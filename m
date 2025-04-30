Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0FCA4B
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971454; cv=none; b=p5v3gFcKRdb1qOMBbNGzZz8GIRx/zaik66gDkntyan7PrcXLMRk6XvVWM4XWKbApQ2YcX6uT/ZRB+Ya+Cim0sW0w/nooPh/BbhfcPzWruQZt2VdBQIEIM6ihKlSEyoQ8ffE1VJZp0ljRCw1Y7IDmr+tOfdNExnR6o39ga8IaAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971454; c=relaxed/simple;
	bh=KYb7Sd5tNsj+RMg3B4QlGYieTbuTCHXhuq01IOsRiCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFV0bk4F0rK3BpI8EMsjZdzTnUuwOtLyR4fnWw/C5gKxYDey9XxZdE9MR/Ubf6Q6W5kYafx2AFTq+24yqioePLq6riuTqyIBxJW399qrcBOeZqnt1JviSM89VtCcU9VatTDOaieMqD1A6zvwjGTHt5Sip7+y+alB3kIetu21LC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RS5izVsn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS5izVsn"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c14016868so6879267f8f.1
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745971451; x=1746576251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1KeXJR1hOzBjZTqW+K21z7sqJwFRtjxFIgXNhmbOqs=;
        b=RS5izVsnaM7CBYpUbki1KakaM7SW/2/h/gHHVW3bbtOM+kcEJsNLzGkPr7OqflHAuI
         L4wYdJaDjsYm2qM7VMk4ZejWR/iGEMq2CDq4gVeEEfy8+p6UoHT1xEwki8/6M/24prLb
         2idohyyze7CpwvVVYoD6pNE+jQfWCdjSyyv1FhypUGzbagRuIE8HeqoZ+dUmAq5sOiKi
         kyWBXsqsm7fe/yfWQ5R61CUEmhJwmvSFv7SqtxGNjnv465nTcRdUKZHZu5fU4Bw6JJUz
         XQLFR0myyf/Jh0kavUB2IufQ5v0dqqsIYU789LObx3BvMDX0KZGWFK6dVQ0jnfmpClVP
         YtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971451; x=1746576251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1KeXJR1hOzBjZTqW+K21z7sqJwFRtjxFIgXNhmbOqs=;
        b=ugbYcjtXRTqKbCpK+bHdkyXeo5cnX63S2/Z9iUxBYX72B1Fs5NYIgQMNMKZHSVcUKQ
         T/Ma3YLwOtyiy5eTU8fOXY5C/ps2YCnoyO1/7KIIadBStp2HCvDoJwsyaegyRvgId5zz
         bP7cacsBrNGrASvA4BJplP/3HU90QukwKVy0J1lWNmD63n3tMRcHhcxaqDJrHcifm5xB
         +zWV1XYhrOK+crF17IY1AUMA5KnkAZYaqcdvgMDV+7JqGcAe8xdQ2Pp4LatAgKZHgUqJ
         tstqPtL2xON2P1H9/6cTecQaaifSFvC4lM7OFvqF+e0eOyln9M+zazKEWXh4E89Rgll6
         GnuA==
X-Gm-Message-State: AOJu0YzZTQOft1oRJuEE4iogRA7EF1shC7vEEmp3ctHt1jiaUzHxt5td
	KPbJ5NvqzBNL1Zr+8a2xNE+yemlXYaRBXMIzuH8x5Y+RGPB7+jgjlUYfE4hXOVrHaDRkk/qREDp
	CTSFI5/7tOhjpHZyB4aHUoLO61ck=
X-Gm-Gg: ASbGnctVj9aQ4+aFhvvqOTx8rCjVKdJnuJeyYFVhzZp/PfU0KifWRgI2eGJGB4AcAcp
	fNGqVrqo7RDZr9+or+EEDLDdt1GKElhHLUDyL11/wqdyX5Qf0hNpXrihYz/CtltNw2TXzjB+5KS
	T5532DncybDaBnWk7hICekhJGxOgHk9C2qW+lAAg==
X-Google-Smtp-Source: AGHT+IEp4MiLtY0qKxS6UrNJvJKT1oFoIU9/fZqZHU+KWT51EHruQ+vwvp7Oizo6pEuXIEHqkQtR0PijT/tOG5eXN8o=
X-Received: by 2002:a05:6000:2282:b0:39e:f9e8:d07d with SMTP id
 ffacd0b85a97d-3a08f764d93mr924789f8f.20.1745971451027; Tue, 29 Apr 2025
 17:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429041214.13291-1-piliu@redhat.com> <20250429041214.13291-5-piliu@redhat.com>
In-Reply-To: <20250429041214.13291-5-piliu@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Apr 2025 17:03:59 -0700
X-Gm-Features: ATxdqUFdIYrUp0QWhy9gP5VNKqfBVnewOUvIA7LbeFFyzs8budADNuJnnCReKHU
Message-ID: <CAADnVQKTSubuisSBap_J=tgO15fCdtwF-NDY_1HLP_m6o28mhw@mail.gmail.com>
Subject: Re: [RFCv2 4/7] bpf/kexec: Introduce three bpf kfunc for kexec
To: Pingfan Liu <piliu@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, kexec@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 9:13=E2=80=AFPM Pingfan Liu <piliu@redhat.com> wrot=
e:
 +__bpf_kfunc struct mem_range_result *bpf_kexec_decompress(char
*image_gz_payload, int image_gz_sz,
> +                       unsigned int expected_decompressed_sz)
> +{
> +       decompress_fn decompressor;
> +       //todo, use flush to cap the memory size used by decompression
> +       long (*flush)(void*, unsigned long) =3D NULL;
> +       struct mem_range_result *range;
> +       const char *name;
> +       void *output_buf;
> +       char *input_buf;
> +       int ret;
> +
> +       range =3D kmalloc(sizeof(struct mem_range_result), GFP_KERNEL);
> +       if (!range) {
> +               pr_err("fail to allocate mem_range_result\n");
> +               return NULL;
> +       }
> +       refcount_set(&range->usage, 1);
> +
> +       input_buf =3D vmalloc(image_gz_sz);
> +       if (!input_buf) {
> +               pr_err("fail to allocate input buffer\n");
> +               kfree(range);
> +               return NULL;
> +       }
> +
> +       ret =3D copy_from_kernel_nofault(input_buf, image_gz_payload, ima=
ge_gz_sz);
> +       if (ret < 0) {
> +               pr_err("Error when copying from 0x%px, size:0x%x\n",
> +                               image_gz_payload, image_gz_sz);
> +               kfree(range);
> +               vfree(input_buf);
> +               return NULL;
> +       }
> +
> +       output_buf =3D vmalloc(expected_decompressed_sz);
> +       if (!output_buf) {
> +               pr_err("fail to allocate output buffer\n");
> +               kfree(range);
> +               vfree(input_buf);
> +               return NULL;
> +       }
> +
> +       decompressor =3D decompress_method(input_buf, image_gz_sz, &name)=
;
> +       if (!decompressor) {
> +               pr_err("Can not find decompress method\n");
> +               kfree(range);
> +               vfree(input_buf);
> +               vfree(output_buf);
> +               return NULL;
> +       }
> +       //to do, use flush
> +       ret =3D decompressor(image_gz_payload, image_gz_sz, NULL, NULL,
> +                               output_buf, NULL, NULL);
> +
> +       /* Update the range map */
> +       if (ret =3D=3D 0) {
> +               range->buf =3D output_buf;
> +               range->size =3D expected_decompressed_sz;
> +               range->status =3D 0;
> +       } else {
> +               pr_err("Decompress error\n");
> +               vfree(output_buf);
> +               kfree(range);
> +               return NULL;
> +       }
> +       pr_info("%s, return range 0x%lx\n", __func__, range);
> +       return range;
> +}

These kfuncs look like generic decompress routines.
They're not related to kexec and probably should be in kernel/bpf/helpers.c
or kernel/bpf/compression.c instead of kernel/kexec_pe_image.c.

They also must be KF_SLEEPABLE.
Please test your patches with all kernel debugs enabled.
Otherwise you would have seen all these "sleeping while atomic"
issues yourself.
