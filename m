Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942703FFAC6
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805821; cv=none; b=GfQkQDHgDDdewISENAXMXBVWKMx+38XhmldpGlgpbyDBLVALG4KHg5Bl0vayYq95Oihy2X0qgiearpV0UCn+tm6dJWJqosfzrWXiAcXzKtjaTqZL8YbUZAXgH7GBrZEeOn82fFAzynbWHtIeAKNH9FcjBSvjGnQlJl8G9SaGfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805821; c=relaxed/simple;
	bh=lG0SD9cXN/5Qk4VXl7q4UfDEDkoq1CrJuW/0BYgMDBI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgwPPrAKgkt7lGNFg1A+kcCIG7gLQIPmvUDJ0my5xw9/LPERdVCFzftbCxFB2FZNzEdjZqAF9g1GR5i0shrjTjFUG6PG7DkxxD4zt+4HwtKk2HjY/5fo67yzQu0HGahPvt52wBCTLSbGsXwArhXAyiWwVcO3+8M1zC7X+2+C6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl2tuid7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl2tuid7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so78353515e9.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805819; x=1780410619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T45Ou7ZWfmCD8W0zzIfAADcxBltvQlyL9M3hYTeHQiQ=;
        b=Yl2tuid786He6HnhdbPNKhrRGdI1UMgasQGDrBjAAsCvNhO5FG8FwHdjcJIWWDcswY
         s54rxVS5Z9lQBTbqVaBON6ovhqAM1Idgpfriii3a2S91vDbbH7iWobZMFvS66ef3u6Cp
         kIlXlgIqfafHUPyo13XoS838bDqWDOiR0DJsHWzAXJnt7s7/q9BSHGGahWiZk648e+yT
         R0xlhOOZPEpjH3C2gs68id0aEdhlqBrqKW976ctzhPxCQuBYV3zqJVlsT/GA/f7WrFpe
         PAANoydgc8v+kOAk+XQpCHKZ+cg+d8bRIsx1nCTNUfbnu4ljZXSyLeUohOvYkYqaSwF4
         ahDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805819; x=1780410619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T45Ou7ZWfmCD8W0zzIfAADcxBltvQlyL9M3hYTeHQiQ=;
        b=ou3/xleUNihcF0tzyabbWLk2U3MAiiMOcbiNOXFfq2AOEEZbluPBdt9MBhByFvB7ED
         fDNH8WI7xomNTt5KyR5zUTC+nlmw+PlnBaDvO+icguKzd46eHVtBwSEXfzLRDQFFyxOS
         Crv+tdSIAWZqdHkHbgVy9xX8fu+yuJBWHj/chhMEg8kgyUwSaFy6aRmli+dESTx+tMWx
         FbHKIY82n9A2tZZMS2J2q72wk2lHO0qC29AxWW8jkZr9y7RYFFKjXv+7z1kA26cTdrsM
         cLbM5JFxNN9Yt/Uxxc8kLHqfTWX7HCYlRLjVoUthK512PAhZvTcGe+wWaLDWT+9adGi6
         CGGw==
X-Forwarded-Encrypted: i=1; AFNElJ+te/kR0JGrHyQEOPSZUAqdv5misz9poEvNGd74Qupbb7bw93zbsI2JAQXFByksNM2hT3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCATwzkL+6zvKi9IKzccNpRnQKUG4/KFK+tWzWc31lDsSnCQnc
	Pi3EQH07SyzCFsuZig4xef97wyJI9AkKEDoqR6PacoiNogk1UP974kUK
X-Gm-Gg: Acq92OE96/rdcF14eHQ3M8V1eK9r5q2eAf0mRAK+IckmX6Gt8rB6r169eSJkSKYvuLC
	L5LRjNBHKGO+aFYfmfeHjnyO19cIxAcn+OJOvkI0HvVg9x3Dk2m2ZMcJbkIJ7Xcrnlm9RL2gzYN
	bWvZyoSqMnO0Jebbwi1DTljpa8WsfOwlelrAt7HZt6sAUAJgHHpQWypn2Hj6xAMfnbGYfJQ4i4p
	wHcnzyCIye8537TqPIgC1MjVz5eusITs8Tp1ujOzmuTt/SWORF2yAZ8YOF11cRjlBhwi2GmXmQN
	dsK30v84xZ4BzC8Tcxhm/2VzdveFx+XV5x68RNAFUo/k/+T3MtquckKvvF05U6gdRuQZ8+w9R3y
	C2Z314LeYCIkHjRIv2J6D2qigcm++rCogmwwdT7lIbjjRyQIZhFMHmAuq+cmd70MyK4/c0RzEam
	eyxQgA8u4/uBAFkePQFG16C5o2Xg8=
X-Received: by 2002:a05:600d:6451:10b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-4904249d11amr228458775e9.7.1779805818565;
        Tue, 26 May 2026 07:30:18 -0700 (PDT)
Received: from krava ([2a00:102a:403b:6530:533a:f167:d705:6aca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428e5adcsm124007855e9.21.2026.05.26.07.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:30:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 26 May 2026 16:30:14 +0200
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [PATCHv3 07/12] selftests/bpf: Emit nop,nop10 instructions combo
 for x86_64 arch
Message-ID: <ahWudlB0zTRvfBE6@krava>
References: <20260521124411.31133-8-jolsa@kernel.org>
 <20260521132121.EEB4E1F000E9@smtp.kernel.org>
 <87bje277zf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bje277zf.fsf@cloudflare.com>

On Tue, May 26, 2026 at 12:58:28PM +0200, Jakub Sitnicki wrote:
> On Thu, May 21, 2026 at 01:21 PM GMT, sashiko-bot@kernel.org wrote:
> 
> [...]
> 
> > Would using two consecutive 5-byte nops instead of a single 10-byte
> > nop safely provide the padding needed for a 5-byte patch?
> 
> Perhaps worth clarifying that nop5,nop5 wouldn't allow us to leave the
> CALL in nop10 tail after the optimize/unoptimize cycle.

right, also we need to have single instruction for that
to have some assurance the app won't jump in the middle

jirka
