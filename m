Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284545FFAC;
	Wed, 16 Sep 2026 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544618; cv=fail; b=D2e9W1XFQJMUXIdoU8bfPwUPCSlv89zNri8BGMRrQU04b0kA7X90lAk3TI521bU+78k1aXgL2HY1XZRSa384F7q1LCXC4rxbP2a21WvSWsB0VgrLWbG9DzG9x0xabYLe8iv4vNolvCCB8Vh1SDiPcS4cXUcJHUE3FqD1R1kqojQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544618; c=relaxed/simple;
	bh=q8Dv3sSw3/TeQ896ItxmIvfp1abMGBrPbvY1wpHqsc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kgok6HduLKksGLlGuC6/XUhGwiNHeg6/srine8QXupDXCm1+I3XeFC6tpy8vYGiTnfU6WIvktwnOZJRyOCr57/+VKuQcQuslb0u8G0E9zYK9c6Xchg3+mGO3FjAluS9zE6MNRHhnHbHtSi+9buUfaOS4zEflP8lKPdCTd4lklc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sJ1TjVU2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yAaG8spJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sJ1TjVU2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yAaG8spJ"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLY73u1308461;
	Wed, 16 Sep 2026 07:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K3SJ+Y5ZjCHgjSGkPOUY41yNjpnzuq0ikR4ij+Wxw68=; b=
	sJ1TjVU2eC5d2B/QQwBOzVHiID2xqPWow+VCx1iQvMZE1pAheqLLHfDiC2ouamjJ
	wnaLanIHBW8Vl6BNGW4E/4rANvTRsOVqwLX+adODPnnOAitYB27yMYOKyxzHgV+T
	hPC53M0lLYivjT9cV5GYdRJKnzSWJmkDW0UOTF62QBGS013SyxPUMQUVZFrOGgO1
	ff6QnBwPrSmPTyUqFzBmquSIL5BS5fdvGuUAWnwaYFzEpC+z4T7F5+hPEbcnP1w4
	k8O4iKToAOPlGZvme3ubwReELBgQQU1MtEcu9Q1AvccKaTYFPC2B8yeFVSQ9qOgz
	cFYmjYBmHHN8ph1dI40hVQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmwn9551w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:42:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68G7e4tl014958;
	Wed, 16 Sep 2026 07:42:58 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6au5s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:42:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y72ifDaFhUWhyYA8xDAiz8paw9e/RUVgnjj603d8gLAZ/QnSLDoZXdhlQ1BwEydYlMtvhVB1j9gkCT8g26ehiNFORrYfJWoixEtpMOP3gbDWSinjeweFD07d4ELm7RcSum5OmGrKmufklQ3O9Ft7DCodACa3+rnlyMZ+PsL/lWrko8vD2myscRPjrvdJuin9/ppnJGMdAx+TtorDd4pcELxomvSME0w6oCKJVXu8HYmUM16nHFOOLmaFy9xbeMlR3CI3gzECGrplOuuoNcyfyw+Z8LRAUpMZ3WyRiQDQR8MihchqYJ8UM3ezyh5Y/5Km2iuzAUWqnQHglDx480IWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3SJ+Y5ZjCHgjSGkPOUY41yNjpnzuq0ikR4ij+Wxw68=;
 b=HbZBVFCN6PPH16+GllsO+DVqjn5Tv5kKm06bssa/qJIp0sSQS4szRO+lmW+PkwBpf5oV2cGSu/iid9uJZG3dNlE0wJscpkTu+C5Fz6zN+nnem22AOx/yE2FACGO0YHQPtQg2tcQSMzM82dh2DVPhMgvZ/fho28pIscLLsDwToeWAGxS6gyMXZDEwUFxhoHdsLR+pWc8jdNjVFg2HHXBQ+8iPHbFTCs+EoENUTV8mVhW5yej5/kiWW6sydgBb7o/443HzD08y+4X90a2/v98phbnMBzMZvJfxlsUWXlUQogMS7V8uXctZVWOXYILNEOZjd/ZAVs4EwNodWqMbINeL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3SJ+Y5ZjCHgjSGkPOUY41yNjpnzuq0ikR4ij+Wxw68=;
 b=yAaG8spJN0Kv3nER5c2hdJpqmAcvvtIwojBJ1OKUn0vjuBBPu3zQr2J3psy3iP/juQBWO72AGRbObyb7cqpKGs/jVwmHB19YoonEs7SgygF46ZbJ7AQWCpBl2m4vAX3Wq5PSMsX0GO0WFEA5sudJTI5aTo6Z8eGic/h+reh/35Q=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SJ0PR10MB998057.namprd10.prod.outlook.com (2603:10b6:a03:3e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 16 Sep
 2026 07:42:53 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 07:42:51 +0000
Message-ID: <bf1473a4-7a07-4a93-905f-fd1ff46b9533@oracle.com>
Date: Wed, 16 Sep 2026 08:42:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 13/18] kbuild: Add support for BTF inline
 information
To: Nicolas Schier <n.schier@fritz.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, mcgrof@kernel.org,
        petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org,
        bpf@vger.kernel.org, nathan@kernel.org, arnd@arndb.de,
        puranjay@kernel.org, yatsenko@meta.com, atenart@kernel.org,
        ojeda@kernel.org, linux-modules@vger.kernel.org
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-14-alan.maguire@oracle.com>
 <20260914-axiomatic-meaty-lynx-8a5dc7@l-nschier-aarch64>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260914-axiomatic-meaty-lynx-8a5dc7@l-nschier-aarch64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::10) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SJ0PR10MB998057:EE_
X-MS-Office365-Filtering-Correlation-Id: 618f5df5-0149-4a51-2410-08df13c61cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|4143699003|6133799003|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	kvtiST/maIZodVvtjUBfwHU8NXji4Qr9lEGptXEeGCDLABzltanOSmo/hyu6Kgk6jAgIQ3DgBXVWONpG2ki2Zi//ag/HCtsf3/2K2M3/rlYhhae7KivxcM2ObnVK+v+VSeU7/PTrNlFs7TJ4xKimi6Bs1FPcVubnnpBCovh2E9eErY6R90bW4m3E9ivO5N80hFUSg6uRiGfZ2Gg4ZF3HJ6jMQvDAN/QfmEqp547ztbcqW++ULbsyQ3M3ef3xcatQl5MAvoCXG3AH3AIj7ibvj3zLeua1zRMZBk3b/F/AHF0UJd7KCqUasH3HeVu/9MSUZh14Ati04HsDE9beHproQNr3VukCDBjMq3PBWVO7poUuzopPlmyeOuVhgSo9MviJcyRClL7hUYcv+1qpXmbforhhUro+SfGrZesLT+Hnwb5UzGkjlv+R0OPzPVUA1ZoDZM17vR4N1QUljjgamfJrcMLcPasV0+NgoDVgGJFMk32EeKdfob4fTycE6Auoj/sAuxJ5aJOknER0Ngv+jJWspFWpIbNGaaCG00V6g4rVj6Dq83F2Rn/5m75nDmLH7Ns18V3YErZ8wpCKC9O3sRMczif7oh+VSkT6xfMks9aAJGutK52yIXK08fo9vUsBhHlCMawrseKbEwak1ZNBMspNS5ZUKd/u8GHG8AsbD/0iXRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(4143699003)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm5hR1NVOERFUVhxTnlGMks5ZW1ZeGlUMFBIL3ZMcWl4OW90NzM3cHh1eXJN?=
 =?utf-8?B?MncrQUErdlVIV0tUWkpFZlN2TElhdUNEdzZHTFBDRzNyUzVoN3I0VnlsOFRn?=
 =?utf-8?B?d0tzaERDUEw2TUdLUUowT3JrdHJ6MnlUQktacDJ3OG53TnZKcTdTZ2RzeWhi?=
 =?utf-8?B?ck9hMVVtNzBDUjdXU29hYitBeXdpc05ST05YT05UaExtZzlDY0IySFNHQ1JJ?=
 =?utf-8?B?a29VTThRV0VvL1FWSW1BR1BVOW13TTNXcjdVNGJVRHBJN3lGc1M4UHdhSFV0?=
 =?utf-8?B?d1Ywc01manJRMjBhMjMvU1R2eVBJd1g2Y0tYS01UYTUrUENQREV3QXVYOTNU?=
 =?utf-8?B?VDhkNVA2S3dtWEhpSXQyTkhDbDllNXVWdHFHVytITE5PVng3MkthZGE4NUxV?=
 =?utf-8?B?dXhDdWhHSmdRMzg5SzFJSys2M2RUZTZBK2JUV1NwOGc3am9qNDVud3N2SkZC?=
 =?utf-8?B?N2xvOVhuL0tNQWwzRVNtbkVUTFhYc3VtRXFRSGMyVVJEUXlxYXRiVnBmVmpE?=
 =?utf-8?B?MXNBVW1VUFBmKzVFYTNGSG5LNWt4KzV2c3JDb2ZadHZyaGJTRjNkb25KTFA0?=
 =?utf-8?B?ampNODZVUjRsYUFMdVdOUC8xaDEyTmJmZ0lpWFNmdkpQd0E3d0dVaStlZkkz?=
 =?utf-8?B?QUpkQ0hZQ3I4WFhzRjlFb24vdk54VnlsVC9OQXhUTnNkR2pSMW1WNDJLeEVK?=
 =?utf-8?B?THRQdE5qb1JOVjF0bTJma05WTWg4S2h5T3Yxc2xicmVvWlZDL0tnb3ZNOUZy?=
 =?utf-8?B?dWgzaDJPTHp1WHlzNWhzbzRVZnc2Y25MWEFqVjcxcEYyS3ZaQVVtbCtIUjZs?=
 =?utf-8?B?U0FpeDhSNmo2dWZhWkdNbjkxZDM4dHFJeE91VjNYem5Mc2xIQXk0TXVWZTB1?=
 =?utf-8?B?bUxscmxpMjQ4b3pTNVVCM2ZobnVCME9xQmJ6bWZXRmh4eGJTMlNETlNLSGNs?=
 =?utf-8?B?ZDRkdHB4YUIydmZydkJVR3pqTzdtdTl0czM3UGxRQTdreHNvd1U4R292OHlu?=
 =?utf-8?B?eStiVWkzWVQ3T3NJSG9uUGxMV3ZCSEFNSVY0bndJVldxakZhMUdocXNENGJo?=
 =?utf-8?B?VXM4c3I3TGs5Yk83ZEx5bDJ5UEdBRkYzZWN5Tk1qSmxaT0tvT1llZHV4WVFY?=
 =?utf-8?B?Z0tWakRGRERZU2toakpLUXpmTVp4V2xKcndxb2pLSXpsSXN3QkJZYTZZcFlC?=
 =?utf-8?B?NjNaYjNpa3ZQZ2phY2pjTHVSVjZ1WEc1bW96bHdoaWxwdGxYTE5wUUpuWXhH?=
 =?utf-8?B?UFNNeHM3ZTJrSzVIaFFrbUtONXhodzMvSHNXS3h0bHJFWkkwbEszY0VRd2Ux?=
 =?utf-8?B?Y2NIT25YeGV5dUswNHdLR3g3WEx2czRKVmtpYlJURmJxc2JQTUc4SkhSclZw?=
 =?utf-8?B?bUZtK2ZMWmZlZHY5L01QYUN2dUZrWkM1YTVFdFRLVVkrb0RzWE81Mi82VzJQ?=
 =?utf-8?B?ZnN4OTJaWFJEdzFOa2F0eUpKak5UODZwcWd2Y2hPSkZ5dzFvMVpaS0hwNVRs?=
 =?utf-8?B?ZHpnYVFqY1VHNTc3RzlKcVZ1WVFkMHkyN3htZjVSeml5M1BZNVJRdUg2eUZB?=
 =?utf-8?B?aFNJN0Izci9wanp6U0dPSlVSUTdsNHhMaUN5RGs0WS9FOTZ4eGpaejBGeUVx?=
 =?utf-8?B?dTdSTTUvR1F5QXJydWh1SnR4L0FlaWJnaUhUMTNEWjNqSFIzU2RLakpva3pm?=
 =?utf-8?B?eGd3TG03YThKT2FYWmNpRFlUVnA2RWNwOW9JSkNYSXpLMEhZZllJVGtHRk4z?=
 =?utf-8?B?NGxtNFhDdW5CcVd2NmFEUi9jbDhCS0hiNHRZR1FKWTc3MExTVGMrNGxhNmVM?=
 =?utf-8?B?Zy9CcFVyM1lJVUVrcFJTd3hBU3AwMzRDREdCTnJaZE5hY1Vmb3VqN3ZHZ0lD?=
 =?utf-8?B?aUxYVzdpL1dCQjJOZGM5QW5la25xdGVlTGhLUUhGNmlvV0owMFVTVmlLUmZ6?=
 =?utf-8?B?ZFBCeG9aR0lpcVFJcXR0ZUJ1VlZHeEc0TXJTUFQ2VkZqSnJHL2R2NXAzS3RC?=
 =?utf-8?B?cWxEYWx4ZFR1QUhpY2FGRDZDeklpUDZCR1pkK3hmR3VVZTk3LzdwN3A5MlRl?=
 =?utf-8?B?RzdFYWg3ZXkyOVlPemVOeFk3bHRGOUU1UW8zcWRDZkN4WGo4QnIzY0hEVDVG?=
 =?utf-8?B?bmNPZVFqelFCK3p0cW4xc29vTFZKbDltcy84Qm9za3lTa09LYlJ4LzA4Z09S?=
 =?utf-8?B?REZUbjZHanJhSUxvbjFKaWttdlkreGxTUUNQeVlJcHNYY2x0YzQwVXkrd0Fm?=
 =?utf-8?B?VjN0UEgzKzduSXZPN3dVZS9sWmRENGhIajR2SGdyY0dYSU5kWElRTjI2aUhu?=
 =?utf-8?B?NXNVTmU4VVFBNUZrTXZhYkZHdFFMQmNVczlDb2FjcXYvZHgxaGRZQT09?=
X-Exchange-RoutingPolicyChecked:
	cm/NdcaIZOGTxO1Vb0iRCV0T+Xi7ZJtFInYVVJPvqOxmduV2njmpfaYPUEs2Ye86Y0oGnhv1lFf57Og7MISWDV851/Xzi9Jo2GWHdmLTXA+STCbQwZiMIcjMWlS27jF8WlvBkp/tH9fK5nL/TCxWmS53825XW5kFnbqtp5ofNoTlYPZKNhT5Ejncbfd4zovC4bwCT++Bjsp6+Pa0FaBh7LspZwSXS1t//L0vTvcTn0ww7MKu9YstRvkjKnrqCyH+6dzSPNUAEKflSFMDxptzNG6cJd3SJ56WjB6s19CAu7dB/TiSP+wNwy6q4VWlS/8krhk9qu3dhjPWrMpMt/sEMg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UIYIKDoyFw0IgP21bEDP81stCjbJyXQXUpWQRlmztNw9W7QFm4DZjiRN62mwUCjmPiBc2o+msJu/RhAtmg2mMv5iASE3MhcvVJltyAFEafDTpRR+GJ+zrmIJ+uClsnSCq7d0F1UHfmwVbWKpBNJwLXIVqYBPGjZKBjZhWyI+KCtIrlBhj1moozG+/c7pkQ14T3bKJL5FkrhNTQCm50l4dZkzYQwbie6C1SbWkRP9YvemQjR1kmaz+RAvNqT/c0Q799W2xoNpkwn6Gbq05v+tRYUBDgb1aKs9wvotVdAP2ELSxOwV5OgmkBC0FV5ie+q8nH9bTBrV91g/AxozFwhv3nKTXVwuhGFQcYAvSkPE28ZIy/E0PmDx65fA7oBCwIlPYGCUe6cs/9ArPJzlUmQPyEdROPmjUlDWTqyEtr/tIeg5Xw6U/U7ZTFqOGS4vdxG0LL/1TGNdJiqmBdZf8jDozmOZDlHT3H22Qz6uOlLlX2plAiQX7GL46piaVFe6Aye34+9o8GjNp6D+mfeJBs/oSoflhXqJhHPSt+JNyjh/r/8KwDIzwk/iAeRe6vH7iU1ATYyl6vcyCqqbgU6nV1SYbSG7tpGOdJreBd4lYceU8Io=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618f5df5-0149-4a51-2410-08df13c61cc8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 07:42:51.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGbbXwDu6hWFgpzlnk6xuzlhEpzOViRIxfJpFSWjtkm91EDi6ImpFQYHvbdAy4MCQJoTINSsqhFBcASA+fD3mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB998057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609160099
X-Proofpoint-GUID: Q-op5x5LhhyoPE9omUrcciFmxBY1JUUa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5OSBTYWx0ZWRfX+Ap1tEr+jgXf
 /E+E3JVGSssyZN1n0MUVc58RhXpAd6wdZRnQ3awfQfXKMjTuvLjIAK/wR2vFu5c4FflqHWxlXU2
 mVgOaWQKDoWWGPydNUdXJI+5CcJfN+e+FPNw3PcYyLCVVHU7IF7T
X-Proofpoint-ORIG-GUID: Q-op5x5LhhyoPE9omUrcciFmxBY1JUUa
X-Authority-Analysis: v=2.4 cv=c9k+0h9l c=1 sm=1 tr=0 ts=6aaa4882 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=VFQcqQG27K28gTGTjAIA:9 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5OSBTYWx0ZWRfX9ia5dXCiMjqm
 kj11xlXePXA9XE9AOG6XqQoZj/8H7gfxm7aA07Ek7RU8XNnO2LgFL9dXbcVC83IS9Pvaufk+PJj
 vPaCTzr63bzzR1goqTXNVJ88nnjcdQ1IKrCeuRvyZy5k+0rPdkbXGuL/QKSx+7yFLsyyukszcR7
 DX62xJBo1ycw02/7McfCB6uzUwwDNenXlndYMMlL0ExEIPbbFDVFo1Mino9yXLVIK9hxIk+YL9W
 3m3kuie5UbCVo4Lo5qks2By8Vp/9sQIV9n+0tkMdfSbJ24oWbEo4FhYQ5Vezcdk1WKBX823Dp9P
 WZFz5BlPfatEjPT0uuavdi87TpXGiGTMxMqcUCnJqkSE9md9BiI/z5q+O+gdzfLu+DJIBt+35eL
 PpDycaGPO1Jccj93WxNBwDcLcMUSWhqI7awGfB2eS988qgEac/BdceojhU63sMtQqZntrtswQSu
 68LEXLxW4l6BQnRwuSw==

On 14/09/2026 08:50, Nicolas Schier wrote:
> On Tue, Sep 01, 2026 at 05:57:52PM +0100, Alan Maguire wrote:
>> Add CONFIG_DEBUG_INFO_BTF_INLINE to generate BTF inline-location
>> information with pahole v1.31 and later.
>> 
>> Enable pahole's inline feature and pass --inline to resolve_btfids.
>> This extracts LOC_PARAM, LOC_PROTO, and LOCSEC types into a split BTF
>> blob named <output>.BTF.inline while the ordinary BTF remains in .BTF.
>> 
>> Embed the resulting blob in a .BTF.inline ELF section for vmlinux and
>> modules.  Add the vmlinux linker-script output section to avoid it
>> being treated as an orphan.
>> 
>> Use the inline pahole feature unconditionally for both in-tree and
>> external modules; the generated split BTF has the same format in both
>> cases.
>> 
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  include/asm-generic/vmlinux.lds.h | 11 +++++++++++
>>  lib/Kconfig.debug                 | 17 +++++++++++++++++
>>  scripts/Makefile.btf              |  7 +++++++
>>  scripts/gen-btf.sh                | 17 +++++++++++++++--
>>  4 files changed, 50 insertions(+), 2 deletions(-)
>> 
> 
> [...]
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 1244dcac2294..dd1b2d9ebe99 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -425,6 +425,12 @@ config PAHOLE_HAS_LANG_EXCLUDE
>>  	  otherwise it would emit malformed kernel and module binaries when
>>  	  using DEBUG_INFO_BTF_MODULES.
>>  
>> +config PAHOLE_HAS_INLINE
>> +	def_bool PAHOLE_VERSION >= 131
> [...]
>> +config DEBUG_INFO_BTF_INLINE
>> +	bool "Provide information about inline sites in BTF"
>> +	default n
>> +	depends on DEBUG_INFO_BTF && PAHOLE_HAS_INLINE && SYSFS
> 
> [...]
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index a1812985a61a..d42dbc8d7199 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -22,7 +22,14 @@ endif
>>  
>>  pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
>>  
>> +btf-inline := $(CONFIG_DEBUG_INFO_BTF_INLINE)
>> +ifneq ($(btf-inline),)
>> +btf-inline-feat := inline
>> +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=$(btf-inline-feat)
>> +endif
>> +
>>  export PAHOLE_FLAGS := $(pahole-flags-y)
>> +export BTF_INLINE := $(btf-inline)
> 
> 
> As btf-inline and btf-inline-feat are not used anywhere else, and 
> CONFIG_DEBUG_INFO_BTF_INLINE can only be set for PAHOLE_VERSION >= 131, 
> this looks a bit noisy to me.  I think it would be good to keep that 
> change in scripts/Makefile.btf as short as possible, e.g.:
> 
>     pahole-flags-$(CONFIG_DEBUG_INFO_BTF_INLINE) += --btf_features=inline
> 
> and for scripts/gen-btf.sh something like:
> 
>     if is_enabled CONFIG_DEBUG_INFO_BTF_INLINE; then
>     	BTF_INLINE=inline
>     fi
> 
>

looks good, I'll make that change for the next revision (splitting this into multiple
series so the kbuild aspects will follow a bit later). Thanks again for taking a look!

Alan
