Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF737C0E3
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777837974; cv=pass; b=M8DzMoGiZDHqIDRReZzDzBaJfM2MC80+QhvU9u4ngDseKT3So5099KJjHA2KBkUI5ZleKJvxpMaIhGBioU7ARFKsvMR/EosuIiukll+XzG35Flr6rSM3j7ankYDUKpv83IUm6igL0Kz7Bz/YVnmV2YfWjExwUKkXlVPPcwww6SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777837974; c=relaxed/simple;
	bh=uZLiEb2AKafZjis01rYd0ydpsrn/wl2hltrcdbVAOV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+QUYC1LolO8IirPJYAx3GYvAHnIKH1iriyfXGgoZwFEp/GevA8K8ja7gbmFZfym8zS0vecs6WHBqTFo0E1jyO8s/nwrNiWPZpSlEAY8YoyGaFWaEwNh8e0FPO5OD8e7IfH+e+U1JHjelYYBhNErgRDmOzrkNeuoVTwtZwWhCuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ4FVv4r; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ4FVv4r"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891f625344so35174875e9.0
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 12:52:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777837972; cv=none;
        d=google.com; s=arc-20240605;
        b=UlgB0lXl2Wd3ae8wdLSxY0SKdBX99Xz++9fP+v5XSlISnzeLvYElM2wDmW6Ao9/QNs
         c0d0wIwnYsSoPr2Zf+l2WjC6EfmpndyfbrZNwv1wQ9mxCbIxzDyV430pTTj2D5q4aDEj
         OEVGdNd0oAexk+fR5GdHZDx7RN3UfUF4YmAUkNOS7YuMRwky1L5lVh+jpVIaGuTdyGpj
         8pCvD61jfHCV3JsUHNJ879eDi3Y0ZI2XShBEfwSsJzUNkWmEpaWRhfNiD446Jr7vMpt2
         3spiHkhOeSYo14Lqrah87FihAV2EN1FhcyXxoAn1IYf/p486V/XpDparqvqk4Tx8RW5E
         ghQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uZLiEb2AKafZjis01rYd0ydpsrn/wl2hltrcdbVAOV0=;
        fh=UzCC2v1K2i9UYTIBc4x4AEuP5+m7u4vko/ZOMSXM+jI=;
        b=QVKQFm7MPt9t1wSkTktShPciOPgdB7qORyLY+7buY3/W17jwUPf3kX8PXNSMcZ9AVf
         a2T1s+3QdlmdUPidkvYtiT5BDXN+Xlu7Oa7z5jpN925bJyumOR9TqIrs0duO4BF47KAj
         QcEQT2AR9tCW9G3Ho+GbMNZ3lFxqdUv2kt3yBAYpE6W2tZbav0gvMiTiaV5xd8ixE3sY
         xDS5yOIEtG8pw7P+YkX9GMbUWBn3G33GWl5+d/x9d6hxVJkOZNanWM8DHoNET5y0UCPL
         N8PD0y+X6xI1xcXeg3MYIx/noZJB24Tu8GdeQs5rqmzZ9tEstDVM/syoLjuxfDL89AoX
         wI+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777837972; x=1778442772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZLiEb2AKafZjis01rYd0ydpsrn/wl2hltrcdbVAOV0=;
        b=ZQ4FVv4r5Mg1K5HQGd7RxnNVRxvDPKvL1SH/j4p2CUeF0l0t63UNAoFSoZjYwmYQIc
         SsAecYuHrtclEG51/DJ3HVgLTis3XiOtblGc1onltM/ebSTNGBjhDJuKBi/+GoLhzOBU
         jm3nI+O9qAL4zXkyfGCKwyck4Slbe0RzHXDzEv0W7UVkTusS9CTetjLjsZ8ayOyitx4e
         ujRxG1jftQhOohBTvGKFTCfxO6BBgfQDCvBLnA0XuZgeJOxm1Z4f8KRQwUSiZrjDoRI9
         XdO4hqGZWgpOL7vb7GApb3XyrQ8C+Yom42isrdOZF52RKEgCvOPBssvPeAMpmq0y8/0U
         RAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777837972; x=1778442772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZLiEb2AKafZjis01rYd0ydpsrn/wl2hltrcdbVAOV0=;
        b=CUsK9BZ/upc3L95wgmmSSthLbNIfV/UFyQW6KA0I2jThxkkSG+tL68lE/S5B9107MH
         wpNd74fygw4uTmLkAAq0EeorEDUD8s9gtyoK0bhO9tGK1WgWU1IbEgmwRNVNq16dZebC
         hNhG50sLlk8vFB5UkgpTwCwGQ3Xyeo1FOabrqfOg58Iti3RcT832CEpFgibvEePmIZWg
         rzClt37QY335l49Trxwj6cVL4QOr2mMXfR8qkfNsOeazxztXxGlMiXO5ajxsUHEOvtr+
         RI59tkPhStXHugcyla6VUeM6JaoENo/TH65yz1TiTKvS5GVI9OUTm9ezO+MjIajK1ZzK
         sUOg==
X-Forwarded-Encrypted: i=1; AFNElJ/sWon2DaUPwZvpU8MFynehhTedD7MdVMWVNabpq3uR3KZ230hKAu2cRgHIrUOPgHMFoLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKUkf5jFRf1Ib5DdubHbwc0x/n5D2Z2VlQtsM2OAW7u17rLLPb
	zTuO5W16S4qFN2ROxR/XisbimZ7uEsB4gjN5b/lBOKD1m3gjFn7oj0NjhZQTEieg+FZG9cUqx6K
	3OuyoRL/V5nUgyePdG3z2I3tdoqdt1Yw=
X-Gm-Gg: AeBDievmjecSR7gj6hbI3wDXw8AVFwjX5mSbwGqQetW96qgnGtA/b0MD1xawwAytSMD
	BLDcq/NLKEyEnGGW6rtmLhOboiBmrcqUQujuNFmxtEZ9TE5xDtia7nwNarcoq5374TCsUapITXb
	ljWmo5HRIn8MnH1DUA0aQAJM+sNhrq3I5YsYgU7U0FbdJz+eVZVVM5I7qqMEXLuAkzJZVMhqjwS
	8TBUY2dXUIebbJejnK91XcRjaNoN2EZKYPj4bnz/mjvgLWfAnlmB+oBnrrijZKKAmrQkKxUmxD1
	uBCsA31NrBV9hhTabYCu4ddmURc3GvqBuf3DUx06rV2CogBLUhLm3EFMJIPgkMA5VlBa9wRiXnK
	QBgI=
X-Received: by 2002:a05:600c:c170:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48a970ab55bmr105961725e9.5.1777837970601; Sun, 03 May 2026
 12:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503190119.559696-1-atomlin@atomlin.com>
In-Reply-To: <20260503190119.559696-1-atomlin@atomlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 3 May 2026 21:52:39 +0200
X-Gm-Features: AVHnY4Je_hdJXpt18lPdcni3VJdqTxwGXnWD7E7YxoG0u0WmQy4IipQtUwj54IE
Message-ID: <CAADnVQKf8=Z31fqYSVRqpGa5a0Q_-8nS5uHLfBNCYUeJrvigwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 9:01=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> w=
rote:
>

Nack.
See reply in v3.
