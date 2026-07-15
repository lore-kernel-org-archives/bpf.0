Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6153B27DE;
	Wed, 15 Jul 2026 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133567; cv=none; b=qMnu3cH6uAunZCSbJNA0tDNT9XkHX/d5w+5OP2NsaUo/9UwJjKEhGcA+6S8u5AyWMW1AvD9sj4bEkNTXrIbgnbB++z3hf+hHZJ7BIirSeslg6LF29Mf1LdkSn2M94OOfSbjVpeyfADLoAuns/xEjbycr8oyedAI7oX29zF9afBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133567; c=relaxed/simple;
	bh=tdQ//0E6IUW1LIs9lZY//5/nl3u6ECjvPDpY+GdSHW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHEEfpVlJpp0BHh3j8fKauN/G06Rphxj2Q6ehxTeU5/rkTgo4J4lyy39MnK8G/ut3n8gfhG0DePLHXCAiNJyRr4uCBT8E+l4Gvqc0Ra/hawiIVWBL5HiGMzDIiGvh0VXZxjCV1A7f1/viY4R0FZix7pVWfhVgT5BBxcNAnpOlU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NViA7zT1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NViA7zT1"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 357BA12D6;
	Wed, 15 Jul 2026 18:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784133508;
	bh=tdQ//0E6IUW1LIs9lZY//5/nl3u6ECjvPDpY+GdSHW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NViA7zT122DIDCQnyPQekhdzIIBYM0nmhajfLHhpPhQy1zdnQvoPFoNy7a8CExp7z
	 Mkq3n5X/1zzIW3RLoMxc8RXOFAxbzNyE0jSRkDcTj5Ss4R3PxNIt93ywz6riidG/Fe
	 fNUVlqbDbs7JlxRutxM8aw/zKJ3SZXJ9IGPg7AKU=
Date: Wed, 15 Jul 2026 19:39:21 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Derek Barbosa <debarbos@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Steven Rostedt <rostedt@goodmis.org>, users@kernel.org,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	Stephen Finucane <stephenfin@redhat.com>, bpf <bpf@vger.kernel.org>,
	Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: Linking Patchwork with Sashiko?
Message-ID: <20260715163921.GH1778116@killaraus.ideasonboard.com>
References: <akQlPSNfGEllNVhe@debarbos-thinkpadt14gen5.rmtusma.csb>
 <20260710074528.5a6e4457@foz.lan>
 <20260710083845.23c753ca@foz.lan>
 <87wlv2jq4t.fsf@linux.dev>
 <20260713095538.3d5e86f1@foz.lan>
 <20260713094120.GD1127719@killaraus.ideasonboard.com>
 <20260713220427.582b28bf@foz.lan>
 <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>

On Wed, Jul 15, 2026 at 09:28:03AM -0700, Ihor Solodrai wrote:
> On 7/14/26 5:59 PM, Laurent Pinchart wrote:
> > [...]
> > 
> > I expect maintainers who want to act on sashiko reviews to triage and
> > verify them first before bothering authors, yes.
> 
> I can't help but chime in, because I find this opinion triggeringly
> unreasonable.
> 
> As of today, the problem is *not* "thoughtful experts are bombarded
> with low-quality feedback from llms", even though the experts might
> feel like that frequently.
> 
> The problem is that the mailing list is flooded with slop to varying
> degree depending on the subsystem. And review by humans, even with
> powerful AI tools at hand, doesn't scale [1][2].

I certainly agree with you that this is a large problem. I don't think
we have a single problem though, but I can understand people who
consider the problem you're discribing as more urgent to address.

> And the argument "I didn't sign up for AI reviews" is weak. If you've
> sent a patch to the mailing list, and there are maintainer-sanctioned
> bot messages in response, you've already opted-in to receive them.

We're enabling bots on mailing lists that people are already subscribed
to. But I don't think that's a very important argument here.

> Yes, it is annoying. It's annoying in the same way a dozen nits on
> your patch from a human reviewer is annoying.

That I strongly disagree with. A humain reviewer sending a review with
dozens of nits usually doesn't annoy me, and doesn't make me feel
diminished as a human.

> But the contributors
> generally accept this, otherwise their patches don't land.
> 
> Your job as a contributor is to make sure the patch is "good enough"
> to land. Now, with ubiquitous AI tools, "good enough" means *at least*
> that the AI bots don't find real bugs.
> 
> Yes, assessing whether AI report is "real" is work, but it's not
> reasonable to push this work on already overwhelmed maintainers. And
> if AI is wrong, again it's the job of the author to convince the
> maintainers it's wrong.

We disagree on this as well. This would force contributors to constantly
justify their value against a machine that is known to produce a
non-negligible quantity of nonsense. Furthermore, if those generative AI
tools are as good as their supporters claim, the time they free for
maintainers should outweight the need workload to triage the comments.

> I set up automated AI code reviews on BPF list using Chris Mason's
> prompts in the fall last year [3], before sashiko was developed. And
> originally we were very worried about the quality of the reviews.
> 
> Time has showed that we had to be more worried about the average
> quality of incoming patch instead.
> 
> [1] https://lore.kernel.org/bpf/CAADnVQKsM8iOGO3ZL3LgbWigOBBMrGbTYZ_k_Ktz=+cVkvRLXg@mail.gmail.com/
> [2] https://lore.kernel.org/all/20260703-vfs-summer-jam-22b2edbbbc44@brauner/
> [3] https://lore.kernel.org/all/0d6aa077-1222-49a0-9554-dd922122a904@meta.com/
> 
> > I believe we should
> > follow the first two recommendations of the Software Freedom Conservancy
> > on using LLM-backed generative AI systems for FOSS contributions ([1]).
> > 
> > [1] https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendations.html

-- 
Regards,

Laurent Pinchart
