Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69D224F3
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642422; cv=none; b=DOIWSynQY34LffGdlbLk2GhrtSXYZI8ovT/zOkA18QUUm/9PvKrGeOnnHuCqQQ4nW7sywcPBGkNvh5vigKUM4YpOLf48dSnQUCnQHImHLU8ajPhH343Bsowd9h9PESNMkxgCgfuX3ZM3YBZmQcPQAP/65vSTqrcMXheW5YtVxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642422; c=relaxed/simple;
	bh=U77JBt3rd7KrKi9B6ZSJ5Gotj4ak/N4gpOAn1+GSv0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaFX2+L6dmh+EwtUwO8Cwn4yJ4fJW2Q1+D/vv1t6/xtbfFGpiBZoeOYOjxwTVG4rM0IQm/FXO1ZFURwfX49UH6ia4MOdfc4yFXpvrq4paTluqy3zrviuCo86pa8/pf4wxf6mVov/nu+DYYku9/Ej+U1tDwlk31qokTMZvKVDUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgDcTE1x; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgDcTE1x"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca24d39d8a4so221196a12.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 17:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783642420; x=1784247220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i/r66+UhRj5gZonbxUZ/VbF6Ixd13WSFTkICbzygVdQ=;
        b=UgDcTE1x7h5/pmPK5BzDpThM/svKjucSI6WFLIZtHNa2LqaI5NABDTzdFd3nJBEgw6
         ge4n4GEyWZNOcFltQe2XaaLofh0w0ayISm2Wabauw8HKBuwElHVnK97m9uZC3axfL5ue
         pkUFI0N0/M1UWQG8KiOEB3NPpv2xr1gG5kIMJfE0lUKCqZPjUp6IOyZ7Nd6ZvjvovV3v
         9sQSLgKBsPd1hqXRmod6n2w5WDv23rmjrJdTRTr0J2hlt8+Gc04kvATU0L7k63gPVNLH
         d0kSM+KWgG3bDv07ovDegj82dxGqhJQvqt7NlneSZ4TV7qeNOkvwcyvFWnd3sc2WfUVX
         sAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642420; x=1784247220;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i/r66+UhRj5gZonbxUZ/VbF6Ixd13WSFTkICbzygVdQ=;
        b=P6jHbl4fvlgqNS0OvIxklJnBI15Jx1G5gjC2L/D422iCd89RQ0PX9T6jrDMZLSNbZy
         adFJgRK3qOsStp6PvOa4+1c/OzzQCn3SHcTNuzTqtwi9mKVPZTYj06e/EjcwLSENHe3J
         /V+jJOqCz/tW4URsq8A+rT0/DbOmAP3Yo2yeeqbnFnnRa1UBP7AycTc2ctjyP7XPDFZh
         BKGlPIFRJgt/q+3+FfW97Fc1yi4LYcbIERzIYD6iPTj+T4lz6q3T8bgJM3WK/Z2liZGs
         D+19qmdoDaoRSPv0IPQCF/oWhUSwnOdR7cMRl9LMc9yExEzq8G80mtwrPTL8oK51780b
         +a4w==
X-Gm-Message-State: AOJu0Yz3zPNxtljHYwYLXVtoYe147uVVtY9VSTNX7ZE6HN8MMVsVXvgE
	jmAODgO+8m52M8vieusj14Vvx32VdR3P97Zsc/7l5WQ6LOpfHM1+XgXN
X-Gm-Gg: AfdE7cndpwt9wc09fv9vweXWCBUN+D2fJJDYvTrLVPGwxNzH1YrD/3vp7zjdqcUYVrC
	A8C+c8f2nk+fxUylOmEqOnGYGpSnvuGtBmF3giRrJCDi7GS0+oMDjUsuVvyerAOciSqCguC8Tk+
	JTelypUBeux3MO/Zek2CeYQQJaFRlqJuKOsgJ8u+HX2Q/41+sd6WClF/Oq295h27jfJgAvXzNWc
	I/+ltfbwklXFccCsWNE6DMMuIGMyBut6+OM/Xxx+3y+OU4HKV/AaiXGL1/S5bAaDd+JB81YqLpo
	AolnVz2ROhj8m+cMF6Wb/1+o7nrUiwnDGjLUdgtOaHAiVrpt0JXLp1GROPd3NdaVGr8Fvmv209k
	lq2elT6XPfUveaDBEeJDA2G2cjjcc4GDYvXfu03+NzOatPmBNB3dEF4zNBuwhHfbxcrVlk/oVak
	G4CavP6WShH/lZ
X-Received: by 2002:a05:6a00:3d0a:b0:847:99bb:b6d8 with SMTP id d2e1a72fcca58-8484302e490mr9433177b3a.26.1783642420202;
        Thu, 09 Jul 2026 17:13:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6ddc974sm9519604b3a.60.2026.07.09.17.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:13:39 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:12:37 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v11 2/5] selftests/bpf: add bpf_icmp_send kfunc
 cgroup_skb tests
Message-ID: <alA47To0uswUAFf3@devvm7509.cco0.facebook.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
 <20260709144900.245904-3-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709144900.245904-3-mahe.tardy@gmail.com>

On 07/09, Mahe Tardy wrote:
> This test opens a server and client, enters a new cgroup, attach a
> cgroup_skb program on egress and calls the bpf_icmp_send function from
> the client egress so that an ICMP unreach control message is sent back
> to the client. It then fetches the message from the error queue to
> confirm the correct ICMP unreach code has been sent.
> 
> Note that, for the client, we have to connect in non-blocking mode to
> let the test execute faster. Otherwise, we need to wait for the TCP
> three-way handshake to timeout in the kernel before reading the errno.
> 
> Also note that we don't set IP_RECVERR on the socket in
> connect_to_fd_nonblock since the error will be transferred anyway in our
> test because the connection is rejected at the beginning of the TCP
> handshake. See in net/ipv4/tcp_ipv4.c:tcp_v4_err for more details.
> 
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
