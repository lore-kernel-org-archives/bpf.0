Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98DB3DD521
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476907; cv=none; b=AQBwUQuCeElK5iaXTr4bmJXou0Icmq31snHZQVsVCj8dSVLwCxvQ3NS7hMh/W7nM2vHEEIEPWr2FaVlg9QTvKN8ZxN2DdhRUeQ11hAD5OPF0s7OEgRaP0jQJ95bXJ2Z1gVVcvpgXVyW4D216eWlhGUi/OgZctnv6we+KWJ3qrUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476907; c=relaxed/simple;
	bh=GyXCZOMZY36czZUTJbxoPimmLReGwOp0Wi43tTz2Q1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9JHCaWiqG8aMtd65fTU23nCEJ6LAvjmi429hPgTFPHPd1yW+Sgf9ayzRXyUH3kXJAiXNcoQ58NuRCPHzRi+HukFm/di0MhsVAJiPRotjWTAtkQeqK7H5v+S6vrOJbmS2UBEHn09QCPu1HvIlTSQew+nB+VzioHId+RPiCM3Ew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9NqJucB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9NqJucB"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso324241a91.2
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786476905; x=1787081705; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ulX7H6DhYLFNmjqa6AwJBS/POo41hZkJfTIC1HYM0Zg=;
        b=V9NqJucBGdMNumxvZk1Atc/cSK7Ep3Tk9hTiyyvwHQb8vPSGIqf8FH5efLZAkjgW6F
         Jl6xyfMh4jUHNrdd29bMjeHU5Tm85vN0NtA/XmjXRHwnS5MQPhG+QTlwcjvpjJmd8MxE
         FC6yWP2xex9Ixhaw5Hxh9MZ1aOdildaX+1sqwzr2BT47bvjw8Kqrhq62GTR9dZ5UCUTJ
         srWMUsuC0m7qIGiERMGWZmqyyDxNqb9ixFQDKkQw+xptriG0eqz0P+IynES/oTdt8l0T
         SC8x8BbzcjgPCvdZ1HWAAZnY0COOXNY6TS1Dbd35bnrbjB0NTY+V7EJny6+e4TxJwYDj
         f1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786476905; x=1787081705;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ulX7H6DhYLFNmjqa6AwJBS/POo41hZkJfTIC1HYM0Zg=;
        b=Q8eOJqOzKlOmA/KZPuwFfRJMLWGXehmCkPVE3kvNWYOTi3o77TP0b6l7gN7rEbkiv1
         eX4E+a2GKHb6xDrqnTI9Z0V71VL4mC1VKI/HPd9m+cljOxyLHTDAt8fw1Liz6XzY5ONC
         YJRPU51YZ8wCKI8RRfrzsfts+dyqJIIaEDT22Vq0i1ZEmRXUTnLVovDzazrSTRvI2Gpg
         ixBBCGTnszGDVVDI+kjzQYhK6kmA9bvaGU3ApEwT6Qt31uz5Zg4f34qXVhQUMWpuUxtt
         +98lWx7iyPFaS2SrG//TloK7eashZjTwC9Vzr+6F3+fmFS23tep+L0wlQQGVvgHZ7iwj
         rWmw==
X-Forwarded-Encrypted: i=1; AHgh+Rqv/mhY8FENP4evcqU6OMg/Gg/oSNC0CH+Ko1fNjhiwdAwurqM6IttzfSUEGDAV1I8li8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfQS9qhXsJzTLh7gmCR25NQ6Es2e6wSalfdOTlWYG4OvJKqaa
	47A6NVzAkZHpjLaKGnJY2/lJS1nwNvckkg3CnkdDgVwTZiVPphvyBjgY
X-Gm-Gg: AR+sD133BYTWTzwGMBx899rMyYOMPbBdZknOSkleM8T1vnshOps1smHJ58xILJEL2KY
	Tlv/JvaUGU9A37C7CrEBitlafRkMpfAapVv0tF1WLp4OD8cWkUiDRgdkmSRrImRYcew3AUg0DeJ
	V2YJMNcwT6JWFB1g9OJs8tks0P6px2A8zq/NrzGCgxR9PFWXFWXEXxoT5MPOhORAk4N9dYUyJuB
	LXIF3AG8o8+K8VbIioM372zwiWgQxte54wAtNQxv9hXTxQp+nb1PDgOgECcBUTBl3T0YsgietAc
	I2OQ6yIvXkW5mD3xNMCj/cNN7na87dCYoW4K/RFcH0V0U9U+Tg5BdHoxN4jppVoefj/W8wfGmih
	ssIuBUXhCL7VnMjofrVedzTY/WG1CzZ5ZbQmERFp51EhsuTdzv8Pv9nt5d3mYHv+MesddWs9mLA
	krBJK6Cb3GPRdJosaA9cOHofr1PRvnUN0e8O2wzk2raSt9387QVpW/fYol44AmE5woAQILdwLF6
	ITwlqavPr9o60gCrlXtsW8MbyikYOrXOQXvMoVJTH4fgw==
X-Received: by 2002:a17:90b:5105:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-392ec60dab4mr7207571a91.13.1786476905022;
        Tue, 11 Aug 2026 12:35:05 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cd18:dfe8:e39c:4123? ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141245540fesm3116697c88.9.2026.08.11.12.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:35:04 -0700 (PDT)
Message-ID: <0acc9bbb617d931401fd5a6300513a23cac956d4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 1/6] bpf: Track verifier instruction stats
 for each subprogram
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 11 Aug 2026 12:35:03 -0700
In-Reply-To: <20260808062601.1070988-2-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
	 <20260808062601.1070988-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-08 at 08:25 +0200, Kumar Kartikeya Dwivedi wrote:
> The verifier currently records one instruction count for the main program
> and each global subprogram checked independently. Static subprograms are
> explored within callers, so their verification cost cannot be reported
> separately.
>=20
> Track both self and inclusive instruction counts for every subprogram.
> Charge each processed instruction as self work to the current subprogram =
and
> to a path-local subtotal in its function frame. When a function returns, =
add
> the callee subtotal to its inclusive count and to its parent subtotal. Fo=
ld
> any remaining frames when a path terminates or is pruned.
>=20
> Instruction subtotals are accounting state, not semantic verifier state.
> Clear them when a verifier state is copied so work before a path fork is
> charged once, rather than again when a saved branch is explored. If copyi=
ng
> a saved state fails before all frames are allocated, skip missing frames
> while folding the current path.
>=20
> This generic frame accounting also records self and inclusive totals when=
 an
> asynchronous callback starts as a fresh frame-zero state. It does not yet
> charge that independently explored callback path back to the main or glob=
al
> exploration root which scheduled it. That will be done in subsequent
> changes.
>=20
> This does not change the verification statistics output format. It only
> prepares the counters for per-subprogram reporting.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  include/linux/bpf_verifier.h |  5 +++-
>  kernel/bpf/verifier.c        | 55 ++++++++++++++++++++++++++++++------
>  2 files changed, 50 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index a2a40caca0a0..f16ee6602179 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -385,6 +385,8 @@ struct bpf_func_state {
>  	 *                           | number of simulations is tracked in fram=
e N
>  	 */
>  	u32 callback_depth;
> +	/* Instructions processed in this frame and callees on the current path=
. */
> +	u32 insns_subtotal;

Another possibility is to have the array of counters in the
bpf_verifier_env itself. But I don't want to push for another respin.

>  	/* The following fields should be last. See copy_func_state() */
>  	/* The state of the stack. Each element of the array describes BPF_REG_=
SIZE

...
