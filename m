Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FF9369229
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 05:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775862; cv=pass; b=La3LmCJ87rhFS/42lcZtOeDSJa08RuEFwS9ZmgYcDhxSOBBAc12KlFlVx+hFGGBybsWxTaYpiQKLr2jqMQkdv1hcI4YWEBJ5W9xeb9pvHaKIunvbLXSy7ZfTzvKlZu4Uu4XFfF0eFiQ+sn+78CnUqOSFjyGJe5y2/idlvqWTRrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775862; c=relaxed/simple;
	bh=PSltAUW3Pbszw31Un6mmbj8jIMad2C1Y1xk6vP+XBsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oz1bPPPObEc8Ns1txWVEPVH76AVX/M9T6SYqo8cBpW8ZSDmvI7LHF/0RezFeU5vdlHOaOAGYeVxm39BL/6kXold2KfrOy6M6FBf3VJQ+1jEszhJ+nfsskj7Qq9lxHbcPqzzGOJxw3yiGSrwJz5gG1vLkxAzL1j9GJQ/PbZ5rmSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJ64QPdN; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJ64QPdN"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12776bebe9fso8578555c88.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 21:44:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772775859; cv=none;
        d=google.com; s=arc-20240605;
        b=H+/6Wht0AQ2C1Vh8XvDGMHzbe1XqJb2qwoUHFnTkyJcPajixNSyAazjAZYfYSTvNc2
         qW62RYVrrE3fSIyc89VriM0bgN7snp4REeDWxm4GFPJkiypF9WJRo2W+N2HHJlUaqDMz
         7NlatCtLD8yXdxnfOAEx6f5Thlp/JDe0dL2hK7/eGPsCjX1ZkQloV+7OCtq3sJFtwqAB
         J00HOtRTiGzAt85thYcxWHoQOEgf4tQbU+gAYLDVsHoR7cuEhZ9wrRRFXdU+XeFuSwOH
         hZb24gMQQcF+zRlSz5v5OAMkdYay4MlA6iM+pyb0/QhHMQUICFMxdS+2/yRlkXe+aEnB
         0ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tyBv9EeX3mFY/3tVDfQWJsxTKxsHkm5c9r8R+TELfok=;
        fh=2/7SJyG/N++8OFf6qXycI08mPlvvShkF8h0VD6r6V/o=;
        b=SlxFTIiWitpJlvjhmXJmr91DpLjmi6bPbqmRR8M6EEOLhyR/GETuLiLM/bfMve30mU
         iQrPQ4mrJsBGV+/7EulZZY63O1ZiVK13z2A4JQBkUoL3J454sbllmX+YZyo9LwNSrosP
         QbrTFDBvnKGrXyQM91x5zRj9DADx6sG9oRdlrGyGo4X+Jy6pNnFrEbvLm0pwYVhgK7nJ
         hh7LIE/DkhytoP6WTvcWl+sCUS16avcJdjENO9Arm8wJ8qcBv9UnTtxLJf09Qee9hdJm
         5IioZm2ItXdQuZ9g+SNuZq5msWrI6CebJ/pVUOnOlGM9BZmqKj7EKzAjvZXjhyXQOq/Z
         x1Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772775859; x=1773380659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyBv9EeX3mFY/3tVDfQWJsxTKxsHkm5c9r8R+TELfok=;
        b=tJ64QPdNkYMrwF6kswOu29tm1VHNA77QBY/+JXz5SaKEWEitVwvvAVp5cvWhcawhIH
         O6NoTmEBJb+sck6Azjo33BI8JpNA8Ml7zmwUXrxb2PCS0quICCPmN2ZMgkjCSiGRg9j6
         9FJLF7iR59luWOqtdYK5cWG65V6P9/EpWFGEhBiJjQx5aBq3PvyXHNzrRcYbYxA1QsK8
         6wF1Y37Bi6dTpqpUZgrbSTj8O3ghTdhoIPvNMd5YIRWk79ildQK83VaNaNE6iU3vgxY9
         KtOM8FsaN08/FY+HkariIl6RVMHBH2MjBQFJdTmkVO2CXSEG4kcFPhS6CwKRMfQQJwL7
         gBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772775859; x=1773380659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tyBv9EeX3mFY/3tVDfQWJsxTKxsHkm5c9r8R+TELfok=;
        b=R0Qvqx5VmycK0frZpWlexSMxG7uG5hpc/LzrGGtnTPmDT5VtHc9o3l5q3hRT6/GIme
         nWkt/OYJaFTvI7XV/0vOT5spaHGuKWIHA4DUtp7xyrqvfkH87ZG+wQp/uLOohpEpWG19
         mMsnkfpf1BXno76ygMt0ExjPuA8sJkJKGuOotk1SD8Ad5y2JaZmoMMYN/r91t+RycrLa
         Ld6raMHfnipbcKKB1CStiNvFIqCtF2kDg3bw5Y9ZyYuIPYpG2wbWRhA+FsNOni5O8OBc
         abV3TGQ/zR1q5T3JwaDpP/Kaw6ycfOIIPWUZ/xf9JIIReQb84YqCBtSFKxgmYJ3HN3Hv
         z6Mw==
X-Forwarded-Encrypted: i=1; AJvYcCV4iPlr4sx4oy3N5MM7SEtfP7pdxozgMrWUDqpO+XcZ1VbPbVwlmJ2nn9wrrSx0c4CckHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtuS1JcnkM2Bjxe/7zPijGyzGu31cfatSiS1TsHqnBS1gx0jzS
	Uzo85bg9jh7CPmdCZjflCFELAv+8Y3nEfp3i+k71vzxApFlA70QQsIA1H5OIYzCr6V85fd6pL2Y
	wQWfP2Numdv+0Id6wM3ZXM9yEMJF8tODwn9MUdUrm
X-Gm-Gg: ATEYQzyoYkFOVe3IbcvqGjwtpvoKh/m7OafYGMJqN92KogOJCmdnwFzNdjHElAT1RTl
	Mqd+M5fUie4JXoW/UcKqrbByYQz0t3KwH3I5MslU3ppa/Keg1flt9eytE+ycN0YXNw2F2L+LWfA
	TfP0VCoOYvkJK/g2B8HNNudQdvSFo8i4WwrE0IgQc9282XJUV8pCWnyc3qA6rL7uaR+rhik2zRF
	I0C+66nDd3BHK/fvKNluYYL+CDn1ZQOynUE/AkNJR1ess0t0uMT2onsXXqwVCCteP1VOITs0gxc
	ixO/H67aRVucio9lLnPBpq/j+LGBho5WI7GPZegOP2pBlxoARtStzl/Z1sirKqLEwXQRccJYZXO
	fyEBoQz0=
X-Received: by 2002:a05:7022:105:b0:123:2c98:f65d with SMTP id
 a92af1059eb24-128c2dc0787mr413515c88.13.1772775858405; Thu, 05 Mar 2026
 21:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-2-2f0c7410c523@rbox.co>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-2-2f0c7410c523@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 21:44:07 -0800
X-Gm-Features: AaiRm51r32W8zss6RR5Iwx5AUfeklGwhcZVJvjzKbkwk8LxQ9Tbtfu8f2GRTyJQ
Message-ID: <CAAVpQUCdzpwbu=fOrwCnaCFuD3U5SL73PB2nroqgUB4QdJ69og@mail.gmail.com>
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

On Thu, Mar 5, 2026 at 3:32=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> Instead of repeating the same (un)locking pattern, reuse
> sock_map_sk_{acquire,release}(). This centralizes the code and makes it
> easier to adapt sockmap to af_unix-specific locking.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  net/core/sock_map.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 02a68be3002a..7ba6a7f24ccd 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -353,11 +353,9 @@ static void sock_map_free(struct bpf_map *map)
>                 sk =3D xchg(psk, NULL);
>                 if (sk) {
>                         sock_hold(sk);
> -                       lock_sock(sk);
> -                       rcu_read_lock();
> +                       sock_map_sk_acquire(sk);
>                         sock_map_unref(sk, psk);
> -                       rcu_read_unlock();
> -                       release_sock(sk);
> +                       sock_map_sk_release(sk);
>                         sock_put(sk);
>                 }
>         }
> @@ -1176,11 +1174,9 @@ static void sock_hash_free(struct bpf_map *map)
>                  */
>                 hlist_for_each_entry_safe(elem, node, &unlink_list, node)=
 {
>                         hlist_del(&elem->node);
> -                       lock_sock(elem->sk);
> -                       rcu_read_lock();
> +                       sock_map_sk_acquire(elem->sk);
>                         sock_map_unref(elem->sk, elem);
> -                       rcu_read_unlock();
> -                       release_sock(elem->sk);
> +                       sock_map_sk_release(elem->sk);
>                         sock_put(elem->sk);
>                         sock_hash_free_elem(htab, elem);
>                 }
> @@ -1676,8 +1672,7 @@ void sock_map_close(struct sock *sk, long timeout)
>         void (*saved_close)(struct sock *sk, long timeout);
>         struct sk_psock *psock;
>
> -       lock_sock(sk);
> -       rcu_read_lock();
> +       sock_map_sk_acquire(sk);
>         psock =3D sk_psock(sk);
>         if (likely(psock)) {
>                 saved_close =3D psock->saved_close;
> @@ -1685,16 +1680,14 @@ void sock_map_close(struct sock *sk, long timeout=
)
>                 psock =3D sk_psock_get(sk);
>                 if (unlikely(!psock))
>                         goto no_psock;
> -               rcu_read_unlock();
>                 sk_psock_stop(psock);
> -               release_sock(sk);
> +               sock_map_sk_release(sk);

I think sk_psock_stop() was intentionally put outside
of rcu_read_lock() to not extend the grace period
unnecessarily. e.g. while + __sk_msg_free().

Maybe add __sock_map_sk_release() without
rcu_read_unlock() ?



>                 cancel_delayed_work_sync(&psock->work);
>                 sk_psock_put(sk, psock);
>         } else {
>                 saved_close =3D READ_ONCE(sk->sk_prot)->close;
>  no_psock:
> -               rcu_read_unlock();
> -               release_sock(sk);
> +               sock_map_sk_release(sk);
>         }
>
>         /* Make sure we do not recurse. This is a bug.
>
> --
> 2.52.0
>
