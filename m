Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B638F950
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786862085; cv=none; b=YhUv8+WN7Hyw31EBg8PJxaXsnNAM0H9gJHWOJwXv5F8k3hNu4LS6bx6FE+7pvOI8oSW3duvJvzpqNMdBPF1M3u2RhVdXu1kVRvz14e0m99DHSTgtIlqJ1h++/NMBEXZZQwVieJ7rFVoxeb81wmMj3telzjWsGH190nDKfBEwTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786862085; c=relaxed/simple;
	bh=Qs0q8evrKjwKuuQBJitD66Q6qPLzb3tA9HljaLjprKA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OefOwZWDKcW/MrjUW/E+iiStFT0PYWjYh9WTJ9ftax6zPB3kxsEEA0gb3/PbCK/3oFUtlvy1KghZvufIKJqK4oElqkXeW6JwQGPyOE6eoNHQ/PSJxT/g75msHMldT7VRx0nUpwsPI9rGvlVCMVi9QK/waxwkZIUD8rcZA5mQ70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyP5jeto; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyP5jeto"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc61541f8cso42373975ad.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786862084; x=1787466884; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UoQtTiJksW0nvGPhiwf8eItL0RTJA2e7q8c9FhRTlRY=;
        b=XyP5jetoRNi9FhaCuHz4Pyr9o21edUCH0+1G7dtUdTJhx99yK3nqRT61hb5foshYCz
         gBPQ1T7Len57WR5Jvg12huR0PnqusvmeZops2cJY/JQYAdTyfhYsPMYbITFFh1JkqL5n
         ezLmmDwBRyXRat6PIeRLNzg2w5XSmLjPKa/vzlQ4EeCFmZTHwczjr1v8ncZLDG3gUotO
         721R2Ehgyv5bED4ZspURiuZre/kWKc0NoRWG1J3WX4xqr/InFmtmNmbmV9/Bozj7tkUn
         k6t1EllaNr1VboPqBFlieFXFF3wRzcfXGPIqwDoL/ZL9WV7PAqxLHXDOVhGhJ64bA9Ub
         dogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786862084; x=1787466884;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UoQtTiJksW0nvGPhiwf8eItL0RTJA2e7q8c9FhRTlRY=;
        b=L88aQ4sI9xvaN8Ckiz5cIvdW+FQ3vxVEuWk10Ud8usarRShPjQ3lY/Rd5cNzpAGmkq
         cWZ4h462dskIh01oD1CLEqivZyCV6/soLiQTX6Odd2R1Qc6jyDpx2xNYxYl4KLeLJLiu
         s15ty9F2Lh/Rwnjw3Vf77kSGfZA6bJCSvBr6npv1dJ4W8DvXk20btYAb6MftSvd7SOO0
         KRhD05M8Uoe50SBNyyrcUOGY97w2Af/Z8h7ndSqZo3Ylf52ojmN//a/nrcGvgWZTvb8w
         cBkPoUKAbRJ3F5H5qD8pWT5+oiCCZH7gLiljxdyD8oYXNBlIB9Tf8iznz7PRL9jHTcgi
         dFwg==
X-Forwarded-Encrypted: i=1; AHgh+RqG9UxRpauzS+dBQTExO4Ed2l4OMNyOf8l6FWTPlCuJeB/hKxsP6nrvRmxNCTmjXBo8GNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcGxe6wbHufZk5CpcQHDE2n84uChHZqQBVY0JTzA88z8Ja9P8g
	+kRRhKxJhWaWRg0NFv9WBfe/vf0GPqHypE8j2DPsprRAPPjJP3ZyY0EV
X-Gm-Gg: AR+sD13SepzP+vOMeIfzfbWxtNEKdwldc5csxQN/Bwqm8LR8bqIontUE2IicLgqwE4e
	dtU58r+XDTucStDaNUFl70kaTO+BV0z1SPqFrWdsRafyuh5TOoh3sQIydxYAAERBaGrrNe9K2Q+
	3dROKlSwu176Pi7XsMPfCVM4cnIzNjBcS2VT6u0Ip2wlB4zmrqeW8dmbopJqbEkoANVkMdL6joq
	AVaIc5SYgSRJbadFg3bJlebHuPBGXFhIPa34w90ouzrJAu5mzzda2pNTvcEEg+Uhxu3W0keIoG+
	1r0jRM5rXWszMtotylBhH3xvns5dI0dpEcPhh2GKI1JuuytFk33AWHkB6QmZzfegCsR8OSy4z6R
	w0WnzOHswsN1wZohi3HSk4JAl6+IsdegH+7G4Y3DPyufvezEvCrfgrFp65aL3UA3QMNn4mumtI/
	wKIH8D/+Q4JPmP93msuqwcjpn1dbdLhCHDhwCT1u4C+Bq5XA2wVdZQPlisvohiou/SOc+7O63o5
	Z8D43Z2Za5HqZHu9Q==
X-Received: by 2002:a17:90b:1d01:b0:38e:7f22:f674 with SMTP id 98e67ed59e1d1-3933b09e9e2mr12925204a91.11.1786862083893;
        Sat, 15 Aug 2026 23:34:43 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531ecac9dsm687918a91.15.2026.08.15.23.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 23:34:43 -0700 (PDT)
Message-ID: <b0846b8a8611ae6084a1e0190c21fe93000ade29.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/14] bpf: Correct verifier diagnostic
 attribution for stack reads
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Sat, 15 Aug 2026 23:34:40 -0700
In-Reply-To: <20260816015746.2632990-2-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 03:57 +0200, Kumar Kartikeya Dwivedi wrote:

...

> @@ -4079,13 +4106,13 @@ static int check_stack_read(struct bpf_verifier_e=
nv *env,
> =C2=A0		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> =C2=A0		verbose(env, "variable offset stack pointer cannot be passed into=
 helper function; var_off=3D%s off=3D%d size=3D%d\n",
> =C2=A0			tn_buf, off, size);
> -		reason =3D bpf_diag_fmt(env,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "The helper would access the stack th=
rough variable offset %s plus fixed offset %d and size %d. "
> -			"Helper stack memory arguments require a constant stack offset and a =
precise initialized range.",
> +		reason =3D bpf_diag_fmt(
> +			env, "The atomic operation would access the stack through variable of=
fset %s plus fixed offset %d and size %d. "
> +			"Atomic stack operations require a constant stack offset and a precis=
e initialized range.",

Relying on value_regno being -1 only for atomic operations is very fragile.
Let's at-least make a comment. Or make the wording neutral,
like "instruction variable offset access ..." (best).
Or check the actual instruction and vary wording.

> =C2=A0			tn_buf, off, size);
> =C2=A0		bpf_diag_memory(
> -			env, env->insn_idx, "variable stack access", reason,
> -			"Use a fixed stack offset for helper memory arguments, or copy the ne=
eded bytes into a fixed stack slot first.");
> +			env, env->insn_idx, "variable-offset atomic stack access", reason,
> +			"Use a fixed stack offset for the atomic operation, selecting the tar=
get stack slot on separate control-flow paths if necessary.");
> =C2=A0		return -EACCES;
> =C2=A0	}
> =C2=A0	/* Variable offset is prohibited for unprivileged mode for simplic=
ity
