Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4733D1CAA
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538253; cv=none; b=mf8thA9/KMJrQFZjQHqUGtU3NON7NSW6tHosRlChyINHsfKK6jL9M2P0PrKtvWC5pOYC0GIp+lBssX0zEr4FICKecfaX1Re/nz05GvSx22+1k/GPa7OCwG14hb4wXwm8e+urOB6XNm06rN4QNllvWcue8pdE00qlF66TLaVMol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538253; c=relaxed/simple;
	bh=DSW7z/rLoS518NX/TmF82geXEzyghH3fOLonN8YL5Yw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K2sDIa3Cr3MPon6U2eFXJ9l+hJdUhwJYBFC5NL2aFluZLz3MLfVhCUjpPLNsTKfLRGBccdG4PJrUt4FgtXjwG/Vl43bqO43T1A12cjKBxFRHntZU03+io7RoGJcJmlAJXUmqwCn4m5Fg1qUBVfnKZkyzxCIg3b/n9srHXn89XfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgXvyeGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgXvyeGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E931F00A3A;
	Mon, 20 Jul 2026 09:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784538251;
	bh=ui2z/08eoPMFeRnoHSeltVGquoY7f7jIlwS6PiCsuCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lgXvyeGFCC4CLpZfhVmHJFY7ypNcAiOGd4uFB4ey7CmQhNMKCjf04E2Gbnf6PR+Tk
	 gyqj5HI+4x5uV1EOG2hRPJ2PU1Iwlb9f9LEdwNdhEop8o/KOncK1U57ZDKWTFAHoTX
	 tJJWeEmAyAfiU0jTVlC5LKKwc6X01jfEV8B8ZMlhzGRlvAxTFu5xAl1pMWtwdYC4vG
	 R9Hyn29cmuI9dxCNZDRf8JTCeGycWPM8d2PeWvRv4WI72jjgpkm0P7Bz3m6dhyPQQ8
	 YXZVSofed9u1bt5R9Fnep9mL0zP0WxaSXlMoCzpxLfdgyaOS9OeNJ+2f8qyCieJg+0
	 au/UJbyfV7HaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/9] bpf: Disable preemption in bpf_get_stackid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720085351.655075-6-jolsa@kernel.org>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-6-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:04:10 +0000
Message-Id: <20260720090411.61E931F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for preemption vulnerability in stack helpers (__bp=
f_get_stack)
--

--- Patch [5]: [PATCH bpf-next 5/9] bpf: Disable preemption in bpf_get_stac=
kid ---
commit eb097d7647defa7379264dcdf95711bc573a419a
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Disable preemption in bpf_get_stackid

This commit adds preempt_disable() and preempt_enable() around the
get_perf_callchain() call and trace buffer usage in bpf_get_stackid()
to prevent the per-CPU trace entries buffer from being corrupted if the
task is preempted.

Closes: https://lore.kernel.org/bpf/20260206090653.1336687-2-chen.dylane@li=
nux.dev/

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 83efd5892d907..a64b14ffd1e8e 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -625,30 +625,37 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs,=
 struct bpf_map *, map,
>  	struct perf_callchain_entry *trace;
>  	struct stackid stackid;
>  	bool kernel =3D !user;
> +	int err =3D -EFAULT;
>  	u32 max_depth;
> -	int err;
> =20
>  	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>  			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
>  		return -EINVAL;
> =20
>  	max_depth =3D stack_map_calculate_max_depth(map->value_size, elem_size,=
 flags);
> +
> +	preempt_disable();
>  	trace =3D get_perf_callchain(regs, kernel, user, max_depth,
>  				   false, false, 0);

[Severity: High]
This isn't a bug introduced by this patch, but does __bpf_get_stack() also
need this preempt_disable() protection?

__bpf_get_stack() has a similar pattern where it calls get_perf_callchain()
or get_callchain_entry_for_task() and dereferences trace->ip via memcpy().

While it uses rcu_read_lock() when may_fault is true, on CONFIG_PREEMPT_RCU
kernels this does not prevent preemption.

Could a preempting task trigger another stack trace on the same CPU before
the memcpy() finishes, overwriting the per-CPU buffer in __bpf_get_stack()?

>  	if (unlikely(!trace))
>  		/* couldn't fetch the stack trace */
> -		return -EFAULT;
> +		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085351.6550=
75-1-jolsa@kernel.org?part=3D5
