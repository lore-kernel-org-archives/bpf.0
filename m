Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3F43EC833
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876576; cv=fail; b=N2fCgHfKfUCKNnUmUQ7i+QHk5o6B1jWUMtunBMEsJE1V3mp6u0UYagnOgrWn8841XJSr9GrPpY5vpnnzxL4bXJsGQaAqvTmpwDVqPfEznZ2PBQUw96Y2VvdJ3jKSUWRzAa9N1Jnfsbt+7z+3zEz8IB+YZ8P5L7NBnkZXoQkrZOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876576; c=relaxed/simple;
	bh=VMTv66kLZRZPRLP8xEjtth7rGR8wwB8Tqh7POMr4o6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmwbRG1zK/8GCVQruCDDitkp77oHUBFZsE8dqOw2ACor8iZQRs12j6h4X2f4FGz5KBvT15W0lXJWOiB7XfwotiTDNjC0ItrejyUHDeTT6oNyS+gdLSRmkk8I1lu0M1FFU9bc7zFLQ91Fs4RdklXHr2jEzMqPIElNPqk9BCTBvPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jn5gw/Xf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sTzhNa4d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jn5gw/Xf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sTzhNa4d"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691FtiV61693141;
	Thu, 1 Oct 2026 17:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jWRupqg5iTatuW2vCQJOIo1nteIXCuXYruxscFUhQd4=; b=
	jn5gw/Xfo9CPfB9EIb1AUoOlfzaJr3XeZiUUYMCzovYfHQDBCai7zVBxkRQ90Wgp
	6f1Mt66yuPY4eu4JhMtSW0WumAY+yKXfo78j4dc/2NM9zikvtBriD6+XZu//HBfk
	nMFbQFZ03IBisk/YcoKZwtRmNVecT38kvdmTa+e+Z1v94lJYccCcOKAU51rqTeSJ
	Kojv1MgMt0wyI7yiqxcVi5sg3pIt6wOMyQYtTHojoaMCSwu0oM0CrJ+x4EnVz8SH
	J6YHtzAs+7J3S9Yp5d0fKErMa8aPLZIEYCa6qc46w8vzu6wOg5loSiFFr/UDrsxb
	tjXxCfk1zhmis6nY2nL+CQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4y9hu3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 17:42:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691HZ20U001144;
	Thu, 1 Oct 2026 17:42:27 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gf5ngf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 17:42:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPvlRPQFrvOpQ5hlMkqd9JxpPnPs+spU/CSzp+7lIy26bZkZIILUDb5Dd9CCd5SVCgRKjWyGyuQPmkY+Gm+F0crcQFfHiOiSmbspGTavl8lbSBIPuP+LiHVzbAFvSO52y3c1tYHWAgGcSP5gbWQDx855/PKMMkd2NaYdLOd3Tzcr8CXH4C9hmn4CzdHlpHI84aWJl6RnVJOJRn1owBZ7sPicjwh2Jntuk2qIJ+mt0SKdyIza8Gdp20MXH3c2eNQgkZgH6HIO+hHALpLJjiKqyjOrxr+MOGdpMMeh+KXSDKXXwB1RqA45On36kE28q0LReuhb+MlJaHgGOw1BAYX/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWRupqg5iTatuW2vCQJOIo1nteIXCuXYruxscFUhQd4=;
 b=gONgBkXj/gt4f/I6lVpV7pVhPnGt+4JQ1QRJIcTVP/Nx+f3wyUiEizZGXqY21QHLFBVkyphM8SKb8nbUYa+u8IZIoxinaua2q/lOpujNvgtpjo/qIteOOj/bvGBY4Kx6T/Xo18gppcInrJzkpbdQaDijNT8SxJsDE6LngWs2NILSp2Q+cmqweKbjqjF89QUynx/KneXdPYmX+hJUeyFn16fvIlb3Ejzt4RqEk2jzaTWTQMjOdWik4fKaUITWtwLDbkDwaaQS8IL0Yg+0TztGZBYZ9SvHfvWVHiTxNact3ccjZo25yWAMGxyVhsqByy69JtzvLeX4TZCZq12hiIrpig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWRupqg5iTatuW2vCQJOIo1nteIXCuXYruxscFUhQd4=;
 b=sTzhNa4dEl3+44k4pfxQqVONwSbCW3e703E4COkJ1jjbqJvKZ8yd7rURbc6N6rTxUNwShW8mNmua1xS1If/c5B3erAtRY21+KKVb0wn2b7I+bE+Z2+CJWw0/CudP75QFD7wRis1VQLMeetghzAdzGA//ZGH+WvYUwmdkK1bygjk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SA2PR10MB4555.namprd10.prod.outlook.com (2603:10b6:806:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 17:42:20 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Thu, 1 Oct 2026
 17:42:20 +0000
Message-ID: <82f7ccc5-da2a-4b78-a10a-442acfac1855@oracle.com>
Date: Thu, 1 Oct 2026 18:42:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 05/14] bpf: Allow names of Rust types and
 functions in BTF
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
 <20260930193127.2181684-6-alexei.starovoitov@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260930193127.2181684-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO2P289CA0002.QATP289.PROD.OUTLOOK.COM (2603:1096:790:6::9)
 To BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SA2PR10MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 191b6434-8ac7-406a-1a3b-08df1fe356d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|4143699003|6133799003|10067099003|56012099006|5023799004|32116099003;
X-Microsoft-Antispam-Message-Info:
	a7EoYNyT9iXmcOh/tPcaCkDqfvBACGm+A2kc9bF+EhqWfGwMLMcGhgMvOyVTYlNjsOmOK7dNrRMpTXkS8dRiYSKxlsUOJSg8NVjA1tHYkH9W8Av/GV+L+YkGy5EgZM1BNq9g8vYCG8bnRJocibA9EQH382jRKJch/nBMccDXn7++HgIrlml0k3znTidwyVbEfMbFSM9A4w9XFHbtp2vJj6QVZdHpa5e9YaqTD78Tn7mknFLX/fv3tfiK4SJmlDPRXehHh4Vmcn5X0H6Vkgt/jRIyWzqKYSFaWryVcW6/KoE36CAMn3Pd7LEmzlAVNvAQqxUx0qt93NOKArWlkzdQtakuJeoEVaPJe7x21XeoGN93tVGZqKTmNMNrqRuqYR3U4JyNw/9zHhzgk31ceOZIKsxy/4EV+LuUv+h9xnqOykiN2BQUTgaQqHn/KZroGYNnvi6E26E0JkQLyIZEBjmmEV3QwXsfjbQqoXxtHhEXDjETAQcQ86hQZNvYODPVpzG/4yZ+OMn2MjCmyAm1AhQcPDnUBzHSUEm7n8pKhVHzXw91n7SfRhmcfDFe2yMibtJCRouRk0HwFy9wJ2N6LgLjK9B8cE5to02JtO/nYb/hKUTDi4AtBJq8rEz9wrI8Nimj8sM95GBQOci2pE01CgQu78mTT6MD/xPwK9icL+b7SDE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(6133799003)(10067099003)(56012099006)(5023799004)(32116099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjRRekdqd01NbnI4TjRCVzlpY0w0MXoyUUhTQlA4QnYzMTZNR1IxREpzRllk?=
 =?utf-8?B?WlpLQzRvaFNmbDlaZlZ6WTNrYWZHK0doZEExdlE3YllTZXRTUHJIcGUvSW41?=
 =?utf-8?B?bHg0WHdJREZjRlZRR2VISjY2UUtMODcwQTM5TDlTTTU2dFdDZTlmZFNDM2E3?=
 =?utf-8?B?UUl6R0wya29ycDVRTWhqM0JEMy9xa3pFME4zMHFtVGRQaU9xWWw0R2c3NmRw?=
 =?utf-8?B?RllGZTBjQzlvTE5vV1VFZHBaYU5aTFdOZVlSZnRtbGZaeEticFNTejZiUVNN?=
 =?utf-8?B?NlNzbktvVHcrRm0rcFlLSU9KQ0NsdzZnWFFhRDJXd0doRHZNTzhUSzZ4N0JL?=
 =?utf-8?B?WkhROGRqdUNlcFVOamlaVWp5enJoZkljNGlvNmJuUjZSRk9FUGhGQ0JBYWh6?=
 =?utf-8?B?elN4LzlMTnloYjFkUzAyeEw4Sm1ad1JHUGVoQkI3RGVpWXNid09jeEkvMURV?=
 =?utf-8?B?NVhHd0tGNERMTU9QYmxkU2tidkNPaDhYR3dtTzErUkFRV0hGSU5SaEh0c2VF?=
 =?utf-8?B?OSsveTVGczJJKzZhUE9BeGJyMVZxMkM1bmRaQndGRkd2L0ZpVjNnZWJiL3lm?=
 =?utf-8?B?TDZJRGNyWllFZkFISSs2UDRPWlF6Vm42MXhvZU1UL0tQcW1mQmEvNDN2QUpG?=
 =?utf-8?B?MzVpUk5kSE5taWlxMktVZjVLa2t6OEp5NVFmaWFmQktPWUZFb2doZytJbkpj?=
 =?utf-8?B?MWtqN05vUS9yQmx0S3N1MlFrckVXSUZLUEpycEdXYjhUNUZrelVIOWdsbHpw?=
 =?utf-8?B?OWxPUVB6NGlyTzZBbDN2cFZpeVllc2Q3NVhreXcwdzdiZjRJWi93czFHM09F?=
 =?utf-8?B?aDBKZ09uc25nZERGMDBZNGFvdnBnek5EemlpNHVzaTBVQVdabFNHOTFIeFdu?=
 =?utf-8?B?bmw5L3E2OXZZYllxU1Fldk0rTWE1Tms4NjJaanhFNSt1akxORXVWTGFkY1Er?=
 =?utf-8?B?QXEwRWw0U29taWcyTExMeGNCOHNiL0hFT1M3bEFzQy9VUFlJTDJBZmkzc0M5?=
 =?utf-8?B?Tm02MU5QZENKbm5xTXNyN3RteEE3Q0R1Zmc1T0hUMmRGSW96SDd6U2tNcndS?=
 =?utf-8?B?cWJGWktqSGppRHIvbTdodE9TWDVsSUdpbTZvcC8rRFVFK2E4a2RwcXNyN1dy?=
 =?utf-8?B?d2tVUjhpemVPWEJKcU0yR0tkK3Vpblp0d2luZ2cwR2RHM1RJZzJyYnE0L2NM?=
 =?utf-8?B?b3RHQ0NLMjlRejRtRFplR3RPaEtFTkZhSWZtZUYwdUJpUnlHanJnbkFPd3A0?=
 =?utf-8?B?V3pScWcrNGl0MVAxbWN4TDl2N0EzdktMUlQxbXcvRHVmajJaTFd1TU4xOFp6?=
 =?utf-8?B?cU42cFJ6VFhwaEU4TisyN09sc1lTb1lTWDAxSzdIUC9XbE5ndjJSYjROZDBE?=
 =?utf-8?B?aW9NYTEyUVJqR2JyVlN3ZEhSQ0d1T0QwWW4xcDRmaFR6Qk83VVJyN1E4ZWdG?=
 =?utf-8?B?U2w0WmJUNlYxMlNpTDdyTmxJRU5pN2JXd3BCMWM4T1FkaEhKbzNRRWJuTXJw?=
 =?utf-8?B?RnI2aDVIbHZ4SXRUVG9BT0FWdFd4L29kRGJyTkpYbjdaNno3UjdpUDh2aUNu?=
 =?utf-8?B?YnNEWEJkdzYxVkYwaC9NMys0Qm5uMExiMHlIaWx6SzNzY0ZDZ2l3N2c0R0VF?=
 =?utf-8?B?N0tNTUh5ckhkNmg5RjlUS3VrWU52OHJmcXBEZVAwaFMxRGNuQXB1SEFJUGc0?=
 =?utf-8?B?dFNudVB0WGh0N1hvNGJSTEovbmgvMUc5UWdKTEVSNVNFQXF5Q1dSWms4OXJT?=
 =?utf-8?B?a3NZMEppa0NOQ2hDbDFieVVFVGhCQkg3cWlieDc2Tm1sQVlvaUxQY1VadEUw?=
 =?utf-8?B?TmQzUEpUT2ttbXplMlI4SHp5a0dHWEdlcFJ0SHpGV1NLREw0NVlxbTZxaHR0?=
 =?utf-8?B?S1dpaytyS0IzMC9KNDEvdDgxNnAraytGemdIWjkvTk45NzlFODNNeWI2dEN1?=
 =?utf-8?B?WWJVeE14QVNSQUFwYzA2YStwSG03cVdEODMxMGV0TTdoOCtpK0JRZ3M5MXpD?=
 =?utf-8?B?UlpDY1pnU09VSGlYdk9QS2VPamV5cW8zTGxNZ2dYY3B0VEF3MSs5TVJtME9Z?=
 =?utf-8?B?VFE4akVOZFFTTDNsVkpJdEs1MVU5NERnWk1KcFlSUzlNL0dSRlFVU2FBT2Er?=
 =?utf-8?B?UU12NngxTWlYb240MFJER2wyOC9nVVc2M2N5UjRJQ3VXMFUrM0YrWk8zWHBq?=
 =?utf-8?B?bHVPVUJ1dm1iSmlBcGxySlczUUU0WitmZzd3OForYitZY1dpdWxLUHVHakJH?=
 =?utf-8?B?Vlh0ZS9QM2d4cTM1Y0RIRjhFUkhUZGxwSWUxWEduVEZKSFZSZTNYcEg1QWlM?=
 =?utf-8?B?RHFmSHpUWGRQMGR2dE1NODYvSE9ycCsrYUlzT3krMDlWRXd3ZkFLQT09?=
X-Exchange-RoutingPolicyChecked:
	Ut53GQvki38tf24aLImTy4bwpDjI4wNDKOtQ/jdoZrkltIxEkzLsTG1MUetQ64s7Widt+tc8R2UiYVgHHcWV3PLvWBy7sb3Zj7+i9mCP5X14MagEIyrO37Pv76Rb3rd7gnsyR9DMH3rXimM9xOlFgSfn44/sHQEh3H382Got8b3NmRsFxQtlBULdkDBqIUoarDYLsW7lLNeXAP1RRsSOfCQHAodTRJtPbulfISJ0zkxG8y7T9/w4I7Qjex2AfVVgfr9VC15lDHh3ozaywd0ZLcb4K39R8HAz2HxCknhG0UQk6mLx2fPBXkvMZDgkQGaCFijlNNfVezQ2gSpd0Rm++A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MRD0W3ZmVIfKIta6G1gkXgZqV45fb869BMUmopQERvkx5Z3AGXp+lFlFndlHtEbSRnVfCOwzROqiS8BnF+bLrM5xbLBmJ8kAvQL9fbDKlUMaxoyE9lYlzplrcYq298Fx1c3WppZnuMmvbX9iS9ZL5/79WFl+N972BDbgEErFu/sHwbR7jB0ZAeFl5lAVuDyW09SlH5k9dVPTVCOCq4YxGCxIdtgbGOKXHX88R17AkfxEWbq6Gdp0GQ9XyoMsjH/qIjPtvzl9O1dP2mYroDBLuaToPthFwXLBe9XoCg/iudEAbeBk+S81NqJd1tKxtRxXQDoKEhCf0lQ7c7nSMz7lQlRWHgcaMKRKwHOE6/xizQ73Udi6JcDIhMnmuTnP+XEHpNkMHYouRQhdbbgQuhB/3zgzASo5db9ipIIu8fWNjAqBUP6kk49tDq7/ZF3Qb5sFjMX299mutMLznqnH7ceX44CZO4vrvbXKc5y6r7rye/0gsd1mJLh0H19iaqMtdX8kc7po/NjKt5r7ZYAdj5XSUJzlyjGVRnQTggXim4B06+aLaj2qKmSUjXbCniXCec/yzXZ5GGZttTCGyzQwMWaVbjRzjXokzGLExEsgO1xFag0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191b6434-8ac7-406a-1a3b-08df1fe356d8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 17:42:19.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8tMYQP687Ngdv9vJL5A4he8YdxmfLnz4EI/4C4cWuu/e3Ocg02eSe/wF93BLGSZA6gwaYdkYHTRn9TKk/hEMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MCBTYWx0ZWRfXzwaoJGqyaloj
 uzUM0PuG6F5jJET3b54BoeKWv5aNVkXefzeMjp/MtZRvLcNS6EqPnHREeNUZDYLe8MhYYMYpkQo
 IaJAW7rylrGnR1NQp3CQJrfUscd+M+WZHMVp1zOLYzM2Q2ip6NbzIzEmsX3ZmQfZKIWMR3LskPu
 aABcAhi+ffOnnC4hqAZFJeexXSFwzJTHhDnoxBs1lgDSJE5PvYwHkD17Ptz0e5aZ0nGi8hBZQcX
 x0C3W+Yj0Ue+pct1/Ydc2rA3LGPewJO7qTmwErQIoaEgZk9uQRfcE7puj1IqY8aqMYaGfUM8lZB
 hnGMaYkWhZIYjBF498/4GH66kceOIBNsHafk0PkssO5n3be58j6pL0tNjBsvanZIcFOlu0MgMRc
 nkjTNZgr8FTMlyqzSG6Y1uQ4iWuRfSPj4tXqqfhDJAesY7qpPXMs6N4FIxjGvcE67VPItb8jf0t
 uyJA+qqfo+++Z5bICdg==
X-Proofpoint-GUID: eUFvuLDjFR9h0EUBE21ol76DbrSxIj_g
X-Proofpoint-ORIG-GUID: eUFvuLDjFR9h0EUBE21ol76DbrSxIj_g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MCBTYWx0ZWRfX4d7WNDKTBdVW
 7Xky1uWv369DveNBwET2yjzhwmNoY0XoxiBpvb/tvs6sLtSPmru43C7UexHHESShekGP9GPvdMf
 c2cHrMb+OYlTr+InCVfYhwHdn14GMMWk4c5IGOPfG7RnDfWWqrws
X-Authority-Analysis: v=2.4 cv=IuyL47/g c=1 sm=1 tr=0 ts=6abe9b83 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=sJDQDlUsfrl4NyXIKOwA:9 a=QEXdDO2ut3YA:10

On 30/09/2026 20:31, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Names of types and functions in BTF that LLVM makes for a Rust program
> are not C identifiers:
> 
>   [69] STRUCT 'NonNull<str>' size=16 vlen=1
>   [147] FUNC 'write_fmt<scx_cosmos::BpfStream>' type_id=146
> 
> and the kernel rejects such BTF with "Invalid name". scx_simple and
> scx_cosmos schedulers written in Rust have them in STRUCT, FWD and FUNC,
> made of letters, digits and " #&()*,:;<>[]{}", 430 characters at most.
> 
> Allow any printable character in btf_name_valid_identifier(), like it's
> done for DATASEC. It checks names of types, functions, members,
> enumerators, variables and arguments, so all of them can have such
> characters now. The limit of KSYM_NAME_LEN stays.
> 
> The name of FUNC is a part of the name of the program in kallsyms, where
> a space would break the parsers. Replace what is not a character of
> an identifier with '_' there.

One idea I've been experimenting with for pahole-generated BTF is to
retain a more friendly rust-centric name, while keeping the kallsyms name
(which is name-mangled) in a structured BTF decl tag pointing at it [1]. 
The idea is that for tracing rust functions you could specify the rust name
(from DWARF DW_AT_name) in the SEC(), but to map to the actual symbol
address in kallsyms the decl tag that referenced that function could use 
the DW_AT_linkage name.

So the decl tag would have the form 

<lang>:linkage:<linkage-symbol>

and it would reference the FUNC type id.

Could we do similar here for the name -> symbol mapping?

[1] https://github.com/acmel/dwarves/commit/a14b368960635b30b188a899a1245143df53e70b



> 
> Tests in prog_tests/btf.c expect "Invalid name" for names with '!' and
> '*', which are valid now. Put a character that is not printable there.
> The type name '?foo' is expected to load.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/btf.c                             | 15 ++----
>  kernel/bpf/core.c                            |  5 ++
>  tools/testing/selftests/bpf/prog_tests/btf.c | 52 ++++++++++----------
>  3 files changed, 33 insertions(+), 39 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8cc17a1cd25c..d27af5d8e495 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -901,16 +901,6 @@ static bool btf_name_offset_valid(const struct btf *btf, u32 offset)
>  	return offset < btf->hdr.str_len;
>  }
>  
> -static bool __btf_name_char_ok(char c, bool first)
> -{
> -	if ((first ? !isalpha(c) :
> -		     !isalnum(c)) &&
> -	    c != '_' &&
> -	    c != '.')
> -		return false;
> -	return true;
> -}
> -
>  const char *btf_str_by_offset(const struct btf *btf, u32 offset)
>  {
>  	while (offset < btf->start_str_off)
> @@ -923,20 +913,21 @@ const char *btf_str_by_offset(const struct btf *btf, u32 offset)
>  	return NULL;
>  }
>  
> +/* Names in BTF of Rust are not C identifiers. Allow any printable character */
>  static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
>  {
>  	/* offset must be valid */
>  	const char *src = btf_str_by_offset(btf, offset);
>  	const char *src_limit;
>  
> -	if (!__btf_name_char_ok(*src, true))
> +	if (!isprint(*src))
>  		return false;
>  
>  	/* set a limit on identifier length */
>  	src_limit = src + KSYM_NAME_LEN;
>  	src++;
>  	while (*src && src < src_limit) {
> -		if (!__btf_name_char_ok(*src, false))
> +		if (!isprint(*src))
>  			return false;
>  		src++;
>  	}
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index a1721f9c0f52..36900b02d668 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include <uapi/linux/btf.h>
> +#include <linux/ctype.h>
>  #include <linux/filter.h>
>  #include <linux/sched/signal.h>
>  #include <linux/skbuff.h>
> @@ -589,6 +590,10 @@ bpf_prog_ksym_set_name(struct bpf_prog *prog)
>  				      prog->aux->func_info[prog->aux->func_idx].type_id);
>  		func_name = btf_name_by_offset(prog->aux->btf, type->name_off);
>  		snprintf(sym, (size_t)(end - sym), "_%s", func_name);
> +		/* the name of a function of Rust is not an identifier */
> +		for (; *sym; sym++)
> +			if (!isalnum(*sym) && *sym != '_' && *sym != '.')
> +				*sym = '_';
>  		return;
>  	}
>  
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index df6ad38d287d..87b554067071 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -1987,14 +1987,14 @@ static struct btf_raw_test raw_tests[] = {
>  },
>  
>  {
> -	.descr = "typedef (invalid name, invalid identifier)",
> +	.descr = "typedef (invalid name, not printable)",
>  	.raw_types = {
>  		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
>  		BTF_TYPEDEF_ENC(NAME_TBD, 1),			/* [2] */
>  		BTF_END_RAW,
>  	},
> -	.str_sec = "\0__!int",
> -	.str_sec_size = sizeof("\0__!int"),
> +	.str_sec = "\0__\7int",
> +	.str_sec_size = sizeof("\0__\7int"),
>  	.map_type = BPF_MAP_TYPE_ARRAY,
>  	.map_name = "typedef_check_btf",
>  	.key_size = sizeof(int),
> @@ -2112,15 +2112,15 @@ static struct btf_raw_test raw_tests[] = {
>  },
>  
>  {
> -	.descr = "fwd type (invalid name, invalid identifier)",
> +	.descr = "fwd type (invalid name, not printable)",
>  	.raw_types = {
>  		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
>  		BTF_TYPE_ENC(NAME_TBD,
>  			     BTF_INFO_ENC(BTF_KIND_FWD, 0, 0), 0),	/* [2] */
>  		BTF_END_RAW,
>  	},
> -	.str_sec = "\0__!skb",
> -	.str_sec_size = sizeof("\0__!skb"),
> +	.str_sec = "\0__\7skb",
> +	.str_sec_size = sizeof("\0__\7skb"),
>  	.map_type = BPF_MAP_TYPE_ARRAY,
>  	.map_name = "fwd_type_check_btf",
>  	.key_size = sizeof(int),
> @@ -2175,7 +2175,7 @@ static struct btf_raw_test raw_tests[] = {
>  },
>  
>  {
> -	.descr = "struct type (invalid name, invalid identifier)",
> +	.descr = "struct type (invalid name, not printable)",
>  	.raw_types = {
>  		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
>  		BTF_TYPE_ENC(NAME_TBD,
> @@ -2183,8 +2183,8 @@ static struct btf_raw_test raw_tests[] = {
>  		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
>  		BTF_END_RAW,
>  	},
> -	.str_sec = "\0A!\0B",
> -	.str_sec_size = sizeof("\0A!\0B"),
> +	.str_sec = "\0A\7\0B",
> +	.str_sec_size = sizeof("\0A\7\0B"),
>  	.map_type = BPF_MAP_TYPE_ARRAY,
>  	.map_name = "struct_type_check_btf",
>  	.key_size = sizeof(int),
> @@ -2217,7 +2217,7 @@ static struct btf_raw_test raw_tests[] = {
>  },
>  
>  {
> -	.descr = "struct member (invalid name, invalid identifier)",
> +	.descr = "struct member (invalid name, not printable)",
>  	.raw_types = {
>  		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
>  		BTF_TYPE_ENC(NAME_TBD,
> @@ -2225,8 +2225,8 @@ static struct btf_raw_test raw_tests[] = {
>  		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
>  		BTF_END_RAW,
>  	},
> -	.str_sec = "\0A\0B*",
> -	.str_sec_size = sizeof("\0A\0B*"),
> +	.str_sec = "\0A\0B\7",
> +	.str_sec_size = sizeof("\0A\0B\7"),
>  	.map_type = BPF_MAP_TYPE_ARRAY,
>  	.map_name = "struct_type_check_btf",
>  	.key_size = sizeof(int),
> @@ -2260,7 +2260,7 @@ static struct btf_raw_test raw_tests[] = {
>  },
>  
>  {
> -	.descr = "enum type (invalid name, invalid identifier)",
> +	.descr = "enum type (invalid name, not printable)",
>  	.raw_types = {
>  		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
>  		BTF_TYPE_ENC(NAME_TBD,
> @@ -2269,8 +2269,8 @@ static struct btf_raw_test raw_tests[] = {
>  		BTF_ENUM_ENC(NAME_TBD, 0),
>  		BTF_END_RAW,
>  	},
> -	.str_sec = "\0A!\0B",
> -	.str_sec_size = sizeof("\0A!\0B"),
> +	.str_sec = "\0A\7\0B",
> +	.str_sec_size = sizeof("\0A\7\0B"),
>  	.map_type = BPF_MAP_TYPE_ARRAY,
>  	.map_name = "enum_type_check_btf",
>  	.key_size = sizeof(int),
> @@ -2306,7 +2306,7 @@ static struct btf_raw_test raw_tests[] = {
>  },
>  
>  {
> -	.descr = "enum member (invalid name, invalid identifier)",
> +	.descr = "enum member (invalid name, not printable)",
>  	.raw_types = {
>  		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
>  		BTF_TYPE_ENC(0,
> @@ -2315,8 +2315,8 @@ static struct btf_raw_test raw_tests[] = {
>  		BTF_ENUM_ENC(NAME_TBD, 0),
>  		BTF_END_RAW,
>  	},
> -	.str_sec = "\0A!",
> -	.str_sec_size = sizeof("\0A!"),
> +	.str_sec = "\0A\7",
> +	.str_sec_size = sizeof("\0A\7"),
>  	.map_type = BPF_MAP_TYPE_ARRAY,
>  	.map_name = "enum_type_check_btf",
>  	.key_size = sizeof(int),
> @@ -2625,14 +2625,14 @@ static struct btf_raw_test raw_tests[] = {
>  	.raw_types = {
>  		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
>  		BTF_TYPE_INT_ENC(0, 0, 0, 32, 4),		/* [2] */
> -		/* void (*)(int a, unsigned int !!!) */
> +		/* void (*)(int a, unsigned int \7) */
>  		BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
>  			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
>  			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 2),
>  		BTF_END_RAW,
>  	},
> -	.str_sec = "\0a\0!!!",
> -	.str_sec_size = sizeof("\0a\0!!!"),
> +	.str_sec = "\0a\0\7",
> +	.str_sec_size = sizeof("\0a\0\7"),
>  	.map_type = BPF_MAP_TYPE_ARRAY,
>  	.map_name = "func_proto_type_check_btf",
>  	.key_size = sizeof(int),
> @@ -2775,12 +2775,12 @@ static struct btf_raw_test raw_tests[] = {
>  		BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
>  			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
>  			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 2),
> -		/* void !!!(int a, unsigned int b) */
> +		/* void \7(int a, unsigned int b) */
>  		BTF_FUNC_ENC(NAME_TBD, 3),			/* [4] */
>  		BTF_END_RAW,
>  	},
> -	.str_sec = "\0a\0b\0!!!",
> -	.str_sec_size = sizeof("\0a\0b\0!!!"),
> +	.str_sec = "\0a\0b\0\7",
> +	.str_sec_size = sizeof("\0a\0b\0\7"),
>  	.map_type = BPF_MAP_TYPE_ARRAY,
>  	.map_name = "func_type_check_btf",
>  	.key_size = sizeof(int),
> @@ -3585,15 +3585,13 @@ static struct btf_raw_test raw_tests[] = {
>  	.btf_load_err = true,
>  },
>  {
> -	.descr = "type name '?foo' is not ok",
> +	.descr = "type name '?foo' is ok",
>  	.raw_types = {
>  		/* union ?foo; */
>  		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FWD, 1, 0), 0), /* [1] */
>  		BTF_END_RAW,
>  	},
>  	BTF_STR_SEC("\0?foo"),
> -	.err_str = "Invalid name",
> -	.btf_load_err = true,
>  },
>  
>  {

