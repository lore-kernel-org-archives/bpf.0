Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8B837F8CF
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776657815; cv=none; b=H80mJuO0hOTQar6xyPOqez5+nbo798q76z/5nrn1vbcec5iCTPTaRCZeuMehYU5jcCRNcI4lJIksZFRRaozMMNA8GtioN9JuTHGFL1WEY/CjwPV3pH3KRMFvWOlkBkKlFi/3lMeQL8QqolRfsUeeaJB7DJMU1dkZLbjEdsb5MeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776657815; c=relaxed/simple;
	bh=4mT3dFg7/3gOalW2PBSx7RyeKxDvyW5mKVZhJlH+DtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vA66xUzgserVnu/rA3EL/OwS71Y02/ZH159o+bIJOS8i65m9v0NtLOqo8/h1YwHJ/XToHkjahA5PLM3FygvBpZi7H4wdqtTLU2BiNnaK77pTOdY/CzuvuV67YwnYUzTvVs8bIj9jzrPXfvkQ14MD15swQfHah0O/LbOIbRUWeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fzWzx6VPTzKHMT9
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:03:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E1C8640601
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:03:26 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgCHam+NpeVpJBEzBA--.30887S2;
	Mon, 20 Apr 2026 12:03:26 +0800 (CST)
Message-ID: <e1e83e9e-8161-4096-8163-21ff3c9ae629@huaweicloud.com>
Date: Mon, 20 Apr 2026 12:03:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 6/6] bpf, arm64: Add JIT support for cpu time
 counter kfuncs
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kernel-team@meta.com
References: <20260418131614.1501848-1-puranjay@kernel.org>
 <20260418131614.1501848-7-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260418131614.1501848-7-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCHam+NpeVpJBEzBA--.30887S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur48ZF48GFWxtF4kKw1rWFg_yoWktwb_Wr
	n3tF97Way7Xrsa9F17G3W3XFZ3A392yryktrW0gFWIv3W7J3yDJrykXr98uFnYga1fXrnx
	Wrs3Zw4SvFnxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/18/2026 9:16 PM, Puranjay Mohan wrote:
> Add ARM64 JIT inlining for bpf_get_cpu_time_counter() and
> bpf_cpu_time_counter_to_ns() kfuncs.
> 
> bpf_get_cpu_time_counter() is JIT-inlined as:
> 
>    ISB                       // serialize instruction stream
>    MRS Xn, CNTVCT_EL0        // read architected timer counter
> 
> The ISB before the MRS is required for ordering, matching the kernel's
> arch_timer_read_cntvct_el0() implementation.
> 
> On newer CPUs it will be JITed to:
> 
>    MRS Xn, CNTVCTSS_EL0      // self-synchronized (ISB not needed)
> 
> bpf_cpu_time_counter_to_ns() is JIT-inlined using mult/shift constants
> computed at JIT time from the architected timer frequency (CNTFRQ_EL0):
> 
>    MOV Xtmp, #mult           // load conversion multiplier
>    MUL Xn, Xarg, Xtmp        // delta_ticks * mult
>    LSR Xn, Xn, #shift        // >> shift = nanoseconds
> 
> On systems with a 1GHz counter (e.g., Neoverse-V2), mult=1 and shift=0,
> so the conversion collapses to a single MOV (identity).
> 

ISB triggers pipeline flush and instruction refetch. Since it is a really heavy
operation, I think We should collect performance data to verify whether the
jited instructions are actually faster than the original bpf_ktime_get_ns().

