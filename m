Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B97478E39
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315564; cv=none; b=ALI5TuLVywYG8H1To+qLLbrsgq3bFhhoGHi7KudaoDvr6akkZvuq1LuhZ1gLxxpzmXXc5+B6GXU7rk8oPQRQW6/uZbnkkEVj/oLOOK5HMg66G1mXRpTpolax5/troVirYqRTbgw+yoVkOZA3+ISWqPbXjyNX2uB+BlzPfkcaV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315564; c=relaxed/simple;
	bh=pmSNxuyH/wG2c/iEw4Tj4WBkyUtLCA5+3cG11jF8U+Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=KngNbP4FY1nzwQm/DouDpN/JerKCsFohCcOQWLvjfHKkRD5SdJRl/PJ35mpBHNda3dWxASyzr3ozs6Q0S/znCvv9gK1EGhFLgg/d/HNJLGShjXSW3Ki7l32f8rad1271KhzJ9CvlMrL25a/IqoH25OjQWwsOIi/2FM52E5CiPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LMyx0zo5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LMyx0zo5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 738E51A1779;
	Fri, 21 Aug 2026 12:32:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F3C6604AA;
	Fri, 21 Aug 2026 12:32:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B51311C77092;
	Fri, 21 Aug 2026 14:32:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787315548; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=P/okyOxFdiUUod5QLoMbmhUXHjT1ii/NpGsbLcZR7cA=;
	b=LMyx0zo5slGi86ZjY5mOL5O67VCvb592BKpstwHkfxvPANAuRTQoSSF4+lNsOn9Pq2jwA4
	Gf4npCc7pHQfypFwuQLdJz3Q3ptrzVbKdUjduCZICuN7yQTYRPVlU4rbT3xRVuOh6YV49G
	ZJ7OkPSBUQGHfGk4mesXyL1BhXVdi9wVTviL2Z7WlypxHRO4ZBiE9L6JTONps5nZNPEwkH
	8ZtmPbPZCsA00zlOEZCWRz2T1RDc0PuU69DmQtVCBz8OsfonCMMy7SDERyfuMUDt4fsiAT
	p6AJ2GgTYHYTXNBGWR4x9cSp0vM5guMojb5ZO876R5kSlZXozT3gx+2ldBkoog==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 14:32:23 +0200
Message-Id: <DKUMHDFEVFRO.2OO8S3V3YE93Y@bootlin.com>
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
 <DKTMSYRHS7B8.3FQB9UVGWOTX3@bootlin.com>
 <51eaedf3-78af-40a4-b3d0-f668205808b9@linux.dev>
In-Reply-To: <51eaedf3-78af-40a4-b3d0-f668205808b9@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Aug 20, 2026 at 10:12 PM CEST, Ihor Solodrai wrote:
> On 2026-08-20 1:34 a.m., Alexis Lothor=C3=A9 wrote:
>> Hi Ihor,
>> thanks for the feedback

[...]

>> Sure, I may have been a bit light on this. The test_bpftool_build.sh
>> located in tools/testing/selftests/bpf focuses on the various ways of
>> building bpftool:
>> - through kbuild (eg: make tools/bpf)
>> - by changing make execution dir (eg: make -C tools/bpf/bpftool)
>> - by running the tools/ main makefile (eg: cd tools && make bpf)
>> - by running the bpftool main makefile (eg: cd tools/bpf/bpftool &&
>>    make)
>>=20
>> This listing is also cross-tested with output path configuration,
>> testing both O=3D<output_dir> and OUTPUT=3D<output_dir>.
>
> Right. That's what I meant by "it's testing makefile infra".  It's
> checking whether any of the listed ways for initiating the build is
> broken.
>
> I agree that adding tests of this kind to CI is a good idea. My point
> is it's worth expanding the coverage beyond the bpftool.
>
> There was a patchset with fixes for out-of-tree build of selftests
> recently, for example [1]. The tests would help to catch this earlier.
>
> [1]=20
> https://lore.kernel.org/bpf/20260728-selftests-bpf_oot-v1-0-05feb15d94db@=
marliere.net/

Ah, ok, thanks for the clarification, now I get how it would help to
have the same kind of thing for selftests build (even though I am not
clear about the exact list of supported cases aside from the one used in
CI, but that can be sorted out later).

[...]

>> Understood, thanks for the pointers. I see that Vineet came up with a
>> new revision that eventually got merged, moving gcc-bpf as a dedicated
>> job in kernel-build-test.yml instead of kernel-build.yml (and so, a
>> failure on gcc-bpf does not mark kernel build as failed) I guess I can
>> replicate this (also, making sure to add this run_tests toggle, maybe
>> ?). However, I feel like it would not make much sense to have a build
>> and a test part, with artifacts going from the former to the latter, as
>> the build step actually _is_ the test. Also, the only needed artifact to
>> run the build is the kernel source tree (we don't need any vmlinux or
>> .config, at least for now)
>>=20
>> Would it be ok if I try it this way ?
>
> I think if the "bpftool build" test doesn't depend on the kernel build
> at all, it can be implemented as a new workflow independent of
> everything. You don't even need new code in libbpf/ci for that, just a
> new .yaml in kernel-patches/vmtest/.github/workflows/, and maybe a new
> shell script.  And it can probably run on github-provided ubuntu
> runners.  That would be a right way to implement it, given the current
> state of things IMO.

ACK, I'll try to apply all this decoupling from the existing workflows
then.

>>> I'm thinking the whole "kernel build" workflow should be refactored
>>> into either separate selftests build jobs, or some post processing
>>> that looks at what artifacts where built successfully and reports
>>> failures. This will provide a little more friendly UI/UX. You're
>>> welcome to look into that if you're interested. But that's not
>>> directly relevant to the changes you're proposing.
>>=20
>> Trying to rephrase it to make sure I get your point, the goal would be
>> to have green/red checks specifically on selftests builds, rather than a
>> global green/red check on the macro job "build kernel and selftests" ?
>> Or does it go further than that ?
>>=20
>> If I get it correctly, yes I'd be glad to try and help on that, as a
>> separate task.
>
> Ok, let me expand on this. Thinking out loud below.
>
> As you correctly noted, currently we have a kernel build + selftests
> build clumped together in a single job. I don't know if this was
> intentional design when it was set up, but it's what's there.
>
> The advantage of "build many things in one job" compared to "one job -
> one artifact" extreme is in the cost of transition between the jobs on
> the performance side (artifacts upload/download, potentially new
> runner cold start etc.), and in the complexity of the independent jobs
> (you have to set up prereqs every time, for example).
>
> The disadvantage is in the coupling of the dependencies. For example,
> currently if selftests/bpf build fails, veristat jobs don't run,
> because they depend on the combined build job. But they actually *can*
> run if the kernel build succeeded, but selftests build failed.
>
> An argument can be made that if your CI run is red, you're going to
> dig into the logs anyways, so this is all bikeshedding. But I think a
> clear "kernel build failed" or "bpftool build failed" signal saves a
> bit of time for everyone.
>
> An idea I have on how we could have the cake and eat it too - avoid
> the cost while keeping the clear signal - is to keep independent build
> steps in the combined job as allowed to fail, so the job always
> succeeds. And then have a separate check for "this artifact is missing
> - that means the build failed - here is the log", either in a
> dependent job or as a lightweight "check" job.

Thanks, this clarifies a lot the direction to aim for. I now grasp the
expected benefit from this potential rework.

> It's not free though: some cost will remain in the complexity of the
> combined job, and the checks.
>
> Validating this idea requires github .yaml hackery (not a fun activity
> in general) and experimentation. It looks doable to me, but there
> might be problems with it I haven't thought about.

So as stated before, unless someone picks it up before I do so, I can
take a look at this and try to tweak those workflows to reach the
improvements mentioned above, aiming to get clearer signals about what
is failing, _while_ trying to keep complexity and CI execution time
reasonable. I am definitely not an expert in github automation, so that
will possibly lead to a few back and forths and experiments, but that
will be an opportunity to learn :) I also have to state that I am still
expected to make progress on the selftests conversion/cleanup though,
but I can put this item right below in my todo list, as this is pretty
related.

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

