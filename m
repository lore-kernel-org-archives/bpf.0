Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C72436197B;
	Mon, 21 Sep 2026 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970441; cv=none; b=lt3+2Q6nHVgBvZu1H8uW14yTZTTsiHxg3M0MZpySyuPlv76Uf5e9G5NYvfHyOEET0g7vPZvYcQzoz0jr4brPAzMut8c3CQEuwnJkEyJPChzlxFp3gPWJvHVNj13Qb/FqgMFJGLbjjhy/tBa8M8GgGpfpWIL+CLGpN4bN6RFE77E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970441; c=relaxed/simple;
	bh=RMF65b1th4KyTlyH/ghnwdL51KpWq0LFuQceNJ7drA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I0a6QJGWO3LlfsOcq6ymEykmebOeV8YDu33bGZrik2/aHaA57Nd3ixy9xD+bNGaS5kHXegfLjnnPeU1cfuy7zQrPJdI0S8PriboEVMx+ICrDvaLVgiA3xAxYTVNKfVX2bDY/X0oFWGAjA16FSG6tEPVCf13YJxokV41N9jFdMlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoihMhd5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoihMhd5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5765C2BCFA;
	Mon, 21 Sep 2026 06:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789970440;
	bh=RMF65b1th4KyTlyH/ghnwdL51KpWq0LFuQceNJ7drA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eoihMhd5PTHLn84/vz7sPPFcqhtM0KVh1hDXderO9x9SRxPJl86fSckKtZyocPdO4
	 bP6/r+P6HBj/rS3eA7OgvhbEKVfkCjkYoN0DAEq40cZ39QgYCa1Q7qHrfOyWp3dShc
	 CR5AMtYFXKf/Dzl5hf1qZpvdYrMD6io0PQN635VZHjRvDB+p1pTdAbE6u50Q5U3YYJ
	 rjYkIUroRaf5xT2gueQEUqtm59TmaonaOI1isxKcMo393YnWtDUud8qGqdMiUsIjSp
	 hU8HEYq9YizkGtdIi5Ump7r5hUCdmiJHPuLe0orFMX7yuBNEEoh8KDc+oTcYyRLeUc
	 XkkIYnrk7+Jew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD97C982E1;
	Mon, 21 Sep 2026 06:00:40 +0000 (UTC)
From: Bochao Cao via B4 Relay <devnull+bochaolucky.gmail.com@kernel.org>
Date: Mon, 21 Sep 2026 14:00:04 +0800
Subject: [PATCH net-next v4 1/2] selftests/bpf: Track test_xdp_features DUT
 processes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-xdp-features-v4-send-v4-1-a0d4ec392cb7@gmail.com>
References: <20260921-xdp-features-v4-send-v4-0-a0d4ec392cb7@gmail.com>
In-Reply-To: <20260921-xdp-features-v4-send-v4-0-a0d4ec392cb7@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Tiezhu Yang <tiozhang@didiglobal.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bochao Cao <bochaolucky@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789970439; l=4557;
 i=bochaolucky@gmail.com; h=from:subject:message-id;
 bh=uQ+2NU3O7ZSyy8b0vNzfpUwu1hVw6HZn8zL79tfx1s4=;
 b=f9+18WycEljt8+sSaCF0e9Vnd4C271Sk4lTjnBNY4fiSf6tAP5xaSygC5OoTAk8qXYKTp6uJM
 OR5FRY54hAeB5/M62m7KRS+ZbK4JQjti1khYquT94N/uTyvCTZylnqR
X-Developer-Key: i=bochaolucky@gmail.com; a=ed25519;
 pk=ZYp7O2eXSIrJ9YmKrl0iHDoulPYSG+1lzICsicAvld0=
X-Endpoint-Received: by B4 Relay for bochaolucky@gmail.com/default with
 auth_id=1042
X-Original-From: Bochao Cao <bochaolucky@gmail.com>
Reply-To: bochaolucky@gmail.com

From: Bochao Cao <bochaolucky@gmail.com>

Track the DUT process instead of matching processes by name to avoid
interference between concurrent tests. Fix readiness retries under
set -e and clean up the DUT and network state on exit or interruption.

Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
---
 tools/testing/selftests/bpf/test_xdp_features.sh | 88 ++++++++++++++++++------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xdp_features.sh b/tools/testing/selftests/bpf/test_xdp_features.sh
index 0aa71c445..a78e0fb9e 100755
--- a/tools/testing/selftests/bpf/test_xdp_features.sh
+++ b/tools/testing/selftests/bpf/test_xdp_features.sh
@@ -8,6 +8,7 @@ readonly V0_IP6=2001:db8::11
 readonly V1_IP6=2001:db8::1
 
 ret=1
+dut_pid=""
 
 setup() {
 	{
@@ -30,77 +31,124 @@ setup() {
 	} > /dev/null 2>&1
 }
 
+terminate_dut_server() {
+	local pid
+
+	# Use the shell job instead of dut_pid, which may not have been assigned
+	# yet if a signal arrived immediately after the server was started.
+	pid=$(jobs -pr %% 2> /dev/null) || true
+	if [ -z "$pid" ]; then
+		dut_pid=""
+		return
+	fi
+
+	kill -KILL %% 2> /dev/null || true
+	wait "$pid" 2> /dev/null || true
+	dut_pid=""
+}
+
 cleanup() {
-	ip link del v1 2> /dev/null
-	ip netns del ${NS} 2> /dev/null
-	[ "$(pidof xdp_features)" = "" ] || kill $(pidof xdp_features) 2> /dev/null
+	terminate_dut_server
+	ip link del v1 2> /dev/null || true
+	ip netns del "${NS}" 2> /dev/null || true
 }
 
 wait_for_dut_server() {
-	while sleep 1; do
-		ss -tlp | grep -q xdp_features
-		[ $? -eq 0 ] && break
+	local i
+
+	for ((i = 0; i < 10; i++)); do
+		if [ "$(jobs -pr %% 2> /dev/null)" != "$dut_pid" ]; then
+			echo "xdp_features server $dut_pid exited before accepting connections" >&2
+			return 1
+		fi
+
+		if ss -tlp 2> /dev/null | grep -q "pid=$dut_pid,"; then
+			return 0
+		fi
+
+		sleep 1
 	done
+
+	echo "Timed out waiting for xdp_features server $dut_pid" >&2
+	return 1
+}
+
+start_dut_server() {
+	./xdp_features "$@" &
+	dut_pid=$!
+	wait_for_dut_server
+}
+
+reap_dut_server() {
+	local status=0
+
+	wait "$dut_pid" || status=$?
+	dut_pid=""
+	return "$status"
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
+	reap_dut_server
 
 	## XDP_DROP
-	./xdp_features -f XDP_DROP -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1 &
-	wait_for_dut_server
+	start_dut_server -f XDP_DROP -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1
 	ip netns exec ${NS} ./xdp_features -t -f XDP_DROP \
 					   -D ::ffff:$V1_IP4 \
 					   -C ::ffff:$V1_IP4 \
 					   -T ::ffff:$V0_IP4 v0
 	[ $? -ne 0 ] && exit
+	reap_dut_server
 
 	## XDP_ABORTED
-	./xdp_features -f XDP_ABORTED -D $V1_IP6 -T $V0_IP6 v1 &
-	wait_for_dut_server
+	start_dut_server -f XDP_ABORTED -D $V1_IP6 -T $V0_IP6 v1
 	ip netns exec ${NS} ./xdp_features -t -f XDP_ABORTED \
 					   -D $V1_IP6 -C $V1_IP6 \
 					   -T $V0_IP6 v0
 	[ $? -ne 0 ] && exit
+	reap_dut_server
 
 	## XDP_TX
-	./xdp_features -f XDP_TX -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1 &
-	wait_for_dut_server
+	start_dut_server -f XDP_TX -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1
 	ip netns exec ${NS} ./xdp_features -t -f XDP_TX \
 					   -D ::ffff:$V1_IP4 \
 					   -C ::ffff:$V1_IP4 \
 					   -T ::ffff:$V0_IP4 v0
 	[ $? -ne 0 ] && exit
+	reap_dut_server
 
 	## XDP_REDIRECT
-	./xdp_features -f XDP_REDIRECT -D $V1_IP6 -T $V0_IP6 v1 &
-	wait_for_dut_server
+	start_dut_server -f XDP_REDIRECT -D $V1_IP6 -T $V0_IP6 v1
 	ip netns exec ${NS} ./xdp_features -t -f XDP_REDIRECT \
 					   -D $V1_IP6 -C $V1_IP6 \
 					   -T $V0_IP6 v0
 	[ $? -ne 0 ] && exit
+	reap_dut_server
 
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
+	reap_dut_server
 }
 
 set -e
-trap cleanup 2 3 6 9
+trap cleanup EXIT
+trap 'exit 129' HUP
+trap 'exit 130' INT
+trap 'exit 131' QUIT
+trap 'exit 134' ABRT
+trap 'exit 143' TERM
 
 test_xdp_features
 

-- 
2.43.0


