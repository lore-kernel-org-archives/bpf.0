Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794538013;
	b=fnuZ/jCBYwIf9FRaVxsoTDsnF/y9WD4wJkt5kCGRRg5NJumivMncoOohh4736DBmXJCF
	 9qcHB+EO+0Fh6VuZ354GMpONqTitkZmrbV681fDAAo7w/hx8VhaSdzUPdt3QcuxiYZSig
	 qjUHf7RuH6Qe5bn9msOfyMQycvgIu44Rf6e08v40oKaF35TS/Ncyx+WHfynwNGNB3iF/w
	 vrMmDaerA159c/AYmRZdWVvay8pxFBGXhdqPKT5CPINXIawu8of9D547z92bYol6isOwL
	 Zjn6ksJx6rXQA+4iDE0i8jMqWA1dGa1Rzruxq661+1SMKBFZR2P54FtcwwKrgJkeJSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538013;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=ZoUgNOzuky+BKyHj57K5wBljJWDfzkgnCUy7oUq6Re8=;
	b=YCUOHCGU7FXX+LvSRuIniTfVNA7juhttqsHjuZVva9T48JtYKoxEtF52fhW8nNayik70
	 LfwSXehEf8UfNXhJm+3FltqUmVQ3u69pPuj0uNJjjYgZGlFgthIO//e6tp9e/0uKUpn5x
	 fMXR8SJkgb8T3rY0ClYI4wRI5687u78gHz8CurZL5Emj4II771M8OcAd6ZwhLttmWIp14
	 cYoaIS3yCgp79O4Norn0IkJwr/QN/9ZVRaEwitBC6zsqXAj26R2Ayl2LOTHh9DJmI9dRO
	 mgwy2K9+w940lULO/RI0BlEa/R4601LdbqUgLrN9Qld50FmLbt8mHRY4JkJonS/3T8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b="hf/a4nYQ";
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24F606A321;
	Fri, 13 Nov 2026 02:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D24F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=hf/a4nYQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1794537914;
	bh=ZoUgNOzuky+BKyHj57K5wBljJWDfzkgnCUy7oUq6Re8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hf/a4nYQlwoTW4l9zA6WEuTRXbWEpDseO6k7hx1o8ArQ8tjk9xkdbe3snUv36n5Dn
	 2ueNDyrvqZyu/oY2nqAe097qLyysonaek9BE5ZZkRPL9h7XddhrlsyFPMi+idcchG2
	 koISafbyXINVolEMZfJ7MgqXBC5mtaMwyK3QAlhk=
X-QQ-mid: zesmtpip3t1794537908t89f91e2b
X-QQ-Originating-IP: I7dyP3jMDpcYscZrnWzmbQ/K2dCgLhDcVhP+g+Ji61w=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 10:45:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12657397245065214614
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH sched_ext v2 2/2] selftests/sched_ext: check that a drained DSQ iterator stays NULL
Date: Fri, 13 Nov 2026 10:45:05 +0800
Message-Id: <20261113024505.922854-2-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113024505.922854-1-k.chen@smail.nju.edu.cn>
References: <20261110125113.2935742-1-k.chen@smail.nju.edu.cn>
 <20261113024505.922854-1-k.chen@smail.nju.edu.cn>
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
X-QQ-XMAILINFO: Ml8T/6JCI2CtUq8dcZUq/vlruxBat4W0Mr494KquwvexP9ySz2vtqA0E
	ZSgt/0yWw46fbcQltUuZejcv3m4HnYZUQ5mkFVGLr42VMF/hVgV9FVVDrPX53WEB4jg+20c
	IA5PE2fadkXZrF4RJWxzbiM0hPLJQI9cYgVfS9BYzzeAIATrZYUuyu7UMW50Z65WrFSzUGE
	i0CrTQx+vR0fj8lX7ziatLMNxmYPfF21HAAt6hwhSF6hp6ysRnNgAwDAgQpg0qQsyWhxWyn
	i4G9aaGRSe2VkbVBtZAhg5e0eQgPOw3bwwF+6jAFBiQzU156oiOfmTV1+Avf9O8NBOSYRAs
	lut1Cg79dfRO6+COybmGyEzdTZu9d7ZCTrP+ZA/KzLHyV2ND3DFTmYq2jQKhOQgr31NcJAG
	fCkiq/iMX37kWlWqQkQP8jcS/Gl3FvBEYBgqBLGoJbEr5BlCvY7nJqPXEfX0JkmopDEdIsM
	3Oj6oig9JrUx3lyExiLNTWDOFncdx8p44Q8GtsWeYHT2WvqvtdN8p2aORe30NeXweiXx8Lt
	YyUzraSy2ChaqPJKYK8wms2TbMxaM9Yw2Ltk9c+SizPhkH4Zdmh8g5kfCKtAxbBFWY4wVov
	e7wxI2OxOP1EPcfYmmNCkCSphHQnBnqcwyI2sRL/0x4goNw1PlikYruUB+Ybn2RpjYXqQ4Y
	U4HWIRVYWgNQWlWPvtaMo7bQ/lypEbAKyS0ayPRtMEVSmEvbVerknwAdZX/oq6epMknFvOJ
	6DvaYSiMFmAyeJ7NcvQ9jxmFhIxI170t4C6/i/dLyaTzyIy+3pVeetQwkIX+mMfp6dZl2dj
	MYTHVGsp8pyYcjxZKxJNjJzHD5EN493PhKvdnGan8J8x4eb/foprQo2cFICaxz29u3NrcZP
	/8C0F3LBy/UbgAaPjnP8JouofqXUIBjx8Nx8ODg+DM+7lK3nisl4yXsh+EsHoZXCVsy2lGk
	+8uAwVXaJl2leJpW0kEWIVNT//TTp8SqRcJyezl4jz9s3qBZuwHfVkB3RhYaskQ24ttcezf
	m2U2pkj3UpwSnXfu3PYDOYBzS4tCMmCR/AAJcPqaldLoxNgYPmrt0yITMNEja2mwGD7UEYS
	Q==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Extend the dequeue_iter selftest: after the DSQ iterator drains, call
bpf_iter_scx_dsq_next() once more and store the raw result.  The
user-space test checks that at least one task was iterated and that the
extra next() returned NULL.

The test fails on a kernel without the drained cursor state: the cursor
was unlinked and the extra next() starts again from the DSQ head.

Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
v2:
- New selftest in v2.

 tools/testing/selftests/sched_ext/dequeue_iter.bpf.c | 7 ++++++-
 tools/testing/selftests/sched_ext/dequeue_iter.c     | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/dequeue_iter.bpf.c b/tools/testing/selftests/sched_ext/dequeue_iter.bpf.c
index 76c2c71a90b6..38eb2df54a6b 100644
--- a/tools/testing/selftests/sched_ext/dequeue_iter.bpf.c
+++ b/tools/testing/selftests/sched_ext/dequeue_iter.bpf.c
@@ -18,6 +18,8 @@ UEI_DEFINE(uei);
 #define TEST_DSQ_ID 1000
 
 u64 dq_count;
+u64 iter_count;
+u64 next_after_drain = -1;
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_iter_init)
 {
@@ -47,7 +49,10 @@ void BPF_STRUCT_OPS(dequeue_iter_dequeue, struct task_struct *p, u64 deq_flags)
 
 	if (!bpf_iter_scx_dsq_new(&it, TEST_DSQ_ID, 0)) {
 		while ((t = bpf_iter_scx_dsq_next(&it)))
-			;
+			iter_count++;
+
+		/* NULL must stay final after the iterator is drained. */
+		next_after_drain = (__u64)bpf_iter_scx_dsq_next(&it);
 	}
 	bpf_iter_scx_dsq_destroy(&it);
 
diff --git a/tools/testing/selftests/sched_ext/dequeue_iter.c b/tools/testing/selftests/sched_ext/dequeue_iter.c
index f60711bf3b39..48e8c94b7bf1 100644
--- a/tools/testing/selftests/sched_ext/dequeue_iter.c
+++ b/tools/testing/selftests/sched_ext/dequeue_iter.c
@@ -59,6 +59,10 @@ static enum scx_test_status run(void *ctx)
 		return SCX_TEST_FAIL;
 	}
 
+	SCX_FAIL_IF(!skel->bss->iter_count,
+		    "DSQ iterator drained no tasks");
+	SCX_EQ(skel->data->next_after_drain, 0);
+
 	return SCX_TEST_PASS;
 }
 
-- 
2.34.1

