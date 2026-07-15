Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4195544604A;
	Wed, 15 Jul 2026 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142426; cv=none; b=QnAH5q/e8cJ4eiU4JO/IUV5xzQPX+aUwNgy6z0G5pXbshIYkDormJxNxb44xiy7HrnGU/i2hI/7nFcXBJ65VMcdOQY7dtMO1aGwY4q5WKjk65aAnkW7LuN0q/QpsSgES4ZrBdnpjgJ4fUUT+WBr4IvngLrq5IF4U4+nL2N6IHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142426; c=relaxed/simple;
	bh=/Nj7Dd3qpxPEFHftN9BYQUKRnbUY4QzNW4WGhPouGi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIMaaCGIiTMFN4iDN0hFetrXC728X9Je9VpqCSNQqllts8Bpje3HDFI4ZBYqlIvvE5WaIPT1vEC3n74E4qSK2wvShTqVsdyrC9tkT2r4kYhvHBQqnM5rfrLmQlj8nB4+LvfNE7b2hNauPUJpXXGIqjVQetw0DOhal8eQ4rpFGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=weXpNVPG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="weXpNVPG"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 287A6104C;
	Wed, 15 Jul 2026 21:06:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784142361;
	bh=/Nj7Dd3qpxPEFHftN9BYQUKRnbUY4QzNW4WGhPouGi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=weXpNVPGNdljTAof2hjl45qg9MNqJ+ebY1YJQjhPe4DX/fff3gRjVe1g26kB6+Iea
	 a3lSF55/siMGfPjNXjG0tua/7zjto1Cu9E2dhVkwep2OLBsRVsIVx41/KsF7dXRoZg
	 XRA8xjN91oJzsJ5zbpY+fEKEFYFUzDL4jV1nq0ZY=
Date: Wed, 15 Jul 2026 22:06:54 +0300
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
Message-ID: <20260715190654.GK1778116@killaraus.ideasonboard.com>
References: <20260710083845.23c753ca@foz.lan>
 <87wlv2jq4t.fsf@linux.dev>
 <20260713095538.3d5e86f1@foz.lan>
 <20260713094120.GD1127719@killaraus.ideasonboard.com>
 <20260713220427.582b28bf@foz.lan>
 <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
 <20260715163921.GH1778116@killaraus.ideasonboard.com>
 <153db0fa-65ac-49de-9bf5-456c9639954c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <153db0fa-65ac-49de-9bf5-456c9639954c@linux.dev>

On Wed, Jul 15, 2026 at 10:12:03AM -0700, Ihor Solodrai wrote:
> On 7/15/26 9:39 AM, Laurent Pinchart wrote:
> > On Wed, Jul 15, 2026 at 09:28:03AM -0700, Ihor Solodrai wrote:
> >> On 7/14/26 5:59 PM, Laurent Pinchart wrote:
> >>> [...]
> >>
> >> Yes, assessing whether AI report is "real" is work, but it's not
> >> reasonable to push this work on already overwhelmed maintainers. And
> >> if AI is wrong, again it's the job of the author to convince the
> >> maintainers it's wrong.
> > 
> > We disagree on this as well. This would force contributors to constantly
> > justify their value against a machine that is known to produce a
> > non-negligible quantity of nonsense.
> 
> I know what you mean and I can relate. Going through walls of
> AI-generated paragraphs is not fun, to put it lightly.
> 
> However it seems that you are suggesting to simply delegate this work
> to maintainers,

For authors who object to generative AI, yes. And most likely for junior
developers too, see below.

> and I very much disagree with that approach (even
> though I'm not a maintainer myself).

I had noticed that :-)

> I hope you're not saying "let's just not use AI", because that ship
> has sailed a while ago.

For the time being I'm not seeing this as a viable option in any way, so
I'm not calling for it.

> And if automated AI reviews are there, someone has to do the
> triage. AI can do the triage itself only to a limited degree. For
> example, there are instructions in review-prompts where AI checks
> whether an issue has already been discussed. But it will never be
> perfect.
> 
> I think it makes much more sense for the author of the patch to do the
> triage, as they have the best context of the work, and they are
> usually the most invested in their patch being merged in.

The discussion regarding enabling sashiko for the linux-media mailing
list started with the question of whether or not authors should be
CC'ed. This came from a consideration on the impact of false positives
and other hallucinations on junior developers. They may have the best
context of the work, but they are also most at risk of not questioning
the validity of the reviews. A one-size-fits-them-all approach may not
be good, which is why I think some sort of opt-in option could address
many concerns. I don't expect immediate and universal enthousiasm
though.

> > Furthermore, if those generative AI
> > tools are as good as their supporters claim, the time they free for
> > maintainers should outweight the need workload to triage the comments.
> 
> Even if the AI tools were ~perfect with respect to code review, I
> think people would still be signing off patches and taking
> responsibility for them.

My comment wasn't about signing off patches. I was questioning whether
the time that sashiko saves for a maintainer is smaller, similar, or
larger than the time it takes to triage the comments. If the tool saves
maintainers from having to review some of the code, or from considering
some classes of problems in their reviews, would triaging the comments
come even close to the time saved ?

> An imaginary perfect AI reviewer that maintainer can trust to land
> code without looking at it would essentially become an AI maintainer.
> Independent of whether you think it's possible, it hasn't happened
> yet, so we have to deal with imperfect AI in the meanwhile.
> 
> > >> I set up automated AI code reviews on BPF list using Chris Mason's
> >> prompts in the fall last year [3], before sashiko was developed. And
> >> originally we were very worried about the quality of the reviews.
> >>
> >> Time has showed that we had to be more worried about the average
> >> quality of incoming patch instead.
> >>
> >> [1] https://lore.kernel.org/bpf/CAADnVQKsM8iOGO3ZL3LgbWigOBBMrGbTYZ_k_Ktz=+cVkvRLXg@mail.gmail.com/
> >> [2] https://lore.kernel.org/all/20260703-vfs-summer-jam-22b2edbbbc44@brauner/
> >> [3] https://lore.kernel.org/all/0d6aa077-1222-49a0-9554-dd922122a904@meta.com/
> >>
> >>> I believe we should
> >>> follow the first two recommendations of the Software Freedom Conservancy
> >>> on using LLM-backed generative AI systems for FOSS contributions ([1]).
> >>>
> >>> [1] https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendations.html

-- 
Regards,

Laurent Pinchart
