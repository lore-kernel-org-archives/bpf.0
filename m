Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05534CA260
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193653; cv=pass; b=jwLZVQWJrF7ivoTYF4wi9XaqmdHmXK/Iux0CmAT0g2T9K2dURmVraSWK0v943jT4UeEIzDoEAgjUD82lpW0CowOvZ1eP3omMw9SoI4zC5r7P3tQqTW8b307kqWBJlfWYbONb1CTpySMGxAf4liHD0bYgfNlln51t52LM+R9Tl/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193653; c=relaxed/simple;
	bh=y1j7Eq9lmZxwVs6xShWbSL5Xng4sr3FjXZzg1MsHkss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLI7jhQ7z5ASzWkpADynj5618rzk2gpALtRV7blYPK7vq5cbEIAZFT6yqeKZerWnCDElrSjvG4l2vUPyTpDEfuJCn+MQ9RV427rROiHQpHqgt7mKonAgqVqHlRrtRy6QdMTs+uncSJ075+2NO2364+ZLXpzeMbB9de+X94Ik3Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2S4GFBu; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2S4GFBu"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-395317d8852so31129031fa.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 05:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779193650; cv=none;
        d=google.com; s=arc-20240605;
        b=TpNJKhhVbbPH6QRF5h9DK9fssNjHU/4tGhDmL2nAhBzgX/EqM2Dcu8BwmFZd7yHEsU
         TTpx+MR9E3gsaKu7w5aR07KpV54urbkPGiBGgBpeytkuaxEwAHToWU/JQvIXCskdwPSQ
         ZrW4g5IRJ+kBEQ5GAnGfd7oQAejrXNFup1TQWm9XjrT4EMpXhRpiTTgB7eMrPc4qJ7Zn
         1RyqcnV/J0Ibl/R6f5oSt6h2OQFk3roszVVbCvvVoneb5bokTdbt5DzgkpeCEHG9tVn/
         swhTntx2cddWRxWGxIyx3j7FjDs3ryf7oBr6rEbjgPA+RTXdUSJlRCR9YtXrLtkrfhgK
         d75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LCs1qpXwTXyCOYCDlieFw6GpLdqpYpgZgXSKHKgLEss=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=cn2OPZIqObFkGvLWKVw5rWJ3jwwlvOoXiiKqy3jwItJW8LsTEzY1TFn6UF404GMJBt
         EXA5jTx4QAshrEiA+z1BNUfrw4SPa0dxhp2El281zWpEE1LR8M6X9qazFLT6IAzVoB0+
         VtaIDlQKk2dEMdWE2d63yYQk7R0vTz6at/5MEWyjITCO9VGXyMGKQRso/f/8bY1XaBNr
         LPk+hlausAEpNIbHPr5fhyyL0lxdapvBAn+LhIithsO7eJBhldf6yoDVqPjCRS06PE1S
         lEqDd7iHzkeKnwnaq9Hx9hRxbixjXFvkHiqkVRPRDKzbFWjT9hMfRi9ghd75YnJrWyD7
         2PpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779193650; x=1779798450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCs1qpXwTXyCOYCDlieFw6GpLdqpYpgZgXSKHKgLEss=;
        b=i2S4GFBui0EgUf3viXHSxJy6+3KdM5uuzaT15MXyej/pPT8zi6DCBqAo1gzKPGId9r
         tAG7ZBJW1oUUyvPQzcI2cQlSfj1zSD4MVvNLjZe3zoOvIYX+3EWElRMCn0J1xyJLAlIm
         27gV1sYCFOYRl5Ep5W5l69ZGc3WR6zA6AgGTFrdofCza9SbGqov+a+2QtZZe4L9HZfUE
         IsEArfN3JvSNfL57K/0fD0Sk1sW/nCM/0wa4WtqEop6UsrmQvP/IEFW0l+qpsRkUxjsT
         K2g86V4uq989VTkwhUELnbCsxujMb9Nqog1gHfDB1E23Ic+c90f2Ba5D9My56aV6fOMp
         qAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779193650; x=1779798450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LCs1qpXwTXyCOYCDlieFw6GpLdqpYpgZgXSKHKgLEss=;
        b=Z27Zf1LK0Zl4Lzu1/dZhwq9mOyJe5dvI4oqfxxcMGu3SYCQBJqbc1j9C8Apw0qLixO
         GSI/SeSi61pTfPikyCXojNCXRTCym4zmqmPx/ExKOn9cll9+fSeky7STrHBKZdf9GGLc
         jdp4XpMNM3akrwrWrGKF4cuAskNrxs0UCe1n/LAtfJOn/IhY0s7guqGBdWgQuYbnjfkd
         R0bOMdDQ8tXhIka1e78ia5JmxcUiXXrIOdRUcaAiwWqcGQh4bmMw7EM2ddm8hh3JjH6F
         8G/dQzTViqCloyIomKXEPBNvGYyNzk0xRyvYm+Y9JZQwVeNiBVmRmcncV4GhR7MND88h
         1SKg==
X-Gm-Message-State: AOJu0YwtXj3LpGxVYmtbh8gaaAsaOK3/dx7/I0YnsRLFDtcJ56TLM0f/
	BNr/S4Ho26oCf+QJvhV2W3T7CuK1EDG8dudYWNfDmeffVaGZT1UyoBpWYihY8h68Ns9754/nMEw
	7RLr555p3jtZrXC/yGbGjBEEB+y9+EBTKod+kwppFgQ==
X-Gm-Gg: Acq92OGiST3lkTDeR2PBVGL7ZyH1PcqfqslVgWXYwnz9ozMMtErwZfZP1S6MDQo3en6
	NjR/uWlywMzvIz4jKxGz8cdybqbZzCnmKf/VEh8qbiH1/JSV5u3S/wAjPpecB7QgpwRE1IqTa3L
	7iBS7PnOsvdr2Vhw2mgo11R4kXtQ31pmtL4mG1y5+oWRjYg3SkLDJ7Pm6NM/vSSlYpfdGJSsPo/
	MBfwQ++2Vbr6OCM9MwhLxY3cD3gAKkCY7IYpFnH4v9KavCxzMY8NXxOJMMZtH9LgGt44KbZzv7F
	Jsbc36BFnwiuFfKTjxRgDR85DsTzmjFzn6+frGTG
X-Received: by 2002:a05:6512:1285:b0:5a4:d44:99f0 with SMTP id
 2adb3069b0e04-5aa0e733f63mr7062600e87.6.1779193649825; Tue, 19 May 2026
 05:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-6-kerneljasonxing@gmail.com> <20260519082514.AD96BC2BCC6@smtp.kernel.org>
In-Reply-To: <20260519082514.AD96BC2BCC6@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 19 May 2026 20:26:52 +0800
X-Gm-Features: AVHnY4LztSDKvv4FGhna3JZkUb_Rg2ODnWdgpjv0ylTPj4N756C-Z86N40V1q78
Message-ID: <CAL+tcoCBQzn5k8PQ53s0kMuBkry2FYvekvJfiNjwM_SoN2rF7A@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 4:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] BPF sock_ops hook is called without holding the socket lock, vio=
lating core locking rules and risking data corruption.
> - [Medium] Missing BPF RX timestamping for zero-copy receive (tcp_zerocop=
y_receive).
> - [Medium] MSG_PEEK causes event duplication, corrupting BPF statistics.
> - [Medium] Data race due to lockless read of sk->sk_bpf_cb_flags.
> --
>
> commit bdfc9a5e79a8f2a8060029cde75cfb38b923754a
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> bpf: enable bpf timestamping rx in TCP layer
>
> This commit introduces BPF RX timestamping for TCP by adding a BPF hook
> to tcp_recvmsg(). It evaluates timestamping flags and conditionally
> calls bpf_skops_rx_timestamping().
>
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 21ece4c716121..64c69bb3578af 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *=
msg, size_t len, int flags)
> >       release_sock(sk);
> >
> >       if ((cmsg_flags | msg->msg_get_inq) && ret >=3D 0) {
> > -             if (cmsg_flags & TCP_CMSG_TS)
> > -                     tcp_recv_timestamp(msg, sk, &tss);
> > +             if (cmsg_flags & TCP_CMSG_TS) {
> > +                     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> > +
> > +                     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > +                         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAM=
PING))
>
> Since the socket lock was released above, is it safe to read
> sk->sk_bpf_cb_flags here without READ_ONCE()? It appears
> bpf_sock_ops_cb_flags_set() could modify this concurrently, potentially
> causing a data race.

Good catch. I'll add the pair then.

>
> > +                             bpf_skops_rx_timestamping(sk, &tss,
> > +                                                       BPF_SOCK_OPS_TS=
TAMP_RCV_CB);
>
> Does executing the BPF_PROG_TYPE_SOCK_OPS program here without holding th=
e
> socket lock risk data races? Since the program receives a full socket
> context and can call helpers like bpf_setsockopt(), this might trigger
> assertions in sock_owned_by_me(sk) or corrupt socket state.

IIUC, we have such protections which are reflected in
bpf_test_access_bpf_calls().

>
> If MSG_PEEK is passed in the flags, will this cause the BPF program to be
> invoked multiple times for the same skb? The callback doesn't seem to
> receive arguments indicating a peek, which might artificially inflate pac=
ket
> counts and skew latency metrics.

This is the pre-existing behavior. Yes, it can happen, but I don't
regard it as a problem.

>
> > +                     if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > +                         tsflags & SOF_TIMESTAMPING_SOFTWARE ||
> > +                         tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
> > +                             tcp_recv_timestamp(msg, sk, &tss);
>
> Will packets processed via the zero-copy receive path miss these RX
> timestamp events? High-performance applications using tcp_zerocopy_receiv=
e()
> go through tcp_zc_finalize_rx_tstamp(), which directly calls
> tcp_recv_timestamp() but seems to omit this new BPF callback.

Agreed. I'll support zc mode as Stan pointed out earlier.

Thanks,
Jason

>
> > +             }
> >               if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
> >                       msg->msg_inq =3D tcp_inq_hint(sk);
> >                       if (cmsg_flags & TCP_CMSG_INQ)
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518082344.96=
647-1-kerneljasonxing@gmail.com?part=3D5
