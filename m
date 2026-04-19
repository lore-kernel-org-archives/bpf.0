Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021087.outbound.protection.outlook.com [52.101.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90F2DF68;
	Sun, 19 Apr 2026 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776568193; cv=fail; b=TpncFUAVr1xM/Y1Ft4URbuceq6HgiP5wjeH4ptuRdkEw14utLgHTIXj8dp/kNnxNEuOquMFtcj3AAvlAc6c/gurKvHrMkr+z2T3gTOgyRTg2VgKUwFBMn9n6/TbybcQk/ehreIMInMhfELLz7uuBB6fpz0mOihxguSetR1XhX0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776568193; c=relaxed/simple;
	bh=wE6n3r8V8y6NIHLNKu8i7KA/RbWMisd3HU+sxwHl7Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GUu23SVHob6oqaADhiTtK++03wBfbqvT7UeWXq1ZIxxSaboYQCiIMFINLAvDIcIbbb78nRJUaQYtgtv0gGAx9tsTjfkzr0qCPeaXNs1ZLIK+kUi3pYBgS9oLVSMLeSLQT2JPjEJcuVW8MCK91a1vc65SFkQgrv1/FLQI7f9xxeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3TOBC6Exid+pMdKnXkApBFEG7p0ZPWdmBMwrDNgMkKcC1RtDVEb3oIUz81kHrfjrXZgZCVtFPjlnLyDf0vP9MGHr7U04UtPV1IR/kgL1ufN4Yd+ApRleEVv9k90V1CzOMaHKZYXfXU8x1RMNcOUIzSdf1jsgmGmYBcTdRXHer47Agk1F+COa33oxJNwdy9Oiv1O5QmyM1T2+WF+1FxZ9wyn32gi5Kad/8e5z93wywyXYPaeHokS9KqKgtEAhhiIb2JOoNrjUM0hq2ZJbx6bvmUvh8UY/36dom1tvtZE8kCrEzvdF8ftdykRaORiHvt+wXBI5P0Ezm+KC28HDalNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbLqW3d0dW59EEaD1awUmAXj9Fn2ErQkxUal10w53xg=;
 b=ovwdfxh98G/zGQ1Uy4UMN1qi9s+DfNtWVRu4ZyfW9AZJs7z57W34jCx6XTQGG4V++UAuCP7iwRaq2rNnssAMciWy411FtEGe0B7goP4uXFTyGl+3Z19wbLfaTjDlS6ccfdB5okK0oQZ/ySbypKdlHej+S/hhqqNcm4F/D3YKUUtrnFlDogzXG1UnGtE+vE/Cktg7ZbXXa3x4B+nYbMz9HllyClW/BPGkohVJaLULBZR74jhlYwZjkTLvVLySXP8VSJ+6yDVSISxBC/blZ8c8NOIaL0ypcX0QRBxI+nAu1Eps8IQfyHW42x1ujEWO5aGhzs8EuDXJTriBB+YSxPOKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB2845.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 19 Apr
 2026 03:09:48 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.046; Sun, 19 Apr 2026
 03:09:48 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	atomlin@atomlin.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3] libbpf: Report error when a negative kprobe offset is specified
Date: Sat, 18 Apr 2026 23:09:44 -0400
Message-ID: <20260419030944.1423642-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:408:ee::19) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB2845:EE_
X-MS-Office365-Filtering-Correlation-Id: ab55238b-eb71-4702-c425-08de9dc11d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	u/6hijDbIPzNAztV6kolfXCeCbfaqV6ceW9G7fiz8C6Ysfen2lzxOLBjByLdvAhYMoIJkL6iNZOMY/HGjYnqkTYj3E1pqXzTaJ3MQpKLs9PIqF3++hp/4n9ov9Ey3fDLiJSSKabvjLx2arTMxgIE/RgqVlLXgUXwbUAbrspfSH46yBCA1sFi1jV80pNPDs7ZmlnVytEYbFsHqCjy5hAlBZDUhlvXcHI05mWL/H1zv2gdxeaGZK/+hj/Ur1RWgIROMu3pGvT4dsyuFRaM2Mk+xjESOuehalon9nAV3KH2NCyyjwEt7fmERDEkoujfo8cHNrcoMG6c56y6wi8b7aso/q+46GF2zuIf6KxSR4ol9NXUAWKOI0wUSNSla/TJqJ4BeMENIKLKhaBogwdwNQaYu1m7TYBfoA4fe33HM/pSeO/k/f8poRAB+Z+GyikTnCZdaKlquCINfCQhu3Z35XvxR7WYISmTy7pCdcfF6n2x+CpXwR/C0JQMmAzMd5AV+/MesEHQqHr1pUlIP5rGYQH0gLt+CnDxwwIWxceUPltWa8ycvhOmRVne2N9YSPVnIfjwzDJkAAjjxAgNLLgsyiBez43avAgXhj8NFyOJeWD33Tw/OnzNz6m98Hh1/a1vNaPzLJXLUYNTb2ejGpXARDL0aYGr7lcgj5yCcAcqGfNEmcqNiBrYEiDTwv37mUNn5BqO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZHBvDNxvNIkmen96QT6jcpJmNO9oiDjTgYvq/yXApFfKWmIlahOVh+XYkybK?=
 =?us-ascii?Q?TF0hRZisg37BJy411lPKrbvA6GiIRbXzZSE7kDyKsIcjxCdTtL+oHs/lce53?=
 =?us-ascii?Q?SV58LwohLe9T2Ya6Bz9gjAmbucvcvyfiCQAwJiQ903lj7rmpQHgT9HWG97BX?=
 =?us-ascii?Q?tKVJOJYHethLwcjIgPwlQRH5Qv6RpLY7kxezQxUQeOFV1lOPF4b+ETw+fGhK?=
 =?us-ascii?Q?k7pQnHC2PSiXi0piH5XC7NabIwZilktgEHvh/wOyNSYlEuyTlo98JXbTgPET?=
 =?us-ascii?Q?W8MKPFs/e6SRyMwDStlVqX03MNRVpinu9z+LmaLtoy70yfuu4b6YXWkxFRJu?=
 =?us-ascii?Q?RX1j+xFLI98YDFin4QGxf74UTeJE36uH4I5aRiwaYo+vqZKnnEF+rhmF7S24?=
 =?us-ascii?Q?P0Be0CyvSBQYp+Yqt2K4rHCPWNVqsyUbPHTDSYZ5mPb8hOPO4F6WpZHkd074?=
 =?us-ascii?Q?Jdj8/geFT9LXWiKG0YL3acSBCf+Wfif8orVV/lrvMHZhfAtGBN0oI0J8rH0f?=
 =?us-ascii?Q?OSxbyKf2HHqCcj0LYWg3ptPUR7JfDwKaJaRAaLwieIIgr2QhNN46xXcU7635?=
 =?us-ascii?Q?gGligkZKm1/UNCQab7vJVYxDikJ0yb40PvipDAz6Wkh49R0Rgz4d2hcAbXv0?=
 =?us-ascii?Q?eGM3zeeddrxOdXDdPrJkSPRjrFCsCNQQn3GImHvcG4RrTYvmX84qHhNB9VTk?=
 =?us-ascii?Q?NL2pQ0PjzOhKGPnZQgmz+/waiDLSixgtCuDE92yVBQJcXA39XdDgGKhsy83u?=
 =?us-ascii?Q?6E8Ej4VpR1lh09w5zMcdPOocaMsbKlvzgJ60MzQOq1zp6Ew04CyPGCk/DQ5J?=
 =?us-ascii?Q?tgoHD8j2i8vxkyydlvKhtz4YVb3ia1EykLM1WrbQIadO4+uyDrepwO/LBB5p?=
 =?us-ascii?Q?aw25cWPg+xH5CVoAa3G/Rmg1ojocolwB68qoRO0V/UNYaDzHo0Ab2SiW9TAV?=
 =?us-ascii?Q?Angdw0B+Nmh2zrMTdRbTxRpeNHRKMhSaUD4hHc57fxLV8oSVQgsEng7SvAyr?=
 =?us-ascii?Q?ypRxHvUXJqHREjQI6LWw5HJUObvHtJRxVCW2grh51hJcvc2uZ4SRQQ57NmA5?=
 =?us-ascii?Q?StU/NfTNPMyrJe3ARdeUOQKyCll/y7TeTARWw3p9Whkbeyq42PjL6yYELrfr?=
 =?us-ascii?Q?mNNs4HX71FNRc3LUjrm6sBNW97IlpX9ERO9ehyMuHi5V68ZwWCqJhd7qkc84?=
 =?us-ascii?Q?GPr8re6FLoKiTTlv0/HfxRhyk28zuxjepik4SDKwXVPKiY8G7OLTmq16win6?=
 =?us-ascii?Q?fU4qIMzTJdJCI4vS92wR/TOUTxY8vjeD8P+l2B1BB1u73HRAACyfZQCKrkc3?=
 =?us-ascii?Q?ZlNyTkHlWD0xL+Qmxvf/yZ9nNXH6giQpjaZ5gOzQ4xjvepF7aXYo7awnNqc/?=
 =?us-ascii?Q?7do2Qo5TAifAE6XdEhADu8Xw9jdE1Wmvri2q2ipUWtA2jYzQj/xrbSVwOOke?=
 =?us-ascii?Q?4l/gOOEB8aXUr1I84Gho6dRvhXwkQXKI67Pzm54OnySbCWsnOB+pder6Zunn?=
 =?us-ascii?Q?0rOU0EfAusbSF8EAxJlWQuBOCDJVSF2DXR/7FrpQDItS5BuZlqw7318Cju/N?=
 =?us-ascii?Q?6mTqqhNVbJ6V/sFUDbfWFEjsbUl4ZvdE0um4HRUikyUW1CSDahp6jo/Z2Tm8?=
 =?us-ascii?Q?49nQrQosgttK96dLAJWWPRHa1YGDJ9scaHAA9+h8FpVIM17nrmUrH1Ymied5?=
 =?us-ascii?Q?xXnvVBDj4IuZV39cOYt3ALv1nVQGiagdVTrLNaHdw2RrtmjzMWj2UqWUHUSj?=
 =?us-ascii?Q?RaY1nJen0Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab55238b-eb71-4702-c425-08de9dc11d67
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 03:09:48.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4McS13z8lAN5q9XOT/XIfMlLcYdm5NPz3BKkRj7topb6FZMuDJfQbxxumeDPOZd749JCtp3E8YaA32E/0DtqOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2845

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

Fixes: e3f9bc35ea7e9 ("libbpf: Allow decimal offset for kprobes")
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes in v2 [1]:
 - Corrected subject prefix to target "bpf-next" (Mykyta Yatsenko)
 - Added "Fixes:" tag (Mykyta Yatsenko)
 - Added "Acked-by:" tag from Mykyta Yatsenko

Changes in v1 [2]:
 - Added omitted mailing list entries

[1]: https://lore.kernel.org/lkml/20260417195816.1265179-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/bpf/0a8afc43-dfd8-4aa0-ae94-a82f8c307599@gmail.com/T/#t

 tools/lib/bpf/libbpf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8b0c3246097f..af81e0e200b9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12279,7 +12279,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
-	unsigned long offset = 0;
+	long offset = 0;
 	const char *func_name;
 	char *func;
 	int n;
@@ -12301,6 +12301,13 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
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

