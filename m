Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8D37A85C
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 05:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785389918; cv=none; b=bsFfqFnYZn013IoT0Hdyvbdw4mEUE1Jj9XLVyH6fYxBXqBy5n2/jSGh0HSBW/fzcTy6YLPKsNO2NTrfth+iQd1o5UbqgMKr3MSA1pWRo0IyfdFA8XpB30mT3ZNjD9mFNu1nKFVhUVT6XgFSWW4QiCFeJsbCgwbGQ+9b115gSkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785389918; c=relaxed/simple;
	bh=WKd4BF371s2Vs0r1R8raYzeInA3l/C20QES7wTMzg2I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gPWgExOrWm2+uVYHeIC52CyOQblGgbkeaBABTbgJr1XZCdZTQeUb3AT1Hmvyw+L5UPzzpx4U5QZbVYq9IhPLQJnrXPCUf1M3m72xD5paDIeJVUZM/wcCuran40VD3GNRrHLpS8an1/VoXKHUi28TMYtLZRA/VScPDtWbherOd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9B2cOxv; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9B2cOxv"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb85186d43so862382a12.3
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 22:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785389916; x=1785994716; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WKd4BF371s2Vs0r1R8raYzeInA3l/C20QES7wTMzg2I=;
        b=H9B2cOxvz5fLhx4iK7EHTyyaCUCXYOxFbGHL/VJYN/d+gLGnyiIopjfMI5djxmBffM
         RXWPIqvdxasRYLWmmWgEiqLAOMq3SjCaVY+MWTiRZuorEa36/mjpdLIcjyfjj4ym6KmG
         lXHAh51h5adSiKehIRz9inpNbC02AiEOCe7+5w/kcU/BAqmmT1Vf4AHvdS4MsxgWSxzf
         J6FZshIsxLT0jyc+lU+pkpbvJUwXTGqUOdF0bniJz0RBfnhBO6HzvTuF1b085du9iAvA
         sUf/rRGGphxsDo9UYiuwxOYNufCjelEwa39Tkt9F8cl+x+W3lBevNa4AkIJWcvG1wFGF
         M/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785389916; x=1785994716;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WKd4BF371s2Vs0r1R8raYzeInA3l/C20QES7wTMzg2I=;
        b=Dlx3tGwUCVuFzZTxFFfq2fGQvc81YbjXtPiRd5dqDvtOmV+NcJGSv0xneXwxrAS2t7
         yu53YlvX8YJAn13f59WDv5ACrIu6v8vv6Cxw7uzA7cQAXgNqlv11oY4Ay37cEaExT9qn
         xxuVCFkwmB9yB4YfTVmpCK1M0RD6fpq9CN35uiqgK4aik3tpOdHUGJlwnipYZlAmk+0i
         qTfWteStHLCTd0Zx6t3PgV5FIco3LAwponqZg0igiEJ4jyeSnGi6XEipflmEKofFiKog
         WHr96bqcctZ4W0FCG/0iqollI+4A34/Vf2tl3puhBDRsbEHGuU/AZUBWx4/gEgCUjQsi
         dElg==
X-Gm-Message-State: AOJu0Yy9D2RTKZxI0PdK48sb42Bju3YHHOuRQj+YlQK6OcI7VpXScGNI
	Wi2/ACT38Of0tipg4yLsDFf5Difsgc276IZ8SMWV1oTvRYV5UMxQ6b4z
X-Gm-Gg: AR+sD12PblFK0DmFFPdYULYpMDs3990u8kIqAWsXbIdquNOUaiuS4cRiujYcqJXPxoN
	9zTZnSKAIEP9b7HlfyMPagwFaOP65e84GHwcAA8JBuijwv7ZE+FW6sXjra2kc3xccuGhhTFOWl+
	5pM7IVs+uECEAY+HBSZB+N03/lvuAkUIyP1ix8PK6UPQfi7KjRFwIUxHtFEuRb1DT0bIc1yI7a4
	xkvchgX3H3gm/7muwVufpoZ/CTzxchpS4/6jq6Zfc8FPTHdUaSFSiZwjiLk7HZ73kZIIVabxpuk
	I8H1gMBHWvcryYY/dGRkMQYQETY6ZHwUHrZF7l6/824wVepVoPIGHn0H9ALyhkltTQ8WTwJpshc
	saF6vVdiMJ1aoZMYbHt4OX0gM0H7g8wgyqI0h8Q1iLDpcN3nDMRKxKMLLTYToQAU11oR3stsQuF
	oYdijErWGjDqDsBwXWjhPcbFijBPLf4oA2JqzpJwn2ombZmpwKBceDXniIrdiVmtYwL9j0d/3wG
	4iTGkkCjIlMax7P
X-Received: by 2002:a05:6a21:697:b0:3c3:6928:8b25 with SMTP id adf61e73a8af0-3c9006b6b41mr1176001637.17.1785389916253;
        Wed, 29 Jul 2026 22:38:36 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba63c4dfsm1720001a12.22.2026.07.29.22.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 22:38:35 -0700 (PDT)
Message-ID: <6bc1c363e751e9ee76e77c64d05795f069b2144e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 15/18] bpf: Classify kfunc pointer arguments
 from BTF, resolve type against the register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Date: Wed, 29 Jul 2026 22:38:33 -0700
In-Reply-To: <CAMB2axNb0m7svf=9X5xTidyqpKMup8akeL+2tGy6J5eMGDcQPQ@mail.gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-16-ameryhung@gmail.com>
	 <cc7d59269cbe0fb24f9cf0f0ae40d555d050e07a.camel@gmail.com>
	 <CAMB2axNb0m7svf=9X5xTidyqpKMup8akeL+2tGy6J5eMGDcQPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-28 at 23:22 -0700, Amery Hung wrote:

...

> > I think this now accepts one previously rejected case:
> > - register being PTR_TO_BTF_ID, pointer to scalar
> > - parameter being pointer to scalar w/o size register.
> > Previously it was rejected by the following code in the
> > get_kfunc_ptr_arg_type():
> >=20
> > =C2=A0 if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[ba=
se_type(reg->type)])) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!btf_type_is=
_struct(ref_t)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verbose(env, "kernel function %s %s point=
er type %s %s is not supported\n",
> >=20
> > Is this intended?
>=20
> Good catch. No, it was not intended, but it seems to be an acceptable
> relaxation. The argument will be classified as KF_ARG_PTR_TO_MEM |
> MEM_FIXED_SIZE. The PTR_TO_BTF_ID register will go through
> check_mem_reg() -> check_helper_mem_access() ->
> check_ptr_to_btf_access(), and by default only read is allowed.

Yeah, probably harmless.
