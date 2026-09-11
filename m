Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9DD37FF60;
	Fri, 11 Sep 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138216; cv=none; b=uiEtsL8xg0zEXHDceJTRHCWoqmc5xvIjkqcLVzeo6aNARaRUQAEGc4LkL4ZzgwNA7LkhlOmwngHEknjkOUatmc5ZK4weOsZMPSVXPiIrfZ70qdNynV2/3ySLL4YK3WR+6+n2+zPdGbchYlp8elJ1iX5EF3QrW2uqQI6/G1CG5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138216; c=relaxed/simple;
	bh=mDxqg0B0e+KGNJHlsebsiTptNATj7dUCBpyK2E8NT6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o//HgzfMHsuV491/udpISxs936GoQd/IYYb80v+ZHz73mzcIr9iML759klDYjP0pPfdThKoK3gvKAzBGYjhl7OGcXmG0yJjKW4b4ZQewv74Qt/pffAw8U8hq2bzdgOBeZZ9XmEMAikCic0iEfF5/B9J+1Hx27lpvT6YPp5cbIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qVjqd8sw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VnfR5lOm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qVjqd8sw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VnfR5lOm"
Date: Fri, 11 Sep 2026 16:50:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789138213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=NQc0xvG1LAZE/VmpEiuiCbOABr7P22cOsRYAgbKaSMQ=;
	b=qVjqd8sw1HN+POFN9xSWle5zUALishhX0bXxXtUcp+qNYXghZ6kkLBouGHIZAKv1+ggsbn
	flmWWh5bc6uhmPiPCoVEWfZDgEIWGR1TzcIViBvVy0GPKNsld2LuzxyTe5Zxs7+BcXI+c+
	TdFzpay6zJ2yGG11tN7EMSTCj/JsFnQ6+djfATiWZdgcWfG0jk6w3+iBJ4Ndm9VqAVEoyQ
	j5A/rEKaBjkLE9WDFYuseRiAeEVdl9a6QhCKqLXG1RvS/cvmjtfy7e1c3VEXX1YQAM/lO/
	ZyaDqAOPT+QkERSej2FBPaKjpLW1hpRxbrviwWjCrzuU9MktGBycWXAff7xDLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789138213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=NQc0xvG1LAZE/VmpEiuiCbOABr7P22cOsRYAgbKaSMQ=;
	b=VnfR5lOmfb/8uuVQnrdoKixhf8M5bLlrMVUNPZnNI+MDH2HT0A00yY4O4OAHu69qq7LMF5
	3Ntqb2JIpVqx5MAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, bigeasy@linutronix.de
Subject: [PATCH bpf-next] selftests/bpf: Replace %pK output with 0
Message-ID: <20260911145011.kErTVDkS@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Networking used to print the socket pointer with %p as output in the
/proc interface. This was later changed to %pK in order not to reveal
the actual pointer value. The output format has then been copied to bpf
tests which produce the same format including the %pK format modifier.

Networking recently replaced the socket output with a plain 0 because
the socket pointer added no value to the output and the %pK should be
removed fom library handling. The format remained otherwise unchanged in
order not to break any tools which are parsing this information.

This change removes the %pK modifier from bpf, following the change in
networking.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

The networking change is in net-next as commit 7c0ec6288b497 ("net:
Replace %pK output with 0")

 tools/testing/selftests/bpf/README.rst               |  2 +-
 tools/testing/selftests/bpf/prog_tests/snprintf.c    |  2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_netlink.c |  4 ++--
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c    | 11 +++++------
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c    | 11 +++++------
 tools/testing/selftests/bpf/progs/bpf_iter_udp4.c    |  4 ++--
 tools/testing/selftests/bpf/progs/bpf_iter_udp6.c    |  4 ++--
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c    |  3 +--
 tools/testing/selftests/bpf/progs/test_snprintf.c    |  4 ++--
 9 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index 07c834433b388..75ff1142c1857 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -187,7 +187,7 @@ The symptom for ``bpf_iter/netlink`` looks like
   ...
   15: (bf) r2 = r7
   16: (0f) r2 += r1
-  ; BPF_SEQ_PRINTF(seq, "%pK %-3d ", s, s->sk_protocol);
+  ; BPF_SEQ_PRINTF(seq, "%p %-3d ", s, s->sk_protocol);
   17: (7b) *(u64 *)(r7 +0) = r2
   only read is supported
 
diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
index 4e4a82d54f799..f2cd442c4683c 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -16,7 +16,7 @@
 #define MIN_SYM_RET  sizeof(EXP_SYM_OUT)
 
 /* The third specifier, %p, is a hashed pointer which changes on every reboot */
-#define EXP_ADDR_OUT "0000000000000000 ffff00000add4e55 "
+#define EXP_ADDR_OUT "ffff00000add4e55 "
 #define EXP_ADDR_RET sizeof(EXP_ADDR_OUT "unknownhashedptr")
 
 #define EXP_STR_OUT  "str1         a  b c      d e longstr"
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
index 00b2ceae81fb0..b9107d3ab6039 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
@@ -25,12 +25,12 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
 		return 0;
 
 	if (ctx->meta->seq_num == 0)
-		BPF_SEQ_PRINTF(seq, "sk               Eth Pid        Groups   "
+		BPF_SEQ_PRINTF(seq, "sk Eth Pid        Groups   "
 				    "Rmem     Wmem     Dump  Locks    Drops    "
 				    "Inode\n");
 
 	s = &nlk->sk;
-	BPF_SEQ_PRINTF(seq, "%pK %-3d ", s, s->sk_protocol);
+	BPF_SEQ_PRINTF(seq, "0  %-3d ", s->sk_protocol);
 
 	if (!nlk->groups)  {
 		group = 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
index b1e509b231cd9..d149cf0d07be6 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
@@ -131,8 +131,7 @@ static int dump_tcp_sock(struct seq_file *seq, struct tcp_sock *tp,
 		       icsk->icsk_probes_out,
 		       sock_i_ino(sp),
 		       sp->sk_refcnt.refs.counter);
-	BPF_SEQ_PRINTF(seq, "%pK %lu %lu %u %u %d\n",
-		       tp,
+	BPF_SEQ_PRINTF(seq, "0 %lu %lu %u %u %d\n",
 		       jiffies_to_clock_t(icsk->icsk_rto),
 		       jiffies_to_clock_t(icsk->icsk_ack.ato),
 		       (icsk->icsk_ack.quick << 1) | inet_csk_in_pingpong_mode(icsk),
@@ -161,10 +160,10 @@ static int dump_tw_sock(struct seq_file *seq, struct tcp_timewait_sock *ttw,
 	BPF_SEQ_PRINTF(seq, "%4d: %08X:%04X %08X:%04X ",
 		       seq_num, src, srcp, dest, destp);
 
-	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n",
+	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d 0\n",
 		       tw->tw_substate, 0, 0,
 		       3, jiffies_delta_to_clock_t(delta), 0, 0, 0, 0,
-		       tw->tw_refcnt.refs.counter, tw);
+		       tw->tw_refcnt.refs.counter);
 
 	return 0;
 }
@@ -185,9 +184,9 @@ static int dump_req_sock(struct seq_file *seq, struct tcp_request_sock *treq,
 		       seq_num, irsk->ir_loc_addr,
 		       irsk->ir_num, irsk->ir_rmt_addr,
 		       bpf_ntohs(irsk->ir_rmt_port));
-	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n",
+	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d 0\n",
 		       TCP_SYN_RECV, 0, 0, 1, jiffies_to_clock_t(ttd),
-		       req->num_timeout, uid, 0, 0, 0, req);
+		       req->num_timeout, uid, 0, 0, 0);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
index dbc7166aee91f..cd65fa81f1219 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
@@ -135,8 +135,7 @@ static int dump_tcp6_sock(struct seq_file *seq, struct tcp6_sock *tp,
 		       icsk->icsk_probes_out,
 		       sock_i_ino(sp),
 		       sp->sk_refcnt.refs.counter);
-	BPF_SEQ_PRINTF(seq, "%pK %lu %lu %u %u %d\n",
-		       tp,
+	BPF_SEQ_PRINTF(seq, "0 %lu %lu %u %u %d\n",
 		       jiffies_to_clock_t(icsk->icsk_rto),
 		       jiffies_to_clock_t(icsk->icsk_ack.ato),
 		       (icsk->icsk_ack.quick << 1) | inet_csk_in_pingpong_mode(icsk),
@@ -170,10 +169,10 @@ static int dump_tw_sock(struct seq_file *seq, struct tcp_timewait_sock *ttw,
 		       dest->s6_addr32[0], dest->s6_addr32[1],
 		       dest->s6_addr32[2], dest->s6_addr32[3], destp);
 
-	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n",
+	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d 0\n",
 		       tw->tw_substate, 0, 0,
 		       3, jiffies_delta_to_clock_t(delta), 0, 0, 0, 0,
-		       tw->tw_refcnt.refs.counter, tw);
+		       tw->tw_refcnt.refs.counter);
 
 	return 0;
 }
@@ -201,9 +200,9 @@ static int dump_req_sock(struct seq_file *seq, struct tcp_request_sock *treq,
 		       dest->s6_addr32[0], dest->s6_addr32[1],
 		       dest->s6_addr32[2], dest->s6_addr32[3],
 		       bpf_ntohs(irsk->ir_rmt_port));
-	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n",
+	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d 0\n",
 		       TCP_SYN_RECV, 0, 0, 1, jiffies_to_clock_t(ttd),
-		       req->num_timeout, uid, 0, 0, 0, req);
+		       req->num_timeout, uid, 0, 0, 0);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
index 23b2aa2604de2..9b789f09f1462 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
@@ -57,13 +57,13 @@ int dump_udp4(struct bpf_iter__udp *ctx)
 	BPF_SEQ_PRINTF(seq, "%5d: %08X:%04X %08X:%04X ",
 		       ctx->bucket, src, srcp, dest, destp);
 
-	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK %u\n",
+	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %8d %u\n",
 		       inet->sk.sk_state,
 		       inet->sk.sk_wmem_alloc.refs.counter - 1,
 		       rqueue,
 		       0, 0L, 0, ctx->uid, 0,
 		       sock_i_ino(&inet->sk),
-		       inet->sk.sk_refcnt.refs.counter, udp_sk,
+		       inet->sk.sk_refcnt.refs.counter, 0,
 		       udp_sk->drop_counters.drops0.counter +
 		       udp_sk->drop_counters.drops1.counter);
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
index c48b05aa2a4b2..9766eff7069ff 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
@@ -65,13 +65,13 @@ int dump_udp6(struct bpf_iter__udp *ctx)
 		       dest->s6_addr32[0], dest->s6_addr32[1],
 		       dest->s6_addr32[2], dest->s6_addr32[3], destp);
 
-	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK %u\n",
+	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %8d %u\n",
 		       inet->sk.sk_state,
 		       inet->sk.sk_wmem_alloc.refs.counter - 1,
 		       rqueue,
 		       0, 0L, 0, ctx->uid, 0,
 		       sock_i_ino(&inet->sk),
-		       inet->sk.sk_refcnt.refs.counter, udp_sk,
+		       inet->sk.sk_refcnt.refs.counter, 0,
 		       udp_sk->drop_counters.drops0.counter +
 		       udp_sk->drop_counters.drops1.counter);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
index a2652c8c3616f..36690478992f8 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
@@ -44,8 +44,7 @@ int dump_unix(struct bpf_iter__unix *ctx)
 	if (seq_num == 0)
 		BPF_SEQ_PRINTF(seq, "Num               RefCount Protocol Flags    Type St    Inode Path\n");
 
-	BPF_SEQ_PRINTF(seq, "%pK: %08X %08X %08X %04X %02X %8lu",
-		       unix_sk,
+	BPF_SEQ_PRINTF(seq, "%08u: %08X %08X %08X %04X %02X %8lu", 0,
 		       sk->sk_refcnt.refs.counter,
 		       0,
 		       sk->sk_state == TCP_LISTEN ? __SO_ACCEPTCON : 0,
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
index 8fda075440235..48a0025cf2ca8 100644
--- a/tools/testing/selftests/bpf/progs/test_snprintf.c
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -57,8 +57,8 @@ int handler(const void *ctx)
 	sym_ret  = BPF_SNPRINTF(sym_out,  sizeof(sym_out), "%ps %pS %pB",
 				&schedule, &schedule, &schedule);
 	/* Kernel pointers */
-	addr_ret = BPF_SNPRINTF(addr_out, sizeof(addr_out), "%pK %px %p",
-				0, 0xFFFF00000ADD4E55, 0xFFFF00000ADD4E55);
+	addr_ret = BPF_SNPRINTF(addr_out, sizeof(addr_out), "%px %p",
+				0xFFFF00000ADD4E55, 0xFFFF00000ADD4E55);
 	/* Strings and single-byte character embedding */
 	str_ret  = BPF_SNPRINTF(str_out, sizeof(str_out), "%s % 9c %+2c %-3c %04c %0c %+05s",
 				str1, 'a', 'b', 'c', 'd', 'e', longstr);
-- 
2.55.0

