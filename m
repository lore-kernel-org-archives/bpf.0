Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8F612D
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 14:06:08 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8111FC2
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 07:06:07 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RLWyr2g9lz15NWF;
	Wed,  9 Aug 2023 22:04:52 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 22:06:03 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH bpf-next] bpf: Remove unused declaration bpf_link_new_file()
Date: Wed, 9 Aug 2023 22:05:56 +0800
Message-ID: <20230809140556.45836-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit a3b80e107894 ("bpf: Allocate ID for bpf_link")
removed the implementation but not the declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/bpf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index db3fe5a61b05..cfabbcf47bdb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2120,7 +2120,6 @@ void bpf_link_cleanup(struct bpf_link_primer *primer);
 void bpf_link_inc(struct bpf_link *link);
 void bpf_link_put(struct bpf_link *link);
 int bpf_link_new_fd(struct bpf_link *link);
-struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
 
-- 
2.34.1

