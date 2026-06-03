Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B763815FB;
	Wed,  3 Jun 2026 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498074; cv=none; b=ppEL9PxFH6Zgnm5K23MKUq+nDeMVfIzHUOSh2FkF98Cgx96bBZzUBrHOv6WQVdb1aZWVBwZqirIG02833kv5Vjpaxx3ovZ5vXeI2jVLLANPq7LcUAIedcWcp7pAB5rynukfyX3vDn2pxXDg0Q9vrfddzjFN0TrF1UsSS+wxsedU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498074; c=relaxed/simple;
	bh=7kOMdDhELVsnDjTcC/y7+iMfuPibj49wbC6iVYiZGNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tV/gP5G27xxGATA2BITqCxF4gcUHqQlUkrnHrq/J2miep5Dx6ZpC4JRATYK/jfuAQp6CcJqsNViyXJ0bf9vpoHKVNop9DgBCb2wmUI7S12OVUP6OWBCx7nu5d4syPoKKiuqCI1mkr4Tvxnxy5xZeS4jsRVrJJU7VccsWW2MBtgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tat/HxE7; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tat/HxE7"
Message-ID: <555331d6-59e5-4925-a409-2bf4af273799@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780498061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wv3ebTyk2pBaPVt0dLr3PlUA7SWe5wDGnlq/dmSVxwM=;
	b=tat/HxE7wfDtc4xbi81DSVrfj6irpnGGDi2EtmyOZmbn/CKKIWhHgmgECy2WpSBBIgNtbL
	iRQiNKMfXARCbblS1gwk/QXqgYEuOPfB3IdkavTjJuz/Aj+pk7CFHN7S7ARDbA0fA+r7hL
	GtDbrNnIxyJJrg6o6uGfI1iLxUYD5Tw=
Date: Wed, 3 Jun 2026 07:47:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] bpf: NUL-terminate replaced sysctl value
Content-Language: en-GB
To: Dawei Feng <dawei.feng@seu.edu.cn>, martin.lau@linux.dev
Cc: emil@etsalapatis.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 jolsa@kernel.org, kees@kernel.org, joel.granados@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 Zilin Guan <zilin@seu.edu.cn>
References: <20260603105317.944304-1-dawei.feng@seu.edu.cn>
 <20260603105317.944304-2-dawei.feng@seu.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260603105317.944304-2-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/3/26 3:53 AM, Dawei Feng wrote:
> When writing to sysctls, proc_sys_call_handler() guarantees that the
> buffer passed to proc handlers is NUL-terminated. If
> bpf_sysctl_set_new_value() replaces the pending sysctl value, it can
> hand a replacement buffer directly to proc handlers. However, the
> helper currently copies only buf_len bytes into that buffer without
> appending a NUL terminator, leaving downstream parsers vulnerable to
> out-of-bounds access.
>
> Fix this by appending a '\0' after the replaced value to restore the
> expected sysctl semantics. Since the helper already rejects buf_len
> greater than PAGE_SIZE - 1, there is always room for the extra byte.
>
> Reproduced in a QEMU x86_64 guest booted with KASAN while exercising
> the sysctl replacement path with a cgroup/sysctl BPF program. The
> reproducer targets `/proc/sys/net/core/flow_limit_cpu_bitmap`, fills
> the original user write buffer with non-zero bytes, and overrides the
> sysctl value so the replacement buffer lacks a terminating NUL. Under
> that setup, the pre-fix kernel reported:
>
>    BUG: KASAN: slab-out-of-bounds in strnchrnul+0x72/0x90
>    Read of size 1 at addr ffff88800de57000 by task repro_patch3/66
>    CPU: 0 UID: 0 PID: 66 Comm: repro_patch3 Not tainted 7.1.0-rc3-00269-g8370ca1f87cc #6 PREEMPT(lazy)
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x68/0xa0
>     print_report+0xcb/0x5e0
>     ? __virt_addr_valid+0x21d/0x3f0
>     ? strnchrnul+0x72/0x90
>     ? strnchrnul+0x72/0x90
>     kasan_report+0xca/0x100
>     ? strnchrnul+0x72/0x90
>     strnchrnul+0x72/0x90
>     bitmap_parse+0x37/0x2e0
>     flow_limit_cpu_sysctl+0xc6/0x840
>     ? __pfx_flow_limit_cpu_sysctl+0x10/0x10
>     ? __kvmalloc_node_noprof+0x5ba/0x870
>     proc_sys_call_handler+0x31d/0x480
>     ? __pfx_proc_sys_call_handler+0x10/0x10
>     ? selinux_file_permission+0x39f/0x500
>     ? lock_is_held_type+0x9e/0x120
>     vfs_write+0x98e/0x1000
>     ...
>     </TASK>
>    The buggy address is located 0 bytes to the right of
>    allocated 4096-byte region [ffff88800de56000, ffff88800de57000)
> With this fix applied, rerunning the same sysctl-targeted path yields
> no corresponding KASAN reports.
>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
>   kernel/bpf/cgroup.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 876f6a81a9b6..2c7f72d3fb11 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2342,6 +2342,7 @@ BPF_CALL_3(bpf_sysctl_set_new_value, struct bpf_sysctl_kern *, ctx,
>   		return -E2BIG;
>   
>   	memcpy(ctx->new_val, buf, buf_len);
> +	((char *)ctx->new_val)[buf_len] = '\0';

Okay, I looked at your v2 comment and checked the bpf_sysctl_set_new_value again.
You above implementation is correct.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

>   	ctx->new_len = buf_len;
>   	ctx->new_updated = 1;
>   

