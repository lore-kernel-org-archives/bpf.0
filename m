Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30448448B9C
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704335; cv=none; b=Ki2VVokAPo5CR0YctTU0s0TnroxeYG649pUnDl1hjj2psebVSMMmOwrPEYYO/xGMpS7BnzDr+8/nHTFfsBgBj687uJ9hNgnhpXHFhQ9j9qZSJfnXa0Yy4oqk4N8gkLTiMYPSdQ+7aooX/zUD4sVmq1yA3RBl6IjPdy1UMKZTDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704335; c=relaxed/simple;
	bh=cfQ5psBdFupVgEA/ciXkWuRtVmhgxSgdnNDh4pIrvSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e2x5C4B7QLya4c7xbqmj1eEbSyv9xkFvOPFzoUMUR/I1hgHOQ24skHb8yGylxLAwSS1KoSZQLX+bLznf4za9TY25/zboE1ddTRfUyeqiO+u63e/JUBQLX0OzVUa+EZHwvuWJshSLQOw3qlTbetjHJkvk2N3oeltT4cemVLOQdIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RQ1JRHOi; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RQ1JRHOi"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1c52d920b8so118797766b.2
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 03:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786704319; x=1787309119; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cfQ5psBdFupVgEA/ciXkWuRtVmhgxSgdnNDh4pIrvSY=;
        b=RQ1JRHOiU5EIR6nJ+NwgjYLdkCx1rJZfxxTkIBOQTnpSa0PQ0rRbm6JrIS1vIC2C/x
         7zvY12zx0UzqrKx6rYc2suzs5KcTGA2QIJNNZ96F2rBC7OO99BCmyrsNEkcoD9X9nxw0
         XJShp/RZUWbsPaLFaZACpW5jx++/VLttd3W61yUdfjGe2ltqGS0phh9yagcusjWw0GRz
         3RMtsIvVgTvPaB8nFxx9O7ZNYvuTZEY89e2Cz48HFFQldYIbm2cyxb5odLrJewofGwoT
         FjLqkwlmZflfrj/pOA2T0cAHxHEYI9EhFnq4wruOHDhzQZ2V4p4VneyFu2tfd91XrMr4
         +TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786704319; x=1787309119;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cfQ5psBdFupVgEA/ciXkWuRtVmhgxSgdnNDh4pIrvSY=;
        b=Cj/t4eIfW/xH7GXJcdI7WaPOes6yqegfzllwEbxS0YlNsPiFoMv51PAZ2QseXohI3l
         dFGkGaikpjmPFY5wblbyjipLsWY+u7bFHAXYYkNfiKWKK+PoURlZvbdaMUex9TuLgmJD
         9dkFo/LZcScKP38iajuZwQidcePqda8ZTyroin4qydqy7Cc1ZLeSYGbqlbw/6ezZcZz/
         Iix9vJUWPvxfeUxfbhAvAdNCo/Bb3++2ZIZjO7QqPtOVQk19sAJq/RWwZ6xPeo5HB/Ld
         /kGyesCR0lUuldpEMORqT0LdIa6dbZY1wyb4DriDrjgL7EVifDRkCK8V7BKPybP37E6/
         GecQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbYblcVd1h8BGOTI8gFAkvTpgXicwHq8qmvQCnArDmJHfrkjUM4OC2seA2FUXIG3Hyaio=@vger.kernel.org
X-Gm-Message-State: AOJu0YySYAf81tC+hNpB7L6iOE2r9xIR/VTynMrr29cocFPYWIobdpW3
	xPmZARvRnYZz5HJeJwy2K8tvy3VTq0Y3J7hLvDRZRb9cJlU5TkYmC2cakvCaGANsCRw=
X-Gm-Gg: AR+sD12M6pE4THDh4if/UI0oSGHtCdgnxAAfUV6M0Fv3ec9HNwmE6ohM/rH8drzHH04
	Eb/jt4hLm8wisOo+fdupQ0nyTw+ksteXodmMuVQCvn1MKlJ6NXpQuspk+CK9YDJPEMiCzsJLVC0
	uCU0GYxMGImBCNH1pJf9l+UzT+vEURvff4kyqyAEiwsppos20dj6OvJyXICThNTNGGlV3xF87dD
	QMPVed2CpViYTxRmyuGLO8rz4jmvSeM0s+lToBIDdtRWajENtaTTBQO5SZesjK0BnhuaKrcbihX
	E0cSYnxrikejd36VgOcxB91IcEvhc0w18zRr/HZdG0KSbvZ+I5BN5ZKWoH5+VLfOCXPkwz2hZBV
	LM4TYLtClKoH3cRAcZTxzwHI/G3IxYWcpRmQhAPfjQhuPJ2a0qzI8LFhnaz5+/aX3CoXLCGzw2u
	h+7mgqnXAUxE7MP5mRRpV1dAvK9Oasq7DmZ4n/nu6scnkuSY6MYEXbGwiwaGqk9So=
X-Received: by 2002:a17:907:3d0f:b0:c20:f913:9337 with SMTP id a640c23a62f3a-c212a265c29mr206885166b.20.1786704319537;
        Fri, 14 Aug 2026 03:45:19 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21233a08f0sm94381266b.11.2026.08.14.03.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:45:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  Ihor
 Solodrai <ihor.solodrai@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Jiayuan Chen <jiayuan.chen@linux.dev>,
  Kuniyuki Iwashima <kuniyu@google.com>,  Willem de Bruijn
 <willemb@google.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] bpf: Cleanup & optimization
In-Reply-To: <20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co>
	(Michal Luczaj's message of "Thu, 13 Aug 2026 14:41:58 +0200")
References: <20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 14 Aug 2026 12:45:18 +0200
Message-ID: <871pc10ym9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 13, 2026 at 02:41 PM +02, Michal Luczaj wrote:
> Non-functional cleanup and a refcnt bumping simplification.
>
> Series extracted from a fix attempt[1] currently under discussion.
>
> [1]: https://lore.kernel.org/bpf/20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co/

Discussion seems to have stalled. Or it's just vacation season.
Anyway, I'm fine with fixing the refcounting your way.
Merely wanted to offer an alternative idea for consideration.
Thanks for working on this.
