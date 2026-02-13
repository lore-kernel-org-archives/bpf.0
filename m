Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBD22ACEB;
	Fri, 13 Feb 2026 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770950785; cv=none; b=M0RiTS8g2JbcNhYzaj0GVuaVxzNzTDAhV2Q9zPsfHK/+RqZwk5yvrmdIcIleaJxArmIIu4tXnFisS0G2BexagE1od/3exvjEx33CFheR4yVgQtpGpS1ZoMe2EDSyd3F7uUojHsR3fo6oH4oBU2vPzJWwxMo9TV7FDSIlXTToCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770950785; c=relaxed/simple;
	bh=LDZ94JtoHMM1UEYU5Q90klCQ7sVAFPEQpBpyLjSIKFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yb4si6CSQrvtYiQBOWgBZfOYgplfJXmGEqTQePBDKQ8WtABsZUMNk0I0rGIYM19y39H95WxlSPBy9EsVYZ7nu6OP3cC+KGL2VTdPVqpWEVHHh0D2v3AkGGTZ6vYFyBqqLESeti8gs7n8UpvLqNVOt80CwP/JYWgStq/BQ60L7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dE2ZlQ7i; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dE2ZlQ7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4e
	RwFhUgku6857Z68xn0kodvZ/XzFvUeVFNaJo7REB4=; b=dE2ZlQ7i0edP11WknB
	LWkXHmBBKZyTlM2+OE4VJ83j5hWivqA0fnD2lN5Zy7tO57/UbpPuPrcp/+mTbHVx
	xhb5/OAITU6aTRW0BDBJyvr1KojB16h1Qcv72f9C4MHMThNDEG/qAEbypwphruii
	Ey9F4VSGtkmRmLit2W++xibX0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnZNoNkI5pvhZSLw--.1343S4;
	Fri, 13 Feb 2026 10:44:32 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	posk@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangfeng59949@163.com
Subject: [PATCH v6 bpf-next 2/2] selftests/bpf: Add selftests for the invocation of bpf_lwt_xmit_push_encap
Date: Fri, 13 Feb 2026 10:44:29 +0800
Message-Id: <20260213024429.39972-3-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213024429.39972-1-yangfeng59949@163.com>
References: <20260213024429.39972-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnZNoNkI5pvhZSLw--.1343S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4kCFWxXF4rArW3Wr48JFb_yoWkWrg_tr
	sYga4kCrWxGFnIyayjkr1UCryakwsxWr9rJFsrJr1kCw4UX3Z8GFs7Gr1DJas2g3y3Kr9x
	Aa909F1Iyr42qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRCrWFDUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8RAmnmmOkBBaUgAA32

From: Feng Yang <yangfeng@kylinos.cn>

Calling bpf_lwt_xmit_push_encap will not cause a crash when dst is missing.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 .../selftests/bpf/progs/verifier_lwt.c        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_lwt.c b/tools/testing/selftests/bpf/progs/verifier_lwt.c
index 5ab746307309..9cef07e6eceb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lwt.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lwt.c
@@ -231,4 +231,24 @@ __naked void not_permitted_for_lwt_prog(void)
 	: __clobber_all);
 }
 
+SEC("lwt_xmit")
+__description("missing dst when calling bpf_lwt_xmit_push_encap")
+__success __retval(0)
+__naked void missing_dst_call_bpf_lwt_xmit_push_encap(void)
+{
+	asm volatile ("					\
+	r9 = 69;					\
+	r3 = r10;					\
+	r3 += -32;					\
+	*(u64 *)(r3 + 0) = r9;				\
+	r2 = 2;						\
+	r4 = 20;					\
+	call %[bpf_lwt_push_encap];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_lwt_push_encap)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

