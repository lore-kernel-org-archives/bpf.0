Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415793;
	b=UF9YE2wrrIVtnq46oLAWRhj05/8uUckpHYQ0QA4G+rYcbo94UmOcxO1nDOIR8x7izLdx
	 USQTgXgEqpB3puqSho7PZGnLSp66RdsYZFPzAdBlTHLkYNcedrJml8SauR07/OM2E3WVc
	 eQl5zSu7iet2ui72SfOuL4AOfIRyOFLRIzFUqT2A6qgHYjEbDeWD4FPk5EkiK6npVkUuw
	 dKkiQ0r0kZAOQ2hEDjcBCtg9e5cHPvZkUr025DviHhyTC+9b/RwsVAtlKoXudyDQ3VP76
	 vs0qI+4Rt/HQKTMP5+x1m5pKVBCtSuUpDWmXC9sNyVqQhjnpqIkLk3yyxTIasalK3eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PghDBf4kIJEJwuuv67hZ591s9lbDxPiJh14ZGhqeiLw=;
	b=zuz6HlQNJylFwBg1jV5o5bnZu4oqtD6pflfamWFeXnklQ/FHZeiiju0zo0tGik2uzo7R
	 X4I1/dASVq/6yedDPzChrvdH11UA6ux3O2Ak1NyuRZHwMHAEoUt7tLfNVd5X8snlKhSHi
	 wKY6+iWKnriiWIHqEouHTz9FKm2/6xMg9qg2l6TunChVN1yFM8vFsxKPHTvav6M4ehbwj
	 Q0Tu3W7kAXw1s/71K4YchnaEcjE+jJedvindT0QyW+ktvDvD8eQmPr6thOig1pHSrQeZa
	 lAFaAyy3pbQF0DvwbBujVNUAbDje8ru+QWndYzDfSMPIKKhiiCkUImGcv6dOP+UzLNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SlWN15Y5;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F0606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559F0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SlWN15Y5
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a07078200fso1381103b3a.2
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415793; x=1795020593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PghDBf4kIJEJwuuv67hZ591s9lbDxPiJh14ZGhqeiLw=;
        b=SlWN15Y5emdxV/cJJKJwK9AYENaWSd50enV3HNnzTlNLgIVPgKVNLhrmD3SVANFxkf
         4hs9VCPqYmoEwNowdfjWZtzfxRB5ovrs0FHyDrWn1gWKhD66YBSukNlQu2ObHVHbQmXM
         8W+DIgEtI1rEDOGp/D/epau9aaTzoIqSxIRGLuw1yudUn0Embafi2Y6cc+v3kMkhqFFu
         5OhgCyr/h5uF45gQ1NiOmeGOsciRoWbuXboCFDslC/VFdNDc/tE1qYSZXOoMLQLwPrSC
         o5PEW4o5osZUAfWwFInT614iSBcvVm2IbEiMwU9VkRTuko4I1611xvapWskkx8nZBC3f
         JTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415793; x=1795020593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PghDBf4kIJEJwuuv67hZ591s9lbDxPiJh14ZGhqeiLw=;
        b=Tp4KgWnbPLQhzmuRGCmsTKte84HvWZh5THkSIbjuzwMlHiD7Nig28xz9ac7TsUsSvk
         NOayZy2b4sr7ApUFrNytIn+mr64OShoDUWPp9v1/a42HyCA/aL8t7nEwgOcfWKArWAlo
         Z50HOtZwIXy318TyAcNSpL3wxhxYEsS+JMjK2qUhqLm7XQVX58sHS3FVw77mJEOVl+rU
         0C0hk0FOssfIdVQ6EZ3dPWM94aQKOGAx6yiz8W5TyKa0jSG3DydNVohPSgxz6LoIma9B
         EFexVIc38/5JdjjgKjLH0Bp6lL8/m3FEvmtiwXBmQtbcqE5DDRKiTATasI7R4t0eaMSc
         GMlQ==
X-Gm-Message-State: APuU4Z9yN5ef3hCoxR97O2jaPY1RNkVzagn/dfSX0KdHe8mrR6cPSz4S
	pKGLjk/aVu8QyWe6pbAr/ld/32rKW61FaWvL5d/9zht2zhazTQDjyxJ0VboS2w==
X-Gm-Gg: AYBFou2EFzd3s5dcZRx6Adr5OuiA84BM7ID2qnar457+QGaXEVRXsW1ODS8ohdTdNCz
	aPoxmF2IhbT0So/24P2MYlH1gGzFz8khHST+xkJE6+d/2yHCdy+lXNoy4tVSOcnhI2o5QILr14L
	GPIG6JmHHJBExwC7eSXIQO9PHKnRBhIHksdARKYIReO/iXbv5grmRvK3uLSP895TPWcQsvZKNG8
	i7jFOVf+MekYrSFSW+sdPWzuzWkM3+EQdYy9tUF3ayVHj0YqqaXzjJCRAsm7wVMl/NwoqsZIFgf
	2cog4iIEa3kXzcbxANo/WuxUsAzI41nq5KmgK6jZIkmYjeZv69u7h7qBYEDBFyg/iYY+T4koXph
	KtQ22BMYzgp1EcZxwmyPFojdOvazyzwwDEE0naLRYn76uYQKR5YRrrJSO5yYoGNEzWPPqWsn/hY
	ItF8I9GIKq1ie/00vzQapvyILYlri2tljcv0N69/nxxSeBnVNyoClX49tHOc8HewVaMNFysPM1X
	4Oqa0GCQJOz/V5PsUirY0ZZeh3sPqxQT7Xdvkfjs/wcO2Zkpgn8oQBuAV/O7Fvd+qPV48+JQcQP
	5wFIAuMyD8Tk5KLp1/k85g4RcwXuvkpaNpj+ZNqmuC8lGh1p1Gzqg1pCMnt876VuUkPvCsMvivb
	PXp9XZk9D0/Mj7WgrL4wB4XdVim2tXNaZZB8reAzdg5+1rS0UIEluEZbaqJFpx3fljNAGoVVAph
	A=
X-Received: by 2002:a17:903:244f:b0:2e9:2a1a:8b69 with SMTP id d9443c01a7336-2edd7a96d13mr31464315ad.55.1794415792353;
        Wed, 11 Nov 2026 08:49:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a412bbsm22529175ad.2.2026.11.11.08.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:49:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/6] bpf: struct scalar, and one backedge-taken count on it
Date: Wed, 11 Nov 2026 16:49:43 +0000
Message-ID: <20261111164950.2674588-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

Eduard asked three things about the code in scev.c that counts the
iterations of a loop:

 1. Can struct scev_value be a cnum64 and a cnum32, in place of eight
    open coded bounds?
 2. Why are there two functions, compute_backedge_taken_count() for
    constants and compute_backedge_taken_max() for ranges? He suggested
    to compute on cnum: no bias, no struct latch_domain, one function,
    one way to handle 32 bits.
 3. Extract cnum64, cnum32, tnum, base and step from struct bpf_reg_state
    as struct scalar, with a set of arithmetic operations, and move scev.c
    to this abstraction.

This series does the three. It applies on top of "bpf: Find linked
registers by scalar evolution, remove scalar ids" v3.

  1  cnum: const, sub, zext32, sext32          no functional change (*)
  2  struct scalar                             no functional change
  3  five operations on it                     no functional change (*)
  4  scev.c on struct scalar, one function     cleanup, precision
     for the count
  5  '!=' with a step that is not 1            precision
  6  tests
 (*) but for an empty range, which stays empty

struct scalar is an anonymous member of struct bpf_reg_state: reg->r64
stays reg->r64, a register keeps its 80 bytes. What scev.c needs takes a
struct scalar: scalar_add(), _set_const(), _set_unknown(), _zext32(),
_union(), each verifier.c's own code with another type of parameter.
'a + b' was written six times and is written once. 66 functions still take
a register. A script can convert them, not in this series. scev.c loses
218 lines.

These loops are rejected today and load (clang -mcpu=v4, buf is a map
value of 64 bytes, data has 4096 bytes, rec has 12 bytes, n is 0..16):

	for (char *p = buf + 56; p >= buf; p -= 8)
		*p = 0;
	for (u32 i = bpf_get_prandom_u32(); i < 64; i--)
		buf[i] = 0;
	for (long i = bpf_get_prandom_u32(); (u32)i < 64; i++)
		buf[i] = 0;
	for (u64 off = 0; off != (len & 0xff8); off += 8)
		sum += *(u64 *)(data + off);
	for (u32 o = n * sizeof(struct rec); o != 0; ) {
		o -= sizeof(struct rec);
		sum += *((u8 *)recs + o);
	}

What changes in behaviour is listed in patches 4 and 5. A loop with a
count gets no may_goto, and more loops have a count, of up to 2^32. A
count can cost insns: beside a variable without a linear form, like
'off += ids[i] & 63', the iterations are kept apart up to the count:
90 -> 247 insns for 32 iterations. And it can cost programs. A loop with a
count is summarized: each induction variable is 'initial + step * count'.
The count of one exit can be far above what another exit allows, one that
has no count:

	long n = bpf_probe_read_kernel_str(e->comm, 16, src);
	if (n < 0)
		return 0;
	u32 i = n;			/* 0..16 for the verifier */
	while (i-- > 0) {		/* clang: '2 * i != 0', step -2 */
		sum += e->offs[i];
		if (off + 256 > 4096)	/* clang: (u32)(off - C1) < C2 */
			break;
		bpf_get_current_comm(e->data + off, 16);
		off += 16;
	}

Today no exit of this loop has a count, its iterations are verified one
by one and it loads. Since patch 4 the test of 'off' has a count, 242,
2 * i is -480..32 and the load from e->offs[] is rejected. Patch 5 counts
the latch: 16. The loop loads again, and it loads with 'off > 3840', which
is rejected today.

Patch 5 does not reach each such loop: a latch on the low 16 bits of a
register ('u16 i') has no count, a flag or a conditional increment beside
a variable that has a count since patch 4 has no summary. A loop of one of
these shapes that loads today can be rejected. No program of the projects
below is lost.

The counting code and the operations of struct scalar and of cnum were
compiled in user space with u64 of 4 to 6 bits and u32 of 2 or 3 bits, and
the loops were run: each op, step, range of initial values and of bounds,
64 and 32 bits and their mixtures, pointers. Without a congruence, at 5
and 3 bits: 7.95 G cases, all of them. With one: 534 G, all at 4 bits, a
sample at 5 and 6 bits. No count, false_until or range is wrong, patch 5
loses no count. Of 160 M random loops at 64 and 32 bits the 39.5 M with a
count of up to 300 were run: each value at the header is in r64, r32 and
on the line of base and step.

Patches 2 and 3: 26402 progs of the selftests
(clang in three flavours, GCC) have the same verdict, insns, states and
peak states. The level 2 logs of 26272 of them, 24.5 M lines, are the same
but for BTF ids and kernel addresses.

veristat against the tree before the series. Tetragon, Tracee, Falco, the
Datadog agent and more than 70 other public projects, the set of v3's
cover: 1105579 progs, 1058728 load, not one verdict, number of insns or
number of states changes. In 33216 more progs no verdict changes:

                       progs   load     insns    states
  selftests, clang     18810  11757   -0.53 %   -1.13 %
  selftests, GCC        6011   3673   -0.01 %   -0.01 %
  Cilium                5496   5490    0.00 %    0.00 %
  sched_ext             1272   1163    0.00 %    0.00 %
  katran, bpfjailer      538    511    0.00 %    0.00 %
  Rust                  1089   1081   -0.96 %   -1.09 %

Cilium has two more weekly builds than in v3's cover. In C
trace_netif_receive_skb changes, 14519 -> 3505 insns, and two asm tests.
In Rust 242 programs change, 165 of them sched_ext schedulers. Two get
worse: float_fmt_display 66118 -> 70018 insns,
float_fmt_precision 65296 -> 69196.

To load the C programs, those in Rust, Tetragon, Tracee and Falco the
kernel spends -0.19 % to +0.03 % instructions (perf stat, two passes of one
kernel differ by up to 0.3 %). Load time changes by -0.92 % to -0.11 %,
mem_peak of the 1105579 progs by +0.01 %.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (6):
  bpf: Add const, sub, zext32 and sext32 operations to cnum
  bpf: Add struct scalar
  bpf: Add scalar_add() and four more operations on struct scalar
  bpf: Compute the backedge-taken count on cnum, in one function
  bpf: Count a '!=' latch if the step divides the distance
  selftests/bpf: Test the backedge-taken count on struct scalar

 include/linux/bpf_verifier.h                  | 124 ++-
 include/linux/cnum.h                          |   8 +
 kernel/bpf/cnum.c                             |  45 +
 kernel/bpf/cnum_defs.h                        |  11 +
 kernel/bpf/flow.c                             |  26 +-
 kernel/bpf/join.c                             |  24 +-
 kernel/bpf/scev.c                             | 938 +++++++-----------
 kernel/bpf/states.c                           |   8 +-
 kernel/bpf/verifier.c                         | 193 ++--
 .../selftests/bpf/progs/verifier_loop_latch.c |   6 +-
 .../selftests/bpf/progs/verifier_scev.c       | 146 ++-
 11 files changed, 754 insertions(+), 775 deletions(-)

-- 
2.55.0

