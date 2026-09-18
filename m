Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6753D7D9F
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709358; cv=none; b=qoqeb0wi9Z6lrWbVToGKY5LAghuBTDQOHOcLPe038pEbp3mTY+7fgJoqn+Yb+8UKkJLq0Tf9MruHO3iZ+ZorRdKNzoBOSau29hqecAZ0Whoq1C8E6qqa0m7uCeeydGjl0OSZeX1inydNCvrv9mA6Mqd7RtXHY9z9U27MZqGZO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709358; c=relaxed/simple;
	bh=7WjhMLhW5LCnvhaoAOO0PBcCy4lMpB9yoQQzoz3Glf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FanynTsxxOHcFJfUFF4oN3RVFqOlpnqeYCoNUQy70tHfK3a58AGITSRTi924Z0ebHcjVocLQX3ZUVfgj6Ssl5ds6yhouR7rBqlo4vZ7q7C4KGgmBEJ2+A1FhK+zlbNJhVRGdfiwABXXBsuUYaFHiMv89/1P5yuNhq11gxo0zV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Znj/Apy0; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Znj/Apy0"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-4858866f7ffso65434f8f.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789709354; x=1790314154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yEEv7ukouBCQheXMGFNV8cgbVig3HJqFjui1JA7es2U=;
        b=Znj/Apy0oLj55Pe7lww2LaZ+4avAUuo90r2q/q+wkG9eauOZcFWJP91kjunj1j2QyN
         cLI0RmhrmN8is4WhbU9nJmipDSBA6oTYNRetIhTNzpLBqgGhIZk9eGKCbkB+/V95Atgw
         IWwQsiBG76e1B5+Yi0O2PC0SQKmKzlZUw3Rjgk17K6acukv2Ko81alcB+Me8HyHv2kCW
         2oCzkjYUktFqAuoQYmQnslj+FKzOiH1OSApeWtLe+n4rieAjF48DMWdFNnPVoS+IJNz+
         4KrzzMLgZ/3pmCWRbeqyuPCnt3I2uVIxwcbWlvq2AKGxhc7gdJc9kVsDb2jpWDDI4PYh
         DWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789709354; x=1790314154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yEEv7ukouBCQheXMGFNV8cgbVig3HJqFjui1JA7es2U=;
        b=sXOAzYeFlg6mnglw7osgs8EUqlcbVRM05ohaapkkurtEQUhyB2yaDfaGxNUFf5Vlu9
         TfUqOwpQwqvzB/75KSwCT13oVMCAPk4AlF4XGHGtl6sq3Kk+BWxhHvhFOmQY96O/ukhC
         fvWPGy3P5A1l3TRV0fi4hdlk4973I7Sb6sgrDri7+fYNeXvmiUidi/cq4proUh+azdpg
         /ikRNtl0CI1OQXr1E6XuLpnEDTnQXEJveywuNeMGN0zvQ+/8uIC2u57r4i0rWI2Sbt0V
         1TynmODEaJ6aK+fE/QJH1H8BDxCUUxEVQg/4TQAgITT16ghL3b3rNqPiMX4F0CLUCOL+
         Psww==
X-Gm-Message-State: AFuF++mdICOV59K1v/HP0Q3qLuFspAAE0Ygof+4XuRrkF3uUUMyVTG35
	LKW569VQUKSWV0sRixvN4tDEAJg5ttstRsKW5YWDI123I2AqNcF1bH81V0k6aMVK
X-Gm-Gg: AYBFou1pZ1z5YTIAFeikxiNJS38jKpjCgkkyNFZ9R6Ou2GHKywwQnFBzACXqN2nulCY
	H6BN5ZEVDzLPQP4qX2VM/by7V2zhJ3Wia+/QxGJwUzlwRc2ttq+AYJd28fiRvNs/IIF+24RDV+X
	xLuZrklASpgea0mYXwcRIcqwUTijvHRz/CJzIY3wwR6CJmYeOOkXOCvaji8qGbcTIv23jPKZfYZ
	OyWUELeHFWH/DVm2ttSifiEfhDpgV4sK5f32xT8FHrrsd00CDC9/aI42ZiV3c4EP00jPbaOdx3R
	+BS0lUL7l9GjWZ5rSR93qYncwTEiVZj4RnY2MkeFid0eLj4FzUwDMY1zMPdFhqEYBk/1QnZmXqK
	rQJlXvo5DXEOtzuZvsyzSIsBXKsi6VEEZFecSr+1+byFTo7AYqU2yHEFugSAojPL3MkF5NuNyvN
	GzOYgX00j1D6VS7cD/iztKcaM5cqsAHAv/5ADxrQHScX6HIprC7Jymvye1ZKo5D8cB6vye8TaLI
	sFdv1GFHKSnVUScjv6m2M0WchBwF/Y6bm8j1vOfh2qqlZp0FFAwIgRmCH6ysw0lFjF+PXYHpTbP
	9yIjrjGhZoKxlNriJRe2GDwB9tEtZfBEshoY6A==
X-Received: by 2002:a05:6000:4b0f:b0:487:452:dbd3 with SMTP id ffacd0b85a97d-4871e363b31mr1355635f8f.47.1789709354444;
        Thu, 17 Sep 2026 22:29:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871feb5645sm1098126f8f.4.2026.09.17.22.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:29:14 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 4/8] selftests/bpf: Cover helper memory access permissions
Date: Fri, 18 Sep 2026 07:28:58 +0200
Message-ID: <20260918052906.12226-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918052906.12226-1-memxor@gmail.com>
References: <20260918052906.12226-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4121; i=memxor@gmail.com; h=from:subject; bh=e6dFVBjscNtgx4KHvWR1TgJtx/PI4OyPW2Bkw+z78a0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvN6Vess2pnRP5dELw74uml3d/reHYUq1zava6nRPoh6 /PNN6xjOkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRmCsM/51+pU7qPlujtGaB 5qrHj54aPnd4JTn3pE+T0hGR5D6u6RIM/wuUPGbopM5+qPbdc4bCjUPr1i79wsztuCG08dcvm7m nQ5gB
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

Check that fixed-size and sized helper in/out buffers require both read
and write permission. Cover bpf_check_mtu() and bpf_fib_lookup(), including
read/write buffers as positive controls.

Keep rejecting read-only buffers for bpf_check_mtu(), and verify that a
write-only map remains a valid destination for bpf_get_current_comm(),
whose output is annotated MEM_UNINIT.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../progs/verifier_helper_access_var_len.c    | 41 ++++++++++
 .../selftests/bpf/progs/verifier_mtu.c        | 75 +++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
index d1452ef6f2f9..6d2c6aec129f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
@@ -822,4 +822,45 @@ __naked void bytes_no_leak_init_memory(void)
 	: __clobber_all);
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_WRONLY_PROG);
+	__type(key, __u32);
+	__type(value, struct bpf_fib_lookup);
+} map_fib_wo SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct bpf_fib_lookup);
+} map_fib_rw SEC(".maps");
+
+SEC("tc")
+__failure __msg("read from map forbidden")
+int writeonly_sized_input(struct __sk_buff *ctx)
+{
+	struct bpf_fib_lookup *params;
+	__u32 key = 0;
+
+	params = bpf_map_lookup_elem(&map_fib_wo, &key);
+	if (params)
+		bpf_fib_lookup(ctx, params, sizeof(*params), 0);
+	return 0;
+}
+
+SEC("tc")
+__success
+int readwrite_sized_input(struct __sk_buff *ctx)
+{
+	struct bpf_fib_lookup *params;
+	__u32 key = 0;
+
+	params = bpf_map_lookup_elem(&map_fib_rw, &key);
+	if (params)
+		bpf_fib_lookup(ctx, params, sizeof(*params), 0);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_mtu.c b/tools/testing/selftests/bpf/progs/verifier_mtu.c
index 256956ea1ac5..af89ce3d30f7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_mtu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_mtu.c
@@ -17,4 +17,79 @@ int tc_uninit_mtu(struct __sk_buff *ctx)
 	return TCX_PASS;
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_WRONLY_PROG);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_mtu_wo SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_mtu_rw SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_RDONLY_PROG);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_mtu_ro SEC(".maps");
+
+SEC("tc/ingress")
+__failure __msg("read from map forbidden")
+int tc_writeonly_mtu(struct __sk_buff *ctx)
+{
+	__u32 key = 0;
+	__u32 *mtu;
+
+	mtu = bpf_map_lookup_elem(&map_mtu_wo, &key);
+	if (mtu)
+		bpf_check_mtu(ctx, 0, mtu, 0, 0);
+	return TCX_PASS;
+}
+
+SEC("tc/ingress")
+__success
+int tc_readwrite_mtu(struct __sk_buff *ctx)
+{
+	__u32 key = 0;
+	__u32 *mtu;
+
+	mtu = bpf_map_lookup_elem(&map_mtu_rw, &key);
+	if (mtu)
+		bpf_check_mtu(ctx, 0, mtu, 0, 0);
+	return TCX_PASS;
+}
+
+SEC("tc/ingress")
+__failure __msg("write into map forbidden")
+int tc_readonly_mtu(struct __sk_buff *ctx)
+{
+	__u32 key = 0;
+	__u32 *mtu;
+
+	mtu = bpf_map_lookup_elem(&map_mtu_ro, &key);
+	if (mtu)
+		bpf_check_mtu(ctx, 0, mtu, 0, 0);
+	return TCX_PASS;
+}
+
+SEC("tc/ingress")
+__success
+int tc_writeonly_output(struct __sk_buff *ctx)
+{
+	__u32 key = 0;
+	__u32 *out;
+
+	out = bpf_map_lookup_elem(&map_mtu_wo, &key);
+	if (out)
+		bpf_get_current_comm(out, sizeof(*out));
+	return TCX_PASS;
+}
+
 char LICENSE[] SEC("license") = "GPL";
-- 
2.53.0

