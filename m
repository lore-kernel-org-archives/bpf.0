Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B75356771
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632749; cv=none; b=JBoX15wmuROCBdUHemqphBMkz7NF05EbQM2rBKAad25MmTQ87ATpeUuhgFr5yv+k2ZCjyRESed8iwTN4qqgF2MPH6LvMe5KjjgozsCkUUwoYkIQOR/TgVYX7xem4tVWaYBTo3hPJoawP8EAYddowkeUuMlbgkYdLoSsFRWCaGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632749; c=relaxed/simple;
	bh=3bNS7vZoXU7N1kY+Mih7avyiv/bjFO+bIZ/936OV2eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxwIXpSmP/LQyVnOkcMJGDKxYnW5D9Zxf8yHDFummOKtKToE3MeEnKl6c1IVQCwCmVUSFZPDFByN0uWgwXqoPx7dKdxnvKKiEKvp6f3J+PfYPi7aa8fPyOSib+6qrFYGrzzSTcE33+OP7HA6baEWa6eq5SjEdSutAKT7mxHOxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YJxm5y5M; arc=none smtp.client-ip=91.218.175.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YJxm5y5M"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3bNS7vZoXU7N1kY+Mih7avyiv/bjFO+bIZ/936OV2eE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789632744; v=1; x=1790237544;
 b=YJxm5y5MdOh41MbVEXApn1rddksgDzoO6LWl/D4n9i6vAdoA07EFIgJisCeYYe/znG7+MxvJ
 FNAps4BQwoPMQZG5ASFvSu0zMTcM4werkB2I8rWvKASmjdgUR8Np1gESOQIHponWe94nApjcVyL
 b+FKbrcJ2sDBAuM3Z0ZkUIz8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6fe8c84a50e127c8;
	Thu, 17 Sep 2026 08:12:24 +0000
X-Mizu-Trace-ID: 6fe8c84a50e127c8
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	VEGA <vega@nebusec.ai>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Tejun Heo <tj@kernel.org>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v1 1/2] mptcp, bpf: reject bpf_sk_release() on msk
Date: Thu, 17 Sep 2026 16:11:57 +0800
Message-ID: <20260917081209.361367-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bpf prog can do this today:

	subflow = bpf_skc_lookup_tcp(...);
	msk = bpf_skc_to_mptcp_sock(subflow);
	bpf_sk_release(msk);

bpf_skc_to_mptcp_sock() returns subflow->conn without taking any
reference, so bpf_sk_release() drops a refcount nobody took on the msk,
and the subflow reference is leaked:

refcount_t: underflow; use-after-free.
WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xdf/0x120, CPU#2: mptcp_pair/440
Call Trace:
 <IRQ>
 sock_gen_put+0xda/0x100
 bpf_sk_release+0x5e/0xd0
 bpf_prog_780c70b94862636c_rel_msk+0x127/0x132
 __dev_queue_xmit+0x104b/0x3c90
 ip_finish_output2+0x9af/0x1c40
 __ip_finish_output+0x510/0x7e0
 ip_finish_output+0x2f/0x320
 ip_output+0x17a/0x3f0
 ip_local_out+0x12f/0x170
 __ip_queue_xmit+0x81d/0x1d50
 ip_queue_xmit+0x4a/0x80
 __tcp_transmit_skb+0x2f6f/0x5110
 __tcp_send_ack.part.0+0x385/0x740
 tcp_send_ack+0x70/0x90
 __tcp_ack_snd_check+0x1c9/0x8d0
 tcp_rcv_established+0xa1e/0x44f0
 tcp_v4_do_rcv+0x4b8/0xb30
 tcp_v4_rcv+0x27af/0x3e60
 ip_protocol_deliver_rcu+0x95/0x410
 ip_local_deliver_finish+0x357/0x5b0
 ip_local_deliver+0x15c/0x1c0
 ip_rcv+0x284/0x320

bpf_skc_to_mptcp_sock() is listed in is_ptr_cast_function(), so if the
subflow is a referenced obj (returned by bpf_skc_lookup_tcp()), the msk
becomes a referenced obj too, which lets bpf_sk_release() take it. That
list is for helpers casting a sock to another type at the same address,
which does not hold here: msk and subflow are two different socks.

Drop it from is_ptr_cast_function(). To keep the msk from outliving the
subflow it was derived from, tie the two together with the existing
parent_id, so this gets rejected as well:

	subflow = bpf_skc_lookup_tcp(...);
	msk = bpf_skc_to_mptcp_sock(subflow);
	bpf_sk_release(subflow);
	msk->token;			/* rejected now */

The other option was to reject bpf_skc_to_mptcp_sock() on a referenced
subflow altogether, but that breaks progs which only read msk fields, so
go with parent_id.

Reported-by: VEGA <vega@nebusec.ai>
Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/verifier.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e79750e2480..5db49a0c346f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -522,11 +522,21 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
 		func_id == BPF_FUNC_skc_to_tcp_sock ||
 		func_id == BPF_FUNC_skc_to_tcp6_sock ||
 		func_id == BPF_FUNC_skc_to_udp6_sock ||
-		func_id == BPF_FUNC_skc_to_mptcp_sock ||
 		func_id == BPF_FUNC_skc_to_tcp_timewait_sock ||
 		func_id == BPF_FUNC_skc_to_tcp_request_sock;
 }
 
+/*
+ * bpf_skc_to_mptcp_sock() does not cast its argument. It returns the parent
+ * MPTCP socket of the subflow that was passed in, so the return value must not
+ * inherit the argument's reference, or bpf_sk_release() would put the wrong
+ * socket.
+ */
+static bool is_ptr_derive_function(enum bpf_func_id func_id)
+{
+	return func_id == BPF_FUNC_skc_to_mptcp_sock;
+}
+
 static bool is_sync_callback_calling_kfunc(u32 btf_id);
 static bool is_async_callback_calling_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
@@ -11369,6 +11379,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
 		regs[BPF_REG_0].type &= ~PTR_MAYBE_NULL;
 		regs[BPF_REG_0].id = meta.ref_obj.id;
+	} else if (is_ptr_derive_function(func_id) &&
+		   find_reference_state(env->cur_state, meta.ref_obj.id)) {
+		err = validate_ref_obj(env, &meta.ref_obj);
+		if (err)
+			return err;
+
+		/* Ensures we don't access the object after a release_reference() */
+		regs[BPF_REG_0].parent_id = meta.ref_obj.id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
 		int id = acquire_reference(env, insn_idx, 0);
 
-- 
2.43.0

