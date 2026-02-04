Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75621A9FBA
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770232583; cv=pass; b=UWuuD7OM3DILkdJG8boc0ZZIdA2nhnQ+U31ENow1bp1azAF4LYpcm/0PRh1bWrO5w3ZuXLKSXUceuEWh2pKyS1SWe7KVaDN35aFNhEAdF8BoIX44d1Vd0x+ZWCbG1vukFksOaVb1+zfQkMu2/h7bJHmupybeP37BbQi7LBnB2kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770232583; c=relaxed/simple;
	bh=PER2BQrsL1CJQhKWon9Mz9meNiPet/3DEkc6fa8mvI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALSoKgFq0qZLEoMdBspRt3/OtbA93BacITL+a9loxvWWvJEieYYzxJVsv8QB8Jg6/aj8LuE8+1e7HyWzgGM64IacbUL0ER5y4ZZouosqAYQmfqZkvGK9ZiSunkRL1a4p9LtT1C9aqz9cWOv9twPoXWDlbHjhmqJgGH0GUPkUJb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lOYWQFnd; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOYWQFnd"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b73112ab62so67289eec.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 11:16:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770232582; cv=none;
        d=google.com; s=arc-20240605;
        b=jfUE8QbpoM/1ctLsPaHZvZ7zphnFCY/jEbhWTbW16p3To/vX1CYc3bAvaCJcINKRw9
         t6ydESRqQ3nnFFHocu6qTGOEKfI9Xe5T0Las8XCur18uWnHYqOZtcDLj0rALgz020bdx
         ro7DKh7OvRt5U8vz47Ppcz5Jw7bx66LZ0zrnvghpbtlt+jj+ZX9JoM3Ra0vY3QX6HRkP
         HC3nKngJiWOYtmG0FBgrRbOJv0LpeQL2Gg3Juawp93zbeHbPbvebfbvTvwKP9GpFO8rP
         LMik5xu/MhfiqMePuKlxQJqmy5EQkOC208qrO35WOQamE8BxH+gOdGATh/XDg796rwvY
         1Fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3uHPEEWLcSxU31xZCU6niHg5YWDthT8oTTsiIIWluck=;
        fh=to/C2d37+pFiCLI6/3PGX5sXSzFGluvmfxHoNSLCFHE=;
        b=SWNp5W2VB10IYyvWMz8pkO7/LPeWtrtWJ+3PZlOW4ZFeUYjQ98dZd8tBXBqFyvvzDC
         BOZmaaQHZBfV/MiXNxB7Ah/xnGu2NE0bJzNy+e5YiwdBDLwRY0rQMq3cuFAvx2c0CehW
         sstOm86Y7UnoWhJlr2q7ikYmFT/MBHegdNfwTPY4sgZ6Q8mBtvMLAvXrUPbT/9aEE4Tv
         iEeFIjiRNhHDnIfhH4srN+B09Hf5fTeIWjBjJMYV+t89k66akAh4xzvawq/uweVGNcJ8
         /SBlfGOs6/D2TVTugKNx9SVngxs+ezrAEkwMb/lbdvXoCsY0MZXnAzSqR/ZYcaQq9Qn9
         VWKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770232582; x=1770837382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uHPEEWLcSxU31xZCU6niHg5YWDthT8oTTsiIIWluck=;
        b=lOYWQFndCQ/CnmrxHZybSqR1JZxpgUlCwKdSzfqTL9v3PN2DBu8h/ZtFI9kle8waoi
         CD9ts7V9/6II5LjcouyoAiFgjm9idk1hyxcBJ19hdmdS4etLs9cM3Wk3Lw4v6lpaXEzK
         WMFz6LChoLmTVv5JTBmdy8LqEYLhjuqrJNODuH36BQcimdXe3flrt0VSK1UJvlACVfFF
         J8zGLZYXoyQ1sQlPe8UJ6ga8x2aWn4au6h0br53kGLRp3/96D2CPuBskbJdZLpnc6Xg6
         ouoOg70PKzSIHXnp37KEdtkWUjWrCOMwYXoFstNe0PhXhWZyvNZ0Y777gLjR2kXrtVgU
         wixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770232582; x=1770837382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3uHPEEWLcSxU31xZCU6niHg5YWDthT8oTTsiIIWluck=;
        b=UBI6uUoy3zCWAo38gzunsVPzf2ED/DDPLe/lttbKCGAeHRPdmWpAMhMazxEeWNyK4+
         WCtfWn8JYOK1zaQ8AXW5yUWA8sMk1BwHZ3vaSDbSnT1rBVxCT8PtFDsz3Kmq9Nbld8QL
         /gt8NSOrP8VnRFRfb7AFTbGhaNBHIKPEJtY3mrF45ExdNK8w4SjAzLjZKNKXI9MSXNVu
         XR+Z/ksAkl1m9N7ahrqpgFjHvW+xDcD6MADzK23EtnHup99Jkw0w1PtHkNVKJFNalOT3
         FBN/Qo5iU0uMGvg57YDYRdCSTCL2OBvGSG/3Mj9cCNXps9rf7CNMoo+IJOzMvT7rm5sj
         TuXg==
X-Forwarded-Encrypted: i=1; AJvYcCVuEiy6bVw42MFKyIAPtyL3CqKUipWyyjkvEJS29xEsyuBKrIe7Nj3jV5ROV+2raLlrvvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12nhSAehXCna3xnWmqz4OKlJH3Nh649C1iP+buLnk0NomWSn3
	PhMadOM2oonz6DTQHpdH0IarG2sL3ZnKgIBU8t/+HzU5ZE19FNZlZRpUr3x9+UQzdUKiEWX0kVT
	ppNBp9HETVE5B3goDJ/2JALIB5YYzbcX4Xk7dMq8S
X-Gm-Gg: AZuq6aJozw1057Et4loSa8oUiFxCZyZ9ut9TBGCADF9LTdspN1seIFaRADI4hTzakts
	YLxuKmqMSbC7eSgKxfrWEbMm4bLZ9UHtTC7UI6Wy7jbXVRBl62YyJw8TAyXpDVaaJOfeqjbOJaJ
	JN2Pu1rr54Io6U4j+oAlWUU+abiGdebnqkHUMuNfrVS0245BFQX+mHI2BWXLAE3eBGXdW4ZWMSx
	NWydTUA9z6nakjePHNJP1i6NH/PLXvkw8HZoyXm23HnbN5tHFtwYrNH6v57TRH/vH6nOzQvmOg/
	usLA5HGLif6h553DmhiDq8n91MOKAOwGQA1IBdu7cr3l+hwzRzeemozcU05u8bIGtfY=
X-Received: by 2002:a05:7300:534f:b0:2b7:f12:9503 with SMTP id
 5a478bee46e88-2b83299d898mr1345406eec.30.1770232581601; Wed, 04 Feb 2026
 11:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co> <20260203200242.404131-1-kuniyu@google.com>
 <80865b12-7786-4787-81c8-08b754716a5d@linux.dev> <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
 <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co>
In-Reply-To: <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Feb 2026 11:16:10 -0800
X-Gm-Features: AZwV_Qgur5lVdyr6ufrZv78YuIEfQq3BMw2wq875R33oIJICWlo4lt09ETOastQ
Message-ID: <CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP+SpHBGqKcUT0iMA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto update
To: Michal Luczaj <mhal@rbox.co>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 7:41=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 2/4/26 08:58, Kuniyuki Iwashima wrote:
> > On Tue, Feb 3, 2026 at 11:15=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 2/3/26 11:47 AM, Kuniyuki Iwashima wrote:
> >>> From: Michal Luczaj <mhal@rbox.co>
> >>> Date: Tue, 3 Feb 2026 10:57:46 +0100
> >>>> On 2/3/26 04:53, Martin KaFai Lau wrote:
> >>>>> On 2/2/26 7:10 AM, Michal Luczaj wrote:
> >>>>>> In related news, looks like bpf_iter_unix_seq_show() is missing
> >>>>>> unix_state_lock(): lock_sock_fast() won't stop unix_release_sock()=
. E.g.
> >>>>>> bpf iterator can grab unix_sock::peer as it is being released.
> >>>>>
> >>>>> If the concern is the bpf iterator prog may use a released unix_pee=
r(sk)
> >>>>> pointer, it should be fine. The unix_peer(sk) pointer is not a trus=
ted
> >>>>> pointer to the bpf prog, so nothing bad will happen other than
> >>>>> potentially reading incorrect values.
> >>>>
> >>>> But if the prog passes a released peer pointer to a bpf helper:
> >>>>
> >>>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
> >>>> Read of size 1 at addr ffff888110654c92 by task test_progs/1936
> >>
> >> hmm... bpf_skc_to_unix_sock is exposed to tracing. bpf_iter is a traci=
ng
> >> bpf prog.
> >>
> >>>
> >>> Can you cook a patch for this ? probably like below
> >>
> >> This can help the bpf_iter but not the other tracing prog such as fent=
ry.
> >
> > Oh well ... then bpf_skc_to_unix_sock() can be used even
> > with SEQ_START_TOKEN at fentry of bpf_iter_unix_seq_show() ??
> >
> > How about adding notrace to all af_unix bpf iterator functions ?
> >
> > The procfs iterator holds a spinlock of the hashtable from
> > ->start/next() to ->stop() to prevent the race with unix_release_sock()=
.
> >
> > I think other (non-iterator) functions cannot do such racy
> > access with tracing prog.
>
> But then there's SOCK_DGRAM where you can drop unix_peer(sk) without
> releasing sk; see AF_UNSPEC in unix_dgram_connect(). I think Martin is
> right, we can crash at many fentries.

Ah I was only considering SOCK_STREAM :p

Only solution that came to mind is breaking change enforcing
a release function to bpf_skc_to_unix_sock() so that it can
hold the peer's refcnt and save the pointer somewhere else
until the release function, but I think this is unacceptable.

Also, I guess this type of issue could be triggered with any
objects that are not refcounted by bpf tracing prog ?

For example, inet_sock(sk)->inet_opt could be freed by
setsockopt(IP_OPTIONS) even after fentry prog verifies
that it's not NULL.

I'm not sure if bpf_core_cast() etc allows such access, but
if it's allowed, I think there is no general solution.

Fortunately that's not null-deref nor oob-write, and it just reads
stale info as Martin mentioned... so probably this is WAI for
tracing prog ?


>
> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> Call Trace:
>  dump_stack_lvl+0x5d/0x80
>  print_report+0x170/0x4f3
>  kasan_report+0xe1/0x180
>  bpf_skc_to_unix_sock+0xa4/0xb0
>  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
>  bpf_trampoline_6442564662+0x47/0xab
>  unix_shutdown+0x9/0x880
>  __sys_shutdown+0xe1/0x160
>  __x64_sys_shutdown+0x52/0x90
>  do_syscall_64+0x6b/0x3a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> >
> >>
> >>>
> >>> ---8<---
> >>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >>> index 02ebad6afac7..9c7e9fbde362 100644
> >>> --- a/net/unix/af_unix.c
> >>> +++ b/net/unix/af_unix.c
> >>> @@ -3740,8 +3740,9 @@ static int bpf_iter_unix_seq_show(struct seq_fi=
le *seq, void *v)
> >>>               return 0;
> >>>
> >>>       slow =3D lock_sock_fast(sk);
> >>> +     unix_state_lock(sk);
> >>>
> >>> -     if (unlikely(sk_unhashed(sk))) {
> >>> +     if (unlikely(sock_flag(other, SOCK_DEAD))) {
> >>>               ret =3D SEQ_SKIP;
> >>>               goto unlock;
> >>>       }
> >>> @@ -3751,6 +3752,7 @@ static int bpf_iter_unix_seq_show(struct seq_fi=
le *seq, void *v)
> >>>       prog =3D bpf_iter_get_info(&meta, false);
> >>>       ret =3D unix_prog_seq_show(prog, &meta, v, uid);
> >>>   unlock:
> >>> +     unix_staet_unlock(sk);
> >>>       unlock_sock_fast(sk, slow);
> >>>       return ret;
> >>>   }
> >>> ---8<---
> >>>
> >>> Thanks!
> >>
>
