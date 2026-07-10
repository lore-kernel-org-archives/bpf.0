Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB9377566
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712947; cv=none; b=HuAFd7FfnwuwfltoPfd3oBO792QhsPn/CR/AmsIEQ4pXsdWOzG79EJqDNht4xLmJLON3LMA24iLe87ziA+2SjilbQ7nhVlhxyDOhf+lQO1YXJdFMKeVdRo4PXNirXeXxFfxZRBTzLLXx+bEsCp1muZOjsf12K8V1BDvVOF2Cr4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712947; c=relaxed/simple;
	bh=9ffiN42qaC1jpsImMXKTd2bML44rwupDWgL0tCrKHHM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZHq43x1a4TxMvN4A2v7k9aIeGXZtxY4JEb8EVWGlnVawFQcyP3aIC7ok/nij3webJlZgtx+3ewrT01ldusaJEYX2I4CZo2KXutwmVT4A5s58aaRpoRwj8cX8Rr2vKgSyjf4hRo+ksX4M1LRogNlKX5Xdi/KSsRLNaA7E8U7afQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1e+jbnk; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1e+jbnk"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-493af9b574cso4658855e9.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783712944; x=1784317744; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9ffiN42qaC1jpsImMXKTd2bML44rwupDWgL0tCrKHHM=;
        b=g1e+jbnkJmSaNDHsIJ64qyQYZlumSYLB/a10JIwFRjjwaW2a0xREGFAWIgyNyGWmnd
         kDQ8o1OEMpd+I9WP0S1bfPXZd6+DZCBbeYhM5h01rOlwAeCxLZkgNFSzn7mlPygUt8rv
         H/UU0KL15590crrsVGz00Z7NPciqvZGEkwImz+TdSKvMs3xxywlJtQysgrVJk0EXo+sB
         QMM/q5ZXdo5O8ulg2ippLjLncjFrwtFo9uE2nZX3ZnkmtEVB2s1B+bVGbqeGG9R8C0Wb
         irZ3qR3huZbVJfA1Jbw+N05WTczBI65j9SqimuSUd9EOMpkcob6yNw6QSmqAf/tlpKbP
         C7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783712944; x=1784317744;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ffiN42qaC1jpsImMXKTd2bML44rwupDWgL0tCrKHHM=;
        b=O0O42GO1SFn28iKyRgHIz/lp4o3IkISRP2DPzAUh7zkU+CoHhG0mUtI0cx9TKPeoMM
         DU05BfvWfPiZ46+O0jeguK8PYK0l+GLGpNKYDNjmN9QE0IqE6cf9iGN2DZjpWhQ10DSz
         sANeYi/EGEhf18jjSI/gV+GktizYxHXkoaIx3xuZozzKahNFuKoaeLbU5i9Kn3qRq/hV
         qdBsptqI5iNgqOhPESCL1WsQfpQ8aWQeoKYllDyODv0t4pc2lRibJQJw50Z9csSE38DT
         jrt/iZo60kAN5xU/1x0fV8moJj39uFtrskN7bA4A8oKpbKWD+qc0x2B9taO2PUnEFrQo
         mcsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDs7htXmXCckxgdotlm9i8AWvNSu1hwO8sDAdayKeiC+utr6GExxqAwx65am/Syl0l6T0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17hUvfqex7Zj8+BI+jCdl6EZvrYFmXL2rmksLTIZzrG5FCgEZ
	y14GcTHitoAO+YOvsnnT38uFYLJL6TLg0nV7vUozApp1QfkcwMcvm9o3
X-Gm-Gg: AfdE7cmVgYc+4PKBOpCjXHAx/j5GYvAZvhI6BwTHnti/5WzCj6eJTXUmvxEv6W9PJwj
	bJZG+DjEKLdmKfTi519rUyI3kHXb4vxcCLhI4Ewc5wV3U/QuB29H5Mek30p6PP7z6zcWzIdHqtV
	MHOQtOiluHTlNY9ISM72s1uxepzvUsnJdfxTIGrGRlZEYU9fYwIbeHxma5exDPJQ6QDV741+jDV
	BsJqmRa7KTGhqQSK909bbu74CDSXQQkUbMqgLJrAUMsQjG1AkKAFq7lNrh3H1ewT868l7Bl4E6o
	aBtrJkhsCoP4VdX760FuT5zqF2oHg55ufuH01dp7MMsMKHkC4jLEkd8AH6Hb+b7uldL6j3aDg4R
	6DeuvnDpAtxVg6zvPNIkimaI4MMKRWySzl11prTjFEeG22Yar9k0O072mT/LmXHltCGFtr3ZV6O
	qJ5nr81SiUnD8+gtFxdlhJF3anf2kv5rqnbvAWuJ9y548W6Q0J5gCjmiVRgi3IhmLFQgDyrE30U
	OAJm3fH1WQ5Zf1Ljo0JvipvDGSUInZv0B6pGmJeTW3Qaj7dWrExrk8=
X-Received: by 2002:a5d:64ef:0:b0:475:f0d1:eb5a with SMTP id ffacd0b85a97d-47f2dd132e0mr127404f8f.53.1783712944499;
        Fri, 10 Jul 2026 12:49:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8cdsm66202553f8f.1.2026.07.10.12.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 21:49:03 +0200
Message-Id: <DJV5GU2AGDJB.2YWAL2MA7FM6T@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
Cc: "kernel test robot" <lkp@intel.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jordan Rife" <jordan@jrife.io>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Fix unused nskb warning in bpf_icmp_send
X-Mailer: aerc 0.21.0
References: <20260710180915.7105-1-mahe.tardy@gmail.com>
In-Reply-To: <20260710180915.7105-1-mahe.tardy@gmail.com>

On Fri Jul 10, 2026 at 8:09 PM CEST, Mahe Tardy wrote:
> Declare nskb inside the IPv4 and IPv6 case blocks so it is only present
> when the corresponding code is built. The case braces are intentional to
> scope the local declarations under the switch labels.
>
> Fixes: f3603df9aebb ("bpf: Add bpf_icmp_send kfunc")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607110140.JeJZ6GIa-lkp@i=
ntel.com/
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---

pw-bot is asleep, applied.
