Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC718CBE1;
	Thu, 23 Jul 2026 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769745; cv=none; b=GHQlIqjeMGiLp+113XaJoQYKLdh83j408ojbx3ADrscIxIFOHxF3bfayTt3Qz1eHN8cwVSv9pS8aGKAJCK8mlStdWzqy2BmYiPeu3O1S+pI8hrQSNM5SaymWugB3ed3+qY8mUgJRxeMqpcxIpYtbwJjF5Y5zpV7eixFIz5Qc5mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769745; c=relaxed/simple;
	bh=jsYnsAuIV7nn/QoJxTvMjmd+uVU6+Dy934+ksuCGQoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jveCuL4zCcFxMraxn3ev6kDqVSxkrZceh26cKsMZXt81EXQ65VuyXJpjSnD0kOiy2Tmc0OXu3kJpTB7sGtGnYMLZm7F6g9E83S1noVyc9RaY587R4ACyGUrEGrjKtBzEcLdl0tm7TO9VszvuUS+5MwxVnUVHxe+j6/p3y8UaXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h5CyJ1dtrzYQtsG;
	Thu, 23 Jul 2026 09:21:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2557D4058D;
	Thu, 23 Jul 2026 09:22:14 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDnzCjEbGFqO_TdCA--.62649S2;
	Thu, 23 Jul 2026 09:22:13 +0800 (CST)
Message-ID: <5a1b92a7-95ee-4411-b691-f54eeeee8a02@huaweicloud.com>
Date: Thu, 23 Jul 2026 09:22:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/4] bpf, arm64: Fix memory leak in bpf_jit_free
Content-Language: en-US
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Hengqi Chen <hengqi.chen@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20260722112754.1615201-1-pulehui@huaweicloud.com>
 <20260722112754.1615201-2-pulehui@huaweicloud.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260722112754.1615201-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnzCjEbGFqO_TdCA--.62649S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4DGF4DJr15tw48WF4Durg_yoW8Xr13pF
	Wqkw13C3yqgF1vkF4DJw4xZFy8uws5Xw1Yk34Uur4rKFnIgr92gF1Yk3y7ua98ArWUGw4r
	WrWY9rnxua4kJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/22/2026 7:27 PM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When bpf_int_jit_compile() is called for subprograms, it returns early
> during the first pass (!prog->is_func || extra_pass is false), keeping
> ctx->offset alive for the subsequent extra pass.
> 
> If JIT compilation fails for a later subprogram, the BPF core aborts and
> calls bpf_jit_free() to clean up the first subprogram. However,
> bpf_jit_free() fails to free jit_data->ctx.offset, which causes a memory
> leak of the JIT context offsets array.
> 
> Fix this by adding the missing kvfree(jit_data->ctx.offset) in
> bpf_jit_free().
> 
> Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 4cdc7dfb05ba..f4e4d4578e38 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -3237,6 +3237,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>   		 */
>   		if (jit_data) {
>   			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
> +			kvfree(jit_data->ctx.offset);
>   			kfree(jit_data);
>   		}
>   		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();

Acked-by: Xu Kuohai <xukuohai@huawei.com>

