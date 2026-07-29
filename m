Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181DC3C1A
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785315473; cv=none; b=oDlw5hKw9M97BjgpHgli1Kkf+OVArSvdx4ZMOrSdugEygKk6b6XEoArnYBnfkkglpZJSBemzSayL7W7dYHMSOHBS/chFza1fzGB9wNSHTDHSqyZbD9H2AZpUYQs18NEpqUtuWxHjiGzcWeb3bG6kia0Wua1O3+pD9pshCVu3BpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785315473; c=relaxed/simple;
	bh=fnIQAXL4alq03Nqr2+G3yIJSdn0M3kXVJxU0PHPRBmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dmcnyqWdwmNLGlSLh1X4WJAMs2WPkCBs/MmynKd7Yq1mbjMBvoG73/b7FbD9PxmDY9Db7GTK1yuz/bULa5WPbBCMQKRvOOLz7o5q7CkJ4J/PfYz29/yaIK1MCRIkioMGgeX5vM/TPBI0+4a/voqcNdXsF8Q4CEgUA2pu5LwSOY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsZ8QaAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsZ8QaAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C341F000E9;
	Wed, 29 Jul 2026 08:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785315471;
	bh=Sau5WZghNArZYZ3jPslZzqCsa/bRMIsImetgbzRp5b4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bsZ8QaAAFEwSqYS+xBThROA3H4gsT4aAiV5FG4d7n0asayQnyeTYmcNfxpvSr8C8e
	 aF2t1uuMEmIbb8kFNknAuulsFpbvvQyZIFYtZuQZAsTwtvzr4NPzBo6q7aYZr9Hl+j
	 3qzBIKwdo76cKs8Iof01/N9b+iogWCu4kre9Zjw1a0Trb3ofL6IkYIg1chx/Qy/EMw
	 /1lrFCeBLAS3PnmzIrYF0F/L2GfYup1O+Ioz4TfMSXDwlMybh99Bw519dKyMaiua8b
	 UvHZIXmVUgSeO+jNj625sUfAxlaLugqPzw8mDfBkjym6aYfNfXILUQtqLnVjx+89vN
	 IXvtKPA/S/8WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next 06/11] bpf: Factor callchain_store function
 from __bpf_get_stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260729083807.1588544-7-jolsa@kernel.org>
References: <20260729083807.1588544-1-jolsa@kernel.org>
 <20260729083807.1588544-7-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:57:51 +0000
Message-Id: <20260729085751.96C341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Preemption can cause `trace->nr` to be modified concurrently, =
leading to an integer underflow in `trace_nr =3D trace->nr - skip` and a ma=
ssive out-of-bounds `memcpy`.
--

--- Patch [1]: [PATCHv2 bpf-next 06/11] bpf: Factor callchain_store functio=
n from __bpf_get_stack ---
commit 41f5133836d848295ac407c006940d4f0641b50f
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Factor callchain_store function from __bpf_get_stack

This commit factors out the callchain storage logic from __bpf_get_stack
into a new callchain_store function. The new function handles both IP and
build ID data copying.

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 41fe87d7302f2..18d1a10bf76e5 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
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
This is a pre-existing issue, but could this calculation underflow if
trace->nr is modified concurrently?

Looking at __bpf_get_stack(), when called from a sleepable BPF program via
bpf_get_stack_sleepable(), it calls get_perf_callchain(). This allocates
a per-CPU recursion buffer but unpins it by calling put_callchain_entry()
before returning.

__bpf_get_stack() then checks if trace->nr is less than skip:

	if (unlikely(!trace) || trace->nr < skip) {
		if (may_fault)
			rcu_read_unlock();
		goto err_fault;
	}

If the task is preempted immediately after this check (which is possible for
sleepable BPF programs under CONFIG_PREEMPT_RCU, as rcu_read_lock() does not
prevent preemption), could a new task on the same CPU trigger a BPF program
that reacquires the same level-0 recursion buffer and overwrites trace->nr
to 0?

When the original task resumes and calls callchain_store(), it re-reads
trace->nr. If it is now 0, wouldn't 0 - skip underflow to a massive unsigned
value?

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

If the underflow occurs, would this result in a massive out-of-bounds memcpy
that could overwrite the BPF stack buffer or map value and cause memory
corruption?

> +	}
> +	return trace_nr;
> +}
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729083807.1588=
544-7-jolsa@kernel.org?part=3D1
