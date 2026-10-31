Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793406689;
	b=gcrKAV96FNIaSgXQ3MTKXqfdzliHbhnV929SuCgjZF2Na9QH9A5Re0hLz8Lo2k0UQ3IK
	 95PPQIV2X1e/4hs4t9SS6ojaqo9zgadLmij1gTJZuaXYl5LswPDPd6hwiY0enXgrSQ43w
	 pRlE5Y/5sJ9SffL7ty8lB3evkB7X3NB4UgS3xWLDHDK4XwDDPKucyO35SAyYIHe/yt0FL
	 8IsxUEe8ZQO5o4Ip/ATz+B6nOxRo5WO+oT7cB9LhkGpTakjKuh+d/dSxcYgJwX82+nDlW
	 xYZugY+EdaoN9WYJX80fuAouUQSMmQNfRtgYe+8aNzErD3hXQymlmNFmv+UGLzXOP6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793406689;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=IXG0sxDC41P8FbPKBXtL73aMgp3ZfXzAv6aGiPAR6bc=;
	b=sS5wNRpqRwqj6+k/EUnDGnpdg1+/Vfdj/mqtfgm7yDRn6Y5aNJSP/jip3JIjGXVM/qhq
	 pQCuc7vn6ZY+x5KgC98GkJlINljAkzI0+BYHFiL8dhZb+FviRj1CFqYtFv1UE0noe8Loa
	 0viad9uVNrz6LfPXxh71d8ZTakybyOrc4WN9FI9pRVlOBtG32x8JB4PjPBWjphe1W4Dyz
	 yu4VRSya3LUUchvq3lRXjNvmA6aZbSsIWWp4A3QqChi4d3prx1MLsg6+LpYVIlq5udBls
	 AvfNREBkqXwmzeLsRxcf7Gwkb8/ycPhxkLj6QA3QnNJebMA4WMGEupXNkzr0ahAoq+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wkoTU3My;
	arc=none smtp.remote-ip=95.215.58.43
Received: from mta1.migadu.com (out-43.mta1.migadu.com [95.215.58.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8371606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 00:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8371606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wkoTU3My
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=e68WjUm5ypCvZVtT91GSngElSLR4dLlmdP5VBoxHKeA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793406685; v=1; x=1794011485;
 b=wkoTU3MyFEp4BgZUBqq/lJzxMoAprQniNvLVx818ACpUiMgIBoLAkrsXThT5VhfJM4NcH36G
 FO1sCE8Xp/g3bSP2tkHJDJo77FWQzaC5hA/CCU3/nrXU992EFo8LgA3S824MeH0yx0vBVuwctKL
 Q2OD/zM1fCY0UOeCp0RKze7Y=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1e9d4d40634a9526;
	Sat, 31 Oct 2026 00:31:25 +0000
X-Mizu-Trace-ID: 1e9d4d40634a9526
X-Migadu-Flow: FLOW_OUT
Message-ID: <18b21d29-8cf8-42de-b5b0-92ccd5783a75@linux.dev>
Date: Fri, 30 Oct 2026 17:31:20 -0700
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
Subject: Re: [PATCH bpf-next v3 04/13] bpftool: Normalize legacy arena type
 tags before C dumps
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com,
 cupertino.miranda@oracle.com, david.faust@oss.qualcomm.com,
 irogers@google.com, jose.marchesi@oracle.com, vineet.gupta@linux.dev,
 yonghong.song@linux.dev, martin.lau@kernel.org, mason@kernel.org
References: <20261030233355.1836749-5-ihor.solodrai@linux.dev>
 <3c1960998302f1ac50394163cf62ccf59ad088c0f586512a5d7771c95ec7e3f2@mail.kernel.org>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <3c1960998302f1ac50394163cf62ccf59ad088c0f586512a5d7771c95ec7e3f2@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 5:16 PM, bot+bpf-ci@kernel.org wrote:
>> bpftool: Normalize legacy arena type tags before C dumps
> 
> TL;DR: The legacy arena tag fixup skips split BTF, so module C dumps on older
> kernels may still print "address_space(1)" for vmlinux arena kfuncs and fail
> to compile; commit message doesn't say so.
> 
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
> 
> [ ... ]
> 
>> @@ -1092,13 +1093,47 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
>>  	return datums;
>>  }
>>  
>> -static int dump_btf_c(const struct btf *btf,
>> +/*
>> + * Older kernel BTF encodes kflagged arena type tags as "address_space(1)",
>> + * which btf_dump prints as is. Rewrite them to the complete specifier.
>> + */
>> +static int btf_c_fixup_legacy_arena_tags(struct btf *btf)
>> +{
>> +	__u32 i, cnt = btf__type_cnt(btf);
>> +	int off;
>> +
>> +	if (btf__base_btf(btf) ||
>> +	    btf__find_by_name_kind(btf, LEGACY_ARENA_TAG, BTF_KIND_TYPE_TAG) < 0)
>> +		return 0;
> 
> Can this early return for split BTF leave module C dumps broken on older
> kernels?

Yes, it will. That's intentional: the fixup targets only vmlinux BTF, which is
always the base.

I don't know of any users relying on btf C dump for modules, but if
there are any they are advised to re-compile their modules with
updated resolve_btfids to use a new format.

> 
> [...]
