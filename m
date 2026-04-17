Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020084.outbound.protection.outlook.com [52.101.196.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CF9282F18
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451595; cv=fail; b=h/1VnExZY0R7JSaXoYQ+F/zA+LJaadn5wZ8/9+TUla3FzITpn95IXcud1nf5qAlesb+FRIejKDh+oW+SjEG73+HvaKHz+Dn4i7r9OdFjVcQeHQwrZHOCcmvzflxN7Wflp448SlqC/oUzTF2VGSo+MoFjquSTv/XI0xNAuiGoVFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451595; c=relaxed/simple;
	bh=umGSuby4sEfoWQLDT0RcJYoX002NBgfIpYkJTGnES8w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=osMQR3V8QiBoa0aWHnVxwxVafeK/GrcNNGDkuIxRwNZy3OqWqSeRtIcUsi2QJ/pOUkAWfGRBv7E9VagE73HuCObzk6CzDKDuipLumFva2AYznMyqWn1zm8QYAjV5n7+6nQdIXMaCHqYs5Ur49QE6xo7Y7wYO9fZ5JZQPWdrEitc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Djtf37DhbD2XzyHH4bbB+VVuZJnwEhVfySa+cxe9pnGnIrvqn/vVwLjUKs9kPGNaBRXAwuW056wiTbA1hJzSBaFq3P1V7f4AB59FyEA6Dq5ORrdTcxxB0ecgjETF8Q9pMfevbF6EW8TG5inI0kHCbzN4aRhy12MC9Be/wpMklk6DB1PLVunV/2gLc44ibl0rewCGpCVBc47+WtHaVxzyzwj3KPyRlPNP8UoM+GxcafyxnrVCB+LLbLrsM8VCVmQV1loxTGpA5Bs1DmHMfXtfbxXfqWyRkkM/bh/cCoyWkhFFtdsobvbRmotJGmBmaNEW1FV3RiLu3FLLRNvIHEdLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hVgxsVbXcI/AOoS8N3hsYIJbUaGMD8kZR4WEPRzWQs=;
 b=fEbkbjbJNemf/K6BYMOs2qVpbgJud8Rk3M9prG2TVbGc1O4mBU7lMPjM5esJsJ4rnWL8CCX/979cmWg+E97RHzVecsxcn1GN9tYQd2X9+FjfgWGLeTZMrw8pWBJFHHnCrWSVjvWFuX380wP4Ge9D6epBW5kGF/dDNazRogGZg9xN7LecDnGV7fnALXFwqDY3v/HJ+h1sUGnpEuRJIuGvQSFu4VMsLy8oJo/KOt+qvx2XEg0ZCsxacsIlPCog5mNvoIOOjJpoOH1rTu6lWGQzJmYzmElabJeoU2C3iTXRTCUqoSRuIiDlb8CsIz1jkwgtTAN1nrO10KbfIzU4Q3tKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB5942.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:242::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Fri, 17 Apr
 2026 18:46:30 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.046; Fri, 17 Apr 2026
 18:46:30 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: bpf@vger.kernel.org
Cc: atomlin@atomlin.com
Subject: [PATCH] libbpf: Report error when a negative kprobe offset is specified
Date: Fri, 17 Apr 2026 14:46:27 -0400
Message-ID: <20260417184627.1259158-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:208:32f::33) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdf8bb7-faf8-4dfb-43c7-08de9cb1a37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	MfqzJyBlz8xtntBBMSTcjZevg0LnO95CdxFrS8y4li+PZrGI/o6Sl1gL2YULO5w+AjCbTKgWOuepmOl1toP/VrLY3lS2aAdKeHKz6CStbsNQ0uud9IP3WZbdHqcG5QWohm00YpqlHt/n5la6ANPKsvEbpiajjSlr9wVnzSKjQbIVw3NwpiFfUo3tSvBO6iBj/Lj0hvj4oVXuI0jGoZDZD0DejFhkTv5gMt5JiLHS1nsM4FumAa9UoXzVHFcjOilqzZo8HRrp2q7yWmQk+IuxtzSxnFNq8ThEP+0JVjVbc2wmGApWWb1Ph2j71KNtjqrtRM3eLKkWForrn3UWhbooPW6FmpbBxY19hpSjMZKZkIgyZsUGUHEb658EcDD1Dku/V1gD2io6Ic1a4kGH9mXs3rUPsh8RpVM2tXMvjR/YpEf9IqZMOrZ/F0eSVwwsAU1PRStbAkPFvEoSSUkEugbA4/y3TX6ZozYRils7sRrlwWHLhlUOa26wOyb4YAwS5suQExeslDtB644eB7yw9Sz8nHv/djCugrtrM5V92NA7nz/EmNnOiRnkmBlSYUP8VUS4vUy1832ABzaro39IxiBpphDSvxBB4aKOTq1tJoN8eRXcCAAjs4/dZ/Hgt+Dzj9UToxX6M41UXl5lSiZR1Ycw35PhphkFVPHhzYMD9SVT1ZKzN8HT6x8jYqPak063nNBcg0gtzD8q3oCKV3Bg2wWTnXWyqJhJ8wN81laeptpjOFc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hm7uYthsc3wg+vDHikpIf8x1xLL19Tw5ipCMPLxvGLDRMtDZ/ecPq9NM8/M0?=
 =?us-ascii?Q?JLom9tqEu6pIFzc8GEfELdmhCq0an5jqvBfsLztEu8PjGfxb25f+Up73HOCC?=
 =?us-ascii?Q?u82APPUYG/T51mAjQREe6CNXgfok/dsSe/CLy6IdkNc2IoOLUQgaiIDT7iTg?=
 =?us-ascii?Q?8Sj5SzL+jWCqEHPJv9ytLyxnIV/Xvie1uMkWqEw72ZmtLFOkMSgCas036mu6?=
 =?us-ascii?Q?TQMSlihwIvuXZHwditcYMkK1pNjLB2oTvsVSG2OujphdoyFUCsUuS9Ov2LvM?=
 =?us-ascii?Q?k2iCLj7KpTW4103TD/IXR5wtgIHrHOtklvU/gPtgHF6WBfQcZlwB/g9oaYmU?=
 =?us-ascii?Q?hRswLBY/GcGEtn99ygk49hf8JisvUCVx3sJnHlzDcOAJGIQ7p+T6KV8zTRid?=
 =?us-ascii?Q?YvaVtgDZ0cnk/eIwHWBdqYLUfK+fI6Nyqo49vkSkYMmoW5JGxPxVmq2WIv92?=
 =?us-ascii?Q?VNNmmLakiJHVh9y6HVXyv+dXkUpqwV+ZDgMKC7nUajQHOx+XBm9eoHpTp+RX?=
 =?us-ascii?Q?KxDDiXqODvv4DdE2+TgfGeqPBf6g7dlAD+JYeAfOif3AS7Xst1PtbpXFLtbs?=
 =?us-ascii?Q?AqaEVUc3BGISHU390Tg/qrqF6jedYWMYp4hZZbI8FEOTep1fjUxS3NHOdpq9?=
 =?us-ascii?Q?wT3l5oepFlSvlFslQVfRXxeEZclI8ULxqcKVXMddTNR2D9tEKkL3J/AsSU7c?=
 =?us-ascii?Q?tbLe1uvL3ks4sR9JBBJTN5z2We7BS63vb97kWwxL7p+tuk6qaYYAve2fJUnE?=
 =?us-ascii?Q?sBrepWgRfQhWAgU9wGreDg+bJi3jqAVeQyWqGSJWwYb21K8IQNuy0T7CzWQX?=
 =?us-ascii?Q?AJxamyhpz7FFR87gmLidrQTvZhM27fJSolddNs2B/CPRPdeFWrkY6AdkWCpX?=
 =?us-ascii?Q?NAEEm9NeHQoxz/2H1ITqzixispEE9ErlhEHwKxdrRvxL5Pl5tMhg+V1lJ0Dj?=
 =?us-ascii?Q?xRKYWN6lKpxbdbaCeoTlv0R3GwbFMfXJsSCxvPUzY2CPK6RJ/WTKnl8YGpvm?=
 =?us-ascii?Q?PgjCo0KxGHOFN+EE+Yzt3iCDEa0e/c8CYkhnwbg1zgzgQDgM5CLXdCP2e79r?=
 =?us-ascii?Q?yXypaF8+dRARSjahVKlz9x34xc58CDQgL6mhb+hGFava7veALMaeYXu/Yb14?=
 =?us-ascii?Q?QN6AedCRkFKUDPczlZnsa1GSvqBlyp4QW48LVeDwkN0tfdDGDOH90RRN92Y3?=
 =?us-ascii?Q?dBEcuaeVNmHDQDfKBL90VpR94x88IR3Sxulra8VDbL1QSVY9gdBeQjulGcU3?=
 =?us-ascii?Q?RP1no7rlap2S2fBcvBOWytOEluJ9cDj9HjejuMwHN0SspdABYSX3x4tj5fiY?=
 =?us-ascii?Q?ZJzL7Y3xURw/weTw1czd5qm4n/zPKDvALcPrLDlottFk2vpSGSpZOMdDSMm+?=
 =?us-ascii?Q?f+mOeTF4Rd4pdpGzsXCAqY38m9KEWtBAzu7Kvjic5EhCr2f9Log1ajIw9Zgh?=
 =?us-ascii?Q?EMmEqAjX9GdPE0yNMuq5o/zUjgU1C4SuhGl//g9n9CXCedVgQcbuy+UIIjKQ?=
 =?us-ascii?Q?oC0rbDsCwiYi9p0E4ip0oLd/kUp/L9G2Bb7uC0xRZViF/5MqA96DE9paGqAg?=
 =?us-ascii?Q?Hiv8qTGYuSCCZMxE3vQ60NKRqNpmTQp2z5PdS+FQSo/gL1cfjuJ0Lwpsw9Xj?=
 =?us-ascii?Q?uQiVbZ51radrEtK5vK9xiH2rnOPvPvQi6Spvxn+L2N7yWMJlTdLjtXT6IuwI?=
 =?us-ascii?Q?1kRCRBCbNOcvQCWqdRbkuv0Aljk1O9ZS7HjoghOtdswmrA2753+pCNhKfF9J?=
 =?us-ascii?Q?rDp4CB0V7A=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdf8bb7-faf8-4dfb-43c7-08de9cb1a37b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 18:46:30.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDbM/RLQusVc3fvZJRy9uNzU1LVTu3THVjHO0eew9gXaGu455xupBmrWutYkAW3vwa6ZTaW6iIL74mBUmMtBUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB5942

In attach_kprobe(), the parsing logic uses sscanf() to extract the
target function name and offset from the section definition. Currently,
if a user specifies a negative offset (e.g., SEC("kprobe/func+-100")),
the input is not explicitly caught and reported as an error.

This commit updates the logic to explicitly notify the user when a
negative integer is provided. To facilitate this check, the offset
variable is changed from unsigned long to long so that sscanf()
can accurately capture a negative input for evaluation.

If a negative offset is detected, the loader will now print an
informative warning stating that the offset must be non-negative,
and return -EINVAL.

Additionally, free(func) is called in this new error path to prevent
a memory leak, as the function name string is dynamically allocated
by sscanf().

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 src/libbpf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/libbpf.c b/src/libbpf.c
index 42bdba4..cd250fe 100644
--- a/src/libbpf.c
+++ b/src/libbpf.c
@@ -12271,7 +12271,7 @@ error:
 static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
-	unsigned long offset = 0;
+	long offset = 0;
 	const char *func_name;
 	char *func;
 	int n;
@@ -12293,6 +12293,13 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
 		pr_warn("kprobe name is invalid: %s\n", func_name);
 		return -EINVAL;
 	}
+
+	if (offset < 0) {
+		free(func);
+		pr_warn("kprobe offset must be a non-negative integer: %li\n", offset);
+		return -EINVAL;
+	}
+
 	if (opts.retprobe && offset != 0) {
 		free(func);
 		pr_warn("kretprobes do not support offset specification\n");
-- 
2.51.0

