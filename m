Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06933FE0A
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860293; cv=pass; b=bKy4N1IupL5JCPOnbAilZwN6r8tvxhd+/LbCcweCWBrVQKCR3/6fBsqf4jUAG2DDBP4kb/QfGCKAupI8E6iD+1oyBDDqYg/DVWVFW0nzgUyD30kzpLlWyzVpijlBuMwmYln+NqmQTstVjW0uczNhyobd4+3Gx+g4Wb75Idb2OlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860293; c=relaxed/simple;
	bh=ABTHCdzsSmrh99b+XmN/GmmM0NPYS0sr2kFlxYc89VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6ywkVvhQujVnCrbLklnJpwa1H/7gqeShfkDzQoajUxbwPc/vzwovx1IFoPeixRDjoFEKCs2dWuCX40KmX/KZ0V9793VHQINqLhg6yuwxeKhepZPh4jkBxrZ2BamPOf1NcJU2vF5cScYQssdpylaB6a5qVYoz3J37xoZ4Ram7UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tCiCpRDJ; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tCiCpRDJ"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c156c4a9efso3745729eec.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 15:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775860291; cv=none;
        d=google.com; s=arc-20240605;
        b=AjLvZauVGLph0dDNtooemTr6D7onpL7jJC9vlmPZYMk5MIdzO2uFB47wSkweM2fr/X
         atcIw2IQZhev5C3tuFUp5tSAM0xpIUsTsUmecKKWfWN5TGjhFh+thtUZ7IAIaamyxnNd
         jQFFhPVztq8XfVh0WA0Q9NDB1wxpxKn45my5ZvFYn2KRlLOJaWVL5jl+VCFRSqGeToWQ
         xZZnHBEbYkuO+CFmTaBgxH6xjtS0/gbo1RjGEAY49yQy985uYxkmUl1ngGItD25RymZ9
         P1QMwIHkwY1DuGskd1Mv4GotVFKjUW22uC7nKjrRjq2q4zsv9qhX51jJxAyPaSdv6YgH
         Rivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t99f77g5Iy+T7II6EXVKP9R88xfslRKx2eeuK9aCq1Y=;
        fh=m7QKTd4buOsc/7jnay3SIomDOLmToa0VqnS0jZ9/GGQ=;
        b=XAoYjdHwiCQhyuA0RK3gf7Q9zB5FahhsydMXR0yLR6chr1zznc5eB/Uru9dc5LRFGS
         Ms4e/e3+crP2yCJ8PdeUCqjeQ+gKTOBq8c939trsExnirf8xKiMjRqVxKW0A7ISR7kui
         ji6vMGbHQ/7ON30WJHDKolCksbTPaFglXC36boS/f8gyKBQUnnFgBdB4lD/gcFzg+FsO
         iUSqiW9FkhZ9AXkynvgQsJ1s5yxnFrHinnhz2WTjEICdcrHge8ZnSCl0oPGP1IXUl7xY
         l8JQ9Gic/j1SElQzoaiYD8p5BlnMh3Vl1R+ttiHzovgVNWJi2U8Bs6z/X/dYoWPLP12Q
         joIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775860291; x=1776465091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t99f77g5Iy+T7II6EXVKP9R88xfslRKx2eeuK9aCq1Y=;
        b=tCiCpRDJyYClOoLPLIqcT/FtnvyUVc05LsY3A1CbGsGKTSwGpIsbaNNIEqp+YkQpym
         UPPd87pJ/MNhh1B6SDW62rrg2tTkdgc/Z+EYug6Uu/UbNA57pHRwDTQy+/pRs2PXv9PX
         Tm5J2WnnWmDyHy2ylF0s+ywrNQQNagXxh5tjb1BkFIDJ0/tJMXAMayvD41b++2z5yGtG
         +tyKkACgf7lojV9Dq5RsG1VT9DZRvkNvBqJl+LWe5VNuQaDAiESM9koFo353UqA/qo1N
         Djb1l8jFd6vye02DR1pNgwfAt5ryS0uS9MjHsTiEzwFhMTnDAwmD2cLD71XYiLfJ/zE6
         mb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775860291; x=1776465091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t99f77g5Iy+T7II6EXVKP9R88xfslRKx2eeuK9aCq1Y=;
        b=qP/1faTbWeQTNLp5DZLF8dFm3DrBHcTm/HXp2RCD+06V/uVpkOVRazT27MRKw8jJlW
         IyYYjVcUwbI0zQozRFCXSrn+yK7Be5nH84v0nFwNnf5FVZWCcC3RWtdSuBGOA0XtnyAz
         nz+9egfHBK1TTbrD1/3bkn4x5O30B6y9/nvW/du7fkNzJ0zN41vhyZlNU+37RrS67QhV
         +jxaTBeZtIjwgfdfNErGgpRN8+ftVJjgwHF7Amtor9nKbRDfX2xPts6l/D5HUHFgxQoH
         alA6PiQt4x2Ax7XLipTkJwxfUwa+TaZAqpso4Net+EHWce4gufObWanIyvrsuhfjgt/V
         xhtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDyRWe5aoazOGsTnP6ToPNOYGSBUW0dY8Wcj00mU1nHNNOxKXmAKJ5hLxVJ1Ypmss/bIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ccrpunepM219ZVotwFZEzh2he9gIy1tl5ypL2xkSHjO/jNJ3
	ni2DGwhbHlV/QIz01yGYRc7abFnMu9zeAGC3zO4ioJtEhsF1V3XtgeeunRpe7Zw9NRMeKolAp8e
	EbMlfTgdIilgCp1SNtYdszw8wYs8VobVXsU8+2Xuo
X-Gm-Gg: AeBDiesspmvfH4qeBqKR6hO33H9ox9dw7zS9VSCBPxmY/lr8SU+6Oi2LtEGpgQFjRqI
	lhOZkdecMIjTEqF0LZkqOOghRIYY3VEXkZYRdOY5DnvggsEHF9k6VMzny19rNVIGTa5H3KTnup6
	/pshe2SBFm7zDrstUzmoV/FmaISh3e01Iq8ow6fUuauXiqMNV9cfeYwGwdp5UUCzUc9o5lBXDlR
	0cIGF/+Pl96VmT/WWdUszyMbD4+4xhfzlypZOtQB0/lkpsIUdu9FJzl2wYAvqCiw6nRWbxb7WYJ
	NsaeCBou0Pd9TGHqsCG9NcljfsdD/c3RMNY6mRbH2oEFexGQZqJz8875CnwV9P5zTbmUVSfLY7w
	T+UAv3kxYz0NH9o56N1m9gNDAWHtpXXUrN17BZrD0NyQAlcSAd2EhOuDmKQE5
X-Received: by 2002:a05:7022:618:b0:12a:85ef:1e50 with SMTP id
 a92af1059eb24-12c34e899e2mr3180909c88.12.1775860290635; Fri, 10 Apr 2026
 15:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409124129.361777-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260409124129.361777-1-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 10 Apr 2026 15:31:19 -0700
X-Gm-Features: AQROBzBJ1676PQ8NXeBhPLu23LccTqdsnp6r1CI3D2XkGF_QrgIAfVv_LOtgQgA
Message-ID: <CAAVpQUCK-d6YwYW+ZAH5OvmYZmAFnmunnoctdZfFFMhqY26aTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: add missing syncookie statistics for BPF
 custom syncookies
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 5:41=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> 1. Replace IS_ENABLED(CONFIG_BPF) with CONFIG_BPF_SYSCALL for
>    cookie_bpf_ok() and cookie_bpf_check(). CONFIG_BPF is selected by
>    CONFIG_NET unconditionally, so IS_ENABLED(CONFIG_BPF) is always
>    true and provides no real guard. CONFIG_BPF_SYSCALL is the correct
>    config for BPF program functionality.
>
> 2. Remove the CONFIG_BPF_SYSCALL guard around struct bpf_tcp_req_attrs.
>    This struct is referenced by bpf_sk_assign_tcp_reqsk() in
>    net/core/filter.c which is compiled unconditionally, so wrapping
>    the definition in a config guard could cause build failures when
>    CONFIG_BPF_SYSCALL=3Dn.
>
> 3. Fix mismatched declaration of cookie_bpf_check() between the
>    CONFIG_BPF_SYSCALL and stub paths: the real definition takes
>    'struct net *net' but the declaration in the header did not.
>    Add the net parameter to the declaration and all call sites.
>
> 4. Add missing LINUX_MIB_SYNCOOKIESRECV and LINUX_MIB_SYNCOOKIESFAILED
>    statistics in cookie_bpf_check(), so that BPF custom syncookie
>    validation is accounted for in SNMP counters just like the
>    non-BPF path.
>
> Compile-tested with CONFIG_BPF_SYSCALL=3Dy and CONFIG_BPF_SYSCALL
> not set.

Can you add SNMP test in tcp_custom_syncookie.c by checking
the delta before connect_to_fd() and after accept() ?


>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> No functional bug here =E2=80=94 CONFIG_BPF is always enabled under
> CONFIG_NET, so the existing code compiles and works correctly.
> This is a cleanup and improvement, no backport needed.
> ---
>  include/net/tcp.h     |  7 +++----
>  net/ipv4/syncookies.c | 10 +++++++---
>  net/ipv6/syncookies.c |  2 +-
>  3 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6156d1d068e1..570a8836c2ba 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -598,7 +598,6 @@ struct request_sock *cookie_tcp_reqsk_alloc(const str=
uct request_sock_ops *ops,
>                                             struct tcp_options_received *=
tcp_opt,
>                                             int mss, u32 tsoff);
>
> -#if IS_ENABLED(CONFIG_BPF)
>  struct bpf_tcp_req_attrs {
>         u32 rcv_tsval;
>         u32 rcv_tsecr;
> @@ -612,7 +611,6 @@ struct bpf_tcp_req_attrs {
>         u8 usec_ts_ok;
>         u8 reserved[3];
>  };
> -#endif
>
>  #ifdef CONFIG_SYN_COOKIES
>
> @@ -715,13 +713,14 @@ static inline bool cookie_ecn_ok(const struct net *=
net, const struct dst_entry *
>                 dst_feature(dst, RTAX_FEATURE_ECN);
>  }
>
> -#if IS_ENABLED(CONFIG_BPF)
> +#ifdef CONFIG_BPF_SYSCALL
>  static inline bool cookie_bpf_ok(struct sk_buff *skb)
>  {
>         return skb->sk;
>  }
>
> -struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *s=
kb);
> +struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
> +                                     struct sk_buff *skb);
>  #else
>  static inline bool cookie_bpf_ok(struct sk_buff *skb)
>  {
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index f1474598d2c8..d685631438cb 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -295,8 +295,9 @@ static int cookie_tcp_reqsk_init(struct sock *sk, str=
uct sk_buff *skb,
>         return 0;
>  }
>
> -#if IS_ENABLED(CONFIG_BPF)
> -struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *s=
kb)
> +#ifdef CONFIG_BPF_SYSCALL
> +struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
> +                                     struct sk_buff *skb)
>  {
>         struct request_sock *req =3D inet_reqsk(skb->sk);
>
> @@ -306,6 +307,9 @@ struct request_sock *cookie_bpf_check(struct sock *sk=
, struct sk_buff *skb)
>         if (cookie_tcp_reqsk_init(sk, skb, req)) {
>                 reqsk_free(req);
>                 req =3D NULL;
> +               __NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
> +       } else {
> +               __NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
>         }
>
>         return req;
> @@ -419,7 +423,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>                 goto out;
>
>         if (cookie_bpf_ok(skb)) {
> -               req =3D cookie_bpf_check(sk, skb);
> +               req =3D cookie_bpf_check(net, sk, skb);
>         } else {
>                 req =3D cookie_tcp_check(net, sk, skb);
>                 if (IS_ERR(req))
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index 4f6f0d751d6c..111d7a41d957 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -190,7 +190,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
>                 goto out;
>
>         if (cookie_bpf_ok(skb)) {
> -               req =3D cookie_bpf_check(sk, skb);
> +               req =3D cookie_bpf_check(net, sk, skb);
>         } else {
>                 req =3D cookie_tcp_check(net, sk, skb);
>                 if (IS_ERR(req))
> --
> 2.43.0
>
