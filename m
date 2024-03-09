Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3C6A29
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709945241; cv=none; b=SGAQBFkKc1sTZa7uCBu96QUxjnx6N0E3aK4ewCKFjU6XVlyIEHoT+PsexMZ4w8WVAHFbdfanlV5HqB0yxJqu0ICX7Yvr3wLloSJnUbezwFScQLd2Jy+wFY9O1UVILtsi1uDnh4jRlp7lwQ6gzYO7NjYTJmuHk4qIeLr+VCDGfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709945241; c=relaxed/simple;
	bh=YANa1EdYmq/ohkPkvuVR+r/53Wzih4/yA/DybjGlNTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/Ba/vP9BsO2LDhPd6HrNUP10ahv6aHFNbkeq+6MEhA1IM0b6DuSn6oZIQwJIAcYQigbAr0xGkv8ky0scrrVcP5r8z7ycL6Jbhksoo3iR19BjEwlS4t97H62iaQnD3+Atzvxp+VpktmBBIVXs/G4WBBwLaBio37niP5Khj4NcoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmdxE5n4; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmdxE5n4"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2289513a12.1
        for <bpf@vger.kernel.org>; Fri, 08 Mar 2024 16:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709945239; x=1710550039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR8fhU1P7euRsfqH4DgPtpQWaH4Ace2+DmCT9Dg392s=;
        b=YmdxE5n4xgTol04pCTvCZlSEPzkKEm2H/m3C1unQmZYjWVntO5tIY20dQ+odjd0txm
         fyZ8rbCklfxYTuiS4h94REh1zlVIgd+Mr3aVx3L/JpBcGUCIZFu8w0pQUB5S5n0E7+mf
         ubpI63Qyjr+Wab4KKPcurl9mfZ1j4yhTMZXOMzDdJpMIsTgaAx/MqVhNKldzQ/fuPzF5
         VNplavKtkKGQqnHkajXe2L0WujUM5aY5xh5MbppjcbifYkIm62iTpgKA2owSnl5ifOzi
         /9wflLcULBAhOxymSoEkwvyqFLs15QgAGgBRwIGaHcWIlHy65lqwEfAtZHOQQGeUpWiT
         AMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709945239; x=1710550039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GR8fhU1P7euRsfqH4DgPtpQWaH4Ace2+DmCT9Dg392s=;
        b=UvLL84Q4/X0DIli6VIfWYXy0LSHQpw7wmdIh3qXDlvTdqdqUKM1P13BQ9PFmu5Yohq
         oJ9wAFOm2pjxYj96kJe73D31Yi7ZL4luZJuWi4KTH83Fcyug4FJ/C4H9MguTpd4cbacn
         4qRW9h1S6d3pVEhCS405zFqPvWMhH+/puuzJaFURliqSU4cYvX1MS3DUlB7wwlZMMcyF
         Nk3IiPAECoVinQmjjZM+zSiKUKVo3l0PLpOdTifTiFtJY9U8x1m7/PIGVQUvRzbdxjmo
         8LDQFCNNJEzMjDDEi+M3teIck400WzXw7LTAHrYSZPR6HcfZKMwSh/4mZbPBK3CLjiwu
         Yhcw==
X-Gm-Message-State: AOJu0YycbOeZKImggSsFtxjWcduHhBzKODFUkOh497vNrclhQz/lvV+M
	qwrOTZ/XSeFQGsKz4kvIOtHTeJQMeWwSnLINIAPLnNcbb22NgS34ohiIUFwei4WK67OlIUcL/IX
	Ec3AZbIR++2S/ZuPXYGOVntU0msY=
X-Google-Smtp-Source: AGHT+IFpgMbU3GkWPn59vV8yryETW1av6SibH32oAG3cM0C7yJQhiq+8hMruY5Fh43X6OHdCXCrIfEsc40kG67AgpZw=
X-Received: by 2002:a17:90b:101:b0:29b:976d:b5b2 with SMTP id
 p1-20020a17090b010100b0029b976db5b2mr690737pjz.17.1709945239554; Fri, 08 Mar
 2024 16:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306193938.2068150-1-andrii@kernel.org>
In-Reply-To: <20240306193938.2068150-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Mar 2024 16:47:07 -0800
Message-ID: <CAEf4BzaqW2Uje4p8PjRPH3su-4Fz4v6MHx3DAFRYt_B7S6ikvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: move sleepable flag from bpf_prog_aux to bpf_prog
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 11:39=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> prog->aux->sleepable is checked very frequently as part of (some) BPF
> program run hot paths. So this extra aux indirection seems wasteful and
> on busy systems might cause unnecessary memory cache misses.
>
> Let's move sleepable flag into prog itself to eliminate unnecessary
> pointer dereference.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  8 ++++----
>  kernel/bpf/bpf_iter.c          |  4 ++--
>  kernel/bpf/core.c              |  2 +-
>  kernel/bpf/syscall.c           |  6 +++---
>  kernel/bpf/trampoline.c        |  4 ++--
>  kernel/bpf/verifier.c          | 12 ++++++------
>  kernel/events/core.c           |  2 +-
>  kernel/trace/bpf_trace.c       |  2 +-
>  net/bpf/bpf_dummy_struct_ops.c |  2 +-
>  9 files changed, 21 insertions(+), 21 deletions(-)
>

[...]

> @@ -2196,7 +2196,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *p=
rog, bool deferred)
>                 btf_put(prog->aux->attach_btf);
>
>         if (deferred) {
> -               if (prog->aux->sleepable)
> +               if (prog->sleepable)
>                         call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_=
put_rcu);
>                 else
>                         call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
> @@ -2761,11 +2761,11 @@ static int bpf_prog_load(union bpf_attr *attr, bp=
fptr_t uattr, u32 uattr_size)
>         }
>
>         prog->expected_attach_type =3D attr->expected_attach_type;
> +       prog->sleepable =3D attr->prog_flags & BPF_F_SLEEPABLE;

there is a huge difference between these two lines, got to be more
careful with bit fields here:

-       prog->sleepable =3D attr->prog_flags & BPF_F_SLEEPABLE;
+       prog->sleepable =3D !!(attr->prog_flags & BPF_F_SLEEPABLE);

>         prog->aux->attach_btf =3D attach_btf;
>         prog->aux->attach_btf_id =3D attr->attach_btf_id;
>         prog->aux->dst_prog =3D dst_prog;
>         prog->aux->dev_bound =3D !!attr->prog_ifindex;
> -       prog->aux->sleepable =3D attr->prog_flags & BPF_F_SLEEPABLE;
>         prog->aux->xdp_has_frags =3D attr->prog_flags & BPF_F_XDP_HAS_FRA=
GS;
>
>         /* move token into prog->aux, reuse taken refcnt */

[...]
