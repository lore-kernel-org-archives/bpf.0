Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05421CC44;
	Thu, 16 Jul 2026 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183035; cv=none; b=nALVgCADyE/26kNdNRLjo1ooSX13gPSIph5dd8A5YVR/DvWH/4isL6S3T800DF8Go04PEsn6PiC9WRmzAJ1641x+5arZ8OoEXVzjyAZcVkOnejQHovjJuxh1+MneDVy2ouSi87czzYvEa3WT9QYhaYcBwfthOuKKttK0pRko2ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183035; c=relaxed/simple;
	bh=lVUi3whRdmsEgUNHPPhKoIfDdnLa+nuFtQcY7RhnlQc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ZJQNXHkxKr5TOSa6kOHvvKxTrF27PyRn3EgozxuQC/OvEDS8LRMuebo+dpNP0b1OnpgX4/Ld7PWHeW108Pd7jliRSzRzqnq2awpXhBbDuXIwt10OA+hhejr7U9oUZfwfCO8vqFaMRvRY1UxWYaHXqioG340U+ZZVeiRhybxptoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qaRv0Vqc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qaRv0Vqc"
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c68:66a6:48e1:9e1:50d5:c75c])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2B95A9D1;
	Thu, 16 Jul 2026 08:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784182975;
	bh=lVUi3whRdmsEgUNHPPhKoIfDdnLa+nuFtQcY7RhnlQc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=qaRv0Vqcnso2uhR+t6f+/4ElLOlzYaSZBBC94TT2hbFEwVU0LoAtZG9SVN2f1pU0w
	 KJ2H4Zdkv/1SmPgyj9+hFsyAVbuJ/irMiGgI/8xKLuvMU0VF6x/wIcGOTOHJExTbx9
	 ynbFQObKDXPQObzNrNGzhL1O56irkrc2jRy8jbrg=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <alfwOgVRgUJYOGtU@mit.edu>
References: <87wlv2jq4t.fsf@linux.dev> <20260713094120.GD1127719@killaraus.ideasonboard.com> <20260713220427.582b28bf@foz.lan> <7ia4mrvtrxjl.fsf@castle.c.googlers.com> <20260715005909.GF1656185@killaraus.ideasonboard.com> <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev> <20260715163921.GH1778116@killaraus.ideasonboard.com> <153db0fa-65ac-49de-9bf5-456c9639954c@linux.dev> <20260715190654.GK1778116@killaraus.ideasonboard.com> <alfwOgVRgUJYOGtU@mit.edu>
Subject: Re: Linking Patchwork with Sashiko?
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Derek Barbosa <debarbos@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, Steven Rostedt <rostedt@goodmis.org>, users@kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Stephen Finucane <stephenfin@redhat.com>, bpf <bpf@vger.kernel.org>, Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Theodore Tso <tytso@mit.edu>
Date: Thu, 16 Jul 2026 11:53:44 +0530
Message-ID: <178418302445.1426769.8816954031983102120@freya>
User-Agent: alot/0.13.dev35+g4a69c46ca

Hi Ted,

Quoting Theodore Tso (2026-07-16 02:43:39)
> On Wed, Jul 15, 2026 at 10:06:54PM -0500, Laurent Pinchart wrote:
> > This came from a consideration on the impact of false positives
> > and other hallucinations on junior developers.
>=20
> You keep claiming that there is an awful lot of false positives and
> other hallucinations.  That's an assertion that needs to be tested to
> make sure that we're not relying on a few pieces of anecdata.  How
> does this compare with false positives and bogus recommendations from
> certain human reviewers?
>=20
> After all, I can think of at *least* one human reviewer whose reviews
> are far worse than Sashiko's in false positives.  That might or might
> not be the same person as the one Mark has said that he has a stock
> e-mail reply telling a junior developer that they should be free to
> ignore reviews from that particular human being.  :-)
>=20

That's actually a point against Sashiko. I can maintain a mental score of=20
different humans, their past review comments and behaviour, and other=20
contextual things like the time of day of their response.

It's really hard to do that with a bot like Sashiko, which can show two=20
extremes (even in the same review):

1. Find insane(ly good) security bugs that other humans missed
2. Hallucinate code that doesn't exist, or give false positives=20
goose-chases [1][2] that make sense if you read the code like prose, but=20
miss key details or context

Which makes me extra cautious and thorough when going through LLM generated=
=20
reviews compared to a human reviewer I trust.

Later in this thread you've equated Sashiko to static-analyzer tools=20
instead of humans (which is a bit convenient).

IMO false positives are possible everywhere, but LLMs are unpredictable in =

a very different way compared to static-analysis tools *especially* because=
=20
they can be quite good at finding some issues and are non-deterministic.

I can understand the appeal of using them to find security bugs or as extra=
=20
"eye balls to make all bugs shallow". And I am not advocating AI as bad or =

to ban it. But I do think usage of LLMs through Sashiko may give us free=20
reviews, but require brand new work of reviewing the reviews. And this new =

work will be a burden on experienced folks, not newcomers, who will simply =

believe the LLM output because it is (or sounds) smarter than them.

[1] https://lore.kernel.org/all/20260520160638.7F2BA1F000E9@smtp.kernel.org/
[2] https://lore.kernel.org/all/20260715174326.0E5B51F00A3A@smtp.kernel.org/

See the pm_rumtime_put() suggestions above. Some people started giving the =

same review comments after possibly seeing Sashiko comments.

But on deeper inspection it turned out to be a false-positive:
lore.kernel.org/all/178080367434.9570.8101421417305606672@freya

My point isn't that static-analysis tools can't make the same mistake, but =

that they're open source and fixable in a way that current architecture of =

LLM models isn't in general, other than giving it an ever-increasing prompt=
=20
and hoping the random-number generator gods bless me when I need them to.

Thanks,
Jai

> Each maintainer can decide how much they trust Shashiko reviews.  At
> least for my subsystem, I haven't seen the hallucionations that you
> are continually citing, certainly not as a common case.  I will note
> that even experienced human reviewers have occasionally flagged an
> issue, only to say, "my bad, you're right, it's fine" after a
> discussion with the patch author.  And that's OK.  When a human being
> makes a false positive criticism, no one responds with "I am feeling
> demeaned as a human being!"  Perhaps we should be giving
> tool-generated reviews (whether it is via checkpatch or Sashiko) with
> a similar level of grace?
>=20
> At least with tool-generated reviews, we can send bug reports asking
> that the tool can be improved.  At least with one particular human
> reviewer that I have in mind, no attempts asking that person to
> improve their reviews hasn't been helpful.
>=20
> Bottom line --- if you are making the claim the Sashiko reviews are
> rife with false positives, all I can say is <<Citation Needed>>.
> =20

PS: There is a separate issue of how LF is advocating closed-weights paid=20
models trained on public data, just because it is free (as in beer) today=20
for *them* because they're a big organization. That demotivates a lot of=20
people (including me) who like working on open source projects because=20
they're open to inspect and tinker with.

Unfortunately if the "my way or the highway" approach is pushed too much,=20
the kernel might end up with a lot of free Gemini tokens but not many=20
enthusiastic humans to use them :-)

I've personally stopped using closed-weights model for anything, but=20
somehow now required to interact with one while working on the biggest open=
=20
source project in the world?? Maybe LF hasn't gotten the memo on how good=20
the open-weights models are these days, so I'll stop my whining here and=20
wait for a few months ;-)

>                                         - Ted
>
