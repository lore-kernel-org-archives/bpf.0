Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78193B47CA
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462244; cv=pass; b=Tv0sQ3EaN63gcqh4rc/IGEvExByJqgX2+Be2/D4bEXW53vNOopKuEkh6pFhASGYPaLkh9V465rVDPVDnqeEURS/6aAdLIuVmUVondq8fUCcZ2JXEIBHIuMsVkSXZJSaD3+ODQTgaObGICOVTMP9p3cA5pd625wNIHx0UYuLOEAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462244; c=relaxed/simple;
	bh=6zTua1aBCX5sjrhDHQqSHHzNTttIxtKJWuTBiuTqKdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUThel0Z35ACVMX5vZBoy2+w8UDCU08zZ5dMiSwMd5IBMPUEzbyRELbMmaWsHWxL0D12PIUnm1/bv2bG8OKe89jXAUE9yea9ROHBu8oet50dEuBW5uBS0Vn6b9O6FyOKV29OFw79sPOYjiDEC5RdWiV8yJu/j6aG1w6aSrU2pDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/vAKLT4; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/vAKLT4"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664d4478a64so6247553d50.3
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 15:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783462242; cv=none;
        d=google.com; s=arc-20260327;
        b=XtyCkmImxdFzvuNXMTGrXzJav40sBiR4YLr8t3AUzCOCKMw2PrtXavLgw8m1SxP6oa
         ss47QK8S29hQqe+Ejd5X7Og4siV6/DmxCFj3jFrusaQfr5KPf+c4ALGI8UpfQ5NbKJ2w
         2Xraf3IhB4lcOpyFbRe3etKM0ZVwOBdcFSMDF3ILmy/vdXPE297Q56YU/3hVgKx9PHKR
         PAYuou9zxLRd/Q2w4mPQpp2YZk0O33F/XMZMBPOBw2DWka9d+OyA6ELYLVH5sBE+mK2G
         1bzLtqTC/fUbcDLaRw0t2w7mpe2aj2IPlU2KC0FQN18LQLefJMjBJVexOMDgu6FtdsTC
         wbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V9PVyLLjKRePJFAAUUspbfdZ54quYu2ZTVe87icNDd0=;
        fh=u/ZUUnaAGFCc405XfjVS7GEdsB6vxR6gbuPmovjiO08=;
        b=WyB0IJiGewQBvkBp0nTP95TKaCAzw2fjYiAFe4AytuxvDPiaMt5hHrlKX8/Q96g/C2
         wZqdj/lnNscRfDer8L5so6MdNVbm7YQNLrWbLE3Il2NOIN9mNYGxU8TNBhNK743wscvT
         InJsZhFuNQ4iV0Aux0YNMNhkBQuM6bTyLxO1zhpciaiNUaCupQhyJdTGRgL5uSc4a9Ys
         Omi5gOGn+qsAN4PdqtxCxOpETspr4kCRpYLs+Cl0fuJweRkMhB1ju0IZz4aBF0UZHp02
         Wb7DBkR35Xd+edMwIoYernFHQUPaKRv+t1Mfb/HaqBHacxo4hz90fudhYcPFn43zVbM/
         8zXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783462242; x=1784067042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V9PVyLLjKRePJFAAUUspbfdZ54quYu2ZTVe87icNDd0=;
        b=P/vAKLT4+YT32ThmrhlkKp12GvRsNVljmiT8yy3AY48O/aYdN7udryeVY6v/A4aDSf
         dsFyegrludNlYp+GaNwcDfQQVDgOa3pR5niHJCstFagnmY9wIwWw1WLvLWDO4yLczZca
         7DzaAonJLqFg+40F/lGljgMd4m+tcxn51WP5p3p/i3YR9xLDBTzy0mp9PHuBHMFywh0a
         IpvwBAWSVEEpFBFzSOyASTGAFDl5UxkdtRxvPV6evfofT+ypNn6111IpOIpjI7z2F5l5
         dBqJpVt7wC3rWxybCCsvrOZioIXZ/G9E8sTeAZSMZOTGURhnI7CslIbz8ynF9p5e5Rqe
         1F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462242; x=1784067042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V9PVyLLjKRePJFAAUUspbfdZ54quYu2ZTVe87icNDd0=;
        b=DE0JV8S5fUj+Z3SSw92gSftmx56cGxtJ3yhALA7l5WzClxetHHwaIDSK983ieAjA6A
         fJwTmSKcTcSbJTwKEYo2PZDGgrTu/lF20TOfkuTkYoUIwT9hBLy9JB78llD+LUrMlJNG
         mWpyFUfmg2gfR3RjGGfmV5QbY3AFtPZ96qvlOulXWnJkH9AcWx+iIF2HxyytqxRM1wvm
         XqdiTFs+T80AbCRuhlsT1BlhaR7Tymozek1hHEZcQBF0YcgxwVFJjF87jtAyXDd18RJh
         nzzVRRaZSJjLrRm1kdQH/SeG+DP8oT5ZyHSoewRe+fWErRxqSVGiGLi+zzJrwt12Nj1Y
         hlcw==
X-Gm-Message-State: AOJu0YzcfRaMpOLT562qfR4driZ+opaJwHImPUk3w2fD3E7FRzZ35t8U
	+/jmApMXJdSIMLpmGYy0Az6bjfg8/Una5FKS+BuULEVDrqjAbWjREDUN+B4TqmGhuMc2YzDJUyU
	qGSDZAkaJsQHxvvCLDMFGHG2s71toULY=
X-Gm-Gg: AfdE7clRzD/2iH3U+a3lwK8f+fHekchehfN8Nsr0uHi/1v8sQ533Fqj6b4mvwyGkPN5
	fitJjHeSR9Ev2JgEXZgHNrGsy/N8nXsrRhoPu57Qvhwca5ay6vkc+FM7pKaH//43TDZADGCzMW2
	uBAw8bp4NykbDDehzv9oWMUawMnnaSUtEYdRquQAvdNiE5mbU2aAB20+Gk3eJodSsZyDkbrvPPU
	6/+5elglt02+YsOQEbuEJA57bdxd7Z6Kh3FnorNuo/HHxd118feE50T7dRZSrYG/X+zpcuHskmI
	0r+theW8Cw==
X-Received: by 2002:a05:690e:4545:20b0:667:96c0:184f with SMTP id
 956f58d0204a3-66796c02026mr1366678d50.6.1783462241728; Tue, 07 Jul 2026
 15:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707190214.1997705-1-memxor@gmail.com> <20260707190214.1997705-2-memxor@gmail.com>
In-Reply-To: <20260707190214.1997705-2-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 7 Jul 2026 15:10:27 -0700
X-Gm-Features: AVVi8Cc_5-tO_PDSLR2q373seBmIDzyU5vDvVn7vnRz_98D8oBmsJ9pwfJo_RN4
Message-ID: <CAMB2axPx5srvjNc-OEcEgvL9EB4iWZH4F3iMjQiuJxSxa6ZO2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Reject writes through untrusted BTF pointers
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Nicholas Dudar <main.kalliope@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 12:02=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> From: Nicholas Dudar <main.kalliope@gmail.com>
>
> check_ptr_to_btf_access() lets program-type btf_struct_access callbacks
> validate writes before the default BTF access path rejects non-read
> accesses. That bypasses the read-only policy for untrusted BTF pointers
> created by helpers such as bpf_rdonly_cast().
>
> Reject non-read accesses through PTR_UNTRUSTED BTF pointers at the
> common entry point, before the callback branch to handle all cases.
>
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  kernel/bpf/verifier.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3193b473762b..7cf555a7026c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5813,6 +5813,11 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
>                 return -EACCES;
>         }
>
> +       if (atype !=3D BPF_READ && (type_flag(reg->type) & PTR_UNTRUSTED)=
) {
> +               verbose(env, "only read is supported\n");
> +               return -EACCES;
> +       }
> +
>         if (env->ops->btf_struct_access && !type_is_alloc(reg->type) && a=
type =3D=3D BPF_WRITE) {
>                 if (!btf_is_kernel(reg->btf)) {
>                         verifier_bug(env, "reg->btf must be kernel btf");
> @@ -5825,8 +5830,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
>                                 reg_arg_name(env, argno), tname, off, siz=
e);
>         } else {
>                 /* Writes are permitted with default btf_struct_access fo=
r
> -                * program allocated objects (which always have id > 0),
> -                * but not for untrusted PTR_TO_BTF_ID | MEM_ALLOC.
> +                * program allocated objects (which always have id > 0).
>                  */
>                 if (atype !=3D BPF_READ && !type_is_ptr_alloc_obj(reg->ty=
pe)) {
>                         verbose(env, "only read is supported\n");
> --
> 2.53.0
>
>
