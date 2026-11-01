Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559999;
	b=XpKLJTXNAe3q2iDOMd5HQVNXw4YrYfYETKUlBqMcx/gabQm1xp9MAuDpMZbRhGCFSXIc
	 eXnnFiUI8K4yCkPiWwr24CsvIynFYeS8O9IuS61nF7TyaFS2wnjHIgwBabOEXNDfvGI4Z
	 fyV5ob4ZeDKn3wzQiWflxMfwG83q3WNatJpqIsKWYSc4qD2QeWhG+S93Zgf+/GXAEUZ6b
	 MtfVf9GgqnIOya3f6G61h8P6apFx/19ciJJRqTzAcHuZ8wvulVg7SEy0fw9rCfLR6yKt1
	 PXkLne7hZQRbdyBCvex8Ht5ND04K8clXbYB9+gemkPssCU7Hh39bB1MdFWwmevaeo8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ox7pf8FL3JHafI7bPE1BGxrX5ZDCrt0aEoHpjm5N0/8=;
	b=11bh8M2M76Q7M5YXXIeOjpd1zmAFbWqRtM5WvSHJFUrFUVfBVRMFAV7zjGdPv2a5QsHL
	 XIIWDuru2fCJdlpOUpa3v0m4Zmpz94olPK54KKkien/1A+2qJcIFs5VQXB7TwMjS2dcA/
	 9F9+9/i96gCkE25b48uADfXSBTq7mh8VObFlpB1dPC2iCl4cZ+W+PzeXYJT67Jg1SO4Ft
	 GYUOdf1HD4XicpZZP29Xvgv36jWLt/LVuvk1B2Zs/HzWId2jjM46vPkaQRlJR4X48urej
	 KA23TyKkZQsUAN0vAA1hrotbvbxnuiYBzAOEkSde6igrLohTeLMGuMR6BjdvuVFA/hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="SIm/zn79";
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E7606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C53E7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SIm/zn79
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso1176182a91.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793559998; x=1794164798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ox7pf8FL3JHafI7bPE1BGxrX5ZDCrt0aEoHpjm5N0/8=;
        b=SIm/zn79ZjQSd9y12T1Gs1/KBhT44d0L9gMqX4uP8k+QXSXmwsDhxqo/qHxbcOqwk8
         J0bQJZ+1QWCodCnW9m8ytPoNOciaDKsWUxBToAANMR5Vmgc8Ts2SyQ46/pT7ldpRwLPG
         +FXzZYsLXZdHEl7xREIv3YrYYbMSJToNQ/Svg9QZ49W87TLjy+jBQRYhwnHenpuyciDc
         U74/tAZU63tT08rRqbx+RZn5tttuRRVFjwgHb1+hJD5cCneDsMfqiXYhGRYkfma5mEFb
         uA+FgSLaV6FJkS1Vo4oy1ak5CwUNY1zRSsxB0yMLPm84cpS8dA1Ix9NekBstOnbI4FTe
         CeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559998; x=1794164798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ox7pf8FL3JHafI7bPE1BGxrX5ZDCrt0aEoHpjm5N0/8=;
        b=D7tzN7I19uxT5wN/nRVLVCTjcowmKLml7zua1RYohkMnFCI6Rqn4JGKQrLLVolNn4M
         lMyJWSW90ToU85YEO+jYujx+J2jJHzgeAGDjnhTK0zaB2XOiII/vp8yN/vCO49FcYuhQ
         Rz4wQj+2sxhGZo3R2rST7evcc5YaE7E5aOfdXpiURT7tmN5gif6N4V+h2xIPxM+q3Day
         csPPBuAExo0FT33fpe0mfGbk4W7zYZz1Ar6WxS+xRudrR2QmZosHV2RKys7qPT4wDgCz
         dI4kMVmbrbua5nnf6KNH5UE8AB6kE2qJmRo6amgl8nyMqm0aFRWacSKpOtNYZJd6hGNK
         e+9w==
X-Gm-Message-State: APuU4Z8umq834aRehM7i9Q+mEsIgn9j5oq/ND7ZooOCiHg+SZvjBAoHk
	i51tuq6wlFVIY8a1Ck+Fo0Z/Fw2qlqc64U4BGomBtlwjNyPXJauAKb9QBWfHHw==
X-Gm-Gg: AYBFou2SUoXNQ2giiKl1stQe3FUCBGm+7zCGL44IMb+tmf4KM13IXhRq7OxCK61KW6g
	UFzUOoFb4LQfqDXH8fRz38ivSvq+G+20wc0pMsUQC4WEZCT1xqX7De2fBmqtKsMB2NLyrlpODHw
	4vGMkwrD+EgXwpg9WxQbU/mXaXJEB/mtaYB0EhgarKIv67QabgPkiGeZihgNi4JT/ej/YxgpxcF
	pVBGeMyuqqxutIrsXADhLs9qqLG/SD0mhg+pjHnP5AuEApPoG6imv1Yt3qqp7E3MjINXrcK7Cx6
	X54/AwUpb59VFGtyHPh4hvhGIWq5i7sfzoQoMZlN6N2qwXMG9K05u6Gj7loayv8v2XML55cUsbq
	BM2KPVhJnHx9h792lh7JE9OiH44vE2DsrYqdCXTmqcKWJr3MBLKXoWQWcWqX0A4sK6yuUIo2GMW
	G2Kh+ag5EtCYkL0HIZdJQ5XSNdCFvNGD/ZkPMv2kWpey1xOJ6m4RWG3d2qJReD62xzafgyD678P
	KC7lW5b7Ag7ecOVAEl2VchW0edPMqoJyGqYrsEuYkmiFSWh144u5MC143Cb23e8CG/guc4YxgjV
	K3A0QLWhirQ+/ZBQ+papS8iX1itYB9e1McvGLB3Zrc99nDt4CKz3xRC5PmWAgRwxW9eW6mUmqpS
	pgBtnv+df8RyKLEBb6Z3ziosFvy1pypzCIVJD57dWG10QFUZIhfaGKJX1qLsJ1+kbp78bLmSZew
	==
X-Received: by 2002:a17:90a:e7cd:b0:3ac:85be:cd56 with SMTP id 98e67ed59e1d1-3ae897ce1famr6795513a91.12.1793559998118;
        Sun, 01 Nov 2026 11:06:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8441a5ecsm10986915a91.2.2026.11.01.11.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:06:37 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 10/27] bpf: Don't turn kfunc arguments of an empty struct type into memory
Date: Sun,  1 Nov 2026 19:05:18 +0000
Message-ID: <20261101190535.1454146-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

A kfunc can take a pointer to a struct that has only scalar members. Then
the verifier also accepts memory of the prog: resolve_func_arg_type()
changes ARG_PTR_TO_BTF_ID to memory of the size of the struct. An empty
struct meets this condition too. But it is a handle for an object of
another type. The io_uring kfuncs cast the empty struct iou_ctx to struct
io_ring_ctx. Thus they use memory of the prog as a struct io_ring_ctx.

Keep ARG_PTR_TO_BTF_ID for a pointer to an empty struct. Then the verifier
accepts only a PTR_TO_BTF_ID of that struct, such as the ctx argument of
loop_step(). Only one other kfunc takes an empty struct, struct
bpf_ws_lock. It releases this argument, and the verifier does not change an
argument that the kfunc releases. Add the rule to kfuncs.rst.

Fixes: ec02fe217fa6 ("io_uring/bpf-ops: restrict ctx access to BPF")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/kfuncs.rst | 6 +++---
 kernel/bpf/verifier.c        | 6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 329d1510b02a..901c37504217 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -410,9 +410,9 @@ explored states of the program.
 A pointer to a struct in the arguments of a KF_ACQUIRE kfunc accepts only an
 object of that type. The same applies to the argument that a KF_RELEASE kfunc
 releases. For other arguments a kfunc also accepts memory of the program, if the
-struct has only scalar members. struct __sk_buff and struct xdp_md never accept
-memory. A KF_ACQUIRE kfunc which wants such memory has to pair the pointer with
-a __sz argument.
+struct has only scalar members. A struct without members, struct __sk_buff and
+struct xdp_md never accept memory. A KF_ACQUIRE kfunc which wants such memory
+has to pair the pointer with a __sz argument.
 
 2.5.2 KF_RET_NULL flag
 ----------------------
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cc2ba4dc9da3..a456adaa459b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13593,10 +13593,12 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 	/*
 	 * A kfunc that takes a projection type (ie. xdp_md) casts it to the
 	 * underlying type. So memory of the program cannot stand in for it,
-	 * even if the projection type holds only scalars.
+	 * even if the projection type holds only scalars. A struct without
+	 * members (ie. iou_ctx) is a handle for an object of another type.
 	 */
 	if (btf_is_projection_type(ref_tname) ||
-	    !btf_type_is_scalar_struct(env, btf, ref_t))
+	    !btf_type_is_scalar_struct(env, btf, ref_t) ||
+	    !btf_type_vlen(ref_t))
 		return 0;
 
 	resolve_ret = btf_resolve_size(btf, ref_t, arg_size);
-- 
2.55.0

