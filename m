Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9422D247291
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794781; cv=none; b=sIdAI6OG9ncfG3ubfGk0le4IDsWQpECzn1d6OgLUOoMgQ+k/zdvl+V5Mxv7/Ua2z2KzKlcN1WhCvZ/ez3Y7zdx85Rdy5kwTWs0Zd20rKVttWew5tbQEB8m7bJtacltSxIX4HSAWvixYBz3T+LeQgX35HsgrxUVMY0sxOeBb2OpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794781; c=relaxed/simple;
	bh=wuxb9nPlKudic/oipknCHPLzHVyQU/slPunuejyoJPg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aS/Mv/LKDaVSzEm48IyoxOpBTl8kjVQwplW4aqUaMbdfvu/bVa9SpfzSal33l4K3gAVgB4PasYTIBKG6nmNOxMWAbLeMerHUWDlTHRaFjmIDkTygKOKdFKwV5BJttJHkMXWlt41V+u214Wn+1QERySSTdELdFfx2tzCP9qwYGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfDiUdk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfDiUdk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B45C1F000E9;
	Mon,  3 Aug 2026 22:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785794780;
	bh=O2Rh1Ew+hfsC1rsO8SNecQEII45ntUBy/ki6BNmIi9o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hfDiUdk6Mf/4NmEKWlIhvmASN9pEMz+wRfdZtV1XTRlU21xVnc4rNuC7VxBHLrna4
	 UDCdbX1OFw49Mkel1XAYdw06njVEO2CjXG4DoaAn3C/xFYtHAbuEJjPfd6OWRBNO14
	 PQVHD41++FAAm5Woh6iDXj2wEp2PHclXm0QIMRQu1tDPCzvRU/Hccui0WIibwDb6XQ
	 CcxbmytUU+NnKCy9y5x+s/zN3VB3HbiOW4cGhUmM6fnzPK7enu7BRbClhTMdIVZK3r
	 gZmQcDOlyx1AwJWLDNCKwqh+s6T0X6SEiUPeBtXoKKyMg9Xi4bbuzDVdDZ1fQUsCd8
	 LdzWVWTmNRRjA==
Content-Type: multipart/mixed; boundary="===============5056360740202259062=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a057664642c66fb41279517055b39100aa5cdcbe7ac2492418d0ed77ac382619@mail.kernel.org>
In-Reply-To: <20260803210149.296496-7-jolsa@kernel.org>
References: <20260803210149.296496-7-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 06/12] bpf: Factor callchain_store function from __bpf_get_stack
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,qmo@kernel.org,chen.dylane@linux.dev,info@starlabs.sg,contact@arnaud-lcm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 22:06:19 +0000 (UTC)

--===============5056360740202259062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Factor callchain_store function from __bpf_get_stack
>
> The new callchain_store function stores trace entries buffer into
> user supplied buffer. It covers both just-ip and buildid data.

This isn't a bug, but could this changelog mention the preemption fix it
is preparing for, the way the next two patches in the series do? The two
immediately following commits (7199cef3355ad and d872b6f929f3e) both
explicitly state they are making things easier for the preemption fix in
a following change, and the series does land that fix in 2c464d58d2665.

Also, 'user supplied buffer' reads as a userspace buffer, whereas buf
here is a kernel buffer supplied by the calling BPF helper. Could it say
'caller supplied buffer' to avoid that reading?

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 5b18d728f4b88..ee9905d67b8ec 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -741,6 +741,29 @@ const struct bpf_func_proto bpf_get_stackid_proto_pe = {
>  	.arg3_type	= ARG_ANYTHING,
>  };
>
> +static u32 callchain_store(struct perf_callchain_entry *trace, void *buf,
> +			   u32 elem_size, u64 flags)

This isn't a bug, but since perf_callchain_store() appends an IP into a
callchain and this one copies IPs out of one, would a name like
callchain_copy_out() (or a stack_map_ prefix, matching the other helpers
in this file) be less easy to mix up? The new static helper is named
callchain_store(), which is one word away from perf_callchain_store() in
include/linux/perf_event.h (already reachable in this file via the
include at the top). The two have opposite data direction:
perf_callchain_store(ctx, ip) appends a single IP into a callchain
entry, whereas the new callchain_store(trace, buf, ...) copies the whole
IP array out of a callchain entry. Every other file-local helper in
stackmap.c carries a subsystem prefix that signals its domain (stack_map_*
for the build-id/map helpers, stackid_* for the stackid helpers added
earlier in this series).

> +{
> +	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
> +	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> +	u32 trace_nr, copy_len;
> +	u64 *ips;
> +
> +	trace_nr = trace->nr - skip;
> +	copy_len = trace_nr * elem_size;
> +
> +	ips = trace->ip + skip;
> +	if (user_build_id) {
> +		struct bpf_stack_build_id *id_offs = buf;
> +
> +		for (u32 i = 0; i < trace_nr; i++)
> +			id_offs[i].ip = ips[i];
> +	} else {
> +		memcpy(buf, ips, copy_len);
> +	}
> +	return trace_nr;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30854471987
--===============5056360740202259062==--
