Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C43955C2
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679556; cv=none; b=uSBj9jXLf91PmNV9EChYH3YuX0or812zXmARj8hmCKwhQKUK3cMD99QwRQ5K01F5rgeq1GHeiwe3RStwP/deHR1lEfXxWkVR/Mjd9stxd1ocrxQgMPBFistUcnBmqavBssGC67ZQkLZAs6DJNmoPB1aVFTY+rduxAh1NAG1DGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679556; c=relaxed/simple;
	bh=sCDEb1avU1aD3CbBYvmRE4P68YtLhqktPeNvIuGWuf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MD1tBe6NnLUpCVCgwiByCX4ZoD9Nf8ovfUE8INf2baGbKlXSREnm1i+ZCdnH7PqMRtcE498ESrb1jJhTciGe2yIe7JcqEhVwONsRe0uk83SwcFiVxq7bTyxJXDeIXr6TMtnM/DDP2qRQQHCQSP29Su2gufaUScHP3zrs0v8Pmq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dCtByikG; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dCtByikG"
Message-ID: <a45e6e99-fcb8-4a7b-8012-8c7e88ea7598@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780679550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fo8CAIvSkQ5YQSXF3PSHKRep1uY8aHbN5UsGrEEgs5I=;
	b=dCtByikGv/+S4Y5FuWiFX7lWwnnctUREovpwFT9ossplx/qANYStE2CRm5XJMbfI5GcLZE
	MLK2q1p2v7w3LXH6YYrcekABZq+VkZbmzYdjx6jOWkCxMWMwwQRl1juFedszxR+KK5b3lT
	p/Kow6ls0Wxyw9EdqL0/1VoKOXwOoo0=
Date: Fri, 5 Jun 2026 10:12:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BPF CI for Stable
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>
References: <aiJ2X7ut4lky47aV@u94a>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aiJ2X7ut4lky47aV@u94a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/5/26 12:45 AM, Shung-Hsi Yu wrote:
> Hi,
> 
> Following up on the LSF/MM/BPF 2026 session "BPF in Stable Kernels, an
> Update"[1]. Since the event, 6.1 coverage has also been added[2] (thanks
> to Paul). With a collaborator on my side, it seem like a good time to
> ask:
> 
>   Is it possible to get BPF CI for stable in its own repository under a
>   GitHub organization (e.g. libbpf/stable-bpf-ci)?

Hi Shung-Hsi,

I think a better home for the BPF CI targeting stable kernels is
kernel-patches org [1] for a couple of reasons. First, repos in the
kernel-patches org have access to hardware - generic runners provided
by Meta and s390x runners provided by IBM. Second reason is that this
org hosts source of truth repos for most of BPF CI code, even though a
big chunk of it lives in libbpf/ci.

Let me know if this makes sense, and I'll create a new repository and
grant you write permissions there.

> 
> Currently it lives as a personal repo that is fork of libbpf/libbpf[3].
> As someone (I think it was Andrii) pointed out during the session, the
> vast files currently in my fork are not needed at all. The GitHub Action
> workflow only needs the .github/, plus the supplement files under ci/.
> 
> Technically BPF CI for stable can also simply be merged back to
> libbpf/libbpf

No, that's a bad idea.

>, but that felt less ideal because:
> - kbuilder-debian container image currently doesn't work when testing
>   stable kernels (I haven't look at reason of failure, might not be hard
>   to fix)

Technically, it's not a hard requirement to use the container.
It makes the build jobs a little faster and a little more reliable, but
it was crafted for bpf-next testing, which may not be ideal for stable.
If necessary you could develop a separate "kbuilder-stable" container, but
it's up to you to decide whether it's needed.

> - actions that tests stable kernel will be mixed with actions targeting
>   libbpf itself 
> - BPF CI for stable will have to contain version-specific tweaks (e.g.
>   [4])

This is fine and expected. It is of course great to be able to reuse code,
but practically speaking, I think in this case it may be more work to
keep the common parts compatible with both stable and bpf-next workflows,
than maintaining two diverged CI trees.

The rule of thumb should be this: if you can use a libbpf/ci action, do
it. If there is something very specific to the workflow, keep it in place.
Don't be shy copy-pasting yaml fragments that work for you, it's fine.

> 
> None of the above are fatal flaws that prevent libbf/libbpf to host
> files that run BPF selftests on stable kernel, so I'd say having a
> standalone repository is more of a personal preference.

I agree that a standalone repository is the way to go.

> 
> OTOH we can also try kernel-patches/bpf-like approach and have a
> kernel-patches/stable, providing proper, fully-fledged BPF CI for stable
> that tests incoming patchset to stable (not sure if Daniel was asking
> about this during the session). But I find this to be much more work.

We don't have to do this work right away (or ever).

First let's set up the kernel-patches/stable (or whatever the name) with
the implementation you already have.

We can enhance and improve it when there are cycles and willingness to do
so in the future, 

> The current approach of applying queued patches from stable-queue[5],
> while comes with quite some delay between the moment patch is proposed
> to stable mailing vs the moment said patch gets tested, seem like a
> workable compromise.

This can be automated by the way.
Check out linux-next sync on current BPF CI, it's straightforward [2].
There is a job periodically syncing a branch, and the CI pipeline is
triggered on push.

[1] https://github.com/kernel-patches/
[2] https://github.com/kernel-patches/vmtest/blob/master/.github/workflows/linux-next-sync.yml


> 
> 
> Thanks,
> Shung-Hsi
> 
> 1: https://speakerdeck.com/shunghsiyu/bpf-in-stable-kernels-an-update
> 2: https://github.com/shunghsiyu/libbpf/pull/5
> 3: https://github.com/shunghsiyu/libbpf/
> 4: https://github.com/shunghsiyu/libbpf/tree/master/ci/diffs/6.1
> 5: https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/

