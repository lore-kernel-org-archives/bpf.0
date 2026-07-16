Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7B3F44D7
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205169; cv=none; b=oJPYND+P5FwqX3Iz+70L/AFFEde607VpcNmFvDGK+kXOATRFzpRXUfijpyWj+vfO+iNVRJ0W59FTNsHWJrk+OJhmL6iPUw9ATsiU21rDyJumJuypaNNmKqH1jq8BL5EtwVaiCk4nghmL2Xx1R9nRhUEnZKRk6SkV0aJazoLuk4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205169; c=relaxed/simple;
	bh=4CBJ8YnD1s2aE8qPCXY6nOU6cIkgfJQt0Zr2Ep+kCNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTAqmOhuq0o5pzwvYK2O5UScVsiAtUZfXHOILAOaAdQctQ5N0sLwIoNjPeO5uZ5jPR67+rv/xOe0UcWnZfRXI/wQIZoj1oxV42PwvhrKdjYaA+OgpXeqTU02+URLGh2zwYKM87WKChA9LXc3pZxDGDIQ/SdTYn1pYagIRqLQqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=qUCMvoKD; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="qUCMvoKD"
Received: from macsyma.thunk.org ([151.240.45.27])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 66GCWEnd019170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 08:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1784205139; bh=NqxL3+SH2AbvlvVybH4sIY4E98+1L2ywgJjmzyt8SIE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=qUCMvoKD0/7fqDuh/lBDbbI+hF1MijLx/EWHUVcydVFyR0ZsTny51YubjkXZ2yWds
	 d9xGsv79d2SisYSsefz4TMLbJQbeu99vSGpoXWGSkZohwTZqz+2d2rvsnctyr+Qt/z
	 ojXHBdjFFTxNxhugP23c3my58ufsrl/zkwlT5G8Ob7k3Wk9BQMHW+vcWlVcTakh4Yy
	 9x6XWEfX9nGNpBnOtoWJVtfRs2zjr2bE+t0TxEWtVOu6YQ5XMs9CVRh7OsPrtIWr42
	 h9ggvCryV9z+UPilYki8yZF4qTpwASqPNqMuY0mvOS+YYcG+WAb4Ek18Ar8uDxx5fN
	 vU2WGrKD95WHg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 79CA5A4EB5C; Thu, 16 Jul 2026 08:32:14 -0400 (EDT)
Date: Thu, 16 Jul 2026 08:32:14 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Derek Barbosa <debarbos@redhat.com>,
        Matthieu Baerts <matttbe@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Steven Rostedt <rostedt@goodmis.org>,
        users@kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Stephen Finucane <stephenfin@redhat.com>, bpf <bpf@vger.kernel.org>,
        Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: Linking Patchwork with Sashiko?
Message-ID: <aljMl2wAv3mlQHhz@mit.edu>
References: <20260713094120.GD1127719@killaraus.ideasonboard.com>
 <20260713220427.582b28bf@foz.lan>
 <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
 <20260715163921.GH1778116@killaraus.ideasonboard.com>
 <153db0fa-65ac-49de-9bf5-456c9639954c@linux.dev>
 <20260715190654.GK1778116@killaraus.ideasonboard.com>
 <alfwOgVRgUJYOGtU@mit.edu>
 <178418302445.1426769.8816954031983102120@freya>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178418302445.1426769.8816954031983102120@freya>

On Thu, Jul 16, 2026 at 11:53:44AM -0500, Jai Luthra wrote:
> IMO false positives are possible everywhere, but LLMs are unpredictable in 
> a very different way compared to static-analysis tools *especially* because 
> they can be quite good at finding some issues and are non-deterministic.

Syzbot reports (whether it is of a lockdep or WARN spat) are also
non-determinstic.  Even when it claims to have a reproducer, the
reproducer is not neecessarily reliable.  I think the difference is
that we know what to expect with syzbot, and LLM reviews are new.

And as others have recently pointed out, there is a combination of
very deep subtle, real bugs that humans would not or have not
discovered --- and at the same time, hallucinations that aren't real.
So it's been hard to calibrate whether or not a particular report from
Sashiko is valid or not.  But this is nothing new, and I would claim
that it's not necessarily unique to LLM's.

> I can understand the appeal of using them to find security bugs or as extra 
> "eye balls to make all bugs shallow". And I am not advocating AI as bad or 
> to ban it. But I do think usage of LLMs through Sashiko may give us free 
> reviews, but require brand new work of reviewing the reviews. And this new 
> work will be a burden on experienced folks, not newcomers, who will simply 
> believe the LLM output because it is (or sounds) smarter than them.

Syzbot and oss-fuzz has been an extra burden on us as well.  I suspect
how much each tool impacts each subsystem varies, but I've had *way*
more syzbot false positives (e.g., reports that don't conform to our
threat models, such as reproducers using root privileges to modify the
loop device out from under a file system being reported as a "security
bug") than with Sashiko.  But it seems pretty clear that each
subsystem's experience has had different experiences with differnt
tools.

> My point isn't that static-analysis tools can't make the same mistake, but 
> that they're open source and fixable in a way that current architecture of 
> LLM models isn't in general, other than giving it an ever-increasing prompt 
> and hoping the random-number generator gods bless me when I need them to.

Sashiko is open source as well, and there are a number of ways of
fixing this, including adding annotations to the source code, etc.

Sure, figuring out prompts is tricky, but I'd argue so is making
changes to Clang for its context analysis.  Fortunately, there are
people who are smarter than me in terms of their Clang-fu who have
been improving Clang.  Similarly, Roman and his team are working on
improving Sashiko.  I don't think anyone has said that kernel
developers are responsible for changing the prompts (or changing
syzbot, Coverity, etc.)

Cheers,

						- Ted
