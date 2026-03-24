Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58883D6485
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344135; cv=none; b=hTOd5E+PGB/axg2mxmypMtGolSBEHKG5x+i+FTRkc+uvusEe0VSJ8ppIhdn17EvaDVfCfv1gwB/gN4EGOupzbNYZPYkHLY6uIyGJvt8qB6kUWrEC14mQBiJ3aozp/BmJx7mACBbStTQ/0ucSwzGbrrPE5jhKBnrKVqsgu5snRwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344135; c=relaxed/simple;
	bh=sNLk76kfl7rLDqgYawYpkGGTBOF6YKCy2yhpNZuonuY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sqvony2RX6a5L0PfNli2UjXhG3C/4l9SMjDRm1yjtCkzqeAkPGZql9xP8ZxHkp9H41Dx6wSdMtcVPcUBhMYUMDKdSwGyf+6jv4yebJSHzmnx850fwm4nPaDsyF8BFXW6H6fCXvZowC5YwW6hU/8I9VescJ1m5TPN9l76ROcHeWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3E72d1q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3E72d1q"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fda2a389so29749595e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 02:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774344120; x=1774948920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1p/kuw5Gevu0gSvz//t6cWZ4W2ENzeaQpoHOrBzYASU=;
        b=s3E72d1qy9EYz8G6RaW9hvwTn+gPd5JBgYXiur75e6amwTuleO3X7aLSlCzBJwBbBF
         Dk3w2OvPXjvpPlpBmz612M/aQujZt73eH6qKTksjqouF/6em5vA90tPJZ8JfKGTUEDur
         j/rEx8+/Ikknez6rXAFPo1RR4yoFyqHI+rt3gcZ25OylRZ0ouDoX/+zbZIGsvx5UdkEt
         3mjt2lS9JaLyDf9Wr81ZX7Njfdr/phY7utLuP57lzf6bgdwhphiEijfTCFIwSIq/qjHh
         XbUnGCgj+ZwEu2zauxV9ybdXkG486bHg/UKRO22ON1+MeAwYonOItZj4gY4KLyVCyRBi
         6Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774344120; x=1774948920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1p/kuw5Gevu0gSvz//t6cWZ4W2ENzeaQpoHOrBzYASU=;
        b=jrNKUmU0MoYFXinviq73UvshzLJs8NehtWJpxk4eINmS/lrB5OHra30fqiye9nr8xw
         ZgWRqqbi2fiD/AlUdfuYX9isOnecD/2J8agxjBESd1vqUyoRgWhNylRPKI72efhx0m6s
         sI1vPn61I6A6IuW1HiE/cEgZYmJ6j3UlEEYq2/Df54Mv1hcmaYIjS4NU34Gzv+8+hbdk
         SBJumvTOV5K9+HfJpqXYDKFF01RNcbFrWcD/kdPGqm9kljDQZC8pBk8rwCFeaaig8A/u
         KQ28Yid7H9YPqmVjYDhZ+LBfxmCw3ySFx+Qnyppjd/Ywbl8WzEZGZ3RcAjNNx/xyMQBS
         nNlw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ+NMvmDgP6ou+M2IQVXfRBqvHOqJxs6wZWsArNIpBHrQsojgEmoXmKnhgjoY5nSC55Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/09nnuIdtfMaUlSN/W6G2Uoly9Gv2IFV40WLGzKU718hXfbh
	tMLKhI+kvXTjq5BYV1o0GZAZuXx/IVdPjaFXCjLmWU2GHXIgyRo23tsW
X-Gm-Gg: ATEYQzxr6aos+vtomUlEXzdzZnzxKZ61vK0Hmnjj116B3LVS0jchD4vGDCpzlVZyrU/
	E44hFpzfyVxyn5JpV7+uIpAb5PRCY1SL57e/d+s+Jsv+XNBbqqKUA/p1OYlTxfdglz7ftgURPYQ
	Ai7hStMVJu4pn5rt/yCqvLu6PDIvU8BK5egoV7X8mXotAnRiCZbNR+K4DTQ+m0HXvmfpUgxGteT
	KLe4cD+bu3Hx8lJdoVxLM24m3QpEus73zoI4AeKkJ4TEH7HflK+a0fE58RyBJirZEHwmeKpQWTQ
	bC0+UJfst91RUl4hQ8VQEj+6uxT9HDHlERWq0O27e9eHYTjkYpScbQ7KUylM8YeNg1nJIrzAUHN
	etrMuYq+w6EksCnX3Fw8thPYQEEFW0hf7eGgBL+hovu8loc5FNyJVlN+KOAouB9x9ZWmLK4JYph
	LlEKct/ug=
X-Received: by 2002:a05:600c:5291:b0:485:34b3:8589 with SMTP id 5b1f17b1804b1-486ff04d42fmr222877075e9.31.1774344119927;
        Tue, 24 Mar 2026 02:21:59 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c094csm28734605e9.1.2026.03.24.02.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 02:21:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Mar 2026 10:21:58 +0100
To: Kees Cook <kees@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] libbpf: Replace strncpy() with strnlen()+memcpy() in
 skel_map_create()
Message-ID: <acJXtr10v7wE_xT9@krava>
References: <20260324053036.it.906-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324053036.it.906-kees@kernel.org>

On Mon, Mar 23, 2026 at 10:30:37PM -0700, Kees Cook wrote:
> Replace the deprecated[1] strncpy() with strnlen() on the source
> followed by memcpy(). Normally strscpy() would be used in this case,
> but skel_internal.h is shared between kernel and userspace tools, and
> strscpy() is not available in the userspace build context.
> 
> The source map_name is a NUL-terminated C string (the only caller
> passes a 12 character string literal). The destination attr.map_name is
> char[BPF_OBJ_NAME_LEN] (16 bytes) in union bpf_attr, passed to the bpf()
> syscall. The kernel's bpf_obj_name_cpy() requires a NUL terminator within
> the 16-byte field, rejecting names that use all 16 bytes. Valid names
> are therefore at most 15 characters.
> 
> The attr is pre-zeroed with memset() at the top of the function,
> so the byte at position 15 is always NUL. The copy is bounded to
> sizeof(attr.map_name) - 1 (15 bytes) to guarantee NUL-termination is

hm, but this version no longer does that, right?

jirka


> preserved. This is safe because the kernel would reject a 16-byte
> unterminated name anyway, and the only in-tree caller passes
> "__loader.map" (12 characters).
> 
> While the original strncpy() would have copied a full 16 bytes from an
> overlong name (producing an unterminated field that the syscall rejects),
> but this shouldn't be a reachable state. Forcing truncation to 15 bytes,
> however, seemed to induce a (unrelated?) BPF selftest failure:
> https://github.com/kernel-patches/bpf/actions/runs/23472955268/job/68300440546
> 
> Allow the literal to exceed 15 characters and exactly reproduce the
> original strncpy() behavior (potentially lacking a NUL termination).
> 
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v2: don't force truncation
>  v1: https://lore.kernel.org/lkml/20260324040535.work.851-kees@kernel.org/
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: <bpf@vger.kernel.org>
> ---
>  tools/lib/bpf/skel_internal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> index 6a8f5c7a02eb..8702d6612978 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -243,7 +243,8 @@ static inline int skel_map_create(enum bpf_map_type map_type,
>  	attr.excl_prog_hash = (unsigned long) excl_prog_hash;
>  	attr.excl_prog_hash_size = excl_prog_hash_sz;
>  
> -	strncpy(attr.map_name, map_name, sizeof(attr.map_name));
> +	memcpy(attr.map_name, map_name,
> +	       strnlen(map_name, sizeof(attr.map_name)));
>  	attr.key_size = key_size;
>  	attr.value_size = value_size;
>  	attr.max_entries = max_entries;
> -- 
> 2.34.1
> 
