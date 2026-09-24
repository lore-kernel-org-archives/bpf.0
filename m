Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A794A6CE4
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269084; cv=none; b=KY3SO8n4DvEHjW8Z8UNfsmOxXvNA8R7q2b684QGK8/YENuWDj44Li2O4oBSZaJqzB67YEoIcZ5NGki65Bl/QMansD/t4Ke+PDow+CqYJpnklyx/omvNlXdAOSU+3x0/4WxF462eXeNbql2TlCncR7iTnwtl88vVjhvnWq0pRqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269084; c=relaxed/simple;
	bh=z7qBVG8nW8vc/+QcAecaLQvvM1sq0vQBOLcPe4wRmqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoM9UoTWxHH8oBbZwhzVOlRD8UIOe7zNPerO8Yp75fKJwCMHKQG/VzJ/vvtUuZTnRAlhe3s8GZEY99JjFjJ9pAHMNOrVzATMOf+LlscJwb8LSwLmgrrbJ8S5jxr6GB/kupvUBUtnb3ZkuNGntxu1yf5E6njtsPhumoDxhX9fstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7os+mG5; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7os+mG5"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-485850cf4deso10710f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269081; x=1790873881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eii86tLen5tcd0oZnA+P+QRUTYVrSjfkyoMDGr0y1e8=;
        b=Q7os+mG5CyFXGKMTg8jBSmEhtFRJsRaYkCFrRJGURfplu4pQdjJxa6hyNOCflgh9w4
         gSjmbnreMi1J6MH4nQIKebWuqmg2Qkzktem1NX5A1oNg+3iETIUGApoqb6dnGb6H/9cX
         fLDxKzUYkpAS4pjcZDszR9Mscc5DftvwFlgR/Ejt+BUEvTbwKWToQAxowk5F6pcv7OWy
         VmB03DwtNXjzv9/+e7uAgf/V6eLcVVEkYyMeGFR6+AlAE35OBaBcVlIXtkTPc0MMWpDf
         21gxOeNzFgAkYLBule34/uJxercqIkQwCtnmGAAPJTk+8Q4iVg5EVRd1RCg3KP8yOQVt
         BQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269081; x=1790873881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eii86tLen5tcd0oZnA+P+QRUTYVrSjfkyoMDGr0y1e8=;
        b=vIiPMlOmHd6uOaxwiXUJwaR7g/tIbnw6KNE2roLZeiXi7SKul06RQMkwUxpibjfI7H
         bsz2M73zdHqFzgoXbwabXI46Zw6khopD3hL6yBdThwimLaK3PAIRlyBJ4bkWptu4TKEg
         BL9Xoi6eLmhrhWuaCQM9sJgdz3Cv6BOJYCFmoMKW6bRikoYQsb6Brv9VrJNQDVo2ZZxo
         mAgOzZ8GcWKqUJ2sKMZinltIV9tDKXZZcewK1HC6np/PO2Btmus2djm6rotylMChDvlA
         9tT/16AKup0y9GRM8yvGidQu9INLgL1kgeow7UDEgpc0qbUkVl8d9aJPK1DE2vBJmVxk
         ftpA==
X-Gm-Message-State: AFuF++lyqjdvT8XR+/Rcjh49p9irPVAxXF/gy51/y4wom5qvN9qSMehA
	WI/FIOPvoNMet5Nqjj3l9fLhY+aTNxZsRsWu1OUaYNlAqq6WvDF0Q0Y+57P6L5BA
X-Gm-Gg: AYBFou2Dsnnwu0Zgy6XVlc0pDHGzQdvSr4vEkvLvT7T1AMpIPWoCmiBfpW0sFsKXqn7
	mZLF39gSt7vTtnKlv8Yw72NMzOlz5c8RJDXm2CsN7tE2iZKZW5VSOil0IJR//9w/BGBZ6HHxLJg
	/1c66TX9wLLNY8QnOC0PjWC1EPpD65c7UELkB6ucQjzSuVTw8hwRPtpm69Luyb2+YQdrHqXmmPY
	l571X6fS6x2A081WWWGGKHN9Y12xKEQqIoH2nQ7wOrLAEsaCGSlDYANJ++//aTJbkOqd37v0uAM
	U6zjv6EKfQ+bAPwtH1VApQBmrS03FznJHwKRba/COfb6VFj7CtTmMXDzm/5aVzAIp50aVIvaRC6
	iM1c8N9lQj/KWJg0qcaNrjIvTY9VlyddGJrYdyW5biCfpFTK7QejydDseO0N1B97oxRD65YxUgh
	i4UTZvsjHQpLhG6eMVcuuy2pOxvovf3FJrCV09faYyyIY43aYUe2eHpW2uAXgFybBKSpiq3MOE8
	XmrViLv0vKlXth683FSvo4GQ03ApoeFLQJ7gOHCea6dMG5cqgBc0RFcNvgE8rSw8ndPTmlHgPzb
	KFbIbu9iT9X5oIOxM1boC7SkcaOP1ZrPhtnuMe9+15XFKOnI
X-Received: by 2002:a05:6000:41d1:b0:488:5db4:791e with SMTP id ffacd0b85a97d-48872a5c50amr4767850f8f.11.1790269081014;
        Thu, 24 Sep 2026 09:58:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm388277f8f.2.2026.09.24.09.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:58:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 11/18] selftests/bpf: Check liveness merge of masks with different widths
Date: Thu, 24 Sep 2026 18:57:12 +0200
Message-ID: <20260924165740.2146806-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907; i=memxor@gmail.com; h=from:subject; bh=z7qBVG8nW8vc/+QcAecaLQvvM1sq0vQBOLcPe4wRmqA=; b=kA0DAAoWRy03e2NUL4MByyZiAGq1VXKhsLpzpEOc443M/ATiyYf88SUKUki/MiY/WlO9033Fk Ih1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmq1VXIACgkQRy03e2NUL4P+HwD/Ragm pVoLPlERfp+Z6cfS9FH1vL8VSpMJLJ/WSiOQoCQBAPU+1S8MZtib06LtvF0Aeg5REPNI+j3kPTU 2aMi/490A
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

