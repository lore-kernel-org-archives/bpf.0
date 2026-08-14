Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021110.outbound.protection.outlook.com [52.101.70.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD91C46F4BB;
	Fri, 14 Aug 2026 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711791; cv=fail; b=d9iG/KyRf8/0y+sAVVYM0ROKASLA0UZp/55e39xQS0WzLlPWca0eS8BPJ63EEcC+R56T1LzvXnOWsSAyrjMkNKjaqvmDcXcmKHv0j78iyS6MlhMhW2e3RUfodLA3zdRyDU9+GWY3d9VistokgR+o4spbgREYb9llj6jQKHgEQOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711791; c=relaxed/simple;
	bh=GVMquoG6lzze7FFbJwWZVUJlxc/xSyJ/zFap1bMfsuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gVj5r8N9/97IEQO3D/1hF5LQOMpZbn6G5csCtrvmugRYVjnBoQUGa4aNInDFuJiiEWykSQJk+FxknelDQBq9mS70ed8Nl3L3C+yiwwIuV33+5ueQ3vpuNPj/RD+OphSpV4gfESgn3bmqabI/4SVGAqfgR2M9BkI1Ag+Rc9n9Mx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com; spf=pass smtp.mailfrom=btesa.com; dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b=Qy1qXvpD; arc=fail smtp.client-ip=52.101.70.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=btesa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b="Qy1qXvpD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGLtLtYIRkGTZC5tx61eCi5lgEtaD+x4eAlW8XggMbxcN57+DbfWO52LnKxHwREmJeDg5HQxbiHZE1ZgEpgzIQJFKCQpPWjE+0IavT5Xy4bQnTOArSK4Qwo7dLWJz2vt8qxwb/GCjp1TJc491Wvc4p+0pilB79riG+bQ00QUEHrTxJ7qmvC6bA+qC4UlMrLoTbm8SOcuUL6btQNuZt65+/rv2O7cyc+zldSCPC1OoN+lCbBoh1M22SZ4iyaYNGgu5j8O0BfmGLlySDpDGhRQ5904RLFTnPmLbF9/qkVlVMusZAV0SXiB3ZQ8A+OK+8fMkQPR3k5tmRroq7S1z44u0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpBen47Tq+UkAkD/zYoiLwUKmOO8jcsg0hXmHlkyiNw=;
 b=Z9T9yM4stT6FLBBiGNsfdC4u8WyCzFcOYQCz2OT4oYLAde868TGB3vnOgGJjVtPg43TAoyUu0dmq/A8+On46PTxhf3sa8vNCRxXrcAxnM1wFiNWTVU/NmSUPYbje4KLoo1b/QUr3VlE9565DSp7+Plh6m7Hmphcs0QyDX60Eke6nBzTAJueCUT33IFxPAHM1y+slVjRpjqzDXI1SUVrhSi0QKUZ/3K6GAupRhnlG4hkyAKxqhsdo3AoMZhho/qziHyWMPDKFrNWCQv2UWk3uAghN15dbUFyMeeaUg9z5cM60nbFIpvA4MR0tapXgYIglBNw4cIM/IgXAWtWudiAMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=btesa.com; dmarc=pass action=none header.from=btesa.com;
 dkim=pass header.d=btesa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btesa.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpBen47Tq+UkAkD/zYoiLwUKmOO8jcsg0hXmHlkyiNw=;
 b=Qy1qXvpD8MzBy+xDhp2fq9ZWrTLSONKB7+KfMueCRX19ZlSK/GMh6v6sf5RkcQnQDiUPUAH+agiCIn3r9FjWmuIB4qSYRxsxC7mInt7pfvl1dK7bFx1oZOHLfGZLw5Lh2IaxViKOYGBDOggUaNCFzLCEuQfamXo63jo+Ca052IemaH0e/9gBDugXKYisgeacmQUClB+2FJnPd/aNcqAbdC/za2KrpNic44PfrFT/gvOwAKzwSj9NwykKkXqhBeCDJhsj9nHPx67+F8p5XP8n55bo4QeqBrrcSJvjBq0PkD748fq+JECS2jomNdDwSrVG49m+55sEzoToTpbybJHHfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=btesa.com;
Received: from AM6PR07MB5384.eurprd07.prod.outlook.com (2603:10a6:20b:80::25)
 by DB5PR07MB9562.eurprd07.prod.outlook.com (2603:10a6:10:4a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.3; Fri, 14 Aug
 2026 12:49:40 +0000
Received: from AM6PR07MB5384.eurprd07.prod.outlook.com
 ([fe80::b45:9ec:1126:f27e]) by AM6PR07MB5384.eurprd07.prod.outlook.com
 ([fe80::b45:9ec:1126:f27e%5]) with mapi id 15.21.0339.002; Fri, 14 Aug 2026
 12:49:40 +0000
From: =?UTF-8?q?Israel=20T=C3=A9llez=20Garc=C3=ADa?= <i.tellez@btesa.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Israel=20T=C3=A9llez=20Garc=C3=ADa?= <i.tellez@btesa.com>
Subject: [PATCH v2 bpf 2/4] bpf: Fix available-data accounting on 32-bit wrap in overwrite mode
Date: Fri, 14 Aug 2026 14:48:41 +0200
Message-ID: <20260814124843.22041-3-i.tellez@btesa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814124843.22041-1-i.tellez@btesa.com>
References: <20260814124843.22041-1-i.tellez@btesa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA3P292CA0058.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:48::7) To AM6PR07MB5384.eurprd07.prod.outlook.com
 (2603:10a6:20b:80::25)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR07MB5384:EE_|DB5PR07MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: d534be18-07f8-4d0e-0360-08defa02814b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|7416014|376014|366016|1800799024|38350700014|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OeaGMVcOXtAlb8pXU3VINXTu4zM8ZlICncSovfFZq6+HH9VPVGat+Uqln5VJThCfZZXJOajESFQS+Nl3SKxLbIXfX7jS9TO4crkyyFv2TYM/9o1f14j3aELJxqeKCcyKYUgoBU5W52cGafLZ6hDBDnKK+JdEt8ClkKT3Acz8F/IO9s0Dn72M5BudfMCybFNSADIi3CM8fXoYHm4sxxs1UOnM46v4mJUh6xP8VZjMBqWV0QR4UwoZAGs6S3AXwFmOuFPlpFV+eRg5me36cr5hAo+ps9EEdcIVOtikoR9BBMXa4CIHeXseqktZe83Rs2+SY8plRmWjSFKKPXGPdkoEwpHCNCtDmLhbgf3vqDQtHEGScX4SgQmv52LwBIfU/C5YNcwivJSeufjM1Is/Z5K16DnxECpVHaY/rAeQJoLJ3bTb7RU1fluoONUCCkvwbKlHfrgdZnsZMrzUiu0hwscaw19E+lzEszviDIvZVwF+g4gO+Owo6tav4ago9t0cM+ajZELiKKLm0nIJrR4jJQwxhVQrMQXyPwXb5Cok5uxF2bfrJmlj/BXFhg2gh71b2g53aLUcTJhwnUbFPejVMr2fNSOYd42SHeFnw+i6zBhVp/JVfehfQo/4z/B+8T/PsFthyDZJW5VgYPu7wv2O1Uf1eiTXh1rajNIPAiSHbP347cO0NSFQ4Q5AsNFSH/CE8v2lx7B6cDkXH8Cjmy1ETJBgcwpoKdmf8kp1RAz0HRkKm9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB5384.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2hpNHpwVkk2WFRFeWtjVnlrSGY4NUZsV0k1NEcrN0gvVXlBVGc3TzlwaTZC?=
 =?utf-8?B?anEwbVUwdWVjUDFwMkt6UElnSTE1MGdpTkVIRG1OL1BTRUEyQnN2dUI5WjM2?=
 =?utf-8?B?MEN5Qk1SMU5KTGthUWYzK0lENzVRNm4ycUpJK2wrS3Z3NHJzMFFYQnk0Mi9X?=
 =?utf-8?B?N282RTNPMVVCbUtTbkk1a2JvZWplcCtWL2FZUHFUYVdrVUxRQk9obGhKdDdq?=
 =?utf-8?B?bXA2czJIbEZmVFRDWWlBUEQ4RzZCK2ZlVjJ6SjdNV2xrSFF6b0M1ejREUXQ0?=
 =?utf-8?B?ZUVrZmJYNW0zdTJBWU15ekNvZXpseTMxRng2bW0rUEJGdUVRY3FCTXplMW5Y?=
 =?utf-8?B?eER6VWxvMWYwOTJsQjNPcG0wTFA1MmR1dEVxSVlFamlvOEpOQVhSV25pTmE5?=
 =?utf-8?B?YmVaYkV2ZTByMU9kWFRMeTlzWHpPR0haTW5uN0xobU41dDI2OEo5S1dNUE9R?=
 =?utf-8?B?cnNjVEQyaTZhZU5BMzJLZ2dnSTdGZXlmdEZaazNZZExQOG42V0lkUzNFaW9J?=
 =?utf-8?B?MWZpTG9mNkxEbmRuckw4VG5Rb2g5TWg4T05BdkRVRXZxdTdXc3VGMkR1bXgr?=
 =?utf-8?B?VWF3TUpLcmQ1TUZxZzhUSkNMcmNTRDN1UldQRHQ1NVVIZ0Y4Q2xCb1A3THN0?=
 =?utf-8?B?ekRpeUZNV3JVVFNERFNneXA4dFlraS96SnpJN2dsZUZXRWRLeEI2M283VmRa?=
 =?utf-8?B?MUZ1bzZlSUkyZDVIbkhuT0t2MFdlZ3NBNWs3STRMNGRFZTdXRzBYdnkyUUl2?=
 =?utf-8?B?aTFmSHZVNCsrdVc3TXBkVjVSaUJhbENQdVpXM3RjUzVQY3AwYnZCMmkwc1hm?=
 =?utf-8?B?c3FFdVBCb2VWZjh1MCtvUGhGTm96dEtWSXFEbURsZkdzeG5memlxQS9OdlQ3?=
 =?utf-8?B?WDlKN1M3c2Vxb3NWWUVmWWFWeGJrTXl6Z0Y5YXRDbUlWVXBFYk81c21qVXB0?=
 =?utf-8?B?SWFNeWlvdXF0UWxwZ1p5UVVrWTlxSngyOTVIMnM3d1FOUnNzK3JMRThQb0RV?=
 =?utf-8?B?Y0lJNU9YbkpnZ2NSL0Q5QmxaOUNwVHl1T1pxS3lodzRta2NmR25xa1k2OEE2?=
 =?utf-8?B?dlJ4N2JEMzhocXdMTGVGOXVQSExXanJlTWpTZXQrR1F5TVFFTFdSN2RjUWdk?=
 =?utf-8?B?ZTUwaWNKcFZ6aVRNUTJFV3Npait5bkRrTWNyL2VTOE85T0lENWpxRUJUWDda?=
 =?utf-8?B?emtTQlNCOHJHbDArS1hWaEJLczJKandmZEx5ZGVjT1FHM3IrWjdidEVJWEli?=
 =?utf-8?B?blRNeSsrRThhRTluaGdWaHFVUkJkckFjd1M1VjJUL1NyVTdTclBXRUdVRkVX?=
 =?utf-8?B?QmhsRXJ1eG5OcjNLczlQbDFScmFyYllOcFlZeDJubmI1ZlFIcUpUTzJIM0xm?=
 =?utf-8?B?VEgrV0FrL24vckFCSFZNU0FFcDhxdnVpRFZ2TXJkU0FVZ05aYVdvY1JBeE5m?=
 =?utf-8?B?Z0JGTWJlTzRBMFZleFRQbEhsZU5TT3NkL1F3RGVMZGRNN242aG1mUEZKK1I2?=
 =?utf-8?B?VDczK3B5eEtTMkl5OWJUZ2NHc2IwNllkSnlHamtTeGl4U0trdmZEa01GYVZE?=
 =?utf-8?B?Ky96dm9EQ0tkSkFWTjVCd0xSRENEL2VzenJXWFRxRW0rVnEzTnlpWDh0eG0x?=
 =?utf-8?B?cFFpNTlBb0FNYkYxak1sZ0lqZWVMZUFZa0VsUGVnRHhjZnVmb0M0c3BiWG9C?=
 =?utf-8?B?N2xoa05jZlBHRlNTQnNLMHAyaWVRMVpVUmkyejg2bDduZnFhV2Fia3p0K0lJ?=
 =?utf-8?B?V2Q2RGVickRTd3NYR05tc0RoYVBBamlvbitybkZEVjFiNEUvZThYZjFhWk9X?=
 =?utf-8?B?U2IzNU1iOFRRcCtZMTNXaHRDQjdkTkpIU0tpeXZHSWVJbFZDQkI2bjUvQ01j?=
 =?utf-8?B?ZnJRN0xyVi9pQmJRSGRKK1BDVXNzcGJrL2VMcmZabWR5Z3BuQjl6c3NsczQy?=
 =?utf-8?B?UENrWVk0M2lRT0taeW1ReGlvYXZQSk0xTUU5cUNOZE1Mc2NMMzMzUCtVYmdX?=
 =?utf-8?B?T0lLRHZYSVozN3p3VFZUT091OFNxa2tHRDlLcWRBKy9CRElDSXJaZXJROWxk?=
 =?utf-8?B?TkwvUzdVT3REU09HZVpLa2ptUjJreXRHTnpHK3ROa0VqYzJZUW43UlBGNkhu?=
 =?utf-8?B?eURCejJkTzUwMVdaMm1hbUt5cFpCajRDSHdQOVdFZG94V2JLS2lRc2luNVlZ?=
 =?utf-8?B?YUYvaytmYWl3ZWdUY1h3RVYveERXSkxOWTB6cnhJMmxNeC9uWUI1UFUyMkxU?=
 =?utf-8?B?bXhoeDJnK29wL3lVMHRLMllLYTI5YzY5QXRkYVI3TVZEQU5DVTBSYmlxZjdh?=
 =?utf-8?B?RG9nMmlHc0tLbkRpVU5MNHYzdHBPRjRZaE1EL29RTlFpVFcrQ2JEQT09?=
X-OriginatorOrg: btesa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d534be18-07f8-4d0e-0360-08defa02814b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB5384.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:49:39.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f51efa09-da77-4b78-95dd-fde75cdb9c62
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aerm9X3M0z3X3BtfrbyhZ6Lwz3wMLF1kkod+1QeBX10kqGQjeB/Inu+b+G3Ai8R3lD3dw6wz66OQQfl9eMF4Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9562

In overwrite mode ringbuf_avail_data_sz() picks the newer of the consumer
and overwrite positions before measuring how much data is available:

	return prod_pos - max(cons_pos, over_pos);

max() is an ordering comparison, and consumer_pos, producer_pos and
overwrite_pos are unsigned long, i.e. 32-bit on 32-bit architectures,
where Documentation/bpf/ringbuf.rst allows them to wrap. Once one of the
two positions has wrapped and the other has not, max() returns the older
one: the result is then a modular difference close to 2^32, so the
function reports far more available data than the ring can hold. Pollers
using BPF_RB_AVAIL_DATA get a bogus figure, and epoll consumers can be
woken with nothing to read.

Compare distances rather than positions. prod_pos - X is the amount of
data produced since X for either position, wrap or no wrap, so the newer
position is simply the one with the smaller distance, which is also the
value the function wants to return.

64-bit hosts are unaffected in practice: their counters would need
16 EiB to wrap. Found by review of the same class of bug fixed in
"bpf: Fix pending_pos walk on 32-bit ring position wrap".

Signed-off-by: Israel Téllez García <i.tellez@btesa.com>
---
 kernel/bpf/ringbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 06d3cc192601..0fefa89039be 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -321,7 +321,7 @@ static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
 	if (unlikely(rb->overwrite_mode)) {
 		over_pos = smp_load_acquire(&rb->overwrite_pos);
 		prod_pos = smp_load_acquire(&rb->producer_pos);
-		return prod_pos - max(cons_pos, over_pos);
+		return min(prod_pos - cons_pos, prod_pos - over_pos);
 	} else {
 		prod_pos = smp_load_acquire(&rb->producer_pos);
 		return prod_pos - cons_pos;
-- 
2.39.5

