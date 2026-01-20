Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86E41B358
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952677; cv=none; b=LPPF51KKE53GsuCv1G0eH+Tbsc6vtFBuAR1vL1UesXSEri2PsJp7S7S4iU+mTcNBZaKIPH514YoXUHJdphco/hKWsD3BcUAJW60M8D9RhMrqE4CU/twiiYxKBdDAXNLLZODlyWb8rqADJ6WLGRHdcJrifkan2k1ab3uS2JwrEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952677; c=relaxed/simple;
	bh=9me34u4oy/zI6wHNONKKIlR5rlAKTeUeC7SYhIdygYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZgMOYnvTKWl/sLg+9EgB7eLGarCW4oSSDLST9aYozdLViD4pDBkclM25EtiIvtGensLFXmEC3jq9+IlmXT3qcMh7qvB31xRMkxGlv1ospcEZ8yJm/r+JK/aQ11OCovyALNofDOwDwIESM25R61vW6PatSNENCX1+1rwLHe351c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AOiXflXT; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AOiXflXT"
Message-ID: <0ea85474-d3ce-42c3-8360-1a53eb456879@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768952662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGA5b+grVZQoCK86vVDs2zAsKuW4vEnEne22G7ph12k=;
	b=AOiXflXTbsQOYq3ho0mJCb7oHPfkAW5HuuGcO6gEUAVdCamKYibEXW0oaSaE1seFkTsFdQ
	OqvoFt52HJ24mnBu06P7QCu249FNZTOOQGtW4Y6mII9N7Xb3hCyrJ7EqdL0PVOITVOkOol
	K8MKYtDSyPzwMso2C8mF+2leVw3OMj4=
Date: Tue, 20 Jan 2026 15:44:15 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf, verifier: Support direct helper calls
 from prologue/epilogue
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com, bpf@vger.kernel.org
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-1-e8b88d6430d8@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-1-e8b88d6430d8@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/19/26 11:53 AM, Jakub Sitnicki wrote:
> Prepare to remove support for calling kfuncs from prologue & epilogue.
> 
> Instead allow direct helpers calls using BPF_EMIT_CALL. Such calls already
> contain helper offset relative to __bpf_call_base and must bypass the
> verifier's patch_call_imm fixup, which expects BPF helper IDs rather than a
> pre-resolved offsets.
> 
> Add a finalized_call flag to bpf_insn_aux_data to mark call instructions
> with resolved offsets so the verifier can skip patch_call_imm fixup for
> these calls.
> 
> Note that the target of BPF_EMIT_CALL should be wrapped with BPF_CALL_x to
> prevent an ABI mismatch between BPF and C on 32-bit architectures.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

