#include <linux/module.h>
#define INCLUDE_VERMAGIC
#include <linux/build-salt.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

BUILD_SALT;

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__section(".gnu.linkonce.this_module") = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

#ifdef CONFIG_RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif

static const struct modversion_info ____versions[]
__used __section("__versions") = {
	{ 0x2e712c61, "module_layout" },
	{ 0x6bc3fbc0, "__unregister_chrdev" },
	{ 0x5cc2a511, "hrtimer_forward" },
	{ 0x695bf5e9, "hrtimer_cancel" },
	{ 0xb43f9365, "ktime_get" },
	{ 0x2b131b84, "__register_chrdev" },
	{ 0xb1ad28e0, "__gnu_mcount_nc" },
	{ 0x51a910c0, "arm_copy_to_user" },
	{ 0xec523f88, "hrtimer_start_range_ns" },
	{ 0xf3d0b495, "_raw_spin_unlock_irqrestore" },
	{ 0xc5850110, "printk" },
	{ 0xde55e795, "_raw_spin_lock_irqsave" },
	{ 0x2cfde9a2, "warn_slowpath_fmt" },
	{ 0xa362bf8f, "hrtimer_init" },
};

MODULE_INFO(depends, "");


MODULE_INFO(srcversion, "D9E498B9FDB9F334C36F4E7");
