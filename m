Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EA364022
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303890; cv=none; b=q91un/Up+iuFtdtuuM8skF61zVQnO13qfiE7w0r3FnmPbAEU/kGLtD+xl2sPjwOr2VIohXSB/1QJ1vLe1cSLmTbEpI+wjrUHrByfo/BrhHBE0Q4diH8Ho8z25u7OV8M/1Bj4dqnagSUfnO85JWO8CRt7+LWAlDSQDWZfFRMYUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303890; c=relaxed/simple;
	bh=B3wB4uGk+oU/OMPLbz9dYvLPTH2BAFwuf4iI50kP2Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxQZptlzgIt9TmHcE4JKTP9Ggp0yhk/HoNcEIjwxckEsew/12CBp7nyjhaQZw2Mapnbkf6ZqxcoTWSCD+SBxXHuDMtDr2vZ2ZjKIKxAXWXjyL570gCfTLABqp1m4hI7NTsMNOKsbw+ZBFtNyNAr2JRXjxiGlixf/82CHkESiAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jfN0PMhl; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jfN0PMhl"
Message-ID: <300fc9d4-467d-40e7-b7e7-097bded02b6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781303885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ht2SR2ifm1paDa+PbjOGRAsdp+TWNYoe+kZwHX+ymxw=;
	b=jfN0PMhlEWCKCJJ9csX93MfFgj/3n7IrMjOMq8Ch6Hwe/yXyFsar7wy3IZAS8+KIAN8hdf
	Ilho25xOVx09IQcH3Lx1ocG1zd0nFyeVOM4J7apXXFretTO4RTYyeK4VZH0iWq2nPzlFja
	eMcCiFV6fraSuFjilMJZ5Pk6VzQIspU=
Date: Fri, 12 Jun 2026 15:37:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BPF CI for Stable
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>
References: <aiJ2X7ut4lky47aV@u94a>
 <a45e6e99-fcb8-4a7b-8012-8c7e88ea7598@linux.dev> <aikYGA9To89q3Jd2@u94a>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aikYGA9To89q3Jd2@u94a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/10/26 1:18 AM, Shung-Hsi Yu wrote:
> On Fri, Jun 05, 2026 at 10:12:14AM -0700, Ihor Solodrai wrote:
>> On 6/5/26 12:45 AM, Shung-Hsi Yu wrote:
> [...]
>>>   Is it possible to get BPF CI for stable in its own repository under a
>>>   GitHub organization (e.g. libbpf/stable-bpf-ci)?
>>
>> Hi Shung-Hsi,
>>
>> I think a better home for the BPF CI targeting stable kernels is
>> kernel-patches org [1] for a couple of reasons. First, repos in the
>> kernel-patches org have access to hardware - generic runners provided
>> by Meta and s390x runners provided by IBM. Second reason is that this
>> org hosts source of truth repos for most of BPF CI code, even though a
>> big chunk of it lives in libbpf/ci.
>>
>> Let me know if this makes sense, and I'll create a new repository and
>> grant you write permissions there.
> 
> Make sense, let's have it in kernel-patches org.

Here you go: https://github.com/kernel-patches/linux-stable

I've sent you an invite.

I vibe-code basic sync with upstream. README describes how it works, but
I'll reiterate here for visibility on the list.

The repository has a main branch with only the CI code, test branches
for each tracked stable version, and Linux mainline mirror.

There is a sync job that runs daily. It:
  * syncs torvalds/master
  * then for each listed stable version
    * pulls in the tree
    * applies the patches from the queue repo
    * overlays .github/ and ci/ from the main branch, adding a commit
      * this is similar to what KPD does for bpf-next, but without patchwork and KPD
    * pushes the result to linux-X.Y.y branch

The testing workflow (test.yml), which currently doesn't do anything
interesting, is triggered on push to linux-* branches.

The scripts are straightforward, though a little verbose as is typical
for vibe code. Feel free to edit it as you see fit, or even scrap it.
I wanted to have something working before handing over the repo to you.

This way we have an automated sync + trigger running on schedule right
out of the box. With that, you can add code to test.yml to actually 
build and run tests.

I think you can copy most of the stuff from your libbpf fork, but it'll
have to be tested and debugged of course.

And the best part is you can make use of the hardware available to the
kernel-patches org: beefy bare-metal machines for testing, s390x runners,
codebuild. Oh, and AI reviews of course, if you want to experiment with that.

My understanding is you'll be maintaining the stable part of the CI, but
feel free to reach out if you need help.

Have fun!

> 
> [...]
>>> Technically BPF CI for stable can also simply be merged back to
>>> libbpf/libbpf
>>
>> No, that's a bad idea.
>>
>>> , but that felt less ideal because:
>>> - kbuilder-debian container image currently doesn't work when testing
>>>   stable kernels (I haven't look at reason of failure, might not be hard
>>>   to fix)
>>
>> Technically, it's not a hard requirement to use the container.
>> It makes the build jobs a little faster and a little more reliable, but
>> it was crafted for bpf-next testing, which may not be ideal for stable.
>> If necessary you could develop a separate "kbuilder-stable" container, but
>> it's up to you to decide whether it's needed.
> 
> Understood, I'll stick with Ubuntu 24.04.
> 
>>> - actions that tests stable kernel will be mixed with actions targeting
>>>   libbpf itself 
>>> - BPF CI for stable will have to contain version-specific tweaks (e.g.
>>>   [4])
>>
>> This is fine and expected. It is of course great to be able to reuse code,
>> but practically speaking, I think in this case it may be more work to
>> keep the common parts compatible with both stable and bpf-next workflows,
>> than maintaining two diverged CI trees.
>>
>> The rule of thumb should be this: if you can use a libbpf/ci action, do
>> it. If there is something very specific to the workflow, keep it in place.
>> Don't be shy copy-pasting yaml fragments that work for you, it's fine.
> [...]
>>> OTOH we can also try kernel-patches/bpf-like approach and have a
>>> kernel-patches/stable, providing proper, fully-fledged BPF CI for stable
>>> that tests incoming patchset to stable (not sure if Daniel was asking
>>> about this during the session). But I find this to be much more work.
>>
>> We don't have to do this work right away (or ever).
>>
>> First let's set up the kernel-patches/stable (or whatever the name) with
>> the implementation you already have.
>>
>> We can enhance and improve it when there are cycles and willingness to do
>> so in the future, 
> 
> Sounds good to me, let's go with kernel-patches/stable. Thanks!
> 
>>> The current approach of applying queued patches from stable-queue[5],
>>> while comes with quite some delay between the moment patch is proposed
>>> to stable mailing vs the moment said patch gets tested, seem like a
>>> workable compromise.
>>
>> This can be automated by the way.
>> Check out linux-next sync on current BPF CI, it's straightforward [2].
>> There is a job periodically syncing a branch, and the CI pipeline is
>> triggered on push.
> 
> I'll looking this, thanks for the pointer.
> 
> Shung-Hsi
> 
>> [1] https://github.com/kernel-patches/
>> [2] https://github.com/kernel-patches/vmtest/blob/master/.github/workflows/linux-next-sync.yml
> [...]

