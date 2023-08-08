Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC714F6D
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 17:38:10 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEFB205D1
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 10:26:20 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKx6P6FBMzrSKm;
	Tue,  8 Aug 2023 22:54:21 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 22:55:32 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH bpf-next] bpf: lru: Remove unused declaration bpf_lru_promote()
Date: Tue, 8 Aug 2023 22:55:31 +0800
Message-ID: <20230808145531.19692-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 3a08c2fd7634 ("bpf: LRU List") declared but never implemented this.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 kernel/bpf/bpf_lru_list.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index 8f3c8b2b4490..cbd8d3720c2b 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -75,6 +75,5 @@ void bpf_lru_populate(struct bpf_lru *lru, void *buf, u32 node_offset,
 void bpf_lru_destroy(struct bpf_lru *lru);
 struct bpf_lru_node *bpf_lru_pop_free(struct bpf_lru *lru, u32 hash);
 void bpf_lru_push_free(struct bpf_lru *lru, struct bpf_lru_node *node);
-void bpf_lru_promote(struct bpf_lru *lru, struct bpf_lru_node *node);
 
 #endif
-- 
2.34.1

