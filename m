Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377576;
	b=XpnkFU8pDFGfRjRdRdv42me8GMPy5zbq7oSNG/OR1EaMRoNanVEsdyDhcnNB8UD2+ZYM
	 f1bj5xMfl6ENjmGwOrleXcu8f+hCWO20S256jsKDCfyfmcJJKMIC/OVcc2lRta9MDJmKp
	 0cMEM1wIakmgWA0bI4V3+2BAQg2jF+D84CHnZl6Xrm4IRJgOZkF4JUddfgUxcz16GEfVO
	 Ooq3aP+i2rVBgI/zmzh9KD1wLSWZ5BZDxzAQ+beiI6awLE+kSgw1iSvzFJ/BZdiMQm6S7
	 NGwRySbp737gDEg/Hu9zunBamtxdTtbtJbmplD0+EoJHTzJYmu+mzm32AVsSHnxmBig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZPDV0npw/bszjt84ro/ATUjh6/JnCi7B6sVa2TSRMfo=;
	b=FwY4Ico7gvLB8BujxUOdvY6d19w2RWjIOTsZNEgM8IwfLYCLm2V4WahBlc411oOQ54VF
	 V0kuD88+BKB2CarDqPWv1W66YdgZO9CH5ZBgaV3AP3dqK01g/nShipTSsQ2iOkLITXOzj
	 ZILE/VBA2heQIw77SI4G6wSoHkB1GEVWWkL0gKNClOrgZ9aMGAYACXgo4VExWs6KA2cK7
	 3dUOAo7kvt3hXq6TDcY6SPsj8Yv20iqwfU/xADkDoqGG7eyDDdJpyHQkSAZNoviyJ++Ph
	 PJqM+PEfUFGSyATHOCNZ0PkpTRcdP0i+oqG8xLOKiVb3DO7ve8PjQmbDLuxHNp2HK0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmv5l8WD;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB532606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 16:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB532606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmv5l8WD
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-89f85edd210so371487b3a.2
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793377575; x=1793982375; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZPDV0npw/bszjt84ro/ATUjh6/JnCi7B6sVa2TSRMfo=;
        b=lmv5l8WD8HOsiBxxfl9Ygx8dENnN5JkG56tAVyK7jc7O6PznodthPlRjLMqtxmulVe
         IDEfzeAMqFBnxXQMbBi2WTpvmOVlTQ2p8FUFU7wMiAUlXEROvcxSyDBvU2Z4yE1gi0h6
         nPYDeLIE7CSxLEB52K5JIm/4PkXrwt3In+X2/i3MGDSeTzSACdcDbKNYxNmVs5bApeHH
         6rab5X/tG3ImPW0Hac5/QTnSXdLM2xtoJLKWG6JAjlCcCDsfoZkFf+rKNJYYblrQ8sVe
         +RynVsKboD1c3eqqwWR3/yOMnzAmUy9FOaCjMAu1rWsHQez6MntSbhZ0WTe84jKzTbcR
         D+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793377575; x=1793982375;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZPDV0npw/bszjt84ro/ATUjh6/JnCi7B6sVa2TSRMfo=;
        b=pxCGv3rRiAddxKVviATlzCRagashU0eT5Yp1vKmenrNOp5FXrGY1LtsEuMQvpgpE2a
         /YPLf3gJnGKuV76tPeEuFDZFNnFnln87Z72nHusWygvdVzIjizwq5asjkQ4dH9IN7nyC
         ytDuP4CUo+DJBwTAoVJLTtViA1CgbeEhEvQENx4H2E0yby/PPq/0CGExsrDbmsItSH9w
         Cs771BoYzG83sDsDSCX00duLHTLVOWtXozwem+NepXCOvoHHX7/GwmlaDetc34HUZRT2
         UKvzeXg88PK6EEa6HXHjQnYZkjBgfkwr4cagYlluwvYt3m1Rb9r7kIeZ+kwJ+8majhw7
         blcA==
X-Gm-Message-State: AFq9FYJR+dozjWR/+AIBta5P8MV7C2kDLib9mZz1CUZwCGELZabpEGa2
	ddSzwGLRZAs6UsgYkSOYOs5RsaA8w959/m3ewMBhm0j3jiZwnWlYpdCE
X-Gm-Gg: AYBFou2tafR65ks43r/JwvnAWa3uP97lRqDQqSMIJPGLMzdmS0Vouyb8C1xUQ+XfsnZ
	KNhUwJdOiVlgZyW/0YVJNfnkq8jGlb0pDSrUadp8DZW4Ec70EHDC5ujrw3JlpGC7h1cdE0Z/6q1
	rPWcbSqZ89O3QYprAAWHKtiqiKdSwJhpeu2zRTtfmh/G2p9FAQ0LwfL2Cw/fcyjeZsms9OJ357g
	22dQkSScVXPK60HMmmST9LT1s2q2ggEvsEyB8QpxiveMf5BUs7LUhzTBAL78ACsAg4UQQoBSv0d
	4h9fH5GrL8y7JkcwlMj0Je9C2nxad/XuyY0faXB9GIYX2+odr+WG7Kn/20pipkqLxRtg5wLGZn5
	RtB4l0aZ17Saze6i48+Tf7HXaJHOx5LVBgm9aimv1nUejicHHo6nQ1LXcywOadAV4yyasfCbtLB
	Nz7VnRJw80SevzpCLl413btFavcjoOUMzi2O6+IZvBzyIA9ARg0bJyls2REQxh3u8Ka9JGYyYdy
	iEoLFfy9OLHhN6Ck3dD7F+NuJ5+PkjdyU6eJoAul3E4321iY+4dpBtXApFjSF1ef63eW97nQs+d
	8NImRxPODn2HFe1/kNJ0isEAc8szTVBHTNUkyNkYpWa7cxdAUv0LABovMrA4/2EzjqdYX8PmeT7
	jkP3oRmwxjfb6XBAfRykbD+zwDZtO3znaxw==
X-Received: by 2002:a05:6a00:a882:b0:8a0:76ea:36e0 with SMTP id d2e1a72fcca58-8a9bdebcc2amr2143970b3a.40.1793377574776;
        Fri, 30 Oct 2026 09:26:14 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d03424sm225749b3a.24.2026.10.30.09.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 09:26:14 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 16:26:13 +0000
Message-Id: <DMIBAJUQ3JXD.2PRX3U9I7T2AS@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-mm@kvack.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Federico Di Pierro"
 <nierro92@gmail.com>
Subject: Re: [PATCH bpf-next 1/8] bpf: Add __srcptr kfunc argument suffix
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>
In-Reply-To: <20261029212551.56964-2-jolsa@kernel.org>
References: <20261029212551.56964-1-jolsa@kernel.org> <20261029212551.56964-2-jolsa@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 29, 2026 at 02:25 PM Jiri Olsa <jolsa@kernel.org> wrote:
> Generic sized pointer arguments are treated as writable memory. This
> prevents kfuncs that only read from a source buffer from accepting
> read-only BPF memory, such as const data.
>
> Adding __srcptr to mark pointers the kfunc only reads.

+1 to Andrii's point re: const.

An arg name has one suffix, so far, so __srcptr cannot mark
'const union bpf_ksock_addr *addr__nullable' of bpf_ksock_sendto().

Tentative patch:

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 73578a4..54d4ce2 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -137,6 +137,10 @@ argument as its size. By default, without __sz annotation, the size of the type
 of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
 pointer.

+The verifier checks such memory for read and write access. When the argument
+is a pointer to const, like ``const void *mem``, the verifier checks it for
+read access only, and read-only memory (e.g. ``.rodata``) can be passed.
+
 2.3.2 __k Annotation
 --------------------

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5601d20..612603a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13217,6 +13217,22 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
 	return btf_param_match_suffix(btf, arg, "__szk");
 }

+/* A kfunc only reads through 'const T *arg'. The compiler enforces it. */
+static enum bpf_type_flag kfunc_arg_mem_flag(const struct btf *btf,
+					     const struct btf_param *arg)
+{
+	const struct btf_type *t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	u32 id, ref_id;
+
+	btf_type_skip_modifiers(btf, t->type, &ref_id);
+	for (id = t->type; id != ref_id; id = t->type) {
+		t = btf_type_by_id(btf, id);
+		if (btf_kind(t) == BTF_KIND_CONST)
+			return MEM_RDONLY;
+	}
+	return MEM_WRITE;
+}
+
 static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
 {
 	return btf_param_match_suffix(btf, arg, "__k");
@@ -13585,7 +13601,8 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 			PTR_ERR(resolve_ret));
 		return -EINVAL;
 	}
-	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
+	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
+		    kfunc_arg_mem_flag(meta->btf, &args[arg]) |
 		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));

 	return 0;
@@ -14137,7 +14154,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
-		arg_type = ARG_PTR_TO_MEM | MEM_WRITE;
+		arg_type = ARG_PTR_TO_MEM | kfunc_arg_mem_flag(meta->btf, &args[arg]);
 	} else if (btf_type_is_struct(ref_t))
 		/* A pointer to a struct without a size argument is classified as ARG_PTR_TO_BTF_ID */
 		arg_type = ARG_PTR_TO_BTF_ID;
@@ -14162,7 +14179,8 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			return -EINVAL;
 		}
 		proto->arg_size[arg] = type_size;
-		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
+		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
+			   kfunc_arg_mem_flag(meta->btf, &args[arg]);
 	}

 	if (is_kfunc_arg_uninit(meta->btf, &args[arg]))

pw-bot: cr
