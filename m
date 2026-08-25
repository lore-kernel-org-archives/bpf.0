Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46E3EEAD8
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649607; cv=none; b=TkNQdNvjc29+bQuXjsJGzWzW7GSGuqZmM0TWhIkSkA/NQbIqhMaPIvE18AfCmLaRoTYi4IaM5Dp7moFvHZDiayl3uvq+NUpqrB7moWr2WjPIXfbO6zSablnXeGNoef7kJUL+hTABqT0MnPmb3/3JdXXacZpoi4ySnBshncggp3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649607; c=relaxed/simple;
	bh=PyE160OajPSsqQd9ddyOfvbdMpeClWf6VPakHByI8uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErQhDd7W3SoPt6gpTr8P8WDtKFHG4VhTvTmmHDu0ULNJwVkO94tSebDo2/9MzX57ez3VuZqBOdZM9NVMkMJyV74Nk3FtOiMRtuspWcPHyISBYI/PPKA8qMBQwgXDfiPh1G94xzqhXKQLVtm2RNnkWv18zdXjsU8Ej9nBjnaT++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hO7OLmw2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO7OLmw2"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so4384529a12.0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787649604; x=1788254404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7cSIyxl/i1oxSUvdnacr9V24YcqM8fZNDWiyKdu00s=;
        b=hO7OLmw2zO6P3bvQ9LbCNoSaj8aX03efx43YDK+GS4L3ZM5cjFcvsaSpANllFuAfy8
         bWVMt8A5NyMNcu8hie3uU33KDWUoToQ16K04Rw6kx6nuCDw/zg6e3SzinSiO1NnqEVEp
         vejLxCKCrwKcp6mAQdkyWeEgtL6a16msKngy3Y+sv0jRYJe90vbfg3cpCO1ZAMBhBBem
         ALlTkOys0UxXgZpikAD4opGx/kDkeNTIwanQJGnSpChEpGKmVLivRH0qiqgSFQBxaa2C
         TQIB8F52HULgc6mD6a5+T9rb9Wnf40nwTF65GdfiQ1iRnjU0zX43UZmAcfx4vzmelswb
         A/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649604; x=1788254404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7cSIyxl/i1oxSUvdnacr9V24YcqM8fZNDWiyKdu00s=;
        b=oVrhJjGpq7RQvp1u6xnnfC6XqRDgZ12Z3eJc6W+maDs4pY1lVX2darYkMhRHhqHTjh
         hAAtvKq3ruUIvub0ks2bJPvLugPPBLZzBpPX1ALKNoAkOSQEdi6i6kZbMZsi1Jmru1ck
         P0Gir8j8oFo1gmS5YkR67Utssdvlc50BKMZtwXbO0lUOBDL52BLhiHEBDTDTDpPRhWJP
         HNd4IzycX0z7g2cPTMCCKQPen+j8dV2yLxi6i5YmA3g3e1cwF0iqTCxX+T36388RTZ88
         0iqryE38ruG7hEhn6lflTnQWwD3zIiqpTN8p07M806iKByU2fW3WPRI+YnMsKlA7rgL7
         OzOA==
X-Gm-Message-State: AFuF++kFZvthFSu/QH6bB4bLQs2mdy52TW3ETu/6JgVBK+tWuGNh9IEI
	QaalcsDnKAc6h0oVLcHXy7VzWjDHScU7GsTmA9CGQLGVCEqtT8yAHC1xcTEu+7PsbA8=
X-Gm-Gg: AR+sD11Y9v9vScVysDMl7JRK/Hzxk5YFRtMuc9u/cxky8/Qujhl3KVHlmTWksLOMT46
	K5rggE7oHzkHv45CNhgpwKuffzTa7R5dCb08kLn7G6xHSYujUmLvI8DwT1OH6NjGjoDOJvfKNDl
	eQdvjRta4NbNsWEtXfgZQbH3vn12tEuAcNTRTAO0B4/b82xNeYwgaeotcqO3gFWDQ41AK+qDy0/
	kltGsHo6nmqzq+OinR5Z/XzP3Lcty5OGDfPeac4w9bXIDtumx8EYXeaHU/0Ng96EfL8GPOV89em
	KToq+2KnvOW2Q27q9vx0f5IBIUNobEUwEzLZ5AV9Yq9lBT10rkITaM8Jo/+V8xnpsc1wg+KnqR0
	2HcG7a+gs+n041+ra7GZslWcAlVkrn7i/7n1LT1Ms3Vba8FpcMa1MMLXfAzCFu0lTFW2a05yr6v
	+ojGCEobNaq8jIvgNOmR7fUYNfI9QiqFPqzLg+kZovEnDfeYKNYKjUoRNR3ywUZ+DGHsEUDdRbw
	vMOA0U4NhsD4aPyKMI=
X-Received: by 2002:a05:6a21:7482:b0:3c3:b57b:6291 with SMTP id adf61e73a8af0-3cd301b5175mr69489021637.18.1787649603514;
        Tue, 25 Aug 2026 02:20:03 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3282afb407bsm5386163eec.30.2026.08.25.02.19.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:20:02 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	emil@etsalapatis.com
Subject: [PATCH v6 1/4] bpf: Add a sleepable page allocator for map memory
Date: Tue, 25 Aug 2026 14:49:49 +0530
Message-ID: <20260825091952.81971-2-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825091952.81971-1-ahemadkhawar123@gmail.com>
References: <20260825091952.81971-1-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
conservative guess for BPF program context that is always false under
PREEMPT_RT. So even a caller that really is sleepable gets the
non-blocking allocator, which never reclaims and never engages the OOM
machinery.

Add bpf_map_alloc_page_sleepable() for callers that know they are
sleepable. Like the other bpf map allocators it places the page on the
map's numa_node and does not follow the faulting task's NUMA mempolicy;
arena memory is shared, so the map's node is the right placement policy.
The next patch uses it from the arena page fault handler.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
 include/linux/bpf.h  |  1 +
 kernel/bpf/syscall.c | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b3cd28d9e3..c817c99d29 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2784,6 +2784,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
 int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 			unsigned long nr_pages, struct page **page_array);
+struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map);
 #ifdef CONFIG_MEMCG
 void bpf_map_memcg_enter(const struct bpf_map *map, struct mem_cgroup **old_memcg,
 			 struct mem_cgroup **new_memcg);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6874ba1424..f9b81638e5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -602,15 +602,14 @@ static bool can_alloc_pages(void)
 		!IS_ENABLED(CONFIG_PREEMPT_RT);
 }
 
+#define BPF_PAGE_GFP (GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT | __GFP_NOWARN)
+
 static struct page *__bpf_alloc_page(int nid)
 {
 	if (!can_alloc_pages())
 		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
 
-	return alloc_pages_node(nid,
-				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
-				| __GFP_NOWARN,
-				0);
+	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);
 }
 
 int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
@@ -636,6 +635,20 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 	return ret;
 }
 
+/*
+ * For callers that know they run in a sleepable context, e.g. a user page
+ * fault handler. can_alloc_pages() is a conservative guess made for BPF
+ * program context - notably it is always false on PREEMPT_RT - so going
+ * through bpf_map_alloc_pages() there would needlessly pick the
+ * non-blocking allocator, which never reclaims and never engages the OOM
+ * machinery.
+ */
+struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map)
+{
+	might_sleep();
+	return alloc_pages_node(map->numa_node, BPF_PAGE_GFP, 0);
+}
+
 static int btf_field_cmp(const void *a, const void *b)
 {
 	const struct btf_field *f1 = a, *f2 = b;
-- 
2.54.0 (Apple Git-157)

