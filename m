Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0297197A7D;
	Thu, 20 Aug 2026 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787206610; cv=none; b=jDLXWoC+eBrI6BkKjfmPvx9WM5tk4WncWA+g/IdOvR/s/EX600/V3Z1uy7rb9mvO6Zx6GAcSrJyNHuslIsgmppUQ/mLbjXXLJAkbXDnyeUjYhs0bbYTJR42uee/CUCynueFuWDtik4AvqyncLT7jtM7KRe2c6kmdpHBqY9Ny03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787206610; c=relaxed/simple;
	bh=Sb12nASbFOb8PxrFu5zSR2EO+Mhc9Z/+rFnhDEU2BaU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=J+PpfF/F+/IS3MYdjAwN70NfqgdmgtOE3IivSBgW3tvQBjQC77+/Cpdau3jP/7XCd6lsJPZDVboj9rlanP1jUbRQs2UHuu0NP58E81e26gIAIh8iRiuXXRDK7f+nPl/XHjtyzL+3Z8hVUYpFAldq9X0G7ti0u3m6eUvZzb6sBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoxNC488; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoxNC488"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09181F000E9;
	Thu, 20 Aug 2026 06:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787206609;
	bh=ipWdfbFCI8SvmCNDLFz98zCDezRaDmFlDpCjuSri7OA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SoxNC488owrOu+P+eRVmaBSeEAJLArCgODXUNXoT19nPx4N974SPG7LeYxMjxYxMs
	 VtCzH83gyE7wo6PwmZjNbn7CHPcVGyEB9XpWOE6AAMkN7Af/qv3pny0YoUB+sUauSD
	 12q4HEwN0ILniWvn88F8tMq+vEt/B25UEKj7WVmWdeLV6b8fuvNSvPGk0SKv+hS/7g
	 +AzkLBZPF4EFvdVle0o1VgyiOSmFIWng1q0EyGUu4zwcXZ1GJIOlCVfXs3VYxyI0kZ
	 yhLjUcfAJegw/nev/LQEkJ3dj81Um1DtZvE5EPZ86ymgtXiMyWAHqdqP8+GO+3My05
	 +sy9/shhOSOrw==
Content-Type: multipart/mixed; boundary="===============5230550170697309396=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <758be5cbbea1b61eeaad2454d28f13a1acb1f3d0d50893b7707d9afdcea131e7@mail.kernel.org>
In-Reply-To: <95d7ccc17681aa3a4a2eeb1b073f00f7@kernel.org>
References: <95d7ccc17681aa3a4a2eeb1b073f00f7@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: sched_ext: Mark ops argument container pointer fields as trusted
From: bot+bpf-ci@kernel.org
To: tj@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,john.fastabend@gmail.com,bpf@vger.kernel.org,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,emil@etsalapatis.com,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 06:16:48 +0000 (UTC)

--===============5230550170697309396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: sched_ext: Mark ops argument container pointer fields as trusted
>
>     Walking an unannotated pointer field of a trusted struct yields a bare
>     PTR_TO_BTF_ID in non-sleepable programs, which kfuncs and helpers accept,
>     but PTR_UNTRUSTED in sleepable programs, which they reject. This gets in the
>     way of making ops.init_task() sleepable, which schedulers want for
>     allocations. For example, passing args->cgroup into bpf_cgrp_storage_get()
>     then fails verification and the only recourse is round-tripping through the
>     cgroup ID with bpf_cgroup_from_id().
>
>     The pointer fields in the sched_ext ops argument containers are all pinned
>     by the callers for the duration of the ops calls and are never NULL. Add
>     them to the verifier's trusted-fields whitelist so that they are PTR_TRUSTED
>     in both sleepable and non-sleepable programs.
>
>     Signed-off-by: Tejun Heo <tj@kernel.org>

This looks like a bug fix for verification failures in sleepable programs.
Should this include:

  Fixes: 8195136669661 ("sched_ext: Add cgroup support")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32336047878
--===============5230550170697309396==--
