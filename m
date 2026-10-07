Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9A4334DC
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412250; cv=pass; b=claRO9+R/KQ6bhTyFnkufEyJ571lwKRF6pimOZQjQFIkYUc9skbI1ZadK8aQqWVeN/PkrAi914IWHcdmDM++VTBOqjJlPNomTYBOl8GlFKCRuYVEUCrqu9S8Zp7w8bksMJxHBKa9XUbNUVf2LswjIT99NTIsfVryWAZ8UF+25Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412250; c=relaxed/simple;
	bh=Lzrn3mTs/XtnEQyVE60M0pIis479rPYQCw9kscVpK0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0Y9xyrO+C4GdfvayIrwYNDXKFCHKqvmApndFpqLychykERNVBOifbJwLcOain5xnoJanVFsRB2LT4suD9rYszZU3k+HsvihfsJSRTlLsr5jvcyv10LdUpW8T6C8+9cZPnddmniV52iFzKfSBQbp+Sb1tJ9lk9GwdxSnTg3Cj1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLf+9oiw; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLf+9oiw"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4f14642adb4so1195792b6e.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 15:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791412247; cv=none;
        d=google.com; s=arc-20260327;
        b=SJuH/TfRd7wWY5I6waPUmsSA18hOJhfic+EoZt7IVLdDgnkWivuZrNlYAJgpigSzTM
         0mKhnhMPp+oq9FXiKVxt5CpPqCREX6dceq6TisJnZ3iQ7mhsQCiUX5MmH9hsuSt8kMPA
         N4sxMB/z5/xHtDcwD7POxQo9A65FXsn6omQMiZtaknFEdeoVubIBDeBDMOp+RmmCwmc9
         qCdvCJi5eYT22zZ3HihcvhYNghG6ifPdvy0XNFycAyi/0yz3RklqxPRjWEvFEYGa+msu
         bGaHNh9x1VetdMc7HvBqvx8Z92A6AZJaK1qdd6uOWwZOsuaSCoQDekzkZ/Zz7QiPxIbW
         fNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3clTQCTCnnpY8hOc1jAjkF4nhO8A4cLiGYdk2Z3wF6s=;
        fh=RRET7pXxm/AY07Eoz/3cK1AJoAPgt/iJYkEat2fzGJ0=;
        b=rUzWL23hcAK0+gimI3Qk5D2uyYdXS/k6PAb0IzS3OEBYoQ5rZ5LZQmStm5kgb0AN7R
         wkURSGxA/7WxDU8FbSDr68wf5Ii+Wn468/1ajvRdXAlCyIvqRt5WVtRiMgk/b9GmR3ZY
         VMO8Bkr6zlrwb1aVkWQVBeqLO2Ai/ZOabhM64gtBbenyPsk60l9d6bOcT2oHIQCUgTnB
         t4XKEeaCY9uuGKfzjbCs6HdygLdFhvJn+JiMFnlBfiq9R0lEWXMsbgUWPJi9TfBxPl4l
         o/ghIb4cCFVBnVfJSV0GzeFtriCPqR4YIFEWCMxyTZE+n+5bksTanFWknsdlDVERBlL6
         PXnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791412247; x=1792017047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3clTQCTCnnpY8hOc1jAjkF4nhO8A4cLiGYdk2Z3wF6s=;
        b=XLf+9oiwblmiuAOVnOBfF0+S+cYq2AJsaW58B+uuT8R9/oaIaD+5ntKnKpWuBndhrQ
         FdgYZYbEf4mkvFT8hyXIUfAIMtv7aLHcLTwtzG1+1W2xj08Hu+DnroZQJBHzABCZPrnu
         Nw0sHdMgUaX0xvJkjLXMaq0cDHr8Q+XBSUgQBA9I2embkKJqsCi33gLvc5vF2r8by8ps
         4jJouGL6vv0t7/NM64NAS9+trnmvFz7i6hPKKuZf+uhDMUZreN8xanrlRaEDEZzdYQUy
         qT+5lBxXLMqRk+sy3PegRBUmEf3JpRFOEw4xKRydFu0QKJXpfFrqIkeJAl9Em5765cBd
         UtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791412247; x=1792017047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3clTQCTCnnpY8hOc1jAjkF4nhO8A4cLiGYdk2Z3wF6s=;
        b=ke0MvoJPp4smWoU8BPQesj7fzMQyh1JBhZ0b1jSJhg6gV6vwqn9Xu3+gGm+tkzrY+0
         sao537P0MJ0xaeHmr4f39LphsdM2x9ic9wCCVuoghb/B6qQ67OXa+DtfeNo2zYxx6vAO
         qmqFo5C0q1X8jSGG1yvWvwc4sPRAt+WT2TT7g6nYgMCqVDXxyvCV5Z68bOBULk8fmyEx
         1/ujeIRNpQ7IZFEPXvyTCmmx1oSiUfc+jvPZZ3H13Clo5RzoFLn2YZBESivOcDbQntgP
         rjtuQDqrMAGkC03Z8YiQTH6kPJ34GimuaBxGRekvJEfkyT9H9/RtiwH7k2cl22HGFUvO
         P/pA==
X-Forwarded-Encrypted: i=1; AKwUvBwY2FSwFLmyNL3aSGfU86vixD+qiw1ICMMOI7SIBdKNqnUdaKU/X7XexUZJko5pg1S7rjk=@vger.kernel.org
X-Gm-Message-State: AFuF++nGJ8YljhMaIebeqsXDP1qvsrK5gsuEIR6FO7Z3Ur2NlLQDp5vh
	E9DorP4LrlfGr8hdB+zV5T6WlJGNfoUk28zQ1MQ3NAkfw6zUM3b8vrtLdXSH5bF+a7VuFkC7Z4E
	Lc9OiC0jZEeNbZLLzUrb2T+/usg5dl+A=
X-Gm-Gg: AYBFou2PoHAeKICtM38Ymnsrsoa6swMldEKSr387ceVZqXsRDub329HpJWisVJg6OLh
	bJr42FzjZ/gQUA9oyb1UK6PFpcE6d7p7v03iutBnCn178tYhDSTPIchZZAD3CqBl1I+wYFyAo5u
	HlrjhxOkCRKeobgZYGNYisqWU8mkbMAY5mAraFOhREfKvuNQtOeiql8Fo+9fu8euIDPYC4+JkvS
	e40S3RVFL0KMTgdqE2z3oFnapCrtfnwlJytZmCoau79hwD5tWTIYkLDqSqOI3c6A+hFMWp9YtQW
	k80yyPgXS4fuXRWh73U7gQOOf7QpNKwThbYwAsnbN1DEk1/FCtSTYAY=
X-Received: by 2002:a05:6808:1388:b0:4f5:59e4:a8b with SMTP id
 5614622812f47-4fc47abd3b1mr3579325b6e.58.1791412247204; Wed, 07 Oct 2026
 15:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-a3-arg-trusted-v4-v4-0-253ef3a1a69a@mails.tsinghua.edu.cn>
 <20261007-a3-arg-trusted-v4-v4-1-253ef3a1a69a@mails.tsinghua.edu.cn>
In-Reply-To: <20261007-a3-arg-trusted-v4-v4-1-253ef3a1a69a@mails.tsinghua.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 15:30:34 -0700
X-Gm-Features: AclHuK-f8-ePnMdo-O27CR238KSTeSYc0f2p8oscdyi9_ZwyWmVUlf-VlzP_ZyY
Message-ID: <CAMB2axPOBx+AuQ4X=rG9cikfcVaNb1Bd2o1dHKP3RNDn2=ftmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Enforce trusted BTF ID argument provenance
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Brahmajit Das <listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 9:25=E2=80=AFAM Yiyang Chen
<chenyy23@mails.tsinghua.edu.cn> wrote:
>
> A global subprogram parameter tagged __arg_trusted is verified with
> PTR_TRUSTED, but the common call-site type check accepts bare PTR_TO_BTF_=
ID
> and MEM_RCU registers. The callee can consequently pass a pointer with
> weaker provenance to a kfunc that does not accept RCU-protected pointers.
>
> RCU protection only guarantees that the object remains allocated through =
a
> grace period. It does not guarantee that an object's refcount is nonzero,
> so an RCU-protected pointer cannot satisfy the trusted-pointer contract.
> For example, an RCU-protected bpf_cpumask loaded from a map may have a
> zero refcount. Passing it through __arg_trusted lets the callee pass it
> to bpf_cpumask_acquire(), whose plain refcount_inc() can retain an object
> that will be freed after the grace period.
>
> Make the existing provenance check contract-driven. Mark generated BTF ID
> kfunc argument types with PTR_TRUSTED, and add MEM_RCU only for KF_RCU
> kfuncs. Normalize PTR_MAYBE_NULL when the argument contract permits it.
> Then use the argument flags to require trusted or referenced provenance
> and allow MEM_RCU only when the contract says so.
>
> Split is_trusted_reg() so the normalized type is used for type and modifi=
er
> checks while reference lookup still uses the original register. Conversio=
n
> of scalar-struct BTF ID arguments to fixed-size memory continues to
> construct a new ARG_PTR_TO_MEM type without PTR_TRUSTED.
>
> Fixes: e2b3c4ff5d18 ("bpf: add __arg_trusted global func arg tag")
> Suggested-by: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 353bde9ae2274..a0ab793f041d8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5327,15 +5327,17 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] =3D {
>         [CONST_PTR_TO_MAP] =3D btf_bpf_map_id,
>  };
>
> -static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bp=
f_reg_state *reg)
> +static bool is_trusted_reg_type(struct bpf_verifier_env *env,
> +                               const struct bpf_reg_state *reg,
> +                               enum bpf_reg_type type)

You might want to teach your agent that the line limit is 100 columns.
There are several unnecessary line wrapping.

The fix looks good to me. Sashiko=E2=80=99s finding is real but pre-existin=
g,
so it does not need to block this patch. If you respin, consider
fixing it in a separate patch with a PTR_UNTRUSTED | MEM_RCU KF_RCU
regression test.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
