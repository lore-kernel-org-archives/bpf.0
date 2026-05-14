Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC13DDDB9
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767187; cv=none; b=nKqPgmFxr8wGEpC0JDa8zQyn9yT+w7t0tcR/bJ7k3RmZQyReyzlgmKqqloAXLWunjcakxwYWfLQidMfpTOc/McWaMdefPaQ9hB07OYPhBZsgBZwQF0P0WfF/+PsBWKtOuKY4kOeBrfwx7xtpT2dCvNa1HlKgpyaJSYcnhcPyoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767187; c=relaxed/simple;
	bh=lHFHcdCgyxowlommR+Hc85Hdpy+9KDeFLu5ofaX7pl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfZvR15xfRKE8cfaPdfkaE64RMzMLEOsOw3sf/9R0GXaFzp/zOurvhQ1Kg5VmKENEfvihS/Qq1EKoWPzf04i35G94xc8b6RRHWk61H2wEsu5B+JJ1D4laykA9nQcb3AKs31hxA3GHAsHO4lN19njEYARAOGlgbxeG6L1U1PHDYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q3y659eW; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q3y659eW"
Message-ID: <7a386625-5793-41eb-a54c-dc3f2aac4ded@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778767175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMD5+LsVBdcbtaYpVHc8wi6uHui78QTN6NfCPibQN1I=;
	b=Q3y659eWkEWVFrfPy07RIDx6KOhOadqhEc91KufiOI5R9yA4n5mccimDDtQnA+el3T0WxE
	toD5fVxN8xtpm8HRA4BQ+TiyRvTf6pPPwJjmIPGs6IsFmEa2C3nTLvWz/BE5w6IWjI2ZPv
	Rl70VfbuPtycg3XpnJltSPujXoOkT5k=
Date: Thu, 14 May 2026 21:59:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 6/8] bpf: Add syscall common attributes
 support for map_create
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf <bpf@vger.kernel.org>
References: <20260511152817.89191-7-leon.hwang@linux.dev>
 <20260512233658.CEED7C2BCB0@smtp.kernel.org>
 <3c9b4ff0-7a62-4053-83c7-23151905c742@linux.dev>
 <CAADnVQ+XR3kyqizGgGhtG5xiBu3oK3O+COUMfPDQDBSJbm=56A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+XR3kyqizGgGhtG5xiBu3oK3O+COUMfPDQDBSJbm=56A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026/5/14 01:02, Alexei Starovoitov wrote:
> On Wed, May 13, 2026 at 3:50 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 13/5/26 07:36, sashiko-bot@kernel.org wrote:
>> [...]
>>>> +
>>>> +    err = __map_create(attr, uattr, log);
>>>> +
>>>> +    ret = bpf_log_attr_finalize(&attr_log, log);
>>>> +    if (ret) {
>>>> +            if (err >= 0)
>>>> +                    close_fd(err);
>>>
>>> Is it safe to call close_fd() here? Since __map_create() uses
>>> bpf_map_new_fd() to allocate and publish the file descriptor via
>>> fd_install(), the file descriptor is already visible to userspace.
>>>
>>
>> I think it is acceptable to close_fd() here, that the duration between
>> fd_install() and close_fd() is short.
> 
> bot is correct. Let's avoid these races.
> Pls move bpf_log_attr_finalize() into map_create and do it
> before security_bpf_map_create.

Will do it.

Thanks,
Leon

