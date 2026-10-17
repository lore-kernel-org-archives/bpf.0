Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973733CCFB2
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247935; cv=none; b=U75aJzcu0UdCKBhIq2xqB1arKv8s29HwEmVWY920XUgoEtgSqjC9tXacV/HPAl7EvwNWW6ou9dXIhkMuj6jMeCS9aMyhEJkQb+HVqPUt6QvYQK/11FggYcr+8HVjwn+DG+DmhJHzp/AEaJLBKAF2wlvrBMyW+LkYdsApZuhhQJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247935; c=relaxed/simple;
	bh=fhyc6R6ModOtnD7L+jTwXbhTgus7dkROG/hK5xGwd0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQgdAeGV0f55VbS2GakVX7wlisZm6KddHXh+eQYzTiYpCqgjdS9dAHK9qBx612cp4Hpg5lgFpLA35dpz7hfgBbAGr9/5i3F4iptwlAuvlR8n5kBITNkZsmHTT5EprFLpkWCXf5YXSvWiqcbKMcW0ArNJMcsGHwZbLp1S7buW3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g+DQB3Kc; arc=none smtp.client-ip=95.215.58.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g+DQB3Kc"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fhyc6R6ModOtnD7L+jTwXbhTgus7dkROG/hK5xGwd0w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792247931; v=1; x=1792852731;
 b=g+DQB3KcwewBElICQBPhWTGMvHSO02Kxc38DUf9YPD7RFVLPMOEuyJjdG919tS3OaquFDy9E
 WhM5aT+PQduxJf5mqYxZyfH2d6+w3bdsK70SIyRdl/BjF5ZqZ9tLIERmOZirbgMSPZJFgBssd7u
 mGO69cHvmffCY17wnunFO+gc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2db501b365efd3b9;
	Sat, 17 Oct 2026 14:38:51 +0000
X-Mizu-Trace-ID: 2db501b365efd3b9
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Martin Teichmann <martin.teichmann@xfel.eu>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test narrow read of bpf_tcp_sock u64 fields
Date: Sat, 17 Oct 2026 22:38:13 +0800
Message-ID: <20261017143819.209510-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017143819.209510-1-jiayuan.chen@linux.dev>
References: <20261017143819.209510-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that reads the two u64 fields bytes_received and bytes_acked
at offset + 4 with a u32 load, to make sure such a narrower access is
rejected with "invalid tcp_sock access".

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/progs/verifier_sock.c       | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index 565c4d8bc3fa..d8e65938c35c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -611,6 +611,54 @@ l1_%=:	r0 = *(u64*)(r0 + %[bpf_tcp_sock_bytes_acked__end]);\
 	: __clobber_all);
 }
 
+SEC("cgroup/skb")
+__description("bpf_tcp_sock(skb->sk): narrow load of tp->bytes_received")
+__failure __msg("invalid tcp_sock access")
+__failure_unpriv
+__naked void skb_sk_tp_bytes_received_narrow(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_tcp_sock];				\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r0 = *(u32*)(r0 + %[off]);			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_tcp_sock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(off, offsetof(struct bpf_tcp_sock, bytes_received) + 4)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("bpf_tcp_sock(skb->sk): narrow load of tp->bytes_acked")
+__failure __msg("invalid tcp_sock access")
+__failure_unpriv
+__naked void skb_sk_tp_bytes_acked_narrow(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_tcp_sock];				\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r0 = *(u32*)(r0 + %[off]);			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_tcp_sock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(off, offsetof(struct bpf_tcp_sock, bytes_acked) + 4)
+	: __clobber_all);
+}
+
 SEC("cgroup/skb")
 __description("bpf_tcp_sock(bpf_sk_fullsock(skb->sk)): tp->snd_cwnd")
 __success __success_unpriv __retval(0)
-- 
2.43.0

