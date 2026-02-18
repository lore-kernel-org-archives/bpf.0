Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC1345CD8
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441658; cv=pass; b=b4Oym1FuRkYgCm7ihf5PUObYu8smLAnwsIqCG7bkXK61C2siclI/F67L5373UjErP1VFj5OpDpKv+sfPJsczbaeyoaTnnmHSmdCOla5RHaOfbAoRe0HN8K0KlOAHvZnuCzTXkPQ1TxPAJd1pO3SX5PWHNXp3SsN9i+a1YZ1+vaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441658; c=relaxed/simple;
	bh=h42zbXHz4RI7Kr8NqUKmVPcAbWYTGI4lOlxhSFZZl/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKEQeiH13svizIaDPYuI7dh6LooCUrAzAY6a7eqcx33/WRTA/pGA1MOsuQ2TseY2xJhZ6RK/Cc6iCs9py6u+ZAXGlOBS4zTtFuvq7W9WSeu+lm870xLn80iz46kqLS2+v+74YhzfW28ddCCCAvKljbo0ZsH2IkbDoXyFU28XAQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PizscVRK; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PizscVRK"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so64319a12.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 11:07:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771441657; cv=none;
        d=google.com; s=arc-20240605;
        b=DSiKJenFseS5DBazJoRNAkjj8bHSH97aMndSudEu9hVujh9U4In+6TSA6XgcImwUJV
         oLPy8yNtl+yePqwFjpNU3UjvSPIuYoUDx2d4Q7uEQursuuNlEUNOsZR3hmUB99yDKsF+
         tEvcU77lfclLK4ypGsOHmBJcZlKzy9nFQGm6rV7wTEZkLhEpQy0DAhsv3V92N0Ce/CnN
         lg1+q+fF1capnBF1nOt+F7AeRgHNeiBQFXrdXHUEQmEPQlamOguwwZk+vHsV1saR/6a5
         Xg/RXJPi9Tr67BsqxCUbKXlUotbCJnU7QfqGjbdN6gLrlU2KTZcwjbo7mPjHFwi+WpW/
         87aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7fxLKZMTD9UYWoOBkoc/hkzN0FZcnJ1sdgpui8EhhwU=;
        fh=EirsGAW1VEkvyAOFAwOu2FwhebzG9msQUOMezX+1g5k=;
        b=CJV1BUUa8W0rWUUZyTVz4EzZlIExbwE2SBTqFii5LCavytxplWzdl1CjBb3PF+FE2v
         ECTzwLpdVHE7zJVd0Gg2uA+ic+dUwLMJXQhE+JTsXQCKtO/X8m/IkchauBFMbYktu8sI
         rHKDshRqFZT4vG2RG2WiZzCRdZmE8l4ARBnv79s7qR2ri6EvWV+OVru0PCSUosJF32Av
         1Z+4hQgC39UKqTbWcOSG+BzBv8Wbp+cgfvaC/+9s1n7K68QhsXFfE2mvJh878F5/6l8Z
         vv177rZQficyryRPip8pc0rjLNh9aI7SAsOQ7PTnyFqke0nmv3j2uGh0xospwyIFFy2t
         UJ1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771441657; x=1772046457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fxLKZMTD9UYWoOBkoc/hkzN0FZcnJ1sdgpui8EhhwU=;
        b=PizscVRKitVzZsBesYE9D3vSoBqG4J7wA6zg/0cNGwGMRmyJMcJh47Rn59KsHk3H+x
         x+F2QwxIkN3LueC1RoIY+H2ecmjlqZBapgfvno1ygCfFoF3Qt7JB3Ag/Favtku6fL85P
         hLY2Gt5svg14QM0c3DmvfPsva14sGmIvvOkHeLGpGQ2tA4p/zt+sXLn5W6Niv9L40QcA
         j9pIhcym+Cfqv83zPt15CaGqIF/v+0GDBrDNGLh1TF8MKcfiZBHApofkUY5eeUFqXKD7
         jdV4kEQ0K1GNTsRo2d1pT1Pt/9FxOWdjua85PJJYZTX41FQC/C/02r3/am+uw+62Fhr8
         keQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771441657; x=1772046457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fxLKZMTD9UYWoOBkoc/hkzN0FZcnJ1sdgpui8EhhwU=;
        b=j5X51HutuD0vXwHYr9hE2gRoMS/ONKdn0GE4QJx1ehlOUgRlTVSfKvW2KPT4t5Jw6a
         pVD1CDiNDElehH7Fntxmm4i7eaBmbPgzb8KXKhGF/GIyNRCOHKkmBP12h2euP3aTovyO
         ZU87H3DE9FCDrqB7DwTyVfRueG+JPlEYoY0luRiumLWWlnkH+V8eEEtmjtQArItgn0Zi
         fy+0reLYlmY2cmq/9C36Q/KzkFsdwpxAThXzuTMrDF3VU3P7VyNczsqkLrLqPvq6rWa6
         Cz9E5HHGjirBxkJOCgRegblp53gmZORwN1xBqEjrAqnAjHGI4ECt0vCUQoytkDbHE8Ad
         TUyg==
X-Forwarded-Encrypted: i=1; AJvYcCWcaZvJQ+ENNZXA3eaYqY9KgVirmqSyqaXwjXKmcWVtp/tmiW4/EGh6lpp9P8ol1Zq3hAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6FgE0poSmB4k5oQKCNfXQhrs3P5KNauz5GYwLQcxdEXYjk9vQ
	jD34+nJLtfxftLgq4dzQOD54FLJgmiy4Q2D/U8v/1stiqf38wkGxWQj+4bDGkZjpXMsSseZOhNL
	ZooVhbKV079MZHzbLyAyO5hsZuscD1WGM0g==
X-Gm-Gg: AZuq6aKInUU7ySGalEvdNtCCN90kLucw4aIFIyaQjk57W0CxOC6jF+1SPmSmY1BQIrC
	zfkR13dR0QsiHhTN7CqMXRtXDepvfkuw4k/SoLwjR4J8/ANxpnSjvas5+cq/h26GWQix6IZXurl
	OSSOnCy9wR8mDCIXHPzimKFCdtkdY9CWAgR5fnBUofGcwqt+x4ZCqptx4jecmcgiF9zzfHmci88
	zjzLKlg/BKqKvcQBvq0ET2XSnjsa1lkMPbsQCOIXYr4fmGbjHVo7cCMbKNYggTOK9ZEaOwlAR3v
	Tj0ElFYBdZM0JD9/32AXSg==
X-Received: by 2002:a17:902:e945:b0:2ab:3cba:4307 with SMTP id
 d9443c01a7336-2ab50569fbbmr177166905ad.22.1771441656853; Wed, 18 Feb 2026
 11:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212152013.17351-1-varunrmallya@gmail.com>
In-Reply-To: <20260212152013.17351-1-varunrmallya@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 18 Feb 2026 11:07:21 -0800
X-Gm-Features: AaiRm52G5Z40XHQrS2HmYXHaNSzlyXzBG_IPmuHNk8iUldw35ksft5PunV-8hSs
Message-ID: <CAEf4BzYzTnxHTmhD_pCAh75bUdcfd3X_CTFHz8RLNXu4q7QqPg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/1] Upgrading uprobe and kprobe to their
 `multi` counterparts.
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: andrii@kernel.org, alan.maguire@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 7:20=E2=80=AFAM Varun R Mallya <varunrmallya@gmail.=
com> wrote:
>
> This RFC patch explores auto-upgrading standard uprobes to use the
> multi-uprobe infrastructure when supported by the underlying kernel.
>
> Background:
> The BPF token concept allows privileged operations inside non-privileged
> user namespaces. However, attaching standard uprobes and kprobes
> currently relies on the perf_event_open() syscall, which is not BPF
> token-aware. Multi-uprobes and multi-kprobes bypass
> perf_event_open() entirely, attaching via the bpf() syscall instead,
> making them compatible with BPF tokens.
>
> To bridge this gap, the goal is to switch SEC("uprobe") and
> SEC("kprobe") to use multi-uprobe/kprobe under the hood. To maintain
> backward compatibility for cases where singular uprobes are explicitly
> desired, this patch also introduces SEC("uprobe.single") and
> SEC("kprobe.single").
>
> Current Implementation:
> The decision to upgrade is made at BPF program load time in
> `bpf_object_init_progs()`. If the kernel supports FEAT_UPROBE_MULTI_LINK,
> we intercept programs with section names matching "u[ret]probe" and chang=
e
> their `expected_attach_type` to BPF_TRACE_UPROBE_MULTI.
>
> During attachment, `attach_uprobe` checks this expected type and
> routes the attachment to `bpf_program__attach_uprobe_multi` accordingly.
>
> I am currently hitting an issue with selftests, and I would appreciate
> some guidance before proceeding to implement this for kprobes and fix it
> for uprobes.
>
> Selftests that rely on auto-attachment pass. However, tests that bypass
> auto-attach and manually call `bpf_program__attach_uprobe_opts()` are
> failing. Because the program's `expected_attach_type` is modified to
> multi-uprobe at load time inside `bpf_object_init_progs()`, directly
> calling the legacy attach options subsequently dies due to the type
> mismatch.
>
> How should we handle legacy manual attachments for auto-upgraded programs=
?
> Should `bpf_program__attach_uprobe_opts()` be taught to internally
> redirect to the multi-uprobe path if the expected type was upgraded?

I think so. bpf_uprobe_multi_opts() should have all the functionality
necessary, no?


>
> Thanks,
> Varun
>
> Varun R Mallya (1):
>   libbpf: Auto-upgrade uprobes to multi-uprobes when supported
>
>  tools/lib/bpf/libbpf.c | 42 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 36 insertions(+), 6 deletions(-)
>
> --
> 2.52.0
>
