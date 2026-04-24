Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C940DFAD
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989066; cv=pass; b=RU+AO0atKs0dDKqd8mstuteg1w6GI3D0bNq1Vp/5jrzQQd0y7Xj8qKT5SInR8iFl7vd3cC3K8ww518Uixwgo50+9Z2gkSdCoOYciXK623QJUlwilQuzI4njws9UI1GHZYLw4qE5M2rOrnjDW9BSXZ38wLRBN4eM3X5OiysDDOUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989066; c=relaxed/simple;
	bh=vTzzIgE2JS6IRMC6snTrIYVwAiDYQSSsSpWSe0DCrmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7F2IBApRtSkTg1Pw2ceSqtY/GbD/YSQfzwkRl//kdqxUbE28y7TYaA5c4lf+0XGUSFmBqR+cMZCGWdup1S8FtE/l1N5neAspD3bgbVzdFF06YeTsCGFf50ED0DyOKaZSSV+7jPG+qMGJFRqGHj2IlwEISXdcefljSkv2NjKH0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TErWXGdo; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TErWXGdo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad9a9be502so45492595ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 17:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776989065; cv=none;
        d=google.com; s=arc-20240605;
        b=PbieHCaUrhqsaFEkwPvlRDOqsSiOHQFxZeb/oXB4A45yEqIQz09VXl4VTUVklZ5oNy
         SA13JWK/9LABAezk7t7+dZIMWDPqH0S9MQruvHe2RnwqdWGBnOc/L9978VaepCcfYhKP
         wElwxn7PZkjnMbwLxjbtWC158P9FiHvqEztZR7IYmCji1wCb27qhsBnZSXUQmxyZ2Nkw
         ECKZCfO96PBMdrnrHentyph5Lu/kT0S5Nof0W0VLxdiRkiD+StohIt3kNXT1dH+Wq9G7
         SQvvKmLKkawMsNtGjA65nk8Kqq+NnS+a+yYOcLw5YMU9jxaMeGWyDw+E4CiVXKtKF8cm
         V0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KTZwoGKCRXn3NUS7spmMnD55V+Zr0LB1j5fzzvDTNr4=;
        fh=zJ7odwitiZ4Go6vwe9A1wHagnO8NzvH3mQM+pdfOTPg=;
        b=hYHiRXMurzIm7iHDlv+9es0PzISzbl7WwSgbkCMzdtcbr41VTuwo+MjjtRNAW+Edok
         So5zbYCDelKDdL2sSDOSl9Fdhi6empspLJw8ED1DoKm+M/Cs0bDwxNNqquo0SHLOPLZT
         FeSAVdXsywE/vegBhnHKGfkwS6iE1tgcpuhLO6NRhImfqo4yAYL9W7bjtP3vwq3bmMuC
         MKxI4wxyXC/pHjhVh0r9qvsulCB/eLvkp9XZ1P+N5L/EVTGD15zx/syBMaWTG/PkkCLz
         2QiRBx3L4IKX9W8I7Wj42Ee65SrSM7/ep+TWvWzQ3v1dD0i6GikM9wZtd2LFMiGI/Wvx
         9j3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776989065; x=1777593865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTZwoGKCRXn3NUS7spmMnD55V+Zr0LB1j5fzzvDTNr4=;
        b=TErWXGdoy1oZ4eoTvshWpEZmUnr6hQF/8rxdzwEmBn020aOKP0gQLUNjC8zjmR+6XV
         u4la2d5f3OuE7zQVwbPRDEERan2P+V1l/r8R92fn/iD3FroVuOYxqEhG04MFdp3H1+Mf
         XGJ7dD+bOonV5B91mGCqmma/YgXQvLOgGvi3zNRpo1uHQmtmjLtlEOn0Qo+LAN3J0Vpq
         Ycm2RHE4q8SdLv5UH65l/ulqRVvMDsinPH8JGMwXO6XBsxqeKzCJ4UcniBv6i0ZjBxAN
         sGwzttqqaY/shgvQ8fRuBJnadgdRpnQY1gnq+V/YUHk8GFUKdoA8iWOfgzpX5R28BeHo
         sepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776989065; x=1777593865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTZwoGKCRXn3NUS7spmMnD55V+Zr0LB1j5fzzvDTNr4=;
        b=TK6rPaAJJ6VT3aaNHpieYc3Ww3JJgj5U5j8wXUhs6DYkg5AVhAJ3GMgegZEVakSKAU
         X8+XavzmrIe+awvXu3qJ8yaW6hlfJd1uvp0fbtWgJNrivitJTqVrWi4xXo8ZSrcRNTg0
         RM+iwkf++pbfpie/WKcjtPDMXUfmOHgYtrHlHsyN1dLRu/gLpUGS1qCl1aWBz1hC9CWo
         t3rfhFXDpvDZOjc2+ixGqjFj0uAUoqhDyV2BWtZU347bCN4wph4+gnp78Y3SsTf2XyUM
         gcvtS0poZUZ/486dqAwQ4iBsIMepWChr8RC4jke/jGQqQRMSGz15+Sj872pEI+BunsMp
         XkvQ==
X-Gm-Message-State: AOJu0YwKqUqzt/bee0sY59ynNawAG/qiS0X/s5/sDI91VqEbweCJedaH
	FjtPeKt8xEFSmf0kYGjtk8lP4TovmAz/dxlomgOgZdhgPlvF8rTucv7UYCihiivrQrX+v1kuKE5
	698AQCZ4z5yWM7Dza+Jy706y3ASjDnW4=
X-Gm-Gg: AeBDieu00i0TfhJEMOnAgbOly3p6FeJfMmFT9/YqaK62E+TxxY9zDuSef79sKBR8STy
	KI5MlC+8nVu5fgZomqgVbtZObnvGrdl6li97yvej2ACYBYzqb7E4FXM6jTfNf4dYSZhK7V3p/aM
	rlP/IKvWXceMdmH2YnV6oARZnL5Mv5XC6KzIxfrxVXH3aAEL45hQRR+N80mlOwFzJmWxjYGWJTj
	ZdO5GH1SEFvBHBuIqHfsuhNSUkx1m0z6n2fW1TPkU1B9Yo7mkyQSeAO20gRE//sXbOSq0glEMRt
	yQY0wnbVc3FqalfBvnuoAL0FJqcFDrk3qg==
X-Received: by 2002:a17:903:38c4:b0:2b4:5f69:715d with SMTP id
 d9443c01a7336-2b5f9f36ea9mr350053565ad.25.1776989065079; Thu, 23 Apr 2026
 17:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-2-ameryhung@gmail.com>
In-Reply-To: <20260421221016.2967924-2-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Apr 2026 17:04:09 -0700
X-Gm-Features: AQROBzB8_Arenp3456-5JT05sOdeqNAovNdxghwId6kPXP5l_pUoFbmC8Km46ic
Message-ID: <CAEf4BzZGg1EKwYFG6QKrkNbiE6RwWKew_Zz8mz9rjshKjWzcKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Unify dynptr handling in the verifier
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Simplify dynptr checking for helper and kfunc by unifying it. Remember
> the initialized dynptr (i.e.,g !(arg_type |=3D MEM_UNINIT)) pass to a
> dynptr kfunc during process_dynptr_func() so that we can easily
> retrieve the information for verification later. By saving it in
> meta->dynptr, there is no need to call dynptr helpers such as
> dynptr_id(), dynptr_ref_obj_id() and dynptr_type() in check_func_arg().
>
> Remove and open code the helpers in process_dynptr_func() when
> saving id, ref_obj_id, and type. It is okay to drop spi < 0 check as
> is_dynptr_reg_valid_init() has made sure the dynptr is valid.
>
> Besides, since dynptr ref_obj_id information is now pass around in
> meta->bpf_dynptr_desc, drop the check in helper_multiple_ref_obj_use.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  12 ++-
>  kernel/bpf/verifier.c        | 178 +++++++----------------------------
>  2 files changed, 41 insertions(+), 149 deletions(-)
>

[...]

> @@ -7433,7 +7426,8 @@ static int process_kptr_func(struct bpf_verifier_en=
v *env, int regno,
>   * and checked dynamically during runtime.
>   */
>  static int process_dynptr_func(struct bpf_verifier_env *env, int regno, =
int insn_idx,
> -                              enum bpf_arg_type arg_type, int clone_ref_=
obj_id)
> +                              enum bpf_arg_type arg_type, int clone_ref_=
obj_id,
> +                              struct bpf_dynptr_desc *dynptr)
>  {
>         struct bpf_reg_state *reg =3D reg_state(env, regno);
>         int err;
> @@ -7499,6 +7493,20 @@ static int process_dynptr_func(struct bpf_verifier=
_env *env, int regno, int insn
>                 }
>
>                 err =3D mark_dynptr_read(env, reg);

if mark_dynptr_read() fails, should we exit instead of proceeding to
fill out dynptr info?.. even if mark_dynptr_read() cannot fail because
of is_dynptr_reg_valid_init(), it still looks wrong and error-prone

> +
> +               if (dynptr) {
> +                       struct bpf_func_state *state =3D bpf_func(env, re=
g);
> +                       int spi;
> +
> +                       if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
> +                               spi =3D dynptr_get_spi(env, reg);
> +                               reg =3D &state->stack[spi].spilled_ptr;
> +                       }
> +
> +                       dynptr->id =3D reg->id;
> +                       dynptr->type =3D reg->dynptr.type;
> +                       dynptr->ref_obj_id =3D reg->ref_obj_id;
> +               }
>         }
>         return err;
>  }

[...]
