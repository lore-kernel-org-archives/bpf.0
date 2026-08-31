Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C4F3C13E9
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179022; cv=none; b=WnNKbNAllRtx+r2up8L+7ptglA/YLIPxSLcipQ4bZcMRBD4oCXbtIclFGQOOKkNF8ywBurdncsZ1x5rgdw9UPn3ugjuUYSpIYGSjtcvvWMTZ9EuhxuNPRZ97OnZff3YfFXgkCDTxzWR9BMtDErdGsONP/HlYByptepF4ThcNPHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179022; c=relaxed/simple;
	bh=qChoQUFD1Zlm65GbRLHIYaP34Mm7OHm/rIuo6JMu3yA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rpos/eRndyfgynA2CDCVULmFQQjEIlkt4Vj+VooPNXmEKZTsL04pczkbSodfHgJ6q3Oio+x/1zV1Lbycp9N5sMhmEIv5koi73tMddmTw1JI59Yn3HRfON1Q3YbeDZn3KJE/tcZmtqkUP0Nz5QA5K/MXpECaLgGqJGR29IcZkKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Td7GKnMD; arc=none smtp.client-ip=95.215.58.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Td7GKnMD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qChoQUFD1Zlm65GbRLHIYaP34Mm7OHm/rIuo6JMu3yA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788179017; v=1; x=1788783817;
 b=Td7GKnMDfwwaRSd9e09p4Dp1PVLj5vO3D7eaH6Kr6Ur/s4d/P1w9mH/0i2zhmMx598k4MkVX
 WGBEyeXgRuRMVQSIRShB+Zzej0+JznFj86vYIDqJy69GXY1LFFArFC17IG2vbmKW9mZMfY00DPp
 isxyLe6MQpJLdCM8+6WytnKU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 87f723dfa3cb502b;
	Mon, 31 Aug 2026 12:23:37 +0000
X-Mizu-Trace-ID: 87f723dfa3cb502b
X-Migadu-Flow: FLOW_OUT
Message-ID: <1c8d7218-a61d-43a7-8565-9329b8a8d12e@linux.dev>
Date: Mon, 31 Aug 2026 20:23:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/5] bpf: Fix NULL-ptr-deref when showing a void
 BTF type
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260831110314.150870-1-jiayuan.chen@linux.dev>
 <20260831110314.150870-3-jiayuan.chen@linux.dev>
 <20260831113506.D1C561F000E9@smtp.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260831113506.D1C561F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 8/31/26 7:35 PM, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] btf_var_show() unconditionally dereferences btf_type_ops(t) which can be NULL if a VAR resolves to the void type.
> --
>
> commit e40701f4e16b364aff9e3327fa4cdff79bc39336
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> bpf: Fix NULL-ptr-deref when showing a void BTF type
>
> btf_modifier_show() resolves the modifier and then calls
> btf_type_ops(t)->show() unconditionally. For the void type (type_id 0,
> BTF_KIND_UNKN) kind_ops[] has no entry, so ->show is NULL.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index da36d4b9d31ab..81506cbb9f9ae 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -2911,7 +2911,15 @@ static void btf_modifier_show(const struct btf *btf,
>>   	else
>>   		t = btf_type_skip_modifiers(btf, type_id, NULL);
>>   
>> -	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
>> +	/*
>> +	 * A modifier can resolve to the void type (e.g. "const void"), which
>> +	 * has no show op (kind_ops[BTF_KIND_UNKN] is NULL). Print a placeholder
>> +	 * instead of dereferencing NULL.
>> +	 */
>> +	if (!btf_type_ops(t))
>> +		btf_df_show(btf, t, type_id, data, bits_offset, show);
>> +	else
>> +		btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
>>   }
>>   
>>   static void btf_var_show(const struct btf *btf, const struct btf_type *t,
> [Severity: High]
> This isn't a bug introduced by this patch, but does btf_var_show() have the
> same problem where btf_type_ops(t) can be NULL if a VAR resolves to the void
> type?


Yes, I fix it in  [PATCH 3/5].


