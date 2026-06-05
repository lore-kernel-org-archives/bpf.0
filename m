Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2223A4D2EDA
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659701; cv=none; b=RfekH7Ux8suRnJRrh0y/dfk40H8xe/XgGueGjQAnEiiJsC4oB+4tl9nz7W7FGYTmvsEC/nGjRkgke1/MIUocVdP28zeRhXjl1Rlz31JC80NtoPOciIA1V0a7ddhpmUiJyaZUCOz8ulIbPDqs+ekHzPbQ90aSqgIc/O3DpdzS1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659701; c=relaxed/simple;
	bh=MKU6yBve4LjhtdOFr7MeChTTtRKGWSFP+YzG6asvfG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MJsE8SzBXUBbnijgWKXd+E9RsTxEhf6kw1gHkkPGK3Coenv+PvYx6/oI5R0GRxuU0AWqSTYjD1Y/er/bkJRE3AfZKSgpf2VhWKoEQEiCmgKf0c7LEDxSiS0xMxsA3dpqjA1bt7lbqVG0wQmFryWjM12q4N5NLGe3E2A80L3si2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwcm7JjV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwcm7JjV"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b64c8311so21267295e9.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780659694; x=1781264494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzhooMt9YamJsJmY7qrxU+cyIJXOcnC8Dw8pcWYhNh4=;
        b=rwcm7JjVnL40O+TouKdiorUEu75AsOf5GaESSfmoUztbabzWq3FsmdsqpFXgLtsJDj
         NCJAm7NEXkzio19D8lkadhgfWJK7bgCYs60wjGhSqw5Pf26IPSKPERuoSmEUjbtHPzxi
         iom+SJatoLOs7kQEXfnVvBfl/3I9iK1kFsVIk689iSL64YKzx5nz9iOGa7uKoVMtBXym
         r4dAyhwClNf2zlz5enmqqgDYmHdzapXhS+XaMpPesh0FUtNgLBJkKEoUyqisJE7evfJr
         AZWPzdUU+znn34Jlm4q9S6Rv7OYnJWMnJojKQvsnAjabhpdpkg8YnlOokPkxA6At0F+i
         aadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780659694; x=1781264494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yzhooMt9YamJsJmY7qrxU+cyIJXOcnC8Dw8pcWYhNh4=;
        b=B70n7iTcfH4+zUt4RVUv2QAxfcbbfkHJHW3ECoqw+zK6Mu2YiZpERK/+TxBKg95uE0
         rilLjKwKY/OdbKoHC2Nz3wEoY3CSS4maG7l8/FS4+5/rdy051ihPP8hONu2O0acUOHZV
         nWz9r0WYtYMDu0zfNYCwU6v3Qc+w1BnnYw4T3OIcBi37SQi3WLIdn9ubd9GcQau5KF86
         ym1fgnpZdZkWCJEWn2Du8WcTISfOr85DXhqLOSn1kZNBwJNlJjHBe4h4hm+ZZHvLS8oR
         4MlHFGZabtTqa5+WVCu1QX+jW476vk44zMiaUEIZwceFqC3kQF0bJQDxfvSqIxFMvx1a
         bNnw==
X-Gm-Message-State: AOJu0YzJjzymbhHkQwq4oxaMihKj4wP3v1wcqCrScwhtxgwYzBEseup1
	uAAMTR+fmMx90RrOWCU7VWcslc4Y6fVdwqt77Hrh0Q+lDM/5/HhFVzzt
X-Gm-Gg: Acq92OGF7nMvImahGjy0sQgiqWcirG2qaZDI6hXcCU9hSXAs5Gt/gNEZGdPN6j5Wm6r
	eDIvoS5svfZepVcAfjE5LkOvx6j5VSzWemxXflYhqXc1djjs/p0mb+RG0/LtFwnoWTT1XSOwiqN
	080Nxh//rISDxH/izhUTaLXNM/aSVGIvCthcmyzYi0I8RDHMT959+S7RTtf08WnLty/Vxkib49r
	lQngL//SAig4ZMP8eFp0TcWZbAQJ2z0wvQDHFxRz5y/0zojHzcJNgkRNSzuXtjJGpFSJ3nxlbLF
	kergznjG4JYbpDVnC7vPVrKvGc27yRrV6pa9oLHwHSRpooJl9CNr8+guPhMei3c181F0pMUxVvJ
	NNfm1eWHK6jy1ZCJ53lalVNZ3yHJOXM3FRrsSEFblfQbZuybgqqt2Q7I7VuqpgK6DDg9ysao2eM
	n4E92jY9/By5eRcS13r6OmfwwcKRWXOXrqFhI=
X-Received: by 2002:a05:600c:674f:b0:490:52c0:744c with SMTP id 5b1f17b1804b1-490c25e2dc6mr47966545e9.20.1780659693513;
        Fri, 05 Jun 2026 04:41:33 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm26831733f8f.20.2026.06.05.04.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:41:33 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 05 Jun 2026 04:41:19 -0700
Subject: [PATCH bpf-next v7 02/12] rhashtable: Add selftest for
 rhashtable_next_key()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rhash-v7-2-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
In-Reply-To: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780659688; l=2514;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=W3S120oLEe4kJEUhbDGjRRt2ZE7Zv+042eugYyCahdk=;
 b=9jes29pR/yMJ9ytVErwW1O/I9n9M6EHVuQwG8txMzJ8r8SYr4fdx3lJfqWd/YtH46XT/Jtg3T
 wV3bMumy6chC0l8dLP9+gT4ueMJud/UEWSEE4s5Depu++R7vN2ing1Z
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
index 0b33559a910b..b767a38a74f9 100644
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
+	while ((cur = rhashtable_next_key(&ht, prev_key))) {
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
+	cur = rhashtable_next_key(&ht, &key_missing);
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

