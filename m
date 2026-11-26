Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795678877;
	b=ocXst6L8Ac5L3T4m14Ujcv8PSQZLtyZ8BTlv3cw6cxUj3/bidWo9hgCTeGPcVK8y6sZ8
	 7hfIGgh49v/bHjxBbzVgM7iczLTdtr1gu8JAEHwXGrtDUypmJAnq48crXUsXpj5UwYuxj
	 hXG+w4ivAxhU+4V10qthYX8u6dO8ZcyTzhN2cQVpffopIC4PlEhPaVOIoA48OyD4ekK0+
	 BqZTLgUUuRB5OwaJ2bDALRwoyYRmyuQJHSrzquL3i6rluNk4lNYLmjwnQZpcJyKRWTmEx
	 oO+TzbwDrVeIq0uwqYaDR7nI+PTysrlUzbO5flW6Ke3MGd5MQwCdBljQcPAHfbqidXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=q+Ubm2QAGWkkevqcn++H+wXuVangaT2LjNLkyOWvZa4=;
	b=zBGLW3eaqHslsZTFyXcEaHTHcpMuLzkik3/JzweBZm42yAeM/S7tBSiryJrjlziUVnoB
	 rpdIGikJgkQWH+ZZjFavqPbmrb/602v4evE+rFfbDr5N6v75JjQrRyi8ZDpk2GHxGcRU/
	 N2pVp5tatu93MDGwgf27HuNRWyc8q9ylG3IjKibXlYL/XwOKw13BbypdxkxhPGhCp26ke
	 stjzpaj4UoH5Ne1ryorgs6gTDVptdII39w+wkbWf88VRdRvEXFBxlXXPt+webA8QWD5bt
	 fhCdC3e6cw5lJqBATyOFnethq96GluKOu/atUQqZZrNZ6rIhfdCdYvTzYzsifLT3ICQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vjYWWtOT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A732606A33C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 07:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A732606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vjYWWtOT
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c1f548f87so89680536d6.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 23:41:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795678876; cv=none;
        d=google.com; s=arc-20260327;
        b=Z57D72skVSVuxCr/hzyyHjYo2orzIFydrzKeXQd6OyrqoRccBl6IoiVlAvh8LKLJnG
         u30nCMcRZ60eFfCYEiw2FSpsqA94X02oELhA9xXaECsTrwQp9nJkcYnNuTe5AEJX3FhZ
         VdyoIqHEdG/NsMMR/2mCe3p7jpHUQr9nxMSoY/THcLDtaICA0SStdkQmGvBkL2+m9Dsz
         bfUyu5UT9ugraDsME9fi9piN+BO16azDwdp29jLTa0rMII8c4StSFFxrFGbMnNxwdW2P
         jV03IttDYZ/TOrflpoL7LV4pBeZgh3talU5Eaqv8DCMa693Vfs26pft6ftY2mPoMFjot
         yMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q+Ubm2QAGWkkevqcn++H+wXuVangaT2LjNLkyOWvZa4=;
        fh=ujgYXoZ0rIAk3TQ450btFpNiCoet7nGnnviBYannNxs=;
        b=YkxaaZx1NDsavRCaw8gVgNA9FifK30O25VggRy8OzkGEo8DB+VDMxpy7RZ0YpnXERv
         Yo9/Tnkf7owPGIWMBX6R3q7SiCmCLITjz6zv7zdyUfD1Ep++06eva2LW1S0zNhQlH7SY
         k/5T1PxDKNkYmrhR/6AaHTV+sSIcdWprxGFbgtTNCqMJudzMt0AL5sw5IEStGThCH6Gu
         UJAZhyOWVXuKnJTuSfAjoENqK+YJzYFyMcxRkKpFHAd2LhR8yoKNe8OaZUJ4PLtmMTVI
         H18f1unlkiG6XHwLYLPSoK2cfgDnwj6WuYFJa5L+cJDgPLKG1Rh/74ANGFFE7RTm9IGf
         KGAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795678876; x=1796283676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q+Ubm2QAGWkkevqcn++H+wXuVangaT2LjNLkyOWvZa4=;
        b=vjYWWtOTVjxpRitCs1Ov3QfzRRQ2tY06zy3Y4ik8hHED3h0mwrmhU4UHOeuxdpnybT
         7K0KCZprMY+v7Kf3EnwopbyboNiElX037NRr3V/r8mrSPbt0dydicTRGKCNM/YvakosY
         DeFt3u1m6GAKDxGX0FP7t0dj/wi37BL+9UGm/YJ+/WM03m2s6XB3JpF6UXxiVEOgR5+P
         cTgi43oizecs1Yim1tbYfiQipIDE1BH6qm26/gMv3m/BnArrLv5J+9iKty2YWpjH93QA
         QI3RxCRnkIkW7Ab/zCVx5SJlLYJ5y19biI3QXqmrVdCqPbG9V7gxMUJTtvgwFum0snZ9
         peCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795678876; x=1796283676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+Ubm2QAGWkkevqcn++H+wXuVangaT2LjNLkyOWvZa4=;
        b=asgzfWxqSjeuiNk14M7KwfoMcewOumpxT//O/7Qw5TI6HB+cjjr2ZwBImSJWqORNKK
         J7S3wBdb7OknMM/vIsBauGgKdEcV8a4CzJxldjsY/KOe7KoRSRXa1XxSRAsgJC19EQ7h
         b/n0GYJww9PvFTGWCdqB2XzumZw32jk4++rHwvpdyueVG0AWdBd8yNX40tPY4dqfkWgw
         yAmFRnT3j6LbOsRjTETdvMVP5QySqXImlRsVc9KGKZ9LN1IsdH+OHKi76WkMjxhCxzEx
         sgZEF029mDMxMjZGD/SjL2emFND4YuQ0MCXSFW/vuFSIFqz9U9IH05oiIdzV5omBbZI/
         skBQ==
X-Forwarded-Encrypted: i=1; AL+hErHagCujAfA4iIsaKGOlKgenPuT6AjtB74cE4uu1V8PLas3a4uyDTMH34o+sKF1WilVDid0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qNiDDXnaS6RiAyIZXRC/l0uL37900+V10vGp6pbKk/yo5Zbhm
	skXWBaG9Xg9ricuBkaVZ98kT8wPPHDdZiSAyLtZpIJnrWtRGPVuhC9V+flFNrSdSqQl+e2YQ3Wp
	RCNmN5N4axjewrZBE8NGLdDVvCXsuNaLSDnGsSixeMA==
X-Gm-Gg: AZFdTZe422nNy3s2HDAmYQ9mSXRLAVEorqu/MOjvx+6O6zqE2EZKGpJf0HhsTck0Ria
	DBVpb9jm+fBKCcRT94jXgJDF9McZzzQId++kG5/flmWdmIDvGSAnk4c/dyf67/4daxELCXL38YJ
	E7+IGxFxQoSk3oXZ2F/127qZjRj2eIP6iGQdVzfo1l4bFkluMWqNLPVJsWG9yOGcA7pniGZQVPK
	zh0R2IhFGKbTt1wO7SQuAwvFcexfUHKjd8QTzW6incrRaWGe1thpTc/j0Sww13dGg4fzIBiXqme
	EAnwpoh7M1dMvPs+Sk3kcIacpxGrJ0gIL0vftCaoIrm3rdIixKTtrFea6SUPdDhFPVBzeQ4MwvM
	WxTJHVetvUswGYahWnj1cnBJhstg38guJgg7VQryK6txq8QEdSbEejCY7T4vzVDPZkomQMSXAFC
	60YvCdA1u9cmOrO4cBiw==
X-Received: by 2002:a05:6214:8616:b0:91f:2374:d001 with SMTP id
 6a1803df08f44-92134aef4e6mr379882716d6.25.1795678876352; Wed, 25 Nov 2026
 23:41:16 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAMcAce97zgo7c2f5Th9FguAHEL5gL87NrJ9MJkJghMm6M44g6Q@mail.gmail.com>
 <2026112651-peso-sandy-64a1@gregkh>
In-Reply-To: <2026112651-peso-sandy-64a1@gregkh>
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 26 Nov 2026 02:41:05 -0500
X-Gm-Features: Aa3M54oG0R2UVhL1kMFuTme6_Ok82BveIP2T0l92n5M8-7IZtdNkPstPzAyhzvA
Message-ID: <CAMcAce-_hShop0MH1Q4p6Y0uf=ApmLoxuKQ9Kjms_4s-Gv1epw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y v2] bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, kpsingh@kernel.org, 
	sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the mistyped full SHA-1 in this earlier v2 email.
The valid upstream commit is 49b18315be4eecfc36b75f4aecb4d40a87d68a20
("bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature"), which was
corrected in v3 and already queued as [PATCH 6.12 015/816]. Please
ignore this old v2 thread.

Thanks,
Yingke

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=8826=E6=
=97=A5=E5=91=A8=E5=9B=9B 02:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 19, 2026 at 11:55:07AM -0500, Yingke Xiao wrote:
> > [ Upstream commit 49b18315be4e590fae0fc39c87d46c87e9ec903c ]
>
> Not a valid upstream git id :(
