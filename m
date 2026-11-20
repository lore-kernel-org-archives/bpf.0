Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158957;
	b=jETKUrgVTR9s3tq8yp4oTUYnfOZUpOapqIQb1Akrnyb0DEkQR+LtELhFNjHDMcR2UbVZ
	 607hGmEJzGXlWqJHgUwNPMxYPvKAzLunBXGyfj0JUk90zYF0RdcjDLF4xp9m0wXz99c6k
	 DJ4nON7fWBtkP2nsqaK+ntTpbOHWMr04doqKttgSE1bgaj2FN455hXt2Gh9h673HwkwN0
	 jApu95wGvtMDFW0dUm2CaqlgMcBIcj+PFZtkoIorap/rMGIEjaUT86pIGS7hrUEovYU7Q
	 atrP7lSdrUFg+dxYdo+7NWJ5gc84cUY6Zk/Htl/1f8yKnbkT5DAtre44Q+zDf84ECYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158957;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=qFKUjQZcSUKgt4QCK8R+XPbzFwqo/yxdcFdNLs4a7Cc=;
	b=koE9e97idFU+Vr09aMFuUDRfI0CC3DgYl5Jmm9s5Gl3r/y1BpZDs4JiS18yyaz6lsZPJ
	 JNxz5N9CLchXKecuiB8t9tUlA6WyB5Owasl+H9eA1oTS7y+vOHHy8nqBN6r2dx9mTFKqu
	 fzmM+7bu8gBWHyHyqU2k3eWWJbq4mBjsE1kshUn1tqjax6FMQ/c+2u1r6FCK05b5bZZzy
	 VbQcocBJ1emWFz8WCKdJVzc31GrS6EUJSku9nfrC6HLFCZMsqoO8m+Q1hx2Lqb8y8Q/9W
	 GCyQpoG0CYIxT5LA8vKrZrFBvX/d9v5DG/LJqdKzznZYT9VHTkEtCpQRgzMFLTpGcLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F9606A325;
	Fri, 20 Nov 2026 07:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD2F9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jW66R5MMgz1c0nX;
	Fri, 20 Nov 2026 15:14:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CCCA840577;
	Fri, 20 Nov 2026 15:15:51 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgA3dfSm8_9qDM9HFA--.40246S4;
	Fri, 20 Nov 2026 15:15:51 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH 2/3] seccomp: Use the classic BPF filter cache
Date: Fri, 20 Nov 2026 06:48:51 +0000
Message-ID: <03575b8ff18b1ec40809ada33257bcf5ac1ab29c.1795139109.git.xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795139109.git.xukuohai@huaweicloud.com>
References: <cover.1795139109.git.xukuohai@huaweicloud.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3dfSm8_9qDM9HFA--.40246S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3CFy7ur47Cw15Ar1UJrb_yoW8WF18pa
	45Gw1Yyw4xXFn7Gr95GFWUCFyrJFnYgr9rur1UK34fAry3Xr1rCa12gFWjqanxWrWIkw1F
	v3WFqw4fC3WDJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Define a classic BPF filter cache in seccomp. This allows identical
seccomp filters to share a single prepared program instead of each
paying the cost of the check, rewrite, migration, and JIT compilation
pipeline.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/seccomp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 01e26bfc6ea1..b1c40ffbc6f2 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -465,6 +465,9 @@ static inline void seccomp_assign_mode(struct task_struct *task,
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
+
+static DEFINE_CBPF_CACHE(seccomp_cbpf_cache);
+
 /* Returns 1 if the parent is an ancestor of the child. */
 static int is_ancestor(struct seccomp_filter *parent,
 		       struct seccomp_filter *child)
@@ -526,7 +529,11 @@ static inline pid_t seccomp_can_sync_threads(void)
 static inline void seccomp_filter_free(struct seccomp_filter *filter)
 {
 	if (filter) {
-		bpf_prog_destroy(filter->prog);
+		if (filter->prog->orig_prog &&
+		    filter->prog->orig_prog->cache_entry)
+			cbpf_cache_put_prog(filter->prog);
+		else
+			bpf_prog_destroy(filter->prog);
 		kfree(filter);
 	}
 }
@@ -702,7 +709,7 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 	mutex_init(&sfilter->notify_lock);
 	ret = bpf_prog_create_from_user(&sfilter->prog, fprog,
 					seccomp_check_filter, save_orig,
-					NULL);
+					&seccomp_cbpf_cache);
 	if (ret < 0) {
 		kfree(sfilter);
 		return ERR_PTR(ret);
-- 
2.43.0

