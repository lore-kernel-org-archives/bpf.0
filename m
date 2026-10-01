Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB35C5304A8
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790888769; cv=pass; b=nKQgjE+keGZq/wdZizr4dLXCVCWv3cXxtpPJBShZfdT5dvphgF1cz4x250FqfKrcV1wAPUiuWmfzLWJSDurqcvKIQ4Mhz6n2X/PqQghN2SnbsrXkLl9IF3RUjBss+t5paykXxjdI/z+I0NtVH/vRK/NZeNr3DC3+q+eSi4UVLoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790888769; c=relaxed/simple;
	bh=xN21QYy0yGgz2sHT1nXnC/21nVEwjhkQB04Hg4E+rW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqvOcXbIriymqfpoZ39D30pIrbCEirkhzZW4NnN79RkFbZsQeI5LIlq3d3ZKGvjr3HIN96z92dkGeKnCYsLGQU7MNgkd4l2VF4X+vkFpRSQHUQKRkCJtk2UZjLK91KoyVj+Gtbm7AlbPCSZnMIDj9MIHPJwcH96JZYbzlTQablU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CAwV36pr; arc=pass smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CAwV36pr"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-885f0eca6c4so1421111b3a.1
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 14:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790888767; cv=none;
        d=google.com; s=arc-20260327;
        b=UpBFm2zTI8HVtn04Dt8YbMXnWkF/OL96ldNl/IPlLf2KUA1wzGGvTF2EumvUbLVh3a
         K8FA5f5TxkAeUrQ9nr896mKLgqYydxEfRNhbWxwjJgejWG+TMwFbSSO1GhF5vJSqN0i2
         GtGz98Szkl242+x2bCC1nxRUOcfJkkzapgZJ8lrnrsHbvU+zwtpp/8vsFdmJLuzDNEAg
         WtZyb4TsNGbMQaZBw2B+uswyHtP+Hlf9aTFEWbid0IuYOqepAVLTOd+648WKo6z2LmHM
         /5FinOCl59eY01r7r+IhVLtcjpQPDcfhyEuaoo5qbQOWOndr8Y/QmDMRha5dWHRhJUqX
         cs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        fh=oabitrVdmBTHDlY4wSsuoU7UiWMliQuzJPUBhj+OhzE=;
        b=ewBbQjtyLRKiUvrOrfHenq3GiYcjqHb/pWvNTaMVXZk14hS+aZwYVb3R/4Qsc14CNX
         nZZp4mAkuSoOI5MhoHMvN5UUP49b3H0JM6+JMJAwbvR7sMzyqfCLzn/N0eKytmGPxPga
         MlgW+B8gkIBXXJIP0KRZIrEnsGeuhE3DeeCiubhcX4nCC11lbE756lJZaNQnnUgmDfio
         u2ivO6nTauk9zykvuC7KeFyqF8WVlxJ+LPTQGRJfWI1e6MmombIotlrc+NT7SaX0Ky3i
         Mf7q4/SP7IcAxOWwgVW6/2viUJjau53gWVa7LFttM+CWAZKY2Al437TJpIZhXtHfNZhj
         rJbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790888767; x=1791493567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        b=CAwV36prXHOZw2NRE+aSACbPdDsBf2SHqbBYA6oNTHRxcIGcOyC/CJqkRH7LJRevOZ
         ClcJMU2t93f7XmqqwruK0c5ZXJiXQfI/+n+w9nHyb4EcEh0EZTu11pUBC9xzrVuOqKBT
         YsV75j7RrnJU55Z+JqH44vXWfdCbI4I+NCB8980IdTgu7vzPMxHvgU+uCw/+FxPpgY0h
         63X1M3w+g/hILuWVI8qWSFmlSwv2NKZwGdJ2DwWfYsxtFTA/lG+C3YADiA4myoIGj7HP
         Z1Ev8yhuTUNqN+BrgGDh8F6GLVD0gbmqkkcnf9FOFy5sLyuxAa1XjcNkIrhbHMfk8YG5
         z0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790888767; x=1791493567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        b=GparfmN9iMZlWUoF09cal871ou7ZBEniTNH0GqRsu3HGXXyCFWCGTqyReSvL/vJxjj
         AYKmHvgx4nxfAVXGzQCbGHJst1J79j++zHHL/9+vvMpV8ogi/eFtiJ3AFqKfc4ix4jfM
         1DKHfKdQ44QvHj3XD8nfV40mt4x3ZjrN0Fh44fNpESazqjJL0NpJOQgUz/XmXX3PeN1o
         No5keAmrbp4AuNiECu2e2iJNchB+VTWwBLVadK925K6LDuReuxtbhy4LqouvgEvGg3nq
         qigKqbk7tGwucUeeOcqVGAWUAr98pHj2VgNBHBu7faJ7M13aBIa/6GjHieq6ezwTqAWp
         YWjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhJgPhMlUjaMKADsUt0HyNrdhem8HDLu5lpa61PK/Ylf3bOc7ilq8Lntpr9+HLFQx2Tr8=@vger.kernel.org
X-Gm-Message-State: AFuF++noYv3kPYCr9rwj2Hn7OCaLBdsWXuxboWzm/VLUYhh8Y9s1OyTT
	8zg6i+4t9CrX+AR8J8u6Ld1XChbS2F9d6rxOLc2OsQ4DJkNAfFCtEM4P1nXI6BKsLraeO2RV/po
	Caw3a3XYrUxtqecXxoGYG7sgDNbuGXqTtf9eppNWt
X-Gm-Gg: AYBFou0CnfEb1YrXHLDZMk5XQscTgncJki5girnyUJWw8LVct88112kPFhMk/BXjP2s
	VVMtmeAcRAZOMB9ScfBA+uebpUB/Y+x9XFqQ0fb6U9kH36bLGiZw2XiN6gS+MEE68/m1Vr5+2yU
	vRdXcMueqUY7rMxOm0PBQz7y5/3/mIRWIqXgnD28fMv6Ex10np3dDKnIWCYUhv9VOFFQAExSf9y
	NOh9w9ObECOKpINAed7fbSoyz//+ElFPbYk8JA9yOLMtKik5O9sUsnpG8U6vBqRYdXpwSP7KV1O
	hf/scA+sWSqd7f1Qn5/2OkhOEnId6yppOzqFbCOIIdVOYrfKCOCkTvEFKy0hIzuoxUilzsstPfG
	Jeo4+eP3lY1u2
X-Received: by 2002:a05:6a00:1254:b0:881:5dcb:400e with SMTP id
 d2e1a72fcca58-88af6d24f34mr727169b3a.56.1790888767004; Thu, 01 Oct 2026
 14:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com>
In-Reply-To: <cover.1790088067.git.rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Oct 2026 17:05:54 -0400
X-Gm-Features: AclHuK923qNeclwyxHc-N96rTW9f--kU_8IWc_3FVDcJfFTXqnWMr4asd_Mjppw
Message-ID: <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
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

On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
>
> The SYSCALL record currently logs only four of the six syscall
> arguments (a0-a3), silently discarding the remaining two. This
> leads to the need for auxiliary records when audit-relevant
> data lands in the 5th or 6th argument of a syscall.
>
> This series extends the SYSCALL record to log all six arguments,
> by adding arguments a4 and a5 inline within the existing record.

Thanks Ricardo, this looks great!

There are a few things in some of the individual patches which I reply
to in a minute, but there are a couple of "global" things that I
wanted to mention:

* As pointed out by Sashiko, when you were converting all of the
arches, it looks like you missed alpha.  I took a quick look and it
appears that it should be a pretty straightforward conversion like
most of the others.

* We need to get ACKs from all the various arch maintainers.  Aside
from the parisc changes all of your arch specific patches are trivial
(and cleaner than the existing code IMO) so I don't expect anyone to
complain, but getting ACKs will likely take some time.  Even the
parisc patches aren't that bad, and arguably they fix a problem for
seccomp so that should make asking for ACKs easier :)

Since I expect chasing down all the various maintainers for ACKs will
take a little while, and I'd like to start getting this patchset some
basic testing, I'm going to merge it into dev-staging now.  While the
dev-staging branch doesn't feed into linux-next (this isn't likely to
land in the next merge window) it is one of the branches that gets
tested automatically and included in my kernel-secnext RPM builds.
This also means you won't need to worry about keeping this patchset
up-to-date with rebasing, as I rebase dev-staging as needed (it
intentionally isn't a stable branch).  Going forward, if there are any
minor changes to this patchset, e.g. a few line change in one of two
patches, please just send a fixup patchset based against
audit/dev-staging and I'll squash it into the relevant patch in the
series.  However, in the unlikely event that a major rewrite is
needed, just send a new patchset ... but I'll be very surprised if
that happens here :)

--=20
paul-moore.com
