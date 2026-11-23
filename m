Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795475979;
	b=lXMI/jO1/jOol4A/k9CIP5FpnPI7Ky+Tqm9u76E7MTBO9INp4nQ2Oy4PRlv6ARq7deMh
	 yPtszxEz0pI5T1L+y+58CtRNcez65NWVGW1Zyp8QbMuF+m8FHjTYTbZ+ubuxsolr0UXcF
	 JVj/UwpUlFz5+2Q5x7viXE5cROsxwSrkbZ48wp9FhQZAE5t5YonGYu0SXF9yWTwXF73cX
	 drlrNd+xaV+vZ9+P4ebNWUmt7M8n3Vc/4HRZZ/yQuuO5hA8UMxUuaW1zIp5MBFTlza+iT
	 +vkB0pOKj9/BazW5EyPPX0Pf2qWlL9BfglPUY+2P2ni6QaljWIXrxLcuq0LyFDP9Xqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PoobtMyoDnc+gxXLqB2HvjfkYgUQiC23/ftHCG2Qu/k=;
	b=XlNX/u3jwg1ksRBck2V8TyaT6CtM5mlTxUF4VHJQQ8gW26BwSOOHVAp1ck5O9l6pUFgq
	 caR5sQtmpbSfSVgy7+qPtXseC02uPw7gmRjFQ4+6CuEjXjIGK9tERYiOfpOg2sGlOO6QF
	 oPnxTKBSRJsbTXmx0K77TJd+/FFGcZ8P5f2Gjs4lkp8KCPxUxz6b9ugT8jMMJHIaVhYGE
	 h3Yfcll8qPbIo6uW2Cb96ccHZu17f3u75m7Kl3ZvfFSmCviz9lCX6f+sSvSFIs8uy/h5V
	 gSeO2kaUOWy0oHqST0iUGNee5bJbEfGNfpN+8bf9twEgvnB1W3Dftzp43G/bNDRs14Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b="RH0V0w/Y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0B606A334
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 23:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A0B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=RH0V0w/Y
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f02b9c1f6fso25891985ad.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795475979; cv=none;
        d=google.com; s=arc-20260327;
        b=bRaP4MzeXrTdQMmqlVS+ZbpvmXEiHomaJztldS+QYecbqug/AiqC7z/QDBocg/c2Ci
         AVb9nZSI1ByKGJN9ITzc7x/xoXNoBKTw6drAVOkMKXSh/tDTKh1+3Rji2kvI+jrbY4YW
         bU0zpLJ809wOr1hRXr+QFsp7s7f7wg3/WoqTjYYbLdd/CO33OvfYPEofhHpeW5COjkC0
         1knr1uNdnovCgWQ6UMgRrdEkYFZzo5nlj9Ll3vEipf3ZQE2D31IjVspmc2NV7b4frBtF
         V/3WZUjju56nxlUbNMo6cYXEYU6vHIGtL91ohY09kKaNqKESloprmsxekJlv0qBA9wwP
         KAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PoobtMyoDnc+gxXLqB2HvjfkYgUQiC23/ftHCG2Qu/k=;
        fh=QYCl2pRKwfrQ00CoGDMwrPAysveUzHeE0XpELQRI5RM=;
        b=BTTkgmEVbVVwyeobEWynREcLyS5QbNVqBHR3z8UW2pTgBfGR4C2KFXuF9q37H9Bonb
         NzuFpqF9toBY4Md9heaQiunSBzm2DjG64yAJs5QgP5+dvzS7mNHL1YITr7OiHkw3zZiy
         R8x50I4OMrPeqwPlM5/ooB2mNG1KACa4NjTbX/T44ZApnoqhtDZPoPgHdNYgJKPxyHfu
         OiH+3JY3c4vZH2iZahrNWC0mipbWXxI4gTw3wfNoifFmpD01rRQvRQqpk9cyPTW6JNkN
         HKzHc2riUxFDOFB3cU3olMAFiMnPylqCmskDkRZBc0FIeg36aa9AMbNmuw6wo/vXR1LM
         65uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795475979; x=1796080779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PoobtMyoDnc+gxXLqB2HvjfkYgUQiC23/ftHCG2Qu/k=;
        b=RH0V0w/Yr/Z4AMRG2tN8F5gjksBm5yKNRTXUsuF/1NCZKbxj6Px+gUwAwti0vvEIpt
         ze3b0AYAjegli3ajVz8reHPYaQTczy5D/5H8TnUyeIVMRhXGJnsSb2RnhkLCYbicZhtS
         ZETTU1BDFAWMBEqZg2gXH/dKYu5ciTgugb+pbPvjad24YoECg7uC1XTQp+k2Mtqfn/u4
         yQUYcoahFdNOsiB3bh3TXDCfyjppcwNpsbv48RHxu13sF+IUnNZLd7/GZ4I98ylOdH7Q
         mlftfwPpLhqmf1SaXDEf4Z+0c98TbjBQ/xj4UXn4EhbvPUieaPwitbh/1GX9QXJhge1z
         U98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475979; x=1796080779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PoobtMyoDnc+gxXLqB2HvjfkYgUQiC23/ftHCG2Qu/k=;
        b=mvzg+In7+jnRfQbanf/wXE54tP5PWnfo9eTWJ/qiWsqztvwq3QNapfuvf735tPdKn8
         8vFpyga64m85UeC/6qrYQ/9Uwi4uytjCUj4WoH8FEsVbIJz8W9GqhnV0XXoSiQ2OCgIn
         KGtMXn8wuDr7ktnooYfKHJNeNrU7qKWDgJWNSes4kwilxHwUr5B+XvDQNEWBc7vey95v
         5PfvmAWe1eo/znHYtfz+ee5XEG5c+XDJ/PcbtcOP3YYkWT3YsAHNgGCQ4rHR/NtDX8Bw
         Xa1/kOC5rL5zjnRv2UayLpmj25QEvmtmJjED8fy4iLajruMQ/gziD5/GraqXJAjPD+tP
         JCJQ==
X-Forwarded-Encrypted: i=1; AL+hErHJRKN4/Ov6K+8MCrMKUp8W66VZlBIT9PQoflEV1jdtw0xZVAse/MTDThBzCJgWerzv0mU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+miN6shwNhyMy92g1GqofprPxstII9EObeCkl3DNjQTOen7Wle
	hy4AAFvsJNSnsp+SbUfzUscHL8/c/uCpJ2rRt9gzDcqengzXq0wxLynXiHirjPjKFSq9H9rsgzg
	kYkaP+pYf0YihagSNYDp1KXPyfJuUU5fcnGnYPwsl
X-Gm-Gg: AZFdTZcQFFlPmRnoRyFN5feClCN7URc159IFfW+PyTOzQHNiDp7ePSxdf6lKAMI2Ume
	niwnUWFCoZk4xE5vXWhl2Iy02m2DMqy5OxONKelJHKpDYNJpfxr9J/USNtwufb71XBZIWN5h8xY
	NWIxsC3rZJTpAzjVaVW3XW9YfS0Prwrz7G8TUvkgSfstzKudjsXG4ldG0DC+jxJGEK1JuF7mV7a
	9F1BCJSPwE8GjWuu1EeNQ3rftaCJK/SnDBkJL/xbtY7O6l3WPDlg7sOOI6FCVSxgjDirh9kUYtJ
	eDW/4vz5wRb+Px9YiKcqOGjkKQeiFblNv7+stBnr3vwRs26XI1GB9fr4ZVoJZIZ3sVgEEnHbvdv
	KQwX89vOIx343w95ebYFo3IAnRsMvvzfr37GqbRJGgaseJtJHiJ2a9HGeIdIdkkqfSI4StLI18P
	fYCBB+1gzcTdG/fw==
X-Received: by 2002:a17:902:e5c5:b0:2e9:528c:b9ea with SMTP id
 d9443c01a7336-2f03f18ed69mr94092915ad.11.1795475978663; Mon, 23 Nov 2026
 15:19:38 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-6-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-6-65591dbba7b3@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Nov 2026 18:19:27 -0500
X-Gm-Features: Aa3M54p84nMzXEsFfUh5-yY_9m2RQyZXUhbb-xh5PHe7PIY590iycN_cOXWciDA
Message-ID: <CAHC9VhTXzxXECV6fwt0BaJC8jF9EBzmzoon4f7fWaJotv1PyRQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] lsm: fix the security_namespace_init() kernel-doc
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:41=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> The kernel-doc claims that the owning user namespace is available via
> ns->ops->owner(ns). But security_namespace_init() is called from
> __ns_common_init() before the namespace has been set up. Apart from
> network namespaces the owning user namespace isn't set at that point so
> ->owner() returns NULL. And for init_net with CONFIG_NET_NS=3Dn ns->ops
> itself is NULL.
>
> What a namespace_init hook can rely on is the namespace type and, now
> that it is allocated before the hook is called, the namespace id. So
> document that instead.
>
> No functional changes.
>
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  security/security.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

The way this patchset is structured this probably should be folded
into patch 4/7 as it doesn't make sense by itself.

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
