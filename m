Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9351238D54
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304590; cv=none; b=EivqcOQsNs5UccW6T3U2UpMoE2mou3Ut/mNuBLLNh4+jBtqCfwdWLH1x4lgqJ26lTYpa+WxNV77TYlMv77f4lJ82fTuLPVuobSIPrxc1xgLDU/gr7iVo8Ec9PEFSiSy0xyz5D30M6aJOLerNrM3snXjxsBsoHWgdK6/zA5rQLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304590; c=relaxed/simple;
	bh=nTH+eojhoFFz9HncLBNVY0cEivOENhvAwAr6MGbzqKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ceba0K4EiEpP9q31No0Md4YkB4v683t9qpH20CvZCmo28vlkclpKHhVITuxsEPPLQ7WvqLfYScYX9cvPBI/BG05wMsKRajJYa6t/7OBOM9pVETizMDTK8oGWrMbFJ1NcqhSZMQ2V6yiS+ifMi8SuzHFfnKY37VXDC/d+4nc8cjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DquNhBjV; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DquNhBjV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773304586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7o6Ic5MlHNF41ckgEquaw90LYmRX6RnSZUbqSyihAno=;
	b=DquNhBjV6TnkfTfEtasziI0Ea+1ve8SuniSNu5Q5kmIbZwisPCPNdviBTwiLHQqX+9nr48
	nG3jWYx7rfhu2eoQs5yRGa4m4SretLqAP9cIIuUQrpHFAA61au4yHKVz5p6RvTiMbQFCzX
	rUpSA587+LYmExLO1cHjq2m7k7UNlkU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9=20=28eBPF=20Foundation=29?= <alexis.lothore@bootlin.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1] selftests/bpf: Improve tc_tunnel test reliability
Date: Thu, 12 Mar 2026 16:35:54 +0800
Message-ID: <20260312083615.31835-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

A test failure was discovered in BPF CI [1] caused by connection timeout.
The current test timeout of 500ms is insufficient for CI environments,
particularly under high load.

While the optimal timeout is unclear, this test was converted from the
original test_tc_tunnel.sh script. The original script used nc with "-w 1"
to specify a 1-second timeout [2]. Therefore, this test restores the
timeout to 1s.

Test:
./test_progs -a tc_tunnel
 #478/1   tc_tunnel/ipip_none:OK
 #478/2   tc_tunnel/ipip6_none:OK
 #478/3   tc_tunnel/ip6tnl_none:OK
 #478/4   tc_tunnel/sit_none:OK
 #478/5   tc_tunnel/vxlan_eth:OK
 #478/6   tc_tunnel/ip6vxlan_eth:OK
 #478/7   tc_tunnel/gre_none:OK
 #478/8   tc_tunnel/gre_eth:OK
 #478/9   tc_tunnel/gre_mpls:OK
 #478/10  tc_tunnel/ip6gre_none:OK
 #478/11  tc_tunnel/ip6gre_eth:OK
 #478/12  tc_tunnel/ip6gre_mpls:OK
 #478/13  tc_tunnel/udp_none:OK
 #478/14  tc_tunnel/udp_eth:OK
 #478/15  tc_tunnel/udp_mpls:OK
 #478/16  tc_tunnel/ip6udp_none:OK
 #478/17  tc_tunnel/ip6udp_eth:OK
 #478/18  tc_tunnel/ip6udp_mpls:OK
 #478     tc_tunnel:OK
 Summary: 1/18 PASSED, 0 SKIPPED, 0 FAILED

[1] https://github.com/kernel-patches/bpf/actions/runs/22674350732/job/65728072723
[2] https://lore.kernel.org/all/20251027-tc_tunnel-v3-4-505c12019f9d@bootlin.com/

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
index 7fc4d7dd70eff..23b5c522ea9fa 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
@@ -168,7 +168,7 @@ static int check_server_rx_data(struct subtest_cfg *cfg,
 
 static struct connection *connect_client_to_server(struct subtest_cfg *cfg)
 {
-	struct network_helper_opts opts = {.timeout_ms = 500};
+	struct network_helper_opts opts = {.timeout_ms = 1000};
 	int family = cfg->ipproto == 6 ? AF_INET6 : AF_INET;
 	struct connection *conn = NULL;
 	int client_fd, server_fd;
-- 
2.43.0

