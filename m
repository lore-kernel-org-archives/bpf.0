Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4456C3876B0
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433178; cv=none; b=js8wLGLf9+bRr5gqtQ/H+Wl6upU8F4lfkANGOPGFDb2LYmx/argR9tJHpj6xduXrGZZUCZj6eYKoghb8T0+CyrUd27l2JgRxZGFKLtzQ+qCYT2IKKs7XGaZ6oEUZHanUqMd0WgWMseJyDNpBSyVU/hCcq9uJh5ss4zCaqxQstSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433178; c=relaxed/simple;
	bh=/NXtkE9hP7be6g5SW3oUyhHd2lo1e9Yj0h/lnFtBQlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxWTalOO4fHifK0vi3qvq0xdKVFO4BZ6cvmNCXHT4DFhqFE6j8F5EwooMruTNfJ08C/GB806boOwxv59L2RKQKdxIQ8OAjgM/JeWw4uGPT/5g1qgapQ0dDkm8nIBP8gV0jm9bAuEhTHE4GrTXfiewTw3EzM3trXvjUpSKOUffg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAtJFA/K; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAtJFA/K"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so5447095e9.0
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433170; x=1781037970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpQxbss7eIXCFzoJWXCkXMUdlHdlBiK0om+KULSpGjU=;
        b=cAtJFA/Kb3k8AhTxFCS5O20mABLpzaco8ooxWioeU3NgtmTwWkQacI0psVsN0imlQ0
         QkNcBtzM63oAWigE22bdB/5Bct3KDhxKDbFNhoYUCKWdraDya1Jg9MSTiXC15vED4Vmd
         zWapy6RYaUfey+UjKZLSh56JvzBDutK63Q+0S7yqJEveehQh8S2ukYFlB4dVNufJlhUp
         XkKQQCUdr1fNfXzz+WGqoFLSYtFtarPHq6EdmdqRrtI04sWSRxrMvpBLsaD5Kj0rsIxw
         pf4MgNgG1vdSy3xIAmkRka13/m4T4CPZmNKtYd5OLutqaTyQKDKtwlgP0x7DffJCGmTb
         x6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433170; x=1781037970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EpQxbss7eIXCFzoJWXCkXMUdlHdlBiK0om+KULSpGjU=;
        b=NaFLOGyFWbd1gTVJzG+rsPWTdxrDA4Yw7YrhHHMfN24HrlXMV/xsLexROMm29ZCGYQ
         0qN0V+M7WQq2vo15r/UQ/uSXoezSDhLCutjw+LqMTZdI2CMvnVr1M5RXD3oTYxel1i3k
         +uhgyV5szhn0dQHPGKZjykuM6yfIR1DLyNdJ7rVHhqvapO9i12gwnu+tgptoL3mLyGto
         ktRdd6Rc7MrHZOlIjj6XRLC0eQgbzz/mGWm6ML/NYbLJUj+w87bquuAzeFIcNuqhrKxZ
         wuBudGc6XdohqFz0dPueoaVY6BpLJHWfyOEtBrOXbfUHOZsAVciAeHUMRoGcz4MGcSkv
         JI+A==
X-Gm-Message-State: AOJu0Yy6i9/NqVQJK6Gue89wHwD673rVsfXOgutbzB5QYxYP0G3TdFBl
	5CHr3lRrYnTFcJzwvQXjn6TYZycFCvwU57pHVOE7C3gPdgjq3qg2YvKe
X-Gm-Gg: Acq92OF5kPnvKojAJBBbDS0AAcwTnhI7002xZ6zIu5xpmdqzC8xzyrdWRR1nmcadHRC
	GC+3HffeKs+O9PkpspaLj/jooy/xYVWiXH+CevZliCDi4JNZ92l5dfD2d7NA+BxXNR9Wazx4CeV
	8PqMD3KQe+EBwN4utJJrXHLyJzUA0YHN7hn+HAhoDEKLVpZjqBTWQv5xcJJR5/DQV2I4m7X2fOB
	RfX2FmbP1OuYexx5rN/WStB/jdgqt5FXjMTkcLR+Xfk2/DYc1zOnqmMMx0sAUzSZKePdT2/5PCM
	k2Z4a4XHwJWhUD2lR+2WDd4vK5wLRjaBno1xCZlB7DpF4qNUJv0XMBc6JVivPFijh0d15jQ15OG
	ufTP+ge/nPQURSqLMn2lp8c8T0+QX8wBzQ/QJe2w/z9E+MoJ9/gnReb6fwJnSgYUelfSaMIBCiI
	oxk1B72B1CJqjtq6ZZyO8U+ruQW+Wgk1Kj9B0=
X-Received: by 2002:a05:600c:3107:b0:48a:563c:c8c5 with SMTP id 5b1f17b1804b1-490b5ea6b7bmr6442205e9.8.1780433169454;
        Tue, 02 Jun 2026 13:46:09 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm2030697f8f.9.2026.06.02.13.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:46:09 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 02 Jun 2026 13:45:31 -0700
Subject: [PATCH bpf-next v6 02/11] rhashtable: Add selftest for
 rhashtable_next_key()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-rhash-v6-2-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
In-Reply-To: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780433165; l=2530;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=IdQ3gPZg/xGvTXclYcGP95K7Rt5GVwzTCGhfzkZji9U=;
 b=3Y7Fg+Gpvvx/VfUfqHDQxBNbh1kdVwr+e0DjMdB0gd60l5aemQ/uHN3Uc1n8z4rxErOTTAFMq
 W7fyN4yVuzQBjrglSq93Yi0NHwFICEbOjuYWKpGKHOFDybWcdwRVtDY
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Insert n elements, then verify:
  - NULL prev_key walks from the beginning, visiting all n
  - non-existing prev_key returns ERR_PTR(-ENOENT)

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 lib/test_rhashtable.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index 0b33559a910b..e9e7253a45eb 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -679,6 +679,78 @@ static int threadfunc(void *data)
 	return err;
 }
 
+static int __init test_rhashtable_next_key(void)
+{
+	struct rhashtable_params params = test_rht_params;
+	struct test_obj_val key_missing = { .id = 99999, .tid = 0 };
+	struct test_obj_val *prev_key = NULL;
+	struct rhashtable ht;
+	struct test_obj *objs, *cur;
+	int i, count = 0, err;
+	int visited_keys[8] = { 0 };
+	const int n = ARRAY_SIZE(visited_keys);
+
+	params.nelem_hint = n;
+
+	err = rhashtable_init(&ht, &params);
+	if (err)
+		return err;
+
+	objs = kcalloc(n, sizeof(*objs), GFP_KERNEL);
+	if (!objs) {
+		rhashtable_destroy(&ht);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < n; i++) {
+		objs[i].value.id = i;
+		err = rhashtable_insert_fast(&ht, &objs[i].node, params);
+		if (err)
+			goto out;
+	}
+
+	rcu_read_lock();
+
+	/* NULL prev_key: walk from the beginning, expect all n elements. */
+	while ((cur = rhashtable_next_key(&ht, prev_key, params))) {
+		if (IS_ERR(cur)) {
+			err = -EINVAL;
+			goto unlock;
+		}
+		count++;
+		prev_key = &cur->value;
+		visited_keys[cur->value.id] = 1;
+		if (count > n)
+			break;
+	}
+
+	if (count != n) {
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	for (i = 0; i < n; i++) {
+		if (!visited_keys[i]) {
+			err = -EINVAL;
+			goto unlock;
+		}
+	}
+
+	/* Non-existing prev_key: must return ERR_PTR(-ENOENT). */
+	cur = rhashtable_next_key(&ht, &key_missing, params);
+	if (!IS_ERR(cur) || PTR_ERR(cur) != -ENOENT)
+		err = -EINVAL;
+
+unlock:
+	rcu_read_unlock();
+out:
+	for (i = 0; i < n; i++)
+		rhashtable_remove_fast(&ht, &objs[i].node, params);
+	kfree(objs);
+	rhashtable_destroy(&ht);
+	return err;
+}
+
 static int __init test_rht_init(void)
 {
 	unsigned int entries;
@@ -738,6 +810,9 @@ static int __init test_rht_init(void)
 
 	test_insert_duplicates_run();
 
+	pr_info("Testing rhashtable_next_key: %s\n",
+		test_rhashtable_next_key() == 0 ? "pass" : "FAIL");
+
 	if (!tcount)
 		return 0;
 

-- 
2.53.0-Meta

