Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021110.outbound.protection.outlook.com [52.101.70.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80546471436;
	Fri, 14 Aug 2026 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711799; cv=fail; b=k2dm6vv5ISV4pAsfPq34B4/ClkOJ2QFyeU62bNzg/564RWR2oz+XHZ0fr7Ksgb5H9mXJ0lOLN6WnfFizzL0fsyETyFizjxm2/5HwOp1PNNiHOmLygNvZd1Wc0D1CeGzpcdFmBa/+psHmT0YMp2ucwX+nS4haYGOTinThPWOLZ+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711799; c=relaxed/simple;
	bh=BI5/zbG4Vz5qyyJS/5NNaGWRVMqUe6k8P1i8WuSrHp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZFH1BoGNBl1qYZlQAB0sieGePaBZcZqECiPERB36F7tjqXhhx/wqzDC5TpryNV7RnJVdjTj2lqs3eUolK/9mgSz5inq7pnu2fhd3GTSAmvz7AnJ5kbEtlh102FbSyWMXG4pT5GEyvihm1aufDNjOVt7gAMmJ/NKb5FQBxh1o9dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com; spf=pass smtp.mailfrom=btesa.com; dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b=qx2fRLhy; arc=fail smtp.client-ip=52.101.70.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=btesa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b="qx2fRLhy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHBzW6I7oMtpfTr/U0DZRYMw5vMzZ5Z4dRU+AnqU2H7oU1mw1faIf5HhrHzCw4nSaNHRQ/55os426wBj6NscVrR+MyRWb+K01SQeHgTFcjVwrOKn2UFZAkoiHX/VomIvwKHGtm3yVv+aofWWo4nEnQiXmcXTiU1Jj1ATVNejBjDnA74zZgtw0Ww4icwrn9i7mN8TZ54Cap+MHdlqAEu7daJeeGQhR0A/9+Z68pEYy4HV3r3iGaIH9EPwkZi6aAdFTUyxSyCX26RjwjPeD/PgcCRy1J2H7+9PGGhvC0kzwn/F06CdCeWw4hFafi8MayPMgvS0WiK7EzniH80R+AL0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Okzdz4oxiYRDuMQwQCRkEm8NvZvhL9Z80xWDYjw6J1s=;
 b=FjDonaSO7TGPmvyDN+TXm7GEWHjx7Qxp4arK4FAHWLnssmu9YIsrhu9cXxxEgL4DlTft5ISlguGaF7pjZX7GkfZJTdR0+y+Rrcksmj878/12MqN/IgjOtnlVyJADRKAaN50YThJwZUKbS0rXd/DPRKV6XIoj4k81gOuEhhVMj3ZYhhR5pahqhZcYMoaJzrypnE+t3mXNaYqKgCcK+7DesCvXoxUPAxIQ6k6DuXb4WYQ5RC+M8+vJinVOpyMPYCjiMyBVILuuR5Vuz59siGdUBhboutrrGqzh2qc68TlggsaBTX+j8UA5+MajZFKNsu6lr0EuH6EVXXGYZp7W/3ZYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=btesa.com; dmarc=pass action=none header.from=btesa.com;
 dkim=pass header.d=btesa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btesa.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Okzdz4oxiYRDuMQwQCRkEm8NvZvhL9Z80xWDYjw6J1s=;
 b=qx2fRLhyLHigDGp/xhNLjci8YybFDOfXObu7LQKQYgf/MrDrFbG3Bdi4VHKQuUKhXp4Nz44B3wJxnBcmcwW2+x1+S9VybKXFg0z2R1fFRBOn9cCQ6tTSpoPu2ZRVNAOUIZi4CQKrDiHqa+2Fmhgl1SAyI8RhkGXdWvoySmlzMY7jQqkcyNqrvgW7/IjIKMQ7/f835/GtDITlgNzxdVT78pyaEUxSNGf+b3Yl8cwN/KGpIdxNjwTKUtEJVugzixk0NA3peefDQnrPsNgC7Hpk83kIknVBoiSt6ClqZXYceCVxJgHCnVo0C6lTggZW5ugT3OtAgpfB4zhYp5DX9hkZSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=btesa.com;
Received: from AM6PR07MB5384.eurprd07.prod.outlook.com (2603:10a6:20b:80::25)
 by DB5PR07MB9562.eurprd07.prod.outlook.com (2603:10a6:10:4a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.3; Fri, 14 Aug
 2026 12:49:53 +0000
Received: from AM6PR07MB5384.eurprd07.prod.outlook.com
 ([fe80::b45:9ec:1126:f27e]) by AM6PR07MB5384.eurprd07.prod.outlook.com
 ([fe80::b45:9ec:1126:f27e%5]) with mapi id 15.21.0339.002; Fri, 14 Aug 2026
 12:49:53 +0000
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
Subject: [PATCH v2 bpf 4/4] libbpf: Fix ring buffer consumer loop on 32-bit position wrap
Date: Fri, 14 Aug 2026 14:48:43 +0200
Message-ID: <20260814124843.22041-5-i.tellez@btesa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 44bb7426-1585-4b98-3734-08defa02897b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|7416014|376014|366016|1800799024|38350700014|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tR9iurCxyUMJcgiIQw7QtlVU06Y0RM+4n/jtyJ5gLjTiTPNju3+R6pL+t4bWVJ/75y0gl12exDWX93e6ofkDVcxqKtmoNQrybfZSQcjrncyNWBsHHiMvrDDzdJWtptxj8J1Tpm9PKy03aal1Xrg5sr6MdU5DdEz1jR2GVSru3eGVeyzNW2KYhsRddnuQICM8zNf8rYbsrPKQfwVEiH9PHCc82ucTDTCPJQxpOiJJS9XvsdY/vfo1rya2P3XBL7HxMtCiUTZTvb8tEMLKdEVYXLGrKO6yEg8L5JRAQGPglrm7IOl9LaqEs5tvl+TI2fkGqk3YH+N0MhJYKQJHaLy6sgV4bD/y+VDer0WA9kwFlBIhXsIFTi+HVvyrFVdCCOD2IlUnRM0Nab6779OugEZtgD1BCJThZJjKZhUm0LVfKGpmePWn/eoz+9Bvyap9InJH+EQkckZcLTqJP78YKmBdLganNnpfKoZYBNmNv14kUaLrWecuaq5Loomzpoy/AQObvr+6l+zzJr/zfuxjGFxiwBBZuo+Eik47S+zBUYjEBZSLCQfqVY5NjlnScPFGjHjEGz15z7MfRa77ZMQnlmFaaEiFQslm0Mo5ywntVSTLHHO1fbi8sDji8sxx2BCYMUJXcZ3axkW5vFU3P4gU3BO4I6GyEyFKYET65rgJ2vwJRlluadbRslweXFaZtJfOd5hd+s0SiWY2iveyB9WadwwBeGL2qfhiIDIMqpC+R+cDTro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB5384.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ay9VR2k3WUwycXlDSXkySjhLT05MWHQvdEVyS2ZjWFl1OUxWZEVTK1RKRkR1?=
 =?utf-8?B?Wk1RUEl1S3JVUk1pVGh6TldQQ3l6dGlOeE0rVXJIdmR0WUJXM213eEIydk9k?=
 =?utf-8?B?SWZNbUNlYTFEUWt6Z2NsSkV5TVlBT1hPdGtZa0gwbGx5dWwzRno0WEZQMHEy?=
 =?utf-8?B?Sm83SXc2cGZFQ1djdEJtU2l2dXk5TmdOVS96UUNnbDlKT3lkWitkYkZWMjNo?=
 =?utf-8?B?cVNFK1A1RG9QVXAxRDJPRnNudHMzYk1JREh3NE9rU3dCMFlaNTBFSnZ6TWdO?=
 =?utf-8?B?blIya2doY2dXNnZWQnlENHpnYlh5emdQamU3cDQzVHkzOGtxTkNXTy8vYjdW?=
 =?utf-8?B?Wmg0bkRoZVhCQVpVL0wvY0MrNDluZWQ3SERyWlBLMlRtaUJvVXNOUnpGQWo1?=
 =?utf-8?B?b2NBNnJkTHB2K28zVmNmWmJSY3FRWEVjSFVlVGN2dFNsSjZGMkExS2ZaVXhV?=
 =?utf-8?B?SnN5SEM4b2Y2cmlOUHJvcHhMZDUvSUcwNTU1V1dyWFNpdGdyd0pEK2VyMlVE?=
 =?utf-8?B?TURCTFhST3llekZDMFljSzQweEVIV29PYU93cDh3RUxzSm9USHdONmQwR3lN?=
 =?utf-8?B?TnZDdWVyd043U0dnUXhnMUNRSlNnSEdyL3JBQjR3RUtUNGVYVFp5NE92enVQ?=
 =?utf-8?B?YjBpOHBUNEN3RUJEQUJEK0FZOUkzUWduVTFUWUwxMEtPUVk0UnlTWGF5UFJi?=
 =?utf-8?B?K2M2OVlWYjJyRGN0WlMwVG1HY2hIZEFxa0hHbHVaVGlnRFlZQTh0T1FjQ2lQ?=
 =?utf-8?B?a0hCVVYyYThjUlJXTmxFT0xMSDUzK29uNG4zUUNObVo5UkpOc0NyY1dZbVdr?=
 =?utf-8?B?dUxRNjJGd2xHUXVTY2lEdVBURUpUb0ZCSzduUkpoUTF0NTUvdDRiMHBvK2s3?=
 =?utf-8?B?eWp0Nkd5VXZXTVg3eDF2T0s3d0Y4TXMvTXRBUjVlVytQRWZ5bkhuMHdSMytt?=
 =?utf-8?B?R2c2UFVxYkRnb25hVlRZRHhBeWhPZjZTdkFpME9FcU1qRFNJaHlKM2g4STls?=
 =?utf-8?B?VFNZZzdkMkd0RVRkeVFPeE5wczNocnhEcTV3RktRWDNLS0lweXgxTTJ4dlJt?=
 =?utf-8?B?UzNGSWt2ZVlDUm9nYitNMG50QXBMN0k4aXBMUU52ZmRGODN2VFFHc3NLWWZ2?=
 =?utf-8?B?STYyZFFjRTRvSTZCVlRReW4zTTZIVUdibkVNWDc4SzlONTJVT3pzakJOdHUx?=
 =?utf-8?B?YU83ek9teTFMRHRHL3ZXbGVqOHNoaitVcWI1TGhzcUJBRm9vblRtNEJLTUd6?=
 =?utf-8?B?NFI1cUh1NnhoeG53VUJsdTllZDRkc3oyU0NzRHpKWVpIc1QwekdBaEpueWRa?=
 =?utf-8?B?RHhaVmJGbXJBWXFHSFQvU0hMK3lwSStFT25KVDRoTElsUkpKODlhbTFkVzZt?=
 =?utf-8?B?U2pBaXhmRURrZ0ttamNKZ25wT1p5Wk1UU2V0eEV6eERjRzlRQjRGUjdhb1Fr?=
 =?utf-8?B?Q0RYaW93K3NoV0NRK3M2ZHFsSGZLU2NQV0p6RktCWXVaRnhDYnNBai9mWUtx?=
 =?utf-8?B?cnBzRGhJV2hFRE9vMEl2eGxhRGhNVUkvMnNyU3NoNE1aWnp3M29ETFJET1lq?=
 =?utf-8?B?QkJlalNXbmczUnB1NWtNc21WaXQwakFpZzRwUytORm9xcFZCZ1VTSmQ2M3ZF?=
 =?utf-8?B?Mm1KZXQrZXpSd0xoK0tzV2cxc2ZWMFVuVTluNDdsR2o5WHhtQVdhVS9yRlpJ?=
 =?utf-8?B?bllSZHFOMkhOQXhoWlpwakNrUEYvSld5N0R3ODBhVXBsem9uZG5UaGtBTDVk?=
 =?utf-8?B?dnQzdE5QUFFDQ1NYMGJwOWczN1JJV0xwZ0R6WWxxYVdkK1BLbC9yK0NwVEdq?=
 =?utf-8?B?K1NwTHlQVWs5NHpNaUoyMXo3RUkybFRxcFhpYTFQODMyTHRzVlFBQVVRdDh5?=
 =?utf-8?B?VW9jeEp2UU5rWWFWbStHcUFBRi9EWU5sZmpWdk8rNFJiSlVmd3Y1UEFzUVo5?=
 =?utf-8?B?ZEVvdVgrL2JoVno0N1YrRGd4VzBHT2J4bStqQ1dURlJ2NUd1VXVKbzByUEpu?=
 =?utf-8?B?azBRWDhWMmZjUEhnaCtaYW9tZEM1d1pJWGZJNG5NaVoxenlIM1pxbTJPMGls?=
 =?utf-8?B?R0FlcjVhaEZhRDY0ZjJKQ05ZQlh1UkY0WTVSYUFrTWI4alNodjhCM1RlNllH?=
 =?utf-8?B?NEYyc3pzdXFMVU1nVmRLUEhCQjQ2SkVab1VQakI5ZTV0eHBvSjF2aHVPandT?=
 =?utf-8?B?NTV6bmJWTEI5RUNaMUJMZnF1SjQzTmxobGlwWUdRNC9BRGRCQ0xTVGFMdEZJ?=
 =?utf-8?B?YjZRRThWclVIamJSMkpqcmZEamZ1N2NHV2xXU2lSczZJVE5LL0pYMU02d2Zy?=
 =?utf-8?B?bDZla29iS1J4bFplWlpDQmxyazJjbVM1K2JwSGYybUNIbWFRVDk3Zz09?=
X-OriginatorOrg: btesa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bb7426-1585-4b98-3734-08defa02897b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB5384.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:49:53.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f51efa09-da77-4b78-95dd-fde75cdb9c62
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9dl+OH03SF5AjUR2WC1hFAreyfO2dh403GO7tFD+pqI2IEKYSzq75CsjeEIVjgiFeEhutABmZ8GeBxfB7LTuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9562

ringbuf_process_ring() walks the records between the consumer and the
producer with an ordering comparison:

	while (cons_pos < prod_pos) {

cons_pos and prod_pos mirror the kernel's ring positions and are
unsigned long here too, so on 32-bit they wrap at 2^32 bytes of traffic.
When producer_pos has wrapped and consumer_pos has not, prod_pos is the
smaller of the two, the loop body never runs and no record is consumed.
Since consumer_pos only advances inside that loop, it never wraps either
and the consumer stops delivering samples for good, with no error
returned to the caller: ring_buffer__poll() keeps reporting zero
records while the kernel side fills up and starts dropping.

Compare the distance instead. The consumer never runs ahead of the
producer, so prod_pos - cons_pos is the amount of unconsumed data and
stays correct across the wrap.

64-bit hosts are unaffected in practice: the counters would need 16 EiB
to wrap. This is the userspace counterpart of the kernel-side walk fixed
in "bpf: Fix pending_pos walk on 32-bit ring position wrap"; a 32-bit
consumer hits whichever of the two comes first.

Signed-off-by: Israel Téllez García <i.tellez@btesa.com>
---
 tools/lib/bpf/ringbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 00ec4837a06d..c8fe57401a8b 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -244,7 +244,7 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	do {
 		got_new_data = false;
 		prod_pos = smp_load_acquire(r->producer_pos);
-		while (cons_pos < prod_pos) {
+		while (prod_pos - cons_pos > 0) {
 			len_ptr = r->data + (cons_pos & r->mask);
 			len = smp_load_acquire(len_ptr);
 
-- 
2.39.5

