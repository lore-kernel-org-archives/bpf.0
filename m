Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D81426D0A
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604266; cv=none; b=hO4g8tvkx6P0EmMquP/gZc2tXb6pa67Y0BFY8gk8Eya8neJIleqKc5aU1kSDCc5rdpHhlncx0dnHD7zUdHMwJglXMoEjwP+TDuQXbuthWnoQBNvhmyN08QxVojlqUcp+ed9bi3SCs7/F63zp+h3niNgSSPFED217B3oaI06M0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604266; c=relaxed/simple;
	bh=TIIjdlJ1X8AiPK1RSlH0x9/gUJnCBnzteMJ7p4ST+kQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SmJHHGhwslkDdQFG0X9OMwlJ1Rwm78Hve9Joxg3kgmKrZydXktFw/OkfgDXHmysrLo5YSCMoyKlixdH8X5VC8raatmR5gHZS73vepycvK/WLM4YBIqs2L9zJZKvsXkD/aVVeA/6urUV0vwqs1hgnMu40moR7itzRSkyxoavxJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aLdyCTz8; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aLdyCTz8"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68c1630159bso4644165a12.2
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781604263; x=1782209063; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mcc40ssZ1K96Uavp2GwOvrRk3/YMLKSUvUHIzWqkOLo=;
        b=aLdyCTz8BxLb2pE1vibPX7G9oJV1/kj0dy8k3ph3UnhioQS5hZhY5lD5YX+9JE8uOB
         Nqf4kCfkyaxnz/Zm6N8mCDq7Bxn9uWZP3Bip2K2tFoTb266D/dv48U1iGi0rULXS2YWj
         vZjAedcZkYI7uyy8WAqwrtTMZApuJ7VirSnUjUyUVBGSkHhxwGW3lvQskcEd7Kcdpdps
         /Wr8zoy7aVQR+PddCHSo0/y2pIu4BpUlddj30UuTGtbmLO8hll2KQt9UFgH0MLtEAros
         1S8Y0tRUXC2p3M0PucOuuEL6euv9cXR3bHRQCVkhS36Ptbx1KGZ/HvQsJqs98YSd45Ne
         gSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604263; x=1782209063;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mcc40ssZ1K96Uavp2GwOvrRk3/YMLKSUvUHIzWqkOLo=;
        b=dR05/A8cXFq5/aW4cAq6JbCl0pMEDnZHbwnhzcWRpLWUcoIo87F+bbi06JgS41V4IM
         6pxnPs9i6EKZJolbwCCo70bAchrMIL/2YzLeQkwHI0/OxER7nPO1xvZZE6weRpMOf/kg
         9dI3i41qFCoJD/+sE3hph0JQpuSDy7TYaoqLcNo0vuVOOEmNojKYH++cFP9RQnWqZ36a
         kFykW17m0kBOC7DoWQxCqmIqIIb1s3uW79PYJfNzALuUZ1UW/cOUW4sooJNGqup6Sr6d
         J6bPKVhJ7Vcj9+cidPFth4gAK4ehcrOQWuPmTsFxAI6VLjbEVJy/SGmIJx16zWU5trmm
         NPsA==
X-Forwarded-Encrypted: i=1; AFNElJ/E3driduOp6Sl3UPEzvO/xHxYtQPIxvuQgewutgd2HXHzCpSJ2BGJGE2mNxCRYnA6ZcLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk25Y5ZBuhpHRZYBy7Ib3A+0bUwY6PX/fbBWTTBslZzS+CGkKw
	p4S/l6l95Jtq+76TNlG7+wuIT74gwQNbdX30J0nRPtYOdtCB9El11hrfm84m2bJKsFk=
X-Gm-Gg: Acq92OH4VGAQ5ZELPKOrw7aXjtDRXKJVFLH1XgqIHPz7xk2HH3OcnnOeUyjCk2VGCuP
	Nv2j1tq6sXVFqsRvLZFxlBhIXx9KultVjDTu37zdF3ZqhgMnEh47vEl28G3nnKRH6kCryUOVBIS
	ejJYv7Nn2Dq4ipi+vFvZRoF0fmRBxVHMwKKugTwQ6BqblogWS8MvQxUW6Nj4KEVOy2a6o//FIma
	CXo7Lm20KNwxWtTvItTQxVCjXWaj9gX7UW0jpQ5YfVrnFr8AvBLSEH+95P+huM0Tcj441Obe575
	fR/vdj7es40Ck9/aMH/e7iDrmED3o2zsH0M7erDtqjdZPFyXXnNqxLJhUW/g/QkA8mDN/DER6pL
	0Ttj2pqat7vxUJsQhARjWx8B5GNyVdl59eVboCZTlM19YcfOgxOkNBKAnnjjZXRC0qbrDJtBJOe
	UJJAVjsYi9XMfCb2QR0Z/uOYMWXw==
X-Received: by 2002:a17:906:209a:b0:bfe:ed06:565e with SMTP id a640c23a62f3a-bfeed065926mr404990866b.51.1781604260716;
        Tue, 16 Jun 2026 03:04:20 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb8341ba5sm623905066b.42.2026.06.16.03.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:04:20 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  bpf@vger.kernel.org,  john.fastabend@gmail.com,  sd@queasysnail.net
Subject: Re: [PATCH net-next 3/5] selftests/bpf: remove sockmap + ktls tests
In-Reply-To: <20260614014102.461064-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Sat, 13 Jun 2026 18:40:58 -0700")
References: <20260614014102.461064-1-kuba@kernel.org>
	<20260614014102.461064-4-kuba@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 16 Jun 2026 12:04:19 +0200
Message-ID: <87ik7iby3g.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 13, 2026 at 06:40 PM -07, Jakub Kicinski wrote:
> The combination of sockmap and TLS is no longer supported - installing
> the TLS ULP on a sockmap socket (and vice versa) is now rejected. Remove
> the tests that exercise the combination along with their BPF program;
> the file covered nothing but sockmap sockets holding kTLS contexts.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/sockmap_ktls.c   | 355 ------------------
>  .../selftests/bpf/progs/test_sockmap_ktls.c   |  61 ---
>  tools/testing/selftests/bpf/test_sockmap.c    | 227 +----------
>  3 files changed, 1 insertion(+), 642 deletions(-)
>  delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> index 6ed8e149e3d5..cda6b22cf759 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c

[...]

>  static void run_ktls_test(int family, int sotype)
>  {
>  	if (test__start_subtest("tls simple offload"))
>  		test_sockmap_ktls_offload(family, sotype);

Nit: We probably don't need to keep this one test around.
It tests pure kTLS and overlaps with selftests/net/tls.c.

> -	if (test__start_subtest("tls tx cork"))
> -		test_sockmap_ktls_tx_cork(family, sotype, false);
> -	if (test__start_subtest("tls tx cork with push"))
> -		test_sockmap_ktls_tx_cork(family, sotype, true);
> -	if (test__start_subtest("tls tx egress with no buf"))
> -		test_sockmap_ktls_tx_no_buf(family, sotype, true);
> -	if (test__start_subtest("tls tx with pop"))
> -		test_sockmap_ktls_tx_pop(family, sotype);
> -	if (test__start_subtest("tls verdict with tls rx"))
> -		test_sockmap_ktls_verdict_with_tls_rx(family, sotype);
>  }

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
