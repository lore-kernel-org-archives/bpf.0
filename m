Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D9E28DC4
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642423; cv=none; b=qJwLevk+zzDCo0HVVv7Y0paLRan0kJxb2lpW8PfKH4AHKP4MxzLTu+OsbCBfit4qLJlfzToy7/wHoraa/4fOYrnyk6oj7OS3adaPQREzw7pvDoJwP816M+g5n2SQq8bpNwtjXy89oaJzpRNFsIfjSDb8i9CCcOLK9iO4+alf9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642423; c=relaxed/simple;
	bh=4th0MfbBWLVOtM/cgbbWVwBzlPcMrWjTSb7fkio8tKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln9P0oUI4G01bdbUvFfUCcyPKRuTnanGb5q96jrRaY64CKsGlG5FFZ54c45tBdHvC1PD/pIXZry5CCNV8cIIx6BmfDepdy9ifN/cX6GLzGuv2Tlgc0FnDuJOZIJc8xDkM87HHoI3UUh4HYJukSFE0uSvo2nsJVkLJ0LcJeM7FdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkhYUTgI; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkhYUTgI"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c888c19b85dso64724a12.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 17:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783642421; x=1784247221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cWBteTvaFd6DcZzmKtdqbpXJSrq03LaitnrbfsJjp7E=;
        b=lkhYUTgIBmOvN7IhDjd3fTW909gPXbjANqTlqWOF5ykPMMw/vaHtc27PhUc8Q4/jtI
         Z4OJhLDZZnjPIMY1sjP/MxufR0kHVL94mrv8/2ZzPPdAC2NVLc4Gej9TQPSpeLodrKxa
         sM0yZCfQq9vX6hawsznB6PrySr6tz0jyTWRFoDPRu6TLAxUI6bAkbMzUWCoUw6Bow20C
         EWJ2efMu3s+E6wcHwN1Y8wHod8buFJN2NbrUOn7YCnyvg6BZ2yUy2BiTWTq+E7JdDH1/
         VOQcMVFxZE5lsvDdqPeb6IwP3YxXdWR3Ind7FWtBJoroyr50aDcNOygsqrt4ZMf9v4Vs
         1Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642421; x=1784247221;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWBteTvaFd6DcZzmKtdqbpXJSrq03LaitnrbfsJjp7E=;
        b=j9KbJzEYR2YS4cMecJrxakfxl7OYdVJFEXQ71AZU+rFeq42LEO00uggDnTvPKgjG8j
         kE6HGwp5+Hsc3gkvM58zcFSlAbX2SxqtJZpuze7EeTmrKF9Suqvwj+XCO+M1pPru7vYK
         BuUElFkzkmfJ7XMC6c6dF5Nm/Ug0r2IqS9te0eGwpaZHqlluhoyrxF2NqdZVARMdEkZy
         gOxZV7z44Vm6gpVfVsYJ8IaHDOZPNInOnjOTMI9LFeJtz8rG9emLIMsGwWKPKLoaIaEj
         AKMknE9QYXpdFT9hRMe/AOO05GgkYOHszzA5n1O0Rti744U7oGCTqUF8C6ilp0zGiL14
         0llw==
X-Gm-Message-State: AOJu0YxhdQ1on6SHPFT5tF1JwDq7trHemuBAmfo5lZb9EjCRbqoKvxuX
	TQtENFVPrZP+DeJQ4PMahzh+BcTL+lm5FObbecrQec3CL//jBv/NxUNI
X-Gm-Gg: AfdE7cnZlCLmb1kuRaeCIWKx3t36XpQq5noufpxwWn15XInK9SuScB0KnAL3zr6qoNJ
	qfHLD7gMcR11GTpweigsj1r0nIolKyYIv7ovjvxIHZCdx/wlbeVmb6uNofed20eb/rLs2OImSUF
	jkZvsPGyq3rm5z9FFtnMe8rfxJxY89G516XcPLm0cOeEckBR710Z/r+rJ8FEEqVyb+Iq2oLy98F
	UxYgRid9D1NoJRL1QpQDBNZHH3zCmtKDfdSBivxABJiiWfuAKnrlED1i1MTDC3ZXbsTnCHjB4Ux
	f3WJMgHpX2ZtSTLhIxWg5DHr9a5PAUdJXQyTHuEEVLNEPxvPvef241TUtjLdoMo+Er4iTPiF9hf
	5wKsNcAr8FfDEQun7m0egUDMo23avs6sO8xZ1kggCHONmwXpasYbVZXQl8KwizzXwqOGHIMpHlm
	oh7BY/
X-Received: by 2002:a05:6a00:23c9:b0:847:8449:2bb6 with SMTP id d2e1a72fcca58-84842ebbe41mr9174033b3a.4.1783642421290;
        Thu, 09 Jul 2026 17:13:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8485413c264sm2278278b3a.61.2026.07.09.17.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:13:40 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:12:47 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v11 3/5] selftests/bpf: add bpf_icmp_send kfunc
 cgroup_skb IPv6 tests
Message-ID: <alA4-eMg_Fw4a7cV@devvm7509.cco0.facebook.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
 <20260709144900.245904-4-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709144900.245904-4-mahe.tardy@gmail.com>

On 07/09, Mahe Tardy wrote:
> This test extends the existing cgroup_skb tests with IPv6 support.
> 
> Note that we need to set IPV6_RECVERR on the socket for IPv6 in
> connect_to_fd_nonblock otherwise the error will be ignored even if we
> are in the middle of the TCP handshake. See in
> net/ipv6/datagram.c:ipv6_icmp_error for more details.
> 
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
