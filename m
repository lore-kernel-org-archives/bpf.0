Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE0018D658
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446469; cv=none; b=eyr9Ek+ufwlHMD1Dh8FTLJvXGj/E8yImfGosQlmiBYmVOE9XvgzQQWubjsICSmED7xXe9pzCipBK7XvCKhR5ThZDaPtTXDFOXYU8fabpCdUhvyS6U3ca40o/Nh2tIbxcEzI2xot9qw16GDSIXM1ktIRmfwmy8OI7KIEMG8ImL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446469; c=relaxed/simple;
	bh=cs6t7X7CRK8Svud40jTvRkJsFctHRu5gwJsDJpMYvLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOV22dOU1UyMcHRPgFgjc7qDJkWIpouUIqadQvOP/txxI6mNY3iCc7RSNNaMMBzxOIMs1+L9h4+y81kLi4/oUv65jZlI4MaWO7SICUrYNl1Rx/emTN3vuc+eQvKtaa6CCSOVN8QDdHer1EirB0nxh+95zors/QJfQ6J1Sfwt8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=IfMjK7uf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="IfMjK7uf"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35a03da7bd6so1716874a91.1
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 17:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773446468; x=1774051268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXbhoLYlxQyyo7Nw6ZYoN5BQZLWF6NXpzKSnh7TUmkA=;
        b=IfMjK7uf2QXpButcCVHR3aQYiCKacYe5OE3hyUm2aL5X2pXs/W03iLB7Fi6UkCkpYR
         gHhGImnppJEJJx79MfqxJfXWpYBQ5r+ee3QWZ/ar26FeB4pO74nB2hsB/+eprXhyOizm
         KI2foTHffWDe1n1MAiUQkAIL7LmR3Q3D255afysOezp3XkOemCU59D0G/qIloLo79kJ9
         /cvsYnJbFSICmgySDNEGIq8TYkYE9lYW5YcuTIxZHEi1mp279IGnaQNTR21qNI6kHtZ2
         t4XOWJosIxtvWMMxd5mNqIXQRZU/3AZDQK905hq+GJXrgPQAyRy74Z65cQSyJihC/z+8
         hJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446468; x=1774051268;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXbhoLYlxQyyo7Nw6ZYoN5BQZLWF6NXpzKSnh7TUmkA=;
        b=N0hky8olBLXeCvAj0JfZIdQdHbTQm6tS5H2TTsEx4LCFjxwt0YKLLEPA9KcF2N9FW2
         Ik2KTm/HTAvu/b1Hw4uyNeo2MBPqddpCNNL7Wv+rFW3fyDI2XXFyc4q4iTAtH3ZTyFWE
         6v9hxfDld1H124WPbQ4Rdruh3mWv7P2derq06llU6SUVWS8vOLFgHsXdwkmWRJhNtx+j
         ymDaK4puKh4td/jFLIu4q2+xIZHfdUlcsYZavJ9XOfDXHGCh9Khe0I2Xu1CZGv6Tedvx
         oLduTIO2f4Z+H1w0/UQ6iAxLBD4V250cXNr32EwbnRXzV/kM3ZLyQs7EY4SYYn5FkGPg
         ySIA==
X-Forwarded-Encrypted: i=1; AJvYcCXOAq7b8ygEC2LPDe+DBmm+taf/R2ALGBPCyGoCNaoTZdwgX9U4Kq3EwoDFSIQY3KL1upk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqsGX4pKsc9OxXXu3PYlx8dP4kTQGUFfGKZCHRvHEZHaQy1aC
	t6dmZ/Ja8hLjoQ996cJPQR7ZSGNVojP054p4E8fT8hELNh7mIS1z8Y3rdVdypHMmJkY=
X-Gm-Gg: ATEYQzx9Or/s19kZpz+Iu3Nuxie0GRI+YYQ4IpLqIwdg0A0uWCniF1vhRT3/AKZ30fO
	yaXql6crs7eh8lUWT+m0TzoRktb+NZp92v6DbdEy0D4HhW8TE+zPCDtBYflKhxO+l18rGAAns/N
	E1RYCW5Tkgy8ShicLfr57GM9qDgPovHNiu8/Nh2KfCrAp220ZgdsBzaBSqS6FDExgkEJt6pcTdx
	ZwQ+3814RAH0sQmAR1hm1Nu33uArB/j29lfH2glb09TdAY1khNgfnL28brXf7RvR70GQNa2v6zb
	FfCe72iV5zOO0Y/4rQWILXyH54aLPV+aJOCcHxa24GxlTztyJJs9tyh+bmG7XlaDLhblgwuUq4R
	FQhRjWb/ksC1Hbp3PR/1aOmIPK1R9tSRGlJnR8hLZwJM7+cTdjggBHT+AzOzyC+GZ/6R+2fvWeA
	zOkFe4
X-Received: by 2002:a17:90b:380f:b0:359:f7d2:a1f6 with SMTP id 98e67ed59e1d1-35a21c7676dmr4837429a91.0.1773446467734;
        Fri, 13 Mar 2026 17:01:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a23d9f29fsm3630876a91.10.2026.03.13.17.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:01:07 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:01:06 -0700
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
Subject: Re: [PATCH net-next v4 3/6] bnxt_en: Move bnxt_rss_ext_op into header
Message-ID: <abSlQrYQcY2zWJy7@devvm20253.cco0.facebook.com>
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
 <20260313223029.454755-4-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313223029.454755-4-carges@cloudflare.com>

On Fri, Mar 13, 2026 at 05:27:33PM -0500, Chris J Arges wrote:
> This allows bnxt_rss_ext_op to be used by other functions. In addition this
> modifies the rxcmp argument to be const since the function only reads from
> this structure.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 -----------------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>
