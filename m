Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F65332623
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258247; cv=pass; b=hIPTbARSh9faA8AywtOGZH4hn9RJ7kRt+tKNJ2cTzSy4JYT4vaPqabQu5T0UbaM4uPO1x40eEsH3iMI0Hlsv3CjWuLw8YyzlvAxBYI4c7DdlkyJlEh1uDJ7ZSozutWympjBob5WQJ/2sr5TDOmu1V4d4zQ53mb151UwAkWotV4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258247; c=relaxed/simple;
	bh=1nbmNN2+uWLC1om5FX22Xmv7l/AAsmEpegK3jh8gm9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSnvbiPvd3wpUihAHNopkG0boxxiWG2ECWbxmCpn1SJbEkqBQ5H/BcMB6OtFGCSsNXORZqzShXEJYYDJYqbhaYGOeBo32E0gQZN7H8Kupd6t7ZFYDcgMHinzr0HzbGpc5bKHJ1Bbj07BzYh/rYi8BHfAtlAvpAy989wnrgmXDiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KniUiV6/; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KniUiV6/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae8177446fso2639045ad.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773258244; cv=none;
        d=google.com; s=arc-20240605;
        b=ZMupOtTXnbpwyAgOfWATp9btlKDx2h8GY/iCj+6qkSIiEr7aqszLcg3s/G5WZWj0Rr
         be7iWhcsAJsxmZnKEEhAtVmWMcS2lT26KV5Uu2RlL2lPSpsZ6+bRDlNiMUnnxQhzL4AM
         4BojjAzTuDvX+h4XJi3bvDLM/KXREwqhxuHy8BJFkWoRPTU0f0du/tgKjAKqhEit8Ni+
         LFHRBQiSNRn5yBk1fG8YZ2fyQ9W2KT2RgPRiEXXMHWzyDk6WMxwmgqwrzNvZLsI3sFi1
         gqRY7cSZ/IBdySgDjTdPSWCvzkF+wa74ETxiGWV6vWobXJRe0x7Z8H/RRaAL2DS3u2p5
         iIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iEAE1DR3z4IwpbaUy8A7+sGJEjgivXuZJQBR6NB9aws=;
        fh=HFezYODqB0dHS8ZckTal1iiWnuisbLhk4gui7Bi0T/g=;
        b=l3RnTzFCyrn5vtFyD8fOhuQrOmdn77v6p8Wdp5gserFEI8C7NkGg6tThN/qK73hszI
         mNNsUFCVScrCSon3MPIwAIoltbEYeZrLO/TEmQaGh/frENSxcoAA4c/lbzsC/VP5/QIH
         hzxR03U3jy+D/4Bvjh9vS0JvHO3srAByK5gQ4K+RdQpFQ/zesLHZw5Q7elfaY2TCUiGP
         HQnISBCcE3pPafoYIxREU5ri7ihNl6N/dc3heNxaO1p0vWFCK5140h8EZjoHcIyALiQc
         2r8zGS6S7+GRSEw0fP4BCkMDoqJI8RfWjTU+NTOJiUvuxy7CL9DBCf9cwSPUCFWz+Rda
         mKNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258244; x=1773863044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEAE1DR3z4IwpbaUy8A7+sGJEjgivXuZJQBR6NB9aws=;
        b=KniUiV6/XFNmf0hJB5ioZzAUVseKPmiaEBfcQIpIoa6KxbcAoInWV2Nt+xQ/+F1YbJ
         /nFfbK0UG875+X5tUOOfrBL2RafG+lUxulKb17BCWrUFPmizYQULXD8W2m1BJ1ZQXiXY
         Uff4OMkgXQhfIkRHFESovBiMCswuVWtWYrD0fweteTh1Viw1zq6wB52Klv/6qabtHGSo
         7fMMSZXGuZmwefEj77bRuNVL99M8rScV01zksjIiOHqpV9FLArH4fmr0tgP7Ovp9aq0F
         7h4X55fvqNnSux+B2ZKHE7q8bovEJ670hfV2/WRDtLq/65qCRjXd4ngqxhlkTcN4RG8n
         0Srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258244; x=1773863044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iEAE1DR3z4IwpbaUy8A7+sGJEjgivXuZJQBR6NB9aws=;
        b=OyYFvqoe2PxEzlyIyuznHrL9ePIFNRDIN0d3QQEakXHheCqEvIvXgSjodMpHOdPIe6
         NJizLtKN1Et5Wd6RjQ6jr/kEZaWcOQO5Vwz+hSeyq2V3NCA21IIZavNs2AH4qvoaKu8m
         hErS6vjcArogkpAT9YsLb8UE+QTcOsIkNxxs6l1DnyUN7Em6sMTaE+TYW6fBTKaOxlgd
         yYzDYlokFVAvDUoyLx+wlLZOm34pa7YTN/KYJkWRMmMf/eVvwte2AQeGjMot5IVwjLWu
         1o4Zu1ktEaFjDIK2+ok/5YQ2+xnlaDmOFq8c+RTTfB+xOkmc2MmgHQMgxcIDWwWMKs9d
         QcSg==
X-Gm-Message-State: AOJu0YwKfbWKLpGOAH9PInnK2nTF6yeLsHkZJK0Ru4qbe8+KNMWz+Px+
	7CPM8c6kcRufThBxTzxU6HlD1HVw2x9K+KpJdSSctNfZQiDq19YFCx1rQtnx75gTtO1uKFGLjAL
	uiDGLusVbChHwXXzI7DTyt+YtpVEQxmI=
X-Gm-Gg: ATEYQzwWJdZ1PM3WYb9yZPWY8AcFxXfwWbhrhgggS4u1x+vOoA5/kSFDbS1oYD6nOBZ
	uUl1ee+vXkXfjsTcXkFeCgrHgxkYVOwuNnofTG/FFykcTXENdh8z9FHizIcHa/3PGzRLXpDzEWl
	srV1roDc4wTcTbPAqvXjbZ9JKmc0inyHnNlfBRqK9D+00mzx3rW67SF1x+FWdKqc410O73S/ktx
	ZWo3vwCRZBPX029qZQ3V2SeOHnbG8JwWD2vo9pmS1CdGG+lZEcVpSmHc/2uka8O8LaCE+CarFiK
	/n9MGQCvW3/WxHDROA==
X-Received: by 2002:a17:903:3846:b0:2ae:47c9:68aa with SMTP id
 d9443c01a7336-2aeae92a03dmr40203415ad.52.1773258244461; Wed, 11 Mar 2026
 12:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
In-Reply-To: <20260307064439.3247440-2-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 12:43:52 -0700
X-Gm-Features: AaiRm52PenRsEpFvNhvd5ipgeHWlrodqDFVXteRMZhoEVrKoEHLpFtXoYjZLlqQ
Message-ID: <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> The verifier should decide whether a dynptr argument is read-only
> based on if the type is "const struct bpf_dynptr *", not the type of
> the register passed to the kfunc. This currently does not cause issues
> because existing kfuncs that mutate struct bpf_dynptr are constructors
> (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs have
> additional check in process_dynptr_func() to make sure the stack slot
> does not contain initialized dynptr. Nonetheless, this should still be
> fixed to avoid future issues when there is a non-constructor dynptr
> kfunc that can mutate dynptr. This is also a small step toward unifying
> kfunc and helper handling in the verifier, where the first step is to
> generate kfunc prototype similar to bpf_func_proto before the main
> verification loop.
>
> We also need to correctly mark some kfunc arguments as "const struct
> bpf_dynptr *" to align with other kfuncs that take non-mutable dynptr
> argument and to not break their usage. Adding const qualifier does
> not break backward compatibility.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  fs/verity/measure.c                            |  2 +-
>  include/linux/bpf.h                            |  8 ++++----
>  kernel/bpf/helpers.c                           | 10 +++++-----
>  kernel/bpf/verifier.c                          | 18 +++++++++++++++++-
>  kernel/trace/bpf_trace.c                       | 18 +++++++++---------
>  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
>  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
>  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
>  8 files changed, 43 insertions(+), 32 deletions(-)
>
> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> index 6a35623ebdf0..3840436e4510 100644
> --- a/fs/verity/measure.c
> +++ b/fs/verity/measure.c
> @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
>   *
>   * Return: 0 on success, a negative value on error.
>   */
> -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dy=
nptr *digest_p)
> +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struct =
bpf_dynptr *digest_p)

but kfunc is writing into digest_p, so that const is wrong?...

>  {
>         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr_kern *)=
digest_p;
>         const struct inode *inode =3D file_inode(file);

[...]

> index 6eb6c82ed2ee..3d44896587ac 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_d=
ynptr *p,
>   * Copies data from source dynptr to destination dynptr.
>   * Returns 0 on success; negative error, otherwise.
>   */
> -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 dst_off,
> -                               struct bpf_dynptr *src_ptr, u64 src_off, =
u64 size)
> +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 ds=
t_off,

again, dst_ptr clearly is modifiable because we are copying data into it.

What am I missing, why is this logically correct?

(I understand that from purely C type system POV this is fine, because
we don't modify bpf_dynptr struct itself on the stack, but bpf_dynptr
is a representation of some memory, and if we are modifying this
memory, then I think it should be not marked as const)

> +                               const struct bpf_dynptr *src_ptr, u64 src=
_off, u64 size)
>  {
>         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)dst_ptr=
;
>         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)src_ptr=
;

[...]
