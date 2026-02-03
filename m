Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E625FA29
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150380; cv=none; b=HJun03rqUTIE3udVi+/LPEPZjrpXqsMGSNMxYkFadl1JiiNmcwfqThuLz+hisUEySOsnQc/r4RM3P7wsOrRk1GvFsfDyW7RlhnpOUsBnaU46vbwltOwhMKuPUPCCC09/7TofijhY3GJyefEnUqgK+dT+bvvr5/s7+ohfToEjMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150380; c=relaxed/simple;
	bh=67UwMTEkJDoE0Rhxh75e3aXqro7WeuDpj2Lx0CRSGoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWk6xx071appkLYDRrXwen7R8WIkHB4R6sDjy9BdQm4vXqf9FqBAZXlLOBOSiT3zKmPOqN4Ezcy5Fqqp1bQLCruy1InlOjPkiBtyb58IXer1BVTxxPPMF8pB8bNPAAupd5o0RBBWhhB4brsfRnGL7V4wa+mzQiM9b9w7pLyOpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCU9gE1F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCU9gE1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550AAC116D0;
	Tue,  3 Feb 2026 20:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770150380;
	bh=67UwMTEkJDoE0Rhxh75e3aXqro7WeuDpj2Lx0CRSGoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCU9gE1FPalgS1P1JE5z36qmh6JvP3Y+8Plog0BEvl5FkBlS/j1X0lQ/YTJ+jZS3O
	 9MmRm/7Rg+8HgpQfjhleVrh0SKZpYf32bdfPspEYQSFilyqhr0OCO+sbKUBtLX2RAz
	 pkOonVzFZgLXZaxEsie1UB+juIvrbsMTz1XdPg9drtnlRbFGdw2v1phwE4LQ08zbWg
	 vqgZg/ACnG8XUVwfmN8wDHYPQORnPAtQANFLXcebujbIl+W98OQsQlYVwNHKg65u4M
	 c1yqDPRizykeRw6GaxzA2Acv/RM421Yb9iTi5oalSmddstSQAFSRTUFvOcq7Pa/y88
	 ieUb+2/FKiqpA==
Date: Tue, 3 Feb 2026 10:26:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Rohan Kakulawaram <rohanka@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Josh Don <joshdon@google.com>
Subject: Re: [RFC PATCH bpf-next] bpf: ephemeral cgroup BPF control programs
Message-ID: <aYJZ62BCwNIC1Q3f@slm.duckdns.org>
References: <20260203102058.41030-1-rohanka@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203102058.41030-1-rohanka@google.com>

Hello, Rohan.

On Tue, Feb 03, 2026 at 10:20:55AM +0000, Rohan Kakulawaram wrote:
...
> One of the main gaps in achieving these ends, however, is that
> there is no infrastructure that supports exposing per cgroup data
> via file paths that mirror the cgroupfs hierarchy. This would
> allow for a unified source of truth as it relates to accessing
> various streams of data related to cgroups. It is important to
> note that we would want the fate of these ephemeral files to be
> tied to the manipulation of the cgroup tree, such as exposing/
> deleting files when creating/removing cgroups respectively.
> Cgroup iterators can mimic some of this functionality through
> bpffs pins but lack the dynamism of the listed approach.

On one hand, I think why not, but at the same time, I'm having a hard time
why this would need to be on some file system. After all, we're talking
about BPF, there are numerous way lower overhead ways to do bi-directional
communication - shared pinned maps, BPF upcalls, BPF seqfile iterator, ring
buffer based interface and so on.

Can you elaborate why this *needs* to be a separate file interface? Note
that this doesn't really expand what BPF progs can do with cgroups. The only
thing being added is a different and not-particularly-efficient way to
communicate with BPF progs.

Thanks.

-- 
tejun
