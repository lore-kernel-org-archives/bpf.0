Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAAA3E1205
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756092; cv=none; b=QyzreL5dCgk2m14BOKmxQXlszWdYC2/T4khTPckcBNDlO/hTBShQEdFqxSEipd4nY3w838OvT/G7JHm/18tf2OuuDXeW3pNrTECCChWjlEFso64HTUkMHwxc0fFWSJrvA+TVSYuzotD+LSrYgApC9GR7A6b/MHAxTeYf3KB8Wts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756092; c=relaxed/simple;
	bh=QNGzhaws/ILgJmwyVqWJT7BY2rbvZFUGhFYWXKg1dmA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=r+qOrNfqFOKyCss/F8l2+RTC+8LA+bf7ON569jbVN3CW7knaBb7HxjpqDHLZbZDymwnEPLRMZNsLi6gNSNX/g3S3yXiGV+ljH3OMeB90HrAjC2uvYSTxmWlnLT10JHN0izmM9Ag4AkRlSVEw+dWgoXljBwP5iQe4afpCGvvUQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDP2A/Ek; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDP2A/Ek"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-794719afcd4so51547507b3.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773756090; x=1774360890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T+kHlqZbPOUk2QRRSgAwGxeEJRArRfLuYjXKmhB30w=;
        b=TDP2A/Eki2fRNnAMltAlHKxXa46RYiCFrjcfkITUE4ZwJvdw+dDruJ2DLoByaRxGN5
         P8SMtjD6D8d/eZYpxeeK69qNy6o5CSB4x6QSARlbotFgiM51MsystVyA13RtqtD6v5Ur
         dXeyuFMabNwkZI1AbAf9QDNEL/iAYwmJb8wYd8GFLIOPH5kCdo7pJsgoTAigLTBarJEx
         hMcnc9xzydLGHaWKnZDsUfg6+rcHx5Af1+qH1aL9LK1wDZz70UBK4NQr7OEXn6PYGMFP
         5RcmRTGA64mlswcjpD5dN4M/6MrEMz/MdoILMP2wjTVRQYxcGIHogVpOzR6rcDf5yrc3
         tmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756090; x=1774360890;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9T+kHlqZbPOUk2QRRSgAwGxeEJRArRfLuYjXKmhB30w=;
        b=kZ1GnDNL7vGCgQyPEXhneEsroshQeQHiGfDlf6JSAlXSKV5vpkcuEsdzW/+tNfrSz2
         WBxhEcEreKTdsXzj0W7SA35gzyS0Ke0S4SWGCuWH7Y3Gx/OiovGTCtufoHbPhNbegz9c
         gS8OypBkj2dMKjS1GAvfhZjBtY6Mvpr9fh6RHdwrYiYm+8GXrulMmA9lP1R2DAvNBt+p
         TmrS+y+P7yWhbJmW+Bm+Zs91hYVwhhRPP9Wal/38ENM1ShTtv9TO/Z4g29jbVXdKTpjr
         zQNa1fQbQYxDkT4dUdS0v4N/ZyOqduXFQiartMtA21H+uJgOg5DdZfgYIJ3IajGxes7r
         lHhw==
X-Gm-Message-State: AOJu0Yw4r0I/H70wUHIF4bGrI/JAHn1+ekp/aazNYydFmZbk+PCnsj7+
	bs56Rf7JbuurxVsLfvf4XTK013EMkhftSq4OHCYt5mMfsfaSaisKITKN
X-Gm-Gg: ATEYQzzlJq4fZmDuUaDaP6T1CqvlDbNCNJ+t+aLD6zXixqiIL0NHJStbMS9SSbcU754
	fb5TbCvzcb/xv7b/pXVMAAFcuAGJyrXYRBOse1rWFbh1FkccP7j565+TCCTLou/SW+GHoxme/u8
	t64VWgZ1Xs4RqFbTr6eNHJ+Ea3Gs/VlcMeNQ4f9yzWuPSogAAKoD3sO1RjTL0EgfWdgYlB1m8JF
	NG6saaWE3lJaCYt0lPnbtV/rJLRPL+Ov30P5LbNSHBw9qoN2x+cP3Awt5Fm7BrgAOfgbtySfx8h
	9tP1PV0jjcjcZ+K2GZqyTyP7FTkX6bbRGyzsBDmH6r3ojWKMip7WI8Muvsi4+M9ADc/MHRdAGd2
	KJDIQahKyREstCskC+XcRb1BQgCZcFB95zhCJfHD2uTNSrWrcm5zuBYAgzNlMHmgXCzBXnop9MI
	Mbb2scA4mxu/QI1oOT1NI0tkx39o4x1zfc6RWlHRy2iW1YkA0s2RxS/ydE7rjrJXBl2PwHOEtYA
	gQi
X-Received: by 2002:a05:690c:38b:b0:79a:46eb:d1c9 with SMTP id 00721157ae682-79a46ebe0e3mr81263797b3.0.1773756089988;
        Tue, 17 Mar 2026 07:01:29 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a2de73263sm58179747b3.43.2026.03.17.07.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 07:01:29 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:01:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Hudson, Nick" <nhudson@akamai.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "Tottenham, Max" <mtottenh@akamai.com>, 
 "Glasgall, Anna" <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.1101cf7573cc9@gmail.com>
In-Reply-To: <39BDB245-4486-4487-9985-0D4FDBCB382B@akamai.com>
References: <20260317121429.2399539-1-nhudson@akamai.com>
 <20260317121429.2399539-4-nhudson@akamai.com>
 <willemdebruijn.kernel.3102df56d5f64@gmail.com>
 <39BDB245-4486-4487-9985-0D4FDBCB382B@akamai.com>
Subject: Re: [PATCH v1 3/5] bpf: add helper masks for ADJ_ROOM decap flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hudson, Nick wrote:
> =

> =

> > On 17 Mar 2026, at 13:27, Willem de Bruijn <willemdebruijn.kernel@gma=
il.com> wrote:
> > =

> > !-------------------------------------------------------------------|=

> >  This Message Is From an External Sender
> >  This message came from outside your organization.
> > |-------------------------------------------------------------------!=

> > =

> > Nick Hudson wrote:
> >> Introduce helper masks for bpf_skb_adjust_room() decapsulation flags=

> >> to simplify validation and keep flag handling readable:
> >> =

> >> - BPF_F_ADJ_ROOM_DECAP_L4_MASK
> >> - BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK
> >> - BPF_F_ADJ_ROOM_ENCAP_MASK
> >> - BPF_F_ADJ_ROOM_DECAP_MASK
> >> =

> >> Also fold these masks into BPF_F_ADJ_ROOM_MASK and per-path flag
> >> validation checks.
> >> =

> >> This is a refactoring/plumbing change; functional decapsulation and
> >> GSO behavior updates are handled in later patches.
> >> =

> >> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> >> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> >> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> >> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> >> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> > =

> > Only patches 3 through 5 were sent to the netdev list.
> =

> oops.
> =

> > =

> > Please resubmit the entire series (after the customary 24 hr min) to
> > the full list.
> =

> Will do=E2=80=A6 as v2 with patch re-order you mentioned?
 =

Yes


