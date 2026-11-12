Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504878;
	b=HzYNj2paKPc9eceXBeQqQV/OEpWJ5IrQvCZB2j/isXOrtQagV8wiQ3wAFYvyjt67OhA5
	 LI4yC3YbW6N8ZgT8I3eRUR+u0CumA1gep98sjV7Pfr+9xP6Tiau2KbGuNhTf6RF2poWIK
	 r8HIGp88jCOh9aUn6flHvZqFcNhbAXxN/9GTemRkBgT5zKSKFjQXaaUuzLjJ5DG6H6dng
	 zSSmAtJsd7m259vsH+C+V0NTx4fLaZGlG4JAwipZviC/04lWU6+k1LT8JoAbBDG9cAIJa
	 FYU6HfUyTqLDsBeAOZHTwbOoZ+vSRE1QMTuW7JVitvfgGTES0cT+7LxUTGU12V6b5dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504878;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fm7bMgVKXh5a/1Ygvu5qJSx51od/ElshRnlpIQ228R0=;
	b=SHSPm/4tX96ERUx63itNT8AcOSx4CdLSTF+fF0Uk7DM48rZNruVR3KRRDJEP//2Ww3gT
	 H6fSoTuje3wo82l/tWlUl5Y/0cu4Bd2ULZF3L5HucdMeP4A3glW6vL5geQG+vlSH34wEH
	 H0MvcuwNMGw+ecA2wlGJORgicEAnqNZngBKf5F1xf2IxXYVpWtPTQvI/QB8BEh5S9JdUg
	 tVzZG/k6j5xk6AG+zTqH6CHgOQQFokYXWBZ21Gq6tJilR7hih+nazJ7wUP+wkDLUPB/wc
	 JldlVjULQY9HDbds2DeSRvQ9blnfUZded4WaUta7n53oCPqFmbbqnBt/UrTQEWyG96Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Emi5VUGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD9606E96E;
	Thu, 12 Nov 2026 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Emi5VUGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11281F000C4;
	Thu, 12 Nov 2026 17:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504878;
	bh=Fm7bMgVKXh5a/1Ygvu5qJSx51od/ElshRnlpIQ228R0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Emi5VUGUVG+4lexaZeYMtQrX6eiHuBCgxoXtTw4frrLsA20J1NBWqzLaotiWtMx/5
	 GyZiL38Wtbko8HeIsSrxs/JrwLoOqf2fGls9wlxwV++6veSzJ7VlZhP6GGrcQRq6py
	 sso2Luli/1h0+SXcPadaM/Z9LeDxh+XD7aWgpNH5l8wcyq4HXJRlL2cidGPpB4tmr+
	 zHVo6ASFWDwybvYT9nNIfdZf5JMgy3zei1dXpQsAbbn3e+8bAAsE54Q2K+Xld6rSfG
	 c15VyIqmLB43T7gnvBczfEPsH46z2uZ06LgmTrEUu2+YevtpvusWM0YKcg7Tnb/njK
	 ciLmD7sqcmCnA==
Date: Thu, 12 Nov 2026 07:34:37 -1000
Message-ID: <5ee521022dea895eafcda3124d7b00ad@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, liwanwu@kylinos.cn, usama.arif@linux.dev, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 5/6] tools/sched_ext: scx_flatcg: Don't strand a cgroup on the ENQ_RACE path
In-Reply-To: <20261112130934.563321-6-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev> <20261112130934.563321-6-cui.tao@linux.dev>
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

On Thu, Nov 12, 2026 at 09:09:33PM +0800, Tao Cui wrote:
> Instead of bailing out, wait for the picker to resolve and retry:
> grabbing the node when it's stashed back, or bailing out when the
> picker has re-added the cgroup to the rbtree. Exhausted retries mean
> the cgroup is in the common cases either going away with its node
> dropped or already back on the rbtree; a narrow window with the picker
> still holding the node in flight can strand the cgroup the same way
> the unpatched code does, at a rate orders of magnitude below stock.

This doesn't actually fix the race. I can still reproduce the stall with the
patch applied.

Maybe just add a comment noting the race? scx_flatcg isn't expected to be
used for actual usage anyway, and things like this can be done a lot better
now using arena data structures.

Thanks.

--
tejun
