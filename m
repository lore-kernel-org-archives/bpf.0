Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3E2DCC04
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770808571; cv=pass; b=kJvE3vLRJYZKltaygKcuUidkIm0Zk13bhU8ot78TUlSXv+R3gbo8MxZdwqsgePM3j+lb5qNdCnRuBarHLaNIARiVOtedlnyvwiZMkHpa5GcalV119ptQ5tlYsnZfky3Um2MTlPSpf0tQfazRlTbusylg7TtI29TlxBOkC/U5/uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770808571; c=relaxed/simple;
	bh=jkBtG/j8ZN/4okd84k0jEU3hNy0M3wj/2JyT74HxgkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzJGd4Uor2GEAjov9ROq1Fh7QFv+18HbGc7reCvHhLJ4dVvNxFvhyRarhKnTXskekuR3KmMjzxHXRAI4TmoniUpxBO5GtJyCWitIF8OU/uQ4DDo0ZWah6eoycdQShTxvTRM59qW5otwz/Q7Knjxay+BB3XEtG1ryCa+mCPArFKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2QpUecS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZB0chFby; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2QpUecS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZB0chFby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770808569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkBtG/j8ZN/4okd84k0jEU3hNy0M3wj/2JyT74HxgkE=;
	b=d2QpUecSl2zRAm9woTSHOqqp3JJP/H/2aAF4srTwMy4yK8BNMleF4Mead4sKZ3oVNxPrUc
	yMFArioCNbCHFrE+94xO7B3neFMHbGcZVKJBAUTS7cyLzgBr80ue9CrJ9e0YK6HRU7Pnoa
	QNba1ur99bM5H0lMZD35Z489sww/uCs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Wv3ExdlzNf-l8uSLv5-Tkg-1; Wed, 11 Feb 2026 06:16:07 -0500
X-MC-Unique: Wv3ExdlzNf-l8uSLv5-Tkg-1
X-Mimecast-MFC-AGG-ID: Wv3ExdlzNf-l8uSLv5-Tkg_1770808566
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b844098869cso254150366b.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 03:16:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770808566; cv=none;
        d=google.com; s=arc-20240605;
        b=UsieMlF0LWPejJEXqN24SA+rhWFyNrDJ2VI3uQ3FSVlORvG3ZqkPkqNoy2d/ls+oEb
         u/56JXvNf+VYqA2dYz6x+MGns9Dl+FMpYiI/xrK626rdl2hu7tgf7hsHE108zNpDcDVG
         RObcSRzFnDM0I4M5uzZsmVWRIMlkbP60iFsa7izTqdyBaSrG5x27nWQwx0oExJcEw+VQ
         g42LaHFZIz88YutEgdqBMNorCme3RL9bqDqFkMunXXXdozx8oBqlalddOEL7fQQUHIcY
         RmuFt/38j9vQo7vNf84gXQYeF7vxKX0PfgC7VtRmq3gLcui3PV3Cz8YQskKWtfoHZVmV
         3ZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkBtG/j8ZN/4okd84k0jEU3hNy0M3wj/2JyT74HxgkE=;
        fh=hH/OxWjZAta3Rvahx8wogoX19tF33Ui9RWr14gCLjbw=;
        b=k2sKAdeo8zvwqJDGaH2HpotbZNkbRlBz4RhdYJRll9ABK4pf8f5HOJyqHq+KCEdzj7
         6Nlaik/WuaKyERELQzUKywuY/W7deiaimp9JOMKwEncAypfPRIH/IES3a8qCCF8oVxQE
         pgyYSbgHsCIgLOxMOMdtd8Nhb7T2xwCPdz/dDGJXOAoWNWHBVY3u2wknHJ6XE6AEKPn1
         AAugrL+t5ophgzlkoKg/rtZYo02SakvjjUsHMi8Ah7MljHHfNA2SM80i9umNXm0CWo+p
         AgawvNYJsDIVUxE/C04ewaNN76x6b1ud/XgdsqZO3GYNER+zyU64edgs42cMmhNraKtn
         fbwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770808566; x=1771413366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkBtG/j8ZN/4okd84k0jEU3hNy0M3wj/2JyT74HxgkE=;
        b=ZB0chFbyilXPfI5aAnTV1j7Ydjd2j6H3JC+iG8pnh/7TZfSu2eGbUzgr40CK71RNM3
         eXNFvrchV2sB9f/dM8+H2yPCqwdvzBRXhNyMq98Y9QKB8DvSVWcU0ZjwZIDUYva40p7G
         QvNlIylrpqOcqlPNwAQijKvwWp2clVeo0Ds3yWAGxTIl7eqS7/OoZ+hNh8RmcPNaG6Lk
         WyYB/8MMf0eSV39YnyIFphrxJzjBKzUuB3U6EWulyKDTYydo7LKQzh4loHKIBn3CTA/S
         vfNZBj8rIUNDvzZkkPhOTIJpKFp0tiPeoLcoDZotek8NBBkFhmyhh08luWVFqq5zR/Dm
         V2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770808566; x=1771413366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jkBtG/j8ZN/4okd84k0jEU3hNy0M3wj/2JyT74HxgkE=;
        b=TuCTYFKsRVJ0GY4MPwZVZ99proOjiBI0I6oGBI2R1167IrqOsBBo04WXOI5o5m45FD
         rRhHdz1PMhXTRpR14aU50qBkdnsmT4h5kZUV3wRkiDcbpNPt1HNNqGVfU9Gu6jIO9RM3
         BeiGRZv+5XXndGCzXYlhcLhesmUAlDCFe+Ejm98/1mQjVsFrAvr7169pb8F1rXFDYSSu
         Vl5pdrITFpxENaio9vUr4hW5M2Vj0UKSi4SOxaPbrAIF2tJJbMasvYPyt5JEIhuDMvO5
         Ou8t3Z0DCgeda5P4AODw9IAOME3YVgqSMRaH1WnQ+TLKdktJQM9JTjY/oCGLs1hXT9bm
         v3cg==
X-Forwarded-Encrypted: i=1; AJvYcCUN58Gxv1e23l2DgzYOaXoTPOYMnFIscxUdKHUUuf4DIefQTXmu1lHChplnD6ATGAnsI88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Q4xRZUMi2dYXpfz8JAAY4k0sU61Nav4NwuQs/p8BXvS1/hFr
	pyah2aCvmGEjgGjFwCppkZdxhl+S587wMR0rm0mQ4mCF4jwo3wO3Zxtbr6nFDlkK1SbcRcKx0TG
	L1CJNowSyKFoJcrtBuVtprED6PDm44z7Jfwz/mvXt6/t+kPwOxdFF2fBFx8olTWhCFJTzYbfX8j
	f6WF/NinSoIBZKsByxkB5Bg68LVPpB
X-Gm-Gg: AZuq6aLKCvnzO0k39MoikgaB4m1373+nwjoT6PdTyvlidJVpkSvLyBBV1c90A57nQn5
	7zOChdYwQUJCsK2rxSLlcKLRxH7sFA+5BjsM4DVREol/Zk+YnAx7rnLiPoV2Wi4t17WGANwrFdD
	CML5umLr//COA9k4vpZalq3se3I8UaaUHNftKOMGngdYGSHbSeXFaLXbpx2TT9TnQKHT4sqf4DS
	NkA
X-Received: by 2002:a17:907:3c8e:b0:b8e:a126:66c2 with SMTP id a640c23a62f3a-b8edf38e6ecmr1063989366b.45.1770808565991;
        Wed, 11 Feb 2026 03:16:05 -0800 (PST)
X-Received: by 2002:a17:907:3c8e:b0:b8e:a126:66c2 with SMTP id
 a640c23a62f3a-b8edf38e6ecmr1063987166b.45.1770808565588; Wed, 11 Feb 2026
 03:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209092436.2899888-1-costa.shul@redhat.com>
 <20260209092436.2899888-2-costa.shul@redhat.com> <aYxhtrJ8cw7SNOJy@fedora>
In-Reply-To: <aYxhtrJ8cw7SNOJy@fedora>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 11 Feb 2026 12:15:54 +0100
X-Gm-Features: AZwV_QjrgosTOG9OQk2nFpenxiJARU16IxGo0YBJgtdrPcEO2NsfIFEDJSnp6AU
Message-ID: <CAP4=nvQp4J_PRbbNNxy6FErcgFF4Qmn3ty0N2HcDSQG5isLiKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] tools/rtla: Consolidate nr_cpus usage across all tools
To: Wander Lairson Costa <wander@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Crystal Wood <crwood@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 11. 2. 2026 v 12:03 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> > `#pragma once` in timerlat_u.h is needed for pre-C23 compilers to avoid
> > redefinition errors.
>
> Isn't it necessary for C23 compilers?
>

C23 allowed struct redefinition [1] to enable template-like macros. As
a side effect, including timerlat_u.h twice does not break anything,
in C23 only. But the Linux kernel supports building with lower
standards of C, so it has to work there, too.

Tomas

[1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3003.pdf

