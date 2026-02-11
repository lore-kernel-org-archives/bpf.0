Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103FD336EE9
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846324; cv=pass; b=VF5Dp6tHOcPadIyvb/DYLGGb8pleofZRtry0pZvcDlE3UEMnZzXM91ddiKC0dbbxUcV8ToEE8N/Ybts7pU9/tJZKFcviQX1Atuu6zIhEIqkBUhmO9vhqcto/Oqtct9Lhl7KOWIT0Bn+8upd4vZPyBB1JJ2dzqhsHfIcUBcojQgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846324; c=relaxed/simple;
	bh=nuE2vBBK+2RJiCiGb0B+sn/cUht5CUWsJl01MuJJ/YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOKLRk9w33mXxWJSgXGlfaIErsexaOC7NdMYjnsoSHz3IBo7zAZviMQeIWq/xWAZbsDwgSSUoQdmuziNov1dRl9rRqRyce6vdao5+ZOzj1ZPXFv0dT5PEelnr8/DhiwM+HPlBdWCExvemXnH54At31yl5o3q9AiZTpvjsL1PI84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTXQLUSS; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTXQLUSS"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c6e1f417918so305958a12.3
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 13:45:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770846322; cv=none;
        d=google.com; s=arc-20240605;
        b=hZ7IRBAdnFaPvFjwEXL5o3HFAMDMFCR13DUtrgwUtZGVym1pu5Zd/cqJ6c/VHS/m5H
         sUXfVTwYpT/KN6hYt6TTtv3W0iwE8KA1YSfdkNy8NOPHPcK8UhrN5DZxV+fDVvwBv1ae
         KNMhuym0GZOtZuGTJyVvWcmNhV+PjUoT9wpCZCsm1QdKfAYs4gW9f1nF/zGUwuQhl6Al
         QigoyNltyg3jvAvSDTUjjCEsLS9l0fbxVjUYz+BRMhtCKIRKWc6KzqHhVvqDP1ZGobPz
         vFO3uIIpKrVhnehjqxJsPMvPSjyXERpooZfZlOXo/fHuasjuZvz1YD7nfNFxdLYKSiHZ
         CUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PFvzboXPKAR/UGK0ChkKHu+3J9bkV3Im9ziXduC/D9k=;
        fh=EaALckxxMbeBWvlw8n6Av0AZEwhvIsP2Sex50El9aWw=;
        b=GOH6jsc0ZMYYN2aqUPy1qCfZHFuXr5QhXnLTF/1b4O0YwIqxX1neIWwQ5s6cDdu0co
         vNfrzRDhaefRo0m6j140M+xwyF4F/mWFnd/rRhkXhyicLpvc7pT1jQxppAoHflo5vLzR
         xJN589tk5aCyq+iGrJIE5YBeP7bVLuCWIxA1sx+51670yuGFR/CuueXmEvO31tzaeGeM
         Zea2UCvYfOo6zlXSil/+nXYyp3ZtzvOXcHLSAvYjngvLvYT+LXWPlxCBGBaJhB+rVVZI
         d9gNewplTC+AWamVwaQarnOS5M7QZ6v26Gg0kjDmFWLlDqjVCm6BemHjwhA/BZBT9X8n
         NLJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770846322; x=1771451122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFvzboXPKAR/UGK0ChkKHu+3J9bkV3Im9ziXduC/D9k=;
        b=lTXQLUSSKVilTBbqLSSr218EPvXWnsnRcCgmLHcff9FBzjeCIPFvxLiz65JN0gRbrk
         aAQdE6fOglBnOuBHcIrzK1KhEQP25E7EjVZpf3Pyjk1gjn305UlusAw3URa89f/mMA1o
         KRNSPRLa3nrlGcTcm7zeTWglyZMSNrDo/4SK7/Yk6LaHqOuhU55mxKMNXGd9ZzxzW1dk
         dz3oc5q4ngLDGfHKi2/yPVuf3arkjYDot0OLabQS5vHJIn5TQDS3ICr0o72EvjCeSF90
         BYa1o5PCjotCloRaPfrUGUDHz7KwdjbK9i1gU4FdL+NTxLp2BLGXOhprSjC3MtvFrY58
         iSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770846322; x=1771451122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PFvzboXPKAR/UGK0ChkKHu+3J9bkV3Im9ziXduC/D9k=;
        b=YDiWAHo556VL0v430hAUZQrbU3GM8bFvx2S+YyweoiQ3WLlenIcuuM0Wt0uTe6TZoe
         62Sg1OaShtMvmuPEaV4n5LIZLEsKRwZo6b3xszWkCliWb08bKB5hiIbgMJwf7+Tvczie
         QvT0HtmpczI8qVCtXTpFIG4V0U7aU/KzePvkvEfJvresFC1/ja3eFs5aHCpwn0zTWLNn
         SliMErphhLlRGaTnSaR8NT2NCkWs7k0cwivO3CCABaYJNpghUs1FDRQ8EZ64EDh3f4lr
         lt0Q5OybrOryKVQnKAU+n+26tm/tbUAbj3CqCWqBWzz/A4dXmcwc7B89N5UsUuIcANF5
         QBhg==
X-Forwarded-Encrypted: i=1; AJvYcCUc379/gEd90zRVOOQakeytUH96lt21tPVU8efPt/I6ByHyrbF8R08FLgjNfyG6/mFWNVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAHP+bXTzj9UcJjHHbiVcVDo7FN2GiMSil1wTS0PqL9q8OjJRV
	z7FIjZd/KYMWoEhTccZfuMemeIvpdpxEoaFWaP+50Zp1Wo1ydnGFV8fyaQkEUZ9rAAvf5/bpLwc
	NzEQdyYsSATPbodaOhM0+aPhyFgEOJlc=
X-Gm-Gg: AZuq6aK89J7sECVpLvdSuMW2+dnjfASAWo8qrHeP5GCQunBNmCaA6z/CvaXNeRb5kN0
	Nvnn8ullTP5JzwwzUhYDChAkYlfs5je9znU/Gu5C3CHPCJ7OjAux7lB4TMOKd4tDgLOpcno4nGi
	0xa14LuOzb4iE+oxUuvuo9v5dm2ZgPlgLLxm/BKGYEJbd2iNHRF/GVgXb9bSuBeXZ3kwSnUP9AQ
	w+v/lzG+nA3jhcnscdX04/C5HmOco3WAn42pX3l12k0LRH3tFkcVNHQIdXbkYDP99m6W0w7ohEB
	IQnTjNW7F3ykhlDY2fw5Wjg=
X-Received: by 2002:a17:90b:5487:b0:356:9405:759d with SMTP id
 98e67ed59e1d1-35694057bfdmr19940a91.9.1770846321795; Wed, 11 Feb 2026
 13:45:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211084858.750950-1-jolsa@kernel.org> <20260211084858.750950-3-jolsa@kernel.org>
In-Reply-To: <20260211084858.750950-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 13:45:08 -0800
X-Gm-Features: AZwV_Qj4MZh7BqEj5rEZ86yKjIHx9VJkmrEfOzDX4jKz7e0l32scxCG59389hyg
Message-ID: <CAEf4BzZ1FGHjogijuAEcdVbvmN=kakyLyi3iw1ZX5YpLfVgaZQ@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 2/5] libbpf: Add uprobe syscall feature detection
To: Jiri Olsa <jolsa@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 12:49=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Adding uprobe syscall feature detection that will be used
> in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/features.c        | 24 ++++++++++++++++++++++++
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  2 files changed, 26 insertions(+)
>
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b842b83e2480..04a225c7f2c0 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -506,6 +506,27 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>         return probe_fd(prog_fd);
>  }
>
> +#ifdef __x86_64__
> +
> +#ifndef __NR_uprobe
> +#define __NR_uprobe 336
> +#endif
> +
> +static int probe_uprobe_syscall(int token_fd)
> +{
> +       /*
> +        * If kernel supports uprobe() syscall, it will return -ENXIO whe=
n called
> +        * from the outside of a kernel-generated uprobe trampoline.
> +        */
> +       return syscall(__NR_uprobe) < 0 && errno =3D=3D ENXIO;
> +}
> +#else
> +static int probe_uprobe_syscall(int token_fd)
> +{
> +       return 0;
> +}
> +#endif
> +
>  typedef int (*feature_probe_fn)(int /* token_fd */);
>
>  static struct kern_feature_cache feature_cache;
> @@ -581,6 +602,9 @@ static struct kern_feature_desc {
>         [FEAT_BTF_QMARK_DATASEC] =3D {
>                 "BTF DATASEC names starting from '?'", probe_kern_btf_qma=
rk_datasec,
>         },
> +       [FEAT_UPROBE_SYSCALL] =3D {
> +               "Kernel supports uprobe syscall", probe_uprobe_syscall,

this will conflict with libbpf arena relocation fix landed into bpf,
so let's wait until trees merge.

But also, this description is going into the middle of a sentence,
start it with lower case

pw-bot: cr



> +       },
>  };
>
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index fc59b21b51b5..69aa61c038a9 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -392,6 +392,8 @@ enum kern_feature_id {
>         FEAT_ARG_CTX_TAG,
>         /* Kernel supports '?' at the front of datasec names */
>         FEAT_BTF_QMARK_DATASEC,
> +       /* Kernel supports uprobe syscall */
> +       FEAT_UPROBE_SYSCALL,
>         __FEAT_CNT,
>  };
>
> --
> 2.53.0
>
