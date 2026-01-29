Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B055346FA2
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708060; cv=none; b=pjQtgQq2ZukaP3zAQiebdUvRaxHQtB4P+1aI7mqHRDPA9USRlLkQLxmuBxj19Co6aGWez0bbGerj7YfmBOtxsXj+f7fRwZguADZiLXN/ob7pZsNVM3z1Emj0eEW2OXYWC0LfQmqRCZToL3YzQjXHh3DrA6rGSxYPXbv296NW6Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708060; c=relaxed/simple;
	bh=Yzi9MIcZ6JIfSwtJxpLZ1N1x91wtPlEwVt9z2DX2r5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKl7B6n2CcZeMiY9w/9/YWQ63WLlzZ6esfw4BYq0L9VGcawy4UwVkSxdUcrfJXit91z84WSxzCvCqI0w8RbMli4YOnDsB85tCXw5OsFdlbPWqZ7zTeGna6bze6ZPeR9eAccPu5Rmc2W7m3RdSkbf96PFpRPqveDu6Ik2cQHXlw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drqCujBI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drqCujBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E0FC4CEF7;
	Thu, 29 Jan 2026 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769708060;
	bh=Yzi9MIcZ6JIfSwtJxpLZ1N1x91wtPlEwVt9z2DX2r5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=drqCujBI5QT+6/u1N/EXdbTnPsmNLtR+vWBaXVIVpor91tFRDf5PxugCiOjw3MAX4
	 rd++ncjXhra953Idfd/pCTbSHOQ8gPs0zM7kQpX8mvVtJHjP80OaWPQpPuZ5CnqrJi
	 DmRf7V9yLy0rnBr4JCwrvJCihH3Id5S0z0JgQMzXgIqw3kUhCAuASMsCthgOEZeB3o
	 mb3ObMtZYEKgR2fLSUtG6Z/c0T0ZnGMH4bK1Nt4AuNnyZFhVddc77pmFmBVxQHSuoR
	 CCVHU+vkrx1CCpFzszEfhJPtlRKsqVlCVAtGHDz58yg6xze6VFixikxZ44tw/Fj9zD
	 IukIZTrDSno7w==
Message-ID: <2b6f4cd9-ff0f-4a91-90ef-8d8e6812f80f@kernel.org>
Date: Thu, 29 Jan 2026 17:34:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm
 dependency
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260128233425.374535-1-mykyta.yatsenko5@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260128233425.374535-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-01-28 23:34 UTC+0000 ~ Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> BPF selftests depend on the bpftool. In some environments we may link
> bpftool to llvm dynamically and then try to run somewhere where llvm
> library is not available.
> It's simpler to avoid llvm linking altogether in those cases, this
> change allows to do it.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>


Hi Mykyta, thanks for the patch. Do you have any other solution to make
it work on your environment? We've been rejecting similar changes in the
past, because we don't want to encourage people to strip away the
disassembler when shipping bpftool [0], so I'd rather avoid adding this
if you have another workaround available.

[0] https://lore.kernel.org/bpf/9ffd4b6b-0073-cfef-5889-cb4d0b838f8e@iogearbox.net/
