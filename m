Received: from mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78729BD9A
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 01:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028922; cv=none; b=un7fQg9T7ml1X5aAjHSQHmRNMsgn2rtIqUxj3TaLur5D3LPrnyTFPI8XfdArCNgbkqv5YYyVn+nReF9tpGt5JpaXxgymoQ7j4EMzt6rViXvETPskzE4Q5u5+xhIXvVPfJgjoyboHimUn+LWAMunvbMTwK6zJQ8E6jIAkSC4WBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028922; c=relaxed/simple;
	bh=fTRqCKsgbkVlenS8t/rKet3TpxPNvpKHeqHtYLlfkcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSxR3k2ObdFVmX6wToJKtKFJph0TlQE5tCWB13lVn7ZJfXCA35CszJvK3Ag2T2CS0z+I2LL+IjQcrEXiWrAl3ZvF/iaynl3WdpZ4YjrUl1j7gGrQ0OamzAN4MhY+MTiuwMxS+Ti0qhRyg8UhJuhi/BNShXluJLV1xZq0siEIWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HxdYmTRy; arc=none smtp.client-ip=95.215.58.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HxdYmTRy"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fTRqCKsgbkVlenS8t/rKet3TpxPNvpKHeqHtYLlfkcU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792028918; v=1; x=1792633718;
 b=HxdYmTRySsuGGyPH+tqYTXI0JZzf27RX6PUu66rgyHh1vSSr9eOyqdWCpH3J8iedwkFTzBrM
 7GvGgoEOVNBLs4tq9EmGHfzMffm5U+QbYYK+XkbAy2f6+t0bEZ5FvW+VcAQDdLT+8A7yWbF1YZ6
 /Wws1Ki47RBWkm2/O+zmCGg0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 57570c4f35a5311a;
	Thu, 15 Oct 2026 01:48:38 +0000
X-Mizu-Trace-ID: 57570c4f35a5311a
X-Migadu-Flow: FLOW_OUT
Message-ID: <09db7d70-b7d4-4cf5-9447-6d16bac10794@linux.dev>
Date: Thu, 15 Oct 2026 09:48:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 00/21] bpf: Add tracing_multi link support for
 bpf progs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin Monnet <qmo@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>,
 Avinash Duduskar <avinash.duduskar@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung
 <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>,
 Rong Tao <rongtao@cestc.cn>, Eyal Birger <eyal.birger@gmail.com>,
 Pu Lehui <pulehui@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>,
 Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <as_7Jgy_sdTE9M5O@krava>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <as_7Jgy_sdTE9M5O@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/26 05:59, Jiri Olsa wrote:
> On Mon, Oct 12, 2026 at 11:40:02PM +0800, Leon Hwang wrote:
>> Similar to the tracing_multi link support for kernel functions [1], add
>> support for bpf progs.
>>
>> With this support, I'll be able to enhance the function-graph feature of
>> bpfsnoop [2]. It will trace all bpf progs, including their subprogs, to
>> draw a full function call graph including bpf prog call sites.
>>
>> The attachment could speed-up when there are hundreds of targets. For
>> example, on high CPU core count servers, it probably runs 200 tc-bpf
>> progs as Kubernetes CNI, and each tc-bpf prog might have 4 subprogs.
>> Hence, there will be 1000 targets to trace for bpfsnoop's function-graph
>> feature.
>>
>> With tracing_multi link support for bpf progs, bpfsnoop will be able to
>> attach to all targets quickly.
>>
>> When attaching to 1000 targets, fentry.multi is much faster than fentry
>> on a 16c16g QEMU VM on an AMD EPYC 9745 server.
>>
>> ./bench tracing-multi-attach-progs
>> Setting up benchmark 'tracing-multi-attach-progs'...
>> tracing-multi-attach-progs: prepared 1000 identical BPF program targets
>> tracing-multi-attach-progs: fentry created and attached 1000 programs/links in 338.171ms
>> tracing-multi-attach-progs: fentry.multi created one program and attached one 1000-target link in 47.345ms
>> tracing-multi-attach-progs: fentry.multi creation/attachment speedup is 7.14x
> 
> it's faster, but the original attachment is under 1s,
> so not really a problem imo
> 
> I guess the api is better for your use case, like having
> less file descriptors open ?

Correct.

The original attachment is fast enough. So there is no need to improve
attachment performance with a large patch series.

Even though the series brings two benefits:

* One bpf link for multiple bpf prog targets.
* Support for all archs that have trampoline support.

But, I also doubt the value of this series.

Thanks,
Leon

