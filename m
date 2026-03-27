Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CBC30B51E;
	Fri, 27 Mar 2026 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774591519; cv=none; b=DdQr8kG/7jf9/55lBimjwz0ISbRWsk4HTnlb4f1MRBaqKjjDGjHE7lg+sOeGZdcBQwbztSIUJmZ/PFNdA8wp5r4DkAGk+0f9yQF1+dbe+RiHslxpcGfuXNsVQbCr7XqyAAnGhuaLFaicutSr+xCBuxE/QfrJBPlNOwv39BjarsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774591519; c=relaxed/simple;
	bh=3zpggxe+bVQs52v6JpXlcKy/PVZUHZyPYXEEIA94JQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJ1nGUxBnvwgMCOTiPfnh2A2lMzva6cg1/M8Jdjq8evUjid0rif/Y8dkpvpJuCPYdUk5TTaZhMWXfFyAx+Gf1TWLTYVDk9Z1X9LQ9xVUM6BPEcx2+snNL4kspEBgSB0J4G9HjKivkHQp9PfWCAPvh0OiJ+hkN7KnJB6ul9gzet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEK91Xgl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEK91Xgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E349C19423;
	Fri, 27 Mar 2026 06:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774591518;
	bh=3zpggxe+bVQs52v6JpXlcKy/PVZUHZyPYXEEIA94JQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEK91XglpLKgSre0jgVBLD17K8QMDYwYL0K1lL0SB3ba0o09gCKmKvQDyWnF4DTBZ
	 iuhMqXLc/Asnh6cpQmxYV5B6q683PzDPdUQByanHhpm/2QaWHTk2h85rxqBe8zKdBf
	 DM/gnA1ipI5Ek5x6XYyf/t4eJvZh8QurmEXu43WqviZHOM7MhtNqPVQdYoTDcSoGuz
	 DMrtP6ShigaRTC235i8Tb7YzvJDvgbjimpJwruZaKPCf9TgoDAb34b3/Fh/WoQq5lo
	 sbECxzdlZZpdlu6id6BgC9utEsuQ5ABLMqaZjkULavHDe0Lr3T6pjeP5rMHn51+0gI
	 ZnEpdiE4W6cpA==
Date: Thu, 26 Mar 2026 23:05:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] bpf: add bpf_real_inode() kfunc
Message-ID: <20260327060518.GP6202@frogsfrogsfrogs>
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
 <acYVjuDOD7NynO9m@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acYVjuDOD7NynO9m@infradead.org>

On Thu, Mar 26, 2026 at 10:28:46PM -0700, Christoph Hellwig wrote:
> No comment on the code, here, but this caught my eye:
> 
> On Thu, Mar 26, 2026 at 05:53:44PM +0100, Christian Brauner wrote:
> > This is needed by the dm-verity based execution policy implemented in
> > systemd [1] where BPF LSM hooks must resolve a file's backing block
> > device via inode->i_sb->s_dev. 
> 
> inode->i_sb->s_dev is not a files backing block device.  The only
> think inode->i_sb->s_dev is required to be is the lookup key for
> finding the super block.  It also happens to be the default backing
> block device for simple file systems, but once things get a little more
> complicated it often is not.  Examples are btrfs where it never matches,
> f2fs additional devices, the XFS RT device, pNFS block layouts and
> probably a few more I forgot.
> 
> For the more complex cases like btrfs there might not even be a single
> block device for a file and/or the mapping can change.  So please do not
> encode such an assumption anywhere because it is broken.

Seconded.  It's a pity that dax_writeback_mapping_range makes nearly the
same mistake...

--D
