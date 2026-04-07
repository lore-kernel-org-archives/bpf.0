Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD44238C1A;
	Tue,  7 Apr 2026 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526313; cv=none; b=KF4HAqmXXHL/zL3tM4FgOEqeaP+juohKAbkLhD/JU4uzBeWv1BZEHnzheOVa2oMOJ5m7sfrB1SjXKxj4Jg9l5lJpdbM5hLXwOJWFs3crSNUJkN0+sh0gg3Sn1VVZwHz2hXUMWkOooBXqVGF77BvFxL7q3gS3AJxS0M7Q3o8kY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526313; c=relaxed/simple;
	bh=KcvkA/E00Wx4hWtOlaUTISCZhZKC8imyu8C7PpT9wWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/Jb90lyufpfRWaMgklJw3KSRcqT6gk90G5vY24qBZBtdtqJdBMuK7bNIKngamYz6WKRw+LHVlrCNViFhNI8vnw2W9zzsQFDM82IYnjnQlVw4QYm76M9bHvxtZqcR93pNDHHq2a/4Ttm2DFZTlvu/G7AGZ/fC3zSF+JkoSxaAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mjs7fCXY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mjs7fCXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0232C4CEF7;
	Tue,  7 Apr 2026 01:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526313;
	bh=KcvkA/E00Wx4hWtOlaUTISCZhZKC8imyu8C7PpT9wWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mjs7fCXYlHewMportKa2HSLRVh7Y27pMubXiTN69l5Qxniz08aYnrybMkIqStrueQ
	 uvD5VPJnVlbGpkLMvHjAdQlzpQBjW56pBgqWAC+gq7IIJVv9060NODRFK8g7p9fjhP
	 hcIq0FXPF4SUOS+1qyNU0kAJPvHiorWJghhRugd2mK+M3ZVmdjEViciNtUSpgBv1AJ
	 Ka55jOfDjMZEl5H2X6J8EY5/S/J+Ludg/ddQh2ukycblp5bszEu7nxvtERK5aK1s+W
	 7gS4Y+ycbE3jZ/rj4oNWXYjSJPnHBkwzIZ7Luyw5a4vKwZugc6rSaCpN8Cn7GBsWYx
	 z7hYFuse4JpCg==
Date: Mon, 6 Apr 2026 18:45:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <larysa.zaremba@intel.com>,
 <aleksander.lobakin@intel.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v6 net 3/8] xsk: fix XDP_UMEM_SG_FLAG issues
Message-ID: <20260406184511.748707f0@kernel.org>
In-Reply-To: <adDjtUbNPSjffLSm@boxer>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
	<20260402154958.562179-4-maciej.fijalkowski@intel.com>
	<20260403165636.1f4ee958@kernel.org>
	<adDjtUbNPSjffLSm@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Apr 2026 12:11:01 +0200 Maciej Fijalkowski wrote:
> > BUILD_BUG_ON(XDP_UMEM_SG_FLAG & XDP_UMEM_FLAGS_VALID)
> > 
> > somewhere or use a hack like this ?
> > 
> > #define XDP_UMEM_SG_FLAG	(XDP_UMEM_FLAGS_VALID + 1)  
> 
> Good idea i'd lean towards the latter version. I can send v7 after easter
> or if there wouldn't be other issues related to set maybe maintainer could
> adjust it? ;)

Quick edit breaks the build, probably missing an include.
Let's leave it for a follow up 'cause I'm gonna break something :S
