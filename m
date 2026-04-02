Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BDE2E54D3
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163012; cv=pass; b=ni2n9QmBs88gF5WMLyONZnlpoAryoE9gMNw9eoUvJct7iTQU72rFSEKXcT67MEeMiEn4LVjzuvSb68pARmtJBR1xCD5L9DBUUKnSkX7HwNOXSG0Fb2fxRY+1ct3IXfnC7kWpd2a3+D+Mqj8x0u++Y39OsfhZ1X94Tvmb+broa38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163012; c=relaxed/simple;
	bh=M7AoocL/zkjHw2Ufjx5CCl8kTol3N0Qn+Us2Fl5uChg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qouyWkOzsbZ39I2DfcVvXUeFc9RcwxkXwvEyFi+qYRaPnp41EFsLP8Ms/GfKE5U5oyCCJwPs4YlW0I0fj/NCbWlJ3MzY/JYRUVeQzIH8wfB2EdfKqc5ioQyl/5wdM8YCj+mHsmfsbSN1lpCDT1nYKVTx4ntsewCkzYXkN+u/4Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN+RODgQ; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN+RODgQ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d932cc948so858373a91.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 13:50:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775163011; cv=none;
        d=google.com; s=arc-20240605;
        b=NLq34qgDJjb6Bc7GmACkyUnq4kX4vG3Yk3fryrPMtwsb/CbIEQBC53nL+bPoesBtDT
         4rjT5U+8aHC9O5WqfVZLLeZkAat5hPiquK23lwn8uLQuE0MCcnx0EeNwss3QxTUgApBr
         xWO6nIkkMhZ43LjmbbomEBFIoeZRL+KktwNPzTGnkaVgNAs8Ep7fVOKzktYJnvfxfywl
         22ocYtkV/F4qlseqfIUAx3ibW1kCmh+4cnLCCRm6vRQ7fLW0tKUkQubyOBjXSxz/bA/z
         0/sh741kOg5t476/WGga3C9yJ6QadE2Z14iedM1WABz4eGar+Xlmd+RU30Hu9O/arRcg
         7Ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fwsFVYVXfwlBT7VVRS6BrMdzKDluXTxhxk2+6tH/a5k=;
        fh=omWTr5jay5JTdDAPKK9OIMQVsKVRvSv0IjaD2NOn32g=;
        b=Jo1Dhjk8Nr5TXci3bogiEV6H7eo37qx1bNhX2aFyGcukjajLH5k2n8CHVIV/5TPcG2
         nwRamYvcrPwjA2ewz69G0OVO1FPXk3MX6MsVneONK6EyUq5Of+vn2vAmWl5p2xfOfdNm
         v8ZUrUnM5Ax9d05KnNXx3ExzcM37WBc09/LqEiGVLESIYElV/pnJgGosdggM2rqfavsu
         MX/ZZOdEuHt1pvrIo8PJTE/KSyWTuPH4eTuL6JqbBphQGCNdB+sA+9FdfWp7fndG5K+1
         snDTwDLBvNsz+aU76Pz3z1DV5NZZqoHFNbr74OTRa93mXOVyCdUJbIzU2/21ZkggPy2O
         0rMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775163011; x=1775767811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwsFVYVXfwlBT7VVRS6BrMdzKDluXTxhxk2+6tH/a5k=;
        b=cN+RODgQWkqG6TQnBfA2umEmYOWzwIMAvSgfdPULOg0/lXh17d7gV0xFbzsoebnrG7
         KVDWvS4WjKFFAXjUkqsYIjbQaZTXBBLSmeVLV+I0UQ1+X6lIomYcnerRIIGfeA9BdTqc
         CO0db+r+eE3REsk9ignIrYgoBPHtKzeoTpKJineDl3IJEmzQ3gGq2DqoKfPXjruAZZpH
         H9pFtUCt12jd6Pkng6sYLCBj0p1afi/AZf5Zgu3tgA/pARLzXbW5BhCByuxjq6slM4C5
         UA+zh4yjoSWkQWvZbdlBatWJiIWrhOcjPCB/hVFuetKjXzGJOPM6QCq1mOsoA/JQW769
         qW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775163011; x=1775767811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fwsFVYVXfwlBT7VVRS6BrMdzKDluXTxhxk2+6tH/a5k=;
        b=I0aPlreZHCw0CnkX+KQTqUGUyQCDQy8NBrB3UgiZ7GFUY4XBLnp9nZ0PAH69naiDhK
         ZrUIkXrciLwiB9iLwLk/VTnNd0OHr4++TFYvUIZVu9bBm+lT/wmoTmtBNfVLZEHEND8Z
         nOKpsI4LeYAUBmFLOMJaYZ3QmP2Sp3ufvMEZCnzth+Vs8jB7P6XrRMcwMb0L/WIobEFG
         yTueqXvtgylr0KdfE3Df12NPX0BxVbdM1UnKvZcDogX/WHFZD3M2Fe9VxadQrdN3ndtZ
         wjM2mqy36119k//RiwmhDp9thSpdlrRHNqevFaPb4CsBboY3HVaRbYbJyqUrYvfOFKE2
         h3Bg==
X-Gm-Message-State: AOJu0YydvnA5e1eNNiJCLDOCI5VShCKqa/ccYkraYfIm5EmOM925hMSG
	EYJwBftzKjUpAhqGcKEKXDwcBBTl3TKhfM67D8UNasua/jrF71CXQ9nnURPIQbmXCqI7EtqJglp
	zotpy4ynfgjQiN6/a4NdUIlu3vYa8U5qk0YFc
X-Gm-Gg: AeBDietS9aPxuWEXwBxhI42bqLQtn2cpdCBJd0XRO9wE1NphCeAZdDkSHP3gZPaPl9s
	FZI+8ZPmEHBJN8C7Hxi2AJvYDNLn5JMs2C1wisp3HdRBam2VZLGHZDuo+OfuwahUdNCzuOvdcqY
	PDJ69yUUccecMuz+ggRAxj3zYF21mTAmdijvlIOyWhfKGuIMG7rTxWQ4U7wUlLRG1LXhYrDJnTQ
	QZxPDAJlLh6xObPQ81n6Zoj3AwiRpC5qUORNixSwrC6XICRE03ZGXWWgaVHZdhXuc7l3aJN0d2U
	0wvOh3tDJKZyAKuJ7w==
X-Received: by 2002:a17:90b:3a0f:b0:35d:9c32:6219 with SMTP id
 98e67ed59e1d1-35de68632f5mr302800a91.9.1775163011033; Thu, 02 Apr 2026
 13:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326213036.8121-1-clayton@craftyguy.net>
In-Reply-To: <20260326213036.8121-1-clayton@craftyguy.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Apr 2026 13:49:58 -0700
X-Gm-Features: AQROBzB4LFfcCk65kA2LiG8Qa1rdk16gHmclsh2WuMn5fWBzVGiUllNuZINqucM
Message-ID: <CAEf4BzYrp+M3ROq6=wP-RWg0tKonR2VNv7RrJTo1n4DWEOf0Ag@mail.gmail.com>
Subject: Re: [PATCH] btf: don't fallback to searching /boot/vmlinux-*
To: Clayton Craft <clayton@craftyguy.net>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 2:33=E2=80=AFPM Clayton Craft <clayton@craftyguy.ne=
t> wrote:
>
> This makes a lot of assumptions about how the kernel is named
> and where it might be located in the /boot. If it's a separate
> partition, it could cause additional problems e.g. with systemd
> automount if libbpf is used early enough in the boot process (see:
> https://github.com/systemd/systemd/issues/41162).
>
> Fixes #955
> ---
>  src/btf.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/src/btf.c b/src/btf.c
> index 40becc9..28d796f 100644
> --- a/src/btf.c
> +++ b/src/btf.c
> @@ -5494,7 +5494,6 @@ struct btf *btf__load_vmlinux_btf(void)
>         const char *sysfs_btf_path =3D "/sys/kernel/btf/vmlinux";
>         /* fall back locations, trying to find vmlinux on disk */
>         const char *locations[] =3D {
> -               "/boot/vmlinux-%1$s",

this is a valid and common location for vmlinux image, not worse than
any other path in the list, I don't think we should just randomly
remove it

But note, libbpf will attempt to load BTF from a canonical location at
 /sys/kernel/btf/vmlinux the very first thing, so ideally just make
sure that your container has /sys/kernel/btf/vmlinux exposed if you
are using BPF at all.

>                 "/lib/modules/%1$s/vmlinux-%1$s",
>                 "/lib/modules/%1$s/build/vmlinux",
>                 "/usr/lib/modules/%1$s/kernel/vmlinux",
> --
> 2.53.0
>
>
