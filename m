Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01EB37268C
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402015; cv=none; b=eyy1bzHneWvkM32dS8M69OEvZk858sx3Ocnp/ZNb3Ap8IU3sMLqyR9OKvVH33lEY/YiXjFeaPMc0ie5LjEIwb4XIWaM7UjVwLtCemh9VSikEUEf1n1uxeBoAuZoAGJjwY44PPFzCEXp06iGnfm8E8tX1pE4GQX6QxzyRPiwayUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402015; c=relaxed/simple;
	bh=OO0WCM+MhFZRSd01e/UnZUH9lwwK4IV4RU2q2bJuQ5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYMTgLIrTmHw8k/zfAssR4BwRwODjvurcCGysCt8IRdqaHe/7l8y5XjkRaMEKHdreGGg8MykDKjJW+sXdN2OUgbeShKIb9Orqfm+CpViRV2QavLfAPOTBZR3yP6/C0DldASysF72lkKdzbfMKOWAjRUsiobYEJPmaiU2v3ZwNpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK7ANP5J; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK7ANP5J"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so1733302f8f.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773402012; x=1774006812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7dcdrbk+Zf94Vu1zqV1wI6yU3R6jqgbXLFez6BNrsqI=;
        b=KK7ANP5J5YEVNLocVERCDSvN2hjAvGe5wtdUabTzqGrqCEPDODOpfFmRFJtttlP0xt
         387XHKKRgiwOt947MBrFjkWSlnwZg1QkI2Vaw6Z6Gxjk47sEmUlCBTN1GNpwR4vVVVqE
         HwvnKo0NY5redejLNnSlzR+YrCUigtQnyTC4EZ57umKc8vKs9AUP4O/lPqqGbPpfxKft
         tjpDDBWMlFX71LsLU/iNelpa2cfl3qe+EiNPe524KT5f7QGWJPxDphQqVHkfhUFbwUSD
         /p48CXicucnEhZsq8XrN8uUbjWVyQ5YSQDB5l2qUKJXPXCcF/CrLOXx5X9IE0GhLV9Ga
         J1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773402012; x=1774006812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dcdrbk+Zf94Vu1zqV1wI6yU3R6jqgbXLFez6BNrsqI=;
        b=StMJuHxYAFQdpdsXmpV43ldybgqRVs2pZp0QYjdc1CQB97c7r3AK/0pe1u6B3NYTk0
         QcUH7nPGM9fHYw0CKt1m/B9Ta+VbpFX3iAYoHk2OKd2M6G9ijUpbty+tbGMPifFrdez5
         PTvm6HW9rcmk9vHpACfi6PlNEA3Avn7vAERY1mMm0hanecUfLkNJlXNBMFAJ/p1X0wFQ
         Ndv7W/IptJMgxGOw7t6HJtceoeU3jlIrPTd4wFk6ID8YKYtb8gz8DNMPjBDOsH/qCNIu
         Pai9xAYn/NN3CKHAuChbnnGkBhy2pKmAfpOc2u02CdX5Ml3v2AtMtb0GcJoxCfoD0ugY
         vkqw==
X-Gm-Message-State: AOJu0YzqgRkzPK+Ua8rIyaJQPTNwTD6gWAhsNkkbxNsxTMNsLc7baU9W
	LBUgO37pNiGy/Hjc+8ElQtR4naDpGdF5ZVcoGKNIFred6fMRYq8SeYoz9SgZvlY2
X-Gm-Gg: ATEYQzxx/ra+gO90S+vrB3LvuiZIJ/D2z9puem2NPPKdtS4iOOH1Hqna6K3ku9wx6lI
	/MAvq3Xiz5F1dYA4iaRvgfgW8QqZnUnX1T0/C9PF8LVxxkVqCeTqSTYlYFdpPbBSxjPfx09Uetf
	eAy16p1WqJqsAeoSUtHOSys2+ArcW7CcCO6pp21F1MH2iXtopgQ6BoX3tqAr88k3tY8+GUaB6+s
	aF/8A5LgIMoYnHv8A3qsBMdHuHq2RfDN/vYSHYXeDVU3NLAFhuGz1Qzbw5n548x7TeiRVGxzwhV
	ed74UKDbneOkmR5E+Czhdmv7D0dJ6kd7rFZ8uxWxPnxw89nrZqGTiHeujCnTrS/CyK5cZFcOKwq
	htT4Uw/+6XKDmZ+bA7lnxQDjTj4noXhVEOCjqhthqNf4qkOuv3GrsN3fExfFCZjnZqSKlkfJpy9
	0mZaJUQHi608dF7rTkzTKCWLkBLk6EZTMsGJy1UvSCpiMdK57ytd913eM+Ey/D9II+lZfiDLjGa
	cPXZ/Cjc35VNDr6QV5SRTA/Z7HLz2Tf687Rg7EnMBdUXLq+QYmn6crIiJUs+9ljZ/oWdjpGJJ4n
	VVP/jKRiH0sWSGLv1EIIug==
X-Received: by 2002:a05:6000:3108:b0:439:bc0a:4164 with SMTP id ffacd0b85a97d-43a04d81b95mr5906921f8f.19.1773402008706;
        Fri, 13 Mar 2026 04:40:08 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001bfc1843b6ac5345.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1bfc:1843:b6ac:5345])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm17377480f8f.24.2026.03.13.04.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 04:40:08 -0700 (PDT)
Date: Fri, 13 Mar 2026 12:40:06 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 1/3] bpf: better naming for __reg_deduce_bounds()
 parts
Message-ID: <a988ecf2c57e265b97917136b14b421038534e8c.1773401138.git.paul.chaignon@gmail.com>
References: <cover.1773401138.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773401138.git.paul.chaignon@gmail.com>

From: Eduard Zingerman <eddyz87@gmail.com>

This renaming will also help reshuffle the different parts in the
subsequent patch.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4fbacd2149cd..189e951886ed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2448,7 +2448,7 @@ static void __update_reg_bounds(struct bpf_reg_state *reg)
 }
 
 /* Uses signed min/max values to inform unsigned, and vice-versa */
-static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
+static void deduce_bounds_32_from_64(struct bpf_reg_state *reg)
 {
 	/* If upper 32 bits of u64/s64 range don't change, we can use lower 32
 	 * bits to improve our u32/s32 boundaries.
@@ -2518,6 +2518,10 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
 		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
 		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
 	}
+}
+
+static void deduce_bounds_32_from_32(struct bpf_reg_state *reg)
+{
 	/* if u32 range forms a valid s32 range (due to matching sign bit),
 	 * try to learn from that
 	 */
@@ -2559,7 +2563,7 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
 	}
 }
 
-static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
+static void deduce_bounds_64_from_64(struct bpf_reg_state *reg)
 {
 	/* If u64 range forms a valid s64 range (due to matching sign bit),
 	 * try to learn from that. Let's do a bit of ASCII art to see when
@@ -2694,7 +2698,7 @@ static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
 	}
 }
 
-static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
+static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
 {
 	/* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-bit
 	 * values on both sides of 64-bit range in hope to have tighter range.
@@ -2763,9 +2767,10 @@ static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
 
 static void __reg_deduce_bounds(struct bpf_reg_state *reg)
 {
-	__reg32_deduce_bounds(reg);
-	__reg64_deduce_bounds(reg);
-	__reg_deduce_mixed_bounds(reg);
+	deduce_bounds_32_from_64(reg);
+	deduce_bounds_32_from_32(reg);
+	deduce_bounds_64_from_64(reg);
+	deduce_bounds_64_from_32(reg);
 }
 
 /* Attempts to improve var_off based on unsigned min/max information */
-- 
2.43.0

