Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF1A27442
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686399; cv=none; b=SPZSMpAESFPFDqQlJXtWGwdB9RHye4++/M8nKFOI1T/6ajxrZBBnCWa37RI1BV4+sE80MZK2neUaB3xtra8EVFAexqP5F9nR3yfVso790tJPBNOq05YQ89OuRJHILPMBnHrkPmAk4OITDJNx9/SHqLbprxCnV12MPXJK8uSaYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686399; c=relaxed/simple;
	bh=ptCC6ECWoq8NwvEdGxDOHxyoOAmU11HMhIDNaeufYn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yrkevggqcs8wVjYYhmA7FkRb5BjjjIzG+WZisjnVvG9RkWvo+icRxa1cHtyeLXtnvn/z81UnjQaQ+OthdNm83VXXHRiLRTxWnax2Zw5kv2YSSAKyHDc/ftQPtxkU7/6KQNWF2Wd+HQpn6Nm5Jie+s/dIZ36rPGo7UuVC+kEbc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE9QBlWp; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE9QBlWp"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c801912c903so3267453a12.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686395; x=1779291195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9pfvZX6NILfeGSOJxHfBjON7lRfDPEPyL1FGEyg6nE=;
        b=iE9QBlWp5OQLkejtWY/11Lz8YrrdM/OYTTKVvnKseUkr/lI6vH/bgkErOF6Hq1KZFP
         lDcmgu9s93arsru9+rFQbIulGzqd335bcMAIUoy76udbWQaCSrtd4RDfhb1hZIXJFFut
         UwyOxdJE3i8oG4GMMGqnuFqmMLSycCkuub2/zfTAzWuaQ0/nuGHxlI1s1nYMdaCIcR2p
         xWydnJJmVWwEzDJRtfmh8MUAvYyU5vSAle3sraXh9xxxRvxj3Z0we77JR1hdjmZfv6do
         BOlaxxvVrvcM5wQPC0VN1fcORyTAK7p/A4ejyWQJrpD8tfhO08w5cQJhPdjf0NQRJ+1y
         dWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686395; x=1779291195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9pfvZX6NILfeGSOJxHfBjON7lRfDPEPyL1FGEyg6nE=;
        b=cMKBKtjVyiZPSkjMXzrdyNgwrLTAGd+/kVRB78zbkB65srgkG9COS/9beHaS230SnG
         bD1kZL/ddeG+7PwOHSXZB34yahEjmcYFObp0rYhHYgi7LeaM4WLEkITd5AW7czMx1uoO
         h9S7hN4t/i8CYeH06ttqQPNwRUuXKXD/wzQWCRLIgDpj2kVAXqJIuTnI6AL8ook6QDs6
         ncaSy19jUEpoXA0lThYbM5lPuUxPt/CUE6Yn3GVCLHiy8eB8jA9BiOVaCJr+XvKlnDG3
         WahoIjomPe9OGXdp2oWMpHwKWxDguUVTgXoeDCn4TM68U3DdpuVq/b07eb0FEz60fHOH
         2nIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+x9ZfZThsfbvCdQ1z9UF6qChIGsbu7lnoJAJI9y8kIWHm0lkhvrhi3JoOYE7NWL56Tfpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGgjT03yJmLbFPIVnF0JX+elysOc2cUmofDjJORQ/F1hEC5ee
	iIw7zKjrSlEPEXZ81RIE5BHXFuE1t60Y/tEf4G/H51Ez0FeyueAzfHS6
X-Gm-Gg: Acq92OECtC1oAoC+azsR2RjMhzeUAEIxPHlzoqlDg6YdKz26+AxtErLzoP4EN35Fwhg
	YuYYnZpfc1tAyQxCAOX6GGfgGg0EdbhbesS7KfcqqSieVk6sf3T2RWIuBdjuobY8En0/AMdyTEP
	oRpAju7yrkGuS7WaE4+Ka+esJRpgDN2zmn0ksrxj2g3Jog/BYebROYTs/KqxKCb2eKOwrtmxmKI
	tbjXj9g94c1cyRHaY2DYOzJShqaaixsbM2mhfQspNo3d1syga541fwEoFIKpHZgDr8GGZZuhUs8
	uLrBGbKlAz0uclIiQTtcJhuhqssgCoJZpOh2nic4Q66lKHr3td2NqcHw4UQpOlS2wON+lwRHgB3
	qCs5/eLRyKg/7o8Fq75ImY/xScZ6hT+Wdbq1MejrkAt9vE8l9pwinkF2rhZIpFrv8fM+pDlu9wU
	VFZA1VZPCaRFRkNoXh
X-Received: by 2002:a05:6a21:6d8f:b0:398:6bb5:54c4 with SMTP id adf61e73a8af0-3af7ee34f61mr4503273637.5.1778686394884;
        Wed, 13 May 2026 08:33:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:55::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82675fb236sm15718164a12.0.2026.05.13.08.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:33:14 -0700 (PDT)
Date: Wed, 13 May 2026 08:33:13 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 5/6] rxrpc: convert to getsockopt_iter
Message-ID: <agSZsZGe_MpQzY0L@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-5-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-5-fe7f0e756fac@debian.org>

On 05/13, Breno Leitao wrote:
> Convert RxRPC socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
