Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814F34252B
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645697; cv=none; b=VdcePIqXG3z3q8OPzxBGPHtMLi41cTWinhvNQlG0/wx3H24k59kNDQyrp5S036VvtVlGT1ErbCLH+8vWFcspv98v6qfFRI8TzY0GgNcnMObqb85clmtTJAy5lZ6vYtjgfaheicOJrbH3uT5Xclr67u54H1UuNvV6DqdDU53LEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645697; c=relaxed/simple;
	bh=Q7Pfc1Ad521mTE/Aqk1fmAjOO9toj/ACDaPAXOpH/F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHj6GLlCCkNAkWGubHfDOfhrV8K3qqbvzg85GFhIJSUaF5NHE/ykN2wUNGlROfBSbDhcYtcc9ADtubMa6TRNS/8TAaV7/d2VBJM2QFsM2TpM3Kap5SSVPEEp6ICVT6HIEfLVQAfrP9BKkdDX4lID19tYwi7RgQj8gZDkkL3hOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nven19uW; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nven19uW"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f84a55e31aso1750723a34.2
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645695; x=1789250495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZC64P2NumaOLf2Tr2iK+YX+7Bmm486ZhLBPnk0J2JB8=;
        b=nven19uW/Nuw57qXnmA9s9m9sYzaYt1zM6SiZQFbvkZ0Y8mRZiqCUDoVEz9QAxnjca
         Pyfy8PWYEuREwljc7OPfmdKxcfRyhnIsCuRXwn4siy8tgcBmAyP/RxBxbQDS44xAxQql
         QRVYydQHXI0QDVkj1Nnq6Or/zojIcElT32hz5UafvKP4QGhkT6dBrDanO5M4uPRHxMmG
         e/V8fl7iCkF549qyDSUMkxi++cnprsadvD7haDPsL50Ee4QWL9XFLKCWm3SH1QRXN7cM
         Th8eYnD0OX7Ly8LwHLei9UmlDhEJwRUnqVW5SOEhN7WsUPxqNTn7zDj/vZw4uPKcemdq
         m4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645695; x=1789250495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZC64P2NumaOLf2Tr2iK+YX+7Bmm486ZhLBPnk0J2JB8=;
        b=BsDx8/MuhlUiYL9MQrjnCz6iqjNnZJV3REolU+93OCPA+NbgNq2UyFgb3yMqfWRvsa
         h5dBFZlFuZmgIB6cFfh8enwtU5aHRLRtTw8sDqnyoQmDk4sRqYalzcsqrXe/uc5nsAf6
         JMPlegqJR3+s3sbGUAHGH5CZXZtIXRtA0YFLASEaHM3Va3dHF7Kuo8+myGM7NhiVwX6T
         ZQFOKXWERKiH+Rabl888QwYvM73Af/ULyi/yO2DZuGhXN4hprZpPSmLzt9axHWWGoXvs
         cL1mDWyx7sP+eS2UHQzmXvVc8MlZTYYwV9V5rGpMK1TJzHo7hX53n0vDKmbsJrW89qEk
         zGQg==
X-Gm-Message-State: AFuF++n03JW/DKIbyyYC99tbW5GIm4woh7Z3kEOP/XdAUBdr56q60FAS
	mCf8IJSwEZcZlXUiGcgYJnJGp+SfbljvHNC3ZKLfgjDOFmd1Rf3qfFwLmBsixQ==
X-Gm-Gg: AYBFou2Tyh6kFD8nLILMFm1zYBhZVXw6pr1sO+1EiU4P2qrYp4/i0CiFZXZ0PwsQyhE
	dLcGf8FQWssl86hjYyw7wKapKvXAk8KKqKw8v4gmbyT5gCYYrCFqxsHT0RGS2OScnOCOBCC+DQQ
	cs5oNYJVScb9wOqId0V3YPhKwZpor2jh1ElMczMIfzU+Lwr7d/GwoivK0axRqahH0CJy+xWBaIt
	j2Gj43aJWlf4XIPGWWWvvZhR+njUUs4FYz6zn81yBF5HoF/lLRKVkuuSdbB0ed0YmiBfcdD5E8f
	wRFxtZ1IGqiBsSP8c7IWPJBXFBLSS3pbaOC/Upcv/6TunhOH5xlxRNPFM+X4RyPQuFRgb4K/v3e
	E2IzrUkvO1hUSRuQj59FTHPTgyBm0Yc758xEgRikTEjCCgVKL9gd9HXHTx5GS/6vZ1UnZAc7Xx/
	9XUWitqpYePtFy80+SeymP3Xc4f6K/fLzNgn3tJyHczQ8t/lS0eIA=
X-Received: by 2002:a05:6830:6385:b0:7f4:daae:401d with SMTP id 46e09a7af769-7fa1e7d967cmr10284589a34.8.1788645694588;
        Sat, 05 Sep 2026 15:01:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f7aeac18sm7152730a34.25.2026.09.05.15.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:34 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 10/22] bpf: Set MEM_UNINIT and dynptr subtypes when generating kfunc arg types
Date: Sat,  5 Sep 2026 15:01:05 -0700
Message-ID: <20260905220117.922028-11-ameryhung@gmail.com>
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
index 7662293ac7d2..f43462a43ee9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -951,8 +951,12 @@ static enum bpf_dynptr_type dynptr_reg_type(struct bpf_verifier_env *env, struct
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
@@ -12130,9 +12134,20 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
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
@@ -12211,6 +12226,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 	}
 
+	if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
+		arg_type |= MEM_UNINIT;
+
 	if (is_kfunc_arg_nullable(meta->btf, &args[arg]))
 		arg_type |= PTR_MAYBE_NULL;
 
@@ -13027,23 +13045,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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

