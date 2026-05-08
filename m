Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C535E944
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271993; cv=pass; b=VLJPEPBnaD9w0SURgZVgmsaanv7gSRKDIIOCJwfiiDo1M7nhmLjwf0CNl3X59yeylqK6mxv166Efcip7yoRf97fFMkGG6G1xp4VDvK+yvxWwi3Ysf1TwfWXpBFq8o3RBDGwXgIGgKnvm5+xMqk3PAsI27ni/Wpcb5ZCeNs1PyQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271993; c=relaxed/simple;
	bh=lxuW3j4GqHcptgKyL/J2NALd6wSfGcijzfrXHbAVRVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruhEJyugfxcK08zrfyAtyt8MqBo3hy0Q5nZtZUrbu8i720ikLL//Gsz9qyJL93iG3jNhFZyid+cknxCJ250qSCdnJBMF2DENx0+jPRd6PL3tUJxCdaf4XvDAD/ZOECDfJCQPEVRJ7SjfU8vqreML9+g/bXwN/C4YCQOgAVtnHgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+THMeXx; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+THMeXx"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1329fc4bf77so353860c88.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 13:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778271992; cv=none;
        d=google.com; s=arc-20240605;
        b=afp33IozNNSzou8LxqI9Pjj9XiAn6dhSHXkcDg5CsRIL0Xc2kPO5WvAVlZY2oc3m4l
         B78XQ9dQljp8aoI5BqTaN7aIViK4ZpX9YfBltgvG5LbUJqNQ5ysO/ylcGALtC0g4/2gt
         maWeaamFnUm8OX1j4WybX/6TqreNYn+DGUt/UqK9d5QvVUjVKXwtWhZT9QT0hRue3GXf
         kL0oUmDRwA31rbqfsYA8k3gC8BUZHcvXzCwAgnjLatzRrWcTmeBwq44U0hyIebq4FYu+
         BDR9wg6KdHqUfhvndKUDDpH+z5LpzX2H3xHHByvqI4uppCVj8IFYFqKdWa2GwLDRpSXi
         HSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3odDrbDW8wBjms51QgSiFASGVEEXp49Os/e0qhZVjuQ=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=KBOgLdouQyq7rYIszaWppS4Bh+lGXJC2VjVLTZSuao69wD4use05DSqxE6Bp4RMiHO
         lc3M7c0hFf19J1sH9rfYrbHHzNE4IAxzsCmj+DH/51S8fgBjI10C8F3/CN0zlYJy/oGQ
         Av6lz9v3HjXfJ0YwNnuQwf2/FmlNv/bGhFgduXYGGLhYIw7TKuWCoGWqbvldnDd0jSSH
         JnuuBd05Es/hGbanzu7dduwY5d9AiRFAeUcADmBHYjkZ4wzh+5aLptDD9+8y8QjWqD6i
         WMlrvAp/9zORetQ41TvTCP3hLhu1aOLw4FInpgPcnwjmlsrbjiGf79ubKTW+XEyTVz9j
         /NFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778271992; x=1778876792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3odDrbDW8wBjms51QgSiFASGVEEXp49Os/e0qhZVjuQ=;
        b=J+THMeXx/zJexeBoR04YVxHFRx0TeDwuFlqamXP2P975U21AupRbQG9gE1zH++bUJl
         C6ozxokKfBb/WSBe4yQJk+TGa65cNsyI8HS0vC44Je1T0eM4IQSfMwozyIXJrf0lhpuq
         vLCRc2sMEJ3zmkQDcDrzCySYnbzq6Rc1ByOEbt0pFGftHwElRhgAdqrVEDwqs0OpE9GX
         YB1qAKibTKomAhjwNWdwyycymwQUbKkS9TVLgjfJ3FPwQ0992O77h6hpELDMz8iD9FVk
         NNGOwV3wxuRWlAo1ySIONwvUR8RMfTIFWnbqcy7H269QJ2Su8p4BQ7IiB7xED3oWcBrr
         CoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271992; x=1778876792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3odDrbDW8wBjms51QgSiFASGVEEXp49Os/e0qhZVjuQ=;
        b=F65SUpRrTUDiiXUvGlMr2c2C7hZNweO2egOYMTe4zmgCreXW2U58h02OuUwhWeYuxc
         lMgRgodKkltMzO9X73U2cGAm2cCL8aa9H5egrnaDJL1tERBVyJ8W1Fo3AGHjcHbvifW4
         KZiNS/zz/FYZn96M/nqJdbU3p14fLVMDTU/iM6HtIJ8fvdRow1+GMv2yUGYO8WmK8E8G
         wA33Qjg7ZN7bYIgxW9abVXrbhUksfiwPkIHlA4xqJsOfl/iPtT7QcTjQwR/pNMWpFdDH
         8n6drrtRLwUh3gUkQewlu8VvuF3KLiipWZP0XzfNHlnocSqpkOIspUE6B5AGjG7gye9l
         CdhA==
X-Gm-Message-State: AOJu0YzlzRHP+8N9hE7o0Eyz0SZ7+rO/5pE3IjQpPxl/HjMZHNV66/wb
	v9rT9G2pYg5r+srWBFvyK2kV/EspBZW31UBN9t3qNRdr5g8vxQCAmBEysbGRt2IBcDsT1KVPt8+
	K6A81bvZd//B5/5opDPfGaSawRVGl5Zha74j/aptaU0flDcsy2x5wWNq82DE=
X-Gm-Gg: AeBDietqrXGWRd3+QM/0gaQVkG8xZ4ScTNQzX54KfNewyoOelogodjnNjtvRbC7Regz
	dU2pUwUh2EtWaBlUyjyhUJlh/s4W+NWT7fP0PcnI8fvU2xIZR4W21zf3hMEeXoxbgT2wpbBmx7b
	F1bzTJbPpabiNRkYDJLB9X82WyJWdAqcHnWbmRxQpBmWAEVrG7z+u7go1GwklcRH7c9M6ji8/+/
	HNR6quBsNY/0AnVjh1DvkpqLqXZSscZbOx66Adf/kZxIxzxAKdey+s68uuBgdD+LdJerBWQwwYL
	bvm5BQpy0dWNMxvAu2Wxwt/LGDtpoHREATUJ5CagxvXEirYGElfPICGl33pVhFOxWR5ZXArA/0S
	6V4XtRbgCp9Z7FX23a+1Pfrpqc+H0FtU=
X-Received: by 2002:a05:7022:ea24:b0:12c:87f1:f41a with SMTP id
 a92af1059eb24-1318e91771bmr7525230c88.21.1778271991253; Fri, 08 May 2026
 13:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-3-kuniyu@google.com> <20260508191737.01190C2BCB0@smtp.kernel.org>
In-Reply-To: <20260508191737.01190C2BCB0@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 13:26:19 -0700
X-Gm-Features: AVHnY4ICHUHDZYm28szu71sFqY4e-p8Nj0_JIbZRlpsCllnhj2x6FBZx-tQgYqc
Message-ID: <CAAVpQUAhzd6ocMBwKFxPAKkuHyB2D-HL5fjrwcBcLrxwQbaT2w@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 2/8] bpf: tcp: Introduce BPF_SOCK_OPS_RCVLOWAT_CB.
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 12:17=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The deliberate exclusion of BPF_SOCK_OPS_RCVLOWAT_CB from is_loc=
ked_tcp_sock_ops() disables critical socket helpers, notably bpf_sock_ops_c=
b_flags_set().
> --
>
> commit 2ab2e31caf792b1e7312616215a88ad7ae1ef4e1
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: tcp: Introduce BPF_SOCK_OPS_RCVLOWAT_CB.
>
> This commit introduces a new hook, BPF_SOCK_OPS_RCVLOWAT_CB, which allows
> BPF programs to dynamically adjust sk->sk_rcvlowat upon recvmsg completio=
n
> or when packets are enqueued. The commit leaves is_locked_tcp_sock_ops
> unchanged to prevent unnecessary enablement of bpf_setsockopt.
>
> >     This will allow the BPF prog to dynamically adjust sk->sk_rcvlowat,
> >     suppressing unnecessary EPOLLIN wakeups until sufficient data
> >     (e.g., a full RPC frame) is available in the receive queue.
> >
> >     Note that is_locked_tcp_sock_ops() is left unchanged not to enable
> >     bpf_setsockopt() unnecessarily.
>
> Does leaving is_locked_tcp_sock_ops() unchanged also prevent the use of
> bpf_sock_ops_cb_flags_set() from within the BPF_SOCK_OPS_RCVLOWAT_CB hook=
?

Good catch.

I need to support BPF_SOCK_OPS_RCVLOWAT_CB in
bpf_sock_ops_cb_flags_set().


>
> Because BPF_SOCK_OPS_RCVLOWAT_CB is appended to the enum after
> BPF_SOCK_OPS_WRITE_HDR_OPT_CB, is_locked_tcp_sock_ops() returns false
> for this new hook.
>
> Both bpf_sock_ops_cb_flags_set() and bpf_setsockopt() require
> is_locked_tcp_sock_ops() to return true. If it returns false, they fail
> with -EOPNOTSUPP.
>
> Since direct modification of bpf_sock_ops_cb_flags is disallowed by the
> verifier, wouldn't a BPF program running in this context be entirely unab=
le
> to clear the BPF_SOCK_OPS_RCVLOWAT_CB_FLAG once it finishes parsing?
>
> If the flag cannot be cleared, does this permanently trap the socket in t=
he
> fast-path hook for every enqueued packet and recvmsg() call, leading to
> performance degradation?
>
> While the potential UAF concern regarding bpf_skb_load_bytes() is a false
> positive addressed later in the series by "bpf: tcp: Support
> bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVLOWAT_CB", and the hook omission
> is fixed by "bpf: tcp: Add SOCK_OPS rcvlowat hook", this limitation
> regarding is_locked_tcp_sock_ops() does not appear to be addressed later
> in the series.

Looks like Sashiko now has context of the series, nice.
