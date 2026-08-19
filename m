Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692019F121;
	Wed, 19 Aug 2026 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110901; cv=none; b=pmWlIBEhz47vOKto0yLRIsGkCSCABeIMrmMakMzQQjaeZW808q8aWx/1YxP1qI+FIKo+huSHV8Y2TxuENDshTQ2UVJ3Do48lTStVgH4pnEndHdDRhHvJuB7Dgl2y0dtgnhqyAhy5ViTNulKICBGwMAx/Chy5XvJi1R+Tj5jHveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110901; c=relaxed/simple;
	bh=VVdxYlVk3Z4rA00QLnrFa4FgdNSWCSlJ8XwxuC1/sPg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=BEL4pk3+Y2OndYLfRUhVVpMVnQb4k7D1rU+KryrVtVrTjG88gZvrUpNPogOMYClTtiJCyjd1dKQl2+a+armsSK/pz/X6XPGxR0s92JAYI4+G/T99b+DL7kqu9xvaToFJQ8/ILMymNfLWHo6MO6ecNqfpiYL2/LVkWp6kpL6LRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rmBsn313; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rmBsn313"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZrPuPOBmVfVWOOXrIVWVaTVmfGyieHoTBzLjPjrT0sc=;
	b=rmBsn313FBwyQbzJfZoLYwOjhXeAfYylrm+hMl83g2lrxxHyLZKLaqyY0wCt9DYW3w9lz/iJ9
	zJM/KGr9aQaPu4JzxbnTDbQ2pqP7eh2oXCNQo9wYJzyfhb+Dh4SAwhm5UeiEhcXH3RMciaW76X4
	2BvS6zSvYOAQG8hMoJAXZfM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hPsXn0RfHzRhVN;
	Wed, 19 Aug 2026 11:30:49 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 6248F4057F;
	Wed, 19 Aug 2026 11:41:28 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 19 Aug
 2026 11:41:27 +0800
Message-ID: <4ba94268-cd39-438c-a788-a5b75cfd8813@huawei.com>
Date: Wed, 19 Aug 2026 11:41:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf, riscv: Add support for signed arena
 loads
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
To: Chen Pei <cp0613@linux.alibaba.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<memxor@gmail.com>, <bjorn@kernel.org>, <puranjay@kernel.org>,
	<eddyz87@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <shuah@kernel.org>,
	<guoren@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1786708960.git.cp0613@linux.alibaba.com>
 <3445fb0231f9c72496ae840e9dca675b15899433.1786708960.git.cp0613@linux.alibaba.com>
 <c5441b7e-3d20-4e4e-a225-7478f7fb9d6d@huawei.com>
In-Reply-To: <c5441b7e-3d20-4e4e-a225-7478f7fb9d6d@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)

oops

need to revert this reviewed-by

On 2026/8/18 22:27, Pu Lehui wrote:
> 
> 
> On 2026/8/17 15:24, Chen Pei wrote:
>> Signed loads from arena memory are currently rejected on riscv64, as
>> bpf_jit_supports_insn() refuses BPF_MEMSX loads when in_arena is set,
>> while x86 and arm64 gained support for them in v6.18. Compilers such
>> as GCC-14 are free to generate signed loads into arena memory, which
>> breaks loading of otherwise valid BPF programs on riscv64.
>>
>> Implement BPF_PROBE_MEM32SX support in the RV64 JIT by reusing the
>> existing arena handling: the arena base (RV_REG_ARENA) is added to
>> the source register and the load is emitted with sign extension
>> (lb/lh/lw). Add BPF_PROBE_MEM32SX to the add_exception_handler()
>> mode gate so that faulting loads get an exception table entry which
>> clears the destination register and resumes execution.
>>
>> Verified by running the arena LDSX selftests (arena_ldsx_disasm,
>> arena_ldsx_exception, arena_ldsx_s8/s16/s32) on riscv64 QEMU, all
>> passing.
>>
>> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
>> ---
>>   arch/riscv/net/bpf_jit_comp64.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c 
>> b/arch/riscv/net/bpf_jit_comp64.c
>> index f9d5347ba966..5786f7dfc8a7 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -777,6 +777,7 @@ static int add_exception_handler(const struct 
>> bpf_insn *insn, int dst_reg,
>>       if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
>>           BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
>>           BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
>> +        BPF_MODE(insn->code) != BPF_PROBE_MEM32SX &&
>>           BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
>>           return 0;
>> @@ -1902,13 +1903,19 @@ int bpf_jit_emit_insn(const struct bpf_insn 
>> *insn, struct rv_jit_context *ctx,
>>       case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
>>       case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
>>       case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
>> +    /* LDX | PROBE_MEM32SX: dst = *(signed size *)(src + RV_REG_ARENA 
>> + off) */
>> +    case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
>> +    case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
>> +    case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
>>       {
>>           bool sign_ext;
>>           sign_ext = BPF_MODE(insn->code) == BPF_MEMSX ||
>> -               BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
>> +               BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
>> +               BPF_MODE(insn->code) == BPF_PROBE_MEM32SX;
>> -        if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
>> +        if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
>> +            BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) {
>>               emit_add(RV_REG_T2, rs, RV_REG_ARENA, ctx);
>>               rs = RV_REG_T2;
>>           }
>> @@ -2126,10 +2133,6 @@ bool bpf_jit_supports_insn(struct bpf_insn 
>> *insn, bool in_arena)
>>               if (insn->imm == BPF_CMPXCHG)
>>                   return rv_ext_enabled(ZACAS);
>>               break;
>> -        case BPF_LDX | BPF_MEMSX | BPF_B:
>> -        case BPF_LDX | BPF_MEMSX | BPF_H:
>> -        case BPF_LDX | BPF_MEMSX | BPF_W:
>> -            return false;
>>           }
>>       }
> 
> Reviewed-by: Pu Lehui <pulehui@huawei.com>
> 

Hi Chen Pei,

It's happy for the verifier_ldsx, but it not happy for the other test, 
pls take a look.

[2026-08-19 11:33:11]  root@(none):/mnt/bpf# ./test_progs -a arena_atomics
[2026-08-19 11:33:18]
[2026-08-19 11:33:20]  [   34.529770] bpf_testmod: loading out-of-tree 
module taints kernel.
[2026-08-19 11:33:20]  [   34.530186] bpf_testmod: module verification 
failed: signature and/or required key missing - tainting kernel
[2026-08-19 11:33:21]  [   35.541256] ------------[ cut here ]------------
[2026-08-19 11:33:21]  [   35.541573] WARNING: 
arch/riscv/net/bpf_jit_comp64.c:915 at add_exception_handler+0xce/0xf0, 
CPU#0: test_progs/122
[2026-08-19 11:33:21]  [   35.544546] Modules linked in: bpf_testmod(OE)
[2026-08-19 11:33:21]  [   35.545885] CPU: 0 UID: 0 PID: 122 Comm: 
test_progs Tainted: G           OE 
7.2.0-next-20260818-00007-gc29447b2149d #8 PREEMPTLAZY
[2026-08-19 11:33:21]  [   35.546625] Tainted: [O]=OOT_MODULE, 
[E]=UNSIGNED_MODULE
[2026-08-19 11:33:21]  [   35.546892] Hardware name: riscv-virtio,qemu (DT)
[2026-08-19 11:33:21]  [   35.547240] epc : add_exception_handler+0xce/0xf0
[2026-08-19 11:33:21]  [   35.547538]  ra : bpf_jit_emit_insn+0x5a8/0x2d18
[2026-08-19 11:33:21]  [   35.547799] epc : ffffffff8002571e ra : 
ffffffff8002b3c8 sp : ff20000000eeb700
[2026-08-19 11:33:21]  [   35.548128]  gp : ffffffff81db8ed0 tp : 
ff60000083130d40 t0 : ffffffff8001e650
[2026-08-19 11:33:21]  [   35.548454]  t1 : 0000000000000007 t2 : 
0000000000000040 s0 : ff20000000eeb710
[2026-08-19 11:33:21]  [   35.548785]  s1 : 00000000000000fb a0 : 
0000000000000007 a1 : 000000000000000a
[2026-08-19 11:33:21]  [   35.549114]  a2 : ff600000809549a0 a3 : 
ffffffff78000790 a4 : ff60000080a8bc24
[2026-08-19 11:33:21]  [   35.549439]  a5 : 0000000000000087 a6 : 
ffffffff78000664 a7 : 0000000000000089
[2026-08-19 11:33:21]  [   35.549765]  s2 : ff600000809549a0 s3 : 
ff2000000017d1e8 s4 : 0000000000000000
[2026-08-19 11:33:21]  [   35.550094]  s5 : 0000000000000001 s6 : 
0000000000000001 s7 : 0000000000000031
[2026-08-19 11:33:21]  [   35.550419]  s8 : ff60000084994800 s9 : 
0000000000000000 s10: 0000000000000000
[2026-08-19 11:33:21]  [   35.550737]  s11: 000000084290e9f4 t3 : 
0000000000000000 t4 : 000000000000000b
[2026-08-19 11:33:21]  [   35.551079]  t5 : 0000000000000008 t6 : 
ff600000808fc3a0 ssp : 0000000000000000
[2026-08-19 11:33:21]  [   35.551409] status: 0000000200000120 badaddr: 
ffffffff8002571e cause: 0000000000000003
[2026-08-19 11:33:21]  [   35.551882] [<ffffffff8002571e>] 
add_exception_handler+0xce/0xf0
[2026-08-19 11:33:21]  [   35.552318] [<ffffffff8002b3c8>] 
bpf_jit_emit_insn+0x5a8/0x2d18
[2026-08-19 11:33:21]  [   35.552602] [<ffffffff80024f1a>] 
bpf_int_jit_compile+0x9a/0x480
[2026-08-19 11:33:21]  [   35.552888] [<ffffffff801a3d0c>] 
__bpf_prog_select_runtime+0x10c/0x1d8
[2026-08-19 11:33:21]  [   35.553197] [<ffffffff801d54fa>] 
bpf_check+0xaca/0x31b8
[2026-08-19 11:33:21]  [   35.553459] [<ffffffff801a8436>] 
bpf_prog_load+0x546/0xad0
[2026-08-19 11:33:21]  [   35.553720] [<ffffffff801af850>] 
__sys_bpf+0x1948/0x2c38
[2026-08-19 11:33:21]  [   35.553974] [<ffffffff801b0b6a>] 
__riscv_sys_bpf+0x2a/0x40
[2026-08-19 11:33:21]  [   35.554238] [<ffffffff80a91872>] 
do_trap_ecall_u+0x1ea/0x398
[2026-08-19 11:33:21]  [   35.554528] [<ffffffff80aa088c>] 
handle_exception+0x16c/0x178
[2026-08-19 11:33:21]  [   35.555320] ---[ end trace 0000000000000000 ]---
[2026-08-19 11:33:21]  serial_test_arena_atomics:PASS:arena atomics 
skeleton open 0 nsec
[2026-08-19 11:33:21]  libbpf: prog 'add': BPF program load failed: 
-ENOTSUPP
[2026-08-19 11:33:21]  libbpf: prog 'add': -- BEGIN PROG LOAD LOG --
[2026-08-19 11:33:21]  processed 37 insns (limit 1000000) 
max_states_per_insn 0 total_states 1 peak_states 1 mark_read 0
[2026-08-19 11:33:21]  -- END PROG LOAD LOG --
[2026-08-19 11:33:21]  libbpf: prog 'add': failed to load: -ENOTSUPP
[2026-08-19 11:33:21]  libbpf: failed to load object 'arena_atomics'
[2026-08-19 11:33:21]  libbpf: failed to load BPF skeleton 
'arena_atomics': -ENOTSUPP
[2026-08-19 11:33:21]  serial_test_arena_atomics:FAIL:arena atomics 
skeleton load unexpected error: -524 (errno 524)
[2026-08-19 11:33:21]  #1       arena_atomics:FAIL
[2026-08-19 11:33:21]
[2026-08-19 11:33:21]  All error logs:
[2026-08-19 11:33:21]  serial_test_arena_atomics:PASS:arena atomics 
skeleton open 0 nsec
[2026-08-19 11:33:21]  libbpf: prog 'add': BPF program load failed: 
-ENOTSUPP
[2026-08-19 11:33:21]  libbpf: prog 'add': -- BEGIN PROG LOAD LOG --
[2026-08-19 11:33:21]  processed 37 insns (limit 1000000) 
max_states_per_insn 0 total_states 1 peak_states 1 mark_read 0
[2026-08-19 11:33:21]  -- END PROG LOAD LOG --
[2026-08-19 11:33:21]  libbpf: prog 'add': failed to load: -ENOTSUPP
[2026-08-19 11:33:21]  libbpf: failed to load object 'arena_atomics'
[2026-08-19 11:33:21]  libbpf: failed to load BPF skeleton 
'arena_atomics': -ENOTSUPP
[2026-08-19 11:33:21]  serial_test_arena_atomics:FAIL:arena atomics 
skeleton load unexpected error: -524 (errno 524)
[2026-08-19 11:33:21]  #1       arena_atomics:FAIL
[2026-08-19 11:33:21]  Summary: 0/0 PASSED, 0 SKIPPED, 1/0 FAILED
[2026-08-19 11:33:21]  root@(none):/mnt/bpf#
