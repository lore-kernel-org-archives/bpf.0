Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5C39902D
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711830; cv=none; b=UVJavU6AB2OWhQ/+kiYhn68pqLr5q0eBc0E9e8anaN2wPARwNFRIPWSQeHeCX/hy+jw+E6/SRdjrMsMkfypCdPj9CQ+oXFuiGpngeKsiOJvZBwxoIe16drd7bmiwX5v+cccnI3GB7F2HB8YQEaLKF5t8JWUjlGyb4wcDYiOQqfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711830; c=relaxed/simple;
	bh=iUtcPP1Pt5ZulqEXUUmLhgiAy01m+dHJZH/8TxZ1BSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lki4S1z8ICHI4Bof2aC42Rp1P/WH0oYEVXHx6lX2KQd5zuq+b+NTE4hXmP0poF3/WM15rLJhtoQLO4OxNgvw4yq7V29b4wPoVKNAaeiydM/EupkZ4QySTAj5iBpWZXoeJbpGJBkF7aMvDdIgRijz/teH2A9WkXg4CajPkO7pvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJbThCrk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJbThCrk"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso77999685e9.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711823; x=1779316623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKpq6+xJCxVGYa43jYJ/xXFyp0v4aI8vPatUHOV7cIo=;
        b=rJbThCrkbb6Jt83gsFa68qmhSSvDd/Uif+e99ts8vh0XKz8WzKzUOVrk+UHGJVveb8
         7+GIH3hAE0Bf/gJ/d9gvWTFuO/aTyp5+jR+U+2AxMPys+hrzHwjH0DRAQItRJ3D0SY0n
         REeSF7HpVc2fCjPT3NA9aSB8ESc8kerW9m5uNDjZqQjgIaW1LCUsoeS9Czo15wZql8hp
         wkKLQ1xpZdm6xBXBU4PrseIn/NrgTF48/r+CwGq1xujfw+R4fdeAWAQ2JGws+upszuVX
         5WgGI4vERD9GB5/y6GBTvZxNWsB3q/cjeh/zcIhqtU8yN9TUJcv5f2DWEy7Uzo/cTbyD
         sbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711823; x=1779316623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TKpq6+xJCxVGYa43jYJ/xXFyp0v4aI8vPatUHOV7cIo=;
        b=DXc3p0R9lnUGqNkex8PpEC6a6uG3f9ZyR79URRZ+YTSLQOjuSwQJ9ytGRZVsiq7PAy
         52qdeibjQbr/24z6u3wCmxBJmDDOy2ldhW8t+Ey3gzUnbJ4zY63BibCecTcDeXIxT7ga
         IVu5Yb3rM2hshZxgB8HEENrviZ0HUaNgRzdCH9E+hXMlgDTYGUxwDQtw6aXuTT+3LNk1
         wz2kS/wjtziOjoiU5Mekxh2YSiq1dxhWYP965sGVutdmH9S5dqs6w5KVNkWbNJR9hmNn
         Uu9S2SYOrzDzudBeKvN8Nyit7NeuVeRgZrK3HTLhBqzpX3Iq0s2Lmd2cbMbJ9sjVLhej
         OWtQ==
X-Gm-Message-State: AOJu0YxmzcDbn4BCzaw7kBITM5lqFKICaWWRSwA7pCRUE5n10OHcg7Gl
	vs0AmyP7K7HYc5DyFE3Ckjw7WXmEOZgkaxGbmrfNOMPwj0xCF50apxHr
X-Gm-Gg: Acq92OEKsDTad85K/IhFeW3REbuls59Tv+HU3KJfeCiB544vTCc41In58DbjoXtUyz7
	9cJpzZFE7l2QBMevfIdGxP+cEmq0fT2J2nhTcpJMg+LTBjh8cOAbI0bs7wahiAuz+eplC5jtrgb
	K6TWJN2ZSVs6XyVVKMQYhcHCK7HlRJPVF5cKg0VF/hIFl5NK/f4iprbDJAm3kiTMbkGCK4xA+59
	n+tym9H7XNjdWXaZpi+/twFCxJhTUGmFqJawUmRuK8qRpClIeGnuvgg4VRN2iMfAa5RRRvDK4ac
	ncW85MlxYYF56TxM2lpoHof8IypkXKzhBvYp3l2+Ol4MAVjRfHIDRx10VbNcQYvVQ6a7hiJTmlx
	ClYEGIICRy5DNZCXnJDD0VYwpCBn4TVRMryt4S7Y9TmyBzyBHXhEwpIx8H+ns00bt7FurMr5Alj
	vEpm3h7wl87den
X-Received: by 2002:a05:600c:a30a:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48fd646e8femr14440905e9.14.1778711823391;
        Wed, 13 May 2026 15:37:03 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb2c80f2sm3355555e9.9.2026.05.13.15.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:37:02 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 13 May 2026 15:36:05 -0700
Subject: [PATCH bpf-next v4 02/11] rhashtable: Add selftest for
 rhashtable_next_key()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-rhash-v4-2-dd3d541ccb0b@meta.com>
References: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
In-Reply-To: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778711817; l=2485;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=3kAS6KJ/NeqPfFierPLLooZUN8VMPbbXLJJly/F9Hpw=;
 b=rg7OCBgTJtt+qocgIWf/98WBCo23fd+6JxEjGoN/8B3FXWy4FCOVDRjx0lJCGZrpIX5828BQP
 GwZDf7CJpZDAtMRpZ20DpqC8DDI41L+t71kkUgtrsP24WqUgbQQbIn0
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
index 0b33559a910b..6b0b11fe23fc 100644
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
+	if (PTR_ERR(cur) != -ENOENT)
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

