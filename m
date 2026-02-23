Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA4628CF5D
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860242; cv=pass; b=ZjFApRkJT4Uuo4W49P02FKYCKc3Cd7qhSqKQAOfI47bwws9lBETem0xBECb9zoL4KzLdvG1YDuVLQtJ8iSlsUOj2FtA1YQLN4G7xYfNgPD1SEHqT9CttNZ/Xewd2w5jag6C5N+AqLfwPp/b6Er8KCTRibYh/JoxVjYGs+VSvGMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860242; c=relaxed/simple;
	bh=raBCTCTSUvLUeIlNEor6xXIRdPMmDF/sZcB/wk9N3R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsNNDky4ypVu7/w9SFhxoz2ySlUnypVATaABEivtwuLbg+Ik3MOVBoyTUq3WiSzTL5zQiAdaWOI3XrTMkejdnnrSdW25e1BL3CHimOF7Dx0CD94Ik796imoPUN5erUC5s9Bq4l1ufmur16Sx5ZkOBIWQ6Xd7yYAUdSIBvw5MxK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoMj/FZe; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoMj/FZe"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40ea611d1a4so1365418fac.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 07:23:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771860239; cv=none;
        d=google.com; s=arc-20240605;
        b=V+IaMBvHhmQGm2edFTvU8rdIe2R0VSF6hcOTFxkdxsdi6FqVTVcse3vGn0lNGWyIju
         uYkaP/HgdveNfVnsbc9QrF/07mUM4le2qXuR9hBjF9LGNuhZGDrZWUTpXzZhNokEkoPl
         Iam2fxJcJ/5vc5NUm3uHxKWKR3Ez9Rf503Cq7n8L7wIizMypyO5wNkHP1zcWd9Sm9Hqq
         Xcvzelhli+qvhDtXss5OFqIs5ItHkVI2/J7CLAFI+c44agMJrmEfhO4oB8HuRPcncjvr
         m8wZpYCmiPewA2NkTYAH5s5L2Uf85mH8OfxxuosjDN5zIFRAIe+X0+eihC3ZAIKevl8g
         E91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iylOjxhh1Hwuz0sxmdpj0jfJrR+KFpeX3OYRYpW8HoI=;
        fh=A2yubMDYGgn7Ex6piUHQgbd11ct743wV2H5q+FOQIws=;
        b=RFj8xjDDEmprjEDu/FgIHl4tmD246bhLZpuU2ADIe+pHtOZiLmAJZ6IDmo7Az5l/Fx
         7Mgf9gZfI48dtNCffDLlSmS7zTg/OskwktbbuQNdkEk9gYqXu1c7G0AFromyPWCksFs9
         gTaPy5CRWdsQ9DcUIJc4STSz8nrPKm/mwHWcB22CNH+xRrHfSJiGUjGklIsJ3J7uIkA2
         M8JHPufFcHjTN4wvbO63+RHJoS7bvW/xPdGR1mu6OPOafHHQKLmn59GtdfgJxKXuXjpp
         ab3vBBTzs43x67KPixteB1K019fpbLtebgb6VCw5irKMIBVTYi3W2me32lub5x01c8p6
         G1pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771860239; x=1772465039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iylOjxhh1Hwuz0sxmdpj0jfJrR+KFpeX3OYRYpW8HoI=;
        b=DoMj/FZe/5Sc4GpED5qJnCWTtjdn9TRio4Jk7F7DXWSoLquKLzREnyNJqIafQtC4kx
         yBV8eRmY+bQSC5aNqxAFOrX6EZA4KKSCgnnMCFRRuSg8uXPhLU6WR/GZpkYI48jb/MZA
         LouJ4RDDKcS3sSKpJUxgCbHDRI3gV/aWkBdZx3RUE+f7OWtIulu1McB0W3eCOifmS1FL
         fWF7MLhQ2eDPrgH0Oh8+iUaJLsa9cZbdE33NrdR383PJ/3wJS3/tiDeX8/twqJwYUPrD
         cJfoi6scMVTDTrrj8AVEkpRBgbNolgsWQCNArRdfFiQWI2yB5skBus56ICywQcUh98nC
         5zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771860239; x=1772465039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iylOjxhh1Hwuz0sxmdpj0jfJrR+KFpeX3OYRYpW8HoI=;
        b=uXI7S714JB+pdAYe30xmTjgovi98Q5kqGQZttOn6l9CGg5AyTDacM9JzmZNIf0s431
         5NghBsDkmLt+TtPJHhyatyHI8e1Dn3aM6+dNJldS+QXKPp1QqPhSqAVbWPSXl0Z1xeRA
         9fPiENFeCKwrFqfzI7ZZh3Pg0N2RqG2luPq4JCnSy1Deq7/1cL/VsfUB3P3PNK+hNmrV
         Vy/tr0slD6r0a4O72OcGhPUmC8l1g9BoHsnNY1zsxZMlMHLxw4FuxwV7A0jYJkFsz5Tr
         x1LidLyRujeboygfPIs/VLkrzAJG0Vus0f0e4T9d0nPc1jFKgUJTYY57/9DIgpDWVyhs
         wq/g==
X-Forwarded-Encrypted: i=1; AJvYcCW31HPzNtb5OPFdVnffiJtgI/g8AhIpOrNBLLoGTLomLL0WLYEny1oF9qyBhbt+GvgOu/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eTNJ1Ei/uCa5D/J7zOblsb88KOjL2jR4C0oA2EODcXxj9T34
	IyhVxaqLIuXTr47FVnx7ZMeDXD0V5gXFJ1tAyHZ9RI+6GhtFabXratd+FTsEAlbu8ltHy61CO7T
	CH22eJxDivpHTn1Keo3yBI56bXMk3fvc=
X-Gm-Gg: ATEYQzw52cNbfuY0oQ6eJkA2pYsLkpOtyXiEHqfrhZvdEcCzxOC+vQq828v9rtOvJbX
	ieH5ajT16sPLUWbVuGzXDanlxeu9g2EIH8SBgd5UYIslDVAvYYwBR1bVXlBPCFQQDbxjyhq+VSN
	mswC/3PQA03YiBiP9xDkZq9C8cAwtcsYFAzyxerB21C3qQT6wm/IpHENoCibUmEn2BUpcEWenje
	bpskrKwI5jcnRSi9Gbpud2BAQ7+RwWlB2LMePa4YbJbiTztptBiFAiSLz4IF3G5vy/WW0f/0XJk
	hIirDj/4hyZ5oBQzzOgysoqNbneAr47p26CiJRqr
X-Received: by 2002:a05:6870:a0b3:b0:409:a408:ba30 with SMTP id
 586e51a60fabf-4157abdb0a6mr3985399fac.7.1771860238780; Mon, 23 Feb 2026
 07:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771327059.git.asml.silence@gmail.com> <7cc147a959ac068c55dae4f540e38e9e4ab121e0.1771327059.git.asml.silence@gmail.com>
 <CAADnVQK0RaOA9ZYZdYyQxOzLde9MR8HpMM0SexcW59A9u7X2Jw@mail.gmail.com>
 <84e2f3ad-28f0-4e9a-804f-2647cba9b30f@gmail.com> <CAADnVQLSEoZ0V1m5j3ggX0o0gzVKyiDHL=J6F0wRXB8qk-MCGA@mail.gmail.com>
 <591a7f0e-7b78-42f1-9486-163249f5e306@gmail.com>
In-Reply-To: <591a7f0e-7b78-42f1-9486-163249f5e306@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 23 Feb 2026 23:23:47 +0800
X-Gm-Features: AaiRm50mSl1h_4NN3vEpL1z8e_BPvhdUzWbq4PkZ6YA8PpW16DDFp2UnmKcYZ60
Message-ID: <CACVXFVPx5AcC9y9xVPCaahDeumNGm4TSkkfhsJ8w+wmW52JQ4w@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] selftests/io_uring: add a bpf io_uring selftest
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, io-uring <io-uring@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 6:35=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 2/20/26 17:45, Alexei Starovoitov wrote:
> > On Fri, Feb 20, 2026 at 3:41=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> I had such examples, but selftests is not the best place for that.
> >> It can use abstractions, and I want to make them reusable instead
> >> of people copy-pasting from selftests.
> >
> > Sure, but please still post them as extra patches so it's easier
> > to see what's the end result.
> >
> > Also please reply to that thread:
> > https://lore.kernel.org/bpf/CALTww28QMg=3DYXqKWpWLZrLO+xiqOe3LGyput8dx6=
8-dnQsxg=3Dg@mail.gmail.com/
> >
> > It's not clear to me whether your io_uring+bpf setup will work
> > for Xiao's use case.
> > I don't think we need 2 ways of doing it.
>
> We discussed this with Ming on the list before, that's one of the use
> cases I target as well, there is no reason why it shouldn't work. The
> difference is that this approach gives a flexible framework for
> extensibility and covers a good bunch of other needs, which is exactly
> the reason I moved from a BPF opcode approach, while Ming's proposal is
> more specific but argued to be a way easier to plug into ublk servers.
> If you ask me, we need a solution that covers a broader spectrum of
> use cases, but I guess it all can be argued in either way.

One big drawback of  Pavel's approach is that it needs a totally
different userspace
implementation for using BPF, which is just hard to use in existing
io_uring applications.

But BPF opcode approach is seamless with existing io_uring applications, be=
cause
it simply uses existing io_uring interface.

Thanks,
Ming Lei
