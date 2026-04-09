Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816432475CB;
	Thu,  9 Apr 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740772; cv=none; b=FlzDmfKAps245ORXhLsbF96e8jq2HOZZJ1736bqQJopnt+01Zg8R4h7suRNfr8q0SeQ9VEd4xty4ZFz9zUCDTvCQ+r/zn0hDPNGJlncQoLKLSyUELGiFkJBp4tquGabdF5c8nIdaiE1h6eI0yGbgzMUvIA3GkGpKKF4TDQYh1Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740772; c=relaxed/simple;
	bh=ZXxpoZGq9wmo4unMkWf6o7LxEDGAuAfvyAJDIHhl3Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx5WfNH79HcAxn2lIKxUc6JM9ab73sFuW2v/M5I7Z9WjFnujHnTtGdTXKjrRg7hNmC00T7h8fDQVDdm0h3WEMGE2BZx/KXbJyQUZCyuA0EKUd4C3wY+h8RIwiqNuUQ+eXPskoSE70h4enlITLHLtMmU4E6XMUgHXaESnUabK9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYuokoO1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYuokoO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B948C4CEF7;
	Thu,  9 Apr 2026 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775740772;
	bh=ZXxpoZGq9wmo4unMkWf6o7LxEDGAuAfvyAJDIHhl3Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYuokoO1yHd0UbFpWdW6F9LLZUmwrSsJcUOMGr3zYOit1axOjfh7Hmizyz3EXZWmP
	 T6GpqgBFOrqqCCHigArvuZhPx2KNUF00uPpEf2+MfAuFChU/xtyCxZX9oxmOzymbQi
	 ap4INcYEr7yngBzbm6UpDsSlGcutJNQPDb682pqNGV5l4QGSYyKl7uBsFzbYZew5hm
	 +twrYAa3eRtZMHtPOEmBARPoKRmaECdxdPbEHWVzfRyia+DSlWLAx0bytXgkbrT6Ss
	 bCwt+oAvMX5O30FZfAXOUzFN9s6fAB1XGIhleztlGPtSb+c2Vsiau0IF6ghp9OvfMZ
	 x+tzFBi8ys/rQ==
Date: Thu, 9 Apr 2026 15:19:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] bpf: add bpf_real_inode() kfunc
Message-ID: <20260409-vorsichtig-umstand-d417555377e4@brauner>
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
 <acYVjuDOD7NynO9m@infradead.org>
 <20260327060518.GP6202@frogsfrogsfrogs>
 <20260407-unmengen-wahltag-474557ec0c58@brauner>
 <adUalnAyY9mm1LUr@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adUalnAyY9mm1LUr@infradead.org>

On Tue, Apr 07, 2026 at 07:54:14AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 07, 2026 at 12:25:29PM +0200, Christian Brauner wrote:
> > Yes, I'm aware of that limitation. In this case we know exactly what
> > type of filesystem is used. But thanks for reminding me that for btrfs
> > it's s_dev is never the actual block device.
> >   
> > What I would ultimately would like in the future is to have a security
> > hook that allows bpf to reject mounting any block devices that aren't
> > dm-verity protected. Maybe we can chat about this at LSFMM as well. I
> > know you will love this idea.
> 
> I'd much rather go right to that, with a slight tweak to clearly
> specify the expected protection and not hard code dm-verity.  There's

Yes, of course. I just used that as an example because we're using that
policy. Just a mechanism to intercept the onlining/mounting of devices
based on $rule. And the placement of that call needs to be as central as
possible so we don't have to spaghetti that everywhere.

> ways to do full file system verity [1] much more efficiently inside the
> file systems, and it would be good to not lock in a specific solution

Note about that: we generally don't rely on any verity implementation
that makes the verity information itself part of the on-disk filesystem
format. The nice property of dm-verity is that the integrity is
completely separate from the filesystem format and it's basically simple
math that is trivially to prove correct.

> [1] not to be confused with the existing fsverity for certain read-only
> files.  Although a loopback image on that would probably also qualify.
