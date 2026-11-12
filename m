Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504874;
	b=V6d4+7vbDSM+OtMzpSDUuYWt9EwluZpITVKeQYv7aagpnBqF/c1XjJI0yL8mjiEDyI0m
	 NZgrXsdLvpJRyLF1xGMzBfO55jUJII/93UwmIhlO81VevmAaHh1ZblooTrg7XfnXhBer+
	 WmzBL4YKj6j25gV9oaZJTNhaPG7x7sw8d1l91b9ogYkJu5NyMmssD5HIbsrEqmRu5qZw5
	 Pz8MfE/oWHkVW0O6vZkBZuCFqbVmY1Ho0Ip4F7ExrUI6/HI7mAnO97xcvyeHdVv1fF+zP
	 VJK7K8Fi2EubsT1ZjtGgDiCa0EQdsfU2OhMVfjhLU3IlE4N1xFv37ChYrRYZEQiV4hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504874;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	b=XoGC5/L0lgPCVlOqLGlmvZuzI8d75ItVZ1aA8OWwrfm2Pzt9mWhkT5XsVIVaWBUPwEG4
	 lfPTkVeeV8fUvSfXnQ3Q+ttfT71zelYSFlTCOb9hsBvqehdLCgLwQf8Zkf4wsV8Ax8uLq
	 hMOmKrdB3Bd3aLf+6SYys2Y2E+AweMn/fgFwXdStFkeWy3V0//SwOQNXbnLDqaPu13j1d
	 guK/9SydXTvo0kzZ5ZQBTCxF6csPhI7xqj80eWzwisbd0ZCbFn0dYVUEa6oRPufYuK7n1
	 zhQSzWnUOER/CLqnARa4+2dByWcvDt2/oz2Wxxiygnn57SGspHNWYk2PL0B2aaoqeww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVpxT8zq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40885606DF08;
	Thu, 12 Nov 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVpxT8zq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1891F000C4;
	Thu, 12 Nov 2026 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504874;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XVpxT8zqQAfDLo88wcXRU5mVsAhHSReoJkj5sXzMivddWbuRcYrcSV43P4fVdf6dm
	 aseI8TItU7vtwyErRUglP8iNEnxEFgGgciwIdyEGl7izYlnKy9LT9dHcxNkUt267VP
	 C9kvEYeI/7wIPEduKJnhC1mwPoesYE49fZU1V+bG1tOSRRCYeTJzk5UjlJ2rW5zNZd
	 sj4KjH/FXWCJ5LrVeo8g+Y1TJSRY+Nn0HOp+RlU3lRPJO4e6b7xrZzLKVoKzXxZPcQ
	 bMgbJnvZ8elhSvEBNbzBnXXnS00fdOcw0/VEZYf2eHmdPB6/LpoudTfM8yLyGuJIwP
	 CER3KBVs03sQQ==
Date: Thu, 12 Nov 2026 07:34:33 -1000
Message-ID: <32f1ba66f4cc42e77e88130565f1fac8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, liwanwu@kylinos.cn, usama.arif@linux.dev, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 1/6] sched_ext: Reject DSQ iterator kfuncs in tracing programs
In-Reply-To: <20261112130934.563321-2-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev> <20261112130934.563321-2-cui.tao@linux.dev>
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

Applied to sched_ext/for-7.4-fixes.

Thanks.

--
tejun
