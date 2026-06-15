Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A3409630
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540647; cv=pass; b=YJMC/pR8dKgDQc/Yd/n+ZqMPQhSrIKzRZCt3X4g4mqPw6qvULpQpgkSph9e+wsRjVPZWDukszE4gLzfycPPmu3wOKnC71le8BAoSn3dx/6hOj/pJ1K7eJqymEOe/ZYjQY1ucAd7IJl5OYTMB8Ch9a1ZZibeEI/5aIdEIhMdTGSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540647; c=relaxed/simple;
	bh=eQLhmoMuXBduJxrYARdnWqAklKjp0V88w5VZfDoHa+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khUdFpcOEAYEEkoVOUrxWcHPq4FA/G4x4tUxjSq2xBvt2V9SLTgVowujxaYj0QnAik3w8Sj5N1brD1RS2vNM0UNWk0Q9uPbmaEhki+wdO9M1S/pi8Kce5OCxB15sennoEQoEg8rQjexdicQDaPr24Jq42yA2iqQmW616kmqQ/9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=riVSEkz7; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riVSEkz7"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-516d0db9372so29309551cf.2
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 09:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781540645; cv=none;
        d=google.com; s=arc-20240605;
        b=Qn2NnDgJavWU7Dtf8gbrEPluWOTUBe1U87zJuf68w1ofOkk3002dIjQEQgOsm4vcR8
         75N+M3uvoSdFRh8ouDQZ2pkMLrinB+hZN0P4iMtNUs5Rtdr4ojt73rdGvvJypJ5REZTL
         u8STcjmHDPJGlKAEWEsZaCiWRTW64h5ZVGJChNfBdyUSYMRRpszLwg7qofHYFN3ziLxL
         oP8LS5Qie6m/zFNeUtXHV1Gb6gmVL920l+EMaC/tZgNpHm1A2mfmJo0Ul/t0aQia+l00
         WRCp8umwDrUeQS8N+OeXsIuXS8qE28i1XSUvhZbFK3XhtQGI8u6MKZkSDw+thN9fL+a8
         QZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eQLhmoMuXBduJxrYARdnWqAklKjp0V88w5VZfDoHa+k=;
        fh=HPLlnHRFYMDc1dRPPN7JHzAUavWE8CnwD5lepMByUjc=;
        b=R0/OHAFH4EmyZGhVPKQVObBmc2wa7UXXy4I+Xf/fsmXNhzyvl/dcAWewjGXwQ0K7iM
         VNSDM15Ln43tB6agxWwkxIFs7zYf3e0+dJBaLk0kNs441wOrB5WdI4Y/n5XJFoxbJmZs
         PZyyIMK5UOJyP1S8TUA90lPnTtOh7NF/xhmE3pdN4Tf7kg02shpILI/4+VrPKDNgD0z0
         cFXVRn5YjXTqBbhdNKz3esrZTCkucY3QXtuKV1ku2pXT5IKwhZuQDIYoiic7GZsDCfeo
         lJH2pnoZyYXJT5DOY/NhXoEBLBnBD2H8CEDjbKDnC0GwUugfFK3X7HNJryMkHVAGC3eG
         BIYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540645; x=1782145445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQLhmoMuXBduJxrYARdnWqAklKjp0V88w5VZfDoHa+k=;
        b=riVSEkz7XxUTuP8nSx0Dp99mlriG5qz82I5qUJYNDyLVWu054EDivQ2JfNvzrKCsK/
         EMk6lXXPhy/apOp4ULHXajvQlP751dBSwQRC653uBAwiuekAUuTYBY6TefucML5/UebR
         L6j2/p2T73dKz2twpHKJHmfndK/2DUdduHNerglo11iMK0axPBtScFv0DeyTkzok1i8e
         jAMrwMu4AUVU43fC91Pq5i7YqAomQYWHb63hsDoXTPW+C+Do8RF9uTVNbOQLjUfrL5fZ
         f4fUvm52FHVns1Cv9tlj9k386LCXeRL8vQHcG3dzvKeLcoTtTXUI3oExsxpSE7QC7x1K
         Yo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540645; x=1782145445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eQLhmoMuXBduJxrYARdnWqAklKjp0V88w5VZfDoHa+k=;
        b=ndMhWHD21nbFjcz/54T6qEnvfLRvARs3d9W7yW8vbsooQTh4URpiUIL0IGKX96qxfB
         +ltdHX+SdyJRPSHfML2s08NLmdf5H6m9S1dpwW1JwS5hHl/FAoNm8AALOb4yEWbwsM7m
         BKkMXxpi0KlD9VhcluUmL03e6ixx+JqokHhNoSDkfVrD+m2RMdIHv2UG48uuYMY/OxtN
         sOG/XMoPqlTGN7xaIBg0svbrjZkvZ02n5hhfifEg4oVMQMCPp+uvVb3fuWIWE9VPmvds
         Y6gSMv/v7Emw5W5NlfdigY1BoX5oTp71YXz8aWghNCOlVzmY8GaGBvLdWuGMoA/HuHnK
         H2Vg==
X-Forwarded-Encrypted: i=1; AFNElJ+2Kmtexbew9S7P/qcZgi2b3s3Zt8GtZWhjbEA+Zu4PwXVYwvEt32SjoTBFwYLCn7bw2VI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyml4DPhqGx6jth6mI3MvM/ZIEtFInd9RG/3V4QqTZfMNwL1AQI
	hMjvfkXp1Riru5kzHYUsJ/7JCW2dfLd4MMKYdljHkew68cr8XoN5g9GjVQUPWjWoGgVWSaE09n/
	ZIoj+6HbAYLqdTXLIV3rK4ThktVpZg50=
X-Gm-Gg: Acq92OGKUq3geGTYTQhWIXc8sC2zmzW3c/S64HZoZIGHFqLtjo/4gM5Rt9qMwqbj5aW
	5q47KBFWU3iob9bZm9n0zJ8k3xc+TPOXeMTJDQsTF6Kdu6Zz5MJNWaBCAEbPML/F8IjViAEn+gB
	teQaTIhwzmYs+XxAbVY6SyWauUY1k8l43LW8MRwdyw90dsjrF6JtI+yrzz744nC8siYzgWDlUjz
	auIJmKtudMBh9sKN/q/Gp53bq2skzjuyr4bw2z0RDoQcXRNTcZja1pLBtdlAFaLNw3xJ1G1wOq4
	hTSEQu/N32J67TdsVN+lz3mxh+eJpcWPxCDSF7MP/sOZo3w6y881PHTd4QUHvBDc5drCgz5tMg=
	=
X-Received: by 2002:ac8:5f4a:0:b0:519:89f6:1270 with SMTP id
 d75a77b69052e-51989f615bcmr14389951cf.38.1781540644718; Mon, 15 Jun 2026
 09:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk> <202606122110.28245E2D@keescook>
In-Reply-To: <202606122110.28245E2D@keescook>
From: Jamie Hill-Daniel <clubby789@gmail.com>
Date: Mon, 15 Jun 2026 17:23:53 +0100
X-Gm-Features: AVVi8CcijWf0YMFkvXRNQBYYFFLxMTeisXVBFVgbN6ptgvwthmuJ0Jfz7cifjsw
Message-ID: <CAO1UbGcbueeqLPOFA+=cJKjQxgXr1pW1vGFR-zNOT7rqsUqs+w@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/2] seccomp: Allow using `SECCOMP_MODE_STRICT`
 with `SECCOMP_MODE_FILTER`
To: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 5:14=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Tue, May 26, 2026 at 04:32:14PM +0100, Jamie Hill-Daniel wrote:
> > Link: https://github.com/moby/moby/issues/42082
>
> This doesn't show any particular application, just a demo program.
>
> I'd *really* prefer to only add complexity to seccomp if it is
> absolutely needed.

When I filed the original issue it was attempting a minimised
reproduction; I was trying to run some legacy binary in a container
that I unfortunately don't have the context for any more.
I've submitted another series that should hopefully address some of
the concerns raised here, including complexity.
