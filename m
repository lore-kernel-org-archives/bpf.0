Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD446208A0
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912613; cv=none; b=s52A4KR4074IMlOJPTy0yHN9ybk95cRAs+ikpHqYUywTzCMlsy01yOEG7RsYm5IWGwUDADEVX2RFUbgFf0I4wX+baUTrBgpcAPY1sURKYDS4AyvdWp1YtKoiDhUd/KZMvC3EyLkf5s+Rc12Mq4JO8Tsea4PvrnsOeDcdMixEwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912613; c=relaxed/simple;
	bh=Xv+dJbRPz2cxsAVm10+qyLsKEgfweMr+yDEsD+Y7vNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVJ8F19SZEB6DuEmzOPr6SzEfleF1PsT3WIjYsEk7A6tgnnNhAh44lF1J+/WSgTnxLX58j2kTc6mV/qMUpGnYCsZHf7ErzlOptRsQXq7ca5jS/pXcHiiWprxnrdW3OL7YsnCK0f5m0fbwLZdc3N+2YnxrYeTMlxitVasHpTuMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glbNRh40; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glbNRh40"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d2505352e6so30253141fa.3
        for <bpf@vger.kernel.org>; Fri, 08 Mar 2024 07:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709912610; x=1710517410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09kYlGOowzZl9i8w9XI2qBUI6LCJpzZBgtJkQJxTRQo=;
        b=glbNRh40tv2Le+ScnUYmHsCLNYUFSCwEp028fen/WJQ/U/2OmZEg2rESQrVevmZf9O
         vLrWs5VvNB1N422xY9ZucdFe/+wMpmhJydUOVi/yNZMBHZ8RhgH5R4hGQi/qhH5z27Wv
         6NEmIqJBfAZ4OHAg7Lm4qksbnEa5PTJZHNhB2KHpyajLmMwZiKZVTsQLWAzlii34dfK+
         C5v+yn9N5qOoR/Bo0Zt6PUUB/fuGqUTtKcZQtn35MwWQ7K4ESTRbhPeKL9UnfyjAn6R+
         nbi0bEPGrY2G8wfbhpdE8dgLkl9ASnyZ0wVqtNjaCzA8IE4Z+a9yQhI1Syak1/ULL3NL
         7kDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709912610; x=1710517410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09kYlGOowzZl9i8w9XI2qBUI6LCJpzZBgtJkQJxTRQo=;
        b=LzfaB1A+uiX0KDFMGdX81MnUxc1GYOBg9pEana52GHunN7T0a6UkWyXQWzObue/a/v
         Fi1AGUtz6tOKoPm8xMsSVZiKSHdpTjD7Pmho3YnEDw1BrAJ+uW59kdhheIHhBRtJd8Kw
         tJ8lKQ53VM+9/8pInd+lxhXOTsojxOexxzoTM0vb++pXkI20IsvnD6Gy65sgq+YS/Swu
         5tCV2WczSbGj7jS65gsZY5Xd8Bp17WQDKxOlTEGEXYC3Vsf76JVFCcxFyEhHXcPNwQjQ
         rvNFL2vykg7CkK4WnaI6mK/nYB0lBquLkjOhYj+HhvKnt1tFgph8dAHH69Z4elJ4JAo/
         mIrg==
X-Forwarded-Encrypted: i=1; AJvYcCUKX5yxxghPkXlYUbnbQ1WRGELP3n/J9EmhYppMCmZrrQKiqAKZaYvkNsEIIylAaTZeYW4Q/hdRAJKJJmOpi7GQDYqD
X-Gm-Message-State: AOJu0YwXyOUZTzWY0IyHm/7KN1jAjwNaJUuMTs/hhxqa04MzC4ULqEWW
	W+bdcGsc6caP/4b+GPvZdGMkXsUa3P29Tpc27HGtGlptz+noua3CPf9RuhWt2q8Jw6MS5RQouEq
	If6E6/2/n+PA7TWrmZsoL5jfEfdE1YlMjJLCslA==
X-Google-Smtp-Source: AGHT+IEexxRvsV38F1jbiWwui/RlNSMhnEWCTaaL850tT2iW2Wn1hXRAExR/ltl1Zl431JxYR+abf/Cvo4P2PGb5QMI=
X-Received: by 2002:a05:651c:1a12:b0:2d4:1d45:d5cd with SMTP id
 by18-20020a05651c1a1200b002d41d45d5cdmr1677725ljb.48.1709912609404; Fri, 08
 Mar 2024 07:43:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeCXHKJ--iYYbmLj@krava> <23f9790d-4ab1-4edb-9262-6f982413b3e9@gmail.com>
 <ZedT8S-GjNOry5LZ@krava> <CAPhsuW5_6vkL58Efm3qL9G9W+7i=XVicoLXT6_G+T7TLx=zQJg@mail.gmail.com>
 <412c987b-b1c4-4761-83e4-d46c78a255be@gmail.com>
In-Reply-To: <412c987b-b1c4-4761-83e4-d46c78a255be@gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Fri, 8 Mar 2024 10:43:17 -0500
Message-ID: <CABWLsevYANVb8TmOF69qtXeEjk6=NVQmsObrFG8r+oqSRMBxpw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Oleg Nesterov <oleg@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 6:02=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> w=
rote:
>
>
>
> On 3/5/24 15:53, Song Liu wrote:
> > On Tue, Mar 5, 2024 at 9:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> >>
> >> On Fri, Mar 01, 2024 at 11:39:03AM -0800, Kui-Feng Lee wrote:
> >>>
> >>>
> >>>
> >>> On 2/29/24 06:39, Jiri Olsa wrote:
> >>>> One of uprobe pain points is having slow execution that involves
> >>>> two traps in worst case scenario or single trap if the original
> >>>> instruction can be emulated. For return uprobes there's one extra
> >>>> trap on top of that.
> >>>>
> >>>> My current idea on how to make this faster is to follow the optimize=
d
> >>>> kprobes and replace the normal uprobe trap instruction with jump to
> >>>> user space trampoline that:
> >>>>
> >>>>     - executes syscall to call uprobe consumers callbacks
> >>>>     - executes original instructions
> >>>>     - jumps back to continue with the original code
> >>>>
> >>>> There are of course corner cases where above will have trouble or
> >>>> won't work completely, like:
> >>>>
> >>>>     - executing original instructions in the trampoline is tricky wr=
t
> >>>>       rip relative addressing
> >>>>
> >>>>     - some instructions we can't move to trampoline at all
> >>>>
> >>>>     - the uprobe address is on page boundary so the jump instruction=
 to
> >>>>       trampoline would span across 2 pages, hence the page replace w=
on't
> >>>>       be atomic, which might cause issues
> >>>>
> >>>>     - ... ? many others I'm sure
> >>>>
> >>>> Still with all the limitations I think we could be able to speed up
> >>>> some amount of the uprobes, which seems worth doing.
> >>>
> >>> Just a random idea related to this.
> >>> Could we also run jit code of bpf programs in the user space to colle=
ct
> >>> information instead of going back to the kernel every time?
> >
> > I was thinking about a similar idea. I guess these user space BPF
> > programs will have limited features that we can probably use them
> > update bpf maps. For this limited scope, we still need bpf_arena.
> > Otherwise, the user space bpf program will need to update the bpf
> > maps with sys_bpf(), which adds the same overhead as triggering
>
> That is true. However, even without bpf_arena, it still works with
> some workarounds without going through sys_bpf().

Anything making uprobes faster would be very welcomed for my project.  The
biggest performance problem for us is the cost of bpf_probe_read_user()
relative to raw memory access. Every call to this helper walks the process'
page table to check that the access would not cause a fault (I think); this=
 is
very slow. I wonder if there's some other option that would keep the safety
requirement for the memory access -- I'm imagining an optimistic mode where=
 the
raw access is performed (in the target process' memory space) and, in the r=
are
case when a fault happens, the kernel would somehow recover from the fault =
and
fail the bpf_probe_read_user() helper. Would something like that be technic=
ally
feasible / has there been any prior interest in faster access to user memor=
y?

A more limited option that might be helpful would be a vectorized version o=
f
bpf_probe_read_user() that verifies many pointers at once.


>
> > the program with a syscall.
> >
> >>
> >> sorry for late reply, do you mean like ubpf? the scope of this change
> >> is to speed up the generic uprobe, ebpf is just one of the consumers
> >
> > I guess this means we need a new syscall?
> >
> > Thanks,
> > Song
>
