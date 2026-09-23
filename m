Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C26E3A3E91;
	Wed, 23 Sep 2026 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141991; cv=none; b=f34FFIWa+ePHr9nD/7UAwOIb5Y3Jj6YBh8HfzHHhHIF8xYbAu2e4Z3MqiiJ0+hMbWaRQzBs1LddXFmPPsdMWjc8eBjszMxYvRceRl9TG7BsHmSHRI7WIT8MWVSr6BIlVMOnRskgtMr8lK/DYY8hD2cKeYMpuQl+E1vNZO+X7K/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141991; c=relaxed/simple;
	bh=Mtoh5rWBAWMUE94pxCfuPwjbds9keS2vlWFyCYC854o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SRSZ4EgdK22we4POLkp9O8+hNMqIi2n49ziLZIem6qQodQdxuTrNhfPJunVWTnnaMSNz7N9ZUYCkZ6qD3y8EUbQqjQi5DKS35s/8qJoeG4R/fIZfg4zoDvnhenHFjEi2hLYB/vKpCPt6C19t8HF2MNyFfZ5eVzr+STPBewTan/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tMxFc5mJ; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tMxFc5mJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790141990; x=1821677990;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T2ByyH/wtJCx7Na+D5rTx7i6cKCUqqPLbl+qGy+Y66g=;
  b=tMxFc5mJ3Wj15njit4bwpyydmBbRmZo5xEplZmLgXHucVg7otbKON7Nk
   lEjMu28pXMV9eu5y3fKS+7U7JtCRGfbt/tgY0eXmtPyyxYZ2akoPgbw1l
   SbhdJDwksuzis7mLQpLlVrR+EwclQ0S6nf3+FhsJ4nIkrrYtJ4CRxsf7r
   ci8W/tjfom1cjlPPNJOJ8OkQ1oqP1tCCaYpBh1NjtVqoouUcTKD37mGmT
   sv5zlcu1N1hBrJdo01uD2XM1E9UPR9JtEp1HdgkE8hGUCjgECn9TnJhYq
   bdaltGqY4/O/9/8OKKMafdxOo2b9cixOGcPZaoMGcKTCfAd6HA+3VNdaY
   w==;
X-CSE-ConnectionGUID: BiFj28b/Th6wdsPGNRketw==
X-CSE-MsgGUID: 2EpWwkE0TQualvsqjrNWXQ==
X-IronPort-AV: E=Sophos;i="6.27,117,1787011200"; 
   d="scan'208";a="29444457"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 05:39:49 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:20984]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.40:2525] with esmtp (Farcaster)
 id 7e661d76-f78a-483a-942f-de0a7336d079; Wed, 23 Sep 2026 05:39:49 +0000 (UTC)
X-Farcaster-Flow-ID: 7e661d76-f78a-483a-942f-de0a7336d079
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:39:49 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:39:48 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Alan Maguire <alan.maguire@oracle.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, "Nathan
 Chancellor" <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	<linux-kbuild@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, <linux-modules@vger.kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, <linux-kernel@vger.kernel.org>, Hazem Mohamed Abuelfotoh
	<abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>,
	<jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next 0/6] bpf: make the vmlinux BTF an on-demand loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
Date: Wed, 23 Sep 2026 05:39:42 +0000
Message-ID: <20260923053948.30617-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Based on and tested against bpf-next commit 91f8613d95ad ("bpf: Drop
duplicate check_app_limited in tcp_bpf_push").

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
   load).  Solution: keep the module's BTF aside, expose it in
   /sys/kernel/btf right away, and parse and register it, together
   with the module's own kfuncs and struct_ops, once the vmlinux BTF
   arrives.  Module BTF thus works regardless of load order.

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
   the module's BTF aside, expose it in sysfs as raw bytes right away,
   and parse and register it once the vmlinux BTF arrives.  Alan named
   this as the hard part; it works here regardless of whether the module
   loads before or after the vmlinux BTF.

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
unreachable until patch 6.

Patch 5 (deferrals): queues kfunc, dtor kfunc and struct_ops
registrations made before their BTF is available and applies them when
it is; keeps the BTF of modules loaded before the vmlinux BTF and parses
and registers it when the vmlinux BTF arrives.  Also unreachable until
patch 6.

Patch 6 (kbuild and Kconfig): makes CONFIG_DEBUG_INFO_BTF a tristate;
with =m links .BTF into vmlinux as a non-loadable section, emits
.BTF.meta, builds btf_vmlinux.ko with the vmlinux .BTF as its payload,
makes the Makefile and #ifdef sites that must hold for both =y and =m
do so, excludes CONFIG_BPF_PRELOAD, and documents the option.

Patches 1-3 are independently useful cleanups; 4 and 5 are dead code
until 6 flips the switch, which keeps each bisect step building and
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

Any BPF program that uses kernel types (kprobe with
bpf_get_current_task_btf(), a kfunc call, fentry, ...) triggers the
same load; a plain socket filter does not.

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
 - lockdep and kmemleak kernels are clean in all trigger orders.
 - =y and =n build and behave as before; =m without module BTF works.

[1] https://lore.kernel.org/all/20260917000201.25581-2-wanjay@amazon.com/
[2] https://lore.kernel.org/bpf/20260916074118.1007116-1-alan.maguire@oracle.com/
[3] https://lore.kernel.org/all/33592fca-88a8-44aa-8d94-40e1e604554e@oracle.com/

Jay Wang (6):
  bpf: pass the vmlinux BTF to btf_parse_module() and let it adopt the
    data
  bpf: split the kfunc, dtor kfunc and struct_ops registration bodies
  bpf: fetch the vmlinux BTF where kernel types enter a program
  bpf: take the vmlinux BTF from the btf_vmlinux module
  bpf: defer registrations until the vmlinux BTF is available
  kbuild, bpf: allow building the vmlinux BTF as a module

 Documentation/bpf/btf.rst         |  35 ++
 Makefile                          |   8 +-
 include/asm-generic/vmlinux.lds.h |  30 +-
 include/linux/bpf.h               |   1 +
 include/linux/btf.h               |   7 +
 include/linux/btf_ids.h           |   2 +-
 include/linux/compiler_types.h    |   2 +-
 include/linux/module.h            |   2 +-
 include/trace/trace_events.h      |   2 +-
 kernel/bpf/Makefile               |   6 +-
 kernel/bpf/bpf_struct_ops.c       |   3 +-
 kernel/bpf/btf.c                  | 782 ++++++++++++++++++++++++++----
 kernel/bpf/btf_vmlinux.c          |  23 +
 kernel/bpf/preload/Kconfig        |   4 +
 kernel/bpf/syscall.c              |   6 +
 kernel/bpf/sysfs_btf.c            |  80 ++-
 kernel/bpf/verifier.c             | 104 +++-
 kernel/module/main.c              |   4 +-
 kernel/trace/bpf_trace.c          |   3 +-
 kernel/trace/trace_syscalls.c     |   6 +-
 lib/Kconfig.debug                 |  13 +-
 net/netfilter/Makefile            |   6 +-
 net/xfrm/Makefile                 |   4 +-
 scripts/Makefile.modfinal         |  14 +-
 scripts/gen-btf.sh                |  93 +++-
 scripts/link-vmlinux.sh           |  25 +-
 26 files changed, 1121 insertions(+), 144 deletions(-)
 create mode 100644 kernel/bpf/btf_vmlinux.c


base-commit: 91f8613d95ad8cd99d8baf094806d1ef98bc6380
-- 
2.47.3

