Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C6308F3E
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139676; cv=none; b=GLwZKixoLYGVo6Hh4rcjQ7OqA2YkCV2Nexw2jDsn2+swHjyenscl6ymni9WkrfQpugKi7Q7j+T0sKRI17iKOgOZxdO7Almw16JGV3mcKtXCiBs4xeSGvX+krggK7QHINikB3tB3DVBO69kcacwl2q2BwUVRQa6M1hmCM9Z0EfRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139676; c=relaxed/simple;
	bh=zYemPZMdTHCuocq7TlEZHrhgov3DesV7eyqbBwxxwNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fv0m3OQqiFcXVXzQh2dGI6aLAj5a8EmT6VtUFGbS0iV0p11ApkxA860kwSH8KvRBfUb1FPR9cz+9ZEQyUsx1LpBVJvQ73XW2d7aRaIF7HlT2P9NmzCtWlxtudNPNSPfGkSPWT2yUgviKbIZMw0iwGmh6RSbGZjZDpcanzd7ivNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QOJ7PImT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QOJ7PImT"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697b8540279so1296057a12.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782139672; x=1782744472; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eOx8McGgHCmd0/ew0ozXnnvDEcN08z5gnGYc0YXCEQI=;
        b=QOJ7PImTRhJuT8EovQsKyEOC9IVVFXJHbo66KzgxSSOAfvvMaVZj0PYafvyj8/XndK
         sqSfuflnfWOMAp2li6F2h//KJ15dulMWuU10Y6eTjmecG2FDYjYON/WefRdRueuqkANv
         Ilp48AwRY4PwqAV4s1t3/5jk3xk/D+K18MnFSUEs8IzCLohWzoPW8DnOXUJYZcgPtvR4
         wJRXDhpHMV5cirw3RCkJ3rQ3hDwRXo95wwZEt5qB0cuficmN3WTIF7znySWQCz74Gux4
         QBn2DyjpPk+6zlintHTJU9XUPfApBe2rsxPNWtZK+0aoD/WEyEXkGGxsM/pkkLJy9Uxp
         sFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139672; x=1782744472;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eOx8McGgHCmd0/ew0ozXnnvDEcN08z5gnGYc0YXCEQI=;
        b=Qx5t+Cv2pTkdfU4OaVjZvv3c7vFbl9ir70W8+2MfehJPA3fzl6Odn8uJhTZ8SPglaC
         A4DyK/1AkjHO3GnVaJdqLSy+CkiErf9s+PGTw94zyHDg0/Y/5KggXyefqr6rBKsnOXgr
         wJzMe7KiqnB7WgnTkU7LPfG9nbvtuWmIOckxtPAoYFALZYWmkskUQ++QurOrO0DT4fta
         ZhFMAx3Ho/2tYIv8Q8YeSEJ9CnnDHzJAG8gyKCyAXs0kRo4aBjM7KTQ8VfEzEKDmNloD
         yPoAd+beJEXSbsKMHNdLkem+LuW9zOiqKeL5FZ5/xF2NgwNoCfmN3LiR7DOiw5Rjzo3U
         yBeA==
X-Forwarded-Encrypted: i=1; AFNElJ9skjq/ZN+KqJDF4NxTYcdVKcjyWZYSq8wBezZpHLaaTpRx6i2yQSWJbJHqcPJTPWJ0caM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97cj++8/gvwmUtSR/PeWL3RdukD4lxqPQfDBkLXbaurb0SsEX
	a2Bax8iCWGQz4075JSCUBS4Bg+7dlifyAhzx9xS2f10mccVCMv4T8L8uk4JBJSzEax0l7U6nbmT
	YCtPU1Z8=
X-Gm-Gg: AfdE7ckhk5erPq2/O4fFWiH2zkjNivsZ0Wzz5kgW+78X1yyMjYmJ/9vf7RsjdbM9qoS
	zknz7G0N15QSc5TsyEs46dI9MHci8r4IOP1wZs0Vn67ecF4rkockWAou2Hw3gPVjHh9iCdFtWG4
	lkXJAhJsTA1hnT4Jh6ZOa2WvDU94j9TnPbaSYH626JI575I9x2dYATBZZyrS0NGUGp9OndlAXSx
	ICokd5nETTWaljglMDhyTcWvwauFy2jQAlx7VYfN/WVFaw4ECf295QhULcskj6AQmGBE5k3csWZ
	dPdZKq/6GoTYknrjKkiNdZBFOaelnDG09dnjV7p/rc8e8hb3oKrUP4vJ6DbYrc/X0P119LkTvt8
	zbxeH91TFjINXb52FjwaLl3lUE+HpWlxRqT+Q6xi+Nc+K67flRqpuCAfYpRvkw3foxkurDOOei/
	aRJ5moR+lBS7LyASnwvD2Kh1fdSQ==
X-Received: by 2002:a05:6402:4307:b0:697:849f:7dd1 with SMTP id 4fb4d7f45d1cf-697849f8021mr3567477a12.5.1782139671680;
        Mon, 22 Jun 2026 07:47:51 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b82f95dsm3513391a12.3.2026.06.22.07.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:47:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev,  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, unix: Guard sk_msg-dependent code behind
 CONFIG_NET_SOCK_MSG
In-Reply-To: <20260622131731.E619F1F000E9@smtp.kernel.org>
	(sashiko-bot@kernel.org's message of "Mon, 22 Jun 2026 13:17:31
	+0000")
References: <20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com>
	<20260622131731.E619F1F000E9@smtp.kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 22 Jun 2026 16:47:50 +0200
Message-ID: <87ldc64oo9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 22, 2026 at 01:17 PM GMT, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Calling recvmsg() on a UNIX socket added to a BPF sockmap causes a NULL pointer dereference when CONFIG_NET_SOCK_MSG is disabled.
> --
>
> commit 95825431b208bd3fb6f5fe58d504bdcb560273c9
> Author: Jakub Sitnicki <jakub@cloudflare.com>
>
> bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
>
> This commit conditionally compiles the assignment of recvmsg and 
> sock_is_readable in AF_UNIX BPF protocol rebuilding functions, guarding them
> behind CONFIG_NET_SOCK_MSG.
>
>> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
>> index f86ff19e9764d..5289a04b4993f 100644
>> --- a/net/unix/unix_bpf.c
>> +++ b/net/unix/unix_bpf.c
>
> [ ... ]
>
>> @@ -107,8 +109,10 @@ static void unix_dgram_bpf_rebuild_protos(struct proto *prot, const struct proto
>>  {
>>  	*prot        = *base;
>>  	prot->close  = sock_map_close;
>> +#ifdef CONFIG_NET_SOCK_MSG
>>  	prot->recvmsg = unix_bpf_recvmsg;
>>  	prot->sock_is_readable = sk_msg_is_readable;
>> +#endif
>>  }
>
> [Severity: Critical]
> If CONFIG_NET_SOCK_MSG is disabled but CONFIG_BPF_SYSCALL is enabled,
> doesn't this leave prot->recvmsg as NULL?
>
> When a UNIX datagram socket is added to a sockmap, its protocol is updated to
> the rebuilt BPF protocol. If a user then calls recvmsg(), unix_dgram_recvmsg
> checks if the protocol has been overridden:
>
> net/unix/af_unix.c:unix_dgram_recvmsg() {
> 	...
> 	if (prot != &unix_dgram_proto)
> 		return prot->recvmsg(sk, msg, size, flags);
> 	...
> }
>
> Will this cause a NULL pointer dereference since prot->recvmsg is never
> assigned for the rebuilt protocol when CONFIG_NET_SOCK_MSG is disabled?

Right, my bad. I will switch the check to `prot->recvmsg != NULL` since
unix_{dgram,stream}_proto don't set it.
