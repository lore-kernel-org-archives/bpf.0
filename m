Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400CD306D2A;
	Fri,  2 Oct 2026 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901791; cv=none; b=ZzdYrp0RQJWqSwtqygnYBDUyKT214g4tbN5mW4bA8ZTLXBSdKBTjW3aHkzL1iZjo6hNE3IOMiH5GD/pzz6n8ldRBxA+hKmEHQKaT7HNdNfOrW9Iwz2MehEAKVCSctGqK3BOkF7UxyliIXhXcTg0dg+P89aYO8o7AJmnQMhGjX1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901791; c=relaxed/simple;
	bh=Zzarz2+J06R3tRQ18dX9spCmBpmCgCv6+ozXcSnW9yU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EksJPNJdLyph9ptb1PUbpPY7VpbjEg82yDp94JLfr0BaTtKz1XlaJof0gJbYhK73LINtS+aCokyLFxTAhZh2/ssrX2WTt3YWrTOjqnD8D5zouzOMtYvDvGwajdGMmyiX/vjhx/h9LrRgpTrmC8RGZM+6ew2xe7vnDdKKE3Q6ZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkbxezJC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkbxezJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB781F00893;
	Fri,  2 Oct 2026 00:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790901788;
	bh=Db/GvDfWV4d/n3gS49SHS0KXHc9QE9FP7jSdaFyKQLc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BkbxezJCqqO1g2VuKyRaKJF3LOEyO5TkxD4fbw6dUhX5fAbrF6aHQuTLKia6X6Kt0
	 NMIUIam0emJ29jh9pzizx9U+4Nrzv7SKs388tW4HNaSy6OL36Jdscgwx2DFgfyP+0y
	 4/IU0Z3w8rZwGfZGI44Ve5uDk+NX1X43708w7IL4DrtA/QLmW767XzqoYt6mq9soSh
	 ltqmovQtDHOZIylY9g73N4bt7YRIMQ4/P/vgTL7YYygAhYKdWp3cNTreVvpTvyVici
	 uBu/FSkdKBNQOvItl10IuMFt4RHMIQ4d03GYMI6gHtbH1Nm3QJYjpKX6idUs6BmowA
	 PGT9Nw5JZWXlg==
Content-Type: multipart/mixed; boundary="===============5085887908721438195=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9be59624464448286a0b96d7f73e4b98182eec73abc8ac1ba66fe5b0df977f53@mail.kernel.org>
In-Reply-To: <20261001152042.124445-13-gmonaco@redhat.com>
References: <20261001152042.124445-13-gmonaco@redhat.com>
Subject: Re: [PATCH v2 12/15] tools/rv: Add reactors support to BPF monitors
From: bot+bpf-ci@kernel.org
To: gmonaco@redhat.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,rostedt@goodmis.org,gmonaco@redhat.com
Cc: alexei.starovoitov@gmail.com,namcao@linutronix.de,wen.yang@linux.dev,tobias.schaffner@siemens.com,vmalik@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 00:43:08 +0000 (UTC)

--===============5085887908721438195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools/rv: Add reactors support to BPF monitors

TL;DR:
- bpf_reactors install dir variable clashes, so make install may fail or
  misplace reactors
- void global bpf_rv_react() may break monitor loading on older kernels
- bpf_linker__new_fd() may break builds on libbpf before 1.6
- unused DESCRIPTION nit

> diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
> index bb81593acd71..44b0e3af1488 100644
> --- a/tools/verification/rv/Makefile
> +++ b/tools/verification/rv/Makefile
> @@ -73,8 +73,11 @@ static: $(RV_IN)
>  	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RV)-static $(RV_IN) $(EXTLIBS)
>
>  BPF_DIR		:= bpf_monitors
> +BPF_REACT_DIR   := bpf_reactors
>  BPF_SOURCES	:= $(wildcard $(BPF_DIR)/*.c)

[ ... ]

> diff --git a/tools/verification/rv/Makefile.rv b/tools/verification/rv/Makefile.rv
> index 418748bc3aa1..3ac329851914 100644
> --- a/tools/verification/rv/Makefile.rv
> +++ b/tools/verification/rv/Makefile.rv
> @@ -34,6 +34,7 @@ MKDIR		:= mkdir
>  STRIP		:= strip
>  BINDIR		:= /usr/bin
>  BPF_MON_DIR	:= /usr/share/rv/bpf_monitors
> +BPF_REACT_DIR	:= /usr/share/rv/bpf_reactors
>
>  .PHONY: install
>  install: doc_install
> @@ -44,6 +45,10 @@ ifneq ($(wildcard bpf_monitors/*.o),)
>  	$(Q)$(MKDIR) -p $(DESTDIR)$(BPF_MON_DIR)
>  	$(call QUIET_INSTALL,bpf_monitors)$(INSTALL) bpf_monitors/*.o -m 644 $(DESTDIR)$(BPF_MON_DIR)
>  endif
> +ifneq ($(wildcard bpf_reactors/*.o),)
> +	$(Q)$(MKDIR) -p $(DESTDIR)$(BPF_REACT_DIR)
> +	$(call QUIET_INSTALL,bpf_reactors)$(INSTALL) bpf_reactors/*.o -m 644 $(DESTDIR)$(BPF_REACT_DIR)
> +endif

Is BPF_REACT_DIR defined twice with different meanings?  Makefile.rv sets it
to the install destination (/usr/share/rv/bpf_reactors), but Makefile
includes Makefile.rv first and then redefines it as the source directory:

  include Makefile.rv
  ...
  BPF_REACT_DIR   := bpf_reactors

make expands recipe lines after the whole makefile has been parsed, so the
install recipe sees the last value, "bpf_reactors".  The monitors are not
affected because they use two different names (BPF_DIR for the source,
BPF_MON_DIR for the destination).

Once the reactors are built (the default whenever clang and bpftool are
found), the wildcard check is true and make install runs:

  mkdir -p bpf_reactors
  install bpf_reactors/*.o -m 644 bpf_reactors

With an empty DESTDIR this copies each file onto itself, which GNU install
rejects with "are the same file", so make install fails.  With
DESTDIR=/tmp/pkg the reactors land in /tmp/pkgbpf_reactors instead of
/tmp/pkg/usr/share/rv/bpf_reactors.  Either way the installed rv cannot find
reactors under the /usr/share/rv base path that bpf_monitor.c searches.

Would renaming one of the variables (for example BPF_REACT_INST_DIR,
matching the BPF_DIR/BPF_MON_DIR split) fix this?  I didn't see a later patch
in this series that changes Makefile or Makefile.rv.

> diff --git a/tools/verification/rv/bpf_monitors/da_monitor_bpf.h b/tools/verification/rv/bpf_monitors/da_monitor_bpf.h
> index 12f0f78b9c9d..a37d11fef6f1 100644
> --- a/tools/verification/rv/bpf_monitors/da_monitor_bpf.h
> +++ b/tools/verification/rv/bpf_monitors/da_monitor_bpf.h

[ ... ]

> @@ -75,8 +74,15 @@ static const struct rv_trace_entry __used *_btf_trace;
>
>  static inline void da_monitor_reset(struct da_monitor *da_mon);
>
> -/* BPF monitors do not use reactors */
> -static inline void react(enum states curr_state, enum events event) { }
> +__noinline __weak void bpf_rv_react(char *msg) { }
> +
> +#define rv_react(mon, fmt, ...)							  \
> +	({									  \
> +		char ___msg[256];						  \
> +										  \
> +		if (BPF_SNPRINTF(___msg, sizeof(___msg), fmt, ##__VA_ARGS__) > 0) \
> +			bpf_rv_react(___msg);					  \
> +	})

Can this break loading of every BPF monitor on older kernels?

bpf_rv_react() is a non-static (weak) function, so clang gives it
BTF_FUNC_GLOBAL linkage and the verifier checks it as a global subprog.
Every BPF monitor now calls it on the da_event() -> react() path, even with
no reactor or with -r nop.

Global subprogs returning void have only been accepted since commit
8446ded1e1a0 ("bpf: Allow void global functions in the verifier").  Before
that commit, btf_prepare_func_args() rejects them with:

  Global function bpf_rv_react() doesn't return scalar. Only those are
  supported.

So after this patch, monitors that only use long-standing attach points
(nohz, for example) fail to load on kernels older than that commit.  Before
this patch they had no global subprog and did not have that requirement.

Would declaring the hook as "int bpf_rv_react(char *msg)", returning 0 in
the weak default and in the printk and panic reactors, keep the monitors
loadable on those kernels?

> diff --git a/tools/verification/rv/bpf_reactors/panic.c b/tools/verification/rv/bpf_reactors/panic.c
> new file mode 100644
> index 000000000000..775f91a300f0
> --- /dev/null
> +++ b/tools/verification/rv/bpf_reactors/panic.c

[ ... ]

> +char LICENSE[] SEC("license") = "GPL";
> +static char DESCRIPTION[] SEC(".rodata.description") =
> +	"panic the system if an exception is found.";
> diff --git a/tools/verification/rv/bpf_reactors/printk.c b/tools/verification/rv/bpf_reactors/printk.c
> new file mode 100644
> index 000000000000..580410d2a1fc
> --- /dev/null
> +++ b/tools/verification/rv/bpf_reactors/printk.c

[ ... ]

> +char LICENSE[] SEC("license") = "GPL";
> +static char DESCRIPTION[] SEC(".rodata.description") =
> +	"prints the exception msg to the trace buffer.";

Is the static DESCRIPTION in these two reactors ever used?

The monitors define DESCRIPTION as a non-static global (nohz.c, tqueue.c),
but here it has internal linkage and no "used" attribute.  That triggers
-Wunused-variable under the -Wall in BPF_CFLAGS, and the optimizer can drop
it at -O2, so the reactor objects may end up with no .rodata.description
section.

Nothing in the series reads a reactor description either, since
list_reactor_action() in bpf_monitor.c prints only the name.  Should the
variable be dropped, or made non-static like the monitors' if reactor
descriptions are meant to be listed?

> diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification/rv/src/bpf_monitor.c
> index d43ee75d3904..35bd1f40a109 100644
> --- a/tools/verification/rv/src/bpf_monitor.c
> +++ b/tools/verification/rv/src/bpf_monitor.c

[ ... ]

> @@ -795,6 +818,65 @@ static int attach_bpf_handlers(const char *monitor_name, struct bpf_object *obj,
>  	return enable_mon_fd;
>  }
>
> +static int find_bpf_reactor(const char *reactor_name, char *path_out, size_t path_len)
> +{
> +	return find_bpf_file("bpf_reactors", reactor_name, path_out, path_len);
> +}
> +
> +/*
> + * link_bpf_reactor - link the reactor function to the monitor
> + *
> + * Reactors are objects defining the BPF_REACTOR function, link that over the
> + * weak definition present in the monitor and return a file descriptor to the
> + * final linked object in memory.
> + *
> + * Returns memfd of final object on success, -1 on error.
> + */
> +static int link_bpf_reactor(const char *monitor_path, const char *reactor_path)
> +{
> +	struct bpf_linker *linker = NULL;
> +	int memfd = -1;
> +	int err = 0;
> +
> +	memfd = memfd_create("linked_bpf", 0);
> +	if (memfd < 0) {
> +		err_msg("bpf: failed to create memfd: %s\n", strerror(errno));
> +		return -1;
> +	}
> +
> +	linker = bpf_linker__new_fd(memfd, NULL);

Does this raise the minimum libbpf version needed to build rv?

bpf_linker__new_fd() was added in libbpf 1.6 (it is in the LIBBPF_1.6.0
block of libbpf.map).  rv builds against the system libbpf through
pkg-config, and the only libbpf gate is the feature test, which only
requires LIBBPF_MAJOR_VERSION >= 1:

    #if !defined(LIBBPF_MAJOR_VERSION) || (LIBBPF_MAJOR_VERSION < 1)
    #error At least libbpf 1.0 is required for Linux tools.

Before this patch, the newest libbpf API used by bpf_monitor.c was
bpf_map_get_info_by_fd() (LIBBPF_1.2.0).  With libbpf 1.2 to 1.5 installed
(for example Ubuntu 24.04 ships 1.3, RHEL 9 ships 1.3/1.4, Debian 13 and
Fedora 42 ship 1.5), feature-libbpf still passes, so HAVE_LIBBPF is set and
bpf_monitor.c is compiled.

The build then fails: GCC 14 and later reject the implicit declaration of
bpf_linker__new_fd(), and older compilers stop at link time with an
undefined reference.  On those systems 'make -C tools/verification/rv' used
to build rv with BPF monitor support and now fails outright, instead of
falling back to the "building without BPF monitor support" path.

Could this use bpf_linker__new() (LIBBPF_0.4.0) on a path such as
"/proc/self/fd/<memfd>" or a temporary file, or add a libbpf >= 1.6 version
check to Makefile.config, the way libtraceevent and libtracefs are already
handled there?  I didn't see a later patch in this series that touches
tools/verification/rv/src/, the rv Makefiles or tools/build/feature/.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36944413541
--===============5085887908721438195==--
