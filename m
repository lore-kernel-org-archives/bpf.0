Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCB333688F
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786656964; cv=none; b=jWnGqYcC8XpJofszEAqgXYa9nzns9UZFlEXRrFmZFNzvB7vPLlo+lacFlKEqJx/tBct/dNwzD4ZWc9ulRVPkqqeYRiPCKP2Q9IFoDafglOF8DWgy6zFLYRVmJSm3FlSPYLjAJ/MO5v1UBWib98ySk60niOziYt7sscVlqPHIWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786656964; c=relaxed/simple;
	bh=bfAqsAAjknuXLM7V8nV9QmEUchJdxl2w+c5fFZYasq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFFKzg5ZAlz4/wCCdUf0/y0Bcvpr1GOcz6CfuvJQmYKowkdp9b8BDs2SZzVk+TKtDNw+THE88YcwawHkRkrVNgK/AOtkwrdtT4A4PWu9cEd9loxxuUfA1Zrra0LW49Ib1n6tDRpXLNYyQXp4/3LAycxtiX87RE1i6jB/kUurbiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm4BydtV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm4BydtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33061F000E9;
	Thu, 13 Aug 2026 21:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786656962;
	bh=pEgtUHR85pJvxTatTgfXENEEYV/8bVzxu0MK7w0h+Po=;
	h=From:To:Cc:Subject:Date;
	b=Bm4BydtVp4/Qz5yAmCuoGlj9MVPPKFEBCyqbH4FXvUxq43n9cEMb4GmhRo1EEn7lQ
	 xZq0GgyU/P7enM4pppkywJYLkMoQmcsehkVCbnpCpJLa04ksNV72SbHMvOZ6cPqpGo
	 Ww4JqonzVR3nIaXfFaOSzeyrnu5hKcjJH5VnyBeqSeUUcjFENpjiLILFYorTsjDko4
	 40a8R4d0wylSZxZC9jOYSocgx2zdaEubAtcH/E5zFVUG8IJOMkgPCDZtnnPDmYZf9F
	 yXHigLDT5Y+QeElvW/WGy1fw1gVJmxSnzsUgxg6K6LUXzC0vWXKEvLTJIejl912IOV
	 DC6Byg+QoJjJA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: Use ping_command() for IPv6 pings in lwt_ip_encap
Date: Thu, 13 Aug 2026 14:35:58 -0700
Message-ID: <20260813213558.3103179-1-andrii@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lwt_ip_encap hardcodes the ping6 binary for its IPv6 pings. iputils
merged ping6 into ping long ago and distros have started dropping the
compat symlink -- Arch's iputils 20250605 ships only arping, clockdiff,
ping and tracepath. There, every lwt_ip_encap subtest fails:

  check_ping_ok:FAIL:ip netns exec ns-lwt-ip-encap-1-0101330 ping6 -c 1 \
    -W1 -I veth1 fb04::1 > /dev/null unexpected error: 256 (errno 2)
  #217/1   lwt_ip_encap_ipv4/egress:FAIL

The IPv4 subtests fail too, because check_ping_ok() pings both families.
SYS() runs the command through system(), so a missing binary is
indistinguishable from an unreachable peer.

network_helpers.c has had ping_command() for exactly this since commit
372642ea83ff ("selftests/bpf: Move netcnt test under test_progs"): it
falls back to "ping -6" when ping6 is not present. lwt_ip_encap.c is the
last hardcoded ping6 user. Fix that.

Fixes: f5e288943e2c ("selftests/bpf: Move test_lwt_ip_encap to test_progs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
index 6606f0ed9a9a..39e8a3b8b6af 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
@@ -410,7 +410,8 @@ static int test_gso_fix(const char *ns1, const char *ns3, int family)
 static int check_ping_ok(const char *ns1)
 {
 	SYS(fail, "ip netns exec %s ping -c 1 -W1 -I veth1 %s > /dev/null", ns1, IP4_ADDR_DST);
-	SYS(fail, "ip netns exec %s ping6 -c 1 -W1 -I veth1 %s > /dev/null", ns1, IP6_ADDR_DST);
+	SYS(fail, "ip netns exec %s %s -c 1 -W1 -I veth1 %s > /dev/null", ns1,
+	    ping_command(AF_INET6), IP6_ADDR_DST);
 	return 0;
 fail:
 	return -1;
@@ -424,7 +425,8 @@ static int check_ping_fails(const char *ns1)
 	if (!ret)
 		return -1;
 
-	ret = SYS_NOFAIL("ip netns exec %s ping6 -c 1 -W1 -I veth1 %s", ns1, IP6_ADDR_DST);
+	ret = SYS_NOFAIL("ip netns exec %s %s -c 1 -W1 -I veth1 %s", ns1,
+			 ping_command(AF_INET6), IP6_ADDR_DST);
 	if (!ret)
 		return -1;
 
@@ -657,9 +659,10 @@ static void lwt_ip_encap_vxlan(bool ipv4_encap)
 	skel->bss->fexit_triggered = false;
 
 	if (ipv4_encap)
-		SYS(out, "ip netns exec %s ping  -c 1 -W1 %s", ns1, IP4_ADDR_DST);
+		SYS(out, "ip netns exec %s ping -c 1 -W1 %s", ns1, IP4_ADDR_DST);
 	else
-		SYS(out, "ip netns exec %s ping6 -c 1 -W1 %s", ns1, IP6_ADDR_DST);
+		SYS(out, "ip netns exec %s %s -c 1 -W1 %s", ns1,
+		    ping_command(AF_INET6), IP6_ADDR_DST);
 
 	if (!ASSERT_TRUE(skel->bss->fexit_triggered, "fexit_triggered"))
 		goto out;
-- 
2.53.0-Meta

