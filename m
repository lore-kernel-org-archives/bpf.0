Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765853976B8;
	Tue,  7 Apr 2026 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557535; cv=none; b=dGayvxk7ZOXBoCndVeYW3sWZW3MDjtzh/7PpfaCeoLYy+Sa1L18BoUuFT2XLhfqPD4tuJxS3BduLGIVXI5nWTlzoH8sTT7hoEYDbLfawHHX1SErCsV/XG5GarbZ/+NWXLt5ZSj3/gHHrDA355FjLhaAszhf8MjGPyUa43Fl+YOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557535; c=relaxed/simple;
	bh=JLoqnTrfr1mDpCNpLPqauZVquycBGwSg65cnm2IhqPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3uLZPuf5ZKfJx4U8myy6ez0r4CqPExNt2Ygu1VmuQAJRq1j7xb1STgd1kxsroTLP+9OWE+/7glA7PTbGWZjchd0zcYz98i99fmYvgtJMZu6MC5TLdWpf2Fbsl2Guh7zTLnLpctYtP5s92mZG8Ly3EV68BJI79pgvxgVDSRmyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV7KhmBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV7KhmBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3387C116C6;
	Tue,  7 Apr 2026 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775557535;
	bh=JLoqnTrfr1mDpCNpLPqauZVquycBGwSg65cnm2IhqPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pV7KhmBmOVF7Ofj9Z6OQ1VDOSYSrL7p0nqQq9ddwQcuzqpKKqGqAIp/4HDprbrYhX
	 9bm7p80Tnw8opHwqb09XzbHlyozh3LEsEwRwXDq9KyxkFDVTKxq9/CS+YJoYYkrG5C
	 9WK3CrjJWEt51chP5jopnsTtWq/fjU7tYyoBOoC2ffj8Ru4aVkD+sjP9C0l3lE0Wgm
	 TFEzEWCCRIn1yA+zc24se1qWP5X9VCi2Q2UrYO+lOrnrQNJZajMWz7INuzOyhRkW6k
	 2dmPtUgAExM4VAiIPK647PYXITgwJKCCRGwZ6R5h726chpC974IkRJL+0ZPkm9WXQH
	 WNz2GPBKkfX9A==
Date: Tue, 7 Apr 2026 12:25:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] bpf: add bpf_real_inode() kfunc
Message-ID: <20260407-unmengen-wahltag-474557ec0c58@brauner>
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
 <acYVjuDOD7NynO9m@infradead.org>
 <20260327060518.GP6202@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260327060518.GP6202@frogsfrogsfrogs>

On Thu, Mar 26, 2026 at 11:05:18PM -0700, Darrick J. Wong wrote:
> On Thu, Mar 26, 2026 at 10:28:46PM -0700, Christoph Hellwig wrote:
> > No comment on the code, here, but this caught my eye:
> > 
> > On Thu, Mar 26, 2026 at 05:53:44PM +0100, Christian Brauner wrote:
> > > This is needed by the dm-verity based execution policy implemented in
> > > systemd [1] where BPF LSM hooks must resolve a file's backing block
> > > device via inode->i_sb->s_dev. 
> > 
> > inode->i_sb->s_dev is not a files backing block device.  The only
> > think inode->i_sb->s_dev is required to be is the lookup key for
> > finding the super block.  It also happens to be the default backing
> > block device for simple file systems, but once things get a little more
> > complicated it often is not.  Examples are btrfs where it never matches,
> > f2fs additional devices, the XFS RT device, pNFS block layouts and
> > probably a few more I forgot.
> > 
> > For the more complex cases like btrfs there might not even be a single
> > block device for a file and/or the mapping can change.  So please do not
> > encode such an assumption anywhere because it is broken.
> 
> Seconded.  It's a pity that dax_writeback_mapping_range makes nearly the
> same mistake...

Yes, I'm aware of that limitation. In this case we know exactly what
type of filesystem is used. But thanks for reminding me that for btrfs
it's s_dev is never the actual block device.
  
What I would ultimately would like in the future is to have a security
hook that allows bpf to reject mounting any block devices that aren't
dm-verity protected. Maybe we can chat about this at LSFMM as well. I
know you will love this idea.
