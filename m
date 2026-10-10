Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D072E03EA
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791665922; cv=none; b=ZQ2FBsMMqUCtV5b2cO4sobE0nJJ7OXufOqUM5UWu0QIflEIu/que840w2lw4lLqwHbt1JLSIdld28lLyWR+l/8dZsGYBGh0GK6uNwGE+kvXF1SJ/9S2x08jTEoRgHzfFUpiY24MZjGqs6dyyLOpkDbhQWzj8pNl7Oo/QBCDtDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791665922; c=relaxed/simple;
	bh=VlhLfVqyKlAH0uvcOeJcdSk0Ip30G9AZAsK/uP1CT+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i5p+2Fog0zucy4jE8zNzpwOrXBIeI2ulQYjdw1vOCLktXzvksOFNJ23A01mk7ahQ1b1yJrBid7GpP/9t+rQvTiHcnuBut/IJlnzmx5pSMqh4/zRSGJq1FS5ovsTcw/Xxj/YPZ7Y48fRPJti/urCiDBUXHQx8TkEdbiM1EgFSOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz+6yzH7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz+6yzH7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d560775ca2so2829475ad.1
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791665920; x=1792270720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ohsgf2G9+PJwuVSj4ovm/rrO/8hhn2/OH27I4FzlDR8=;
        b=Cz+6yzH7CXB+pHXgslvEaMr0sNnzETbfPgGuCoK/YQPqsLCk2V5ftOGjUZytmeV3kz
         IM7Div4fPHA3a27LqepPsUmCSswhe5V+WK3u7shdH50Hm602wA1X6aZxLLYrByGrtzYB
         rk+VWRedU3f3zfxzrfaT5sDdC/fea4S10H+GATTtGWnPwok84BnucYzZnTMW/77CjBSk
         PIN1H8Yox7NphNfgAq+iPMw1ShIjCxuCQ1CUtW4CBaZxdRRY5lYM/VZviUqCMX/e8rKO
         YoRKUYrwN6jSanKdKuQD3/scrKU+5DtkzfSLhTfKOcxul2QhYEeZ2Xj1lmwa/Cy0Fw0E
         W44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791665920; x=1792270720;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ohsgf2G9+PJwuVSj4ovm/rrO/8hhn2/OH27I4FzlDR8=;
        b=yyuhaaupgE2xJ4el3syTkkaLD/4nN+jh5k2BR5aGVW8qhJ6fPxrv32L/vsKomx6AC+
         RbbZXuIgzOeAfBlbiSlKmBQVEH/Y3EVy9qQX6taKg8hg1ooaURQpd2PpUH3skkwaFk9v
         bobE2nC902H5DZYc+lHhjaFfqcGwQAVrOLy9qaedGgjqMrfaGxNgcqIOqQG5+MVtaiVr
         iF+im56oquG17tQEhP5jsYEhokHBjwd+npkeQcluTyzMIBgYLB9dF2+WAl7T6rav6b8i
         TH5xQXbp2SjURLJoRc92t6VuxZywPMGlAGhD4eUcR4z0bmpaGRmiX8pdvKi7/eet1dmK
         4nHA==
X-Gm-Message-State: AFq9FYK7x6gpfOKgDCTpIvOkuBMQ/q6VJX47OduL6REpIOxP+BeoIoYy
	M4u+0MxbOKhXKJtUPEak1JK+OZ1wpRIFJXlyj9pS0o0iBP9LSPpbu5TdX4Zoq/Hz
X-Gm-Gg: AYBFou2kZ0f5zjw5hxYl+oy51rTiFFDCjL0IfZz++qENhdjOd46LZj4K/fae8niYBCd
	iTmdvmAy4pUa8cwIt5b23ln/KWXbiybq13u8VPSaC5v4HJNqJoeoe/LaQVv0FmEfq9ZLCfx1iUJ
	qS6s2cUCqOeGSjy+zewO1zjKgnwdDz1Jb+XBakDfvdJ96tCHwSOu5m1Q+TqGFy9ujoA4X0gA6tT
	VThe5XwY4wcy0nOVECL7lzi+J+cASzon12yxFAh4t0Bly+M/KMYL+E0re54i/sK1RJkYXzxCiwA
	5Bo+jKVoN5kQDP2ux5CoUAh1FhuUT77nCepDu21zvdib7qHqFptfe7KXrTqnqwAgY5RRbYYaj5F
	Ac/+G3HEsrEkpLV3JyyZPtClPW7m1Z/rN6TBHTsmEhExl5TC9vMOX0kXm70RbPuggk7ne8aSIHL
	PS5alWfoKI0JQmzlPYLaA0n9wATOeNhJgHysn9KYRJVv7AxemCJco1f1aBk6mGVyQROFDD7ovNc
	hOfRFzbyLI2vL0=
X-Received: by 2002:a17:902:ef4f:b0:2e5:c563:c0dc with SMTP id d9443c01a7336-2e842cdb0f8mr51544925ad.42.1791665919911;
        Sat, 10 Oct 2026 13:58:39 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b17basm26137945ad.42.2026.10.10.13.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 13:58:39 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] bpf: use div64_u64{,_rem}() in scev.c
Date: Sat, 10 Oct 2026 13:58:26 -0700
Message-ID: <20261010205828.3366892-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For whatever reason gcc built-ins implementing 64-bit division are not
wired into 32-bit kernel builds:

   ld: kernel/bpf/scev.c:2074:(.text+0x4512): undefined reference to `__udivdi3'
   ld: kernel/bpf/scev.c:2141:(.text+0x475b): undefined reference to `__udivmoddi4'

Instead, one has to use div64_u64() and div64_u64_rem() explicitly.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Reported-by: Tejun Heo <tj@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610100657.DOIT44Ep-lkp@intel.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/scev.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index adad32d8cb12..48500d73105a 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -5,6 +5,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/jhash.h>
 #include <linux/log2.h>
+#include <linux/math64.h>
 #include <linux/min_heap.h>
 #include <linux/bug.h>
 #include <linux/tnum.h>
@@ -2083,7 +2084,7 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	struct bpf_loop *loop = aux[bpf_loop_at_index(env, latch->insn_idx)].loop;
 	struct scev *scev = env->scev;
 	struct scev_value initial_val, step_val, bound_val;
-	u64 step, diff, bound, initial, backedge_taken_count;
+	u64 rem, step, diff, bound, initial, backedge_taken_count;
 	u8 op = latch->op;
 	bool up, down;
 
@@ -2129,26 +2130,26 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		    /* Is the latch condition false on the first iteration? */
 		    initial >= bound ||
 		    /* Count iterations satisfying the strict inequality, including i=0. */
-		    check_add_overflow((diff - 1) / step, 1, &backedge_taken_count) ||
+		    check_add_overflow(div64_u64(diff - 1, step), 1, &backedge_taken_count) ||
 		    /*
 		     * Check if the last iteration overflows the counter:
 		     *   initial + backedge_taken_count * step > U64_MAX
 		     */
-		    backedge_taken_count > (U64_MAX - initial) / step)
+		    backedge_taken_count > div64_u64(U64_MAX - initial, step))
 			return false;
 		break;
 	case BPF_JLE:
 		/* E.g.: 3 + 2*i ≤ 7 ⇔ 2*i ≤ 4 ⇔ i ∈ [0,1,2]. */
 		if (down || initial > bound ||
 		    /* Count iterations satisfying the non-strict inequality. */
-		    check_add_overflow(diff / step, 1, &backedge_taken_count) ||
-		    backedge_taken_count > (U64_MAX - initial) / step)
+		    check_add_overflow(div64_u64(diff, step), 1, &backedge_taken_count) ||
+		    backedge_taken_count > div64_u64(U64_MAX - initial, step))
 			return false;
 		break;
 	case BPF_JGT:
 		/* E.g.: 7 - 2*i > 3 ⇔ 2*i < 4 ⇔ i ∈ [0,1]. */
 		if (up || initial <= bound ||
-		    check_add_overflow((-diff - 1) / -step, 1, &backedge_taken_count) ||
+		    check_add_overflow(div64_u64(-diff - 1, -step), 1, &backedge_taken_count) ||
 		    /*
 		     * The last iteration underflows the counter if:
 		     *   initial + backedge_taken_count * step < 0 ⇔
@@ -2156,35 +2157,35 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		     *                    backedge_taken_count > initial / -step
 		     * (direction flips because step < 0)
 		     */
-		    backedge_taken_count > initial / -step)
+		    backedge_taken_count > div64_u64(initial, -step))
 			return false;
 		break;
 	case BPF_JGE:
 		/* E.g.: 7 - 2*i ≥ 3 ⇔ 2*i ≤ 4 ⇔ i ∈ [0,1,2]. */
 		if (up || initial < bound ||
-		    check_add_overflow(-diff / -step, 1, &backedge_taken_count) ||
-		    backedge_taken_count > initial / -step)
+		    check_add_overflow(div64_u64(-diff, -step), 1, &backedge_taken_count) ||
+		    backedge_taken_count > div64_u64(initial, -step))
 			return false;
 		break;
 	case BPF_JSLT:
 		if (down || (s64)initial >= (s64)bound ||
-		    check_add_overflow((diff - 1) / step, 1, &backedge_taken_count) ||
+		    check_add_overflow(div64_u64(diff - 1, step), 1, &backedge_taken_count) ||
 		    /*
 		     * Check if the last iteration overflows the signed counter:
 		     *   (s64)initial + backedge_taken_count * step > S64_MAX
 		     */
-		    backedge_taken_count > ((u64)S64_MAX - initial) / step)
+		    backedge_taken_count > div64_u64((u64)S64_MAX - initial, step))
 			return false;
 		break;
 	case BPF_JSLE:
 		if (down || (s64)initial > (s64)bound ||
-		    check_add_overflow(diff / step, 1, &backedge_taken_count) ||
-		    backedge_taken_count > ((u64)S64_MAX - initial) / step)
+		    check_add_overflow(div64_u64(diff, step), 1, &backedge_taken_count) ||
+		    backedge_taken_count > div64_u64((u64)S64_MAX - initial, step))
 			return false;
 		break;
 	case BPF_JSGT:
 		if (up || (s64)initial <= (s64)bound ||
-		    check_add_overflow((-diff - 1) / -step, 1, &backedge_taken_count) ||
+		    check_add_overflow(div64_u64(-diff - 1, -step), 1, &backedge_taken_count) ||
 		    /*
 		     * The last iteration underflows the signed counter if:
 		     *   (s64)initial + backedge_taken_count * step < S64_MIN ⇔
@@ -2192,13 +2193,13 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		     *                         backedge_taken_count > initial - (u64)S64_MIN / -step
 		     *	 (direction flips because step < 0)
 		     */
-		    backedge_taken_count > (initial - (u64)S64_MIN) / -step)
+		    backedge_taken_count > div64_u64(initial - (u64)S64_MIN, -step))
 			return false;
 		break;
 	case BPF_JSGE:
 		if (up || (s64)initial < (s64)bound ||
-		    check_add_overflow(-diff / -step, 1, &backedge_taken_count) ||
-		    backedge_taken_count > (initial - (u64)S64_MIN) / -step)
+		    check_add_overflow(div64_u64(-diff, -step), 1, &backedge_taken_count) ||
+		    backedge_taken_count > div64_u64(initial - (u64)S64_MIN, -step))
 			return false;
 		break;
 	case BPF_JNE:
@@ -2208,9 +2209,9 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		 */
 		diff = down ? -diff : diff;
 		step = down ? -step : step;
-		if (diff == 0 || diff % step)
+		backedge_taken_count = div64_u64_rem(diff, step, &rem);
+		if (diff == 0 || rem != 0)
 			return false;
-		backedge_taken_count = diff / step;
 		break;
 	default:
 		return false;
-- 
2.53.0

