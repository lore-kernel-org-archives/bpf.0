Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6EE43933F
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497615; cv=none; b=s34DsnjCy70eZ+Te/cpZUA1+YouET1we4QcMJybsYndnAnxUQGUD6hv9l5MhTLMIWObeQwU5K7spJXsWaiYXRlVqNO17Ulf6AWb2e0OknHgSRPlYoyKygVO1e2vYuKMs7NwbyWZSSsSG1NZR4HuR2vgZNOsgprnjLvFZaEj3YTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497615; c=relaxed/simple;
	bh=XhbvqjOdjhVKjaUTw6zflrPNgueBqC/aiLfFiC3naJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy1oewJPDhctSu/cxhS1cWerDlZjSz9I0z7F/jm9ppn/oy+VJ1ScZivvCL5napO7SogXpwDlyfcb2FI/hU/vcp9KKKfDgpSVD367tpL+21ODxN19lLMVwME80aj1ZXuG96jFuXJSuW2NsDaZ7b4PYn403kWrF9J95oqBPqC7gzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8qgeY0z; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8qgeY0z"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2e7c8213b09so6039595ad.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791497612; x=1792102412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wR6B1DFYSH6KdPY/ts+nWKN+fn4/J9gqpkYviWx1rk0=;
        b=Q8qgeY0zhMbaeiJHpdP5JltSzND6Rijq+U/cRwVd5f9NqZPLpS6Da5DZsCZUKf7rfO
         uPM1mXY1iGXmryRnT8FnJaLFqcA0kjShFr7+wx2QKss+5l8XaxNIWuGeH+GNI0HWaws5
         j9t63WxZc38wX30FUAR5cABtBNCruLJI5pmc4sFqtL2co133g18UZmezAq78L15Iq+8R
         JuW7sySL3Efws4SchAvE0Il45p9PFTLCABdeC0WDKDdsJWaaygtJ5uGU2Ju1ArJ6NRV4
         5eFnoEI7N3IrMo2KNoIKeLoswMMgXkG+7yQKYMs9QXVPGCPuKBjgnTZ82NtbzhG3ekQP
         SbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791497612; x=1792102412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wR6B1DFYSH6KdPY/ts+nWKN+fn4/J9gqpkYviWx1rk0=;
        b=JICKkmZ1n6LcPwHL/mXR17ohC1lryzTVX18amj49nsahZW0g1WcBGKwvFGOuvS4pua
         u7mUe12Xm7sNXus9F28KZGGb7BL6SO3pqmpxHxep1dtrv0Aod7qsKqDgfHYZuxxeT5hh
         RahjexHlX2ChvxbWb7nBTp2Rv4qI3wHqKXohIYe1nDMqb2DvMHs9Yk8mzoYP/CR03LXI
         A3+qw7rKeD3r/CVKmWzuDmHwDbLcGM+UmyhO+2jy1NZplXp5LkLuyETWcVxHCJMFWgPX
         nzLyuNneCh0Z1sn/Cd6uXkBc3km9ULX4kNlOrvOtOo9wtDrR5FKuo5z1K8O5KzWXB3Vv
         JZCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmoXtS+31W+nXHvpx78pgKo/1RouBEVmH64zf8cvVeow9fd6t4fU5UmSd+B0Y3nU240nQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWP+al0TdIeTk7QoH/vla6l7tz01aFLJ1PamWEyZQ+lPdzsJt+
	k5NlAxLstF5SOO9oIV6bbYFQoi/jDls0zeS3IhTU/6XZ67wzEhTUMQNP
X-Gm-Gg: AYBFou1Xx7vJTtHuTiqJ1abYnLffGMMQ7MatBQt6mELBMD5Uy/sRkcaoH6fu66hMfvL
	evxA/J+CYy56wzvpt8lHC5/9u8Gjv5Pxqn3ofEFfc8Ewal01Y50r3sUyUvckqmWPq6ydF82BEO0
	a67qOaLOWI91J/v+/r8mT4iSPqAqnRUwVL1b9UpeUqQZRb1aFsA7K1pDr9VbsnZq7y/ExBxjJ0c
	tfFLrjoKuufzclJeLAK95S8BVz08Pfr/lbiHwTSg2UbfUpRZ2Yz1s98VieJ+npaLomtvdae9c4x
	l3gdBbbZxRFT+0tfA8j8bzSu1fh9TRTCFEjw5hO3FKI89p1U41Ol3sK8xCHtAv4qIKiTHge7Xp2
	yQojwz1JIRDHngy2bQF8ZZirDPEAeP+/JWTcOE08DmmASu+U/9lWu+TLMTYlfnZymRGn2k0cU3T
	RmPqRwMFm5T9vBVvG9N1GnkEgzSf2+7mJIg5UNLo5VvavW9A/pzO6dLDHtpP6nm/cD
X-Received: by 2002:a17:903:19e7:b0:2e6:1a6c:abcd with SMTP id d9443c01a7336-2e84280a68fmr108075ad.3.1791497612535;
        Thu, 08 Oct 2026 15:13:32 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8c57sm337035ad.53.2026.10.08.15.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:13:31 -0700 (PDT)
Date: Thu, 8 Oct 2026 15:09:56 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Luigi Rizzo <lrizzo@google.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net-next v2 0/2] net: netmem: document design principles
 and intended direction
Message-ID: <asgUroVsxJq7gut1@devvm7509.cco0.facebook.com>
References: <20261008023030.1089616-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261008023030.1089616-1-almasrymina@google.com>

On 10/08, Mina Almasry wrote:
> Because the networking stack and drivers are only partially converted to
> netmem_ref and current memory providers only supply unreadable net_iovs,
> automated code review and analysis tools (such as LLMs) frequently infer
> the wrong architectural invariants from existing code. Specifically,
> they often assume that page_pool's struct page APIs are primary rather
> than legacy wrappers, that memory providers always imply net_iov, that
> net_iov is inherently unreadable, or that callers should branch on or
> downcast netmem_ref directly.
> 
> Document the intended netmem, memory provider, page_pool, and skb
> fragment design principles concisely in the relevant headers, code
> comments, and netmem documentation so both developers and automated
> tools follow the intended abstractions. This series adds comments and
> documentation rather than performing a large refactor all at once, so
> that future incremental changes nudge the codebase in the intended
> direction.
> 
> This reflects my mental model of the netmem, page_pool, and memory
> provider architecture; I welcome feedback and disagreements,
> particularly from major contributors to page_pool and memory providers.
> 
> Cc: Luigi Rizzo <lrizzo@google.com>
> Cc: Björn Töpel <bjorn@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> ---
> v2:
> - Document both current implementation status (memory providers currently
>   supply net_iov, and net_iov is currently unreadable) and target design
>   principles, and clarify that new code should generalize existing
>   limitations as much as possible (Stanislav Fomichev).

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
