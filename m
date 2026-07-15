Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0835E949
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150045; cv=none; b=B+vPj2Prf9JUrPHBlAIAGZIyhYWBEb6VNf0ABhdzZ4oxLTVecD/khWsOgUYYbD3M+J1hqZTQtHVK9S/gR70nctYJ4VgwlTKVQd+o5FBP3pTmbCcH5lz9CHs0DXQRhbEahxkUiZLsDiBJHqSXB4YW9DoIC1gxu4/dyUa+UYaXKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150045; c=relaxed/simple;
	bh=JjL5R3PM21jYjL3dhKTuqLG5KDGeSP9kpjzJIYM4Xk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/7s/jh9KQ0sG1EpENxeihVwHb8RGcY1eTEBQfdnLOZo6GhVsmvI0dXAra2zllNADq39eFPOzn6zHSeAJFCSFhq8DBS0UvJBUSzUOYTRA/33/uCCiWUTsEa3AtNuudJAWAG+IUcJ6L+OB5AIc9i5ep/usUXQX4o13YIhB4bdvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TIDL9Mev; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TIDL9Mev"
Received: from macsyma.thunk.org ([151.240.45.27])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 66FLDdNs008034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 17:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1784150024; bh=uYq+byWWyif9wmZSPGAPnACZIKEOE0Zwz0myKhUMrS4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TIDL9Mevy2mpVgOgGEYrJIKp9tZPKCNEuamo1/3zYBVLFwH4cbTFcyzeV7cS6W9la
	 Ek5zts/zRfs1E2X0dn5P3YKEvNuXvJIj6fGVHzm+gWDWnC6ACmzIDOo5AqGHFMR64M
	 glfatvkEt98MX0SpNS8HO99Bob6cXxG2aitIKRfU/vMfnnr0jjjjeO801GOXSxI1v2
	 ULy3nj7bD93RdEDNVXn2O84obn5GSZbeS8c06Fz+3fJOpLS1UFrLV5toO2DVNXK8ct
	 CLzZLkvR4HHqqJo5Einp8Vsy5AoJw2eGUppKJomeDgCP4jLPcrqdlnHhvR84wBdB2H
	 WkBklTDyM3a1A==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 80A5DA321C5; Wed, 15 Jul 2026 17:13:39 -0400 (EDT)
Date: Wed, 15 Jul 2026 17:13:39 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
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
Message-ID: <alfwOgVRgUJYOGtU@mit.edu>
References: <87wlv2jq4t.fsf@linux.dev>
 <20260713095538.3d5e86f1@foz.lan>
 <20260713094120.GD1127719@killaraus.ideasonboard.com>
 <20260713220427.582b28bf@foz.lan>
 <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
 <20260715163921.GH1778116@killaraus.ideasonboard.com>
 <153db0fa-65ac-49de-9bf5-456c9639954c@linux.dev>
 <20260715190654.GK1778116@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715190654.GK1778116@killaraus.ideasonboard.com>

On Wed, Jul 15, 2026 at 10:06:54PM -0500, Laurent Pinchart wrote:
> This came from a consideration on the impact of false positives
> and other hallucinations on junior developers.

You keep claiming that there is an awful lot of false positives and
other hallucinations.  That's an assertion that needs to be tested to
make sure that we're not relying on a few pieces of anecdata.  How
does this compare with false positives and bogus recommendations from
certain human reviewers?

After all, I can think of at *least* one human reviewer whose reviews
are far worse than Sashiko's in false positives.  That might or might
not be the same person as the one Mark has said that he has a stock
e-mail reply telling a junior developer that they should be free to
ignore reviews from that particular human being.  :-)

Each maintainer can decide how much they trust Shashiko reviews.  At
least for my subsystem, I haven't seen the hallucionations that you
are continually citing, certainly not as a common case.  I will note
that even experienced human reviewers have occasionally flagged an
issue, only to say, "my bad, you're right, it's fine" after a
discussion with the patch author.  And that's OK.  When a human being
makes a false positive criticism, no one responds with "I am feeling
demeaned as a human being!"  Perhaps we should be giving
tool-generated reviews (whether it is via checkpatch or Sashiko) with
a similar level of grace?

At least with tool-generated reviews, we can send bug reports asking
that the tool can be improved.  At least with one particular human
reviewer that I have in mind, no attempts asking that person to
improve their reviews hasn't been helpful.

Bottom line --- if you are making the claim the Sashiko reviews are
rife with false positives, all I can say is <<Citation Needed>>.
 
					- Ted
