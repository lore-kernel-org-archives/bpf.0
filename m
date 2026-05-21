Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A441E33987F
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779399044; cv=pass; b=G94HwA5AYbcVuruzH4HBbh+SxZk+bUhjdqehKml8ZQl4sQHY75nj6iZ0JRsKRroeXzLoWv4uuDm/lEOsEgxSSs83VgxiSvIJZZZ00bToUyXVOcGSKanxA88ynNVggtwDZHieF33xAWQBNroIW92ssUOmAqdBb9W/LBcVUSyOmFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779399044; c=relaxed/simple;
	bh=cgt9ZO5EdZt6bchHY3X4Z55fqeWQ/ykaDbI5wc96+II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffwN3RId5/9BSZJ93OJh1ZaubMuimh7xyoOb6zLLiVsNoSXs/tPis1RxLu4NLrkaH3/7ZmfrCRiX3HUUfMp/AJ/nSZEHGBrcPcbqFGVS/dnF3lWlrke9er3Ji2LZVH7LIHCyaNRW1c6AteVY3OrKNsDyWjZeRW8vWHqS29ROZ0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKZR79wt; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKZR79wt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso8594985e9.2
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 14:30:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779399041; cv=none;
        d=google.com; s=arc-20240605;
        b=ih0/DdPVJOhTm3QPbLx5ynHTHRj9w+QCm+JG23F9Q1eujIx0RUPbaqcMAvJqpHtagU
         KvJtYC58aMyynHnix/0XxrGWkIKXTyfaX+fiVT9OaYjLvn9i3R2OOODYMSnH6DwDZZqz
         ZjQ3Vk/arLLUtMy5dZ9OPgseBiA4zM2a72oTlM+5KQOvwCRl+iN33Aju4PAq2PzzuBmG
         UTOhIvqO2triJaujb7X4KwJmZzn60vPito2kGyeN10P8vUpvxXP4zKBJ11IwgSTykBr8
         3tkhmgB86OxgbvL4oj/eMxxwACnWkOlBHag5Kkma9t2bzvsKsKNWloIpSuHh4nfhQA3p
         0c+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p1ywolQ/F0eG/GKMZFrxaeUCjK8IyklmVVzomFKMSaM=;
        fh=sONRXr/W/9o6IevyKy/I/tnfmNhe+EoceMcPRY9ERdo=;
        b=W4xHnCaDcKi92rXgJHZzlmZbS43HLHxssq+bU80RMT3HdGANoIUMm2SIG8MXB3qvHY
         FKhgqClomSrBVxsyUV0H9oZ+dcDDJLvKq5VRv+hNVQKD6O7gsrVdAXeYkmcUI/3pMQEc
         m41ZWn0J+632l99ifPz589jaARoa8vOOtKYmcijN/+0zIAY9gep8X9Sw9Z5nP7achz79
         rEP44dwh9PpwRknW3BGHg3yk4SuvZCsGN6MEpo7MVXjH3pYm+AG+fZWQjCLUMm0ueYqz
         5gpGyq19Oc4RjetgXiSueVSNzYzoSItZABOm44GWmdPqqeS2mJoY8WK6fMo19C1OLbHn
         u2/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779399041; x=1780003841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1ywolQ/F0eG/GKMZFrxaeUCjK8IyklmVVzomFKMSaM=;
        b=UKZR79wttF1zR4R/eVVOK8Q1TZCo/MxZP9gFGn6ZhQPvYsNpwnVaHSGEKZIbsf0wAc
         xaxL/TAoJKuYOSmKfzn7iBJO+ECjRYF7mUEpaUIbXPbruSgrf1Qxb2TCZldFD/UiJlOT
         ohlFXjcWmmDsYC/Ia8POIo3q0qatp471nHGW4W4U2HDHnNA5krSmKkuOI2U2cjEsRvxh
         IX9mdY/2lmhEekZzHdleqyzfrdYxqr+2OIWCmoYshmQNggv00Qe1MILHgZlekpn2xd84
         Bwx6bCxDeTuw5AlrtIoJcPumozqptaSGyN+L2brdI8EVr1mBv++SYQACvmqYGTtQVaT5
         Ot/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779399041; x=1780003841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p1ywolQ/F0eG/GKMZFrxaeUCjK8IyklmVVzomFKMSaM=;
        b=HAnEf7wJCRKxnH7iuvR1FqxRbkE2qCbmR5cgnCt1NDvRRwP6d/lUsjgBLJLHHhnrMo
         SVlzBwDBXcq2xqG1blsxUAtVkMuWo0z0/VGEI8nouGen9xwTk4b9/1hAfxRwl+Jd/Mct
         rehPb3gkSbjL/q+J0tjFCIZyFVnIED/3uTOfCrd/uhNyPNZqWl8bicSPS1I7cVGfgryM
         +0BhH7hzh4Qm3M8bLPxeD1f6xrwXWTSYTkqfoJNYPzaDnNoCO0oIBAB5hqJzVSfMIFdv
         Pymtily79Dw+0hWnhPAeBnROe+35+L2+dgVG+iMwTFrhVMRm3FjvVfUyDUIMpAXR99Xo
         8+sA==
X-Forwarded-Encrypted: i=1; AFNElJ9De60P2TDoQuWGvsBgKU9y0AIIXf3yBs9VYdiWJmP5K2MeyuQBp+C7rBAmA1NLHEEdMWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwneSn/GjNDyFrpmBGyUVsu224IJA6Jh/2xm89KtD0LD8SgokE0
	AuF8Wknh+5TPPit9iaNRPaCb0Mzkadx3LxPBohbP+oDsfcClCG0UlCjeecnqdlWjEEtW6bIX0ga
	OWV2kQJcvs0LnOAkMEv0GGs/B/IIU1Yw=
X-Gm-Gg: Acq92OGw2+UgzzrMj1dJ71OEplv9K+VgQoFX2w98iFDmZi67ypHvtKahzZX9yHOkjy4
	k/DU1R9GUyH30kyDfF8Lv5YOM4/vjrcCEQk8EiN0FqxOTkywGvQhLbZuHahzWcbqIz80HkoxWas
	BuuVVKSPrAULybEZD3gfdMtvcUkHIYfTwZ0U2nLFw2tY/A2FJwO3BFm5Soq0Qr9hY7UdQuD0pX+
	WDw529o4CO0Lr0tMSC9hOh78dREepw78rPC3ay96foVQv7HK3cR8oDqfuEDUNTez9tpVrJ6aW00
	lEqdYIiNxqhMW6ue6OzDgWJ79JNmFFFZiPuRhKF0qOByV5wZV2ttZT2k2UWelkuU6aVt
X-Received: by 2002:a05:6000:1ac7:b0:44e:7284:5f21 with SMTP id
 ffacd0b85a97d-45eb389d49emr705269f8f.18.1779399040604; Thu, 21 May 2026
 14:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521152217.2345235-3-kpsingh@kernel.org> <20260521165240.D95EA1F000E9@smtp.kernel.org>
 <CACYkzJ47rASFZLZPz2VU9FE7J2-hGdw2f-5LQYmXoB9urVwRqQ@mail.gmail.com>
In-Reply-To: <CACYkzJ47rASFZLZPz2VU9FE7J2-hGdw2f-5LQYmXoB9urVwRqQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 May 2026 23:30:29 +0200
X-Gm-Features: AVHnY4JqkdIRdLJVntIglhOI-10xwJCt9XHHakTQUyyYHW3PAWkYAyswPlgGLFs
Message-ID: <CAADnVQLJw=Dk=VjWmot4O1WLm2TxLH+-mX3G8AuPd9f_5rAJCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bpf, libbpf: reject non-exclusive metadata maps in
 the signed loader
To: KP Singh <kpsingh@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 9:09=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Thu, May 21, 2026 at 6:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [High] The BPF verifier will reject the `gen_loader` program on 32-bi=
t architectures because it accesses a 4-byte pointer using an 8-byte read.
> > - [Low] Multi-line comments do not follow the mandatory BPF subsystem s=
tandard.
> > --
> >
> > commit 878a81f0d9571d5734eccfbe01c3dfe58050f954
> > Author: KP Singh <kpsingh@kernel.org>
> >
> > bpf, libbpf: reject non-exclusive metadata maps in the signed loader
>
> [...]
>
> > > +     /* Reject if the metadata map is not exclusive. Without exclusi=
vity
> > > +      * the cached map->sha[] verified above can be stale: another B=
PF
> > > +      * program with map access could have mutated the contents betw=
een
> > > +      * BPF_OBJ_GET_INFO_BY_FD and loader execution.
> > > +      */
> >
> > [Severity: Low]
> > This isn't a bug, but does this multi-line comment follow the BPF
> > subsystem style guidelines? It looks like the opening /* should be on i=
ts
> > own line.
>
> Sashiko, this is how we comment in BPF.

No. Sashiko is correct. bpf doesn't use the old networking style anymore.

> >
> > > +     emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
> > > +                                      0, 0, 0, 0));
> > > +     emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DWOR=
D_SIZE * sizeof(__u64)));
> >
> > [Severity: High]
> > Will this 8-byte read pass the verifier on 32-bit architectures?
> >
> > While __bpf_md_ptr pads the C struct field to 8 bytes, unnamed bitfield=
s
> > are not emitted in BTF. The kernel's BTF will represent the pointer mem=
ber
> > with a size of 4 bytes on 32-bit systems.
> >
> > Since btf_struct_walk() enforces that the memory access size exactly ma=
tches
> > the BTF pointer size, it seems the verifier will reject this BPF_DW acc=
ess
> > with a cannot access ptr member error on 32-bit architectures.
> >
>
> Good find Sashiko!
>
> __bpf_md_ptr doesn't help =E2=80=94 unnamed bitfields are stripped
>   from BTF:
>
>     $ bpftool btf dump file vmlinux | grep -A1 '^\[1462\]'
>     [1462] UNION '(anon)' size=3D8 vlen=3D1
>             'excl_prog_sha' type_id=3D17 bits_offset=3D0
>
> vlen=3D1, no padding. On 32-bit the pointer is 4 bytes, BPF_DW is 8,
> btf_struct_walk rejects (msize !=3D size). BPF_W doesn't work on
> 64-bit either (4 !=3D 8).
>
> gen_loader needs target pointer size tracking (like swapped_endian)
> to emit the right sized read. Will revert __bpf_md_ptr and do that
> As a follow-up, I need to re-spin anyway since I messed up PATCH "bpf"
> and probably confused the CI.

hmm. I think AI is wrong here. size=3D8 is all we need.
I think BPF_DW should work. Pls double check. Don't rely on AI guesses.
