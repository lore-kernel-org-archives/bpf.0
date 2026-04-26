Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBA726F289
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777224338; cv=none; b=lk/sdGM9ultzW1IhqFYueYeaIKQv9fLbS529LynxH6RG3qt2/sugnhLjBh87vv5Pt9obXTPoO1SuQR8KeuUb/dFGqgROFzJr5SdqpmoNOtLAJgpl+Yo6qC9Ouuj3eqqObl27cufdtdiOqb0ZwgIhWbwdG8DlXVjsgObUgNl5SSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777224338; c=relaxed/simple;
	bh=YdKvJO80/Hyqh5y9hrOSyc7hbOFwuSbEewRXk0VQ/mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSB03NfzgXognOEbn5KtDScRnyQAnpFrs8VDzjiQowWRWRw+ud8C1ezHQXEQ1j3oQEI2I9Q1/YBxO1/DG6/mD7Nn0HKMwArnSJC4AHX9hAlW+S3k8KJANztEm2ScB6eC0nOM5ZcgJ1J6CRTZv/4Rt2BZL/p1Quqjs8jDvSQ5XPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpQXZE/N; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpQXZE/N"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b299b3c739so43281505ad.3
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777224336; x=1777829136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+6CPeRvdvvPwrZtKUyWHox6m2QvzqSu3dsuue3xfPc=;
        b=YpQXZE/NCeE4RnOzT1Zf4+u113xNGMLtASCb6U9dF2FLsS8YefYuinDRtaYNozV+A/
         xEzV4ibLySd/RVW3haYsqtZ0CvseVweJo01Rq1lfgfsG0xOEmbeYDXHaNlT73kOFXHOU
         J4Jf7YIy7su3ak5PCZtdY8pnYCNmmKOs9ofQVmf/HZCmY5u1I7wRdFxAmyKUmM/uaceq
         sitypVnuL2NWvrd6sCZG/2a5f8geV82KWEoaZBfmIyL7jJH4ykiAXn7taYzURZFb1jbp
         hXkc/JAW+QoAHRmZnyCJ0YjTzqjnOaA5u/0hf/zmjCwxqMh0rdIef5H1/JjlKMVTfMmX
         xdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777224336; x=1777829136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b+6CPeRvdvvPwrZtKUyWHox6m2QvzqSu3dsuue3xfPc=;
        b=F1wgia3j1YfsfR4vLaE9JydQuCWdXh3QkUXRHcsrkZIaGPLpWpIvYfSVVlwFKsntlY
         9LXZ3LKpd7G25EKD14bCx9b8Zfcd70hC7dr91zAuJIb/Hh7ZLl+Nw9a54bS7uVIBPW0x
         UCdKb9Fdl8cHWiIGRm+zLcvNSVxIn5k7RF5oWrARNFiGkC9a7QOdyYmWKUeFl8eCqOMd
         ZVwb28eH4Q86CuxgwrSjbOkiR+/gN72TgkrOqGRiWMspWntO0WpWnKpkjEe/bANzYSOv
         eBbqU0tp68xAGIrEz2tSf+ZX2inGdqu5q008Tp5wBOK+lilV6sCu6jLSSVYrZIkQc23o
         Ilow==
X-Forwarded-Encrypted: i=1; AFNElJ8K4yPhuTL8IVQBRgk+/UnqkJburrt5GjPXbWfhLtzi0ax6eYoO0ReWSFnnLKMyPqKHC4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cZh64Xc63Pctq7s80yH1QXmcsXjuzWAnJYRYbwyfHY07mgmW
	5IcAxd4BdG4fJ47PhWrDkL7S7wb7UITeCYdXPkEjnyPD55bQZ2uePFjo
X-Gm-Gg: AeBDiesrQLQ3s1FoXjyQCSV+Ilt5M6nKHsRwQWV9I2esdxLCCIh/eOEYfeo75EU2mIp
	ALS62/5aVW+Kqjtm0cGZ+O7zgaLVLKwwUfRi4sBH0MGxQadd2XuON/iyAbJsXugpyMJ3Xxb+6kg
	BOxDQNuuhPcM2MsxIUow1I4SJdeazFSnV3HQoBxYs53rk3AqLxcZpTRAp7Bbw1jyhe0D01HvIKS
	fN/VAtbJH+wmV4gZXxLGvngPjJJ8YYUJH8EdthJ8U421D+ooa6jnRi1t9I4ekQNUdY8D3/zM6BF
	IPsHMeHOit1qRHTeoK6GxPn1tmvEQr4/KR5GMJlBaVQ/L3tAHqdS6c+9ULEkzUCaIahgpRzsVUy
	Qt0/EW1aZdXCHrTq0x+TVI+uifE4E4gHxD9I/pIeSLfveMgdFaz1T+ONVF3+JsLqJYOWHfQiKmY
	TyWTbsCwhIaHrFQBGtvsxOvnfm9te3y7av+zN1nKA66qJ8VhrdHPj+ipg=
X-Received: by 2002:a17:902:9a4a:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2b7975cdb76mr126726695ad.1.1777224336274;
        Sun, 26 Apr 2026 10:25:36 -0700 (PDT)
Received: from localhost.localdomain ([121.169.163.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab2112csm270275605ad.62.2026.04.26.10.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 10:25:35 -0700 (PDT)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greg@kroah.com,
	security@kernel.org,
	Junyoung Jang <graypanda.inzag@gmail.com>
Subject: [PATCH bpf v2] bpf: Fix off-by-one boundary validation in arena direct-value access
Date: Mon, 27 Apr 2026 02:25:05 +0900
Message-ID: <20260426172505.1947915-1-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026042614-scowling-hankie-f84b@gregkh>
References: <2026042614-scowling-hankie-f84b@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_MAP_TYPE_ARENA accepts BPF_PSEUDO_MAP_VALUE offsets at exactly
the end of the arena mapping (off == arena_size). The boundary check
in arena_map_direct_value_addr() uses `>` instead of `>=`, which
incorrectly allows a one-past-end pointer to be accepted.

Change the condition to `>=` to correctly reject offsets that fall
outside the valid arena user_vm range.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
 kernel/bpf/arena.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 802656c6fd3c..49a8f7b1beef 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -511,7 +511,7 @@ static int arena_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32
 {
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
-	if ((u64)off > arena->user_vm_end - arena->user_vm_start)
+	if ((u64)off >= arena->user_vm_end - arena->user_vm_start)
 		return -ERANGE;
 	*imm = (unsigned long)arena->user_vm_start;
 	return 0;
-- 
2.43.0

