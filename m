Return-Path: <SRS0=zGgN=4G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC88C34022
	for <bpf@archiver.kernel.org>; Tue, 18 Feb 2020 03:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E4C20836
	for <bpf@archiver.kernel.org>; Tue, 18 Feb 2020 03:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQVf50QM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgBRDMr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:12:47 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44524 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgBRDMr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Feb 2020 22:12:47 -0500
Received: by mail-qv1-f67.google.com with SMTP id n8so8498041qvg.11;
        Mon, 17 Feb 2020 19:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6kcPaoQ/OOo2zZ+VvgC+FS69kL9fFamWWFF1feFv6AY=;
        b=YQVf50QMALLBCsGVQxOe/bNEjOhO4zpztJ/1dR4s4CznMTIRkckfOUBAWw02uLxq8K
         K7wbLEojPW9mSRQvvoSFIFWWRady3MAI6Sj5x83+NWXwh5wdWXHjuV95GBWO7oVaHTiK
         ppPTtottqVzVNnSXlGvXWgWAiGsubbi9DQaCKRwHwFHAfob7B0WEgPqqjS6SW0K9v8aQ
         cvEl7x9xf3iHvwwvFAl/2fvAMvcV6Vu0GFc7zPgq+A7VwJgrmJ2WzU+/vY5Hom6nyucn
         t+6+R14h1TjDn4il8szxIRBzI36aOMl8fEFrwyIhbIDRYQjJ1yz1GY61jo/Q5wgflRBY
         06UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6kcPaoQ/OOo2zZ+VvgC+FS69kL9fFamWWFF1feFv6AY=;
        b=p5jXNgUuPfsoDy1qrxUcvm9WJfBZBs1EkSPbZ5Y7YuZut1Dpbq409XL7wmzVeRq9gu
         vGBCgVjvYZ/UG3vgB63Wonl9xcQSXNlaW+qwuVPpYwQnTGP4R9tOSAyYB6YCZe6KReCC
         Ae28ev4NpQ44C9h12O0CSKAQVRhnUc35/I8jjyT5FfeiAaj4ujo2t/0MOyezUOkcgf9w
         Lxa+IqIAlNT/uv01arKYeJEwP3W9L9BlqcGHDr4mtnarUlrSsl8cC6c55oIcM+D1A9Um
         SpXGBcvSz7xpzjgQs+jJgT3Yiwq75Ch57sejRZ0q4gvT2KHMfgudUZ2yDrEGCLv82R97
         X2Mg==
X-Gm-Message-State: APjAAAV2DEZZ2LmFMz4dE8braKCho9UoyswYRfmumQksIc6qBFXjqTec
        Tmx99gLMSiLs3z6C1fweBBWC21mo
X-Google-Smtp-Source: APXvYqy71nUt7r8mVrAQJ93AZyW4VmWU1gK0wUS6l0FXTh3leEzTR+wGuZLYpDs2Y+lyh7HASHkIpw==
X-Received: by 2002:a0c:ab13:: with SMTP id h19mr14895264qvb.243.1581995565922;
        Mon, 17 Feb 2020 19:12:45 -0800 (PST)
Received: from ?IPv6:2601:282:803:7700:5af:31c:27bd:ccb5? ([2601:282:803:7700:5af:31c:27bd:ccb5])
        by smtp.googlemail.com with ESMTPSA id v10sm1241008qtj.26.2020.02.17.19.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 19:12:45 -0800 (PST)
Subject: Re: [RFC net-next] net: mvneta: align xdp stats naming scheme to mlx5
 driver
To:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc:     ilias.apalodimas@linaro.org, davem@davemloft.net,
        lorenzo.bianconi@redhat.com, andrew@lunn.ch, brouer@redhat.com,
        dsahern@kernel.org, bpf@vger.kernel.org
References: <526238d9bcc60500ed61da1a4af8b65af1af9583.1581984697.git.lorenzo@kernel.org>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <70db0e12-22df-e612-b885-bce926bbaf5f@gmail.com>
Date:   Mon, 17 Feb 2020 20:12:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <526238d9bcc60500ed61da1a4af8b65af1af9583.1581984697.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/17/20 5:14 PM, Lorenzo Bianconi wrote:
> @@ -399,10 +400,11 @@ static const struct mvneta_statistic mvneta_statistics[] = {
>  	{ ETHTOOL_STAT_EEE_WAKEUP, T_SW, "eee_wakeup_errors", },
>  	{ ETHTOOL_STAT_SKB_ALLOC_ERR, T_SW, "skb_alloc_errors", },
>  	{ ETHTOOL_STAT_REFILL_ERR, T_SW, "refill_errors", },
> -	{ ETHTOOL_XDP_REDIRECT, T_SW, "xdp_redirect", },
> -	{ ETHTOOL_XDP_PASS, T_SW, "xdp_pass", },
> -	{ ETHTOOL_XDP_DROP, T_SW, "xdp_drop", },
> -	{ ETHTOOL_XDP_TX, T_SW, "xdp_tx", },
> +	{ ETHTOOL_XDP_REDIRECT, T_SW, "rx_xdp_redirect", },
> +	{ ETHTOOL_XDP_PASS, T_SW, "rx_xdp_pass", },
> +	{ ETHTOOL_XDP_DROP, T_SW, "rx_xdp_drop", },
> +	{ ETHTOOL_XDP_TX, T_SW, "rx_xdp_tx_xmit", },
> +	{ ETHTOOL_XDP_XMIT, T_SW, "tx_xdp_xmit", },
>  };
>  

LGTM

Acked-by: David Ahern <dsahern@gmail.com>
