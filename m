Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5503DB30F
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785792652; cv=none; b=fQWAFryEJtgvOOAhGaV5rT8zWcmu24l22YFQ3rnPpo1R/m9I5CL4ESooOS2nKB0sSyS6QchB/C3SNekYzzlmLFmWmp2qb6RcEbGWGWDNPlo+Dd0jQN+jw3Ubmr4jA3GN7kvQz28h+epe6Z1eQ32EPOmhD4cJ2CGrEQ1H/pMNVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785792652; c=relaxed/simple;
	bh=SfnHkZr6+ITwXJ4Mynm4PrM3BDMIXDL+LHUwzqcNfNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YQ/picv+jW7F9B4ePePDxh2MKZyqft8IowVwgkiwmcZiZBz/Rw5QCIvowT9LdYAi6o1Zb8BBeO4dEuFR8lxwL5srotyy4KtMQCEVTRL5An/j4vwyNs7UnbPGbWQ4Y2nSVT+G8hJdxneF2EtxK7E2bKITDbeLCfVJp7AmfPB0yqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3dv8dLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3dv8dLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF301F00A3A;
	Mon,  3 Aug 2026 21:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785792650;
	bh=RAQlKPI+VrsKZozeVh/53DsSFLHFMtUbiYDagmq5y2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3dv8dLBUPkRfer44t+bu89PuoaZHc2ZAlqGRqgvBR0gZq+p2T+lALDjRFjs6s9TL
	 9gMknQW/SSp74iIEudQj4lKWjxi8qR2ohzY6mV3FYUfhbe0aTATEpD3OsKqHYtnyFg
	 I1Kw76BJvWAX+u14cwbNRufn6GbiRw8Ip5I1k+Y23a2YXnQom1HXhX6AXGTGQdGmYU
	 3uHpuBnPTsPzUj0l1xF3If4ovBTehUdx+eMuaPlC7vwziyUFP1ADYXcL+TwYOvc+ff
	 Ng9nNZc3rOacd8AUq26Gg07etEZUqsTETqaBYWY6AwUhtlA849FN3KIvw/7ofdABPa
	 Iv1wubUCXpScQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 bpf-next 06/12] bpf: Factor callchain_store function
 from __bpf_get_stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803210149.296496-7-jolsa@kernel.org>
References: <20260803210149.296496-1-jolsa@kernel.org>
 <20260803210149.296496-7-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 21:30:50 +0000
Message-Id: <20260803213050.8EF301F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A Time-of-Check to Time-of-Use (TOCTOU) data race exists in `_=
_bpf_get_stack` when used from a sleepable BPF program, allowing concurrent=
 modification of `trace->nr` that leads to a massive Out-of-Bounds (OOB) me=
mory read and write.
--

--- Patch [1]: [PATCHv3 bpf-next 06/12] bpf: Factor callchain_store functio=
n from __bpf_get_stack ---
commit 1569be7d337e247b4d7eb8620dff965cc57a3fc6
Author: Jiri Olsa <jolsa@kernel.org>
bpf: Factor callchain_store function from __bpf_get_stack

This commit factors out the callchain storage logic into a new
callchain_store() function. It handles extracting both just-ip and buildid
data into a user-supplied buffer.

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 463f94ba1cc47..e51e03c4b60ed 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
[ ... ]
> @@ -680,6 +680,29 @@ const struct bpf_func_proto bpf_get_stackid_proto_pe=
 =3D {
>  	.arg3_type	=3D ARG_ANYTHING,
>  };
> =20
> +static u32 callchain_store(struct perf_callchain_entry *trace, void *buf,
> +			   u32 elem_size, u64 flags)
> +{
> +	bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
> +	u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> +	u32 trace_nr, copy_len;
> +	u64 *ips;
> +
> +	trace_nr =3D trace->nr - skip;

[Severity: Critical]
This is a pre-existing issue, but could this unprotected re-read of
trace->nr lead to an integer underflow and out-of-bounds memory access?

If __bpf_get_stack() is called from a sleepable BPF program, preemption
is enabled. Between the bounds check in __bpf_get_stack() and this read,
the task could be preempted. If a preempting task running on the same CPU
executes a BPF program and reallocates the identical per-CPU buffer, it
might overwrite trace->nr with a smaller value.

When the sleepable task resumes, this re-read of trace->nr could result in
a value smaller than skip, causing trace_nr to underflow and resulting in
a massive copy_len during the memcpy() below.

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
> +
>  static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *ta=
sk,
[ ... ]
> @@ -737,21 +759,10 @@ static long __bpf_get_stack(struct pt_regs *regs, s=
truct task_struct *task,
>  		goto err_fault;
>  	}
> =20
> -	trace_nr =3D trace->nr - skip;
> +	trace_nr =3D callchain_store(trace, buf, elem_size, flags);

[Severity: Critical]
This isn't a bug introduced by this patch, but this is the preemption
window mentioned above.

The check if (unlikely(!trace) || trace->nr < skip) happens right before
this call. For sleepable BPF programs, preemption can occur between the
bounds check and the re-reading of trace->nr inside callchain_store().

Could we cache the validated trace->nr value (e.g., using READ_ONCE())
and pass it to callchain_store() to avoid this Time-of-Check to
Time-of-Use race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803210149.2964=
96-7-jolsa@kernel.org?part=3D1
