Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF73A9870
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791286262; cv=none; b=YsNh0VwGsu9kDAfcefiSdR7scGNBNMHt+QOb2bLtKm57jGqM3dBeMXp+c9WXYZPLhsQ6oVr/UIVk/CnIhg0mnrvHY/zklrLh7cu6ZYZGkyMNYiSf6ugm7NTMCAKef/JU8OlWT/QT9CZSV0E7m0KI+vQ6Cm9Rm+dmkMvkvDR5udY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791286262; c=relaxed/simple;
	bh=R4Q6Oufor1a5QGPX/ia8OLnOebta9NNQBwUAa7to8wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4zq+bkNmtB6tq9SAnXWEcVGdeCFyNuCeiBD8so+CrHqp/zhS9jUS7ImH2CDY2xSDF22W2Mcw64StSDHq0SItaS7uGyAsNMl9pBtJZ+EtxPJyXnP+Cx9QY5f5xjevvyeuziVNcSpfX0D6sjHfmfAFDNM+M3FHjoI2N2CtiAtJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLFE8bzo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NaAXzZbh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLFE8bzo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NaAXzZbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791286258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R29e74OCsihxaScB7A5LszBTHN9x/Z//RuBavLbJ3M=;
	b=eLFE8bzoW1uB4tGWVkCxhMgO0KWTzlnbRxk94NAkejnCobAA6NPncZ1GI2WQ7nemZQ2JL2
	ly6sOh6zhP3Md6ORsZLXX+rBzdWbNt4K4QwSiHlAnT1IzVJEawqMScZaEBaaMw4hgrrO2M
	0JYFxegEnISCZ8iiqqHOijKZCsGJkSA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ZFGwQCT1MM2fidh13RhPfg-1; Tue, 06 Oct 2026 07:30:57 -0400
X-MC-Unique: ZFGwQCT1MM2fidh13RhPfg-1
X-Mimecast-MFC-AGG-ID: ZFGwQCT1MM2fidh13RhPfg_1791286256
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a17574b5easo12269575e9.2
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791286256; x=1791891056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3R29e74OCsihxaScB7A5LszBTHN9x/Z//RuBavLbJ3M=;
        b=NaAXzZbhMOOKUACQo9J1Dy5wG1jy8AEo+zrFwORkHZtGjCE97MfBMEjeZHVpcmdhCP
         dDznGU49rEbIMiryvUeyM/HaE7v3H8AKrdducweVljbwxUoMF6pUpcLNr1/uEaV3JfTc
         owirJmFgJUOxrr/BzrVCn5upfajowRbc+3j3I84qVeSobrpyAa4JxqDrbKbx8gM78Cod
         5d59Y5Wy3VusieTl7xySao0XF2q7JvTi1rlxBavMjF39dDKQP4h1doMIdTqcPM0ojrmS
         AKr8OHu6QnFZHzHUbKYHR/JsDRt50WfAv3eM9u/3LRyZXN+lZTiaJ2MyDVyFWeXZBpDW
         hzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286256; x=1791891056;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3R29e74OCsihxaScB7A5LszBTHN9x/Z//RuBavLbJ3M=;
        b=q6+7+pR31j/oCNMEV5HrDFr5pVT050Qv7GTLoZDrnY88kjww1qRhye0EsgeLM0Wans
         JIWEy2MVASN9Q6srdlSLzJ/4W0KY9xew6/sLG5sTKsT0C6ZD0viqshjRSjrBYu2C0Ifl
         9kIt/YwG8uBNtkTdyz18WYmbqHEM4GYhU90ZtsVOj+yBHcDrNr1pUzPYLmiYTEmVS22A
         3LpRfFxXYRGrlkAQTS71T63twfqkmEZog1azGZNsSp+MbpDzGOUdDCY3eJGNmR7Rsi5d
         3Wx0KVgFQMN+ooIKMXiani+9oDDxD9wtXMve/z3RWjvXOzqxrJu6YvmS9qsb5JQvOHqL
         YvCQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9bIaDLo6Ol0fqCx0Nc4KxGJZHfza6nkq0ubjkm5J5GgO655DStNWkrZH3y0jHr7xI6mY=@vger.kernel.org
X-Gm-Message-State: AFuF++nddPNHdOwN+IIE6WdlZ4L1DbLrClTZ9SpJNwtX+Fo94jQL6mAZ
	gudJSLZF64lbYSwelWqTC5pWCpLGKdAHVnY380mpdG7pSly7WcjEmd8Iq8jekNzU8WK+H+/sfNC
	WQVwFtqd+Q0sYYT6y1jEymqtPK30rJYCkNdgkC6FMu0CoKE3ZcvRB30arEdiVWA==
X-Gm-Gg: AYBFou19+MYI6O+OUmQcsxg8QvwyQ4MVgpTtYT6ofgPlHWH+Bc5CT0jJH+zT5rvVgPQ
	F+3uj5xo2HUBr02X8IGmi6+uyuHoIK1GY5BXJooGSB/EcCObRhEFakFRNK9CpS1zzi5oBHk3KDM
	MwfQyZH+EJwNgLUEFFKW4HLtkMcfviMlJ4B2wEEQch/l404DFzNbMkn+gI9855DQnWOo9Q8E2tz
	DyOf9g+7QW3jsRXExHzMlCtfWF+/UB+s5RMcN8il/qxJXzBXVSXkvXQHbC/Yssgv8z6rRP0waZi
	R2kEji7P2WVq7tBGhEGH2YhnKusOGxSMe6JcYO4+0RFyE02bgHqq63Pz08as8g==
X-Received: by 2002:a05:600c:3115:b0:49f:cac3:c68a with SMTP id 5b1f17b1804b1-4a168105ddfmr171529425e9.31.1791286255720;
        Tue, 06 Oct 2026 04:30:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3115:b0:49f:cac3:c68a with SMTP id 5b1f17b1804b1-4a168105ddfmr171528815e9.31.1791286254840;
        Tue, 06 Oct 2026 04:30:54 -0700 (PDT)
Received: from [10.43.3.161] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03fef174bsm257722415e9.2.2026.10.06.04.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 04:30:54 -0700 (PDT)
Message-ID: <ba8144c2-10f5-4448-80f5-d10d786bd8bb@redhat.com>
Date: Tue, 6 Oct 2026 13:30:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from the
 response descriptor
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-8-poros@redhat.com>
 <20261002132739.B6C0F1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261002132739.B6C0F1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/2/26 15:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ice: conflated -ENOSPC causes silent MAC filter drop on queue full
> --
>
> commit 5b00f3f5a2fd8517b295e1041c4e6854bbdcfd81
> Author: Petr Oros <poros@redhat.com>
>
> ice: take the switch rule AQ error from the response descriptor
>
> This commit modifies how the driver extracts switch rule AQ errors by directly
> reading the return code from the descriptor that ice_aq_send_cmd() copies back,
> rather than from hw->adminq.sq_last_status. This avoids races when other
> commands complete and overwrite the shared last status variable.
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> [ ... ]
>> @@ -450,7 +448,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
>>   		 * should go into promiscuous mode. There should be some
>>   		 * space reserved for promiscuous filters.
>>   		 */
>> -		if (hw->adminq.sq_last_status == LIBIE_AQ_RC_ENOSPC &&
>> +		if (err == -ENOSPC &&
>>   		    !test_and_set_bit(ICE_FLTR_OVERFLOW_PROMISC,
>>   				      vsi->state)) {
>>   			promisc_forced_on = true;
> [Severity: High]
> Does this change unintentionally catch transient software queue exhaustion
> errors?
>
> If ice_sq_send_cmd() returns a native software -ENOSPC because the control
> send queue is temporarily full (e.g., under heavy administrative queue load),
> this fallback block will now catch it.
>
> Previously, this block was gated behind the hardware-specific
> hw->adminq.sq_last_status == LIBIE_AQ_RC_ENOSPC check. By changing it to
> check err == -ENOSPC, a temporary queue-full condition could be misidentified
> as a permanent hardware MAC filter limit.
>
> This would cause the driver to erroneously set the overflow state bit and
> return success, dropping MAC filters and leaving the hardware permanently out
> of sync with the OS.
The send queue can not be temporarily full. Commands are sent one at a
time under sq_lock and each one waits for its completion, and the queue
is reclaimed from the FW head pointer. It only fills up once the FW has
stopped processing the AQ for 191 commands in a row, and at that point
no filter can be programmed either way.
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
>> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> [ ... ]
>> +	if (status) {
>> +		enum libie_aq_err aq_err = le16_to_cpu(desc.retval) & 0xff;
>> +
>> +		if (opc != ice_aqc_opc_add_sw_rules &&
>> +		    aq_err == LIBIE_AQ_RC_ENOENT)
>> +			status = -ENOENT;
>> +		else if (opc == ice_aqc_opc_add_sw_rules &&
>> +			 aq_err == LIBIE_AQ_RC_ENOSPC)
>> +			status = -ENOSPC;
>> +	}
> [Severity: High]
> Will this translation ignore hardware MAC filter exhaustion during rule
> updates?
>
> Because the error translation is strictly gated behind
> opc == ice_aqc_opc_add_sw_rules, if a rule update command (e.g., expanding
> a VSI list) triggers hardware exhaustion, it appears it will return a generic
> -EIO rather than -ENOSPC.
An update modifies an existing rule and the FW does not allocate
anything for it. The VSI list allocation in that path goes through
ice_aq_alloc_free_res(), not through ice_aq_sw_rules(), so the
translation is limited to add on purpose, the same way ca1fdb885e5f
limited ENOENT to the non-add commands.

>
> Additionally, native software -ENOSPC errors returned directly by
> ice_sq_send_cmd() will pass through unchanged, leading to the conflation
> issue mentioned above in ice_vsi_sync_fltr().
  See above, that needs a send queue the FW stopped draining.

