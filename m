Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537993;
	b=HRAMIlxb/BZ02gy1KChfLqrZEDx9PgDB2ghY8pCgOye9f3NeXtCOyGnc7PSRQS7ytxS6
	 btPNYA8l2DA/04lIe3872Hlgw3jOXO6t7XipZ4E/h3k+br9yDnkqszgnJGIl0pdCMzGnK
	 x8pWb7FTsyVmOih7FD2+g5H3bfdN6ZxIAYCCMh5kJmPSCzpMpFE4vnrHj5XFijS3qOMHb
	 /iTkjyGfi1GpgRS+jeAzQqaBu87wvjM/blpvtWbtJZEa50D2eQwlAl/2BVZw0EzS3oenw
	 2ac+g96gfAHT4S29P3yhBNz2SIlcuLIMD1Y3Qa1GfTIlfZOK/tfLlq8twU0+Un71zhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537993;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=g/SGycCInIofj90xk9/WpIqfNJA4ZAAGanQ1HDKZcOQ=;
	b=0nrN+Ev2sRbMn99NaheHs+mZ/Sh2N1PcWmdRTxpVh5VpCcUcU3i94bNOSZlhyL+4YbIs
	 9oaf9ytb5W40u9a12254ecwDpjEiyGEy1O5aMRE7i/0AMvtz7CAGECFtiF57l1veXUUAI
	 CNCbCpXnpYi+eLdSFpWAQ2lV8gLZR5hOYPWPynJ1cMCFEm5iM1poWQWXpRFun5BDOhDvg
	 XXPMbk+D6fafIaSHQpMGzB77jswj7gARZ0X4mV0vOjwiIsXwKXRn+M78A39ruV8+TNy58
	 iNZHaeu6+lGxaV3VnF8M8Zx45JLhXiyPDt8E4NH94yN0kJMEQqyu+3Q+umfpmeH/gJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b="YODF/bdh";
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C3A606A327;
	Fri, 13 Nov 2026 02:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C3A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=YODF/bdh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1794537911;
	bh=g/SGycCInIofj90xk9/WpIqfNJA4ZAAGanQ1HDKZcOQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=YODF/bdhKkdBa4kz7xD4J0DxBvL3Z1bUe/rLzhY0cl8rMtdlYVSecRuo2MhVERDmH
	 V5s+ZnSuXaVr24TkkBMokWraI7RDSZQLA4MlqVnbfZGmlBZfuX3jCkIsEaSzlMDqkt
	 xL2lNVWpJYwfbl83XS9xSl/1wVTOsR1Y+o/U1ofo=
X-QQ-mid: zesmtpip3t1794537906te7f6ee02
X-QQ-Originating-IP: eswpORA6cmZ/EnNGyFUFs3wACJvhwc26BCwIC9deF+g=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 10:45:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6365193483630494665
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH sched_ext v2 1/2] sched_ext: make DSQ iterator stay drained after NULL
Date: Fri, 13 Nov 2026 10:45:04 +0800
Message-Id: <20261113024505.922854-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110125113.2935742-1-k.chen@smail.nju.edu.cn>
References: <20261110125113.2935742-1-k.chen@smail.nju.edu.cn>
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
X-QQ-XMAILINFO: MB5+LsFw85NoCzqSXiMdVCXKgzYec4/K/LNNH3dA4ljA621uR9cJhcTe
	nf+RA/BM9MoHNIaJ6V8Tq/aOy16uGBTn8VCaIGs3RowNnh8CAokfE4dP9i+TEOZmbQ6trVj
	nIQL6D/aB/mf1hIR5CWecfGG74oIA8kW0F2eOCrZXxbL/0Iac5C6yMsFdGwXx3utjXl7Iye
	Ke/R9uRQfquhMBDbQaZudHgQ1wg9q15smH4e9RoXIlKrbc+Bk3jx0V4xuDl/H3ok9gpvLMC
	B0jc5hJ8hNkhECX9SacyLVebMm6ciVkTfmZGTy2O/DBf75qOYnCAzXMgXE1nTa49yloT606
	hqj17Ky9Wd5w5S8CAwIoofUcFTAnQNhIRp4YhsI6hgXIAFB1pJ9/Rzso6ECwk0Oj6YdKOJS
	jfwHFEz5sMdtMFyQzuboMLp4mP3eLOUaKGqDgFFMpiwiab5RiSupFeGD03Xa0Jf885XaTfq
	zA0bxYnTgqSaOYRkjMUvYTEWhT3c+hSr5W2pt+T38LXsRcGO4uLQtrIbMnuGgSULps4FFy0
	vSJDOzCtmCpUM72Xkhm83MbCAK1z5dXoKGRcpVhdT8Erh+Lu5310wtllVvgqmsaOokuNH3C
	AZAsWggjJVA4jdVj5l6fJXV60oK6BOrEiuUjllySXLamC7sEXYOdCKIUK7dDgUpftsHzP5p
	COKHvvgG2netX3ECV/g8QAvIlkLMwIKsO7v87hTeLU+wYIytAnIMlGsKohyScW15acwoX+x
	/Ki5PTapM7bM49Lp2TluQV1vmSFI1LF2a4cIe1dsv3uxRxJi9Rv2FOmeuXLe2164LTlFJHb
	IDFKpjfzHWgLjYX16S9X43DFgko1OGkR5n+p+cEzOMMvYDGu5jRYOWDckZdbB6xsA3Z7U/4
	UmwFrdlD8DwC2vOfLmgc/KU9V2Ffi9TIdSZmS9Oh7HDg86m0Py4OgfGghxPISU1jnPQgGgZ
	7E5yVV17jRL/rs3AqHKWa3Tgx7q1yiIX5MP2gCrD0xavY06HNisdBPa5Stqtubu180hEyyd
	rRK1jBsa3mLzBORpJlFB/w6PaXQ1OTlq0PgwLMhArQm5OoKkZrNr37rJYzqIVK6V9AhvCUv
	g==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

nldsq_cursor_next_task() unlinks the cursor and returns NULL when the
DSQ walk is finished.  A later bpf_iter_scx_dsq_next() call sees an empty
cursor and nldsq_next_task(dsq, NULL, rev) starts again from the DSQ
head; the old tasks are still queued, so the iterator returns them
again.

The verifier relies on the iterator contract that once next() returns
NULL it keeps returning NULL: process_iter_next_call() marks the
iterator DRAINED and treats later next() results as the constant zero.
A restarted DSQ iteration therefore hands the BPF program a kernel
pointer while the verifier believes R0 == 0.

Remember the drained state in the cursor flags and return NULL on every
later next() call.  The cursor has spare flag bits and the BPF-visible
iterator layout is unchanged.

Fixes: 650ba21b131e ("sched_ext: Implement DSQ iterator")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
v2:
- Shorten the code comment.

 kernel/sched/ext/ext.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f74ffb3b1aca..8a7a33e203c2 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -580,12 +580,14 @@ enum scx_dsq_iter_flags {
 	/* iterate in the reverse dispatch order */
 	SCX_DSQ_ITER_REV		= 1U << 16,
 
+	__SCX_DSQ_ITER_DRAINED		= 1U << 28,
 	__SCX_DSQ_ITER_HAS_REENQ	= 1U << 29,
 	__SCX_DSQ_ITER_HAS_SLICE	= 1U << 30,
 	__SCX_DSQ_ITER_HAS_VTIME	= 1U << 31,
 
 	__SCX_DSQ_ITER_USER_FLAGS	= SCX_DSQ_ITER_REV,
 	__SCX_DSQ_ITER_ALL_FLAGS	= __SCX_DSQ_ITER_USER_FLAGS |
+					  __SCX_DSQ_ITER_DRAINED |
 					  __SCX_DSQ_ITER_HAS_REENQ |
 					  __SCX_DSQ_ITER_HAS_SLICE |
 					  __SCX_DSQ_ITER_HAS_VTIME,
@@ -11028,13 +11030,18 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it)
 {
 	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
+	struct task_struct *p;
 
-	if (!kit->dsq)
+	if (!kit->dsq || (kit->cursor.flags & __SCX_DSQ_ITER_DRAINED))
 		return NULL;
 
 	guard(raw_spinlock_irqsave)(&kit->dsq->lock);
 
-	return nldsq_cursor_next_task(&kit->cursor, kit->dsq);
+	p = nldsq_cursor_next_task(&kit->cursor, kit->dsq);
+	if (!p)
+		kit->cursor.flags |= __SCX_DSQ_ITER_DRAINED;
+
+	return p;
 }
 
 /**
-- 
2.34.1

