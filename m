Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E43CAE88
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577585; cv=pass; b=KZRrkvpVPy8ZK6xlNTJhuhKAd3RfdqP1J/7MVRE2X+Zn5FcpVfe3u/AWNhArlZXXgIRYGMFrsShGHvkxynMvEfmmI0dYkEnfC6EqWSwyd3pA5+7UCP/TeXv4LbVF/1MRdpqxlTDJlsZfnpmrhPcQ0X7/tV6nL6rVjyJ3JlgmMfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577585; c=relaxed/simple;
	bh=Er30WK2/2ZRPe4ekJFuImif8OxmApH32y+z10r0lfcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gq/nSDr8HKMTgOeVJZQon/J/G3jo8bQJFmaKji2WmzcoKMbSnYpRI/FlbCo1jacqf0aISTulVcATiWYZrGP/aUqfcD9fpWWf5rG543w9OELFgkUTij5ctjD6hMF8WveedpvMLkkGZF56US6QvZBJ9rAc58VaLIvYrVQcDM9br7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4gGr6OX; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4gGr6OX"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43b8e8e7432so4260159f8f.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 08:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775577576; cv=none;
        d=google.com; s=arc-20240605;
        b=N6HhgN8kMPX6Ru+Ip3w+DxRJ0fZd+QeNYA0XjVxzHoshgtiGyUetberBfs+eQMQTYF
         5LsKpvlV9i1G7oED5WScRayF4pYwDvhpEmzyLa0sa+TQqVCTcTnJi+u/Hkj6Q22CxMIH
         lueqsLZEGpKXZmc4tVGyA9DJqP7hqQ4aVypfboSgBT6IR9GlcPBQGw+lVmI4npxm+fQr
         yW0jVnohmg9ZkXHaORGnFw9qn1p+O5Sov+1UIBdxtM7nBoERYERL8yWT8fEqEFm9XHPY
         ghfONEXLvavaxPFXQ68LG+DT+pAEvpr2y6P8ZYUVONEb8kSb79GYyV/b0DrSPR3kI23q
         qL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Er30WK2/2ZRPe4ekJFuImif8OxmApH32y+z10r0lfcw=;
        fh=Sq/K1EFVkXPFuOWzTVIi+KAjY0pEP9GWsF7LzpDFuvs=;
        b=QE0CCEbUXG5kX9b5WLL4ZagQ+3DGLRcA7zdPwkl0Tf6mQRPM6xv+WjT6jJ+ou84e0F
         15R6HGASRHfEUxiIEtkvsiMjKcVCyUEvr3uM0e1Suq9sAanAMRTWRyUkDE8qmRcWkjlr
         rRkZ5ZONB5H9pnwLCFFp5TtsLI7kCJbCu8M33CRtgTqAEhzFVNpUmAfQr5j2x9/y/MmP
         +mipYatg+pYWpLgo72N+O066HyyjjthZ6WkzsHeMfRO1hxo/SYr6V/KGKXLse8UpL0bm
         YJsOg3n+KwlnkTly6h3NJZcdB3KQDbXfwci/E7zGpCdbAMpiI5pwMmoJoQYOreOF3gSG
         ACEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775577576; x=1776182376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Er30WK2/2ZRPe4ekJFuImif8OxmApH32y+z10r0lfcw=;
        b=A4gGr6OX4h51IYfD9W3AvcqvJPCkqGIf/f2zbSyy0b058toZAOMK55r9lQNVdE41VL
         jP3PQ/oRzqtW6CAXzwdQeuwkGcQEfYqXkEgUn+nOaS+mnJRHhzmnSfaadkIUenpxh13h
         /ga7ycacitWtucLjEr8njtDsif/Tcr32EyRIeSkw+T6EnOjoC9rnAq5EM7x0DaAuLWGd
         mfi+zm5UN8Jwpih9qjQEWUuR7k1bmkLY5/hqtdh3R5BCBzcYzNNgNWL7bYjDrUkG0ZkA
         WOA8MgAyKjPrQqhWIyeVRkDch2YTa4FvGS2/4TbmDoHi4O1zmSBLdfNdX6r75ao1QseK
         VoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775577576; x=1776182376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Er30WK2/2ZRPe4ekJFuImif8OxmApH32y+z10r0lfcw=;
        b=eOj5t7cSUo5X0TBeObbVQhj6iUuq2Zvf0FxqGfiPOUWT7iUUCoA0YnpUedXIo6l0id
         iHFPve73sF24q/9955UisS6TOkedJUdPuZRWAk3y5wZp9NE/f98XUvQesp0jRzo5pVp3
         YqdVdNY+hOSZ1HiCgHd5qPpWsBZY8/KbIGHTFkQUyu6VY01GQQC0h/yfqMbQTr+xmf/j
         OzYX4iJwrItS7Sn1aUu+A+kWOsPbxNTEtb52yCRtZv0rSqGD86E92jfNyQ8YdQTBoc+N
         +N2FCz2T4WvYSVAAWehbMhELwwtxSLOfpH7PbeSBg9pew19aJuOxob8UKz9PDDjym2R4
         eS8A==
X-Gm-Message-State: AOJu0YwKzcJ9Dm+hOOaeTFOE1ydNGJbY+U/CaHCaUxJpkMq2EKvySX/j
	Nhojd+FgV0LMCaLyikfR78/0UTUJ+ZA17GjG6iK8qQj7am79FXL/6/v+xMSxT9H3LUU5PyQ0xoy
	K1rRtLlw36rV8/tmiP757E8gQNHVkIYQ=
X-Gm-Gg: AeBDieuRqLpn1z0RuSUn1yYlx1eK61MFamsrR50rk2ZpTQglRrsYe8cWBOQAk6CPx+q
	oUu4QXmnRVQWColNr6KjCVALH+uZE/o+tVhsEqy/lCn0PI/wlXDqe7cU4m3ogA3EmzPMJElHedo
	25wq/QDIKbSqg3Rj1zXl6xPj+6LSL8o6L2b08O6Df+aArn14m2W8cyyPT6YD8k0tkIAFwjKAEA7
	UJA4e1B+vT8JroqJNShbUZtSXgoyAM4/9UzAqEmCoi9utyK/X9bgUO5WpK5sGgRm85yCS+w8day
	PY22QFIRzvtuWD/E4OktEYRWDCawJPfwR/vKwXQwv1iskRlCEkUiVynb4JNQEJmMgrDjqIZRUGj
	pNWnMBR0=
X-Received: by 2002:a05:6000:184d:b0:43d:61:652a with SMTP id
 ffacd0b85a97d-43d292e8ab6mr26187230f8f.40.1775577575466; Tue, 07 Apr 2026
 08:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406150548.1354271-1-ameryhung@gmail.com> <20260406150548.1354271-3-ameryhung@gmail.com>
In-Reply-To: <20260406150548.1354271-3-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 7 Apr 2026 17:58:57 +0200
X-Gm-Features: AQROBzBjWHfCvxer05KGxxkfD7gFSnRHQ3Hpme-u6KvVYH8WDyT8vtZho0RC5DE
Message-ID: <CAP01T76Tg2rpPR21QsgpOVJnP_KrD2XzyUntY=zSw8vhb6uPXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Test overwriting
 referenced dynptr
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	martin.lau@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Apr 2026 at 17:05, Amery Hung <ameryhung@gmail.com> wrote:
>
> Test overwriting referenced dynptr and clones to make sure it is only
> allow when there is at least one other dynptr with the same ref_obj_id.
> Also make sure slice is still invalidated after the dynptr's stack slot
> is destroyed.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
