Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648198;
	b=0OKuQFTdXMT4QCMVD61V3fs+0O/JbwuN/WbzD0A9hcLFpfrbUMziz/6fOoYIheW+c7Tr
	 jvIhYnGdv/dv2QJdq8Vg8Mm6syoeWs4O7mMIbYIpsa1r3UONPd8q87GonMD2m0E8UY+zE
	 riDoosw09DCQ1GoXdIlzNw0a1tr68X/eIPvwYZtAdr22oLFTsQi0iPym4Y+yVym8SY5ki
	 ND4jbe++wEj934pcVRYfSLegKM5hrjW3EHFjcjdALm9xIT/J2b3Bsv7pSmLkRavU3V+F5
	 P0Ynw37Zxh7OiFBllyJtd6lHAr+xTVkzGw5LHQboaJIFTvvcInjWLVvQJ7SilU5wUDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=z+7iqYy4OkIb8W2YjxUcaoM9qADwsgWhehmQGnSdoNY=;
	b=SkLi0TIKsKwoVqaAhYX244TdMoeMncGnvKzMGzSkw9u+bXGOY7VNgG/439Tf6t1NQqxV
	 iSrXJHYdceAcZPinvde8/ZKf2THR1lAPw2LhTnzcf6NLeadJ3vvgIN7PrgMcQ8zsstGae
	 0Q6RbhueIfbMu46pn+qG3Tak05dKBOf2v7lQjG70Ree5PmwlkpZXvECWEFx2qgggBBWu+
	 E7aeWtj8jZXWQMFkdEZ0YNBuC1m7g8cdhCpdlCUCG1V4ebth10oK3pRbCNOLL/nI86rqA
	 tnZOMVnyFe9D6XGoeOJ65Uth2Dx8wY6Khczah/EHQgHYTR/38V8FMeo/Qra7v1ezJKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QbUB6MkF;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E59606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69E59606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QbUB6MkF
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e985106c0cso32104995ad.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648198; x=1794252998; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z+7iqYy4OkIb8W2YjxUcaoM9qADwsgWhehmQGnSdoNY=;
        b=QbUB6MkF8hjayv2sm1ZOGDz7bZrtbGpg4x14g6XZ6y4BaqeIUqcnU3uZRqQZAq+Z24
         RCrulzK1gnDaqLCrozH+lc9y6EcLvca8ij2erDoG1e3LVCToH3JTHnhbyBFPxxxA+O4F
         u5tRXHVH3EO8yFsc4m5MJl9KmfYXFIaVDV3bqIFQmy73dC85l1Wx2+dgxcXUByQtNA5b
         wVdcA36zRbicVQFsmWckbD1kRLHjEysCTWsOSWsyxnzZeWGQrHhz8nsMeR79hZTdodjC
         oc9IG2TtICIiRWNpGh7QZMqUfigvTJ4XBMX7NFnyMATd5qXfiuSlpCul/+gfVShlSar+
         D8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648198; x=1794252998;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+7iqYy4OkIb8W2YjxUcaoM9qADwsgWhehmQGnSdoNY=;
        b=y4e+FZe3ish0egDUunTSgwC4St4DUy7dGm1mp5T3pKlAKJgsNHs0F6Olfix5oNZIOc
         c3pjHkaze5M6KA4A07Hi+9FJ8YgPf4S4laKiH3zUoEOI3Di1I0aJokKObUXeONJEi5Yd
         +qMVgZ5ZsBLq21J7vDdfJW2sbR5HUu+NkIL7td/C8/0l1i37Mdy15v6RIi81YMqGvzER
         4KVkSe9dyxbZXC3xOZJKTEjo6Vp6aIu62RgyffVXegU1+RyPwmpztZLAhFkY07OkD48g
         kMcWUKGOuNX6Kp+ZzAjl0MjBUZit00Z171guaJD0wcqdpchor1kKlfrV9YGIcAwbezR4
         tKxw==
X-Forwarded-Encrypted: i=1; AKwUvBxHs6vMH+yAzFBJTrhOOzWRE5S38AjxvPSQF2wSEomF1bZcpuUVqPcXN8uTx93o3MpJNfQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MMxIBPnQU+EiTziPZSMv2V4DQbnDM4bKJl9c132hHKTjvZqXH
	TqdSI56cuxA4KmUnn4ZCX2fVX2FxD58O40pe4JUnQAr26z9zmOktjM4h
X-Gm-Gg: AYBFou3P1gFhh1pCaxMysbWKcRiXvJ2zR/ChEgSTsj2ZJMbpF2FFKg7kMysm7lxivUw
	0bicP4kjtk/eKNacFoR0iWSJcFJHk2hAqpwcdalAgGlllc3udtSGGRhdDcDPVxicuT7il02KUxd
	lYPQ/0ch4wRnAeWp7II+Gl/sfgCiAyNe7dtI1vdw/mzmvyjE8M1NAnd1E81xK6hcU1YH50H/dEz
	SG9IKae6aX6zjVCcCYg7uRKrcaryAZpD9iE2RzNufLJ/oB+tVYfAxyuCrUSWmbfOo3Es1EuVyoh
	hLcyFTY7X0o8a4e6eot3cm3vl/MzLkTCfhE2E2izuTa4/BiVUycyzBfK5x1wpO/U948Gsh9YDH3
	mcXN5RFH9pntaDU46sT0FAfq8hntFWfx5G4kct4bXwIQxtITVHNH+LMp4Cmj+Lgi9qIXiYV2bbT
	32kp6U0kxE+kTL2CL0WqIqQU7Vdmj/3wXDHUr+jBQ4aVtNsf4JQDu5t7tWZ/jegVNGzjaNnkb53
	K2oIFIvwn9sctgh7pAfpgPBRRz1jeBBYl2a4+caS2iMliLLEnD5sRmZRd9WKEf/3KNzgKzLLM/g
	yIKS1I3/K1gKKPJkaTxCFMMZ3vj1T7IntQStuyXpMWVasQfyJajHPQoMHPyTf/SSZy17
X-Received: by 2002:a17:902:e5c1:b0:2d6:e9f3:9305 with SMTP id d9443c01a7336-2eb36414ef0mr104248555ad.5.1793648197830;
        Mon, 02 Nov 2026 11:36:37 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392965fesm31536785ad.59.2026.11.02.11.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:36:36 -0800 (PST)
Date: Mon, 02 Nov 2026 12:36:01 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an egress redirect before each send
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
Message-ID: <tnw3t0.mxmnzrgt0n6o@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 00:21, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>From: Chris Mason <mason@kernel.org>
>
>tcp_sendmsg_locked() expects a caller that has the socket open. It uses
>sk->sk_socket and the wait queue sk->sk_wq. For an egress redirect of an
>sk_msg prog the sender calls it on the target without a reference to the
>target's file. Both pointers are NULL before accept() and after close().
>close() can occur while the sender sleeps. Then the kernel crashes.
>
>Fail the redirect when the target has no struct socket, or when the sender
>has to wait for the connection. The error is EINVAL. After close() it is
>EPIPE, as today. sk_stream_wait_connect() calls remove_wait_queue() without
>a test of SOCK_DEAD. sk_stream_wait_memory() has this test, but it can
>still use sk_wq after the sleep. This patch does not change that. The
>target can change while the sender sleeps there. Thus do both checks before
>each call of tcp_sendmsg_locked(). Clear MSG_FASTOPEN, so that the sender
>does not call the connect code of the target, which uses both pointers.
>
>Today the sender can send before accept() and waits in SYN_SENT. send()
>with MSG_FASTOPEN sends the data. Today it fails with EISCONN. When the
>redirect of a cork fails, send() returns success and the kernel drops the
>data, as today.
>
>The Fixes tags are for the two checks and for MSG_FASTOPEN, in this order.
>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

>Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
>Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
>Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")
>Signed-off-by: Chris Mason <mason@kernel.org>
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>---
