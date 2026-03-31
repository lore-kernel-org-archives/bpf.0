Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72480449EB0
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979805; cv=pass; b=gjOCVeXgyh+XKFEkoPsMtIPxVtPbzxRb7ETU0cIhs5GdRgDlDE218vMQ84m4d9v3dzkyj2IpBo36YSgYnWuyqy+vy4RHZdVDYSho6yEUOyLiXDf5JvimUJVazoerkGKcTs/mXHDfDrjQ5Ab1mS7kR1S8E1Xc9/OXSKK2XY2FhTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979805; c=relaxed/simple;
	bh=wGHpIzOAcsHAW690eu5DZr/LfHt2MdMpvym7tmjoYhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhuzMyFpzU/O8HKLciYRRgpLXZv8fgy0g7KmvISClsmIByWmApPnkL/0q52+KDew4XtA8HgMtrv9nsKm8BNv/iIGJ18XmKP5VNE9j0xTzQuhXuheq4Im+WjtKKixQF4ypUNSFi3t+FxNmRjb3KUlrnle69Vn+tEgSDMf8jzL+q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azLhY1Iw; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azLhY1Iw"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-649278a69c5so8257275d50.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 10:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774979801; cv=none;
        d=google.com; s=arc-20240605;
        b=FJg5m252mfeECVgKpWqbcoAeyBvj/+5/1kCpxz2mXhKIce6VqQ4TLW4oZR/Sf7xsKF
         XVURLsECnWOvC9LUF70Q/B+rUjOmUB0P4UQ2SzSWvR40IZRDWHXj+VTYrBh6CFQKPXuw
         fgjyEAGF4JMB6KQT++rwnFsHqqZaFi8n5+ps3rHzJ440FNQS09wWUf39ZIjcA6FhagzH
         e5S4ho6BZn+VpBl3nmODWiNYsmh0O2Iu8/BnEU2Ne8po+5j4IFIi1icXqA6emMSuaA+C
         Ir8AAiYFdCfjSlZa4AGsexKgbNOJyyUvpkfv1aMq3GEb2DK9cHED4bGsiOZN5sNgjZXY
         CEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mG7GVo4QPf18ZEFXSFarizVdr4pLMjODERGFFPI55Jo=;
        fh=vQ+yIjU9WoTvLS0+CY1XzGBoRPm6XKAErIpZjYK40gk=;
        b=NtEJPfOkA14+bRJCoMr4Css4ek3mTZfjaVa77JAvdot/1UNEZBV06/9gjTLNfFgl0/
         2db6Fx7F7DaI4TPvV62xptA31uQVoLM8t78BNF8GHDbD8PpDVj4e/GvJsTnw5qFB8gc1
         WYhHUo/B0LkaqdqBLtjZjKh0FjoeAGxybxGilXXjreGDOcby4XNgcLw7QmwbbxrZutN0
         UG1jZxx1OUwWrmsnx9Rco7pDkVClgpM9aZ8PWNPAxD5Vchv9tL5seSXsEIRSKJGcp140
         22BPsPpSAU+V38VCyc0/9kaji32zmdCxiOLhr6g1Czt9pVXGvAytwa/TnGD6AmBzWmLC
         NTnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774979801; x=1775584601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mG7GVo4QPf18ZEFXSFarizVdr4pLMjODERGFFPI55Jo=;
        b=azLhY1IwvO9IJ+lbFcQZXHD4rB42ErrM40m5WzrgwJWRnOhm2hoF92nRadqXC7tDEJ
         oAcgBuGKyZrW89G18n7ryBjzFqz2aaEsR9z2cZW/PZuKyyysCt8d0+yfU0gJ6REL+YJA
         FdaJSVYVBP3ForkCfJq2engH6MoQgI11J9LD2FL7xZ3TDRMv19wXvXUXBuJuIUkTd0c7
         9YJQ6ZlohjPi6mIkdtneHSEk7nCmyyxDwIeZaZ4Wjiuy7OFZKEnK4GJs3hCWbG6y+geg
         fluKbbejYSMqsEm7PBFYlgyPkPxXBHf1Vk8gFHmlUqjIUA58yqh+4KdogFdAP3itXB1t
         APiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979801; x=1775584601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mG7GVo4QPf18ZEFXSFarizVdr4pLMjODERGFFPI55Jo=;
        b=s8D/7moYzPmysF4QeVFevggdB/LEBvwpWXb/GE3YDLRvxv1kH6EmMUO3/gGKMLYPMY
         0Z8Wjl2tYhP8ycvcMppJ6GwGWkaj33AOseHn1DQUMQDFVBnGcu8dLN96D0zxVq16NeyP
         5bG71N+ODas2MvQHqYqgM4RWA6tAUTbhyB8tU4cTIbWRpa8UBJ3Hk2JLeOkFywKXCohN
         4f46ZJhhZ5Avw930DKp/40BxcTxuxJy7vUXoOhOyEyGtS94PttgTXSVF0OnCQmNnw76X
         DWLM2YBAn6yJ0LUZZZUYmHUeUUM7T4WIIjy3Z9S3hkJDU9c03XSxSLumnU0D2ck8EwgL
         ap0A==
X-Forwarded-Encrypted: i=1; AJvYcCVsR5R7d/Nmxp63oxSgsv7CLrwqf8bFvhERozoQuQ+rouqxgq9FaU3D4zS1jaKtr0Zr3kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWZ6Biyrv0ShPm7INr4tJbA6xzwPM13HRPZXR01j+zRVqE4QH
	qaVDA7unS4u7vlE7NHeHQ22+E4lNOV0opPSiJN5OuIQHbvM/coD2me5T9rdUqj4c8sp2uvVzeqX
	du11tKao9ZtNhj1EbKechcbF7a2vsrtU=
X-Gm-Gg: ATEYQzzvOQ4sbI1TIWPLEfgo+eFUqt+3E8QOvoucIiREZzUZYKMd/Nzr00mz56q9E/l
	rbMscIpT89HrXc2U4M/GavHsOHJ14xYxXPMiNDPpMRLAP2N6r0RoBycMhoBDXE5mbQT8440bBrL
	4RPAubxGAaSvheMMfpZ2vFDROi8Csfc5fNTMJe4bM/FWaYlh51BErM1sIKw2qEPi+ga4dVCIE/U
	k3QCPtsw8GkrhxIo/LvB3/mJb5jZFiX9+XaP3wiCzXwDx1nM6Fa8MkesTUHux5fRxX5cGPXxUmq
	ykoJt44=
X-Received: by 2002:a05:690c:dd6:b0:798:e281:a51d with SMTP id
 00721157ae682-7a211c434c4mr4048417b3.32.1774979801121; Tue, 31 Mar 2026
 10:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331172619.29837-1-tpluszz77@gmail.com>
In-Reply-To: <20260331172619.29837-1-tpluszz77@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 31 Mar 2026 10:56:30 -0700
X-Gm-Features: AQROBzDXPrFXva9LnUMpmWEIPKv0TJDbj33-xobr5huGqHZeUayz1ZgyXpQHwMw
Message-ID: <CAMB2axNeSJv_yWDHk-kJLV0RCLrSkxfoNGZ5zyVtDP2dmehv2g@mail.gmail.com>
Subject: Re: [PATCH] bpf: propagate ref_obj_id for dynptr slices of refcounted dynptrs
To: Qi Tang <tpluszz77@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 10:36=E2=80=AFAM Qi Tang <tpluszz77@gmail.com> wrot=
e:
>
> bpf_dynptr_slice() and bpf_dynptr_slice_rdwr() return PTR_TO_MEM
> slices that carry only dynptr_id but not ref_obj_id.  When a
> refcounted dynptr (ringbuf, file) is released via submit or discard,
> unmark_stack_slots_dynptr() invalidates state through
> release_reference(ref_obj_id).  Because the slice has no ref_obj_id,
> it survives the release and remains usable as live PTR_TO_MEM.
>
> This allows post-release reads and writes through the stale slice.
> A BPF program can reserve a ringbuf dynptr, obtain a slice, submit
> the dynptr, then continue writing through the slice into the
> already-submitted ringbuf entry.
>
> Set ref_obj_id on the returned slice register when the source dynptr
> is refcounted, so release_reference() properly invalidates it.
>
> The original comment stated "packet slices are not refcounted" which
> was correct for the initial packet-only use case, but
> bpf_dynptr_slice is a generic kfunc also used with refcounted ringbuf
> and file dynptrs.
>
>   BPF verifier incorrectly accepts post-release slice access:
>     19: (85) call bpf_ringbuf_discard_dynptr  ; dynptr released
>     20: (15) if r6 =3D=3D 0x0 goto pc+6  ; R6=3Drdonly_mem(sz=3D64) =E2=
=86=90 stale
>     21: (71) r1 =3D *(u8 *)(r6 +0)     =E2=86=90 reads freed memory
>
> Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr=
")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  kernel/bpf/verifier.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f108c01ff6d0..937c9adf1b3d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14071,11 +14071,8 @@ static int check_special_kfunc(struct bpf_verifi=
er_env *env, struct bpf_kfunc_ca
>                         return -EFAULT;
>                 }
>                 regs[BPF_REG_0].dynptr_id =3D meta->initialized_dynptr.id=
;
> -
> -               /* we don't need to set BPF_REG_0's ref obj id
> -                * because packet slices are not refcounted (see
> -                * dynptr_type_refcounted)
> -                */
> +               if (dynptr_type_refcounted(meta->initialized_dynptr.type)=
)
> +                       regs[BPF_REG_0].ref_obj_id =3D meta->initialized_=
dynptr.ref_obj_id;

Currently dynptr object relation tracking is buggy and this patch
fixes a part of it. There is another parallel effort in refactoring it
[0]

BTW. It will be good to have a selftest for this type of patch.

[0] https://lore.kernel.org/bpf/20260307064439.3247440-1-ameryhung@gmail.co=
m/



>         } else {
>                 return 0;
>         }
> --
> 2.43.0
>
>
