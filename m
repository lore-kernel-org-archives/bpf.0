Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D64A2E19;
	Thu, 24 Sep 2026 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263920; cv=none; b=UMONIRIdYIG1G0ks4Ppg2sViO8lwo2B/pQtPUsLdLyvFJdVaYrMyB91X5H20cRyHzO7qFE5YfsFKmqttNg7pxSEon1y/5xBTCnJzRdDD3F06RMLJeW1e6aGr0pKtH8XpZuK+B9ltgjZvSUviKrz8/qcQdzb90r8UU1kSfhy+pRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263920; c=relaxed/simple;
	bh=3xo8ngm/a45taQFOuaP0QBr/hJSDbioFbORZziwTNgw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VfhM1lkNs1Jo2X6BXED9lMX2SfJzjiKkP1oS+F5fN0GILorgIC7icRWcrt5tvIgVdihZ3rs0OwUwM7kBhSHS5uzA+71CV6Pfe06FmfSTnhTUbBVyBOQDCRyx1+CrOzJ/qKXtzzXl6Dd1WTtD3TtJjd2ep5iDn4xLcWNrEWVn/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=floOD8J8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SWkaRAUi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="floOD8J8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SWkaRAUi"
Date: Thu, 24 Sep 2026 17:31:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790263915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wiPTQbaQJEV34RoypBhntP44b/GO1dhGqAzeDjKzHns=;
	b=floOD8J8WL1BIoRbv8JoybFmQXvK//30BoLaqmmskCXp+UFQtc9dK6DYls0kSdZr+omfgZ
	pkNajWbIW3s4cCHCamzvcZMvYpS2SLxldDJDXmc1ZjVK+mv/jDG+wySaj8XhRbQESnl82/
	VwtbfsSwIb3iHBzM2HDEkRzj7WBgEOSuqYgpoiemH9ItNYk6YTrM0O43oeWxskGQ5HsRjx
	HvsM/eSS5j/HKaDkjUZ7P+CuhzXUID9FeUMTP3cBf3Imwe1NQ7Ox/0yrntO2t+NPllghZ0
	YEEsyRNp6CAQU3TKzm40UFitcztcNewTvq3qmXGyeMhoBfVQHTKLJRB/6Bg64g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790263915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wiPTQbaQJEV34RoypBhntP44b/GO1dhGqAzeDjKzHns=;
	b=SWkaRAUiDx2uTxJ6EghqsmHO+OG7jVZOpK0Z87LESniZ/fk27qrwnZRoTvPd6eMYzLU89B
	GVBnVHDdC5JYC2Bw==
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
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v3 bpf-next] selftests/bpf: Replace %pK output with 0
Message-ID: <20260924153153.tlErkAb5@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Networking used to print the socket pointer with %p as output in the
/proc interface. This was later changed to %pK in order not to reveal
the actual pointer value. The output format has then been copied to bpf
tests which produce the same format including the %pK format modifier.

Networking recently replaced the socket output with a plain 0 because
the socket pointer added no value to the output and the %pK should be
removed from library handling. The format remained otherwise unchanged in
order not to break any tools which are parsing this information.

This change removes the %pK modifier from bpf, following the change in
networking.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
The networking change is in net-next as commit 7c0ec6288b497 ("net:
Replace %pK output with 0")

The bots complain about "unchanged format" which is changed in terms of
spacing. The order of printed items is unchanged.

v2=E2=80=A6v3: https://lore.kernel.org/all/20260918102610.gxA3km8_@linutron=
ix.de/
  - correct the subject line
  - correct grammar error in the commit description
  - Pickup a reviewed-by tag from Emil which was sent for v1

v1=E2=80=A6v2: https://lore.kernel.org/all/20260911145011.kErTVDkS@linutron=
ix.de/
  - sync dump_udp4(), dump_udp6() with net (0, spacing). The columns are
    (were) not aligned.
  - Update comment in snprintf.c

 tools/testing/selftests/bpf/README.rst               |  2 +-
 tools/testing/selftests/bpf/prog_tests/snprintf.c    |  4 ++--
 tools/testing/selftests/bpf/progs/bpf_iter_netlink.c |  4 ++--
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c    | 11 +++++------
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c    | 11 +++++------
 tools/testing/selftests/bpf/progs/bpf_iter_udp4.c    |  4 ++--
 tools/testing/selftests/bpf/progs/bpf_iter_udp6.c    |  4 ++--
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c    |  5 ++---
 tools/testing/selftests/bpf/progs/test_snprintf.c    |  4 ++--
 9 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftes=
ts/bpf/README.rst
index 07c834433b388..75ff1142c1857 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -187,7 +187,7 @@ The symptom for ``bpf_iter/netlink`` looks like
   ...
   15: (bf) r2 =3D r7
   16: (0f) r2 +=3D r1
-  ; BPF_SEQ_PRINTF(seq, "%pK %-3d ", s, s->sk_protocol);
+  ; BPF_SEQ_PRINTF(seq, "%p %-3d ", s, s->sk_protocol);
   17: (7b) *(u64 *)(r7 +0) =3D r2
   only read is supported
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/test=
ing/selftests/bpf/prog_tests/snprintf.c
index 4e4a82d54f799..ccfb02bd4e7cd 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -15,8 +15,8 @@
 #define EXP_SYM_OUT  "schedule schedule+0x0/"
 #define MIN_SYM_RET  sizeof(EXP_SYM_OUT)
=20
-/* The third specifier, %p, is a hashed pointer which changes on every reb=
oot */
-#define EXP_ADDR_OUT "0000000000000000 ffff00000add4e55 "
+/* The second specifier, %p, is a hashed pointer which changes on every re=
boot */
+#define EXP_ADDR_OUT "ffff00000add4e55 "
 #define EXP_ADDR_RET sizeof(EXP_ADDR_OUT "unknownhashedptr")
=20
 #define EXP_STR_OUT  "str1         a  b c      d e longstr"
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/tools/t=
esting/selftests/bpf/progs/bpf_iter_netlink.c
index 00b2ceae81fb0..b9107d3ab6039 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
@@ -25,12 +25,12 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
 		return 0;
=20
 	if (ctx->meta->seq_num =3D=3D 0)
-		BPF_SEQ_PRINTF(seq, "sk               Eth Pid        Groups   "
+		BPF_SEQ_PRINTF(seq, "sk Eth Pid        Groups   "
 				    "Rmem     Wmem     Dump  Locks    Drops    "
 				    "Inode\n");
=20
 	s =3D &nlk->sk;
-	BPF_SEQ_PRINTF(seq, "%pK %-3d ", s, s->sk_protocol);
+	BPF_SEQ_PRINTF(seq, "0  %-3d ", s->sk_protocol);
=20
 	if (!nlk->groups)  {
 		group =3D 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/test=
ing/selftests/bpf/progs/bpf_iter_tcp4.c
index b1e509b231cd9..d149cf0d07be6 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
@@ -131,8 +131,7 @@ static int dump_tcp_sock(struct seq_file *seq, struct t=
cp_sock *tp,
 		       icsk->icsk_probes_out,
 		       sock_i_ino(sp),
 		       sp->sk_refcnt.refs.counter);
-	BPF_SEQ_PRINTF(seq, "%pK %lu %lu %u %u %d\n",
-		       tp,
+	BPF_SEQ_PRINTF(seq, "0 %lu %lu %u %u %d\n",
 		       jiffies_to_clock_t(icsk->icsk_rto),
 		       jiffies_to_clock_t(icsk->icsk_ack.ato),
 		       (icsk->icsk_ack.quick << 1) | inet_csk_in_pingpong_mode(icsk),
@@ -161,10 +160,10 @@ static int dump_tw_sock(struct seq_file *seq, struct =
tcp_timewait_sock *ttw,
 	BPF_SEQ_PRINTF(seq, "%4d: %08X:%04X %08X:%04X ",
 		       seq_num, src, srcp, dest, destp);
=20
-	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n",
+	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d 0\n",
 		       tw->tw_substate, 0, 0,
 		       3, jiffies_delta_to_clock_t(delta), 0, 0, 0, 0,
-		       tw->tw_refcnt.refs.counter, tw);
+		       tw->tw_refcnt.refs.counter);
=20
 	return 0;
 }
@@ -185,9 +184,9 @@ static int dump_req_sock(struct seq_file *seq, struct t=
cp_request_sock *treq,
 		       seq_num, irsk->ir_loc_addr,
 		       irsk->ir_num, irsk->ir_rmt_addr,
 		       bpf_ntohs(irsk->ir_rmt_port));
-	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n",
+	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d 0\n",
 		       TCP_SYN_RECV, 0, 0, 1, jiffies_to_clock_t(ttd),
-		       req->num_timeout, uid, 0, 0, 0, req);
+		       req->num_timeout, uid, 0, 0, 0);
=20
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c b/tools/test=
ing/selftests/bpf/progs/bpf_iter_tcp6.c
index dbc7166aee91f..cd65fa81f1219 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
@@ -135,8 +135,7 @@ static int dump_tcp6_sock(struct seq_file *seq, struct =
tcp6_sock *tp,
 		       icsk->icsk_probes_out,
 		       sock_i_ino(sp),
 		       sp->sk_refcnt.refs.counter);
-	BPF_SEQ_PRINTF(seq, "%pK %lu %lu %u %u %d\n",
-		       tp,
+	BPF_SEQ_PRINTF(seq, "0 %lu %lu %u %u %d\n",
 		       jiffies_to_clock_t(icsk->icsk_rto),
 		       jiffies_to_clock_t(icsk->icsk_ack.ato),
 		       (icsk->icsk_ack.quick << 1) | inet_csk_in_pingpong_mode(icsk),
@@ -170,10 +169,10 @@ static int dump_tw_sock(struct seq_file *seq, struct =
tcp_timewait_sock *ttw,
 		       dest->s6_addr32[0], dest->s6_addr32[1],
 		       dest->s6_addr32[2], dest->s6_addr32[3], destp);
=20
-	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n",
+	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d 0\n",
 		       tw->tw_substate, 0, 0,
 		       3, jiffies_delta_to_clock_t(delta), 0, 0, 0, 0,
-		       tw->tw_refcnt.refs.counter, tw);
+		       tw->tw_refcnt.refs.counter);
=20
 	return 0;
 }
@@ -201,9 +200,9 @@ static int dump_req_sock(struct seq_file *seq, struct t=
cp_request_sock *treq,
 		       dest->s6_addr32[0], dest->s6_addr32[1],
 		       dest->s6_addr32[2], dest->s6_addr32[3],
 		       bpf_ntohs(irsk->ir_rmt_port));
-	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n",
+	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d 0\n",
 		       TCP_SYN_RECV, 0, 0, 1, jiffies_to_clock_t(ttd),
-		       req->num_timeout, uid, 0, 0, 0, req);
+		       req->num_timeout, uid, 0, 0, 0);
=20
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c b/tools/test=
ing/selftests/bpf/progs/bpf_iter_udp4.c
index 23b2aa2604de2..d4079a619da66 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
@@ -57,13 +57,13 @@ int dump_udp4(struct bpf_iter__udp *ctx)
 	BPF_SEQ_PRINTF(seq, "%5d: %08X:%04X %08X:%04X ",
 		       ctx->bucket, src, srcp, dest, destp);
=20
-	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK %u=
\n",
+	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d 0 %u\n=
",
 		       inet->sk.sk_state,
 		       inet->sk.sk_wmem_alloc.refs.counter - 1,
 		       rqueue,
 		       0, 0L, 0, ctx->uid, 0,
 		       sock_i_ino(&inet->sk),
-		       inet->sk.sk_refcnt.refs.counter, udp_sk,
+		       inet->sk.sk_refcnt.refs.counter,
 		       udp_sk->drop_counters.drops0.counter +
 		       udp_sk->drop_counters.drops1.counter);
=20
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c b/tools/test=
ing/selftests/bpf/progs/bpf_iter_udp6.c
index c48b05aa2a4b2..dadc5f73ff098 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
@@ -65,13 +65,13 @@ int dump_udp6(struct bpf_iter__udp *ctx)
 		       dest->s6_addr32[0], dest->s6_addr32[1],
 		       dest->s6_addr32[2], dest->s6_addr32[3], destp);
=20
-	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK %u=
\n",
+	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d 0 %u\n=
",
 		       inet->sk.sk_state,
 		       inet->sk.sk_wmem_alloc.refs.counter - 1,
 		       rqueue,
 		       0, 0L, 0, ctx->uid, 0,
 		       sock_i_ino(&inet->sk),
-		       inet->sk.sk_refcnt.refs.counter, udp_sk,
+		       inet->sk.sk_refcnt.refs.counter,
 		       udp_sk->drop_counters.drops0.counter +
 		       udp_sk->drop_counters.drops1.counter);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/test=
ing/selftests/bpf/progs/bpf_iter_unix.c
index a2652c8c3616f..df3d971b21e8a 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
@@ -42,10 +42,9 @@ int dump_unix(struct bpf_iter__unix *ctx)
 	seq =3D ctx->meta->seq;
 	seq_num =3D ctx->meta->seq_num;
 	if (seq_num =3D=3D 0)
-		BPF_SEQ_PRINTF(seq, "Num               RefCount Protocol Flags    Type S=
t    Inode Path\n");
+		BPF_SEQ_PRINTF(seq, "Num       RefCount Protocol Flags    Type St    Ino=
de Path\n");
=20
-	BPF_SEQ_PRINTF(seq, "%pK: %08X %08X %08X %04X %02X %8lu",
-		       unix_sk,
+	BPF_SEQ_PRINTF(seq, "%08u: %08X %08X %08X %04X %02X %8lu", 0,
 		       sk->sk_refcnt.refs.counter,
 		       0,
 		       sk->sk_state =3D=3D TCP_LISTEN ? __SO_ACCEPTCON : 0,
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/test=
ing/selftests/bpf/progs/test_snprintf.c
index 8fda075440235..48a0025cf2ca8 100644
--- a/tools/testing/selftests/bpf/progs/test_snprintf.c
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -57,8 +57,8 @@ int handler(const void *ctx)
 	sym_ret  =3D BPF_SNPRINTF(sym_out,  sizeof(sym_out), "%ps %pS %pB",
 				&schedule, &schedule, &schedule);
 	/* Kernel pointers */
-	addr_ret =3D BPF_SNPRINTF(addr_out, sizeof(addr_out), "%pK %px %p",
-				0, 0xFFFF00000ADD4E55, 0xFFFF00000ADD4E55);
+	addr_ret =3D BPF_SNPRINTF(addr_out, sizeof(addr_out), "%px %p",
+				0xFFFF00000ADD4E55, 0xFFFF00000ADD4E55);
 	/* Strings and single-byte character embedding */
 	str_ret  =3D BPF_SNPRINTF(str_out, sizeof(str_out), "%s % 9c %+2c %-3c %0=
4c %0c %+05s",
 				str1, 'a', 'b', 'c', 'd', 'e', longstr);
--=20
2.55.0

