Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.37.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794498879;
	b=gomTDSMDGqrTCVNStuXXfhGU6rgYXtp3WxZhbKMxXgwfH4fu6okRiPxFPy0IdKFTvGpx
	 R4Yq/E1nW0F1n42oAXYX51DiQ5WQbSyBgeKip7/4QDQcbmHmlTZZOhXtOng8OuXjRvaqY
	 woJ07jC4ha+KG7rQSavyZoU0d24nSgLb3uc/0XLryixzRW4sPeuPCXNGvy6U+YL1M1yNh
	 k3gMy1JjIPQqPE1JKGJLHXYYkqmE49AcrYDZFCj6yKn/2DZahSBHN2a47nGFwMJKiq369
	 HWYsg2UhcQy0D9XU0Ch8fxeJoKU1674GvcrN6F2hJv7vXu1/sWh/y5Z5ycMxxV1kOhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498879;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=hK85rzLuiql32w0yqFx6yAyNzeMuejWNKlG2avOogJQ=;
	b=JQVWQA67SRVBpC9WW2CxG74tOSauUA6hTrA6ZeRmEY0HJK6dNk14YVWE+qYke9fQyYtu
	 c49b9PznhNeDlzsT3kqrHhFvTrNyr1kgAbg9S32oZvwSy0NLV0JuHRY0KMJmCmzHgG31y
	 M4lVLKVlwghkIGcCE41Vna73rooXpHnNS+xDiyBzf4oj2qSbeyRW1MpIkdMwo8uklWLPu
	 4sy7yKVoSI5wsDufl3F88ittVfHOtRT2FyEzqI3XwJj7VAt792vhaA0HqjLHpCiZs7/C/
	 W56Gg5AZNHFhCEZIhf0XO2S1t3bgm3/jxvF2NOKjh2UBXBSGRJUsutv7hQPkkKOOPnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=msVCDfAK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.37.79
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazolkn19011079.outbound.protection.outlook.com [52.103.37.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32156606A323;
	Thu, 12 Nov 2026 15:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32156606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=msVCDfAK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhoSrukbBsc2rYb7JbZDfoc9IYzLUiuUuBJUi+cBGSCZUsmQVV/8UAC47XTBPasUN0aoROTNy76Mx9xYN+yHgX8qYjDf+CUjMCfk7S8XPGI0reJY4Q+pGH3bqZvIGPdnTuSvj0g67H+1kWN9sN4hfMZ43jjCtd67Y2Ce5CDFhy3aLrfoc/eiSD5f/HmzF2AKK6mIMNV8AOxRYymVkyt+LuizHcyo8V0nxRerHrYYdCXDszvU7rmOC4MmH0pVNA+iwYytesPLUTR5mF8WwphxH7s1ZdvgDoIISO/YuyvL0FdoXMfOBVctSYDyhnfohLapLRHtbQAZU9HRG1L8CQ9Mqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hK85rzLuiql32w0yqFx6yAyNzeMuejWNKlG2avOogJQ=;
 b=q4ShGNmdkiSKoAwlwoFB6RzVzyx2+5yj9pEh5RnF6o1UqLlrLdWNRmLQVj9sKp7ghzovFP48U7B28SpPXdZ2XJnry6z+dNk6HWtgTSln+groHM9koinIVcEqDlhSRghDtGjHMzYI2eWLTwx3h1dBRnKHSV/zUfHAfNgy5Lg1t/VwU+zMKYq41nCTIF9ebMm3oHtLaVFM1GCmEgRaN/WfaksYe2aOalGoHL9wtimgIXTvR4JSIqFZRMgAU0qNKF+JX1d0GVGgQKXrh/+vzfNuYxR0TnsxhE+9sesZ+pqXGm7TV7eVhp8V3wNKwQf0OztUAKfmcfj7ZNN+KfoSrXdohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK85rzLuiql32w0yqFx6yAyNzeMuejWNKlG2avOogJQ=;
 b=msVCDfAKOTuQpeM/8d3qXHqLL94xz/aYHZFtjy5TUJ468GnjJsQwaX2oaTGNeM4JNc70AgGGvoAtAu/wDU5Lk31rgW+nDRaNr3cf/hVj0iToLJrdXJ1rTWVV2Gi21m552XGu8KsKsCDxVY82LuPa8iNKlpNu1LpVmZA19NDW0vOkN3C9lkykaxcPCuIjulPwjVTaFpuJUDzGgBd9IIXeye6HwlwFjyNMZqvsI5I9PKKolq1hpL6VPTGdYcPUdVj88K+p0QidJE9uASz3T7xOOJOyhNhCtBNVlEZXYiql4YIXzv/SAY755kkVquT7etT2/6NDUo+LqsEwAVGIGnt21g==
Received: from LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:378::12)
 by LODP302MB227602.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:4d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 15:54:37 +0000
Received: from LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
 ([fe80::fa56:cf9e:33cf:e1b4]) by LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
 ([fe80::fa56:cf9e:33cf:e1b4%6]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 15:54:37 +0000
From: Adethya Srinivasan <adethyasrinivasan@outlook.com>
To: bpf@vger.kernel.org
Cc: Adethya Srinivasan <adethyasrinivasan@outlook.com>,
	yonghong.song@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf: Reject writable map iterators on read-only maps
Date: Thu, 12 Nov 2026 15:54:06 +0000
Message-ID:
 <LO2P302MB019721D7E507DFA1C707F102BC702@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <LO2P302MB0197C0434BCC2A9031E99A18BC702@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
References: <LO2P302MB0197C0434BCC2A9031E99A18BC702@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CW1P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:290::19) To LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:378::12)
X-Microsoft-Original-Message-ID:
 <20261112155407.136041-2-adethyasrinivasan@outlook.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P302MB0197:EE_|LODP302MB227602:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee27215-c63b-4a52-b591-08df40d540bc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|260925184616899003|25010399006|24021099003|51005399006|19110799012|8060799015|15080799012|23021999003|5072599009|41001999006|12121999013|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tC64m3gxECdyruiD0A9CEqiAzmYMNv/Qv1CLZj+HSj/7kX5pfwW80/88ZesT?=
 =?us-ascii?Q?fpCufh1AE5zYMmhANbDpZ7X50juEFMC589eyGvo/8VPW8dJs2pUgAXzVYwpV?=
 =?us-ascii?Q?0EwExai8q7kMNwvp2NOWVx+VadOtZ05oYd3BgsnHZmiz+LRQgtHn7azfshY6?=
 =?us-ascii?Q?fY58hKDLTl6JM/+B+SwFeXvm4t7siaB6Y+l77odVHjPNaG/4ZSrKjxz7MGac?=
 =?us-ascii?Q?3jNufPCrH7Z9AXA8KNnQ9FbhNohxUsZRsvqx8jAMsQjjECSOZvu3VnxZsnKh?=
 =?us-ascii?Q?nwxoxVtlSaKbeNknr5X+PwjK1l/Q9DhQ8/zeJ75xK+fnaGeYwuV4wIS9ker8?=
 =?us-ascii?Q?XRymrBau4/PI+PCzQv82zTeZnoIWnja5UQgkTiVPB5tjDWqdT3Tr2rpvgsPz?=
 =?us-ascii?Q?KLfyds0DeoTHp+My464vathz8KG+X49GqA7lYTPNZuJlWNnN5b15EhCGPGih?=
 =?us-ascii?Q?O7kCLHBTrVzNbfPfAdPJMpvdUZTT2I2s7t/XgQBybou/VNQEPHVuJM8tVe9h?=
 =?us-ascii?Q?KSmY9cCRbcYyCxEsvU7D+DvHNO/zRcEwBaz9CiOsA0F37wgXQNXGeNh+pIJS?=
 =?us-ascii?Q?f/oul/MpGKaRpEiD7Pk3FXR0dz2c6lfKex7JVC0JSV1+Rj3G4094TAuoi/Au?=
 =?us-ascii?Q?yrTrO0Ux/DHcxz7Z6rh9mKYRrqOF8WDiYj44sm58oWAH/BW4/l1tl0UF7vIp?=
 =?us-ascii?Q?wOubkDcxWZCbSnQKtoxxIzhPptdlLJPGwfoP5ngZLgR+OGNTYR+kM4GQ5KHX?=
 =?us-ascii?Q?0Xm+OdxAQWc89HUpzniDMRxgMasVhWIf1li4Hll9lO7i6BwzrZiw/bwXTsuc?=
 =?us-ascii?Q?Hgw0r1d2ugu2OERdrijc0BXdvJZgLg7PdnFG+sKLWeS6Tzt+e60zRhQt+Ray?=
 =?us-ascii?Q?yA9Rhc7chQDXVFrmT14zpHRU9wiF98S5bZD8+nD0I5UWoOugNUcwE3QT1W2h?=
 =?us-ascii?Q?s9XC0jh4y46lYmXo8sFdxAjIMm18kkiukkR+tDcf4fdS6pAJw4tF0b38Ltpx?=
 =?us-ascii?Q?GgzXDwiBWDx0ec2/wnBIvO0PZu8EAWw6NMqY2emN22KIZKs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+Lqsxic6Ub8K6C5Kp7q3xadk3CpHFpJGVH8179ub697fiEoyCRzUo9BhLna?=
 =?us-ascii?Q?DnHA5eDThqSs9j6GKUCarAYaTDa7eweWg5yksvBD8E6rsS4NqwFhN/sK5TVI?=
 =?us-ascii?Q?QQC2JTAn1yg21Ly9lGoC8wNZJk3scRSySivYHRC/lkl6ltQ9GnQy5LCD2CaK?=
 =?us-ascii?Q?doUYzafyo6zCKCJ7gVLsxRi1ESTy0ZBjUs7lAGdyOxwkA8DJdddI//WAkwlc?=
 =?us-ascii?Q?ccjVTW3g3Vn5H/GoTX9p2CXujUrF5bOFJkctDue61DwpyxwhPqUWDJRCvCoe?=
 =?us-ascii?Q?knrNi4vSFDNo9Aj1rZaGqbROgxeKlwPJKXULS8wGTKUYnCsfyjMWmNhoZjhA?=
 =?us-ascii?Q?5OTUEWRnkqMVkQu/4yR1HFt4vfvPjJ6UDFSgtSFb4BAHCT4xjX2bqnXj3q8C?=
 =?us-ascii?Q?9dIPyXH4U+loMbXP8ouGFzF/nFdxpJCltEIj9R2YdM7yPuH3fMZQTqvXtbpG?=
 =?us-ascii?Q?yARGTIIRZIlQvdJUIvv6LNjWZ/fMyb0X39kefJjyvx0Pl568u5SHgIqT9dkw?=
 =?us-ascii?Q?FKQZlTXBQswpGwm5PLdRr3Uw9NLhrE1CRo6CH2HYiP3z6prYkpo6BUU+zccT?=
 =?us-ascii?Q?u7KtQwSJczHpMutGTEI3kt9rE6JkxUm8nUkiRadeJ8KJtMmq75qq6e18GhHT?=
 =?us-ascii?Q?1BE6nKelaAyHl9PHh9+ybCEBcKFSqOl00J1OXQ1OSVfGoq8FbrlGeUGmGGa+?=
 =?us-ascii?Q?ostfzY6J5xaXEQneoBTvvhUsoivyhqqEro/gnT/k+04cOzoa6ZNdYcl94vn2?=
 =?us-ascii?Q?5zFQNcdXf4e++vk4EWhyw4Y3epWgoODaQ5EBfsXas0r0hrPviEqfhjhh5S/A?=
 =?us-ascii?Q?YVcxioIpJ2ojB9SDdVg0OZMgi1oQazahiEoJJD1RNs2mhr4yhHyGRAobtUaL?=
 =?us-ascii?Q?Jyj0st5F1WvhFNkxESZwjl2H0z3O2Aq8v8t32ec9rgQuHOf7WGsbcB92qvmu?=
 =?us-ascii?Q?ch+/Za4iGJRa2P9TjEm5XEap35RjCppOP7aUcNLMadbm2wLQWCYdfWP3jilN?=
 =?us-ascii?Q?IPoOpkYzATTN2qzLzoDv9Hclu5yUBy6IXLN5yNjIeipY15AYiA9KQjk52FP1?=
 =?us-ascii?Q?F6yQTLiPepDUsV58esdmzOQJCOO65cBCFsxd+8YwQ6ZajhopmY23yZHUFfRN?=
 =?us-ascii?Q?Rt1wCzc0oNNSZJPrY2Jt/ogpOS6XypOp/EebkhMysFLAlLpZr7e3JX52h7Z/?=
 =?us-ascii?Q?+84Z8QNXG+nxrOdUa//1Rdfd6GVPjC2qNX34KlBfFs5UEycdx6rwEpi9i4vO?=
 =?us-ascii?Q?xq+XJ8eJTP3KcTs/VlFvwf8Dp/UoJkJvVWhPirh1vUYgMFbDvwJJAYnuud/g?=
 =?us-ascii?Q?H4Iq4W5T+B5WsqEhUnOTDA7jYQyehAUXqsprHvtiN0jeSAAPxFUCEFmkUi/K?=
 =?us-ascii?Q?G+L87fQrePFCcd6yP0gA8/v77AUh8XE8gfli+0Hk6rR4Fqmy7w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee27215-c63b-4a52-b591-08df40d540bc
X-MS-Exchange-CrossTenant-AuthSource: LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:54:37.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP302MB227602

With CAP_BPF and CAP_PERFMON, an iterator program can write into a
frozen BPF_F_RDONLY_PROG array. The verifier treats the contents of
such an array as constants.

Reject writable map iterators on maps with BPF_F_RDONLY_PROG set.
Keep allowing read-only iterators.

Fixes: d3cc2ab546ad ("bpf: Implement bpf iterator for array maps")
Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
Signed-off-by: Adethya Srinivasan <adethyasrinivasan@outlook.com>
---
 kernel/bpf/map_iter.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index a58c14869..7a769e5f5 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -99,8 +99,8 @@ static struct bpf_iter_reg bpf_map_reg_info = {
 
 /*
  * For an iterator that hands the live map value to the program as a writable
- * buffer: the verifier knows nothing of the map, so the special fields of the
- * value have to lie outside of what the program may write.
+ * buffer: the verifier knows nothing of the map, so read-only maps
+ * and special fields of the value have to be protected from writes.
  */
 int bpf_iter_map_check_value_write(const struct bpf_prog *prog,
 				   const struct bpf_map *map)
@@ -109,7 +109,13 @@ int bpf_iter_map_check_value_write(const struct bpf_prog *prog,
 	const struct btf_field *field;
 	u32 i;
 
-	if (IS_ERR_OR_NULL(rec) || !prog->aux->max_rdwr_write)
+	if (!prog->aux->max_rdwr_write)
+		return 0;
+
+	if (map->map_flags & BPF_F_RDONLY_PROG)
+		return -EACCES;
+
+	if (IS_ERR_OR_NULL(rec))
 		return 0;
 
 	for (i = 0; i < rec->cnt; i++) {
