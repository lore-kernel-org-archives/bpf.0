Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD148F835
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030401; cv=none; b=WNEZuOexcZt4u0J5McCmqKLq1TQyZZfdFsEhIk5PipmLHIO4pIkzjs88YRAdr1Koy1ZqS0ZcX5hbICMLJfxG7SB6rdjziGhtMp03yE6ST7i1EA3GR+r5r2cnrBph6eplFaBM1LkZKATz/WuEi2dP9+cT76ta0u5Am5Td5mgwTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030401; c=relaxed/simple;
	bh=Ak46jCvZ2WxrtoTUoLT1M/3WNlcRsblXb7S23JGp56U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBTcWgAVaYZrcLv1eQpVO8a9T2nnOI/0hd5uU4O1qpvhwKWZhPPa+RbKbcuoeLylBgGo1IreVQ7I9CHqSpWzBfS3WxQGNQ2wlkUyIA6jdMnk8QIrJ48s8qbTWbEwBOZobIL0ogmWRvVxOT5issYe23+PQIj7dur7kI8/064I0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=t48tgfMm; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="t48tgfMm"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LHVEjM2637431;
	Mon, 21 Sep 2026 22:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=I6pTffqkS9wXDzkKse56F/A4a4Msj2QvmDvsxVbU9AM=; b=t48t
	gfMm455/gfAced278xQLwdach6PCP9bV7zwL56j8rj7C0CnNEV+eHxYMtgg1laEL
	KspSrW5kaFX2ccsFhpT0zWxdw1I8L0Mm9ZBpCgcBk8UDyVl/YXSOb74r3DsgO1V1
	2dNhrEYGE2VwfmWcKnVn4WdU2LwuBMee3HZTbohl0NQIJOdE5zcNN6pK9sh95lC9
	EFjuG9TL6BKMOnSyMLvqIMs3oQ17xsU3BKtI0H7cV0IaM2V/WWceMCVGSDJkk3LW
	tztd3m6smQouktkJxdDC6Bb34EOscYnOmmoRiWQkCTK4OLYk34oFyYbDNBMtOh44
	DMh3iUelq4jN/peBTg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gu9270yuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 22:39:44 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 22:39:42 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>, <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v4 3/7] libbpf: Support declarative manual load via SEC("!...") prefix
Date: Mon, 21 Sep 2026 18:39:33 -0400
Message-ID: <20260921223937.3203093-4-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
References: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDMzMSBTYWx0ZWRfX8N3UuKCkipQw
 DFZKla9leJhNeCyvYbUHaMSFeiDfMs4wbHLbm4C9pkLKoNysqSFIegV5jHo4+ktydV2jVenobcV
 1lPwTKs5v8Ylstr9B599FXI/Vk3rPqjqkiiV5vAU9i8hecK4DxndoEnjtOlGof3uS8TSDRgFhMz
 cRJn20WTudXj5l9OSwNN2jCCEC2SU4bRMAizclYNRIHZixdh3RhStPsjpxDUZr/smC0+Qg9zR/c
 WOvD1Yt7JOH231YJKeHNUwXBUW/nIhrQtRnZaoL07RyXUKCNxuwAE0mudOI37zOGfR0PVxIFD+r
 bz7RNCujsFBkHCARY4NYkGokzAGU3nREcRCwtiN3nTaa04a2NcVdin01LbzHP2WkBrbUuxLQKeA
 vTztcC/4/wPWxaW+5El0W6amJAbQFTRvMiohuE2aWz/Cc6QNMxzwAPwcXhQ8w8V0gj34dfV6rZA
 u6mkQRgxI1ctshTepFA==
X-Proofpoint-GUID: f4GVdTN11nNE71e56D5Xw2l1wTScBqh1
X-Proofpoint-ORIG-GUID: f4GVdTN11nNE71e56D5Xw2l1wTScBqh1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDMzMSBTYWx0ZWRfX02/evHE8fiO7
 DMgfKFOPzOWzyJifI82MBj7LHG5SMwdGk1DOawXQ9hwShGE3yHXcaN1S+VA+6pNkwkWvfUtXUyG
 odKe5wsibui23Gze0qf7I+8ybG561lveXVVsuntAszfCbIntMDDI
X-Authority-Analysis: v=2.4 cv=BOsmP1QG c=1 sm=1 tr=0 ts=6ab1b230 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=LpP_590H9VDjBmbmCXQA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11912
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210331

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
index 61195d16ee0f..789d2df7eaae 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -890,16 +890,25 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
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
@@ -15399,7 +15408,7 @@ int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_
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

