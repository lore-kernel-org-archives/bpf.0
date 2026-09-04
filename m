Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053548094F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519475; cv=none; b=WhFsLUTWOoe7a6fQRM/8kEog3AN+47Am0e2M+kvtuM/G/V/7+mu/n7TMNwiM3QYz1mdk8Xiqi4bY7NgAB8YWdQyARPIbxwU8fjOOlvvH1yuhqFC2+jHzc/TY4725pbcsdHNkNNy5GrzpNSeatyulSpxzd7rop1iQdJZ8I0M5QHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519475; c=relaxed/simple;
	bh=pXIKNBJZ7VpWZJHYVm5d/JqZ2uDmSW/zMvrAvNFtAkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anKFZ8/sBamvPGyCdmuPFVNHsRi/mhQ32Su33c1Fee7q7NFe6vllh+BvEz/AzsOGvCk9D8Sog4pgGydAJYdbnm9BbFIbrLyRBmxO8q3itul97OyEu1gAddhQnFmQzaksSF6lHQX36bAOSvkOSLGj+ag98asms7OprPzyAF+Ry5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IArX4aRH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IArX4aRH"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca80d708489so655762a12.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519474; x=1789124274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjnURsU06dXJhEmQk8UgpVeNwhEKlwAdFOshlqNlRoY=;
        b=IArX4aRHUF7ZH3gol+dETzxTV/6IBuM+H6f8/aWPNjpJN3Rk8BBsmrNDD8zZ7wDmsv
         hGIoSDi1Gt+2xn27Uyuwxh+YCHGt2FWDkvg2g54JpTdE48SUrzqb7jqZ3T6xrWiFYUrp
         hrt+PCqwYOXeA0YC5uEsvqv5tk5ghXsmnEsHVOhViHmJzUH6EUZ1MwC9JziX/zRtlawa
         6p0m6pqW6lZ//+giCtUmOIe+cx4U+lkRBWWwtgWwmTIAphWXeC9OyeQzPc6esYKT0Nbh
         XXWVWMR0CSJFQ4Qd8DxPEcwII43oRNRyGzvBOfM2K/NuO3VUvKxG+g7Qd/lFb/xJ2FX2
         OchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519474; x=1789124274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CjnURsU06dXJhEmQk8UgpVeNwhEKlwAdFOshlqNlRoY=;
        b=ZYHehzfreZu2D7BMXXF4BrlYVyGOvy6qJ7F6RbIw7S22A6oxTwKL/z7BcbWyx0Sff6
         NOkz+opaS86nkDmyePvHPQQRJB3N4b03LtFioj9DmOz01gnZybYj0oU46Thz5dA8sEzo
         AoCRTFqGyPPJMh0cegKSdhmlJbLg/yeYkk3KG6OezUgGaes1WnFJcFSRNnIRc9rBx74M
         oEvMaVNko08UiAU/O6R7domTeahZ4x2/PlehGCyT63aWgGmaAvdNwS3luFWQ2NWTETq6
         g5gGvI1oOZQrarDcDAuh5zrxt1LPI3+/yRfJtjPlacciaKy5loTijiZO5/3GXvMTQgx9
         2wsw==
X-Forwarded-Encrypted: i=1; AKwUvBwsTz3uav5Qaaf6bCgoEwmCUOtGNA+Q4HZgSaLHxsfw5vKHASCzw2j01q57hZBflN101Q0=@vger.kernel.org
X-Gm-Message-State: AFuF++kjvww1N6pYMvOzOxXrIE5fVnjBRHeoN14HGyiEoJTjixxKREha
	B8BWLSbNnuegeYa9UQ/AnTAAlFy7f6XbnCl5MpqhY4NizWHfLveb/HVw
X-Gm-Gg: AYBFou1+h4ORwsffbixKmpHEcJ444Ufv8ysAZE2HsVWgJpydUs2PXe1855dpTVAIG7o
	ENyI9JORUdmMw+6502lXpSSZTJt2LJ8c6BH9OJnDzoeoN4neJVqXhPqTocvuQAS5Evn54RYSdcR
	9O1WU+gHxARNS0/IQH7dAvKqebYdjmm6rfhKEpzyhD4zTggqm52SXx0iwvvL357D1mVzMmc4Xn2
	+qw/w63SLJjoVFWYmTMjnISbbu5HXA62LAzPjAuQohgtTBKpcxePTZeBDLQOay2c/Ey600y7WhR
	t0MbsrOzXtGzhO7lG220dnjTuSyugZMbplypoSHQ+gzshHNb2yBFdlERX3jVDd2n3gmuanhTWrr
	FMM6ulP9/3GgKqXseDBQRYV/VWVqnQIXnEjcri9Hkob1deB79UD7Y/5L4K3Hbcaiy7BXF3cupj7
	I6DxudEadCxEXJSU0Wx4q5OlcRONDzuEBfpaNaDIqoeHnbYt5jmpIUvkF5F3HMG2nMkbVHwhlUN
	/trqM3bUN8UQOs=
X-Received: by 2002:a17:90b:4b90:b0:369:7491:7b24 with SMTP id 98e67ed59e1d1-39b07f2f31fmr13507017a91.6.1788519473607;
        Fri, 04 Sep 2026 03:57:53 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm5523091eec.18.2026.09.04.03.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:57:53 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/7] ARM: net: fix typo "arithmatic" in comment
Date: Fri,  4 Sep 2026 16:27:31 +0530
Message-ID: <20260904105743.39799-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904105743.39799-1-hemanth.selam@gmail.com>
References: <20260904105743.39799-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "arithmatic" to "Arithmetic", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 9ede81afbc50..b1c21c014c9c 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1346,7 +1346,7 @@ static inline void emit_ldsx_r(const s8 dst[], const s8 src,
 	arm_bpf_put_reg64(dst, rd, ctx);
 }
 
-/* Arithmatic Operation */
+/* Arithmetic Operation */
 static inline void emit_ar_r(const u8 rd, const u8 rt, const u8 rm,
 			     const u8 rn, struct jit_ctx *ctx, u8 op,
 			     bool is_jmp64) {
-- 
2.48.1

