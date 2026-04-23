Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42CA33EAF9
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988239; cv=none; b=SGogSL9vxFN0kF2ssovAMQOPEGDlWBFthtoM9ag1/1FZwFFQ0vNH9hELOu9n2eSu067e5rXTU2embhfO4IsC8FUCsYXjnVWX7b7oajqujhGP9UkkzvatKML6K36O25ME3jlLe4QSxiORkdtRhXnZh5NhQmEDNhH4/OEGTAwiasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988239; c=relaxed/simple;
	bh=qr2WiQQecuPaUYPjW2Trq7UfNJ9ovwMsgiNRaFaPQVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoiXOamLb4297sGMICaEUtAxFlU1ZZYC895dX8Sy4q/CpdJLN4z98jbsAk7HRNqHtzXxHzmJza1gj7VRVs4j/XYRinNZyjD6QRG0Ef5muC98wtYnUdCvUY1SMiU57M8CH44/IMiH5PqUurVOvgFNBeV+bHODPSvXenifC5Cz6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqI1CcaQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqI1CcaQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ad135063so64006655e9.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 16:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776988236; x=1777593036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SoJDwPkMJRXAjZ4TZQiCf67HQrUPSbE7YmfZk1PoVRk=;
        b=AqI1CcaQyMh8YEbrdq0G8YCEsRf3xh+tYkfL4vUaPR1OSE96UrMGoYD9aLYczCJKM8
         ofZL5QOKbeHZlxs50fkkPHgF7GdKfL7YlQawGgW+SWJh8AA8FlXhrFilKI48YfKqjFJr
         qk7UZvO0DapMtkky7N3ewiRvT56WLvDUVshhuRx5kzD50MH8wcJQk177JF5SSKfNe1qU
         ytekYc5hLLqfRdxQI3uM7loXgErTRfLc/3i7lpPl1GV5IUe4vvRMBSneEF2gc+JYYioJ
         qGif7jC3O1bVYVCQsMHNRL891Q8iz+ntun4Or7pElbS9+EmkazsjykRxZZirtozhP6V/
         BtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776988236; x=1777593036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoJDwPkMJRXAjZ4TZQiCf67HQrUPSbE7YmfZk1PoVRk=;
        b=hs44JX9fhKtstyCsWu5NUrBxPw+DUKoeERmqkxeQ/tRtS853A/UQIORGQB9Vr5rphZ
         GLHiViycFtdUkQonfoWK52sW3mTQL2XcjJfCnLeHJElLqKmtxQ1bPJdBk+5mKkgxyIVT
         Uq1uHB0H7lHbc/nOIVM0U6yNL28ZMEqxwV1sgafZg/nnMI4sTN+tDPak9jKy8grAb3Zz
         feJ0JcSfknd1MM/3BLQBEnLPw5H35/dyBNFbXRsKysz40rw8xUJqBTSIcUg/fqw+v5hq
         l5hODzOfiPIUQt922vun8pi+PXzGFyCzRKfJEbfHt69Ib5I6XDViXvlUstl4N6+1QFdB
         aqqA==
X-Forwarded-Encrypted: i=1; AFNElJ9KX6CymwGzjVHr+LOKEA1HN1/+dLtmbiXU45nnYk+RPRXTxCinmWgUjCWpHLU9sSYhctM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5U5g/ywEBYkulzVM3cD7Q+3qm+ej1/oJaTKwB2kLaC4br/A0i
	bzFvUk7K6fFgeE+7SemlD7yh5JK6Y5LZfZZngXkO3O7ne3efIfsAOzOo
X-Gm-Gg: AeBDies8NoAqaJt/XPxZ0PAsvjjnprCg5OiCQ1+9LRD/G3+WuS+Lu//91jMemUcdnD8
	nL265UJZo6s2rsMnLBvChpKy4a1RnB7hAMiC4YVS0w0hgpyYVgYcjHCpEBtJGF1UXmaqdKJOraB
	BE8OstB1hHpPm//izCk42zpyJoEyS3VnvV+VhTc9/oiDH5CCKh+kpVvT9WAO3By7eb6ErLkiICB
	dckDtuigXGFezKPleftXvtllWYX0LeOw+O8z7GCLXywGi320CTeHG6CJc2RnbFSZdJE+XDBFFeQ
	QDgSdRxP8Z70jJqKQj3wOEjxDsAg3tdChc/unc2oh8z85+xqPK2P8QF6vVZFfVoTYnteBFWsZ8M
	iTYfJbSS25hP3bgeLvsUCl4V0nO1FBY0f33QeWt8/WchlAq6J8CzXUlRkc3t1K5Pgr7Rki9DfMw
	F14t788Tz/E9YkfWYiI+eM/AxhLyF127I4K3vVtW95KWsvhkCQQlQ+OOPqp2lWF8Ddl0xcwecAv
	SSDrZ8IBbHYsdjINZAaB1OXg7e+65kD
X-Received: by 2002:a05:600c:a108:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-488fb78ba6fmr352461715e9.24.1776988236004;
        Thu, 23 Apr 2026 16:50:36 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm97277615e9.23.2026.04.23.16.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 16:50:35 -0700 (PDT)
Message-ID: <8cc73c03-afb6-4b7d-97ea-e05d9cc56c2d@gmail.com>
Date: Fri, 24 Apr 2026 00:50:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v1 1/1] bpf: Fix sk_local_storage diag dumping
 uninitialized special fields
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com
References: <20260423222356.155387-1-ameryhung@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260423222356.155387-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/26 11:23 PM, Amery Hung wrote:
> Call check_and_init_map_value() after the copy_map_value() to zero out
> special field regions. diag_get() copies sk_local_storage map values
> into a netlink message using copy_map_value{_locked}(), which
> intentionally skip special fields. However, the destination buffer from
> nla_reserve_64bit() is not zeroed and the skipped regions contain
> uninitialized skb data can be sent to userspace.
> 
> Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>   net/core/bpf_sk_storage.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 14eb7812bda4..b50d26a542ed 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -558,6 +558,7 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
>   				      sdata->data, true);
>   	else
>   		copy_map_value(&smap->map, nla_data(nla_value), sdata->data);
> +	check_and_init_map_value(&smap->map, nla_data(nla_value));
>   

I think check_and_init_map_value() should be moved before the
copy_map_value(), because copy_map_value_locked() already uses
spin lock special field, which if uninitialized can deadlock?

>   	nla_nest_end(skb, nla_stg);
>   	return 0;

