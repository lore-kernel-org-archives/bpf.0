Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEA53655E7
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212789; cv=none; b=p4Y/BFUMVmK8XWwiryGo1r0Hc+MtwRmxGX2gvYIowIln6Jmuzk7Jj5dnWenrE1rc94NzI0oEzvwKDuSQV/xWzXh8WVc8wegKFmXh4TmJADnOKQybzWoDC7A8guSg9gHA4QIejFATGFkN9fdJBMl0TXvD+21iyBdZbo++32brPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212789; c=relaxed/simple;
	bh=ZtJX3WQMMA9mK+XaCcfLnc35EMB865YOIgWqBlRERPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9SIsRVcf5zNL425gd5XlPbz/PJSYo1cPSjr8lpIdXEoO2+h32/LAUr4eEujFvSMxC8/vZ3/z8xOooLaDvELJGHIbPvNcfLDzsrNK9lrX1VuHm6kXMVMGHILLrX9GFqm1ubi/H7Vxjv73x7H1Hnp8GeTumFudmKVctwLDa+bDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=hBa5pHA/; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="hBa5pHA/"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13810b63a1aso610280c88.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781212787; x=1781817587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qf+EMuGOGT252QVdKS/7NYWLP675aIpiwNn6fsk89tw=;
        b=hBa5pHA/lCT+/3vsW+QBm+9mOfu0xy8Uxv8H5EHDrjvowK4cur50bmrpY0hHgNhJYt
         3N3p79AooLfwpGwocaeJXBs1nuJfOBlbvl25IjbFxzFflpXP5xUWVOLQhjR0MplrenjE
         K3uVcYQABYhYSkKoKMP41dfithK7laoAZKa6OqFfUzLqhbz/jjdb4cvh/ZAOm9pUiMv6
         9OjAGeLhFl0P9uRAt4ZYvI4UGCUQusyxhjcbMn8kP5nL3vPiC3DIrOHh1dMslYXjaqb5
         QIX2ZLTqobVjsfH2DpALdKeqQ20v9KB+wspFH/2KA74h7rIucYmDqlKYz0RZqjY/DkA6
         pRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212787; x=1781817587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qf+EMuGOGT252QVdKS/7NYWLP675aIpiwNn6fsk89tw=;
        b=CYCAYyU8We8D96pn2e0/hc+LqpdfIKa1kAQvrNzh5JO0FAHYfPqzH1Et0bgH/Zbz0k
         j41n1PsQNOuGwy1v7pvhNKq8CdYkMOhJrvbCQG00NH4BmDkSWEZMm+etNdCLRjet0nN7
         tl+mzeQhIX374hg/tpHX/p615vWG3RU9YdkZDWzAq9APuQS6t8R+JSLafBW702vf1GTc
         UmHtyq+TVtwSG3GJQ1aj34vizB/I12Hc548q24M13LF4WX9oLkiYLcLxWWiV9kKa7HPm
         x+y4CQr2p/prphxxXtnEs9N6iaQKhqdHi+3+pEuUUmRM0JvU0Oo2bzFXhExvhjpd0MOH
         oQbw==
X-Forwarded-Encrypted: i=1; AFNElJ+cBDKpy/7XVGNVCmPCK9lt9S81HRZB0LtRRsvZ9Qns/nNUvuXa9ju02MB9XSaQtz2nQAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64qfIM0XbjXaFgZufAOBL4J2hKGH3lrJEXdSeJKPHlgUVv7OQ
	RaZqmTUKAVe4vs7S63lSnH4l8cGUc1vPfVBobfOtytXCPlFSW49Ene3XjJoxJ+CShU0=
X-Gm-Gg: Acq92OF2LLwQrnXkfRCMXB+FQk36m/KKsiujsdbZawx2yoJvXurzHzM5S4rGnU0adGb
	xN21Qr1fw1ECVyAfVdas47umkvuNeKYO7PSTuIVpDYlHI5F8mC9phqjLvnitvdSxRoDwmXl/hIB
	OyssTIKKlHF3fIjvcPqJ7uR0M5M2AwIPJr8xpt+66Er0RLr6ijKgRnaYK/FvStJ41moe/Bcriju
	vbsjHVaUCXt0+4t9iAsM7QfTkap20kK/dPfuhhPiQiSY2DnvGRkMgKE3Ncnv8dgy8nZt0KVZxVa
	59DFCGmHPV0E0TnXf/P6AsuFYYK1redjBCZlZTk+uuWSA7ppozICYKdqGbRENdYwKYZh3TBfiKM
	4i0nQQGSTyjmV76uOg+WyqCwhDt1BbK064h2w6yd+23088nBfm1tqQQzVDzahYCq72P79J7qg5P
	Eo23K33ocXXp/DyMArigDGq+gCCqcgR395MyG1cFzC+dLw0pgxKUu6ag==
X-Received: by 2002:a05:7022:6ba8:b0:137:fea7:ed19 with SMTP id a92af1059eb24-1384bb1c373mr26757c88.3.1781212787304;
        Thu, 11 Jun 2026 14:19:47 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b919ef9sm84787c88.7.2026.06.11.14.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:19:46 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:19:45 -0700
From: Cong Wang <cwang@multikernel.io>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: take the socket lock in
 udp_bpf_recvmsg()
Message-ID: <aismcTr30ORVXQhW@pop-os.localdomain>
References: <20260610175922.1103871-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610175922.1103871-1-rhkrqnwk98@gmail.com>

On Wed, Jun 10, 2026 at 05:59:17PM +0000, Sechang Lim wrote:
> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 9f33b07b1481..8dd73e9ee1ea 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -80,7 +80,9 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	}
>  
>  msg_bytes_ready:
> +	lock_sock(sk);
>  	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
> +	release_sock(sk);
>  	if (!copied) {
>  		long timeo;
>  		int data;

It seems Kuniyuki's fix covers more than yours:
https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/

Regards,
Cong
