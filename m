Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046A2701B8
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 04:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780718995; cv=none; b=YZQtgzmVHUVz/wuNnsiHBX+JxkOPoiAvdDuG7+2Y6Ymc16708YjU+FZE0kH0b9IQd2izBY9aC3wwjeVET8tXV4xNFGm5vNq/RuiXQEA3lqJp6ZFcb9CLx6ZPlLJBl7H5W/IBKCg5c04CdkWzzOQOxsUVXZjttaocBSAhuSN49Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780718995; c=relaxed/simple;
	bh=iI07tlEMVBXWYJhJn0IDrnIeVtNhLz3cJrnWxMQyiRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0K6w9MCGfy/h+m478r8V+wPuD3plNYEqk5zxoP57SXn9LuveSU2dZXCaL7Vn170BPQHfs2QkD/cNdZAkfB3wPRB4vDNN2WkTliNE87BAUNNXvcIttcfsSyxn+47MEyMxEQ3Zwpe2BfIGa8qU952jUNbEA4OkEpNtRNDBnUm6xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ax/Sr5yu; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ax/Sr5yu"
Message-ID: <d717e193-f3b3-4022-8b0f-5e94595dd69b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780718991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zf8N71EUgiyD6Wduy1O+u0nq6u0a8d3gfrz5jZ1oWN4=;
	b=ax/Sr5yuepOsGT/g/0aFCUw2e59PpwGFTV3YtjVNpcj1qlT2Ce5e5XpVspBLWKV2rc3Bzc
	W4lZcSE21EEXOr6T+JSCBiRfX0W9r99DnZt8jTJxfdbzbWCYdf3C1NaeraTZ/1ZUecgMyk
	KYneJRXR7EwufNUw3DM4KSri5YTNPig=
Date: Fri, 5 Jun 2026 21:09:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 8/8] selftests/bpf: add tests to validate
 KASAN on JIT programs
Content-Language: en-GB
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
 <20260604-kasan-v2-8-c066e627fda8@bootlin.com>
 <13b87293-5237-43d3-9f91-33c13041cb43@linux.dev>
 <DJ18PD6QWGA2.2HOYGKU7RUB68@bootlin.com>
 <f73d0971-0544-4a92-bde7-b2fbfcdaf28b@linux.dev>
 <DJ1EYKOXV11H.25EJOUKFI81T4@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DJ1EYKOXV11H.25EJOUKFI81T4@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/5/26 1:55 PM, Alexis Lothoré wrote:
> On Fri Jun 5, 2026 at 7:20 PM CEST, Yonghong Song wrote:
>
> [...]
>
>>> Are you seeing any kasan report when you manually check your kernel
>>> logs, or not at all ? If not at all, are you using the "CI" defconfig ?
>> I do see one report:
>>
>> [   79.503059] ==================================================================
>> [   79.503715] BUG: KASAN: slab-use-after-free in bpf_prog_bb753b2ee1f69aa0_st_not_on_stack+0x115/0x160
>> [   79.503715] Write of size 1 at addr ff11000117210a20 by task test_progs/2153
>>                                                                                                                                                                  
>> [   79.503715] CPU: 6 UID: 0 PID: 2153 Comm: test_progs Tainted: G           OE       7.1.0-rc5-gd552a156c2fa #1926 PREEMPT(full)
>> [   79.503715] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>> [   79.503715] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>> [   79.503715] Call Trace:
>> [   79.503715]  <TASK>
>> [   79.503715]  dump_stack_lvl+0x6d/0xa0
>> [   79.503715]  print_address_description+0x77/0x200
>> [   79.503715]  print_report+0x58/0x70
>> [   79.503715]  ? bpf_prog_bb753b2ee1f69aa0_st_not_on_stack+0x115/0x160
>> [   79.503715]  kasan_report+0xa2/0xe0
>> [   79.503715]  ? bpf_prog_bb753b2ee1f69aa0_st_not_on_stack+0x115/0x160
>> [   79.503715]  ? bpf_test_run+0x208/0x770
>> [   79.503715]  bpf_prog_bb753b2ee1f69aa0_st_not_on_stack+0x115/0x160
>> [   79.503715]  bpf_test_run+0x472/0x770
>> [   79.503715]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [   79.503715]  ? __lock_acquire+0xe4a/0x2a10
>> [   79.503715]  ? __pfx___css_rstat_updated+0x10/0x10
>> [   79.503715]  ? __lock_acquire+0xe4a/0x2a10
>> [   79.503715]  ? __pfx_bpf_test_run+0x10/0x10
>> [   79.503715]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [   79.503715]  ? lock_acquire+0xfd/0x2b0
>> [   79.503715]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [   79.503715]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [   79.503715]  ? rcu_is_watching+0x1f/0xa0
>> [   79.503715]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [   79.503715]  ? __kasan_krealloc+0xe9/0x110
>> [   79.503715]  ? eth_type_trans+0x4b9/0x5f0
>> [   79.503715]  bpf_prog_test_run_skb+0xddf/0x22f0
>> [   79.503715]  ? __fget_files+0x29/0x350
>> [   79.503715]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [   79.503715]  ? __fget_files+0x29/0x350
>> [   79.503715]  bpf_prog_test_run+0x1cc/0x2d0
>> [   79.503715]  __sys_bpf+0x740/0xa30
>> [   79.503715]  ? __pfx___sys_bpf+0x10/0x10
>> [   79.503715]  ? _prb_read_valid+0x334/0x770
>> [   79.503715]  ? handle_mm_fault+0x91b/0xc00
>> [   79.503715]  __x64_sys_bpf+0xba/0xd0
>> [   79.503715]  do_syscall_64+0xee/0x400
>> [   79.503715]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [   79.503715]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [   79.503715] RIP: 0033:0x7f92d8cfe1ad
>> [   79.503715] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 8
>> [   79.503715] RSP: 002b:00007ffe4237fee8 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
>> [   79.503715] RAX: ffffffffffffffda RBX: 00007ffe423807b8 RCX: 00007f92d8cfe1ad
>> [   79.503715] RDX: 0000000000000050 RSI: 00007ffe4237ff70 RDI: 000000000000000a
>> [   79.503715] RBP: 00007ffe4237ff10 R08: 0000000000000000 R09: 0000000000000050
>> [   79.503715] R10: 0000000000000064 R11: 0000000000000206 R12: 0000000000000000
>> [   79.503715] R13: 00007ffe423807d8 R14: 00007f92d8eb9000 R15: 00005585778dd150
>> [   79.503715]  </TASK>
>>
>> [   79.503715] Allocated by task 2153:
>> [   79.503715]  kasan_save_track+0x2f/0x70
>> [   79.503715]  __kasan_kmalloc+0x72/0x90
>> [   79.503715]  __kmalloc_node_noprof+0x34c/0x730
>> [   79.503715]  bpf_map_area_alloc+0x4a/0x110
>> [   79.503715]  array_map_alloc+0x19e/0x580
>> [   79.503715]  map_create+0x8b2/0x1500
>> [   79.503715]  __sys_bpf+0x7ea/0xa30
>> [   79.503715]  __x64_sys_bpf+0xba/0xd0
>> [   79.503715]  do_syscall_64+0xee/0x400
>> [   79.503715]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> [   79.503715] The buggy address belongs to the object at ff11000117210800
>>                   which belongs to the cache kmalloc-cg-1k of size 1024
>> [   79.503715] The buggy address is located 0 bytes to the right of
>>                   freed 544-byte region [ff11000117210800, ff11000117210a20)
>>
>> [   79.503715] The buggy address belongs to the physical page:
>> [   79.503715] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x117210
>> [   79.503715] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>> [   79.503715] memcg:ff11000117210411
>> [   79.503715] flags: 0x200000000000040(head|node=0|zone=2)
>> [   79.503715] page_type: f5(slab)
>> [   79.503715] raw: 0200000000000040 ff11000100072000 dead000000000100 dead000000000122
>> [   79.503715] raw: 0000000000000000 0000080000100010 00000000f5000000 ff11000117210411
>> [   79.503715] head: 0200000000000040 ff11000100072000 dead000000000100 dead000000000122
>> [   79.503715] head: 0000000000000000 0000080000100010 00000000f5000000 ff11000117210411
>> [   79.503715] head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
>> [   79.503715] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
>> [   79.503715] page dumped because: kasan: bad access detected
>>
>> [   79.503715] Memory state around the buggy address:
>> [   79.503715]  ff11000117210900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> [   79.503715]  ff11000117210980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> [   79.503715] >ff11000117210a00: 00 00 00 00 fb fb fc fc fc fc fc fc fc fc fc fc
>> [   79.503715]                                ^
>> [   79.503715]  ff11000117210a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> [   79.503715]  ff11000117210b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> [   79.503715] ==================================================================
>>
>>
>> But when I am running another same test './test_progs -t kasan', there is no kasan reports.
> Ok, I guess you are missing kasan_multi_shot on your kernel command
> line: without this option, only the first report is generated, then
> KASAN does not emit additional report until you restart your kernel.
> Could you please try adding it and running the tests again ?

Thanks! Adding 'kasan_multi_shot' to the kernel command line indeed fixed the problem.
It would be great if you can mention 'kasan_multi_shot' is needed in kernel command
line in cover letter and in patch 8.

>
> Thanks,
>
> Alexis
>
>>>     cat tools/testing/selftests/bpf/{config,config.vm,config.x86_64} > .config && make olddefconfig
>>>
>>> If not, would you mind sharing your defconfig ?
>> Attached.
>>
>>> Thanks,
>>>
>>> Alexis
>
>
>

