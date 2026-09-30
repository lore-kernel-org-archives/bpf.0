Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505D4DEC31
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776937; cv=none; b=B0JZco7f/6eSJwHVIjKg/YHHbM2DceHllb+75kJHW96uVZyYYOijBXuQ4GXD3PFRvvwQFMF6wAgVb5bjeONRjT31J9uPrSwcmr4hX/iBLp8OHN/QX+R1EUsweOpCS2bDQRmtypI9uYwtxE5XbEFsvhkrPiU5zGiBXJgSm7xrqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776937; c=relaxed/simple;
	bh=1F1V/rD1y614TqPYCfWDNkmVlHzqqdQCMZ9Th+5moL0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LYE1TJoPxQ3uudZeYsfDBE9RVVeVDVaAf04TP1i8c7Pbg2QD6NN0gDI7yBCO8jdXYq4mZNNhhVAc/qqhOeuwDN12XA3q138C0ReZ8NcKGOxgQvFOHIA/8VpHF11KT3Y09v9ozXyi/DO26H4RgXk+j2CLdo0CgKm/aw5VwqqQK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=twEtjkYX; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twEtjkYX"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-670fee39d73so5826641d50.3
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790776921; x=1791381721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qs9QTXyZYNRiUfQ+wZvKCopWk12AffrP+uIc+6uA/NY=;
        b=twEtjkYXug3JBx6a9VqoPJbXVGWrkEe/btz0u9qN+OOUm/cmw+/ufq5ef2mY+n0W8g
         rb2PBghFyAImnAvv+mBWnOexAQi/vDGEcU33O6w54g6iXmvp5rtZcCZyW1Y+5NBLPVyw
         wcsaoho5r9ThEqmSJVQ9cFq8MuBVqENVWAy5LrhtRITkkv6SS9CDys9dWl1dKC6uDsOy
         hcrCVEo69SJK/ghkJMAH49WDTtQ18miaZ0YUJwAuNLJGHayFIbYfg/vuBWkc5eIE3uQU
         MdUON6q3dwLIq/4AoapfNbGYwqDEcAuq2bOEzHMvGYVwllygz7pzOvYRdL02mnCZ52Ok
         5c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790776921; x=1791381721;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qs9QTXyZYNRiUfQ+wZvKCopWk12AffrP+uIc+6uA/NY=;
        b=Fb26dcwyFXC/uCqhM/KzXTwTte7r+eWWpuorWIiHypju6nrdPLVH2NoH4TvftD5MW6
         YnUWaW959p0/Ewut92l/siL1FGB9V2K8SCHi8JrGVAEIylU7vDX9LzmY3Q0kfKkv3P5A
         JDrXzWOtySYuHdPgsgGKt3xlHYPbGt3nyWS0l4JhXmzwLPzjp/W1+ySGypYAO9Y7uzoV
         0DEo3tz012XTGa4MlfF4iiz8hrD2JbKUN7F9XSKQXvUVIDSmdRAVcR2MjUyBCfuh5KK5
         z+oj2Ao4EaUqb5vyOkOzaRZV6yjjj2+HOTOJbqwuFXP5gC5MS5i4CTcBYL2udObkcYsY
         TlRQ==
X-Forwarded-Encrypted: i=1; AKwUvBysSqW0vTW8Kj1lbjCLkEe2UTxmTyMeRjnhJ6UdLCYsa3DXqxJQUAMjuZYBTiD6ZSiloqM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCwuofeZkT/KzNg6gvUbiDqMF81xg8xKCg8434975OOjMewhC+
	xf+ndQUr+CchzeABAcTGASX0fpaHqf1AxUL9sjx+e9ldxMsJO0HEg294dKuUvQclS6Q=
X-Gm-Gg: AYBFou2Cn2LfH5hb5q6e8Z9CfteYacZ6gJAj/T8bUNOs+FPZbKcPK9T7FSpt73cYPMf
	bGBsDHmaPjXmU8INB99CHeRfO7uhcNn62H2G8ArsF8Y40YEjXVwYoPF6N2I3HKUbQBBRudx4Uhc
	k2snoAZlROqmAzCs2633obu2LjQvSrOQoDBCtZCgCs6euEtwyWwGX6UZ3NK3wy5Q6TEdufSdKwz
	HgJJlebo45V2wWx1DsNUkcywHmwxdcSzlqSq/oZhDWqzjwgtTnWZIg7y+y1Af/dJU8hR8PCpmQc
	aNVOiO6HfrAppelYmgqwV6nMvfpoUiRKWKt3qN9Oyq1IrP2PAK5m/4xEDDVyk0O5dzDic3XutN4
	TBUAtYgYJL9ycQh7iwCOK+G2OEaU3YubomxdO9IjNW0egwBN61v/IBclD0RQ423ZnRSziCn8mkt
	yC/Nac1vDq3//pMiDtIkXDCtaQSibZDppiqul2k1Xcm0fuGubpSPM778PBOILErfqx0+FI/B7sD
	RHFECc8N4yl6macOxcgNhyApR++S0aBzZVUqiI5NT+y5hBcA73VsuwHdz8AJA55UERXoNj70DUU
	G+4VYF7Hzh+MzQTTnA==
X-Received: by 2002:a05:690e:484d:b0:66f:c238:7657 with SMTP id 956f58d0204a3-67683530372mr445880d50.76.1790776917625;
        Wed, 30 Sep 2026 07:01:57 -0700 (PDT)
Received: from [10.21.51.184] (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca. [142.127.77.63])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67680ac3521sm764290d50.1.2026.09.30.07.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 07:01:56 -0700 (PDT)
Message-ID: <6c581ae0-2480-47a2-b46e-97afadbc7c1f@linaro.org>
Date: Wed, 30 Sep 2026 16:01:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve
 <aesteve@redhat.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Benjamin Tissoires <bentiss@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <054ef52478fc93fc213a9dae23ea77f73094aaf2@intel.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <054ef52478fc93fc213a9dae23ea77f73094aaf2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/26 11:03, Jani Nikula wrote:
> On Mon, 28 Sep 2026, Maxime Ripard <mripard@kernel.org> wrote:
>> Panels in general, and MIPI-DSI panels in particular, are pretty
>> difficult to support and require pretty much a panel driver for each
>> panel produced. Most of them are pretty simple, and require an opaque
>> initialization sequence that is usually poorly documented.
>>
>> This creates a tension between OEMs and distros because OEMs will
>> typically get a new panel to react to a sourcing issue during
>> production, and thus need some swift turnaround between getting their
>> new panel and it being operational in the OS. Distributions on the other
>> hand can take years to ship a kernel with that new panel driver.
>>
>> To solve this, I followed the example of HID-BPF and wrote a panel
>> driver that will rely on BPF programs to perform the panel
>> initialization. That way, we can ship the programs separately from the
>> kernel, and with a different lifecycle. If this driver is accepted, the
>> plan is to have a userspace component started by udev to identify and
>> load the right BPF program for the panels found on the device.
> 
> I'd think for most panels it would suffice to have a declarative
> language describing what to do at what points in time. For example, at
> poweron, enable this GPIO, wait a little, write this set of DSI
> commands, etc. You rarely need actual programming, or even ability to
> read-modify-write something.

Yes we could have a similar panel-simple but with init tables, but
in reality those panels offers much more features we don't handle because
the DDIC vendors and panel integrators just don't care exposing those
features, but they get handled by vendor implementation like for Phones.

> 
> It could be, say, YAML converted to some binary representation. Maybe
> that could be in the DT, or maybe you could override it with the
> firmware loader. And obviously any vendor "blob" could be trivially
> converted back to YAML and upstreamed.

I don't think we want this, downstream vendors does that and we don't want
to go there.

> 
> Where that falls short, you could always have a dedicated driver, or
> extend the declarative stuff.
> 
> Now, the question is, how much more BPF solves over that, without
> requiring a dedicated driver, and is the added complexity worth it?

This is my global question, and this is what I'm evaluating here, and so
far is created more problem that solutions.

> 
> FWIW, on the Intel platforms that support DSI, all of the
> initialization, poweron/poweroff, backlight on/off etc. sequences like
> that are stored in the BIOS, defined by the OEM. A plethora of DSI
> panels, one driver. Don't look at it for examples how to implement it,
> but I think the basic idea is workable.

For _some_ panels, here, as a general solution no because we really
want to have full support for panel features.

Neil

> 
> 
> BR,
> Jani.
> 
> 

