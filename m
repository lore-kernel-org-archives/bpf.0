Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEF3DE445
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638598; cv=none; b=WIHo7rml5WmS0RpNYugIFQ8Lpz55R4TnMclm+XFvxd8i/TkfahNEVtG3W8+nJiz+jXHFgk17J+qpK7K4e6UCzos6431nis//xWuc7BwRF4noJJCbN5Kb6QH5DckzWDLMAgVj465Q7/qJEvVDH0yopNFfbzDHig++7g7xCXvccnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638598; c=relaxed/simple;
	bh=x4vuvjMjK3Siqy6TliGJe8+jhWlv6O6RxnFPsOmVF7A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=e13aoDZZZvxoCUsGoi/K0Ggdh+H3MNUjwidJu8nJzjmY0dU2hZHCKi8e4jf6qquU481C4G7MuTLLY8MHbkCvAq/JjAbQMPMBoVvMMNLKEilLVsVkDsncqf8toEdYJghtfr+YF0w6lba8azZuhUn5BLtGuy/0MidtgAcRt0P7r74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC8Anh5V; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC8Anh5V"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4859b1fc7a8so3567433b6e.0
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781638596; x=1782243396; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EO/9z4OOJVGQlHYYaBZaNw8VQwWazXkqSJi3LxEM90=;
        b=GC8Anh5VfSrdFDAjBCA+t3VBlW9IQNj5CS2020mtctSOl0TPtqgqnGjyN+MItcjWCE
         R0j+pM5rZJAV44nYdGQv7jC3qjGRKFk5ryfZPJP6ggkny9bOvT5PsAWDBqNcZnOUDHzW
         55at24VAlGj21mPIJaKOSHd4NigWRARptROZhFH3vPAFtWHmD3Dcc2orE/BzygvegpF8
         MYKIXU7AGLmA1BXhbVVUIyvaoI5TvJOVe0/vMdnU4AZCkGAi3uDlSMlvfvJARjsCEL6h
         eT6d5OdfnVWITLk0Pho0d6JAb83fB8Ys9lco4IUXjCHAL6DfOFBC6BEmxTmI4sb3ZPRt
         MAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781638596; x=1782243396;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EO/9z4OOJVGQlHYYaBZaNw8VQwWazXkqSJi3LxEM90=;
        b=e+iCwF9/LcCoFLVzqfuo+pbaw79h83E9Sqc5ckP3E/XULKJSiLx/Rzm2cBpl/kmUJU
         C1TiyXM4eAzOMU0GsFWuJmPlJTYO+mlPpvF3rCdHier/SpvCvzzK1SjJSNPVrscpByw/
         jPWm0+Jg98wLgD5K5XVmEFxCTO+jikym1p/cVewyYsUNLbhaFuV/vvgLh34zd83P9m1u
         r/blO2bLDn7FRyRQYPwKiE8asvKqxmKSoet7HgsE4vOC0s37yKcNArHDDN/Nxryz4Mo7
         FL/k0n+JGhR9dipzIBqL6n+Mnp3BP9OMn9KgkDz2EA6tOUJhLhffbc5G+7ngM0Ujvvtr
         wunQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4QweyeM2iceSzxf34jdjrRXHRVN5cXggLSJpujXMRptK8ViF5qWfgZcWlHpycd/voL5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8FtxtImKpasRgFzQ9vil7R37HxYlNxTeaURpm/SGZWbzwrR+
	UJUgJjGQvWh7aIX764h2x+qADLYfiq1oJ28RuyvN/Vdh/j+HIaZgCRXp
X-Gm-Gg: Acq92OHa6iKPxVDFX8AxlDuC0JTnjsI99bWzh6SA1XCzhrJnXDY1qcVqk8k0Msuejzv
	44Y1Mpl2imLhgNUXhhwfydILBVsOYScbBLIm7FzVU1XvyI7SHOO6CAHZOc7NnNOhMgDMXGe/T5D
	/fkbLSGpdrUgjRK6jN1dHuR7Ix26pcJEDmsJsVnHoOoE2S3Rs2bHKVE+xRpFY6aMTyM5oknz2YC
	elL1JhVhjYmkoSiffOjPLFwK5iXe8PUOiGg28km91lpgTEm1vvISwF5clTbZ5MRPJtRv41KgE8u
	2M3JhKal0DE114sQ7fF7vMAJZDInTtSKefoNHoGjBU4Xy4fQ8JlfgV5ZX40WMf3/kG+dCGQuJbi
	GXKyEyPhXf9LxOmGviWFixS9d0Dm6y28veowjujP+XHwTwS05Yu/Dw1zTUWWa7t6LMlDNKHUBlk
	ac8fxL+rPoYyMbIbioOyyN8eyf9Reu6WXAZnWLceM+Vp7EA3GQnRDpMPwGSYsdS43iQkE9I9ZN7
	8kAYZEudWKLheGuLA==
X-Received: by 2002:a05:6808:1b28:b0:479:faf5:ef4c with SMTP id 5614622812f47-48944641750mr389992b6e.32.1781638595545;
        Tue, 16 Jun 2026 12:36:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875ddda6b6sm4881214b6e.8.2026.06.16.12.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 12:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 12:36:31 -0700
Message-Id: <DJAQ65ZVYAN7.2Z8DNW7Z0JE7V@gmail.com>
Cc: <pablo@netfilter.org>, <fw@strlen.de>, <phil@nwl.cc>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <shuah@kernel.org>, <kartikey406@gmail.com>, <coreteam@netfilter.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Guard conntrack opts error writes
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>, <bpf@vger.kernel.org>,
 <netfilter-devel@vger.kernel.org>
X-Mailer: aerc
References: <cover.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
 <70aeec0ab762aebe65129cf6052e132c7329edc2.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <70aeec0ab762aebe65129cf6052e132c7329edc2.1781586477.git.chenyy23@mails.tsinghua.edu.cn>

On Mon Jun 15, 2026 at 10:42 PM PDT, Yiyang Chen wrote:
> The conntrack lookup and allocation kfuncs take an opts pointer
> together with an opts__sz argument. The verifier checks only the memory
> range described by opts__sz, but the wrappers unconditionally write
> opts->error whenever the internal lookup or allocation helper returns an
> error.
>
> For an invalid size smaller than the end of opts->error, that write can
> land outside the verifier-checked range. Keep returning NULL for invalid
> arguments, but only report the error through opts->error when the
> supplied size includes the field.
>
> This preserves error reporting for the supported 12-byte and 16-byte
> layouts, and for other invalid sizes that still include opts->error.
>
> Fixes: b4c2b9593a1c ("net/netfilter: Add unstable CT lookup helpers for X=
DP and TC-BPF")
> Fixes: d7e79c97c00c ("net: netfilter: Add kfuncs to allocate and insert C=
T")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>  net/netfilter/nf_conntrack_bpf.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrac=
k_bpf.c
> index 40c261cd0af38..3c182024ec509 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -65,6 +65,11 @@ enum {
>  	NF_BPF_CT_OPTS_SZ =3D 16,
>  };
> =20
> +static bool bpf_ct_opts_has_error(u32 opts_len)
> +{
> +	return opts_len >=3D offsetofend(struct bpf_ct_opts, error);
> +}
> +
>  static int bpf_nf_ct_tuple_parse(struct bpf_sock_tuple *bpf_tuple,
>  				 u32 tuple_len, u8 protonum, u8 dir,
>  				 struct nf_conntrack_tuple *tuple)
> @@ -298,7 +303,8 @@ bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_s=
ock_tuple *bpf_tuple,
>  	nfct =3D __bpf_nf_ct_alloc_entry(dev_net(ctx->rxq->dev), bpf_tuple, tup=
le__sz,
>  				       opts, opts__sz, 10);
>  	if (IS_ERR(nfct)) {
> -		opts->error =3D PTR_ERR(nfct);
> +		if (bpf_ct_opts_has_error(opts__sz))
> +			opts->error =3D PTR_ERR(nfct);

LLMs have no taste.

Above two lines could have been one helper
   bpf_ct_opts_set_error(opts, opts__sz, PTR_ERR(nfct));

Or we can do a step further and simplify the code more.
Turn this:
   if (IS_ERR(nfct)) {
           opts->error =3D PTR_ERR(nfct);
           return NULL;
   }
   return (struct nf_conn___init *)nfct;
into:
   return (struct nf_conn___init *)bpf_ct_opts_result(opts, opts__sz, nfct)=
;

static void *bpf_ct_opts_result(struct bpf_ct_opts *opts, u32 opts__sz, voi=
d *ret)
{
  if (!IS_ERR(ret))
    return ret;
  if (opts__sz >=3D offsetofend(struct bpf_ct_opts, error))
    opts->error =3D PTR_ERR(ret);
  return NULL;
}

This kind of small improvements should be obvious to any human developer.
Please do NOT send us patches straight out of LLM.
Review it first and think how to improve it.

pw-bot: cr
