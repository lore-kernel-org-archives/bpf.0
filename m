Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C44A92EA
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267530; cv=none; b=LRkNkWlkigcWiywmT3286SjKIuEtHVMK9i8U5F1uVklW4WeEKzF7uFBiGrsxop8EP33cemqW4/LccB/fanU30fG1Y4OpNcQS8MQtUIgpraHx2aDxAn/a6I2UmDG3P2UKWNgCUlnWo+p7DxmjK8HxBvVIMk4SJIX+Lj0nHKDii0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267530; c=relaxed/simple;
	bh=z7qBVG8nW8vc/+QcAecaLQvvM1sq0vQBOLcPe4wRmqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gY4gkip9HPr2SD9CvU3j037xYqB6xBThi3k+VLwMnicMBBtz85ShMq7moji3r3gOszr7pPVXoLNal2m/Sjg+gkaiJjE1i00L7lttrT5VPs/tUqcsVzxFUaAccUFZmnDBK5uqUJrtyvLtVuEa8ZnbUs4AS9RDDX9mw93fsjX4ORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oaLyERsY; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaLyERsY"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bbf77e8so89305e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267527; x=1790872327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eii86tLen5tcd0oZnA+P+QRUTYVrSjfkyoMDGr0y1e8=;
        b=oaLyERsYLXHMyS4a9xvhEeyciJv1C03A7xdOkwl0Ang+FNcRFG5GG55pqpG0gTi4oA
         T2DQe4cjN0xHRxzCl2a/6NN+PqsQIwGZ+4dQrd81tgwX9RmGxnUcUUvPHy4mjSmRsJQF
         3ceS93bOUoa125lpObNdtuNsjg2rDL0HgEJ2ixFjbaYgy4meLVjPqOkkH/Ue2Y3W6aOe
         kgyQuSz1vutWvTHRGo4UlOsj180JhRgBCgg2zime9aO9hBQT+1tGYCC233DvF9XeWoG8
         Z2DTonaeeCnw8Iqd+I6DTwLQWIAbnGAR6fiLrOgDLxcBvuWqrZge8lYin9qOV/EsGmXz
         YEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267527; x=1790872327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eii86tLen5tcd0oZnA+P+QRUTYVrSjfkyoMDGr0y1e8=;
        b=Ja5FNuL3G7Ns/fDtKsneJtmqmDfK6BoP+UtLKfGPABoGOXpPbucE4AHmq6XHUjNheO
         vQvcZgf8N9gKdVrhpyE1lBpKWZ9OXBWRPaou+z6VLgnkr8vyobzWeyhc65jhhDathoto
         Ufwlu4hcQAbDWHezjLz52AP4CKdGojnRuR0GaHjWkyQTWqtViFGrjNjms+IS805IX9XE
         KAQBmdXUNSqFjUF4XmHZa7TORVZUQYOWOH83Gpq53zzOiDAiydqkjsl5V/GlB6MP0XB9
         akiQEAjxxI0m/Gfgn37mGkOTc6s4+MY3ybdKMRc85RkVY0xbqmuXLgNi9MYskT1CZlAc
         5Gsg==
X-Gm-Message-State: AFuF++lnGl7nXaM2e7/Mea6JjkQV/qXQlN4V+UMLAqb+bbk+elTc4aQ2
	9/kQ2swt5YTlwEZr8Dk5XDhnPTRf/TH+dRTamdfUJ+sN67lb6U2hnjpnyneep9wB
X-Gm-Gg: AYBFou3IuGwRF2wJZtAma4j5WVxcHGMgOaagVD1OZ1PVBBHLbx5B1sSA1GFpBLvGCyB
	6jzcqEsNRt6QITZG93JiRIM8/OyKe/KgLgVuNLUzYUB7Oy9+a6WzOLQq3x22aTdxlfUexhOUDdK
	DOLkwI/jTSQnQCqgjQw+WCfG+sm+SYW3YWqLWyvyy0EhZjrqWPAnA+l83bb1kVUrktstxTeh0AZ
	iAz7B7DFALFzZV4zkeJiIGeT2hAUFaixABy722tXeo5JCZD32mQ21hs7p5KcQ7xY+LfOKcry9iv
	k8CkdBe+A1keCLP2qdwGmtAnKf2lUTbg8cy2+i12vkcUB0Z8s6tcBCZcP5PnP54pMPZ5fyLatg3
	3mA8lKUTflisZeM5F1ZVA/c2Hh0nT90YKoONLN2MojqlmGdWYbAO7Nm4P0DN3W8nEBulDJW9SDo
	fqP4awoI+/X76vw0kDtgDCxO/bAjOncAGWK0/arVXAQrC8zRfo0MDfC5YMHTg9gjPAAcH8eNPOb
	OkhyKkMolBXdiD34QAlodUZTIAw/f2jDId+aj598xQHSQBunKfP0crVdc+ZO4ZsCsp+1UCxkEpA
	N1xLDAtQtxe8NRzClhFzOlcTk1cvnY25oVukM2RKMeppoq/UyugPYfPdAuU=
X-Received: by 2002:a05:600c:3b1b:b0:49f:e4d4:dd70 with SMTP id 5b1f17b1804b1-49fe6705bd7mr52797905e9.31.1790267526547;
        Thu, 24 Sep 2026 09:32:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee911e9bsm303125e9.1.2026.09.24.09.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:32:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 11/18] selftests/bpf: Check liveness merge of masks with different widths
Date: Thu, 24 Sep 2026 18:31:25 +0200
Message-ID: <20260924163144.1945455-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924163144.1945455-1-memxor@gmail.com>
References: <20260924163144.1945455-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907; i=memxor@gmail.com; h=from:subject; bh=z7qBVG8nW8vc/+QcAecaLQvvM1sq0vQBOLcPe4wRmqA=; b=kA0DAAoWRy03e2NUL4MByyZiAGq1TeyhsLpzpEOc443M/ATiyYf88SUKUki/MiY/WlO9033Fk Ih1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmq1TewACgkQRy03e2NUL4M12AEAzwp6 4QEMSeF0sdV1WD+gCZm4q5a/gHOHVDGGKM5mGJkBAKmvlPbtQPlQBl7mo9XttIo5+c15E7cGo92 UGwCkMXEI
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

