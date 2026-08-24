Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16671377EA7;
	Mon, 24 Aug 2026 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590498; cv=none; b=qjjRgL4U0Dq6SGgJrHjGNBVraXY/jiM/1gQCgljnkDbHSWd+Lp1YatHbAw4RA6Zxs5ydEPplugkJubKEcZ54Vjm5NrRrDSrdobYRCaOxhefmVC7Q0Mvt0bYVkVrNv+k787ra0ReYXEQLoUQ86VlkKmVEKoIaGXKLmSE9VPpWnAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590498; c=relaxed/simple;
	bh=/lqiw1NJh/Yb5p1qWHuE47wYZY4QW2ip+Vl1UQ1DRV0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Gf49K9EZrkgyBHtB9IZt4igEOPciXjs2WGonRubX8SmZ4EgqXiCUNLTN2a4f93vDQJfv8uszhaaHIYdxqbIVnYkauyqvnKbdK+AL+iZK0nLGYq2kX49MpOfwCDq+xfvXziECF72uTV2yb3myO3BVsIy2sjWFBnjb45p9hjS6S8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAuKRD1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAuKRD1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769081F00AC4;
	Mon, 24 Aug 2026 16:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590496;
	bh=YA5DK6mKhujUxdthBvMWZ+u4S6w37MYXZOMmqOdb73Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XAuKRD1P8CMoNKICONOg+E7kCOzQOpI6K4wuaQZO0adZoIlm+HWO9TsYliGZf1HQN
	 +AnMqJKw9g80UyJyiij2T5Y+fagRf0TUoyukMWsKv+ruMGT6BTZyctWa/aoayTwVTv
	 ZeBgnGWQVaLqsi1Gy7jHgYnUMDWPgVBryKDaSZFxEYTnUmiNPTVyvgAeFtqPqyMCrY
	 UcRr+gzv383RKzhkLKNF38W6TdxltFuSdr0Dcu0e1rDZS0EzMQRf8Ro7A+BRint1p1
	 bKjbL8v9md3jjOFrWL0lJcBsG6kICrwmaS3HH7zS8quWX894H1EDuPr/odW3jgCbNq
	 y1O2EmUb/esuw==
Date: Mon, 24 Aug 2026 06:54:55 -1000
Message-ID: <20eb5e65cb330a6f9cc41781af302873@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 suzhidao@xiaomi.com, emil@etsalapatis.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: [PATCH v2] sched_ext: pass the initial cpu.idle state in scx_cgroup_init_args
In-Reply-To: <20260824142817.568085-1-cui.tao@linux.dev>
References: <20260824142817.568085-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello, Tao.

On Mon, Aug 24, 2026 at 10:28:16PM +0800, Tao Cui wrote:
> +
> +	/* whether the cgroup is configured idle via cpu.idle */
> +	bool			idle;

In sched_ext, a bare "idle" reads as CPU idle state (ops.update_idle(),
idle cpumasks, scx_bpf_pick_idle_cpu()). cpu.idle is the cgroup analog
of the SCHED_IDLE policy, so please name the field sched_idle instead.
Renaming tg->scx.idle to match would be nice too.

Thanks.

-- 
tejun
