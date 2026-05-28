Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC353AEF5A
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960650; cv=none; b=lqJN4/8O2pGeDsQAxkEaHmBs8K+QpcFoNaljhBZd1TV9p3xE8U2j0E4R+KIYVEAIYm9oCCy+Pxz40mDTuhGf8SfWBCupS2xWYOZ7F1uyPMbk278Gb51I24vUigUi74dg7vfSj5zBrMmIVk52b6NN8F+faKowcgOWQNhCmj6NsxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960650; c=relaxed/simple;
	bh=LoGASex2qnTG+TbDm1RTWf0ExI8R1+KY/4AGVcMtGWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QNk39zZC4qxfwbuMkQ2TSpo5QiOQ6lJkZ7b2d9alIixPzaOf9BJdZAaR8kiKGdLCddP4f/UzULZxmNpWB+d4TYnoO9Zj7C8sW6A/8/PIHxunMjPQ3gDZCzeVQ7jFvZnX0QLwnnoe/cucuGA8v2fWj+tXQoRf/s/y1ltaD8BWiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0pO4gbd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o52DZ/Fq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0pO4gbd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o52DZ/Fq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779960645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDPtL7TwxG75IfmZr4FfYfvPDdnmXjEs/bxPVe7ap1c=;
	b=f0pO4gbdAje+bUGJJpmNOBTVLTWgbtr09S6H7/x0qIrriZEEuAO84G0+FIt6OgUhSBsvEC
	5K+TtuC5BXNg2t/3/ZIr+D46B46ttIlg0qphs/7Y0FPZMGL7Cup+oFkpCCvhcmhw8rZ4fC
	xJmUqSh9G5gOfXwgqxFHwiEmjjtX9hg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-myA8ObbFPcyEYJua8aLu_w-1; Thu, 28 May 2026 05:30:43 -0400
X-MC-Unique: myA8ObbFPcyEYJua8aLu_w-1
X-Mimecast-MFC-AGG-ID: myA8ObbFPcyEYJua8aLu_w_1779960642
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45e80183514so8728303f8f.3
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779960642; x=1780565442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDPtL7TwxG75IfmZr4FfYfvPDdnmXjEs/bxPVe7ap1c=;
        b=o52DZ/FqAhN+vs84+yikxVl81ZMWIybv11FV3YEJ4xCeRw3dh8yi66KZGMozD/StiR
         2mTEk3hcROKX0BgdkkfLPoledB7cKzseQWbdBp1Z7SG5nKsYrGzScr/1WqXwjcxOSj6K
         WZ+uJgOF0QX6/j+Ra1JTHSUH7azaYbbv303jqemnzJxJPryg/L+MrPvHdms8YpeKHiBA
         ctwaqFLR5hWY1PlHtC94q8g+7XqcGEbF/zsxW0w3zgvl7IiIQoGZNVumcYK+tSlvaW+o
         a/kN4xwODcmtIjzJqyRcQ480CB4pmxEzA92yHv2At+uwa8e9/kPh22nLO5VstbPioUiZ
         YtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779960642; x=1780565442;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDPtL7TwxG75IfmZr4FfYfvPDdnmXjEs/bxPVe7ap1c=;
        b=ApM9O+r8HRlTaxXFX2pr72PSuOeN5mrSj9Ok08AziKPRU3/ekw4cwaB5DR/Q3l9BVn
         cnmBCiW5RHAE6I3r059SyY21NQfjwJUOTzmr3h+NtzHDW5J+MmQF3wsd07T8UuiukO8T
         +0yk5vnWH/QEEsp8plPXFTpmGR/c0UgLktRc7aByOkbyBi5dTTcqghNL7oqhvTyvCrUY
         8I+89yycNohqaZ6BmN09BZzVRgIhU9thN2E9QNI1SJvhkG4m9Ws4NtO5yOi1nQPvwdkd
         9kWoJNZyT2mwEJD5pYxWeuYct07W6mCON5IzvkMS/3lx8nNet3WrKBVKrWhlUEbyDQP5
         8wAA==
X-Forwarded-Encrypted: i=1; AFNElJ8kHBH3GVX2sIcJ0tE4bIB7jqb/1MKUUtqFfdWhfGdCrc6U7LDLcmQRIqY1bT+VZo1MYyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/RnmQU7/PDgQWfd1AUDB82DRtQxTgkhkLxVI2S3YHw40CO86w
	P6TsrgH6U+8mhqH9R5qZgcw6P6x/Qzqm1V724XwAI4b58gYB9wpgK3/8wXHAa/jNydSX+HBmk7F
	PW0ne9bh4OlkSymqyeETEwgUcHME24bIrZXnt/XWxosKGyUIhWkBfEg==
X-Gm-Gg: Acq92OEt9JDxWXq9nu+JGLe3IeFsZMhOhNj9YBY73ebL35emX9PQlvDA7wISMkVFica
	7dA02bVf+eJNImwev4rt4oLtPAAAIFvpO4dqAxFHfkmjhDKcOisdojun9yHZym43fQBhu5ML7hR
	JJCf6oDi8WnWH9hub2r7T93ijAJK9k/PvTzW4bgtF0cZpeU3uGc7RxKrEJPMwtyZ7746C7LQSC+
	tKLb+Y6AmeHHIYP+pC2xFX2++3JjrGDH5iLGkFl7cJHUsUNGwmoVs2qE7qCS869P5KAj1oHRilV
	+z/Q5C/KDftnNjQcBYJWSu82Ed31ywVDEoylmxm8ZLXSTsbjYWlCfO91pRfBy9ned3DHef8EUI+
	E7n+mprakfiIRLOmeNlRyA353sSAqDwvzHiI3eh+jTaNnpUVX1SE1UjkF+YVGHD4IVQ==
X-Received: by 2002:adf:e009:0:10b0:43d:c95b:c46f with SMTP id ffacd0b85a97d-45eb38bfdebmr32523739f8f.38.1779960642465;
        Thu, 28 May 2026 02:30:42 -0700 (PDT)
X-Received: by 2002:adf:e009:0:10b0:43d:c95b:c46f with SMTP id ffacd0b85a97d-45eb38bfdebmr32523688f8f.38.1779960641995;
        Thu, 28 May 2026 02:30:41 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a296bsm11898279f8f.21.2026.05.28.02.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 02:30:41 -0700 (PDT)
Message-ID: <3665f7c1-9c97-44ac-8b6a-e6c31ad96730@redhat.com>
Date: Thu, 28 May 2026 11:30:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: mana: Skip redundant detach on
 already-detached port
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, stephen@networkplumber.org,
 jacob.e.keller@intel.com, dipayanroy@microsoft.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 yury.norov@gmail.com, pavan.chebbi@broadcom.com
References: <20260525081129.1230035-1-dipayanroy@linux.microsoft.com>
 <20260525081129.1230035-3-dipayanroy@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260525081129.1230035-3-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/25/26 10:08 AM, Dipayaan Roy wrote:
> When mana_per_port_queue_reset_work_handler() runs after a previous
> detach succeeded but attach failed, the port is left in a detached
> state with apc->tx_qp and apc->rxqs already freed. Calling
> mana_detach() again unconditionally leads to NULL pointer dereferences
> during queue teardown.
> 
> Add an early exit in mana_detach() when the port is already in
> detached state (!netif_device_present) for non-close callers, making
> it safe to call idempotently. This allows the queue reset handler and
> other recovery paths to simply retry mana_attach() without redundant
> teardown.
> 
> Fixes: 3b194343c250 ("net: mana: Implement ndo_tx_timeout and serialize queue resets per port.")
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 0582803907a8..1e1ad2795c3c 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3350,6 +3350,12 @@ int mana_detach(struct net_device *ndev, bool from_close)
>  
>  	ASSERT_RTNL();
>  
> +	/* If already detached (indicates detach succeeded but attach failed
> +	 * previously). Now skip mana detach and just retry mana_attach.
> +	 */
> +	if (!from_close && !netif_device_present(ndev))
> +		return 0;
> +
>  	apc->port_st_save = apc->port_is_up;
>  	apc->port_is_up = false;

sashiko(gemini) notes the above can lead to different race:

---
Can this early return cause state machine corruption by bypassing the
updates
to apc->port_st_save?
Consider this sequence:
1. queue_reset_work runs, mana_detach() succeeds (apc->port_st_save = true,
   apc->port_is_up = false), but mana_attach() fails.
2. The admin brings the interface down (ip link set dev eth0 down), skipping
   mana_close() since apc->port_is_up is false.
3. The admin changes the MTU, triggering mana_change_mtu() which calls
   mana_detach() followed by mana_attach().
4. mana_detach() hits this new early return, preserving
   apc->port_st_save == true.
When mana_attach() runs, it sees apc->port_st_save == true and allocates
queues, setting apc->vport_use_count = 1 and apc->port_is_up = true, even
though the interface is administratively down.
If the admin then brings the interface up, mana_open() will unconditionally
call mana_alloc_queues(). That function calls mana_cfg_vport(), which will
return -EBUSY because apc->vport_use_count is already 1.
This leaves mana_open() failing and the interface down. Since the interface
is already down, trying to bring it down again is a no-op, meaning
mana_close() is never called to clean up the orphaned queues.
Does this sequence permanently brick the port until the driver is reloaded?
---

I think you need to be more restrictive in the early return check.

/P

