Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA82AD1E;
	Tue,  2 Apr 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077131; cv=none; b=Q76gUJlSUhZhmZzzB0JvM9EIlnEzy/l3F75Rk8HIo655f+daYhnVPpasudRRScchDoZDGdVN828R8u6OKjKMrmb0E/e2hTLfciAsmUyru3+eHOvZS4ID7rEVu/tyYkaRbFB9Tp63S/LwdqvVrd3y2Fnlit9GKNq+q2OCRq9HU1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077131; c=relaxed/simple;
	bh=Q+RRJ0CF1GZvmxi7po6ZV9cub5NwpQNH6APpN2f5sEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlCCfSEC60mlL0pEaXGu0Bnj631OHjSm5B3gdSS+w8VqKQ24D7N6DptxqHAnpmhBw2pMdiSm+hDfUqIQBfS0xkWcoOjtsWI3ac0tgxYN3mAD3T5gQfpEnAG1ybzOIosI/8bAI2wiywml/U78jbR3ZZ4rH3Ukt2kRbDf5uXOu1Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ni4/ondA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni4/ondA"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e220e40998so29639575ad.1;
        Tue, 02 Apr 2024 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712077129; x=1712681929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrOan73/B24oAGslX3HeYJv0/juyY/bVZ701pisbD/0=;
        b=ni4/ondA2lO7wPGBxTgnXcp9leCz3kAUy2MAaMYHjwPFRy6uJfmtIxs4/N/+A/V+Zk
         23MRUND45h3Rk0nJe8qZGshkm0HtQFJIyT1NNO2DFRXGBPJIQT1vBTeAIpP2GlCC+mST
         LnfQ6/QoLAPRrGnqyBvzQBYjY05LvysKxzwvgnu9gf0EM+2uCkEkuSoaFMaVXpYoqybS
         E6QpeFpw2rDPEwXh+8vZXxuB8zJN2KejHFOvKQynT7/rko+8eU2ibUbwRwm5h79AF3Vk
         bq0Lk1ttKMSwUksd2rdvyoGTQgN9sNfgwxksFf9EztHhOhk/Jl7GvBFU4aRDW8OgrBQg
         audg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712077129; x=1712681929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrOan73/B24oAGslX3HeYJv0/juyY/bVZ701pisbD/0=;
        b=TchhpjNy0m378/ob8sA86RPoUQZqTub8qLen436WE8suWPIyltRKDGESvOoY6dik62
         WAVwtEJ3rLOeaZ/QiM8L4VqyM23pWIKpzRGeGPfgTiVHwffIY9uecgKiwEz7Apy7sDCK
         2u0KWyC+gnOnwyreEqcSjWugrWPcamLdcp+5hNOxnwUcol2oIJ94JBBSh8KK0KznKjLE
         6Mlug+T2XWdOb2kQxjwMIbfKiRe1+QyQI/yR92Dr2L243t4DNSjj4b74FozBYTW828t5
         zMUrlCWR2MEmuTJMIc+hTTFPLyv3stJzU2jnT8Woc5nYK4do9rna1wAfMegSD6owS6NI
         gB6A==
X-Forwarded-Encrypted: i=1; AJvYcCWxZwHAV9+xOBbAsNXs3WuMIT00YK4BuPfkt9tZOOK7RWhWeqK+RKLNYJCriVuMtnaNWKBzSluhalPQsK06elMKR57J2sK+CNqVSyw1f023o9PP7xobS3My28iSlu4CuyVARMJ4KDfg
X-Gm-Message-State: AOJu0YyWxIWH3RkRY4DRtEXG+FbgAgMk2eqqPFjoFuM3xefBC3SNuHF/
	7o44MBgKycQvs3dffbz9ysT/IO/yap+NNn8c5Kkf4lyfEyVDUy3yNLyqTfD+e4CkIprqv2gUOOV
	PIECUc43umay4hx6VhlBjEmNRnm4=
X-Google-Smtp-Source: AGHT+IGbokNweFK+ud/enu3N4BkesSiI+KSvQSYEY65p2sVq+H2h7Ct/jyZXN7h2PqqGv0CEzBJzA9hnvuhrL6cOn8g=
X-Received: by 2002:a17:902:c255:b0:1dd:651d:cc47 with SMTP id
 21-20020a170902c25500b001dd651dcc47mr258347plg.28.1712077129030; Tue, 02 Apr
 2024 09:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401191621.758056-1-thinker.li@gmail.com>
In-Reply-To: <20240401191621.758056-1-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 09:58:36 -0700
Message-ID: <CAEf4BzbbneDHp=sD4+5RmuK=U9vg8Uo_M6XEXdKWrZ_MkjFocw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] rethook: Remove warning messages printed for
 finding return address of a frame.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: mhiramat@kernel.org, martin.lau@linux.dev, kernel-team@meta.com, 
	andrii@kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 12:16=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> rethook_find_ret_addr() prints a warning message and returns 0 when the
> target task is running and not the "current" task to prevent returning an
> incorrect return address. However, this check is incomplete as the target
> task can still transition to the running state when finding the return
> address, although it is safe with RCU.
>
> The issue we encounter is that the kernel frequently prints warning
> messages when BPF profiling programs call to bpf_get_task_stack() on
> running tasks.
>
> The callers should be aware and willing to take the risk of receiving an
> incorrect return address from a task that is currently running other than
> the "current" one. A warning is not needed here as the callers are intent
> on it.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  kernel/trace/rethook.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index fa03094e9e69..4297a132a7ae 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -248,7 +248,7 @@ unsigned long rethook_find_ret_addr(struct task_struc=
t *tsk, unsigned long frame
>         if (WARN_ON_ONCE(!cur))
>                 return 0;
>
> -       if (WARN_ON_ONCE(tsk !=3D current && task_is_running(tsk)))
> +       if (tsk !=3D current && task_is_running(tsk))
>                 return 0;
>

This should probably go through Masami's tree, but the change makes
sense to me, given this is an expected condition.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>         do {
> --
> 2.34.1
>
>
