Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C96257827
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112907; cv=none; b=rCWq0vlYUjGcL2niANR906MuQNS/FhIzlXWwayO9b6C+lFOtgvd0+mbK4mK7l1ZZBh7VVT0/nd0F1FTnynvdbtbSfTOQxjjm8yc2VQRUFmqXziZ4W0L/I0xFFMasNQTvq2j0GcMc8prTCK34B9K3ypu8mac96dbIOYAaBUmzBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112907; c=relaxed/simple;
	bh=Iz4YOTsmD7veUO3iudU+wuEJxP/eGedm4I6vX5uI78g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mfLABODnl0LmyoFksA2UgpAS3+q4Yrrx2dyGkZHc2I11h7rKsBGBWuFVY1PRJ+gbXST0YvzIbmj3X5hCkTJrlDBW9u5NBLzhxa+ge0JCeOxu3NdcUSl0fzSaKTlQApsWSmG1l7QTecQE5Dq8FsK5O2ZRTaUz8FXV0VrqbCw1oj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4qz5wwK; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4qz5wwK"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso2535968a12.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792112905; x=1792717705; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w0+spJL5C4C3eiHVSz7CuLh5ZhYnqXc1ZEKa8rDfKBE=;
        b=s4qz5wwKYLHvykWMyp118Ti2tpSzamYSYWPyPiCD2X3v6rtDI2u75jJoi8BP70Gze+
         2rTfuFho30dRAH0i8TaNltf93TaOL8VmVBET+5X+hJ7LltE+aGpst0VaEZyU/1K+e3lQ
         AroKl04sJ78FSbaQMCge0ggJIE1p4x3vMwqCOa+dvINlsW+z9j+QAK8wkgVsTiKINwmM
         rL1kACHqtnBpgBdcrZyg0OgeWBMciah31zlF8ywUa7X2wCz7YT8uoBj6E5xVFAanlnT6
         kJdGL5X8cS39kC0erIlX0+Ac0dl4G7HINPRYfu9cBNUQNcREVkEup8MHV4NbxHD9j9OC
         1r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792112905; x=1792717705;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w0+spJL5C4C3eiHVSz7CuLh5ZhYnqXc1ZEKa8rDfKBE=;
        b=gXtt3anQOfqRSRkBmbU0z89fRbHSejHP8mOu6a76creNQNKC8GNJA5MyzHx6hPJmzk
         XHYtsbzNMe+SGalhzEH8sRboSSu+nyUvYTq4hiCwVY2B26x6FJ+ILv+G4xBocP9Yu9dK
         TRARAsM/cP7gEg19pnl2MfQU9ekkUQmnroNBBLa+6p07atbH46Gb+1kSUDHYnFCePId4
         YszFB8lo/BOPsD/Kt1NqzEpAQ7OTDIHsan2iT8w/McWoVzWQc3yd56WGXCd5KCwZuD7o
         o/YN+o+uqeCWhdTWH4HF893jFnurwzOeDR/i2jaB9Y5Jc60PuG0fhUeOSn/W0o8louUg
         PeMQ==
X-Forwarded-Encrypted: i=1; AKwUvByVmr6gUdQemLAqfnq/SuEGI1lMiAEQVVp+jJb81aX58a6IPxIdb6jhb4nOZchBwVxGET4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOqgH1quJcSbQKd0nUg95N/Yq0dwBCdRTj4WhcqVSQUGfV3SaN
	pVOoqyJ7EIKcLdyY1cRpzRiglKoCHicEWI19io8nSK08DlYfhgb2qGxT
X-Gm-Gg: AYBFou15UwyIhe2q3DOyJh0HoVYuiYma1/dvbH/PU3AM9coKbAHCtQwExoiBTVB+tu6
	+XWG3psPssEBOs1yVTSHDet8/eaKMuLST5UOQ7s/OrdvVVcEfkz53BMjwOF2fJye1NyU+ZqDwWz
	iP9MRin73ZuhrDZdC8rMajcooYte+gQpMhO1VrQDE5T2VZeJIw0ujcwdCrHEx7YzwsH31oWrclc
	Md/VGqdInUsK2n5ZboeqeROI99q4PXRN6kUKcNI6KVbzz45novmrkjMoBceghkxq/IGgjc5Uo8G
	ICozJSh0u1kS8WJsThDa0CytSoqpIh319jrHtemB0CAvASoTvOmEAHY5T2VZuw2r9buau6QcOh4
	2TNQUQ4XhDpoCtVMO1TnmnHjuWeppKa0ttq3BZgiQG2B5KPqsjnH6RL1n5zdeAYFeRdI7QQl4t8
	gPRKAISK9LRpVxLFnyscebtZrAZhTfiObzod/8RZFAl0vUh6QlX5V6uBRErY+sSCB/GzO0eNqC9
	hv0G8Tjmg0X0ebQPDXYysGISi+q80Yb7fwU0l3VijQ6tH5gaYlJ8PJ6pgRcL4lqWkdcoIt/Fx99
	GyE=
X-Received: by 2002:a17:90b:17d1:b0:3a6:f1d2:57f8 with SMTP id 98e67ed59e1d1-3ac53df025cmr8318460a91.2.1792112905049;
        Thu, 15 Oct 2026 18:08:25 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549b42b8sm244951a12.12.2026.10.15.18.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 18:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 01:08:24 +0000
Message-Id: <DM5V06J7GLXR.2BJ4ZJ3IN5TT@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Tejun Heo" <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 05/15] compiler_types: Add __arena and
 __nullable BTF type tag qualifiers
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261015234125.3152346-1-memxor@gmail.com>
 <20261015234125.3152346-6-memxor@gmail.com>
In-Reply-To: <20261015234125.3152346-6-memxor@gmail.com>

On Thu Oct 15, 2026 at 11:41 PM UTC, Kumar Kartikeya Dwivedi wrote:
> Kernel structures increasingly want to publish pointers into a BPF arena
> to the BPF programs they are shared with, and some pointer members that
> reach programs as trusted are legitimately NULL at times. Neither can be
> expressed today: a pointer member reaches the program as an ordinary
> kernel pointer, and sched_ext resorts to a plain u64 holding a
> pre-translated arena address that programs cast before use.
>
> Define __arena and __nullable as BTF type tags, the way __user, __rcu
> and __percpu already are, so that tagged members survive into vmlinux
> and module BTF and the verifier can act on them. To kernel code and to
> sparse the qualifiers are empty: the pointers are ordinary kernel
> pointers. The verifier side follows in the next patches.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/compiler_types.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
> index c5921f139007..e97ee2d4d1df 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -51,6 +51,8 @@
>  # define __iomem	__attribute__((noderef, address_space(__iomem)))
>  # define __percpu	__attribute__((noderef, address_space(__percpu)))
>  # define __rcu		__attribute__((noderef, address_space(__rcu)))
> +# define __arena
> +# define __nullable
>  static inline void __chk_user_ptr(const volatile void __user *ptr) { }
>  static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>  /* other */
> @@ -70,6 +72,14 @@ static inline void __chk_io_ptr(const volatile void __=
iomem *ptr) { }
>  # define __iomem
>  # define __percpu	__percpu_qual BTF_TYPE_TAG(percpu)
>  # define __rcu		BTF_TYPE_TAG(rcu)
> +/*
> + * Qualifiers for the BPF verifier rather than address spaces: __arena m=
arks
> + * a pointer into a BPF arena, __nullable a pointer that may be NULL. Th=
ey
> + * reach BPF programs as BTF type tags on kernel struct members; to kern=
el
> + * code the pointers are ordinary.
> + */
> +# define __arena	BTF_TYPE_TAG(arena)
> +# define __nullable	BTF_TYPE_TAG(nullable)

I feel this is too early to put this for the whole kernel to use.
Only couple fields in sched-ext need it, right?
So sched-ext can define them locally.

