Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D713D8B1;
	Fri, 27 Mar 2026 05:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774589339; cv=none; b=f3/frCQSht5bd1n0odmzAlM20BASjWSa+MM8zlfiMy+fVbC0sZ2g7iMmJO+Zgkml5/MKr3FBa0OKJNbcOZhix4nvCSFVejpFilCJj30yee4j8KEtac+WwSeKYpaJbhZDSo/i/mRWsDPkXzrhIK6DHVZfHMdAKEXvF4W/xH72DPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774589339; c=relaxed/simple;
	bh=FG2GDC4ij+T4I97jxKEPbfDAX4Pnp0gdJTS5GGYiiJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVqssipsJgBfYTPD2GcIVeLl/a5HZbxgLKYZIRe/MRif7U+pRGgatdoUlfCUB0QfNeF2gYvUXVXdbPPxr/gInGf/RMibcjEd2lAWGOz7+nTUIeVlAcQz5KCsWvZW7/8oEr+1j7wdoQUcP0cVWWBzTVRsYw3l90qBFU+Vqzj397Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dt+ZEV2L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dt+ZEV2L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BgH7Q1PDYXZ9oqGA7qXFYNJO8OSqR8pOwpmN7OS6C6c=; b=dt+ZEV2Lh/QuB/PJ9dvNudeJdR
	cWg1c+68N6n61UOqjYPOG0T9nYVPLziIHauoa3gB7xG2tuN7eWpVyoPOd/13wJkpewfVC5vuq0Iko
	suWau4EqFI8r7bAUy3hrQu6IOCdUd5WbAbEFptIukNwgs94LKROAjKG7d9J5LsI5mZ6gWe4Vylpju
	N5Pl91UwOnEIwc/21xuEzbqcKISvmqBcfdUz/5QyCztWNYeKqMzUX6LUx5NDBErcPPGpb3YfTByal
	FvcAdU3MlMDEn9eg+vqDuLEc7gQnuvaht6kmB2HEs3rZoiHfFKZ3HFX7ahDBHIh6afA0fioXSTGjT
	y9q2IQfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5zkU-00000006hyk-264u;
	Fri, 27 Mar 2026 05:28:46 +0000
Date: Thu, 26 Mar 2026 22:28:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] bpf: add bpf_real_inode() kfunc
Message-ID: <acYVjuDOD7NynO9m@infradead.org>
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

No comment on the code, here, but this caught my eye:

On Thu, Mar 26, 2026 at 05:53:44PM +0100, Christian Brauner wrote:
> This is needed by the dm-verity based execution policy implemented in
> systemd [1] where BPF LSM hooks must resolve a file's backing block
> device via inode->i_sb->s_dev. 

inode->i_sb->s_dev is not a files backing block device.  The only
think inode->i_sb->s_dev is required to be is the lookup key for
finding the super block.  It also happens to be the default backing
block device for simple file systems, but once things get a little more
complicated it often is not.  Examples are btrfs where it never matches,
f2fs additional devices, the XFS RT device, pNFS block layouts and
probably a few more I forgot.

For the more complex cases like btrfs there might not even be a single
block device for a file and/or the mapping can change.  So please do not
encode such an assumption anywhere because it is broken.

