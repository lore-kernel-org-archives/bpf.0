Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4021C569F1A
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999704; cv=none; b=VX0C/AZDElc9vTYbwbTmPT7Es5cwlOeDqSX5JGlfZ0NUApfkmmESRSIVEIDCWA6865wVcTjvHEanibxPUImTFfTUhCuUJgoqhr/OHo9sogxwiEqHI2S7NBloRz2Pid9goVLcwF8JGrTVviCeNlUQdjVEaZbpD+AJL09amhceP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999704; c=relaxed/simple;
	bh=hJiXXW54w0qUZXfnK9CVMzygd8SH7dwnkWHP5F1VjjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QpHkF5bw9miaRKLIXNyToSUs38MQQbH67CjShOTm26tKTz0CUvpdFr/eq92VQiFL2284AfKmIjDToVXdXHMxE8f1bzt/mNdkWYLkLIDN8Y4YOGEgUV0ODQCc/v5bB9B24jDaPp5x9zZ5wDRcKjoqzkzBtqSqX+I2ydvpgmEmey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NbuVJq6e; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NbuVJq6e"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c3156e7705cso223563366b.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791999694; x=1792604494; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=urMVj8JzD3NiB+saVlxwn8HdeCLu3WGCkEIWSX5UCag=;
        b=NbuVJq6ePbtMW+4yoHTEbd0PzS8B/iVVcWdC7NDUkGSFlJY4ErRLKGjQUyAGkGKJ0H
         oBj2JMeqsa256MUIgop65L1uWgSuRsHVKF/6n042fw8BbrGJxPkFdYYQwSZZsJpsWWr/
         PpHBuMCXvqB6I+3fdJllgefEMfcuKEERSGw31FO2Isn4gw3Df4+JxRSDyCK3ZRLrhMMc
         3bNBqvYinuab3qWp9lxDlcVqnwEK8R8qYjSdbS3i6q09XqvlmLc84T6Tvu3GwYNOJeBb
         dY5tdPNPMA/lPMYMSaQNjJxQzf1ME2NT4piM4RKpP4FBqCEycxq+CAOXkqYr7H7WcX9N
         67CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999694; x=1792604494;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=urMVj8JzD3NiB+saVlxwn8HdeCLu3WGCkEIWSX5UCag=;
        b=1U+6hYkB9KrjhMfTSLMSiy683gxGZAXPTa3QjcFTEK3Zs1r8XJpMZAcnnXDK8E+1nZ
         4Ex1SQ0uqhfVaoZ2Gf7ksuFkZAaWORNh3sjFNFYLHHL/XcX7uTFB5jEwBGJj6kgrlpCA
         jxQKS5DvcNIIpIb6sWXIDua6RwRReTXjZxPGhhPpZ03uKPhg4Nh5tti/ZqfJdTTs9bvd
         HXCvCHJvPny1cUFnDvwV8/Q8l46WJft9c9hBmVEtpePc8x/DUeaVh4w/Rx2RfsI2CqSn
         nud+CTX+d5uWL6i0Y7yGRpgWSVWkgu6HgVKajoWzKmD30VwbpPO/cJkEHdtha99j9VPU
         5Z6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZH4EtTohCywTqvczCRblTV9JbiFqetXjKTqZPqaARA6DEdbbcsSbJFTpObcuEO47R8ao=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJ2pbeCPbX5L2URg0Jx4afjE3o20FexTrr3nEJwKGzdVVwqfc2
	5di9JsPbLTjtv/RlLwgDdPD+Uul0i1dUz7Ei3krtJnkvUjlrQZNiTi5+fxeqYwHYheM=
X-Gm-Gg: AYBFou1UBgVh5hjOKP3aF7sfRYhj0ZtIBb2Kj1NZvawQoqq2FeBmrVy5rfNME6qjV3H
	eme45LcLrSrKxOs4mv1ScCZkBUw6NBlosqur+HvjegWLdP7jgRnLIQyAWod3fgZlkJeejxZI8m5
	j54zmaL2SQnlM8TkUkD7PAHmdPyhdw5SDU8Vs3hpQgAui/RF88Bu4dNwrSSL0FA3T5OqPbaS+Cv
	r3p1d2fM9Hp4XgJ1PIpLygN3uXk3DoPMDWu8Y00Gm/a+Lb6J5NHWjqoijgK0tt/hDDOr7sKOR8t
	/ZucMN48On13AitGWoo55MK3n9zvv3AtsT5bPJ08EUZMcJkBkeNVeuBzHrZaKZkkJ1RR0V0ZLLB
	iAEetS8BXzmSE6Ua44rgDFfLaQ12jseQXofAvWz6hyW067DEeD96M4Y/1Y+F1i95ekEb0cKSFyG
	DZC3DEScnPzWKFQK5Jqwg52BWJ48u8mztg2E48CLiWIiy1q28KS7KcSiNGEwBm
X-Received: by 2002:a17:907:9705:b0:c2a:f5c2:5cfb with SMTP id a640c23a62f3a-c31a9a28f7amr1598056666b.7.1791999693127;
        Wed, 14 Oct 2026 10:41:33 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:2dc::49:1e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed9c33f9fsm9815466b.42.2026.10.14.10.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:41:32 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Amery Hung
 <ameryhung@gmail.com>,  Yonghong Song <yonghong.song@linux.dev>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Eric Dumazet <edumazet@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Willem de Bruijn <willemb@google.com>,  Tenzin
 Ukyab <ukyab@berkeley.edu>,  =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>,  Kuniyuki
 Iwashima <kuni1840@gmail.com>,  bpf@vger.kernel.org,
  netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 10/10] selftest: bpf: Add test for
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
In-Reply-To: <20261006192601.1875100-11-kuniyu@google.com> (Kuniyuki
	Iwashima's message of "Tue, 6 Oct 2026 19:24:36 +0000")
References: <20261006192601.1875100-1-kuniyu@google.com>
	<20261006192601.1875100-11-kuniyu@google.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 14 Oct 2026 19:41:31 +0200
Message-ID: <87fqy889is.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 06, 2026 at 07:24 PM GMT, Kuniyuki Iwashima wrote:
> The test is roughly divided into two stages, and the sequence
> is as follows:
>
>   I) Setup
>
>     1. Attach two BPF programs to a cgroup
>     2. Establish a TCP connection (@client <-> @child) within the cgroup
>     3. Enable BPF_TCP_OPS_FLAG_RCVQ on @child via setsockopt()
>
>  II) RPC frame exchange in various patterns
>
>     4. Send a partial RPC descriptor from @client to @child
>     5. Verify that epoll does NOT wake up @child
>     6. Send the remaining data of the RPC frame
>     7. Verify that epoll finally wakes up @child
>
> During setup, two BPF programs are attached to simulate
> a real-world scenario; one is bpf_tcp_ops and the other is
> CGROUP_SOCKOPT.
>
> While the bpf_tcp_ops prog handles the dynamic adjustment of
> sk->sk_rcvlowat, the CGROUP_SOCKOPT prog is used to enable
> the TCP AutoLOWAT feature via userspace setsockopt() using
> pseudo options:
>
>   #define SOL_BPF               0xdeadbeef
>   #define BPF_TCP_AUTOLOWAT     0x8badf00d
>
>   setsockopt(fd, SOL_BPF, BPF_TCP_AUTOLOWAT, &(int){1}, sizeof(int));
>
> This reflects a common production use case where an application
> decides to start parsing RPC frames only at a certain point in
> the stream (e.g., after HTTP Upgrade), rather than immediately
> after TCP 3WHS (->passive_established(), etc).
>
> When BPF_TCP_AUTOLOWAT is enabled, the BPF prog sets
> BPF_TCP_OPS_FLAG_RCVQ and initializes sk_local_storage
> for two sequence numbers to manage its state.
>
> Then, for the RPC frame exchange, this test uses a simple format
> defined as follows:
>
>   0        8       16      24       32
>   +--------+--------+-------+--------+ `.
>   |            header size           |  |
>   +--------+--------+-------+--------+   > RPC descriptor (8 bytes)
>   |            payload size          |  |
>   +--------+--------+-------+--------+ .'
>   ~               header             ~
>   +--------+--------+-------+--------+
>   ~               payload            ~
>   +--------+--------+-------+--------+
>
> Every time a new skb is enqueued to sk->sk_receive_queue, the
> bpf_tcp_ops prog parses it and updates these sequence numbers:
>
>   rpc_desc_seq : the SEQ # of the start of the RPC descriptor
>   rpc_end_seq  : the SEQ # of the end of the RPC frame
>                  => rpc_desc_seq + 8 + header size + payload size
>
> Assume we receive two RPC descriptors in the following pattern:
>
>   1. When we receive skb-1, only part of the RPC descriptor is parsed.
>      rpc_desc_seq is set to the first byte while rpc_end_seq is
>      unknown.  Thus, sk->sk_rcvlowat is set to the size of the RPC
>      descriptor (8 bytes).
>
>    <- skb-1 -> <---- skb-2 ----> <------ skb-3 ----->
>   +-----------+.................+....................+......
>   |  RPC desc 1  |  header + payload  |  RPC desc 2  | ...
>   +-----------+.................+....................+......
>   ^              ^-.
>   `- rpc_desc_seq   `- sk->sk_rcvlowat
>
>   2. Next, we receive skb-2, which completes the first RPC descriptor.
>      Now rpc_end_seq is known, so sk->sk_rcvlowat is advanced to it.
>
>    <- skb-1 -> <---- skb-2 ----> <------ skb-3 ----->
>   +-----------+-----------------+....................+......
>   |  RPC desc 1  |  header + payload  |  RPC desc 2  | ...
>   +-----------+-----------------+....................+......
>   ^                                   ^
>   '- rpc_desc_seq                     '- rpc_end_seq
>                                            & sk->sk_rcvlowat
>
>   3. Once we receive skb-3, which contains the next full RPC descriptor,
>      rpc_desc_seq is advanced and rpc_end_seq is updated according
>      to the size of RPC frame 2.
>
>      Note that sk->sk_rcvlowat is NOT updated to the new rpc_end_seq
>      yet.  This ensures that the application is woken up to read the
>      already complete RPC frame 1.
>
>    <- skb-1 -> <---- skb-2 ----> <------ skb-3 ----->
>   +-----------+-----------------+--------------------+......
>   |  RPC desc 1  |  header + payload  |  RPC desc 2  | ...   |
>   +-----------+-----------------+--------------------+......
>                                       ^                      ^
>               rpc_desc_seq -----------'  rpc_end_seq ----...-'
>                 & sk->sk_rcvlowat
>
> This sequence corresponds to the 4th test case in rpc_test_cases[],
> and we can see helpful output if we "#define DEBUG":
>
>   # cat /sys/kernel/tracing/trace_pipe | \
>     awk '{ if ($0 ~ /AF_/) sub(/^.*AF_/, "AF_"); print $0 }' & \
>     BGPID=$!; ./test_progs -t tcp_autolowat; kill -9 -$BGPID
>   ...
>   AF_INET6 rpc_test_cases[3]: Start parsing skb: seq: 0, end_seq: 1, len: 1, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_buff_len: 0
>   AF_INET6 rpc_test_cases[3]: Copied 1 bytes: rpc_desc_buff_len: 1
>   AF_INET6 rpc_test_cases[3]: Setting rcvlowat: tp->copied_seq: 0, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_desc_buff_len: 1
>   AF_INET6 rpc_test_cases[3]: Set rcvlowat: expected: 8, actual: 8
>
>   AF_INET6 rpc_test_cases[3]: Start parsing skb: seq: 1, end_seq: 8, len: 7, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_buff_len: 1
>   AF_INET6 rpc_test_cases[3]: Copied full descriptor: rpc_desc_seq: 0, rpc_end_seq: 258, header_len: 100, payload_len: 150
>   AF_INET6 rpc_test_cases[3]: No more descriptor: rpc_end_seq: 258, end_seq: 8
>   AF_INET6 rpc_test_cases[3]: Setting rcvlowat: tp->copied_seq: 0, rpc_desc_seq: 0, rpc_end_seq: 258, rpc_desc_buff_len: 8
>   AF_INET6 rpc_test_cases[3]: Set rcvlowat: expected: 258, actual: 258
>   ...
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
