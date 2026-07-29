Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D3411F82;
	Wed, 29 Jul 2026 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319340; cv=none; b=PJNMEfQYhXquDCOcDConQKT5hlSI2+UbFWYCnsprkBOxon8fo2Bimqle1kqQp7GlAfW+SYCicsFpiCGQ+XDOo2kefh4ZTib9GGVTTup9omdGdRaJFo6pswdFSCPLvl0Usz/jKiJ+3Ic7ZIT9wKBl8wHUATjVj2Ou2azNX/8d+BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319340; c=relaxed/simple;
	bh=9PfxBrDiMYUxWpyNHKjtCgvCSLmjTslVE0viAZX8wTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Snt57iKycMNw1Cb5tSdIJvn0Qv0TxW8ZFU97pPOgIJIy606b+I/V6bSqt0UjgCH8yGp4zSWGSt3OSLF0BJ4EU5EkyYzM16Dn9ybzOuq+9jP2F9LX/DxiK8PEAU8FuFlWkqawgyDs8+Nfk60yPCiJBtSGS4fZUMFmgPp6MKbZ9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WelTDRu+; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WelTDRu+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IRTu9j5y5y9a1YTDJl0H4rANLraEGK96ArcaCizkdM0=;
	b=WelTDRu+uivCh7iBOPgbw5rxwQrvsEA/HpKLGNNVQhbHxIM8zuwneVukpRa3FCL3HA6eRRMAf
	5ggGwPriu25KU66NTFtCvbm2ML4bTIp2DiTeXqbNwZs/Edl6lrRlDNYwfq5+qI2YqWZVbb0zzm/
	FlP2Nnvnja33+JBdrDMF3A4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h971043cvz12LHh;
	Wed, 29 Jul 2026 17:52:36 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 67EBA40538;
	Wed, 29 Jul 2026 18:02:06 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 29 Jul
 2026 18:02:05 +0800
Message-ID: <a528cfaf-42bf-41e8-be61-32693334a39c@huawei.com>
Date: Wed, 29 Jul 2026 18:02:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf, cgroup: Fix potential UAF in __cgroup_bpf_attach
Content-Language: en-US
To: Pu Lehui <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
	<eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Song Liu
	<song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
	<emil@etsalapatis.com>
References: <20260728132336.2857800-1-pulehui@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260728132336.2857800-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/28 21:23, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When replacing an existing bpf_link in single-attach case in
> __cgroup_bpf_attach, old_prog is NULL while old_link holds the active
> link. If attachment fails midway (bpf_trampoline_link_cgroup_shim or
> update_effective_progs), the cleanup check `if (!old_prog)` wrongly
> treats the existing pl entry as newly allocated, calling kfree() and
> causing a UAF.
> 
> Additionally, original flags and storage state are not restored on
> failure.
> 
> Fix this by checking `!old_prog && !old_link` before freeing pl, and
> properly restoring all previous states on error.

Nack, sorry for the noise.

link attach only support BPF_F_ALLOW_MULTI mode, so it will not occur 
UAF pl.

But there still remain an invalid storage access issue. I have been 
mentioned and fix it in v2. Hope that will fix.

https://lore.kernel.org/bpf/20260729100208.3076769-1-pulehui@huaweicloud.com/T/#u

> 
> Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program attachment")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   kernel/bpf/cgroup.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index e2fa0ebeed83..e22e7dfe0022 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -811,10 +811,13 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>   {
>   	u32 saved_flags = (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI));
>   	struct bpf_prog *old_prog = NULL;
> +	struct bpf_cgroup_link *old_link = NULL;
>   	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>   	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
> +	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>   	struct bpf_prog *new_prog = prog ? : link->link.prog;
>   	enum cgroup_bpf_attach_type atype;
> +	u32 old_flags, old_pl_flags;
>   	struct bpf_prog_list *pl;
>   	struct hlist_head *progs;
>   	int err;
> @@ -865,6 +868,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>   
>   	if (pl) {
>   		old_prog = pl->prog;
> +		old_link = pl->link;
> +		old_pl_flags = pl->flags;
> +		bpf_cgroup_storages_assign(old_storage, pl->storage);
>   	} else {
>   		pl = kmalloc_obj(*pl);
>   		if (!pl) {
> @@ -884,6 +890,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>   	pl->link = link;
>   	pl->flags = flags;
>   	bpf_cgroup_storages_assign(pl->storage, storage);
> +	old_flags = cgrp->bpf.flags[atype];
>   	cgrp->bpf.flags[atype] = saved_flags;
>   
>   	if (type == BPF_LSM_CGROUP) {
> @@ -912,15 +919,18 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>   		bpf_trampoline_unlink_cgroup_shim(new_prog);
>   
>   cleanup:
> -	if (old_prog) {
> +	if (old_prog || old_link) {
>   		pl->prog = old_prog;
> -		pl->link = NULL;
> +		pl->link = old_link;
> +		pl->flags = old_pl_flags;
> +		bpf_cgroup_storages_assign(pl->storage, old_storage);
>   	}
>   	bpf_cgroup_storages_free(new_storage);
> -	if (!old_prog) {
> +	if (!old_prog && !old_link) {
>   		hlist_del(&pl->node);
>   		kfree(pl);
>   	}
> +	cgrp->bpf.flags[atype] = old_flags;
>   	return err;
>   }
>   
