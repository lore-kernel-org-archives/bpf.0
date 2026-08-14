Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958DA346A08
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739540; cv=pass; b=IMVZzSk/qqfHVJfwfrsnCfMqBexf0yTwf59wBbiTTpBVuVRW7LihXKfmJXHZX+nprWXJY5yOM7PaqLE5LMK+H/LWrBKov4rrZvR0fEb7jkZ5nK8uTia0nzJxMBtF03tmZAOPuq5PThPShBxHNhAKEtM1q0M9wFv/NExH7wqoJdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739540; c=relaxed/simple;
	bh=fDtmrf85ZQe/ITC6s/lLzWWob18EB0B4ixC3+NydqBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbXymTf6E8ViMky1a+pYJcV9ArdqyzGpHN1mc/zPkroztLBVZRcKHS5QTiqXpaLLJSj3FQPeXvO+c04yB0gAoEF5ivIam0/WVSnyvTDc+xm6ND+KEVQAtWwbavl4GOkagyT2LQ+vGPdd7vqxCC+tjGRZQaiDFI/yR9pszVGxD+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/0d0e6T; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/0d0e6T"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so1489269b3a.3
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786739539; cv=none;
        d=google.com; s=arc-20260327;
        b=nN+2/dfimV7MYCtSmsKzZds2vWeCf1hK4sX9MBjILHg29IA1iqERBlxSb0C2wklri+
         TU0+7BdA/SWUAOtfclw0omChvQYkpDE0VQI5uQSXoesA9ylHe/tiVamz0lnvBF0RfLWa
         G5aIy3sHYNIsthBZs1jSakcLEwldFDAyXaqfhZ9BtbsmbL4WhIUW+0G1pCtA/LjGcfje
         E72pw5+Ldkc5Kz3zf6pz9Zkq9P2ess4xUZuzQkelNlO3DklVu9+TkzLsKfTN9s7FbHhl
         Gx6qygn+MMQv+yqtS0seV9b24SkblBVn8XDVXYhQHRhb+7k3VrUDzGKd9hvR8VxqbBxn
         YtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BfUaJhOj0W7UMR24l1krIbEd3jzyohfQdD0zU2FJI3c=;
        fh=Jhc8qUS82ewjnmR5J6GoQBwkTnL2S38bZDTss0mnObU=;
        b=CzV57sWi8/mbliT68WHtFEuZh97Pl5ggROnPRJKPvnjMRYksCVXvINvAaw6n4Lv/CL
         Wn2E8Zc0WAPy7YrnDsxMs50xkRjwCQOi0gE4gqLRiWrAGngGqon5mAOcd7L4wlGuzO4G
         dWqfbFYr1rvqfzz1yuitBK66d1vXuxlUMxHU4BYEHccwbxod4YxM+tebHlUWabmAARrF
         jZvoBFjWyR7wBb9wjP6Sa46fhqpJazn4M5hGrTJ9X6lzQpWcAnfwJouCvSmTOEjRWw0h
         ulixosjAP5PoYaJkHNYRh6O23KeH8Mck+t7ZwP8Df6kOIOibQo/H08fuJuWgjq+e16fl
         pTpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786739539; x=1787344339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BfUaJhOj0W7UMR24l1krIbEd3jzyohfQdD0zU2FJI3c=;
        b=m/0d0e6T906rYpeV0v+IyjhC+RftzpuIyW3LvLfsQhqLmEmEg8vIUdZfGpskD+q+vQ
         0d6xMMrMjD6mkVMAAy+gGHyF6exTZ1t97hGyN+9K1hOpoEUCSxVib9QRe7v/ZIjWIfp8
         cGf6mKVLMQKk2KRWWn8aervzTwalhvfOtklClSGT+1jNhCxxQorxUiMlOgcdNN4cQOes
         ILPSMpna/U8AC/4eDUs4vXU9iECForP/kfv+53A5OXvp+b903jA/f4IRhXEWbPwB+36W
         F8SQRphxBXLwsU+AvvlS5/dNqNacMv8tIOGmrKnDYCdOcedNGB6TEWG/O2H0rcw4rqra
         THfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786739539; x=1787344339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BfUaJhOj0W7UMR24l1krIbEd3jzyohfQdD0zU2FJI3c=;
        b=XH53WjLFiBl7UxCu1KR0QUIjEIq4eQAOAoC6Qbz8uy280nKPb+P9Ol3LpBYp5z44XP
         Px+wZkGy7T0G0dITO9AjdQKVWYM9SKQUOQhjBNS+kp4Tu6PF37Df4AAQvGJY8D7Cj6M4
         kHUJVGNS+yr9HZttQHqQM8p+Zi03DWnq1WujyBdorUif0Pg7BqPOgmwZuXmCxvp6K7Uk
         QOrVfCcE7MJ+2orhQtkz57Oc78uGD+8l6HJyK2VSiuaOpOp5/yyks2ZiVZSGacbzCwu7
         tX2MiVP0q5+9gcN7v8emooXyFC1yMxbDp4bBFL9tcCOkK7toy5RReB6saVBMj2KuXNap
         mecg==
X-Gm-Message-State: AOJu0Yzoy+CEFYTeza1obqC+MFuhg4bOPVLtappkq2qs2AQM+st55uJk
	6W05Y3Sc3nMFvKOwLdgLj/6wbrsjPZaFIAz69o1fSXXWgwmTHZ6Oc2Z39gLXwUjGKi0MBKepDnF
	d1MMO/jL982hw4eQvEsnj9cif0zTVw/0=
X-Gm-Gg: AR+sD11qHuPJoWpJnIwvLooDo+81ZiZoS0Ajgu1e9ps6GSB0O2syYtiO40CeKgSU0rn
	ZTcTT1ud26LTIKfiiy26HhyqVXuxUwwkczJWWNvOvl/lrehl13qKAq/TBCgs6Vfs7I2/FvtwM2f
	3ddT1hN7a7myDWmZ45k3Zt7UvTF6hcgw9NCxUgO0fsP8h//Yz4hXeQA5gY8Uk8n7GZWz6aFE3/D
	XC6QjlAA7vY5osRrkuqp0BwCAIcPZHFxJH/JG8ZDcR98/Iau+FxcFo9K4ff04k28IuThICogkvC
	GlrkOB5D31KpCiBHqBUkH7TbjJy4iWEcegDZFTz06niOv2SKr5dMDpG9GCexwCaoVGeBA0yOykh
	vZnrPyCELjN7piSPYMiQWvUc1uLKB4Lo0TSSC
X-Received: by 2002:a05:6a21:3a48:b0:3c3:704d:57c4 with SMTP id
 adf61e73a8af0-3cc71b122bemr11130921637.12.1786739538897; Fri, 14 Aug 2026
 13:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814173206.93082-1-leon.hwang@linux.dev> <20260814173206.93082-2-leon.hwang@linux.dev>
In-Reply-To: <20260814173206.93082-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 13:32:06 -0700
X-Gm-Features: AUfX_mwYlaWdU9szLoemEjEdcBeqvThVLjHorsYcgxr_XMe5uBLfK7uw4V91CdE
Message-ID: <CAEf4BzZvEHCFaPuBDuxCF7-_TLPsJdyZV4WQid2N0RPrPv8NYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Drop duplicate blank line in verifier
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 10:32=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> Drop a duplicate blank line in verifier for cleanup.
>
> No functional change intended.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/verifier.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6ac1afced20b..81eae8f70acd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12113,7 +12113,6 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_call_arg_me
>                         ref_tname =3D btf_name_by_offset(btf, ref_t->name=
_off);
>                 }
>
> -

seriously... just because AI tells you to do something, doesn't mean
you have to do it. I'm not applying a patch that's removing a single
empty line.


>                 if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_=
type))
>                         continue;
>
> --
> 2.55.0
>
