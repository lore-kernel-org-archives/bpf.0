Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397783ACA6A
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755779; cv=none; b=asIPN8dvl0h9o6HyYl0ShNoBajCCeaqbxU9N3+6jgJrfCMiI6O96I1lZqxj367zfaKMsY3VK3MZiRXA2yKh+gciCwAkbmSC8xfzk+JV/9wWb7DFXls52+mh3CpRCVFUbRG7j7zgurgYZDnfOalnuXIp6sx8dfaYFvkLVz6dKC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755779; c=relaxed/simple;
	bh=W2ELaAWxPWq9kV4aD5RtZ5GPohgOHYpCVcJj9TyZ2fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/A8ssKlDzk9oRJUaMpbymnAxnVlxRDw2YKkE0BoZpLCexnp1JJc/38s6eYEqfFKLhFhRjtH3xy3nESlLCwscrKfah/htIQEk8AG1uDQNGRvnCzLKaj7dRKoCxbemtAtXmww5sLE29jonRglW0tjtdVa5VrGCvrwB1lLSZ4wrps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MyEzHq5c; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MyEzHq5c"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so12740682a12.0
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778755777; x=1779360577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2ELaAWxPWq9kV4aD5RtZ5GPohgOHYpCVcJj9TyZ2fg=;
        b=MyEzHq5coipkYbJMd1yo7waPyBK3HkZ8XjybpErDYtrdDgrj5r6HSfF/nhbiSveM1D
         bs+GkhECWjRn6m2FrgRNXo3EpYuqGZmfvNr0n7g72YwN3yM4v2cHFp3VC6lbU+l+HX3G
         otml/B2tvFm8bn2HxZSO7s9nTAcopIP7EyHiCHDYL6OyPEtWS2ck3FUobH/Ml7PboZeI
         86Fg+pzE0xt27l9SxaHxDHmIQ/vtKTzM1L1lStJNlkJ2CAjavVNsavKVILKfUF56IODy
         KdZhPCvitlO/kbz92w5UQRV0vlU7QPpCf+pPIy+DyedgLxk59olG3HSQpBQkeAWE6AGA
         tDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778755777; x=1779360577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2ELaAWxPWq9kV4aD5RtZ5GPohgOHYpCVcJj9TyZ2fg=;
        b=Vx0ul8rZ6DwABN8drAMyr9yR97OXoIhCYZnXTrXkGSeKQv0PT3QYwcsE9jWtj+wQwd
         yXy0/YH2VP1TSHObNIlXAdHp+NczgBBCb25K0q92oUnxvz9aq3bbTm7/o01p4KwqCDX+
         LldPA8PblD1UVt4kONYFEh+UiBYoWavxTkf1L5zq13eujWsJ89xcoqebVVPFGkareZKG
         P+PnDs4zd0zKvhvtOfOsqaO8wlMe0OYIQK7mthji9rYvBv7IHXChw4ehdDUVWPqVMC7e
         gocswl6S9icNCmZndXknSb8tmpL7RXD3xZwuNRRC+G26gkGQZ7Fv+30OV2EJRsiyU7K4
         sm9A==
X-Forwarded-Encrypted: i=1; AFNElJ9QtQuSsDHk4FIGYkQ34ELFFco1OuPibkOdSGpu4pfUF+s47s+NwIOBu8OqIdM6ewWqsJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbzZmGLkoVtFPsOJVShulpVkHKyBCoGSDH2McNuo5xpBhT67Q3
	LoH+iThUMaVPat8dGr7suWsSbyP5gyD092yjASZcTQa/GSUGZqrit/LX5y2AwX3dWW8=
X-Gm-Gg: Acq92OH/WwYpQ8OCl908w08skTd81Dt3qM+rYmakfAmbgRgzKS7JPiDwr4lkfXLL9fW
	dKU+nZweNRjwAbNGWHV4za8dwkENkVfLPl9+yhDhWS9HFKh9zl+VAJDRUPHC83uGvM6FPQXHGpc
	6KhoUb3tVNzsE6dGIHwUbcW2O8/wZ+5rJWds2iA9vNZDdKX11y/mFcmlYEcJ/Cd2VNpU6n6eRaJ
	Fyyxca0jWHedP23oT8+HivPamXNV1eb8nshDCb7d3ulpNhvHyIOuDVcQ5qEg5JOtB+BcxN4jlj8
	pjuFd+DtcHd8M7mTPE6vdnhKCxAdKe5pOQYqjaeyjyarM5PfF85yirS8j/EPRbFWlQZVeo8bULZ
	BPtzKoRGFRL5rWKN6Ly667fEBn9SH5Yn739MwuZee7+lmy5K8aH8aohs5T7nfn2ZmM4XftpAufh
	Xq2awTwjip7imd05t/RWtW8datpik=
X-Received: by 2002:a17:907:97ca:b0:bce:b80d:2843 with SMTP id a640c23a62f3a-bd3c18364famr554084766b.32.1778755776611;
        Thu, 14 May 2026 03:49:36 -0700 (PDT)
Received: from 2NNP224 ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dec7d1sm73895166b.32.2026.05.14.03.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 03:49:36 -0700 (PDT)
Date: Thu, 14 May 2026 12:49:34 +0200
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Subject: Re: [PATCH net] net: Clear skb metadata before LWT xmit
Message-ID: <bdyx3frk2qpw5ujueebmhpyuadfybf7jtjkr5fqajytruh4c3i@yddzh6pypa42>
References: <20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com>
 <20260430173153.5cd1d348@kernel.org>
 <87jyt78y93.fsf@cloudflare.com>
 <20260513172612.6dcc5887@kernel.org>
 <dff89f5d-01ff-4869-bff2-5c5b285cf578@iogearbox.net>
 <68a1cc81-80b2-4d49-916a-2d3aca4d54a6@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a1cc81-80b2-4d49-916a-2d3aca4d54a6@iogearbox.net>

On Thu, May 14, 2026 at 09:18:07AM +0200, 'Daniel Borkmann' via kernel-team wrote:
> Maybe the one case where it could break down is if you would
> try to transport data from container-related iface (e.g. tc @
> host-facing veth, or netkit) all the way to phys dev when there
> is tunnel in between. Not sure if it would survive today,
> potentially yes. In such case maybe better to move this further
> into lwt related paths?

That sounds good:

https://lore.kernel.org/r/20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com
