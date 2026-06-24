Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C7D22D792
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782264993; cv=none; b=hbBWOpKUeXRRLG9cxzAtLyKfd4SF1+ulahxmv0sTMZ3K2IT2Vsq+vrNR1BiDwIjcKDpcoEclL9qg6P3e43BoOlYIlrWL4wv3JkGIMuI/5GPZvXB93e303lrc4DUaZtZ3x0k4w2yf3UrOJGWz2K8QHG8dYiGLvaYdcBhHIGrxEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782264993; c=relaxed/simple;
	bh=KnvIe/6h4mSuOk3n1VB0XXJmDIZJDvKAcuC47OaLoDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/YMyHzf+TGcwMoXEJumDSew0geDVfvlUf+48zeAbH1wZUR0C6Gp+4A9uqk+FZTiDu3jjT+tQUm54Mr3tzI8g7YJf0DqsVGWZILUV6LkZQa79sKOvY5Meq6O4VMJ/O7OgqlBCTVg71SXIjO8lv56vabJCcNUArGx2pmRVlIFeEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XeGxuCQ8; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XeGxuCQ8"
Message-ID: <73c05543-f6d6-4df2-9a32-8ee30343a670@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782264989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQ383rsH80JLkIrPgbME6Yh35rwqkpod5OXpoJUyEWs=;
	b=XeGxuCQ8QJuQO5wU9io6bNXNxpJIh+XYA0LfZ2zQoFem4dH3rK+i7ezLIZaZm6ijeTnEvv
	9F9BTcls54kU2XYgVx9q4Keq1ZGDFgmBLwKAjORALF1hQ8nlJBPaT40ErxnFcolGTkyaIk
	o5z4hWmN7txErnZ8BcpkpLEpZRPcHVU=
Date: Wed, 24 Jun 2026 09:36:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on
 lookup-bind-release
To: Michal Luczaj <mhal@rbox.co>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/24/26 2:03 AM, Michal Luczaj wrote:
> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
> sk_is_refcounted(unbound) = true, while sk_is_refcounted(bound) = false.
>
> Because sockmap accepts unbound UDP sockets, a BPF program can increment a
> socket's refcount via lookup. If the socket is subsequently bound, the
> transition from unbound to bound causes bpf_sk_release() to skip the
> decrement of the refcount, causing a memory leak.
>
> unreferenced object 0xffff88810bc2eb40 (size 1984):
>    comm "test_progs", pid 2451, jiffies 4295320596
>    hex dump (first 32 bytes):
>      7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
>      02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>    backtrace (crc bdee079d):
>      kmem_cache_alloc_noprof+0x557/0x660
>      sk_prot_alloc+0x69/0x240
>      sk_alloc+0x30/0x460
>      inet_create+0x2ce/0xf80
>      __sock_create+0x25b/0x5c0
>      __sys_socket+0x119/0x1d0
>      __x64_sys_socket+0x72/0xd0
>      do_syscall_64+0xa1/0x5f0
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Maintain balanced refcounts across sk lookup/release: (re-)set
> SOCK_RCU_FREE on proto update to treat the socket (whether bound or
> unbound) as not requiring a refcount increment on (a RCU protected) lookup.
>
> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

