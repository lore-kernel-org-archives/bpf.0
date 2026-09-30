Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B924E2F33
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775412; cv=none; b=qk/LtEdMHVu75KwQA5fgi5e+QVjHOpl5rq/cCRFwZ/eZcx+GxS9Q4/2Z+vcqUz5EkJrCfUgR4Y3YjlWfTke/aiPbzuHaMbY9uxQzicCAqSqPYIbxwPwyS/+lb09TgPoBtFc7Akem3o3NkJhrH2HeIGqQCi2wFNnWgCjg/o1dy3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775412; c=relaxed/simple;
	bh=HaaQw8ekFxtZ+l5QVtlpbUxOK8bhqLG8/7s9pMLLvUw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gh8LLe5+nvPNpoh+gzxkwkDkPVc7WpeAeZVFDw3HSBGGRJco+hJRQycdf4/2WQzKAz8LLOqC6mmN6akEv5FTS6oZXhbOdyka9KuvKM67hEdDORJWJ62St56NfTHxcYt1xWBGh2bpR+s0a80DDKucuavIlzvO3RLtl395qm1A8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UhdQRXB2; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhdQRXB2"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3d90ac37so752553e87.3
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790775404; x=1791380204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SCp+zU3LM4gM5+pkGXM0JBbm8ITifADics/CSBcjDU=;
        b=UhdQRXB2MQIjTSH8mSIB9Q6a/5l5+c83BNcZr+3dM+8KZ+bhUYqob/azloYP5bjoiN
         6meoHtKvKeBLZMMsUkyLTLu0DzxUjlDdjjjbTb0KMfgWEa/1DFLynmMkoT5rRmmKpyxP
         +9oELCwBC22uuIFEWCA6o2Wbzo3kwWr1gD8kScgiUIGcqMOYS4PRK8ZT2nTjPwrpkOyq
         cHo36AxQCYnEMXf1TxPJv89zuesmBDgr0WlQvDvo+BdE6HZSGknc2s04BPmWUTThkAOw
         gJ+n05DUkbygyAmEBi5O8JLgo8mpEfgE25KhQ7KiPXwL1c0NAheYqyoJLbrGgu6CfQNx
         tNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790775404; x=1791380204;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5SCp+zU3LM4gM5+pkGXM0JBbm8ITifADics/CSBcjDU=;
        b=Y9Djfz6EzmRIhEASoHiWijGyn16uLiMDHXfZGYv0FPKZbKRT16xOi0sMNIC9H2k5Fk
         GteaDpYE9cF0bn7QcE4fQwWwMGNux0Jylht5p4r6Y2ja9rexkts6W1YFR6fNOBMNZZCs
         PfoL8YO+iHBx7RGk4NCECgG2fKkLyjmLg+yKcYiy/VmlAw93ut8B6vRYHnnwmY/0F+yI
         2SrzHid6tmkmsaVTSz/3rrU6A3c2ndTAfHhCI9AEf07M7Bf2794FWEbfipRKM+1PnIf5
         oovcxVfncDQDdCT5XhEsdvXVGYsSVZOOiS6YduEZHo/wzVA4VOnLvNzT0Dh8UnP9nGDM
         hjzQ==
X-Forwarded-Encrypted: i=1; AKwUvBy62bM9PY08HDyyy2sCYVDTcr/LEzjGj2uHO8Et2Rwg2i3igDvODXZYaUJnUg8DtYe8rkY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMXzXs/6s/nWPy0VUr50ZEXJY5AnZpscPj7zijNPrHCLiGHRBt
	6SATyqplWKLv2xC5hOCd1OW6+CrPamt/ZrRLo1iTcx/efmDdcs8DEKZkKYe3G0oEqdY=
X-Gm-Gg: AYBFou0FBRcbRAIdFLg6orB03sdQiP66W36atWOh3f3081fKK/SAkGu/90yH594cVf+
	qdfSJijLfTSBO+h3nyiq+evlusQ2mcovTkrxcTzc85ZRTq2SduOCmHV6Li76CtDPg3xza6p3tA3
	jrAWakFhZ1wX2FIV3s6W07CmV2Clkrnuhd8p/BJytneAq/0aZYWilHErhZ86xt9LBbOj5vNA1ns
	I9kRp4CBhCylsxptnNfpiEx+ocA1tUhELUQvhIiqoisenXoImISeHbK1hvri2zsWBRrlnEXC5NQ
	E8EzYjtN6bHqcS1EkBwBuGfaVfE1n91HdX5ItHjV20QYSUrsMu1I3+IRUQ7sBqdvlOJKCGPq/rq
	mKc0l3IfRH054+2DVa+S9cE7d2VS9ZgdPpSXW9fzrsMVkrq0gp2Ub11e00o/t+F+vqB9aLhX1JM
	zkYi9ARhmIth2cHIFFXPnpB+W8G+gdLazIk8Rm5/TzwYGKEbZbog/o/ImcDgfi0juUB+deqcj3B
	+eX1QCjSNvOKBGjnCAMaEJAdZ6y0MhHfMR93S5svgOInKOlPxuMl5C0+TWmoLJSG5vZO60Z72jt
	hYNGf8Q=
X-Received: by 2002:a05:6512:39c6:b0:5ba:3f76:aca9 with SMTP id 2adb3069b0e04-5ba403e962emr726819e87.17.1790775403507;
        Wed, 30 Sep 2026 06:36:43 -0700 (PDT)
Received: from [10.21.51.184] (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca. [142.127.77.63])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba3fc023c5sm360682e87.68.2026.09.30.06.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 06:36:42 -0700 (PDT)
Message-ID: <fb7ed8ab-8aea-4731-a5e5-c9476d8bfd38@linaro.org>
Date: Wed, 30 Sep 2026 15:36:36 +0200
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
Cc: Benjamin Tissoires <bentiss@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
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
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org> <arrAqg5n87INTHE6@beelink>
 <674314b4-6b80-4b3a-ac15-eefd31cea607@linaro.org> <artpBMeM13Dd0lLy@houat>
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
In-Reply-To: <artpBMeM13Dd0lLy@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/26 09:41, Maxime Ripard wrote:
> On Mon, Sep 28, 2026 at 10:36:18PM +0200, Neil Armstrong wrote:
>> On 9/28/26 21:48, Benjamin Tissoires wrote:
>>> On Sep 28 2026, Neil Armstrong wrote:
>>>> On 9/28/26 19:24, Benjamin Tissoires wrote:
>>>>> On Sep 28 2026, Neil Armstrong wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 9/28/26 18:22, Maxime Ripard wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Panels in general, and MIPI-DSI panels in particular, are pretty
>>>>>>> difficult to support and require pretty much a panel driver for each
>>>>>>> panel produced. Most of them are pretty simple, and require an opaque
>>>>>>> initialization sequence that is usually poorly documented.
>>>>>>>
>>>>>>> This creates a tension between OEMs and distros because OEMs will
>>>>>>> typically get a new panel to react to a sourcing issue during
>>>>>>> production, and thus need some swift turnaround between getting their
>>>>>>> new panel and it being operational in the OS. Distributions on the other
>>>>>>> hand can take years to ship a kernel with that new panel driver.
>>>>>>>
>>>>>>> To solve this, I followed the example of HID-BPF and wrote a panel
>>>>>>> driver that will rely on BPF programs to perform the panel
>>>>>>> initialization. That way, we can ship the programs separately from the
>>>>>>> kernel, and with a different lifecycle. If this driver is accepted, the
>>>>>>> plan is to have a userspace component started by udev to identify and
>>>>>>> load the right BPF program for the panels found on the device.
>>>>>>
>>>>>> This is kind of late for serious applications except if we manage to
>>>>>> solve the bootloader to Linux display engine transition.
>>>>>>
>>>>>>>
>>>>>>> This driver is fully functional and works with both 5" and 7" Touch
>>>>>>> Display 2 panels for the RaspberryPi. However, it breaks away from the
>>>>>>> typical panel driver in multiple ways:
>>>>>>>
>>>>>>> - BPF programs can only be loaded by userspace. This leaves us with two
>>>>>>>       choices:
>>>>>>>
>>>>>>>       * We prevent the driver from loading until the script itself is
>>>>>>>         loaded. This has the side effect of preventing any other output to
>>>>>>>         be used until the initramfs is ran at the earliest, and possibly
>>>>>>>         ever if the loader isn't installed for example.
>>>>>>
>>>>>> This adds a dependency on user-space behavior and if somehow the
>>>>>> initramfs doesn't load for a reason we won't have a way to display
>>>>>> an error.
>>>>>>
>>>>>>>
>>>>>>>       * Or we probe the driver all the time, but only report it as connected
>>>>>>>         once a program has been registered. This is somewhat unconventional,
>>>>>>>         but allows the other outputs to be functional, *and* allows the user
>>>>>>>         to force the output if their panel doesn't require any
>>>>>>>         initialization or during debugging. I chose this solution.
>>>>>>
>>>>>> Both options are not really great...
>>>>>>
>>>>>>>
>>>>>>> - It's not a panel driver, but a bridge one, which is also pretty
>>>>>>>       unconventional. This is required because panel drivers don't have
>>>>>>>       access to a detect callback that is required for the above, but I also
>>>>>>>       think that the recent work from Luca blurs the line from panels and
>>>>>>>       bridges and we'll end up going that road anyway.
>>>>>>
>>>>>> On this point, DDIC _are_ bridges, but in the current panel API we blur the line between
>>>>>> the panel and the DDIC. So being a bridge is fine, but in a general way we lack
>>>>>> a proper way to describe the display/panel/monitor independently of the DDIC.
>>>>>>
>>>>>> At first glance it's a nice driver, but moving the timings into a blob moves something
>>>>>> into possible proprietary binaries with possible closed licence and distribution
>>>>>> restriction so it's a downgrade for the same of bringing up a panel faster.
>>>>>
>>>>> Quick answer on this, because I had the very same questions regarding
>>>>> HID-BPF:
>>>>> - in BPF, you can require (and by default it does) that only GPL
>>>>> 	compatible BPF programs are loaded, closing the argument of "closed
>>>>> 	licence and distribution restriction"
>>>>> - also, a BPF program can be disassembled much easier than a binary
>>>>> 	blob, and I remember Alexei showing me an example where you get almost
>>>>> 	the source code from the BPF object in just one pass.
>>>>
>>>> Right, it "solve" one of my question, but doesn't really solve the issue
>>>> of vendors providing "GPL" bpf programs with source available "somewhere".
>>>>
>>>> Another big issue is the API, I don't want to keep the current API as-is,
>>>> we plan to support more advanced panel features and use try to use the
>>>> atomic states to support rate switching for example, and I'm not confident
>>>> it's a good idea since there's no "simple" and "forever valid" API
>>>> to initialize panels...
>>>>
>>>
>>> That's exactly where BPF shines. The simple rule of thumb is: there is
>>> no API stability guaranteed. Basically, thanks to the verifier and CORE
>>> (Compile Once Run Everywhere), you don't need to keep the API stable and
>>> available forever. There are multiple ways of dealing with it, but the
>>> gist is that if a BPF is trying to load an "old" API, it will be
>>> rejected by the verifier.
>>>
>>> Then it's a matter of being nice enough in the kernel and provide ways
>>> to deal with those.
>>>
>>> To give you a few examples:
>>>
>>> - in HID-BPF, in userspace, we keep old versions of APIs in separate
>>> 	compiled objects. Each is incremented (by 10 so we have a little bit
>>> 	of room in the middle). Then the loader tries first
>>> 	0020-device-with-new-api.bpf.o, and if it fails, it tries
>>> 	0010-device-with-old-api.bpf.o
>>>
>>> 	I'm not saying we should do the same here, but that's one idea
>>>
>>> - recently, a BPF commit broke the ABI of a function while removing
>>> 	implicits: bpf_wq_set_callback_impl() was replaced by
>>> 	bpf_wq_set_callback() with a different number of arguments. I simply
>>> 	had to add a new function in my header which basically does:
>>>
>>> 	static inline int
>>> 	hid_bpf_wq_set_callback(struct bpf_wq *wq,
>>> 	                        int (*callback_fn)(void *, int *, void *),
>>> 	                        unsigned int flags)
>>> 	{
>>>         if (bpf_ksym_exists(bpf_wq_set_callback))
>>>                 return bpf_wq_set_callback(wq, callback_fn, flags);
>>>         if (bpf_ksym_exists(bpf_wq_set_callback_impl))
>>>                 return bpf_wq_set_callback_impl(wq, callback_fn, flags, NULL);
>>>     }
>>>
>>>     And then I changed the bpf.c to use hid_bpf_wq_set_callback() and the
>>>     bpf is compatible with both APIs
>>>
>>> - with CORE, struct fields are relocated on the fly when you load the BPF
>>>     So for instance, if my BPF only accesses fields .name, .phys and .id
>>>     in the BPF, I can define:
>>>     struct hid_device {
>>>       char                       name[128];
>>>       char                       phys[64];
>>>       unsigned int               id;
>>>     }
>>>
>>>     Then when loading the bpf, the verifier replaces all offset to the
>>>     ones actually used by the running kernel, and the program loads
>>>     transparently, even if you add fields before/after or change the
>>>     fields order in the kernel.
>>>
>>> Changing the mindset is the hardest part of it. But once you are making
>>> the shift, it's actually much better to work with. It doesn't mean you
>>> can go yolo. You still need to be careful in your choices knowing the
>>> impact on your users. But the API at version 0 is not frozen and you
>>> don't need to maintain it forever, especially if you control the loader
>>> and the headers used to compile the BPFs.
>>
>> It's really impressive, but there's no way this would become the de-facto
>> way to program the panels
> 
> Nobody said it would? And like I said in my previous mail, I actually
> expect us to keep merging panel drivers. Do I think it should become the
> go-to solution for simple panels? yes. But we can always make
> exceptions, and for more complex panels we should totally do a more
> complex driver. Like HID has been doing.
> 
>> and if the motivation is to make it simpler this implementation
>> requires adding bindings and bpf programs which that are the same as
>> native panel drivers, but won't be able to work until user-space
>> starts and will require to be in initramfs or rootfs to have
>> functional display.
>>
>> Not sure to understand what are the positive features here except
>> isolating the panel code in a safe bpf program (is this really needed
>> ?).
> 
>  From the cover letter:
> 
> """
> Panels in general, and MIPI-DSI panels in particular, are pretty
> difficult to support and require pretty much a panel driver for each
> panel produced. Most of them are pretty simple, and require an opaque
> initialization sequence that is usually poorly documented.
> 
> This creates a tension between OEMs and distros because OEMs will
> typically get a new panel to react to a sourcing issue during
> production, and thus need some swift turnaround between getting their
> new panel and it being operational in the OS. Distributions on the other
> hand can take years to ship a kernel with that new panel driver.
> 
> To solve this, I followed the example of HID-BPF and wrote a panel
> driver that will rely on BPF programs to perform the panel
> initialization. That way, we can ship the programs separately from the
> kernel, and with a different lifecycle.
> """
> 
> You can disagree with the solution, that's fair, we can also discuss on
> how to solve this problem, but I'd appreciate it if you weren't claiming
> it's all useless.

I did read the cover-letter and I got the arguments from Benjamin, and
while in theory it could indeed solve the issue described, in reality
it won't for the reasons I exposed.

And since it's basically allowing to accept out-of-tree downstream
driver instead of upstreaming, I'm kind against TBH.

But I'm open to discussion, and I'll talk about display Panel in
XDC today, Plumbers and ELC next week so I hope we'll find time to
discuss about this in person!

Neil

> 
> Maxime

