Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8342E4274
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180251; cv=none; b=po3u8zaRdV3PCCfPBlMMAv12MRJqdfYrD3TgW8knZPyzz/d8/Qpeu+jBf8/5PTV03PlIbzna3RmuoqsIZQ9YYIN6HqE0SabGQnP5ws/RaOczD/5i+skfr9xdRqbZVDiiedb2xklj8WTu3DL6m4BEPlA1fWd04Y9RVzAMgN9lMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180251; c=relaxed/simple;
	bh=X0jYres7RAKfvS4aOQk8bP0u7kzw0Dczk5OQQ6co5ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRYpUX6Ae/IwLch8ROa+enk1MT/iLmeILSXRKXfw26w443aHo0BJ55G8uaeVINE/xZIcOqfgfS5qxbsNnCz8y/7+r2/sxxs6XTTllojGUZbZH9ihayhdRPKDg1Q/+6COFt1qEmF1HcnbOiRHqutsJi0lh2QsaxF7IJfpCK34VKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=wUJRshA1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="wUJRshA1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae82df847bso30964745ad.2
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773180249; x=1773785049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rRhnGis0WZpWlPXUYX9lgom+TN8jjMQV7lIc8SULHU=;
        b=wUJRshA1ZbgZHx8oohqXEVrapFeMWBj/BnXOTclN1O1HZ3EtKO3ONW6eyHcl2WB/hy
         BzOX0OQIZFq0/IuIHWr4o+NjQrpBOyG3Nh+agWDO70qHOMyhA727ciM+DdS2x6eY4KSP
         ZlzdGYzmwDjzm0t4Jjx9VBkzMVrkzt4PjdGjtCgAYoDdPwtYWdsBdDOj6CI/wH08Qg7s
         7uVKzi3UYlfDxUng6HpUjq9nU7SSydwS332xc6uCJ3lwJSNWZYve27hn4/Zdvu7oP7Ts
         jecmyCTqrgKxP2NLZve16Sy0TSIW/5EPAjltpksAt6/NzvLWrhMI5YHtdIUPieLrJNJZ
         Q3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773180249; x=1773785049;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rRhnGis0WZpWlPXUYX9lgom+TN8jjMQV7lIc8SULHU=;
        b=hhaM0GFIjD5tJescWp28Acy/eep/07PLBiwxq4iqR5N80ezEkaLcvmSpn1KRbGTN9s
         0dynkiOsW4iDsd3nIwjBLLma243MqE56fb/bQPhTc58qz8mS5mgNscwKGb3jJcCeQWWU
         xG61NRKsu1bc4FeuKrQL2xWDr3kg2kPuBvPFzNrnPvn8Da5Tm0Wz3uLwcpqqMGs13P2V
         jeY9PQbJjr+dbH6kb5G5N+W8I2U2wJ82yqrEObS0yn4jLjdZNIAxuE8qJNh2pg+4bBq2
         z7WeSR7Fk4d8UAjGF5KUPWbsrRn5KVESYCh80tilDc6J12p4iYr4ttcXoFC4hsU1qlZc
         R9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUOe7b5VHbo4Q+ivVtVgvVayw7hZvSsdxFuKA6+tcHgLZ0amKVgHLjJGbR1sjCb9mRTDi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+rdF6flYABuk4d3SJMzyeGYuoD/rpRTM3rbeHbz963f14cyKA
	soqynP8gOZCWlrOC7c6YqSqC3uN//6Pld5p1RgZiRp0kuIOmOqAx4Suju13l4LVgt9M=
X-Gm-Gg: ATEYQzwXcK10VfGkfAASiCs49YeHNx3EobyEFG96rZfuKEft//S1ju8QDL2BxZ4ed1o
	UHHQOcvwc55er75IqiUsypBB2Rksv24ZIfnu1e+NRMFxsL7W+YTFJTziBIDot3Yi++mmfaEBzg7
	tKq6ISbmSHApJbLHr8Wkf5gpRSsMsdr1h9bB/lQF+QeQcXW2fL+2DwngiTWuabDw0QYDiYpeYLi
	YXqY/nC1PhrEKtEK4wfpqTCF3vI0TIj73gIrdOl/dMG2VuCLb4yKBbpOG6b9h1VhgRQuhG5KDVC
	MOh3z29ctwMrB8xkNk1R6UgxbzJlUOtJn5qmjfbUOzlkM7fSoFNwd3NCAIb2hM4WrmGFIXaQSnT
	5FuCiU+zxPEPgon1PUjiPyRLVjDLjHqsMjs+kdrCIXeS2CYdlIow05UH9tBpWS50PPSb5qnRCMI
	Xfwv0T
X-Received: by 2002:a17:903:1a0f:b0:2ae:8293:7510 with SMTP id d9443c01a7336-2aeae905468mr2932715ad.54.1773180249550;
        Tue, 10 Mar 2026 15:04:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae261077sm2560365ad.40.2026.03.10.15.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 15:04:09 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:04:08 -0700
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [RFC net-next 00/10] Add TSO map-once DMA helpers and bnxt SW
 USO support
Message-ID: <abCVWEkf0n8Rdce2@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
References: <20260310212209.2263939-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310212209.2263939-1-joe@dama.to>

On Tue, Mar 10, 2026 at 02:21:48PM -0700, Joe Damato wrote:
> Greetings:
> 
> This series extends net/tso to add a data structure and some helpers allowing
> drivers to DMA map headers and packet payloads a single time. The helpers can
> then be used to reference slices of shared mapping for each segment. This
> helps to avoid the cost of repeated DMA mappings, especially on systems which
> use an IOMMU. N per-packet DMA maps are replaced with a single map for the
> entire GSO skb.
> 
> The added helpers are then used in bnxt to add support for software UDP
> Segmentation Offloading (SW USO) for older bnxt devices which do not have
> support for USO in hardware. Since the helpers are generic, other drivers
> can be extended similarly.

Sorry for the noise; just realized this implementation is buggy.

Will fix and send an RFC v2, but this series is the general idea of what I'll be
posting, for anyone interested.
