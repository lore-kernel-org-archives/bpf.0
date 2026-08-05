Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202E73C5826;
	Wed,  5 Aug 2026 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916121; cv=none; b=Kf77PjcEHCDidA6UTGO19aSMEqK52DWILmIiyB3EqPa9HnOIrN6rO3cSu2fzaZ+Jb0zc+Oseu3r7pNVjCp7R8ZyD4O7xQObIGCwoRLSXhB8JBaTy2uYfDmydD1haXuXAvknXuDO86m3C4abiudDkPF89L5cqlBWwoGLAY7Dg2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916121; c=relaxed/simple;
	bh=iz7e3u8wAD/d3qjzHr/RNRIZAcf5M9o9o+thk6Ka3m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=apbG/m275O8kCd5rbD31DIa6PohphXo9OlRSdlfzYWpjCSu4169v9idoQc1aAbF3kpVi0ITbSeK9CQ3E5BFLbTaHCE2SOxgQHcKwjlYZ19cVMYcMmhJaS0+BjpO65P2RAGo7IBKIM/fa1KfSWP3HEp40ds1MG+MtqYiJq7pqzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gYKIKHEL; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gYKIKHEL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RtbCKHsVAhTVASlgSZ0wsmn6MVIeHZzF36EEypzJi2g=;
	b=gYKIKHELE8d9p4PS3nHt57D/Da2QruvqOZ1IAZX7yN/98cHkkBjYBRXId2oXkVd5GwyWXEw54
	Jzlsvp1YDfg+R3iEIRXSzJVbTY6iLKuVGaOHPyBpiT0l73k8s/0g2vasUmK26zUinBW22eQeeh+
	n92F9S/IVV5BvdvsiIi1Y/0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hFMjh0cFXzRhQt;
	Wed,  5 Aug 2026 15:39:04 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AC622025F;
	Wed,  5 Aug 2026 15:48:34 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 5 Aug
 2026 15:48:33 +0800
Message-ID: <916b5920-a2f4-4b05-b86e-6a29e599ffad@huawei.com>
Date: Wed, 5 Aug 2026 15:48:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Fix stack out-of-bounds write in cgroup
 link update
Content-Language: en-US
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>, <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
	<eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
	<emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260805052858.2390918-3-sanghyun.park.cnu@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260805052858.2390918-3-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/8/5 13:28, Sanghyun Park wrote:
> The cgroup link update path checks only the program type, allowing a UDP6
> sock_addr program to replace the program on a UDP4 link. Running the
> replacement writes past the smaller IPv4 context into ipcm_cookie::opt on the
> stack.
> 
> Require a replacement sock_addr program to have the same expected attach type
> as the link before changing link state. Limit the check to sock_addr programs
> so update policy for other cgroup program types remains unchanged.
> 
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---
>   kernel/bpf/cgroup.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index d2da5063d8f8..65bf25deac4f 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1055,6 +1055,10 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>   	if (link->link.prog->type != new_prog->type)
>   		return -EINVAL;
>   
> +	if (new_prog->type == BPF_PROG_TYPE_CGROUP_SOCK_ADDR &&

not only BPF_PROG_TYPE_CGROUP_SOCK_ADDR, but also 
BPF_PROG_TYPE_CGROUP_SKB, BPF_PROG_TYPE_CGROUP_SOCK, etc. I think we can 
make it general.

> +	    link->link.attach_type != new_prog->expected_attach_type)

use link->link.prog->expected_attach_type

> +		return -EINVAL;
> +
>   	hlist_for_each_entry(pl, progs, node) {
>   		if (pl->link == link) {
>   			found = true;
