Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B9308F1A
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847708; cv=pass; b=kt/oXKgN/FIqVu2o1QU7c4rIR+WW4Z9cz2ND1dF3RPGU3qWHfJbz3uk9F8kAorCGfiPukYM3cfAkrMqIksy7lWzBqEM69/YiIo5TIk0JxPaAQC9mOWmYfZThbaZGSVXeMZCez3Vn3AB0rJOvokUAi032Tj+PvFs9N3PF/GWjgnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847708; c=relaxed/simple;
	bh=tCJq81FL66sxDKBUIEICJqHR8t85p21VqUlVG+I65FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRvKW5tvuNmSWjpqOk9H+EBcuy2NYghj+eccuZqHVW229yHAYVtr3+V7JvaaAm7BY2Io1DdTxJXPzLdskAZTuhJnMQwlbGcPhXYOmSKt5/Su61Plqi65cJ8E4kZnGPwtbeSs7+ltNYfT65v70MsYW83VxuQRRPUofGxqSTn4PMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2NPtheY; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2NPtheY"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso67113465e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:08:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770847706; cv=none;
        d=google.com; s=arc-20240605;
        b=V0WDa5Tv4wEFgejTEHTACejCE/pHjqaI0PqYW2YJbVOKh1++yzheL9YoAb8GnfMxYX
         Km2pHgD8qIDdNCrkRXWN/uE65ZdPI1NbwvHQiAvLLjDQe3wIglWCSrNBG0jawzx1UICn
         9E+vrAh8USHDuDoGhkOrvZyabtzz6sYnwdhIxRoaqLhxvPYsuKEJyo/8bStXQLG7ruza
         XqscfnfhPdRJwuoqZRq7sXnM8QhO/qZz7eBKCpHrWMJcOq8H1NmR0B7vMgXdDlnIcOlc
         0JwsuCQrAkylBQQkAYJhBrYfTTVBGq7kVAwGbaEWTegomeGj1QbpXJ6eFfYEnak0uR70
         t37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3nTqpfkQMQ6pdlJQ8OFriQBu1jaouWkYbDuGI2Kjklw=;
        fh=/vcNYrAJJb439dsZ7iBfi10x9/H/MJg6e/sjvEyepHc=;
        b=Lnzpk3N2chpswFEhgcePCIDD7OwgJAL1CPnmFnEK+Sxqm/NuttUwBafwa2Bt3s6VnM
         BM7ooEu/iR9zbKuK03CeW7HDiN7bfEvloQpTKtvfKe7HA1v1x+jfhnJNc78f+PzuAhIU
         Q0E5xCfK7Xvd/Q/LOWQ3Tm0V/cWO4AH5bDQewCW60vnz13RWJG5gB6jyjVsmoCTesVYG
         mvc2UouiNAKfNghRs0XxcSkn7ddKehF0XbIFh9swiFercEHMNIzVTYzDqd4ryrqTVi7H
         V2I0DPaYuowPbZEKVHtqZ2ARC0yebRKbU/WYYClgqLRrQhoGZJZr4TBz5ccIAsvDjXbi
         xKqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770847706; x=1771452506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nTqpfkQMQ6pdlJQ8OFriQBu1jaouWkYbDuGI2Kjklw=;
        b=k2NPtheYBLJsHMqIKHaX7OIAF1YbauSI3ZzoLbEYL1c/FMr8d3pl8Y/jolFHUGBVA8
         vUCl5jCNj4COYFb7u9sbDui54QQZ6hPzdH03oo5BTaPRlPwmelrW8h4300/JCSyBPzpd
         FuaZ/OP3/BumD4zCwC9QQffHJKxR1ju/RIgJzkpWKRW5Q4TJjxBXAULeQpwD6y7G60XJ
         UJAhJoOgZkEBGex8+tCpxCeufT6JG6S2a2tHGaMHmKj3zPSDb+qkeR/o8EkptEUf4Ifc
         fyiNXoZN0jV6b5YNx9zTtzhSK+LmZ3OR/1FaeywLtHRzjAzLcTxRH6TK91XJVGAd3Mhw
         6LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770847706; x=1771452506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3nTqpfkQMQ6pdlJQ8OFriQBu1jaouWkYbDuGI2Kjklw=;
        b=QOwHQBXrZNer7QI0YWE3l0j9+HvMGER5Eba0TPrMza20BAE5lqYh1/aVNtnJOrVLtR
         BxkX833ixNrK4DCeClylALpf9wwG44hMVrlwYph7k2tYfjKCEx/1PLUFp38ngZCbCKct
         VfJgt4ODYt3DEMnDQ7SIdExijmbyDmTDAIhPGqbzUlh6kPSnybj4877D9eGpIdcUqymq
         dhc2vovLbgA97nMWXs82a2B7Seegi+fkSlT7ltuA59X7qnPERK1f463/QQEKNSXgrjgZ
         vFJodGU82tiMZw3f5uF/GI2S34LjXaXl642ZbNb+QTO1dIls1DTjeXSumIurH/0z1hqu
         WIvA==
X-Gm-Message-State: AOJu0Ywc7SZZSBoCtDZapISKvtidR32hFmcb4ZLMYcgmXCex7h14b8o+
	bcVRG5Hm15fMsWO5GvmK2cW9J3ZZk+7qoyZSBm5F84fPaYzZwyfcRtbUIf4HOJfBDHOZpNKfG2x
	qRv71hSwGU/9qg/zlJ3JJeuCwxM7hYg0=
X-Gm-Gg: AZuq6aLnwTAyiKlTj/RaDDMX5cTWJzeXw6lKLDOJ0qPO8nlwLsIHxaJn1/TEktJ63/l
	XQ7pubRUn6JZEionzSbRSk/zfqGJkcdaNUxfvNODYOlUfcSItLIrlwdyG1D7lWIRqK1oFFsKYV4
	Z0d/B7MkOqsUnkGh4cTWtZ9V/yjcnuaT8/L6bA/V70bG937gysnbDkLP4/fAUjoekGSQ4wyuzol
	fo+cTy4lZAboLXYrvG6NBIS8dqmZkhUBx2eXqCgfSIrKVC5Ehh8jZL1w0GxgbC74tJrI54nTsjd
	GJm6TfzDZMWnYIQBf3cBvP7UH8cyzj3DReSevjBlXGJJZSdFwLZtccrWn2NQL32NRp2aPOK1ivP
	TVUmXERoS9SmLbkobC2E+FUGWMg==
X-Received: by 2002:a05:600c:848d:b0:483:612d:7a5c with SMTP id
 5b1f17b1804b1-483657166a3mr10252425e9.25.1770847706017; Wed, 11 Feb 2026
 14:08:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211181248.3040142-1-memxor@gmail.com> <20260211181248.3040142-5-memxor@gmail.com>
In-Reply-To: <20260211181248.3040142-5-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 14:08:15 -0800
X-Gm-Features: AZwV_QiKNI-3VXNzPwtjTihb_VNkIrzme0TMkBYTohDkQr_5GE9-3b732pfY_kU
Message-ID: <CAADnVQKBdZC-T1q-qPB8xxXm1KkXz0maGu7EszhQE1aKX-HxFw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 4/6] selftests/bpf: Introduce concurrency
 testing tool
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 10:13=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> +
> +struct lock_val {
> +       struct bpf_res_spin_lock lock;
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 3);
> +       __type(key, int);
> +       __type(value, struct lock_val);
> +} lock_map SEC(".maps");
> +
> +SEC("?syscall")
> +int conctest_rqspinlock_task(void *ctx)
> +{
> +       struct lock_val *e;
> +       __u32 key;
> +       int ret;
> +
> +       key =3D bpf_get_smp_processor_id();
> +       key %=3D (__u32)nr_cpus;
> +       e =3D bpf_map_lookup_elem(&lock_map, &key);
> +       if (!e)
> +               return 0;

Pls remove all of the 'if (!e)' checks when doing lookup from an array
with a constant.
I'm not sure in the above the verifier is smart enough,
but I think we improved bpf_mod logic recently, so should be.
If not, improve the verifier :) and let's get rid of this legacy 'if' check=
s.
