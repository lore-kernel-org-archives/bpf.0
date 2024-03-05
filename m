Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C213FB9B
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709682830; cv=none; b=t0mrmPWraXLTRnPJiDk0C8dgVqGedRl4N9rJ79Se7wQO1trX9Vsa37J7t9y/OFlnCyMwdKiuvk+gNVTNbySZiXdBigONDPpTwCwRLcbhCkSSTLTZz0vP2vma+sI0ZWljio/KQownBCTsgjrFIqsIpELGaugCIdLY3ef4MMpj894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709682830; c=relaxed/simple;
	bh=ydf4Yx2Jd82KucagGqCfWZtB5+14VqxsLS0+ojqyNdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiRhbO1zIfP1zzB1SNSaeS/KbZ0XL+TN/ZVnew4+1Iw0ecDxI/Mv8zh5ytD5PwyF9rOzxOr1JSyvFtpcr+YcF1XNbz5TG6DiLQCiH1xCvZztJ2+iSaoZODyNLZ9RBSHpZmah9m/GV49Zi9g9rDzV+EmAWATzlVHTp+Vm265VgFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzpO+ah9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzpO+ah9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6198C43394
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 23:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709682829;
	bh=ydf4Yx2Jd82KucagGqCfWZtB5+14VqxsLS0+ojqyNdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LzpO+ah9drHuZetTc6PXeBhsLKV8VTcekY2BZGsGs42AKmkmPTUoyyf/ViL6yDepO
	 1sMymmCNWoJofJE6nUdrb1ZzAPKVbUnD6O9sVHOT3NCky5YbVFWLf1KLx0+KwozbtE
	 HbZjo/zdukihEwTbJngIVX0vjuA+uDyZDTyqCFzR5fmwisK+JeP0ZSZ5p1wLaghb0H
	 Vz95XJMg5hUzmJCLyX1oEpudABE6/HOjO70C0h0ESX0j5RBrn6SdQfvuJrLcC+870d
	 QegErBu3C7JuTuDbpPcC2HOxmEa1V+Qun7N2fyO6dTprAVxZd1GbOYfq8uMgHN25z2
	 zTWqrvGeaDewg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d2505352e6so83398511fa.3
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 15:53:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoCRe/mmNWAGoyYyDphv7w7syOkReGLxeiqFOSkgEd75qsfntsmIcXTnShURRZy42XOHXOUd2bJuqoxxUf8x7vtBb2
X-Gm-Message-State: AOJu0YxyurhAfQ0dBiWBd90nI10ESNnt8LeaC9gImLV/uwv9rp6k7NTB
	1OZrNaSKewbO6/Pfm/fHQbZMYYW9DiWOXG5bWWC08hAvZgmASevw1VhPdZCF8Q9iPJy0GW/cDZg
	YzAmTqPYWEOsZIVBmDxx85+JE5hg=
X-Google-Smtp-Source: AGHT+IGQGWhkwtEfACGp79cxMl4K5dwnAX80/nJD8oibv9TVbbG/RYYqiNSCGroJ+UjUcPKsJBonIlK7qedhM30/c9A=
X-Received: by 2002:a05:6512:e98:b0:513:59fb:1a50 with SMTP id
 bi24-20020a0565120e9800b0051359fb1a50mr1185879lfb.54.1709682827910; Tue, 05
 Mar 2024 15:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeCXHKJ--iYYbmLj@krava> <23f9790d-4ab1-4edb-9262-6f982413b3e9@gmail.com>
 <ZedT8S-GjNOry5LZ@krava>
In-Reply-To: <ZedT8S-GjNOry5LZ@krava>
From: Song Liu <song@kernel.org>
Date: Tue, 5 Mar 2024 15:53:35 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5_6vkL58Efm3qL9G9W+7i=XVicoLXT6_G+T7TLx=zQJg@mail.gmail.com>
Message-ID: <CAPhsuW5_6vkL58Efm3qL9G9W+7i=XVicoLXT6_G+T7TLx=zQJg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Oleg Nesterov <oleg@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 9:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, Mar 01, 2024 at 11:39:03AM -0800, Kui-Feng Lee wrote:
> >
> >
> >
> > On 2/29/24 06:39, Jiri Olsa wrote:
> > > One of uprobe pain points is having slow execution that involves
> > > two traps in worst case scenario or single trap if the original
> > > instruction can be emulated. For return uprobes there's one extra
> > > trap on top of that.
> > >
> > > My current idea on how to make this faster is to follow the optimized
> > > kprobes and replace the normal uprobe trap instruction with jump to
> > > user space trampoline that:
> > >
> > >    - executes syscall to call uprobe consumers callbacks
> > >    - executes original instructions
> > >    - jumps back to continue with the original code
> > >
> > > There are of course corner cases where above will have trouble or
> > > won't work completely, like:
> > >
> > >    - executing original instructions in the trampoline is tricky wrt
> > >      rip relative addressing
> > >
> > >    - some instructions we can't move to trampoline at all
> > >
> > >    - the uprobe address is on page boundary so the jump instruction t=
o
> > >      trampoline would span across 2 pages, hence the page replace won=
't
> > >      be atomic, which might cause issues
> > >
> > >    - ... ? many others I'm sure
> > >
> > > Still with all the limitations I think we could be able to speed up
> > > some amount of the uprobes, which seems worth doing.
> >
> > Just a random idea related to this.
> > Could we also run jit code of bpf programs in the user space to collect
> > information instead of going back to the kernel every time?

I was thinking about a similar idea. I guess these user space BPF
programs will have limited features that we can probably use them
update bpf maps. For this limited scope, we still need bpf_arena.
Otherwise, the user space bpf program will need to update the bpf
maps with sys_bpf(), which adds the same overhead as triggering
the program with a syscall.

>
> sorry for late reply, do you mean like ubpf? the scope of this change
> is to speed up the generic uprobe, ebpf is just one of the consumers

I guess this means we need a new syscall?

Thanks,
Song
