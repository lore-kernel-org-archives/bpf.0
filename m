Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F41925BC
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214908; cv=none; b=FkH3F+ckurjgTWZbPE5om5wp+vGvsokfVrxczvWB1r1iukLxELPdeELHPbyd+1/6ZPfofYJ7n1b5pqtydj2ZC+WVdRt9IBixIvBhfZCf0Wbo3WGltWa+fM335ZV3qin1GKAWU7TlxUi3p2LPpUPgzyrSsWOxUMeEfRIkeEuWNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214908; c=relaxed/simple;
	bh=7plH7WgQTs+l9zZOaLB5rWBEoARwlNS5Gqh95RX4byw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=XFOUpG/1z9YWN8DpENJWixiuwKQOwNRjo2MrMke7ujCyL8zPMgzpBVHK5Bb9xLcK6D5y8JKVQEdEjp6MqDcKSG5x1bGBu4/e++ozj49+n65ZwfggftWY3edLtwr7TpqxX+xBk3kuDsmIfSwXx3St4KWA24LN02JfUUPPJuzdd6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qLHU4AkE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qLHU4AkE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F23664E412F4;
	Thu, 20 Aug 2026 08:35:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C4EF9602B8;
	Thu, 20 Aug 2026 08:35:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CDEF11C75B7D;
	Thu, 20 Aug 2026 10:34:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787214896; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bq/D9WVzFogb06jpCnh/bSgd7ZfHdWCL0Df6vR4FcE0=;
	b=qLHU4AkEzXlrFqI/0jeXQiAIQugxiUruOR4Jk9xBw2B07ghDBASFKw7eUvlCsar3gukj7b
	ea3t4z+0YBpDSalav6+eon/cDXlnrZgycNkReYCOxXz/z7tRV18S8ik/vycjCwblQxHjtv
	5Muzamcg5BZhTt2EHL4AQsULtlUirE0bV9YqE+wCOsI5vkpt8jN9G3X0/OwqymAtQ5ObxH
	hIWSPr2ZhbNXkQW9TmTsG8tDytkfZJ+xv50Wubqe602KN3ccyeIDQORDnknwrR6hmo0N+b
	EHY9lzKE64vN+brZhkCnZp3m2XgDtsMSmE9WMB0/aEOnVIkD7zEs5l0f/MsaNw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 10:34:51 +0200
Message-Id: <DKTMSYRHS7B8.3FQB9UVGWOTX3@bootlin.com>
Subject: Re: [RFC] running bpftool build tests in CI
Cc: "Quentin Monnet" <qmo@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Vineet Gupta" <vineet.gupta@linux.dev>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Mykyta Yatsenko"
 <yatsenko@meta.com>, "Puranjay Mohan" <puranjay@kernel.org>, "Mykola
 Lysenko" <nickolay.lysenko@gmail.com>, <kernel-ci@meta.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "bpf"
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <DKT6QBHWC8YM.4D90SOC807CW@bootlin.com>
 <16d6ca03-c8a4-4370-a8d2-c97a99d68bfc@linux.dev>
In-Reply-To: <16d6ca03-c8a4-4370-a8d2-c97a99d68bfc@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ihor,
thanks for the feedback

On Wed Aug 19, 2026 at 10:46 PM CEST, Ihor Solodrai wrote:
> On 8/19/26 12:59 PM, Alexis Lothor=C3=83=C2=A9 wrote:
>> Hi,
>> as part of the cleanup/automation effort in the BPF selfests directory,
>> I am now taking a look at test_bpftool_build.sh, which ensures that the
>> different supported ways of building bpftool work correctly. As this
>> script does not really exercize anything at runtime but rather at build
>> time, I'd like to propose to introduce a dedicated step in the CI
>> automation that already builds and run selftests. I have opened two PRs
>> in kernel-patches vmtest ([0]) and libbpf/ci ([1]), hoping I am not
>> confusing which code should go where between the different repositories
>> kept in sync with each other. I have also opened a dummy PR on
>> kernel-patches/bpf ([2], not to be merged) that shows how this test
>> would look like in CI.
>>=20
>> This really is a RFC, as not all tests from test_bpftool_build.sh are
>> being executed: I suspect those based on .config to be currently broken,
>> but that can be handled as a second step, depending on the chosen
>> direction.
>>=20
>> Any comment welcome !
>
> Hi Alexis, thank you for working on this.
>
> I am a little confused about what are we trying to test here and
> why. Maybe you could explain.

Sure, I may have been a bit light on this. The test_bpftool_build.sh
located in tools/testing/selftests/bpf focuses on the various ways of
building bpftool:
- through kbuild (eg: make tools/bpf)
- by changing make execution dir (eg: make -C tools/bpf/bpftool)
- by running the tools/ main makefile (eg: cd tools && make bpf)
- by running the bpftool main makefile (eg: cd tools/bpf/bpftool &&
  make)

This listing is also cross-tested with output path configuration,
testing both O=3D<output_dir> and OUTPUT=3D<output_dir>.

Will be included in the relevant commits if this RFC goes further in
this direction.

> Some variants of bpftool build are CI-exercised regularly:
>   * selftests/bpf directly depend on bpftool, it's built and is used
>     as part of the main "test_progs*" suite
>   * bpftool has a standalone github mirror with it's own CI pipeline:
>     https://github.com/libbpf/bpftool
>
> Looking at test_bpftool_build.sh (written 6y ago btw), it seems to be
> more of a Makefile infra test than bpftool test specifically.
>
> Given how complicated some in-tree tools/selftests/ Makefiles are [1],
> running infra tests like this would be nice. But then maybe we should
> develop them beyond test_bpftool_build.sh?
>
> I briefly skimmed over the CI PRs you've submitted, and one thing I
> would say is that we don't want a "bpftool build" test to block the
> kernel build when it fails. It either needs to be a separate job, or a
> step that is allowed to fail.
>
> Vineet recently did a similar thing, where the gcc-bpf selftests build
> was interleaved with the kernel build and I nacked it with the same
> justification [2].

Understood, thanks for the pointers. I see that Vineet came up with a
new revision that eventually got merged, moving gcc-bpf as a dedicated
job in kernel-build-test.yml instead of kernel-build.yml (and so, a
failure on gcc-bpf does not mark kernel build as failed) I guess I can
replicate this (also, making sure to add this run_tests toggle, maybe
?). However, I feel like it would not make much sense to have a build
and a test part, with artifacts going from the former to the latter, as
the build step actually _is_ the test. Also, the only needed artifact to
run the build is the kernel source tree (we don't need any vmlinux or
.config, at least for now)

Would it be ok if I try it this way ?

> I'm thinking the whole "kernel build" workflow should be refactored
> into either separate selftests build jobs, or some post processing
> that looks at what artifacts where built successfully and reports
> failures. This will provide a little more friendly UI/UX. You're
> welcome to look into that if you're interested. But that's not
> directly relevant to the changes you're proposing.

Trying to rephrase it to make sure I get your point, the goal would be
to have green/red checks specifically on selftests builds, rather than a
global green/red check on the macro job "build kernel and selftests" ?
Or does it go further than that ?

If I get it correctly, yes I'd be glad to try and help on that, as a
separate task.

Alexis

> [1] https://lore.kernel.org/bpf/20260804170156.1709916-1-nickolay.lysenko=
@gmail.com/
> [2] https://github.com/kernel-patches/vmtest/pull/502#discussion_r3724931=
742
>
>
>>=20
>> Alexis
>>=20
>> [0] https://github.com/kernel-patches/vmtest/pull/517
>> [1] https://github.com/libbpf/ci/pull/236
>> [2] https://github.com/kernel-patches/bpf/pull/13368
>>=20




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

