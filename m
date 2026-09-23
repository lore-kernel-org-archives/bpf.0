Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE093CF67F
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206200; cv=none; b=h8Wos7XG3Xjb/hTPPph8Qb0siH3e+tV2nnYPiLeX3KaHNaR0ynDgM3cK4CcGLwbj1gCbe5psGGK86Ufd4qmxxbkELElUWgrLvkFiAgfILh1uHznfOoZsq+eK3o02FZnl5noZFJrcLvQi4RCjto1abB/YaFmMuzeQAdWjGP+0aSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206200; c=relaxed/simple;
	bh=0FmFm10fiZY7qZzHE/7biY3fPi2nq0w48I892H9NeNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlDaXVEyo6PwMk/Uu4Fn9VRgmU7GbhMi8NsoOrWW+glLeWHNrXd/ke7aRurO1gMrWo7VOhF5n/15pixwX9eYWGXcwd05SoLlRY2x1nCdQBlOFGkRA6cANMkeNX4wNYMXHNQV3Q0BaNxMA8FZiWTxTPyTwkEuXtWsjzHTDQrnHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=TBUZt54+; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="TBUZt54+"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NKm4Fh858067;
	Wed, 23 Sep 2026 23:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=kzT9H8amvOpub039MfFt68gV+LJlFriZKGgtMYmpTUA=; b=TBUZ
	t54+p8LA3edpTEeC4fKdmE93QVusjoPdhthJYlpzbTWKTerJ8NhHetZ1ifTvLVd2
	7gvjy5WXuVqT50YFLPoVdm3VUbn575AF5uz6laELTKyhTd9BfdE37P2O6KX0CXLN
	2SjHlNsEm5Tyd5Wbc8/MknWEQxz8b0o6q0k2609ZVt74Yq14oqg2ZzkGvfSG7AYn
	mY3IEAe1OaGNfZ/twHFSDnio4FWWJ87H5FyTQPSeeS3/l5r+V5GFBjN6SNdf+54C
	b5HA4zTJhcfGQY+hLsIfK88iK+p89vi7wczgPtDgGSGyyvQOyeTRXYOkK5uQZKZn
	PMcT1QpHfNoh117C7g==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gvp4ggck3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 23:29:44 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:29:42 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v5 3/8] libbpf: Support declarative manual load via SEC("!...") prefix
Date: Wed, 23 Sep 2026 19:29:34 -0400
Message-ID: <20260923232939.1886328-4-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX3GVyyzc5pDO1
 yKBOrbbYvvHM2DgPyS7nJssCuWA7itk5ystjraHfml3YeKlEdNliydmZ/F4m6Tnyhvi/mM3YVqu
 eDkvOu90YfnQLFLOldTzhwiWvXZR0Gh26x23PyxEU3ggMMbU4vgoafw8OonW+1Aqp5+Z4uU6mXq
 XKn+egYhE0koUAtm7/zteXJlqfRiw00PIO9mYqrp4TeuqD8NVv9HJ8ZiJc3pVjLbXQO6Yh0Taxg
 kvUHS+fYS+heMq3AEQnpw6CoIqjOXs/r+cH+zTHENLgcbpgVDhpxk8vLXEIbDQHkYJNcJl1nAad
 CTD4aTIAGL3+O5GomxMi6MKDTxnszJ1qWVp6zSX12uTfbf6lYqT5vmfwZf4VWhvdImO4F2+n3Df
 faVnOB4AUo7JMkRwDgE9aYVDm3Von6CL5CZ1NbxTTHVi7nN/ELzZK9EjKJg90GEsob9aEVXwiU4
 L2hfvwLjlNx9AVy0KHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfXxrx/EvS8x+xl
 QEDhprTpnayIi465LzE4nbvhdVP7V3tHwOXeJgsMLJ3GPoWcUFC+WzNDxwhp0mCwrxQrAXN0noO
 9A6wdTofFc00k+IyuaTQ9dQ9Z5a9vEUGhOybubZHPLBon0s9u+Uw
X-Authority-Analysis: v=2.4 cv=Edpd0/mC c=1 sm=1 tr=0 ts=6ab460e8 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=LpP_590H9VDjBmbmCXQA:9
X-Proofpoint-ORIG-GUID: iYaWZob9h68xqcXt1aHV6oZFEI3o0vI5
X-Proofpoint-GUID: iYaWZob9h68xqcXt1aHV6oZFEI3o0vI5
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230095

Add a SEC("!...") section-name prefix, letting a program declare
itself manually-loaded in its source instead of requiring an
imperative bpf_program__set_load_strategy() call, following the exact
convention already used for SEC("?...").

The prefix is recognized and stripped in bpf_object__init_prog(),
before find_sec_def() ever runs, directly setting load_strategy to
MANUAL and initializing autoattach/saved_autoattach - the same place
and same style '?' already uses, and before BTF or sec_def exist.

Assisted-by: Claude:claude-sonnet-5
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 939f0d6378e3..d815e53e8295 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -889,19 +889,29 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	prog->fd = -1;
 	prog->exception_cb_idx = -1;
 
-	/* libbpf's convention for SEC("?abc...") is that it's just like
+	/*
+	 * libbpf's convention for SEC("?abc...") is that it's just like
 	 * SEC("abc...") but the corresponding bpf_program starts out with
 	 * autoload set to false.
+	 *
+	 * Similarly, SEC("!abc...") marks the program for manual loading:
+	 * it is skipped by the bulk auto-load pass and must be explicitly
+	 * loaded later via bpf_program__load().
 	 */
 	if (sec_name[0] == '?') {
 		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 		/* from now on forget there was ? in section name */
 		sec_name++;
+	} else if (sec_name[0] == '!') {
+		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_MANUAL;
+		/* from now on forget there was ! in section name */
+		sec_name++;
 	} else {
 		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_AUTO;
 	}
 
-	prog->autoattach = true;
+	prog->saved_autoattach = true;
+	prog->autoattach = prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL;
 
 	/* inherit object's log_level */
 	prog->log_level = obj->log_level;
@@ -15469,7 +15479,7 @@ int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_
 		 * A gen_loader implementation is being called for autoloaded
 		 * programs and defines its own model for loading BPF programs.
 		 * To pass a BPF program to gen_loader, set the program's load strategy
-		 * to LD_AUTOLOAD.
+		 * to BPF_PROG_LOAD_STRATEGY_AUTO.
 		 */
 		if (obj->gen_loader)
 			return libbpf_err(-EOPNOTSUPP);
-- 
2.34.1

