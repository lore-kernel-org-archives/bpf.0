Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F9381EA3
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790453025; cv=none; b=RNWwKDaQ4nHcOpPT+N3mn8FKX4mI9qVCyp/iVzTKZ9a1LvO8sEmDZtX6wxXFCgyLHfkDvCg98y5yCP5Is4T61K8JUBZKl835bFFGysFw0u5ZuxgpEn1rwFGcj5HzKDB4fF8UT3oTibCdmTFVG1DaIy4+yjKereCuxXCYkIptHxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790453025; c=relaxed/simple;
	bh=Fo5DaFstrSmVMLKymJkXSjconmfqfwAQOAVdYXURvOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSKxmyqeWL9NMj6qlrmoLx/h7+SjcvvCqSV0JoVNWMztpyBGAH+AJpIoXTHqEwuMoPQ7EP/MYo/BYanDbnTgYqfq3HiIZPefPCJ14QWvtEQ/l5I2GbNbhdxO9afeU1PwIJR8qglWYnE8Qeu5vriv9BZeIkQrhCj3I/sZrjzD+5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcrOR122; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcrOR122"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so13804305e9.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 13:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790453022; x=1791057822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=crEKiHcNRykCDD/R67rRRmFahSTLMCA99xfWB3eHuVI=;
        b=WcrOR122mae9HO/x4z+yYJGdqIkO/wD1nsbIDK0iL7xblmsaTcS9lwanj98goxZ4jH
         F8ByVL55X7101ZSO4eYzmN1N+eSud1nwzDpZ7CMWuvacMtj/FKRkp/n1A25QG3B8txUW
         j0WtUMm+X8PsF8niY8jfCwJve/TRmKdLkbLEy445jNRLs5YngRArHi8x3q8nLaDv3eBE
         ZYEKyMUM4ZYlVBP9HmUy/UidcqsTGBwC2xNPzLjOxvzMEozz8OpZBF1rIWCggAJ2mGN6
         9v2b7veGiqTlmPLSpZR2uIFRP8etUP8HKd5HL7BZz47M8p4Tj7ssDrg2hn3F/H/NycGr
         IMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790453022; x=1791057822;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=crEKiHcNRykCDD/R67rRRmFahSTLMCA99xfWB3eHuVI=;
        b=Dv4ysktyVdwEwqFjneO3byytmUhFm5AkcGJTH4eCV4pgUE2dCd8WOj/luADtrMJVWK
         XiCN9GMtf7keRiJYWEYQ4eZ5Wn+cr4GqZEmf5Nuhx1pTF1+F6laI4MD1f5Z8I26n7f/G
         2Ob5ntI/Iy4FIoFYl+Jh5liwcE4em3oTQBL/YrnXlhDZZgYmLlkdQJTHmlA/YfZcEsk5
         uuVzzyssefvotygT0LiEv6wGFqdge3rdQUsqFy9AXV9o7W7dA/2V6o50tJTKaE0YRhp8
         IA4OxWOUOvmV4W0g7/OcjyaAczyxmzxENGhkRApkoERQ7W+13EXUAmKnqLkBGpFR6bvU
         PjIA==
X-Forwarded-Encrypted: i=1; AKwUvByKsLIGkjSF7LVSzqgE16PTy/bkMe2g4tTYkdf7+Emxg2VHEDkGhqBh/hNF5tOCkdTyupM=@vger.kernel.org
X-Gm-Message-State: AFuF++lr+6Vexas3GV7rUBr9TrhUmKi+Hhvpy2ERCKVIpq3pImWKya3N
	35bO7ZvMBjOGZnQq36tNsiGuOAPD2tOdyeYQM49KfKcOXrkqXvjCaI4Z
X-Gm-Gg: AYBFou0woUmXQplPzeD/r28JABVjLcdaYt2LXIWmAr1E3pSwxKaSeOSi0yfLNewuWRg
	rC+Ze6Bt98UEFFmZBx/WN2X0A8Vz3cShsR195eKT2umltoewvyK2ihRaOzClK0HKNdFpNxW31ij
	DKqyf5qN0raHt3czMtKP/9LgD4Z2BFvoE1LL0euO6AJSeVFivmRDTAna69NT+3hJYpcbTLxl4iI
	srufy4ljUbOLTFiyj4Q/SwGSpQ7CJ5cxwFUOnp9AsnFtbDaNxe/mWXqOfG1VFSk4nV0CDHrhjlY
	XHPrX8dDyQWIb0oaaxsFe960IVIN+Y6jSbcoBk9h7C1ac5nCowTNm6A7Bj8YJ5GUAb2HboG2GIi
	g1a54/eUdETWeXUhxqIbcwTD94DTsP4a0xzElV8blKTTLF1aMXVi6F27peRW9+AqKuC0Yf00/8Y
	rsYV6qMnfRDlPVCc8AgRQb9G1cymJrU/L8gVw5/IBXq1USeJis764r/HMUxUqC39sZ2vqKhLGqk
	7ERgBE=
X-Received: by 2002:a05:600c:a00e:b0:49f:fe90:de63 with SMTP id 5b1f17b1804b1-49ffe910591mr28965985e9.28.1790453021999;
        Sat, 26 Sep 2026 13:03:41 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff43ad975sm196648925e9.13.2026.09.26.13.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 13:03:41 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [RFC PATCH bpf-next 1/1] bpf: Remove redundant second __reg_deduce_bounds() call in reg_bounds_sync()
Date: Sat, 26 Sep 2026 23:02:32 +0300
Message-ID: <20260926200313.281893-2-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926200313.281893-1-omermetekaya0@gmail.com>
References: <20260926200313.281893-1-omermetekaya0@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

reg_bounds_sync() calls __reg_deduce_bounds() twice in a row.
With the current cnum implementation, the second call is now redundant.

__reg_deduce_bounds() first intersects r32 with the 32-bit values
representable by r64, then intersects r64 with the values allowed by
r32. After one call, cnum64_cnum32_intersect() guarantees that every
value in r64 has its corresponding u32 value in r32. So, a
second call cannot further restrict either view.

The old tnum + min/max representation could require multiple passes:
tightening one of the 32-bit or 64-bit views could allow the other to
be tightened further. The double call ensured that the bounds reached
a fixpoint. With cnum, the first call already reaches the fixpoint.

Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 kernel/bpf/verifier.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8d8923ad5..1cd923363 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2180,7 +2180,6 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	__update_reg_bounds(reg);
 	/* We might have learned something about the sign bit. */
 	__reg_deduce_bounds(reg);
-	__reg_deduce_bounds(reg);
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(reg);
 	/* Intersecting with the old var_off might have improved our bounds
--
2.55.0

