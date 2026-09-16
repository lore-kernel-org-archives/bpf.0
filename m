Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF74AC148
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601054; cv=none; b=DpyWVJgLOWOd9jGqanzeN7Ef4reZc4JJbN6WfW8QNJ33ZDLjzDsmi/eMDP1xT3089Iu9/BCOCPXx2MC5wA84lpwLUX5hsknRFvNMeeuFaJR90MK+FHtc0O/qx/U+wCxY0yAchF20NuV5Ih6pfZfpqxUp4NIlK/JfY6k2cluh0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601054; c=relaxed/simple;
	bh=C6p0VzhESS3YUAZ6jD8P6+9JQOWJbbvqWUkpg0WS+nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2aG3wOT2EaPW/P9Te2vLdTcUHDNLDAGeWUwO6qt+Yt5IN5eTLseEIGMGW6eUtVmqe1KC3Z8HyPTiDENv+CBh16iQoDEZ8V7vrtULE1tD4oZSOBhX2Qfb2DREE7Y9LJ2/cqoHoZg1XqsxC+1ZL8g22ADWZ88iPI3K14X77xRfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHX2fTaD; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHX2fTaD"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398beb616f5so77551a91.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789601052; x=1790205852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6pABj9nXXZs9Mu0ob9kVDZTLhP5PCYTs6fda/TKyqgo=;
        b=PHX2fTaD9mnOKfGLPOkUOwR1UNJQL5tw5t3MpPjVAEX93sW6VP+jzoVXVSw5wXqZoM
         B/4sfmmWJf3yxagD3Dxc+2rJV8xHQLhWCYsfY6Zq2vF5U/uSD9YdLMb2upMBmM1yuC4m
         hWSvxby7jLNf9CzFw9JxK547mLi/Zac0JcI03+BpVyNFH5+X3mgkpE0bFFfcV0vTVvOx
         1w3yaQa8+AIvw1roH7C6uWrEaOulcCDKwEodBOp25KkkUrdXM0LRTBKcsJTjRZt/8Lji
         dAql7HZrL4SH5u3YBp2H+Z61fJZX6uMr0eRCxq880MlWJvOJbvnGxmpsW2jYKkg8fScZ
         oE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789601052; x=1790205852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6pABj9nXXZs9Mu0ob9kVDZTLhP5PCYTs6fda/TKyqgo=;
        b=ICI99ik5e4GirxxC/gD3FE+DXrQcXJecIIV5Jet82tSi0dk3dFkbvxyMVsnrrhHwm+
         SVRWkNYcQ/p3ItAmCSb7wQyP3dVDlI1oX9RfrPTkEiAqHfJxhFwKi0UcydRXF3voZkNs
         QqChrBIRSss4GDg0rw7S8/rzMhhReVGSg74VhbOmT2LOcAtNREHeMmb3NfBux7zCaem+
         HqbSKkgkkq3s4zbJN4wr/oqPI68BgPlGJI6IvUz9rU+DBY/hx7bG6NIThvjdy2JIXZ1g
         ZDiZDcSGfI8plTI4OBOOONAS8LEoNCWaVRvPR6s9oBYQZ0ie5vBbYOMlhnII6RHtBzkO
         Lybg==
X-Gm-Message-State: AFuF++moblE8LnkfD5gzSak2WCTZ7CWs0Y/s7wqjYZEvsAvDFH7mvmI1
	e2RxZ4fAaUY8DvtEV+fRd5vG5cJQw3EhTjiIGikF8Lle/liEzSstE/nSdjIU2Q==
X-Gm-Gg: AYBFou2WByNjpar8iBR3AF3AQDpVwI63fa8q+UQoGzzwu1ufDWQQqBxtNWOw+sp+AgT
	VpPfNBDdXRrIOKFg1Pyd6wT6sfKFYF2j8w/QZgLtYkUiPNWqCQUHsY6JMLNS++sDAqh0g+PYRs7
	qeK+7ogiX3AnMjBi2KIxh1mrf7mEPt2Q2RbEiJZSsQob9Jb1bYmXbZTT5lk9vFwCDvc4M5QeHRU
	RODbBVz4+PxvH+BDsL+OVpObYwV6BDVLm8cLma5DQfdWN2Goi2q2r/TJLnQHcpjnbFj0qMUx0hh
	xpoUp2q9BgvB1IC1qneqfLok02MbbyPZ1+FYIJvxBIMA22qr03R65qtRGIv2qyhxAsAUtiY02Gy
	zrHPgCnzcXRV4IdVh0UvrYUYPaYJ7e55ERh1KTF8EcUOhvBURMJID3AOcj37pnOpiuRk7RrFVN8
	ANwv72j+vS+FLpuS6C43Czw/bamykfiArtpXivK+zF+pugEYqj0310XMSxVZV8hVNi4YN7pOQzR
	rqI7IlO68yN/78LiEWXKMP5PcNT8SJcoCtLIix7doyEyrNEMGhKIvLjhfI1ruRQSDVaEgCIDNu5
	ODr6pXFePY7Bw2QwNRDVVopgHqPdYhtaRZGOlc8OS69E
X-Received: by 2002:a17:90b:5484:b0:39d:b57e:b47d with SMTP id 98e67ed59e1d1-39e35f809c5mr1649980a91.8.1789601052187;
        Wed, 16 Sep 2026 16:24:12 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36115cc8sm1509507a91.3.2026.09.16.16.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:24:11 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	bastien.curutchet@bootlin.com,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Wait for links to come up in lwt_ip_encap
Date: Wed, 16 Sep 2026 23:24:07 +0000
Message-ID: <20260916232407.764886-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

lwt_ip_encap creates three fresh netns with veth pairs across them and
then immediately pings over IPv6. The peer ends of the first veth pair
end up with the same ifindex in their respective netns, so linkwatch
does not treat the carrier-on as urgent and may deliver NETDEV_CHANGE up
to one second later. Until that happens addrconf considers the link not
ready: no ff00::/8 multicast route and no link-local address are
installed, and the neighbour solicitation for the next hop is dropped
as a no-route packet. The NS retransmit a second later succeeds, but
ping -W1 has already given up:

  check_ping_ok:FAIL:ip netns exec ns-lwt-ip-encap-1-... ping -6 -c 1 -W1 -I veth1 fb04::1 > /dev/null unexpected error: 256 (errno 2)
  lwt_ip_encap:FAIL:ping OK unexpected error: -1 (errno 2)
  #226/1   lwt_ip_encap_ipv4/egress:FAIL

This reproduces reliably when the test is run standalone on an idle
system where setup completes well within a second. The original shell
script had a "sleep 1 # reduce flakiness" after setup which was lost in
the conversion to test_progs.

Instead of sleeping, poll SIOCGIFFLAGS for IFF_RUNNING on all veths at
the end of setup_network() so traffic is only sent once every link is
operationally up.

Fixes: f5e288943e2c ("selftests/bpf: Move test_lwt_ip_encap to test_progs")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
index 39e8a3b8b6af..5c5560d45c5b 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <net/if.h>
 #include <netinet/in.h>
+#include <sys/ioctl.h>
 
 #include "network_helpers.h"
 #include "test_progs.h"
@@ -141,6 +143,54 @@ static int set_bottom_addr(const char *ns1, const char *ns2, const char *ns3)
 	return 1;
 }
 
+/*
+ * A veth whose peer sits in another netns with the same ifindex gets its
+ * carrier-on handled as a non-urgent linkwatch event, i.e. up to 1s late.
+ * Until then IPv6 considers the link not ready (no ff00::/8 route, no
+ * link-local address) and silently drops neighbour solicitations, so wait
+ * for all links to be operationally up (IFF_RUNNING) before sending traffic.
+ */
+static int wait_for_oper_up(const char *ns, const char *dev)
+{
+	struct nstoken *nstoken;
+	struct ifreq ifr = {};
+	int i, fd, ret = -1;
+
+	nstoken = open_netns(ns);
+	if (!ASSERT_OK_PTR(nstoken, "open ns"))
+		return -1;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_OK_FD(fd, "socket"))
+		goto out;
+
+	strncpy(ifr.ifr_name, dev, IFNAMSIZ - 1);
+	for (i = 0; i < 50; i++) {
+		if (!ASSERT_OK(ioctl(fd, SIOCGIFFLAGS, &ifr), "SIOCGIFFLAGS"))
+			break;
+		if (ifr.ifr_flags & IFF_RUNNING) {
+			ret = 0;
+			break;
+		}
+		usleep(100000);
+	}
+	close(fd);
+out:
+	ASSERT_OK(ret, dev);
+	close_netns(nstoken);
+	return ret;
+}
+
+static int wait_for_links(const char *ns1, const char *ns2, const char *ns3)
+{
+	if (wait_for_oper_up(ns1, "veth1") || wait_for_oper_up(ns1, "veth5") ||
+	    wait_for_oper_up(ns2, "veth2") || wait_for_oper_up(ns2, "veth3") ||
+	    wait_for_oper_up(ns2, "veth6") || wait_for_oper_up(ns2, "veth7") ||
+	    wait_for_oper_up(ns3, "veth4") || wait_for_oper_up(ns3, "veth8"))
+		return -1;
+	return 0;
+}
+
 static int configure_vrf(const char *ns1, const char *ns2)
 {
 	if (!ns1 || !ns2)
@@ -304,6 +354,9 @@ static int setup_network(char *ns1, char *ns2, char *ns3, const char *vrf)
 	if (!ASSERT_OK(configure_ns3(ns3), "configure ns3 routes"))
 		goto fail;
 
+	if (!ASSERT_OK(wait_for_links(ns1, ns2, ns3), "wait for links"))
+		goto fail;
+
 	/* Link bottom route to the GRE tunnels */
 	SYS(fail, "ip -n %s route add %s/32 dev veth5 via %s %s",
 	    ns1, IP4_ADDR_GRE, IP4_ADDR_6, vrf);
-- 
2.55.0

