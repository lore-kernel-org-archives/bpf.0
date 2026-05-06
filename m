Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD346AF15
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075289; cv=none; b=oIrxeEjXUi550xl7f/LS5tqVYuSAmlwlbsFdtdfhfFDnkLKmtY3HmrsVj2ziFnRvsEpA+bBFPVUf0EmmLVt03fz8QELYP3WHR+CK9TTStzQD6utNA57CJNFH2MYY0XpeTrGaUUqidbfzkRWBCyGk8CbYXIOnhDIMFRXiKfFS5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075289; c=relaxed/simple;
	bh=iFo6IeXT5cb3dJwJhXvu6rdwvFc1/NkYTXybwYCOKzs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CXYNVCzlTDzu8uWTqkKqwJwL+WlfME2uzSiumPFiVF3KfM1LkXqktNSRarHKAk6On+l1hzjwJgIcXDDhPAzF6UCr7gM6O+TYTZpTRhT6paFMtT3YBBJUXACzA+O68bGDzmSaFzZEDzHsGVEFljimA8pTu6V6Z7F6iAMokTaPk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csoYTJmW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csoYTJmW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C8CC2BCB8;
	Wed,  6 May 2026 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778075289;
	bh=iFo6IeXT5cb3dJwJhXvu6rdwvFc1/NkYTXybwYCOKzs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=csoYTJmWbbxJdu7ZIF7Lu7GtATGiPHFWgk2Bw+KJzErbXa8fE4Ecq8Mw/4oIeU+e3
	 lHT+R8HiaPBjdLT9I40Flv2E/IzdPoE58bjm5+QwCrSuOo/K4xLaaHOisKcnj31X0i
	 vGnCmnyA0cvqCZm2xFdbCEVKpL/8XUVqkVPBc+6NRhqd5k7vVJZzgxB7A6L2ItJi+8
	 sXHzKvx23jdsw3Xob4G+MYkWZWv5RlQ3TtoFq2Q/Rse/lPhkMiBrLZy6D/vzDSKB/4
	 fVJv0v7D9dCns2BXTsWfpX9hT0OSKXk2MzEcVf7IFaqSlOhhTgQT7FfHtJVjTz1ZfM
	 mYra1Fxsrca2w==
Content-Type: multipart/mixed; boundary="===============6886076766116466222=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0d56117c671b24596a37277bfabafd5bf985df961172e523ade09f8bcff4140e@mail.kernel.org>
In-Reply-To: <20260506131257.713895-2-paulhoussel2@gmail.com>
References: <20260506131257.713895-2-paulhoussel2@gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: render CGROUP_LSM_NUM configurable as a KConfig
From: bot+bpf-ci@kernel.org
To: paulhoussel2@gmail.com,paul.houssel@orange.com,andrii@kernel.org,yonghong.song@linux.dev,paulhoussel2@gmail.com,kpsingh@kernel.org,ast@kernel.org,song@kernel.org,martin.lau@kernel.org,christian.koenig@amd.com,fw@strlen.de,tjmercier@google.com,lirongqing@baidu.com,paul.chaignon@gmail.com,alibuda@linux.alibaba.com,kuba@kernel.org
Cc: sdf@google.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  6 May 2026 13:48:08 +0000 (UTC)

--===============6886076766116466222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
> index c9e6b26abab6..9ab5ca3dbaba 100644
> --- a/include/linux/bpf-cgroup-defs.h
> +++ b/include/linux/bpf-cgroup-defs.h

[ ... ]

> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f0..7f51598aa8fe 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -101,4 +101,17 @@ config BPF_LSM
>
>  	  If you are unsure how to answer this question, answer N.
>
> +config CGROUP_LSM_NUM
> +	int "Maximum number of per-cgroup LSM hooks"
> +	depends on BPF_LSM
> +	depends on CGROUP_BPF
> +	range 0 300
> +	default 10
> +	help
> +	  Maximum number of concurrently attachable per-cgroup LSM hooks.
> +	  Increasing this value increases the size of the cgroup_lsm_atype
> +	  structure.

The help text here mentions that increasing this value increases the size
of the cgroup_lsm_atype structure, but doesn't mention the more significant
memory impact on struct cgroup_bpf.

While the cgroup_lsm_atype array in kernel/bpf/cgroup.c is a single global
array that grows by (CONFIG_CGROUP_LSM_NUM - 10) * 8 bytes, struct cgroup_bpf
grows by approximately (CONFIG_CGROUP_LSM_NUM - 10) * 25 bytes per cgroup
instance, since MAX_CGROUP_BPF_ATTACH_TYPE expands to include CGROUP_LSM_NUM.

The affected arrays in struct cgroup_bpf are:

include/linux/bpf-cgroup-defs.h:struct cgroup_bpf {
	struct bpf_prog_array __rcu *effective[MAX_CGROUP_BPF_ATTACH_TYPE];
	struct hlist_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
	u8 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
	u64 revisions[MAX_CGROUP_BPF_ATTACH_TYPE];
};

For a system with many cgroups, increasing CONFIG_CGROUP_LSM_NUM from 10 to
300 would add approximately 7.25 KB per cgroup. Should the help text mention
this per-cgroup memory impact so users understand the full cost when tuning
this configuration option?

> +
> +	  If you are unsure, leave the default value.
> +
>  endmenu # "BPF subsystem"


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25437889223
--===============6886076766116466222==--
