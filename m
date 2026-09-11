Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A885456DFD
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164278; cv=none; b=hyWtRdFRVWloV3W3Hqt50MdjyKZzOkz8LM9147BNNPrvaZD5l5PtNkIBJWsb2pDhrPygQ8fu0wLNIieTBaJrfr8Zc5cYQnZNjhwSHkVlf5leI4j9770MngXMGA10AsW+czJcC3hUsz3Kbmj2zNcx0HOKrXArdHysgGL3bOsrbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164278; c=relaxed/simple;
	bh=XVxLqx+dTRGTvU1GPqqw7wwyakxBL1XVId17AP70rTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nATd84w1Arl46W+xZ87qGwp7rKwlQojHAuUQ5iA/HEvZkipGYNTGSk7+k+E0sVcOhg9vFNmPDXViZMefuNQkOVOWQiaQJILWzMi4kqCFbnz8HsS9MQcFx1wJw4s4XUs00aXIjlOkyuehfQzvuEaQCH8aZkmPVvJx3MaQZoc+DYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7XVPBGq; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7XVPBGq"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7f4f0d37f93so42746a34.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164272; x=1789769072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=53Lwgmm1q87ULxFX/EFWkZKZ5abM86Fjo0BUNup3kaw=;
        b=U7XVPBGqq8CYfLke5yyIUg+gzDxxMgODNkpruQwYXYTiCCf95meOwfBI5E0NlJDjuZ
         H6dBHBe3FlKiNsFkYsTku3MGHZf9o0YHxIXNXyT8w3YoNdaVxxnve0OzXsHnl+0Af1vU
         H58/Cyf14csQVPIVDDpgbt4w6MvfVcvaNx6svHHm1t2lWWqxvSw+E/Uc3lKMAlwFCvK3
         fEm+ERiERlqNdE2Ur1Ud6qxUUUnp0U120kPPx7DaDiHJeIoXucNanNS8Vzt9JNXiNx47
         TLgTQqOfo5d4DswDeEGdzWpwntt7PZD4U6PXN8lhsduKM99kWT53zgfUGjkBEvpVG1vI
         sqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164272; x=1789769072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=53Lwgmm1q87ULxFX/EFWkZKZ5abM86Fjo0BUNup3kaw=;
        b=LLtLokC8F9m/r8c9B3gBl0m/qPm7hUWBAZVhGgvruzfWuYotmqPAAKtQgY8utKsmvc
         706TdUin05M9uhccBvRRq7kUx6YOlADkXjqeGAQ0aWbaRWazmPpWYsxia91xq7QUj1Re
         c5DudYcD+wtZlYAGz6jSa5o/F3j1Jbkl5v7riOQ/KLcQbV8iM+4w8P+tJqBv+4ZZPtDp
         vD5wRgP2qqQfcTPJbGYt14HSABDZCyAsXl8p+4U1xJM6FJJ2T1xYnoYDJxKA4LUWK/+s
         vwZBHvenPHiIepajeed525T773DZ9wcHYT19ACRkfZNr/xnCdBK1fTn28ExKM9rx2lpm
         5YUw==
X-Gm-Message-State: AFuF++kHCz28zvCf1UxRin5jLaFmDzGnbmYvUxXRrUFPyZCjsMCE9uI2
	78k7zx6mSZ1PodfjwVe8kTsUJLjoSpHFuCJjw0f8Fl+cyAVFxIuis2woBxXQ/w==
X-Gm-Gg: AYBFou0bf8cP14TadtvBZ8bJD1qYCksc79TOPQDa+3TStxt6sy3IGQWclSh0/PG/Gzc
	hNgieQodwJG3sqen9dFEKx0G532nzySxoRB6iYoXimjzHtvHQiPcEeRn2vJvvDhsPc5hrbV67GH
	rIABkYDDfH6lrYbuLwgHALVr9Bjv/OHzSbSRrZKAWEEm+tZLcoJNDsiTgY76csSxd2kRBxbBaLc
	3gu17BMe7LiTR7QjEV0lkhK71TNBaHHM1FwB/do84qMYwt32F/MyOl7Sq+51PtVdtduNG+XGj6c
	61uXHyQK9gXPZcEV0Gm5y3lQCI8atPXpHk1iA0qckZxAWrbi6WGSvQrqHklmoT7lkdqpLsKhZA8
	+u8HpLeGtSEiQplVtsMJbTKU1DFHdrZtYyxtw9I/rZ1IEfw+A4lVYOTHD/TVznh5C0y8nf/5LYG
	QeUQ4RvG61thDm4Z6MB2eo812NaiAisegCKnhvhnUrq1sb1guOUy4a6otsc9toUA==
X-Received: by 2002:a05:6830:3e01:b0:7fa:5c49:524c with SMTP id 46e09a7af769-805a01e680fmr176655a34.19.1789164272308;
        Fri, 11 Sep 2026 15:04:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f6d1875csm3668637a34.22.2026.09.11.15.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:32 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 10/23] bpf: Set MEM_UNINIT and dynptr subtypes when generating kfunc arg types
Date: Fri, 11 Sep 2026 15:04:02 -0700
Message-ID: <20260911220415.1396439-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dynptr flavour a kfunc argument expects is rebuilt on every
verification of the call: check_kfunc_args() starts from
ARG_PTR_TO_DYNPTR, adds MEM_UNINIT from the __uninit suffix, and then
walks a chain of func_id comparisons to add DYNPTR_TYPE_SKB, _XDP,
_SKB_META or _FILE. All of that is fixed by the kfunc identity and BTF,
so move it into get_kfunc_arg_type() and let the generated prototype
carry it.

Inheriting the classification also means PTR_MAYBE_NULL reaches
process_dynptr_func() for a __nullable dynptr argument, where it did not
before, and is_dynptr_type_expected() tested for any type of dynptr with
an exact arg_type == ARG_PTR_TO_DYNPTR comparison. Test the
DYNPTR_TYPE_FLAG_MASK bits instead, which is what the comment there
already claims to mean and does not care about unrelated flags.

What cannot move is the KF_bpf_dynptr_clone arm, which takes its type
from meta->dynptr.type, recorded while verifying the parent dynptr
argument earlier in the same call. That stays at the call site, applied
on top of the cached classification.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 47 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20e7da6674a1..c602007bf583 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -960,8 +960,12 @@ static enum bpf_dynptr_type dynptr_reg_type(struct bpf_verifier_env *env, struct
 static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				    enum bpf_arg_type arg_type)
 {
-	/* ARG_PTR_TO_DYNPTR takes any type of dynptr */
-	if (arg_type == ARG_PTR_TO_DYNPTR)
+	/*
+	 * ARG_PTR_TO_DYNPTR without a type flag takes any type of dynptr.
+	 * Test the flags rather than the whole arg_type, which may carry
+	 * unrelated ones such as PTR_MAYBE_NULL.
+	 */
+	if (!(arg_type & DYNPTR_TYPE_FLAG_MASK))
 		return true;
 
 	return dynptr_reg_type(env, reg) == arg_to_dynptr_type(arg_type);
@@ -12227,9 +12231,20 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		arg_type = ARG_PTR_TO_ALLOC_BTF_ID;
 	else if (is_kfunc_arg_refcounted_kptr(meta->btf, &args[arg]))
 		arg_type = ARG_PTR_TO_REFCOUNTED_KPTR;
-	else if (is_kfunc_arg_dynptr(meta->btf, &args[arg]))
+	else if (is_kfunc_arg_dynptr(meta->btf, &args[arg])) {
 		arg_type = ARG_PTR_TO_DYNPTR;
-	else if (is_kfunc_arg_iter(meta, arg, &args[arg]))
+
+		if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_from_skb]))
+			arg_type |= DYNPTR_TYPE_SKB;
+		else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_from_xdp]))
+			arg_type |= DYNPTR_TYPE_XDP;
+		else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_from_skb_meta]))
+			arg_type |= DYNPTR_TYPE_SKB_META;
+		else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_from_file]) ||
+			 is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_file_discard]))
+			/* OBJ_RELEASE for the latter comes from KF_RELEASE below */
+			arg_type |= DYNPTR_TYPE_FILE;
+	} else if (is_kfunc_arg_iter(meta, arg, &args[arg]))
 		arg_type = ARG_PTR_TO_ITER;
 	else if (is_kfunc_arg_list_head(meta->btf, &args[arg]))
 		arg_type = ARG_PTR_TO_LIST_HEAD;
@@ -12308,6 +12323,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 	}
 
+	if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
+		arg_type |= MEM_UNINIT;
+
 	if (is_kfunc_arg_nullable(meta->btf, &args[arg]))
 		arg_type |= PTR_MAYBE_NULL;
 
@@ -13128,23 +13146,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			break;
 		case ARG_PTR_TO_DYNPTR:
 		{
-			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
-
-			if (is_kfunc_arg_uninit(btf, &args[i]))
-				dynptr_arg_type |= MEM_UNINIT;
-
-			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_from_skb])) {
-				dynptr_arg_type |= DYNPTR_TYPE_SKB;
-			} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_from_xdp])) {
-				dynptr_arg_type |= DYNPTR_TYPE_XDP;
-			} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_from_skb_meta])) {
-				dynptr_arg_type |= DYNPTR_TYPE_SKB_META;
-			} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_from_file])) {
-				dynptr_arg_type |= DYNPTR_TYPE_FILE;
-			} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_file_discard])) {
-				dynptr_arg_type |= DYNPTR_TYPE_FILE | OBJ_RELEASE;
-			} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_clone]) &&
-				   (dynptr_arg_type & MEM_UNINIT)) {
+			enum bpf_arg_type dynptr_arg_type = arg_type;
+
+			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_clone]) &&
+			    (dynptr_arg_type & MEM_UNINIT)) {
 				enum bpf_dynptr_type parent_type = meta->dynptr.type;
 
 				if (parent_type == BPF_DYNPTR_TYPE_INVALID) {
-- 
2.52.0

