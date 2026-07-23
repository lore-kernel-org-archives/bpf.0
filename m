Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A33515D5
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783309; cv=none; b=Pz0572m3GVIzTAbj6BdSNZk5kWjBa/fi/XITRxuJUAxWP8NQWR3mdcSOpguib6dvu416FEm28nUEJmFpOXPVr5PJ+zOugDjpgTgXprj5GX8qKVkZn2Eg7IqkLuMeJHTmzCfIT8DyHeyvw1CFzv6iBVgwPYQNW5oXRvDG0HEBHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783309; c=relaxed/simple;
	bh=eCv845LE9QqfcUvfQWz+eVPAHq3Ru8SyqLz0ShgGTns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYtBc5WL1gOefGL7xhIAPpc2XtGrXE/fAQynpQRfI9sZ0nRE8/DPTmNX5PPhKuzu7LhCLuQBnNmB/7ZBl7RQKO2zAmdhv33O7R7TRlpYFA9KfXLbRNTuogfgIGhQDqL5fuRCgme4PfJFV1Ohygl5oK3NuAL06ofA780qcW4X8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il5Xc86U; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il5Xc86U"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc61541f8cso749165ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783307; x=1785388107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g4uTZvK+oXVDcknq/iBqrg/HPpX9QWrBNgvYjgF/ld8=;
        b=Il5Xc86USfgWWSpUqfwk5BvASKb+j7NpTLlw9J96uW9iLq8Zb5XIIpb/E7GvkeT1cF
         2g2LSK7e4BeV77i5kTXtAVseybpveCVP0eLcPOYwelUYQNT8eAakV3Tur3+ffaPYJGar
         i7sVQvDM8wS9lRvY0R9/jqSwcVshEdpLH72u/EgdlfAoH5D6uYDhIyCtc1SfKy3cHmQf
         do0JAsqWwfcYPjCCRaJOx/yEJXgkGS0MKDVyN23heuvbaZGeCjkZDGseO1eMJQ7DUxYQ
         UOoV1DnVW9DqTLS86FseMCGQk9/TfwVpBlxGflJho7fNFaYcCV80KTQi1heYs6ZxwNfB
         LFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783307; x=1785388107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g4uTZvK+oXVDcknq/iBqrg/HPpX9QWrBNgvYjgF/ld8=;
        b=cBeoqDI19gIoDszmFNZy/FKA/xiwHnMqJgBk34OqRtP2smiU7SyAGyrbxk1XMQYD6/
         7khqeRcbP1Yvgels4qAo8LpweAy5UrWDpioPy2l0KwdVEg6kqX+oZSgzUXln2gfAmz/z
         yx9ty5FW41HPQ0jjTDPm6Cf+wagZg9yh5iIPtojMCQEQLl5rjeIqlc9bVgtiTB+AwwKz
         aunCRoFoPzpsvqaX8B0FNf1r2rNUc8BfukBsWmG8DPIATdRtBhaOOjvGQZ88wtqrxsc8
         vLOtp9cOB2U82kRmMVqXQfbHX/gDh6EI5h829OgUapz7ygDLiiHYtx2wvHnvNZy0Wxka
         gBVQ==
X-Gm-Message-State: AOJu0YxEHypdx0rr4p9VvBZ2kqaVFsr2nSblGVtzygZKrb+LKik3uEQC
	IjPS2QbrBFKYlgaYFaYwkRq66+C439gCeUPAyYi92uq2mTMWHhNTPfcIhMH76w==
X-Gm-Gg: AR+sD136yLwWu72vgKySHEDAqaiPjyTKFMJLTCgJFHk2vDzsho8wPUnTc+zLIhq7q5u
	zXSLBHhWFO2VIrimxaneX1mrBPBAQ5ykUCXXV4LRh5uvE18berhLYPKhj6JioKpizqJh2dKaBqz
	3WpMDhq9W//piucHHMTBZlgVW1ya53X7Bl5GhIePxjmNZlsx/rqeiimJV5SmuSGsOYu5TmqJYfF
	t3ZHcm0CqJ9ZsR3auWWhAUhHWcZlHbmFFsu533eA9c93br3nZeJq2KuuQxUI9Ht3csCr76v3CLq
	zpJagMknKVDmZxaEv8b/5nIQVPM1E1bduwW3bp7tKXumbsbrrwogay8P3R95h0P64Di/uNeQ18J
	/gNBPBfnkru574kJLT+UDcBEpgl4N+RkP/+8ImkvuVbHslsTY/ij5NHzPO4zJqrLT0+si
X-Received: by 2002:a17:902:ce89:b0:2ce:a6a4:451b with SMTP id d9443c01a7336-2cfa94567a1mr14177505ad.11.1784783307255;
        Wed, 22 Jul 2026 22:08:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f3b6578sm25684895ad.81.2026.07.22.22.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:26 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 14/18] bpf: Check helper mem+size in ARG_PTR_TO_MEM case
Date: Wed, 22 Jul 2026 22:08:02 -0700
Message-ID: <20260723050806.1158442-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_func_arg() verified a variable-size memory argument across two
cases: ARG_PTR_TO_MEM was a no-op and the buffer+size pair was checked
only when the following ARG_MEM_SIZE argument was reached. Handle the
pair in the ARG_PTR_TO_MEM case instead, looking ahead to the size
register at regno + 1, mirroring the kfunc handling.

check_func_proto() already rejects a non-MEM_FIXED_SIZE ARG_PTR_TO_MEM
that is not paired with a following mem_size argument, so the size
register is guaranteed to exist and ARG_MEM_SIZE needs no case of its
own.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f89551bbae7c..65de60301861 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8511,9 +8511,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->subprogno = reg->subprogno;
 		break;
 	case ARG_PTR_TO_MEM:
-		/* The access to this pointer is only checked when we hit the
-		 * next is_mem_size argument below.
-		 */
 		if (arg_type & MEM_FIXED_SIZE) {
 			err = check_mem_reg(env, reg, argno_from_reg(regno), fn->arg_size[arg],
 					    arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ, meta);
@@ -8521,14 +8518,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 				return err;
 			if (arg_type & MEM_ALIGNED)
 				err = check_ptr_alignment(env, reg, 0, fn->arg_size[arg], true);
+		} else {
+			struct bpf_reg_state *size_reg = reg_state(env, regno + 1);
+
+			err = check_mem_size_reg(env, reg, size_reg, argno,
+						 argno_from_reg(regno + 1),
+						 arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
+						 fn->arg_type[arg + 1] & SCALAR_MAYBE_ZERO, meta);
 		}
 		break;
-	case ARG_MEM_SIZE:
-		err = check_mem_size_reg(env, reg_state(env, regno - 1), reg,
-					 argno_from_reg(regno - 1), argno,
-					 fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ,
-					 arg_type & SCALAR_MAYBE_ZERO, meta);
-		break;
 	case ARG_PTR_TO_DYNPTR:
 		err = process_dynptr_func(env, reg, argno, insn_idx, arg_type, &meta->ref_obj,
 					  &meta->dynptr);
-- 
2.52.0

