Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEDC4E73A7
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724847; cv=none; b=tYefvvmxz9kE6TmM+47QIvDXQ9qVkrOCYbz/5SfF4ap97QehkPNnn2/Wjntja5iSsHw+4IERA3VnZv8EYHz9yqq/nW+SP2BI2qoyWJ2frVa9ctgOAPnIjDEV+N8fnOckGGcmMN3m8XSJFD2BpoNsFYqcK353vRwRijzDPj+E8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724847; c=relaxed/simple;
	bh=pppU/o89qm1sLiO0OoAbWHZ4lhtSEjVPfFnL708X03k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS+uPmCppdeKyuOLnr97sObVY+G/o83Bephkk9HsI/nyJFXvnohn9yRCtGfJdz2bqXjJXcPhSm1jN1+wPT2UkpLziCxXaxLXNFV3om0LKq7vkASZA7Q2WUZO4OphH36+xKJtzt03PXw/2rQnuUJWwFef4idSaYQor2aQWgbbRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWPpsaZr; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWPpsaZr"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3965683e9e9so3183530a91.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790724845; x=1791329645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=90vGdgLltOmZQprXn366F7yU1jtNwuxzXIhmT3hWVVU=;
        b=XWPpsaZrC3iyN4IQ5PfJ4Cc9ltb26LLu6wszgkNnPmvrXU6+Di0GFJ4L4i0cizDH4f
         JtWMPGHPRzRQ3h2EJzu2nY3DbdZWBWhwPfUcvkrBjIfHli0wB6tVMten9EjGsa+BjLBN
         tl/MZwyIqL6bgos3xZ2uNHQKRLZeVPBHy7QV/BWEeQP3CDa5Q7J87vHOcY+v6qONuj+l
         kTkqQ4DXuX8ZlM2dkwdoziTMQzSdkOCmp9qN/ynaMX+CBVt3quEGMsY2RtGAzA1h0wpO
         nqc07ksW8m7HxUlqhczw4pWy4aPay4dmksMhAZsUNAo/nLAa1+vxwbVqcFj/nQWy08rU
         LoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790724845; x=1791329645;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=90vGdgLltOmZQprXn366F7yU1jtNwuxzXIhmT3hWVVU=;
        b=QntB8cjF+waMK1oB1ATT0dO4tzL2TEYmbq5iWKfkdF4sMfkSes6iK4atG9Vfmfc9dV
         zuK4UeUEi0iTWmmGhmoJeKH5xw+Pe+8aVLLm1u17/RWFxEugDGG0eEMFjLDinagWg7C7
         NCjceTHE/rHG41KqUw5L+fOzAZxImq9B9sHKsjDwfXr6CMjZXa5YLHoz77XXOhXS1gYd
         7TTvUd1A6ZypqM0Pa7bpHPUpReSua4YSrv5QxRBztmPytJvZ8b3n/0rNtOSTFUwJAoiy
         TeYP5JqFGwnhZFhl8l7Wz5KtTvTFykVqliDnuqBBc49Op8Of8tGou4CbI+8m7p9mLa8h
         0MKw==
X-Forwarded-Encrypted: i=1; AKwUvBzO1QxaQsfCDFnjQWY8Pdo9rl7S066DbQbQ1Vw0G3XlNw5oOh36sBCFzdwLX30kgHMDZBo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrH1vlxLKX+woIQlktNloM+8qggLfOJXt8pgvGKgI25n7IiSUJ
	SDpR3QEy+agfHxBLsTptbEYSMujKp87T6pTt853oK2oi5c7uX2n6jrRa
X-Gm-Gg: AYBFou3uqbA+/yd4p//S5tjkxRyvBGdXUKBp3Qk1U7hqbh2zYTU7ZkMQOdY7SIXbNaR
	o6wxSMt/3EshmJ1tY9Gdod5qDF0ZI23sd1Jdr7kuMDr+opRw6lI6uEchoDATIcUOkP4r0fY5ZLD
	ZUZ72mXdmemp9Z4zGW0ABxjMBGWsTR9bOIhCVDcmTS6dgCZPKMLWq00dmbXews8J9X7qMPls6YP
	I0lp0sNdw+exIhSLiCcb1zhNKxvBFPAantUJXZkZhcTKhCtvKcXJ6paKP08yCvsd3zYoPLqedME
	Bpb8UnHY5MIW1lKnYCrAtSyHRt8hpZh1W9Mkdu37RvsXDzGM6ty+Lm73NsDgxgTBNID7+IjtGC7
	cU8u6doGLW7V6elpikrW7viIMLm8tCNK5wzS5L7mYecwj/tVhREq+zPfYWeyZNZrs8q8mhmSMx5
	b36cTsvL7/X9ce+xkgjaaWMeip43Rl35kbjJ814T+FUmdU3WtCGiLwc2iGixD1t5b6
X-Received: by 2002:a17:90a:ad7:b0:3a4:c673:7649 with SMTP id 98e67ed59e1d1-3a4c6737775mr195074a91.21.1790724845069;
        Tue, 29 Sep 2026 16:34:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cac131c7sm163775a91.11.2026.09.29.16.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:34:04 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:32:08 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	hawk@kernel.org, sdf@fomichev.me, emil@etsalapatis.com, liuhangbin@gmail.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	aleksander.lobakin@intel.com
Subject: Re: [PATCH net-next 1/5] net: record XDP programs propagated to
 lower devices
Message-ID: <arxKZIebRaEoMsN5@devvm7509.cco0.facebook.com>
References: <20260928223648.2739371-1-kuba@kernel.org>
 <20260928223648.2739371-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928223648.2739371-2-kuba@kernel.org>

On 09/28, Jakub Kicinski wrote:
> An upper device installs its XDP program on each lower with
> dev_xdp_propagate(), which calls ndo_bpf() directly and records nothing
> in the lower's xdp_state[]. netif_xdp_propagate() open-codes two of the
> checks dev_xdp_install() makes, but the lower still looks program-free
> to everything else, so the checks made in the opposite direction miss it
> entirely:
> 
>   ethtool -G $slave tcp-data-split on
> 
> is refused by dev_xdp_sb_prog_count() for a device running a
> single-buffer XDP program, but not for a bond slave running the bond's,
> even though netif_xdp_propagate() would have refused to install that
> same program had header-data split been on already. Binding a memory
> provider has the same asymmetry. The lower does not report the program
> over rtnetlink either, so it is invisible to userspace as well.
> 
> Install it into xdp_state[] like any other program and mark it with
> xdp_from_upper, rather than tracking it separately. Every existing user
> of dev_xdp_prog_count() and dev_xdp_sb_prog_count() then gets the right
> answer with no changes. The flag is only needed where the owner matters:
> bonding reads it to tell a slave's own program apart from the one it
> pushed down, both to refuse enslaving such a device and to let the
> bond-wide program be replaced, and dev_xdp_attach() reads it to keep the
> program from being replaced or removed behind the upper's back.
> 
> The lower now holds its own reference, as it does for a program of its
> own; the upper's per-lower reference for the driver is unchanged.
> 
> While here, refuse to propagate onto a device which has a program of its
> own, matching dev_xdp_install(). Bonding checks this before enslaving
> and before installing, netvsc does not and would silently replace the
> VF's program.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
