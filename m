Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108550C283;
	Fri, 25 Sep 2026 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379300; cv=none; b=qaOeBbw2qJ1mwkEzRc81D9mjZU2ywPJ8FbtwDk7GHeC/q1K9l3HkfXAYsvz2+O/w/KKGQlcJn+W9V3SFaFr1EZGQemy5yAx8lkgsNfjWArTx/dcYECfooRoEhF8SL8JOxrFmVgz9zzZWL/WyW91oCNNk1U+AB3oWQQM6/TY7dPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379300; c=relaxed/simple;
	bh=BPQmaMqcgQsP7ysN48sHoaIZOEBcl73Zdf6juYzfdn4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gDV/+Wp+Fzj4ApU/5awUIu/0O8ZLNoVkULUqIeskJHkCXoCeYvpZp28m6SQ7Lnc2kh9L/TbrgClXH9m9UgcmP2lnLkmmUHsf7AM3dK35afznv2U8zP/1Pvb5NSjfgqc/CYH4nyF0u7dZb5OOyoPdqwkvllSvRDZIAwcF55mHU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF27ZLSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF27ZLSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42C61F000FF;
	Fri, 25 Sep 2026 23:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379288;
	bh=0kwg2i5VQoD2f3FjSWL6NQm6vE1Jm8y0B25JJIHy7zE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LF27ZLSsLCpJ0SJpknKJxGrDPsaJnONUiffi6BM/HkdC+lvlYLhUNDgiJszHTEP/W
	 QeURNV7l/p7TEPr5YIz08H2NEHlNGXJg/o+15E8k2AkCV5/gvSM+lYFXXpE4nwvWt5
	 MiM6vCLaMSUJbwb6t2xQE33kFY0v/nbBjKnIifp17GQKglGPiq3AsvWgqi4XzFjVbq
	 MkgaIq/WMW4BIqwKfi6gL19nkLY65Rqudun/S0O5G5nhhZ1unyBXHtADWBiznfwIhF
	 IAx/2u/GZGB8l1kmn8mitUzhXhSPM7hmc/PBSO7feuk2e7avwnhntaP7GdmBJCwHv1
	 3SJ89JO82QeGg==
Content-Type: multipart/mixed; boundary="===============0784112096318364826=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6e565a3c5689de1d5ba05904e3d7f477373bca8e10be75fea4b6adc048ab6ac4@mail.kernel.org>
In-Reply-To: <20260925224229.1850-10-wanjay@amazon.com>
References: <20260925224229.1850-10-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next v3 9/9] kbuild, bpf: allow building the vmlinux BTF as a module
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,mcgrof@kernel.org,petr.pavlu@suse.com,samitolvanen@google.com,linux-modules@vger.kernel.org,ojeda@kernel.org,rust-for-linux@vger.kernel.org,arnd@arndb.de,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 23:34:46 +0000 (UTC)

--===============0784112096318364826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Make CONFIG_DEBUG_INFO_BTF a tristate.  With =m the vmlinux BTF is not
> part of the kernel image: it is carried by a new module, btf_vmlinux, and
> loaded the first time something needs it.  Nothing that works with =y
> stops working; the 5.4 MiB of read-only data (distribution config) is
> simply not there on systems where nothing uses it.

The statement "Nothing that works with =y stops working" appears to have
exceptions. The patch itself adds this to kernel/bpf/preload/Kconfig:

>     depends on DEBUG_INFO_BTF!=m

This makes BPF_PRELOAD no longer selectable with =m, and a later paragraph
acknowledges this ("CONFIG_BPF_PRELOAD is not selectable with =m").

Additionally, BPF programs that need kernel types before the root file
system is mounted work with =y but fail with =m unless btf_vmlinux.ko is
in the initramfs, which the changelog mentions later.

Could the opening sentence be reworded to acknowledge these exceptions,
for example: "Apart from BPF_PRELOAD and early-boot users without
btf_vmlinux.ko in the initramfs, nothing that works with =y stops
working"?

> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 29de1222c3e7..1bd0d35cdb05 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -1276,6 +1276,41 @@ format.::
>              .long   58
>              .long   8206                    # Line 8 Col 14
>
> +6.1 Kernel BTF
> +--------------
> +
> +With CONFIG_DEBUG_INFO_BTF=y the BTF of the kernel is generated at link time
> +from its DWARF and placed in the .BTF section of vmlinux, which is read-only
> +data of the kernel image. It is available as /sys/kernel/btf/vmlinux and, if
> +CONFIG_DEBUG_INFO_BTF_MODULES is set, module BTF is generated as split BTF
> +against it and available as /sys/kernel/btf/<module>.
> +
> +With CONFIG_DEBUG_INFO_BTF=m the same BTF is generated, but it is not part of
> +the kernel image or of the vmlinux ELF file (vmlinux.unstripped in the build
> +tree keeps it, for module BTF generation). It is delivered by the
> +btf_vmlinux module, which the kernel loads on demand the first time the BTF is
> +needed: when /sys/kernel/btf/vmlinux is read or mmap()ed, when kernel BTF
> +objects are enumerated (BPF_BTF_GET_NEXT_ID), or when a BPF program needs
> +kernel type information (an attach_btf_id, a kfunc call, a ksym, a map pointer
> +or a helper that takes or returns a kernel BTF pointer). Until then no memory
> +is used for it, and afterwards nothing differs from =y. In particular:

The new section lists when the btf_vmlinux module is loaded, and mentions
that bpf_snprintf_btf() and bpf_seq_printf_btf() handle the missing-BTF
case because they run in program context. The ftrace argument printer is
another caller that can reach the loader, and it can run with interrupts
disabled.

With CONFIG_DEBUG_INFO_BTF=m, CONFIG_FUNCTION_TRACE_ARGS is still enabled
because it depends on PROBE_EVENTS_BTF_ARGS, which is a bool that treats
the m dependency as y. The func-args and funcgraph-args trace options
print arguments through this call chain:

kernel/trace/trace_output.c:print_function_args():
  t = btf_find_func_proto(name, &btf);
kernel/trace/trace_btf.c:btf_find_func_proto():
  id = bpf_find_btf_id(func_name, BTF_KIND_FUNC, btf_p);
kernel/bpf/btf.c:bpf_find_btf_id():
  btf = bpf_get_btf_vmlinux();
kernel/bpf/verifier.c:bpf_get_btf_vmlinux():
  if (!btf_vmlinux_data(&size, true))
kernel/bpf/btf.c:btf_vmlinux_data():
  request_module("btf_vmlinux");

This is also reached from ftrace_dump() in the oops/panic notifier and
from sysrq-z:

kernel/trace/trace.c:ftrace_dump_one():
  local_irq_save(flags);
  ...
  ret = print_trace_line(&iter);  -> ... -> print_function_args()

request_module() sleeps: it calls down_timeout() and
call_modprobe(..., UMH_WAIT_PROC), which waits for a usermode helper.
If the BTF has not been parsed yet, bpf_get_btf_vmlinux() takes
mutex_lock(&btf_vmlinux_lock) with GFP_KERNEL allocations. Either way,
this path sleeps with interrupts disabled. In panic, the other CPUs have
been stopped, so the modprobe wait may hang and block the dump or any
reboot after it.

With =y, late_initcall kfunc registrations parse the vmlinux BTF during
boot, so this path only does the lockless acquire load. With =m,
btf_defer_reg() queues those registrations and does not load the BTF,
so it can stay NULL until the trace printer runs.

Can this be triggered with CONFIG_DEBUG_INFO_BTF=m, func-args or
funcgraph-args set, ftrace_dump_on_oops (or sysrq-z), and no BPF user
of the vmlinux BTF since boot?

One option is to make print_function_args() use bpf_peek_btf_vmlinux(),
as bpf_btf_printf_prepare() already does. The doc trigger list also
leaves out other non-program loaders: reading the trace file with
func-args, kprobe/fprobe events with BTF arguments, struct_ops map
creation, bpffs delegate_* options and netfilter ctx access.

> +  * /sys/kernel/btf/vmlinux exists from boot with its final size.
> +  * Modules loaded before the vmlinux BTF are exposed in /sys/kernel/btf right
> +    away, their BTF is parsed and gets a BTF id once the vmlinux BTF is
> +    loaded, together with their kfunc and struct_ops registrations.
> +  * kfunc, dtor kfunc and struct_ops registrations of the kernel itself are
> +    applied before the BTF becomes visible.
> +  * The kernel only accepts the BTF it was built with: the size and SHA-256 of
> +    the BTF are linked into the kernel and checked against the module.
> +  * Once loaded the BTF stays; the module cannot be unloaded.
> +
> +If the module is not available (not installed, or the root file system is not
> +mounted yet), the kernel behaves as one built without BTF and retries next
> +time. CONFIG_BPF_PRELOAD is not available with =m: its iterators attach through
> +the vmlinux BTF, so mounting bpffs would load it. bpf_snprintf_btf() and bpf_seq_printf_btf() only use the BTF if it has
> +already been parsed, as they run in program context.

[ ... ]

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 134b15a44625..418025c5e657 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -396,7 +396,7 @@ config DEBUG_INFO_SPLIT
>  	  Incompatible with older versions of ccache.
>
>  config DEBUG_INFO_BTF
> -	bool "Generate BTF type information"
> +	tristate "Generate BTF type information"
>  	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>  	depends on BPF_SYSCALL

Does making DEBUG_INFO_BTF selectable as =m keep PROBE_EVENTS_BTF_ARGS
and FUNCTION_TRACE_ARGS enabled? Since bool dependents treat m as y, the
tracing output path would call the vmlinux BTF lookup, and under =m that
lookup can sleep.

The chain from the function_graph printers goes:
print_fn_trace() -> print_function_args() -> btf_find_func_proto() ->
bpf_find_btf_id() -> bpf_get_btf_vmlinux() ->
btf_vmlinux_data(&size, true) -> request_module("btf_vmlinux").

request_module() calls down_timeout(), kmalloc(GFP_KERNEL) in
call_modprobe(), and waits for modprobe with UMH_WAIT_PROC. These
printers run from ftrace_dump_one(), which does local_irq_save(flags)
before looping on print_trace_line(). ftrace_dump_one() is reached from
ftrace_dump_on_oops/panic, sysrq-z, <func>:dump function probes, kdb
ftdump and RCU stall dumps.

If the func-args or funcgraph-args option is on and nothing has loaded
the BTF yet, the dump hits 'sleeping function called from invalid
context' and schedules with IRQs disabled. In the panic/oops path the
other CPUs are stopped and usermode helpers cannot run, so the dump can
hang.

With =y the BTF is parsed at boot and bpf_get_btf_vmlinux() returns from
its fast path, so this path could not sleep before this change. Earlier
in the series, a commit added bpf_peek_btf_vmlinux() for
bpf_snprintf_btf()/bpf_seq_printf_btf() because they 'cannot afford a
fetch that may sleep', but the tracing output path was not converted.

Should btf_find_func_proto() use a non-loading lookup
(bpf_peek_btf_vmlinux()) or skip the lookup when !preemptible(), or
should PROBE_EVENTS_BTF_ARGS/FUNCTION_TRACE_ARGS depend on
DEBUG_INFO_BTF=y?

> @@ -408,6 +408,26 @@ config DEBUG_INFO_BTF
>  	  Turning this on requires pahole v1.22 or later, which will convert
>  	  DWARF type info into equivalent deduplicated BTF type info.
>
> +	  If built as a module (=m), the vmlinux BTF is not part of the
> +	  kernel image.  It is carried by the btf_vmlinux module, which is
> +	  loaded on demand the first time the BTF is needed: when a BPF
> +	  program requires kernel type information, or when
> +	  /sys/kernel/btf/vmlinux is opened.  Until then, no memory is
> +	  spent on it.  The vmlinux ELF file does not carry the BTF
> +	  either; module BTF is generated against vmlinux.unstripped, and
> +	  tools that read the BTF from a file can use that or
> +	  /sys/kernel/btf/vmlinux.

The help text says the btf_vmlinux module is loaded when
/sys/kernel/btf/vmlinux is opened. Does opening the file actually load
the module?

Looking at kernel/bpf/sysfs_btf.c, the file is a bin_attribute, and
struct bin_attribute has no open callback. The BTF is loaded only from
btf_sysfs_vmlinux_read() and btf_sysfs_vmlinux_mmap(), and the comment
there says 'the first read() or mmap() loads the BTF'. stat() and open()
without a read leave the module unloaded, which the commit message's
btf_sysfs selftest note about stat() relies on.

Should this say 'first read or mapped' instead of 'opened'? The commit
message has the same wording ('opening /sys/kernel/btf/vmlinux ... each
load it').

> +	  Module BTF (DEBUG_INFO_BTF_MODULES) is kept when a module loads,
> +	  as with =y, and registered once the vmlinux BTF is available; the
> +	  saving is the vmlinux BTF only.
> +
> +	  If BPF programs that use kernel types run before the root file
> +	  system is mounted, put btf_vmlinux.ko into the initramfs: until
> +	  the module can be loaded, such programs fail as on a kernel
> +	  without BTF.  Not compatible with BPF_PRELOAD, whose iterators
> +	  would load the BTF at every bpffs mount.

Once DEBUG_INFO_BTF can be =m, does 'make localmodconfig' silently turn
it off?

scripts/kconfig/streamline_config.pl maps loaded modules to configs only
through obj-$(CONFIG_X) lines. Any =m config it cannot tie to a loaded
module is written out as '# CONFIG_X is not set'. The only rule for the
carrier module is kernel/bpf/Makefile 'ifeq ($(CONFIG_DEBUG_INFO_BTF),m)'
/ 'obj-m += btf_vmlinux.o', which the script cannot map, and btf_vmlinux
is usually not loaded when lsmod is captured anyway.

So a distribution config with CONFIG_DEBUG_INFO_BTF=m loses
DEBUG_INFO_BTF under localmodconfig. olddefconfig then also drops
DEBUG_INFO_BTF_MODULES, SCHED_CLASS_EXT, NET_SCH_BPF, IO_URING_BPF_OPS,
BINFMT_MISC_BPF and PROBE_EVENTS_BTF_ARGS. With =y these options were
kept, because the script leaves built-in options alone. The only
workaround is LMC_KEEP.

Could the Makefile use an obj-$(CONFIG_DEBUG_INFO_BTF)-style rule that
streamline_config can map, or could streamline_config preserve this
symbol?

[ ... ]

> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 01a37ec872b9..6a0958cf0e6f 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -38,20 +38,34 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>  		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
>  		-T $(objtree)/scripts/module.lds -o $@ $(filter %.o, $^)
>
> +# The ELF file with the vmlinux BTF: with CONFIG_DEBUG_INFO_BTF=m the BTF is
> +# stripped from vmlinux (scripts/Makefile.vmlinux), vmlinux.unstripped keeps it.
> +btf-vmlinux := $(objtree)/vmlinux$(if $(filter m,$(CONFIG_DEBUG_INFO_BTF)),.unstripped)
> +
>  quiet_cmd_btf_ko = BTF [M] $@
>        cmd_btf_ko = 							\
> -	if [ ! -f $(objtree)/vmlinux ]; then				\
> +	if [ ! -f $(btf-vmlinux) ]; then				\
>  		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
>  	else	\
> -		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
> +		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(btf-vmlinux) $@; \
>  	fi;

With CONFIG_DEBUG_INFO_BTF=m, external modules (M=) now only get BTF if
vmlinux.unstripped exists. The in-tree packaging still ships only vmlinux
for this purpose.

scripts/package/PKGBUILD's _package-debug does 'install -Dt
"${debugdir}" -m644 vmlinux' and 'ln -sr "${debugdir}/vmlinux"
"${builddir}/vmlinux"' so that modules built against
/usr/lib/modules/$KERNELRELEASE/build get split BTF. With =y that works.
With =m, Makefile.vmlinux strips .BTF from that vmlinux, and cmd_btf_ko
tests for build/vmlinux.unstripped, which nothing installs.

So every DKMS/out-of-tree module built against a pacman-pkg kernel with
=m (and DEBUG_INFO_BTF_MODULES, which defaults to y) is built without
.BTF, and the build still succeeds. The only sign is the stderr line
"Skipping BTF generation for foo.ko due to unavailability of vmlinux",
which is misleading because build/vmlinux is present; the missing file is
vmlinux.unstripped.

At runtime those modules have no BTF: fentry/fexit and BTF-typed tracing
of their functions are unavailable, and register_btf_kfunc_id_set() from
such a module falls into check_btf_kconfigs() ("missing module BTF,
cannot register kfunc"). This contradicts the changelog's "Nothing that
works with =y stops working" for the external-module flow the tree itself
packages.

Should scripts/package/PKGBUILD (and any other shipped build-tree layout)
provide vmlinux.unstripped when CONFIG_DEBUG_INFO_BTF=m, or should
cmd_btf_ko use another base source? At minimum, the error message should
name $(btf-vmlinux) instead of saying "vmlinux".

>
> -# Re-generate module BTFs if either module's .ko or vmlinux changed
> -%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
> -	+$(call if_changed,ld_ko_o)
> +# Modules that get a .BTF section: all of them with CONFIG_DEBUG_INFO_BTF_MODULES,
> +# otherwise only the vmlinux BTF carrier module with CONFIG_DEBUG_INFO_BTF=m.
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> -	+$(if $(newer-prereqs),$(call cmd,btf_ko))
> +btf-modules := $(modules:%.o=%.ko)
> +else ifeq ($(CONFIG_DEBUG_INFO_BTF),m)
> +btf-modules := $(filter %/btf_vmlinux.ko,$(modules:%.o=%.ko))
> +# Only the carrier depends on vmlinux, not every module
> +ifdef KBUILD_BUILTIN
> +$(btf-modules): $(btf-vmlinux)
> +endif
>  endif
> +
> +# Re-generate module BTFs if either module's .ko or vmlinux changed
> +%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(btf-vmlinux)) FORCE
> +	+$(call if_changed,ld_ko_o)
> +	+$(if $(and $(filter $@,$(btf-modules)),$(newer-prereqs)),$(call cmd,btf_ko))
>  	+$(call cmd,check_tracepoint)
>
>  targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o

[ ... ]

> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index fcae1e432d9a..557db1ee1f3b 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -86,6 +86,11 @@ remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel*' '!.rel*.dyn'
>  # for compatibility with binutils < 2.32
>  # https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=c12d9fa2afe7abcbe407a00e15719e1a1350c2a7
>  remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel.*'
> +# With CONFIG_DEBUG_INFO_BTF=m the btf_vmlinux module carries the vmlinux BTF;
> +# only vmlinux.unstripped keeps it, for module BTF generation.
> +ifeq ($(CONFIG_DEBUG_INFO_BTF),m)
> +remove-section-y += .BTF
> +endif

With CONFIG_DEBUG_INFO_BTF=m this strips .BTF from the vmlinux ELF file,
but the in-tree consumers that read the vmlinux BTF from that file were
not updated. Only Makefile.modfinal was switched to vmlinux.unstripped.

The tools pick their BTF source like this (tools/bpf/bpftool/Makefile):

  VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)                   \
                       $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux) \
                       ../../../vmlinux                          \
                       /sys/kernel/btf/vmlinux                   \
                       /boot/vmlinux-$(shell uname -r)
  VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
  ...
  $(OUTPUT)vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL_BOOTSTRAP)
      $(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) btf dump file $< format c > $@

$(wildcard) only checks that a file exists. In a tree where an =m kernel
was built, it selects the build-tree vmlinux, which now has no .BTF
section, and never reaches /sys/kernel/btf/vmlinux. btf_parse_elf() in
tools/lib/bpf/btf.c then fails:

  if (!secs.btf_data) {
      pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
      err = -ENODATA;

do_dump() in bpftool reports "failed to load BTF from ...: No data
available" and the vmlinux.h rule fails. The same
VMLINUX_BTF_PATHS/firstword/wildcard logic followed by 'bpftool btf dump
file $(VMLINUX_BTF) format c' appears in
tools/testing/selftests/bpf/Makefile, tools/sched_ext/Makefile,
tools/testing/selftests/sched_ext/Makefile, samples/bpf/Makefile,
samples/hid/Makefile, drivers/hid/bpf/progs/Makefile and
tools/testing/selftests/hid/Makefile.

So after an =m kernel build, the default builds of bpftool (with
skeletons), the BPF selftests and the sched_ext tools fail unless
VMLINUX_BTF is overridden. With =y all of these work. This contradicts
the changelog's "Nothing that works with =y stops working". The Kconfig
help says tools "can use that [vmlinux.unstripped] or
/sys/kernel/btf/vmlinux", but none of the in-tree tools do so by default.
No commit in the series touches tools/.

In-tree packaging has a related gap. scripts/package/PKGBUILD
_package-debug installs vmlinux and links it as build/vmlinux. With =y,
that is what Makefile.modfinal needs to generate BTF for external
modules. With =m, Makefile.modfinal looks for vmlinux.unstripped, which
is not packaged, and the packaged vmlinux no longer has .BTF. External
module BTF generation against those packages is therefore skipped. The
builddeb and kernel.spec debug vmlinux copies also no longer carry BTF.

Should VMLINUX_BTF_PATHS list vmlinux.unstripped before vmlinux, or
should the vmlinux ELF file keep the non-loadable .BTF?

>
>  remove-symbols := -w --strip-unneeded-symbol='__mod_device_table__*'
>
> @@ -93,7 +98,7 @@ quiet_cmd_strip_relocs = STRIPREL
>        cmd_strip_relocs = $(OBJCOPY) $(foreach x,$(remove-section-y),--remove-section=$(x))	\
>  			      --set-section-flags .BTF=noload		\
>  			      $(remove-symbols)				\
> -			      -o $@ $<
> +			      -o $@ $< $(if $(filter .BTF,$(remove-section-y))&& [ -n "$(remove-section-y)" ])
>
>  vmlinux: vmlinux.unstripped $(and $(CONFIG_DEBUG_INFO_BTF),$(RESOLVE_BTFIDS)) FORCE
>  	$(call if_changed,strip_relocs)

[ ... ]

> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> index 8ca96eb10a69..d808d0006d32 100755
> --- a/scripts/gen-btf.sh
> +++ b/scripts/gen-btf.sh

[ ... ]

> @@ -191,6 +251,35 @@ if [ -n "${BTF_BASE}" ]; then
>  	BTFGEN_MODE="module"
>  fi
>
> +if [ -n "${PLACEHOLDER}" ]; then
> +	btf_data=${ELF_FILE}.btf.o
> +	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
> +	dd if=/dev/zero of=${ELF_FILE}.BTF.meta bs=36 count=1 2>/dev/null
> +	${OBJCOPY} --add-section .BTF.meta=${ELF_FILE}.BTF.meta \
> +		--set-section-flags .BTF.meta=alloc,readonly ${btf_data}
> +	${OBJCOPY} --only-section=.BTF.meta --strip-all ${btf_data}
> +	exit 0
> +fi
> +
> +# CONFIG_DEBUG_INFO_BTF=m: the btf_vmlinux module carries the vmlinux BTF
> +# itself.  Its own types are of no interest, so instead of generating split
> +# BTF for it, copy the (non-loadable) .BTF section of --btf_base
> +# (vmlinux.unstripped) into the module.
> +# The kernel recognizes the module by name and treats its .BTF as base BTF.
> +case "${BTFGEN_MODE}:${ELF_FILE}" in
> +module:*/btf_vmlinux.ko)
> +	if is_module CONFIG_DEBUG_INFO_BTF; then
> +		# -O binary only emits allocatable sections; make .BTF one for
> +		# the extraction.  ${BTF_BASE} itself is not modified.
> +		${OBJCOPY} -O binary --only-section=.BTF			\
> +			--set-section-flags .BTF=alloc,load,readonly	\
> +			"${BTF_BASE}" "${ELF_FILE}.BTF"
> +		${OBJCOPY} --add-section .BTF="${ELF_FILE}.BTF" "${ELF_FILE}"
> +		exit 0
> +	fi
> +	;;
> +esac

The carrier module is recognized only when ELF_FILE contains a '/' before
btf_vmlinux.ko. That holds for normal and O= builds (ELF_FILE is
kernel/bpf/btf_vmlinux.ko). Does it hold for 'make M=kernel/bpf'?

Since the M= working-directory change, the top Makefile changes into the
module directory. scripts/Makefile.build then skips the $(obj)/ prefix
when obj is '.', so modules.order lists 'btf_vmlinux.o' and
Makefile.modfinal passes $@ = 'btf_vmlinux.ko'. 'module:btf_vmlinux.ko'
does not match 'module:*/btf_vmlinux.ko', so gen-btf.sh goes on to
gen_btf_data/embed_btf_data.

With CONFIG_DEBUG_INFO_BTF_MODULES=y the carrier gets its own split BTF
(plus a distilled .BTF.base, because KBUILD_EXTMOD adds --distill_base)
instead of a copy of the vmlinux BTF. Without BTF_MODULES,
Makefile.modfinal's matching '$(filter %/btf_vmlinux.ko,...)' also
misses, so the carrier gets no .BTF at all.

In both cases btf_vmlinux_module_coming() fails its check 'if
(mod->btf_data_size != btf_vmlinux_meta.size) { pr_err(...); return
-EINVAL; }', btf_module_notify() returns
notifier_from_errno(-EINVAL), and prepare_coming_module() makes the
module load fail.

After 'make M=kernel/bpf modules_install' the broken carrier goes to
$(MODLIB)/updates (Makefile.modinst: 'INSTALL_MOD_DIR ?= updates'), which
depmod searches ahead of kernel/ by default. request_module("btf_vmlinux")
from btf_vmlinux_data() then keeps loading the broken copy, and the
vmlinux BTF stays unavailable until that file is removed.

Could the match here (and the same in the Makefile.modfinal filter) cover
the bare name as well, e.g. 'module:btf_vmlinux.ko|module:*/btf_vmlinux.ko)'?

>
>  gen_btf_data
>
>  case "${BTFGEN_MODE}" in

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36198628965
--===============0784112096318364826==--
