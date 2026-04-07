Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12D33B95C;
	Tue,  7 Apr 2026 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573658; cv=none; b=U8kAmQ0d2x4y4KrhWdX5vAFe2JwGLXE7AvY/Iw5qotKTqqX1AsrKUOam6CJWkaIPsnr+EFN9brF2GHIWb6fFlgZNCkrnm45duboWCXprZEQA/pM1er1Ifz3hmDVZygzcxhIrr9wKP8Cot1r8JvKb0qDmRxzHHM0Kqr9tnxiDk8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573658; c=relaxed/simple;
	bh=RkaG3689Dfne+XM44UQiTKcfy5ESH998KqdJaxuhDO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAO9ElBRig3ynglCwrfhheINiBcYns76iYKm9GfEZbHXxOfqtboL73sufLFfF+U50QX2jldjPzn0TivIjIxNDjqOYv2MikBYfTzgDTq6IZAYNqRvyBrjFAcIl6nGYzUwVRLr4Lz0Cu9fNDh9MyKcp/kwFqeDAqjgtLsu34Bhf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lkbitBBG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lkbitBBG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I4Js2ohWZueRGJabplhLOOhsDw9WIffOuSiRzBa05HM=; b=lkbitBBGJM3CbpjW8o5AFwucvm
	6OFjkYMOw3EZUCZAWFBqLFUSaCboA5mxZSZZh+fAIaGStZ/4id2bvEGkuVj5WQgMeqCa10Bi9EH9Y
	vc+KaBS843kgj7FI0AV4zUdZuP/zxGUAwhrz+vEIOteTfbLtFci38lBiKbqxtk1NZzo1Qimc855jB
	AbmY2p9aF1hzjCu2C5WTaC8qpbATXprH5pIwVNyWaE4U7uOfuCwZgVkELaOocgvZ2uxDJTm40UiuO
	lNjTE8e738gWP8wFlvrDPTEEkYnGiN3MwTHGkfBKJGhTStYT4C43VqQexsamhr/o0X6hUT7gNSAJm
	1zHYdPpg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA7ok-00000006eeq-2lsy;
	Tue, 07 Apr 2026 14:54:14 +0000
Date: Tue, 7 Apr 2026 07:54:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] bpf: add bpf_real_inode() kfunc
Message-ID: <adUalnAyY9mm1LUr@infradead.org>
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
 <acYVjuDOD7NynO9m@infradead.org>
 <20260327060518.GP6202@frogsfrogsfrogs>
 <20260407-unmengen-wahltag-474557ec0c58@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-unmengen-wahltag-474557ec0c58@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 07, 2026 at 12:25:29PM +0200, Christian Brauner wrote:
> Yes, I'm aware of that limitation. In this case we know exactly what
> type of filesystem is used. But thanks for reminding me that for btrfs
> it's s_dev is never the actual block device.
>   
> What I would ultimately would like in the future is to have a security
> hook that allows bpf to reject mounting any block devices that aren't
> dm-verity protected. Maybe we can chat about this at LSFMM as well. I
> know you will love this idea.

I'd much rather go right to that, with a slight tweak to clearly
specify the expected protection and not hard code dm-verity.  There's
ways to do full file system verity [1] much more efficiently inside the
file systems, and it would be good to not lock in a specific solution

[1] not to be confused with the existing fsverity for certain read-only
files.  Although a loopback image on that would probably also qualify.
