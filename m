Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDA36DA14;
	Wed, 19 Aug 2026 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787168942; cv=none; b=MAK4RkvyDUjh6Ggb+m/eM4Zrn/bnZLf2zuFlpd069L0vLbRTmsb6Tq1mpRxPhXN92Hx/pKY0SIs5Uevc7NHYVYpoQjaQdfyboasXJ4z46lzojA4LjpbA7lOUitT/SQTNsNW9ik6+JI0Ec3zjmm7ol9PI25FQICpWSDBzl6VAhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787168942; c=relaxed/simple;
	bh=JyE9x7cXkwrSsZzt+/aRirCd95ty1wWbupZ4ZRQbRGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlw0wdpEXjHKpVcvmE1m/wexb9Z3yhAx0h40i5sGTlEfRXeHvMqUg545lziYBofSIzwdhYhnrQ3IKfTmkuSKMzNWuPawI+dIcew9djcg4NQ5FVI1l0+3XvbIAFI1kvpVq+Yom++hIvPayBddBGiccq0ihGit1BbYE8zsDls/x/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvkIXW69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvkIXW69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874551F000E9;
	Wed, 19 Aug 2026 19:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787168940;
	bh=XfeZJd9fXnBmuXGRHztCBpLwV/tkKcdZ0yLGID9DHG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LvkIXW69lauoSwueX0qWqInb+OdvHA6E0a456fdQQSX7SUiFiidtUHaCz0bC97Nm1
	 e2O3bwFosI9KXGlDsb6r3yAet+MCJLo4QKRx1cFENH9MEcwL+aLXTchVv+dFHpGG8n
	 7eTNftFx5LkdHd+wVv5FQ78ID9c7zD73lahkaE5pLW2Mn8UUJ0JWV9ydg/ERNMQyn0
	 58VOfk9GA07MAsToQ7c3DSbjVzMF177E0feq3AtF1OQO45fcwoOEAcclo5e2IMXDzV
	 HnwvLDQThqlURaEZHOT0hOGulD+NdJU1HXW9RNIF7ntOgwgQL10+vqFpo6m/DaOHwW
	 /ECsNqzEY/+7Q==
Date: Wed, 19 Aug 2026 09:48:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2] docs/sched_ext: document that cgroup CPU knobs are
 scheduler-dependent
Message-ID: <aoYIq-QwrSBagFB7@slm.duckdns.org>
References: <20260819012157.220932-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819012157.220932-1-cui.tao@linux.dev>

Hello,

On Wed, Aug 19, 2026 at 09:21:57AM +0800, Tao Cui wrote:
...
> +The fair class enforces cpu controller knobs such as ``cpu.max``,
> +``cpu.weight`` and ``cpu.idle`` in the kernel. sched_ext only passes
> +them to the BPF scheduler through ``ops.cgroup_set_weight()``,
> +``ops.cgroup_set_idle()``, ``ops.cgroup_set_bandwidth()`` and friends.
> +Whether and how a knob takes effect is up to the loaded scheduler: if
> +it doesn't implement the corresponding callback, the knob is ignored.
> +For example, none of scx_simple, scx_flatcg and scx_central implements
> +``ops.cgroup_set_bandwidth()``, so with them ``cpu.max`` has no effect
> +-- the cgroup runs at unlimited CPU with ``nr_throttled`` staying
> +at 0.

SCX doesn't have nr_throttled routing right now even for scheds that
implement cpu.max (scx_lavd is the only one right now AFAIK). I'd keep the
documentation more concise and generic. I don't think listing schedulers
that don't implement the feature or specifically pointing to nr_throttled is
all that useful given that most schedulers don't implement it right now.

Thanks.

-- 
tejun
