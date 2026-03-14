Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5444204E
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446628; cv=none; b=uJJ7zey1WPqKqHsMf17gk3Ix6lxZnRISn7GOl9Eagok+B2uInVCw8GKPSSrMK3ELgyoOsSe+jx9UeL8hCWYiy4KRBsRhTT12v1Q9i3uDAZ/t4h/NBvF8Qla82HkrSFIeOZPtr/IRTCujLZGcL5QQyeYyKHp73U3fu1Qy2MLFSBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446628; c=relaxed/simple;
	bh=1IpDbn8F8zKHinBsi3h9EdQBKvspX2BPCv/f104MPeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMaKS0/9UYOLpG0HlELbouwvupsRlnENNhq5Z0g0JOuMC2KwWC6H/8uftJyhFQEq0KTLBNGiDxfbQFSCWrpwgv/FJrQE2ORRPPe9LXP2JjLk4bhL/IB1CL3LT889ebgBb7e/omkcOEcQNsOpDcnQm//jC3S15BreeGFrdhP/hnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=d1RZ/pEK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="d1RZ/pEK"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3591cc98871so1323150a91.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 17:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773446626; x=1774051426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+XiywP7V0UQEUfGj2DiJzWJSmdJ2SC9ctDq/9BKbNI=;
        b=d1RZ/pEK4u6XBSe4J2xY5iGXz+Yl1yGGsNE2x5UYMF2PHqHwn6KjwAOAWoX7Qovkco
         +Xp2zLNcm5sDymTAqmrDJabMD3VnTPsT9oRhDD+jJKJqOJK/szPe7kEu1VNG/xdXyY5k
         llqc3ZljEwC79BjWAqxfPYF3VOwYgelA/78+JwSVIWGu/JBFkjkjb2gishQlZmjm/6kc
         ljMtWAx2N5EQPFLWESoVAj/6+rhi3SoeQdNmAJB59fzewr7p6nzDbKbUtUeDmVhD8jnj
         2vEXOIsdkhQkcTGis/ZH0ZmQk820xhPZYOjN8n13rCEHfTjVog87z0xE5o5DuEkoUXX/
         oIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446626; x=1774051426;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+XiywP7V0UQEUfGj2DiJzWJSmdJ2SC9ctDq/9BKbNI=;
        b=BeFc+Nw7DlZudEurPJ7QknNHoWkwrEj6gKGSuHGjZcWU+kRoQAioFmzl7CfOqSmFA2
         Edey60zZq8vKvmgMrr3hy50n2cWDb41qThQEIPSadBUnu1TYp+UYR3sPXugGXgfxjknm
         GXBZwL9whCi2LPS4Zj30SeRo3p1Kkfp6K1dg7Tje47PooJEVlIEvqAo7ZozAgF9jSeWh
         jvPCt75bT85XJ02EiSlfWZzB8b8atCJ/OkXu/SOc1JhGe5yUdXT3JW9Q4hyZqw7osQXl
         R1Jlww2g7XBlYRQV2L0v+5/Jny5zKh8I0uIbtX/WNaBRw7/VPz561IkxxBO18sh+bP2b
         kiiQ==
X-Forwarded-Encrypted: i=1; AJvYcCULMQDYzcEBpBzI/eO5OMhzOUCRsVHB0eo3iwwYo2u4ijdGy6n33D/kZUPkrqJNalZKmFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGIt2VwdYfqgCQNKDYQcP9qfT09pda7kVSjE/JkO03ctZRKUYT
	hD17XWarmJ9QKvW9pa4N4+VcsrT2S7EuQPWng+a4G2xoIGeHTZaetKV50WmON89RrM0rNc5apP9
	Sko0jKow=
X-Gm-Gg: ATEYQzxuXr9HBjDsz/8ukCVg00VsRJMSW7g+mzaoDHn3NPschmplHJezU8jzq56WCDN
	nRkhPW0A0vhQzxXQWFKfoa6rrc1HWqmJNQNirBKMdupyqSaRgF0fDzrtrcL3nV6AzTqs2is/uyW
	fNhRSm6L97c4s+OO3HmLc5o4KkcbVprzyUYAroAf1gcxT680DBSVaXGL4jIHxe8amIflvXgpPNi
	QWRGyzDsL0IxHK6HzF+Q7s0lIq4VOr2BAYmAPKPLxCZgXHt6VvNBWtzKQ1DEpEdj0YIMauqw90F
	/P8tnGLHP0dedNLgJ4fY8UemwHEGwrnA7w8ruzLKNBce+E7pE3cXENkAOCv9Y1MU13N/BDdXTi1
	X1CvDhako8hotELCboZs/vp9m9g0mZzgYH1p6K0qjVoBXI+osvEw2sBnG+6GKd2QAcIbCQJMn3n
	v8xEn2
X-Received: by 2002:a17:90b:4c48:b0:353:5c16:aa7 with SMTP id 98e67ed59e1d1-35a220fb316mr4566826a91.25.1773446625823;
        Fri, 13 Mar 2026 17:03:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359fe40bed5sm10340191a91.5.2026.03.13.17.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:03:45 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:03:44 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/6] bnxt_en: Implement XDP RSS hash metadata
 extraction for V3_CMP
Message-ID: <abSl4GNkVtsL+r+E@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260313223029.454755-1-carges@cloudflare.com>
 <20260313223029.454755-5-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313223029.454755-5-carges@cloudflare.com>

On Fri, Mar 13, 2026 at 05:27:34PM -0500, Chris J Arges wrote:
> This adds another conditional when cmp_type is CMP_TYPE_RX_L2_V3_CMP for
> drivers that support this completion format.
> 
> This re-uses bnxt_rss_ext_op to provide similar functionality. One
> limitation is for L4 hash-types, protocol-specific bits can't be
> determined.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
> v4: re-uses bnxt_rss_ext_op
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Joe Damato <joe@dama.to>
