Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA763E6398
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312597; cv=pass; b=SbDwhfolXht0hC+w07t+hIGEcU4OXY5SV1jBYUQcVMDgnRUbjbcbR4Q7wm0IeH2y/XGOqvo0MoRJuZWwyAD7sTDlHlbkXtEpI4T4hqULRNkzVUL77VEgq7Oxf3Htfj/cW/3PzxHYvilpKCMjxP0J3avDlShK7aNeIbIbNv18NKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312597; c=relaxed/simple;
	bh=R8JgkOd5lr+BChFUFWuQ91yJgC7j7jLEQd1YL2cU9/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsC9x2+O6bFlH5utMCxhjNaQpfRPitnqPs0N3Fl+Lo8iiOqhHMD2VJ2jmp5a+ut1nuF6fwWdkLu1mpZM2IbCn+Mx7ZI+dFn23PCpjmmpfwy9/RQYcsYnoD1Sz6waCoAacCLLii3Nn923VDiipENDMv1FPbmu5cV0cOWBopZVzzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZhWDfJM; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZhWDfJM"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so5877458f8f.1
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 10:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777312594; cv=none;
        d=google.com; s=arc-20240605;
        b=aqRbAOkzlfq6UfL5x4n6aNFLHlBRRWCBRjOq01SG2QJpbX9FGbYJH6ScMXYiJiF6bP
         LUVFmw+iqX7ExXw58vssFNX7M10hdnhbAy+AGifd6v5y794E0P1CEORqCHgXuRsnOViL
         roWql5MVt/u3pvBFKEoAljWqZFebT7Qv+ZHt5EYNgY9S6OhtYZ7qvu1Am+uUjCGxFq1f
         S01vsXX31BbETb2y6zA2IV6Y0tG5Wlu/A0SI9INuv4CcQH9JchWpwVT+8olLchL1fCg7
         yCvY4f5K24Kk8KLXW3c28suIfge6OM/EQTS0hbqLFu35LfFAVl4gpeFm2s//pUFymXVu
         dC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bdtk+tbcesdydqaq4rR+B1vnJAlIJvTKsXgd/J/7xZc=;
        fh=GpOlpQSEGZ80/560P0YK6ZTvONG+o2JAoGBotmoZrSI=;
        b=OjzDeXsal792qO3pjhfzBM4a1P5ZeeWYMZF9cZwqfjH2G36dEleyzBOxm8XJzBEDZ7
         C8iCT6XiJuI997CoHwgjVPqejkD/8r48hQyDi6HRaZ3hJEodJM4ju9N0/lf7kytn9Nxu
         kLxMrJouP9CYE5Dz6cTwrppQxUL6ToWh1baQzrVMtuaLRLEPe67nDtuktzd5ToJZX+gM
         jQAxs1DBD+6PNgas4VDPC4CQjgG+Lshur381snuz3hUSwCPSnLLKjCcp0RCo9xAqPIf6
         MMqBpx68I9hJfmwp023s9Y4jARHvrIuG6ZoqkqaurXhJdaqitZMaGiiRrDxp7zYKB3g6
         Wyrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777312594; x=1777917394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bdtk+tbcesdydqaq4rR+B1vnJAlIJvTKsXgd/J/7xZc=;
        b=fZhWDfJMdUS7rfGmLFrEjQTa3Bqoi/5sP4t7n8DezJ5vQYfldMPwsQXmCZN7BwqLW6
         EQDbT6yBqAEQMZ1kk4PEVgza2b24CjRUYZyVy8pQ08Ei92EcdIVBuF5nAy2oubShVRxQ
         7AtsvArK18UKWss0R9HnG+xeAdU2KuwvirJR9yOlKfyL9TE0lYlKIe1lobO1M3nWdkMA
         ZeabfVK9gxdan+kE+8uvpSGP8jaw6QzUr4ApSUSyewKn6eL0lR4bo2fBg3HPNv92jE6/
         KtArC46VD6BMupoCn40CTsJdXlI6nVF11hbNhY1iqP73Xz6B6boB2UDipNj91CYgyGma
         f+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312594; x=1777917394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bdtk+tbcesdydqaq4rR+B1vnJAlIJvTKsXgd/J/7xZc=;
        b=MQB8oHcFt79v2XYQKjDPV4NKLkG1lBCq2zWfhP7ACrXSI6gaFa98ap+fIlcjx6zz+5
         Oxk6P/0VfWEgZ7NFZcj7cjNGbATXL8jfh/hQ0rU39jg4w5Zuf3v0pYdzhk674QQeQYP/
         OIOVlkreudR3LpBYmsFE/3O2K0ff82ZCrtXqUSyKvEXfZI6TTrZXvWL3QBJLGK32I9xZ
         Ugxj35/Uew2OGqocFzNQGd/TF+L8abYwtZn7M02Ad8XpDHWYtgbsVNJyTG7n02XscPUH
         LiB4hpF2hVoANpo55dTL9yWhSj/nVIiip8+pwk+KYIQByot3H7p+YS5ESlZJrGlIexru
         nBWw==
X-Forwarded-Encrypted: i=1; AFNElJ9D8Q/PcWqa91wzJjQl6PLHK5kVCVPb08TpyKXh7O4s9kfHthKtB4JT2pk8xNJQiyLi6MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtkuB3NzrWD5HJVsKnVnbO7FtYnw857TpcMiJnfI8p36X2J21
	Rp8w9fAc8NbMHovvOavLLSdHbH8vUh6/61hnMqC84mdUjLH5UrARvktv4/TZCDt9caitpDNxNlB
	DbhcBHbQl4Hl4TIVRuHHAHqnko9hZ+/A=
X-Gm-Gg: AeBDieshhGoSRZVoqrf7O6sdotB+u6nnTcCXwdVxMq24498TnaJG2fJxz17uAYql3T4
	tfHst5p2l6hzujDOSjGqa8tKTgAQcIlFwa7Cmg9dOJR6j8LdD8nPC3bzBvGt96BnEdyCUuH7MX7
	ezv15/uhYca3LAoq0blKU/hWXbeVfW89Fke/yZepX/eEOOcQf1puo+CgWxoe4IiM1SkI/nzKgHA
	YqM/oU/aX3hxF0j/GoAumIlwAE2ePNrm4qmy9ZwXpyRmt71M3Z1hwEs8LDGjB0/ywJ+JIYfOA1I
	XVasEqXvFrCxWgU+A4O1c5XUPa7RYfn3dv6KDdwIrc1IY2Dve+suTCavX4KkxaW1+19/jrkw/6E
	8uLs=
X-Received: by 2002:a05:6000:2dc3:b0:43d:1c4a:37c with SMTP id
 ffacd0b85a97d-4463f3c980cmr41554f8f.4.1777312593855; Mon, 27 Apr 2026
 10:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425-cnum-range-within-v1-1-2fdca70cb09d@gmail.com> <cbe38c19690a27094f622c637388fab76c18c5c1d9356b8702acac37abe4a9a5@mail.kernel.org>
In-Reply-To: <cbe38c19690a27094f622c637388fab76c18c5c1d9356b8702acac37abe4a9a5@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Apr 2026 18:56:22 +0100
X-Gm-Features: AVHnY4KgOMd9BQUEKYPVX0rxaaDATcgEir8uDsUsIRoFwHNl7SKvGgs1lxU3NhQ
Message-ID: <CAADnVQ+UmyqeqGmqo+9k9CyRVANXfw+L8uG=gfgSCBOSZdEuUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: range_within() must check cnum ranges
 instead of min/max pairs
To: bot+bpf-ci@kernel.org
Cc: Eduard <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 12:20=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: range_within() must check cnum ranges instead of min/max pairs
> >
> > states.c:range_within() must be updated to properly check if
> > cnum-based range in an old state is a superset of a range in the cur
> > state. Currently it makes the decision using min/max accessors:
> >
> >   reg_umin(old) <=3D reg_umin(cur) <=3D reg_umax(old)
> >
> > This is wrong for cnums that cross both UT_MAX/0 and ST_MAX/ST_MIN
> > boundaries. Consider cnum32{base=3D0x7FFFFFF0, size=3D0x80000020},
> > which represents values [0x7FFFFFF0, ..., U32_MAX, 0, ..., 0x10].
> > Its projections are u32_min/max=3D0/U32_MAX, s32_min/max=3DS32_MIN/MAX.
> > A register with range [0x100, 0x200] (which lies entirely in the gap
> > of the wrapping range) would pass the min/max check despite having no
> > overlap with the actual cnum arc.
> >
> > This commit replaces min/max comparison with cnum{32,64}_is_subset()
> > operation. The operation implementation is verified using cbmc model
> > checker in [1].
> >
> > [1] https://github.com/eddyz87/cnum-verif/
> >
> > Fixes: bbc631085503 ("bpf: replace min/max fields with struct cnum{32,6=
4}")
>
> The Fixes tag points to commit bbc631085503, but that commit exists in
> bpf-next/master and is not in the ancestry of the current branch
> (patch-series.local). The current branch is based on a grafted commit
> e06021ed87b0 that contains the same cnum-based code with the same bug.
>
> While the Fixes tag is semantically correct (the bug was introduced when
> min/max fields were replaced with cnum structures), the referenced commit
> is unreachable from this branch. Should the Fixes tag reference the graft=
ed
> commit instead, or is this patch intended for a different branch?

AI is being confused.
These patches were applied.

ALL,

please periodically 'git pull' bpf-next to see what was applied.

pw-bot was unreliable in the past and got very spotty recently.
I think it misses every other applied patch.
Maintainers don't have capacity to send manual emails with "Applied. Thanks=
".
