Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021110.outbound.protection.outlook.com [52.101.70.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BBA470136;
	Fri, 14 Aug 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711795; cv=fail; b=JvKH8UJcAPBXSQBQoajQfqfwEbx4zo75O1WUGOn7EFI7Wb1NWYeNxHoL9bn7ldcmH1P6l/5dyOk6CYhmc4xeR0VzfDt2oIAZa9RefjXzz70l8OxdpUJzVlFAUuQz+ioCmbO6YeG3Dq8OlLb5mfyCW2129AImm7bmaK9ox7qrxxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711795; c=relaxed/simple;
	bh=KMzsPlDp7NpZhxnrtC7XvlZ5+IcXVfv/2Z3RMpaoQRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RLJRkwOgVvTJVHwFvRB31DPyMAuuQ6XcZzcvuosrTdZw4tc7qmRPhv0klVBPsIZ5tXgytCXC7RrrT55VwXVC7etOeESm5UFpgK4d7GsQZfPOVsjW4UDMkSK+gxhDFzFDIEwqsFC1sjaru7M0VGiSOcA6t6f/ei0ENlT/or4o5tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com; spf=pass smtp.mailfrom=btesa.com; dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b=C9E6k4Ik; arc=fail smtp.client-ip=52.101.70.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=btesa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b="C9E6k4Ik"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIsdWMG6BleZXxGixbpFvAwQJT6h4IZdy+SWvFjcS5eVh6vpjceidNSmfL7Jhaz408VllLl33REULOEwx0YZDX6xjxzrZyBW/m6LV/o5/LGSq3IGQQxljGZhlLKDBjluPqNm24XifwpHLB8hsFxy4bGhgeuBuFMfOm/41/oab+WnsWPpJZfsmNvu8lmrtyv+/p+1PhacH3TEbDsR2jub/Q7r2k19cy40pi/Y+tH0NBws1iq4H8yoWpqsbxXMnDQTQAY643oP3fWjoDO6A3RxVvifsYhPgp0NQv3QQb7ab3hP3yDWYe2wC/t0oGdOhuzmItbenreOB9H/9MmZ5iwd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A//WmfDP8jaP9cQL60tcNuZqRYc3P4DRJkuKhkvJP0I=;
 b=ggPYlNw8jhNchV3gmkfmx4OOC2a8cu9gW8q4zkc1EqxPcAHyViuT3GzNhBUBQDlAuWMxzaRkK1kEk+oigx4fPSKNOXtyc9XVD+qNsrmnxYA4SEwB7YG4OEkfgKpzrC5rDrL4FBmA5rb+ks3g2uVAhuyZ/+xzqTZDBkLsBBcpV5QMTffaTiKLvItH8bxUXkWJjsFzuVW647C5ds/otwg8KDBwyYvksqkOhwTmtgeEjys2PZdyGg0a7aIGOEh6rzvTq6TdbLn2BFx1fFDfAlK8aD/wd1CUyQm+s0KHIiQd6blI1EvmuznMSJdC9KSj2Lc0q99wpYIMuBeAcfd07eZY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=btesa.com; dmarc=pass action=none header.from=btesa.com;
 dkim=pass header.d=btesa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btesa.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A//WmfDP8jaP9cQL60tcNuZqRYc3P4DRJkuKhkvJP0I=;
 b=C9E6k4IkNBg2HIm7zhCYSqwEBRlf1mS2ij2Ax/r8EpN+ldANykckC2CwITDHZKE1VByLCImTdiz0RGCgkpMoEymPAkA0Mo4Q82dDuwg2y6d/g9qaqgPEV4iDIGr5iRGdeW56aEBDbBHijuJZ4Y2lHr74f3WPFhrlgsb2fXoub/O1hmQH8pxXTbcqoL7KFYagLc3H5YF+d4WBIfUXlZQvqV7xJymgwFJ8/gYWWXbxriedWliyrbJTH40cKNrATgpjIbPFDoLQarIZpxca3P/1uVq3mpNUVAYW3wtl5x2dLMS5uBHrQnJvf3sTEv7RShXFfautn+U/b7tYTNfwNZlJxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=btesa.com;
Received: from AM6PR07MB5384.eurprd07.prod.outlook.com (2603:10a6:20b:80::25)
 by DB5PR07MB9562.eurprd07.prod.outlook.com (2603:10a6:10:4a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.3; Fri, 14 Aug
 2026 12:49:47 +0000
Received: from AM6PR07MB5384.eurprd07.prod.outlook.com
 ([fe80::b45:9ec:1126:f27e]) by AM6PR07MB5384.eurprd07.prod.outlook.com
 ([fe80::b45:9ec:1126:f27e%5]) with mapi id 15.21.0339.002; Fri, 14 Aug 2026
 12:49:47 +0000
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
Subject: [PATCH v2 bpf 3/4] bpf: Read producer_pos before overwrite_pos in ringbuf_avail_data_sz()
Date: Fri, 14 Aug 2026 14:48:42 +0200
Message-ID: <20260814124843.22041-4-i.tellez@btesa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8a96c19c-38e7-4e95-ecf4-08defa02858a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|7416014|376014|366016|1800799024|38350700014|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4wb+EKwmD+4DA6EnrxvfmLZXf0yWuYblwfzZRxIYojPfAA4LHok9stnC8cR5Smu8coIPp063CQ4tkkIPW9Xi9R0Fhaq7wk2bhid9TOkIORNP3OxkWm8RbPYu/lcKbfLfJ6TgULcxUKbRysXMB7N941gvsfJohv5zIqPtb8cx+eFrVZQka/9BOkEUSlLiTJyYx0LMRRC87GsO0k08b2o5aAfpeWZZmqhjqrZr9wFwp0HYcsPrQZIzDy2r0M/zY1LP5gPuKi1tBkHyLnWcxZZOKPVC9m0zlVXIt90yj+ayEvkW7awiRUAjP765cAnocnS5vJ92QGCzV5THcZRrE3iml3y9MiIjcRhMYp6XiSKgUxkx3NBjkYoZ3yy6mrblE3FVB6JjOO6hKzNxVTuxetresbh5vPO0sCNLBG7gygQEIosLLYvZeAlu/dp56rg4K7sMO3jaPgB+o0yhydaneRmgYNOWjWFDZ5m4qWQ6Lhu0JbqeI8rX/LPRdDOJccIt74lxdi1b+5ef0ulxGze46FGFSXZWeqTT7X+bAoIDNDUaKqRry3rvvIKcgv7CGVaHwgmjeQq82UN2pBjHE5dXRjiCOALJCjHyCxJO1a+FhR2zG2dfgk+VcDiCiaG85uwrtt19dVZ5wIT9UF35bKy/bbKpP5Hva9Lti7YD3fxR+rFfzuOBbUepv/C9D7mED2Lx7FjaFjTsgOw1pzC1dIXzjwuywQxDNYttSKcksAocqw3rV0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB5384.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWN1S2svZ080UmhrZlRZd3JGRER2cVVwMzd1N09KYUVuR0l6dEowa25VVWQv?=
 =?utf-8?B?TXdzSzRyajNqQmhxcEpmR2hidVpzeUI0Z1l1ZXBhZ3FtQ3paYmxHbXU1bjFi?=
 =?utf-8?B?VWJ0SzVncW1GandFNlh3aGF2UlNKdytINHZYbm9sY1MzRjBnMHRpMUdaaDll?=
 =?utf-8?B?dUVvRkpXTVk5MkFTV05TbHpaYWhKMU9zTlk3Q0JCQkw2ZGxVM2VUek1ERFdv?=
 =?utf-8?B?UjNaNmlPV3o1aTRNQUtWa1ZzQ01BL0VlK0F2bzFwcW9hcEZWeTBzaXpEMkw5?=
 =?utf-8?B?dVhuM2d2d0Q5cHR0dUwwNDdPMnZTd2J6RlBZaGtkUkQzMzdMNFI4d3kra0ZS?=
 =?utf-8?B?YkVUa2NwMDdrd1dwOXVHREp4aS9pUmV5RGdENEx6TXBOb3dhclNFUTZuVlRL?=
 =?utf-8?B?TitTMlNCVkhUWDk4LzdlSUNkYzFkZ05jcmFiUEFKamtxajRSTDk2VzF3ZzBR?=
 =?utf-8?B?c2lKWERXdWtyZGNVVks1UkxaZm0wMTFhUlVzeTlMZitZQ09oSjE0SytSeVNp?=
 =?utf-8?B?WGpEdnlidmxOZ2NTdFBPaDlhVlJEL2orZDBGTnJYcmZYcjJ0UjZ6bFo5TEQ5?=
 =?utf-8?B?TndXNFFxcFBVRlB0KzE5QVIyVlBEeks1Q0t3cHUwQVBvZXVPWWhkWGhuY1VI?=
 =?utf-8?B?VzVKQ0RBcGhzKzdtNllCUm9BS2RBMnhnU0NCSkpUeEJqQUN0QTR3S1JRZTJs?=
 =?utf-8?B?VklKZytQbU1kWEVDYk5GRHJqUHVKTnVtSWVzd25ha1MvTlhIQnpoZktmQ2lj?=
 =?utf-8?B?REhIaG1nOWxXQ0xQZ01nem40YzFtSWlaRzNJWHRsOEhjOEFKOGViOUdiSjdG?=
 =?utf-8?B?OU4zZEFxZUpLZkZxUTdveWdPcU1WR1BoZFBWci9yUE9JWnMzbTdzMFdKM1Q1?=
 =?utf-8?B?R01tQ0hXUDJjUmE2V2xGR3diVjgzdk5KSXNySE14Uld0SkltLytELzcrTUgx?=
 =?utf-8?B?RU4ySGRaek1lc05hdTdCaTU0K3VpdnVyaDkvUlJpMlRLUXI5MkFBU1lFTXI2?=
 =?utf-8?B?WHJ6YVZCVXRCSktiaW1kTmVkTE9DQ1lsSlR1Z2tPM0pScDdPdXpJN21LTHJR?=
 =?utf-8?B?MG1VZC9NYlZTK2x2RURzOEg1NG1IbVNiQ1dXU0tCZnNtNGxLcFk4bGtSWGVw?=
 =?utf-8?B?cVVRbytMQ3RLUklDNnVxbzc2dnBxaDJkTDVaZHpJa1Q5TC9QekJzMlYwTDlv?=
 =?utf-8?B?cXdLNnVxQUlEK0RWNWlJL0oxTThXei9SNmNsMkhuS21IY3EzNXNGSDQrYjVM?=
 =?utf-8?B?K0ZhVDF0eGl6ZUtKbEJ1TGN6d0txdVhQMHAvdlMyTUx5VlV4bkFuVzdXTTNK?=
 =?utf-8?B?WDFMWWVNZjRQMk1qUDM3TjRCMlF5U3ZOYVpTRnhVRUtqUGE3KzcybExkREgw?=
 =?utf-8?B?cVNRTGR4NWFtekpRclBva1NyMXNOeVhnaE1qMnQvZElvckFpTURsZ0lxd1JL?=
 =?utf-8?B?emZjdXpYb0pxU3E5NDJmR2VxTDByQ3VSUTlmTXJuOTNxOFpMNm5BU0dzT0FK?=
 =?utf-8?B?cm11Vi9vV3g5M0RwZjU2RG1odTdZdnZzNkxBQ2w4U2JtSWw0NSszRE1JclZl?=
 =?utf-8?B?WitOYVJxL0FRRTd5QWRKMFpsUk1URm43ZGQvRU5RcjVmcG85RFd2QzhmZnNs?=
 =?utf-8?B?WWJ1cDFESEFqMSt3V0p2SnQyZGRodU5lV2lqZGN3YlVBNVJyamxYNTVKSmpq?=
 =?utf-8?B?cllDaFg1QjdDSXVxOFNFOFBCZnlwN0Vpc1FrallmM0FlUGRZWmowTXovdExj?=
 =?utf-8?B?eC9kSWZZdnFHenNLMVBvbGh4cjhpRUo5QXhZaWl0bW5iYWxCdWtHRlovaHg5?=
 =?utf-8?B?TFFnbVlmUUExQ0xsVVUxa1ovOTFpZXF6OEoya3h0RjFUd2xlOWtnVUJTRThs?=
 =?utf-8?B?R2gxK0FldU4wanJXVjdKN1hTeWhQRTAyaTh0bE5pcFBqUWYzSWhYSFd6RkRI?=
 =?utf-8?B?Vzh4WmhDbGJRNEpBekNPeHNKdWZCUit1SjdCZ3V1UlRYLzZNbzZwenZJbVJQ?=
 =?utf-8?B?Mnk3dmk0d0VaSXQ5S1JFVkdVSkVFNWxVTmlEVWpmZ3VYWDYxZ3JIS2dyY01i?=
 =?utf-8?B?UkFnWUoyTHdpOTF4ZVViaGo3QUk4enROb21FUEJWZkozTnJZQitCSGVPdEpp?=
 =?utf-8?B?b3B1VytkQXIxOGdyMk1KR3kxaFVGM0tjRTF1d1pza1ZUVFhXYVpQbzFNRmJt?=
 =?utf-8?B?UVk0Sko1ZlBtL3BnV0Y3MVJ0eXJFUUlFWnFFZW5zWXhVVm44clJUTXZUL3My?=
 =?utf-8?B?MWFmeE5JK3hYZnhJVGxTOXFXOWlxa0hZNXpDVVMrRnp0TnlaUTFpZUVrM1Jw?=
 =?utf-8?B?aGtrTTFwSlRjN1l6NTY5K2JjZFhoYnZOMW04czhOdEVvVVdkU3RWUT09?=
X-OriginatorOrg: btesa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a96c19c-38e7-4e95-ecf4-08defa02858a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB5384.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:49:47.1690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f51efa09-da77-4b78-95dd-fde75cdb9c62
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwlAMlWzwQNvAdwwr+AqJNlhpCFw39pjzTQ0M86Qxj8dAi7JcbpRwRzzW1H/JXS7fGyCWjgYyQdJKuHXa/iBeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9562

The producer documents the order the consumer has to use, in
__bpf_ringbuf_reserve():

	 * smp_store_release(&rb->producer_pos, new_prod_pos) at
	 * the end of the function ensures that when consumer sees
	 * the updated rb->producer_pos, it always sees the updated
	 * rb->overwrite_pos, so when consumer reads overwrite_pos
	 * after smp_load_acquire(r->producer_pos), the overwrite_pos
	 * will always be valid.

ringbuf_avail_data_sz() reads them the other way round, so the acquire
load of producer_pos no longer orders the load of overwrite_pos. Nothing
then prevents the pair from being observed as a stale overwrite_pos next
to an already advanced producer_pos, which overstates the amount of
available data by however far the producer moved in between.

Swap the two loads so the documented contract holds, and say why in a
comment.

Signed-off-by: Israel Téllez García <i.tellez@btesa.com>
---
 kernel/bpf/ringbuf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 0fefa89039be..89a9c15a260f 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -319,8 +319,14 @@ static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
 	cons_pos = smp_load_acquire(&rb->consumer_pos);
 
 	if (unlikely(rb->overwrite_mode)) {
-		over_pos = smp_load_acquire(&rb->overwrite_pos);
+		/*
+		 * Read producer_pos first: its release store in
+		 * __bpf_ringbuf_reserve() is what publishes the matching
+		 * overwrite_pos.
+		 */
 		prod_pos = smp_load_acquire(&rb->producer_pos);
+		/* Ordered after the acquire load above, per that contract. */
+		over_pos = smp_load_acquire(&rb->overwrite_pos);
 		return min(prod_pos - cons_pos, prod_pos - over_pos);
 	} else {
 		prod_pos = smp_load_acquire(&rb->producer_pos);
-- 
2.39.5

