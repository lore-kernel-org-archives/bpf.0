Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E073FF893
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538332; cv=none; b=J7hKk1zYmV9h2h/PpuKIDrMNDgyVnDa1hhpIAWvTxlDAi+rM+X1vwR1Nkocn/8cg279N84xFc+vNLkMqXcxT3+7rwOEsa3SdIAQTEEciVZ9cY3pHjKTseZQIs/eaa+vBRRLuB0meAqcAS+ZejqmG8Q4VGbOusGPazhTkM585fE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538332; c=relaxed/simple;
	bh=QqoAvbiyQQgUhV16qDYAHCAa0swk4FHa96i9AC8gypc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=fKaKh8OKnW4MQ33Tn/UIeR9G1sL87Mn7mlNe3yWLLvqgU+Hb8OiXRvXDX9Tc2mHtld19IO3KNT2wAUkcvl6SGmjihDBUVoeA8JcgJOtkJXWoAOTw6iSM3tzLY+0JKx97G6AfEB1YJmFqFP6se20mk/skr5PYp7b3HbLE+MUVY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcz+cu6H; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcz+cu6H"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43d26679a6aso2034672fac.2
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781538330; x=1782143130; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqoAvbiyQQgUhV16qDYAHCAa0swk4FHa96i9AC8gypc=;
        b=pcz+cu6Hi6dIbLwYDDhcL23Gj5VRH8IiUq54cePSY9wv1fXAYSfaxPPPwX6sKTahB5
         DyAfoEYXjHf2b1nX3wi2u14S860c6+tGeo8zAgoeLzsm43n7PCmDrOCMPp/hdsFBUVlb
         tUBMwMgtMJhxvicVdhXisZk+pgNU5d+hQlz7u+yJQl3idV1auneXw1LcLI2rETa7yKvV
         7OhfEOYEne4/Ua5PNZlooJVxRirI3fVh238ayywj6kyYa9bjKp6NBFV0FDgA3qYtLgI4
         7NBnNOVXnmEyTtAOdFPm6u8uHKUESDymd2e/lAsTogfAF0Hh+OtHe3RmE+gJlFZIW1/q
         hmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538330; x=1782143130;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqoAvbiyQQgUhV16qDYAHCAa0swk4FHa96i9AC8gypc=;
        b=KFd//i7NNqlJyqNoK8qEVdyaMKnsnWYvNnhr/dpscaUpluDsHWlNfWXanMMehS39y3
         IwZNs8YpBK1S3ov9f9yAmFPQjH5/1C9aLhcM/iGx8hxvnODseM70L7BDWzX6Y9jDXumY
         7RltE1G02jcUh5SJjA1hsL9YYZZtmGdkvL2YiWw4Km2gWl5JlJ5iaxQg6uTBWUnADg9g
         k1drRAY30I3UqT22nWD1/9A15sfuYBYsSjO/Hw/sqwbKsE6lGgqV4bceTS05gCA4+w1/
         EqDF20rHhwRijYrOvZMAPCBmx06SIqGlf202SwrajIf0pqH6BVFvRPCQpyvzs476Ajee
         wvdA==
X-Forwarded-Encrypted: i=1; AFNElJ9qRjwGvyEObFdm59hhdtRK85BtlgVYpiPM4a/UakSWF6nq6o8r2wYL/CzrQONpV3uvQ2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVEGwifwiKTHYYRaYJzBe4sGq4RzkbAeRWykU+N4DzSBBbwa6I
	w3Jlnv4GqlIxHSEmZBo5ctrKEvrrqZ53oPoqSZOyjAyjnv33jWMKoRxo
X-Gm-Gg: Acq92OFzNa8hZerCwOTyEhsRGBGdfxC0INj/lY26IfWmxqdJhpySUOBsGYjq88WhQHM
	fhhhtKjFPxI3zgT/h7NeekVGq0tgWXAsKiWZfvUCurM2ITlBLRoWXaO+TSsgz4BtD6EvnKgOKm1
	ejojCFn5kBgJbQSHopaJA3bukniRAuc/wfYLHtHyBNiQ1+U91zufQkwmZSdhdC7DRjuicK3Igyx
	lt0+8MPKV/LkHHaEJqM3ln7K8SAU9rujPTrtNCt/6zQRlB316BgOEbnM8U71kfMFEUkFQSTURAO
	VmuXhtjb9fQaQyZtguVx1FyU7/x8VSp3/Wf9jdXf1LjBUaQIQ1quVWocPM6UHDCsoIj2Jhwcgfr
	/T5MrcKd38smrQXDoOaBZM4xWrvkMhiLpKzVIJJAmAjEsXwyFf3NKshLd1Eh7SAz73OPDZYBeaT
	Uo9Vq4M0eRRdHL/HrD6Dnmv4VBbSWLVJdnpXqxB/LDVyqzajuEbiXC+L20tVFc76CvIXPw9XKE1
	hPiMftTxJAfZl+QhKAYoobiLbR2
X-Received: by 2002:a05:6820:f00e:b0:69e:5175:de1 with SMTP id 006d021491bc7-69edc76c580mr9255765eaf.41.1781538329976;
        Mon, 15 Jun 2026 08:45:29 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308afc5a5sm137996fac.5.2026.06.15.08.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 08:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 08:45:28 -0700
Message-Id: <DJ9QMPLAXOGG.2PDC3A2MUENPC@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] selftests/bpf: Add some tests for
 LoongArch
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>
Cc: <loongarch@lists.linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260615100506.19558-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260615100506.19558-1-yangtiezhu@loongson.cn>

On Mon Jun 15, 2026 at 3:05 AM PDT, Tiezhu Yang wrote:
> This series is based on the latest master branch of bpf-next tree.
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/
>
> Dependency Note:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This series strictly depends on the following LoongArch core series,
> which moves thread_info into task_struct:
>
> "Move thread_info into task_struct for LoongArch"
> https://lore.kernel.org/loongarch/20260612011616.27771-1-yangtiezhu@loong=
son.cn/

Pls repost when this patch appears in bpf-next.

pw-bot: cr
