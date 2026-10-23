Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792734428;
	b=ku4RPirPQrHzrsotXTA2SeeJl9a1zokZdzNzuMyhGbtANn6MaaqIlCjy575cCt4ks8Nu
	 Wr49mpex2Fl6xZFmuRAffSOHOEhThNzLlIMJbdN9040E+g06j2fCsyPB17tXBK2s4zm/Q
	 QBvVHG9PToqFlKFlyaucf3ccO/Da3iBnqFWPKmwBEJYsfUBWa2VJncM1LVYZmREvCeWkW
	 5rqcScGNgIfAFfQLv9POE7VlXU++b/33FGQ1vCi+SSfTqJIP8c27xtq2cHmQ912pC9BmK
	 33JLhx5PP8qKmKvrjNWGgJjrbW4fvmRkBviBBMl0vZHKl2/kH6A4bXbxiOSKxBCCC4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792734428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zNK+CBNyfpDVKkV4YXxiogNMmZyhunQAxrs8le/yzsU=;
	b=iJATESM3bSzRHwssyBnQ5nyqoZOJPOani3mdeeIWFBo75yQAM9ZAkln+X4GJAZ1V4/iy
	 /fHuvVJnqYoIPsqp+YUeyhoZU2nU9hgPQMCKz+C3wniWfCxL/sxU5rBe15TvG+nbxCFCy
	 bwb7rKCWWibe0BECJoTIdR3P4wU2LWu1hyiudpKOruyRUaYEkw6KoafsFWq4ofdn8bYl3
	 5CePKCLgxC1SNVb4kX8LN7vcZKAfGjvrQVVBaErLKfOq9KO/ouQs15kpqX2mMeVt2LUgK
	 4PvgSKgXiTxSVA+2e8bR0tCHVTzPr/YeCSCUEdKjb/MIzLGlXPB8uh6fk70liIXyuSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=h69QaGax;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497DD606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 05:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 497DD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=h69QaGax
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso388659eec.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792734426; x=1793339226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNK+CBNyfpDVKkV4YXxiogNMmZyhunQAxrs8le/yzsU=;
        b=h69QaGaxG22W/SPO8VpRQDfs8kSjJ48Z2fzJyexXSJU8KordG0o+1IB70SxSObzUZB
         mqWBp911baXt0/z0gf3YI2YOtN/kSiXskmBBaKsX6Kylh37vKtSVhCPF2/AqcWyoDk9E
         J2OS8PBYScSGDfp+glnqap7Lu6LKmz8ehrlo+ktNAOsE/3TqCLaplXnxuYE05iWasKTJ
         y0JEdP8KoA4QlkPBCoyfK2ZRW+iXaF/OuaEHGnf/tLcfZ+Bz62cVtcAM7TKIpQsOOPir
         /EwH3/D6U32NKgNZJSPauPrweaN+laTOlHKb2XsjE3g/mnL5k14SBcIA5qVQG4Hf+0Kt
         tuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792734426; x=1793339226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNK+CBNyfpDVKkV4YXxiogNMmZyhunQAxrs8le/yzsU=;
        b=onGUL7pt7bjMApXC8XeWrX4FpebHop4GEAe8jXxHFZBP97/RzcTwoAyBWksQARXl3c
         H18qlxQAcpbhGEkonMbNwigKzzzjzjC4Ry4ohVBENAOmQUKChzP0L28LALq8u3SAeFlF
         VDLffvof7BXDdFuEga3YkzQv9GOK2RX34x5hFU36oXw079nYDRCSCOrgDzFTJIENU6v/
         y+iGUFgi/sA89JGtuqZL0hrA5Q4iwbud3mdTzOB7i/P6UH5zO2wn61QsZGUVdYRQn7R3
         z4t6+OHBitBdy4E709w9lDrulYsVA3GMU8dKflo8aEA3akYGIu9TomFPfGxTPtWlQBzY
         tE3w==
X-Forwarded-Encrypted: i=1; AKwUvBwIhxCAblDL+VDEZAgsx1RknjkA1pTQYMBYOdq3NT51uPfQQKKhqsOTPdivvMWxhJx/Aso=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIjQY/lgSf/lWFDF93DkfCZGRdpbgP6EgtFqqoAgR93pHash1c
	3xjhdy5g4IThrjzfHiWH4dTGSD9a0TCi1GdotUVTQqhqFognlswG5b4XlQPVpUMLwzcS
X-Gm-Gg: AYBFou3JSRCFq99LY8LHQJbPc4QMkIqmZETFRVGJi1SeB1J1rW00CzC3mmnj7C9cg8b
	s7mfNlyA7shL7z24yqflCoRXrXvISjaaFJY8QnPk90iy04P1aa7iy3YojmTMAF8uaNnhnhqhth7
	y5fNd2Tz+va+BBgqRB7JAOiR7T4mtAN4xgFFTPZYIxm0k4OYzPAYi6qVQ6etmwS9BcwDQpIDwkk
	Wq7Ji1bS/+ZUh/dPR7rqo46yg91UdnaLdN2RDsMrwWLn/vE34yWI86IN0qtm5GYSwcl/zaDh76d
	gWH2xXueBeEc87xRjkGvOK2Uq5P6og/mvOYWz3pl9VrYkP5QJCXkLLcWiGM5dGZhJDm3ij42AM/
	iqHuHSe78DVAjJsdWUFdEEFwZHrQgZxZ65h6Y06PjR+gMPtFpg4l0mLRfEGA2DNK+Z+bI7KXFkl
	jTG1vAYgcDjAzAdAS8vZ1h58JHxwAIUy0uPlxkUNyS32HozeA+42RRKnWVoUqgFNn3i6frOun/A
	HZxaSZdzYpAZXwUuAFFsRzizTzA5IzJAVRGS1+bDNYnRcs7raczlDQmRgP+ZnRWSsWFaHs=
X-Received: by 2002:a05:693c:87c4:10b0:360:dfac:6817 with SMTP id 5a478bee46e88-369d976cae3mr1813552eec.18.1792734426078;
        Thu, 22 Oct 2026 22:47:06 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9d8978csm6252135eec.13.2026.10.22.22.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:47:05 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] tcp_bpf: sync copied_seq after pre-accept data
Date: Fri, 23 Oct 2026 13:46:50 +0800
Message-ID: <cover.1792733621.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
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

We found and validated a receive-sequence state bug in
net/ipv4/tcp_bpf.c. A process with the capabilities required to create a
sockmap and load SK_SKB programs can trigger it by attaching a drop
verdict to an accepted TCP socket that already has unread data.

We will provide details of the bug below, along with a PoC and the
QEMU crash log.

---- details below ----

Bug details:

When tcp_bpf_recvmsg_parser() finds data queued before accept(), it
saves tcp->copied_seq and then calls tcp_data_ready() to process that
queue through the sockmap path. A verdict that drops or redirects data
can advance tcp->copied_seq while consuming the skb. The parser later
reconstructs the sequence from its earlier snapshot plus only the bytes
copied to its local ingress queue, then writes that stale value back.
This rewinds copied_seq past data already consumed by the verdict.

The PoC sends data before accept(), attaches a sockmap drop verdict,
then reads and removes the socket from the map. A subsequent ordinary
TCP recv() encounters copied_seq behind the next queued skb and triggers
the TCP receive sequence warning (panic_on_warn is enabled in the test
QEMU guest). The control case, where the first data arrives after
accept(), receives the later data normally.

Refresh the local sequence from tcp->copied_seq after tcp_data_ready()
processes the pre-accept queue, so progress made by the sockmap path is
preserved, including when the queue cannot be fully drained.

Reproducer:

    make
    ./poc

Run as root in a QEMU guest with BPF sockmap support enabled. The PoC
uses a raw BPF syscall and requires the capabilities needed for
BPF_MAP_TYPE_SOCKMAP and BPF_PROG_TYPE_SK_SKB.

The panic was reproduced on Linux 6.12.95 with CONFIG_BPF,
CONFIG_BPF_SYSCALL, CONFIG_NET_SOCK_MSG, CONFIG_INET,
CONFIG_BPF_STREAM_PARSER, and KASAN enabled.

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/bpf.h>
#include <linux/tcp.h>
#include <netinet/in.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#ifndef SOL_TCP
#define SOL_TCP IPPROTO_TCP
#endif

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

#define BPF_INSN(CODE, DST, SRC, OFF, IMM) \
	((struct bpf_insn){ .code = (CODE), .dst_reg = (DST), .src_reg = (SRC), .off = (OFF), .imm = (IMM) })
#define BPF_MOV64_IMM(DST, IMM) BPF_INSN(BPF_ALU64 | BPF_MOV | BPF_K, DST, 0, 0, IMM)
#define BPF_LDX_MEM(SIZE, DST, SRC, OFF) BPF_INSN(BPF_LDX | BPF_MEM | SIZE, DST, SRC, OFF, 0)
#define BPF_EXIT_INSN() BPF_INSN(BPF_JMP | BPF_EXIT, 0, 0, 0, 0)

struct bpf_objects {
	int map_fd;
	int verdict_fd;
};

struct scenario_result {
	const char *name;
	int first_recv_ret;
	int first_recv_errno;
	int post_delete_recv_ret;
	int post_delete_recv_errno;
	int post_delete_fionread;
	uint64_t bytes_received_before;
	uint64_t bytes_received_after;
	char post_delete_data[64];
	bool blackhole;
};

static int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr)
{
	return syscall(__NR_bpf, cmd, attr, sizeof(*attr));
}

static void fatal_errno(const char *what)
{
	fprintf(stderr, "%s: %s\n", what, strerror(errno));
	exit(EXIT_FAILURE);
}

static void fatal_msg(const char *what)
{
	fprintf(stderr, "%s\n", what);
	exit(EXIT_FAILURE);
}

static int create_sockmap(void)
{
	union bpf_attr attr = {
		.map_type = BPF_MAP_TYPE_SOCKMAP,
		.key_size = sizeof(uint32_t),
		.value_size = sizeof(uint64_t),
		.max_entries = 1,
	};
	int fd = sys_bpf(BPF_MAP_CREATE, &attr);

	if (fd < 0)
		fatal_errno("BPF_MAP_CREATE(sockmap)");
	return fd;
}

static int load_sk_skb_prog(const struct bpf_insn *insns, size_t cnt,
			    enum bpf_attach_type attach_type)
{
	char log_buf[65536];
	union bpf_attr attr = {
		.prog_type = BPF_PROG_TYPE_SK_SKB,
		.insn_cnt = cnt,
		.insns = (uint64_t)(uintptr_t)insns,
		.license = (uint64_t)(uintptr_t)"GPL",
		.log_buf = (uint64_t)(uintptr_t)log_buf,
		.log_size = sizeof(log_buf),
		.log_level = 2,
		.expected_attach_type = attach_type,
	};
	int fd;

	memset(log_buf, 0, sizeof(log_buf));
	fd = sys_bpf(BPF_PROG_LOAD, &attr);
	if (fd < 0) {
		fprintf(stderr, "BPF_PROG_LOAD(%d) failed: %s\nVerifier log:\n%s\n",
			attach_type, strerror(errno), log_buf);
		exit(EXIT_FAILURE);
	}
	return fd;
}

static void attach_prog(int map_fd, int prog_fd, enum bpf_attach_type attach_type)
{
	union bpf_attr attr = {
		.target_fd = map_fd,
		.attach_bpf_fd = prog_fd,
		.attach_type = attach_type,
	};

	if (sys_bpf(BPF_PROG_ATTACH, &attr) < 0)
		fatal_errno("BPF_PROG_ATTACH");
}

static void map_update_sock(int map_fd, uint32_t key, int sock_fd)
{
	uint64_t value = (uint64_t)sock_fd;
	union bpf_attr attr = {
		.map_fd = map_fd,
		.key = (uint64_t)(uintptr_t)&key,
		.value = (uint64_t)(uintptr_t)&value,
		.flags = BPF_ANY,
	};

	if (sys_bpf(BPF_MAP_UPDATE_ELEM, &attr) < 0)
		fatal_errno("BPF_MAP_UPDATE_ELEM(sock)");
}

static void map_delete_key(int map_fd, uint32_t key)
{
	union bpf_attr attr = {
		.map_fd = map_fd,
		.key = (uint64_t)(uintptr_t)&key,
	};

	if (sys_bpf(BPF_MAP_DELETE_ELEM, &attr) < 0)
		fatal_errno("BPF_MAP_DELETE_ELEM(sock)");
}

static uint64_t get_bytes_received(int fd)
{
	struct tcp_info info;
	socklen_t len = sizeof(info);

	memset(&info, 0, sizeof(info));
	if (getsockopt(fd, SOL_TCP, TCP_INFO, &info, &len) < 0)
		fatal_errno("getsockopt(TCP_INFO)");
	return info.tcpi_bytes_received;
}

static int get_fionread(int fd)
{
	int avail = -1;

	if (ioctl(fd, FIONREAD, &avail) < 0)
		fatal_errno("ioctl(FIONREAD)");
	return avail;
}

static void set_nonblock(int fd)
{
	int flags = fcntl(fd, F_GETFL, 0);

	if (flags < 0)
		fatal_errno("fcntl(F_GETFL)");
	if (fcntl(fd, F_SETFL, flags | O_NONBLOCK) < 0)
		fatal_errno("fcntl(F_SETFL)");
}

static void send_all(int fd, const void *buf, size_t len)
{
	const char *p = buf;

	while (len) {
		ssize_t ret = send(fd, p, len, 0);

		if (ret < 0) {
			if (errno == EINTR)
				continue;
			fatal_errno("send");
		}
		p += ret;
		len -= (size_t)ret;
	}
}

static void close_fd(int *fd)
{
	if (*fd >= 0) {
		close(*fd);
		*fd = -1;
	}
}

static void bind_and_listen(int fd, struct sockaddr_in *addr)
{
	int one = 1;

	memset(addr, 0, sizeof(*addr));
	addr->sin_family = AF_INET;
	addr->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
	addr->sin_port = 0;

	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)) < 0)
		fatal_errno("setsockopt(SO_REUSEADDR)");
	if (bind(fd, (struct sockaddr *)addr, sizeof(*addr)) < 0)
		fatal_errno("bind");
	if (listen(fd, 1) < 0)
		fatal_errno("listen");
}

static void fill_bound_addr(int fd, struct sockaddr_in *addr)
{
	socklen_t len = sizeof(*addr);

	if (getsockname(fd, (struct sockaddr *)addr, &len) < 0)
		fatal_errno("getsockname");
}

static bool wait_for_bytes_received(int fd, uint64_t want, int timeout_ms)
{
	struct timespec ts = {
		.tv_sec = 0,
		.tv_nsec = 20 * 1000 * 1000,
	};
	int elapsed = 0;

	while (elapsed <= timeout_ms) {
		if (get_bytes_received(fd) >= want)
			return true;
		nanosleep(&ts, NULL);
		elapsed += 20;
	}
	return false;
}

static void reset_result(struct scenario_result *res, const char *name)
{
	memset(res, 0, sizeof(*res));
	res->name = name;
	res->first_recv_ret = -2;
	res->post_delete_recv_ret = -2;
	res->first_recv_errno = 0;
	res->post_delete_recv_errno = 0;
}

static void run_scenario(const struct bpf_objects *objs, bool send_before_accept,
			 struct scenario_result *res)
{
	static const char first_msg[] = "FIRST";
	static const char second_msg[] = "SECOND";
	struct sockaddr_in addr;
	uint32_t key = 0;
	int listen_fd = -1, client_fd = -1, child_fd = -1;
	uint64_t want_after;
	char buf[64];
	ssize_t ret;

	reset_result(res, send_before_accept ? "trigger" : "control");

	listen_fd = socket(AF_INET, SOCK_STREAM, 0);
	if (listen_fd < 0)
		fatal_errno("socket(listen)");
	bind_and_listen(listen_fd, &addr);
	fill_bound_addr(listen_fd, &addr);

	client_fd = socket(AF_INET, SOCK_STREAM, 0);
	if (client_fd < 0)
		fatal_errno("socket(client)");
	if (connect(client_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		fatal_errno("connect");

	if (send_before_accept) {
		send_all(client_fd, first_msg, sizeof(first_msg) - 1);
		usleep(100000);
	}

	child_fd = accept(listen_fd, NULL, NULL);
	if (child_fd < 0)
		fatal_errno("accept");
	set_nonblock(child_fd);

	map_update_sock(objs->map_fd, key, child_fd);

	if (!send_before_accept) {
		send_all(client_fd, first_msg, sizeof(first_msg) - 1);
		usleep(100000);
	}

	errno = 0;
	ret = recv(child_fd, buf, sizeof(buf), MSG_DONTWAIT);
	res->first_recv_ret = (int)ret;
	res->first_recv_errno = ret < 0 ? errno : 0;

	map_delete_key(objs->map_fd, key);

	res->bytes_received_before = get_bytes_received(child_fd);
	send_all(client_fd, second_msg, sizeof(second_msg) - 1);
	want_after = res->bytes_received_before + (sizeof(second_msg) - 1);
	if (!wait_for_bytes_received(child_fd, want_after, 1000))
		fatal_msg("timed out waiting for TCP_INFO.tcpi_bytes_received to advance");
	res->bytes_received_after = get_bytes_received(child_fd);
	res->post_delete_fionread = get_fionread(child_fd);

	memset(res->post_delete_data, 0, sizeof(res->post_delete_data));
	errno = 0;
	ret = recv(child_fd, res->post_delete_data, sizeof(res->post_delete_data) - 1,
		   MSG_DONTWAIT);
	res->post_delete_recv_ret = (int)ret;
	res->post_delete_recv_errno = ret < 0 ? errno : 0;
	if (ret >= 0)
		res->post_delete_data[ret] = '\0';

	res->blackhole =
		res->bytes_received_after >= want_after &&
		res->post_delete_fionread == 0 &&
		res->post_delete_recv_ret < 0 &&
		res->post_delete_recv_errno == EAGAIN;

	close_fd(&child_fd);
	close_fd(&client_fd);
	close_fd(&listen_fd);
}

static void print_result(const struct scenario_result *res)
{
	printf("[%s] first recv ret=%d errno=%d (%s)\n",
	       res->name,
	       res->first_recv_ret,
	       res->first_recv_errno,
	       res->first_recv_errno ? strerror(res->first_recv_errno) : "none");
	printf("[%s] post-delete bytes_received delta=%llu\n",
	       res->name,
	       (unsigned long long)(res->bytes_received_after - res->bytes_received_before));
	printf("[%s] post-delete FIONREAD=%d recv ret=%d errno=%d (%s) data=\"%s\"\n",
	       res->name,
	       res->post_delete_fionread,
	       res->post_delete_recv_ret,
	       res->post_delete_recv_errno,
	       res->post_delete_recv_errno ? strerror(res->post_delete_recv_errno) : "none",
	       res->post_delete_recv_ret >= 0 ? res->post_delete_data : "");
}

static struct bpf_objects setup_bpf_objects(void)
{
	static const struct bpf_insn verdict_prog[] = {
		BPF_MOV64_IMM(BPF_REG_0, SK_DROP),
		BPF_EXIT_INSN(),
	};
	struct bpf_objects objs;

	memset(&objs, 0, sizeof(objs));
	objs.map_fd = create_sockmap();
	objs.verdict_fd = load_sk_skb_prog(verdict_prog, ARRAY_SIZE(verdict_prog),
					   BPF_SK_SKB_STREAM_VERDICT);
	attach_prog(objs.map_fd, objs.verdict_fd, BPF_SK_SKB_STREAM_VERDICT);
	return objs;
}

static void destroy_bpf_objects(struct bpf_objects *objs)
{
	close_fd(&objs->verdict_fd);
	close_fd(&objs->map_fd);
}

int main(void)
{
	struct scenario_result control, trigger;
	struct bpf_objects objs;

	setvbuf(stdout, NULL, _IONBF, 0);

	if (geteuid() != 0)
		fatal_msg("run this PoC as root");

	objs = setup_bpf_objects();

	run_scenario(&objs, false, &control);
	run_scenario(&objs, true, &trigger);

	print_result(&control);
	print_result(&trigger);

	if (!(control.post_delete_recv_ret == (int)(sizeof("SECOND") - 1) &&
	      strcmp(control.post_delete_data, "SECOND") == 0))
		fatal_msg("control scenario did not recover after sockmap teardown");

	if (!trigger.blackhole)
		fatal_msg("trigger scenario did not show the expected receive blackhole");

	printf("BUG OBSERVED: pre-accept dropped data rewound copied_seq; after sockmap teardown, later bytes were counted by TCP but remained unreadable.\n");

	destroy_bpf_objects(&objs);
	return 0;
}

------END poc.c--------

------BEGIN Makefile------

CC ?= gcc
CFLAGS ?= -O2 -Wall -Wextra

all: poc

poc: poc.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f poc

------END Makefile--------

----BEGIN crash log----

[  248.655684][T10461] Kernel panic - not syncing: kernel: panic_on_warn set ...
[  248.656860][T10461] CPU: 1 UID: 0 PID: 10461 Comm: poc Not tainted 6.12.95 #2
[  248.657895][T10461] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  248.659562][T10461] Call Trace:
[  248.660062][T10461]  <TASK>
[  248.660576][T10461]  panic+0x533/0x610
[  248.661158][T10461]  ? __pfx_panic+0x10/0x10
[  248.661879][T10461]  ? tcp_recvmsg_locked+0x495/0x2220
[  248.662633][T10461]  check_panic_on_warn+0x61/0x80
[  248.663324][T10461]  __warn+0xdf/0x2e0
[  248.663899][T10461]  ? tcp_recvmsg_locked+0x495/0x2220
[  248.664655][T10461]  report_bug+0x308/0x3d0
[  248.665324][T10461]  handle_bug+0x111/0x150
[  248.665955][T10461]  exc_invalid_op+0x17/0x50
[  248.666605][T10461]  asm_exc_invalid_op+0x1a/0x20
[  248.667274][T10461] RIP: 0010:tcp_recvmsg_locked+0x495/0x2220
[  248.668115][T10461] Code: 03 0f b6 04 28 84 c0 74 08 3c 03 0f 8e 14 1a 00 00 41 8b 8f b0 09 00 00 48 c7 c7 00 e9 b8 8b 44 8b 44 24 08 e8 7c 50 6d f8 90 <0f> 0b 90 90 8b 4c 24 10 39 4c 24 0c 7c 32 49 8d bf 50 01 00 00 48
[  248.670939][T10461] RSP: 0018:ffffc90013edfa00 EFLAGS: 00010282
[  248.671812][T10461] RAX: 0000000000000000 RBX: ffff88807eacc3e8 RCX: 0000000000000000
[  248.672908][T10461] RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
[  248.674007][T10461] RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffed1023155181
[  248.675107][T10461] R10: ffff888118aa8c0b R11: ffffc90013edf778 R12: 0000000054ce5d8a
[  248.676210][T10461] R13: ffff88810b72d890 R14: ffffed10216e5b12 R15: ffff88810b72cfc0
[  248.677444][T10461]  ? __pfx_tcp_recvmsg_locked+0x10/0x10
[  248.678275][T10461]  ? srso_alias_return_thunk+0x5/0xfbef5
[  248.679073][T10461]  ? tcp_recvmsg+0xe4/0x540
[  248.679745][T10461]  ? __local_bh_enable_ip+0xa7/0x120
[  248.680587][T10461]  tcp_recvmsg+0xfd/0x540
[  248.681198][T10461]  ? srso_alias_return_thunk+0x5/0xfbef5
[  248.681999][T10461]  ? __pfx_tcp_recvmsg+0x10/0x10
[  248.682724][T10461]  ? __pfx___might_resched+0x10/0x10
[  248.683532][T10461]  ? srso_alias_return_thunk+0x5/0xfbef5
[  248.684309][T10461]  ? aa_sk_perm+0x1d8/0x8d0
[  248.684970][T10461]  inet_recvmsg+0x109/0x510
[  248.685649][T10461]  ? __pfx_inet_recvmsg+0x10/0x10
[  248.686347][T10461]  ? tomoyo_path_number_perm+0x262/0x4f0
[  248.687197][T10461]  ? __pfx_inet_recvmsg+0x10/0x10
[  248.687940][T10461]  sock_recvmsg+0x148/0x190
[  248.688591][T10461]  ? srso_alias_return_thunk+0x5/0xfbef5
[  248.689381][T10461]  __sys_recvfrom+0x1a1/0x2a0
[  248.690072][T10461]  ? __pfx___sys_recvfrom+0x10/0x10
[  248.690961][T10461]  __x64_sys_recvfrom+0xe0/0x1c0
[  248.691678][T10461]  ? do_syscall_64+0x93/0x270
[  248.692337][T10461]  ? srso_alias_return_thunk+0x5/0xfbef5
[  248.693131][T10461]  ? lockdep_hardirqs_on+0x7b/0x110
[  248.693884][T10461]  do_syscall_64+0xc7/0x270
[  248.694549][T10461]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  248.695373][T10461] RIP: 0033:0x7fd9e0884687
[  248.696018][T10461] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  248.698625][T10461] RSP: 002b:00007ffdd9906f00 EFLAGS: 00000202 ORIG_RAX: 000000000000002d
[  248.699774][T10461] RAX: ffffffffffffffda RBX: 00007fd9e07f2740 RCX: 00007fd9e0884687
[  248.701070][T10461] RDX: 000000000000003f RSI: 00007ffdd9907290 RDI: 0000000000000007
[  248.702298][T10461] RBP: 0000000000000033 R08: 0000000000000000 R09: 0000000000000000
[  248.703404][T10461] R10: 0000000000000040 R11: 0000000000000202 R12: 00007ffdd9907260
[  248.704486][T10461] R13: 0000000000000007 R14: 000000000000000b R15: 00007ffdd9906f90
[  248.705651][T10461]  </TASK>
[  248.707447][T10461] Kernel Offset: disabled
[  248.708136][T10461] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  tcp_bpf: sync copied_seq after pre-accept data

 net/ipv4/tcp_bpf.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.55.0
