Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35DE2C08C8;
	Fri, 10 Apr 2026 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775801732; cv=none; b=XUoX7p6mIAJQFsnGWRLmfaZhjulOtqpDienP59vdtWQtn4ZAt06FPf2kbUMft2eANYxd1PVVjPsvE5elHeevxHULVLpepnHghdSjViycvoc296+3T3QN2tVRCUDZ3CkIoTqY7UUw0hPUhA4R+3BXPVUmtyaoHV/RPRrjO2Q33A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775801732; c=relaxed/simple;
	bh=KgvnKGcXGXU88l0czntTzYFax2G5Iid/3FAP9jKyAMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo5XnSk8sjw7QT28RtDfonu6RfBajvk9oPexPqH5KNjqKu61T3M240o2TIbRD4XY9xb5mAEfQ3FS59QL4VRrbSJtZCHoeHLrFQP+rsjvTtO9BbWvhCuA2H4jGFiCWVr3C4gYb0Wn3rhbjlfb2syQp/NkC7JRpd2UjHDaHeNmfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zsTIFQla; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zsTIFQla"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Kk3EU/XwfJL9hGGHRQptOeSG6TwGLTBxlWVgkU2o2I=; b=zsTIFQlac0OVQ6jQXXHfQCatYd
	9PiNnMeIZYp3BXrusZ2eqU8Z6tigF6T/XTp2D9y7SD+Nv7iAtTr7glCU+dCJKzZ902X6xj8UxHht9
	G4OGKGJQ8qEcpG3ujjrcFn676rIC8WuLQl1KtjwYZORsfbZjNtqvyO4TGhSfGBcBzVP2+cXUtLdsR
	SgORoyZ+xlyyfiHI/6eLaNaBnYn/v2slv4CwJjX7+4lsFozLlMkDGEEi6cNa82Vu/5UknDXGjoH7R
	hnuEtqX+S3gU0SUdlcsRfOhwKXCoSWWKdoNle3V3wTP3Ck1sGpkNQ/pZ8Wc8+xQBhhoNFgm/i7c7R
	XcEmSp9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB59A-0000000BfVD-43nY;
	Fri, 10 Apr 2026 06:15:16 +0000
Date: Thu, 9 Apr 2026 23:15:16 -0700
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
Message-ID: <adiVdIhcgfiIoXja@infradead.org>
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
 <acYVjuDOD7NynO9m@infradead.org>
 <20260327060518.GP6202@frogsfrogsfrogs>
 <20260407-unmengen-wahltag-474557ec0c58@brauner>
 <adUalnAyY9mm1LUr@infradead.org>
 <20260409-vorsichtig-umstand-d417555377e4@brauner>
 <ade2nskzkdcsvF55@infradead.org>
 <d889ed2b-ca34-4e95-ae5b-1d66636b515d@linux.alibaba.com>
 <adfPlQrImtuyhMIO@infradead.org>
 <7a605318-9f09-436f-806e-d4a3bd31b97d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a605318-9f09-436f-806e-d4a3bd31b97d@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 10, 2026 at 12:42:41AM +0800, Gao Xiang wrote:
> >   - a lot less I/O amplification
> 
> But not quite sure recently how extended OOB data is
> kept within the physical media (I remembered in the
> early years each page of raw nand flashes has
> several-byte OOB together with the user data): if
> it's along with the corresponding LBA main area, I
> guess it has to read extended data among multiple
> LBAs (but the LBA main data may not relate to this
> partcular I/O) in order to verify the hash of the
> hashes.

For HDD it it is stored next to the media, and doesn't introduce
extra seeks.  For NAND-based SSDs it typically is stored close to
the data as well.  NAND pages are significantly larger than the
exposed block size for any modern SSD.

> 
> >   - a sane way to actually have verification (including authenticated
> >     encryption) in a writable file system
> 
> Yet if considering modification, it need to move up
> the tree and recalculate/update all hashes until the
> root hash, it's not a low-overhead task TBH, and need
> to apply to every single on-disk change.

It needs to be applied in-memory for every changed, and persisted to
disk on every fsync or equivalent operation.

