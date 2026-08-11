Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDA3DB339
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484238; cv=none; b=uzRM3O/nR6j9TmOgKRk8JyZp+zt2TNHeK40qqr1OX/b5Wbiu0GeRGZziK0i4ARAyZ3VWduu2mcllGfSF/0JJtSOj4hsVzq2+ug9WEzqbmjZ7QUUV/B2qN4K6KLjx+zyNaFRuuaF/PUQSN7aYLIaccuq3QKm2KnNltqvzkL/sgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484238; c=relaxed/simple;
	bh=KP59bD27jLr4sw7H2xEom5966sKh/5s+NobmGVYQW9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YYykLCp6Mr9YSOcIEq3v856U1/mU6vzzEh5kIc+W9zZLwikpLr5HsXAdOSOcyo/kI4mnDjvDfUyWoiyxVhfsVbkKapQ68cVk0KLsSsp+BWNVFFSzKk+7HLUXDYb+VgloLpqA5uTsESrI5rFNhBp8BOY/D52IRybe8lcYMLBFjr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=soa17X/j; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soa17X/j"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84f77cc7302so153573b3a.3
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786484236; x=1787089036; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KP59bD27jLr4sw7H2xEom5966sKh/5s+NobmGVYQW9c=;
        b=soa17X/jTdGqoAevAHXP0stU5bvB/fKYqIiQeLXkqeeutiDzw7z1L9b2XcELDvNREN
         MFxkBlJk5XztaTh/zoMMM7QZP6gJwxGy+Uy3ajOHj6BGoVNSV4blkjjL8XLOr4833+5l
         /HKf1wBf1Z5lb8C+GuQwJ5uwJKvFcqd/UjU2PiAn/nDrL8BBDPtbaQXZD8qr6/+TApwc
         5106EHr1/FgPrlArp/z95dEV1mtEoXdm071NK4eY8dGzt8bIXo/On9Gqa1KGVxKYpUzx
         zE+Hmabq77ttEh21IXL0USTAsbBPOx6ivAp161mO0aG7EmP0hQz29K5wtURPafZ7rqpK
         SfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786484236; x=1787089036;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KP59bD27jLr4sw7H2xEom5966sKh/5s+NobmGVYQW9c=;
        b=oi8h8EpWYzzimnD+GUOhnPaFyWKSWGeK/cjvzrMUwJdtBHA2slAdCtUFXan36KlG0J
         geZprkrdw7ddh/9wr57plgpwjYtm1dK9yXkuq6GJy1j18/FCtw1NppQFurRFNAy/SM+T
         9OEQvoUNcSpS4jDc+nZ+yA1tD9dtjBvaX6uCPPAJHjroINbcWQTpEcvLk7yzrosyK92I
         mVrgtp1REmJWu47kYHb5utLq0t+cgEVKMOqOeaxmUFFSus3XYG2DYTZ01oD7ZFzhHXDP
         pxUQO4a7BiwzScJkU7msf3vmqruboqayC680+kSRG9W9Hhkm9NUaRRpHXaM0scpX6vFr
         Gjmg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7lEhetFZ3WhtMBmtXsSrINe+lpj1tujHdm6ZUTpbOmqeio7n3HK7b8TA4VZU4Vfr52C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGzN5z+0Wn03IMJUAZFT/yLGfMGEu2Ply642zAAWgbv/fgGX5
	ynhcqP2FF3rfm797MedEGK3AMMHUHrukQq4rEeQHN1+zT4bvimBRWBoa
X-Gm-Gg: AR+sD13HL+nwJVGmhjG4tVdg08V2a1Hl/86ZlAxiC066skWtU4M3EFZMOFAqN1+BPel
	GuF83GE6gtzqSvCcs0+IeoRGWDzbrJFopGOtLYlZ2RHNWMGuao18k9K8evU+cl1UoiQkjXZ8AU5
	hAD0AZpEtmo90c0jjxq32aC9IWbOYI1sZq8PXYm7SBVHPsOllJ0QVUWdfm+6OexwLRmllTUfV0K
	4wA7frfXu+RsFXeyNx4D18Gxs76PsPZBmSErZWlz0tTIA1V7aiqxaJGvKFddzbcWZVccKC5RfGP
	17z/MJdRjP1T0bddYVQkqVxxceyniFXM7Ra94KasyasmdCfdy2/4nyQGW7x5DSK+d0Qits4qhaT
	XyuKByPiky4Jaj9KcgX2tRy2Ngo+70lOFF1nw9nkJ+gtsB9UuZP9I6/FDYvX6l+kk5LrKNakX3m
	c52hsprgG2YCnejiIRYHfGQxKU7AWhKPk3ytA5iH+Yt4WGziGyyVGYR1Tod2IaNK4Q4PNyaVXrF
	+Rs/colOv10U4J+4wjLkqPuzATk/p8aOre1SBHF5BBOhA==
X-Received: by 2002:a05:6a20:a11a:b0:3c8:e313:8d42 with SMTP id adf61e73a8af0-3cc2bbbccc3mr6579748637.31.1786484236103;
        Tue, 11 Aug 2026 14:37:16 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cd18:dfe8:e39c:4123? ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14124454d3csm2895670c88.2.2026.08.11.14.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:37:15 -0700 (PDT)
Message-ID: <a6ede12a860053ec95bf1fe95e69bb877ffd955e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 6/6] selftests/bpf: Test subprogram
 instruction statistics
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 11 Aug 2026 14:37:13 -0700
In-Reply-To: <20260808062601.1070988-7-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
	 <20260808062601.1070988-7-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-08 at 08:25 +0200, Kumar Kartikeya Dwivedi wrote:
> Add small verifier programs with deterministic instruction streams to
> exercise per-subprogram self and inclusive instruction accounting. Use
> assembly for normal call chains and straight-line callback bodies contain=
ing
> only moves, calls, and returns or exits, so control-flow pruning does not=
 make
> the expected counts unstable. Pass callback arguments as explicit assembl=
y
> operands so the compiler keeps their registers live across the asm block.
>=20
> Cover asynchronous callback attribution separately: main verification-roo=
t
> totals include all callback exploration, while static and callback totals
> remain local to their synchronous paths.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
