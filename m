Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125ED44163B
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926764; cv=none; b=m98162tHoJukAj7WtArBW8kXSnV7c6iZBA11ReM1Lorur4BTh4KIbfSH3KeGdrjMAVonxDL93TCGnPGVcVFe2dQk0J1Nyb9misSSubWEVLQxJN3Sq7iV8zouAGbVt2AECdhppxzSjpuzmUsH4G8ou/92kT7ntut35tkijyirvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926764; c=relaxed/simple;
	bh=CzmDZ/wH/56FUzFgARFzfpa/0ZupMVwrU7mJXCtI7S0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P6nz8tXZo4OgYm3JJEz+NGXRtlFW5OEQ1EbKTSsATSQk+GJh0wk2q44IsV7tWSwADK1uL1tpUeGCEBOYjMjowDt5cKuHRhAwhsVymgV9pKRJ6qQd2tmcbXBUECH9JhpGGvHcB9pqjBB6Uuh38GEIxPFlb4iL/LN+xHDjKoj0FYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X2xrJSJO; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2xrJSJO"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488811c9ebaso3881609f8f.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 00:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790926760; x=1791531560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HtusxkcwYuaOiThkZo32xth6vfJtdesZfR+wxZipLek=;
        b=X2xrJSJOQwETnrxmoMh3KMFBtJbjl9GglqDYF+kb9DRHSsmlphrA2tTvl9CiDzkNzG
         I9BuER6rTtSaESNtoqAdAhu9vxtJpG6mjEccfUxvQxsKDgOD7YbJRwon5qRqiTssmeYB
         Jzprlu4gNUXnxjmXFTlOxUvde0WwjHe7NpMRuxzmXLMpdaIq8HENFLCQLlbuqdEbpzGo
         9LmGvG85a4pw0D0IAhzn60LTwAMytXyP2EY86h3FtGCfh52vjuXg6r//yuFIJs5hKkoF
         WzVuLHtVANWYbZKRn5SSXhkdHWg6OkQ0CFqHbJgjJt3mCHYx8QyzTE+tcwVXAqlpBU4z
         kuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790926760; x=1791531560;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HtusxkcwYuaOiThkZo32xth6vfJtdesZfR+wxZipLek=;
        b=MAaPbzCHmTTVzWKBzmlQvrWzGkOKTJ0gkV4ynEmmefQhiw/ORvRTthECg2mCUySdOe
         FBXSnrPaECLhFBUIkJRjl4Ew1i71Jrikj60pQgQGkySSa9hjjeeSZNP8VJssI/iwA7NW
         /mMvPkE3aEHeJoQjJQNAlIltaKJBkzxueEJhEB/n1EBB7frmIa+Zg97Pt8ig/+ujIpug
         x0M7TQm2//g8OJbBsiPD89+Zsm6EhbJFofeXVH3EarI7iezWSA4vgxnrdYa+lAf41S/b
         rcDivunoCT+RyrylEn5D21g8+2tilgKRrzIQ11v20KbQ7USWJ5BttL78hXq6MvWMakU/
         rQGw==
X-Forwarded-Encrypted: i=1; AKwUvBw+yNZTqZjszy9EtKYICGYpksfpb/ESMi+JIuLUtIuoPjIYJIPzSprlRQVqyZjNNamyzbc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqAer1c9xfV5Z+iHNSp6WXziD5wkpBbjGB7MqAiiPWUXGLhvuO
	oHotTMLPvsrN8ETPdARXE5vNU/oPyTYr1xWk4cTDdO8RY+DhdIEjki1JXEwJUruz4wo=
X-Gm-Gg: AYBFou2gFYidChTqVNJNRVJDxSO7GduLrpIpCojoL6acxryWalRjuZo9TcPe75Mwitu
	BAGmHXTg/74gtpEt6gOdl+bE+PgaCRZIBO/ynQC1bziiY9CqXyjUbtoqFZ6s8Ai+6rY+mcRMpzd
	FAwGcEAcsSTrlvGHqlhW2j/6y3dclMuSQZnLsu1da4bNSm8vy7eWxYIrX4qGC+AsPiEHOAGbNYK
	lKtXz8To2Ugv2cTkZflqX6oxbULyyNdDrqXYqPavcwKDOEPzZfpWXtMdDlhbEsLxLyrSPveggiI
	1w8kRY0ttD2pYvOd7wE/9IeJMYucLq7TQZrI81khlpDIfSwkhHFhSVI1dHduiIxuFxH4qXTiSu7
	b72GMi7vHRVhpVLMaKDPTJcrsI1U9aV/ZvsQOxRVDFSNy0XyUuTAryI4uUx+u0v0JbFLRClN04p
	TbAYfTOFta7rJHdfqIm0WVVravRU2TlUtcEyp/8DbLGrv6nfPw04w5o9XNIFpkWV008AmRFarSD
	zV/sxLUOoECHatn7WQyDg65oxIN/cL2WnVAfWIpa9L+0qHq+TE=
X-Received: by 2002:a5d:5010:0:b0:48a:ffcc:5b50 with SMTP id ffacd0b85a97d-48b12744206mr2302441f8f.40.1790926759988;
        Fri, 02 Oct 2026 00:39:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2f62:6d3:721b:8c9e? ([2a01:e0a:106d:1080:2f62:6d3:721b:8c9e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38105239sm5444144f8f.33.2026.10.02.00.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 00:39:19 -0700 (PDT)
Message-ID: <02ec6d43-f803-491c-a793-410ae80ac987@linaro.org>
Date: Fri, 2 Oct 2026 09:39:17 +0200
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
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org> <artlIYhgbskRJXDQ@houat>
 <27bc999f-ef3a-450d-a4ea-57ac45508705@linaro.org> <ar4C329Cm5hzB3kH@houat>
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
In-Reply-To: <ar4C329Cm5hzB3kH@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 09:01, Maxime Ripard wrote:
> On Wed, Sep 30, 2026 at 03:49:12PM +0200, Neil Armstrong wrote:
>> On 9/29/26 09:27, Maxime Ripard wrote:
>>> On Mon, Sep 28, 2026 at 09:20:12PM +0200, Neil Armstrong wrote:
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
>>>
>>> Would you be ok if I was to make a tool to decompile a BPF program into its
>>> source file equivalent?
>>
>> Not really, I don't see the point TBH.
> 
> Cool, another moving goalpost then.
> 
>>>> Another big issue is the API, I don't want to keep the current API as-is,
>>>> we plan to support more advanced panel features and use try to use the
>>>> atomic states to support rate switching for example, and I'm not confident
>>>> it's a good idea since there's no "simple" and "forever valid" API
>>>> to initialize panels...
>>>
>>> So, a couple of things here. First, I really don't think we should
>>> extend the panel API, like at all. But let's discuss that at Plumbers, I
>>> don't think it's very relevant to this discussion anyway.
>>
>> It is, and I'll expose why we need to get out of this deprecated API
>> as soon as possible, we are seriously keeping the ability to provide
>> support for advanced panel features which are implemented in vendor
>> kernels.
> 
> I guess I'm not the one working on out-of-tree panel drivers then. But
> yeah, I don't dispute that statement.
> 
>> The API was ok when DSI was added and we didn't have generalized atomic
>> modesetting, why would you not want panels to embrace atomic ?
>>
>> I don't understand, please elaborate.
> 
> Again, you're putting words in my mouth. I never said I don't want
> panels to embrace atomic. I said we shouldn't extend the panel API, I
> told you twice what I meant exactly by that:
> 
> https://lore.kernel.org/ksummit/20260604-grinning-determined-falcon-0e8b01@houat/
> 
>> I acknowledge it might sound a bit like "let's burn the whole thing to
>> the ground", but what you just described sounds an awful lot like what
>> the bridge API already does.
>>
>> Let's acknowledge that drm_bridge isn't just about bridge anymore, make
>> panels bridges, and we're done.
> 
> https://lore.kernel.org/dri-devel/20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org/
> 
>> It's not a panel driver, but a bridge one, which is also pretty
>> unconventional. This is required because panel drivers don't have
>> access to a detect callback that is required for the above, but I also
>> think that the recent work from Luca blurs the line from panels and
>> bridges and we'll end up going that road anyway.
> 
> So, yeah, my point is we already have an atomic API to support panels:
> it's the bridge one. If your plan is to make the panel API an equivalent
> to the bridge API, then it just makes no sense when all consumers are
> handling bridges anyway. Just write a bridge driver for your panel IC,
> and you're done. It works today, and you don't have to extend anything.
> And you can embrace your atomic panel.

I have no precise plan yet, but my idea is close. Since we basically program
the DDICs in panel drivers, which are bridges, just move them as bridges with
perhaps a set of panel DDIC helpers to reduce the burden to write a full
bridge driver and then declare the actual physical panel as connected to
the final bridge connector.

Having a proper "panel" described would be the key to the move, but the more
I dig the more it needs to be a generalized solution across DRM.
I had some feedback about how this would solve issues people struggle have
with advanced monitors arrangements and advanced features like Tiled Display, etc...

But yeah let's meet in Prague a discuss about this, I'll be pleasure to you
again in person, it has been a while !

Neil

> 
> Maxime

