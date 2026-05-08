Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6743CCFA8;
	Fri,  8 May 2026 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256353; cv=none; b=JGVtiVFFcsTCbNTJjtX7dft3ctZDR8YVLYKp3HiA8q1UEJq2P9htqIPeQenqB/Y2B42o9JH6Y8ljOcnLXsUlicN9rhRwNocF/8kiLw/m6S2LiIT7poBhRPLJU1rXFRjwwW2mQKOrRvOZDpZUwOQlvIdvmcSgIS+tBH6BAooGWOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256353; c=relaxed/simple;
	bh=N6wtEE3PduSsyFFmtTroeuF5GQfkGRx/69RZSt8G8FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2fNqTMMStwcH6dkloaBJrn0sTt2VEkbYW8k77xhlgltPgzhWOD8zeP3NmVmQsR9Iq17sRkODdcDlvp4rP2FW6ks36kKm25qaFpka0xAW15uS2odbslcqfaVz4csCAsoR0R8ncwL6bhMfVPiO47HGXzUONMxDMEa1cczzvrBX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3/pKqOi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3/pKqOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC14C2BCB0;
	Fri,  8 May 2026 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778256353;
	bh=N6wtEE3PduSsyFFmtTroeuF5GQfkGRx/69RZSt8G8FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3/pKqOillhmU0om7DrpVyPKG/dmMI24o58/3HQ/JTFQMn9+LrT98y4BtDLo++vh2
	 ghgQXni+HXAPmitwFMLTFVaiBVcH0uTuL6ePmoo3FCh3QhOQeUmfOJeWODnlvz/twm
	 uDrfKf8VsUN93OjHCaxdeeWToshO7be1oCC+OThQCP1elhjn+18/uAmc+QOQzzGNRS
	 9g4o4SsozH1OggXqDb6nuckfaYib/1TJf8vgF2okDqT6GzrO/VuOs782Emfo2sf2AC
	 spGAfVI7JUBhQmWe6J0rVBKnHRZV3ZAepikc8s1qiTTwblJi+5w7uIvvhyln65x+x1
	 hIN+YaU7zPvQw==
Date: Fri, 8 May 2026 17:05:45 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, roman.gushchin@linux.dev, 
	inwardvessel@gmail.com, shakeel.butt@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	surenb@google.com, tz2294@columbia.edu, baohua@kernel.org, lance.yang@linux.dev, 
	dev.jain@arm.com, laoar.shao@gmail.com, gutierrez.asier@huawei-partners.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v2 0/4] mm: introduce mthp_ext via cgroup-bpf to make
 mTHP more transparent
Message-ID: <af4IEwbAAIYUH0z9@lucifer>
References: <20260508150055.680136-1-vernon2gm@gmail.com>
 <af376QFXC36uf7kp@lucifer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af376QFXC36uf7kp@lucifer>

On Fri, May 08, 2026 at 04:15:04PM +0100, Lorenzo Stoakes wrote:
> Thanks for the series, but overall it's got to be no to this until THP and mTHP
> are in more stable shape.
>
> And this is an RFC, you're trying to make really fundamental changes here, it's
> almost... rude to do that out of the blue non-RFC'd (unless you're a maintainer
> perhaps).
>
> Right now the THP code base is a total mess and mTHP support is not even
> properly merged yet (khugepaged support outstanding).
>
> BPF interfaces are permanent, we've tried the 'experimental' thing before, it
> doesn't work and we'll not be able to yank it later.
>
> I've said it before, but we really truly need to get THP into better shape
> before we can tolerate large new changes, let alone an user-exported interface.
>
> So can we defer this until we're in better shape, and then send that as an RFC
> first please?

Yeah on second thoughts, NACK and don't send this series again please.

I was already annoyed you'd send something this invasive and massive without an
RFC, but you've also ignored the feedback we gave to the last THP BPF series
while ostensibly claiming to have taken it into account.

And then... I mean seriously... _shamelessly_ trying to take control away from
THP maintainers and reviewers who work bloody hard for this community by parking
code that changes mTHP behaviour in an entirely distinct and unrelated
MAINTAINERS section...!

There's a biweekly THP cabal meeting which you didn't raise this in, you didn't
bring this up at any conference, you didn't send an RFC.

You've sent it too before we even have mTHP khugepaged support merged... or have
really stabilised on how mTHP is supposed to work overall.

And also I have made it really abundantly clear that I want to see the technical
debt _paid down_ before we add anything else major.

And as if that wasn't enough, AI review is finding endless problems with this
series on top of all that.

This is NOT how to engage with upstream. Again, please don't send any more
revisions of this.

And next time _engage with the community_ before proposing something this big. A
[DISCUSSION] email, or an RFC, or in a meeting or at a conference, or even
off-list or on-list mail, something.

Lorenzo
