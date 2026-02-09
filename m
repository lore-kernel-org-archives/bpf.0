Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FCC3EFD2F;
	Mon,  9 Feb 2026 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664267; cv=none; b=d2qvUOEYeZJKfPeUqYC6Fo98Yiyrg/XzgzoEChG18blgWil3xbMPBwcG+sSSeESjUaAK/loHm/BJUsiXATF24e/VytlwrwrzJwZX6AD2MO3Zz1upz7omXCHdb+Yzo8DSWlFMyGm1lbCU7zPMTi++Q9xy8PDuuu94cbFruiDfEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664267; c=relaxed/simple;
	bh=kZt9M1YRULSLHyGLdjnQHwoSmJ13N3Gz5fXm9cq4BXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5xaq4EkVijf2VU3xeW5k5CoHFntqhoblJ3+WnIxojSZ6PPZhKl7WRYk3/oUPRKnlru4+7CJlEAPH9zuqVDxN6+eet3NwFfAj1KKlAxgDZUdPtw/cB7KntlEEI2aQ8kGYuMDgFF4PMCnvB7y2pcZrdvvdTGbqjQGA9Gu4MZPC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW6okML7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW6okML7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C172CC116C6;
	Mon,  9 Feb 2026 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770664266;
	bh=kZt9M1YRULSLHyGLdjnQHwoSmJ13N3Gz5fXm9cq4BXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PW6okML7rDt29KRIEbqlP3q8+pD8EXIeBuEYMXLSzY71yNLnspeuulYU2hzQxkheH
	 R6oG00jzZFe98PA6mTyUhZxdAweb/zU8g+53rlMghW7wKLkyYaIMR350f69/qiWsLR
	 EWSVjNn23ruEXCUNX+ypfEYyqW64fxQ4A/xbOSMT2xaZBik2t3fhrzM3K+TVXw6sgd
	 mAnZqaMhrfekr0/RYnJup3fXuLqOpRf0XzMarBxzA8XBI3UAYXS4uJWNNMcDYoaUqi
	 9G/KrZnpHycWlWkMCcHsJx7E0HhvShrsK5FD4eTX3t3EXHIurquA4k2AKjMn7VCnxU
	 OQ2UcJr0dTYjg==
Date: Mon, 9 Feb 2026 09:11:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	guohua.yan@unisoc.com, ke.wang@unisoc.com, di.shen@unisoc.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, xuewen.yan94@gmail.com
Subject: Re: [RFC PATCH] tools/sched_ext: Use u64 for kind field to fix ARM64
 atomic ops
Message-ID: <aYoxSfDjUvnIIAMd@slm.duckdns.org>
References: <20260209085536.16723-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209085536.16723-1-xuewen.yan@unisoc.com>

On Mon, Feb 09, 2026 at 04:55:36PM +0800, Xuewen Yan wrote:
> From: Guohua Yan <guohua.yan@unisoc.com>
> 
> There are following compile errors in arm64:
> 
> bpftools/CORE/scx_simple.bpf.c:144:2: error: unsupported atomic operation, please use 64 bit version
>   144 |         UEI_RECORD(uei, ei);
>       |         ^
> 
> Convert kind from int to u64 to resolve ARM64 atomic operation
> limitations. ARM64 primarily supports 64-bit atomic operations.

Alexei says this is llvm bpf backend error and the answer is to upgrade to a
modern llvm that defaults to -mcpu=v3.

Thanks.

-- 
tejun
