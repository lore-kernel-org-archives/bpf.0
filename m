Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602382;
	b=s58O2ur4k/xSQwTPMDpG0Rw5SlHG1Vv1bEWXP4FesTZj7ZnX0ffMUEBgqtfPlt0cDyLu
	 sZnuGbilFIP/wfYpY9ZDgytJUZT4MWbgv63btAG3qd+xR6hSQK8dj69xJ0rCUlcjQ/HZ3
	 mtJ60ZV/hzl/X/X0BUl2Ac33putrwW59TxCG/gzwzYvKAto4rx3xFsxRs2X2vBECjtE/z
	 qbxqx6nywpmV3DOyUwIuxHpmTRhH5VfcWjta777A7YN5/70HVKdlyQev98X2iJ67koXDz
	 rsVUHEKbMG3lWJRTJExpRqfGIFqb0/+JckjWJEJFmUy3tAaUualrn6cLs9tLeCvWeZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602382;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=HuK8oPx4InwGJgjQQc7WNgyri5Jajv/yOMLnovK70Bc=;
	b=BJLLfWl3fX7fR+PGMyHZnHIV7wKPKOKePnLwGMh1pBGsZj1JX5K90Iq4uOyQ94M9l8JU
	 aZUUxcN204s+HQAfBC8wDFQkhBdHxMiQAbVewpTn7PM8/dJbSTcXbXBrQRgSbFR2Csba1
	 2+hgqsaFk474PG9WZaJznbAoO4h8vvflcv8S6h50sCR5Aw2RdVxT1jPVZk66E4uPUPUwB
	 BKaHO2g8K/cLBjuU8/gSAhGetxDL8ZgmV0PFFPykKsFV4mOQ+o733MFE/958zOpqqmh7y
	 d2EZ2TEYbYFlYzxD43mSe0EMoLTqER86Fpq6SLwTwGjzeWaf73KckSe3IbRIoi8HsoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tgw1wbBe;
	arc=none smtp.remote-ip=95.215.58.210
Received: from mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316DE606A31D
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 316DE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tgw1wbBe
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wB2pwdMHXz/YDIVlJTaUyB8piB+MtIOF1Q6lkwmoiHI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792602379; v=1; x=1793207179;
 b=Tgw1wbBeUTqs8ZMU18YzZ6kyN7NQtb19xPfl5pMZpXbtD7OoYVHeAsPBxrfv1MLErWudQIka
 UtuNvNhfrDJ+P7C70MtvJN7jHrgUMwHWhEYBVh7+uYe0W7FURcMp/4XQWNFmRk+OUBF7N/8sXLp
 QsSJ7/uCdc25WWhPaslBKHMc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3e7ea2b092a3cc7a;
	Wed, 21 Oct 2026 17:06:19 +0000
X-Mizu-Trace-ID: 3e7ea2b092a3cc7a
X-Migadu-Flow: FLOW_OUT
Message-ID: <a62ec925-8187-4103-b863-7e623ce0ff27@linux.dev>
Date: Wed, 21 Oct 2026 10:06:09 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 5/8] bpftool: Emit __bpf_core_pso on
 verifier-rewritten context types
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>,
 David Faust <david.faust@oracle.com>, Ian Rogers <irogers@google.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Vineet Gupta <vineet.gupta@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
 <20261016000012.2232059-6-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20261016000012.2232059-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-15 5:00 p.m., Ihor Solodrai wrote:
> The verifier translates accesses to some UAPI context and socket types
> into accesses to kernel structures. These accesses require an
> unmodified base and an immediate field offset.
> 
> Leaving preserve_access_index off does not stop the compiler from
> merging loads at different field offsets into one load through an
> adjusted pointer. The verifier rejects the resulting program.
> 
> preserve_static_offset, available since Clang 18, preserves static
> field offsets in load and store instruction immediates. Apply it to
> the 13 types that need static offsets through __bpf_core_pso.
> 
> Eduard introduced PSO in Clang and proposed annotating BPF context
> types in 2023 [1]. His v3 RFC [2] left pt_regs annotations in
> architecture headers unresolved. However since commit de6c7d99f898
> ("bpf: Relax fixed offset check for PTR_TO_CTX"), program types without
> convert_ctx_access() accept fixed offsets from modified context
> pointers. pt_regs can now keep PAI, while PSO on bpf_perf_event_data
> covers its regs member.
> 
> PSO creates no CO-RE relocations, so BPF_NO_PRESERVE_ACCESS_INDEX does
> not disable it.
> 
> Clang 18 through 23 crash on __builtin_preserve_field_info over a PSO
> record, including bpf_core_field_*() and the CO-RE bitfield helpers.
> -D__bpf_core_pso= can disable PSO for affected programs.

Opened a PR for clang with a fix:
https://github.com/llvm/llvm-project/pull/234280

> 
> [1]: https://lore.kernel.org/bpf/20231208000531.19179-1-eddyz87@gmail.com/
> [2]: https://lore.kernel.org/bpf/20231220133411.22978-1-eddyz87@gmail.com/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>   tools/bpf/bpftool/btf.c                          | 16 ++++++++++++++--
>   .../bpf/bpftool_btf_dump_sorted.expected         |  8 ++++++++
>   .../bpf/bpftool_btf_dump_unsorted.expected       |  8 ++++++++
>   3 files changed, 30 insertions(+), 2 deletions(-)
> 
> [...]
