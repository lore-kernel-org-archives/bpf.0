Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784B47A89D
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077775; cv=none; b=nEUqipKJPJ38PZOgbpm7cnuymDEGRJvLoCJcKFLWH6iBSDkAR2b330BwqmpaQrphqShaQ1xl/t+VmP4XH/W3VUJQy2aYqy0Is8JE0PCS5+ktvXhItEC067zVJiUbWOBonZd8yc3k6jdAjHxOdZTskd30gX5AzvgJdGYD4qqUtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077775; c=relaxed/simple;
	bh=HEXYHxn+Z0+LPHKPPsRT1TCzVbCiIfcZXSM8GfXnQbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMNU9bXe7RyqDmm2csDSrT2dVP4vnPEeQZbb7sEb1wDhtfzd2RG1m2QnvOgMME5fjHrusPB8JzHVUNg/F389WRkB+EwzEeMUmYeox9eoqi5ceN9uchbpdi9scV+gp4VmH8NseuxLoXasFORkj0LkqNTEjkj7KGY27gdQi4/3iLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXF722Ln; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXF722Ln"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-482f63546c5so3130135f8f.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 04:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790077772; x=1790682572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mqEoRXtKkxRNj1mr5zvC6xRKrFW0b6x3zXerZYbmh0g=;
        b=FXF722LntcH2oD9CUDXffgrHzs6TCRCul8IZJHqMoRh/8ciDn+Cq9PcvYJ90SCTh6s
         eoqMsWZtLUJ6SQ0/cM0DznOP4TOhBugO+nwpAA3HTz3w1hJlIxlXSmRadirUEobnYXER
         qnF+PMH2FpqF7C2zUrsVWBZshTAHtWLMQBP3KPgSNchOFijj6aKUv4nEgofhPbyICRjM
         FV48fhoHaR35ZxD1DQ219n/WJj31WccGRWtpnK0KAT2r+s+8gbPFedrWhjvMg8DmCkKG
         XAzHk+hWZDAFrl8L+DUJI3/gcmaXMYK57caynvK+W6PzsWoBL6CPws0sPCzdaD3YwaV+
         NXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790077772; x=1790682572;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mqEoRXtKkxRNj1mr5zvC6xRKrFW0b6x3zXerZYbmh0g=;
        b=UBhtrD3iYr2qn5yOgGvUy5e1yFB6C6XgEc6TqZouPHykIej0AS58P7eJYKU4DPHcM0
         8NqPfif+Xv8xhDQac9bHAKWg2d5D1RIgyyfujLlGOQ01RycYy/gXaGAMudeVYemT0pgv
         VUUbYEbAPudMg3wAhhhPLccrQbARjkh52E9ZAWgvgHsx7VD058neq8k/WmD+jrpIdZkK
         TUOR6Y9TmPntFEcMGzgHr58EwnzgsaY+Jx7Np4mYkVHy3UGvl7Sxj7VRrd3Pet5njCD1
         578JQVfskyeWqYfaCXKI7/XQOArkPF4TM5lv0vnyh71WzTKtzhJ1imzVnHT1IehO6UBD
         rZZg==
X-Forwarded-Encrypted: i=1; AKwUvByBL5QqmaW+7nH85gitQDS16TgC2YO7qluafredqP5+fe4OacwSg+odPAbGNAH3yCmx0M0=@vger.kernel.org
X-Gm-Message-State: AFuF++kLzBOoJCoq9AOjp7gsbYrp5sLVTuRfQk+dP7V+taEvBDfM+ceb
	V0NCCR9Zb5TGSyG/h+zA0GuKgi1b0uCVg/sxUEQ08tPGTPJMshu41giu
X-Gm-Gg: AYBFou39V/c1KRkMmHYBIw0IwIQYNkXnFz09IOfKMTM1lfUNx40H7M6zgcNQ/IaFFKP
	WCTDIwqiH662Ux3fYWbzhhTuTX1lH4lV1fMbgIdGuNnxPP1TIXdkMaGkGBnrKoM9tAjhHP7TolU
	N/pP7zAhgvK4oWvnL1rsC0eGhYxwljscmFD8kZF4ovvD+BM7U5qY6JYg20e/c4aBgWxmBNRFinO
	d+qjQe+VF7yE+CC+yWi364+l0YrRHyntuH4q3PlbVqjilKP+Ogez4K39atKxVs74tyb00trTXVA
	Rv6aBmMNXZcMJn1J+LxjBIaGEBLYltGdvVWafFMn3DxMsAY6VCesbPR5wY9EocYOeb69Oeq4OoJ
	9GmwWnqL+AKCS5NF+InfrjsDVF4QjusQnJHjEYlTfd+qqmoykZ/C6VYz2I+UM9DbAKvQq06ZFMx
	yE8wz5nRImvVXNZEWJB9fTDb2XkOD6KuJ9iY1eru7GFlbOXRQLOSXGQOJnQbYtVM3mbFVGZOexu
	gwDdoRd+eHPqOwMuL2J53Xi40vlDTPauWQ=
X-Received: by 2002:a05:6000:184a:b0:486:e300:a0c3 with SMTP id ffacd0b85a97d-4871e212306mr19840066f8f.12.1790077772299;
        Tue, 22 Sep 2026 04:49:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1715:59a3:7aab:2955? ([2620:10d:c092:500::7:c6a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862793528sm3832853f8f.36.2026.09.22.04.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 04:49:31 -0700 (PDT)
Message-ID: <dda58bff-1dd4-45a7-aecd-3383a28ce88c@gmail.com>
Date: Tue, 22 Sep 2026 12:49:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Speed up htab lookups for u32/u64 keys
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>
References: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>
 <DLLGNOQ59JIC.1O76G4NM0FXZ1@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DLLGNOQ59JIC.1O76G4NM0FXZ1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/26 2:40 AM, Alexei Starovoitov wrote:
> On Mon, Sep 21, 2026 at 02:28 PM Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>> +	/*
>> +	 * Fold the jhash constant and key length into hashrnd once for the
>> +	 * fixed-size fast paths instead of doing it on every lookup.
>> +	 */
>> +	if (htab->map.key_size == sizeof(u32) ||
>> +	    htab->map.key_size == sizeof(u64))
>> +		htab->hashrnd += JHASH_INITVAL + htab->map.key_size;
> 
> This optimization is probably not needed anymore?
> 
I'll double check with benchmark and remove if not needed in v3.>> -static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
>> +static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 key_size)
> 
> __htab_lookup() is __always_inline, but htab_map_hash() and
> lookup_nulls_elem_raw() that consume key_size are not.
> Whether memcmp() becomes a single compare in _u32/_u64 variants
> is up to the compiler. Make both __always_inline?
> 
Make sense, thanks.

