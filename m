Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E40138DC51
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324431; cv=none; b=S+cBoOLXnk7kuZB2KhVANI6h8iVnkBW4MppGGDZv5YVcKge1jH2VLt3eB0XkDY453QpQBv9eqHvANMF8dpZXsAQ/BgaOfZUljalnBtigX16fK+sntfjwcNrhjTNkSCcJEZqH4JRJ8ZmqTY/Zk2IpV2DROdVOGdIMvMaAA1za+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324431; c=relaxed/simple;
	bh=tqEGtAhnxbXL9GpbFYtG/woquE6EdyIaEmoKb6GGAOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njAc/BkNPC6rTGvqgSpInpi1cwGsbTZ3aDhccCmhtRDcJCQ+PDo6TDbXpe3VwBrKK7Uz4S4xiYxiLNW7cIHRbRMmnH60/c0zV70MJ146S5Mlma5F7fuSaV4/JDFcXiVu8osq/EUxcAUzdxYYoh1ROqivWU98+d67sKjDH2Gl0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oR8pV8YH; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR8pV8YH"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a81335d55aso1088143a91.0
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324426; x=1791929226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nuzdd06tW7sFf7TARBH4wDGelSXzM2xlPAPhaZjPmaU=;
        b=oR8pV8YHH20rjyYN0QHYj9CvyPKVaYMvDRDNIWx4f47I+sw8I9tIGv4CIFakPBkqt0
         HPXRn5+kL2+LYG+uTRUUlqucBGnXV0dX1Ob93Zl6TE/R1k4x+sCn6A7vmv8AnPA9+HpQ
         wXH2Jy4OAGHE96i7R9LWezHiLAfyUFcfH2CfLfgyA7ygJe7dZ4Vxc5uqPOu0cxkvuqhv
         LqsHhhcU8L0p68sAQ4ho7Lu4Ek6+WD1smuBGL/CGgHAgQEQ5B0+XQpQ9aOE5p5X7DTbc
         u6jLyqFSCeHQtwsC0A3NDvyxoPXXV/6d3S+SRZJh2isFcyGhfS4aE5jhvyysJuNrYazs
         CKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324426; x=1791929226;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nuzdd06tW7sFf7TARBH4wDGelSXzM2xlPAPhaZjPmaU=;
        b=s3n3LJzxfty7VHOgob5DaxE5i0mSxFJQLhHPrV1sdcNWdy3ugrP6RzLEgnTuuPSvUQ
         hEyQcsgo3IbrO9CAmUgjVG5GqbWQ3S0bbgkMnkH67E/1rfl/nlnfqE7XvRkQB5tab6Ka
         H06YOdk4qGnPv8h+M3HjAZflC7QTs8PgbY6BAabKe8P5t17CenOSJMyZovK13q6erdNY
         JaGFYBM4PKn7lXQoJkbDta9zO4i6THWKgqSzhWFQ3/OW68cLnmvRNjgXfFG2FwUwGN9T
         8D23U8Qu+0H3C0jC0zMb9TPAc3WwzOUMNhdVtPAFIItyEq+KtA4ldujXU2os9JEO9y+p
         GQ7A==
X-Forwarded-Encrypted: i=1; AKwUvBwGEcd8pjE0/lP43H8KMi6bW7MIWstnwYxLaJuXZi53qklXWHKKHhqNWTpAbtxwNYgUXBs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8xMow2+iQH2UJWMosXBXBKUOllTNv8sGZNxJeJhkyZm1Zn21z
	UwgqsJfJyune6OeDIdBct1ixQApRdS8aDyWyyLopjzvcPiy4aBTOlaBr
X-Gm-Gg: AYBFou3QPqQy4aSIUnqBSbINMfUvLgq+8authwH3pV8EQELNRGGRiR3iFR3+FuK0JrI
	DhK3J46QQG95LY95FG1KsydzN8FaFZWp5LoG6c5J6vaAl0G7beLxCKl+T5pisizSu2uxNhZVZMQ
	pZADKthz+MZhTcEUSQPgSPPuzGF4Xrg5YXErrpvRSJHBVKYOxREkm8tgO8DDpgcWk444qo5LOwd
	r8yyLyeZaVgq2PzvwwXnowmZ7KbfPF3zHY6Saj2yWND3imz1VQe1nigF+2OHqVPTyNTxmDKEwRp
	dy1eIhRdDJehI3E5hkuZQAzG346je7HMw4IopDFW+4OuTofGXNuqxX08Adv6BX/N7x2oF7MPgQu
	KapBrEzSUV3TqvKAtFhsRdf1hvWRrf07RRZ7OKOmav8b4km0vVYRbxpTLbPU3UdXbepWnb2yVBY
	0mmoCiWAbINQc3Fg4jdLDeUJ9jKBTASDc1Pb2uJpEDeSQf3I7lk4ePEA8AQraf0Ug=
X-Received: by 2002:a17:90b:5410:b0:3a0:f2c8:9ad6 with SMTP id 98e67ed59e1d1-3a8a1568aa6mr345073a91.64.1791324426453;
        Tue, 06 Oct 2026 15:07:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89d5ced5asm504174a91.0.2026.10.06.15.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:06 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:04:52 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 03/10] selftest: bpf: Use
 bpf_tcp_ops_set_flags() in bpf_tcp_ops_hdr.c.
Message-ID: <asVwfwx2Z3AxV_Ou@devvm7509.cco0.facebook.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006192601.1875100-4-kuniyu@google.com>

On 10/06, Kuniyuki Iwashima wrote:
> The next patch guards bpf_tcp_ops callbacks in the fast
> path with per-socket flags.
> 
> Let's use bpf_tcp_ops_set_flags() to enable flags for
> parse_hdr, write_hdr_opt, and hdr_opt_len.
> 
> Note that BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL and
> BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN are used on the
> server and client, respectively, for better coverage.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
