Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC93AD534
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433713; cv=none; b=XQKwY1ksaQgisBFVqxMpmEMR1AKVuRDyNhBLyvT0l8IsDHpWv6anGHca9GQSFeO12+y2r6vTiFMEjHXlczKtSrfYUkBCM+IA4xLmxOsrmejNiDPqLqmETfrl0dMGmYEnF3ikd4U4ffEot9Lv0o7MBgt36IR5oXJkxc1xcBoKPzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433713; c=relaxed/simple;
	bh=/5jcfcm+QZh4bxx3qZPCeJHymhFI4h1sx5H1Fe2oMhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8J2Q/SjGBtAVWVwZ2Pbw0YL4iN5OGFR+WNwJ7U41ORog+AtI3x9A8Ru6H18DdYX1G46C2RqphC5KmiUZG8bBBRx2S6msgL/fSiEFJzywuYlGIvj67Yy7JlSrIzSmU6okPy8Oe1JxG9jvu4+PFHKLhqqIY+ojZexDvglwnE7TmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QlgkJmdi; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QlgkJmdi"
Message-ID: <c92395a7-5b56-415b-afe7-186b69c0a5e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774433710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgOX2Ueq2+jdgqSbhNggaZUcUNC7RJqS127l3Eab4gA=;
	b=QlgkJmdickflLaFfKx3wSePqh64y2bLOlWkY6yFHeG8ZzVP31aJMeNc572xoQFRhCGYDKF
	kwAq4R0G2EDBUA3MAQqZ2ce31T5qMqLJnZCpUvzJiLWZ5kzSQ61646XIuifUaY21CNr3pn
	StPmY8yn1+F9gGonqj1MgaiJPkAj+h8=
Date: Wed, 25 Mar 2026 18:14:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 5/5] bpf, arm64: Emit BTI for indirect jump
 target
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>,
 Johan Almbladh <johan.almbladh@anyfinetworks.com>,
 Paul Burton <paulburton@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Christophe Leroy <chleroy@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>
References: <20260324122052.342751-1-xukuohai@huaweicloud.com>
 <20260324122052.342751-6-xukuohai@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260324122052.342751-6-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/3/26 20:20, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> On CPUs that support BTI, the indirect jump selftest triggers a kernel
> panic because there is no BTI instructions at the indirect jump targets.
> 
> Fix it by emitting a BTI instruction for each indirect jump target.
> 
> For reference, below is a sample panic log.
> 
> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
> ...
> Call trace:
>  bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
>  bpf_prog_run_pin_on_cpu+0x140/0x468
>  bpf_prog_test_run_syscall+0x280/0x3b8
>  bpf_prog_test_run+0x22c/0x2c0
> 
> Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
> Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> ---

[...]

