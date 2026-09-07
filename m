Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9917395ACC
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810999; cv=none; b=AkQ1IqTDqTWOK7KovsIIogKzpZng6+ZzkOXmkB680i8Ip51HDXvz3YvInpZRxCPb0vOI54k15mw1XmKHKwGi5j27/IRkO5p6Sbp6q3p5A0y34Hh7E/+W9S5epv2eH/GwR7G7KFklrsKvatIpnR4AiWFZxcJjAY9cMGDvj9ZS4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810999; c=relaxed/simple;
	bh=hIyFo/SMmuD6DPlw2NjgH6t6EVn4gfJ2lvfYAKWJE4s=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gImi+fh+Sv/cBWPE6OecZsxQaSdnEmVQY/2QKDMRiV4j21wQbOeDIYS6ASKE0q/8GmhiyvsUR+DEsLmiEtjedzFboFqEa/4t+q7tO7TQyxl2vvuC+tNH+v4p/IFKcDKsMU6YN1tIzeu8cFsMva4/hVVz7SODDKC3XrMpLqSI3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLJubxAh; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLJubxAh"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4b381337e1fso3594494b6e.1
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788810996; x=1789415796; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BxrjhQGIzHQ2Ir2WjlL1tbPLZpDSCUP81lVNF69L+iQ=;
        b=MLJubxAhBUeuJNHcA04gPeDT+bNOTW61lFYI6x1HclQ+FX3/vClR6/AalWIbfiL5B+
         3tKajszSp/ol4UpZNdOHEZ/NSdhBrRW9Nt/RsBjnsmZTVfjB2YAxqmXHUuFzYgEHnt4E
         2XnubkvzMNjgAbULWmVQXbkrGHUnvG7H3uKyuffll2wNQ9g3MXmVmv2M6ELVu+jfyXkc
         6uym41WJENhnjQyDAtqDxOmpMZiS/epv8W0TW0BTZShSqu71SoBsSLrrp+cCHwIg4rNJ
         FeHh7/D95hCpr0zFInxtpDZ7EMX0BE4OtjJM/7lLmEsgZKqbZiIJ0S5XMSY0c6wiSi2Z
         Empg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788810996; x=1789415796;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BxrjhQGIzHQ2Ir2WjlL1tbPLZpDSCUP81lVNF69L+iQ=;
        b=i4r54ToSP69GrmlULEdOZxLyL9HQEOiYzn+fPixJKRZTSyCCHknvnBoZBDtqgom3a1
         HT5tVDmO8LNZbUhTzK7NQkONoftaFjlWHEuX6hIlAZtYenU3/07nqSZ2R5BchkNNh54d
         FpT0B4bw9J4ufdOiahfKf0uW38CptYkXiqsKxnZxd9S1RVnmMgjSh6ySPEATTt6F5jFF
         yBLriSgkAclIUd8WZGHCr0gEKfBgdtrOzwxEMVWEsnsCcK5Ms1gbR6BpWZrThd8C78R6
         31XbxMKxMPw/8/h45jba2twGvHbLv39svlASkvAZhI3pRkMkZBk7VnvxMk1Vig7krMtU
         qM8Q==
X-Gm-Message-State: AFuF++nWjxl/3uSbd/wu3Yv0y9hsS6zgxWkjCXCoQqOkzCPf9VS0jid8
	HKw0lmC7Phh9CXbb8N/VfeZq7lmaoa6Hg21eF53ynOPYQKW3yUj+TbAQ
X-Gm-Gg: AYBFou2HMIzTTHYHex8PmUVoYnvsQbhKXLSUWrx4ixMSyMHTFqtq1fyP2TJfjT4JSvA
	ROh/HHEW8LSbgiHzG2vZNPl2f9qzbQGYmoNJTDdXJCtd/jgggMvI+SrszpBYFk1WJ5k4Z8z16rU
	yQVeSn6WsLLy9ZafKVh2D7mS6hK6Z59SbdjC3HDa4kpJ35KWM5vFZFoPV0KTsW/057BwaBOYZRI
	zcvwlvCdzHjcC6sMxidLh/RVYIRrGmY2D3BUnNIrPtlhEVcxz4Z4OPkL51+Lhq93LsivXeH9I3K
	FWeZVTw5AmN7NyEOEq6inOIRx27bWNDEr6E4VfA4W4VITFEgKLrp+JBoqP9u/yJVfpA/GaqrqsT
	EOF3At+uGpmjVKGwQ/CnKmblW7oMNkWdAh+TlNDyEKBpX/NcRhojCBx1T05938RYHXMCnTJESbN
	2NwdIvfTUgEF3nfKeOhUDAyHYHMmT4FivWYDDcI5+n6mMxj6Mo2Q/On+RfizCPI1Fh6gkcw0JXI
	j0xIwvF4VrfZlpmagnlohd4QQQck9oujOILJ2GQed/lTqWSVlRhLtqOthkYosTp5Q==
X-Received: by 2002:a05:6808:1984:b0:4b2:21e2:82d5 with SMTP id 5614622812f47-4b962b66ef6mr16875564b6e.10.1788810996417;
        Mon, 07 Sep 2026 12:56:36 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475543fcaa9sm9517301fac.7.2026.09.07.12.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 12:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 12:56:33 -0700
Message-Id: <DL9CKPXX2OFG.2EK0RAZUT2PMV@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>
Cc: <bpf@vger.kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Mike Rapoport"
 <rppt@kernel.org>
Subject: Re: [PATCH bpf-next] bpf, x86: Use global buffer for trampoline
 size generation
X-Mailer: aerc
References: <20260907160538.922450-1-jolsa@kernel.org>
In-Reply-To: <20260907160538.922450-1-jolsa@kernel.org>

On Mon Sep 7, 2026 at 9:05 AM PDT, Jiri Olsa wrote:
> Currently arch_bpf_trampoline_size allocates and frees a temporary
> trampoline buffer on every invocation. The buffer is only used as a
> scratch space while __arch_prepare_bpf_trampoline() calculates the
> required size, and the generated trampoline is discarded.
>
> Allocating a writable scratch page during kernel initialization and
> reusing it for all size calculations. This improves tracing_multi
> attachment time.
>
> With current code:
>
>   # ./test_progs -t tracing_multi_bench_attach -v
>   ...
>   serial_test_tracing_multi_bench_attach: found 55227 functions
>   serial_test_tracing_multi_bench_attach: attached in   1.563s
>   serial_test_tracing_multi_bench_attach: detached in   0.256s
>
> With the fix:
>
>   # ./test_progs -t tracing_multi_bench_attach -v
>   ...
>   serial_test_tracing_multi_bench_attach: found 55235 functions
>   serial_test_tracing_multi_bench_attach: attached in   0.798s
>   serial_test_tracing_multi_bench_attach: detached in   0.258s
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> was "bpf, x86: Add support for jit dry run",
> - doing this by having single scratch page instead as suggested by Alexei
>
>  arch/x86/net/bpf_jit_comp.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index bba351944202..13ef0d53ca29 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -9,6 +9,7 @@
>  #include <linux/filter.h>
>  #include <linux/if_vlan.h>
>  #include <linux/bitfield.h>
> +#include <linux/init.h>
>  #include <linux/bpf.h>
>  #include <linux/bpf_verifier.h>
>  #include <linux/memory.h>
> @@ -35,6 +36,15 @@ void __asan_store8(void *p);
> =20
>  static bool all_callee_regs_used[4] =3D {true, true, true, true};
> =20
> +static void *trampoline_size_image;
> +
> +static int __init init_trampoline_size_image(void)
> +{
> +	trampoline_size_image =3D execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE)=
;

I think I asked it earlier... why does it have to be execmem ?
Can it be normal page?

If so then alloc it and free it every time. No need to keep one page in res=
erve.

pw-bot: cr
