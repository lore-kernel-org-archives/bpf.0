Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537913;
	b=Ik0tLkhV62M6bKmqfwribr1vhON+RUSN9xOAkB2knEKUetGsQ6dGFh7BpZ3XbnM0ObFZ
	 CCQtr5ZDhcDVyEQF7QSLZd2W80Xs7EVPft97u4X3Rvc/JUze1uKdX1t8FkQf5D03wnb7W
	 C6nfyA7XM/pL4KAzGWzwuDsQSnoa7GAzmC5Ux29x7KprDBKG80Fo0BkpFTNSDTPiHatWa
	 o58z6P77dI6VKbEvaRcpgdbBpqdrPVd+HqlQSgnrPkJXpbwym68aW6PxBHO1t7/KbFf8X
	 iAYcGF+8Q+0a0+HhgtwxKv+d9biL+7y+4o84a5eDZrtrpT5WX/wLZ+W+49pfbgO37+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537913;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=l5lZWNF7Ym38b1LI7ehF+OPGmdiH9wvt6SCkHsFrtjw=;
	b=GbbPOkShuLkq+/GIU47J/aHfI+PSS9/yKKV5l00+BHR+qKlzZUsUvMYOS7d9SMVlqN3L
	 QTMQzGjVEdReK/XlEoa5LQgVt/p91qBDP27a7YPjWLfFSEM/hTalhdC5D2qDAm+ruACOd
	 +rkbn6W8AeihmLy/mh2a26XJazNjFTrKr2Mm9Cbm02UD16VsCiE1fEn5HX03dql8JT30q
	 85n4WIPyhAgNx6JXgwUA7eKflfQgzRw+J38m1qVd0c+nIMgmDa1VrUI4o855Zs0LoLiNN
	 PAMTPSwOQGhFhni4HKSQB74yQ7WW/1L6mn1jowODO4z5jevkL4lFflmPHnbx5S52DkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=gOxtODFq;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581CD606A88E;
	Fri, 13 Nov 2026 02:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 581CD606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=gOxtODFq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1794537891;
	bh=l5lZWNF7Ym38b1LI7ehF+OPGmdiH9wvt6SCkHsFrtjw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gOxtODFquZ6qM11cjavoeLWu/7D72/nrGmfDSjTyPTKlBvyzWUxgtP88AOBH/I/Np
	 kICCbJVRuvOjL+xXm912VmHnx5Z4pPsWKtEuNDrJrlUSimeEhhPHPkPx5h8QGQK+vq
	 k5tk21/LwSgkeNDkYP87qfqrQJSJ8C2G91Xiuhhg=
X-QQ-mid: zesmtpip2t1794537889t9e608108
X-QQ-Originating-IP: /Dst6S97j4UJ+YS+s8qXpvhzGetRv4t3V4IIfCGjFGI=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 10:44:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8035796014243981157
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tjmercier@google.com,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [PATCH bpf v2 1/2] bpf: make dmabuf iterator stay drained after NULL
Date: Fri, 13 Nov 2026 10:44:46 +0800
Message-Id: <20261113024447.922683-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MjqaYNLY8QZGJszbSAppscBWRdlMG+zMbHf+MeJn3oSHTkWESnyckha8
	/1RKf+CZ2KJjVPK9CziiTSjjso1gH0ckXskEnIz8paJ/ieazUyoYRyPYgVGPVALWrQemeoE
	DzcDOEliV0aMuCWG6z3GYY8A9tdxY1bK0tl86G+WI1gf7tr3WvhCZ6xcgzpZVwSBG89fCd2
	wwnzgLdUi1Klj/aSgwhV4hfvnYwnyqVQj6ofbe/nC+3mn0432hIOLDGeev3a+Ari8eug/cu
	3M6BCCai/NjoFDaCr4YBT0tloayP9Tmlty1CX/tRIbuYoA5lcMLq2K6vMpTZUPRxhHrctVI
	zPxKQSW9wrtzWz+vhck5WMEtjMJuhGwWr50TIdJjABixD3pQkPoYWn11kgaffvJ3rrloKEz
	DMk3LeSD+e4+VduFN/u7CKrDuZx8nJoNdrfKIhJN2yjUkmkgoQkbTfxnn2vbbRT9JdhGubY
	3b/7D+IQzL7q2hIjKVdDTTDB9zx5XUnTRRVI4NElRGtXm4pthDvWDMnBlcMrBtKbwNkMy1G
	mpIJzIMB9iXsmnta/P8XJVrPberg1UdupC9nNENgzJudBlyNTGJX1FXKmEkw5bZzfhVukEN
	OQdkshjxtvnIF1ViX47FZhRZhK1WUCjuM/Uq1w7Dstx+KmRZ2MNZjkps/oPYEQ1iwBr353d
	Owvnj8XGxIxrT33pDAZvKhPDUXvF4wLVDP51WmdHifaIfpQvNOWMKe0c8xzKwwrUBUqqf7e
	p7extZD2KdYDzmOBALf/l31fPqN2ESbIRA8JTkVHyawh21iDCGwzyN6uXJndcFxm73mur2S
	WrmNFBfwU3TfURVUyj5J/O32V7TAB6t7+SRjozzYyQZaN6mQIjL+P9NeICH2Uk3So4+xXN0
	oGViuAbQTWpNXpAYEgW70tcSkmdwnaXpwguYg0u4V1i5+fry/RZuvUb21OOGkEQ3ahc5wHY
	txemdHXRAZKCd6zZowQ+VGM11tw/1vKFMPyJmBQaRo3QOxOzlxagosY5ZAH+FwVSb+c6cPw
	Ej7p6TNw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

bpf_iter_dmabuf_next() uses kit->dmabuf == NULL to mean "iteration has
not started".  dma_buf_iter_next() also returns NULL at the end of the
list, so a next() call after exhaustion restarts from the list head.

The verifier relies on the iterator contract that once next() returns
NULL it keeps returning NULL: process_iter_next_call() marks the
iterator DRAINED and treats the result of later next() calls as the
constant zero.  A restarted dmabuf iteration therefore hands the BPF
program a kernel pointer while the verifier believes R0 == 0.

NULL now means drained.  Initialize the state to DMABUF_ITER_START and
translate it to dma_buf_iter_begin() on the first next().  The iterator
state is BPF-visible ABI (one pointer wide), so use an invalid pointer
sentinel instead of growing it.

Fixes: 6eab7ac7c5ee ("bpf: Add open coded dmabuf iterator")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
v2:
- Use DMABUF_ITER_START; NULL now means drained.
- Move the ABI explanation to the commit message.

 kernel/bpf/dmabuf_iter.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index cd500248abd9..390f6d730a67 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -156,6 +156,9 @@ struct bpf_iter_dmabuf_kern {
 	struct dma_buf *dmabuf;
 } __aligned(8);
 
+/* NULL means drained; START means "not started yet". */
+#define DMABUF_ITER_START	((struct dma_buf *)1L)
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
@@ -165,7 +168,7 @@ __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
 	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
 	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
 
-	kit->dmabuf = NULL;
+	kit->dmabuf = DMABUF_ITER_START;
 	return 0;
 }
 
@@ -173,10 +176,14 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it)
 {
 	struct bpf_iter_dmabuf_kern *kit = (void *)it;
 
-	if (kit->dmabuf)
-		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);
-	else
+	/* Once NULL is returned, next() has to keep returning NULL. */
+	if (!kit->dmabuf)
+		return NULL;
+
+	if (kit->dmabuf == DMABUF_ITER_START)
 		kit->dmabuf = dma_buf_iter_begin();
+	else
+		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);
 
 	return kit->dmabuf;
 }
@@ -185,7 +192,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it)
 {
 	struct bpf_iter_dmabuf_kern *kit = (void *)it;
 
-	if (kit->dmabuf)
+	if (kit->dmabuf && kit->dmabuf != DMABUF_ITER_START)
 		dma_buf_put(kit->dmabuf);
 }
 
-- 
2.34.1

