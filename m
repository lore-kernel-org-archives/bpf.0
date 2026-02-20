Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28EE1A5B9E
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771630635; cv=fail; b=a3Gt1dtJOw5rZjuUFgS5Pflk/1MQxhvRbalwo4kgX/4CoiUn/PL8/btTxvSkmJ8eR52oz069lvxCwDRQkg7QrydxHTI3Q/VAlxaX9yw1bzT1QVAII5OkS06pG/tM3WtBGmPCkzDnbHvXm2/6c51I1YfhAAu/kktXqb2xn55j42g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771630635; c=relaxed/simple;
	bh=8AJtcX21pSnRkyQMs8iubc9iMinUaMyo4gvuEfCJGHA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZ4N6Qv/b8qkXamUXwuSq6cs4O0zdRXfRQAFbcg+0nr04miRV/f1S67RlGBEDUD10UkJ0Wo++4TWSoNmXNIRMS6OyrvmxBozpnCVE1X/jIHPjg5epRuvw3TNtUn7U3LLekSEmUUwjPDFo8kPAm50PkUIVSvzL2oj+wbDSDsGXF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vacb0Wr6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bNi8ArX/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vacb0Wr6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bNi8ArX/"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KDsrcS967977;
	Fri, 20 Feb 2026 23:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=noUK5+slE/fH+AA4kXY5T86L42nHbAn+OqotkNhcSaE=; b=
	Vacb0Wr6dhmjjtNSGNmThuvTsWHPmFma9f08wFM7QM16fNvE6PgMfyCAzBHiJxzT
	NUu8nJnS1RODX8jDSmR30ghmG3unK2+Cbqp0yzGvBT4KyzPxHfME0c7XHE5QsZoA
	/F7/Wo6nMnrr610aeluOZzq66rqKpx7/aVfD3EysiqwSvfG3JeYKf9/WB0GfX6Mo
	vntLblidXaEWU6pA9CuJw5OFsTyc7snSd31CbBFdQqat3p49RKMWvsBGkVv9vRbD
	3N9VLT8ynyI8nSuoyk5bq4GYXTz3ijM1c4x6ZnyAGAGNsWN0VJBXfkRIF8Wf/HLR
	RW1pZYNR3QQ7hFECVABkLA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0b2632-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 23:37:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61KLYPAN015367;
	Fri, 20 Feb 2026 23:37:11 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb26n4tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 23:37:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/LMkI1WVGaG/1smsVBwd9sKDBw3OBvdz2QFfIo3TUn+r5YEw4o3vOCZ3CmQBLoNrxTfrV2Tb+XQY7DEn3tpr2l5tdd4LBH2bHsfaG4hyXprpZu/Hr2mKi7A0G1RzefwKRNyBx5/eVsxA70GqvIHDCc7SuvkKDiOtdklzz0qZebsNGy41WZCmU00XFEXIbFeuAylpN4pixvWA5E9tsNeiLKICnRrFj2RaiuGJKPvdgYRdFpNSNJnVphmLeSBYQKyPADBBi+K6EUtiW+vv4poQvSAukN4sy5jKY20jy4mufBCiCm/0rnj8QorHbzAwhIOE4uyTNOhRfPFKTcMQKJChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noUK5+slE/fH+AA4kXY5T86L42nHbAn+OqotkNhcSaE=;
 b=JRXN910jFRDAo/EFPMgQ6aqYVKrlyeg/jF9TwaDHhzDp3k3QWrcKlGv4hp/JZsgPiJvqkeDJg7r6ewusCGrKGOcopd4pLRvXyacT233xRV2g/QFCSFEzoLkCtYu20Jm8YORPVvPcxUpa0/8BpbSV99J4MhkrbFZN52GXlGK9ZeQQmEz0cbZGNSkZDpoh6VMSxPuAPgBHfcmSIvJx9UwdagHNu9GKqlu7N3CK78GAM5Yb8I+zZroz1M4oMyPYouy78mUweQQfwwS4EGszakWShBK2BpL84atKIuDuVYiS+gRKK9nO3fYNPQfUXrHAfOcW00Xh6cBEZrmIc0eFqMN/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noUK5+slE/fH+AA4kXY5T86L42nHbAn+OqotkNhcSaE=;
 b=bNi8ArX/l4QRTglbadAxBVjbTosNkJtvkd6WufZh44+ulCUq08wFKAaw9Y90dWXN/lqmSsZNViDsLYhjloURp005SaBflVlvifUlslgduHXefPOWZgx2kXpeXlc2JzCw3DACe8kLYVJ5JtHVOd0wsRYzGf1ferWI3j42CbJySSA=
Received: from BLAPR10MB5075.namprd10.prod.outlook.com (2603:10b6:208:322::19)
 by SN4PR10MB5799.namprd10.prod.outlook.com (2603:10b6:806:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 23:37:09 +0000
Received: from BLAPR10MB5075.namprd10.prod.outlook.com
 ([fe80::8f5:4de9:81ce:f5c6]) by BLAPR10MB5075.namprd10.prod.outlook.com
 ([fe80::8f5:4de9:81ce:f5c6%3]) with mapi id 15.20.9632.017; Fri, 20 Feb 2026
 23:37:08 +0000
Message-ID: <0e69c72b-c580-48d9-aca7-d2b6ac5901d3@oracle.com>
Date: Fri, 20 Feb 2026 16:37:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [[LSF/MM/BPF TOPIC] Progress on BTF linking and deduplication
 using the toolchain
To: Nick Alcock <nick.alcock@oracle.com>, lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, bruce.mcculloch@oracle.com, jose.marchesi@oracle.com
References: <87h5rcfqvy.fsf@esperi.org.uk>
Content-Language: en-US
From: Elena Zannoni <elena.zannoni@oracle.com>
Organization: Oracle USA Inc.
In-Reply-To: <87h5rcfqvy.fsf@esperi.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:930:10::28) To BLAPR10MB5075.namprd10.prod.outlook.com
 (2603:10b6:208:322::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5075:EE_|SN4PR10MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c58631-b48d-418d-5b34-08de70d8f5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2F0V1JWZy96SVNQb1VOdWEvcDQ2U3pPVHlEZFBrbnRpZndzTGJNMjNxM3dB?=
 =?utf-8?B?SFlMeDFoaGhOR0xCODRpbnB1YXZkM2VDSTFFN0RzOXllTXhsLzVQQy9xSW1Y?=
 =?utf-8?B?dnRPKzVHZnVCL0didXBzUm5BU3hvTVBrTDNldW8wVmJyYlVwRjlQTzE3Uk90?=
 =?utf-8?B?Nk5xSnpkandZT0p1T2F4dE5uVUxXT1VpMUZTaEZXcEgrK0FnczNxV3VkWURH?=
 =?utf-8?B?ekVzNkJEelNJTitXeklUbjJ5S0hzSEMxQUZBZjlCR2U1Qk81eFlGd2hoZ2py?=
 =?utf-8?B?MlgwS2w4cW9DdWE3THh2cXN2Zy9kOFNnSmNXQWswNnhTOFplaGpGbHFwMHNi?=
 =?utf-8?B?c04wc0RvRUVVMWdZeGtXajJJTjU1YXJjZTRCdks3bjJuQThXc1loU1lvQ1Zo?=
 =?utf-8?B?WWFyNFY5TE5xZ2hNb0cwbWVWRHNQeVd2aTg2ZGU2NGErMXc0Zkw4TkxxeXFU?=
 =?utf-8?B?QnRiUjljZWtweGlmM3FRUExRZmE2VmhhWkJvc1BuS1BUYnlzM3JiVFY1NFdw?=
 =?utf-8?B?OFg1SVlUWUFLcW1pUUo5Wi9yUUd0OTI1cFQ4UEI1YmlaZUdmampHL1UwS0Jk?=
 =?utf-8?B?Q3hHSHlTRDdoOG9ORER2dytmemRXL05id2dtQVNhMlFtV2hZUitTTHViUk5x?=
 =?utf-8?B?QTJ0dy82ckVFK3dCRTIxbHNjbVZraUFxMmZ3emlUczVvMkFjb2J5ZWxjVDNR?=
 =?utf-8?B?N25GTFJCbVdZL0phRTE5SDZaOG5ReXBzLzd0TmxCTDlVQnpKZS9wTE05K2lW?=
 =?utf-8?B?Rk16dUh4NVZmMEp5aGNVb0E1Q0hUTDc5azUvVW9VcmZBd1pyb1dOY2VSc2Jr?=
 =?utf-8?B?Vi9BeVhPZXA4QUMydjNEMTMyZE51djVTa2xOSkg1cUt3MTIyOHh6Z2l1dWYv?=
 =?utf-8?B?RVdCYjF6UEZhQWY2U2w2cS9QakxYSzZoK0hXOWFHcWo3V0xrM0xCMFlaRFZj?=
 =?utf-8?B?ak1oTGlRUDVqNVgzbExmWnA5dHVlUEJmNzRIQmtLY3pKc2NROEpWRlBYaDRa?=
 =?utf-8?B?ZmRxUjVFL1l6TDJJM3pqREdyRlNMaDBhN2V5S0xLalc0eEhFY3VqUHVlT2FY?=
 =?utf-8?B?cDlzd2c2TDI4SWlVMFpkT3o4VkQyMlJuTHhlMC9nTzNpUG9yYXh1RERVcHhM?=
 =?utf-8?B?RHNySnZTdEh4ZC9xNlpjbmlJaHRPZkRqT1dvOGthNHgvcUNPL3VIOFBXOUVY?=
 =?utf-8?B?a1lVMzIrVE5ZdGVPWG0yck9YR0p5RTIwbWsrUHFXdzBkOWw4aTczdHVGaWhK?=
 =?utf-8?B?MzZvcC9RdnczUDVUOElhdG9teGNCQWw1dEM0UWx5dmNoYkRsaTJuSDl4bHRL?=
 =?utf-8?B?QXZiemloY1FQRk9URXBQV0dsL1hyeUkzbHdqTDVyRHROd0hlTFRjelE5aHVI?=
 =?utf-8?B?K0ZNdzR5VjNFMmpPaEJRelhxT1JkTm5VTnJ0R1IzQUpaTEVVQXRvU2VuS01D?=
 =?utf-8?B?My9GWm5NbWJVa1VsRTlwdnFDdUF3RGJnZXhKZEZmMHNTeml6WVR4aFdYN1hD?=
 =?utf-8?B?K3VwSUJ3cFM3YjBjcHU3bDVCN1J2bVRkcVd1MElKaGpOMHl2eWE1Y0NPTXUr?=
 =?utf-8?B?NzVOeUpCUEhSTytKSC9TYzlkeWpGYlRXdG1BVlB0aEo4Q1hMaFVwaFlaWHpm?=
 =?utf-8?B?cnZpZk5kSkdKZm1McUgrUW5IOWUxYzVKa2o0bFFXeWRGaUQxUkRyQ01hTGpw?=
 =?utf-8?B?c05uOTU4YVBvNG55TGVqZUZLbDFISlhQTjYzNmJTdkFMOXpnVW9qdldzMzFn?=
 =?utf-8?B?NUxoenViV1RIMkR3S3NBYkdzL0NqS0x6aTRiRi9QUmExUGM3NWI1UXd1cWJ5?=
 =?utf-8?B?ZTIxWTI5RHljZ0hiUTAwd0Y1U0RpWTVvUktkUjNYTEV1TklxOW53VFo1WVBH?=
 =?utf-8?B?cjFBcVlrYW1ZNkVWYkZ0NmQ4QUo2VFdxY1VlaVM5VzZOZVl1UlJPVXlGdzg5?=
 =?utf-8?B?dS9HMGI0L3c5clFHMWZUTG90V1JPUFJPNVFXNWNqbWsrRjRkbHYzNDFCSnJD?=
 =?utf-8?B?ZlU2TkE5RksvZU1tLzVLT0xQakt0Y3Uwall0M2JWUStEK2hFeFNDTFZCWHA2?=
 =?utf-8?B?MVBuaTV3R0pOdXl3VkRBcFlsSFJYQ0lHR2RQdGRiWXNoSksxeUI2ZGcyVnc1?=
 =?utf-8?Q?7VBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5075.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUNTOXU1VUc2dU4yZHJ2TjVUYkFkQ3M1OVZrS0ZFeERCN1kxalVmSW5wL2Zt?=
 =?utf-8?B?cXJKLzB6cFJUN3JTeVFtOC9vU1hEMkpjckx5cG5OVFFWbmZlVlpqaVhzMDVn?=
 =?utf-8?B?WE5uV1N3Y1dObWN0RGdBWm9OSmlhcko3TGsxMW9oZS94empDekxPenRyZFlR?=
 =?utf-8?B?OGJkMk9YYjgvSXJOcm80V1QzTy9BYUFXOXRoYlBBUWpkbUl6ZGpobzFFdlFa?=
 =?utf-8?B?SDBVUzVsdzFBSGVlRnhsbTRuazJveXRLcGJxbnhGU2R3YnBNWmxITEV0S3pP?=
 =?utf-8?B?M09sSVZCTWtDTFFpSjVWbzd2Q3ZEWHZuaXNia2dpRW1PZ2pLZzU3eDN4M2dV?=
 =?utf-8?B?SkpzZWxqdncvYm84MVYvQ2lMU1ZFL1QxeU9Ba05CYUZMV1MwL2NGS2NSRHBm?=
 =?utf-8?B?Mlgzd2FuUGk3TVJZcWhMNmh0b1BqaGtFTVlqY1JJT1lDL1FJQjVDRFVuaWJy?=
 =?utf-8?B?ZU9tdEM5TjgwSjZ0RVlvcExRaUR5K1JDQXV3eHlXcjV3TU5CazhtWmlHOXho?=
 =?utf-8?B?Qm53SnFTeDFtNXZzY1JhelJhZUp3WThwWC9NOTZEdktrRFpOTnU1aVIzcGhN?=
 =?utf-8?B?bU42dGdqc3Y5UWZuS0R5c3RoUk12b2hiZWNBWm1NM3phU0JWQmkxZ1Z5SUFx?=
 =?utf-8?B?UUVsNHdmM2pUdENjNDJvZ0kzNUFNYTZPNm9KR0twdnJJWW9uN2lpeGhnTCth?=
 =?utf-8?B?eXJmUWltcnNzYlcwOHhOUm5Hemc1NnhEdVVnVkpLQUtnd3B0bEM5WDBRSnRV?=
 =?utf-8?B?Q2E0ck9RY0c1cDhrREdCSnRCVkFUaUhwZ0N0OHFTazV2dnZ5QnphRHlvZVpB?=
 =?utf-8?B?TlYvb25KMkExMlp6YTVXUTZ4RlA1aFZMNHNGWTZyaHQrQzZONTVsd0VKcnVq?=
 =?utf-8?B?aDBSL2E3NmFqd1RDSU5td2V3OGVCdlI0SFYyNDJYY0U1N1ZmQ3FLK3pDeWE5?=
 =?utf-8?B?bHc5dEJpNllUUjQreHRKbkxLdjhwb0dHR3dYZXdjNkc5VDlYZFdBU0N6b25M?=
 =?utf-8?B?OXU0d3JvS0Evdi9lK0hxeEpjL0JhWFRsTjdBL0tKSjBrUGFFNStlZDg0M0FM?=
 =?utf-8?B?NU5KYXVqOUhoc3ljVDJhaWJJUGd5bU9ZVXI4NytoREJiZzhPeWY2alFzMjNm?=
 =?utf-8?B?dm1yN2RmZXRJNEw0WXdRUitwWmNSM21mTDRnaXRGZVRHK050b0dTWVJXNXhK?=
 =?utf-8?B?TGN0L1A3Q1luTEcrY1ZoQnRKTXNHOXpCRGhNSEdTQS9ONEV3dmJtcE5qKzVN?=
 =?utf-8?B?cndDMTMvRVNIbDY4dnplb1AxYnhLMFJOaGxqK3JyNVdBRlFSQ215aHdSTFlS?=
 =?utf-8?B?amtjQnNrMnI5Z0FRb0U5QjBaU21Tc2FzMHZVTUNGUktKd1B1dHJsN1UwSjhi?=
 =?utf-8?B?ODlEdTVORHhZYUFwcmdpWXpHaDRsalA5bGN3NnMrVjRSMVFFaTlNM0F2QzJN?=
 =?utf-8?B?TXc4bGFlRSs4ZDdzbW9aeW5ZYmJCa29KZk9VblZwcHlFZEQ5azlYWjdFVSt1?=
 =?utf-8?B?OWl2ZXlYMU1kMlJkMjM3WGpveER4VEZKU2JYemY5UThFOFJUMm5CR1l3WnAz?=
 =?utf-8?B?VlNDUkdBbnRoWUw3Q3JRai9rVXhBc1liekh0cnpDbllUUWl1N2dOZFhqa2NC?=
 =?utf-8?B?TTVWcnVyTnhzZzhPemk1YzViN0M1L0Fob2hwWHB1bVJrZis2L2EyVm5BcDVx?=
 =?utf-8?B?MWtXQ3JMNkM5ZEpGYkRaQUlReFBvako0SXZaa3Q2aGh3MkNSMDNJYTI0RE5F?=
 =?utf-8?B?My9DaFVzUmRrcmJRL2RsRklKZWhSTzRmVzRMUkdDZU9YTnRWZXg2VFJRK0sz?=
 =?utf-8?B?R1VUckI1Wlpid2FmTDl1dFVLQm1JRGxoSjBkYXNReGVLSVBzTjVjOFlraTVl?=
 =?utf-8?B?T05xWVNTeExFNEtXMTFiU1VhV3JXYmgrNmlLaGZHS0ZyYUpvLzdTd1BaTWpm?=
 =?utf-8?B?Z3FtblE3M01vWEcyOWRHVXpIUHpTc3FZamNPTTFvR3pSRTlaZUxEdk1FY0M5?=
 =?utf-8?B?bkxJWXhOYTVYUGFmUHNBeFhuWkVnRnpkc3FCMXJDZzV3L0lhZUpGc1BPbWcy?=
 =?utf-8?B?SnJqYWQ0eXlvTEd6VUlhemZWSkRJS2htU1pOVEJJdXhsRWxhbjgraU1QdkMr?=
 =?utf-8?B?K1dSd2UxL1M3RFBHcGh4ejVFdlFTMmNoZ292VGRUUnFzak4xczFhbkhhSGdM?=
 =?utf-8?B?c2RBKzJIdDFUblJOTGdTVFI1aXhzbVgwWm96cEhlcVpBTGxMaHl6TjRxMHFD?=
 =?utf-8?B?RHFXMmhIVm5ybGcxaHl6bVlXYWprdDRzbCt3bHMzYnBwNnFxS1VnSXhUUkZM?=
 =?utf-8?B?dnM0WVRTU1d2Y2NoZXI3TUV1TnR3WjhjYkdNYkNJV1h4V3RSKzhGMWZSYXYw?=
 =?utf-8?Q?w0u1dch+9qIpUcYo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	keECKAXkSE7N+p3izPRF7/ibSB5SajF/6eZbmbvylRmpyUnakNyJ8Anwhf/arW7wRh0N/V6CRZFg68O6IexR0SE+02UyuQgA3sdX//aJqo9aHeVI2UBbpUXUXh3c7mir1xnhbcy3lk0Fcqu9/g4GTI2bL+h4pJPCiNW44UF5aLmJp6lyci3Hx2FvAJSzOgEEjKq83rSPeeWelPOygj0LTWGsy+pRAwDoE3KtNwpcpOr+b+qU6oCLV20WJNUsjBnV6cdCz1mDGOo7wX09C5YA0rta3ngVLW09x1ozy9w7Ow1XF+NE8xzI3Aq5GzwGu2J8jWJ3vXc+HnionWUSG/rOOKPi+/JqQMoG/iRqN5XsrZVEQm3k0+ydeoZ0ilhgkcV5SAV6RvcXbiqaKnkk7+lnd81W/iNFdWPD51oCvhpvCyb5kI1Swbf72wlSxv/BOJEkvWV4neEdRqFTFjucvCJA+KC394yU1RGrdXDCCIbUt2JyofJsv50Ry7WNvWFRQ+RC0QPjw0W6dBAM2EUlFn6Q6f0hxCyk8SpChJKEh73khXZSPrj6acD68P/CLgXXvWDrVvqc011No7t/3KOSVDH020zVjHO7Dl8ajW0sbS/JZVM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c58631-b48d-418d-5b34-08de70d8f5ef
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5075.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 23:37:08.1013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4tT0LYrf5hFJ9vt3QXrePcg/vKC8ulLxV+AzTLUam2+FvySNS0S9qfQReIKZ4JzCM+XWR7wn6C6GYA7kc1XOLNA4HjIUSkcl4MPVg08i8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602200194
X-Proofpoint-GUID: SCLxxRXpYWGTh5-Q0PfYmNxzQZJU6g0p
X-Proofpoint-ORIG-GUID: SCLxxRXpYWGTh5-Q0PfYmNxzQZJU6g0p
X-Authority-Analysis: v=2.4 cv=UsVu9uwB c=1 sm=1 tr=0 ts=6998f028 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=fP69bkJT4T1ybanGQXsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE5NCBTYWx0ZWRfXz6AtvYIdkst0
 zd+PJyeCs/33tU6OVfSywLbjpkY78V6fWBgNl/pkKNjVHhIXT/dChttKAHu/S5uRB2/ovT90JHl
 9A1f9+u8SDVT+DDj5LQ4b34hJAQdFkCNOdEDaWHcmjzxKQMRDOp79BzsNeEfs5mNvhkP5rmkTEw
 FSjr8A8LYTS+zA09J7wRwKR4pA0NYAvAUrKmRVTpNu9ROUTzE3otCpLy7LOwj/QZr/Xcxv8ASzu
 ZjUUSAkyvlWgVw7wU8KyO+EvccMENu0DyrTpS1sspmKbfZHLYRA8440LSd5tltatFsXM6dKZGXM
 sRfZ0pBjW98q/RqStwBL9lerjVfLoteXOlGPbNShtmDFjm0nuQQHoS5GRVMt7rBAU984mcFOFTz
 FNZXqoSgkG+Pt9Dv+WIZoW+xl68ZHr5bR+oYT6y3NfXozYC86aOoi2lUhM/iYYYIff9ZlJu+h+A
 IXZt91Wc5LvA+slo+SA==

On 2/19/26 12:57 PM, Nick Alcock wrote:
> This talk will provide an update on the work we have done in binutils and
> pahole to support BTF.
>
> We have been working on pahole modifications, intended for use with
> GCC-generated BTF information, providing a more direct handling of BTF
> without the need for DWARF to BTF conversion.
>
> This is done using libctf from binutils, which as of our latest version (not
> yet on binutils master), can read and write BTF in a way that is fully
> compatible with the existing mechanism.  We also have added support for
> merging and deduplicating BTF in the linker.  In addition we can now dump
> BTF with objdump.
>
> We will show comparisons between the old and new approach within pahole,
> which will exemplify differences in speed, as well as the lack of
> differences in output.
>
> This talk will give a brief overview of how this works as well as a short
> demonstration.
>
>
> (Like several others, I'm hoping I can do this remotely: transport from
> the UK across Bank Holiday Monday is something between awful and
> abominable.
>
> I've added a couple of other possible attendees -- Cc:ed -- to the
> Google form side of this: if this was overstepping some sort of bound,
> since I'm not a subsystem maintainer of any sort, my apologies.)

To clarify on the attendance requests: (sorry cannot edit the form)
Nick Alcock -> preferred remote, 
Elena Zannoni -> in person, 
Bruce McCulloch -> either

thanks
elena

