Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873BE37DEAF
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513721; cv=none; b=MyTHqrq3NZLCBh2YX9FuJ5RdOMmHs/H8XSSHKc04JiVGdgNhXrzCIU5Rie/jvAhwcgaSMozDHsWJbOaHLRP4lxCdLM7bomOJLAg5TeE1mY3DZ2vCP4mY9+o8+c6LQjyiFaoKM6gxRv7lFmabCpvddEOLQ3pS59lqZyn+keMGahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513721; c=relaxed/simple;
	bh=9sRvDcxe23upaWSUmUumDJ0eXxQS3ASVNHYvYp8xLFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aW+3LWy0D3In9+U5eM3TMcP9AX66w9uiePC0xi9sZrZmnnJpUdF5VMwOYgpFmJ1ewyzcpzBRY061bl1gGVKmD+VMZnko9ij5K5Of6v7cQ4pncxDYyjyZ5vPK/fsceHY0OEwmkzTaaZ1q1XQIb4KRzf7ob+DHZ5VtbUTJpjUtVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYeCoWhk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYeCoWhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6D71F000E9;
	Mon, 15 Jun 2026 08:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781513720;
	bh=VKvvfGVwDq+1GAJCdgJP9K8gCH/aWqlPLdHIbe7f3Nk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dYeCoWhk9j7nQq2O6cAl9V7lSuBvCND7M2XNQdRaj+943d6RLWAU5DMf6ObgCphYS
	 NVVIHlCfS+kk37Lr6v9HnFWZs4Y+MvHhHdX3MZQS2p9rhuFxBm8Dx6jZKTQVOqgAR+
	 MaAh07+Zl5tPjDhMw52MJIDXuet8UsT6c4JM5iosI/J9kfqqj3JJszMz23e4LF2JTw
	 m9ppgW8HIqaMTjhZCQRXVxzVmxTSvg8OgKhfZhqPGgA/wHdyZiE4pMqOEJnWz8m9qE
	 1zbptCFYEMU9boGfF3asIS+m5TZXSlsdeThqL006r1YAxlowc/dISkzXerNDI+8Kzf
	 XTG6LOcHsG/SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Gate dynptr probe-read kfuncs like helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615-f01-07-dynptr-probe-read-cap-v1-1-e626cd61a381@mails.tsinghua.edu.cn>
References: <20260615-f01-07-dynptr-probe-read-cap-v1-1-e626cd61a381@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 08:55:19 +0000
Message-Id: <20260615085520.1F6D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to apply the CAP_PERFMON privilege check to the dy=
nptr `copy_from_user` kfuncs (e.g., `bpf_copy_from_user_task_dynptr`), bypa=
ssing the security requirements enforced on cross-process memory reads.
--

commit 6b909427f5d275b8ba84a3cae17389eff1d7a985
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

bpf: Gate dynptr probe-read kfuncs like helpers

This patch adds a common kfunc filter that mirrors the helper policy for
probe-read dynptr kfuncs. It requires CAP_PERFMON for all four nofault
probe-read variants and applies the lockdown check to kernel-read variants.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9ca1951046679..fbef89196f851 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4961,9 +4961,41 @@ BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
>  BTF_ID_FLAGS(func, bpf_timer_cancel_async)
>  BTF_KFUNCS_END(common_btf_ids)
> =20
> +#ifdef CONFIG_BPF_EVENTS
> +BTF_KFUNCS_START(probe_read_dynptr_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
> +BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
> +BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
> +BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
> +BTF_KFUNCS_END(probe_read_dynptr_kfunc_ids)

[Severity: High]
This is a pre-existing issue, but shouldn't the copy_from_user dynptr kfuncs
(such as bpf_copy_from_user_task_dynptr and bpf_copy_from_user_task_str_dyn=
ptr)
also be included in this set?

Because they are missing from this set, they remain available to
BPF_PROG_TYPE_SYSCALL programs, which do not require CAP_PERFMON to load.

> +
> +BTF_KFUNCS_START(probe_read_kernel_dynptr_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
> +BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
> +BTF_KFUNCS_END(probe_read_kernel_dynptr_kfunc_ids)
> +#endif
> +
> +static int common_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +#ifdef CONFIG_BPF_EVENTS
> +	if (!btf_id_set8_contains(&probe_read_dynptr_kfunc_ids, kfunc_id))
> +		return 0;

[Severity: High]
This is a pre-existing issue, but does this explicit return leave the sleep=
able
cross-task memory read kfuncs completely unrestricted?

An attacker with only CAP_BPF could load a sleepable syscall program, obtai=
n a
task reference using the bpf_task_from_pid() kfunc, and call
bpf_copy_from_user_task_dynptr() to read memory from any process on the sys=
tem
(including root-owned processes).

This bypasses security requirements because access_process_vm() does not
internally enforce ptrace_may_access checks, relying entirely on the BPF
verifier's capability gates, which are skipped here.

> +
> +	if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
> +		return -EACCES;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-f01-07-dyn=
ptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn?part=3D1
