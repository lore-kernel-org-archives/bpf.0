Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793058730;
	b=rxYkkz6PdLqfU0sU+cazJ1rcbFoS+62rFxYMM0YJNybp4PRfIzs+xHQyqYBTkk4wThqA
	 szH21ZfbNYv4Hnk5uYuxG4Wi2gEzeJOsADQnltHGDVp5CpERBb2p/38PuTFMV9QNKz8sQ
	 XdgdaAygyh5FrIRkJVwjZUscL4AJ7B3W0FY38Pr1U7z12HwfcdeRhi99E1bji+wG+W4rm
	 GOQVvwaEIY2c3O56UzI9ZPBHEFNRKNn1iiypmnFWPaMisxLYPygsb4SKT2xvKHnH6XRLT
	 BrpWCZRL84fDFjQGjcBPAQHQS1b1poioJZY+gapeMMI+ANIUi3i11x5cS5iA5ZCbs2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
	b=Ff2cSMncf7c1/HMQbhQyYGA2gm8N59o1+3Nv6CSSG1zIqu6vvgQ2AY6h0h+FFE/4jR+X
	 3sbjbFfCvuzUCuuuNkvD7o4uzvKCM7PqXrK/PbCzG5zTFD1jWUMfeK7FikeFoEzFPSKR7
	 Ct+lM2fxQf0UKfq5BWyr34IvmXjT1AIXJILT7tg4PvHzz1Sb/ZZZVZ4eSAU26S3LwZCFP
	 QUlhFvw/CMvPzXlkkyDKyNUGWUPoUQoXQVVd+GhY/J/pG9oppQUcaNQIIR5fpTZMETsJa
	 Zq9ZfARUz4x77THBqriD8aZM8UonBT2FhoOwcFrvcxNg98MTGbtmyIHGRxr9CgU1a4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IrwijN25;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B4606A323
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 034B4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IrwijN25
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b47bc5ee46so428044a12.2
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793058728; cv=none;
        d=google.com; s=arc-20260327;
        b=UAuY7kq8Fb+6ImZv9db5z025zzTKtd8ySh2XwDiqEX0qSpiUNjWtSqtCNXxi2kqgXc
         b+rWVNHbBqDqz0vy5bLBgqwD7aeMpD8X+CTWfWJqey9qa8RCoYxt6DtBqGcjxE16gc1i
         xHRQWErUdON/ZMITbE8i2oyqARngcIy+vuDKa0t8VxSkodPeMsI1o10/bJXcxjZD4yU1
         I4NGUsxpomApseGnw9XBuTH3Y1ZAzV8nDUTI5KxX/4MjU4UO8LPm404UzTd3qR2LTxhj
         dZPC1xyPXjWBWr8Dk4KklnIf8ORJ2OuL+FsxoZaMg6EMjc1aFRFXoT47f/axU4VVIrc+
         B+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        fh=R/Id75Mbp//uef12DBaIbhpdrHf3OfU1zO7T0R2YO9w=;
        b=JG1LQiHHK9Cgnp5t/g01iLHlySda3y0mNVulqFiy0hLlWEnnn9Dkz9gA+1l2qt3Z42
         5fL31FHznI5oYT176gN5G+WyrV9CsKTJ+yRWrBSIJaejXWWsC7JL//JnN/9cnZXgv+Py
         FG/OPytbmp2UPGbN2Gb2SuocK5Wc3K+NP8XEbhHdnWvzWRi2bsfatj4pWkusljn+Y+NN
         2ygYMGT8kyjb4/HpAP5Gea3+sl+sJGiMniften3B9vWGqYW8MRvU4tOizPFZ/Qjjs1Ut
         QIhjhYXIXFQTBa/wg7RBvvPSeCAz5L3fUsSL6HDcDkVVcWQ2MV3Wb/olQM7+GD21BhHs
         4Y1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793058728; x=1793663528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        b=IrwijN25Y5XuhkNoEvpxTGUzu2F8Fw7yumOC6bQX+sv9sI5cIkUQ+8qDyW8Rn0leIE
         KD/M3UgHYaJH9qxw5QEzap4cvaO8QRp4WvUy/b8d8qlbP4zjT/NLwA46mVK4rk5TE67Z
         hbcIs7JRXy3S3BU1Zp46QexhDFTfTqhgb9F5yDiJoNepIvxVOAnGlUkvuMj53pVOulEq
         nY7AospiQUxyoh3b4b1zlSlhp0Xm7S9U0DWHUHqyywQpS6V9BxBGr6qPvm7+SL/x95K4
         vKS38fvl7h/D+VqUiNNcMPjyNlpB+LfGZlaoNjHo8oTsgp0eeolgiheQhrTjRg97kEV2
         ylBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058728; x=1793663528;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        b=x4nY5fDqAgm9jS2x/tZ2kTQY5VrpQHm7qV0fAlSpBbewp0upX6oQ4jCGe4VxXmz85m
         HxYqFWCgYMuAJinL+d/hRMmt6JAxRm1UtfJuqwsLPOgwnQjHkxAR9wGKmcamFZbiwLOU
         5KD2gL31PuNZKxKszEvTc3xoKZoEt2v3fxWavTFOMbZLqn2KYSSgorpW+gfxQtL1byKF
         1JAQPB24PDV93MgaY6OhNZFzBz6bFPMxzY9lWkXhl0eES/N4gB9luyBbnSqBFkDuTdnA
         2FR9nH9r16Kn/yf87tyW7UicFbw8WEcUHQkwSZS34IHeVCBrsa4Jpdh6lgszI5FRzIGb
         LIeA==
X-Forwarded-Encrypted: i=1; AKwUvBwGk45boINbbGK8iA6jFpIE+hMN7WNJ2cLGFq19tcW5CBV+b1goAWpO61bptoOjijGrt78=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1faXBaKAETihD2qvg5ecvNX+HipWMhwXvxwKNsDYfxEOKQc5w
	WCOknQl06vU9fB3u7UvGa1xypqXlQtzjhCG2kNXjZ6lTVw8QvtC/W+ghPWjdkcaz48VGHD6c7Sz
	JBbFDbEhxloTc4HbtXjW3C1vvn5tWVwZLewUYIFK3
X-Gm-Gg: AYBFou3/34NL7kh9lAaIeT016ypcvUQiM+J+Jj1Y1AfwRp6uYc0gvNkUu0x/7gEyWMW
	8byIlWhjw+xDSNZaL/1ABBZxwnuReSEon8UvXafTp1X6pwbSVFaEfeSWgXTReUYJzrcsGghi9li
	AwfPn/Ee4kGljXsCHNbJhg5AjFSQT3nZFFIUFZBn2t3Dm/aodGcUgoJ06HxBzUtajwKL2p1FnUi
	Z/vSAUbw0V8wAT4WKDst5b6TiKR6BUUkTbedst6hTOPm2BSdisP8LS4DaM7Mm6gpJyHv1OBYDGv
	FEFndzQvUKT6QR5f8yktMGfH+5rnHG1hUG0YM/6R478TvetWcnP6Pli4CUxGctEQ9v+/sP016z+
	BOyZ6Af5mFDi3O4o57WI+fuxDAiom/Dh7C4yJv+dYHpt+vz2uistFTfhHESnAmUlEzPhNj87QtY
	UiWG3qLWBBF09rua4JmHsvcdUOJe/5kXOZDgK2KU2Whn+PKnM4yZF+oMwQAXF9/gHifoch9FlfN
	J3EFkn03g==
X-Received: by 2002:a17:907:80c:b0:c46:6a50:40c2 with SMTP id
 a640c23a62f3a-c46bdee2675mr943075666b.39.1793058727681; Mon, 26 Oct 2026
 16:52:07 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-11-jthoughton@google.com> <3b0a8fc4-d140-4a90-b810-cbc1283fc083@app.fastmail.com>
In-Reply-To: <3b0a8fc4-d140-4a90-b810-cbc1283fc083@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 16:51:31 -0700
X-Gm-Features: AclHuK-Nhf6TYTDNWSq0v6hReecRKBdo5ExoV8oZWGVCIO9BK-126Jv082Kq0QQ
Message-ID: <CADrL8HUZ3t8RdMEeBPfqsy1_1rN0Ty9B2c4iP6OzNS12te6vOg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] uaccess: Move the NULL mm warning out of line
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 4:03=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Oct 26, 2026, at 22:52, James Houghton wrote:
> > uaccess_without_mm() is inlined into every user copy, including every
> > copy_{to,from}_user() call site on architectures that define
> > INLINE_COPY_USER, such as arm64. Each inlined WARN_ON_ONCE() adds its
> > own __bug_table entry.
> >
> > Keep the NULL current->mm check inline, but move the warning into a
> > single out-of-line, __cold function, uaccess_warn_without_mm().
> >
> > The trade-off is that only the first offending access in the system
> > warns, rather than the first one from each call site. The stack trace
> > still identifies the caller, and the access is refused either way.
> >
> > Compared to the base of this series, with defconfig + KVM:
> >
> >                      inline WARN_ON_ONCE()    out-of-line warning
> >   x86_64 total       +5,884 B (+0.014%)       +9,714 B (+0.023%)
> >   arm64  total      +40,948 B (+0.10%)       +24,609 B (+0.06%)
> >
> > On arm64, this removes the ~16 KB of __bug_table growth, while text
> > size is unchanged, as a call is the same size as the inline brk. On
> > x86_64, the call is larger than the inline ud2 and causes more .cold
> > splitting, so this is a slight regression.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> > NOTE: This patch is included for reference only, to show the cost of th=
e
> >       inline warning.
>
> I would suspect that the growth is larger on architectures that
> don't implement __WARN_FLAGS() but rely on the generic WARN_ON().
>
> This would mainly affect 32-bit arm and mips machines, some of which
> are very memory limited, most of the 64-bit architectures have it.

Thanks, Arnd! I ran some build tests on 32-bit arm and mips:

arm (multi_v7_defconfig):
 - base: 31,913,726 B
 - patches 1-9: +64,816 B (+0.20%)
 - patches 1-10: +23,193 B (+0.07%)

mips (malta_defconfig):
 - base: 11,830,177 B
 - patches 1-9: +61,168 B (+0.52%)
 - patches 1-10: +25,881 B (+0.22%)

I think it makes sense to include patch 10 with these results; cutting
>50% of the size increase for arm and mips seems worth the trade-off
of only WARNing on the violating callstack. Let me know what you
think.

Is the increase even with patch 10 too much for mips or arm? I can add
a Kconfig in that case.
