Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260A3191A5
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425388; cv=none; b=W4wHymqqYwQMze44ysaqwjHH/TLg2NsQM+hNVTsrrXwWZx3ygdJM841f6cjqkP6fM7LXwqxPpCwg4x3cfFvNIJNsK9EPSvWW5R3mz2ab0tIubkkXT+vwHoyFNvN+CELPO1nNGBCG7DdsNzmmEbTwtguTd5BgIW6F3bE1Z6D8L9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425388; c=relaxed/simple;
	bh=U2fX4Im3M3L10DVA6s01fOcvlG8bPt9e7Shen6VAzD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XW6daaUO5j3PCisa1YREBbU4WXTjf/UKdd9Azr1aDI6ABmKDbKYtrCtk8FxYP4IODwuIpFpbtWYLN1A9z0mE0aZqAmTlS9VenOCEu4tsgGzblQ0fHuHuJmwnXIBQh02c9nyMuF/NEP+7QNraZvgBB/ZGoEc/Wv/QddRfnWHqgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kw6wr1Mo; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kw6wr1Mo"
Message-ID: <7808103b-5daf-46bd-a3bb-6d64f8f2e680@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780425384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wzN4GALLPuVcqXOA/t9aT4SlAO+gKewctMR8F/17uk=;
	b=kw6wr1Moezu+q4NxUUUcpXMvXmobkf2Q1FBAPMcM/66ZHq2qaHQHkGs9cM7Lqt2Wmu2K8p
	Du5AYhdw5AJmVR8r10QzX7xYyoJnVB6DU+TXoOGEliUgOjKkbi+X04ZqJ8am0ThzfQahKf
	9+UlSKq+LNmkS4qlYh9lsQzCVgF5uNE=
Date: Tue, 2 Jun 2026 11:36:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 06/14] resolve_btfids: Discover kfuncs from
 BTF ID sets
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260601221805.821394-7-ihor.solodrai@linux.dev>
 <20260601223325.C912E1F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260601223325.C912E1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/1/26 3:33 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Ambiguous string-based lookup in resolve_btfids incorrectly resolves kfunc BTF IDs on name collisions, causing silent failures in BTF mutation and tag emission.
> --
> 
> commit 8f8fb9808a6cbcfa547c7cbbeadbb0e70e3b6b81
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> resolve_btfids: Discover kfuncs from BTF ID sets
> 
> This commit updates resolve_btfids to discover kfuncs by parsing BTF_ID_SET8
> symbols instead of relying on bpf_kfunc decl tags. It extracts the kfunc name
> from the symbol address, then looks up the BTF ID by name and records the
> associated flags.
> 
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index 43512af131482..d35a7b2460e83 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
> [ ... ]
>> @@ -1003,92 +1020,63 @@ static int collect_decl_tags(struct btf2btf_context *ctx)
> [ ... ]
>> +static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
>> +{
> [ ... ]
>> +		for (u32 i = 0; i < set_id->cnt; i++) {
>> +			Elf64_Addr addr = set_addr + sizeof(u64) * (i + 1);
>> +			const char *name = find_name_by_addr(obj, addr);
>> +			struct kfunc kfunc;
>> +			s32 func_id;
>>  
>> -			if (!name || strcmp(name, kfunc_id->name) != 0)
>> +			if (!name) {
>> +				pr_err("WARN: resolve_btfids: no kfunc symbol for set %s entry %u\n",
>> +				       set_id->name, i);
>> +				warnings++;
>>  				continue;
>> +			}
>>  
>> -			pr_debug("found kfunc %s in BTF_ID_FLAGS %s\n",
>> -				 kfunc_id->name, set_id->name);
> [ ... ]
>> +			func_id = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> 
> [Severity: High]
> Does this string-based lookup risk returning the wrong BTF ID when processing
> kernel modules?
> 
> When resolve_btfids processes a kernel module, btf__find_by_name_kind() searches
> the base_btf (vmlinux BTF) before the module's BTF. If a module kfunc shares
> a name with a static function in vmlinux, or if there are multiple static
> functions with the same name within the module, it seems this might return an
> incorrect BTF ID.

I am not convinced this is an issue, because a module kfunc shadowing a kernel
kfunc by name seems to me like a bad idea at first glance.

Still, AI might be onto something here. I'll experiment with bpf test module in
the selftests to investigate.

> 
> If the wrong BTF ID is returned, resolve_btfids could silently mutate the wrong
> type in memory later, for example in process_kfunc_with_implicit_args() or
> process_kfunc_with_arena_flags(). Since base_btf modifications are not saved to
> the module's .BTF section, the actual module kfunc would remain unmodified. Will
> this cause the BPF verifier to reject programs using the module kfunc due to
> missing implicit args removal or tags?
> 
>> +			if (func_id < 0) {
>> +				pr_err("WARN: resolve_btfids: no BTF FUNC for kfunc %s in set %s\n",
>> +				       name, set_id->name);
>> +				warnings++;
>> +				continue;
>> +			}
> 

