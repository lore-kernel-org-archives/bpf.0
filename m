Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792759542;
	b=lYk/eQpzw+HAPw5HgCPE5wkFum1Uls0BZNg22RRKercvd2nClJiMl7m+v1g7/RARhsDW
	 M68qQTK6wfQHTm1okBc2FR5vjhh6xvXRszW62wIFDoQ+IAqCdI+vbkBrurpTh7aSDRCNm
	 TLsvcSYtBc00mCh1mv73GjZlRKlcNvjZHE5kJXUpyqQAW74MByCdJ3itFxyS0h/VxKNa2
	 b9gb2NYCPWNCWUynEqkzwtbr41mtDMrON5L4GhlXeJSFXPtHIjv6JaVrgAxyoI9dH71jF
	 T4+qcMSk0WKfYOf3DYBXPy/xHoErZ1DR6PrhUwEj67GTop+PsdlU4CFzc97yHa1nHQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759542;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
	b=3hgYpQ4tbeReooPKoTQ25E5KKewFXqyXsesEYDxhpnKwhb7mHvimsHQBRzGy87TENV9U
	 ITVvVoulvdWTFXE8vjSUeYxXim2phr8tzXbqHYYtobb4GbZp5lgUZUkNT+mA7ppo6rBQh
	 DHbSjjrfo/naCBh61LqjKliNL+aT/tcO7cQDWz57S+QbLnDiRwf0aAKldMie44IOMfznS
	 3OcNwNw2VKqoPyDMdk0+JVL72LFyhexItobe4RyN8IjkGwv6hqyjYAI4WunvIvNOMlMqS
	 vQfCh6w70HkaAzwlp9KklLLJk1bPD5ALq0iXtLVCpSk5eEx8gn6eI1IJ0+o/jMfVS2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HMqYc8W+;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kvNnk1JJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956BD606A31E
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 12:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 956BD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HMqYc8W+;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kvNnk1JJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792759540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
	b=HMqYc8W+fjXYuoeU0deohfy5BjhJjLWC+ARnQHn1fjyPD//jxOKKRuH9DQMYR6V1qkQzjZ
	5TSK3qgF+nphUNqAih5iWmoJe5pTMltxyhtRYun1OXReg8Bfv6GjGwaTYm9dohrknjPc/7
	ZRCv1tsqN2nhjo84uFslVuZURLH9gPI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-arI92JXlN_mCHfE-wCnHOg-1; Fri, 23 Oct 2026 08:45:33 -0400
X-MC-Unique: arI92JXlN_mCHfE-wCnHOg-1
X-Mimecast-MFC-AGG-ID: arI92JXlN_mCHfE-wCnHOg_1792759532
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c40285df2a0so47870566b.2
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 05:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792759532; cv=none;
        d=google.com; s=arc-20260327;
        b=b1NNybAEZZk5+S4kBHepP1fO9u4+PWbhObC8Z186yMDbI1SN9qHwKn5594rxOCpyPs
         DMxDL6GFrcU5DAJOW+v4rw/7p9wdHcMRu2515E5W4WMNTc9DvoTmlUuQlqFKiZD14r7Q
         o+A51LztSiC6LX5Tkb5hfXiROIAm8TLVQLRnCDxJKCn7VOWF6MmEgI0XhigLPE9uK7bl
         IK2PNKq28DwRTv5HgMLg5613+8dUKl5Xoh6wLvD4RphpfFNW+iQ+Vaj3K4s8dwBew5I3
         FQcqQrKUyBB8KJFH0uI9TjNLRuv8sVCLL+Oave7YooD1ZDDmFWpS7ROOYnco7WoUTYfO
         +eyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
        fh=6iyzOgDXG8VHkDVY9uYO/ueUrIKMPTRwyX/6eHHjqIc=;
        b=p+5ntrXfg0OTduKqGV38SwJpieplEapAvvvMejXw2M+kKi1zR1Pn9JQHTGtGg60+Xd
         hqELrOVQSkRqqT9WWN2miELkwV8Q/PM2myVZ06NO/Ah504Txf7l2wZpSzvUIUtiR52yJ
         64BYoahH2zEYLk8PyvryDuseoVKj/1A19HmdqgBypWXkUkulRgFvShcUUz0i5te5/jPd
         GA03xsoHl4QICDwk2ZlrtZNILaqlB5/vi/BsccBS9FCprBIuXDqAxuCzRLNNSIDoPQzI
         U3r+HhL/mflqL0OY4DXuxar378zpb0vcw9zswcSN6fAECNmvRZQbvD9dniBotm8IsjEm
         bm1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792759532; x=1793364332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
        b=kvNnk1JJq5fdRFGdNebQGgC7q5Z0qxP3L9LUL3H41Yth6fk3qBq/vZiBoiFYGjpoaa
         n0dKED8PrTcleCQwOwv7EZPUJSb5pjlDuNEjMabYepgzXz7C3LDzgy4bYbztjIZyxLVm
         9Xqzkh+s/Df+49IhCw6cb1qC+ZGFZ4Nq2c4DcUiiFr5dQqfAvw2NN8GjnWhsaGKkKTYY
         KzF7Id+sGWe/yi/p3xtqj3XYUidB030oWuXhAmSpJVfUlD5svLFMDnkRZ4hFBW84cWXH
         J5am/hwQZPE6DkBBvdYxtO+xDbckJ1JouoT4CQ4/tz5aQZvy3bGe6vJgFqQzFd7jFxWj
         dG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792759532; x=1793364332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
        b=rM+nIbrleU2U2LHqNyypdcNIkQQ/u4/nxhPgpJbxlUmgARSXckXIzTYZOjkuQMEZY9
         J+cdkshaSfWwylqQSjIMmckuVjzwRD+Xs8y+IomwnxMPCF36l1EwZvaeKbAZjXg2v6l1
         Gvwv2ssStETgi8zAO7BFIywosg0LJ1unbFes5UzGa9AeiyzDwWAdxNAS5PUSPF35FD6j
         1UX+ugh+N/kx1w8jZ/wLTrEJuRsx4xnSQz4pVJTDCaPG/WkjxktVEZo7OJ7OO4ynmk6s
         n1eaktoSXHUkr8RQChyHS8BM020y820Ma3qazx2EbSXc7GIfTkcMNS6MqLlz1TBZpoxw
         q1Wg==
X-Forwarded-Encrypted: i=1; AKwUvBxvVNJzCGIdPGWDWxAWm2YzOWY7LsVDQjc9CSQHtIOv7McWgMgb8/gHT8cLzg7VLT0Eyr4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLS6eKfPAqc9DPukSWg0q7xtsAFMpKFbH2II6QxvYizcBZ4wZn8
	Yz3MNY8nT3ZlxFA/61iDFL5XEW2sD+k9rw3mZg5sxysGJdVR3omPhy5IVxjeME/R3VjEXsdo2s2
	gYaAa3dN+pRqvN5pEy8poS+AI95Xw/Di7njaPwuBwls5l137HPu1cPZELhkOTyJ7zx45HVC7Sfw
	FO0cg7lwL8qP8fMAEvoEw9OcyLtNaw
X-Gm-Gg: AYBFou0ntOg7W1VvVvcPvnJlbEM91SbYAfuMogZvhS+L0k8hcpPKZ4Cd5c+Mu1/JsoF
	1RQdbkIXRUg1YyAL+hBzGzAsNOzLj4c4KgDbz6b9JXHHWRsnB27LLXOWHToSRvTRZSetciG19yd
	GIl9LhA33eHwDpWqMGNILLywcAd/3A2v4RDEW0nyZI805aSWKi8nV3ifRK5OGB19xzWPCe36Lkp
	U4BpfUacE+k7WReZKGAzsFMZQs+oyk6e7ziO+NDs+p8GPrPRG/Eis8/rvKG5NGxDz9QLZFuHT8a
	mRA=
X-Received: by 2002:a17:907:fd8a:b0:c2e:46d0:b802 with SMTP id a640c23a62f3a-c46a92ae6c0mr328357966b.40.1792759531915;
        Fri, 23 Oct 2026 05:45:31 -0700 (PDT)
X-Received: by 2002:a17:907:fd8a:b0:c2e:46d0:b802 with SMTP id
 a640c23a62f3a-c46a92ae6c0mr328354266b.40.1792759531460; Fri, 23 Oct 2026
 05:45:31 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com> <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
In-Reply-To: <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 23 Oct 2026 09:45:20 -0300
X-Gm-Features: AclHuK-AKUESe6iHVc-VzwOYib6sgRKlK0BCnAtM6wg5S60Ozyo0oOLLHvDr8CI
Message-ID: <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
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

On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@red=
hat.com> wrote:
>
> ...
>
> > > * As pointed out by Sashiko, when you were converting all of the
> > > arches, it looks like you missed alpha.  I took a quick look and it
> > > appears that it should be a pretty straightforward conversion like
> > > most of the others.
> >
> > I've actually dropped the alpha patch as per Magnus's request [1].
> >
> > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBK=
y4BLWOvDTt92t5Eg@mail.gmail.com/
>
> The problem is that as things stand, this patchset breaks the build on
> Alpha.  Perhaps this gets resolved during the current merge window,
> but as you know we can't break the kernel build ...
>
> https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.com

Of course, you're absolutely right that we can't break the build. I
was afraid that this dependency might cause trouble.

I noticed Magnus posted a pull request a few days ago containing the
"alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
resolved during the current merge window.

For future reference, what's the best way to handle dependencies on
other subsystem changes like this?

[1] https://lore.kernel.org/linux-alpha/ataJlL6L7TrS3gWs@z440.darklands.se/

>
> --
> paul-moore.com
>

-Ricardo

