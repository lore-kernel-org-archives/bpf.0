Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF52391855
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312811; cv=pass; b=Gk/TO8pRKpZ2IGepboexRM1BM4+rEWNSS/HQyFRY+0DUknlO29XiMXxyQ4EBi7rckAuJ+1FvO6IhCqJWdWvYmo5EEbI7SkmDq1TbFe1UbKoFd3OqWbhV0pTU28VE8z11tbnQmSN8ThX9PnM8cAay/BqvsdT5sdYteaYPG48SHgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312811; c=relaxed/simple;
	bh=+NJcR0MlTdrzYTaZmZD5S47nVuIArtoxlhCqn/AuTOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cl8ABz0jDZIFVsAzW8OVzqxUlavlZCuZk+rmkdEFWOYatzCjZ2B72ecma9TJgbvF2jMH306KF4SN9PK/VBJdH0FjovRskE0iNj3NhnLH/gSGYEqS0pkehLcLuCHd4RsjiIJVm1OzRmtl3F1SB0644RT5SgMMgZhjUp88as3rxYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeeLF6Il; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeeLF6Il"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509101189f4so7598311cf.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 03:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773312809; cv=none;
        d=google.com; s=arc-20240605;
        b=jvTwRVFTe5e812YddnewQuNNu/pQ2Hv82GFnQadZBei60IDPQFsfXno/oSniY8pGyJ
         NuIVBuGO7L5eZIit0zvMeljmuRty+urE0rmduXxbhgTC6nIM9YLFnk5qrXnOGmLN/GlX
         oKJ7LpU0/lqTJx7CvW6qR9l6g6h1F+XjtMv4xjm6uBCjMkTUJhC1eZiRLz5h/k3b/84R
         uaSXXRc/9YqcAs8rS3LQE5Zn74TkXtX8TXG90o3r8ambp/nu9l+QO7NTD1JQ82C1bPil
         SGB+2AiXcWkmPNF9G+7aoav5NBIj7I+33lG2UrErx6leIyVNzIrCbaDlQV0bepV0Qwni
         nIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/I81bSz93u926pibWsVVMFGC2cc5DCiOOxNJCuPHFmg=;
        fh=FoVHJHt6Eila2ldZX8/m2v+mmTUcZq5oKD2Xu0YgOy0=;
        b=CjedP0bGKDjRYw7j2MRSFjQM6cB0ql1PsI0wnbmXPQrmjFjzOW3IwzRaXOlmv1YJx8
         J91C5vXL4ZDsm1bi37edI3k4okmcfOM6vQ3MYkFZ30kZvJzaxfg2jLVTuDsqB1fk3LEr
         /JpxPMvClD/2kyMr81JCLfMMhsQZbaGDiS/u3dA+6Itf2CDObLG6jz1SqThyuLeWklZW
         b85EZ4pBaszKtmP0trkAwVEj1ea4x3s0k+w/XP528ccpkK6sMf0NvzJ7jnBYe8CtXdtJ
         Ji11a7gpKTrTdMo+0F3O/NNu54gz99itoZqNiqxak0zH94KSrm3xrECRxb0RcdT726L6
         SfqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773312809; x=1773917609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I81bSz93u926pibWsVVMFGC2cc5DCiOOxNJCuPHFmg=;
        b=TeeLF6IljbQ6+U+GWvtrl2IxYnkpM4HTc0gzXZ7zt0s9FqhP6HuGUPTg031mfMYBA3
         wJhCIfcwvk7DjMJLQLNOEKrmVGEVX/moxEFawwrhDEaQ9GjnpRiFY6/E4tHC2OUQg5i4
         py9+yhKM2AxHf/0Bc0zSXERho3M5J8JTV9unmXKorkHWoyrCiTDnNtCOIna39vEd1hIM
         Q3UvOkTahqftSbSzUV0UbR3LeAqS8cl1kb3izVq9oc5nHSABKvhyKvlTcIykgTar1hTw
         2cokQlpqmKLKTz2n15HsE3Spm7XFOGu16HccEFm3lEz60Ci0m3NPaXPWCHDPdbibTQAR
         uzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773312809; x=1773917609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/I81bSz93u926pibWsVVMFGC2cc5DCiOOxNJCuPHFmg=;
        b=W5idKFF5YzI6SQlQb+UA8n0oJ7002XKgyC1bTNJyY+rOBpcluclpCfZogCw5VJZ0rS
         NGDgOKcUS5/WSOpu/2wus+fRLmq4W5E4i+oCKjPd4nsRmetafeZ8qGwEm7ce6KktcrXV
         hiqkDHlc1RaOOS9mI3DZlefuKhOOOGFG99De5/j/qibXOjrBn/S38OMu7Ycy6EYKtWJ6
         UX/sVlAE3Z2xbu3Yf9dytkot/bOKrfreCS5Qs1VrSkKA5nH/VlYSZoRr2VLlLr1mmdRk
         CdnChqMaVCcIsseQQEjjqCSQHQwxIVa6KOVtyJxdExzLjyBUQIWdAadgU+/C7A4F8ulL
         t7Pw==
X-Gm-Message-State: AOJu0Yw2UiWEQy8EHYkXWUU0r5nPDrgyqFmW9ynSlnDuGQcm33DESomm
	f28tic+EUy0WkzAvboAXKpx+3CZpetRtZfmu5BxolM/Nb7BXe46K4sOQUFI4RvENiqAdPzpiDZs
	MMBXBosDd9llgU6ByYtq/SjruocdUVRI=
X-Gm-Gg: ATEYQzxGDwlUlVOLhu1myvaoLVtIIH+2zzAvdztabu5RIlJCYr0tJNrmavQ6isHSbum
	qbnWKHwfj8i7Mk+skQbcOY60hh6jAQjEL29YjdEOsk8itgOU340Zn6tNIW00i1fbwvj7gEcL2XG
	KNdTFvQQ39bCf1k6ZxTP0SG46qvnW8eposZksh32bKZ/vewGGbYH3Kv7EohN8LsYcgQJBGIGyjq
	D/fW8IMR6PqOEVXYMqDLU/LqjLJ0UMTG9vcrXvz/SO2UnVpE+m0tmUB25dlLk3JJAjGRY/rJZKc
	isQFvvOU
X-Received: by 2002:a05:622a:3c8:b0:509:31bd:3dec with SMTP id
 d75a77b69052e-5093a1bb83cmr69101951cf.70.1773312809078; Thu, 12 Mar 2026
 03:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+WLDByd8qeUpVBijKooyZkBRB1iwGT8fjUEUKXgQEFAZ_pzHA@mail.gmail.com>
 <f7be55c8-be47-490f-8afd-65cfaa95fbfe@kernel.org>
In-Reply-To: <f7be55c8-be47-490f-8afd-65cfaa95fbfe@kernel.org>
From: Farbod Shahinfar <fshahinfar1@gmail.com>
Date: Thu, 12 Mar 2026 11:53:18 +0100
X-Gm-Features: AaiRm514giMYNb_7U1MacP7NPokCpoQiiKZVprFXSvGdVvdmYT-s3PP5hVf1x3o
Message-ID: <CA+WLDBzKND2EF-f9GDpgEvS2VPvXk4A2=qUgZxvaFqP0zq1E5w@mail.gmail.com>
Subject: Re: bpftool generated jited has unpreventable jump addresses
To: Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 6:25=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> 2026-03-05 14:54 UTC+0100 ~ Farbod Shahinfar <fshahinfar1@gmail.com>
> > Hi,
> >
> > I want to prepare a CFG for a jited eBPF program. The output of
> > `bpftool prog dump jited id xx` reports jumps with kernel memory
> > address (e.g., `ja      0xffffffffc013ad2a`) and it seems impossible
> > to infer where the destination of the jump is. I thought maybe by
> > knowing the base address of the program, I can manually convert jump
> > destinations to relative addresses, but the base address is not known
> > by bpftool (As far as I understood looking at the code).
>
>
> Hi, if I remember correctly you may be able to get the base address for
> the image from /proc/kallsyms, depending on your privileges and your
> sysctl configuration, see:
>
> https://docs.kernel.org/admin-guide/sysctl/net.html#bpf-jit-kallsyms
>
>
> > My questions are:
> > 1. Is this a real problem or am I missing something (I might be
> > because the bpftool already reports CFG for xlated version)
>
>
> As far as I'm aware, there hasn't been much interest so far in
> generating the CFG for the JITed program, knowing that it's already
> available for xlated instructions indeed.
>
>
> > 2. If it is a limitation, how do you suggest to address the problem
> > (if it is of interest to others of course). My initial guess is to
> > return the load address of the program in the `bpf_prog_info` when
> > doing `bpf_prog_get_info_by_fd`
>
>
> If the sysctl knob is turned off, I'm not sure allowing the extraction
> of image addresses through bpftool is a good idea.
>
> Quentin

Using the address in `/proc/kallsyms` things work. That solves my issue.
Thanks a lot.

Sincerely,
Farbod
