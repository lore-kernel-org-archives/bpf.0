Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA153876BE
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598931; cv=none; b=aHrpsYFuporhXzRgCQNGvbmQtOc1T3+kWYe3O8gmYv2beckwh0KMnWvJX8Ukh9Uqs9JEdFRznmID2I0K7MtKU8FxOlALQdaveOnaXZNwIgsxnaX3+FF1IMGUfr3ZO/slc7kk2t76UZ8fdp3w3AvvY4WAaBsbjFhOeNWSvgV23bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598931; c=relaxed/simple;
	bh=Wx1AAq7GS77Yx+NHTkcZG7Jf5qgN+SY6zII626i8Irs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCO5X8Bq8iu9/6OLUpJTcIi6GAtdyNFO2CAO8OaEvAxtksq4O2l8+5BB8X0OhDpqAWMgEuCJmQS9Hy/U84Cs6429PorktpHDBxfYJ/W/JvRh/y/lCCN7H1BvVGhNASO2zN9lm88zX+KgwSKzXK4iCH+MjIPpJtkiqfX4//H6W88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=J+rhqAoG; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="J+rhqAoG"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4884687E85;
	Mon, 24 Aug 2026 21:15:26 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l1BdpqQ-OZcP; Mon, 24 Aug 2026 21:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1787598925; bh=Wx1AAq7GS77Yx+NHTkcZG7Jf5qgN+SY6zII626i8Irs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J+rhqAoGTWVueMGXgQIFOvn/axEYe/Cb53LIHgMt4KjQPbycCduXLEbBDWwg2hRBi
	 N5TRs+mEOfEjihourU+OeTh4vHCfbjN3TFNwISk/GkDkhPpA8yamtzbpev9YcbSX3S
	 R9YZNfVqbWsS0qfVNVB9vOsX9vS4HBsh9DzDF8lzFt1b90BykYDPEaPwFiHvDWGXQC
	 T28ty1VUEZdVhAv7Gm/009UuW4E/be1YpRcxEeoO5EzBja8yF1q139JQCPuWPD+yip
	 /wmJB+Ixfj+HKxKgfiOlDiVO5FGhDM7LYSyxCofLc8JDMuUbTPi/J7fTZU+h+XEFJA
	 wUO1vX/fyipKg==
Message-ID: <bdfd2ebf-b249-43cd-a393-0088a7accfe0@disroot.org>
Date: Mon, 24 Aug 2026 20:15:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: Fix u32 overflow issue in map batch operations
To: bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com,
 brianvv@google.com
References: <20260824113123.270057-1-maghasi@disroot.org>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <20260824113123.270057-1-maghasi@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/08/2026 12:42, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:
>
> Pre-existing issues:
> - [High] Missing `size_t` cast in `key_size * bucket_cnt` and
`value_size * bucket_cnt` length calculations leads to 32-bit integer
overflow and silent data truncation in `__htab_map_lookup_and_delete_batch`.
> --
>
> --- Patch [1]: [PATCH] bpf: Fix u32 overflow issue in map batch
operations ---
> commit c9edb3a32ad168bfaf9df954c22a4563c73796f6
> Author: Masoud Aghasi <maghasi@disroot.org>
>
> bpf: Fix u32 overflow issue in map batch operations
>
> This patch addresses a u32 overflow issue in map batch operations where
> address calculations exceeding 4GB could lead to data corruption. It
> resolves this by casting the counter variables to size_t before
> multiplying them by the map's key or value size.
>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index d8db1cebc1936..334eeb297892e 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -1978,9 +1978,9 @@ __htab_map_lookup_and_delete_batch(struct
bpf_map *map,
>>
>>  	rcu_read_unlock();
>>  	bpf_enable_instrumentation();
>> -	if (bucket_cnt && (copy_to_user(ukeys + total * key_size, keys,
>> +	if (bucket_cnt && (copy_to_user(ukeys + (size_t)total * key_size, keys,
>>  	    key_size * bucket_cnt) ||
>> -	    copy_to_user(uvalues + total * value_size, values,
>> +	    copy_to_user(uvalues + (size_t)total * value_size, values,
>
> [Severity: High]
> This is a pre-existing issue, but does key_size * bucket_cnt or
> value_size * bucket_cnt also need a size_t cast here?
>
> If value_size * bucket_cnt exceeds 4GB, the 32-bit integer overflow would
> truncate the length argument to copy_to_user() in
> __htab_map_lookup_and_delete_batch(), causing it to copy less data than
> expected. This could result in silent data loss since the elements are
> permanently deleted from the kernel map, while the syscall falsely returns
> success.
>
>>  	    value_size * bucket_cnt))) {
>>  		ret = -EFAULT;
>>  		goto after_loop;
>


As far as I understand it, the key_size + value_size must be less than
4MB at-least on x86_64 systems. so if the bucket_cnt be higher than
1024, an overflow would be possible. Also the possibility of the
bucket_cnt be higher than 1024 depends on the hashing algorithm used.

As the hash is a u32 value and the key of the hash map could be a bigger
type, I would say there is a possibility of overflow here as well, and
we must add the fix for this case too, in the v2.

I will try to look deeper into the hashing algorithm and see whether I
can reproduce a bucket_cnt large enough to trigger the overflow. If
anyone has a more concrete understanding of the bounds here, please let
me know.
