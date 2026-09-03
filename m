Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804E42902C
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446682; cv=none; b=aKYY2A893QZqCP6nEi0uF165l+U94oF5OlyYRazuijHcmhJLhHQkdHbWgHUqHXe7zGroAj+6xdCIgVp9nf89b3tqCDrvDMPSiOYRSeQeWXf7Meoz2yJR+yOKdfWjcmkHR/Hxk0tHbCeKOHISO0qDcUG+/HKCwCq9rdqumeM+HWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446682; c=relaxed/simple;
	bh=u1sXiNdijn2rnNidniWFHFdqBgAlguy2SwdhDkdWT78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsikBy/MiiHC5og3vFJ3PlZ+X5gwDXyST4wGJ4OZUjIoYHGXsARWic5BZRhQbmusSgv9GRG+E63ek/57ikDBewm6m47jGDPjEMfTrRXNET78GYIDFF63hUV8Q+2m8IX7+jgJ12mDJGGPq6SHXM0B7j4QgZg1h+WgyNbaLZMcAYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGq7P5id; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGq7P5id"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-48437576531so864717f8f.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446678; x=1789051478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mkFtkIvLmpGZP2KngbHc9AXiIjqhknZ6xdrwQPSZ2Og=;
        b=DGq7P5idayGUJBW/A6gVTmTj31JG47/sSlnPGUIo0lOiJ2t/4PAOYZVFrjwnnVx79q
         HU2mit58P/JFX9yVunDy00peOZwaQtnqDFhTrKdM8P58QDVh/BsumXKp8QkdfnaLksbP
         OqSO560hR2fbJlMjX3RaDHSsZumo0rMB7Xq7v9nbS1IdCWTpgZDjY+PMkQDM6kKiznzy
         qIfZMyP/Cu/aCLy+A0I3o05fKNXzafpAn1DHdEvmdEOjUmDBDL38QB1z/Hi0i7BN5aag
         CN6yAIUoIOA+z8g4YOSA38Q+f27CHOgMzxgY7H2nMFrkZ5NnCbGKSsYDwqpNmMhwQ95X
         Wqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446678; x=1789051478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mkFtkIvLmpGZP2KngbHc9AXiIjqhknZ6xdrwQPSZ2Og=;
        b=LLvX8AxWeojnl511lxbGjsT47AL/P8ML+qCSASWq17dc2P/jSn3FCi3iqhEzyY7gjf
         OVQamKaocCIVbXsc7hSdDz6Qi8Vk7TPJm9LpNlMM5IwN5pGDEJJXzZcbV8qSywC0MpI1
         up9HETyr/uJqb/K8UjudDertltxlq3Z20fpmU+dfzbrwjdRIA244ZrlfbRpR03P66lS7
         9o/xpvN5RF+FyxdrwO5up4xbCvwLScaTVKB2nUWHiC1D70Sqa38UwY/8btOZ1YTAtkRR
         Y4FdhX53XKbV+nnLZvb9bk1e8w+YR+ZhX8RuOMZ2wZ/lgrQeSCqBKq5SzUhUponfsFyj
         OQJw==
X-Gm-Message-State: AFuF++lVFvo1Ov0aVUMxvcCAGmao75r7T2SF+slg7BTiwH2rEe+zyK3q
	L3Um9AhbmiNVskaOI3CwiCQmGLdNnINADcQyXpJVSPZk90KbAum4xR04wWHxOFyU
X-Gm-Gg: AYBFou3ihjcn0wwkTpbmnVZy6G7SEDvYG0ErdyEJ4Krehj+P4rCdUvYE2PJ+u2E8T+Q
	odDOGFqjtTnn5D0qDFZwbQgIAARU2t/1H1ARlmm3M3F3QdSk1cLnHd3iJVrqH9i4qTEUZNimz6B
	uAwimDNMkhNc88Sd093gwKbw0AFkpd3m58SVqKkWtz6sKlC9uVddkHmKTwnAPAB+WHjp1P+m8hZ
	JbIxpRzI0YvZlRWFCVLVhRXwXa6Bqb9zZitBSTO2jsn8iNWlWHalC0QUuwvAmyoPoMDXetiBmu2
	desrSzePoMlH8lEGmOxfreku6MmGJgaRgvaofUqkmU7dAehDMBOU9jXii4/qAek+dtqohu9N34b
	yB2PNAmkddymPH0uqC6N0+w8hO5cOPA3sM/WEd4y60u8uEtSRviOM5JTW5dhMB/oP1kqnjbKT2w
	FqPk4M1Ee2V4eNWW/omBJEdp5DWZDT6KJesa/eEE+oQzeZzqnowotniji7KPAvRtvBx6WjSumVY
	Q9njz7tP2qEFdLBx+7XFVD3kvB00klQjrU5vTLKhMvynjCnwYMLBzwSkGhC2Ji1nfiAPERRLg0C
	doWaxqBu62d8DBuSdF50kPFgcVg=
X-Received: by 2002:a05:6000:2212:b0:485:1bcc:67f8 with SMTP id ffacd0b85a97d-485860bfc30mr1541840f8f.13.1788446678403;
        Thu, 03 Sep 2026 07:44:38 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80798sm13599672f8f.13.2026.09.03.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:44:38 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 02/10] selftests/bpf: Cover signal tracepoint siginfo sentinels
Date: Thu,  3 Sep 2026 16:44:20 +0200
Message-ID: <20260903144433.1716731-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144433.1716731-1-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; i=memxor@gmail.com; h=from:subject; bh=u1sXiNdijn2rnNidniWFHFdqBgAlguy2SwdhDkdWT78=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtm84RDc19LPq28Zfnl2AVd8dV/5F+sf8xiMffDQknps HMcZ/JSOkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRZD1Ghsf18d5c/7bb/gh2 vRNSZmVSwHB2m1i5Ss6bkqtsIbd0DRgZvho29pnv8668WCx86nQG/5KUoldm55ads34amsfKYmL DAgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add load-only verifier coverage for the signal_generate and
signal_deliver info arguments. The signal_generate case performs a NULL
check before dereferencing info, ensuring that merely making it nullable
cannot satisfy the test when the nonzero SEND_SIG_PRIV sentinel is used.

Both programs load successfully without the verifier fix, contrary to
their expected-failure annotations. With the fix, info is a scalar and
the attempted dereferences are rejected.

Also add success cases showing that plain raw tracepoint and tp_btf
programs can continue to read and compare the context word as a scalar.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/raw_tp_null_fail.c    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
index 0d58114a4955..7e8842bf9000 100644
--- a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
@@ -22,3 +22,39 @@ int test_raw_tp_null_sched_pi_setprio_arg_2(void *ctx) {
     asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
     return 0;
 }
+
+/* Plain raw tracepoint arguments remain scalar values. */
+SEC("raw_tp/signal_generate")
+__success
+int test_raw_tp_signal_generate_info_scalar(void *ctx)
+{
+	asm volatile("r1 = *(u64 *)(r1 +8); if r1 != 1 goto +0;" ::: __clobber_all);
+	return 0;
+}
+
+/* tp_btf programs may inspect the sentinel as a scalar value. */
+SEC("tp_btf/signal_generate")
+__success
+int test_tp_btf_signal_generate_info_scalar(void *ctx)
+{
+	asm volatile("r1 = *(u64 *)(r1 +8); if r1 != 1 goto +0;" ::: __clobber_all);
+	return 0;
+}
+
+/* SEND_SIG_PRIV is non-NULL, so a NULL check cannot make info safe. */
+SEC("tp_btf/signal_generate")
+__failure __msg("R1 invalid mem access 'scalar'")
+int test_tp_btf_signal_generate_info_no_deref(void *ctx)
+{
+	asm volatile("r1 = *(u64 *)(r1 +8); if r1 == 0 goto +1; "
+		     "r1 = *(u32 *)(r1 +0);" ::: __clobber_all);
+	return 0;
+}
+
+SEC("tp_btf/signal_deliver")
+__failure __msg("R1 invalid mem access 'scalar'")
+int test_tp_btf_signal_deliver_info_no_deref(void *ctx)
+{
+	asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u32 *)(r1 +0);" ::: __clobber_all);
+	return 0;
+}
-- 
2.53.0

