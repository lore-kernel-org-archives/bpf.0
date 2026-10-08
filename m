Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53777411FBE;
	Thu,  8 Oct 2026 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791503048; cv=none; b=S8euWvC0L5+YaFH1g+MwFE0S++Q7qjTCUlflGtRG0Nz7qNSUz7yWWveUXBL5Ql87Az+b45gYUSqpijBzzDv390nkOFMxk2EDEMn5U9rfCZuT9gpMDWAridRb7Mlj87fUPnZNJ70TzUjXgk8m8wsvZf9uEXUuTaXDZWo6bOmh5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791503048; c=relaxed/simple;
	bh=/kt30oE5DuE+U/9nZxME8FtofxwkMOZ+kkTZhY7CtMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0AogF1Vrrsqe/9eHZaN5eH+7iIeSiWPyZ42j1iAZGfhaxT8aaK2oblCt4Pwo6cU1QEDXeNqlgD11XGEB91Q8w5BWRf1s35oHvxP9iaqGfGkfNj1Q+OyzlnlgsXIR7JM66Ogas8cxVMPzpuK3UUzwqtGwHPlT2Sie27Bd+4D5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKF3K9zh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKF3K9zh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8673C1F000FF;
	Thu,  8 Oct 2026 23:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791503046;
	bh=ipeer+bQKmXXmZjTWk1tt8rZQdtLvz9OSjoAqHF1Ha8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hKF3K9zh/iJVBT1pVrWIk3PlZeh/D4OHKXJx/PB6jMgcFAZx7vHpuOCNi1r3rqckn
	 /Dz79t52oQeQpY9jMnAl6SXjvGdYeZ2bbnr++PZI3ZdhlDp3nXXef3Fb0EAXULaeiD
	 s4sC7xY4mn2z9CDYm+ty7dTRLNg6SDhSSFTsU6+uGWTaPFcfMbMZftMoyKHs+2OQRk
	 IDzRe/hY3eFjUD/bl1xjZAImDURN0FFrClEHV35SX3QSH//kxdztxu2mAPsOHBfRf7
	 hEFAmWVVxDxJdgyrTery1sRFfJfksNLyY04vXE7Og23laVggOgW7yxLhOgNdf/Rdgw
	 hqTVWRHBXkkjw==
Date: Thu, 8 Oct 2026 16:44:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Cc: quanyeyang@proton.me, John Fastabend <john.fastabend@gmail.com>, Sabrina
 Dubroca <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan
 Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: annotate lockless writes to
 sk->sk_err
Message-ID: <20261008164405.06bf2cbf@kernel.org>
In-Reply-To: <20261003-tls-fix-sk-kcsan-err-v2-2-e939a2ebdd56@proton.me>
References: <20261003-tls-fix-sk-kcsan-err-v2-0-e939a2ebdd56@proton.me>
	<20261003-tls-fix-sk-kcsan-err-v2-2-e939a2ebdd56@proton.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 03 Oct 2026 21:44:29 -0700 Quanye Yang via B4 Relay wrote:
> diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> index a23f4b4dfc67..e5d5d755e532 100644
> --- a/net/strparser/strparser.c
> +++ b/net/strparser/strparser.c
> @@ -57,7 +57,7 @@ static void strp_abort_strp(struct strparser *strp, int err)
>  		struct sock *sk = strp->sk;
>  
>  		/* Report an error on the lower socket */
> -		sk->sk_err = -err;
> +		WRITE_ONCE(sk->sk_err, -err);
>  		sk_error_report(sk);
>  	}

This chunk doesn't apply any more, please wait a day (for net->net-next
merge), then rebase & repost.
-- 
pw-bot: cr
