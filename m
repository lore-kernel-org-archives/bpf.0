Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFCF3F4105
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651410; cv=none; b=k73vzsB8dt2lPGpGM4fI933qu1YYvfJVdPxQ7aa0xkvNvPPyzFP19jd0U/NptE3iR9eUuvpf8YLCQKaFOEnyARU8CZ6NG09BEGDfxZZqgV+nlj1P2wv1lhyM6vcG8DyAeNlaOSJ/tOFqCCM3HTSPUW6Jfzpo/EeQDL8zrXFbZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651410; c=relaxed/simple;
	bh=PyE160OajPSsqQd9ddyOfvbdMpeClWf6VPakHByI8uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcJS6UuwGEA2IHUm7viEKMx+aibben1Xzh8Awm1g/afoysovma6AyaT+iOvtu6BP2wFS04/eiIg+1NyE7g9qj/xBKjWb7Vh1zYDRAjdSoPgnnQ9VrX2YL6dwQw7XGhfz5xlGBZL3c85QTVUGoimwq3LmUm7ibzYzkFOW6epB0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mylXEhIO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mylXEhIO"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso49986235ad.1
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787651408; x=1788256208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7cSIyxl/i1oxSUvdnacr9V24YcqM8fZNDWiyKdu00s=;
        b=mylXEhIOn2K1qqw1nMVq4eo5yJ2TnzTcl+0GdsooM5a0b8Y0cYu8qS2oq6AHCzjWBW
         6q5DReILtgQinihErYEGpenSQItpt4AnYHzllNvMB7w10xWKvZKfogS/cFP3IEb0Ho6T
         KpMzA/czWthiNcW0ux5NhwdFWws3vxbvevnUG0c9Ieb5j7rpj7dvMx+lufLU2EqcXycG
         LcQliSZvQyKnH1FS82BrgFQigDIHP1ydA8KSeHPPL3oXlsXp1Zz4NZuQTVxUmricyU//
         WdrD6v02+/fIAoep7PhyRI74kjccojGm0Mh/fDC2nyoIUyd6MkJwl6pPvqq0J+JS772r
         qXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651408; x=1788256208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7cSIyxl/i1oxSUvdnacr9V24YcqM8fZNDWiyKdu00s=;
        b=W14Qo+VIt9nTw/RIw9bhLSetOlUJ8oOtBVHwFr26jyjHXQa9TsVWWx0m6TCeEYecYX
         i1I2gi3USITP41EGtzWAus+LmnUBLasBOQrZmBWclA6a977a0tDCvgU9BrsZkmCAopoa
         a7oKJNIOtGEcEFbkQGhrUC7rDk591oOIDhk8zIDlFstrS0EH/k/fWWAAaoTOiUbkBtND
         tMtg/trb7b8aHWoMs3buNvuDqpIsReoP3GGSrBMqqf117UyaFWlrZFyFckhN617qsbNC
         OGe7rDs6AfpPwTG0ygVwYRsigdqO3fzjkdDxmJ6yOEh7HaSMRk7IGITV6Xw05Ie7IyiA
         Nebg==
X-Gm-Message-State: AFuF++k14yHp8nDrukI6QLS73oITRQmxYFEnmc7QwLx3ZcEn3u8i0Y2L
	EsMZxaAFt+UdFtWRdppUSeXVNqGWNurmXbhJBBXFh9nj9eF0vcXZDbyLG5dp1fCMoaI=
X-Gm-Gg: AR+sD13mVFm7PGBQLGs4yEAvCaU1qzF+5CwyM3ZNsXEbjK3QvDJ3X72RakwJ3EqZIEp
	CoVdHOMP+9N+JwudvsK9CLqbAnJCqFiLzQoTE+BfjDGXLzgnuxzVP6GnevDZXNmxn/U53Vg1c18
	Q0LamQWiAzm1d9D/Or6R+MkGxqX49BYF6Jepaz3UBMWKUUUzUXXfnnEDKPoyqEcrdZJVP7m7eLu
	qhMdh630cZWIP8rxdO/kt5JFGjoN9SOYh22i3wUxGwKyIvf3qqohT/BlpJZD2A8bYg8zT9vE+C/
	deYtoa+9rv+1hQlCTxChD1EybRjbUHaUX9WuYqxcURpCKg3MHpTm8j9KwEuEVX4xJHpZrRtaCdG
	KlcbwHMDX0YHl37nyi5fQjvTqKOqcMj5hNHQ3cbrPTkJ+Q8Jn8Fei5AP9CSckZkNVnVhBjjrpCu
	qEuHn88i4sP5TyUO+JMwSIyQqJi9YEo4zXxmhicQezE27tZRDwNglWzIJzP3QBprytdX7wdSGL3
	TS7Xqc0zjDYwfXovqDQaDcCO2u41mM2c8Y=
X-Received: by 2002:a17:903:390d:b0:2c9:fb11:1bf4 with SMTP id d9443c01a7336-2d64af4eea9mr635232355ad.7.1787651407659;
        Tue, 25 Aug 2026 02:50:07 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32827662702sm5923062eec.10.2026.08.25.02.50.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:50:07 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	emil@etsalapatis.com,
	ahemadkhawar123@gmail.com
Subject: [PATCH bpf-next v6 1/4] bpf: Add a sleepable page allocator for map memory
Date: Tue, 25 Aug 2026 15:19:52 +0530
Message-ID: <20260825094955.83240-2-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825094955.83240-1-ahemadkhawar123@gmail.com>
References: <20260825094955.83240-1-ahemadkhawar123@gmail.com>
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

