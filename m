Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36FD15E8B
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787706600; cv=none; b=TsZi3A4kWnG5UjmB/tM2Q0w2aKCy9SuHUC6MMG9OrLXbZX5pSu3YGBTtpjJSa9EZecv4HasSFuymgDH5rwNBwnoZUMRvtl+s/SNL0usccRxEXrYyjWHv5BsyAsetkCX4QNwqY/ZYzct4KvfomUEkwPYwTaNXmwvc41tjIUMeNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787706600; c=relaxed/simple;
	bh=N0TbZOwb9fM2Lbpw8Sv0+KdfymJihar5UhaRJJ2fwoM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=kAj2r2ssxxqDk8fK0n7vNIRfSzxoX7dz8N/f5absFttMZSmlcFnaYeKSfIk85SKvFYvBUXhNWTRU/qLpUl5eNtvlVCKndCgQUaqS5ldNV3+07Jq8Mv5C6cqkN02wH27LhjIzmQ5otsvHyyy13rbcSD3IIOBvhnIS2L8n/sx6ZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHuEkJ2l; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHuEkJ2l"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f48c750afcso436674a34.0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 18:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787706598; x=1788311398; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N0TbZOwb9fM2Lbpw8Sv0+KdfymJihar5UhaRJJ2fwoM=;
        b=EHuEkJ2ld12UMqWLMnDZJ98cy3umRQlNK9Udd4UUDGmgf7Xc40gHrb9DGZbJo82qrv
         6e7WiQjASSCuvuE9KR8ODcgPajvGzvrM7oY4rjP8/sNud4ZoSK+Bt2xG3fS9sfyRU/Fw
         LRMQfmvn5uW75mIG2Z3hJ1uz0Q836WPUvKWeCR2sEDe/SxUtRcgimCtBi4U4Qguoc+bL
         twhq6kCVcbB3kKnUaehYwuTr0BRxo6UffqATPmZO+xfeHTOyFRm6P2pG13gkX2xBJPBg
         hrAQCRs8G9YAw4zMJ9IpUlhhcJgdcWJ/5KbrfJpabbWm8pb+aqWgKXMB7Y6qMXLUwz6a
         GeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787706598; x=1788311398;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0TbZOwb9fM2Lbpw8Sv0+KdfymJihar5UhaRJJ2fwoM=;
        b=PYaPD8iinz45WUxBi4naFbuVhbMF2fx/8Ir3PwYk++wi2bvTqvPoVlbDqN5fiK9PtK
         aNbr9GwzA7hVjdS0jIi5FTa5gEpeYLecmh1C3tn7f43KFsVqT/v0M3202YnRyDvwi5Pn
         biqHBL25l/Cmh1CW5FoBgy/6vJRRwonfIDR6ba++AHhRkw6+DU/ejcK/0OBJ1vtjDvdj
         4HkVZj1vokhwNjmOyP1wwFjsXIiYVSugsNwSfa/UuPghUm/SgMtc+PjkM8rQdI0hxu9F
         0T7/T893fFh/aLJKCAP9OSj2LVvOmJM1EoxG+DkB3xmQvYeB489kUQOXQODVMmUzeRxo
         3LOw==
X-Forwarded-Encrypted: i=1; AHgh+RrfI5fKty+O4Af13DnjJ9ICrQtI3mV/WkS52N5IKVi8PiZswOwxJkYllzPaQgfRSTHRhqk=@vger.kernel.org
X-Gm-Message-State: AFuF++kwxenY4kqUfySsbIuajGDEBSDFs6SF31AQ02dYoGMASJBUO6zF
	QO3tbwEY/g0LuqgvKqeayfoc9qvD33AeBuWtf4VxuVOjW+ab0UL5cIEZ5UPvYQ==
X-Gm-Gg: AR+sD13/T30pRsR0sWy9sdPi7nCVKUqTvJWDFpFDzQMASsb7RI2+Xlytjcxrmy5Jady
	dXg6rZ2gFAuYsx+0JPwhBOZi6RkUtPTic7tizQpNmPO9ULLPqliS7EFwHUVOETXUi2rt0u/ipw6
	l+R8PToBOCi2gyhn1ZLcQz7JX8/Q34AtlGSt2LX4Dj3j2+jHDrwAOVWEEUaoFu4/tZd4tO75qAt
	eY5MOTT+H8US0hdmj2T99Hp1bGfxkGORzMs8Yubd5oDj4OJAYzxWv6RCPqYSrXLldzisGVSBG8g
	ltIOWyKUx7ZPj5bEpX8PamtkAawXuvyJw3/iPS4yiO3x1YMxyDPCR2brdMYhD+Nl5B4A2MSqnVJ
	Sqjwf4PhBoorRJKagdUuHkCrI9MCzd18T7lYD2Um7EWIcOSXu0M91sz6p7emWuGnFpbm7wdUaSj
	CijEsuNjH8LjYkvnQPRipndnDVSpg0zSydUPXY7L9tP3VsXxC72XVlmZOFDBItj+MU2/mOIBL/1
	pg7JpmvBJz2+aXXghdWQFs21dur61pO3STS+/27LY6B0VJmpjEKM1s=
X-Received: by 2002:a05:6820:628:b0:6ae:8fc0:dbaf with SMTP id 006d021491bc7-6b1a03ae5abmr2976110eaf.1.1787706597499;
        Tue, 25 Aug 2026 18:09:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-465ade707ecsm899942fac.5.2026.08.25.18.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 18:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 18:09:56 -0700
Message-Id: <DKYH3KM93BDY.1MR4WLZSWGEU8@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?q?J=C3=A9r=C3=A9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] bpf: x86 timed may_goto corrupts private-stack JIT state
X-Mailer: aerc
References: <20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr>

On Mon Aug 24, 2026 at 2:31 PM PDT, J=C3=A9r=C3=A9my Jean wrote:
> Hello,
>
> With the help of AI models, I found a bug in the x86 timed may_goto path =
that
> leads to a verifier/JIT state mismatch on private-stack programs.
>
> The root cause is that timed may_goto fixups pass a stack offset in BPF_R=
EG_AX
> and the x86 trampoline reconstructs the counter pointer from native %rbp.=
 That
> is incorrect once private-stack JIT mode is enabled: ordinary BPF frame p=
ointer
> accesses are remapped from %rbp to %r9, but arch_bpf_timed_may_goto() sti=
ll
> uses %rbp and ends up reading and writing the native JIT frame instead of=
 the
> private BPF stack.
>
> The bug was introduced by 2fb761823ead ("bpf, x86: Add x86 JIT support fo=
r timed
> may_goto"). I reproduced it on a KASAN-enabled x86_64 kernel based on v7.=
2,
> however KASAN does not trigger because the bad write stays inside the nat=
ive
> JIT frame. Yet, the saved-register corruption is observable.
>
> I have not included a patch here because the fix seems subtle to me and w=
ould
> likely touch many files for different arch.
>
> I can share the minimal reproducer and other details privately with maint=
ainers
> if useful.

Just send a fix and a selftest to the list.
