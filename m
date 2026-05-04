Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6F2DBF76
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879417; cv=none; b=dp9y5iP5YNTkt0brA3zJkriYnpalf2Ljy+QlBN02D98UbUIHPiW/glYIRNs/OwQgyxE/etDoAkvtv8HojbaPo7Xkz6o+s4vUQeCt+HlKwC1itkizexR6Rbr/cTbHS0UruzwkZcAwzhN+1gLgwChv1Ld7V3j42rqy7Av95d/6elc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879417; c=relaxed/simple;
	bh=vZpL3hFnPLX1qsmsl2h6q2noPRnMYzoWv2dK9qooY/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUFbKwQgxuuSbpyGyNrCnGF0RAC1IdO0T8nUi9N4m2LLjjME2tgYzxZTD/b1mu/GOEwogkg3pGCcBVDMFMPLxHh/9izCp8Gx5A0syr9vfTVhwIcOIVtnBTMUXNQxBvH+dNRX8YMwE0F3nFraHE/RQWvm3NGwcYFU/B4Sa53wlIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=SqwhWiv3; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="SqwhWiv3"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so2227608a12.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1777879412; x=1778484212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pR1ocLRvUn7kffo3HR6B9Aaxv8Xm9HWA7hfsrBewO7c=;
        b=SqwhWiv3jTFyrO14BU2FM+DJfdYV7U54SiyucZATCKZTai6JP1fOHwRjjpTG8vpHvm
         D110Q+YUlk8Cl9+YfGhhy8gMTPauQnJimmiWva7SadLzxcr4rJzSWpR44sLMcoU+cRk3
         8wicwjHAHBh1MiKSQup3N6HDn4u8dwLykRnLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777879412; x=1778484212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pR1ocLRvUn7kffo3HR6B9Aaxv8Xm9HWA7hfsrBewO7c=;
        b=N8tRqHhW411ad8BomxUDFQqVz/g80UFdJ+iH38oSXKLzb/wQawBjPpUBPZmwCIme0m
         GcSiccyp6/x/eWeIkLB9L41ltIEiakUqsrfruRBUhIO/xp7eZFdfT7xmZO4Mr71lISue
         8MEKZc2TP2s6uIIv6lebG2WpyfpZWlaCvl16AqZ5vc5bnXkdBCeqMHU7JVLjRlqdtptl
         CGm6p4/wmbcEa1gnBLW7GOTQbDtMMC9xjCq5oC8Pb/ZbfXEg35YjIZhGwVQl/LakInK6
         OvmYuCrEaoyZV3B6PKr/UGH9XnEIWs7Y5JvKSWV5KG7BJS/d/+BabQyhXSi/pzePIQzP
         y5bg==
X-Forwarded-Encrypted: i=1; AFNElJ/Mw5Nkzs8c2UdJ5nuoqR9IRTxLb187LJV/QGq6waGrfJsPb4OFj8c6iYtfGUf2P0lOk9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhuKQqw2p33jlpH3PEtF/Ozmv2hRjnR3ZENtLPZsPiPh9391PO
	iP6WRdPpFjktWWgkPJ3PNuDNUdu5JezH9mROaEhDa908EhXAk8+VqQM0DBb1VvKN2c4=
X-Gm-Gg: AeBDies1fQhl2jb9LteiOIZpKgT8S4f5kwA6BSl1EtVc+4NafcnjA2LwQkt3rGSrAjG
	GAXXiwBW/UJi4CN4269qzETUddGfbAHKUuzkhJV7oCTfCy+0KP0/bkZvGzbjO+pBfRmaO4c43l0
	q/AcBxyVVUmRyTkyc80wddALODfw+PrXtMTA0By7hOp0PmgN6EMi9nMGReXhz3efO14Bdl5vkIY
	q3bYRoL1V7pd5HsFScMhzml31FivS2hENdK4TGCHH+/qWqpMoRd4h1PVHPN58O78D7IMIoauktv
	5oCAy8ttWbmkvUTPUDs++KrZ16vjb/sjQANGJuKZUgUlj/elh4Kkz0dDU3CvdSFxf9ipK/eom6C
	U3HTOxHMHEZZOGLh5YTZy3Cn9T0JzegdRJHEMOvoMgQbkYwImSw+q/nW419P2L0WgD1j5ZLDGuQ
	jhQoCsjn2covdHmubLs3rXrUzvMQXmWPJCtua2fch85vBb3BhG7xfk/KXox7A5EkguXFt45sKgI
	t9pPal4rdWz
X-Received: by 2002:a05:6a21:3298:b0:39f:2307:8a2d with SMTP id adf61e73a8af0-3a7f1c69e0bmr8846267637.12.1777879411777;
        Mon, 04 May 2026 00:23:31 -0700 (PDT)
Received: from eulgyu-desktop.localdomain ([147.46.174.223])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbba8fefsm8486016a12.7.2026.05.04.00.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 00:23:31 -0700 (PDT)
From: Eulgyu Kim <eulgyukim@snu.ac.kr>
To: john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	byoungyoung@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: [BUG] KASAN: slab-use-after-free in __sk_msg_recvmsg
Date: Mon,  4 May 2026 16:23:25 +0900
Message-ID: <20260504072325.23474-1-eulgyukim@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We encountered a "KASAN: slab-use-after-free in __sk_msg_recvmsg"
on kernel version v7.1.0-rc1.

As this issue was identified via fuzzing and we have limited background,
we find it challenging to identify the exact root cause or propose a correct fix.
Therefore, please consider the following analysis as a best-effort guess,
which may still be incomplete or incorrect.

The issue is that sk_psock_peek_msg() only protects the list lookup; after it
drops ingress_lock, the returned sk_msg can be concurrently consumed and freed
by another recvmsg caller.

Following is the harmful sequence:

1. Thread A calls recvmmsg() on the socket and reaches __sk_msg_recvmsg()
through udp_bpf_recvmsg() -> sk_msg_recvmsg() -> __sk_msg_recvmsg().

2. __sk_msg_recvmsg() calls sk_psock_peek_msg() and obtains msg_rx, the
first struct sk_msg on psock->ingress_msg. The ingress_lock is dropped
immediately after the peek.

3. Thread A copies data to userspace and still holds local pointers to
msg_rx and sge = sk_msg_elem(msg_rx, i), but has not yet updated
sge->offset/sge->length or dequeued the message.

4. Thread B concurrently calls recvmmsg() on the same socket.

5. Because udp_bpf_recvmsg() does not hold a per-socket receive lock,
Thread B also enters sk_msg_recvmsg(), peeks the same msg_rx,
consumes the remaining data, updates sge->offset/sge->length,
dequeues the message with sk_psock_dequeue_msg(),
and frees it with kfree_sk_msg().

6. Thread A resumes and accesses sge->offset / sge->length. Since sge is
embedded in the freed struct sk_msg, this becomes a use-after-free.

We have included the following items below:
- C reproducer (~100 lines)
- kernel delay patch
- KASAN crash log

To reliably trigger the race condition bug, we patched the kernel
to inject a delay at a specific point.

The kernel config used is the same as the syzbot configuration.

We hope this report helps address the issue. Please let us know
if any further information is needed.

Thank you.

Best Regards,
Eulgyu Kim



kernel delay patch:
==================================================================
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6187a83bd..3599efa75 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -451,6 +451,8 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
                                *copied_from_self += copy;

                        if (likely(!peek)) {
+                               if (!strcmp(current->comm, "slowme"))
+                                       mdelay(2000);
                                sge->offset += copy;
                                sge->length -= copy;
                                if (!msg_rx->skb) {
==================================================================



C reproducer:
==================================================================
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <linux/bpf.h>
#include <netinet/in.h>
#include <pthread.h>
#include <stdint.h>
#include <sys/prctl.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/uio.h>
#include <unistd.h>

static int sk;

static void recv_one(void)
{
	char buf[1];
	struct iovec iov = {
		.iov_base = buf,
		.iov_len = sizeof(buf),
	};
	struct mmsghdr msg = {
		.msg_hdr.msg_iov = &iov,
		.msg_hdr.msg_iovlen = 1,
	};

	syscall(SYS_recvmmsg, sk, &msg, 1, 0, 0);
}

static void *thread_fn(void *arg)
{
	syscall(SYS_prctl, PR_SET_NAME, "slowme", 0, 0, 0);
	recv_one();
	return arg;
}

int main(void)
{
	struct bpf_insn prog[] = {
		{
			.code = BPF_ALU64 | BPF_MOV | BPF_K,
			.imm = SK_PASS,
		},
		{ .code = BPF_JMP | BPF_EXIT },
	};
	struct sockaddr_in addr = {
		.sin_family = AF_INET,
		.sin_port = htons(20000),
		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
	};
	union bpf_attr attr;
	pthread_t th;
	char byte = 0;
	int key = 0;
	int map_fd;
	int prog_fd;

	sk = syscall(SYS_socket, AF_INET, SOCK_DGRAM, 0);
	syscall(SYS_bind, sk, &addr, sizeof(addr));

	attr = (union bpf_attr){
		.map_type = BPF_MAP_TYPE_SOCKMAP,
		.key_size = sizeof(int),
		.value_size = sizeof(int),
		.max_entries = 1,
	};
	map_fd = syscall(SYS_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));

	attr = (union bpf_attr){
		.prog_type = BPF_PROG_TYPE_SK_SKB,
		.insn_cnt = sizeof(prog) / sizeof(prog[0]),
		.insns = (uint64_t)prog,
		.license = (uint64_t)"",
	};
	prog_fd = syscall(SYS_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));

	attr = (union bpf_attr){
		.target_fd = map_fd,
		.attach_bpf_fd = prog_fd,
		.attach_type = BPF_SK_SKB_STREAM_VERDICT,
	};
	syscall(SYS_bpf, BPF_PROG_ATTACH, &attr, sizeof(attr));

	attr = (union bpf_attr){
		.map_fd = map_fd,
		.key = (uint64_t)&key,
		.value = (uint64_t)&sk,
	};
	syscall(SYS_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));

	syscall(SYS_sendto, sk, &byte, sizeof(byte), 0, &addr, sizeof(addr));

	pthread_create(&th, 0, thread_fn, 0);
	sleep(1);
	recv_one();
	pthread_join(th, 0);
	return 0;
}

==================================================================



KASAN crash log:
==================================================================
BUG: KASAN: slab-use-after-free in __sk_msg_recvmsg+0x977/0x1010 net/core/skmsg.c:456
Read of size 4 at addr ff110001294ee828 by task slowme/9510
CPU: 2 UID: 0 PID: 9510 Comm: slowme Not tainted 7.1.0-rc1-gf1a5e78a55eb-dirty #11 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x64/0x70 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __sk_msg_recvmsg+0x977/0x1010 net/core/skmsg.c:456
 udp_bpf_recvmsg+0x17b/0xa90 net/ipv4/udp_bpf.c:83
 sock_recvmsg_nosec net/socket.c:1137 [inline]
 sock_recvmsg+0x155/0x1c0 net/socket.c:1159
 ____sys_recvmsg+0x1c9/0x460 net/socket.c:2918
 ___sys_recvmsg+0x1b5/0x510 net/socket.c:2960
 do_recvmmsg+0x307/0x770 net/socket.c:3055
 __sys_recvmmsg net/socket.c:3129 [inline]
 __do_sys_recvmmsg net/socket.c:3152 [inline]
 __se_sys_recvmmsg net/socket.c:3145 [inline]
 __x64_sys_recvmmsg+0x190/0x240 net/socket.c:3145
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x16e/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x44bd6d
Code: 28 c3 e8 d6 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe36d135148 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007fe36d135640 RCX: 000000000044bd6d
RDX: 0000000000000001 RSI: 00007fe36d135160 RDI: 0000000000000003
RBP: 00007fe36d1351b0 R08: 0000000000000000 R09: 00007fe36d1351a7
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe36d135640
R13: 0000000000000000 R14: 0000000000414d00 R15: 00007fe36c935000
 </TASK>
Allocated by task 9509:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x321/0x670 mm/slub.c:5415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 alloc_sk_msg net/core/skmsg.c:527 [inline]
 sk_psock_skb_ingress_self+0x5e/0x370 net/core/skmsg.c:629
 sk_psock_verdict_apply net/core/skmsg.c:1064 [inline]
 sk_psock_verdict_recv+0x7d9/0x8d0 net/core/skmsg.c:1262
 udp_read_skb+0x644/0x6e0 net/ipv4/udp.c:2014
 sk_psock_verdict_data_ready+0x25f/0x690 net/core/skmsg.c:1286
 __udp_enqueue_schedule_skb+0xc37/0x12c0 net/ipv4/udp.c:1745
 __udp_queue_rcv_skb net/ipv4/udp.c:2311 [inline]
 udp_queue_rcv_one_skb+0x755/0x1100 net/ipv4/udp.c:2402
 udp_unicast_rcv_skb+0x21a/0x3b0 net/ipv4/udp.c:2566
 udp_rcv+0xd8d/0x1d20 net/ipv4/udp.c:2643
 ip_protocol_deliver_rcu+0x282/0x440 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:241
 NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
 NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
 __netif_receive_skb_one_core net/core/dev.c:6202 [inline]
 __netif_receive_skb net/core/dev.c:6315 [inline]
 process_backlog+0xaa4/0x1960 net/core/dev.c:6666
 __napi_poll+0xae/0x340 net/core/dev.c:7730
 napi_poll net/core/dev.c:7793 [inline]
 net_rx_action+0x5d7/0xf50 net/core/dev.c:7950
 handle_softirqs+0x22b/0x850 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:912 [inline]
 __dev_queue_xmit+0x1ee0/0x3750 net/core/dev.c:4905
 neigh_output include/net/neighbour.h:556 [inline]
 ip_finish_output2+0xca9/0x1070 net/ipv4/ip_output.c:237
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0x29f/0x450 net/ipv4/ip_output.c:438
 ip_send_skb+0x45/0xc0 net/ipv4/ip_output.c:1508
 udp_send_skb+0x7e4/0xf70 net/ipv4/udp.c:1161
 udp_sendmsg+0x1864/0x2030 net/ipv4/udp.c:1443
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x554/0x680 net/socket.c:2265
 __do_sys_sendto net/socket.c:2272 [inline]
 __se_sys_sendto net/socket.c:2268 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x16e/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Freed by task 9509:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6246 [inline]
 kfree+0x1c7/0x650 mm/slub.c:6561
 kfree_sk_msg include/linux/skmsg.h:418 [inline]
 __sk_msg_recvmsg+0xe0b/0x1010 net/core/skmsg.c:493
 udp_bpf_recvmsg+0x17b/0xa90 net/ipv4/udp_bpf.c:83
 sock_recvmsg_nosec net/socket.c:1137 [inline]
 sock_recvmsg+0x155/0x1c0 net/socket.c:1159
 ____sys_recvmsg+0x1c9/0x460 net/socket.c:2918
 ___sys_recvmsg+0x1b5/0x510 net/socket.c:2960
 do_recvmmsg+0x307/0x770 net/socket.c:3055
 __sys_recvmmsg net/socket.c:3129 [inline]
 __do_sys_recvmmsg net/socket.c:3152 [inline]
 __se_sys_recvmmsg net/socket.c:3145 [inline]
 __x64_sys_recvmmsg+0x190/0x240 net/socket.c:3145
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x16e/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
The buggy address belongs to the object at ff110001294ee800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 40 bytes inside of
 freed 1024-byte region [ff110001294ee800, ff110001294eec00)
The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1294e8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000040 ff11000100038dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 017ff00000000040 ff11000100038dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 017ff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 9507, tgid 9507 (bash), ts 180790229591, free_ts 176526000771
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x23d/0x2a0 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x24be/0x2540 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x680 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x342/0x3d0 mm/slub.c:7251
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x323/0x730 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 __do_kmalloc_node mm/slub.c:5294 [inline]
 __kmalloc_noprof+0x473/0x770 mm/slub.c:5307
 kmalloc_noprof include/linux/slab.h:954 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 tomoyo_init_log+0x1a6e/0x1f70 security/tomoyo/audit.c:273
 tomoyo_supervisor+0x340/0x1480 security/tomoyo/common.c:2232
 tomoyo_audit_env_log security/tomoyo/environ.c:37 [inline]
 tomoyo_env_perm+0x149/0x1e0 security/tomoyo/environ.c:64
 tomoyo_environ security/tomoyo/domain.c:673 [inline]
 tomoyo_find_next_domain+0x15ce/0x1aa0 security/tomoyo/domain.c:889
 tomoyo_bprm_check_security+0x11c/0x180 security/tomoyo/tomoyo.c:102
 security_bprm_check+0x89/0x270 security/security.c:820
 search_binary_handler fs/exec.c:1654 [inline]
 exec_binprm fs/exec.c:1696 [inline]
 bprm_execve+0x885/0x1430 fs/exec.c:1748
 do_execveat_common+0x50e/0x690 fs/exec.c:1846
 __do_sys_execve fs/exec.c:1930 [inline]
 __se_sys_execve fs/exec.c:1924 [inline]
 __x64_sys_execve+0x97/0xc0 fs/exec.c:1924
page last free pid 9436 tgid 9436 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0xbdb/0xd50 mm/page_alloc.c:2943
 __slab_free+0x274/0x2c0 mm/slub.c:5608
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4569 [inline]
 slab_alloc_node mm/slub.c:4898 [inline]
 __kmalloc_cache_noprof+0x2bb/0x670 mm/slub.c:5410
 kmalloc_noprof include/linux/slab.h:950 [inline]
 tomoyo_print_header security/tomoyo/audit.c:156 [inline]
 tomoyo_init_log+0x183/0x1f70 security/tomoyo/audit.c:253
 tomoyo_supervisor+0x340/0x1480 security/tomoyo/common.c:2232
 tomoyo_audit_path_log security/tomoyo/file.c:169 [inline]
 tomoyo_path_permission+0x25a/0x380 security/tomoyo/file.c:592
 tomoyo_path_perm+0x392/0x4b0 security/tomoyo/file.c:843
 security_inode_getattr+0x12f/0x330 security/security.c:1895
 vfs_getattr fs/stat.c:259 [inline]
 vfs_fstat fs/stat.c:281 [inline]
 __do_sys_newfstat fs/stat.c:551 [inline]
 __se_sys_newfstat fs/stat.c:546 [inline]
 __x64_sys_newfstat+0xfc/0x200 fs/stat.c:546
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x16e/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Memory state around the buggy address:
 ff110001294ee700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ff110001294ee780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ff110001294ee800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ff110001294ee880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ff110001294ee900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
