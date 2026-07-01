Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B264392C29
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934310; cv=pass; b=ClFb7qRlZujCUROkZ0B3RMj3oHOalgrOJxTIRgHFEL7wjxYAHgkCt6Y5aw0PzjEvzfUTpSIk2EA/kwK5SEeFKj6AF2VqIHu36Wqe7FUmHcIHDFyCwGBYQSJMl3jWZwvGwshJyuyjDi4faj9MOkQQAxo9Qqgz7Z6Oux+JvCZcl0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934310; c=relaxed/simple;
	bh=FYbU7ZZR1ardUu7/hnOPvsNdJaF1pTEctjOPw9zaRlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4mQ1ZolqfA/6YbLwM8yvfIKjrGLW6ayaLC1mL1KRwsRPJEsgFuIKIe7YJnIPgcG3ntJh+CLGmj0Im+ZpS/dgor97Zwl+Fxrgrtv3FI7uePcII77b8VcMAxPvpmo5UTtQN6W9+JK2tY7xLj3E/QgTKNawFUtlTsqS37dliqVvR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6xvmvez; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6xvmvez"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c9abe1c505so6443645ad.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 12:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782934309; cv=none;
        d=google.com; s=arc-20260327;
        b=ZwdWoPM2yz0kSyPLXxhYubNT7VKaGqrWtTtrE7dON0b2UrkVsaSRQZL2k6POq6C6Jy
         Rv0oFRSy5pNWhUMOuryAc1OiIGQWvnLNoOviQQFxpF//FY+aWM00Nv4r0WO/sXLLRpsV
         gr/aP5HgAZk9qVSasemb1gJBMJ8Af0GQyqAu81ZPTaJ4obIfilOSbZ8MloXGBltCKAHL
         QOh0vGFZKufcTCcz4lHtWwiN4PwtU9AVvlY62UPO4FcHD0sWfLy7r7nLAPPp/kpFfQd4
         TMoh1ljCk9MlnADVVlKFgmNB+ScAYPtF1MAfAKxG9UxwMpRnUmZSKJWRzopdBw+2VVV0
         ClPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MvSRxvWpZkkrTTRKKZ2eLhjlabjyjLbSMGPDu7w5z/k=;
        fh=Nqu7q/aJ6g8rlmWeSgWiqLCcLcjaPr1wvsB6u0WBYOE=;
        b=rqwWljQvlHRNwvQO5Uly1zDAheD6IK9pR4dxLbJ5UaoxCwdku090lGpES4OyQa519o
         /bbp40LNJ48dHorURv6kfv5NNKbgO2jEeuU3SqDAdydvlloAqG2ei3XruFkajiMblac7
         mge37oiLjn+FxYrZ/b7KFnXxHxGv0qSc3R4wnuWqxBSOdgQs80rSgc8pt4c9TPwV+na0
         fUk8o/r11swoQ3SLrgsaj7XxWRVXVLLTfkb59REm+Mh1xQPOGAa4g5jRdTQ3EeMWFaAR
         k071rmfvhGe/Z/9vQkv17pfjWGOmuwWp6KalbPMetLTL2saTLi6GESaSaTngHzXyB9Ih
         yiQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782934309; x=1783539109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvSRxvWpZkkrTTRKKZ2eLhjlabjyjLbSMGPDu7w5z/k=;
        b=D6xvmvezBv+3bC4Z/x2/q8nqgZMR2PWlnKxhqAQsBkdFap4Qufe/KW5DfUjTXRbzKq
         CVHzHMJuQkaeVKoFh2M+vLsH2UbCeyL9+tajSdrsf8bzbyMCFRCvg6T1EI/OrdQFKtnn
         Yedaid0GhP5Ndm+V2ruU4Qg5I3Tj0ZYZUSWUm2SPVAqQ3hXbf17koJDqUvvJ8AoAqRA6
         g+mclI/syypxgqn2pS0+AvefmcLa1DRBq+5UwY32F2MZr0+RSamBlJda1aVYJrHYaXb4
         UsrJXxUjPJoR1lKcjFc30vxGHLzrNG/5T2Gz5Nq0sNl+NRgvKzVzBDWdYjcoTyCyPyMg
         U9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934309; x=1783539109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvSRxvWpZkkrTTRKKZ2eLhjlabjyjLbSMGPDu7w5z/k=;
        b=LaxDFN4g3c6ywv4E00mSVyVBlYtRDiWZSvFNa865T+UL2RLWBMW4EWWRRj/cgON5Yg
         M2Tvzy8XWnmb6hwWYVYKVOTeG2mQTszavQFVe6682EBj9YLZF9Ms8e2Okx7rkuvu/2Km
         crxsfG1hE4pvmH+v9sypKLrf5yadiUNuGHJg/G/WCHJAw5qVh4uxzRGSZTSlu1fNXG49
         lt2BTR3a4SQs4zMAHGWCEw1Y4NeA5B0wJrHTQrjLftUhxnRs1R/fu1BecYyeuakb7/BN
         J8k1M/DWXx6hVC+zbxx8khTn0EIahsmrV61vb0EIwS5ZVaYu1UdCFzsZrjP92tjBiN4b
         S8RA==
X-Forwarded-Encrypted: i=1; AHgh+RqfgME6McRwK6BRc6463h2UGJLYC6EhTWlbq02hpznG5WbjXuTE2Hs2saNNuYPRBpbiRsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoqM3eT4QH3LUd7VTYVrvZ3SjGeHmb1mRIOWqzjzQ1/8dXe/qx
	WY7biAtipOO47pOLU5Gi0vCKpbYrYN7EWaJIWj8ncdjfSe5GLtBjuc86gTvOXrAA0kESLkV1kvI
	bsvURSMDQRPHCd4IK3ZpFdXuRJ0jL34O8uA==
X-Gm-Gg: AfdE7clk3luLzWI1vyJvDf6UFCaZcYTVtXi/oYSo/Lk8EotlY0aHgq0fIjcA4AFGtJ8
	7THwAiZMKagohK+PkHLfvOSSdW8j4aWTy675myDvv3yBFaYyRd+AsYNm81GxLTiEi8wqHc0KEwo
	xuTQe2ZPhb6AN3SfQzHRGzfYl2XZbvgOF9b+c6sIWYT/sRjCWoa/Z/23hchfe9YflDDwmU8vbPb
	1WyfSXcRJEkfQuCHcQexLoTCZ3uyx43hPVUhJ03DxxFxBKybmu9oOVkISHwKHOU1zkHbwL32CWk
	RkvbDfJYvmMXlmqd/PUZMuvnLSfG4n1fcHD+VQd0OmjayPXjQS0Ojg==
X-Received: by 2002:a17:903:1acb:b0:2c9:c54a:7915 with SMTP id
 d9443c01a7336-2ca91140306mr23456615ad.14.1782934308564; Wed, 01 Jul 2026
 12:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629152406.52582-1-leon.hwang@linux.dev> <20260629152406.52582-5-leon.hwang@linux.dev>
 <20260629154055.6DD941F00A3A@smtp.kernel.org> <96cbecfc-bae6-46ff-90a7-5f4703e1c44c@linux.dev>
In-Reply-To: <96cbecfc-bae6-46ff-90a7-5f4703e1c44c@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 12:31:35 -0700
X-Gm-Features: AVVi8CfISks_LG4JQSiNXyaFUKM0gRwVJ8fB6cCXJJRurC35m-YEQt8rS7IGXGU
Message-ID: <CAEf4BzbBpDQOG-xUArBzZa_qZ08q=QViH-bbFmqwLNesGvJLUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/9] libbpf: Add support for global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 10:55=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 29/6/26 23:40, sashiko-bot@kernel.org wrote:
> [...]
> >> @@ -1983,7 +1989,7 @@ bpf_object__init_internal_map(struct bpf_object =
*obj, enum libbpf_map_type type,
> >>      }
> >>
> >>      def =3D &map->def;
> >> -    def->type =3D BPF_MAP_TYPE_ARRAY;
> >> +    def->type =3D is_percpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYP=
E_ARRAY;
> >>      def->key_size =3D sizeof(int);
> >>      def->value_size =3D data_sz;
> >
> > [Severity: High]
> > This is a pre-existing issue, but could this integer truncation lead to=
 a
> > buffer overflow?
> >
> > If a user supplies a crafted ELF file with a section (like .data, .roda=
ta,
> > or .percpu) larger than 4GB, the 64-bit data_sz is implicitly truncated=
 when
> > assigned to the 32-bit def->value_size.
> >
> > This results in a smaller mmap allocation based on the truncated value.=
 Later
> > in bpf_object__init_internal_map(), memcpy uses the original 64-bit dat=
a_sz:
> >
> >       if (data)
> >               memcpy(map->mmaped, data, data_sz);
> >
> > Can this overflow the allocated buffer when parsing unverified BPF obje=
cts?
> >
>
> Sounds reasonable.
>
> The data_sz value comes from the ELF file and therefore cannot be
> trusted, as the section size can be malformed.
>
> For example, readelf -a shows the following for a normal ELF:
>
>   [ 3] .data             PROGBITS         0000000000000000  00000040
>        0000000000000004  0000000000000000  WA       0     0     4
>
> The section size can be modified to:
>
>   [ 3] .data             PROGBITS         0000000000000000  00000040
>        0000000100000001  0000000000000000  WA       0     0     4
>
> In this case, data_sz would be truncated to 1.
>
> However, in practice, there won't be larger than 4GB section in bpf ELF
> file. And, it is meaningless to hack libbpf to corrupt user space memory.
>
> Of course, will post a separate patch for further discussion.

No, don't. All this hardening of libbpf is nonsensical. libbpf is not
meant to protect against corrupted ELF. If you don't trust the source
of ELF, you should definitely not attempt to open BPF object and load
it into kernel to run with root-like capabilities.

>
> Thanks,
> Leon
>
>
