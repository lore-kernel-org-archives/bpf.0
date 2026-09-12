Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C0B26982C
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789199708; cv=pass; b=Pt54bP5PAa/dRL5VF3cq4+OW0izyKEcmd7ubdE6ZNgndP/WDqJPglURMToBoxbnotZPKPqG066LTW/+swgsnC7z0Adbu1XKCUR5WTmE7vP8wqCunfjX32Q9nvDZVx1b8Upc7WoBU6cu25TO2TJca2WPTWpbBDnaitEFLCYQRE0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789199708; c=relaxed/simple;
	bh=qraFBZqrQdal8zEw2/KrvvRvWjYsoA2R+hTRku00T3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfNxY6RbMDNE6fz6UH8aVq916gwYlxpOyZYZOFE1r68t2mayFN+HjXu/s3qJkV+CKj3+yq5WHtxr/eXkeyNvSsSbHfALAQNkt93ia1fMqaZs/6FVLruPyFuvODgQJWuKWFY8WO+2Z/8THA0sxbnNXCrTKg5CRkk9a9+wP9YV1AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQAiVzHw; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQAiVzHw"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a47f740839so2208611fa.2
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 00:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789199705; cv=none;
        d=google.com; s=arc-20260327;
        b=AyXFPFdNWebX7bdOPgimjR7n4zcFcSW0TCljnt7m1btKPqbFaFucfDVhj6WGiOsuGL
         augzNjjlD9NBI9Gmk5iWFNJl0dzY6ZN+VSN9+QFDrMNeVU11DUnrAYdUedyApSAOLYrq
         sMsly5fM1gBUynnk0K/MZD81Q3rxZUgMEmJeo0AH1PXC0DmDndsrdZNsXhoug0iczjVG
         C9merIMreAlhXkcsv2E7D7HtoUNmdOe/TdCi3tfy8T+YXYptrPYLIb8BF3F1zjyY9IK1
         mSnY1tH+mfaUCbByytoqIV0W/fd88R1Qzosb2/yVCsexvRu4MHUo5T/V+UF7G/yRfETY
         MZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qraFBZqrQdal8zEw2/KrvvRvWjYsoA2R+hTRku00T3I=;
        fh=v0jGyHTVhkOwGV4CM6mpCs2m7NlF7DQjBzY5I86JrEA=;
        b=aRXtXxRTHxP9g4ddgOoRJFCfsR+MEyv+m0nBDJOzAmzMeXN0XtwQCgf1VNaWaYEavX
         CS7k65wGZuIkygFXK2SvUHxOYzaVs+BxzUAG10pSOS6lnE6R4QwZ5GxQ8/6RYplaX8VC
         7i0JxvTS3ayisQCOv9KxhDr0ZIa8Okf0aJMfdXDAceiVCxIBoFaSNcT3gU148oPH3ik6
         eRGd+56yaUzi5b9iNJSApcd4qwnAPn4PqHipT3g2Q71aK3YpO0mqeEL4FyoySovUEW1r
         3yEAvU9+M4T7sNgN/x+Yuk+iQePSzvh9Fjfb87zgcdwyW2IJncZNCUqKYQ3CrTLTTT0E
         s+6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789199705; x=1789804505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qraFBZqrQdal8zEw2/KrvvRvWjYsoA2R+hTRku00T3I=;
        b=IQAiVzHwoD3Ol+I1nVI7tZ4umYincIqc6wa7YUTmnm25ln3GKUe9hdxYSqm8165f8v
         7gRTIReUghJbbt/oAfwTHjIJnXDoCexr4qEpfkVDHRgpVICLN5SYoqIh9NVgp72nrY0w
         zCqJR0mC91be5aGuz6noC5ihgFZV+lYiX+H6NuJqXzUfOHfTJovqaau0W4Hv3vYxrqbd
         iDuDC2Q9M0nQvhEfI+Ysq/hm0LHJZ43SqaZP/LrDQp1iXdc1ZTCwc/Jjhmhly8mwmJLT
         2x4DjB89ZTp8TmjzjmykXkacsBi6HukjOwmLZJsge9SmhuXXW/pWMudgZ3+DmXEkSbfX
         GxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789199705; x=1789804505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qraFBZqrQdal8zEw2/KrvvRvWjYsoA2R+hTRku00T3I=;
        b=NLmgacJmKZdvtppDKbtgE6xRr+X2j3tVhnqtcvBrt47gZ7PDQq5e3b9yAyZSRNi42B
         dtnjsDSjtqrSNvanOUmIUy13sH/D35xADdT4ivMkwtgG9/c+yu4v1FrpJUT21P4VXl4k
         MBeGXleQUfO7z4Mlz7blZ4p86YDOUqA1qxzjkgnciWsncTM7//ORgbq+IlvxaS00Ky/4
         OimG8jZySzQA87oSDSDifl1UFoEagW66fvSn8URiRvVg5jKK9A5aiH48vqLCyWy1XirZ
         mpkAeW4onAfh/95EagJFJSy7REemrFXa5NYsTNt3Pi2VScR02O218LnDFDaheewcX0Sf
         lGZg==
X-Forwarded-Encrypted: i=1; AKwUvByjdHdiDuCX8ogUOZsaffUl2gzyYx3EayGjUXIFSMmHCj1xdNRkswc7zJt1jCx0OLb7JXw=@vger.kernel.org
X-Gm-Message-State: AFuF++nPUsFRFWhnWRrEvV6pS8IupCRQSwfW2r5Lf6adY9oqFhdvusaf
	+7Mo1SPRLhycfJtJpmSkJ4zvmlsURNdEWv6SQ8GY6bp/CJBIiC61dMwpFdo4x8WDkwR45j/+FrN
	lOnrJnabQUdu1XvdkSWJTIvdk7KORgQ4=
X-Gm-Gg: AYBFou1XtTjG/hFBeS5poOwE1OeYZzJ1GzN950IhqHTUPQCNeHXWKNPnF08VQHdLAjd
	MINALe3kQ9ZK+blZtnFfFEkB9zEzYniXYg6OKXiDWV7U8LFuSaAXbEmUysPb6+1DykSaXLIv5ch
	lWkI8vTSMnor3trhbfxAD/3vvpNpHbXi7n5JVUlmmrUb8MWlgeXpMRFuz0ApNKVsXx5Cz9TV+6L
	3yQdAgIhhXWdmHfZtyMmFHBsWpY2qYJHQkl2S6Pzfi12PelJCua16sdHkpA1Yl2atC+XSHoauDU
	IunmKfJ5OB+Ne9ihaPcNV6I7l4avd6XPBC+W4CeXffbRSc01kRdanwpeaJsT2/HDzoHtNW7F2r4
	jtI2aiImR6qUtT/fcoZ+QNSDHos1RyLAzrRg4X9ZmeKRRKreu7BM57s7SWVL8drpFZ2Xz9A==
X-Received: by 2002:a05:651c:2120:b0:3a5:a54d:c8cc with SMTP id
 38308e7fff4ca-3a5b381adbdmr2465281fa.23.1789199704298; Sat, 12 Sep 2026
 00:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aqPxxX9MeGmAqGy6@boxer>
In-Reply-To: <aqPxxX9MeGmAqGy6@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 12 Sep 2026 15:54:25 +0800
X-Gm-Features: AcwNN1VhgUjz0cIUxA0NgGcE4loqFcZjApjBq91ceZl4RtJn8Fq4WivT_OFEx5E
Message-ID: <CAL+tcoAxn5FCHJr8Lp_8n+4pbz2m4gXmfHxhvg6jFOgFHN0J5g@mail.gmail.com>
Subject: Re: [ANN] AF_XDP office hours
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 8:21=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Hi!
>
> We feel that there are efforts on various sides related to AF_XDP
> development so we thought it would be nice to have a mechanism to have
> cross-company syncs or discussions.
>
> Therefore, let us introduce AF_XDP office hours. Plan is to have a meetin=
g
> every Wednesday 9am pacific time. Similar to what BPF did, we're gonna
> have a public spreadsheet where people can put topics for discussions:
>
> https://docs.google.com/spreadsheets/d/16GL6AbdjDyT81cJ3-qUnYvFxqO-RlhtYT=
S68bfQQDbw/
>
> At this point we are planning to meet even though agenda is empty for
> given week, this might change in a future.

Awesome! Even if the schedule is a bit late for me (0:00/1:00 AM).

Yep, there is one thing that needs discussion:
https://lore.kernel.org/all/CAL+tcoCPKPucCJVGD7MA=3DXSUyCte0K7WTOYuCrLfbRTd=
Wv2mrw@mail.gmail.com/
because I see no reply during this time. Adding something complicated
in the hot path to fix an issue makes me feel cautious/unsecure.

Thanks,
Jason

>
>
> Thanks,
> Maciej
>
