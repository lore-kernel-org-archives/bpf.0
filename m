Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F64F649F;
	Fri, 25 Sep 2026 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370805; cv=none; b=inI6jUClMl4dZDrrKp5yQ6YLCUawjftKKi55LFh8qIEHF1LrzWevCe8ggs7re1MEJkf3vyubvqxSQdyobS9PKrmvJtihHlRQGyT/EvOhM2iPC/baqK6RXce7Y+5s9UvTsYiWEnHCVeWMVtmMZDkgJ0OAUhUadDepyjIHgrqU75Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370805; c=relaxed/simple;
	bh=i8m/G1bHvKwbpaAYgfFeVg4+XQZ2BtxOj9jKkDBVxyU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QhOuLfAfVEc7+8uLzkmsgTfsFZth22pWW44IoUiVPAxuWrqxHz9kGNM/MtlmMdNbv4ry13LRKq3sMVkexi4reUtY9tWasGF/XeeGtHq+aIUY7VNnpAQV+ropinp0+bWOY2o1NsavAcr1qhbzJxPTiSseVZPsAJIZGL8JA9NloeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rwCkdxN/; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rwCkdxN/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790370803; x=1821906803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4M9IybI95F4X5+ocCoe/3+V9SQt9LrvgrMiXy1xALYo=;
  b=rwCkdxN/YaDjswsPcoG+4zyaS6c2VbrivTRUj+7VNyg40bwEeNEw+lI9
   5z/57TeFIi/2m+Dhw5o7U9XZJCNUOi18cp/fcAflUPI7E0mViiipfLrhi
   Di8Dfm81vMqXtW35PGrkbgi/seY8BFXUP9rjVlYeDyc58OqkKWvVmhczO
   k09YCKPfDVwsnKGLBIQmqQzrp0PRc8wzpW8pOHFU4s4/prt6KAWyEMMUh
   Bzoe+HxL5DO4vhSznsdhr9tAhPnSAZOzLpFSWWacjuXZaVIZajI8K0NIA
   JlZF6sxuLfMyFNpkGMJma3gyYlPXvp+NPRewGNwLhKV87gCwxTVS/LtEf
   g==;
X-CSE-ConnectionGUID: BZtPZxczSSWHEFkFrx+gTA==
X-CSE-MsgGUID: S2GLXNomR0Wf8mgkH9HHPw==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29660703"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 21:13:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:11423]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.110:2525] with esmtp (Farcaster)
 id b324db84-06cf-4840-a36a-f958d6926a2a; Fri, 25 Sep 2026 21:13:23 +0000 (UTC)
X-Farcaster-Flow-ID: b324db84-06cf-4840-a36a-f958d6926a2a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 21:13:22 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 21:13:22 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Alan Maguire <alan.maguire@oracle.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
	<nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, Luis Chamberlain
	<mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	<linux-modules@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, Hazem Mohamed Abuelfotoh
	<abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>, Martin Pohlack
	<mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next v2 0/9] bpf: make the vmlinux BTF an on-demand loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
Date: Fri, 25 Sep 2026 21:13:05 +0000
Message-ID: <20260925211314.5118-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Based on and tested against bpf-next commit b4d936547f5a ("Merge branch
'bpf-arena-fix-range_tree-consistency-on-allocation-failure'").

This series makes CONFIG_DEBUG_INFO_BTF a tristate, so that it can be
set to =m.  With =m the vmlinux BTF is carried by a module, btf_vmlinux,
that the kernel loads the first time anything needs the BTF.  On a
system where nothing does, that saves ~5.4 MB of RAM with a distribution
config; on a system that uses BTF, nothing differs from =y.  =y itself
is untouched.

Problem
-------

The vmlinux BTF that CONFIG_DEBUG_INFO_BTF=y builds into the kernel
image takes ~5.4 MB of memory, resident from boot whether anything uses
it or not.  On small instances that is not negligible.

A distribution cannot simply turn it off for the users who do not need
it: it ships one kernel build for all its users, and BTF is not debug
info anymore.  CO-RE, fentry/fexit, kfuncs, struct_ops, sched_ext and
bpf-lsm all depend on it, so =n takes those away from everyone who does
use them. 

Hence this series adds CONFIG_DEBUG_INFO_BTF=m: the BTF becomes an
on-demand module.
Users who never use BTF get the memory back; for users who do, the first
use loads it automatically and everything works as with =y.

Approach
--------

Do not remove anything, defer it.  The BTF is generated exactly as
before, but with =m it is not part of the kernel image: it is packed
into a module, btf_vmlinux.ko, which the kernel loads itself the first
time anything needs the BTF.  Once loaded, the BTF stays, and nothing
differs from =y.

Making that work ran into five problems.  The first three are existing
components that rely on the vmlinux BTF being present from boot, which
a loadable module cannot provide; the last two follow from the BTF no
longer being part of the image.

1. Verifier.  Problem: bpf_check() fetched the vmlinux BTF for every
   program, so the first socket filter at boot would have loaded the
   module on every system.  Solution: fetch the BTF only where kernel
   types enter a program (attach_btf, kfunc calls, ksyms, map pointer
   access, helpers that take or return kernel pointers).  A program
   using none of these never touches it.

2. Initcall registrations.  Problem: kfunc, dtor kfunc and struct_ops
   registrations run from initcalls and need the parsed BTF, which
   would again pull it in at boot.  Solution: queue them and apply the
   queue when the BTF is parsed, before it is published, so no program
   can ever see a vmlinux BTF that lacks its kfuncs or struct_ops.

3. Module BTF.  Problem: module BTF is split BTF against the vmlinux
   BTF and was parsed at module load.  A module loaded before the
   vmlinux BTF cannot be parsed yet, and the module notifier cannot
   load btf_vmlinux (that would nest a module load inside a module
   load).  Solution: keep the module's BTF aside (the same copy
   btf_parse_module() makes with =y, so module BTF costs the same in
   both; the saving is the vmlinux BTF only), expose it in
   /sys/kernel/btf right away, and parse and register it, together with
   the module's own kfuncs and struct_ops, once the vmlinux BTF arrives.
   Module BTF thus works regardless of load order, including out-of-tree
   modules with a .BTF.base, whose sysfs reader waits for the relocation.

4. Trust.  Problem: the verifier treats the BTF as the description of
   the kernel's types, so a carrier from a different build must be
   refused even if vermagic lets it load.  Solution: link the size and
   SHA-256 of the BTF into the image and check them when the module
   loads.  The linked-in size also lets /sys/kernel/btf/vmlinux report
   its final size before the load, which tooling expects.

5. Tooling.  Problem: pahole --btf_base for module BTF, bpftool and
   external module builds read .BTF from the vmlinux ELF.  Solution:
   keep .BTF in the ELF as a non-loadable section, so it is in the file
   but not in the image.

CONFIG_BPF_PRELOAD is made unavailable with =m: its preloaded programs
attach through the vmlinux BTF, so every bpffs mount, which systemd does
at boot, would load it and defeat the point.

Relation to the inline BTF series
---------------------------------

Alan's inline BTF series [2] adds inline function information to BTF,
which is even larger than the BTF itself, and its cover letter leaves
delivering that information on demand, through a module and sysfs, to a
follow-up.  When Alexei suggested taking the same route for the vmlinux
BTF, Alan pointed out where the difficulty would lie [3].

However, that approach cannot be used directly for the vmlinux BTF,
because of what depends on the data:

1. Boot-time consumers.  Nothing needs inline information at boot, so
   loading it late only concerns the sysfs file.  The core vmlinux BTF
   is needed at boot by the verifier, by kfunc and struct_ops
   registrations, and by every module's BTF.  Therefore we need to make
   each of those wait for the BTF instead of expecting it at boot: the
   verifier fetches it only when a program brings kernel types in, and
   the registrations are queued and replayed once it is parsed.  That
   is most of this series.

2. Module BTF.  Module BTF is split against the vmlinux BTF, so a module
   loaded before it has nothing to be parsed against, and the module
   notifier cannot load btf_vmlinux itself.  Therefore we need to keep
   the module's BTF aside, create its sysfs file right away, and parse
   and register it once the vmlinux BTF arrives; the file of a module
   built against a distilled base (.BTF.base) serves it once relocated,
   the others serve the raw bytes as they are.  Alan named this as the
   hard part; it works here regardless of whether the module loads
   before or after the vmlinux BTF.

The btf_vmlinux module added here could carry the inline information as
well when that follow-up comes, so both would share one mechanism.

Patches Structure
-----------------

Patch 1 (refactor, no functional change): btf_parse_module() takes the
vmlinux BTF as an argument and can adopt an existing copy of the module
BTF data instead of duplicating it.  Needed so that module BTF kept
aside at load time can be parsed later without moving the buffer the
sysfs file points at.

Patch 2 (refactor, no functional change): splits the kfunc, dtor kfunc
and struct_ops registration functions into "find the BTF for the owner"
and "add the registration to this BTF", so the second half can be
replayed on a queued registration.

Patch 3 (verifier): stops fetching the vmlinux BTF up front in
bpf_check() and fetches it where kernel types enter a program instead.
Adds bpf_peek_btf_vmlinux() for the helpers that run in program
context and cannot load anything.  With =y the BTF is parsed at boot
anyway, so this is invisible there.

Patch 4 (carrier): the runtime side of taking the vmlinux BTF from the
btf_vmlinux module: request it on first use, copy it out of the module
in the BTF module notifier after checking size and SHA-256 against
.BTF.meta, and serve /sys/kernel/btf/vmlinux from the copy with its
size known from boot.  All under IS_MODULE(CONFIG_DEBUG_INFO_BTF), so
unreachable until patch 9.

Patch 5 (vmlinux registrations): queues kfunc, dtor kfunc and struct_ops
registrations for vmlinux made from initcalls and applies them when the
BTF is parsed, before it is published.

Patch 6 (module BTF): keeps the BTF of modules loaded before the vmlinux
BTF, with their own queued registrations, and parses, registers and
publishes it when the vmlinux BTF arrives.

Patch 7 (.BTF.base sysfs): gives such a module with a .BTF.base its
/sys/kernel/btf file from load, with a reader that waits for the
relocation.  Patches 5-7 are also unreachable until patch 9.

Patch 8 (preparation, no functional change): the #ifdef and Makefile
checks of CONFIG_DEBUG_INFO_BTF that must hold for both =y and =m use
IS_ENABLED() and $(subst m,y,...), in bpf, tracing, netfilter and xfrm.

Patch 9 (kbuild and Kconfig): makes CONFIG_DEBUG_INFO_BTF a tristate;
with =m links .BTF into vmlinux as a non-loadable section, emits
.BTF.meta, builds btf_vmlinux.ko with the vmlinux .BTF as its payload,
strips .BTF from vmlinux (module BTF is generated against
vmlinux.unstripped), excludes CONFIG_BPF_PRELOAD, and documents the
option.

Patches 1-3 and 8 are independently useful or neutral; 4-7 are dead code
until 9 flips the switch, which keeps each bisect step building and
behaving as before.

Testing
-------

Tested with 1 GiB of memory, same tree, =y against =m, both with
CONFIG_DEBUG_INFO_BTF_MODULES=y.  The on-demand behaviour is easy to
see by hand on an =m kernel:

  # lsmod | grep btf_vmlinux
      -> nothing: the BTF is not loaded at boot.
  # ls -la /sys/kernel/btf/vmlinux
      -> the file exists with its final size (from .BTF.meta), although
         the BTF behind it is not loaded yet.
  # modprobe ext4 nf_conntrack
  # ls /sys/kernel/btf/
      -> ext4, nf_conntrack, ... appear immediately, although their
         BTF is only kept aside, not parsed: there is no vmlinux BTF to
         parse it against yet.
  # lsmod | grep btf_vmlinux
      -> still nothing: loading modules does not load the vmlinux BTF.
  # cat /sys/kernel/btf/ext4 > /dev/null
  # lsmod | grep btf_vmlinux
      -> still nothing: a module's BTF file is served from the raw copy,
         reading it does not need the vmlinux BTF.
  # grep VmallocUsed /proc/meminfo
      -> baseline.
  # cat /sys/kernel/btf/vmlinux > /dev/null
  # lsmod | grep btf_vmlinux
      -> btf_vmlinux ... [permanent]: the first use loaded it, and it
         cannot be unloaded.
  # grep VmallocUsed /proc/meminfo
      -> up by ~5.5 MB: the BTF copy, allocated only now.
  # bpftool btf list
      -> vmlinux and every loaded module now have BTF ids; the modules
         loaded before were parsed and registered on the way.

The same with an out-of-tree module (built with M=, so its BTF is split
against a distilled base, .BTF.base), on a fresh boot:

  # insmod btf_extmod.ko
  # ls -la /sys/kernel/btf/btf_extmod
      -> the file exists with its final size, although the BTF behind
         it is only valid once relocated against the vmlinux BTF.
  # lsmod | grep btf_vmlinux
      -> nothing: loading the module does not load the vmlinux BTF.
  # cat /sys/kernel/btf/btf_extmod > /dev/null
  # lsmod | grep btf_vmlinux
      -> btf_vmlinux ... [permanent]: reading this file loaded the
         vmlinux BTF, relocated the module's BTF and then returned it.
  # bpftool btf dump file /sys/kernel/btf/btf_extmod
      -> the module's own types, resolved against the vmlinux BTF.
  # rmmod btf_extmod
      -> unloads normally; its file goes away with it.

Any BPF program that uses kernel types (kprobe with
bpf_get_current_task_btf(), a kfunc call, fentry, a global subprogram
taking the context, bpf_snprintf_btf(), CO-RE, ...) triggers the same
load; a plain socket filter does not.

Results:

 - MemTotal is ~5.4 MB higher with =m while the BTF is unused, which is
   the size of the .BTF section.  Once the BTF is in use, MemFree is the
   same within run-to-run noise.
 - Modules loaded before the trigger (ext4, nf_conntrack, which
   registers kfuncs from its init, xfrm_interface) get BTF ids once the
   BTF is loaded; a struct_ops map for tcp_congestion_ops and a syscall
   program calling bpf_task_from_pid() work; nf_nat loaded afterwards
   takes the usual path.
 - stat() of /sys/kernel/btf/vmlinux reports the final size before the
   load; fstat/read/mmap agree afterwards.
 - A carrier with one byte of .BTF changed is refused with -EINVAL.
 - With the in-tree bpftool and clang-built programs as the first user
   on a fresh boot: bpftool btf dump file /sys/kernel/btf/vmlinux,
   bpftool btf list, a socket filter with a global subprogram taking
   struct __sk_buff *, a raw_tp program calling bpf_snprintf_btf(), a
   CO-RE field read, and a program calling a kfunc of an out-of-tree
   module (distilled .BTF.base, kfunc registered from init, loaded
   before the vmlinux BTF), and a read of that module's own sysfs file,
   each load the BTF and work; rmmod of that module afterwards is clean.
 - lockdep and kmemleak kernels are clean in all of the above.
 - =y and =n build and behave as before; =m without module BTF works;
   every patch builds on its own.
 - The boot image on disk shrinks by the compressed BTF with =m
   (15.0 MB to 13.2 MB here).

Changes since v1 [4]:

 - Split for review: v1 patch 5 is now patches 5-7 (vmlinux
   registrations, module BTF, .BTF.base sysfs), v1 patch 6 is now
   patches 8-9 (preparation of the existing checks, the switch).
 - Fetch sites added for the program context type table
   (bpf_ctx_convert: global subprograms taking the context, ctx access
   of tracing/EXT programs), for bpf_snprintf_btf()/bpf_seq_printf_btf()
   and for CO-RE candidate lookup, which now fetches before taking
   cand_cache_mutex (Sashiko, bpf-ci, Jiri).  Without
   CONFIG_DEBUG_INFO_BTF the new helper check is skipped, so nothing
   changes there.
 - Module BTF is published only after its deferred registrations are
   applied; only modules past MODULE_STATE_LIVE are replayed, with the
   module pinned; a module still in init has its queue applied at LIVE.
   Fixes the concurrent registration and COMING-module lifetime issues
   (Sashiko, bpf-ci).
 - The sysfs reader of a module with .BTF.base waits for the module's
   BTF to be relocated instead of serving the raw data (bpf-ci); sysfs
   files are no longer removed from the deferred parse path, and
   MODULE_STATE_GOING removes them outside btf_module_mutex.
 - A module whose deferred BTF fails to parse or get an id keeps the
   buffer its sysfs file serves; nothing is freed under a reader
   (Sashiko).
 - The vmlinux registration queue has its own mutex; no lock is taken
   under btf_vmlinux_lock that leads back to it (bpf-ci).
 - A failed parse is not cached with =m (Sashiko).
 - Only the carrier depends on vmlinux in Makefile.modfinal; POSIX dd
   instead of head -c (Sashiko).
 - .BTF stripped from vmlinux with =m, so no boot image carries it,
   also where the image is an ELF copy of vmlinux; module BTF is
   generated against vmlinux.unstripped (Alan).
 - Kconfig help: initramfs note, module BTF accounting (Alan).
 - btf_struct_ops_add() renamed btf_struct_ops_register() (bpf-ci);
   its stub only defined where used.
 - Tests with bpftool/libbpf userspace and an out-of-tree .BTF.base
   module added (Alan).

[1] https://lore.kernel.org/all/20260917000201.25581-2-wanjay@amazon.com/
[2] https://lore.kernel.org/bpf/20260916074118.1007116-1-alan.maguire@oracle.com/
[3] https://lore.kernel.org/all/33592fca-88a8-44aa-8d94-40e1e604554e@oracle.com/
[4] https://lore.kernel.org/bpf/20260923053948.30617-1-wanjay@amazon.com/

Jay Wang (9):
  bpf: pass the vmlinux BTF to btf_parse_module() and let it adopt the
    data
  bpf: split the kfunc, dtor kfunc and struct_ops registration bodies
  bpf: fetch the vmlinux BTF where kernel types enter a program
  bpf: take the vmlinux BTF from the btf_vmlinux module
  bpf: defer vmlinux kfunc and struct_ops registrations
  bpf: keep module BTF until the vmlinux BTF is available
  bpf: expose deferred .BTF.base module BTF in sysfs from module load
  bpf, trace, net: prepare CONFIG_DEBUG_INFO_BTF checks for a tristate
  kbuild, bpf: allow building the vmlinux BTF as a module

 Documentation/bpf/btf.rst         |  35 ++
 Makefile                          |   8 +-
 include/asm-generic/vmlinux.lds.h |  31 +-
 include/linux/bpf.h               |   1 +
 include/linux/btf.h               |   6 +
 include/linux/btf_ids.h           |   2 +-
 include/linux/compiler_types.h    |   2 +-
 include/linux/module.h            |   2 +-
 include/trace/trace_events.h      |   2 +-
 kernel/bpf/Makefile               |   6 +-
 kernel/bpf/bpf_struct_ops.c       |   3 +-
 kernel/bpf/btf.c                  | 922 ++++++++++++++++++++++++++----
 kernel/bpf/btf_vmlinux.c          |  23 +
 kernel/bpf/preload/Kconfig        |   4 +
 kernel/bpf/syscall.c              |   6 +
 kernel/bpf/sysfs_btf.c            |  85 ++-
 kernel/bpf/verifier.c             | 122 +++-
 kernel/module/main.c              |   4 +-
 kernel/trace/bpf_trace.c          |   3 +-
 kernel/trace/trace_syscalls.c     |   6 +-
 lib/Kconfig.debug                 |  22 +-
 net/netfilter/Makefile            |   6 +-
 net/xfrm/Makefile                 |   4 +-
 scripts/Makefile.modfinal         |  26 +-
 scripts/Makefile.vmlinux          |   5 +
 scripts/gen-btf.sh                |  95 ++-
 scripts/link-vmlinux.sh           |  25 +-
 27 files changed, 1300 insertions(+), 156 deletions(-)
 create mode 100644 kernel/bpf/btf_vmlinux.c


base-commit: b4d936547f5a3ca5563f48ee81f153c928336027
-- 
2.47.3

