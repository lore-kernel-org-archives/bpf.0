Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB0E4ACC9A
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596438; cv=none; b=sTbFfeZp22E6sF7XEJ5jyhHsjqUhHMy7qaFeyMvY8EZFOnwcxHXw50ssZr3v6op4zJFrgDG9H6HBXqs8knK9+i/zJmVXr+A9CqNfVJbdHvIjGPil1di1rLBFFFPIk2Z4cHhJQqJ9epTqCm7x1nQ3tRA+4EAAjtgqixOdf4yJwaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596438; c=relaxed/simple;
	bh=4P22437nuX/cuV9pPGVJnqGJLPfVSiARn1ck5o8LsSI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1OBn2x3ouhMnEmibAprtr57yNGzY+CB+YAUKOizHGStInhwh6bH7D9fwpozAEpe1svdnmDqZvffhUBngm2yqDKsqlPrCXIphY0gP8bE9sKf3M3WNot0KASH9W5vnd2Kq+0xpgmdYR7ON7wtGISiJZM8Bb8tkALVAqrCcUmPxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkRL74uS; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkRL74uS"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so1221295e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789596427; x=1790201227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f96Fshb8UdYMP3A3f8B+8ArYfxBmH/uMdosKkxpkqxU=;
        b=PkRL74uSrZQ+hGaY3EOZd9DDlAlRLZAompZp5NjDtC1czPZRo4ug0O0fV5rUsC3dsJ
         bsp4K9RGOBF7Omc2NT3PmyJm7TNmeTvu/DXVBki5kV6NDiZgZZW89WjahGC035dnaMg+
         FsxBh85A5MGaslMoNM+wqfU95Fz5JStRJoQv71KEzuv4gODGYjVwUKv5d9n8wSoUZCb8
         CpphlmYkaR1dTmT149nXqE8fQ6HXMcgYNxPp6bn624x3grj5zDkx/EXP5iLIP2BLRHU1
         TgBnKksa1U1ExSr6xahbsKvDaZyNAxHr8FH3xGXnHW81DjIYJtVZytgVe21SuaVZG1Il
         trQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789596427; x=1790201227;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f96Fshb8UdYMP3A3f8B+8ArYfxBmH/uMdosKkxpkqxU=;
        b=Tk+VFDUBvkxfIBRDw2gQ3y8BGAtkAy+N5vMfhmuGwkiTxE8cxnDnoclVFm744XZibW
         wS3JQ3klrr1B+PW8eyhAB92I+dFC7O4PUdJRwLzpM7wdp83dYMqBoeyutTdDZHaibv7q
         bwqu4Peff/LYiuHZMmkDmq9uZc4l7oHdGTvFUXBmRk1Nc+SUteHeJek0umDNVPMS2JE1
         8NF9UUfh4jHJBZS9LnSdHcg7wA1XLysrvjO6qpiCBTv8xBlRCg+GjtnpczHUTj585SFl
         EzXpO0SmrMCT8XUdb+IedmeDR3eD5dEU7JFINh3w9jSz005XuZoWC2geWS246uI0nEOq
         dVbw==
X-Forwarded-Encrypted: i=1; AKwUvBws6gXr0iu/PcV2CEuPXMcHW1Xca7tnoNVwTa1qZl7no/IzOfCw2rG18XJp+hB7JErrNbU=@vger.kernel.org
X-Gm-Message-State: AFuF++mQZX2kC7elEyeSxrwywO+POl6rAzKmOU9gU7iLebvWK2yFBYpQ
	j1yZLI3hwDScOiNxTLVF3dCN5QjIYqDTQbT9x81A04maHAsMD2zWHqUw
X-Gm-Gg: AYBFou2PTL+fYCPjiOD9yElDpC+RKvvHJ1GqQhscanfK5HWQ7ZxkFdEjNhBsJSns/E9
	enxX5Woayk30AkF8evVHid8eKwhzEhim5/OhiZsnH+p/3k2dA5g4UDl1DjkDUITP9Ml5I5Fm8OI
	27E8MX/iLikwk9gJvkE/6LxgiyH3jJ3fxvdJ41aHWz4u4s4IeOr4qf1MyugwCqidZvOU/nUk4G9
	XHJOxjpMMwXacdt5nrBa5bp91ZK3u6jjNdt6dDHkZpGhx+75fDS/djUcccBK6Lc9+p3DuyIBJ4J
	ZJAIZOOlpF+nNwpi1SCJqJnrU3mQTwxWV6phUV2anWrhWXSZIBYVs4bvXfVACsf7usbN4dfj0/E
	d8MrNfa32x7gCHmy0Ywxz+I1y84kUdyX+fER4vKfs/RlQhUmOPBYssc9pcgXOum16fR+lrfKF0R
	vWcI8UqMbFFsmQps0GKB8C1jAusmYTg+L3/H3FlhcTxKAN6SfDH73Qzn4BMw==
X-Received: by 2002:a05:600c:19cd:b0:49e:6c11:c4fc with SMTP id 5b1f17b1804b1-49eb72ffa35mr98912715e9.7.1789596426532;
        Wed, 16 Sep 2026 15:07:06 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd24a6basm23004695e9.12.2026.09.16.15.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:07:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 17 Sep 2026 00:07:04 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	daniel@iogearbox.net, ihor.solodrai@linux.dev,
	yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
	martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
	bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
	yatsenko@meta.com
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump
 LOC_PARAM, LOC_PROTO and LOCSEC
Message-ID: <aqsTCF4uGmN5SlZD@krava>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-10-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916074118.1007116-10-alan.maguire@oracle.com>

On Wed, Sep 16, 2026 at 08:41:16AM +0100, Alan Maguire wrote:
> In raw mode ensure we can dump new BTF kinds in normal/json format.
> BTF_KIND_LOC_PARAMs are rendered as strings, for example a
> const value of 0x2a and a dereference of r10 + 0x20:
> 
>   [12] LOC_PARAM '(anon)' size=4 flags=0x2 vlen=1 values='0x2a'
>   [13] LOC_PARAM '(anon)' size=8 flags=0x38 vlen=2 values='*(r10 + 0x20)'
> 
> LOC_PROTOs render the associated values of each of their
> LOC_PARAMs for easier readability:
> 
>   [14] LOC_PROTO '(anon)' vlen=2
>   	type_id=12 value='r1'
>   	type_id=13 value='*(r2 + 0x10)'

nit, AFAICT these are dwarf's registers numbers? could we output arch's register names?

jirka
