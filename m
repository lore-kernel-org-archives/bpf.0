Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801683537C7
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442552; cv=pass; b=QlQS/PlVpJi0HVam9CpXaUtuVZCe5JFRCvJB/oQfVp8kkdacqz1EClbzGlkwuLE90dABf389aJADYYSSdAzwKP0wYUvJxjXnKeJRLFgBKx8/Q4NMdV6HM3DPfozSJwS7jUeZFWeLQ4XgKsouCOIliduDYy/y7uLAidzFXVVKO88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442552; c=relaxed/simple;
	bh=q6Nezx+coqG6mWV4fmEAwURcm6SBiKBuBYFOit8HG/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERiNyk3jDobj0RvtUR6F7XU5Ro9cNjCtN4sgVcbIqIvJCe/V8S6KQAds4PduIoo2cr4XFgtPoERAILz0Zu5WgsGfdiUjh54GCNT7Kwh0MWY6MD3XA6gL0kZjAWMPVIJyMSxkTUCvZiNrpR3RnqdmG+8fjfrmBAwwo4YR4gV5PW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXY1TfGm; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXY1TfGm"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43d70b3e159so440120f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 09:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776442548; cv=none;
        d=google.com; s=arc-20240605;
        b=Q3B5bfA8rucAlmaw8XelkDee16oLOmBHRRKdxwMIEceh1ONKP6erNWCk3FZLMJRlW0
         TCtzknS6Cnj+caCAEvJCaOR/3djZMXh8j7lWXs/UCXcJ+xwbU0yijjoKf1N+PYgu0LHp
         9GMDYeTzNH/gD+YCmy5Pb+AqFL7Uovw57FDH74QXuY0EhanIjIYXYuy4tWCudVo3olNY
         BcYoxnfuGYa/0KQca64dShknR8/lBGLrEHJ1QmE5Wj8Etp5bXYWUaYDXJLbECj/ywYsW
         ThANCQOUbYdCjg/YdsnrA/RjRzMRtIoLYsNLA4v2h7jxatqeQVDmUUX4BEpV8lz1Ey6p
         27Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9enA1eTjIvtoAOrDsdnAz3Q5kpxt6lAESqgXuJyiPxc=;
        fh=biVxOfAQ8y53MvSfca8y15aWHNNleTL0sZ4Yh4c+Sg4=;
        b=L5eaOE7nrfGyi1kHUnPAbG/XEX1he8x3/2x3UIskdCP/hxNt5bnMFjctY54P0VUs01
         PsweR+35U/nyjSuD5qM3gA4KJmFVz6tpVCLn7PFFoSPlsfSqp8BRtQvEnhwt65eZMjvP
         FRp4gZCgTPhT0Q0VEkpcqlrsUl+GstxkokyQYlZwPJSL9k0A8UjAsHiwmYGBtt6F6SyS
         QM9WjXF0xWkny00FsWbRHWNRCkYCVrPSEAPZkNi5EmZwlMb4leyUowvY2ahHnT1NkBYB
         J7jmkLkeKJzl51SIayeAio7eeAB6UEZ2o7MrlO+DrlGGSjrWDkjzu84j2c0Jijn5ogyz
         iwoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776442548; x=1777047348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9enA1eTjIvtoAOrDsdnAz3Q5kpxt6lAESqgXuJyiPxc=;
        b=pXY1TfGmXpeJq47QY982yvYnKPcob+U/U1/3AD14Rxy5EwzXBUaFiTE46IdgmDw3C3
         z07lPAgt34cNZWbe/doAtG4Z3JeJqiffM5U0obi8oJe+HfF51e/OiZkfeeCAeycqPJbp
         jO+d1Y0OE4a5DHa4A+U00NAzK82hSJCfXgy8zKtsza4LarwkeYQYHbLcJT13sj9Id9Ch
         SKDotJzhkG0b/wEZ7xESEZlyUl/AzSen2oFRlw2wzWJu6LbyBuB+6fNSbtfofE/VnctT
         kdRoGUeJRx0sHLxTS3YOPOmttQ2x0uZcBVx2erNP9xA3F4jS6z275u6L4A//l9qX1EXV
         YMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776442548; x=1777047348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9enA1eTjIvtoAOrDsdnAz3Q5kpxt6lAESqgXuJyiPxc=;
        b=hLlfEeWFQSJ0sXV3EPYyTdPc6K7NxCFZbVnVRx9Nc0XRgEDqT0f2CPbYAuJnTrHZDm
         eTfMqu4oNLNgOe4xNvLUfRWM/OuchKuxZBMS+XI2/7fgmmFardz0OS9OQW/v2kxjIWvh
         aSEx26WEZsQjKJzpnM18pZjP3uG7hQSmOIB89+3UFuzjBBQz2PoDP8P/9B/kMuEb37BG
         cc5v3ZWIZlzAiD36TfYrMwXKdfzmS+hIpQo359V1O59FLmQy0+XCiX9f8cSD5gMZYF5Z
         Ri5W568N4x19xq2Mq8UumODhN5KGQb6odqQQ3YvxIJ0yDcX3lzWG3noa7P+0xpbN/gcU
         gW/A==
X-Gm-Message-State: AOJu0YzT0w7Barom5IlH41MVc3rfecMeezHxPynubjob3SMP86/hJy2z
	qPkcVIBd48C9kIzIHDzmgWSE2kiPKPwsKJ4GUOxzKxc+A+Q0cg93VKed+ajCsv6aWJYAKM+Lbir
	lDKZa68hkCf1LGa1+i9bSDIn8SpAAjYo=
X-Gm-Gg: AeBDieskiSLZeKn3W0LTLAZ7P4cLZiHujXT92akB7xQ+vKi3hFeF1N2XggI6jvirSWF
	uzegLU8PHX2bzwxvA3B28hHK0yq99MlWo/sd9L4tpRDf9kov7bDtqb4IBkqZ67uyXigcP8knawI
	S8tc+BKVhGuRTPg9sLL72ANoAs75+bRI+wncd4PjP4v0oDRSFEOW8SmleWFXtRKNKZaqiYp/zAc
	saU762l9KABlO9vnwt1mGdsIMlMwdl9lkhq2BIaC+hc9cUbYuuYIDolXjgzs6Hd7ygYY+afKq2o
	PGm1dzkVfcAlP3e9R+BUF9y7WCSvbABXEi953bJDRI3hWbu5GK0peRR6MKKvkPCQ0WEqtIcX9vN
	vyHuEFEiuha+Ckn/2UaBp3H0t7y/1Pj0Y9XlbbtTr17gsArsm9lY=
X-Received: by 2002:a05:6000:2dc8:b0:43d:6fce:3ef with SMTP id
 ffacd0b85a97d-43fe3dd2b9cmr5207438f8f.21.1776442547324; Fri, 17 Apr 2026
 09:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412174546.18684-1-emil@etsalapatis.com> <CAP01T754f+qzWDG=9PyDmOXuL1mn9R9UBAtUor-RdzDGMGZx7Q@mail.gmail.com>
 <DHVIDBPOK7I3.2837ZLDGJOBY@etsalapatis.com>
In-Reply-To: <DHVIDBPOK7I3.2837ZLDGJOBY@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 17 Apr 2026 17:15:11 +0100
X-Gm-Features: AQROBzDI50JbgD1D7rA0Fi8FpE8c4y63XolZPEsWXmXx-iDXgvbyEV6awwaSgsI
Message-ID: <CAP01T75tGi6svN=2oPpw0m+-UcHk2gnOw989fB7GFh6J19ru4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 0/9] Introduce arena library and runtime
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Apr 2026 at 15:43, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> On Sun Apr 12, 2026 at 3:22 PM EDT, Kumar Kartikeya Dwivedi wrote:
> > On Sun, 12 Apr 2026 at 19:45, Emil Tsalapatis <emil@etsalapatis.com> wrote:
> >>
> >> Add a new subdirectory to tools/testing/selftests/bpf called libarena,
> >> along with programs useful for writing arena-based BPF code. This
> >> patchset adds the following:
> >>
> >> 1) libarena, a subdirectory where arena BPF code that is generally useful
> >> to BPF arena programs can be easily added and tested.
> >>
> >> 2) An ASAN runtime for BPF arena programs. BPF arenas allow for accessing
> >> memory after it has been freed or if it is out of bounds, making it more
> >> difficult to triage bugs combined to regular BPF. Use LLVM's recently added
> >> support for address-space based sanitization to selectively sanitize just
> >> the arena accesses.
> >>
> >> 3) A buddy memory allocator that can be reused by BPF programs to handle
> >> memory allocation/deletion. The allocator uses the ASAN runtime to add
> >> address sanitization if requested.
> >>
> >> The patch includes testing for the new allocators and ASAN features that
> >> can be built from the top directory using "make libarena_test" and
> >> "make libarena_test_asan". The generated binaries reside in libarena/.
> >> The patch also adds test-progs-based selftests to the codebase for the
> >> libarena code, so the new tests are run by ./test_progs.
> >>
> >
> > I am back in the same position as I was with comments in [0].
> >
> > I.e., again, I don't see anything in the stream output (passing -v to
> > test_libarena_asan) when I build it with clang 23 (LLVM tip).
> > What am I doing wrong? (Leaving aside all feedback about integrating
> > it in the regular test runner that is still unaddressed, thus tests do
> > not run by default).
> >
> >   [0]: https://lore.kernel.org/bpf/CAP01T75+BoQfQN=47NhYYviZttjCPb_CXNpa=DUC0=xSvdNZdA@mail.gmail.com
>
> The series introduces a selftest for the test runner called libarena. It
> is introduced in patch 9 to avoid creating a runner that does nothing in
> the previous patches. Tests run with test_progs like regular selftests.
> For ASAN we do not have LLVM22 support in the CI yet so test_progs doesn't
> exercise it.
>
> The stream output is suppressed by a switch in asan.c to make the output
> of test_libarena_asan legible. Each test that expects to generate ASAN
> will generate a ton of output. I will add userspace logic to consume
> the splats instead of emitting them to keep the output sane.

Why can't we put everything in test_progs instead of separate test_libarena?
Then add some logic like existing stream tests for verifying / testing
the generated output in ASAN mode.
For example, libbpf doesn't have its own separate test suite. I think the same
logic should apply to libarena.

If LLVM 22 is a problem just detect and mark the test as skipped for
now when unavailable.

>
> >
> >> [...]
>
