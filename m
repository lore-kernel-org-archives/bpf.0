Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235457;
	b=K15lLLbg+t/wEBsvJTLT5kLJCQTomFcUyPlep4g93La+DpGQcFEUZRI2qEvg6qwHzB6j
	 QAaRRE9NbRtVOxpH6hgGrR5YgeJzUK3YdEx99U32asC9/R+0oQEXePR1OSVXey7/VNJo1
	 gCmJrupQMvb13dwZERE1NUj3nbTnGgwoqz/XFvp/9ogx0Jh+gN994Q0vjeJEQx2a243b/
	 1V2jAMkB0QzJyO7ukteIleZorSjp3k/JWCaT0EN76sgYqvFZWR0UAaekW5lZ5Da5P2eCe
	 BMIdZK/gQWTeJcZl97R1d0tWktlhhEDg/y4nVya9kh3N+LszNJdaV+jZZ9kzhO26cuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235457;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4cLctJ9Qo4U4za8wRy/kYbYmCRd4xjZ8XCPM5NSztzc=;
	b=codT78zULRH8tWJfqgeu6+RMDCZw2LLlsvJAHdcNLILLZMJiSbTS306cckk5j42sy57f
	 snFjn+Eujsqvu6zA1mYn4/qvkf6lWYHU0WNoFvGDG7bkK0UVzyE8wk966DTgitP9x7cpe
	 DKUP6Z/5L5UcSYIULJvqTBCJuDNKYxLVyQP33KU1pqp9KEjPTUCiVBi63spcnk8OCWEPv
	 22gHpiql4tbHmCGMYw1uTVj/7XF4BdZV2wwhWg9mByXQg66sc53W9Mz+jypboWOGfJW38
	 4jNIHKCZC+B6BuxhMTEeweLZONJK2vdbvwqjYVu356tUvyn89vtmDQ57hvmvQKxXUCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYCSscoj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CB606A323
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYCSscoj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E46E1F0089F;
	Mon,  9 Nov 2026 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235456;
	bh=4cLctJ9Qo4U4za8wRy/kYbYmCRd4xjZ8XCPM5NSztzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hYCSscojtgenDMRwylCF0fukr/ncMABMSTmInRpg5bTLptzTzaQpvfYjNWqNb2FIC
	 awexrPoHfoTJJo2PbXFxv86KftinVmNxl+LD9nvUUCy5D16pFO1Aa6hFRCrfkdN/v+
	 ADaSP/M2O9Rx/DGwp4aG711bRhgMjO6e9WzKEMpE2qIseScmA1VyG+DwbPHiBQa/Zr
	 q08dyrTCJMvDyyonCKLXWOgPwH9RHGSffJJF27oNwTwqm+38Zy9fonA2h4Gg+vQ6Mk
	 sPk9Ygl4okYvRIwj/xaTO7rq32ySrs+r8a9gRZLmJy1n4aVEX0kNGtUZgvWUHDL6Ue
	 fvoAD3ThVMRog==
Message-ID: <sashiko-outbox-205125@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix va_list reuse across loop
 iterations in scanf_one_line()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWRyacOhbiBHYXJjw61hIENhc2Fkbw==?= <adriangarciacasado42@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261109143846.1626182-1-adriangarciacasado42@gmail.com>
References: <20261109143846.1626182-1-adriangarciacasado42@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:44:16 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/bpf: missing Fixes trailer for scanf_one_line() fix
--

commit be7c1bdc105e46aa8eb43384f62da500ab1ddc9a
Author: Adri=C3=A1n Garc=C3=ADa Casado <adriangarciacasado42@gmail.com>

> selftests/bpf: Fix va_list reuse across loop iterations in scanf_one_line=
()
>
> scanf_one_line() initializes 'ap' with va_start() once before the
> getline() loop and passes it to vsscanf() on each iteration without
> reinitializing it.
>
> According to the C standard, once a va_list is passed to a function that
> invokes va_arg() (such as vsscanf()), its value becomes indeterminate and
> cannot be reused without an intervening va_end() and va_start().
>
> Specifically, when scanning '/proc/self/mounts' with the format string
> '%*s %4095s cgroup2 %s', every non-cgroup2 mount line matches the leading
> '%*s %4095s' (returning 1 instead of 2) and consumes one pointer argument
> from 'ap', exhausting the two passed pointers after the second line and
> causing vsscanf() to write into uninitialized stack values on subsequent
> lines.
>
> Move va_start() and va_end() inside the getline() loop so 'ap' is
> properly reinitialized for each line.
>
> Signed-off-by: Adri=C3=A1n Garc=C3=ADa Casado <adriangarciacasado42@gmail=
.com>

[Severity: Low]
Should this commit include a Fixes: tag for the commit that introduced
scanf_one_line()?

  Fixes: 67cdcc405b46 ("veristat: Memory accounting for bpf programs")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109143846.1626=
182-1-adriangarciacasado42@gmail.com?part=3D1
