Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219FF48989D
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542052; cv=pass; b=F4TqbrjDYcTy9WhbRecBnUyeoilMnL0SlAVe6RBb5IhYmVIc/jYNHCuZ19Oq7NWAynunDFBQovDrn/Bqqr8iCk4yDatayNT7fUxNiPlJ18O2Mf1uq0yoUjepWJ335YHO09RoL7FMrIKApGwuBk3oDLAh3o3ej2Iu6bekUnzUc88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542052; c=relaxed/simple;
	bh=z/QbDZxnwC+/tnRxJxXRoQCvXeIFpTjZ0hFagL/Xcu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrFjhZa4USIYRJAMvfSGjZbqGH9Zf41fmtN/m8Tku8r39oohKXCV2f6qiV2ZZG9vAU+ZaugQJSjrvhbOiUXZKB3/qhtPqTgjm7GaCz3eeHQxKFxjI0QZl1BsQOPr9wpfku78vdXOI+OXNOCzHS9tJyAUqXv85mk5v4JmyZiJebU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZV0BgHy/; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZV0BgHy/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cea3004256so17956545ad.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 16:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785542049; cv=none;
        d=google.com; s=arc-20260327;
        b=DVkFp26gkp//gWzmLf/lSpGJGm02+NscgEFfpdb/kmztmXgmhDDKmeYES+locMH+LF
         WUxkPxL70xzFAaFFJMX5DvAsdbaDyry/kR04xv/pFjHMMOR7JwXv04IpBQJEcE3FA7jD
         BUBlGZZtlvzKj2gP2fxRhgDwjXXXBOm2GlzeBtLQiBB2eHcFARVFH9ptLpKJ80IiTsDO
         sI/Y/rwD9ob1efBqSy9y4oOFbmDKTeWEEQtN5aEbvicy6/Y90n4glKUCy8k1hHfeo+zt
         ZclzwR3fP93UFsUzG0BRW0xfP4kvyq6CKMqsLH5pzEfYvJi77qfa7xGv2sYQMjrg45k+
         iI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dQKsEaYPuZ8wUMoAt2HfbFs2BUMXF1f6C68Ep6tQFIU=;
        fh=SENpZdmtQzC2nsYVVOy74xT/JkretOfUWMwnRSZ3n+E=;
        b=moK4JOn91IM2VNgLsaU9CIqaDbQW7K63uBwgKzCMRCn5gq5q9ZDv65dBLrPu88xgFm
         wu1Hd2C0nkXYE/1h1CAexC0Ykj+uxsEDDn8qTX/7ULt+iT+KhAK5DXm/26UUcBERue9n
         X9hhlc/VEtcBijwy4k5II2dcZMlnuoHtpaD/saRT/9FuzvN0QVcvuYqnsJ4p4leeSp/y
         8XvrKUIT3Piow0Qv3Gffnx5qFfM++AYQaRSzHpChECGxtA++xZS6sYHDWSIueA0Akn51
         pCK1kK4X9t8nK5fH5AQ2LOuvR69N7jLQb3Fr3bxtu6wPbpHlBStHhsJsyvhYKOAF1Vbk
         e4Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785542049; x=1786146849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dQKsEaYPuZ8wUMoAt2HfbFs2BUMXF1f6C68Ep6tQFIU=;
        b=ZV0BgHy/uAnN9EOzIAQYVUbFIXWO3vw34W+ka1DXfjZgjShGF5bIB2XW2TCwB/mSKT
         plj63u3MT5FK4f87z+oC+7VyoAHqYV/olVWm0Ej36vGfOfH7KTvDSMjcJbdboN8IkZqe
         aB1NkXJRumonCAnU95F+Wnx6V1IZtKIGAFkfzRZCIM0geMN4llQFsZAn17V5C3YZ5V/w
         WyZL82/1kyeXvP/4qL6O6xCpnYt0+rgyZH4ILXcHk14teDfwOBwpQP/oea6oP3ogMvoL
         jHuKRARqsVMMUTc4zfbC+0SCFn4wiDzbAUzPPo+dwq3hPrXU0622fFOXznS6u7Qoa5L/
         /lGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785542049; x=1786146849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dQKsEaYPuZ8wUMoAt2HfbFs2BUMXF1f6C68Ep6tQFIU=;
        b=QXsx5h/ZWn/rutbeLdcw35GfzWcHpCoKoAbl0wP6ouQIwWxrl7Qpi2sJSoQKDfjU8p
         /m9ovou9nxtMNRqJBO9xHHKujSu1F6MrDyPIhnYb7B5y1Jq10SF91mclLjeWmizIpZ/U
         phQYqcGs8/na+get3OwpC9PdYjsQfucTKQzNJU35Zv9OgQy8ec0cnQ6ElGjiSeSpyy8k
         h/H0SXmqoDwzBHmAuTei80+yVdyxuV0vpO5o6u8aXbhB9hHky9SUG5Y5D6mlN8fYqpRB
         jKUsOMiv3tmeeln1WP8Q/Hm8liioWSJGRx3ycNxAMbplbCCOqzdFgNY97rFtYm58KN1P
         TeUA==
X-Gm-Message-State: AOJu0YwZm5oVdaf7O0z7mvOT0OAdYh+J5ULuC2+buCLmdD8YDmCX6yea
	wSubF5TyadgikxhdfdZg6lg2VvvTfE1YlqYEB3vG4lJNfS5DKLdiMt6RB5U4yaGumYSGzt2xv++
	fdWFEXrKuj0m+en4/39++0/B+kvn4WCBMwY09olwE
X-Gm-Gg: AR+sD10umW27oodNq2NFE+RLr8NVR3Tt74XIGxx1Q0JWgb/T1HQHOkE19i1cpScPE/d
	VqLBpJ+gtOIJhT1BGyNiwThvss0RTYokrQcJhFMfOR3I4HcVsJiWPCqRWgCjX0eorYSaNjKCojz
	Gi4wRfosljsIPhq56a+nx5FW29euE29OTdwe9Glhu4zfmk0eoWrbxmMj+N/T3y5fz4uUWgd7xBJ
	36Q/nHlsSI2sw0oOMTJH5F8mW51dydFRhcNwKNMTkQkf7+n8uq91ZEtgyYinOpkdcTlbYCNVDiA
	cpEahQ9UtDYD80XGZtVoqIoUkfx/T3KD1CYlqRrLk1Ks18ZpWoDeraeRW5C5jrFVNWa2MIhiGNJ
	akXQh9Mu5nva1LKugORdIv7v7XqvZ9VnGhKq8nawVFW30/NA7JpZ3UeHvVz35atVyOyxvAIzkzJ
	5y5EATbBEKUbM+8g==
X-Received: by 2002:a17:90b:2f45:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-38fbc408bdfmr1443765a91.7.1785542048763; Fri, 31 Jul 2026
 16:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731175141.284757-1-shivajikant@google.com>
In-Reply-To: <20260731175141.284757-1-shivajikant@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 1 Aug 2026 01:53:57 +0200
X-Gm-Features: AUfX_mzJ0TpvTJcTLfxZAL-iQCcooiKSqprQ2g9C8MzHeYNFd9pziA-74s2jJgY
Message-ID: <CAAVpQUBB2ZBGt9u_TiBhjB==gvDZ-4gpuzqDTA2amhO1v132Lg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] bpf: Allow IP_TRANSPARENT and
 IPV6_TRANSPARENT in bpf_{set,get}sockopt()
To: Shivaji Kant <shivajikant@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, anubhavsinggh@google.com, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:51=E2=80=AFAM Shivaji Kant <shivajikant@google.c=
om> wrote:
>
> Currently, bpf_setsockopt() and bpf_getsockopt() for SOL_IP and SOL_IPV6
> only allow a small subset of socket options (such as IP_TOS,
> IPV6_TCLASS, and IPV6_AUTOFLOWLABEL). Calling bpf_setsockopt() with
> IP_TRANSPARENT or IPV6_TRANSPARENT fails with -EINVAL.
>
> Transparent proxying (TPROXY) and related networking components often
> rely on IP_TRANSPARENT and IPV6_TRANSPARENT to enable binding sockets
> to non-local IP addresses.
>
> Allow IP_TRANSPARENT for SOL_IP in sol_ip_sockopt() and
> IPV6_TRANSPARENT for SOL_IPV6 in sol_ipv6_sockopt().
>
> Tested-by: Anubhav Singh <anubhavsinggh@google.com>
> Signed-off-by: Shivaji Kant <shivajikant@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Change itself looks good, but please rebase on bpf-next.git and
respin with the correct branch tag to trigger CI (and maybe Sashiko?).

  Subject: [PATCH bpf-next v2 1/2] bpf: ...
