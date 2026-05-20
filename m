Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30113D8137
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296359; cv=none; b=KTNNE5a3tHUoVnnktpiicvpHHE5mlnpxmLuc5kTNstZOxkZhjBAQXcaVwTWBa/TkD+PtWhw1SpiD1NdmM3zwSd6C7vYes7e8ri/wr97T7KWn9Mlqpd4bbkQx964CaPBg7eEeIvpEaBYa8udDLoy+duUYeRJfvACUQBRgbBbKHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296359; c=relaxed/simple;
	bh=AIhvkw0yBDgtvPsGE5h15ItzE0NtmWKsmKdeIQzLbpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOasv0JHlry6vikOAEzJQqDdX2KrBpGtQ6Jxboy/Rf77eofczmF7GdKvno5EC1FlnvXcZqzUo1MOqiWyfNc0XF1vlOnlOT+32pR/ADoMAv4o+Mi12FJlhvTiTbMq0W1icmkFz//eJAKaZIoFu244Ttl0BvoCiAKtEfallNBdA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt4uN8yV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt4uN8yV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bcd3ac3307so29130085ad.0
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779296357; x=1779901157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7TAEp9q//rixySKUh0Tspzo/0EDR88Kz9RGYRdINGA=;
        b=Xt4uN8yVvxa9hVN1z29L2KOGHYh0NsE3A3GRJA6naizfc37eEDzZZcDfObA2CAmq1U
         c3yjUmA949D1gkGyQznm1dxzWbOFwLJ36DE1/y443cxHxgJLF7kuLyuJBOIA1d6edNiq
         kmKlb5QdIa7rNNz8+vqcxMvgQQzGlzYWTpCFJm7nMd4L8WyV34Nv1NUfQP5YHbo8WDJD
         iy1u2Kv5HSwjIFryNxaYYp3td+hJUTSpz7KUYUGU0z31aeoGD5j2kLr0mm23NIvlfm9j
         U3gJw5OutCbGYYSJyAyyFP/hSjwHWAmFU/sV+d+Q8IAnDLiCkIyXkCcJi0c4SVDJji4S
         8RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296357; x=1779901157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7TAEp9q//rixySKUh0Tspzo/0EDR88Kz9RGYRdINGA=;
        b=jnNu3AvkPUAYSbpmAThdtbh6nZiulimkCi5yvme9KGY40j9T2ieEEzVwxreXaexhS9
         kDFoLcnAFuDVpb1KNq2zrcGX2/gORdKcq3AoJVdJ4ZdbDRG3+An+x2AXcULf9P6taeUL
         1jresME8xlajh4i4NzqAA/TRl2hiYt0FbOU0vA325SbOKW/nkpEa8EjSvL+zwszZBtSM
         n9aRffVhhYre10FlM2UMmaumYPudjK08y0sS+6lXQQUMyC4ICxirZjAWls0ZX3Qyddr/
         ND7VI1VuLjfVib8aa8lCuUf1Cdi4cf5i6FhzRKq4Uce3AcESSmrKpbZj20PCBpfpHLOI
         sooA==
X-Forwarded-Encrypted: i=1; AFNElJ9fsFp7aDCRP0TuFTDTsYYfM7WflSNISihbldG5DeN97OeRrnj99M1SI4MQQS7lsURcC2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Je79yhbkP47rxAR475z8iD8GSxvjiIUuvfhfevP+30ad7syq
	r+xOyvie3hdWb9yhbccp1/2LXCUuP3UR5S5cSwKa8H2Z0d5lZk+25KCt
X-Gm-Gg: Acq92OHeoHW98yLsL2GhGjMNwRcBXNDfy0TvOxJ4/orWfujfFVjoND3420EHp1HiQbI
	BAWKQCXFw0WWA0W7N76hPCJ/o7OzfonJHATSaTgzq9j1rfTVbUZs5MhosYXZ+bqQgYXPjNeOr1C
	L/D7FLMM8b+2HDkUGDUwgnuYYYWzTJ4uUhuSzLAmspoJLcNWsGdNZE7oP4OiXrbtxZ1OhFgKadH
	2povhp6PXdUGYZnGsfBB6UVIIKOBgqq/+yIR78ueDglTH9vBMpOoz1D6Bj6iv1j/POjKwpPi69r
	EHjAdoA8GjsG+8AbzHpbquK5d0Z6YSuIRbLBpWD4kzfJHMZTZApQU5lppqd92Jm29p5cve+oWFQ
	vPRbktDJuORQNKrozK1NgO5clM1ou1t/yxWMj/fUhrWliW/Fv7X0yeRPhr1DrmtdgeHZEqHomh5
	iT0Ck88e3t7OdVmYmTCPkc
X-Received: by 2002:a17:902:f987:b0:2bd:2430:eb7b with SMTP id d9443c01a7336-2bd7e8cbdf8mr183864475ad.12.1779296356690;
        Wed, 20 May 2026 09:59:16 -0700 (PDT)
Received: from john-p8 ([98.97.43.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11b495sm234935005ad.69.2026.05.20.09.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:59:16 -0700 (PDT)
Date: Wed, 20 May 2026 09:59:14 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: rollkingzzc@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, jakub@cloudflare.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com, 
	stable@vger.kernel.org, martin.lau@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v3] bpf, sockmap: keep sk_msg copy state in sync
Message-ID: <ds3zog2r7avfbiu6je6v24oevvg3ogaegkrjdv3w7ibm5eb7hy@unozyvsnb2ou>
References: <20260520102715.3033936-1-rollkingzzc@gmail.com>
 <646104384170b8d95ce979ba3d0bd87a808e5dd2a1f6b2bc4e0a346ca38e654d@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <646104384170b8d95ce979ba3d0bd87a808e5dd2a1f6b2bc4e0a346ca38e654d@mail.kernel.org>

On Wed, May 20, 2026 at 11:09:36AM +0000, bot+bpf-ci@kernel.org wrote:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 9590877b0714..223d78708486 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>
>[ ... ]
>
>> @@ -2794,6 +2835,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>>  {
>>  	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
>>  	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
>> +	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;
>> +	bool rsge_copy = false;
>>  	u8 *raw, *to, *from;
>>  	struct page *page;
>>
>> @@ -2866,6 +2909,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>>  			sk_msg_iter_var_prev(i);
>>  		psge = sk_msg_elem(msg, i);
>>  		rsge = sk_msg_elem_cpy(msg, i);
>> +		rsge_copy = sk_msg_elem_is_copy(msg, i);
>>
>>  		psge->length = start - offset;
>>  		rsge.length -= psge->length;

Zhang,

Did you want to push two smallish patches to fix these two? I have had
similar patches on my test system for a few days so they LGTM. These
two fixes

>
>    page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC |
>                       __GFP_COMP | __GFP_ZERO,
>                       get_order(copy + len));
>

and

>
>    rsge.offset += start - offset;
>

bot must be reading reviews because I called that out in v2.

[...]

>
>Could the ring buffer state become corrupted when data is appended exactly
>at the end of the message and the ring buffer is full?
>
>If data is appended exactly at the end of the message (start == offset +
>l), the loop finishes with i pointing to the unused slot msg->sg.end. If
>the ring buffer is full (!space), the coalescing fallback logic reads:
>
>    copy = msg->sg.data[i].length
>
>Because i points to an unused slot, its length is 0, making copy == 0, and
>the fallback coalescing block is bypassed. The function then
>unconditionally calls:
>
>    sk_msg_iter_next(msg, end)
>
>which increments msg->sg.end. Since the ring buffer was already full,
>advancing msg->sg.end causes it to wrap around and equal msg->sg.start.
>This could corrupt the ring buffer state and overwrite the first element
>without calling put_page(), leading to page leaks.

^^^

This one I haven't looked into yet. Let me know if you have time to get
to above two issues this week would be great to get a v1 out at least.

Thanks,
John
