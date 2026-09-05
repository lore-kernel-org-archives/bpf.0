Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5C349CD6
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645702; cv=none; b=aME+PQXuyfTQiGeYpAPFLX2SPN/GNQR8KoKze7dhZjDbDkxL7Nw4VSi8SPms46IOKnU7k4XeoVuk/TXdwYzvpFZXtR7mUTTdvZqPM5dQKBDPywsqrtTeJ2uzd85UODH7FSgc5WUBwRe7kvP1Wb8yGWNx++MbPr4KUPLkMEe52yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645702; c=relaxed/simple;
	bh=qjeOHspToQKh3Fk2OmkJJGHDpGJ9tgTm+kEQL4I+Dg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gILUzSTUf1HCB2aKZ9bH3HKUfuKqDAhmWH7Oithxszqj1U7vJvtgz+moU4Qo+aKKZSAVeNp3E5WKBmnSo9BPlVwj8LO+wJcYz0/l8CKXpApTqR3qUI2JMq/UyVTHPdVvDM+aSr9go093rvBzk+eHMvGRv2r4ewmS/K1NHgKywxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEmReig8; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEmReig8"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b28df1f600so1886979b6e.2
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645700; x=1789250500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x4gQN2xiRz5NCoo5UCkMAIrLZf11ogJ/BPl8VQy9h2Q=;
        b=CEmReig85GD46Rv8c6Rx25VOepzbM7ck0NhFrNwGIbLtSgoVFU6YOxueXq4gPgsg+B
         XRtGDESsCMdvdkOor2qpIWxE/F35cfjZiVkvlx/RDGpgVv5yumB1gOZBQI5l4Zmg8bug
         ZDkPHukGxPBXPN9cdWquw9g/QMfvVmpozeOu+5McAfSC8CEemT+2KXKH+sfgRJ2UAo92
         oUHaIrG25RPj4pd0cm22593xiFXmxOggIMUqYpG9arHn6/xHbLpDZrrQdEwW7PIo9VPQ
         Ay4MZq8R/N1altV0NXwcI0ls0VQTbhzjFyH47v8c0ykw7swKe6A55b/bP6cv60Wh93tC
         DpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645700; x=1789250500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x4gQN2xiRz5NCoo5UCkMAIrLZf11ogJ/BPl8VQy9h2Q=;
        b=Law3W9V/79jlQza1PUnR1BqD252xSLBJTlXUlvM+vWHGMuLklbCOv3OobqJv/79bIx
         uIEMbPn1pODRUUz2x/5gCFe6fZOAkijDvY3M9aXV0C637aMrpkYsAvnimLvZUiKZ9525
         bxHSH9I7CF/eGagGb1jNrXSMSwlXIYp1SUKPKm9eS+DYWp4UXlzjMicDEed+ocDy5Vme
         XGz17aCFgy0V4reGhwAEEAid0qE7BghxmJSuWyzSb7V5w4qzothXI57+wTcPV20QPGZV
         Muq95HNGr9xuNfun8fqqNFfH4poPZsVao2kC2XFWcNoTAmnIWEm07XWSa9Y+ct7jhHmV
         5K5g==
X-Gm-Message-State: AFuF++k4HkOqhVY70vpSgB1UCaMvz5EnFbt/BqxWxmiso+2HaGDAYX8E
	6x6ZAU3B1bkk1ZSKE2lightJsO0vgG0dwEIkIJPWS2JPqe1Y13Yfy1OOuzBg8g==
X-Gm-Gg: AYBFou2JiKXKwHsMSZvfogoPUFVr7AmaIonzIC53V6xut36+K+jfHBHc8C9A5EM+4+H
	t00AGgyXavWuTqsJs9Q+fXtbE+gxsJZT6Gtxm8qg6GNI415+D6+iSCZV+VaUzkszFrpdp6AnbPY
	0WZ/KwdWh+4G5DrfMsX0lLJKKpPRXzDdyyrmxl+UsWe/beDNrBcVXhIA4gcWuVhd4LQXay3+chM
	6w5dRRrxK7782St9mWwS3gS07/K80AqWCuhCSDhrdHPIII3dpsodNxZ6Coo2IB7h2kFqEpUps5w
	aWvSHgu5qmbp77Xg/2UeWUO9Bzs0ZORgiVZYOzr2XG/NfvJTzM4t9vHKVTJlK2w+BbBbsK+YfhR
	PQYMZO8l/4Ek2r+KNHB1aDfOeDYREG++Icmt1ti0/0yMBI5fOHgJs5oLjT9IXdSDKvyevG1Yalb
	v5J7neHLKUXaBnqrp38C8Ks+SHVebJnPZzgnIN/wFVQ2tD1bwVgFlnKSW1DCLvDA==
X-Received: by 2002:a05:6808:1242:b0:4bb:ac05:9ee0 with SMTP id 5614622812f47-4bbac05a175mr1668035b6e.13.1788645699596;
        Sat, 05 Sep 2026 15:01:39 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b970d1cf26sm6562340b6e.4.2026.09.05.15.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:39 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 13/22] bpf: Resolve ARG_PTR_TO_MEM | MEM_FIXED_SIZE size in kfunc bpf_func_proto
Date: Sat,  5 Sep 2026 15:01:08 -0700
Message-ID: <20260905220117.922028-14-ameryhung@gmail.com>
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

A generated kfunc prototype classifies a pointer to scalar memory
without an adjacent size argument as ARG_PTR_TO_MEM | MEM_FIXED_SIZE.
The kfunc path currently walks BTF and resolves the pointee size each
time it verifies a call. The common check_func_arg() path instead
expects that size in bpf_func_proto::arg_size[].

Resolve the size when generating the prototype and teach the existing
kfunc path to consume the cached value. This prepares fixed-size memory
arguments to move to the common checker.

arg_size[] shares storage with arg_btf_id[]. An ARG_PTR_TO_BTF_ID
argument that falls back to scalar-struct memory therefore keeps its BTF
ID pointer and continues resolving the size when that fallback is taken.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6e36df72d13..2e068c095436 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12085,11 +12085,11 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		   const struct btf_param *args, int arg, int nargs,
 		   struct bpf_func_proto *proto)
 {
-	const struct btf_type *t, *ref_t = NULL;
+	const struct btf_type *t, *ref_t = NULL, *resolve_ret;
 	const u32 *ref_id_ptr = NULL;
 	argno_t argno = argno_from_arg(arg + 1);
 	const char *ref_tname = NULL;
-	u32 ref_id;
+	u32 ref_id, type_size;
 	int arg_type;
 
 	proto->arg_btf_id[arg] = NULL;
@@ -12232,6 +12232,15 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
+		resolve_ret = btf_resolve_size(meta->btf, ref_t, &type_size);
+		if (IS_ERR(resolve_ret)) {
+			verbose(env,
+				"%s reference type('%s %s') size cannot be determined: %ld\n",
+				reg_arg_name(env, argno), btf_type_str(ref_t),
+				ref_tname, PTR_ERR(resolve_ret));
+			return -EINVAL;
+		}
+		proto->arg_size[arg] = type_size;
 		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 	}
 
@@ -12888,7 +12897,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		const struct btf_type *t, *ref_t, *resolve_ret;
 		argno_t argno = argno_from_arg(i + 1);
 		int regno = reg_from_argno(argno);
-		u32 ref_id = args[i].type, type_size;
+		u32 ref_id = args[i].type;
+		u32 arg_size = arg_type & MEM_FIXED_SIZE ? meta->fn->arg_size[i] : 0;
 
 		if (arg_type == ARG_PTR_TO_PROG_AUX) {
 			cur_aux(env)->arg_prog = regno;
@@ -13265,20 +13275,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			 * If the register does not contain btf id but the argument type is a pointer to
 			 * scalar-only struct, allow verifying it as a fixed size memory.
 			 */
+			resolve_ret = btf_resolve_size(btf, ref_t, &arg_size);
+			if (IS_ERR(resolve_ret)) {
+				verbose(env,
+					"%s reference type('%s %s') size cannot be determined: %ld\n",
+					reg_arg_name(env, argno), btf_type_str(ref_t),
+					ref_tname, PTR_ERR(resolve_ret));
+				return -EINVAL;
+			}
 			arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 			fallthrough;
 		case ARG_PTR_TO_MEM:
 			if (arg_type & MEM_FIXED_SIZE) {
 				bool known_memory;
 
-				resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
-				if (IS_ERR(resolve_ret)) {
-					verbose(env, "%s reference type('%s %s') size cannot be determined: %ld\n",
-						reg_arg_name(env, argno), btf_type_str(ref_t),
-						ref_tname, PTR_ERR(resolve_ret));
-					return -EINVAL;
-				}
-				ret = check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRITE,
+				ret = check_mem_reg(env, reg, argno, arg_size, BPF_READ | BPF_WRITE,
 						    meta, &known_memory);
 				if (ret < 0) {
 					const char *expected_type;
@@ -13289,14 +13300,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 							env, insn_idx, argno, func_name,
 							"Pass memory with at least the required number of accessible bytes and suitable read and write access.",
 							"the kfunc expects %u bytes of memory for %s, but the verifier cannot prove that %s provides a readable and writable range of that size",
-							type_size, expected_type,
+							arg_size, expected_type,
 							bpf_diag_reg_type_plain(env, reg->type));
 					else
 						bpf_diag_call_arg_fmt(
 							env, insn_idx, argno, func_name,
 							"Pass stack, map, context, or other verifier-known memory of the expected type and size, not an integer cast to a pointer.",
 							"the kfunc expects %u bytes of memory for %s, but it is %s and not verifier-known memory",
-							type_size, expected_type,
+							arg_size, expected_type,
 							bpf_diag_reg_type_plain(env, reg->type));
 					return ret;
 				}
-- 
2.52.0

