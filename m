Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021110.outbound.protection.outlook.com [52.101.70.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B04657E5;
	Fri, 14 Aug 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711785; cv=fail; b=NLLeLGahSMvIKeJ7mfD7WioVRJXaLCcnUSOqPYE5lJfZHUnw+dBnxgWzwLK5YdxT3MZ8cYV6V5N85Sm0qjV9hGNd44nr0y0Q5TLSQXjJBlQN0pdGSviI9yPPRCXCLTXUj+91QkmdwUCpNvMr3PfzNUV8Wl7N52al7U8LWthE8Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711785; c=relaxed/simple;
	bh=c6hCuhPw+XimGLswlRdQkW7pFfYPJv8XXQOqvWmEKo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PIFPJ4JAweuM01+1Ss9UW0PHNMur5gjiXmNHtj/b/+Cm6p0Xpy+k+Z7bTjmu/js9bJGZtRQ1pWWO9TOH3A0g5pOuiaDSgy1wKdhw69APBV6w2hBvIfAPvhWuzI6Mg0Q3jtLSXgIga5YcRbKWoMThRnNNXLJzrhB3Xg/YeCbFhmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com; spf=pass smtp.mailfrom=btesa.com; dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b=OgmF0Lr9; arc=fail smtp.client-ip=52.101.70.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=btesa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b="OgmF0Lr9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4MlQZwuFK7cdC5IVX/mC39HTY+f/IDaRC/f5Wdp0UDx648ESKiTyWvtbwxwWgwrXz+v4wAJ/NL7Wh3nLlHLqVf4yKRdRB77XPoIA8DZ9SgVTXphBO6DBc4bx4UT4n545P044kk2z4GTEG6H0bzDkoNlM7hSvwloGgZaxTWQym9oQusapr/LYHooo/avjXTbfBK58YpgRC1k7o+Z56fsv5pZqdRBUCdEWVJ2xAICVPNM8WSA7pLJK32pEqXfQgkmqJ91CIEAKxVE60FQQzFIcKTpoe4SfpP/dgblzEeUd6cWSW5J3b+nv8h5s2MniKoig40D9as8T4t1BWXrIZQVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTrw5gNPSBbZS3YWp9Vax+IpRjsl96Bc4oQw682RbGw=;
 b=Wv1ghlnfVgL8orqNfBIZ/GJY6KoMHLQHOcv/rirO+ru764UB4ExSLe7hGtp0DAbPjQAqEV3Hef+2SL0abuDCvFALoOiJzrj6nyRnjdC/3VDtQI5Gkauc50ISocekejGa5qnpl0oBYy7qKzujNvK7nGOgVrCYJZ2eHa8KBJwGff2iYYhDXeC+wP2cWK3Beol5eTCAgfd2Q+vdt7dWUgaB7VTrJQFwW42fURKdrrduRHrD+PCbweboouZkJGVVIb4+0VoBhCQpOEC96cyj4QKCpQmH8nEAvCjuEyXXy+ZGqQJ9mPoKfesSOZvc9agzPnBR+fIx81PLzTV9N5uQJm/ECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=btesa.com; dmarc=pass action=none header.from=btesa.com;
 dkim=pass header.d=btesa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btesa.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTrw5gNPSBbZS3YWp9Vax+IpRjsl96Bc4oQw682RbGw=;
 b=OgmF0Lr9x9ydFqFoP+DXMmaiBjCGEpsDoNDc6IQx2GOnlog3szLV3YgUguKIlvqwtSY9Ape7IFGQhxf6CMHqX3IVnP0CzFYyQY+lmASIWo+wBZxraKIUMCumJ05bLPk57rNPgtI0diZ88GSjZvwFzXlZoFuHF0iGVopC5ErDtYf/7Oyd5euGkpUxxzO2JPYpqUWykqPa02piyTnEWiHguwRcz9Ea573G2Hn2z6LafJzUEK49yDbw2PuQ6R89xtrlWBo1Cl4tfLYrWzajr/Kfg3vPmcdrU1Tc2+w+V7VCT175UBjhL/5JG8XhEMhYPIiDIWbTMaamh/PU8EPMI/PNOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=btesa.com;
Received: from AM6PR07MB5384.eurprd07.prod.outlook.com (2603:10a6:20b:80::25)
 by DB5PR07MB9562.eurprd07.prod.outlook.com (2603:10a6:10:4a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.3; Fri, 14 Aug
 2026 12:49:34 +0000
Received: from AM6PR07MB5384.eurprd07.prod.outlook.com
 ([fe80::b45:9ec:1126:f27e]) by AM6PR07MB5384.eurprd07.prod.outlook.com
 ([fe80::b45:9ec:1126:f27e%5]) with mapi id 15.21.0339.002; Fri, 14 Aug 2026
 12:49:34 +0000
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
Subject: [PATCH v2 bpf 1/4] bpf: Fix pending_pos walk on 32-bit ring position wrap
Date: Fri, 14 Aug 2026 14:48:40 +0200
Message-ID: <20260814124843.22041-2-i.tellez@btesa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4cd1b5a9-9c46-4d1b-651e-08defa027dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|7416014|376014|366016|1800799024|38350700014|6133799003|10067099003|56012099006|5023799004|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ioyw29g+kEJTZ1IriOmDShfahytkW3sedhd6kSb4qUYTkj7JWowz815yoLylHQCOI5vF7t+keXXkT3oRVvBXtIYGmX0pzu4zRvIyiOSCsaMfxK9uJBtOnd5FSoSXR7RDXCT/7jYgVzGJhfXEUSukAs1nguF9Q3wJb1Rw/DUSHwMnIo44VJddmoEVkzV3UvKli5ad4B3xI+iqoNhKNPWu4A9mRBkYccL8oM0b+OMsJ1RxajMCgLhw1h7mqUzZycZDDEQJLBs13OBMgAnyDDKunw6bhO+IrW9fIRRicFkUm5LRvToMWxTxC0GPLv+4py59sMUsTzVWLLyiK6EXc3Qob8ASaBk2WmJqRsnxFbPcwuGHYt8HrCV6I4jwfc0TzI4HQMVV6IywHF0uHaint/jA67YrlyTs/uGXjXJLJ65NjLGuprJ9k7L9vZPZOjGeXR67p/6doEujF8gpJL7OqSzo35Z/KrmEDmPdmcvH8n9GqUiekrD0bh24W+s+puT6iBqc7BEtLrxn5kNPvkhwfJy7drWq7qcWewZTSzDBpHzyELC+aydRA453CPeiG67lfyX85riv14lU3Bjb3qnKUNsM8zQ5IM7fPG8v1qRj9obyLGNcVNGKTzVs0uVPgdU70Ez7XyRt8zxfR+ni5Vh40FtNiaHe/NbOXy6qWVHDej4pNJml1O8LaPgjOgFV1zIV0FacMliZ/ZPWq95GEdxaTMRlvnAVsszr/D+6jrQqwbFy6Z4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB5384.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(6133799003)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0t6Uk9qVlJBL3pIeXdkMmFoZUI4SFh2ekNBQ0ZmbmlaeWpNckFaU2lWWFZx?=
 =?utf-8?B?Wm80NHdNR2dPTWtsNjJjTTJra3FMREhOWUFiamZMZWVoUGIrZDE3TXB0Qjcx?=
 =?utf-8?B?c1ZjbU1TT1IwejVRK25RT1ZSMFF4VWN3K0srVnRZbUtKbjUrVUN5cW5nSmZ1?=
 =?utf-8?B?c0UrTldBU0tkaTBqVUNhYlRJT081WDRpY3NCMHBVbGk5Qnh5a1JQcEIrUUJp?=
 =?utf-8?B?Qm4xZFU0SmhaV3JIM05laVpyR1lPRytCdXBKQURuVUZkUm5VczU1VUVlamNT?=
 =?utf-8?B?eWUvbTE2NHFHRDdETEZJL1BSY2xURHhyOGZGYVpBRDZYcDZ0WDRyNnlJWERC?=
 =?utf-8?B?UEtkODRHT2xLQTNVdVg1a0l2NVBnQmZQTVg5Q1pnalhjdDhOdWZJZ285dzFN?=
 =?utf-8?B?d21rOGVuMG9HR0M4ME9PVWlnMTdvNm9kc2UwdWk1Tlk3WlgxOEFKcytqa1dH?=
 =?utf-8?B?Z0d1WTR6S3NrWWVYakNtYUVZZWZOS0J1VmhOSHNxa2RKZ1hUVWFYUDJqeWhn?=
 =?utf-8?B?RFpPYlpGeGkydUZhd0crMmoxSmlvbXJ6YzV5UFBHbFBNaTFEcWYvUGNSUlR6?=
 =?utf-8?B?NDBEQ0p3cER4ZUdJMEhWc1JQaEIycndRYnNuM3Fkczd0clYvRTdGVjJvY1dk?=
 =?utf-8?B?dU84NXBmQ1d3V1o0WUc2RnpHVWtiM3NPbkZETVhuMVVTYkc2bjk3Z1U0cWFo?=
 =?utf-8?B?RWZKcC9BS29meDhGOE9udHVGYldBbHpCMXd6N2QrQkFUbjNkWkZzR3pGdkRT?=
 =?utf-8?B?cEpxNkdhT3pOYzBFckZvbkhTeElOcG8zWDdwejhQb21FZUxGaHp4aklRQ2w5?=
 =?utf-8?B?T0k0TlFGOEZGWTBUNXR3YVl6bEF2bVhaaUh5ZVNJeFBoSWZrNTJjQnF5Mk9k?=
 =?utf-8?B?RUM3cktDY1o5L2gvcmtOYzlGUlNwNmQ3K3RIblhxMy8vUVQxbElsVitJWmVN?=
 =?utf-8?B?b2lYVUg0dGdTZlp4Sk9Yd3hpeXNGRjNvTGljYjg1SFhsZXJEbThnZEJtZi8x?=
 =?utf-8?B?VU5aeFoxR1NqY1hsMW1Db0prdTA1N0M4NHhIS0xNSWF0c05sdHMraUpJM01O?=
 =?utf-8?B?RVRRb1Y3enB5TldSUVd3VWxCQ1lzTjI2aWNzZ3BPZWVQNTVRZmlEUnQ4NlBI?=
 =?utf-8?B?ZzZURTdkMUxFQWlsZVlMV0YrVG9DSktzd1hPNUREd25ocTh6end3NlovUmFi?=
 =?utf-8?B?T0pEa3FqMkFvQzd6T0R3Z3ljY3FmOUhyb0JncWpFTnovR3Q3M1JvRk1ldzVC?=
 =?utf-8?B?Q0dKMHl2ODU2ZEJGTVdBdHo4b2h3Q1V5a3VKMXpId0dITTFIYkJsa1Q5bVpN?=
 =?utf-8?B?cnhUeHlRQ1N6bjB2K21temFMWUhkdTFnc0duVWNmS2h5OE9EUzhlU3NYQW9O?=
 =?utf-8?B?N0xqYlVPYUtOelhldWYwWFNHd2pPT1hHWmxpNjlaZGV3eFFMMms4U3A0ajhT?=
 =?utf-8?B?VHg4SVRjSHhHVGgyaFRpWElZb2ViQmZET0U2dTN5UVR2UlFkUEM4TGpLdkFV?=
 =?utf-8?B?OGtOT0JzL0tyc3hMRDQ2Wm9ZL2FGK1dqV3VqaFNwYXhWbzBHdGtsTTNZMHp4?=
 =?utf-8?B?eTl6RmxNQlF3UWY2K1hRaGRuWEUvRlN6OWZVMW5TMEV6OGZJYUxJQWdQQ0dY?=
 =?utf-8?B?M3ZUczgxN2xiVlpaUEhiVXRaSU04MTkwdDNNUFdsakk0aThiMGlFNGhpSGhn?=
 =?utf-8?B?alFMNTRmTUNyZGQ4Tzg3bGpVaTR2SDYyTVQzT2Z1N2VaY1VMcTh2dldKRTlr?=
 =?utf-8?B?cWNobmJxTUNoOW9RNVliUUdCYVo5TWJ4OVM0QWtXMngreWJqSWdhTUd2aFNN?=
 =?utf-8?B?K1BTQmNEMnNleTNUcUFDWmFTeVZCRTJmSXdzRWdWRU1pTENHVFJrR214TjBa?=
 =?utf-8?B?T05HWkFLdlJsRy9rL3F4aktaeXpOcDFsazRBVkVyVHhwVGxJL3I4Z2FkcmtR?=
 =?utf-8?B?VEl6Y2FEK0J6b2VsZGkrUjBTYlZmTXdSbFJoZW1zQXBQUTgvV3JYN211dTkw?=
 =?utf-8?B?V3V4cTFtY05obWVGK1ZZZ2FYcklnSlkyaWViSFY0NGsvSktxWDlpV3ZDRjds?=
 =?utf-8?B?ZDRGcXNhM3U0TTZmVytQNTRSUHA4a1h3RkRDK212M0I1MmZYWTNzMFJYQ0s0?=
 =?utf-8?B?SE5teDJ2OEg3SERkbEsxYVhxSDZwN3NmL0hMNElMaXJYSkJHdzlTdGRFYlov?=
 =?utf-8?B?MExaekpZbmVqWVBSaHAwWlVLb0tPS2VLcmVEUi9hbmRJOVdjclVJTzVib0hw?=
 =?utf-8?B?Q3pReHhwVXRQQy9JTEtpbUJTRHRZR2NKbWM0cGhQSE1xWTJybXVNek9HRkpv?=
 =?utf-8?B?OGxwaHkzUGpON2dOekxqOW1uYm9GTStBN2ZSRjNTUEdhMjhZempYQT09?=
X-OriginatorOrg: btesa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd1b5a9-9c46-4d1b-651e-08defa027dc7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB5384.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:49:34.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f51efa09-da77-4b78-95dd-fde75cdb9c62
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwKqjAb+qGIOxDdsGLGZTWVdnfCkNZ+VG4x1u+VDR9WOALiXAoQevfT6KfVr3eCIJyQKqFiwZ3wVvnWVX7yZCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9562

The reservation path caches the position of the oldest not-yet-committed
record in rb->pending_pos and advances it past already committed records
on every reservation:

	while (pend_pos < prod_pos) {

consumer_pos, producer_pos and pending_pos are unsigned long, i.e.
32-bit on 32-bit architectures, and Documentation/bpf/ringbuf.rst states
that these counters may wrap around there. Every other comparison in the
file is written as a difference, so modular arithmetic keeps them
correct across the wrap. This one is an ordering comparison, and it is
not wrap-safe.

Once producer_pos wraps past 2^32, prod_pos is small while pend_pos
still holds its pre-wrap value, so the loop condition is false and
pending_pos is never advanced again. Reservations keep succeeding for a
while, because bpf_ringbuf_has_space() uses differences, but
new_prod_pos - pend_pos grows as the producer advances, and once it
exceeds rb->mask every subsequent __bpf_ringbuf_reserve() call fails:
the kernel believes a pending record spans the whole buffer. The ring
never recovers, bpf_ringbuf_output() drops every event from then on, and
nothing is logged.

Observed on four armv7 devices (i.MX7 Dual, 6.6.52) running a
tracepoint-based collector with a 512 KiB ring and 160-byte records.
Every one of them stopped delivering after exactly 26846821 records and
4295491360 bytes had passed through the ring, at event rates between 441
and 862 records/s, that is after 8 h to 17 h of uptime: the trigger is
the byte count, not time or load. That figure is 2^32 plus 524064 bytes,
and the excess is one ring's worth of grace period, as expected while
new_prod_pos - pend_pos is still below rb->mask. The last reservation
that fits is the largest record boundary X with X + 160 <= 524287, and
since 2^32 mod 160 = 96 the boundaries after the wrap sit at
X = 64 (mod 160), giving X = 524064. Userspace kept consuming normally
until the producer stopped, then read zero records for good. With this
patch applied, one of the four devices took 10 GiB through the same ring
with no stall, while the three unpatched ones kept wedging at the same
byte count.

64-bit hosts are unaffected in practice: their counters would need
16 EiB to wrap.

Compare the two positions as a difference instead. pending_pos never
runs ahead of producer_pos, so the unsigned difference is the real
distance between them and stays correct across the wrap.

Fixes: cfa1a2329a69 ("bpf: Fix overrunning reservations in ringbuf")
Signed-off-by: Israel Téllez García <i.tellez@btesa.com>
---
 kernel/bpf/ringbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 35ae64ade36b..06d3cc192601 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -482,7 +482,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	prod_pos = rb->producer_pos;
 	new_prod_pos = prod_pos + len;
 
-	while (pend_pos < prod_pos) {
+	while (prod_pos - pend_pos > 0) {
 		hdr = (void *)rb->data + (pend_pos & rb->mask);
 		hdr_len = READ_ONCE(hdr->len);
 		if (hdr_len & BPF_RINGBUF_BUSY_BIT)
-- 
2.39.5

