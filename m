Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC843CEE3
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927593; cv=none; b=Ol8fsY5x+jb2YBWyxaoGK6ZhbtBpZpNLwilOZiNlkSqs9HLE+llm8ib6lN2daq6zETYdbgLKVGDpzBUZ/VZwVOjm8lmWoOtJrY8q7V3Re+l0VXMvsRHET7UZK+yMSI2Q5IFQEt5kyfj983NSxTJAw3D0YLo9aMMp34SPkTD3d3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927593; c=relaxed/simple;
	bh=ag+sZnjQWuyPSA4K+zz6QgF7pFR9QYHKz6IJ/tFAQLQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O86vhInXQRS9Y46cZWb7/pMJEsUn1YaTfUIDf1eHQaea8BxIB9ZOmf9y3/N2TeSk6E3uyk1r4aouIiToB1WKZezjyvklXi/mNEyAHbvtOFfnfxBXsgkFm8c3Abj5AriIxnnfKFYlSyaF5GvJZ0mrTak1tfyPi+FjO763DcXCC6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cqh1NaeE; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqh1NaeE"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b05fdb2f9so1717035f8f.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790927590; x=1791532390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=URK5hJaiby1L1KtEXv2HgCyxpcy+Et12hnj8ni1/g3I=;
        b=cqh1NaeEqrQtHsMP1LF5wq/gPDJlRjc152vrjLf+zRyR8Jm64x79MrxtkpOrIra/Uz
         vOqiRV+/BB8DkleBjvMdw5tIm3QHP/hI9BdUUjFsm/NwMrV5QJKpXKBT6p7p7sDsET5y
         5py7yp2FWX6SCsTf3knHwW38Qpe5U6ceRW+oVgZRINv39M8Vw2ZNZQz+AArbZ3Ig8Zeg
         4J7pS/OeK3NxIuZgntbbie+DLAgZqe5Nqtq/NAWMm/2v7Zbt8jJXMnGKX3qxkhKXnLyQ
         FpSz6cfEUWcwl8SHF8X6WUbc1eyPBAo74S1N18xHPAzNJL+bo2hCv8fKperxOrpCsyno
         Ywfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927590; x=1791532390;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=URK5hJaiby1L1KtEXv2HgCyxpcy+Et12hnj8ni1/g3I=;
        b=rVe9nNfkxMqgKd0ntZErhshcZTkcZJQhVsOvx0kdbAf2kYYzS2pS1QVq/FmVIZ9csn
         PGBmaLHiFKMOKdw3ZTXKA/pdoPreU1PumaNVZnxVcbEC0WlNBKTy9gV89TPG89ur34eV
         BbihhsevEg2gGbt3g93wEAEi7TBgYrbF81BmarskyJBcJaANg7PekZ9YVI/TNOE5p12C
         tUPDM6j53B98Qj5qgTcXldJax8c4zPyq6l+Dr17V3IlChTBeI6qtz7cchdVyj046nc4V
         L0dcvMk16E4vMwAyisjXzW90jGHe9ctS2i6ia5OKa45wyld+8I7ScnxbnMEv0pIsWSad
         qhbw==
X-Forwarded-Encrypted: i=1; AKwUvBzGtYB76r2EOzSR23SiVqApPY7kkaQlC69raUdRWhMRtCgsrB+vFHLOmoRY5ZSBfH+yEJg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwnf3OJ7NBcwwmeqtKU2nyymLGslzhytLpm0209B1W5QMm4n7l
	aVvnCfE+WWFeutma3BAU62GZpOrI+TfTgepO8WMPA9fFP9dVgFmSvn7ONika/LC/rY4=
X-Gm-Gg: AYBFou2tSkHB9/mv00QUI2rl9Fm+pwzeiuRkJhFHjI4uyvjopW9ly8KpudWUmdpS8zK
	4MLIBuQWnQHHQDcXCeZeWmFAmk+kumtHxiXGKgMmRqKlOI6G2qbROAoKMQrEycmeqQ92J3g9yUB
	oe7xW2lp09BihII3q0MGF3dmSTN4/yOuqKeO99nyf8XzJiuSkMGiRC0+/Vkj5eNlglqsaODWr4e
	0uxNCDZvc6Cbo7wqj3xo710a8gxrBY1+i98VEMrxrZ5w8jb1/PMLL4N2CSDpUQEyN6f0czngKjH
	IK+285HV2JVJQpHUjH/Ha8KkCYSxB0FEwc8pA5bVmNkBEhdHeONlPWwIFOJc8ScG1dYQcZd82vE
	bjmCOTnM1yrw8RUE9eEIJQF5oShYzKnFpO0QOb1csn2/RjzZ5R7g16BK9u8RA9HTGIQvfYVkPyf
	XAYp6eZ88PIUZo2y7eqR6R1ZPdFBmb7xQM0K227uQFnDbGuhASd22MEXuvPkmDQUiKCAKe1SH+X
	iNGaybv2ncc5sPJ3NQYHpJh29VtPx/n5fn2WHDOtp2bGcTyxRMK
X-Received: by 2002:a05:6000:46da:b0:48b:68:592e with SMTP id ffacd0b85a97d-48b126c2526mr2669376f8f.4.1790927590269;
        Fri, 02 Oct 2026 00:53:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2f62:6d3:721b:8c9e? ([2a01:e0a:106d:1080:2f62:6d3:721b:8c9e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f0ab7sm3840821f8f.7.2026.10.02.00.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 00:53:09 -0700 (PDT)
Message-ID: <a92aa0bb-d50f-4b67-a645-942090d4fe79@linaro.org>
Date: Fri, 2 Oct 2026 09:53:07 +0200
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
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>
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
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org> <arqhwHiVf00j94J7@beelink>
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org> <arrAqg5n87INTHE6@beelink>
 <674314b4-6b80-4b3a-ac15-eefd31cea607@linaro.org> <artpBMeM13Dd0lLy@houat>
 <xlv1wls4ebjq.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <828c9108-2db1-45a6-9301-19159a094301@linaro.org> <ar4CRTMQGs5_nGKY@houat>
 <2bd17843-4a65-49b0-9e10-7b73afb206b6@linaro.org>
 <xlv1cxtsft8e.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
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
In-Reply-To: <xlv1cxtsft8e.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/26 09:37, Javier Martinez Canillas wrote:
> Neil Armstrong <neil.armstrong@linaro.org> writes:
> 
> Hello Neil,
> 
>> On 10/1/26 08:50, Maxime Ripard wrote:
> 
> [...]
> 
>>>>
>>>> I don't want to add a supplementary maintenance burden for the sake of using a cool
>>>> technology which has serious drawbacks and dependencies on user-space even if looks
>>>> really cool.
>>>
>>> Spoiler alert: v2 won't. I've got the in-kernel loader to work and thus
>>> you can have a built-in panel driver that works without user-space
>>> intervention. So this is not a topic of discussion anymore.
>>
>> It will still have users-space dependency, meaning the BPF files will need to
>> exist in the fs when drivers probes.
>>
> 
> It doesn't have to AFAIU. The BPF programs could be built into the kernel
> image, just like firmware binaries could be built-in as well.

Right so my main question still is: what does it solve exactly ?

All the descriptions I saw so far is that it simply moves
the panel C code to a BPF code with no other additions.

I still don't have a clear view of what is precisely solves.

It adds some complexity to load those BPF driver, adds some
maintenance complexities since with every API change we will
need validate BPF still works in addition to C (and maybe one day Rust).

As the maintainer of the panels, merging a bunch of new panels at each
releases and helping migrating to newer and modern way to interact
with panels, I think I have the right to express my interrogations.

I'm clearly not the oldest kernel contributor & maintainer around here,
but the main interrogation I have when submitting, reviewing and
merging is : does it really solve something efficiently.

I don't want people to be frustrated by my review and question,
but I feel I'm allowed to say I'm not convinced about this solution.

Neil

> 
>> Neil
>>
> 

