Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727185;
	b=QDDimsFdDYyae/hh9xUnwRSlVSV0i1650VveSSiK6fsdXdUjQsvGvv8k892fgX6TFRZx
	 UsDdIpW0EfQIC8e6pAWMZ9JtzO82+UAO7A0T76a7JcoE+2lnjb3WYOQW9C2r25Nn0DrxA
	 CDWOnwHkWVPelZh6H9YrK1zVAZXIKGzzBvNYtfHe4gO/t4GeMpogYmb3pA+c1/HBf4Hw7
	 B0kygPuLbdJHv3UjOAdOIxxadll/n8HNaSeCBdkuIHhuZPOKDUDPQwTNJjvS0ko0amcp/
	 qgJ4+ATAqT11UIcLAGxOr6vLmN2wAwQ9thkCQMsG63vwbGx5Nd/wi+g/SII2Kk89vBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727185;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:X-CM-TRANSID:
	 Message-Id:X-Coremail-Antispam:Date:X-CM-SenderInfo;
	bh=wx+pTWYe2L1J9TNpz5QtoSwN8J9xEqwWbSaGt++qleY=;
	b=o9hKHHjz/lxvxJmAA99q9++3NMhMNHcvxotGAnNrTMItLX7g0nP65jvYvqRPv5uaCelH
	 /u3KOQoR8IH+LYlKIXpEVcTWmDSDcwv/jxlv4ZgrBNHnzSnZA7Xnsj3c/CGog/q8V4WHz
	 T+CAKM8Ep61DT8QqaTjr4+kL2a/hu3v1eqOCxtwwxNfj+Bfc+C6D85Tlt2/I/vSu/lDwt
	 dX9FNHISzyiZqwdkC3h1yJNd+cLSw5sG/eb/Pfywlo2aDvc/cM9EYGHBDNlb/+nJB+iyQ
	 gcH7MPRndvqqqeGkxa2dWbJQjFJLLF44jbpGO1IAr/muvf9oki4xmGD+zsPOmuBgBYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="PVCHlrY/";
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A854606A328;
	Tue,  3 Nov 2026 17:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A854606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PVCHlrY/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Message-Id:Date; bh=wx+pTWYe2L1J9TN
	pz5QtoSwN8J9xEqwWbSaGt++qleY=; b=PVCHlrY/Uy5NiugXnsGWzwtaizh87dW
	f3Q62CpWneg5N2lLggoeW8RO00etsPNV3+HhhDWThP0n5D8pV/TFqpejvX4dbWFA
	zAEPI2KqjjvxN5u8oaEYEj8j41q1FF95Ech3mLMrwTeIu4uvbvjdZWZkq6jYJFT8
	XYulfqXr42m0=
From: shaos <shawnq1@163.com>
To: Amery Hung <amery.hung@bytedance.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Martin KaFai Lau <martin.lau@kernel.org>,
 Toke =?utf-8?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,	linux-kernel@vger.kernel.org
Subject:
 [PATCH] bpf: net_sched: reject bpf_throw() in qdisc teardown callbacks
X-CM-TRANSID:PSgvCgCXagqsGupqnkg9Dg--.50703S2
Message-Id:<6AEA1AAD.2E7977.08739@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw45ZFW5trWrtFWftry8AFb_yoW7Zr43pa
	ykZ345Kr4rJr43WFsFyF4DAF13C39xWw4UCryDWry5CwsaqFyjqFWxKa47uFyYkryDCry0
	qr1qy3W3WF40kFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsdbbUUUUU=
Date: Wed, 4 Nov 2026 01:32:29 +0800 (CST)
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzw0HFWrqGq3ejAAA31
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Hello,

A BPF qdisc's generated reset/destroy epilogue cancels its watchdog
timer.  bpf_throw() unwinds directly to the exception callback and
skips that epilogue.  If the timer was armed, qdisc deletion frees the
qdisc while the embedded timer remains queued.  Later timer-queue
activity accesses the freed qdisc, producing a KASAN slab-use-after-free
and a kernel crash.

The reproducer registers a BPF qdisc whose dequeue callback arms the
watchdog and whose reset/destroy callbacks throw.  Two fresh KASAN boots
reported use-after-free in rb_insert_color on an object allocated by
qdisc_alloc() and later freed by qdisc teardown.  An otherwise identical
no-throw control completed deletion cleanly.  The required BPF and
network-administration capabilities make this a privileged local kernel
crash; no privilege escalation or code execution is demonstrated.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
Git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
Source version: Linux 7.3
Compiler:       gcc 11.4.0, GNU ld 2.38, clang 20 (BPF PoC)

The console log, full KASAN kernel config, and BPF C reproducer are
available from one fixed-revision Gist:

Console output:
https://gist.githubusercontent.com/shaos26/9908a8ddac69e303cb5dcc709958537f/raw/3fa043e43683907bcccacdc80a71b150920049da/console-output.txt
Kernel config:
https://gist.githubusercontent.com/shaos26/9908a8ddac69e303cb5dcc709958537f/raw/3fa043e43683907bcccacdc80a71b150920049da/kernel-config.txt
PoC source:
https://gist.githubusercontent.com/shaos26/9908a8ddac69e303cb5dcc709958537f/raw/3fa043e43683907bcccacdc80a71b150920049da/poc.c

Run this as root in a disposable VM booted with the target kernel,
CONFIG_DEBUG_INFO_BTF=y, bpftool, iproute2, clang 20, and libbpf-dev.
Build each variant against that kernel's BTF; test them on separate
fresh boots.  With libbpf headers installed under /usr/include:

    bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
    CLANG=/usr/lib/llvm-20/bin/clang
    LIBBPF_INC=/usr/include
    "$CLANG" -target bpf -D__TARGET_ARCH_x86 -O2 -g -Wall -Werror \
      -Wno-missing-declarations -I. -I"$LIBBPF_INC" \
      -DVARIANT_THROW=1 -c poc.c -o qdisc-throw.bpf.o
    "$CLANG" -target bpf -D__TARGET_ARCH_x86 -O2 -g -Wall -Werror \
      -Wno-missing-declarations -I. -I"$LIBBPF_INC" \
      -DVARIANT_THROW=0 -c poc.c -o qdisc-control.bpf.o

Mount bpffs if it is not already mounted, register the matching object,
attach its qdisc to loopback, send one packet to arm the watchdog, and
delete the qdisc:

    mkdir -p /sys/fs/bpf
    mount -t bpf bpffs /sys/fs/bpf 2>/dev/null || true
    bpftool struct_ops register qdisc-throw.bpf.o /sys/fs/bpf
    ip link set lo up
    tc qdisc add dev lo root handle 1: agent31_uaf
    ping -c 1 -W 1 127.0.0.1
    tc qdisc del dev lo root
    sleep 10

For the separate control boot, register qdisc-control.bpf.o and use
qdisc kind agent31_ctl in the same sequence.

On the vulnerable kernel, the two throw runs reproduced the KASAN UAF;
the no-throw control survived.  With the patch below, the verifier
rejects bpf_throw() from reset/destroy with -EACCES, before qdisc
registration.  The patched control object registered, attached, armed
and deleted normally, then survived the watchdog interval.

Fixes: 7a2dafda950b ("bpf: net_sched: Add a qdisc watchdog timer")
Signed-off-by: shaos <shawnq1@163.com>
---
 net/sched/bpf_qdisc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 098ca02aed89c..61f0dc93d3856 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -12,6 +12,7 @@
 #define QDISC_MOFF_IDX(moff)	(moff / sizeof(void (*)(void)))
 
 static struct bpf_struct_ops bpf_Qdisc_ops;
+static const struct bpf_verifier_ops bpf_qdisc_verifier_ops;
 
 struct bpf_sched_data {
 	struct qdisc_watchdog watchdog;
@@ -131,6 +132,7 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 }
 
 BTF_ID_LIST_SINGLE(bpf_qdisc_init_prologue_ids, func, bpf_qdisc_init_prologue)
+BTF_ID_LIST_SINGLE(bpf_qdisc_throw_ids, func, bpf_throw)
 
 static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 				  const struct bpf_prog *prog)
@@ -307,20 +309,31 @@ enum qdisc_ops_kf_flags {
 	QDISC_OPS_KF_COMMON		= 0,
 	QDISC_OPS_KF_ENQUEUE		= 1 << 0,
 	QDISC_OPS_KF_DEQUEUE		= 1 << 1,
+	QDISC_OPS_KF_TEARDOWN		= 1 << 2,
 };
 
 static const u32 qdisc_ops_context_flags[] = {
 	[QDISC_OP_IDX(enqueue)]		= QDISC_OPS_KF_ENQUEUE,
 	[QDISC_OP_IDX(dequeue)]		= QDISC_OPS_KF_DEQUEUE,
 	[QDISC_OP_IDX(init)]		= QDISC_OPS_KF_COMMON,
-	[QDISC_OP_IDX(reset)]		= QDISC_OPS_KF_COMMON,
-	[QDISC_OP_IDX(destroy)]		= QDISC_OPS_KF_COMMON,
+	[QDISC_OP_IDX(reset)]		= QDISC_OPS_KF_TEARDOWN,
+	[QDISC_OP_IDX(destroy)]		= QDISC_OPS_KF_TEARDOWN,
 };
 
 static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	u32 moff, flags;
 
+	/* bpf_throw() bypasses the generated watchdog-cancellation epilogue. */
+	if (kfunc_id == bpf_qdisc_throw_ids[0] &&
+	    prog->aux->st_ops &&
+	    prog->aux->st_ops->verifier_ops == &bpf_qdisc_verifier_ops) {
+		moff = prog->aux->attach_st_ops_member_off;
+		flags = qdisc_ops_context_flags[QDISC_MOFF_IDX(moff)];
+		if (flags & QDISC_OPS_KF_TEARDOWN)
+			return -EACCES;
+	}
+
 	if (!btf_id_set8_contains(&qdisc_kfunc_ids, kfunc_id))
 		return 0;
 
-- 
2.34.1

