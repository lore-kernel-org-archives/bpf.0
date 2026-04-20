Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857D6FC5
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776721796; cv=pass; b=Xm0C6QFIZPJI3o9KBQdbIDf9l/UysFzRXSm4VGAVNy9OCbUoTjcun/NMFFCBk2EIZnmJ9K1Kb/x75S0XtmYfIMbDdDG7bnkOa+ssfdvW59MNsaH4IDSkMgU/Dzzv75mfLxhxkjrpTLRhstvKpETbhXYM/N2MHcGcX80pkYC0tVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776721796; c=relaxed/simple;
	bh=IlJHxrJ3JreVN/Lh2HB8AMMXCOeLcMdQEFx2x8jYHp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wgikultor//KFJPH2BWApuOxsYUVM8TmX0VfmUjyU38lbpNnyzId6cLrF4bZwpidf0Q00tJacjoO91Y0t7ZAwXJnX0Fb0eULD2TkC/KAukjhrl7re75yYOVkGdGFGcxOhiJLGbtTbBGQR773ETnBr9K5qGIuR4XeAy7U5S1Xqb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D77W10Tk; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D77W10Tk"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d7650202fso2810902f8f.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 14:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776721793; cv=none;
        d=google.com; s=arc-20240605;
        b=bqBs2L6QjJhW17E1yVR+eL4aEfWDQCDPPlzmkoEr1Gl14RNMZeYefROvNbozHJi8HF
         Ubau2PbHMogY82Qe1e3B6uwoEPZf2aPY3z/FjJBiTTeB441aochs5OIyqhotEXznLTz/
         mcS2iuLGs1QwTPKUOSqxuUA7es863TFly7BfYhgKZdy7VpP/0LsiriQR2s30S4QzgWFO
         gtPS8Kjm72U2lT5LlHWX7PCv4DvynctwVsczUlrPo/o5T0vXESkgtzMtusowazt91174
         dKcy0agwuUUpC33CuI+EDA6KE3fohjqtT2DVH+TahZDVdT/YOEmX3hL5517HQM7iL63X
         qWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IlJHxrJ3JreVN/Lh2HB8AMMXCOeLcMdQEFx2x8jYHp0=;
        fh=ZqhAIJptzmv0PfdoMauuqD/XoYXp4JiXEsAqNq9C++4=;
        b=bY3Y4YyH+cPFme22af/YsxDNN1RyqhPeZFsV5BZPkqsnZoVESnwAIEfnevJ010mYyd
         XrBJBjUzrmapwVXSlAFW8bCy5y+pCV0NvcR4deULjQM30Q+lvv8pOWFC9zhB0PmydmKc
         hxWsnMvVYoGRO95IAesfpoLrwJp234HljqvBWKOjqQZOJDZiI7lUjLorh0efHJmDUUP6
         i02cI8RGH7WcWifoMx9t/kU3xPaXBWoA73+nYYCpYmSnXSNajAkX9gpuzd+f4fgVoGdq
         BjxIh7Fezq104rNW49CkwucwWzxT+idhV2hnY5Rn+kTYMtPA4CICmXfjsqEPf3M3CL+0
         qQtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776721793; x=1777326593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlJHxrJ3JreVN/Lh2HB8AMMXCOeLcMdQEFx2x8jYHp0=;
        b=D77W10TkPmuKDMKfDp4OnmjRv5rVz4T8cQg/pYqVAIvr7hPlYeS4FGHp2Ey5kdOUTi
         WtQuSnY7hRROMiFhS+fgReDBo9Y5ogJ4tovBYmlTQuCmv0PcH7DbT67/lTc8Xlmh/+T0
         firbkNI4CtuuppwlWzdWBrrro1UpFPMmDCcvgeVIAzfar6LGagXE6d2Sbq+1i0qo1UUi
         5HRnRnN6jeGsWfT/CAr/dzh13hzum8OyNVrk7g4GNkhhzBZmUF31OPEhaQcy7d/0PXje
         TJlnRdB2W4aWsM12U7pkvxI+WpyCRR/VsvZ1NFfiDhm++MpS84W9m9vA9eaxZjlVrIXk
         1pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776721793; x=1777326593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IlJHxrJ3JreVN/Lh2HB8AMMXCOeLcMdQEFx2x8jYHp0=;
        b=Rz1j6RHsFIyPVbxmYoyTBwYyqcCkSUaWZ/uN0HLftxygfyUpOzw4euOkPJkT22hDzR
         sFy1RebI4yAHEpKajhkh2W4lViA74/4+ZR9hJWHZqcvwXufsqbLRuP80ZX/0jjh0P3qM
         U/UiPAdTDgNC4DPqOTrUHZGLEK39+Qg0BSZHIjCRQlhOULLeESXsd8SRYmH2gluX7DoL
         jZRgv9FY9J39L+wQzJm+uVPbLgB2hD9/VgsQUgM6wSFieq1y9o5vXK9AHKuPY3j0NnHA
         +Q8vvL/A3WLz/TiJIQlZ8lJbM4QtYxe8S0mfJDX0YmABHjCWvlnqYjNAhL31ej/UASTy
         Ew+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ezHqgqBG8yIuislv/o0jTEw/85AYmVRXGdcSXXxLBObKRdBhwEvBKlmaCXMIDT2r7ZLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhfuSzQ8tcYY5tYR0xVlHBbkbrvNeuha2AfvYCIE8m2xhFMj7W
	5YGxnPRffgcsf2Jr2oUEiBkO7D8e1BhOo1uMvsesDk+wf91SDeJcKi/3SWyuAfx7I7Lvk4n7vfd
	giEklwPa/Wi5En+OX0XbcCMOXBOLlb2o=
X-Gm-Gg: AeBDiesj4Tdfq/ETYZgsy8ALBEIfOuXT33g64DXAhJqqdkd+2WQW5wVw/x8xg957teu
	2dbFwigIaQChbmp0xJ6ZLP0AaVL9s7gCR9PL/tzupx5OQHwAUfQ46lCWclMPwkGXUfQsW0H4xsn
	yStuDINtDbSYWFl2QnWPXGadatgU31KN58LdKxkopFAPF7vITNQIsAaAWVD53FWrOKr1/i/FQHz
	dyXUdTpeXw32yOm8uz8ejJnZhG+1fM6cEiKCpQMNcq8qFnjZFEuOf0e95BuB+j/v3UtcTGAN1K/
	RF6TX4YzR6Eujydai7yQHSt/QCtY0HDqqu6ihcHxEUhHzR07UbzB/Elt+3O3DSAk7XJKErg6IWD
	v7BAUxJwZmoUmVAG7Z5Sbgacy78J3+IvXAEm3IhViTd4BLBI=
X-Received: by 2002:a05:6000:2902:b0:43d:77a8:3baa with SMTP id
 ffacd0b85a97d-43fe3dc551dmr24162080f8f.3.1776721793084; Mon, 20 Apr 2026
 14:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <m2mryx1vwi.fsf@kernel.org> <21aad67d-97b8-4ffd-8b4a-747ee8b917be@linux.dev> <CANk7y0iU-u2=Rmi88DbHz_L87ERpXvUR0EormKqo==9KPh0MvQ@mail.gmail.com>
In-Reply-To: <CANk7y0iU-u2=Rmi88DbHz_L87ERpXvUR0EormKqo==9KPh0MvQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Apr 2026 14:49:41 -0700
X-Gm-Features: AQROBzBDPzx30ienk_33LzlxpSkvy17u-YgNJ5xbeBR-Yv3ynQYZbuMqgMixenY
Message-ID: <CAADnVQLw3LEh0sn-3F5dkns60rFvHe=0kKV7WCL9GPeCRP3Pdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/17] bpf: Support stack arguments for BPF
 functions and kfuncs
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "Jose E . Marchesi" <jose.marchesi@oracle.com>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 1:25=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
>
> Okay, doing it separately is better I guess, I will wait for your
> patches to land and then resend the arm64 support.

Just combine them into one patchset, so that CI tests it all together.
