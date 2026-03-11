Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C0371055
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246176; cv=pass; b=KJn+1HdkRaxgnqyBa8tvozRZNMo2C1LYv1rJ5l51dlJ8Px+4Uwu1P61diXY15ZQhPufK0bGeVogUPhYormqdI0EnWb3NcwOfQaAloFUsQV3bZ/kHnaNd4+bQ5UXeJStq0Rk6sKpSS/hDnEKFF8al6LBikCPO0Tx4hxilJptQGv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246176; c=relaxed/simple;
	bh=/8jX/0nXFpkyhyrW+LSOBtcRnALE1ajFmbVXm3b0yVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLavDB25eKpXNRf77JxC7T9Qo78hxglfz51R9HjlAypPKIoVBl30MGYN2+FCFDgbUqQgT1AGvzpM1NXDt8HWS+96g/j7voo3ddboH+mfijPsdOC+UrYuxyyox5juFRw4er3GrLl6DnsR2UVQ4fYtYWE/qFNr+o89OlMvEhj2+wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=yFgxRSI/; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="yFgxRSI/"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829ac4670c4so76042b3a.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773246173; cv=none;
        d=google.com; s=arc-20240605;
        b=k9SBx0Dom7fCYglgGxd8NsZsiBQT37aFHA36DB/K60mpm9A5EB8eLgax/bKNkhBjPI
         7+BMUNdyNoFD+niiaJ4rcEddp2f92pwXDlIPhGjqUih+EGUVVRMwkHIP41i89qg7x5iu
         zoneiVsezvIf4xY6H39oXtLlDd2QS1i2KDuukZMCXsXdg9PeGdkAckz6yxlZ3M6dGYbp
         ZbyHlaTOH95KF1BEXPM+bA3jC1Fp6arReRDnZ78jX/g/cWGWnWeN4TMLdTSQBqbXW+MU
         Fyzu9QjI0yKmM/FUaoGA3x7VlzETvJBjqRQecxKrnp4HYpMjeAk27bXF6T3e80rY/a3y
         vr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vfY7z/mH1QCzKBvw7XY9whOUf9+5X6AiAqhhH3gD6M4=;
        fh=Yj9eI1yNVzXukKFNGD8dWxziBO1Y3p+cgTIS+oUh/JI=;
        b=IsmQp0duIZS2WPNn67HlNs3I4dqRbYMCsIOOJgsohY0lLVis/PmoR9JCJ2Q9nVZilN
         05TftilcQ775s89A+GwZx67GH7d+VG2mYuReX9JMShZqGZhlINE47TF7fG68A8NGoSkf
         a5SbMZWZ59M1354FvbvCdr3Tyub8L4dgbyD8nVjrF+nTZsgihAU31VJ0Tck2xvQLdYZF
         Grple1huRgom6N1mxrwKXZd97z8lcZ7E9xyLfihfPVdWc8WiaH3IOm9q4Lcp0y34tcFm
         V6c5jac/nSdfP/hQB3RjTbWpmfni5hzS8gIS18GPP3MPT9vg9U/WOqlkeOMOte43QhTp
         7UHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773246173; x=1773850973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfY7z/mH1QCzKBvw7XY9whOUf9+5X6AiAqhhH3gD6M4=;
        b=yFgxRSI/Zh6RIo4oRK2m59I1tVQFN3wpCh7/78HRUTkRQcFJHz1Krl52pltuaAfoJm
         zHBspXvHVt9uOVXy5AvbLLFy2tMgPOmlnDjCKawLT4D5b52rq2dvy/djjKszB7VTWF4o
         4jJWNMatb7YoUGHnwbdlFBz2Ff5HxySx639j57WalC7zam31UkDnLt9NtZ+HCU4TwC4q
         IJSYFhKgtzZ1Q3Sqxx8tnCuRaXuQqA5IjhBWicIja4E0WfV+8ujLjudWTylkbEJRI7Qi
         TYHUdRkuxgvGT3mft8Yc2qb3f6BP1xHB/VV/q6Kg+3oCXsOj7PhuuNRV6LjTQcdlLcDP
         0Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773246173; x=1773850973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vfY7z/mH1QCzKBvw7XY9whOUf9+5X6AiAqhhH3gD6M4=;
        b=mFuLtyDjG5y4PGIct2k0EskEntq34LB5uaDdfzB2tx6eOCQLfaC2ToYZ1/9yyB/pqt
         dJoa92EW4fLkEKusWiQU4Phj+DRD7LsozgEQukyS0ewAefveO2cLZMK1hcMjSsArmzcY
         WEiwdGy9dhOPJx3OxOLi6BYHaAP8UlhotT9cwVaHR7M24NPSdhcoxnTyUUBjBm0I73pt
         gYkSN4SU3dy91y41OSkHMlp84LCmcAqtyn3xWZNnQKZNWKr8e2VbrPix4RRJlcTFjvlf
         f2BRApARQlphmJlov6Yvepdn+kFixUIAdPhf8/Vj5EDNUyyxWPy6NQP7dF6+ph+yKP0T
         MWmA==
X-Forwarded-Encrypted: i=1; AJvYcCWl2/DNRQbTm8Q4/VVSwAKgAteL41iM7V8XYPDLZsa/9jiIY80fhY7eL8UQuXpmHw1zZtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUG/QDLLW3VGIbamizP8jUSCS4h6xzuhCJ1ri4ts0K0QHueME
	G9uLnKuW9f89nFACpO3mx1tjBbnafU8zVOM0hBsAvooJFOJXeU8/ACN8L2waPwyiShA4VqKTh/I
	jVqeJJaEVw0mn9rCdYLkmgj5dglu7zsRJqpDc4mCG
X-Gm-Gg: ATEYQzzxk0vIlbf9K0myR4x7nImY7SszEE5nZYBlir8N4uRbkPIojC526JnrdAkQt94
	Ulbo0sjEN5v0Imd+HyOeToy2sbAeZJEJP/wajzISbfNFtvz6UWp4r8zpd9u9GBpNF+/61c8vsiU
	S4EJtmFqI7MmPuB711J5dvGrhOKRc1TJ/XgOb7mfSj1BNuUVgP26W25UyRWwE7s7dYGYBYavF9y
	rZ6PLHtK2+kLxfEFwU9hx5RYRX819pYYr6IRQjyZDKJX7AemQrKoKYvsJLIHGyjdUG9sTzSkxTz
	BXBPAmavCU4pL5MKpIZ9UGSCfw==
X-Received: by 2002:a05:6a00:7603:b0:829:9a7b:db84 with SMTP id
 d2e1a72fcca58-829f715d0c1mr2313680b3a.49.1773246172868; Wed, 11 Mar 2026
 09:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307212058.169511-1-jhs@mojatatu.com> <20260310184713.7e810431@kernel.org>
In-Reply-To: <20260310184713.7e810431@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 11 Mar 2026 12:22:41 -0400
X-Gm-Features: AaiRm52amjkmnAH6dCMjUuecqHixg9RGz4S-GvYmjS08m4Y_7VN4P7VgDYfbo_8
Message-ID: <CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com>
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

On Tue, Mar 10, 2026 at 9:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat,  7 Mar 2026 16:20:58 -0500 Jamal Hadi Salim wrote:
> > Note: We tried a couple of different approaches that had smaller code
> > footprint but were a bit fugly. The first approach was to use recursion
> > on the qdisc hash table to iterate the descendants of the qdisc; howeve=
r,
> > the challenge here is if the graph depth is "high" - we may overflow th=
e
> > stack. The second approach was to use a breadth first search to achieve
> > the same goal; the challenge here was it was a quadratic algorithm.
>
> Lots of complexity when realistically only ingress/clsact support
> the unlocked operations. Can we not just take rtnl before the
> references and not bother all the real qdiscs with this @#%$ ?
> (diff just to illustrate the point not even compiled)
>

Two of the several (I think 4!) patches we had took a similar path. I
am trying to remember at least one variant was bad for performance and
the other was unstable. Let's see if we can revive it and take a
closer look. BTW - none were pretty, it was maybe half the lines of
code but touched many things.

cheers,
jamal

> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 4829c27446e3..21b461f3323d 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -2255,6 +2255,7 @@ static int tc_new_tfilter(struct sk_buff *skb, stru=
ct nlmsghdr *n,
>         int err;
>         int tp_created;
>         bool rtnl_held =3D false;
> +       bool rtnl_take =3D false
>         u32 flags;
>
>  replay:
> @@ -2290,11 +2291,17 @@ static int tc_new_tfilter(struct sk_buff *skb, st=
ruct nlmsghdr *n,
>                 }
>         }
>
> +       /* Realistically only INGRESS supports unlocked ops */
> +       if (parent !=3D TC_H_INGRESS) {
> +               rtnl_held =3D true;
> +               rtnl_lock();
> +       }
> +
>         /* Find head of filter chain. */
>
>         err =3D __tcf_qdisc_find(net, &q, &parent, t->tcm_ifindex, false,=
 extack);
>         if (err)
> -               return err;
> +               goto errout;
>
>         if (tcf_proto_check_kind(tca[TCA_KIND], name)) {
>                 NL_SET_ERR_MSG(extack, "Specified TC filter name too long=
");
> @@ -2306,11 +2313,12 @@ static int tc_new_tfilter(struct sk_buff *skb, st=
ruct nlmsghdr *n,
>          * block is shared (no qdisc found), qdisc is not unlocked, class=
ifier
>          * type is not specified, classifier is not unlocked.
>          */
> -       if (rtnl_held ||
> +       if (rtnl_take ||
>             (q && !(q->ops->cl_ops->flags & QDISC_CLASS_OPS_DOIT_UNLOCKED=
)) ||
>             !tcf_proto_is_unlocked(name)) {
> +               if (!rtnl_held)
> +                       rtnl_lock();
>                 rtnl_held =3D true;
> -               rtnl_lock();
>         }
>
>         err =3D __tcf_qdisc_cl_find(q, parent, &cl, t->tcm_ifindex, extac=
k);
> @@ -2451,17 +2459,16 @@ static int tc_new_tfilter(struct sk_buff *skb, st=
ruct nlmsghdr *n,
>         }
>         tcf_block_release(q, block, rtnl_held);
>
> -       if (rtnl_held)
> -               rtnl_unlock();
> -
>         if (err =3D=3D -EAGAIN) {
>                 /* Take rtnl lock in case EAGAIN is caused by concurrent =
flush
>                  * of target chain.
>                  */
> -               rtnl_held =3D true;
> +               rtnl_take =3D true;
>                 /* Replay the request. */
>                 goto replay;
>         }
> +       if (rtnl_held)
> +               rtnl_unlock();
>         return err;
>
>  errout_locked:
