Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315145;
	b=oobC8jL84Wma8sStTeubeFQ0lL8p2uLjs760O8azgYZc0IMSpBou47hWiXQ2MJlmdKhE
	 4woFg3Ua6QkDbC4S4Y3YXCL4WBRfqvfFnXnE7+/oJoXbtfquQEDqOPugcYABYfA9p6RtC
	 q4aWfcqUDX9e9j7u64xdgeu3MACD0jWMlAtoQIx76P2QPUYQwD4PugOFm4i6W7FNsbP3P
	 JsIlyRQvAPQWEwSaDuPnWyQyHZ64RpH6JKABZEkXWvMRc9ThHvwQvAMDkTr9Q9n4LgToF
	 4O8uIUbY7A1oCIZbNaD1SSckYzQGB3uRoz8AzoWcAtxnC4p+46H2e7rYDOliFld8Qhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315145;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=O/4t0fmDlw3ey9yibz/+cpBbJK+aVAgemr+JbdbCis4=;
	b=k75yOrhnnGK7yimte79n96C4NsqXn8mD+80RbIhB2QmOlv8dVxkC+wTv/6yzXf9pjMyy
	 DeSU4sQu+cmG4IFZpR1iKLcRzX3B+5j0Vs4eZltYeFYiyPaXfRPuoCxrci1sWjZIg7Ck6
	 KkS6O9N1dDg7/r6tGL1wkdu7x40yh+w4XVKYIw0CBZ7yIEiuhGAlW3jh0fuGY0f/DsNMF
	 OOno8xPWI40HfYhT5XckpCwrubOlDvQ+LWyY6mRBsLMwmXNH3D+AyCqJRnz3j/eokQp8D
	 EbyFdgMc5sPsC4943ySsHQLZ0fW4e90CXSCmkPZELpqevKA8O4sRhhi/Ph/bYyRLopw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=oe33SrFz;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B27C606A32A
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 12:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B27C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=oe33SrFz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1794315074;
	bh=O/4t0fmDlw3ey9yibz/+cpBbJK+aVAgemr+JbdbCis4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=oe33SrFzaxsfFrezNkP/CJia0gvLRPVc5eAQDA2oPq8fnOmaoatArDBx8mpZUi8Qo
	 8m1EO6ETMDXZNq4ks8qJsC5RMz0Yb9TMVbEg6HvecB76UR1UFlX2lmbloSrQye5JFZ
	 T07mv9SwWy723wVs78V8Ibk5GMi6RiXHLPpL2BfU=
X-QQ-mid: zesmtpip2t1794315072td94b9037
X-QQ-Originating-IP: kUPMYRU8RXedmnEzvofaVAd6aIx214/gp9wE5oQPGe8=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 20:51:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14794258371886372565
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: [PATCH] bpf: make css iterator stay drained after NULL
Date: Tue, 10 Nov 2026 20:51:10 +0800
Message-Id: <20261110125110.2935707-1-k.chen@smail.nju.edu.cn>
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
X-QQ-XMAILINFO: N2K7JO7TcIoELdlYmZvit1wf8scYIkicgH8LUHLcCuKS85dRU2yf+nDs
	op+9/GKLuwP0NGNDYxaEFmgYL8JglNcNIoGLXezg1lx+RYdNSlak2CoLHL0aeqJiKQW9b0V
	exfv3WgyDUrYL4V5DNOAMCRnKNC/aGXaer6im4Rc4HdM6dQRfnWU9pAK6YNbMrEDlB43xst
	hoO9pP3OZjTjRH1oOGmyqgDVJ+2Oml7HStJA9OEPz5YVsecCNhHk2ejchLUEgwVuQZ+NSnQ
	wqtu9al5fXyn4To4/Q+Iz8MOGQjEfULhLZzgSjiA3gN9Hx+k8eXpDW887zmarHFR9T5i1mR
	YbFdX8OeKZdjm+v74e/Gbe1nEmW8V/9tfDUvJ490U0KeRsSvUEun/xDuEEz2fZL4C5Rr9uq
	DuC9yaU7StgMnHRHTcvsSxHga2V8T1LWV9kBVBiv1nDok1JCr4jjtwJuxRWS9m6beoWUPY+
	HVyE8qp9uKrnjQ1gpX27lo9LcoCa3zt+nBR0Bz9xaMBnWeGoiePmBk9nxJ069UaWO7i1dDJ
	pMMBYlmiw7o5w3BaTAy+qDVYS2kTPimXzXSmlhlHxajv0ykJ6cU+FVO5ZkJjDFINL87koYU
	aQ9iZEmf30vQynsQ6GFcNHH9vgSX88R45FTlMNN/7Dxy6xhOYVfU4KRKGbaSoiJ/rWcIgrK
	SPa61QO/m67ogW6lMq83sMPPwgkeOHZsSEkKA8Rn3GAV8lLfKtFBPHlAS/t4egXqjfIsdmW
	zuEM/HyYd0I6RDBcLJr0bkE+Crj3AHihHwETURJwEb7g6jfV0blhrHXT0+LuWaNAb7oV4PY
	/jMpuebwUW5ZiVWoMfrPxmhdQCe3modODYpB+/lYY05dE9H6IIUsmLXbjySGcKAgh86FuTY
	+sryA+j8Nar2KZofdkfUaewsIBTeKS35FXhqRudyO2hyeytSEvGKIvHV17dOSZzc+8WmFZ+
	p7s1QRIZf7RCPdaRcQQqkoz7kb8VCMSHn5mLEb+4UkQ3CeyLx7gH3OIWqTG1SIu4sOdDgNS
	FFYIjYzFzhxn0zQTmH
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

The css_next_*() helpers start from @start when given a NULL position.
bpf_iter_css_next() leaves kit->pos == NULL after the last element, but
keeps kit->start set, so a next() call after exhaustion starts the
iteration over from @start again.

The verifier relies on the iterator contract that once next() returns
NULL it keeps returning NULL: process_iter_next_call() marks the
iterator DRAINED and treats the result of later next() calls as the
constant zero.  A restarted css iteration therefore hands the BPF
program a kernel pointer while the verifier believes R0 == 0.

Clear kit->start when the position becomes NULL.  bpf_iter_css_destroy()
is a no-op, so no cleanup depends on @start after exhaustion.

Fixes: 7251d0905e75 ("bpf: Introduce css open-coded iterator kfuncs")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 kernel/bpf/cgroup_iter.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index fd51fe3d92cc..fb7ba1e45590 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -365,6 +365,16 @@ __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *i
 		kit->pos = kit->pos ? kit->pos->parent : kit->start;
 	}
 
+	/*
+	 * A NULL position means either "not started yet" or "drained" for
+	 * css_next_*(), and all of them restart from @start when passed a
+	 * NULL position.  The verifier relies on an iterator which returned
+	 * NULL to keep returning NULL (see process_iter_next_call()), so
+	 * clear @start on exhaustion to make the next call return NULL.
+	 */
+	if (!kit->pos)
+		kit->start = NULL;
+
 	return kit->pos;
 }
 
-- 
2.34.1

