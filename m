Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136CA36EAAA
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186140; cv=pass; b=NFCYK4EkGp5ExDyvarcsoUTIrX76RnwIbemq+NxYmtbd9fOucgoPafmJQCMWnkwth9k5/1fJn2ZVxTV2wLH9xxWpzJZGvIFHJCtAzIAo8alJ5oGDrZmsu/oLaKWTwXFIwpWTk92WcVbiekuw1Qyue/+heiImP/39EHFK8oHNhxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186140; c=relaxed/simple;
	bh=HiSI0lU9AAW8Bi7i/XZVtO7ZCqEmkeDjYdIHFxH1EcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V99EUJ/6I28aEnD2BdjqEKWb7eyaDBkAKIS32QGmuiNklVz3yuuAVn2k7Fej9RUrybGjLZ8BsKI+NDJ4HQ8Oy72Jm4Pev/1Bum3LJhxvqlRmkc5A/qa2ZEweMyatMs4+RN2v0stZgplESE6RtqRQajWCHdlVD0Q2qsSvkMzWnGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lneGFv/+; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lneGFv/+"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-679b072ed3aso1351753eaf.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 01:55:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772186137; cv=none;
        d=google.com; s=arc-20240605;
        b=Dp+5HP0n/Rcpw47mCRRjmxbfJNO/cyxgifXbouR8TeRpLtsPxXDVnVdzpzCRBWMs5r
         FnDv32TSFYeQ7u/wZcQXj8UpegflN8LLVLu/V2OWpxj0ugWM93QnmnYiao4xx8EnqEkY
         wyJZ9Tp00aJhuoyHiwzyJJW9P81FSy5d8ZYjG5yNePND/5dd+iIDZggQHLqRDxT7zt7u
         7NOZi7JLVNK7dxP6g9eGnPzbcu0f4/vNU0eBaCIHAzOpsoTHI8V61mIsWolMW8qKM3fQ
         R5NDJhRXGhsLiwsk9TUfpMmEyiRnTLWv/JriPlenuqLTfeaaYTSI989mJu8FI8mx80UL
         hZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S/KJb9IiHquzk7HYxCf6i4TfDA+7vLU5j0god34XCBM=;
        fh=1EIMotNVXoXmqTDjGnC0mj9oauOt6IEo2nzZoqk4wRU=;
        b=dr0ugItgeaid/JuO1PkehuujBn0wl0xcs5EXKQ16Plc/jGqeA1hTh4DWDzAs157e6D
         mKK0vri39igRgcYTpS0DxgjFTj3IkHCBZrBW9eD0EAUjaSwJ4SvLb9aVPQaQIpFM/TIL
         gaI82zIvDumC5vUKEYryxeUn3DhxDVYbGrQN44qegwqSbph5EFLCohEo/BguefU1EpFU
         Szhn4Y0JoM/98IVutMpO53dtZD28r6LmeLl7dAB8fllpFBDd9EHNM9V6LqZqgxSGGsV1
         zOyn3uJyFs5LLelJ7JaFnsI4eWH+ZWiqAjCh76avlkl4N6K/CUx7cnBQOK6PzWgZeLJW
         ltgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772186137; x=1772790937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/KJb9IiHquzk7HYxCf6i4TfDA+7vLU5j0god34XCBM=;
        b=lneGFv/+AOYYGckSDGCrmx6hf9awI1TUq5GcY+7rIhH+jir8rt0S0kE0Uxhk44liZk
         Vr655LgBIXEDFmKTDI1xyvYqyIVe1xI97vCdLv/18aqqMAAfBXcwenoo5Gue31ad3PsI
         x5haee//9lNIItvOP1J9+wKBg+INl0j9Y97gWmqDgCGfcut94BuFCWGDAS/wgViwqere
         pxMf/se/WHg92fGAbTyXztHbStAwanRp2zbfl08Xq8o73Nqvj29M5CqWHvh3ytIzH65o
         ivxcTl8LDa8Kr5f6Hg67DqPewDQHrpnbD9MLJp1IwkTGAbhhaxm+MqOtucO9nWCxCxoa
         8cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772186137; x=1772790937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S/KJb9IiHquzk7HYxCf6i4TfDA+7vLU5j0god34XCBM=;
        b=WozK1Y/n7ACsIvF5ufXSwE3z7GbxL4wLzb59pUgWYvEbfIWJlOXhf2J8fHZqiP2rLD
         iBjFnwDDihmmCnaA4CgIzkdkN0e3L8tNgSWBaGNqsten0AuBUWpBunQkz4mH8gwV5ktP
         orDx4Gy2YxZ2etLa3Svh0P1GmzgQ40ovKU3JMO59C/4Sy4b8T+RDoOiTPLQ5scs/sUmg
         0jgSOloPT2eVEOgQvmOGqmOC6CBrHFfAmrFT4HlCig07WcKXJwJbZP1WOppCIrUCqeOT
         KvdVBaZNUTt9tIHhQZACnlS/YmN0GJ14Njbc/UEUGvnNioADnNaqnHI4fps7rPaxaTzi
         BH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3DwTgGhGuj3CudvL6AXKddvsC6M35U63B001keylH5wM0A6ue83N6sshNoZowHDMYQmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYVSI7NIchYPV2jUd801GXtNI3SZ7xZ3jxOR/u+kk1RsU/QxR7
	m4KDyEgQxuRkTWJk+CtHHKcyOp4sc6wouxqb3uVFaCu5NwUsmTYTkZAqPwNRpB6ZlwcTgQqP8ZL
	+fVao23+JrWjXiEgEMWLvq9KM6EWIS4k=
X-Gm-Gg: ATEYQzySgAOM4TRsauBj2CnxPYCGW6wdPc3VNlUhdav2/DhLHR+T0PheIZV+nkp3G5P
	ALE7szDZhl5OQi9X99kvpOjpXZ+/m0Kdd5izPtlhfPSNyGXxV0ksTRez5vFDsSr1cMkuZvgRvh0
	70BlXhgWEaRd4LdhpM4UzQQ7slxJrqU4u3sLNQjYSQr1q8vDKeJShYWrUx+qAUw1/YT2VMLz1kB
	G2zvKABXLqqgVelP3dGqk5fdzQ9kFGCeez/VIcGZuzasUuZdgnGN984S0Jgj6WBnSdt1Mj2sZNC
	rN0bEM2VUUyDppWTc1s=
X-Received: by 2002:a05:6820:488a:b0:673:ebaf:ce52 with SMTP id
 006d021491bc7-679faf84b68mr1104232eaf.57.1772186137013; Fri, 27 Feb 2026
 01:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224073515.1273-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260224073515.1273-1-yangtiezhu@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Fri, 27 Feb 2026 17:55:25 +0800
X-Gm-Features: AaiRm52XVBiKUry11FjHKqNVfETs7nGqLIo9iJjKEFSTMsaM-HMLMgEvnGKb08o
Message-ID: <CAEyhmHQVTzOohJUAL5FfP39pY=8q=ui7LYE3Z4+n1s71GK3Shw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] LoongArch: BPF: Support more features for trampoline
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 3:35=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> This series is based on Linux 7.0-rc1, tested on Loongson-3A6000,
> the main aim is to support small struct arguments and 12 function
> arguments for LoongArch BPF trampoline.
>
> Tiezhu Yang (3):
>   LoongArch: BPF: Open code and remove invoke_bpf_mod_ret()
>   LoongArch: BPF: Support small struct arguments for trampoline
>   LoongArch: BPF: support 12 function arguments for trampoline
>

For the series:
Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
Tested-by: Hengqi Chen <hengqi.chen@gmail.com>

>  arch/loongarch/net/bpf_jit.c | 109 +++++++++++++++++++++++------------
>  1 file changed, 71 insertions(+), 38 deletions(-)
>
> --
> 2.42.0
>
