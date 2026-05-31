Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562F91D54FA;
	Sun, 31 May 2026 04:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780203181; cv=none; b=J3++kTsL9MoY6iPE/Zs+A1b4gseljGlwFszWBXPPFoRNY76mAMxKTe1RjCoVbckTrJ6ItkpJVyQbk+an0hTi3o18ef6fDVqKTZpu0SIadJlYs1BCAdINDW/RkzOaTsVc8wXHBYSfx5FPdPuDWC8/rwoSlc6KT65Kg9446rMdQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780203181; c=relaxed/simple;
	bh=BEgUppDCDRw8PP3X5I+8jBTlt1jboC3EEPYd8erBziQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yef5lY8QirE6PcjmJhmnonjXizHKoMLW+k6Ft1B4vYr0xKLRIGmw9Tc8EH7P/d95eDmwzw8+u7piYjNy6PWEmtlvwm8JrD5ZLe+wSi7afYBDcOJoU4c6epnNs6WkGvVMmOK2BayZSGQGTIkrMrcjTAPuDcOLQTtaxyChJXhiInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowAA3zwaBvhtqIKkVAA--.20948S3;
	Sun, 31 May 2026 12:52:22 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	toke@redhat.com,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	zzhan461@ucr.edu,
	n05ec@lzu.edu.cn
Subject: [PATCH bpf 1/1] bpf: devmap: reject cloning fragmented xdp frames
Date: Sun, 31 May 2026 12:52:13 +0800
Message-ID: <4b596825bccc64d03e0c2e0db4dceb12c7f5cf47.1780176829.git.zzhan461@ucr.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780176829.git.zzhan461@ucr.edu>
References: <cover.1780176829.git.zzhan461@ucr.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowAA3zwaBvhtqIKkVAA--.20948S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1UCrWUArW8ArW5Zr1kXwb_yoW8Ar47pa
	yDXFyDGFWrtr47Ca4jyF4I9rW5Kr4kWay7Kan0gry3Zw1qgF9rW3yagFy3XryYyrWFka1r
	tF12q3yDG34DX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRMXdjDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEECWoanc8JJwAAsB

From: Zhao Zhang <zzhan461@ucr.edu>

Devmap broadcast redirects clone xdp_frame instances for all but the
last destination. That clone path only copies the linear frame data,
while fragmented XDP frames store skb_shared_info in tailroom outside
the linear area.

As a result, broadcasting a fragmented xdp_frame leaves the clone with
XDP_FLAGS_HAS_FRAGS set but without valid frag metadata. The later free
path then treats uninitialized tail data as skb_shared_info, leading to
an out-of-bounds access during frame return.

Reject fragmented frames in dev_map_enqueue_clone(). Devmap already uses
-EOPNOTSUPP for unsupported XDP frag forwarding cases, and the current
xdp_frame clone model cannot safely represent a cloned fragmented
frame.

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 kernel/bpf/devmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index cc0a43ebab6b..2bfebded5329 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -581,6 +581,10 @@ static int dev_map_enqueue_clone(struct bpf_dtab_netdev *obj,
 {
 	struct xdp_frame *nxdpf;
 
+	/* Frags live outside the linear frame and cannot be cloned safely. */
+	if (unlikely(xdp_frame_has_frags(xdpf)))
+		return -EOPNOTSUPP;
+
 	nxdpf = xdpf_clone(xdpf);
 	if (!nxdpf)
 		return -ENOMEM;
-- 
2.47.3

