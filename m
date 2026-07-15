Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0540422E34;
	Wed, 15 Jul 2026 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142655; cv=none; b=D9TJXKVKkAUyDlbc4p4px2uW+J75t86pA9N1zpLmz/0Fark+gUaQX69bzqeuarGPjBmYNW4r7+xT0ysAPX6W0UEN+Jp9WnR6/a/iSq31zUidsOlCNktMBlPdvyTt5YNR8frlAIOi5ad9nS92F8vFThQkgXIsHdYw36eI2nk8kUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142655; c=relaxed/simple;
	bh=b3nDkrPnfxPi1gVoXMnJB1S7ShDIU/aaMWnscLaoVqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZK7tii0fx3zvVtsWs0otpoQCUXgwv+4lPvHH19hxBqXhoLQGn+6cIzplxNxXgnA/y3C2iykHzEH2kZoJC9tYdgzCA+HAk8FWY7VNA4iD1BjCNABHPOclx7Q8dAqearwXZr7T4VzieB6OiEqC5XlTjE7KqW6Hs9B5CYB8dRrnxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AOSyM8Qi; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AOSyM8Qi"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 275ED104C;
	Wed, 15 Jul 2026 21:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784142592;
	bh=b3nDkrPnfxPi1gVoXMnJB1S7ShDIU/aaMWnscLaoVqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOSyM8Qioa/cE7zSAclANTSYIUqOp9u6Bkx7/GLicg+6XndprCy5xiA6SDBHUjCl2
	 GzAcCBKyI84SFfBCiv+gQ2ynTg6rpmxzeS3Nf4THVgwplWrTHlFkUUIVrN/K0HU40T
	 j/JPKrtbs1yVLGuo9aiuZ741sVmDIrICoKoFBDVo=
Date: Wed, 15 Jul 2026 22:10:46 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Derek Barbosa <debarbos@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>, users@kernel.org,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	Stephen Finucane <stephenfin@redhat.com>, bpf <bpf@vger.kernel.org>,
	Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: Linking Patchwork with Sashiko?
Message-ID: <20260715191046.GL1778116@killaraus.ideasonboard.com>
References: <20260710083845.23c753ca@foz.lan>
 <87wlv2jq4t.fsf@linux.dev>
 <20260713095538.3d5e86f1@foz.lan>
 <20260713094120.GD1127719@killaraus.ideasonboard.com>
 <20260713220427.582b28bf@foz.lan>
 <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
 <20260715163921.GH1778116@killaraus.ideasonboard.com>
 <20260715174153.GB3846105@ziepe.ca>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715174153.GB3846105@ziepe.ca>

On Wed, Jul 15, 2026 at 02:41:53PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 15, 2026 at 07:39:21PM +0300, Laurent Pinchart wrote:
> > > Yes, assessing whether AI report is "real" is work, but it's not
> > > reasonable to push this work on already overwhelmed maintainers. And
> > > if AI is wrong, again it's the job of the author to convince the
> > > maintainers it's wrong.
> > 
> > We disagree on this as well. This would force contributors to constantly
> > justify their value against a machine that is known to produce a
> > non-negligible quantity of nonsense. Furthermore, if those generative AI
> > tools are as good as their supporters claim, the time they free for
> > maintainers should outweight the need workload to triage the comments.
> 
> I feel Sashiko and this whole AI world has created alot more work. It
> is not saving time at all. Now I have to go and read every Sashiko
> report to see if there is something important that normal review
> missed. I have fix all the drive by 'this is already broken' stuff it
> finds. We get way more patches than we did before. Now *everything*
> has to be looked at more skeptically if came from some AI slop. I get
> crazy real security reports that need special hand holding now that we
> never got before.

I'd even go as far as questioning if the additional work is resulting in
less time being spent on changes that would address classes of problems.
There are many areas in the kernel where APIs are hard to use correctly.
Improvements there (and I know there's ongoing work such as Kees' object
allocator functions for instance) may pay off better than spending time
discussing about one-time memory leaks in error paths of probe
functions.

> Even on the submitting side now I have to run patches through all
> kinds of AI tools to have a solid chance to navigate the new guantlet
> upstream.
> 
> We aren't saving time, or creating less work. My hope is we are
> creating better quality, higher security and less bugs.

-- 
Regards,

Laurent Pinchart
