Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197A29D28F
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777837923; cv=pass; b=YVCcWIm0L/XVv03hVhqk7xaROFp8MU8wO8uJyIRoO+jf2QHaiofUY6zv3sDBdsE6nGeibUKM2PQLDRMogkKLFAzysgzLxHeIzgkx1VQPQv50Ffa+syGj2gzhDd9VtqpsL6zVwBo49bNzTqCuPOao8pKQEA4Z42Edf0/P0ywiViI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777837923; c=relaxed/simple;
	bh=DltqfY2DnqkS5mXlCZEDd0aLOzaByEF9OWsh8VyUvms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRV4p8Dm0OLVhTtULbAjyo9e0WS7/K4q4eRRGxcCBdaJmM2fT5M2twmctKor8qz9xRE4rxjwRXYcdjFUFw87iczYnxcFick6Ww3AGH/6/zc/aHgl5A5t41vMz+PNwGJHUEoLc7AwvrfpHXtfmweKNnbkcz6FyaaT42zTs5L48DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnYzhCxg; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnYzhCxg"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488d2079582so37127445e9.2
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 12:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777837921; cv=none;
        d=google.com; s=arc-20240605;
        b=V1BUzNsV512p8P2/Zf8574vjD4GDowh4dV4+N/c5YXyeB2rDKStoQBHvkSixozEjgA
         k1nkpic0sRXIPyLbu8kazyw8njQ+DCXK2HiLsZXhND1SddBkG9ZIR//jphlQzsmoadVf
         zR/n98I4TzcLgXnZU2mVNirJaQrkzm9d+QDKOn+gIKPOx744hCD7iWCLbypqQnGW93GY
         RkEN5LnSHVB/1k+VfgncRVwHVPeUyhJpLCgeJva4WtWs/lsclf0TuG6Ozfb+IRkc6uzl
         ngNqWUeMfCH4IlgJSZqMD7PMHosWHC7RHDsf8DmxF2uJRscwl1eYgiOgZ4kpTfz/MImM
         V3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MO9uxptEOBu74fEJnlr1X6LfcN1QpYq+iJ0FUEQHje0=;
        fh=uulfMXzilibTROOx+aDpBUZnYu3jVgsDVCH018qZ0b4=;
        b=Uue01a4B6zPwlVuzI7vDlkO1r2oleplmw+nmUSWJRXQh7wloU/BDIKNyuyZ6WImlEE
         ov64cCrI04fD3Pdt/rlrljnjm/nuHYU/AdhhBOcvjkHMuSoMnapyS/yL7xm0E5wO4INE
         NXAbEdOI88ayYoi2lWoPH9QwIjeG7eP1ZRjqi/Hc6nlovd9rDy3dy9xvD0eJ8w7H3mJC
         Rep4fdWswuk3L7Jn7Hm0ASQaBtHW3TlObIsmzitQwRFLSOK6eXS1cIlV9iz7ipTmmP3J
         b9hvLsYLuxQFTppXs9v4AxRt6tGdzuhuFF1CUbGlYgHxB7n1+8r222ilNS/rFIjC1S7U
         Md8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777837921; x=1778442721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO9uxptEOBu74fEJnlr1X6LfcN1QpYq+iJ0FUEQHje0=;
        b=mnYzhCxg9ZE5p69V7X/lqJEUe2kCAhwAxQJ1giuRnRKVz+DiN8OId20cXjYE5M/iCe
         3V5/gesbbRDyF2VY7+UPLRXGNOw44Z3zAW4r/ieaY/MrLxjrnryc6StEr8+yEtG1Pzp5
         zQaWntW0ecnxt//PTRNA0SIXUyjIQfvsiLQ8LLBuFG65V0v1wuHbB2ZVXv8LLDqxFx6A
         UqafEtQWKq7gykbs4uA9Z5l04KDIHhHtyaZZkZXpt5NUuwMIZ95fUuXunE33pEm2cOvy
         RrxB9abW/lm6zPjBIb99VdA32PcZZoFfvu2iob7bkJs0FLpVAgbXuyHmo2snCjs2vN5A
         ej/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777837921; x=1778442721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MO9uxptEOBu74fEJnlr1X6LfcN1QpYq+iJ0FUEQHje0=;
        b=hdyLEb4iitQ89Y6cJu4jtfKXe9wvxQJkZ7J5gIdrwVpHO2Tp/4DYLaWL66q7aZp2ea
         PPCRsJNVVO/qtQoTDdxmePr4Ks1nmY9ru9D4XZD3+f+oxpzxSyxU7LJK3WSazEehEC3C
         QvHAt4lICvQX07bM3KtuoXqeu/k7MGzbodixGKGZvBWLSBpZCCn0lkyoMwiONs4JkYgZ
         ETWPrd4y9WCbI/g9qdN/w0PKDKNR7hvf4ewBQyX/QJHjd+qh9GcMJgVvYkrKk441WbID
         6RbdNeXBgJPkUpCpSxoq7fBzqeFqpHzsTWeYst9MLD7u58/i1BxtXZ5N/61uTEmyYfT0
         LEiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HhgbluKFY1fHDljVtzrA+cmhBvKS4skPBzFBDk6Ta9XsnOa+9rpsuKcbEZKNI+JxgqR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMePwoqPXgZVgpfDp3VaGq91YJ0cmh/M+mywNUpybetJVgAcYJ
	4M7HlKQNMIHBiflZ+lP4SuSCG3KclEhqYnpwAs7RrWDWzrzof4fNdVPTkGKVDJbayUPuP+7AiM9
	uXLcy3ANf62BKseNQMIbaa+n/GmZbFFM=
X-Gm-Gg: AeBDiesklsV5XyBv06wmaWAZGlze7ButMxNXVWzhgDYp+c7d4VXV8znPOv3tnSzhIeK
	i7Kh/m1on0/zw7bO7tbwe1/cnnYgxsJ50X6FLk24gt4xVTqe4GCCnhugX7r7yejJjpkq3tUMltf
	xNyuWKKawK4BiSxtUPllxcxJBf94/p0cOFwh89oRfVAXEA7q6mpOqO2F3EeHcVYJb9wsQCtRdEs
	+AJpvawbjhLoEVSLc/6Ry33YbWs/cGgEY1PR5//gcn8WPyApiWGGlZaSFGvOYthYiaxwWL2LJwi
	dMHwmcsOJEVVwwJ9YsXGFPaanL0xzV6LVw2Z4vT6l8AxQo/TMC1BhZ8ELoM3hTVqfChBaC6lkdD
	6icKC9snYlA2qgA==
X-Received: by 2002:a05:600c:a402:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-48a9865f7c3mr85772745e9.15.1777837920657; Sun, 03 May 2026
 12:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503164700.548164-1-atomlin@atomlin.com>
In-Reply-To: <20260503164700.548164-1-atomlin@atomlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 3 May 2026 21:51:49 +0200
X-Gm-Features: AVHnY4KCwOHSaSmah7QMZOP4tTai9ZqkBy8y44nUZiuECcF2WDS_Y4gkXYfZBao
Message-ID: <CAADnVQJ5fatNF4auH+a8E39zWMfja3rm4BM_xGcTnLX8uuCQ9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 6:47=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> w=
rote:
>
>  struct taint_flag {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a3c0214ca934..34b25609e72b 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3083,6 +3083,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpf=
ptr_t uattr, u32 uattr_size)
>         if (err < 0)
>                 goto free_used_maps;
>
> +       /*
> +        * The program has passed the verifier. If it utilises unsafe
> +        * helpers, formally taint the kernel now.
> +        */
> +       if (prog->aux->taints_kernel)
> +               add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
> +
>         err =3D bpf_prog_mark_insn_arrays_ready(prog);
>         if (err < 0)
>                 goto free_used_maps;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 69d75515ed3f..9d56082a2ac1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10287,6 +10287,14 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>                 return err;
>         }
>
> +       /*
> +        * Flag the program if it attempts to use mutating helpers.
> +        * The actual taint is deferred until successful verification.
> +        */
> +       if (func_id =3D=3D BPF_FUNC_probe_write_user ||
> +           func_id =3D=3D BPF_FUNC_override_return)
> +               env->prog->aux->taints_kernel =3D true;

Nack.

Please stop this spam.
We're not doing it. These helpers have been around for a long time.
There was no need to taint then. There is no need to taint now.

pw-bot: cr
