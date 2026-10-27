Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129615;
	b=ZSZuMstbZT5+XkFKV9nktYSfLHl4yuDYP6nKzAVcRCZ0yhyMJmGImkuqBswrMhKtMFlJ
	 6k2hAVbo0EqUgKT+Ip/1BDb+cr8HTBqlG4wDG0shzL0+gpy+UHHwb54yC6uxPNCxxCfg3
	 Mbb0wzno7Vn/T4ON/cUmlhyaGV6BFCrl3G4PRRoRVh93/1Zll1mtFW0jl0mH6ug6qd7GV
	 Y/W3U89mDzyppBxnmrY1gy0j2Xngn9SgtjAeElCHxqoaeLhiYm8+HRm3BDQLBJ1t3Aaon
	 rp/9QB+9MSTzkVkf8TsBFzvpZx7TfPWBU0op3azdn6wkXOqB2xeg1TrEBvyiL1YMXWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129615;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=UYHoSpCC3bJkRNY60Q75ZtY+/Q28tZmoyETvol+drwU=;
	b=Y14xHUKmtI0JFJPYesDOeUI0YZsHcB/alt0OmPW6Pq8ducoNTQRn5BJnX4BUTkoYyQvy
	 jmVsZo7cjVQK5We41GEfrjrHjKRee/0wgL2Arm6MtMae2ccgUUckyUncnX31inCBEoisr
	 PP7N9FNz2NUkogpVSZ2NTIQzUaUGwc7P9GY9/3cJSml1YxNamxcddBSNkgc5TamF0NUGe
	 spSFlGglX8t9Y9ggg9qUxeIkyO/t9MEn9kBoA3usWgWQbOQnG6V65ePcR0nQ8bY700fXr
	 jtF0zTTAswmeq4SsU1EAMXsNoh8SoEsdjnT8DDmYZ9mFXXcRZ6snyzktQOrYoUOVjqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EGolnHug;
	arc=none smtp.remote-ip=91.218.175.193
Received: from mta0.migadu.com (out-193.mta0.migadu.com [91.218.175.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D3C606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19D3C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EGolnHug
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KDlDFT7/lBze1qf8C7Wzt65hkkCuNYLkslyxyezk8l0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793129610; v=1; x=1793734410;
 b=EGolnHugYI+f7JE/JFBxWzrgEaore00DVnBAu3DnDO8VIRo311Gnn/5j3Vj6ZP+Yu/sb29V9
 a5WSiRHSuN8oze/F/V9XiiyKZQRFV6ab2dxY3ZuMN0ZdAQ84X2oiFYAOr/JQWY1VJeKgkrz/RLe
 1RWm7p6xndo3RDzu2jVMfjgc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 54aa230a64b7b18a;
	Tue, 27 Oct 2026 19:33:30 +0000
X-Mizu-Trace-ID: 54aa230a64b7b18a
X-Migadu-Flow: FLOW_OUT
Message-ID: <5199fa29-64d8-48ab-b591-cbc854750789@linux.dev>
Date: Tue, 27 Oct 2026 12:33:25 -0700
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
Subject: Re: [PATCH bpf v2] bpf: Fix out-of-bounds btf->types write for split
 BTF
To: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261026073654.840705-1-yangfeng59949@163.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20261026073654.840705-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/26 12:36 AM, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> btf_add_type() bounds the btf->types array by BTF_MAX_TYPE, but for a
> split BTF the type ids it registers are start_id .. start_id +
> nr_types - 1, so what is actually left of the id space is
> BTF_MAX_TYPE - start_id.  Two things follow from that:
> 
>  - the limit check is an equality test,
>    'start_id + btf->types_size == BTF_MAX_TYPE'.  It is evaluated only
>    when the array has to grow, with btf->types_size == btf->nr_types,
>    and the growth (T' = min(BTF_MAX_TYPE, T + max(T / 4, 16)), starting
>    from 0) is clamped to BTF_MAX_TYPE, which it lands on exactly (...,
>    928143, then min(BTF_MAX_TYPE, 1160178)).  So unless
>    BTF_MAX_TYPE - start_id is one of the 48 sizes that sequence hits,
>    the check does not fire for a split BTF at all;
> 
>  - new_size is clamped to BTF_MAX_TYPE instead of
>    BTF_MAX_TYPE - start_id, so the array can still grow to
>    BTF_MAX_TYPE entries even though only BTF_MAX_TYPE - start_id type
>    ids exist.
> 
> As a result nr_types can reach BTF_MAX_TYPE for a split BTF while its
> type ids have already gone past BTF_MAX_TYPE; a type never validates its
> own id, only the ids it references (btf_ref_type_check_meta()).  At that
> point btf->types_size == btf->nr_types == BTF_MAX_TYPE and the growth
> branch computes the same size again: it allocates a fresh BTF_MAX_TYPE
> entry array, copies the entries, and the loop is left with
> btf->types_size != btf->nr_types, so that branch is not taken anymore.
> Every type after this writes btf->types[btf->nr_types++] past the end of
> the array: BTF_MAX_TYPE * 8 == 8388600 bytes are requested, so the first
> such write lands in the 8 byte rounding slack of the 8MB allocation, and
> each further type writes another 8 bytes beyond it.
> 
> Fix both by bounding the array with BTF_MAX_TYPE - start_id and by
> turning the equality check into a '>=' one, so that the array stops
> exactly where the id space ends. Base BTF behavior (start_id ==
> 0) is unchanged.
> 
> Fixes: 951bb64621b8 ("bpf: Add in-kernel split BTF support")
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> Reviewed-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  kernel/bpf/btf.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7ed1ff71a089..ca49c47f6a45 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1752,15 +1752,17 @@ static int btf_add_type(struct btf_verifier_env *env, struct btf_type *t)
>  		/* Expand 'types' array */
>  
>  		struct btf_type **new_types;
> -		u32 expand_by, new_size;
> +		u32 expand_by, new_size, max_size;
>  
> -		if (btf->start_id + btf->types_size == BTF_MAX_TYPE) {
> +		if (btf->start_id >= BTF_MAX_TYPE ||
> +		    btf->start_id + btf->types_size >= BTF_MAX_TYPE) {

Hi, thanks for the patch.

The fix makes sense to me, however the commit message is difficult to parse.
Do you mind respinning with a more concise explanation of the bug and fix?

This should help: https://docs.kernel.org/process/maintainer-tip.html#changelog

pr-bot: cr


>  			btf_verifier_log(env, "Exceeded max num of types");
>  			return -E2BIG;
>  		}
>  
> +		max_size = BTF_MAX_TYPE - btf->start_id;
>  		expand_by = max_t(u32, btf->types_size >> 2, 16);
> -		new_size = min_t(u32, BTF_MAX_TYPE,
> +		new_size = min_t(u32, max_size,
>  				 btf->types_size + expand_by);
>  
>  		new_types = kvzalloc_objs(*new_types, new_size,

