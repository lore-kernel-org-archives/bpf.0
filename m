Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8713F327D
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373483; cv=none; b=lw3Qlrlvx6yTVQqtSpjC6K8t+ebZWsKYkaSWMCrKhL4TPgWjqa5ReH4wl87wV4QoEOFjqLvtoWjDo+0KOnsZG9uvGM/CCi2ZJsNXmXA328CPE8Ui7F+Zat3HP3X86Y2lldx7ghB0eYmaSygTp2LXAjP9KntRTlsiiiALsIOT92w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373483; c=relaxed/simple;
	bh=LzNKOOtsB7XvUNiX+ePEJ42beuiwVnk8QTEK2XnY39s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HJHscxMsfETD8Ee/psMkVr9Fl/3c/ripp7RXvP1rR0wo+TYODuyjQE/JF6TMOQ6v9zcEz718ZYdqUE9H7h4MASeJrBMeyRol2/8SAOjLXxz49j5AswP0khE4xJU6LoY8jAV3nzE7V0PIqzDoZCLomRpHreOzMfLGZllNjQXTjfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSdg3oVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSdg3oVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB301F000FF;
	Mon, 14 Sep 2026 08:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789373481;
	bh=D2T0coOxde1+vHpNWOoD68p5jIgCFkQDORBG0Hgvjv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lSdg3oVAp4i5+oZZdWF/TaT6buDkgSXmqEQHLnbaGq60+Kq7BvUxgOjquq8oAasq7
	 Js+5oaQP/YOJw7dRS4gAewZmwG1oAZZjzs9Qkb1EX10u28YO+lHxSxqZoRESvwnxRy
	 eaiLkG5q1+QQNHH2T2uBIj3DuV8uZpJjUL1I9wn1r+GZoNyBS/06LeHm+JJ7HCkro0
	 FC9PBGBVlsNjR6iHk8Zy9mQrHAAAT6XpyJIncakInCrZ3DgbzlrFHvIrFauFxY/Z6L
	 7wOfaz+rPmec6m+Ns6Iu2DFwTngzc5w/ZSCH5MyfHGqyzfcmFXt38JjiL9+vtBW2Oo
	 hxbwoG/Q5K0qQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/5] blk-iocost: add iocost_ioc_tick tracepoint
 for per-period device summary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: tj@kernel.org, bpf@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20260914073356.791518-4-cui.tao@linux.dev>
References: <20260914073356.791518-1-cui.tao@linux.dev>
 <20260914073356.791518-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 08:11:21 +0000
Message-Id: <20260914081121.7EB301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The tracepoint `iocost_ioc_tick` uses `div_u64()` with a 64-bit di=
visor (`tick_dur`), which implicitly truncates the divisor to 32 bits and c=
an cause a divide-by-zero kernel panic.
--

commit 1f0b986a96c58d14982b08bd292007816d7d5b50
Author: Tao Cui <cuitao@kylinos.cn>

blk-iocost: add iocost_ioc_tick tracepoint for per-period device summary

This commit adds a new iocost_ioc_tick tracepoint to the blk-iocost
controller. It emits the overall controller state once per period from the
tail of ioc_timer_fn(). This allows observability of steady-state and
dormancy conditions without needing drgn to read kernel memory.

[ ... ]
> diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
> index e772b1bc60d60..ec5d9c453d55a 100644
> --- a/include/trace/events/iocost.h
> +++ b/include/trace/events/iocost.h
> @@ -178,6 +178,52 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
[ ... ]
> +	TP_fast_assign(
> +		__assign_str(devname);
> +		__entry->cur_period =3D cur_period;
> +		__entry->period_us =3D tick_period_us;
> +		__entry->vrate =3D tick_vrate;
> +		__entry->busy_level =3D tick_busy;
> +		__entry->nr_active =3D nr_active;
> +		__entry->usage_pct =3D tick_dur ?
> +			div_u64(usage_us_sum * 100, tick_dur) : 0;

[Severity: High]
Could this lead to a division by zero kernel panic?

The div_u64() function expects a u32 divisor, but tick_dur is passed in as a
u64 representing a time delta in microseconds. If the system experiences a
long delay (such as a ~4294 second pause from a VM suspend/resume or a
debugger session), tick_dur can be a multiple of 2^32.

In that scenario, the full 64-bit value is non-zero, allowing it to pass
the tick_dur ? safety check. However, the implicit cast to u32 inside
div_u64() truncates the lower 32 bits to exactly 0, which would result in a
divide by zero panic when the tracepoint is evaluated.

Would it be better to use div64_u64() here to safely handle the 64-bit
divisor?

> +		__entry->running =3D tick_running;
> +	),
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914073356.7915=
18-1-cui.tao@linux.dev?part=3D3
