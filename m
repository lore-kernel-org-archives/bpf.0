Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28672D9EFB
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336828; cv=none; b=jqdaJO+6fBE72NyjKTyAOmmEepbbITska6wkw2nkEt72FpAFavl2EFaSoXYK5HI8I/AM3bZpaxbKhL2BE2Usr4d4ZfFgeO4wDDHD/Cxta7SIo/yxuMcQLtHao7IeNqD8F/bHBCC3Cg8FWwUPP+jys9hXlaiLole3/mbLpSNUDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336828; c=relaxed/simple;
	bh=TEwcs9QV6IRkpLFCirJt9niMwetx10OpdmiVpveQtLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OFAf0G+R/Z2ojLj3R2ywZpeewwCiRkfaP+2irDnIgWHOj1FhtvhFi59V41edKp/is63kwvJli5S/KGBaZwU7WIMt3BJAO8cCkb8jsXu8Tn82fNLpKV6ApykvnJtBKKoNIt5AZeINV5FL5Q4rvfhR/CighjQvgV+48ff/ljFBBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfOkREbR; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfOkREbR"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13721dfd471so9678726c88.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780336827; x=1780941627; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=63QzUSItxjqthVwyw4x4XOqLTeOM5ciWj6AEgFnXSaY=;
        b=QfOkREbRRvj7gdvSSW73LCHtnfHqKN2pZElFZmegsNZgU7xzheP/pt84P5XaBw3zIZ
         W7HU2HQ8jU+Bp7QGnBzgdNlb3DNHssKRKzVMM8Nha+1b4chOdCi+mFUDIQXuCGKmn24S
         UBQ+bolbAgCbsWrwtbAh2UA1F6vghwQTkujxNXPpGF/b4JIHVjQA/mJIWULjb9g28S1r
         XO6xZZM1+dcAfFagQ8HpHLxgWgZWKpscAnRp9iEGD238kXJ74F3CGLuI2jgkw92NXMO8
         w57iBrBKmtT2v7SAbmD3SYurIc3GMX/uygd3M1zu2atN0hKMG6QlCfFijTnXUOxkpvAu
         ziGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336827; x=1780941627;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63QzUSItxjqthVwyw4x4XOqLTeOM5ciWj6AEgFnXSaY=;
        b=QBG3VibXJ9eP36bcLf3BcK8vciGBY1GJeFiOQGprWophfZr14ds35ad8vWuIkhZn9c
         kPmgPJ+Wb9TMpceC+5OMhynRahQI5huMdhlCmNAuXOUBOrRnT+6PDVI/22bn5VMeJ/Hy
         T/Z4X+IiarI6l6wHtr/BVsfwX3Pqfj9pKZfVldTjZp0drmRiuvmyBGONqZi9v6Ha5uvW
         h/gqT11xNaZO0WVawtvJW/wlKxP7l258b2j9u0F7exnb3J1e6NnX7NvHxkQM65DCxYLn
         x5RNobEMx7X6lrDndEBBvL+vwVleVvg/OOEcExNl0EqJVYss5OxRmZ+jPp3ziwDzwgDG
         N3ug==
X-Forwarded-Encrypted: i=1; AFNElJ89fTV0xnhgJpWjMCJnj9NQWYGK7z639ziErp3KjD98Fja5rI1I80+KvWALIpdd9GvpTYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJOjCD8VSwcE5aZ0m1ogQuhEY8ToNqgCuZBuCelTCkkbby8ml
	xaky/Iv+8n+x0KqQ9CAEAL+dnM0B2TQssc6H644RBO4kN1Ta4rSY89sU
X-Gm-Gg: Acq92OGoGY6+96kCqNLSe3y4X6ouGRS+gqSKnzjhlIn6QlysqMu4nY6Pv6NssSrp7i2
	PehqplS3Klf9AqnfHCUqzC5RzQTA0hfgDQJ+3z+lXf5InWryHAbHSQ8FihRU0YcOxtnP5CGLut9
	uo4C6094h0qkmuTcmxZpCuVuvDRsMQwc0cN+dak3EXmn8T0zbgPL9k1JFosXXUAcL5kxodC7IqX
	32r9X7rLE2TqSB04rW1Hk298Ptb4ZHLfQ+UGWq+ZRXSqQMUe5lXmLAzIxdJ5rLNLW2i/EcZkhPb
	rRcqBPg6M2N996rz5i7hlQ4K22ZHShZIIPcjTUotPw3qdeJyITTL3qyM1vmCIbNByxOVSACwjsG
	CennX8JEdg+gF8Tf8hy29w9kLS1kRFEQdy+eTLvAyW2FRL8d8sYiOnwL3jMqlwMjj20j6s5Et2+
	Z2xDbGWD11zBY9Ux7Bd6tm9U8Ibr/crZ1XtPLbJY0CIJyDRzd2jW5whe2JC3rNIMQdNnO64yn9z
	9L8rhCJ8ARUIokJNNT5ocEpjEc=
X-Received: by 2002:a05:7022:4b:b0:137:6781:7dc7 with SMTP id a92af1059eb24-137d423c272mr4699930c88.19.1780336826867;
        Mon, 01 Jun 2026 11:00:26 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:34dc:a4cc:76e5:e597? ([2620:10d:c090:500::7acb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137dc179940sm5050092c88.5.2026.06.01.11.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:00:26 -0700 (PDT)
Message-ID: <1bf1a11fa5dcb38287384833dd77c748f3a766b7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 05/13] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Mon, 01 Jun 2026 11:00:24 -0700
In-Reply-To: <20260529014936.2811085-6-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
	 <20260529014936.2811085-6-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-28 at 18:49 -0700, Amery Hung wrote:

I think refsafe() needs an update.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 877338136009..5945956a7573 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

I think refsafe() needs an update as well.
Something like:

    --- a/kernel/bpf/states.c
    +++ b/kernel/bpf/states.c
    @@ -886,6 +886,7 @@ static bool refsafe(struct bpf_verifier_state *old,=
 struct bpf_verifier_state *c
    =20
            for (i =3D 0; i < old->acquired_refs; i++) {
                    if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap)=
 ||
    +                   !check_ids(old->refs[i].parent_id, cur->refs[i].par=
ent_id, idmap) ||
                        old->refs[i].type !=3D cur->refs[i].type)
                            return false;
                    switch (old->refs[i].type) {

Wdyt?

[...]
