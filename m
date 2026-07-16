Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27626E70E;
	Thu, 16 Jul 2026 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188553; cv=none; b=btp5ThP9CeJVLrc5RRnX91uApqbeTmcNrvlNpwqvgkdvmM2vSunnAKZaeAcaZiMkEaQhtgqS1FA07sY6oNKTfoU2nz2cg90/MUVod5gZgXUDY3KoQ+rchLjYH3HGfZOiv/AuOn8AzpPFwC4Z8nG2EbeFmh1Ny36wHwI5YG1Eth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188553; c=relaxed/simple;
	bh=eKaNFoGTqTDvYqIO6Mptf6n5JgA3ChR+7r9P9xayAdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyFWUyarDRZNrvXJRWaMjiS2ahtdhNwQ4zAkRFmdjXuSBKrWN9bH9T3ZCah5XWJat6cZa+Fhb9XZTg6iOvmfd194bFmQI4+zFt/ehLIgEhrcbCU6I5RnSKvGrEXA43NUqIp7FFEIwemfuy565JpluPTJAhWaYWLsEGHyV0mxE3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kR1Do7AK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kR1Do7AK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB221F000E9;
	Thu, 16 Jul 2026 07:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188551;
	bh=ec3GakrzuOxIMF5BbZJZobzJEBZ8RKWdHBnwK3o9c+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kR1Do7AKckjucgHlz16PsWqd9WNJVg5K+3jZqfvIUotZfPCNRutiFv9oq6qQTgySq
	 LvME9w0C7ydv8RrykaDkgJqvRNmETQJj6WHjHdfDOPpl96ZXKxu5jgR8RmAmG7NMfD
	 kJTtTGP/EMbhPwDXm/VZ1b3vXY+mufEbHlArXjzevb3hMQB/Dj6Ro2XPjRXBytZTHZ
	 mu5Awkc5gEf5efY+AzVzzGcbVj0MJN7u2woqDCjfGSwhr0jFswXNIm6DxDfdnhJGwa
	 TiZpqHDGQc7hFnWURzcvgGky2dyILaurYjrDf8VOUAGTDGJaOfdQIZbPwvn+4wl8cL
	 iGW7+d5KC3yaQ==
Date: Thu, 16 Jul 2026 09:55:45 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Theodore Tso" <tytso@mit.edu>
Cc: Nicolas Dufresne <nicolas@ndufresne.ca>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Derek
 Barbosa <debarbos@redhat.com>, Matthieu Baerts <matttbe@kernel.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Steven Rostedt <rostedt@goodmis.org>, users@kernel.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>, Stephen Finucane
 <stephenfin@redhat.com>, bpf <bpf@vger.kernel.org>, Chris Mason
 <clm@meta.com>, Christian Brauner <brauner@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Subject: Re: Linking Patchwork with Sashiko?
Message-ID: <20260716095545.63f49e85@foz.lan>
In-Reply-To: <alhMB7vGodoewjcz@mit.edu>
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
	<alhMB7vGodoewjcz@mit.edu>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 23:53:55 -0400
"Theodore Tso" <tytso@mit.edu> wrote:

> On Wed, Jul 15, 2026 at 11:00:54PM -0500, Nicolas Dufresne wrote:
> > In V4L2 m2m notably, there is a "job" in the background, which allow
> > to safely (at least this is the theory) chain up work, and
> > synchronize against pending work. But Sashiko (and other AI) seems
> > to not get it and state with confidence and long explanation that
> > the drivers are racy and should do X/Y/Z more on top (and never
> > blames the framework).  
> 
> Is there actually a race which is allowed by the framework?  Or is
> Sashiko's proposed race actually not possible?
> 
> Or is it a case where it actually *is* racy, but it's something we
> really don't care about?  I've seen this happen with KCSAN where
> technically it really *is* a data race, but it's actually not
> important --- so we just have to mark it with the data_race() macro[1].
> 
> [1] https://docs.kernel.org/dev-tools/lkmm/docs/access-marking.html
> 
> This sort of thing can happen any time we introduce a new tool,
> whether it's KCSAN or lockdep.  

Lockdep warnings are particularly tricky and hard to fix. We did
have false-positive lockdep warnings ("hallucinations") in the past
at subsystem level, which took years and a lot of work to find better
ways to fix them.

> It's not necesarily unique to AI
> reviews.  In both AI and non-AI tools, we can have developers who fix
> the problem in the wrong way, or where the fix actually makes things
> worse than the putative "bug".

Very true.

> > This is why I recommended not forwarding the reviews to the linux
> > media list just yet during the summit. Now, the tricky part will be
> > to find time to try and help narrow this down, I never checked the
> > implementation, but I suppose you can add more layers of prompts to
> > force into looking deeper ?  
> 
> Has a bug been filed with the Shashiko folks?  I can imagine any
> number of solutions, including adding comments in the source, or some
> kind of marker much like the data_race() macro to shut up KCSAN
> warnings, or __attribute__((unused)) to shut up gcc or Clang warnings.
> Yet another solution might be to add some kind of a AGENTS.md file in
> the explains why a particular construct is safe.  Personally, I
> consider it to be the less desirable solution, since having something
> inline in the sources is likely to get out of sync with future code
> changes, and having the annotation in the sources will hopefully be
> useful to humans, not just AI bots.
> 
> But the exact solution is going to be very specific exact warning and
> why the AI bot thinks there is a problem when it really isn't.

Agreed.

Just like any tool, LLM can produce very wrong or very good results
depending on how one uses it. I'm pretty much convinced that media
needs a custom set of prompts to avoid it to report false positives
and to make it point things that are more relevant to us.

> 
>     	       	      	       	 	 - Ted
> 
> P.S.  There was a recent thread[1] where using Clang's context
> analysis resulted in a false positive, and I think it's instructive to
> see how it was handled compared to false positives from Sashiko.  We
> had a discussion, and the result was two pull requests to LLVM to
> avoid the false positive.  There was no complaints about how the false
> positive somehow was demeaning to our humanity, or that we should be
> accomodate those people who want to ban the use of static analyzers.
> There is something about AI that seems to trigger a different sort of
> energy, for better or for worse.
> 
> [1] https://lore.kernel.org/r/20260712165610.366474-2-timday@thelustrecollective.com
> 



Thanks,
Mauro
