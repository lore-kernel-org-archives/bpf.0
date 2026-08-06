Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C641D23F
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050695; cv=none; b=gCJfvR/yBbfuISt2LmhgX+k0+HB/Avqe93m2H59UAj6r7+Q5vxplwLZkceZ8vv4sgR4clQ0B6OHtx0tTO6ZZ7MUkLwtZlTDIsGBI7/ZxS537K7naIuxActU9F183LTuFhyw0WCrG1AbynA0j9mD3eXZpT6T2768hdT/pe8TcZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050695; c=relaxed/simple;
	bh=KLgnLshjNI9VcrY29EQL1ZXYEYozQCdQuXvrSRjhX1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWB8cJINlBZwkrF+8GzO5fY9IS8/lk82Q2utRVTNgKfkguaecTWZ8HHNvg38E7WmVvVqMQTkJuBCNAShqO0SweAGkg13FO/fDzIVLtJr/Nu+l+OuAmY9J5GYEDsTpQvSe7Y5jwhuz5SKunXPtu1NTt2q1aYXXpgikBH3oiYdkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qc/w2+o5; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qc/w2+o5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786050691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W3TW40QrzhbAh9lILrXSw9Kq2EMliej+rT1aztAAw98=;
	b=Qc/w2+o5LkEZYSuveWEiWtkg048QzzpImS3iUsZxByQES3+qKdQAuUUxgAwQJnBYL0K2nU
	jqfoL//4tQmKBeFVSGg/Zz5lOigSwGsb48I4ebKa4OkcZQo0ygoR5d45zXvRf5sKsdgrGK
	xfRVHdhNsQAO/AWBzJzTa6GMbBBZjwI=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next] selftests/bpf: Sanitize traffic monitor log file names
Date: Thu,  6 Aug 2026 14:11:05 -0700
Message-ID: <20260806211105.3307932-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The traffic monitor names its capture logs after the test and subtest
being run, replacing '/' and ' ' so the result is usable as a file name.
Test names are free form though, and other characters make it through.
A subtest called "INET4: bpf timestamping" produces

  /tmp/tmon_pcap/packets-125-15-net_timestamping__INET4:_bpf_timestamping-net_timestamping_ns.log

CI systems that collect these logs as artifacts reject such names.
GitHub Actions' upload-artifact fails the upload with

  Error: The path for one of the files in artifact is not valid:
  ... Contains the following character:  Colon :

Replace the whole set of awkward characters in one pass rather than
adding another strchr() loop per character. Note the loop tests *p
before calling strchr(), so the terminating NUL is never passed to it.

This came up as a side error/annoyance when trying to re-enable BPF-GCC
CI runs [1]. The CI side already has path name normalization and needs
some tweaking as well, however fixing it at the source also makes sense.

Fixes: f52403b6bfea ("selftests/bpf: Add traffic monitor functions.")
Link: https://github.com/kernel-patches/vmtest/actions/runs/30710914503/job/91399011388 [1]
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 tools/testing/selftests/bpf/network_helpers.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index db935a9d9fc1..3818cec354a0 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -1142,10 +1142,13 @@ static void encode_test_name(char *buf, size_t len, const char *test_name, const
 		snprintf(buf, len, "%s__%s", test_name, subtest_name);
 	else
 		snprintf(buf, len, "%s", test_name);
-	while ((p = strchr(buf, '/')))
-		*p = '_';
-	while ((p = strchr(buf, ' ')))
-		*p = '_';
+	/* Test names are free form, so replace anything that is awkward in a
+	 * file name. Besides the path separator, this covers the characters
+	 * rejected by CI systems collecting these logs as artifacts.
+	 */
+	for (p = buf; *p; p++)
+		if (strchr("/ \":<>|*?\r\n", *p))
+			*p = '_';
 }
 
 #define PCAP_DIR "/tmp/tmon_pcap"
-- 
2.55.0

