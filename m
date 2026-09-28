Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FB3CDBA5
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600049; cv=none; b=IENbsY6ofPHFT7gjc7vx1G0PRQMi4a8s4ZJ7/48DigqbHPnZWppWHYox8gJvUqbEsAs6RF05FrFnzG1Cw5htbswDNl1cxUF8ve79lTZplt2eKda2QET+OoeGyBnju6Q0pFSy6bG48IhAlwiocrH48r9LXFaRzsOTBFkdpSGtrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600049; c=relaxed/simple;
	bh=tJFYAFdar/edNhuq+KmVYEKhj6ZL8sX1lZmp/hi5rZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mipVlkb+stTp70kNSIgiqIBbetivVLBGplFjKSFFzB07UxzxOsWmJfQohpWPw64dzYQgIOqEN0+SriUOhPMGIUjgtBDlyperQ+6t8COSl2WeZzM1UQtGnkm8EAUsmd2466rEjW7CuNmVEcaOD8meMi9f22m+QNCIA3cvSnnwjq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kEih1S1p; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kEih1S1p"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D88E980881;
	Mon, 28 Sep 2026 14:54:04 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 04FPWnroJKYK; Mon, 28 Sep 2026 14:54:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790600044; bh=tJFYAFdar/edNhuq+KmVYEKhj6ZL8sX1lZmp/hi5rZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kEih1S1p3YbA5y5Xq6H5LYMpHLIAcnDqLLMKW+6SXC4E9ML1cWxaHtQih91YK/902
	 BS/PBa+qjRCPbulUsfWvFkK2kaJenOvwL50KWHWSGUqtlqh6jm4ZJRcmyHTecJ/7Yt
	 N/21p/cHA7Jbe21rV4ic02vy0pIXGjDLUqKrBeOQkvPT3ytbOPfJuIXvtIvY/KN/5z
	 D0k6IVPPt++Q12s1sstKRiDFPBLCMWRqaKYFd8JLnYOLe3gzUhkKsXLVtHQUwwgCxB
	 Hr869fbGl825GYPYthvcNFCmtwBHShyj57eRKbikQKj/4KZU/SogMQ7BLIQnddAMLV
	 6jgh+9irQCOlQ==
Message-ID: <27c143ce-7f50-4d78-beaf-8d82e3677d22@disroot.org>
Date: Mon, 28 Sep 2026 13:53:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bpf: Fix incorrect handling of user flags by percpu
 map updates
To: bpf <bpf@vger.kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, leon.hwang@linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260928102821.995214-1-maghasi@disroot.org>
 <20260928102821.995214-2-maghasi@disroot.org>
 <20260928104137.2B9601F000FF@smtp.kernel.org>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <20260928104137.2B9601F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/09/2026 11:41, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] bpf: bpf_percpu_array_update() misses validation for mutually exclusive flags
> --
> 
> commit 41d85d3576867a24ad9b52f72cd4c1d7b23504a6
> Author: Masoud Aghasi <maghasi@disroot.org>
> 
> bpf: Fix incorrect handling of user flags by percpu map updates
> 
> This commit fixes incorrect handling of BPF_EXIST, BPF_NOEXIST, BPF_F_CPU,
> and BPF_F_ALL_CPUS flag combinations in BPF_MAP_TYPE_PERCPU_HASH and
> BPF_MAP_TYPE_PERCPU_ARRAY map updates.
> 
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 0ce26b538075e..463f43b19e5cd 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -438,7 +438,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>  	u32 size;
>>  	int cpu, off = 0;
>>  
>> -	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
>> +	if (unlikely((u32)map_flags & ~(BPF_EXIST | BPF_NOEXIST | BPF_F_CPU | BPF_F_ALL_CPUS)))
>>  		/* unknown flags */
>>  		return -EINVAL;
>>  
>> @@ -446,7 +446,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>  		/* all elements were pre-allocated, cannot insert a new one */
>>  		return -E2BIG;
>>  
>> -	if (unlikely(map_flags == BPF_NOEXIST))
>> +	if (unlikely(map_flags & BPF_NOEXIST))
> 
> [Severity: Low]
> Does this validation correctly handle the case where both BPF_EXIST and
> BPF_NOEXIST are passed together?
> 
> Since the mask check above allows this mutually exclusive combination through,
> evaluating `map_flags & BPF_NOEXIST` as true here will return -EEXIST instead
> of the expected -EINVAL error code. Should an explicit check for the 
> combination of BPF_EXIST and BPF_NOEXIST be added here, similar to the one
> added for hash maps in htab_map_check_update_flags() in this same patch?
> 
>>  		/* all elements already exist */
>>  		return -EEXIST;
> 

As there is already a check for "BPF_NOEXIST", it is just a matter of
which error code to return, -EEXIST or -EINVAL. The implementation
currently handles it by prioritizing the BPF_NOEXIST.

There is a similar case for the combination of BPF_F_CPU and
BPF_F_ALL_CPUS, but the implementation already handles it by
prioritizing the BPF_F_CPU.

But let's wait for other reviews as well.

