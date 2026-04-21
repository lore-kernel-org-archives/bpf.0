Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9626AE5
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740318; cv=pass; b=ZEEfByeuYRMMR7EcrElSRxhgS2M4s5NzS6VbhbHjCdzXflvrgneB2FzN3p1BJ+Ts1rKR3/P5aEOwkdqKFDAJbuvgCebIo2QzN+iLV3xqGr0yd2bitlo95GXk+WeLCyJRK2l0Aa2Yp8VHloVBI1Bb+zwE06h4mKrdSzPYfygulpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740318; c=relaxed/simple;
	bh=15zJuDN82sLupPnVtGsTihWSYlYDRHMJjrZzNaXHHlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdvQsQ4H/Rr3R/ggcPChxXNj51OqD5ysfzFN7PbeckHLm0nOoVl6Grf3lb2IbZCchfEDLxHW5YiPHpLthOwkwEoDeSROD2zgSEoXctHMzBTnDUkHWtT5GDlJtiEta2vTurGkIT/dRdMFUaiJfc3aIvsRDKSVWk0aWYMZz4Dl/rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keU7vZB9; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keU7vZB9"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfbd17589so2821795f8f.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776740315; cv=none;
        d=google.com; s=arc-20240605;
        b=akA8NuFfHyet7XhYg+JA1JwQ0/pov6l6hha3oV/7hj6iOZnjhbdtQzcAMvGUmnMUwp
         +EjOBzodurOl/0CcgH/h1N45FvPd/71xXAWv3jocx+KFzmydhRTS1Qe5YMT+s1QqF77F
         YlHUfi4aAsI84oe/Yx/HJ7uCbRkDdEnP/T9W8cbNwK4y9JgChmmyMyuzUJn/FYIQOdiA
         RJsWzXulBUPRzU2by/ys4ouzxnTR16CTUx6vK3MM2X0avQxxU5SC6LuqFY3z1pnT/PYG
         0VoA68URUMCY1cBmoantcTtHcrJ6+n2wyi2Ytl/ncOrN+Bovxhgu9CKoz9FB1Y2NOCrS
         50zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P8sfVF5aPV6fheRm7xIg/4vXl2F2m+SYWiTCmFqi/mA=;
        fh=XMPXhJunIeQjd51PRvXsdfiXmYHhFtrzrqh0GLXLa/M=;
        b=jaGRWjYg4660jhelOIk2dx0IIYqeFBw4B8mU7qnpIbFYTUWAtZnwZOcv+9VitAwL8R
         C5bltIiemX1Q+A+p1NJVcqkBJ84e6czXu3sohiu17Xehs4PqlIrOmuX7hGRCFN/+KYRZ
         wjfLIfvWf/p0S/WvRLUQmb7HtD7qM5F3qqFZ4Qq+GW6Std/FQwaruvn/DXRQyfYyt4QF
         BjGv++arqHH73pZ/zvp8PVx+FGMCkYnd1ziNPZ9zTv+zjyzIc5HGVEKRaROfuKNQ472X
         3tzLn3QZZGacSkXQMESX5qCI37g2kQLKvufR2oIDgTmNfGPHI4w5518czHEu3afawyB3
         8c5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776740315; x=1777345115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8sfVF5aPV6fheRm7xIg/4vXl2F2m+SYWiTCmFqi/mA=;
        b=keU7vZB9QkVikcPBHfQ6BzuMv6N1xFj7fr57g0D3V2A0sAck0oULG8AERJHsX/9Agw
         8o6dmn5kaqg4bpEyNsMSuCRWtrkYGQydNECJdKrUK6j4IcACEK0Yy16ePipb3s22JbEh
         6yk6jEAPl5MQ4QSUwUBSG6S/riiSfZ9dLX2C+kMQKzATcUTYzZnDCin4BPAV5n2N8Pyp
         SPO3zEEWBUmJ11SVjUGT/bvN8vQWOxJBcfaJLCk8Ms8NiHxAq7Q4hCX9l6I01HjnmBn7
         fuOojtzQElxIkIFlWemVCgQb/siD/GYn0My6NITP+6A9nlZy3HBOQBir02/8Uy3ADURn
         AmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776740315; x=1777345115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P8sfVF5aPV6fheRm7xIg/4vXl2F2m+SYWiTCmFqi/mA=;
        b=RiK7WyhYHE5BQ3m52Sj58EwwzWYUYqU/6uKC1D88Lu22qaCjLs8JkeSowJHi1mtUS2
         hQ704a0ncriTpsdeh1UHl1fLAIbP9ICRNVsckaebmvasYAp+RaCVycWW9C48lDcdJORh
         AsKD1fjdeV1Bc5y6e16TAncAEQ1Aw4wrx80MZfx/PBr6+ywQ5zh2H8QW3+seZyRMbfBD
         lg1MrVE7/8FllO6j6VTnp8HsqAXJLP77cJ3FcNYApoAG9Rn4LYqk5aZrZKxwJrAjdKje
         m8tzpnRfFTgOF6tXLFxgzPegWKoIh/eCc3UHZ7EYMyqS1tUyKYeZ5OsXlvHpFXI03NYt
         0UJA==
X-Gm-Message-State: AOJu0YzrS8g/6ThNMbHahyQJ/uAwUx3P5wCWxdGP5H9xtRdwWVHE983w
	YnFhQje1LEHCSuuFUvTopBA4wdiFPCNqmmgkcu3YSbydNN9su3+AzS47+X62DJ0ZLEpfbJxjRsT
	YAVhF4jf7ftWtyd0sY+2ozedNynlyiKo=
X-Gm-Gg: AeBDievXPpnjwPNFB0/2MrhV8iwitMdN45AKL3wf+d9YdxouEb3l+V2izHm30YAYlGg
	aAKbUrXcNNdmH9RJRasvwZZsdwB3TPouuS6Y7KGEk3a2napW5cvE2hXcvRMdXDK5EhSQj5UC2Wt
	rTeF238cQa08oJorJOH2ZdTSR+9evJ/QQA4bbQhGevJqLoHpCRY60/p8opY3pMz8Qiz6URqoQyJ
	EO1+FfGt7QnBVHsPFUK8StRgQZGbmbw+JAsaN1Wfjf2arCewHIIh+1HP1XL5e713lj5tKi68JFG
	5QMemCQ4ACADVJQYf03iz5AdI67JYjIuwXJH6KRZ8fkO+Rp5hsbHau6+LOGK6u8X878im4uuels
	mZadUmvhLnIhc5eG+H18kjMqMeCieN11KzWGf
X-Received: by 2002:a05:6000:184d:b0:43c:ef4f:79e4 with SMTP id
 ffacd0b85a97d-43fe3dfd36fmr23883572f8f.37.1776740315197; Mon, 20 Apr 2026
 19:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420153603.4097618-1-puranjay@kernel.org> <20260420153603.4097618-3-puranjay@kernel.org>
In-Reply-To: <20260420153603.4097618-3-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Apr 2026 19:58:23 -0700
X-Gm-Features: AQROBzCFO23TG2U4gu5nFV1RJmSaVXGhq8AqzBuE83zRbtjTmMjwmjL6kTxPejU
Message-ID: <CAADnVQJ_D6XyvMHPr59dxZSgFY3+6UayhcWrDC-U2k-Epv-9eA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf, arm64: Add JIT support for stack arguments
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 8:36=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>

nice and clean. I like how it maps to arm64 calling convention.

> +       if (prog->aux->stack_arg_depth > prog->aux->incoming_stack_arg_de=
pth) {
> +               u16 outgoing =3D prog->aux->stack_arg_depth - prog->aux->=
incoming_stack_arg_depth;
> +               int nr_on_stack =3D outgoing / sizeof(u64) - NR_STACK_ARG=
_REGS;
> +
> +               if (nr_on_stack > 0)
> +                       ctx.stack_arg_size =3D round_up(nr_on_stack * siz=
eof(u64), 16);
> +       }

I'm struggling to understand this part.
Why do this when this func calls more than what callee passed in?
Looks fishy. I'd like to see selftests with more than 6,7,8 args.
Because only then this logic will kick in?
