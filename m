Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470840;
	b=G4yFgsZEBa4e48kLYJr95S5mmXWhuPNq3GxtFLF3fvsmabC2zRqhbEJgDsUega36y7Jf
	 CQqvFcPcDOGRb1JriMrxgAPTGCxjbomeirLaIFZHxZJAgzBzh7OvQOdGfwy+N8w05oD4A
	 YsDAPPvrJ/fVpFqnfu4RS5mGqP/oQOospmw6U56ghEfVOBkU2x3o+WN+0RZiARWUnDkDy
	 Iz7kzlMRyTxRrisjItDznYzWBkefiVPdtoCi+CGJ3qxGzudiprvoRWoVThuAuQkbxOGsh
	 vQO5u7zfLCkBHEQCp3LZ5CvEVIWkh4lhCe72f5GsLIWSH1mFOfwIjyujFrSEDZzeD+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bT0iHq5lkYDD7SZbBCiIQ3XRXWAC4wwnO8nRkXHLxrk=;
	b=siguU0tOjQKl6omfvhnLdmt0xJgXV6JJ9VtMIVqNZOZP5t1KSJtBHZbtrIV71kLZFQKu
	 z8H4iFvTMU5J4mX7B+kl2Qp9Wv6Gt2x6qzbMyyyY+kPb4YFcfCsVdkbG67YBD8KrfT6S7
	 zWxK6EvPPFQhBLHfP5sIAm41jfwo62f+gXVRpClhGLePAa21YfCNIKpvPyOKOL4ExT1KX
	 GnF5Mf2aimTg4/yl5+sT4Oq7O23wHi5ATLZd25RM0q/3hYADiXU1g6Ru1Hi7fCYnh6muD
	 1xEIJf/vRk+c8zAWfKTzTva8J3iSPDY7Yez4I1C23Ohi+FnIuCXtw65nKvua8mTmqMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="s/bjWgsW";
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB98606A31C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEB98606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s/bjWgsW
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-881269371acso141369b3a.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 21:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792470839; x=1793075639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bT0iHq5lkYDD7SZbBCiIQ3XRXWAC4wwnO8nRkXHLxrk=;
        b=s/bjWgsWKM7RG6TxFIbk6TGC3/SmOw94iCjnFiAGpBQ8vNuQQQyQeX5eIH+gU5mr8k
         b+x0Ot0jthYCql7d0mp3ThE7Fcv1hDBJG/HarzroGQWmVeVmLfmAPxwg8NHN3zHoWwlc
         eWBFGzK52UWQi8cDTD+nfJjjWoISBsISvkSBH174kgMBoQ+J5pzdehdDewRuH3c8MZco
         P44KbM1iiL1Lgwbb2bMZKyrcIwgIP4z7IqYJDP9kLTAiPpM8oiJF6Aectclyd6rhfwCj
         RuumCJkvHgtEQTSrkTaq7SaGq5KcBJZSbA6P/2nmvdf18I+qa6UKRuoU3M63GtsfU7B5
         ezFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792470839; x=1793075639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bT0iHq5lkYDD7SZbBCiIQ3XRXWAC4wwnO8nRkXHLxrk=;
        b=rxeaO/LuNgVfeK4K1ajhnfhuLW4jiQqF/u48EVRwaDi21L/4tg/Hn0O+s6fD8VV/sz
         ABu8XF+4vOzejJNdAZwSqUi5122RDkNW5vtxbY9A4BGhCZ4QlqgDoAKhiOeMpdp6+E9Q
         m5YFzi/DU/tjciWJ+qL10m+jUJe+ejyYxCCJ/AqdEtR0xyxPiwoRseyVAROu6WYIALDC
         TbXAtjJc/BcEA9jwC00MWBx9abM8uBn6C6OhDFrntyLiQjfdzA2aPmKmDwnHxO2VgUfQ
         lAg7uxhaoNH06rsrHJy1ZJqPLcH5WXS5FPmmvNrQWMVbxFQZPOgRV2kp0eA2nhecSBUv
         j4NA==
X-Gm-Message-State: AFq9FYJqQ+XzcylkHhnSEMySsBAwE7fltkJ8QbAOnaklIvyOm4emsdzX
	iMeSzXNGeRzfG6RyorKLDR4jLJpRIQKe5GkRZSBk7rbf5eyFsbYTmpXdPBsdBg==
X-Gm-Gg: AYBFou2pDJwp66npZGNt87rUai4KVaqs2vSGLOBmhcPY0G/1piKNvVSKHrzVNJlGUIv
	N747mVSEl9DOQMA939hAiVYD/0AoMMPEJJY2pZQvpTNRab2lKpumpenRDoCxiWmspRtyMcmEztI
	9CcuVkQhcuVm7xoAYbtf35SiFzVEu5w70Rgy8Nhu0WCWFaUjkfq0ITr6HYHMzgUTBbz28Mc88a5
	N9vkYQ8atAa+U46pyoZo7ILjLGuFf0MIMfcZtqh8CEQlCqERbxkcHGBHMorOiehlvHUk7sy8ctK
	AyjsA8GYyBYVvAP1N6F2FQM/P7cjKwBkwuYPrDKsnLNbuWH8o0NLeRBVD3jr+cAwbi0FvMDx1gH
	0Ba6YtBsD+OdaIKjYrrQv2zc3aR/xkrNok//r7sh3FWJUhuR46Na5y//hocYOeR9t0AAyQnLISz
	g5seTMuys2Rzm0wYa+JWqTDianT7oCI1F2hiITd+Bw2OaHNoOe0nN/eUIAnR8VqlCzt7lBQsvGC
	2FjlQZ8QjaAE0/P1SxvNApPzJPkOhb3+BFm8CYZYS8nyB4Ty9OkiROeOQwMf6WdBJGBuGXADXtw
	S3CXo1Wgk5Q2XFpaja2ymxNW+/Ma8Rqv+2OpZIDY+Y8f
X-Received: by 2002:a05:6a21:6b18:b0:3de:2fbc:c391 with SMTP id adf61e73a8af0-3e26f932ce1mr761133637.7.1792470838841;
        Mon, 19 Oct 2026 21:33:58 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a15c57sm4633187a12.25.2026.10.19.21.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 21:33:58 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v3 bpf-next 6/6] selftests/bpf: Test unwinding from R0:R2 subprog
Date: Tue, 20 Oct 2026 04:33:19 +0000
Message-ID: <20261020043319.3031996-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
References: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
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

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Global subprograms returning a 16-byte scalar use R0:R2. The
verifier therefore checks both registers at every ordinary and unwind
exit.

LLVM lowers a resume to "r0 = 0; unwind_exit". If cleanup code does not
happen to initialize R2, the verifier rejects the unwind path with:

  R2 !read_ok

Extend unwind_cxx with a global unsigned __int128-returning subprogram
whose cleanup only releases its RCU read lock. Load it separately so
the existing cases continue to run and the failure is attributed to
this case. Check both the normal aggregate return and caught exception.
The test passes once LLVM defines R2 before emitting unwind_exit.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/unwind_cxx.c     | 24 ++++++++++++-
 .../selftests/bpf/progs/unwind_cxx.cpp        | 35 +++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c b/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
index 36e52766022c..23e9c7566563 100644
--- a/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
+++ b/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
@@ -42,7 +42,8 @@ void test_unwind_cxx(void)
 {
 	const char *file = "./unwind_cxx.bpf.o";
 	struct bpf_object *obj;
-	int err;
+	struct bpf_program *prog;
+	int err = -EINVAL;
 
 	if (access(file, R_OK)) {
 		printf("%s:SKIP:gcc doesn't build %s\n", __func__, file);
@@ -57,6 +58,10 @@ void test_unwind_cxx(void)
 	obj = bpf_object__open_file(file, NULL);
 	if (!ASSERT_OK_PTR(obj, "open"))
 		return;
+	prog = bpf_object__find_program_by_name(obj, "catches_aggregate");
+	if (!ASSERT_OK_PTR(prog, "catches_aggregate"))
+		goto out;
+	bpf_program__set_autoload(prog, false);
 	err = bpf_object__load(obj);
 	if (err == -ENOTSUPP) {
 		printf("%s:SKIP:JIT does not support unwinding\n", __func__);
@@ -73,4 +78,21 @@ void test_unwind_cxx(void)
 	run(obj, "does_not_catch", 200, 0, 12);
 out:
 	bpf_object__close(obj);
+	if (err)
+		return;
+
+	if (!test__start_subtest("aggregate_return"))
+		return;
+	obj = bpf_object__open_file(file, NULL);
+	if (!ASSERT_OK_PTR(obj, "open_aggregate"))
+		return;
+	bpf_object__for_each_program(prog, obj)
+		bpf_program__set_autoload(prog,
+					 strcmp(bpf_program__name(prog), "catches_aggregate") == 0);
+	if (!ASSERT_OK(bpf_object__load(obj), "load_aggregate"))
+		goto out_aggregate;
+	run(obj, "catches_aggregate", 64, 71, 0);
+	run(obj, "catches_aggregate", 200, 42, 0);
+out_aggregate:
+	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/progs/unwind_cxx.cpp b/tools/testing/selftests/bpf/progs/unwind_cxx.cpp
index d46ee41fef85..3a113ffea29c 100644
--- a/tools/testing/selftests/bpf/progs/unwind_cxx.cpp
+++ b/tools/testing/selftests/bpf/progs/unwind_cxx.cpp
@@ -67,6 +67,17 @@ struct rcu_guard {
 	}
 };
 
+struct plain_rcu_guard {
+	__always_inline plain_rcu_guard()
+	{
+		bpf_rcu_read_lock();
+	}
+	__always_inline ~plain_rcu_guard()
+	{
+		bpf_rcu_read_unlock();
+	}
+};
+
 struct preempt_guard {
 	__always_inline preempt_guard()
 	{
@@ -95,6 +106,18 @@ static __noinline int middle(int len)
 	return inner(len) + 1;
 }
 
+using u128 = unsigned __int128;
+
+/* Global subprogs returning 16 bytes use R0:R2, including unwind exits. */
+extern "C" __noinline u128 aggregate_return(int len)
+{
+	plain_rcu_guard guard;
+
+	if (len > 100)
+		throw 1;
+	return (static_cast<u128>(len) << 64) | 7;
+}
+
 extern "C" SEC("tc") int catches(struct __sk_buff *skb)
 {
 	try {
@@ -110,6 +133,18 @@ extern "C" SEC("tc") int does_not_catch(struct __sk_buff *skb)
 	return middle(skb->len);
 }
 
+extern "C" SEC("tc") int catches_aggregate(struct __sk_buff *skb)
+{
+	try {
+		u128 value = aggregate_return(skb->len);
+
+		return static_cast<unsigned long>(value) +
+		       static_cast<unsigned long>(value >> 64);
+	} catch (...) {
+		return 42;
+	}
+}
+
 #endif
 
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

