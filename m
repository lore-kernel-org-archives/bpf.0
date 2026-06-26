Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3A34A79D
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506887; cv=pass; b=XqC6o+uTLCbdosWURqsAIC566zHae99OeYlmCXgJ6ehT+LtVgPK37YolikM2jBsUsANlYxy1QFnyHK/mjLmyupinSluycwoKBf7McLJFVukDjBvNgTkrTki7bZEgUkX1GkHPnBuL3o0NO7IJsKSp2jMV7Nn5owNXeMoCMSwxK3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506887; c=relaxed/simple;
	bh=KElP/Iy1UeyW/Da0/mMf8Kynq8HSdLhoCnepn/8wCxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mT/+KtR9/H/xxrFeptR0MNIOOhK2pVVopp/qfBF+8o1Dqulyx2LrZoyqVxxrKPwifOnvOwOU35jsCubWpsgm+RSxrlpkJ6i1JQ+TX8RbNs0SOydDxwml5/mTn6o4TlRZmHuPKb9HGX7pAyLoYFjBAXAqYJTWEOkIz9nrJysMi8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qaaMTerd; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaaMTerd"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-139b5e604b9so1739013c88.0
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 13:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782506885; cv=none;
        d=google.com; s=arc-20260327;
        b=PXq/pV7H9fcUAsvq/b/1zNXyoj0SdYo4I9AfK8NoPm9fcVJeL8LJUck9Db3hR7BU3D
         VkZMVkIW9m+kDMoax2lMEU+SU74IaioO9CQIdfCsJEAftk96h8jdVEKC3E/K4U0atLmm
         8jPpiGi4sdR37860erDQYS4j35Wxcu7BTEKpxywfmrFl+Zmu2QRoEp5waGNkRjXcUoaJ
         3AnudHrLYHMW2WrzJPLeOq9K3A3YYbFnCTskCaUxI7vPH6FCsX1yUzkYVqWqKBTnuRc1
         BKohMKwmzEEReQyzy8jSU1HLpaaVe/Xaok1xwEuu93YrqFweN/8mxE6Iyh6JOCfkz2Xt
         H3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KElP/Iy1UeyW/Da0/mMf8Kynq8HSdLhoCnepn/8wCxU=;
        fh=BW0f3mJD4PpdWfArYSEBDHR9Ue57SLw67aFwvccmbqA=;
        b=I7RET9BGc6I2tI0AzkcLPu1ZFuxAJRkDQRmaWKU6hDyR618ks9eVnLEv1d0kCUXPy8
         tOYlER7d7Z7lw1S9ve/52QqlsGQeiy6wq2dsn2sxqPtu9bgRPziTYYxVz+t8APQoxBU2
         RLBy355AhCW8gCscuxB2B21K3FyF/95TTl3CHKYZBaRsmc+c8lCaNIO2t1CkfhSrwiqS
         wdJ4Ln822YN2weT3/dSPsUGf61ElBtgSvI6wqKtCgc4kqsUa6gh7pHpaKqYky3cW9eTz
         cgZ4Mle1/lJAq7W3JAsVJgi6kfVwvOWlO/Ba254e0896vBoTR7VU5o6w7A/bh/vG8h8e
         t50Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782506885; x=1783111685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KElP/Iy1UeyW/Da0/mMf8Kynq8HSdLhoCnepn/8wCxU=;
        b=qaaMTerdITfOXCEd0UTm4HJevvw/vs9CVVrNrzoqqKFBKsdWib1Iy5rGO1FJlCCBQ/
         f8ifRfrwrIWkHT3czl94uwHrch/1TChpngDeOQ7Z5d2JCZw2rBr0cN5OORxNrr211ucJ
         5iY/suWLSuQ7aKZQjtH2Dtrd7fvUaIIkZmLq6rXd0fcghA+rtzlkqF50mIDyW6hAqkd4
         +l2feFlUgYSUB8aWc3yeMD9wnesjOKc1BH2lb8nr+awjEAu0taUJIKg/kD0edNd9M7sC
         2lmaFrkSC5F8Y7/T8dgkwsrvH86ozYy1Qv0y+Fd2rWYs7VmabYYbrzvQS2+scDa/yhQs
         Yh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782506885; x=1783111685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KElP/Iy1UeyW/Da0/mMf8Kynq8HSdLhoCnepn/8wCxU=;
        b=YDktzGzU+ZrVz9vGYE32SXM1iR1EHlTI8L31zxZIVIg9x/Uj9N7DZB3hBgcBCp3UX8
         8oCrE6GuxoChQ1BXb+3kysUX68OuAz1zuKjFhDIWyqlCVTlN4MefiyH4JYaZc9nHYUpI
         7RNrEZsvNDneSBUK5ZWvjRogYVyQ5G9zD1/hC1CI/6nms0+nhMB9PKpZMO6o4DWWzKUV
         GdtRv+JM8pVUpUEOLDoGQgvjW/M9KTMEAEYwScJKBr4JV9O6nvdgWC7U/aqKqjoGtoDl
         QGRB2ycKuPqr0LQ4YFLU2HYOhGQ9KmK9QASCHYy+NMB0FWix956BEy7zzD9NftZBHx2k
         LlOg==
X-Forwarded-Encrypted: i=1; AFNElJ+PbtzQ77/pGPCczYNnAi/pz7kSiQq4qL3/B0jxb3GwPXHwVeq+yAW5f9yvfk3R3I2BzJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMyNd07dw++r1d/pDON9uzshtglHDMHWotFxm/C9IwHD3O7Zs
	HJGuqENqRz83uIAI/kGhZwcDpswYDVo3DI5FC4lDZJX2FJ93eUy2f9Id6JdjprAot8o/Oy1cpRg
	qNQjHUQo6NGPV0WCw4YU1TG6qTLN1VjgzMOcnD+5H
X-Gm-Gg: AfdE7cnBCx+fbH544TOwDjSOdy8j44GTwzcM+dQ42Rjp/OoE+L+kCqE2JcE4FQajb6f
	MIjVlIlh49vVIyDKrnni66d60d50nDBFFS2XDlQMDMB618hBzBYMgqLruMO2X2jyDFSnQ7kzVWm
	RFx0U6z7VZSHIXCzmVLbR5r+DRUsakcou9L2djlKglLdBzdvJwg2KB675dWWQPd6reG1xR9ml21
	mS62bMcuG2H2VJl1V697IRyh5KdofN8X6V0gRSp5IOFVsqjJ1sH5CAi71GGZAvYsLn3KgirMnO0
	+sGscjLwU372Teu49TJsrmPex/ULTjpjM4YvTVzGLyllqchAyULiY2qXNUXP2zopS0Xj84JBTRb
	WI7dYRyCRc1TXXBHfkeGZn8Zqnz0hmI9Wx88pQVk=
X-Received: by 2002:a05:7022:5f14:b0:139:ed5d:7568 with SMTP id
 a92af1059eb24-139ed5d95c3mr689594c88.47.1782506884557; Fri, 26 Jun 2026
 13:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co> <20260626-sockmap-lookup-udp-leak-v2-2-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-2-7e7e201c951a@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 26 Jun 2026 13:47:51 -0700
X-Gm-Features: AVVi8CejzJHp_vEaY_FIRiYnk19hwrxgeyua0I2We0gP1Ictf7xHIFKUIkMHCdQ
Message-ID: <CAAVpQUCGpSWuei+cX9LL1WG=-14_FJU75G2njvvWCugsSMWDqQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/4] selftests/bpf: Ensure UDP sockets are bound
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:37=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> Update sockmap_basic tests to bind sockets before they are used. This
> accommodates the recent change in sockmap that rejects unbound UDP socket=
s.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

nit: this should be patch 1.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
