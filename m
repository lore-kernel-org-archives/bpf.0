Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75F346E7D
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785118605; cv=none; b=T/pIjqcLAsotvjWuXECwTZ5yC0j45cRspIW+irYZxzJPKRVySBYNnNi2al7ZEu67ZfkVoGU/HcRlNBuBSg0r6ELrRpgyW1kTNJvhI9Lu8ZQEcE5SiU8v6c3Ppt+YnbxGvgNN71qBMiJ1RwS7H5r22KoBAtvjhJ2N6qZDRJZCqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785118605; c=relaxed/simple;
	bh=xzbmg4Ol+zkQBpFqdxehI+797KgrzmXMCCWs50WMrXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVdE0ROygKeR+n8B4W0RwsfCayvwlaCzd0c/D7SRFSycFZy3FNVyHgc0mGuB2I+mv6bAGAx5oHHLX6TZ6jNfR4iHAAtH6OT2YsopkCrL0TLTlkZivmpIQhIMWcXO4tlZgtRXo8mVNZuiH/5utu5S9AsLKYYxDTuwuFiv2nqPUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h7hz8397dzYQthl
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 10:16:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4F10A40703
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 10:16:41 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34Iduv2ZqmyBZAA--.3224S3;
	Mon, 27 Jul 2026 10:16:41 +0800 (CST)
Message-ID: <b3ba4b33-f1e5-40a3-a112-7d35ecb33840@huaweicloud.com>
Date: Mon, 27 Jul 2026 10:16:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/9] parisc: Fix memory leak in bpf_jit_free
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260725154915.2488611-1-pulehui@huaweicloud.com>
 <20260725154915.2488611-4-pulehui@huaweicloud.com>
 <20260725155419.4B7DC1F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260725155419.4B7DC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgB34Iduv2ZqmyBZAA--.3224S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5Gw4DAr15Cry7XF45GFg_yoW8uFWDpF
	Z5Gry5uF9Y9rWvgr4kJw18CFW5twsrGa4UGFyUu3yfuF90gw1DGFWak395Wa98Ar18ua18
	trWFgryfurykJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7
	M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4U
	JVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
	uYvjxUzWrWUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/25 23:54, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Pre-existing memory leak of the allocated JIT image (`jit_data->header`) in `bpf_int_jit_compile()` if `build_body()` fails during an iteration after the image is allocated.
> --
> 
> --- Patch [3]: [PATCH bpf-next v3 3/9] parisc: Fix memory leak in bpf_jit_free ---
> commit 91fdce2769b7bfc645bd4e9356cd152dd1568159
> Author: Pu Lehui <pulehui@huawei.com>
> 
> parisc: Fix memory leak in bpf_jit_free
> 
> If a subprogram fails to JIT in jit_subprogs(), previously JITed
> subprograms are freed. However, the generic bpf_jit_free() fails to
> free their leftover jit_data, causing a memory leak.
> 
>> diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_core.c
>> index 172770132440d..ef63c38bdf151 100644
>> --- a/arch/parisc/net/bpf_jit_core.c
>> +++ b/arch/parisc/net/bpf_jit_core.c
>> @@ -178,6 +178,25 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>>   	goto out_offset;
>>   }
> 
> [Severity: High]
> This is a pre-existing issue, but does bpf_int_jit_compile() leak
> jit_data->header on some error paths?
> 
> Looking at bpf_int_jit_compile(), if build_body() fails during an iteration
> after the image is allocated:
> 
> 	for (i = 0; i < NR_JIT_ITERATIONS; i++) {
> 		...
> 		if (build_body(ctx, extra_pass, ctx->offset))
> 			goto out_err;
> 		...
> 		if (ctx->ninsns == prev_ninsns) {
> 			if (jit_data->header)
> 				break;
> 			...
> 			jit_data->header = bpf_jit_binary_alloc(...);
> 
> The code jumps to out_err, which falls through to out_offset (seen above):
> 
> out_err:
> 	if (extra_pass) {
> 		...
> 	}
> 	goto out_offset;
> 
> However, the out_offset cleanup block only frees ctx->offset and jit_data,
> and skips freeing the already allocated jit_data->header:
> 
> out_offset:
> 		kfree(ctx->offset);
> 		kfree(jit_data);
> 		prog->aux->jit_data = NULL;
> 
> Could this lead to a memory leak of the JIT image buffer?
> 
> [ ... ]
> 

will fix if have new version, or will send new patch

