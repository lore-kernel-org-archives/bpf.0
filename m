Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892259;
	b=fl/bwZwy47z5EnXdFy2QhogrZ2ikXrAwnt/1nir8OddG3SCXI8txuMNvS+WZaOE376z8
	 /xQ7bvZdu+pUZhoAE4C16EPCsO05kHfBpk0kJPUwRLOwZI9TQUL55CQeaCUWCS44/yGPq
	 OJto2fKIF9XXfefSiX4sH9YRjfATvYU5MkbapAjzUpvZCdG4t6OPmEw7zT9r87Fih1hKy
	 sHhAFP6kk9ifn0X5e3PjV1XXMfpr63yyQuSCi1+uDtBOg7ZieMF/k31Ipc62LhuS9bxqe
	 8dr0WcKhiltEzWYQ/2ygByyXTwCM+vNbLhJczK81wEGn8Itw4nDraLjaHUTV8kNf7FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=W4gIrbBqqGETUk5+tbhvCUCWoRJurZ/AOQlfllVrCmw=;
	b=Ozrnkya04s9O/7KNC0tOFJ/t1z9SG8Z0qLzRhkC639OKb4iHCHGqItSDFfEbG+Ng0Xej
	 RYlUFdA/1Pvlvio1fLHXiWgbTuXAtWXC1BkIoYp/xLl94JKEnGNpRq4fkErslhiVks6Hi
	 UYZbgfhu9T0Z0AsM30OxKoDbGRbZgBiEKY5Dqtq9DwCWjcoDpoSRp7mFPWroPzVtfLwPK
	 ro398kQPelIZKf9mv/wMu4nPYp1qw0RJLw1J1BjgqPaHnDuMsE1X3i+B/ZfxzBbzf2dkk
	 Kvd7aH8CYC7IHNM3yShavppnF4+jSu+m00oE/O24GKVpBYdyAXF6pOpSKXJP6kzQ2FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aopwHs8L;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9A606A323
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 05:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39A9A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aopwHs8L
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc758830601so3921372a12.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 21:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794892258; x=1795497058; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W4gIrbBqqGETUk5+tbhvCUCWoRJurZ/AOQlfllVrCmw=;
        b=aopwHs8LgRJ3mBsJaJv0DxIl2B8qllLye4JnbsuNtX1peqS7pc7cZJ4Oq7b4K4h5Tb
         ubc1TbWOgq6uRhUO8Fq/NQsV/JeYBhAkjCZiExAgSAzPZFzRK/1THZTjCwcE1xGCB/Mh
         +7MAzGFkfgV/AQyLytSOm6RuCo1yrTq8ENiO/Nc2k7Fy5I7YW0UIGd//VDa55nWFK6cu
         o8NFQp+0Vhd20qkO/0wz3WTRbdYQoLh0REBaB55tJzOPpCHEADIdOPejj1+1Hhhqtc52
         UMQ9LjOAYjgcnXr2tkeu0l3DzY11SRRJjc2ZUbKlyHlgyC+YMOMW/nI8mda3Ns9fHv7L
         6Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892258; x=1795497058;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W4gIrbBqqGETUk5+tbhvCUCWoRJurZ/AOQlfllVrCmw=;
        b=kV8ks8mc0BgHtqEMHfi30WqldY8UKU9GJ0NxJsaWoJxntYcmbMQZE5ShgY29l3+3GV
         vkMo9fdvodgpYDOT4PCNExrTTqkoTEVXfKZ1cCUyJrPNmMqkFe2BKEFVubW6g6aqHhZw
         dFuhYnRilIvF/btZYQ1YSGpdx4PJEzSBKc1eGBdD05EBg+LpUKJdbf/ERAVIfyHTZgTY
         iTbcuN+fb0vPlNWoLGeYg1+DO3IiAxPiNM+wX1Is6Etd1aWGkMuuUKP8OEb2PJn+9hid
         owVRLgEACwjae4QlmYC0aBgJwzS8YVz4cgoMcoOi/CMxwd7yKWcp+r2li9maY+uGPymF
         wLew==
X-Forwarded-Encrypted: i=1; AL+hErGaH1odNZoA3kFuGy2kE68hcH/U/RvZ96ssjmsCDtr+Ih0+ozivToC9ClQiaf2F/Yt5Y6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5fcjzTKHp3O7TRGFHmDKN68PhK76TAlEIltBvaByCNc6FDuC7
	t/cHes1L3L3aEvI8qOg4H4d1oxp8mMmMJQpYCYl4iSa//L2JgAMSPSyQ
X-Gm-Gg: AZFdTZfXF1XjaqPyQCNEE6xw4nghRW+QOIAtYUuwyE5SQJQTjN+KNSQeI2T75EgcF/U
	IcAti6IFkQrnOOV8bGQpSEkg2qoWV85OC0wRsshEV4DQTpFRtlOUCMqoHsNDEzWJx2f6jBBHf3b
	XrZBpshH1tfAlZV6ZfTgHZJI6Wb6NRoRtjzfqMWpnUcGiZnyiueGp0LgCxdUE8Tgd5jPbVJyoIv
	BjztxZJefbsjB58fiNUBKXA9lXmzDTvWnF32bQrAGjiHpkq/HfyZ0vE3r5juwjJtW6GNBZif1Up
	NyDsmp+uvc2vaekplkI3N/N8vUJqUuNtBp+TJ+Q7l2Uoma58LLsB9Vj8TtbLWtHtOADlP2oAva4
	MqiwaV0x683blYWqgejP20g2UUo0zzMeVybFCNaQfzJew8hMoNI3uIrU3jVQzo1oOwHqb0TSczB
	15BJNN5yN8dq4ymPSKlJClAj5FrB2wN1PQtChH35doiY5b1QyU3lHC+vxBGBX+73QQjHNd/Pn8B
	BvyPxAOojJsHViV7LshzdWmcIllRzg3wpry0R3y84H7g55y7M9Lzo+XQDoMYE+HHnLlMI3bCd5g
	dtoZpLq8XQN9zr+B5XTbC+8n8+MWl0iK6b5DkyR97uc7NdOkAaQYheQ0P+xAfxAAsjCkH9TbAuA
	PevajuyEVtZLreCZ+wFAUOp9wSzGYvx2JXw==
X-Received: by 2002:a17:90b:2749:b0:3ac:7c52:fae5 with SMTP id 98e67ed59e1d1-3b1b0cfd813mr12141538a91.50.1794892258359;
        Mon, 16 Nov 2026 21:10:58 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde0e3277d1sm828308a12.17.2026.11.16.21.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 21:10:57 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 05:10:57 +0000
Message-Id: <DMX87BV331FW.XJL0Y10TBDO2@gmail.com>
Cc: <rhkrqnwk98@gmail.com>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <john.fastabend@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] Documentation/bpf: Update sockmap docs for
 mutation restrictions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ahmad Wicaksono" <supersonix03@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261114170117.196552-2-supersonix03@gmail.com>
References: <20261114170117.196552-1-supersonix03@gmail.com> <20261114170117.196552-2-supersonix03@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Nov 14, 2026 at 09:01 AM Ahmad Wicaksono <supersonix03@gmail.com> wrote:
> +.. note::
> +	The verifier only accepts this helper on a sockmap or sockhash from
> +	``BPF_PROG_TYPE_SK_REUSEPORT`` and ``BPF_PROG_TYPE_SK_LOOKUP``
> +	programs, and from ``BPF_PROG_TYPE_TRACING`` programs attached as
> +	``BPF_TRACE_ITER``. Other program types, such as tc, XDP,

This already not accurate after Michal's series narrowed BPF_TRACE_ITER to iter/sockmap:
https://lore.kernel.org/bpf/20261107-sockmap-update-limit-iter-v3-2-7c0bad1ad036@rbox.co/

Pls wait for bpf tree to make it to bpf-next and resend keeping acks.

pw-bot: cr
