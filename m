Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346463DCD95;
	Wed,  5 Aug 2026 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915001; cv=none; b=MuhbG02/KTRvDByPsam+zFM0Lf8y/pjNkONj+R+QBkmpkaD9wZx8+9jOTWNbbG2STJUAD17W+r5o39MkSE2AkvYnStsV78ZYJGEB1v7HY/HGfR1ScB0Hmbgzp8h7anNw7a6d1qsJGxsc8rTlt5GP4c2nmMUTqY0zQgCldw+YngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915001; c=relaxed/simple;
	bh=mLpr+qO4dl8whi3UQYmaGUkANNrHvfLh0/2dU0t5k3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eIMzEPjciHM7XXNLpgEdviPhZ61iuD3SlFOfUyyXyMRCHEnX+7CmAu+QWGyT2uoQXMiqVn0+/znIN64s/zVHPEcVT7tck02Q9MG0Xlyc6da1RfRudYKQUkQfE5oTMILJ05njjS04J9an8aimFEjOPL4ehdtI/xMoKvbaO4EsInw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fir13Pya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fir13Pya"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9269AC19425;
	Wed,  5 Aug 2026 07:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785915000;
	bh=mLpr+qO4dl8whi3UQYmaGUkANNrHvfLh0/2dU0t5k3w=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=fir13PyajHVlc2Rc9nIwgQOJnP2tCfkGTahgmdGHeOhgXiMGbQtp34bEUEZROrxv5
	 djzJNGr7nlFYR8Yqp8p9Jup6Y3XMHuQDUaYVl2s1ZeSemY897Xwsj54uXp9s8FH5/q
	 2Csx/FFEd5qwIkyjYxyWIAZz+7ymvOoqMZMzfsXis4YxEBQWJr+Y2VyIvk9tio3gyX
	 16/tXmYMBaqwGWeOXs0BzANG60iLdASjlki9bMnGFo/hwuRNtcuwr5IDyeLMrpTTjg
	 ahgfzBS3OUUcWw3lcuW7/rJfH9a5hG1rGXVuR6W7pLuINfVG4qY7fP3Lb83235JyvM
	 +iZe/D7RHS8AQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B75FC55182;
	Wed,  5 Aug 2026 07:30:00 +0000 (UTC)
From: Bochao Cao via B4 Relay <devnull+bochaolucky.gmail.com@kernel.org>
Date: Wed, 05 Aug 2026 15:29:42 +0800
Subject: [PATCH bpf-next] selftests/bpf: Track test_xdp_features DUT
 processes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-xdp-dut-process-lifecycle-gmail-v1-1-45984df8d295@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQrCMBAAv1L27EJaMBS/Ih7a3U1diWlIUomU/
 t2ox2FgZocsSSXDpdshyUuzrqFBf+qA7lNYBJUbw2AGa0ZzxsoReSsY00qSM3p1Qm/ygstzUo+
 WrZndyMSuh1aJSZzW3+EKc3QYpBa4/U3e5odQ+Q7gOD6htoNVjQAAAA==
X-Change-ID: 20260805-xdp-dut-process-lifecycle-gmail-6d60bf8dcdf1
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, Bochao Cao <bochaolucky@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785914999; l=4986;
 i=bochaolucky@gmail.com; s=20260805; h=from:subject:message-id;
 bh=2PX0a8BnWsRv3IzbYZsE6aRgPFWWou64hmODJGIhqFk=;
 b=G+ama6iOK6PZpitgtc3PszYOiC+EWiymrju6cQy/uyhX0yJ87JwgGGwizfCUE/hjAD0Rq9mIm
 jEaicJZFRvKBya927CRm6Cs4PF7/TdUYZFjFwIU6lETjqkGK0H7pPiU
X-Developer-Key: i=bochaolucky@gmail.com; a=ed25519;
 pk=ZYp7O2eXSIrJ9YmKrl0iHDoulPYSG+1lzICsicAvld0=
X-Endpoint-Received: by B4 Relay for bochaolucky@gmail.com/20260805 with
 auth_id=920
X-Original-From: Bochao Cao <bochaolucky@gmail.com>
Reply-To: bochaolucky@gmail.com

From: Bochao Cao <bochaolucky@gmail.com>

test_xdp_features.sh waits for any xdp_features listener to appear and
uses pidof during cleanup. A concurrent test can therefore make another
test proceed before its own DUT is ready, and cleanup kills every
xdp_features process on the host. The readiness loop also has no timeout,
so a DUT that exits before listening leaves the test hung indefinitely.

Record each DUT PID when it is spawned, wait for ss to report that exact
PID with a bounded retry loop, and only terminate and reap recorded
children. Install an EXIT trap and signal handlers so failure paths also
remove child processes and network setup.

This also removes the runtime dependency on pidof.

Fixes: 4dba3e7852b7 ("selftests/bpf: introduce XDP compliance test tool")
Closes: https://bugs.debian.org/1136522
Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
---
Tests:
- bash -n tools/testing/selftests/bpf/test_xdp_features.sh
- make -C tools/testing/selftests/bpf xdp_features
- sudo tools/testing/selftests/bpf/test_xdp_features.sh
- verified cleanup leaves an unrelated xdp_features process running
---
 tools/testing/selftests/bpf/test_xdp_features.sh | 60 ++++++++++++++++--------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xdp_features.sh b/tools/testing/selftests/bpf/test_xdp_features.sh
index 0aa71c4..f3aa4d1 100755
--- a/tools/testing/selftests/bpf/test_xdp_features.sh
+++ b/tools/testing/selftests/bpf/test_xdp_features.sh
@@ -8,6 +8,7 @@ readonly V0_IP6=2001:db8::11
 readonly V1_IP6=2001:db8::1
 
 ret=1
+dut_pids=()
 
 setup() {
 	{
@@ -31,32 +32,53 @@ setup() {
 }
 
 cleanup() {
-	ip link del v1 2> /dev/null
-	ip netns del ${NS} 2> /dev/null
-	[ "$(pidof xdp_features)" = "" ] || kill $(pidof xdp_features) 2> /dev/null
+	for pid in "${dut_pids[@]}"; do
+		kill "$pid" 2> /dev/null || true
+		wait "$pid" 2> /dev/null || true
+	done
+	ip link del v1 2> /dev/null || true
+	ip netns del "${NS}" 2> /dev/null || true
 }
 
 wait_for_dut_server() {
-	while sleep 1; do
-		ss -tlp | grep -q xdp_features
-		[ $? -eq 0 ] && break
+	local pid=$1
+	local i
+
+	for ((i = 0; i < 10; i++)); do
+		if ! kill -0 "$pid" 2> /dev/null; then
+			echo "xdp_features server $pid exited before accepting connections" >&2
+			return 1
+		fi
+
+		if ss -tlp 2> /dev/null | grep -q "pid=$pid,"; then
+			return 0
+		fi
+
+		sleep 1
 	done
+
+	echo "Timed out waiting for xdp_features server $pid" >&2
+	return 1
+}
+
+start_dut_server() {
+	./xdp_features "$@" &
+	dut_pids+=("$!")
+	wait_for_dut_server "$!"
 }
 
 test_xdp_features() {
 	setup
 
 	## XDP_PASS
-	./xdp_features -f XDP_PASS -D $V1_IP6 -T $V0_IP6 v1 &
-	wait_for_dut_server
+	start_dut_server -f XDP_PASS -D $V1_IP6 -T $V0_IP6 v1
 	ip netns exec ${NS} ./xdp_features -t -f XDP_PASS \
 					   -D $V1_IP6 -C $V1_IP6 \
 					   -T $V0_IP6 v0
 	[ $? -ne 0 ] && exit
 
 	## XDP_DROP
-	./xdp_features -f XDP_DROP -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1 &
-	wait_for_dut_server
+	start_dut_server -f XDP_DROP -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1
 	ip netns exec ${NS} ./xdp_features -t -f XDP_DROP \
 					   -D ::ffff:$V1_IP4 \
 					   -C ::ffff:$V1_IP4 \
@@ -64,16 +86,14 @@ test_xdp_features() {
 	[ $? -ne 0 ] && exit
 
 	## XDP_ABORTED
-	./xdp_features -f XDP_ABORTED -D $V1_IP6 -T $V0_IP6 v1 &
-	wait_for_dut_server
+	start_dut_server -f XDP_ABORTED -D $V1_IP6 -T $V0_IP6 v1
 	ip netns exec ${NS} ./xdp_features -t -f XDP_ABORTED \
 					   -D $V1_IP6 -C $V1_IP6 \
 					   -T $V0_IP6 v0
 	[ $? -ne 0 ] && exit
 
 	## XDP_TX
-	./xdp_features -f XDP_TX -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1 &
-	wait_for_dut_server
+	start_dut_server -f XDP_TX -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1
 	ip netns exec ${NS} ./xdp_features -t -f XDP_TX \
 					   -D ::ffff:$V1_IP4 \
 					   -C ::ffff:$V1_IP4 \
@@ -81,26 +101,26 @@ test_xdp_features() {
 	[ $? -ne 0 ] && exit
 
 	## XDP_REDIRECT
-	./xdp_features -f XDP_REDIRECT -D $V1_IP6 -T $V0_IP6 v1 &
-	wait_for_dut_server
+	start_dut_server -f XDP_REDIRECT -D $V1_IP6 -T $V0_IP6 v1
 	ip netns exec ${NS} ./xdp_features -t -f XDP_REDIRECT \
 					   -D $V1_IP6 -C $V1_IP6 \
 					   -T $V0_IP6 v0
 	[ $? -ne 0 ] && exit
 
 	## XDP_NDO_XMIT
-	./xdp_features -f XDP_NDO_XMIT -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1 &
-	wait_for_dut_server
+	start_dut_server -f XDP_NDO_XMIT -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1
 	ip netns exec ${NS} ./xdp_features -t -f XDP_NDO_XMIT \
 					   -D ::ffff:$V1_IP4 \
 					   -C ::ffff:$V1_IP4 \
 					   -T ::ffff:$V0_IP4 v0
 	ret=$?
-	cleanup
 }
 
 set -e
-trap cleanup 2 3 6 9
+trap cleanup EXIT
+trap 'exit 129' HUP
+trap 'exit 130' INT
+trap 'exit 143' TERM
 
 test_xdp_features
 

---
base-commit: 6655c409707ec8ce9ce0850ffe4fe02331fd4d9c
change-id: 20260805-xdp-dut-process-lifecycle-gmail-6d60bf8dcdf1

Best regards,
--  
Bochao Cao <bochaolucky@gmail.com>


