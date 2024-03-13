Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7150AD25
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710292456; cv=none; b=rlJpm+NUL84+NAJX7wl8tw91ErPTDEgAURrFbFKGl7PDKtYILraU2BqPugFmzUTzos6lWrL3iczY0P/Gf5dUgRMKEuS6yHwDZ0ZoRLqbX99Q1UW1sGkEL3yKL4yCxV/cilW+ZxNYcYIROMjvwY1vBEoouHGwonrwQ7nK008Bh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710292456; c=relaxed/simple;
	bh=twMccmPlR7/SShgFg0AONE56vJVPPL3EBuKYw8SPbFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgsMYUa2jLrM5XKpv7sl14PphszeiHtc76ePgxHGxiTkmR/T4su6caebNG6bJccjqpl2mp/RnPtnCfdzYDJ5xjiN125p2Vv/zmgoIgKBdYymDFj5IvuGE5lFu0r3R9EagtThnzR6jcaRE4xYSH3MBoWSqVb5T58WFeFCca8v7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FDZNA8oD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FDZNA8oD"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29be5386b74so2308055a91.3
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 18:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710292454; x=1710897254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twMccmPlR7/SShgFg0AONE56vJVPPL3EBuKYw8SPbFI=;
        b=FDZNA8oDu26c1b4Iq8kZpI5sjsgzWxN3M1q+oBqWsp+edkBILL0x/ka8+/nChjOnBo
         cMYlOjrqOw6kEqUyIAMKHDstbnc8rFkNuM1rrWPxLO3KbA3p4Y++EQDbz8OKhAb5qja8
         P/1+acCyx9guR3yh+MkS99mdDHrWjPTSgvwyMWYpSq15boCnFJ9P6M8RBXrnaibQe2qk
         2BsCYF1COi08jt7I+YEdGO6oK2NjxCIwpkkFSRn8A/uCPUSF/O4d72djMV8nJFSKXwUQ
         W8cPGSiSEhradaspEmLUBW3lkkxtC0OsA80J9lNQ/YWJOsOA1HqnRU1xV0YI5hVDMg7T
         PbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710292454; x=1710897254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twMccmPlR7/SShgFg0AONE56vJVPPL3EBuKYw8SPbFI=;
        b=jsB3mXwVqz5P4Szf2ltoZfZRMZwCp34OZmAYz2jvH9bCeBl/blOXrFYBlmwejLNr99
         l6qtNbIrev4vKkze7Ts6nNsPYg3GbzRelGAnMi2C1c6SyiLh5zYRNBvXXuijmIHWJt21
         zst58vYllo1ugoSgowxFYqtHHvmtQu0eqOGlhrQJHb3jgeRYgR1Jx3aNQ8ldS0Qh7CNd
         LXN3R4AfdTlYexeY64NN75F9cHQNwYJQ88PUZ+PXdf3HuBhxY9PRTptCgZysrRfJmWnH
         Fo182dc1pByQ4Gxma1ujHZiz48gqZZjRJP4VMiyh/bCPiMLh991LzqmpkMPOBfWe+kXQ
         2vDw==
X-Forwarded-Encrypted: i=1; AJvYcCUJH+SWvaVBs+OaHSltUTawNU55sMkD49Mwx0vTu6uCg0rRgpfbyx0gVvW4RT6iQRJ41YbIR7GkaC8+iw9jkOhSZ/yV
X-Gm-Message-State: AOJu0YxrtN/dcAEHuUfADDt3plbxOnmCyk7Rgf0kvYa1DbS2eDkaCgi7
	7RFDENPgd5MIFJG0NxAc1/uLo2kVuLXn21bjNmxi9TBbx4wKymjCFeAYZUqMsUtqGUcvVH+TGlJ
	Zh3iR+bcsKQmnXJVrkWRUUtHGC6P/59xTIktG1A==
X-Google-Smtp-Source: AGHT+IFJ2nJztVxlcv7iF1fLo4e+81DiH9lck4a4XLEq2MMi6yrbHR+XGNXNfeaQ8LZdIPeyXdsLEIp10M0upU5dDak=
X-Received: by 2002:a17:90a:bb0d:b0:29c:5ba3:890e with SMTP id
 u13-20020a17090abb0d00b0029c5ba3890emr829001pjr.4.1710292454186; Tue, 12 Mar
 2024 18:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-9-dongmenglong.8@bytedance.com> <CAADnVQK+s3XgSYhpSdh7_9Qhq4DimmSO-D9d5+EsSZQMX4TxxA@mail.gmail.com>
 <CALz3k9hZxsbUGoe5JoWpMEV0URykRwiKWLKZNj4nhvnXg3V=Zg@mail.gmail.com> <CAADnVQJ87Ov6ny2hj-0_WymGB3TeuEZu373EmqmRJqZv-8Ze_Q@mail.gmail.com>
In-Reply-To: <CAADnVQJ87Ov6ny2hj-0_WymGB3TeuEZu373EmqmRJqZv-8Ze_Q@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Wed, 13 Mar 2024 09:14:03 +0800
Message-ID: <CALz3k9jf4Q7KJPes=omx5oBpEmoFNSvc=vp=D0hEa-51i7tc_A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 8/9] libbpf: add support for
 the multi-link of tracing
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:12=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 7:44=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dong=
menglong.8@bytedance.com> wrote:
> >
> > On Tue, Mar 12, 2024 at 9:56=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Mar 11, 2024 at 2:35=E2=80=AFAM Menglong Dong
> > > <dongmenglong.8@bytedance.com> wrote:
[...]
> > > Pls use glob_match the way [ku]probe multi are doing
> > > instead of exact match.
> >
> > Hello,
> >
> > I'm a little suspecting the effect of glob_match. I seldom found
> > the use case that the kernel functions which we want to trace
> > have the same naming pattern. And the exact match seems more
> > useful.
> >
> > Can we use both exact and glob match here?
>
> exact is a subset of glob_match.
> Pls follow the pattern that[ku]probe multi established
> in terms of user interface expectations.

Okay!
