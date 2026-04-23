Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9F37F8DF
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962755; cv=fail; b=u+AIiJPN8O7NKrmohbYad1OvJkJ0Yx0E4VxWtucKhKIl/5kSJyZN8pkh2OSEx7N6m1VsbHzi5OCUBzP1jjXtk3PZqLujbmV9EN5XMG3edJSlp8R74kh/+wFOr9qSFcuwMfzo0lAP3785koi9xqIG9QmrTTFma1V7WX8tS52MelE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962755; c=relaxed/simple;
	bh=jczY6o3E6ix6rxYoumMXGpr/nY8C/1h8PTvC2mf0+nc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JZ3YEchqPkMy9DNSvnyIe05WT8gw9cWPqXxC9Qhnue7NMfVux3vMyjhk/FJNRoiygvmVuvbJ2Cy0Ckfg/GENUOpvyLxyXz4R2BWnSSnabE+LUA5CDDHQnSWNrdvWTI55GvVLcvGIqDJ5cJ8ntagnwENR76cbqJAGfMRu8x075VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DeZmFsIq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XWhSoblF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DeZmFsIq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XWhSoblF"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N7LvuP3738297;
	Thu, 23 Apr 2026 16:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xz357+ZTknSMmobnX2lw90WGV2TrlgwL1j1iM8efipE=; b=
	DeZmFsIqrZ87mnZzqqk9Brr65TiBib0JUaIQIUjcpL76XNl0wPv89URZujfGQgOZ
	3TyvNKq/fNGhQ7+XIiG4vvnnnQANILbbflwbKn0I4BaqG5M0WZ5HKVtNh6pgcBI4
	AGi5IiUhtXQiEEgDBsJiN/vQq+HBdDDNYDr6uUjtMDkPqby4hC02CRElgFUIvmeo
	aHSvftHLG/pie7d+Z0JWBbqChvprD/CZRkXI5QRSgw1qok0PVimen0C6Y+Q7L/pM
	x873epNxcRuRB1y7D8tU2IgBMDp8dB4IWiXF+XKdS9ZtOS6XdWa1BEf81ydv1m47
	ZX4fgEGbe/apl/96UOGmYg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dpenjbtsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 16:45:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63NGaD2M040900;
	Thu, 23 Apr 2026 16:45:29 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dpjjg4hxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 16:45:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/dpwUvaiZy30A47b2PxfON+4ziVLUg9yVqibkO28RhkkdfuSQrrI23ZM2vm1FD8e73uoEYiAFBe40MrCwZASAJUDJzBMacV1vnpKyNtGNtaEDJjUgeI439Zu5D9g3Wr7IsvAdVkGT4blFdoR+BY2pQc4tW4BL4av0Ph39VWON5+um7wcBm5J6LLPtnjKWNLffRYEh/g/bnlbxOercYZ20e8dHCeNhflh0NX4LgSTtolmsRhmXxXdB8ufZ4JL5oRqBEL2SD9WGyXvaLAiH9eVq80Q+bbLr1ZpmCVbLTgdFKFb68z7g2ruoyLXqoqqQ8yBxQAt58C7/zrbAIuCpV8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz357+ZTknSMmobnX2lw90WGV2TrlgwL1j1iM8efipE=;
 b=jT0vZ+x2z3XlUoaXFHMaBmLXmuDSt9zCvvrLx83lNMvOqmfoXm5iZaf2ZXrYD4WWVc/CFtLq7WNxobpCwktniU4Cfky/fZ3YGUsWF4mvpDiB64b1onLq920c41XdNipE+NJ35dawQdLRC0EHpQZ+r1nRj017ELWeQvLc8Xa62MnQIGcJiYzQLaKmy3LgnfJWlwTo+a7XtPktYUY7nNQWoFixPebYyRH+fedp/XeDmfJGPHNhCSJTFI+2NxQyfs0iVwoW3zt39Wb8TM0amdPPXMH9NOkhlpM16/w0EZdHX8nvB03Pl0SlxMspA8XuCN26EdVjdt1COnTSdQ6luwYMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz357+ZTknSMmobnX2lw90WGV2TrlgwL1j1iM8efipE=;
 b=XWhSoblFzx3F2Us+dyFzEYky2b62JgIihtt2C66P14ppalpSKkLR0q7NcHLA9vy5z9EGwF42qXEorJEfXLHAALwcHr4Vk2lTXMrYDVOmedkgygT8dsHZsAOrBrg0xGkezVZsrXs00WSp54laJE46kupWeULkfceIkL+jV233BhM=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DS7PR10MB7346.namprd10.prod.outlook.com (2603:10b6:8:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 16:45:24 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 16:45:23 +0000
Message-ID: <01836973-75b7-4506-9bae-72c8ea08630a@oracle.com>
Date: Thu, 23 Apr 2026 17:45:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: Fix type size overflow in
 btf_type_size_unknown
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org,
        sashiko <sashiko-bot@kernel.org>
References: <20260422103206.533695-1-alan.maguire@oracle.com>
 <CAEf4BzYgTt=bgx-KYjBMU2PvnfV2=LFXu-pY-L1yOzNpxoraTg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzYgTt=bgx-KYjBMU2PvnfV2=LFXu-pY-L1yOzNpxoraTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::10) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DS7PR10MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a891e3-57d9-49fc-8241-08dea157b6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	k8XkNndXHRejcIxWXkzLd8pdCqdQ++Sy8k4Io+XYWIQmjK11G3lHRE/FH0rOoeCeWt4i2vXZTKJS8Boyni8eUvZyChHzEG8TKoq5JxwqmMDNoC+Y77ZAz/G25TbPDKIhmT5LjKs8MzCgSDhPbfJl/fX5pBreY2sAdu0lzZ84p21tN/MeuuiwMTHvCijQ7jQEsSqGv+eo7loz7/bdT3Na6Fkw+dBU9lfTPlMF5xiXXH+4xz1zomYcmjRLowrkIY47LkAJ1Znm42A9V9jeVg8xWu7cUOBeuERhjYaMJqWKPWL0+exbmtjFA+NEsxGAGke9AGRH4QSFoLgQZPQ6YcBCYLyzSxfaQblmHgJe0tdn4slOF+gLCGV3dEx2EVEq8jCMi/o/lKjTeDTSq1aDZDCoztitWfHHlJ1hcld4z2KM/fHRAASYOWI/f40YBHVxKYR1BdzXaVvTxbYXlqp4o63RTm9t9g/dne3QO3iFZoSU8mTuHthzqpTZc4gCgA8tX7sxC4hX4QQCMIdFOtYlWOZvtX9PP6j/nKnpMdIn88nuHCaRPtco08RH0LrAJO9CZlp/qgOLE8y7Tl52N1engjRpubKTyfLAy5/gU120ZgNXZslX4MjTZCCIkI+NxhyQ9grjrnKASmE19mAh+1vzwbetTbJnd8c7bvhUQZk6KUYszjhbeJtwF4rnn6fJqx6uL+ya4V12lMQz3n58elJbAcUYWAhz6F1ET1nOaXboZ9uKfXpwWnyG/MUgG0/hxx0tN2rd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N08wUmN3YXBraTRaVVlRYzk5ei8xbjZCZmVBK1ljTmNadmRxcG1jRUQwMUxv?=
 =?utf-8?B?bXBiOGJ5ZkptZXE1cFZZY0JacE9wKzUxTVBJNnRlcnpZbWg4aEF4VXJpb3B5?=
 =?utf-8?B?aGMvdGxUWUFUditOM3A5Ni90bmhUL3VBTzEzWFhDYTVENWYwYncwaGNPUjZy?=
 =?utf-8?B?VU9GNTJDaFRrcDRSTlVObUxNK25RTk84TzVaTit2anJoSmw2bzgwaUJKOEdh?=
 =?utf-8?B?a2dpUXBHSmgrZ2gyaEtTZXd6bUN4RDcvZ3hObUk1bXY3MVFkMUdMYWpKTmo0?=
 =?utf-8?B?aWVQTGU1dWJBQUNuVnZEMm9hMXVHZnBWcmxBVlNDT2tBc0MxdzlrOWpCWkJD?=
 =?utf-8?B?bnFaZTJ3cjhvSGpNbHk2VW9WVVRRbzZHNjQ5c1FrUTVnbWl3VXYxQ3pFODd1?=
 =?utf-8?B?NmlDTSt0a29jVGJ1TDN4K1FQY2thUWNjQTBBL2xyT0txTHBYd1FUMWtoNlho?=
 =?utf-8?B?TnJrTURvTEMxRDdsZkFicVRTeUlSZ3hhaVR6SzJ1R2RTdmYyUXljLzQ5dmg2?=
 =?utf-8?B?VkZXTU9rVWJOeXZESEJrOTZzUElYKzZNQjZ1enRVUytXd1EySUlKNXZvZTFt?=
 =?utf-8?B?ZmIyNFYzNVRScWVwczFkNmZvUTU2aWU2ajJBMU1XbGNLeC90UWRnc01RajJO?=
 =?utf-8?B?STR4QTBsMjRoczBLb2RRTE0vcm1LK0FsUWZyR3dacC9vaTlPSnllVUlQMDha?=
 =?utf-8?B?K1hNay9SL1dlM09jOGE1QkVyM2dTcmc2bWhhMjNOdzdoTWkxbFY1NFI3Q3VO?=
 =?utf-8?B?ZTJaZnN3OWVrYjVHWGhhV3hKWnVhVWZNMzk3VVpob2pPWCt5OVlKQ0l3Z3VX?=
 =?utf-8?B?cDZNQlJnUWRpREM1eXg3eEt0dU5sRzVvaXk0SExISTVqenA3aTF4T2J2dFdj?=
 =?utf-8?B?VXdDU2dKTS9Pa3lQWGFiMkJ1WkYxOThUS3FNanB3V3dSR2JHNWxsRTNTazI5?=
 =?utf-8?B?VWZjSStDdkR1dlIwajJ0K2NJLzVEY2Zqa1kzMXhoQ08xL05Kb2JDYXBacisr?=
 =?utf-8?B?bTJwSk5LRkU5MGJXbHA2Rm81bE5CckQ4THYyeFEzMHAzNldCL0N3SUNLVW91?=
 =?utf-8?B?b1RDc2VaUVd5NlI2T2FDUVhnNHYzVXcrcThrSlJkTjJ3bGNyQ281eHp1d1pw?=
 =?utf-8?B?SXVJbCswM0ZZZEkrNUdnQVhoZVFrTStiaTJtNElUZnVtQTBMWk10RXBxanFT?=
 =?utf-8?B?SlBPYSs0REMyMHBhQTRreFRLRUlHTFZYOUNrQVZ5cEZDQ1E2azZpa29waE9p?=
 =?utf-8?B?czlBajlZSVJLaXZGNFdOckM1Y3BUaUptaGFYNm5ERUdjNHNXSmltYTkrMFJK?=
 =?utf-8?B?OEE3SDcwcEhtMUMrT2ExQklyUUZUL2tsNTRIMDN3emhrOHJhb0VtaWRqa1l6?=
 =?utf-8?B?UmZkSGI1L0xNcmlLZ3ZWVzM0Ui9zOW8rNXd5Nm5URDlNaXg5bWNVMUdQMnB6?=
 =?utf-8?B?L3VKZlNGTUFQNUszSXBTRXZzZjRoMlZoZnRUUjFIVXFVSUlrNEFYRlRrQ2Z5?=
 =?utf-8?B?VzZZR0p6YzU5Z0YxcCtXa09FRHg2c1JQdDIxUjVGKzdOZEs1VFFBcnVBVG44?=
 =?utf-8?B?Wm8vbHNFVzRua3J6WndyYmVVTjJqMEErSWxGNm5sYUZBVHhRNytPNGYySlhr?=
 =?utf-8?B?SUQ3ZUlmVTlSNk1ENW9zd0U4OXU2US9HS1I3SjhvdWx1cGVwK2luL3l6MWJH?=
 =?utf-8?B?ZzRTNldEOExsVFg5ZUJkVm9pRnIrN2Y2S3JxdHo2bkxPZlNJSFhLQUtVSEcw?=
 =?utf-8?B?UjdOdk9TUWo1b282cFRSQ0Y1RG9FK1gzcXhSVHVPeGZabVNvdmpyS002QmdN?=
 =?utf-8?B?Q0d6VUdDZWU0ckdRY0VjcDhZU0VMVDFWbGlHTllnSWpTN3dLRjBKZ0M2YW5i?=
 =?utf-8?B?cmVzS3hvckc1L2NIcGpBOERDTGxYTVhMSjYrZUF3M3F1SXlmVk8rOHNZY0t6?=
 =?utf-8?B?MDV0b1BST3VveVFkVjl5VjlxZldNbTFoZ1UxbG1CV2NiVHZaWGlvaXhvQzEw?=
 =?utf-8?B?RVdPRG5MQkhWZUprMXNIQWtCZEw0VGJGTEtDOFJONlNKNDRCcmdZMVNCR1RX?=
 =?utf-8?B?MUtmMXFHUWlaZnpmdXRtTytaaFFoMXROZnQxbXY4dGZMM2xnSXNmR2I2ZXNX?=
 =?utf-8?B?RCtIWFZxcGJOdFFjd1hOK0pKYTkydGtFdDRXS1kvQW1pbk1jUlhmYmViWVNM?=
 =?utf-8?B?UFJkanJydERLSEJweVVubFRvdW5ScEpzY3RES0haVlhOMFlCQWVCSUZPdkor?=
 =?utf-8?B?MGZ2Z0I3THdnOFFOc2Nxc2srQ2FTT2RYU3I1clVkWGVxYUIyeHcrT2pHc2hP?=
 =?utf-8?B?NjhzbVlEOWxySVBIdTFtZUlVcFZsTEZLWkxaWlZLbEhqdllVM1NrQT09?=
X-Exchange-RoutingPolicyChecked:
	uMzy9QY2Fa0YPC1lHgqo+vUY2qr/LNNxcbIs2HPo3+WdgBlWmkXv9gpoYfTLwyWEsCnAup7U7fwkOszQooMa+ZfVPDQQkbRm6IAWp4Nuamu27KEIOVlFnl+UOQSA4H/NGaH3IFqdUMzls9CXFthuf4Nl9Z7xL0ICBJAK7FExntwOcDBn29QtOrH1nCgeKKJQW4fYOvqavr/QRE5mKuKD/tkrUf0kESmemuJ28cGpehwR8RXtthm5PWmszQcXen98qEcKASUpOH+g1tOOwX8EzWt2gVp2w4+nySe7L68LHi4a+2KD0fXstU5bvWkORNGHd6LAepCxc3PrdyCdHByh6Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jAMlR1tD3qnc8DEFt0MpNKGJcSy8c0aUgmkKXZ+MfevpL7AVMNEbf3DO5LjLd4o0YxrUse2jtiVnAdpMv0anhu/F8Ia9TMj3mhwQbLtUbDmSNLKvIcK9H4uQvyq6G12SL2Erv0cnGOZBC2HiR22FQmraPtlFEMxTAlLEweZbof7M7dTnw2ky78hc+uSORTEj8+0QBXnjDIURY1ZtRM/hCFLKs96TsgKN8JcZDRpC4Jjz8/o4nv0H39RXXBagaw8j5rt8hA8gwJDgXpBywRS3sG97zYFXwPX3BxkuKdHWMO4SYihpsBCESS5yzU9vo37VFClYTFIHbf/9mhoZeNzaRW81gieJptI9lhMCv4/dOOdAokg/6JqxuoGx/Ib803mdwNuJ9NAVEzJOTLCFwGGGXQkionciuvXD1ogQaGxyx38fnAG9Lw4FfaYjeTHOOPbOuQKA0HVYt0jD2QgUFYHeujT3pix3tBJ7aq3coKdEw/XUZLzxey8hQFgelM7ep1yjjGxCNIgtwX3RBmACrBhrJvsCJ0sUNEHbMCY5uKHsPw1GWaFv9F7Kj3ub4I18/8MHqs47ivlcyieJCn/zyDi07nb5Uw/HyUDOjAzme2lbIgo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a891e3-57d9-49fc-8241-08dea157b6c0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 16:45:23.6921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xvJJb2Su/nbEIdL/AT5DPJrOGNsjtzUxhWo1yuvHsKN9omZiABbbyOPjVxyU3Z8WuCrooACXGrrPbQC2pdu7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604230165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE2NSBTYWx0ZWRfXyAdR2V0vk2CY
 +JIJEcAAx/WM9DuHpQ3jJvr1OHF/K0Cj/jzX4M1n7uzAGkySCiPQgom7yqJAB5Z1Zmq31gtCmvM
 tuvl4PzbdEsuejL2NNGeqSyosP+hgHsmZiWph9HByIzsr99vRfRgZ1M9ClWMjQiqicpB03e+lX8
 mL2y+Dsp0ksSaZxVlRZgmDnsALXuMiC/xtBRSKhy3Z1o8TuVSMHjIFYGD0DaOiNQA6VuIwSj64p
 rhOQ4HyJJGnDKDGDA9crnuiZDXMq6cP/VBwn/S90k3xO71vmzAtRXdYUcqI6IwBA54v+79ROSaC
 EF9prrw0uDTIXE+DaEw4OrAZfaC44ZUcgB6uJCMNGCJRwlFset6xVct58tsWxa4ZOgR6Xx0DB7n
 dJVfU3HjnyFXJt5jzDq8DZwLNj2PIc6HJVV/68PTs4SG+YoX98B11gok9nN/e5p2R+TBDdPq9ag
 M/m1kUm1P+2zKCY612g==
X-Authority-Analysis: v=2.4 cv=Xay5Co55 c=1 sm=1 tr=0 ts=69ea4caa cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=whr-fATYU9qSxJfbpLkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Sk4_vVL14wIcw1ssqNOqu-vdSMsdhg-Q
X-Proofpoint-GUID: Sk4_vVL14wIcw1ssqNOqu-vdSMsdhg-Q

On 22/04/2026 22:22, Andrii Nakryiko wrote:
> On Wed, Apr 22, 2026 at 3:32 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> A layout section with a large elem_sz/vlen can lead to a 32-bit
>> overflow in btf_parse_type_sec() at the point where a large
>> type_size is added to the next_type [1]; a sufficiently large type_size
>> on a 32-bit system could lead to the bounds check
>>
>>         if (next_type + type_size > end_type)
>>
>> not triggering (since next_type + type_size wraps to a value low
>> in the 32-bit address space).  This would lead to a bad value for
>> next_type when we add the type size.  Avoid this by ensuring that
>> the type_size we return from btf_type_size_unknown() falls within
>> the range of <current type, end_type>.
>>
>> [1] https://lore.kernel.org/bpf/20260417170712.74E77C19425@smtp.kernel.org/
>>
>> Reported-by: sashiko <sashiko-bot@kernel.org>
>> Fixes: 2ecbe53e0e991 ("libbpf: Use layout to compute an unknown kind size")
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
> 
> Is this a real issue? If provided BTF data is corrupted, we don't
> really guarantee anything, do we? And if it's not corrupted, then
> 32-bit overflow cannot happen because btf_header cannot even express a
> type section bigger than 4GB.
> 

As I understand it, it's the sum of the type_size and the current type pointer that 
could overflow on 32-bit systems; so AI seemed to be saying if the current type pointer 
was high in the 32-bit address space I guess it'd be a theoretical possibility for legit 
BTF, but I'd assume other things would fall over prior to that (how would we even read
that BTF fully into memory?). Maybe there's a way we could finesse the AI prompting to 
avoid garbage-in-garbage-out style problems for libbpf, not sure.


> I'd prefer not to pollute logic with unnecessary defensive checks
> meant to satisfy AI complaints.
> 


