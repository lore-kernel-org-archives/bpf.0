Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492433A7F72
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601770; cv=none; b=SoRx0TqDhGbHVleS+MKmcLKDzMg4VckP87JhgclurPd9PXvzTzfErzflYFKjlm/5N2vtqKAcgqQu9lOniSSzBnfdv1edzZMwYcLpdTuUTQTKkSymfoyY3LBZAhUUkd8GoSLYDSrTdQDbIfDfsF9Zi/q3nA1LAYvgJ6yl0LrW1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601770; c=relaxed/simple;
	bh=EAD9/bXJ4tnJuAwrhyAdMrCQIQ55jfIqEKAmPGt31sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loZrJuWu0kHat4Zi3FSCBAkxjdhPi/3Hwyx4KeqNg9QxYUovdNsffl6RO+Nli4n2iVQhSTaoNQP7kfm2ndrVK8qgSJqQJ0FM0RLw9c2VWkYe9oA61e+OB2QOMr5ppsrIudl8PNecNAB+swtv6A3+kcQMhE4J6RBnbYICF2352h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DJouXcY5; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DJouXcY5"
Message-ID: <bdda3985-d443-4d57-9365-ad7424573e66@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780601756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNm9t5e8lAXGoW/IVeDw2m+9fidHrJXDk+58Ty0jXuo=;
	b=DJouXcY5+AmQMI5KNgzKE2sPEBtR6yIR7QUGT7yRsww8JuRKFwMvKRmTwlXu8LF+6RAiOL
	EudhekB9R3I/CLuC0enZj0B/SzSANeahh3PqMeszRkgSvSQp4cl0YzgD+LL/hBgPbHweB5
	KXK2HN2I3m4gkuJFHTd0skO5UC2N8vM=
Date: Thu, 4 Jun 2026 12:35:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] bpf: NUL-terminate replaced sysctl value
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Kees Cook <kees@kernel.org>, joel.granados@kernel.org,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, jianhao.xu@seu.edu.cn,
 Zilin Guan <zilin@seu.edu.cn>
References: <20260603105317.944304-1-dawei.feng@seu.edu.cn>
 <20260603105317.944304-2-dawei.feng@seu.edu.cn>
 <961fbada-5ca3-46c2-a5df-51bb006f9cb6@linux.dev>
 <CAADnVQLtKYpE0=-UWLWkBVp4s0cncR+KXRu_7Wkt4zXWsmkchQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLtKYpE0=-UWLWkBVp4s0cncR+KXRu_7Wkt4zXWsmkchQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/3/26 4:23 PM, Alexei Starovoitov wrote:
> On Wed, Jun 3, 2026 at 7:37 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 6/3/26 3:53 AM, Dawei Feng wrote:
>>> When writing to sysctls, proc_sys_call_handler() guarantees that the
>>> buffer passed to proc handlers is NUL-terminated. If
>>> bpf_sysctl_set_new_value() replaces the pending sysctl value, it can
>>> hand a replacement buffer directly to proc handlers. However, the
>>> helper currently copies only buf_len bytes into that buffer without
>>> appending a NUL terminator, leaving downstream parsers vulnerable to
>>> out-of-bounds access.
>>>
>>> Fix this by appending a '\0' after the replaced value to restore the
>>> expected sysctl semantics. Since the helper already rejects buf_len
>>> greater than PAGE_SIZE - 1, there is always room for the extra byte.
>>>
>>> Reproduced in a QEMU x86_64 guest booted with KASAN while exercising
>>> the sysctl replacement path with a cgroup/sysctl BPF program. The
>>> reproducer targets `/proc/sys/net/core/flow_limit_cpu_bitmap`, fills
>>> the original user write buffer with non-zero bytes, and overrides the
>>> sysctl value so the replacement buffer lacks a terminating NUL. Under
>>> that setup, the pre-fix kernel reported:
>>>
>>>     BUG: KASAN: slab-out-of-bounds in strnchrnul+0x72/0x90
>>>     Read of size 1 at addr ffff88800de57000 by task repro_patch3/66
>>>     CPU: 0 UID: 0 PID: 66 Comm: repro_patch3 Not tainted 7.1.0-rc3-00269-g8370ca1f87cc #6 PREEMPT(lazy)
>>>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>>>     Call Trace:
>>>      <TASK>
>>>      dump_stack_lvl+0x68/0xa0
>>>      print_report+0xcb/0x5e0
>>>      ? __virt_addr_valid+0x21d/0x3f0
>>>      ? strnchrnul+0x72/0x90
>>>      ? strnchrnul+0x72/0x90
>>>      kasan_report+0xca/0x100
>>>      ? strnchrnul+0x72/0x90
>>>      strnchrnul+0x72/0x90
>>>      bitmap_parse+0x37/0x2e0
>>>      flow_limit_cpu_sysctl+0xc6/0x840
>>>      ? __pfx_flow_limit_cpu_sysctl+0x10/0x10
>>>      ? __kvmalloc_node_noprof+0x5ba/0x870
>>>      proc_sys_call_handler+0x31d/0x480
>>>      ? __pfx_proc_sys_call_handler+0x10/0x10
>>>      ? selinux_file_permission+0x39f/0x500
>>>      ? lock_is_held_type+0x9e/0x120
>>>      vfs_write+0x98e/0x1000
>>>      ...
>>>      </TASK>
>>>     The buggy address is located 0 bytes to the right of
>>>     allocated 4096-byte region [ffff88800de56000, ffff88800de57000)
>>> With this fix applied, rerunning the same sysctl-targeted path yields
>>> no corresponding KASAN reports.
>>>
>>> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
>>> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
>>> ---
>>>    kernel/bpf/cgroup.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>> index 876f6a81a9b6..2c7f72d3fb11 100644
>>> --- a/kernel/bpf/cgroup.c
>>> +++ b/kernel/bpf/cgroup.c
>>> @@ -2342,6 +2342,7 @@ BPF_CALL_3(bpf_sysctl_set_new_value, struct bpf_sysctl_kern *, ctx,
>>>                return -E2BIG;
>>>
>>>        memcpy(ctx->new_val, buf, buf_len);
>>> +     ((char *)ctx->new_val)[buf_len] = '\0';
>> In v2 (https://lore.kernel.org/bpf/bf25d653-d856-4ad7-a751-b97d38f38892@linux.dev/)
>> I suggested
>>       memcpy(ctx->new_val, buf, buf_len + 1);
>> Does it work?
> may be it should be strscpy()?
> The input is a string, right?

The following is the bpf_sysctl_set_new_value proto:

static const struct bpf_func_proto bpf_sysctl_set_new_value_proto = {
         .func           = bpf_sysctl_set_new_value,
         .gpl_only       = false,
         .ret_type       = RET_INTEGER,
         .arg1_type      = ARG_PTR_TO_CTX,
         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         .arg3_type      = ARG_CONST_SIZE,
};

So the input may not be a string.


