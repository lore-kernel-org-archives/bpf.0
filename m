Received: from mail-vs2-f27.google.com (mail-vs2-f27.google.com [74.125.227.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208453B440F
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622986; cv=none; b=I/M3a7BWOdQ7S83Rxu7kjYbxdxC2UjTDkD0WR7FOqbkTfhEEkpf7b54u8L6zeXdrY2HVZU2bbXtJtXXtDY5cJXExa8TQPiXENOZd1AmZsn4FervfEV071zHDMjdyc8Aw1MKseBLxozrjbL6BXM8kh583WfA12JtG7LLC2RLMoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622986; c=relaxed/simple;
	bh=8o86JjkAcKW1SQ3YiOijQtpyWtLRAZA8fJZvP/xH5d4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c0u7GASH0H8MsJVeUoH8m0n0slSoPQYmjVK/Rje8Mm3NiGpfin9nEuXDWIJb8+Ybd0uxwzydjClJZkz9ak5I+AaoloL7sbzjTf+LWp2XUfWqiBbe0ZN58e1H69KBrf3PS7dXwpcwFZI76RGTF3g1TbHCeKL856JKEgCYe8ZDaSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B9BHqKQC; arc=none smtp.client-ip=74.125.227.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9BHqKQC"
Received: by mail-vs2-f27.google.com with SMTP id 71dfb90a1353d-5c963d7503fso1146262e0c.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790622983; x=1791227783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BQ/QxsaYA9sPy0Rq4QivZtNIQwREX4bWNN8dGL2Ve94=;
        b=B9BHqKQCrK+/68hjpsxzjJT5KEvxJaYYONWFx6NyCc/PPVa2kvPiQMF6U5aN/4Pg8a
         fE7Ye8FOegGhWNtqJcFambSZWTBNRC6C6XxFsBtRCQMYdubTvqPunlKo852nbFe1YPiC
         M1IixVw+GYlBk2MzqaIqs6eEQjl2sylYxNrDsw7Gifnp5jL6U1GN6r6sa4n7ShP7WyWB
         DigsUxLsv3kDvFmNg2llwGfYghJ/mxIj7/npYooHJ85yFq/qjgWg0r8y5b062EX3rcZE
         w9CkUuzAJG4kyBIWtC0vxQkacKfksPY3YupibfS0XVXDov4hCdWhkPRf29LhA9u2OTgv
         MP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790622983; x=1791227783;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BQ/QxsaYA9sPy0Rq4QivZtNIQwREX4bWNN8dGL2Ve94=;
        b=x8GWDmCRDwOyKsrS1jPpfbhPH/WS73o3FgE9mbZxsUI/S1+se8YyJhOYo0AEUhxozU
         sosxHoNZCN1yuK7mdZ5/okQWFHSpFB6i2nPUi3ADvw7w0MnRgahZhu0qMFnmZuE9Dl8o
         bP/RUvE4dq0jVAD4RGAmwe2xjKlXr4yFAJ9ysycLDna3CBsQqnpKwcMI0sTzd9BeQA/V
         Px5SflsD3YK3AK5pt/AZza34Y6bFuXZkXEJQlzsIwUxTFJXrmO5uj9QTU1aDDJ3oIPdj
         6JxTsnP2FD5JRrF3zC71VujrWAby/9Xh8R5wn2vqGORneI/FJZg2tuykQUIogf3rzFqD
         nedA==
X-Forwarded-Encrypted: i=1; AKwUvBzL0WB8zEFYmHReZWVIANTxQjcUeRqlgIgXIFD12VBKqjV9sOm0a3lQOw2AWSQwuMFLZFY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKl7qdlAjpJZQIo9AmuEYYmTaSyIHrH8KTZQEjGAW+okv26Hc5/
	XPuDa1imoA2AgPMQnoFF0Hk8u3l6KVR4en8j7gqoO33yKtpYrLBccKWCYfSAQVi3Y1c=
X-Gm-Gg: AYBFou2mSWgqSjVduv6OPoEhmg8xWmcVN8DwvsFsYMItIEtLbUlxkgcXm0NlQJOyqFW
	R1BeOYn9Jw07lErTS1F9VqksXwqANt7MRrQtWmd03sV1xPxbqVu7pUFfrFlprJncvLwKbF6aHX5
	GaHJ+ZqzCJjtLJltxSeNFZ6+hNTWA7kP+0i4Y6pmyC2WqYsz8i+cyh1/NupuBn8/DneBo5ZpQ3j
	g+/vbbmBUPQ8TNU/Bw+nB3o+0r5KHuf9iPPLsE1kdL1PMH+8W3BisKLjq7Sd7IIivx5wC37Jt8T
	EZQJKeu0VsIlAJpZX+cVV5Q4HmIfyr9iWOeNJM68w8Plac7vcr7xEWEF1MUFvXUt7QoHb5ANCV8
	sXoqia88Cx5SGJdCZNnMyTvfB0wQIp8xsMFkxJjXEMdQUmd6AlHtj7R8CAGJu4fmIi4yqsI955d
	dS/5omB9D7jsjCtnz4QMF8WsrMQZeSOZoJj9Tfu2jALVToABwjbmT7o3kSeQqbNAqjqHnMFXzta
	s4NQF4N5yqtjDgtEq5J0gihudlaHDZ8h/otKYMUcMHYe25BXsSPSG6mcBQ6qAmWlQZUpf2ijptD
	Xh86snE=
X-Received: by 2002:a05:6122:1313:b0:5c9:a60b:e5d5 with SMTP id 71dfb90a1353d-5cb0b67e6bbmr5760667e0c.15.1790622982793;
        Mon, 28 Sep 2026 12:16:22 -0700 (PDT)
Received: from [10.21.51.184] (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca. [142.127.77.63])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde4f969b9sm10052205e0c.3.2026.09.28.12.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 12:16:22 -0700 (PDT)
Message-ID: <8fa0c826-9d4a-487c-b7db-5412118364d5@linaro.org>
Date: Mon, 28 Sep 2026 21:16:20 +0200
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
To: Maxime Ripard <mripard@kernel.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
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
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
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
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 18:22, Maxime Ripard wrote:
> Most MIPI-DSI panel drivers follow an identical pattern: acquire
> regulators and GPIOs, perform a reset pulse with specific timing,
> send a vendor-supplied sequence of DSI commands, then enable the
> display. The only truly panel-specific part is the init sequence
> and power-on/off timing.
> 
> The panel-mipi-dsi-bpf driver replaces per-panel kernel modules
> with a single generic driver whose panel-specific behavior is
> provided by BPF programs loaded from userspace at runtime,
> following the HID-BPF model. This enables new panel support
> without kernel patches.
> 
> Panel DT nodes use a two-entry compatible with the panel-specific
> string first and "panel-mipi-dsi-bpf" as fallback. The generic
> driver matches on the fallback, while the first compatible is used
> to identify which BPF program to load.
> 
> Six normalized optional regulator supplies cover ~95% of existing
> MIPI-DSI panels: vcc (IC core), iovcc (I/O interface), avdd/avee
> (positive/negative analog), and elvdd/elvss (OLED EL driver).
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   .../bindings/display/panel/panel-mipi-dsi-bpf.yaml | 184 +++++++++++++++++++++
>   1 file changed, 184 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.yaml
> new file mode 100644
> index 000000000000..9a20a21cf70e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.yaml
> @@ -0,0 +1,184 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/panel-mipi-dsi-bpf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic MIPI-DSI panel with BPF init sequences
> +
> +maintainers:
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +description: |
> +  A generic MIPI-DSI panel driver where the panel-specific power sequencing
> +  and DSI init commands are provided by BPF programs.
> +
> +  Panel DT nodes use a fallback compatible so the generic driver matches on
> +  "panel-mipi-dsi-bpf" while the first compatible identifies the specific
> +  panel for BPF program matching.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - description: Panel-specific compatible string
> +      - const: panel-mipi-dsi-bpf

I don't see how this can be a valid hardware description, bfp is a software
implementation and has nothing to do in the bindings.

Neil
