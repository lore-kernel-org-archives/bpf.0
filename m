Received: from mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C348E0C5
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306582; cv=none; b=Pdb3HtI5xoifDSsDDMNseA8DkjlgThqeL3fJrrzYY5uFEazGRP7/fyTi4TQ8lHHNvTb78OV/XSTiXhDW0Iv4hUMkr7lkzTzQ6o8ih8gXJcC011JPja9TiycZYkUn95orTFlpNOHG8FQytteMpQsO0x0aazpymyBOwF83itcyqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306582; c=relaxed/simple;
	bh=ip3lsF1/RW6hopKSPjIofrNyzgxwJm4Yts77+HupLAQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u15y+9uWq0Qvv5S9pyv/Dr74w3QakIM9sbNSJhCG97C1pktM9Tr2PfJ8RkFCJYaJUAD/5M/T1J9JBHVO+wDOdeH33V6WU+hcdYKqC+8wqTBFKCP1NxeEfOIr/Ig6MIiUmg8y5hMqk6/w+ripupqSiZidN89Eu1neMCwWKWUtkU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WSwn+b/v; arc=none smtp.client-ip=95.215.58.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WSwn+b/v"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ip3lsF1/RW6hopKSPjIofrNyzgxwJm4Yts77+HupLAQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791306578; v=1; x=1791911378;
 b=WSwn+b/ve3DQFsJeY6fX95XEV2BPixpBsT0uwVCPwkfTkm2TBcZLyDrj4KjdGnxKCSuk2tR8
 B+W9kHY20jUF9+iTBffqpJpzbNTXVUag1vT/hY3lbPMbkHYk8DbRLqhJgV8R6UnezcQwXggAdo8
 1CuETHch+HUj4uJyj3WxlcXQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ff89a30a3c80fbc7;
	Tue, 06 Oct 2026 17:09:38 +0000
X-Mizu-Trace-ID: ff89a30a3c80fbc7
X-Migadu-Flow: FLOW_OUT
Message-ID: <501b9da8-bc0c-4c02-866d-f50b20b60289@linux.dev>
Date: Tue, 6 Oct 2026 10:09:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: Use /tmp for temporary file
 in d_path
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Pu Lehui <pulehui@huaweicloud.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan
 <puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Pu Lehui <pulehui@huawei.com>
References: <20260929083924.1851840-1-pulehui@huaweicloud.com>
 <20260929083924.1851840-4-pulehui@huaweicloud.com>
 <DLRXY2AQRPYP.1YQ75SL3XHQHN@gmail.com>
 <52daee54-9127-445c-b924-64623ca2e125@huaweicloud.com>
 <b5f31057-e2e3-4c73-8edb-c8e70960a319@linux.dev>
Content-Language: en-US
In-Reply-To: <b5f31057-e2e3-4c73-8edb-c8e70960a319@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/5/26 3:54 PM, Ihor Solodrai wrote:
> On 9/29/26 11:24 PM, Pu Lehui wrote:
>>
>> On 2026/9/30 0:29, Alexei Starovoitov wrote:
>>> On Tue, Sep 29, 2026 at 08:39 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>>> The failure occurs because the rootfs created by libbpf/ci [0] does not
>>>> mount /dev/shm, causing temporary file creation under /dev/shm to fail.
>>>>
>>>> Let's switch to using /tmp instead to fix this issue.
>>>
>>> This will break BPF CI.
>>> The test was using /tmp up to v4 and was moved to /dev/shm in v5,
>>> since /tmp is on 9p in BPF CI and 9p doesn't support fallocate. See
>>> https://lore.kernel.org/all/20251206141210.3148-1-electronlsr@gmail.com/
>>> vmtest's init mounts tmpfs at /dev/shm, /run and /mnt, but not at /tmp.
>>> So fallocate() will return EOPNOTSUPP and d_path/check_mem_access
>>> will fail on x86, arm64 and s390.
>>>
>>> Mount tmpfs at /dev/shm in mkrootfs_tweak.sh like you did for /tmp in [1]
>>> and drop this patch.
>>>
>>> pw-bot: cr
>>
>> Hi Alexei and Ihor,
>>
>> I have been make a pr for mount tmpfs at /dev/shm, pls take a look.
>>
>> https://github.com/libbpf/ci/pull/239
> 
> 
> Merged, thanks.

Pu Lehui,

I just realized that this change may not be enough.

If you want to make sure the selftests will run properly in BPF CI,
please try the vmtest tool (a qemu wrapper):
https://github.com/danobi/vmtest

You should be able to run riscv64 in emulation through it.

