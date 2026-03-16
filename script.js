/* ═══════════════════════════════════════
   SURF SHOP DB SHOWCASE — SCRIPT
   ═══════════════════════════════════════ */

document.addEventListener('DOMContentLoaded', () => {

    // ─── Category Filter ───
    const pills = document.querySelectorAll('.nav-pill');
    const cards = document.querySelectorAll('.query-card');
    const catHeaders = document.querySelectorAll('.category-header');

    pills.forEach(pill => {
        pill.addEventListener('click', () => {
            pills.forEach(p => p.classList.remove('active'));
            pill.classList.add('active');

            const cat = pill.dataset.cat;

            cards.forEach((card, i) => {
                if (cat === 'all' || card.dataset.cat === cat) {
                    card.classList.remove('hidden');
                    card.style.animationDelay = `${i * 40}ms`;
                } else {
                    card.classList.add('hidden');
                }
            });

            catHeaders.forEach(header => {
                if (cat === 'all' || header.dataset.cat === cat) {
                    header.style.display = '';
                } else {
                    header.style.display = 'none';
                }
            });
        });
    });

    // ─── Scroll reveal animation ───
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.08, rootMargin: '0px 0px -40px 0px' });

    cards.forEach(card => observer.observe(card));

    // ─── Collapsible query bodies ───
    document.querySelectorAll('.query-header').forEach(header => {
        header.addEventListener('click', () => {
            const body = header.nextElementSibling;
            const card = header.parentElement;

            if (body.style.display === 'none') {
                body.style.display = '';
                card.classList.remove('collapsed');
            } else {
                body.style.display = 'none';
                card.classList.add('collapsed');
            }
        });
    });

    // ─── Smooth scroll for CTA ───
    document.querySelector('.cta-btn')?.addEventListener('click', (e) => {
        e.preventDefault();
        document.querySelector('#queries')?.scrollIntoView({ behavior: 'smooth' });
    });

    // ─── SQL File Tabs ───
    const sqlTabs = document.querySelectorAll('.sql-tab');
    const sqlPanels = document.querySelectorAll('.sql-file-panel');

    sqlTabs.forEach(tab => {
        tab.addEventListener('click', () => {
            const target = tab.dataset.file;
            sqlTabs.forEach(t => t.classList.remove('active'));
            sqlPanels.forEach(p => p.classList.remove('active'));
            tab.classList.add('active');
            document.getElementById(target)?.classList.add('active');
        });
    });

    // ─── Copy Buttons ───
    document.querySelectorAll('.copy-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const target = btn.dataset.target;
            const codeEl = document.querySelector(`#code-${target} code`);
            if (!codeEl) return;

            navigator.clipboard.writeText(codeEl.textContent).then(() => {
                btn.textContent = '✓ Copied!';
                btn.classList.add('copied');
                setTimeout(() => { btn.textContent = 'Copy'; btn.classList.remove('copied'); }, 2000);
            }).catch(() => {
                const sel = window.getSelection();
                const range = document.createRange();
                range.selectNodeContents(codeEl);
                sel.removeAllRanges();
                sel.addRange(range);
                document.execCommand('copy');
                sel.removeAllRanges();
                btn.textContent = '✓ Copied!';
                btn.classList.add('copied');
                setTimeout(() => { btn.textContent = 'Copy'; btn.classList.remove('copied'); }, 2000);
            });
        });
    });

});
