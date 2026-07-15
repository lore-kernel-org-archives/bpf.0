Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD61443E2C
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140804; cv=none; b=b/qEBVa2IVatHPP8BhgvbJX+nb0vckInd/3nFO1me4xr7r4cybOpNeS8q7fa3bWfkYlMiLKNdcoK+bf0nztiE5cGo6CRpWb3Lv+8Fq0D71hQh9FO6g1dM592ErhuHCwRr7UE+O0YeKRKBATWc9Ur2Ib8KOJDsYF+3PuYiILoT8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140804; c=relaxed/simple;
	bh=qCMDyr6l9nngciGqwtqSZ2s10JheS05uLQm+TKEICzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=se6yMdPLsB9rHOa+52/kXC5xwDbM+oB29kStupUi3mzwknzDjcCNg/HMM0EL9p6qYp3hKxEs7ci3KY/BX8KSG1ainniDMbzekJoGqh+2KX9zmPBA9d2FeeILaDHQJjmpYTS2HvizDBq2fncTZTmWgalQYdwE1ttG+2SLt4gaqkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VkIQ+vHk; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VkIQ+vHk"
Message-ID: <6a0f487f-540b-4d47-be4c-db6a0799d2d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784140789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlTfEd9+07VsxQpFxrAmQ/fuYJtyDucO9jtZIOc6jN0=;
	b=VkIQ+vHkmeS74NvtPILVOS0jwRE6jXvgdljth2+KA0P7w7cEsY9J3pjXuFWDLVzqFeOVu+
	8QcPTNMHYWsnvohWjNThskWLVX4DgsC/n9prpeeigGe7Cl4pH+FWlx2X9CIsmPcL9A3h7t
	KxQU1dgahbOICgwusnQtSdq7bZpkKrk=
Date: Wed, 15 Jul 2026 11:39:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Linking Patchwork with Sashiko?
To: Mark Brown <broonie@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Derek Barbosa <debarbos@redhat.com>, Matthieu Baerts <matttbe@kernel.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Steven Rostedt <rostedt@goodmis.org>,
 users@kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>,
 Stephen Finucane <stephenfin@redhat.com>, bpf <bpf@vger.kernel.org>,
 Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20260710083845.23c753ca@foz.lan> <87wlv2jq4t.fsf@linux.dev>
 <20260713095538.3d5e86f1@foz.lan>
 <20260713094120.GD1127719@killaraus.ideasonboard.com>
 <20260713220427.582b28bf@foz.lan> <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
 <20260715163921.GH1778116@killaraus.ideasonboard.com>
 <153db0fa-65ac-49de-9bf5-456c9639954c@linux.dev>
 <f690c44b-bb03-4085-a9f1-0321a3f33e30@sirena.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <f690c44b-bb03-4085-a9f1-0321a3f33e30@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/15/26 10:35 AM, Mark Brown wrote:
> On Wed, Jul 15, 2026 at 10:12:03AM -0700, Ihor Solodrai wrote:
>> On 7/15/26 9:39 AM, Laurent Pinchart wrote:
>>> On Wed, Jul 15, 2026 at 09:28:03AM -0700, Ihor Solodrai wrote:
> 
>>>> Yes, assessing whether AI report is "real" is work, but it's not
>>>> reasonable to push this work on already overwhelmed maintainers. And
>>>> if AI is wrong, again it's the job of the author to convince the
>>>> maintainers it's wrong.
> 
>>> We disagree on this as well. This would force contributors to constantly
>>> justify their value against a machine that is known to produce a
>>> non-negligible quantity of nonsense.
> 
>> I know what you mean and I can relate. Going through walls of
>> AI-generated paragraphs is not fun, to put it lightly.
> 
>> However it seems that you are suggesting to simply delegate this work
>> to maintainers, and I very much disagree with that approach (even
>> though I'm not a maintainer myself).
> 
> This is something that already happens with human written reviews,
> indeed I have a canned reply for one particular reviewer telling
> submitters it's OK to ignore them.  It goes in both directions - it can
> be ignoring some issues or postponing them for later, or it can be
> making sure that there's input from particular people.

My objection is to a suggested expectation for every review to be
triaged by maintainers/reviewers *before* it's sent or the author
engages with it.

I think the author should be the first one to engage, it's a feedback
on their patch after all. And of course reviewers/maintainers are free
to jump in whenever they can and feel it's necessary, and they do. Opt-in.

> 
>> I think it makes much more sense for the author of the patch to do the
>> triage, as they have the best context of the work, and they are
>> usually the most invested in their patch being merged in.
> 
> It's not clear cut - untrustworthy tooling often causes problems, I'm
> fairly sure I'm seeing issues that are the result of submitters getting
> mislead by LLM reviews in a similar manner to some compiler warnings.

Yes, this is a valid point. I'm not arguing automated AI feedback is
always good. This is why the triage is needed in the first place.

I think one small thing that may help with this is teaching
contributors to not iterate on the revisions too quickly based solely
on AI feedback. And also try to iterate with AI reviews off-list first.

But that's marginal. Fundamentally, a human has to read AI feedback on
the patch in the end. I don't see a way around it, barring the singularity™.

