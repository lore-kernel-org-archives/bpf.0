Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997328469A;
	Wed, 25 Feb 2026 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983799; cv=none; b=c+u+FlvjfUGHfCOaZHoB5Qmdh/TciSmTQUbKLrqutt5w/PtNxfLO19AfGR4kyr5pYnPMB2upnISvAdbq2V1K96j9FMpMFkmhhJulxEDlXxxBj2mmW0AKEDpFCE08Km91dwHcsMj5PdYYBcy0OVNrEM9jK/hPhFg5aJC77AXy4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983799; c=relaxed/simple;
	bh=y2aFqO9WIx16UYSditB/wfiMc0vDSTODgR5FYkfmN3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaSQGpDNIoMEnAZGsjJb6pBReF4xmpsQ3LrEL0csDpxgqK7dnbjvg54GKuiF3R3d9+kZJS3psR6N12zZNoycbieuqbm94d/hLewJcjn8Ybzf/VQjUKH7fe85cdRtHY9gXNy+th8tMQ01Rxspxa1WgOStGyst51hfbdIVwKXsiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fLHQM0t7bzKHMMv;
	Wed, 25 Feb 2026 09:42:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2D1B240576;
	Wed, 25 Feb 2026 09:43:14 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgB3MOawU55pvV0aIg--.2510S2;
	Wed, 25 Feb 2026 09:43:13 +0800 (CST)
Message-ID: <c402e95a-26d3-47eb-8249-52ece97989d3@huaweicloud.com>
Date: Wed, 25 Feb 2026 09:43:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: bpf: Fix UBSAN misaligned access in BPF JIT
Content-Language: en-US
To: Fuad Tabba <tabba@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>,
 Jean-Philippe Brucker <jpb@kernel.org>
References: <20260224093128.1926610-1-tabba@google.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260224093128.1926610-1-tabba@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB3MOawU55pvV0aIg--.2510S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw45Zw45Gw1kJrWrGr48JFb_yoW8Xw1rpa
	yDGwnIyFWqgr4jga18ta1DCrW5ua1vqF43GFyUG3yrtF98Xr97WF15K343uFZxGrZ8Gw4f
	ZFyUKr13u3WkJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 2/24/2026 5:31 PM, Fuad Tabba wrote:
> struct bpf_plt contains a u64 'target' field. The BPF JIT allocator
> was using an alignment of 4 bytes (sizeof(u32)), which could lead
> to the 'target' field being misaligned in the JIT buffer.
> 
> Increase the alignment requirement to 8 bytes (sizeof(u64)) in
> bpf_jit_binary_pack_alloc() to guarantee proper alignment for
> struct bpf_plt.
> 
> Fixes: b2ad54e1533e9 ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 356d33c7a4ae..adf84962d579 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2119,7 +2119,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
>   	image_size = extable_offset + extable_size;
>   	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
> -					      sizeof(u32), &header, &image_ptr,
> +					      sizeof(u64), &header, &image_ptr,
>   					      jit_fill_hole);
>   	if (!ro_header) {
>   		prog = orig_prog;

Good catch. build_plt pads NOP instructions to ensure a 64-bit relative offset for
plt target, but it misses the alignment check for image base itself.

Acked-by: Xu Kuohai <xukuohai@huaweicloud.com>

nit: Add check for base alignment in build_plt, or a comment to clarify?

