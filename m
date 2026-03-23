Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FFD3B388C
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282848; cv=pass; b=ETOhVkJsFMcdPdbALUJjBLFofmb4bg4g97nvLd+9hcIfGMz/9eGIhHrmn1JsKJp2reFLUm0D0q8MMW+m/g6CFQx4GIi9k0OBNck/40SQhr3WVTazpe1z6e44cERvN/oQpyHLfeQ99OgA6ana9tg1hCJZhDC3XedYFlA8yh+6EMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282848; c=relaxed/simple;
	bh=V94g1pzKL5dHi5fv8nGsDMXp1c7cNO9ZtyC0nibAyPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fm3tvphOHUplsEeDSBZgS0pDHyydb328NXmcgE2L7RWxl2GHoJP+XwIp2xWNy49qaTS2zUkqJbDMD/2IkWOMLyrTUQnb0yXp8qxenVZ7O2ID3/khpZffby2OqLq47sbhMMftTqKzVZgAhvepKl/d2nT3r+OuaXsu5UNSpk9M7R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tAhw6w9G; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tAhw6w9G"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so921779a12.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 09:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774282845; cv=none;
        d=google.com; s=arc-20240605;
        b=FKJqkOqYJRU4aykt7kg4IPAmY+yZzsbvSyZgNTlLZVFrvRaboiPOwJotcN0wyD5xZf
         8QbT0Dy5IrZT2awKZJcMSi1a6jqY3bO4T2rR0P64zVZRg2t1vv5+gcG0KwnhKFQunr0s
         hLbwU9/ktX2LKl0trrtRqgnuDX5ak5ifksLUk8A0GZ4HJronxRQUTT6Hbsy0cbg+neJf
         ZlfvsSHMq6yRzEPceJZ/j+YHzFWivL+/pl0HUFOYojMB4mP2DzzhZCfJvSF+yhJbr+wR
         yNPreYV+KLcqKW3Saq0XA1EXcou0JTuruWcS7uGHIqWwFWw6gAmAB5HPawcEZe1p1k2Z
         E1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V94g1pzKL5dHi5fv8nGsDMXp1c7cNO9ZtyC0nibAyPA=;
        fh=k0JbapEB5kCeESxzGRIgINDZW/JO92xvtNuEfzs03G4=;
        b=ZrcfxR6NpXZDOv6IWXtEzuLraKc1L5pwzWn1j0ahyA0sCM2wLfZ6vBa1MhX5ZjWIbu
         +Q4Fi0HbIMQTj1lwS/JPWHweOzus38evuxWPPI13tsPxU4fRxSn42J+AShCVdVKiMGAV
         pt56jntCfOdEsyYcWoyqipQLyxzQQ0hNaNqon0qcgr8oDjUzO3r2FmBQAGJBJjVyv/tz
         hLoiunNZ8Gz3dZ/VS1T7Opxd8cWTjY7/CuuDbGdssmJ0J31keWp9DTBdZu2siIozCgJT
         tvbR8dOVJOxjTVIYOsw8g8avLHmB4XSiazZ2yMXc5GNkSCxVQUUQWBwsPIzjznGuzUAj
         JTpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774282845; x=1774887645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V94g1pzKL5dHi5fv8nGsDMXp1c7cNO9ZtyC0nibAyPA=;
        b=tAhw6w9GKdc3xo2aP/R1zmF2Bg6DHmgYENELQvZe5GZj7w+UyBENW0Z5anZHMfMh24
         RMxu1/frYTMQOLQG5jHMBFLRKL4TiK7nEcQuN8yjEJlurVUiLFmrFmyq58eXxFj7Rfz/
         zQzmqAt/pQfPrkmHiHaTw7NAI6czwsYBFMdWL7EadWwMHMoXGcaJheEJYX+cHn/nzkeM
         uhaIKUYdA6x8t9InJb7gIKXEJzoPSqkDVqsbYEUNF4OSzDb+j9k5yKZ10fol8gCu6ilI
         jFHokAKCJPcB89wn126XOjLiNFV86nNWpd4M+n0PdIRyYFBLsBujuAGUxnRC9c102arW
         uKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774282845; x=1774887645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V94g1pzKL5dHi5fv8nGsDMXp1c7cNO9ZtyC0nibAyPA=;
        b=oU975n5fdi8fdmd9Mw0QbwAwyCDDQiyL35YLrvRNXdqQ2B5mHQdv7R10wAS6kaAl16
         2VNwzkKv4fCD600CC7DckkXn2N6q7u6vOQ3KTUmrw/RqS+/cDoNpZ2OzDCIayUNba0HL
         eVovyJg3Wbo7qt5v/UioewYBDI37uYkBt4GIYlTN23Qf+yavcSeVodqn+uo9KFcwBvTB
         9S63YPPOvXUCemu0Etd3KFu6O+S4yHgPczNOzYdZsHaWjjGIYkNAJoDMRVjpQmOb0eZJ
         L+8OoEKgxrcHOcPcYYEd0p5j2djmqVA06d2jC13I1CUllg1aS7O/XZzzKHDrd7eTO2gM
         Ub6A==
X-Forwarded-Encrypted: i=1; AJvYcCXxfL4EB88eEJN6KYqMNU9WbLJKeJ2uBEZOPsfMfsF5M5JcLrl1s7WgdA+qIaYipd6BxT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6z2TcfdOxlKHf3tAyjLrR27szpdbLpmeSEDCUW/XcCnzp6ThI
	vnqtNTjBcRVA8CBvAonIUUIsEvQ0jctmxoh3tJpI+luU3mqMJjewspwodrohP/h6EX7AJX+2BZ/
	8vILqsy0x7Fqgx8OeyDt5xo7MpO5b+iFTytTgKUAi
X-Gm-Gg: ATEYQzz9EoXgLc9sci1OT1m+K4l4qxS+dkiBEqFIP4G7ZNjs2C/AZigCtw7RYvNXo9X
	ENesY/N2RVihM44yYDy97NP/pwfuKhW0XT9RUSEQnOk1XaQfu68fgQSDJ3HD7A0ZBuQ58bfsmlV
	BCLMfdLogNxpUXzozX/dcvTMOya1uNK2mnzIzDRHXXLS3dmy5xDBZnwJ6LMmr5PNsBJlp9NZD/m
	ugho/cMR7J7oqwQTXjQGNqkz/UPIBPzjPftGKMjFFF1KD2ikCl6pzR7TzOJxZIefnILGIDkTSKJ
	hN5uEKHchGTx0owwPr2nrmne0YNHR1ncQnk3+AyERq5xYGGQVHEt
X-Received: by 2002:a17:906:919:b0:b83:e7e:3732 with SMTP id
 a640c23a62f3a-b982f3630e7mr720689166b.30.1774282844692; Mon, 23 Mar 2026
 09:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320160055.4114055-1-wusamuel@google.com> <CAP01T77hy3j5BZMBcYdadLfPe7dYb3zEGDF9daUxJHYy=+fcgA@mail.gmail.com>
In-Reply-To: <CAP01T77hy3j5BZMBcYdadLfPe7dYb3zEGDF9daUxJHYy=+fcgA@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 23 Mar 2026 09:20:35 -0700
X-Gm-Features: AaiRm52TW1-EKDTCZ2bTgcJapMDIKftRA_vvryAeSsRy_n7c_tkgZmk8jNhLUuc
Message-ID: <CAG2Kctooz+1ywStvHv=wg0p6ZTbHGm4nf5nGUfcrOnDi6H6KSw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] *** Support BPF traversal of wakeup sources ***
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, andrii@kernel.org, 
	bpf@vger.kernel.org, kernel-team@android.com, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 10:52=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>

[ ... ]

> >
> > The initial attempts for BPF traversal of wakeup_sources was with BPF
> > iterators [1]. However, BPF already allows for traversing of a simple l=
ist
> > with bpf_for(), and this current patchset has the added benefit of bein=
g
> > ~2-3x more performant than BPF iterators.
>
> See, it ended up being faster ;-).

Yup, thanks for the suggestion!

>
> That said, I didn't understand why you dropped the test. We still need
> unit tests that ensure the verifier causes the bpf_ws_lock to be
> released before exit, and an example program (like the one you
> benchmarked with) to demonstrate usage. Both are mandatory. See
> various *_fail.c files in progs/ and RUN_TESTS() macro for running
> negative tests easily. I doubt we will have any wakeup_sources in the
> CI environment, but the example has value nonetheless.
>
> pw-bot: cr
>

Sounds good, in v2 I can add a test for the lock/unlock kfunc. And
thanks for the thorough feedback, let me take a look at the *_fail.c
files and test macros.
