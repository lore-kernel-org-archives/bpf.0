Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022092.outbound.protection.outlook.com [52.101.96.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50173CBE89;
	Fri, 17 Apr 2026 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455905; cv=fail; b=YDSAegC067XKR3GYpb8fmPzO0X/gO0JeCtj+mJ0w2TeggaJfgZUHcSyjhA7KfsbNUX9J7YITVZqI1o3OY0hLe5xZQWXUyFnB5e9IJWdvKQkopqSVYJG8aLnIgS4AfOKjtW4RY787472OqrjRqnQ3bGYU3uKDCAudYwPY/hNgJGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455905; c=relaxed/simple;
	bh=wmMqcsNd42xnTrDBfMrgt9RLC5zaf2/jaXbZg6I2UYA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BLU49qR7Vr2up6HtJpotxE34umbjlabCtmFgbN58GqRhBK7WkBBhVnBF/8voYmjTxDJENRtpbDUoXp2LmLq/FeTQ+vW0irrCfAlx0B1xwuFusQ52UMg1bf7hMVJSzPH535xq9V5yl/a73e1dyjxa12MWa9UdTFRYeLZOxqmg+7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNo90x50Z8QmcPT5yrrvdb3Bddd39koUzsOfaXpITLH6EedkvEI3uLZ4KWOZF/QPyscvYMpRr13ENvlDCIlvpDyicFPO42C6LGTTe7yGNRq5BCWbRpcweJgmmyCpYD3MoxeSPYTB19q+yGIqTiObloE5k8gFagvnxKdbufZU7zr2YPCS276XZIKX5w4bbAq5wSzFulIiHT3zl4zSeBi5KCouwvYK6cyeuoHMVy+MSXrSo0rpVlBsuCwkbdzh6/LMuTAnBh8mVEnYsUEuu1u0f6piE/0t6yCZ/Dyt+DCXtlGL2OA8RiMdxrxymtU2kUkx7Ew3UJOftzD+8FHpnNt4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCMnjgoXcgRxgiiM4ExeUD19Q8RdeRJaB11dw322kD0=;
 b=Xv7g2w/kCPRpxfCzAbPT64pqt4ETKkEx4G4+ivHj8UFTgoYa1/NlHSVV3W1Epa+vQdJIStzih3Nz0Y5suNxi1u/cRRUfxFAW/bfXpQx9AeMghsq1NB53PK1S3IvITtxxwcagK89kkLoB2yCfx/P/X8vhhi2UjB7e3hW+V9uLk3ysnFDH9JoKVTpvhvSxIHFaYpgKhq6jqrPV2jmwmnLT37l6LVBbVHRvQzk1z10qotgpwe4ox99FYGaykrucvYqC8h4WOQLGfyQ5AiI+Oc+ugzoDv2fLpCyNvSrJpx0elWh6275BXfX/o5h20gGEu4zPqpVJ5Q9dcAm0Nf8po0GP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3334.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:84::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 19:58:20 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.046; Fri, 17 Apr 2026
 19:58:20 +0000
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
Subject: [PATCH] libbpf: Report error when a negative kprobe offset is specified
Date: Fri, 17 Apr 2026 15:58:16 -0400
Message-ID: <20260417195816.1265179-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0110.namprd02.prod.outlook.com
 (2603:10b6:208:35::15) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3334:EE_
X-MS-Office365-Filtering-Correlation-Id: ae00bc83-5fb5-43c7-c2ce-08de9cbbac7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	r3iTa9UlkbmdAsK79gwYbiDHxNjXiBViIxXU8oEpfGult277RvH+3toYn8+4fKKFB8qhJermEhR/xJ0vjmQSP6/9iw+ZhYUId+cGZQIfet3CBKMhhmfOtT/lietSt1EWszwum1N81OtFoMDyogtSIL5EiGH7bt/dai+v1EPYGJNGh0ZezTendCww7hSWCI79HPUSQww7d4msfLDdSawHPegU6JB2r2IQeRBrhxR45MRr8+CoGH5gtj4lCw7x72YRAjzGBWrjZc1XJJGIG+rIPkEGEI5CTihkw7I5lufeYSjRVNTlICTGhkg6xtfVK05zVoTMy0VK+fXet/+qMcQQG51EelP9LOC2nE0g+lw4GicWuxGcrmzefuT0BAdZxJIF1uquHy6lvfeFBW7SKau6eqzDAY4aTuxjHcVnYUw7Gdky5lghh7AxDmVYYZ2TkGsXUS7TzE8WlMZAsWhQXlW/PdUm0D0bMPKKjnskFLarCcHtcjSlCWikEPIEprtAXrFUlXhUvLzuhbPYLfqL1iYXzGZpkcJLURCSAMgPM8xW9a6rfr1s+QtCrqpCK+DFIiMYVvMYxun68YpyJ66+KlnoZzcyjXV9xvzz6oIQNBFbIF+BfVIPPAbk/ar9rGszgAeg7o1DjtFPmdotH9k/Qpg/Sug8WUFWI9bOs/r4Bva7GOFjAhXxPH3T1fP/BJ/vbchcH8Yye8LZ+/rCJMlYqeNcD7badvIGt0G4GkRkvEWazyc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dhR5EuiWuDvo5q9QZZl1i7sfutWcFNNjwf24+AEdPTu4JI39s5MtfqcwzEML?=
 =?us-ascii?Q?qrTDp0gl4zgo1QEAAjo0m0QsyECHd23PHszOdlvcojHfEwJn6Xsb61/NoASx?=
 =?us-ascii?Q?AvMkaMdFvKdN/5awSIEayxDGEEnaaBGbdbDZL8iuVAUBS0J/2UKRtwCWka43?=
 =?us-ascii?Q?7ZbkvHmSD7LQMx0s4QRNVeAUMYqOGi5SegJnRPuOTs9e+GXwjH/DjVOit4Xt?=
 =?us-ascii?Q?dVe4xADPnaKmxwyLSxveXL5e0BLuy85r8grYx3xEAv4IzZM4vR2xRZDampwB?=
 =?us-ascii?Q?/dNsjIbYFW9vd9dQY38egmdP8rLL2CBrXai18y6KA7abs81apCGjqpASp63a?=
 =?us-ascii?Q?xA7JdWciiAOQZzryS3tWHjyoJ/lEYTNSodKHHQBDv+5ni63xqqlJV2XWVaQ3?=
 =?us-ascii?Q?Go8gp9qEIqghf0/54beA46kyc9fXIcsYs8BjPyq4jZoudlRDk8RxMI3GfNfC?=
 =?us-ascii?Q?IxeicELvQpZjp0vfN8p+2icc8+N7syfr8KxhgqB1LrdoVUPELnEDIPx44OA1?=
 =?us-ascii?Q?uYSY07RUjpG6QOGMVmSqp7cAqnIB2jGzZ0NJaugXiR+gnM13baUQb/EjJ+zQ?=
 =?us-ascii?Q?Zho7XDHLRhArAogSDD6yPTOt8x/3vju1iZ1LCypcRmk6fCqIq+ltzjbCecAk?=
 =?us-ascii?Q?yctZy0k9REyTcTqHQ/10GPEu6DvfYaoauHEmGHESzGl9vkoaGQyQcqFfpYtM?=
 =?us-ascii?Q?TQolqZwHRmfTa9OcqfgMXNcrAfCk2V6+cU+lgCt0Dt2sEHXdEtRLenEEzeBm?=
 =?us-ascii?Q?hV9mw/GNTgHx3ISeQETzxTn8zr/V113V7WeMLnXBkQz5Mhn2Ha6SyBqOcykc?=
 =?us-ascii?Q?UfpUHiAL1AqRhAc2yxl//dndlAW7HE2kFRNPNPQBxbRVYY+p9MNxACsRgUyh?=
 =?us-ascii?Q?GO1MIEAlQSyBiPHKinhkeVqZa/gRigHqFPbXimb0g//ZM2TsdFeQEqpxAM8p?=
 =?us-ascii?Q?5tfqrgVzG/IouqY6/ZCTD4SSYoPSK1Ean8kWRdsS4Ial3mfxiDAW7SI0Lq8s?=
 =?us-ascii?Q?1fgr/CGiOt1bBJHaxEZC2Xh5O5YUmBMqvBtHXhdKEzVIFKfGn/7S7CKoOSIy?=
 =?us-ascii?Q?8uAAqHGT1VozugvtOdIB4wsOcA+Lm9Nj0qvV9urPDkLJtojhWQQsDD6Ybuvt?=
 =?us-ascii?Q?OUCjj65CQnz/3JsPTHSo3g/t3KUS+t91vwxWgRnukWAkxrNKah3XENa+Tqtj?=
 =?us-ascii?Q?naXUwuQKQoJs6tf89dILAwSzpF3c644kCmrmKt5VcTgsPcw0j2J0X7V2TmDO?=
 =?us-ascii?Q?wkocQQ7TJz0LNXIChPuHenmpFrQkZBi44iiw7eq7hyTbwZwJIr2gmg6cJxVj?=
 =?us-ascii?Q?jZ9iytwx7fGZY+nux4xrPWdOMncg8ajWNDJNFGtOUcT1Dv840nfuE4/zuuqB?=
 =?us-ascii?Q?PRZxfhZH9rWwhUCFpkh6QUPDjpxoyy/qv8rLrQtPu2GLs4jnNon9+bHBIRsR?=
 =?us-ascii?Q?Z141s+4eGTgP8+cZNTBi//MIKbf6AUy+06jHh1xgLBrGs8tYlzc3Hv8ohjYl?=
 =?us-ascii?Q?6qKdcfkLbcb4LejRvh1kUAZNTySxKkGyH7YgrKh+7Sc9WC2RMPevb/C5m1Bh?=
 =?us-ascii?Q?Ru6F4vFKeivqJNDyWsrS+V8pLy/DjxA4LQv1ti47tY8gWE9my/lKwtRdjq+d?=
 =?us-ascii?Q?WwdsLh3ytrp+O0h1PiGrB9xBkPhsc7Ltledox+kzVhaqC978sqgIO45+RRyI?=
 =?us-ascii?Q?XAbc5khBLApN6d0X+wIj9T3THHvJUCIRqOtTNwnf3NkHU6g5T0ogXLj/KTir?=
 =?us-ascii?Q?etEpJJDgvw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae00bc83-5fb5-43c7-c2ce-08de9cbbac7d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 19:58:20.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2eh9ewyqcccxacmyvA6KEJg97GRgOFcuMzpWHPG1mlLC6JMhdopWl0GpAp0i0ElzBxqi/RRgK1jZ+37a2ZYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3334

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
 tools/lib/bpf/libbpf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 42bdba4..cd250fe 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
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

