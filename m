Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792774247;
	b=UESXw/zluUQsA5YnyS2MV7kq7hwkPoNmU5j1K8/EP8j9GeSRYBmUHQI1yaeAbBVZuw89
	 r/ZqkPxH+uErvB5Ho+rD131KMicN2pwCsgSaMEV4c7WwjXxY4OBcCqehto42fXGhUxhUx
	 iKcL170rRrsMYprddHIw9j2OVXY8VhtTLo2blL7lrE55uQZzqcAkx9C+PNVO2OqMGmhzS
	 lViX/rpY2hVIZxx0pelzBkGBUgwOvKFszQjFjgTNQvAO/bB6/3IlG9w/viwvskdm/W9+q
	 grvA6O7FK6RkwTmRoT+Jqidr4LhkxKzCEp7/XOx+bvJ7/nBKEYbSOMsD3fooJP5YrkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774247;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=GCz40g1guEeoJS/oqADgwojm7pc6elU5aYlmpqlNJXU=;
	b=43JG0+3QLIML7tNnh/VAaR7ktgBo1AtZZrs5hpEtE7W9l2IuhnexFqHsFwItjB1l5kVH
	 P4eFc8jS4IAduzVP25XzOW9Zombwwx68U5EOYHXOluaWEtnSG76FQYoBN8x/TbCt84qUY
	 nC9O/tcRtQ3lVmGO1Q94ddPJ/kMfXhyrSvs6erBScKtun0YazeSIQTD748MKo7bG69N54
	 VZBUH6CEbN6DsqpR59VcPrqqIS9qRXr/FOwQxADCjcVCnUtj2aj/aI3Pc1JF5Hu4EJguf
	 8ZWEuHw3vPPQI5hczwrFbeIJumCz2SR8FEYlEn/6xwW6+EORg6pABOd327hg3aXoSWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EnYsLRBW;
	arc=none smtp.remote-ip=91.218.175.224
Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065FF606A321
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 16:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 065FF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EnYsLRBW
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=efnr8bEjRz3wvGuIq/m5I2FsgQOeEhbbFO8QT7bbpds=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792774244; v=1; x=1793379044;
 b=EnYsLRBWzSYhcvwW4OfLcNO6yUKdOiHpXWeF2prjikQafl2G00pwJAr+O91IgPRgx0G2jH9P
 mBrdmcyx5YocYr5MLuv8FLYapWHLdo6z6dLh1fqyJ3YIiPC4NcIEMcVh0g7AX96DRDZxGP5uEuS
 5vE1GkcEx932vU89PjSducmg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 008a056e11af6839;
	Fri, 23 Oct 2026 16:50:43 +0000
X-Mizu-Trace-ID: 008a056e11af6839
X-Migadu-Flow: FLOW_OUT
Message-ID: <3e0cb7ec-4849-4986-a474-83f8ad98c1ee@linux.dev>
Date: Fri, 23 Oct 2026 09:50:37 -0700
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
Subject: Re: [PATCH vfs v3] bpf: Allow bpf_d_path() from filp_close_sync()
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Christian Brauner <brauner@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 NeilBrown <neil@brown.name>, Jiri Olsa <jolsa@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20261021201400.5409-1-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20261021201400.5409-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/26 1:13 PM, Ihor Solodrai wrote:
> The d_path selftest closes its descriptors with close_range() so that
> its fentry program on filp_close() runs.
> 
> Commit 056069eb2b66 ("fs: make close_range() synchronous") switched
> close_range() to filp_close_sync(), so the program still attaches but
> is never called:
> 
>   test_d_path_basic:FAIL:close trampoline for filp_close was not called
> 
> With that series, close(), close_range() and the closes on exec and
> exit all go through filp_close_sync(). Few paths still reach
> filp_close(), dup2() being one of them, so a program on filp_close()
> no longer sees most file closes.
> 
> Allow bpf_d_path() from filp_close_sync(), but only from fentry.
> filp_close_sync() drops the last file reference inline, so by the time
> an fexit program runs, file->f_path may already be freed, with no RCU
> delay for NORCU dentries such as pipes and sockets.
> 
> Attach the selftest program to filp_close_sync() and keep triggering
> it with close_range().
> 
> Add a test rejecting bpf_d_path() from fexit/filp_close_sync.
> 
> Assisted-by: LLM
> Fixes: 056069eb2b66 ("fs: make close_range() synchronous")
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Christian,

Just in case you pay attention to BPF CI signals, they are red for
this patch because commit 056069eb2b66 is not in bpf-next yet.

Thanks.

> [...]
