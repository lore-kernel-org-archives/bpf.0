Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B18C3E8681;
	Tue, 14 Apr 2026 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176047; cv=none; b=hbXfi6qiak/A/xttboKr9G8R0PUR5i5TywIRvqt5/ACvwysnDuoDwH9U+d8nHvLP+Xdw0tdbcAQuHCV/58yx2TTGADVcNL/HlPDuec22DDj4JIiuN9HiZVdEXEb000um6TZzsjhIP3KD80sdd6rst0b/Qb8clsa3Kz7kISUnPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176047; c=relaxed/simple;
	bh=nT2Tj4WN5nVASsWR0Rf23HRLAUy4aZ6TkvIacAn1giY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCCbG8iaHCRGC8Lxc0jMBShEoi6PozvyiizXJm5GI4l8szGI+HwuI8SGe/xVRaqf2WUf0wONzO5kKmcuNdby5UHiOfr+Yv0OIZhUPzBy1IyK0c7kKcJ8R49LzCjAtdApCXthVnz0q7M5JDst8c091d7blgvYJrUcHXHFWyHURzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=TmWXK9Mc; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="TmWXK9Mc"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wCeWO-00Fdqc-Fw; Tue, 14 Apr 2026 16:13:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=BieWsBuZObwE52NomKb0T7XPKPlqeO+dDW3yQZ5Qiqo=; b=TmWXK9McvraL/uU6NzggGfFs+p
	9DSFlGdxaC8b5SZUsjm6lDdacAi2SO3Tq2fIo0/POPCMlvr+4EtaJIiXl9TwmXaN/bUdUjK2uyxbQ
	SlXHukDi710aZ0rHaZDWNH+b9RzU6h15dvrtxdHPEaFIRB1H35GhaHecqkdDVXG5VAkMyp4LeNzD1
	8NfsfIhwVvjSSPEP4AieQcL6zHcA+T6nKb6TE0vpWNcvI9AKalWfNmUt3EpfBeUwABxoVbtuQRZSC
	LHfJSZHOFs/NE7y8fj3sDPF2g+oL6ZuTfh+C7qWt94UNQBgPttDNpzxQ78tuVB67TQBl5EGJD0QBY
	4GaOezLQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wCeWO-0000Vs-0e; Tue, 14 Apr 2026 16:13:44 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wCeWA-00DhbX-2Q; Tue, 14 Apr 2026 16:13:30 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 14 Apr 2026 16:13:15 +0200
Subject: [PATCH bpf v4 1/5] bpf, sockmap: Annotate af_unix sock::sk_state
 data-races
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-unix-proto-update-null-ptr-deref-v4-1-2af6fe97918e@rbox.co>
References: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
In-Reply-To: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>, Jiayuan Chen <jiayuan.chen@linux.dev>
X-Mailer: b4 0.15.2

sock_map_sk_state_allowed() and sock_map_redirect_allowed() read af_unix
socket sk_state locklessly.

Use READ_ONCE(). Note that for sock_map_redirect_allowed() change affects
not only af_unix, but all non-TCP sockets (UDP, af_vsock).

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index b0e96337a269..02a68be3002a 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -530,7 +530,7 @@ static bool sock_map_redirect_allowed(const struct sock *sk)
 	if (sk_is_tcp(sk))
 		return sk->sk_state != TCP_LISTEN;
 	else
-		return sk->sk_state == TCP_ESTABLISHED;
+		return READ_ONCE(sk->sk_state) == TCP_ESTABLISHED;
 }
 
 static bool sock_map_sk_is_suitable(const struct sock *sk)
@@ -543,7 +543,7 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 	if (sk_is_tcp(sk))
 		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
 	if (sk_is_stream_unix(sk))
-		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
+		return (1 << READ_ONCE(sk->sk_state)) & TCPF_ESTABLISHED;
 	if (sk_is_vsock(sk) &&
 	    (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET))
 		return (1 << sk->sk_state) & TCPF_ESTABLISHED;

-- 
2.53.0

