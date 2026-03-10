Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4D3E9F75
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174549; cv=pass; b=fm2assu9xEEO2e96LaLatvusoQ/LEQGOmxLp9m5u6EFeUpUEGRm4APOQMU8MpAwMWmQ9htHge0+UDAziiHVP5SF5kmGiCP7XpXmJYO2164ZuirSutBQqK4B55hqv4OwS/LNvvPnuj6vPxjubAyHib3tNEIVHTjthxu8htFTDfFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174549; c=relaxed/simple;
	bh=N6x0jYhn3luRrw5ThVaSTZxn+bTc9HcceunU96D4iLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCbz6XPdxWBCVnw+4gFjchFgS9UUgEjVhXZDnoAU94Pgoa37ILa2KEv8q2pJOyfmEZuSfy0jwBbYWEo/1nBT0WzG9iQzHq9gMZXtIjyjUpccqcz5mVtQf/ayGioymjyVTelLC3/GEnHVAESyOifzkvJgNJEFfwvjcaEFX7u/+y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFOiD/GQ; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFOiD/GQ"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48541edecf9so18220285e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 13:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773174546; cv=none;
        d=google.com; s=arc-20240605;
        b=MJxhzB+o4zl5869+AWExoIX7kmzrQV/otA7vDyNweUORJ7EGzS9pOP31RoHq8j18Qz
         ATrWQglUJJvYKiH+Bn0cOwdfbNhqi9XQ8qBO2UbtHwYuFurLMZPePr8SH3BZYJh4O5vG
         yALgEyEQ069Hm+3iZgOfpQIdDfTSxN+vk/uCvVDiQdJMgNQdAYXfSn4bK+LXQUauLcxq
         pE8BrAZp9HDluhsacn5xWvgDIy1YtdeUIjp1GVTcqQvWyw+A1Mm9kRG02y1yUNVdfqvs
         V3aZ8O/T7jJEyl6bH0WI1TwVeNt7qr81+xUe01oq1wqoM7F2vZ9ytfIrd2eEOgczrAkh
         mbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O0FEVAXmpV5gsVK5WkVg8WlCpwDU6JgtAPL7ZqJq3cc=;
        fh=eCJ0y+IIz/0iJmRYCxKQtY1Pmus0OnQ0hLKOwqGyzLc=;
        b=Pj7FeGWFerD+4BgjMKOlK7G1jcoh7XyjRG/pRduwJa3Zp2TK4NbFziBKOKwOiVrRXh
         DQ6mUqkJC28d0NyFXs+4plpn4ZD4bm6d1Fm298aFFCpHTiDGP1e/sNLm9UJUojLTBjvM
         KruYcarRKqYy2pp/ETwueo0dji5AZSgeD513gTBJ2rr6djqrcdUdjgfMUaZc63taPV0r
         Ll1Tf1CytnpsUs4XWoQfxUpmWQq6VG7gpbS3/O4cBZgN2SHkRfbBwtAfKhg2EEjS024p
         tvbQKNdv4aP+obTKkhbXPkHMBtSSmjvhnB/ruAsWB6/vahDBrpUapbv738+DB7ZIV33l
         7Q9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773174546; x=1773779346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O0FEVAXmpV5gsVK5WkVg8WlCpwDU6JgtAPL7ZqJq3cc=;
        b=ZFOiD/GQkev+b8nRVdKNNGIN76DA4Nl3EnEPuX8wcQPZM3vWjK2NxqCWbIE/jyWRR2
         rPXt2NqlIU7dulDNHjF7FJ6gByLCJ8HFpGNZHMPvh6T1+hZLFW017AWCNW0mbZ9w42eo
         MXgD+vfXO5nendK4cVqzvIuswGORVzb+MBjZCe3bAkE/eIYDypkLTZTl0n8uXVKULJxo
         vJBYG9LX5C0fSa6ATyIeQFV030u+gn+NLbYu09AktCWUK+ilMIUu5BH/q1j9bMcCZ6FV
         DIiZZw0sPm8iPgMFRxHAtmSE4FUKVffa5I4rUpbL8RG9OPNKXpFVCT4bTLW9nQQvaV6K
         im2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174546; x=1773779346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0FEVAXmpV5gsVK5WkVg8WlCpwDU6JgtAPL7ZqJq3cc=;
        b=Vy1XgAlga6Nr17Lfehdmk5vDruWYK03qVyv8XgAyBz57tUWBnEduC0BIo+dgNWMdDD
         yv0lrmtRrRmAXOtWkbFEaNMAggy0RYRwKe/8cidPWE4WlqcXw+0FDtdAIPLH7XP0+2JT
         ltJb0Y8jA2FACffu9K1O0uoSkDh6i+R/Ij7F3du47FcEurBTzFy1mxhu6J8E7EiIrhmA
         c+cPIV2kaZ2Pq9o2cljEwblzaWDRqHBg1HeUyQ7Go74XnqywhM6CJSnT/jKhsSCfx2cg
         X97sLWZmcEdECa90i4Jig97eloRY/x/6oNDWyU0KqfPtsm3zpA8NgcibuBAuR/w65CN9
         tGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnQ+dhTv2aNhv27K1uIcsUTlnF0XqH7QRVVxcdGhAFNYDH2dUFf2M1YQXJ8B0I8+qs5LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylNhkoJMPqdIvJ1i5Q6HxY8di/rKHQ9QLvD0b2DOACiNts2AST
	/kAOi+XMYL+8bDSrwh8SBYOjC3Mcq/Vq8scfV+IpGn+SD71SnsJZ9DEqsWKnQrq1OSf5WzyBM+c
	UJnNdiJQCRarJO81eWcKAhECizhUsDOU=
X-Gm-Gg: ATEYQzzfq00HVntb8R2zYdm9lCG8ODzu9wS7aUOkSkDnEQYYavJLO3/E8qJNEAjR4pB
	FlsRdyR2Is277/CB3TdkmdGF87ekK5R7vjqooHjzl0GSVyFh03FnIRQ0lAxtL7dJH17Gx0yuPM6
	p7F/ESbypUf6TJq82JIRf6+Y9viRmPqe/98TuCRDNnXH4Patnux2L0mtchBviIRUjA/s3274PCl
	QLypNJnAppIEH8xq7hOmXFS5ReCoIm+lNsLm1vx0w8Xfe4myf7vZcNwWqLFe/xBkUwaCRonyvOg
	GejOXKQVoI+ukoIIMpJ9pRBOGE2mgnSsdPYY1uUWj70GOPgWusnZzaplRf1DKWi32gmQFc8=
X-Received: by 2002:a05:600c:3b16:b0:485:46fd:100a with SMTP id
 5b1f17b1804b1-4854b10c9a3mr1771725e9.25.1773174546023; Tue, 10 Mar 2026
 13:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308134614.29711-1-pilgrimtao@gmail.com> <20260308134614.29711-2-pilgrimtao@gmail.com>
 <8f97dbb5-de94-4ac0-8b3c-e0ce890fffc3@linux.dev> <CAP01T76Nxy28ZAMi86Ez-WcCpiHKe2EBz4Y2j1XJjrRs=Qp-CA@mail.gmail.com>
In-Reply-To: <CAP01T76Nxy28ZAMi86Ez-WcCpiHKe2EBz4Y2j1XJjrRs=Qp-CA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 10 Mar 2026 21:28:29 +0100
X-Gm-Features: AaiRm520pPHQ4sBmL9oMqqosQfKRBxakZ30bobybTaG_1MU9wtOa6J7zkghjsYc
Message-ID: <CAP01T75XhkDAKSAGwE93H=s_h7UDNtee9neNWKirCDHU8yeV_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/5] bpf: Introduce the bpf_list_del kfunc.
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 21:10, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Mon, 9 Mar 2026 at 07:34, Leon Hwang <leon.hwang@linux.dev> wrote:
> >
> > On 8/3/26 21:46, Chengkaitao wrote:
> > > From: Kaitao Cheng <chengkaitao@kylinos.cn>
> > >
> > > If a user holds ownership of a node in the middle of a list, they
> > > can directly remove it from the list without strictly adhering to
> > > deletion rules from the head or tail.
> > >
> > > We have added an additional parameter bpf_list_head *head to
> > > bpf_list_del, as the verifier requires the head parameter to
> > > check whether the lock is being held.
> > >
> > > This is typically paired with bpf_refcount. After calling
> > > bpf_list_del, it is generally necessary to drop the reference to
> > > the list node twice to prevent reference count leaks.
> > >
> > > Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> > > ---
> > >  kernel/bpf/helpers.c  | 30 +++++++++++++++++++++++-------
> > >  kernel/bpf/verifier.c |  6 +++++-
> > >  2 files changed, 28 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 6eb6c82ed2ee..01b74c4ac00d 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -2426,20 +2426,23 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
> > >       return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
> > >  }
> > >
> > > -static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tail)
> > > +static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
> > > +                                         struct list_head *n)
> > >  {
> > > -     struct list_head *n, *h = (void *)head;
> > > +     struct list_head *h = (void *)head;
> > >       struct bpf_list_node_kern *node;
> > >
> > >       /* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
> > >        * called on its fields, so init here
> > >        */
> > > -     if (unlikely(!h->next))
> > > +     if (unlikely(!h->next)) {
> > >               INIT_LIST_HEAD(h);
> > > -     if (list_empty(h))
> > > +             return NULL;
> > > +     }
> > > +
> > > +     if (n == h)
> > >               return NULL;
>
> Couldn't you keep the list_empty(h) check after INIT_LIST_HEAD(h) as before?
> And we don't need n == h either. You could add a comment that n will
> never match h.
> The verifier should ensure it, since it distinguishes the head and node types.
>
> Let's say the head is uninit. Then list_empty(h) will catch that case.
> Otherwise n might be NULL.
>
> After list_empty(h) says false, we definitely have non-null n.
> We just need to check list membership using the owner check, and then
> we're good.
> It will be a less noisy diff.
>
> > >
> > > -     n = tail ? h->prev : h->next;
> > >       node = container_of(n, struct bpf_list_node_kern, list_head);
> > >       if (WARN_ON_ONCE(READ_ONCE(node->owner) != head))
> > >               return NULL;
> >
> > This refactoring is worth, because the "struct list_head *n" seems
> > better than "bool tail".
> >
> > But, such refactoring should be a preparatory patch. Importantly,
> > refactoring should not introduce functional changes.
> >
>
> I think it's fine. Let's address this and avoid too many respins now.
> It isn't a lot of code anyway. You could mention in the commit log
> that you chose to refactor __bpf_list_del though.
>

Just to make it clearer, since I feel the language above might be a
bit confusing:
Let's not add more churn and just fix the issues in the existing set,
and try to move towards landing this.
We are quite close, and it's been 7 iterations already.

The bit about the non-owning refs pointed out by the AI bot, you can
do it as a follow up on top after this is accepted.

> [...]
