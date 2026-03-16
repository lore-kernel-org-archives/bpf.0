Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4E26738D
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660559; cv=none; b=ZaI52nO6BsMm/JRw0px5YT486mNYOVasYyJgo2Efz4o3mBZKx1i1TjtZTzW1bYuVjRl8AFHKUcdQpDey9OU5OLuh/eY9QrhkKcmR5t90gMeR2ldFRGemMV6l7VULV9iv9GpJn8QxAI5FYGta0InEDyy2HvESGtEpX2dT0mh5qsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660559; c=relaxed/simple;
	bh=X6NpjHI33SxFJZtV58lEW1oBuVxFCOVbuRWaUibfXDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4jXUjIYrl3gVqn7o7QXVqnMYoOfpnEOpKt6U+W2KpsBOqGojxrRrvw/Z1jx00+vNKnQ0Vcnf0QJ9Td5fVM37Bh8j4py7SRJvxRpxE6ja4LwDVT/LL7+Rs/hMVdodrmFjmhgvMTeM89fGO6A3jBCGIh6GhkhxBNOD/kIdzyHn8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDIu095M; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDIu095M"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c738d327336so2782260a12.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 04:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773660557; x=1774265357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xcdf8NjYRYFE5tIQAMhp6zvGC7XeDqC/XeKloLYP+1w=;
        b=UDIu095M5+CBbIhot34O5IZt9TCm4RWOVJCY3mcOFpqfQr2ymU2SO5wrOagnpN2Jr5
         Dpo09el23CakLIboz9Ow6mxjyZ8pryC8v2BJu7VHlKLCrTrxUwlqqyxJpvdvIIROo+7e
         ubq4iXRbNjuVygDfDCHz8xbBAynkTOJgbXn8xu1hArezT3yLzoTAmGNG/iAMv6kieDcW
         v3FzqsvJagorsYPfufdfVbya/eUOOgapaT3eC8ok0u06pnGZozdXxjDXhZb8R4+MDm7C
         twfxUa6tIAB0C0bg2lEExfHcqmkXPGUH34o/3hqmCyEVQ5cPztDSEZGcaMLEBcO+7W3e
         sXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660557; x=1774265357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xcdf8NjYRYFE5tIQAMhp6zvGC7XeDqC/XeKloLYP+1w=;
        b=OHkJo4RWCQnRt5Hv2SRCWTzYay4RvCmfp1xJAEhXVlgUaSQZS0TPleJDX0J8JP2b98
         3a6fxzI05NaJDWgq6Yu/EfRKIpsbovVKidIiMoihyHzhJgVg3LjUv2EmQp9XVNEvIHOj
         iX44kGg95QuTVFFucZlD4L1voQHewLsitbyIACgs7ezXCMiz+x5AheFuUKfTkQksZ2EQ
         3TVX25wBpGOHcyneXNEg20yZZYOBxA+OmA0uEfXWfBANUoQtKhoMPHEy+vBatALGP5+F
         pvRU912Bf2h72SDu4OamR/rtbUa2TJsuXJn78XT2SmAn6hwBQcXpg1DD7KZRumhZ7lNZ
         tP7Q==
X-Gm-Message-State: AOJu0YwW8KHIy6ZoydLv2/vz5/6Qq6zuiJP3nnpGvVwvDhWg2dmlz5be
	VkHmZUY17DBxPe2Hzg7kghQiQYEP246FgZR5exQRpMaSfCqFpc5S0Yuu
X-Gm-Gg: ATEYQzwBj/Ra+hxg6SZbdKHDPSyZiOH5XP3QTu8mwToZMdbt9qOqUHjhHvpLEkIZ8Ef
	qZoWQfA1th5CWm4Vfv+67EJG9GX0CSQfYSkVjW0N7uMhTy8CGEV24lUMq678C84WOhlgHZF85Y8
	Dq7VRFaeD0PHEBq2s+gQFuU+AGkMv+9kqiIep98du1Rv2vzR57ONVDYrM0/HZNM503Jz647/jyp
	lJnaMfwpGhBxDIzgSPBNObae2GqETLew+CaFSfa1p3EuWToGM3wwdJMt+U2JXQ+rq1/VDhMXgVv
	NQjWhPczoeMbt3iy/eAH0T4fWYMZzdIRIUAXZd24Zr1xHEWCRbimb/9BlfP9oyY5caWDVltYfKG
	E+93mFZzPUN9zKUiIob0i5bfTA9Iyo6AmRpKfL3obgxLTMMAF8PspIAH1GZF/b8dekU8FS1DOO4
	Kn6Gg1HnNQ2yFwM5NKxJLI2aBE18ZoqMiZoHRnqSVnYuJCRs1jAk5Hda8=
X-Received: by 2002:a05:6a21:6317:b0:398:a060:a967 with SMTP id adf61e73a8af0-398eca11578mr11470604637.11.1773660556858;
        Mon, 16 Mar 2026 04:29:16 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7401588ecesm4684940a12.32.2026.03.16.04.29.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 04:29:16 -0700 (PDT)
From: Chengkaitao <pilgrimtao@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	chengkaitao@kylinos.cn,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v8 3/8] bpf: Introduce the bpf_list_del kfunc.
Date: Mon, 16 Mar 2026 19:28:38 +0800
Message-ID: <20260316112843.78657-4-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316112843.78657-1-pilgrimtao@gmail.com>
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

If a user holds ownership of a node in the middle of a list, they
can directly remove it from the list without strictly adhering to
deletion rules from the head or tail.

We have added an additional parameter bpf_list_head *head to
bpf_list_del, as the verifier requires the head parameter to
check whether the lock is being held.

This is typically paired with bpf_refcount. After calling
bpf_list_del, it is generally necessary to drop the reference to
the list node twice to prevent reference count leaks.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 11 +++++++++++
 kernel/bpf/verifier.c |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e87b263c5fe6..dac346eb1e2f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2437,6 +2437,8 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
 	 */
 	if (unlikely(!h->next))
 		INIT_LIST_HEAD(h);
+
+	/* verifier to guarantee n is a list node rather than the head */
 	if (list_empty(h))
 		return NULL;
 
@@ -2463,6 +2465,14 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 	return __bpf_list_del(head, h->prev);
 }
 
+__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
+					       struct bpf_list_node *node)
+{
+	struct bpf_list_node_kern *kn = (void *)node;
+
+	return __bpf_list_del(head, &kn->list_head);
+}
+
 __bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *head)
 {
 	struct list_head *h = (struct list_head *)head;
@@ -4549,6 +4559,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64c1f8343dfa..e928ad4290c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12508,6 +12508,7 @@ enum special_kfunc_type {
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
+	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 	KF_bpf_cast_to_kern_ctx,
@@ -12568,6 +12569,7 @@ BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
@@ -12644,6 +12646,7 @@ static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
+	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 };
@@ -12652,6 +12655,7 @@ static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
 static const enum special_kfunc_type bpf_list_node_api_kfuncs[] = {
 	KF_bpf_list_push_front_impl,
 	KF_bpf_list_push_back_impl,
+	KF_bpf_list_del,
 };
 
 /* Kfuncs that take an rbtree node argument (bpf_rb_node *). */
-- 
2.50.1 (Apple Git-155)

