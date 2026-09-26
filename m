Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5DD3115A2
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465717; cv=none; b=S5SR3jPgKqS/JYWtU0gsvjEcs/BHGmeBZhHRzbBuWKJ0HIWclaqmm7BF/qcj+2qS6xez79FpZS0hCepaJ07k66blVRm7fGoIZnOjQ4tRxqiNbPRkrxfeCCImPn9rSVO/vXZF6i4X8VvaUdGpHULFETKl1a8JZx/38hVMPXLSkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465717; c=relaxed/simple;
	bh=7+3w0J1/pGodLmA3vrZdXBkhae484YbGQX+7hqtAcoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A397sJfvezN9ss+zRgR6U83uAfnK6L1DHJlIiryOQU0omLGieGI8rTAlA+M6DeNPyVAvhIXcMCYQrKL7avSbTOl9qV45dF6+f3OWmwSvMhn2RRTfhCvZDN0FOBuyniRKK2Nxkyqgwhktok75VXYk48eeD7mxtvOeIoGNDV/1dX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHGlcj0T; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHGlcj0T"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48880d1367fso369511f8f.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465714; x=1791070514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RR3lV7EZ6a/PcRikckR1v+jZegi35m6AGnlc385O0g8=;
        b=RHGlcj0TQ9F364HKEOfh1pCUrPjekp9sghZOA61CxOk/euOsLIbA4jiLN492fG0agQ
         cf44WtzrEhdFxJQggO5+QKR/je/fRBTyvOVNajPRslK7ohxDyZ9fiXGWExHFcCz7G6Z1
         H1Jvjt9oomqcC2X8Mndh5lzlySkPOeDeV3fG2NNgO/TLHevENM0P7GimeCGfeVHqna/Y
         Hmq/U9L9GK/JBxDRLxGwXPsMB9egdhQSLtpc5vBarQuBP10biq60mJDn9A15jr5sSe4+
         rEVq849a/e29yD3S4gBd9110KFaXag07h5xToPnmE68Fhkq+80rWN3nIbUClY9iTKgpZ
         aqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465714; x=1791070514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RR3lV7EZ6a/PcRikckR1v+jZegi35m6AGnlc385O0g8=;
        b=hY1oWlPiq1y9zNe7nHDhD6xOvNduh6UW+KJ/FQprdL1193AFRoW2klJ9eN5sYGBm1M
         03JhNZAngSyLB4bqTqh/J9elE8/cAgIkPL8nyB6PYnMoZfHGrfskkPI0+rgViwFsHwob
         +LB3ChAoZi8/Uxvy38RnkcFZWnmupEFt3zbAzcSNzxhWUIX4bkdH5mJNggRQCWGnVw9r
         6xTq4Dn5f65WnSJjniAvTTjOFy8WIi2QCgQvXq9lh3nKU7Gmn7UPDNZ5fInFrq1ECKDb
         ttWN26icnxNk042yKDd46DV2vk4rSy3aRRP5rqgJz91qQ4gEGOe4j92hZ31VLNyscVGV
         qQ/w==
X-Gm-Message-State: AFq9FYK00qUc3uYxHoG76Nit4cue0C6+VN0eBkENHhD46vkAXOyCrNGM
	mIDTS3Mu6O+WIx7bSL3qfBTY6G54ne3A/esSQ91Os4r6krm8U4dweyWrln+Av4ck
X-Gm-Gg: AYBFou3HidgJSTWIeHoPeNiU/TLl5SViH1j4gKkosKXCf3D8OG6s5NXls1KexJBU2tC
	C5pXFT3w4j2ZGlMbbQEr+OZddFclKKmQlIwuGgD47e9Fj0xeXJeQafPojqk04n+Bqc3kObZEK3j
	tvuTL6z8n8WaQw0pD0STK1NWRCEHoqC+73NBsQo5zEVWhr+nuaQajBN/GGWwqz4JBxBI1u7bdCb
	BuJib/pTmYuJwu41VUAHuRiLSJFExjlzsjSkrl4TOHpqGQ+xmfIDkA3YS0PiA4Aia8MW04Hf9nf
	LwLNzat2lgPx02cX2tCSmrVsko3cs/SzL9TShSX57rUhL71hBLOpB4chaOyaDiE3HnMtZ8mSVyy
	fMB5WeMW9X/tFkpCyS4IFDPvNifdWskzd0/5XeldLbXL4DQIVwsEbOvWK9cuDTGcx/0yRroDo9n
	VUazcoP+p/dYBu9YtK9VDRimY8SpRjFKSCSeZwGnxNJ4Jffq42PLAcnxbfXP9mAHkB3fEEXei6l
	WhWSpWEz0eBZcvkP5G1tCeACEy7N9P0pGSQGtk3T55YZXloGLVtjdler0Nf5abbikxK/XD86BAf
	tdHdZlBRFCKi3X6xRMjvhYWA0vDTnn+bzjopOQ==
X-Received: by 2002:a05:6000:2206:b0:488:5d3e:bf47 with SMTP id ffacd0b85a97d-4887db2d092mr10119881f8f.33.1790465714117;
        Sat, 26 Sep 2026 16:35:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a76fsm17567926f8f.7.2026.09.26.16.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:13 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 05/16] bpf: Allow scalar and atomic access to typed arena objects
Date: Sun, 27 Sep 2026 01:34:43 +0200
Message-ID: <20260926233503.3114147-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4886; i=memxor@gmail.com; h=from:subject; bh=7+3w0J1/pGodLmA3vrZdXBkhae484YbGQX+7hqtAcoQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWGz2BunkqKLrry3m+irohdU3f9jEuIjBTbeM2cpVU XHJk+KOUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATCTcmuGvgMTCtwLP/s1oaSlq Czf1PBOuWq/g9k/yxDFux4Bmxa4ORoZXTgWbjpxv0nEy/vin49e8bR4aBuuj/AUVVy7ouzHhz24 OAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Let a program read and write the ordinary fields of a typed arena object,
and run atomics on them, through the native pointer the cast produced.
Every byte the pointer can reach is mapped, either with real objects or
with the type's scratch chunk, so the accesses are plain loads and stores:
no probe mode, no exception table entry, and no address check at the
access. The verifier's bounds are the whole check. It already keeps a BTF
pointer's offset constant and inside the object, and the object is inside
its slot by construction, so a typed pointer never leaves its typed arena.
This is what the sanitizing cast buys: the cost of trust is paid once, where
a value enters, and every access after it is as cheap as a load from the
stack.

Reuse the rules for program-allocated objects. A typed arena object is a
program-BTF struct with a special-field record, as an allocated object is,
so give both the same treatment where the code asked whether a pointer is
allocated: reads and writes of scalar fields are permitted, an access that
overlaps a special field is rejected, a pointer field loads as a scalar
rather than as a pointer, and flexible arrays are not walked. Writes are
permitted because the memory under the object is never unmapped while a
program that saw it can still run, which is what allocated objects need a
reference for. The fault-prone dereference predicate does not match the
class, so the context conversion pass leaves the accesses alone and
load-acquire is allowed on it. Helpers and kfuncs keep rejecting the class
as plain memory, since none of the argument type tables lists it; a kfunc
that wants a typed arena pointer asks for it by type, as the page kfuncs and
the kptr exchange do.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c      |  9 +++++----
 kernel/bpf/verifier.c | 18 ++++++++----------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9bcfefdfb734..6a29a9d87702 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7782,7 +7782,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	u32 id = reg->btf_id;
 	int err;
 
-	while (type_is_alloc(reg->type)) {
+	while (type_is_local_obj(reg->type)) {
 		struct btf_struct_meta *meta;
 		struct btf_record *rec;
 		int i;
@@ -7807,14 +7807,15 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	t = btf_type_by_id(btf, id);
 	do {
 		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag,
-				      field_name, !type_is_alloc(reg->type));
+				      field_name, !type_is_local_obj(reg->type));
 
 		switch (err) {
 		case WALK_PTR:
-			/* For local types, the destination register cannot
+			/*
+			 * For local types, the destination register cannot
 			 * become a pointer again.
 			 */
-			if (type_is_alloc(reg->type))
+			if (type_is_local_obj(reg->type))
 				return SCALAR_VALUE;
 			/* If we found the pointer or scalar on t+off,
 			 * we're done.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0069983f103..75697e52a2df 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6341,12 +6341,6 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	u32 btf_id = 0;
 	int ret;
 
-	/* The access rules for typed arena objects come with a later patch. */
-	if (type_is_typed_arena_obj(reg->type)) {
-		verbose(env, "typed arena access is not supported yet\n");
-		return -EACCES;
-	}
-
 	if (!env->allow_ptr_leaks) {
 		verbose(env,
 			"'struct %s' access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
@@ -6398,7 +6392,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (env->ops->btf_struct_access && !type_is_alloc(reg->type) && atype == BPF_WRITE) {
+	if (env->ops->btf_struct_access && !type_is_local_obj(reg->type) && atype == BPF_WRITE) {
 		if (!btf_is_kernel(reg->btf)) {
 			verifier_bug(env, "reg->btf must be kernel btf");
 			return -EFAULT;
@@ -6409,10 +6403,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				"%s cannot write into ptr_%s at off=%d size=%d\n",
 				reg_arg_name(env, argno), tname, off, size);
 	} else {
-		/* Writes are permitted with default btf_struct_access for
-		 * program allocated objects (which always have id > 0).
+		/*
+		 * Writes are permitted with default btf_struct_access for
+		 * program allocated objects (which always have id > 0) and
+		 * for typed arena objects, whose memory is never unmapped
+		 * under a program.
 		 */
-		if (atype != BPF_READ && !type_is_ptr_alloc_obj(reg->type)) {
+		if (atype != BPF_READ && !type_is_ptr_alloc_obj(reg->type) &&
+		    !type_is_typed_arena_obj(reg->type)) {
 			verbose(env, "only read is supported\n");
 			return -EACCES;
 		}
-- 
2.53.0

