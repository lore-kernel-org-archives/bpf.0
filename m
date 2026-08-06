Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18829AB05
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043127; cv=none; b=XKLiBADu2TrDQ+FGu8dL/AsEduim7VEkQXcT+6qXhUGwDOTrpn9NJ33ieBVQ5aTtdr9/RXMjhY3PfthHFuEE0O6E2DknQM1SFON7XMRTX9uzKm4IZ+MZRUBcUzwpCrflVi6ouZNEO9IJbsoh35Dr1uM0XOIMEAav4A6R/wTf5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043127; c=relaxed/simple;
	bh=iwmpFeilXycTx4SuKxILJjFBoUF70sEwOlXtwOhnMpM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LSjB69YQ6f4+XftqnwTk+RzBNqEW1yDxo5QwaCKBrVyzsTBJSS+0Q+yRK+oFcplT9POwHbIpYleUre+adrVSLXgIeL7olAdf9WjBZQJTLBWFyu7db3boy0X8tyUtIUDfiH3+337M6xcTq/VJXrTtbdOBBOE2F54ldsMV+dybZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAjyLY+w; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAjyLY+w"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485ef63b68so3732662b3a.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786043126; x=1786647926; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iwmpFeilXycTx4SuKxILJjFBoUF70sEwOlXtwOhnMpM=;
        b=hAjyLY+wzGXtQLSzVPqwmFHXzTgyKG9NYn7oid1FYtPNImAgo4201jYeNQStkvZKVE
         EF16fNxT+W1peVgpnMGIg3yOfIApxlid6e1QL/wqWG8H4SfWLo3s+hLxS8pJUIVJMS2I
         EfWFLMRJZJOR1L191FKIcxsQieAUqY+p8wvIrrlxa33oDthF6caAZwzvPC+D0N6IdPYZ
         +v9JYvQoHtkaKoG8sT2Ji/7/+XfWI3MsCkvx5l8jQAUFhYSFjWYKvub0EkOCcqcg+G+s
         jmwaHAuXBWsIGREXftrllvsaI/orT+nyRl85V2fYbkRm0MQeHPcdC+owZ/jw90ghovzz
         gySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786043126; x=1786647926;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iwmpFeilXycTx4SuKxILJjFBoUF70sEwOlXtwOhnMpM=;
        b=ogdqNPbpScZH3d2Na4NGLX6r1D1fwIrQi+iFs8iHptiCbrQsntVUcJkwJKzlOWPBIL
         CI+SKFXLGp5CU3L+HjCpMpCYoHQApBmvuWsYU0Jn79OngWPK7awY0EJcXzSBsfNPYu5b
         Dj4eZv17Ie8XvbOefr+ZJNVywl7bLddlgwuNKtkza66iJ2vHyx3ioBpNml3i8jSd9tNr
         kfru4d2Pp5KDw+0RWfuLjuNxZlLehTN5Few5jQDslMY17ZHCklpTb3Qmv0kEwIt35WYX
         pITVDQdklJu7IhFy+ZmNNjNueBMZ7aRbrdoDgoTf3+/+WXwxlmAfJo/n5yg7RQOH63Bk
         lzsw==
X-Forwarded-Encrypted: i=1; AHgh+RoW5iGNHSrHpr6kiY9DcVXPp2CxoIX4UIi7AAZQLwU96kv3wpddXb6L+kDthMNavd63KAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7v49G0pTgTeFTK07ygib3Md8kC86B8JcGEhGfTOXez6LaHPvl
	3LEw7jgugMX2tu40fJVca5hLZ2n+tRZ8TJYmbRdLoBpZJO9gFU2OGTwf
X-Gm-Gg: AR+sD13OTEcBrxHf/oDyWO7iYRhidW4RS/1mlcJxnbWhiZ+h6JXPMia721SUXDo7vIk
	NysXqpSLMphIpOceZTzr3THnRl8/JFibGOhgGfvTP+IPmkIbGzV7XuTeGuZJXwVyxIL5a2TUORL
	kQ9VTXnag6wCSsVlQeFUzfOeHJiPAZEornIqQpW/IX3eNdQDOCy2jlyE7xbc2XTVeFuZCyzbegh
	w4aYcD/JEOAvl/o5pNl3VlSSaY0zmSMpItBdLU6F9QTHGR1fiQveKx61c0j4pjgf2Fo5yBCzaWf
	+qdjn6PPVVWXUIEcWsC4Jj8S+Mpjnsg4DGOIHYjjR3Xg/NPC0ZzExDdj2YQXz+vIk06dzPf6dvH
	SFEl3uPkOH8+QyAjq75xsOgLlgAoeu9nTJ4ak8mT9o9XceNTyDHUeS4Y9TSD2g1tgrUNcmbg7hv
	wf+1ZMsrmpXR//cvycc7ZAKEyrDv/45fnx+xDRLI6o5LS5g4g3vpJ2tJ+vcjAfvwdA2H57J0gFa
	L4jFHgQf8UQIJ49
X-Received: by 2002:a05:6a00:658b:b0:847:8ccc:d7cd with SMTP id d2e1a72fcca58-84f2e0ed95bmr13739022b3a.37.1786043125950;
        Thu, 06 Aug 2026 12:05:25 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45389e75sm1915451b3a.2.2026.08.06.12.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:05:25 -0700 (PDT)
Message-ID: <8225c3b4b2077c0fc5a86678d410e68ac6939017.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] resolve_btfids: Deduplicate BTF after
 btf2btf transformations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Date: Thu, 06 Aug 2026 12:05:22 -0700
In-Reply-To: <20260805230648.2354989-2-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
	 <20260805230648.2354989-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 16:06 -0700, Ihor Solodrai wrote:
> btf2btf() adds new types to the BTF: the KF_IMPLICIT_ARGS transform
> synthesizes an _impl FUNC together with its FUNC_PROTO and copies of the
> kfunc's decl tags. Nothing deduplicates them afterwards. pahole runs
> btf__dedup() on its own output, but that happens before resolve_btfids
> sees the BTF, so any type the tool itself creates is emitted as-is, even
> when a structurally identical type is already present.
>=20
> Call btf__dedup() at the start of finalize_btf(), so that base
> distillation and the by-name sort both operate on the canonical set of
> types.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Hi Ihor,

I'm curious if you had a chance to measure how this affects the
resolve_btfids running time?
