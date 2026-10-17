Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1951D37F01B
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792209902; cv=none; b=pkKX7PAaojC5dbLP0ir3BVpa74MclEpo9lJ0IpQf2b16IzTNMKHuzQOh/qsGpQmUbXW9LiTI1x15Wy3303iI2v7MMU7dutwcQY7Xo0ub5bK1yzUAFrkO55SgjIL1z85rXGc+FqSGzUzKsDjEeh+pWHf4IGvfrO8WBif62u3aCIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792209902; c=relaxed/simple;
	bh=fO0mzPZiShDsFNIz7gwX6d4eDvPM2pb6gIMTwEOvhkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TLJvFihbbbXUIH7MccJ6XXz+mhMXMxd2uNsT4VsE4n0eoTzJZ5gtb0DLIbJx2kKO9+uLLbYk5JfG29gnef40zjcRESccNeUneZBWuJzVBQviiEjQ0sOdTgvyZwd4dyj1cUhgvd1ZQLwEp9ayGjU/cpOwLN9NIejGFzb+us5b/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMi9zl+E; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMi9zl+E"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e832c03576so6285985ad.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 21:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792209900; x=1792814700; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hu6qZrNNR8jshmCrO+tEIuOZOsw8C215drmXj26mpdo=;
        b=DMi9zl+EKs0ZMTd0ekAFLgSODNRuKmYAyXcD4WU9ELunkuB/diU6LgoB/ztYCB5KJm
         zUeUMifxZiAnj7mi/9qTLdaPqCIzin/Dr7yvSy2LxfppTrEWvVZXqTiEURvP0Uk9flBd
         ZQSJ+TrK/lNTSoMKHaamYwaRIQ83vOVC94vb9+Zta3v+UgR/hh8/XRKar06OjIHwsJzI
         GeSlpoeNHWfEH0ccigAbNssWZrCJuPC6Pw7BHnk0yasX8iJ2ZfiE0UbJhwGoEuC6NGJF
         FnCVEe2pvKalrRJHsTnd0oEiV9Nffu/JB1QT7r334YBhiAXxuP2PJ4vKScYh/Qm7/WNh
         ZPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792209900; x=1792814700;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hu6qZrNNR8jshmCrO+tEIuOZOsw8C215drmXj26mpdo=;
        b=QrYUyth7Gjro0mIJhli8Cux+Go8EYjxBqJbPnIJVoIsxyzw5/xTEfGwbqzGJdJxFPW
         ZqJ3EPXt0r7PW0gSOgHyWK/Yrz1IbPVKj8IaRWxFt1LutvlGgedIWKsJ6OIo6z3MgkPi
         08TUMvXzdAeOfUoNxV3REX3hfQyONzWiUHA4/rNkvM/lsZXjfHQvlrb56j78rwtj18ru
         3S7WIVVg4IL92L/mIG4rdbkxziQzRgbcV/AJ+zGWM/6AfAkqvb2twZyj2EFcYI29exsS
         YWzQwQzaCfb0HHLzAWOzU1CR3reH18v/c8wPSIcMUAyGAdRM7x5lHzpTeBzcnX0tKItK
         j+bA==
X-Forwarded-Encrypted: i=1; AKwUvBw5n6FE9YXBpRM1V72cJvsjHN8ZeHokAHfzFAuLK8JLzEIL4ZIcwa2WlB8m2g+tQKLbHGU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHqXaNDT11Xd9ZcGsrysDyVq4n2PWZhTDQZuKb8mlL990zYwiy
	nKZZiFSSdOWlmpr23K2zVWWv32uTW60dM2HqPuu4Pn9BpCvfD06nbDbWPwhlizmIZ5Q20jjvylw
	aC3KkjA==
X-Received: from plbbi4.prod.google.com ([2002:a17:902:bf04:b0:2e2:dd23:fd42])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84a:b0:2e9:4b65:368e
 with SMTP id d9443c01a7336-2e9a6d1eaa1mr17669515ad.15.1792209900119; Fri, 16
 Oct 2026 21:05:00 -0700 (PDT)
Date: Sat, 17 Oct 2026 04:04:59 +0000
In-Reply-To: <20261017013912.396296-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017013912.396296-1-alexei.starovoitov@gmail.com>
Message-ID: <atLznTaCBocvn-kA@google.com>
Subject: Re: [PATCH net] net: free the policies if a socket's clone fails late
From: kuniyu@google.com
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, josef@toxicpanda.com, 
	mason@kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au
Content-Type: text/plain; charset="us-ascii"

On Sat, 17 Oct 2026 01:39:12 +0000, Alexei Starovoitov wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> sk_clone() clones the IPsec policies of the parent and then its BPF socket
> storage. If the latter fails, the new socket is freed with sk_destruct
> cleared, as it is still a raw copy of the parent. No code which knows about
> the policies of a socket gets to see it, and the two policies which have
> just been cloned are lost. They also stay on the list of all policies of
> the network namespace and in its count of socket policies.
> 
> bpf_sk_storage_clone() fails if memory is short, or if the storage doesn't
> fit into net.core.optmem_max.
> 
> Free the policies before leaving. This can't be done for all users of the
> label: if the socket filter could not be charged, sk_policy[] still holds
> the pointers of the parent.
> 
> Fixes: 8f51dfc73bf1 ("bpf: support cloning sk storage on accept()")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
