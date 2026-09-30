Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740864ED1A1
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775989; cv=none; b=df/4+5USxTqPxx/sJdv26bap8+0mXI2Ge8+FVR3p4F7Zk6Rvn9YJ6P7ul6Cv4LCauJ9IZBc1bZdDBJ++l7sLSVhXIWBFZO7ryGikt7+hKSyQypofEj2u/VkdprdhHGLfx0Qb0C4nHLlvgBx90dB2ASlaNPj72usCyqm5H56FStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775989; c=relaxed/simple;
	bh=7Nh6EI3LZQzPWseqkE8KELp9TSy2sy0wDOC/Rv8pmcU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AasUW1xSB/pNAc7f6bli0u9hf/8e/ey5ZOsm/QjL88xhj5LJRioI/hQYG/Td3e4e/YOSIySI+Hj1yZC7lM88JCL8syS6/r0wlSjWP76h/PA6rYXDrgKFtajlG8x8qzFp1SRLpcLyP01ZARDqo6kODNtlxczeiYBnM9tieZW1VTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xcxcl+U5; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xcxcl+U5"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488811c9ebaso2739253f8f.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790775972; x=1791380772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CHcqKszk+BLOaoNOEO2+3FAWySZdw8cPx3mMZwkgNqk=;
        b=Xcxcl+U5qcQRd2VbgTjtIVucE+ieNBGFJZ9WdLE9FW7ei8D0EbEtjYvw84vATDRq9f
         97luY2pQNaAAWWtrpNAAPXOWwbMszSpp1qjjd/dux8YnBEVDzjzQY7KOy/HyVfuVdIdx
         qUgb1+ARuM0k2IvbTKc79HYY1v2OedsYiOxqxEPVJC2U0eQF95hDfdGU/s2Js38E5yTN
         58CDuo2uLDfvL1KbOj8kFUCFHaToum1c6ZouxpoW/Jne3/n9pxaNu8kVBZ060WDR5BUf
         oXmr8vWIT0amR9kxBDNzoacOPGgwn0jee+vxn6k7Y+4DsrXKXTMoIoGKEEvUnl1FOkiT
         xRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790775972; x=1791380772;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CHcqKszk+BLOaoNOEO2+3FAWySZdw8cPx3mMZwkgNqk=;
        b=iHfHAy4FGH5UkEDht7Rn48Js1WGNrS6BIcPdNxwb97p5fE2+KzCA2XuObwtKstcgCd
         yXsHJCFJnct9Tc6er+1lRrhkO5EVLt9Giy1a8vYP6fPrgKo+WyiE+9PSlzsQCuV/Q60Q
         41RZSr+jKTdVDGwegRsWW6evDeBPvVd5rDOuwzBi47aHxSwYzvFFb95hecfBrGjr1Q5r
         mxmgC//nCTuFolTP9lMAYBE2CGXmxNWoJk+khpQJDrJBxxg7v/8xaN1TgYAtnLAk958A
         S1J4n3dJUCjW9bDKBrQhwA7xqZNC8KMGgKoZbqk0JYyMGgjdEoAl3en4PTaamt2ZjWUf
         2DJw==
X-Forwarded-Encrypted: i=1; AKwUvBxtmr1QeAg3PsOpPChZXp8XOPiYfB78Y70yRxMFDw6mO8VuojII2mqhr4811jDP80U84Uk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9RWKNzelAGf1UJiWgtfll4KOiDF/MQ/TQWvCCyrJSMAoRWvKF
	F7mcCrPM3IW/hjiSiKdMMcOMiXzoiS/ITwbCFvG5mfOyVyBl5KJlzZQS4tp+H2ecwjA=
X-Gm-Gg: AYBFou3bvY6Vz9WvUC8+AuL1kHHooVzPFUsnjqdCbFCfBLPxzl5qdutCwRHUnR43uhJ
	oFHhG71JTPhXOAquOdU9pwEtzTZZivR2F77uTOjMiXGdP3dlM8ewT0PyRr9WlMsBT4ExiCTDH2l
	evs8oqcvIyCkGOwTC/GumsHFB1XBoYz82elweppGgd4BDJvx15dlqjoF7BPRt614t2ZeLdSR8SO
	QcQdquK8QdHllBUff5bGY/3eBlOMiIANawVTH+LU7Kidjha6mFCrgMXZGD5Bx9LFsNaaFjiqV8Z
	MgraUyoo401ozlK/dK0brF6Shi58cOXjjrRlPRmUSlNegs7sQhldp8wtIleO0gNt8j4id5zHvuR
	meVZ+/ofSIK80uC5DFE38YtE5bM9E5bCRTUtgEW2HfQNuCoHShJuZuAOLba1nvdfypTHGD3OSwv
	wTIIMTu26EJBCVzh4psJzy8BKdjWCbqqgRaKbse+dJVSVsF9mI3Zn/pVkURN38ORAfwXje+cJ9N
	jY/5MNyrSq7mtG6DtANs+KyOFS20ktDt/Sn8WNLq/Clp917S6mXMEg5oxN5tOR4jh4B+YhaNuHa
	Ilue1cA=
X-Received: by 2002:a5d:5f81:0:b0:488:84e2:cb0b with SMTP id ffacd0b85a97d-48b02549be8mr3355158f8f.51.1790775971655;
        Wed, 30 Sep 2026 06:46:11 -0700 (PDT)
Received: from [10.21.51.184] (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca. [142.127.77.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b029e51b8sm3780276f8f.20.2026.09.30.06.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 06:46:10 -0700 (PDT)
Message-ID: <c75feb5d-055d-403a-8dba-3c187cdb8e7d@linaro.org>
Date: Wed, 30 Sep 2026 15:46:04 +0200
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
To: Maxime Ripard <mripard@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
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
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org> <artgrTe6wvKxnUOG@houat>
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
In-Reply-To: <artgrTe6wvKxnUOG@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/26 09:13, Maxime Ripard wrote:
> Hi Neil,
> 
> On Mon, Sep 28, 2026 at 06:39:58PM +0200, Neil Armstrong wrote:
>> On 9/28/26 18:22, Maxime Ripard wrote:
>>> Panels in general, and MIPI-DSI panels in particular, are pretty
>>> difficult to support and require pretty much a panel driver for each
>>> panel produced. Most of them are pretty simple, and require an opaque
>>> initialization sequence that is usually poorly documented.
>>>
>>> This creates a tension between OEMs and distros because OEMs will
>>> typically get a new panel to react to a sourcing issue during
>>> production, and thus need some swift turnaround between getting their
>>> new panel and it being operational in the OS. Distributions on the other
>>> hand can take years to ship a kernel with that new panel driver.
>>>
>>> To solve this, I followed the example of HID-BPF and wrote a panel
>>> driver that will rely on BPF programs to perform the panel
>>> initialization. That way, we can ship the programs separately from the
>>> kernel, and with a different lifecycle. If this driver is accepted, the
>>> plan is to have a userspace component started by udev to identify and
>>> load the right BPF program for the panels found on the device.
>>
>> This is kind of late for serious applications except if we manage to
>> solve the bootloader to Linux display engine transition.
> 
> Virtually all "generic" distributions are shipping the panel as modules
> today anyway, because anything else is nothing but impractical. But
> maybe you don't consider them serious enough. Also, applications live in
> userspace already, so can be ran after this driver would be initialized
> anyway.

So what would this exactly solve ? keeping out-of-tree BPF driver + bindings
driver forever and never upstreaming then ? Is this what we really want ?

> 
>>> This driver is fully functional and works with both 5" and 7" Touch
>>> Display 2 panels for the RaspberryPi. However, it breaks away from the
>>> typical panel driver in multiple ways:
>>>
>>> - BPF programs can only be loaded by userspace. This leaves us with two
>>>     choices:
>>>
>>>     * We prevent the driver from loading until the script itself is
>>>       loaded. This has the side effect of preventing any other output to
>>>       be used until the initramfs is ran at the earliest, and possibly
>>>       ever if the loader isn't installed for example.
>>
>> This adds a dependency on user-space behavior and if somehow the
>> initramfs doesn't load for a reason we won't have a way to display
>> an error.
> 
> Yes, if an error happens before the DRM driver loads, it won't be shown
> on the screen. This is already the case for any panel driver today on
> any major !embedded distribution. And with built-in drivers, this can
> also happen before or while the DRM driver loads.
> 
> The solution is always the same though: load simpledrm first, move to
> the proper DRM device once it's functional. It still works with this
> solution.

Module != bpf programs, maybe one day it will change.

> 
>>>
>>>     * Or we probe the driver all the time, but only report it as connected
>>>       once a program has been registered. This is somewhat unconventional,
>>>       but allows the other outputs to be functional, *and* allows the user
>>>       to force the output if their panel doesn't require any
>>>       initialization or during debugging. I chose this solution.
>>
>> Both options are not really great...
> 
> Feel free to make any suggestions
> 
>>>
>>> - It's not a panel driver, but a bridge one, which is also pretty
>>>     unconventional. This is required because panel drivers don't have
>>>     access to a detect callback that is required for the above, but I also
>>>     think that the recent work from Luca blurs the line from panels and
>>>     bridges and we'll end up going that road anyway.
>>
>> On this point, DDIC _are_ bridges,
> 
> I have no idea what a DDIC mean.

The DDIC is the Display Driver Interface Controller, basically the
IC which received DSI packets and physically drives the display.

It's basically a bridge to the panel, and this is mainly what we program.

> 
>> but in the current panel API we blur the line between the panel and
>> the DDIC. So being a bridge is fine, but in a general way we lack a
>> proper way to describe the display/panel/monitor independently of the
>> DDIC.
>>
>> At first glance it's a nice driver, but moving the timings into a blob
> 
> Let's not kid ourselves, it's *already* a blob. We just sugar-coated it
> enough that we can be happy and call it GPL.

It's the case for most drivers, but since we don't get proper
documentation we're stuck using registers list and can't
implement advanced features. And moving this to a bpf won't solve
but enhance the problem by a large factor.

> 
>> moves something into possible proprietary binaries with possible
>> closed licence and distribution restriction so it's a downgrade for
>> the same of bringing up a panel faster.
> 
> We can already make a proprietary, out-of-tree, panel driver today. That
> being said, the only license we allow for BPF programs here is GPL, so
> if anything it would be less of a concern for this than it would be for
> regular panels.

So you're on to facilitate keeping panel driver out-of-tree and never
upstream them ? this is awkward TBH.

> 
> Maxime

