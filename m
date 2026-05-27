Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB304376A04;
	Wed, 27 May 2026 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910060; cv=none; b=qjkZ3FsXIAR9la/lmF808czBaDeZqYdGMZeyDTeCHZ6+I9890pUfwbdZ2PkncHkrV7mO+nTvXfPGEcLVwO0USTAn/6OjrUmpD6IPW3ps0Tu3CZOTJzgkDLcP0yI6ou/w3GrtNdEdgS0RsQmYrykbfYPcRJYygm9rdGKoLxirdEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910060; c=relaxed/simple;
	bh=I6rXmqj1/09InO5E55qZiYaeL3imTctwylNQj0iuz7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSlxI1tP2+KpDqYyZ+zV+9NHNqBrPIPMhdf4xlbSuFmANk9BOR/o0p3HmANnU93jU/UPo2GhhpkiXIUYy3tvBH/wuWaIJp5tYbtP7FZmUjQEiZhR6tc/+/WWQYy629Y7yQkUy3pKA6thnWAlTrHGS3oA7gwq75XqvP4VlbCuuZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpkBKtz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpkBKtz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1B61F000E9;
	Wed, 27 May 2026 19:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779910058;
	bh=SklbkO+cYcSUJ+xy8Q2xa2q3pd9qKXRXxja0KGBXedM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MpkBKtz8W06VXzx0kzrk+OMYxdxCgEkAd980ksbz+soshD76ZTpt16qqhyDxtb8uZ
	 j6KP7y25kHD9om1THmqjwAvrv3m11ItirD9HNWbxgEY/TnlG+tAcUTMERS31s/dQEJ
	 C6qDSyGTa4uBrQ3Qtg4rd33LBuUpurT9vnOCeAgJwfq1PdtLcZc83rULO+YEszghM4
	 +Ftc/tzNqri7H9tgYQ2pWiN55x5p+DcfwLlmH/mStaqW+nLUMfJ04EynRK3yFEZmj1
	 FzGeXwwrC1h9PIK0wA+vCuTFLGEBHjg7pkkVEqJgYMciaoUOe6ioP2dZq0SJ33jo2R
	 5+eEqopkrj4yA==
Date: Wed, 27 May 2026 09:27:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <ahdFqYqzxRoGFuU_@slm.duckdns.org>
References: <ahWOVFZZScPjm2Ow@sirena.org.uk>
 <CAADnVQ+yjm0SJ0UQMeuS82MLDeo1bvZKSMMDh-K8D9-PNu=p8w@mail.gmail.com>
 <23a429b4-bdf1-4f96-b3af-7ab3186e99d3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a429b4-bdf1-4f96-b3af-7ab3186e99d3@sirena.org.uk>

On Wed, May 27, 2026 at 02:24:49PM +0100, Mark Brown wrote:
> On Tue, May 26, 2026 at 03:08:06PM -0700, Alexei Starovoitov wrote:
> 
> > thoughts on the best way to fix it ?
> > Pls send it to bpf-next. I think it's fine for it to be in one tree only.
> 
> That's fine from a -next point of view since bpf gets merged first,
> you'll also need to ensure that the sched_ext stuff doesn't get sent to
> Linus until the bpf changes have landed or flag the dependency up to
> him.

Just sent the fix patch for bpf-next. And, yeah, flagging the merge order is
what I usually do.

Thanks.

-- 
tejun
