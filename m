Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7E55931A
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880386; cv=pass; b=FZthKCaaBpiLOd+VZpVlANrPG4XOakBadxDwqhktv22jaAee1BaU/zD7lgOS83mmnBk0q6JbCMytCQhXhe3EdowlPi1EHWIRYzSWN1WYY8hT4Zp1WlD+XtRclxZsx+7CvMX+IjLU7W7TaQ3UkV7FfI9Nxw5WXtwcXdOCV0woQXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880386; c=relaxed/simple;
	bh=h4V3qmSg9Cl3SBicqioBkg1pZFXj8Z00HAErU9xLdic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5MbRItP3YVj5nhO7/m24A0gikRZobZgPg7LwXwEPuFHgjMZw8XBG5yJmDxE6wzdDCBGZrqhjVVAqrPJXEBwVtPYzluweuXT43EfYCbogPy2zYsYSlFAuGoqczCqbHdyHHBpK+K/1j6/xFyKeJWcKKcDSXO/WBvA8BQzjZ+Qw6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8hA5CSV; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8hA5CSV"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so266515ad.1
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 08:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788880372; cv=none;
        d=google.com; s=arc-20260327;
        b=J0qXpP9Z7GhHNAmiWRoNtj28PoT50zri2DKlJuZLwd4UEtxqROU4CD54UYd4OSaava
         GB5d7O6OUGN6jdhKOxQoD0pPXbjIIfzy4gY1+Wp11nxr0qje0nvT0TPq0MFgC2il1hRa
         kptARw7bFhzhPyjNhMYJvUtI6yChAzmiX6Zvsa5fx8eEACMbaPHdQWEihIvehytZ8BrV
         07BVYqBsjflLRxJLTK0kBPHwc/CPofOK3KtEBXDruSUh5ZE+rGozucpiqfzuqQ6Kfvwp
         kRMDqfjVWZ7iOFX4QpW7sr5XjSVLjioB71ZOxY89Vx9dd0NOvKfqPa2ra2WXw1F1SO4+
         qxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BouDQyseTpgBscOBCF3a6wtMXmz3CzisSn6GhPbdwBA=;
        fh=cM/HaxhP1SbywpnQ2M3Q7934D6jwc44Vh97tXU2qnio=;
        b=Q0XgeGg7KybNjw0WDc9U/dmItuV4wHo83UQGh+AIwcBU85dAMEt2Pok7T5I8+q0fch
         k70Lz077Orq35qkkS+npaYSsFHC1xHNyxadcr3WpTiNTzrIbtL76a1xFyZo0oapxiY9j
         x8RQuUg5inFzGnGYgJXeh6/VYNoRGhwPz3Dx9tqr7py9hMLWOt3z84ApMZtop0Xkgnlv
         vSOJ6LA0mqqc9EnpzvhdYuDy1Ivn1/+wpIWM/dqoDM24lugX5i+1p6eGaDdn6Z2VmlYD
         D9N+Fs5x2YdZSSjY9Y7jnKhSSO8GR2cornyQPAyjtjAtszxgMtn5B/bx9D6QpxNOkVzP
         MG6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788880372; x=1789485172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BouDQyseTpgBscOBCF3a6wtMXmz3CzisSn6GhPbdwBA=;
        b=C8hA5CSVxM/Z74ufDl36ekUeNsEHH0WhC055seX39waYfrIjxLVZ4VhECPL9nMmD/K
         wLdIm0FQyh/deMhjU8aIUom//KEOY82WrXpdUbM7PBWESChmWZNeTyh8FOIkFGCQRHnH
         V+QjdSgJVP6wZaBVd28laxSh8PhhsWvJvsV1HHj6qpe87nj4gtmmTAyZr3inkbnv59dk
         wOlegio/ZYU86wJwwQ+16BwGPyXrbgX2sA2hLTvUfeuEIsqb2ZeILbC/KkOzbkRi7UCN
         9IPPJlDqQt0j4OnW4uSgA5mN04rCsNt5IhBF0P9BZnrGSF/ksjVmbDiLioj2EAV5ji1F
         g6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788880372; x=1789485172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BouDQyseTpgBscOBCF3a6wtMXmz3CzisSn6GhPbdwBA=;
        b=IUmkC4heKVx5UFkOT+cn6rfgoarGF+HfweK7R++7pgD58ILhYCAsqaAOWjZ72jJCcJ
         U5PokPC4JwfNaGWHy2zmlCIZL/IsE/PRZ7YvqJU3U/UmxfakShah7glWv7GV7xgXTlGM
         u0qC0mdUtTSbDYO/8/qshZu41/6fEgsj8RwuvzFCoE5B4VE5raoA/PgkSXFidJCBeCXI
         xtQdg+G9ycWsaDYGWdP8yApFrcIgzmk2DRn9upbnKl56kKkvmogm1HikeO6RgyVwbb13
         duc85BdCrVtdUzszmMZWYpk+gUZICQz9lwxdAGpEbG3kxpQtXMYOO7amd/BKi/BKuaNI
         TG8Q==
X-Forwarded-Encrypted: i=1; AKwUvByfEIIVPhM22qtfy0wWROMcA0ibu5VwPHwMkBqXIn96PsX16l3+KGwZgUwTgcUHW9OzpFA=@vger.kernel.org
X-Gm-Message-State: AFuF++lpN9qyp49UwSHc3Mm6xj/EDLNqUT7igS70E12Xmg+fHCb9QLLm
	FK5N1iJiVVA0QjF2XE3gzm3UJmSfBfda72IxQtikI3qCfzpV7MD2mCtWCdIIHrJshWneoRz+YPE
	Z47PeSxMMm2x1j94div879xxgHhE1c164H551wsXQ
X-Gm-Gg: AYBFou1x+d0WXW0R7ALYijR8dxu/qFEpY28HH5ppSwaL3oDEGWSkl/1vazlw0qwN4mo
	goDHorYC8iKPDpfNo8w3pnvRJBKdJuxmNvmEr2gR5G9BOfpda8PzGAdcNHwWI4sZqugAgY8muHc
	EMl3ZWku7aIk6AQnaqlMcgMT2+btg8gx9Yjyw6/z35IRcvvk2cm9g+RrqoNSplIbFFYpUhd2vUI
	YMiYN/jKR8rxS2+cUMDz0DV/0Ev6/P3Co6LHKDLLT4JaCs67zNwbCGRoa7G//1KXfZUfopdO8jj
	RQna2Jm8xkF1zdQsM6yY1hlFq7E/6ikl7pI9hUWckWGDx0oTUNDa7LG7RnLdCmBCHjZmnSfvjtR
	E9646X6hvgCZnbg==
X-Received: by 2002:a17:902:c102:b0:2ca:4bb4:4bd with SMTP id
 d9443c01a7336-2db294d1416mr11909045ad.5.1788880371498; Tue, 08 Sep 2026
 08:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903215606.31633-1-hramamurthy@google.com> <923eefe9-141a-47b7-94c5-c91df94e66f6@redhat.com>
In-Reply-To: <923eefe9-141a-47b7-94c5-c91df94e66f6@redhat.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 8 Sep 2026 08:12:40 -0700
X-Gm-Features: AcwNN1W-djDon6i2Oxz6RcG_IKMBsvPvG6L-ePIXfRp75VFE_wdPCqR4Vyc6SXM
Message-ID: <CAEAWyHdvav2Yd1qjt9Z+O0f5OAN3OKd1y9OPV=VuASLXYbUdpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/12] gve: AdminQ mode related refactors
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, jordanrhee@google.com, willemb@google.com, nktgrg@google.com, 
	maolson@google.com, thostet@google.com, jacob.e.keller@intel.com, 
	debarghyak@google.com, kees@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 3:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 9/3/26 11:55 PM, Harshitha Ramamurthy wrote:
> > This series is preparing the driver for the addition of a new control
> > plane mode(MailboxQ) by commonizing and reusing as much code as possibl=
e.
> > MailboxQ is a new control plane infrastructure which uses mailbox queue=
s.
> > This is a new control plane to communicate with the device when the dri=
ver
> > is running on bare-metal instances as well as newer versions of the dev=
ice.
> >
> > This series contains 2 main changes to the gve driver's existing contro=
l
> > plane(AdminQ):
> > 1) refactor some initialization/teardown path methods to make it work f=
or
> >    both control planes.
> > 2) add gve_ctrl_ops structure to the driver for various control plane
> >    operations
> >
> > The refactors are mainly around the init, reset and recover paths so th=
at
> > functionalities could be moved into the control ops like 'set_num_queue=
s',
> > 'set_num_ntfy_blks' etc.
> >
> > This patch series only sets the control ops for AdminQ mode. This is
> > intended as a preparation for adding MailboxQ mode in upcoming series
> > which will add the new control plane infrastructure and then introduce
> > the corresponding control ops for MailboxQ mode.
> >
> > The entire list of future patches can be found here for reference:
> > https://github.com/hramamurthy12/linux/commits/gve-mailbox-queues/
> Imho the 'medium' severity issues raised by clashiko on patches 1 should
> be addressed in this same series.
>

Will fix in v6.

> Please note that you are supposed to act on sashiko reviews, see commit
> c82ff94592fb68f529afe63ca7f5ddb7dae4ba83. Lacking such feedback, I'll
> tend to err on the safe side - i.e. requesting a new revision.

Acknowledged.

Thanks,
Harshitha

>
> /P
>
