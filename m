Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F534753C
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897334; cv=none; b=WpsbmiPKXbxoMPYJdgqmgOYvmMz9qsaG3ilLV4JBuIdPTftsyPnbbk9PoVmpcyKLFtMR4/hTmuNLG2IvdzFY8LjVcY2wibB3+RqZVdF2iEX8pPmk1W4YO5BPzXgxc2w+43LfC1E+mqmJ9BzJKyUWk2DInvkV3bQ+236lHvCNOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897334; c=relaxed/simple;
	bh=FlqRMTgwnEYTgwBo0M4QMzzgXOiGkRJeDRkX7I5vYZo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oIKmWp/PASNfkwHbG3REvhDfBfY50OeZJg2moYCU8ElE0tP5qOxbsXaQuiryuUUKoQoAXyDCqru+ZUE2DpWbALQrH8fiQv7xh4iAs3SuiWI0aFFZYTtivhmJ0qFm6wV0V3N6bxGrp0d8Di30lJYHNj9UEYH89DnENtOyF+jr+MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU5dTAWH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU5dTAWH"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso1244889a91.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781897332; x=1782502132; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tdZietZ1vzrwOz+XYJNjMrGChV39Xfbmkh2IyU4ikh0=;
        b=IU5dTAWHKzT+NpMVAP6hRKK/sKAoftG0M/mm5M/H1j+X4sLT3vGFFGrzOgn+RM8rVV
         BtrxrsTm4X7szyrrTTDhfanHHQF7HUY2w4q+QJGnOlO3K0RmC+Ok/BNZcybnxzq12ono
         J7KZK2e7R7ka2iniVazPTLwv3zlwuwcKGSV5u0aMubReFj1vX81fIxrp8ccz7u/e4Yey
         KeCI9Uy6GFMJheUU6CmhePlFm2tT0QJwl++2V1jZHqO0oJOoGGEET3XaxpgxJXsnC+0S
         9XbEjNXTK2z+9qegr4zQeWwgSAneIqbNLqPZ1jXHeN2unmYBcKB6jE/X1TZ0fvOjrh8A
         fHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781897332; x=1782502132;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdZietZ1vzrwOz+XYJNjMrGChV39Xfbmkh2IyU4ikh0=;
        b=sAB+LreHn+1HLeW8MEMoR6FAPGiTYe3F6lPavfTmH78vZrbYOoehzVGJhDeb2B2xio
         nh2F4j8rBugkPIm6vjXzDmuaOh32NGGa3Xgno3Z3KYSwlf75E5x+dQnCpJDw7z54sQdw
         YDN0eC7kBGALv4zfCSgGQMbs95ArufGQfyb2jxskzXOd3UqafDtE9RInkBy5Q79xJESM
         G7R4pBA6GtPxAq2fy85/+fjcb4ddzUbYT6gAr/XjtLZjPEdDDEHFIKKJsNL82YSMjxqm
         fb3h4A5276zV0Uts/XCNN2SxqGob9gRhlscrhVs//bS8yLp83bKKOk3rV1nttUuc2sdq
         Gb2g==
X-Forwarded-Encrypted: i=1; AFNElJ/UEcijHMSlquxCLggOxPkZqZm2/iYuPOsAIpX8TegURTQrhgqL455iODSJibEP/Bqw/b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQbpI7EpaJ/CX2Zc8/ah3fzp/eZhhXA7bm38auTUm3ireo3yh
	r4+JD9R0Zd5XzQLbkD6HQeBAXgkR2/4PexxBC4PwCPnTNKvvLTSvYyUZ
X-Gm-Gg: AfdE7cmaqMhM4Vs0COcyPY5mYSFjrt+6NaLgXLdq5LjDHtHVgRcYUYd4VKaj+eGILbG
	zQCqfah1NftcXZcigPKLSpBbT86UC4HjwMjHx9LD3ivYU+7ojVLBYjV9/cowLgFGLOvSL99SKde
	cGFtcHfK7oUjq6ntPsmXS8mhSiQl2Z0hLiy75q5NUxpUqomBTWzHLaC3G46Iq5NKuZ3cOdpsXXF
	ZQNNheUNGq4dej7SxZiXGwbFIfph35lKYh6MPwvAoX9ianPwa5vu8fNV4bkr6Ykr27yPtE05y81
	4BNqy1W7EEhM82u1L/0gjbkJYQT4+pzpEKg1TvHyERf8g+YSu7OBaEEti36CSmxYjGwjTE/dI1C
	thOOdiRBY+QGjqzNDvod+Q3pdKOCbPhaOhUroA9b3cgjY6YHgwZrzgThzrpCM9CfIrLiUv9Ugz1
	FOUoqFZjgDANGrgna8+gK7t5PZN+j5mxmQQCGuKjdM8g==
X-Received: by 2002:a17:90b:4a90:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-37d160bec36mr4958120a91.1.1781897332384;
        Fri, 19 Jun 2026 12:28:52 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4f225870sm363308a91.8.2026.06.19.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 12:28:51 -0700 (PDT)
Message-ID: <5986dad827772fb0060f7c4adfb811ad93755a52.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject offset refcount acquire
 arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, Viktor Malik	
 <vmalik@redhat.com>, Leon Hwang <leon.hwang@linux.dev>, Dave Marchevsky	
 <davemarchevsky@fb.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 19 Jun 2026 12:28:48 -0700
In-Reply-To: <fa2336b329055908a401ec3b18f8498ebc03846f.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
	 <fa2336b329055908a401ec3b18f8498ebc03846f.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 07:59 +0000, Yiyang Chen wrote:
> bpf_refcount_acquire() increments the refcount at the caller-supplied
> pointer plus the refcount field offset, then returns the caller-supplied
> pointer unchanged.
>=20
> The verifier records the return value as a base pointer to the refcounted
> object.
>=20
> bpf_list_pop_front() and bpf_rbtree_remove() can return embedded graph-no=
de
> pointers as PTR_TO_BTF_ID | MEM_ALLOC with a fixed offset equal to the no=
de
> field offset. Passing such a pointer directly to bpf_refcount_acquire()
> currently passes the refcounted-kptr type check.
>=20
> That makes the runtime operation start from base + node_off while the
> verifier models the returned pointer as the object base.
>=20
> Require refcount-acquire arguments to have zero offset. Programs can stil=
l
> acquire a refcount from a graph-node-derived pointer after normalizing it
> with container_of().
>=20
> Fixes: 7c50b1cb76aca ("bpf: Add bpf_refcount_acquire kfunc")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---

Hi Yiyang,

thank you for the bug report.

>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf..4510fe0b4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12392,6 +12392,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  					reg_arg_name(env, argno));
>  				return -EINVAL;
>  			}
> +			if (reg->var_off.value !=3D 0) {

I think this check should be handled by check_func_arg_reg_off() /
__check_ptr_off_reg(), could you please reorganize the code such that
it is handled there?

> +				verbose(env, "%s must have zero offset when passed to %s\n",
> +					reg_arg_name(env, argno), meta->func_name);
> +				return -EINVAL;
> +			}
>  			if (!type_is_non_owning_ref(reg->type))
>  				meta->arg_owning_ref =3D true;
> =20
