Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A442982B
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236716; cv=none; b=ox1QjY3txwhwsQQXtKE+lQoGMOR+XEm7NOF+1ExkAGPjaEaHMkToBGdpMWkIM2cs8mv8fi3n/uFEka11Z7usiBC3yPMH6mBn9AoAbs7EMn2/+HcfcQ87UQdIiVHg+PUvMObhVs02ocMFD7S0BQn8g+pdDGggSqpcShgUFbyf+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236716; c=relaxed/simple;
	bh=6L75ZvRtYQ5DK6HozL8NxAaOjemGmVEHjnEaykm4mVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNlkErznXwK/OyMwS/dW5aJj/tVykqrcWZfMw+oy7z150xYazwPqRlfNeUYQZwhDOicnRjuKtCeaM96/iooptqv0t+lYV66Z87wBUSzhOEgMUgLSodNiAT+L120Grf7fw0oLwu451YyZg15aBER4C4OpW7bm2Dqf/8nl5Hjt7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObNukigN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObNukigN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E587AC4CEF7;
	Wed,  4 Feb 2026 20:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770236716;
	bh=6L75ZvRtYQ5DK6HozL8NxAaOjemGmVEHjnEaykm4mVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObNukigN0JA1Ql4BHO3NESX5b9RRtZF3u+wvawDbyfeqiqwU2DWr1kG20jjXJOhRz
	 U78+h1Anf1mEoU+dEhrQy/cmqjvjmmDZFc+NvXkT+O8FeKPchg/5k5NOUarxT14yw8
	 vpAmqLIOXU2XUjVFO2ABJtQukH7fSrt6sU07H3RD8MVCKBkmiG7xqWy2KRMHkZpIzQ
	 fhYy7NqRTdiMnlwJC6vDSS5E+fFyDpgJw8uxpa0UklYy5KbnbcMJrRPd71QDvJnEip
	 y2+8EeQSTa5xDgKFovH8sn518ZaoH2x4S1rCC90yzYcb9+FjCs79wzcWoE+FRdRkoA
	 27G9jLVs1058g==
Date: Wed, 4 Feb 2026 10:25:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Josh Don <joshdon@google.com>
Cc: Rohan Kakulawaram <rohanka@google.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [RFC PATCH bpf-next] bpf: ephemeral cgroup BPF control programs
Message-ID: <aYOrKpI7vxCUdZVr@slm.duckdns.org>
References: <20260203102058.41030-1-rohanka@google.com>
 <aYJZ62BCwNIC1Q3f@slm.duckdns.org>
 <CABk29NuyzS_XSUQM3yA0a2rqpNXg6xaGP5pVGXJoJa-xaOBdOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NuyzS_XSUQM3yA0a2rqpNXg6xaGP5pVGXJoJa-xaOBdOQ@mail.gmail.com>

Hello, Josh.

On Tue, Feb 03, 2026 at 05:04:09PM -0800, Josh Don wrote:
> > Can you elaborate why this *needs* to be a separate file interface? Note
> > that this doesn't really expand what BPF progs can do with cgroups. The only
> > thing being added is a different and not-particularly-efficient way to
> > communicate with BPF progs.
> 
> Each of those existing communication mechanisms have advantages and
> disadvantages, and my take is that none are really optimal for the use
> case described/implied here.
> 
> For starters, I think it is important to have the interface be
> synchronous. Stat collection and reporting for example makes much more
> sense to do on a read() edge rather than arbitrarily dumping info
> continuously into a map or ring buffer or something.
> 
> For the BPF iterators we already have, you could in theory pin and
> unpin as cgroups are created and destroyed but that feels like a bit
> of a hack; at that point you don't really care about it being an
> iterator program, you're just piggy-backing off the fact that it
> exposes a seqfile interface. Add to that the fact the trickiness of
> keeping everything in sync as the cgroup tree is modified, plus there
> will always be a latency between cgroups getting created and userspace
> going to pin an iterator (especially if the jobs creating the cgroups
> are not the ones caring to pin the program).

Wouldn't pinned BPF_PROG_RUN program fit the bill? It can serve as a generic
entry point with arbitrary input and output data. It can take the cgroup ID
along with other params, do whatever operations necessary and then return
output in whatever format. The users don't have to know much either. It just
needs to know the name of the pinned program and input/output formats and
then do bpf_prog_test_run_opts(). It's not whole lot different from doing an
ioctl call.

> I also find the file based interface incredibly convenient. You don't
> need to have code deal with making BPF upcalls or read() from an
> iterator fd, instead you can use traditional file based APIs. Exposing
> as a file-based interface also easily lets scripts and manual
> observation/manipulation work easily as you can cat/grep/etc just as
> any other file. I have to imagine the motivation for allowing file
> based pinning of iterators shared similar motivations.

AFAICS, this is the only actual benefit, right? Having text files as
interface.

> Typically cgroupfs interfaces are low bandwidth communication
> mechanisms to occasionally set/get resource limits and stats. So, in
> contrast to the APIs you describe, this is also about offering a more
> flexible and convenient solution without needing to worry as much
> about efficiency.
> 
> I also think this pairs pretty nicely with sched_ext as schedulers can
> define custom tuning knobs that will be automatically exposed for
> manipulation on a per-job (cgroup) basis.

Maybe, but, for cgroup level low-freq hinting, being able to read xattrs on
cgroupfs should be enough. Anything high-volume/freq or needing finer
granularity, cgroupfs file interface is far from ideal.

So, I don't know. I'm not dead against it but unless I'm misunderstanding
something the rationale seems pretty weak.

Thanks.

-- 
tejun
