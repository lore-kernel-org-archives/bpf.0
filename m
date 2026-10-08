Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5A357739
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479832; cv=pass; b=kdgiQoGqJCU3nHfUvtyZPAUZZ6dRw8uJ82sAe3eZ3pbZdbE74pANNz6jQfr80ZWBa+3Y0tBZyf6z90VnjwyjHGoEom8UCipMrAg/etuHhinvWuSVExeLc5ul0XcQGTgRsu7SVmyygRJuQgVcGkgQwAPY939W7eKuHa8R8QdnmgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479832; c=relaxed/simple;
	bh=8TPLZhK+AhSCBPEHWCi7lPDnehMDfRAsgS0v468v7Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQAYjDfQB9a6y5Y4eTLqklv/fHoCYlIL4wnblT8nWVv1QeQp4kYIYOi/ePuNBFM9OsGtIZHvKaMFw7Goizyc85c4fCLyiAgMxJ/buRV4vgfV9Op7acLqVVHjHo0CQHgLJ/QDiDWSNqBXnXv02uEQTqwTQJ7y2FDKkzYYoNecLoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ2af5/V; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ2af5/V"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-82395ae2ea8so4803672a34.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 10:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791479829; cv=none;
        d=google.com; s=arc-20260327;
        b=SJVCV2X0SMyXDUWuhox2OKxEEnmZzfVCQrMxvlGWLDZs/c6z5aH6fgYEASaobqdIxF
         +CZoZfEsO34dhVuGmLs1Q4r9PzevYa41kM7+MucGi2ELPtlnjZmnuFQ6EAWkUAUSb/mh
         CUX9Jffe7WDR3x2ROCD7fBqPnUtyTc9J0x8/uKppVSF0oKajt5UTmK26vrixamSsjqSE
         zge4Ytn+QEgPxuu7siIVBhuA+Tqg+jD8OrKbGLum/kigY4Hu0Q6RsVlXJN6RxOclbJAT
         8FJTI1hmnny9Vt7HQOtePZM/o+0vScLX/MO9KFoBafmsfyvW5edtZG/0xCjCgSQKtJGY
         gqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nSpONfxn82OnXHDY6XiK2Ttjokj0dpEJQtqzydWJ8X0=;
        fh=ausqjJE6GCXyqJdcUYl8hFn+cbXWQ/i5CwHDGUt9IoE=;
        b=jV7rkoz2HW0IvRJqDD5PE5Kutvl1Q1gHuUezy9j5ifYbItwTbef+T50GHQhXV2/doQ
         9YNk98XoB0e+c+3mlM13+61iUWT5cikVZpW5O2h5UztZmFOw9yR49H1YD4GqhRCNtn5c
         r41ITAkE7C4QeOak/Sb/kD0vOy0Hd1M+sNAAnX9No+tLnxZSr9+YPDGtLL1R5wW/VUPA
         Bmyc03GlRxlnYljorKoHg+V9IYzFC3lQ7llQEf5JD9A2AWSDVpbdKjdbZJ1hqAjn+l8f
         z21ZTrRcbC8bGYbLyr2Z79pEv9fd5iQmmQ3AullLHVXvDOer0pWvwd096yi1GCZz4Rps
         6ypw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791479829; x=1792084629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nSpONfxn82OnXHDY6XiK2Ttjokj0dpEJQtqzydWJ8X0=;
        b=LZ2af5/VCGasoiLIcdMtF0vHlIPEThHv632wtd5mKSU3zEiqk86gvNOH7GieD8qJzd
         X4CA8mTkVC0+Exo6UT5SxTRp3VFTOLd3+dNaj65SaEjQrQG8MHTbykyzeZtVQCT3ds1y
         3tYKRUeTEKxKbg3IDOVHYCIdthlisOFuigdm2jVV7ttvG4QkcmxW7ElTMJ3+mF4Xdpag
         94QI5jyTACo9dq168WjSdvlRS5Gn3UnjUAemm7ER3R0Zx1UT+aqC5fRRXoNtH0y4rXmi
         1EFWTHHfixtlaytiwW957farPLiHKltBYeCpUV50tfZ8EN/3t7zU2M7DLbO+LNNm5sXq
         Y0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791479829; x=1792084629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nSpONfxn82OnXHDY6XiK2Ttjokj0dpEJQtqzydWJ8X0=;
        b=xIQgMocpFXOK/bmLKS8nVYSxKh9ZNgZ2D375HOjAjsj5yTI/hawfHEWtgwATTl+DBa
         JVBfZCo8wVq/pVkg/InLetBGoHkbaIgwCyH7vJnoJmeSkbAD6gg1p3y1iz3NDhkkox8v
         DWCtJAxK/TpCLS1fYmYBf6DHFy5PPx4PwlsNaCmOnMlPJFC6FCvlICfrm5C6LT1pu4wn
         NxW+a+E6cjL9RO9/zgZTY5yp6k3HvfBQb+Hu9JeNP/wTGtV17Gg8HVxzJccvygcIpEQ3
         C68hYN/k/td+tkqsraEePfePBco7L/7TB7ONXOLu1a5Ea+FllVTRcYm644qhrJ96mBiK
         EFxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZBC025YQSaY/K7chca8nLydnSLaEUKjWJC8kIjbbPXWYryg3O7UeMoyvO1GwdZFlqOqE=@vger.kernel.org
X-Gm-Message-State: AFuF++l0XJC6g3fW8nSDWSSt1o5FoCmZVd0hOd71yU/5NsTD1lly5Jos
	YzpJ9kfhfAc/7Wsu46evphayd8owSnIxDRHYMPa+CMMLqnWPqvP4NG+F8G41Wst5uKCvdM6Okfg
	nXXYQHLmnCiu+fL5UlaAt2JoGFcSqjzY=
X-Gm-Gg: AYBFou2JopipgKnAmhdxOwxgSzQV7bSFMPpX1VGQzgVDom1HUp7AO6Dxuxrl42GmdzK
	HJu9FCGOG68J2CWSYn2nfDVrOyCcVv71uKXCsDT4OodMnzXswubPT1Hp8j7ebyZUy/4Xn3g12y4
	XK4im0AjSuZOwSj4aH9JC/hwF14DB32palwjGLs0/lJ58E1NWvmw6pU4z9vQJMo19mN2Yvu6QMr
	Q1fAIkVU4qFeCA+PFTDqsUVstoOJkCWOHTRqzh7lA5aGRMXxuR3gHUeuMEiiNxQSvUFEXzAzYED
	CtLQ87Ig/LySQbKpskZjy3gRTy3T5kPmoeCuBVEiwQu+n/NwLAkx1pc=
X-Received: by 2002:a05:6808:16a1:b0:4f4:4de8:9373 with SMTP id
 5614622812f47-4fc46890902mr5775908b6e.21.1791479829230; Thu, 08 Oct 2026
 10:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com> <20261008031604.256498-11-kuniyu@google.com>
In-Reply-To: <20261008031604.256498-11-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 8 Oct 2026 10:16:58 -0700
X-Gm-Features: AclHuK8ASGIDEe0W65rv_VH9rEvQ9UE55lHFYXFlGQ2gOAXDeSvmVe1l7KhhIAk
Message-ID: <CAMB2axPBS2=hPponYK4z4mA9nAhCXRVOWsR3F-yWOqzWA4BbzQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 10/10] selftest: bpf: Add test for bpf_tcp_ops.{enqueue,dequeue}_rcvq().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 8:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
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
>                  =3D> rpc_desc_seq + 8 + header size + payload size
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
>     BGPID=3D$!; ./test_progs -t tcp_autolowat; kill -9 -$BGPID
>   ...
>   AF_INET6 rpc_test_cases[3]: Start parsing skb: seq: 0, end_seq: 1, len:=
 1, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_buff_len: 0
>   AF_INET6 rpc_test_cases[3]: Copied 1 bytes: rpc_desc_buff_len: 1
>   AF_INET6 rpc_test_cases[3]: Setting rcvlowat: tp->copied_seq: 0, rpc_de=
sc_seq: 0, rpc_end_seq: 0, rpc_desc_buff_len: 1
>   AF_INET6 rpc_test_cases[3]: Set rcvlowat: expected: 8, actual: 8
>
>   AF_INET6 rpc_test_cases[3]: Start parsing skb: seq: 1, end_seq: 8, len:=
 7, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_buff_len: 1
>   AF_INET6 rpc_test_cases[3]: Copied full descriptor: rpc_desc_seq: 0, rp=
c_end_seq: 258, header_len: 100, payload_len: 150
>   AF_INET6 rpc_test_cases[3]: No more descriptor: rpc_end_seq: 258, end_s=
eq: 8
>   AF_INET6 rpc_test_cases[3]: Setting rcvlowat: tp->copied_seq: 0, rpc_de=
sc_seq: 0, rpc_end_seq: 258, rpc_desc_buff_len: 8
>   AF_INET6 rpc_test_cases[3]: Set rcvlowat: expected: 258, actual: 258
>   ...
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
