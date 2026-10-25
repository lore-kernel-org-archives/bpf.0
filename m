Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792971946;
	b=h9LQBsLQohSd6sXJVJsXcDYFkBlLaAfVw5Z+uhT3539bFmxso6Nldl/LHK/063VIiHDu
	 SiBUUR5MLlyguR8jZUO0LlO9ibalnfnycJQ5ZxtfGjmbolhgeCDFTvcBlgea0IAvqDFWv
	 k7nue5NbfJ8xzEv6RlR6a7GWgR1h5zdXYX01UR7jCMS6mCCVv1ukkWzjucjBy2Oy1maHP
	 r11I4hi7zzjoQTXOCFCtoradfarY1/27qnLZtpk3HoRFcuZqjoDvVks9zgA6hDj2Xpen+
	 aNH5tirSywejDJVLEgtU+d7PixfVTAq1DZB1JAXWUaHuTLF/I8jKzQIgzMxG2mJuLwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971946;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=V7d/1Q16AniqDuKOFI7Hvr5gX9EtSjbRsrj3kU054MQ=;
	b=ZSqqAgsoCHzs8Gb3/miKxOWXkb9qHlhxl9NZdgpngYBilBWFywAQV6jPH2au7S2YHWXh
	 gzLB+7U6CC6JCnd4IM5vikk4dJhaLGQKEp/qtS6WTEtyzqu8ZAJv5sPExqs9Kzs2rYV4O
	 4AbaC4f4+z8N6U0M1jMWdXUqvG8wZBIb4PnJi+k1gYqm3wHIFcF5ROyJlX3KlRxQLV25S
	 pA3NQpc25eiixXVhQ76XEe/wYxSWERBWjaNpDChXCfcHIHrzn6d3NQSZHLp6qNX977ads
	 m4Gzf6LvCayLxn1vzz6zW+O4vZu0Io8OYFjwx0BvsbTqQqV9zy7fo3N0qBSunP2SZUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwF6Z5bO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67AF606A333;
	Sun, 25 Oct 2026 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwF6Z5bO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792971945;
	b=AmKXTXnofriixThZMOt1dIZLnnMuRSw4ve2vNPX5vyI7Gks/K2MFb5gsQx9Kdz1I9OUc
	 +MCfE+Hl6rUQBFghVvKq0eX1i67BTlgQd1uMLvlOy6eUPhWdiJqsTQaCX1p1Zh/pG5+ky
	 Zyd2Qp8+g3KcznO5edqzKUdeV3Z4tZgT6lDWuTzWh3w1+Lofw4+nnII9N2x5tmUVk41uj
	 iNOhUnKcUuGfJ24NDytRAJ1kEjwZw3Ry2YDeYB3m9U7jcYfVjJY2ubQIQEZkiUBZYUMfS
	 t6dVGI65+Iqfe0qKxl80IxHjv9Jf2bCl8rNxfcsUzbDoJ04qZJe1W2joi5bTxhEwJ4A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792971945;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=V7d/1Q16AniqDuKOFI7Hvr5gX9EtSjbRsrj3kU054MQ=;
	b=JpAvoBxHOyLV2WCoZrt6gtiEG4BkNYfBe9ziRXmQV34xBJbgOyXNc1MMGpyjlBf4zOP+
	 R5d6LtrUA2MMYsFstMzumZ6Ahmz3114JtXStqV9DTXBdzcyCZWku3Fl5d+ibCqaQgGUdX
	 yXiEdBemf23LFG81OmcNN0bQcyjtxgFWCPEMDgJL/JMqLQiKqtvga1jv4G3dpJnw76UFu
	 b/RF72i/FjG7IB02KfMCGpwzhxLDH8GdyaLZBl9bHIa/OtrvJARz0l3oM545ELp3gChZr
	 LmoHFnHBNXOazAAC4/kwjBxtvr8Z4QgyBoK7jNZuImGZWllc8GhjIualgfY+NnBu4bg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 016401F01829;
	Sun, 25 Oct 2026 23:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971945;
	bh=V7d/1Q16AniqDuKOFI7Hvr5gX9EtSjbRsrj3kU054MQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IwF6Z5bOZDAM8wEyJxn2A53yAXaraajy1Ys57Dq8601+H3oC6SXO8jBySjPLUzE9Q
	 DbJk9+ZcqZ70pfSdF4k/7JqSSUALpQnlwNuz6aBTua0HRjGoDvW+IFMxorXySTtlDa
	 UOj3Adz3PgPTV4Tdod/zjsFeKBois4OhBGZ2e3vCHEMDd4whg4qfJSHV/o+dOy4Bvq
	 YfRyKcOpmisIw30jyvAfn/nvf1h/rz+WTUOmrt5zLkAP+dLdO2Ny1u4ckt2yBKAlk6
	 aTTT9Kz+8iZbNqL1cANaZEU+RQSe1QH93hOylGzcpkPF0VHuKVpFh+Wkf0oMbjmJ1l
	 7ZgKZACCU9smg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 807FE44B31;
	Sun, 25 Oct 2026 23:45:43 +0000 (UTC)
From: Eli Skeggs via B4 Relay <devnull+kernel.eliskeggs.com@kernel.org>
Date: Sun, 25 Oct 2026 16:41:58 -0700
Subject: [PATCH bpf 2/2] selftests/bpf: Redirect a bare FIN to another
 socket's egress
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261025-sockmap-bare-fin-v1-2-bb8feae7c4a7@eliskeggs.com>
References: <20261025-sockmap-bare-fin-v1-0-bb8feae7c4a7@eliskeggs.com>
In-Reply-To: <20261025-sockmap-bare-fin-v1-0-bb8feae7c4a7@eliskeggs.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Eli Skeggs <kernel@eliskeggs.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792971941; l=4880;
 i=kernel@eliskeggs.com; s=20261021; h=from:subject:message-id;
 bh=4le5YBHhX3XoOuXEtcw57i6wiQvbpdg4GyDHi4mqUR4=;
 b=BZlc7bOp4bZPIb1hWZMCebUp1rGvnBTGlTSBaXqnLzp3+B+yJygeG2w0oeCh/cHy71ZESi2Rq
 M1dy0JoM6g5BmBJQCDhfWz3GEwTDar2pWL3vesnmicUiNV1/sKXnlq/
X-Developer-Key: i=kernel@eliskeggs.com; a=ed25519;
 pk=38k+FqQ3STTnr2H4HZ7IEseBOHWRDYVhvyMmQlB51gc=
X-Endpoint-Received: by B4 Relay for kernel@eliskeggs.com/20261021 with
 auth_id=1252
X-Original-From: Eli Skeggs <kernel@eliskeggs.com>
Reply-To: kernel@eliskeggs.com
Content-Transfer-Encoding: 7bit

From: Eli Skeggs <kernel@eliskeggs.com>

Redirect data from two sockets to a third socket's egress. Half-close
the first socket so that its FIN arrives in an skb of its own, then
confirm that data redirected from the second socket after the first
socket's half-close still egresses from the third socket, and that
the third socket reports no error.

Without the sk_psock_backlog() fix, the zero-length skb breaks the
target's psock: it ends up with a disabled transmit flag, and SO_ERROR
reports EPIPE.

Signed-off-by: Eli Skeggs <kernel@eliskeggs.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 74 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_pass_prog.c   |  8 +++
 2 files changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1fef6ec2ba7a..e1e477ce72b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1325,6 +1325,78 @@ static void test_sockmap_multi_channels(int sotype)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
+/* A bare FIN turns into an empty skb. When redirected to another socket,
+ * verify that it does not break the destination socket's psock. Data
+ * later redirected to the destination socket must still transmit.
+ */
+static void test_sockmap_skb_verdict_redir_fin(void)
+{
+	int c0 = -1, p0 = -1, c1 = -1, p1 = -1, c2 = -1, p2 = -1;
+	int err, map, zero = 0, one = 1, two = 2, sock_err;
+	struct test_sockmap_pass_prog *skel;
+	socklen_t len = sizeof(sock_err);
+	struct bpf_program *prog;
+	char buf = 'x', rcv;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	err = create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);
+	if (!ASSERT_OK(err, "create_socket_pairs()"))
+		goto end;
+	err = create_pair(AF_INET, SOCK_STREAM, &c2, &p2);
+	if (!ASSERT_OK(err, "create_pair()"))
+		goto end;
+
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+	prog = skel->progs.prog_skb_verdict_egress;
+	err = bpf_prog_attach(bpf_program__fd(prog), map,
+			      BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
+		goto end;
+
+	err = bpf_map_update_elem(map, &zero, &p0, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(p0)"))
+		goto end;
+	err = bpf_map_update_elem(map, &one, &p1, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(p1)"))
+		goto end;
+	err = bpf_map_update_elem(map, &two, &p2, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(p2)"))
+		goto end;
+
+	if (!ASSERT_EQ(xsend(c0, &buf, 1, 0), 1, "xsend(c0)"))
+		goto end;
+	if (!ASSERT_EQ(recv_timeout(c1, &rcv, 1, 0, IO_TIMEOUT_SEC), 1,
+		       "recv_timeout(c1)"))
+		goto end;
+
+	err = shutdown(c0, SHUT_WR);
+	if (!ASSERT_OK(err, "shutdown(c0)"))
+		goto end;
+	if (!ASSERT_OK(recv_timeout(p0, &rcv, 1, 0, IO_TIMEOUT_SEC),
+		       "recv_timeout(p0) EOF"))
+		goto end;
+
+	if (!ASSERT_EQ(xsend(c2, &buf, 1, 0), 1, "xsend(c2)"))
+		goto end;
+	ASSERT_EQ(recv_timeout(c1, &rcv, 1, 0, IO_TIMEOUT_SEC), 1,
+		  "recv_timeout(c1) after FIN");
+
+	err = getsockopt(p1, SOL_SOCKET, SO_ERROR, &sock_err, &len);
+	if (ASSERT_OK(err, "getsockopt(SO_ERROR)"))
+		ASSERT_OK(sock_err, "p1 error");
+end:
+	close_fd(&c0);
+	close_fd(&p0);
+	close_fd(&c1);
+	close_fd(&p1);
+	close_fd(&c2);
+	close_fd(&p2);
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 /* A socket in a sockmap without a verdict program keeps its ingress data
  * in sk_receive_queue: FIONREAD must account for it.
  */
@@ -1404,6 +1476,8 @@ void test_sockmap_basic(void)
 		test_sockmap_no_verdict_fionread();
 	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
 		test_sockmap_skb_verdict_fionread(false);
+	if (test__start_subtest("sockmap skb_verdict redirect bare FIN"))
+		test_sockmap_skb_verdict_redir_fin();
 	if (test__start_subtest("sockmap skb_verdict change tail"))
 		test_sockmap_skb_verdict_change_tail();
 	if (test__start_subtest("sockmap msg_verdict pop_data overflow"))
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c b/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
index ef9edca184ea..dd3cb7524e21 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
@@ -52,6 +52,14 @@ int prog_skb_verdict_ingress(struct __sk_buff *skb)
 	return bpf_sk_redirect_map(skb, &sock_map_rx, one, BPF_F_INGRESS);
 }
 
+SEC("sk_skb/stream_verdict")
+int prog_skb_verdict_egress(struct __sk_buff *skb)
+{
+	int one = 1;
+
+	return bpf_sk_redirect_map(skb, &sock_map_rx, one, 0);
+}
+
 SEC("sk_skb/stream_parser")
 int prog_skb_verdict_ingress_strp(struct __sk_buff *skb)
 {

-- 
2.56.0


