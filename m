Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F619ABC6
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777130447; cv=pass; b=R/GzL23H0sB+varemkdCtqRgydZjSZqCl2heAEXk07gxweuzatghEnFPHMio6UgIjEVbzG6uysk2UQ/iyESGHMRJ3jWO4ISr0KKAe9uEEq1JJI/JDVujiaLeAliPW4bymSAGhnLIe0dnUaf5oGl+r4Wy3KsH+fRRcHfEzAqYSIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777130447; c=relaxed/simple;
	bh=xvubfhsqRTC/s7rXmnD74zD4AoJQnJ46QaRB8hjxifQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2bwJBm/X0YXlq4B/YZvRN7Vgl4IiJi63GLlrOWnx3OnqR3GOfBsKkVyXTywCXcL1x7vhBdCt1ta1JPAxdrq4TGtTCB8kp2yYtu6Wg/Cf2e6p01Dwe9IxxhIgoNqceM5yhBa2fe4+tx1/aO67yvq1UMp2KbN+pCxYVZXTIOzcnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsxJxGO5; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsxJxGO5"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d73352cf2so7260003f8f.1
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 08:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777130444; cv=none;
        d=google.com; s=arc-20240605;
        b=djPmTLguTcIR1UmVME/Ir5+X4EwqSKRMArT06MQ3vGIqPDoJoS1UyY7Rl0Q6hxOTzj
         LTfycEb0TbD4oo+5KlCgiKFkDEnIVIdvXbOSSSlILyXAjz8li2qNj0RW+dmWcEYyEKhT
         4mQPkbvsUhTiZ/O6Ss/dK4l9GFrZxbfWfVzZ/erMNJRnPIargcGdiF4rJjo6ilPT8ATO
         Nuvxo2lMtO0d0mWB3UJ+NeIOGDL5pOMAaKINDjefwJMMKG5B/srofgvB8efX7LnTVUT0
         nWYktPzxd/x90a4E8/6ILkuumeNpAF+lHw+ah8X8FC3SPI/IhuC+oKcSKuw3J3mRSjqU
         Ztzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qQoEkJtWa8rndYMAZoGtt5FiG5NJwAZP05rusEwBNs0=;
        fh=wZAhWMl+ME0+PIRSzgsNSTEkId7HAa7U2hvAmykBHdI=;
        b=NkayWoj/Alr1byu/fq9WiMSIF9aZfj1r3KINR2Kz0gfSvSlTQsfvttVxEaQHvMWHfm
         qpkHf5i8zp2fc2mEqS2gnW0wb0Fw8hLGVfX3X9HiaXXZV61iMoaUPFHDjYrj/3ZiSTEw
         +2dKTumtUciYhm+16o5EQWdnPTj1tYd6fjfDJo2TPMsSsmQRynnnWL9i3JbeE/liUPhU
         PyWm4N62pSjn22+7xlVdVENlQYECZQnB0b3r1MbR83OdlITzvXxYZ7n9qg7EmSAQnoCW
         n7EnBB9qqljqrKabU8dgCK6gsHrwEtpJUUdyxVdQlSKWwBVfCZUc3FWBwdu+ynWpaeNc
         +83g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777130444; x=1777735244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQoEkJtWa8rndYMAZoGtt5FiG5NJwAZP05rusEwBNs0=;
        b=DsxJxGO5ApHHqL+5iuEbathuGsmeJ+vLPCXx6ZwSsvgCwSsHjtelr9XcHNnrfnZ8pr
         SxIYVMW1GoBUNORXidDJLxwId5R8ntoggf93l1NdezifS02zZpBEQ26Zvp9AN9s/39qO
         Xqs6KffqIypfooqPvqCpkmTCys6yU0SAj5OQxw4yZLgAGV/Sq2wB3YDHdq5WubWRk0YL
         A0ZH8PsAih24IJAHNi1THyc0A1gqkVtI87MYE3AcweGJFpAy1muNpb0Hk8kzA65OqUwm
         Y+PMyrT00XSVtbADP7SErXiu7KkVUvy92xxZTg8VXuoDddKX+yHLILEGEoMtzjXELN4X
         zIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777130444; x=1777735244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qQoEkJtWa8rndYMAZoGtt5FiG5NJwAZP05rusEwBNs0=;
        b=CJEQ2ha4519QMF6YrhU8ZEvub2207UWjGS11g1XqvVTiGTh1MVLtc/q2U4tMf80Z7r
         JJc2mjkBISZHrGT5AZC+Qkwg/HynGbOablgwsuZPUaievM68Mge/XWPsfUFeZ6T8ooqi
         3F3IEMXjeBY7uRvYYloa2m+xXf+P6ik7E5eqS73SqaDutcnxzrsvIpvoP7i0pryJN4uJ
         xiMIM+QdJU19fELpD1JsTscuYpkHOX39mbCBv28ioSndLuA8znSD9Qxac55/itgjtuhX
         5PDPLBqq1gU4D6URVg+4OyFWiyZrUnmKkQ7ytVWHuNZLicF9g0MMWEQk0jMC4+piQRYu
         Gm+w==
X-Gm-Message-State: AOJu0Yz06ZoMrUVbspBuwsXXVrufYKm3B8cHSil7C9+FfYHMo10KVRyV
	/tJ5yDc9+m9ZT71pVvZ5HKk8VBSiZm7pC4NOdwF6lrapiAWFQO6wNAIdgZBM2U22n9fBQERMrkS
	JGE90ocg2dOzw7A/qaqRm0cXxanQY/qc70E0IWLE=
X-Gm-Gg: AeBDievGVbcj3nx1QS3nDOOM2QhMA9hMISgknxIsk+gbqJz9DgvIGtyvML2udpzqYei
	VNZvkGWhpHTzQdmHrO6bbHgrK2OzwwidKBTtDIY4Mqanq0Hnj2G3scPgjvYygBqOOiZ3ormMZ/X
	KxWFj9YAIXXslov25Afczocx+fd4Go5dsBArpE+2CQlMfS1uAVDwX+49LXl4jwYvBqs3z9bRxcR
	DQQzcAjL/8TE0Ts/Gkj8FbAyAKsmcB6S8h33xYmWYuRkC1hafqs62dclgEfltCy/eb7nHOCTSGv
	/RDYQXGl8UaQAQH4/VyP9YSctn90U3djcth8SqThaMqSAILH+7tZF/vFTmw9SUybpdg/bDmMMia
	2UW4+be/OWV4agvnLIQIrIwY1Px1T+kdANKLiBtt5Uu3eM70=
X-Received: by 2002:adf:f8ca:0:b0:43f:e41d:85f2 with SMTP id
 ffacd0b85a97d-43fe41d8657mr39671498f8f.2.1777130443935; Sat, 25 Apr 2026
 08:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424-cnums-everywhere-rfc-v1-v3-0-ca434b39a486@gmail.com>
 <e0d8a24cbc3fd21cc361b93a3b25c9b412bc8c6a.camel@gmail.com> <eefc176f8803ab1da8bbb0cae03d35d8d3df661a.camel@gmail.com>
In-Reply-To: <eefc176f8803ab1da8bbb0cae03d35d8d3df661a.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 25 Apr 2026 08:20:32 -0700
X-Gm-Features: AQROBzBTbSs2Ao5GFsLZBpSMVlz7MOBmU51-3UeKjnYddViW4fyUpBOsuCGwn0g
Message-ID: <CAADnVQJa0x3ph51Eb_0UbO51B5OYfdfLoNdhMNt5nTD3LfpQ1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: replace min/max fields with struct cnum{32,64}
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 4:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2026-04-25 at 03:05 -0700, Eduard Zingerman wrote:
> > On Fri, 2026-04-24 at 15:52 -0700, Eduard Zingerman wrote:
> > > This RFC replaces s64, u64, s32, u32 scalar range domains tracked by
> > > verifier by a pair of circular numbers (cnums): one for 64-bit domain
> > > and another for 32-bit domain. Each cnum represents a range as a
> > > single arc on the circular number line, from which signed and unsigne=
d
> > > bounds are derived on demand. See also wrapped intervals
> > > representation as in [1].
> > >
> > > The use of such representation simplifies arithmetic and conditions
> > > handling in verifier.c and allows to express 32 <-> 64 bit deductions
> > > in a more mathematically rigorous way.
> > >
> > > [1] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
> >
> > Uh-oh. range_within() needs an update.
> >
> > [...]
>
> The fix is as in the attachment, the tests are still passing, but the
> stats had changed a bit. I'll send the fix formally later on Saturday.

+        if (FN(is_empty)(outer) || FN(is_empty(inner)))
+               return false;

too aggressive.
empty inner should return true, no?
If both are empty, is also 'return true' ?
