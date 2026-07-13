Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC42352C52
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975644; cv=none; b=bKVcOm0D1NmL9RvDBatHJCvTYIHIVo8zB695FY2IycZiP3POuNigkU3VJZyCLNaDq/x/VGRVgt2RVrf9vDtpWn3VU2eOaNSMbxsoDRo9EkVSGq0zuHdFZHy4MKc5csX9rEjKHWufPTqBZZuKQ9FbGnEERrVNNz0S6M40QR3N9hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975644; c=relaxed/simple;
	bh=MHwslCC2Nt+IsAJw+WSX1C2a7l1sagCPXjQr23Cn9CE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X0Pww3Pd7oyaFauUwpWpFrl7bylIGdzZ3WunwI3e5rZ6iKMfCCx78V3qRKCfHkPDRJyM1Q5rUUfFz9ejcWAvNPIZ1yD+5GPz+0x2fjZ6MbNBQwmdUvCb8e1tgX3P5lAOsCqwEFC1FJlkbisN1cU30nfxuo6crGySxGi6tYQkpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgPFK9P+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgPFK9P+"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a2dcec51cso1819845b3a.3
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 13:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783975643; x=1784580443; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MHwslCC2Nt+IsAJw+WSX1C2a7l1sagCPXjQr23Cn9CE=;
        b=kgPFK9P+xZkg3yKM2nqWJatyNEpv8NmsYeKomGm7nPnAxC9LFSEAr3SwbVhA9UlqSw
         7oPYzN16QFZzK5BbEjQBFVACSk60Yf2de2G0F2n2pez/7vaxgfDhYzTaMrl58MpM0s99
         kzh05ugi65oJbz5uunb4rhph78691DLbc4OOpCzCSVQQ7XJtfFiviq/VrlHyz4mNDjhg
         7lSkYXNgr9vvoAbyPgEuJsE6IGAcND2h5E9A/yZ6zwEqLxtb/3QIoElrlBeTgQWMzJey
         k9pGgJha1WoJhkNzpOCmF9sYYo5B6I5+5JyjBnMrH3PcfMcE8XHI55SUPy0zKoYgw61T
         GUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783975643; x=1784580443;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MHwslCC2Nt+IsAJw+WSX1C2a7l1sagCPXjQr23Cn9CE=;
        b=hkkrD/8+2dNuS/5crXL7aazhljmbE8cjDKWxkUMfkfWf0x6u1gEp7ILn37PcViPHdo
         HaT+RzyfH+4VNNrPocxKHg380lfppigVG7UudqBbdpUAvzKu98g9hNB3EzJbUIJcVzG3
         SX+l8wjoIBELRlmrOTkRkmo1ve+HKqD9PG3JDykzkkvOXtFt8/ZFSJtoZCanR+v+kiQC
         0m+wYMX3EwnAVn3ai/ix2v4JwhLmjn4hwDUeQFbWljQPGcQbNN5YfPHCgPz292iPO5kk
         42ds9SFiI/ywbDR5V0jzAjF8fXGsdTX1PFK19OF40335cKStkiXEwZWwDo08CH8gimNu
         iBfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8q35FIbTeNA0lnFvFbAHAX0WMZQt8Ubqhl+QbonCCC2TufrEp4aFle0TooXokoJMWJ30=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLbGn1+dBNel8r5c2KvszeoW/Xtb4G1jqARdN3IOB+/R5WrL6
	Bk0Sn2lAW8CcZMIjbxy3jNAOwqQte42YR1QyAudpIROaRl9vmEVyE/Sq
X-Gm-Gg: AfdE7ckdkpS0ws0r1H6eiB4ijLw6sUTX0djh1JH61mWkHIrlvEgB8/kTOZCMyjqUqJF
	ZaEm5y1jLlgC2l1FuQnNkRs1zzby5DGwKHDyWcXOEcGLEhmrhSZOJbjG4EZw4qJ7PvZUTbLvEiq
	90TEPVL7UWDZniARtxVDqOJHTPF5+rBGYk7FXjKCINL51zk96eq6XVbTburNyuUDmjIE0YnqVui
	vS5k2mONClOGPRr1PE3VFE114ztOJv5+F9/7xRVoQCIn0FkgozDEOPWT1dBAig6MU/bJ/xKpHHi
	o+k8YD9Vx4kKkZRmn+Xla/VW3FY3+54EFetP49NKG41b7OyE5wMZX0sJ+eQNwEUvqmHZ5vjF1Oj
	lzEADhFs7ogWeK1roPiUT7j+yJlWkpeyG8rtwCxFAD9QBCZeLnbcsj6LXyFK5r8oXK6NbXp8GfV
	smuGYsQL2vjiBF7aC0ovpI4hG0PA96Q0ZtBw8uPmND
X-Received: by 2002:a05:6a00:94ee:b0:848:2f84:72c with SMTP id d2e1a72fcca58-848898b9283mr10236647b3a.63.1783975642656;
        Mon, 13 Jul 2026 13:47:22 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f23a600sm362593b3a.6.2026.07.13.13.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 13:47:22 -0700 (PDT)
Message-ID: <08508d2133284d49e1da297895c85cf854a97bf3.camel@gmail.com>
Subject: Re: [PATCH bpf 1/1] selftests/bpf: Enable BLK_DEV_NBD for
 raw_tp_writable_reject_nbd_invalid
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, sun jian	
 <sun.jian.kdev@gmail.com>, Matt Mullins <mmullins@mmlx.us>, 
	stable@vger.kernel.org
Date: Mon, 13 Jul 2026 13:47:18 -0700
In-Reply-To: <20260713063513.215781-1-shung-hsi.yu@suse.com>
References: <20260713063513.215781-1-shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-13 at 14:35 +0800, Shung-Hsi Yu wrote:
>=20
> The raw_tp_writable_reject_nbd_invalid test relies on availability of the
> nbd_send_request tracepoint, which is only present if the selftest kernel=
 is
> built with CONFIG_BLK_DEV_NBD=3Dy and the kernel built from current BPF s=
elftests
> config lacks.
>=20
> Without it, the bpf_raw_tracepoint_open() call always returns with -2, le=
aving
> raw_tp_writable_reject_nbd_invalid test always passing without exercising=
 the
> checks bpf_probe_register().
>=20
> Cc: <stable@vger.kernel.org> # 5.2.0
> Link: https://lore.kernel.org/bpf/alRtilWhKw4zzMkI@u94a
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
> Not sure if fixes tag is the right thing to use here, so use the cc
> stable tag instead to get this config change propogated to other stable
> branches to make stable BPF CI's job easier.

Shung-Hsi,

Thank you for figuring this out.
I'd suggest we switch to bpf_testmod_test_writable_bare_tp() [1]
from the test module to avoid the config dependency and let
Sun pack all of this as a single patch-set to simplify backports
(if such are necessary). Wdyt?

[1] https://lore.kernel.org/bpf/3430dc0a2a141769a596ab21d7abdd86a0a804db.ca=
mel@gmail.com/2-tp-test.diff
