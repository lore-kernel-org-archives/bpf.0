Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5326CE1E
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177215; cv=pass; b=APlvDEm9v1jStH1QGQ1sbfyqat4UYASX2hceH5wHqVWihNjHTtDd8coBscNGMaxle6N+S8QHWGT6ZDHkCFv4+AGmjC27LTk/Np232UzZxDdkfNO/TIhoPRIR3D4F1/oR9q7+xJPjhrI0+4Z5VIMtxEC/mfZouHPsH9rAk/Pwpz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177215; c=relaxed/simple;
	bh=z+r8cADNJ1goFXqiFxfvrucLp8szq64XSfMHf/m9FPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDmUa4FUfmDdTAjNS4eFjotp7W93yOXg4GWxukTa29JWX51j/xOu5gs9svMcYZTAXNSwQoREaclcwjLI2z1MapMUCqEBTbiT1FiO4Fsi8FBxTvPNuOivUnh5PJ8/RfmlP60rCAOnK8dhqkGqM9SgY8OxvZ8NDJoJ6ChsYuHB5Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1uY4nFb; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1uY4nFb"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d74086e5bso1923452f8f.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 07:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776177212; cv=none;
        d=google.com; s=arc-20240605;
        b=YBVFSpDxsQS1n3Vt1D3PstkG//UZt1Rtdu26HkKaOkVKoAfKJPBJCOazSX/pyjr3Rw
         TcTTZhDzTBwo33ShT2T6OX1py43dXUvwMxXIkRQPplrUdRpyZQqiKvJO6pyHBbWreJqE
         P4uP8BfUQByrtnPbUq0bDqTF19/tYV89Z8eJVjlWbZBdEqjzILBUJjWOu7qoSn6Xo1MK
         wJNh2/1hd2o3btcYiB0dXMkqQSFz6Q2XCNvmTFSTG4Ej+nRRVKXEDaJZR4h9CNXgqXoZ
         n/Wou4KLRCbu+HPpnr4FcOwhjSa15dzYX+EoO9RA/jJFp67flU25Jf7V7iw231UGneY5
         ta1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bw6f7AXQLyB14/caIw5kD86MDDHBEfPYqQSR/5hoL5E=;
        fh=PlmwSG5G4xagTl68cJWNETnfHDDkht7MRDohS7UC6m0=;
        b=Fz+MmQi+Yfxn9jJ2NfAaRPke7RIFpAsNz2efjO+wP80Z/RgsCc5qzVwGUJy4boHtCr
         HIFWEMGcqwg8pDSvw8fWN6jSMryTmB32EiSLvDI+WNl86XmlsuypH+8C53Joz4QOwQFZ
         P9jSPhRcSK9ByAFkkXPa1WlMfw+1CJwTjRH6qCfre998APgYRuXYh0ulvSBw5vrKEoyw
         I33GU+MNNcR+135c0kGvqq93qqPVQDnTc3sS+ArsleaHMzqyKCUxY/NKHIthA+YlDmGl
         GhKpBYf74GqMYkuUhvZh+Q4eNcxX15hplZOg8Nyi4SIHMqC/T5tGWRHZX1lGrxlkC3zI
         qvpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776177212; x=1776782012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw6f7AXQLyB14/caIw5kD86MDDHBEfPYqQSR/5hoL5E=;
        b=m1uY4nFbY48r/Xpf0dgmOPmB9DkzFeJODUf2P/v9awivH5M9bJI+kaZ8lUv2TJJ7w6
         60+c6MD4hliooPY6i0iKklgtYsS6WEt6MJ3Yu0yjgNgK0u2qWZYDGPeu6KzpS+qV9SN0
         Hs1ZIWxifj3I2qEIwWCszVmZ3+WA8yapSNbrCejSe1+OEChdvyzgAk2W0FvskJoFRfKO
         5qbqExof2+YjkvyZ+bZhz43P92nF99wqvr8HT1itd+kbrtU7EkwGkIsT+OnpqUb67aYC
         SoxavYpjJbVYYA09w9m8REuOuwbtlPLHmBQjitN0f1D4QT3yhFjKy7LFHlqymcP0gaVm
         QgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177212; x=1776782012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bw6f7AXQLyB14/caIw5kD86MDDHBEfPYqQSR/5hoL5E=;
        b=qZ0W8oYiXv/HcGxotNCa2oMpzNMWKVJ4lvcAhrc9kLzGu878sPd8zKbPmEEMww7BWv
         8vQIfNQ3bWhwUSGwThVLV18fnmugO8DKI+fq3ReoitAO0mKklus1YKiFuHbNSpVjpp1C
         kd8B3yVK/0Z2dLMxPeEFKFljA32Y+Qd4J/dJDNDKf3GwUZnq8Z63NSsshSWcyT4jhRFE
         DEoMUiUYEk3beKuKZyBO0GqZ3gDKhDxWNaQW1OpfHvxwAjBSZtkOBDFUic2FbMMVPCiN
         akLlXzsM4T/FVveTZ1t8tE0rnmQWU+Z5UBts4BHM0Ue4zEGReYwQOIt9NVNJuB9cdptm
         4GOw==
X-Gm-Message-State: AOJu0YwB0aW9skGtxzb7N+LFPYz6zbkQ8ikOjG/EH17Glfo8pEHJptTU
	Bq1Wxx2Rxpc3+LJqh3qXdVWinFVViB0vtft2W2IKujAyMorScg64O9pLP0zZCzhE7RyMvcb/jOB
	6XLFhgBvoE9BkVgso6bhGrBkfikow8Gs=
X-Gm-Gg: AeBDieuRPI/G/niRKl6tqL3YHGKyyWhm04yY6IeOlfmTUJnydUNHOFFzmYfH4PWVzBZ
	MplsxdvEdXsbQLejpk6VTm/6cpFcv6CLfilIZAsAol18H+QisQ6T3655HTcEpjAlu2tfVQpnkbe
	GlnS6xHJvTVJ3qOCuqUsXSALnNqeImWvd7jU7tM9pMVmFjAXIH0oPUqL6bjoXUvjct6njdB1hZU
	q2DFu9i020p/j8Pnal9ghltPwteYxwEHfWsGdH+izx909QwMdcPgBuJW1gqzHozEs6TTdgDObpq
	O6t8/gWvGXGaEOyx7O7e+crHZWYuGrEdUIkl6zk3nmM9MG3bx/u55IEhZKjZP0hgJcnmDCOaOGD
	M7trANQVT/fE0z2Dgw50E67vibf5jb2HBhyY7
X-Received: by 2002:a05:6000:2dc1:b0:43d:7af0:3a7c with SMTP id
 ffacd0b85a97d-43d7af03e24mr10264101f8f.29.1776177211931; Tue, 14 Apr 2026
 07:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414105702.248310-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260414105702.248310-1-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 07:33:20 -0700
X-Gm-Features: AQROBzCkbw5ADLWM4k0dOh5Z9WgXj9bNTMtPKcV-DzogX7CuHh-4xfxWUg3Ty-U
Message-ID: <CAADnVQKZC5hrfn1+7BJXYnemWT_AR6ODYH5OhmpRaAWOosTxDQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf,tcp: avoid infinite recursion in BPF_SOCK_OPS_HDR_OPT_LEN_CB
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Quan Sun <2022090917019@std.uestc.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 3:57=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> A BPF_PROG_TYPE_SOCK_OPS program can set BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FL=
AG
> to inject custom TCP header options. When the kernel builds a TCP packet,
> it calls tcp_established_options() to calculate the header size, which
> invokes bpf_skops_hdr_opt_len() to trigger the BPF_SOCK_OPS_HDR_OPT_LEN_C=
B
> callback.
>
> If the BPF program calls bpf_setsockopt(TCP_NODELAY) inside this callback=
,
> __tcp_sock_set_nodelay() will call tcp_push_pending_frames(), which calls
> tcp_current_mss(), which calls tcp_established_options() again,
> re-triggering the same BPF callback. This creates an infinite recursion
> that exhausts the kernel stack and causes a panic.
>
> BPF_SOCK_OPS_HDR_OPT_LEN_CB
>   -> bpf_setsockopt(TCP_NODELAY)
>         -> tcp_push_pending_frames()
>           -> tcp_current_mss()
>                 -> tcp_established_options()
>                   -> bpf_skops_hdr_opt_len()
>                            /* infinite recursion */
>                         -> BPF_SOCK_OPS_HDR_OPT_LEN_CB
>
> A similar reentrancy issue exists for TCP congestion control, which is
> guarded by tp->bpf_chg_cc_inprogress. Adopt the same approach: introduce
> tp->bpf_hdr_opt_len_cb_inprogress, set it before invoking the callback in
> bpf_skops_hdr_opt_len(), and check it in sol_tcp_sockopt() to reject
> bpf_setsockopt(TCP_NODELAY) calls that would trigger
> tcp_push_pending_frames() and cause the recursion.
>
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@=
std.uestc.edu.cn/
> Fixes: 0813a841566f ("bpf: tcp: Allow bpf prog to write and parse TCP hea=
der option")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  Documentation/networking/net_cachelines/tcp_sock.rst |  1 +
>  include/linux/tcp.h                                  | 11 ++++++++++-
>  net/core/filter.c                                    |  4 ++++
>  net/ipv4/tcp_minisocks.c                             |  1 +
>  net/ipv4/tcp_output.c                                |  3 +++
>  5 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Docum=
entation/networking/net_cachelines/tcp_sock.rst
> index 563daea10d6c..07d3226d90cc 100644
> --- a/Documentation/networking/net_cachelines/tcp_sock.rst
> +++ b/Documentation/networking/net_cachelines/tcp_sock.rst
> @@ -152,6 +152,7 @@ unsigned_int                  keepalive_intvl
>  int                           linger2
>  u8                            bpf_sock_ops_cb_flags
>  u8:1                          bpf_chg_cc_inprogress
> +u8:1                          bpf_hdr_opt_len_cb_inprogress
>  u16                           timeout_rehash
>  u32                           rcv_ooopack
>  u32                           rcv_rtt_last_tsecr
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index f72eef31fa23..2bfb73cf922e 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -475,12 +475,21 @@ struct tcp_sock {
>         u8      bpf_sock_ops_cb_flags;  /* Control calling BPF programs
>                                          * values defined in uapi/linux/t=
cp.h
>                                          */
> -       u8      bpf_chg_cc_inprogress:1; /* In the middle of
> +       u8      bpf_chg_cc_inprogress:1, /* In the middle of
>                                           * bpf_setsockopt(TCP_CONGESTION=
),
>                                           * it is to avoid the bpf_tcp_cc=
->init()
>                                           * to recur itself by calling
>                                           * bpf_setsockopt(TCP_CONGESTION=
, "itself").
>                                           */
> +               bpf_hdr_opt_len_cb_inprogress:1; /* It is set before invo=
king the
> +                                                 * callback so that a ne=
sted
> +                                                 * bpf_setsockopt(TCP_NO=
DELAY) or
> +                                                 * bpf_setsockopt(TCP_CO=
RK) cannot
> +                                                 * trigger tcp_push_pend=
ing_frames(),
> +                                                 * which would call tcp_=
current_mss()
> +                                                 * -> bpf_skops_hdr_opt_=
len(), causing
> +                                                 * infinite recursion.

Let's not add new bits.
Reuse existing and test/check all in one place,
like commit 061ff040710e9 did.

pw-bot: cr
