Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF00853E2E3;
	Tue, 13 Oct 2026 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918961; cv=none; b=fTXjBiOxRL3vzXHUUlR3CqnRrKPPfa9tTf9/ChLOVQyzBP1mtvsrrdX2lbeYU/z4ZfC9DZhyM6VvLEYePN/cG7TEbuhJ8jehcijbhC6uLqmQAM1vRXVLlWWmns8aifZZGtk6WQNw8i+Wi1dx/bD7UK+RO3Dv34XT3EB46Rx7smA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918961; c=relaxed/simple;
	bh=zUf0b8OC49/Pzg+LXsQP703933gm7oXIgq1vUyRIKe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lb3tRsKOOGwLB7E2QlyXy3SSf/xz8AeGkg+JY6yZhd0ysaLIa2AxOUF9ZAPBxSJ0Ox9XjFo+hfmq4puC5lXnkCB48CVHGJl/evwQIBy8egJJ/yUwPQfP9CKUBdioI6WzEQiY4WJv+7fTc/SlkbBxQg8or/U1imY2WuYPy623vaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=oaMdQZEA; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oaMdQZEA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lNVu3SidayKSnfaFfufRCwE/EdZVl+S09Mc3SjWBxfM=; b=oaMdQZEAqtw4XKZAEkL9C4HwZJ
	3YCZN2tsCxkc2vaqA1xLB+6L7Bf30QtRBDnXH7j2G3FkM8KsYvl9Xk+b0KOPTm2N9aoNLj80qnPqC
	5VchyQCm2Z5X/9ZsXiAa5vWNl1WVDR603eUWPipSO5lLmxAwBqhWPl3kPuyOZ7+KsZKDEBqe5w5Jc
	p+SS1Fdza/H4TXOyL/clT38rOZfDYBr7m9m5vqAOBWPjQIA6aSNgVxzhICMF5PbSY8g0a+ZNh5Y4H
	XXocSdi6yYNsCYw2XINQdCSNSdPc/ixDTR4dA2suby86Grlzt8wezMFr8d49o2XGqm1eyArgQC0gy
	RRGZJUTw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGhyf-0002xQ-2y;
	Tue, 13 Oct 2026 21:15:58 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGhyf-0003BJ-1j;
	Tue, 13 Oct 2026 21:15:57 +0200
Message-ID: <b59d91a6-d9a4-4d8e-8a3a-db94c2b3c25c@iogearbox.net>
Date: Tue, 13 Oct 2026 21:15:57 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 14/18] bpf, x86: Multiply by 3, 5 and 9 with lea
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261013171230.523677-1-daniel@iogearbox.net>
 <20261013171230.523677-15-daniel@iogearbox.net>
 <sashiko-outbox-170282@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <sashiko-outbox-170282@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28152/Tue Oct 13 08:26:14 2026)

On 10/13/26 7:58 PM, sashiko-bot@kernel.org wrote:
[...]
> Does this code silently drop the arena base pointer if index_reg is
> X86_REG_R12?
> 
> When index_reg is X86_REG_R12 (which has a value of 4), the SIB index field
> becomes 100b. On x86-64, an index of 100b is interpreted as 'no index
> register', so the CPU completely ignores the R12 base.
> 
> For BPF programs utilizing arena memory (e.g., via BPF_PROBE_MEM32),
> functions like emit_ldx_r12(), emit_stx_r12(), and emit_st_r12() explicitly
> pass X86_REG_R12 as the index register to emit_insn_suffix_SIB().
> 
> Because the R12 index is ignored, the kernel will incorrectly dereference
> the user-provided 32-bit offset directly instead of adding it to the arena
> base. This could allow a BPF program to read and write arbitrary user-space
> memory, bypassing arena bounds.

False positive. SIB index 100b is "no index" only with REX.X = 0. Callers emit
the REX byte via add_3mod(), which sets REX.X for R12, so the encoding is e.g.
4a 8b 04 20 = mov rax,[rax+r12*1]. The SIB byte is byte-identical to the pre-
series code, and jit_insns_arena selftest exercises arena loads and stores with
a zero offset which runs through this code, and full test_progs run passes all
arena tests.

Thanks,
Daniel
