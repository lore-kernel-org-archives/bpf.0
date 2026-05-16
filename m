Received: from outbound.mr.icloud.com (mr-2002g-snip4-6.eps.apple.com [57.103.68.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC127EC7C
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778933211; cv=none; b=T4FfSyxAiItsTv24v+iqtpCKRXIQ0ri9c0Hu10ytLgnlkDtSKAJRR4M5clwRPdKCKUpBByMuBqn5nNOVcNvcP+mDph/MPPanqUgNZYTJ0707ydeA4aokI1hzRE1fsUekVT9jqxlk8eVUMR9a09rP1E9h4tVxlDObrasru9rsTsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778933211; c=relaxed/simple;
	bh=bkitfgbATV7muE7dLlUcvmr9xMuCmbEgqgAiY22qe8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R7xOGg8j5ASGYQ8Tt3J58abMDaYvyHJx7B2fi7PDGN5PPM4zwwBs0JBlmQI8R98gIzzifRyIClK6HJjUICYhNMCAtFaW52L0i1DS5zVNMLnP9vk5Zad/dP03JRXGCmSSw0LovjFVPLwbzEKPXkMkFTr4yl1sO5XJBooa+ftOzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvasnytskyi.net; spf=pass smtp.mailfrom=kvasnytskyi.net; dkim=pass (2048-bit key) header.d=kvasnytskyi.net header.i=@kvasnytskyi.net header.b=sTwzVRL0; arc=none smtp.client-ip=57.103.68.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvasnytskyi.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvasnytskyi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvasnytskyi.net header.i=@kvasnytskyi.net header.b="sTwzVRL0"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPS id 7B02F180017B;
	Sat, 16 May 2026 12:06:45 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFBHVsPRQBDAFYCXQZLVxQEClwAVgVyG08ZQANOH0EbQBEdA1IfEhZdRUECWgpcMFIOUh5ZEkYDUgFaQ1kORlBLGw5cAktaFVUXDgJCH1AfTBZXQ1oZHBlaFFwYU0VRH1RYQxlFVmlBC08dXRlbHEJkWFcJCgBEEUoWShlEAEsZFxZWGRcGWxQERAFdBV0CRQhOAl8HXQBFF0ADVQRSH0EUClwAVgVyG08ZQANOH0EbQBEdA1IfDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvasnytskyi.net; s=sig1; t=1778933208; x=1781525208; bh=QNuhYDnlYFZZgAg9TfiK4gX6cXQQKz0Ik93tJj+M/aA=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=sTwzVRL0/De253VX7g+vSjdeojP0LYkM5Uhe7R+fVWSy5fd4/JdOb+yvTf0/x2xqCeAbz/KmCac0SbfETg/RT1VYXGcqFW4p2kLCkzqc/Jk/Jq4TirG0C0exVEx3Kxoiymn9ph/g5hPrGXIw30B/mnHVMH+gqplRep9VU9eXjdlDe4X4uTL/qkrmUjwU7bkfkACcOI0nAjHaJarbDWVpvB34EfJzOJAdzlnvZBFndrnNWPiNs7H751byQf7hJ/uuHLcKTgyaSMcpYasNA0jqrhm01vbCYJb8gMvkUyb6JEDCl6oerD84pY1km/XkF/AlwB4hPHpAs8QZabd4XrqfUQ==
mail-alias-created-date: 1743450725635
Received: from periecle (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPSA id BC93C1800106;
	Sat, 16 May 2026 12:06:41 +0000 (UTC)
From: Roman Kvasnytskyi <roman@kvasnytskyi.net>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roman Kvasnytskyi <roman@kvasnytskyi.net>
Subject: [PATCH bpf] selftests/bpf: Reject unsupported -k option in vmtest.sh
Date: Sat, 16 May 2026 14:06:25 +0200
Message-ID: <20260516120625.80839-1-roman@kvasnytskyi.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nH-lzb8WrWMz4XOfNm1oqSXTv0Mgol4_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDExOSBTYWx0ZWRfX3pDR6/+SI2Zy
 sXu9KJMta2THkrjo3Vys1QUSvA5pGt/NPMy89Q4bG0s1z5nzPoyNvAClXNB4RU4CvwoXhJgohmi
 eglyIj8fJvFrOIniylg536uNzVSsiAijAYc9usf5c1OV6nnS2K+eqbk9HxHRdkQe3pkSBWpPXzK
 isCtrk0ojMaHknHjFvOD0ZbOsnFXSvQRYG8MFYeAw1MND8fj0s5ejhOyNIZK5i7FFcAJtJUq9Za
 rrZ2yPgoua8UpLUWhdCjV/eUaRyoY/Hp3O3+xVxvh3s+uT8CGX+NJ+1j+Dw+7TC62fK3prjhJp1
 O+2RLjupuPcFeOtA44DZy/2fzoZ1XL6EQn3HPHFE1O8jdpVVFYuEpijm3rUgi0=
X-Authority-Info-Out: v=2.4 cv=IfyKmGqa c=1 sm=1 tr=0 ts=6a085dd7
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NLb4dWRdAAAA:8 a=UdcUEC0rSNdnLTSpIWMA:9 a=A-tYh6_xkEhJBr09wb0_:22
X-Proofpoint-GUID: nH-lzb8WrWMz4XOfNm1oqSXTv0Mgol4_

vmtest.sh does not document a -k option and does not handle it in the
getopts case statement. However, the getopts optstring includes k, which
causes the script to accept -k silently instead of reporting it as an
invalid option.

Remove k from the optstring so unsupported options are rejected through
the existing invalid-option path.

Fixes: c9709f52386d ("bpf: Helper script for running BPF presubmit tests")
Signed-off-by: Roman Kvasnytskyi <roman@kvasnytskyi.net>
---
 tools/testing/selftests/bpf/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 2f869daf8a06..9ca802285393 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -382,7 +382,7 @@ main()
 	local exit_command="poweroff -f"
 	local debug_shell="no"
 
-	while getopts ':hskl:id:j:' opt; do
+	while getopts ':hsl:id:j:' opt; do
 		case ${opt} in
 		l)
 			LOCAL_ROOTFS_IMAGE="$OPTARG"

base-commit: a828abbb897657451d96ad7bf20f1893ac983bb9
-- 
2.54.0

