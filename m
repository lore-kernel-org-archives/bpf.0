Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670123;
	b=TCyTVeCyk4vm/0RM8cEYhdlbGHTOnyIBGc4ZMwrJ7yo2Zqz4nbHqTjqcZ7S/TfLFsRlk
	 NqMn95aWYKGDWUId93wbcpI8mfsgK0lLu4YIIx3VqbREx3hlH/Scu8u6Q0D/qbVolt3Qx
	 38eFIxCrBFOpspN5aLm7MVnXVyvDPlLRVpp6FX8kazdXmYhpRXHkcM5RN4UduDtQ1T9sP
	 q24/OtZyCjmxPsPV7WwtMfJJQgOVctaJ9Ab67JtFx3xqAYmMqao1vqJrtoehx0drxwrtH
	 Crl8wl5AgvQJc35/wwGOheV6ZWxwiflEodc6fPyGYXjAd/9JMWl2jCqyVzydhltts0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670123;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dGnaZBUj0XNcB11772fHKRR4jnMCSTKoOZ96EtQkLP8=;
	b=JYEYYfsGeKuuCcInlhS7DpC7HFhEhikBCnMR2SNhQVNs7qLqLA93idm7vR6QhC7tg03/
	 v3a0k0/usrkbaiN8BfC1aZnBtbOFXiMtY6QCDrIBW4RLJltpGDQTVLkENCAOQ13zR2N7K
	 qfmGDGDUIlC7coQrOCMQvKCMaLYvMLibiywcVaz2A0QlD/35tEuPzTZBacKWTscWNs7uA
	 7HbK5jEGf/80cBjLgcIsY46IljUxBQ3dzsSn1c0ElLAWDaAnT49FYsUfklwLhiLuu7H45
	 +xGt4lepvok/mHUUXiVWPYZGemxN2M+Y+iIhd+PfFbgG6QNmZPv6qnji/YUi5jisSpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fKH70yEb;
	arc=none smtp.remote-ip=91.218.175.236
Received: from mta0.migadu.com (out-236.mta0.migadu.com [91.218.175.236])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05860606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 01:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05860606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fKH70yEb
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dGnaZBUj0XNcB11772fHKRR4jnMCSTKoOZ96EtQkLP8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793670121; v=1; x=1794274921;
 b=fKH70yEbYDywQGAwgfKSS+FjmYqpdNjx/QAS6L7HT/xmTPtjFKacyw2MbKh0akpklTS9OHgd
 koVAORicRuRu3tQLsfJU9vw1xGIoAAdyPRjlLZcrpLoB9v3kYqa4Gj0jnTKUox/RvMJ0oLPNMh6
 k8yttt+zw5PAe78xF3bDXib8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4aed7de82dbe24fe;
	Tue, 03 Nov 2026 01:42:01 +0000
X-Mizu-Trace-ID: 4aed7de82dbe24fe
X-Migadu-Flow: FLOW_OUT
Message-ID: <f64dd211-6449-4522-92e2-af1d5f238f73@linux.dev>
Date: Tue, 3 Nov 2026 09:41:52 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 11/15] bpf, sockmap: Don't copy 0 bytes into a full
 cork
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-12-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-12-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Chris Mason <mason@kernel.org>
>
> psock->cork is a ring. sk_msg_memcopy_from_iter() writes at sg.curr.
> sk_msg_alloc() adds room at sg.end, where a full ring has a spare element.
>
> When only a part of the data fits, tcp_bpf_sendmsg() copies this part and
> flushes the cork. If nothing fits, it copies 0 bytes. This copy writes
> nothing, but it moves sg.curr to sg.end and returns -ENOSPC. Thus sendmsg()
> fails without a flush. sg.curr stays at sg.end, and from there a copy moves
> it past the spare element. Then a copy can skip the first new element, and
> the peer gets memory that nobody wrote.
>
> Skip the copy when sk_msg_alloc() adds nothing, as tls_sw_sendmsg_locked()
> does. This pass of the loop flushes the cork. The flush empties the element
> at sg.curr, thus the copy in the next pass starts at the first new element.
> Now sendmsg() on a full cork does not fail with ENOSPC. The prog runs on
> less data than it wants to cork, as it does when a part fits.
>
> The first Fixes tag is for the -ENOSPC without a flush. The commit in the
> second tag added the spare element. Since then sg.curr can move past it.
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Fixes: 031097d9e079 ("net: skmsg: fix TLS 1.3 crash with full sk_msg")
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

