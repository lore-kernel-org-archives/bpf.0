Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E911038AC96
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324439; cv=none; b=rajm3UGTAD0Fop9pdqfiJ0WrVNm4Oyc1+nQD2VbIdLuEXsm45QHVVf+FVL4wwn38wxRLUcL0UwM+4ySEi6OyJsOxlgkVHtG/B4shlom7kKzeV2pE4Gi9ogSBPBlmkLfiejb1xTTVuT0foHjvMh4nFga4YLS7OpQ9YZKrsdU+5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324439; c=relaxed/simple;
	bh=B4fH7wRo82+xD0mPhsFWyivVYv0Q3R1a6JKRMyRXCJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1Fkc9L1V2uskCRZsQGEQwC2vyFjgFXrPZKDpFChIOeHOl2bCdE32xOqdy4m0GwAi04BL/cd/c1y+H29io5lPTVPzeX1cTyOm+QIRhvpk/+7fZqald94VDebQn09B2hzFb7ZpyOjoz5pJEx4605EsQwHlzXQ9/pirDdBjPNyfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwOaoZ8f; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwOaoZ8f"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e30379b781so2896425ad.1
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324433; x=1791929233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xV1WC96HEZo5ow0jJgk/jpxh1KNQ8B6OwYydLnktSEc=;
        b=BwOaoZ8fe1j9XSKi+VK+PXgi5n67AuKX5i8ebarMPo1iK7UNnx0EaKT1E9AoKiPtVr
         BUpT9lcpcT6p12Vr+57ClnQgthJYH3y25YYNZ+aI+0wI27aPB1h9/E/0CajiTHPBB5CC
         J9C/EuGuYmEjdbqANemtzP7vQVxGqArXSJ/3qNRk1yYPi7Ltf+Cv7jpH2AKfluV5pDRT
         XBqUPj/nnjW3rqQHcVsWK4AePBnCNm/zuoZfpMWzfHR+khMFMuqaZu2LfS7YqWQnxO3n
         AcfLQpnlvu3iPFQ7lOcc2hLEDLPIQS+oeuZcAej2BBto62KkSWA2CGOVTJwCxtSWz1lm
         MHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324433; x=1791929233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xV1WC96HEZo5ow0jJgk/jpxh1KNQ8B6OwYydLnktSEc=;
        b=tBD4S+I0i2xp7BMRiv/CSdgsVws3DSBWfnwL7fCbQMNzQ0syCXyoNVByLUF7fjTp5s
         NYUWIJQvg5NtwDybj+qjkWbooed6CfZPj9d20amZpFyjixNI7AQMl2YjFUAm7n8pzwqO
         /11gvKzSVvRsi0IAkfylscmhmFC9TLA8F+i+9or1WE9IlUz+9mgHgd34nhdBRwEfw7bQ
         guqEzq78K9LyfzhiM/KFhCiqJhdYxD9NXvz/+Pz2Ds7hfr86Pb9Zt9NFW/tHnw+2/IKQ
         sQOuilt4dQA6BGuczf/XsWWnspoq/ouNhuOsmgEsiiMqHXtqOINcvEuMdz+lk1YTOZJX
         AjlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWcQAXugwyzKF0rhegPm2dA/Rp2hMyCA11tP2O71hCnWkVo5UQcbOvFQLFIH1ewABzrVo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5tal94egIyO2iAThHvfkybbpCbRGzDNKIoNEW/Qb/5vZc1R9W
	928Hz3RJSen1qqGwgnjggGmE6r+I5pvIkSxq30jdbBeyjQKt0x2mn8Sv
X-Gm-Gg: AYBFou0cNv1y5CWOxSKTCzFMoXLy2CogUV9algEJfMrFX3PQ5Bz4TksYX52wASiKUjV
	DvadCAzgcr9N1RG05z9LnDYi2W0Ak+J8tEAEqohsGDeLmepxMkI+h1jHcBamf1QGcDaoL4goozk
	Cm+oHomldMa6PcKQDA/6zTU5C9NH3xD1QVV3MdtnUw55HOP2y+Rld7dFs0LczEAUDYHE022YWyb
	yqCDx59kV5Up2BjHmQRXArHZ5oDDpl8nHmAVLCqHQTA2dTAfu/2kHGRso3rnFijMBBIgdw1X+KD
	tNHqg+EayO+gcUD/g09bmEW6KCXsunMDk/ttFI9h9k3rku5tDJ5p0iXXKLl7ejwUOmVoJzrj0ER
	iZyZeNIMwKbmeekmiUQPU9XFboxpZuQOm5jM5VBXMbLOWyYOKnlE+SE7E4QeuFlwiDMPdemdpt3
	MGj2wVwLQmR8aIByGjS1AXleSuUBgmDp1hglenN73qCA/Ktk5G+vZSU/0XHG5LzjA=
X-Received: by 2002:a17:902:d48d:b0:2df:91ae:7ab3 with SMTP id d9443c01a7336-2e6003aeddfmr4365225ad.9.1791324433115;
        Tue, 06 Oct 2026 15:07:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6046fdb36sm1587575ad.22.2026.10.06.15.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:10 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:06:40 -0700
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
Subject: Re: [PATCH v4 bpf-next 10/10] selftest: bpf: Add test for
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
Message-ID: <asVw6d5Y0moFn_GG@devvm7509.cco0.facebook.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-11-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006192601.1875100-11-kuniyu@google.com>

On 10/06, Kuniyuki Iwashima wrote:
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
