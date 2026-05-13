Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C938AC96
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706235; cv=pass; b=gaSwrVgcaKisPLj+dqtt48DZYO3PDv14kHWcrxvjbUdu0QDO7LImlB29dMnqigNYFHi+WhCaZg5SD1WPEWxzUQai2i/Z4iUzt5Iu83bEzLl1ycKPwgHXAOjwI+NYCKAugp71SFQ4sEj/NAvFD3Rx4h8G1RnZMSGQAXL5lbkODuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706235; c=relaxed/simple;
	bh=Ak9QebyPplmvEVZxfnV5E+i53CeeU7rfM7MEpmPpjGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHv7BMP5hUu1Wl83guaaCaT3Ot6fljOwMOLLg+NaPKQaMWFZN5t8zBPJv2vuNQfG6bdko0E4wEWHzlcyu3X2oEAxaaKCHpD0057zw2R3xJXmTCb6kzby+WgGztJj9j0c2PUG154SchtJzvPczg9OIQ3M4E5AoPHpXVvxZTgcsG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcVX9y5c; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcVX9y5c"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ae6a0e523so1646666f8f.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 14:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778706232; cv=none;
        d=google.com; s=arc-20240605;
        b=JF7jSilGvEKqGRlXBpoeMx5cb8Q2lp8cfJNWmEedFIhbWX25ztQALakF4Wr4MLnnk+
         dStw9jpAqP+OxP0ATYMyWHEZ5Mc3f8JzTKrMjEWq1YPGKAdcPfTssdAWnxYuUzCs9L9Z
         pQHvYPQaeGedLeMM5Uk8Uw90HseyJRDnqwmE7de+PDA42HpzFY4GXy5ZyRvx1OWorTw5
         7kXRKB28PeK5M4Slqchl9XHS83ylhrLH8yQEHWRBOc7g9XNsI3sAQKFCcizL+R+WytR5
         Dka//BfAuc7fw2Tdw2UioGa1oajIP5XXhGVjOqpcqO7RKvJqESCgM8K9oJKrgQVgnD3p
         Uq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=11Jb0dd2cFuHeuXRLOYq2HD+pUqkjW/pEpvn5zyVRwI=;
        fh=j2h3wn0bnTpxET5PqmRHXM5Ft0iSolfekrTyBGQiP7Y=;
        b=k3fREdPhsi/2QZDOBjnIrzC6e9vHsEolRXnpN6Asdvc6IHp/kz5hzNH6zY7tJJemt9
         O0xfiIiyiRft6Fqc9CAfZGJWwcyGSrtjCimPK6XTAIY4o1NdJk/ZqiAGZitpCHuGx1lt
         aUCMqkCIARgMq1pP3RPSb+lKnIr48umUKeXaqxJecV856HAFQqYX5eN7531EET94zHwn
         wbpmNXvwwxBTI6PqAXe2HEuOVMd57IUNVK7YCdCSAei4zskw3IQlmo0/uve8odH5RaS4
         cxsBaXFToKJj9ww/4SpYJrTR0XadVIZ3ZIE/wKYjSEelmZoG20BfgI+shm3HJEp1pK+2
         vLHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778706232; x=1779311032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11Jb0dd2cFuHeuXRLOYq2HD+pUqkjW/pEpvn5zyVRwI=;
        b=HcVX9y5c47XWvgjfriKRUdvHTr8ETHDVDz0P1dnyPvS2r2mGIk9fTZJ6THBnxelHHd
         uU3m1Ai1ziyUb//eDySpqpncwCj3NPi9Odvbz8qYPlEdCHBgXw7/frR2sNMI+IMTDl/u
         jwukpNw/KmLQhQbqY4NqaxcE65XnrohvX8vt3IV6360EHTErMpMBGu0qr7cCo7FKXtj0
         EguRmnlJiwEUEHCcs9KqGle8j/9CGhq059T8XV3MUsVRlQppGWxkNeNmIWNd0oIjfmPh
         +z3jzpoVp8uBw42iOpuedHezYQjyM+gTZ57rJVWh+JMqslRL6hXXfmOOYEFTT6cguTq+
         sgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778706232; x=1779311032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=11Jb0dd2cFuHeuXRLOYq2HD+pUqkjW/pEpvn5zyVRwI=;
        b=kSFUSurTKBFvI1xE/6HRf/KgbagNQ2GDULJJiGZiOx5BYECv3FtLrvvUy8BTs9hjST
         0E51KwWyyG34RVbNIRfxoAio7jjC1H6w4cBzTfDcDNq2h1d+HDqyGXJAnq8W9UQ29rcS
         rLvWaNbZQLvias+tQalrZZ/nrauFt9EweDnz3o5pII7KhAkFfbJmoADAiO0hSHfYVquR
         LsTrVX3HfzBvqa3i2LiNf4w2d+ZhEwWl2Rz7D6X7TdMOLVHh0HxktZA4LYtvBA1xmEn6
         YyggqT55EWdOHwHo/ztNFiNJSr3rIx2YAwS78chjtwvSBisRBioNwJ0RnjWb3r09FAaM
         j1Ug==
X-Forwarded-Encrypted: i=1; AFNElJ8KZQSX87HB82abhd6rcTBHqpaJA3RzX8Si7TZ+xAr3LhmHXtURoDOylON1qFmMMOt0lGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJ8H499Tm3IBFfWuvn77B14Yv1oA7f+aHQFEpZ6Rv3DuOn9Jq
	ySb8ZDCKHHjFVL072Vjg1OTay0Hlx+T5etCd7muecMpDvKbwHJ237SJfpFwsDi8d52obdTLOsnL
	ATg8jA8ozRog5fOAnZOsifGNOowcXiy0=
X-Gm-Gg: Acq92OFs3bkeBCo7zJ0ZC1NMaNq3sAq33Xn5m8FOkW98bF0/G0TqwjPY0XJeH1P48Ob
	kblsg487a5F4S9RRO1HNgB/YGa4XBOigbKhp3wL/l21/osFzZRwvxlpK7hIMhLDfQC0LYDLRclQ
	sfR95rMhauLUh/FivmFJlfT3EB4gAupwGMvvbSCFsuLFzl9EE+0dVW+EX07CndWkmhgaRlxhZhD
	rKQ0gZMO3FxjMtaOfdOMtxMYM8W7YO1+5Et8Df8jd8dL3DnK4HSge4QUvJ0wzuYZ32Fab1+zKry
	xGnUvfoP5C+WU5Pnv0S5N7w/drpvoPRxLg+bgfOYNeD+qFs3Od41CNE1NlPzG3s/hp1eDokg3zZ
	ZyTJeQ237cyrC7jch8DeehGut7g==
X-Received: by 2002:a5d:5f51:0:b0:453:f951:4e5b with SMTP id
 ffacd0b85a97d-45c584a86acmr8273177f8f.13.1778706231832; Wed, 13 May 2026
 14:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511174559.659782-1-wusamuel@google.com> <CAP01T74KQ6bie5o++i_gHM19J+s2RzDyM6=w87=oUZgPagPejw@mail.gmail.com>
 <CAADnVQJtuKQh-bpDDeqWCQRM1zb2sSgo0qET_+1+JFOL-6cpDg@mail.gmail.com> <CAJZ5v0hqdyMnBtvvo7RwUkh5saLvAHkTEVz8Ln09UaKMqoP=Dg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hqdyMnBtvvo7RwUkh5saLvAHkTEVz8Ln09UaKMqoP=Dg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 May 2026 14:03:39 -0700
X-Gm-Features: AVHnY4JXZcwxzcwywRgvFsuXdvDflXIGcM__yxtCZ9WZk-JETjoc5UQtPM5_vFs
Message-ID: <CAADnVQLvuCKLUHnxcEx2+t4diLmuOb9VSthoDea5iktsAZxhTg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Support BPF traversal of wakeup sources
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Samuel Wu <wusamuel@google.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Android Kernel Team <kernel-team@android.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 12:52=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Wed, May 13, 2026 at 2:51=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, May 11, 2026 at 1:44=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Mon, 11 May 2026 at 19:50, Samuel Wu <wusamuel@google.com> wrote:
> > > >
> > > > This patchset adds requisite kfuncs for BPF programs to safely trav=
erse
> > > > wakeup_sources, and puts a config flag around the sysfs interface.
> > > >
> > > > Currently, a traversal of wakeup sources require going through
> > > > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls t=
o query
> > > > sysfs is inefficient, as there can be hundreds of wakeup_sources, w=
ith each
> > > > wakeup source also having multiple attributes. debugfs is unstable =
and
> > > > insecure.
> > > >
> > > > Adding kfuncs to lock/unlock wakeup sources allows BPF program to s=
afely
> > > > traverse the wakeup sources list, and a kfunc to get head of wakeup
> > > > sources list is needed to start traversing the list.
> > > >
> > > > On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~=
34x
> > > > speedup (sampled 75 times in table below). For a device under load,=
 the
> > > > speedup is greater.
> > > > +-------+----+----------+----------+
> > > > |       | n  | AVG (ms) | STD (ms) |
> > > > +-------+----+----------+----------+
> > > > | sysfs | 75 | 44.9     | 12.6     |
> > > > +-------+----+----------+----------+
> > > > | BPF   | 75 | 1.3      | 0.7      |
> > > > +-------+----+----------+----------+
> > > >
> > > > The initial attempts for BPF traversal of wakeup_sources was with B=
PF
> > > > iterators [1]. However, BPF already allows for traversing of a simp=
le list
> > > > with bpf_for(), and this current patchset has the added benefit of =
being
> > > > ~2-3x more performant than BPF iterators.
> > >
> > > This looks good to me, you can add for the set:
> > > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >
> > Rafael,
> > how do you want to route it?
> >
> > If you ack it we can take it into bpf-next.
>
> I guess if someone really wants this, I have no particular reason to
> object, so please feel free to add
>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>
> to the first patch.
>
> > I'd think patch 1 shouldn't conflict with other 'wakeup' changes.
>
> Sure, there are none ATM anyway.

Thanks!

Greg,
are you ok with it too?
I hear your api concerns, but imo it's a nice improvement.
And bpf is not a stable interface despite some sceptics saying otherwise.
Just see how much sched-ext api surface has changed.

So if pm:wakeup folks need to tweak it later they're certainly
free to do it. Of course, it's better to keep things backward compact
and deprecate gradually. All options in developer's hands.
