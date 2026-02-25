Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B957280330
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772008915; cv=pass; b=FXd+xou8TrJYwuuupSy24sHfSwlqBQEBSw0J7aXOHGkNFkfiNZboG4+xde+4zvNT6ejBFMCmQUuERMPeLWwMhj08zYApEYfsXwviFlyRSsdnYeekiRAeQERLY8w4RgYqnG+78m85ZJ2+4nAkvsFG0+UjSLQ3PNKI/t57VBg9jBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772008915; c=relaxed/simple;
	bh=wVVF4M39OF22CFnDgc/z5jD1ft5G9WshuJgs6Fku9AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHn/bonm+++MA6uSaxhiXvqVVDGUTwA3mFMrw1VbyMIV2hO3cJCW0uf/GlRYVCap5kUrB4+RyvtrAS7ljAeOfFdhukzDnK4LRVd52QQ4dyTsxd+415VeZtWl3I1UjdunLEFTWtMbwOMce0AaLnQweb/KK11UVEZxFRTvqW83Y08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7x1ZgJx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcbIZZXN; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7x1ZgJx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcbIZZXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772008913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqJeychEvw+Ibn3A7j/Js2jJAC0aUjfqbjGzdXbGj0U=;
	b=T7x1ZgJxOIFNqkBkOrEAU8XRBS9r1SA+UbwPNkpOzbIzsyt6MjlaHKOljkG00loM//IQ/a
	1cT6gvW4iY2k2yB96xOK1vTLywyyu5WcpAeg4jJXXiRjARFHcAhE7FFkiCpTrn08Zgoi4H
	dktBxzO8sT2hhNAPbd65/MFAQinfNN0=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-RJsayKnaOTmopOkMCO7a_Q-1; Wed, 25 Feb 2026 03:41:51 -0500
X-MC-Unique: RJsayKnaOTmopOkMCO7a_Q-1
X-Mimecast-MFC-AGG-ID: RJsayKnaOTmopOkMCO7a_Q_1772008911
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5ff0acfbaacso628015137.3
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 00:41:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772008911; cv=none;
        d=google.com; s=arc-20240605;
        b=J7Ml2oIJjgRUrEX0RSLe12EyKw+BsUMiV0ImdyKznZ19WKKlOtdD3/2CTcQWGnwPRS
         OgOZBN+XoVfuLDREUez9ROGGMxKOX77kqbAcfFXPlasNtNEB9qJi8I5v3wBM9urJ9bSD
         aJzkVGOqozSgbGrs8uca+Mi4HNLHBDchbe6KnCBoBPQ48B3eidDDoNAvet9I2IsrZEYa
         +ZloWyvE5I+NzUxTzhh+Hj2i/iGNMwp0wZQUOGBhLCzfEtawmDJi5hHZARtWNDJAG4RF
         kusXIYMHFgN4U/f+PCh02DlmTr7bEPy6P9KcvHRNmnmE3OucxRz0sqffBoVj+GElATva
         krfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GqJeychEvw+Ibn3A7j/Js2jJAC0aUjfqbjGzdXbGj0U=;
        fh=F3LRp9u4RndWhCL46jAnb1Ay++hHI6IKRIJPDRe8TsQ=;
        b=MmMJCY8uFOpekXtOABZRXrohmoZmvVoie14O0zSgzbJRX1vBBQrCL9/NuG8/WWlooj
         S+vwsCC/mOaUDBZi+3wTquWxoHmFF1PSv4sgZNyJsv6DQkeT8eAFgJDHWLUQOnLC4vCt
         qA8/7ZljWUQKdHuobCNG8Xdy3YB0VP6i1NEg8XkZAgKot+VeXnsBLrFkAbWJet4WZMGF
         N6TpPg6yDcrePq788VQbFApyP+SKgx4yVKcgaVOa1jPse3CFMs7lKjL8mAH3fRr30PZQ
         4xvvY9gkJr4vdhIkN3YKyQkzEq/fUpaS0DR26476sLERppOIMAnTw/McmENJfGE3/xc1
         6tXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772008911; x=1772613711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqJeychEvw+Ibn3A7j/Js2jJAC0aUjfqbjGzdXbGj0U=;
        b=WcbIZZXNI0llbF3G4MSFw8HB1IYSLylhDLdPglsGJsL1lXscQCoc+POoryeSiJTC4p
         Por8nHjh7/H2iK2cEXpTCD5TTLTcC7vTVD8a/gx0FOQ4CdS/v8Fnenym83MGcFL1drGQ
         y0vPk/F/pkifkRd3bHv3ucpYGl2H0ZskpEkc5gJfzCODa3V+2iJPWuXbMx2gKwFjOgNr
         bklsye0+l4GxzEVHRsAV2deFm3e6tedn7917ahyJGB9PbcCgabQZyRzRKz6lEPdASMqw
         MbDjijGsIF6CkfvisUr2hmjg338GKzsGHJWUEIBOS3gsjVo6RR1M4kP1F4vYcpVEJt9K
         V6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772008911; x=1772613711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GqJeychEvw+Ibn3A7j/Js2jJAC0aUjfqbjGzdXbGj0U=;
        b=qk12WWzpnyUOuXbcXQ3fY3sJuNK0gK7BqkJNr6DHl80HUDKIp2YgpFfI8IJstWCGAb
         n+VZRALLRgFwwOnRn858RlUh9fb/fYKjefCfGfd+/WSG/rT8acbSrreFrT/e/M8SEEv8
         oWVhl2T3BPhh/D7aQT1yNbKco42Y4Aw5N2Hc+6Q+DpKCimKdeEwYphE5k33vrzGXZ+6d
         kfWVyPzwO2KIF03lDzZG/KYEQDvA1LuzTIn5WhLPo3aNKtETIYa0kqkXmrjjNjCxq8qv
         jKReu1wFBRgCUY1LUKir/Ai91sOQxZbH/Lhy28SsfQCk+D0FRI+vHYbz0bx4RNPqgXUM
         mRNg==
X-Forwarded-Encrypted: i=1; AJvYcCXvXzPUgVIdccqemIUV/JzNTNxw5RshT9era9i5Q35oCX+9u8sSpRTDyogKHKRbHQTJYvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZw92OdQ6soZmfEnPatx2CRpmvXcg6MiFMCYsn/0HCeEYTRrNq
	iXDAU6E7qQLSUmjxmVzdEQuzrJLKlnFRwX+uRoWykAxQK+65wvyZccsPj3rSwZG7boLjPdC0vjw
	uFh0SeOvMdWgBPUyjYxrE/8+P+i7JWEIr4l+dtfQNGQiYR7+4CEP6AZW+WCJkRu6yeAbPTxhUC6
	hVmQsCcokGgS1Ees/KtGsCZralOH6Z
X-Gm-Gg: ATEYQzzfxM4buQFlUTT79A7fS/RXS/BoLRDxjMvXqNCub6GcvNKxqPLIQtzsnCW76Tu
	3CvYz+Xe5u//EYyC9OyDF5lbhQ+ROSr0u+394rDMGFSPa3EOOWeqYlpAGJhvLPsMI/PTUcu61DA
	nJdxJuxlY9VNX/eULEnMJFVDDlPMjizuf/jPeaH2CZMxYikLZnwUosyF7uemfD4nVWR5xFjtoPx
	OV6ZyY=
X-Received: by 2002:a05:6102:5487:b0:5f5:3a9a:7db0 with SMTP id ada2fe7eead31-5ff063b0789mr551581137.41.1772008911099;
        Wed, 25 Feb 2026 00:41:51 -0800 (PST)
X-Received: by 2002:a05:6102:5487:b0:5f5:3a9a:7db0 with SMTP id
 ada2fe7eead31-5ff063b0789mr551578137.41.1772008910672; Wed, 25 Feb 2026
 00:41:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771327059.git.asml.silence@gmail.com> <7cc147a959ac068c55dae4f540e38e9e4ab121e0.1771327059.git.asml.silence@gmail.com>
 <CAADnVQK0RaOA9ZYZdYyQxOzLde9MR8HpMM0SexcW59A9u7X2Jw@mail.gmail.com>
 <84e2f3ad-28f0-4e9a-804f-2647cba9b30f@gmail.com> <CAADnVQLSEoZ0V1m5j3ggX0o0gzVKyiDHL=J6F0wRXB8qk-MCGA@mail.gmail.com>
 <591a7f0e-7b78-42f1-9486-163249f5e306@gmail.com> <CACVXFVPx5AcC9y9xVPCaahDeumNGm4TSkkfhsJ8w+wmW52JQ4w@mail.gmail.com>
 <ed7b85d0-38d0-413c-a28a-f3b0d1a72a13@gmail.com>
In-Reply-To: <ed7b85d0-38d0-413c-a28a-f3b0d1a72a13@gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 25 Feb 2026 16:41:38 +0800
X-Gm-Features: AaiRm50Lx0aBOKCi5jnRjGuV36AuW0E3_hU5uBR8m0P2oxYndDd8egjED4cAIfE
Message-ID: <CAFj5m9L_WPH_du4GMVYGBdYA_NX1kbGtJpAP0hbfuEjuk5faZw@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] selftests/io_uring: add a bpf io_uring selftest
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Ming Lei <tom.leiming@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, io-uring <io-uring@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Xiao Ni <xni@redhat.com>, 
	Caleb Sander Mateos <csander@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 12:30=E2=80=AFAM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 2/23/26 15:23, Ming Lei wrote:
> > On Sat, Feb 21, 2026 at 6:35=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> On 2/20/26 17:45, Alexei Starovoitov wrote:
> >>> On Fri, Feb 20, 2026 at 3:41=E2=80=AFAM Pavel Begunkov <asml.silence@=
gmail.com> wrote:
> >>>>
> >>>> I had such examples, but selftests is not the best place for that.
> >>>> It can use abstractions, and I want to make them reusable instead
> >>>> of people copy-pasting from selftests.
> >>>
> >>> Sure, but please still post them as extra patches so it's easier
> >>> to see what's the end result.
> >>>
> >>> Also please reply to that thread:
> >>> https://lore.kernel.org/bpf/CALTww28QMg=3DYXqKWpWLZrLO+xiqOe3LGyput8d=
x68-dnQsxg=3Dg@mail.gmail.com/
> >>>
> >>> It's not clear to me whether your io_uring+bpf setup will work
> >>> for Xiao's use case.
> >>> I don't think we need 2 ways of doing it.
> >>
> >> We discussed this with Ming on the list before, that's one of the use
> >> cases I target as well, there is no reason why it shouldn't work. The
> >> difference is that this approach gives a flexible framework for
> >> extensibility and covers a good bunch of other needs, which is exactly
> >> the reason I moved from a BPF opcode approach, while Ming's proposal i=
s
> >> more specific but argued to be a way easier to plug into ublk servers.
> >> If you ask me, we need a solution that covers a broader spectrum of
> >> use cases, but I guess it all can be argued in either way.
> >
> > One big drawback of  Pavel's approach is that it needs a totally
> > different userspace
> > implementation for using BPF, which is just hard to use in existing
> > io_uring applications.
>
> Not really, it depends on how you write it. If you need to rewrite CQ

I meant SQE has to be allocated & built in bpf prog, then it is inevitable
to move application logic into bpf prog.

If the logic is complicated, it is one big thing.

raid5 is a great example with complicated fast io code path, I'd suggest so=
meone
or Xiao or Caleb, try it. Compare your approach to the bpf opcode and draw
some useful conclusions.  Code should be more convincing.

For bpf opcode approach I believe Xiao has already built an example.


Thanks,
Ming

