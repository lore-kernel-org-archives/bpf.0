Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249375;
	b=p7pTTWfKxwRKaBfEyLW5yLGpCXPQtQ1skdGzx05J8b/EHoqCSUnLt6Ze9MsrfgWF6mCs
	 bqxd629nc2qu+B+S7/bLjQ23R2JTrfyG8BFkgAiJdMIlapaaPuX7iCMKVGIvAAV5wyx2Z
	 RYCMbCWFt7dvhH9F3N4r+wApSbIMm5pR/cBx4kmeURfoy6ihzjx6v9Rr4q9tf4wXzxrS6
	 DCOg3Tllh0mGoD9Y6S8V+ueG+RJDlpv17hXWtPdxMHlxPtXcdL71Im4IDgil3nXi0qeB9
	 AJbwdIVJWRxcYGO3iqUtn1OWk8CjbUdG4ZvhfQj7xbdaAakJpwgrP7rU6FiMd0JFrTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249375;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XryAyzOT62H4jaVGcDRl1ybnJDHAbiye9fHmfJ5Ybuk=;
	b=FMFVUdNPncSNr8M0Y81qSnN07g527lN4oau71VzdHM409b6yRql6Mn6SA+KXCIGiEy4u
	 Sew0gMed4Hg0er/ysqlW27anb3Xilgx/PrYIcDCADbLzeEJXTELOV4s5vHdxE2U++zVc6
	 mTsgBdUj6B40/9pEf0lTi/EFoJ1Lp1YJPmoZULQ0i0xvdAs31QNOV57cf5LKvTNS7ihiw
	 Bfo0F3XOsyjfGMEXGQZcnBrQI8S3L0Z/B5tM2+gVbhl5IKbhLgymavP/fWIU9nysBnrOI
	 PIElrn1wsNecxVeFQ8RjB9dfmpMgL7b8jw5sQ63SG8+GIeW/N623yZm92orFjB74HVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Aw/2gYQl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6146606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aw/2gYQl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470C01F0089F;
	Mon,  9 Nov 2026 18:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794249374;
	bh=XryAyzOT62H4jaVGcDRl1ybnJDHAbiye9fHmfJ5Ybuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aw/2gYQl08plPIY3fc8ORhzjmQHW6faI3b1JIbxCk5ZrE8ByMtPSg688DUQaFTkeM
	 C/o2jEkT4R0a2WiEwH10Frsjdx/KDzzffgq0lyz+zJTBqFjr/N1wPeiiOuwSeMTc+S
	 zPXxB4HVBsUI0c2sEcqk3GPADn0KrRVzkvNgoEPOjcbQpBBy5aKyhfpHESE9zXeOew
	 2h8zkRaw7qynpOtmr/Uq3SnGnr1fN4Coz6ZrpjQ8CPLW/96As4xbfI5aUM5mKWVFB7
	 b+i8HjjCP/k/1C2QhhiTX8nTfZrzsgZ9nHP7gA0MTDbUem38VpESjVb9sJynXMbhAb
	 DnJb6/TXNr82Q==
Message-ID: <sashiko-outbox-205424@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] selftests/x86: fix fork bug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Roberts" <bill.roberts@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261109182758.252223-3-bill.roberts@arm.com>
References: <20261109182758.252223-1-bill.roberts@arm.com>
 <20261109182758.252223-3-bill.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 18:36:13 +0000
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
- [Low] selftests/x86: missing Fixes trailer and redundant report text
  in changelog
--

commit 63564f14db64d744c41e3438f86b4c7188ec7e2a
Author: Bill Roberts <bill.roberts@arm.com>

> selftests/x86: fix fork bug
>
> The shadow stack ptrace test does not check whether fork() fails
> before proceeding with the parent-side ptrace operations.
>
> If fork() fails, it returns -1, which is subsequently passed to
> kill() on the test's error path. Calling kill(-1, SIGKILL) sends
> SIGKILL to every process the caller has permission to signal,
> potentially terminating unrelated processes.
>
> Check for fork() failure immediately and return an error before
> entering the ptrace test's parent-side logic.
>
> Shashiko pointed out this fork bug, and the relevant snippets from the
> report are below:
>
> [ ... ]
> > +int test_ptrace(void)
> > +{
> > +     unsigned long saved_ssp, ssp =3D 0;
> > +     struct sigaction sa =3D {};
> > +     struct iovec iov;
> > +     int status;
> > +     int pid;
> > +
> > +     iov.iov_base =3D &ssp;
> > +     iov.iov_len =3D sizeof(ssp);
> > +
> > +     pid =3D fork();
> > +     if (!pid) {
>
> [Severity: High]
> This is a pre-existing issue, but could this code broadcast SIGKILL to
> all user processes if fork() fails?
>
> If fork() returns -1 due to resource limits, execution will proceed with
> pid =3D -1. When ptrace() subsequently fails, the error path is triggered:
>
> out_kill:
>         kill(pid, SIGKILL);
>         return 1;
>
> Since pid is -1, POSIX specifies that this will kill all processes the
> current user has permission to terminate, potentially crashing the host
> environment.
>
> Signed-off-by: Bill Roberts <bill.roberts@arm.com>

[Severity: Low]
This fixes a bug in test_ptrace() introduced with the shadow stack test.
Should the commit message include:

  Fixes: 81f30337ef4f ("selftests/x86: Add shadow stack test")

Also, this isn't a bug, but the subject does not mention shadow_stack or
test_ptrace(), and the pasted review snippet in the second half of the
changelog repeats the explanation already given in the first three
paragraphs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109182758.2522=
23-1-bill.roberts@arm.com?part=3D2
