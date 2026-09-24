Received: from mail-pj2-f15.google.com (mail-pj2-f15.google.com [74.125.227.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFABE282F1F
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287443; cv=none; b=szURMUVxfQpZxW2SzgzNIVddwNNEr6dYNc/RYYZ5K5JzzSVjOgkQ1qc5DLedS9s2rzaTgb70S6zmNnNVUu6w3f3Ec5NbEqLRRv94MPTjoLHqQSif1M8Fyvl1ARU2hqfetSFLvHrY6GgQE5OAgNBDkhRU9ZuHAg+OhlwKHEvyCHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287443; c=relaxed/simple;
	bh=fvRRQUaXZ+msYz3u+44iu+s99ted+Q82ss42Zy1Xbuo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=SulZHFdPqlE2ZS1JtFWwbUdz0/xjvN/kglTPs6KWQUOR+4XWfPHG5FV1u633jkQNO9wrWFyKxwNHySuKR5tQWusNmvOk0ysM2M90As3ivawvGRbYeQI9mmga1Cm8LpkCB4gr6zP4WM/Nm9JXnLOnOmbR7647CCu/XmavSzK1/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=VCJkTC7B; arc=none smtp.client-ip=74.125.227.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="VCJkTC7B"
Received: by mail-pj2-f15.google.com with SMTP id d9443c01a7336-2d747f01363so1280105ad.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 15:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790287440; x=1790892240; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fvRRQUaXZ+msYz3u+44iu+s99ted+Q82ss42Zy1Xbuo=;
        b=VCJkTC7B33Yu1MC64s8FJzhY27y2Bp2/J8Hg4wN536ez0dFuIOIMRK6we0/JGaglfm
         j4DI78HtrNIfUZfM8F0pQfCs0T3piNEWpzIqFf+aUQ+sj+9ercCwwKW7DX2+WsczqUEZ
         JN8Zz2d7gDzF0NeE8WhH/ln0X/0nmqNOwkFAPB22lz/pVF7jeus+9W4NifFeW5JkIbxK
         QsoH+BcJxw6pSNtzpnaa0VYoL0xiH2/7jRjUS7x6R+MEoOfuUqMBM901yLe1Izd0LhNx
         +BFNjYxdzKcFpk6VLz88T6eJYTzBrr3BDfRA9SghRSKmWQ3nURLOxbuqHGhijspX56DK
         4v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790287440; x=1790892240;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvRRQUaXZ+msYz3u+44iu+s99ted+Q82ss42Zy1Xbuo=;
        b=fUjrCcVmGxX+n/ZwPyk10lgOQcY2mb1XyBEcv30uKC/Xlf3rVpHBTfrxcUguS/76IH
         +g4+NIR1oxmGoLVtaDn/kD/GAQepq+OMGQ1YcizMDBSL0mHRdLKMvWDWjPQooeU9XMbT
         4cjtYwfXRgXnbHERxAFJsIVH6ri2zTrAFPyxq2v7k06D76BhnVyoMWnXR2gjr4Ay44pj
         gb1lZR9FQj+8PrU8aHIPhlQvgqaMZdIQac/SWWzfpPmHrY+L0bR8McT72KKcNChiJleV
         PSOr74gvtCtGdgoUUMeLfpOuh92pWe+PijPUNlgdLLQl5QSJZddsDs+hM33dXjSvPwQO
         BL/A==
X-Forwarded-Encrypted: i=1; AKwUvBwgGKz6HWiG63KraectAIYXoJJAbUUNIhsjyDirSi8ysesJyMNzl43kwIktViO6/9JtI8U=@vger.kernel.org
X-Gm-Message-State: AFuF++ncqimI24GH3oXry5yM6jLWoXxefe4vgdwExwrLmWTlzSEfKn2y
	CHcGw9Idnh1TOVMucmNSVhRgwq9GqNYzapIHfcDBDBdoDlt3nc/s2VCNI2LlXzG2U8A=
X-Gm-Gg: AYBFou0Ajm36yqBB7H8EVFLuiYm2AqsYVHHQGvtTMHmb/7sXsf54203tPVQJvBnMwMH
	ok8jLC+bXyk5LLwTDsJ319hythwPEMmSJPmdW2jFzOWBcR85OOY2NO0CO2xs7zItmedVXVw5EWT
	AZbG5VrJVqKUkoos4gAT2LE40lPkboPpc+gX5hixk8CalzF0F1Qk+Eeig/nhZph/gBo9NxSm6Zp
	xc6HhN90cHkcjuwSmGBFLZlsp8fPdz5upWwcJmqPK8OcehW4zDpwGabsYejJgbgXdHPwWj3lsz4
	g2btOM7ZXccqQIjNmuXDSs6VKg4qfn9pZq0Ex1r+cAetHdTjw35Ke2pJQZPzr4scj9QemITpCss
	i/HGcqlUew2Sab0p6IWrA93hEZrFB6joOTMpBc78tyAZa1FghyED3/UcWAcP/4hGhhLk7I4Tehs
	ozBnFq6mZ7TDhlRf5nQty42BY4GFLde31PMVjB4pas4o8CUsxllG0da3gnEV25vsRkEamBotwtE
	CsdgB4t5x//+F8UTRZX7H/ECqHtY4Ul
X-Received: by 2002:a17:902:f789:b0:2dd:ad74:ac83 with SMTP id d9443c01a7336-2df94b9280emr1048285ad.30.1790287439663;
        Thu, 24 Sep 2026 15:03:59 -0700 (PDT)
Received: from localhost (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91460aaasm1605575ad.73.2026.09.24.15.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 15:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 22:03:57 +0000
Message-Id: <DLNVXIS2M1DR.A0RIZCKWG1UN@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 1/2] bpf: Add sleepable arena page allocation
 path
X-Mailer: aerc 0.21.0
References: <20260924053621.7076-1-emil@etsalapatis.com>
 <20260924053621.7076-2-emil@etsalapatis.com>
 <DLNVA9111IMS.2GQ5DERPDAH6I@gmail.com>
In-Reply-To: <DLNVA9111IMS.2GQ5DERPDAH6I@gmail.com>

On Thu Sep 24, 2026 at 9:33 PM UTC, Alexei Starovoitov wrote:
> On Thu, Sep 24, 2026 at 05:36 AM Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
>> Add a separate arena page allocation path just for sleepable callers.
>> The path preallocates the arena memory to be added to the tree before
>> taking the critical section.
>
> Another idea...
> can we drop pages[] and link the pages via page->pcp_llist
> the way apply_range_clear_cb() does on the free side ?
>
> Then both sleepable and non-sleepable allocate all pages before
> taking the lock and there is no need for kvcalloc vs kmalloc_nolock,
> batching, etc.
> The whole function will probably be much simpler.

That would be ideal. Most of the complexity of this has been shaping the
function around the fact we need these intermediate arrays that force us
to drop the lock to refill/possibly require significant memory allocations.
pcp_llist should be available to use after allocating the page. I'll adjust
and resend.

>
> pw-bot: cr

