Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755197;
	b=xb/9IHmbCeAz+oLcAj37NszffJ/1DMzkOH7n9csqBwi1GY585gg7Ww3s3LtGGAabR8TB
	 t7ySIRhGK5HvkXl37f0V77QRzhA3Su+cwVdvsPScoJhAQeQkMRu6Wzf/0EXmDN1UQWPBP
	 FJyaWN1G+2qJw2W0mGPrEoZvg2j64AnpzIgQBRD4gNZ4KNhxvIoNTarmZ2lAMS9y8ezUl
	 J3LMRK0eURQvM1l/T7j1bH+j/gr0QjTwOHMaco2N/+xEtgSo3VHAEXHFhvRrpzS+P3HsO
	 oOj83D4jBRs0etcac1WZOUdyxkDNu0we5VqM7jSpqn0eD3o9o0MNuLBe0oFlwtf51tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755197;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=weUeyzsssr8dS91Dxqw4Iq8kFGcygNjrCrPAqehGlCc=;
	b=lQrc1/+0Rj13H6fZ4lIhqnlylzzKF4VtvM6sYrj4zE2oaXJAwX1Qz4ps+qOxCMeHCbWV
	 Fc1/s4XGtKDMz5JMmKWs6F3twPdEtIL2yiOX0Ud0Kh/Znwtbikoq0cDi3eKEqL/FoR6cX
	 kHW+OzSsXtl4pIFa0WaqlxHdQXeIWXq9WR3MDYm3HijPXWXjEVpLV9vRwuHKb71KqxK6i
	 9COtcb+8mkNY54rKN/cPxVFm3yYJfzw4UhUdU9EMNKQiiYQLsdDE5367GL+aeuGoU1ZpP
	 LjgU9faf6Pjy2PF4HsiSRYbCELZz/7cuGT/jR9ghoE5Od8MfFGDTb4KHE7lBuj/eS0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORwiHLMY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C22606A32C;
	Sun, 15 Nov 2026 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORwiHLMY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893241F000C6;
	Sun, 15 Nov 2026 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794755196;
	bh=weUeyzsssr8dS91Dxqw4Iq8kFGcygNjrCrPAqehGlCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ORwiHLMYmxXPyBaOautNu04UKw3d887VJtdDVPax8pPHotHrCmKMkIyvRpu+hEzYy
	 gt9xSGElu9PnvdWQk182cqwkh2M94cHZOAJAu1XhJK10xHtHJvLiNdtp8mL97bUaVp
	 w7L7mx+Y2twfAf4B9+HUNoIoSkKlMy8gpPwzeTtMXF16yWyT41sIinLmdfgbMf3nuR
	 D4aitWGt4WgmiLx5RXKLoZRYDOb+vkVN6DvyrtPPNERciCARX7vvIxtsgBqY2ZHbh+
	 gENgRrBxtRse7T4gzRJ2PIKd5Qn2saK8eSKgo84axX7OFDOef4xKAYbsr2N7wE2Ayi
	 NZ6uTQz9fbjfg==
Date: Sun, 15 Nov 2026 05:06:35 -1000
Message-ID: <598bee2c48b23aee00c404d1183b581a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>, Peter Zijlstra <peterz@infradead.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, mingo@redhat.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 1/2] sched/core: Pass ENQUEUE_RQ_SELECTED on initial enqueue
In-Reply-To: <20261112144935.583937-2-cui.tao@linux.dev>
References: <20261112144935.583937-1-cui.tao@linux.dev> <20261112144935.583937-2-cui.tao@linux.dev>
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

On Thu, Nov 12, 2026 at 10:49:34PM +0800, Tao Cui wrote:
> select_task_rq() sets WF_RQ_SELECTED and ttwu_do_activate() maps it to
> ENQUEUE_RQ_SELECTED so enqueue_task_scx() knows whether ops.select_cpu()
> ran. wake_up_new_task() also calls select_task_rq() but activates the
> new task without the flag, so on the fork path ops.enqueue() never sees
> SCX_ENQ_CPU_SELECTED and SCX_EV_SELECT_CPU_FALLBACK never counts a
> fork-path fallback: a misbehaving select_cpu() leaves no trace in the
> counters, and schedulers testing SCX_ENQ_CPU_SELECTED run a redundant
> select_cpu_dfl() on tasks select_cpu() already placed.
>
> Set ENQUEUE_RQ_SELECTED on the initial enqueue when select_task_rq() was
> called, matching the wakeup path. Only sched_ext consumes the flag.
>
> Fixes: 9b671793c7d9 ("sched_ext, scx_qmap: Add and use SCX_ENQ_CPU_SELECTED")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Acked-by: Tejun Heo <tj@kernel.org>

Peter, how do you want to route this? I can take it through sched_ext too
given that the flag is only consumed by sched_ext.

Thanks.

--
tejun
