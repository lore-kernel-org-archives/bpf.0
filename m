Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4531C8604
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274712; cv=pass; b=LsVIaC3US/HRgNFXEvW1VxNeOZ1xbejcNNqpw9KDkPWPECSUiAUODFRXxrNGfOieIhZdfAMundxyn13AzjfyeS6+hH5n0YEQDtL1zKfH3fv8fYjyBnQOd7RFNbXNE+geXZ/hFLxZLE7SE2s8LWBiR618CFhL+PD0LipwriCGVNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274712; c=relaxed/simple;
	bh=IZ4XZSF64CuwQFbBvvn/SOHeTNC96IzPW50aIXcYpmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yku37OWENmkhuB8KqVtUjxxC6mazlq9ThGEodNdlPQJqVmjB9BZ+d/0U6FtAD/dOrp1ZOC9ddXiCEXm6LB+5VbJfBuoJbfDv+mA10QPPcpIdCQEALWkRMuSrfjgrWGEHeVOHOaas/E6p/ZMtAe/f6eLDREk9dD1nn+BMYovyY/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=om06fQzl; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="om06fQzl"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a762db7aso4953285e9.0
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 17:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780274709; cv=none;
        d=google.com; s=arc-20240605;
        b=A/Jp49vgahOmI3CSWCc65pkZSDJGgR2tMwCeT5kC8lzvJUZzxyXENeqt4DjBJM0MZ/
         CImEZ48n2w0LjpXKee7YFBZ1RoEIz9hNxCU9pOBLvXo7oFQJMRpuJXiatFC7ZV0uhehy
         SNDXFhQKpKH7djNCKLpYnMhvg975e7Po+dxWqP4PUuwLdB1OvEmx/ecQ8ZD5Pnj5yhgy
         iXbOakUInNgJSQ/p36A8gNrHNOnjSZ7eW3VAKY5tqsa4Dlvs4lWE3wXaKSn0ee4RdWk2
         KjJlOnEPTydinYlkOMYG6iDt46X+IlQalMoH1SlcG4BYw7uE128UPu1r/XQ1SivfTnI1
         SKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NR2hmbEsf+lZOhNyIUzFrhZQ4twYIu9TsbQ2+1H9Yqw=;
        fh=pZQIFKirb3jPzAax7r7ujNvmO9cg6+z99Xzwkx/OUpk=;
        b=kCLmQwLtZOhLvWX8A6kyQvex/G4p3OR5MShiZ8y3lm2fSQHHUoMVSr4Py/F65kJOmK
         +8vOwwJ+R7bS4YPxhqNUcn3Xsd6xZTlUC1PSoBUyZvmQeBj+283Ml5r6flFUFh2ciUt1
         cgzS0d7+lwSyVaD+9as29xSLdPH2i6zTUix26hfLfsG9VTZNyiklfj9CEigAjvjnCX75
         ngjL1sc4iKY0Gn0IlQiSD77EX+egcKsW6P1V5JPnaMKOhjpUn1LUkLUhLj8coLQgCiV3
         JqOEGyfhGn5WcUeV4RHAA5YIRx4caJJcir9f/AHDqD/DYpBs1DvqsWGzTRFV8iPVATR1
         Sazg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780274709; x=1780879509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR2hmbEsf+lZOhNyIUzFrhZQ4twYIu9TsbQ2+1H9Yqw=;
        b=om06fQzl9Pe7ZDw9yJtalGj8wV9NlNZQi0Ra6RKs32AYCE2qK2SatqyvAKdiWX8moH
         3xBtPBld5UiKtMCqZB70uWpcWbhh4vwbPrDofx/i2OcqUVJNvPjVgi+jT5lKTHwq/85a
         iYz+BD1MCJPADOdyC3uazqqcnhCsJ0F8DKkfmVXQjiy0Heg03EVOVVz685JCG6bZogId
         LxoXOAD+WqPuuCFWeD9cSyZmeyy9DmlglrSV9bhoQTQRRneNifVYogQbowunWgPkfX5A
         8p9xzbdNISDZxX99EFrRYnPS8G7gfRyBo7/R4CGL3YRt1JQYUEkqr9bp00+MNuFNjSSE
         UXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780274709; x=1780879509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NR2hmbEsf+lZOhNyIUzFrhZQ4twYIu9TsbQ2+1H9Yqw=;
        b=O55dxV4Qy/9BY7QPk3n4srsMAnT5uFzPxFOEHdtANkZV2/vN+L0v1ztQQ9+ujhCNGZ
         ZCbIVP358yBn+cUZQM6jHpTiXLK4tIUtMOK7+ysFTglfGkbwRDdZ7T9H3mOPbm4xN5mi
         BDdHwE50zB7SpgO2aqi5C7huLSMzD2+0PsQsqtTqG4vpbojA8mxnldASGSfy3QxCtlo9
         HJJYh42zGQFXTk6sp9HGj+jeBGu39Kz9+mTKT0Nr+ztxWacGz59VQAVHNQpv4W1mSu+e
         AxRWk2LIjGQswwEA+h7ZCbojO0H8CplsLDSZVPn0jCSbee8XDAhTI70zcJC/z4nBRWmr
         yi8A==
X-Gm-Message-State: AOJu0YzC5zR8c6j4VfnvaLEeIKNCf0a7R3CRZbd8PArDpq+qPjubNt5z
	HN4zNs9dMKIwHX3M6LD5MgqzMtOrJmPHSCzlvJ+oLaKFf2Oxpo8/Y9a742Bvp2TUjQeFRZfITfe
	e8/92tzPSt7Y7c60y9o+SAE0B0nJmjPc=
X-Gm-Gg: Acq92OF+tkVtf4SvEOyXAPmoPFmvFG4bVkV59KGOzb3Nshz+VszPqKPAxqYOF8tK2hZ
	XhrY7hKfr/kVlUSeyhaSjqbg7bsYgZ+X4QyGeDmltlhARlQ3C4tmiQF8dthAQQsxUGUzPA+t4mh
	9ffEOhdJAYHv50AeSLxibvcpQmHUNzMQXwDTfaeqTjWmR92TgnH4htAGheTNkpD6iP+o2h1B5Wa
	f+FzuGoOMJWJLoUaiZuOodb7Cqgsu2QiS+OqzY4R7L9HKkE9DsqUibFoz1kX7K31umYHjVw8+S3
	0F2RLXRq6fGihtXUUOQ6EGYw3v6oMsa8wC3g4BrkrjbHqNx0IKDryF4tGFPDo0nykwYfjgfcLED
	S7nWUyO1SHr6uG9Y=
X-Received: by 2002:a05:600c:4f87:b0:490:abd7:fd9 with SMTP id
 5b1f17b1804b1-490abd71214mr7854975e9.10.1780274708953; Sun, 31 May 2026
 17:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529151351.69911-1-leon.hwang@linux.dev> <20260529151351.69911-2-leon.hwang@linux.dev>
In-Reply-To: <20260529151351.69911-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 31 May 2026 17:44:57 -0700
X-Gm-Features: AVHnY4JLy_kGPt9SuGY_PbelWeENHCrokYlfBWentfqbHu0QQiGfeVQh1WKtLPs
Message-ID: <CAADnVQLh7VEKAtckzz=XOVPT8ovpDQshvPPCWHDQu2OWQx27_w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/4] bpf: Fix TOCTOU issue in lwt
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Guillaume Nault <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Peter Oskolkov <posk@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 8:14=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Sashiko pointed out [1]:
> The hdr pointer passed to bpf_lwt_push_ip_encap() can point to concurrent=
ly
> mutable memory such as a BPF map value.
>
> So, the memory of hdr pointer can be updated after skb_postpush_rcsum().
>
> To fix it, memcpy() the hdr to a local buffer, which will be used for the
> following checks and updates.
>
> [1] https://lore.kernel.org/bpf/20260525150010.CDEBA1F000E9@smtp.kernel.o=
rg/
>
> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_pus=
h_encap")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  net/core/lwt_bpf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d..8009e427851f 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -599,6 +599,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool=
 ipv4, int encap_len)
>
>  int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool =
ingress)
>  {
> +       u8 buff[LWT_BPF_MAX_HEADROOM];

extra 256 bytes of stack to partially close a hypothetical issue
is not worth it.
Ignore such AI complaints.
Not every "bug" needs a fix.
If a malicious bpf user wants to crash the kernel they will
find a way to do so. Especially with agents.
We cannot realistically close all of the holes.
Right now the priority is to fix the issues that normal
users can hit and not bots.

pw-bot: cr
