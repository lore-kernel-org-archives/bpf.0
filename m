Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49703AE199
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095545; cv=none; b=LPlaHTCIR4efJZBP4o3hGSXuEx7ETJMNrDVillSY5sAkfjK1f8W0XRLq7jU+VULzrshdxJH4JoRc4IBK13lzPKQTsEdE4T4oxpNadpZwkj2KRhdNIeU2jeQ9toRgqvK7JvQOR/fsJO54egAAZ2T8qEvc5mGGje3kLYr9am8M4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095545; c=relaxed/simple;
	bh=OsSTuld6c7lCkdPg3Ah5qMecUqP9cL63G32ShJK54YM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=trImg+5hhkGE9YVwYwzXU9Gr12jG3MLM1o8XrBzAV+e+vp0W14CnpEQAHE2NztJyYE7Y0oJaGNobNR3BUmwhZl5JNtuJxPwspjHn2+kH5M8RAOBkIAH0JC1oJMovPUXnBXL233T7pptydJaow/jvLn+kNC//rYiWZ1a+pBKKcDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVdb/7vD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVdb/7vD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE211F00898;
	Wed, 10 Jun 2026 12:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781095544;
	bh=8aTNs82JEVzD0XEjQ8Nw8MWZCmO9iJ7Ek44C3gzdvjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AVdb/7vDvUNdxazuEmXLJ3m790wzzMa5l9WFXS+jcz6CxcRqmVYew+WWj6IG7Goo0
	 yZUqg4zyt1YDLlbZ3sYY//mWfcmYNXXwl56iYjE+Ua6nLd78hpbOiPm1/oGv501AAr
	 JkvbSbhlzKXhZFI3lAKqBjEZZLo/9Dsd/XxCewtPyMBp7vwaFMf+ba6hDMMWRgRBJS
	 3em5rXzTVHtaIFk1GisT8tAwQSzWKoise+5lh94OigAteY+cEmcaYxZDMZvAXJrzJb
	 HSzBKvXEFph7QXsOOxRk355PtOfYG4X0p+JVyxlllxHKxjAaH7jKzbNUpxvQ6YSRKb
	 98OIDFFrlpaMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix setting retval to -EPERM for
 cgroup hooks not returning errno
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610201724.733943-2-xukuohai@huaweicloud.com>
References: <20260610201724.733943-2-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 12:45:43 +0000
Message-Id: <20260610124544.3EE211F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch breaks cgroup BPF boolean LSM hooks by ignoring a BPF pr=
ogram's denial (exit code 0). It leaves `run_ctx.retval` unmodified for boo=
lean hooks, which fails to enforce denials, ignores overrides from previous=
 programs in the cgroup array, and causes the trampoline to incorrectly fal=
l back to the original kernel function.
--

commit b6b16c6bf2bc0b50b22feebf85585b33ce70965a
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Fix setting retval to -EPERM for cgroup hooks not returning errno

This commit modifies bpf_prog_run_array_cg() to avoid setting the hook retu=
rn
value to -EPERM when a cgroup BPF program exits with 0 for non-errno hooks
(such as boolean or void LSM hooks).

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 35d1f1428ef39..83ce66296ac19 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

> @@ -83,7 +105,8 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>  			*(ret_flags) |=3D (func_ret >> 1);
>  			func_ret &=3D 1;
>  		}
> -		if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
> +		if (!func_ret && cgroup_bpf_hook_returns_errno(atype) &&
> +		    !IS_ERR_VALUE((long)run_ctx.retval))
>  			run_ctx.retval =3D -EPERM;

[Severity: High]
Could this change cause BPF program denials to be ignored for boolean hooks?

In cgroup BPF, a program returning 0 typically signifies a denial. By
requiring cgroup_bpf_hook_returns_errno() to be true here, a func_ret of 0
is ignored for boolean hooks, leaving run_ctx.retval unmodified.

If a prior program in the cgroup array called bpf_set_retval(1), and the
current program returns 0 (denial), run_ctx.retval remains 1. Doesn't this
break cgroup hierarchy semantics where a denial must override an allow?

Additionally, if run_ctx.retval remains 0, the fmod_ret trampoline interpre=
ts
0 as an instruction to call the original kernel function rather than skippi=
ng
it. If the underlying kernel function returns 1, the operation ends up being
allowed. Does this unintentionally bypass the BPF program's intent to deny
the operation?

>  		item++;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610201724.7339=
43-1-xukuohai@huaweicloud.com?part=3D1
