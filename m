Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794495328;
	b=fxyXijOBYbDQuz3ngMQMgDquTJhDqMws4GLgNSaF8YmrMkyGGhLUQctz2eO3gYTgan/I
	 um1V6Bv+W5kBjp4WecImkarGGzyxlo18RRcbu3TWrI8pd1/9wr238pT37W2lLzvyLB3BJ
	 IwrA3GuLzogaAKCEegmkGuhQGvqpVsqNelz0lhPPpvtmWxaV+Y1Pg5yXcl3N/39uUBNXg
	 H+u0V0eMP38+8J9rFJfGLZKBgLn5VYiV+66gPbS9ahCsbva0Ep7NhREiaofV9UKuQnf4r
	 pln0cME01KZWw3+YGLPOvWzkMUAzb4y9hRClFn2DtN2tNP8RGSsP7yMJJH+OCp5JNvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=vwPTmyMvNhiyDg4UslxzJuuKVfCT6YaQluFzq5V0j6g=;
	b=OmZQKNW7hvEBQQ1Mktmv0aGFTsNIVInFNi7+DKhwNXuGJZoxo1E3gImJtlTimWapPZye
	 7s88FtjAgGzVlXpaxvxhw6Av2KYhIGqr0jWurqcXYkctsQSbhRC7fkRTdb4F1zxTamEu1
	 yffV+IDrEg+G8OrtFDR0PYh2o1drdGsIh2r5HzOoGkx3VlicuY0kRwsX5T+VEBiGo/pZS
	 aXP3pfHQ2dUVfyFQfBKTbTkcOX8LAZNOZNhIQCcHr5OfI/bxfQnBzz9nWaASLJHLN5fu5
	 NmjcA2u7kvafko5CimJTE24szVXKstjH1OX5dMgfTMwVMp0ODBfJvoZjKelLnPdYpNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=U5KQI7tP;
	arc=fail smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7991C606A327
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 14:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7991C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=U5KQI7tP
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6f74f6b46abso1950721eaf.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 06:55:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794495327; cv=none;
        d=google.com; s=arc-20260327;
        b=Q9vHKYWzMDkC6sXw4OTa1BzgEkDGYpSS110VsT4fGyVBT/PO1DKYPJYd3ShTKTJD2p
         FEmPtjlkDZ8AJzLnJOfxObGT6An3qPoqr+tdNLwZI4VeJ2e3zniTx2bNikz7EsuWyntd
         9c5f+0Wuzz4fHG33roMAeVTvmRSisfc5sFQqNawbiYsYfy3CUZDEDxqNbqAeKa8W5lpu
         aLGwTTZiVJQqsKzAUor7VWlLP2LpaX/hJPwHAfLdtiGqGuBjfZ9MnApwpqxS0AoRieWf
         GakBsFa0fGMbEKrKYqtRwrEHU0s1sAcW2KtVTc23HHTSVXV9g1nEN5WBmBoLKi5hHWVN
         cRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vwPTmyMvNhiyDg4UslxzJuuKVfCT6YaQluFzq5V0j6g=;
        fh=F0GIY7RErUIGaSXf02/sJ/iKytsNHZVjc9wk8+UHtmI=;
        b=c+4iezoe7nf68KMMmQz6K7+tR9WP5VnhSFbd1UmgrARhyMDjbXo3SenqkBKkElkltf
         kCSGUnEpQonOYM4nL75JBqnc12TellUf3TGyi9Y7jTRr/lZeg+6atngtOsP4PjgF6yTY
         vqOdhXKxhuuSrK+VdnBdHiq9zJN2C71qlWNUoNbpW94eESiLu9xh8+X32Z907DXJG050
         rin6tNHxYF5hR9Z4bIBHVyPRDi73edXpDOw4b5GvhOaJ2+O/cMi5fcBhpV8MXW7oEzs8
         xhphlpv6ix7U7UG/elD5yrSSOMHpc8mRUrEjfzT+itgFhsQ7HHxgV9L/vQuEJ0g+27+p
         SVUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794495327; x=1795100127; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vwPTmyMvNhiyDg4UslxzJuuKVfCT6YaQluFzq5V0j6g=;
        b=U5KQI7tPQrZmVs2O+/K/2qinNoIrgmL+JN3JGy7b9UiDPeSLDrYZUz8m3+Fi+GmK4d
         FPhVPTsRS15yE/k7GknytYpWAG6MwHXBIIKa8+5OUMRQdlbNuFvA+ep3tr0dGAEsUuqS
         a+qAoHXBep9HV3bGKKYHTsPNJ9pBthMfNLk3q0DuYIG3pLV59xn/MzPe5hgZKfRheDNT
         6JXrnL43z2Low687s4+keArBSR7IBzhVjsWA3Ig96aNpRQIwExEY7RDDcIQ+BgeozV2b
         TQoClntxCegkGq8td3fNEFFkUr2rZefYM3k1Tn1u2EN6NmmUeW9xJMDbZ19emN/tNOTo
         3cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794495327; x=1795100127;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vwPTmyMvNhiyDg4UslxzJuuKVfCT6YaQluFzq5V0j6g=;
        b=GUp9LCSj76BRdXjpG8ZJkQ7Wv8AKhGj49hZiHRUgb92sAtREbQIrWfL8MYOKIBcWYP
         SCCYXYqRNx2HTLJYK/i4jTTpSZYJ+HhJi3BjcfRd49TOjbfR0baUnkQKaHIhAOH2kJH7
         kzKgZHMjbEd+Z4TKT4miqYWWJSV7htKsvLsrwQJy9Z/CPi9ryxbKS/r0/eeTxpQZbQhJ
         1TUTAvmfKw5Lm9Z9neA/fvpS/SQMlXMF92QNUwNDSQVyetzypsREw0sUVm5Bw20fLASG
         XSB23dr+JEhBDkoLFTw83U3X4LK6gXaAL/4CccBNiPSmB2J+rtxKl2KPjaeeQG63Nxfz
         Lu2A==
X-Gm-Message-State: APuU4Z/rNSfObaQaboyTZ4y1PDqEv+aoHV/incXd8MSu5zvnRuu+ngAU
	ifnybwp/8XoL03T3aOYaYkm899Dhtjn39S2sgM7ZTHWpl7govFbhBjeZUSirwiRV7hIZ43qM0VC
	eJ3sJI/Ey6p0PWSQTxJLt72lyJyuIiJy06/iGqaaV/A==
X-Gm-Gg: AYBFou2YO3qoflI7fQR4N/pjhAVRc0M1DELf4fMNeneCYMECKJgYilDUsqbzkWJxywG
	mbdlKuhfJFc9Vw71LM+0Cytw3Nj7NRN6YZKmeUQqlnO3zBFw9f/rKvdlX/fkX4mWlw0LJTThbyi
	89KB82PmE9z7rJZcWtVb2lFT/Ay9ZA/mw9zOPJiNkQc5eu+K6Iqtrv+ANkRnSLtNZNMkOJXSm3y
	Xo1v70G6CKHyEESo8U8iN+aB2r8aaUxTgE9YdclgoTE+QBGjBl6l479AgPDxUvzWNVnr9k+nshj
	sSxy3KyIg2ewLJls6QGz59g3+W7WGpcpj4hb4za2W70TWzRNi4DcXxNArVTiLfYabQmo1cFngPK
	4K+UmEDOwq7hMZ2DBMxuoqgW2xvqMeRbJfDeNIQvuUyVji/a5Jv9sNUD8Y8cnFBa+ySHfyNVEtw
	rwPPfA4wtvoQ==
X-Received: by 2002:a05:6820:a50f:20b0:716:bb4f:9d1c with SMTP id
 006d021491bc7-719179b52cdmr2435932eaf.70.1794495327350; Thu, 12 Nov 2026
 06:55:27 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com> <DMST78XBB2RK.2BKP3O07GEWZQ@gmail.com>
In-Reply-To: <DMST78XBB2RK.2BKP3O07GEWZQ@gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Thu, 12 Nov 2026 14:55:16 +0000
X-Gm-Features: AclHuK_osBWVQK63DcE7gK81kaRbLSav5BXe8bL_6Bp3W1Mewum9RV7hacJBHqc
Message-ID: <CAG4wq-cXJtTzG2GO9KTL04b=prS+X67fRBJ=nriOO0G-24Rjzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Vladimir Vdovin <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Chris J Arges <carges@cloudflare.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	llvm@lists.linux.dev, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

Hi Alexei,

On Thu, 12 Nov 2026 00:34:54 +0000, Alexei Starovoitov wrote:
> I'm with Stan on this. It looks heavy.
>
> How about the following idea:

Thank you very much for the patch and the idea. I really appreciate it!

v1 uses the skb_ext-like layout mainly because of the earlier pushback
on a fixed struct [1][2]. This series adds only the three most commonly
needed types of RX metadata. A 12-byte fixed struct that takes headroom
only when any RX metadata is stored can be a reasonable middle ground.

I would like to hear from Jesper and Jakub before I move to v2.

Thanks,
Tianyi

[1] https://lore.kernel.org/all/20250805172831.213ddd8d@kernel.org/
[2] https://lore.kernel.org/all/1d5521eb-84fc-4417-a3f5-6366694d160a@kernel.org/
