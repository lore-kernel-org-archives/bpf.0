Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F11A316E
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583172; cv=pass; b=LkgNTT18pjXKp/FQV8zj0EmWPhH+Uua16RLa0lz+3jlv8O7jy+Za47oWdbHLHEhCS2z/2SHuzBGYjriRwnAVcEyxNM+Sd/8UmR4YmX1Z8exfoQuu5H8v7lrQf45Vq3yGAllJ0+YmMFGQeHj8NVauKYuydHrIDsJZvegFPuGCJhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583172; c=relaxed/simple;
	bh=z/h17cI078/9NqpyUHkpSLsM1u59G7+ivUeblLNROEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mP3IEMnI2JKKZaxi6NefrjipSfLI8vsODn5a62aFetkJdKJJ2m7Eh5FF6k+KJEwWxOSeiS8WPHx/y0XXbwA40wYu5xGkNQRVUDB2nNN2XwCe1+Ib0WuI/SYrLZT1t2gS8lK+LWutLGeKm34vcT8J9bCoTzW9MHiQ/S5mCUV59GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rH9cnnGC; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rH9cnnGC"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43b41b545d9so1653507f8f.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 20:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774583169; cv=none;
        d=google.com; s=arc-20240605;
        b=cBbqUaNgIsnukyqMROnu56M+ko4J9BQRXm7hmon8F9kI/4oKakcppzM+TH2xlaPzlp
         7AX18oZofUI9Vo4xhAg449sOTYnHNwcRBXSaXObKHs6s8ftIg95rm6kqmk/aY+n3eKmd
         3GfqgSac0WtKzB6GzKcGuAROnN9cTSIRnR2FdJQm+3ygwoLjb8UWkh/8B8APIMNmW5YC
         TvyqfBExBEGt75MhBnFLnJjcIxFMtgkEOUlY+pMbyFGqrhIW0GvYqMyU4vrYsY+8PH21
         6utSwJ5RNtgRl1n7BPHmyYGTeshtZvr//Tj5y6tdqQ8HkefA0J//UMyQYKfUhZC6Awm/
         X9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5wVcBv7b/y9aTM42g+v+ng/0bnwUi5+6v4uuZ1Xt0Fw=;
        fh=smd304FbnUM21K73O/z8iyQ3UTEUjucTGWwqhPFJ4zQ=;
        b=bfyHexl40OzEE6+qpoH8+NxIgnwuZlo3SGfwzjBUliG5Nczx70ZTLkLzaEejlTmOhL
         h7m2wcKFLxkh3DKw5srlVDKrZUz8zce1ue82wpS+6N02xJ7GDBTMaTvLmtK7VMrLh+QJ
         zPXrNn9dpTdRmBztCrhcq+aMjsWE3IUZ0TxsqkQjdffYCKok/dQi2z1b7ke/5KfUWox4
         uYmFqYvw7sc3Q0Oa1Gapk53R/ie86oF6bFxlWogkG3y1xPprNUiaq3ky8i/SIGEOmxtY
         Vsm0cbKpDRzHi4hlyTgSW2TKqWIhyR1KHMl91V7viMgUV12iqRDdFKs9h8fPiVUhNyeT
         ruCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774583169; x=1775187969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5wVcBv7b/y9aTM42g+v+ng/0bnwUi5+6v4uuZ1Xt0Fw=;
        b=rH9cnnGCqdkjI6q0v4TknKC3G+ifAqLhG64Qr+TlLOOLkH1SmlFaoAPdSXdUSz7C6h
         AEebTZqiXUZ4oh9ZtpvRgb6XgJ73Xbr4YL+5VW8cXhXQfwZ72N13qVtsZ0OAqdgYlo1T
         fI26OQY0yKyGBf/SVD04dqohsZw5w8Z6ImJkCvf4qSxR5f0mXtkTSwbQIsDtxWJC9mwH
         cSlaDN30YO9zRiKjjuRO1dxDp4bMEnNP/loHxFAOCqjy4/ds+V34rMe9WyQccnjJXofk
         hpeWfnk/jgE1qe7KnVE2nJZcwKW0I8wrfZcD/b4Rp1rc51hFZovoaLpKidSuIQ8ivsat
         jRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774583169; x=1775187969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wVcBv7b/y9aTM42g+v+ng/0bnwUi5+6v4uuZ1Xt0Fw=;
        b=GMEGR9gqIDjy7iK9O8dZSFIUJ4tLnScbbSdjc7/uEfp6ncKqc8zyU9qw/rCa9GskP7
         GPBIVe6rPuRtVmxg7v6pgr/iIRMcwxzZOO7Ag09kXXW+8K4s33YyujtJ5051LbSv/ZU+
         vcGzwcRGWkqxRqtsBJFkuNteAAdrq7EhBvx4gRCJA0TTmqdVMlyMoFUFs5grsAB8Ajw+
         1x3sDBxaKYhYpX3fesEGv3kqV0iaFw2uNiuHygSZB/HxjRnMHH9Olx3uBxPqhAHQrtEu
         jY25nTQ/xT5X2klyeZ8Q2hFdevRlZuzEgYaNyL7G0/Sb+vXnGCWtonD0kHxuUb2s7v0d
         2HFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoQpe7fCtlYJ18U/onZcLCAPKAZ9fdX+bEhSqYc9+cbn+0OK9uoszAS2HTNUXWCSjVeKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/765kD6vTO8n0Ldv0l1YgxnLRsxwc1lsYJeb/B+MRvcmNaBvX
	4q7+v6FdmDRDlVhUbZC2KqH5GJM54nChbDY/kmVpbmGbswGfsxDi5Mmf4NCIx4vhTN6EPtJBOCw
	rBstsEVXGwstRVP8CUi0epNG/f4Rp6Xc=
X-Gm-Gg: ATEYQzxxl1Wxl+0Zih+ctQe5Pu/VwFPe6O66YHL39qq8Ztj/ekfFde1afpJkOiN28vl
	Ntr11p9QpqlSbGu8SAefSJ5+GkAUsG2ej961OpPSkW7mbJay5co1QzqS86eQUKveB/Mf3aPvysQ
	Vz0o/E3rQDZK0EnS0VFmRHnIqbDo06ZJ66fUE/5FJzyMsv5eWWHY8KEXGnhcP3n9NQcCOIcV3At
	GUQ7MKgDpzh4XMp65XqTHjnZowzpFvaMwzUCk3h//s5MgqFETLG54al3BZh4EFHUGxnQt7WRBHM
	3pOV2BUEBorms6AR6uV74wS/sLdY0ZbaMUdXDSPJVbvXE4zA3cyIo4zdVAy9
X-Received: by 2002:a05:6000:2681:b0:439:b623:a9e9 with SMTP id
 ffacd0b85a97d-43b9e9ea811mr1026044f8f.19.1774583169395; Thu, 26 Mar 2026
 20:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327002759.4033863-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260327002759.4033863-1-ihor.solodrai@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 27 Mar 2026 04:45:33 +0100
X-Gm-Features: AQROBzCdhGzp8nj02kMy229fL82E-L1nWa-ZvGLMktbKYbgnowa445D_l4uc-qY
Message-ID: <CAP01T77azUtPrOeUWWj=Y-VfvwWA9yma=+n2sJ-6Q2mRE1mLmQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 01:28, Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>
> The following kfuncs currently accept void *meta__ign argument:
>   * bpf_obj_new_impl
>   * bpf_obj_drop_impl
>   * bpf_percpu_obj_new_impl
>   * bpf_percpu_obj_drop_impl
>   * bpf_refcount_acquire_impl
>   * bpf_list_push_front_impl
>   * bpf_rbtree_add_impl
>
> The __ign suffix is an indicator for the verifier to skip the argument
> in check_kfunc_args(). Then, in fixup_kfunc_call() the verifier may
> set the value of this argument to struct btf_struct_meta *
> kptr_struct_meta from insn_aux_data.
>
> BPF programs must pass a dummy NULL value when calling these kfuncs.
>
> Additionally, the list and rbtree _impl kfuncs also accept an implicit
> u64 argument, which doesn't require __ign suffix because it's a
> scalar, and BPF programs explicitly pass 0.
>
> Add new kfuncs with KF_IMPLICIT_ARGS [1], that correspond to each
> _impl kfunc accepting meta__ign. The existing _impl kfuncs remain
> unchanged for backwards compatibility.

Just a drive-by idle thought, but is there a way we could drop these
_impl variants too eventually?

I think the existing macros in selftests can be updated to use either
version by detecting the presence of the kfuncs, and maybe we can emit
a warning to the stderr stream of the program during verification when
we see these being used that they're going to go away in N releases,
and then just drop them after that?

>
> [...]
