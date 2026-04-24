Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8E37D13C
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068362; cv=pass; b=AbeALb2cpF5G79BQdysD7rg6q/OUDZmR1yWS+UxJgoQ3OUP4JcKLbWzIlQEr6zu+EevP2k+NxJFh2Dc6B+Gc5dWaU+Dc+Z5aACxoCJEJK/ctuat/a4xEYH0BPmjJHPbQsjPAnY5vFFB/kVS0gC1b/eegRgEDm/DLEpCPPfSif28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068362; c=relaxed/simple;
	bh=7gQQ0WbS6BfDp0nY6MJb9pQfWgZ9lXQf8swLrQ9a/AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UK0pSyNegqYGJguZXW2QQh3+FLi0YN54nX6NaLvOFoducLh0PS/bm6lK/Dl8pW+gxwDCt3T/2UjEHQDsZGXdMWvhyP7lOnARfw623+rgATWNhqxQzpGFC/9d6LXHLBvGhNU8B/sbRi2+vroZkftP9EHgEkyKNhMeL9ZEx6L6ncA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGsTNVz0; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGsTNVz0"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43eb05b1875so4878756f8f.3
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 15:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777068359; cv=none;
        d=google.com; s=arc-20240605;
        b=EesG1gE2JKNOIWe4FwEL4EMHbhWITzWyEUkiUNLzlzCJvKPCi0w3Y1A19ACZQ5vy7z
         sxR3I89k9uGNDODOJ4GW9CzqD15cyxkrmiW0zjY8uNVD3ZBVcjfC+qbU/QihsJ6c7MMk
         JJFS9R8vmxjOhatIaCjgclge8EPuYusmsZ/z3zG17oYtK1gOLJ4jBMzrv8tk8mnCZHNH
         d0mMI9wNTIa6sy1WbMkAi4gg5gBDyjDob6EhDqf0uRwKzaJQpjxI+tXuawpsCybJVsst
         sHDDX++LrpXGOE+qVCkSq9uBZLSiewPK3Ef2ervHgvMzIEO5Sc6fqJU4ty9iOEAlJkAS
         B2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r5RElcU3sJmtTmGQf615qTgHo6/2ahPDly8jUC64Wxs=;
        fh=Sdrs/urj7R8ylXUh9Is2BRte1gjRuva1QRLqOZrr2Dc=;
        b=Eld13iu7zX6OGtnJHpM6KQA/IXLmCwG3DMZvl7PD3Dk+Xs1G0RskrMlck+RVHnjQ6m
         j+i+cP7vYndtrXnN9C9iztDdTymtEtfug0kYk6vTkvjx++TzsTENXg/aDsr7/cT6nkwl
         RZJXaHAfG49cc9BXLWUXWlMnOkSOAS39TUocOfTVHm1qgQOi0EAygVItpjAtR/+gaI4h
         wFlltZivatEzAS1S8cxzDu3zoVz9gAr63Rq/4vKkNZwm45a4LH4hAi5v89RimWkOtfER
         R3gr22hWZVbCTQRLaZa1XjKSk88DLGq3wIK03cH1Qc7fCmslEjLk1BIilg2Qm+usYJBZ
         Vgrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777068359; x=1777673159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5RElcU3sJmtTmGQf615qTgHo6/2ahPDly8jUC64Wxs=;
        b=SGsTNVz0qbZXS+w0kyfxbxWZO4OmqQef1sOk+ssMviR0ZjzioAcGTRBvwxbWYDBE92
         sMmSaxZzerfv5kkiDj68HBPLR2M/cMBjUt1IB6N7PAHKN8VpVwnckoHFt1bpWeZM7qJz
         vOhFJmiUKHA6atz9jFeOAsgFpmQ7wqD17xvhMig4koAKdFvDiy6IVabITWkebv9hJgW/
         3vVCVJkoSNpIpBKr5MfOvXYJBLsD0OP3WqX5oZvpnNoei19Lz86tjhc2duSSzRFyy+9B
         RPwi0cMH98dCZB8l5tTNaaj2Nq1y1wYrwIAW2ubWzytHR5I3b+5QWb2HonMrOE1bp28f
         pXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777068359; x=1777673159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r5RElcU3sJmtTmGQf615qTgHo6/2ahPDly8jUC64Wxs=;
        b=MaccpdyXsnIC2nFVW0EqurwbOz3URoncqtpjrexFQKuDP+yh5G55bU3iq6NWazYrMg
         QbIId+4RnlCR9ZyDNQfTxx662s22yI0wVDU+59lHmTNXJ7wWdteZnm8uyTU7wKCT6JVw
         9FSbzVefmrZaTeH3XcGBeUYYNxG/uqz8MCmi2Su3toosIv8DY2EmPAb1ZtdfzXG8hV2A
         +64s07UTt2CWZqRnjO+mtD++UjMh1ipKmFaGlsYj5/B+MB4dATbnU+M7ojTzQ5hfhUGS
         N+vIB2Z4w7DbQidJEa+hUxVmqzLnrR/e/7c3xo3MqxIrCYfJYtfAQ+zQiaQTgG/d2Eln
         9akg==
X-Forwarded-Encrypted: i=1; AFNElJ+8xtqn9lRnnIO2QCLiTAGeiwa1/0PVxmc3RGVoZv9BNYCQFi1ZaccTscwA/3gbrkEI9Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHiJHRokVMH5oy1RO5j7H5WaRiXjuufLtYQN+yEDbL3RwLhhhc
	qp3MBEV0ZxU/XQrMVMBJKkdzWl6asviUS1xyWPgj9IDgCNcK7yMWhqbdG51CiB67F2B9FOeWoAy
	0mFylYv6syVBjDcd3xgRX5Nn8hRRavEXErVC4
X-Gm-Gg: AeBDiesOFK4aV2CtaTx4X8VQankJVj0kLWaGKS1ZyNzeCLaDPXcViyX37iTyP+CSQ4r
	3y6aW96a23H/gsQa8PISTcCjmwoMhVAzo5e+lKxqyhCigZ3ZIF1ttqGKuKyGMHZIF2cx+k8bQR+
	Sajt83zVe1gP7q7beMzJytRMmFyuxXn1ynUFsrio86hdJSZsRqpC0oj+6D/k2TySHRPcGZSpNsu
	ejbNY3ckNP6Ub9H3zZTDVvxoUg5CFdTcdPC4zA3S7JLv+2ceN+GQX6uTdVH67F5K/KlUzBa+Pbi
	PxfkkDSXV2eV6zM+nTyRDPtEPd0k03usCIYYJ0f4Caw32wAgc259N2YKGXh9I2x8gq1QKl/Ex0M
	CiK/t2PrYGgZ9TETUsMT2NBE6C7STNezHOBhA
X-Received: by 2002:a5d:64e3:0:b0:43e:aa88:f1a1 with SMTP id
 ffacd0b85a97d-43fe3dfd649mr52383468f8f.30.1777068359361; Fri, 24 Apr 2026
 15:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424192252.695240-2-utilityemal77@gmail.com>
 <20260424195958.AED4EC19425@smtp.kernel.org> <aevOssMWH_Vm9CPG@zenbox>
In-Reply-To: <aevOssMWH_Vm9CPG@zenbox>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Apr 2026 15:05:47 -0700
X-Gm-Features: AQROBzArnv5I2cQAO8z3xS8tXYahE2_qJWz1N6nhxxHXWgkmwfxIdd0w8y8BVa8
Message-ID: <CAADnVQKFtuX48V9Yy88GHGVbQyY30M3b3YBvZ2PmYt_-jbohpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Implement dtor for struct file BTF ID
To: Justin Suess <utilityemal77@gmail.com>
Cc: sashiko@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 1:12=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> On Fri, Apr 24, 2026 at 07:59:57PM +0000, sashiko-bot@kernel.org wrote:
> > Sashiko AI review found 1 potential issue(s):
> > - [High] Calling `fput()` directly from `bpf_file_release_dtor` can lea=
d to a hard deadlock when invoked from NMI context.
> > --
> >
> > commit 6368f91be1fd91bc9cb38d3498f35d279bad04c9
> > Author: Justin Suess <utilityemal77@gmail.com>
> >
> > bpf: Implement dtor for struct file BTF ID
> >
> > This commit implements a destructor for struct file, allowing it to be
> > stored in a map as a referenced kptr. The destructor calls fput to
> > release the reference.
> >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 2bb60200c2665e..ee5ceb82e4f812 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > [ ... ]
> > > @@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void *p=
)
> > >  }
> > >  CFI_NOSEAL(bpf_task_release_dtor);
> > >
> > > +__bpf_kfunc void bpf_file_release_dtor(void *file)
> > > +{
> > > +   fput((struct file *)file);
> > > +}
> >
> > Can this cause a deadlock if the destructor is invoked from NMI context=
?
> >
> > If an NMI-context BPF program (such as a perf event tracing program)
> > updates or deletes a map element containing a struct file kptr, the BPF
> > framework will synchronously invoke this destructor to clean up the old
> > kptr.
> >
> > When fput() drops the reference count to zero, it calls
> > __fput_deferred(). Since in_interrupt() evaluates to true in NMI
> > context, __fput_deferred() bypasses task_work_add() and instead calls
> > schedule_delayed_work().
> >
> > This leads to the following call chain:
> >
> > bpf_file_release_dtor()
> >    fput()
> >       __fput_deferred()
> >          schedule_delayed_work()
> >             add_timer()
> >
> > The add_timer() function attempts to acquire the timer_base->lock raw
> > spinlock. If the NMI interrupted a thread that was already holding this
> > lock, the NMI handler will spin indefinitely waiting for it, resulting
> > in a hard deadlock.
> >
> > Would it be safer to defer the fput() operation using an explicitly
> > NMI-safe mechanism like irq_work_queue() to handle arbitrary BPF
> > contexts?
> >
> For (human) reviewer context: The NMI stuff needs to be addressed separat=
ely. [1]
>
> I guess the AI isn't gonna understand but just doing irq_work wouldn't
> be right either as it would break operation ordering for maps and
> fixing it here wouldn't fix the other dtors broken in NMI.
> (cgroup/task_struct)

Will break operation ordering?
What do you mean?

I feel we should fix things first before being subject
to more of these bugs.
Why cannot we defer to irq_work the whole map element if in_nmi
and call all dtors there?
should be a simple fix.
