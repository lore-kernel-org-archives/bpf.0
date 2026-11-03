Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729004;
	b=uFdoMI+en/RdJkvIB7ghjx0tlvlZAbogiX3yuja92zoYuoi2k9TzzvYeeuIH4IyX2VLe
	 wyFcLl+WsQwSUO1UtYiPgtwxUAIE36xVrW8RLTziMv4X8gz7lHgsTv1oHnYdGK1DBoLqq
	 ASW5bAE7vQ4oS7+q7f7EES8/oc2lb0aZybEYsWHSjmw6GY0Z9eekVOoY095b0Ydg1xxYD
	 RmVqR4Wih/8cUBKZ4N6SUlefA2kIOFJMfYoNzOo6y8QjIe2b3ENf9wmwCfq/93OaBYNqK
	 cEGnaynUv7p5VWz2GSVoHyLTqT0zZFlX25kdAY/jWfOvsu32nc9V56BMnz4Ft8QBqGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QlGR/Z6huNBqf7qPxyYVqVaOp44Imd+irchLTr/i+qo=;
	b=go4BMOYwiYlYkqF33TCF8i4O8BOYzNVWl6aXfN3QtEjZiMMwJ+lJlejATQ092miJqWEI
	 bV2Emo3ZQ6VbpzjixKa6attYh+vB7TxulWUan31CkT5K86lc3G91LCwIWCTUJEO1wb2Ga
	 a/B7sgFP0IXi9LuJzzNTh90jss73Okl0e7hvax8QfWooqi2V25IrXP+KWGIbYEzoWyv5Z
	 mYn1ZYjMWO9BXVK2RTTQz1Aqr/TG4kVZTdYPijAv2X1ZXJrmdcsz79t5lLKow/i2MA9dT
	 CCxuSB98+hTkaK7kUe8cXIZhiNuPBrB0QBcpAogu7+bbSe8MpvKaGdJeDg/I9M7WnYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0hiDjsEE;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD01606A328
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDD01606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0hiDjsEE
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so2988736b3a.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 10:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729003; x=1794333803; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QlGR/Z6huNBqf7qPxyYVqVaOp44Imd+irchLTr/i+qo=;
        b=0hiDjsEEpn9j0ZIQpW5CA0+dO1x89/+ClvWhR84pcN5M0bybnZEfTk/MtjjPTvM6jB
         i2hZqx2y3cK1QhNy5o5s5n4ORiwcBh/blQpJr8RTK78NC39NRFgDzirlx+zAF+f0GNH9
         Z/779Vw+ckZESLIcXznt2cfCQEai6LF8T8PC4o1Rhb658qjvbeZmSJc76k5BOqrqa9ka
         9USAYCDzQkJg7yWDvvEaUuJdjCCw7Qsn6RB1LU890vYdxO5hQyb6bQlvLuy+OKhOCQTn
         jjtQr31J623sU33+Y92NyJbZPAJ+5wMxn6ZJYIohVS8+HBEgEuRNEgYz9dVbnoLUHVLR
         1tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729003; x=1794333803;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QlGR/Z6huNBqf7qPxyYVqVaOp44Imd+irchLTr/i+qo=;
        b=hFMxruwy2XXbA1aXC5C+tXF9i5UukDnFBHSbk9qCB05YWynxUgWZSI/4k0mliictcf
         fMTShxQb3F9IA9QAenGv5D0csl937amkMWwlBwmRRFRVPzAgRi2subEwpfGFFPyp6Gqd
         Q6to/Jo4Q7Wtllx7y+HH4ZQex34hcZP60JxMTF1WgP/d3yDY/Ny3Z7KGgTTbEwU6YHWC
         NpbmBOduVtsT3jy8mL1v0Lg8AeiLPm5+cMVu3zdeC11KHOhiIdTN1W+97w+IUP4swOM0
         LLfcbmYxtKFl1MgznvPVdBBQckpLFm8EdOQPJkLa2eFJ0j1RS1t5sC4bc04ihgWcksHQ
         aN4w==
X-Gm-Message-State: APuU4Z+p9Fr2c4ZhVCgbMrgJwRHR5b3hWbJhBw0gugAM1MJP3bJebcbY
	lA5Gkv1AmByasDBffsL4V5G3WVtUlXNl1N6xkwb/qV35k9QIZJCK7yzp
X-Gm-Gg: AYBFou28daEfoJ+3t0G5/jNe3OJcIQeGB49TiM1A21I3eiX4+8LLFG8AcyxelDbUoXu
	o1vmWdDO+tAoXdRC/fFxvM/xB0lowskOsRhPhhTt6HTrF5RuobfO3HmKz3wj8SnCh2tTpTmxWi6
	z5FEh22qk4xVW0tnfALN8YwBBWXK5/cS5TToHIdlBAM6N/ZOBPKlTnM4iIXZzuMAmWonIQS33om
	SIeMFSJXbEyygYxPzS+5r7Su2rptijRjHYPyPXSIK/OHVVFWbHIZgM5Cz0n3PSZcCb7GxWE0zLe
	0aowc2x/6NdZHdtbzLEc94AZWf3yIdxiglcqS9XjoIDIRdg6X8FFc1AIzgDGVTmwcmROaO1D2jB
	sTJ62g0X6FEO+PNyVkMwERTJWFrMi476VSRapVcXAwsUChimWNE55JAZSKQtCh6eLeTIikm6C6y
	97OyRkYEFpow9ZdoTO4JQxooWakKnuLINDkKrdhwVV4euK7gaobPIWfZtgv+2e2J5m7s0KKMAHa
	AjTy0PxDETRJ3JSEsy4yaUj5LjUdBBD0WHwaHMX0IjSaO518MZ91HhAtnsKYiy/Pr9aaD/NpjVm
	Smg9xaNy0EoQ+KFgDn+QshX63CVYl+hipll84rrAH1mz0++V5+9WFd6s0/RnBMBqzIeN0D+F6QY
	/LQTJsafdK9B2ICe4fiFcVTNJrIHTTG0xtQ==
X-Received: by 2002:a05:6a20:a111:b0:3e2:9dc2:d69f with SMTP id adf61e73a8af0-3e928a26e3emr12491551637.52.1793729002716;
        Tue, 03 Nov 2026 10:03:22 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fdb34sm3771979b3a.5.2026.11.03.10.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:03:21 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 18:03:21 +0000
Message-Id: <DMLRV3E28SC8.3FJZXLBLZI4DD@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>
Cc: <bpf@vger.kernel.org>, <linux-mm@kvack.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Federico Di Pierro"
 <nierro92@gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/8] bpf: Honor const on generic kfunc memory
 arguments
In-Reply-To: <20261103075916.100050-2-jolsa@kernel.org>
References: <20261103075916.100050-1-jolsa@kernel.org> <20261103075916.100050-2-jolsa@kernel.org>
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

On Mon, Nov 02, 2026 at 11:59 PM Jiri Olsa <jolsa@kernel.org> wrote:
> +	t = btf_type_skip_modifiers(btf, arg->type, NULL);
> +	if (!btf_type_is_ptr(t))
> +		return false;
> +
> +	t = btf_type_by_id(btf, t->type);
> +	while (t) {
> +		switch (BTF_INFO_KIND(t->info)) {
> +		case BTF_KIND_CONST:
> +			return true;
> +		case BTF_KIND_VOLATILE:
> +		case BTF_KIND_RESTRICT:
> +		case BTF_KIND_TYPEDEF:
> +		case BTF_KIND_TYPE_TAG:

My earlier feedback must have been lost ?

This switch is a copy of btf_type_is_modifier().
All three callers already know that the arg is a pointer.
t is never NULL.
One helper of half the size is enough.


The patch from the v1 thread, rebased (compile tested only):

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
index 935b163..21dd273 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13182,6 +13182,22 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
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
@@ -13550,7 +13566,8 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 			PTR_ERR(resolve_ret));
 		return -EINVAL;
 	}
-	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
+	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
+		    kfunc_arg_mem_flag(meta->btf, &args[arg]) |
 		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));

 	return 0;
@@ -14102,7 +14119,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
-		arg_type = ARG_PTR_TO_MEM | MEM_WRITE;
+		arg_type = ARG_PTR_TO_MEM | kfunc_arg_mem_flag(meta->btf, &args[arg]);
 	} else if (btf_type_is_struct(ref_t))
 		/* A pointer to a struct without a size argument is classified as ARG_PTR_TO_BTF_ID */
 		arg_type = ARG_PTR_TO_BTF_ID;
@@ -14127,7 +14144,8 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			return -EINVAL;
 		}
 		proto->arg_size[arg] = type_size;
-		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
+		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
+			   kfunc_arg_mem_flag(meta->btf, &args[arg]);
 	}

 	if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
