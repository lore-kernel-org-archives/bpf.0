Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90FC2F7EF1
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571242; cv=pass; b=eCugpE6i7HPrkh8dzLYSsYTuF1UhUltL1KCcCswJ9Z37EATck28h+bHxz77daW2VF6pTLw7gFIiyG0RraWHkuHI38KpzUWnng88WRnLezPr+Iexa7k3MNZRSRgo50y0OaAs+VYcsJWU4juoyHAkkei6kQsv7h010hITl8X5abc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571242; c=relaxed/simple;
	bh=P/Hbu0V5Vc4QgElq6BDPyNbu7w0tz8nmjZRMAFRdhVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+u2wxwnmBz8747dCJYledURqldv8JhQKCYR+VODp34q9NUEIkG5SeLq4ndpTimfyN7z/aDzGMsODQu832AIPBZdWcC+mk1L5u2jir1fRfQPxoM3DwMAZLrQbkA8x4q4EaqtHFxAgX16RLUsxYvn8MFz41kd2TRtZd1oMmiBJSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfEhKl0I; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfEhKl0I"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-852c481415fso1620446b3a.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 18:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788571240; cv=none;
        d=google.com; s=arc-20260327;
        b=HnCxQDXYu8X4200+dVLqEasVN8mumtN/iqo3Xk7PBOFRY8meTj8VpegTgdF18kcTxG
         /GV6XA9CWPidxJ7ZNFQw0UhPyKmxrpDzpp2Dn6+F/xqn/lMXhV8t7QKb5uBhFHYm56CT
         fKcSsdcb5mdh3S7+StymH7lzcHdbZtiNN4ZSpWl5vBfg2Y9zaZX1R/t/rDKgDuUwzKpU
         CZulE5Q4icQlqZ8MwRBPuGyiBnk8d7z8xY2f4jgUjHP2G54QJpkLyb4xYt5xqIO6pNca
         aV0+FChw/QErTnv65KYLDZ5ZNkiBbAoX4NzLmx7pllxgBVWFCiFuUlQct8t4zSjalmd7
         YdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P/Hbu0V5Vc4QgElq6BDPyNbu7w0tz8nmjZRMAFRdhVQ=;
        fh=woVywNWnoTvW+K67bURU3OKk9rzew8cWdAp3XkYggew=;
        b=FhxX/c7VwB7Zjip0tX1I6GhUBqNtRwIezE8yNBIiWPfM8nXJXu0yKlmQe2uvEQ5KIJ
         gnj6FqYQEnMm291BW3yxrTyfh6M6Le0TpnY2ghu4jtBVom7bLZ0neum92cBTa4AgXdVH
         MIRV+mQwGmfC3Fm6sjVVPyvudQ1SvsGsphKv2omH5dpK6ImUxPzL+n6R3/ogXrwEcDqe
         WCFrAxGcXEQfXFvMSF8aKWudJwTtG2YIFudsuggA0584APAg/5d2ygtuXbJdGlc3rNhn
         GGIlk2/i/nD5iH8DhEhJjcmNttJ2jrK/eNbJHquOXgHuAhTWA3RKKayxxsiW2Y3Yo9Sr
         3R5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788571240; x=1789176040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/Hbu0V5Vc4QgElq6BDPyNbu7w0tz8nmjZRMAFRdhVQ=;
        b=gfEhKl0It9NqgR3w8+wejPtXZN9sOx1oMaFRAYr2TmIgv9zIWWQ0zlN8C9Y+ji8YT/
         xqN3aUaYFp0UwVxtWZ9IqWdp9ADMLkdqiR77ZyZnoxvn6OxkCiBHx50KtjSRIeTYpyeh
         gCSOi2IWF50ArN+eYejmr2Y+bbcfauLDFpOptdZndGV6tSCNETtVadfRiDpUNUzYDiP1
         tB11vRwZrrV6B+t0Ks52C8lzxwaN05WvOhTTkdXcTg1UnS1KV0PhTo6lO+QWPLn+fTw4
         G9xJIvPDgs8P1/DwNdoSjS7Pza6QcQRzaYk0ZYdKrJRVsGiNE5XLpJTCT/qxbz0nD9kG
         kx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788571240; x=1789176040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/Hbu0V5Vc4QgElq6BDPyNbu7w0tz8nmjZRMAFRdhVQ=;
        b=gazBz4dSVso7ka8HONNiXoYWqtJ0109q+oYfYtWS3NdXJYgB/njLhXmnnGEt/eycTJ
         pbQ9oVLpiIinsTmTpielte1S40tdSMRE+mncS+fsOQhfsa0K9p6peuc5CXHxGPwgWQpo
         d5GYIBbn6MPVs/ZvKVXh5jET92+Pw5/AHm3XxHGXDkbhKeOXXei3d+iZDdFaGqeVbNm1
         7m75wzBRsbt37firkSAj3y8H6UGdzhAIfs5gweVdX54DIbbj6XVwimH5bUqRcUlrHOO2
         egQ1mxOMFkd8hXbMBmuETdIYTdpR+bY17l0akcWDwbuoZkVSnHIm7DWMxBIXeJQ7EVWe
         FSLg==
X-Forwarded-Encrypted: i=1; AKwUvBys3Esux3kTvYHFXV6eQII9KLz79WvN0avw7UW08ZtSu1BmGpwlLtkIDo7JM5NTUOFpnbE=@vger.kernel.org
X-Gm-Message-State: AFuF++nlTiyBRsWcFlIHvttjPwWgm+AZm+HNNni7zKj/Rxt8SmwXpoZ7
	YQ/LgLUq4yaI38ZANLLq0ys9t5AQUZF2TCiNVKrm6vgr0tCygMyLxcEBQ4lD6+48yf0AYPkHfG4
	Wsz5yx8qbrB4rkNuUw75PpxpaM/vyr4c=
X-Gm-Gg: AYBFou3wE8qtmxrOVOoxiESkZvc+52uqe0PqqtrWcEyhQ4uyVEVbqLIufRKKEYvSFQC
	dAAJj/EQBy67bk5wjiJbhViOuXr4TewDS06+1v3R9x6Gqs83tb2COxFwvYbgiXBnt1RJ+Ish8Fx
	sQDKgX5HAvBOSgAZU0J+RyN8oG/nVgL0/l7bJIvfsLC35vlUvEj5MT9gYcoWxp3sOxCFMtpew4Y
	U6rEg8lLMiMH4xrMbfMZkU016rjkSiq/+EF+bhCjX5cvh1+5goU3A8MBeV4NvNP2Cbz8XBrn1rP
	+lhwKzaJ7rrcBcll4OLPBs3T7fDUxp5dfl10YXaFjLs2Itr7z15wdy61KEenLZkFxqKq9es71Zl
	ay4I+FOZiQ9qW9Tz5UuiGrynJKzyg
X-Received: by 2002:a05:6a20:9f92:b0:3d0:ba81:79b1 with SMTP id
 adf61e73a8af0-3da3980a0f4mr14688710637.0.1788571240105; Fri, 04 Sep 2026
 18:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-sockmap-lookup-tcp-leak-v3-0-b998b3d49d07@rbox.co>
 <CAAVpQUC==6KEBs3XgFjZ536mJ23cbHma8HuiWMu1DRc_=YYOHg@mail.gmail.com>
 <20260902155216.4fa23444@kernel.org> <CAAVpQUAWjBuF1Rgze0Vt_XvkUT=Ajw-F+Kh+s2iHk38c8iAapg@mail.gmail.com>
 <CAAVpQUATOCCc0N1jnfy2+tkD_zj1su-a-4+bV6qXOSzR7y_iQQ@mail.gmail.com>
In-Reply-To: <CAAVpQUATOCCc0N1jnfy2+tkD_zj1su-a-4+bV6qXOSzR7y_iQQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Sep 2026 18:20:28 -0700
X-Gm-Features: AcwNN1UINzK3524FpZxXYWs5I9-HPFyb-jm4MKb0Vr_8_U4tRNTF9_M_llHPnxY
Message-ID: <CAADnVQKi0yji3iEepgwy6c9cXWhzJqGJ9-gg-7NXJc5Jj+bVeA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: Fix socket leaks around connect(AF_UNSPEC)+listen()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Michal Luczaj <mhal@rbox.co>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 4:06=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Wed, Sep 2, 2026 at 4:04=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Wed, Sep 2, 2026 at 3:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Wed, 2 Sep 2026 11:58:49 -0700 Kuniyuki Iwashima wrote:
> > > > > Several BPF socket helpers acquire a socket reference only when
> > > > > sk_is_refcounted() =3D=3D true, and release it, independently, by
> > > > > re-evaluating sk_is_refcounted() again at the time the release ru=
ns. TCP
> > > > > connect(AF_UNSPEC)+listen() sets SOCK_RCU_FREE on an established =
socket.
> > > >
> > > > Due to several bug reports, we are now inclined to forbid the
> > > > buggy transformation.
> > > > https://lore.kernel.org/netdev/CANn89i+px52TtJy3S9=3DuHxGj3s-WueguR=
o1Z_4FxO=3D02KLmwmQ@mail.gmail.com/
> > >
> > > Kuniyuki, would you be willing to send a patch to do that?
> > > Not sure if anyone else is planning to, I wasn't..
> >
> > Sure, I'll post one like this with s/synchronize_rcu()/-EINVAL/g
> > https://lore.kernel.org/netdev/20260804015349.2353056-1-kuniyu@google.c=
om/
>
> and cover IPV6_ADDRFORM.

sounds like the fixes in this patch set won't be needed,
so I tossed them out of patchwork.
