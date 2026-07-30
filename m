Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72A39A066
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453079; cv=pass; b=tEM7+5mLmzBINSF4x1gkrmNmc9hLcLYAJdButqnC8dC8X0wTmR4lHv4R3eyXlhCYZyb5L1eFzoWanV2OQWl5r8/06dU5GaHMkCm+iowq/6oi5kWidyri5fkeNPbCxsI1ttF5W6pLWwygxDyTMn1lYcjseK5Q2kyFeQ3NbIAjfqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453079; c=relaxed/simple;
	bh=aAHyLzQGbP/i36dcFzch5gW5EG2i6IOS+QMJLJMh6pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mk4MJ+s9sr4UGJuVPZzOOn1XyZsq1jzqxW1cILffm0vUkleszirzOx9xFnTnqnTKZzrK11InXIJD5up4c37igP0OgLeimgHwAzCGZYjtXExbQ/8jTDOaOUu00OK2wMIYNq7faYOQDZTUCM618f8Km3uNrQK9LLcg7X5MajgZxXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHligVHo; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHligVHo"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84874b52eabso619158b3a.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 16:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785453077; cv=none;
        d=google.com; s=arc-20260327;
        b=nS7SuBAguSViTIMRBPo5sUfLfzMW1BysCM+LW44I6Aeatlk9uBqBFm1jPqP4jpW6O5
         WuxBIyfZzgAdjNlGz4ur2kP7J4zgB+XAqGsVijBj8JuGvORYt3Ji/zPHC69qjDZVvj+V
         tn2eTEw0JY1XcM2y+RJjDzKG3aAjr7CDs2vCAMdXB2O3Ctbi5PlzLjJteQB9lRuQRpqN
         ztuu+RERC66QLt6h2ESVzrqmLBJahesLBMiT+22eCGEZqfrmbf0CEK7t6bvZ/FQxPT8X
         lNO5sVBvQQtUIaIU9DK1zQQAvdAzdHpfjZ93OP7oPTVc49LK9rUTZmoOnoHvNU+E4wqs
         8esw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9VWEQTX9oJXoVpskbTvTmE5W+BfnLm7U7xBM1LJIhhA=;
        fh=Lso6GRs6lbjX0e/GpY5ORD8gj5QB43uxuP+N/kNgxd8=;
        b=FH8deUL6SWHkKCgJqBxnaRVdrqklEyJj8J23awelLtB/FoMIMZiEmmsfe23z8YRshv
         2NEK/W0LijGik21dHDyh2wfrXWtPxKn0Wop3OBZ/SRw6hGEW3IsBw/IeeZn+b/almLiO
         HfOYSkKM54e90qoTYx3tzSoNFtJ0BSvEaXuThgi2zfaTDxyKz5O89AJHLOe2nLrY0qVH
         8I8i9YPiTWLyITsLdV3nOBSM3pmc/oY66J84dPz6mv3wooTnBl0fi9h0U6ftHFgcgjKM
         tdMR+3qYiDSFWQz4yqrWVcnCd5EPHO7vRjVJ/ZrTz+yqWUMIwF9/msnlSc1tQduEXNHj
         A/Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785453077; x=1786057877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9VWEQTX9oJXoVpskbTvTmE5W+BfnLm7U7xBM1LJIhhA=;
        b=cHligVHogG0+v0c0TmHv59afIcB8MUPlZVYNEmEAf4XPyG9WnzBRk9EsOJK2z9Jhjz
         17BVvgwTVCLiREWu4hDr9DBnhrJb807W2f6m1jr0r+Dv0B7a7TyrfEKTmobT8Ifsqshg
         lWJu3tu61aO7gADdHoLVecJIhj4ASq0lWkLho+GEg4ueS5ZEPR7niS24M+RYwO4wmAJ2
         Il/L8gvGrZ69yviFnxPgbcag6gaiYT01pXCaip5o0iZZHwydENoz4SgfbBJqYJU6xrf7
         R2t9rkATvcTglsVj3LnWFFZc1W0ecxdyo1kX7wf3fHj/bUpU0qKiDh7BfsIH1QyWKkjV
         fh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785453077; x=1786057877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9VWEQTX9oJXoVpskbTvTmE5W+BfnLm7U7xBM1LJIhhA=;
        b=OUSAuVzXt55t4vMG9CUcZb7kD6mdYLKLeNM5f6Un0HuUeRNE5UqgXRmnHmBH/1KY8v
         6BwDrvT9pcD4TqUCMQcTr5E7bDqlPaEEFMjmvq+cNWk7V2apCdIdtLqZRDTOvOi/3F+t
         S4W55CfpmWg6jUusRYFA2i5R1bD2GEXHaKmXSAB0cXyVgh978d+o86nEHmeGhFRhX/Dw
         VgMa/x8cXvNKf8Y4WXBRMhZsP0hBpRvj/nygHuDfjyDa+dQLK0WyBGl8986XlrwG0kAK
         tS+nfCTsvzHwN47p8bLdCIzvQyDu6POJdnInm6ezRgH4NFzkSVI9Ywqh5AGj6ByOzEEa
         BiFA==
X-Forwarded-Encrypted: i=1; AHgh+RqSn9nFrMlBxZg85lVd1s3FUrQtCtjT0YcB6UAHEr7S1JNvudT1GyzFS+5jJV5ersINLAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPzU1n3Larvv26sfdLZ/74/C9gyLPJCd8eOHM78h6C4EOQUu8c
	PBSBzXLw0P5sn705mqlDNSVTsEY8EyCTg6dBiWtETel5a6mR3MmpIG/N635pGfehATmvc2BZHk9
	QYIstSV+zx4R3gDzo/NIhZiW81nYFpng=
X-Gm-Gg: AR+sD105wJZ7lNj/LV55kAkac0RJs1hR82SkOOZqSGdNJ7I0nST/nW1eaeJF904+lKv
	DzvkvaS0AH3y1v16O+1thxGOZ/O6owdKZzsTr6jGiR33qRjLmVRzGw7JUtb+8hdqCLWMnIPD7FL
	oZYHSVg3QfAv1uVy4IIa37jIP64yzZlSuHUk5D0LlaXkASTxeAxTNAIbwjacG9g3t1fwfR6K7ZJ
	MUYXUelIyanTMuEP+xWtQQwjPARf+Ff1DSCsSUsH27UuTa7Jj6f/Ni6PGd3ZQ/PYFwgeKyEreJN
	HSgNy+VMhgga6+9Wz0z/cS06vgAcaG3LCRGt1FE093VIvkMB5TX0LdKWJ1cuCXGeVG6hMUaon3q
	xpkFdcnAhCDeM1RRH4FI9onL4vJ30JVMi4VRagt0myJtgh4CzOE5/
X-Received: by 2002:a05:6a00:3d04:b0:848:56d4:3288 with SMTP id
 d2e1a72fcca58-84ebc21af74mr4414436b3a.4.1785453077371; Thu, 30 Jul 2026
 16:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729083807.1588544-1-jolsa@kernel.org> <20260729083807.1588544-12-jolsa@kernel.org>
In-Reply-To: <20260729083807.1588544-12-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 16:11:02 -0700
X-Gm-Features: AUfX_mywuLwCfqsR7O5YCn0jCNqtSmTiJk9xszULcjC-UM5Ge2LLQ0491h4-AOk
Message-ID: <CAEf4BzYvmVJ7bFZ_dmW-HbwwM1yUxzs40yHNdF_JTn+Hr+0w4A@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 11/11] bpf: Clear buf on error in __bpf_get_task_stack
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Sashiko <sashiko-bot@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>, 
	Tao Chen <chen.dylane@linux.dev>, STAR Labs SG <info@starlabs.sg>, 
	Arnaud Lecomte <contact@arnaud-lcm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 1:40=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Both bpf_get_task_stack and bpf_get_task_stack helpers that use
> __bpf_get_task_stack have buf defined as ARG_PTR_TO_UNINIT_MEM
> argument, and we should initialize the buf on every return path.
>

why "should"? what's the point to initialize it to all zeroes if we
failed to get stack trace? we shouldn't allow grabbing stack trace
without CAP_PERFMON, and with CAP_PERFMON we shouldn't be worried
about "leaking kernel memory" because CAP_PERFMON is plenty privileged
and allows to access any kernel memory.

or am I missing more reasoning behind this change?

> Adding missing buf memset for __bpf_get_task_stack fail paths.
> The __bpf_get_stack call does clear the buf properly.
>
> Fixes: 06ab134ce8ec ("bpf: Refcount task stack in bpf_get_task_stack")
> Fixes: b992f01e6615 ("bpf: Guard against accessing NULL pt_regs in bpf_ge=
t_task_stack()")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/stackmap.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index f4827afbfed9..9ab0c2523a41 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -890,14 +890,17 @@ static long __bpf_get_task_stack(struct task_struct=
 *task, void *buf, u32 size,
>         struct pt_regs *regs;
>         long res =3D -EINVAL;
>
> -       if (!try_get_task_stack(task))
> +       if (!try_get_task_stack(task)) {
> +               memset(buf, 0, size);
>                 return -EFAULT;
> +       }
>
>         regs =3D task_pt_regs(task);
>         if (regs)
>                 res =3D __bpf_get_stack(regs, task, buf, size, flags, may=
_fault);
> +       else
> +               memset(buf, 0, size);
>         put_task_stack(task);
> -
>         return res;
>  }
>
> --
> 2.54.0
>
