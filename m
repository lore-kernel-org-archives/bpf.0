Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792562;
	b=TtkMDJOMR5VDY7Si+aq6futXSw4nezNpZuQ+Sgr4wlzBMJ/nDyOhCQG9gop69GyItVA+
	 W/otB5eG678J/uWUA+iyU/x54PswozMMZ39PzJXEcJc/f3LPj4LgToOHqOClQN+korPYt
	 2cNSU5ZQnYxGAIpOH7ogbM9Z27ZnTiHvMWaZMy6SjjlPAOVP8py+SSxd+YXgFm05EmmAk
	 YmmyN0S9iLmLVGsuJARU3TJtTB6jGkUUOoY5aOSyHUUCcVgxvuBgpv1SDq0kTkc8JXMy/
	 iqTXpcCdU7iK+b2WuLbkip5nkRLZzNrFVhGwAodBnOKUF7RfA9V+6g/O+jNQIXglHrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792562;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=UovAB91mpmRvk0vwp+7ZyfpwJL8uSdEUcyWvQiIlTp0=;
	b=mZ3CRdohbVzW0Vzrtj+rPZtY/6m1meB5FwdtaFXoVQtOvncAdo7ITdCAS+6pDaqOOhYT
	 WS0RrCK+M+zGt/bsHnwmLOrz0ffHmrrMPcNyepIKm3Zbfurx8/6AVviOVGDNmQuhANLSa
	 AxQjQvh6L18QYKXi9yQIZtMwgq66nKZlYpjAKHa8+HXWIc+LYrB1oGGzcIwSBWVBc1EWf
	 smK173Ax6N3u9yuMbcI4drZyJKcHJ7oQqMkOAFxeT4RzObbodTffquy061l4XybGciUSP
	 AlYZ7wvr0OfW3y9Xon7NDyat4khVd7Bxk92MJfCR8g+KT0wZdnQYBfN5vq9ofA/hQNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81105606A31C;
	Fri, 27 Nov 2026 15:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81105606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jbcRy2Mjsz1c0Qv;
	Fri, 27 Nov 2026 23:15:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3591F40573;
	Fri, 27 Nov 2026 23:15:51 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgA3dfSlnglrgroaGA--.48334S2;
	Fri, 27 Nov 2026 23:15:51 +0800 (CST)
Message-ID: <5b1c03a4-f910-4f97-af3e-1b8c328dd1ba@huaweicloud.com>
Date: Fri, 27 Nov 2026 23:15:49 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Introduce a classic BPF filter cache for seccomp
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jens Axboe <axboe@kernel.dk>
References: <cover.1795139109.git.xukuohai@huaweicloud.com>
 <DN0AIFQ82CFP.34SDTH6ZFZC1G@gmail.com>
 <309b8e49-2f9c-4a2f-9b40-8e7e7cce3455@huaweicloud.com>
 <DN5F4EBDNESC.3UOJRTCXCL4HI@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <DN5F4EBDNESC.3UOJRTCXCL4HI@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3dfSlnglrgroaGA--.48334S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5Aw4ftr1fJFyxGryrtFb_yoW5JFWxpF
	ZxtrWftw1UJw12vw17Xr4UWryrZw4DWFyrGr15Ww4xurn0kr1IgF1Ikw48urWY9ryrG3yF
	yr4qqrZ3Xrn8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 11/27/2026 4:17 AM, Alexei Starovoitov wrote:
> On Thu, Nov 26, 2026 at 07:02 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>> After further profiling, I found that this collapse is
>> mainly caused by Firecracker instances queuing on the
>> global pack_mutex in bpf_prog_pack_alloc(). So a better
>> approach is to replace the global mutex to per-pack locks.
>> I will work on that instead.
> 
> Makes sense to fix it there. Every prog load benefits.
> But I doubt that per-pack locks help.
> bpf_prog_pack_alloc() walks pack_list from the head and takes the first
> pack that has room. All loaders pick the same pack and queue on its lock.
> 
> I suspect the hold time comes from these:
> 
>    path   under pack_mutex            what it does
>    -----  --------------------------  --------------------------------
>    alloc  bpf_arch_pred_flush()       x86: IBPB via on_each_cpu()
>    free   bpf_arch_text_invalidate()  x86: text_poke_set(), text_mutex
>    free   bpf_arch_text_invalidate()  arm64: kick_all_cpus_sync()
> 
> Every free marks its pack dirty. A cBPF alloc from a dirty pack flushes.
> The log of commit a9b1f19a6a67 ("bpf: Prefer packs that won't trigger
> an IBPB flush on allocation") has ideas how to flush less.
> 
> bpf_arch_text_invalidate() doesn't need pack_mutex. The bits of the
> chunks are still set in pack->bitmap at that point, so nobody can take
> the chunks or free the pack.
> 
> What do you see in your profile?

Hi Alexei,

You are correct.

The benchmark server is arm64. The lock hold times in bpf_prog_pack_alloc()
and bpf_prog_pack_free() are typically 8–16 us and 256–512 us, respectively.

The free path is dominated by bpf_arch_text_invalidate(), which sends IPIs
to all CPUs and waits for completion. The wait happens after put_cpu(), so
the task is preemptible. If the task is preempted, other lock waiters remain
blocked until it is scheduled back and releases the lock. This can extend
the lock hold time to seconds.

Below is a sample of the captured preemption stack:

-> bpf_prog_pack_free
   -> bpf_arch_text_invalidate
     -> aarch64_insn_set
       -> __text_poke
         -> kick_all_cpus_sync
           -> smp_call_function_many_cond
             -> el1h_64_irq
               -> el1h_64_irq_handler
                 -> el1_interrupt
                   -> arm64_exit_to_kernel_mode_preempt
                     -> irqentry_exit_cond_resched
                       -> preempt_schedule_irq
                         -> __schedule

After moving bpf_arch_text_invalidate() out of pack_mutex, the p99 VM
startup latency drops from 2.79 s to 170 ms under the same workload.

I will post the patch once it is ready.

