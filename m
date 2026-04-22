Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944411D63F0
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894215; cv=none; b=EcKjptPmoih/Vg+h4WHKIB6fH8VR0onaXHeyuus96MgRNf/DRUge1d3gfzGv88JhmM0qNcMT0L/EySAyf7Sc8Ntb2HuaaStExc3XFm9jH3OXJdEq3OqNV1/C70fxxnrMILt/XGeiAL1uTGz6+bopdAqWHIHFW4UarzE37X5zerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894215; c=relaxed/simple;
	bh=8lDknS+e5iupbtBzakeuFZbEVqQ8CylMsiCFNT4opKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PlggUdRgjBZDx58g4ddeT++vyDq60EWnyxvxkjDB8jgiYfpqqthOJi0kwv2chJNkPsfoino5sDhWAO7t8NupHEyFOwpE8zm0KXH4HDZ2PYhaUrFwfiqnptTRn6qhJ54n1oOYqr/Pe4ywneTO3PnxdhxdI9+SHzFt/eD14EDsVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dauAFVpi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dauAFVpi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4B8C19425;
	Wed, 22 Apr 2026 21:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776894215;
	bh=8lDknS+e5iupbtBzakeuFZbEVqQ8CylMsiCFNT4opKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dauAFVpimJxpd8iym5nwRlWq9nLDyOfi/xtmE9KfKhNXzSOsijuqLKdyOXiD2WIIQ
	 b0Ip0JU+HAkoXBWAMGIAn0FS1r9akD0xn1NSpJ0xknJJg68zLmU+ZEM8E68G9cg9pC
	 bpkySA2uQLk9OAeX+NgCzjxvbjFN9m2eBO7r+/u1K908wE8m7M4iwKmM+HtdHcHUzu
	 YRlKmo8VzwHddemGf/V6lQOWLX+Mb/Cmlp2df4Nx7Wmi8yeHnta0vmA4f8wt+K2H24
	 h+2p0Nm9F4m+/v/Lfatw51qG4wr2OFsUJn0OKINGKMngvz1k/BJFG0zI3K5iNQFRpM
	 uIabAda+gjbVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v12 1/6] bpf: Add sleepable support for raw
 tracepoint programs
Reply-To: sashiko@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260422-sleepable_tracepoints-v12-1-744bf0e3b311@meta.com>
References: <20260422-sleepable_tracepoints-v12-1-744bf0e3b311@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 21:43:34 +0000
Message-Id: <20260422214335.1E4B8C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Adding `bpf_prog_get_recursion_context()` to `__bpf_prog_test_ru=
n_raw_tp()` causes concurrent test runs of sleepable programs on the same C=
PU to silently fail and report success (returning 0) to user-space.
--

commit 222c8798357569a257ba54fe2c8b4e389e16e925
Author: Mykyta Yatsenko <yatsenko@meta.com>
Subject: bpf: Add sleepable support for raw tracepoint programs

This commit reworks __bpf_trace_run() and bpf_prog_test_run_raw_tp() to
support sleepable BPF programs by using explicit RCU flavor selection and
adding per-program recursion context guards.

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
[ ... ]
> @@ -748,14 +748,35 @@ static void
>  __bpf_prog_test_run_raw_tp(void *data)
>  {
>  	struct bpf_raw_tp_test_run_info *info =3D data;
[ ... ]
> -	rcu_read_lock();
> +	if (info->prog->sleepable) {
> +		scp =3D rcu_read_lock_tasks_trace();
> +		migrate_disable();
> +	} else {
> +		rcu_read_lock();
> +	}
> +
> +	if (unlikely(!bpf_prog_get_recursion_context(info->prog))) {
> +		bpf_prog_inc_misses_counter(info->prog);
> +		goto out;
> +	}
> +
>  	info->retval =3D bpf_prog_run(info->prog, info->ctx);
> -	rcu_read_unlock();
> +
> +out:
> +	bpf_prog_put_recursion_context(info->prog);

Does this introduce a regression where concurrent test runs of sleepable
programs silently skip execution and report success?

For sleepable programs, execution can block. Even with migrate_disable() he=
ld,
the task can yield the CPU while the per-CPU counter from
bpf_prog_get_recursion_context() remains incremented.

If another userspace thread executes a test run for the same sleepable
program and is scheduled on the same CPU, it will read the incremented
counter and falsely detect recursion.

This causes the second run to jump out and skip bpf_prog_run(). Because
info->retval is initialized to 0 and no error is returned, the test run will
silently succeed and copy 0 back to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422-sleepable_=
tracepoints-v12-0-744bf0e3b311@meta.com?part=3D1
