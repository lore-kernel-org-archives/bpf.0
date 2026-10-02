Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017330C637;
	Fri,  2 Oct 2026 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901791; cv=none; b=ifihutMouF/q6WUpoaZ54ng/rT9FSDHHzBOFG8+X8SEiKzbnR9I1/0vFSOD2w9aBX4EyY+9v3qG3CAKk72punXwRCQ33Vw0SvYMqSDqUmfnTBsQ9zu+WeE713RhtjIf01lMzdLjwZQi+0/Y5Sw40Os/GMLrOzYqkKwbRoaCbXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901791; c=relaxed/simple;
	bh=56ct3Q7eKLjRYBn/VFcDzzJdQBfaNzG4aoQ7ut7W8hk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=URq53Y/mdhWTtJMPSa0L+i9DDqbvlHyf96EPJwXtFB2wxXrCVHzCNOw/NriWuol1X4hC1qfxZeihx/dlDvlysN2GQ6qvtOrxhv6QuwbflgZ+1rmyV3E60tOYeI34Ngqj16hbTZp6CxQXvGD0jO5AcsC9rrrAH2PaWGvGEjP5nlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKUITmYE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKUITmYE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BDB1F000FF;
	Fri,  2 Oct 2026 00:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790901786;
	bh=N8i6gFdY9s2QER20rUU/289DDlfiICXitfqZc9Vxt3E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lKUITmYEb/hyga5arqGCq931G/TV2nkyEJ0fU8OE/wckYarW1+XOHBMDXn92TU6BL
	 +13ai54zmJiOjaG9P/FnXd0bizYsMNNU20Pa8Y/pKyxLdiso8/PyQTmpKDayDI2F1/
	 IQSCVj+KPcNuAU7ujFUn5yZIM/mslI0B2hM6NqeHiLU3f2KYYBc+1vO23t9BKisN6v
	 NS/ulEKkLkZgZ67EmFjEXL4DyZ1hnoTWPTsyyW9MfJ6FM8a4/Am2NBiEHuXG61D1rc
	 9rZCLoI3GDAhNLq2sMQ08jAkoJRVaagvBHR27cVIhhiS/amNGZ0+4cr09aT9GVeTso
	 xWVNizXrDaRvg==
Content-Type: multipart/mixed; boundary="===============2199014445031950111=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1081b7a0f143f29745409a1356f223fd8b196c827e18d46cde7f41716def72c0@mail.kernel.org>
In-Reply-To: <20261001152042.124445-11-gmonaco@redhat.com>
References: <20261001152042.124445-11-gmonaco@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: bot+bpf-ci@kernel.org
To: gmonaco@redhat.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,rostedt@goodmis.org,gmonaco@redhat.com
Cc: alexei.starovoitov@gmail.com,namcao@linutronix.de,wen.yang@linux.dev,tobias.schaffner@siemens.com,vmalik@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 00:43:06 +0000 (UTC)

--===============2199014445031950111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools/rv: Add BPF monitors

TL;DR:
- Possible rv build breakage: requires host kernel BTF, old libbpf/clang may
  lack likely() or -mcpu=v3
- Intentionally broken nohz monitor gets installed, changelog omits this
- O= builds write into source tree; install wildcard evaluated too early

> tools/rv: Add BPF monitors
>
> Add the code for 2 initial BPF monitors, both DA (the only currently
> supported type):
>
> * queue: per-task monitor stating tasks alternate enqueue and dequeue.
> * nohz: per-cpu monitor stating the scheduler tick don't run when
>   stopped and can run only after being resumed.
>
> BPF monitors can include the in-kernel da_monitor.h, which is now
> adapted to share as much common code and conditionally compile what
> needs to be BPF or kernel specific.
>
> Integrate BPF monitor building into main rv Makefile, if all tools are
> available on the system.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

The changelog describes nohz as a monitor for a valid property, but nohz.c
says the opposite:

tools/verification/rv/bpf_monitors/nohz.c:
  /*
   * This monitor is broken on purpose to test errors, sched_tick can run with
   * stopped ticks for one last time (deferred tick reprogram).
   ...
   */

Should the changelog say that nohz is an intentionally broken test monitor?

The new install rule in Makefile.rv copies every bpf_monitors/*.o, so 'rv
list' would show nohz to users as a normal monitor that is known to report
false violations.  A later patch in this series (f5a3c821fa88 "tools/rv: Add
reactors support to BPF monitors") adds a panic reactor, so 'rv mon nohz -r
panic' would panic on a known false positive.

Should nohz be kept out of the installed set or clearly marked as a test
monitor?

Also, the first monitor is called 'queue' in the message but 'tqueue' in the
code (MONITOR_NAME tqueue, tqueue.dot, tqueue.c).

> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 7f0bdfd7cce3..ee1cec73ec85 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h

[ ... ]

> @@ -77,6 +82,9 @@ static struct rv_monitor rv_this;
>  #define da_id_type int
>  #endif
>  
> +#ifdef __BPF__
> +#include "da_monitor_bpf.h"
> +#else
>  static void react(enum states curr_state, enum events event)

Can the BPF build find likely() and unlikely()?

The helpers in da_monitor.h that are now shared with BPF use them, for
example in da_monitor_enabled():

    if (unlikely(!rv_monitoring_on()))
        return 0;

The same applies to da_monitor_handling_event(), da_event() and the
__da_handle_start*_event() helpers, plus the per-task and per-obj helpers in
da_monitor_bpf.h.

Nothing in the BPF include path defines these macros.  They are not in
da_monitor_bpf.h or bpf_atomic.h, and vmlinux.h only has types.
BPF_INCLUDES doesn't point at tools/lib, so <bpf/bpf_helpers.h> comes from
the system libbpf, and libbpf only gained likely()/unlikely() in commit
dafae1ae2ad3 ("libbpf: Add likely/unlikely macros and use them in
selftests").

With libbpf 1.5 or older headers, compiling bpf_monitors/*.c fails with
'call to undeclared function unlikely'.  The libbpf feature test only checks
that libbpf links (bpf_prog_load), so BUILD_BPF_OBJS stays 1 and a plain
'make' of rv breaks.

Could da_monitor_bpf.h provide '#ifndef likely' fallbacks, or could
Makefile.config check the libbpf version before enabling BUILD_BPF_OBJS?

No later patch in the series addresses this.

[ ... ]

> diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
> index 0a8c7a656f7f..bb81593acd71 100644
> --- a/tools/verification/rv/Makefile
> +++ b/tools/verification/rv/Makefile

[ ... ]

> @@ -68,19 +72,51 @@ static: $(RV_IN)
>  	$(eval LDFLAGS += -static)
>  	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RV)-static $(RV_IN) $(EXTLIBS)
>  
> +BPF_DIR		:= bpf_monitors
> +BPF_SOURCES	:= $(wildcard $(BPF_DIR)/*.c)
> +BPF_OBJECTS	:= $(BPF_SOURCES:.c=.o)
> +VMLINUX_H	:= $(BPF_DIR)/vmlinux.h
> +
> +BPF_INCLUDES	:= -I$(srctree)/include/uapi
> +BPF_INCLUDES	+= -I$(srctree)/include
> +BPF_INCLUDES	+= -I$(BPF_DIR)
> +
> +BPF_CFLAGS	:= -g -O2 -target bpf -MMD -MP $(BPF_INCLUDES)
> +BPF_CFLAGS	+= -Wall -Wno-unused-function -Wno-missing-declarations

Do the BPF monitors need -mcpu=v3 here?

The shared da_monitor.h code that is now built for BPF calls try_cmpxchg()
from da_event():

    if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {

bpf_atomic.h implements try_cmpxchg() with __sync_val_compare_and_swap() on
the 32-bit 'unsigned int curr_state' of struct da_monitor.
Documentation/bpf/clang-notes.rst says:

  Clang can generate atomic instructions by default when -mcpu=v3 is
  enabled.  If a lower version for -mcpu is set, the only atomic
  instruction Clang can generate is BPF_ADD *without* BPF_FETCH.

A clang whose default BPF CPU is older than v3 (LLVM before 20 defaulted to
the v1 'generic' CPU) therefore cannot compile nohz.c or tqueue.c.  Both
reach da_event() through da_handle_start_event()/da_handle_event() ->
__da_handle_event_common().

Those clang versions still pass the clang-bpf-co-re feature test, so
BUILD_BPF_OBJS stays 1, 'all: bpf' is added, and a plain 'make' of
tools/verification/rv fails where it succeeded before this patch.

Other in-tree BPF tools pass the flag explicitly, for example
tools/sched_ext/Makefile uses '-O2 -mcpu=v3'.  Could -mcpu=v3 be added to
BPF_CFLAGS?

No later patch in the series changes this.

> +
> +VMLINUX		:= ../../../vmlinux
> +VMLINUX_BTF	?= $(if $(wildcard $(VMLINUX)) , $(VMLINUX), /sys/kernel/btf/vmlinux)
> +
> +$(VMLINUX_H): $(VMLINUX_BTF)
> +	$(QUIET_GEN)$(SYSTEM_BPFTOOL) btf dump file $< format c > $@

Does the default rv build now depend on BTF from either the in-tree vmlinux
or the build host's running kernel, with that BTF also needing to contain
the RV types?

Makefile.config doesn't check either.  The bpftool-btf feature test only
runs 'bpftool btf help' and clang-bpf-co-re only checks the compiler, so
BUILD_BPF_OBJS stays 1 and 'all: bpf' is added whenever the tools are
installed.

Failure cases for 'make -C tools/verification/rv':

- No ../../../vmlinux and no /sys/kernel/btf/vmlinux (for example a chroot
  or container build, or a host kernel without CONFIG_DEBUG_INFO_BTF): make
  stops with "No rule to make target '/sys/kernel/btf/vmlinux', needed by
  'bpf_monitors/vmlinux.h'".

- The BTF source is a kernel without CONFIG_RV: struct rv_monitor, struct
  da_monitor and union rv_task_monitor are missing from vmlinux.h, so
  'static struct rv_monitor rv_this;' in da_monitor.h and the map value
  types in da_monitor_bpf.h fail to compile.

- The in-tree vmlinux was built without BTF: bpftool fails, but '> $@' has
  already created bpf_monitors/vmlinux.h.  There is no .DELETE_ON_ERROR, so
  the empty header stays newer than vmlinux and later make runs keep failing
  until 'make clean'.

Before this patch, building rv did not depend on the build host's kernel at
all.  This also seems to contradict the commit message ("if all tools are
available on the system") and the Makefile.config comment that RV can run
without the monitors.

Should the BTF input (and possibly the RV types in it) be checked, falling
back to BUILD_BPF_OBJS=0 the way the missing clang/bpftool cases already
are?

No later patch in the series addresses this.

> +
> +$(BPF_DIR)/%.o: $(BPF_DIR)/%.c $(VMLINUX_H)
> +	$(QUIET_CLANG)$(CLANG) $(BPF_CFLAGS) -c $< -o $@
> +	$(Q)$(LLVM_STRIP) -g $@
> +	$(Q)$(LLVM_OBJCOPY) --remove-section=.rel.rodata $@

Should these rules honour OUTPUT like the rest of this Makefile does (RV :=
$(OUTPUT)rv)?

With 'make O=/some/dir' or 'make -C tools O=... rv', the rv binary and its
objects go to $(OUTPUT), but bpf_monitors/vmlinux.h, *.o and *.d are still
written into the source tree.  The build now writes into srctree and fails
on a read-only source tree.

The objects also end up where rv cannot find them.  bpf_fill_base_paths() in
src/bpf_monitor.c overwrites the "." search entry with
dirname(/proc/self/exe), i.e. $(OUTPUT), so rv looks for
$(OUTPUT)/bpf_monitors, which doesn't exist.  Freshly built monitors are not
found in an O= build until they are installed.

Could the BPF objects and vmlinux.h be placed under $(OUTPUT)bpf_monitors/,
with the install rule updated to match?

[ ... ]

> diff --git a/tools/verification/rv/Makefile.rv b/tools/verification/rv/Makefile.rv
> index 2497fb96c83d..418748bc3aa1 100644
> --- a/tools/verification/rv/Makefile.rv
> +++ b/tools/verification/rv/Makefile.rv

[ ... ]

> @@ -33,12 +33,17 @@ INSTALL		:= install
[ ... ]
>  install: doc_install
>  	$(Q)$(MKDIR) -p $(DESTDIR)$(BINDIR)
>  	$(call QUIET_INSTALL,rv)$(INSTALL) $(OUTPUT)rv -m 755 $(DESTDIR)$(BINDIR)
>  	$(Q)@$(STRIP) $(DESTDIR)$(BINDIR)/rv
> +ifneq ($(wildcard bpf_monitors/*.o),)
> +	$(Q)$(MKDIR) -p $(DESTDIR)$(BPF_MON_DIR)
> +	$(call QUIET_INSTALL,bpf_monitors)$(INSTALL) bpf_monitors/*.o -m 644 $(DESTDIR)$(BPF_MON_DIR)
> +endif

Is this ifneq/$(wildcard) check evaluated too early?

It runs when Makefile.rv is parsed (it is included from Makefile), not when
the install recipe runs.  In a single invocation such as 'make all install'
(or 'make bpf install') on a clean tree, the wildcard is empty at parse
time, so the BPF install lines are dropped from the recipe.  The rv binary
is installed but the monitors that were just built are silently skipped.

Would a shell-level test inside the recipe, for example 'if ls
bpf_monitors/*.o >/dev/null 2>&1; then ...', be more robust?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36944413541
--===============2199014445031950111==--
