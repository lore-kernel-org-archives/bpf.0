Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D14EDCC1
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894965; cv=pass; b=muJlDoWzWvsQgMCVtEG71jhBFpj5wAV3wK7KEQPpPeFKxxeqA1MwSgCV+FD6HACPV8BqqgF5kqTMzx3OLTxgjaAhM0ET0UxBCBE08rZa1SOuxOfJPVXy4L5SkSa9BpLEUK9b2P2sNMPTaCC+CJvFiIUbhOp+5MFKsCDaYO0fKiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894965; c=relaxed/simple;
	bh=KJz0ljhpxQV0dxuLmyAZzCH6KN1a+1DHS+L2+lDvs9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/LrdKWcmYgwxxMg7VnLubfe4Uyjte0jM3xy5q8xWd6qLTQyMwJ8ruitBe/K41FZ45MEbA5Ht/P4OMJaRV/RbqLjx36vrhlfOs+ZKA5iht8PalNfhdm1KjW/Yv+EMp/AXqj++C+FyqwqeHGG/YkLGAN0vHf4WsFof4hq/IMrtyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfwSn7zu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgoLMzzU; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfwSn7zu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgoLMzzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791894962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
	b=dfwSn7zuZu81ewqBOOFI/l9xBxfYJhLUcFdAPbnSmoghiBOkFiERe/7H8aC8j/8PUFnFxh
	hUEDo/0FrspbXA/QllExBFUWPEDUX14/KIH1NCYfGCUalH8BbQhjiAXAvmcIhVnRttbg9R
	J1fIDjF29+kS3QGm0E5Cg8ZicDZJ6dY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-7ElXdJH_NzusJvTYGPmzDg-1; Tue, 13 Oct 2026 12:36:01 +0000
X-MC-Unique: 7ElXdJH_NzusJvTYGPmzDg-1
X-Mimecast-MFC-AGG-ID: 7ElXdJH_NzusJvTYGPmzDg_1791894960
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2942fa0995so304913866b.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 05:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791894960; cv=none;
        d=google.com; s=arc-20260327;
        b=oQstHkJ0oxoQ2cFSGXIrIOTVZC58R9wWGdQWDLEknm3WvLnQwidEF0pnFHLbhsixqa
         CGn2fEdw5lpe5Z/gvvNtbI2LYZ5tgs7g6TF1TNeDDVkX9nvXz9MlvY68IRw1+PsxIAJ4
         VlmYhhu7QQaxDukAVbg5SoecNnh4XNgzzcynummf+RubaNxrkRbr39Lmga/39FXiYsc9
         3fcAtN2+aZOuecAAvBKR5dM2F6rNi/h5eSczAcKZNwe+D8Yuxb/YgiotZLGlUtmSfAQW
         3XhN0YbTdo+/Pihe+9p+5CDtiosnbcOmKhz+kyNwd7nCBbo+0hDZw12Q11dFkbw2njCY
         FZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
        fh=eT1JZztlTyTlXb53SoJ53NMmZ1v+l+GIgSC06QU2f9Y=;
        b=h4IrGqBOQGUAIn6Qfshu2oSpwakmxsFPWQ+rkUh5bOw+kdDwEovCiMwvUnUvgK4ElK
         nGtz7kCbo/NNW3y9wAtokHENvYjy4L25kY1Cjblx9pYQWJ8+n0f6+ob507jft5siw6oh
         bTViOwMRlRGzmJ7N7VjwOHoJPIRR/CzsaaDLtNfoU1Wjex9iLHxsyzCyibxD+oCaQdU1
         dx5Fq5OiRAl0/Er47XIY2ZsET+mOvQQu1fkm0aKL2PI0h3f2p63i5riRz2xdewgXOq0A
         RzaqczJ3CsFMsan/KRWfCBfokhhs7Xdd+cgfiSLrDSxvPVCSaSMx6t1YVQ0hqGLF13Ey
         VCmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791894960; x=1792499760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
        b=YgoLMzzUztWzAtGp2BsnHbg4p+kiT33FbX6LqK9gQMrWA1L2iCBRfHGuRar0q6PPvi
         Z+/pKSPqH9ljzJkup8+HBSxiFoZhhYF+EG9czbqjtvxPdNGONXNP8VzJrWWyK8wt1XJI
         WJmkye6UFTuSDnGTG+lWNQekyg9JvV578yJFbnZ+CB30MZKnFvJ/g2FG55n0ZYrYQOeT
         JopL6l+aVJkFYLJz1V3QLGr7MSW03SSWSdAIoUOmHauJXBNbtpwoVRzcLPZouXiBgWiG
         hACkPXzW6b5ieD1bEV21hIW1mcG/rZHsSqaWAw7jG0dKXVWwMufD+Bh/ffF5JBE9k6bi
         o6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894960; x=1792499760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
        b=yET2kBFb1fsIsvolHdNEcgAdvBFf87WvpwACR6jeXMOvnyvBJfZTHmzID6FOCbmMKh
         rblvFdqlODWbuvxDZ9DUHIkpUomiG7x9Ox3WhKx/FkHO0LKNVs+/b2a1Fa0UnO4IWrxR
         hyV5HGKiLtptSQz79p5NSTBk6psIyTtCYW5pMfShYVdp8NmOh/nSn409XZ/dC2Orjb9x
         Uf0WrFEmXWWxgpSGl13Fnku3eYGCCwfw0BK2YH2k1uPMNnVq4mQMdsQWDMgf+Wa+dMpz
         iK6v2/CcyGtgRxcFyXWB3h9D5UspJGAkCiASTVba0IqOZ4w0zlLzk+wkBYH745R7I6SW
         0goA==
X-Forwarded-Encrypted: i=1; AKwUvBy12Ukj37Kj2Y6Fcgc0MQMARguh07ss6H6W3pYs0G0tPcbkF51N8fhr1TyhStOTIjAcLEI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrsK9xwLNkcQUjDK5vwTIDqNBIycytwbH38CiI8yJwR7Bz5DSw
	35UMTqiKGU9OAZ4Sxun0i4lkWeip0HoFjb6ikvPutQp1GH5h8I0IpKM0yjFiO8ePf4ONoQZaBGm
	x3sB8+w3evedCAOwjWZ7DndgZf0zmhFu/hAWunx2rkW6Rx+1wRiq3IfQvbVHWypshV7YOE3vxJe
	deZ3T8uCJmc06OnhmuFi1EyOWKltbL
X-Gm-Gg: AYBFou1XURAYE0mXhnUBSIvATU05mU9No3NZ3gvLjrNNe5xglG6wQvy47luoOK7FFSb
	cZORv46YlNsKaVzvJihYhZflhQ0ZJdGtKJoaDN0BIuOK6+Vcdqq4eufUOjfo7LpPBcj8hqOyJR7
	XeQkYcPVtm7nIr1vTRpnfVKkgAKPz1R3jbuP3GokgYswm9aIwhTgZ2jQKYmdrfvoUEdE29Gmf+2
	6rncsIwOrp/x7UMcxDxQ5KYSxxz8+KN0roeOph6SOimDIyIboBdidtkeTaMPRXBcrAKWqidPZRO
	5DI=
X-Received: by 2002:a17:907:7b8a:b0:c2e:1b4d:e9e9 with SMTP id a640c23a62f3a-c31a9f6ade4mr1135545466b.30.1791894960276;
        Tue, 13 Oct 2026 05:36:00 -0700 (PDT)
X-Received: by 2002:a17:907:7b8a:b0:c2e:1b4d:e9e9 with SMTP id
 a640c23a62f3a-c31a9f6ade4mr1135542366b.30.1791894959880; Tue, 13 Oct 2026
 05:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
In-Reply-To: <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 13 Oct 2026 09:35:48 -0300
X-Gm-Features: AclHuK-0QABZ6yrPwALI3VDGc1f2HfQWIB06SZ96BvTfEuUJkskwg4GU5NbIk1c
Message-ID: <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> >
> > The SYSCALL record currently logs only four of the six syscall
> > arguments (a0-a3), silently discarding the remaining two. This
> > leads to the need for auxiliary records when audit-relevant
> > data lands in the 5th or 6th argument of a syscall.
> >
> > This series extends the SYSCALL record to log all six arguments,
> > by adding arguments a4 and a5 inline within the existing record.
>
> Thanks Ricardo, this looks great!

Thanks, Paul!

>
> There are a few things in some of the individual patches which I reply
> to in a minute, but there are a couple of "global" things that I
> wanted to mention:
>
> * As pointed out by Sashiko, when you were converting all of the
> arches, it looks like you missed alpha.  I took a quick look and it
> appears that it should be a pretty straightforward conversion like
> most of the others.

I've actually dropped the alpha patch as per Magnus's request [1].

[1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BL=
WOvDTt92t5Eg@mail.gmail.com/

>
> * We need to get ACKs from all the various arch maintainers.  Aside
> from the parisc changes all of your arch specific patches are trivial
> (and cleaner than the existing code IMO) so I don't expect anyone to
> complain, but getting ACKs will likely take some time.  Even the
> parisc patches aren't that bad, and arguably they fix a problem for
> seccomp so that should make asking for ACKs easier :)
>
> Since I expect chasing down all the various maintainers for ACKs will
> take a little while, and I'd like to start getting this patchset some
> basic testing, I'm going to merge it into dev-staging now.  While the
> dev-staging branch doesn't feed into linux-next (this isn't likely to
> land in the next merge window) it is one of the branches that gets
> tested automatically and included in my kernel-secnext RPM builds.
> This also means you won't need to worry about keeping this patchset
> up-to-date with rebasing, as I rebase dev-staging as needed (it
> intentionally isn't a stable branch).  Going forward, if there are any
> minor changes to this patchset, e.g. a few line change in one of two
> patches, please just send a fixup patchset based against
> audit/dev-staging and I'll squash it into the relevant patch in the
> series.  However, in the unlikely event that a major rewrite is
> needed, just send a new patchset ... but I'll be very surprised if
> that happens here :)

Sounds good!

>
> --
> paul-moore.com
>

-Ricardo

