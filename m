Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482959;
	b=AM5ob4fzLhf1xGdZHuraBNirKD8Wj5DRuXIT4XKdnsBeaBfAOVPgi7i3dTNJSdfUr+e0
	 1VetWWKvgpB1ITTQy8gDR0J6KAyB8FDGovzFr7XbAgHk28gaCf075YrGuO8/6sp2Bkkhh
	 8kEO6lRzBl5wFufjdEdWyyZ8V+TXmdyvuQPZG7Iac6/4Lm+zcXPpdbsqxfJEdZDPutTS0
	 8RnSzD+wh8RB8Oh1MCOIb+yRYEhsrh0ex8HjCGUtmADCMkhdELnSTqAhmG4D8pX6uE4t0
	 oyjkXxHbfnFung/gh9Kbpmc/Aawgpo0lVtK32kc0aeQyQucqSolxC6UrS4+1XiSKQlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C6hzf2s6hKShPf7oAcRuMB0755YohpVsSX/WLyG5XrU=;
	b=xEMaAq4c8LfLsaGZytxudmQl+gf0xxNjNw99w8i6gkFeNuX9VIVon1BVTXlMDjcHoE+H
	 lYOtp2C6wxrnrcKhIpfqPw5RlXUeqj6Q47IFiulvdfKW+ukMjqiBNEO8EXAVdP+NYva+B
	 dRdeEiwNktxp4+6qXO6iFe9TD4P3d5WPbWwRZw609BXe/ueplm4mL1dq1auSXu9sgIOwy
	 juqbJeWvRgB5V4Uj7PbVGh+D7jaHEol1k7hRSSG4DtO1gpDGIte3gSXJ/uDBcNTi+C/k2
	 qi504qK48W4Vxv22Vv1i0rno3XuxoUa+zwxfAlAN1XJyMIcXdTqeDc3s1fFkZHA6z5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NzfeTj7P;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F51606A326
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 01:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56F51606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NzfeTj7P
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9210f2622ccso48501466d6.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 17:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795482958; x=1796087758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C6hzf2s6hKShPf7oAcRuMB0755YohpVsSX/WLyG5XrU=;
        b=NzfeTj7Pj5s2+Md8UTM6BYvGoT1rx5OWIoiyb/ayCzfqk+1jTTgngERRL32/PWRykd
         J6FbS185f/6H/TH5yEkoW2ub9IFSiqeoWBVGdrn77H1z6Z+41uuBGle0uiEER1ROD3ak
         y+0pzrLyn70PwKY4GUeR7joNEiUx53tzEVSz1cGx6q0syMwc2ylmXMY2FZiHHZ7fVJN5
         hiqTjYpQ2IYIL99JhsrIgLj0bekrQkeeGweeh54CtsBdq7WiPVKgg23oBkWaGjD+JLoI
         e8E1yGBJhpIGoPWPMMfJzCZsx/lMoQGDEktqdJK8UlwcEnQ0g8F/qBU2lQnX3Pm1xI39
         g5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795482958; x=1796087758;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6hzf2s6hKShPf7oAcRuMB0755YohpVsSX/WLyG5XrU=;
        b=Gg9dFfC0lJVGXPJvP9CkDOlFmjbSY2lBJiLFnIJgmofk+fE3QdOU8rgPDXUb21dOkz
         owGbl75yctbVh9Peg/GlHapV8NrCFM0uZ+Ouiw/ZKyd5yFf9i6B+dBW3UJRSxgshvaW8
         vjLvTbd2/8JFh+NyXkgZE7BKd37D2rDlqydB16mVyL0YNKyko8+vgYJVb19G3bl4H6cl
         jNG09XWIBMxKrs2N24Npg+eU7qYenlrXo/l+TYvGIQbKG2gPUJY2eT2ZVPIjGFTQ7PeU
         Ldha7302SUI5F9wSCejEKxWUCEDZmWI7Z6G4hb+t959VhEeMKCEOIlCu4UKfp0Cc8yng
         eFEA==
X-Forwarded-Encrypted: i=1; AL+hErE3J9JcwgzM3SHzpVfFr2t4d5KlzKQkqFzLF754CjHrl43KJ65Tane6PW9b1ePZM68vjnI=@vger.kernel.org
X-Gm-Message-State: APuU4Z++m/nhGxTPKEyDaUV8RAZxnf2AGe9kJy3je6RrLuZKmGNkFHeG
	7UATgPUmFHD/XGGy0X/yER0LB3heJb9uAzY8D8A5iI5bmsj4Ttt5/nfO
X-Gm-Gg: AZFdTZd+yRXkFLMKIlGpCqQ3yrjtpstW5Req7OcvYPAd6Z8uTqq/eyfmO+zXGKrurus
	2i7a3Z3FRdbplo1JZvf5ojRK+p2phPJ5pXSwEc57SD+mcK8c5I51WRW+uneQ0+dI2bzHcAeRNIK
	dd0gEECzXJpvlCi8BSSrQVtcxUWPoAgIfgi7UTlhtDONf6qAtPhB2CkeN0LoQIkBi45NGdngcfZ
	ZzO/RF1scXtMfeMLbWzVVph6DPN/jTy9Xb2kfYgNFW7KaZw9Lb2+Nb9447u/BMRtfXkBj1dqtjc
	KiLpoHtmAjeUljeAWGJkIQ6s1+i8nwSRGs5sBhH1fy51AI73Ak/YB/3wkMmV8tpbSAnERjQTCff
	GJOzcqqtDIv+C+p9IlGZ+GHLBcOvDVIiiZtCkarj6ovk5tUzN5+bmCoMwSbGA9xB2OJezTs2FGf
	WP7td6BbSX9NHrjbkMq0eNXG2LqiwnRO2BR0OkW74TufZe6SRTPpLOzbFA+f22V3E1RuwXKPO/s
	ua0C08KoT/phfQ/kfmqNseAXo1rNV12Th15vxROaD8YdpTN3wHHYWbrrhsWTIXxvTfYoGqB7Kk+
	1EYCGAYlzkKmGAeA3eZ/iIJx/eBUOuqisIsafg+6F0a1JniF8gzPnHaWZ6a3KtPUQRF0/JHx2uk
	1ThKMNKJauAbnHQcfOU53SPdeiEYj5lLUkR3pJVYhtiCSkBSXB2LB0y65C4xKNIw=
X-Received: by 2002:a05:6214:8504:20b0:921:2245:73c2 with SMTP id 6a1803df08f44-92134abe315mr179048286d6.20.1795482958278;
        Mon, 23 Nov 2026 17:15:58 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349ee175sm123288296d6.26.2026.11.23.17.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:15:57 -0800 (PST)
Date: Mon, 23 Nov 2026 20:15:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>, 
 netdev-bot+sashiko@kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 maheshb@google.com, 
 peterpenkov96@gmail.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.19db5ff627b4e@gmail.com>
In-Reply-To: <c663141e-78bf-41cf-81d0-fdda6fcbca74@mandelbit.com>
References: <20261119153056.353156-1-antonio@mandelbit.com>
 <179530424233.3135.6226986969775563090@kernel.org>
 <c663141e-78bf-41cf-81d0-fdda6fcbca74@mandelbit.com>
Subject: Re: [PATCH net v7] tun: bound the NAPI receive queue
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli wrote:
> =

> =

> On 22/11/2026 00:37, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> > =

> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
> > =

> > If you believe none of the issues are legitimate, please reply to eac=
h
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patc=
hwork
> > know by including "pw-bot: cr" as a separate line at the end of your =
reply
> > (one such reply per series is enough).
> > =

> > - [High] Bounding the IFF_NAPI queue by packet count only
> >    (net_hotdata.max_backlog skbs per tun_file, ignoring size) does no=
t=E2=80=A6
> =

> =

> Right, and the commit message says so under "Still open": this bounds
> each queue the way enqueue_to_backlog() bounds the per-CPU backlog, but=

> not the memory a user can queue. Closing that needs the queued skbs
> charged to the writer's memcg, which touches more allocation sites (one=

> in vhost-net) and every tun user, so it will be a separate change.
> =

> =

> > - [Medium] The patch silently changes behaviour for IFF_NAPI users wh=
o
> >    set a finite send buffer with TUNSETSNDBUF, and the commit message=
=E2=80=A6
> > =

> =

> True for a send buffer larger than about netdev_max_backlog packets:
> there the queue limit now drops before the writer would block on socket=

> memory. With a smaller send buffer the writer still blocks first. A ful=
l
> queue dropping instead of pushing back is also what netif_rx() does for=

> a full backlog, regardless of the send buffer, and blocking on the NAPI=

> queue would need a wait/wake mechanism tun does not have.
> I'd rather
> keep the fix minimal; netdev_max_backlog tunes the limit and be done =

> with it.
> =

> =

> Given the above, I am not going to respin.

Agreed.
