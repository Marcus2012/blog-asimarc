/**
 * ASIMARC Custom Ghost Theme JavaScript Logic
 */
document.addEventListener('DOMContentLoaded', () => {
    // 1. Mobile Navigation Menu Toggle
    const mobileMenuBtn = document.getElementById('mobile-menu-toggle');
    const siteNav = document.getElementById('site-nav');

    if (mobileMenuBtn && siteNav) {
        mobileMenuBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            mobileMenuBtn.classList.toggle('active');
            siteNav.classList.toggle('active');
        });

        // Cerrar menú al hacer click afuera (Click outside / tap outside)
        document.addEventListener('click', (e) => {
            if (!siteNav.contains(e.target) && !mobileMenuBtn.contains(e.target) && siteNav.classList.contains('active')) {
                mobileMenuBtn.classList.remove('active');
                siteNav.classList.remove('active');
            }
        });

        // Cerrar menú al navegar por un enlace
        siteNav.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', () => {
                mobileMenuBtn.classList.remove('active');
                siteNav.classList.remove('active');
            });
        });
    }

    // 2. Header Scroll Glassmorphism Effect
    const siteHeader = document.getElementById('site-header');
    if (siteHeader) {
        window.addEventListener('scroll', () => {
            if (window.scrollY > 20) {
                siteHeader.classList.add('scrolled');
            } else {
                siteHeader.classList.remove('scrolled');
            }
        }, { passive: true });
    }

    // 3. Keyboard Shortcut for Ghost Search (Cmd + K or Ctrl + K)
    document.addEventListener('keydown', (e) => {
        if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === 'k') {
            e.preventDefault();
            const searchTrigger = document.querySelector('[data-ghost-search]');
            if (searchTrigger) {
                searchTrigger.click();
            }
        }
    });

    // 4. Highlight Active Category Pill based on URL
    const currentPath = window.location.pathname;
    const categoryPills = document.querySelectorAll('.category-pill');

    if (categoryPills.length > 0) {
        categoryPills.forEach(pill => {
            const href = pill.getAttribute('href');
            if (href && (href.endsWith(currentPath) || currentPath.includes(href.replace(window.location.origin, '')))) {
                categoryPills.forEach(p => p.classList.remove('active'));
                pill.classList.add('active');
            }
        });
    }
});
