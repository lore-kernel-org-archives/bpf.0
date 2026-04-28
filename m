Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E714E401A27
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378938; cv=none; b=o44u/Wfxzapwlbrvgd2y/VrkduWb6S+7dOVovbwNp/Zy0AdWsie2lYuGPn7brittpVPFaTLnWTj3E/Yd4cw3c7X0VLgJtKmy4yt+iHud9UYkdwl1mb2h5415JkPRUwiSXSPf0/+wI3d3Y90vxK4jYZE823DdtYsmtkEbwb9fKpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378938; c=relaxed/simple;
	bh=eYPmyiMGSedPs8Nz6KaAqMfRG2j7jcSEfi7C64leoOo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XOfgepMVfItVbFFD7pyj/yPyt3lGAThQYUu9rVcexAXs9RoSUefq1M37c2VTcFD8Ho9jrqzUC7v3R6BY8+vbCv3ut1M3pztN1YGOc/nr/2pV1XRY6/c45TFPtNQckJJ0mkGsGxQoGID/yfUodTqrNapTEiVe2KROPnGqOoRhph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+5HNLPn; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+5HNLPn"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3614826eca4so9934059a91.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 05:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777378927; x=1777983727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eYPmyiMGSedPs8Nz6KaAqMfRG2j7jcSEfi7C64leoOo=;
        b=X+5HNLPnvrHMrNvEklBf9QLL7d/h/vmSwyQchRWz8qWl/nJ/tAaaLOHeglkvjl/7b6
         ZYEpkn2ZAe+o0gw+Tz6mDS5L7RLlrxv6lGHRoPPCupkS0pJk1fCZPqq2pmgkBVb4AOf+
         akDfXc8+2Bm1FBmqbUgK1Wauvy6fNQpNi9PWOZaotEkeWzEsPKMb6EWxKKQn7l4jsosc
         jC6Guo16iuAGd2CaSkv4sILLid+k1rjs9dWMkfWua4DL+vJ0uI/R6/piItUQeuAnNU+e
         NffETEUEnwV1IOQkClJQZkBiuajbfOkw6YaEHOZfcVuknkdSP9ppaeE0V0fynYNsySEE
         V7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777378927; x=1777983727;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYPmyiMGSedPs8Nz6KaAqMfRG2j7jcSEfi7C64leoOo=;
        b=ebDz/7vUtzEWQvF5SzTjQeO7mo0XtjKDQd09C08Ow4EdDyUbPEClfZ18ByKiILPI4k
         LSxe4+iEvpkI/X6earvH6TUSCYDl6QxtloSgrXgAyfpiQJhwpZyfcng+w7mr2ZAxNhEN
         ZJR0NsOdxUJ2kRtMQ6Pa/DpiIVq2WZY1O8Ju5HBgr3KZ97hve7XsD40bpztm8qHaptCk
         cl5Zja9tRbIDcuvMGEyleWyc7+prTlA/Deo3Ta3mW8l17uUYwFrn1vDbeSvjyhFz4vn/
         BZ/by1K9xkr/eYeTFjBW4SBG+CEIiAagE9aYeF1nTlCWq7mckzQ/uHEoXb3akbdSf6QY
         zHNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gOqflVG8QXkjUa7OmLnogurQkOfyOFBX7XDfpS60lWMebHK+VpEErtLQSjfGEsw3oGmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv/EhnkOcijgNEkyn7wdDqyAalDXxxYEAf8Bpn8S1PukwrbdFJ
	HjnsBqLYY2xwB8V3ZwdP8Vl6+tomXWK0mvOq9fN9J0807Rsm+fATGwDM
X-Gm-Gg: AeBDies9Kfbjvi8uTfoTkH9S2H6VDwoS3mDzF+viIGTDmwi11mqqlkZAiAf/Wv2he+3
	WNmJrdUJk6+RYhUEj4lHfaCZHQkxduN1fhR2MEB+4nfOOs+790lt1vP0h82IyHXz1JJYleJWmyM
	vVFCiiPyqS89t/z5YWW1+Xc4F4GLMDQ5poUB04LDnS2BvKbt5tPWH6ww/ZJe+9brv9otnOqm/tO
	783rQNeK//3EJcD7RmX3HD1gYBhFgKT6JpWK1LCOgXwtNP2+p6mFZjtm3cQMekeAISEWVr3gA0G
	K3jKwEPEfj+gLqkjk5GE3b1oiptPPtB6sWGSd0ZGs1RdocX8GAUHc+Y/MtcVMXbrx1eq35RK6wi
	BfSP4MY3u3DwKnxz9Dn8Syg1Yuj8z0wkPgZhVjBTAwKhgPdg0gbNV52FB6HWLmsvRnly8cQROcl
	G2clak8PhH7t/7FM3K92NJQ5ebqO2MJc09KMjZR6gRiNeFT8mwPqn3Q5BU+jZ58r4TQHYDNqlNr
	FINmw/mhHs=
X-Received: by 2002:a17:90b:2f8f:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-36491c8837amr2989046a91.0.1777378927430;
        Tue, 28 Apr 2026 05:22:07 -0700 (PDT)
Received: from ?IPV6:2001:da8:201d:1103:3367:a44:8d5a:228a? ([2001:da8:201d:1103:3367:a44:8d5a:228a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490de9f9asm2987905a91.8.2026.04.28.05.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 05:22:07 -0700 (PDT)
Message-ID: <65911f89-e1ef-4da1-aa41-d261e5162f71@gmail.com>
Date: Tue, 28 Apr 2026 20:21:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Linpu Yu <linpu5433@gmail.com>
Subject: Re: [PATCH v2 bpf 1/1] xskmap: reject TX-only AF_XDP sockets
To: kerneljasonxing@gmail.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: sdf@fomichev.me, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bjorn@kernel.org, linux-kernel@vger.kernel.org, tanyuan98@outlook.com,
 yifanwucs@gmail.com
References: <2b156bc4277a9e891f3399935416701d1f9efd7c.1777276241.git.linpu5433@gmail.com>
Content-Language: en-US
In-Reply-To: <2b156bc4277a9e891f3399935416701d1f9efd7c.1777276241.git.linpu5433@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for catching this. fbfc504a24f5 is not the correct Fixes target.

At that point, AF_XDP did not yet have TX ring support in the UAPI, and
xsk_bind() also required xs->rx to exist, so a TX-only socket was not
constructible there.

Tx queue support came later in f61459030ec7 ("xsk: add Tx queue setup and
mmap support"), but XSKMAP updates still rejected sockets without an Rx
ring via xsk_is_setup_for_bpf_map().

The regression was introduced when 968be23ceaca removed that check.
I have corrected the Fixes tag accordingly in v3.

