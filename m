Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC0E1EE7C6;
	Wed, 11 Mar 2026 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244882; cv=none; b=hHI2EARLgw5jgViZ2HwAgcV+rIZEc5wkCp6Zg6zk54txy1C9OlFZwozFFlz5lhVVLpndCACxU/ilCtH8/NAMOZr2X89UGl07GErCHkdB02v/zQiG1B19X+dEh1XoopB+7osevqwBIKQgCFJsn423nP/pT8NTfqeiJjFtQGLSS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244882; c=relaxed/simple;
	bh=dAGZ9QDB/AHQYbwzsn1M1UQyB+pSq+QxswCJaxDDu24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtGI2mLloH6sV6JFDi3iJ62TOW5VxGU1qLCmrQNPblK25UZhPG9Rka+Y4g8Zub5iDLhX0R9VytiNIceonuHZRAGMNq3gpYrXRKnmmix15cqHDav8uVjE9JGeiuhgYjZuuiAvzOCW7JGk2kmdKpJB9UBUpVxwPNJThDW9r411LkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T7eoa007; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T7eoa007"
Message-ID: <8a3c7f14-b3d1-4208-acbd-76e5db6c5320@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773244877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNLVd2r8mGNBLCXONY/Iw3RP+/fVmudHh8AMMFKtpgg=;
	b=T7eoa007BVw9qMjpjq/4/VBG87w4s7+0T8oqqgUYtqzr42Q8zRLZrQFJMdRPGrA0mrxij5
	W3DVTQp89FUCmPsJAqcYTcubh9bLsrWUDTBCOaPy9tCsAVspeipcyKCG7KJSsD6OYJxRPb
	spLeEXgijisarBZtiXgC+0kGwalFLgM=
Date: Thu, 12 Mar 2026 00:00:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Feng Yang <yangfeng@kylinos.cn>, Menglong Dong <menglong8.dong@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, kernel-patches-bot@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260303150639.85007-4-leon.hwang@linux.dev>
 <47fbcb9aa941b07054bfef30b802d488688fafdf6df889e78b38313a614b98c1@mail.kernel.org>
 <CAP01T74sqmUAL7=PuzFPNbghX+6N_OzrsZiOHcMEMtg01CuL4A@mail.gmail.com>
 <94cfdbdc-833a-4838-af84-e0989e988418@linux.dev>
 <CAP01T74w4KVMn9bEwpQXrk+bqcUxzb6VW1SQ_QvNy0A4EY-9Jg@mail.gmail.com>
 <CAADnVQJ=NGUydRq9SghNgoo2a3JZqz4498Sk81t4CfdHm0vSHA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJ=NGUydRq9SghNgoo2a3JZqz4498Sk81t4CfdHm0vSHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026/3/11 23:44, Alexei Starovoitov wrote:
> On Wed, Mar 11, 2026 at 2:22 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>

[...]

>>
>> I agree but the main question is whether such a case is realistic, are
>> we going to have write_ctx programs tail calling this way?
>> Tail calls are already pretty rare, thinking more about it extension
>> programs are probably also broken wrt checks in this set.
>> bpf_check_attach_target is doing none of these things for
>> prog_extension = true. Nobody reported a problem, so I doubt anyone is
>> hitting this.
>> It probably also needs to be fixed.
>> Since you noticed it, we should close the gap conservatively for now,
>> and wait for a real use case to pop up before enabling this one-way.
> 
> +1
> tail_calls in general hopefully will be deprecated soon.
> As soon as we have support for indirect calls there won't be any reason
> for tail calls to exist. (other than not breaking current users).
> We definitely don't want to open it up further.
> So the simplest fix.

Got it.

Will follow the both-ways check approach in the next revision.

Will apply the conservative check to extension programs using another
patch series, after verifying the potential issues for them.

Thanks,
Leon

