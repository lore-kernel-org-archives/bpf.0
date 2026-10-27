Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793062856;
	b=ZpmiTU/6bF/fmPfF9/ZXEr2fVip+0e+ZmeU9DxOS/F0i8zVAwrV10uPCTtK5H55uDXlG
	 CbdNSRtgGiNN2Vw/axcKp3ImtuURWx5iValSORpUhSLg5VYq5Pkkok0X9/rmBbT1Tzv9b
	 wv/S2fTRh5XL3sqK50XDdZRr9MHJSpHWmbEpqo3IjbfdtyESN84x1ZOqzDPZIhnFNXJVA
	 HorbQevMt+eZ+L5opEBnuagFC2RkKSKBsm7DXff0alkscqG3k1nz3AGgobSyKgFb8vW+w
	 7Q+ADhPPOYAWXF8igSHwEHifCmp4d+wa8SRyEQTS/aGlY0v7gL2ZAJ+04K0RC1cklCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062856;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IpKX3swhrQlMom0lLBqI2ODq1LUXSCgf1MJ2betI5Bw=;
	b=0qtod85ls0XWaHNmslm+FQg4g45B9mVsrQ05Zx+PhdkkO5fGZMXxvYq7EWATlircWLnV
	 7WzSrRRE765bgGKUs23oHlB1CQuQVlbDZDLE9hMC1TNOWEZebn1nyFfHwISQy5LZdNWzD
	 fUUrDy/pcwANQWjQEEADeogmKEU7IP06BUQxksFkaxBxd9DK7wvESKvjMvlp2+AUain47
	 rbXxTeotUIbM6le/ta4dlxujegisA+fWvYStpHEZrMQhNtD33Gb2vu98Pj97bMSK3BeIu
	 gHflKbicPmPmBOjhMpQqwz76zCEKztRSRbYozG/z+SkqvA2lmcb9t73dTX6EJOrHa8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYmLgL5j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5F1606A31A;
	Tue, 27 Oct 2026 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYmLgL5j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BBA1F01825;
	Tue, 27 Oct 2026 01:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793062856;
	bh=IpKX3swhrQlMom0lLBqI2ODq1LUXSCgf1MJ2betI5Bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NYmLgL5jtPrzu2kFeQtykcdKKCkekjbgy3pWStJTvk5SQKobBWxP/+SY2itN1Qrud
	 qjLO9Mxu0Q9JX7wbdcb48SQGVmfvfavo5R6CYeLQi3fNIYXZCtg4rnWlm6/Ksq5i57
	 sDKxPGKDmL0LW8Ast/bcgGytEhTBaA3MDIEhtTOxbDZjRGEMJGgWdkOVUf9tG4yZLr
	 Ica/b/8yA1VBp839V6yyJjhGmuKvr7lOy+N4zAA+hxQGQQNmEXwQrXIbI0LQpMVNnl
	 swTx1gOzlZfPlBz9h0FROHCuiUl2HJyldjkMh893H+NL2L2gK39YC4ZK+6MLJP4aW9
	 rgtl0Nczu8ZQQ==
Date: Mon, 26 Oct 2026 18:00:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weiwan@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>, Jakub Sitnicki
 <jakub@cloudflare.com>, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: Make PSP skb extension survive packet
 scrubbing
Message-ID: <20261026180052.04dd1110@kernel.org>
In-Reply-To: <20261025040523.678027-2-weiwan@google.com>
References: <20261025040523.678027-1-weiwan@google.com>
	<20261025040523.678027-2-weiwan@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Oct 2026 04:05:22 +0000 Wei Wang wrote:
> +EXPORT_SYMBOL(skb_ext_scrub);

Why the export? In fact as of this patch set the helper doesn't
have to be visible outside of skbuff.c at all.
-- 
pw-bot: cr
