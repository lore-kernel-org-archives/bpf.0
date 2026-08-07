Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81933134CF;
	Fri,  7 Aug 2026 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074105; cv=none; b=UnHbW49AtvDw5FkOQYWjfSqC5ycRuAaqyzL9itPEvwGQlklGC+qRhexmiRIJKzOViudkKil4czWiDINFeE5INeziTTH2nKhI5oUdxT4K+8BMBEieP0sNLNSeUl0mSBBld5bWOv/t4bhH+1akJxWrGp/ftiixCEr9XLkyPZwLDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074105; c=relaxed/simple;
	bh=pwiUG79GIkEsYmtn3GH8uv3dTK71ctq2AghdGKdrFpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGtZzW8loOsWogtegIxndINDSA56oS3biQKoz4mA6mIW6QZs8w6YpE+DsV9VaeS4YfiMtgnadwYCH0HgVkqzZu0RhI/cP8T1lMlZ5cwzDbjcBdZY5OjxnfWFcPU84w5tNLaYKJ5LaDNbhesI7RXYkM92GMyBJ32dC3Td9SPEcNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hGVLc4LCRzKHMVb;
	Fri,  7 Aug 2026 11:41:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7B1934057D;
	Fri,  7 Aug 2026 11:41:37 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3s0LwU3VqnLadBQ--.6311S2;
	Fri, 07 Aug 2026 11:41:37 +0800 (CST)
Message-ID: <f8359409-4450-4bad-934e-b7f880d2101b@huaweicloud.com>
Date: Fri, 7 Aug 2026 11:41:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: ftrace: Fix ftrace_modify_call failure on kprobed
 functions
Content-Language: en-US
To: Paul Walmsley <pjw@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andy Chiu <andybnac@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
 Pu Lehui <pulehui@huawei.com>
References: <20260802094929.3978390-1-pulehui@huaweicloud.com>
 <4a7ed7d1-9eda-3082-81cb-5375b7839f29@kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <4a7ed7d1-9eda-3082-81cb-5375b7839f29@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgB3s0LwU3VqnLadBQ--.6311S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyUtryUurW5Xw45Ww15urg_yoW5WF1Dpr
	yfKanI9F4FyanFqay2gr15Cr18tayDAa4UAr1xGw1fAa4qkr18tw1xtr48J3s8JrZ8Aryf
	Z3Wqyr4DWryUAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/8/7 11:12, Paul Walmsley wrote:
> Hi,
> 
> On Sun, 2 Aug 2026, Pu Lehui wrote:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> We are frequently hitting the following splat during the riscv bpf
>> selftests:
>>
>> 00000000026dc75a: expected (7c3ff297) but got (00100073)
>> ------------[ ftrace bug ]------------
>> ftrace failed to modify
>> [<ffffffff03c44c1c>] bpf_kfunc_common_test+0x4/0x20 [bpf_testmod]
>>   actual:   e7:82:c2:ce
>> Updating ftrace call site to call a different ftrace function
>> ftrace record flags: 80100002
>>   (2)
>>   expected tramp: ffffffff80043904
>> ------------[ cut here ]------------
>> WARNING: kernel/trace/ftrace.c:2278 at ftrace_bug+0x46e/0x4b0, CPU#1: test_progs/98
>> ...
>> [<ffffffff80008f4e>] ftrace_bug+0x46e/0x4b0
>> [<ffffffff803d3e86>] ftrace_replace_code+0x16e/0x170
>> [<ffffffff803d42b6>] ftrace_modify_all_code+0x12e/0x1b8
>> [<ffffffff800430f4>] arch_ftrace_update_code+0x14/0x28
>> [<ffffffff803e0324>] ftrace_startup+0x14c/0x2a0
>> [<ffffffff803e133c>] ftrace_startup_subops+0x584/0x1050
>> [<ffffffff804500e6>] register_ftrace_graph+0x4e6/0x1018
>> [<ffffffff804cf9f6>] register_fprobe_ips+0xc66/0x12f8
>> [<ffffffff8049abe8>] bpf_kprobe_multi_link_attach+0x5d8/0xe68
>> [<ffffffff8050fcaa>] __sys_bpf+0x3d5a/0x47f0
>> [<ffffffff805107ee>] __riscv_sys_bpf+0xae/0x168
>> [<ffffffff80034d78>] syscall_handler+0x60/0x100
>> [<ffffffff8228b4f4>] do_trap_ecall_u+0x174/0x208
>> [<ffffffff822b69c4>] handle_exception+0x16c/0x178
>>
>> After debugging, it can be triggered by similar commands below:
>> ```
>> echo do_nanosleep > set_ftrace_filter
>> echo function > current_tracer
>> echo 'p do_nanosleep' > kprobe_events
>> echo 1 > events/kprobes/enable
>> echo 'f do_nanosleep' > dynamic_events
> 
> I guess you meant
> 
> echo 'f do_nanosleep' >> dynamic_events
> 
> instead?
> 
>> echo 1 > events/fprobes/enable
>> ```
>>
>> The reason is that attaching a kprobe to an ftrace-traced function entry
>> replaces its initial auipc insn with ebreak. When ftrace_modify_call
>> later runs, it expects auipc insn, so verification fails and triggers
>> ftrace_bug.
>>
>> The expected auipc logic remains conceptually unchanged, and kprobe
>> single-stepping ensures normal execution. Therefore, if the first insn
>> is ebreak, bypassing the check to continue patching the jalr insn is
>> safe and avoids ftrace failures.
>>
>> Fixes: b2137c3b6d7a ("riscv: ftrace: prepare ftrace for atomic code patching")
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> I queued the patch with the reproduction sequence updated as mentioned
> above for v7.2-rc.  Please let me know ASAP if you don't agree -

Thanks Paul, total agree to update.

> 
> 
> - Paul

