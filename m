Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B55695
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446448; cv=none; b=MydZYZyrLxOA/7IXE4GFkp+7/MeuXFj28RXOVOPjqBWSW61slIlBFNAdclRNH2d809ZjPqZltxVmH0hoN/6vCW3i4hxdRVGZ8A5VtVoi+1l/pqqLX/FhH2ak71iD9vNSM6V/0NJdNwUSBbUQxq53Bx6krYhaHpT7utM1NgEaPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446448; c=relaxed/simple;
	bh=Jdy8vtd4v2L5ybNRpXFG2S36VaTj65TmQCtQyBKvDY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPOGA0gb9hYQqiH4wrYKmqKAV4MZCKjkHFRDd+Fwuxd+zktJBZj5gZlKTknKJtosPb9Vch+ZgVGnRXcv/g2dxM8G/kGSMGtNa5r/gBv+sR4W6g15QypENAwJwhJB+yZuXI8UXYOlhXrPged9+BHlgLeUpoXSyGLS+n4HJsslq6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=BPm0St31; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="BPm0St31"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c7393536e53so1090387a12.2
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773446445; x=1774051245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUNX9+er7eAIPoSIjhlN4xy336/lFgZH6wO1ycKkjxc=;
        b=BPm0St317WSF+FDVXPZku8XqNcuapzNMxoqTPqE3OqKcIqMSS6UuC1igk6ubEatQdT
         4Lzl8p63Q5q76TK26DZhZmZxN9KfN9elwCVF1MokzAa24HZA1WsvAX5pqTmq/svWXRXp
         /2lf7e/9qQ+UiXvoEUWWmjJiXTFYoQeYyN1kqH8X7wAj2cAY/2pzbm9NDAiqjAVjvDPO
         Z3v6BXj3oijos0ixwqzvU/jaDrqEVtiKneeSYWUoaEUblebmkWtIbWCqkbMnPuCduZYK
         ljHkfHGzbwCOuk6gt9E/Hrry1v3zAirZ8vEkf9edtvjCzdJyaj3AIe3EKpTrwWlo1R+2
         U2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446445; x=1774051245;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUNX9+er7eAIPoSIjhlN4xy336/lFgZH6wO1ycKkjxc=;
        b=OLuyRs1oSCZXctjQSHX4hem4RkNUNUcnk+Gj8a+0K8YiR6DQHkv1mcdV1ZJMpaZgT4
         6WCpe+80YOymeq/hCuEkSbLshzzXTAM0nlDYpQDhdVLFR7IoUzgyQfD9PpWW50A62S79
         HZZLns2PYyhgA9NP6jfyVei2l+PQEpgxgWdB2msvwCKL3sC7fjiwxlUdcm+PK5Lpwguk
         YxIs9HngAu0qthPjHgrVWR5KFtE+AuTt+S3Ufa/fGKv13vM3yIblyE9hUsc845jZ/ven
         8mruq1APoC43lSBJJM8woSXACY+v2zd0NJew3TkOfHR4TNqEWqpHlao6G+AZxpUL535B
         fmbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3xEAxuZmZg2OFKhJJAYUEmywF0WgvklTw5jfmxV6XygzrKu17HVZCDWQvvX7onHy5GNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnIN75/m4lpZ6sBqwx0d9SQMvC4PJEXbIAxuWcKSm3NgxI4+3v
	HVowzK+XKGjVQehqrdoJwgRzgN7lelFXbOLsPoM0EmZQAL8ExFth31bWLtvgRIe9u1g=
X-Gm-Gg: ATEYQzwlVCl5LWKfH9L/xR/X87KlxpNT/aUxYzXufTXIPZLCl7sOWQWl5OZZ1E8cho+
	tBhFd/xrG2DeoA6BD1sFZBWJQQ8UtpAwQ9GYCrTHbdWjrr6rPIwnVbf+7wKhuCL1Du2rujDausd
	50RMjPjfDJW/V645hyR4b6AeCnol6Bd94Cv5tbzCGwxriO4H1JQVabjKZT7sfDuqXT+A9WuSBMa
	LLW6zHP7oMO5IW3uDOGhvngL4l6VC4kfBm9kR5TUJYabtwGqBoniuA9mni315lT42XJvoOwM8Vs
	S6tySTKED3AftLg72RDrU6BLohcuUnioLEVmqk5Q7O449GHnaBUQhodlUfwt8tQy+q0RVX72tXF
	FC7knoQRVZLfphXuWcLV4ILtpP/fX9Oa5W6JSEbw9qJnvLTEAUyEr+OInG0Qu/5b3jOOWneXeEa
	FTz80=
X-Received: by 2002:a17:902:f70a:b0:2ae:5044:8dd4 with SMTP id d9443c01a7336-2aeca960929mr48646955ad.19.1773446445348;
        Fri, 13 Mar 2026 17:00:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece630b8asm33391945ad.40.2026.03.13.17.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:00:44 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:00:44 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/6] bnxt_en: use bnxt_xdp_buff for xdp
 context
Message-ID: <abSlLEsmGAlmGkQk@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260313223029.454755-1-carges@cloudflare.com>
 <20260313223029.454755-2-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313223029.454755-2-carges@cloudflare.com>

On Fri, Mar 13, 2026 at 05:27:31PM -0500, Chris J Arges wrote:
> This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
> pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
> along with the completion type.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
> v4: moved bnxt_xdp declaration to follow RCT style
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++--------
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
>  2 files changed, 22 insertions(+), 10 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
