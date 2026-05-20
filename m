Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C73624D8
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263493; cv=none; b=qHr5pGM+sm1O2lGb7mFSexdRuwQlV9JU3Seb4PkkZFUNwYtFBXsDRIkchTPXlGmN4aObV6xDv9eG+qi9daB02tjEsHejT75JmTLr79s6K9UGzWCgV+8+ZgJoDnRtJO2lXLD8bXX/X1nfAWQGQoEcMaKRGTWc2ODnpW2mwD2uR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263493; c=relaxed/simple;
	bh=lH18sPiFqtaIkbCq6WJ4DgOllJRgmWr2NqEXU38aSnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W16tvEJ3eC6XsjOFJPqXjDn8kRbc9Gs8ZYy1ozXxX3bYctmKo6Bl2gNwSVHV7mkK6ReeqqJdNbxnpJXKr8BnWFoQGabpDh2zqAJk0PwgY5K6k/3WikRKTS3+CmWQd/N6pphaj04KQJzizneeIKZB07w+jSlEhv4KX27xNmh83Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-6312a0d556cso1983489137.3
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 00:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263490; x=1779868290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NDejt992yDCTWkO0OE4bUSJB7qBtRwZ7hXxs6qLkZxg=;
        b=lRVhhhgkv9xAStZsO8UA66L+MqawZdrWkiFRJDoBJliVNsHVZcZLESegrCLBZseEjD
         pt088C5vgF/AfTSuV/4q6rNWA6ytb0B8hP2C0jJTkT1JEd7JCZBPcl4uKZEJ2SBKJST7
         +tnb0iwtv7JmgTuY31rMbNXap/5Tg0xqlVvvjtWPo7oBng57dCbvWz5/4roAwhNQ8SG1
         1FPpbtzRGUGpTnNPUtlNGNk3lBse5nBBNvJo2OP8aePAiCouk/1eC+WOvb2UpWvHfA2X
         WuotaTS59plU3174lZ2orRHo4TSe1ncWAX+pcnLXpRFS7OBofzT0wBmYLxEpI3yt3ekB
         tETw==
X-Forwarded-Encrypted: i=1; AFNElJ/WXL7vH9b7WEl5hXqLju3u8N+G7aO65kyDYw1E29RP43GYjBSHtXzcUIMXjdnZa/SAnW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk12d4VleGWjefSzc+fsB9VAs8tZl4rIoJuQlKEkhL6Dv8r2xu
	R3BYjZrhc8Uz5/j7uJVFbIpVVbRRBZCLWAyIHjAw6aYCYvTh0Jxd5PR2+4t2Q1p2n8w=
X-Gm-Gg: Acq92OEcG8LzJFWRb+ZW4joL8kg/1l9ONGSUlIyd3JUM9RpB8RQ1C9Xv77iQM/d+yXG
	y7kLbspYLyFljrz1CLzJc/QugQcT3oz4c96VzvzWqlvfFIP0SlJtF0ZtFlhb7g3+Qk9C36OxpmZ
	H7PEjGLgvNzVcxPKnXbHB/lUeAwUJmNQvJaY+BVQKHEcKhqs2cLMQUj/o7sBzAObxcaJ6THKDnq
	qFvJmozKTKAVCx9EaPjvQg8onxSUkJZb02mrlw/qLFe9Y0aD0do+yLcCSy2hDoOUbCfgUzXWPC+
	0Ftg9Kr61U2pWo2NIu8xxtsXASZCY5zD7fbTMPZ6fPoUB86T+ofJJbgEmZ9eF9Li8/hVJKFMKsv
	ideIK+ZjirDTrezs0ZcSrsLUpsS01tBbVacNuNmLKN0zSfXn/n3soe4JoORtTRidJAEmTTE4gTW
	mxHFuTGrsJv3BCanlYVzk0E0a12S6sV58yik6sZnt9LazlkDuplwoH09/Me6vO
X-Received: by 2002:a67:e107:0:b0:60a:8515:9097 with SMTP id ada2fe7eead31-63a3cc0d093mr11174824137.3.1779263489809;
        Wed, 20 May 2026 00:51:29 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2f8727bsm7809786241.10.2026.05.20.00.51.27
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 00:51:28 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-95cc1a5fe9cso1063216241.2
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 00:51:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ztoJB4UgqfYugHM9IQZZ9mmZtL58A9FbZUiQ4N8G3+t4sy4Gp1uDtZET1tb7nIK+1Oos=@vger.kernel.org
X-Received: by 2002:a05:6102:cce:b0:607:97b7:c283 with SMTP id
 ada2fe7eead31-63a3ee83998mr10853072137.14.1779263487604; Wed, 20 May 2026
 00:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519203858.1342507-1-arnd@kernel.org> <CAPhsuW60EONo84VkYbYsLHdAPzpfZ+ig8z=+M6NEhiNj_--qtQ@mail.gmail.com>
In-Reply-To: <CAPhsuW60EONo84VkYbYsLHdAPzpfZ+ig8z=+M6NEhiNj_--qtQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 May 2026 09:51:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVpT84X4kQ9nhUoYMcQ6rGkh5VhnbtQsSYGuBomBX7s4A@mail.gmail.com>
X-Gm-Features: AVHnY4KfwuTB56Nc2TM7bpddkjuO7q3wAHishd9BWbQagfH7_RJuMLKFJt4gzn8
Message-ID: <CAMuHMdVpT84X4kQ9nhUoYMcQ6rGkh5VhnbtQsSYGuBomBX7s4A@mail.gmail.com>
Subject: Re: [PATCH] bpf: avoid padding in struct bpf_common_attr
To: Song Liu <song@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Song,

On Tue, 19 May 2026 at 22:52, Song Liu <song@kernel.org> wrote:
> On Tue, May 19, 2026 at 1:39=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> w=
rote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Building linux/bpf.h with -Wpadded shows an unintentionally
> > added portion of padding because of the 64-bit alignment:
> >
> > ./usr/include/linux/bpf.h:1510:1: error: padding struct size to alignme=
nt boundary with 4 bytes [-Werror=3Dpadded]
> >
> > Avoid this by adding explicit padding.
> >
> > Fixes: f28771c0691b ("bpf: Extend BPF syscall with common attributes su=
pport")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  include/uapi/linux/bpf.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index cc4c0b62cdfa..0f0ec00cae4a 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1507,6 +1507,7 @@ struct bpf_common_attr {
> >         __u32 log_size;
> >         __u32 log_level;
> >         __u32 log_true_size;
> > +       __u32 __pad;
> >  };
>
> Can we instead add "__attribute__((aligned(8)));" here?

That won't help:
  1. The structure is already aligned to 8 bytes, as the first member
     (out of context) is of type __aligned_u64,
  2. Without explicit padding, there would still be an implicit hole
     at the end of the structure, causing a warning with -Wpadded.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
