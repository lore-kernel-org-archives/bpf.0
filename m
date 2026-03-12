Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75912346E55
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349170; cv=pass; b=HFE0T85bCYbnEQqj44PuoDzn+4UAmum2VfIhHlJ6Q6vv6Z8Tu132ocTpqGiOVqCWnS8SyCymEr/Nra3cCuR/fpK4SRZ6RAyOMTOPkg9mFeoXyv7DYyGt/FGrYJtDyba65o8wCcGFuzAwkZbHINWZdH3QR+J30xSyt09Uxq8o5b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349170; c=relaxed/simple;
	bh=ssvV4Io+jemM4XwDtGcp6joagQ0Eu0Vp3VZ2eSC5jPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIHDqKcoGlzXXCQD84EF9k1N4z1nMlGRhUX1oobAG391jlGmzshtZ56+UmOeOla9Mx3KiPHea8ttXSfl++TCuRkweLQEcnAHYOexmxTLoybMCXVea45n2146fVMusCNqBHd6+NFtd3JONYI14Kd3Mf7/RyQRsz1XiKFMxoMmKVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P20I1NX6; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P20I1NX6"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-829b8b6c4d0so1247918b3a.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 13:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773349169; cv=none;
        d=google.com; s=arc-20240605;
        b=fZ2OU0P9gvGxV+el+q9bOP8G+2YKtqVbHmVvUAmdeZA0ydShRyV8arnYsExAAqmK0M
         aa5c6IXk3AKs0oeGDh0D+Rhaj2v5wyU4yqzwF2DqRqHWer5rgOJpmNv5mqS50qsflZqy
         grMzhMl5X+4yzgr4BOvL3xwSMdon73REwx6qd9o7MPfWtA+hbpelINbabZYv/DKDVnlR
         E4gf6A07HQmcN4vpp6wEsUXQKinzsf2yodhH1FEiEUMQEZ9834yXRc71mVbhbUKJpG+h
         mNZZ5PAsems5UWaPlnRJm/Y8Id82hKW/m42TRoJ52ejwZKSEHFmsZuSym5Zb0EkhXFQl
         TUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cp5h2tV6uxs1N58si6FW43oOoBC3Tf0eACotbRT5Vy8=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=jF/17KGs9Lwzn7VpQR8WoACdClwS2PY3dnZq1hO+USu9bQjd+L2Cs+fd55v9Mf456S
         Sl4cJ49ETSvzLKZrFcPB18Znoorj6sPZNZNe3TXdXYupsxkZpgDEbZIFWuSH7nOKkq4c
         LZtwBnwykq+MK07plmAN43NGhoguqlpHj1xEyzpMltjZa4aXFWKsCUZc6Q9E5KqKGGo0
         hzow6wz2Te2OOYt+fZuFd6a9857ia0euMAV4qGrKw8VUjCCh4dWwnxOec0p7Sx+Mo899
         GVipgpHppDaqZOvyv5l9TWX4y4mgIcJljYKoMAZjhhvE/vnKl08qD/pPkIKDIoELLxbX
         VuRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773349169; x=1773953969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp5h2tV6uxs1N58si6FW43oOoBC3Tf0eACotbRT5Vy8=;
        b=P20I1NX6sEPDDFZtC8wEcHFlRc2RNqEqVgq4+rndwsTGSiX2YwNAQCIDDzXJoC1k2O
         narKRI6w3MtNH/NC9VdmSqQkRuIq3Ao22cXAkezHOSlRWs65OVSJdwJlNg1+oLzIpYZ/
         p2aC2QEiIioWzIDnuN3XbE07UBbsJeedXyhscFsUaKLVWDUizHnMQG7WwqiVKKRAxDvS
         BUfXACaiVZX0rOC8xwiOUf/y7hgXGlwT2OY1Kdox2GP8hRFtuFApStvcLfYbXZz1/Dat
         NAixmusHOo1CHAodwpOC+CbdAw4ojE/xhClkp4+MGe7jrCnS2qhqVHbNcV7tcFIx5fBN
         2k+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773349169; x=1773953969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cp5h2tV6uxs1N58si6FW43oOoBC3Tf0eACotbRT5Vy8=;
        b=Q9CJ72vGLzZKDFPig5LxgNB9TtO1T4UsrSQC2oDrxFAq/G5jf0jfnk3W3qlFynKqie
         xjF8ZsVfB0oZWYD3VSma3QqcW8mXRB8hQ9dQ6pq065Jj/IJZWe6GQw+oV5fqc1mok+vS
         7Zz+YfaH5lQZ6nhv1G5eb5lyP56trwRTeblVRVNkCRCoib4H3HlpV7sJTPjhf31eE6cU
         WkH07uNCLXBeAgk5Jns5ul9oAdITcpj3mLPH+VVLSB2KTMyHoPds51veYErUv2Zk8H6F
         n3RQbr46SL8+tI6U9TwtYrnJTrBfZpvKIqmJiTAMt3mFW8eMfT3gwT6w2/PiNwR6pluG
         jdwQ==
X-Gm-Message-State: AOJu0YwIDdsAm5iODwzEb/eTKcPT29hPPG+23nouEF548EHdYqY46AOQ
	NIdkpkVP3m0JFXOZYUDuwbWe8+9H0+iU4cL6WOuJASf26njLsWgEPYRZOc+V6BUS5VMEdYFahdL
	RBJFrNPdCGKNEtSmldb1rdAxMDd1Fv/g=
X-Gm-Gg: ATEYQzzc2Yj6rOexy4i2JZMazCRzFOMV6xuvgOZsMNEPZCe8Laeud0zSUSWJ0+xQqcQ
	RhULzud8eUE8h1r2vJ/Zgzr4oOGEIGt+GBBLHV/iug+fdWinFOgmHnW8LSurK4zYzWxmBfSaJsV
	rA3LMSbtT6mikTrz/PXkdNIxE/5CBskmbuyPOKPVeWdYKGjslVXL7YiCAI6Y6RcQmeJKdOg0nSX
	BjoPFA1oGvQ/nBwagq6JtbsdGn2X/rs14+gkz37X6aTSNEwyQtELJn+OeQ5uA+ZGMTzMl/U8jEG
	dWq4+ygxfWIvGlRuK+somok=
X-Received: by 2002:a05:6a00:a208:b0:827:26b0:58d6 with SMTP id
 d2e1a72fcca58-82a19904a3amr732317b3a.47.1773349168863; Thu, 12 Mar 2026
 13:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com> <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 13:59:16 -0700
X-Gm-Features: AaiRm53cIKJnofKmst8en-js2hf6Ohr11X2ErMzbcnxC49HkphACZyWLNpZ3esQ
Message-ID: <CAEf4BzY8b6tBUyVybXhWFYTLgGA0qcZin=517UUtPMkh7D7ZGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Verifier support for sleepable raw
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 11:23=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add BPF_TRACE_RAW_TP to the set of tracing program attach types

for completeness, we should probably make classic tracepoints
sleepable as well, no?

> that can be loaded as sleepable in can_be_sleepable().
>
> Reject sleepable programs that target non-faultable tracepoints
> at load time in bpf_check_attach_target(), providing a clear
> verifier error message.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/verifier.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8e4f69918693..95b33b85698f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -25216,6 +25216,12 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
>                 btp =3D bpf_get_raw_tracepoint(tname);
>                 if (!btp)
>                         return -EINVAL;
> +               if (prog->sleepable && !tracepoint_is_faultable(btp->tp))=
 {
> +                       bpf_log(log, "Sleepable program cannot attach to =
non-faultable tracepoint %s\n",
> +                               tname);
> +                       bpf_put_raw_tracepoint(btp);
> +                       return -EINVAL;
> +               }
>                 fname =3D kallsyms_lookup((unsigned long)btp->bpf_func, N=
ULL, NULL, NULL,
>                                         trace_symbol);
>                 bpf_put_raw_tracepoint(btp);
> @@ -25432,6 +25438,7 @@ static bool can_be_sleepable(struct bpf_prog *pro=
g)
>                 case BPF_MODIFY_RETURN:
>                 case BPF_TRACE_ITER:
>                 case BPF_TRACE_FSESSION:
> +               case BPF_TRACE_RAW_TP:
>                         return true;
>                 default:
>                         return false;
> @@ -25461,7 +25468,7 @@ static int check_attach_btf_id(struct bpf_verifie=
r_env *env)
>         }
>
>         if (prog->sleepable && !can_be_sleepable(prog)) {
> -               verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, upro=
be, and struct_ops programs can be sleepable\n");
> +               verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, upro=
be, struct_ops, and raw_tp programs can be sleepable\n");

this is becoming ridiculous, can't we just say "Program type XXX
cannot be sleepable"?

>                 return -EINVAL;
>         }
>

>
> --
> 2.52.0
>
