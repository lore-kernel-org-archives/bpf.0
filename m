Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1854A341F
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003134; cv=none; b=UG1zreJUYVbB6xV3t30zlXCpItvKQpXonfQsIVEFc/7cJw6rkgpqd7d5ZPqXoLZfFjEE3c0V0OfV+DRtajbJVfbQVhevmT6K2hamHq1HcLC7v1s2j/HYjdNIpqtKvQKWGjrz6lvTmrzgx2+dz1x76/iRqDeglqfVZes7IG25ti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003134; c=relaxed/simple;
	bh=H88g9hW4UZ+8YvbJreYAaYNBhxdmpJiqEb2cx/0GvAg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UWiE1+HQqEmEw9KNUfxE4Q4cV718kMNEvTcnDFbdc9HsSNxifGMOXjpwkfw4UCJJL9dpwq98Qlu4RbnvslUHjjgGjGPE3g+Hsouq34bf9GrFs3bA7DCPNpxQcljV2+JH2hEPnsCGhIYe0eQ0TnRcGxX5p7sCJIoqGnyznc8CwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxOPL6d0ZqrfEAAA--.5510S3;
	Thu, 02 Jul 2026 22:38:50 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxacH4d0ZqXUa8AA--.15763S3;
	Thu, 02 Jul 2026 22:38:49 +0800 (CST)
Subject: Re: [PATCH bpf-next v6] bpf: Reject programs with inlined helpers if
 JIT is unavailable
To: KaFai Wan <kafai.wan@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev,
 Leon Hwang <leon.hwang@linux.dev>, Puranjay Mohan <puranjay@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20260702053127.23599-1-yangtiezhu@loongson.cn>
 <f61c41783f56fc259b56141e8d438a56c9dfa31b.camel@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f8e82ae2-78cd-bf91-ee7b-99a49289552a@loongson.cn>
Date: Thu, 2 Jul 2026 22:38:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f61c41783f56fc259b56141e8d438a56c9dfa31b.camel@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxacH4d0ZqXUa8AA--.15763S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw48ArWkGF1fXw4UXF1rZrc_yoWrXFWfpF
	ykC3WvkrWrWrZ2g397Ca18ur4avrZrCr9rKayrGr1YkFyqgrnaq3W7Kr1YyrsxWr48W3WI
	vwnFqFykGr1rXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
	vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWx
	JVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jjLvtUUUUU=

On 2026/7/2 下午8:16, KaFai Wan wrote:
> On Thu, 2026-07-02 at 13:31 +0800, Tiezhu Yang wrote:
>> When an architecture implements bpf_jit_inlines_helper_call(), such as
>> LoongArch, ARM64, PowerPC, and RISC-V, the verifier skips rewriting the
>> helper call offset (insn->imm) during the bpf_do_misc_fixups() phase,
>> because the helper is expected to be inlined by the JIT compiler. As a
>> result, insn->imm remains as the raw helper enum ID.

...

>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index ba09795e0bfd..f5c283af3cf7 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1889,6 +1889,7 @@ struct bpf_prog {
>>   		u8 digest[SHA256_DIGEST_SIZE];
>>   		u8 tag[BPF_TAG_SIZE];
>>   	};
>> +	u8			jit_required;	/* program strictly requires JIT compiler */
> 
> maybe 1 bit is enough. I'm not sure the layout matters, if not we can put behind sleepable:1.

Hi KaFai,

Thanks for the guidance.

I have placed jit_required:1 right behind sleepable:1
to keep the layout clean, and refactored the kfunc path.

I have just sent out the formal v7 patch series with
Suggested-by tags.

Here is the full pahole output for v7:

```
fedora@linux:~/703jit.git$ pahole -C bpf_prog ./vmlinux
struct bpf_prog {
	u16                        pages;                /*     0     2 */
	u16                        jited:1;              /*     2: 0  2 */
	u16                        jit_requested:1;      /*     2: 1  2 */
	u16                        gpl_compatible:1;     /*     2: 2  2 */
	u16                        cb_access:1;          /*     2: 3  2 */
	u16                        dst_needed:1;         /*     2: 4  2 */
	u16                        blinding_requested:1; /*     2: 5  2 */
	u16                        blinded:1;            /*     2: 6  2 */
	u16                        is_func:1;            /*     2: 7  2 */
	u16                        kprobe_override:1;    /*     2: 8  2 */
	u16                        has_callchain_buf:1;  /*     2: 9  2 */
	u16                        enforce_expected_attach_type:1; /*     2:10 
2 */
	u16                        call_get_stack:1;     /*     2:11  2 */
	u16                        call_get_func_ip:1;   /*     2:12  2 */
	u16                        call_session_cookie:1; /*     2:13  2 */
	u16                        tstamp_type_access:1; /*     2:14  2 */
	u16                        sleepable:1;          /*     2:15  2 */
	u16                        jit_required:1;       /*     4: 0  2 */

	/* XXX 15 bits hole, try to pack */
	/* XXX 2 bytes hole, try to pack */

	enum bpf_prog_type         type;                 /*     8     4 */
	enum bpf_attach_type       expected_attach_type; /*    12     4 */
	u32                        len;                  /*    16     4 */
	u32                        jited_len;            /*    20     4 */
	union {
		u8                 digest[32];           /*    24    32 */
		u8                 tag[8];               /*    24     8 */
	};                                               /*    24    32 */
	struct bpf_prog_stats *    stats;                /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u8 *                       active;               /*    64     8 */
	unsigned int               (*bpf_func)(const void  *, const struct 
bpf_insn  *); /*    72     8 */
	struct bpf_prog_aux *      aux;                  /*    80     8 */
	struct sock_fprog_kern *   orig_prog;            /*    88     8 */
	union {
		struct {
			struct {
			} __empty_insns;                 /*    96     0 */
			struct sock_filter insns[0];     /*    96     0 */
		};                                       /*    96     0 */
		struct {
			struct {
			} __empty_insnsi;                /*    96     0 */
			struct bpf_insn insnsi[0];       /*    96     0 */
		};                                       /*    96     0 */
	};                                               /*    96     0 */

	/* size: 96, cachelines: 2, members: 29 */
	/* sum members: 90, holes: 1, sum holes: 2 */
	/* sum bitfield members: 17 bits, bit holes: 1, sum bit holes: 15 bits */
	/* last cacheline: 32 bytes */
};
```

Here is the local test log for v7 when JIT is disabled,
it correctly rejects loading with -ENOTSUPP (-524) and
prevents the panic.

```
fedora@linux:~$ cat test_panic.c
   #include <linux/bpf.h>
   #include <bpf/bpf_helpers.h>

   SEC("kprobe/sys_getpid")
   int test_panic(void *ctx)
   {
   	struct task_struct *task;

   	task = (struct task_struct *)bpf_get_current_task();
   	if (task)
   		bpf_printk("Task address: %p\n", task);

   	return 0;
   }

   char LICENSE[] SEC("license") = "GPL";
fedora@linux:~$ clang -target bpf -O2 -g -c test_panic.c -o test_panic.o
fedora@linux:~$ sudo sysctl -w net.core.bpf_jit_enable=0
[sudo] password for fedora:
net.core.bpf_jit_enable = 0
fedora@linux:~$ sudo bpftool prog load test_panic.o 
/sys/fs/bpf/test_panic autoattach
libbpf: prog 'test_panic': BPF program load failed: unknown error (-524)
libbpf: prog 'test_panic': -- BEGIN PROG LOAD LOG --
processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1 
peak_states 1 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'test_panic': failed to load: -524
libbpf: failed to load object 'test_panic.o'
Error: failed to load object file
```

Thanks,
Tiezhu

