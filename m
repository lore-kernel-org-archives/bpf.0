Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E562EBB8D
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112749; cv=none; b=B856NdPbgP+xZ99YbR7heARAmsRoq8ICPNkkXZmcMI1jbeUj8Bemb5TagvsJ+BR79+tSNCLHJ0FQTK6Hq4J5VNFFzDU1gnBfNISbG2BMRP3DfjboivW0CCYl64lzfatef3id8WXNUUCq7lwv2e9fHLZmYRBeixrT66dSct9+U4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112749; c=relaxed/simple;
	bh=7m7syOs1gD5W9Jz1PtLFXWzV5Kqkfqnh5sc+5M+foB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gd9Od0bbbYfdWtSe1dp/nV8fSDx+VkKAbUPj56oXQkoheneO/GN8xq3vMSQ2mA60vBXUVQB9f9pyTngKOolifKpemVqJHit2CpshVs72o5SiI3u5SX8+JKHJFYtnTN4gks7+sDxef27GzsJA97/qQwizgYp5aqzITIwkJiWEV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RKPVlvSD; arc=none smtp.client-ip=91.218.175.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RKPVlvSD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7m7syOs1gD5W9Jz1PtLFXWzV5Kqkfqnh5sc+5M+foB0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789112745; v=1; x=1789717545;
 b=RKPVlvSDpuINjSFbTOuUJltO258fqf/j2ZJf33sF+kzkm+9GqkzSlGJRD+8+WWmnpQEgk0J0
 EmzLTClauArz3DnU3LnYuxG6yUzBQnUuzXqHyprdeJblAc+5H3OrrwDr9iCCDbkPeFwH9OyUMdt
 MyFAVr6PEjdrYTu/axZ4xH5Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1ec7040721a1edf5;
	Fri, 11 Sep 2026 07:45:45 +0000
X-Mizu-Trace-ID: 1ec7040721a1edf5
X-Migadu-Flow: FLOW_OUT
Message-ID: <c3f2a61d-d5bc-454c-987d-717b5f8c8809@linux.dev>
Date: Fri, 11 Sep 2026 15:45:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in
 __bpf_sk_storage_map_seq_show
To: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
Cc: ameryhung@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, wangfushuai@baidu.com,
 bestswngs@gmail.com, mattbobrowski@google.com, kees@kernel.org,
 menglong8.dong@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 xmei5@asu.edu, tgopinath@linux.microsoft.com, kys@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
References: <20260827051859.45511-1-blbllhy@gmail.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260827051859.45511-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Cen Zhang,

在 2026/8/27 13:18, Cen Zhang (Microsoft Security FORGE Labs) 写道:

> Iterating a sk_storage map is two stages:
> bpf_sk_storage_map_seq_find_next()
> returns a selem, then __bpf_sk_storage_map_seq_show() uses that selem.
> __bpf_sk_storage_map_seq_show() re-reads selem->local_storage via
> rcu_dereference() with no NULL check. A concurrent close() can run
> bpf_selem_unlink_nofail() in between and set that field to NULL, causing
> a NULL dereference of sk_storage->owner.
>
> Oops: general protection fault, probably for non-canonical
>     address 0xdffffc0000000011
>    net/core/bpf_sk_storage.c:809 __bpf_sk_storage_map_seq_show()
>    bpf_seq_read+0x366/0x1120
>    vfs_read+0x174/0xa50
>    ksys_read+0xfc/0x1d0
>
> Return if the re-read yields NULL.

I also reproduced this issue and came across your patch while preparing
to submit a fix. Do you have any plans to send a v2?

Here is the crash log from my reproducer:

[  756.754624] Unable to handle kernel paging request at virtual address dfff800000000011
[  756.754631] KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
[  756.754635] Mem abort info:
[  756.754638]   ESR = 0x0000000096000006
[  756.754641]   EC = 0x25: DABT (current EL), IL = 32 bits
[  756.754645]   SET = 0, FnV = 0
[  756.754649]   EA = 0, S1PTW = 0
[  756.754651]   FSC = 0x06: level 2 translation fault
[  756.754655] Data abort info:
[  756.754657]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[  756.754660]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  756.754664]   GCS = 0, Overlay = 0, DirtyBit = 0
[  756.754667] [dfff800000000011] address between user and kernel address ranges
[  756.754673] Internal error: Oops: 0000000096000006 [#1]  SMP
[  756.815224] Modules linked in: vfat fat sr_mod cdrom virtio_scsi virtio_console cfg80211 rfkill binfmt_misc sch_fq_codel virtio_net net_failover failover fuse vsock_loopback vmw_vsock_virtio_transport_common vsock virtio_rng
[  756.821030] CPU: 1 UID: 0 PID: 914 Comm: poc Tainted: G        W           7.3.0-rc1+ #33 PREEMPTLAZY
[  756.823909] Tainted: [W]=WARN
[  756.824703] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[  756.826443] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  756.828224] pc : __bpf_sk_storage_map_seq_show+0x158/0x1d8
[  756.830842] lr : __bpf_sk_storage_map_seq_show+0x148/0x1d8
[  756.832300] sp : ffff8000a32afa30
[  756.833144] x29: ffff8000a32afa30 x28: ffff0000ceb5ec80 x27: ffff0000ceb5eca8
[  756.834956] x26: ffff0000d516d400 x25: ffffa9f37d85e3a0 x24: ffff8000a32afad0
[  756.836764] x23: 1ffff00014655f4e x22: ffff8000a3300000 x21: ffff0000d516d400
[  756.838716] x20: 0000000000000000 x19: ffffa9f37d85e080 x18: 0000000000000000
[  756.840556] x17: 65642d6572702030 x16: 3030303033336130 x15: 303038666666663d
[  756.842400] x14: 0000000000000000 x13: 0000000000000001 x12: ffff700014655eef
[  756.844210] x11: 1ffff00014655eee x10: ffff700014655eee x9 : ffffa9f37a9be66c
[  756.846018] x8 : 00008fffeb9aa112 x7 : ffff8000a32af777 x6 : 0000000000000001
[  756.847825] x5 : ffff8000a32af770 x4 : ffff700014655eef x3 : ffffa9f37a9be380
[  756.849630] x2 : 0000000000000011 x1 : dfff800000000000 x0 : 0000000000000088
[  756.851437] Call trace:
[  756.852086]  __bpf_sk_storage_map_seq_show+0x158/0x1d8 (P)
[  756.853498]  bpf_sk_storage_map_seq_show+0x18/0x30
[  756.854715]  bpf_seq_read+0x2ec/0xd28
[  756.855707]  vfs_read+0x188/0x7b0
[  756.856577]  ksys_read+0xe4/0x1b8
[  756.857424]  __arm64_sys_read+0x78/0xb0
[  756.858402]  invoke_syscall+0x78/0x260
[  756.859372]  el0_svc_common.constprop.0+0xb0/0x240
[  756.860585]  do_el0_svc+0x4c/0x70
[  756.861430]  el0_svc+0x54/0x118
[  756.862287]  el0t_64_sync_handler+0xa0/0xe8
[  756.863352]  el0t_64_sync+0x198/0x1a0
[  756.864288] Code: 91022280 d2d00001 f2fbffe1 d343fc02 (38e16841)
[  756.865828] ---[ end trace 0000000000000000 ]---

> Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or local storage")

Would 0be08389c7f2 be a more accurate Fixes tag?

5d800f87d0a5 only introduced bpf_selem_unlink_nofail(), while
0be08389c7f2 switched the destruction path to use it.

> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Cc: AutonomousCodeSecurity@microsoft.com
> Assisted-by: Copilot (Grok 4.6)
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
> ---
>   net/core/bpf_sk_storage.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 1d295a8769fa..7228520aa2b6 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -806,6 +806,8 @@ static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
>   		ctx.map = info->map;
>   		if (selem) {
>   			sk_storage = rcu_dereference(selem->local_storage);
> +			if (!sk_storage)
> +				return 0;

Also, I agree that returning SEQ_SKIP would be appropriate here.

Thanks,
Xuanqiang

