Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35374473C7E
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784677987; cv=none; b=SvXvFajW7t5oSzm+0gwmdjrGszEubz21WUoP1iz1guZ7cRZ67ORFmNxYD2Q8nC5k/2PJTUBwBFV8taAIyT9W1/xg6CmHej3VlAGZooAp8glyFejwjC54i2KWcCDK1+of6hfh6dXK5msuvxZ3P47a+5xmim/Qc4eEjAm+uk6wtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784677987; c=relaxed/simple;
	bh=o3/LOYhvDhaSRK4supHpFZWqrvVZAHUL1OwjfXkLq8I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EajIygO+dsSq0EIBAL2y3AfEi0NQytCGG0sFlZ34sEAV8dv11qo3ywljqZdNXxhgOewKTPWf1rOiD/U4+LkPq5DCtPIvGPRAuqyg5ULRHDDBTg9aboYQWELkXxcEiyjyGMdJ+lUBaOCX9M+5PD5VksdNG5+vqIHO3a3yUmHExxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxxjQJgE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxxjQJgE"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-382ef647e20so11419305a91.1
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 16:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784677985; x=1785282785; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xz+rLekKfe/AAP0Xgd+Iz5oYMriTqERJLl0HYz+gnMU=;
        b=GxxjQJgECCSY08QnYzjmSGxP6PhdBeUFlNHFBjBKp9Hn+KI0mKXGx2vz8zBVZlv80b
         5rDEvdjBv2dHfizn9LpP3rMryuTBV9KmeGfQzLMOtI2+D7awLZFgh45RUjTy7ERRqskI
         79z/vJIPlVyhO21GqpYh/UmBIgAUwPzEkoKqQV8Fw/F3rCxwUczGqCVswayElOQ7IO8z
         iRA6rDsSwOXdSOsHXY3y+rLVkEuDrwIFOMuXVa7+Q16L69nWiLXcMdA46u9gdltTOADZ
         qIzcqJmSobfSi8BWb95KBFOkFV8f1XBQS/OSmacZW4V6TXXUo59fyUYGasOYjxvbFnqb
         KnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784677985; x=1785282785;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xz+rLekKfe/AAP0Xgd+Iz5oYMriTqERJLl0HYz+gnMU=;
        b=U4OIdgKGSyv7oYZOIdqwM6k+2jKNBgggZkPicD5nrNhTgyeH0MlxuDPR3yBykqbJo8
         1Ay3rHp1rriLheVJEzOgTuHxZl/Vn3jHaSYGJqMqXMAce57JlYLRknINzxdSuOIcWxe+
         lutnFtNWR27qAvSQZzE3ypAB7wj2snk1dWTqJWINDyoLZWZQrrFWvrgIay9Q7U/iVG0A
         JEInQ5NGV+B2uA/u9IDTsqG2/9ZF5TlAP/34IOecZ9mTI3FEahdHeVcUatgh2YRN5De6
         xod+UB7QDzRVHta5ZB2j8PhVE0HhcIdo5LzMtT1ghSYZR2Vg82mdiBq5GvEMQM+IX6nG
         a7Ug==
X-Forwarded-Encrypted: i=1; AHgh+RpnCzbpGehLaw4gLmpsFib7f7q+cYJrx09B1fjVhZAkXZA8yaV+IohM/iyxoF2zKmomiVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+28An4vjIC6dTnA4tZKP8SQr2hM6rj3heSxFe/FSdXZywY7F
	dVjNoftLym0//FvVjmhKEOwICieAH4M2kcdENfs2iLwN+yxxnefTmhFT
X-Gm-Gg: AR+sD10DdfTp9lx0DMiDzhkBCCX0zwgEiTV4HoiChyMY2k89IKguNBS7FZgCHsoihwZ
	ZBZ+JFXmi0lCc5krZIfdtN8uBUYL0sx1+Qmy+b/+e4hxma/LIIqBDNGIGXsK35qp2GE9nVVG7VF
	Ivu18orVyJeUEimMUjZgRxPRDADxh4r4m2GkFYfsYKTTpA79a2nHdN5aDqjWGXVtkMts84rp4PG
	p+4plmYznX7f3dGrj3r6u+WFix6MgRceK7G9P3hJ3+BO5cqKsG6AYFipYOSY1OC+3X4RMN6wry9
	vlUGBYwJsOIhRaV2zPKs1fm+m0JuERPa8m1ZT52ckgI6blAohZ4KUQdPPfJOgqFpem9G8hFpWGN
	rbHixBnO6YNQmYzEQaITLLSyUas/YOc/83iGoDf/f2gssZd6kvTinbo03VltQnDd2XutEWKP1bo
	brGwVA9CQRAPI8dmHh9hqJoXx8ZAsienpKkZyuI+4mGHHI6o0Fxivc+8r/
X-Received: by 2002:a17:90b:3886:b0:369:7f25:cec0 with SMTP id 98e67ed59e1d1-38e4b2a5964mr21107022a91.0.1784677985494;
        Tue, 21 Jul 2026 16:53:05 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cda2:e912:7f2e:f787? ([2620:10d:c090:500::7827])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d1300401fsm672641c88.3.2026.07.21.16.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:53:05 -0700 (PDT)
Message-ID: <ea92ce5296ff4cacb1ecddd90493e04424dfc488.camel@gmail.com>
Subject: Re: [PATCH 2/2] selftests/bpf: Cover stack frame number after
 scalar plus fp
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, chenyy23@mails.tsinghua.edu.cn, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Cc: john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 emil@etsalapatis.com, 	bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, clm@meta.com, 	ihor.solodrai@linux.dev
Date: Tue, 21 Jul 2026 16:53:02 -0700
In-Reply-To: <b076593c985497a5f903439b864d1e8f1cd107f1561d04a22b77c6fafb3b4c13@mail.kernel.org>
References: 
	<81c5f138e510622fcf908b99bfc7000b872e0966.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
	 <b076593c985497a5f903439b864d1e8f1cd107f1561d04a22b77c6fafb3b4c13@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-21 at 10:29 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/=
testing/selftests/bpf/prog_tests/verifier.c
> > index be97f6887f0e..0483ae340726 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > @@ -11,7 +11,6 @@
> > =C2=A0#include "verifier_arena_globals2.skel.h"
> > =C2=A0#include "verifier_array_access.skel.h"
> > =C2=A0#include "verifier_async_cb_context.skel.h"
> > -#include "verifier_basic_stack.skel.h"
> > =C2=A0#include "verifier_bitfield_write.skel.h"
> > =C2=A0#include "verifier_bounds.skel.h"
> > =C2=A0#include "verifier_bounds_deduction.skel.h"
> > @@ -165,7 +164,6 @@ void test_verifier_arena(void)                { RUN=
(verifier_arena); }
> > =C2=A0void test_verifier_arena_large(void)          { RUN(verifier_aren=
a_large); }
> > =C2=A0void test_verifier_arena_globals1(void)       { RUN(verifier_aren=
a_globals1); }
> > =C2=A0void test_verifier_arena_globals2(void)       { RUN(verifier_aren=
a_globals2); }
> > -void test_verifier_basic_stack(void)          { RUN(verifier_basic_sta=
ck); }
> > =C2=A0void test_verifier_bitfield_write(void)       { RUN(verifier_bitf=
ield_write); }
> > =C2=A0void test_verifier_bounds(void)               { RUN(verifier_boun=
ds); }
> > =C2=A0void test_verifier_bounds_deduction(void)     { RUN(verifier_boun=
ds_deduction); }
>=20
> The verifier_basic_stack skeleton was already dispatched here through
> RUN(verifier_basic_stack).  Adding the new subtest to
> progs/verifier_basic_stack.c on its own would have exercised it under the
> existing harness with no change to prog_tests.

Bot is spot on here.

pw-bot: cr.
