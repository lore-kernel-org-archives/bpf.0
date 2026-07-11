Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0235DA41
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783773380; cv=pass; b=iTxk2MVR9AFPQlzzbI4FX0qodaOUBdFlS10t4sSzSDHXdKuO+BUhL/sLHBzKLS541hRC5/r1w1U0pjAgytWzKBfoJC5NuMJW6E7hQeOWJgOU0350db3vdA0UZEh6OvnfIt/M3WCT8A7O0fdf+xcFKshLIPAyqVOk+kG42n43t3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783773380; c=relaxed/simple;
	bh=SySi6wxUjqMlb54PMbePhqAsSdMDQniN9v3lzfJ0YBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KH1xFdVxIWEHJ7PQsTQm9PnFAjUEhR4fnyZhW2Q5EQrWsO9LXV/OMQP4CHtcg3pXUjPJKJUfYmSJ8hV5yvH0g9OL9DCSGLDdfzn6RDu3hxJCbOHg5SgCOu1YZChR5fKKEo5L2eWFZqjoEp0BjxljhFW/jbmAhfwcVKI8IFafumY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZfkGud36; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfkGud36"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso17037735ad.1
        for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 05:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783773379; cv=none;
        d=google.com; s=arc-20260327;
        b=mqrKoUVAS1cZ0mmJZtP8csae5OAWpJPs22rCcT7KzHl5/Atw8rQHQwLZeK8VKRgqis
         xSvOqLSdUEgrzVntorlXpnLIuzg2Zn8u1adubC7ubEzp1SNPGOsGtqCwwQSEVQxqUs9b
         km0ETuiBt6AMsAb1EpUhihSfvglOvQ6xmLtG/0lo86ZZQWJRaLrpWdt5vXV6AJJVe7rj
         JjxZEVq32qfw5mLlcF8u+q6f6XtbyQdZTXeNtxxURzLIo1d1E43972+ng0luS9HXm3Lw
         ugURBviG2MzDenY6ZgoRe8f8um/8maF49oTVjRsLVUuYNfHwRyPrTyIQRrlJ7qHxkHwc
         lStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p3UIKxrSmu2n2Hpeaq2hgsK+CnJAUQ4ug/QP00PQNO8=;
        fh=ZxRVuc9FEwAa/LeMg4+vNsU1qo3I0dlu/WlkPxN9EfM=;
        b=OIrC3RP4aoSwqC4B2pbDdsDpqXioDN+mDmjRRhMIIO54QjPv2bVxFF0n98goCHU2Sn
         gtLzVERYZ+lyatR9m4zha7QHa4tNqr6SKnHclvMBRSRAJQTv6GdcxCBmSbsgcBtBh0qV
         XbcQ5FgBnPrFgJEkN+16WaxVjCeD2M5oIb70i0I8jMhz9VKjyO3VQ5fHEMU1YRExTffR
         apRe7M9gs6zmgdAkZL5nVaIz4p65PuzM1lgDcmUVCS0Jno5h5N7QKGcOiXhNP2bX3+kB
         eKeuM+myAPA/KRgkYyIRP76XJewKYvBE8eIZB4EENJU5lOfyWRTOPPBpZhEx/0i6tams
         A9GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783773379; x=1784378179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p3UIKxrSmu2n2Hpeaq2hgsK+CnJAUQ4ug/QP00PQNO8=;
        b=ZfkGud36eCIO7m4defjS4plWlPfy3KVLAXT+cc9E410pyS53G8N1LCX6wa987Mp+bX
         uDg9mwNwWvvQ05A7eUI13ETQVn2UTvF4DmICNJoKp+AF5pEdj3HcT9qaDaY/UsSvE/j/
         3xpIuvyMNB25XL4rfwYLHdO1LA9dz7PA+jdbA5X2WVNGylnP0+oJKx+xwQERT91ncZO+
         k2f6WwndE0ZJ6BNmkMV3FfmqLgeANfxutrjtWkmQnh1HV41nzJGS03O+kgYzxWzq8W1X
         +D+7Dcz5mj+N40X/KBFc1IKjO7eqYRcyPK3dm6enGMu6oA6nUZi1YkGH+uy/Jldzzt3y
         OILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783773379; x=1784378179;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p3UIKxrSmu2n2Hpeaq2hgsK+CnJAUQ4ug/QP00PQNO8=;
        b=ku5f0K+wwqEJNZ0RK6VRcEJ5b48FBfECzpBGG/K/kW3vGPFwngKeG6ttT/OhcHIYSe
         Dk8F/P6MJrweFF10uAX5IeWsisTjY8sZsgNL4txMdSfEMkqp4BFDY2C2zwJYqjG6ekxk
         XaG71mtN/Dk+Ovea/T8EipYmHi3ihuQ4lkAsU7t81LZSaJoUoJQhNtmP99bb02WCGkzt
         1QnYvtudvt3jnhB8MnghxMqHokgrEd9Gj6m60wlFqkwA96WCCoy3iZHQT34jnwy72zTc
         7mdhjG8YGdvT60cY7sNwaRNZDKkRs3dgx+W81F/J3DS6MXSjK4+wKnd9EEc+ffnkkZNv
         o8Iw==
X-Forwarded-Encrypted: i=1; AHgh+RphFVIzAH4/skWwxHtHCzu0P2ysNIyCstiVkQonJ2JFI+2VD/4GNwuXWcywgCC2PDh/WOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHOA/R/OgBjBwEgdxbfFgCVVPwFQNXI681hqJ7IxMGO2ayzgP
	FYwnI2D2OFPdZv4hlXLi/B1bx696iaoxV6DK92IR+03JF4HtrwUvYe9WfwxGrF+OY3BG5CAT4HT
	hhcM0TyLc4DKPJAlDBHUKOTIaujAfxZ+GslArB4rE
X-Gm-Gg: AfdE7ck+5clOu7VVrHWgjzyX9hbPBHkweREK0n2284JrsXnx2hrYyoSBCViLPYLcn+F
	ceF2ATTLw5GA8vxGxTfBgxzmyIaY59wWz/ItvfqIFD737d/9n2Zh48VGD0UQ4ZU/Iy2VIJHfZKx
	lHes/cbg+7MzalaUTsgG+Un2rNeg4c3ydZdfC8AXxZ0gobLkfHrHBRVkevRVcizjzN6Oj5OeEYx
	xTFAeB4fAIbyKLBE5TthfXfC2AKAAyCq/TWjD5eY1TeDczX92dV35+482il4ddsXuUWYgobP1RA
	CgCGnBxk3a/+/s2HlZAi5VyNFswzqUieM3QgOarcjc/ATA5feTWGCyhVJeW7YOAoWAY+INnPo8v
	FI2tCoA33uHaLlsTTVajaRuXZqniI9eqe3B/yvJ7TU3afvQAHe2P4
X-Received: by 2002:a05:6a20:72a5:b0:398:6ea8:21d2 with SMTP id
 adf61e73a8af0-3c110a69208mr3046148637.19.1783773378103; Sat, 11 Jul 2026
 05:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>
In-Reply-To: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 11 Jul 2026 05:36:05 -0700
X-Gm-Features: AVVi8CcfTyzxfkzbvbHTzEquulsluAfF-rDOUv_47ONGcdu5G8dIKhY0LEnBX3Q
Message-ID: <CAAVpQUDiLwSYwFStRGpMQkGbm3j8_KJm9LVj0ykV7V3nYQ4YTg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Ben Cressey <ben@cressey.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 5:33=E2=80=AFPM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> reqsk_queue_hash_req() publishes a TCP_NEW_SYN_RECV request_sock onto
> the ehash chain (via inet_ehash_insert(), which drops the bucket lock on
> return) and only afterwards refcount_set()s rsk_refcnt to 3.
>
> Lockless readers such as __inet_lookup_established() account for this by
> using refcount_inc_not_zero(), but bpf_iter_tcp_established_batch() uses
> plain sock_hold() while holding the bucket lock, on the assumption that
> the lock guarantees sk_refcnt > 0. That assumption does not hold for
> request_sock:
>
>   CPU 0                                CPU 1
>   -----                                -----
>   tcp_conn_request()
>    reqsk_queue_hash_req()
>     inet_ehash_insert(req)
>      spin_lock(bucket)
>      __sk_nulls_add_node_rcu(req)      // rsk_refcnt =3D=3D 0
>      spin_unlock(bucket)
>                                        bpf_iter_tcp_established_batch()
>                                         spin_lock(bucket)
>                                         sock_hold(req)   <-- addition on =
0
>                                         spin_unlock(bucket)
>     refcount_set(&req->rsk_refcnt, 3)  // clobbers saturated value
>
> which surfaces as:
>
>   refcount_t: addition on 0; use-after-free.
>   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x48/0x90, CPU#1
>   Call Trace:
>    bpf_iter_tcp_established_batch+0x14e/0x170
>    bpf_iter_tcp_batch+0x53/0x200
>    bpf_iter_tcp_seq_next+0x27/0x70
>    bpf_seq_read+0x107/0x410
>    vfs_read+0xb9/0x380
>
> refcount_warn_saturate() then saturates the count, the publishing CPU's
> refcount_set() clobbers it, and the socket is left one reference short.
> When the last legitimate owner drops its reference the reqsk is freed
> while still reachable, leading to use-after-free panics in e.g.
> inet_csk_accept() or inet_csk_listen_stop().
>
> This reproduces in seconds with tcp_syncookies=3D0, a handful of threads
> doing connect()/close() to a local listener while others read an
> iter/tcp link in a tight loop.
>
> Use refcount_inc_not_zero() and skip the socket on failure, the same way
> every other ehash walker does. The listening hash is unaffected as
> listeners are always inserted into lhash2 with sk_refcnt >=3D 1, so
> bpf_iter_tcp_listening_batch() is left as-is.
>
> If every matching socket in a bucket is mid-init, end_sk can stay at 0;
> advance to the next bucket in that case rather than terminating the
> whole iteration on a stale batch[0].
>
> Fixes: 04c7820b776f ("bpf: tcp: Bpf iter batching and lock_sock")
> Reviewed-by: Ben Cressey <ben@cressey.dev>
> Assisted-by: Claude:unspecified
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
> ---
>  net/ipv4/tcp_ipv4.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fdc81150ff6c..92342dcc6892 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3074,25 +3074,25 @@ static unsigned int bpf_iter_tcp_established_batc=
h(struct seq_file *seq,
>  {
>         struct bpf_tcp_iter_state *iter =3D seq->private;
>         struct hlist_nulls_node *node;
> -       unsigned int expected =3D 1;
> -       struct sock *sk;
> +       unsigned int expected =3D 0;
> +       struct sock *sk =3D *start_sk;
>
> -       sock_hold(*start_sk);
> -       iter->batch[iter->end_sk++].sk =3D *start_sk;
> -
> -       sk =3D sk_nulls_next(*start_sk);
>         *start_sk =3D NULL;
>         sk_nulls_for_each_from(sk, node) {
> -               if (seq_sk_match(seq, sk)) {
> -                       if (iter->end_sk < iter->max_sk) {
> -                               sock_hold(sk);
> -                               iter->batch[iter->end_sk++].sk =3D sk;
> -                       } else if (!*start_sk) {
> -                               /* Remember where we left off. */
> -                               *start_sk =3D sk;
> -                       }
> -                       expected++;
> +               if (!seq_sk_match(seq, sk))
> +                       continue;
> +               if (iter->end_sk < iter->max_sk) {
> +                       /* reqsk_queue_hash_req() inserts with sk_refcnt =
=3D=3D 0
> +                        * and refcount_set()s it after the bucket lock d=
rops.
> +                        */
> +                       if (unlikely(!refcount_inc_not_zero(&sk->sk_refcn=
t)))
> +                               continue;
> +                       iter->batch[iter->end_sk++].sk =3D sk;
> +               } else if (!*start_sk) {
> +                       /* Remember where we left off. */
> +                       *start_sk =3D sk;
>                 }
> +               expected++;

This should be incremented just after seq_sk_match()
(see below)


>         }
>
>         return expected;
> @@ -3129,6 +3129,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_f=
ile *seq)
>         struct sock *sk;
>         int err;
>
> +again:
>         sk =3D bpf_iter_tcp_resume(seq);
>         if (!sk)
>                 return NULL; /* Done */
> @@ -3167,6 +3168,10 @@ static struct sock *bpf_iter_tcp_batch(struct seq_=
file *seq)
>         WARN_ON_ONCE(iter->end_sk !=3D expected);

Let's say the batch array was smaller than the hash chain length
and we reallocate the array based on "expected" w/ the bucket lock.

What happens if refcount_set(..., 3) is called during reallocation ?
bpf_iter_fill_batch() will see the larger "expected", and WARN_ON_ONCE()
will be triggered.


>  done:
>         bpf_iter_tcp_unlock_bucket(seq);
> +       if (unlikely(!iter->end_sk)) {
> +               ++iter->state.bucket;
> +               goto again;
> +       }
>         return iter->batch[0].sk;
>  }
>
>
> ---
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> change-id: 20260619-bpf-iter-tcp-refcnt-107d52b238da
>
> Best regards,
> --
> Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
>
