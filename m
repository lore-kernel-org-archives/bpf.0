Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AC713AA2F
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482039; cv=pass; b=ncz5tOA7RpXlIiS42qdLJh4E7h2/SaZFtxEFmJaiVac2z4XnO9CwodHbjpECnXiGnQ46tCkV2B3+Y09XVatB+BRU/8zKUWC5cww1CdF4rzi3K2aGdppkbdjrpgmK0cT0ldvJIOLU81Yr8945tfiQW1Ki/TkznFDr5F03frsoiIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482039; c=relaxed/simple;
	bh=vyejKawb6c81OKzUc/Dy5VVny4R59bH07JH+ZWAtYmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOodFtQVPyoHNExjpTlEgtGp/eOEkCiP91yYnT8ndlXiqLNWqe11UPrpRLWD1vduD1ME6GP3lHnwSEQOf1FEfkf4sdFZyp0PMXwswGsAhklpI950YpNTKk2MpqKY5P9AU2kHSGvR5LWYjFvTsq+iZoTGQpPLpb9Mf4TCsvShFHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIA/f1zE; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIA/f1zE"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e7c6ec9dbso8133385a.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 20:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783482037; cv=none;
        d=google.com; s=arc-20260327;
        b=MIs2xG+sgJMH0qkt86xrKD1JWbowtyOsL8A9WQVKyGLXR+4yVS3nQG0qYGUZKKQu7z
         nh8F84E6B6MfffDlviDlNE63mbo0M49hxTKpD167Kzc4gPbCyGOPW4OsvBr+3l5purSU
         74Z5bPmsUuPh/DOdo0YeWGeRdxH5CmfUCVuMlDZKnUgn0/MeusnxfUYNlwO8qRFWGisX
         oBlB3/cSZsxJrXHG6UFSMXxf4Z3YglVOvlnluPNkT8Oxo5tsV8ywoc0l9HywpsNj6vZf
         c2arkt8y5oeGt1P1HRYm7Y+NkibPnsNiCSlVzg3mJzFkMg4Z3UkQPMPaRXgCw+dYmdgY
         n/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Qa+4EiSp2Mydw7M6P1zopsrBJak/NLQvEazW1nO0ks=;
        fh=3kAaT87vUtL3jbQ+nsGborhQL0U+tAH6eaEQs+mE4qQ=;
        b=DiAiDpIJiUCny8+Bld9WpOt1414lD2EJ3Po8+IUn1xhlE4K7erFsxl+9SJwn3I5cwH
         lw2TcQBW6ZOwld5wnZO1MlrxVrp1WR6+pm8mVnLms+F7XU/uiRgJ3J/V+7Gce+3ADYbR
         ReHsYRdH8khzKpZ9VOR5En2KxNWUz3Z9CMVLqG62WUjYY69MOa29H3pSuJh+Cjju7eSM
         3s6K74/gxP2AIfAQRNUmIVmubvzI+umsVumrpqGvgLgQBlCUfAo29EVUaY5dT+6DC2dR
         8je4xF5kAlIU9SKhNczCNPvMqO0z58KtKQxRn7RvwIF+iQW03o35ATSUNRdz2CmXAlvh
         CEGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783482037; x=1784086837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Qa+4EiSp2Mydw7M6P1zopsrBJak/NLQvEazW1nO0ks=;
        b=PIA/f1zEKPkjsbA4Wzh2/sJo8Hbo1i7/WqlfHYfPZNz0nrI1wuRvqcCMDI9YgC97Q6
         rgluiVYRbc/waOrqlgIFbPXTMeWbFwTlRVCOvLD/fBkwypIvGJLN32voAlVlC6isV/X0
         lGSi5+jKraBAtjdwdcBBzUEyLsaproyf/OwPHDCG0wc/EZBEJjYJ4gZR21M3QeO5i/DP
         5+6oNbMQTO5w3W28SPBLdIiQtDf6l0jD17RGpB1HTjnTa96Z2/zwnNkcEltVIOYc3ip4
         UAW3WLDIYfNCO7PD51E9s5a80lGGoE9LhceJpxTsN8qGI9jntdzGjlpJfdiddXfh6Qw/
         91tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783482037; x=1784086837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Qa+4EiSp2Mydw7M6P1zopsrBJak/NLQvEazW1nO0ks=;
        b=QdQ/6CX0+DJej7B9ToT2FyhnGSJhkTqbATZUAgaHKjiG60Z0ToWMR3Sa8Gn81VmGmU
         PUCcBmcpR/7FSNdKl5DMyfWzSCn6maM2v+aczUoaPB2zsitaNQ5B6lXJYBoGUxxUzph4
         80FKQIwxt6Z7OU4MwMGxi07NLTXtASI4hAvR09jUj6lqV28sHmvMsOEe0hLneugiSkCX
         HWDIEt+KoxuChyzYM8ZftAAjzujtqXYkOeySwJ7JkAPLRxZLiAuPJ1Ghhp9Ba1N5FHTh
         CYpoipAqIpK9Pf+yDoZTCF/ZCTJXFJ9b5ubTT9JOVrKLKavOZ+b94rbTFHwEsOYto6eC
         i3lg==
X-Gm-Message-State: AOJu0YzJGIdbjA95w7F7xs3/u5gLmVuej9VB8S2t+BiJ9KQEPsBTsXNi
	IB+FD08aWvRxlYP++/6AKEiUU4srgkRymX2mBXQF0mbS4GfnGqB2hMX+FoVkwwTQ7nlipjmh98w
	l4p44twdPDLgCb1bXT8iPYQ6I5lAm71mozS8RptA=
X-Gm-Gg: AfdE7clNfXnrsRJYxFatib+rMF41eqKwWZiqh3BmpoAY0BkRO7bhNLnrlt8HlWZ5bse
	e2Xavpywf8F2HW/6mL0NBJMDU8scRjqmdzEbMvtrvH8rPB4UukuwxDhWhOcu5kGAGFs5vqwtNj5
	fWyrGo3eNXfKVtYFkVlmEF57rxIlfazXSuOdk1ra3Sr6d6Q1APXOoIQa5ScqL/f1nWCtP8b2Y51
	gTNlZGQOjRQyVnGb/Z6VbOUl9TwsKDRr0IM8ITVRt6rCjcoMjw6qnQ83kO3aJhfDoo4DnwnReL7
	zJdz4Egjdm+zDZfS0E+A5g0M+D7R/qgCY3lljA==
X-Received: by 2002:a05:620a:2913:b0:92b:67e6:8ac0 with SMTP id
 af79cd13be357-92ecf6965ebmr59211785a.74.1783482036798; Tue, 07 Jul 2026
 20:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5a6bff16c0885d3ec756a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com>
 <6702d2f1-dcd4-4b68-b1ac-daa8661235a0@linux.dev>
In-Reply-To: <6702d2f1-dcd4-4b68-b1ac-daa8661235a0@linux.dev>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 7 Jul 2026 23:40:25 -0400
X-Gm-Features: AVVi8Cephjp7dZrQ7HVqOogT0cobirvdNaVw4_nk_zdryglSi4jSG3SZ13lnB_Y
Message-ID: <CAEXv5_gC_ze_CURdJMHBQ0aLS=uA8GyisSwnwo1YFTd_++4phA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf, x86: Fix FineIBT #CP in BPF dispatcher's
 indirect-jump fallback
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:30=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Comment style: /* should stay at its own line.
>
> > +             if (cfi_mode =3D=3D CFI_FINEIBT) {
> > +                     EMIT1_off32(0xb8, cfi_bpf_hash);        /* mov $c=
fi_bpf_hash, %eax */
> > +                     EMIT1(add_1mod(0x48, BPF_REG_3));       /* sub rd=
x, cfi_get_offset() */
> > +                     EMIT2_off32(0x81, add_1reg(0xE8, BPF_REG_3), cfi_=
get_offset());
> > +             }
>
>
> Better to emit_cfi()?
>

Yes, thanks. Will do this for v2.
