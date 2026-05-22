Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137E38E13F
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453684; cv=none; b=W/TuPqc001TFptUSsD3AajQ3Ga7CMDM1hlnB+X5oaVrUCxMEXePEwOiDTZEKCnITwYMZnZUtUZmVJ/DAiu7J+/7WzxiH7Ij1aGHhF9oWdDKh9yFCMteFhQgFnYiGV1+Pbg2EM6ml0REKpBXBOfuoF8DeRh62jkxKWNxOUCJguHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453684; c=relaxed/simple;
	bh=K2Kd3pQcxsqBFlbqqWudAqW3CNfDdi0gezIfNvhDKBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=COybQWlHYuLDCLTnBbag0enrY4sTrWdImobbJkWVwrgR0DjeameFXN1722maSuSKOMOg+wzZJdJafU+pV6v/Ol/O10k+ofbBaT9lp+rsBQuGrz/37HCH/lMO8rfmvuvjsG0uUYvnBWtMUWl1tyKy0QOHsAU+zVJ3SZJwyCbP42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4LPgBew; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4LPgBew"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4904127c32cso6686475e9.2
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453681; x=1780058481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vaGTVnVDkb8ouPe24yBBCJM7yry1NUndZsBJBBuR2jQ=;
        b=W4LPgBewexWeEE5/ltIbxQ9xpGd5yxTODv6zU2QrXnAR8FEN7Y24ZGdFnmAMD1JoFK
         Ea2cGZAZQJSs052ypgfo/MDt54K2mRl6nI2OHJX6rsgJm3kLRU6PCBuv8aGhz229eoO/
         YSxhu3FvzVker9cYTmRoQm6KXyQFUKcw87mXswTiqkhE/pro5tvE0l99g3IcdLermDRf
         Oh/clAzoIsGaIECjYkwci8wAtmphtG9OZtKsL9UYdk+G9/gWCIGUalK1KIUHzPEFv716
         FR8wX0KItg2aHmJiOHOIcLwSUm9x48ueMUpSmdO3hkDIkKNJ1lUH1KK0GN6H3jKoQNVO
         9H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453681; x=1780058481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaGTVnVDkb8ouPe24yBBCJM7yry1NUndZsBJBBuR2jQ=;
        b=lcsUcBw3r/tkt+ZQCPhVHGrYsCi/t0Wo4C0Hr5HGDdH37sWbblgnTBf1ybY64bJr71
         FwS3nowVCo4ALRuOM+soNoYRSg+Cd2m7veFX3HN0vjX0ZTFbuIXgcDf8xo1lJ/sjMaaa
         MbSC2clvIVGmYK/SBstY6dTZAlrNsJ4hr9W7eQGznF9da2gy/ZCPT1ywyASLVIEY+Y+E
         td4hHs9F0wzYXeiJWGNozcLb621+O/xQ2wSYsQUDYS5iwMsW7dyP6e7AJllvAcYyWjsG
         6o3fAxBM3SY4AJPI4U4CObiJkVtciy7aOyMBZb1ci0PiGBpvs7YHVd6D5oMwzqzVWUnt
         wJag==
X-Gm-Message-State: AOJu0YxSZ1ocf/1GWH339j/css9tlE0KgQMGBX9imUmGzIQBP9vtusiz
	JEWza0OwFYht7XTzBoWM9o8HPTOw+54/jO5ww6NQ46veHg4QIZfXRqlZ
X-Gm-Gg: Acq92OH8DgZdPd86CI+8wn7plAIYH7D91LCGU0xbR38c/ky6GhQrL5Ze7S2+NWYHZWb
	xBxmRPMeoXwtLyY6/U/F4NbfOf+XThO62k7/SI93rV+UvWbGd6NQIviem9IpWQuiiJpOjI21lsF
	XdYQ3CkNyd0k5YvccJCCwGObMK/ct3IL8JYFFZQ/JcKBs8jpt1katSRu/6I+35CqYtS3l5nyX+i
	Wd89fvf14mbwv/pVOBFzf+h2Z159YKzaifyHFFLUfbbp2eYwaXkCVzj5BoNaby6zqBwHeGZrXpJ
	wISkDW8bbGmMT71IDujC2k3rnrflnHqk2WudAORUPKNt4vfJQcap9Dl0Z+flZAVoOTzOzeuqd/q
	3q9M9sJN4z6JH0t7QR60kCLzJ6RauWa7g0S83tFSrDOmEepJAXSbs7YxxiPHGCVuUbif2UgCRYs
	0CHxoYpui5spvtqbEvqpMz2nJ2vOLqNT0lSYxERt3xwdVyFfJRcTu2pOOODWpeHD6M3uWzz9vIA
	9Dfag/CPM1g+cSUdNVDHFWeQ7pe66WpF6WHfGIQy/IUJFolkfLmya6LJh3se0dxNS1KP8Eyd66U
	qRNMTi5WsIqBFQ==
X-Received: by 2002:a05:600c:4688:b0:490:4224:e0a2 with SMTP id 5b1f17b1804b1-49042ae265bmr45561905e9.33.1779453680765;
        Fri, 22 May 2026 05:41:20 -0700 (PDT)
Received: from localhost.localdomain ([149.22.234.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490452765f5sm38872395e9.5.2026.05.22.05.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:41:20 -0700 (PDT)
From: Himanshu Anand <anand.himanshu17@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Himanshu Anand <anand.himanshu17@gmail.com>
Subject: [PATCH] bpf: Add nelems overflow check in btf_find_field_one() btf_find_field_one() multiplies a u32 nelems accumulator by each nested array level's element count without checking for overflow. The sibling function __btf_resolve_size() already guards against the same overflow pattern (btf.c line 2110). Currently the BTF array verifier (btf_array_resolve) rejects BTF blobs whose total array size would overflow u32, so this code path is not reachable with crafted BTF input on kernels that include that check.  Add check_mul_overflow() anyway to keep btf_find_field_one() self-consistent with __btf_resolve_size() and to guard against future changes in the validation ordering. Fixes: 994796c0256c ("bpf: create repeated fields for arrays.")
Date: Fri, 22 May 2026 13:41:17 +0100
Message-Id: <20260522124117.13846-1-anand.himanshu17@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Himanshu Anand <anand.himanshu17@gmail.com>
---
 kernel/bpf/btf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a62d78581207..b767a9fcf095 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3765,7 +3765,8 @@ static int btf_find_field_one(const struct btf *btf,
 	 */
 	for (i = 0; i < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); i++) {
 		array = btf_array(var_type);
-		nelems *= array->nelems;
+		if (check_mul_overflow(nelems, array->nelems, &nelems))
+			return -E2BIG;
 		var_type = btf_type_by_id(btf, array->type);
 	}
 	if (i == MAX_RESOLVE_DEPTH)
-- 
2.34.1

