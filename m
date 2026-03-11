Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA07257849
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205059; cv=pass; b=LZwWXpE0ovDOhX4d47XyZM74oc3ZG/f8VynQbAW35a1gVjQCb5fvzFQz3uvJmz21BtGITBRdiB7YpvP6VdeDK2lef7XhkfJM6XRE8AyVZWN826t4kRzIOYLkMWhATpYFNTgTIPaKJiT3jdlEyUm37d89aupiK1yd3qZ9m1TX7d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205059; c=relaxed/simple;
	bh=tQUkS47wbxvGDRbtPbZgzsO0VSZeaXsZKqGOpWvmQkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2nQ6Y8U59n/U9VKZ0b11FodfQeiSirG2OYLNQNJWxO4n6DK5xZneytMPOr7AhnvaBLmVhi8gQ+KpWP9rfCntcHflR0taq0pTWiiTqBn7l04m7LwP22yONz/IpgCBzRA/OYfn25aEHDCeC1DgLeh2+9c7E/o5YqrjmGjvnL+p9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWiDsEEi; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWiDsEEi"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-127380532eeso955150c88.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 21:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773205057; cv=none;
        d=google.com; s=arc-20240605;
        b=e95kuoZ3jW8q9q9TiMWFvZ37g0CbF3x1TvZ5Qef2MODlLEfmIPkGym5ZpNQDYYKi55
         oLYPVzq70cb4wuM5ByJJicqzbadvpCf2Gjy4cWWULrXALp1StnVVF6Ug5DVUFZkHqwdd
         dGeeUyJSfMVLpOG3wjBpx5pdmU9qTJLMs/z64sKQgSLdcRwf7EBhIatl9FnKhHL3crsN
         ddYZZjczRAqFLgwcKiUCmNIrC/Alwo33QPsdIV1qG8A2jb8tUh8GCU0qtn+qE7/gN7Kr
         k/GpvkE5LuURBQnbBItRPjmT7XKnGdo6FpRrNZ5gYi2qhqjoSmituxoFDgW+GvrxB5ku
         8urA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ag1Q7iiQTmW1LyMcYibmgdn2+ZlfPyr/1PUridSt8jo=;
        fh=Q7Y/3uGbuNbLkoCEfyDXKgFdI25/I11uxVhYD//QAn0=;
        b=kSPuSbYQuh/uOcz37Yg3ol6DxW4OqJGnGIxMHE5HCE4jPV9d213l+1FjB8EiMpzd7X
         7sXOsNCcs+29IdCpusl3PTlFaeTmrjGB03zPLI6RiaEEmjo9q4gFz48bhMJZxBWOHkOJ
         EKQ2O8hiTQdkd5mTJE7BRm1tdblASb/We41q6gpdHw9lOCVuL2QcTA4gaGkQ3iXLNc8X
         l9Bx3Db6ryyIQu5ga4+7ve2Y9HGjQjej0vfMLjhU3RmHNLQlNOKCOM44sft1oQILeBSi
         MDmAXm9BDP1G05Wz9mMJFb3OjeKeOgcrqdxEkdg0wOWoC5p2aJAXKZumnWUSw/xJwySL
         TwRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773205057; x=1773809857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag1Q7iiQTmW1LyMcYibmgdn2+ZlfPyr/1PUridSt8jo=;
        b=fWiDsEEiurloA2OPu/hA7DT4oA/Ty2jTmRrMNCl2H4+/oqq1o6x3oupb8fX4g7DJ+R
         K0lnaOXOnjNJBUf7mfiCkj+i/lusgOF/kwTlESfhj/FT/9+bO/fgYZXpnPKG37SHHSTW
         bf1nN/0VfsgITSYaxC5MTtAOchHoAxZkyddT4m5lRxtWNXVL0LUhKK9QhAmwXCIfMi6+
         GIwFOVWmkSvW0+gd3Pxr6cdHKhujg67rymMHtPd3ql4A6HrXEdH9ywwgANcLa6uSAqj7
         JZrOrEV0/PhGa49U7GCVGKgybiJt6A8cV+YqUmgWx2yG3R7kv4sm+LOdKiix+16vMDaZ
         M08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773205057; x=1773809857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ag1Q7iiQTmW1LyMcYibmgdn2+ZlfPyr/1PUridSt8jo=;
        b=Wsp5gego1VD2LkKbFixZdx4K4wyMavJqJ17fvf9g6lYIYJTqQDGO+4G2BCP2RO42mb
         PvSTxEwegUElXgTYdY8REJK35+7iCBJ07CBqYvkppJ9Qg2BEGyry68XpE/3fPUbG9BUC
         jXpQBQT3PzuqWURzmkxL6om1eiH0PRp7LO+tgJRDQLqsZwoKyGELxbwBT3xkbtxuV7/K
         MsnDzrPk2ZCCmojGEZDpj+q5hIe00XRa6Yd1uv9ZkYCizWfKdM0RK+VBnU+vV3mqR061
         sBslRvBjMBwurS//Sk30Fxsw9XgMRW/UmZruD32EiGMbxS3cr7Fg7rOqvaa/PgF+nVeL
         UcBg==
X-Forwarded-Encrypted: i=1; AJvYcCWuUf2RYYBQ03OFVWyNyHH1VXaFuR9dDKKLiDcrb4lvwtgFc+XKThczHewDPaTCiKVpNwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbsX4x7UMIakJIKF2tpSzAs2QBTZu8ujZM+x9zcs4RG5V6NkM9
	EVKQ9tgifJRTymAjuu6d5TTuuKbtQPPBjgETtTvbVSqX1bRwQ3vMNLvQG5udR/o6GpZfk8xVcsX
	UyisdbAllo7i+frF8ZoopbMFZrxzVZEa8XMM/yeSm
X-Gm-Gg: ATEYQzzH1ZJe4zm6pNZlnwGJg40PTRaS+RA7zRxggYNKpt8kR/X+SDzvy3QRkBHvGsG
	nPQsNxHt2gTQesj0PcYfDl+gb9rWB/RLqCh1IoT5/zvhcIpWAKq2ZidHKtIgESiWqSqEiax3irz
	QkiW+bBf4ljM27o0o+YYjnT1+s0LDfYi8sTW157S6fTYxbybjmUSZrd60FHs8jaPE34PEWE8sOe
	l/mlB2n1u92CNhXRQFgoHQ0LtoOkWHugsKKpGRGyxaJN3f/G6Og41QMRTnquINRdyRqTBjH/mYy
	dwPmJ2GXgBZci9NKl8lAaN7GGvrCoHCruLwqEQ+4mtYVYbYeuv41LdnDTkXQ9DE7kPBQAbOiZkI
	e4+OKtg==
X-Received: by 2002:a05:7022:6992:b0:128:ce44:be8f with SMTP id
 a92af1059eb24-128e779f435mr631048c88.2.1773205056860; Tue, 10 Mar 2026
 21:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-2-2f0c7410c523@rbox.co>
 <CAAVpQUCdzpwbu=fOrwCnaCFuD3U5SL73PB2nroqgUB4QdJ69og@mail.gmail.com>
 <3bf84a79-7335-483c-b629-2437e360387d@rbox.co> <CAAVpQUB8fvyKSQ8UjBs4=FHmz0iME4SO=3CviS_dCzLNTLkjHQ@mail.gmail.com>
In-Reply-To: <CAAVpQUB8fvyKSQ8UjBs4=FHmz0iME4SO=3CviS_dCzLNTLkjHQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 21:57:25 -0700
X-Gm-Features: AaiRm50dWB64huQ0DmvsBEvKGoF1e3fB43KjjwJ89Hmeo2RR70RzYJdAJbH7aDE
Message-ID: <CAAVpQUADj21wNH=OkUVxW81Zf8RPd1TxLgcfU1wVbWXDY+W6Sg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/5] bpf, sockmap: Use sock_map_sk_{acquire,release}()
 where open-coded
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Fri, Mar 6, 2026 at 6:05=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote=
:
> >
> > On 3/6/26 06:44, Kuniyuki Iwashima wrote:
> > > On Thu, Mar 5, 2026 at 3:32=E2=80=AFPM Michal Luczaj <mhal@rbox.co> w=
rote:
> > >>
> > >> Instead of repeating the same (un)locking pattern, reuse
> > >> sock_map_sk_{acquire,release}(). This centralizes the code and makes=
 it
> > >> easier to adapt sockmap to af_unix-specific locking.
> > >>
> > >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > >> ---
> > >>  net/core/sock_map.c | 21 +++++++--------------
> > >>  1 file changed, 7 insertions(+), 14 deletions(-)
> > >>
> > >> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> > >> index 02a68be3002a..7ba6a7f24ccd 100644
> > >> --- a/net/core/sock_map.c
> > >> +++ b/net/core/sock_map.c
> > >> @@ -353,11 +353,9 @@ static void sock_map_free(struct bpf_map *map)
> > >>                 sk =3D xchg(psk, NULL);
> > >>                 if (sk) {
> > >>                         sock_hold(sk);
> > >> -                       lock_sock(sk);
> > >> -                       rcu_read_lock();
> > >> +                       sock_map_sk_acquire(sk);
> > >>                         sock_map_unref(sk, psk);
> > >> -                       rcu_read_unlock();
> > >> -                       release_sock(sk);
> > >> +                       sock_map_sk_release(sk);
> > >>                         sock_put(sk);
> > >>                 }
> > >>         }
> > >> @@ -1176,11 +1174,9 @@ static void sock_hash_free(struct bpf_map *ma=
p)
> > >>                  */
> > >>                 hlist_for_each_entry_safe(elem, node, &unlink_list, =
node) {
> > >>                         hlist_del(&elem->node);
> > >> -                       lock_sock(elem->sk);
> > >> -                       rcu_read_lock();
> > >> +                       sock_map_sk_acquire(elem->sk);
> > >>                         sock_map_unref(elem->sk, elem);
> > >> -                       rcu_read_unlock();
> > >> -                       release_sock(elem->sk);
> > >> +                       sock_map_sk_release(elem->sk);
> > >>                         sock_put(elem->sk);
> > >>                         sock_hash_free_elem(htab, elem);
> > >>                 }
> > >> @@ -1676,8 +1672,7 @@ void sock_map_close(struct sock *sk, long time=
out)
> > >>         void (*saved_close)(struct sock *sk, long timeout);
> > >>         struct sk_psock *psock;
> > >>
> > >> -       lock_sock(sk);
> > >> -       rcu_read_lock();
> > >> +       sock_map_sk_acquire(sk);
> > >>         psock =3D sk_psock(sk);
> > >>         if (likely(psock)) {
> > >>                 saved_close =3D psock->saved_close;
> > >> @@ -1685,16 +1680,14 @@ void sock_map_close(struct sock *sk, long ti=
meout)
> > >>                 psock =3D sk_psock_get(sk);
> > >>                 if (unlikely(!psock))
> > >>                         goto no_psock;
> > >> -               rcu_read_unlock();
> > >>                 sk_psock_stop(psock);
> > >> -               release_sock(sk);
> > >> +               sock_map_sk_release(sk);
> > >
> > > I think sk_psock_stop() was intentionally put outside
> > > of rcu_read_lock() to not extend the grace period
> > > unnecessarily. e.g. while + __sk_msg_free().
> > >
> > > Maybe add __sock_map_sk_release() without
> > > rcu_read_unlock() ?
> >
> > How about dropping this patch completely? The more I stare at it, I see=
 no
> > reason why af_unix state lock would matter in any of these places.
>
> I agree.  Actually, once it's held, it can be released right away.
> The lock is only to ensure that peer is set after checking
> TCP_ESTABLISHED, but it continues holding unix_state_lock()
> unnecessarily long.
>
> Honestly I prefer Martin's idea, using unix_peer_get() in
> unix_stream_bpf_update_proto().

Pondering again, I'm leaning to towards my initial approach,
just null check for peer, which allows bpf_iter to acquire
unix_state_lock() and make sure the socket is alive.
(still lock_sock() is needed for bpf_setsockopt())

The check is lightweight and SOCKMAP does not need to
hold the lock unnecessarily, and we can provide stable
result to bpf_iter.

IOW, if we hold unix_state_lock() in the SOCKMAP path
(even unix_peer_get()), we cannot use unix_state_lock()
for bpf_iter and lose stability since it will trigger dead lock.
