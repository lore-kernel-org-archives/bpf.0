Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810672F39C7;
	Sat, 11 Jul 2026 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755645; cv=none; b=KQMd5U/pR+RuizsnseoeZEmZdC0clqUzZIPpmBkX9tyWNvNdzFwt5XnR+KPXtUgYJNMPOtLLOHLAuUfgDqBD//ytU4AS/OsGkIbdEo6UIquVvSg91iGCM7HeO1Un6Zll07/Jys7QnJGwwi0oEod5UyRr+LaQTaWRpRtSohSGrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755645; c=relaxed/simple;
	bh=jyaVMBgBdH3BdAcMDeQs+QsdiDd8yWss8V2bp69B1UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSwHi11OD+nwkPM/cJ0IztHwG4lAphuUWlx1UMPCxRFws3wXRII0BQyu2v2XFg/1dcLeT7GOgPHYXVpE7qM2blfFsqyseIkBKUKgdoixo853fqZOX/I5cZcbZ6vphOT3bGI13EcSTg7NFhxcmQjG0uDh+F3xnHsMfLic3/m1j7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gy0wb4yrtzKHLtj;
	Sat, 11 Jul 2026 15:40:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2F9114073D;
	Sat, 11 Jul 2026 15:40:41 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDnzCh481FqcZNPAw--.188S2;
	Sat, 11 Jul 2026 15:40:41 +0800 (CST)
Message-ID: <1d4101d0-e84e-4af6-a07f-b269c2d98f3a@huaweicloud.com>
Date: Sat, 11 Jul 2026 15:40:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] bpf: Remove unnecessary dup/restore
 subprog_starts and prog clone
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, emil@etsalapatis.com,
 yonghong.song@linux.dev, a.s.protopopov@gmail.com, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev
References: <329e83120f0d88c2e5dc9d7bb2c0d38988959d32.1783775928.git.xukuohai@huaweicloud.com>
 <8cb15a4684938f4f0766c752a8cedaffde40f0abed7cb3e5247b390e3a68c84a@mail.kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <8cb15a4684938f4f0766c752a8cedaffde40f0abed7cb3e5247b390e3a68c84a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnzCh481FqcZNPAw--.188S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF1rXFW5Xr17ur4DJrW3Awb_yoWkZwcEy3
	y8AF48Cw4Dua1jqa1vkwsrWr40gw4kAr1xCr1kXr15Jwn8Aws5A3y8Jas5uFy5Xws3Grs8
	AanYq3ZY9wn8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/11/2026 2:28 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 25148865f9c76..232c02031fecb 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 37f22eb418540..80c8beb45ea04 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
> 
> [ ... ]
> 
>> @@ -1309,13 +1309,13 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
>>   	return 0;
>>
>>   out_jit_err:
>> -	if (blinded) {
>> +	if (cloned) {
>>   		bpf_jit_prog_release_other(orig_prog, prog);
>> -		/* roll back to the clean original prog */
>> +		/* roll back to the clean  original prog */
>>   		prog = env->prog = orig_prog;
> 
> This isn't a bug, but does the comment need the extra space between
> 'clean' and 'original'?
> 

No, the extra space should be removed.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29141596379

