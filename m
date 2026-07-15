Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033A28725B
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132913; cv=none; b=t7zakASECkFmvzN6TF4KFMlyIVLBwK5JvKTRkh367dHOuMWroUOBiNzv+yfoezEImbBjWrsv7vUutq2O5fgKWbIaiYruoTzz3sztduWN0a24gy1laQS0wzUn6s3+4Hr7HPrqGbXCwFOswN4Eklusnguc7bfPZrRwtX0sHc6WGIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132913; c=relaxed/simple;
	bh=kYirwBAuLJl0Z28Is6n9L+vxTIXbJZ4R5UuYSCdJYIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdmNwlclDynYvd+JURLqO/dgC7VE+NdAAe2yEziRb0im02XoQI/VS3gzBYJuaDUIgQuw7ZrqKosD2HE9J5e31NnJVxP6m7K51CeZOfKcUxhQAgEk2RMHWXLPHKyFPVT7y0QztbkfO/lGzYu9jTLvmbjHjW92mIHiOM9bg3yHOTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tg/Ya4zi; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tg/Ya4zi"
Message-ID: <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784132908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTacKQLLuTMd2fXvvh6NzdLLAV7FfwsgEUfmU/L/fQ4=;
	b=Tg/Ya4zibKMsAo6gAfHKoHnMqwtMr/iZNfoOZ9659m9MsNP6XiSuJALAACCVVG9ubBF1se
	Y5hTScoI7Pdbch4Z6RPr+vyOE95E6tiuq7SvqG96p8BUaQOK+FGtj4/GMQJ3nUcMMBO+9Q
	S0USLjcy+2KfRuwVuUzUgVFRKS1bwkk=
Date: Wed, 15 Jul 2026 09:28:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Linking Patchwork with Sashiko?
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Derek Barbosa <debarbos@redhat.com>, Matthieu Baerts <matttbe@kernel.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Steven Rostedt <rostedt@goodmis.org>,
 users@kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>,
 Stephen Finucane <stephenfin@redhat.com>, bpf <bpf@vger.kernel.org>,
 Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20260604085201.177ad537@foz.lan>
 <20260607195656.02788791@foz.lan>
 <akQlPSNfGEllNVhe@debarbos-thinkpadt14gen5.rmtusma.csb>
 <20260710074528.5a6e4457@foz.lan> <20260710083845.23c753ca@foz.lan>
 <87wlv2jq4t.fsf@linux.dev> <20260713095538.3d5e86f1@foz.lan>
 <20260713094120.GD1127719@killaraus.ideasonboard.com>
 <20260713220427.582b28bf@foz.lan> <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260715005909.GF1656185@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/14/26 5:59 PM, Laurent Pinchart wrote:
> [...]
> 
> I expect maintainers who want to act on sashiko reviews to triage and
> verify them first before bothering authors, yes.

I can't help but chime in, because I find this opinion triggeringly
unreasonable.

As of today, the problem is *not* "thoughtful experts are bombarded
with low-quality feedback from llms", even though the experts might
feel like that frequently.

The problem is that the mailing list is flooded with slop to varying
degree depending on the subsystem. And review by humans, even with
powerful AI tools at hand, doesn't scale [1][2].

And the argument "I didn't sign up for AI reviews" is weak. If you've
sent a patch to the mailing list, and there are maintainer-sanctioned
bot messages in response, you've already opted-in to receive them.

Yes, it is annoying. It's annoying in the same way a dozen nits on
your patch from a human reviewer is annoying. But the contributors
generally accept this, otherwise their patches don't land.

Your job as a contributor is to make sure the patch is "good enough"
to land. Now, with ubiquitous AI tools, "good enough" means *at least*
that the AI bots don't find real bugs.

Yes, assessing whether AI report is "real" is work, but it's not
reasonable to push this work on already overwhelmed maintainers. And
if AI is wrong, again it's the job of the author to convince the
maintainers it's wrong.

I set up automated AI code reviews on BPF list using Chris Mason's
prompts in the fall last year [3], before sashiko was developed. And
originally we were very worried about the quality of the reviews.

Time has showed that we had to be more worried about the average
quality of incoming patch instead.

[1] https://lore.kernel.org/bpf/CAADnVQKsM8iOGO3ZL3LgbWigOBBMrGbTYZ_k_Ktz=+cVkvRLXg@mail.gmail.com/
[2] https://lore.kernel.org/all/20260703-vfs-summer-jam-22b2edbbbc44@brauner/
[3] https://lore.kernel.org/all/0d6aa077-1222-49a0-9554-dd922122a904@meta.com/

> I believe we should
> follow the first two recommendations of the Software Freedom Conservancy
> on using LLM-backed generative AI systems for FOSS contributions ([1]).
> 
> [1] https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendations.html
> 

