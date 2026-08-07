Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E57374A04
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786135525; cv=none; b=hccABUMhiugCiys1SmFmjICyuqOYApurSTAq8mQZ+/WhpVZPuECujL+uro871I7QFn6VvLyu1r5LFtDjQCeS3RBbOxgnF11O3V/0uon/ypm5OiK5kBR7GedHZmj3FOdeep9wn90G4lItKb5wLvT1rQDgpN35VhXijZq/53AQtYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786135525; c=relaxed/simple;
	bh=Q4RHAPdjvAUroJEAowcOvOdKnx9h9nY6Yn+jXr+v6wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXB6WY3G4HMO5Tkf6cac0uW2ya2VRto8rRmfQLdXlBIsoWvyg00nGnENzXy9x/ok6SOE28OaxJXuz3IhNV9VlFXeTiq4/H/Wgaqp/A25hMRFWMrP392EyCrxwHhmCCnAYCN0d4AVH8SAkDWyr9J6ff2/s6LFxoPXy8t/pEQsfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mjK9iPLV; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mjK9iPLV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786135521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+aKGXBL2tMvuQmrqU+86b/PjqkYaMHr/2ScOGESSKE=;
	b=mjK9iPLVNoISOhJoa7L1V1Ou6HrIcruls21r8soEC/N/vwlh5b/+VkmS9TlQsGOe6gsvAA
	U7Jns/AZOfx1ys/ba5ei1J/WkXX2djakMqCPZZnofLhP4YnxhjSqTkSXd6YuTVjYcbyy55
	0BEheeKx2fPcSMwjm/w4syPnU46glBU=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: vmtest.sh: preserve command quoting when running in the VM
Date: Fri,  7 Aug 2026 13:44:34 -0700
Message-ID: <20260807204434.1036279-5-vineet.gupta@linux.dev>
In-Reply-To: <20260807204434.1036279-1-vineet.gupta@linux.dev>
References: <20260807204434.1036279-1-vineet.gupta@linux.dev>
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
as ';' or a redirection. 'sh -c ...' still works.

The RV64 recipe in README.rst does depend on the old double parse: it
wraps the denylist in \" so the literal quotes reach the guest, whose
second parse of the init script removes them. Under %q those quotes now
survive into argv, and parse_test_list() strtok_r()s on ',' turns them
into junk filters:

        -d ",exceptions,"  ->  ["] [exceptions] ["]

That is harmless for DENYLIST.riscv64 only because its first line is a
comment, so the leading field is empty. A denylist starting with a real
entry would silently lose it - ["*arena*] never matches - so drop the
backslashes and let the host consume the quotes instead.

Fixes: c9709f52386d ("bpf: Helper script for running BPF presubmit tests")
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 tools/testing/selftests/bpf/README.rst |  4 ++--
 tools/testing/selftests/bpf/vmtest.sh  | 13 +++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index 37164322a102..07c834433b38 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -107,12 +107,12 @@ Docker container and local rootfs image. The overall steps are as follows:
     tools/testing/selftests/bpf/vmtest.sh \
     -l <path of local rootfs image> -- \
     ./test_progs -d \
-        \"$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 \
+        "$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 \
             | cut -d'#' -f1 \
             | sed -e 's/^[[:space:]]*//' \
                   -e 's/[[:space:]]*$//' \
             | tr -s '\n' ',' \
-        )\"
+        )"
 
 Link: https://github.com/pulehui/riscv-bpf-vmtest.git [0]
 Link: https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh [1]
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
2.53.0-Meta

