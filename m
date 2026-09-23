Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4AA566C7D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190722; cv=none; b=GoJcVnho4TFpS45ojeQh1lGuXW8tAzqsqKM8m3MH1yQ/oc8FgvzuGgwrIz7JpTBwB3rBzX48vlKBFGE2CzpHartpyVhs+VkrV42AMcElP0lo9awFMrAuWQK3+3//YiwNZjJUwt/+KWJsoaeyr7P9a1nYiGrOTvP5guW7TVIV1i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190722; c=relaxed/simple;
	bh=i0ynLbSwgzfOm7o4IJSLX0RoNEADaMII0zDO9q/uV4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHr14VoDesEu6pk8EF/BmoBFIQXCZzi33uz9edlnd982g7RiK5k1aFIIMMqMbHNotYk80qHjF4ZJu1WJpT/VZsFxmfC1v5lbBbsTVxi5cpQckdSrBgEGPPgEpv/jaULM7ivxg5nUkNvqj/laQVIqBJrhiwdsEh/zUBm/6hDYL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNv/huyD; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNv/huyD"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso4640915e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190719; x=1790795519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rk0W2+kDQ9wOmen/Go1msDr9ipAbOPS6t82SaJP0VV4=;
        b=VNv/huyDkib5/tIICCI7pSAffJ352gc6xG/OJqAgRZg/46/1Tl71rI295vR0SNjHp+
         MssmTkH/kOKWi9H1jXj8mH2iyXEx92XkLC91IFeryNQh/fX+YmxC42WGCClhh3lb16iG
         3gVqWPs5TZg9BFb2egR0gxq+0D/Vf16v560ZyQf0cAsYp7YJFZiQ6orciLS5U4ayCuMg
         6CcQShAZ+v2InabAJG2nHCNHSrK870EYlva18vIe0IvhPjhJy9OhtladHgUXUhOFabXy
         8C9pIoDGF/JXbBHROq6C90l2ujaTnflvpYKKd/74RYiqj6Yt+oEOropYS8Wz9AGcsYjv
         xn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190719; x=1790795519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rk0W2+kDQ9wOmen/Go1msDr9ipAbOPS6t82SaJP0VV4=;
        b=p9rEPqisLGIjVFVZ/n9OfZOCyLOc/DzJiE9oh5R2M4wzNa1YfMJc9HiiFDYGme8BVt
         42pvrJM+RPFYsd9Viw4hwK6CO4YajzwIXcN8QeEPs7tO7QB83jTRBgq/4KnjP33nW27F
         U8OZUqHu+lWoooZ/0mjcmOEIOuIDCH3+5laXlp1ktt3o4dbACoB6R6U1t+ytGZspYxzB
         uoFGqoYyv4S6I7TwTbqbdY1LB66H143uZt67TkYf9NO0qNOCKrTJLG6Cof2jpGSCuOKx
         K2N0J8BCiWwtilsiI+HDmyPFU7dwkQvd9A/gn0EFqaO+tyYWhlxq5XQOnelB/FKpNOAm
         3LFQ==
X-Gm-Message-State: AFuF++laf5Na3Vvxle0U5NNumKx+L9fjWm5quahozdLLWGJQpzqgjBxl
	Xyqol7LHvM+d8jVHMprsfOc5iPKGEGp232gCk6NWMJkQwtWn7PD56wo11kSjPbI0
X-Gm-Gg: AYBFou0wpz5EqaOzcm6pRo9ACUIwNMVkZ08xC4XezPM+xhW3pevWzPCzpT47eueLfHA
	pH/MSJjlz46YDsFWibLxQro3jlB4ZcnVfOLFTZLNwr6y2rvlpYIMtWSRRKbMq2wKLUjMlUxy063
	/Zr/viGZWZ9i361qHJ3pKJw028zz9vXG3tgDn8ZLBS+L6ze6HPOcD2T69oo9d3eEVuF2VXh3Tbv
	WaZi8m1JfAeDQ5lBCSFuiWhGgNueyLzNleYfc+4n0djAXKQGajWLlRKJvGLY+GvpHG77Ljx6Jo3
	o79KXl7fgpT5y11i+xQejH6vwz/vEbaYW10aTrDSoxF0SyiPYanB2IA7oH3ITOUMKT4TrOiZlmU
	an3TT+jyJ1MkNW5uEBLPcavCZqsRUBASPN12i/3D9Sn+tpYii+4/UxU9TFxPDzW6daLvAbMZ189
	Uwj0Nxvs//V8NAIfG0qqhRTAqAJJjTxwBGX0UTZYkJCKBxQxYKzPJyNL0UZ0M67F0BUU0gYygPS
	Un7l7ciWGBR5/ZPLRMulRG1olhBCgGnw35CLT4en6hCJWKHFA5qECtsUuwQZECKIC/TGVr2pmz/
	y/VSFwEhZSHYmmYZBg3d3n/AsNm4zNBTx1cn9RyWskePjBfW
X-Received: by 2002:a05:600c:8b22:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-49fe66d3044mr3405575e9.13.1790190718703;
        Wed, 23 Sep 2026 12:11:58 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c4cc01sm33413075e9.3.2026.09.23.12.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 09/18] selftests/bpf: Cover the tail call caller stack depth limit
Date: Wed, 23 Sep 2026 21:11:16 +0200
Message-ID: <20260923191139.2816206-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=memxor@gmail.com; h=from:subject; bh=i0ynLbSwgzfOm7o4IJSLX0RoNEADaMII0zDO9q/uV4w=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4reXD7dMUv7Xvfn+/0PMKyw/Xn994PiN4EArk8npy /ruKP826ihlYRDjYpAVU2Qp+b+PyfhE5e9A22XcMHNYmUCGMHBxCsBEdp9m+J+VdXhnFtdOuRW5 i2aUt9x+0P98w+v0l5vXzHz75YFC7tRShn+KqZt3dk4p9Jn0cVfL9ZZJBefajL8GpZXvbdhXeny 1zDseAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A tail call from a subprog only unwinds that subprog's frame, so the
verifier refuses tail calls once the frames of the callers add up to
256 bytes or more. Nothing exercised that rule. Add a pair of tests
with a caller using 240 and 256 bytes of stack respectively, the
latter expecting the "tail_calls are not allowed when call stack of
previous frames is 256 bytes" rejection.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_tailcall.c   | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall.c b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
index b4acce60fb9b..51687da97225 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
@@ -28,4 +28,61 @@ __naked void invalid_map_for_tail_call(void)
 	: __clobber_all);
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+__used __naked
+static int subprog_tail_call(void)
+{
+	asm volatile ("			\
+	r2 = %[jmp_table] ll;		\
+	r3 = 0;				\
+	call %[bpf_tail_call];		\
+	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(jmp_table)
+	: __clobber_all);
+}
+
+/*
+ * A tail call unwinds only the frame of the subprog doing it, so the
+ * frames of its callers stay on the stack. With up to 33 tail calls in
+ * a chain the verifier caps the stack those frames may add up to at
+ * 256 bytes.
+ */
+SEC("tc")
+__description("tail call from subprog with 240 bytes of caller stack")
+__success
+__naked void tail_call_caller_stack_ok(void)
+{
+	asm volatile ("			\
+	r2 = 42;			\
+	*(u64 *)(r10 - 240) = r2;	\
+	call subprog_tail_call;		\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("tail call from subprog with 256 bytes of caller stack")
+__failure
+__msg("tail_calls are not allowed when call stack of previous frames is 256 bytes. Too large")
+__naked void tail_call_caller_stack_too_large(void)
+{
+	asm volatile ("			\
+	r2 = 42;			\
+	*(u64 *)(r10 - 256) = r2;	\
+	call subprog_tail_call;		\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

