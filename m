Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493F44838A
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380271; cv=none; b=lJ+uJbKQg/Iujkxbsgi6dORBE8FdUwW8ezBaS7lsJSUk0NnaItJ8RImP4sLk8UXhFSvTGsdqCk45I7TtczTZe/O37H9KBVQvfYzaZlTNLa0Bt0xl5J097UyqCyKSNL1BN/qodXhfuouOh8EbqDG0b1W6QH5VFftb/bbUl5VR37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380271; c=relaxed/simple;
	bh=PZSQQI4iM/v/q56J62l5sT9DyBOlizugaHqSeNShsH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H77Vlbel+nnER+kDnRgPw/7rAaHl/SAgP9IuHSXg2tLW8ktBFw1kVK6JYIRPzJ29L6Yw/9YJjN+qpC83Z7GPqurXsv7UKFNkrmsuJ344ss7xJ95wlfes6NWe8qEZdyR/dFZVLP3yZKEvOvKMtT5RQXpSQ2JsQXsNg8Cgj7LfAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPVwh+O4; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPVwh+O4"
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6de056f06beso1052693eaf.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380268; x=1792985068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ilHAzzLsvX6Kbjkwg2wNlvpwGquZ3SDw0vSiAlYEdp0=;
        b=QPVwh+O4fba2IH2vWJgs+IwCyr7IejZhNFb2QGwauGIdwctVgxchQDv7F08x6IIWTJ
         HGwTbZkNnPtURK2tHxTZQ/PqnIeFQfk8Su5ZtsRpAjGFCg8rDTIbjaYuOC5gXXXW4Hks
         Vj/yK+eJtiZsxfq812WQKrpYry4tX5Os/EQmPSiTqZ1tT1qtE+mIC3Y+N0oWX5tyS8RN
         N4clMnict+uvKivHso+FVLUbj6Hvkbof5Pw/bp38ypqvzFEGgacxHetpWXga3V6unhC0
         xJV3RmbyTqEVURBAzWNa3n7uiU3NG7Beye+ZdiBCPbZykWrjReSC5Fl2T8Psl2qb/hlS
         ZFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380268; x=1792985068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ilHAzzLsvX6Kbjkwg2wNlvpwGquZ3SDw0vSiAlYEdp0=;
        b=c38ZOq/uH8yR3vqMSiWQ12abgUyLyEUc0qKpcsZYXxM/LTXanTMaIl6s6xHvLvlCOF
         ieh+Lm+s/lGtaVPzPSEQwPt3u0P54TKoaCecxKxIPTHPGNKiYVk/k1P7/Z8qs8LRN0EQ
         FCYWt9A5NGhfOxUDXNT1dDz7AtPupBa/CAUGDWBrwf64MUVfY4X+8HjFXNVDwh26jsII
         enXKTkCpdg3Y6+3B/FzIqQWH4O7fTxr1D7nAsjsKF9HhZSci128O6PTCABESc+L6wM14
         YbhZ51m6d8XelM7zcGc/QW+gO2wV9YcTBNeWNIxO+VEsz3byRW0KpL849aAksqOxFInP
         Q9zA==
X-Gm-Message-State: AFq9FYLR4J2kZkHJM0CMuwHmSIl2d5e9rqKTWTwhgoSBF6ZPG/uax6E5
	F8+4pbFT8lcMaSdKX7lXD6CzfaSuFXeDGixwlIFjUR4ZMEFzfG+PvD4iO2cSW0KajmU=
X-Gm-Gg: AYBFou3VwMj893mUNcIkWoWEjE5WsQso47K/VkpiY5CyDIUnA3sRRgEwieEB0DJ0m0s
	WN7rNt/W7WHuapYeGPNhHmfNcGhmxyozehowy9LhF071UpkUCKmUA+xfteBBVLVWrRpFeIj398v
	ZT0N5osppEWh8xHxNZ/8CebmKvFMX0vMsvVkQMVA9RXHByIymSDRF1FmhyFJ/ZuoFdVvTdXlp0s
	k+/uHWYqF9q7F9LJIT83Zk73XaOIO98zNl7r35jaQ8BMM3ErHodH0gCl8o05Ok7/2lW8REbAb04
	xhHrcqc3SS45jKwH+Fbudg3OK08YzvZu+hpYLXmcLSGuMqQvBmHbXd3oLhLp4KID7cP089U4G+X
	zlWk+jdLDHFrDbrH31ZAw7NB4OuahXIo/WbMOcNUfXrJZDWXdqwCohvFR35ALk/2CLyCGx9qlNu
	7jIr64Pt2qnDZMfIvYub+ylZoGvJWGryjmf7TAb4QD+ScMxz33NldsUR+MHRe0Do4THcax2e23r
	qcSYBj9P+smdchgbX88oJ70CPSwFl/6B8iQ8Dzywp44AHCeQGGv9C7Rvb7Y75iBgAvLYdWUAhjY
	FDwd
X-Received: by 2002:a4a:e849:0:b0:6e1:f7f7:532c with SMTP id 006d021491bc7-7035639e7e3mr4044830eaf.40.1792380268384;
        Sun, 18 Oct 2026 20:24:28 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-843d83aaa5dsm7083818a34.21.2026.10.18.20.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:24:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 06/16] bpf: Recognize __nullable on pointer members of kernel structs
Date: Mon, 19 Oct 2026 05:23:46 +0200
Message-ID: <20261019032401.2302823-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4088; h=from:subject; bh=PZSQQI4iM/v/q56J62l5sT9DyBOlizugaHqSeNShsH8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqr27ra5nEprnBN/yuz+N0d01fmH1Ty9VculJC1mCd36tn MSYdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMjadQz/K5qvb7/IUJJQXMrcpl5rmr +sfG7Os4DiZ70xfosO37TWYWS4pPeg9/wkm/0vPnNXrt60gutljl2V0ZuVjG9SC2v1761gAwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A pointer member of a kernel struct that the verifier derives as trusted
or RCU-protected is assumed to be non-NULL, so a load through it is a
plain dereference. The BTF_TYPE_SAFE_*_OR_NULL lists exist for members
known to be NULL at times, but they live in the verifier and have to be
extended by hand.

Teach btf_struct_walk() to report the "nullable" BTF type tag on a
pointer member as PTR_MAYBE_NULL. The tag combines with any other tag
on the member; it only says that the pointer may be NULL. The verifier
keeps the flag where NULL would otherwise be assumed away: on trusted
and RCU results, which a program dereferences as they are, and on
per-CPU results, which the per-CPU helpers shift without a check. Such
a pointer has to be tested before it is dereferenced or passed on.
Plain and untrusted results are probed anyway and lose the flag, as the
BTF_TYPE_SAFE_*_OR_NULL lists never applied to them either, so a tagged
member of an existing struct asks no more of the programs that read it
than a list entry does, and the tag can take the place of the lists.

The next patch uses the tag on __arena members to decide whether the
injected address translation has to preserve NULL.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c      | 18 ++++++++++++++++--
 kernel/bpf/verifier.c | 10 ++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a9bf4c3c0a27..012b6c5c3eff 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3569,7 +3569,8 @@ static int btf_type_tag_walk(const struct btf *btf,
 	return 0;
 }
 
-bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t)
+/* Whether the pointee of pointer type @t carries the type tag @name */
+static bool btf_ptr_has_type_tag(const struct btf *btf, const struct btf_type *t, const char *name)
 {
 	if (!btf_type_is_ptr(t))
 		return false;
@@ -3578,13 +3579,18 @@ bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t)
 	     t = btf_type_by_id(btf, t->type)) {
 		if (!btf_type_is_type_tag(t) || btf_type_kflag(t))
 			continue;
-		if (!strcmp(__btf_name_by_offset(btf, t->name_off), "arena"))
+		if (!strcmp(__btf_name_by_offset(btf, t->name_off), name))
 			return true;
 	}
 
 	return false;
 }
 
+bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t)
+{
+	return btf_ptr_has_type_tag(btf, t, "arena");
+}
+
 static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 			 u32 off, int sz, struct btf_field_info *info, u32 field_mask)
 {
@@ -7973,6 +7979,14 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 			id = ctx.id;
 			stype = ctx.t;
 
+			/*
+			 * __nullable combines with any of the above: it only says
+			 * that the pointer may be NULL. The caller decides whether
+			 * that matters for the register type it derives.
+			 */
+			if (btf_ptr_has_type_tag(btf, mtype, "nullable"))
+				tmp_flag |= PTR_MAYBE_NULL;
+
 			if (btf_type_is_struct(stype)) {
 				*next_btf_id = id;
 				*flag |= tmp_flag;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 14dacc5d202f..5d5ef7e8509a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6754,6 +6754,16 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		clear_trusted_flags(&flag);
 	}
 
+	/*
+	 * A __nullable member only matters where NULL would otherwise be
+	 * assumed away, which is anywhere but on a plain or an untrusted
+	 * pointer: those are probed on a dereference, which tolerates NULL, and
+	 * the BTF_TYPE_SAFE_*_OR_NULL lists never applied to them either. A
+	 * per-CPU pointer counts, per_cpu_ptr() does not check for NULL.
+	 */
+	if (bpf_may_fault_on_deref(PTR_TO_BTF_ID | (flag & ~PTR_MAYBE_NULL)))
+		flag &= ~PTR_MAYBE_NULL;
+
 	if (atype == BPF_READ && value_regno >= 0) {
 		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 		if (ret < 0)
-- 
2.53.0-Meta

