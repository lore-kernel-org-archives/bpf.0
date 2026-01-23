Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59555208994
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194670; cv=pass; b=DwyxWmbrrcHMz+Fio3iIalk2a8Gi6w2EDPtVBl2gtycJYJMylNIxLK+xy96Fy+EG9yzQqdknY5aO7HNo9D1DFPCB4X8HWw0EixXBJpfw+dUPA34+pOUlWzpu6dUW673jUiOG3hbnq0FG1xE9V5ndjpWcU3LGIP5dup9QdJiL55o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194670; c=relaxed/simple;
	bh=rWDQCp15baqJ4aAP8bX3vbVpR/UO3uYWRgULkeu55iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s046K2STAVBF75x+KR/xS13CsUVoL9UJlm5g87YQk2mhPvo1Zkgff3s/EwpnGMKwigKL7X27tpvu2nn2EdNbN82jQfF8/XRD9do4uxfCUkbw7CmLUK+yiF1oee+ZvNY0qZkWGAcjUkMSIZe/3qm1jqLwDgYy3fcQZpJF7pJndYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1BPEHB2; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1BPEHB2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbc305882so1554165f8f.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 10:57:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769194666; cv=none;
        d=google.com; s=arc-20240605;
        b=FD2W43uJOPdfGCOyGYHtGYxq1MGt+oxuPKju8dcWui2ZIdj75ZRrxnJnucuN1HOVa6
         PSPk5MyTiz/5zvk4QaAV7ahMPMYk6vGPsKtuwTkNHMuANs88QhMZztGDuUswPriOEcSu
         W7mY/ZbTgYepWU0FhVjoZ5EvEGXuXWqPE994ZNh7fR2A23VbNtrpwXKR2poUDANnQMbD
         8w+0cS+n7p4Qvl8jCu4qbIEJZ2ey9kW15WFZaZ5mXefxZFEu93FZjldJ54J3T77AZ/jE
         t2g3yXEtr9kaZO1H0gE2EmA6b1AiqZQ2taVBdA4WygJAbWkQciSlS8vFjFtH7yIcr+GR
         Rvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rWDQCp15baqJ4aAP8bX3vbVpR/UO3uYWRgULkeu55iA=;
        fh=omZrD48Gs/de/ahoxs7dj0o7gkd1e4k9chRizYazdYw=;
        b=UBLQeFderV6UeT23wKtMfyOJE3X449FNTUxT5fbGwt1RPIcgtgIF057kxF/+nhuS8E
         644KZeOkuuThSsGs8IYXfqjWQqTL2xnw/9tddiDZKJGFs0hhkXR8BXTcZLfPXvtQZ/iN
         Gr2RPPmZJBJmWxUYiR8jr1TUpHpSGZnKNPdgbp1MEmUg9a34bEtZ0LVkmGxlNKgHcHWR
         USoM4zMcSucls9C0t3gZSj8JIFRD7JpBMYFiG5oGzyh/DpIqdGS3ARmeWZ9sZUOIAmPW
         +uIyW/Fh2VqgmxI3CZX/Qp6y8rVjk+fb6UBweSi1bT+tNaf78l54l87OCWlvMk+DJygL
         6lDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769194666; x=1769799466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWDQCp15baqJ4aAP8bX3vbVpR/UO3uYWRgULkeu55iA=;
        b=T1BPEHB2aOOg4+qvDonPfcdNegNgItGJI6is1ZerCvddTMbjxh5clncqiO7r30VzLq
         AqWUF+kuQl3ygR+vp49nrZLipvkhxC73lwKnJQQJFqWYxt63DoScsBGbARUldTMyBHUv
         vcM2t8gMK3eFFOzcIUA+gd2umspfPHaWQKMQ3WJ4OF29C0omnX2kbfbBFABqxxa6bxF9
         S3siO4HIsfbVzeU2hSUzPc7aFHHbCCeMbpIjIxf9hGH53S5nSved2ySDOBtD0jfFyFTl
         Hb4vUDTCuwD0aL4B23QzPrYs0JKR0Qj3a/clza+uqCRpaGPfgxULqywAqjIuNheOQvOx
         7ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769194666; x=1769799466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWDQCp15baqJ4aAP8bX3vbVpR/UO3uYWRgULkeu55iA=;
        b=iQkCusezx41gVDNHqWC+ttYhCBHGFYZqK+PcebbvcCTGnz62nPncUGmBoC/qtt+CHU
         Ojdxl3OQDwj8CoWia4usywQOf3OLkRKggdLjTs+fOgDDOxPFZC6t5NypjuNxKsEIYxeE
         UC5kjclwB5dNwzIYypBDwDCuJS35rOyBynxQz8SqutsGoy3BCIsnYFRqQ+DGF3uuzrXG
         gURBTjbFE4s0HX35M1EE1pDNtpTYYGfh/tay0qijLs1VGxa03QGK/U5MJ2/w6iOa8Akn
         Odz05Xe8l8hp58Z9am9ZNFK1EMzs5kKHtI8HHUGuZ4UEYgq4O7ekM2mWC0twnAvPOu2Q
         GlbA==
X-Forwarded-Encrypted: i=1; AJvYcCWV9pJfv6yT6/WEo82/cRy/jFovm5lTeKraQM0c9KWV7n5S8/nTsjFzbHDCDeqXzxJr84A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcfL54OW1IlcmpPmgfMQSAVm0aTgsoG3fBRFNQCHixGGwOxQZI
	bV5QIi6pe06dd9GLhm/MrwqcUJN1Ho9K+3KZ3lJBQ8U/aC4+W2EUHMy85piKLMGL/g4jlsZncFq
	I2/P0M7trbRuisIFZdnYSRRdEi0MwMK8=
X-Gm-Gg: AZuq6aLzeZImIQTJNo3HWvmICpkQLfY6pIP8ZBz1kwYD/zf0n/plz+YiDTKLx8xGAxp
	XzUZUNbyVVcAa0VV5+jdRvbV6UWFb8kWbgloQUhZdruX4yiB8kNdZjeo2jPyGY/0RpvKZUstFMa
	6IOuYoe7xVMGaJr13FrilsRfbMNsTafRKJpoc9QChE7sKULK+tLRl3QW5T8yvfjsL0+Mmq5Jmni
	+lzcg1teE4aDBppNZttQ/cYCsNUrhFnGDJrcIMnrLd31jg3VSdGUymZohN4jsLTcHXWg3ktRjsg
	1Wrz2U996vTocGL+UaRNcIOi22S1ySbJtlJHRWpEh0gvOYm5o5aT4MV+SQK1dY5gFUwaTEOy
X-Received: by 2002:a05:6000:178c:b0:435:9690:f056 with SMTP id
 ffacd0b85a97d-435b15fafe2mr6917717f8f.35.1769194665619; Fri, 23 Jan 2026
 10:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5be1a66a-2594-404c-9c6f-cd36e1eaf684@gmail.com> <a46cfa94-fbc4-4fc1-8042-230055af412e@gmail.com>
In-Reply-To: <a46cfa94-fbc4-4fc1-8042-230055af412e@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 10:57:34 -0800
X-Gm-Features: AZwV_QiXcmZBYVXUxNEnBOv8YsYh6rzr6Qjp1uOUfFHnVT-n777FDYNLOqnUNB8
Message-ID: <CAADnVQJ_JQGWRMW3LxsHiEKOf3on11XVeRLgtMv4VjUNM0pjew@mail.gmail.com>
Subject: Re: [Bpf] Re: Undefined behavior in eBPF RFC
To: Tristan Itschner <tristan.itschner@gmail.com>, bpf <bpf@vger.kernel.org>
Cc: bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 6:43=E2=80=AFPM Tristan Itschner
<tristan.itschner@gmail.com> wrote:
>
> Hi there again,
>
> first of all, I would like to apologize for the unprofessional tune in
> my initial message. Sorry for realizing that only in retrospect.
>
> My concern was as follows: In pipelined RTL CPU implementations, it
> makes a significant difference, whether unaligned or only aligned loads
> and stores are allowed. Implementing unaligned loads requires quite a
> bit more logic, especially when optimizing certain fast cases. Knowing
> from my background that cBPF requires unaligned loads, I assumed that
> eBPF does the same in principle. My concern was that someone only
> implements aligned loads and stores in an eBPF hardware implementation,
> because it is not explicitly stated. In fact, the word alignment does
> not appear at all in the RFC. This would break jitting cBPF programs to
> eBPF programs, because then the behavior of unaligned loads is
> undefined. But you would not notice it in practice if you were only
> using C programs, because the compiler only generates aligned loads and
> store (unless you tell it to do otherwise). This is only an issue in the
> context of processing packets with variable header length, such as is
> done with cBPF. But cBPF is enough for that of course.
>
> However, I have realized now by re-reading the spec, that eBPF allows
> only aligned loads at all (I misread the C-like syntax), which of course
> makes a lot more sense for the actual use-cases of eBPF.
>
> I hope you do understand now where I was initial coming from. I'm a big
> fan of both BPF implementations, so please don't get me wrong. But my
> concern is unfounded besides being understood as a suggestion to clarify
> that behavior in the RFC.
>
> Best regards, Tristan Itschner

Hey,
Sorry for the delay.

eBPF actually allows unaligned loads.
See
https://docs.ebpf.io/linux/syscall/BPF_PROG_LOAD/#bpf_f_any_alignment

BPF_F_ANY_ALIGNMENT and BPF_F_STRICT_ALIGNMENT flags.

It's not documented explicitly in the spec, but any new HW or SW
implementing support for eBPF must support unaligned load/store
without heavy penalty like a trap. Otherwise it will break
performance expectations of eBPF programs.
