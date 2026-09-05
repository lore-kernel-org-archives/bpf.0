Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFBA26AF4
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645698; cv=none; b=T/cDXNFTjcYzwZf4OY4W45xyVvwxOaxqYMGN+WdmbnoMyBmgkX1dWxrzisLl9OmjyenSzZ0JimeG0SzaDTclbndiJjXOQCifG14cC+RkDfyXV9mJplvrA9XWxFyyA0htatqlbbx4f2KVQ6wz38sLgJI2kw21yq6av8sXFmmoEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645698; c=relaxed/simple;
	bh=aCviLAcySKIOqoj5sG1ssYRXtbnCJ6L2GMiJKHndqdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOpf22JCCdMNP6GYN7dfU0RnWpXmQP7xmtnkzJSV16LcwORuWJCHYdaoHhu94wbSNWjk8C91drINMCByc4qJkE3tc35+Nr1wkuoDkS8QeGZ5aciM0773VrgKBkOhYOEoJolECoKFqyciSrYdmK2O7HLQ7BkLw9CM9XBjIHrQhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMwrmtHV; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMwrmtHV"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4af173320f9so1705437b6e.2
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645696; x=1789250496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HZm0ttASY7rre/2JxFqWxyWYHaZ5PaCtc1JLxshrQdw=;
        b=rMwrmtHV9U0GZH+1r9pT3+yL6ZlmQAwDog/BqEHUu6SEC1WHVMRWFLu2ty/KBIirKj
         8nmiSAs3NqS2afpqt2UJ/kwl/2S2rKVW1dKrQsmAFXE61N+vyY6McthVaFkJt79b2Run
         KRrN0JX13gMJjljcUY+tFWpmpuB1dYQeIIaJde7ibZGqguXCqNsUvaElRMMJtnAKvCuL
         INpdPG4HtqlUCHIcSLheMW4paW45nOdU/LCpEb0yaeyagwcMPl9q5U2nO/r6yDSRKlZz
         6egLBICfPclxJWOCucPPbYpJfdH7cLCHw7usYOb1tw2hLA3O3HPLbwRXdZYsOfPOEKjk
         k0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645696; x=1789250496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HZm0ttASY7rre/2JxFqWxyWYHaZ5PaCtc1JLxshrQdw=;
        b=gnunapZpWUSm/WRlVsi8xkjwWrQvqDHk2Bo/0NxiHhKR6V2VaqpdcUI9Mhm4Ml77H7
         8LPq6sHMN4mJDg8FH/TqspLR1smfEZO9//tpaJeaw4/l1ZFbrq+Owa/rdEL6gL1OQSYU
         4LRyZ25QZyo6B3B7eZrASGail+eIxUZolcF0nAdG/tNUf3IsvK7mb5gUXDRwpD48k5KZ
         PUlWspx1Uj8SU4jKfiaimGiAALoCYQjS/0+45uXpFiomfsGtuyhWlvbQxarFkbWTM3DE
         n3u/ojs2Z+Gj785tMQ8yHokwI7twcGm/CUHsW/dox++ADX77+KrlSb0urh20w64c2+PO
         5KEw==
X-Gm-Message-State: AFuF++nrwXU+DlQ5AHUuy7bzReCwfuc6WeMpUE75R+Fr1xqMcCS+F9jX
	JAaV+0nOo4so4TFpJZYySpVUvyuAP5snDVmQ1IJzRSiucF+jm1dk4EULecHPOA==
X-Gm-Gg: AYBFou1FqMoyIpf+fb3XLFTbqPmQEDHIPjv42s3E1pWt0PyzU5Q+TXY3ed5E0jtZ/ej
	yVkVbCHp42dtp6ifXjMjjS+NUX/9nc7hRXYdYhYgIovS82mxloGZ0XPLm1dDAFmjTiSzVPCyeRh
	/GjoWLOJnRnvEl55DzFPxk9RmyO+1XAXLzKE2usUKqqF82ybwcNJl7VgTJD3IOxXEHJ5OcxLCFW
	R+OXdftU0IyjdfkMzGJDaiRx9d4mSLS8pWDCTivb+BO/+OtAPRTy4mL2arwzw8Z7JxuDVFUmXg/
	agJIlLcEyKX95hmli+I4d7FE6IAw3b9Qxnvrind9FFgJ1wAyMEbpIAFmi+762HnLw2gUbG3RoNT
	mFoFjkeOjpu8HcNO8N+TcV0Xhp/s1sC3ChvAusAHfSixwgG7+4lr3A1jQVMs4B1ZKPBvMe+plXQ
	sPQVI11fcpnNnIdbpSlkOScqPJsv8XOxhfHsONEIqjQ/JBCQwmNLQ=
X-Received: by 2002:a05:6808:67c6:b0:4b3:880a:f08d with SMTP id 5614622812f47-4b9622c002amr9184197b6e.11.1788645695927;
        Sat, 05 Sep 2026 15:01:35 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b970d200fesm6123132b6e.3.2026.09.05.15.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:35 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 11/22] bpf: Set MEM_RCU when generating kfunc argument types
Date: Sat,  5 Sep 2026 15:01:06 -0700
Message-ID: <20260905220117.922028-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BTF ID argument of a kfunc has to be referenced or trusted
unless the kfunc is KF_RCU, in which case an RCU-protected pointer is
accepted too. check_kfunc_args() reads that off meta->kfunc_flags on
every verification of the call, which is the last thing keeping the
argument policy of ARG_PTR_TO_BTF_ID out of the generated prototype.

Set MEM_RCU in get_kfunc_arg_type() for ARG_PTR_TO_BTF_ID arguments
of KF_RCU kfuncs, the way it already sets OBJ_RELEASE for release
arguments, and test the generated flag instead. Setting it on every
pointer argument would be equivalent here but would leak MEM_RCU into
arguments whose handling compares the whole arg_type, such as the
ARG_PTR_TO_CTX test in check_func_arg_reg_off().

No functional change intended.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f43462a43ee9..c5b394e847e6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12239,6 +12239,14 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	if (is_kfunc_release(meta) && arg == 0)
 		arg_type |= OBJ_RELEASE;
 
+	/*
+	 * A KF_RCU kfunc accepts an RCU-protected pointer where it would
+	 * otherwise demand a referenced or trusted one. Only ARG_PTR_TO_BTF_ID
+	 * looks at where its register came from, so leave the other kinds alone.
+	 */
+	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID && is_kfunc_rcu(meta))
+		arg_type |= MEM_RCU;
+
 	return arg_type;
 }
 
@@ -13174,7 +13182,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			    reg2btf_ids[base_type(reg->type)]) {
 				if (!is_trusted_reg(env, reg) ||
 				    bpf_type_has_unsafe_modifiers(reg->type)) {
-					if (!is_kfunc_rcu(meta)) {
+					if (!(arg_type & MEM_RCU)) {
 						const char *expected_type;
 
 						expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
-- 
2.52.0

