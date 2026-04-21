Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5AA34DCFF
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803402; cv=pass; b=OsJLpuDaZFN6r+SR/TUqY+lXlCgMmwgL9+ZfxwHxaSZ/0Yc/MXK/Utim+H1Ma+z5Le+n9MfYmN/XkivJ6rq/bQp7vVoFb4ZTBUmaRDn4mCQLT4sxu6hhGQ6j7E0oJnQ/caPM9lOI1u/QtNPDj4fUZweGquid52lIJxf4P92L1hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803402; c=relaxed/simple;
	bh=1PWI3WWDiD11dCdku5DMvyC6Wz/XRvR3qkp7NACXhxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmjFhSI+C5HG1e4v8bx1+5YnfqUjYWAbLDAksOnsxb1W4oQu5nqRRTOyc+qrmY0/baKugZduMJu/7mNSUqwCN4VwfU6vToKup7JHcO6DLlbn47cLzIF/xhK1iozNo8lxyYvXy4YxBd56OKRrG3mcNSjagwuxm2eRSBhhW7F35vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnmypWBY; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnmypWBY"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso26097575e9.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 13:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776803399; cv=none;
        d=google.com; s=arc-20240605;
        b=MO90ms0axd0XDev6x/lz9tCfLkyIeErQARL5t/Y91NXMPhirTN8UXdlCOhdffgZrbh
         xV1VxnAZ+cBIWR/UvEVqUd/EBEd9TMln+ZPf/pZI7iicp2Od9JjMNDvRQcECMUFnBM9w
         4WSgDEM2IjS7xKnIAaN25e0uFeSiz45A/PMhx4kKtGQWMh3rNNg4GW6AOYjGBEwuXBoC
         h55aW2hP3IEONXfzO5gEGvxe9EP/9kNRyYbhJcO/nP9AF8eACyUGAdUh4E/6JuNm/0h4
         ycTm29imbMIXy+GSASdMYKKH4fN5t62ojMLcC6xmBYVZs2ja7MzXENp+KorcuoEcC26N
         ACig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=99MPOIYc8QZM+lDX2U1YrxVffHKZ9TWe93T8J1RuSaQ=;
        fh=iqo/8vDfm5Nzhs2TaBR7J3elgBmY8kEhvMaT4ndACC8=;
        b=PAHfy3fx9Wqdfb6KoM80t8K0qhGerbJJw2EkNXxRAUXzxEh0CyE/zfV3kuyTZfFMR0
         E3ExYl7n9Z43BVQJORL7QePBfQWVwYT8LUYXOEFbFCDcFbrhVBis6ImEg4UU12oguJCL
         IhNY8Vl9zsqGnw7SdiJP7UJCyx4fsFqSxasBblW2c75Ijbagl7UbTCTk+8XeKY0gIB4l
         rRS0EXh0pUa6IONLjvyGyZOEdjxRZR6nUIfN2eSPcIpboba/SbJRrnkbdLoIM+QUdmXZ
         pm7UvLTtsfeb+oJEEHeu2n1u8xUwjzdPiELwhhNHct1O/+rftLdTMGRw6r9JWK0meIx/
         kGXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776803399; x=1777408199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99MPOIYc8QZM+lDX2U1YrxVffHKZ9TWe93T8J1RuSaQ=;
        b=lnmypWBYYlsQyGxlvv42RTusaMJ09bDxL+uvMyR/QHlydOtDordg0nrq4JWlnBpGHe
         zSBY3uWWSiURv03ASxbkxF0vLvsfAE/IYDCwlrEVUaJLCUH4YNL+C5n8WDOYSfKz+Wgx
         fu9h2wOk80mJXJV0ZQHLkcHvU+WFu6N0ZmtQeNmk/rK1tvY3En3aK/j7Ug1ZOv+6ndAt
         IgYCmqxUF5WSmhmHPa9Cb/x4ExnrJsw1/8cyaTCE7OjSNO5ReK5OXIVQfUnbrqGyumbG
         LgxS1uNXXS4DhIXBZPw7//lnJT+QmsnJpWXAF+O28Tx9LDEofm7R3uSjd/39gFZfZCi8
         YbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803399; x=1777408199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=99MPOIYc8QZM+lDX2U1YrxVffHKZ9TWe93T8J1RuSaQ=;
        b=UlVy4HuScWBpZqhZkHUdPqvXQBdHHoHPvatZpvZyF2fEEwc4SlIYGMrUbTbEP8gWyl
         XR7bU9VufOsHznBjLBR66Jn5MrkzT62FeHdy+0q1yWcsJu0D8jZJGyEla+xFJQSTihjL
         tUjJZTYv1clgxRpNmmHzS9SFTB4FMLlrHvBaezYllgrTV+BzE+5wN5TNMdNpPF2cOUZy
         yJjUuiwtHMwrS/J1SPVrkqXCUK611We9C9+GR8l3qWW9cJ7VWdC5RaGXp7QeE+MfWqxW
         H3VvDrXF6sj5xqX1NPyalXDhKs/3MuFbclNjrDL6f9zxyHvBgX1hj60C4//Ce/dmKgPp
         HUng==
X-Forwarded-Encrypted: i=1; AFNElJ9Dh/6ZFaFXNKYlJ2QyIUowWPKL5HuGikmtmDbFnetXtuRcUP+UcYmVNefh1sQMoai/EIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQw785bQBoaNXRRqdYqYtDgDP06q6YSvBT3DXcIcflqzQZburM
	vVF7+izf6d0ahka+1Aa440pOpQg9GM23I9qQleWMBQx+/IRa/DGsV7QU0e1kFaXAmDUTM2/Z7dG
	joUzZtQhwjeI+oiGKIgsY1LK114som0w=
X-Gm-Gg: AeBDievcqklKzGV1sVLsuU4dTTq7zQbTX1NXKNRnqsb6bUr9wNhvLzA/iHp9CW75i1k
	Bwik5maI0duQtgB7WMvvDXFIrvivyrFWqG/q8kX3q7AbVSZEj06pMwNSAUbGx0TdmyB+d+qIVwU
	n0JgdPxsHdgtzbagX0WVuEBagDqVWIfWbJtCGUq/Pn4trWsZxKoc+lfRYo3bB+uh5XIfaG3ZCfi
	f3soSXgo/NfFOM/TUC0x9SUVbDCQGru0GaX65pXKFBdTb/IJ/K0XvaAueouXGiwg4rJMat1ksDU
	NZE2+peVmr8PKj2sKeInG5yTwXnKBgSl6CqaEchb7R0Oup10zjDqSoitZlHQQ3COFPGkG9+pdJk
	elXOc5vHW7JKh3Yqe8w1+XZoYrqkRPMdowVXm/mzV2jzvB2a0PAnkAhKrnHSTIAbUQoU=
X-Received: by 2002:a05:600c:8587:b0:488:a797:f0ac with SMTP id
 5b1f17b1804b1-488fb7880bdmr194389675e9.28.1776803399095; Tue, 21 Apr 2026
 13:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420203306.3107246-2-utilityemal77@gmail.com>
 <20260421010536.17FB1C19425@smtp.kernel.org> <aebef2Mz9fLoChwK@zenbox> <aefSL_kZ8GSbpdfH@zenbox>
In-Reply-To: <aefSL_kZ8GSbpdfH@zenbox>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 21 Apr 2026 22:29:21 +0200
X-Gm-Features: AQROBzBBg0QA_474lwIZdJH8GCRcZYj5ofZxaZMyZ6HQRPEQuJVnw-QeUoR3rNc
Message-ID: <CAP01T77=cADB+DmuTc2+RMdYKDMjSCaMn16bBRnCgEyuc5GqzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Implement dtor for struct file BTF ID
To: Justin Suess <utilityemal77@gmail.com>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Apr 2026 at 21:43, Justin Suess <utilityemal77@gmail.com> wrote:
>
> On Mon, Apr 20, 2026 at 10:18:39PM -0400, Justin Suess wrote:
> > On Tue, Apr 21, 2026 at 01:05:35AM +0000, sashiko-bot@kernel.org wrote:
> > > Sashiko AI review found 1 potential issue(s):
> > > - [High] bpf_file_release_dtor() directly calls fput(), which is unsa=
fe in NMI context and can lead to a system deadlock.
> > > --
> > >
> > > commit b9990bf55467191e86e004a62cdb84e6dc71b794
> > > Author: Justin Suess <utilityemal77@gmail.com>
> > >
> > > bpf: Implement dtor for struct file BTF ID
> > >
> > > This commit implements a destructor for struct file, allowing it to b=
e stored
> > > in a BPF map as a referenced kptr. The destructor calls fput() to rel=
ease
> > > the reference.
> > >
> > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > index 2bb60200c2665..ee5ceb82e4f81 100644
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > [ ... ]
> > > > @@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void =
*p)
> > > >  }
> > > >  CFI_NOSEAL(bpf_task_release_dtor);
> > > >
> > > > +__bpf_kfunc void bpf_file_release_dtor(void *file)
> > > > +{
> > > > + fput((struct file *)file);
> > > > +}
> > >
> > > Is it safe to call fput() here?
> > >
> > > BPF programs can update or delete map elements from NMI context (for =
example,
> > > in BPF_PROG_TYPE_PERF_EVENT programs), which will synchronously invok=
e this
> > > destructor.
> > >
> > > When fput() is called in an interrupt context, it adds the file to th=
e
> > > delayed_fput_list and calls schedule_delayed_work(). However,
> > > schedule_delayed_work() is not NMI-safe, as it attempts to acquire sp=
inlocks
> > > such as the workqueue pool lock and timer_base->lock.
> > >
> > > If the NMI interrupted a context that already held one of these locks=
, won't
> > > this result in a hard deadlock?
> > >
> > > Would it be better to defer releasing the struct file using an NMI-sa=
fe
> > > mechanism, similar to how other BPF destructors handle this?
> > >
> > BPF_PROG_TYPE_PERF_EVENT allows the kfunc bpf_put_file which also just
> > calls fput().
> >
> > So if calling fput in BPF_PROG_TYPE_PERF_EVENT is safe for
> > bpf_put_file, why would it be unsafe in a dtor running in the same
> > context?
> >
> Disregard.
>
> The AI was partially correct, but my course of investigation revealed a
> real bug / reproducible deadlock in upstream.
>
> In addition to my patch having an NMI unsafe dtor, the existing dtors
> are also unsafe in NMI handlers.
>
> I was able to make a reliable reproducer that deadlocks the kernel with
> the task_struct dtor on upstream (without this patch).
>
> I'll send the full report in a bit.

This is an orthogonal issue, but what you're adding in this set makes
sense to me, but please respin after addressing the nits and some more
tests as Song suggested. Let's continue discussing the issue here in a
separate thread that you began.

pw-bot: cr

>
> Justin
> > > --
> > > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026042020330=
6.3107246-1-utilityemal77@gmail.com?part=3D1
>
