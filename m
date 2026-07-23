Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183A447807
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815932; cv=none; b=uv8BYDxZ+kxZvye6pbAY6IqH85y3rMIRSzce3ZiBCdwOqNP8EEN/cGJEqYm23x7lWef3k4t1q1v4PC6yu4L+4ZPIIDRTEBgeIYh+xK4VuFUdUS9Otj4PglBEwLrpVnnFEZ6xCtYpVZIe/5ZB0SX6duPzVdqfMgUIqDZkPuoIhg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815932; c=relaxed/simple;
	bh=GZTfIQvF0oPDZeyCs+MdWt748jfjlzSCN/KAcJI3Fic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YButr1Jg5Hh4xZ0p4GUEZUyNDgXSEhomKqVQpnMMSttX3EFG7UKGWPhwIkyRA9POXpeiXsqT+angBH7Tyeg7lfWid0FaOfNQrDfGqJfntaoAXUOeWQqcyH10QUTSWs8dtB9Il9fDjxakmy24lCMoVD5b/pv3pc/7HGokAE9TJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAldTSC0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAldTSC0"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so622493f8f.1
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784815923; x=1785420723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1XQefTGt3GGOzzOfzTSkYQpSOiy/K/m4PaZ+Y/MEVQw=;
        b=rAldTSC0foVs88bZHvIP4MTDHfx7sGd70VfbLTtiPoyLJAOb2fH2jNzRmvPTCYdh9F
         xi0iZpFUfGITlymlhkAzv9xIGqNemuY3zK+iXSQs/fJgaqpOOgwS9ceuuK/rw+MivMlr
         L2OPQOCCUb+ELJod83aMKdjsKw09wxRM5+TxN+zFaZrrMbBvNVTZ1+LclvuyytS4ocJE
         Znl2pbXY68q0IAPZluBwy6RA7Pha2WDmwOYBNZ/aZMSO6yTiaV8ZLaP6+etAYZUAu/71
         4+YUI+P5C70/FD9CEkHJYTdJY8RCCZufpxIFZ5OurQ/DsZD40R7xmS+lAxZjKpSbTkNI
         xJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815923; x=1785420723;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1XQefTGt3GGOzzOfzTSkYQpSOiy/K/m4PaZ+Y/MEVQw=;
        b=kyuRy6CFkWaQD+EqqWK9UmgA4xYeSzwf1U3+4u9Yblf15ckx3EacwuzoM9KJYwtH1U
         kBej7rs3Zq+aiCczn563O9hb82U6Saxcqe5TxiVWOkLos8mghIWa9E3CuJ4I3WacToYl
         8Y1waY5dXTT7GYM/TPwZSkaiF9gYAsT/7Bb94QTa79hNiFmZaGA242jNtGyZdyC38Fjh
         uJ8i3oXrzvNg/0PANZlU3U0T/dD80dGr5FsONRwtVjAVw1wMQDyP9d9YS/jAZJ4rcVvl
         J+QRZXN4aN51DMHIkN3wXgY2787pt26dYAa9Yzybx/97rFtIF0YUMuwUnGeq6xl5CyAX
         bGxQ==
X-Gm-Message-State: AOJu0YwsshHGpZokPlvfeguFJfR//BV5/x/Z9e+F0cHtebHV3S0tSvs0
	Ru9fJ+GV+ZPHTReRMfjIVjm/Qn5AMXZL1KuB424BN8mqrDrRugzRyhc6
X-Gm-Gg: AR+sD12AxUbBQxT+unoqpYOletLX6LNjCuiduZmXr2eKeCuzxfFC7OLEtzLsNZNEy6K
	OQ5VwycDduIqFumwOW/G84HpksSU592nIB/MONn6r3ByPl8sRxx5sgv4kGiQlW3iwgz+IxrLyLT
	2y3opHAzFtlDQJqv944GsAGGrrX+eX+1Oq8Y/DayzyAXXjQC4frBjQX4W9Bh5OjmNKtAn+FkJq4
	VSkFoTFTZpgYhctnaYk/Fm+eBiUHoxahnBc4JPGvVqaXXFrUhFEsfDdzkWw9iB+9vPEvsKJ4iB+
	6Hc53X6KvwEG2emdNO1ocSFDzneRgnr9+Ehtt35C29VJOBtuZ7i8iFZLXgpW2sIZ6z4aR1dCZXO
	wTZgzAieGTZahMm2m7+ZHl9opbQVF+avwhwYqSIGQTZeUEGB4+J4up+HY5CtDmLZuzO/ojKLFhU
	lmWr/2O7yHxzA8Q8Y0cXW7KKDAbGFx471Zf3LkZkhGJSKjxCVb0w==
X-Received: by 2002:a05:600c:4ed2:b0:495:3f26:97fb with SMTP id 5b1f17b1804b1-49573cba103mr36502125e9.3.1784815923172;
        Thu, 23 Jul 2026 07:12:03 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:b876:739d:6f1f:1b78? ([2620:10d:c092:500::4:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4aae16sm154682445e9.0.2026.07.23.07.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 07:12:02 -0700 (PDT)
Message-ID: <0fe51955-39f7-48ca-8ce5-bc842868d53e@gmail.com>
Date: Thu, 23 Jul 2026 15:12:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] bpf: htab: Reduce elem_size by 8 bytes for small key
 sizes
To: "T.J. Mercier" <tjmercier@google.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260722203801.1854941-1-tjmercier@google.com>
 <20260722203801.1854941-3-tjmercier@google.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260722203801.1854941-3-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/22/26 9:38 PM, T.J. Mercier wrote:
> For standard and PCPU (non-LRU) hash maps with small key sizes (<= 8
> bytes), comparing keys requires only an 8 byte compare. Storing a cached
> 32-bit hash value to shortcut full key comparisons provides no
> performance advantage for small keys, and consumes memory for every
> element.
> 
> This memory can be saved by eliminating hash along with its associated
> 4 byte padding before the key, reducing the elem_size (and key_offset)
> by 8 bytes for standard and PCPU maps.
> 
> Introduce htab_has_hash() to check whether a map requires a cached hash
> field. Update htab_elem_set_hash(), lookup_elem_raw(), and
> lookup_nulls_elem_raw() to conditionally bypass hash checking and
> storage when htab_has_hash() is false.
> 
> Together with the previous patch, this reduces the minimum standard and
> preallocated hash map element size from 64 bytes down to 32 bytes, and
> non-preallocated per-CPU element size from 64 bytes down to 40 bytes.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  kernel/bpf/hashtab.c                          | 35 +++++++++++++------
>  .../selftests/bpf/progs/map_ptr_kern.c        |  2 +-
>  2 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 57729c3dff3d..b8c30d402958 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
...
>  
>  	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> -		if (htab_elem_hash(htab, l) == hash &&
> +		if ((!htab_has_hash(htab) || htab_elem_hash(htab, l) == hash) &&
>  		    !memcmp(htab_elem_key(htab, l), key, key_size))
>  			return l;
>  
> @@ -812,7 +825,7 @@ static struct htab_elem *lookup_nulls_elem_raw(struct bpf_htab *htab,
>  
>  again:
>  	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> -		if (htab_elem_hash(htab, l) == hash &&
> +		if ((!htab_has_hash(htab) || htab_elem_hash(htab, l) == hash) &&

htab_has_hash() is constant for any concrete map, maybe we can store it in the 
struct bpf_htab (it has few holes) and we already describe layout there, 
or at least not calculate on each element in the bucket in the loop.

>  		    !memcmp(htab_elem_key(htab, l), key, key_size))
>  			return l;
>  
> @@ -3219,7 +3232,7 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
>  {
>  	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>  
> -	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
> +	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor, offsetof(struct rhtab_elem, data));
>  }
>  
>  static void rhtab_map_free_internal_structs(struct bpf_map *map)
> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> index 373c8d17ea55..6bd4cb68c20c 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -114,7 +114,7 @@ static inline int check_hash(void)
>  	VERIFY(check_default_noinline(&hash->map, map));
>  
>  	VERIFY(hash->n_buckets == MAX_ENTRIES);
> -	VERIFY(hash->elem_size == 64);
> +	VERIFY(hash->elem_size == 32);
>  
>  	VERIFY(hash->count.counter == 0);
>  	VERIFY(bpf_map_sum_elem_count(map) == 0);

