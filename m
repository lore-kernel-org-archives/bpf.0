Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486640DFAD
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989075; cv=pass; b=qslW3J7GdWiopUxos09ievdAhQiEQ/6uHGp2TYTLKiOw2kXA2iA/MRx4Id3sYHr9ccMTDSI5VAvsXGsgdba9mFU/YSQUJQ3B/jaa8L/zZAl9OXjjJT3iApOPS7I+K0zGbF5NhlHsyXyfjiFwVxQV82xvwlk05yUxHGTU5vNZchk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989075; c=relaxed/simple;
	bh=rR7yJkVeAU+bU7zDCIhoy1g4AE0IgeCxaWBV/S19lxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAAmhwoy2eJYbpmjBh+MfKnphHlQKUYSV20AM0DyyEDRZ6mPSVqagYuMRqPyoOwKl7u6sud5OsqveJjcDr4toEdSOPV0QCgMlJ0b52odKfip3JzfiUJepMJjaEA2sWywfA75uHT4NdIcGIGGHVlIwT64qydzbHkUgeuINBi6Ais=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4SpdDL/; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4SpdDL/"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so5738931a91.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 17:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776989073; cv=none;
        d=google.com; s=arc-20240605;
        b=cDo3lWdgAJgdXVk0NMmKuyzi9lD3X3Y4objwErJTmXyPyx0xFA36O2YxbLhZJveJv0
         XTeZ71AAUlt8n83p1vVSPQLEK85gVw92xRVATtDaCFpsJAAmutcUSPCf+EGXfIJ8AYMg
         GgtZz5T1plD1PUM63sh+zPwCi/kwV5oRuJYCqZZs7Pwm1fNxM6GjdbduVQBJ64p2ej6b
         IP/AnRrcJH2jQCEk8z5EH15JeDFnnH7veMzdrIwWExYj28LCfUY6i6h9fvR198HX6iyR
         tV1JDG81gHkil1HZy0KYsT85Wv5JpNXgzPKq7G6zO9TUJTKQoX3daS1/dAUmV4sa/Uz1
         BMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FAB5UxHLGkfqH3aRKTWSgh4XaJyzbZFNomio95Cy/qQ=;
        fh=zJ7odwitiZ4Go6vwe9A1wHagnO8NzvH3mQM+pdfOTPg=;
        b=beRVS1j65y9HeZTI7B+AC/0StYek2atEdJuGmakdbd4RHcsnNVEY5zSOgw+lCwYtFu
         8gFWBZp7sJaq42VZWgWkTt3V4mUcTQSwiyJv7XVYj+V9EjX5ASmEN0TVDp/ERs23icxO
         OYoKxQJt27CYqH1Gj/JIrOoNIyjr60Wc5Q9dFH9OR+TEGVYRbe3he3x5aJou1PE5Rtak
         /PML7uPvwj7qfgt4LV2n1RUX1P3JlnW+qNNAROWmglv/yXrZtdE7c/GoOtQMU3rrHNzJ
         JKrYOFpi6CTKnvZPRUSACAoK3JFANTuqZh/mMlRjqfXy1NLzjfYv0fosAycfNlHfPbH0
         Kp+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776989073; x=1777593873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAB5UxHLGkfqH3aRKTWSgh4XaJyzbZFNomio95Cy/qQ=;
        b=d4SpdDL/OevtWmUXPEdI9Ke22c+/+ixlMX2mYOgbhr/tlVUq1x0vBimLXtE7NqM0ZU
         gBF3dEhR/jKSWhci2XHx2P4CTC0UE8mLnneznBUWklcekQQNMTNGaoYp1iqoDL58SwmS
         5ZXIqB6dbxMSLCiI40eCBCcdDUXS+Kx/9jToQyqETEhfmbSRDugL1er/lHYvqeHnRkRv
         KrhD3fxnudKzNv7wM5XfILjuATcXhNLsBbeOfrp+HZ1K1isWka2RQ29TyJ6oojc4zybi
         Jul+W6zXdU6QP5YCHi+KbY+G/JAxd98wet04kocHDV0YrUjpK6fPU31nrZiL/+Q2Gl1q
         vEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776989073; x=1777593873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FAB5UxHLGkfqH3aRKTWSgh4XaJyzbZFNomio95Cy/qQ=;
        b=HHDtOKGX8a7Jhnnf+S/ekxfXrBXjjNtCEzmez6mxNJ/ivwwxTgYoQv5/EJPIAY0f+m
         U34E91YhwatdgRHd0qYWqismlgxTvfgG0H5DxI/4lWRH6i1f6aQtwEIVTDATnsQ6Q88z
         5KXdzDUF8c5rA3M0NHMgyuQCpGQA1sJpdwlQYL0QPM2LfeSa0kvI7CyU7tkaTLNYDZQU
         cXse4Bc5Daonod7Fu+00cHgo5np3b6duAFyOUeNQNbBYf54EJ3cOUomuX0314AenH3HI
         oeTvrK4lCD0nUftmtsrmqR/+vlv0H31Ly3HnxfiIbvmmtVK/2k8lb8BDAcD4alxcRsIa
         Aftg==
X-Gm-Message-State: AOJu0YxGDZV8Cregxlhjaw+4nrf5/ZO1zbY9hOgyCsA/P1cPsftYp6oZ
	CS05I4CjOcp8HM8v/fmEk3QRDHyoXjDta/GCM2Nj8ceLrEJVewIs/ueTMZPfcgn5sYMGgC3IJ8e
	AERbPHEpG01GmgMCD9VMNEFpqk+s7vKA=
X-Gm-Gg: AeBDievEWjIsnM15g8Q7STYQsI/oYM0cPEvHUhYv3o1QZtzxrWtuGL5by98YmbKrEUM
	oPz+UloUTcXqZ6NHZhphp/+/aXvVXHjtTp6KNvbaF1RXjYZDoA2LLvGiFj88oH6qgJlaAZPKbpt
	bYNmG0QVb0dXBUKGsyyJLL7b3d4I7oSKKekEl/ZattU+e/9V/Wn/mrgoLIdvclGek0OovQ8xv5G
	Qej5H2RERgtPbtNkB1JEjZ+hFdeSf8enIh18XUORSjsEBJV4Qv7/TUxGZgpm89+pN27fK4BOsfT
	YhBaPVy29HmvTD9E/O7qO5jFvk6cqASg9jmB1BmC5Nm4
X-Received: by 2002:a17:90b:562b:b0:35b:929f:7e95 with SMTP id
 98e67ed59e1d1-361403bdcfcmr30802961a91.4.1776989073332; Thu, 23 Apr 2026
 17:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-3-ameryhung@gmail.com>
In-Reply-To: <20260421221016.2967924-3-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Apr 2026 17:04:16 -0700
X-Gm-Features: AQROBzBCc5pqEFftVacWlfESInl23hSRMNeIxUTHFTaCSQoHlqvOHxidBSCmDd0
Message-ID: <CAEf4BzaPi0jTQM5Nuv4nGY2R19D+ZfR_WbgMzqGPvbG7GqEQGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Assign reg->id when getting
 referenced kptr from ctx
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Assign reg->id when getting referenced kptr from read program context
> to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
> referenced skb in qdisc programs using a new field reg->parent_id in
> a later patch.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 41e4ea41c72e..93003a2a96b0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6448,8 +6448,6 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>                         } else {
>                                 mark_reg_known_zero(env, regs,
>                                                     value_regno);
> -                               if (type_may_be_null(info.reg_type))
> -                                       regs[value_regno].id =3D ++env->i=
d_gen;
>                                 /* A load of ctx field could have differe=
nt
>                                  * actual load size with the one encoded =
in the
>                                  * insn. When the dst is PTR, it is for s=
ure not
> @@ -6459,8 +6457,11 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
>                                 if (base_type(info.reg_type) =3D=3D PTR_T=
O_BTF_ID) {
>                                         regs[value_regno].btf =3D info.bt=
f;
>                                         regs[value_regno].btf_id =3D info=
.btf_id;
> +                                       regs[value_regno].id =3D info.ref=
_obj_id;
>                                         regs[value_regno].ref_obj_id =3D =
info.ref_obj_id;
>                                 }
> +                               if (type_may_be_null(info.reg_type) && !r=
egs[value_regno].id)
> +                                       regs[value_regno].id =3D ++env->i=
d_gen;
>                         }
>                         regs[value_regno].type =3D info.reg_type;
>                 }
> --
> 2.52.0
>
