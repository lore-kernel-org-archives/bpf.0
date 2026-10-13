Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C768E485CC1
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913051; cv=none; b=ttT0RaIlgODKGBwOarxit2i5tn/n1XtEHow+WJttXeIcdsKVLlYd5l93PhYUt4jF9wd2vcBpNc3zkdVvpbTMFWbp6CsmqqX1wZ3sYqgKcLW9Lk8cTQ6Ew1FT2szfJjRqdI0oSKe67qNbIxQVsmPCtmUwO/J6q9dX/pwO1vtSWtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913051; c=relaxed/simple;
	bh=NbQoBeYPzip+yvprXypzCQvlIroWsy7X5ZcNilATwys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGnEsiuq1ISgt+cLrkczbRDD4O3Z8GUbKdfLavgZTc27plP11WFRH4sh1SdHngQx/Ji52PakC7zIqSZOv0tOGkLI4hIQS7JTJffuhleKWNKwZjnYkK0cW/P+QImGSQ0239wmzPRp+vL0FR9Ug9HLe0L4/5d55vXvUBR6JsRcrMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lbT27zlM; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lbT27zlM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=o4dAEh+eaIY4KB+ZB626fpur12f+NyB7yW/Qh/khwh8=; b=lbT27zlMUiFwG9mY8K2jhNfl/q
	R4FdoTZgPZMO6MSPPPTQkuJILpIY0cF/vM9qGnM9m8SoZ8FI+3QqvjuqE7pD4ZhHjZKCWHMLroAby
	5NrZn6j6u9Jfp3TOJH0XVS6M7pWIbwIy0Amiri6HSU+JOlpoZ94/mbiB5esONatf+O2Xyju769Dq4
	stzhn1pFCSy3lG6VaQyPluz4h0MlPyiKmtFaO9CabsEbVhXnoDxxPJeXzYCGi4Aul4n5U3v/Yn9zT
	LcVp353/Ci6Db/rQ9uJUXzNgxOkAeIFGHqYECNvZb52S8CHl8k5lo4oBj7XK0cRL8Jid9dWfMdX8K
	rTNWJxRg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3D-000PPr-06;
	Tue, 13 Oct 2026 19:12:31 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 00/18] bpf: Various x86-64 BPF JIT improvements
Date: Tue, 13 Oct 2026 19:12:12 +0200
Message-ID: <20261013171230.523677-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28152/Tue Oct 13 08:26:14 2026)

This series changes the x86-64 BPF JIT to emit shorter and faster native
code for the instruction patterns that LLVM-compiled programs hit in the
real world. Every change stays within the lowering of a single BPF
instruction, nothing is optimized across instructions. The patterns were
checked against what clang's BPF backend actually emits, and the native
forms follow what LLVM's own X86 backend picks for the same operations.

The last two patches carry the instruction tests of the test_bpf.ko module
over to test_progs as result-checked tests which run on every JIT, add
sweeps for the rewritten patterns with every register as operand, and
finally remove the module given it is legacy code and the BPF selftests
today are the authoritative source of truth for BPF-based testing.

To see what the series does to code that is actually deployed, the BPF
objects of Cilium (7c11a349512b), Tetragon (3f20b90ee580), Katran
(2cd783e43a07) and the sched_ext schedulers (the Rust ones of the scx
repository at fead94e15184 plus the C examples under tools/sched_ext) were
built with clang 20 and every program of them that loads (526, another 39
fail on both kernels) was loaded on two VMs run through vmtest.sh. Both
kernels (before/after this series) got the same objects through the same
loader; the size below is jited_prog_len from bpf_prog_get_info_by_fd().
There are no programs which got bigger in size.

File                                  Program                    Size (A)   Size (B)         Size (DIFF)
------------------------------------  ------------------------  ---------  ---------  ------------------
tetragon/bpf_prog_iter.o              iter                            157        108       -49 (-31.21%)
scx/scx_simple.bpf.o                  simple_running                   86         80        -6 (-6.98%)
scx/scx_mitosis.bpf.o                 mitosis_init_task              3362       3130      -232 (-6.90%)
scx/scx_simple.bpf.o                  simple_enqueue                  256        239       -17 (-6.64%)
cilium/bpf_host.o                     tail_drop_notify                838        786       -52 (-6.21%)
katran/xdp_pktcntr.o                  pktcntr                         179        168       -11 (-6.15%)
scx/scx_cpu0.bpf.o                    cpu0_enqueue                    328        308       -20 (-6.10%)
scx/scx_tickless.bpf.o                tickless_init                   248        233       -15 (-6.05%)
scx/scx_cosmos.bpf.o                  cosmos_init                     662        623       -39 (-5.89%)
scx/scx_userland.bpf.o                userland_init                   123        116        -7 (-5.69%)
scx/scx_lavd.bpf.o                    lavd_tick                      1798       1698      -100 (-5.56%)
scx/scx_lavd.bpf.o                    set_power_profile               471        445       -26 (-5.52%)
cilium/bpf_wireguard.o                tail_drop_notify                716        677       -39 (-5.45%)
scx/scx_layered.bpf.o                 tp_task_rename                  382        362       -20 (-5.24%)
scx/scx_lavd.bpf.o                    lavd_cgroup_exit                 59         56        -3 (-5.08%)
scx/scx_bpfland.bpf.o                 bpfland_init                   1128       1071       -57 (-5.05%)
scx/scx_simple.bpf.o                  simple_select_cpu               240        228       -12 (-5.00%)
tetragon/bpf_execve_map_update_v61.o  execve_map_update               322        306       -16 (-4.97%)
[...]

For a feel of the native code, the two loads through an untrusted pointer
at the start of Tetragon's bpf_prog_iter.o iter program.

Before:

  24:	49 c7 c2 00 00 60 ff 	mov    $0xffffffffff600000,%r10
  2b:	49 89 f3             	mov    %rsi,%r11
  2e:	49 81 c3 50 00 00 00 	add    $0x50,%r11
  35:	4d 29 d3             	sub    %r10,%r11
  38:	49 ba 00 00 a0 00 00 	movabs $0x800000a00000,%r10
  3f:	80 00 00
  42:	4d 39 d3             	cmp    %r10,%r11
  45:	77 04                	ja     0x4b
  47:	31 f6                	xor    %esi,%esi
  49:	eb 04                	jmp    0x4f
  4b:	48 8b 76 50          	mov    0x50(%rsi),%rsi
  4f:	49 c7 c2 00 00 60 ff 	mov    $0xffffffffff600000,%r10

After:

  21:	4c 8d 9e 50 00 a0 00 	lea    0xa00050(%rsi),%r11
  28:	49 c1 eb 30          	shr    $0x30,%r11
  2c:	75 04                	jne    0x32
  2e:	31 f6                	xor    %esi,%esi
  30:	eb 04                	jmp    0x36
  32:	48 8b 76 50          	mov    0x50(%rsi),%rsi
  36:	4c 8d 9e 20 00 a0 00 	lea    0xa00020(%rsi),%r11

The same JITed image dumps were run through llvm-mca 20 as straight-line
code: one pass over every instruction of the image on the scheduling model
of a given CPU, with the helper calls left out since llvm-mca cannot model
them and they are the same on both sides. This is a static model, the path
actually taken through the program, branch prediction and cache misses are
not part of it, but both sides get the same program so the delta is what
the series in here rewrote.

** llvm-mca -mcpu=skylake:

Project    Progs Cycles (A) Cycles (B)      Cycles (DIFF)  uOps (A)  uOps (B)        uOps (DIFF)
---------- ----- ---------- ---------- ------------------ --------- --------- ------------------
cilium       156      87259      67879   -19380 (-22.21%)    256445    244684    -11761 (-4.59%)
katran         5       1213       1213        +0 (+0.00%)      3944      3944        +0 (+0.00%)
scx          275      72560      70781     -1779 (-2.45%)    133616    131221     -2395 (-1.79%)
tetragon      90      61907      61885       -22 (-0.04%)    188155    188015      -140 (-0.07%)

** llvm-mca -mcpu=icelake-server:

Project    Progs Cycles (A) Cycles (B)      Cycles (DIFF)  uOps (A)  uOps (B)        uOps (DIFF)
---------- ----- ---------- ---------- ------------------ --------- --------- ------------------
cilium       156      78114      61902   -16212 (-20.75%)    256445    244684    -11761 (-4.59%)
katran         5       1149       1149        +0 (+0.00%)      3944      3944        +0 (+0.00%)
scx          275      66903      65717     -1186 (-1.77%)    133616    131221     -2395 (-1.79%)
tetragon      90      54849      54827       -22 (-0.04%)    188155    188015      -140 (-0.07%)

** llvm-mca -mcpu=alderlake:

Project    Progs Cycles (A) Cycles (B)      Cycles (DIFF)  uOps (A)  uOps (B)        uOps (DIFF)
---------- ----- ---------- ---------- ------------------ --------- --------- ------------------
cilium       156      51850      50979      -871 (-1.68%)    230693    230022      -671 (-0.29%)
katran         5       1065       1063        -2 (-0.19%)      3816      3809        -7 (-0.18%)
scx          275      54339      54255       -84 (-0.15%)    102485    102317      -168 (-0.16%)
tetragon      90      43254      43225       -29 (-0.07%)    162817    162681      -136 (-0.08%)

** llvm-mca -mcpu=znver4:

Project    Progs Cycles (A) Cycles (B)      Cycles (DIFF)  uOps (A)  uOps (B)        uOps (DIFF)
---------- ----- ---------- ---------- ------------------ --------- --------- ------------------
cilium       156      66985      66665      -320 (-0.48%)    274895    275648      +753 (+0.27%)
katran         5       1387       1390        +3 (+0.22%)      5188      5188        +0 (+0.00%)
scx          275     117153     116630      -523 (-0.45%)    304094    303980      -114 (-0.04%)
tetragon      90      81172      81156       -16 (-0.02%)    277077    277069        -8 (-0.00%)

On Skylake and Ice Lake class cores the modeled cycles drop by a tenth and
Cilium's by a fifth: those programs divide by constants, where llvm-mca
puts a 64-bit div at 32 uops and 76 cycles of latency (its Ice Lake model
carries over Skylake's divider, the hardware is at about 15 cycles), and
shift by a register, which is 3 uops through cl against 1 with shlx.
Cilium's BPF code holds 416 such divisions in 88 of its programs, all by
NSEC_PER_SEC from its monotonic clock helper, which conntrack, NAT and the
load balancer run for every entry they stamp or check; Tetragon and Katran
have none, the schedulers 75, mostly by 100 and 1000000. Both are cheap on
Zen 4 already, so there the model stays flat at the program level, and the
few programs it rates slower come from its Zen 4 model charging a 64-bit
immediate move a full issue cycle where Agner measures a quarter.

Golden Cove, here the Alder Lake P model which LLVM 20 also uses for the
later client cores and which gives the same numbers as its Sapphire Rapids
model, has a divider at 3 uops and 18 cycles. The division drops from 24 to
10 cycles there, and the totals move by -0.66%, Cilium's by -1.68%. That
model counts register moves and adds as zero uops and puts shlx at 3 cycles
of latency, so it rates the shift by a register a cycle slower. The 27
programs it rates slower are 1 to 6 cycles each, at most +1.16%.

The rewrites on their own, cycles and uops of llvm-mca for one instance of
each sequence in a single pass (the pipeline fill included, and for the
division without the rax/rdx save and restore both sides share):

  pattern                   Skylake    Ice Lake   Alder Lake  Zen 4
  r1 /= 1000000000          81 > 10    81 > 10    24 > 10     21 > 8
    uops                    35 > 6     35 > 6     5 > 5       5 > 6
  PROBE_MEM address check   8 > 6      8 > 6      8 > 6       7 > 6
    uops                    7 > 3      7 > 3      5 > 3       7 > 3
  cast to a user address    9 > 6      9 > 6      10 > 7      8 > 6
    uops                    7 > 5      7 > 5      8 > 5       7 > 5
  shift by a register       6 > 4      6 > 4      5 > 6       4 > 4
    uops                    3 > 1      3 > 1      2 > 1       1 > 1
  multiply by 3             6 > 4      6 > 4      6 > 4       6 > 5
    uops                    1 > 1      1 > 1      1 > 1       1 > 2
  16-bit swap, inc/dec, 32-bit and, test for cmp: same cycles and uops,
  except one uop less for the 16-bit swap on Alder Lake

Daniel Borkmann (18):
  bpf, x86: Drop redundant REX prefixes from zero and sign extensions
  bpf, x86: Omit the displacement byte for zero offsets
  bpf, x86: Shorten the stack adjusts and the tail call counter loads
  bpf, x86: Use shorter test and cmp encodings for immediates
  bpf, x86: Compare against 0, 127 and -128 with the adjusted condition
  bpf, x86: Use movzx for byte and word masks and a not for xor with -1
  bpf, x86: Consolidate the ALU, shift and neg encodings into helpers
  bpf, x86: Use shorter and faster forms for some ALU immediates
  bpf, x86: Swap 16-bit values with bswap and shr, not ror and movzx
  bpf, x86: Use BMI2 shifts also when the count is in rcx
  bpf, x86: Fold the PROBE_MEM address computation into a lea
  bpf, x86: Compare the PROBE_MEM address range with a shift
  bpf, x86: Divide by constants via multiplication with a magic number
  bpf, x86: Multiply by 3, 5 and 9 with lea
  bpf, x86: Use emit_sub_rsp() for the trampoline stack
  bpf, x86: Shorten the cast to a user address
  selftests/bpf: Add JIT instruction tests
  selftests/bpf: Remove the old test_bpf module

 Documentation/bpf/bpf_devel_QA.rst            |    16 +-
 Documentation/networking/filter.rst           |    15 +-
 MAINTAINERS                                   |     1 -
 arch/m68k/configs/amiga_defconfig             |     1 -
 arch/m68k/configs/apollo_defconfig            |     1 -
 arch/m68k/configs/atari_defconfig             |     1 -
 arch/m68k/configs/bvme6000_defconfig          |     1 -
 arch/m68k/configs/hp300_defconfig             |     1 -
 arch/m68k/configs/mac_defconfig               |     1 -
 arch/m68k/configs/multi_defconfig             |     1 -
 arch/m68k/configs/mvme147_defconfig           |     1 -
 arch/m68k/configs/mvme16x_defconfig           |     1 -
 arch/m68k/configs/q40_defconfig               |     1 -
 arch/m68k/configs/sun3_defconfig              |     1 -
 arch/m68k/configs/sun3x_defconfig             |     1 -
 arch/powerpc/configs/ppc64_defconfig          |     1 -
 arch/s390/configs/debug_defconfig             |     1 -
 arch/s390/configs/defconfig                   |     1 -
 arch/x86/net/bpf_jit_comp.c                   |   720 +-
 kernel/bpf/core.c                             |     4 -
 lib/Kconfig.debug                             |    13 -
 lib/Makefile                                  |     1 -
 lib/test_bpf.c                                | 15934 ----------------
 tools/bpf/bpftool/feature.c                   |     3 -
 tools/testing/selftests/bpf/Makefile          |     3 +-
 tools/testing/selftests/bpf/config            |     1 -
 .../selftests/bpf/prog_tests/jit_insns.c      |  2433 +++
 .../selftests/bpf/progs/jit_insns_arena.c     |   113 +
 tools/testing/selftests/bpf/test_kmod.sh      |    73 -
 tools/testing/selftests/net/Makefile          |     1 -
 tools/testing/selftests/net/config            |     1 -
 tools/testing/selftests/net/test_bpf.sh       |    11 -
 32 files changed, 3098 insertions(+), 16260 deletions(-)
 delete mode 100644 lib/test_bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/jit_insns.c
 create mode 100644 tools/testing/selftests/bpf/progs/jit_insns_arena.c
 delete mode 100755 tools/testing/selftests/bpf/test_kmod.sh
 delete mode 100755 tools/testing/selftests/net/test_bpf.sh

-- 
2.43.0

