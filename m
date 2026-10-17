Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065D537C929
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200085; cv=none; b=D9qRHOWaV6PJV3FG2QlUeP9KDu/xXb7jlC1wESM4PTzNNTL8FBtFrjl+8l24snk5pOHv4V/C1Ur0ZcaOPh3y8lwybIJP+bcK160tH67LyQO1uplQizhKURxtdIdR/lFNd7marBXdH0zyWdD2OAiEbq30I1+Mju4qK776kZHQqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200085; c=relaxed/simple;
	bh=OQc7ovHnX081mUlFOYqUF0sNSICI9EspyAQcDauXQNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rV0yR414HWFoJacQtE6vBKFL7I9xQKWAafIMW46Bhq/PZRQlsGcmT9ocLcO91FLpe8xjq89yhqKBIi8dfvf1lZ59N+B5oX6Pp7CxWkMMnI3aXnIUvDYLbsinEr34XxHPJ9zRYeykdEEa0psFA/3awDXjtcvgfy6MrF2EoE6yUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKL961tj; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKL961tj"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc758830601so385941a12.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200083; x=1792804883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ty8oBQC8ZzmKhKgO/ClpXA/s1qlF/mePfz8ntL+VDOA=;
        b=RKL961tjpeUHYLPIQmaJZzrQwHOpD0o0FEioTd6GUHTPYDJlIw8TzqsCXxcVCUS1GD
         9I1cHbVukjAqKLU3oUfUgePNLGG/TrnfXzbuR+O2jVzGEVJAHuhQTAmLvNz5OGXcJUuH
         bcmw7WfqUanCWmUjoG2airrVdev7BVd/R2JloZSSv5Q5GqWhYL117Pi935BOw4ntgfTl
         Z7IdUp1Bk2WATkTZIfolJELp+2ZDOCP3Uo0j2T0VerFgoEjYSF2maqWnpFjGcdBLr4Iq
         /91A6FilGx9/WgwaL//SVBF/ld5GO9itB9J0K5wtnh/MCpwakVfR+YTFwWUkeX+BLIop
         4ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200083; x=1792804883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ty8oBQC8ZzmKhKgO/ClpXA/s1qlF/mePfz8ntL+VDOA=;
        b=YPNMQrfsI1hgErBjAztmRDIhL7+Qm6x0N9L5WeVMc6SUneMT7NzEaWG24m8vL6DYn4
         pydwl2nfo5F1PlTkxyrRes0PQ1ksCOSIB/cJAAT7SNy0SI7+bo0o25/ywEnW/XlscpD0
         2H/ZZRphSZNaKzdCcrWnaKKPZzkIuSDPAoz0Lf8zJ0BdfbhTww187pUXm/w7+bCVDMup
         kzA4zCpYQIF10vhq7oPgQ92prwA4BvCzef40GbaTxf9gTVxdC3+4KXA2Zi8jpR5+qdjS
         lhN4sLK0m5VREsXXzn0eK13nLJcm7Wu0w5/JjelEVwEnKEfaYa7VQ1yf1YAujmEVkhlG
         JsEw==
X-Gm-Message-State: AFq9FYISNgrtgGa30HgGcaqU0wI3JSUt9VOxrOjKPS0bW0KMc550Koe7
	Wqm4uMcBC+NtB24mvRfaKrDjOiaAgnp4GHNhxIOhKCCzIeFxBnFraIAtNwkWwfqm
X-Gm-Gg: AYBFou39B7UQpGY0vsZpubkYV+ES0sBn0NDlHQhO2jOO24WWF4nZGVum8om0rHuYnvE
	6Gxo1KXnU9nS1HY8gcXmUHVd1VQGedfBHGAYCX7wJvyNz7IClQey5Q1BYu37mZzrkJePpmR4lA+
	XS9wfaOIbti6YnZisF8JFnNBg9P0hOeKjsMoT1rXeHxgcR8J4JMKD1XP9Rh8aVng5vLWVP3axgp
	QWYwUWaOWfJ+8nfKdi6epRHxbw+x5ttl3HkScsEE66bvE6fT3BurbjXlSRtVqIjBwdJhSEkJkpF
	rVscRZxIa8KAvHzmuNEOLwNU1g7S2+I5MNA8uLhzopupQ5/B4ca5PPOgAopzTC6cvS9UaTnVWey
	WhUFqaVcKLiGOBqTpMqtqcQO73sS7S+GhfedudP49XfYv/rC/tO8V38U6Rn9YwC6OdqQGNRFkAL
	+7fPZL+tQ1eWkaqmrEhWpy8QHJmZizOiXk0kOe4okbWLzuaxftVD0vaOpb6iTf+m5bJqkxdkW5v
	i/n/J9zYzL+rz1X+lfY/owhuKCwLlQT3zJxh0GQUjBArpWpfMyDS084/cQAndZ/CJuco2VnombZ
	qgeJOVaeNxIKzSlU5GVjqDAqYY3NhtOA8zLWh7Cb6Hk=
X-Received: by 2002:a17:90b:5448:b0:3ac:7c52:fae5 with SMTP id 98e67ed59e1d1-3acef2b5beamr1228025a91.50.1792200083201;
        Fri, 16 Oct 2026 18:21:23 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3b16c2asm2651789a91.2.2026.10.16.18.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:21:22 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 07/38] bpf: look at all 64 bits of a BPF_JSET mask on 32-bit
Date: Sat, 17 Oct 2026 01:20:27 +0000
Message-ID: <20261017012058.355787-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

In the branch of a BPF_JSET which is taken, the verifier can learn
something about the register only if the mask has a single bit: then this
bit is set. regs_refine_cond_op() tests this with is_power_of_2(val) and
then ORs val into var_off.

val is a u64, but is_power_of_2() takes an unsigned long. On a 32-bit
kernel it only sees the lower half of the mask. For

	if r1 & 0xffffffff80000000 goto l

which is a BPF_JSET | BPF_K with an immediate of 0x80000000, the lower
half is a power of two. So the verifier takes all 33 bits for set at l,
while the branch is taken if any of them is. A mask of 0x100000001 from a
register does the same for bit 0.

The log of an i386 kernel, for r6 = bpf_get_prandom_u32() << 31:

	3: (45) if r6 & 0x80000000 goto pc+2
	from 3 to 6: R6=0xffffffff80000000 R10=fp0
	6: (77) r6 >>= 63                     ; R6=1

When the program runs, r6 >> 63 is 0.

From then on the verifier works with known bits which the register does
not have at run time. It accepts, for example, an offset into a map value
which it derives from these bits and believes to be constant, and the
program can access memory outside of the map value.

Count the bits of the whole value.

Only 32-bit kernels are affected. On a 64-bit kernel unsigned long holds
the whole mask, and this patch changes nothing.

Fixes: 960ea056561a ("bpf: verifier: teach the verifier to reason about the BPF_JSET instruction")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 430d5309eb5c..d0ba7156ba4f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18145,7 +18145,7 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		 * this restriction. I.e., !(r1 & 0x3) means neither bit 0 nor
 		 * bit 1 is set, which we can readily use in adjustments.
 		 */
-		if (!is_power_of_2(val))
+		if (hweight64(val) != 1)
 			break;
 		if (is_jmp32) {
 			t = tnum_or(tnum_subreg(reg1->var_off), tnum_const(val));
-- 
2.55.0

