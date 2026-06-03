Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E7477998
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490835; cv=none; b=t7i19+9s+09lyiNmjC93umtFLx0eZ2uF0PE5ZmlNEbSqLd1Sx5dsMOofQ8/WUV/4VcCm/KMOD+yUWpt1goMFRAS7UywavRq5NLiQ9ntALEQEoIA/bgol6VAnO/HekxLSi7Q7cteth4GGxbgWxiL22ekYC+ST/FFxzpd3oEN9W/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490835; c=relaxed/simple;
	bh=xuk5LJsTEgR/F0PqyeTUVSI5oXkL3zqMuisiklQOfJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7YjjFGc4mWnzqggiCu77gLr4KW8nd7g4QqDFWPMeiv1FytIyFZRewBAPE8vqinxYawzM3kKH8rUY7U9awTkzut8WGlrakD9185QcZnHXzdWejifDR+i39+xbtqM7b+PcZa472hz/jN1Bjw1PLJOTjEhUSlutStkV2GyCYiEOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwxn/REC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwxn/REC"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eee266c6cso4920570f8f.1
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780490831; x=1781095631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiTDjKNv3GZkcXbuAoK0CK4IqwaNlLBn/iTalAwUTwc=;
        b=gwxn/RECP8zA53tjEwHtLQvXuNq8RrBfnN+5u2vo11v/I7uZhLu3tVQUPT6WmOLoym
         5xqqZ2TClP0GOFP8g0lo5Dma/PbyMVmtnEfTWNeDjgHw7NKfXmb0ubhJ4MVKgn8WrtTH
         frXsqPc1YE98jcHV/9mdfn4vHRMRiD53swbWA6QgWaHkMEo0rWJ1xB3ycj2rsAJvkIS/
         frTxuJJ3Q6UYpJEFjwYRQtPMPQ2tfl8CZiRqXi1+Aw6SYt8hRHDx3g91vPZeHwTFyrsu
         GqremN0oSMpmrY32m6B2ckmyHRsMscF7sNmHfGnUzjBOH2dpCFswkivmeUdcyrvIje4c
         VDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780490831; x=1781095631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiTDjKNv3GZkcXbuAoK0CK4IqwaNlLBn/iTalAwUTwc=;
        b=jS0gS2khODMeG22vgp4J3HZzj21u32AymrIyA+yCWus6q7YlgPHQIvUBzHZcRdwxfD
         a4xbJ5RtjGsjUEllEhQW1poFdgAKIslygljkA/ubaiJd3U86YM8xiGW446l+hQ24J9Go
         NYESS8l1wW6ClqzQCQcH4U068wovEEBLRmkDopNab8m39jeXlEYJkOd0HIJjvwWwOMPX
         57RVDVVq25aZ7PMLhdbvPhJh1wRvApu27bMM7KQe+QSbobNzl4RPG98I39xI1Yo9k/XV
         +ebc4RgwpybXr+J42EL94Y4zeSAlm6/lKoPeBeFu83xa7zJuU5yR20xC+uHBY3MlWINA
         WNGA==
X-Gm-Message-State: AOJu0YzXlJd1KbM+E9WBqgulN+O/w+pWume/9VE9SbuE/ccVL7BT0aw4
	lLlwvf8AgWQfxGtZEYMGFSK6N3ErLt0mp91VxlM++5z/ePT1Qx+fzAt4
X-Gm-Gg: Acq92OHAuizs4yOxKIR0alrD1Is6STletRbTZBhY3/mV41U8mOL8s3XkgvoxlR9x9cd
	HewFiICDa1lQmHqhF6a3F7XNQXBYPTVL0quBcabaMx7ZaATe30dJrxVMYmj+DPHETQmy9xBs/Fc
	8e46Ay0DHnklluKXTLhFMgnex49gOuSTZ7l8iC6Hi74oXje/UIs18m1SXgeFAzQ+AaFkISaoYRs
	KX6Jxd3iFKcck/ycyB8H7By9X/jvjD65wf/ert7ESKqzA3G0uptbaWyAlX70Eh02oYoupsxgdHz
	DO7zhc9rPobM4FY9HNBmeEeJaTbr+++B9F8AO3dtDduhGwE41X/skRumYzFOx+PQKcpzAW7S+oz
	bXfojNDG411IAA10LJCo9pmoi6fnNP5qU9BDlpCW6SOUp1ZTimdxjbaeeuWfRyXwOLrivflVLst
	ENvPCyNwtVNC/INprdTyki/Awp9zT5NW9Lv3paQ3CUplh2OlcGElDdzeAa7fjdEuNvBG6PRInbI
	IUxtQC5AO1cYestVs4Aeg==
X-Received: by 2002:a05:6000:2403:b0:45e:ea68:5237 with SMTP id ffacd0b85a97d-460218e10d9mr4228689f8f.11.1780490831325;
        Wed, 03 Jun 2026 05:47:11 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm7815199f8f.5.2026.06.03.05.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 05:47:10 -0700 (PDT)
Message-ID: <54556d8a-79d4-4beb-9956-1da0c3dbe5a8@gmail.com>
Date: Wed, 3 Jun 2026 13:47:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 01/11] rhashtable: Add rhashtable_next_key()
 API
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
 <20260602-rhash-v6-1-1bfd35a4184f@meta.com>
 <ah-RnMHSKUIIjwVb@gondor.apana.org.au>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <ah-RnMHSKUIIjwVb@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/26 3:29 AM, Herbert Xu wrote:
> On Tue, Jun 02, 2026 at 01:45:30PM -0700, Mykyta Yatsenko wrote:
>>
>> +static inline void *rhashtable_next_key(
>> +	struct rhashtable *ht, const void *prev_key,
>> +	const struct rhashtable_params params)
> 
> Why is this function inline? We only inline the fast path code
> and iterating the table does not warrant that treatment.
> 
> Just get rid of the params argument and make it out-of-line.
> 
> Thanks,

Got it, thanks for the feedback, will do in v7.

Cheers
