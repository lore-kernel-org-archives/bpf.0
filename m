Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605217;
	b=ydzK0TJvEICQzNL3SunGFyUrraQfGcHbNtGOHpew4TmwxmzK3JkvgyBmtxVY9WutG1JL
	 iXpKhjE8kCWBMBYHKoDEyNYI0wHLxSfxCVme45tj2upUm0EXO7Dh5Tf3Dlz4PtHVRhzZy
	 ZrWnJKBmMzajsuBRkQntuufRzseP8AE89BhUBnnmFxPjnhHWCmEHHF1J7QBA2QkDctMur
	 QlkeA2xkyxQXkiuQbxjndPwySJOh5wj5I/hmcPGXGhBrE1y+w3e9B3VQHdHJL1jIclkMF
	 mwLjEt5HUyEN1CLKVWDzw7B/nWnfVo/EEvs5V60IdU+238WhPi0IDr1KSgcXfG8KOJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HRzIKbKLO9ua2/xR6UHeXwPGuH+fej2x2QAgvQV43mY=;
	b=f417raFJzELVh3PMuHldRY9e3G2X3euQMxET8BddJ7ZPPG7pGJfpww2VBOAOIxcGxhVZ
	 KXSoCFdfUbtoQHE77z+zo+y89fG49gdeRkZLeDIRPPjLahaLu2F5b54XDGDZlB3FAEihb
	 x3/hfKnf80c/Kt6xjad0/0u6tmUvexkpqm6xTR8vB5st5XpF1GuikN6b/fTKHXu28aW6A
	 r/3EDKo3/qzxpgFyVEnAC1GSjfGBLlmerTjos1hMM0lLFqEkRBpWURJ464Z1HIcFjZ5+y
	 07Vd6Ol1gb17Y0cXC9q9SYfLGl1jTfUPhOf19Ds5pIeMi0VU5MbPKSTul93cEbSA66w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bbx+Yu4t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A25606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A25606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bbx+Yu4t
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso464937a12.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 10:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792605216; cv=none;
        d=google.com; s=arc-20260327;
        b=Oy2DA5SGuvLoSecbQUvdFft2OGwRLv8S1YaUTEkrXhzIBiP9Elt35iLTXq2RBhcwhL
         MDEgKbPhJZUzrb/NHvVOZjnbTlIKrnp+bKA8N8idq0L2OaHTgcGDTBg5Ap4G9NQ8BHWx
         Y0kx1xz53NuCQmyfcX7CcM7jhqxV+sAsEKf+t00yZ8Ck15R3vAgGq9hzK6aAUuLyfSo9
         m4DGT2q/6tFf/VPrQJLm8SPNHW++Y9TAovK0pi040NzS+ZWJUSk25bo/xDdc7hWv0xzT
         73N7i0orGCsPLnud+sfE1HWeqcQUQdSiBr7jOv0h9tRGCH7LO7o3xE+CyE+ZzMMGFAXs
         D+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HRzIKbKLO9ua2/xR6UHeXwPGuH+fej2x2QAgvQV43mY=;
        fh=BY3IHw4vY7eTSZb6EdDQAMFyMCfTA1plVlz3DoMiYCk=;
        b=eRwnmwU9hXmpDZcHIfihzj4JXl8F/BuC/WdbPMRgZLUtInsTBr9KLxGPzFXoFyr0N7
         MfJaUPyxvo4Ob3rsKoERjRDMK5bYGMBObB0zuZ/c6tRnlV2Z3RwiLezAYbp+b55GXCuQ
         EFm5GjasPzuSN+3Ya/MxaCNfyRNWXI1V2vxG+u8F5JoJsgAynaSdUjHi+jbHrmgJjrSi
         VYOAWYI+PWty8afZW0yG8oex6qvKRaYq+0TgtRgoeUzXa1UPUkVB22iW+3/A0e9zFltI
         d+JyYlli7zcVL1jbHQDY7gOiH08EJbtANO1ITM4gFYokUSm0uZpDnGZzQuXz7pTEWjVX
         IX9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605216; x=1793210016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HRzIKbKLO9ua2/xR6UHeXwPGuH+fej2x2QAgvQV43mY=;
        b=bbx+Yu4tyXLlbw4MnlGLTvddW1yf7vyK8FTcqgruyy9PZUNHGwqV6UtNX8F5po3in9
         wLR6thuruF+xn5xbrbi4KJtXndc46ra1yeI2RRCvABOrzb1qbuj0V2eyRLPapvaEg9HW
         8/4Pw3rVD/HRGHLXrjgBoc6MXDKiqBzBCeDchiNen2q5Z2aGwfzoPtdYW9fAoa3RuMq9
         AVm3AA8ZB80Jixd7Yxbzl6uqA9QARcfd64L/0KppQEZMbjIV1LTBqwoTo79Q8o2wgurA
         HDJTKkOcWyCXcB+0jd3gnzpn/iu5m4sX+gw+rLwcnUFYB+yyh+O7uZ3wfplsV9eKat6+
         ceaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605216; x=1793210016;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRzIKbKLO9ua2/xR6UHeXwPGuH+fej2x2QAgvQV43mY=;
        b=pzdRQPPpN6W5FOeYQGRFmOOv+disceeZSq7MGQ8b6zWHQ4RKZLmbiL7tD3K43VrUa2
         u+GRz1V3aMPmwJecImfPS17Y9zzF3fqw+1RMVbvHSJesNjqkgiUSLWlwo0szslKGNsyn
         TFwcXr8z8kWdyG7AoCFopG8cIUTDyMgRIeDfsvxMZcurd+QuVVFAhjw6HjqoCQGBK1vC
         XvozROV5ZCvF0BPrkawhMPcRGW/H1edXdyzZwntNeRWqLIShhfspGiKT/SInFeZgZB3p
         MyhRyOSB+MfvR8hyU69f5M7s3HvKTJjyQg7N+6Tja4hNHvicHF7MdQtj0KkgeUZ0usdQ
         HTfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrCY8/jT+sCRlss8uu5mp+Lj56SrrQVqMmE/iGQ1NBR8/x5E0o6LDUI+UBGwNqmYMxSe4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1s1OJFhiiCQE70SfzfTcPjugPqJW1+l5VSpL90LmlAgo2BLh4
	ddWEQAX8FvHEPPYo4oO+zRZns92l5CPDBDQK9WJSh1aTPc/I6GZpZLoJQljkeTu8GzKNEI14cM3
	uv7xkFKIgQrq55JXDWPxTuMTsFyP4ZHQ1vQ==
X-Gm-Gg: AYBFou1gsf/XMtpu5+Bb+vGzCdT7yY7y4F6cHpcSvSlTKNZ9mhyIXyHKnyTjDwJDrKp
	IobjafpaHwgP+pGuQIhhaP+xS8rNF5cLUTXMc7nkE+Sh57PsYwfrrT2E903XUK0IX6a0FsXt5tl
	0b4D1pQK+O9wezp8lyf8JQUDQ2NlZj1JTVilkz0FGQhr+z+PpmcRA2xY9ySYNgWf3geNXTDRxxA
	5H4fe0vr67Wm+suXG20gPst6UJX/LXTlzovcZIIYMFB44kpfMFP5i2rbR5wqJPnjFdw41pkFTn3
	SXn37HGCdB5BPKuWr78Yq0yudpff0d1NhRzYe4v8vij0ACPYinnG72FrYx/iAmpa38XfXPpftuS
	1LXWkeipZIQuDVgu9L/egzBGEepSidwGx7pjEYCaSNDbyM11JLHRQ5houshA6brMaPfUeLqnRuH
	7X5joHh/u0NIXVN5vQovVXO/8LNhyQpKofk60TO3xgMZwzaSGb3JA=
X-Received: by 2002:a05:6a20:7486:b0:3dd:85aa:4524 with SMTP id
 adf61e73a8af0-3e287dc99abmr2330743637.31.1792605216458; Wed, 21 Oct 2026
 10:53:36 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152455.71524-1-leon.hwang@linux.dev> <DMAO0T9BL4YQ.2B3YU3ON26N6L@gmail.com>
In-Reply-To: <DMAO0T9BL4YQ.2B3YU3ON26N6L@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Oct 2026 10:53:24 -0700
X-Gm-Features: AclHuK8_cFMGa7PixGohqfLm4WTItvsVIneWtEgSW9zyjr0DgVTz99PynKBUK2Y
Message-ID: <CAADnVQJLcDW5HyZO0GEYY0yWtERkULZxYEQs8hEzG19_WogGvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Pass extack to bpf_xdp_link_attach
To: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 9:43=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
>
> CI is right. This looks odd,
> but instead of CI's suggestion:
>         case BPF_PROG_TYPE_XDP: {
>                 struct netlink_ext_ack extack =3D {};
>
> do something like below:
>
> sock_map, netkit and nf links will probably need the same when you
> get to them. They can take &extack too.

We don't have time to do this back and forth.
So I dropped the series from bpf-next.
Pls repost the whole set.
