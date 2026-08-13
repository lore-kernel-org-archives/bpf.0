Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C5441D23B
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603112; cv=pass; b=gWX7KnEXaC+A+qjsgTo0D6bDaFJQQtOBQDIM1aRdeWlgJzlSAqyZzoi1Ib0wTbEZPGrY9k9YLH4AOje7rv3pg60O6EJ3HA1x78IZf9Xj9+dUUhpVmjZOLCUaLH4kf31ZwShe48ghZMNrH975iSvD7aXllBEhWiCkPBoqIYvRtig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603112; c=relaxed/simple;
	bh=+A24NtONRwnbr6r3D7xaRVes2nGA+7zLWQBwcOligMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYsNA4tRxV5OQIdhoS2mR//T5Gf34khqGXjZXBeUA5IOnNoELrVCZTDPdBEw1/N8WlkdQ6kfv5MN7Mp9fo2VxasuVomwmzeejGuFwHD7/rC3dfpfKqKfPWNhmswV7EOEeF84mf7Cv5enzHrtd82VifZt0tT8Wqs+U2gS0cZmRxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=none smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b=seICwRt/; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b="seICwRt/"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso686730e0c.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786603110; cv=none;
        d=google.com; s=arc-20260327;
        b=c8DOKf6QB0KiXlMlnWunRsy8iwf+s2fsPl2ugOq1d8jMwa7gnyU7z2eQ7MFp03Oxww
         3MZlkauRE6/uJpR6Ca1POGNu7oKq8w9ZAVCj7luPFdAkz7ASno/tfqYwfuPjosyEzmK3
         hIudqfXUSfXWT5q8hpaHSTM9exVuUvqngDJpCBMe8X/QD8NzkraxMdZU/xxNRLjp7j0T
         LjYgjfnBWiVSY/TdJW9Otv3wB1/zjMyDSgVCwSSvaayKjC9U1XWwI2mgGW76dJJVBTkc
         8vX/CK+tq/fA0n6kWdKQyMOX8fREOR5AI7wjJFvIDoVWSIwtY1o9Y5sC2lmu7feH/Nxd
         ZaNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+A24NtONRwnbr6r3D7xaRVes2nGA+7zLWQBwcOligMI=;
        fh=SU6NvKS3Wzf9lcXzJJpj4+07tb5X0j360LJazEc1kNk=;
        b=Zc41v94InKdi5fGkggriRSmngpnhlxKItdGanKSUCv8jEQZcbBfwxtcdGM+n91gHFU
         3TZ/bgBRoSGfdSUxpQ28eKeumdG+y2PBUi3FonZmtGhO9dAcJEqN79OuJyDwZuIr7NH3
         PmydUS5iEddGqLbxntBauCfSLodqQB+zsf9o3Hy3HHLuy/JtJ/j0+xPHTi7aHvqjx+9i
         ceLN/zLGDgDSWVvGySy02AZlBQEkXKDdmH5xOoE6epA/LkmU1IQKsWX3I/cepdKviXpK
         AESdInkWNyqqKn3gTDWGdYbTdXqAZEaml4TJBt3cuyyBgkmVku3oGfPlos8BHZf5GT4u
         d/PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20251104.gappssmtp.com; s=20251104; t=1786603110; x=1787207910; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+A24NtONRwnbr6r3D7xaRVes2nGA+7zLWQBwcOligMI=;
        b=seICwRt/JeBBzfHlC41orlrh+jIQOO9ErSfHMZyRvAxm4pRcjwaWrEaL7Hh4NBL5vG
         RKtODZQ8PL8KQVZU9Cz6GEaVQl5KJ9OcUBxu902VsyLMt+UnFEzTq1k3LNwKQcZ8iGbF
         kLekaE/Bk0W1BHFsljuhWBOTgGRq5gQEnYnxnX0QKuRBIdvTzVG02d+CjqRe9Gont2a+
         AW+bBC0nyo/NcGPHfo5BDdHCGuWWaMcMsbVyaK4F2uB8C9GmqAYXRlbu/0sdAgGdjQCW
         27yv2xvTQokDu2HkvNdFuAJLaaqiU9sKYXxDWPvykMtKSps9vBhjM5hiqW+74f3OWgJL
         ACZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786603110; x=1787207910;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+A24NtONRwnbr6r3D7xaRVes2nGA+7zLWQBwcOligMI=;
        b=ns8rEL0LEVtLCsnQBHbNuWyMCwUjEpTfpYOnmznN4PgpFX338hPqie7JfK0LdoCDFH
         RxB69qFIZeI7dR5RyNuNxKVszxpFDRfBNLxK3wMEsli7eHHKBf1ad7k6wzfhI8sPm3t+
         53YnPkS5+2onA5bB+I+xTDxYH5PUi5r7GlIh124EmL+DHuuZDoYcqzBzw7K7WALQxBPd
         W4zcRJRhorZC6q+94C+eV2dsx/KAILTZ1zHEU+KPzf7/nYy4zSCr2x6XWP8ZBzFvAeaw
         Yg+1pVVQPF58f2Yx7dA6ljH7FF6pGOrBPV5Y3VXmbR7z+4/ndDfsj9GqiUW0zLbZB43u
         V+Yw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6ZNQC1lmhol1oD1ex5bHMLNQZQlvbdixbUCH4br/P8Hgjumjts0lql6cH0P/CBZFNTLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdB3K1MKcIiNiV1915SelBpl0HhguZC9Em0VdurYf8eRyoFQYV
	peLoWkQtKGwuEfyRAxXHK5tqAYT+vE1uSLrDj73fLNe0XS+FPxKusRCQm/OlYDE94hXqEflAHhp
	jHlcvKlB0pMA7iVkS7pzwBxBC5Bk9gOKXBTFcTeydIw==
X-Gm-Gg: AR+sD101ywKfsmBN5tiKL1SclIkjo49yReN494IVguguTu77Uq9qcpYGfFw0SucMxZx
	EaPu2KPFGNpP02vhOAxYDf3ymd5TCHFEv6He/UdXmaaoo3xxSaH/TcVknNr7s8whjua1nQVFRwx
	J8igJdYj7d5WFqR7ZGYeBGPKSRq1cgnPBAt08nvdrLGSIMwSOMojONnzRqWTE2f5Sge5W1Zq3Lg
	6eRs746SdqToZCOjA30uQAdGRf4zuOtvqMvfx9hW96l3UuEsgxK/Zcnxg35NrXLiq7dqKTZzkRQ
	ADnTleqKak0jJyIfYU6GL9aEHnDQR8PW4VovVaK5NblcvccZwiJa3w==
X-Received: by 2002:a05:6122:e24f:b0:5c1:2150:9de7 with SMTP id
 71dfb90a1353d-5c579cef23amr400695e0c.12.1786603109953; Wed, 12 Aug 2026
 23:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810194215.3754591-1-main.kalliope@gmail.com>
In-Reply-To: <20260810194215.3754591-1-main.kalliope@gmail.com>
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date: Thu, 13 Aug 2026 08:38:18 +0200
X-Gm-Features: AUfX_mxnVKFrhzMvzU9GpBsrmWTwP-e51VBkRweV7y8XFEVr_QVxGwultt7UhUU
Message-ID: <CAM1=_QTvdWzBpSGnoLV7wiW0dsn_nc04V8KnYuntptQ5mF9Pyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf, mips: Add signed div/mod support
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, tsbogend@alpha.franken.de, paulburton@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	philmd@oss.qualcomm.com, bpf@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nicholas,

Thanks for the v3 series. It looks good.

However, i am currently on holiday and do not have access to my full
QEMU test rig right now. I have verified your changes with the
test_bpf selftests on mips32 with QEMU on my laptop, but the remaining
arch variants will have to wait until I am back in about 12 days. I
would like to do that before giving my final approval.

Please proceed with the remaining opcodes in the meantime. I will do
the same on my part as we discussed, and then we can wrap up this
whole v4 compliance work when I am back.

Thanks,
Johan
