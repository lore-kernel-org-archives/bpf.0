Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C32D3ECF
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 04:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202637; cv=pass; b=mB2SVL4Ksnqy68KEdbPN+zL5ohqrgEJMFfkaiFT7cUtCWti6TmrPvVk8QkpohP78SIaCUJIbOXbJlYnuxaohO2qB/UFnzq3383N8COSNBAz/rdEy//5pkbkWdJ12yaqIYqrvlvVDP89BQir39Io8/CSYewNBLU2I7zmMg3OfY2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202637; c=relaxed/simple;
	bh=LYiHq7xvyxJ+Ss27zWLVJLl6BJmg3VSJZYbOUkB7Et8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuZOTgfadQeWc4c4F8xTeUzhz153+F+kuQYvslrzqQW4ktQTs1wroUOdhFCVcMRYR7mRTUNeYqAVtVASriytJEBezfssD2ehCeDCng4PdMYTNHsbiNbit43eleQdUsuYFPgj7deRllE1ZFv9m0Jzhpc6MxZR7WH/QP0LLerAEYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QMimxV7c; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QMimxV7c"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271195d2a7so978756c88.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 21:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773202636; cv=none;
        d=google.com; s=arc-20240605;
        b=i3V1NVKUrO8yNAGly0N4JSUmfq/qKfM2waF4T2iVAXZmK3rdT3M5SE6gOg5DZ0GsKY
         XVDR2joL5FGFdKh7qwsO0ZsiCRHMndCPAM8nvRCB9YcT2ch9ZKCddvFVhjNUw4rqotVG
         8+AQju+/FnU0uu9s3wALHVUh3TsqPxYy4Tf1zQCh5KsygmOaU7ACYhM2EFQMMxM69pFC
         X9/rRPdPmVd6Y+ImeU9bYWwr57+aLGs3s5Jzcauy4GBBMZkaXgehDe8wCh/fzDiUzxka
         8FfEfLrini7xRbMUQvw5Ev4dk+sdLtWgmZkheEu5iXEUoPJ0+eAyXyPUJSFNx3KyHAAY
         iYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uENPJmAfC/lW/uop31YwmYzEuEawM2Qvzy11V2b8dlU=;
        fh=nFcRY6cN5MTK5YNK64+hDxkVQ0JFylQRgabbBhsOP9g=;
        b=FadBDWWCImzXUFE1qhxFwt3vIq3wAlrU0OZLLNkitgJDWm/qcFZU+s9fRHgwOHfsrx
         E/OiFg5fg9kWAHvu9vczn95lBo9OkVwKOcrVy4iBWX6YFhhOWAXYz6HlJ5jf+2Q/GsjA
         UesMtWGZDpNB6qPmC1vbtUN6fUthUGFC6gc8jK+rvrOAw4inEaLLzP4QnZCzTGdweRPx
         NNmQp0bGg7jlMsh8987qwAikE1tg51KC/FQ+R54Iq3SlwUKWsKJfVSV1hd7KIwGE4P0g
         b4iNXYRmsgBrg0vSTm6rBTGpVeqs4dfTLSPdDlI2YQ9L+W0ccKpe4YCj7GbUE0x+2iNd
         Ktaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773202636; x=1773807436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uENPJmAfC/lW/uop31YwmYzEuEawM2Qvzy11V2b8dlU=;
        b=QMimxV7cN44WR7B67D/P0dlc58g2v41ig6Vi6/Vu28UGClputTM+0srfxhPBF1ecdI
         s8FlBIqtTHcO0psv2Adb2Nl5KGzYlAOZ5LTARzg1rQSx/hjUeBC1NPsoyvJgz//rwauS
         x0CERTIMVin/l4n8/PnJdbLYd54y0ODkKMGow53WXwPKbilwQwEVCNb+Aqu5PcoIQ94F
         v1MZHhjMsVChNEoE3zvHKH0h9vyplqppy6ZDUOyBWiUp755YaLf3L43E9uEZx+G1VtP7
         nOhnt3slCJoSBpkaoGzEybX+CABPv8TV6+TnV569hDWgXqfDwlKHxpLJeAKHfRo25ZRq
         mWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773202636; x=1773807436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uENPJmAfC/lW/uop31YwmYzEuEawM2Qvzy11V2b8dlU=;
        b=QuXAScd5ZnQz37mjuR8ayvp2aockuPp9Zg9EBFB3kAEb4nuHT0wlHc9Ts0VdxY8jqx
         Mq8ISnZwqSIC/CrFptd8dfTgIVU7lmdUiy3DU5dZgxDxy6EQJ1GhdDxMxBses7wX58Ao
         dH+axIaQCoCwu8EZC5V0ZFMVVOqLe5QrKCfufqW3UlMgVVbOtXL+Zq7bZk3Y8/bQ234D
         2PclpPw5vU1c86sAczJUQkQ0DOgpIN9crAEYuvLJXAu63O2blEcHw+MxXk0rd57YgI+Y
         lHDwtyb80n4sBXBTVCsldsBM7J+9+zC/YPQfvH1NDrkpM2DWHWMkp/c/ayODLplOsjEz
         tSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj7Gt6/C/zPOrJ3PRBsenBdXzESRlU9TvfuoRRqYOPQdiDZ59hNGvLVQFTHsggxcllTj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzpZXJ7luOn2vAZrLCNvf+oxoDk1B7gCMYZJEKbf4iVs68lo4m
	7EF7K5jn5vvJa+GhwIwX8Y97FELmMkg9+kqD3YufjakfJSFtm+r4Aezn9Wt1BRBJ6ltHkJEyfLG
	fkvsGI7BG4CD8t6wDqkV6HFrIU1brP5Ey547Y4Qag
X-Gm-Gg: ATEYQzyU1ieEiieKe3VKHcFfBbD+3IetGN7vcsebp52JtpBFw/BIWWGql21BazgpmOi
	tYtM8ljJUoLECFm4yxSn3MZBDPvWHp7EHL80W5m6nrxLBBc2OVIxTE4iFEyeg/BW6I1Gg75ksJH
	kSNFNUMXPHdR0fVP6r6qBa5ZqWM0pq2d2Kqe7of2l+5EFsre0fR+eeIIYfEJTfMQvZdRuR3RgDp
	O7S57ykSRmy0kw27Whx0gYNRP25Z+7b0428AamL21WOBCvufFgDZUjODoPKdyyDs2Pd4GWDRhJq
	pb7QPIGYAKbNCgNaKobpL2zYl5Vl7rbML8wMSRTSCZS74DbzPE9EdCqxvfDN6ei+FFY6Um8=
X-Received: by 2002:a05:7022:6098:b0:124:9acd:328d with SMTP id
 a92af1059eb24-128e780fa81mr554744c88.22.1773202631872; Tue, 10 Mar 2026
 21:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-2-2f0c7410c523@rbox.co>
 <CAAVpQUCdzpwbu=fOrwCnaCFuD3U5SL73PB2nroqgUB4QdJ69og@mail.gmail.com> <3bf84a79-7335-483c-b629-2437e360387d@rbox.co>
In-Reply-To: <3bf84a79-7335-483c-b629-2437e360387d@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 21:17:00 -0700
X-Gm-Features: AaiRm50MuWsI0wVYgHjWFEMgL9Nc1lx7e73JLHzLZPG4BRs6YGGTA8FHDUMRMq4
Message-ID: <CAAVpQUB8fvyKSQ8UjBs4=FHmz0iME4SO=3CviS_dCzLNTLkjHQ@mail.gmail.com>
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

On Fri, Mar 6, 2026 at 6:05=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 3/6/26 06:44, Kuniyuki Iwashima wrote:
> > On Thu, Mar 5, 2026 at 3:32=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wro=
te:
> >>
> >> Instead of repeating the same (un)locking pattern, reuse
> >> sock_map_sk_{acquire,release}(). This centralizes the code and makes i=
t
> >> easier to adapt sockmap to af_unix-specific locking.
> >>
> >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >> ---
> >>  net/core/sock_map.c | 21 +++++++--------------
> >>  1 file changed, 7 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> >> index 02a68be3002a..7ba6a7f24ccd 100644
> >> --- a/net/core/sock_map.c
> >> +++ b/net/core/sock_map.c
> >> @@ -353,11 +353,9 @@ static void sock_map_free(struct bpf_map *map)
> >>                 sk =3D xchg(psk, NULL);
> >>                 if (sk) {
> >>                         sock_hold(sk);
> >> -                       lock_sock(sk);
> >> -                       rcu_read_lock();
> >> +                       sock_map_sk_acquire(sk);
> >>                         sock_map_unref(sk, psk);
> >> -                       rcu_read_unlock();
> >> -                       release_sock(sk);
> >> +                       sock_map_sk_release(sk);
> >>                         sock_put(sk);
> >>                 }
> >>         }
> >> @@ -1176,11 +1174,9 @@ static void sock_hash_free(struct bpf_map *map)
> >>                  */
> >>                 hlist_for_each_entry_safe(elem, node, &unlink_list, no=
de) {
> >>                         hlist_del(&elem->node);
> >> -                       lock_sock(elem->sk);
> >> -                       rcu_read_lock();
> >> +                       sock_map_sk_acquire(elem->sk);
> >>                         sock_map_unref(elem->sk, elem);
> >> -                       rcu_read_unlock();
> >> -                       release_sock(elem->sk);
> >> +                       sock_map_sk_release(elem->sk);
> >>                         sock_put(elem->sk);
> >>                         sock_hash_free_elem(htab, elem);
> >>                 }
> >> @@ -1676,8 +1672,7 @@ void sock_map_close(struct sock *sk, long timeou=
t)
> >>         void (*saved_close)(struct sock *sk, long timeout);
> >>         struct sk_psock *psock;
> >>
> >> -       lock_sock(sk);
> >> -       rcu_read_lock();
> >> +       sock_map_sk_acquire(sk);
> >>         psock =3D sk_psock(sk);
> >>         if (likely(psock)) {
> >>                 saved_close =3D psock->saved_close;
> >> @@ -1685,16 +1680,14 @@ void sock_map_close(struct sock *sk, long time=
out)
> >>                 psock =3D sk_psock_get(sk);
> >>                 if (unlikely(!psock))
> >>                         goto no_psock;
> >> -               rcu_read_unlock();
> >>                 sk_psock_stop(psock);
> >> -               release_sock(sk);
> >> +               sock_map_sk_release(sk);
> >
> > I think sk_psock_stop() was intentionally put outside
> > of rcu_read_lock() to not extend the grace period
> > unnecessarily. e.g. while + __sk_msg_free().
> >
> > Maybe add __sock_map_sk_release() without
> > rcu_read_unlock() ?
>
> How about dropping this patch completely? The more I stare at it, I see n=
o
> reason why af_unix state lock would matter in any of these places.

I agree.  Actually, once it's held, it can be released right away.
The lock is only to ensure that peer is set after checking
TCP_ESTABLISHED, but it continues holding unix_state_lock()
unnecessarily long.

Honestly I prefer Martin's idea, using unix_peer_get() in
unix_stream_bpf_update_proto().
