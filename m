Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4FC2D661C;
	Tue, 21 Jul 2026 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784606798; cv=none; b=iKr8We07Ci93BpYbmZ/m3zwRn2e2eQCi01YcT9Jx4O2rOkEQdbRiKvw57XVrRfZg0XsmI5GJucZy8jlUpzzbvQUDt6TDZLGXhcwZWUcWhKYlEa277j1ln1cIUqGLF6ePS61qqttnzjoTQULlO70nUQXswMn+hnrI1wtVhhDPues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784606798; c=relaxed/simple;
	bh=0LsocKogIxy0NAFJaGmIS3UoSTnByu09at0uIn4mJrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TB6u5pJfVA7rRiCa5i3JsZWou4bMJXP+K6XQAaR2qPzDBgmfarWWbEM+BnqSYNhI/4Hwc93Lu5cW0r2A0hDnweCZOtukhaDeJF1YwRy1LtnrN21NsVQc18YMMLS2zj0PFcRZNFi4emkNgK3nrA/+CNd7FTe1K4XAR2/5nZzCGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h43hc0wZkzKHMP3;
	Tue, 21 Jul 2026 12:05:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C297E405B2;
	Tue, 21 Jul 2026 12:06:18 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAHF3M58F5qwav1Bw--.64145S3;
	Tue, 21 Jul 2026 12:06:18 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v5 1/4] bpf: Fix potential UAF in bpf_netns_link_update_prog
Date: Tue, 21 Jul 2026 04:10:45 +0000
Message-Id: <20260721041048.1394085-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721041048.1394085-1-pulehui@huaweicloud.com>
References: <20260721041048.1394085-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHF3M58F5qwav1Bw--.64145S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1xJw4kCF1Utr17uF48WFg_yoW8CF1kpF
	y3Cr1DGw10krsF9F18X3WkuryrXFy0gr4UCr1DZ3W0qFyIqr1Fg34UurZ2vrZY9FWqgFyS
	qa4jgr1Yqw1jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

In bpf_netns_link_update_prog, the checks for old_prog and prog type
are currently performed locklessly before acquiring netns_bpf_mutex.
This creates a race condition that can lead to a UAF issue.

If two threads concurrently execute BPF_LINK_UPDATE on the same netns
link, the following execution path can trigger a UAF:

CPU0                                          CPU1
bpf_netns_link_update_prog
  if (old_prog && old_prog != link->prog)
    return -EPERM;
                                              bpf_netns_link_update_prog
                                                if (old_prog && old_prog != link->prog)
                                                ...
                                                old_prog = xchg(&link->prog, new_prog);
                                                bpf_prog_put(old_prog);
  if (new_prog->type != link->prog->type) <-- trigger UAF

Fix this by moving the old_prog and prog->type checks inside the
netns_bpf_mutex critical section.

Fixes: 7f045a49fee0 ("bpf: Add link-based BPF program attachment to network namespace")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/net_namespace.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 25f30f9edaef..9fc62db1441c 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -171,13 +171,17 @@ static int bpf_netns_link_update_prog(struct bpf_link *link,
 	struct net *net;
 	int idx, ret;
 
-	if (old_prog && old_prog != link->prog)
-		return -EPERM;
-	if (new_prog->type != link->prog->type)
-		return -EINVAL;
-
 	mutex_lock(&netns_bpf_mutex);
 
+	if (old_prog && old_prog != link->prog) {
+		ret = -EPERM;
+		goto out_unlock;
+	}
+	if (new_prog->type != link->prog->type) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	net = net_link->net;
 	if (!net || !check_net(net)) {
 		/* Link auto-detached or netns dying */
-- 
2.34.1

