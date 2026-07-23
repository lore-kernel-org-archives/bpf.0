Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BDB47DD4A
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808089; cv=none; b=JC98onDskvwMnBSZVU9hGoA6WEnVHXfhQLtLTE++xhAYLHm0eXwFmFSV2gETVO02ecxrpu+5khaGVwttBhTpA5n6lwc+hfa+35K0dQ4bMJ5AERxzphkjf3vp8ZZ4ZQsbvi3y/Bz/kf3zAhdHTDE7makVOmdSopuX61Youfe0Cmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808089; c=relaxed/simple;
	bh=VhvXNNcxlIZQB3tmisgrhWDXnzRc2mufK8ra6Ac2TC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNYajKjRj7XrhZJg38RdlJ6FWwVw8khiCxh2NH30kf9NdnaFx6Q1+KAL6AAFSGyQnY0jNycj3HN+5uNOn8wKsCpIa9f729y6NNs0IvgLG5N4kwD7C60bAhvSAJW/sIgxbdDe2AabJ1uzSwgoL40igyuPq4JqHtpPlhyZrFS+8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=H5mszQ7n; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="H5mszQ7n"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1c52d920b8so80824366b.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1784808082; x=1785412882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PkrX/Ja8Q0VrDbJNxzAbjjCsD248bt/Vc77qR3I7Xuk=;
        b=H5mszQ7nFu7UIR++BiKmotzfRtStyeBih2LCSzFooxL6HBy2No+WPVBXMDP/95aEOA
         M6GawiR30SnR/BS4gB+muVeS5x8+TeedpIURg+qFx+UUZEyWu8+wdmxhfDHiH5lPrvkB
         U8zYze8jLUcnCCnuptXvBzrNNDQTNmZUo52ZePwQQh8ZObGfHzvPH6mJ3Wzgp3mRjCvT
         vQyXMATOloqDLCyT975fJcs8u6ndQPriaMPu3GB2BToGm8Os8tdD9pX+dtsgPpyqIH9o
         Y5BPPyErXMKhZehX4yFK09YkU+k9eJT0wr8H9/JJNGeb5dZJ35LoeCZIgksS9tECmr+m
         QZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784808082; x=1785412882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PkrX/Ja8Q0VrDbJNxzAbjjCsD248bt/Vc77qR3I7Xuk=;
        b=loxkPWPBSrXvQFlhBEMeYlBbzH2fTDWBkXVxjddA/KVFTfLbW6KQfz1t9MC9bverpm
         F3YyBrc84LgNTysQX1CT6Z91ANVd7dyd8PzTLihvX0jiO+3/I0ktw6Kmof2UYWN49IlE
         i9jmNKXaAaXBN8UN5FSlDkeDYHPQrncVjkGCLm3hrsg9MuI027krvXkJNGoDu/Nma8HB
         s9O3jQubGN+r7zAhuPogOya6LkvSLqFARmcbT/Nxz8wO39co254kB6+gL7bC5Y3/qMWp
         DIo0eLq44rLkMR6Htyv8C7MzYeLGVYnkLnQdAONvgF7OXl7Z1CECLf2RHgxeISE06veT
         Mrzg==
X-Forwarded-Encrypted: i=1; AHgh+RoYr9w8bY66uqRX6rPoXrOKH1NOdqjN4JcCNefpVJa0AneWUOhOT5NHCPYggZ+IFisoG3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyb/NJfgqsCosvzskHvTHl7N8IGoOsDkuMMCdWcJjWywtW25z
	OteTt6lXW1NJRGobyu8prLP8fWNBi3kKu+MLjH7te+XhH9wFY4LN3MKlGKbjRcbe2zIQkcHtc2n
	8SJ7M+pY=
X-Gm-Gg: AR+sD10vAdBhXi6XlIC2XiH6/qIFetUevHFWTQ9OFaVzJKc3WwSh5nIfOm7XTCVfYUF
	UsJPCqhQlZ3MFloyrf8KJ2SUFGpj61REJ/J8/u1d6jF1b9FlNa1SdBdrktd+oWkPOlMFHm3Y4E9
	OOXeawNr/1ie2J4IF+3a3ZrQsUjHLzqn66F0GWKxAY+d8G0kLH9bGYywxLhnavSdgd4CXL9KERL
	9mjesPksXjeu+cawwrWimYmPAL0LsziW7BuNigck34mggjDJX27LnBdMxnCEcDiYZAMYPe+9m4A
	H0jjjl+PSjFez8RbK/KFMu1H9qfBP0SjttqplxzTM4HmGlekVKBazY5BgsaMAQ6d0YGkSZM9Bap
	saO86Z3cfsWsAUDKH/LTDsg8nqnuRQT3I6d4PGq950Xl9QRQQlmvBSGLyU8yx/ACT
X-Received: by 2002:a17:907:e1d2:10b0:c16:61d9:1679 with SMTP id a640c23a62f3a-c1c50992bfdmr78318566b.52.1784808082255;
        Thu, 23 Jul 2026 05:01:22 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1cdc::2e0:3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ebb98dsm220560166b.48.2026.07.23.05.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 05:01:21 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:01:20 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH net v3] veth: convert frag_list skbs before running XDP
Message-ID: <amICehHZJgV-mt7S@matt-Precision-5490>
References: <20260722191925.2192070-1-matt@readmodwrite.com>
 <C8A20909-E6B4-419B-B6D6-35EE7DE78C79@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C8A20909-E6B4-419B-B6D6-35EE7DE78C79@toke.dk>

On Wed, Jul 22, 2026 at 10:53:34PM +0200, Toke Høiland-Jørgensen wrote:
> 
> Please retain tags when respinning.
> 
> Reviewed-by: Toke Høiland-Jørgensen <toke@toke.dk>

My bad :) Will be sure to keep them next time.

Thanks,
Matt
