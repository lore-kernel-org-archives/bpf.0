Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504876;
	b=vaBZmgeW7e1r1+DRA1v1YtrqGDyUO0xChJdM4sgkU+WdVaIxzt6MYYlfTOM+8YvaDWZ/
	 54IIurjMv6nFQMQumK/3xflpXrxS4COoE1uY/aHFtfrv4oPszUsUQkaH3BQ7nU08pM4W3
	 ihG5nCPMg8yQjIV1CtnUyioyaTdwRUP8c3hsUXPmiaadSh06C0rwSFICNvj99r2JkLVql
	 fpEnwvsVTrWkzNVVdRR2qr7KxirTH8Fy7FeGgYF/olMtvIYTb+lqVxiE4e3D2Xpa2T293
	 0kp3uol05rcyIziEHrHMRVaIqSrEihz4PDebudYL21dN9qCDioPr0sKvEsb/EM+C/og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504876;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=h23T9D711EMJDyMWkYY+/1FmfB/C+CHYnF4WCLbqkVA=;
	b=mszX2iyuIuKDMHtAkIpY+qZIOhid0exsoTzQd7ttiC6p1xAYyEU/1foxnzKQABVT5MaD
	 /YlOs3soRxbWPVZDoWB+KkuGvu351FYbSytQj2BtqqYFDppoxWK1aOIRrUh/BsyOGzn5y
	 PFyxP4tLcL47p0p6i4Y0/1SrGqo74Y2XwW0h/pBBBBu4FjbhNcIMGgI/AfwPDH7fzS+VU
	 FP4Bw+eQZjZ9NuFj2j52hsNS1DLsBABYiPmER31c5e2AR7V/M77B3WXGNCYmMjEDs7KJg
	 wbcKgFU1MzJzc6d5/9seZW5IwbPzmMGzo4DCreKmCBuAQsheyuUyhdb1ETVRP3DAcaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czkSOc5R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318D606E94A;
	Thu, 12 Nov 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czkSOc5R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1011F000C5;
	Thu, 12 Nov 2026 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504876;
	bh=h23T9D711EMJDyMWkYY+/1FmfB/C+CHYnF4WCLbqkVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=czkSOc5RC55Yh7YDtErKfTgjJPYnYRs9/jqrg9Z0C5wQrJrDpxyiHwwvRJzKrnV9a
	 PMd47TfveSDovtaeUPjulKDj/tg85+JPKwkgX0kUPVGR/IK8e8x638yZVOzt4jqoMD
	 kaBQxiGl5d6LlRMS5cVeEP2Jcv61Siqtc/LSxiNTn5LCOlApVnVuLyja61Othh/8cQ
	 zC655aepk5tpHAnI0TohwCB2B8qsz/vsmHlWxut3DmPv2bcqLvk+MJXO2eH+rV1ips
	 I88ejplMUaiJyA5UVXCmAQMT3pR8zgLt6pOF1uLq8RdTTsmHuOUMTlTw+O4/iq/P+c
	 bbX7QGpzsUTlw==
Date: Thu, 12 Nov 2026 07:34:35 -1000
Message-ID: <b2c95831800d2cd21fd28ec66f84cd9c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, liwanwu@kylinos.cn, usama.arif@linux.dev, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 3/6] sched_ext: Return -EBUSY from a pre-init scx_bpf_sub_caps() read
In-Reply-To: <20261112130934.563321-4-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev> <20261112130934.563321-4-cui.tao@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Tao.

On Thu, Nov 12, 2026 at 09:09:31PM +0800, Tao Cui wrote:
> Return -EBUSY instead: the caller sees a retryable "not ready yet"
> and the comment's expected scenario stays survivable. This mirrors
> how the cid path already handles the same class of pre-init window:
> reads before the tables are published test the table pointer and
> return -EINVAL instead of killing the scheduler.

Why is this useful? ops.init_cids() is documented to run before caps and
shards are finalized, so there's nothing for a scheduler to query or retry
from there.

Thanks.

--
tejun
