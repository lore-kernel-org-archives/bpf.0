Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8244BC9A
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704168; cv=none; b=WKRYndFY7LYfN8hmOzo4as/l6ysUOan0TC1gZa0jYEIc//G1DgwIXapQu0GKbOTGCLTELmDiWujJ808LN9Ksa615aNDqtBMSfEru6cxft+02E7fHLko3tPCVFfbKkcuyH3N8oxlDGdhuttYvPx+5wRq5r34J0onq+CuD0gXDt88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704168; c=relaxed/simple;
	bh=QToTVh6/Mnx9ZpECqcu86BEjK/YNJA8QQpFCROHIGrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uBWlrKq/EEicIXETPMp7l7LCuI6GLm253RTH8d3LTxPyK5YW8T8LXc+NHYKf1TSuec345ZRhFr+9jucS/JrEK/tgnHWCLFwjBc4hM5AAoGPlmw7ogUWLXC4mmbm/cGkn5sCqvoQ6SNOGWkSS8K/OVCbWSHYUXo76DOndkqI/19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZNcWxW4X; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZNcWxW4X"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so1342326a12.2
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786704159; x=1787308959; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QToTVh6/Mnx9ZpECqcu86BEjK/YNJA8QQpFCROHIGrQ=;
        b=ZNcWxW4X+EjxgNmXm8R2cPAWq+NDyZA0BGhSxbHKKfXMLnYgiN+/8mz57XbfkwLZmj
         yYL8enZqSfv1GnxT//hOA4X/UFx2D7eh8qeYYnN8jSfXyHcZxVQMHeS1hDemVIw8DMTA
         VIvUATCLAvGq8yUbkZRQ3nd7HULGGw8uiPtXGHLFMJx5vPmRLQxjPemTDaJ3AUtLDbqD
         IPRp5EciMPfpWqCHfJL5iQ7VhYPMFUHqKEFakkVOV7Fu8dvrgNoMP8n2K7dl3b2OhVGg
         czLtNf1ehT/iPoYKmfL/11FJoFdC8Q/q4jkIMXpEfN54cI2tkIkaw6mINq3Nntx6IK7n
         WXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786704159; x=1787308959;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QToTVh6/Mnx9ZpECqcu86BEjK/YNJA8QQpFCROHIGrQ=;
        b=Q9kg74xMqVub0eJcwrIgFj5zyCAUwhV6TMvEqUog+OSIWIQeJWFKAflOeOZr1gz32y
         cx7ggGjOfZ9Ob7eRvQq3Ba6Em7OlOBR9GGAPevAu0p7QtZikJF7kTSCSxvMU27dNnam4
         /s7cvac792TF/hpXtC5RdGdY7WpwG3D+wTi/Xp/pZYv6tDZ/ZAH32Jxhab/E+hxx9Vf0
         SuMop/GPDSMdX/5EjPYfJViz5rF76zdiDZJphrH0qrDzCdNkIa7kn5/C4hKVMA70BkZg
         rpTEuPTBHhP6xkVUN7Hj5W/NauDV8JKGfRX4GxXuELsOZCl4lfRzUY68e9EWTGRArW3v
         DcxA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9PwBCJE3tdbksodoIJbnYIUgOd/ycEv47C56sliqz9LzT7CrPQUwvUk0q0hU7mjCYjoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSK3k9lyWs7oxgSZZoS/sIh/CPwNa6djHLoDLQgC52BGMpr1F
	JhN/BNISg6JiFigAzvS+4/M5nqbJ40pxI1gYmzc4JKp2/LG9LmxKzzNyyKTqQOODK/A=
X-Gm-Gg: AR+sD13lChKgtisrHds/9uvGV2JZ5c6qzzIBrXucz1p0pCDlY5Nu5adXvN03mObXuBO
	AkeQ4mdBWoqj35bDOC12lbssSaAkWuajkCIEuQLVxkH+T/EznTziSsIqXyczC5K3PtfF6CnbZrO
	uTeKeh3dYs+pwaPRIgld+PPGOVXSqv07/R84CzOtFNGDtoZHnrOcMrYKzIj0/iS3Iwf66Uhuk31
	54qg/S919LOV48QxqlW3YJ2oelo8fEKtxmsJCkiqgWUUZ8lRNE8vyG/R/KDATsr4pxvBl/JQyow
	MftTFC4RYbcjOHUtnHmbLuXo+cfSLaQ9L6vl+OOSxoqPR6/BkSu8huOuHLalovBVz9wlUx2CEPs
	rpnsWEevvo8mc1Thn9cuEMR50iGhWnsjdeBqBvfvtpK0Jxbxp/+D1lt4d5n2+47sppYMe+hY9iu
	XdfqdtGsUpIZxGFHkTdMyVcgD1IUT3TLqxP80g26b3lz7y0oN8wmei87i40gshXEU=
X-Received: by 2002:a05:6402:914:b0:6a3:691a:9d71 with SMTP id 4fb4d7f45d1cf-6a38a957c26mr2538574a12.11.1786704158754;
        Fri, 14 Aug 2026 03:42:38 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38c9ea527sm621948a12.12.2026.08.14.03.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:42:38 -0700 (PDT)
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
Subject: Re: [PATCH bpf-next 2/2] bpf, sockmap: Use sock_hold() instead of
 refcount_inc_not_zero() in lookup
In-Reply-To: <20260813-sockmap-lookup-get-ref-v1-2-31f5d55f44ac@rbox.co>
	(Michal Luczaj's message of "Thu, 13 Aug 2026 14:42:00 +0200")
References: <20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co>
	<20260813-sockmap-lookup-get-ref-v1-2-31f5d55f44ac@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 14 Aug 2026 12:42:37 +0200
Message-ID: <877blt0yqq.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 13, 2026 at 02:42 PM +02, Michal Luczaj wrote:
> psock's hold on the looked up socket isn't dropped until sk_psock_drop() ->
> queue_rcu_work() -> sk_psock_destroy() runs, which happens only after the
> entry is unlinked and an RCU grace period elapses. Since the lookup runs
> under RCU, a non-NULL result guarantees sk_refcnt >= 1:
> refcount_inc_not_zero() can never fail here. Use sock_hold() instead.
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
