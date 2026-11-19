Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098510;
	b=QD9dUPzivGiXrTgWoL+3LkRJRg7o1LLGEwQwDqo6/bSjI9cDb1/ccFMNVU3wTtuqAwK1
	 COalRnUwWSp85BbqLXSOn1djcWzQEA3IZeJu7npxicDFnOsM1n4K36IHNf1UUnsBQIhwx
	 FMKSPzSaHuZvVRhgFECN+rgm85Mk0TIJlccREEwhZjB82YVyxlRGReG1s34n5/kOAtFuV
	 qgi+4lLeQdRJ0hy1d7f5Mqqpr/cj4JgO53FoJvNTHw7weoJONFmDwv5LA58sD+KjX/L1Y
	 RsvdeF6/mFOtIMlFSE0e7h5WbE+szbIeiOUk7aro3eVBCZTLNL+CmugMzDC3uEQVvkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qOToLkQMO4FrpWnJEkX03w+5cMe3PRHAU63SY4eysRw=;
	b=b5+HDwwbLc5eFm4Eb8nLXy6bcXQZwTM19KVUmAipo/3oPZ5Bo7oB83YtgyykTBmFBYO8
	 m/VvfKSRCXGuSkRLqejD70vR5yj4trXCcM9l0Z4rWRTUewNShlS0jlYfMEtLfQplEPFyN
	 9LDkdq/T5SUcj+OVCnIrox8ZxO8WsZB1XrqsRDWmJvmtSYAsmO19QhIn6hJW0KxbuDaMT
	 pDMLBR5QVCRSu4b558sT1RwyH0QgP02kqfl0p/vq1HFNmF1IOTNqRmDUutCNdVw5c2TFc
	 TEKpd8N7icy2ByOmDGKxGOm3Sb7V33Xgqe9L8W2QgQHyZzwepElDV2ryn84ffgB/Tlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=LPPxLzc8;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9347606A324
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9347606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=LPPxLzc8
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so18197695e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795098508; x=1795703308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qOToLkQMO4FrpWnJEkX03w+5cMe3PRHAU63SY4eysRw=;
        b=LPPxLzc8xknyeU4XpWB/tCUOYssCrTydZ1+sHxjOUzttqVoQyA816JWyn24FjmX8Gg
         FieFwM1B7U1NpClT4e00NzXcY94hUkPJhEWnnrOF9RbsXddQm4djqZHtkMHxkjzkKx7w
         msGaXbUuDT6UCttCBcam3xh5IMt37Ors0JkrAUxA/D2v7UE7/HJJlyfohIPumvjTVPpp
         p+l/ltCk0e9ofxX1CMYPO8446ZBi+Hb1Z3KN9uvLG4oTl1UchigY7ocCuNi7r0W8+hKO
         9gRja5+Tff21mwCh4wxEtfS8Zj/1lQV9UGO5gWjVo3px9PxCTuK5QHZkSn1wMSSD19L/
         kynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098508; x=1795703308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qOToLkQMO4FrpWnJEkX03w+5cMe3PRHAU63SY4eysRw=;
        b=NuqCezJcsPBwr0eWu6m22eSxbuUmvHjDqnorakKue4sMg1C96Vy4ZiRtA7zqZ3jBme
         vIac6yNU+nu52X53MNn+ezmFpl0GPxdZP/MWChBAWTBFih6KLNxuqZ8Gj7d4taGHOo27
         GBKE/e0npdnGbLHbjJbBoxGi/Jg3wG3uMHcdGCrClL/vaLgdbUWrkKYzrHiqKNbE9NHc
         AtstgQGD6srdXb9csF5vVCf0a6nndQscIUprVxZl6HXjJSHWxymBf9/zBCYZ8yAr1ItC
         yUM6lwrqNE0V8sCI65CkEylXcxLR7w9BkphJrK+w2eNTsJbd0VDyxY7PjMkb9wRED3PE
         rvjw==
X-Gm-Message-State: APuU4Z/ZJgAARTSsSh51M4jqUVqN/BigAe1Ta/CqkFUHMmA1sEChWxQz
	mGV2mYitot9b6vmDysJMkYoADkyivUXZD25HuMNx0VE2sRNqJ5JS0nW+QQ+0yPf/W+8w81VcR9q
	l9p7ZIodAHR72
X-Gm-Gg: AYBFou23ZN0Tw3GgG+qFJUi9C8vtQF5IZEkhJrZqWTrIGVbxW3SHF/rkdPXYar3Ge8Q
	lt7r6hMgs2x4lWw2NgTMInofrumn1cX8ZAvS/0DtR1swjd1IVbJKj5Ir4GPOQCCm6V+KoMnsRGA
	cBrFRKquGntaGG+7CVQdyqzkVQYKuC/f4bGY8Mv4fksJUd1dg7adPDDkvif+NG0Y21e9DzYIxDR
	MgRITF5mnNSLT9DV41z3M6PTDJwkS7ED/6Z0seAB39+S5GwbazF+D9/rU08zulsgOTMt7Sp3joN
	/kiQcKcQvHXEC5/jEn+RVCWRyZm4urwZvXJLIZnKdjlb4IGaCXEBqbTwmpjdl9N4ueVXsnmnkfM
	qmEg0p4OvnpYma+x9CllieF+JpOGS5YC6OCDpmq6tYmGQyba6ODVWXSKU421bnobOsPVl04TWI9
	tPO7erYCuFtk1ojn+2C4d1iGAQvdzGEZeFkxRCByqK1gTPuY3FMNZWYjkRQY5XJhW8mx39AhPmf
	SHlgWarG2RWMGdzq5Z2FMYhfgvUeBktpUhs87T7Zj+i+Ik7z9BRZpIEx//O/Bq3H+MVgFcTzrkY
	3gj/sbt5ZY00ypnjbAv+fTigzHLqA1XSdEU6TUCQHrhI4bJQyjrqNC8WvH4DXyOsTJScZqoi
X-Received: by 2002:a05:600c:4ecf:b0:4bb:5345:606b with SMTP id 5b1f17b1804b1-4bb7da39144mr124257845e9.31.1795098508053;
        Thu, 19 Nov 2026 06:28:28 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab55e241f9sm101257f8f.52.2026.11.19.06.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:28:27 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
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
	Paul Chaignon <paul@isovalent.com>,
	Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>
Subject: [PATCH bpf-next 7/8] selftests/bpf: Exercise netkit socket assignment to a host proxy
Date: Thu, 19 Nov 2026 16:22:29 +0200
Message-ID: <20261119142231.2612515-8-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119142231.2612515-1-razor@blackwall.org>
References: <20261119142231.2612515-1-razor@blackwall.org>
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

Test IPv4/IPv6 TCP assignment from a netkit peer to transparent host
listeners, preserving original destinations and bidirectional payloads.
Cover established sockets and request/time-wait rejection.

Honor rtnetlink error suppression to skip unavailable netkit support.
Detach before final counter checks while the listener remains open.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>
CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC: Martin KaFai Lau <martin.lau@linux.dev>
CC: Song Liu <song@kernel.org>
CC: Yonghong Song <yonghong.song@linux.dev>
CC: Jiri Olsa <jolsa@kernel.org>
CC: Emil Tsalapatis <emil@etsalapatis.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>
CC: Paul Chaignon <paul@isovalent.com>
CC: Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>

 tools/testing/selftests/bpf/netlink_helpers.c |   3 +-
 .../bpf/prog_tests/sk_assign_netkit.c         | 304 ++++++++++++++++++
 .../selftests/bpf/progs/sk_assign_netkit.c    | 137 ++++++++
 3 files changed, 443 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_assign_netkit.c

diff --git a/tools/testing/selftests/bpf/netlink_helpers.c b/tools/testing/selftests/bpf/netlink_helpers.c
index caf36eb1d032..c9488ba5606e 100644
--- a/tools/testing/selftests/bpf/netlink_helpers.c
+++ b/tools/testing/selftests/bpf/netlink_helpers.c
@@ -276,7 +276,8 @@ static int __rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n,
 int rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n,
 	      struct nlmsghdr **answer)
 {
-	return __rtnl_talk(rtnl, n, answer, true, NULL);
+	return __rtnl_talk(rtnl, n, answer,
+			   !(rtnl->flags & RTNL_HANDLE_F_SUPPRESS_NLERR), NULL);
 }
 
 int addattr(struct nlmsghdr *n, int maxlen, int type)
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c b/tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c
new file mode 100644
index 000000000000..eb2dd03b923e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <net/if.h>
+#include <netinet/tcp.h>
+#include <uapi/linux/if_link.h>
+#include <test_progs.h>
+#include "netlink_helpers.h"
+#include "network_helpers.h"
+#include "sk_assign_netkit.skel.h"
+
+#define NS_HOST "sk_assign_host"
+#define NS_POD "sk_assign_pod"
+#define HOST_DEV "nk_host"
+#define POD_DEV "nk_pod"
+#define DEST_PORT 18080
+#define PROXY_PORT 15001
+#define TEST_DATA "test"
+#define TEST_ITERATIONS 8
+#define IO_TIMEOUT_MS 1000
+#define POLL_RETRIES 5000
+#define POLL_INTERVAL_US 1000
+
+struct netkit_request {
+	struct nlmsghdr n;
+	struct ifinfomsg i;
+	char buf[1024];
+};
+
+static int create_netkit(void)
+{
+	struct rtattr *linkinfo, *data, *peer_info;
+	struct rtnl_handle rth = { .fd = -1 };
+	struct netkit_request req = {};
+	int err;
+
+	err = rtnl_open(&rth, 0);
+	if (err)
+		return err;
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	req.n.nlmsg_type = RTM_NEWLINK;
+	req.i.ifi_family = AF_UNSPEC;
+	addattrstrz(&req.n, sizeof(req), IFLA_IFNAME, HOST_DEV);
+	linkinfo = addattr_nest(&req.n, sizeof(req), IFLA_LINKINFO);
+	addattrstrz(&req.n, sizeof(req), IFLA_INFO_KIND, "netkit");
+	data = addattr_nest(&req.n, sizeof(req), IFLA_INFO_DATA);
+	addattr32(&req.n, sizeof(req), IFLA_NETKIT_MODE, NETKIT_L2);
+	peer_info = addattr_nest(&req.n, sizeof(req), IFLA_NETKIT_PEER_INFO);
+	req.n.nlmsg_len += sizeof(struct ifinfomsg);
+	addattrstrz(&req.n, sizeof(req), IFLA_IFNAME, POD_DEV);
+	addattr_nest_end(&req.n, peer_info);
+	addattr_nest_end(&req.n, data);
+	addattr_nest_end(&req.n, linkinfo);
+	rth.flags |= RTNL_HANDLE_F_SUPPRESS_NLERR;
+	err = rtnl_talk(&rth, &req.n, NULL);
+	if (err)
+		err = -errno;
+	rtnl_close(&rth);
+	return err;
+}
+
+static int transparent_socket(int fd, void *opts)
+{
+	int family = *(int *)opts;
+	int one = 1;
+
+	if (family == AF_INET6) {
+		if (setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &one, sizeof(one)))
+			return -1;
+		return setsockopt(fd, IPPROTO_IPV6, IPV6_TRANSPARENT, &one,
+				  sizeof(one));
+	}
+	return setsockopt(fd, SOL_IP, IP_TRANSPARENT, &one, sizeof(one));
+}
+
+static void check_timewait(struct sk_assign_netkit *skel, int family,
+			   int accepted, int client)
+{
+	struct __sk_buff ctx = { .ifindex = if_nametoindex(HOST_DEV) };
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.ctx_in = &ctx,
+		.ctx_size_in = sizeof(ctx),
+	);
+	struct sockaddr_storage local, peer;
+	socklen_t len = sizeof(local);
+	struct sockaddr_in6 *l6, *p6;
+	struct sockaddr_in *l4, *p4;
+	int i, fd;
+	char buf;
+
+	if (!ASSERT_OK(getsockname(accepted, (void *)&local, &len),
+		       "timewait_local"))
+		return;
+	len = sizeof(peer);
+	if (!ASSERT_OK(getpeername(accepted, (void *)&peer, &len),
+		       "timewait_peer"))
+		return;
+	if (family == AF_INET) {
+		l4 = (void *)&local;
+		p4 = (void *)&peer;
+		skel->bss->probe_tuple.ipv4.saddr = p4->sin_addr.s_addr;
+		skel->bss->probe_tuple.ipv4.daddr = l4->sin_addr.s_addr;
+		skel->bss->probe_tuple.ipv4.sport = p4->sin_port;
+		skel->bss->probe_tuple.ipv4.dport = l4->sin_port;
+		skel->bss->probe_len = sizeof(skel->bss->probe_tuple.ipv4);
+	} else {
+		l6 = (void *)&local;
+		p6 = (void *)&peer;
+		memcpy(skel->bss->probe_tuple.ipv6.saddr, &p6->sin6_addr,
+		       sizeof(p6->sin6_addr));
+		memcpy(skel->bss->probe_tuple.ipv6.daddr, &l6->sin6_addr,
+		       sizeof(l6->sin6_addr));
+		skel->bss->probe_tuple.ipv6.sport = p6->sin6_port;
+		skel->bss->probe_tuple.ipv6.dport = l6->sin6_port;
+		skel->bss->probe_len = sizeof(skel->bss->probe_tuple.ipv6);
+	}
+	if (!ASSERT_OK(shutdown(accepted, SHUT_WR), "server_shutdown") ||
+	    !ASSERT_EQ(recv(client, &buf, 1, 0), 0, "client_eof") ||
+	    !ASSERT_OK(shutdown(client, SHUT_WR), "client_shutdown") ||
+	    !ASSERT_EQ(recv(accepted, &buf, 1, 0), 0, "server_eof"))
+		return;
+	fd = bpf_program__fd(skel->progs.probe_timewait);
+	for (i = 0; i < POLL_RETRIES; i++) {
+		if (!ASSERT_OK(bpf_prog_test_run_opts(fd, &opts), "probe_timewait"))
+			return;
+		if (skel->bss->probe_state == BPF_TCP_TIME_WAIT)
+			break;
+		usleep(POLL_INTERVAL_US);
+	}
+	ASSERT_EQ(skel->bss->probe_state, BPF_TCP_TIME_WAIT, "timewait_found");
+	ASSERT_EQ(skel->bss->probe_result, -EOPNOTSUPP, "timewait_rejected");
+}
+
+static int enable_netns_ipv6(const char *name)
+{
+	struct nstoken *token;
+	int err;
+
+	token = open_netns(name);
+	if (!token)
+		return -1;
+	err = write_sysctl("/proc/sys/net/ipv6/conf/all/disable_ipv6", "0");
+	if (!err)
+		err = write_sysctl("/proc/sys/net/ipv6/conf/default/disable_ipv6",
+				   "0");
+	close_netns(token);
+	return err;
+}
+
+static void run_netkit(int family)
+{
+	const char *dest = family == AF_INET ? "198.18.0.99" : "2001:db8:99::99";
+	struct network_helper_opts client_opts = { .timeout_ms = IO_TIMEOUT_MS };
+	const char *bind_addr = family == AF_INET ? "0.0.0.0" : "::";
+	int server = -1, client = -1, accepted = -1;
+	struct netns_obj *host = NULL, *pod = NULL;
+	struct sockaddr_storage expected, actual;
+	struct sk_assign_netkit *skel = NULL;
+	struct network_helper_opts opts = {
+		.timeout_ms = IO_TIMEOUT_MS,
+		.post_socket_cb = transparent_socket,
+		.cb_opts = &family,
+	};
+	char buf[sizeof(TEST_DATA) - 1];
+	struct nstoken *pod_tok = NULL;
+	struct bpf_link *link = NULL;
+	socklen_t len, actual_len;
+	int i, err;
+
+	err = socket(family, SOCK_STREAM, 0);
+	if (err < 0 && errno == EAFNOSUPPORT) {
+		printf("SKIP: address family %d is unavailable\n", family);
+		test__skip();
+		return;
+	}
+	if (!ASSERT_GE(err, 0, "family_probe"))
+		return;
+	close(err);
+	host = netns_new(NS_HOST, true);
+	if (!ASSERT_NEQ(host, NULL, "host_netns"))
+		goto cleanup;
+	pod = netns_new(NS_POD, false);
+	if (!ASSERT_NEQ(pod, NULL, "pod_netns"))
+		goto cleanup;
+	if (family == AF_INET6 &&
+	    (!ASSERT_OK(enable_netns_ipv6(NS_HOST), "host_ipv6") ||
+	     !ASSERT_OK(enable_netns_ipv6(NS_POD), "pod_ipv6")))
+		goto cleanup;
+	err = create_netkit();
+	if (err == -EOPNOTSUPP) {
+		printf("SKIP: netkit is unavailable\n");
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_OK(err, "create_netkit"))
+		goto cleanup;
+	SYS(cleanup, "ip link set %s netns %s", POD_DEV, NS_POD);
+	SYS(cleanup, "ip link set %s up", HOST_DEV);
+	SYS(cleanup, "ip -n %s link set %s up", NS_POD, POD_DEV);
+	if (family == AF_INET) {
+		SYS(cleanup, "ip addr add 10.88.0.1/24 dev %s", HOST_DEV);
+		SYS(cleanup, "ip -n %s addr add 10.88.0.2/24 dev %s", NS_POD, POD_DEV);
+		SYS(cleanup, "ip -n %s route add default via 10.88.0.1", NS_POD);
+		SYS(cleanup, "ip route add local 198.18.0.99/32 dev lo");
+		if (!ASSERT_OK(write_sysctl("/proc/sys/net/ipv4/conf/all/rp_filter", "0"),
+			       "rp_filter_all") ||
+		    !ASSERT_OK(write_sysctl("/proc/sys/net/ipv4/conf/" HOST_DEV
+				   "/rp_filter", "0"),
+			       "rp_filter_host"))
+			goto cleanup;
+	} else {
+		SYS(cleanup, "ip -6 addr add fd88::1/64 dev %s nodad", HOST_DEV);
+		SYS(cleanup, "ip -n %s -6 addr add fd88::2/64 dev %s nodad", NS_POD, POD_DEV);
+		SYS(cleanup, "ip -n %s -6 route add default via fd88::1", NS_POD);
+		SYS(cleanup, "ip -6 route add local 2001:db8:99::99/128 dev lo");
+	}
+
+	server = start_server_str(family, SOCK_STREAM, bind_addr, PROXY_PORT, &opts);
+	if (!ASSERT_GE(server, 0, "start_server"))
+		goto cleanup;
+	skel = sk_assign_netkit__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+	skel->rodata->dest_port = DEST_PORT;
+	skel->rodata->proxy_port = PROXY_PORT;
+	if (!ASSERT_OK(sk_assign_netkit__load(skel), "skel_load"))
+		goto cleanup;
+	link = bpf_program__attach_netkit(skel->progs.assign_socket,
+					  if_nametoindex(HOST_DEV), NULL);
+	if (!ASSERT_OK_PTR(link, "attach_netkit"))
+		goto cleanup;
+	if (!ASSERT_OK(make_sockaddr(family, dest, DEST_PORT, &expected, &len),
+		       "make_sockaddr"))
+		goto cleanup;
+
+	for (i = 0; i < TEST_ITERATIONS; i++) {
+		pod_tok = open_netns(NS_POD);
+		if (!ASSERT_NEQ(pod_tok, NULL, "open_pod"))
+			goto cleanup;
+		client = connect_to_addr(SOCK_STREAM, &expected, len, &client_opts);
+		close_netns(pod_tok);
+		pod_tok = NULL;
+		if (!ASSERT_GE(client, 0, "connect_client"))
+			goto cleanup;
+		accepted = accept(server, NULL, NULL);
+		if (!ASSERT_GE(accepted, 0, "accept"))
+			goto cleanup;
+		if (!ASSERT_OK(settimeo(accepted, IO_TIMEOUT_MS),
+			       "accepted_timeout"))
+			goto cleanup;
+		memset(&actual, 0, sizeof(actual));
+		actual_len = sizeof(actual);
+		if (!ASSERT_OK(getsockname(accepted, (void *)&actual, &actual_len),
+			       "getsockname"))
+			goto cleanup;
+		ASSERT_EQ(actual_len, len, "original_address_len");
+		ASSERT_MEMEQ(&actual, &expected, len, "original_destination");
+		if (!ASSERT_EQ(send(client, TEST_DATA, sizeof(buf), 0),
+			       sizeof(buf), "send_client") ||
+		    !ASSERT_EQ(recv(accepted, buf, sizeof(buf), MSG_WAITALL),
+			       sizeof(buf), "recv_server") ||
+		    !ASSERT_MEMEQ(buf, TEST_DATA, sizeof(buf), "server_data") ||
+		    !ASSERT_EQ(send(accepted, buf, sizeof(buf), 0), sizeof(buf),
+			       "send_server") ||
+		    !ASSERT_EQ(recv(client, buf, sizeof(buf), MSG_WAITALL),
+			       sizeof(buf), "recv_client") ||
+		    !ASSERT_MEMEQ(buf, TEST_DATA, sizeof(buf), "client_data"))
+			goto cleanup;
+		if (i == TEST_ITERATIONS - 1)
+			check_timewait(skel, family, accepted, client);
+		close(accepted);
+		accepted = -1;
+		close(client);
+		client = -1;
+	}
+	if (!ASSERT_OK(bpf_link__detach(link), "detach_netkit"))
+		goto cleanup;
+	ASSERT_GE(skel->bss->listener_assignments, TEST_ITERATIONS,
+		  "listener_assignments");
+	ASSERT_GT(skel->bss->established_assignments, 0, "established_assignments");
+	ASSERT_GT(skel->bss->request_rejections, 0, "request_rejections");
+	ASSERT_EQ(skel->bss->assign_errors, 0, "assign_errors");
+cleanup:
+	close_netns(pod_tok);
+	bpf_link__destroy(link);
+	if (accepted >= 0)
+		close(accepted);
+	if (client >= 0)
+		close(client);
+	if (server >= 0)
+		close(server);
+	sk_assign_netkit__destroy(skel);
+	netns_free(pod);
+	netns_free(host);
+}
+
+void test_sk_assign_netkit(void)
+{
+	if (test__start_subtest("tcpv4"))
+		run_netkit(AF_INET);
+	if (test__start_subtest("tcpv6"))
+		run_netkit(AF_INET6);
+}
diff --git a/tools/testing/selftests/bpf/progs/sk_assign_netkit.c b/tools/testing/selftests/bpf/progs/sk_assign_netkit.c
new file mode 100644
index 000000000000..766f21d11772
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sk_assign_netkit.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <linux/errno.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+const volatile __u16 dest_port;
+const volatile __u16 proxy_port;
+__u64 listener_assignments;
+__u64 established_assignments;
+__u64 assign_errors;
+__u64 request_rejections;
+struct bpf_sock_tuple probe_tuple;
+__u32 probe_len;
+__u32 probe_state;
+int probe_result;
+
+SEC("netkit/peer")
+int assign_socket(struct __sk_buff *skb)
+{
+	void *data_end = (void *)(long)skb->data_end;
+	void *data = (void *)(long)skb->data;
+	struct bpf_sock_tuple tuple = {};
+	struct ethhdr *eth = data;
+	struct bpf_sock *sk;
+	struct tcphdr *th;
+	bool ipv4;
+	__u32 len;
+	int ret;
+
+	if (eth + 1 > data_end)
+		return TCX_PASS;
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		struct iphdr *iph = (void *)(eth + 1);
+
+		if (iph + 1 > data_end || iph->ihl != 5 ||
+		    iph->protocol != IPPROTO_TCP)
+			return TCX_PASS;
+		tuple.ipv4.saddr = iph->saddr;
+		tuple.ipv4.daddr = iph->daddr;
+		th = (void *)(iph + 1);
+		len = sizeof(tuple.ipv4);
+		ipv4 = true;
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ip6h = (void *)(eth + 1);
+
+		if (ip6h + 1 > data_end || ip6h->nexthdr != IPPROTO_TCP)
+			return TCX_PASS;
+		__builtin_memcpy(tuple.ipv6.saddr, &ip6h->saddr,
+				 sizeof(tuple.ipv6.saddr));
+		__builtin_memcpy(tuple.ipv6.daddr, &ip6h->daddr,
+				 sizeof(tuple.ipv6.daddr));
+		th = (void *)(ip6h + 1);
+		len = sizeof(tuple.ipv6);
+		ipv4 = false;
+	} else {
+		return TCX_PASS;
+	}
+	if (th + 1 > data_end || th->dest != bpf_htons(dest_port))
+		return TCX_PASS;
+	if (ipv4) {
+		tuple.ipv4.sport = th->source;
+		tuple.ipv4.dport = th->dest;
+	} else {
+		tuple.ipv6.sport = th->source;
+		tuple.ipv6.dport = th->dest;
+	}
+
+	sk = bpf_skc_lookup_tcp(skb, &tuple, len, BPF_F_CURRENT_NETNS, 0);
+	if (sk) {
+		if (sk->state == BPF_TCP_NEW_SYN_RECV) {
+			ret = bpf_sk_assign(skb, sk, 0);
+			bpf_sk_release(sk);
+			if (ret == -EOPNOTSUPP)
+				__sync_fetch_and_add(&request_rejections, 1);
+			else
+				__sync_fetch_and_add(&assign_errors, 1);
+			return TCX_PASS;
+		}
+		if (sk->state != BPF_TCP_LISTEN &&
+		    sk->state != BPF_TCP_TIME_WAIT) {
+			if (sk->state == BPF_TCP_ESTABLISHED)
+				__sync_fetch_and_add(&established_assignments, 1);
+			goto assign;
+		}
+		bpf_sk_release(sk);
+	}
+
+	__builtin_memset(&tuple, 0, sizeof(tuple));
+	if (ipv4)
+		tuple.ipv4.dport = bpf_htons(proxy_port);
+	else
+		tuple.ipv6.dport = bpf_htons(proxy_port);
+	sk = bpf_skc_lookup_tcp(skb, &tuple, len, BPF_F_CURRENT_NETNS, 0);
+	if (!sk) {
+		__sync_fetch_and_add(&assign_errors, 1);
+		return TCX_DROP;
+	}
+	__sync_fetch_and_add(&listener_assignments, 1);
+assign:
+	ret = bpf_sk_assign(skb, sk, 0);
+	bpf_sk_release(sk);
+	if (ret) {
+		__sync_fetch_and_add(&assign_errors, 1);
+		return TCX_DROP;
+	}
+	return TCX_PASS;
+}
+
+SEC("tc")
+int probe_timewait(struct __sk_buff *skb)
+{
+	struct bpf_sock *sk;
+
+	if (probe_len == sizeof(probe_tuple.ipv4))
+		sk = bpf_skc_lookup_tcp(skb, &probe_tuple,
+					sizeof(probe_tuple.ipv4),
+					BPF_F_CURRENT_NETNS, 0);
+	else
+		sk = bpf_skc_lookup_tcp(skb, &probe_tuple,
+					sizeof(probe_tuple.ipv6),
+					BPF_F_CURRENT_NETNS, 0);
+	if (!sk)
+		return TCX_PASS;
+	probe_state = sk->state;
+	probe_result = bpf_sk_assign(skb, sk, 0);
+	bpf_sk_release(sk);
+	return TCX_PASS;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.47.3

