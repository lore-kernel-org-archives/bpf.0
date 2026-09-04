Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7237D47F77D
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525932; cv=pass; b=JZc/Bk1D5bepQARRGVF2XAS0Fp4C00n5bhjZdCx4t8hmVaoPQ/sWBjuBZdt9hUPz5RyUH4nG9NOFDpRsYg20ykMvPf0QK2AjU5J7wfr9sP1yr0Dx2nG6mER9yMqN3WV0rmm/1dmnYeZJhT+90dU5/GuV3uFKby+Lo6vOTsveJcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525932; c=relaxed/simple;
	bh=SzDs2yWMGbqw4SuOTjqilOjXglSn17D0yFwlVfQoGko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VD/XVhzwzn3tsfuAENT/SxS5oNAOvHlUH4rjLJ4LrHRsfNAzH1r4YR1Xx4K854JgLi2Zo14Jc6IbpPYggP+FPZWWWQM6mLkVz8/hXeyt3CHm1bqigSTZsh7EeUaLvYI4dJLbhuRAW0nexw9PC4G+Q4ND842Wm7vHzaPGtYX/t3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nlj2Z3NM; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nlj2Z3NM"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c255c58156bso178619266b.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 05:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788525930; cv=none;
        d=google.com; s=arc-20260327;
        b=k0BTNcSE2E7G5HYXcwv7WP/zZmE/z1IovIRCtiz4ZcsFB2o3Oi2JkzBlv3sb3Q52l/
         vWM0h2Ps6yp3EzljXulXu8GW+V3NFrckd/htzz9ESOHEcrhHnKZCXMcrulUFl9kpYWRR
         rijUVT+exZ2g4J92ldQB0AAmkn9IAqmLxVLFADGLWgoduq1DMOoHrWJllmAnVbrb/rGq
         prDkhYaifNeiNZcf/jS7yCCxxqAFRE5CznZsMKsSVGULhi3J1+0+GjO4luG5ME0VdU1v
         Wfrt8cNZTO+9xNuxKJZR/tzJ7QMAS1yDViJxzV3DLLpXr9d1HICiN056AUSstDJnnEg6
         IqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SzDs2yWMGbqw4SuOTjqilOjXglSn17D0yFwlVfQoGko=;
        fh=CNUBTTp9QRi+PvJEeelSQp5MYFx8uJg+eZC6/5vyUY4=;
        b=q6xvcHHbyrbtV+rjkKfvoUfFJpHeMy5paJ7Ptg71xmKj4Tozfx2cs1ql20v33BlEgp
         y5VSq1qt+Fuw12kAcUnh7TR1cBRKUScAcktNYucLOEoYHncRdUioXSJX4Fu4De0RDiBE
         Rv0ceyUd1/xGI+GFX3mPIhcxCH4eq+boIgadtn1+VOZCSsCZWpqvNcR9oV6Uz2sjEHVX
         lAIFIoNr6aRMxtrbbI90IuZxg7e7ChKHGROv1XqiHx2LyXwZAIGmKCGMWFvc6l/IwaPL
         UTwaa6s/gcLqbRft2Ktsj/cMclw2KIR8yxqONJ9QtUqT6FZ4K9dmvwMHgnJB8OHISRWP
         qCXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525930; x=1789130730; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzDs2yWMGbqw4SuOTjqilOjXglSn17D0yFwlVfQoGko=;
        b=Nlj2Z3NMP945vYPmFS8A/T+djK5rR0QOM/Sf77FlLxxYI05mI1l0HnYr3Nuce5iSRO
         QKeS7bHvw6LjQfqEfx7Kt12GPatAVlpUaUXz7QT3xdTOm5p7wX5k/0uI4vGuzvFVmnIi
         Y2mH+HtMg7cSKyCxrFTiTSbSKon1wdYgt+HSH2v4ORuB8vU2Md2By3TeX21e0T/8OdAx
         A6DaW85w3yMlHgKOSd3JoUqx8GImv1rVtR8W7FwtyaJU6YglUD2AAXO7Y4O3Y4wujYnT
         cTAhkV3RJ3GebedisXrFdvdpCJ5VttrjAEO0NrOvFgZsri4RSE5vADGdpYTomFt5os9X
         uMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525930; x=1789130730;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SzDs2yWMGbqw4SuOTjqilOjXglSn17D0yFwlVfQoGko=;
        b=E7wwas78Di3zDCYTu+tku/r1ILm3GTslo3KjLY6w5KA5RQcPSUmoxHNYzL84+iSloW
         J5/Py4l4uj7d3a3wrvbKePYNubYpJ5wlRmIp3uCk7vQ9zj7n6atZ7PpeB3kAx9yUxL1p
         bgJH1aC2uAZc8cGrUHJ6sT2w3mXqBaSpYRlYqSwrJ/C144y8Mvul3mi6ZNYbY87SCBeU
         unE3ducY/cvf+hfCnVVxHvg7Z5DyjhuOg7XZUqbOf3Brglm3zGNYD72PogjaQMYLccKQ
         I5foDbLTKL7/yuyjnHzQVCqsZvRe0SlXeiJsKMdSYLH/ZCbmU8cpXcYuU1F3qUH2z0ls
         q5fg==
X-Forwarded-Encrypted: i=1; AKwUvBxFBMs9M01kJi/wlPcDSYTpVlNl46yeivfGbBFnHY2H/78TxE7zQ3HWh6rx/8r466EL7a0=@vger.kernel.org
X-Gm-Message-State: AFuF++kMiobETM/S6TzMkzsCriXIt0k/IEl6ej2tYPjaCQkAqtAjlSzp
	jtDjXz9u2zFg3PK+GhGGMV+iXhpZ8Mrt4DRf/R8cCi3lbQE1A8dx+AmiHIpTaLAEWhgWv8vy277
	n5zl/QWwYAPUIP9IHtqoYAhOo6dgh/7aK4V81tBY=
X-Gm-Gg: AYBFou1xsHiWoSr0z16s72EZmG6JXIFXbzbtR7OTOf6ixHITGtok2WpTa4+O3eo+P0G
	dmOOOp0vOU4cwVK90QwvfTdKkCzGbejoOjlea1Ggl1dSclPJGbMbQ2V08ck8WIy5LxCrXEVqaeA
	rEbm74hHz2temlZcu7E8FCREooWGFXy1xWKDh/5zp1KGYujcN7zctxGUxt3zFraTdghSEu7TCnU
	Z9FxnzLsIm4e+U0kAcjRCb3ogZY2h8Xbcjj1zHhV4vR1yUEXy45AaRInTXk4SIs6T7yfWujejvV
	lYEhkA5jUta4jWJCz7ahkGajNCGjDgAOIFDp+OrjTft6gA==
X-Received: by 2002:a17:906:c14e:b0:c16:2dc0:e1ef with SMTP id
 a640c23a62f3a-c260c988de0mr274506066b.14.1788525929567; Fri, 04 Sep 2026
 05:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904111731.673341-2-main.kalliope@gmail.com> <e473cea93e948db9c27dc4ae0e993eb3e09011e7cbe8c8e4b305c3b12d866502@mail.kernel.org>
In-Reply-To: <e473cea93e948db9c27dc4ae0e993eb3e09011e7cbe8c8e4b305c3b12d866502@mail.kernel.org>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 4 Sep 2026 08:45:18 -0400
X-Gm-Features: AcwNN1XHcgBQzn_feFro3WF9Vkiwio-_jIt5iIjF6wB3SyaChhdHyChwkqqr430
Message-ID: <CAJZwKkgz6h7cjeduFqh8yFsPLZrHaaJ6jp7BYrxjV40YDgnyxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, mips: Factor register moves into helpers
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, johan.almbladh@anyfinetworks.com, paulburton@kernel.org, 
	tsbogend@alpha.franken.de, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"

> Could the two be collapsed into a single sentence about why the move
> lowering needs to live in one emitter?

The first paragraph describes the problem with adding width handling in
build_insn(), while the second describes the refactor and the state owned
by the helpers. I think that distinction is useful, so I prefer to keep
the current wording.

Nicholas
