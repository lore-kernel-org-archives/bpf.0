Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58B30C148
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746214; cv=pass; b=ffscvmhPWca32UXyihhJcSiKBIlJ59E6euWTDWccn6BWrliVQRsJY6L3u6nuPHpIt2UgmYmu2xOA/3ZsZEPCe3Wj1aHR5Xa4F+VyNx9wlYxB6Z3FJoAbPvPtA3AXkluYhbN4QdVQ2y6+mEE1LnjHitQh8iMk2HboMGQIxa9ObZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746214; c=relaxed/simple;
	bh=LpzHZjjw9WWzYVr2KkbWNQpkV9bpn8GytcGc6ODCG0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fm403mzkE9gSNCpVQWbT8mQcxwzyysF4ZHY5hDVpCbsMxVzzkT3a88R7IqEkLFuflGzrN+uV9j1ytTm0Pxp7JXZkpRcxB7OHFwnMaSaAqFGu1kKfgpyHEuVcHUkAd7Qlx1py0ujDQsaiSCbqLt7+RFamKJMokiFFb//NoNKcRZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwRLDPSl; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwRLDPSl"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-930c0f9c1b1so498712885a.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784746211; cv=none;
        d=google.com; s=arc-20260327;
        b=jChHm3J5vUF7o4ufw+yNREB2CfAl7Aj3XOI6XvmtsNQpQc//9SmQzEKYu96PyiyGXY
         Pvsvd6SBr5EqVOXi773RXoK2JveMcWYOFyMhAg+K5aZ8lff2uBbunChUV6QMT3MukSQp
         UR/GzK6Lw2MuRLXov/3hRJWZScqc/M+HnIwMD9rnW0Y5EbrmLUVOYTE53OT3c/uJIspa
         pFBnXVB8SoBDklLebOpUNbk9r6uFjESCAP0C4fXP5CL2uhpmStj8fQ+rir8qGe2SsMAm
         2c/Wzehe+x8Xs/b4lVCKg1ZGE9t5+tZiLsVYWOajwk8bXtv/d6Gumg5ClEq9fH5V85vL
         bKYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=81PqcakE3vFqwcrUKH8WKjOfwB48ApktmKwcHNXwN8w=;
        fh=9ZVTFihw7ntTMMkfY75VQ8ejL4DLKI2HWzeLAQ1q7Zo=;
        b=JlfZD4qFKcV8WlZTg6wRMyQG6qCZCVLYKy0LtxeE83RCuFJf+hc0ta3Uu7xXKrS1eE
         aIza0wlBZ1EH08iLXGcei0n9Yg1QSM/OiJBa8+xEEMB3DYoY8JTA8krxAm391efKqlxk
         PveN4D4YQsWZ2HqJiyrDmtg7LmELJYSg5NW006rf08jwdydcS43BFCXSrdO6Dcmbbt5v
         J0xzOWvcol6OR53IWiXpDjbgxQMNuxysfbcqRHKzi9XvniGUMiwXZGpVV08758buWWMD
         5tOkoEGDgYc1ZjcOxpNBNhteIP8UkXTYjhaN+iVBNuFoCZDvL5/X/R3XY/fD+3CwmBu7
         LgrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784746211; x=1785351011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=81PqcakE3vFqwcrUKH8WKjOfwB48ApktmKwcHNXwN8w=;
        b=TwRLDPSlaqKU0KTwYCWF45jMW5DZy9g9q0wP1M4K2l95JKX7p6gpHEKrMu7LYoe0/O
         XWTxPsO99B52ZaJD0d6YH1MbVhYO+8PNUDnrKP/53zlhjsc8kEbFZXdc7Op0K+TPjrJy
         sd1k37lE1LibVdk9GR1EH2B+mDIQecfIo9+KbonwbO8v7aKqWfT5QfOJt85vxhW7aSU0
         KQGQtxG+WgQnRCbSnYTgmo+YrRE+Q1v1TiK2xWzaNKPL24TirIGAVOSVfL+qmuo/PURY
         9adM9Cwl97B4NotDScBIBFZcxl/eppm78HqPzzdAMZmcB7q8oHT6KOhyY3p5pxHzqxVD
         A8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746211; x=1785351011;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81PqcakE3vFqwcrUKH8WKjOfwB48ApktmKwcHNXwN8w=;
        b=fRDWG6e/Bke1cARDHpa7tKpdhyiL20jkB6bQc8F0PtJsMmKrE3RJM7qyAy4nwi45Zh
         SjDQHNNKTZ0YcUxCcgMTQc28B5FucKT74GMGrvbF5H3P2tStzk44etShhVKYe/ORJXGQ
         1TwuoAQN4Xa9vzChhdg1IZ+g1JDKe2FWKUWCK1i1e8cBgfyXhVQsztiFo8I113gqlNMy
         IxJ0272sLd9NIvailaSKcCPK551CGfcjA2aOjPbBgVq89QaVBhtP8JJxzMu82UxyRqw5
         F8rv6He28yrhmxrP9f2mZfhDPK1uVOEDfWW8F7LpL/LNsanYMLCpUzFW6OH7iRrZ5W6d
         hCLw==
X-Forwarded-Encrypted: i=1; AHgh+Rqi8UPuplln36yiQHx6tdvML2veZEptoJJS8IK8D1LXHma201gnBA+HIAjmUU4i6c5rxBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDqVzSleGE6P79JvKbxyrWPaf/lDuCYrAdrKsWkIQnwteh9fRg
	V6jYpjbVRE+8YSMPI0c9lu8aoKB5rGz2gmzrKnALR0gmO84EWZ2gmRB/86Vrtn+eVhsuph7w7Zu
	TsEeemDAyS6W3urv+O/sWsoP3VRkXo2Dl/7lpShli
X-Gm-Gg: AR+sD12Bie5NbAD+WRIPaVI0u2xHR467FuYvTu9rtu9712eMI1WvEOz512LZyoXPzKk
	AmEUwJWIU19CrkPZLLr5BNe8mPyDsynNomitiSYSk3dV95qwipSbu5oUDd8C1i8h12W95Wm0hZk
	7wc3e2YlpL9kZo3IfFy/t08PCuL9NaU3XSXsXIs+5g7Vlcfbc6YFBfoocYcQ99vlDALyBBtMRFv
	+0iy3CO4NZ9r0ATeBCInpTDNpNGD3fwrE6NtJlg6PyW67BbECsByaYESNtifdJ/KdRtDnowOOKa
	itbWdOsdVZ1eO7iBV3YAa5fDj9gwUGbOfuqWqrxlWQBPTTt2oCueeiMRJxquCHc4fDuT3oZc/dr
	AzcYHjQQ=
X-Received: by 2002:a05:620a:2781:b0:930:a3f9:93be with SMTP id
 af79cd13be357-930b41e3f78mr2166588085a.45.1784746210540; Wed, 22 Jul 2026
 11:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722170033.2763794-1-tejasbirajdar@meta.com>
In-Reply-To: <20260722170033.2763794-1-tejasbirajdar@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jul 2026 20:49:58 +0200
X-Gm-Features: AUfX_my4Md1AiO3X81lIV1evIfaK05NsCXHOiqWRa_MlvfcNKZaAVltr3zCh0w4
Message-ID: <CANn89i+WLbtLYNjYipH+8=6nrq-XmdYY9TgHHNpeLLeuuvbEUQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: honor BPF_SOCK_OPS_RWND_INIT on the active
 connect path
To: Tejas Birajdar <tejasbirajdar@meta.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 7:01=E2=80=AFPM Tejas Birajdar <tejasbirajdar@meta.=
com> wrote:
>
> BPF_SOCK_OPS_RWND_INIT lets a sockops BPF program pick the initial TCP
> receive window, e.g. to advertise a larger window up front in environment=
s
> where that is known to be safe. Today it is only effective for the passiv=
e
> (listener) side; on the active (connect) side the value is computed and
> then silently discarded.
>
> On the passive path tcp_openreq_init_rwin() inflates full_space when the
> program returns a non-zero window, so tcp_select_initial_window() can off=
er
> it:
>
>         else if (full_space < rcv_wnd * mss)
>                 full_space =3D rcv_wnd * mss;
>
> tcp_select_initial_window() only clamps the requested window *down* to th=
e
> available space, so without inflating the space first the BPF reply can
> never raise the offered window above tcp_full_space(sk).
>
> tcp_connect_init() calls tcp_rwnd_init_bpf() but never inflates full_spac=
e,
> so on connect() the requested window is clamped back to tcp_full_space(sk=
)
> (~64KB at the default rcvbuf) and the program's value is ignored.
>
> Mirror the listener-side inflation in tcp_connect_init() so both directio=
ns
> behave the same. tp->advmss is the mss the listener path uses as well (bo=
th
> are tcp_mss_clamp(tp, dst_metric_advmss(dst))).
>
> Fixes: 13d3b1ebe287 ("bpf: Support for setting initial receive window")
> Signed-off-by: Tejas Birajdar <tejasbirajdar@meta.com>
> ---
> Functional test: attached a cgroup sockops BPF program that sets
> skops->reply for BPF_SOCK_OPS_RWND_INIT on the connecting socket, and
> drove it with packetdrill on the active-open (connect) path (wscale 11,
> advmss 1440). On the patched kernel the advertised receive window on the
> first post-handshake ACK now reflects the requested value; unpatched it
> stays clamped at ~64 KB:
>
>   req_segs   unpatched   patched
>   256        ~64 KB      360 KB   (256  * 1440)
>   1024       ~64 KB      1.41 MB  (1024 * 1440)
>   4096       ~64 KB      5.63 MB  (4096 * 1440)
>
> (The SYN window itself is unscaled/capped; the offered window appears on
> the first scaled post-handshake ACK.)
>
> Regression: tools/testing/selftests/net/packetdrill run under virtme-ng
> on this commit vs its parent produces an identical pass/fail set (no
> newly failing tests).
>
>  net/ipv4/tcp_output.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d7c1444b5e30..478e4951140f 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4101,6 +4101,7 @@ static void tcp_ca_dst_init(struct sock *sk, const =
struct dst_entry *dst)
>  static void tcp_connect_init(struct sock *sk)
>  {
>         const struct dst_entry *dst =3D __sk_dst_get(sk);
> +       int full_space =3D tcp_full_space(sk);
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         __u8 rcv_wscale;
>         u16 user_mss;
> @@ -4133,14 +4134,16 @@ static void tcp_connect_init(struct sock *sk)
>
>         /* limit the window selection if the user enforce a smaller rx bu=
ffer */
>         if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
> -           (tp->window_clamp > tcp_full_space(sk) || tp->window_clamp =
=3D=3D 0))
> -               WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
> +           (tp->window_clamp > full_space || tp->window_clamp =3D=3D 0))
> +               WRITE_ONCE(tp->window_clamp, full_space);
>
>         rcv_wnd =3D tcp_rwnd_init_bpf(sk);
>         if (rcv_wnd =3D=3D 0)
>                 rcv_wnd =3D dst_metric(dst, RTAX_INITRWND);
> +       else if (full_space < rcv_wnd * tp->advmss)
> +               full_space =3D rcv_wnd * tp->advmss;
>
> -       tcp_select_initial_window(sk, tcp_full_space(sk),
> +       tcp_select_initial_window(sk, full_space,
>                                   tp->advmss - (tp->rx_opt.ts_recent_stam=
p ? tp->tcp_header_len - sizeof(struct tcphdr) : 0),
>                                   &tp->rcv_wnd,
>                                   &tp->window_clamp,
> --


LGTM, but it seems "rcv_wnd * tp->advmss" could overflow

I would suggest squashing to your patch the following fix to current code,
and apply the same logic to your added code.

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ddc4b17a826b52afa967e17d482403f373f2f72a..f8c1123aba433713f60b30fd4e1=
df7fe4f1860bc
100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -453,8 +453,8 @@ void tcp_openreq_init_rwin(struct request_sock *req,
        rcv_wnd =3D tcp_rwnd_init_bpf((struct sock *)req);
        if (rcv_wnd =3D=3D 0)
                rcv_wnd =3D dst_metric(dst, RTAX_INITRWND);
-       else if (full_space < rcv_wnd * mss)
-               full_space =3D rcv_wnd * mss;
+       else if (full_space < (u64)rcv_wnd * mss)
+               full_space =3D min_t(u64, (u64)rcv_wnd * mss, INT_MAX);

        /* tcp_full_space because it is guaranteed to be the first packet *=
/
        tcp_select_initial_window(sk_listener, full_space,
