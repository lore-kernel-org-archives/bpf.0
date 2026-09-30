Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F180480965
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808875; cv=pass; b=ZVIicDJH8ggoWINIq5NcXzh7UmBXb7AfneONbdHjEw9odXMfLVQyta4dpfXVZzLD3ap6b/My5N2xiUVfcMFLl9JivbPuFpBeNUwjbz3Zbik3i1iUlmlSeTPmk+XhdqyfrNkczpwZPi7AfrzRE1LUjLPrXTlpjrRn2E0crT9P59s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808875; c=relaxed/simple;
	bh=25OW8kJVzXxMj1f7wl7vPyZB0Mh372NuIRML4c+wriE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSrrgrfMFyGT0AY7duWffZrLCNsx7ZTVj1pACSSQ2EDdbdy3v7PhLgRN+fyDHuyPhazH1jgmo1LposgosKXmADObV1g6yJL2Pc2FxXj+dcJEnDRhdDYMkDO/zJwv+jsrQlTRDtJADBUM8x4PJeXsFBHlH6dD5LKploRFXECTueE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zy6xGcMl; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zy6xGcMl"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6aeeccb7d59so112695a12.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 15:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790808862; cv=none;
        d=google.com; s=arc-20260327;
        b=QgLCbt4V4tIh+Y3VzVO9EeVoGKY0Q4FWkzz/Ix5wuk3sRv9GkKZX3NSdMwbzoae2PP
         OeK8+flh0xgYZJhO+bvm23aTdY2jMKX/otqpbWzou0oEfbakGBYYECuGIDXnmXEmpBLR
         HgwIuyHSf1iuOLcr4kDMZJmRRCAr7PT7W7mmSHfQEXGT0UBWx23TpOZnJuHbYbGTRxgt
         fkGGZ0L5EFzLMIHL6fL7EMjPC0XUJvCBjiAg7NNRUoQpGeTJ5sa4zNlaT+IA/5uY6O58
         zJ3PDqEHSphs9AvS+26R80mkVDWpXPLH29h68dKQOZDNP+JzxFiNSITckMn/fXunIz2r
         PogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BMDqFIaP1O55HQyhPMTHQHywZWJn4sXJBK7hF4BIEBo=;
        fh=HPdfSmrxlispavD4OWQDFHQ1dh4cWg1iRzAVbGrXgk0=;
        b=PzpjhR7rHaD07UcHbqrQIwkfF/GTgtD+UH765voNAuiGTuyh7ZU41OJWFcqOQdHHCs
         DwQ7v+Yq7DUexin1yBtNr8ZhsfKLB61yidZAMKshNUt+796L83AoEkqq96UFC1850FAs
         QSUO3HBKvTk8prK83gD5hM1i4CHj3WgwTGEvjEPkA4I/DvitC4AqUQlt5lbmBheU5LwF
         r2GF8MhXeuzCBOUm+uCivYYMhieocrFG28iuJvd2wLP2EGB4wMgB/O7sSbLqTtz8Gd5o
         Uagyl61xrVid+slqF7eSPyrYmq1TV/dEGsAwFQWj+QKwhg+pyACKtBCSoIvNECDzAZ1X
         5GJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790808862; x=1791413662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BMDqFIaP1O55HQyhPMTHQHywZWJn4sXJBK7hF4BIEBo=;
        b=Zy6xGcMlXVBd+eFtXChF9aS7xQKph7IQFCB6hlxE/Gn77dVpltkC5j+60MPQi1YqRh
         FrxcrOg6LDIi3yNq7tNq57mP4Hl0L5J+F8OBEmbEqRaxPT1wpI3r9lYTWP/rzPCeFYtZ
         WqFkvsxL9Ouvjy55QvXZuzZVCS4YT6g8dwlVYE86YsmVsqjA02AXaRq/hyzAsa+/qLQH
         JgCjG/XANB8/gBpMjftnf9B6EYVYV0M3xdeaKSjQQmIKHmbrNZpjaU6mlNwgTBnZzEQF
         hGGnSovGmdHLgREBDFVpenSDsMozh1hleZCO5/f3gq2XUT9EMCJ8mrkLnrGmD0j2iBgR
         KwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790808862; x=1791413662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMDqFIaP1O55HQyhPMTHQHywZWJn4sXJBK7hF4BIEBo=;
        b=P6mmVfTOzyfnraO8HzrVUzFPYFVqpdq4gnV6dL5Pk3j3PAljiT7OyU/me7mKVpjOHj
         V+2cx2Vza8T/U8GehjJTk0+wid+zweH+fctVz/kdMF36yQKQYwqNXTRf7MhD/S8U6aEw
         lMx0TNeZkKNFVteG87/g7WrzqOKCyqzyPci7BCmAJGJTVI/PZc42xDZfwQzFDDcejIYd
         55uDz/wGmUCDv1Jnfl/Hve+5RaJOL0YDeAhTEJKZLSOuKqtLpAwwMhmdocdnmcFPFahg
         yDXsF/wbuijoMjvkqbHogZ3tSO7qvWtu3gH1lFvsavvvCva3LUKxpOxf+0nPbiPqwT8q
         L0WA==
X-Forwarded-Encrypted: i=1; AKwUvBz1zRWET6WuWFkisgplMH6ocp5TJ54vu2SbT8efwztFRYZxBz0UmAjk7/eBOpmHDND3jK0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIL8buCxCtZAue4RDxgKG07VNReQ6EiqqvdD+9h+2yhyNzLes4f
	eeVRNiPobk8/LPOmfTnjyF+t+8VyPbLrZF+4xyw06mJu2eV4dMXHJWzec9UabOp77RVJYR/seHn
	2u5d3E4Kspv5mAbpRR89vXVUNe4/Av8g+a457Yr96
X-Gm-Gg: AYBFou2S9YKTGPCkqpH85eeJVANsQvCB3iDw/C3cCtYiDeepNjghtj5qCjQz/e1cHAU
	aByuJHK7Lp4dzy3jV1wmLzY3Thg0eNUgTmzd/jnBPZlNXdSA5Tm+PVz2WEuQ/2juBqvtN3k0Wtf
	6M1NH+isomWuottbVcFpN1gnkwD4WJJFgldzwPfC5bt94S0PjAyf1efNRUBVZGUyX69138ZFaOI
	L1qNXIEjbCnjszINp0C5PNoFiMUVYB+8E2IUDJFExVUjr9Fxz7AJYXyp4tJnRzvNw93FNOV6WJE
	seU2DvEI8SaH8x8LhWO8vYcBh9i9bj7TkcZxV0tutiiA8B/yEbOb6yxq7jrdBplbjQaA/M8FU7I
	ryOvCBl3WGa/s4Gk9w5aH
X-Received: by 2002:a17:907:9449:b0:c27:420b:7c79 with SMTP id
 a640c23a62f3a-c2e23e520f1mr221873866b.48.1790808861871; Wed, 30 Sep 2026
 15:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930214735.3288780-1-joshwash@google.com> <179080528731.31693.11268580346361726174@kernel.org>
In-Reply-To: <179080528731.31693.11268580346361726174@kernel.org>
From: Joshua Washington <joshwash@google.com>
Date: Wed, 30 Sep 2026 15:54:10 -0700
X-Gm-Features: AclHuK9fnFHxOP4qsQ_Oocv5ijMmdZLzMw5uNrAYSg6n06sJyJ3ZPqhXptnZoq4
Message-ID: <CALuQH+VEopCYRwDmxyaLadDtMy29m5=Li9YowmjWpZha_SEMjw@mail.gmail.com>
Subject: Re: [PATCH net v3 0/3] gve: various XDP fixes
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:54=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

(1/3) gve: fix XSK buffer leak when rings are stopped

This issue was hit in production.

(2/3) gve: fix XSK buffer leak on error descriptor

This issue was caught by LLM

(3/3)  gve: fix napi_disable deadlock when attempting to disable XSK pools

This issue was found in production.


>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

(1/3) gve: fix XSK buffer leak when rings are stopped

This issue was actually triggered; symptoms included a buffer leak.
Reproduced by continually performing ip link up/down on an interface
while XSK traffic was flowing. Eventually, no more packets can pass
because all of the XSK buffers from the UMEM pool have been leaked.

(2/3) gve: fix XSK buffer leak on error descriptor

This issue is theoretical, as RX error packets are extremely rare in
my personal experience. But it is plain to see by static analysis that
the buffer will be leaked if an RX error is returned, due to the early
return in the driver. All other XSK-releated paths free the XSK buffer
in gve_rx_xsk_dqo().

(3/3)  gve: fix napi_disable deadlock when attempting to disable XSK pools

This one can be very easily reproduced by enabling an AF_XDP zero-copy
socket, and disabling it. The deadlock becomes more apparent when
attempting to enable a second AF_XDP zero-copy socket, as that
operation will stall waiting to get the netdev instance lock.

Snipped stacktrace from
https://github.com/GoogleCloudPlatform/compute-virtual-ethernet-linux/pull/=
96:

Workqueue: events xp_release_deferred
napi_disable+0x1d/0x50
gve_xsk_pool_disable+0xed/0x1d0 [gve]
gve_xdp+0x14a/0x1c0 [gve]
xp_disable_drv_zc+0x89/0xe0
xp_clear_dev+0x59/0xf0
xp_release_deferred+0x20/0x90

>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

All of these changes were tested on the GVE driver using the DQO RDA
queue format.

>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.



--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3
