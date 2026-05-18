Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDDA3803DE
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779075003; cv=pass; b=VCpel6zkGvZIU7112rEZgmQ3lTrL2C4m6XDL79NXK0F7V8kAS7ipweauk91iuA8VFMVImTzCqPCGM9HVl/PigUyWhrBwie/CDnnKmRQoTLjEnJtPc94X70ENiYPTDOv+kIhBiXUxeVU7yVDWtUUezaN/Qo13shagPIxZS9BY/Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779075003; c=relaxed/simple;
	bh=Ah2or2wqmpMc/QA9Fh43Z3aAuzOVZJMZOOpqKfpS3T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEF3n5W+OvVtZy0r5TXBY0YqSKS6DY7pXMlzgXwHXRMNQRXuXWMdj6tXUZrb5P5Kw/V6k8d4OGl6T/3xPE4OHf4n7bbfPIi7rlOI0mjUTGLrUIG5mDeVgPAbUZ09liUykBXRX4QP8vHFs750PKgtPiNdbmuIlyUZcGuOoK2ssDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUNfa1Z3; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUNfa1Z3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so19261565e9.0
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 20:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779075001; cv=none;
        d=google.com; s=arc-20240605;
        b=db8xddtKemwlHSM+ng3NqEHRsNvvHJPZJXmPAKvwBdHIUZ3n6AFGHZIxXCDjQxeTvC
         8aRQkRAijHs78gPS02YSdXqt4jkxPzh9Bqzc3YgumyOP6x8Hz72M3z1D5INbk60SKGoJ
         pI5zx6YOw3ypzYQYl+ZDUcQhd/Vdt0zXuZjf9H0XUSycZsUon4/HPvsEo7XtVSGHvc7g
         WNYHo1z0oHyU8g2jbawWHd208Kopj1BOJ/cuF26n+ma3/IAFaOCBHa5tK5HaSO7PfnBf
         k/Krgsp73rXTS9x+2YZAnC8YY038Yj3ztlL1SVgh8RvIDdsJLTaBGBRHygNCLSk5Hik6
         7KDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ah2or2wqmpMc/QA9Fh43Z3aAuzOVZJMZOOpqKfpS3T4=;
        fh=3xknuT5WL/NqbnJpXwQYnW+td1YBF5a4KWkJipVzyMI=;
        b=CU4Q9gxDE7xNGYKy1nBkFF7ba7B5J88vdPxa3D5LavP6kX0+4MJpBWNHe62Uyd62N7
         ubwq5wIMJ1A0L2ZyzPPdTrAIU1GU77r4HbkvH2uWoWq0RU8PTTGvsOMgkQ2NtY8O4wki
         pTkPEPj/PmVR1um5tTB8IS3paY6EGqZ3I9jsstnjX/kc4hlbGCciJxu0xp8FnsLvVdB7
         AFzWG9Hil3VWCYDb2XQp7pffW8YTutwRnJKfL8oEt+Zqo46QLDBv2V47EewjtB3hzJpY
         D+Vd7jBtg2gyruZvLL5Avz6tc9QaBQFwjBm32bbQECQeGLqhMGVd+DRWHgdO0KvyRQmO
         HsAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779075001; x=1779679801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah2or2wqmpMc/QA9Fh43Z3aAuzOVZJMZOOpqKfpS3T4=;
        b=IUNfa1Z3DM9Bh12g+I6TcllOzu8J/koiqn56iX7+DLbJu0VXaiFl/l7Oy97Qfm0u17
         xQzLHuer/I2vjy3DKKw6FzxEW81cJ6pEpB7KW14g5ZXKFN7oWKG7OuAWOSKz6gTusHf3
         r+d/oQdqbzl25DuBkSuUb11kyPCgY6N7nY6u6mW+lG+xM2S3/mMD2DPsi3d5d2YqVyRr
         BEWYgpDfYurKLER8J3vyVLBZ2mJLKZTyD6z7YRRfK0T0eks3WuUv7niTrQYRFC6sBpJy
         cyreFq6xqwgIYMn1Zv0ch9Y34heYlMdODr0R0cqx0y7o5ZOLxxdBi4qiCOhuryiTyKrR
         rzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779075001; x=1779679801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ah2or2wqmpMc/QA9Fh43Z3aAuzOVZJMZOOpqKfpS3T4=;
        b=CCzf2TbimXuhn4EMbjmEMGBfEOAFjM+pvXlssylsBCB5Cc/KXxKr1/osseV80X8Nz7
         nvS98Q6VKxgdUrTSRxgWHI0B/26Mjnj6jBcFl52xpZAP3ygVZ8AuZzoQiChEVZH/pdZE
         sCLXm17WVQE0sgVVOPh/3N8/YoUJzQ0o7J0LPFlfwFSAfhiK1W9UQ1loZQm6xXWY3GWl
         3JEBteLbyB/52RXKpuEFYT5+xLPRESg9f3NRuYbpYI/vHHUQCuJk2FgVaV1M77pgzxR6
         3KwmnSo31/2+szvoZUBYioamnDOqH1oClvG3avehsBBDkwIFYtEturEQVjXEkyv8kW9X
         GGPA==
X-Forwarded-Encrypted: i=1; AFNElJ+owPw36pkkzBJRwBWNwyuwkk2IFtGVhJ3Dd8NBVAvTcMX1/YP3R4HGLMwuM7XmriEjmJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/ArPICUP7q97XqM9xq94mcUZs525powXyGO6txwIcYYa3quH
	6lo0xAUO4nEl/43bqhuhKRhqhSD5LBEGWp5v5Ix0HHtduHsIH3FCqioiAshsZttf8Bg11dYwMOg
	L4aDIEtI5nv/uP7pfkJio4S/0iKuueeA=
X-Gm-Gg: Acq92OGo2kH0/rtJTGkOpVacqpw0LWh2iFD74W8phLoLMnEQFHJFELHVdLHiZhAnyB5
	5UUu1TYNyRQtgW3/SlKfDyCImIepIeLPamAk62AlshVpHDNsAbkoIeQE1pALp41SIm8qtPrEn7Y
	Oby8gf8h9SHO2tI1FM+XvUEguPpEO5TC5UhTJK7b9OsjBxJmJ9qqN1S1kkOS9rifRcLKAfw5lTo
	J6U7YH2HZLwGIkiYhrrt+IMjSH6EUDlmGgUcnfVzTky/561kXY0FAWMeI3OeS0c7cvgpXzlh51g
	KhBrs7ctqEuq1syVcIKmDIHUbfqRC1/YPK0DgwfTEprnRNsO27/2VjyYMTMg+x6+20jBxoXzIWI
	sxbu0+2A6WlIVCJdXfgVVoN/4zA==
X-Received: by 2002:a05:6000:26c3:b0:45d:b14b:23fb with SMTP id
 ffacd0b85a97d-45e5c366f83mr20413156f8f.11.1779075000433; Sun, 17 May 2026
 20:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-1-yuyanghuang@google.com>
In-Reply-To: <20260515071504.2054786-1-yuyanghuang@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 17 May 2026 20:29:49 -0700
X-Gm-Features: AVHnY4IEM0nvjSnXzFwg7aWUVavgM-pZSVaHMNKMxqjmbw4PkrOQcMdn5z4rIOY
Message-ID: <CAADnVQ+Mc81ciE+6i4Mvg5h=fRNq6460w0-NAw_bU12oaBWruQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: Align syscall writeback behavior with
 user-declared size
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:15=E2=80=AFAM Yuyang Huang <yuyanghuang@google.c=
om> wrote:
>
> The bpf(cmd, attr, size) syscall copies up to 'size' bytes on input, but
> several commands write outputs back to userspace unconditionally. If the
> caller passes a short buffer, this can lead to out-of-bounds writes,
> potentially overwriting adjacent userspace memory.

The whole thing sounds like a user space bug.
Please demonstrate a case where this issue is seen
by using libbpf APIs.
