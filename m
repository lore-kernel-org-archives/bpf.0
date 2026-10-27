Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793077689;
	b=RzzTiL2xaRZZ4fnPLGGb2d+BjTdHWcXlpAFrbtvqs7OOGqoCypiYBYMnbOWsa4iZTIAg
	 Zvkd0mO16JFSF0I4bN052/yQa77ZykmO5y4i5uUwkTxUSGxCV7kwVcYhP/4q0mYEhjPYA
	 qUwc4VIM+Xd37Tt7hHvP28EXrkvBTuuKLwILfZCUIMNaze7d+qhA8wvbiAp03Et6Ck2QK
	 B+PI8d8bctYfJYlKo1RQlY1YHkxwVQudTxS03uHk+/VRkoRoqWDFl+sQhos2L3QOSZgdU
	 eQpccgiMq48hSg4hNcw0tKYB8rImf11AurnyPzFWfHqlHk58n2qJ/sa12yQTIn0HMGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793077689;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fBiWcffgRvlI52+Wg0fa2gGufwTKUt42iG8au1rmOOQ=;
	b=pE2Fu72vxOfRgQjaZwWOc14JkRbXcMxCqr+iSwTQq6Wm+2Iw+6CgKNhilII6FiXkLD5i
	 N+oG0ar7j5FGY+WTDvqXsiD0BLxVGsznEGWhjozDwveEZaag+2H+bVf80wxj7LVg6XV3+
	 iiJGmJCC7k3EF26pISEUDEwFKc9vwqUNvNYgBoflXikJNGnRZDD7gwheL5UJhwp6UFnMM
	 tzUaDReGSNInUkQTo+r30wx8VR15/7Or8/Wm/90g65ybDo1lyiNCfMfAD2/0I8Vm+9mh8
	 Ow6CP7MpMvzgluNguwjB8j3GS0QytPPu0Lg6EnlKZFpIKLej3ilqjJtN2R1xa++VhkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iYwKO9CN;
	arc=none smtp.remote-ip=91.218.175.89
Received: from mta0.migadu.com (out-89.mta0.migadu.com [91.218.175.89])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5145606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 05:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5145606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iYwKO9CN
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GqnWk2kRqu+9UgZ+qMG/sXslOzm7NeB+4nFuZraWHMg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793077684; v=1; x=1793682484;
 b=iYwKO9CNwul4lKbmvWp6XaHCn6J1C+sC6lcFkNVFfYkVeO9AgN2uO30C7M9JYzV2fgzwQi68
 kQzil3TRwf1fYhMGuKogG1dnfcGY4MK7TcI97VwQAh7rqrvQS8UkjqexO4W44crNGSIbmm9XCUJ
 lxcrerHWNBI6wnBS+7rZ+7Hs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e7cf6db001b1daed;
	Tue, 27 Oct 2026 05:08:04 +0000
X-Mizu-Trace-ID: e7cf6db001b1daed
X-Migadu-Flow: FLOW_OUT
Message-ID: <0e447293-7b70-4ce9-b5e4-ef9522da2de2@linux.dev>
Date: Mon, 26 Oct 2026 22:08:00 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 00/81] bpf: Stack in arena and a verifier that joins
 states
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <fba239f1-febc-4af5-8033-a893f8265191@linux.dev>
 <DMF6AVOBX25C.28Z0NJS6CEB3J@gmail.com>
 <f9aee9b2-0010-44b2-afb4-0be3958b332c@linux.dev>
 <DMF6R1UZUOG2.GSKI6FS2KJ1D@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DMF6R1UZUOG2.GSKI6FS2KJ1D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-26 5:14 p.m., Alexei Starovoitov wrote:
> On Tue Oct 27, 2026 at 12:04 AM UTC, Ihor Solodrai wrote:
>> On 2026-10-26 4:53 p.m., Alexei Starovoitov wrote:
>>> On Mon Oct 26, 2026 at 4:57 PM UTC, Ihor Solodrai wrote:
>>>> On 2026-10-25 7:58 p.m., Alexei Starovoitov wrote:
>>>>> From: Alexei Starovoitov <ast@kernel.org>
>>>>>
>>>>> The goal of this series is to load Rust programs as rustc and LLVM compile
>>>>> them. These programs keep data, heap and address-taken locals in arena.
>>>>> They use trait objects, recursion, unwinding, and loops that have no known
>>>>> bound. The test programs are in https://github.com/4ast/rust-bpf
>>>>>
>>>>> The series has three parts:
>>>>>
>>>>>      patches  1-15   Fixes and a revert. They do not depend on the other
>>>>>                      parts.
>>>>>      patches 16-31   A stack in arena.
>>>>>      patches 32-81   A verifier that joins states.
>>>>
>>>> Hi Alexei,
>>>>
>>>> Just FYI bpf-ci-bot AI review workflow is limited to 50 patches per series.
>>>>
>>>> The limit was set as a guardrail for commit selection logic (to not
>>>> accidentally run review for 10k commits). I chose 50 because usually
>>>> we ask people to break up long series into smaller reviewable pieces,
>>>> and pre-singulariy >10 patches series would already raise questions.
>>>>
>>>> Since the approach to patch review on bpf list has obviously changed
>>>> recently, what would you suggest as a new limit?
>>>
>>> I didn't know that there is such limit. I'm not sure there is a good limit.
>>> Maybe whitelist it by known developers with commits?
>>
>> The purpose of the limit is to guard against unintentional blow up of
>> compute and token cost. It's not infinite.
>> Are there plans for 10k-patch series?
> 
> yes. they already exist.

It doesn't look like you are joking, so let's consider it seriously.

I don't want to come off as too skeptical or critical. I'm just trying
to be rational. These are difficult problems and there is a lot of
uncertainty. So please bear with me.

For the sake of argument, let's imagine a 10k-patch series that fixes
multiple important problems which have to be addressed urgently.

What is the logistics of landing it? Is it going to be posted to the
mailing list?

Is it expected for people to read the patches? (my guess is no, it's
too slow)

Is it expected to get independent AI assessments of every patch?
Sub-sequences? Which ones? Only the whole series?

Can today's SOTA AI "agent" systems even do that - analyse entire
10k-patch series in one go without dropping any balls? Let's not
speculate about future better AI, the series has to land *now*, no
time to wait.

And remember, the same AI with same root prompt can produce different
results, depending on many factors. Should we run k-of-n or something?

How long does it run? Does the infra to execute this exist?
How much does it cost? Who pays the bills?

How many independent AI-driven assessments should be done before the
whole chain of (Linux) command is satisfied with the results and
pulls the trigger? Pardon my unample metaphors.

Who and how assesses the assessments?

Is there enough confidence in today's AI capability, that these 10k
patches are landable in the real world and won't create more new
problems vs what they are fixing?

These questions are just from the top of my head.

There is of course an answer that kinda works: don't worry about most
of the above, trust the AI output (the agents that generated patches
*surely* tested them well) and just git push.

But this is a "leap of faith" approach, and it requires for the vast
majority of participants to be onboard, which doesn't seem to be the
case yet if ever.

If we are not doing the leap of faith, then the questions above need
thoughtful answers, before anything approaching 10k-patch series can
be seriously considered.

If we are, well let's be explicit about it and stop pretending to do
proper patch reviews (whether with AI or not).

> 
>> I'm sure we can come up with a reasonable limit for a "reviewable"
>> series.
> 
> There are not reviewable by current infra.

Correct. Current testing / review infra is not able to support regular
100+ patches, let alone 10k. And that's bpf, which has a pretty good
infra in comparison to other corners of the kernel.

The questions are: how does the new infra look like, who builds it,
and who pays for it? Is it even needed? As of today there are no
answers.

A proof of personhood in text communication hasn't been invented yet,
so I'll do what I can:

Typed-by: Ihor Solodrai <ihor.solodrai@linux.dev>

