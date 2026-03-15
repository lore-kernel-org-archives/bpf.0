Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ECB366074
	for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590229; cv=pass; b=AtTpyC1ceSWRYl8LbPJGHWXNmOcggQ29bVDeTpcucRYFZLeptUciHYmVs7GE38FSkfRpwbuVUYwj+rKkOtAkG+9aOVqzlpijN7Y1m+PZo6QvY4l3G5QlRjtd/t/snVa12PA7bUC1JjfwjHSr1iG03eg8E5/RMFc+uQ47VWkykks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590229; c=relaxed/simple;
	bh=RHhZsLnqC6Bu6Ua4krxM/WIz6LxoxkyzOVR0OJNFQIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C70YhZbOrdzY+IbyPReiVHRLmytGgKDMZDLYm+OiYlKODN/lw+2QvLaWh1hyRQ87w7SRX9ca2hstJ05o0WQSLW9eGp5wgBMLGL+YsYE2lMyNItDckiqaUNDzCI0lrACFfILQV3r5Ev7XYwlNAmUsmeNFTmKiiM6Zstxkv/aLG0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=d0gtwYW3; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="d0gtwYW3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82976220e97so2224420b3a.3
        for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 08:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773590227; cv=none;
        d=google.com; s=arc-20240605;
        b=UYFOvs6w5tQFsCgMxwp1ssLGFAqt3jAZTFWyU1YUSC3nmFKDveH9TW6KAlaYQmC7+M
         +pT1twv3qpFYpEVyRYABlSS4LenQJ+IOp6O1tXZRBVu+UXt82e8XYUmBuYvVwtMSOEBh
         1hmL99aMWL2UdXEvPinyBwSrWjgoWeDAd8IEYEaL6D7XOtJrIGm8nmYq/Zzmfd1Qzgjf
         AMvr8fMr6CcAETwUUzOUiEqi6N/RjvZJ0NOeaWYblQ5t+Us5o30NJOnhH2n9y9vbHjlH
         PoDJz8pRxvZZuKbrf9PZc4wT2IUnS8/F6WlXK6hATnnR7z+3SZ8jf8c/FAHwR5lmLUIS
         Rr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKiLs1RyC55du9pBc4TcXHWFicF13Mvzo2PvrfgLqag=;
        fh=ZKu9LfPHg1aX8ygCbUUr++rbP9h3iiJO79+zcbli/aY=;
        b=RtalCFvty2Tjzh5YktTG5m2BwFKIsFrda8YgESvEcfErpaUaYaf+YzIq9CnYBsI4WJ
         YU7jvqJI89vy+amQu0oNFhnnPh4h/TiTO0xQWOuj2jYeJpJYx16GOPZ3pxCZIOBcQqHn
         REFgW5K7fjpwec5hQJwAIjxAXfdr65In2lti3tXNrPrCsju9L3SkF41If7BhZZlq5AiD
         PEm4heMWlmBIejwktJavhuJhgoqNa/gfrx1oktHXVB1XrY6bbPVZPzN7Kz8k6/oORq7+
         jaNcVXdZq8Yfzft2hQmqzQYhkPbrG15F3fstiNPMdeT1AB48ykkXqp1UUmqwfCGz6sl1
         6E7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773590227; x=1774195027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKiLs1RyC55du9pBc4TcXHWFicF13Mvzo2PvrfgLqag=;
        b=d0gtwYW3LERaAfl6wkpYefFOaIeg1nSgHfprggMyM3QbUGnAC5WLE9Z5kbtQESzVXG
         rV7jvnUY5dBo4ah+vGNHlZz/vsPUYV7Hd/NSPpdoJNe6Hz5pRGViXAFCCa5akhv5VbIw
         zTftIm6K7DKwLPAOYuSm9MAOZX+Sa0Hv0wyCFxF4Zq7nbOzPywnShZbHsrFP5SyOp2Fd
         ClDIL74nCnAhXfQXTuFNhFO8/JNsgp7iizZbUHTyYGnIp2QKppEvGG7BaB3H4RQK8BPj
         3H3HyDCbujzY4I6NzysF2p7WmMpQ75++zTZzzshDr7xJ3HBRvHpXuCUC3ZcpBT+wK8QJ
         l3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773590227; x=1774195027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKiLs1RyC55du9pBc4TcXHWFicF13Mvzo2PvrfgLqag=;
        b=EpSzp2EA1yPTU6edFft7qbFX5Hz/HngXxgpxbema7gI+3HzI5ikT0GElyz5/a66jxX
         bL5Kk6GjJVq9cRdavDHhjG9nLGjq3zPY8KqBY1+yXZJKojBiqboJa5NxxXrYHS9i3GT5
         1tDkjQcNeLfPtk5TVynhN6hH+IhVHCubUWFECEul5TZQbuRdpaW2oPo6RYX+GLnRN4p/
         n/ElCEIa9g4lItyn9Yftpzs+HdL1mzWgIEg/9R0p0PQNk6G7ag0xQwsuZiHlCRZDX1ML
         pacWb09P9kWp83rM7nMQgdayKjESjdUKjZCzVg0hsYen44WpIJT/dqL/4SAg7mE1JgCz
         XX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIkfbtchE+GVGk5s2vAq0PKiJgKMJl1IH/uZ0PkbT8F5b10T7QuHxADEX2aROjNyY5oRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyocXuO7HAnM2Zl3iIUgJD6R7fI0Ze/CYY7mT67rE9N9BVi1vEk
	90/ZyBzwJb4kKm6gOaPtNiXA3MCRZ1ci17bd8OqByq8uVJlYUun1weulIe7qJ6d6tdydT6Xo3WD
	MTaglDn9mkE0pQ+n57GSK5oIKw+HhvGkn7T9Npw82
X-Gm-Gg: ATEYQzzENxnZkXgbeYyw4wlO2vrxg7nT4Z/Ne/MUrqT7PkNaQEF8uMea+g6Ft5zO+Ns
	V5H+U6RgEdeFJrzctfc+qFjI41q8H+yXWEWcwIbm3X49xEngUgsBherDvxiCQIB3fSU7NxUenJ4
	X52cx8KrZQb3ikGjQ+MAx1BYtmKRvVfwcrQab8lJjuludkv6sTp6ca9u64yCk6mFVElgQfrrUim
	Ay6jM6b7JodxhUO52OzUU/jRvvlni9AesqynmEsO2WbuwF3fQ1FrejEdrr08AECGKrL+iKmcXEb
	X9QoRQryereiuBY=
X-Received: by 2002:a05:6a00:854:b0:81e:81fb:b392 with SMTP id
 d2e1a72fcca58-82a196d9795mr9102209b3a.11.1773590227286; Sun, 15 Mar 2026
 08:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307212058.169511-1-jhs@mojatatu.com> <20260310184713.7e810431@kernel.org>
 <CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com>
 <20260311175249.54abe1b6@kernel.org> <CAM0EoMnv14pSaJWW3ZQuegkbQEqqye0zp0-_tCaOEWEg=C3xCQ@mail.gmail.com>
 <20260312165113.773a5f44@kernel.org> <CAM0EoMm0dMRKJyfCH80G=q4PnnTzzKVRvSrAU204FFKMn9NOtQ@mail.gmail.com>
 <CAM0EoM=KinOanha9nKJ=GyT2FU_o3Hg-tY5fWDfFO+PBuQfXpA@mail.gmail.com> <20260314080004.3e8575d8@kernel.org>
In-Reply-To: <20260314080004.3e8575d8@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 15 Mar 2026 11:56:56 -0400
X-Gm-Features: AaiRm51rmZBzVnloy_8xdC3vuhjPorclFaCvP3TTlZ3O1BeMklnatfJOc6SBkho
Message-ID: <CAM0EoMnY7b+wzxCP9Gqso-v7xBKjaA_9FN4OZc2YjifmCvAVsA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot delete
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk, 
	vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com, 
	cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com, 
	km.kim1503@gmail.com, security@kernel.org, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 11:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 13 Mar 2026 15:36:28 -0400 Jamal Hadi Salim wrote:
> > In this specific example, the issue is that the classifier code path
> > can't release the rtnl_lock while the qdisc's refcnt is bigger than 1.
> >
> > Does this make more sense?
> > The reason we went with the "mark for delete" approach is at time x+3
> > the "qdisc add" wont be able to find this qdisc. This is the common
> > observed pattern - for example described in the commit message where
> > we get have a slightly different flow with "qdisc del" before "filter
> > add".
>
> Maybe a (completely untested) diff will help illustrate my thinking
> better than words:
>

Dont have much time today - but will try in the upcoming days.

cheers,
jamal

> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index 99ac747b7906..c13c9e8619e4 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -27,6 +27,9 @@ void unregister_tcf_proto_ops(struct tcf_proto_ops *ops=
);
>  #define NET_CLS_ALIAS_PREFIX "net-cls-"
>  #define MODULE_ALIAS_NET_CLS(kind)     MODULE_ALIAS(NET_CLS_ALIAS_PREFIX=
 kind)
>
> +extern char *rtnl_load_mod;
> +void rtnl_load_mod_check(void);
> +
>  struct tcf_block_ext_info {
>         enum flow_block_binder_type binder_type;
>         tcf_chain_head_change_t *chain_head_change;
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 332fd9695e54..c21dd2e36592 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1368,11 +1368,15 @@ struct tc_action_ops *tc_action_load_ops(struct n=
lattr *nla, u32 flags,
>  #ifdef CONFIG_MODULES
>                 bool rtnl_held =3D !(flags & TCA_ACT_FLAGS_NO_RTNL);
>
> -               if (rtnl_held)
> -                       rtnl_unlock();
> +               if (rtnl_held) {
> +                       if (WARN_ON_ONCE(rtnl_load_mod))
> +                               return ERR_PTR(-EINVAL);
> +                       rtnl_load_mod =3D kasprintf(GFP_KERNEL,
> +                                                 NET_ACT_ALIAS_PREFIX "%=
s",
> +                                                 act_name);
> +                       return ERR_PTR(-EAGAIN);
> +               }
>                 request_module(NET_ACT_ALIAS_PREFIX "%s", act_name);
> -               if (rtnl_held)
> -                       rtnl_lock();
>
>                 a_o =3D tc_lookup_action_n(act_name);
>
> @@ -2107,6 +2111,9 @@ static int tcf_action_add(struct net *net, struct n=
lattr *nla,
>                                       &attr_size, flags, 0, extack);
>                 if (ret !=3D -EAGAIN)
>                         break;
> +               rtnl_unlock();
> +               rtnl_load_mod_check();
> +               rtnl_lock();
>         }
>
>         if (ret < 0)
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 4829c27446e3..1b0f762d6e4b 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -46,6 +46,19 @@
>  /* The list of all installed classifier types */
>  static LIST_HEAD(tcf_proto_base);
>
> +char *rtnl_load_mod;
> +
> +void rtnl_load_mod_check(void)
> +{
> +       char *mod =3D rtnl_load_mod;
> +
> +       if (mod) {
> +               rtnl_load_mod =3D NULL;
> +               request_module("%s", mod);
> +               kfree(mod);
> +       }
> +}
> +
>  /* Protects list of registered TC modules. It is pure SMP lock. */
>  static DEFINE_RWLOCK(cls_mod_lock);
>
> @@ -255,17 +268,15 @@ tcf_proto_lookup_ops(const char *kind, bool rtnl_he=
ld,
>         if (ops)
>                 return ops;
>  #ifdef CONFIG_MODULES
> -       if (rtnl_held)
> -               rtnl_unlock();
> +       if (rtnl_held) {
> +               if (WARN_ON_ONCE(rtnl_load_mod))
> +                       return ERR_PTR(-EINVAL);
> +               rtnl_load_mod =3D kasprintf(GFP_KERNEL,
> +                                         NET_CLS_ALIAS_PREFIX "%s", kind=
);
> +               return ERR_PTR(-EAGAIN);
> +       }
>         request_module(NET_CLS_ALIAS_PREFIX "%s", kind);
> -       if (rtnl_held)
> -               rtnl_lock();
>         ops =3D __tcf_proto_lookup_ops(kind);
> -       /* We dropped the RTNL semaphore in order to perform
> -        * the module load. So, even if we succeeded in loading
> -        * the module we have to replay the request. We indicate
> -        * this using -EAGAIN.
> -        */
>         if (ops) {
>                 module_put(ops->owner);
>                 return ERR_PTR(-EAGAIN);
> @@ -2459,6 +2470,7 @@ static int tc_new_tfilter(struct sk_buff *skb, stru=
ct nlmsghdr *n,
>                  * of target chain.
>                  */
>                 rtnl_held =3D true;
> +               rtnl_load_mod_check();
>                 /* Replay the request. */
>                 goto replay;
>         }
> @@ -3230,9 +3242,13 @@ static int tc_ctl_chain(struct sk_buff *skb, struc=
t nlmsghdr *n,
>         tcf_chain_put(chain);
>  errout_block:
>         tcf_block_release(q, block, true);
> -       if (err =3D=3D -EAGAIN)
> +       if (err =3D=3D -EAGAIN) {
> +               rtnl_unlock();
> +               rtnl_load_mod_check();
> +               rtnl_lock();
>                 /* Replay the request. */
>                 goto replay;
> +       }
>         return err;
>
>  errout_block_locked:
