Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3727FB2E
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433625; cv=none; b=K7Jk6rJLia8eLva1xr6zRCcA/00dBT2PtI5mXCsTFEZZh8GPpcGPz0oZpB21EVrnU7UiXM8NdR6Q7nBjVR+SagKVmGBev1Pq9eA8MGfCouSOCnyOOECgUcBHUzt7nUaBenNC3TREpAfugckSve4Y9jIGOrnZXGTyu0uCEgCxsow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433625; c=relaxed/simple;
	bh=jPQ/OCE3cLFSUiqEm98z2Z5fX4ZPiIzJozt+7kxLFuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHQtZ00zYjuYqFMf13lhaOh10ECxcXh5TCFwa2HJuNXkXrPxGa0ydkoWvd67TAkAkUj+0yU6WygRGr4vF8M+tn0Ywv7W7jSK4ZU4wrR9aQskorMENG0JdCILi7W2XynPgaLy8pEOgze8IUCZa+qm2OHUxPFqWhSyBpf/CjC+PQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SsU4PKv9; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SsU4PKv9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774433611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1c0m0l0BFph+vxPq0JK9iSEmYMllvCkSTL83OQwQZ68=;
	b=SsU4PKv9+lZGDqr2EaxCrhvGpHfT5pV6z0OIDaxH+Z4kRtrwqm8MD0Q/el6No/iYD9/2Y3
	rl1oJIt/C3CHRAh6D1Hr5nWpEAThsnSoU8IId1jD+inQ7KIvZm2TjbhsUNlaxZo9XlhewW
	Q7HWh79GyA17l2p8AfB2a3l8EvkPKBs=
From: Leon Hwang <leon.hwang@linux.dev>
To: xukuohai@huaweicloud.com
Cc: a.s.protopopov@gmail.com,
	alexis.lothore@bootlin.com,
	andrii@kernel.org,
	ast@kernel.org,
	bjorn@kernel.org,
	bpf@vger.kernel.org,
	chleroy@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	gor@linux.ibm.com,
	hbathini@linux.ibm.com,
	hca@linux.ibm.com,
	hengqi.chen@gmail.com,
	iii@linux.ibm.com,
	johan.almbladh@anyfinetworks.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	list+bpf@vahedi.org,
	luke.r.nels@gmail.com,
	martin.lau@linux.dev,
	naveen@kernel.org,
	paulburton@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	udknight@gmail.com,
	xi.wang@gmail.com,
	yangtiezhu@loongson.cn,
	yonghong.song@linux.dev,
	Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v10 4/5] bpf, x86: Emit ENDBR for indirect jump targets
Date: Wed, 25 Mar 2026 18:13:03 +0800
Message-ID: <20260325101303.232060-1-leon.hwang@linux.dev>
In-Reply-To: <20260324122052.342751-5-xukuohai@huaweicloud.com>
References: <20260324122052.342751-5-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 24, 2026 at 08:20:51PM +0800, Xu Kuohai wrote:
>From: Xu Kuohai <xukuohai@huawei.com>
>
>On CPUs that support CET/IBT, the indirect jump selftest triggers
>a kernel panic because the indirect jump targets lack ENDBR
>instructions.
>
>To fix it, emit an ENDBR instruction to each indirect jump target. Since
>the ENDBR instruction shifts the position of original jited instructions,
>fix the instruction address calculation wherever the addresses are used.
>
>For reference, below is a sample panic log.
>
> Missing ENDBR: bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
> ------------[ cut here ]------------
> kernel BUG at arch/x86/kernel/cet.c:133!
> Oops: invalid opcode: 0000 [#1] SMP NOPTI
>
> ...
>
>  ? 0xffffffffc00fb258
>  ? bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
>  bpf_prog_test_run_syscall+0x110/0x2f0
>  ? fdget+0xba/0xe0
>  __sys_bpf+0xe4b/0x2590
>  ? __kmalloc_node_track_caller_noprof+0x1c7/0x680
>  ? bpf_prog_test_run_syscall+0x215/0x2f0
>  __x64_sys_bpf+0x21/0x30
>  do_syscall_64+0x85/0x620
>  ? bpf_prog_test_run_syscall+0x1e2/0x2f0
>
>Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
>Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
>Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Acked-by: Leon Hwang <leon.hwang@linux.dev>

[...]
