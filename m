Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A817A31C
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698532; cv=none; b=BkuoFAxAfFxgUoDtzOozJo4bopb/ZE7K8M/yw+BYLhGmzkkvsH4IixREWHMgXCMayZCdg+AHhgR1/MvodToZGfJrCg5KAtRsPei9nO4fVyKNT8FxiBJd2oy+Yd1nGArWH6SkYKgLpxfGtXy0QtgNbIxib52kuT/ZFy1Ni04HEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698532; c=relaxed/simple;
	bh=AgRRhqr+xsgiNYhaHTvirxnepaiUqG3kn3v1saTxfJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seWt2qPKre4f8AIeEax42YWlcTJu83Yh+SrKi6JWcOXcuWfazZGBPsZijGPYpyRqQJEyHiUInVHe0xepeAh58npsq8AS7K38NXxEr5qxuuVQoPKijH+hXOLIbamXf3TvWxvspTVFbPXEgP/hKnflU8lt4WS8uVBARc6l5EB92TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiwGyiA1; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiwGyiA1"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d9b21d1461so3378572a34.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776698529; x=1777303329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmHj4qLUk/zUhVqmDWix9lzF21N06q4cYXnz7D8gDJI=;
        b=EiwGyiA1y831fauNR7yHPrVrXw/yLeg8qQFUlhLId50UO1bNl1YuNYOtRjB7bQx3yA
         lkMqYbJaK+ROo7Evn9Ce+cNeHXpBYKu5Zn7Q+Tri+SygF11Gh0cF14N/jHT84u7Yk6CQ
         7d5vNcKtl2WtgzlPiavTn6DL/xrxSy+tGUuSWUaDAdrK7BTSfoykR8Gr9BDpLNX1u9Np
         ++CMT8dvFAXAKrN+dcrbh78KSgbugLZIeyQTvUV6k2kH3bucEdtjVePQ1UhXkqkvCzLx
         +lHLnVMhLDo9ubmThfF0FmNr2i0fgiS1RNj9kRcYtE/1FMQwXi+j50h9RcJU0vijaEIw
         SGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776698529; x=1777303329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmHj4qLUk/zUhVqmDWix9lzF21N06q4cYXnz7D8gDJI=;
        b=idWBr2e52+7K2AO9UPqkyb77gmGYA7/myeQITa6Cc6kc3JuXE32uCjbrGVumtn/QEf
         LqAxvDmaImbszceOYtCozMixXCaQFD9Wiwh1XEyM5x5w1Kvypp3ofeyZB4zhht8FrRJQ
         PxqkovYvxW7eEyjlf2Cdf8UE1i3QiQwPSrL22OxOGhiBKu6hJkM2I4OnbPwbe+Tkign7
         5HzTyzgeTMaOkZ39rpn8TOxkCGLUN6+khdYZAex/ClQ7gN3vVm3ElsU51SQTVLVuw4W4
         v3NpIalRiRnklurXpNkIK1GMdG69rSEfgQOhHrRxItUgJ+rYWc0AhJMnBjlnszmLumKF
         igmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CZrwhlxKZFeQk3Ao+RtWOF5ndSb8L1cyS9S6p9H0wB+soQ10gtRBl4Y9s9Elj8vaLtU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQy2uG7YVphxGG8loUdNkwP3vtyc3Mxf4nWeWYBiVzWYpURs0X
	8yvs86IvMoInY2URqXQbwsYrCbrYia9CgqTfNiLj1cklJyaN1zyenC8d
X-Gm-Gg: AeBDieslA/YaR0f5VAZ1rtxIW7Vcew4IY/sGfMoIfJl6N2TZyXI7WhD3gPfqjh291xb
	j5LYOHM7vuxevuy2OLyUcV0OIjIJEOVVVXS6+1+l1FqBhkb4ffPDO5lp3EPaYCVO7l+jWoaK7jn
	/vwnWuOsK2bAeDfvBW/QndQlThZB2TqN3dDb6Ka7Y4BLAa20pFgyBbT5In3EsaAsn7Lu7YsEoov
	VL+J9WlFqsjQmHunzQZL4Us3abgmfMxSY+OpH0kw2tP6anBBNyrpQPXtcZsL94I6rRua4I6vJOY
	7A9bWilPRNAiUvVgRzx3cy0Wp3O00lFC2JYR5/5sgZQQWM5jzF9gmOZBdN7vV2oh69NRWT5v/hy
	+vgg9ZZzkqr0ElZrOg/ZsOKFXSA9PpdjUD1OIzdJtB+8Ra//MSu7OuTBUDmh1L/RJGxl0XZZNxw
	2dvGaDHOIAbxlLb0LMdCMILB4XsWnP
X-Received: by 2002:a9d:4006:0:b0:7dc:cb0d:9e02 with SMTP id 46e09a7af769-7dccb0da338mr855442a34.9.1776698529551;
        Mon, 20 Apr 2026 08:22:09 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc953e39asm1510189a34.15.2026.04.20.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:22:09 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:22:07 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/4] xsk: avoid skb leak in XDP_TX_METADATA case
Message-ID: <aeZEjZSsVIdpcbFF@devvm17672.vll0.facebook.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
 <20260418045644.28612-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260418045644.28612-2-kerneljasonxing@gmail.com>

On 04/18, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Fix it by explicitly adding kfree_skb() before returning back to its
> caller.
> 
> How to reproduce it in virtio_net:
> 1. the current skb is the first one (which means no frag and xs->skb is
>    NULL) and users enable metadata feature.
> 2. xsk_skb_metadata() returns a error code.
> 3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
> 4. there is no chance to free this skb anymore.
> 
> Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
> Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
