Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84E18040
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 04:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032503; cv=none; b=RYsdmcrqBGJz6YL8QSAMKjyk5UF8NTgQyCIdQmbKZMwVYnCC1lamXgwP16Ury5scXVQSnt3M39dT3LN9PDlEATB2nyPOmxH2Da1dFplPNLgD3Z696XHBVaWyT67Wh7omkUaCDg0fEvtlfa4Gur0wT+iYR1+q9V04zVuoI9AAWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032503; c=relaxed/simple;
	bh=HakP9ucsY44k0Z5vms/GDuf0YjLU1i1WvMCEuYtSLjI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tgQUi22Eg5G6yPFu2GS0OKLDGr2HHTfw95lfG2ET3RySQpeYwB+EyAs4DxnJpUeHTodpfcwvRYnwQz1SSE2e1emI9J7x4wiPlvO/xWs6h/KfFlb3NSSJ+fhQOdyYJqYPqOEtp3yf0CLc5WJF6AWSKv3N6u7b1G/LaS8h+Bp4Meg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEbe0PkZ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEbe0PkZ"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c4f55a1bd6so72201b6e.0
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 21:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712032501; x=1712637301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWX8kuMPXdFDyZfMcll/UUblCrh8gZic7wBnI9WBgxo=;
        b=IEbe0PkZyGupKUlpI2sNGkcFQuRnNT6ZDDGUaVC4mxsTC0ttG4Lgq5J89sD4qcl+ZB
         nSBGZ3e3+a90QRAlLW9Io08JF2NZ0RMiKpxCrd+3hWnqoWULxPXuUy/wtiDb4D6XEXZ9
         84vcfFXH+6O8dLb0Euu+DrzWESjoMKOn/hEdeJaiL7dB45JiybNJsrRYk8LwOcSk9FLh
         VWUA7ZZmlo2i6HeQtbKOYtwr6CsfND3L+zLstPhvbKRhcLYteUtXQfhbaNKHVjyTZqAb
         aa+d0jCKGRCjMHlllardANAGB/VczoRvDFVx72pn0p+1Y6MJDEJgML4mlwFx7zsgfHzP
         i5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712032501; x=1712637301;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xWX8kuMPXdFDyZfMcll/UUblCrh8gZic7wBnI9WBgxo=;
        b=w4SEw/rfv3DfJGoDwhJ8tin6Q5HsWy1y6OFUjMx/rqVhGvxonGWzYhGismfjcwjaiY
         vj0PwDz2+GgOmBIhL+TmCCd66q6ftPiSqTna7Uvch1iN3wKD/cgzh09Xy3gg42vsGuRt
         c05rDA0p4cISzvLCnhFeqhbOoBG9rRUWs0OSG5auCQrXCL2VOKUYwQM0wDvk4URE4eLx
         w4r9PPzS+A9vmKNJCCoZ4Txk6MKw3iJqSt6UOoigqH3E8l+q+t5jaTYkgkwFzrKkJU1+
         /rt4NI0ay7SWgn5+Hxfbc/zVYcdRtr4zo4KsHFrVWX2yJAJvztDwaQ0lq44XQtb2wPlG
         xDsg==
X-Forwarded-Encrypted: i=1; AJvYcCWyWTTyrXVrgdAxP6ZwJoFhR7eVsZV9DmzSnDMRp3FNAKReuxZ0xBBbVVYQJldX70ujhdSHKPZcDN4GUCrhgzFWqhqh
X-Gm-Message-State: AOJu0YxMpxIKSzlV3/04PcYVkoDgSgAXplW+scYSm7z8vsTnvxLk/+f6
	RWeMiSdu43eFacBFjj9YwV1xcehufgQ5RGNSs1ptjjrmlYZImzXIAK0tBgef
X-Google-Smtp-Source: AGHT+IEosB7rYwzlkeNb+bF12wvf0uGngY4g2qCycBs80a3PXBL2wooof6takw0ftw/HNx8XBqwKOw==
X-Received: by 2002:a05:6808:318a:b0:3c1:7eac:a8a8 with SMTP id cd10-20020a056808318a00b003c17eaca8a8mr13498649oib.26.1712032501450;
        Mon, 01 Apr 2024 21:35:01 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id n16-20020aa79850000000b006e64ddfa71asm8985720pfq.170.2024.04.01.21.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 21:35:01 -0700 (PDT)
Date: Mon, 01 Apr 2024 21:35:00 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <660b8af433ed8_1a1402086c@john.notmuch>
In-Reply-To: <20240402021307.1012571-2-andrii@kernel.org>
References: <20240402021307.1012571-1-andrii@kernel.org>
 <20240402021307.1012571-2-andrii@kernel.org>
Subject: RE: [PATCH v2 bpf-next 1/4] bpf: add special internal-only MOV
 instruction to resolve per-CPU addrs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> Add a new BPF instruction for resolving absolute addresses of per-CPU
> data from their per-CPU offsets. This instruction is internal-only and
> users are not allowed to use them directly. They will only be used for
> internal inlining optimizations for now between BPF verifier and BPF JITs.
> 
> We use a special BPF_MOV | BPF_ALU64 | BPF_X form with insn->off field
> set to BPF_ADDR_PERCPU = -1. I used negative offset value to distinguish
> them from positive ones used by user-exposed instructions.
> 
> Such instruction performs a resolution of a per-CPU offset stored in
> a register to a valid kernel address which can be dereferenced. It is
> useful in any use case where absolute address of a per-CPU data has to
> be resolved (e.g., in inlining bpf_map_lookup_elem()).
> 
> BPF disassembler is also taught to recognize them to support dumping
> final BPF assembly code (non-JIT'ed version).
> 
> Add arch-specific way for BPF JITs to mark support for this instructions.
> 
> This patch also adds support for these instructions in x86-64 BPF JIT.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c | 16 ++++++++++++++++
>  include/linux/filter.h      | 20 ++++++++++++++++++++
>  kernel/bpf/core.c           |  5 +++++
>  kernel/bpf/disasm.c         | 14 ++++++++++++++
>  4 files changed, 55 insertions(+)

LGTM

Acked-by: John Fastabend <john.fastabend@gmail.com>
