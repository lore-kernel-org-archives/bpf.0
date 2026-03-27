Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B82BE05A
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624367; cv=pass; b=JsUdwzvLOnKsDeHHXkRWrJ5J3lm++bcrwTbh2l6HkiM5T5O06qKF6NOXwdai3DQp+lVQWpcOyb5XKGbB2u4U2dtcZZ82tGHHn8hi6rIA+1maaMRajA1pFSRUSEN4sK0bhOpUoM4MWNEwn6Sc09+1gKEr9ryznzkcikb3Ka+NFVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624367; c=relaxed/simple;
	bh=aAAIIkwkpasgGtMXZcOI76PRHtjGQB/ePuh/XN13coo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvL8P4DDe3uEia6/Y1EUuqVyoZEpSXcoET3YVIHoWtxw831qkUkCBc+kp+vAYQB/Byj0vKHjy4rQg7GK7m+et47JPPdCAZu3Em7rUuFRdKs5IeIWBMvG/KfrlrgsjbnkY3KaCr8ib3T2cdjUqwBH3GBM+TXlVYynrUhR9szLJIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/Nv0w6E; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/Nv0w6E"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9910707d82so249664866b.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 08:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774624364; cv=none;
        d=google.com; s=arc-20240605;
        b=E0qt8rARQ25cK0rV6J1R6CEEG31h23uw24zVu3CZIS44SWNGSseNTB1useopgka/+N
         8ME72e3i0c/kYFmHATVgm/uIC/VuPJHGbDujw+3gh5h15XZodBsIrZ+sdPPfLDz3ikT+
         DCxeyyg7okDmQ/pur1zQ7MBhmuDk+EiuPatiQfqkrmqfwjA/xJmDUXNkoVUW3ekHhw8A
         nZQDj/O7NSHX0W/K6zD2LqMEW+MRpcl088EUO/OB5atCae4P6J71dURJAmrSi5bhXZKe
         oekRuDNWQnQnquzg2l4jTsB/3YyJmgFCq0lJGBiLDF0WAremugAzhwCX53+9N2uq/2Ru
         JQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aAAIIkwkpasgGtMXZcOI76PRHtjGQB/ePuh/XN13coo=;
        fh=lbxlTJaBAbSKxI+rwEbemYfw/TWOSEp20aZzEnJyMq8=;
        b=ShLfB6cDcioruydN/B9vHtzvWMYIRNrKIcHN36UztrUZZ2BRIckaBMJzw6BNWHDoJl
         C6dJox8Ia1ORQoIq3azFnVl7zc5PYgPDPTfGFB9U25I6nNh2P/JqNxtIlJqucD4W1haj
         ZoCU8no1NwGIyoOIUoNnrBtv9oJW/2lUCS+Fmxq4eKvtZHriR+Vd1XzUKZ+NN1S7gVG4
         frPs5iyXaB3m26eH2pqKZI2oAUQ/sUuGTP/N4lP7BeVJGT34HUD7nWhErovbmFZ/f9og
         ZqDlnzNHpfExyCQk17MtL/VIoR39ZCbLFdmUKMo7HlMTMunGj8jiHz0+kDwa7CZkxk2v
         Bv2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774624364; x=1775229164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aAAIIkwkpasgGtMXZcOI76PRHtjGQB/ePuh/XN13coo=;
        b=f/Nv0w6E4jgFvT3XWcSZB2E3D988dC10+Vr3O5znh252l9CVjFsfXAOEHxGgldo/Sk
         N4ah3imcjpxd3HohUaAfIQZR1o8rJ6SCgjESCvKtF/CCJZvB0Pp43JtBheQD4K+5W/1B
         pmnKRPh6oY7OoOO+hyf7VjO7HM0gSzeJKQUriLK/GNsGiiMOhX0fJhCN8DquwaQkqrTN
         42ifVXbZ1V+u1I21yxa0rlbXGjIIKXa/d6A/R7cs1N9CETzxj7dXAp2okmGzHwTaNIzJ
         /Ug/8FWoqLiGBJc97CZRmFP7KWkjQYa8dl80TUiNLlQ6PTsyjaZM0I0eafkGxmIMXrFD
         J+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774624364; x=1775229164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAAIIkwkpasgGtMXZcOI76PRHtjGQB/ePuh/XN13coo=;
        b=ni+d57VzZem9TsamvUijUIPge6ISoZl5H3oX4B72wGkG7jjBfbK73/cj+C11kXDhrH
         hsb7AqPfOdjFLFar0bisHCHbzJowTdWjrOqtRqdGgTdUw3Hlepi5RKLLILxHFwMnZ5k0
         DzwpjMKpFAsleBLOBJnEAlxzHi6q3XjUWzX7/C7rpJFWQ7LmxQy0zf6RflqceowKIZNr
         49NQweGqUDw1H08NdKJrjPuBHBIYv15xQPIwRqhOAy+TOsqE22tq2xDNqJJAxK1jH3mt
         0nIfdsRU6+UpXTIxyjUf4zhZtEImy1U6G2zy99Tz96iy89Q72l53r53s2ZIvAzElQ4UJ
         M3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNV/ozT6WrBqzZ48fm2zGpqhvUDeqoiDDjTZHmHXS0zZvupchveCAnwDVr/wKgR4vWf3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOLbbgYustEcEY30Y8dBWqTVdXd9oraEWiH3sh1CSoJMIqfMr4
	33zl++TIea1vu6Uv3lBLulhTtC4tTvLBAPpfdQNEHqrvXiOFko09KsPjPL+jvExwiHhrnyW4FBc
	CoqVOycJPAQKjtHG8Zdx7x1AD8g0pxir2Pr6f
X-Gm-Gg: ATEYQzyNUJonLof40bL23dhMHih/8JQ41TMde9PcJm147teZXyYE9dbzwF3l1yE7zZq
	t/tX5O3RczHNmcllsz+oTzSKP3Go+KAZH9vy5wFwem177oedIE+JEznXTgIguuwzkSivgb7y1KB
	SRxUzaOicnrmhlG6k+UZTDdKAW4qBp60evrDTXIET44zwcAtVQUGeIpcufhITcKrhFr48N+hHOL
	0rSc5l83vQcVD6vXklx+J/w6w23BbAllo9qcsW4eqM8+DS3fOCSa0lHKwn8a0/4GxFSy8qE1xey
	/ybNWB59OjdJHpPIasJDi7Bd/zo6bkt8dOmBp+Q=
X-Received: by 2002:a17:907:e158:b0:b96:d6cd:29e6 with SMTP id
 a640c23a62f3a-b9b503125a2mr158356266b.2.1774624363778; Fri, 27 Mar 2026
 08:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327141616.1961457-1-hayatake396@gmail.com>
 <20260327141616.1961457-2-hayatake396@gmail.com> <CAADnVQLh76CWYJCJXgOst43FcJOrPP2Y0wcwGPX71QqmiD+7pA@mail.gmail.com>
In-Reply-To: <CAADnVQLh76CWYJCJXgOst43FcJOrPP2Y0wcwGPX71QqmiD+7pA@mail.gmail.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Sat, 28 Mar 2026 00:12:30 +0900
X-Gm-Features: AQROBzDmYmczh2NyeEemAcGpDCom04u2Q6qw3Pd4PCsvZvk70saVT0NWa-U7xHw
Message-ID: <CADFiAcLvdjE7zwqf-hpH01jnbxtnWQNoj4+zBwK0+RU80-k9bg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: patch tail-call fentry slot on
 non-IBT JITs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Alexei

Thanks, and Sorry, I sent an older changelog from while I was still
iterating on this, and it described the issue incorrectly.

My changelog made this sound like an IBT/non-IBT-specific issue, but
that was wrong. On current kernels, fentry on tail-called programs is
not supported in either case. Only the regular fentry patch site is
patched; there is no tail-call landing patching in either case, so
disabling IBT does not make it work.

What this series was trying to do was add support for fentry on
tail-called x86 programs. The non-IBT part was only about a bug in my
initial implementation of that support, not the underlying motivation.

The motivation is observability of existing tailcall-heavy BPF/XDP
programs, where tail-called leaf programs are currently a blind spot for
fentry-based debugging.

If supporting fentry on tail-called programs is still not something
you'd want upstream, I understand. If I resend this, I'll fix the
changelog/cover letter to describe it correctly.
