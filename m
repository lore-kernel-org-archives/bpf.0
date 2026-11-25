Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795612494;
	b=BcyEoSx7fIvI+KFJFhEu3hMyMXN0UsontRb6QVzlFCufjlQJIu1VcEqbFrozNt7WtYm/
	 z50PYESooGcmPaozC8ccj4dOJTAEAlEjhF/hKFFqSDBy6fEcZRNI90M/zFuGlw32A+Bdg
	 cja4qtIT5/Rs5unWP2Wa5AoJC8qHJI6ROQW2vFZ1SO9Hq+wBOsfyiAtDW8UMa71dQy0iy
	 sAmfqJCmZgW4zkQxzF1HDxk2k06iYWYtq25RvG3FZxKOUcihKLK3bGxSoyWEBa51cm/lo
	 vpxSVwFD7wzYfdkBcvqnWW4xynJu3GUeAW30EHPWj/cKLm4jsTbdFqP78z43BI1rOOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rsD2t4wySwOX9483/VTT5W33RUNkdKR2nnX67XsIXPY=;
	b=wW1j6ttWGmVEQvJQtayawtaRU0iwSRAhEEbk+D3dWWx6L9yrj0bKsTB7V+luft+ylCwn
	 7hDHSYhwACAlPaFb5iBGW50iUomXKQN8JbfUlhdn3dDOhtLvWWLRWasQeXqtvqZEMqvCH
	 9JRVXaKJiPmE8+4mFJ9rSaqd3zmyrYrJgZ2h+IQPUsnyGiszyoubZMy1m7QKhEgr4LzQo
	 kQU9oS0ZsdG6WjOuAewxGj4Ohk9ljKeUzwZTD/k/LSMDeUHhJS4troGzwECC5iY5eiwq4
	 xqOZqUEA38KqGKOQL2KGk83sg0G6A7E27uNgmdMZDKW5ZDrSFF/O4BlDy0EKbyvxqoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=SQtVpwNq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C93606A335
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49C93606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=SQtVpwNq
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c516a192844so525952166b.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:14:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795612493; cv=none;
        d=google.com; s=arc-20260327;
        b=Z3z6x9d0fv1YmJJO61IuIPTwfVL41jpOqqRN9m4XBmlbAzKrZ7VMVz3Rxjft8ItedA
         xvgvznVs6LfFotu+RRZnc3q6s8IzZwIhDjRGFbkYK2Crl+BuKz+yXH56wIrnsxYXiJWf
         UHxbiOq0jHC3S4rkHKRW4hx5dwXqdCel9rTHnYH/vm5/L7ZdqOCkY1c6z1KVzqGNEoh5
         zw8FOCBZLbm6wihg8VJcvr0TT3yPo1wwc6DsEYdyH1AiCLR+iAw8U1I1MeK/c91GPx3r
         CT2fkngSWrfIazcXi1R+heWA5ZZflMTA+yNfnZzjd4Mzd8FXE4GbXYPVRUp3zmIdKDl+
         N10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rsD2t4wySwOX9483/VTT5W33RUNkdKR2nnX67XsIXPY=;
        fh=X0JzhkDhvZTzkJ16bWrQCHqzcT61hBI4qsk7lSGSx/I=;
        b=FYFKepYNktuKKaF70SbnTOd23vpuYavbMKm9IR0qCzIBU1JOp0Qv3tEizJIAJcpFDR
         yuKG12zaAnDx6sK6W4byXze5OuXaAmiLUnUMYNv7WM3RHXnsJH70X7TXQn5y29jSUf28
         2s9uAQH7YCdKKW+84d8kgQmaXmYRmZa9g5huig6QfuZ1bq9GHAD/DsitrGeC0aWAblBC
         X2L0lqccsVccC84BfqfE9C122vNA07Bkl1pweKNWmXU1grWE2SyqOMDziJ6VVeSOcmEv
         GK9WClAjWAxs30Qua/VeqHd4Vmek0L18lwzToLbk7NvIgUWQLUMhuGaYnhBHG+Coci5s
         2rnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795612493; x=1796217293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rsD2t4wySwOX9483/VTT5W33RUNkdKR2nnX67XsIXPY=;
        b=SQtVpwNqC59M3VVfa1dfoE/sHfHGz4A9t3U5kjHMDgLzJ/LAFCY5PizY0zTwKdadfJ
         O5ndt6idAZjUViDyFaIvEIf8PjRYdeEJFTenPhqxD4KS9aPKfpOMnuTLEhg3AkAWFtLb
         C5Ymg14tXaFwlcuhdcnd7dGuMWOyoF95OQ0QdQje9wpaUvQsnSy5dKhyiokeJ6ja7Iw9
         +zk02GJZi2Wlz6yoDfQWZ/vdkaQsq5UB2BtV1yJAYqfUJRYjcsv3oW54uKvJOZv2uChN
         f+AE+YTe+od53xhnjSMY71A2eUBacbOYKi4eu6oeZ84A/p08jqOhFnP6cS/QI+9QYTOp
         pzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612493; x=1796217293;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsD2t4wySwOX9483/VTT5W33RUNkdKR2nnX67XsIXPY=;
        b=WWn7xFHW3aLwUf5qApw2EFeqPzGHq3o9F2gh02Q3E9POlWDl+gUCJ8JAUMN0xGcod7
         JTgebrhn+gg3E/hNUewxvPi+GoqYSw3ObJ+xYoRSt1CH1mAAkXWwoexm17bP+EmY49wg
         PdvnD0UiuvM/TemGD5dBYf76hpq8MqGYuFVgtj7BCtJM72JAezSDfB9xQLwCrhPmBcUM
         cDfHhjAzRueKlLUPH4rkzPuF+fE2zVOZZEJ1iiAPnqqjbJ8irtmWGZp/TjBdcf2Syqhq
         VMTWBfjv7uZ57BDicT61mSG7Cu+8jhXWVrMpEGTIqN9RjsduRcMW3iZn9kx9lzJ46FV/
         bWxw==
X-Forwarded-Encrypted: i=1; AL+hErF8lGOyiW8i3J+xva6w5Jp/zNlYFsq8PJxE2SK+yb5qBq1Vs/5IXrtwNis0rAZAyK+pKyY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NQPGf3EIs/MJo+DOhPy9sc3JzIZzhvzNuH0LQX5N286gdplWI
	ZOru4vVlBAE4qxi0pI+pVCIXhvAgsS3+GfWnHjr77sbPPS348ICea0jv5BWUiTbC/DdMQoEZxr6
	GKV0e8E0y68pxDU4Qn4XkPciOFo3dbdN35c6QdiTRDg==
X-Gm-Gg: AZFdTZdEOvPbIllbWrFPCIT0cGfcrWooe7PjYCLiYoTUZNA+yX9T29Z+ZsyXnc5UbIs
	8FURhsC3DdOYaWG7ytWtY0g9e1uU79s193A1xX4sjZrzoIxMlb8rLR32LGWNk5bFZgqicPLgneI
	3w4vRtf0sU8azVBdAPGfE3M0kHKpdSd1QTevR+Wo8GmKiTMw8mCwXSQ28GXsvqvwI1vuUHlmjac
	n5MPv/tPgAZAp5EkFsPTYTrRaQAqC2Kaoyasm8kB/G77GtAVbm2F+kbeJvZ7v7RaMXbF9ttHe/X
	VmgobDaYxEjBSsuD2yY6LG8jY0P4tfV5cp2SrlwBCr46hnCdZFrnA3UbfERFKvlA6jM0fnDUO1y
	a5FrvG5NoME/IwcU5+dP0q7DQPaGJpaVDk/WEBralHrrb0d/SS6G6FVujMpgP/meKj2okZ78=
X-Received: by 2002:a17:907:9306:b0:c3e:e677:5608 with SMTP id
 a640c23a62f3a-c513a5da8d0mr1423705266b.12.1795612492588; Wed, 25 Nov 2026
 05:14:52 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118184729.2302130-1-m-malladi@ti.com> <20261118184729.2302130-3-m-malladi@ti.com>
 <CAAofZF4XYd5z8X56DRARMxbu3t7QX48T7V69MPBw9TW1BQAmKg@mail.gmail.com> <20261125113634.GT31322@horms.kernel.org>
In-Reply-To: <20261125113634.GT31322@horms.kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 25 Nov 2026 14:14:41 +0100
X-Gm-Features: Aa3M54q0E3DE8nTpapJpm6hmEWKXKOUeQTw9rDRWi3Vp2mEG2fUlO9gFRZDhhqk
Message-ID: <CAAofZF7tvsfkjjZY6e8Y7P-ddNnR=XQfLAGysrpq1yp0rRGrjA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: ti: icssg-prueth: Add ethtool RX flow
 classification support
To: Simon Horman <horms@kernel.org>
Cc: Meghana Malladi <m-malladi@ti.com>, kees+treewide@kernel.org, 
	laixiangwu@cmss.chinamobile.com, philippe.schenker@impulsing.ch, 
	haokexin@gmail.com, devnexen@gmail.com, jacob.e.keller@intel.com, 
	sdf@fomichev.me, john.fastabend@gmail.com, hawk@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com, kuba@kernel.org, 
	edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com, 
	Vignesh Raghavendra <vigneshr@ti.com>, danishanwar@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 12:36=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
> [...]
> Thanks Marco,
>
> That may be good general advice.
> But for networking code the explicit approach taken by this patch
> is still preferred.
>
>   Using device-managed and cleanup.h constructs
>
>   Netdev remains skeptical about promises of all =E2=80=9Cauto-cleanup=E2=
=80=9D APIs,
>   including even devm_ helpers, historically. They are not the preferred
>   style of implementation, merely an acceptable one.
>
>   Use of guard() is discouraged within any function longer than 20 lines,
>   scoped_guard() is considered more readable. Using normal lock/unlock is
>   still (weakly) preferred.
>
>   Low level cleanup constructs (such as __free()) can be used when buildi=
ng
>   APIs and helpers, especially scoped iterators. However, direct use of
>   __free() within networking core and drivers is discouraged. Similar
>   guidance applies to declaring variables mid-function.
>
>   Link: https://docs.kernel.org/process/maintainer-netdev.html#using-devi=
ce-managed-and-cleanup-h-constructs

Ah, thanks for making me note that!

--=20

Marco Crivellari

SUSE Labs
