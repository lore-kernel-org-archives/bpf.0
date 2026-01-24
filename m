Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008449443
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 02:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769223597; cv=none; b=mEPjdEK3imyNIHVENH3YjdeUUFZOh+BQYZQRmHhNnF524wubAC/a27RfAorsE77tJm5Uqs0f388pd/+6XEUYfysRD+1JvfE6ot+0FZwyw+fV861yGo707VXiwVuF5sAt2oBzMp+vL1jm+s8wrGWGBPbveDAGtWPgabmLYOeJRCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769223597; c=relaxed/simple;
	bh=xzEq0+JXleMIrq/JCyWSi3Hfiw7RjJVzGUYmO0KSAyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eEsPmPECu8pTMFZxYeI8prrqvKXjD4UWQYzMasA0DSJcgFdeVGfBsRlaHa9UxZpo703w2E7TbNF0ZsfPkTZvDaEf/fL/YW7AOW5iH4uDb9GWnNhWoTZrFLVCdgCSYgH7plhi5n+3Z3+VHQLi3MGID95/0Xx6gsMCD6OG2xb9wtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=n7jZAJck; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="n7jZAJck"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dTYjO+jN971PBs8HsMn0m/JgIi551dOZTssrhOegW1Q=;
	b=n7jZAJckgopw/9lcV7lpAAodRT8XxobJ8q3tAj7b8ZfhTLBAoDlBF0o509euB6f2moU58aySu
	SLqCUFk8WOfdgV0WBv87XFaIvEmHC+VjogeK5HLZ68mZYOJuEqFrAqMmcKLCpZ8XlLi63/8GIh5
	Ijryj4JRA7azDR9g0SOwWXE=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dyfZ42F9wzpSth;
	Sat, 24 Jan 2026 10:55:56 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id F2E9640569;
	Sat, 24 Jan 2026 10:59:46 +0800 (CST)
Received: from [10.67.110.198] (10.67.110.198) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 24 Jan 2026 10:59:46 +0800
Message-ID: <b5d75a0b-965b-41fc-b34b-9069959309f5@huawei.com>
Date: Sat, 24 Jan 2026 10:59:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/2] bpf: Make sure all tail call callers use
 cgroup storage if the owner does
Content-Language: en-US
To: Amery Hung <ameryhung@gmail.com>, <bpf@vger.kernel.org>
CC: <alexei.starovoitov@gmail.com>, <andrii@kernel.org>,
	<daniel@iogearbox.net>, <martin.lau@kernel.org>, <eddyz87@gmail.com>,
	<kernel-team@meta.com>
References: <20251203195050.3215728-1-ameryhung@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20251203195050.3215728-1-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)

Hi Amery, we’ve encountered the same issue, and the current patch works 
for us. Do you have any plans to upstream it at a later time, or might 
there be additional updates in the future?

On 2025/12/4 3:50, Amery Hung wrote:
> Mitigate a possible NULL pointer dereference in bpf_get_local_storage()
> by requiring all callers to use cgroup storage if the owner does.
> 
> Cgroup storage is allocated lazily when attaching a cgroup bpf program.
> With tail call, it is possible for a callee BPF program to see a NULL
> storage pointer if the caller prorgam does not use cgroup storage.
> 
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/c9ac63d7-73be-49c5-a4ac-eb07f7521adb@hust.edu.cn/
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>   kernel/bpf/core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index c8ae6ab31651..e249ea98f55d 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2403,8 +2403,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>   				break;
>   			cookie = aux->cgroup_storage[i] ?
>   				 aux->cgroup_storage[i]->cookie : 0;
> -			ret = map->owner->storage_cookie[i] == cookie ||
> -			      !cookie;
> +			ret = map->owner->storage_cookie[i] == cookie;
>   		}
>   		if (ret &&
>   		    map->owner->attach_func_proto != aux->attach_func_proto) {
