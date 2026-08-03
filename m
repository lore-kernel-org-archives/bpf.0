Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9520ADF8
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723111; cv=none; b=a8raL7HAb/kNnUq+VhSL886pkKC57scqSxowHbWNfsqPQfrL7P2IK7LS3vBQpmW5HLzDqJsa+GvLiimqvxTJL+sUUNdy58mhLrHuFzhRg5RSgMKUJGECnTatZohi98hGd+3grA9296bES1x0iaJyPiQvBforKDKBezY2DmUHZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723111; c=relaxed/simple;
	bh=vMe+KDs9KpRo1PgVH/I4P2G972B31ZsFlfANzgqY0ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEm12at3UYb7T+Q0+J+XEUe5PCcBkFoDijKb07ORa7F0IkS4QFlqLyNsPZ9v0j4EIV2Z+T8SMJAKXLJ6lvToMQlSMf8iEF2Eq4nYpSOs7XDp/e+Nh7yhA6/5CEIra1TLzjvBISylNWXUZmK8wM0NkhoPQ56Xcvifs8nGik7SYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hD0Xs4JzYzKHMMW
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 10:11:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id DA61B40D61
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 10:11:43 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBnoUDe+G9qpxKsAw--.21977S2;
	Mon, 03 Aug 2026 10:11:43 +0800 (CST)
Message-ID: <94b537d2-2d51-433d-a3e6-7ce9cd3bfd64@huaweicloud.com>
Date: Mon, 3 Aug 2026 10:11:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3] bpf, cgroup: Fix invalid storage access after
 __cgroup_bpf_attach failed
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260803013934.4036646-1-pulehui@huaweicloud.com>
 <20260803015036.E47F71F00A3D@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260803015036.E47F71F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBnoUDe+G9qpxKsAw--.21977S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZw4UXFWruw1ftr13urg_yoW5Gr1fpF
	s8J3WUKw1YgrZYv3Z7K34xZa4S9w4kKr15K395tw18ur43Xr90gryxurWY9a9xZFs7uw1x
	tr1YvFs2kw1jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/8/3 9:50, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] When updating a cgroup BPF link via `bpf_link_update`, `__cgroup_bpf_replace` does not allocate new `cgroup_storage` for the new program and lacks map compatibility checks, leading to severe out-of-bounds kernel memory access.
> --
> 
> --- Patch [1]: [PATCH bpf v3] bpf, cgroup: Fix invalid storage access after __cgroup_bpf_attach failed ---
> commit 91e5396c1d1312a251035a5e4902151e56fc5bdf
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf, cgroup: Fix invalid storage access after __cgroup_bpf_attach failed
> 
> This commit fixes a potential invalid storage access issue when replacing a
> cgroup BPF program in multi-attach mode fails midway. It saves the old
> program's state and storage prior to the update, and properly restores them
> in the cleanup path on error.
> 
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 4355ccb78a9c6..57fd1d784e440 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
> 
> [ ... ]
> 
> While reviewing this file, I noticed a potential issue in __cgroup_bpf_replace():
> 
>> static int __cgroup_bpf_replace(struct cgroup *cgrp,
>> 				struct bpf_cgroup_link *link,
>> 				struct bpf_prog *new_prog)
>> {
> [ ... ]
>> 	cgrp->bpf.revisions[atype] += 1;
>> 	old_prog = xchg(&link->link.prog, new_prog);
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this function properly handle
> cgroup_storage when replacing the program?
> 
> If a user replaces an existing cgroup BPF program using bpf_link_update with
> a new program that uses a BPF_MAP_TYPE_CGROUP_STORAGE map with a larger
> value_size, could this result in an out-of-bounds memory access?
> 
> It appears we swap the attached BPF program on the link here without
> verifying that the new program's cgroup_storage maps have identical
> value sizes to the old program, nor do we allocate new appropriately
> sized storage buffers.
> 
> Since the verifier authorized the memory access for the new program based on
> its larger map size, could bpf_get_local_storage return the smaller old
> buffer leading to out-of-bounds read and write accesses?

The following patch has been covered this issue.

https://lore.kernel.org/bpf/20260728133058.2858367-1-pulehui@huaweicloud.com/

> 
>> 	replace_effective_prog(cgrp, atype, pl);
>> 	bpf_prog_put(old_prog);
>> 	return 0;
>> }
> 

