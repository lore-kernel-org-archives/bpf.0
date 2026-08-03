Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63C41D136
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776600; cv=none; b=D9p2PVQMIaVwEHnUTz65F1NYkQii/v2iI0HPoV+ntw9FeFDn5gkByltJKcyZ6hPCrWlW8rD3IVRDI38sKIw0OgQMH7rQZX2N4ni4fn45arnxTj3K18KWAp0ugUNAxmvwvVCOAq038hCNTWil8xAr9LTTEBGfNRIEyOG0rN9247o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776600; c=relaxed/simple;
	bh=AomQnBJrOabZeFIgszGdHUBOPU2NS3CZgOB9fea5+CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoRWY8FzSaLJz+pQ83xKO6GaxXYrjKG3fF+DTjB9R+F4cVlarm4AWdcnbRANkjvfkj21WDmh0cYQCUYmUgg8D+MpCcqTSpdWjD5OPl+hOjfcDv2Yf/SineBDPHIfBFRu+55zXE1YtUII0M7DutTv0hm7qDhz5MWf8MbuqCQR0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NHlwlQNZ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NHlwlQNZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785776590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkwIs7oH/Bj4wRZsMV4sV1xxa0iYAnaHv7HnajZqz60=;
	b=NHlwlQNZNfm377C2L3c2HQkFZLaLXz/e0cw/19B7pcR+Zkd1z+7c3SZkGbMyOgsuDfytg7
	6WOJ6Y87jKC5FqkM9pRgvRr5YhdWDe18mjvln9Cbj1ffXoNGw2Vh0i9JzutFZqlgm40GQ6
	bA19fxCm9AtLVx3BM1XsgB1UIfDiIuA=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [bpf-next 4/4] selftests/bpf: vmtest.sh: preserve command quoting when running in the VM
Date: Mon,  3 Aug 2026 10:02:51 -0700
Message-ID: <20260803170251.1898102-5-vineet.gupta@linux.dev>
In-Reply-To: <20260803170251.1898102-1-vineet.gupta@linux.dev>
References: <20260803170251.1898102-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

vmtest.sh captures the trailing command with command="$@", which flattens
the arguments into a single space-separated string, and then pastes it
into the generated guest init script:

        cd /root/bpf
        echo ${command}
        stdbuf -oL -eL ${command}

That here-doc is unquoted, so the host expands ${command} and the
flattened text lands in the script verbatim. The guest bash then parses
those lines as shell source, re-splitting the text on whitespace and
glob-expanding it against /root/bpf. As a result any command with a glob
or an argument containing spaces is corrupted before it reaches the test
binary. For example:

        vmtest.sh -- ./test_progs -a 'verifier_*'

has 'verifier_*' expanded in the guest into the matching object/skeleton
files (verifier_align.bpf.o verifier_align.skel.h ...), so test_progs is
handed a list of filenames instead of the intended name filter and runs no
matching tests.

Quote each argument with printf '%q ' so the command is reproduced
verbatim inside the VM: the escaped text goes through exactly one round
of quote removal when the guest parses the init script, yielding the
original argv with globs and special characters intact. The common case
(e.g. -t <name>) is unaffected.

Only do this when there is a command to quote. printf '%q ' with no
arguments still applies the format once and emits '', which the -s
(debug shell) path would take for a real command and try to run.

Note this makes the trailing command strictly an argv rather than a shell
snippet: passing it pre-quoted as one word, e.g.

        vmtest.sh -- "./test_progs -t foo"

no longer works, and neither does embedding guest-side shell syntax such
as ';' or a redirection. Neither form is documented - usage() and
README.rst both show the command unquoted - and 'sh -c ...' still works.

Fixes: c9709f52386d ("bpf: Helper script for running BPF presubmit tests")
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 tools/testing/selftests/bpf/vmtest.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 9ca802285393..6a3d026d76bd 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -428,8 +428,17 @@ main()
 
 	if [[ $# -eq 0  && "${debug_shell}" == "no" ]]; then
 		echo "No command specified, will run ${DEFAULT_COMMAND} in the vm"
-	else
-		command="$@"
+	elif [[ $# -gt 0 ]]; then
+		# Quote each argument so the command survives into the guest: the
+		# host expands ${command} into the generated init script, which
+		# the guest bash then parses as shell source. Without the %q
+		# escapes an argument with a space or a glob (e.g. -a 'verifier_*')
+		# is re-split and expanded against /root/bpf there.
+		#
+		# Skip this when there is no command: printf '%q ' would still
+		# apply the format once and emit '', which is not the empty
+		# command that -s (debug shell) expects.
+		command=$(printf '%q ' "$@")
 	fi
 
 	local kconfig_file="${OUTPUT_DIR}/latest.config"
-- 
2.55.0

