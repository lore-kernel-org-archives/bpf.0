Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E730F7F2
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190445; cv=none; b=vCasbhxYZ5xOwKK5KmaJcEdREcY+VU/dsM7N4Ku/YLTwNZrsglbPNTNOcZXnhIt5XBatu68isygRZPWnVuj/opkP4+qz1nTgAB9txDQjrN+9MFeoZw0UUi1DZl1rpbKAoBMPiOd5rcO7kGibHWDFzKi29Zh7fXvC1Ub1aFVlMj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190445; c=relaxed/simple;
	bh=k186Z5fpJc8Vkox/jpLlIGX6O1TXcU4jUt6mcyg0x70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXZy3SPKDbhNWqlaxqBq6p4hAbNd0JYa3T/GLltQoADceDFOW7lelI1aDAl58ya1Y2is+lSOkK3uhZJsatowbPqBKaLI0gJpO5mJLpic3VjexELycPqWUDL9hKcfaqQNL+R3QD0JUJaH2GHZloNyG6Hkqxh8xcR8Q6fp7vOT42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ZSS3bgNv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ZSS3bgNv"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so953193a91.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 21:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775190444; x=1775795244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SPhc9e6j9rflEcN3/6qNXeNEA+k08+dO9KDiknYxlI=;
        b=ZSS3bgNv4Ja25Drf9bhfqlX3MLze+dPEzmQ2UGfy7tWABKHWYd6KAOoQJeOk/wJN7N
         UD7Op7CbS65Nf4DSIpLAvrIA/uGxiBiZSoRAYypfLnb622ItJuuwyBqEdMLSS73K9XkN
         h2ZeFGXi5HK/tqEoyShuPf0qw4mZYmol6XH8lZNmMJTr8XG+7gOhV59lPUU+TgvTqNWz
         EALkge1x75Y9GJx8dirRjAxeCm9tZELcbApVIYo7VTy9kcGOWTZg0ZLQuEw2GToCNwyz
         GTxULIkoq1GXxHhQy2WkY1bHo0q06vuMhS46gFCM25J08BAzL0vLdTK7x3b2UY1ElINv
         UXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190444; x=1775795244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3SPhc9e6j9rflEcN3/6qNXeNEA+k08+dO9KDiknYxlI=;
        b=gGWSb8TkThJfsBko1gvjlzms4BI+/6ZXO5GmO9cgD1HluHrLuxyWQUGlH2aOXtZfhB
         Xv3a9S77xycLwoQcEWnQNM/tgM71CWII9ZT9c6oe64aRyPacdVefGCel1z4kNNWKVQ8c
         A3XIXNwcAB86/3YUkMz+AQAwZs8EQKqqN8L8NA34QhN+XqFVez3dVvUy5oH07/aEn05O
         /5k3/P/+tQKKLDRvViuZ5An5qEij98HmkxNdiTnZ80F5Hzd4Fn71mvPlbxEvB5qyUlZU
         NXrP/MUKVDFVoFxFYIZZZ32tX4aBPw7aJkcodNK8RqfnIzq/ReXwYcu8d6XeWuoMd+jC
         FuWA==
X-Gm-Message-State: AOJu0Yw7MI93/un7leUHKQm8EEV2fkU05bAF7ysx6ACz2hmCe0uqugdo
	CvUvuSyORQYplnoVgiWkaCAHlwPhrlYfJNmK8u1J48wtL/93uyX65TPtOdifsuNsMq2aIfZYPOj
	3zZQ1rIZpRw==
X-Gm-Gg: AeBDieuag5joVGRsz2ur96wuqe5Z0rrAEkO1Ze19+z33hUafjGAzGkEmsCjy37ebL98
	XUy5p1nGiW1DKJD/5plEK+hq/dqwj22O6ZEbNS1a92pWemRWHhvDNxWfAju5fineV4KuHqN4BtJ
	nhVlBg2LPbikfz6n8Kx0HdcpnTH1AvB6CGtjzrbgWV3YPFYwPcrsXXJmRUfhoFKiOJXazxNh+/w
	55PyrIiZv0IEgQAeqI6NDqExBOl/eRDh1Qo5q/qRHVFHgUmtNfLs4upgMM8ziPt1W34OG807xss
	qi3aPvKVtj1zUVbizdnol+dvEvHqLzcVpPYwcD75zw9d4UmjmgzV+tCkcNRst7TVXX6p2X8uuQg
	y83m9pQ/XK23sGzd0l2FxEfVN0e0XFUWrjXHOXLrSFmp8rvPKYmpUB8bJeR5WlROio8ns0uAU7k
	Hc8w==
X-Received: by 2002:a17:90b:51c4:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-35de59c732bmr1334556a91.8.1775190443843;
        Thu, 02 Apr 2026 21:27:23 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe937925sm12970449a91.12.2026.04.02.21.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:27:23 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <etsal@meta.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on arena pointer addition
Date: Fri,  3 Apr 2026 00:27:12 -0400
Message-ID: <20260403042720.18862-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403042720.18862-1-emil@etsalapatis.com>
References: <20260403042720.18862-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

The compiler sometimes stores the result of a PTR_TO_ARENA + SCALAR
addition into the scalar register rather than the pointer register.
Handle this case by upgrading the destination scalar register to
PTR_TO_ARENA, matching the existing handling when the destination is
already PTR_TO_ARENA.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..583121b9aa7e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16333,6 +16333,24 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 					bpf_alu_string[opcode >> 4]);
 				return -EACCES;
 			} else {
+				/*
+				 * The compiler sometimes stores the result of
+				 * PTR_TO_ARENA + SCALAR addition to the scalar
+				 * register. Upgrade it to a PTR_TO_ARENA.
+				 */
+				if (src_reg->type == PTR_TO_ARENA && opcode == BPF_ADD) {
+					struct bpf_insn_aux_data *aux = cur_aux(env);
+
+					__mark_reg_unknown(env, dst_reg);
+					dst_reg->type = PTR_TO_ARENA;
+					dst_reg->subreg_def = env->insn_idx + 1;
+
+					if (BPF_CLASS(insn->code) == BPF_ALU64)
+						aux->needs_zext = true;
+
+					return 0;
+				}
+
 				/* scalar += pointer
 				 * This is legal, but we have to reverse our
 				 * src/dest handling in computing the range
-- 
2.53.0

