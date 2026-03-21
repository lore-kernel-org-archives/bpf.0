Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE62BEFFE
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124682; cv=pass; b=IdU3OrjCxIT8P7qQrRK/nUZ+VO5oK9pTo84eZMAwe1NHQO25qqn6lLtWrS2BbmTWXuylREekiOIdJvYJLp+Lb58/recZIyP9xgaxP70HTTi7fnfb0dzpqZP2QXp0WiUhe3W9smMv3Ea8u4Wex31xqkm8XRbaUwEb1x9sywci25s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124682; c=relaxed/simple;
	bh=pfTu0XlDAbBXU/QNDfEPiH0uyXMFSCPtlFwoDj4a+5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LogGQzRGjjuG/qXWbE+eTfeAEhAUDJiUw4Y7upLSKznaRFC2PjNMk9qwUdBeBNCf2dj57CM4vnztmCNVTtebmlt1jb2paQAHVoVmN0++S7/7PizfFPVj2kxbwXmSA/PzccQu7moqhfIxmpEvp7NxCinVDNIlGnx9nE9YAE+t+dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGHzC7To; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGHzC7To"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43b4121c40aso2107357f8f.0
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 13:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774124679; cv=none;
        d=google.com; s=arc-20240605;
        b=jR7AGRzPhheIl7IlH311ygtimWYu99weOFrbq01m4IEfC3N5x+kHJTPLMARvXt8gHI
         kwLLcxGxtbotvqNyTvKhQbM6nIQuoztovsy6Kskh4jQM/UDXvP5C0kG0jGgCZRPOwKKM
         rIZnCfXPIYdV5tu7z5b/FQoBFVoOy0W1dQ8hRzyrh3qvBQpLhyVm8A3oHmYIWvk7SYUk
         Ja6HwmlkgRR7Kv5ZwtIwm8qU9OoaQRRI6rDM5fjEdyO2F2AG2ZYyoRFGMrlW4IKUrKfO
         ju+TR7jPE0bMqkf8t/Yc1HHz2HbrGwnKuI6tA9+k12nrrlCI1r75lNzZFumXYXJld3jd
         i3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pfTu0XlDAbBXU/QNDfEPiH0uyXMFSCPtlFwoDj4a+5Q=;
        fh=21xPKL27vVVhu+AF102Gbu255DuKtSOPyZSQ8vTx1KU=;
        b=fmAgxlK0KDKUcffmEQytkfkc3XphwpOwiDtCXjep7hwhW3FN2JLbrU0IDBiyGezuZQ
         weUMuL7U9tHE441vK0YAqW7o+QVp8OG9SFTt54QPLBTi1DZHyvJLszj97EDjUlb+SpmK
         RVm2V2mbRvWxV0QKLWuRy1PrTJRUKZ7o+qdKskvbKRMMZ+xa0uMDRuIWtbIel0q+qHCm
         McLDpKtPKmqmjGr2P5kWQcnfm+r3hU1RA5kceGiUMs6jhcRkktpUczMXYPYAjSqG1icF
         gwKsEvph7pQzGhgGbYNnJTADSaM0z0N5FGI9i+0bnhXImu4wadvlnkCWNTozWh54CFd2
         Vo+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774124679; x=1774729479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfTu0XlDAbBXU/QNDfEPiH0uyXMFSCPtlFwoDj4a+5Q=;
        b=KGHzC7TovKu5MahnGyueFSeB7vh3hTxNhC39VvMsQleyZSyEWau0xZ8R7zJuxGvyiD
         EYhh5Kdh6dyR7I2fBZVnGlqto9l2v21rhhw7QjTCvuU7Z29zYoDQ6vVnmChDwZ5c37ie
         jIH9JKVCvHuPRBVUCEmJKckwF1eZBmyyW2GKxko9jIv2pZiS7vRlXAYKrzMdwy+NqxN4
         ehv2/jghT4osPKf9LiY3Biith12x0jbB+IFp1e+LBmN7qPW5mf19qkH0y5+8wThgKXXM
         8EFf5JVEfCMRX2p6PHYZX5Uc4NEyonrfQsO5p70KJ+v7UDJh1ZXnXKvdPqd0NeQIXJtR
         Genw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774124679; x=1774729479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfTu0XlDAbBXU/QNDfEPiH0uyXMFSCPtlFwoDj4a+5Q=;
        b=GbjlX94JaQv/3ju7fFarY1MTOme3g74vGO9KI2WG6QSaUBHjHAnMg6D7r3Lm+KTqvu
         cNLn1mwEaw9WlBeTm5maFbivOlmyfgIe23LoVygol0UVBH49Bwo2RJKO1qsa/QBTucvN
         wYZW0dxAW/VIa+8uPRRA70ZbjueOeZgLfPfOrIqZcMSoRf7hgytvkS/GWp2SQGT78D23
         qP76nW6encZ0TskVFM4sTt/mWjtI1EwuUwRWxdTR8lgt2VV4vk1FpTrFyFIG7Fg49j/h
         bouXsWmlnr7LkVCeDvSgvD4BBEftdpSUZ++iZGiIQS2dV3IAh5iVOxauZ03xuks8zugQ
         BZcg==
X-Forwarded-Encrypted: i=1; AJvYcCV+PFowGCuV0GDigX/IMVBlGKZ2EUkXLFruiESR97CvjYxF07m0UF+LL9qj8OnX+ChROxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlkLlnIu2KVcXuOcFoANE15jXdW/JYmeZ9XxLYgJljjS9opQyK
	9SFrbTdmA7uozeRY4abGhJs3bR6UONK5FhecPefOQc9OV+4P+Z6iytsILiubwhgFS/pgor8Njh1
	ikp3QqmP+wdDL2EscHxx95zntapjKvZg=
X-Gm-Gg: ATEYQzyIHqN91GhydMUhBqOvnDU2mjm1c+EgosYttbAvWyce3RYVpL+ngosLlQ62uHh
	YUGI5SlZw8jQvs/2aHSxr3Ua6gLBnUOhbJ7oN6N32h5BaCMxNQWEkuri8HxBA8grgyT8LjBOnWN
	zLFaeKbvFtm3jQzCFVAmHp0tEX0XavmZiPY5YtfoTZVM/Mq0i7bAHnjt+XnNS26D7CKerUa/VOQ
	jFneNFm1c2IY0JF/+iH0bdACib+oev0lmLvaFO0AdgWk/8E7QLID9M2hzkNmh69lTwtfUR4r4sp
	RtFZAxmXQEPP0jOvWJZVoCzTMPn4n4cvMR3z626pyYpjdeRjWCFvLQuSJ34=
X-Received: by 2002:a05:6000:26c5:b0:43b:50d6:4f00 with SMTP id
 ffacd0b85a97d-43b64277fdbmr11128450f8f.30.1774124679031; Sat, 21 Mar 2026
 13:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320130219.63711-1-keisuke.nishimura@inria.fr>
In-Reply-To: <20260320130219.63711-1-keisuke.nishimura@inria.fr>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 21 Mar 2026 21:24:03 +0100
X-Gm-Features: AaiRm53bVwQ534i5qqMR1mjSgGTHbgxpURTNQ_YpJWS-n-_xB5yfJFws81GteuI
Message-ID: <CAP01T76OgruOT788VhAJUaTi3Ktqh6kZp031EWJ3Gb3wP1YZMA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix refcount check in check_struct_ops_btf_id()
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 16:47, Keisuke Nishimura
<keisuke.nishimura@inria.fr> wrote:
>
> The current implementation only checks whether the first argument is
> refcounted. Fix this by iterating over all arguments.
>
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> Fixes: 38f1e66abd184 ("bpf: Do not allow tail call in strcut_ops program with __ref argument")
> ---

LGTM, but please respin with a selftest.
The expectation is that it should fail when the fix is missing, and
pass when it is applied.

pw-bot: cr
