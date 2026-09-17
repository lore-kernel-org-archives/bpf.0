Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9D4CA79E
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677050; cv=none; b=htaJI42IcJCIicXYQ6ylbUaXymsf0LwaLOnGsa/yxeNUJhibUxi+YVtO2/ziUetCNOBmBKV0/rn/sjKo7lZ3iBL3YjKcQvbZoSsz+HT9g1hmVJgLylVKnvdtY2Zxqsa3Q9o5kH71SjtiwQCvbaJumQN2T5HkT3his8Q+0FPxMe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677050; c=relaxed/simple;
	bh=DvIqwJPqDaRO0Eip3gWBLv4S95Dr+zM5gNwZK/iEQ8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2BB/4uhB3PbxRsQrhTMmmKoluHWmObTQQdPGwGmD6heY97cGlM+3cQVWCb4xpirZ4f+YYNHI1Nca1+DV6cUmDmt0ph8aYDSorzyuK6jh9XbhN79DgC7BVFoUo9PGNaQMk8y21p9ONJv3q12+tsjXZRQmW9aY5zMmlzLDt4RWf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Z7vG7qy2; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Z7vG7qy2"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHZPkY271740;
	Thu, 17 Sep 2026 20:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=YofMTygOd9duPmYCpeVPLLncm4axK2O+FnStcJzGWyM=; b=Z7vG
	7qy2AM/zu0j/KqZvmEYrOLrZSATjZy23uS5z/Ikw2x3yyjUlXAOkA6qdGizKjfnK
	v5dZrvXy/XUU2isAvaAPwBXRQKhKtSAQP1338K+9PA4u/hXw7bN5DUW49+oBtU5t
	4U7kxwGcxn75J8FSGK9Qz648cyULFSuuBbS43mvtf93mbUGtZb5T0X369AlXDL7x
	aap3gcEhL16W3/hamiluslj0fpu52XKIdXENr3mm/orDM6g2hc58lgge81rt3LyC
	cnmhrR8L8Lw7+w7xtMJEnDnKZHzMuAmmy4wcPgL87Ei4nH8Ncd6yWlKUYX3Uy6di
	COBdy8AJWZrQ5RWZpg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4grmr60rk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 20:30:46 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:30:44 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>, <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v3 3/6] libbpf: Support declarative manual load via SEC("!...") prefix
Date: Thu, 17 Sep 2026 16:30:37 -0400
Message-ID: <20260917203040.3150212-4-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI5NCBTYWx0ZWRfXycaryR/duEp7
 cCHBDMxXnxq8tbapa8rhgL7Ir0jzC5nurCJ7gRT/fHp6W9nShkYp7q6p9+7ALLYAYvOJoSpyaU1
 vIjO6aGQQpHUAYh/sXCpM2sb8DYP+n438aT1BIGdpe4P5uzNG4O6
X-Authority-Analysis: v=2.4 cv=OcQNnRTY c=1 sm=1 tr=0 ts=6aac4df6 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=LpP_590H9VDjBmbmCXQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI5NCBTYWx0ZWRfX/RDNDwzw1x4g
 fYiFjby1xsbcXttwaGN8kNaEFeiyZoD/ak06f6WV0HQhvXx4ORGDs/xiLrZ5rTOIYd6b3zE5yDR
 WGzeaaLNvJgdCm/vmfvCfPy5Q3S+1pJb0IJl8BT6OMKfiAH0D3TMcrWjRfy4kj8jNjSLo+sChRH
 voDuF3sYb0+6HRHKW217rWdGl0wq+2hI1E4tgteMirE27Sl3D+RkNxnIwWdxIJd4M7xwmYG2sfr
 vAvIrg8efmujniP/JMRU8ZNTLNLayB9jydwSFaL/4zRRgH214jIgJmoauRf9bSjJ6/uyxujC6Z8
 lgQGibokXmEQWDS5LhU/kjuAEW1OQbF6TcK0VuNpLdgEOp0RRjwAI4GsgM4iTQgwBT6lhVH4EMb
 gMDKi0DhwERzOMF6r4QrUnkrLb6ii4e86R2cJk2JrBZCib0BiVnmdydVJIUJvMaoPPSaVYCWBO6
 AGSJWI68gWecDZqvajw==
X-Proofpoint-ORIG-GUID: _aolAJHDnmwQyBbfPrlFyfiSFjvTELcI
X-Proofpoint-GUID: _aolAJHDnmwQyBbfPrlFyfiSFjvTELcI
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11908
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170294

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
 tools/lib/bpf/libbpf.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index acb8caffa442..c9a184d9626d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -872,16 +872,25 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	/* libbpf's convention for SEC("?abc...") is that it's just like
 	 * SEC("abc...") but the corresponding bpf_program starts out with
 	 * autoload set to false.
+	 *
+	 * Similarly, SEC("!abc...") marks the program for manual loading:
+	 * it is skipped by the bulk auto-load pass and must be explicitly
+	 * loaded later via bpf_program__load_manually().
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
@@ -15287,7 +15296,7 @@ int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_
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

