Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E18535BDBB
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629022; cv=pass; b=Wzv1B99di7usUTX3ZNIzCdRDeIDEV9FIaAMHKBD0zjpazx1tdmthwEa+9zuV0b+SdnkLHIPp65e2x9EkuiDKq4jhWIoY5AGUYjxb73tWZRnbCruEou1O42m4sRpI6HMqEnYTamcDP2IYDX5FrXoZWLCuHkk4/BgiQxsQdwYhjpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629022; c=relaxed/simple;
	bh=FC3aGEn7yaFpmPR9w0yiTeAf7we4oOmunpak6tx0IxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mM1d9wo9Te04pyV5JxGUnLrdwwh7cVJJEJ2g/Cu5FXpdZnxDbpUFk+F5BKAaGdBSU0j5oXY8XZ/QjO3/0lJm1HLTEX+n265YewNWan+bVGktEg2nuCcvn9DNRKKJRZLfNQt2V5OrNfygUJmWee2kFiZoPHIvRCMKjDe/093FEho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od/DrxZO; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od/DrxZO"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b886fc047d5so371235866b.3
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 09:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774629019; cv=none;
        d=google.com; s=arc-20240605;
        b=WpHeI0qgzEsuSgVP9Zp2in1w0P1ZZvlMpaHYvvss6UsRNV5Axysdj/V66Vy90whO6G
         OQ8m94JwhI4ZOtkmpAHiUj9XGq2IcGyICrB/b5TOb179japZ/H2KHABGMrYmjiuM06Iy
         AK5/V19AldY+m0zq+SV/hcsFU6FfKNlTP1Di0hz9jW27HBltTimLKKPkFUGXR1KedFqf
         kM/3BEX7UTUPjWatblwhVyQ1mvwNX5Kw1PEKqomHpKUXMR8WprxpkD5NIQv1zTRWbgKP
         Wvr6SQcGIu9zHWPUFf0jwdiI0K8TfahTTXHGW20AsBQR5cQWh2oQLg2Z9ImbYbP9H9+f
         dpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FC3aGEn7yaFpmPR9w0yiTeAf7we4oOmunpak6tx0IxU=;
        fh=YBluoplolQH/20d/XxUpeviEzkx3l2/OcMkVmUn2Hh0=;
        b=AaoFruc3+gG3klrYgcA/Xx1mcKsjZj7M5BOgZHet7dVM5TA4B5mYAIIJIN0maX9xXG
         3d1I4qIRn4uoYqMbB30XRjs2usrrx00OysAjGNFyiLBppPoGiW46+Ik02vks9HuVz1Zi
         KdoG0mgeDzWML1QlM/WnC891HKsq3Hx5qm+cIA69GdHug0fj2GdfqxbZP90I0IAIw5JT
         pIML0yxtMTFIvAbhZTqEgLfKkhEgUR3O1JWpEMTjD1LLszptpu7oNjjh7AAwZHVIXuQ+
         K7ZQYiSBorQV0KMFYJAOT9HhH1i5GRDJS7FY0uAMNBQ4++T+dze3JFxF1TazLFrSeIh7
         sY5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774629019; x=1775233819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FC3aGEn7yaFpmPR9w0yiTeAf7we4oOmunpak6tx0IxU=;
        b=Od/DrxZObGIaVdSxQ2bSIsHGjb8vLQNHDWwSqHnDURK8rMUWLQ0p/SdEQuRzjIJ14c
         Z7lXUIkzbWouxV/wfu1+5V0bMPzs5U0N0H7jQdcv+PBOWfvoHxI/ic7AR5N9nSTUZX7F
         TfRi0qI4Nz1tQ23LXh2stlW7vFKbKU9xB7VYzsctT7G4fcMV1ODllniaRAZF3QEWGnpC
         WowRbdFz9bjMo08oQOU+o8+kl04Uh/Z0izXHK9MJVTfGp8bwMHpdbZ0VHKYasL5iYlSN
         sAJInd6OeuW5KUxN6+liEx3chYTAq3KT4D0/AHA8hGQkx7vR5K2TZjNB7Fr29Z69mYLA
         QB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774629019; x=1775233819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC3aGEn7yaFpmPR9w0yiTeAf7we4oOmunpak6tx0IxU=;
        b=iYQILQcYSC4UoLso5P+x5dz8JOBsg4QMTp92lJI3AMB7N8Q7PUoo3cAIZZVS/2W1uE
         DQ3SsEjigz6y0PQ3Bur1GObvKt3VaFfavHC6PKXo2DzCDXYnFATHF9xkIYDsDH8mGk4S
         2VWv52VeMlNut23YNs70LDtmmxZgJXGqxfj1fgBFY906YXVI6CicQp7QiZM6zReyzmoP
         PvcpV0xEMLOqlma7+DteJY78xWaFOc9t1YAvMe9fKv0hS46Cwd7Ap6oHGTl/14+dksq8
         323arAp0+FUFy0iOimMXu9Te3gMCX6fJNAMjKWJo6M0PKfbOLqiiJQFBriCJ4gYGurGv
         /E6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSWeEl1aXU9ZwDJo5r7qQvbyidek+3nL9zINZdn0ddQMdeCRVjPXgo80I/xkySLDkPYJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEU7o12BTiDlFyjtHQ1v0TmeBFVnLXpvBz1p+y/scT3abake5
	p0hkTaX3xt+cBQbYL2jyqx0xDHdl3tGgRs0tzp1doJEF8ItWV12WJ0LfeK1IGR6laxPYKeBU49U
	gWvixPGLZSP8dR10fNzV4xFoUJBxZGP2YQwvo
X-Gm-Gg: ATEYQzwl8QcI+WnUIBfCovVtzMhHI1Utyggx3W5ZECJfV3MKQCaEES5HZwxZVW3eRrj
	rpmC0MZbOaKYx/Qmxzct5n7w8n8hD85mW5KM/XRuxv9bzLbm+W4XvgIQ5VCxQJoUsFwCKt5QiyP
	33OmugN1GYnUklkxcWxSyFnXK4kM5Fun3PHPCMTPhzscJgcoo+2UbL9eMzvY5zM92JGvnWoPAW3
	nURiu1MxzUPJYCkQ2R3NRMZ5RCdZ4rgt6Ha/uQk7YlRUf7mjT0/8INaWMWC3wh/c7y78ANv+vcx
	8bsq+B3Od6h5B242GwtqCgJBHXDmCTReCTyvJ508g+5EVhqJ5Q==
X-Received: by 2002:a17:906:9597:b0:b98:2732:3dd1 with SMTP id
 a640c23a62f3a-b9b507cc370mr155133266b.42.1774629019174; Fri, 27 Mar 2026
 09:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327141616.1961457-1-hayatake396@gmail.com>
 <20260327141616.1961457-2-hayatake396@gmail.com> <CAADnVQLh76CWYJCJXgOst43FcJOrPP2Y0wcwGPX71QqmiD+7pA@mail.gmail.com>
 <CADFiAcLvdjE7zwqf-hpH01jnbxtnWQNoj4+zBwK0+RU80-k9bg@mail.gmail.com>
 <CAADnVQLR6Y94wKo1G_4w0-xTPdR8ws38oGu3xfHOXxNKcqjyWA@mail.gmail.com>
 <CADFiAcJtjVHYVQeYJ_znVsjiJkEBmLfOafp5srY0HQMGwVtiQQ@mail.gmail.com>
 <CAADnVQ+0EwaJXgS1WSDf12+Ds2Uxbh9KMpDcyq+gyZjcQ_6+dw@mail.gmail.com>
 <CADFiAcJFy-n5Zz+Wj1dWEH0WcK+PhKXi7cbvdsLnPhMXRcVktg@mail.gmail.com> <CAADnVQJmqKVZC1gkvAaAmO9V=cnYPO0UYB6Wyp6Shko4tZeUQg@mail.gmail.com>
In-Reply-To: <CAADnVQJmqKVZC1gkvAaAmO9V=cnYPO0UYB6Wyp6Shko4tZeUQg@mail.gmail.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Sat, 28 Mar 2026 01:30:07 +0900
X-Gm-Features: AQROBzBzwb6fls0dn26HPvWeRnh5qPUOZ6CMbjvFarf6_LGZ-e-aYjW0CDjTnwE
Message-ID: <CADFiAcJCrS0wjkPcGU9sCYQukEoegeZG7JMkqhGDYq5C43nfXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: patch tail-call fentry slot on
 non-IBT JITs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> yet you're still top posting :(

Sorry about that. I misunderstood what top posting meant and ended up
replying in the wrong style.
I had not understood that it referred to quoting in that way, and I am
embarrassed that I got it wrong....

> see how cilium did it. with pwru tool, etc.

Thank you for the suggestion.
As for pwru, I had thought it was not able to capture packet data such as pcap,
and understood it more as a tool to trace where a specific packet
enters the processing path and how it is handled.

For example, in an environment where systems are already
interconnected and running, I sometimes want to capture the actual
packets being sent for real processing.
On the other hand, if the goal is simply to observe processing safely
in a development environment, I think tools such as ipftrace2 or pwru
can be very useful.
