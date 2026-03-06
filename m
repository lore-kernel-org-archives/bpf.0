Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDCE3ED13D
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813626; cv=pass; b=NXtNucpSZWUcuokYIBRQkRbzFXASkZWWyBWhXBMbfnfmsmY29fe9M0CUz//Gmnqf/9PqE8kZu6C0lKGIOOoKid7Z7r6MDvPr5ydP2ANgKYJM0R18vFdqc5ZT8pdFWG28MkUfG3Klxt5FHGO8oXrD0uVkEFXMWt4HnOtk+W18FV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813626; c=relaxed/simple;
	bh=/XfUhtjrTn8YG5rbTPbsBqNSCLkIYcA1mEKayXUCIE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBLSmXUzgsyAWBn6/H3IEQEjD4fbGnV687Oo7hk9ruFpB0nebYXFnP+FS8b+EvfZuvGJPDIjB+7beF+WJAfEAfHn56UQAaJwoCHjLEvTg9y4eao7vjfxxxANIsayUq4ih5RDoR9oNnQlbHhe1HBOKWmiX2RoSoTpNyl9lZyZ/5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuU5dT8Z; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuU5dT8Z"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439b2965d4bso5212869f8f.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 08:13:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772813623; cv=none;
        d=google.com; s=arc-20240605;
        b=SHD7amvDbr/9sC5LB7y9GA6jv/Dq+8ERhKKL211e2bGhTpkYreqXDSAyj2W+KK58wc
         9Pn2hUtex7bOkCEy2weNG12rOjPxI04uD0+uRlmK5tIxEKHqhyhX4qq9hctwMYdQqnX4
         DTKSkl6j4RtcaURPryN6fBCTIzObj1rYn/Bbqz+1tsRG+KUJmyhM4GJMgBGCf439WIS+
         9VyELBt1voz/e/pbhPwAqnC8Ee7PcfhU6r4FCqZoM2201r+qjP4JTvn33zw795O7q2ct
         qkwCkD4uhCSO3pXwVAAK3oGVP78NvxndFIXlH7DtD8K+2A4q5T8NKeefGcqzz+xfURqu
         oN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/XfUhtjrTn8YG5rbTPbsBqNSCLkIYcA1mEKayXUCIE8=;
        fh=NTE3CgXhsJQhCFjLsoDxCfZc/0OsKIw8WG0v+NskoE4=;
        b=CGiv07bqCNvWh/RBhY12HK2FQoGTC+hPVkl1MBBdRqvFi+sSryNe8Su3nhHvd/P4SE
         wOYRClzlIbQRwWWMcvZUtzINyRbfIkV2GjvTK2XJP1Dzk2d6KOfDEA5GP47+XZ/J3kQB
         J71xyueuHkWGtAJlwPk1FLHqCA/BBsYEJRJVoJB8jvx+H6Wo+uqie3sI2jklLZB1Vv8G
         h/p05SPvpL33Ukg1t/tBRx2KOFrwtnxy+wLHS8IYEs7kGjfS0qRpl37SClMP8TA8dU8y
         ef3n4P6xiZx0byTM6722Doq1M4xzOSE4Soc/InuxrFRFfWz0JoQKMdw1L9EP6UvU9zXf
         WjGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772813623; x=1773418423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/XfUhtjrTn8YG5rbTPbsBqNSCLkIYcA1mEKayXUCIE8=;
        b=NuU5dT8ZjqRrHpeq3iUYxquqqR4AfdlTCtWKPipjA/72nOWGdCDd14DP2sN4pf+qfb
         3iF+Mp6sS8JZksiUxZftVnd0TrmC1VZy2nhoJIOlv38CwuiL8NhnQ/OGcbb2yR4t0jUM
         I2cwtmu++uf/UncAf6Hm6kpvVnSzwVaZ3qaPyud+UfaCT7uwO9kIVMJcn7uzJ/hFKZ9L
         vEesQBKoqU4fcM4g4U4XzAIvwwhA/DT4U5ktIz5zzdnhsPFiwOFSbQjWb7q5RlQF/LyL
         tyxecApeQpHPR6rl72Xlp+4q2laN5DvzOz92vQ7lqYto0oKTcoifDV65i3y1IaOZl9/z
         Tb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772813623; x=1773418423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XfUhtjrTn8YG5rbTPbsBqNSCLkIYcA1mEKayXUCIE8=;
        b=aAQLTYogsq3XdhrkWjBLrFEHJAmt1qB/DVRmWrM33rlxTKUCUcnN73QvlSdFrrUpE5
         557asWSPINFYfGCi82p5ZdogxYSwNK5RsXjKo2uZRiMkfSpvBqaZYmTr/do4IJj7RyeG
         IJxUPSOyTuowXW+HdpMjfglKpnimmYOxdxN2a/UJd85WAX2+g2V57aa1mcAsOjFBP9CY
         KfuEWjqEzou7aIy8OVQ29InFPA4EhkEOerb+NWs4PNXGRKK8P79RSfJurskjZajRpZI8
         AN2H7ahSmB05xxbnAGBkrHOFb+2D+VelOQIeSO0xmgUx95nAPoHQkPhuEctE34/dGWkU
         CDgQ==
X-Gm-Message-State: AOJu0YyJs4XD1luzEfnGxM9NGklRCR8qozwvPs8fZGWb3jILBWfjI8qh
	tA9LDvxZcb75X8Gac2681Sg6jCdCplhx/jBkD4MIbovUcyCGIfmtpXtV0nVVYFPEEypY1Sarsn/
	Hj5s1N8i3OKjg4sWsHlgdONpecNm9jSA=
X-Gm-Gg: ATEYQzzQadnLF9xGLyfoe2j8CjSgjLrB1aeyLBtxn4chLDRbTPpJ5AdiiXVLMjkG2PL
	c5++F9fx9LHZPOdvjJ0PdLSi1NCYzMEgr0xcj4bYF71dzt7typOJAkXsvigTggCJH9Oh5T/UTa8
	ypU/vvrgVGck8gVYW8w+aUBKQ4cxaNPoRjqye/0v+LLay1dfN6QSUdYCEkz/zmm5c+71hwHEhvP
	BJ1q+iWZmYeuu+XPQhYrMZy3LtHcDc3lnc5ka0ZKN/kzhk5dkmJ2UsV08C6CF50PPeMkqEimQWt
	iaAJ9vLaNmWXTWhdWl+7mWaL6lOkfLMVXQRcP18yMZocZlOIkFBtsfkUpWY=
X-Received: by 2002:a05:6000:2407:b0:439:a95c:ef03 with SMTP id
 ffacd0b85a97d-439da6694bamr4856383f8f.37.1772813616857; Fri, 06 Mar 2026
 08:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772804199.git.vmalik@redhat.com> <df4e8730627c311b18fb0634989070eaa1567c75.1772804199.git.vmalik@redhat.com>
In-Reply-To: <df4e8730627c311b18fb0634989070eaa1567c75.1772804199.git.vmalik@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 17:13:00 +0100
X-Gm-Features: AaiRm50yTgou774vjQ-GHTpk3KJjAkqgMKot44ff0eV2nTs33nJFGDug5Cw2nLU
Message-ID: <CAP01T75K4U=KxH=1cAv2twaNhCkc8kqsx44Giwe3PGDaHjvQQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Always allow sleepable programs on syscalls
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>, Leon Hwang <leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 14:50, Viktor Malik <vmalik@redhat.com> wrote:
>
> Sleepable BPF programs can only be attached to selected functions. For
> convenience, the error injection list was originally used, which
> contains syscalls and several other functions.
>
> When error injection is disabled (CONFIG_FUNCTION_ERROR_INJECTION=n),
> that list is empty and sleepable tracing programs are effectively
> unavailable. In such a case, at least enable sleepable programs on
> syscalls. For discussion why syscalls were chosen, see [1].
>
> To detect that a function is a syscall handler, we check for
> arch-specific prefixes for the most common architectures. Unfortunately,
> the prefixes are hard-coded in arch syscall code so we need to hard-code
> them, too.
>
> [1] https://lore.kernel.org/bpf/CAADnVQK6qP8izg+k9yV0vdcT-+=axtFQ2fKw7D-2Ei-V6WS5Dw@mail.gmail.com/
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
