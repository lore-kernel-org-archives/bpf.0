Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567921;
	b=b+IVLtqkSq6sjixICiuph1LRI5iIvn94dbB+YLhx0RrRbc9SqR/8roHa/qx1CT5u7W8E
	 WwkfKVAl8H/CrD3ZiC4Uc3eqSpOV5zivphR/kZeQvI7Ekmw4VLGOOiFE0tT4Jj3m2lYRJ
	 w/z8bNYAfg9rYu8VGmSoDu8PDDxU+ecKCmgAALyd5/C5p1eDVdWl49wIKYEH3+fH8q0kN
	 u9WN0B6AJJhIt7l1UQvrNgzeqPRnaJlN+aNi2uQ0mh3fzb5fHQhVXCeC/YSJanL4UffsT
	 DBBKVPHVf5zr7Ra6Ep+z9ac4gUA61F7Nkb1r4iQAVyMr35JPGpC1pizrZZV7FUA+TWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=reO/0evIiDzpyVPcrOkTNkcSvkNXLH6JHyvO2OKvF+E=;
	b=1zbENZdrOUNoZzZQV4s8Sx2WYd7a0tB/6JdDGQoWDPY4XztHasjRWxb2Bo6XkBmL/PKV
	 K895lleN35sutPz43zo3/uwIeC242Ycm1euOnGrjfb2nhKDJsrvrZIRj4TpNcggQz0dkp
	 ZKIWW1/HFYbodb4YRQHL5P2242DgBqQ2h88poUspwcjJ/PeqzbNaPu5Te0gdaunspMIG8
	 tNaTMaQej2PPbyegiu/jeFrfkkt8FkINS5anNH5QumyDLLfErPuQOIIfHRvaVYF8Vn4H3
	 60leU02eOCpGsBimhEYg6dP+ry8HoPOulypO8aT2nbMEmzDlAiJmBJA7LYcEgQVV19Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aQx7jrkG;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401560A5BE1
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 00:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D401560A5BE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aQx7jrkG
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-38355b03cb8so5056007eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567920; x=1796172720; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=reO/0evIiDzpyVPcrOkTNkcSvkNXLH6JHyvO2OKvF+E=;
        b=aQx7jrkGVcH19bCY5rgJwvjq+KiJAhEf52+OiAcrQMBE4qbRpoylCJVZjNbGF4On9h
         73a5XuKQB+1Gpedqcept51JcxhgCx+mF0LZeqcE3qjVdrORfSEy3Wrv0gRbbTm4QNqoD
         9yaygDQRn5TEnBZmRxBCynGeWbLj22d0REsMg0ZzkxO7ClYsJJ5XXLq6790Dzwlr3MoQ
         ApWG537I0pcXGzeDSyQyomZJ57SaqsysxDHnit36NauM8FgoJJ85jNMKEqrM/nL9rqvf
         1yFGBSjWJ3a4JAxsP+dnGMrIJrnU79JbjKFYam8F2y2v7mqI6/aqEUpycjB0VDWP3D3Y
         f3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567920; x=1796172720;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=reO/0evIiDzpyVPcrOkTNkcSvkNXLH6JHyvO2OKvF+E=;
        b=zdHqAqS1kZS4Eo71ErS9uqoKfsDUwTik0ZsU5LcqRqOD9R0TKwIM6LdYRlpEzUca8J
         z4ke+UNooWonM57NlSRYdmqom+Vsl7TfX6DpQI1syN80es2YFTXBsoSLM9ewdvsH+992
         FmgsSBQcOc3Yxc6toWsrdgYk7fMkgNZ3b7cyaBWfIhnx3v6yYuZNAdYQAPp0NHoeuxU+
         ZCt+/v6L6NqXl195H4CiYtPMaYMvwtX/qwjwdKt1yHVY/GlA3NsLLET9ALSWKZIYvk32
         DULL/NRoTSMDJ6qJiDFzl/d4YuDb/s7mBUSrH0jb5c2geFzaK/SS3ot1hjQIEp8k7lDA
         QrVg==
X-Forwarded-Encrypted: i=1; AL+hErE6rNxF8cHe3JPTwAinunmCgyOjQSkonSzrOSCKYxs9l2n3+PMrlJGTS3Rx893rJDpPG2I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/T7EsXsD9NAeuXWUIVvFZ0Q6jK6cQQmvbrZGRgy1snioDy0nyf
	UmMKixrWP24xWIw9EFJtwlXt+/Hf63XISQvqh9ObT8UMIsPhal56XAFU94uABIkT5EbHdvs2J+Y
	I7Ggn/Pri/A==
X-Received: from dycnr5-n1.prod.google.com ([2002:a05:7300:e9c5:10b0:369:fbca:f649])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6191:20b0:375:e4de:96d3
 with SMTP id 5a478bee46e88-3869e61da0fmr12560688eec.31.1795567919715; Tue, 24
 Nov 2026 16:51:59 -0800 (PST)
Date: Tue, 24 Nov 2026 16:51:08 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-20-irogers@google.com>
Subject: [PATCH v4 19/19] perf test: Add inject --sample-buildids and record
 --buildid-offset shell tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add shell tests verifying perf inject --sample-buildids (with basic
samples, callchains, pipe mode, and kernel samples) and perf record
--buildid-offset across per-thread, system-wide, workload, and callgraph
modes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/inject_bid_offset.sh | 179 ++++++++++++++++++++
 tools/perf/tests/shell/record.sh            |  74 ++++++++
 2 files changed, 253 insertions(+)
 create mode 100755 tools/perf/tests/shell/inject_bid_offset.sh

diff --git a/tools/perf/tests/shell/inject_bid_offset.sh b/tools/perf/tests/shell/inject_bid_offset.sh
new file mode 100755
index 000000000000..9be2e3323558
--- /dev/null
+++ b/tools/perf/tests/shell/inject_bid_offset.sh
@@ -0,0 +1,179 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf inject --sample-buildids test
+
+set -e
+set -o pipefail
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
+sym="noploop"
+
+skip_test_missing_symbol ${sym}
+
+temp_dir=$(mktemp -d /tmp/perf-test-bid-offset.XXXXXXXXXX)
+
+prog="perf test -w noploop"
+[ "$(uname -m)" = "s390x" ] && prog="$prog 3"
+err=0
+
+cleanup() {
+	local exit_code=${1:-$?}
+	trap - EXIT TERM INT
+	if [ "${exit_code}" -ne 0 ] || [ "${err}" -ne 0 ]; then
+		echo "Test failed! Preserving temp directory: ${temp_dir}"
+		exit 1
+	fi
+	if [[ "${temp_dir}" =~ ^/tmp/perf-test-bid-offset\. ]]; then
+		rm -rf "${temp_dir}"
+	fi
+	exit 0
+}
+
+trap_cleanup() {
+	local exit_code=$?
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup ${exit_code}
+}
+trap trap_cleanup EXIT TERM INT
+
+compare_script() {
+	local orig=$1
+	local bid=$2
+	local msg=$3
+
+	perf script -F -ip -i "${orig}" > "${temp_dir}/script_orig.txt"
+	perf script -F -ip -i "${bid}" > "${temp_dir}/script_bid.txt"
+
+	if [ ! -s "${temp_dir}/script_orig.txt" ]; then
+		echo "${msg} [Failed - empty perf script output]"
+		err=1
+	elif ! diff -q "${temp_dir}/script_orig.txt" "${temp_dir}/script_bid.txt"; then
+		echo "${msg} [Failed - perf script output differs]"
+		err=1
+	else
+		echo "${msg} [Success]"
+	fi
+}
+
+compare_report() {
+	local orig=$1
+	local bid=$2
+	local msg=$3
+
+	perf report -i "${orig}" --stdio | grep -v '^#' > "${temp_dir}/report_orig.txt"
+	perf report -i "${bid}" --stdio | grep -v '^#' > "${temp_dir}/report_bid.txt"
+
+	if ! diff -q "${temp_dir}/report_orig.txt" "${temp_dir}/report_bid.txt"; then
+		echo "${msg} [Failed - perf report output differs]"
+		err=1
+	else
+		echo "${msg} [Success]"
+	fi
+}
+
+test_basic() {
+	echo "Test basic build id offset injection"
+	local data="${temp_dir}/perf.data.basic"
+	local data2="${temp_dir}/perf.data2.basic"
+
+	perf record -e task-clock:u -o "${data}" ${prog} >/dev/null 2>&1
+	perf inject --sample-buildids -i "${data}" -o "${data2}" >/dev/null 2>&1
+
+	compare_script "${data}" "${data2}" "Basic injection"
+}
+
+test_callchain() {
+	echo "Test Callchain build id offset injection"
+	local data="${temp_dir}/perf.data.callchain"
+	local data2="${temp_dir}/perf.data2.callchain"
+
+	perf record --call-graph fp -e task-clock:u -o "${data}" ${prog} >/dev/null 2>&1
+	perf inject --sample-buildids -i "${data}" -o "${data2}" >/dev/null 2>&1
+
+	compare_script "${data}" "${data2}" "Callchain injection"
+}
+
+test_pipe() {
+	echo "Test pipe mode build id offset injection"
+	local data="${temp_dir}/perf.data.pipe"
+	local data2="${temp_dir}/perf.data2.pipe"
+
+	perf record -e task-clock:u -o - ${prog} 2>/dev/null | tee "${data}" | \
+		perf inject --sample-buildids -o "${data2}" >/dev/null 2>&1
+
+	compare_script "${data}" "${data2}" "Pipe mode injection"
+}
+
+test_report() {
+	echo "Test perf report consistency"
+	local data="${temp_dir}/perf.data.report"
+	local data2="${temp_dir}/perf.data2.report"
+
+	perf record -e task-clock:u -o "${data}" ${prog} >/dev/null 2>&1
+	perf inject --sample-buildids -i "${data}" -o "${data2}" >/dev/null 2>&1
+
+	compare_report "${data}" "${data2}" "Report consistency"
+}
+
+test_pipe_report() {
+	echo "Test pipe mode perf report consistency"
+	local data="${temp_dir}/perf.data.pipe_report"
+	local data2="${temp_dir}/perf.data2.pipe_report"
+
+	perf record -e task-clock:u -o - ${prog} 2>/dev/null | tee "${data}" | \
+		perf inject --sample-buildids -o "${data2}" >/dev/null 2>&1
+
+	compare_report "${data}" "${data2}" "Pipe Report consistency"
+}
+
+test_kernel() {
+	echo "Test kernel build id offset injection"
+	local data="${temp_dir}/perf.data.kernel"
+	local data2="${temp_dir}/perf.data2.kernel"
+	local kprog="dd if=/dev/urandom of=/dev/null bs=1M count=50"
+
+	# Not all systems allow kernel profiling, so we check if it succeeds first
+	if ! perf record -e task-clock:k -o "${data}" ${kprog} >/dev/null 2>&1; then
+		echo "Kernel injection [Skipped - permissions or support missing]"
+		return
+	fi
+	perf inject --sample-buildids -i "${data}" -o "${data2}" >/dev/null 2>&1
+
+	compare_script "${data}" "${data2}" "Kernel injection"
+}
+
+test_record_buildid_offset() {
+	echo "Test perf record --buildid-offset consistency"
+	local data="${temp_dir}/perf.data.record_orig"
+	local data2="${temp_dir}/perf.data2.record_bid"
+
+	perf record -e task-clock:u -o "${data}" ${prog} >/dev/null 2>&1
+	# We must have the binaries in .build-id cache, which the first record does natively.
+	# Now record with --buildid-offset.
+	if ! perf record --buildid-offset -e task-clock:u -o "${data2}" \
+	    ${prog} >/dev/null 2>&1; then
+		echo "Record --buildid-offset consistency [Skipped - not supported by kernel]"
+		return
+	fi
+
+	# Verify symbolization resolves the workload symbol
+	if ! perf report -i "${data2}" --stdio | grep -q "${sym}"; then
+		echo "Record --buildid-offset consistency [Failed - missing ${sym} in perf report]"
+		err=1
+	else
+		echo "Record --buildid-offset consistency [Success]"
+	fi
+}
+
+test_basic
+test_callchain
+test_pipe
+test_report
+test_pipe_report
+test_kernel
+test_record_buildid_offset
+
+cleanup ${err}
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index e4789e2bcf43..80cee3eedcc3 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -740,6 +740,79 @@ test_ratio_to_prev() {
   echo "Basic ratio-to-prev record test [Success]"
 }
 
+check_buildid_offset() {
+  perf report --header -D -i "${perfdata}" 2>/dev/null | grep -q "BUILD_ID_OFFSET"
+}
+
+test_buildid_offset() {
+  echo "buildid-offset test"
+  local ret=0
+  perf_record_with_retry "${perfdata}" "check_buildid_offset" "perf test -w thloop" \
+    --buildid-offset || ret=$?
+  if [ $ret -eq 2 ]; then
+    echo "buildid-offset test [Skipped not supported]"
+    return
+  elif [ $ret -eq 1 ]; then
+    echo "buildid-offset test [Failed missing output]"
+    err=1
+    return
+  fi
+
+  # Expand test coverage
+  ret=0
+  perf_record_with_retry "${perfdata}" "check_per_thread" "perf test -w thloop" \
+    --buildid-offset --per-thread || ret=$?
+  if [ $ret -ne 0 ]; then
+    echo "buildid-offset test [Failed per-thread]"
+    err=1
+    return
+  fi
+
+  ret=0
+  perf_record_with_retry "${perfdata}" "check_system_wide" "perf test -w thloop" \
+    --buildid-offset -aB --synth=no || ret=$?
+  if [ $ret -eq 2 ]; then
+    echo "buildid-offset system-wide [Skipped not supported]"
+  elif [ $ret -ne 0 ]; then
+    echo "buildid-offset test [Failed system-wide]"
+    err=1
+    return
+  fi
+
+  ret=0
+  perf_record_with_retry "${perfdata}" "check_workload" "perf test -w thloop" \
+    --buildid-offset || ret=$?
+  if [ $ret -ne 0 ]; then
+    echo "buildid-offset test [Failed workload]"
+    err=1
+    return
+  fi
+
+  case $(uname -m)
+  in s390x)
+       cmd_flags="--call-graph dwarf -e cpu-clock";;
+     *)
+       cmd_flags="-g";;
+  esac
+
+  if ! perf record --buildid-offset -o "${perfdata}" $cmd_flags \
+    perf test -w brstack > /dev/null 2>&1
+  then
+    echo "buildid-offset test [Failed callgraph record]"
+    err=1
+    return
+  fi
+
+  if ! perf report -i "${perfdata}" 2>&1 | grep -q "${testsym2}"
+  then
+    echo "buildid-offset test [Failed callgraph missing symbol]"
+    err=1
+    return
+  fi
+
+  echo "buildid-offset test [Success]"
+}
+
 # raise the limit of file descriptors to minimum
 if [[ $default_fd_limit -lt $min_fd_limit ]]; then
        ulimit -Sn $min_fd_limit
@@ -760,6 +833,7 @@ test_precise_max
 test_callgraph
 test_acr_sampling
 test_ratio_to_prev
+test_buildid_offset
 
 # restore the default value
 ulimit -Sn $default_fd_limit
-- 
2.56.1.831.g720f3f5937-goog

