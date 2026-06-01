Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303E1C5F13
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329669; cv=none; b=h1U16j61ekwDBk6r7smcSq8DfittiCNSD6PoaGOXWbiBKwliCKlnwdm6rlsBtfX3Gm0OhCduJ6bsQ6L3CyDrR2+FrbIe2jyqSkdB6POGGzAHkYx9fNtORTPifJCkqY0vml1h6mE/cG4CMWDBAU07jUXoOk6NuiBt0vm78+B0cWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329669; c=relaxed/simple;
	bh=Do74d+8XBL9lpsb6lEODd043vgrF5jDPLHMNv7Y/a78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqU8/aa8AiIqGesVRt9t1XsgqeEkLiKMFNT7vWNYj0OTEXi5+WERoMkqdS06CgGSEJ9Avjbr13czX/UDTI8ueUnpMyxkVDqcL/fkdrbweTny1+43h4sn02yjZF+dOgvcYx30ERSPbl0knr6Ey7OEGzgKGXpbyGCUsajWOu03Jm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d94JY1LC; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d94JY1LC"
Message-ID: <36f7fc7f-5fbc-4f60-b5b0-76300d78b15c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780329650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txVl3s2cy1CA6Q/ph71iN6AxLc0+78y4QVoXa/72WbM=;
	b=d94JY1LCAzRt68ouZuqp5RUJCu0chX6+/N7POXzWgcj1HNEywa/FuFrr9CdcBYQuaeRxkW
	nE2jLGMOz5yXOuqgRWIjK6yv3Q4QmwRxSwMjfcxKYAx3V4pqouryGZNnN51wiSMbLd4z0f
	bx9J4zgVVSri9k01UbbIc80eDbxYAxc=
Date: Mon, 1 Jun 2026 09:00:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Tighten cgroup storage cookie checks for prog arrays
Content-Language: en-GB
To: Lin Ma <malin89@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, cenxianlong@huawei.com,
 chenzhe@huawei.com
Cc: bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, YiFei Zhu <zhuyifei@google.com>,
 linux-kernel@vger.kernel.org
References: <20260601095158.1186318-1-malin89@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260601095158.1186318-1-malin89@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/1/26 2:51 AM, Lin Ma wrote:
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

The patch looks okay to me. But can you add a selftest for this?

> ---
>   kernel/bpf/core.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 8b018ff48875..dccd47c92992 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2459,8 +2459,12 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>   				break;
>   			cookie = aux->cgroup_storage[i] ?
>   				 aux->cgroup_storage[i]->cookie : 0;
> -			ret = map->owner->storage_cookie[i] == cookie ||
> -			      !cookie;
> +			/*
> +			 * Tail calls keep using the caller cgroup storage
> +			 * context, so prog-array members must use the same
> +			 * storage cookie.
> +			 */
> +			ret = map->owner->storage_cookie[i] == cookie;
>   		}
>   		if (ret &&
>   		    map->owner->attach_func_proto != aux->attach_func_proto) {

