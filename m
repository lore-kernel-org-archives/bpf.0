Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370B83B9DAE;
	Fri, 26 Jun 2026 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506259; cv=none; b=Sxi+YYgGm2DR3/UR7ucu0S8T6suwdBp+p395+LESMGw3NhEtwTVvFwOaQe4K1cFEf+V41hJo77kDhlbpY/HWKFkDmmWQGpJ/D4GnQibu3KlpCJGRjfRexO90WzTb/tScZmyiLGT+gA8NAmA6ItfWNV/FoMbXHcygpVgikIPgl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506259; c=relaxed/simple;
	bh=+A2FU6VF/cIfIOhUFB1LNMfzDHTD0hmtVaW25lwPGjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oRIbMWs2Tcw1J1oHzpC6A4Z6dl/RDBOymDIF0AjFiwlbirOu9X1bpptp4mVs0NbaGYmk6HzV4dPhokmgNOp77F9nkYCIo0xGWgu3SG8eQBmwg+52sW24RXe+RiqUlEYLfc/s+cGUTpSlhEWV83oI5d8C/t6l5ukeM9exdaA6fhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KonUhT/u; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KonUhT/u"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wdDIJ-00AoOV-Iv; Fri, 26 Jun 2026 22:36:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=hx9bkK2sxM76pNzLvsxqdpArZV/FzA5Z2NgVR5n6pec=; b=KonUhT/upZ6LIwJONzq4FRcnWi
	och4Vhxm7DYI4/scm4Pa1nvadiDShAiztMChZ8cYt3mj4o7Cd7UFbkfk1/QshQMuiUK1FJDW/tawg
	mwdBEzJ7pA3gH3kvgjOgxgaRFHuNnFeluVdEUIN/nfugu72ognZanZGDPz1DV0liMvJuAxSIEX4KU
	nFhHxs/6DFWh0tBdisjsd98+eBmXSUYq07bKp1cy7GS9c8DJdrttLJSRX3mFK+C+zeQVL5qktZ5xl
	3njWmbD2WJ3trDHzodgYL8y5TgHwYOeeVXym0dJW1MUjIqw7VTixLYnhZiZEWudnWrhX5S9H8h4Mq
	tqxUydhQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wdDIH-0006SG-Ko; Fri, 26 Jun 2026 22:36:57 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wdDIA-006anB-Cz;
	Fri, 26 Jun 2026 22:36:50 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 26 Jun 2026 22:36:30 +0200
Subject: [PATCH bpf v2 2/4] selftests/bpf: Ensure UDP sockets are bound
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-sockmap-lookup-udp-leak-v2-2-7e7e201c951a@rbox.co>
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Update sockmap_basic tests to bind sockets before they are used. This
accommodates the recent change in sockmap that rejects unbound UDP sockets.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cb3229711f93..2d22a9058a8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -853,7 +853,7 @@ static void test_sockmap_many_socket(void)
 		return;
 	}
 
-	udp = xsocket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, 0);
+	udp = socket_loopback(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK);
 	if (udp < 0) {
 		close(dgram);
 		close(tcp);
@@ -922,7 +922,7 @@ static void test_sockmap_many_maps(void)
 		return;
 	}
 
-	udp = xsocket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, 0);
+	udp = socket_loopback(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK);
 	if (udp < 0) {
 		close(dgram);
 		close(tcp);
@@ -993,7 +993,7 @@ static void test_sockmap_same_sock(void)
 		return;
 	}
 
-	udp = xsocket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, 0);
+	udp = socket_loopback(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK);
 	if (udp < 0) {
 		close(dgram);
 		close(tcp);

-- 
2.54.0

