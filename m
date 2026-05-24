Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA98817C220
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779584142; cv=pass; b=XLFnj48011M/q7onRPSSKt09CoJeS1ppdMteR+uePhwf1/trlbkiFBXy3EDaYrf8wokWMSubAjKn6l7jbRy4C9asLktuXSTtbSD3OHNPuPmoMgg02tkHsrvMQwsBH1/R1JuqlMzbyF4CkMikVZq/xOjvJtp5j/NHBhdR4uzsr7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779584142; c=relaxed/simple;
	bh=p+AG/29QV/Gbca8cjEqgBqRmo3LE8JW0kDEKqQ6ndZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsG4OH+8QpmpeYzH5peUwLMBE6OzJekgQ32DiFt1K6NPSovXneVbpjmodb5m+PFGbdy35t3UouEyANLcBKejdEhLcP3Xbtq5XOgsQ5XiRNleX7la6fpRyqaVFwjmKrHOssj/fLw377yhfu+BO4WOBwQkMR1c0Jp6MeOSJDyiJf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LPtbUXZW; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LPtbUXZW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so4604682a91.2
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 17:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779584139; cv=none;
        d=google.com; s=arc-20240605;
        b=c0PFzgQV6Nxglcz9iLsg4yKvIAZZPayF3f6QGQJT5xMZgGMfK3znjWrZpnA5dyhhkw
         wLrdCbWolTP7AiDuT6zztPGwJkY5ItORwCYJdZ/uiVihfk9i++s0gdsk223d2ihilGjx
         EuUN+w0c18EDMBC+JKZrrp1Nd1O30uz2D5W+XnRSOSXMF1ZyD23uHoQXntHb5GAlS77m
         RXgPAhxQ0RSgZ8qx7XpJ0pwKfE8TABy/17jlTdL36vnbqXv4vMiATzUOsSCEH5Zpk0vk
         DDkEjA62hVQ7EghcF2Oo9qz3GG6IwB2ITdZpunaCTfSehmYJoyGdkyyO10iC6a6Ad7Wh
         nJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V3/jkhW5dThfKx+ujob/mso+Xhv3Sib/nvQhI/3XA4Q=;
        fh=44rFILfQp2HxB5nT9B2Alvk1KiIDO7jvNOSolNNd6c8=;
        b=FxeeOLrULxw8mcXUSFNh8Q7S+tH86GTdsAwtfAud37A4NAXXD1hlle/jfSV+TZhDA+
         ohD5Sr0sNYGux/b9NCYEmTLm5tsrt6ugrrmmbxfc2GMYMgCuGoerQjKbOpnxpLADWnPo
         tFiOY7ao1cr95/W77maUSrtKS4i/70Oa0tDQ6XntL7LGbomNGXstkRAaBVhjtvjeSKOu
         SXTb2Ldxpvgg0CKMWF71zvvLaysttpj60z1K6g7QEPlpXJ9pVQtmb7MB4+y1Q2Zwp0pR
         ZK/QKHBvFFc+kkSPxWH7Y2h9NQXEJXG5uyuSJVdLgOUZyv5HcSJvTVMBMueasCEzjb3o
         EbXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779584139; x=1780188939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3/jkhW5dThfKx+ujob/mso+Xhv3Sib/nvQhI/3XA4Q=;
        b=LPtbUXZWS4BJOdc25C09sjZm/+ww2gOhIOX9qf1Yi4Ec3nkTctGWtJhO+bprA0ixvY
         ps6dbEjJL2DZ3IFFRHWU2P+oUTCiBmdhbWYnXzJ2tMYCtnpAnBFcbDVLhvKpKiCwtJP8
         0gdJKfj4oBVbOox2+ueEJy1JfYNtovGPe5YtqaPz9Q35wv4i6HJsvwvbIaGR12OCZHaC
         zt47T6g6RePGHqPJgdIT1Nh6qHYqX2WNNesSwwJjbKTRIbZxDh080Pd45Paw5+kfN/8Y
         FxJYJHL2DKbnz3naaVTp2HrN3FqHEU4hi5R/7/j9bWTajSJjcfkJkpRqDhSAMlqT8gei
         6MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779584139; x=1780188939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V3/jkhW5dThfKx+ujob/mso+Xhv3Sib/nvQhI/3XA4Q=;
        b=AP0tXy0FIP71GU4keD2yIRyuWiElGCvOg8tuanTXhrNYx7GEJfGhnoV6u5qIHTwo1Z
         0d5hO/EKf6b+x8RN56ZI8wmxqGj8uJeNMEEzuVHmBIucNpv7vc6nqDXp784XIXFTF1tx
         Qwqy+M3T3GrcGZyG7E3jkGXEG1ZIiH8jCIw+xsNBtLoWNbO5dpmDcwrjWlTtymdHAHFd
         oh/TkJOXq9TLFVgvqu75+5lMuI8pJCWUgz8onqx+v1nK0eclOAWkEnpCdmg7yT7mbWzL
         pHgU8BmRTAp6jq7Ae5BGjHebiFAFeaDB8XXHnwM0XSr887XuCpBg/JLc+O28s4TWGzTi
         Q5Sg==
X-Forwarded-Encrypted: i=1; AFNElJ8L4CiJJHusutnyTGqnx4d9jMxktI4nttYaOH4huexZ7nYqxvTUWHjWx/RHW2mu4sUqgiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKtRPJ2SkKPWyOfFqgm5dGgQDn3HCKLpMvv1jtOOfUqMv1KIH
	32ashfmJawZE7wVe1p35RtITOkIMLE+u49rmcQTQ4Awbp+ZfjuNGvEX+8Vpo9MsNd1bDTCiRTMO
	fMuqPY0Lp2xiZGDaXTiWxFdnYavLrJnWLecjYyjSiQKdQ5vNjMgqSJIsZ
X-Gm-Gg: Acq92OExnkqfFZl+3u8xc10GMAcA/TYZQUk14EgMdwRhOwH24nZ7jfV9V7ExIlW7HzC
	g3y+BCc/i3s4E3oKt7XkLduN8Ocl51AsXAH6eF2CVAsPjAcuD9xKUW/Lm4vS4hKtJDE95adV4Xi
	ipsaDzSRxQRboiDI9BXMpPjj/kgtExxjgvIcWxvduLIgN85Y+HoZXxf0aEE/C/7fQ/ZKeHhZ66N
	/D2spgFAp9YldKEZR8//8NLYw5S1bGIjS37xCQpCq/46JQboyrkc4+3h8X8MiSERQV6DyhZnZpp
	SP7rYUbXCFYo60/vIA==
X-Received: by 2002:a17:90b:2f88:b0:368:ac5f:d313 with SMTP id
 98e67ed59e1d1-36a6787677cmr9184632a91.20.1779584139064; Sat, 23 May 2026
 17:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <20260522023234.3778588-10-kpsingh@kernel.org>
In-Reply-To: <20260522023234.3778588-10-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 23 May 2026 20:55:26 -0400
X-Gm-Features: AVHnY4KsVTOCEpGxW1kxnwclUZDtnApGycQwDbSYR2fjGdWcQiPp454xoqaYUNA
Message-ID: <CAHC9VhQ-cq-nD7uq3kv=SFSJyzO_CEgwzFeMcdbznTmPWJoy6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/13] lsm: add bpf_prog_load_post_integrity hook
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, Fan Wu <wufan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:32=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> Add a companion to security_bpf_prog_load. The existing hook fires
> at PROG_LOAD entry where the verdict is at most BPF_SIG_OK; the new
> hook fires from bpf_loader_verify_metadata after the in-kernel
> metadata check, just before sig.verdict is promoted to
> BPF_SIG_METADATA_VERIFIED. Policy LSMs that want to gate on
> metadata verification (not just signature presence) register here.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 17 +++++++++++++++++
>  3 files changed, 24 insertions(+)

...

> +/**
> + * security_bpf_prog_load_post_integrity() - Notify LSMs that a signed l=
oader
> + * has just verified its metadata map.
> + * @prog: the loader BPF program whose metadata check passed.
> + *
> + * Invoked by bpf_loader_verify_metadata() after the kernel-side hash ch=
eck
> + * succeeds, before prog->aux->sig_verdict is promoted to
> + * BPF_SIG_METADATA_VERIFIED. A non-zero return aborts the kfunc and lea=
ves
> + * the verdict at BPF_SIG_OK.
> + *
> + * Return: 0 on success, negative errno to deny.
> + */
> +int security_bpf_prog_load_post_integrity(struct bpf_prog *prog)
> +{
> +       return call_int_hook(bpf_prog_load_post_integrity, prog);
> +}

Since you're using essentially the same LSM infrastructure and IPE
work that Blaise, Fan, and I developed for policy-based enforcement of
BPF signature verification, perhaps this is where we can find some
common ground to start working together once again.

I would be happy to support and maintain a
security_bpf_prog_load_post_integrity() kfunc wrapper as part of the
LSM framework, similar to what the VFS folks do with
fs/bpf_fs_kfuncs.c, so that either a lskel loader, or a BPF LSM
program if you like, could register a BPF integrity verification
verdict with the LSM.  This would provide a single unified approach
for LSMs, including BPF LSMs, to build their BPF program integrity
controls regardless of what the system builder, or admin, chooses for
a BPF signature verification scheme: the loader based scheme you
developed, or Hornet.

There is no technical reason we can't support these things, e.g.
multiple coexisting verification schemes supported by a single LSM
enforcement interface, we just need to be willing to accept that we
have different needs and show a willingness to accept different
solutions as a result.

--=20
paul-moore.com
