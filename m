Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D21F5825
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779497014; cv=pass; b=i57wDLSuNovp7EupYXHPio3SM1q5YkWN7ziZ3/HEFKmyQaZTg0QpxG085Sdr/5Pr8dux1MonJOisTjtLKDMY3/H84xCcnnGZVC+ZWN1jtFdfwTSWAyAQsv3zjY1tKGdRpk7DprykPzF64bivbYKX89NvUfnTwxQwSVmW2Gzn2mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779497014; c=relaxed/simple;
	bh=fRvAKgto27u5Qw0YVnZl37234t9t9ZLTyQoH4JF6iOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPgX7spexrFLBZPq2bO+N+owPofewuSIahC40EHRKk+URqwAsRYBYSE6pdmo39itwitDwX8Ww7pulMUEGvlnEb+ky2QuqD4zBQx1ERAmrumwdEmiqsMaBiUyQSlH5OlFX+9UZ7X8r83ANdS5g791skXj7lSJd3yhVxvaVrVUDvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vy1OGaKL; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vy1OGaKL"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1363fe80fe8so2660509c88.0
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779497012; cv=none;
        d=google.com; s=arc-20240605;
        b=BcDgv406f/D2Tk/hwPeKiCR01uFd6plQ9gXAHelIRXB5qkuSCYwDeot3NYvABreWeB
         RTtIZO9xM1lZ5caocHJojCxANyxfF9UV+8IRYDKquSTOznWfOOjOeXJC5yxQkljsOslb
         Cgje7Ewnro2sgXNDCJ3O03pZYUPsy/Od1nYERi4AnT542I2LGLIPwx28M1bTupGij2ay
         UIWADX0ME+Xx0HoUeS3mEiGr/HBMCfKHnZckfmLxluih9XRmZfMOJoBQ/7jDkmla8tcG
         3oF9C1m/277vnqScStM2UgxJyxuwMiFjrNscpd9kdWqNx2yJV1TOMO/IbQsfC/O3Sf3E
         w9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q/GUzFl9apaO95CDtIhr40JrpKgtUpGRXRASP5KVz0c=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=EmRl4qAdpvsLHuuN8bZkYnlBNGAFG1wFeNIfEjhA1zfJoRL3qgVSNW8AqglHvdUTg1
         txHcyCWv6bjb1oNnFiNhBMb92g4N4hBiq4Yu4uD+cWHW1+MkLF33BrZlk+9poHqLAKor
         SkqQCb3gGF8/BT1B9qzsAutStZdbtSykpDRoVxrChojLYxRQtsHcT30FyMNipQ2fyZDw
         tpcg7eaAj/Up7uoEWkPUn5+/XIEOLpOyurA5xtetOpqr3PwBbu9ZvomzSal4EC0wU31p
         FnrXVrGWa54A0gycFWjAc82VgUvrwKaAbs5sWluoPNZONgL1SHsAtqslxKj2rObQtKrE
         EZiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779497012; x=1780101812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/GUzFl9apaO95CDtIhr40JrpKgtUpGRXRASP5KVz0c=;
        b=vy1OGaKL15Jx0P/2zD+LGRDs5uYmIjATtfShigj5IKOfwUZUlbx8h6ETLiLYMz0SzK
         TZW92ORAjdQ5vQXnDHivLsGO7sK28wMVwVCzqwT93r7DAxcZrHKCg6qkjXNgHqoLzWsW
         7pZ6rtzrZUCT1Tq8uPw1+vJw7F2ho0KjopWrsstIO3tFzQFre7DrCCnJTuN/lau8nNiH
         H+05Jl2xVBPRgiIuR7ZL5GJzzHqwVKyP3J2flQF+lmJISmcv5ZhrcTzgLuN96WDI7jwl
         9SvgDBtESf8EDP/MFYKDJgqoAvDl0QH8XfhxBlvn7CazswrwzgA/mxhBWwWl1Unaxpo4
         7t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779497012; x=1780101812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q/GUzFl9apaO95CDtIhr40JrpKgtUpGRXRASP5KVz0c=;
        b=sKvu281WJNlL3oXhlfRb2youV7pwqb83zSdhZ+o0gDp/4a9HshxN6NsKzPug/sxC4z
         FWxnnsr4V7P+VZ41eWU+BOqDMBONenw+k0p1gZsljEMU3sqJCMIur+s+c8Jh5SMn7CXk
         DfHJTvyF1LkrHShkz+xF4vqERB357D+dMqVdW0nLRDlVotJGqVDir71NeyZEFNMQYzKt
         9fTEnJ01nMcfti3qcJhkd6DExZ/NHyhiPBK5I28wLUc42o2aqWHLxtnKsmcbsgNOw2zC
         US8TtI29RbO8cHvEOIl+MevGQoSwUm4q8Lg2B48n1vo8v21Sl3kULqOvxlIs6c0IB5M9
         9cJw==
X-Gm-Message-State: AOJu0Yyz+ER/uFP3xRAcWPlLC4n+1sLOQXlREvzTQFsGFUdebOCBHXZg
	K73nMN/HCCRY9ri4M27kQkxGgaRfkkBq6JfV3wTxer5ydW7OTqHDAmeURj8lXkbLm5EXWrv2EeX
	vcSg1pYVoy3OP5XhXBgIrlzITNqQugroDlOLeoMnE
X-Gm-Gg: Acq92OHGsu9AkSRSD7z52Oq9OOXFSxUHyW4Le7/314b+aenYD9s97aHz6BbIqAHmBLE
	5c5Yy4f8KH6rEmBN7d5ool5xxNy7tSj61nciu/TpCRqWH3mPY8hjgF2ivDU3L3Hku3CY2fAf+dG
	PGC4lfTp/IAcsV88sDMI7KfCnWps9FcmVHrohpekIUsx3wBiN8i5vqWEiEkJPiqwYza7aQlmPDy
	NXRGuwtW4gcfIuR+CMtddKd6PPJKmOCbdCIS+boHIu/l0d1XjmQeVReJtYTdBnloAN579z5VE1d
	7iFpioLLLa6wC9TkIvavF6uvXD4DgXXwGV0qcgC18OPt4goc0fjeLuC2hln4SgWAnw9d5nFfYc1
	QX1qJm9CeigS8uhVCm6yaywyMTaG6KQKy327ps162jR8m4C3NN590jhGxs/JMMfM=
X-Received: by 2002:a05:701b:428b:20b0:136:959a:abf2 with SMTP id
 a92af1059eb24-136959aadfdmr149356c88.2.1779497011492; Fri, 22 May 2026
 17:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522074601.1658705-9-kuniyu@google.com> <20260522091815.AA2361F000E9@smtp.kernel.org>
In-Reply-To: <20260522091815.AA2361F000E9@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 22 May 2026 17:43:19 -0700
X-Gm-Features: AVHnY4LJwF3JrCpIIbZ495-ZcWE3wxzxjfEsOwI0EDi7fN5JnQdCe20DSmvA31o
Message-ID: <CAAVpQUD47Ga7=UPfSHk4VZ9mASDHKGbAMfaDGVQa0ZZATpKU3A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/11] bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB
 if receive queue is not empty.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 2:18=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf_sock_ops_check_rcvq_cb incorrectly prevents orthogonal flag =
updates if BPF_SOCK_OPS_RCVQ_CB_FLAG is already enabled.
> --
>
> commit 684ea4455b7f13af338937adb28643e76ddccaac
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB if receive queue is not empty.
>
> This commit modifies BPF_SOCK_OPS_RCVQ_CB flag initialization to explicit=
ly
> reject enabling it if the socket's receive queue is not empty. It returns
> -EUCLEAN to indicate that the queue must be cleared before the feature ca=
n
> be enabled.
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 5913b3be9f1d3..883e4aaed49e5 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5395,6 +5395,9 @@ static int bpf_sock_ops_check_rcvq_cb(struct sock=
 *sk, int val)
> >
> >               if (unlikely(sk_is_mptcp(sk)))
> >                       return -EOPNOTSUPP;
> > +
> > +             if (!skb_queue_empty(&sk->sk_receive_queue))
> > +                     return -EUCLEAN;
>
> [Severity: High]
> Does this check prevent orthogonal flag updates if BPF_SOCK_OPS_RCVQ_CB_F=
LAG
> is already enabled?
>
> Because the val parameter represents the new absolute bitmask for
> bpf_sock_ops_cb_flags, any update to orthogonal flags (such as adding
> BPF_SOCK_OPS_STATE_CB_FLAG) must include BPF_SOCK_OPS_RCVQ_CB_FLAG in val
> to keep it enabled.
>
> If such an update occurs while data is in the receive queue, it seems thi=
s
> will unconditionally fail with -EUCLEAN. This might break the ability to
> dynamically update socket flags, especially from within the
> BPF_SOCK_OPS_RCVQ_CB hook itself, where the receive queue is inherently
> non-empty.
>
> Could we verify if the flag is actually being newly enabled before return=
ing
> the error?

Makes sense.  I'll apply this check only when BPF_SOCK_OPS_RCVQ_CB_FLAG
is not flagged yet.


>
> >       }
> >
> >       return 0;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522074601.16=
58705-1-kuniyu@google.com?part=3D8
