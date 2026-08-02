Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900BF34D93B
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785705287; cv=none; b=ddFVPnJD4aK3vb4R+A5OlPTWOiexWT7zy8M6KcnTnmDf2+J6bPmA9meSzesEFuAPulDAPwUeQa3CsQ/XKiNex3cXd/xrOM3utbQKUGHYUGXIKm8zYW3lGb5CN2pvdSyxr8JgKKedlnOpzepQTEfKlW0d+bED3kgQnIrNoPhw6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785705287; c=relaxed/simple;
	bh=xiH5K20zhFLujCG5cqdKwN3NVZ6Xi+Iv8KH317YeteE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jOfe3sn0JYySdiTp2ckRDNpf596hVccsBZij4wzGvd0hPRJvnL5ShIbccRPmlgCjkyrc06UwaWfBmyYTVirJBTXIMWisuVul9k/XtJbZx6/VijwY0EWEuuDhPSK4P3gR2iNXmpnq22Mhb0WowtKNYPewfB+RSiqVwrz0DdTxdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0ocr1DB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0ocr1DB"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8453427d3f4so2952679b3a.3
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785705278; x=1786310078; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I4KXpZ+gjMlK0sJuzsGSRQEWx7WfloFw34dvf/AKuII=;
        b=j0ocr1DBvlNB155o7zYzrZxcHXSAh0bOXswv7Grw/0BbNmHOVBlu5gTqMQGtTnZAcR
         heq8xMsaBw+LZ81DIoY/0OV3B3z1QqxZBRMVxWHhC/e6mGXRse7X9I4vglS0iewtCaRW
         0iJRJ/+EZsUFSLg/QvFNTM9RYW4NiXw00loovR7khbLAKyp0hJgwxSUl6rAJeHgT1Akr
         QgEGtUbDJdI0zzG81ZfNpZeLIohcJyBLWdDsJxIIuc0jCQVf5ldHzJk+QBZ25OE7sm8u
         LneoXL0TtS8+U/GHxXE8wpZtbZZg7Wiqywf0AQfWySVlbsN1CD5LJbIeTQJpcQlaJGnx
         1y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785705278; x=1786310078;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I4KXpZ+gjMlK0sJuzsGSRQEWx7WfloFw34dvf/AKuII=;
        b=fXz1I9ZkDdip50s+fe6Hi7wIXMFmbKzjS2nDfIcfE0nqvlHzMHtLreSYxEMCQFDKFi
         bfX1kEPCVbSKgXGlC7AdPX4y6ak9jXhk5qqeNgKiUHxFUUK2EkqxFGrUPbQGZtHZpNuA
         WH9MNXmRxnB5zmfRQJKTsKIm3LBp6jv5IQXZ2MptJ4m0f6R3F1BRGhlAC1znAUOfq6Vi
         Aw/HrcOvKtbXqZqTArUpiKW1oip6QrV7qEtt4jieiEwe1Bb8ABJAV8z6gUi6t8nkF746
         mB6kVqCXNK3TotwzzlZ5OH3baxCq8QL/SEMec6DUb2JhY8kUpDRaZHrOtVLlAjn8M2pi
         1buQ==
X-Gm-Message-State: AOJu0Yy2YO2pjUb6SxGQkmOgH+bjPNYmjHFAopQZGg9IjA+nKUv5NaCb
	WGiVB7O9Qs7Y16u3k0ii0U5Ftkmjtt2TX6keMzTEAjTDcv76pzM2ldposDVDXg==
X-Gm-Gg: AR+sD11abun86rkkR6iyexc0fssopRu1HURM9GwRLQ8Zx2skZhf5Rz5e7S64FfowtMQ
	SrVUXtO4KzGdKd8IZBLTIzGODT7vwyUAXMsmueYa+nDGCe9Ynm2U9u+ZRpQv8mUGuLBcB+1PvD9
	3nhYx3Gyq+d/ras19/3FKTz88q8ClOzTMNMaM6T0biPZq5UBoMdGwbS2WjjFF68YnzId5k1t9b+
	JK8wCGjicjqC88L2D63ggZwBS7W1biJyizIYR9c1iR3M/qA98pfIgLzTnUbpod9055thlPt0T42
	h7UbNMHavtRfSGkh138bSdmnbA21dnh84w3Xh811HB8RLO+i/b0lyBeAZWAGpMAROPNE4zvrJBn
	0WRHzV/wzmQuLH+Rx0IuUm5/QVlqX58UCOQIxhV/ePfIkO8JqNxTeyEKEWk6vVENP1FxWm02AmX
	H5Q7ApphQALCRZ+lK4okXeTpVmonv0xrl6yzRxc13whtZhz9ZhvXdq6scxVLilxjVqw6LqpYKoi
	E9VpnG73dMehkf1
X-Received: by 2002:a05:6a00:b4c:b0:847:99bb:b6d8 with SMTP id d2e1a72fcca58-84ee4840802mr6580892b3a.26.1785705278245;
        Sun, 02 Aug 2026 14:14:38 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29f31dsm2747170b3a.36.2026.08.02.14.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:14:37 -0700 (PDT)
Message-ID: <ddc2fbf63c32eb8b933589d27550f2a8d0eecba0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] bpf: infer zext_dst based on static
 register liveness analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Sun, 02 Aug 2026 14:14:35 -0700
In-Reply-To: <20260802210741.D10C21F000E9@smtp.kernel.org>
References: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
	 <20260802-static-zext-v3-3-3456b2604574@gmail.com>
	 <20260802210741.D10C21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-02 at 21:07 +0000, sashiko-bot@kernel.org wrote:

...

> > @@ -15026,18 +14941,14 @@ static int check_alu_op(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn)
> > =C2=A0				if (insn->imm) {
> > =C2=A0					/* off =3D=3D BPF_ADDR_SPACE_CAST */
> > =C2=A0					mark_reg_unknown(env, regs, insn->dst_reg);
> > -					if (insn->imm =3D=3D 1) { /* cast from as(1) to as(0) */
> > +					if (insn->imm =3D=3D 1) /* cast from as(1) to as(0) */
> > =C2=A0						dst_reg->type =3D PTR_TO_ARENA;
> > -						/* PTR_TO_ARENA is 32-bit */
> > -						dst_reg->subreg_def =3D env->insn_idx + 1;
> > -					}
>=20
> [Severity: Critical]
> Does this missing zero-extension for BPF_ADDR_SPACE_CAST allow out-of-bou=
nds
> arena access on architectures needing explicit zero-extension?

Nope, in combination with changes to bpf_is_reg64() in the next patch
it does not. bpf_is_reg64() handles BPF_ADDR_SPACE_CAST after that change.
The commit log is not very clear about that, though.

...
