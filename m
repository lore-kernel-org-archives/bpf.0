Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B73D649A
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790082; cv=none; b=r38XK3ugKGlC/Z1tYHOpUAu/16RLamiq0GRu3XRtV7YkSDFN2AzsQPpROMLwKYaq+Fd/iPcxx3ZuOa3XPecMRpNvmciy/5wKtC52Ze/Px1KhgdI4eQHJ+WIQ1/HK69GQ1OgeUvZwDzPEE2NeWjl/vW4eB3fCJ/poNpA7I+N/Ws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790082; c=relaxed/simple;
	bh=UhEIIQ/fF6JUzP2E7jtUaa6TUP1Hc0Cfz/k0EoiURMk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CNgmCWFy+h4xC6XqMjZopTm4maNsnhUkhKgIxw8eF9A1zsuZMPbofMsgglMgO+F6YN/X54lfPta341UNvjPGfNxNqYhtVN2/XesUriSGlU5wIRIFTPD/mOUTZ6buYqTgcQTvSRmAhKkn8VxqAQvI17ZEhTOKEv0c+JGXA646Jw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhM5d4PB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhM5d4PB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48d146705b4so109946475e9.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 03:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779790079; x=1780394879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UhEIIQ/fF6JUzP2E7jtUaa6TUP1Hc0Cfz/k0EoiURMk=;
        b=nhM5d4PByi4xSAS3U27yxW6KF7L/hBEubEIAYTggJ7kZsUjlNlRmhewLoXbG4Nvtpg
         gUoAYxvkEGaXOK800aKwD9aSU1yQDk75udsSOC0l00GpyDLcgMDcqc6CDDJ3EZiJWT9k
         BhAFSDTUKVCphiWAaryStKMXl1KYZkGs+vF6stY6TsxLjSkLKg0H80s+mfBTL7ClDQxi
         wrh/oNB6+vFekhmJv5/NNq756L8RvneHRa4K9RxViy+hRDot6TAack2lxRoRuO+e1Era
         7M4UcTDFPMnWsTCzzTeGHJp/F2A27v/iijQ/SIQp5PA2vfyWk6Ly2m4K59/Esw6+hxHN
         cXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790079; x=1780394879;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhEIIQ/fF6JUzP2E7jtUaa6TUP1Hc0Cfz/k0EoiURMk=;
        b=hE3bAXWVMiheURRYgrT0CgI4VO5q0jNn3QPf2oTBx2IrUM2Pl6XuoyJjJ2Xr16pm48
         u7svN6+vh2SY46rMTr7fJZo52QO4ypdZMvmcumoZ/QlXn7f3VP/zFcYWO+lQp1h4D2G3
         JudKo+jUB8UpyNQOLtg6tPeHgf3jFbrahd17i2AOHTf7uQIbK1dqdOCI77ANIYDpyOwM
         LlsYA0JEja952XVaWlZ3xBQARopfgq9lkkhvhuJQYP3QGnZ8rwbulWln5I5xWNqpF+7D
         DrcT+d3/avI0xy+fxgCtF7SiL0EgoGeliojR30YTwQ1gDO2+Uc7XoU1p3G2lyqwQ3mph
         U6hg==
X-Gm-Message-State: AOJu0Yxkz0P1c7lVGQOBDhxExYQlxdV3e+H00R7hKfEnPDA5h5heBAjs
	oMngJo1vRjnNahO01Lvp7ILx6IQtzHD+AaW733b2O7N/5qvzgpYBKkfTdJSy2Q==
X-Gm-Gg: Acq92OFpVWCPDBZUYXcFclVjKM0RozUGumw1L3nShwSivEG1KJndjJGeuEGSoTO5x8F
	H209FWEmPmoxZlxH0jNe9o6jWTylkR7B1hgVPvBhj+vr1817qMBJ5vddFsIH61b0USUMgAy8tA8
	8PrEMfBisnGnm7h/Oy1LLMgretblObc3VD5CIQSy1iToUrzZUVDBROvwVcPiQBQB6tgEqFFxq2T
	n+mnbfFQneFSu1J1gf0ya3wFTBsdmQ299Ab3X3881rEXPp1F9DS/sQGxD8n4joTkMZJ2+ODj1Ug
	S6dVZ9uxKTUHQmgEDQyYntEpyVVcshYdQf4POI6RusPv6wBfwH/41jClxd8PuHSSu5vBiE3PcX5
	g95tEsUn3vXeJGrKK9AjooGgCJjR9fsfuUQh9lSV0KauLoim1lY0FASrZXxEOAowMExK4eJH96+
	Z2qk739AN41OjNn339TLW7hbEFi5ijoJTQgbSFZJOgxiwRaSZsA3H3J0dDMvfQuN7gLI9LzXu4Q
	rhr+rCTQGs=
X-Received: by 2002:a05:600c:530c:b0:490:5527:3be2 with SMTP id 5b1f17b1804b1-49055273be6mr204156145e9.32.1779790079105;
        Tue, 26 May 2026 03:07:59 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c60b5sm344635055e9.1.2026.05.26.03.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 03:07:58 -0700 (PDT)
Message-ID: <eed59d12-969f-4135-a84b-4965743692cd@gmail.com>
Date: Tue, 26 May 2026 11:07:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] tracing: Expose tracepoint BTF ids via
 tracefs
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org, rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>, linux-trace-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
 <20260518-generic_tracepoint-v2-2-b755a5cf67bb@meta.com>
Content-Language: en-US
In-Reply-To: <20260518-generic_tracepoint-v2-2-b755a5cf67bb@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Steven,

Gentle ping on this patch from the series.

Since this part touches tracing, I’d appreciate your thoughts on the
tracing changes whenever you have a chance.

Thanks,
Mykyta
