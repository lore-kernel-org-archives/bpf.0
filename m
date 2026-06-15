Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C52E2850
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535307; cv=none; b=hlNB2Q/Y4P+0hYgbT84+CQydfN5+KHveaNc9f+p9EWDZbhPW6yMejnNAm2Jt3+z3y7U9YKNuuBODTZ+j5WmiR8XiOxvafZVZ+fJgIlscklkMXSEpfsLIiCqN54UUp3AaCTRuyxSmWgtDe5Fp1o0E2bBP8mrkDT6D7RzHy2jNy5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535307; c=relaxed/simple;
	bh=TMNsHaBtmsq2RZT9rlpxYqnanVi6lepK09rczAvkJgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cZXwilgKe32j/zUUpag9toiffKYDUfCP1GOjo7CcMXBJASP0vOl+PHrSYvxwwO6nINqyqcoE2LSAv3DEnXk4LrpU0MYZVJdoquoFXxkBbL7rBtQOV74GYF9H0gbT4ZrP6b0uNk3CYElKTW92hwGQVgQsHjPx7oYEFwtdHkMiiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bg8sQcEN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bg8sQcEN"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bf84a2b2077so388273866b.2
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781535305; x=1782140105; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMNsHaBtmsq2RZT9rlpxYqnanVi6lepK09rczAvkJgI=;
        b=bg8sQcENGe97LxqpuelFjqr5bvDEIm1qw8dkRQ6PSJ2WWpHP/NPtKNEviiZI/CBX/W
         +/4800SY/KjxqOq5AiCMWUfKfAh/Zl6JLrYkTag4rr2/4ZFI7co3UVuRcCjRjQjGnbvq
         Lf2jb+vliAXL5hJlTcLzx7+fXyxrui2ujG0+1x8pTiMQiMUfVpzDj50huOeqKis3MYjj
         uLquI8t8gUhe3RM1azEtKylYaKPiczHxIIrVq45pqzd/O93uoCo5ZUNBoYQ/xdZoTqYC
         lnW7CgliDcz6s94bgIar1N5yEQv6sAzjxxbOxs+7nk2ZAXVuKVJWJ6AQJNODlpoiff0W
         Bozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535305; x=1782140105;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TMNsHaBtmsq2RZT9rlpxYqnanVi6lepK09rczAvkJgI=;
        b=cl/nwDcfgLBHx3NXaIFkBcbs8UPVXKaLGyVl4c54lwodjjzY0rYmeI5oNXWJEYniIy
         KTqOm+ts05BYW2A2W0S6jZ1hOFPLFyN/zbpd4NqmPTRbiZ4EU1ejtSWg31mcEJiWj7hv
         O8BpKPEyvN7NPmcAg8cpWr71Vt1ImoWEQe0DoUFFP5HxQgeQgCCAkvClkKpGhf6OCDrd
         d8r4v5dWaeiSZLpwQuFDF/p9J7dAXLLFeW6blkWxUB1pHYBOwEMljxJO6R1IN0IYpd4p
         GH9ASzS4dIytMsv7s25MNTMmq5OwjTXeh8xPm5uBPr03jlPW7cey+r6G7e/IajgNNcEk
         qiqw==
X-Forwarded-Encrypted: i=1; AFNElJ/A/+rmh2ziI7G7qKNnE/H2JAueGwqoVB4oGmtxlmdGSlXt8LBYvCtquhQU2xxY1WCe04k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcLmFAzjWjWPRialmjR9kf7dj7EsvdH/NouC94p/zIbnEy5KEL
	wdjSk5hGSxh2iV/PNA+/hcYXh5udBG1OM4c+10vaLWBLNFcWWnEwjilKnRh0DWwgYm1td0+y4TV
	wS7ws
X-Gm-Gg: Acq92OG05H3cZGuS79UsE5nswMC6o/qLJkTKfzZEZKca2Dm9dK/MimFGEq8yesMby66
	12dH2JHS13Umj6UljpCyKE49nvJ0vRz6QVEmeO89Ati71zXffs4JUY6q40hv3YEyNMRKJ5vKhU9
	fY19rLg/K/IcZ1TUxep6lPLa9V8iF6ZFK0IfxuhKJoz8hjqhbPfCeOYDfm7m4lLJqVykLbToWFz
	yxWIY3dk5ow9DTMdPTJV/Ebrf2TXVMhQFKc/xBgFRjiTN1inTL3lDOmTelgE9KEVtLAxVdps4IH
	NoaGnkeZ4g+vRfD0J0Bnb6MgJI9WyUZnhmVC5jPldy4h4/LcxNPkfmcZXeTRfodywVhkYp6R/Zl
	UNDgLEHZ0FJK86aDWqsIfoYtvY7EZO5ws9o1qpyb6aukCaCpTCXhLRns51e6K6/+nwxG0dFHKqi
	2UqKZ9UcqZc7S+n1DgMqNym1Z3cw==
X-Received: by 2002:a17:907:75f3:b0:bf8:b1ed:43e0 with SMTP id a640c23a62f3a-bfe28d1b424mr498313966b.18.1781535304852;
        Mon, 15 Jun 2026 07:55:04 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb44203c9sm499562266b.12.2026.06.15.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:55:04 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  bpf@vger.kernel.org,  john.fastabend@gmail.com,  sd@queasysnail.net
Subject: Re: [PATCH net-next 2/5] tls: remove dead sockmap (psock) handling
 from the SW path
In-Reply-To: <20260614014102.461064-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Sat, 13 Jun 2026 18:40:57 -0700")
References: <20260614014102.461064-1-kuba@kernel.org>
	<20260614014102.461064-3-kuba@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 15 Jun 2026 16:55:03 +0200
Message-ID: <875x3jdfaw.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 13, 2026 at 06:40 PM -07, Jakub Kicinski wrote:
> TLS and sockmap are now mutually exclusive. Try to delete the code
> from sendmsg and recvmsg path which is now obviously dead.
>
> The main goal is to delete enough code for AI security scanners
> to no longer bother us with sockmap related bugs. At the same
> time retain the code in case someone has the cycles to fix
> all of this and make the integration work, again.
>
> If the integration does not get restored we can wipe the rest
> of the skmsg code from TLS in two or three releases.
>
> The changes on the Tx side are deeper since that's where most
> of the bugs are, Rx side simply takes the data from sockmap
> and gives it to the user. On Tx split record handling and
> rolling back the iterator were the two problem areas.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Nice! This unlocks further cleanup in tcp_bpf and tcp_ulp.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

