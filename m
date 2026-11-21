Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795260930;
	b=Kj68Hr9wDK1KqYFg0cIUR43U5w9sIH0HgxPIrdDt8pVbZXgV8MmG8D9yPwkfs9D87lRv
	 Brc3ljLlBm6BDdQaWQlMU3oDMUhsdTXKFeeS4w4BJNu5MKkn/o+HOxNBU7Im+qGfyjCVY
	 H0AvpsULOx6ui9144s+oUXw6hpXXKNKSGdAV+79RE6xGSYbyFF5vZoAMnlAPt+2Y0qWqY
	 LnMzKtWIBLLzuKRNVFpBWOiubG6hU+FVQzFwbnGthxeqa5f+LdpE/ZC67TQnFXjcZtdlD
	 WM0Au2dOYwOceE3lOS1YILXaqLBBk5Cezzm3hUJx0kfeP79B6rAxjBS/VyC8q95y9qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PFg+qpMqWg6ZdZREgqR6rxXhJfQ64SZVwcKwbvaP2cs=;
	b=mngVTZiyMuP0auLn7FX+SakGLtdgUDZeYIvcm9BN9KptDTY6f5vR6ghIqGda9komQbQf
	 Oi3pSuBcJWQc3qHizvzG0Ip8h4Tr4pIQwdDnXfAxlRf6CVvPHOxP5J6ZVuKFuFy7F5uki
	 MUv0avIf6HHE8dPzXDvRfvzWpkDrh9Pm06T11fx+CKuuBhkNdxBFbqLGqP+txRxfANh0A
	 C7Nm/n4AgiNMZDbb7lEd7DUYpN4IKVg9l/+HU5vGh9FATRL99JLHJU3RKuohDqS5pxEzn
	 ERtn3jDUcydiIXUO5JrFc1C2GPlTR2qnzcInOqCQRlO0Dlquf1bkhX3W397hTypK04g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=iIHzRdBI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD2606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29BD2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=iIHzRdBI
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b2382bf051so967483b3a.3
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 03:35:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795260929; cv=none;
        d=google.com; s=arc-20260327;
        b=gZbJLQ+DB67gfkMp0HuiwfZv0Y28tYf1pBTCdOoNX9ZK0zyl7+qycKgjaDVd2pcmrx
         b2yAqToXh/L9q8eNydVBug7dAip1/WBR0rV6XrkHhya89uvFdUborKJLnfPzlw6kz0+L
         0c/rmka50Jn66pEiVzZTSOlHuetcuRcykdlWEB1nKCXXGKQQxN7ops1SVABlurQlqJ8B
         ePmYzNlVnWEKyQjqw2fy9Aygnjzxf10D5WoWvfmNTjREpvqWOUNQS4Kez86VGe4IhP6Y
         bRvdibl/o004e0cNWzLvwgPPjtyMV9lfXcJziJQUop+kYHq3+VxuWou3DzLNCsA+YrKq
         Sx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PFg+qpMqWg6ZdZREgqR6rxXhJfQ64SZVwcKwbvaP2cs=;
        fh=N+/qtyKP+N1JLi9sL/KuSVXf2xVdBn6w12V9L52gxXU=;
        b=f04/dKdlsxbsWBSvwy5sOkdtPaYZOx/Dc3vipaUhb5Z51fkutjWTXXjuy7+r9E20Mv
         XdQM8rQ1H9M5bB+s3JUfxIEh/tTsGsiD4ejQfUxheLm42vaYswMYP6bhJtuldCe6gQqB
         7HNGKYKhLUpAfulJrwOYpLupoQ+Q7MWeqY9oqEcTo9v3bK9SKbEOEXNsO+dl95aU0qY3
         q0y/PEz9Hyu2JW68wsGzBCMaLTS5U0o/lClRoVWaU40TemgZ5cNl0OlPDEXE/6+h/RtH
         ZYugfzltF6r4/KcNCEo90Gamx+jgZxANJrMPftN6qGM4T/+j3pfl3wJGZpw/z4/SFhJd
         /n1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795260929; x=1795865729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PFg+qpMqWg6ZdZREgqR6rxXhJfQ64SZVwcKwbvaP2cs=;
        b=iIHzRdBIHTm9ReknsaiSijgujHBL8nI64ecVfCA/UvNAEHg0DVbqs3+HInuUOT7eg+
         JhefxyzWrEIZbeYJG1ZThQFYhdsZ6Yq2ZYaNdLaZFslSJNCHhJFcNL2tbaDPhIVhuGJk
         DaL4usxMpeCn1XEZeRE53VF1ZrQtTaWPRM/N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795260929; x=1795865729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PFg+qpMqWg6ZdZREgqR6rxXhJfQ64SZVwcKwbvaP2cs=;
        b=tn2CK/7VSNJYdM1sVhrlF/taFOsXXhpnxXfjgDiwWlNCbTS65vH2Z1SlfhtTfqxvE/
         O7F0n+jE3Efgt0BTkYiEfvYx/D9pvI3cqOOdVoVM51CwyJzfOX2Upx0w9m+OnT2o87HI
         zYCVI8J8/Om6oY5Hm1EvPGAx7Yzv9iVxqP05fgiCmJ+aYll3n3e/IgrDV3Cm6i/UXs+B
         VKs5MMCbQkdFdsekDbViPxUWzjJCKibUQy/rkPmUmvz+KgfD/9lOPn+2SmSzRrmCOAMU
         eFAP/iIKqgU3JFmF3jB0U9IsyUwnM1MwSHllGcttVQaD+BAaE4cJnJLFen0IS6CdNUEK
         1McA==
X-Forwarded-Encrypted: i=1; AL+hErGNlfbG3ansx17ukxM4e5wIzo/IVRdVJYhpuSGG9imDC5MwXwUEFWVlEEkf1cLtOAwJWps=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lDMxQKcQvU9EBEW9alOXcsJBpu4eMmvIHkqM7yq2O2UyjYf72
	OoZd0wHRZ6tEab0uSow6w2CB99NVPB5l8HPOD00NFkECV3UItKEi/+YaS0+l3pSmq79WXf7ZnDY
	fmhvodFIpCR5RgKn6MRtvquIDjAwmptTv37243QYm
X-Gm-Gg: AZFdTZeQAtzIm5d4HbkVSLjIXSG7aV++tRjbDg+mNMvn3YwHR9+ePCUnh/3m7N8N0Pk
	Y+AzN7yyEkdbwYTJsO2bvgIMVyjVkQoJPSyUOwLcaCNFCJylzfvhc7cruRQe7GwtKq92hkOIpn8
	5aU8kMG+VtJfA1cYd1CaE0hfzsnesa/7Xb+emfATBZTUISWviB09fSe4573v8zKivsA1S6omG8u
	HU9PrNmroCxo7ig1Z7/XRD4HpNEhUkDgS6Gwexa7CgR6GcvK547pV91kGuFKT31tqIzoCy5trQS
	IjvWkyzLeMIjTJUVrl/3G0+3fsJlwX/5EdBFsooEm3Qj03RtyetYpS8HMOzr4dLUNFfUqKP+eGq
	926D5zJvC+cFdY844aqBdgi7s5TafYFTn28xhoCq3T/YNDiwMPq44cjlCqwUAqdW50OXKUVX2qx
	EfQdd0uM5cFOIDcv5oJZKr
X-Received: by 2002:a05:6a20:748f:b0:3e2:1218:3ea8 with SMTP id
 adf61e73a8af0-4014b564283mr6992874637.14.1795260929405; Sat, 21 Nov 2026
 03:35:29 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-J9UK.v1.r0.20261120103344@mojatatu.com> <CORE-J9UK.v1.r0.20261120103344-1@mojatatu.com>
 <DN09UU4NHKLV.29WR92GGDPBP5@gmail.com>
In-Reply-To: <DN09UU4NHKLV.29WR92GGDPBP5@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 21 Nov 2026 06:35:18 -0500
X-Gm-Features: Aa3M54pLSmB9e1t62DD22qXWW6Wd6hUo92Znhze0v7AddURdYqDarYPQPAr6_T0
Message-ID: <CAM0EoMmYSkXjvpw_rGi_4Y49jnHXV0FSuc112zs4MSm2SgPxFA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] net: neighbour: skip the stale dst lookup
 for a redirected skb
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:06=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 20, 2026 at 07:42 AM Jamal Hadi Salim <jhs@mojatatu.com> wrot=
e:
> > Skip the lookup when skb->dev is already neigh->dev; the parking neighb=
our
> > is the top-level one in that case and can reinject the packet itself. A
> > dst that is a route via another device, which is the sch_teql shape, st=
ill
> > takes the lookup.
>
> It doesn't. The check never reads dst->dev:
>
>         if (dst && skb->dev !=3D neigh->dev &&
>
> In the repro dst->dev is va, skb->dev and neigh->dev are vb.
> The lookup is skipped. teql takes it, because skb->dev is the master.
>
> That ends with 3/3 of your teql series:
> https://lore.kernel.org/bpf/QDISC-6HS9.v6.r0.20261119070330@mojatatu.com/
> Then 2/3 of it and the lookup itself can go. It can be a follow up.

IIUC, that is the plan i.e a followup (not a respin of the series). To
be precise:

- v6 is on the list as 1/3, 2/3, 3/3. 2/3 has to stay in it: without
the restore, 3/3 parks the skb naming the slave and the drain sends it
out the slave through neigh_direct_output() with no link header.
- 3/3 carries Cc: stable, and stable trees will never have this guard,
so 2/3 has to travel with it there.

Once your guard and 3/3 are both in the tree I will send the follow-up:
drop 2/3's three lines and the dst/n2 re-lookup, and back the "dead
branch" claim with a runtime check (kprobe should be sufficient)

Thanks for the ack.

cheers,
jamal

> Acked-by: Alexei Starovoitov <ast@kernel.org>
