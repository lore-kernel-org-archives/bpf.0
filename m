Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1893B3BF2
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232793; cv=pass; b=ftVTmQvHWF8ZqxJ41KRdjo9PBZz5QYkDUCucixCxIkpnG/XgfuWj5FjztMJRYgNKpi8QiKGQFw1unt0hu0sW0aVy9uHMZqQLTZXNrDR6SdTpvrpznZmAysGChz6dXuXg1vBN9L7P9tQXcE8OxveUu/ZsvjTJOGkgwVkeAhO8AYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232793; c=relaxed/simple;
	bh=Tw92wCgtX64w4RYTjVLKytcgWHeN5opE2HHm0QpdkRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVu9xRBg3MBOC2rJv8ep8bbeQFp6ZMI8oDQRUdd3ZwI4I5heWYU//Dg12Uc2XfKJOplhttMQoK+StgH82xfiWufahmBQngDbgZkpfSQPfrJ/3iRIFlYW07fiIGp5AmHNtmTUBGLtzBOeDmQ92vOOM495o7zl6/p0XacyZ9aH6uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPB2EHR+; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPB2EHR+"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-864cd11a932so6938467b3.0
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 20:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788232791; cv=none;
        d=google.com; s=arc-20260327;
        b=onhVXzv/AaqrufTMyWQr9K0Wvju1T9EhpOQnUm6eLlLJrVM7jSuTvkNWREg5NNUV2e
         8uJrG+DAUJPYiNJRW3Cb2ayYcObcaC7KWHNSTGO26NVr/z7Q8Vl+MuY2F3bv4mkbZv64
         FOO6laAfMIO6rIXKVL3RQp54FhpcqJvdR4j2SDdbyrwTi272/dheeCesZ9dwMww4KgBP
         UwhZY86HGIfc6x0PacHwgbh9bnmEat8gc8g0r0cgv3tita0UV6i7XXCCljIQH9HDA4ct
         k+ImOscVtroGwvoH5dnovWPzBmg5FvULOdw3W7JlGJckJjmBSg5T+PpUT7xdVegQL31M
         IIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uxfDC7P3hjzDwZfMMU4ZVm/zbG7/WqTWINl4wOrB0SA=;
        fh=WV/XN5X1oEf527+V7W8SMtugzL9N6qpwP4JTepq8Hy0=;
        b=He2hubiM9PfKOD3Kw3eTnHhTZw7kePtKcFSKd68h261lDAu02je5Q1lQFvQwsH0uvC
         z53pK7v3KJcIvLHylvmUwsA3EQStG7vqfrOBh/iAjuQtpbtMtPo2MYXeq3l9vyEeaBm+
         qgvR1t16123oyUoocpHbcvcXOq2QD1DAhgbTe3exe6BZ2OZ0Lbtg3CWIrVvM8xzjr6Eq
         G2j5T9+jNe+44uA5yPiDg0FPkKLPEXOmzgydTK5C7gfTXYqGaNYvTXq5naydaqsTyAZp
         sbCA3MoEfLiPRdPUQXIrErh34KMKnyE4mvHTGuHV6jX7uG/jlwY/IMMTUn66ELc6byGX
         J94w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788232791; x=1788837591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uxfDC7P3hjzDwZfMMU4ZVm/zbG7/WqTWINl4wOrB0SA=;
        b=lPB2EHR+6igVUVdCc+ca0JhuA+VEPlYznluHBt0xJL+bvXkmja7ZXtt/XstECP/MHP
         1Ghu/9LSqj650L50NVqs8Gx7Bx4EkPw+8zLNKniSQ63QrlVchaglBkHNC4CHCMBTgy6D
         OmfkiSxAvSWIMzF3r5NLVanLlv2NVZGtq4uywe8USDaP6DRh4OM/hpuT0XybtI72p1Hs
         EUJWGqmmWuuSIc+F/WfmltcKxzr3WKeqzq/kqyRFeoiT1oZzvFafm1zqjyGn+HGmP+ML
         T6m1I72hjvSbmVs5+VSv1VFXDV+sfthcB1/0aKkiygCqtQgp+t/xe+2nQcHFI4Of/Pwz
         MlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788232791; x=1788837591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uxfDC7P3hjzDwZfMMU4ZVm/zbG7/WqTWINl4wOrB0SA=;
        b=mP9jW6VZ9+tA5psYK6P0KRHjjKmh1cIClpvNmsMmRFqkx0mhDvwGrqdqn2R3+mZbV7
         qh9cYqv2dZbk3QZDpc1WELAW5xwFBN7ZaZKpTfd2MyKXK+OlHYC07Fl6yRFgVqpbvCNH
         MbbbNBtG0hgu1Me6oOczzKHqco9fxSZwuiIeGnpM2/UhRnYtuEMzzpv9R2jjJmzQ467j
         X/BswNdpEqfmTVE9TFA5MpusAa3l0o2QjHdHo+Hpq5txJmLDFRnL/SJ3ZMNYEUf+k1/M
         0os5m0U011AikmXvfVT110/Vwmfd0SzM93P9X1+BeiW1gw6b6lIi7+eLfcs8ccdRBWD5
         G/ag==
X-Gm-Message-State: AFuF++nGvPivlzB978CIpPAtncI43zLfrHDHkqvvSPrcl8W5EIfpTfjs
	wEw+cDFXHEny9/EQ00nrkyYSq/DSv/cEXFoZ8sn8toS5soxc1mVIIGoKfBWQjddzwcbSbIwcYMw
	6bLr0tRF3uH75BgrmsHW4QZO5MC0Mou0=
X-Gm-Gg: AYBFou2D8KOnxWs+O7MI6mrHVjo3ytCDx0fkIE5G989NXFoDJyMnr0ytJF0z46BjTcH
	UY/tmE6peR0DIGHMa7QNujLtsDcTEgMDpY8OEx9Psn3wnoUsoxwYirSQ6VKUa+akEZ4nBmwww7N
	p7umBuZ3yl5LWOvNw03z2iGseQLAhPprlVwLJ1YasTgIXld1RmluakTXLa19AgNNm4zFP319mrE
	qtPLbSPpPjYDg9oGZodAShPLX9Mq6UI2/yqnyWUB65epD8a1mgAsQN/+3d9i71KcJCCC9BRlbXg
	L3zLZxM/lXUM/J8NF7TEqvWZvcG9VeKsWBjkOEJqIKkcyF4z7AoWI2xMO6ymXv1cjc6ckS3apd2
	GMRKsgEG9x+mqpewOSe3g2nbN3THni60hXw==
X-Received: by 2002:a05:690e:419c:b0:668:43b7:acd with SMTP id
 956f58d0204a3-66f8a41a3c0mr853872d50.8.1788232790590; Mon, 31 Aug 2026
 20:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com> <20260831092305.42062-4-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260831092305.42062-4-tasos.papagiannnis@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 1 Sep 2026 11:19:45 +0800
X-Gm-Features: AcwNN1UzotP2OBEays5eiLg4A4d5qM5oPgXZ3iL75O9H0DWfs8MThC678FLuhRo
Message-ID: <CABFUUZFToRDtvewhqHOWjE1h+7o-cmb1D-z3Pe4oXTVXzt6Z_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] exec: Clear bprm->mm before dropping its reference
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	kpsingh@kernel.org, matt@bobrowski.net, song@kernel.org, 
	utilityemal77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 5:52=E2=80=AFPM Anastasios Papagiannis
<tasos.papagiannnis@gmail.com> wrote:
>
> Once mmput() drops the final reference to bprm->mm, the pointer must no
> longer remain accessible through struct linux_binprm.
>
> The successful exec path and the bprm initialization error path already
> clear bprm->mm when ownership is transferred or released. Do the same in
> free_bprm() before calling mmput().
>
> This is required for eBPF kfuncs where bprm->mm is either NULL or points
> to a live mm_struct to ensure safe access.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> ---
>  fs/exec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index a14f28b15607..4b4d8f0627a7 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1453,9 +1453,12 @@ void bprm_drop_loader(struct linux_binprm *bprm)
>
>  static void free_bprm(struct linux_binprm *bprm)
>  {
> -       if (bprm->mm) {
> +       struct mm_struct *mm =3D bprm->mm;
> +
> +       if (mm) {
>                 acct_arg_size(bprm, 0);
> -               mmput(bprm->mm);
> +               bprm->mm =3D NULL;
> +               mmput(mm);
>         }
>         if (bprm->user_ns)
>                 put_user_ns(bprm->user_ns);
> --
> 2.55.0
>
>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
