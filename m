Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927E36605A;
	Tue, 30 Jun 2026 02:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786563; cv=none; b=OlMHbi43zoxDY/eUB3prvJlmrbo9rztaUW97rglTvYCnZGryngharc9eKOTA4S1rcV4lfLeupPVlT/vx78SKrLnBiR63rkBMw5R5yACgRg3BGJe2nKdRhbhS14Ue1B+TCRKUJkyfeevv2HtqWstq85YFFCASui46NxLbudmWTTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786563; c=relaxed/simple;
	bh=juTJQJWa3HS79THiD/lohh02iaQ6EKMAcfxyy/1PGXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSUUn9SuBL9cxdIrp3jK7h/FXm0fgr1J5ORi2B0yqIGqdRP7B9bDwQ86MLAEAIt7VzYPdsvV+zLzzmJG+yJ0yGW+Pv9RxtRhZVST2TAVQUFwk+qrqdWUQcjjawKlUBD2YC6c6nMGLJlsm36w3bNllp5v9qQLrMEw9nCSkZeuFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gq6Wq5yGyzYQtfg;
	Tue, 30 Jun 2026 10:28:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D570B40590;
	Tue, 30 Jun 2026 10:29:15 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgDH_Cb6KUNqKow+AQ--.27894S2;
	Tue, 30 Jun 2026 10:29:15 +0800 (CST)
Message-ID: <06c23b18-b385-45d0-a602-a82c00f5aab8@huaweicloud.com>
Date: Tue, 30 Jun 2026 10:29:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 00/12] bpf: Introduce static-defined tracing
 probe for BPF
Content-Language: en-US
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
 Rong Tao <rongtao@cestc.cn>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <855e44f3-d22c-47e5-8bd1-c5d9f7014a75@linux.dev>
 <ec28f0f9-0693-4c9b-88fa-bffca446a63c@huaweicloud.com>
 <b8d8ab5e-bef1-4c95-8e5b-ea9768041b2e@linux.dev>
 <55499fcf-d552-4366-9016-21ede7f687ac@huaweicloud.com>
 <4f30012f-778b-4c7d-b610-2e18cf01abdd@linux.dev>
 <678ec73d-06f1-4860-94be-be000ca462d4@huaweicloud.com>
 <b4b906cb-e7b2-4ba7-bbb9-e6c813238859@linux.dev>
 <8ea18b6a-932c-4eb0-a536-d52ce3e1f457@huaweicloud.com>
 <1f10e056-744e-45bf-af93-6192668be79c@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <1f10e056-744e-45bf-af93-6192668be79c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDH_Cb6KUNqKow+AQ--.27894S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWDtrWDZFW5Gw48Cry8Xwb_yoWftrX_u3
	s5ur1vywsF9r1xXr4rtF18AFWxKr4UArWUXFW5uF45J395Ja92qr4DK3srZwn3trW8WFsI
	vrZxJa4xZr429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/30/2026 10:14 AM, Leon Hwang wrote:
> On 30/6/26 09:19, Xu Kuohai wrote:
>> On 6/29/2026 9:53 PM, Leon Hwang wrote:
>>
>> So it is more of a user-space workaround than a formal solution. And even
>> for this workaround, there is no need to add a new libbpf API to remove the
>> stub. You can simply build two versions of bpf prog, one with subprog and
>> one without. When you need to trace fentry, load the first one; otherwise,
>> load the second one.
> 
> Yep.
> 
>>
>> What SDT resolves is dynamic tracing after the prog is loaded, the hacking
>> before loading does not apply.
>>
> I think current implementation is too complicated to justify this kind
> of workaround. I'd be more comfortable with a simpler approach.
>

Right, the implementation is indeed in a somewhat prototype state and needs
polish. The RFC was sent out to check if this is a worthwhile direction. I'll
craft a cleaner, refined version after getting more feedback.

> Thanks,
> Leon

