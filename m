Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F8B43BDAA
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238393; cv=none; b=FZNall5AIk0YKMmlkpjc6j7jOlWhF0QSFznmENtdcVuh/PSqNpSCkEFdQoYr2LkqCo0XhvCE0TbmzNrsAlbMhHBlr+oTeWMlTSvSiR35z5RlopjA9C15ng5bkzceWILukb71dkBuLpPFXZHlnBuCbIdSBWMcec3ItsVMfaA4zrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238393; c=relaxed/simple;
	bh=z7qBVG8nW8vc/+QcAecaLQvvM1sq0vQBOLcPe4wRmqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgkOiOvc5O1BP16feahErGKxPEFAPbZNA4Ejenp4sIanrkT18HuwUFZtcXd68hyxKzm1zKLI/vX0I9IsrDAkfvncgZbQbfzqWuJAl0z3ph4+yf+EF2LwxeuT6KveioqNh4ulpmclsvAoo8ihQo0pfgBJYla04slUnV8OCATc3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZARnxA9m; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZARnxA9m"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bbf77e8so2795445e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238389; x=1790843189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eii86tLen5tcd0oZnA+P+QRUTYVrSjfkyoMDGr0y1e8=;
        b=ZARnxA9mit/YYnYim26MUD0ZaxiGoBNvd4aEmbmf2AjjlB9xkRWhr5joWMjlrY75AT
         pUxY660VBopzkIC4p/NaMOzxgPRONlnkWMvXmL3JowPGtPEZCDrtw6asmGjT8Q3450/k
         1OEdrZh9PicQHUWkoZmYBtBi4MkcefOCSBPwoxXqPWWjmwjGMKlgIkMGThAxKGbHZU4q
         UBFhJU5dv7zM+cx/p1S7ajS3r2c4Bg6XrsY/2HNfg5KhBFyrgd6cUjAJVwqF0ACvMxYH
         Owwmo+VVz9Umft+suSzLmztZKzVVPTfnP45cr06ES543peSZj+BMEzkIVGaSu92SyESm
         LLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238389; x=1790843189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eii86tLen5tcd0oZnA+P+QRUTYVrSjfkyoMDGr0y1e8=;
        b=OestVlJdweOGkJho3JiiDy9bj+tTMeiMc0qtnDBHoteIjqakLNiAdOdaQwmJLMF9Fn
         oRjrb4UkJ9HG/t3lH037EowkqMSqC+d9TywlC2JIlVr8Q+ojmMtzgSxyWvM+6/DXFx8E
         x01E19wrm45gFSJtoZN/4ksGg5qlCGFTjRRgeXTAljhH4KYXMd4rEG7MKKjlgLKVejF4
         k3POJyGrltma61FMK47tnKBbvYbYtYfjcpuiRjAUIerIt4wHaoeBD508eso/z5oj32Kb
         ZIQk0f+NP5sIPyae7uiM3luWl0vO14/B/q4o5Uz/MlMHsGPk0/vvYlsrv6bArPxF3gPW
         soDw==
X-Gm-Message-State: AFuF++mrm+hnjMTmv0iXP/PhwWE1XMN4gJWZMVC4j+kSUMq18QWy7v83
	QkUQ58iS/h8wn8lEE/3Y1HtYWcbKByr0wYn6JUQhW//tC2NiDiYLUzBxV4NQrivi
X-Gm-Gg: AYBFou31+tXLwTKvw332+IXy4AtGP0aBWOvK7OaYtfaLb32UXHr7ombOh/RYBO9KO3i
	vR7tw5nspDjDtb0lC5HhiAtW4lRjJBWYO+XWO5w7KvCkHqNNXS5qIB2eRrPj3HnGi45qVQ+uN7L
	YC/ikpuKiolQGtplMGBu1dyd9vTFgtBspAfV/K5k+XOCMufN8nyvJ73Gw8kMVKN61zwzn0xhsEx
	wIPVkT8ycnzxlZYEawKHVc/i7qt5lr4ooJqTDMxHQ2gEGZ+qHUJ4gD9fy3v1fxMWg35P+xjn/v1
	S/EDezzKGLedenQAvTUTfFImwfOqBhu79ZLq+g+0t6ebsNvjEvntx10E6AiF0xZlGaK9kucvm8Y
	sW2cThkXwqsc2SK02YSgj1ml44IEQo8AYAm7UE0ALR/2WE/DKmr3AJv7ETaD5zq3oJUP0utxeDg
	/XZpqpIwwIjT+x5VkPNpxXLYt3ehY1pgjTUGvOaGQW2b/1uMK+PSjjn949jVvWFlASzlkdJftTq
	46SXyPckBQxtIRVjGEITajZRAIP7TLra3I7DeEzwP4+7kDjBVxBQK43ui3LBk/uDTFps8hKgBEc
	O4ca6uskswuUIgFmBBb2R2/QIswacZmXOyY5YNzkXpGaYfQs
X-Received: by 2002:a05:600c:1f95:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-49fe66f1aa8mr24709955e9.19.1790238389109;
        Thu, 24 Sep 2026 01:26:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877a2d5sm12553268f8f.27.2026.09.24.01.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 11/18] selftests/bpf: Check liveness merge of masks with different widths
Date: Thu, 24 Sep 2026 10:25:47 +0200
Message-ID: <20260924082607.2695649-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924082607.2695649-1-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907; i=memxor@gmail.com; h=from:subject; bh=z7qBVG8nW8vc/+QcAecaLQvvM1sq0vQBOLcPe4wRmqA=; b=kA0DAAoWRy03e2NUL4MByyZiAGq03mShsLpzpEOc443M/ATiyYf88SUKUki/MiY/WlO9033Fk Ih1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmq03mQACgkQRy03e2NUL4OdvQEAly+X ruQ0DZHchLhuxIYncVg9sUJomzX4vD4RqRZ+b94A/0AdgbRv/UoRfdguk9I3i9EgaKCOu/b3OZd WConrjAsD
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The liveness masks of a function instance are as wide as the deepest
half-slot the instance was seen to access. When the same instance is
analyzed again through another call site, the new pass may have settled
on a different width, and merge_instances() has to widen the original
before combining the two. Add a test where the first pass of a callee
reads through a pointer 248 bytes into the main frame and the second
one through a pointer of unknown offset, which reads the whole frame,
and check that the merged result keeps the whole-frame read. The
precise read stays within the first mask word on 64-bit, so the
whole-frame pass is wider under every stack budget and the merge has
to widen the masks; a deeper read would need two words already, which
is all a 512-byte whole-frame read needs on 64-bit, and the widening
would go untested there.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index f8758eb62dac..c3b08089fef1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2861,3 +2861,54 @@ __naked void narrow_store_defines_nothing(void)
 	"exit;"
 	::: __clobber_all);
 }
+
+/*
+ * The same callee instance is analyzed twice: the call sites are visited in
+ * postorder, so the second one goes first with a precise pointer 248 bytes
+ * into the main frame, and the first one then passes a pointer of unknown
+ * offset, which reads the whole frame. The precise pass stays within the
+ * first word of the masks on 64-bit, so the whole-frame pass is wider under
+ * every stack budget and merging the second into the first has to widen the
+ * masks while keeping the whole-frame read.
+ */
+SEC("socket")
+__log_level(2)
+__msg("stack use/def subprog#{{[0-9]+}} merge_read_all_callee (d2,cs{{[0-9]+}}):")
+__msg("(79) r0 = *(u64 *)(r1 +0){{.*}}; use: fp0-8..-512")
+__naked void merge_keeps_whole_frame_read(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"*(u64 *)(r10 - 248) = r1;"
+	"call %[bpf_get_prandom_u32];"
+	"r0 &= 8;"
+	"r1 = r10;"
+	"r1 += -16;"
+	"r1 += r0;"
+	"call merge_read_all_mid;"
+	"r1 = r10;"
+	"r1 += -248;"
+	"call merge_read_all_mid;"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+static __used __naked void merge_read_all_mid(void)
+{
+	asm volatile (
+	"call merge_read_all_callee;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void merge_read_all_callee(void)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r1 + 0);"
+	"exit;"
+	::: __clobber_all);
+}
-- 
2.53.0

