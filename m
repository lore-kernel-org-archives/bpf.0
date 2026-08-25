Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267223EAC6D
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649420; cv=none; b=bPxWwpQ5xjZ7ZsKLtQr85c/scg3SV8G8NQobQHAhKDH/QqMMdOLUbW+P546bbtnIgMXdehHt2vup2DXhEh/v8Fn+ja26j04eLmZbKxTHAWEkY31q7a0fZoVczxKlWIjwYsGmpYUEgmsAY20jEHE99f2vnPCq6CoEuBiOF8U+E6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649420; c=relaxed/simple;
	bh=g+/TtVkzmh631DxnNEFoUvESWZL7IYHefa8yB6Kzeww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3zGU6d1VzFBBPAIWM6LtKDK9/VrMvFawAmaJ4kQSokB/Ws2ygOe3/COzJYv78c0eGhJcIslTWNFRZGjLD5o74cQrRzcGwTlYvN9uyF98D0gaVzbPzNnIxt21plq+ne5y7/4ME6n4feTeRi9GaQPksNsPK+mS2tA6VnxNVHnba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA2Tr6Zg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA2Tr6Zg"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so6255716a91.0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787649418; x=1788254218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UnWWoI95YwE6br4ddsyhfhfO9WEVo89LWu8/RDZKuLM=;
        b=cA2Tr6ZgrLuGseRJLHHNpuDSDhARMc21mJR9exn+M3sdPia51nxlqO4l79KeoQ9hpl
         cXnbclWeyyEoDh7kFG7LPTE4M+XGP61FmQknhwdvhhT1lZJCKSwkwTVbFvtawUETcJAU
         NuPFgZ4p0U4Ta285kewcUhzFXoKoUgChsETDDO2dZrpI5W7+dUow5Zh1iaMYa8acI+NW
         /IqPxzd4w4DlCbzy96CGcD4oN+ZjWPNWSw2vPtZHq+v6FpVGQpAME7YbF0rJv+OGtUJ2
         FPDk5fJvY7poMENLOlh80ew3yKJPY15eoLeR2sm7APHa3q/cg+mkczvJh38+6XMOJVrE
         wTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649418; x=1788254218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UnWWoI95YwE6br4ddsyhfhfO9WEVo89LWu8/RDZKuLM=;
        b=G+RqPEfWxJ8mqDa169qeSQoxUPo/k8JUkHrqu6Y9sc4nv4DwikoGlWS31NJR5I1/Vo
         33h6A+lwRONxIZ7Yn5u+z37kWTQ4W66HqvmmgvxqUeolZ+KOvUk6/LOERBCeVb7ARGNk
         RoNNAy36lAE1cJTi/VtYB+HT2C2bb+WRe6wu9vW27yLvdtIp80lzeLOFLFuhg2pfk4dv
         Mp73zzE9cvlktWk6tXrvrxdk9rs4S6zxTM8Cbvnup8F+Hos9mbQqyBWC/Oy7bC5F565J
         bict2HAS7CuCOjAIpZTeIH9e4Qi0H7DccTYVKZXJ1iXRandWIOFqrVZxRJCkmcOIkP13
         pSRg==
X-Gm-Message-State: AFuF++kkwiv3afgcarzfYkQGvMdLcXrrc7otDoojSK2cwm0L1bMmdgvg
	MMNn1rC4rlRHMKV409ofekNYnU2U/+LLCK7t+8WJ4Fh6DKtHH5TfLV+3uRgHyA==
X-Gm-Gg: AR+sD104K54Iv0LqvEaGHNqpXceHq4C6lW1ZUVMBZWQhfwe7YDFgS8qRRR3WOEdTP+2
	NbSsxDrvFzjETjGBiIgYpnoGkaj7clZ1paSk40RS8+693pF6BOvrpRkLaJjObg1nALKX3W4uP6T
	auTY0I2qgZ3IhnpR4V/1TPIgvV5WC4fNjE6+Zcj7c5Etfb7TMLHR/Z473VNqhKVVQPIsh+Pb4yE
	w9KRwjBBM5uk6hANvVhOVqvOMEYzQucQ9XEdSmaITQm9XFv+hHgV9mgRtfcmH+nUCCCQiayhg4g
	RMKWiDpH3zjIxrP/XcJVk9IuAOyVcH3Y/ervzr5cT6C1zNR1ihGn2KfcW5fTVQZaku/DvMdK2KO
	ndHNnMvg/OdQl+roD+UgxOFsNCMQqIVRFSA/I8rz71luZzwJXyzS+BATLyV6LQQpKRsr6UHHO+b
	n4eezY9/T5T4TnUBhMShkHbPDhaIihjKp7hTqzck6HYT9hWeuw1KzUvpXjx2+JYMqlTntvqk5+D
	yS9L4lL5BezAQJrhOs=
X-Received: by 2002:a17:90a:1697:b0:396:635a:9b10 with SMTP id 98e67ed59e1d1-396635aaf7emr125987a91.11.1787649418345;
        Tue, 25 Aug 2026 02:16:58 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860fe08csm52122658c88.8.2026.08.25.02.16.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:16:57 -0700 (PDT)
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
Date: Tue, 25 Aug 2026 14:46:44 +0530
Message-ID: <20260825091647.81632-2-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825091647.81632-1-ahemadkhawar123@gmail.com>
References: <20260825091647.81632-1-ahemadkhawar123@gmail.com>
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

