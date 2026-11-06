Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961094;
	b=gIyiOws2Qg+lWTHHSl33jfaKQ0Qkr6oM3WfKxMb+mnRA0XyO3HFab/jgmaLsbazbcZF3
	 f5h4se9bdyphNiyZqqSRUXd/p16jRr51xjTwY+IX3ctlbqUuVfRgNpS1gp5Px+ZieKpZx
	 GcdF28or3aOoOnyrFDcw+kmBAAWO4OxCiJJXMtarP5hqn02XQrz+mB6vt8YP2NmNkkEqc
	 leyAYbegzQtUEQbp2TWes8YU8RjFT+QZNMQczbmbHRafAT8BcH0suw4kwOWZsEYlY4kj9
	 K6YJvbsaTlolgNYEVhE7inmPM1NRse0+BIKHBoI/WYCYMr8/bMh8l255QCczd+8nUbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961094;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=47Ntl1dLCap8ghJf1wKpG20qFI59QF+x/9vztni3aAM=;
	b=fTSenhGS7Ain2dMj8QfvTd1FRQkGYd5A4uKNetTUbaGBrGfLVXP+EaLE66ozRXPB8nyp
	 dTc2LfrZDqBmY4V/pDwWVBGaxo4u6XOZpusIk8SuKutHPpQEjc+ZuhXtuKvBzV9Jwy7z0
	 u/0++LhH5ZHpIK8+LdWKZuOI+PdsMl/MX4iVsD3jdhfDtLhrZGbK/1EU1r8bMiGgbt9Sp
	 6AzZoM5TehLjRn3d2mQ92OxCnGAVN9sb+ipKCUTVnPLXI296btZ0pDORgIWRdzXLx1ZSK
	 vV+1vuioNcg7O0BnEEeiFxJHtQRwmdVxZAnP7HenpFmZ/+o5ePzQMU/ddqBJlJUN13A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QejfiyGw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B326606D801
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QejfiyGw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E2C1F0089F;
	Fri,  6 Nov 2026 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793961094;
	bh=47Ntl1dLCap8ghJf1wKpG20qFI59QF+x/9vztni3aAM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QejfiyGw0ir0/+sS1P9ykH+dHZN88Vl/LILfB5O842kKoBJWUzEsQgds1SpLoe9xk
	 9PZoM2Cdui64DaTWI7P4ZyR4vcKUs2Mlr4b3WSOqR2GiMMYUEUf3ung++fOb37sQdE
	 IElUZua8Yo2Sy45nP1Eha5/Z99EaJhArI/pnfByxQA1kYdfEfzmz7zmGmeMWbKdYPf
	 2B+cqRAYummcguvJMxkIHg5j5QRBXkJPX69jxik1BedY23iUAGgGaz2dP7NOe6wOMZ
	 fMEP/nPu27j7f4jCB1OPgUU/vOUeifOoSso8phYpFWXA2zeRT8kodt0rVMLAd3W9ON
	 jqFg0xKa9Qp/A==
Content-Type: multipart/mixed; boundary="===============2531472142402089686=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <41d66c9d73a1a3da07356eb4fb72463d0dc4e473c32e426b1db0340e23d03c73@mail.kernel.org>
In-Reply-To: <20261106095747.471718-8-luyun_611@163.com>
References: <20261106095747.471718-8-luyun_611@163.com>
Subject: Re: [PATCH bpf-next v2 7/8] bpf: Check bpf_timer value membership before use
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 10:31:33 +0000 (UTC)

--===============2531472142402089686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check bpf_timer value membership before use

TL;DR:
- Timer membership check may mark LRU hash elements as referenced, so
  self-re-arming idle timers could skew eviction
- Nit: new -ENOENT doc line splits the -EPERM text and uses undefined terms

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h

[ ... ]

> @@ -5468,6 +5468,8 @@ union bpf_attr {
>   *		**-EBUSY** if *timer* is already initialized.
>   *		**-EINVAL** if invalid *flags* are passed.
>   *		**-EPERM** if *timer* is in a map that doesn't have any user references.
> + *		**-ENOENT** if the current map lookup does not return this value
> + *		when the membership check is reached.
>   *		The user space should either hold a file descriptor to a map with timers
>   *		or pin such map in bpffs. When map is unpinned or file descriptor is
>   *		closed all timers in the map will be cancelled and freed.

This isn't a bug, but the new -ENOENT entry sits between the -EPERM line and
the paragraph that explains -EPERM ("The user space should either hold a file
descriptor to a map with timers or pin such map in bpffs...").

In the generated bpf-helpers(7) text, that advice now reads as if it explains
-ENOENT.

The wording also relies on terms the helper description never defines ("this
value", "the membership check").  Could the entry be placed before -EPERM and
worded in user terms, for example that the map element containing *timer* was
deleted or replaced?

The same text is copied into tools/include/uapi/linux/bpf.h.

[ ... ]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -1575,8 +1574,7 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
>  		return -EINVAL;
>  	if (!atomic64_read(&map->usercnt))
>  		return -EPERM;
> -	if (cb->type == BPF_ASYNC_TYPE_WQ &&
> -	    !bpf_map_value_is_linked(map, cb->value))
> +	if (!bpf_map_value_is_linked(map, cb->value))
>  		return -EINVAL;
>  
>  	return bpf_async_update_prog_callback(cb, prog, callback_fn);

With the WQ-only condition removed, every bpf_timer_init() that reaches the
membership check and every bpf_timer_set_callback() now calls
bpf_map_value_is_linked(), which does:

    return map->ops->map_lookup_elem(map, key) == value;

For BPF_MAP_TYPE_LRU_HASH, which may hold a BPF_TIMER, map_lookup_elem is
htab_lru_map_lookup_elem() -> __htab_lru_map_lookup_elem(map, key, true),
which calls bpf_lru_node_set_ref() on the element.

Before this patch, bpf_timer_set_callback() had no effect on LRU state.

A timer callback that re-arms itself with bpf_timer_set_callback() +
bpf_timer_start(), as timer_mim.c's timer_cb1/timer_cb2 and timer.c's
rearm() do, would now set the ref bit on its own element every period.
__bpf_lru_list_rotate_inactive() and __bpf_lru_list_shrink_inactive() move
referenced nodes back to the active list instead of evicting them.

Can this make idle entries whose timers re-arm themselves look hot to the
LRU, so that entries that are really in use get evicted first?

The syscall lookup path avoids this side effect by using
map->ops->map_lookup_elem_sys_only (htab_lru_map_lookup_elem_sys, mark=false)
when it is present.  Could bpf_map_value_is_linked() use the non-marking
lookup when it exists?

The same helper already serves wq (7b56ce638391) and task work (36948ba24248)
earlier in this series, and no later commit in the series changes this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42200504781
--===============2531472142402089686==--
