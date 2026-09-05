Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FCD14A619
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645694; cv=none; b=SwDbsFQmqKLcnLLWChMMR0aIATVvghas+4U/c/40jTdSudjPdzkbmSBiBJ+pSMMtsnChxNgl6BlcXusEkZ5AQaTtb/51m1RsifEP8fu45/sFprQVRgsZ447DJYNqrtGInJySjvNImq8ogckImqeS5NAklctWpaK0zkOawH24mq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645694; c=relaxed/simple;
	bh=oetYajvIg6ov0h1rOXlJQ4h+5pt3Ah7G1NRnJNRLLa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8FlTu+cOsCVfF9sj6UA5S+G/xK9AVwZVxd3Yespop5wcYsB+FR2x/Wi+zHG2xBR7yDlOpxokpuhf335OtCCnfF2UqOzzxV0r6qxGUfemMZHaXWDdOmazhhB3vZQwxaf76+vGrEGc1GR1721Yf6JLeTcSQJnGwEV9t4LROVwltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaoxAYGI; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaoxAYGI"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7f4ea388ba6so2351703a34.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645692; x=1789250492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qT5Roaod8XbVgUQqldYwKGUlkGgdWm753VGgOMrU5L4=;
        b=PaoxAYGIYLTXqnpJfFHVP3Kkr2f+FGx9B9wuhoZ1OSqOoiYSbzXT39Be2Guydz76AK
         L/rzbMNZXgGq9BdQ0Zocw0FMx8Zh1d+rPMTOyCHrI3h7ktXgNc+DrFomjnrEUBruLIMn
         0Y0flcxMs7WOpJZeeZlD7N9pJ09vURCTdXhZxlj51Mf9o60GgP8JBTxnT/wyQ+Qj0HGI
         tjSKLr6q+DhHe1iPX31rrQpkW7VdIVN26DwH7ifs7m7nyMmFGCf5q18mS3wAOlfJ2nUc
         JNPdb3BHd/uahCltqQGNqY7ejXlBg51XTaPuqJtYDMycIFGQ+HiqXWxOMOCfc+DAhCiU
         O2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645692; x=1789250492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qT5Roaod8XbVgUQqldYwKGUlkGgdWm753VGgOMrU5L4=;
        b=pAigHVEgSI0witCyZW65sqfcOr4kYftgUH3qFv7PLQJa04CnzFpwf7WbbbhkdywUya
         wpc4jvekHsdCa47t+Snarn/Gbx6ZKhc9nRdsWX/Q0LcM4x9qfD5i9N5rDl8+7P4xaceh
         KAyQ/mInr+P86i0YoeGVESi9Xtd2TQLBdKPNrId1KxH8QkXlzv3sUkyEBexi1hJesPmg
         rkeWyCRo83jHtVvMZ44seDKP++umCjKjWMIpNWx/U2gDCDesmg3LeWMm89cAnpYmad7/
         9tHeqNtH4H4QThMvLAgNyw0cu/ppQH1gSIxgv4sQqA68BumKg6G2nlInaEL1djJRaKV9
         Sztw==
X-Gm-Message-State: AFuF++nPVC588teggVn8vdSZywaUjYtIR0cZyAhUZFz3THJTkGTsPFgc
	l5osX0sPcyiYoKqttmZEbBm4alkInqU5xAuKXfgm47KZofrrZ4QPNL1qphwwCA==
X-Gm-Gg: AYBFou03BM3BqDBaSF+n/mg13iUeo5IluMiioATKuvk8w1hvyim04Y8VuHcf4jtxBdA
	mmMp1PCK+v76wfAbdCK1GSqj9hZP7KXM80Jsw5d02AEpLfU6JBc3BLXoIajwSdsEFVbC8g8fOwY
	IkZj7i0rcXUkgH4ew4Gxih3P56IH8nZWNvJ5d/b2dXR0GR9wRpDKYQDwrzzWp6OXPp+MfGsc4Vc
	zI9klZ2gj/GdgSpd0mgByVeE1JtQtBxz/OM0Zf+85RWYT3Ey5sUo0+fhfEcL6XleXlp4VWS1n/a
	Rgj5ymM5ec17v4t3ORfOm5YwwLuc51r03vCRz9XIRYfp9daC8dA6tZobhlwOgmBuvPmKVOj/L90
	0CZRtLn6wav0vTAQq4tPp6Pg7DfLRW1lLR0btuXwDnjDv26yO3PA46S1tDy/9UKNYpii5AsFOXV
	THn0rcpltZ5YqjXf1zIU2PCHFvbR6biAYi7lSudREAlnmE35FkGu0=
X-Received: by 2002:a05:6830:82bb:b0:7d7:d524:bc88 with SMTP id 46e09a7af769-7fa1f420061mr10848857a34.10.1788645691702;
        Sat, 05 Sep 2026 15:01:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f1b06b7csm7123975a34.0.2026.09.05.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:31 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 08/22] bpf: Classify kfunc arguments the verifier ignores
Date: Sat,  5 Sep 2026 15:01:03 -0700
Message-ID: <20260905220117.922028-9-ameryhung@gmail.com>
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

The verifier does not inspect __ign arguments or the implicit
arguments of a KF_IMPLICIT_ARGS kfunc. get_kfunc_arg_type() leaves
them unclassified, so gen_kfunc_arg_proto() skips them and
check_kfunc_args() repeats the same BTF predicates for every call.

Add ARG_IGNORE and classify both cases in get_kfunc_arg_type(). The
generated prototype can then record every argument, and the call site
can consume the recorded type without deriving the classification
again.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 547703f54a89..1f78746e0601 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -923,6 +923,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_IRQ_FLAG,	/* pointer to saved IRQ flags on the stack */
 	ARG_PTR_TO_RES_SPIN_LOCK,	/* pointer to bpf_res_spin_lock */
 	ARG_PTR_TO_PROG_AUX,	/* pointer to the caller's bpf_prog_aux */
+	ARG_IGNORE,		/* argument the verifier does not check at all */
 	__BPF_ARG_TYPE_MAX,
 
 	/* Extended arg_types. */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 22f5aff76b40..7416f1e16aa9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8797,6 +8797,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		cur_aux(env)->arg_prog = regno;
 		return 0;
 	}
+	if (arg_type == ARG_IGNORE)
+		return 0;
 
 	err = check_reg_arg(env, regno, SRC_OP);
 	if (err)
@@ -12086,6 +12088,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
 		return ARG_PTR_TO_PROG_AUX;
 
+	if (is_kfunc_arg_ignore(meta->btf, &args[arg]) || is_kfunc_arg_implicit(meta, arg))
+		return ARG_IGNORE;
+
 	t = btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
 
 	/* Scalar arguments are classified from their BTF suffix/name alone. */
@@ -12215,7 +12220,6 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			       struct bpf_func_proto *proto)
 {
-	const struct btf *btf = meta->btf;
 	const struct btf_param *args;
 	u32 i, nargs;
 	int arg_type;
@@ -12234,9 +12238,6 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 	}
 
 	for (i = 0; i < nargs; i++) {
-		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
-			continue;
-
 		arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
 		if (arg_type < 0)
 			return arg_type;
@@ -12844,7 +12845,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			continue;
 		}
 
-		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
+		if (arg_type == ARG_IGNORE)
 			continue;
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
-- 
2.52.0

