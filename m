Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FFB3914E4
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280119; cv=pass; b=g7RNTBcGVW4PAnt63lb52xfjV1lWcN6pV67eky4OINqQCVf4THapySn7Oyxlcg1Ka3LLg6V7kOFdGbAjg6uH/gMCUntFenQ3XIdCs8tm3dS7betpHB7jHIEca5hLOS7nOppYLkHyb0z3x6EtGrIOgsfe3xHhjNt8l9LZNxT90uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280119; c=relaxed/simple;
	bh=xLmT1CglDc1tRi97nwnjGAiRAUXSf/PXHXAe9jH7qa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPz3H9ZWMWYT7YqvaaMqXgHG1z1SjJxsTKbcM7ElXEO3pYlnRBE9B8sV7kzjcSOjPXmuafODs549s6KWkgJ2hjUmAnK0UM/S7waM9Ty42jRqeCx/PnlG414O6Ih897gh2k7KIqtFR6kmbidTOVYc9R1xFQCFEwaeUzh/7kYiFiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmayjKZf; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmayjKZf"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso975425a91.3
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 09:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781280116; cv=none;
        d=google.com; s=arc-20240605;
        b=aNoTChZofIg2ELddWL25uJR4AMXzHDE//cuz/DhlgGjJbFA9SnkCTk8TCGZ0qjoWzu
         BwTy5O4kUnEYj5/gjBcIIwxOd6LvSC5vr04dsIzhn95+cF47rDSW3DsfdbyphhizyptN
         JGixyYZhNV/OvqksJ+3SJ/7iPzrQSs2suEr+TsSNGQk6b9pVJZpOgTp8K9nc0IYR6v4A
         etxuGyQ1kHLT/BOYzDIlXBx+SDcjm1mZPfk57J0OSRXegjl7FSoSFIyZ0k3whvlsL5QQ
         CjaJIUwWOd6Ey7mhgadFF1mlFUNnQWFrIm1Bpl5DzuU4+RwURN0xaoUjFtoXSoh1pooS
         wbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3NluFMG/+8oV4UqiIPnUP3waoS+zwZ5/CDcQWyg+zCA=;
        fh=zNUieA+TCC3md4T5wY3jjGGdvg4wOO8nzmz8iWOX5GI=;
        b=VFNHy4rJMntxPO5osWvFpfm4DqNZfsGWM56u0DMZTpKgUsgWhO2NxOT/dlfCfVEAYl
         6ElM0KE4D31U0f27OK7RO3eNNSjgaPvXbCYAb0mdeXJ3gM/y0DVyBI+fs43pqF67fXW8
         ZKpCvNi6Mo+tn9NEMxm1R9FnZmboodYjJjg9qtr2lCrbQMJ3ecqV1JuE3VN68rw9IqJd
         FFF2tzu1PTlFb7r9Cjubwr+0KaGpGFP24J2YJyA1p7wzkROuMsOltsv50wof8CzNjWjX
         Zhdvc3jLEkZHfbMC1J22orrJPiZltexkCHsGe2LY5+47PhNDVHvlFD5OGLOU7Acww4Dx
         oV+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781280116; x=1781884916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NluFMG/+8oV4UqiIPnUP3waoS+zwZ5/CDcQWyg+zCA=;
        b=LmayjKZfXj6a0qpPllyDM4QM/G4gpUaLGmES8roRE15fVN/SSLH4vStK+sgtEvfLWT
         9gJUB5R+symRRzxQK0nHtekVFmD7fmTRG6mjyeDLY3vMnAIdvhYTaPYpKsp2C1wA+rsR
         dJ0ganFgAmJDcNmdQFu499jp/zSQbXykkpBDi/c3BN2Vv7tiGgWdCNadvjXBiM1oLcAu
         FYfe2bwzRVG2AEwV84HmOPnWb57F52fDPp44jZUTtp3BEpC/xs8j3ENwasrO0yP4+h9N
         FPkVH0Nkrw7nBENJWzjutiOF3AOO4QksPTAdL5h+nM7UjYm9co/WyB3Fe8fo8PRxBg2U
         76cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781280116; x=1781884916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3NluFMG/+8oV4UqiIPnUP3waoS+zwZ5/CDcQWyg+zCA=;
        b=YxYBeTH3AIGNvGChNAmC5VXERJhLy/xmVY0b6AJ8vfRZNZ7aTu2nmlZVIXJ7EEnXHl
         xd+azthwltsVaWhYn5llfTumZN85zyIX8LAd8kset+7RM3mRCLvJL+33yfP8iWIGVCRJ
         S/e5eH9OfITCfGBxCCw5j40HS4sO/BxEAD4ZOHMBgAGyGMyVl/wv0sND5XGzXcfMo+um
         5ERFAVMFIn3s1h4OwQivUcf5gKEMnCi6BwlBBGy0ehVN1fs5pYHaHPKqfFMXTTn8CPko
         u+Wh/apAJpWW5UHD1hDDZ9t7OSzDArGhpKPbVDhDADIoh+yf6zUc4aN9cRLUb5lmh4Ci
         9wdw==
X-Forwarded-Encrypted: i=1; AFNElJ821JsdOb+YqytrfsqzZPo1qlRKQdbs0UEMj4ZS5hqIeONi+/4psRqeXfMbtlUBHUOhvow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLVgDPaR7ObTLFRZNHEPEuZz7sd97UQNgdMrCnuXBVheSdHOe
	Ao1vhk/Fcevf8CFOJmi41KkeiyJP+zzVnRHYyAMiohsmcs+ZInF6zSvkmAfMmlmonxjbWgAfPlg
	qa+tFRzt4LXBlZn473QilSW2CXJf/yAw=
X-Gm-Gg: Acq92OFZn8R9PjeuKVr9iKO1Bbe/m36FxVpGmR5sGrrw5AhShnJWYGCU0d9cA+JWmRE
	XCgdm/vCVKlzP4bXZ6iir4XYGWZfI05OI4RGgMtrFRywHjOwxZ/ZG88VfcSeJMT+fSLk0wGAex/
	x22OGvUqaayIwdRNfdqt0iuLv8LR2oDiom1a2M4u6wCjRuvw/DN+IA1IgcKaRAwW0pR2VS6c0Q9
	HBpNcH7XbfdkVBKLYOpdcs4xzqe6/7ruOvsOTxMjBpu5uZc1OuOleLdkZ4X4dy5rqlUhiiSf/e9
	qz0n/IpNLSkERvg4oE3kyL3jWvA+c2PGYtqwAoJTAxnzLlFuhaDtR+pOvJOC4PUjBkvPd3stqRF
	r9/TDzDAy+AWKkOuibQcCKp/HcLJAmIg3hLo=
X-Received: by 2002:a05:6300:6708:b0:3aa:c93b:625b with SMTP id
 adf61e73a8af0-3b783c74eadmr4367140637.3.1781280115162; Fri, 12 Jun 2026
 09:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jun 2026 09:01:43 -0700
X-Gm-Features: AVVi8Cf3XUkYJ4-XhNrmqW9iOjgBV1BE-aGRWP1cVs3vyQnQRIzHDQ5CDQInRCg
Message-ID: <CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for
 BPF-paired sockets
To: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Hemanth Malla <hemanthmalla@gmail.com>, 
	zijianzhang@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 6:15=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> This series adds an opportunistic "loopback splice" fast path for two
> locally-connected TCP sockets that a sock_ops BPF program pairs at
> handshake completion. Once paired, sendmsg copies the user payload into
> a per-direction in-kernel byte ring and recvmsg drains it on the other
> side; both copies happen in their own task's mm, so the fast path incurs
> no skb construction, no softirq, and no TCP protocol-state processing.
>
> The underlying TCP connection stays fully real: sequence numbers are
> frozen at post-handshake values, so FIN/RST/keepalive keep flowing
> through the normal paths and the pair tears down via a regular close.
> Pairing is opt-in per flow and fallback is per-message - handshake-style
> traffic takes the TCP path, the bulk phase takes the ring, on the same
> socket. Nothing leaves the host and applications need no changes: no new
> address family, no LD_PRELOAD, no source modification.
>
> The target use cases are co-located endpoints that speak plain TCP:
>  - regular TCP loopback (127.0.0.1) between processes on the same host;
>  - container sidecar deployments - e.g. a service-mesh sidecar proxy and
>    its application in the same pod, talking over loopback or a veth pair =
-
>    where the per-skb veth+bridge cost is exactly what the ring sidesteps.
>
> Highlights (TCP_RR, 1 KB request/response, netperf, pinned CPUs,
> baseline TCP vs splice; full tables across message sizes and TCP_STREAM
> in patches 1 and 2):
>
>   loopback (127.0.0.1):
>     without busy-poll:   105.8k -> 235.1k tps  (2.2x)
>     with busy-poll 50us: 106.1k -> 713.0k tps  (6.7x)
>
>   container (netns + veth + bridge):
>     without busy-poll:    99.9k -> 233.9k tps  (2.3x)
>     with busy-poll 50us: 100.4k -> 704.9k tps  (7.0x)
>
> Synchronous-RPC (TCP_RR) at a 1 KB message wins ~2.2x without busy
> polling and ~6.7x with it (the win grows toward smaller messages and
> narrows toward 64 KB), because the ring removes the per-cycle kernel TCP
> receive-path cost and the receiver can spin on the ring directly -
> loopback delivers via the per-CPU backlog and exposes no pollable
> napi_id, so the generic sk_busy_loop() is a no-op there. Bulk streaming
> is roughly neutral on bare-metal loopback but wins decisively (up to
> ~6x) container-to-container, where per-skb veth+bridge cost dominates
> the path the ring sidesteps.
>
> ---
> Cong Wang (5):
>   tcp_bpf: add bpf_sock_splice_pair kfunc for opportunistic loopback
>     splice
>   tcp_bpf: busy-poll the splice ring before parking the receiver
>   selftests/bpf: add tcp_splice basic round-trip test
>   bpf: allow SO_BUSY_POLL in bpf_setsockopt()
>   selftests/bpf: set SO_BUSY_POLL from the tcp_splice sockops prog
>
>  include/linux/skmsg.h                         |   9 +
>  include/net/tcp.h                             |   8 +
>  net/core/filter.c                             |   1 +
>  net/core/skmsg.c                              |   3 +
>  net/ipv4/tcp_bpf.c                            | 847 +++++++++++++++++-
>  .../selftests/bpf/prog_tests/tcp_splice.c     | 206 +++++
>  .../selftests/bpf/progs/test_tcp_splice.c     | 125 +++
>  7 files changed, 1198 insertions(+), 1 deletion(-)

Just saying that the code is free nowadays, so whether it's 1k lines
or 10 lines is irrelevant for the discussion.

As far as the idea goes, I think, it would be interesting in pre-AI era,
but today splice and friends are a prime target for bugs and more bugs.
skmsg and tcp_bpf are reeling from unfixed bugs too,
so my take is that we should not add any new features to skmsg
and instead deprecate what is already there.
