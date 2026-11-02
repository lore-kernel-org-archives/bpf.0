Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650279;
	b=f7w7yvXNZ6CeAN8to8Ln3blplyktAKMDIiz3OLXK0uDYRts9YmO0dpId8sNs7fTl5873
	 QnBC4ZVmbdiYRgZsxRrvwH20kZ0ElK5Q3vHJBZg9RbOHbKBRpjdNOhWbKq/NVsaSoQ7Hi
	 DsKmoaYZMlPxVbZ/JiWbJOfdlmOcwai3qO5A3cHeLCjp/fn6ujbBvfggWa9RxgvIi7ddH
	 9NLNN04VfKne7/Rvdg0+KDnDooOUfLpfUpIbK6tqClRsY521ofFqJkPwZ0ZzlOYGew45P
	 moYjoGgyLRrHwFNoCadL29K5hPCHarOf/J+3gzs6kY6Q3tlY16vIF/JzZoIQ6jt5k1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RcymY4D4UF/8ph33P0OPdwCWekGZodgPY8AEN9x8u9A=;
	b=0hsfUUpqQdIrhveE+fZSCMQMeq/T7cw62EAQDheqqUuxTUBzrthajD5RO19TBHEDC98K
	 qwYTAf6lXdxyioDKgdYZL8h5xe3H3Apwun8KCp9VdgNEIEomncG6/x0EONrP0CxzSRZ6K
	 GDiZyhtFHY/hJpX6/tNOXJVrNmTd4l9VY3COB7aOy/Vc4fJaS7T4kq+Q43AEEim5ua99l
	 /slO/Q4v0txqXGfDqA+M9BFH9MA1YTYlR1NCmtQHw/KNiMBtcJNmy7yo2FvvGo9QHSRCY
	 gbMov1C2sLrk+eflF+/qXwcAHdT4zBzFTPZot26toh0EO1OLJHIiQGmofC3OllVRonA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jQqHEnFn;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0C606A329
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 20:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5F0C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jQqHEnFn
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso2136093a91.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793650278; x=1794255078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RcymY4D4UF/8ph33P0OPdwCWekGZodgPY8AEN9x8u9A=;
        b=jQqHEnFn+FXMVNfoBrs1W0djK36mh6tAQLBKKA0np19Q1lUiMt4NJL7nk+7gnZDcHa
         puQGZPgqWkCEuwWOeI0MtPwKgP553Mens0+MZqU+Rj1oNBo68oEFeSew3Cv2ASUxq4U0
         REbJSjunXBCew6mlmraQdA0sD3dOYhqSN2uRJrAafjPbp7rVPTI5CQl8npSMS4Nfl3ob
         0BvbBihL+543OtXPr6alPH7jNRAFDG3zkmvzOOP8fkKzmzF2QvGWbpDu4rKzSPRzHIJd
         yDJUU0RHvw8Njw4cV/qdGBTcoDd/p5a+w9HR8R9aoCMvAnYiKZD5aP2h4x86Pj6T+lCR
         K/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650278; x=1794255078;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RcymY4D4UF/8ph33P0OPdwCWekGZodgPY8AEN9x8u9A=;
        b=peaIULiANdZfDq8mpdvk2J0hSoNnioyAtWgpqMZrW0ei2/DNSGh/v/QC1WJDB+jZXw
         xbB4idpLv7W2SsTmH2J0U5rMsyCGVIsiikbC0YTc1rMA03IcxDFujdnfymUpx3Zk54dS
         HyP2mj8Vy7KjHUyxV/ZKh3liavur2ByceoF9jJJpKv3MJXBbzAdgARTpQuY+0JA4iwEO
         fJo0OBHLA47EGasbMZNGqcEwpq6yPLV910UHqjUR3Up2TgTTpq5gqoLvvgpj50RpC3Oc
         oM5G4zHr5mS7aavXof0epw3xxUyY7RNtnzFSacFnl3pnRNg4QUsbKhF5ZDRJz8QB96oZ
         MugQ==
X-Gm-Message-State: APuU4Z/Z2SD5EAX2GaOAjyebmKtaEkPA7CcBIalU8fFREhRKEE0pi1yR
	Xvkd+Qquo8WWZhVU6qJcnxCtIPQ+eWCOZIEAJNUA23qJd5cyLaniUCJg
X-Gm-Gg: AYBFou39ZnyOn/dSX0l0c2wA1dfdI5Luhfmcs4EYsS3gK+NoBwX5jOG6JbSCj+XgJnl
	6t4uWDSXSypPoAWM7u2oaSqYG/yjQLm+dXgL/f7Gk6istX2FgBFFohsncsXP3kxwioxyf2Roqnx
	GXNPrDiJQn0KXHyIuMmRyGW+zes/5tBnfJxigkWz7h3nXAJdO04wLADpK1m9dEwOJgGGJAT1vx8
	My2pMzloabkPtP89gtcLTRBvjWtqS9wUsO3ydJ1uBZy4BDaRKI6o8g0qk843VnztrpFPfMEeiO0
	FQPRCebxHe4Vq7nH7AC9B6fXYrm8ojZvNtiR2FPDgzAHO1jpOSV/QGnsfDY7NseCkskPpW5rQC7
	4AEa0FxW2n7YCfrN6ohWMl0CxE8XETfc44ZTAInCpBvvfC5Ih/zUXVqn0lfLsGQ0JeBqgBQH7BF
	MACaZrOH0p4TeFsbpYaUxlZS/skHdVYJ+As5OzjIxKzWhTnaTEL2SMxc5VlymigEwIiptHr7AR6
	L4aAswIy7JP1J83gznzN+EN3jMP+DsktzdUzeHEkx6xhgEEL1YXQP5U9nwGhioiL/usTxVxyO6x
	Fy4bXPDQR6eE0oqSYO9SieBtgSXn6TZudXh8X6+fKPGx/QrJrtxhgVvRSFBe//B+/yzPHznTKHJ
	q97I=
X-Received: by 2002:a17:90b:2742:b0:3a4:b418:94cf with SMTP id 98e67ed59e1d1-3ae897158ddmr9622591a91.14.1793650277913;
        Mon, 02 Nov 2026 12:11:17 -0800 (PST)
Received: from john-p8 ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c29e619sm780797a91.0.2026.11.02.12.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:11:17 -0800 (PST)
Date: Mon, 2 Nov 2026 12:11:15 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, jakub@cloudflare.com, 
	jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, 
	matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 00/15] bpf, sockmap: Fixes for verdicts,
 redirects, corks and recvmsg()
Message-ID: <aujuOJCs5zZyon2k@john-p8>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>

On Mon, Nov 02, 2026 at 07:20:57AM +0000, Alexei Starovoitov wrote:
>From: Alexei Starovoitov <ast@kernel.org>
>
>These patches fix bugs in sockmap:
>
>  patches  area
>  -------  ----------------------------------------------------------------
>  01       recvmsg() after a fault
>  02-04    the verdict of an sk_msg prog and the return value of sendmsg()
>  05       the backlog of a stopped psock
>  06       TCP listeners
>  07-08    the target of an egress redirect
>  09       the TCP state in recvmsg()
>  10-14    corks and the redirect target
>  15       bpf_msg_push_data() and bpf_msg_pop_data()
>
>8 of the patches are from Chris Mason and Josef Bacik.

Thanks everyone lgtm. For the series.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
