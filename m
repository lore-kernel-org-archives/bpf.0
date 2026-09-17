Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33937F00D;
	Thu, 17 Sep 2026 01:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610182; cv=none; b=ERMfYSIVP5AJVNsQTMe2FOUfMz9wQ8lmYdzyRyeMZugiPKSJfEg0ErKctM644qtW8YIMshy2HABR3THbmcVf2dJUBKdqg6VYE+ZlncoGJLzKqkrHqUW6VM0VgIgY17IKrE/F4ZZuuEVbeUUGdhQ4ctuSHUbnywc7frC4wDdY4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610182; c=relaxed/simple;
	bh=6aLvv26gzfe7p4DZyMFH38kkHLGlcFACYahQlzHunJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+Uq0lbaODWnfrUHOdhWeQB1n4skKa5Lvy2Wt2dLjfU3S1SUDBId2tWyTpp72K5JsMA4tLeFlvxeSeYcNmCjEnFOVoK3+HCAgDCWuatOkPynGOe970YI9IYqV0AVZZ8yzhWM1j3w+ELFcSA+RA5eO+wTSBU1aE8TwbLY/DlMN2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=BaYtfOlA; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BaYtfOlA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=6q44N/SKdwH/k3pKemR1sT2b8ZYcaux/puC2YbKuY7o=; b=BaYtfOlAm39h
	sz4v1iuM6ti+7bEIjqPZkicwkZNX6bNO28WfXzyELaODXb6cdYkd6+WpDQZUQV2DbFRQMvDtPMYYe
	Ob9C1Aq4QfzGmtwgfu+zIzkOJ2rnn8XrrjgMieHP+XA/fzdMWDt9hMqgAHCpmh4FkNsx1pjK1rnkw
	HLkbYAIDDQoamwQ/45AsVUjheunHi/Pn2Rw0sBi/8VsEXP9fV//AXkLPPujjGcLTzh8zZH95u0GZi
	ocz22IwKRJXZi6ivbnT5pcxRwciAoEE+hBn/dxAxInAXgJfcMZUnPIl1mAK/Vu7b+kSXl2KOeV0Ba
	54D1VAF6sU1egHrlTwo/tw==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1x71JN-00132Z-0u;
	Thu, 17 Sep 2026 03:56:07 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] selftests: bpf: run test_xdp_features in its own netns
Date: Thu, 17 Sep 2026 04:55:56 +0300
Message-ID: <20260917015605.2464043-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test creates its devices in the namespace it is started in and binds
an IPv6 socket to talk between the two ends. Both are unnecessary
demands on the host it runs on.

The device name is fixed, v1, so a host that already has a device by
that name cannot run the test at all. The IPv6 control socket depends on
the host's firewall rules, and where those reject ICMPv6 or the port the
test picks, the two ends never meet:

  Failed connecting to the Device Under Test control socket

Cleanup is trapped for signals only, not for a normal exit, so a run
that fails leaves both the device and the namespace behind. Every later
run then stops in setup, before it prints anything.

Re-exec in a new network namespace, where the device name is free and no
rule of the host applies, and everything the test made goes away with
the namespace when it exits.

Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 tools/testing/selftests/bpf/test_xdp_features.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_xdp_features.sh b/tools/testing/selftests/bpf/test_xdp_features.sh
index 0aa71c4455c0..1f6be4af6718 100755
--- a/tools/testing/selftests/bpf/test_xdp_features.sh
+++ b/tools/testing/selftests/bpf/test_xdp_features.sh
@@ -1,6 +1,19 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# The device under test listens on the veth address of the namespace this
+# script runs in and the tester connects to it, so a firewall on the
+# machine can refuse the control connection:
+#   Failed connecting to the Device Under Test control socket
+# That side of the pair is also always called v1, and cleanup only runs
+# on a signal, so a failed run leaves the device behind and every later
+# run stops in setup.  A namespace of our own has no such rules, and
+# takes the leftovers with it when the test ends.
+if [ -z "${XDP_FEATURES_NETNS:-}" ]; then
+	XDP_FEATURES_NETNS=1 export XDP_FEATURES_NETNS
+	exec unshare -n sh -c 'ip link set lo up; exec "$0" "$@"' "$0" "$@"
+fi
+
 readonly NS="ns1-$(mktemp -u XXXXXX)"
 readonly V0_IP4=10.10.0.11
 readonly V1_IP4=10.10.0.1
-- 
2.55.0

