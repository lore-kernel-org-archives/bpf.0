Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A463CB551
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538492; cv=none; b=IORXYJqYAj0AjFRq1tnaqcvBvihfXUXi8EUt54piC3vfE/vchpBKJKZUCWKy3kE7mks1V4EJEE9KLv8//HzX/0Evtio2csHVwgoi/xHuAgWUuxnu7zanriM9f4B7oXxnnNi15Yd3MCjwCqy/psGIhwhXG/gVRAMl85fJeoskZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538492; c=relaxed/simple;
	bh=4G5r9PKsi5wBz7FJZQDjq1pb0/IOWEKBSH2YuhQznLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hiyf5xLQZAoaAS1gSwh37d3hQcgS0pdZHqgzxvtXEc4FZfSS5RWyH9ii+SZFslRhdz+tZJ7iy48SzOG3Dc0MtByEUYF/bN0TrRodpfjT6pXtwUp8XNrIxBZqi/lSjdI+TXq4xuDto8/THmUfDqcRUgev8M1k+t7L7+Eph497uWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR5UYtR/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR5UYtR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1651B1F000E9;
	Mon, 20 Jul 2026 09:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784538491;
	bh=nDXK9FvWGsqSa2PmFa4+Tmucsfpk6QuN5cA8uYOlI7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VR5UYtR/Vf2awZE6laLr/spFgbbg2wtoLqBcUACCJgkrDHgK7mIh5LKuMGbfT/8JA
	 pKx04AmucKRB+x5guxZ1nQg59dGqlZsyCsGISga29QVljo5/gI1IS/a6kViXbxs4+f
	 9TRH/nGe1uj5hV3rjGs9iUQAkE/5EEYHxfB6HKyqt0P+DVBEW8cF6LKqXyzyXa9zs9
	 XJCpfcLSu+Beej2MBjT1dYtckxov9vlx2T6BWmzOqtT4hgzKbUObYPFfKli/2tKoOU
	 mBOKRZm3uba+Iika4C6uy1QTv9g18sbOoWIXbJCsTaxO5xdN/wAKDvSTcrFyJtACYl
	 0uLt/YjaesvXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 7/9] bpf: Factor callchain_finalize function
 from __bpf_get_stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720085351.655075-8-jolsa@kernel.org>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-8-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:08:10 +0000
Message-Id: <20260720090811.1651B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Sleepable BPF programs calling bpf_get_stack() or bpf_get_task_sta=
ck() can corrupt per-CPU perf callchain buffers and trigger preemption warn=
ings.
--

--- Patch [7]: [PATCH bpf-next 7/9] bpf: Factor callchain_finalize function=
 from __bpf_get_stack ---
commit a181c39a42a0e8c840b9a2a09b02e1efa512170b
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Factor callchain_finalize function from __bpf_get_stack
   =20
The new callchain_finalize function calls the build-id retrieval
(if needed) and zeroes the buffer.

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index b990643f25cd8..eea7b781300ca 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
[ ... ]
> @@ -827,18 +840,12 @@ static long __bpf_get_stack(struct pt_regs *regs, s=
truct task_struct *task,
>  	}
> =20
>  	trace_nr =3D callchain_store(trace, buf, size, elem_size, flags);
> -	copy_len =3D trace_nr * elem_size;
> =20
>  	/* trace should not be dereferenced after this point */
>  	if (may_fault)
>  		rcu_read_unlock();

[Severity: High]
This is a pre-existing issue, but can sleepable BPF programs calling this
function corrupt per-CPU perf callchain buffers and trigger preemption
warnings?

When may_fault is true (such as from bpf_get_stack_sleepable or
bpf_get_task_stack_sleepable), this code relies on rcu_read_lock() earlier
in the function. However, on PREEMPT_RCU kernels, rcu_read_lock() does not
disable preemption.

The earlier call to get_perf_callchain() eventually reaches
get_callchain_entry(), which relies on smp_processor_id() and requires
preemption to be explicitly disabled:

kernel/events/callchain.c:get_callchain_entry() {
    ...
    cpu =3D smp_processor_id();
    return (((void *)entries->cpu_entries[cpu]) +
            (*rctx * perf_callchain_entry__sizeof()));
}

Since preemption is not disabled during this sequence, can the task be
preempted during or after fetching the per-CPU buffer, allowing another BPF
program on the same CPU to overwrite the buffer before it is copied by
callchain_store()?

> -	if (user_build_id)
> -		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
> -
> -	if (size > copy_len)
> -		memset(buf + copy_len, 0, size - copy_len);
> -	return copy_len;
> +	return callchain_finalize(buf, size, trace_nr, elem_size, user_build_id=
, user, may_fault);
> =20
>  err_fault:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085351.6550=
75-1-jolsa@kernel.org?part=3D7
