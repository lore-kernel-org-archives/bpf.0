Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC443B9DAC
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279387; cv=pass; b=XrwRMx1bqN+asCwy6XgDbceiFCeXfAU7FTIVuYheWBS3EgtjPd0lQ7CVXs/kbTckUGEMsS+NMjosY+P8qmVamzhGFbR6vVqelLZlZa8RfZBER88tAE58L+PNzSxZut0+EXIsZelA0KZDrLMXQx3asXuyblmTn51pVaixASQQ3Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279387; c=relaxed/simple;
	bh=1by0OKcVPgwQ83UKqVqOXtfqRhrTuC3ua2RDj6TSuus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCruqqSgSiSnt2kyXKm6kkIuNxtoBaonXc76Dq16evxz4LhuqOBsSwcg7JUnv3RW9wsXaCvdawUwZAUCyrHI/LLLR/t/x0pXpPldT5lTatmIIaHGlbK8ZT7+ti00LZnHdlv45tFK7X/35Kb1t3Fg4VEmtznRweaSYG3ZGMCV/yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXXvAdkC; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXXvAdkC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so24882635e9.2
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774279384; cv=none;
        d=google.com; s=arc-20240605;
        b=VMDrMpGrgKHt6GWsVryozthvwN8BAgT2nFbcu6bVJ379IBm9OqrB1+YJe/siFW6sPq
         Ex1GUeGVf8Usyi18/Md/y29Km6VIZeWPImVdkEKK62OXMnT358fdicc7hHqfhEdFoy8G
         du31JS69EtyRDrkQjgPhCr9ZAH1v5xo2vtPZ8JxBgwH4xiY0LU6BXg1m3f5/kiMXuN5a
         ol74DA6xN1J2CWjI1LHfGMMniJHPDF0I8B9kAV6XGqkSY2ES4ReCdI6RoeaW81C4d9rc
         +x2JiHk0hxtfrpWiSyaksbjvfpWyCzF0eG/rP6NPurgP5964UZgA6u/oPeJ7lmySmQVg
         pnQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1by0OKcVPgwQ83UKqVqOXtfqRhrTuC3ua2RDj6TSuus=;
        fh=Z4JsaELKVFLnQVb8ifh7h7taU6GXGSiHtlLRNF8MLhE=;
        b=KXX0OeLCnrblfGcQYMnUijQP2R3PVVGFNhaw8htCihX9wf3MFnHYUQ2uG1/1R+lTD6
         wnSlp//XEQL80OL+fuxi9XQwyVZURhb5NiCdf11jglfljk6eImKDN+fWQQRSsOuTrP8j
         s3hXFSIc+9e01pO5fMBaIS7yrJvgZ5a7LesJgX1F1WQXqng0GBjXN0T8vHDa/itHL6AJ
         80U1qp2Vjj5pT1iCaBY1/l2m5D9vWOHGfCws2aqFe5CGyO63Hvpsz4NV9DQEJ1nOWa8j
         3MEggtFBxAczHGEBr6d9lKRheWDOAKU/CyCkbOX1vcsJsGuQhuKYSXl0j6O6Uf2IaXTQ
         bbYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774279384; x=1774884184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1by0OKcVPgwQ83UKqVqOXtfqRhrTuC3ua2RDj6TSuus=;
        b=NXXvAdkCtCEOE87CXNBTbJAPxTjZ4TmDPiM46I7yetW3WJfqk/UgK0ttfyFwjYwU52
         QmC7KBuJjWUWI3TEh6aUQ9euVJwOG1P4kZDv1ECyI8N7GrDpUqCu/C1bVsqwIrQpwscH
         ZXcaKXOCFQlMPuk6i5UymNu3dd10hDuU7GEqI+yU25o2jUslrg0DwEPRYPsrqj1hlzF9
         UQh9T0Wjd6O0DzbfgArXFZBsP7ygCADFrniz+vWVAd7dd/RuXJ+a/tpZAGdA/5KHZAji
         RnRj7AvvT74jxBqtLCexxjL7VV2NiOVlNTa61RFU8Le/ol5uFgCLI9FsxtV5hdk+7SgD
         p1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279384; x=1774884184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1by0OKcVPgwQ83UKqVqOXtfqRhrTuC3ua2RDj6TSuus=;
        b=a4dXaTMLJ/s41dbdmD0kVJcw03ybojpuks/cq/BZZpz/fiOzSJ7PPE9SClqazFfWBz
         uNAzvdPhmRv6Mu2hWoVKX8A1wS6o2Kopn139irS9qyzJ6h9LUjbKNbjcl+wZuK/xVoud
         6N5TWdgyLkz8J1DyTmcAFZ1B7xqNiq2yY94tJiCkjZwuWCliGBtk6ipbDpnttcKeVzzQ
         ISvqsloMmQC3EGfE4Rj/zMsx4RXaj7wf41o6dLU8YorL06OJVzWeP2QIkN5pQ83PJq/s
         bwrFbMpm4WKO9tzdtcF33gQAkcGiW0UT9IXFc6R76yujzutgSppETQZ88rrn1KS5U4Pd
         C4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4xOqGSofxEUYYw3DHLYU/OfHlf3064S9v+gYLA+wRlw0XLX5eufQxym/M1nJla+Uj9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2D+QWZqze1hSC4Lx9eFp61wg0TyGZMk56Q1Z/RJLKwrGZ0N++
	ThC16m2CVGGvNX8mtmpU9IlGmUWBmN+IijnrXaU62dbILiGbVYh+1Y/k2hFd+DRr+JuEcjS71BS
	BHPYLX+TIiE/7asM8P4GWMr7JeB4Sen4=
X-Gm-Gg: ATEYQzw7Ofvf8/y2EHbIX4D33Dp1k11DTqFWMg7ppOI0MTgd5JCaJGxTQtIagXUcLFg
	NQZfm2vp7fvRxjKFNaNPZrjh4L3wH4+h2w3W9vVlDoFfVzrsFDRbi/AyicTn1qEYBaqyLS/Qxay
	rAI2hSM0IpNxE4YCTEmIv9/nQ1xVxHjZmc1BvSpJU0jkszgR+Z7atQ+NfZdKpkvvV0ETW4tccGK
	02qKTxp+IIpt0I/w1PNXTM/fmEn33wTNj83tlyMUDfP8qg5Eccdmy6E3SHT6BzGZsKomuNQMHXE
	u/cpyL+Rxo7HywsCMXt/6IvT5SJjqMsP7ioh2zzLNyDeBttPzraSavju2z5Mlur+GiWIedBYVNO
	XQTfEvg==
X-Received: by 2002:a05:600c:8b6e:b0:485:3949:e5c6 with SMTP id
 5b1f17b1804b1-486febb56a2mr166258475e9.3.1774279383373; Mon, 23 Mar 2026
 08:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323090508.18986-1-ziye@zju.edu.cn>
In-Reply-To: <20260323090508.18986-1-ziye@zju.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Mar 2026 08:22:52 -0700
X-Gm-Features: AQROBzCXJkgSoqG1WoeHugTzuT5IdZszduMQn3dWOu8DEJGUgtJfbJL4m7fMrPI
Message-ID: <CAADnVQKgyDkH1xcrQTD2RgTz5k+NAwxbmXFnJEPosvCZH6J5NQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Drop redundant CONT_JMP alias
To: Tianci Cao <ziye@zju.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Yazhou Tang <tangyazhou518@outlook.com>, 
	Shenghao Yuan <shenghaoyuan0928@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 2:05=E2=80=AFAM Tianci Cao <ziye@zju.edu.cn> wrote:
>
> Historically, the classic BPF interpreter distinguished between taken
> conditional branches and fall-through paths by using CONT_JMP and CONT,
> respectively.
>
> After the interpreter was migrated from net/core/filter.c to
> kernel/bpf/core.c, this naming split remained as a historical artifact.
> However, both macros have long expanded to the exact same sequence:
> "{ insn++; goto select_insn; }".

It was like this for years and can stay as-is for historical reasons.

pw-bot: cr
