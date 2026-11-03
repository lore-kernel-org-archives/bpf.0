Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674302;
	b=CkVduTwJpXTBhP8N+GzCSq20YhcwJHe6Ll75LhOGMziqLIid+TXMJcXBZ71gJIU4FOQT
	 SARNTeQjjQPjDeC/Vtf3qMQwwz6Ad2gRajkUCtUNNM/lnaOoZERV/Z9kkzQW0LSaIQX7U
	 2Y/M3oOXm9W8bTbtd2OgaGiDeN6Y0MoET5qMjzPSWtlSWDNvkmkz5WPtB4Mq9qFtxeOjs
	 OGjUmx54o0mGJQ5wEI/0IoPI8+bbHzP/p1anFWdhherttUBeZy7qEJmPA2iUe1ScNZ+yG
	 hPeYApfDltd+n1H8z7grAgClT8IKbIh2apZkcO8gq/6Zct5b9zR9fbb5gjF5Y9XqkYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674302;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=utwUhk9+7VPzUXEYzNonE0Edk/uShvzq3IaEsS1QgV8=;
	b=g1PtqQ07fsf5v+Dsgp20WOqmFm2SY8qYdkaBKo4ezNRl2kSsVA9wXVqZEH6kIZli8XPU
	 4n7Ihg/sl19JRYgrZiRm0W0AkgJEtD44afcd2JQ89/wqWF6iwZ+6mC62ccRq/jX4FUGGl
	 Ac0z0jYn+BkBmYHTz0rWc6PMqF0qkWs04CTFqe2HY5wdLB6hvSqj5dgzx8UCfkZH6zYnW
	 XsU5kCy8lHNaWkiTzzO84THmhs6h2Y1xdGBj/moeLJiPwcbj/HfZ9VszM7pTUQlp8HCi0
	 pwhRegkN2HnQMSM1HWWQEoSGCnfzpNzBFckFTLU5oJOUdTyECWNbK/X+hNwwuoD0LmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=id4W5LpY;
	arc=none smtp.remote-ip=95.215.58.129
Received: from mta1.migadu.com (out-129.mta1.migadu.com [95.215.58.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7B606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 02:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C7B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=id4W5LpY
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZcPdpIiVqTYoAsjDU4Us1BMEE8qTlTBCdbodw93yRjw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793674299; v=1; x=1794279099;
 b=id4W5LpYlhLzo74b3IC8L4iqxW2CCLNO9S2PAcoan9efMPryUQPX7QTuAW4P2g6z4gWNOu/w
 m72QNiDNCpQrELRfRrB4RskiIkmYs0EuEkzMGCRV3kKnuje3lsOSIXczxQ2WDyYRGlHBJOgzfC+
 MiEhi7G5H159Q6LxuJCI1G70=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ecb1f28cdbe85820;
	Tue, 03 Nov 2026 02:51:39 +0000
X-Mizu-Trace-ID: ecb1f28cdbe85820
X-Migadu-Flow: FLOW_OUT
Message-ID: <428e6bf2-9e6b-4f7e-a36f-cd6a6dbb2122@linux.dev>
Date: Tue, 3 Nov 2026 10:51:16 +0800
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
Subject: Re: [PATCH bpf v2 15/15] bpf, sockmap: Clear the end mark of elements
 added by push and pop
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-16-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-16-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> The elements of an sk_msg are in a ring of scatterlist slots. A free slot
> can have the end mark, because sk_msg_init() marks the last slot of the
> ring. Also, sg_init_table() in tcp_bpf_push() marks each emptied slot. Thus
> sk_msg_alloc() and sk_msg_page_add() clear the mark of a new element.
>
> bpf_msg_push_data() and bpf_msg_pop_data() fill a free slot with
> sg_set_page(), which keeps the mark. Then the sk_msg can have an end mark
> before its last element. bpf_tcp_ingress() copies the mark. Since the
> commit below, __sk_msg_recvmsg() stops at the mark and frees the sk_msg.
> The data after the mark is lost, and its pages and memory charge leak.
>
> Clear the mark after the two sg_set_page() calls that can fill a free slot.
> A free slot keeps its mark, as today. tcp_bpf_push() does not read the
> mark, thus SK_PASS and egress redirect do not change.
>
> Fixes: 9974d37ea75f ("skmsg: Fix invalid last sg check in sk_msg_recvmsg()")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  net/core/filter.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 50c0cda778db..d68b52150405 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2995,6 +2995,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>  	msg->sg.size += len;
>  	sk_msg_clear_elem_copy(msg, new);
>  	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
> +	/* A free slot can have the end mark */
> +	sg_unmark_end(&msg->sg.data[new]);
>  	if (rsge.length) {
>  		get_page(sg_page(&rsge));
>  		sk_msg_iter_var_next(new);
> @@ -3128,6 +3130,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
>  				sg_set_page(nsge,
>  					    sg_page(sge),
>  					    b, sge->offset + pop + a);
> +				sg_unmark_end(nsge);
>  				sk_msg_set_elem_copy(msg, i, sge_copy);
>  			} else {
>  				struct page *page, *orig;
