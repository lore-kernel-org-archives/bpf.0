Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086DB367296;
	Mon,  1 Jun 2026 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310110; cv=none; b=KcN+Mxke2Fx4RbLt7z+//7f+/1jStFxQ6DZpWmJpceAKI7YRGKZDavA37MOs4MM6iUUFzKWHyv7SHZZRSZoCjLMzaVe+8nGL3KLryU+OUQ5sHxKHPKPrI/rGxFgvC9FuiO9MI8eSHoSJ7NsQb7n+U068cmTJ/XHkuR3wGSsWtMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310110; c=relaxed/simple;
	bh=/AmouHzOGpk+u+fMGVY5ORySinzANA/TH0gROjiNSbE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=op9MlKTgOER2GkU1nNRwX8flnSYqZXYE1FwikWXHeIuuBpEqlQykFcXyS8mSL3xx9UoyASH2sFG4RALVJbhDhOXZcgsZS3WnJGpuNavRr+vHXS9ef1KSCgagwfHIa4EwKP5xhp/BHte1ozAK11DiDZ9wHY/UMoN3nwr0dkeRKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBeZSkth; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBeZSkth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D3A1F00893;
	Mon,  1 Jun 2026 10:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780310108;
	bh=M+MQSl6lY5bBejCFKyoQlrVgF+TUG3+sKVFgxWE4UlA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SBeZSkthTfAI3c3lw0PnncYazIIx2dYBJ7ORGgCB1EMBXBv0ucsx+9xkdp+mSE7OW
	 x4FDbB7RrbBo34dHnnawonew/ukPBBwsKpaVu79htfp7c9dLYxj1dK2ARnVEPnT56V
	 NEmWVLg2yigWObQBjRZpZL7S1E4mhz+5V9lS7uuXGicIljGX6ro2KQKzbltTROhPke
	 duop4/2fiW32pDIe78CG+M2XZ+k2l5WPO/xhJJ+Ih/U2Fnfy2p2CV6ld3PmaYD+xRY
	 Q8qyvPl0ektdX2txCiYnzpYEz7b1FNW4NKR8IEPimchqEwjxSkdvPtRKtfrGqkQYYm
	 AlGFUhal6eBCQ==
Content-Type: multipart/mixed; boundary="===============4540520546284454036=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d061816d1a9bfa304d8b8a986df4729e3b30028a350d79e7eb981a41d7b5a53c@mail.kernel.org>
In-Reply-To: <20260601095158.1186318-1-malin89@huawei.com>
References: <20260601095158.1186318-1-malin89@huawei.com>
Subject: Re: [PATCH] bpf: Tighten cgroup storage cookie checks for prog arrays
From: bot+bpf-ci@kernel.org
To: malin89@huawei.com,ast@kernel.org,daniel@iogearbox.net,cenxianlong@huawei.com,chenzhe@huawei.com
Cc: bpf@vger.kernel.org,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,zhuyifei@google.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  1 Jun 2026 10:35:08 +0000 (UTC)

--===============4540520546284454036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Tighten cgroup storage cookie checks for prog arrays
>
> The recent KCTF-reported cgroup local storage issue assigned
> CVE-2025-38502 was fixed by commit abad3d0bad72 ("bpf: Fix oob access
> in cgroup local storage"). That fix addressed the direct mismatch case
> in tail-call chains.
>
> However, the previous fix is still incomplete. The current prog-array
> compatibility check treats a program with no cgroup storage as
> compatible with any stored storage cookie. This allows a storage-less
> program to bridge a tail-call chain between an entry program and a
> storage-using callee even though runtime cgroup local storage still
> follows the caller context.
>
> Require exact per-type storage_cookie equality when checking prog-array
> compatibility. This blocks zero-storage bridge programs from joining a
> prog-array owned by a storage-using program and closes the residual
> A -> B(no storage) -> C(storage) path without relying on partial
> BPF_PROG_TEST_RUN special cases.
>
> Cc: stable@vger.kernel.org
> Fixes: 7d9c3427894f ("bpf: Make cgroup storages shared between programs on the same cgroup")
> Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
> Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
> Signed-off-by: Lin Ma <malin89@huawei.com>

The commit message references commit abad3d0bad72 as the incomplete fix
that this patch builds upon. Should the Fixes: tag point to abad3d0bad72
rather than 7d9c3427894f? The current patch removes the '|| !cookie'
logic that was introduced in abad3d0bad72, not the original shared
storage feature from 7d9c3427894f.

This work appears to duplicate Amery Hung's patch from December 2025
(https://lore.kernel.org/bpf/20251203195050.3215728-1-ameryhung@gmail.com/).
That earlier patch proposed the exact same fix - removing the '!cookie'
exception to prevent NULL pointer dereference in bpf_get_local_storage().

Amery's patch was preceded by a review thread from July 2025 where
Alexei Starovoitov suggested design changes (removing the
for_each_cgroup_storage_type_cond macro). While Daniel Borkmann
addressed that feedback in v2, the core logic remained and Amery's v3
submission received no maintainer response. Pu Lehui from Huawei followed
up in January 2026 asking about the status.

Should this patch acknowledge the prior submission or explain what
happened to Amery's version?

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2480,8 +2480,12 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>  				break;
>  			cookie = aux->cgroup_storage[i] ?
>  				 aux->cgroup_storage[i]->cookie : 0;
> -			ret = map->owner->storage_cookie[i] == cookie ||
> -			      !cookie;
> +			/*
> +			 * Tail calls keep using the caller cgroup storage
> +			 * context, so prog-array members must use the same
> +			 * storage cookie.
> +			 */
> +			ret = map->owner->storage_cookie[i] == cookie;
>  		}
>  		if (ret &&
>  		    map->owner->attach_func_proto != aux->attach_func_proto) {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26748527078
--===============4540520546284454036==--
