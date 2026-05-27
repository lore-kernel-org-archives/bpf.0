Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C738F93B;
	Wed, 27 May 2026 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863769; cv=none; b=orh/lFTIBHY6g+nyW2Xw5ckDKrvkzghbyY3mHt4nHJPAPIudFxt80uE6K2sIsFdBLhRXcFC0zcRBP41bc9X4fYiC0XuhTLZDOOAp6LJn2cGShj0+N0H0YzVACdO//+HYmbZNkcYhhNHUEFuXtasmUM0ia6iH5hD5ABW7oIhK9EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863769; c=relaxed/simple;
	bh=+4gcolxbJMWDdl9ML5fS9mq4eRYbugmUUi7VpPseeDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okvSY7K/74aY3EYpvzt3YQ1oxwO5xmVgRaMSmrl6/qXLZEppmJO0lVwdLerjNNkRUJTcXtdQGCv5EIFHb356UdmfV9zR/mdZMYnLAvJPID0zZ4EibsRHInoB+CSex2K2YyiFzy/lfvfUBjoqwurbFEdbHlwx07nmElL+shhsOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DfLdRd/K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DfLdRd/K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2X9JLneWqv2oGphPt2c/qDFQAq43EmtanRRqrzs8GHs=; b=DfLdRd/KUoe1qan/PAWAsf4TiR
	ChOHyFCTBewt5RO+3T/93rPseP8uQXKNZNyaPb/gi6dBpIKAJ73eMA3ggmLETmkCymSd9WYoGkicY
	/REJ/cE/z7d4k2QtJfmQdGrXS849ydamtUMmr+4iqss1sZIRXVGxOSYSaO2LDXAhgl9tU2zbQJABT
	OH2LEdnEE6w39emHJSEU2Kd5t2DXyB5LM658mggM5UWW23f72c0VwlibNgPNmfm5SFaTV5iSApjqc
	ySY8LECDHd8GQYEsFbuDE0vHCHDDXMWUzFjq2fefGS82pCbcbq4x/PDSraOop89tv65/hzlMiFWDZ
	0jxKh1bw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7s7-00000003PXp-2byU;
	Wed, 27 May 2026 06:36:07 +0000
Date: Tue, 26 May 2026 23:36:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v2] bpf: add bpf_real_inode() kfunc
Message-ID: <ahaQ1-puBtYjDe58@infradead.org>
References: <20260526-work-bpf-verity-v2-1-cd0b1850d31b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-work-bpf-verity-v2-1-cd0b1850d31b@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 26, 2026 at 02:02:22PM +0200, Christian Brauner wrote:
> Add a sleepable BPF kfunc that resolves the real inode backing a dentry
> via d_real_inode(). On overlay/union filesystems the inode attached to
> the dentry is the overlay inode which does not carry the underlying
> device information. d_real_inode() resolves through the overlay and
> returns the inode from the lower, real filesystem.
> 
> This is used in the RestrictFilesytemAccess bpf program that has been
> merged into systemd a little while ago.

I still have objections to this program as it really should not do
the poking through two layers of inodes and then look at the potential
incorrect device that should be hidden.  Please add proper VFS APIs
for your integrity verification instead of piling up these hacks.

