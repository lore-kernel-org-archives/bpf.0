Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4639EF0F;
	Wed,  1 Jul 2026 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886282; cv=none; b=muf0w4G2I44qlFn7PN+gfJpbTYTIECF9g44nQ3V2EtaXPRP1lE9xpoaRbUF9KYp0JYFOXDpx9T6xhSmZU7gHQJB1+qCJqozlvrqs8XzB232tpcA0EeVK0PQIuAYkVKx+X6Z/TzAvAeYhdblzyKVDWT71fx7p6OlPb3ElbrVzST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886282; c=relaxed/simple;
	bh=ZMy8PZaoXj/6U4GDnfHUvK3S/HTJccSHp3onDTh6/hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieAfyk3XdFYueobBHbr1vxE6NVUX7D94pdtgFTvYJhoXTyLTjketZWjPFlOO/02lDl+kpSm4TC7+cccjSxG4nP1O4RVATSRw3RgpBT+mR0KFgU82VlK13ztvIPv/DXrmLeAiO6tBdFXDVV2OsHDBc18y6oI/biiIEZTG2BAFXaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqqQL491lzKHLwm;
	Wed,  1 Jul 2026 14:11:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C48D14056D;
	Wed,  1 Jul 2026 14:11:15 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDnVfOCr0Rq5sLMAQ--.50422S2;
	Wed, 01 Jul 2026 14:11:15 +0800 (CST)
Message-ID: <b4c10ece-f199-4205-bb60-cdf07548e915@huaweicloud.com>
Date: Wed, 1 Jul 2026 14:11:14 +0800
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
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 Eyal Birger <eyal.birger@gmail.com>, Rong Tao <rongtao@cestc.cn>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <DJMQ5HY26JFM.3QOFH7X8RTPIL@gmail.com>
 <5335390d-6627-49fb-9645-ebcce410277b@huaweicloud.com>
 <akSUyRNYp6hx7BK+@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <akSUyRNYp6hx7BK+@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnVfOCr0Rq5sLMAQ--.50422S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1xuF1rAw17tw1DZw43Wrg_yoW5uF4xpF
	1UXas8KFWDAayqka40qayYvr1YyrsxGrWDWr15t34xu3Z0gr1xtFsrtrWYkF1Y9ry0k34I
	vF4jv3s3ury5Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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

On 7/1/2026 12:17 PM, Anton Protopopov wrote:
> On 26/07/01 10:18AM, Xu Kuohai wrote:
>> On 7/1/2026 6:07 AM, Alexei Starovoitov wrote:
>>> On Sat Jun 27, 2026 at 3:51 PM PDT, Xu Kuohai wrote:
>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>
>>>> This series introduces static-defined tracing probes for BPF programs.
>>>> BPF SDT (static-defined tracing) works similarly to USDT. User defines
>>>> probes in the BPF source code. The probes are built into NOP instructions
>>>> in the ELF. At runtime, when an observer is attached, the NOP instruction
>>>> is patched to a CALL instruction to the observer prog trampoline.
>>>>
>>>> Unlike USDT, BPF SDT requires explicit macros to generate the function
>>>> prototype BTF for each probe. This allows the verifier to validate the
>>>> probe sites against the declared types, and observer programs can be
>>>> attached similarly to normal tracing programs using the function prototype
>>>> information.
>>>>
>>>> A probe with two arguments in the target program can be declared and defined
>>>> like:
>>>>
>>>>       BPF_SDT_DECLARE2(my_trace, int, int);
>>>>
>>>>       SEC("xdp")
>>>>       int xdp_prog(struct xdp_md *ctx)
>>>>       {
>>>>           int len = ctx->data_end - ctx->data;
>>>>           int ret = XDP_DROP;
>>>>           ...
>>>>           BPF_SDT_PROBE2(my_trace, len, ret);
>>>>           ...
>>>>       }
>>>>
>>>> An observer would be like:
>>>>
>>>>       SEC("bpf_sdt")
>>>>       int BPF_PROG(observer_prog, int len, int ret)
>>>>       {
>>>>           bpf_printk("len=%d ret=%d\n", len, ret);
>>>>           return 0;
>>>>       }
>>>>
>>>> The target program and probe site for the observer program should be set
>>>> at load time via bpf_program__set_attach_target() manually, since program
>>>> names are not unique and program IDs are allocated at runtime - there is
>>>> no static way to identify the target program.
>>>>
>>>> For BPF_SDT_DECLARE2(my_trace, int, int) and BPF_SDT_PROBE2(my_trace, len, ret)
>>>> macros, the compiler produces:
>>>>
>>>>     [code section, e.g. xdp]
>>>>         goto +0                  // NOP, patched to CALL at attach time
>>>>
>>>>     [.bpf_sdt_notes section]
>>>>         ___sdt_jt_my_trace:      // symbol marking this entry's boundary
>>>>         .quad  0b                // 8 bytes: offset of the NOP in the code
>>>>                                  // section (resolved by the linker via
>>>>                                  // R_BPF_64_ABS64 relocation)
>>>>         r1 = %[arg1_reg]         // 8 bytes per argument: BPF move insn
>>>>                                  // whose src_reg field encodes the BPF
>>>>                                  // register holding each probe argument
>>>>         r2 = %[arg2_reg]
>>>>
>>>>         ....
>>>>
>>>>     [.BTF section]
>>>>         FUNC_PROTO (int, int) -> void   // from BPF_SDT_DECLARE2 stub
>>>>         DECL_TAG "bpf_sdt:my_trace:2"   // keyed by name + nargs
>>>
>>> Interesting idea and encoding scheme, but I don't think we need it.
>>> I'd rather see static_branch/jmp work that Anton started to be completed.
>>> That would be more generic and folks that need SDT-like observability
>>> inside bpf progs can instead guard their debug code with static_branches.
>>> SDT equivalent would be static branch plus a call to nop function
>>> which can be freplaced.
>>
>> Sounds like this is similar to the kernel tracepoint approach. I'll
>> hold this work and recheck if a dedicated SDT-like function is still
>> needed once Anton's static key work is posted.
> 
> Yes, one of the reasons for adding static branches was tracing.
> I will post an updated patch set soon and cc you.
>
Great, thanks!

