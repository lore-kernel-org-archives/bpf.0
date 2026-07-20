Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4E3A9624
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538442; cv=none; b=d68H7DxPTqBlDUuJn8iiSmMl2Aa0hO/UQqmZNphMlPsQ2lfMRd6XPmZRg2UTHBvfRhgwBxvcgJRHwDO4iTOnyjTg6cqeUYC8FfO/EEjbrQdl3pDqmmIkQcr3q5ftSA5Kiyw7urL8C2rZZtt8Z3DMwh4CqB1Z36VLOOkP7faJa74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538442; c=relaxed/simple;
	bh=uHDHf2cmebgBp9gOmiZaJQ1C3/62qtQXnYNxfsA0dOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jRSqnQtEJb/Gdc0pL7qqtu3JY7XOtK43dmvT0THKJyN8xUE7IeW2UfiSKLQeg/x7lxKwfcHKmBags8JMQVWHSknkLyIjiNt9FUFm0Whe1NMk9y7AAOCo9/yjftylbFol8nADQgYrqaXvKk5zl3m3y6LiPR7sQ+Ce+Vfe8jVs6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/xQZ/Aa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/xQZ/Aa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D26B1F000E9;
	Mon, 20 Jul 2026 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784538441;
	bh=sMzzEcShb57NAkG7w6uh28MYuzYXSU2uMay1P5ZbQwQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c/xQZ/Aa15jSY9XwIVC9zQCQiNbxWGDGgfE8NrFrXsOVRKtQdr50i3P2SiDAzX6XE
	 R8pwkMlVlGtDfe60WsyhgQ7jzpQHpWze65jOIvV2QerrRljGLUj5pw9C1R1hqHO6ci
	 8Hek8Ay99bkcsJkdR2pctb5PwP3jPvANNNy8UEtKUwGbZOQeq5Q/18/rRUsmEAHwUR
	 DPhFIRV71VGFIjhObKPqAkehphTL1dlsQ4L24J53G9ElW0zYAYd6oykBgZ9o0lhfqJ
	 ER7Xz9oXbTbYa5VRw+nmjhXeumfcrXAsVzO8P5iF1lBRCeQFu/71WvSUfHfsieSAM2
	 kkjTb+oAE82aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 6/9] bpf: Factor callchain_store function from
 __bpf_get_stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720085351.655075-7-jolsa@kernel.org>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-7-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:07:20 +0000
Message-Id: <20260720090721.2D26B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The 'size' parameter in callchain_store() is unused.
--

--- Patch [6]: [PATCH bpf-next 6/9] bpf: Factor callchain_store function fr=
om __bpf_get_stack ---
commit aee65ba10526fcf4c6320ea660fc50a555551cc1
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Factor callchain_store function from __bpf_get_stack

This commit extracts the logic for storing trace entries into a user-suppli=
ed
buffer from __bpf_get_stack() and places it into a new helper function named
callchain_store().

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index a64b14ffd1e8e..b990643f25cd8 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
[ ... ]
> @@ -747,6 +747,29 @@ const struct bpf_func_proto bpf_get_stackid_proto_pe=
 =3D {
>  	.arg3_type	=3D ARG_ANYTHING,
>  };
> =20
> +static u32 callchain_store(struct perf_callchain_entry *trace, void *buf=
, u32 size,
> +			   u32 elem_size, u64 flags)

[Severity: Low]
This isn't a bug, but the 'size' parameter doesn't appear to be used anywhe=
re
within callchain_store() in kernel/bpf/stackmap.c. Could it be safely remov=
ed
from the function signature since the bounds checking is handled in the cal=
ler?

> +{
> +	bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
> +	u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> +	u32 trace_nr, copy_len;
> +	u64 *ips;
> +
> +	trace_nr =3D trace->nr - skip;
> +	copy_len =3D trace_nr * elem_size;
> +
> +	ips =3D trace->ip + skip;
> +	if (user_build_id) {
> +		struct bpf_stack_build_id *id_offs =3D buf;
> +
> +		for (u32 i =3D 0; i < trace_nr; i++)
> +			id_offs[i].ip =3D ips[i];
> +	} else {
> +		memcpy(buf, ips, copy_len);
> +	}
> +	return trace_nr;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085351.6550=
75-1-jolsa@kernel.org?part=3D6
