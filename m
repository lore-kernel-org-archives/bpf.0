Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6044D68A
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052533; cv=pass; b=oacIP1hpvzUIRa8Rdo1sDHtv1RSScgW9+Xs2rmGnQzTOr47a9YAADooBGARpfsEKxNZoYxcx8YwZheUZUDegn33eGq8bmK2gYainUIgIq7GZmra6dcBupkVwyRJxX1bU9FEULmuj7ywUC4IEreUO+NVfTTGLyYFRoWTyrClrGxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052533; c=relaxed/simple;
	bh=hirgCt1PZAXwyuuObnGxxAhuWbF5pVndJu+2sUatshc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkgARIs+L84u3fqnxZjGCDCgw/Rf0rR94yPpC0zNI7/xE+9qQSdNRkk9Lwwq2da/uJGvaJWMHJ/eFy39lsT+I3k/IXo6iypl5hu7WNJ2KdWEICEEjq1DjR3wp1nEgjnm8NY1lpjUXD64K5Lok/syoIG4y25lyTjCQe2J/ENPOrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiHg6Se8; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiHg6Se8"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43cfa33a983so2440870f8f.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 07:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775052529; cv=none;
        d=google.com; s=arc-20240605;
        b=eOUX8bmcxN0FC6r3/3XjCupunKYRM64IcvbwP5iOmP0ZCh5qsttLK+rELm9NtP6100
         0FKF8fe7eaRKx1UJImLniviN8uMN7/hkbi/8VLwZhJXHDuo1ggbiEEQP94cV/kxDvCRV
         LkqDY9oiVdZXTVu4GWykpvBlsK+mmw1pVIGcaqGrBfS/FIPjLD9X8VTE046O6Bkhj8pZ
         hpq2jmVjUexQKfliZCVUdr7IHO9KjFqyH8BMngkKbj3HCX9GB/oPOwB6TvGy5MPbo/HV
         tozABNRhyMUh/CeboCx9UJzoB6Uh0hjyJYHmVrcUkMyVRgWVSW9ZpQ/iHqkDSWSsUVh9
         G4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a1hIUDWQSXTMNI+xukBaLoexapmPDMcad1HRGKU7yJ0=;
        fh=iPvzjKy5l7nIXRimA+yMgoQ1NjVgDn70PmhNy/EcPps=;
        b=IP9DyFC+bkgT6JFLeurgqXRV+qgdr8wQlTP+pMwt4xMt0S6QtLOvvupM4QPJfnQ3j8
         Y2d3Nxagj8kR0J72zTEl6GVXv0YcZdomIRHnKhzFZkPIu0qeHgfUIEXzfw2qFK1kpDEY
         OfB/5Hz7NuUK5U/dkxMt4tCXlCjpq7yDaxrBRaAvkcZgvydwL2k9Y/8O0vSPFUpZsQ6M
         T0k1EJFzLuOB5KJSpAmeXa5moldTXjh9oEHYXaVY79EgFc3WVC5MM2+aavJrdSQ+QeB1
         B3EzP8YlGvufFGiqrhGoE+pmXE66oiLBuMAXvQX+F9kpejUUfgMYo+gzwBCf9w3Y7njG
         D4Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775052529; x=1775657329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1hIUDWQSXTMNI+xukBaLoexapmPDMcad1HRGKU7yJ0=;
        b=QiHg6Se8TROA6PrwUEDZ40hAU/jZ8ZBH9/O3d5DS/Cdm4w5K474tLqfoNb/B6pdsGJ
         QuNl/OLMoL3xcR6iBgwDIuYt14y2m78ruK2Tj1JtjzoyROsnjebTMVn8tMYC8OpQwXUi
         HZ9dCUdKJGqXnJPcQCLGEH0I1PoU44d4eMDjHEXt9r7U3JC2vD9UHoj74m63mAeiUmoV
         UgeNWK9R7Rd9LhKEDn8UEQJ1VPYKgGAO3fVEC4Av4DlDsfl0Wd1X0D1pZdxhcSYH3WC/
         Ip5/9/jiY0Djn+byEckdkEShjH9mL+psGLU0prQaRf66W7G+FrlthFSuALE9PdE+qUl1
         Yixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775052529; x=1775657329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1hIUDWQSXTMNI+xukBaLoexapmPDMcad1HRGKU7yJ0=;
        b=JAA7e0tRFvU0hL4MPBOi2KK8cSSarkCHDfOP80I7N4P5lsAn2mIIwNB4RjRK6JOous
         /MkxE7lNaeHlztSDZz+Q34FVCQDe9iVGpbshFqycZfUERfgrdkPTrXko8UJqlQiI990z
         hPzKR9K//4+CsL5/IYXBYgWd1fTVL8YdbHXeUvmDs+Os5TgtB8bpYKaBgluftlzYl5Tr
         uMs7vQkol/1i6kZgKWTlF69BVCJ/cdhhQDBSe2Wbv5cfA6oW4Q3asGMcSD0luZ3MISec
         7I7wuVpZnMvdK3xDPAjuSVVG22SUIb00cDXnX4iyMXAjXXdsY6+pIP6fPmw3N7hN/r5u
         x+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXJCoykSF88mbHPbpHEb98cMUzXZGYBRVXvj9GQDmPuXhUbHDvmrSPabJTHctgYcdOSnKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfF5UHguA8G4W9fnOWCy6IiwVAln4PKr19NKsN49g6Q2NRJEW
	j4xbuOYV8+lYR6SOr1c1fQbhe1ZahDI5pX8pRhxwXV6E29PEr/D5XUfoQAVV/fiDET5K7Z3omRO
	CgB2zGf4chiovXMb9KGsf7nj/zWiYBsnOnUi8PSVy/3XT
X-Gm-Gg: ATEYQzzHc+N3IQFvRqN2UD1Fn8mHA7prmdgl6Gt3UG2fuHQvnIOpWth6NklQ+PZ5L4/
	puKZRyEVx6Cb7xHgRdU+3D/cjzZMEpGQSdgiWEFykye2AvoLMPZNtecKh3LTGtnKmpK8vK9BnfW
	PggCGfqcuFMbiMMZ4E/aD0Ox522psB2mZSpDxSTDJ0EZyprAjJ1pVQEpZHW9IHlj9zmQTYF24vW
	uHgNl1z1Uaxo81BbNaTRCpUv55loTxHZAQg3HNXsNThTkeuNYJ5xjI5GLVzSXcTHPkTTgVTVUTV
	K05+OUKbbhwJbIpwrQg9z0Ynfh5tDcpgCi9FXs2YczzF5LCY5iTxFhVZSL8=
X-Received: by 2002:a05:6000:2909:b0:43d:29a:e42a with SMTP id
 ffacd0b85a97d-43d150c211dmr6936101f8f.29.1775052529247; Wed, 01 Apr 2026
 07:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac0hLyMuPHiZfnVc@computer> <20260401134921.362148-1-varunrmallya@gmail.com>
In-Reply-To: <20260401134921.362148-1-varunrmallya@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 1 Apr 2026 16:08:12 +0200
X-Gm-Features: AQROBzAyPknqbXnEAJ3AwqA7IYVLrAYRqJiT7mIsqGERF9toiQ9NeCx7u4QvpN8
Message-ID: <CAP01T75D7p2smSyoFvyZykgC5bJdobL_cqtk6-w+LmP4NP9SpQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject sleepable kprobe_multi programs at attach time
To: Varun R Mallya <varunrmallya@gmail.com>, jolsa@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 15:49, Varun R Mallya <varunrmallya@gmail.com> wrote:
>
> kprobe.multi programs run in atomic/RCU context and cannot sleep.
> However, bpf_kprobe_multi_link_attach() did not validate whether the
> program being attached had the sleepable flag set, allowing sleepable
> helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
> context.
>
> This causes a "sleeping function called from invalid context" splat:
>
>   BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
>   preempt_count: 1, expected: 0
>   RCU nest depth: 2, expected: 0
>
> Fix this by rejecting sleepable programs early in
> bpf_kprobe_multi_link_attach(), before any further processing.
>
> Fixes: 0dcac272540613d41c05e89679e4ddb978b612f1 ("bpf: Add multi kprobe link")

Please use the right format.
Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")

You can add the follow to your .gitconfig to generate the fixes tag.
[alias]
    fixes = log -1 --format='Fixes: %h (\"%s\")'

> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>  kernel/trace/bpf_trace.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0b040a417442..af7079aa0f36 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>         if (!is_kprobe_multi(prog))
>                 return -EINVAL;
>
> +       /* kprobe_multi is not allowed to be sleepable. */
> +       if (prog->sleepable)
> +               return -EINVAL;
> +

Looks ok to me, Jiri, could you also take a look?

>         /* Writing to context is not allowed for kprobes. */
>         if (prog->aux->kprobe_write_ctx)
>                 return -EINVAL;
> --
> 2.53.0
>
