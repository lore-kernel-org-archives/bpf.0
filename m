Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D4331A5E
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763281; cv=pass; b=p/jq+/gQW2EAdje2phDj3FaZzm1Wx8B2c6PfQs++w9o7XQ/mTQI+yPKzBZLvrx1RgKdvcyLEXis8wDtxZ5HtfITJr6WOKKUdoiRfG0cHJO+nJZ1OSNWoMC49aUIjD7iBYtZqUXjOHosjv3l4a61UVTIjcVa1KVwr6FSBRxp2wgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763281; c=relaxed/simple;
	bh=p+GL1RHk95VcNPV+7PanD4ja4B7TXU7D9Q0xAa76aMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFnhlZGCmFQeg52j0TxK2RnDp9+W4iuRNtel+UA2LcRjzIMpCQgAylqUB9uT1t/Bf/NqfVHe9G+22rcPlT/P0Todt6b0ldTW4MN91wWaP0KlTvgT5RYw5clOg216Y+Bcca/5547MpSw4kTiTKQZXjweRDO1h5lLfw1tbXGVJynk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1wfrgAU; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1wfrgAU"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso4909759f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 18:14:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772763279; cv=none;
        d=google.com; s=arc-20240605;
        b=Zqf292FtxiZIsqV5VCb9YDjUcYhXy0RvLyd9lOZkTBBxYdC0nTVaJuON4GTAaWkMAF
         Twt63hnvq/PeZpNjHdCmgu1v3tbThzXtlwizXKFoVdi25DrMENaNyYj/XeNHeX72QGc1
         ONEvNED0E65RysegVal/4A5h6HkvT71CpEX9J1mla/+fiHq1ZGheBrXUg8sNGkL9t18h
         NT/dMjURrcnSEJu4IeDnvdmCNOXLpcFFXRjyGNVCl+76OV8fqG14Lp/pKGLZoswX2mBk
         LVd9VvMEZY6cUcWYipoJHWeFlOfEdT4M4Oy6cyUpbBVfMbLIhf65E0d9gfyONM3VaofF
         tYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W1o4OYc2hfB7TCeH6Rp0sRLIPj8EEvJIdbRZH9fwEgg=;
        fh=SLLqeNFenzG78T5ZcKVeaGGtCPMzr8V9wTz9d6BbUfA=;
        b=MzGPdgxpJWf2M8TBXXY9P6cnHd4MDlOH4UbhqSWmlrPH7iBr/Zr1IkrKM9HU+3nhKT
         AAqBLvsxoAmzGfFb/92M1R9xrOnf0Xy8UjtaxnIQ0inMYEAWu0F7e4ub0+4niGecxD21
         GHw6CU55wHkecSHgE1eiqYf0dZBLoAgA951sPLv2tV6sOj0Sjhz2JlNuqcSwC8dhiwbc
         j7hyiQPpyek9TnE9QNvnCUrQ7qMb2w3dqJzl1jtJYx9lfbkWidfulp40RTcTbd6XLE8P
         W9RfQQwyo96knXg5a6WQT9hTahInxLjZr/0H0ukEZtJfqaCzaXHRBXUXrNvQqEzPInjd
         CBMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772763279; x=1773368079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W1o4OYc2hfB7TCeH6Rp0sRLIPj8EEvJIdbRZH9fwEgg=;
        b=K1wfrgAUJpaL9qMgU7hXDKrxC5XxX2Hat0fG605n49YJK3aH75q3BFYyuT9sfalwZb
         IHtHnNV2PT7mcfpHEI1sTkC1inphHy73ReVO+Kp1qvpfcVnYAMP0oeOAJtVvvzJcWeXp
         I80Hg4AliM9ZbrB74I3TCSBTYkMYTP1tJdYc0KcehHWRqmqzDCw9bh/NnaE/zyujdNtd
         JP4blWO+giDHHbkrXVy+kJEWTEXnzH8ahYySVe1I4Ge9L0hAgPW2M89ZbFkrQ6jrTBUD
         CAJ3/M913QBwFzVU9aCYgQ/2CfQ2/4QxZcv59gAZ8jnVuzmsr1sE0/mnA6TDR/IcixTR
         bgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772763279; x=1773368079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1o4OYc2hfB7TCeH6Rp0sRLIPj8EEvJIdbRZH9fwEgg=;
        b=IU4PJOjTKtzRCNAFnFJVpmD6jQazyDqXDBlvoXiqvdPPSLGxT5L2Av4/QMiiwm53JT
         l85WiyMLcKaV23fDP+MthEKR5Ql6LkGB+WhHVW9G32Fw2tET21OakCUsKl06wxS3lNS9
         DaAu9EHkIpBcFF+YDRTx+iStb5buiax4Jv0yAYljJObVYk6GDjtYwhCKb/b3rW6i8JqE
         kdY2XZPpVPZTZ+TDKGp8VhgUbZej+BKM/vdQPJvmvpUJKP7mRUWlNKfG7T795Qp7VFA7
         MZq4KOSbxUMsP/fMYakxAGYBQzusyaQLta6ZRz0DVqpBIOzLRFC3dt0SLrOPNGgzQi9G
         +M5g==
X-Forwarded-Encrypted: i=1; AJvYcCXkxggwaraQyc8M/Je7pKFDUrbjT4F3QFlfbb9n7lrrhpUGi36mps/tsWTMIKXIWLYb1dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE9+8d0gHAUtBP6++CIV0h5yz7PPt4YO5jq6Xe4K2DT+8fSDQw
	QsDx0xa62qExsQFr0fczFKN/PjOLWcwmapPMR0f9LWPwk2hoVo6SCa0YJA9cu3Hkq+y8jB7pacN
	PHcPXRoK4NP/9KmH4jFt+J8PV+KELsGw=
X-Gm-Gg: ATEYQzzEHnUyvipZ26c7pweoCJW0sGH/ABTt5UwxSnFWeB5HbXh67IM6bgsXjIWsVL9
	fgr/3CtAgQn9U8Qij/tOqJFC6UQVYveXQpn5dJaxwRPNK0bJjPUCLABHdkMG4J/Etf/E1CTBabJ
	UORz2css5yKKbpXu/6lnpxMJT1qLxKrRii2G4BT6un5gqCQRIQDDb6Jyz1ujT/3JCBOb9OQn+1Q
	729BsVrkmMZZOReIeYclSc1EnmlC7lBAL8F+1CGy7DqLkyn9g2+rxyJbWlcPPY0SLtYxEa4+d3u
	oIpYWI1XG/lNB7QZxVKClm8PZmPikzM4p8y4jeeTwV4OibOtgic1jJLqIxI=
X-Received: by 2002:a05:6000:26cc:b0:439:bc31:a056 with SMTP id
 ffacd0b85a97d-439da8a6cbdmr652216f8f.51.1772763278886; Thu, 05 Mar 2026
 18:14:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772721009.git.vmalik@redhat.com> <f93e9762-fa64-481a-8537-12f6af95abf6@linux.dev>
In-Reply-To: <f93e9762-fa64-481a-8537-12f6af95abf6@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 03:14:02 +0100
X-Gm-Features: AaiRm51rfp7lxETGpuzzazX11Py1LvUkUmLPQ8-oHtBIkzLlPsk6y2vPB9zjv1w
Message-ID: <CAP01T77dvSCyGq4L6XFS3uMeB7dTwCRvbePL-mnbEHDU7xvm=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Always allow sleepable and fmod_ret programs
 on syscalls
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 03:04, Leon Hwang <leon.hwang@linux.dev> wrote:
>
> Hi Viktor,
>
> On 5/3/26 23:25, Viktor Malik wrote:
> > Both sleepable and fmod_ret programs are only allowed on selected
> > functions. For convenience, the error injection list was originally
> > used.
> >
> > When error injection is disabled, that list is empty and sleepable
> > tracing programs, as well as fmod_ret programs, are effectively
> > unavailable.
> >
> > This patch series addresses the issue by at least enabling sleepable and
> > fmod_ret programs on syscalls, if error injection is disabled.
> >
>
> Could you please explain more about the purpose in cover letter?
>
> I'm curious about enabling fmod_ret programs on syscalls, as they are
> able to modify the retval of syscalls.

It was already discussed at length here:
https://lore.kernel.org/bpf/CAADnVQJ4PU7bCb5XO9+zMZhLRSdbCKwxG6Rtojh2Rc3UZ8H43Q@mail.gmail.com/

I think the next version could include a link to the previous thread
in the cover letter for posterity.

>
> Thanks,
> Leon
>
> > Viktor Malik (3):
> >   bpf: Always allow sleepable programs on syscalls
> >   bpf: Always allow fmod_ret programs on syscalls
> >   selftests/bpf: Move sleepable refcounted_kptr tests to syscalls
> >
> >  kernel/bpf/verifier.c                         | 79 +++++++++++++++----
> >  .../selftests/bpf/progs/refcounted_kptr.c     |  4 +-
> >  .../bpf/progs/refcounted_kptr_fail.c          |  2 +-
> >  3 files changed, 68 insertions(+), 17 deletions(-)
> >
>
>
