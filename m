Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AE409278;
	Mon, 20 Jul 2026 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549846; cv=none; b=rZdPEeNu67VvHssMj98mxskCO3RwzKXRycl1Q5UYiRzxXrwl797XUzQ5SlvA126PTqqWLpvQj5TfBS+bnEqnmLBjHzgWrmkMHJG71qzgJo9Z/JfrReD4Cl8zHHAtHSGmK/ocvl0gB2Yg3iMtdSjNuJrUF3z0qeP2CASJPkMm/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549846; c=relaxed/simple;
	bh=HQxSx5CU82tCOihowjVZJN57y2ZpK0Cp2PfnhmPATuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6N8bTwtUeZzWgIUFblyZNXk9UKN/E1iLVSRjkX2TKBBJMkvgMRYQdf4Vx2eWfQ0yHHyEXcTmZrt6IFt12eg0uHhn2PObP8+rPm3T8PWEYcf3tmfmj8Ilr35inOXNZyQ5uv8nEOoWX2BdLAQhIuWGfGw/NHL+wPPooUeeCPNMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h3fdZ2DwszYQv0q;
	Mon, 20 Jul 2026 20:16:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DB6564056E;
	Mon, 20 Jul 2026 20:17:15 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgB3h3PKEV5qteOkBw--.22716S2;
	Mon, 20 Jul 2026 20:17:15 +0800 (CST)
Message-ID: <f610a87b-5d8d-4241-a1fe-9c6338371afd@huaweicloud.com>
Date: Mon, 20 Jul 2026 20:17:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/3] bpf: Fix potential UAF when reading bpf link
 info
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 yonghong.song@linux.dev, song@kernel.org, jolsa@kernel.org,
 emil@etsalapatis.com, pulehui@huawei.com, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260720033055.1215477-2-pulehui@huaweicloud.com>
 <27e047ceba0b38f4f51e932d9d256d280a4370fb66beca03ed7a3148b6600b19@mail.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <27e047ceba0b38f4f51e932d9d256d280a4370fb66beca03ed7a3148b6600b19@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB3h3PKEV5qteOkBw--.22716S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr48Aw4ruw4rWrW7GryrCrg_yoW8Wryfpa
	48GFnxCw1qg3yUX3WIqr45WFWSgF4v9ry5JFn8Wry09FnYvanagry8Cr43ZFyY9Fn0gr4I
	qw4aqw1xA347Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIb
	yZUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/20 12:04, bot+bpf-ci@kernel.org wrote:
>> In bpf_link_show_fdinfo and bpf_link_get_info_by_fd, link->prog is
>> accessed without holding any locks. If the prog is concurrently replaced
>> via bpf_link_update, the old prog can be freed, leading to a potential
>> UAF issue.
>>
>> Fix this by holding both normal RCU and tasks trace RCU read locks
>> before dereferencing the prog, as BPF_LINK_TYPE_ITER support both
>> non-sleepable and sleepable progs.
>>
>> Fixes: f9d041271cf4 ("bpf: Refactor bpf_link update handling")
> 
> Is the Fixes: tag pointing at the right commit?
> 
> f9d041271cf4 ("bpf: Refactor bpf_link update handling") only refactored
> the existing update path into the bpf_link_ops->update_prog method.  It
> does not look like it introduced the ability to concurrently replace and
> free link->prog.
> 
> The unlocked reader in bpf_link_show_fdinfo() already existed by then,
> and the racing replacement path (the BPF_LINK_UPDATE command with
> xchg(&link->prog, new_prog) followed by bpf_prog_put(old_prog)) seems to
> have first appeared in:
> 
>    0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
> 
> Should the tag instead be:
> 
>    Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")

make sense.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29715011327

