Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14019371D05
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776895103; cv=none; b=WspZcIpCWXejxJyqpDcjlNr2z2JUKFpoSEiSn/CKAIZoIaS/5yeWpGt1T1P4Q8nJP0j+k8ir2/nQca0qpYcuCXAn/atDEFc2fOHXBtsp7JRRwcPxaGIHWBZL2U79zDPTDgV8HQ8bvlZ/vPytHfVjlOZPpbakpRv9gOmAjO90+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776895103; c=relaxed/simple;
	bh=GzHVAmsLzPuelQXQHQrVV3DAhz1JSgmFcYw+FXXnjMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHFzUmb+orTVBjo2FsSiV6MF25/lqn3qiCUvvu+7F7xawX9FTCqgop3h9LNdQtH2PrBn7Bn+I3yceiSvkawhJ39TnaSDuW72+MfRveR9lFZS6PYjhLpyhb3X/oEs3ku7wPQzFa1urKpbjwpY8cg45EhZw7+0K0sjgamlescxvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf2kU7R+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf2kU7R+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so77996245e9.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 14:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776895100; x=1777499900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuCrp9vHvm93F/m655sREzL7Gh/S5uVZ2N8F50ItWVg=;
        b=gf2kU7R+8lACzlYkqVPilvWZl2tDRZVw0hnN5jBkNpPdEFKWwacioM4kKJmTOyJK0X
         jZwtCI+HdAQOBx9GWEMc497zBYLerTdCmx38x5zG4mXLPGxwdNBbBthE7uobBu4LLaJJ
         cEFexorEi7XI4VyGGBBWA7n+53ubTSD+dhZR95aAxDULN5NZY9SwvC+CymhUJR5qkS5q
         7esGZp0krCHGqa+A2goYFZWxEgEm0jWjv9FZOT7sra3rJGOsbA+H597BRzwnaYRLiDBL
         uMGtJm6oToEfomuBQhvOGa/RNa24v+jQtH//aeeSuaEi+4WUPc4TSCPQVSTA/zJp8yaV
         nyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776895100; x=1777499900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuCrp9vHvm93F/m655sREzL7Gh/S5uVZ2N8F50ItWVg=;
        b=iGKL5MLcVdBDOhOxFXzUrab8mqaVZlKcuk+4n6duwVPryzg/Mr2xPjd/V6UeZT+kJk
         qQ9Wx2djEjjlzKM0onj8i6NefTW7u+A3Suoiy9cas0UAIIM1fy2yiHs9kgqD1jhK8n+e
         6QlbQtKqrJQvbDbZAVTBDAhwi4DfRooC04Q7ulSFBfIpOezqaFknFrV3/ofUSaogUDdJ
         wGim2jFY7R76KpyGC67odL2NZFEChN/8o3jo+EtlCDvRBfjRinzQ7aQRgIyrp+5skybB
         XU5XV/hp73y/6oecqyUemApesjt6ZbP0c/V0MEhJ0ZHjK/nLekY71QGjtJsQ7y4OeJgA
         kM0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+6P8nhwKmDzc0ZD6cFDZ5i8y7Cb7407NgsbOV0P247DA2+1oNuBvB2vkALtaBj85R71Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT31YzI9Yr550idq1oKVQjLMZ5uRc+YfAPGWKfaV5ddnQl7QVb
	u+aAW+v9FMlGKf7L910hxrM1aPieNxe+Qzs33OpnOrpkjzmIC6BJ+ti8
X-Gm-Gg: AeBDieu082KCny2SIM42hQXRHNMzDW1qLJjLKk1pfl2knUfLMcpIrMyrskXcDZcX79u
	n1Xccb1m2Vr0dZgcv5Wq/txEtyXQSLpqtgGiswJSwZm78G793FJpC1hbvvmFnkJxSp2/gz91HFl
	Bf6yGgD7h0SeTuR16rzAmqrVXddE7jAb14GE/5ujLLHi6Xw9zkiMm4alB38Ui2WoK+oqhsXc6DK
	owdolZvzrL+UCuIPM6a8u9i22XBpOLUsQE9igMuhkiC5uy5Z0Zd7+niEnWDt+HSmj7UMiu9bCzv
	R6zDhWc4O23whETAt7QJqNSSmJQi2tJj6VoKHh4zdBgUMrb897k77H7YgQ14i60iyYfBVWefQW8
	kvsxoShyAZwlYog38xeOcFpf2RcKTDTD9ImtiNlSXHaKpVHV3Naqk9myMAgTFRlpuWUcHgVz4Qv
	Yb2aDP8SdshAze6+1bCblM6pXOA1YlIaMldPVnQQMkCeGjDiLUJ+OOqdcaL3LHXwA6560+xRZgH
	7vfQjXtsGncBh8jmIq4ah3fu0mjAPWDpFMpbrRR6d2WSTYTEBDuOx40cB6FaxnbBsvk84ABa4Wt
	jxSZ4Lr+O1B4
X-Received: by 2002:a05:600c:468c:b0:48a:56d5:16f2 with SMTP id 5b1f17b1804b1-48a56d5179amr120772365e9.7.1776895100454;
        Wed, 22 Apr 2026 14:58:20 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cc7b2efsm151827445e9.0.2026.04.22.14.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 14:58:19 -0700 (PDT)
Message-ID: <e49d1391-b06f-4d60-98ff-0f034f2ed9e9@gmail.com>
Date: Wed, 22 Apr 2026 22:58:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: fix missing submitter_task ownership check in
 bpf_io_reg()
To: Gabriel Krisman Bertazi <krisman@suse.de>,
 Ali Raza <elirazamumtaz@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260422-master-v1-1-e82f47558345@gmail.com>
 <87eck6ofo8.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <87eck6ofo8.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/26 22:20, Gabriel Krisman Bertazi wrote:
> Ali Raza <elirazamumtaz@gmail.com> writes:
> 
>> bpf_io_reg() installs a BPF struct_ops loop_step on any io_uring ring
>> the caller holds a file descriptor for.  io_uring_ctx_get_file() only
>> validates that the fd resolves to an io_uring file; it does not verify
>> the caller has authority over the ring's submitter_task.
>>
>> A parallel path in io_uring_register() already enforces this:
>>
>>      if (ctx->submitter_task && ctx->submitter_task != current)
>>          return -EEXIST;  /* register.c:733 */
> 
> How is this a protection?  I thought ctx->submitter_task is about
> IORING_SETUP_SINGLE_ISSUER. there is no permission or capability over
> it against other processes.
> 
>> Without the equivalent check in bpf_io_reg(), a local user with
>> CAP_PERFMON can exploit IORING_SETUP_R_DISABLED -- which defers
> 
> I'd argue this is a non-issue.

Right, it involves receiving a ring from an untrusted source and
then using it. Any application doing that is extremely broken,
even without any bpf you can use that to do some pretty nasty things

   If you have CAP_PERFMON, you are able to
> mess with the process in many ways beyond this.  Otherwise, how a
> process would be able to get the fd in the first place?



-- 
Pavel Begunkov

