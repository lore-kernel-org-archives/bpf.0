Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794524469;
	b=AcPGuuxHw74dE3wu2Cr78Y5PLn3ekJlCUiLgPtjL4LF1vcO1ogIsrd2mom+20MpqTDEq
	 LoqqTj015RgTNwUIvwEJoNZesZQ/QPQJpZsZnrH6p1AbWvaPl9+BG/2dzrmaUzzx5wAq8
	 CEQVBRSPOUmpP95dRTf+xjCFeaJbfo77PYvV7G0Pn09LbGxRzQF4l4StR8Z3+IAVp1WGV
	 VJ9qACeMiOVAFGtPRJvnhCw2EFCb6Nn49MErzsEFXpiCAGEMtjmmPHdZ9oFmBngYwADh3
	 xhJdl7/p5T8QdkPsxWJr53YLejbWW0h40Ns28PqmHgBqt4F+CXaNkU435jnkP9ULJAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XeZTUBvhgpIr/mryTTLRvu/xMyKUEKxDCy6a+x8xHAE=;
	b=wC401Y4XcUCPtbwcyUd6iiYIhpXD1DuF4Hz9Wvsp4C1R1ewjzXXTqn6vogs4z2DvZDJ7
	 h1JHY4So6i5NhOo9Mebr/p64lrkP+c93Tim23v/PRu2qYG9wpdpzzj/0oGASmIOVp3NBX
	 cXdfuEbtyA7DoLtQqIRJKQLTWynOmy2nZAWeRUXGLWgoJYoGdZb2nD48YoujtZeczm7nk
	 ueinrfcfNPCNDZ0tNCuBO+7hdTguXUCKiaxWM0wMur6nUU2mpkv0p9bzHkxFzdBjVArEP
	 W4j1YxeD+FW5bmNyiUhkWh2DIvD1pa4Ge6NMZ0dNNNbRFRRlEBNZxVisvWlktyC+M2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORwCc0Rf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C1606A88F
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 23:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A59C1606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORwCc0Rf
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so3114745e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:01:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794524467; cv=none;
        d=google.com; s=arc-20260327;
        b=DdFisKTs0ziuKmn6eqpkc3uzlzLQoR5ThdRR8/kz1Xb+MUmG70vEjUTUJTMhcxdt3M
         6FGLKzlbrjjl7Ia7qekE98LtSnnXLd9R837gbbwPQx7/Hf2HZZzxBReqa3qMEQMXfFJb
         ps/8VDMLghqpe2+5f4woRohULp1IG+HvHd7uAXA07+z9uW6wP4d5OhICreXnXOur9PLN
         AsE41iGN4F5ZjZZ+d/RODbaRHepqYBtVT2+aeH9LPBPpnszoXg4Dz0v761XKUIcKzWDs
         Nyjo1xuvROqqHE0TkGlm9Qp2qmpz7drx2sR1nvP+NtzYABZXBoZnoCAErf2yXZheoh7o
         2apg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XeZTUBvhgpIr/mryTTLRvu/xMyKUEKxDCy6a+x8xHAE=;
        fh=946bwbWUVkZTrsKyM+LXk+OccKM5tEh9r6lNqhpg4W8=;
        b=loekXlAo4XOmvGzQ6jAwBRFFmlpTtjAGuOThOCmuiPC5CEUiplnAjhP2OLk1C/jIO2
         qf5c2Wv/ARMVez+0mWwdFjqi0HLrUx4su0JDKG3aygYOY4ynL699orGtdDq/uWOclzIS
         y2KbW6OQfGfXEptIzwKbzAHbIM+TPQIjetc/y4d0e3HMjORuhdx3dwunquM4d4Uxn15p
         cpubC1yzUDcuP81XXc9bJZ3cD2heo1m5ryy6CVaUXa87IBL9H3lvXxu06nqVc9SyD+/Q
         qvnC0wx+PhlTaZvzbw6uYrbe0dwc/Lu23zJW0RkiS8MoAD+cNpuAmEtX7I7F7CHoHRYM
         c8xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794524467; x=1795129267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XeZTUBvhgpIr/mryTTLRvu/xMyKUEKxDCy6a+x8xHAE=;
        b=ORwCc0RfO5g12dP7DXRFOapIjWsMZprR43pPYuTX5mzuufCJ+FSeXnwUhWLdW5uQcT
         pUhjEZ6JndcGeqBS2exd1A6EPEaFxGnzAxxa3p1FYRbJgY/kNs2HrPyjO5jEV0eVTrCU
         MpV6JvRAyTtMc63c2sWcGhIVMtn9or0kHHYQxmTnxGzXPJi4ugNlUDjHOnnvbxlv5WQy
         j6WOnF+fX1TKbps7pGcWObt5jUeVGoqMY4fduHB+irTQuU9h+MkFBPWFJ//1njBTIxYG
         FEqOW2CkK6tHrOgCL4gg3YFE7gHukHSnJrunAODa8JKo+sBjGY0Ntec7QRCPypPNNCF8
         nZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524467; x=1795129267;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeZTUBvhgpIr/mryTTLRvu/xMyKUEKxDCy6a+x8xHAE=;
        b=tMiQyFmlaJOHLPuVGqcrc2jcuGACJ8+vrN/o+Gg2L99TcykX3gcd4A/gnU5QE94xJy
         yis7lfe4q1H9mNmX+Kx92AzxL+hvhs/uQ3dfxCR1RJ5A1NYii05QCXt4gtYfZn1+LPJe
         ZS72dzFLVXdbI2pXJtluyzjKlH+f2Quea4UFGOj2L+UbkI0u6qhUaQvxWTT27PjJ+yCE
         /wI+gY+gmcPl5u58OYtlkykEYa/ZdNh4IR+jMjBw5smwFWnvUr34bVcEJO4XYIrH0+0H
         OIMDiTENrqIQeGlFwNN1qM2LsC9b4kbt6gsp+G1Ib8doB1pJSOB5ucCxurVA/2JXtRWH
         USJQ==
X-Forwarded-Encrypted: i=1; AL+hErHc7pOh9KkaKAc3nXX7CXrfpxm2KcI0Zds8+uSH/A/wBOTWbLPvScTRa3hXhU/591uQaN4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SKkQ6fCFi7cM/GaE/9ueBA46hjMb7GZ+tg/D1SViqsEHUNylZ
	mFE+wQs1Jdi6Fz8kh5Rw36uxwvKpWXy2SaNZ6bRmzfb+2WfKtjd31AsHsxmJ+yoV8OVyiFfhWjy
	fx9naGr65MjmHeL4tDrO7zyjK/ul+5HU=
X-Gm-Gg: AYBFou3FUkYUrsHCUSSlod/4G8gsomybd9ZqZLixpG37ShwVgFVLyqS+QCCG0yMm2Qk
	cXg5QKzbImxPcfCrhAmgA9bilYGW6Q+Xz0OOPjCubuwyh3yuURJFOFcrD+f2UwA75cBtN4Xyjoh
	HXnk2lMAKs/kY5eqQtbJkDji03fDbhCgK2U4OrdWlaiZnyGVpupr9YB7FF/P6NDhPGd62VBKXTc
	Cqa2dro8+vGOw0DFHDvovQdBHhdZoF/YP6j38Qxu3QZgHH1Dfra4k9A/kPaS6fgvmY2xoFeEfJk
	+CFDSqYEYKv/cmWWO7cMchHzeP4nWer7SfvOQcMWjNZP0qOv+02N7LAPHZnID1AXJgscFn2RJ8V
	vGbd9DQVtecpMGTaaXVX2o3cQT3I0AdjbbjgWnS+33PSShIxxM3100CrW+ZGDOGjI9qb/2YsfmX
	5aloCE/MOeZAkGsOAerEhyWBYleeQt5hV7RQ==
X-Received: by 2002:a05:600c:840c:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4bb5599bda8mr15428035e9.0.1794524466778; Thu, 12 Nov 2026
 15:01:06 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAEf4BzYDmzNoN-5Rnfj4RrAU8wKnZe+tDFApng61L0mubXqung@mail.gmail.com>
 <tencent_3455CE5C67BEF809176851A476321557E70A@qq.com>
In-Reply-To: <tencent_3455CE5C67BEF809176851A476321557E70A@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Nov 2026 15:00:55 -0800
X-Gm-Features: AclHuK9-JNkpmr-iGpGEl47XwzmIYWiDVtXbPH3fGOAQAo_1XzuYJoGM1mVSO4A
Message-ID: <CAEf4BzbdC_+KSCN8C=+E+3n4H70p9c+xbFvEOQC-RXADWbGB5Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: check cpu_possible() in per-cpu helpers
To: bo cao <treebacker@foxmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 6:41=E2=80=AFPM bo cao <treebacker@foxmail.com> wrot=
e:
>
>
> > please trim the commit message down, it's way too verbose
>
> Will do -- a trimmed version follows as v4.
>
> > not sure this is right, bpf_per_cpu_ptr_proto specifies
> >
> >  .ret_type      =3D RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDO=
NLY,
> >
> > it already is marked as maybe_null
>
> The proto is marked, but check_helper_call() drops the flag on the
> path this hunk touches.  For BPF_FUNC_per_cpu_ptr with a percpu obj
> argument (R1 tagged MEM_RCU), returns_cpu_specific_alloc_ptr is set,
> and the return type is then assigned as:
>
>         if (returns_cpu_specific_alloc_ptr) {
>                 regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC | MEM_=
RCU;
>         } else {
>                 /* MEM_RDONLY may be carried from ret_flag, but it
>                  * doesn't apply on PTR_TO_BTF_ID.  Fold it, otherwise ..=
.
>                  */
>                 ret_flag &=3D ~MEM_RDONLY;
>                 regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | ret_flag;
>         }
>
> The cpu-specific branch does not carry ret_flag at all, so
> PTR_MAYBE_NULL never reaches R0 there -- only the ksym path (the
> else branch) keeps it.  Nothing after the switch re-adds the flag
> for this case either: the code below only assigns an id when the
> register type is already maybe-null, and clears the flag for
> ptr-cast functions.
>
> Since bpf_per_cpu_ptr() does return NULL for cpu >=3D nr_cpu_ids
> (since 01cc55af9388), a program that calls it on a percpu obj and
> writes through the result without the NULL test passes verification
> and oopses on NULL + offset at run time.  The hunk carries
> (ret_flag & PTR_MAYBE_NULL) into that branch, which only restores
> what the proto already declares.

makes sense, thanks for elaborating!

>
> Thanks,
> Bo Cao
>
