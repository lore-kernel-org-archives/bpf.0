Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878867750
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144738; cv=none; b=PtXMnfNJNsx8/IKJ7A8I7OK/ObY4eSvXnR4ukbGWufNCXWe6WQAfjRtKfx/1aLfyBTwJZypdB4VkH82D8Y4NfobM3y0a09zb5J87QNcJM6lBEQukLHzLV0d4jETHzLMBRJ7fWWeHoTR5T5mT2VzqhoQbvDdP90QE/rkdWxRYq+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144738; c=relaxed/simple;
	bh=eQSl1D9jtau/tNxDvzgNSvUu0+X9v0y+CD7n+gfenvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayBKP/+Jf7JzxZZwS23/lKY4D6tOCJAxD2S7DtbJ8yVH3GWdxZnagU6r099qJGm2xW1VndEWpxBSpGCk/DVNV5eoc/X3dPqoP7tSC8EOAGOp7fp2Clm+auXFgZG7SHbBWczXVBM+ETu6TPgwSEakvURmwPYbXpqJRFQpciUsxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHGk+jmH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHGk+jmH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0025ef1efso16063695ad.1
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711144736; x=1711749536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OMIY5f1gJBb5ybPsu+vT+XrO4cKKPs9xKxLzbUyrBw=;
        b=cHGk+jmHKqpHjdlCQA8dHjUH4VOrUI91KwioYTB64kQxUnuZia6BmbOH/0+VNOyod5
         aNAEUDJ63RxZQXiPquflied7uU4K+sHLL0803KvQHH84OPn9kknkH/OUz9Ttd6egkY+5
         3EJJsJBp3Iu6C4aan3xbfnPUvfwGlk9GIu5vEC3ZQ0T0turi/3rLgBEOObuXb5JiVkZ2
         gbwXp6U4M6lJpdqWuXUlmumAJ1q/yXTqmRttOtdGGkBVnk9fORVu/e3Dg2DbeejR8FJw
         TbWj8EyeaSW52NYJaNgXvXM8UF2PEKgxsDaSwkHTMTXoiSTUv3V5ZG1eaB+y2SsmXcFY
         coZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711144736; x=1711749536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OMIY5f1gJBb5ybPsu+vT+XrO4cKKPs9xKxLzbUyrBw=;
        b=JgbbURLRo+Yb8nr+rEGfmcO4TQr0iCZv7RFe3mYVsTPb+j95lqUFF9WgrCr/qQL9kk
         6t9XDqWR/o6l1KEAmKL9iXp1QWkAtuAXnTMvCBMsMIO3css2vPKDDujKg83aiWloINiP
         iVWwpcF073fVcGvKAaQPjO7P31gN8b7Gz5JDgT1xFegS+YPxCU89Aqjcvkl5TT5jFqen
         q94UzszcK21Q3FTHXE1zNsNb28Yr9/rV/Dn+PGHe9hVPev4ye/mvvUVTZvSkwABh8EEn
         GI5+z9eTHW9VQaTwD2dbJWgLuVcpyDuNsqNG6Gy6iiyoY138gbInkIRmk4QaPNNYj+D5
         FQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCVLbMrq3alUzKm/0ofFWDflMZovwZU0FodABkmknYYYo6sy8XZ7YOcXqgVe2VRB55NqqI9WyHiNz9HxZbfwH0a8SMCj
X-Gm-Message-State: AOJu0YwKNTD+vYNe/VSbQEmjNf9mpKGzw+A7m+s1uHjyiKHeqgFdrezW
	hoU7jcNfuV2Oyj0BTqtHWqCrtcV6tehPs/woyal9cyKIlqZFJE4c4lgBOyb//cD5Bmnz7DHIaug
	SIZXmrtNM7AeestJZ7eTWFl1ErpQ=
X-Google-Smtp-Source: AGHT+IH3/eCzhIPKsFlGZ04aLN5/lxwuY5Ny0VGBRcB9cx7m+Q/uFfehXH12/242nUSXYAOlOVpkcBmzMvgIFj1hoH4=
X-Received: by 2002:a17:903:32c8:b0:1e0:2e8b:f4b with SMTP id
 i8-20020a17090332c800b001e02e8b0f4bmr1031993plr.2.1711144735872; Fri, 22 Mar
 2024 14:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200124.2220345-1-yonghong.song@linux.dev> <Zf147sHXbgMs1yDZ@krava> <0bb5c256-a564-417c-b252-166aec017870@linux.dev>
In-Reply-To: <0bb5c256-a564-417c-b252-166aec017870@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 14:58:44 -0700
Message-ID: <CAEf4BzboP30Qto0jtJ=-_dbxqA375qgKsY5J5VAt8DS3=sKE8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Add a selftest with available_filter_functions_addrs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:07=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 3/22/24 5:26 AM, Jiri Olsa wrote:
> > On Thu, Mar 21, 2024 at 01:01:24PM -0700, Yonghong Song wrote:
> >> The current kprobe_multi_bench_attach/kernel test
> >> reads sym names from /sys/kernel/tracing/available_filter_functions.
> >> Some names do not agree with the corresponding entries in /proc/kallsy=
ms
> >> since the corresponding /proc/kallsyms syms have suffix '.llvm.<hash>'=
.
> >> Actually, if we pass symbol names in /proc/kallsyms,
> >> kprobe_multi_attach will be okay.
> >>
> >> This patch added a new subtest where addresses are retrieved from
> >> /sys/kernel/tracing/available_filter_functions_addrs, and use the
> >> address to consule /proc/kallsyms to get the function name.
> > hm, I don't understand the reason for this test.. AFAICS test_kprobe_mu=
lti_bench_attach
> > is doing that already, just reading available_filter_functions file
> >
> > both available_filter_functions_addrs and available_filter_functions ha=
ve the
> > same functions, there's just extra addresses in available_filter_functi=
ons_addrs
>
> The goal is to include those kernel functions filtered in patch 4.
> But we cannot use the names from available_filter_functions[_addrs],
> and we need to get names from /proc/kallsyms. Hence this patch.
> This will test if we give names (<name>.llvm.<hash>) to kernel
> for kprobe_multi_attach, things will be okay.
>

for patch #4 it would be good to not skip those *.llvm.* functions,
but find the full name using kallsyms. While here we can use address
based multi-attachment, while getting addresses from
available_filter_functions_addrs? That way we'll have a test that
benchmarks both symbol lookup paths in the kernel (where user provides
symbol names as strings) and address-based lookup (where user provides
raw addresses).

> >
> >> +    *symsp =3D syms;
> >> +    *cntp =3D cnt;
> >> +
> >> +error:
> >> +    fclose(f);
> >> +    hashmap__free(map);
> >> +    if (err) {
> >> +            for (i =3D 0; i < cnt; i++)
> >> +                    free(syms[i]);
> >> +            free(syms);
> >> +    }
> >> +    return err;
> >> +}
> >> +

[...]
