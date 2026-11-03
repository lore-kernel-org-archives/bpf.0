Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708866;
	b=oUh/wu8uAt7+8jGD9YguzPxHACq9WgpogK+r/L4JVJyYxRc2L6i9j7WeC67pl4WeITon
	 Q0F0Xa9jiXI3i/T1353ajaPFwnJn4YZAC6kVC56A++LBVOSXF+iFvKZAndYKyhZieezay
	 2ZNnekber0iugeEpXSiGWwxtFDURrsEttQQVeqmMgEZsJKfASKkbdSw6srUKwJKrvkFm/
	 MQH3OFVVkmqtqC3wzv6K7tMY3NdNYH1UrHljNp7mH6X/S4NIA/SCvWREn9CBa9JYtveKc
	 EytkTWGuJWwpqwq3FhqFYM0/Xg9wDLWEgSD5yJwOGGwsNskXPgX/A9hRkR5YIePSn0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708866;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=1e4HuC6qF2VZCRWPXvERuaWS53K/FbSafZk9mn8sVvg=;
	b=q3CQJKMsnkCZ6drdlDR9lBzB+vrv6qpVhF8F79Ak4fsvGLgA+3Wwbd0zgUcVQXzSkGqk
	 4gclroRuIrg6/hZ8URE29+P8S4vND3bcu9xFYLY68rL/pcLElgHGdZ93texhYM5/eQtU6
	 N9zKZTqQYl4H/kSO22o/bHdAe1TEjcUHIEYHwjTMhxWKNKbXMO7CzvONtNkl6Z/H+tiOT
	 tNyioSQ5xNZmQ8lc2VO5bLW+Zu64mDD1TQfFHE52pMvEbOxOHdfBGA8fUcUxeGBzptpf4
	 eJZrEw/DuwPxCzKDlnnmmcP3YrtQeFH96OpdfQhp6wMBWCNLREYYIcnkEa6M469FKHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=FbHb3flf;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8839606A33E
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8839606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=FbHb3flf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=1e4HuC6qF2VZCRWPXvERuaWS53K/FbSafZk9mn8sVvg=; b=FbHb3flfXDDhKdXQ8S0mfZDHlV
	p/svzvIWl3UejuXB8TXp+QGldlvciKxfHJRrLUWE5dS7NAyt1B1xKcrd4u02AAV5rCqFmNxDuMytT
	/LQVpqUbUQ/49FR5BBaCl2Wk/y2JKGxGAxA3YHDHZY2rlO4s2adpGY/Ut75lCI7h+u3wxjsXUTaBt
	HvtzE+/J8u06W98+pABSSJ2RdNiL+cZ2f0E8eLVQ9FgPcmg99X4oGWpOrDHPGJxWvBTaSWro8BoQp
	PebmXo2O5PyXnKr0pxPC4kZEpM0+QYNgVix//ZITIelDfeS6UHKdX+gjy4KkeVYmQisoJl8iBg8gi
	vIfitQog==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODby-000MQ5-0H;
	Tue, 03 Nov 2026 13:27:34 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 00/20] bpf: Various arm64 BPF JIT improvements
Date: Tue,  3 Nov 2026 13:27:13 +0100
Message-ID: <20261103122733.1383002-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

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
objects of Cilium (c3fbffb08183), Tetragon (31e646a5ed0c, the variants
for kernels from 6.1 on), Katran (623234e1814b) and the sched_ext
schedulers (scx at a40cb6115e68) were built with clang 20 for arm64, and
every program of them that loads (338, another 25 fail on both kernels)
was loaded with veristat in the arm64 VM of vmtest.sh, on a kernel
before and one after this series. The size is jited_prog_len, the cycles
and uops are those of the llvm-mca 20 models of the Neoverse N1
(Graviton2, Ampere Altra), N2 (Cobalt 100), V1 (Graviton3) and V2
(Graviton4, Grace, Axion) over the JITed images as straight-line code,
without the helper calls, which llvm-mca cannot model, and the LSE
atomics, which the models have no scheduling information for. This is a
static model without the path taken, branch prediction or cache misses,
but both sides get the same program, so the delta is what the series
rewrote. All numbers are averaged over two boots of each kernel, as a
map address with a zero 16-bit halfword takes one move less.

Project    Progs     Size  N1 cycles  N2 cycles  V1 cycles  V2 cycles  N1 uOps  N2 uOps  V1 uOps  V2 uOps
---------- -----  -------  ---------  ---------  ---------  ---------  -------  -------  -------  -------
cilium       160   -3.31%     -7.36%    -11.26%     -6.86%     -9.35%   -3.52%   -3.94%   -3.53%   -3.53%
katran         5   -6.41%     -7.53%     -9.07%     -8.57%     -0.36%   -6.35%   -8.44%   -6.39%   -6.38%
scx           99   -5.95%     -7.63%     -6.60%     -7.11%     -5.43%   -5.91%   -4.79%   -6.06%   -6.02%
tetragon      74   -4.23%     -5.83%     -5.92%     -6.30%     -3.31%   -4.46%   -4.63%   -4.51%   -4.50%
all          338   -3.88%     -6.88%     -9.01%     -6.71%     -6.91%   -4.08%   -4.30%   -4.11%   -4.10%

Cilium gains the most cycles from its 355 divisions by NSEC_PER_SEC in
81 programs, which come from the monotonic clock helper that conntrack,
NAT and the load balancer run for every entry: all four models put a
64-bit udiv at 20 cycles against 11 to 13 for the magic number sequence,
and the N2 and V2 models do not pipeline the divider at all. The
schedulers have 14 divisions in 7 programs, mostly by 100 and 1000000.
The rest of the cycles and most of the uops come from the branches:
12711 compares against zero and their branch become a cbz or cbnz, and
2961 sign and bit tests a tbz or tbnz, a uop and a cycle each. Then 979
loads and stores take the unscaled form, 505 xors with all ones become a
mvn, 482 stores of zero take the zero register, 187 tail calls lose six
instructions each, and 98 multiplications become an add or sub with a
shifted register. Katran stays flat on V2, whose model dispatches 16
wide.

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
  44:    540001a2     b.hs   #52
  48:    f940034c     ldr    x12, [x26]
  4c:    f100859f     cmp    x12, #33
  50:    54000142     b.hs   #40
  54:    9100058c     add    x12, x12, #1
  58:    9108802a     add    x10, x1, #544
  5c:    f862594b     ldr    x11, [x10, w2, uxtw #3]
  60:    b40000cb     cbz    x11, #24

Of the 338 programs, 303 get smaller, and 284, 270, 277 and 225 faster
on N1, N2, V1 and V2. The best cases:

  Impact     Largest decrease                                    Largest relative decrease
  ---------  --------------------------------------------------  ------------------------------------
  size       generic_usdt_filter_arg      27388 > 26256  -4.13%  pandemonium_enable 280 > 224 -20.00%
  N1 cycles  tail_handle_ipv6                922 > 807 -12.52%  flash_select_cpu     74 > 53 -28.38%
  N2 cycles  tail_handle_ipv6                760 > 605 -20.39%  flash_enqueue       179 > 98 -45.25%
  V1 cycles  tail_handle_ipv4                542 > 471 -13.10%  flash_select_cpu     66 > 41 -37.88%
  V2 cycles  tail_handle_ipv6_from_netdev    441 > 339 -23.13%  flash_enqueue       147 > 67 -54.42%

The largest gains in cycles are in Cilium's bpf_lxc.o and bpf_host.o,
whose programs above hold 7 to 11 of the divisions by NSEC_PER_SEC each,
and in Tetragon's generic_usdt_filter_arg for size, which turns 243 of
its 961 conditional branches into a cbz, cbnz, tbz or tbnz. The scx_flash
programs gain the most relative to their length, from their divisions by
100.

No project gets bigger or slower on any model. The worst cases per
program, which for the cycles are the same in every pairing of a boot
before with one after the series:

  Impact     Worse  Largest increase                             Largest relative increase
  ---------  -----  -------------------------------------------  ---------------------------------
  size           3  flash_select_cpu            616 > 640 +3.90%  the same
  N1 cycles      1  rusty_set_weight              42 > 43 +2.38%  the same
  N2 cycles      1  rusty_set_weight              37 > 38 +2.70%  the same
  V1 cycles      2  rusty_stopping                92 > 94 +2.17%  rusty_set_weight   37 > 38 +2.70%
  V2 cycles     10  tail_nodeport_nat_egress_ipv4 295 > 301 +2.03%  mitosis_dump_task 49 > 52 +6.12%

Of the three programs that grow, flash_select_cpu and flash_enqueue of
scx_flash do so by 24 and 16 bytes for their divisions by 100, and
tail_drop_notify of Cilium's bpf_xdp only in one pairing of boots. None
of the 12 programs that some model rates slower has more instructions;
their changes are compares and branches that became a cbz or cbnz, which
the model then issues in another order. The uops grow in 3 programs, 4
on N2, by at most 2.86%.

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
  tail call slot of w3          9>8 4>2     9>8 5>3     9>8 4>2     9>8 4>2

Thanks,
Daniel

v1 -> v2:
  - Share the divisor selection with x86 via bpf_magic_div() in the core
    instead of copying it into the arm64 JIT (Alexei)
  - tailcall: ldr x11, [x10, w2, uxtw #3] in place of ubfiz + ldr, with
    a scaled flag in the register offset encoder (Xu)
  - tbz/tbnz decided once in pass 2 from the sizing pass offsets, no
    repeated sizing passes (Alexei)
  - Dropped the 24-bit immediate split which was 4 bytes for a cycle
    of latency (Alexei)
  - Arena acquire/release test insns built with __imm_insn() (bpf ci bot)

  [0] https://lore.kernel.org/bpf/20261013171230.523677-1-daniel@iogearbox.net/

Daniel Borkmann (20):
  bpf, arm64: Free the offset table of a subprog in bpf_jit_free
  bpf, arm64: Free the private stack when a pass over the image fails
  bpf, arm64: Emit ISB SY in the speculation barriers
  arm64, insn: Reject sign extending loads of 64 bits
  bpf, arm64: Keep the ll/sc atomics address apart from the old value
  arm64, insn: Add the LDUR/STUR and TBZ/TBNZ encodings
  bpf: Move the division magic number selection out of the x86 JIT
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
  selftests/bpf: Let the arm64 private stack check skip the BTI pad
  selftests/bpf: Extend the JIT instruction tests for arm64 encodings

 arch/arm64/include/asm/insn.h                 |  30 +-
 arch/arm64/lib/insn.c                         | 144 +++
 arch/arm64/net/bpf_jit.h                      |  40 +-
 arch/arm64/net/bpf_jit_comp.c                 | 911 +++++++++++++-----
 arch/x86/net/bpf_jit_comp.c                   | 163 +---
 include/linux/filter.h                        |  12 +
 kernel/bpf/core.c                             | 147 +++
 .../selftests/bpf/prog_tests/jit_insns.c      | 604 ++++++++++--
 .../selftests/bpf/progs/jit_insns_arena.c     | 446 ++++++++-
 .../selftests/bpf/progs/verifier_ldsx.c       |  24 +-
 .../bpf/progs/verifier_private_stack.c        |   1 +
 11 files changed, 2076 insertions(+), 446 deletions(-)

-- 
2.43.0

