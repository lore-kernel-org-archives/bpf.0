Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF5175A7D
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886025; cv=none; b=CaAlBJVjWRUEyJ2EtW1Z/0925IraG1M1nS+CwJ/kbr2KMNRyHYWMGoBtKM71KnC+6rOoEpQ10t09tn55zENvVxOtdfn0PzY0OaL8qNXu0JStAt4kPGS8Fx3WQufQzxzANrvyflJ7WLO3VnJeMHDtnCQSKWUehVXqcwyEvFxRgdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886025; c=relaxed/simple;
	bh=8nXfIk5k6dh+bgwKm/+Wl0vJSnaFBQYASdSW7R0dNV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=boXeUlWz5Rlya8hV14ZVQhtYEId6Lypkp/h987B8WxIj67jMFnQqQqVfb/PM4DdOYZfrjw94aD2je6I0oMFZhsbqVq1aAzNTESi5qQok80ps/0nuAEIq5tyd+k4VsNpTQaJ5utTHM9hrQygO6XfXV9cV0G87LK/W4+Tst7O1ovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KV8889/J; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KV8889/J"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1600d040e4so32417266b.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784886020; x=1785490820; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8nXfIk5k6dh+bgwKm/+Wl0vJSnaFBQYASdSW7R0dNV8=;
        b=KV8889/JB4eIpH97s8HguSvE/ERktzfHkYFlN3U3LmmJOkf9Mc/9+X7Z9wxhGnbarZ
         nPQYu0n0oXTNNPG8IOrsrzW6Imq16rzEQnnRataBZLkjhGPv7SSzJFc6xv1gNAn+XhbY
         uyQwiVy0ywFe5vY59oE/bjQs9BUqE3e29TeNMmr+PbDibF7OtrO37wpXZ1DoVMj2hmNg
         fe5Va/zkRPZdLsoRMSmb5NOgrZuPy2VUWLJASeQPadiJ1dPIqRl75SWbg0Hezab/iM1p
         jmAYmEImmZkP9Cdxm5WBH9XDOrMcQnSpUwPh6P/E9zdJLMVJVlFmdHUpSNXKf+ug8XhN
         eklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784886020; x=1785490820;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8nXfIk5k6dh+bgwKm/+Wl0vJSnaFBQYASdSW7R0dNV8=;
        b=P9mdMpJixPdh/M2aLoAYUDtm4vK8Caxh9DDazRxiJRVvkkpMqZrG7MZ9G8kOmAhcAt
         YYm/rVbJiOpIFF6EchoEp/Agq4deTnJVGh3iL3wvfnL7BQMwYld5fUZMlry9MGy9CcS/
         yctqe+roMkCO5q/MiN5+nXadDK6S/9Xq0xXHAi2uIStPn1jWpJDs4ElEvVtNR/9ifNfJ
         lts0tauUSfup2J85xNWCRPeZXquauVrNIpvGod86n3SPZM0rVXD0uTC0yjKDh/BDfHTM
         KoMGb5L0v8zlS+snBjEHKLMEf+K8T4e0vQNJSVoC4rKEseBVABAwmeFxZ8yVbCkosq7b
         hVoQ==
X-Forwarded-Encrypted: i=1; AHgh+RoK+sbIUsFcPESCyfHvlzwTLXWv3oN7/MdDTkHDnFH6lr3krk/bbrfdRwwLfdwzxGqLXos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHnQNHD/X8oInWr8pAwZK/axVJ1nfuQ0NV4hpVAeKrzFnqsSd2
	aYsNhRMznqevNeYGn7lr9GrkdIrfnLwjd4du3lN4JS79iyCz94zUdYa7f+H7Pqvxjt8=
X-Gm-Gg: AR+sD12GihXrLShMaZW71PRxskytGC1hBzfA3Ds4dbRgb5imZ4qJEv5Pzxc41p6VRq9
	1EtX05ZsV7eLppMMQX3pdY1f2vWS/lkZeuw50KwuC/Cz1wqVIV03GzGWveoIMbpHSVU++PN4uzs
	rdjQkmjle2tmL4ZyropBufdEfTEvxVcHAy8qHrnRY7vGd4xQ8Ch7mSD96rwU4Nadp4t+XJKW6AQ
	XeNFWxRJmQlEFiclzVLPVxeyAQHNhoqXlE9b4p4KnCSrcGQHbF1SikKsZjjPnMRYq8mNzwyz1+u
	jWlCe5putu3hVG1077hkGosduVH2Yj8CKq4mWElnebhYcCyMjc6D8KVxslLdG4+On8kPUuSbjKl
	37vvFD+d0TlMBMIjSy8aKqsUJU2TiG+GtBwefGuTn9a0wfDQDDEPX2BRJ6zIWRO5TVRJz9D+ZtT
	baOEA6tlCTkbO0Jkw=
X-Received: by 2002:a17:907:3e0b:b0:c15:dd1f:f2d with SMTP id a640c23a62f3a-c1c53813397mr256387466b.25.1784886020370;
        Fri, 24 Jul 2026 02:40:20 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a7861esm334032966b.10.2026.07.24.02.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:40:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Eric Dumazet <edumazet@google.com>,  Neal
 Cardwell <ncardwell@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  John Fastabend <john.fastabend@gmail.com>,  Jiayuan Chen
 <jiayuan.chen@linux.dev>,  "David S. Miller" <davem@davemloft.net>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
In-Reply-To: <20260723100030.3eee6d51@kernel.org> (Jakub Kicinski's message of
	"Thu, 23 Jul 2026 10:00:30 -0700")
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
	<20260723162602.3275661-1-nicoyip.dev@gmail.com>
	<20260723100030.3eee6d51@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 24 Jul 2026 11:40:18 +0200
Message-ID: <87ldb0lo8t.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 23, 2026 at 10:00 AM -07, Jakub Kicinski wrote:
> On Fri, 24 Jul 2026 00:26:02 +0800 Chengfeng Ye wrote:
>> Subject: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
>
> Since you are spamming the list with the reposts of this could you
> please add [PATCH bpf] to the subject so that netdev CI is not confused
> into caring?

+1 because we need bpf CI to run sockmap selftests on this patch.
Please point your agent at Documentation/bpf/bpf_devel_QA.rst.

Contrary to Emil's ask, I'd recommend fixing one issue at a time.
Reviewing multiple fixes crammed into one patch is harder, IMO.
