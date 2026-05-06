Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9E3F076E
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082759; cv=none; b=SWCmv84lfjgewnE03VOZwjITMkYoPIlvZHcz1bhbHvoimHhgm57A54LMNQ/3VLyQGuFJQz8Kgl8rXXltT4dEuNTovst1M29x/XwoJ4VwQNIQsmlmLTizDiv/N4C6P5Gd2776EOicWmblp/cUV7FyHgS6s75GgpPQrNVLTBfGtOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082759; c=relaxed/simple;
	bh=ceHdrbU8TgZGhmGH+deacKbDZcLJJ0KHn0TyT2+uKso=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XpLhQh2dVMhAEmiVJhm9AFw7EekRwfrtcaG9NW6IuHJ7lmdxmu+w6l/cLfnm6EGmwXT6FWdQfQx6b8dYSOlBux5mzNYDwhGJp2nQwVraTuif0SyD6vjJAtUHeAxa3pkVYPoncQJ0jvxxySAeGlvGxLwAFs+hmJPyeXS9UIwDNkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEJAjYXz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEJAjYXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FDEC2BCB0;
	Wed,  6 May 2026 15:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778082758;
	bh=ceHdrbU8TgZGhmGH+deacKbDZcLJJ0KHn0TyT2+uKso=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=qEJAjYXzhwUQjOFLTQl9/NN7pw4WoG38Kn4yQruft/C+2KFZpVndP+NeXqkLm/EF7
	 Xkn85n8V/WsFx1fPzXljR98LkdeoU9bMoSy2/j/BEBf+kOiU55FnV5YBwt6aibyWLT
	 pef9xS3xguBPww+6sqn/drz4XTaeEvTMVLGapAY6pVXXXKX0Tw8uPIqiMN67hjyofX
	 3Xom2JldQhOcBiHYp2F0sx1iiyH0H+n87/ypD9k5Z7wO3/YGRk6uJWNMIyvJUaFM9S
	 VvwlQq7i4iPegytV5QxhKSVk4TYB1/m9yKZei1RpfZO2NqAemLOU/EWsSoJG5QGmXy
	 tZxeUmQk+FP5Q==
Content-Type: multipart/mixed; boundary="===============1287482027544834248=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <283f244ee4c180a4a69cf5cffdbeffea1a0928262758906384f3512e09fe3c44@mail.kernel.org>
In-Reply-To: <20260506150547.767315-2-paulhoussel2@gmail.com>
References: <20260506150547.767315-2-paulhoussel2@gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: render CGROUP_LSM_NUM configurable as a KConfig
From: bot+bpf-ci@kernel.org
To: paulhoussel2@gmail.com,paul.houssel@orange.com,andrii@kernel.org,yonghong.song@linux.dev,paulhoussel2@gmail.com,kpsingh@kernel.org,ast@kernel.org,song@kernel.org,martin.lau@kernel.org,christian.koenig@amd.com,fw@strlen.de,tjmercier@google.com,lirongqing@baidu.com,paul.chaignon@gmail.com,alibuda@linux.alibaba.com,kuba@kernel.org
Cc: sdf@fomichev.me,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  6 May 2026 15:52:37 +0000 (UTC)

--===============1287482027544834248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
> index c9e6b26abab6..9ab5ca3dbaba 100644
> --- a/include/linux/bpf-cgroup-defs.h
> +++ b/include/linux/bpf-cgroup-defs.h
> @@ -12,7 +12,7 @@ struct bpf_prog_array;
>
>  #ifdef CONFIG_BPF_LSM
>  /* Maximum number of concurrently attachable per-cgroup LSM hooks. */
> -#define CGROUP_LSM_NUM 10
> +#define CGROUP_LSM_NUM CONFIG_CGROUP_LSM_NUM
>  #else
>  #define CGROUP_LSM_NUM 0
>  #endif

[ ... ]

> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f0..050af0b72651 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -101,4 +101,23 @@ config BPF_LSM
>
>  	  If you are unsure how to answer this question, answer N.
>
> +config CGROUP_LSM_NUM
> +	int "Maximum number of per-cgroup LSM hooks"
> +	depends on BPF_LSM
> +	depends on CGROUP_BPF
> +	range 0 300
              ^^^

Should the minimum range be 1 instead of 0? When CONFIG_CGROUP_LSM_NUM=0,
the enum in include/linux/bpf-cgroup-defs.h calculates:

enum cgroup_bpf_attach_type {
    ...
    CGROUP_LSM_START,
    CGROUP_LSM_END = CGROUP_LSM_START + CGROUP_LSM_NUM - 1,
    ...
};

This results in CGROUP_LSM_END being less than CGROUP_LSM_START (END =
START - 1), which contradicts C enum range conventions. While the runtime
behavior stays safe since bpf_cgroup_atype_find returns -E2BIG for empty
arrays, the enum definition is semantically incorrect.

The Kconfig help text refers to "Maximum number of concurrently attachable
per-cgroup LSM hooks" which suggests at least one hook should be
attachable.

> +	default 10
> +	help
> +	  Maximum number of concurrently attachable per-cgroup LSM hooks.
> +	  Increasing this value has two memory costs:
> +		- 8 bytes per added hook (due to growing
> +		cgroup_lsm_atype[] array in kernel/bpf/cgroup.c)
> +
> +		- 25 bytes per added hook, because each hook adds a value to
> +		MAX_CGROUP_BPF_ATTACH_TYPE and thus increases the
> +		effective, progs, flags and revisions arrays in struct
> +		cgroup_bpf
> +
> +	  If you are unsure, leave the default value.
> +
>  endmenu # "BPF subsystem"


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25444641622
--===============1287482027544834248==--
