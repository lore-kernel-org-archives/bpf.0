Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B13DBD70
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745005; cv=pass; b=He2vHn4msW2lX9RPHgMn2jySttUZ4acr5bMD5o9RHHdEh86WLoPhqmzIoK6Pk64PdWOnj5D6xuOpdrdTK2AE+3S0HNR1bQ1SP76/XUPan3upvmnOppmy76mxc5xpLF9vMpMZSwEsiVy0dDI+rTPZvdAmXmThIh3OMaUlJjuenIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745005; c=relaxed/simple;
	bh=aiz98qC5uuUB98pxDGSrJs8vIwp/65s1qr19/1CjLTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFpvkuxIpQSIe95pfoA1YqRA9VyH8OLWeBLy2Ve5ZCFK1rM0FyJYCCIR9e0ySliFf6KtTrW0NNep2JdVgPff90D6F75/jVB9pLdm2XoIH+xMZZ3Sh7msa+diuO2G2Uob9Qat3HfU7GbCSik0Jfi+QHA1ddzegck9mMWH0Lb35ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+6sNB4o; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+6sNB4o"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso601921f8f.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 07:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775745001; cv=none;
        d=google.com; s=arc-20240605;
        b=Btefqn6gaaIKDNA/T8+/kEJrUyn6BswB6nyCGJEoMd51krMfVBxXaIwEb38h0baPyj
         TECEWMDsAuXix62BG44xYzn+ua6wz85f6U7VJkIGI4nsWwKcP6HkTLa9ILqIWYc8bmPy
         aE9m9Yr+kqIunPDY/k5SUxcJQbrSv8SHPncJQNySjGJA0NrivKuLz3j6JLimo3eUJHAH
         COu2dDtRzBLapBbpYnl59Gu58WFQe3FQ+vYnaJ8jDvl+37vEOUpTR+Wc7Zj9kWdUnaL6
         3UmnLbi5k7zcewSwQuYG0ZFQkcZbaDjpbKnLYQngL5ThhpXcuuzeUMyuOm7rxElKNHbQ
         y1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j2B9qE/aSznRzr95piluDzuDSrf64tY/r70hHnVKdTQ=;
        fh=xW1zDAVckaMwIZZzoIm96NMKgedzyVxgemogX/d458I=;
        b=YzWcNuqkMN9sf0ZN1qaYOcdGoc5E1j0LzzLObTj740nxpi7VJz4k/WbH84Yk/2kTVs
         /FUvIJuXD/vgMgUDRKFe5zTJGOAosofe+4nBoosT2gFjAjAlQYCAUhQr7JvjZCDCHLJf
         UPZICvRunKf+Xm5Vns1ZSA6QsZHhTqV5w5QYzyNQ5LvondGvP7EGgMGpVIeJdDE/KsHe
         MVw++SPoHVNvRytMmn/Fjsyl2IEiFbUJgMUcWPaXWVj7kJ6hsM6Va6PfK3ayXZhSY+un
         7ZewLu5FqK+XJvUDinKB86N7qMsaKTUNHON2sfDGT4N93apn5EZAvzULkZDZMZLBqc+v
         peVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775745001; x=1776349801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2B9qE/aSznRzr95piluDzuDSrf64tY/r70hHnVKdTQ=;
        b=R+6sNB4oNQPK9IWW0WP6NZ7e8XKcqazpLb3HQLzI979uJShdR1bjPiXVh+GiQwdAfi
         7qIwrp9BWtIu2WMvND9WRKEEnUdC+ulFYCeuEh4laRTdvrHkesN7dV+wlCUOXfbjpEeE
         DBNnjiN3Z3CLR8lsh5+8GXW4GYAvc/vsumJbCNVANiGJI9lDhraIDa9f9h2Ckpd7QnrB
         PREjGjBWYHTT3k5OEyD/jCciY8Ko7DECj0E8Ve2r3CeyY/B31gVqMn637CGnjvpJPrjF
         qnvRUUyy96BEmnhfYozGX7NLCf9bGfxR+NYR+YuziVmRnAZCgnadA6TEnjYUvnAlP/OM
         epqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775745001; x=1776349801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j2B9qE/aSznRzr95piluDzuDSrf64tY/r70hHnVKdTQ=;
        b=hqK0iYE7QPYIAke/r6Do/klw8x388r4Lrtzw2TZKLyFqJewLoZUoEdE7i65oNpeawq
         x4WxX3lRMAlG7uWcma5SamJp8NFtsTEiE4cfQVOUtq0Ae8NhCR4mb1DYHOGnJpifWv6j
         kbQc6HFyvdhaezHbG8vFRc45TvfS2/X0oOqLuBuEznNUXF7BWSysLVBAp5mPcDOHaaQE
         pJEpdOdeS/DMOXiez3AyuBp7AMXWvwA4WqjdYrgJUIkmA7l4ozwxoAXOEm9qvsatF0q4
         HMnBcSzEcfn7O6wA/KkGzIaEAJEeOidd9aV/dDsYmXBDqwFfMlrB3Zd9DaScb/J1LfVc
         SMUg==
X-Forwarded-Encrypted: i=1; AJvYcCXCJfDxdHFgyYnIkRvTn7cZjKfGNSLHu1hLmyt4sEJjj3/HSWTpXnmqLe3TL7RSFmyMZQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkYJB1BstHyJ78UygF1uPy9GC085DCSaXTK7awFjBIhmHk+ZxD
	7A7vxlxDOU9bTORZPWrkVkzZ+KHWtgSuMxztVP1QAexTSxx1ZkkqjX/Sef//b6algX11w61buiO
	n4CyFICQtFPQRwhqDHBwTHq8Aff5M/Bs=
X-Gm-Gg: AeBDietFYdX9HnXiW/ju62yQZCrfy3yANlPGnsL0mnXUuiUT/Xj8/aSi3JAS3qKYcxv
	y7M5cp/oHf0GC+lgdNhcDHoCUDKfdd6FeU2Kyg0c9TSECCezkpK33Ut3gZsaaDhUthdxW4Pi5tA
	rR09lqPnwTKSM5oFXqY8ufDUEt3st04D7PnTkA7LZZK8H+3TAS3ugpMth6GdHMI+NEgZDGoXEuL
	T/f01P7oGYMZDFbqCPLIsl5ueHx35tGz3cZsGkCdeSpsikoMHscRwC3L6xzRCu4taBnVBIW8nnW
	gFJ6aph/EL/QhpgoQJ/SAiYl+KNsCo90uhhsAbHGa1lhx+5L2oKNrAKCCdMDSQL/0gMx0xWDUTm
	kOX2iq1ODPaHODYr6b8xNI2ahAQ==
X-Received: by 2002:a5d:5c84:0:b0:43a:16d8:96e8 with SMTP id
 ffacd0b85a97d-43d5a089c3amr5137406f8f.0.1775745000893; Thu, 09 Apr 2026
 07:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406224953.2787289-1-werner@verivus.com> <20260409061026.3926858-1-werner@verivus.com>
In-Reply-To: <20260409061026.3926858-1-werner@verivus.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Apr 2026 07:29:48 -0700
X-Gm-Features: AQROBzA77CgnGz0GMfcb6aUuD-xSsenSGs755KZkihl8giw17FumU7yK1I768zo
Message-ID: <CAADnVQK0Toai=KZ3BggnR33DK20Oks1VcjphueRShCWuyuh3pA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: guard sock_ops rtt_min access with is_locked_tcp_sock
To: Werner Kasselman <werner@verivus.ai>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 11:10=E2=80=AFPM Werner Kasselman <werner@verivus.ai=
> wrote:
>
> sock_ops_convert_ctx_access() emits guarded reads for tcp_sock-backed
> bpf_sock_ops fields such as snd_cwnd, srtt_us, snd_ssthresh, rcv_nxt,
> snd_nxt, snd_una, mss_cache, ecn_flags, rate_delivered, and
> rate_interval_us. Those accesses go through SOCK_OPS_GET_TCP_SOCK_FIELD()=
,
> which checks is_locked_tcp_sock before dereferencing sock_ops.sk.
>
> The rtt_min case is different. Because it reads a subfield of
> struct minmax, it uses a custom open-coded load sequence instead of the
> usual helper macro, and that sequence currently dereferences sock_ops.sk
> without checking is_locked_tcp_sock first.
>
> This is unsafe when sock_ops.sk points to a request_sock-backed object
> instead of a locked full tcp_sock. That is reachable not only from the
> SYNACK header option callbacks, but also from other request_sock-backed
> sock_ops callbacks such as BPF_SOCK_OPS_TIMEOUT_INIT,
> BPF_SOCK_OPS_RWND_INIT, and BPF_SOCK_OPS_NEEDS_ECN. In those cases,
> reading ctx->rtt_min makes the generated code treat a request_sock as a
> tcp_sock and read beyond the end of the request_sock allocation.
>
> Fix the rtt_min conversion by adding the same is_locked_tcp_sock guard
> used for the other tcp_sock field reads. Also make the accessed subfield
> explicit by using offsetof(struct minmax_sample, v).
>
> Add a selftest that verifies request_sock-backed sock_ops callbacks see
> ctx->rtt_min as zero after the fix.
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
>  net/core/filter.c                             | 53 +++++++++++++++----
>  .../selftests/bpf/prog_tests/tcpbpf_user.c    |  9 ++++
>  .../selftests/bpf/progs/test_tcpbpf_kern.c    | 21 ++++++++
>  tools/testing/selftests/bpf/test_tcpbpf.h     |  6 +++
>  4 files changed, 79 insertions(+), 10 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158..5040bf7e4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10827,16 +10827,49 @@ static u32 sock_ops_convert_ctx_access(enum bpf=
_access_type type,
>         case offsetof(struct bpf_sock_ops, rtt_min):
>                 BUILD_BUG_ON(sizeof_field(struct tcp_sock, rtt_min) !=3D
>                              sizeof(struct minmax));
> -               BUILD_BUG_ON(sizeof(struct minmax) <
> -                            sizeof(struct minmax_sample));
> -
> -               *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> -                                               struct bpf_sock_ops_kern,=
 sk),
> -                                     si->dst_reg, si->src_reg,
> -                                     offsetof(struct bpf_sock_ops_kern, =
sk));
> -               *insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
> -                                     offsetof(struct tcp_sock, rtt_min) =
+
> -                                     sizeof_field(struct minmax_sample, =
t));
> +               BUILD_BUG_ON(sizeof_field(struct bpf_sock_ops, rtt_min) !=
=3D
> +                            sizeof_field(struct minmax_sample, v));
> +               off =3D offsetof(struct tcp_sock, rtt_min) +
> +                     offsetof(struct minmax_sample, v);
> +
> +               {
> +                       int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG=
_9, jmp =3D 2;
> +

please de-claude your patches before posting.

pw-bot: cr
