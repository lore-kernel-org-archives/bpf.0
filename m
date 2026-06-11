Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C143CEE4
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197275; cv=pass; b=aGaJSnm14QyiSocUnvR3QJLcIn2XKOQWQO/dXYvY1+johytupIB9mvR5jFK2x+PkHH0vz29ky8zgNuRrF0B5sIU0Gd5hujhqLQ+iP36bnKvQy/CY9U40gVo+qTHDejKI98dkav0LnpUoSsW5gfW+u15WowLU0YU+ZYMQgtRol8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197275; c=relaxed/simple;
	bh=BRG/+Vzt4T53h7k5QJdHXcInjK0uh6ckGOysRuKZ8Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpApn9TsuMW27AFgVN73nz5WM6fbfcxB7EOiqKV3qufCtd8wVdnqTbvOhauT3U/EiKxbtsUW61QJhEEa3jpEAuB9xBkInqlzYyJw6snl1nrb2sbebFmYlDyyYp4Z43GqbJGa05GWs+hVJMvGrtyKfCQ9f3ljjAjcIGHKlGyQfqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tM3pjFfo; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tM3pjFfo"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7e2f3646c10so914107b3.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 10:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781197271; cv=none;
        d=google.com; s=arc-20240605;
        b=Ok6gjCEsDWy7UGC9NS3w3nftNMjVDny6iO4OnqI+fuMoxkM4HbCzGyVdyvH+hRE7lA
         czWAPUap8SePXLkYxLSI6CBEhJCkMnPZvi/0XirDRk2QA2h+QdEGWvOUNlF5z7irc3CN
         Nmh72CwltTDMOZNsbafLaVmHP+U7U6evL7JTXU08fN5Lr/qf7AS0KWUHkHHDMfGwc1CO
         fBy34wsTcw4gsnUPWugVsALt+EKgJ1XI/6AuIP2YhNVlifKdHBqHGbndfA+1TjqmZssX
         3eDZAEVa+/RL81oGFNnBMCf/ig+vovH6HWVL28yz4qSXoaHi1lRQpLaGdZJb9YKsTstR
         6uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fAYyJrdDmGO0RJNipWyudCHDG9PqIFDzzEaVoKYHsmE=;
        fh=uceQOIG2Gy9ktH4F8e6Fy6tMZMPRm6KZ02zGcfxPNgo=;
        b=S2SQCHBHbVMsUs3MQoy5z2lz82DF7Rrpo6zcPUaZ+VjXdxnVs3/R5LASzj/xbPlCCt
         a4wgeXbs/p28v5naDk/AHblTb5BMUXM81L4/O/H0J78xgb/TkQJDjLo6USmb8/DfZ3cs
         emRkk4/6UIq+pkch59Ut5SQVvsnYGffCkgr6vLiEEMTWkejwQFvAMWa51UGUYzJtgmSV
         QiBSrOgIGNimnaMgnALq+X7A33z+EJmvXVqqjY9NMvpxsmAex4FaN3N8C0y0+TScWDy+
         wuoqRoS7jghx5ZoVnaNJENCARZiCrssDflaicmK1zYuc+NoiaHueBb8ZimbnmhdmFERE
         TetA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781197271; x=1781802071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAYyJrdDmGO0RJNipWyudCHDG9PqIFDzzEaVoKYHsmE=;
        b=tM3pjFfokCbPZbIXWfqvS5Fp8MML/h9bYU7nUBklrZq/4D3YyD5c8f/cVlStsxJswz
         ZDwGDWKDbA+vyJlLqVX1+t8NMry+OHpB3S+aY8XktmJjpDT/puuzBeCYHGOUKPdk58Kg
         ss0LfwiRu9sMwPNgq6cH2NzPs+0x0Goo3xE7uJtqOUyQtRx4/Rvo6PycT5RhtT2tiS/4
         LPy/o+IV28FmJL1Tjk+v/H+PzyE81ANkMq0oUts8+G/rjiiu7xdLpFYZrPL8V037DdAx
         y8STMM118lfIFptobHEGv5hMcwL9Q7/6GtLrbt6UjXeHOInUqbHAc5tFdOq5prpy6o40
         NiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781197271; x=1781802071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fAYyJrdDmGO0RJNipWyudCHDG9PqIFDzzEaVoKYHsmE=;
        b=eD37SaEmIJSltW223FEDwgCfHe5j8AUlmGOwg1m5Elu4ePdBNUSpAt9mj7SoWRjwcw
         cpT2fgPgji27pxaJ+kPsCVcBrrUEsjh8+b0ISlN/GcAJzupZCbsiOYVZL1iEWlQGt9Ba
         ZDjqXt0VTiNCx0eH0QhqMsEwPxyqgQXxL03YIYeqQSgjaqCRY8jhzH/XOPgbja92h+hK
         uIEzRq6NrdS4ishqWWGRY6Bn4YMO8zeshrXpnx9cThzgLZE8fNtzfIZqrAgvtC0nN/5+
         oDRVnJCciR0jesOVW7t9sLhFcwoFD+Yp1mCuEi9YO2hgq3ujhsGXOCjzDEDwROk4rh2t
         VT+g==
X-Forwarded-Encrypted: i=1; AFNElJ8QyO1WtwXmy37kQ7gijLRaSU/Nd7h4dh7ImXDitNBRTdpDn42aSD7Dkpi91BEdh7yRgMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymRmsIlx1rTeiJDWQm5yyx6KPsDJAGKbRaD7qhCR10gX7hpjqN
	qZK2wVfv2orEQ8/e1eA60fv6i1n+nxYMaKN7z+C7IWRtHtkRREF69aNa/nR0pfm84C1RGtzO+7x
	b73QNeIC2hJ9hxnRsNNFphLUWsur/bbH2NFATgY+7
X-Gm-Gg: Acq92OGRWVJt8Uo42SvhoMa+OElaaubUlGanX1YhltAegg1+LdxV8UkkPqTDYVC/RW/
	k5gr0FEWNwvkxEJUHUDDkJbtB1WUGGdBckr922c3ixC+DoPoapmvix5c6RrEliZem3I5kSjR9/4
	geZAf/T4/lCNcQXS5I9fBgZeb/zxlnP9PUITQrTKMmBOPfu+jB2E10YABoNLy8IgiVEbNSM9Ko9
	nlUpXoS23wawUMfgcQD7X3iWhZoyJJ5GahAhSgVQ1XEWW4W8bUidXHJEiRN0PEA2L8D2BHCsv6b
	csAsdjvp1eli3a6hka1YCCMhsinbL5cdqQky4veh/SPtRA/mZGu4+tDjwsbNXMi/eNyiKJlhIul
	G1lKOAeF7AR7GjxnV2N58Xs7q2aerMQ==
X-Received: by 2002:a05:690c:690e:b0:7e0:97eb:f3cc with SMTP id
 00721157ae682-7f6570993bamr43002157b3.28.1781197270694; Thu, 11 Jun 2026
 10:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com> <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 10:00:57 -0700
X-Gm-Features: AVVi8CdtI2GzmyptA-tGAGNyn1dR7786EfJbaaPlfBCtP3di1yIY6vTdixZaV4g
Message-ID: <CANn89iKkPJqOM=0KV8O8=2zWrZObj+E+VJoLztp4sUi7Vj0aQg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback for TCP Prague
To: chia-yu.chang@nokia-bell-labs.com
Cc: horms@kernel.org, dsahern@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org, 
	stephen@networkplumber.org, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, kuniyu@google.com, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 9:15=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> This patch adds tso_segs() CC callbak for CC algorithm to provides
> explicit tso segment number of each data burst and overrides
> tcp_tso_autosize().
>
> No functional change.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/net/tcp.h     | 3 +++
>  net/ipv4/tcp_output.c | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index e8090f542f7c..3b415c9dcc54 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1366,6 +1366,9 @@ struct tcp_congestion_ops {
>         /* override sysctl_tcp_min_tso_segs (optional) */
>         u32 (*min_tso_segs)(struct sock *sk);
>
> +       /* override tcp_tso_autosize */
> +       u32 (*tso_segs)(struct sock *sk, u32 mss_now);
> +
>         /* new value of cwnd after loss (required) */
>         u32  (*undo_cwnd)(struct sock *sk);
>         /* returns the multiplier used in tcp_sndbuf_expand (optional) */
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index fe725d94a225..a7206fa61957 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2274,7 +2274,9 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned i=
nt mss_now)
>                         ca_ops->min_tso_segs(sk) :
>                         READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_s=
egs);
>
> -       tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
> +       tso_segs =3D ca_ops->tso_segs ?
> +                       ca_ops->tso_segs(sk, mss_now) :
> +                       tcp_tso_autosize(sk, mss_now, min_tso);
>         return min_t(u32, tso_segs, sk->sk_gso_max_segs);
>  }

Can you explain why min_tso_segs() is not enough?

We do not need two different mechanisms.
