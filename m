Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538A378839;
	Sat, 14 Mar 2026 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773499606; cv=none; b=XuNPLXH5lMRtOygBq6+51d5VmeXS074iovUCourhN1fTF6cxRmswmhepo5vJmZkVCxxCTzxhrzljmgpmRXu+3tzTghuWbMyGRRodJVgviBp2r4xvCqQktq6O8UoeUQ5PQm+DzJmCRiKxihXrrDuNOOUJ/2hRXxrOm9txBWs2mzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773499606; c=relaxed/simple;
	bh=6RU8YXK4lZN6siF8UbKrqN5vMtCFPb/4s6yA+Sn9MNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAgBZC7IAMGf3ruUFhbT9Aqq7/pJCjlXLzoMU28J0jSWDttda+6Tg5SrraHQV4X9GFt8PRYPfEqE7ZW7CRq2YKzo3PD9WVpehDG1D0Vy/GkEon++zMky/nzqSDPE5yCeFkgXhmEENF06Wj8cuvEmNC/eZtfFylHfGIWoLRRZpvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ1uOxYh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ1uOxYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE559C116C6;
	Sat, 14 Mar 2026 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773499606;
	bh=6RU8YXK4lZN6siF8UbKrqN5vMtCFPb/4s6yA+Sn9MNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQ1uOxYhsn2rdSSZbRTwlAsHhN71r/yB1LGVZKoyRhq+d/8gNjQcqlmeBFv7TK1Nb
	 BXvDdS0re0es8eY6VmP5BKMxnV/d2Ccix0TzykXmK0kCNiyEohZUt47HOXGbj/EqQZ
	 KJdppcJYsvREbHU2EM3r0z9znqt8cE66ID55MNjSIDOjLXBAQM2kO6Z9f4EcEA9sr7
	 5QrkIAGG1Bm07Y/NNxU0spRVIzrmgP/3X2EcHuH8yH0thGotdIT+cwspNZzggSEWkW
	 gkOHK0sB2zGVAr0Xsr6vPmcVQuntI8mrBbB+EMVeGDYGogY8qswBMcmp3g8jAp3x6P
	 p4QdsSHyb6q7w==
Date: Sat, 14 Mar 2026 07:46:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, <pabeni@redhat.com>,
 <horms@kernel.org>
Subject: Re: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer
 Rx processing
Message-ID: <20260314074644.027eeb3f@kernel.org>
In-Reply-To: <abPrzvYABPo7iAzq@boxer>
References: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
	<abCUMtO8Trtzs23d@mini-arch>
	<20260312173348.4e70cdec@kernel.org>
	<abPZXXt/xCis3tIg@boxer>
	<abPrzvYABPo7iAzq@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 11:49:50 +0100 Maciej Fijalkowski wrote:
> On Fri, Mar 13, 2026 at 10:31:09AM +0100, Maciej Fijalkowski wrote:
> > On Thu, Mar 12, 2026 at 05:33:48PM -0700, Jakub Kicinski wrote:  
> > > The pre-req is in both trees now. Please repost?  
> > 
> > Will do.  
> 
> Argh, seems like it's not there. Maybe you meant Nikhil Rao's fixes, but
> the pre-req for this patch [0] has been applied to bpf-next, I do not see
> it on neither net-next nor net tree.
> 
> On bpf-next I see this as f620af11c27b ("xsk: avoid double checking against rx
> queue being full").
> 
> [0] : https://lore.kernel.org/bpf/20260218150000.301176-1-maciej.fijalkowski@intel.com/

I see, repost for bpf-next then?
