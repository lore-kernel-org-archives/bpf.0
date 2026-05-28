Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE73E1231
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990467; cv=none; b=sOqFhkPxCgumGwIJ/G4DAiTi5pmL7qQ5rSL02V7HIj6loNU6wJt6Z4YR3644Jw/YZhjyQMdyqOehES7g9LSBv2WbXbr5PKzdrnsIXWi2cy36vvZaTYG9LlebZxI5futpsj3yZfGONE1MxOmF2sjKCn/jwaLxhrhgBbnmQepS8Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990467; c=relaxed/simple;
	bh=/lEueV8DeMX/PNOiLN5TFUbKn2LYOYLvFm2aS/us4II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tZcQQ+Yp2vrfwUiMj6XLVjHZQCVySF6/Zh5cAOPqOC3WcmvNUUqkmTyQUeWLelAV/1Nv+0n2yqLaFjD6GRCOgYoRzgGW9v9TcGJlb0j1NSqTWkXmyI4ZlJWdz0+ndwQDKbfctL71O+k5Sgksen8Qj+9IbHFU8YFeLMQug+D77ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edTtjRyV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edTtjRyV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4905529b933so46913525e9.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779990458; x=1780595258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icjfP91pvB48TPe+zFIYgOntqop3zG2k76gg/oMMysQ=;
        b=edTtjRyVjPSwH3LiL8OJOUxf1Se7VhvJ/jtw1rTfgYqmoh4T9aGiLZ+/kiqJ9oVS9p
         iXokVPtmaCRt/OiSWmNDG7bB+8ItTxjigCTk0JEJqWUN/IqZosRtpSSabB4m2sn+3QjY
         xHlJwW7x7ImWm128DggL7wL2ZXKGp11erKwHpwTgvlayAmzc8Qjzmrt/zKmisM/3jnFc
         soiA5e4YvKXoDKfPEWo6Bt1UODCXQzMdSn8sS3BHTUuj3r4dCfO3TEav2p9K8bxznuuD
         nr+caM7nzMStONpFxIoaSe2wxadogBg6DM6WzyGQyi9Xrac85u3v/7pUAOqmgZMt2Ka2
         eugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990458; x=1780595258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=icjfP91pvB48TPe+zFIYgOntqop3zG2k76gg/oMMysQ=;
        b=JxhBr7hC9j7lUMXZ+dd6dUxQFCUzOCEGUm/8NsF0+Z2Xgk/EsA8qoE5e0Fu/XiGTAe
         Aae2b0sismoQh+2FXKT8BvW/UmPktxZPNjOdqiU3O3PZZqOz8SL6eWADkMri+9vTeF+U
         m9akP3g4exbSmTIWr2WIDJ+c5bQXub7ZU+sROuo2cm9UtJ3D6a5zbFS9u1RAmC18M9LA
         LWTk3l/daOAxr+CiNyRwKSBIlKTtPelCloALlH5lWRnY+EWm7nlFO+b7E6AGWfD3/xka
         uhTk/SMA/jDQP/ykbIJNRBkW1cVKxwbUB8GTjR3fhZ6hYMDGN1VoGQsJZ9wwoJkSehe1
         jB6A==
X-Gm-Message-State: AOJu0YxChJplWlT3k1eajysCYcw4aVRYI1fm/TXdbAQXyni+SOD2egfC
	QsSkYkl2NAHUyHhVBbowMjYhiEchU1HftsNK66b/stfMjJztzFwWl9qT
X-Gm-Gg: Acq92OE8hHTjgMrI8fre4WPJ5FtTgHg0y2ThMUnJ7tTsGhyHP47MSSpwAavZRGo2tIp
	tv1muQCSMymhS2yx13FeOq3RUdeO5eTmMUgkPPEZvNyUr2UM2TNBtyLnNQJONZxYTPzaUpW0zDg
	b9IlD+GAZr5OVKL3TcmLkPM3HE6AWGWdQlQ/nEid2DvGgbdlzOhsIRHFcW8MtdVGMnCl/Is+L3a
	gHkQGHLAjfIhVfUmiCMklja9RP+dvv6MIN5kw8ycLxI2Ko6CrEmsqJQa0QItToI+efEJKMem3AL
	D78N9/6HpinmRSQL0EokUyOBMhmiAYv1CLbJ43pT7+hjzs4CQk64yWfgKIqGoWSehgOZ2J2f8Ve
	SNm6VSt+ahSTrb427lcbA0cmvyAZA5yw9X966poVxI6xY8lckcBC/z7v12TThI2ACJ4hhPlhJAF
	y8kN5+zMzejdX0YL66NZBdBavzwCYr+NMscA==
X-Received: by 2002:a05:600c:4746:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490469c56d6mr445581965e9.12.1779990458092;
        Thu, 28 May 2026 10:47:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908f0b5c9dsm19217765e9.34.2026.05.28.10.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:47:36 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 28 May 2026 10:47:13 -0700
Subject: [PATCH bpf-next v5 02/11] rhashtable: Add selftest for
 rhashtable_next_key()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rhash-v5-2-7205191b6c57@meta.com>
References: <20260528-rhash-v5-0-7205191b6c57@meta.com>
In-Reply-To: <20260528-rhash-v5-0-7205191b6c57@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779990451; l=2501;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=hCWN0uZvucVBZGKvUhn04KjDXavGBsZ3Bxo8ufb/6p0=;
 b=xz3d5GhHmF1Ph24kUZyM8Xy8Pt0uhglu+k/Wba7c2Qvdc7K1tRdBigH4HHKtEEbG8ufCgWGL4
 s4D6Stxv7IsDYoje0I21S0rAFdVIJgyV1xm4BVe98cg2a0Z7LiFgzL1
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Insert n elements, then verify:
  - NULL prev_key walks from the beginning, visiting all n
  - non-existing prev_key returns ERR_PTR(-ENOENT)

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 lib/test_rhashtable.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index 0b33559a910b..c7a0817b0be5 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -679,6 +679,76 @@ static int threadfunc(void *data)
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
@@ -738,6 +808,9 @@ static int __init test_rht_init(void)
 
 	test_insert_duplicates_run();
 
+	pr_info("Testing rhashtable_next_key: %s\n",
+		test_rhashtable_next_key() == 0 ? "pass" : "FAIL");
+
 	if (!tcount)
 		return 0;
 

-- 
2.53.0-Meta

