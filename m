Received: from mta1.migadu.com (out-237.mta1.migadu.com [95.215.58.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B741DDA18
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172376; cv=none; b=LYROss2/Z3BMUrX8em9J17ceO0dPs5q1AFXI9ybqR4o9Enm1N/nPz/evQF5cS5TkDa8qYm8SFicIHz0wz1JdMnNmn6KPLsbeJCimbyBksizFcbPS1yr4anG7Juzm5RhfyofnTqMC+BMy8KNDmn9HAENXlBgF0hueDeVQ5c/imyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172376; c=relaxed/simple;
	bh=bXRksxrkgvibjhQcIyFFPkXN6fqu+nQtRAbqYQbOTo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJARxdR5eYv9OnAkxy7FiPAM2VCUu2jcgoucIo5gGL5kAVlSTpD12BMBAJqk4eXKJJhSD+RURlB29cnWWaNkDotcnZ5hlaz869BbaTBm9iLbziZl9d4DOnCAtL8cYLH2RVCqlleTUVZgzw462OJtdge6UKHWIjRZMeMgGg+pT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AFfbeJ/P; arc=none smtp.client-ip=95.215.58.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AFfbeJ/P"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bXRksxrkgvibjhQcIyFFPkXN6fqu+nQtRAbqYQbOTo0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787172369; v=1; x=1787777169;
 b=AFfbeJ/Pq5n1GZHo4YcoIyNX+ZP/BDfrxMZopycoPEEYij2dYu6grfqxPpzvoFtE5DJKxR88
 8WfZbWh2yzkg87bX7+rv4/92tQ28z32xwQH+xyCyk3ZVa7v0W2OZwGy2crpVuU1HAAOq0h/2YEo
 4hHo1MvxOYTtTNgo0tc3hCtA=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:125c:1:c798:6665:a2e1:1482] (2620:10d:c090:500::5:942a)
	by smtp.migadu.com with ESMTPS id 3316c15ce6d2af14;
	Wed, 19 Aug 2026 20:46:08 +0000
X-Mizu-Trace-ID: 3316c15ce6d2af14
X-Migadu-Flow: FLOW_OUT
Message-ID: <16d6ca03-c8a4-4370-a8d2-c97a99d68bfc@linux.dev>
Date: Wed, 19 Aug 2026 13:46:04 -0700
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
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DKT6QBHWC8YM.4D90SOC807CW@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/19/26 12:59 PM, Alexis LothorÃ© wrote:
> Hi,
> as part of the cleanup/automation effort in the BPF selfests directory,
> I am now taking a look at test_bpftool_build.sh, which ensures that the
> different supported ways of building bpftool work correctly. As this
> script does not really exercize anything at runtime but rather at build
> time, I'd like to propose to introduce a dedicated step in the CI
> automation that already builds and run selftests. I have opened two PRs
> in kernel-patches vmtest ([0]) and libbpf/ci ([1]), hoping I am not
> confusing which code should go where between the different repositories
> kept in sync with each other. I have also opened a dummy PR on
> kernel-patches/bpf ([2], not to be merged) that shows how this test
> would look like in CI.
> 
> This really is a RFC, as not all tests from test_bpftool_build.sh are
> being executed: I suspect those based on .config to be currently broken,
> but that can be handled as a second step, depending on the chosen
> direction.
> 
> Any comment welcome !

Hi Alexis, thank you for working on this.

I am a little confused about what are we trying to test here and
why. Maybe you could explain.

Some variants of bpftool build are CI-exercised regularly:
  * selftests/bpf directly depend on bpftool, it's built and is used
    as part of the main "test_progs*" suite
  * bpftool has a standalone github mirror with it's own CI pipeline:
    https://github.com/libbpf/bpftool

Looking at test_bpftool_build.sh (written 6y ago btw), it seems to be
more of a Makefile infra test than bpftool test specifically.

Given how complicated some in-tree tools/selftests/ Makefiles are [1],
running infra tests like this would be nice. But then maybe we should
develop them beyond test_bpftool_build.sh?

I briefly skimmed over the CI PRs you've submitted, and one thing I
would say is that we don't want a "bpftool build" test to block the
kernel build when it fails. It either needs to be a separate job, or a
step that is allowed to fail.

Vineet recently did a similar thing, where the gcc-bpf selftests build
was interleaved with the kernel build and I nacked it with the same
justification [2].

I'm thinking the whole "kernel build" workflow should be refactored
into either separate selftests build jobs, or some post processing
that looks at what artifacts where built successfully and reports
failures. This will provide a little more friendly UI/UX. You're
welcome to look into that if you're interested. But that's not
directly relevant to the changes you're proposing.

[1] https://lore.kernel.org/bpf/20260804170156.1709916-1-nickolay.lysenko@gmail.com/
[2] https://github.com/kernel-patches/vmtest/pull/502#discussion_r3724931742


> 
> Alexis
> 
> [0] https://github.com/kernel-patches/vmtest/pull/517
> [1] https://github.com/libbpf/ci/pull/236
> [2] https://github.com/kernel-patches/bpf/pull/13368
> 

