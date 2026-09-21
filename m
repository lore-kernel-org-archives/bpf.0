Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E784CE66C
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023821; cv=none; b=tUCfdF94R3DpnTov2uUSb+SjOfRYM+3oOp5JV2VR0Q0+JKUbdTygWiX6G0pSeT/ga9YRJhleIUZRgfUQEEKC4OXEkjF0uHlD/EqF0wwhaqypXS0tOtVytWlh/INZikz3Kt71VZNw9Y9tAOTtrF9Mas1EL2VDl7XZeyEdZF6Mw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023821; c=relaxed/simple;
	bh=qEAn/hVg3Cl5mJm9CYL+m7z92mCbcQMxWOGU9phsNoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODy+1I7Qi8PFRq7Na6DxbjW+0jo9VuehyXgHQWBHz1f1iyKAtZS/BiTSmwk5Lue4/fdnP9udBNQ6XVl3gYdJHfGMLS8sV/68Ar8gRdZv6ko/L/T7rIjJlf0efGVvOcN3uWBcDhJcEdX/p+EgENPNDOIEMuc8YV4giN8qRCc4jNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5KOKa/Z; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5KOKa/Z"
Received: by mail-pj2-f6.google.com with SMTP id d9443c01a7336-2d74bbdc61fso4107395ad.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 13:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023814; x=1790628614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iBygId6C50zTy5kgZzjxjMwL4y8mIdO76ZHGBBIk9cc=;
        b=O5KOKa/Zk10rqrzhW3NioQZH9b/4WtPSecY+yS48aT1oosEiBSfX8vtb8Rc65x7eSV
         9WRNlAoeGC/TBq/yEMrnsOrum0ApYqGPFCp0+E6IruEyk4gASFNYdfuonsnNuAWNRfVU
         xqiYpHV1fLDol6B1AJjDyoxbtIQrbilFOT5ayXMueAOG8dLIVJj9Y3AzWQ+O1Fib24vC
         tVOD1TkmqUqW17KjZbbY6RPXaxBS5sMa9ipj5HsXm4SJUjEXiyFrcQh9ReJE7pLMD/gc
         a2QeRgMddcXE+ZY554aJVY8SHSVESdllXKeoKXhI8dPDCUg4GIhvQcAka/i8FViOCvE8
         Tf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023814; x=1790628614;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iBygId6C50zTy5kgZzjxjMwL4y8mIdO76ZHGBBIk9cc=;
        b=SqZFKo98Kevbzkp7Tmjswtuu8WkdB/UFPsS6MvCfQoVCk4LH/Rq5CUK4djhbIk84za
         8eMH4k0L2P9Kco2UK08Yk3MA8b7ZV45n3vpicwNH2oCrs2L14ocomOe+CwtLYQeWO3fn
         01wW6YhTcyd7OAcZIW59qDBA/+LJ9mfADwED6wGizPorMUGFiPmvKd2FsWVL7FhfmsCn
         e6ffxJJEdI32OrWXcH0mI+t+scfn9Sgy27Yj/pomaFQrMCLPCLi5VVszuJ1+X2kmwX4N
         gAWzyFF//JFiYtI+3cGuNexfcYybJ6wXAubiDR0ZQRBNPWBETxp7LfeuRxHU4TIsk8Oa
         Vs2g==
X-Forwarded-Encrypted: i=1; AKwUvBwuXWDiUOogKcchqAgbmskfBl30cS71XlYsGXYLxoxjO7lHI8bn2nKPUIc+F1qYJTQMAOs=@vger.kernel.org
X-Gm-Message-State: AFuF++lapYaYpMTAiXKQmFuklrMKL4x9UgF4w3Vimpo0Xo2QryCxKUpE
	LugYfvC4U5mTFBKyCw7VkdpoPwDNO8zkH1oPjuUINCshpZPO2IbOd/2S
X-Gm-Gg: AYBFou2NthsxuoXXHlsw/GIeDMjMEw/tnasuMyRQ4vXwkvfgLQG1Sk+3ztz5RnSNyxG
	bzrg8nVztWVwVXiuBW0918tTtE6ZypKWecD6/ogQIwUCGGoufIiJ5b56lmHTmPWwk9W4VNzW1fb
	ENvF7jT6nSvIqCmBl/pUbIkXpgMD4REFEPYDJP3oeFUFUOIFVc+gZ6dfL0WzK7a9awY8SbzD96w
	AQhid9q2jDXIPKbUqzjpVtEd9Flk67U1rQLjkNQcJqT6Kb3KhZ4+ZfDapUe5/IJGqiHbSVs50/C
	EJRARDE/7/rzaFfIG8rzNes/2ecpd9SLnVTpX1U6JzwQubNSCGKwWd9eHgM1kCNOuA7DS2M91sm
	hghu0xsmeTZIhF48T7yis+wpITnRk5GYEHwBFepCiTTNsJVblHbPuNhuuK1NuYROpz9EHAZSGvK
	tlCscnFButcuYqkaiHOUDAR3XrpGIbHcQXz89q8V9WMhraoNhlh+Qou9H3uHD5Kvg=
X-Received: by 2002:a17:90b:2243:b0:39e:6a7f:6188 with SMTP id 98e67ed59e1d1-3a066b0d8a9mr546901a91.25.1790023814057;
        Mon, 21 Sep 2026 13:50:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e52d5adc1sm8700628a91.0.2026.09.21.13.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:50:13 -0700 (PDT)
Date: Mon, 21 Sep 2026 13:50:04 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 7/7] selftest: bpf: Add test for
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
Message-ID: <arGYdL3r6NLN0N6R@devvm7509.cco0.facebook.com>
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-8-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920195633.3033620-8-kuniyu@google.com>

On 09/20, Kuniyuki Iwashima wrote:
> The test is roughly divided into two stages, and the sequence
> is as follows:
> 
>   I) Setup
> 
>     1. Attach two BPF programs to a cgroup
>     2. Establish a TCP connection (@client <-> @child) within the cgroup
>     3. Enable BPF_SOCK_OPS_RCVQ_CB_FLAG on @child via setsockopt()
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
> after TCP 3WHS (BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, etc).
> 
> When BPF_TCP_AUTOLOWAT is enabled, the BPF prog sets
> BPF_SOCK_OPS_RCVQ_CB_FLAG and initializes sk_local_storage
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
