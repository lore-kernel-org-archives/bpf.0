Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315086;
	b=kLr3K7AIfqkw5wNx7tZGj/ZlCoYWxjDoVu+ZHa2lqsCYd/9scbmH+hwNWb/kr2Yfuz3c
	 2HaobogN/J4DcXeLqNjaC/OPRd1UbHFgnSQEp19vWyfqL3walB4F2EnasqsxL3oG/XyWj
	 I8PlAW9HU5OTV8QhWLxOdWmwThaRLlwe7ePysFK1SrgqyOKFhYm//tWi6Jd20yV7U2tpe
	 5j2BlRm//WPbWOTmJ26gPDFCsuRnKXJYDgm7GmUNYbjMaTGXSeZ0qY+bYLiXbo1GTXwAM
	 S+Q6KZ9K27AW9dPIlZo+L//WxVNnL04v3Aw9bVmU6EsgjnjpJfvPl/mFiq9gdvV7HGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315086;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=RxZl6p7PH/ZzZkbb7ep2WA/FeXnjYV/M8ID/0T9gT/Q=;
	b=LwDyGzNEb/1Wd83dW3PzJavZex7H8CQkGvCt12fbx7VdJ6sYdzbEtJOJ1yNYRgbE54vw
	 dj6oqiTBdR3DClWnGaoOpM9avbv0yLI+X9kNCrf7c14IbkOfF2WE/BpT6739hoQSUGHsR
	 gN/VQQTg+Pc4n1Ubaj82P+fDJbNvac+Tb5y4+mDyvZSO+9Q6QNwfY370qYTiXMrQRitsH
	 vRuh7RECL0YVdGVrd3vdmPBpjtMeWDMXNHV6/SWaVJA3le4a5BeTcd/JeFGaJbKXwR4Qi
	 iTFj5UHnmduwBjc5b4IJQ72TFAWx6usP+YusVNyw6csHJzVYypXamXZJNg9DF4DX4Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=5bdoU13O;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3DC606A326;
	Tue, 10 Nov 2026 12:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E3DC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=5bdoU13O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1794315073;
	bh=RxZl6p7PH/ZzZkbb7ep2WA/FeXnjYV/M8ID/0T9gT/Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=5bdoU13OhJjaFzk/UuAJm2aB75OBjAaY7TWqMD6y4sPfAWcFVL4mqTyc9SBD6EJbl
	 rGRYOjsZy00/QxNw3P6mEMTdIuum5/pQ46qNYYjYaakWyiwhCfS9668moIVIb85wkv
	 /9Gp9Qg40ELwGPCC+N2Yj1iNWmldK19PTs/v07Ck=
X-QQ-mid: zesmtpip2t1794315069t11fc89a1
X-QQ-Originating-IP: DOWT+SLXdKkkQCd8sDpgnmX258kipbcc6y7odjw9PsU=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 20:51:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12170903532052178925
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [PATCH] bpf: make dmabuf iterator stay drained after NULL
Date: Tue, 10 Nov 2026 20:51:06 +0800
Message-Id: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-QQ-XMAILINFO: MWxZUaxBV+u3RaK5TkvHNA8gQCfm4CUQUAkd7XR7zg0OxlQA1dsg7vic
	nxNR/6js4aTsuzNYX6BLi02iCHAfuQM5E0+rycFBciLzi4fuIaWPgDUPuFUhiL86j310D1A
	cutER53OiSFGN9SZPj2Fwm+azkiti5zwyGf7kJ9Am/aGNNpa+CT2+reH89+qoWDKxdM+UTq
	m+OeIQYsODX+655wFJC8GsOWuXuw/QUASTTOIqsqExZpZCFVxODhYm9dBYvFyFywo+59QGM
	2cf1xSJTnvAkDE+IVa9NULrpSPCVKmNGfZKxVsDVlo9oVYGdyPemFwqIZWenCKuCqRvOIYG
	Ga6VgqHnSA0VUnmUcyy29o8pNkvJ3URWvMy5eh0x5Qu8q8h6jUq3ZxPTbkb9wAFGfDN2ye0
	t2yUHYLbDDF+5kz/2dQecWk0YpIbKPoDS8n2leJcW4ryhVaWuuiKeb+Jd9TNQlzpX1MMdwT
	hzGENWGN2+SAyP/h1ZJ8hM4MYaSro5YvhiRVbRwiwYQaP/rq31Fix53DC4s7qHQ9ASL1Xu2
	3CC27bShbD3VDgzhruEqkS0oxzXbrBHyI9hiogSRIoqasn+9nMW4gzvQ3ROgn8TuIW2V0vs
	DwBYRjUVFCxkB3rzEWqqWUOSnA10xJgawnqv3MnPnnRQvA/NUuuEezKz9UYV8XaRrMG1251
	jes556nTem7chi3RKpqGtnsHnGdN7jODre1FjAPiVGTuD//hTjTAsVJFW/1Bf6yZnBDvWAu
	V571BDHKRHmAbB+PdN0hLIs/iXQjwpILvZ5TzcOw908mCdR8iWNzr6Vfu6+nQM9Qk0T2W/N
	JUE4u8rcibpYd2P0f7MbjsqjzpaRPS4vowKj3jKVEos7OI4fl13Nu/Jr/dDrzhSR5eAn5se
	y8NI8tIzy4ZJJGpdOx7l4/AT3HJ3EYghO+P6a6Ogw3f0OLquIDNuyMP/QwcP+cTuYjyvkiv
	FXz84nuwk62IXVqDRCataltp23nKEBGsH32XqfQdjEnWojXcaeZqehdLwJn22cmAUexszPV
	WfX0kHMJtC1P+ZugW1MG/ZDlj7i56QlYFT46/wCQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

bpf_iter_dmabuf_next() uses kit->dmabuf == NULL to mean "iteration has
not started".  dma_buf_iter_next() also returns NULL at the end of the
list, so a next() call after exhaustion restarts from the list head.

The verifier relies on the iterator contract that once next() returns
NULL it keeps returning NULL: process_iter_next_call() marks the
iterator DRAINED and treats the result of later next() calls as the
constant zero.  A restarted dmabuf iteration therefore hands the BPF
program a kernel pointer while the verifier believes R0 == 0.

Use an invalid pointer value as the drained sentinel so the iterator
state keeps its one-pointer ABI, and skip dma_buf_put() for it.

Fixes: 6eab7ac7c5ee ("bpf: Add open coded dmabuf iterator")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 kernel/bpf/dmabuf_iter.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index cd500248abd9..a2b7c38f9ae6 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -156,6 +156,13 @@ struct bpf_iter_dmabuf_kern {
 	struct dma_buf *dmabuf;
 } __aligned(8);
 
+/*
+ * The iterator state is one pointer wide because struct bpf_iter_dmabuf is
+ * part of the generated vmlinux.h ABI.  Use an invalid pointer value as the
+ * "drained" sentinel instead of growing the state.
+ */
+#define DMABUF_ITER_DONE	((struct dma_buf *)1L)
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
@@ -173,11 +180,25 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it)
 {
 	struct bpf_iter_dmabuf_kern *kit = (void *)it;
 
+	/*
+	 * The verifier assumes that an iterator which returned NULL keeps
+	 * returning NULL (see process_iter_next_call()).  Without this check
+	 * the NULL left by the last dma_buf_iter_next() would be interpreted
+	 * as "not started" and the iteration would restart from the list head.
+	 */
+	if (kit->dmabuf == DMABUF_ITER_DONE)
+		return NULL;
+
 	if (kit->dmabuf)
 		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);
 	else
 		kit->dmabuf = dma_buf_iter_begin();
 
+	if (!kit->dmabuf) {
+		kit->dmabuf = DMABUF_ITER_DONE;
+		return NULL;
+	}
+
 	return kit->dmabuf;
 }
 
@@ -185,7 +206,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it)
 {
 	struct bpf_iter_dmabuf_kern *kit = (void *)it;
 
-	if (kit->dmabuf)
+	if (kit->dmabuf && kit->dmabuf != DMABUF_ITER_DONE)
 		dma_buf_put(kit->dmabuf);
 }
 
-- 
2.34.1

