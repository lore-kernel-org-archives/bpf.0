Received: from mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC2E389453
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256798; cv=none; b=e0p9BbG+0WULh7gQES6cMFhQi5antqp38NI42DyD5RrFCdn9yrc8XQwFwQ216Xrl0jah2CR0kuEVCMtww8VwgubJf67Q1VsC5mXX7ElJ/Tqv2IZ4d/Jl0Pfz6V3W56b6saCJkGdzxMxWyh5ZY3gnhMXDx4zSgi0gVGZ/NEoC9aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256798; c=relaxed/simple;
	bh=aZJAG40+h2BiOYQbJw4W3UdYpilnWssXgl9TVeW5Yvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqWZ3HNqy3cJRTsKsonj6wsyJG6r1L5TDUr8+js8gO+a335PrwalZlgo6bXQPhYPai+3anSLOSVONz0f36IG3RhnG+aarXeT+aNzaAN8WoEBUY/QxHsBsf8tqKkoQ5VCwuOfwsXJXyddhXZrzlqjkLM93Iu+GuQIvyG5F6YLN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YzzKBhvp; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YzzKBhvp"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aZJAG40+h2BiOYQbJw4W3UdYpilnWssXgl9TVeW5Yvc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787256792; v=1; x=1787861592;
 b=YzzKBhvpG+KA2F5j4j2Xj9fQH3jTWGdFlW2pL8yWeQbmgcBfWsnSRloE1iPx6GX8JrzmE+rC
 /vZaOGFfi3WEiMZXYzbBMqxGwfr5Xo0fQpWW1tgLmFvspFiwN3zfTctL0cLPPgNmUR/BiFJyt0R
 ssEBJ73ZPD8Q8SSvzVUVuy0o=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2620:10d:c085:21cf::13e0] (2620:10d:c090:400::5:2133)
	by smtp.migadu.com with ESMTPS id c3725198bbf41d07;
	Thu, 20 Aug 2026 20:13:02 +0000
X-Mizu-Trace-ID: c3725198bbf41d07
X-Migadu-Flow: FLOW_OUT
Message-ID: <51eaedf3-78af-40a4-b3d0-f668205808b9@linux.dev>
Date: Thu, 20 Aug 2026 13:12:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] running bpftool build tests in CI
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 bpf <bpf@vger.kernel.org>
Cc: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Vineet Gupta <vineet.gupta@linux.dev>, Emil Tsalapatis
 <emil@etsalapatis.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 Puranjay Mohan <puranjay@kernel.org>,
 Mykola Lysenko <nickolay.lysenko@gmail.com>, kernel-ci@meta.com
References: <DKT6QBHWC8YM.4D90SOC807CW@bootlin.com>
 <16d6ca03-c8a4-4370-a8d2-c97a99d68bfc@linux.dev>
 <DKTMSYRHS7B8.3FQB9UVGWOTX3@bootlin.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DKTMSYRHS7B8.3FQB9UVGWOTX3@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-08-20 1:34 a.m., Alexis Lothoré wrote:
> Hi Ihor,
> thanks for the feedback
> 
> On Wed Aug 19, 2026 at 10:46 PM CEST, Ihor Solodrai wrote:
>> On 8/19/26 12:59 PM, Alexis LothorÃ© wrote:
>>> Hi,
>>> as part of the cleanup/automation effort in the BPF selfests directory,
>>> I am now taking a look at test_bpftool_build.sh, which ensures that the
>>> different supported ways of building bpftool work correctly. As this
>>> script does not really exercize anything at runtime but rather at build
>>> time, I'd like to propose to introduce a dedicated step in the CI
>>> automation that already builds and run selftests. I have opened two PRs
>>> in kernel-patches vmtest ([0]) and libbpf/ci ([1]), hoping I am not
>>> confusing which code should go where between the different repositories
>>> kept in sync with each other. I have also opened a dummy PR on
>>> kernel-patches/bpf ([2], not to be merged) that shows how this test
>>> would look like in CI.
>>>
>>> This really is a RFC, as not all tests from test_bpftool_build.sh are
>>> being executed: I suspect those based on .config to be currently broken,
>>> but that can be handled as a second step, depending on the chosen
>>> direction.
>>>
>>> Any comment welcome !
>>
>> Hi Alexis, thank you for working on this.
>>
>> I am a little confused about what are we trying to test here and
>> why. Maybe you could explain.
> 
> Sure, I may have been a bit light on this. The test_bpftool_build.sh
> located in tools/testing/selftests/bpf focuses on the various ways of
> building bpftool:
> - through kbuild (eg: make tools/bpf)
> - by changing make execution dir (eg: make -C tools/bpf/bpftool)
> - by running the tools/ main makefile (eg: cd tools && make bpf)
> - by running the bpftool main makefile (eg: cd tools/bpf/bpftool &&
>    make)
> 
> This listing is also cross-tested with output path configuration,
> testing both O=<output_dir> and OUTPUT=<output_dir>.

Right. That's what I meant by "it's testing makefile infra".  It's
checking whether any of the listed ways for initiating the build is
broken.

I agree that adding tests of this kind to CI is a good idea. My point
is it's worth expanding the coverage beyond the bpftool.

There was a patchset with fixes for out-of-tree build of selftests
recently, for example [1]. The tests would help to catch this earlier.

[1] 
https://lore.kernel.org/bpf/20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net/

> 
> Will be included in the relevant commits if this RFC goes further in
> this direction.
> 
>> Some variants of bpftool build are CI-exercised regularly:
>>    * selftests/bpf directly depend on bpftool, it's built and is used
>>      as part of the main "test_progs*" suite
>>    * bpftool has a standalone github mirror with it's own CI pipeline:
>>      https://github.com/libbpf/bpftool
>>
>> Looking at test_bpftool_build.sh (written 6y ago btw), it seems to be
>> more of a Makefile infra test than bpftool test specifically.
>>
>> Given how complicated some in-tree tools/selftests/ Makefiles are [1],
>> running infra tests like this would be nice. But then maybe we should
>> develop them beyond test_bpftool_build.sh?
>>
>> I briefly skimmed over the CI PRs you've submitted, and one thing I
>> would say is that we don't want a "bpftool build" test to block the
>> kernel build when it fails. It either needs to be a separate job, or a
>> step that is allowed to fail.
>>
>> Vineet recently did a similar thing, where the gcc-bpf selftests build
>> was interleaved with the kernel build and I nacked it with the same
>> justification [2].
> 
> Understood, thanks for the pointers. I see that Vineet came up with a
> new revision that eventually got merged, moving gcc-bpf as a dedicated
> job in kernel-build-test.yml instead of kernel-build.yml (and so, a
> failure on gcc-bpf does not mark kernel build as failed) I guess I can
> replicate this (also, making sure to add this run_tests toggle, maybe
> ?). However, I feel like it would not make much sense to have a build
> and a test part, with artifacts going from the former to the latter, as
> the build step actually _is_ the test. Also, the only needed artifact to
> run the build is the kernel source tree (we don't need any vmlinux or
> .config, at least for now)
> 
> Would it be ok if I try it this way ?

I think if the "bpftool build" test doesn't depend on the kernel build
at all, it can be implemented as a new workflow independent of
everything. You don't even need new code in libbpf/ci for that, just a
new .yaml in kernel-patches/vmtest/.github/workflows/, and maybe a new
shell script.  And it can probably run on github-provided ubuntu
runners.  That would be a right way to implement it, given the current
state of things IMO.

> 
>> I'm thinking the whole "kernel build" workflow should be refactored
>> into either separate selftests build jobs, or some post processing
>> that looks at what artifacts where built successfully and reports
>> failures. This will provide a little more friendly UI/UX. You're
>> welcome to look into that if you're interested. But that's not
>> directly relevant to the changes you're proposing.
> 
> Trying to rephrase it to make sure I get your point, the goal would be
> to have green/red checks specifically on selftests builds, rather than a
> global green/red check on the macro job "build kernel and selftests" ?
> Or does it go further than that ?
> 
> If I get it correctly, yes I'd be glad to try and help on that, as a
> separate task.

Ok, let me expand on this. Thinking out loud below.

As you correctly noted, currently we have a kernel build + selftests
build clumped together in a single job. I don't know if this was
intentional design when it was set up, but it's what's there.

The advantage of "build many things in one job" compared to "one job -
one artifact" extreme is in the cost of transition between the jobs on
the performance side (artifacts upload/download, potentially new
runner cold start etc.), and in the complexity of the independent jobs
(you have to set up prereqs every time, for example).

The disadvantage is in the coupling of the dependencies. For example,
currently if selftests/bpf build fails, veristat jobs don't run,
because they depend on the combined build job. But they actually *can*
run if the kernel build succeeded, but selftests build failed.

An argument can be made that if your CI run is red, you're going to
dig into the logs anyways, so this is all bikeshedding. But I think a
clear "kernel build failed" or "bpftool build failed" signal saves a
bit of time for everyone.

An idea I have on how we could have the cake and eat it too - avoid
the cost while keeping the clear signal - is to keep independent build
steps in the combined job as allowed to fail, so the job always
succeeds. And then have a separate check for "this artifact is missing
- that means the build failed - here is the log", either in a
dependent job or as a lightweight "check" job.

It's not free though: some cost will remain in the complexity of the
combined job, and the checks.

Validating this idea requires github .yaml hackery (not a fun activity
in general) and experimentation. It looks doable to me, but there
might be problems with it I haven't thought about.

> 
> Alexis
> 
>> [1] https://lore.kernel.org/bpf/20260804170156.1709916-1-nickolay.lysenko@gmail.com/
>> [2] https://github.com/kernel-patches/vmtest/pull/502#discussion_r3724931742
>>
>>
>>>
>>> Alexis
>>>
>>> [0] https://github.com/kernel-patches/vmtest/pull/517
>>> [1] https://github.com/libbpf/ci/pull/236
>>> [2] https://github.com/kernel-patches/bpf/pull/13368
>>>
> 
> 
> 
> 

