Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E830C37C
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855709; cv=pass; b=RaI7YOgjSdc2l45r5bNfl9FM/mQFM31OkI52V+8bi3yvKHe9S/x7XlrMKC5nSEvAAMwJ6Kla++4q27AX9L5lSbWxL5QSIFztNzMyxiuNTqDmSVjLWVjw2ZFd3zKC8K3f0+7e3nketmFCEDVJWblZ3HUwXsVLVLTRjdL4V7xh8WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855709; c=relaxed/simple;
	bh=Gm1Bg0Q4DelxFOLvPjQd5M/mGETysFMssmFfnQE9aUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyoAnCIkgHnAcrPLDgyUIPY+Vnnml2JAcCExSSMdTGOqXxyvluuuMH0u/3W+UQe+2frHBfIc3ck8UezAkptZXSPveXHSFiDEwJNKYkgrH/x299C/lBt3xmbWE3K11eZQ+ocoY9LvpZn0JsFoojVgyQnutpjjD9rciOAzypm01vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uU/qFRsJ; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uU/qFRsJ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517dc520840so32212351cf.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 08:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785855706; cv=none;
        d=google.com; s=arc-20260327;
        b=MNxvGJOqe11dJkvajc+eH7wek/xT3yjDGQTI1r7RlyOarJHeffa/AKxMZMILhXQPQc
         jAjwrlKMbq+n1bl51bUBDPVk6nGOixx9St4bI47jv4Q5LXVtGTaB/PhZsvxJc+P1PKYf
         YKndaYsbAGzsZILV3xCNjuhCo0jmm8FXZo75R1JeGV848hN8AxFLazO5WDr20cN7yYe1
         J04Amio8x4ACzpisoavEvlLR0h/bfxU0+id6U64C7M4y+k/uoZMjLiSp18nUaLU/He0H
         3364F0jrIETUcf+jm3waGTIIxSHaYmnRWwaPF8hZ4toPUVbaSVzJxTIwNGAP7082XJUx
         vmvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gm1Bg0Q4DelxFOLvPjQd5M/mGETysFMssmFfnQE9aUs=;
        fh=Vi6H2mT+EsMsG07LkQKPFIaHzN2Q6CZ6E2dI7KrsM8w=;
        b=GnCh2Cw4RNJo+SQ9W6d3tAoafATC+lS7BH0+tpLVY/6JVsolLORUOYC4JxCnvZbXqI
         k5fBZ9WfETyJbgoaIsxB1Eqjz7aLuNA6bHdMHit+SurktHCTDKfw5RBtQIWmHXXNoZvk
         ibNHw2Ff5pVNpi7/wqoTSqJyLv2DWrnclZDPta3RlvoDMhr25vPbYM3WI/7CaPSOojrN
         2yf9OsLamS8UlLQIdYW7eFXjREd2LmcHltQ77OI9H/RYS7eiXGIeFk4gsrsKQLSZDr4t
         4F6Wize1bXlRj69DSt8fstQoml4o2/hRMwisx6QhaG2ZqnNZ6bFLqy+peSo2QwVS5NVc
         +I5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785855706; x=1786460506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gm1Bg0Q4DelxFOLvPjQd5M/mGETysFMssmFfnQE9aUs=;
        b=uU/qFRsJRsyz2D+U0sh47u5KIJ0ZhmJBZOF9Ex+pwc1syF0qCT+iXeLlGVHJnuAl6a
         Q/EchurVRhkASrHTVFB6NY9iAuE04EPwS922kmyv/ZU2pu06Dk2BfdccimIVPisR7TMw
         FQvhDsxUXlRxmHzUzRP6dI4KvHTu1PHokLjtqkyIw8PmoYWYnqRQyQ0Jn8GFD0D1i6A5
         jyGn9pluOKuE97jwpozcLOapvKTjVz+ZM5LQx1E0W6WYODwfd+Dju+/CY172xHJynZMz
         F8hg80Azv+D3CteevmBjDO6zaPu2j6A26ZToAgHWU1E9zgiuuwPr2htyXbHej8NGO2kl
         42Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855706; x=1786460506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gm1Bg0Q4DelxFOLvPjQd5M/mGETysFMssmFfnQE9aUs=;
        b=rm1v4qtQMdsldnSa4f66v+yV3KXrgNYR11D0dTiZ8dee+vKuTBbqxAOiqa8/MzLFOH
         n/HBBU3VzhRNX1o6Ggt0R/mCmRAe9d/SU0BF4P3g5mhrCu50byeqsoRIcR09kApyE9k+
         +x9Aq5nZifefH9zXzIlpJhBuad+o9EsKIexi3C4vpGvLX5qM2roDCkAdgkZfjdyUjnET
         UnNVccW9Onrc1LVvJe6+Y7gE1rLhBwmkPZhmxSWRd9E0i0s9RTM21SfXc8PQMCWS/HHQ
         p7xMG2DwHGHsgc1NPam6hmjberLbK30FJyitrv47ssQ/F3pfuyd534RSWDRJBpNVSQ6K
         16KA==
X-Forwarded-Encrypted: i=1; AHgh+RpdZshUKwHH/2DcfX0KxwT84V56l08GqVoA5ok276Lq20nA4QRucCFT17HhzTjHnBC2bwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkAR5sXWqm2jUmXarjYKjStYkrHhGSlbjQfsKdFvyk5GFKrpe
	f4eXOYhKWNJ34FfHqJvWiq+4+cT55YhcPRB87zWDQnUkYhdxxLzdUw/tIS5H96z4DkA8yhJxOOE
	MixtotFhhUYqB+IIKi9n09w1Fhnyc84NgJ3H0V4MeZvvmPiHKw5z81FNC
X-Gm-Gg: AR+sD124GTYwp4iFmLibz/yE7jz857rsYg9Ouaby7qfXqXqh8FfbdLPC8HKjlwfPQCk
	h0vVi75McE40bxKxPxLu6VUkX2UFwg6z6O+6TdQw8O50dPkum0J/X1Fll1X8aCY6AbJrNcXxoSX
	mmT8B3YxBAGPWe3rY8ny0FqUfE2j+pLP7/bXXUL28oNaUjEFLlcYCDPt7SJlyfLu7Y2g197wNPm
	4ccOBikika0DFvw8u7HTHkNBZIdAfU5XzYlKGAr7/f4FOpQfCBn9hlCtWP/+uVsUbFsPnZtYFKn
	kEsL6Mq7vNKY4LU2btOsUI/d7Qr+o0nQJB1Frwr1UVAYPAvDRh/ulc+WhqlkMcjRBYAoyX236uS
	wcMzjiV2y4QdRAeUUQOmA7rwIaz0ZK/395WMFuN7OtxV5gyOtxwmTJn4=
X-Received: by 2002:a05:622a:5c1a:b0:519:b5ef:7fdd with SMTP id
 d75a77b69052e-52b5666c4aamr282275791cf.6.1785855705379; Tue, 04 Aug 2026
 08:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785823138.git.rakukuip@gmail.com> <6218aa3534d0d2d3f448fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com>
In-Reply-To: <6218aa3534d0d2d3f448fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Aug 2026 17:01:33 +0200
X-Gm-Features: AUfX_myRYK5h5EqLM3l3dY-aqNjZceMzS2Yr38y86_EP7ctdV6zLk4B5bfLoFh8
Message-ID: <CANn89i+8EawQn7o2uCosBXDy3VR-uTdxYwjvt3NzyTPsBySfCw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/1] bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie
To: Ren Wei <enjou1224z@gmail.com>
Cc: kuniyu@google.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, lmb@cloudflare.com, ppenkov@google.com, vega@nebusec.ai, 
	rakukuip@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:29=E2=80=AFPM Ren Wei <enjou1224z@gmail.com> wrote=
:
>
> From: Luxiao Xu <rakukuip@gmail.com>
>
> bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie accept a socket pointer
> 'sk' with argument type ARG_PTR_TO_BTF_ID_SOCK_COMMON. However, they acce=
ss
> sk->sk_protocol without validating whether 'sk' represents a full socket.
>
> When a BPF program passes a mini-socket (such as struct request_sock or
> struct inet_timewait_sock obtained via bpf_skc_lookup_tcp), sk_protocol
> is located beyond the memory boundary allocated for mini-sockets.
> Directly dereferencing sk->sk_protocol leads to a slab-out-of-bounds
> kernel read.
>
> Fix this issue by checking sk->sk_state !=3D TCP_LISTEN before inspecting
> sk->sk_protocol in both bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie=
.
> Since mini-sockets are never in the TCP_LISTEN state, the condition
> short-circuits and prevents dereferencing fullsock-specific fields.
>
> Fixes: 399040847084 ("bpf: add helper to check for a valid SYN cookie")
> Fixes: 70d66244317e ("bpf: add bpf_tcp_gen_syncookie helper")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
>
> changes in v2:
> v1 Link: https://lore.kernel.org/all/ca8d8c570509b02355bb4bd4e56859f3e256=
4c9c.1785576172.git.rakukuip@gmail.com/
> - Check sk_state before sk_protocol instead of adding sk_fullsock() check=
 (Kuniyuki Iwashima)
> - Correct Fixes tags to point to 399040847084 and 70d66244317e (CI bot)

OK but I do not think this needs a series, a huge cover letter, or a
bloated git log.

AI will be able to rebuild a cover letter (of arbitrary length) and a
full repro just by looking at the fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>
