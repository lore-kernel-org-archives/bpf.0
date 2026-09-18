Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40B29AAEA
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696839; cv=pass; b=Hm7hX2Oa2OXLyTjFw40m1YqCBoa7eIC99KIR4Vin+/BkUjiGK4JRz1OAfA1C2uiphUmgdhlWok7pVgHfj27QtNLoa7d75nyLFPL+GcuKFgZ2Fq2WdrEDbe+e6EXa+n5xyvNraZAoW4+rfFGNDxBHZgJc778CCGe1x79JYfUGpW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696839; c=relaxed/simple;
	bh=PlpdISyC6OBUWzrgrEb9aVRd6AgBRmYLWa2or2JmLpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3eIlSTDCkopkV487PZqqoDEqZBbvO7znfG9zZVwu1lE6Afu2Xy68ogu8FkN1l5Ie3wJe2bcxzeca49HnbCl8Im77031eiJEoHOAywzhsWq6kaz8vYnfMvxz4hGfBXPDb9NK6HkJ3+0BCWUyJljQVlCTqij2qdDy2hEiljVzWqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myNaS1Js; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myNaS1Js"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff15fadfso1083491fa.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 19:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789696833; cv=none;
        d=google.com; s=arc-20260327;
        b=Fe+gLchL7YvhLW37PtzhATW0QI0CBdlmH14ZXY6W9YPJ7epea1uwF0ymo3O10QLhE2
         7cLxVkL6xq6CqBcNl2BYXreIyCZOLUq3Fua3YKczxYCC7SGPKfaebtFxncmw20DJZz1Z
         vn7ZFZb7OiG8mz1yLOcm/Ost3oGIGshhbieQTP7dtVANhloPgWAywWh5co6deeOHLuEE
         C91TsCFLcZNKr8AE+aa/gIf9CWhU7AOPlO7Mn6HX6EKH0rJ+kbBlEW8/1HqJyofZkJr/
         rmFDw4F5686iZyCfRdFDHG1MUQ5pDRF8Q0N9boeMsa7yGMglQ4DRt6EUmRfp0SJge0wJ
         rCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L2T3WkwTK3gI4mo7cJOiCwU4Hwrt8d7v79JJAK0jOPE=;
        fh=kwdo/7xAI1iFGz9ykoIC8CnlIxQkBap09RDvGbS6i3c=;
        b=VJuHygv6we6U/4n/CLFtWRH1nl+O6i9o48qLzehyeYPpuv5FVVNcy+r3k66M2hpL7t
         b5NgJpobYFM/Jc5ZNToKJG1Xir+S2fZmvyNrXO3K7WSClGfgxysTOux+nvTBBFhsNmrt
         Fuekmg76Ytwc32hgks6IIFgIW9AJ8099i5IjHnFNuKfgkzE+v/x0YIsGD3fzJkbiYGMc
         CnnzsY0I2PpsNc9Urtsf1IDZarN5SnPznOxLOoG6vD81CqglSpaHrUPUvblJeu7/fCK/
         HXtgYBhaYNEBGw2Q1DiEqCA+D1WOyZkMGWP1gx4O7RbX5EtNrfh0L9VP7y9j9wkXb3C0
         xdFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789696833; x=1790301633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L2T3WkwTK3gI4mo7cJOiCwU4Hwrt8d7v79JJAK0jOPE=;
        b=myNaS1JsLFFIm5e5f3FYaT+j2Q80KabkLfjHDZubrbmY30L2qMLB6EG5xv2L/IBfKE
         a8qf2zupTfVeiTEATfN98kuvPqWtgoHOArZamdp6lZaeVkCzIjtXXsD5f0drjt3GgHEL
         ENY4+c2R//etIDRYbNcXIZBPVxNt1xbl1GMkjas7B5CidtC9jsMxrHq5uFfa2ba0TmpH
         OaTTM9zVibYbRMH1WSC/gokLvlDgKalobEVc8NJsuW2b1Bw8KiZoSpD9KYZmrU1Mi89+
         LRQf84RDdU2Ddos5tM8OR0Jt6Em/erGERGYDpBdl1obk3NSCEm8WTRg3XOMfLGiPRxGa
         VXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789696833; x=1790301633;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2T3WkwTK3gI4mo7cJOiCwU4Hwrt8d7v79JJAK0jOPE=;
        b=Ikm/cRB1xv/AuCcO4OqYr8KO5d6QlWJdXnBfk+FYBxPgc3dzgVYm+Hbtcc049KA0Ie
         9V1DJD3LmrYVGQ6Yp++46RGb9L2/2XIdN6uN+GxtQCrFVyu2mzicmzYTCAYOvefY/d6u
         V8poTcKDZ1mUGNdsywKGkSe1SWpPgSBaM6rpOuVaunT3cflkrbSGPlOXUiZbsvjdWiqF
         B9bGmG+sC7c+Skn7o8GD90zwwMhUtApcn4L0/W/MUMaDFINtZQ+ZzhmZU+WBdLqv3Dgb
         l51dinEFJqtgTxlAhGXtxfrMFnFMMGJP22oEn76BXveGtEKI+KNco/knjg58OaUy0JmC
         JQTA==
X-Forwarded-Encrypted: i=1; AKwUvBzD6AFMbZLFLMDSYKhWOL23c4lTMfSFx+mQXsdSj1eUF4xtHNXrG9nxgXbsZ38cvExHvOk=@vger.kernel.org
X-Gm-Message-State: AFuF++mSSXkuRBs580R75bKMCYd5M92aHu5xGPvDvbxx5+dMfAGmzjrh
	AQa18KUeheNROHuxrJNT+4s/mBwyPDNAJdEGAjACe5SFE/O/Y5WJzJx2co8arWysWmVLaTV+p/L
	Yj/oBtLUB6Dmhy0KRNWeIifutlNagOGs=
X-Gm-Gg: AYBFou28z6as1UbH3x8MRvQsarnjlN0c1Vv+4WiFn6AM8xx4jMUcmYDx6li035vOwjl
	NHv2VzOrM9vhBcIW+CX8NZ+GS9/o+Ju8U1sS9oIkI1tTaJq4zvmBUlIDkQ+wm9zAHdOpfwyPfr1
	ZK55PR3EZ+qmaizh1v//h96V15e6+SK2guJcsSSWMaE32YUGqg8JEZKbc592bCuYQoOfWpy0CxB
	P1Bl0nMedwOGUaEQt7mLWH38XvMeZSBGjwDg1FJUzNC7mugcgzg+9jemu2RzFtknZf9d1Xy+2iw
	tv9Erq3gW/3MavCa2mUsZKKAo+pS7/ZphAoC54MzMJUpbNBcBbEts7dMGsWYO8YhTSShH257oqG
	m/MYK4AtncvI0jVDcIYSR0dSb9GfAa+MYBvX5Ml7Dy/lRg5VkeEKek+q8+ARDOxnekNB9ig==
X-Received: by 2002:a05:651c:30c9:b0:3a4:d4de:bae6 with SMTP id
 38308e7fff4ca-3a5fb17a570mr1567331fa.6.1789696832712; Thu, 17 Sep 2026
 19:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917172050.2191062-1-dw@davidwei.uk>
In-Reply-To: <20260917172050.2191062-1-dw@davidwei.uk>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 18 Sep 2026 09:59:54 +0800
X-Gm-Features: AcwNN1XHiKAx1h7uL3cxHgyhPj1cS9briPDspIEQfpfG3uER5hEIyBwbthlqDDg
Message-ID: <CAL+tcoBpFM6MvZGPDJAH1j6aX8UaRcJLhtGbS_kRX_bQ=J5oMA@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: prevent stale tx timestamp keys on rtx fallback
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:20=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> tcp_tx_timestamp() can select skbs from the rtx queue when all the
> copied data has been sent in tcp_sendmsg_locked(). These skbs may be
> already cloned, sharing the same shinfo, and handed off into the lower
> tx layers.
>
> tcp_tx_timestamp() sets tx_flags before setting skb tskey, racing with
> any reader of both. It is possible to observe a valid tx_flag, but an
> uninitialized tskey, which produces a large underflow after subtracting
> the socket tskey.
>
> Reorder the writes in tcp_tx_timestamp() and
> bpf_sock_ops_enable_tx_tstamp() to write the tskey first, followed by
> publishing tx_flags via store-release.
>
> Readers perform a symmetric load-acquire on the tx_flags, followed by a
> relaxed read of tskey.
>
> Fixes: 838eb9687691 ("tcp: tcp_tx_timestamp() must look at the rtx queue"=
)
> Assisted-by: LLM
> Signed-off-by: David Wei <dw@davidwei.uk>

Thanks for the work.

Yesterday I remarked on your V1 at
https://lore.kernel.org/all/CAL+tcoDMR87sxJftp7T0JX-+NUz8VkXU67M3oNZy8Tk88s=
DPOA@mail.gmail.com/

I'm still doubtful if we really need to introduce this much code churn
just to fix the problem of this best-effort behavior. Even if the
patch is fixed thoroughly, it's still a best-effort attempt since
there are a few report points where it misses generating timestamps.
It has nothing to do with the patch itself, but rather the design of
net timestamping.

Thanks,
Jason

> ---
> v2:
>  - switch from pre-setting tskey to reordering tskey/tx_flag
>
>  include/linux/skbuff.h |  3 ++-
>  include/net/tcp.h      |  6 ++++++
>  net/core/dev.c         |  2 +-
>  net/core/filter.c      |  8 ++++++--
>  net/core/skbuff.c      | 27 ++++++++++++++++-----------
>  net/ipv4/tcp.c         | 11 +++++++----
>  net/ipv4/tcp_offload.c | 16 ++++++++++++----
>  net/ipv4/tcp_output.c  |  6 ------
>  net/socket.c           |  4 ++--
>  9 files changed, 52 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 421f6fc45451..489eeb4eb390 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4776,7 +4776,8 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
>  static inline void skb_tx_timestamp(struct sk_buff *skb)
>  {
>         skb_clone_tx_timestamp(skb);
> -       if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
> +       if (READ_ONCE(skb_shinfo(skb)->tx_flags) &
> +           (SKBTX_SW_TSTAMP | SKBTX_BPF))
>                 skb_tstamp_tx(skb, NULL);
>  }
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 5e5f5f9b89a3..cc7f78b5cca3 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1159,6 +1159,12 @@ struct tcp_skb_cb {
>
>  #define TCP_SKB_CB(__skb)      ((struct tcp_skb_cb *)&((__skb)->cb[0]))
>
> +static inline bool tcp_has_tx_tstamp(const struct sk_buff *skb)
> +{
> +       return TCP_SKB_CB(skb)->txstamp_ack ||
> +               (READ_ONCE(skb_shinfo(skb)->tx_flags) & SKBTX_ANY_TSTAMP)=
;
> +}
> +
>  extern const struct inet_connection_sock_af_ops ipv4_specific;
>
>  #if IS_ENABLED(CONFIG_IPV6)
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ecfbd72d5d1a..172ebab5d38f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4828,7 +4828,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct ne=
t_device *sb_dev)
>         skb_reset_mac_header(skb);
>         skb_assert_len(skb);
>
> -       if (unlikely(skb_shinfo(skb)->tx_flags &
> +       if (unlikely(READ_ONCE(skb_shinfo(skb)->tx_flags) &
>                      (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
>                 __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHE=
D);
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e753552..ed6396704e11 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12602,7 +12602,9 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __=
sk_buff *s, struct sock *sk,
>  __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *=
skops,
>                                               u64 flags)
>  {
> +       struct skb_shared_info *shinfo;
>         struct sk_buff *skb;
> +       u8 tx_flags;
>
>         if (skops->op !=3D BPF_SOCK_OPS_TSTAMP_SENDMSG_CB)
>                 return -EOPNOTSUPP;
> @@ -12611,9 +12613,11 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(st=
ruct bpf_sock_ops_kern *skops,
>                 return -EINVAL;
>
>         skb =3D skops->skb;
> -       skb_shinfo(skb)->tx_flags |=3D SKBTX_BPF;
> +       shinfo =3D skb_shinfo(skb);
> +       WRITE_ONCE(shinfo->tskey, TCP_SKB_CB(skb)->seq + skb->len - 1);
>         TCP_SKB_CB(skb)->txstamp_ack |=3D TSTAMP_ACK_BPF;
> -       skb_shinfo(skb)->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
> +       tx_flags =3D READ_ONCE(shinfo->tx_flags);
> +       smp_store_release(&shinfo->tx_flags, tx_flags | SKBTX_BPF);
>
>         return 0;
>  }
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 9648782fe8cb..25ca82eb6cdb 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5601,7 +5601,7 @@ static void __skb_complete_tx_timestamp(struct sk_b=
uff *skb,
>         serr->opt_stats =3D opt_stats;
>         serr->header.h4.iif =3D skb->dev ? skb->dev->ifindex : 0;
>         if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
> -               serr->ee.ee_data =3D skb_shinfo(skb)->tskey;
> +               serr->ee.ee_data =3D READ_ONCE(skb_shinfo(skb)->tskey);
>                 if (sk_is_tcp(sk))
>                         serr->ee.ee_data -=3D atomic_read(&sk->sk_tskey);
>         }
> @@ -5652,6 +5652,8 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>          */
>         if (likely(refcount_inc_not_zero(&sk->sk_refcnt))) {
>                 *skb_hwtstamps(skb) =3D *hwtstamps;
> +               /* Order the tskey read after observing timestamp flags. =
*/
> +               (void)smp_load_acquire(&skb_shinfo(skb)->tx_flags);
>                 __skb_complete_tx_timestamp(skb, sk, SCM_TSTAMP_SND, fals=
e);
>                 sock_put(sk);
>                 return;
> @@ -5663,19 +5665,20 @@ void skb_complete_tx_timestamp(struct sk_buff *sk=
b,
>  EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
>
>  static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
> +                                                u8 tx_flags,
>                                                  struct skb_shared_hwtsta=
mps *hwtstamps,
>                                                  int tstype)
>  {
>         switch (tstype) {
>         case SCM_TSTAMP_SCHED:
> -               return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
> +               return tx_flags & SKBTX_SCHED_TSTAMP;
>         case SCM_TSTAMP_SND:
> -               return skb_shinfo(skb)->tx_flags & (hwtstamps ? SKBTX_HW_=
TSTAMP_NOBPF :
> -                                                   SKBTX_SW_TSTAMP);
> +               return tx_flags & (hwtstamps ? SKBTX_HW_TSTAMP_NOBPF :
> +                                                     SKBTX_SW_TSTAMP);
>         case SCM_TSTAMP_ACK:
>                 return TCP_SKB_CB(skb)->txstamp_ack & TSTAMP_ACK_SK;
>         case SCM_TSTAMP_COMPLETION:
> -               return skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_TSTAM=
P;
> +               return tx_flags & SKBTX_COMPLETION_TSTAMP;
>         }
>
>         return false;
> @@ -5718,20 +5721,23 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>         struct sk_buff *skb;
>         bool tsonly, opt_stats =3D false;
>         u32 tsflags;
> +       u8 tx_flags;
>
>         if (!sk)
>                 return;
>
> -       if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> +       tx_flags =3D smp_load_acquire(&skb_shinfo(orig_skb)->tx_flags);
> +       if (tx_flags & SKBTX_BPF)
>                 skb_tstamp_tx_report_bpf_timestamping(orig_skb, hwtstamps=
,
>                                                       sk, tstype);
>
> -       if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, ts=
type))
> +       if (!skb_tstamp_tx_report_so_timestamping(orig_skb, tx_flags,
> +                                                 hwtstamps, tstype))
>                 return;
>
>         tsflags =3D READ_ONCE(sk->sk_tsflags);
>         if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
> -           skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
> +           tx_flags & SKBTX_IN_PROGRESS)
>                 return;
>
>         tsonly =3D tsflags & SOF_TIMESTAMPING_OPT_TSONLY;
> @@ -5760,9 +5766,8 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>                 return;
>
>         if (tsonly) {
> -               skb_shinfo(skb)->tx_flags |=3D skb_shinfo(orig_skb)->tx_f=
lags &
> -                                            SKBTX_ANY_TSTAMP;
> -               skb_shinfo(skb)->tskey =3D skb_shinfo(orig_skb)->tskey;
> +               skb_shinfo(skb)->tx_flags |=3D tx_flags & SKBTX_ANY_TSTAM=
P;
> +               skb_shinfo(skb)->tskey =3D READ_ONCE(skb_shinfo(orig_skb)=
->tskey);
>         }
>
>         if (hwtstamps)
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 562752352afe..ec4ee5e5d2de 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -483,18 +483,21 @@ static void tcp_tx_timestamp(struct sock *sk, struc=
t sockcm_cookie *sockc)
>         struct sk_buff *skb =3D tcp_write_queue_tail(sk);
>         u32 tsflags =3D sockc->tsflags;
>
> -       if (unlikely(!skb))
> +       if (unlikely(!skb)) {
>                 skb =3D skb_rb_last(&sk->tcp_rtx_queue);
> +               if (skb && tcp_has_tx_tstamp(skb))
> +                       return;
> +       }
>
>         if (tsflags && skb) {
>                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
>                 struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
>
> -               sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
> +               if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> +                       WRITE_ONCE(shinfo->tskey, tcb->seq + skb->len - 1=
);
>                 if (tsflags & SOF_TIMESTAMPING_TX_ACK)
>                         tcb->txstamp_ack |=3D TSTAMP_ACK_SK;
> -               if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> -                       shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len=
 - 1;
> +               sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
>         }
>
>         if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index e74d99ca9fac..73344cdf8e16 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -16,13 +16,20 @@
>  static void tcp_gso_tstamp(struct sk_buff *skb, struct sk_buff *gso_skb,
>                            unsigned int seq, unsigned int mss)
>  {
> -       u32 flags =3D skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP;
> -       u32 ts_seq =3D skb_shinfo(gso_skb)->tskey;
> +       struct skb_shared_info *shinfo =3D skb_shinfo(gso_skb);
> +       u32 ts_seq;
> +       u8 flags;
>
> +       /* Pair with timestamp request publication before copying tskey. =
*/
> +       flags =3D smp_load_acquire(&shinfo->tx_flags) & SKBTX_ANY_TSTAMP;
> +       if (!flags)
> +               return;
> +
> +       ts_seq =3D READ_ONCE(shinfo->tskey);
>         while (skb) {
>                 if (before(ts_seq, seq + mss)) {
> -                       skb_shinfo(skb)->tx_flags |=3D flags;
>                         skb_shinfo(skb)->tskey =3D ts_seq;
> +                       skb_shinfo(skb)->tx_flags |=3D flags;
>                         return;
>                 }
>
> @@ -198,7 +205,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
>         th =3D tcp_hdr(skb);
>         seq =3D ntohl(th->seq);
>
> -       if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP))
> +       if (unlikely(READ_ONCE(skb_shinfo(gso_skb)->tx_flags) &
> +                    SKBTX_ANY_TSTAMP))
>                 tcp_gso_tstamp(segs, gso_skb, seq, mss);
>
>         newcheck =3D ~csum_fold(csum_add(csum_unfold(th->check), delta));
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 00417a429222..7bab67f5d327 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1795,12 +1795,6 @@ static void tcp_adjust_pcount(struct sock *sk, con=
st struct sk_buff *skb, int de
>         tcp_verify_left_out(tp);
>  }
>
> -static bool tcp_has_tx_tstamp(const struct sk_buff *skb)
> -{
> -       return TCP_SKB_CB(skb)->txstamp_ack ||
> -               (skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP);
> -}
> -
>  static void tcp_fragment_tstamp(struct sk_buff *skb, struct sk_buff *skb=
2)
>  {
>         struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> diff --git a/net/socket.c b/net/socket.c
> index c05d86e63abf..d16e1f491f15 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -766,7 +766,7 @@ EXPORT_SYMBOL(sock_release);
>
>  void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
>  {
> -       u8 flags =3D *tx_flags;
> +       u8 flags =3D READ_ONCE(*tx_flags);
>
>         if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE)
>                 flags |=3D SKBTX_HW_TSTAMP_NOBPF;
> @@ -780,7 +780,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flag=
s)
>         if (tsflags & SOF_TIMESTAMPING_TX_COMPLETION)
>                 flags |=3D SKBTX_COMPLETION_TSTAMP;
>
> -       *tx_flags =3D flags;
> +       smp_store_release(tx_flags, flags);
>  }
>  EXPORT_SYMBOL(__sock_tx_timestamp);
>
> --
> 2.53.0-Meta
>
