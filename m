Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA023909A2;
	Thu,  2 Jul 2026 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977426; cv=none; b=eSG2Fz7mGtOyr8sBfTXcKxHsX7A9OZPSrO9OHN2vBbK7Ln4t920iqsss+AoFrRx3+G4nhq7tqAN/bdUlpEosXkQ9sDTBBpRnsLn9k7jFu+4stYlpEKoG2dg/XbR3sC4b0NP93h82fH3ifz8HOhkHKx6lU3+h3Alj0QvjDlB12HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977426; c=relaxed/simple;
	bh=R8nBOFgR+ufGGDKb1xf52cgQ4BydgEOLwmej+qbiPoM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FsBsPmJsGhP645K7jDKN5BQdNvN9DS8f6tFF1GeopsOEtr5zURTl2l9kZQcZaOJy4JkAATryd67axYN5LSDdZP6uEWTgozLtGtKh1ejutWK/XxnHMldX/xe51PR458u+UyRn0XhJU7LtDv3cX/3yWJwIwLLxl2YLLFuymwV0u18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=sz8R45B9; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="sz8R45B9"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wfBsI-008gZY-IW; Thu, 02 Jul 2026 09:30:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=GpnWSIisMNcORXDNNfaeBjgR31J9QL0FH7f2GqB6oNQ=; b=sz8R45B9fyt1hLnzGWzWfEHB6a
	Mb+hotCiMnYjqwMD7m0SH+pjVpcGE6jLTfN3rUNPyQXCA0sZ1FSRHAw5tbyy5THMV5UIpEZecdW8M
	PL9qEeyGDwvzNAtGX01wxjX2tbDfqqxWCdvHVqDbDtbVUWbzNXosv7nNWB9myOsbA0Ja6pYUsprDR
	3r2223AG5Ra4OBVl1AYfQ1CyVq7rBEEOP9zsTXXldqJAFFTK5DS8YuQT3w810S/q5JkLW57TxIuXB
	/4aFgdBNi4oCjkqpTE+4cqZe4zcaUOPFKAFsyX6aPxjq+VktiYMEw1ZlNUJprNJq2sRKJrf2UbLZq
	cz+MEECQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wfBsI-0001sg-5b; Thu, 02 Jul 2026 09:30:18 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wfBs5-003H6L-TQ;
	Thu, 02 Jul 2026 09:30:06 +0200
Message-ID: <a025174f-ac44-4a5c-863f-e00fc5c71b0b@rbox.co>
Date: Thu, 2 Jul 2026 09:30:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v3 2/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
 <20260702-sockmap-lookup-udp-leak-v3-2-ff8de8782468@rbox.co>
 <20260701235552.2B0AA1F00A3F@smtp.kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <20260701235552.2B0AA1F00A3F@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 01:55, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but does the same refcount leak
> still exist for TCP sockets?
> 
> A BPF program can acquire a reference to a TCP socket in the TCP_ESTABLISHED
> state (e.g., via bpf_sk_lookup_tcp or bpf_map_lookup_elem on a sockmap) because
> TCP_ESTABLISHED sockets do not have the SOCK_RCU_FREE flag set.
> 
> If a user-space thread concurrently calls connect(AF_UNSPEC) to transition the
> socket to TCP_CLOSE, followed by listen(), inet_hash() will dynamically set the
> SOCK_RCU_FREE flag on the socket.
> 
> When the BPF program finishes and calls bpf_sk_release():
> 
> net/core/filter.c:bpf_sk_release() {
> 	if (sk && sk_is_refcounted(sk))
> 		sock_gen_put(sk);
> 	return 0;
> }
> 
> Because the flag was just set, sk_is_refcounted(sk) will dynamically evaluate
> to false, skipping sock_gen_put(sk) and permanently leaking the acquired
> reference.

Yup, a known issue:
https://lore.kernel.org/bpf/e08be4f5-0bd9-4228-843d-86ed20594bac@rbox.co/
