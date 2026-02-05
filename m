Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC9222575
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316872; cv=pass; b=S7Y90exOYO4hMz5rhSWbuVZnV8tbAhoMj5q6a9fug3Smmaxq2jGuI54mLGFSYkeP+AenBU7q6roG79vjVZbbjrY4OfLBLXsYxulXOc1SsivxveD/u6/gUUW57tmI/tU0vt5OaU9LPntYYwBX9uQd/HEBmsVw6ZAtBy5uNpFlOi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316872; c=relaxed/simple;
	bh=TcRSbvXNJgdwK0D+zr1lv7A69Xhax3SXB/KZlxGu3Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVXIjo6ILP1XR0iN4PQUz5lS2MnKfKtU4vZrN6LKuRwm8K67oJro1GbC1c4Cz7CBDIrYDSQGbNpIBSA+WCfmWk2oMZ0boDbVCEmeprGqScfW1/z++AxMA6jdVurde3Fbgp0/6/usOwK7WHhtgdaNuKfKygmalGrD+4Ybtmmv+bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+PkkvQx; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+PkkvQx"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43629377370so67148f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 10:41:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770316870; cv=none;
        d=google.com; s=arc-20240605;
        b=Dqb0GMhig9/Gm2ct9Iq2Jwf7rVISQrsOz0Zk0k/wKF+EMyVUHMa8iPSpnzmZcVTc3T
         PzVRf88s1Y+ntqDcBTgXz1WelenrM/I29SXOLOAng/xYhvwlfOCGNV0CKI5SpUPXaHx7
         Q56SwosO+bvtWm6ZhmkSRHE6O0HRdLlk3YiIMuUOqwEg6F0noUvGG9SJyI8063VVuVEP
         529S/s0XynZxOAr1xV32dpvyLOc5vOlqAIZwitLLiJqeb0w37fuyHxB7D/zAwXrY7Apt
         40jUxw/z5OeJ+bIFnUMX9CniZiJvMY1cn9FDkIqUedtvqbDnpUMCzCmoZ4m9Cc49dS5I
         g56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TcRSbvXNJgdwK0D+zr1lv7A69Xhax3SXB/KZlxGu3Z0=;
        fh=YwvFB+7MW92qFeDWuJHtK6kxWR5Ma4hmbXV7sMeuLro=;
        b=AHgjRDx4qqUrtzQ3lTg47oz+gfDSuAbBM3gjLJOU5PjKUkGy8SPZMALlPJnp/ZW1/N
         96SgzORtn4nZW6GRTTxYVsLYVAkug/NFuiuqPbiRwWjYQ+AnpgamsHHjl6+QCDS74m/p
         v+7vaBnE6R32c/pUcqCDE7DW6FD5Ttlq9PTg1oEWi5huXa5YkRC17JyG9CAMrT6TJMdY
         V5cwohV8ROu1vGfq1a+wSbtmPLvofbCydcJiM5xwlyXxH4NI7fmLcqEAfR44nxydB6p7
         SlAGrnhDn4jYtUGEOPii/r8z8bjafpITRRSXuI28gVZnYzJv2+yD1k+niFhryokI1ejG
         Nwiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770316870; x=1770921670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcRSbvXNJgdwK0D+zr1lv7A69Xhax3SXB/KZlxGu3Z0=;
        b=G+PkkvQxh1YzxqvRjYGUXHgtLGLCtz2HCHkR4wEiUzdWaSzwITBkfbh3MYrMWkFjZL
         GZ2z0s4ercWpUr0h0HL2/gqQROxmG4XkGsF/YVGAvgT2wUn4FRfDw02kduMl58Mli7wk
         fI161Pyb55IoN9fG6PV2RjIH0nDmlbNsIFyZURMyNEymaB+XnZDoyXil5H5qbC4IsQHw
         JCEQI7/rFyXGvaZcwrgrfcD3ZkFGaaDs9sWJ5l8bjXC341ZSJVNEXFPkLQF4KWrI5xSr
         G81E82kMX6lJedKWgTlPoQbQHr+GciVczN++pkPjK0RJJrcfDmgnlT2ouWH4SziG8GCg
         I0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770316870; x=1770921670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TcRSbvXNJgdwK0D+zr1lv7A69Xhax3SXB/KZlxGu3Z0=;
        b=sFUCZDObQv8bCN1gMn29xOdjxy6pPAH1HI+H6M+KG5ESCHxa9bEng6/BbfjCY8ITH4
         ZxVDG3EDz+3AYixpOj/kWDeyoxhVTosGbCIC5cdizpObdA2EV1Due17C0sMj/RF54ztC
         KXwfOths63KAmlXzw/pdlnbLbPADP3FFEHVKWrMM60iczlYOsPuID+mnQ1JAE+AOIzEX
         nj/oN+XCHOVZIdKLeGb3NaFY3a1Nod0OFp985rqoohHHClQnldB0gVgFXfoAINQHgIIX
         pSZwemmlIR13fjGlLzDhoW70W7cJ93AJkVxgUfT9PVvz7hJGgLMJ4hqSXzWuLDsarwQD
         DZfg==
X-Forwarded-Encrypted: i=1; AJvYcCVvjpyYsIZ8XNlSQ4k7EZgN8wYGuHzO1OEQ8opIUd48XP+cech3wuE6eefG67ifbr0ab78=@vger.kernel.org
X-Gm-Message-State: AOJu0YypOrez3KsVYEjuX/IjFgBcLgkbFzdzl/gDys9DZrGC3psDUAu5
	3nIN7xZ6Z1kh3v5i9+5hkzwycRudQjJjXynpu1taAnKcTP3e9F64OI8aEArZBENK2u2SxltWjQX
	yeoVxoj2w5XOLiJtOEooKq2dhfM0ExaM=
X-Gm-Gg: AZuq6aJ1btW9DuSObJKvIC+PHxs8qHdBMDaYpH5C7wvOA6aLLMcqgl+JmnKSsJVRUjC
	Vr666LBIDIqXdtCqr6mBeLpaR6Z/y/RG027Qs/Pbv34Utsg//j1T3qTlw1pxAHYoLmCOLCpn/jz
	pY5IdiAny1MDkDlnt7n1zAxONZrK883MZfya1va0wb9t6Lo8jAMXyzA9BpSXqzEJJ5Rsj1hsqJF
	x2ZOIr9EA/8HrK/Qmr0lGdO/xq0SM4emS4m1iOKqCCwMbY6pzPOd9CM9lVKytB+U0qOgGxuFPtU
	4FzkDvpjNZXskop4Bk9NbjgYB4tgGo688f5Sc9FBaHCLWUIHXhfitTPlWVS/XFJuBX1U3lvf
X-Received: by 2002:a05:6000:4212:b0:435:bd00:3978 with SMTP id
 ffacd0b85a97d-436293b6e91mr312523f8f.60.1770316869849; Thu, 05 Feb 2026
 10:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205070755.695776-1-kpsingh@kernel.org> <4eaf4476-f8dd-4c75-a6bf-50dbee8fb807@iogearbox.net>
In-Reply-To: <4eaf4476-f8dd-4c75-a6bf-50dbee8fb807@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 10:40:58 -0800
X-Gm-Features: AZwV_QgS8if9r2iLLf6OupCtlsqadQmmVImKaHfGMnYVmhq4RYukqRgAkfz9_dw
Message-ID: <CAADnVQLePYSw7Ke5LmcNB3B6mnxrKVjSa-uv8JfgoRjT9=BBWw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Require frozen map for calculating map hash
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Toshi Piazza <toshi.piazza@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 2:19=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 2/5/26 8:07 AM, KP Singh wrote:
> > Currently, bpf_map_get_info_by_fd calculates and caches the hash of the
> > map regardless of the map's frozen state.
> >
> > This leads to a TOCTOU bug where userspace can call
> > BPF_OBJ_GET_INFO_BY_FD to cache the hash and then modify the map
> > contents before freezing.
> >
> > Therefore, a trusted loader can be tricked into verifying the stale has=
h
> > while loading the modified contents.
> >
> > Fix this by returning -EPERM if the map is not frozen when the hash is
> > requested. This ensures the hash is only generated for the final,
> > immutable state of the map.
> >
> > Fixes: ea2e6467ac36 ("bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY=
_FD")
> > Reported-by: Toshi Piazza <toshi.piazza@microsoft.com>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> [ tree would be bpf-next ]
>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Applied. pw-bot is down.
