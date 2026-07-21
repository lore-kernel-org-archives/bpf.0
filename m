Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4C449B2B;
	Tue, 21 Jul 2026 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784605100; cv=none; b=c5Du8md6PqK9NyzqEjorovqt5iuqS3HUIh/9AgQKu5Q+/E22V1aVPYHpbyJXSs+nNjp4+WtI94o2kfcDwlDi1n/thbXEEawmKI7fAC6PrVpQG1+FRM8NevcsZ2s8BXu56UoZFzXgH7c/gZ8rm84naOtU9kwVk+gKfLrtkhcVzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784605100; c=relaxed/simple;
	bh=C7SfukGJF0NhfpNaZ7z4q79yVZHYEI75XYo59Kvg2zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rB2Xa+Eo2O8jN5g1qvWo6EBj1r5ZNg1rGOXx0kB7GMbI/8IHtF/RGJ0o5UZwMMSw+xodVCv60ur4beH+GoObXxNUQq4YLlD9T7hI82Uyiq5SO0tDtMEIKfVv5c6j73ESlzru76vlUSTaueLeXMkR7SM+YZe123jOVAOF4/jDEBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h433t1glQzKHN3l;
	Tue, 21 Jul 2026 11:37:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A78C2407F0;
	Tue, 21 Jul 2026 11:38:11 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHrSmi6V5qf9z2Bw--.36951S2;
	Tue, 21 Jul 2026 11:38:11 +0800 (CST)
Message-ID: <edbedc4f-773b-4edd-a43c-c451ac380bb2@huaweicloud.com>
Date: Tue, 21 Jul 2026 11:38:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 3/4] bpf: Fix potential UAF when reading bpf link
 info
Content-Language: en-US
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20260720134547.1289964-1-pulehui@huaweicloud.com>
 <20260720134547.1289964-4-pulehui@huaweicloud.com>
 <1289e62e-e956-40c9-a93b-22feefb9110f@gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <1289e62e-e956-40c9-a93b-22feefb9110f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDHrSmi6V5qf9z2Bw--.36951S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1kJrWUArWkGF13uw45KFg_yoWfWry5pF
	W3CFyUCr4rXr47ur15Ar1rur1SyF4UZ3WUJr97G34Fy3W7uws3JryxKF17ZFn0yrZ7Jw1I
	gryqqrWxKr1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/20 22:16, Mykyta Yatsenko wrote:
> 
> On 7/20/26 2:45 PM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> In bpf_link_show_fdinfo and bpf_link_get_info_by_fd, link->prog is
>> accessed without holding any locks. If the prog is concurrently replaced
>> via bpf_link_update, the old prog can be freed, leading to a potential
>> UAF issue.
>>
>> Fix this by holding both normal RCU and tasks trace RCU read locks
>> before dereferencing the prog, as BPF_LINK_TYPE_ITER support both
>> non-sleepable and sleepable progs.
>>
>> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   kernel/bpf/syscall.c | 27 +++++++++++++++++++++++----
>>   1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 6db306d23b47..2458c68146b9 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3471,9 +3471,10 @@ static const char *bpf_link_type_strs[] = {
>>   static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>>   {
>>   	const struct bpf_link *link = filp->private_data;
>> -	const struct bpf_prog *prog = link->prog;
>> +	const struct bpf_prog *prog;
>>   	enum bpf_link_type type = link->type;
>>   	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
>> +	u32 prog_id;
>>   
>>   	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
>>   		if (link->type == BPF_LINK_TYPE_KPROBE_MULTI)
>> @@ -3490,13 +3491,23 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>>   	}
>>   	seq_printf(m, "link_id:\t%u\n", link->id);
>>   
>> +	/* prog can be sleepable */
>> +	rcu_read_lock_trace();
>> +	rcu_read_lock();
> 
> Only rcu_read_lock() should be enough, see 57b23c0f612d ("bpf: Retire rcu_trace_implies_rcu_gp()")
> Did you manage to reproduce the UAF?

This is also what I found a bit weird, although nesting rcu and rcu_tt 
isn't a problem in itself. Based on commit 57b23c0f612d, RCU Tasks Trace 
grace period implies RCU grace period., so rcu_read_lock is already 
sufficient. Thank you very much, Mykyta. :)


As for reproducing UAF, it's not so difficult to trigger:

Sleep for a while in bpf_link_show_fdinfo after fetching link->prog to 
enlarge the race window and allow the RCU grace period to advance.

```
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3411,6 +3411,8 @@ static void bpf_link_show_fdinfo(struct seq_file 
*m, struct file *filp)
         }
         seq_printf(m, "link_id:\t%u\n", link->id);

+       msleep(2000);
+
         if (prog) {
                 bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
                 seq_printf(m,
```

and the following selftests:

prog_tests/link_info_race.c
```
#include <pthread.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include <test_progs.h>

#include "link_info_race.skel.h"

#define MAX_ITERATIONS    1000000

static volatile bool stop_flag;

static void *updater_thread(void *arg)
{
     int link_fd = *(int *)arg;
     struct link_info_race *skel = NULL;
     int prog_fd1, prog_fd2;
     int err, i = 0;

     skel = link_info_race__open_and_load();
     if (!skel) {
         fprintf(stderr, "updater: failed to open skeleton\n");
         return NULL;
     }

     prog_fd1 = bpf_program__fd(skel->progs.iter_prog_non_sleepable);
     prog_fd2 = bpf_program__fd(skel->progs.iter_prog_sleepable);

     while (!stop_flag && i++ < MAX_ITERATIONS) {
         int new_fd = (i % 2) ? prog_fd1 : prog_fd2;

         err = bpf_link_update(link_fd, new_fd, NULL);
         if (err && errno != EINVAL && errno != EBUSY) {
             fprintf(stderr, "updater: bpf_link_update failed: %s\n", 
strerror(errno));
         }
     }

     link_info_race__destroy(skel);
     return NULL;
}

static void *reader_thread(void *arg)
{
     int link_fd = *(int *)arg;
     char buf[4096];
     int fd, i = 0;
     struct bpf_link_info info;
     __u32 len;

     while (!stop_flag && i++ < MAX_ITERATIONS) {
         snprintf(buf, sizeof(buf), "/proc/self/fdinfo/%d", link_fd);
         fd = open(buf, O_RDONLY);
         if (fd >= 0) {
             read(fd, buf, sizeof(buf) - 1);
             close(fd);
         }
     }

     return NULL;
}

void test_link_info_race(void)
{
     struct link_info_race *skel = NULL;
     pthread_t tid_updater, tid_reader;
     int link_fd, err;

     skel = link_info_race__open_and_load();
     if (!ASSERT_OK_PTR(skel, "open_and_load"))
         return;

     link_fd = 
bpf_link_create(bpf_program__fd(skel->progs.iter_prog_non_sleepable),
                               0, BPF_TRACE_ITER, NULL);
     if (!ASSERT_GE(link_fd, 0, "bpf_link_create")) {
         link_info_race__destroy(skel);
         return;
     }

     stop_flag = false;
     err = pthread_create(&tid_updater, NULL, updater_thread, &link_fd);
     if (!ASSERT_OK(err, "pthread_create_updater")) {
         close(link_fd);
         link_info_race__destroy(skel);
         return;
     }

     err = pthread_create(&tid_reader, NULL, reader_thread, &link_fd);
     if (!ASSERT_OK(err, "pthread_create_reader")) {
         stop_flag = true;
         pthread_join(tid_updater, NULL);
         close(link_fd);
         link_info_race__destroy(skel);
         return;
     }

     sleep(10);

     stop_flag = true;
     pthread_join(tid_updater, NULL);
     pthread_join(tid_reader, NULL);

     close(link_fd);
     link_info_race__destroy(skel);
}
```

progs/link_info_race.c
```
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

char _license[] SEC("license") = "GPL";

SEC("iter/task")
int iter_prog_non_sleepable(struct bpf_iter__task *ctx)
{
     return 0;
}

SEC("iter.s/task")
int iter_prog_sleepable(struct bpf_iter__task *ctx)
{
     return 0;
}
```

It will trigger UAF:

```
root@(none):/mnt/bpf# ./test_progs -v -a link_info_race
bpf_testmod.ko is already unloaded.
Loading bpf_testmod.ko...
Successfully loaded bpf_testmod.ko.
test_link_info_race:PASS:open_and_load 0 nsec
test_link_info_race:PASS:bpf_link_create 0 nsec
test_link_info_race:PASS:pthread_create_updater 0 nsec
test_link_info_race:PASS:pthread_create_reader 0 nsec
WATCHDOG: test case link_info_race executes for 10 seconds...
[   65.037682] Unable to handle kernel access to user memory without 
uaccess routines at virtual address 0000000000000020
[   65.038461] Current test_progs pgtable: 4K pagesize, 57-bit VAs, 
pgdp=0x00000001020af000
[   65.038758] [0000000000000020] pgd=000000004061ec01, p4d=0000000000000000
[   65.039910] Oops [#1]
[   65.040065] Modules linked in: bpf_testmod(OE) [last unloaded: 
bpf_testmod(OE)]
[   65.041009] CPU: 2 UID: 0 PID: 111 Comm: test_progs Tainted: G 
    OE       7.2.0-rc3-g0bcca2a42cc5-dirty #12 PREEMPTLAZY
[   65.041576] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   65.041788] Hardware name: riscv-virtio,qemu (DT)
[   65.042087] epc : bpf_link_show_fdinfo+0xe6/0x188
[   65.043062]  ra : bpf_link_show_fdinfo+0xdc/0x188
[   65.043276] epc : ffffffff801a1cce ra : ffffffff801a1cc4 sp : 
ff2000000058bbc0
[   65.043538]  gp : ffffffff81dba048 tp : ff60000080f53500 t0 : 
ffffffff8001e2d8
[   65.043787]  t1 : 0000000000006000 t2 : ff60000080f53610 s0 : 
ff2000000058bc20
[   65.044044]  s1 : ff6000008184b800 a0 : ff6000008209c4d0 a1 : 
ff200000000bd020
[   65.044288]  a2 : ff2000000058bbd0 a3 : 0000000000000030 a4 : 
ff2000000058bbe0
[   65.044542]  a5 : 0000000000000000 a6 : ffffffff8105e620 a7 : 
000000000000000e
[   65.044799]  s2 : ff6000008209c4d0 s3 : ff200000000bd000 s4 : 
ff600000802ebc80
[   65.045049]  s5 : 00007fffbeabc880 s6 : 0000000000000000 s7 : 
0000000000080000
[   65.045305]  s8 : 00007fffbf57dce0 s9 : ff2000000058bd00 s10: 
00007fffbeabc140
[   65.045554]  s11: 0000000000000001 t3 : ff600001fffc3900 t4 : 
ff60000080f53600
[   65.045828]  t5 : 000000000000024f t6 : 000000000000024f ssp : 
0000000000000000
[   65.046078] status: 0000000200000120 badaddr: 0000000000000020 cause: 
000000000000000d
[   65.046482] [<ffffffff801a1cce>] bpf_link_show_fdinfo+0xe6/0x188
[   65.046855] [<ffffffff803bd01e>] seq_show+0x14e/0x1f0
[   65.047068] [<ffffffff80354d04>] seq_read_iter+0xc4/0x350
[   65.047284] [<ffffffff80355074>] seq_read+0xe4/0x118
[   65.047485] [<ffffffff8031d3ec>] vfs_read+0xb4/0x2e0
[   65.047681] [<ffffffff8031e312>] ksys_read+0x6a/0xf0
[   65.047875] [<ffffffff8031e3b8>] __riscv_sys_read+0x20/0x30
[   65.048075] [<ffffffff80a727fe>] do_trap_ecall_u+0x256/0x458
[   65.048315] [<ffffffff80a81634>] handle_exception+0x16c/0x178
[   65.049112] Code: fb04 3097 003a 80e7 bac0 b783 0509 0613 fb04 854a 
(5394) 1597
[   65.049821] ---[ end trace 0000000000000000 ]---
[   65.050483] Kernel panic - not syncing: Fatal exception
[   65.050874] SMP: stopping secondary CPUs
[   65.051646] ---[ end Kernel panic - not syncing: Fatal exception ]---
```

