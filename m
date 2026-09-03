Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C894B66DE
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446685; cv=none; b=mchs8sFftaUwWdckFfWyD4h9915bqS9+dxcdnI8dCPCYj9DsrcZFdV4X0346+KnkFAA4mLedQKlXU530QsblqiYGDq9snYNzGycKuv38XVPw5paZYzvEObNBKS+lkV+RW0aFRyB6lkgwt799ars/VyhzU6Be+DvYhIb7OcYosm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446685; c=relaxed/simple;
	bh=yHsz7B5Uuw0+7sQmMpTLoNABbZIVgWLQzH0MH/Ul9pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JB2Y9K6Vkr+wN+XD8E6w12/GQNBgncsckD2Ckl0JGJGMEjbEVGKpXp0anFOubEpxD5lCkTtIgIVwvK6rHNgLVJNJDNil7QQrcxARPAsk82IzlfTBu6uvlYTvvMcQN06dc0I4ingsCy1YfW01GXPVlwbnRgrVkzNhKVDvZ/UyuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJaUh1JL; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJaUh1JL"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4843e397f74so1606268f8f.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446682; x=1789051482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88RRJqmeibUWQIvrVY+5aTETnD9Ncf56HIg8fRO2HEs=;
        b=TJaUh1JLxCdoPdwpplZps7kIS15fX8768BIjo1qGMrZaBiw4BWxtZCKxPCi6tDcO0C
         JZCtSnuKSMFVMODANFa1KpBQHlsgmxoxdsBfkeiTk87UvmzIE+Gt62+c0ioSokDbWunZ
         cQXN2Cn/OQxpr2KFCHR+ON6VbG4jTvrZaaf3qmvsxOoMrswRS10gLKH3yQ4PxFcacCwm
         XTfITnxQdHMkIlOEd6rbfMs548Pv0aEywSPzdGfwpUCPLLalpWXomyFqx/AQ5Q13pKFY
         yikuhShYJ+hi/CwcnvhmLyat/hP6i7apORGuXHesa5oI8HlKoZ4tdoU0Poel3u/RFT7C
         XdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446682; x=1789051482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=88RRJqmeibUWQIvrVY+5aTETnD9Ncf56HIg8fRO2HEs=;
        b=Gh2Zol5/y5pjLV2MLvgCy905z7P+87sydq9wfJn1n4VLu8EEDipt1FqZgDwZgsUK3I
         tRB2R2XUO4RHjEWDORC7Uko1xwA1OKXlHI76xO2s9DLoJahWfYQByC7YcvjZp2Ppydlc
         QMkRuUo2KpEm4WQvAVa7akswfOd30pQgtXUvvfd+HPislev4kUyGZSReRvGYLeuAjXnX
         X9rw75GkEDsH6wdbDzq/In26aQsZE+1GOTjyYZydjmxxrUY5Qoy54LMlRkZ3WH334qvx
         UVXMQiv/MbdE0f5vRHiw1ctg+vWFqLJtsWdlDCQJIjeVj4qwaqAhxAs11vJXfEah07i/
         NQkw==
X-Gm-Message-State: AFuF++mY9GV8xxfPkzf3ykuavYV/Q0HxmmR+V2E01U2UqNXvsxsVngUc
	o9QI/GR4hhZwx5WiUpyMzvPKW8tFhQyCHqr2AVPcizriVCQUmODD72+RUwSLAl6B
X-Gm-Gg: AYBFou32/KBmNMJqTEqNSGcb1Lz3BJBBcAGyTDFsxXC8gSz2lNt6VAZ5oqiR2AIJbd3
	akJ3a/qg7eUt8FXHr4A6phmN/yvvM1TwIU/CsHpLNybJ2Tq4JMC7vYEH0f3dwHs008L1rFeXMiu
	2kqyr4bTt1J0O0uV4Dsw6tAMlEBEWcbLsNFwWKQdkevAi8YrwiHHhculq4iFA87zeXT+utcYb5f
	VTngc2+3EgdRsrvbsLToxqtVY7Frc3m792WNcjpaNjIuHQ9ejFow6gzKraewGdzMJwXFheS80gv
	iA8Wm28B/prI4kpbLXgNV+aGv6ON4TO46OrFFdU0+OzYr/CChk/V2xAo+Cszjl5DKTRlPa+cwwh
	DNt+cNOZyEojQbBGVEYf4A/81iP5qid45FwzBZdDoXqhI1q7bwcA5Mjh1SBKajPIEr3adwoDHpJ
	9zB2+Gl6ChNnbVefeGwW5+++0UZtzOir2aLqHGoCjURMd2/Xvf7PaKdAqBlmDd3ab5saPyjVgPE
	l0xBBHThFvhmpm0hSPDiwAtwIxei2yKvldxcF1RKfDNRAsepfKt97pkEi8R7qVsFgXuDXqQSiQC
	3H14rNpytmMyhSKdy9yvkKJ5YDI=
X-Received: by 2002:a05:6000:25fb:b0:485:8226:c699 with SMTP id ffacd0b85a97d-4858226c9a7mr5416798f8f.24.1788446682085;
        Thu, 03 Sep 2026 07:44:42 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80388sm16028761f8f.14.2026.09.03.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:44:41 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 04/10] selftests/bpf: Test direct tail calls from callbacks
Date: Thu,  3 Sep 2026 16:44:22 +0200
Message-ID: <20260903144433.1716731-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144433.1716731-1-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=memxor@gmail.com; h=from:subject; bh=yHsz7B5Uuw0+7sQmMpTLoNABbZIVgWLQzH0MH/Ul9pE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtm84Q1OwqqN56+PVfn2qToTW1bYv/VBWzjUmB6O+uq0 Gz/L48EOkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCR8I8Mf2Vu3Vut6m9ZOr3p RElAsLHGlE3vXujpeMYGpk5NFfoU9Zfhr/S0Ftt/pzdp8PoE83OszlnvuzO+Wnx78Hupr8d/LjC +xQUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

tailcall_callback tests a tail call one static subprogram below a callback.
That reaches the later stack-depth rejection, but it does not exercise the
tail-call helper while the current frame is itself a callback.

Add a callback that calls bpf_tail_call directly and expect the existing
"cannot tail call within callback" diagnostic. On an affected kernel, the
load instead reaches the "callback unexpected regs" verifier bug, so the
expected message is absent and the test fails. The existing ordinary
subprogram case remains a success control for legitimate tail calls.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/tailcall_callback.c      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/tailcall_callback.c b/tools/testing/selftests/bpf/progs/tailcall_callback.c
index c41632cf423b..14fa7a87028e 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_callback.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_callback.c
@@ -44,6 +44,13 @@ int callback_loop(int index, void **cb_ctx)
 	return ret ? 1 : 0;
 }
 
+static __noinline
+int callback_tail(int index, void **cb_ctx)
+{
+	bpf_tail_call_static(*cb_ctx, &jmp_table, 0);
+	return 0;
+}
+
 static __noinline
 int callback_empty(int index, void *data)
 {
@@ -78,4 +85,13 @@ int tailcall_callback_2(struct __sk_buff *skb)
 	return 0;
 }
 
+/* callback with a direct tail call is rejected without a verifier bug */
+SEC("tc")
+__failure __msg("cannot tail call within callback")
+int tailcall_callback_3(struct __sk_buff *skb)
+{
+	bpf_loop(1, callback_tail, &skb, 0);
+	return 0;
+}
+
 char __license[] SEC("license") = "GPL";
-- 
2.53.0

