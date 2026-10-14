Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5932051E43E
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984184; cv=pass; b=C1mvPjyGrqIhw0cU+aENeFDd3qTZkZ9vQ4usS6q/g7AqTjDDVae9o/FeEXrovp1sPV0jFQJKOhez7pRUNeWkt6vU+UOVsdDIjJrwkmKWp2msch9bEYUhz8mQQz8LAZwQRSIsPHKh9ggTN4gY3w1gYKhS/nW/KE9IhnONCoYd2PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984184; c=relaxed/simple;
	bh=sx62d86u+TFaCg/f+CExTaHz5XyZuk82UhxVFxnoojA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gtu9jrL7EnRrtCQn6Onk4BoBMR/dF8p8gpwXN6FZkhpK5uXdkF1t9QFqkad8I79bSe/AmQOC+0G1qu3xtlWe61/TihrjlHxnHRARj3pmUDjXQkB3ZrJxhxihZFFOZHKlYCo/GjaOLeoXgydu697XTfpHJgNntIEKEV+HyA5TzqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J61v5yps; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J61v5yps"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso3729259e87.3
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791984176; cv=none;
        d=google.com; s=arc-20260327;
        b=p8Wy3sJbAXcCt/NnmRTQuLSQYX9GWtl+XGCo/4oFIP2uvPnVxS0xPASVhWuSteTcfe
         rHQ7AOVAn+l0tD528WukzbuYSV6m3JG/peesf0j5/IHwjA70fpHH+Uan8GNmRGCMrwyB
         biw1K6Ejh0m2CBh+nZtOHtrr8FSuWV3w9AzDJkee6Yot2mRFTUeCLvbkpVjM6LFUipyg
         Z4ezSsuMlDKPySsde17wjop6MDwgVJlddqbMBLbbN07BN/C0qDfypYZAijYuyk7KolZ8
         q8/P4POV5yg2y25pMk6yZ5QaQpxresnsX1lbnnMhMFH8iUoUN64lof/8SXToIIRncK8b
         NcIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sx62d86u+TFaCg/f+CExTaHz5XyZuk82UhxVFxnoojA=;
        fh=o2zQgqgxU3bw6PBTvXqPr7yOKky5VVoo0V8elWzn1ag=;
        b=cfcBHoBDVIBJY9RrZnl5YKUZyR3UQK9oW8sr8XZV5MCyawEocEzsRzc5Ij1X1rSrTB
         7pPqvUoisSu4PQ961PxIT0Sx1+gBxfXO8uK3aNCI7Aq7dYqiAiVJVdfWVQAVE3IjJMch
         JjoanFBWZfD6CC2tFM17UXhxjKN1dcUJjXnI9TYoBReN9TmnIKbWzQceBZJpsp7Dw2EY
         sAF7TgrvQ2dX90i4ObrSEaCAMB3DaQHOXNmWFoDl+XdJETl4crbxX8aLF+OBHxSj5RDO
         e0hdGFcVKmLDoVYVCI3zKz8e07Jbs21N9qwZ6sCyZcUrOWIRfPLSR4hmToLwbauh41RF
         N9rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791984176; x=1792588976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sx62d86u+TFaCg/f+CExTaHz5XyZuk82UhxVFxnoojA=;
        b=J61v5ypskIS88w0cB4ewIfhQRL90OmfqKQ4h4DvaLaYK8JDgi/I2c3uInGEcgeRxuK
         Ysd+KkoAQbeXeIB5GX6rk7pNQ3+ibVf+jY5zDVRnwnta+FrdZseCAykos19ieLtKmqsZ
         gHTyUhVcMR63qZk97wzBCxftedd4nUNZSQrashIQM44S6dkg8n+F79IQ0VLOZDWK+cWH
         /gb+Fb4I7jwHN1gwRjw28DPuVGBjjt64g8p/riQWr+30iEwhCeInwZZ6Ioc3uaLcY+P3
         Wc4s8QA4GLJ1ogiTNrdRw0vs8Di2kfBqqsp9Lt4fLorh1nCwOtLCOqkp7XeQim3QtYvo
         677g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984176; x=1792588976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sx62d86u+TFaCg/f+CExTaHz5XyZuk82UhxVFxnoojA=;
        b=G+EAseBo7CzvJ939detmfSnQdcEi62zd2K24BLi0AhsQjJcxCtheKZxZdK7xs66sK5
         qItog42ieFbCAUjjby9sv53dqhDeQac1NDS/+M0XE+jQkbbMNX/E5sa9ah6T37Wp2sCy
         WysGai3hHOmelOWcp4/6P+31D9QbCF2X7cECfpHdbu9kE5FYchI/JYgtD6kZnnAsNa/n
         KorTXl+db+NaE2e41K9n0/gXumXsiQ9M2XurJazBFpLp8rWI336wfdwwzzoabKsEJEMU
         q/y7dzFDY6zWegbFWmpPR4rhmegegElfOwF7lodtJ9ekYkxH6ORnAhXFhf/wGd5lI1CI
         7AVA==
X-Forwarded-Encrypted: i=1; AKwUvBzN7O+bCl3/LpbeISeNoyFEyEtRmsBqlEjKA4ewE919XmWFAtaS4nLai51ieBT6lxQMi/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvabLx52Pilpd5epcnj5fdDoHiu7Ehy8evHbZrP2NWMfHCjYfC
	EJl9xekLb/A6rCt3ti54CyEvm5gDsX22rZxxJG8ShoYW4tdPQ2U3bH/fYdwq1dxCnncZpaWa1ws
	DbI8jit/NsTWyclXKDgXToatV+m/M6+0=
X-Gm-Gg: AYBFou1VccsYdLfJkoV/grYPgOxiw6GOgoRrVgF7H68ObplHSNTbK1rooql/WKSQYjH
	lVvBymW7ecxpEtP7klwiynViOnkmGlU86jU3ysWN0UoRXjEvxOFlPX6YpJIQ9Zp9NQeIImAp07T
	QYoFtKRYH3sYVobwbEd8oxgo15YaMg4a8Y/8l6dBBSS8b5KqTL321XgYYbyu9HZvWz3Bx57vypa
	E9vfc+jpfVsHQVqH44rotq0qCjvkMVobFHfl2+kbqdiH3dwRV5xQFoR3MVxA9G113IWusTtdysG
	BqK18X5sRLmQXvAaZVveHEbdnBia4hBhYdA/gvb2mZPZ06XVaW26Isks5snqe4ZOBDgGD5oQzKx
	gVLGL+Q82UpbNUp9Ga9jeyE9uSRwgyk3iSK7GNzn0Qbk/yvklBV0Rsq1LZvwB3NBHqpjfitQ=
X-Received: by 2002:a05:6512:6c8:b0:5b8:edc5:c9f4 with SMTP id
 2adb3069b0e04-5bcde6b4009mr5690761e87.13.1791984176053; Wed, 14 Oct 2026
 06:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013-xsk-suspend-teardown-v3-1-2d6be7602947@gmail.com>
In-Reply-To: <20261013-xsk-suspend-teardown-v3-1-2d6be7602947@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 Oct 2026 21:22:17 +0800
X-Gm-Features: AclHuK_CZ8InuoWyy3gcmsKZkLS2hm7xv53f53O43urLI2AeK5PGKE-WHdvjfa8
Message-ID: <CAL+tcoCsz08UKVci6y0BDsEbfhsEzn_F_C63pwSNh8GwswHA1A@mail.gmail.com>
Subject: Re: [PATCH net v3] xsk: freeze deferred pool teardown without
 blocking unregister
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org, 
	Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 2:38=E2=80=AFAM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> Deferred pool destruction calls ndo_bpf() under RTNL. system_wq is
> not frozen during system sleep, so that callback can run after a
> device has suspended and gated its clocks. Use system_freezable_wq
> so running destruction finishes before device suspend and new work
> waits until process thaw.
>
> Keep assigned pools visible to NETDEV_UNREGISTER independently of
> the socket list. A released socket has already left that list, but
> its final pool put can queue destruction after workqueues freeze.
> A resume-time unregister would then wait for a device reference
> whose release cannot run until the resume completes.
>
> Track assigned pools per netdev with netdev operations locking and detach
> remaining pools after the notifier socket walk, including copy-mode pools=
.
> This also covers leased queues without scanning pools from unrelated
> devices or network namespaces. Remove the entry on assignment failure and
> normal teardown. The deferred worker still owns the pool and later observ=
es
> the cleared device pointer, avoiding a second driver detach or put.
>
> The lifetime problem was identified by code inspection of the deferred
> release and system-sleep paths.
>
> Fixes: 1c1efc2af158 ("xsk: Create and free buffer pool independently from=
 umem")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Admittedly it's a bit hard to review the complex logic. Thanks for the work=
!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
