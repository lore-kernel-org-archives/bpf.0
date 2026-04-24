Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E936A03F
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777071185; cv=none; b=YtnJ6gSniXOW8VCHp5taYteO4PbfbDrTq/Om+q3XML1Q+U2n3EFgGQsO6Z/v/aggvbB4ltIlZ/LfTb6/XK/DJNPBbhp/v5Lq1nW6jid35qqNfwFfO03T3SrxKwM6535dVOhTi/jDiYpVF4K42bQ8tMwQmH7KkS+ojTbc3JdrBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777071185; c=relaxed/simple;
	bh=KcYc2IyJBNQXyrC3Ld5Gbt6tFFPtZHzHqRbGFhWeylQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Clw4ihlpuKK2bmscaScK4Ott0TgeZASmypdKutsLsH+FZlmxnwqMsjyKFhqnAe4B91TCdvTHQfiqzMU3QNevkE9AjFW8XEXPf6HT+DM2ebiG8Rc1/54E+5x8viwiGN1ugWP9/ZH5+8Y/MmLabfR9rQzLaW0iJtDbbn3LRuY39qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rh4NeQGy; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rh4NeQGy"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c726ef332so11765508c88.1
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 15:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777071183; x=1777675983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGj1yGIFUFe4k7lt3K0iUmH7miZOHlaHTJ0uzmb+e+w=;
        b=rh4NeQGyO3FuV1IS7x618Uc1225POFrEQJkB8Hq6hLbd4vVMxflgUlXZ7UlBsiVDXi
         OcOkYZQe/Fnrb5BHOQqPpSlrNgXZlX4v9lnQv3g5eKMFziN3bhlpXKGsTdWX1f7LLpmv
         +tKT9pPzZxkp+b6FiNP1MBN1s0cq2D7frBoLpfIcSxWv3zNV7qwilLxFQHzV4TvX3wuc
         9uso++vZ7WqE8xRgnA7rkWhihMh6u5KfPc/gEu/wLKl/xoVMV9JJOk1AL+tmJIkCy5JW
         YEY/qtm+JstgM3x5zh/14rqV4kwvO1Y87gwDz+QfgNQZu06II0kIPOtiqr2NEejiBauG
         /CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777071183; x=1777675983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGj1yGIFUFe4k7lt3K0iUmH7miZOHlaHTJ0uzmb+e+w=;
        b=GCMVyZqIHTdrcibyNbLUwQzruNtRtCZ67kMiv8Dcqzhq9mq3m3zYKeEd8cNTJyn84f
         i372OXFX+tH3qoUYesKoXwtPwzkBS6JbW1usuZ16/AXkLSLPGAm+iVrqbrCz5q6zZ4Me
         w9KPzhHDnEBgMb8Ng0G0Gv/8cIPsuU8DQg98FNoRl9c6quazcDZbfY8QZNXOJv91STvp
         p2Ml41wcFON2ub7Vg4gDoHmn8nr6YyalESgVnjkjA8EGwcNA+b6PXsrySiLuU4L8/tWd
         mDI62k0kWDS8hvCykCVMqzym0ZsoFzCw1ZBK7Ky3bIOIkpv8a8abyGxWWzMCK0GUE6H5
         wR+g==
X-Gm-Message-State: AOJu0YwvZ7ryhIbla2aDJWGE+7GTh1LykXXQotbw4aB2gWcOAEIzO3h2
	1jjcUH5crlmgGvonqiB71FLnCQUzqssfRX/mQDz9ACD9irtgJwExi+4id1L22m46
X-Gm-Gg: AeBDiesWZOSYRXuYPf5W6NgGdguEDnlcBfgFRPg9BBY6Rb8BhbTmYKZMY29L9/+KshH
	7nIraTP86RmFwJIkWlDpQEBDlrNMRS3J05ySerlr1XyBjBFmOnTAWr2KRaH6JXH5HsMscdDburz
	93A++FjNmp3ARucTZsoljLGzj+dqB/0G2fORCBP4FeFn1gvIhBr7Y6p2ZyEiFY5DeJeref6NybF
	/EhpVoTKGlzaPUuRfi0Z1qBi1W6buJ1Yf0pqBiDZWDCXvP7Hj6BGEV2fuF4He8Wc9cL8W1oMIKH
	grZLP38BHKdxEr8SBwJRLkSevPrgfumSmaydZVjho4c+nOKCyD+djwFCgtZPP8NX0Ge5Dfz5izU
	yC8Yz8oRCE5X4qPC4djqtejvtwEo9gennD59XhbpYbJgOwZksgHuCpPd6FA03IN6QmKQhGeVjJl
	oCfAk+ETDVw38BUUYeUMOniAK3/7zO2uEoP0RqsIqI7VO/jfgpjG2HXJmK0tWeA4pN/UwYh5Hpj
	wL73EHRhms/VDubhvI=
X-Received: by 2002:a05:7301:6793:b0:2ca:7eb4:3e0f with SMTP id 5a478bee46e88-2e464dafc32mr17611148eec.5.1777071183311;
        Fri, 24 Apr 2026 15:53:03 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::1:b6b2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cff04sm33019868eec.23.2026.04.24.15.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:53:03 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	harishankar.vishwanathan@gmail.com
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: new cases handled by 32->64 range refinements
Date: Fri, 24 Apr 2026 15:52:45 -0700
Message-ID: <20260424-cnums-everywhere-rfc-v1-v3-4-ca434b39a486@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424-cnums-everywhere-rfc-v1-v3-0-ca434b39a486@gmail.com>
References: <20260424-cnums-everywhere-rfc-v1-v3-0-ca434b39a486@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

1. 32-bit range starts before 64-bit range's low bits in each block,
   causing intersection to skip entire blocks.
2. 32-bit range crosses the U32_MAX/0 boundary, represented as s32
   range crossing sign boundary.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index f0b3fbbbb627..5dd243e653c9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2187,4 +2187,84 @@ __naked void tnums_equal_impossible_constant(void *ctx)
 	: __clobber_all);
 }
 
+/*
+ * 32-bit range starts before 64-bit range low bits in each 2^32 block.
+ *
+ * N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
+ * ||----|=====|--|----------||----|=====|-------------||--|-|=====|-------------||
+ *       |< b >|  |                |< b >|                 | |< b >|
+ *                |                |     |                 |
+ *                |<---------------+- a -+---------------->|
+ *                                 |     |
+ *                                 |< t >| refined r0 range
+ *
+ * a = u64 [0x1'00000008, 0x3'00000001]
+ * b = u32 [2, 5]
+ * t = u64 [0x2'00000002, 0x2'00000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_before_block_start(void)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x100000008 ll;						\
+	if r0 < r1 goto 2f;						\
+	r1 = 0x300000001 ll;						\
+	if r0 > r1 goto 2f;	/* u64: [0x1'00000008, 0x3'00000001] */	\
+	if w0 < 2 goto 2f;						\
+	if w0 > 5 goto 2f;	/* u32: [2, 5] */			\
+	r2 = 0x200000002 ll;						\
+	r3 = 0x200000005 ll;						\
+	if r0 >= r2 goto 1f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+1:	if r0 <= r3 goto 2f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+2:	exit;								\
+	"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * 32-bit range crossing U32_MAX / 0 boundary.
+ *
+ * N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
+ * ||===|---------|------|===||===|----------------|===||===|---------|------|===||
+ *  |b >|         |      |< b||b >|                |< b||b >|         |      |< b|
+ *                |      |                                  |         |
+ *                |<-----+----------------- a --------------+-------->|
+ *                       |                                  |
+ *                       |<---------------- t ------------->| refined r0 range
+ *
+ * a = u64 [0x1'00000006, 0x2'FFFFFFEF]
+ * b = s32 [-16, 5] (u32 wrapping [0xFFFFFFF0, 0x00000005])
+ * t = u64 [0x1'FFFFFFF0, 0x2'00000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_wrapping_32bit(void)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x100000006 ll;						\
+	if r0 < r1 goto 2f;						\
+	r1 = 0x2ffffffef ll;						\
+	if r0 > r1 goto 2f;	/* u64: [0x1'00000006, 0x2'FFFFFFEF] */	\
+	if w0 s< -16 goto 2f;						\
+	if w0 s> 5 goto 2f;	/* s32: [-16, 5] */			\
+	r1 = 0x1fffffff0 ll;						\
+	r2 = 0x200000005 ll;						\
+	if r0 >= r1 goto 1f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+1:	if r0 <= r2 goto 2f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+2:	exit;								\
+	"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
