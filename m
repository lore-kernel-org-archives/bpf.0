Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7B3B7741;
	Thu,  9 Apr 2026 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751068; cv=none; b=ehvm9tqXIVMRIyjy3rupsGu7VN+uMsBs2IWTSZn+hpvwp/QYOnlzSZBKGt7yO0Cy1UPhn61zIwK/w2xnOeEG3F95O+XRbQ4t3AwnYUJ7YKmFlJ8MjUoT4o/XIPsUKsTyZiKrYOYI6csF2tKQ8f/QOgkE9o/LY2lSM5vprTzggjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751068; c=relaxed/simple;
	bh=nopiZ+wWjn6L1ZI266QPLnkgnBR9AIWFQQ71CUhCNSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7jt/jdi9rcod0C9wIPbLNuyfHI6Vas7vRk20uSwZq+w5XU64jGZAJeRJrZ7e3kayiI5hhQFwjbuwWqkG5Qdc/Ms2x5YfH4TOoL6gL5Qco6DTauFI40H2X9BHbY7ppfChrdh+LIFZBnE+Zt5ayEZn5soL+eRPppDWELBXP7nNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qH5/9cKS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qH5/9cKS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fnOSvuDUL9+1Ay/ob5YlOvnH99aIvHh/5ZmPHvtUw2A=; b=qH5/9cKScqEntBSLt2Ss94G6mH
	ZIbK/otNIklPLaUuahSS6gmr0+nCm0cogprXjwYi/LdWNRWR/CIyl3L7HndlscS8WBFVptVz6dqWA
	gL2bn4G+Zmfk2YkmH387jOPaAqURAoPmgGHuaXUbbj2w9Asl5eO94q8Us4CR5a8L2A//pHuHeiuPh
	FhNTUI3aTR6q99o8ENjOaQtdjeh1C29Qm0wOrdzSMZtQAWiYecb76Yslmo+j1jqonbd5zrgYjPoR8
	n7QIzllEkmcyzJX2akc9UwvS9oM2+UXPfSYaK0ofpio0efrvOIoVClXHlfY1weT8y2K9Z8rJv+xcG
	iGHxeyMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAry9-0000000Atez-29nt;
	Thu, 09 Apr 2026 16:11:02 +0000
Date: Thu, 9 Apr 2026 09:11:01 -0700
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
Message-ID: <adfPlQrImtuyhMIO@infradead.org>
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
 <acYVjuDOD7NynO9m@infradead.org>
 <20260327060518.GP6202@frogsfrogsfrogs>
 <20260407-unmengen-wahltag-474557ec0c58@brauner>
 <adUalnAyY9mm1LUr@infradead.org>
 <20260409-vorsichtig-umstand-d417555377e4@brauner>
 <ade2nskzkdcsvF55@infradead.org>
 <d889ed2b-ca34-4e95-ae5b-1d66636b515d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d889ed2b-ca34-4e95-ae5b-1d66636b515d@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 09, 2026 at 10:37:46PM +0800, Gao Xiang wrote:
> > LBA data (which Linux also confusingly calls intgrity data) would be
> > even simpler and easier to verify.  But yes, we need to clearly
> > document what we want.
> 
> Yes, you could keep hash / checksum in the extended OOB area, but
> I guess you still don't know if the hash / checksum of the
> particular data can be trusted (or is changed by attackers).

You'd still need to build a full merkle-tree out of them, but storing
the leaf hashes in the extent LBAs means:

 - a lot less I/O amplification
 - a sane way to actually have verification (including authenticated
   encryption) in a writable file system

