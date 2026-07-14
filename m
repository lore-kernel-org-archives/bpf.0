Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC638332A
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010206; cv=pass; b=Ig8ZMTXbKwzPFw8PCL3yLCJ/9KEwgZTiOqvMPtnVXeHZGRoR3AZ4/rNbfIT5aIRehEltSkptCLsjwZXWsf4oSsGfrNAflnrApa9ISTi3ohtM7L1FdSUmuD7YSbHLi4cKlyoDPeLpwhjtXkOj3ufX0gZ5bGazmcuo9tFYg8UvqQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010206; c=relaxed/simple;
	bh=Wnrg0Gu0f2+9+eCpNmhH2Vvi2/B647p4odZ67Sj98Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1rTEcx46e88QUCoZrX/0KBYclX5ykDYmK6o2qCWoQTWk+COvjwkDyhngikdm4USwAdZXMuvUI8nDuijGQUmDESzNLmP/iFAwunIdGYgkEU5sk73PbVqs2JN8ecCJth2mHNskSYhGlRGXi3tAE2DcOZuSwPnZdZYua+0kjCI1gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C5yZtrYa; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C5yZtrYa"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-447a81776e9so1260056fac.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 23:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784010203; cv=none;
        d=google.com; s=arc-20260327;
        b=SIohtFQjwF4sOaKNxZMaSzGxBUThHJ2033Pr2TDjjEhL014m6dgm4Pb7yB1RuarT/A
         VcFzm5rCzYqDGzpYCxmsQVjU55k8L68+0zPUiLGpUuQdftQ20V6SjLB5t3Grnaz+Oe/v
         Tt8ShcuNLMDJV2HMEPMYaAXqS4amlFm+Jy8fqKUi25sFd3D5cwV5OWm+3/eedp9eias3
         mKsxK1t/rzJyCLrbQ9DVu9QliUb21Qf4QTu75dLoAAC6CLhqUMm9cBbpaMQFFbziBXL0
         ostEWBMFT9tFZJqQCfpNpIkDTmDTb1TabI72QAIaMgEhxNZxwmr0S8AN7C0G0tAfVE2j
         YeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UmwZ2JdGpnQjzlIbtGvTSfdYg7lmImsp/NzZpGZ4h5M=;
        fh=Lfbewpn7/1EFZk9aZXXWqdWhONNzd78YvWXCDr0xnNo=;
        b=DHV8RvRJtiVteJsfqxC9CNzQDsKs+CkFUed/ijjhI2954+9zZXc3K119MbCGxaudja
         ISZ4fzqo7tdSYxt0caozVb84KU0h4X2f813IOqCaz6vWlqoN2XiWBm2zVPhZ99agepLo
         iDYxvJ6fuK+uJ1kGE6ktWw+F98ieldVWjUiizSVrq9QTBD17f0XhAemRG0OsnHh47PHh
         JKIcZ8ruDhDGDvXmof5ekN5Vs0CkTHEA1z0cCYbMSdRVsjgQox16i8mae2Q9z1+hJFzK
         FPLAC8pX5ZoVtqaU2w/HnCmufqO8JvgrpBHyjiix8Q+x/CJarVU8NqeMtLH2mmD48Gha
         E6eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784010203; x=1784615003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UmwZ2JdGpnQjzlIbtGvTSfdYg7lmImsp/NzZpGZ4h5M=;
        b=C5yZtrYaiOai+7as/nU2LgehtiklETKyJnzwc2vxBneqEmyzoH+JQh4eQyBUziM0lG
         C5BFzgkQ0c2YxmZDEwST2r64De/ECjJmxzDv2TrvOOCpuQTfRfVb87y/yoDNNyxYiYGK
         hGT+t4qBr1h2v3f0HU25s3P6QndmCuieG7ZWLNGT48IjDmJevjgX4rG6V0Kt7bbf0DHg
         wfJwy951dE9B5rrv9Xvd3Zl37pc6fokNAUUTN/MbomosKUGuFZnUbp3pbRH5WLoo9fxQ
         5PXbFNjVnwVb/4ZUmvXNnJapsE4j+3FyH/bOMiIVDa7gFXhWuKtSN1CJrzKAthipaDP2
         LOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784010203; x=1784615003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UmwZ2JdGpnQjzlIbtGvTSfdYg7lmImsp/NzZpGZ4h5M=;
        b=pTxYCwJ4U8faebdd3P1ivKIdOCuQA0KHsvolXZhGdq5ZgiFmj958VO98od+1+ywLMU
         GkG63yJFzgaWshnAd6yizWoRz6zyZrAoyVAUB1ok2NcIi73XYzr3tYgVxkb2B9khnN8R
         mY2P/bEg+wJNTd7n+bYZGmB/PGMveWw1hPigIRQOBjcZAuKt68TZho2tHDpwXdbhaA5R
         4S8LWW3L9dVBJJ0kE5I83bWgwo/Wzy5SQJ/RrUoPNhUbu0VafIGEhuJ8FAu2nKiYmUPM
         HfWQetyl5S5vsjDL0Pz21C0s9yMOt+z9dwycjYzDl1EXLau2WzuCg4uSe0HWXczvTa39
         J/wQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3Cp2mwFjL7yVOIe/yCpIfE/bhDms28qiELRfmorPOQbnmAk1l8Tx1uiBB4IFNmfbnUmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwY1CW5fdmKONFepovBe/5M/rBZ3YqPPOgVpzE7FAAuBgcMd4
	ugY+KULa6HjC4FaSsbQYO0q4Yy6zZcZhS1GGNU1yxvqIMkLKDm43fcOpWXdxchV6qUPHbZakjS6
	ssoP0IhUvoW4dz+A0Hn5VIFdqiXMsyr0urY8myJunow==
X-Gm-Gg: AfdE7cl+P9bdMC4cd6bF3yNKsT8sniBIhWBlY5hwGO3TRWjP48El51121kXeNFPxJFN
	DDQeSKRsxuACEd23mmICcKWafy8ExsN7BwmR7aB6VivNhmrLCV2Z6j5IiR4DujrjtgH1YOZAbnw
	s5MRHgPm/74BT7tCaYSIK1lxrwY2rMqjk7vug9gSfZMwH5/prYKNnE17wUG576b54KP1hIeK/U8
	XT+vfbwN+KhoW5vKIHOQ/iyzIfR5upLOh0LSM77hNZwlSU6UJsOfzEh2c1oXxIblSBnN/eO45A=
X-Received: by 2002:a05:6808:1b24:b0:495:f79d:b08e with SMTP id
 5614622812f47-4a47a6c1d27mr439710b6e.21.1784010203197; Mon, 13 Jul 2026
 23:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703122832.15984-1-cuiyunhui@bytedance.com>
 <20260703122832.15984-2-cuiyunhui@bytedance.com> <74ffb0c5-4edd-7b64-3d3f-be76c2aec4c2@kernel.org>
In-Reply-To: <74ffb0c5-4edd-7b64-3d3f-be76c2aec4c2@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 14 Jul 2026 14:23:12 +0800
X-Gm-Features: AUfX_mxF_EkkHPpXwVLSHWKREo9gY6a3BeqhKBMKR6LcYXx54wa2zu3a3fsDMQ8
Message-ID: <CAEEQ3wk8gK9pam2da=o5mbfzU3-5EtfH5nyhAoVfCoy+7UuCGA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 1/3] riscv: io: avoid null-pointer
 arithmetic in PIO helpers
To: Paul Walmsley <pjw@kernel.org>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org, 
	thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk, 
	rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com, 
	conor.dooley@microchip.com, tglx@kernel.org, debug@rivosinc.com, 
	seanwascoding@gmail.com, andybnac@gmail.com, menglong8.dong@gmail.com, 
	cyrilbur@tenstorrent.com, wangruikang@iscas.ac.cn, atishp@rivosinc.com, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Jul 14, 2026 at 2:04=E2=80=AFAM Paul Walmsley <pjw@kernel.org> wrot=
e:
>
> On Fri, 3 Jul 2026, Yunhui Cui wrote:
>
> > When port I/O is not supported, exposing the port-string helpers is bot=
h
> > unnecessary and can make clang diagnose null-pointer arithmetic from th=
e
> > PCI_IOBASE based address expression.  Keep the MMIO string helpers
> > available as before, but only provide the port I/O variants when
> > CONFIG_HAS_IOPORT is enabled.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks, queued for v7.2-rc.

Thanks for queuing patch 1.

That patch is independent and safe to take as-is.

For patches 2/3, we later found that the percpu try_cmpxchg fallback path c=
an
expose a variable-shadowing issue in the current RISC-V cmpxchg macro
implementation in arch/riscv/include/asm/cmpxchg.h.

I'll address that in the next revision of the percpu patches, so please jus=
t
take patch 1 from v8 for now.

>
>
> - Paul


Thanks,
Yunhui
