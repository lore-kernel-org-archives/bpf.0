Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C393F58EB
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179242; cv=none; b=uak4AIAcsDdk7e04jwYdvQTRWC5wyaJ8eIje9oubXvSWhVTTIGujW2uuFiDS7mTbdUB3BNFpxADPBJ6yAYoMQJxyIyYdzWhp9KlSBdPpllHHJN822SjzsXQP+2AJkETqUY/T+C/QY/5BA01hjCa79QnFcYWgiIwObOVa2iNstJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179242; c=relaxed/simple;
	bh=OhUAGuLpEUtGnu4qFuSxitUETrm9FnNYjqGDp4Zm3Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ea3AwBjiOhuSgz3ym7H7y8ebhFdrbNgfpTUaDmS+1vPI+Yk45D8GQouoC6WuLmdBBoVQv8tkzBJXhGMhbHJXLYJHrTWK7IZ4HFzKe42bl3A9fV4riDS8ltbe3vGuratOyCzHbBemkprVTOvLYJWLc/HjJWhBFKhXnF3F2VeL6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UcFJ+UhH; arc=none smtp.client-ip=91.218.175.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UcFJ+UhH"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OhUAGuLpEUtGnu4qFuSxitUETrm9FnNYjqGDp4Zm3Sg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788179238; v=1; x=1788784038;
 b=UcFJ+UhHE04pM3wJToZLi1qJpHoz9wCESCjXPucx4341eJfBGgN+v4c8uds52U/PTnODz8Jf
 UW44Eg8FpyuxbDvkF2umebTsEJ3vaJaRtaUURmdqhovSDBCMZhV7W41TDUQGz39D4VYSolFXFO4
 vXAw6w5Gv0aeg0m3Tr4GWFC0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6820a5db4ae73fcc;
	Mon, 31 Aug 2026 12:27:18 +0000
X-Mizu-Trace-ID: 6820a5db4ae73fcc
X-Migadu-Flow: FLOW_OUT
Message-ID: <309536ab-86b3-47a6-a420-c460447f6c46@linux.dev>
Date: Mon, 31 Aug 2026 20:27:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/5] bpf: Reject key-less BTF for hash maps
To: bot+bpf-ci@kernel.org, jiayuan.chen@linux.dev, bpf@vger.kernel.org
Cc: syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, yatsenko@meta.com,
 alan.maguire@oracle.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
References: <20260831110314.150870-2-jiayuan.chen@linux.dev>
 <9ed4c84cc7d723627f10b9b5d1dafb9b72d3e0bcff6db149d7605f5d9ad8c7b1@mail.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <9ed4c84cc7d723627f10b9b5d1dafb9b72d3e0bcff6db149d7605f5d9ad8c7b1@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 8/31/26 8:05 PM, bot+bpf-ci@kernel.org 写道:
>> map_check_btf() allows a key-less BTF (btf_key_type_id == 0) only for
>> maps that have a ->map_check_btf callback, and leaves the actual
>> decision to that callback. Hash maps used to have no ->map_check_btf,
>> so a key-less BTF was rejected outright.
>>
>> That changed when htab and rhtab gained a ->map_check_btf to register a
>> dtor - htab in commit 1df97a7453ee ("bpf: Register dtor for freeing
>> special fields") and rhtab in commit 6905f8601298 ("bpf: Allow special
>> fields in resizable hashtab"). Neither looks at the key, so a key-less
>> hash map now passes map_check_btf() and gets created. Reading it back
>> through bpffs feeds the key type_id 0 into btf_type_seq_show();
>> btf_type_by_id() returns the void type, kind_ops[BTF_KIND_UNKN] is NULL,
>> and btf_type_show() dereferences it:
>>
>> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
>> RIP: 0010:btf_type_show+0x223/0x2e0 kernel/bpf/btf.c:8232
>> Call Trace:
>>   <TASK>
>>   btf_type_seq_show_flags+0xca/0x120 kernel/bpf/btf.c:8250
>>   htab_map_seq_show_elem+0x12e/0x350 kernel/bpf/hashtab.c:1669
>>   map_seq_show+0x13d/0x1e0 kernel/bpf/inode.c:293
>>   seq_read_iter+0x93f/0x1270 fs/seq_file.c:196
>>   seq_read+0x344/0x4d0 fs/seq_file.c:163
>>   vfs_read+0x1e4/0xb40 fs/read_write.c:572
>>   __x64_sys_pread64+0x1eb/0x250 fs/read_write.c:769
>>   do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>   </TASK>
> The call trace appears to be edited from the original syzbot report.
> The original report (6a8f4e88.27659fcc.2ceef7.0008.GAE@google.com)
> includes these additional frames between map_seq_show and seq_read_iter:
>
>    traverse.part.0.constprop.0+0x107/0x650 fs/seq_file.c:112
>    traverse fs/seq_file.c:99 [inline]
>
> and also includes the inline frames for the pread64 syscall path:
>
>    ksys_pread64 fs/read_write.c:760 [inline]
>    __do_sys_pread64 fs/read_write.c:769 [inline]
>    __se_sys_pread64 fs/read_write.c:766 [inline]


I edited it intentional‌ly to avoid breaking the format rule.


