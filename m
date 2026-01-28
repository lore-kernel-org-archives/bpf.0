Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA22AF1B
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769559588; cv=pass; b=AA7fDwvYNoUae6ukxsW47lwwwhK0/Q8Rz/xmJO0W9hBnq/7e3cb5wdlfyu/p+k7L/ozBEedG33awKBDA6yu5ibTFw0ioqiN8lhtfKKx3/YdBMvdThMKelpeGkj/5gDfmizjA2WTP7FaVkIb8ACW+qFTJ/7q6G1fwuNSJWZhyjPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769559588; c=relaxed/simple;
	bh=XTZyxyLFwUZN0269MByrb7ZoQKTAv7A4qXgogRPRzDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rmhzay2h3H70GMTNvSBB8KASk5xwM3iRQows6aR3jdUsZfEAderBNujg9MfsLkbglf79S+hpB+Rq5fLI0ugVOMP/DbOKgI8yPCAqDo0Wn1B8xGQ1TYJsWED7Us+omBgxnf7oGIdrKJnlqJ9uKn40tMBCgd/jfK0ME9eGFZtw+0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXPDw+1f; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXPDw+1f"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432da746749so3454036f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:19:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769559586; cv=none;
        d=google.com; s=arc-20240605;
        b=Zbz89ch/fvDA7ldqslga7PxylJ4hXaiwhtqwuBAHCo/cjDlYyOSf8OdBeSArjiV7y8
         7Y1bWQHXGWKauBPMNUhJdGsPKIak43wH+UZD9KQ0sNbhlF6jzK9Z7cFhG66QNYrmUnl4
         8cokiebuzIOpa3tAlbkMRK1pcwZ3R+8SnmFLnJBum9/2OxGdo5owamj1WpzZeKGxtQmK
         cUuVozSyTZFdvmpwRAXb/EXjqQh12rBuRSz3j+4pkf7Ak50cx2SMAPoBIMh396oOTL4w
         ELNoftvwQQUN8F39+CYCYe2PFi9BZsVor36oznmTS4SRapofPgiJQ85b/1Td8BWljruA
         Z7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XTZyxyLFwUZN0269MByrb7ZoQKTAv7A4qXgogRPRzDA=;
        fh=a+EYa79QYI41GMec4/rMNWmyhFxBSHuJALU/uYwsT9o=;
        b=LtEtIUsW/gE5wY4jGxF0/bqlND8vh4kYmA/W+ZDNlBhyzxRbwDNAvHS0PFJ8Gtm6IY
         qCgix4Gk7wVYGnYXNISi7P7VtUaFLoHlc4Vxpj6C7JJyegN7P8QxI+bL6BmIDTyF0fKw
         I5WW6zd9Giuh9KPXx0E3x1kF0XeneHNKwkEKNRmVywN5PRtB3bskODc3JbM3L5oVVe0R
         ekDPVSBRAZPPk8aM4Nq5aD965E2OXYoOSYR+dms7vrmHd4xPOb4Kdd0tkKiAs6vO/BEu
         XrfyA7sdVKtWGR3Yc43BTeKqwD170g2LEYqrPRmM8u/0+P/tvX+NqGw4zuRmU4m2utcH
         AeMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769559586; x=1770164386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTZyxyLFwUZN0269MByrb7ZoQKTAv7A4qXgogRPRzDA=;
        b=mXPDw+1fuZz1febu0O1kOpQEZBf7u0079SCqQ/QA3H4y+M2ASBUMLrWy2Q0xH49fIa
         WGP2zfqzzsUsjcKMxZ+bKn0dG9icXT4xYTU387t9uvM0LCdksjKLhnhYxQ5KWyLCEzIz
         YuDZsr9o9qijG5qKTQt/RIWVf6TVCcBwyXaIpi69/Q/Athzy+Owv8YeP+fFwa5mWPJMk
         Xjm4OCj3ISwsr87Arfk0IKCdcsyHhGu4IL8ToBuY3R43aySPidJgoC/LDlQauFbpi1Xs
         BSFOXygfy8wAy0MFTkbVz5Xkb01W1XmP4wcvQngEMGu5hbLAnC0nfzMyT2zRK8pOYDqX
         VIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769559586; x=1770164386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XTZyxyLFwUZN0269MByrb7ZoQKTAv7A4qXgogRPRzDA=;
        b=BSF4A3Miaf/GFoDCKhRsnjjrQjkXrLkRKGqh5/DPECfr1vgCjokcn7/bg8ZD1LGrfH
         2XnhgYdbdcGBzvB1W1pk9NM/oLjnfWKZtWPClkD90BiVRfO9RMyCQk6cTnLxkdu2XLJc
         fbcTgFcKvJz7IflHVLefLl3kl+yb0gi3iBH4rB8XbG1b7F8S8JdMEPnLN+Bel+2/WaPS
         fp0eqicuJ0jP2hbwe94jZJxZ6rMVG167men6whLOXzk/Hnb5LWi/siKq2+BzKps0JMLo
         pXa1ZhC9YlQEAwlNujcsJ+y0i68M5Wz9auLuTLMj90+zERUJE1i97h8G00idE0n2PPQY
         7o4A==
X-Forwarded-Encrypted: i=1; AJvYcCXwYUnR+uV1a8cX6BTT1okAujCl08vtxCZdNueIsJRqdFlTCvw+f5vUlhzOjXLq8NzEZqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWOO0WjJwBrbVmY0HSI5+wTXVgkNZ4AGf4Df9A5YB1qPV/+lB+
	BTF1gAc1dNnLXhsRFLnD89WE5QL+F8vQFYHds8740iOL6B8pYtFerI1niriv8bh/gKINs+OdgnJ
	REjjXYGTA/FkCO3oRblxgULsnbufXTdk=
X-Gm-Gg: AZuq6aJWch6Rq3lu6miqTh4Sfced0Wlygm+5DORZCgfaxhHdvr8iuPTPjezh26pkWU8
	TXHDYMNChDu7MuE4ymxkhA62fzOw+XaaKTrhOcOZtJdyox+cAu+i7RWuOmpvyuSJV1iuEsbD560
	fn3VG82E5aY57GDc2YpMLDi0bwOAjxuABz0eVxYBbxNoxkSRTiPR/sHW2KdCJ9C79FlkTjj7+0f
	ii+Vj+iATjxJ6mjg90APLej1TFqYfOwfxxiNDFn7aT3/GTGW2LvzNEpUydqXxUqzmOq3rQeIpmW
	fwnLboVaMHz4OZVwdaEnLctjoxB3CHSh9mS9sPvP70Y8BGPvPa5M4Fs4IWcRDxVEQWmRL9KnaXL
	R7BDH2XYBu31BOA==
X-Received: by 2002:a05:6000:258a:b0:435:a370:2d7a with SMTP id
 ffacd0b85a97d-435dd0a3e6bmr4552214f8f.36.1769559585702; Tue, 27 Jan 2026
 16:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127231414.359283-1-emil@etsalapatis.com> <CAP01T77Bp7T7fq_zyhqFLsnY=791VF2JLyU+zxZchEO5Yq=5cg@mail.gmail.com>
In-Reply-To: <CAP01T77Bp7T7fq_zyhqFLsnY=791VF2JLyU+zxZchEO5Yq=5cg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Jan 2026 16:19:34 -0800
X-Gm-Features: AZwV_Qhoui8x0ZA_YyBzwS2DVMQgs8sgK3BfLiPQHFiE2AOGK4ZJJQ13cn_Ipug
Message-ID: <CAADnVQLz33Xs7Ja3QHwWZzpWc-NqGD6+DQrH02MeQUL4WUZ_TQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow void return type for global subprogs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 3:53=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 28 Jan 2026 at 00:14, Emil Tsalapatis <emil@etsalapatis.com> wrot=
e:
> >
> > Global subprogs are currently not allowed to return void. Adjust
> > verifier logic to allow global functions with a void return type.
> >
> > Also adjust existing selftests that were ensuring that global subprogs
> > with void return types fail to verify. These tests should now load
> > successfully.
> >
> > Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
>
> Looks sane, apart from the renaming nit, could you also incorporate a
> test to ensure freplace logic fails when return types for global
> functions don't match?
> We didn't have global functions with void returns before.

and also a test that R0 is not accessible after returning from void global.

clear_caller_saved_regs() plus what AI suggested should do it,
but a test is still needed.

pw-bot: cr
