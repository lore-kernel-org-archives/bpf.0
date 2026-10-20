Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792471467;
	b=5i5BDvxUTg6phv3qraj+C+l5LWcu3XEvMRbvC+0SesOjG2jZd+ElyKeiP3n0GGeNqZ3+
	 laH2TlngfiL4dbFdaD2WipACvLfQVQPRBlpj316bwo0i5WPkB8a0bELTHUq7i/SifeV95
	 Q/Bnsj4hhstj+FVWjWxq9kGpD19LmdPArH+rgQyyx06JSdTqXeZejZk8owfHzmwweo/uf
	 izUuEeXJ09sdFYHT/kWpSCuQyZVsuYp5Ob4viQk6vnoAnAkYbMkXy0hOFY4K2Bep0qfH7
	 wivjf8X/jSsvfuXkeUaddnCMV5pD1fAI6vLUkBtMdJ0kDnBae8xMHRkBfwqIhfASp4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792471467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=UQmGxlGdn3QZ10a+N3kg+/R2AQD+k1cxjSIXOj37hsc=;
	b=lN6ngGYrA/M68A04MzmLVa3l2I2LBhJeztzgmJuchCJTqLH++Q7l3m3bcPQ/Beo0e4a3
	 bvQwdK2a88K4V+FyOpLuy5H+2md/lE91B84OrjE5Vnh95f/aAZMmjUsjrWje/yYN1DLMg
	 LTOI1tnpjRs45Ncufs5mGgOseECDbwO8FyuohFbiAV8lV/rH6NqIOz7xhdqFSyBQTDn3I
	 NNZ70/SIsm01K/DZMth+vgoOG2v87v38bC460BBbYptuSVlsB6f5JXpdttEQat/XU1tR4
	 7bxSoO/Rim5l6maheFcaiKCIa0wOrstYPrpN8mnh/VrpFPnNKBB6Yl8k6MfWz714lBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=raISaSLF;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62BD606A321
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B62BD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=raISaSLF
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a01e2962a1so2879196b3a.2
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 21:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792471466; x=1793076266; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQmGxlGdn3QZ10a+N3kg+/R2AQD+k1cxjSIXOj37hsc=;
        b=raISaSLFvpfJhhKXTctmI2ZoD6G3Nx9qTuIBKW3Zmxc2Nkb3Bq+10xSuFAmKT5Nn6y
         My8vC/xbYO9YUAguV6MXmnMZmUuRIBAJAc2qQwmn1r/575pTZVo5M9DBV2xX3SNZeThb
         bB6hng567B6HlxPS8NmajjGC2/4Ga7Dwm01st8cT7eAlOrNoLmtj27dHnRFhWudCTbhs
         8Na0TmqqS8iLzLnyWvOzkwD4iS1/7IrxiRfjMZ+ITHzi99LvWZ88w7sM/sKaXsbuvNzE
         0M0nn37aYaGZawooUIgjAUB7ijvomLgayI6XxUU/G7qjStlREfr4ggzsX85zGMkZ2h1Z
         iHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792471466; x=1793076266;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQmGxlGdn3QZ10a+N3kg+/R2AQD+k1cxjSIXOj37hsc=;
        b=babEgEgfIrlbYAIa5mThnLa6528+8SxzzRXPmcF1UwiWwM9WH8T0zqFjTEUhULItxW
         8L/RIZNc6gr7IjEI7iOsUgKRrKqgDnHZq/IGUfV2FMFM5rqTyW3eeoe3zr1A4r1c73Ti
         CSJ7pbdJNbRqi7RmH07i5xIJDv8G7YwEr92lhD8Oy1qx93n+Yt8X1W7qt0mpM/Nd5q77
         NEm0+O/Mczt6f8brg/jfdkXqslxepWhMLrHIfWuYFsq8fPGCV/gdqrgwQYtJtOBFHY8P
         E/OWykFZxcrrpxHD0yTNyA6U8+yeODa9JM0aOUAKNQ9/bLJDPmR0yEV7Hqgv/PK2wq/r
         BIeA==
X-Forwarded-Encrypted: i=1; AKwUvBxbirWLzB2WfqU6I5W3gPb/EX0vlRo8PU1oRTPbDp//lI3pKTvSGBymPj2pfFR2YDSpeG4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOYE9svjYzAKSIgXdwTWF55rpXK/MyTJVW+3acr+zTE/g4tkKE
	+l3EZYouxfX3zvijtGF2j4tWu36xeKUbb2jX7N3TEtne8avoOPYijAtbxyknzWmAsa58jxAMntV
	pLMomsg==
X-Received: from pghy24.prod.google.com ([2002:a63:fa18:0:b0:cc7:d128:5a50])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9d8a:b0:3d3:aee4:66f3
 with SMTP id adf61e73a8af0-3e225fea044mr7912512637.25.1792471465857; Mon, 19
 Oct 2026 21:44:25 -0700 (PDT)
Date: Tue, 20 Oct 2026 04:44:25 +0000
In-Reply-To: <20261019082214.102398-1-dmantipov@yandex.ru>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019082214.102398-1-dmantipov@yandex.ru>
Message-ID: <atbxndUiT5qkAER3@google.com>
Subject: Re: [PATCH v2] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Eric Dumazet <edumazet@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Kicinski <kuba@kernel.org>, Levi Zim <rsworktech@outlook.com>, 
	Denis Yarapov <yarapov_d@mcst.ru>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	lvc-project@linuxtesting.org, Sashiko <shodan.ai@mcst.ru>
Content-Type: text/plain; charset="us-ascii"

On Mon, 19 Oct 2026 11:22:14 +0300, Dmitry Antipov wrote:
> In tcp_bpf_sendmsg(), the value returned by sk_msg_memcopy_from_iter()
> is checked for error but not propagated to 'out_err' label, so error
> handling may not work as expected. Fix this by assigning error value
> to 'err', thus making sure that error won't be silently ignored.
> 
> Reported-by: Sashiko <shodan.ai@mcst.ru>
> Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
