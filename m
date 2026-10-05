Received: from mta1.migadu.com (out-74.mta1.migadu.com [95.215.58.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EBA34EF1F
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240890; cv=none; b=LjGih83uOZlZ0iWK2essYVkCk46u+NFHnpWveF9KLRy3ZOC+jUlGl6I4xUD3RzUCjtZQbY7PXamUSNGPs1JPEjKOZ8shBqUWMHC9JUj5QGqXIoXGk5oE7k4Sq9U3246MGHBLphWWpH0YJ6MLHOSMNE0wFUtY3O6GB2SljVlzSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240890; c=relaxed/simple;
	bh=x9dt0iOgJmfi9EX56kvB4OY6WAH94SdeT+VfzXw7UFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pl+CTQ1TCd3vBTVvxt6edlY6tpfwK+9OFxfr19fLkWYZn62wFBjnznIOyWlLXpg1Lm16LQWLaP9gwJLQCUO3qz3kJW29yQ8mr1FtW1MSp9rkKQjTYOTonj0FchXNVw8l3qfTVzqo/KZSB70DCGvJThVlU/eohfRrluQZqQlqpQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fXC0n/eH; arc=none smtp.client-ip=95.215.58.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fXC0n/eH"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=x9dt0iOgJmfi9EX56kvB4OY6WAH94SdeT+VfzXw7UFQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791240885; v=1; x=1791845685;
 b=fXC0n/eHV1UAKM+0l6728krlI+/DQxAYm9/qO9kcux1lh6Ou9bm5eq9F4I1k2R0+2Cw+Iq88
 B5rMh4DPImgW87XEm0lOEtCoUMScGHmhHYi8/PfU5ELuGHXfXLvlIis8W5W64wSaufLdt1HnNq6
 X7j5x74wkvEi3a/38IQuzw7Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 88bd8c56e4024cfc;
	Mon, 05 Oct 2026 22:54:45 +0000
X-Mizu-Trace-ID: 88bd8c56e4024cfc
X-Migadu-Flow: FLOW_OUT
Message-ID: <b5f31057-e2e3-4c73-8edb-c8e70960a319@linux.dev>
Date: Mon, 5 Oct 2026 15:54:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: Use /tmp for temporary file
 in d_path
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
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <52daee54-9127-445c-b924-64623ca2e125@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/26 11:24 PM, Pu Lehui wrote:
> 
> On 2026/9/30 0:29, Alexei Starovoitov wrote:
>> On Tue, Sep 29, 2026 at 08:39 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>> The failure occurs because the rootfs created by libbpf/ci [0] does not
>>> mount /dev/shm, causing temporary file creation under /dev/shm to fail.
>>>
>>> Let's switch to using /tmp instead to fix this issue.
>>
>> This will break BPF CI.
>> The test was using /tmp up to v4 and was moved to /dev/shm in v5,
>> since /tmp is on 9p in BPF CI and 9p doesn't support fallocate. See
>> https://lore.kernel.org/all/20251206141210.3148-1-electronlsr@gmail.com/
>> vmtest's init mounts tmpfs at /dev/shm, /run and /mnt, but not at /tmp.
>> So fallocate() will return EOPNOTSUPP and d_path/check_mem_access
>> will fail on x86, arm64 and s390.
>>
>> Mount tmpfs at /dev/shm in mkrootfs_tweak.sh like you did for /tmp in [1]
>> and drop this patch.
>>
>> pw-bot: cr
> 
> Hi Alexei and Ihor,
> 
> I have been make a pr for mount tmpfs at /dev/shm, pls take a look.
> 
> https://github.com/libbpf/ci/pull/239


Merged, thanks.
