Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442120;
	b=d8E1W8T/YSoakFMC/rKOqBEqZte8K1qP5EJTsXMcnbUm0c6sYZ1gTxVMxZKm0ruo3iDC
	 Uv1wwIaP9/nxkCWjAh6ASRtBjy4eIvmaMQK7YNfnZxWNX/7yz5V1XdfdBs+wR8OUhdRfb
	 1dQfTlAt5GAxwMhunnb9+roGXFRB69PDqKIUbEzHu5LMnDGvHDGELuTE20d1BqtpFp9eS
	 KjAdXsJ9BIc3VjCZQEmLgQTNGpQJXv75Bdrn3Vs76xg+rxIgnACH5WCUaSC/pYjPS11mh
	 TiUloS2xKb4mdp3iB4l8qrukztQhDC8NYt2RLNbT1ubscflqlFjGsskZ9I5TleCYuGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=d/FBU/21WpE5f6YGA3ntN/C1akP7qq2R2YB1rM/tvh4=;
	b=lhm1VuELVn00OTD0mAOYkUoCF6iZkROn08D0f8oEZPjIdzBbRDCgjgoD26veUkITiB5o
	 Fq0K9llPP8QcCOWxAtpUljE8lULUVHfCtRGqApeag8eiJvM+E8YRpZjBHLX+dOubF73k1
	 loyjRxSisgzbS4/WVCcPjaeqjhkkof2MDZ7l7eXU56/NONWu1sNSUwrunV+6IjkCHv0Pd
	 rwkKBXvBAYMD5PxL7E1U8siGh2FPFFL4K7c4Lt46WK0PmBR4v8zYxeFwDMfxjKd01NzOL
	 Ngez8XxYn/SR+kG6Ax2vrG8mDtD6PPc9TwXIAUgECMfk+qRHZhfoS2uuAy3eQADOfBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mm0pHWNU;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3C606A31C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 00:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EE3C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mm0pHWNU
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso2583416a12.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442119; x=1795046919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d/FBU/21WpE5f6YGA3ntN/C1akP7qq2R2YB1rM/tvh4=;
        b=Mm0pHWNU1xWGWclCgy/RrCqKm4/UjDJbTBoE8u629Yvo2v90G/w/d+Og+e8xuUbDNW
         E59kcft45p0Bfa4W1aYI5uINBkzRCiLpH1pPsNjxBFaBNS5LjdLi+PceJ4bkrZo371SX
         nYa32CwlXGGK/KI3sGcx75+g1K0BWdjgng+yQh8nAG8/e/B+UVZ2csFnb/LIiGaZXklr
         ZkTDXHkv9siSYUggimJiQVVEyoCpB2VtZqdq6hoRVt4CxVxmgqe+gWxVGhrN1TQVE9zd
         LekS14c3QVaQqBC/XrsC0GxNbnLAAIUCW39UIYBH7mpvRk/TZjuMPAiNmqElx8caold+
         LWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442119; x=1795046919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d/FBU/21WpE5f6YGA3ntN/C1akP7qq2R2YB1rM/tvh4=;
        b=ePl2jSjnjOl3x123LgmoRdabZgEUOgLzCHfAw+8kogir5OmCkaLeRoNc3xO9twR2qj
         QYwmVXs1ar8hH0j+/8FI8cog3zdaJ0ICQ5sJio8tANpcUa6xgOJ59J3mjfc6ouCcCPP7
         6kV6fX5ATEW7ounJBTO72Run/Net4nHVQpeXfxP+Qy6fIIosPOWBquq9cBg0x66DS19j
         Ga+M34F6/+B6KEZevKbakQFM7tnkf75jOOlKNrBb/gH44zKCtcrnKb9vxTwqC4cjeHoY
         aTBF2uRVMcriRMqOlqCRTMEfHlPWmMhSLBuddb85QhgH4sMHaSd6ntQaoXCbiB4gNJoe
         AisQ==
X-Gm-Message-State: APuU4Z8rw+T1trCcfKUCz2v4el91q8YxLUOInsMe1fQ4XlsW18XEnphP
	VT3iClbWVRwzqPZ2vK+5XevY+E44jiClXbRkPPPCF8e+80tNJ/RLqUcnEU5W8w==
X-Gm-Gg: AYBFou3fH0Z5xymdyCjrykvDzYGe0aPspgTvRpEzz/cwP/+jd9OWaXWs4Ds9F12JgrD
	bjxnTkl1wlMD+qAa1NYPiaGVfcQny4dQAJsRKUxoIh3r/X6db/iCegfpw3j1QOhv3RKvbu3WOPs
	dKD1S3Ci4ewRjgFb61xomztBOUyKQZeLLf5lA3dR9GBph4EtH4VRwSKMcujkWvFBr8ZKetBJ5UK
	gsx8Z7+wCbGLDDRn6tdm47en5V8YLxZsWHRagkuoZukMs2Sgitnj52/cCYLnw6Gw9P3W2IFndIP
	1eKrww+ChblkgpVP6krZpFYW8iRMxiZvSIiZStTp9Sf2joQ1bTzmbFWw8IvRafjmqpGacAtKgVk
	RodTMGqKtY+rGkvAxMl+LYG6d41f1ppD0itZzMtEAqR0FPkqQ6zfeZznDwOJ79I9pmJlpz34Hlp
	J+UX0UT5D40rIRBgE+VQHlPo8c94sSWBiO7b9jmZwxTVifRzWoLmDl43IF3/qXjeS32vhYTYYJZ
	oMXaeQIi1k3+Zk+DdPxJusFm7TV33PY//jtQubPIGHRqhUKO/kRZ4Y7DcPPXMp0JDuPUm/6r7x6
	vhe7FREAR0uDeKMxom1KJzLcm/76GueGp2TAEP0ekE4UEhmJbbqG7cbTnGra02JnopN/hBSVQ44
	FRgTvQO6Mc30+R2CCktD9kqaPUVibtGQm00CFZiVDnayLXmItGWyADMZy7Bxd8j9/ZE4GaILyhA
	==
X-Received: by 2002:a17:90b:3e8e:b0:3ac:95d7:2fa5 with SMTP id 98e67ed59e1d1-3b182f1ff12mr3927785a91.44.1794442118990;
        Wed, 11 Nov 2026 16:08:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c74bf3sm1405330a91.10.2026.11.11.16.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:08:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 0/7] bpf: struct scalar, and one backedge-taken count on it
Date: Thu, 12 Nov 2026 00:08:28 +0000
Message-ID: <20261112000836.3138846-1-alexei.starovoitov@gmail.com>
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

This series does the three. It applies on top of bpf-next.

  1  no WARN on a reg invariants violation     fix
  2  cnum: const, sub, zext32, sext32          no functional change (*)
  3  struct scalar                             no functional change
  4  five operations on it                     no functional change (*)
  5  scev.c on struct scalar, one function     cleanup, precision
     for the count
  6  '!=' with a step that is not 1            precision
  7  tests
 (*) but for an empty range, which stays empty

Patch 1 stands alone. Where the verifier takes an infeasible path
a register can end up without a value. reg_bounds_sanity_check() says so
in the log, and no longer with a WARN_ONCE(). It comes first because
patch 6 gives a congruence to more induction variables.

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

What changes in behaviour is listed in patches 5 and 6. A loop with a
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
by one and it loads. Since patch 5 the test of 'off' has a count, 242,
2 * i is -480..32 and the load from e->offs[] is rejected. Patch 6 counts
the latch: 16. The loop loads again, and it loads with 'off > 3840', which
is rejected today.

Patch 6 does not reach each such loop: a latch on the low 16 bits of a
register ('u16 i') has no count, a flag or a conditional increment beside
a variable that has a count since patch 5 has no summary. A loop of one of
these shapes that loads today can be rejected. No program of the projects
below is lost.

The counting code and the operations of struct scalar and of cnum were
compiled in user space with u64 of 4 to 6 bits and u32 of 2 or 3 bits, and
the loops were run: each op, step, range of initial values and of bounds,
64 and 32 bits and their mixtures, pointers. Without a congruence, at 5
and 3 bits: 7.95 G cases, all of them. With one: 534 G, all at 4 bits, a
sample at 5 and 6 bits. No count, false_until or range is wrong, patch 6
loses no count. Of 160 M random loops at 64 and 32 bits the 39.5 M with a
count of up to 300 were run: each value at the header is in r64, r32 and
on the line of base and step.

Patches 3 and 4: 26402 progs of the selftests
(clang in three flavours, GCC) have the same verdict, insns, states and
peak states. The level 2 logs of 26272 of them, 24.5 M lines, are the same
but for BTF ids and kernel addresses.

veristat against the tree before the series. Tetragon, Tracee, Falco, the
Datadog agent and more than 70 other public projects, the set in the cover
of "bpf: Find linked registers by scalar evolution, remove scalar ids":
1105579 progs, 1058728 load, not one verdict, number of insns or number of
states changes. In 33216 more progs no verdict changes:

                       progs   load     insns    states
  selftests, clang     18810  11757   -0.53 %   -1.13 %
  selftests, GCC        6011   3673   -0.01 %   -0.01 %
  Cilium                5496   5490    0.00 %    0.00 %
  sched_ext             1272   1163    0.00 %    0.00 %
  katran, bpfjailer      538    511    0.00 %    0.00 %
  Rust                  1089   1081   -0.96 %   -1.09 %

Cilium has two more weekly builds than in that cover. In C
trace_netif_receive_skb changes, 14519 -> 3505 insns, and two asm tests.
In Rust 242 programs change, 165 of them sched_ext schedulers. Two get
worse: float_fmt_display 66118 -> 70018 insns,
float_fmt_precision 65296 -> 69196.

To load the C programs, those in Rust, Tetragon, Tracee and Falco the
kernel spends -0.19 % to +0.03 % instructions (perf stat, two passes of one
kernel differ by up to 0.3 %). Load time changes by -0.92 % to -0.11 %,
mem_peak of the 1105579 progs by +0.01 %.

v1 -> v2:
- reg->raw covers the union on 32-bit too: u64, static_assert() (patch 3).
- No WARN on a register invariants violation. New patch 1.
- Applies on top of bpf-next.
v1: https://lore.kernel.org/bpf/20261111164950.2674588-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (7):
  bpf: Don't WARN on a register invariants violation
  bpf: Add const, sub, zext32 and sext32 operations to cnum
  bpf: Add struct scalar
  bpf: Add scalar_add() and four more operations on struct scalar
  bpf: Compute the backedge-taken count on cnum, in one function
  bpf: Count a '!=' latch if the step divides the distance
  selftests/bpf: Test the backedge-taken count on struct scalar

 include/linux/bpf_verifier.h                  | 131 ++-
 include/linux/cnum.h                          |   8 +
 kernel/bpf/cnum.c                             |  45 +
 kernel/bpf/cnum_defs.h                        |  11 +
 kernel/bpf/flow.c                             |  26 +-
 kernel/bpf/join.c                             |  24 +-
 kernel/bpf/scev.c                             | 938 +++++++-----------
 kernel/bpf/states.c                           |   8 +-
 kernel/bpf/verifier.c                         | 215 ++--
 .../selftests/bpf/progs/verifier_loop_latch.c |   6 +-
 .../selftests/bpf/progs/verifier_scev.c       | 146 ++-
 11 files changed, 773 insertions(+), 785 deletions(-)

-- 
2.55.0

