Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65667399007
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781644456; cv=none; b=bnEK98aokmuQpeRJ4ur1cutJfvlkmykMIX9IBu8N6d8RhmmVPHe1mRuuZ0Dcq8W5Gdd7d8KwS8wrsDdHVyf/DHQXDvCFuJXBYMKJTVohMt3rnjZv3mIJ5oHm6UI8JHPYu9Vgle04o7t+3it0njCjdWaAKkQTVOz7SFohWUrGWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781644456; c=relaxed/simple;
	bh=szkiZMk/51Dn59gZAVp5UYnh69ioTUYKzeBduM21+TE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Z8DMHSrQluRVb7Pf4xsQ5bWmkw1nwHEJnUAmRaG1Jv0STVdqWqAOjEQUiaEgsVDOMPkV5cFN07IBtVG+XRA8i6doOVPNdYRQIG9Q927IUvSm9w7/TY3tbodFzXMV2rAo6RXKH8y1spRXJuCkomvDtNndp6XvobVa1c2mAfu/Y8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=MrEQhncq; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="MrEQhncq"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304d8362a58so240116eec.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 14:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781644455; x=1782249255; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c17Bx16QV5sl8RyBSVDSL07SiEznBKCXYOLNi/brxf0=;
        b=MrEQhncqmacAwuD+IhhHv/AvLjg8onI+AK5Sc/N+wrFW6GVJt+GtMPURg0j/QOwnXL
         jz6Na2vvniMbHUxUuUFhAxYGkXr+KlN6hoWpPTu670lAKabH9SJ45/2OF+crovFC9QHQ
         nb51bqqryLe7tRogJjboV75iDcmFRPs6EF0cZB7nTMEFOtuhefEOXFwKjze4WvNJuLu0
         9D461955t3G77ka3tSwyb5FJAsDT20JACtpcl3VQ6OMECf5NyA8oGsJY9bypfIsxssLh
         FIBNGWfXF+9h3blXb5ppQ3SG97OdRKzbnYSWW9a7bDvs+0FvN4gtm29ROJSsLC4sn6uv
         nHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781644455; x=1782249255;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c17Bx16QV5sl8RyBSVDSL07SiEznBKCXYOLNi/brxf0=;
        b=TGG1AS8kSQqy4M5SIZA6U2FWHzC4BNQxdGb73Kr904UTKPRCVujjz2CqAyT4poUKCZ
         UVng7qn4k7Qh7YOZWiWnMqmUYO6sOMZMeCcKj3AOSNDpjzEt1Rbia7FYWCykWS4n7o0y
         s5rvqz/wonuQC0t12DbBeleyRTBEcl1JPmpXQDYvyiui+rS5ii2Kk8/pBrGLOgUG0v4Y
         L9ViiXBKGMgBTlpY0a8iDxWOHpBQ24AWfWLGfxcr4UVinFDArLuX9GN0vlpk0LZYElE3
         ro2tdWHRK16jj9UqqOJ61JfmL7PEDydXhE6swPMzj/28RywwCeeFhmzrxhIFVf/K28ER
         pyPg==
X-Forwarded-Encrypted: i=1; AFNElJ/W8C/aCDLX8bOASWt4v5YLprgD/NoskemdxwpbYT/LXIwIddbeQ9QDRANMQ+kG6aomIYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3FwSj3S2Nj35AKB9Hxo08gPfJ87sAZQtPM1do+iijPiC62tij
	d9RHer7iZ53A0bg772YKQpzm/1JH7CakmY6/yQhN2xWWc4RDrHXp7a+y+U6KO4pVnQo=
X-Gm-Gg: AfdE7ckAqyAyc4Cb2lgeYrZm+i49GVmsJmICQSQ1eVVBAY4qLfUswZKk6uzMZn97y8r
	146RqoqBQl/R2Iwcs2WB6CSk6i1gWgArd/uTtJsDlE2DImT5At2VqSaj37roZYs8ilF7ZHlGEmp
	TzZxJlFprJwLJgBkztg1tGdUlkP+H7bxZjLl3Pz0JNqTKG31Zoer6ChEfxvc6APjILa5WlFM/kK
	db8AClMbfvbhQa8theZz9KFYEEF45WDcZEpggkgdsXelRSmZV/mYdlmA/MM19NaE+Y2U0pCyOrp
	7MDhHGF6g93Fos4L4/K20fJSYFhVx2NtvCX+2vmN//mUJkb9K5sGMNdG40Mt7Slv4btdYM9b1RF
	68JFvY8PxnJhdKtsBPWWUmk7pkjiPyppEH/x9FGjU2xyhGmFsxtIIqhFvs2ABOZirkFDW2pCCMZ
	cumsCN
X-Received: by 2002:a05:7300:1912:b0:30b:b4b5:4979 with SMTP id 5a478bee46e88-30bcf50dac8mr197992eec.12.1781644454518;
        Tue, 16 Jun 2026 14:14:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1a8e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95450sm25214840eec.28.2026.06.16.14.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 14:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 17:14:12 -0400
Message-Id: <DJAS8Y6NFDM3.2UBTXDT6CKACA@etsalapatis.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Luis Gerhorst" <luis.gerhorst@fau.de>, "Shuah
 Khan" <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover stack nospec slot indexing
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn> <20260617-f01-11-stack-nospec-slot-index-v1-2-e3a080b0cd7e@mails.tsinghua.edu.cn>
In-Reply-To: <20260617-f01-11-stack-nospec-slot-index-v1-2-e3a080b0cd7e@mails.tsinghua.edu.cn>

On Tue Jun 16, 2026 at 12:57 PM EDT, Nuoqi Gui wrote:
> Add a verifier test for the fixed-offset stack write case where two 4-byt=
e
> stores initialize opposite halves of the same stack slot.
>
> The test uses the CAP_BPF-without-CAP_PERFMON loader lane so Spectre v4
> mitigation remains active. It expects both half-slot writes to emit nospe=
c
> in the translated program.
>
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Trivial style nits.

> ---
>  .../testing/selftests/bpf/progs/verifier_unpriv.c  | 23 ++++++++++++++++=
++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
> index c16f8382cf17d..9ebbd4b531df1 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> @@ -976,4 +976,27 @@ l0_%=3D:	exit;						\
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__description("noperfmon: Spectre v4 stack write slot index")
> +__success __success_unpriv
> +__caps_unpriv(CAP_BPF)
> +__retval(0)
> +#ifdef SPEC_V4
> +__xlated_unpriv("r0 =3D 0")
> +__xlated_unpriv("*(u32 *)(r10 -4) =3D r0")
> +__xlated_unpriv("nospec")
> +__xlated_unpriv("*(u32 *)(r10 -8) =3D r0")

No whitespace to the right of -

> +__xlated_unpriv("nospec")
> +__xlated_unpriv("exit")
> +#endif
> +__naked void stack_write_nospec_slot_index(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 0;						\
> +	*(u32 *)(r10 - 4) =3D r0;			\
> +	*(u32 *)(r10 - 8) =3D r0;			\

Unaligned \=20

> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

