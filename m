Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D63FD12D
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922839; cv=none; b=n8LijVZAw/A51cRoTZlvFfe3aSsAj1FiXde0yO8cxcZmwNSUiwFK7YzmICFzu8fKAXc7ZJb0SuqetA26fBObmzV9Zl5pP/fG6iVbleCzfRC21GCvLi+vGmDSUUstIKwfxnTnoKvRz1ly4YVJ50mQgjaj0NRcSrKAOPh+WivaqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922839; c=relaxed/simple;
	bh=0b5Al9Z10dkeqHgU5oQfqKnmr0Mo3Nhb12defrrYj2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ocle5ix7ju63xgrINLiCClatu44Ol5vkb1HbQMwPEaNUQsKEJjBL2sJPB8JyG+A+I7sN8+CDPZ441nSTxoWWovWnhX8cf+n1WyeYExDR0+jZe1JdkgtA+s36TvuyLPHvHlZP/OVcZgD+n1vWI1z2FxKERhKVu/3gs5G8U5nxmQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOv3AXoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOv3AXoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F0C1F000E9;
	Wed,  5 Aug 2026 09:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922838;
	bh=Dir+iJSxqwVr3O/g3/GfC7V3+VkejD073x+TZW/w28A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SOv3AXoWU7En1zXE6CD8NfJdssfK3HsWuMf7OxGTwdgOOwbxcN1G91Jz0gFYbnmEp
	 bGRuvcqDQ5I1XMy0gL2wSxsBmO9xmHccR6BiiPcesqtmhoisLn/uXBIQXKxOiNEscH
	 sY+SgHlEkEUMDTuvTq9XmAemfRG2bFST4QxqjfICnQfqXVewClER7dp8wzKpPSwBb3
	 kWzNzBektcPJ9CV8f3cudDPcZy8CqRpYbbVR9ZzbUZODOWpu8T6i+vUDIduPPHfF5I
	 Q2cIKmhp4rgOFYzcaLWTxX6lTdQ9G9vEwvY7VxKiThyNCSf/0BD7WW2H4xKc0Vvvv5
	 BSRZtm99/ZAyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 bpf-next 01/12] bpf: Factor stackid_init function from
 __bpf_get_stackid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805092843.516315-2-jolsa@kernel.org>
References: <20260805092843.516315-1-jolsa@kernel.org>
 <20260805092843.516315-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 09:40:37 +0000
Message-Id: <20260805094038.50F0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer underflow in stack_map_calculate_max_depth causes a heap b=
uffer overflow when sysctl_perf_event_max_stack is concurrently modified.
--

--- Patch [1]: [PATCHv4 bpf-next 01/12] bpf: Factor stackid_init function f=
rom __bpf_get_stackid ---
commit 036b334d8e7b51a2339ee19596a116e90ed56c01
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Factor stackid_init function from __bpf_get_stackid

The new stackid_init function stores all the necessary bits for stackid
trace and it will be used by other functions in following changes.

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> +static int stackid_init(struct stackid *stackid, struct bpf_map *map,
> +			struct perf_callchain_entry *trace, u64 flags)
>  {
>  	struct bpf_stack_map *smap =3D container_of(map, struct bpf_stack_map, =
map);
>  	u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> +	u32 max_depth;
> =20
>  	if (trace->nr <=3D skip)
>  		/* skipping more than usable stack trace */
>  		return -EFAULT;
> =20
>  	max_depth =3D stack_map_calculate_max_depth(map->value_size, stack_map_=
data_size(map), flags);
> +	stackid->nr =3D min_t(u32, trace->nr - skip, max_depth - skip);

[Severity: High]
This is a pre-existing issue, but can this max_depth - skip calculation
underflow?

If sysctl_perf_event_max_stack is decreased concurrently,
stack_map_calculate_max_depth() can return a max_depth smaller than skip:

kernel/bpf/stackmap.c:stack_map_calculate_max_depth() {
	...
	max_depth +=3D skip;
	if (max_depth > curr_sysctl_max_stack)
		return curr_sysctl_max_stack;
	...
}

This would cause max_depth - skip to underflow to a large integer. If
trace->nr (which may have been captured with the older, larger sysctl) is
greater than skip, it passes the early return check.

The min_t() call would then select trace->nr - skip, which can exceed the
stack map's element capacity and lead to a heap buffer overflow later when
copying entries into the bucket buffer in __bpf_get_stackid():

kernel/bpf/stackmap.c:__bpf_get_stackid() {
	...
		memcpy(new_bucket->data, stackid->ips, stackid->len);
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805092843.5163=
15-2-jolsa@kernel.org?part=3D1
