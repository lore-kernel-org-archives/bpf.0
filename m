Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282B3CCA12
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794546; cv=none; b=ZPmd+YkkRx5U9ip/fAmXHF1P6vfmRaDKHmo1l8bUgoOxwrYKspgcE0yq6HTN31GmVVpXdMxzxbrzZ88nH3Ii3FFhjnXoPoIX0IB45EsGF9S/3RqPulhJLuZwz5py2CDWASGXyF8HZ+f5Jzh5qa2yIJDf924vkuszft2og9B8E/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794546; c=relaxed/simple;
	bh=EVKVIefgDC/PBqL6YGHoR67wmzrgbiJyMXmA/9DVfZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DK7haO1s+p0VdFplCBKwV+Rw53iEKDcy4H88pK6hVFKPRtHWMz0qE85L5sP9//ule+SQpsi4zBraVPTFyorcoa8OsLFPmdY6eb0KlMIJ9a/RvqEA6d+Mc5FfrRPyDCZJxcVdbD0pE78DW3DFRZ4j6Cdit/Y5UxLi81GoiTYm+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J43ZLOEB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J43ZLOEB"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36a7bbb9698so2138393a91.2
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 04:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779794545; x=1780399345; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EVKVIefgDC/PBqL6YGHoR67wmzrgbiJyMXmA/9DVfZE=;
        b=J43ZLOEBMbnnRwvOtiwDUqdKGk69YLFxBvhZkcH3PBBQuSI0vOtmzipCV9V2OAgaa5
         nlVP3swVKFYnmHZxPD8G7VEWHo+NJzyqAPVwfGeMY8ktKfKisM9NdjqlMHfk4kCuwad4
         qsC+4tftk3G09Oss4plMykDHE6avdny3ctOH+8cYOxvmXfGr3ktq6rJooWJfFPoPynHg
         I/prdGUem6c8aMsse1knM4VRF0NUgBBsbMn4xMfX0YmutD/htXLBE7zGrekOcvOcZiCe
         U3rYKw7Xz4uPYTXFfY3ZwNSHXqc1/FAOnHNxriTHaxy4h7DADEWNskpuFGUB5O1Ivfcn
         bl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779794545; x=1780399345;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVKVIefgDC/PBqL6YGHoR67wmzrgbiJyMXmA/9DVfZE=;
        b=WvLtkHwvK19+7SY6eylur0HGEIHY0mA/rutE4SH24l69SH0ITWpzDfpAI5foOCPUbn
         Juu12cQApVLmZ2r02YAJqwAiq29mVQC0QB91rxuS1hLOXd/vdYWz2P3LPZsdE6QINxHB
         FkZKuvLgwu+ApBAm5KXFvKzi3g2ArOYm9HQYHCaTMKqA1U04paMY4M9+jFxO+nWs7MeO
         zDOwrpvoVGvZJwm9Rz7Oh986JpB52uUeiKdjh+a8HZSlGu8uhZrRFRY2GrX4plW8Gmie
         XqI21h0WEsjYQZfK3DZJDXCjXTrHxK3SCeAI1Lua8p1gYj2LygD41wTBc1l4mtXhz/k1
         cCbA==
X-Gm-Message-State: AOJu0YyLJD8EJ2T0McS1ftuxuOSjJLLmbYQRVGU72fbSE1zwDtqQGWGK
	Bb9ta1srWdWqqAiUOKPRcfWyQPVhRcACdORmrOGwOUCsWt1MddIip5IGdtpd1wgR1zM=
X-Gm-Gg: Acq92OHq0/56A0jF0DrjNy78EAJcHYNmv2ok/+lx8dXH8YUpaqhvtphPtGrNTCewa2g
	mehNAPG6Kde4dm6lUOIRW1Hwf3srO4zpcPwIMGaqbdpof/SEIDyQpXcmSXZKA3ID83Hi9XpiY/R
	KSIaHG6Z0hcz2Af/jfe81u08AVoCs1j9YqNnnA+40jIKSZowTb5KpA9WvWN6Ke6gfodUX2jSaO1
	OE+XLDJ/CkeiTkoLe3Ns5hOZGRs4kpAdTCk3FD69OcZMtAnm1t1WnyapTD9c9t+a+rpqv/yZ93g
	r7IQHbxAOHUEqoOQ0YuniCLu47qAogtj5BEaQyf8xJpthCXW1odu2exfbrlwPIGzqRb71I676Ns
	bMeYZvU9WQG4eciThq474FLdlY9for0DXPqG8EEisNNUiav6RETRAs+8hSVzhkGTod3AiIuhmFd
	GR5VgRxwOo3KfkuJvhRXqtgujdzvu0TwjZMlQ/D5IXQSsckFZCZtQnOb925Mg8gw==
X-Received: by 2002:a17:90b:1b47:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-36a671e9069mr17418698a91.0.1779794544803;
        Tue, 26 May 2026 04:22:24 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721c7baasm15720019a91.9.2026.05.26.04.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:22:24 -0700 (PDT)
Message-ID: <d2c217ffaae81022cd323394c3c759a8d36d0549.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/6] selftests/bpf: test cases for loop
 hierarchy computation
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Tue, 26 May 2026 04:22:21 -0700
In-Reply-To: <20260526102514.AFE3C1F000E9@smtp.kernel.org>
References: <20260526-better-1m-reporting-v1-3-51e4f2c59780@gmail.com>
	 <20260526102514.AFE3C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-26 at 10:25 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The expected verifier log output in `fwd_edges_no_loop` incorr=
ectly expects an unconditional jump `(05)` for a conditional jump instructi=
on, which will cause the selftest to fail.
> --
>=20
> commit f35c2f4d237eac02dd241fbf85f69d40722f62de
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> selftests/bpf: test cases for loop hierarchy computation
>=20
> This commit adds test cases covering various branches in bpf_compute_loop=
s
> for loop hierarchy computation. It includes tests for single bounded loop=
s,
> independent loops, nested loops, diamond control flow graphs, and irreduc=
ible
> loops.
>=20
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.=
c b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
> > new file mode 100644
> > index 0000000000000..db26157e3e14a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
>=20
> [ ... ]
>=20
> > +/* Case C: forward edges, no loops. */
> > +SEC("socket")
> > +__success
> > +__log_level(2)
> > +__msg("=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0: {{.*}=
} (b7) r0 =3D 1")
> > +__msg("=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1: {{.*}=
} (05) goto pc+2")
>=20
> [Severity: Medium]
> Will this test case fail because of a mismatch in the expected verifier l=
og?
>=20
> The inline assembly below uses "if r0 > 0 goto 1f;", which is a condition=
al
> jump. This translates to opcode 0x25 (if r0 > 0x0 goto pc+2), but the __m=
sg
> assertion explicitly expects opcode 0x05 (goto pc+2), which is an
> unconditional jump.

The code is adjusted by constant prop phase.
I'll just the test case to call urandom() and keep conditionals.

[...]
