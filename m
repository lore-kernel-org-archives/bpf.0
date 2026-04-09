Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FB2E3AF1;
	Thu,  9 Apr 2026 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744686; cv=none; b=tRDewFkII3rmoxEPDNSe5Ej6DBsiWfeWrxuxAKVd7fuNaOsBkWQTneAR2/zQzbtRhtXNPJE0Ho2lznjy7zBkPsSAzlo7XUUNVlCI+LT8x6MOHrgoTet1RSOH+zIeFhm+HA11BnCH+YqhkMuc0Ie8Qck5Nd5VTju9qBqklQU8KdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744686; c=relaxed/simple;
	bh=SUdGY5HVFvDcHzp72SDRpxbcKlePboKVB8TKShOaiJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI8RSMK8DIgb/067ZN31DvPik53qILUQWos0e/9xIsgqieUhKQ5nw3MD5zFlvZF0U/pPQQX/C97Vax/miWaiW4xfqQz5UGLP0jAquundJ3wPgYqwk+ctPQmW893yzp+2yH0fNREl/zh8Ulidh7FriC2sC7V2i+oWL8/Bhp3//+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TsXFe7VC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TsXFe7VC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZriNUv43y9hyKogezhLLvYEHVpd46sW27LpgGvQvIZ0=; b=TsXFe7VCaHgNbmPsKxGHE0QGE1
	0jqJpQeq/eSThLRv/i0M+L4POuXbvK/9f2jaEwBoHAzGD4d9E7XGDbBSCIrjEZpGMzvjd6SJxwA2d
	63oMZWEp+icNkGWfYM4DR0Nm7nvSPFRf7NhHGGnWw50opqlInYWeu4rqLc4WpT1JW8v2LeSiyWBWe
	kMwfSnDB2+TQSdrUm2QVsxHE/ksBnR41b9wi6dRjcdId9t56rwp5luH2jkNm7SHd2BTWVPMF1DJFM
	VqvWoJCxFlM2eyJc87hwivMuPgDksAWccmQsX1mQzc10Q3+HbZmX9x0Xn3fW1OO0iWK5iou1/7pwU
	OLrIzesQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqJ4-0000000AhGG-2DKp;
	Thu, 09 Apr 2026 14:24:30 +0000
Date: Thu, 9 Apr 2026 07:24:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] bpf: add bpf_real_inode() kfunc
Message-ID: <ade2nskzkdcsvF55@infradead.org>
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
 <acYVjuDOD7NynO9m@infradead.org>
 <20260327060518.GP6202@frogsfrogsfrogs>
 <20260407-unmengen-wahltag-474557ec0c58@brauner>
 <adUalnAyY9mm1LUr@infradead.org>
 <20260409-vorsichtig-umstand-d417555377e4@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-vorsichtig-umstand-d417555377e4@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 09, 2026 at 03:19:27PM +0200, Christian Brauner wrote:
> > ways to do full file system verity [1] much more efficiently inside the
> > file systems, and it would be good to not lock in a specific solution
> 
> Note about that: we generally don't rely on any verity implementation
> that makes the verity information itself part of the on-disk filesystem
> format. The nice property of dm-verity is that the integrity is
> completely separate from the filesystem format and it's basically simple
> math that is trivially to prove correct.

Any file system integrated version storing the hashed in the extended
LBA data (which Linux also confusingly calls intgrity data) would be
even simpler and easier to verify.  But yes, we need to clearly
document what we want.
