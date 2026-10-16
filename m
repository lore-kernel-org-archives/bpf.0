Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD62241CB7
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118393; cv=none; b=VTleLkhRPUsRc6zVPuVGao6X2blXQeKNt6xya+SfUBBoJ2BkU42eyIrhRpAdGN5CyIjwx/bxL0H4n01RwVWB8wiObljfk7UWlk9LcERJ2Y93s8UQo0h+84pcZEQ7dd3nj2DdRbuyVoQqzVweIX6VT/1no+6zmvhpY/r2q78hxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118393; c=relaxed/simple;
	bh=br+OrEN7GaTnyM2SAyhjFA18uF7dldFrkdn8thnU2h8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=P6Op0ZeOMtUEEKd8qHiUMYk7y878XLos2NSUiqICR2JH51RKhyYDvk+jR8oZ9gxqEWDQQ5sPKVq30ZV76pbOMQ48VSBc1MGLT7TfB4zSS2fHsqSLqV2M6W40kZSL/X8e28g9FPf8BJ7sMrQkcLqopvm8/W8fbHLqTdFaodWMVnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuguizAd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuguizAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226281F000C4;
	Fri, 16 Oct 2026 02:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118392;
	bh=L0LK51XibYhONI6n8JtydgwCLRvfdPCcGYSrAe4lWsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DuguizAdSvVLEzd9eXjAgYhnBaehuItg20DeMG2zrzkiy/9uBJ7SGsAl3nlVyuT/8
	 Gk+hLyzEaivMUa0/57Y0G2oQfeFS94C3mcT17OdxpmLtJOQBEUUJr+G7suIJmVil/Q
	 UCDjtsP4EmotWYhfxIPygq1JJQ3NIeBOSE7mnEL7dE+stx6mhB4yycWXS1siU1ADC9
	 52xPvoK0pMDmNY6kvrVMip2sIRLT9+K7traNC0g9web4IxqwmcHv0Y5wwj6tEfAyxp
	 Xg5KGpoG6UrFXo+BlCiBWQBzUPX7hIdLXVYoGBZ4w2ZtZnwuKqvMgDsxu8V57AIbZ/
	 mT8K1DB+wAx1w==
Message-ID: <sashiko-outbox-173633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] bpf: Fix stackmap overflow check in
 __bpf_get_stackid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Dinaburg" <artem@trailofbits.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261016023225.19034-1-artem@trailofbits.com>
References: <20261016023225.19034-1-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 02:39:51 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: KASAN OOB write due to missing max_depth < skip check
--

commit 02cac1c9914fa38a62e3ae2d92fc6a6dde2513ff
Author: Arnaud Lecomte <contact@arnaud-lcm.com>

bpf: Fix stackmap overflow check in __bpf_get_stackid()

This backport attempts to fix a KASAN slab-out-of-bounds write by capping t=
he
stack trace depth in __bpf_get_stackid(). Since the helper function
stack_map_calculate_max_depth() is not available in 6.6.y, the logic is
open-coded.

Link: https://lore.kernel.org/bpf/20251025192941.1500-1-contact@arnaud-lcm.=
com

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index a330f38ae7335..04d873f1a552c 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
[ ... ]
> @@ -225,7 +226,12 @@ static long __bpf_get_stackid(struct bpf_map *map,
>  		/* skipping more than usable stack trace */
>  		return -EFAULT;
> =20
> -	trace_nr =3D trace->nr - skip;
> +	curr_sysctl_max_stack =3D READ_ONCE(sysctl_perf_event_max_stack);
> +	max_depth =3D map->value_size / stack_map_data_size(map);
> +	max_depth +=3D skip;
> +	if (max_depth > curr_sysctl_max_stack)
> +		max_depth =3D curr_sysctl_max_stack;
> +	trace_nr =3D min_t(u32, trace->nr - skip, max_depth - skip);

[Severity: High]
Does this code risk an unsigned integer underflow when calculating
max_depth - skip?

If sysctl_perf_event_max_stack is lowered concurrently to a value smaller
than skip (which can be up to 255), max_depth will be capped to this smaller
value. The expression max_depth - skip would then underflow to a large
positive value.

This would cause min_t() to select trace->nr - skip, neutralizing the inten=
ded
map capacity limit. If trace->nr is populated from pre-recorded perf event
data captured when the sysctl was higher, trace_nr could exceed the bucket
capacity and result in an out-of-bounds memcpy() write onto the heap.

It appears the upstream commit included a check to prevent this underflow,
such as returning -EFAULT if max_depth < skip. Should a similar check be
included in this open-coded backport?

>  	trace_len =3D trace_nr * sizeof(u64);
>  	ips =3D trace->ip + skip;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016023225.1903=
4-1-artem@trailofbits.com?part=3D1
