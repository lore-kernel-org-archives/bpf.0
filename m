Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793669956;
	b=Bm0U4pKDZM0kusf6IgC3zk8KMzV4+m7MRqAHxMmhuNwRzI9PK6YGwU+gc0hEj8qi1m8p
	 5oxRK107XCqwCehemuX4BXrOJm7b8B1aBF8eKizWIb+fJGYvU59d+no3T2g7FaS+Fos+2
	 bq0ah00rDol+SvLffEqf4zq+tZgad7+sGODgbFgQJ0Sj/nFwVAPn7Js8R6C1hWcrWrFMd
	 /loHn8lnRfFRHu5s3T5Jdw2LI1TVnTq/9ee5nWb5Ypa2W8OWgex8uU1jweutJqMGJq1Bf
	 gAmJyuzulr1v/olJlF8wvEZ31U0xRUeNQsrT3Bo8mkO9uTd0+zReYUyvaV4Jrce1NDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669956;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HOxjTWq8USRbKf1NHRtOCVdwPDHFFHRlSbuWNNCvU8A=;
	b=yhkLAMerUWXQE6gu3Gf+byQ7v0qa636SEEv2AARWz9DfZoVf9QVE1UyfyuM2dh8iNX3F
	 VsYjzUej8u5S0zXk4SaonXim7dXHKfix2BNfa45iao0wt1Nx1jVYjLdtp5Jzo+53dHi4L
	 hIExNBVIcuecN6dbx9cl+BqnzBJ83Eph+sAO9rWlBXqmd5km7wsFu/tgy8IdE5MmBg7YB
	 uo2INLW/11FbJ8Q44VCOYT3nr/nu2ph4fNzhvfOfK5Wz5gvnHJRSgk7uUKIEjabxv5LCt
	 AaQ4Sk6PZ5FvhD6iSHczH+5VRKhFvA4gjiUFqS+HWpaAT2tdSlitEcl6vKLgf9zJx5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o+ZYmuFF;
	arc=none smtp.remote-ip=95.215.58.188
Received: from mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD24606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 01:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BD24606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o+ZYmuFF
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HNSCS4mk/qPWR2K35tmQ3WR1yx22JuOv+/Tg+3LgkOQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793669951; v=1; x=1794274751;
 b=o+ZYmuFFCw80PtIe9GxnWrv+TzoFQwC2HC/VI8N9PF6H+1XGdT8M6JU2vBASGGoUsoj1wFqQ
 r5Hdg6Ql0/OJjhmpHEhP8TCxpjn3YyfFAuukawKSD3F0ohNt97PgJmdvs/QTqm1YPgcmnt4m+cS
 Tz6Hqj+sn2+xCmbM7uic2I5U=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6da7c6571af7a7ce;
	Tue, 03 Nov 2026 01:39:11 +0000
X-Mizu-Trace-ID: 6da7c6571af7a7ce
X-Migadu-Flow: FLOW_OUT
Message-ID: <c5a1ce12-2c0c-489b-840b-1cef8cda999c@linux.dev>
Date: Tue, 3 Nov 2026 09:39:04 +0800
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
Subject: Re: [PATCH bpf v2 10/15] bpf, sockmap: Reset the copy position when
 corking
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-11-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-11-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Chris Mason <mason@kernel.org>
>
> sk_msg_memcopy_from_iter() writes to the copy position: byte sg.copybreak
> after the offset of element sg.curr. Both tcp_bpf_push() and sk_msg_xfer()
> remove bytes from the front of an element. They increase its offset, but
> they do not change sg.copybreak when the element is sg.curr.
>
> tcp_bpf_send_verdict() can send a part of a message and keep the rest as
> the cork. tcp_bpf_sendmsg() appends new data to it. If sk_msg_alloc() then
> extends element sg.curr, the peer can get memory that nobody wrote:
>
>   old offset    offset    end of data     offset + sg.copybreak
>   | removed     | rest    | not written   | new data
>
> Move sk_msg_reset_curr() from filter.c to skmsg.h. Call it when a message
> becomes the cork, as the helpers that change a message do. It sets the copy
> position to the end of the data. Without removed bytes it changes nothing.
>
> Fixes: 91843d540a13 ("bpf: sockmap, add msg_cork_bytes() helper")
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

