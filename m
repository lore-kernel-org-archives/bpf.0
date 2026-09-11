Received: from mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6C2580F2
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136693; cv=none; b=KM5qVhVz/PbvZPU0Mh2chsz/k16vTthJ9Ea65q2FcbtYXSEKPBEVYsEFM1V0tN95eQ07bVCTSbPtTcZhIVLx5rxLLOO/gqkYlqCuRWW/N1j+Gwykt8DHd4srnLm5D1GbAbTJGos0KGlahHUCzeGwCAigYje9cWkxFLqPnUi2gPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136693; c=relaxed/simple;
	bh=68vbxBHpsZEn00oQLWKRWeOhLCGrb/gn4QRg4kqmr+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1pdpO2SMtMZseLBbqsJan8bjg/79yJ72QAYap8eS+j+XM8CevktyPnZv4ZpLfbJefeLBAtDw4JWtAU3MrZDsJSeU4VLxltGz5MUC0MwvjQcuTMLl++4y3wTrsx6nhE+O+8T8LM4Tl92kQlprnlxPB3q6ULIDW/oCU8IRQoCIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SBs2DxmF; arc=none smtp.client-ip=91.218.175.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SBs2DxmF"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=68vbxBHpsZEn00oQLWKRWeOhLCGrb/gn4QRg4kqmr+A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789136685; v=1; x=1789741485;
 b=SBs2DxmF2oXuNwA+NZdRJMsh/CV127mt4FVGSttTjTtJgs9mgTl5LPrjCnAXapPKMv8HJSXO
 sB9WQJsleDlygxxIUWOQEfMi34RuJ9UGSK1uWbNDDGNOYAyxVb+26FRfm62yWL9Th1L/cLeabMG
 jvfcP/pvSmkDFTh25WNSYp3U=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5091ab4b9adc1903;
	Fri, 11 Sep 2026 14:24:45 +0000
X-Mizu-Trace-ID: 5091ab4b9adc1903
X-Migadu-Flow: FLOW_OUT
Message-ID: <19eca438-012e-4457-803b-cca4e4d12520@linux.dev>
Date: Fri, 11 Sep 2026 22:24:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in
 __bpf_sk_storage_map_seq_show
To: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
Cc: Amery Hung <ameryhung@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Fushuai Wang <wangfushuai@baidu.com>,
 Weiming Shi <bestswngs@gmail.com>, Matt Bobrowski
 <mattbobrowski@google.com>, Kees Cook <kees@kernel.org>,
 Menglong Dong <menglong8.dong@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu,
 tgopinath@linux.microsoft.com, kys@microsoft.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260911140308.81560-1-cenzhang@linux.microsoft.com>
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20260911140308.81560-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/11 22:03, Cen Zhang (Microsoft Security FORGE Labs) 写道:

> Iterating a sk_storage map is a two-stage operation:
> bpf_sk_storage_map_seq_find_next() returns a selem, then
> __bpf_sk_storage_map_seq_show() uses it. The latter re-reads
> selem->local_storage via rcu_dereference() without checking for NULL.
> A concurrent socket close can unlink the selem and clear that pointer
> between the two stages, causing a NULL dereference of sk_storage->owner.
>
> Oops: general protection fault, probably for non-canonical
>     address 0xdffffc0000000011
>    net/core/bpf_sk_storage.c:809 __bpf_sk_storage_map_seq_show()
>    bpf_seq_read+0x366/0x1120
>    vfs_read+0x174/0xa50
>    ksys_read+0xfc/0x1d0
>
> Return SEQ_SKIP if the re-read yields NULL. This prevents the dereference
> and tells bpf_seq_read() that the stale element was skipped, so it does
> not consume an iterator sequence number without running the BPF program.
>
> Fixes: 0be08389c7f2 ("bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free, destroy}")
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Closes: https://lore.kernel.org/all/20260827051859.45511-1-blbllhy@gmail.com/
> Suggested-by: Amery Hung <ameryhung@gmail.com>
> Suggested-by: Xuanqiang Luo <xuanqiang.luo@linux.dev>
> Link: https://lore.kernel.org/all/CAMB2axNFOC9G2RwOCnsWDth83REMWnmPE8gxMwbLYoGusw9miA@mail.gmail.com/
> Link: https://lore.kernel.org/all/c3f2a61d-d5bc-454c-987d-717b5f8c8809@linux.dev/
> Cc: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
> Assisted-by: Copilot (Grok 4.6)

Reviewed-by: Xuanqiang Luo<luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang

