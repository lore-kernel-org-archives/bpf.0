Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69142F6E7
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341132; cv=none; b=CRR+/Wf7zSv8YohoZ5tlgT93MoroyyKlHupTGZqn++Xur9eeqm/wfGumaP8mbWrTZCq9xUxpJ6/rZVsZxU9fj+7fzRpgDvYlMi7nkd5L6z6YI+gKEeIObfyc1PSAyokd6OQz5KIRcWFo9OKPTcK4SdTpBvFimGS2D3hWKYzVhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341132; c=relaxed/simple;
	bh=jK4ZlhYedd4DEg6MSR/LED1W882a6z/xcp0Bv8UCfCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwPbsH/QuMfud78Lbyv5uhqxj2rhZTPCjTThJxsZwJM9bAp67wOx/BIRvPTrHpscow4Z1FTHboltyjcAWot/WSnwzL+2xg/T5lL4BLbAFq9NpIMsnbtp7qm/s9j6y5BmRmUSR5RTAIW0h7gxlMKuI8CXszbLKofLkq+BYJuONGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E18WooU1; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E18WooU1"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8143daf89c7so25795937b3.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783341125; x=1783945925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vY6rzYAt+ZQcO2ZDLPVLwSbWNgumvFKyf8BqCln01Do=;
        b=E18WooU1SZSlTPxCokaGlaqlqgKjf3ediTexgb90kr/pPsjkxPxOPJ57v8hOI7UVFq
         r1ky4BUbth+UoIL+1HlhHxASShqLG7l/8BywXApvNuhyZIpyHVv+E39YOedO+YMy16jC
         OoIiRZs6hhRg7THDRccpDtFE7E7ewkVof4Mhc0dI1TMXpZiNEVTLtFXSqXLlj9NRmyQE
         Mbz0a5vKBA5LPQRAUMldqjMafugIyGgujwIBPUHqwGrtFC1/gXMcUW+z9OsG8gLJwfJT
         smHRALzwniYnkv6xTZ0jrNo6+y4PkHmmYET3b834xVGKj4gQnmsMzUnS31FAwzl2YiV4
         ioiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341125; x=1783945925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vY6rzYAt+ZQcO2ZDLPVLwSbWNgumvFKyf8BqCln01Do=;
        b=NMpxXp3PmcBe8P1W50hmhodYtgW9KcOCuhJjut6Oa7/ryUkTEbZBLmIkO7AMjkl/ye
         VSrerM0eG9sWLtMW7dipSYK//Oi/Wqv9ma0TLi4hl0z3+fqubbqUGCl7r2mlZaeuWdSP
         N/tUlVRBrzLXAu2A7O2XdZ7xElgHk226Cv30agZGwt7Pu7Z894TD15Xm7gwR9JOsM9Nz
         5yza7XhWkaYQmrPaH/Mmy9wYI8TP/n1zRuVQ552OpCrCSiCFTZXF1PvjNlbPOUcV/54j
         OJevNQS6dO2fFxZd9eBHaSCde7qSzKpqJxXn/1ZgZRnqzjjpIF8Bos9rIOWsev37kRsv
         hluA==
X-Forwarded-Encrypted: i=1; AHgh+Rpf6Vtgbt+a+z1oDWL4PEqQojHWAsKWbqVt0G6vVlz2TG8EquO8eKwu9ru3KinMPG4Czqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8pv37iYh/uwEk+WqT5mcLBtixBIX2Wekan+BSYvpwwDnt9Lqw
	mtpANWc8ylIchY8TIlWCA2SRjfFd3SHuK6AAKHtjN1dW95B61VpwKJiw
X-Gm-Gg: AfdE7cmcGrmtzLd+anJd7Mw1cRysU+0rONxheH2luGz/lf5qbJ9odP7Gg8kF3jwNpIw
	cPoQ9NSP4pPHTDuZZJnU2nB7wJl5okMXXcGQEAqKwaHPNRyVfX47xjJ/oWg5Za8FNmtycXR5wAm
	Wwke0PH/ysfPIdWlYXhnNjG5RbKfEnpW03nWOCAtqzZUYE4se+hiHYPSAHDUJIbBt4W+UUThI3n
	AJ7ZoINHQFn8Jwyf1KhiwzW9xI34gM3SIgPs6hePHnUYitjUJU13Wx/L01A7vAXCM6B39MC2UsF
	vwIf8PhIXqacBfNebHH1BvYmYItAXXsN4EzAFjVZ7TA7Kb40Xkiz75s3K2svT8nRO4TB2hKPkH/
	zFYfP1w6pzH738TpJo92GGFDDnEu0Qm6yPVwVgyFpM2BupYT8VBS74vEo5CagmVbYfSALAd53i8
	Npmia0mwM3X3tcY+2WOBPx853tHLKm/XnDLywC9hl23egaUN0=
X-Received: by 2002:a05:690c:6013:b0:80c:de1d:3154 with SMTP id 00721157ae682-81be26662eamr156487b3.35.1783341125333;
        Mon, 06 Jul 2026 05:32:05 -0700 (PDT)
Received: from computer ([2405:201:d015:d26b:41c5:151e:6e02:36c7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81be1d3c4f8sm148277b3.14.2026.07.06.05.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:32:05 -0700 (PDT)
Date: Mon, 6 Jul 2026 18:01:56 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] libbpf: Limit bitfield dump reads to checked bytes
Message-ID: <akugPNylTrOa_bNn@computer>
References: <20260706023632.625353-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706023632.625353-1-lgs201920130244@gmail.com>

On Mon, Jul 06, 2026 at 10:36:32AM +0800, Guangshuo Li wrote:
> btf_dump_get_bitfield_value() bounds-checks the number of bytes covered
> by the bitfield, but the value-building loops read the full backing type
> size. For narrow bitfields this can read past the checked range.
> 
> Checking the full backing type size is too strict for packed bitfields.
> For example, a packed structure can contain an 8-bit field backed by an
> int type whose BTF size is 4, while the actual object bytes covering the
> field are only 1 byte.
> 
> Keep the bounds check based on the bytes covered by the field, and make
> the value-building loops consume the same checked byte range. Preserve
> the full-size read for the non-bitfield path used by unaligned enum
> values.

This seems like it's heading in the correct direction, but to justify a change
here, could you provide examples that can break the older
implementation, if possible, with an ASAN report ? If it's not really
possible to craft something like that, then this would be an unnecessary
change.

> Fixes: 5714ca8cba5e ("libbpf: Fix OOB read in btf_dump_get_bitfield_value")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Do not check the full backing type size, as it rejects valid packed
>     bitfields.
>   - Limit the value-building loops to the checked byte range instead.
>   - Preserve the non-bitfield path used for unaligned enum values.
> 
>  tools/lib/bpf/btf_dump.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index cc1ba65bb6c5..5d185f7961ff 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1766,17 +1766,21 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
>  	__u64 num = 0;
>  	int i;
>  
> -	/* Calculate how many bytes cover the bitfield */
> -	start_bit = bits_offset % 8;
> -	nr_bytes = (start_bit + bit_sz + 7) / 8;
> +	if (bit_sz) {
> +		/* Calculate how many bytes cover the bitfield */
> +		start_bit = bits_offset % 8;
> +		nr_bytes = (start_bit + bit_sz + 7) / 8;
> +	} else {
> +		nr_bytes = t->size;
> +	}
>  
>  	/* Bound check */
>  	if (data + nr_bytes > d->typed_dump->data_end)
>  		return -E2BIG;
>  
>  	/* Maximum supported bitfield size is 64 bits */
> -	if (t->size > 8) {
> -		pr_warn("unexpected bitfield size %d\n", t->size);
> +	if (nr_bytes < 1 || nr_bytes > 8) {
> +		pr_warn("unexpected bitfield size %d\n", nr_bytes);
>  		return -EINVAL;
>  	}
>  
> @@ -1784,13 +1788,13 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
>  	 * stored in num, then we left/right shift num to eliminate irrelevant bits.
>  	 */
>  #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> -	for (i = t->size - 1; i >= 0; i--)
> +	for (i = nr_bytes - 1; i >= 0; i--)
>  		num = num * 256 + bytes[i];
> -	nr_copy_bits = bit_sz + bits_offset;
> +	nr_copy_bits = bit_sz ? bit_sz + bits_offset : nr_bytes * 8;
>  #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> -	for (i = 0; i < t->size; i++)
> +	for (i = 0; i < nr_bytes; i++)
>  		num = num * 256 + bytes[i];
> -	nr_copy_bits = t->size * 8 - bits_offset;
> +	nr_copy_bits = nr_bytes * 8 - bits_offset;
>  #else
>  # error "Unrecognized __BYTE_ORDER__"
>  #endif
> -- 
> 2.43.0
> 
