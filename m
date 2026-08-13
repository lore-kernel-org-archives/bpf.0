Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696E42D6E64
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786588427; cv=none; b=QpPOuEwOx+w+eGauAIP0atN9DauELD862S2PxpN2MjAgQtKf/rwHVJjuJMfG9Qef80hlLYAohjyG2GD0bZJwDHB29yGehbgcQnPlMyAVsi1tRIXqQgsNvtRUhjT1MHJJXo65bBwWqY0AcGGwtUVh9oR/vtfaAcqbTMSgkIyeLos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786588427; c=relaxed/simple;
	bh=mfcoaHzFUlYbi6SscVdtoCboZavxA3EYKtz1pthvlUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Im58DTE00okeuc8VhEa9ubpmiKxRcqLBiWFTTCWsSJGubCJ0wACj+udeCL1OILOIHb/L3KPRyANC9GpCbqawgipAgZGVoyTkTSpVgq9lJJIqQ4rtAS3F06q2P6Krxp83cDW+tgOxa6LdaQe/j4zpq5Moe4Mb+e/PzEaG8UvaUXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hL8YM3gmCzYQtnT
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 10:33:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8304340981
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 10:33:33 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3Z0b8LH1qUU94CA--.47281S2;
	Thu, 13 Aug 2026 10:33:33 +0800 (CST)
Message-ID: <953b1c77-01d0-4a8c-aecd-00df353c6222@huaweicloud.com>
Date: Thu, 13 Aug 2026 10:33:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/7] bpf, arm64: __arena kfunc and struct_ops
 arguments
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org,
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <DKND9FBAR1JE.3713OP933LYT3@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <DKND9FBAR1JE.3713OP933LYT3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgB3Z0b8LH1qUU94CA--.47281S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1fCrWfurWxZrW3KFW7Jwb_yoW3AFgE93
	40y393uw1xWr1xGFW3KF13ArW7JFZ5WF10qr15WrWjy3s0yryUZFsay34kK3yxA3y7Ww4a
	vFn8Xa40yrW2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/13/2026 7:50 AM, Kumar Kartikeya Dwivedi wrote:
> On Mon Aug 10, 2026 at 9:09 PM CEST, Puranjay Mohan wrote:
>> The x86-64 JIT recently gained support for the __arena and
>> __arena__nullable argument suffixes on kfuncs and struct_ops stubs. This
>> adds the arm64 side and flips bpf_jit_supports_arena_args() on, so the
>> verifier stops rejecting these programs on arm64.
>>
> 
> Hi Xu,
> 
> If you have cycles this week, could you take a look at these changes and let us
> know they make sense?
> 
> It would allow us to close both x86 support (already landed) and arm64 support
> for arena arguments for next merge window (next week). No worries if you need
> more time to go through these though. Just bumping the thread.
>

OK, I'll take a look at it soon, thanks.

> Thanks!
> 
>> [...]
> 

