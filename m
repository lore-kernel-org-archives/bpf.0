Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BAF366DA5
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527773; cv=pass; b=RXkGArgYNY0kBxqri/S694xJWsz6p90hZVVQxczKf/BbRODs9+zHEkEF+O5sFijktwsRCVy787d6LAwUmhJ+ONxtOWwy4xW953+dh6ZupIoPAzlfDld39yWI8n/ICJoIK0OlIzZx226lAWgEYs8pbHjma8e9qFeFJZrs+jvTDt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527773; c=relaxed/simple;
	bh=1AqsvOqNRMqwYQ/YcVOH8zeiA01xGEtXh7OJ1cLbSws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhMeH9wM3QvdkQGJ4DtxVREBCFx5Uuzp6BJ+k2ommJ4vFGkNR9EWmXZ3YYc7LB7InnCHlZcHRXCBDOmNrZCvGt65I2HrCLWsActhG5/4qUTssXdLDwDQPpLXrryrJGUSjIrw6d10fQq/Cziz82Dvut+vQH1lp8zqW0S39HlUJH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cVhyXp60; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVhyXp60"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5062fc5d86aso49584071cf.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 00:49:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772527771; cv=none;
        d=google.com; s=arc-20240605;
        b=aJMiSACcPkv8NhSLYDmkG5jD/qR5INh+nUvmuxVJlxzJFiZm4BkFWvDvz5ghBrP+ZY
         LmBHj8RFtlFXt0KCQkPi2SiXXmiAGtKTaIYVCPmxsxmvGQmU6EuXzkpESIANlKpYhKNG
         mSYn2QI06qI7ukPdZvRTCxLYxmgS9UMYuokVYOYdjIHgqiIFcxHHsb41zlbx5JTwkMkn
         uQnbJlj/FoN4dF891fv9vwC3nqNf8j2O+5eVFVKZhx+IXZai/wnWL6S8YNRHk55Kec3b
         T8ows70puAbTImH1Z1EgaxtJCQSIh83/KRnd5xHQPQTgaFKCdEMLS6LXZIwtrmZExGxe
         erCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qJFJxH+8x5vYr/jSCBou90e7JFINIUv2cUf96EZsYn4=;
        fh=NW42s1sZobISdyPs7UHniRa76ULVNintyQv26r+3pl8=;
        b=SdPfh6asJA37F0COUOF3NjsmzSviXWyoax46b81tskqNvVBDnA9Xb88w0Dx2YtqIaV
         /AQJP+5cdWgpNZ3hih4tWU/IKWpYjvDqd1ImwMGy1UrUTntZYN9Awrq7gHjSepDYRFh3
         m500bJaO3J3bGRQNjknMYU4WYFiwgq+ij/rU6I4ZENbEqNyg11yz5UM9AuCaRfa1qIB+
         CQtMbVVbvQw126W0CmqFu6eTuhjDmYaWszAub12Btsyn9rd6imH5lt/JhnO7dcrttdKA
         aqCkwbDiK1A0Bxq/upA2DIEiPZyhrhGB2T73PNEej8HxgDlrBe9iOIfIuJL32cEzZ34z
         EkjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772527771; x=1773132571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJFJxH+8x5vYr/jSCBou90e7JFINIUv2cUf96EZsYn4=;
        b=cVhyXp60zciM3AXflHDLPp5eARWYeqG6qfcTnMN6iWAHrkP8SPZjHXCG8vFLqr/0lj
         JHkB1QoDg2tHtKrOLght+nEuZedjq6mPq5CextF/86opO+U9IGD0/93MC9IxoBj+btan
         ZkX5M454fxFPTCCITQSVskfeOTbUb8xsYFduqAmeHGQ1j1wjPwTKauhWW+VGVFaVZ2iH
         NRiaCEuI1TRZ2Jco1zkSEtG6sRVhlu5IbPSOrpjlpRhJfePNJEbVWSFg/7t+3hvK97Qb
         rgiOPEqnfDqbxIFpdtUEd+Lmze/GJfxa9gF2EObU3pMnOcijOFPEYyjWZDMFn81fL2Mn
         T1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772527771; x=1773132571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJFJxH+8x5vYr/jSCBou90e7JFINIUv2cUf96EZsYn4=;
        b=EJUFfd/GmU5/VDw+3XGjbdMHcogJ2xh7t/QF1i/N6dx2nnpM5I+fWd2t33JE8z4JPr
         A2H/zfJPKAw3y9MYjOcddrrFiKI/xCfWFRQvz50SQX4b5KQYtMCatnGcVAudrZbFAYDC
         4sKb5QNkubuVMhvYbpYOQ3HejU80BHNY/EOCqX0uH97vDRaibU2ACeF8bnetp53vyM9s
         C/lJjFZ3txJcpunky07X0dWLmjNG6Pmn50VkVLxRIWZ5iKmJ6FGDMIz6vfT7kjpOPcc5
         Aio/UfhMfZgzMVQ1SOgyJr9qe2/13wBMRnY5lF7S6+cCK8X+5Lpt3f3fbJTwUvF89CyM
         ahBA==
X-Forwarded-Encrypted: i=1; AJvYcCWqqenLLEtCoUF5t+heThOl1yPSQX4Js/BNts4+XtmfJWKMx7IkzgAnZNtc5NB0E8vqY44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo22KTBvGFa5zc9UvlQMp86/BCcj52TDc5H5YynsFUbbB5xpXw
	ywyYzVrwdkdE8eoNtrIFOsMP5KlW84saiHmGl3n/aWyuCMHaRNt5FVBmUe+e5pcoHCfxqFKP5Zn
	E4M/YBcG/aTx5NpNwtQLVzHA0vZqticLV31Rhoxl9
X-Gm-Gg: ATEYQzzNIeMjGdhRRwdNrX0u3lAJi1IfGnDLpbv0qhOxREqHHWkxVrQoQxf7unszXN0
	AOWXwX2qQ5kxH+8lvS0bhi8sSS5pkm/Cb9EmGUPeKduyVTWwNv5Dauf9iFeD1ZNfXhoyntw2pV8
	rlxFKN9NSLoixUBIELftCxoSY2UMu8lCZBCQiriWkZSABsZI8blDsmHf/eNAIKi2LMsWA12jWB3
	rzg43ClxQAnn6RXSiXObLc/BIb1jmwbzezR0SSFB9sGXg6qOZJjQZJijOIyeyplc50A6b29Y2Xw
	h5V9tgw=
X-Received: by 2002:a05:622a:1a9f:b0:501:45c5:935e with SMTP id
 d75a77b69052e-507526b46f9mr182579481cf.7.1772527770566; Tue, 03 Mar 2026
 00:49:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303074847.2814835-1-kmta1236@gmail.com>
In-Reply-To: <20260303074847.2814835-1-kmta1236@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Mar 2026 09:49:19 +0100
X-Gm-Features: AaiRm53vlNvYGd57BJCoo0f6cwXNmR2U51OBhyb8mBCxLXDtUTevNoI3OdqqTzk
Message-ID: <CANn89i+10Jz0BpOPdajdLccfBz5UNq9ay7qcXS0LwDaU-07ozQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: replace per-packet memset in __tcp_transmit_skb()
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 8:49=E2=80=AFAM Keita Morisaki <kmta1236@gmail.com> =
wrote:
>
> Replace memset(&opts, 0, sizeof(opts)) with targeted initialization of
> only the three fields read unconditionally by tcp_options_write() and
> bpf_skops_write_hdr_opt(): mss, num_sack_blocks, and bpf_opt_len.
>
> struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> CONFIG_MPTCP=3Dy (typical distro config). Every remaining field is either
> assigned before first use by tcp_established_options()/tcp_syn_options(),
> or gated behind its OPTION_* flag in tcp_options_write(). This memset
> runs on every transmitted TCP packet, so removing it reduces per-packet
> overhead on the hot path.
>
> Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=3Dn):
>
>   Before: 5 store instructions zeroing 40 bytes
>   After:  3 store instructions zeroing 4 bytes
>
> With CONFIG_MPTCP=3Dy the savings are larger: 12 stores (96 bytes) become
> 3 stores (4 bytes).
>
> A BUILD_BUG_ON guards against future field additions: if the struct size
> changes, the assertion fires and forces the developer to audit whether
> the new field needs explicit zeroing.
>
> Also add opts->options =3D 0 at the top of tcp_syn_options(), which
> already used |=3D without a prior clear. tcp_established_options() alread=
y
> clears opts->options at its top.
>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
> ---
>  net/ipv4/tcp_output.c | 16 ++++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 326b58ff1118d..ae04c697dbacc 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -965,6 +965,8 @@ static unsigned int tcp_syn_options(struct sock *sk, =
struct sk_buff *skb,
>         struct tcp_fastopen_request *fastopen =3D tp->fastopen_req;
>         bool timestamps;
>
> +       opts->options =3D 0;
> +
>         /* Better than switch (key.type) as it has static branches */
>         if (tcp_key_is_md5(key)) {
>                 timestamps =3D false;
> @@ -1549,7 +1551,20 @@ static int __tcp_transmit_skb(struct sock *sk, str=
uct sk_buff *skb,
>
>         inet =3D inet_sk(sk);
>         tcb =3D TCP_SKB_CB(skb);
> -       memset(&opts, 0, sizeof(opts));
> +       /* Only zero fields read unconditionally by tcp_options_write()
> +        * or bpf_skops_write_hdr_opt(). Other fields are set by
> +        * tcp_established_options()/tcp_syn_options() before use, or
> +        * gated behind their OPTION_* flag.
> +        *
> +        * If you add a field to tcp_out_options, this will fire =E2=80=
=94
> +        * audit whether the new field needs zeroing here.
> +        */
> +       BUILD_BUG_ON(sizeof(opts) !=3D
> +                    sizeof(struct mptcp_out_options) + 40);
> +       opts.mss =3D 0;
> +       opts.num_sack_blocks =3D 0;
> +       opts.bpf_opt_len =3D 0;
>
>         tcp_get_current_key(sk, &key);
>         if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
>

Interesting idea, but the implementation is a bit fragile.

I would instead add a group in struct tcp_out_options to clearly mark
which group is zeroed in  __tcp_transmit_skb().

Partial patch to give the idea :

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 46bd48cf776a6a37e6ab2664245cd1e35a88d4f8..b96168f50170b7359d26de23891=
28bc80d4d549e
100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -429,14 +429,19 @@ static void smc_options_write(__be32 *ptr, u16 *optio=
ns)
 }

 struct tcp_out_options {
+       /* Following group is cleared in __tcp_transmit_skb() */
+       struct_group(cleared,
+               u16 mss;                /* 0 to disable */
+               u8 bpf_opt_len;         /* length of BPF hdr option */
+               u8 num_sack_blocks;     /* number of SACK blocks to include=
 */
+       );
+
+       /* Caution : Following fields are not cleared in
__tcp_transmit_skb(). */
        u16 options;            /* bit field of OPTION_* */
-       u16 mss;                /* 0 to disable */
        u8 ws;                  /* window scale, 0 to disable */
-       u8 num_sack_blocks;     /* number of SACK blocks to include */
        u8 num_accecn_fields:7, /* number of AccECN fields needed */
           use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
        u8 hash_size;           /* bytes in hash_location */
-       u8 bpf_opt_len;         /* length of BPF hdr option */
        __u8 *hash_location;    /* temporary pointer, overloaded */
        __u32 tsval, tsecr;     /* need to include OPTION_TS */
        struct tcp_fastopen_cookie *fastopen_cookie;    /* Fast open cookie=
 */
@@ -1565,7 +1570,7 @@ static int __tcp_transmit_skb(struct sock *sk,
struct sk_buff *skb,

        inet =3D inet_sk(sk);
        tcb =3D TCP_SKB_CB(skb);
-       memset(&opts, 0, sizeof(opts));
+       memset(&opts.cleared, 0, sizeof(opts.cleared));

        tcp_get_current_key(sk, &key);
        if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
