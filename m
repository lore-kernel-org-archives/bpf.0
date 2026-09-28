Received: from mail-ua2-f30.google.com (mail-ua2-f30.google.com [74.125.226.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F074EB876
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623218; cv=none; b=EMetFzPF7Q+eW5zbKbroxyFotDzF0r7seUsmN5/+QhXpLUDwpvLn5tO6lpZbej2MdA5jB4MZ96wvcbMiHnD5F4geR4feZXaKPUuFusWdV2v/FCSJuDg6Q3Sq8yFu5Sx0W6JraSy1F6YAzxHKLiDz493Gb91wYj6RFnkNHIDPabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623218; c=relaxed/simple;
	bh=+IdK2muCFRO0CVjwWieNJcwFsMXfEeJbRjc+FinzqwI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SpK4/XHz20sqWYEkbz8GiQ8cneVhwGCNSJze2PcUTj4RhBt/axXpSuk65nrzXvc3Nmm+gmHw/2qd6EwB4g/5ZxyF5ny0p+nWjPp0oMxFB2Ar/yYWXNSk7wrBXUhof48dNHjK64JA4gJDovyiog4LAxWCvcW67k23MAJp3/8YHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q0PsxeLF; arc=none smtp.client-ip=74.125.226.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0PsxeLF"
Received: by mail-ua2-f30.google.com with SMTP id a1e0cc1a2514c-97e7c7b4ed1so2018513241.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790623215; x=1791228015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3EOtyWnpj6H2JKh2l6IAWizW9Kgj+njv8aMgbCxIvr4=;
        b=q0PsxeLFzwdunkwC4eSX0d+C8Pa5wgTuqRwjkZJezaOmGXMuXtaKdThAgnE3yaIi6l
         kH3CT/GUozRF4oxBmTQvBqJXDHlomOXBQKIOqCUI5MxQspH8kTQc5zSEX2JS4S19cWzO
         b2oDrOTkLmhtYN25GiuzVEBbpbrUWB7tFi2xSHB85InaYm27YQMEaWb8fqaTIBa6fzBT
         NJNd3nvqKIWQtV1o8x7/2b26PncmtElk0rtaNgyUz/nqsrqGRwppCGWmBQtsZB9m2atP
         SW1bmzaP8mxnWhCoWX/Motn3jhiQrTFgpIktM4ClBAYtgp4Y3UYtPs/D+5SU4ZGJ4HHq
         mgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790623215; x=1791228015;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3EOtyWnpj6H2JKh2l6IAWizW9Kgj+njv8aMgbCxIvr4=;
        b=yGRz8Y0ER0aQe24cm3DQ6Lf3sKWEKionAZqRWEZDNaF4I+fAj0xHTAGT4feILlcxGV
         OyIFijCUPFc95MfCXnYK/rVNnMFLEOAm5xf7HstWxgxswNOr+JGmcWMuCbg2zUohjeW7
         8RMg6sz035POeMozDwKQ1l58pTvNOjHhx/+jBzvnwdvuda66/O2OltTYC5voIR8lEYBJ
         /UIlUJ0/KTvobGVhks1X/99N7hED8dv2lU50/H+wdFpDZ8/GvvJsLv9JElE7JvdWLZfW
         Wq0nbJGhaKLvZOQcR5nbD0tOvfuSTiVRLDgGw+L9q3uyM8YzRS/QrhcYwqoCqDX0ui3d
         WZ5g==
X-Forwarded-Encrypted: i=1; AKwUvBwi1oSu+8qJzF0Fze3f0KOZEOWaca2OMq1AkobaQ7PWGmHV3V3xsyrkSbXxAZWgZoUpYPw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFUQmYlBhqvRtsYWgj9gr4lcMl55FHAm9o8QcRgdyZpRH5LTb+
	3GNskSPhgs3uVKn17pFLp5qS0cxgJVXO/zI2+1ldjglS7MwnE+DyzLP76YqSt14GNvg=
X-Gm-Gg: AYBFou0i1/tDL0lrphTioF1cMyd/yNy6+/BT/wWorfZw6zXCdFFzMZpr/nVAZJmvSDs
	egF1C958eLQDfGUtp+h6wJI9txstdZY5guCyIhkSx5b+A8vxjXN1HEmeacsQb8MN+Nl1xvf/bDn
	jY/5cuuQiJdn5t7Hhl8QQM9UgNqq9SgxZ7FsIOkF7Ai7R3POet6L88OBwM7Ro9OODOO6qkymLSQ
	gz1aVxJz/0CPhi0IWH5YW0TStqJQ/G4MARfrB5nR9+OdTSQSToJRORwr4xYnx+QN7udVyOXAHOg
	3aHDBCXqnVQGUaP6CJMeLFU5wSzcZAeUWAQY6JJWtneAAf4snBYkFPOfsL8Pit70D2fT16V5obf
	ULTY24+76DFjj3nl0tfdehJu/sKYlj9KQ7/62YkBgKAN0G+jD/eZxxbYTTHZsBKotO/gkqxq5DH
	5KnyjqPkb6kJdYBZym9+pVbwpu2x5IZFV1g2FxBm80n1UtroAbTDmBKsy+QsopAC+0dPvOiLfkq
	E0gH96UDjsPaGcyxScU6qdOMkZc3nESAR+/xTU7bvEwOZJNzuVB3Zc9UbHYz1P2vxH1wChOldK5
	UX/D2XYEPgaXrviU8g==
X-Received: by 2002:a05:6102:3f8b:b0:7a6:bc69:5a32 with SMTP id ada2fe7eead31-7af1e6f3640mr5363208137.23.1790623214949;
        Mon, 28 Sep 2026 12:20:14 -0700 (PDT)
Received: from [10.21.51.184] (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca. [142.127.77.63])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9889afc5c7csm8124301241.2.2026.09.28.12.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 12:20:14 -0700 (PDT)
Message-ID: <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org>
Date: Mon, 28 Sep 2026 21:20:12 +0200
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
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
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
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org> <arqhwHiVf00j94J7@beelink>
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
In-Reply-To: <arqhwHiVf00j94J7@beelink>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 19:24, Benjamin Tissoires wrote:
> On Sep 28 2026, Neil Armstrong wrote:
>> Hi,
>>
>> On 9/28/26 18:22, Maxime Ripard wrote:
>>> Hi,
>>>
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
>>
>>>
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
>>
>>>
>>>     * Or we probe the driver all the time, but only report it as connected
>>>       once a program has been registered. This is somewhat unconventional,
>>>       but allows the other outputs to be functional, *and* allows the user
>>>       to force the output if their panel doesn't require any
>>>       initialization or during debugging. I chose this solution.
>>
>> Both options are not really great...
>>
>>>
>>> - It's not a panel driver, but a bridge one, which is also pretty
>>>     unconventional. This is required because panel drivers don't have
>>>     access to a detect callback that is required for the above, but I also
>>>     think that the recent work from Luca blurs the line from panels and
>>>     bridges and we'll end up going that road anyway.
>>
>> On this point, DDIC _are_ bridges, but in the current panel API we blur the line between
>> the panel and the DDIC. So being a bridge is fine, but in a general way we lack
>> a proper way to describe the display/panel/monitor independently of the DDIC.
>>
>> At first glance it's a nice driver, but moving the timings into a blob moves something
>> into possible proprietary binaries with possible closed licence and distribution
>> restriction so it's a downgrade for the same of bringing up a panel faster.
> 
> Quick answer on this, because I had the very same questions regarding
> HID-BPF:
> - in BPF, you can require (and by default it does) that only GPL
> 	compatible BPF programs are loaded, closing the argument of "closed
> 	licence and distribution restriction"
> - also, a BPF program can be disassembled much easier than a binary
> 	blob, and I remember Alexei showing me an example where you get almost
> 	the source code from the BPF object in just one pass.

Right, it "solve" one of my question, but doesn't really solve the issue
of vendors providing "GPL" bpf programs with source available "somewhere".

Another big issue is the API, I don't want to keep the current API as-is,
we plan to support more advanced panel features and use try to use the
atomic states to support rate switching for example, and I'm not confident
it's a good idea since there's no "simple" and "forever valid" API
to initialize panels...

Neil

> 
> Cheers,
> Benjamin

