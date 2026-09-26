Received: from mail-wr2-f7.google.com (mail-wr2-f7.google.com [74.125.225.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE2380FCF
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465719; cv=none; b=H5J5hUE7LB/rF/G90qRgGLYlCWRPDUnpjXW1lM3UrT4gEGcPNxmaOZX1nt+h1z8UVWdAw3fRRJpgypdnX9tRq3dnJ/AFOZ8LU3RiW40I09wzHbE2pixJD6V2Q9dFRtpeOwiHf7yWqHwyuYVUFNUL6ZOY4B2dpEwkeOYY/wEEroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465719; c=relaxed/simple;
	bh=mdl0bHekMZPsDzq8R2rOaKYoki4uPL/MY94votAWWF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TU0f27sh3XXiFTgqeM2LkdJIqui9Da5+s4h95uO33wFDha24RW0KZWpDRv7BS1c/eQdqacmgxxw3o9hzgGJdSeearYYAETXANd5A2nDNa7O55WdXaAkIRe9BLBrR6Ll9Xr8IkjMV1oCX8JWR5GMnqmN8OiCLKBfX36aXLtSY3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHtML6G9; arc=none smtp.client-ip=74.125.225.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHtML6G9"
Received: by mail-wr2-f7.google.com with SMTP id ffacd0b85a97d-48888103f99so271964f8f.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465716; x=1791070516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWbjbTIKOC7T75SGsH568HJmvFj5YkUAClcJ6ld4oxc=;
        b=sHtML6G9/wixpclTQ/acGRkBgmHh1RIPKJELIytgFRScOkFF0NLAfl4XYZ+aXW+Jur
         +VbQ3UzmuRgFKEW/1qyo4RRbrnEWaXgxM4mutZigbigo07aVoGTBzABNII+NXd/+y87Y
         JSFe3Ypp/QnmN9f1GdTFaJzwbqZdLTFx1WT7OSlygH0w8qYfpHj0BiubfCAWlt57Q2Y6
         Hg+WXP25tw1agQafTzBxxzcfPC9Gde0hGJssy+N4cYlmMwCFVx5oCnZTY7VKL/LHpocL
         TBZUNg3Ik4zR5u1i/UqoI3PitnHj2ZcD+w5/12zJAEN787guAJ16w//B+JwcO5wf+S+T
         2C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465716; x=1791070516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aWbjbTIKOC7T75SGsH568HJmvFj5YkUAClcJ6ld4oxc=;
        b=JPHv3qku0TJhCetkkhtUr56qpbcOXna6q0j4vKoO3gRxAWUAbb6P/Tcmkmt5Fsy9ac
         bLVd6IBUA2Fw+fc9Xj2KqCC9WKj6VNH49cqqmYuvg5Pd1+NKO07qd45yOlEx+lsClHK3
         eA3US4MZdGzFKczEM6zX3MfmglCeSbkZRMvBfeA5OT72pWeBOzd6j/za6ywkQ9MqHFGr
         UipxjdvVul5tg1negXCOCCWtrC5Gu4gtbmZlNYjXu4Kskm7a9Xi0f8aAGrJce/ndr0ZY
         RQCJuUkdemS2Dt3Wd6OfRc0Td5gI8QumgUjt0EKaTLrrNBsQKoPpK3VxCoZTPPL6caAC
         D8pA==
X-Gm-Message-State: AFq9FYJAOE5QMJown41UJy1SIfK75Q6WGcolvVWkAnYpe6YjEnxNyAhe
	5mDyVjdxLjtjK8VjTt6sTyZK4Ku2l83PsBmVFO5tnRKVAR6rzEPrK4urFOBnAmr6
X-Gm-Gg: AYBFou0IepsIrY5T83cCq2bTgMGGPP4fpiR1W6iIXm4lZFTM2QKB79hchRrJCPtdDSW
	Cn7wqXxerojzJMFuBNNJ/0Ke2NW7DJYKTZAsyfx+E3hscbxptECRCPLtgn0FczKS4WrNwCEZe6N
	FQGg57r+NpEPaPDti21iJx+6saRH0tENHfYy14umKoQO+gepDiDVmenAULc/9NFpRt478PyeW3z
	qc/9/RezzjW1MYVYTGMNLIiA+vWqJfRDReU1Zp0KNS+J6IgNn5eP2dWJBOOrPw9ztvBY8UUjo7y
	1R9Drj3Q2mwkPETjJskJCa3da5KbCv7h1niK5hjOhXGkly3Tyc2MndvfUxj94CF5pbS4goZpY+O
	8DWcOnEqkAUBFJWntll3MMgZ0nHM9BybH7PdhCRfC3PrGQU75Zz10HZUd4pbfBhJD3y5715ZSra
	vcsPMMtUrh0KSAXc6TIiMJFv9hR90i0f9Mx93Pc0HezDyg5TaaD5C3u18C/IKhplY0FMGOwjy96
	Tp6gcMuxZiKLh302i+6aERlshVxYbkBNOa5w9fA9WFkrOOtbxE3wKLmSUYpoi/z9yj4TLew5sCz
	hzeSjL7RukitM326o6eTb6qhS9u98L9tdt6dbg==
X-Received: by 2002:a05:6000:2dc8:b0:488:82e6:2671 with SMTP id ffacd0b85a97d-48882e62910mr8722925f8f.12.1790465715766;
        Sat, 26 Sep 2026 16:35:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84221bsm16782533f8f.36.2026.09.26.16.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 06/16] bpf: Support special fields in typed arena objects
Date: Sun, 27 Sep 2026 01:34:44 +0200
Message-ID: <20260926233503.3114147-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4620; i=memxor@gmail.com; h=from:subject; bh=mdl0bHekMZPsDzq8R2rOaKYoki4uPL/MY94votAWWF8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWNw/ps2VU1Ne7d/iVHVwhlj/K3/923NmfPs4U/+GZ IrasnKjjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkxyeG/zXXv8at7pTI0XXN 7F5t80TtLMfpayeO8XKEeru272J8M4vhn1m9TjDT/4d3RSXLjNYmJh99OlUwkPetyWILB83Tcz5 9YAQA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Let bpf_kptr_xchg() take a pointer to a referenced or percpu kptr field of a
typed arena object, so that objects in arena memory can own references to
kernel objects and to program-allocated objects. The exchange is a single
atomic word swap on a native address, so it needs nothing from the arena:
the field's record comes from the struct's BTF as it does for an allocated
object, the destination may carry the field's offset, and the value is
matched against the field's type as before. Direct loads and stores of the
field stay rejected, as they are for allocated objects; the exchange is the
only access. A reference left in an object is dropped when its chunk is
released or the map is destroyed, including one stored into a dummy object
of the scratch chunk by a program that used a pointer nobody allocated.

Kptrs are the only special fields a typed arena object may hold, and the
reason is how its memory behaves. A chunk is released after a grace period
that covers the invocations that started before the release was requested,
not the ones that start after it and cast into the range, and a fault in
the middle of a kfunc swaps the page under the object for the scratch
chunk, so the rest of the kfunc runs on the dummy object that every
unallocated slot shares. A field survives that only if each operation on it
is one atomic instruction, so that it lands on the real page or on the
dummy but is never split, and if the kernel keeps no pointer into the
object, so that nothing dangles once the memory is gone or reused. A kptr
is exactly that: the exchange is the only operation, and the referenced
object is held through the pointer value alone.

Timers, workqueues, task work and RCU heads are not. Their kfuncs take a
lock in the field and touch it several times, the async callback object
records the object's address for the callback, and an RCU head is linked
into the RCU callback list in place. A release or a fault in the middle
leaves a lock taken on a real page and dropped on the dummy, a callback
running on memory that now holds another object, or the dummy's RCU head
queued twice. Locks, lists, rbtrees and refcounts stay refused as well; the
memory is native, and a program builds those from typed pointer fields and
atomics without kernel help.

The way to give a typed object a timer, a workqueue, task work or an RCU
head is to allocate an object holding them with bpf_obj_new() and keep it
in a kptr field of the typed object. Allocated memory is owned by the
allocator and freed only by bpf_obj_drop() after its fields are cancelled,
so nothing swaps it or reuses it under a kfunc or a callback. That needs
those fields to be allowed in allocated objects, which a later patch adds.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 75697e52a2df..f854d8419fff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -386,7 +386,7 @@ static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
 
 	if (reg->type == PTR_TO_MAP_VALUE) {
 		rec = reg->map_ptr->record;
-	} else if (type_is_ptr_alloc_obj(reg->type)) {
+	} else if (type_is_ptr_alloc_obj(reg->type) || type_is_typed_arena_obj(reg->type)) {
 		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
 		if (meta)
 			rec = meta->record;
@@ -8063,7 +8063,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 	struct btf_record *rec;
 	u32 kptr_off;
 
-	if (type_is_ptr_alloc_obj(reg->type)) {
+	if (type_is_ptr_alloc_obj(reg->type) || type_is_typed_arena_obj(reg->type)) {
 		rec = reg_btf_record(reg);
 	} else { /* PTR_TO_MAP_VALUE */
 		map_ptr = reg->map_ptr;
@@ -8834,6 +8834,7 @@ static const struct bpf_reg_types kptr_xchg_dest_types = {
 		PTR_TO_BTF_ID | MEM_ALLOC,
 		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF,
 		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU,
+		PTR_TO_BTF_ID | MEM_ARENA,
 	}
 };
 static const struct bpf_reg_types dynptr_types = {
@@ -9154,6 +9155,7 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
+	case PTR_TO_BTF_ID | MEM_ARENA:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * its fixed offset must be 0. bpf_refcount_acquire() returns the
 		 * pointer it was given while incrementing the refcount at the
-- 
2.53.0

