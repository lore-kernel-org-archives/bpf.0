Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC931E849
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 03:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784174112; cv=none; b=fs04y4Mkblfm0IwqTVnAvC10tXpBH3xtKrdyiRzV+nMQu/tCFNni/1nUVvSKutfDvqr88jAwyZoQd51xKbpHFvq99N3DkP4JFPr0ifgrfMJHnC6qS3Rd0U89nhUgUyS47diowlFMxAx7BwpSfe9aZ7SF5vW7EoJ3uClysFw49hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784174112; c=relaxed/simple;
	bh=JY4UaD0jeiUSjMFofH8dSI2EJhzBGeat6rBi7QdOfs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoNrGhXOyTDGlpAtU+t5e1IGA7y6HVZhR60xBFn0Uw9NTKMLt371rwFev5kiaJwUOhbfFGLH0p7qs7p9ldVLxRh7CMCQHXat/DMpLFh4AHsXclV6NqdT2frJpHgdxvuZV2LMbd+CXBZRIg13bpPeUbSg3kGuuETJUIoVQq/y26k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Mp3xSQ8Y; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Mp3xSQ8Y"
Received: from macsyma.thunk.org ([151.240.45.27])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 66G3rt2l028829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 23:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1784174043; bh=UUp7Jai+pVhhRkverQOqPGQVEy44/dxVTc2+nLLIONI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Mp3xSQ8YCyCTEvxQh4n3YJL7s+HjUd0ND7yFxB8JaLFBfbzufLUZgOmQXc7tPYBnY
	 LIEh7XozK8O9WPeMtFF99q9GTSJeKVret5NMOMJFgr9hz6KzrkscLkoqeDDu3rNDoN
	 rOckootfuTnLJDTtBMx2m438B4Kc/snaSDMJr46M5PzoHxIkn17azKvsopjkve7BPg
	 p6/3LXyYyS82Jkwob8i6OS3xeUfpQ/j9MuQY1IMylC84rv4wHuoOAk+KkwYIQFCLmJ
	 7FgojTDUazxfzEovdQo3XyHVZoHV6Bbi1MvhdJ1Yre3LdWjLRCktl/j6ZOcnAD9C7G
	 aHfWp2xDV+tYw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 72601A46658; Wed, 15 Jul 2026 23:53:55 -0400 (EDT)
Date: Wed, 15 Jul 2026 23:53:55 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
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
Message-ID: <alhMB7vGodoewjcz@mit.edu>
References: <20260713094120.GD1127719@killaraus.ideasonboard.com>
 <20260713220427.582b28bf@foz.lan>
 <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
 <20260715163921.GH1778116@killaraus.ideasonboard.com>
 <153db0fa-65ac-49de-9bf5-456c9639954c@linux.dev>
 <20260715190654.GK1778116@killaraus.ideasonboard.com>
 <alfwOgVRgUJYOGtU@mit.edu>
 <ef9f77c613a05c5745941587099eeb4f159d5e31.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef9f77c613a05c5745941587099eeb4f159d5e31.camel@ndufresne.ca>

On Wed, Jul 15, 2026 at 11:00:54PM -0500, Nicolas Dufresne wrote:
> In V4L2 m2m notably, there is a "job" in the background, which allow
> to safely (at least this is the theory) chain up work, and
> synchronize against pending work. But Sashiko (and other AI) seems
> to not get it and state with confidence and long explanation that
> the drivers are racy and should do X/Y/Z more on top (and never
> blames the framework).

Is there actually a race which is allowed by the framework?  Or is
Sashiko's proposed race actually not possible?

Or is it a case where it actually *is* racy, but it's something we
really don't care about?  I've seen this happen with KCSAN where
technically it really *is* a data race, but it's actually not
important --- so we just have to mark it with the data_race() macro[1].

[1] https://docs.kernel.org/dev-tools/lkmm/docs/access-marking.html

This sort of thing can happen any time we introduce a new tool,
whether it's KCSAN or lockdep.  It's not necesarily unique to AI
reviews.  In both AI and non-AI tools, we can have developers who fix
the problem in the wrong way, or where the fix actually makes things
worse than the putative "bug".

> This is why I recommended not forwarding the reviews to the linux
> media list just yet during the summit. Now, the tricky part will be
> to find time to try and help narrow this down, I never checked the
> implementation, but I suppose you can add more layers of prompts to
> force into looking deeper ?

Has a bug been filed with the Shashiko folks?  I can imagine any
number of solutions, including adding comments in the source, or some
kind of marker much like the data_race() macro to shut up KCSAN
warnings, or __attribute__((unused)) to shut up gcc or Clang warnings.
Yet another solution might be to add some kind of a AGENTS.md file in
the explains why a particular construct is safe.  Personally, I
consider it to be the less desirable solution, since having something
inline in the sources is likely to get out of sync with future code
changes, and having the annotation in the sources will hopefully be
useful to humans, not just AI bots.

But the exact solution is going to be very specific exact warning and
why the AI bot thinks there is a problem when it really isn't.

    	       	      	       	 	 - Ted

P.S.  There was a recent thread[1] where using Clang's context
analysis resulted in a false positive, and I think it's instructive to
see how it was handled compared to false positives from Sashiko.  We
had a discussion, and the result was two pull requests to LLVM to
avoid the false positive.  There was no complaints about how the false
positive somehow was demeaning to our humanity, or that we should be
accomodate those people who want to ban the use of static analyzers.
There is something about AI that seems to trigger a different sort of
energy, for better or for worse.

[1] https://lore.kernel.org/r/20260712165610.366474-2-timday@thelustrecollective.com

