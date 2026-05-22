Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810782BF3F4
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475868; cv=pass; b=jzht9SQbFb0Zvip2CSxl7BuEM4/VOKLoZORx0Z5wgxm8/6g99f0VIGWVtyk0RY+/QYkmIT/vDQUr0uISxgoOZy5Mjp9we0uu6lCWOe5a0Klswfd3yKkhoJaB5h6PWBkpnfvIdkIBiaQbs3nMOlx/3a5n8aHuHZCn76GfY3PompQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475868; c=relaxed/simple;
	bh=NZShw1MASHtchmMpXFIJ7C+AmrOVAclE9Fcdii5TRXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NirL3X24ofdiw4cZCgoezSVLkGtFHHnAY5iEU/CCT2EiNSD4SDfRdj42yRyPt+VPcPWj3BY07yzf4SFQrcx2QNKuETcIr10I2hMorWaNJjLjhQrvvnJ4fjmPpYfVUuWiIWqBZhWNA/EXEnS7RcYC7uhcATNqVMgDf2wPpEnfYuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT17stIB; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT17stIB"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8027e876fcso3379074a12.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 11:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779475867; cv=none;
        d=google.com; s=arc-20240605;
        b=NrYVcj5piisFeMzPw6hS2M7qtz9UZ5On8PWhcvOkA4IPm12HhBVCgiLLoDqJDPdqqL
         2WidRK3Igs9gdIWSPEjxBbhkf7ZUDLk6xGuY+aD3x/xxZE0bgqjqyTpGpIW+btHx35eY
         rLldUh976IZ9wHDYEa9pg5A3DEIsd8QXb3HvHqrzAgS7C/w+K0o0p3G9LA1XQeb9roB4
         c0oLhETjJmFCKqz+WbsOOT6bsdVyL5bT1miqHYca3TqeW9BJQlwsF62iBrNSr/tRGvST
         eWfvqFpwwqix/Li/B+UA43iD7xhKEdau++CYRt8jnf7S8Iln7c6/wVogD0DeHV7GZSn9
         exYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SicWR6oDoXTpOwEFSC6EX0IEQzBj/yfrSemAWLQ78jo=;
        fh=eocfCJVYfJmGSQt0PILJd5H+7aD/h34qDoCNFquFj+4=;
        b=K+1Aokur5TrSyBr9ysLEzP7sh+WpRkA/FnM8NcCg294V9V33XrY01lzxkmfVsOXJ3t
         8E3fIZ9xN7Eo4uiUNN2Ij64mwxWdLpSznIAEwAP9MwiLNmSGNdaTa7+DneYqo4cCbTt5
         5tRchJ7+bFP7LRZVP8BKLUIVbC36hGTLRKS2Zv9pJsIhdWTZ6PSWNBo4k//bNTTuTgqx
         UD6jyXnNevmBrT29W5OaXHMp94ttiGBK1gjF8RP0D5bjUvkLOWit6R8ekah6OGlAsWjv
         qTBXPEzgZAGwEYh/EBw64kRvr6TFd/1/ZXrJ+fud9HIi5M1FE1Bo4S0V+8eVypfhFVdx
         ukrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779475867; x=1780080667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SicWR6oDoXTpOwEFSC6EX0IEQzBj/yfrSemAWLQ78jo=;
        b=MT17stIBW/M+NGBUakDOQBy5BaD/WPnCvKJh7mWEEeGEm8NdKRxUG0BScrX0m34/aG
         KTyepsxg3iYwvw3SdzxWDUpFQ7a+VtKemRm6Yb+2BFIAwrOd95YIkL7lem6u+ocyZ7oM
         EnRBtxIpVCxdIIzpfHD2IonWvl6sr5BKcpkO527RvmovZDDkVthv0CPRR/ZGQAu8QS2m
         PkaZ2M5OuXq2ckZHACVAPB7eVgpwUHN+lmSDhsAn5eQONgKaEyen8SwU0bx8xOnKtliY
         WwKQpzrZhWl4NPkNuETRar72NSk95pTJoqhvk9KORKZ8mOJs4pZdxuleq9cZtLFHLD1F
         ZKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475867; x=1780080667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SicWR6oDoXTpOwEFSC6EX0IEQzBj/yfrSemAWLQ78jo=;
        b=TGdi9ncr8752viN3qNZ7Dg0akp4HU+aJGyNdHQkUyQcqbp1NurrAHQk7LcmNWvT1+Z
         s9L+9WqMUmWucK0nOpSGPO7o3n/9l5l9NKM4P5082IzejOHyUtpZJSkpPElftiNDe0pD
         DythFcL4QszBpsuKzWJnZYCXZ9qHLjrzJPZrlQJtrgAatQlxAyX+ZeevbDzBHlNX7ost
         BDLt6+uWVr9cVMKsGqOYhKnLDKNu7d+sK4VKn2NZ4LpIX+8yAzvnCGDOoM7eu21+69Cn
         Db/3a24Ji0y91LnD6Uwaw6AlkZBf6aff+X0MNnV0Ch0Uic1stXyYtowbJ52s5ucJ8Bis
         aIJw==
X-Forwarded-Encrypted: i=1; AFNElJ9PP5ExxaLutjvXbxohqee2D13PuK+UiohgxrJhamtT11NUhILkqvL7heaLMbhaeNBOURk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMA0KcuZUJLKHovC5UBJDMcF0135IqlgRbJ9eakmUkYDhaf+aw
	7wQWaJPKElyAGlYm/6n+dG4gXVIrSYhXmT4b/ztQ1Rr3nRF9ypdZ+mfBgM8nvOudPYquV98/Onw
	5Sdh7INzyJSekc5NbqlGb5qaltaAoPAk=
X-Gm-Gg: Acq92OHzdLFC2J5uzuEjdgLWatthMDW1fmIdV0drEREpdaRyH5MSOr0XLj5j0975XPK
	crDDYPFZG8Qr0FlWUgFV/gBgRa6Wb2Sfsm1V8xSlU2A6UH2BjqE6LyVj4AtYfmmGpndx/8fGnxB
	JacX6HMwlZQ0236/QsP3EEtdvuqgud7cTf6C9E20xANepBXD9J4pKRHzoUTu/zLy8MAPKNIvT5L
	aHSv0u6cfPZiwyA0/IxaH6bymgFDco3ab3DXantR5J0ByNcyhTBuQnYxcHlX6X7288eYgoaAOn9
	GrVdmWpDRCT+0e0Yem1oSxA=
X-Received: by 2002:a05:6a20:244c:b0:3a2:fbf9:d819 with SMTP id
 adf61e73a8af0-3b328f3be03mr4974574637.52.1779475866609; Fri, 22 May 2026
 11:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521124411.31133-1-jolsa@kernel.org> <20260521124411.31133-2-jolsa@kernel.org>
In-Reply-To: <20260521124411.31133-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:50:49 -0700
X-Gm-Features: AVHnY4LByqrb2bL0kfR9YGd7hy4rE6eOc5M0VcEvHUbYT6t1lwB0v5isODPzxgg
Message-ID: <CAEf4Bzb9YmTh4_r+GxHtWNw_brr-sV2=KCKp+4yP+o7ihrjaxw@mail.gmail.com>
Subject: Re: [PATCHv3 01/12] uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:44=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> In the unregister path we use __in_uprobe_trampoline check with
> current->mm for the VMA lookup, which is wrong, because we are
> in the tracer context, not the traced process.
>
> Add mm_struct pointer argument to __in_uprobe_trampoline and
> changing related callers to pass proper mm_struct pointer.
>
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>

lgtm, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
