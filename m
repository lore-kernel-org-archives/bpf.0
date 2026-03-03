Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914636E47C
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581623; cv=none; b=VMkrVNpARiuBeyBLxSNTR+eWaTklKZnUJGgsVYUe605ZFTPYP+ZaVEL4ukvGr82s+VvNpH3+e/gCFcruxJ2TDdSAYFGUgfZhox6JMhicmtR2oYoDoyaWuXksH3eIbdzDZdtGU61/5pezFaSlqGMglm0hdLSVC+QAwAQw7xNZPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581623; c=relaxed/simple;
	bh=DgInQPOfs7MW7QQlMUzTCZwgBNKkyEcFmnyMp9LRJR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoG8VRc2tMyMq4S2X1xcxeAG0/2cndEUjpljt9msaEgzz16XAZIpWGxA9OqHMM1nBug2YZ8j/Tx7OLbd58wR9n4hmE5qPzh/2SyJ1LEz5Mgu4fetahU2XJ8g0E67U40eHuOFFnDFTbEScnwo97S7B/GnqaUkDROYvv2YGFTZGxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TPzO0BUB; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TPzO0BUB"
Message-ID: <e8196fcb-899c-46e0-b2d6-f23bfe3a3b93@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772581619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yz6EaLjPjIbUsTph7dOC7bDL2IBKayJuLespoWR10Xg=;
	b=TPzO0BUB5pvmnmtM0G9iLFwYceuvlGTvYydjoUrLdMwhBKa3H8gEuHOe//QtF9Aa/x9H31
	ZwS4Mn0BSackIlSuNGX3a3YuoE4bPcPQtodoH6lRvEznVoyLdqrNJTd1UKn5ESns3ClrgR
	BOHmyOrT7pbjscZ/oVIQogLs5SaKGak=
Date: Tue, 3 Mar 2026 15:46:54 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4] bpf: fix: Race condition in
 bpf_trampoline_unlink_cgroup_shim
To: patchwork-bot+netdevbpf@kernel.org, xulang <xulang@uniontech.com>
Cc: andrii@kernel.org, ast@kernel.org, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, clm@meta.com, daniel@iogearbox.net, dddddd@hust.edu.cn,
 dzm91@hust.edu.cn, eddyz87@gmail.com,
 hust-os-kernel-patches@googlegroups.com, ihor.solodrai@linux.dev,
 kaiyanm@hust.edu.cn, martin.lau@kernel.org, sdf@fomichev.me,
 yonghong.song@linux.dev
References: <851F26B7D9E91336+20260303083626.1107524-1-xulang@uniontech.com>
 <177258060605.1514859.8771485378779224297.git-patchwork-notify@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <177258060605.1514859.8771485378779224297.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/3/26 3:30 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to bpf/bpf.git (master)
> by Martin KaFai Lau <martin.lau@kernel.org>:
> 
> On Tue,  3 Mar 2026 16:36:26 +0800 you wrote:
>> From: Lang Xu <xulang@uniontech.com>
>>
>> The root cause of this bug is that when `bpf_link_put` reduces the
>> refcount of `shim_link->link.link` to zero, the resource is considered
>> released but may still be referenced via `tr->progs_hlist` in
>> `cgroup_shim_find`. The actual cleanup of `tr->progs_hlist` in
>> `bpf_shim_tramp_link_release` is deferred. During this window, another
>> process can cause a use-after-free via `bpf_trampoline_link_cgroup_shim`.
>>
>> [...]
> 
> Here is the summary with links:
>    - [bpf,v4] bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim
>      https://git.kernel.org/bpf/bpf/c/56145d237385

The bot is confused. It replied to v4 and v5. Only v5 is landed.

