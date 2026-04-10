Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED33890EE;
	Fri, 10 Apr 2026 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775804774; cv=none; b=ZFdMKDC1b4FateMnZwZno09kGPixh0bEhc0mdXZfxUJdEIbxtKBghlPevDehKSsfFxYr0PzCCjefCpihWMkXJQluuOqKZ9SLqtcemm3Fa2oMYDv5SRhoJdaLe2/mkhwksLFz+YPjnApX0pVQwhh4kaUFnRGlVvfpFo/fYPoDt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775804774; c=relaxed/simple;
	bh=iTEb/pgMc2T+B9SCp6Qn6buK3/n5BaKhcJPU8IEoEhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCqxK5eNMtMaBZC00AV8/lcaWjbtbnxkdvOF2LJ61NLvdEcxTf5trkmt7i2QK8VdvqdQ6pynSoUikoFFoAPR7GZhFg7bbDhffCJzNa6K2lpPKdjnvyHAbRLo85Qix+4VEgjhnuRucYHxXFUEo91aFMiMyAFRSIwNuDtM5b37CwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nsVgIZmV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nsVgIZmV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JVEMqQ2bTZsmiRaT8BYrbWGfG4e+wCHFw8ZKkwuHg9E=; b=nsVgIZmVfoni6RhL7GQ74HwuQG
	QwSuZRqxhYf6H+9lvaL4rHrbVjplVvhqm+9W7DfcCwubqcs6TozhtqFn1ZA0PkbIJhFPSlvIxFgss
	LVXUC8Amo+W3WQcU09eokGtAPAmZqthFbMYUZOptYcyod+O0qENXYwEds2yvnjHsp+TY2rGoLHVEC
	I0aDX5n9Uv3YkeaJSKPj6zbHyekByQZpANSGf8GSpmiw+qZcfkXzv7WC7WaSLw8HiWRW3H2W/Ud9q
	kpRqQy3VXpuDk3uv/fqAmc1Rxp1XHtOjv+BcRRMj0Evz4hd5O2fYmpa1TFP3FhfHSQFBUQit7x+aO
	ooHatB/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB5wM-0000000Bhzu-3FTT;
	Fri, 10 Apr 2026 07:06:06 +0000
Date: Fri, 10 Apr 2026 00:06:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] bpf: add bpf_real_inode() kfunc
Message-ID: <adihXuFuuS5uoJ31@infradead.org>
References: <20260327060518.GP6202@frogsfrogsfrogs>
 <20260407-unmengen-wahltag-474557ec0c58@brauner>
 <adUalnAyY9mm1LUr@infradead.org>
 <20260409-vorsichtig-umstand-d417555377e4@brauner>
 <ade2nskzkdcsvF55@infradead.org>
 <d889ed2b-ca34-4e95-ae5b-1d66636b515d@linux.alibaba.com>
 <adfPlQrImtuyhMIO@infradead.org>
 <7a605318-9f09-436f-806e-d4a3bd31b97d@linux.alibaba.com>
 <adiVdIhcgfiIoXja@infradead.org>
 <b3dfc06b-9f9b-4337-be96-a277061517d0@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3dfc06b-9f9b-4337-be96-a277061517d0@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 10, 2026 at 02:46:00PM +0800, Gao Xiang wrote:
> > It needs to be applied in-memory for every changed, and persisted to
> > disk on every fsync or equivalent operation.
> 
> Yes, yet it doesn't change my evaluation: and you need
> to consider background writebacks too (since writeback
> will update data and then impact the whole hash tree).
> 
> Currently data writeback can be applied for each block
> independently, but if you consider maintaining a hash
> tree (rather than simple checksums), I guess you have
> to keep strict atomicity between data writeback,
> metadata and hash-tree writeback, otherwise the hashes
> and partial writeback data will be mismatched.

You write the leaf checksum with each block.  The rest of the chain
leading up to the root is kept in metadata tied to the inode and needs
to be written atomically with the transaction commit that updates the
on-disk metadata to point to the newly written block.

> Yes, the OOB approach for leaf hashes will help to
> reduce write amplification, but my current observation
> is that it won't have any help to read amplification,
> especially for small random read; overall it depends
> on the target workload.

For HDD is roughly halves the number of seeks for random reads, and
at least significantly reduces it significantly but quite a bit
less.  For SSD it reduces the IOPS in a similar way, but for that
you need to max out the IOPS, which for most workloads you won't
on anything currently (and probably in the future) using erofs.
