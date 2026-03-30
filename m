Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40A23958D
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 23:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913251; cv=pass; b=A2CS0X9MQccK1WtS3tZygoMeC4wIIlmmrXf6QVvJX9rPQMXrz+7q//o7DG8vpVJlkDTfn25lwqO4p68s0ZfHH+6KpPPjxCJqprbzFnFD3QLyqzI+SKbc4OusOZOnbuzVJJ6GO+DL2cTSZBTjgnUEV1mrFohSuxzr9JrMAwwaILg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913251; c=relaxed/simple;
	bh=JgZ5ODvWVLaWmasPVUDL4RPc/Bj5LTDUSgn7bToRISc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iS/n7oVQZ+Q5WSW19f6pJrOkCVPoHJZsqY97oVUfLVYN7ERJ9IcS3i2o0Mvjmk1MdSFglkh4jWyR/LMz1yKGKNxNLXOXQW8nKT2oFXec7TF1hIbHbgyxldnYzh9jEEeNkqFk0TJdrwwgtoWb9teTeiOPyc6UNEMx9eScqmhHlNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c4u6/34G; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4u6/34G"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-127380532eeso1000190c88.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774913249; cv=none;
        d=google.com; s=arc-20240605;
        b=c3ezqIo8/qBYkGj4DSmy4JzW/4x8Bc8cmNy1ZorkFJXnSzupgRYbdBaPa3Tz2DL+sg
         p0vQszjGGvg91pVtCZqOGRWlL4dDZ6Fg+9bip0zuq7+a0D1Mj9tCf4f5Fqwkg+4WETBl
         ycOjLS5S+wDddwBm6EmVErtqanAmIjypoVPO9vP8bxBam3UjURpyQaMwr7OwdI8nzoUm
         xpa9CrgjKEItpdgVbnWs4Jkr/hS09fxb2JG61Ob2iZgQPr4EJsj6o80OLXj4kwsbf75s
         GA21i8pxiS8izJxSg9vk5ppqnpxF5RG0B58aOdJ0dip4k1t9KfUJFwW3nMqb4YwzeN1S
         lMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JgZ5ODvWVLaWmasPVUDL4RPc/Bj5LTDUSgn7bToRISc=;
        fh=QbwN5XLXnmgo6rCv5D0u5Mlsx36mkcXiIxHdZyis1YA=;
        b=MwM7E4h5GVc/R65SIdl8vvUxdM0/7g0xRHaiKKnAPK3RoPzLGFJudF9lbRQdboXiuR
         4IO0HIMr3kSztrPGgGKwtXmR1D1RBmXxi0i+YEeaABFaeJbfac9dHOX7iUlLXMlTXRkM
         HVqZNrlj1fkemNoOxywg6NUzaqQekvwN2yz+XBKH6Fy2Z3/6QQYmS/317GP1nX2uKSQN
         vFMf2P5t5fX/ZaWD/4c4xyWK9rd7GMRSXCgz0CJc364BbQDrcF7O7ub2CYFqa+fOSFW1
         cBFBiBQ78rdksaSyKrLrR2ie64wYV4hmAff80b472iM2XAflEmeaWEGViYiWNvKIdtBi
         z5sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774913249; x=1775518049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgZ5ODvWVLaWmasPVUDL4RPc/Bj5LTDUSgn7bToRISc=;
        b=c4u6/34GSB+Q6/bR6L/zEZNiya6Edo/hZdTdkt7y87eOo8iVj938lYDwF3rEGpxG++
         yQT0bjqm1XkkWvKoQEHVraW1byhXodnCwdaobUa6ebV8HB9/9FX7FU9NDjj9LnZ/1km3
         PTEt4fSPZsyeJDZczkUfhEMpENQYi8WqpB5zvM6ijGO8t1QQiDYdoR/WrtYp99uk6FrT
         KKHNtlTQ41STFSsruGYsWP+aqxJiB4tSc7An3lYc18JYp5/MLam2huym50SJcuhVqHJd
         9N+vZEwiJ2hZ38OxbmFSLRfoqvKC8TvErZmq+DcDtNe/2Kxe8EQQr72x4wpWONDH/0EG
         X/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774913249; x=1775518049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JgZ5ODvWVLaWmasPVUDL4RPc/Bj5LTDUSgn7bToRISc=;
        b=PXb6DY8H5DRYTIcXkiCz8I8NJ6/Jf34Vv4C73rK2U5xQ/jZJc1vTxaWdBIrvYNkjz6
         9SIDbmHeXzWmnBuAS10uB1qpCY7ajsnwPy3h+sg/wVJkKVfZPGBfPIZ86PgbUutgD709
         IJrhsVvub8l77PX0YcKqHfXth8AdHQKAFnMKlqBEJmPjyBm6ntszZzS4ARYVCVJrZaIl
         VCVIQL6agfCyNUnsFVJypxKkw4X2f3iUSyxBTJGTeZBcJCP8KS45Jee3D6N7wpzPxNf8
         Imjq4bhvgo9guAKAH5MPYo4vZs4rsKjE1A2WquJhEKs/c7piSPqqEeyPcuDpsRkVGYkV
         6daA==
X-Forwarded-Encrypted: i=1; AJvYcCU86kLVT/LEvk9vfKXDn+swwhwoERZBfqT9bPQqbD8WjvmxWsDb5sYShL2uV0BPwm2T9Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdHE80ODkA82whoXrwV4iNV35SpO9xHBmJE43p0enQz8q2ovCh
	bCpQlCu0WHReXD+FA1H8OrQ22NaGoCRV13Yeje98lykLatxzjv/aVTsZC+XHojaL0P80DZ2tv/B
	MZB6xOZf9v7feSMFdaqpJ4zfeESNth1zQ7aaFsH4T
X-Gm-Gg: ATEYQzwTYs3Czj/P41vM3OZbxQ+9u/hpVvRAmMynhof8arFe0J9nDjSxkMvAnrJRlbI
	IMqLM13Xrt1Bi9qV9HgRxYKRrBHsEVSwTBe9ZTl86p3VA/VQY1voLk3gKWLdHxijhBw2y1CMtpP
	SpW33f5pAmMdvjU9/GHGZqMS7knEOifFKkq2/J/9p+HwvR/d8/n5kgVtoEJSk8FS8RKmOisYOeC
	9Zt0/vN+ScQoZWYXIhD8roXnLoQXC+374jIDcHcbJdTXno+3e8dL+g+Gk0M4ec8pu+fyoCmDcMu
	zF5j/N1NXZ0sJUjm3WfaxVNVTw/iGOpbTS0cXJljo587V9GFNJw4ZAI7tdN9Z2voY0J/Zw==
X-Received: by 2002:a05:7022:4388:b0:128:d0df:a66b with SMTP id
 a92af1059eb24-12ab28d8ac0mr8933270c88.26.1774913248833; Mon, 30 Mar 2026
 16:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-5-2f0c7410c523@rbox.co>
 <2192e9ef-894f-4826-b296-4f90e973a31b@163.com> <b9a956dd-ebb2-47ca-8b49-ccbba6ff9b26@rbox.co>
 <b21fac4e-891b-481c-9734-e95290e49097@linux.dev> <fa818820-c0c9-48dc-8ebc-661cb3349935@rbox.co>
 <dd043c69-4d03-46fe-8325-8f97101435cf@linux.dev> <27fa6e91-02a5-46cd-8c95-b75fd2c5fa08@rbox.co>
In-Reply-To: <27fa6e91-02a5-46cd-8c95-b75fd2c5fa08@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 30 Mar 2026 16:27:17 -0700
X-Gm-Features: AQROBzAkhh6Y9s4L1mXgxWRFDG45HwU7v2d7VbOquHM07Ta_Nm7VqgaccYrFf7k
Message-ID: <CAAVpQUAtF29CPDAdEUchYOP=oy8D2-B3GH3fWs2pwTmnYoTu=w@mail.gmail.com>
Subject: Re: [PATCH bpf v3 5/5] bpf, sockmap: Adapt for af_unix-specific lock
To: Michal Luczaj <mhal@rbox.co>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Jiayuan Chen <mrpre@163.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 4:04=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 3/26/26 07:26, Martin KaFai Lau wrote:
> > On 3/15/26 4:58 PM, Michal Luczaj wrote:
> >>> Beside, from looking at the may_update_sockmap(), I don't know if it =
is
> >>> even doable (or useful) to bpf_map_update_elem(unix_sk) in
> >>> tc/flow_dissector/xdp. One possible path is the SOCK_FILTER when look=
ing
> >>> at unix_dgram_sendmsg() =3D> sk_filter(). It was not the original use=
 case
> >>> when the bpf_map_update_elem(sockmap) support was added iirc.
> >>
> >> What about a situation when unix_sk is stored in a sockmap, then tc pr=
og
> >> looks it up and invokes bpf_map_update_elem(unix_sk)? I'm not sure it'=
s
> >> useful, but seems doable.
> >
> > [ Sorry for the late reply ]
> >
> > It is a bummer that the bpf_map_update_elem(unix_sk) path is possible
> > from tc :(
> >
> > Then unix_state_lock() in its current form cannot be safely acquired in
> > sock_map_update_elem(). It is currently a spin_lock() instead of
> > spin_lock_bh().
>
> Is there a specific deadlock you have in your mind?

lockdep would complain if we used the same lock from
different contexts.

e.g.)
Process context holding unix_state_lock() with the normal spin_lock()
-> BH interrupt
-> tc prog trying to hold the same lock with spin_lock(). (_bh())
-> deadlock


>
> >>> The only path left is bpf_iter, which I believe was the primary use c=
ase
> >>> when adding bpf_map_update_elem(sockmap) support [1]. It would be nic=
e
> >>> to avoid bh_lock_sock() when calling from all bpf_iter (tcp/udp/unix)
> >>> where lock_sock() has already been done. It is more for
> >>> reading-correctness though. This just came to my mind.
> >>> has_current_bpf_ctx() can be used to check this. sockopt_lock_sock() =
has
> >>> been using it to conditionally take lock_sock() or not.
> >>
> >> [ One clarification: bh_lock_sock() is a sock_map_update_elem() thing,
> >> which can only be called by a bpf prog. IOW, has_current_bpf_ctx() is
> >> always `true` in sock_map_update_elem(), right? ]
> >
> > For all the bpf prog types allowed by may_update_sockmap() to do
> > bpf_map_update_elem(sockmap), only BPF_TRACE_ITER should have
> > has_current_bpf_ctx() =3D=3D true. The tc prog (and others allowed in
> > may_update_sockmap()) will have has_current_bpf_ctx() =3D=3D false when
> > calling sock_map_update_elem().
>
> OK, so let's take test_sockmap_update.c:copy_sock_map(). It is a tc prog
> and it calls bpf_map_update_elem() -> sock_map_update_elem(), right? But
> running `test_progs -t "sockmap_basic/sockmap update"` shows (pr_warn() i=
n
> sock_map_update_elem()) that has_current_bpf_ctx() =3D=3D true. That's ex=
pected
> and has_current_bpf_ctx() would be false if sock_map_update_elem() was ra=
n
> via a hook?
>
> > The tc case of bpf_map_update_elem(unix_sk) is unfortunate and requires
> > going back to the drawing board. I think checking unix_peer(sk) for NUL=
L
> > without acquiring unix_state_lock() is needed for the
> > sock_map_update_elem() path, since changing unix_state_lock() for this
> > unknown use case seems overkill.
> >
> > Whether sock_map_update_elem_"sys"() needs unix_state_lock() is up for
> > debate.
>
> All right, I'll re-spin the series reverting back to v1.

Sounds good.


>
> > For bpf_iter_unix_seq_show(), one thought is to add unix_state_lock()
> > there before running the bpf iter prog. iiuc, it is what Kuniyuki has i=
n
> > mind also to allow bpf iter prog having a stable view of unix_sock. Thi=
s
> > could be a followup.
> > [fwiw, it was why I first thought of has_current_bpf_ctx() to avoid
> > sock_map_update_elem() taking unix_state_lock() again if
> > bpf_iter_unix_seq_show() acquires unix_state_lock() earlier. I later
> > concluded (but proved to be incorrect) that tc cannot call
> > bpf_map_update_elem(unix_sk).]
> >
> >>
> >> Let me know if I'm correctly rephrasing your idea: assume all bpf-cont=
ext
> >> callers hold the socket locked or keep it "stable" (meaning: "sk won't
> >> surprise sockmap update by some breaking state change coming from anot=
her
> >> thread"). As you said, most bpf iters already take the sock_lock(), an=
d I
> >
> > Right, all bpf iter (udp, tcp, unix) has acquired the lock_sock() befor=
e
> > running the bpf iter prog. afaik, the only exception is netlink bpf ite=
r
> > but it cannot be added to sock_map afaik.
>
> And sock_{map,hash}_seq_show() (being a part of bpf iter machinery) needs
> to take lock_sock() just as well? Would that require a special-casing
> (unix_state_lock()) for af_unix?

Right, lock_sock() + unix_state_lock() + SOCK_DEAD check
should be best.


>
> >> have a patch that fixes sock_{map,hash}_seq_show(). Then we could try
> >> dropping that bh_lock_sock().
> >>
> >>> [ I would still keep patch 3 though. ]
> >>
> >> Right.
> >>
> >>> [1]: https://lore.kernel.org/bpf/20200821102948.21918-1-lmb@cloudflar=
e.com/
> >>>
> >>>>
> >>>> In a parallel thread I've asked Kuniyuki if it might be better to
> >>>> completely drop patch 2/5, which would change how we interact with
> >>>> sock_map_close(). Lets see how it goes.
> >>>>
> >>>
> >>> If patch 2 is dropped, lock_sock() is always needed for unix_sk?
> >>
> >> For sock_map_update_elem_sys() I wanted to lock_sock()+unix_state_lock=
()
> >> following Kuniyuki's suggestion to keep locking pattern/order (that re=
peats
> >> when unix bpf iter prog invokes bpf_map_update_elem() ->
> >> sock_map_update_elem()). For sock_map_update_elem() not, we can't slee=
p there.
> >
>
