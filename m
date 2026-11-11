Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374086;
	b=zd4Djd39R227FJbV4LAphbZRj8tbZPYImsW6HOWHPuTwcPWMuF05Vbec6xZt5pP1PN7S
	 oIK14TGh7cRdlxNFT66tmvaUX7fBxDWy4dJHd0W1Fwj8xJCQzR/0eP6ywcz0sF7xl/zyd
	 igjszytrl/GCy8jHlKIDz828JFJhVr5OJ0Cqmgq7A4xl3n0QTCKq8VC//mQZgdrDZwJSX
	 Is3psdJgCEzne2gCAqGJ60+INwdGF4UlW+2LuJ75Ao+geaFTmb28DsQ41dp0XCvAcscVP
	 owwaIVeg4MP/5S+vQYANXbUMzF5vXN68egWZ3pg96+AwiWkBXEUq5wMf2klqgV1pqqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zP7er+kFb6Pus6Psu8lXgDxOgRS8T9eVaXlKAvh1Oy0=;
	b=ySWRy5oh5q3iH7vimmTbg5bRhlI00ZQUbbMfaZebLo5mH8EMhCkBLhJWm0Z/U9ZChpJe
	 oGPm6Iv0KjJ81WC96MUXc9sSbk9DUaF+12SxapqDku5uRsfcAg3gfy4hb3NZWCKd80Gha
	 4zG3RsTZfK20J7VPpjjb8U2mGhAe/cJX5ZWyW4unLFumUWBVEEgfMEJ4Btjpt6Dy+Z5jQ
	 UNOW1EruwLOznIz+K4CvGr3hPTuTMcw4L78yJJOsvnqHTSMcdvsSoy2os1oWbUA99ZRML
	 C6K4SItpVIAR+dZKSScyoknDD0yFp826l+UnGLSmCfmYq8RbzPK3um07IcUkatIeubQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B++kYN2H;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9BF606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C9BF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B++kYN2H
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso1194676a12.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374085; x=1794978885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zP7er+kFb6Pus6Psu8lXgDxOgRS8T9eVaXlKAvh1Oy0=;
        b=B++kYN2HIgFVIgcQ/hc41ejXQ1xRZMQEwu50k1ZTPJR089Y0HDbCo7pIjxdUaGYRnB
         xvw4lNxmRtzCEmNkvNpXAcjzPvHWWoUte3yScLO3fQDTIn20IfbuJA8zlH0D/SgVnBuy
         L/R44FM2jr/Cs9P8+kA0U/zm9k1DpUcZt7DQVUf5zxDfIOt38wU3DbB89NnOBCivK16Z
         wWVwA8+VZfkdCU1ZetrNWM+TGIKlP4K0dSqb/kfUlurffcoBwZGspTzjgQEhRjrgxzjj
         C86rs55lrjfaSCMJrNFH7AwF24uOyDu0VqYR1zCJqEe1J36pvwIFyrX2tQDJGD6jetYJ
         KYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374085; x=1794978885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zP7er+kFb6Pus6Psu8lXgDxOgRS8T9eVaXlKAvh1Oy0=;
        b=PBdpZS2WmdTkDNuP9dSe5zfsTtw/tZoY0vjLLhtFz4syuK0rrOisfyT6x8Ske+B5St
         cCzJU4yI0AUpWkUxMlpM3P6lrwRB0MMXI0f+S3UNbVWY5bRD1c+Ew/DjtdZy4Pad0oZZ
         G9kFmhFg/mt1w484sx6N45XeMzl9rMB7ZqdfiI+uTmN+OUEz6Ctv05UuiudX2ImGEWiB
         ICy46Ol2U4zIyXcI8oQtcZ3nzutrZ0vV8lcb5UxsTSXL5/0+x/i4HKSRh7xooCnHXRyJ
         kiLII7QbxGk3noQphfJ6Sq1za+rpEfD11TmMaXfureZSg2nXGwxD0++Eeeo9wc5XkkCN
         sdDw==
X-Gm-Message-State: APuU4Z9g0LY2THGD2/ZuRSbDJd06W6sfvNDXLrYcJDaqEksNNt1c5x53
	xbtuow766iAylD/4d6SpMxPsEsVFGA6VPa46vIBahGFI8rdu/iK7kPDk0GmB1g==
X-Gm-Gg: AYBFou16uPer55lLcJ0Uph209NX6iZQBTMMwjQS2cpXPjn4itp66KWzW1gjgYx6jquD
	IvoK6q/ZpU844QaiTSW2PwXiiKJByfL43OFwY/TaUZfDL16YlIUTxJnLLfHXPq7MLSb7YYlb+4V
	MxYmWApVOM31MZ17PevK6aHje+HVSywbfX+m1iOqYcNdJHnL8kHTeRU1EYm6XeRZib6oAbvrIJI
	n+lMTCODnZv/e78wJJkL7T6iYQW3tVUFUUif79RWeqv7V9xqlO+Af03OABPbuGOPfvYBn+ZTK6G
	VNNk36crHJ1XwWnUJ3qXTMDdBch6L5B/2WF2sdwRtTPZCSa/84unX9D2zkq26POrE+y54slMSEH
	dlF+N0J79mvTRNZspheVEV/NkblvvUNEd1QbWrIWmJnRUF9neaDoNwPVrL238Kq9/amZTNygAgr
	XAsN0enwAWLCYvLEi8xCOG5q0iTJHd8PZvfyZLjzUrdt3VmOqRkEz/wH97PRpciKHygU4lZ8IlD
	MMbQorxQSZoMkhxjVDQSoPcU8RWde/u0TsFp7osbqG1bzrBahBlc2fq0sT5Mh51Th0VVV8B5UxG
	5PTC0v9Kae8gHUuvIx2iRNYmsaG0/y9WNYJbFb5pxCFfmq/Ocu/35BjW+SWtXry/fZG2qgbx6dX
	ReJPv4ZFpzGdycjgwa/vB8wMAwzhaAVgHKSDPYc+npn5fbMHRHpVNfZVMYVH2KXkrjBF20ffaHA
	==
X-Received: by 2002:a17:90b:5604:b0:39e:59a0:46b5 with SMTP id 98e67ed59e1d1-3b182fb20fdmr1373943a91.24.1794374084847;
        Tue, 10 Nov 2026 21:14:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db319bdsm2690599a91.6.2026.11.10.21.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:14:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 10/29] bpf: Detect a dead branch when a range and var_off don't overlap
Date: Wed, 11 Nov 2026 05:13:21 +0000
Message-ID: <20261111051341.2800252-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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

A fix of the main pass that stands alone. It is also a prerequisite of the
patch that refines linked registers at conditional jumps: that patch
intersects the range of one register with var_off of another one and asks
reg_is_empty() if the intersection is empty.

  1: r0 <<= 3
  2: r0 += 5
  3: if r0 s< -2 goto pc+2
  4: if r0 s> 1 goto pc+1
  5: r0 += 3
  verifier bug: REG INVARIANTS VIOLATION (alu): range bounds violation

The low three bits of r0 are 5. No value in [-2, 1] has them: the range and
var_off don't overlap, the fall-through branch of insn 4 is dead. The
verifier takes it with an empty register, and the addition at insn 5 trips
over that.

simulate_both_branches_taken() refines the registers as each branch does
and drops a branch in which a range is empty. It relies on
reg_bounds_sync() to empty the range. __update_reg64_bounds() steps through
var_off from umin to umax, which are 0 and U64_MAX for a range that
crosses 0. __update_reg32_bounds() uses only the smallest and the largest
member of var_off.

tnum_step() returns the next member of var_off. reg_is_empty() asks for the
first one from the start of the range on and compares it with the end, in
64 and in 32 bits. A range that crosses 0 wraps around at U64_MAX or
U32_MAX: tnum_overlaps_cnum() splits it there. The test is sufficient, not
exact: 64 and 32 bits are checked each on its own.

Two tests in verifier_bounds.c, with the values above shifted left by 32:
no member of var_off is in [-2, 1] and the branch is dead, -3 is one in
[-3, 1] and the branch is verified.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 34 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_bounds.c     | 33 ++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5bffc1e288f6..bc0937b98818 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2325,6 +2325,36 @@ static bool range_bounds_violation(struct bpf_reg_state *reg)
 	return cnum32_is_empty(reg->r32) || cnum64_is_empty(reg->r64);
 }
 
+/* Do @t and [min, max] overlap: is a member of @t in the range? */
+static bool tnum_overlaps_urange(struct tnum t, u64 min, u64 max)
+{
+	u64 tnum_next = tnum_step(t, min);
+
+	return (min & ~t.mask) == t.value || (tnum_next > min && tnum_next <= max);
+}
+
+/* The same for the cnum [@base, @base + @size]. It wraps around at @ut_max. */
+static bool tnum_overlaps_cnum(struct tnum t, u64 base, u64 size, u64 ut_max)
+{
+	u64 end = (base + size) & ut_max;
+
+	if (base <= end)
+		return tnum_overlaps_urange(t, base, end);
+	return tnum_overlaps_urange(t, base, ut_max) || tnum_overlaps_urange(t, 0, end);
+}
+
+/*
+ * A range and var_off don't overlap. reg_bounds_sync() compares var_off with umin and umax: it
+ * doesn't see that [-2, 1], which crosses 0, has no member with 5 in its low three bits.
+ */
+static bool reg_is_empty(struct bpf_reg_state *reg)
+{
+	return range_bounds_violation(reg) ||
+	       !tnum_overlaps_cnum(reg->var_off, reg->r64.base, reg->r64.size, U64_MAX) ||
+	       !tnum_overlaps_cnum(tnum_subreg(reg->var_off), reg->r32.base, reg->r32.size,
+				   U32_MAX);
+}
+
 static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, const char *ctx)
 {
@@ -18916,7 +18946,7 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
 	 * reg_states in the FALSE branch (i.e. reg1, reg2), the FALSE branch must be dead. Only
 	 * TRUE branch will be taken.
 	 */
-	if (range_bounds_violation(&env->false_reg1) || range_bounds_violation(&env->false_reg2))
+	if (reg_is_empty(&env->false_reg1) || reg_is_empty(&env->false_reg2))
 		return 1;
 
 	/* Jump (TRUE) branch */
@@ -18928,7 +18958,7 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
 	 * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the TRUE branch must be dead.
 	 * Only FALSE branch will be taken.
 	 */
-	if (range_bounds_violation(&env->true_reg1) || range_bounds_violation(&env->true_reg2))
+	if (reg_is_empty(&env->true_reg1) || reg_is_empty(&env->true_reg2))
 		return 0;
 
 	/* Both branches are possible, we can't determine which one will be taken. */
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index f55d58af8004..316e9377caa8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1995,6 +1995,39 @@ __naked void bounds_refinement_multiple_overlaps(void *ctx)
 	: __clobber_all);
 }
 
+/*
+ * r0 is x << 32, the low three bits of x are 5. No such x is in [-2, 1], -3 is in [-3, 1].
+ * umin and umax are unbounded for a range that crosses 0.
+ */
+#define RANGE_CROSSES_0(name, smin)		\
+__naked void name(void *ctx)			\
+{						\
+	asm volatile(				\
+	"call %[bpf_ktime_get_ns];"		\
+	"r0 <<= 35;"				\
+	"r1 = 0x500000000 ll;"			\
+	"r0 += r1;"				\
+	"r1 = " #smin " ll;"			\
+	"if r0 s< r1 goto 1f;"			\
+	"r1 = 0x100000000 ll;"			\
+	"if r0 s> r1 goto 1f;"			\
+	"r10 = 0;"				\
+"1:	exit;"					\
+	:					\
+	: __imm(bpf_ktime_get_ns)		\
+	: __clobber_all);			\
+}
+
+SEC("socket")
+__description("dead branch: tnum and a range that crosses 0 don't overlap")
+__success
+RANGE_CROSSES_0(range_crossing_0_no_tnum_overlap, -0x200000000)
+
+SEC("socket")
+__description("tnum overlaps the negative part of a range that crosses 0")
+__failure __msg("frame pointer is read only")
+RANGE_CROSSES_0(range_crossing_0_tnum_overlap_below_0, -0x300000000)
+
 SEC("socket")
 __success
 __naked void signed_unsigned_intersection32_case1(void *ctx)
-- 
2.55.0

