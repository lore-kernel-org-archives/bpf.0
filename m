Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC2265620
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 05:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780204708; cv=none; b=IaJpt7QQM0R21dk6psvamZvRct+bPEjkgpcxLdrJQwKvM6lr0E0/RQ5F8IuCIXL0mgDJ1Gup8N9ltrJu52pwmLR4hb8gguauw0n2e161451/myYAo7b3jMHyBtjpsQ//qt6VAD2N3LwIjpzPKSQggVVUUN8vqDLBI11nb5tv54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780204708; c=relaxed/simple;
	bh=Px4nFEz1UEBG3n9dnC0Qf3LTPV9/tzMyHk0YRBXyVFs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=USO4+5KcN1QaxImeFD9uTflryZ3a2AYMhDdrS5xkYvJw5rHedBlRhBJ2pXRqxCEL3Fl8rs6L8ywGpB5H10CGWNT1UymHVnKJpDezNBOXWEnrDyFTPKSfKZ2wfz8xejP5OZDw8YMHwtpW4dUHKXzm4BUSutw4NDzUSUTGCqL3aJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn2L1K9h; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn2L1K9h"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-48544493bd1so5215137b6e.0
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 22:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780204706; x=1780809506; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGAALg4v24MIG6iZqmmf3RK/ZE7OvwF38ejvXCVftvA=;
        b=Nn2L1K9hi/ogEbv+Vkz2BTGarUX9wJllAzAPwsh9UoEGC2bXCQVTmzvl/ktdacgw9t
         PYoCCBw2kY4t83UWFN2NEros1Amy0duo23JswkNogmXVEqeoYjtwFb74ZwIQ8xxUG2Aq
         M5fYtl8pN6p7Xrd7EHPfibw2x2BHA7+zij1fcMzTbPGGKrVYnfKu5TllBE/0ioIh1v8i
         seAyiLMGGrQiUBKWGEjSMGnf3Y5dxHcGerauw2REoA45H9nC7QIvejJoxQa1C2akB0Qk
         +pkq6cmmCppEKszzYfAS/fDM1UQ8GfX4e8jF+5acPHXa/lIQcbgbZ2u5DuRi/trrbYBL
         MEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780204706; x=1780809506;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGAALg4v24MIG6iZqmmf3RK/ZE7OvwF38ejvXCVftvA=;
        b=Fy0HNLg7tusgOZ/6XaWeT4ct2OSfObeRDeRAu+QlpFr4yXdKCoffut62iuUizLQRHi
         pvICiVy9hl+wBnhlsyW95cz7nCtue0ZUHKbWkB2Hu87eLnAkbHtKM98gyFPTXmptGtuI
         Vb/SeGWvcuzpJms+3o0Pc5gLfnoxZ9tQhgwTiUHHFhkLyRDKzwFLfjNLyv69JAhPl6Qo
         zPIyw6Whm7aH38M2dM+4hJ4wbMr06T0vL7iJhYo2/3TWjrfMolx2qqM3Da6ehszXLDUL
         CT/EtcuyGdSq4UktiOxiS64BGxrQdc35JKrfdusGinuQH1fkD4sw/0v+HRBiQWq6Hksk
         83cQ==
X-Gm-Message-State: AOJu0YwhYW0rEjWt5FcgH0S6OMA/yLhg3fw8deUUZnLlrTOUkCvO30ss
	2McIHzBPcLgnRFON1IrHJoVnEPrW8P4DNyoG13wyyKti5pSZYXvuHFc1+mfamA==
X-Gm-Gg: Acq92OGm9z7Fb2jgS2mXH9526/DhUO90gyfMecEWX54shSQlkf+TuhXDT3tQ499Gs2i
	FxjN+i/wzfJGdpgeDR/RRvOPfd1wCcm6unJamGmO3OVkUSUMGOIBvV7ZzsA++FIDOnTMYhZ2g7O
	WdqJ9jphZAJ3frBPF6jHb3HJtJJ98xU/sdZU00uBeDOqDLAwLL418UdULPeVS4Ohrpo1qiv8XvD
	cFJrmLkoerIQHgzt3pNFl48vTXf03z0q7JqpJN/oh+G8oSAHaWsbUzrDJADi7ZDbylHzMXu7cq+
	0KTaclr3RzPC62UBTI2wswjdNvQcV5cdUk3ZjBSGB5kbcUbcYH28pq/fchSzSe5E/NjmMdnNynx
	ND340H11R5BpzunXdI03cvr6m/Yj+sFqozHSJih0v519aZbXMuQVSW3K2U6hed4NbqPhrQzjcDK
	s7K1g1SNEFTUdpfPxLnRDii5Zv7mIHKOol4WPdPzsBRGFEZkX/+RdqgXdq69/O6AZjwB7K1C9gX
	CZMUZsQCLtvLkBTTpueTH+tye9Ty4tZh6QW
X-Received: by 2002:a05:6808:690c:b0:485:a8c5:de75 with SMTP id 5614622812f47-485fb49e60dmr2945735b6e.33.1780204706378;
        Sat, 30 May 2026 22:18:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48606166072sm2087506b6e.11.2026.05.30.22.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 22:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 22:18:23 -0700
Message-Id: <DIWLWEKAUX29.3HJP2JO064JLR@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 4/5] selftests/bpf: Remove __arg_arena from
 the codebase
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc
References: <20260530002259.4505-5-emil@etsalapatis.com>
 <20260530050310.113761F00893@smtp.kernel.org>
In-Reply-To: <20260530050310.113761F00893@smtp.kernel.org>

On Fri May 29, 2026 at 10:03 PM PDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Incomplete removal of `__arg_arena` annotation
> --
>
> commit 936642e9509313ae2959c6a3c4255651cca7040f
> Author: Emil Tsalapatis <emil@etsalapatis.com>
>
> selftests/bpf: Remove __arg_arena from the codebase
>
> This commit removes the __arg_arena annotation from the codebase because
> it has been subsumed by the __arena BTF type tag. The typedefs previously
> used to minimize __arena annotations are removed, and the pointer types
> are directly annotated when declaring variables instead.
>
>> diff --git a/tools/testing/selftests/bpf/bpf_arena_htab.h b/tools/testin=
g/selftests/bpf/bpf_arena_htab.h
>> index acc01a876668e..eb80d67c38708 100644
>> --- a/tools/testing/selftests/bpf/bpf_arena_htab.h
>> +++ b/tools/testing/selftests/bpf/bpf_arena_htab.h
>
> [ ... ]
>
>> @@ -53,7 +52,7 @@ static int htab_hash(int key)
>>  	return key;
>>  }
>> =20
>> -__weak int htab_lookup_elem(htab_t *htab __arg_arena, int key)
>> +__weak int htab_lookup_elem(struct htab __arena *htab __arg_arena, int =
key)
>
> [Severity: Low]
> Is the __arg_arena annotation incorrectly retained here? The commit
> message mentions removing __arg_arena from the codebase, but it seems to
> still be present in the signature of htab_lookup_elem().

Spotted this manually as well.
