Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38D1339B1
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615284; cv=none; b=E+Ed0QVnpSXsUtqGIjdGwuR0tbwg2yyfDVTXuHHhO2otjAc6tc1AcxG8NKC+lf1th7xyhyiUC5h9bDNWDs579PWStWH25wq2R3UZdNFXZNdQzuvpBcM54cfxHQ6CTK6xMPOrYmZnMcuZkKUDh+LEwab5iC0oqXddE3wtcZrqgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615284; c=relaxed/simple;
	bh=7U/szfgXKtXMnDv3RqDoe2ETwCv4LarwWXNMMbO3ur4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZvhxXSk4TV0qk5dY6/FhpcJOmdtWp8vvmPJvvN0yqR0tOpRGv/AsDRa65QhqPcMB3awotPcMkVdXJQ3A1j6Gsl6f2x603TW7jyiTc5ejXPb9msY5Z6Nibuav2pppzNr1uDRheJAnl2jboKhR9y1oKb1ZqbUYg2twShJR8zhoTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhikLx3Z; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhikLx3Z"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8421f0e9c5bso588859b3a.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780615281; x=1781220081; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eHWZ6A9B/1c/c8Z7W9iMQrXkzA6+51AuQekNuyU9bqI=;
        b=VhikLx3ZAzO6ZumEvHpaQDfkaZaXQGcvqfrOrTFe8FVZh3aIJACkNC7UN8cQJAOJjd
         Y0RQm1ASKbvWNHZr1zFihuoNjD5eYsPQS72/aF0/yMPxmmarqsw43wV3QwJ3J9uN+lHv
         FtQU8x4pEq75+GMVHRPPAzeGSxXp6iswoitV38dwyOwW6O9ch4BnO1MBQoINAyJnBgQZ
         Lra0nZ3Qc83D6NhjhDA48SNgEurcWNDutG9rF0IxN+NaCg+PTPamCX53VatV9EkzWrKC
         4NlZ2C7sTtjgt9f9Ha9iwRfSjeF7XdJXfZebBZl6j9EpaI/liezHVPzUZF7anNJex9gJ
         +Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780615281; x=1781220081;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHWZ6A9B/1c/c8Z7W9iMQrXkzA6+51AuQekNuyU9bqI=;
        b=re3syQtG79YSWF4Q0CZsg9v8YFwtVMqCiXXyy2wQS2iAKHunf+y3ostD1wweXmyW/H
         hWecgeW2JCz4uMzlwuu/mozm8ffVyvOoOjgUIEqyEUoTcULyh7AXx7cHUW5U3+iz/8ul
         8ctXSZhomBRZxPsG8IajLKfbiW4b1PuWQRFdQs3YWAyEbZ1SJEdb646AdkfytUF0IAAC
         neYTFAEVIb3Q1CnLEZ8seKFiOhfiPrgF8GnO7l5lEsL/dpkDiZWcjsWggb1mllXFxuv4
         r0I/I8OAgq0JsjJzD+oaWdXyP93hqnDS/5Mj3XMb/ECwkowcHjY9IFNtsXeHDl5brUhN
         hkEw==
X-Forwarded-Encrypted: i=1; AFNElJ8y9BaZm9MdpZ0uwUkNzjB/EY/U+KAvt6tPB8r6qNmoDjLY9tgtadJiH8QwsNdO0ib7GbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIoDPy9iM+wS1YsETZmfdqfsixbD6l/HAAjlxE04LnSrfcCY3s
	EbNBjOKVxk1F91qTEDym2r5XiraFEqqQqeT1W1q5iNolcb9fiE5atvLI
X-Gm-Gg: Acq92OG9d0dGeVwWECkqPiz7ABdj3dUBCvWAyzz4XtPm8os5tfaugFVQZyQ5//dcvo1
	WBJnOs+GnT5VnWJPcs4lMiT77Wd/sZ14cX5xrDeU+SGVCoLh4ezjDPrfEcbkzsAw/BDvkVPXVdt
	sloTrQ18tPprSxloCEzOGxBGYkiI7+kZYd/nO4HzaXj+fzTsOUovegtBS5+61vDZKDpP3l2q2nP
	+kc6R1wEzu8J5hqq6lWgp9niI0Vz0jX6+X843XFzkXBDhCH6dI4dxrq4y39IRgZD849IzoFgsDg
	IhHXEZWl3KCgycRet4LtU+nGaPKLm5eKO6Q0m6C/54oXmAefIL0rleGCGZbrJ0iFDRak/mhQZ8Q
	D1nFc5aE7ne8LKF24m5koXvs13HqPvsvE64qlKtjDl0j5G7r/2fH+DOgI1lJYjEmDQumR7xCuvd
	gl1sqfGJy1TSljTdbYvz6bIeU/Tr8AIyyzLPG4dB85AiMRzYu8PRykunMEg4B2Zg==
X-Received: by 2002:a05:6a00:1d83:b0:842:3ca9:32d5 with SMTP id d2e1a72fcca58-842b0e2048emr690165b3a.5.1780615281146;
        Thu, 04 Jun 2026 16:21:21 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a2600sm7739586b3a.27.2026.06.04.16.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:21:20 -0700 (PDT)
Message-ID: <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for
 REF_TYPE_PTR
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, ameryhung@gmail.com, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com, ast@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Date: Thu, 04 Jun 2026 16:21:17 -0700
In-Reply-To: <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
References: <20260604220904.1032145-3-ameryhung@gmail.com>
	 <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 22:59 +0000, bot+bpf-ci@kernel.org wrote:
> > commit 89f2be9817e074d02702d22068104fb9fd9aa103
> > Author: Amery Hung <ameryhung@gmail.com>
> > Date:=C2=A0=C2=A0 Thu Jun 4 15:09:03 2026 -0700
> >=20
> > =C2=A0=C2=A0=C2=A0 bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
> >=20
> > =C2=A0=C2=A0=C2=A0 refsafe() compared each reference's id and type but =
not its parent_id,
> > =C2=A0=C2=A0=C2=A0 so two states whose PTR references differ only in th=
e parent object they
> > =C2=A0=C2=A0=C2=A0 were derived from could be wrongly treated as equiva=
lent and pruned. Fix
> > =C2=A0=C2=A0=C2=A0 it by checking parent_id too.
> >=20
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Amery Hung <ameryhung@gmail.com>
>=20
> This looks like a bug fix for parent_id tracking support. Should this
> include:
>=20
> =C2=A0 Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking a=
nd fix dynptr UAF bug")
>=20
> When commit 308c7a0ae885 added parent_id tracking, it updated several
> safety-checking functions to compare parent_id but missed adding the
> parent_id check in refsafe() for the REF_TYPE_PTR case. This caused state=
s
> with different parent objects to be incorrectly treated as equivalent
> during state pruning.
>=20
> > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > index 5945956a7573..06d9ae24f006 100644
> > --- a/kernel/bpf/states.c
> > +++ b/kernel/bpf/states.c
> > @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *old,=
 struct bpf_verifier_state *c
> > =C2=A0			return false;
> > =C2=A0		switch (old->refs[i].type) {
> > =C2=A0		case REF_TYPE_PTR:
> > +			if (!check_ids(old->refs[i].parent_id, cur->refs[i].parent_id, idma=
p))
> > +				return false;
> > +			break;
> > =C2=A0		case REF_TYPE_IRQ:
> > =C2=A0			break;
> > =C2=A0		case REF_TYPE_LOCK:
>=20
> This adds an extra check_ids() call for parent_id. Could this make it
> easier to trigger the WARN_ON_ONCE() in check_ids() via BPF_ID_MAP_SIZE
> exhaustion?

I think the bot has the point here. Let's switch to reallocating idmap
or failing check_ids() if there are to many ids (probably an
unrealistic scenario).
