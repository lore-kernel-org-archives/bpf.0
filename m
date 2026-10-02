Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C4C414433
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926145; cv=none; b=nMrMhVAKo/zm1H8TXPVaOmYOX+37Ng2EWHLvcZp5Jc1KjGzyFJL01pMThn/+lNVm4PmMS7X2DT5fCMbn/kTFP4kFK7U+SIZJDqVtgyLa/ifYxFRZDUdyBiuGyMI+s6Ldcyz0b4Bby2Sa6QNKZr8ntSYugJfrROPT2W7UKDStxsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926145; c=relaxed/simple;
	bh=BTuGr8m9qHOpmcjHfKxzvSU/3vPYu8rA2unWoXylLKk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dd/dwIy+TbQg5Cd08S5+lahwyxPyXumoIlIgNO44xp9u2eAfAnmsRYQkkPJ+39oa4b5cHichZapHM51BGhHChwDlo5pc40UEHYh2+6zyiHrXyEHRPWT5fgHpJVSFOh3DFkNe2MaZynaqUE75f/ntr41zzMAg8V6otgPxfunvHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bhKSNBHo; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhKSNBHo"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso66160135e9.3
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790926141; x=1791530941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6zplr7QU6lV0JIsmwOjHD1EDA7HxZc99c9t5ZOt0FqI=;
        b=bhKSNBHoAMMnzGX7ZcGPXEO4IE47Ndm51W5xr/hzwzpiypx7FC5CfkYK+Kt87JVpQJ
         /QJosLMTALfrEVEhFCXcdAS1G9h9spnUj4KuxCEDblLtrfUVg4tvXdmotnJI/oP7GuRe
         ennf0DeKkC4v6rQ/HW4bb458+0+QeuwGAluRstIcsqABFH/AbFXpV0FZ7GqxxcBgRzBj
         b2BlhCGJVgL9n8Cp4hU0EHXk4uRwBb2PJrCBXlmw338T0qsJz5bUqCM+Cj2BiFMW67cI
         7KmvaFREUd9aDsWFdrS7IaBOXKHyQv9LJrT1DOBQddrm/6Wb4ZxRyhqeLNpCxbbnnBqS
         EiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790926141; x=1791530941;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6zplr7QU6lV0JIsmwOjHD1EDA7HxZc99c9t5ZOt0FqI=;
        b=2wulbP/y/a5/oWR6FqNOztIQ8fO5b24RLub2fWZH/J25ldMHe+8SKHrmcI0NUywhD8
         0QwisuCYpyBq5Q9PO+ZM9C8niqIJ70YhUQEUA0hg9MTB6ze19mOOwAdvHPLQSL5jvBq/
         mEzOcYzay03zFYP0YKODz8mMqm0Z1evXH5TeG77wZmi4vucuqYRaCMPU4MphcW2MKMex
         yCFC3SgZIo56ICgHw+6yrFNTZehf4kwtIutDuc4oyewVHYqCJpbGerX2gVFp/0CEpj98
         jzybZzpjQd/u9u0Jp6hI6chseozhipO/msQLiFO2luJB8kRafZBsPrk0ngrI4pxOqwwb
         RTNA==
X-Forwarded-Encrypted: i=1; AKwUvBwZEyGpM1or8dCslcrCAoK795kKlNRpk8DgIjKNUAcys2kCp+QAps7Cp4muuMO0fhdX1sY=@vger.kernel.org
X-Gm-Message-State: AFuF++ktymgL/sGSNlueFFlc40FcKEoHl5FmVvTxk41cRjfukoq986WT
	E1KK7aiKRT7PHWMijd+6rF3VQhIltYFRCrAsHFaB5xF9/ckH2TQKFtc449tiN12WBa8=
X-Gm-Gg: AYBFou0V5aG5EboBkP5foEhBtej1XwFiMLT9hPkIfSrGgsiqaHpxZz8CbLSK53WC99L
	4SwFJ902Ehn0EGvb/1vJlmZRggJvcBNck/hO7QpJSLPXEMvYN87GIHE+wcn7WQavmUERMnmwBGP
	aanCPVLiMtGguXEORzDbzeQ5E0b7wSaZyW0jue3TPiWKSjzTOqX1mfUklEFIHcnV6LZmP2M9M1D
	7584Y+vCNIOT8ZIT1fsTLOKqubsPU4XA83wPMT6i11BLU/yWq0vnq2RnaJjLIqE4hGBHTysyV/z
	r/ZHVq0cPMei//J0CBNf87TjZv8hayPV3vn+q4m3r28p4mKqZJeBuYGZTv3Vsqk2qAuJU4MZhs3
	BTCgIfO4DtqzqSg6rDi0/Clr6F57c4vpWAFQ30mS6ldED2PY4qVpgqDepNU6FFSpwSc4vaKfa2u
	+V52OHe6K9/jRTLVI1G3VarqbNkGL1K811qBGTR/YjD+AzKf2yFM1eC+V/ckVZ4h+GB3M3BLkHH
	uwuiG1LkpiXP9X3xIZ2y/Gh8z0r4+fc8i6n+ZZdD238Y4/MqD2r425noS9Lxw==
X-Received: by 2002:a05:600c:1911:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-4a02756643dmr30178595e9.10.1790926141218;
        Fri, 02 Oct 2026 00:29:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2f62:6d3:721b:8c9e? ([2a01:e0a:106d:1080:2f62:6d3:721b:8c9e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a039505568sm42454685e9.3.2026.10.02.00.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 00:29:00 -0700 (PDT)
Message-ID: <ebe0714e-cb96-4091-a718-97dd9c081710@linaro.org>
Date: Fri, 2 Oct 2026 09:28:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
To: Maxime Ripard <mripard@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
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
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
 <20260928204059.GA515872-robh@kernel.org> <artyl8fD3zzng8Uh@houat>
 <742d5bab-51cc-49f0-825a-f299a055bb1e@linaro.org> <ar4G864IgYTvfNNy@houat>
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
In-Reply-To: <ar4G864IgYTvfNNy@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 09:09, Maxime Ripard wrote:
> On Wed, Sep 30, 2026 at 03:32:19PM +0200, Neil Armstrong wrote:
>> On 9/29/26 10:39, Maxime Ripard wrote:
>>> Hi,
>>>
>>>
>> <snip>
>>
>>>
>>> panel-mipi-dsi-spi is a generic panel that will load a firmware, and
>>> quite similar to this one. google,android-pipe and qcom,fastrpc don't
>>> attach to anything and will just open a tunnel to userspace, which is
>>> somewhat equivalent but more dramatic than what this driver is doing.
>>> simple-card or its variations will just instantiate a kernel driver from
>>> the DT and is used pretty much everywhere.
>>>
>>> I reused the binding from panel-mipi-dsi-spi for this. It was reviewed
>>> by rob, and acked by a panel maintainer, and 4 years ago, so we're way
>>> past the "oh but we didn't know what we were doing back then" argument.
>>>
>>> So, let's phrase this differently: what's different about the
>>> description than panel-mipi-dsi-spi, or any other binding already in
>>> tree?
>>
>> The panel-mipi-dsi-spi still describes a class of H/W control interface,
>> not a pure software driver implementation type.
>>
>> "panel-mipi-dsi-bpf" or "panel-mipi-dsi-rust" or "panel-mipi-dsi-cplusplus"
>> would be the same problem.
> 
> Rob explicitly said the bpf part wasn't the problem. Also, I don't care
> for the compatible itself, so what would be an acceptable compatible for
> you?
> 
>>> If it's the BPF part, BPF is not Linux-only, and there's hardware with
>>> direct BPF support these days, so it can be considered OS-agnostic and
>>> not an implementation detail.
>>
>> If somehow panels used a standardized MIPI firmware we could define this
>> in DT, but here we're basically inventing our own type of firmware from
>> thin air.
> 
> That's not what panel-mipi-dsi-spi is.

What you describe is how it's implemented in software

Neil

> 
> Maxime

