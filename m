Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153717;
	b=OssvC7b9p+0NgUU2/9Y5CY/BPrQy7euxpOsof17mxHB4jkWcEwVe4NJK4nBXcaQ8LLEv
	 9BHX4QRWGTRwiWGjJhoFYfdLeTiNmdnXU8HdhdNllKrpmKJ4wIylFcJ21/MwBEw6F3uTh
	 5Zt9TPzMKFkF31do7O68s4qRfFGn6MIN96CQFtEJJYeaDVnhKrqF46Ec/dfh2mPD8HAqo
	 dB72+KolmKmVd4loHtvUF8OClv7DHbrVK9otBIRwsQii/1hiDGLsYogfxUqMvSq9KaH+L
	 I2Mbs+1BGkCz+J0vqoeYAP9h7cXLyZr30ACbsjc0IhI3HZmkPlGbaoDFk6zd7IY/JIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hvomCCgFzWhpYBXa3hhafOnqFJIwpv7L2EVg3Oed+HA=;
	b=cZBCkB9mdIOdR/KCW3Le/w8hEE3XB3IGkrxA5HtF1nbq8YyG+Ja6OU6QDNJfUJKmGKBs
	 NSBWkctyqUmrz9Le26XtMN8NJ4F/iXwoZ+SADt/oWzRkcpLzRzKDPkHEq2meoHZ8vmqB6
	 dk6smKLdjGfSAO4rMS3F1Voc2kDI0hNXykKW/v+7jmel+qxgWY45+W4DSn6wCxum+syVb
	 G3HhIV/2e9M0r2i48niRVn+8t+RyCtWf1gfLrnhnL1z065bjxc2g0auh0lMjJVWRt3ixU
	 hKwc5nFcBzyHsciZDkVZ/j/8eASWld2tQpzfeDEPMiLir0y+ftD1cIznTQ1iH/5WafQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yvd8aIil;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A68606A323
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68A68606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yvd8aIil
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a611dcb60dso1228535e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153716; x=1793758516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hvomCCgFzWhpYBXa3hhafOnqFJIwpv7L2EVg3Oed+HA=;
        b=Yvd8aIil5VAqoHZvNm+SXebOsK/CtWyI5o/ZuFXlnLMo35L61D9lG4NKn9/T34qLuN
         979tW1IrJMbq6qD4mxlh/pOV2iw/boMDbJsFV58f3OEkabwtGOnlQKJNBeGn8dR8nF/O
         PD9ycrjLAUxWq6NTYb6/rBZ/DHcP941zYsnK5Ej/JMAR0i4jwpXJFGE40V2d+uPFCRiW
         bywIJ0odUzeStViljaMIgeQyRTZj3gsqhCVR7wSxXUCTiFg3GsCbvRDAhcELyPZwKbhC
         xvO4kGRmoE01/Zr3HlOGzIqr4OCwHlqoCixFFM8pX0UCfUIEbM9bLoOHlROROSiRk3Ys
         IGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153716; x=1793758516;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hvomCCgFzWhpYBXa3hhafOnqFJIwpv7L2EVg3Oed+HA=;
        b=k2mORnp2QkhwUlLvOf3k9y3ZNc5FpqZ159XclzjUIRMMcLJPddtEYTVTvEKhxWGwwe
         yOd6Yq3CwSDfNvYq39Xk7/FbeIQ1lD8iEmxHypGBLhLr/V+1hhCEuLCY5p/1YmvjFft8
         ceFiExEFfPlwsezkQ3blwIB2ImGcYbcIEvxoZP9Zckt5eBIm+8WJ8Ckr3vgKNnp6ZV4m
         72qP4lNpKcxoFWup8umpTGocfpO9AjFxr4cZp6Gy0n57heh4QzD/Jkrx7mE1azwPndcI
         nxwJgaCQqhA1jVemglJhF4ezd3Lo8O8KKtDCCHqpjOuTvnePYM6OXIwWKHZIBRPTP+Cv
         3BEA==
X-Gm-Message-State: AFq9FYIDfe7Aj2WO3Jo9GuBCkBV+FV0VSctbfnmu7kMuEnUDtFTEokn5
	gbfshbc+7bKEt9Pzo9T49QuBIaZkcOWzGZG46uuCZDF98w9ZW33IcwOly/ntinMC
X-Gm-Gg: AYBFou3ITWasRjiZLSn0iErshWV+2ip4wIV398ljNAFiMkAVlynij3vLSEYn+Y+WDiZ
	JcsjORKzGMRSqnKwjgFFSeXUsK/7o9VpZ9y5zBCMDvXNuSXJagE4vbSrr280esdRkCEPgpZ8x3z
	PNw/9jDSfBqGFpBHHeYowv/vGBnaccHukkPGzhkNl4Qsg9pptgb9RWXh4F8W3VJ7kSFPG50FaRG
	XT5py55M0+1wr1FBviWTT8zzhLhvA6BM6z01IMgLpKqzwkfDuQ0vqoPV2d2c66Gxb0gUXobVE/q
	zjVB0L/yYzZoSyd183y3Pw+EV0ofpRZRFAn/F1NCj+CI/3vWQcwVWO9lNR6fzS8DDZ6gslZv5CI
	FOJ/zZVnRcMziO5mzsCK4sUKTw4upj8gPQu5CIE6ZCa+ohdLubCzCb8NSrS1xhSIaG7lC56aDfo
	aBJugkN0ssEcdsmu9URJULFItC0Ukzp5ku4mcdivSDsbok9dZnmKnnQTDQtydMEDUPHunza09M7
	vXu3lizBfR9bkYz+jyY9+DtGA9WyeM525tseyO91UHStL4PKjyz9cxZ94juPBxzYLeB7iJQzMzH
	1IyC0tnrLHPpE/LqML2Gk9ok/h1+4aEGB6zz1+YlT4YUKlb5CL9a5xu70Ayb7pxpFBTI0Uwe5PC
	l2+EBrBVd5y2XT9LCF53S38WwyVC39XgrUfRdTH5bNJwBLRHKB+Gkpqd67lOg2A9g0uQm
X-Received: by 2002:a05:600c:34d6:b0:4a1:d675:b031 with SMTP id 5b1f17b1804b1-4a9660b54e8mr16323345e9.6.1793153715858;
        Tue, 27 Oct 2026 19:15:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97d38c583sm9336845e9.15.2026.10.27.19.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v1 05/11] bpf: Let the callback of bpf_loop unwind
Date: Wed, 28 Oct 2026 03:15:14 +0100
Message-ID: <20261028021514.1203900-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-187310@kernel.org>
References: <cover.1793147364.git.memxor@gmail.com> <25728094090d9bf3e4cd88feecec336f0493a5a9.1793147364.git.memxor@gmail.com> <sashiko-outbox-187310@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed Oct 28, 2026 at 2:19 AM CET, sashiko-bot wrote:
> [...]
> [Severity: Critical]
> When helper_has_cb_pad(BPF_FUNC_loop) returns true, can inline_bpf_loop() in
> kernel/bpf/fixups.c emit a live BPF_JMP32_A instruction that jumps to a dead
> landing pad which is subsequently removed by dead code elimination, or leave a
> stray BPF_UNWIND_GOTO after a load instruction?

Same as on 04/11, fixed in the next version: the inlined loop gets a pad
only when the verifier saw the pad of the caller, and the unwind_goto
after the call becomes a no-op jump either way.

> [...]
> [Severity: Medium]
> What happens in prepare_func_exit() in kernel/bpf/verifier.c when a bpf_loop()
> callback subprogram with a 9 to 16 byte BTF return type (ret_reg_pair == true)
> unwinds via unwind_exit?

Same as on 03/11: a callback hands over r0 alone in the next version,
whatever its prototype says.

> [...]
