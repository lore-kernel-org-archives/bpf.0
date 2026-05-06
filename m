Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AC2E2850
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101737; cv=none; b=KmjN2UQoETUNt1k4XO2/QvsRsh3OwvtXoHewCP6LjgMgyyGC0mPGySdBZWx2ip4HAaagOjtkWMKmTBcWIjn9PFw5WiALu7fez1yeewbIAbrfsmXdlXDm9KReteiPCoCs4y8ZOASDPAZijaEP7ei9XbMxbEJkd+o1/MuTaEs68dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101737; c=relaxed/simple;
	bh=KKRPFY0uMil2EQLCPD4N91+BEXNXLOCW+/lMKiUqZtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EQJldS8vXe+hdZRar4eZkczt1CJy4YUHAefM8C3LTzhkc4vJu151WII32K+EvWt9wPLbI7QvxYxtnNNgxyhiV5z1vKtmRkPCAIa9F9xMIIwuvt6pJRv9EnGWP/wdwkIzDSnljOv3tRIV0j1RQgMZWYUPolC4CRInjP1Cm5ra/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwG3R5nK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwG3R5nK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C29C2BCB0;
	Wed,  6 May 2026 21:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778101736;
	bh=KKRPFY0uMil2EQLCPD4N91+BEXNXLOCW+/lMKiUqZtU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LwG3R5nKF5kIdEU2qlGbrPr9n5zD3hVmBx7chuv/6gT2ielnDq1rP2SdePcJ37B6S
	 jstfJ7/gi/8aiY06S08rh7H8i2oJ9hrt3OmRSwiC39N6APMYNMotOH/H7SYEF3FsNr
	 RwvxR3h5xxlQcEcViX+peFnxM2NkZl1FKmqpahRAvVKxTToMw1plVRFChZNmWgklZQ
	 tuWinJNI+0WnOq0lHWw5zPC59tha+n2oFs+c14NzmahNb3OVfragQha9MHB+jMsxeG
	 jrWmdByOo13fhepe8E3kJkcdkwD40EeF1fojNUxM2GBLztxtvfRdMcplO1Aq4nS4Lk
	 J8IIpdVS4fTZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] bpf: render CGROUP_LSM_NUM configurable as a
 KConfig
Reply-To: sashiko@lists.linux.dev
To: "Paul Houssel" <paulhoussel2@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506150547.767315-2-paulhoussel2@gmail.com>
References: <20260506150547.767315-2-paulhoussel2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:08:56 +0000
Message-Id: <20260506210856.C6C29C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Increasing CONFIG_CGROUP_LSM_NUM to its maximum value (300) causes=
 an excessive stack allocation in cgroup_bpf_inherit(), which will trigger =
a FRAME_WARN build failure and risks stack overflow.
--

commit 33800a93ec2833bc433c78926307347450251cdb
Author: Paul Houssel <paulhoussel2@gmail.com>

bpf: render CGROUP_LSM_NUM configurable as a KConfig

This commit makes the maximum number of concurrently attachable per-cgroup
LSM hooks configurable at build time via the new CONFIG_CGROUP_LSM_NUM
option. It allows the value to be tuned from 0 to 300, replacing the
previous hardcoded limit of 10.

> diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-d=
efs.h
> index c9e6b26abab6d..9ab5ca3dbaba3 100644
> --- a/include/linux/bpf-cgroup-defs.h
> +++ b/include/linux/bpf-cgroup-defs.h

[ ... ]

>  #ifdef CONFIG_BPF_LSM
>  /* Maximum number of concurrently attachable per-cgroup LSM hooks. */
> -#define CGROUP_LSM_NUM 10
> +#define CGROUP_LSM_NUM CONFIG_CGROUP_LSM_NUM
>  #else
>  #define CGROUP_LSM_NUM 0
>  #endif

> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f09..050af0b72651d 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig

[ ... ]

> +config CGROUP_LSM_NUM
> +	int "Maximum number of per-cgroup LSM hooks"
> +	depends on BPF_LSM
> +	depends on CGROUP_BPF
> +	range 0 300

If this is configured to the maximum value of 300, could this cause a
regression by overflowing the kernel stack in cgroup_bpf_inherit()?

In include/linux/bpf-cgroup-defs.h, MAX_CGROUP_BPF_ATTACH_TYPE scales
dynamically based on CGROUP_LSM_NUM. At 300, MAX_CGROUP_BPF_ATTACH_TYPE
grows to 328 (28 base hooks + 300).

In kernel/bpf/cgroup.c, cgroup_bpf_inherit() computes NR as
ARRAY_SIZE(cgrp->bpf.effective) and declares a local stack array:

kernel/bpf/cgroup.c:cgroup_bpf_inherit() {
        ...
        #define NR ARRAY_SIZE(cgrp->bpf.effective)
        struct bpf_prog_array *arrays[NR] =3D {};
        ...
}

On 64-bit architectures, this array of pointers would consume 2624 bytes
(328 * 8) on the stack. Does this exceed the standard CONFIG_FRAME_WARN
limits and risk build failures or runtime stack overflows?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506150547.7673=
15-1-paulhoussel2@gmail.com?part=3D1
