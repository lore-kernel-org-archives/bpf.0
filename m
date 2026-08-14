Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021110.outbound.protection.outlook.com [52.101.70.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBCB470121;
	Fri, 14 Aug 2026 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711779; cv=fail; b=U6ZXLcFXlo6zHMywCjc2IttN1n0kHbCK+xHYeKZ3OSqNsQ7CZsYwKvCyXoTxQKrYMYu8wU+k8R3yz9Ns8KJ28HWUJm8dlSju0tzAlOUHpkNU6zP800Y6FOJo6N3egEiYrSk4A7FA2M7T6YgV+NwB+rD4T3lkl7l++5XhnyH8D00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711779; c=relaxed/simple;
	bh=Dqc3Hd+ilaSug3cNuSPPvt6GTdt678ppp2jk3tF4vFU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T3TALBRvV0WJqbJ/dBwhCs3B5t4UCFMfROqow3eaJUxzgRv71CXDNMaYU9b8R0Z0qAKzwydjZzMXvW17/4T4pBQOZqOEjgyeTVA7hvQz1GsaA1Ty6Yly08dn3rX3lWXNVZjiY60g0RExqA5Ic8+o4ieuDut89y9i1WR5jlKb2Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com; spf=pass smtp.mailfrom=btesa.com; dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b=d98muYP5; arc=fail smtp.client-ip=52.101.70.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=btesa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b="d98muYP5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMnDLuMiIfcnCMrI9iHqtpyk4gaEKcrFQXUpQedI5eX9pH/2dhnZuUODti4ccWh9k0fwhLZ4eIhnBYmCVIm9elt4ov5G7SWnT/q9SFsEB6pMvB0qMmhefJ40O9jIXs5S7+H7L51oK7ZRHjBoM7vkKwy53lpZGHTtco6R10GEr279P2CCHyHUZHZ8SoCyqSk8H2ShCR8I9KfPZog2gMK5Aas7i3W7GYQyT5vG2zrr35KjeRjUH4i+bsshxqyDl2byw6L4BuodHSbvqz7aMEJNSyGgJM/XudzsNG8ytLIpNsixn0P6cxI5xAJqoy6YO9BCChw+W8KbfferEoVOJY0NJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjDZNLWfWcSlCWaWjiIeZzqYIg3kr7shNaMmJ/CiJQc=;
 b=MjLR2OSbFvmwFk3pe2CMLnDQP7rTktqR8g/PaLOWpMjkIta7i/H+Krz1eLjx5Q/O+0OOXGl7O7bJ8e75InelHuvYGIUlPu6buiHVhuNz/YVYvImYwQ+3KNzfBCwKn1mSbQ2blIph/rWr1Zoo4/rMdZ3inUXASv+IkKbL96ArluHOVAMipZYt731/OK+PjxTLKEXsVJ1Unx3WnOpdPw5Lp6YYIDEO06hYBxNEYwPZALlYlShu8J9suIirhIT7tjcEgLA+SGbyumTnpmWDIAXr3nyPBiRwaL7lN9zqefXN+yPgW1/yy+F54Y4Y8GBUWf+MQhAvB7SXqz2bH2N9VEavkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=btesa.com; dmarc=pass action=none header.from=btesa.com;
 dkim=pass header.d=btesa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btesa.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjDZNLWfWcSlCWaWjiIeZzqYIg3kr7shNaMmJ/CiJQc=;
 b=d98muYP5PMw9FNd75fkkWpuubMrrNPRAyzWbwlD9hCP1JQx0F158UgnIvoviucrBHBUdylcy/FJymta18rN0CRbl/pQg44sTgohXHWCla2G15Oz9vKHaWb983JqESpodSJMJm/lacA/PYGoMM+M0E6Uwdxc4ObpbsPxSiVECF27SRHcD9P1eV6vOILpPq/KrxktpMe1bPess99hmJCQrjk/DtqneBexnU//cUy8p+8F4IK47lyr3Dp5ZbUCJeCjVKAkggsWbzLofbV4X2Lf+pwkbUQznxqNYobq3YD3yf1RHUN2SG7xHBCGsUO5wTkay0p06Bs6BukLow2N9+RC4kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=btesa.com;
Received: from AM6PR07MB5384.eurprd07.prod.outlook.com (2603:10a6:20b:80::25)
 by DB5PR07MB9562.eurprd07.prod.outlook.com (2603:10a6:10:4a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.3; Fri, 14 Aug
 2026 12:49:29 +0000
Received: from AM6PR07MB5384.eurprd07.prod.outlook.com
 ([fe80::b45:9ec:1126:f27e]) by AM6PR07MB5384.eurprd07.prod.outlook.com
 ([fe80::b45:9ec:1126:f27e%5]) with mapi id 15.21.0339.002; Fri, 14 Aug 2026
 12:49:28 +0000
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
Subject: [PATCH v2 bpf 0/4] bpf: Fix ring buffer position wrap handling on 32-bit
Date: Fri, 14 Aug 2026 14:48:39 +0200
Message-ID: <20260814124843.22041-1-i.tellez@btesa.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: df572c6e-a129-4287-6086-08defa027a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|7416014|376014|366016|1800799024|38350700014|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	LCVqao3XPCzHPABhglkLvx4DRTc0FCyE/WiW9OX+w8+qyoyngSFVoFAZBcxSLQwfR963ZRN2nD57Kxs9Wlmoj10CtRjhgm1F3ABEcGQ4LuW1LRzxydCW0uOGkZqvqmDwxL49zt1SCfTnroUzvqJwPJiWEAGf96XbISbei0LdVM1KBcYU7AzIpdAdBxWW+agU4+gz5upyfJlSbTKzK/x+xGOPmRjG7up2OhtGrDTPR6stiwoy56SRTXmJrdzwTbwsumiJjAlNP4go8K10PvSUzuf4ePra6xE8d1Dd3112cVOF0bjUTJsxEjAUZON8bfvCMqI3/4hR3H3iwlTHk4TxQsRoSGeNG5iimm4NF7JIkG6EeQh3/S17GMTcWYTVu3tPX3KR8yX4jmCXZgRZ1Abc1ihxg58vK7a8dMboUL+jC4GtpnSMRiMNqOShiSflurGgmb5hLh4pMVrobrvno0L19x++sonLEb306ubHDT4R28+MFs48NHDLhJyS0cBm1u4VqKuZ+bKUFSSzBis5KQaJi9ncLU0LkWEa8FbLWVozvn1tUVScRVvuKWBQO18Cxq3Ye4rckgUriXlra6R3T8BHnVg43iz2WfhTP+lClqfKTXd+7jk0glxmellfWMyo2pRDDRPAjTqxSjxQQgvweDq6G/KpVHZEgKP3LoPR0vGgyiPetj+CYgAuddX+rSrdSotgKZ1opMOMyLpb+YkCj/biqVnAr+W/fODIvfYMlv0Edgs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB5384.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2kyYStuV2dLYlE0c3BCWDJHUmp2V1hCd2Yzbm0wZ3hkVlRtUVdaTzluRzJq?=
 =?utf-8?B?blB0TWhIaUVBWHg1Y1FyWTlvZENMb2tsZHpHVS93OHplUWM2VVhIdDd1Y3VH?=
 =?utf-8?B?eEtpVmxYQ3puNGpMbENrUVpiRVFDbjhqanY2eE1Ca2kwMVhMTkM4TktzVTRC?=
 =?utf-8?B?U3ExcDBrYnl5a2p3YTl0YWN5Vlp6VXVpd0MzWXVoclBFbzNrQlRFckwwdGdO?=
 =?utf-8?B?cFc5ZEc3TnhTUm4yanJSZmtUajRMVUZXQjROVUdhb0M5TWNTRllBNFI2cTdy?=
 =?utf-8?B?SmI0UldINTdqemlMWXlhVThZY3kzNm5BeWE2SXViQy9kcDhXZUp2R0lwYVZ4?=
 =?utf-8?B?b0dCSUNrUjZsUVM4TGI2QjNMdUJ1andLVkVaYzFGWXViYVVPZlhVMHAyTWhh?=
 =?utf-8?B?Mnlqb3BNanYyekRRY09MZTExTit3RHpOTC9mOFkvMTd1a3NOVHNvbHhSYy9l?=
 =?utf-8?B?bEREQ3ByYzFYd3FoeW1HSjBldGhoZzZISGhFTmdVRENDTHRwTkZyc2RnOUFa?=
 =?utf-8?B?elNoSzhmdWRURUJJb1ZTdFZGR2dTT0RMenZPYlVhT2oxK0FyUWNrM0pjVklK?=
 =?utf-8?B?MUtBbVBZam9uUHhPMHlNNHRLdGpxQVNwam5CNUcwd0ZjT1hDaElEODlKeHU1?=
 =?utf-8?B?SmZZWXNEWlhPeVdzTHp0Y1F3aUlvb3puRnFFRmYzNkMzckthMVE2bko4aTJk?=
 =?utf-8?B?OTRuNHczeWhEdVJzaWlYQnlrOGx5RnkrNk5qSnpPRzZsTFRWUWtMeC9Hdkps?=
 =?utf-8?B?OC9ucm03RlJ3NVFpVlQ5M2k3OW1ad0VaM3czVk10R0NXMjVYWGZoQWhXa0M5?=
 =?utf-8?B?OVl0L0pSUVNzU0JNdlAyejBCV083ZDBuMmNFSFEyV3pNSGtzakZhejlMZm1K?=
 =?utf-8?B?Qkh4ZFphYTEzbnJaMHlkRmVmaVNEY2dteGI2Z3duY2tzL1FsclYvSkJNeGZh?=
 =?utf-8?B?eThJa0h2SW45Y3hJeW03RXEvbnd2eGQ5dWUvMHA5Y2ljSVpibytEUVhxM3dp?=
 =?utf-8?B?VGlUdFl3TFNVa0daMWVwWUwrWTUxTnJlNUY4K1VVQVlYcjVsTFdPNWtRakJq?=
 =?utf-8?B?UGwzVVFZTTROcWVYMmt5SGZoTUFmZXo2cFRib0IxakpRUEFkWDdyM0ZKT1Za?=
 =?utf-8?B?TkVtL0RMeGdSOFhvR1pMK2o2TGxFUHUvUzAvL1ErNkJnSTNsRC85MVRBRFkv?=
 =?utf-8?B?emRsZXdtbEV2T05WM25TdjY4SWxhRDk4R2o3TkpKUW9xYzhZM1c4R1hDT09Y?=
 =?utf-8?B?STJBUEVyWEtFdHdRdm9CV1FLY1VFbVhpOW1zaE1TZExTK00vU24yaTdHYmpv?=
 =?utf-8?B?UmIrNTZGYkN1YjFPRk0reXlXdVlFTzZqUU9ydmF4T2lQRDJCekZ2YnY2Vnpw?=
 =?utf-8?B?S2JwWVExUk5Qa3FUYkJCb1UwZXZkd2tiNWxDOGJxSGpoaWpvZ1JMWnowbCtR?=
 =?utf-8?B?OWdSY2Rra2gvOFI4QitobDVhZ3lVWlZvRUhmWU9DTmc0ZERTS2V6OG9XV1dk?=
 =?utf-8?B?T2RiSVlsT1dlLzRoVFI5bGd2Q01Db3BUbVBxbGJ6UEI2SkJwK2w4cnhOSVRI?=
 =?utf-8?B?b3pHMGtoSmljZDhLYU53ZHU3ZmdFaGpjbDFMcGgrUGYrVWk1aml6SG5WWTdJ?=
 =?utf-8?B?TlF6dDdHM2Y0UHJUSW9TZXM5VGpRMlZyVlZrRjJOelRseVpGVDEyWEtaeFE2?=
 =?utf-8?B?OXRyb3FJNlNKd21zZkg2QjNyVVlPSDZDVTNzeDlaRDVZMXo3NzFjYjJzeEtB?=
 =?utf-8?B?dXlrRjN3UGhFVmJFUTJUdzIzTlFqUC82WWhnSHlRY2loWXVmbUgyNzFCWFVj?=
 =?utf-8?B?T1pobVNmbHcwRy8yYXVYdnBlcnM3UE9Ma05qcEJrNlVZNXFBamhGbURUN1NG?=
 =?utf-8?B?ZUVxUmE4QVU5V1AzejVNalFnNkFHVmd5QTloRTNkaTFmVUt3dmN3cm5UdVJE?=
 =?utf-8?B?dWptODg2alZSZzRIVnN4ejlweDFiTDRPa0MreEo2dFBSRnh6eUxtOWl3TkU5?=
 =?utf-8?B?RzIxVmxPUGxWdm1UUWdLT1V6Q2QzYzdCVHZqMHV0SUphMThyWGNUZ3VyODFw?=
 =?utf-8?B?Wk83clRRb3JhVFNNYTcyd0oreGtvY1hxb2lnS2xYQU4zOHI4UnBtbklzTHBZ?=
 =?utf-8?B?bk16NS96N0NZNzdoUjRNanZ4cmNlNlpWSjNSRHdPR3ZyaE5vaThMNVlHYUZJ?=
 =?utf-8?B?OGlkMXdqY1BWQjl6V3JiQmpvSkZuRmFnM2l2Z1ZJOGdDbWtSTXlHS294VXQr?=
 =?utf-8?B?aERGSGkxSnNRVTBndk0rWnIrQ3V6aHJmblk1eTQ4RDVzM0xFMHREL0J2VUpx?=
 =?utf-8?B?WW1yQzRvOXk2NEZOVUJpTzAza1ZMdXdneVNHUDZZN1lTT0tVbFpPdz09?=
X-OriginatorOrg: btesa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df572c6e-a129-4287-6086-08defa027a62
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB5384.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:49:28.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f51efa09-da77-4b78-95dd-fde75cdb9c62
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPEnM3gKr0xmg9tDH4MEkfqomtpDHpIBA2LnDmCNTk9zhY9GQs3P1KyIJh31jR3aviNIKg1pab2d9mOTai09UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9562

Patch 1 is v1 with the (long) cast dropped, as requested: pending_pos never
runs ahead of producer_pos, so the unsigned difference is the real distance.

While looking for other places where these positions are compared as values
rather than as distances, three more turned up; patches 2-4 fix those. All
four are the same class of bug: the positions are unsigned long, they wrap at
2^32 on 32-bit architectures, Documentation/bpf/ringbuf.rst says that wrap is
expected, and therefore every comparison between them has to be written as a
difference.

Patch 1 is the one that bites in the field: four armv7 devices stopped
delivering events after exactly 4295491360 bytes had passed through a 512 KiB
ring, and with it applied one of them has since taken 10 GiB through the same
ring with no stall.

Patches 2 and 3 are both in ringbuf_avail_data_sz(). The first replaces the
max() of two positions with a comparison of their distances to producer_pos;
the second reads producer_pos before overwrite_pos, which is the order that
__bpf_ringbuf_reserve() documents as the one the consumer must use. Patch 4 is
the userspace counterpart of patch 1, in libbpf's consumer loop.

The review also pointed at __bpf_user_ringbuf_peek(), where cons_pos and
prod_pos are u64 locals loaded from unsigned long fields, so on 32-bit they
never wrap and 'cons_pos >= prod_pos' stops working. That one is not part of
this series: it is the user-space-producer ring, where producer_pos is
untrusted input, so making it wrap-safe also means re-deriving the bounds
checks that keep the kernel safe there, which is a change of a different
nature from these four.

v1: https://lore.kernel.org/bpf/20260806130214.66028-1-i.tellez@btesa.com/

v2:
 - patch 1: drop the (long) cast (Andrii Nakryiko)
 - patches 2-4: new, the other 32-bit wrap sites found while reviewing the
   rest of the file and libbpf

Israel Téllez García (4):
  bpf: Fix pending_pos walk on 32-bit ring position wrap
  bpf: Fix available-data accounting on 32-bit wrap in overwrite mode
  bpf: Read producer_pos before overwrite_pos in ringbuf_avail_data_sz()
  libbpf: Fix ring buffer consumer loop on 32-bit position wrap

 kernel/bpf/ringbuf.c    | 12 +++++++++---
 tools/lib/bpf/ringbuf.c |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.39.5

