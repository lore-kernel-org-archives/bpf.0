Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9280D3803EF
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776242665; cv=pass; b=IKp73p8xfBoPjZJE4kJwa3f5aKNoXXi6B91zyawbMbPDq1S5nNEJL6Dhxlk6NElH0pOHglo0KbzRDcqNLYYfQ1IlQUc+wP6z8zXYddUphiJTa10dGhKoFf1HsjajXCbDvsIlqB1WwEuCOgv+o+v94loxsERcE2wMl/EJyt9gkE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776242665; c=relaxed/simple;
	bh=Mp0Dhk0lYnbwO2gDSPWZreLqZBbZWgOEa+uBM9bOFwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5KB9Q1hnE5kfKmzY9puoKUhOVSkiLueiPsGxv1kwkLzk69o+thJ8g6WCPrKQXtk5BcTXihAe2YueCn1C6bjuKiptBPyDv9wGOOFJ/6StW3BcEDAbrm/tBZubff7+Hn7RjCtAbQXAoHypXPFKijIwGnswpHXQJtJpovpwhpQs+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVwjpQhf; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVwjpQhf"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so8168454e87.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776242662; cv=none;
        d=google.com; s=arc-20240605;
        b=GHpugNpahFyRgeJT+edK7tPHMBhMPkoDx2oOhU96g3Xm2iYsMTyO9DxiMU9+FurW0a
         cue/58bCuEPkN9H9P4R0q+Z48sgcXrqcvp1VCgEeAPILHh2ox/It+WiGap3UcqGFW7Uz
         lBDDRJqnevOXnwHK5taeSxHa/5nXOpR9vrTYecsOEYV4FGYnD/VB3fP6iyFe/NBeeyjj
         Imc+CYlUiVnNsh8EBq3D19KpbK07CDYwxmbteMy47kjsXYtl6TOa/Qy11QFLZVZdITbh
         6bk0BbIL4OcMOFViaQYuWPj9iyBMO0ljYixW/HYMOyMzInMBUsB3Mrr5q7CwR1NFRYlz
         bu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mp0Dhk0lYnbwO2gDSPWZreLqZBbZWgOEa+uBM9bOFwc=;
        fh=wa7ft0M2CEK2WvBhk6sgeTmvCdI2Z3C/YYkYbUHtelc=;
        b=O/faZyBrlonrZXQqnqZM8MGJiRHaPnJabM/pXefONQMnjXxPxPKu+7tddMO5n6EiAd
         HJ+ndJqud/k7Ck+a7GPaMVVwFW0psO3AXlsXlbAuJ08UALhdCqwb0bl/3QNhaZLC/Isy
         chARtTwMD+Zb/vGj6X8qGg8fFhkMDJgmE+1F5wafASgaYIjmIe409pFaI94dyX9SoMPg
         nIaR76Assr90d+/jtd68FN/1z5q/rISwEAIyUCCqyxkc/CzGUKWYdrpss9oaCu9MJXig
         26noc11YYMdleCAKFnIIf5MQBNlUFctdZZq54EfVB20IyvcB5V8J55qhV7F97+QE1IMA
         P++A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776242662; x=1776847462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp0Dhk0lYnbwO2gDSPWZreLqZBbZWgOEa+uBM9bOFwc=;
        b=OVwjpQhfrQJREJW7sgaaQuxPFZrLF/hPaKkuU/LHNcdBJYwPpEmdDzxQBxtsowUwCv
         JK+ZnAWl/Qw4IFqxvFxK8dSdfaemjWHnLA+5IZJ5IXPRh0/Ud4OxhMsy+jo1hhdTJ5Qe
         xIPxwGk8qoZGhXIfRdPSkGx6RNv9hgDbZcZIxUFz2fDNvY4zT2H69MC8i2AUbXPnZW9Q
         RB4i4YoOnn12FMZ8MJB+rsiEBAqTBinWkGJ3SXmrDk/MDxebU1rfFe4aqlW63CDBmQks
         LB/qFGiXJwsTPzJ9cncS/xuNE0XGWgjh63x3xpmj1XQkghpXaX7IbHKmFDDeeC/lW/T8
         qmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776242662; x=1776847462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mp0Dhk0lYnbwO2gDSPWZreLqZBbZWgOEa+uBM9bOFwc=;
        b=fORMBjVIiEWuKJ49yTpRdV25fJW/mjPzXqxVXrJxCE/pSEnY0ZSQAzknVYQukpWxOU
         glXvhaVgHjGqwCYVnbdivT0qgS9Z+arqHat2wCiSjCuf7UrZid4TjiQdzTyJSAfVvUeF
         8N+40SFt3rsK8uCdxsjn2QyovEpqvn5LLpW6y/Ehk9cOhiouX0cmw7Tu6cQbNCez92tA
         jJR03Kj0SsglZ4yooFNCyootegTncDyd4aCSHLq5sPuDuLbhubUo9yOhc/ut7DI34PEH
         pd6WLl+2AgSlG4OSHPJFCyNEhB3ElbaYZ/Dp9FZbAb1/oIqBUZQzNHVy67fz+gAmJ47c
         ZAHA==
X-Forwarded-Encrypted: i=1; AFNElJ8LoKkOxY1b+gbUnfJDDvEHPWi8wZpLMXNPm2GV6it2DMLb10U67aYmMlUOnf7OvsBq514=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQjnQeBXX2GIdQB7wSakoCJTNIw6lDq/Bk9Z2iC0kN0SN8Puc
	ITFNyBokaQqdwMKG7AqT2N9RQPcK/0W4kbcDwsHjHDoqklqHAKaLXOjJRDh5xxTKJwv4GCstGkY
	Z0iaUtmlX89JTNNVk8ASuHDqGWZbmgbs=
X-Gm-Gg: AeBDiesRxyJ//CyBc4BSAtGaoo2cszBeoG2XCX/VT+xleh9gRMign3XCXOvz4UlfDxq
	BKeBmWju73x7UpOcPEAsnShNMqNgIvQP15dBJ8NCCobAs7zTOrvCWgMV+V8jEMenY/icvFPabi/
	StylyFymPL+0nViCWeyXOKau29yCFvYUcK0jk6DfBi/Mg3TtDKycy2GeoNm8QsAKlBXNEr60HUY
	4cVAGXQxRJ8ilJwKbjVO5jN6SLd/ryaz4QrUawnZ84A3a1KhT3JUrpkPXk52vWA/L+U9Z+Q+eqj
	tndbW2X9YexFO75ji+ytuE7KQHh//A==
X-Received: by 2002:a05:6512:3c97:b0:5a2:c686:9ccc with SMTP id
 2adb3069b0e04-5a3efe95a7fmr7954372e87.43.1776242661492; Wed, 15 Apr 2026
 01:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774701288.git.linpu5433@gmail.com> <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
In-Reply-To: <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 15 Apr 2026 16:43:44 +0800
X-Gm-Features: AQROBzCt2wgsTaaBC9SpVkmhIZQ7-Is_FsZn4GXEUWW-Zwn2cocdtw-dm-HR96E
Message-ID: <CAL+tcoAy5WQRsL6z=YinPaiBNvd_=WB7qsR4amf1x4=qVw7AAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] xskmap: reject TX-only AF_XDP sockets
To: Linpu Yu <linpu5433@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bjorn@kernel.org, linux-kernel@vger.kernel.org, 
	yuantan098@gmail.com, yifanwucs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:33=E2=80=AFAM Linpu Yu <linpu5433@gmail.com> wrot=
e:
>
> Reject TX-only AF_XDP sockets from XSKMAP updates. Redirected
> packets always enter the Rx path, where the kernel expects the
> selected socket to have an Rx ring. A TX-only socket can
> currently be inserted into an XSKMAP, and redirecting a packet
> to it crashes the kernel in xsk_generic_rcv().
>
> Keep TX-only AF_XDP sockets valid for pure Tx use, but prevent
> them from being published through XSKMAP.
>
> Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE=
_XSKMAP")
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
> Signed-off-by: Linpu Yu <linpu5433@gmail.com>

Hi Linpu,

Any plan to post a v2 with our questions resolved?

Thanks,
Jason
