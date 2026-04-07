Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673333A9DE
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590467; cv=pass; b=eODrjgfvyKDkXw1Pb/QoUIhM1lAUjFlpGTbz2Gl2owKdH4LpOWpf2j5z3EBkkNV9qj2SDk7BTZMnP44bu6OQi8osHJ9oXN0iLGfhI9Ny98eUhQj+ie1Y0g7y4EbEhl0atSLBKLtajOj8mNu7bGrQTCy+DGxRYFnonFyt+7DBnNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590467; c=relaxed/simple;
	bh=Dduh/r7rL0wwQLDHT7Dq47LMSVf+sUsG6SXK+otwyz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnHwTIf25HiHiGqkez5f0ZFBFjS8qNPQPzU0qdChP/rcvVqdOEJ3Mo9hyGWvcrC/2hG29Figg8ItsgGghHlC/g2E7HuQ/a+/nsF91xQ0j4A1pet7Hby0MGbQ6ZdfeOq3VNY83SEMMdW46QawjTzB184YR2UbQxxB6FapGmSVz9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juHXYhu5; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juHXYhu5"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so133437f8f.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 12:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775590464; cv=none;
        d=google.com; s=arc-20240605;
        b=jaoaHxsaTV6vn+mHtkmprJOphGHtovkIULUGRFiFZR+Ep8wHvUA8rzwMfbpGe+z4fp
         ImSdL4rMLpYXEZ/CQ2papCC2p47alYvfZBajKh/95wNWI9CVgW5U7pUbdH/m7TayM7No
         kku8muW0Uazpnw2m4Zx4kUfKz5/ANozT2HCCeuISq9Jl9hNrF/u61WLBxAym+1PJbBa6
         edBBwXMLCvH+tZHvHZoyp1UPrNJkD8eiL7Ge8xNtra3K1JUk7vtCk0xqs4dapRoW/HXh
         +Ja+/t+zRk2pObV4LaDOoq65AQNNJ9rQhYBeXDagAQw+dPu+u5cDSiXS2D1Q2NpwJtvm
         T9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Pzp5p0ah2XzFVNCxifp5xJHsqGQxMq74whZrMr4olQ=;
        fh=u+gLe3kWGNGIx6ny6A8xUE2ZuEfgvLWQHfVD1iSn5eE=;
        b=T9tEFoCkeC0eQJCJMhNPYRXLJ+3fj4/uVNJ7oDVO9cdpthuZHCxc6f8S1Uw9K+1urT
         I9cMyiYT+l3lJkMlM7Iu+J5NiDOQJNpfwYdLxej4hkHbD93Yny1XP5VUP3sTBdMFrsoT
         W5ZouldS75wtvgXujY3+5Lag2xfmiQlGw7v20XFC/DMuc3g42JelLS7AwNz8TElzM38P
         Tqv+HG6j1XlfG3UsSYWROdn9I0JKqYWDEWUPbOi7AdbuhC2UN8luHzUUJ1rVU9vxwlbv
         5IbHnX8HPvy7MnBHkufLRZ9YMUE8XHlSyIvP4iDfWgEaibStqpeMmLddQpZ1gXlv7UoV
         R3uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775590464; x=1776195264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Pzp5p0ah2XzFVNCxifp5xJHsqGQxMq74whZrMr4olQ=;
        b=juHXYhu5F2REPTR4Eq2IZaY93he1HAE7/KsIhF2svyb4DkLKIHL/w5q8pd7KWGX7SF
         T9ruP7JGLR66/QnQWw4cLgmZsI7QCiosNRhJrvqgtNa7hWVexgzO7bTyvinzyQ0fjafo
         pbb6NIJy9xeMkw1Tc6E/hfa9fj3IWdEgH+rS4Q6m3wT2vIAx/ruHkwfC4Ogs5TMJgWR4
         TKZhAcgH/Z7cCQdHgn5S57zMIx1BZ/nEf/CEZ4YmMq6ChIrxfsfWKI747nkPiA+pzwYt
         eiXpkwf7PaMuF7wWlcCvfgxNDL+9A4FZreFxfKd3D+X1a7Tb9Lg8pjdX4dwjlmSCg9no
         Z3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775590464; x=1776195264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Pzp5p0ah2XzFVNCxifp5xJHsqGQxMq74whZrMr4olQ=;
        b=A1rdRO8owIrWi60wzq6UUdjR6rxdkIiRGOwSi41OBXPsMt5CeNvh5XvkUQimSFjbNc
         09DUtoVanXnMnl9BwpuYmqMzBHBpYX6xjfXyhmV218QR7Hvgs7YGoaBAt38esAdVNwxe
         5cnfhddj6qbLZNvJgel3bZ3wwq4Wrfv9q0XMG++e9fQQGkALMfy8jujJRBxIWWmXdtbr
         x6kdTvoPja9G9YpmRvA6CgvlkVmkgbqPQtZz1wpYJz8SJ8gn9NLrlYck8sqJrp7yGQPH
         sDzTCZeRi/Cnrcr6IE4o8Qu7ngkV5Lkum1rTj5tUQMGCCZShdc+mYwwF5kRPyClu0+l6
         u14Q==
X-Gm-Message-State: AOJu0YxJf+SoEi6aTzjmnmQXA7DpBg2zMTXpUi481VU8OyOBwDwc0Oob
	aUBtehZIomQYgCW6AF64Rg75LQxbsgtPYztuLsqo6cHpnpZmCZP9qoxXswGZqixgv3A2rePAPux
	yeN839w75sYm+7e/RdUH8tlNr0yl+qjs=
X-Gm-Gg: AeBDietz/8ArijGRdVSoQx75NTIqY80O5ZxCsEXxso7tl/oFdi3CDO8HAGlJEaP+hid
	umhdRiReObVEvJc+Rg9i4mk+bzkS9gOGsWDqtsN8qr4sxVSC9JoJYXfnDvBx7PmikiKS3coTNLe
	hxicabb1cSeQSb2VrDWyo+9LCQhpvlD7jk+MtbzIRhxAC2AZQzETay2QH7iT4/Wfv5y2KdIXj/i
	0XLBZpNpk42N8MebXKonKWIES2ajoTP4s0xttOrPUq2vJzEP6WEpzXqjhn0fxsgHAxT6FVS/PRg
	ABO+KH16KNtZPUtvcIHZ7tPSdiP8fI96B83C8tstO7RnqVLzAV2xKkFo4DiZkRMghmh6ZUBAanR
	X7toar7gexSayHWsraZ+m7qWl6g==
X-Received: by 2002:a05:6000:430e:b0:43c:f650:cc97 with SMTP id
 ffacd0b85a97d-43d28fa819emr26513417f8f.9.1775590463872; Tue, 07 Apr 2026
 12:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407165145.1651061-1-andrey.grodzovsky@crowdstrike.com> <20260407165145.1651061-2-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260407165145.1651061-2-andrey.grodzovsky@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 12:34:12 -0700
X-Gm-Features: AQROBzB8jC7AXTIBKmRgp7Dw-NfnpoOqtWSEbar1A6pTO4tuGY_3T07kEdK6a4k
Message-ID: <CAADnVQ+1pDz05Mngq+Kv9ns2yaxXhJOuu0JawZYKuLEhBa5F-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] tracing: Prefer vmlinux symbols over
 module symbols for unqualified kprobes
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 9:52=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> When an unqualified kprobe target exists in both vmlinux and a loaded
> module, number_of_same_symbols() returns a count greater than 1,
> causing kprobe attachment to fail with -EADDRNOTAVAIL even though the
> vmlinux symbol is unambiguous.
>
> When no module qualifier is given and the symbol is found in vmlinux,
> return the vmlinux-only count without scanning loaded modules. This
> preserves the existing behavior for all other cases:
> - Symbol only in a module: vmlinux count is 0, falls through to module
>   scan as before.
> - Symbol qualified with MOD:SYM: mod !=3D NULL, unchanged path.
> - Symbol ambiguous within vmlinux itself: count > 1 is returned as-is.
>
> Fixes: 926fe783c8a6 ("tracing/kprobes: Fix symbol counting logic by looki=
ng at modules as well")
> Fixes: 9d8616034f16 ("tracing/kprobes: Add symbol counting check when mod=
ule loads")
> Suggested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  kernel/trace/trace_kprobe.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index a5dbb72528e0..99c41ea8b6d7 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -765,6 +765,13 @@ static unsigned int number_of_same_symbols(const cha=
r *mod, const char *func_nam
>         if (!mod)
>                 kallsyms_on_each_match_symbol(count_symbols, func_name, &=
ctx.count);
>
> +       /* If the symbol is found in vmlinux, use vmlinux resolution only=
.
> +        * This prevents module symbols from shadowing vmlinux symbols
> +        * and causing -EADDRNOTAVAIL for unqualified kprobe targets.
> +        */

Please do not use networking style comments in the new code.
Same applies to selftests.

pw-bot: cr
