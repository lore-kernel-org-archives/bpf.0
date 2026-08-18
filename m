Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9730CDBC
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787077321; cv=none; b=qhwDxAbdv9kmpNBg/xUve3K25foUz6r5vH+pD+sUljwJ4gmRhaExpsk7c/WhB+xj1582OgXjOgKkYjU0Vwg5OkCIF2BZOUfh16ziLeusoj9XdIKeDP5OrFGE/KLrtr3ZkhzML6rfeWjuKNS+qyoZDzM+ukcbcHdfHSvT9SBMoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787077321; c=relaxed/simple;
	bh=Sth/kZ8MVgOYjAxNoYSU+9s86ZDZqc/jAQGKdJyCTlc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D6/7y7qYgGY76YazvY1x8md0o4LxAYyrYgaHnJWGGf05aNkREwu1WE5q02uUAaF9xxvM6sgr6HMVaB7alo3sw4RbfF1f0tapW4LPWuLjAhPhdzCmj4VnZFeEVaJy60O2NUgwTH3+Xw8pl67wlB5FmySHgg/QaV4juctV7lG0cE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCt3yWCJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCt3yWCJ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbedf433a99so75357a12.2
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 11:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787077319; x=1787682119; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Sth/kZ8MVgOYjAxNoYSU+9s86ZDZqc/jAQGKdJyCTlc=;
        b=mCt3yWCJ7uKm4pnXxNnD76v93jjI8yVYgXDqkYoEHCORIBqOaDpaZdI9D5cToUr1yF
         EUbpqxYIM8pbDIU68LfWfezbN0y/yWcbqwirCjg08wKwGtbtbKTBr4hAjWeTtFNfJ/HX
         roApHqECxbqO8ArBVDL7XfhIPBc4uTqb4v2TdMfi/Ss+A+C9Nq5tTuwfa2/UnLGQPXuW
         vGohDc29OA0i02tLxLw4bcpbq5r2JNpbKaTdj2MIEDeuKF+e8JoUFMjB3GyZ+Dfy+lib
         DjiZearSzXbXO414cCIPL4k6vdFS3XyrW+23ULa2Kp8V280+jj6CFAQ+jxeWDjU1xj6v
         VfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787077319; x=1787682119;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sth/kZ8MVgOYjAxNoYSU+9s86ZDZqc/jAQGKdJyCTlc=;
        b=BBgmAn2WqSsoVIZsSDehS/DWZgcpK9fdmSQkBOwimIfb18aCTVZcFInQKtlUhL4aUE
         KQKaFB57MSfY5EnXaMUNqY61ZY/q7J9wXS00x6aveRSHWuu0CLVurCzvc9WetWSFUERp
         AEC+hIIA/Ge+PpeuIgkh0JL/s8qokYsYKyeGTrntxshIkuav7vzMwpZB9vnINFM+4VQO
         60dVkQZ/AZYtRLKB8jpAvwBKZe1Lk3QrenNkWBBesFCYkepmWP9UeryfMy8iR1YvGK4J
         MdhnUaU7W0PpYRawATV5cvHPgUa/VTmuNAVfcTCzqWeltFdyzIhRL3h8PrTe35deDPxF
         UeSg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/883ZHfFRrOBJGaojXHI7O6Mqh5y8H/lKy36XPdVWKSk+wUnsrpG6dgSQcraGWtv8utg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYWqo9NWjN+hOWGxDKZAxSLfc31gCJdpDEGbha8V8Flf3VI4mR
	UNF2/JwXvfPtHU2GaHRusGHLIcy8rND79KEt5PFUfXb/JqkHpTYZ/k8riLALEK0GKQk=
X-Gm-Gg: AR+sD12FDRBfHq8+wTS3qS2P5uNJTc5EvkjJkq/KvozRphR9DyFP8yVQw3qNWTXtVWT
	GPYIIbfIEZgAwTDrh+zdSmo2MPVrjAW3l2lpCENg9UYrBWofic8ThNFbbCNl9tAS3JPJoC4SUEG
	SDYRlQFIJ8bkZ/gEWHIiRbBfkhUeIGKt8JtJNs6T0KdCbwF84S9pALdCK+3yhkQodv/6pJhFw1s
	p/v5dgGxTdo4yGnKYGSRcHPUAf7Hpr/2KbEdcAE1HBJ5DVGpXBOrzFilXBTaOYWuEFMW1zk4I3f
	BOMoVP1H539P/ZoW96/Xuj4n2l3AHcdYGLzir1iQXHI3wLofKegwhh3OVimtrV1x+fbLoo4sKBh
	HltPxeSNPJkDx0d3xtepEt1KxPHdcU62TT8Pi7cLNEexididnBrE0FNt197racwX3FssHhhtjNR
	sjwzrwtI37bXFolaZfdg6oDVy/T6Hk3lzzykM+SdiLMt+gZcwRzlIuQ5svmDUC5halOj2CXT1g/
	u/+zy2GKML4up+3
X-Received: by 2002:a05:6a21:3282:b0:3cb:96dd:2477 with SMTP id adf61e73a8af0-3cc719c7361mr41583969637.8.1787077319030;
        Tue, 18 Aug 2026 11:21:59 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13c036c50sm2476285a12.26.2026.08.18.11.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:21:58 -0700 (PDT)
Message-ID: <5529c8e66bede975905376e701975c52d4dc6e86.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 04/10] bpf: Handle R2 as a return register
 in precision backtracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 18 Aug 2026 11:21:55 -0700
In-Reply-To: <20260817042202.2288574-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
	 <20260817042202.2288574-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 21:22 -0700, Yonghong Song wrote:
> Precision backtracking treats only R0 as a return register at a
> call/return boundary, so once the verifier starts modeling R2 that way,
> marking the second half of such a return precise would trip the
> "unexpected regs" checks in backtrack_insn() and reject a valid
> program.
>=20
> Marking the upper half precise, for example by branching on it after a
> call to a static subprogram, walks backtracking into the callee and
> reaches its BPF_EXIT with R2 still set in the mask. Handle R2 like R0
> in boundaries where a call defines the return registers.
>=20
> R2 differs from R0 in that it is an argument register as well, so it is
> part of the BPF_REGMASK_ARGS check and has to be cleared before that chec=
k
> rather than next to R0. Clear it unconditionally, rather than only where
> the callee or the kfunc really does return a pair. That gives up the
> "unexpected regs" assertion for R2, and in exchange keeps backtracking
> free of any BTF lookup. Nothing is lost: a callee that does not return
> a pair leaves the caller's R2 uninitialized, so the main verification
> pass has already rejected any program that reads it, and backtracking
> is never asked for its precision.
>=20
> At BPF_EXIT the return registers are sampled before the callback path
> clears R1-R5. That clear does not touch R0, but it does cover R2, and
> running it first would drop a pair return whenever the instruction
> following the call happens to be one that invokes a callback.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
