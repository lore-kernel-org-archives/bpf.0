Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125490;
	b=llEFqGpVdPr2DNJkLXGHt7qzvkNjeggN+oS5VN5OE+n5nJAKulqY0b+FMk6/F6XZohIa
	 10QLp8/ZdVsXkwfmZruMZljOWG8CpS2tprarF9aRkGtfMiDqkoielEdgRM6Bz1jmM/PQg
	 XK1dvbH3fERr8pDTDvI+G3W+jfvgZM41m2aptdCKPiVGaf3VvATgg65eJJR8tYTNRXBRp
	 RiyZpbiwbO2GLeeyT/Z9NY6u+orl0BxzfTG4cbwC0YBdNnlDS4FocVEl1PC0tS4Iqo8vf
	 qzzJxWvmy2ZoVC8jsb82tWIixJuBLHI8L+ewW9i1N8V6TdcWjFFq+WJEkBNUuec3JCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125490;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=oVk9kZCk+OuNiHjWDCVE619CURDfZzsf3I+7hWvz0gM=;
	b=GrWLR/4pRfuPdrRlfYoakIjcgrQ36Ap+9jPE16iVfZpWlc/SZu1ALYISoASX6cXEZGIm
	 drI+eM20DlgZEtgEbgr/OFufwx6EDCPL2sUZUQ/Q90iUpx3iComgFW74TZQUCidW3cBDR
	 tUMN2fwi8HXE6/sAw6FhukuSM/Oojm5Uh5ZeIywbtCtGc1QN8/806mbAJt/DMroxWeLgU
	 fe+2apb/SZUo29LELU7HdTmMZzCTCRemeCMcOllnTBkqcGfd0sVUlxLZ86GstXasUggOG
	 oxCdGXR4XtV6zfaV6ITCmEQy2ZtdgREcF/K0wZoegP4/JwRYgydXl96RfPV/ZGXP6Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b="EmYFv/KK";
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775BF606A31E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 775BF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=EmYFv/KK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=oVk9kZCk+OuNiHjWDCVE619CURDfZzsf3I+7hWvz0gM=; b=EmYFv/KKHISzQ9g0oUPHMlCBaJ
	EsHSmuCkf5tY4Yv9wQlmd1CSMYfEB+lKR60kNs5oNLLa94As7dx/2cLSpjETkNrg0ScEMftA+w6LG
	bKIDlIvljkj1j0mtvO2AeldP0aKb0lB6YdmlPp02IO78whoPHNsFc2iKoL4PvpZf1PrFhF/IXQiCa
	3+TEv9Q9DbkIJbV9d8F970gDofFCaZVtG6CUuOmVTyrFVaRSysWlo69b8fniHiAXyC9Qq8olow46O
	ojfewDgmjVBDukT4ytc6mmgJLT1XmZhlMI0fvpiDxGLvChMyRAAIsp3apfUIx8U55drEZ45bTt49X
	dYHa9lHA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqo-000Ii1-0M;
	Tue, 27 Oct 2026 19:24:46 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 00/21] bpf: Various arm64 BPF JIT improvements
Date: Tue, 27 Oct 2026 19:24:24 +0100
Message-ID: <20261027182445.1156335-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

This series changes the arm64 BPF JIT to emit shorter and faster native
code for the instruction patterns that LLVM-compiled programs hit in the
real world. Every change stays within the lowering of a single BPF
instruction. This is a similar effort as done recently for x86-64 BPF
JIT [0].

On arm64 under vmtest.sh (qemu TCG), test_verifier, test_maps, jit_insns
and jit_insns_blinded pass in full, and test_progs and its cpuv4 and
no_alu32 flavors only fail tests that fail without the series as well
or only under TCG. The encodings were checked against Arm's machine-readable
A64 ISA XML: every A64_* macro and directly called encoder, run with
boundary and invalid operands (39028 cases), gives the encoding and
fields the Arm ARM expects or AARCH64_BREAK_FAULT for what it cannot
encode.

To see what the series does to code that is actually deployed, the BPF
objects of Cilium (7c11a349512b), Tetragon (3f20b90ee580), Katran
(2cd783e43a07) and the sched_ext schedulers (scx at fead94e15184 plus
tools/sched_ext) were built with clang 20 for arm64, and every program
of them that loads (817, another 121 fail on both kernels) was loaded
with veristat in the arm64 VM of vmtest.sh, on a kernel before and one
after this series. The size is jited_prog_len, the cycles and uops are
those of the llvm-mca 20 models of the Neoverse N1 (Graviton2, Ampere
Altra), N2 (Cobalt 100), V1 (Graviton3) and V2 (Graviton4, Grace, Axion)
over the JITed images as straight-line code, without the helper calls,
which llvm-mca cannot model, and the LSE atomics, which the models have
no scheduling information for. This is a static model without the path
taken, branch prediction or cache misses, but both sides get the same
program, so the delta is what the series rewrote. All numbers are
averaged over two boots of each kernel, as a map address with a zero
16-bit halfword takes one move less.

Project    Progs     Size  N1 cycles  N2 cycles  V1 cycles  V2 cycles  N1 uOps  N2 uOps  V1 uOps  V2 uOps
---------- -----  -------  ---------  ---------  ---------  ---------  -------  -------  -------  -------
cilium       160   -3.37%     -7.69%    -12.10%     -6.81%     -9.58%   -3.10%   -3.47%   -3.11%   -3.11%
katran         5   -6.41%     -6.78%     -8.54%     -7.48%     -0.18%   -5.62%   -7.48%   -5.65%   -5.64%
scx          391   -6.67%     -8.43%     -5.62%     -5.54%     -4.19%   -5.81%   -4.39%   -5.93%   -5.90%
tetragon     261   -2.62%     -3.19%     -3.76%     -3.79%     -2.13%   -2.54%   -2.61%   -2.54%   -2.54%
all          817   -3.22%     -4.70%     -5.54%     -4.58%     -4.16%   -3.06%   -3.00%   -3.07%   -3.07%

Cilium gains the most cycles from its 417 divisions by NSEC_PER_SEC in
89 programs, which come from the monotonic clock helper that conntrack,
NAT and the load balancer run for every entry: all four models put a
64-bit udiv at 20 cycles against 11 to 13 for the magic number sequence,
and the N2 and V2 models do not pipeline the divider at all. The
schedulers have 78 divisions in 35 programs, mostly by 100 and 1000000.
The rest of the cycles and most of the uops come from the branches:
38341 compares against zero and their branch become a cbz or cbnz, and
6173 sign and bit tests a tbz or tbnz, a uop and a cycle each. Then 2698
stores of zero take the zero register, 1171 loads and stores the
unscaled form, 707 xors with all ones become a mvn, 316 multiplications
shifts and adds, and 222 adds, subs and compares take an immediate
shifted by 12 in place of a move. Katran stays flat on V2, whose model
dispatches 16 wide.

For a feel of the native code, the tail call of Katran's xdp_root
program, from the bounds checks to the test of the program slot.

Before:

  3c:    5280088a     mov    w10, #68
  40:    b86a682a     ldr    w10, [x1, x10]
  44:    2a0203e2     mov    w2, w2
  48:    6b0a005f     cmp    w2, w10
  4c:    54000222     b.hs   #68
  50:    5280042a     mov    w10, #33
  54:    f940034c     ldr    x12, [x26]
  58:    eb0a019f     cmp    x12, x10
  5c:    540001a2     b.hs   #52
  60:    9100058c     add    x12, x12, #1
  64:    5280440a     mov    w10, #544
  68:    8b0a002a     add    x10, x1, x10
  6c:    d37df04b     lsl    x11, x2, #3
  70:    f86b694b     ldr    x11, [x10, x11]
  74:    b40000eb     cbz    x11, #28

After:

  3c:    b940442a     ldr    w10, [x1, #68]
  40:    6b0a005f     cmp    w2, w10
  44:    540001c2     b.hs   #56
  48:    f940034c     ldr    x12, [x26]
  4c:    f100859f     cmp    x12, #33
  50:    54000162     b.hs   #44
  54:    9100058c     add    x12, x12, #1
  58:    9108802a     add    x10, x1, #544
  5c:    d37d7c4b     ubfiz  x11, x2, #3, #32
  60:    f86b694b     ldr    x11, [x10, x11]
  64:    b40000cb     cbz    x11, #24

Of the 817 programs, 715 get smaller, and 640, 601, 587 and 467 faster
on N1, N2, V1 and V2. The best cases:

  Impact     Largest decrease                                    Largest relative decrease
  ---------  --------------------------------------------------  ------------------------------------
  size       generic_sleepable_preload    30192 > 28292  -6.29%  pandemonium_enable 280 > 224 -20.00%
  N1 cycles  cil_to_netdev                  1331 > 1172 -11.95%  flash_select_cpu     73 > 53 -27.40%
  N2 cycles  tail_handle_ipv6_from_netdev    1070 > 828 -22.62%  flash_enqueue      202 > 118 -41.58%
  V1 cycles  generic_sleepable_preload      1118 > 1000 -10.60%  flash_stopping       65 > 49 -24.62%
  V2 cycles  tail_handle_ipv4_from_netdev     713 > 495 -30.58%  flash_enqueue       187 > 85 -54.55%

The largest gains in cycles are in Cilium's bpf_host.o, whose programs
above hold 14 to 21 of the divisions by NSEC_PER_SEC each, and in
Tetragon's generic_sleepable_preload, which turns 451 of its 667
conditional branches into a cbz, cbnz, tbz or tbnz. The scx_flash
programs gain the most relative to their length, from their divisions by
100.

No project gets bigger or slower on any model. The worst cases per
program, which for the cycles are the same in every pairing of a boot
before with one after the series:

  Impact     Worse  Largest increase                      Largest relative increase
  ---------  -----  ------------------------------------  ----------------------------------------
  size           3  flash_select_cpu  616 > 640  +3.90%   the same
  N1 cycles      5  rusty_stopping    133 > 135  +1.50%   pandemonium_cpu_offline   17 > 18  +5.88%
  N2 cycles     15  bpfland_stopping   47 > 50   +6.38%   the same
  V1 cycles     16  lavd_running      746 > 751  +0.67%   scx_pmu_switch_tc         76 > 80  +5.26%
  V2 cycles     30  fcg_runnable      114 > 119  +4.39%   mitosis_set_cpumask       53 > 57  +7.55%

Of the three programs that grow, flash_select_cpu and flash_enqueue of
scx_flash do so by 24 and 16 bytes for their divisions by 100, and
simple_enable only in one pairing of boots. None of the 51 programs that
some model rates slower has more instructions; nearly all their changes
are compares and branches that became a cbz or cbnz, which the model
then issues in another order. The uops grow in 3 programs, 7 on N2, by
at most 4.12%.

The rewrites on their own, in llvm-mca for one instance of each sequence
as the JIT emits it, in a single pass with the pipeline fill included.
An arena access at an immediate offset keeps its cycles, the add of the
offset now off the path of the offset register, at a uop more on N2.

  cycles, uops                N1          N2          V1          V2
  r2 /= 1000000000            25>13 3>7   25>11 3>7   25>11 3>7   25>11 3>7
  r3 /= 100                   24>13 2>7   24>11 2>7   24>11 2>7   24>11 2>7
  if r6 == 0 goto               5>4 2>1     5>4 2>1     5>4 2>1     5>4 2>1
  if w0 s< 0 goto               5>4 2>1     5>4 2>1     5>4 2>1     5>4 2>1
  w2 = *(u32 *)(r8 + 6)         8>7 2>1     8>7 3>1     8>7 2>1     8>7 2>1
  arena r0 = *(u64 *)(r9 + 0)   8>7 2>1     8>7 2>2     8>7 2>1     8>7 2>1
  *(u64 *)(r1 + 0) = 0          5>4 3>2     5>4 3>2     5>4 3>2     4>4 3>2
  w1 ^= -1                      5>4 2>1     5>4 2>1     5>4 2>1     5>4 2>1
  r0 *= 24                      8>5 2>2     6>5 2>2     6>5 2>2     6>5 2>2
  w1 *= 65537                   7>5 3>1     7>5 3>1     7>5 3>1     7>5 3>1
  if w2 > 0xffff goto           6>5 3>2     6>5 3>2     6>5 3>2     6>5 3>2
  tail call slot of w3          9>8 4>3     9>8 5>4     9>8 4>3     9>8 4>3

Thanks,
Daniel

  [0] https://lore.kernel.org/bpf/20261013171230.523677-1-daniel@iogearbox.net/

Daniel Borkmann (21):
  bpf, arm64: Free the offset table of a subprog in bpf_jit_free
  bpf, arm64: Free the private stack when a pass over the image fails
  bpf, arm64: Emit ISB SY in the speculation barriers
  arm64, insn: Reject sign extending loads of 64 bits
  bpf, arm64: Keep the ll/sc atomics address apart from the old value
  arm64, insn: Add the LDUR/STUR, UMULH/SMULH and TBZ/TBNZ encodings
  bpf: Move the division magic number computation out of the x86 JIT
  bpf, arm64: Consolidate the load and store emission into a helper
  bpf, arm64: Use the unscaled forms for negative and unaligned offsets
  bpf, arm64: Store zero immediates from the zero register
  bpf, arm64: Zero extend the arena offset in register offset accesses
  bpf, arm64: Adjust compares with unencodable immediates by one
  bpf, arm64: Materialize immediates with fewer instructions
  bpf, arm64: Shorten the tail call sequence
  bpf, arm64: Divide by constants via multiplication with a magic number
  bpf, arm64: Use a move or mvn for the and and xor with all ones
  bpf, arm64: Use cbz, cbnz, tbz and tbnz for zero, sign and bit tests
  bpf, arm64: Multiply by constants with shifts, adds and subs
  bpf, arm64: Split 24-bit immediates of add, sub and equality compares
  selftests/bpf: Let the arm64 private stack check skip the BTI pad
  selftests/bpf: Extend the JIT instruction tests for arm64 encodings

 arch/arm64/include/asm/insn.h                 |   33 +-
 arch/arm64/lib/insn.c                         |  147 +++
 arch/arm64/net/bpf_jit.h                      |   38 +-
 arch/arm64/net/bpf_jit_comp.c                 | 1018 +++++++++++++----
 arch/x86/net/bpf_jit_comp.c                   |   97 --
 include/linux/filter.h                        |   11 +
 kernel/bpf/core.c                             |   93 ++
 .../selftests/bpf/prog_tests/jit_insns.c      |  418 ++++++-
 .../selftests/bpf/progs/jit_insns_arena.c     |  381 +++++-
 .../selftests/bpf/progs/verifier_ldsx.c       |   24 +-
 .../bpf/progs/verifier_private_stack.c        |    1 +
 11 files changed, 1865 insertions(+), 396 deletions(-)

-- 
2.43.0

