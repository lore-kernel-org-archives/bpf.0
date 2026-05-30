Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB62D1F40
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780106666; cv=none; b=AMKOoyCEdcrfl+n2nEVkmkQWV2IalmNiwGFpBfkPMVPSI4CNCWCuxU3YqK6SDm2lHcZpFX0+SM/cpqOO7utF2uEuw55b3D/D9E26b1rcwCP/dRqd8YzOj+FnNCBupCl21h7E3jZHFK3DK03J/My9EGwSkWb6gNV8WaAqHWlmv28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780106666; c=relaxed/simple;
	bh=7WBejSlv+HgO8c8WsxFa7qZJ9ay/KQ2PyyIZvINwRiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+XYnqzFIxULv0/BWBbz30d/SuVsEEyj3eop+b0AqiGhDVUXu4IsCMRB+0Tx6B4DgF0BtkZ9Jnv1Ohc/CC+9CdKltEJDUeMqgpq5C8BFg6+UMk666ljmhWmMhsvMaHTqj8qmzqP/Wn5oIW2QC0Gq+8PsKKfOb351CFDV5ID5T9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=H1PtMmFF; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="H1PtMmFF"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b5232009a6so198516476d6.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 19:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780106664; x=1780711464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyvQQy5ElSJ4C47Ku7QQerTV5jy4JNAb0KjCorJ5mco=;
        b=H1PtMmFFt1aCNvVPpfp3DBZ0e3KJMpoVNTwdgWDyDuU7pBei12iz2IUrRMW92oBbLk
         gNyyxdlpOQ3wY/iTrTuxi+HxngdWowv0EHUygwwtvlaeb+yRCQHmCSShGQVFYBgeqINW
         fRSsWzB9OyidAMZpqopYW8XqWa47U7IwD3Nf9WmKsECbdkz9xn36+XEF5CwBXpjf4ZPO
         0aFBqxuAy6pLDEjfdRydWBB4+2mTajC4fExCuYK7d3KUex7zj+RsZiKV9Ws9n8tiFKFf
         YDG/5rFl1RxoqcLjkUNf+N+7r/jD9Hm8WnkYnOKPdzutI/KHoPXo5g7QjJEahb6flAH0
         RSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780106664; x=1780711464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyvQQy5ElSJ4C47Ku7QQerTV5jy4JNAb0KjCorJ5mco=;
        b=CA6MLlsBcUtdzJ2s98RVlhlm02Ca6271zhYXfipyAk0RjadcGCHnyQaLHQFlD46D/C
         9L7BNIq6itFNjqfHkPT2Kb5r+IfFU8QShK4DmA9P0arprGEBMoIFxcQjEH4JJ7pAiatK
         JAg4XZF3WO4mfCx1UrRzao/eECkjA84SfxPi7zU/11j0BRt5FpTKLayJXAVWJKtK8yWH
         MHpJ2IKbHJ5dJjoUWuza5sCFUKxNRsI9F8l6Yjnkcj2gEXXK16vhtAUnK9v2ToKxb0IW
         J/w/x0GHJhiIwpssqLX6n4X/IqNEO3YM2d6GBnrS+D2SAlN8hK5DrXAEnHV/9s3iSfyS
         zZ7g==
X-Gm-Message-State: AOJu0YxUOPmNxzgFsSUDqq9xPV3sVQft9Uz0tpipyU9dikkoMedyu99E
	qvv4iT+V0WdaX0YJVm2TR/1egDytBPdQ5lGGLtIBn5tUj+sI6cDpNHq3mNMPiPmeux5lMO8RiFc
	+D4ZHV2g=
X-Gm-Gg: Acq92OE7Uuxo+s7vXHK+n6yyCr0yFnO9AMFHQ5JKtjSM/x0k5yjdT4Zb027noxSmFUF
	7Ycsckb5lpfW7DrIsZv1KWxcWsN3O+ll3cAkVfOtn9cjmgx9cRWMEDB+jpQblwIp+vDu6MSk0bd
	8ndpwMat9jDwejmb5jpVU+2hce4HoNTd3LrFZDrAMI9mbKgcHSe6KvBqRWNjGzeOJZyAVNC80Dm
	gBmm6P4ldwRV9dUlQFPYD7VisfjkHHOvYSnLhqMCk6iNkCa+fa85/pT/B3EUAwFwmhk+P1cc+vA
	6srDux7nV0zQCtQPxv96OMvDL1wXgdCENGSRRjZo42L8YHFOjT/yg6Th45IdpbwEgP6v7s8Q4nX
	j5KnN0tzITzkYtFrWSlaGLnXKVpUhV6cVwMBe8f4jMThvnD28i84lsoBP+9Ij/BCb04NxNkhjfL
	wDAeWzhFWMkUFf0vX8nZKgQjZz3RdcYDTfMX1knZ+ohEnD
X-Received: by 2002:a05:6214:2b0c:b0:8b7:4b46:1248 with SMTP id 6a1803df08f44-8ccefd983f6mr34849436d6.24.1780106664446;
        Fri, 29 May 2026 19:04:24 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea06d4casm32658206d6.16.2026.05.29.19.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 19:04:24 -0700 (PDT)
Message-ID: <40dbc071-1430-4364-a4ce-30666f90793a@riscstar.com>
Date: Fri, 29 May 2026 21:04:23 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/12] net: pcs: pcs-xpcs: select operating mode
 for 10G-baseR capable PCS
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
References: <20260501155421.3329862-3-elder@riscstar.com>
 <20260502155614.2CCCCC19425@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502155614.2CCCCC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 10:56 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] The generic workaround unconditionally overwrites `MDIO_CTRL2`, breaking Wangxun hardware.
> - [High] Transitioning from SGMII/1000BASEX to 10GBASE-R leaves MDIO_CTRL2 in a broken state, preventing 10G modes from functioning.
> - [Medium] Synthesizing a hardware value by adding 1 to a UAPI bitmask macro is brittle and semantically incorrect.
> --
> 
> commit 797f904fd928c0648fed4442dd4dbb70a939a7f7
> Author: Daniel Thompson <daniel@riscstar.com>
> 
> net: pcs: pcs-xpcs: select operating mode for 10G-baseR capable PCS
> 
> The patch attempts to solve an issue where 10Gbase-R support suppresses modal
> switching for 1000base-X and slower speeds on XPCS. It sets the PCS_TYPE_SEL
> in MDIO_CTRL2 to a reserved value when detecting the relevant PHY interface
> and XPCS feature support.
> 
>> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
>> index e69fa2f0a0e8..b2c84b7e1e11 100644
>> --- a/drivers/net/pcs/pcs-xpcs.c
>> +++ b/drivers/net/pcs/pcs-xpcs.c
>> @@ -747,6 +747,40 @@ static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
>>   	xpcs->need_reset = false;
>>   }
>>   
>> +static int xpcs_config_operating_mode(struct dw_xpcs *xpcs, int an_mode)
>> +{
>> +	int mdio_stat2, ret;
>> +
>> +	switch (an_mode) {
>> +	case DW_AN_C37_SGMII:
>> +	case DW_AN_C37_1000BASEX:
>> +	case DW_2500BASEX:
>> +		mdio_stat2 = xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_STAT2);
>> +		if (mdio_stat2 < 0)
>> +			return mdio_stat2;
>> +
>> +		/*
>> +		 * If this XPCS supports 10Gbase-R then it will be the default
>> +		 * which prevents 1000base-X and slower from working correctly.
>> +		 *
>> +		 * Why are we writing MDIO_PCS_CTRL2_TYPE + 1? We want the modal
>> +		 * behaviour that comes when we pick a reserved value. XPCS
>> +		 * allocates extra bits to this field and allocates values from
>> +		 * 15 down so MDIO_PCS_CTRL2_TYPE + 1 is the value likely to
>> +		 * be allocated last (and hopefully never).
>> +		 */
>> +		if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
>> +			ret = xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2,
>> +					 MDIO_PCS_CTRL2_TYPE + 1);
> 
> Is it safe to calculate the reserved value by adding 1 to the bitmask macro
> MDIO_PCS_CTRL2_TYPE?

This is a good observation, and for the reasons pointed out,
it might not be "safe".

The comment above the assignment explains that what's going
on is intentional (to get a behavior that comes from writing
a reserved value), and was done in way that tries to avoid an
eventual problem.

The next version of the code will still do this the same way, but
we would welcome a suggestion for a better way to handle this.

> MDIO_PCS_CTRL2_TYPE is defined in <uapi/linux/mdio.h> as a bitmask (0x0003),
> not a maximum integer value. While this evaluates to 4 today, if the IEEE
> standard expands the PCS type selection field (e.g. to a 4-bit mask 0x000F),
> this expression will evaluate to 16, overflowing the field. Could this use an
> explicit local constant for the targeted proprietary reserved value instead?
> 
> Also, could this cause issues if the interface is dynamically switched back
> to a 10G mode (e.g., DW_10GBASER)?
> 
> If the interface switches from SGMII to DW_10GBASER,
> xpcs_config_operating_mode() hits an empty switch case and does not update
> the register. Because xpcs_switch_interface_mode() only sets
> xpcs->need_reset = true when switching to SGMII, no soft reset is triggered,
> leaving MDIO_CTRL2 stuck at the reserved value 4 and breaking 10GBASE-R
> modal behavior.
> 
>> +			if (ret < 0)
>> +				return ret;
>> +		}
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> 
> [ ... ]
> 
>> @@ -919,6 +953,10 @@ static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
>>   	if (!compat)
>>   		return -ENODEV;
>>   
>> +	ret = xpcs_config_operating_mode(xpcs, compat->an_mode);
> 
> Does this unconditionally overwrite MDIO_CTRL2 and break Wangxun hardware?

The next version of the code reworks how this is done.  The code
will preserve the special behavior used for Wanxun hardware, but
will update the operating mode in a way similar to what's done
in the current patch otherwise.

					-Alex

> 
> For Wangxun devices, xpcs_pre_config() calls xpcs_switch_interface_mode(),
> which delegates to txgbe_xpcs_switch_mode(). This explicitly configures
> MDIO_CTRL2 to MDIO_PCS_CTRL2_10GBX (1) for SGMII and 1000BASE-X.
> 
> Later, xpcs_do_config() calls xpcs_config_operating_mode() here. Because
> Wangxun devices support 10GBASE-R, it writes the reserved value 4 to
> MDIO_CTRL2. This clobbers the required Wangxun-specific 10GBX state,
> forcing the hardware into a reserved state and breaking the link.
> 
>> +	if (ret < 0)
>> +		return ret;
>> +
>>   	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
>>   		/* Wangxun devices need backplane CL37 AN enabled for
>>   		 * SGMII and 1000base-X
> 

