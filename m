Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350C428DD6
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 04:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712292142; cv=none; b=V9vJezRZlcdAuJodZvFco3oUG64xDYk5tGXzjlK7ZRz0KrmuzHxDhN3uja3A3kUP5XwETR1PX/Nr7YpisBJkr1yCQYX0QWz/5qj+yNQA/7TrqD/pcxJ+VGUx5p5ZvNoNufWSthpj3lMEW2G/I879keLUA5XJsLUxu/HGiTg5DlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712292142; c=relaxed/simple;
	bh=63VvLltA6504QsqVt2PCWIACme5ZueYKMjIkqyX8ubI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZG6QLbsILhfqECwOiiqjtNCxX+9qCTV2v+YB0/5VmcyeJ2OO12Z8xcbCYayvNgoSr/joh0uRndzYm/cFWvpTT4W57lxIi9xr+IP4HcH9Ebo1QpruvtTDJ0LM7yKHxjpMcNE2JGhQ9AiySQRZeD7BIRUduLsWqvR/l4bH8yaYLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c//6mLVN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c//6mLVN"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecf3f001c5so1095657b3a.1
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 21:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712292140; x=1712896940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgwdAzHlCCBin24m6ElpAuyZGeG/6Z7+ioKTaRDOPiU=;
        b=c//6mLVNS2oEima1JcUada7cZLwRfgQzWUsaXdom17mr7uaMt8J/6CXCSXO9MTgKfr
         hZE0tOzJEBsCWx71W/OqyJ5SW+AV/5NhGLnhVXPWqt8snjFrfZHspWoWZ82kXKYYbrPP
         1PsCNg1hy/gc0YvsnUxog2so1LGWTFQ9lw7C2vMsQSLGrXDQEm+hS0Bx8G+C0bhDRAwX
         Ez7x5AxvP07gKaXaKaNww4AgBmWxlIe9oj7xeGmPBzBeJW54aLcqXBhUEpE752tTob5t
         w8UY1qO5wZN/tEY7wVzSRB36X3C+dSfMs1/BXyAohyd6NBEPPSXp66UFqkHVzSFMaoeH
         /Gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712292140; x=1712896940;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KgwdAzHlCCBin24m6ElpAuyZGeG/6Z7+ioKTaRDOPiU=;
        b=h/6/bgNylg3A3xNXpyw1SlYHRtJk1K3IhPvGNyk1kK9cjrIW7MTDJIWGdCaVq88dDc
         DR6VeKlVDngI3pxugKqvCM6iski6LphEJ/wpcXyftddWeqfvYgAEzEykn4+krO3Kqsy2
         hsqtyl2N+Vum9NyZPES1w4jsPYnpR7AHdps3I2Qp7Aur5G56cPR29kUWuGGP8ap8q7Rd
         mIWXnygXA7HW8BcToRv94Vs6EGZdo6QDbEgdaaXs4S9ZAYzC1aVLw9cGTcyMJsWvySMg
         S4blp1eliDJ8u0Fus1VjoAMonpgVClIJHdVwKfL/buJ+t0Qwl78I9NOt4g/qZv1/skbe
         1jyA==
X-Gm-Message-State: AOJu0YxOR+K4045seRRtLa1fQI3XK+NFe9RUCR1ET/zX5HwFETOTZxrY
	5fmNxnSSCnKD72oXOMVDFeUcK0p1c0LBIPa9RMr69ObWiU1yK8AO
X-Google-Smtp-Source: AGHT+IHpcAhdijjebMVXD9WK1pSP4Ev6/pROnysYbd/WJyEUt97tFOvWa3/A4riS+eiWF9HpbG4HKg==
X-Received: by 2002:a05:6a20:5605:b0:1a1:87c7:2d03 with SMTP id ir5-20020a056a20560500b001a187c72d03mr524022pzc.33.1712292140501;
        Thu, 04 Apr 2024 21:42:20 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b001dcc160a4ddsm515885plh.169.2024.04.04.21.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 21:42:20 -0700 (PDT)
Date: Thu, 04 Apr 2024 21:42:19 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 kernel-team@fb.com, 
 Martin KaFai Lau <martin.lau@kernel.org>
Message-ID: <660f812b3cd68_50b87208e1@john.notmuch>
In-Reply-To: <55359f46-087e-4685-944b-80fe6d61eb87@linux.dev>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022158.656285-1-yonghong.song@linux.dev>
 <CAEf4BzbkcKFVEWaHSavbRi9+9VQMbqCgP36p9fzk6Hai2v2izA@mail.gmail.com>
 <27046774-e3d6-40c2-b3e3-ae6e64ecd33b@linux.dev>
 <CAEf4BzaYh6q_0TUUARd8m0eK+5RBxWQJ8=-n84vdayPPh4Z61g@mail.gmail.com>
 <660d964a1444b_1cf6b20885@john.notmuch>
 <55359f46-087e-4685-944b-80fe6d61eb87@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yonghong Song wrote:
> =

> On 4/3/24 10:47 AM, John Fastabend wrote:
> > Andrii Nakryiko wrote:
> >> On Tue, Apr 2, 2024 at 6:08=E2=80=AFPM Yonghong Song <yonghong.song@=
linux.dev> wrote:
> >>>
> >>> On 4/2/24 10:45 AM, Andrii Nakryiko wrote:
> >>>> On Mon, Mar 25, 2024 at 7:22=E2=80=AFPM Yonghong Song <yonghong.so=
ng@linux.dev> wrote:
> >>>>> Add bpf_link support for sk_msg and sk_skb programs. We have an
> >>>>> internal request to support bpf_link for sk_msg programs so user
> >>>>> space can have a uniform handling with bpf_link based libbpf
> >>>>> APIs. Using bpf_link based libbpf API also has a benefit which
> >>>>> makes system robust by decoupling prog life cycle and
> >>>>> attachment life cycle.
> >>>>>
> > Thanks again for working on it.
> >
> >>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >>>>> ---
> >>>>>    include/linux/bpf.h            |   6 +
> >>>>>    include/linux/skmsg.h          |   4 +
> >>>>>    include/uapi/linux/bpf.h       |   5 +
> >>>>>    kernel/bpf/syscall.c           |   4 +
> >>>>>    net/core/sock_map.c            | 263 +++++++++++++++++++++++++=
+++++++-
> >>>>>    tools/include/uapi/linux/bpf.h |   5 +
> >>>>>    6 files changed, 279 insertions(+), 8 deletions(-)
> >>>>>
> >> [...]
> >>
> >>>>>           psock_set_prog(pprog, prog);
> >>>>> -       return 0;
> >>>>> +       if (link)
> >>>>> +               *plink =3D link;
> >>>>> +
> >>>>> +out:
> >>>>> +       mutex_unlock(&sockmap_prog_update_mutex);
> >>>> why this mutex is not per-sockmap?
> >>> My thinking is the system probably won't have lots of sockmaps and
> >>> sockmap attach/detach/update_prog should not be that frequent. But
> >>> I could be wrong.
> >>>
> > For my use case at least we have a map per protocol we want to inspec=
t.
> > So its rather small set <10 I would say. Also they are created once
> > when the agent starts and when config changes from operator (user dec=
ides
> > to remove/add a parser). Config changing is rather rare. I don't thin=
k
> > this would be paticularly painful in practice now to have a global
> > lock.
> >
> >> That seems like an even more of an argument to keep mutex per sockma=
p.
> >> It won't add a lot of memory, but it is conceptually cleaner, as eac=
h
> >> sockmap instance (and corresponding links) are completely independen=
t,
> >> even from a locking perspective.
> >>
> >> But I can't say I feel very strongly about this.
> >>
> >>>>> +       return ret;
> >>>>>    }
> >>>>>
> >> [...]
> >>
> >>>>> +
> >>>>> +static void sock_map_link_release(struct bpf_link *link)
> >>>>> +{
> >>>>> +       struct sockmap_link *sockmap_link =3D get_sockmap_link(li=
nk);
> >>>>> +
> >>>>> +       mutex_lock(&sockmap_link_mutex);
> >>>> similar to the above, why is this mutex not sockmap-specific? And =
I'd
> >>>> just combine sockmap_link_mutex and sockmap_prog_update_mutex in t=
his
> >>>> case to keep it simple.
> >>> This is to protect sockmap_link->map. They could share the same loc=
k.
> >>> Let me double check...
> >> If you keep that global sockmap_prog_update_mutex then I'd probably
> >> reuse that one here for simplicity (and named it a bit more
> >> generically, "sockmap_mutex" or something like that, just like we ha=
ve
> >> global "cgroup_mutex").
> > I was leaning to a per map lock, but because a global lock simplifies=
 this
> > part a bunch I would agree just use a single sockmap_mutex throughout=
.
> >
> > If someone has a use case where they want to add/remove maps dynamica=
lly
> > maybe they can let us know what that is. For us, on my todo list, I w=
ant
> > to just remove the map notion and bind progs to socks directly. The
> > original map idea was for a L7 load balancer, but other than quick ha=
cks
> > I've never built such a thing nor ran it in production. Maybe someday=

> > I'll find the time.
> =

> I am using a single global lock.
>    https://lore.kernel.org/bpf/20240404025305.2210999-1-yonghong.song@l=
inux.dev/
> Let us whether it makes sense or not with code.
> =

> John, it would be great if you can review the patch set. I am afraid
> that I could miss something...

Yep I will. Hopefully tonight because I intended to do it today but worse=

case top of list tomorrow. I can also drop it into our test harness which=

runs some longer running stress stuff. Thanks!=
