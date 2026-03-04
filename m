Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C122353EF7
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662779; cv=fail; b=YVC8rxD7uv1gvAGWGVE7q9IIzXI9+Ai/Vf42HFnwBkZ769Kp1O747suEyB0yCs9fHFMOxbcXGcy2aBdDe+45eHk8aMfeJyhq7WuDN9zdB8mmXEvhG0UUToMLHWEEuw7lFWnfG62wIWLIDH2Pn4lonMBaZDMtqi6U05sub6UPHMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662779; c=relaxed/simple;
	bh=ETLtEQ+Cexkm85+BLTQ6DS3SM4r/O+QQFmFF4lk2BeY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gybSv0ZuT3Fuc/OsVFU1ylnxPszm71Y9fYSyqjAUyYnY8d8dGUElC00EPFX3+NvLgtAVUl4kinezIR8BdaAnHXQRi0uHBLwarbiBCW7PPi53MC1Yay5HCjHFfWAd7DJJYvQ5sNH48pPai6TewrwwgIXbs4GMlA69W/7lSiwHc/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WChLhzR+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lG2lDYjf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WChLhzR+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lG2lDYjf"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624M52pK3259174;
	Wed, 4 Mar 2026 22:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cmJd2hCwgjcrFSf4lB8qE1JeFv61f0gI6GoBZpbftYE=; b=
	WChLhzR+E8qaDYDJ1EH+0fqTaRRSg+M2zoXJFpewfhOd64W1G97cQzfWnjz8DtLe
	H7PhY5n6h1p0XEv5cMznv5SQ8whXxyzUAJcjy+satu+Qfj+Ygd2EwsOOLpvsPl8C
	YNXQHpu87wWzGNhAX7hESLqwa2U3fIwOg3mf1oZM8hjZd9gIgvMIdhcps6xgTQxw
	XjmYsLp+z3gpveBE1WcZdIfdFpQcxCZHGWvKug8WjkBZGbeO1aVL8M3BYX1HHWt/
	r0cqB5BIKVpavmAAwhS2GB8BGLtNiLHbYHT5HRxCa209G4VBHlnZyjQ2tWLU9zF/
	dE4AfWzMEs6CEueN6ric+g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpw7gr0et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 22:19:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624LgvGT029749;
	Wed, 4 Mar 2026 22:19:35 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptcd9a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 22:19:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSgv3aFEtE/oxapMk+kI02fByppiQbawkKq+fSkBAcCviU9CrDpDvQpb1WxZTv7aIqT1ptEAU2Ih3B8mU8i/KZpNJS9PUl6qyghxKuRe9zSvWx7A7ID+KNAkf8plgCCm+JLPxQ04Eb4nJxy2CuBs64MxNFvYogAAIp9RyQKrXK1esuuTkyMf4SMMOFszpDd0/QPgWX4SCoa9R8tYTFsAPQakQgLTnmcGF49HVjrjZnLMsYplro0Jmz43ZSGooioP7tQPdSb7F+3+E0McOVxQCXgBguyyUoiPOTj7PDroXKEIhpXhbsGD4uQVll0ZM2TPEcNc5mRV65wWdSBSI3M6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmJd2hCwgjcrFSf4lB8qE1JeFv61f0gI6GoBZpbftYE=;
 b=ki38MPwQ8TAigdCoOrYcUGjon8oLS/RIrL1HMLYe20uxk7nT9uy/0BgU3BQRZmuJmnlN3y8ONIwhQKjT4ADJOxRoSTbWpAA5KHnCB54Od+e3jZq9q+kyKjCpfRF2e2bQ23gd+P5Tu2MqHZzFbb2btzy5+aZVkW6BjtbBpjflDYmkrnZ4rzaERGHginxtxc1ATo242c86qZG/mRRYS7+VO8beImhc9XF+TCUt2iWHMOMGr2mFB9Dx9VlpDORqRMGmsUDwF/CXPOrLSbFAljLihOFFt8k5yxt2MruKZ+UcLV6UBuWkMhoyVtMeEogfm1SsyNiciBfdHEKx+dcoao0RHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmJd2hCwgjcrFSf4lB8qE1JeFv61f0gI6GoBZpbftYE=;
 b=lG2lDYjfaYHz/cViCn7P+8Cp6O/VarBejqPDrZwYdiWIKnAm1G+U6xzA8feuO7NnpPQhI3W9lpSGqT5BGnew99xWzLUzGOIOw+sGUWVnRrh5o1HW0ffoWUarRCLXkIrhOj3+bMmb9cZEauoDJKpdWFiiERuUs/vumzRem1Bk7Dw=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CO6PR10MB5553.namprd10.prod.outlook.com (2603:10b6:303:140::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.17; Wed, 4 Mar 2026 22:19:20 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 22:19:20 +0000
Message-ID: <bc2a3f3d-64ff-4e74-bc03-1a7cb074d108@oracle.com>
Date: Wed, 4 Mar 2026 22:19:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] bpftool: support merging multiple module BTFs in
 btf dump
To: Josef Bacik <josef@toxicpanda.com>, bpf@vger.kernel.org
References: <cover.1772657690.git.josef@toxicpanda.com>
 <b19c2760ffe48cec546dd3810d237f8cad20d606.1772657690.git.josef@toxicpanda.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <b19c2760ffe48cec546dd3810d237f8cad20d606.1772657690.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0026.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CO6PR10MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f69ae87-0b14-43d3-4562-08de7a3c14f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	yvX6CJljKB7VQL6gO21JIbB8bqaA1XvLNZ1oAEyWxsI3pgXfNO8K2fVuz6cK9eT4SYr7Gb1s21U9BwzuUrWpCyAQ23wUIWEhSI6CuKLvWn5ATIfp5DdMI6Jr27w4WmUb9YRTh3cBeAy7KeZAAjed/P5jZbOut+tI2PyZ3oaIL2XrUUl0xLP8HnDJqrBO6gxS5c5s39aGiSkUYNPwmlydZGzCWBAcs/OvrYTmsZ3uoUELrsftq7LVbSWaRXRXx7vLptVWh5lYZgMUpxF9ljO4RvO4b5T6pbxgsWQgYz7ykSmMEqwBPuL1vqkFuZOTAfv5bB3lGRLLdc5pCGzXVyv+GKP8lkRcW25lAPN6fpuMqAluPjDK5eJW+nGfNNa0dx05A9s4ZWizgFH6ZZw/QrkiAPHfyheK4EmBh//qKNPYcVcEBDMGHAJcUCDfoksrq5nWh0y1f004hkoRFow9vjB4gkLQXduQfdozzsyJBuOwOr6pX87+tigFEtDdW7c8hjrRJNfvypAEANwCtJdIPXEp3B4UjbHJG//CAr4iIrs4SSg7A2vpWeyFvrX0CGn2wmJsxgqhoObz2Jk3spqKnfgK2KXSc9igsGlckg283FKl5VPyg1CGxTsBZssXCfGWAHqLziRuKJ1llnjJPInuLLtA2deYXzlwOLt6xa5f/5ArQfbTgLTPiOtPoiboVGO+pcoMo4vEEk7/0T+BxNITJKszZ6hd/6wa+HfJmxT0z/KP760=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW1yMkk3Mkl6RCtwMEdhcENWYk44OHNGMzFLbU9OOTd0K1Nia1J3dGpaYnVq?=
 =?utf-8?B?c25mbXZ2cGxnVUtLNmowaEI3MmY2MFFlOHhUVmhWMitZNUJoYms3alYrcmtk?=
 =?utf-8?B?TkdEb0xGaEREaUJYaEloSmtGQlgwMUNqbnQ3RGtCa0FIaTNSdGhIZ1FDem5X?=
 =?utf-8?B?WVBLL1EzNFFkNHFva3ZjN2tRVnlJcUcvYm9nTzVVMi9ENlVraDhKQ3NwNkZk?=
 =?utf-8?B?YldPVXlwOHEweEl2WEpYVE9nSXNjOWt2SVZwUUF6MGJOd0RGQ01YR0Y2WVRT?=
 =?utf-8?B?UUtqMHRWQThiUnVwcit0aFg4Z2hGc2NIUnozdElkYjNHTytSaitKVURwQUtJ?=
 =?utf-8?B?M2lTYUg3dzNnMTQzc0xyd2VuQW1iVWtmSE12U3p3dzZONU9QWERCWEVTcURN?=
 =?utf-8?B?azBPeGh4QnpLLzdBSEhQSFVSYmh2a2VmaEdZNm5WVGs4VnRaeVJSQ25SMStC?=
 =?utf-8?B?VmoyWHdqVzFnVGlEQm9XeEJEcXhlcXFZV1Q3MldzbWJoeTJVYjlNdkxYQzVD?=
 =?utf-8?B?MVIrc216SmNLTGx4SnkrZUJscGIyOXNnSEFuTmtwT0RZNHhqbUpDOU5Zd3Vk?=
 =?utf-8?B?T2pFVkpqdERZMnoxQU5VQ3g0UDlPNERvVEx4R1ZseE10aGxJNTZtZDBQaWw3?=
 =?utf-8?B?YmZIOTQ5MXBGNVdJUUdJYVEya0tLaGxrUHRMajQ2cTZ6RlU0NkRMdndSNUEr?=
 =?utf-8?B?WkFwQjkxZEhBSk95cnRKWi9PQjNVMldZRTk3cCtXM25GRlhvaVJvbC9uSWhm?=
 =?utf-8?B?a1NzVUtycWhJNWE4NUpvdVY1cUMvZ3V0TU05T3pBSXd2WG4zRnkyay9LMjBG?=
 =?utf-8?B?MzBYQThqbFNHZktrK3IvTHVsVFFWSzZiQ01ZcHVMOU1UZ2FRS2NmelVZUFc3?=
 =?utf-8?B?eXZPME50YnFTcmFhNFpJdExickpqMThRdXowd1d4UE5CWldYenJLZHlreUZV?=
 =?utf-8?B?cXVUbFBjdFpFMUNjRmxGWFdGNkJsSjFHcjRqMU1QeTdpMURpZ21JRjlNaERZ?=
 =?utf-8?B?NmVGUTBzVS82VGtOaGF6blhUb0k2RXQzc0prUXYyZFNUOWdFV083M0NNbklH?=
 =?utf-8?B?bXlNM3czeWpjZUFSRkV6RGNZUlFxeFJvMjdsNmtJdEVpUXVEWFpvTVNDSWZY?=
 =?utf-8?B?ajVDTDBRbE1lWHlXcnlrMXRsdGlYM0tjWjA1OFdKS2RkMGRsWFBGaUgvRC9W?=
 =?utf-8?B?SER2YVFDMGxPSi9FTktPR0gyVllsTmY2YitrM1FXR1Q4K0hKZ1BXVVlhbFZo?=
 =?utf-8?B?NXVYd3FjdTVTZWFjYmhwZVVIUjZIcEQ4d0dKUEZ4bGErRmxlZVV3cDVlVWR4?=
 =?utf-8?B?Q29mczVzNmxzcjBLSTJycEV5MkpNWjhRSVY1QUxwN3lxRFY3Q243eVR4SHJV?=
 =?utf-8?B?c0FQR1N6R0UzcDZTdDB1aWRKTXpQcFN4ZGxIWFc0SnMrcFdVcWVhVTBUaTdB?=
 =?utf-8?B?Ti9lbWNSakVJdGkyajhFYnhTYTRqeXFPbEc5ekJSMk5Pc0tzZmhEbVVycisr?=
 =?utf-8?B?TitidFE1SlRxbGlEbW03a3Y5SG9PWmhZbWRuSXZPVVdxeVNvYVJVcGJqNTNt?=
 =?utf-8?B?YmZYUzlkUzV0QWhUdzlCZmJCeVArZEZjMlVwZ2RQTE41Y3BHVm1EL1lDVXMv?=
 =?utf-8?B?YmUwNnBZWlB4ZmM2OCtxZnIwV2wvcExkbzY3dTV0SC8zYXFqSDhoeHF6WXpU?=
 =?utf-8?B?SlRrQndnSkRUZTR5SmY2ckEycFdrdy9PQm56d05kSkg0enFkL2ZuUnBVVXVF?=
 =?utf-8?B?UlF3b1dvMlJhOXpxdGFPTDYxb3RCQUVtbnQ1aFZwSjFaNXBLSjZ3MjUvWGdF?=
 =?utf-8?B?NUJjbmliUVZoWUYvaGxUZXF2dnZYbTBOZkF3aFRtR2N4VElneitkSkJ1Y1V6?=
 =?utf-8?B?Z0VTMjFrZWNxcDd0ZXR6Z1BBYVIrQmFSZWkrQ2dXZW42MlV1bWJXTXpXdkNv?=
 =?utf-8?B?NDczQWV4Rm1PbThCWVdINXFLSk05RVh0bC9yZ2V6aFMzMk92QzRDYmcxYys2?=
 =?utf-8?B?a2l3RTQ2MGRiMzd4ek9BYjVOOU1mNm8yZjdHeEZ1bmY2bDg5Z2NZdDF3VHpC?=
 =?utf-8?B?R0tONU9ra1IyNlJnWDA0bHBLK0FHQlJVWFZEOVlNV0k5Z0k5KzVITWZFMjlm?=
 =?utf-8?B?bHc3SFBuNnlKSURBMW5JN1VRb0Q5QVpYclBJS2E4eFVEOHRQbmhRVHErRnEx?=
 =?utf-8?B?THF5YjdXb2U1bHZscXRKTnJ2Y3MvcllVTXd2MGpvQmliQmJ2bXRsNDRDL0pX?=
 =?utf-8?B?VTFhTHo3VlRsRUsvbitEUFBuRmNqNzRvUFA5eksxcGhlVmljbFFVWEo5ck5Y?=
 =?utf-8?B?bDdFcHNWTGRaUkxCUWFWck5lRmpLSGJ2dy84dHBmTHlXd1MzZ21pZz09?=
X-Exchange-RoutingPolicyChecked:
	KpZ/Wla1pf8gfmOrGNDr+IHcU9b6T9BmbbfSIO5z45Hup3k9TQS+v1gG+mmkxCIk0OAY+ZNKrUpFWx+kQUTtS2S3jk+NBbb/eN1ibfHrXmyfreUCJRweBf2M75X1/PJfXPkUy76N50oFhKHBMFOpjisKlSBPdg2F56KwPD0jGqVbpMyO5rcvYnD2+VGGYdbB7KrgjrMDwzvHup6FdrqCD+1ykIfDI315UyGUtzT7s+3KznhiDXjE4PaMz0Wc3v1xFRDXTxI2YUZL1ux4IR0c+Wy2BSQXHw15I4f5xQObOzQFxWdMzGa0kznumF+vwSC6mrWtGH67i4ykNEsBvfP8hw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8hK+DfN5urlDBBKh5KlIJYxEv/9MBODDV6bzhp1jXE6jhGIc7vBQIZUXywzKKsiUUA+9xnqKK7r8k3Vgckg27YpQ9UPRIRqRTdzxpL/0sWhIRUPWkLdEQzO+no2RPsIsq4MrBB14jUSLC+adDACjt+f25fN97tEhhoeFHx3cG3Iuz1XmPR0uioAP8pSI2P+S+M65PdVmFUG8bjvFJ0luASk+J21xeIUg12olpG1W2FSsX4yejCq81g4gw8xVxav9b41LD+nobmb0zSeUjakOZlzKrmaPXIHd2k3ImFOsdjYUX2UqsWnhzNwtSdV5MhSFk7Sb0X0XAZ6WtfaeKw2tQomlHcUqABWoHhQVU3X1o/89jtUpDZU/zqoMj62PWSaTSv4fFGf0SywmggyUdkCWtm9+Rsb7juxstXG0K6RjujiR9/DlDjSWbBz3O9vtmLNr13OTuJVH9fxeJsxSKr7VBkpqt3gNscLvHWTYFQFUIXtWyVu2nCPrIckT4DVkLnoKi8DVCsM/3pjYdUcDTYDme7UBPjhviNYxNLfbFYf9MiaYCUcMrhj6h7QcLqJMeAo5Yxv58ajSFCVvNxJ9UeX22QTDW6BAdbXtydgssnaje2g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f69ae87-0b14-43d3-4562-08de7a3c14f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:19:20.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVUPkPW/CDAUwNtsvxR7+ybDbut2OcaQsIF1ysnp4o0SZto3KLvddUIVfy0tUNwcijTEiLosP0GdJPivfzX7+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_08,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603040183
X-Authority-Analysis: v=2.4 cv=AMMfTYaD c=1 sm=1 tr=0 ts=69a8aff7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=maIFttP_AAAA:8
 a=yPCof4ZbAAAA:8 a=dcwo75d0aCNZSCF1YtIA:9 a=QEXdDO2ut3YA:10
 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-GUID: BbvltyOwPeL4VzbFnGsnhdD67N7kThtC
X-Proofpoint-ORIG-GUID: BbvltyOwPeL4VzbFnGsnhdD67N7kThtC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE4MyBTYWx0ZWRfXxKR4XuwGlalE
 EDo+k6mF0gq/H0WLmLtbS9GMWNKQcxUGbspd6hI1/w2rtYIS2zqPCXmisNLxQ1fhfV8grBLzTFP
 tjGkuJYnFfTjWwsKjWHiq5efUeVQBbylmgqwORB+MfkJoiT1zNW2Uw146k9voPNhcdpLSzUdelL
 bJCL5aBWn9KcrDKldRzwD5z+HDZ5QOvIkNfQt73c0rfmlmgLWrs2SZ+JR4WCWuF2rlk7M98zMor
 M1iivsS1F5W2dZ+slnQhnYIjizVoJrmMO5mfK+Ac0rshzos0aNutukajDdm9jYfD8CJnArN58Xs
 nxKan5SgMXkM2IlV331mhX1jIfA8JCvPAoE+b5Hd7rNx6Dxmm/dQDDmC9CmszOW9mUjVycyUnHw
 R4n/WHhRwsyAOdDKCcx00BwmGHxJMxcVFln2iU4JBWKZa6ZGpAhSBlt6mN30OV3c465hQaPm7mu
 OAAvb4VRm4NIP5jKYBg==

On 04/03/2026 20:56, Josef Bacik wrote:
> Add support for specifying multiple file sources in 'bpftool btf dump'
> to generate a single C header containing types from vmlinux plus
> multiple kernel modules:
> 
>   bpftool btf dump file /sys/kernel/btf/mod1 file /sys/kernel/btf/mod2 format c
> 
> This is useful for BPF programs that need to access types defined in
> kernel modules. Previously this required a separate bpftool invocation
> for each module, producing separate headers that could not be combined
> due to overlapping vmlinux type definitions.
> 
> The implementation collects all file paths, then for the multi-file
> case creates an empty split BTF on the vmlinux base and iteratively
> merges each module's types into it via btf__add_btf(). The single-file
> code path is preserved exactly to avoid any regression risk.
> 
> Auto-detection of vmlinux as the base BTF from sysfs paths works as
> before. If vmlinux itself appears in the file list it is skipped with
> a warning since its types are already provided by the base.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

again minor nits, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

this is a really useful feature, thanks for working on it!

> ---
>  .../bpf/bpftool/Documentation/bpftool-btf.rst |  11 +-
>  tools/bpf/bpftool/bash-completion/bpftool     |   6 +-
>  tools/bpf/bpftool/btf.c                       | 132 ++++++++++++++++--
>  3 files changed, 132 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> index d47dddc2b4ee..cf75a7fa2d6b 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -27,7 +27,7 @@ BTF COMMANDS
>  | **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*] [**root_id** *ROOT_ID*]
>  | **bpftool** **btf help**
>  |
> -| *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
> +| *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* [**file** *FILE*]... }
>  | *FORMAT* := { **raw** | **c** [**unsorted**] }
>  | *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
>  | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
> @@ -58,9 +58,12 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
>      When **prog** is provided, it's expected that program has associated BTF
>      object with BTF types.
>  
> -    When specifying *FILE*, an ELF file is expected, containing .BTF section
> -    with well-defined BTF binary format data, typically produced by clang or
> -    pahole.
> +    When specifying *FILE*, an ELF file or a raw BTF file (e.g. from
> +    ``/sys/kernel/btf/``) is expected.  Multiple **file** arguments may be
> +    given to merge BTF from several kernel modules into a single output.
> +    When sysfs paths are used, vmlinux BTF is loaded automatically as the
> +    base; if vmlinux itself appears in the file list it is skipped.
> +    A base BTF can also be specified explicitly with **-B**.
>  
>      **format** option can be used to override default (raw) output format. Raw
>      (**raw**) or C-syntax (**c**) output formats are supported. With C-style
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index a28f0cc522e4..babb0d4e9753 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -961,10 +961,14 @@ _bpftool()
>                          *)
>                              # emit extra options
>                              case ${words[3]} in
> -                                id|file)
> +                                id)
>                                      COMPREPLY=( $( compgen -W "root_id" -- "$cur" ) )
>                                      _bpftool_once_attr 'format'
>                                      ;;
> +                                file)
> +                                    COMPREPLY=( $( compgen -W "root_id file" -- "$cur" ) )
> +                                    _bpftool_once_attr 'format'
> +                                    ;;
>                                  map|prog)
>                                      if [[ ${words[3]} == "map" ]] && [[ $cword == 6 ]]; then
>                                          COMPREPLY+=( $( compgen -W "key value kv all" -- "$cur" ) )
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 946612029dee..c44e86a64760 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -28,6 +28,7 @@
>  #define FASTCALL_DECL_TAG	"bpf_fastcall"
>  
>  #define MAX_ROOT_IDS		16
> +#define MAX_BTF_FILES		64
>  
>  static const char * const btf_kind_str[NR_BTF_KINDS] = {
>  	[BTF_KIND_UNKN]		= "UNKNOWN",
> @@ -878,6 +879,49 @@ static bool btf_is_kernel_module(__u32 btf_id)
>  	return btf_info.kernel_btf && strncmp(btf_name, "vmlinux", sizeof(btf_name)) != 0;
>  }
>  
> +static struct btf *merge_btf_files(const char **files, int nr_files,
> +				   struct btf *vmlinux_base)

here - and below - the naming implies that base BTF has to be vmlinux. While there
is special handling for sysfs paths to use vmlinux as base, it would be good to
just use the more neutral base/base_btf as name I think.


> +{
> +	struct btf *combined, *mod;
> +	int ret;
> +
> +	combined = btf__new_empty_split(vmlinux_base);
> +	if (!combined) {
> +		p_err("failed to create combined BTF: %s",
> +		      strerror(errno));
> +		return NULL;
> +	}
> +
> +	for (int j = 0; j < nr_files; j++) {
> +		mod = btf__parse_split(files[j], vmlinux_base);
> +		if (!mod) {
> +			p_err("failed to load BTF from %s: %s",
> +			      files[j], strerror(errno));
> +			btf__free(combined);
> +			return NULL;
> +		}
> +
> +		ret = btf__add_btf(combined, mod);
> +		btf__free(mod);
> +		if (ret < 0) {
> +			p_err("failed to merge BTF from %s: %s",
> +			      files[j], strerror(-ret));
> +			btf__free(combined);
> +			return NULL;
> +		}
> +	}
> +
> +	ret = btf__dedup(combined, NULL);
> +	if (ret) {
> +		p_err("failed to dedup combined BTF: %s",
> +		      strerror(-ret));
> +		btf__free(combined);
> +		return NULL;
> +	}
> +
> +	return combined;
> +}
> +
>  static int do_dump(int argc, char **argv)
>  {
>  	bool dump_c = false, sort_dump_c = true;
> @@ -958,20 +1002,83 @@ static int do_dump(int argc, char **argv)
>  		NEXT_ARG();
>  	} else if (is_prefix(src, "file")) {
>  		const char sysfs_prefix[] = "/sys/kernel/btf/";
> +		struct btf *vmlinux_base = base_btf;
> +		const char *files[MAX_BTF_FILES];
> +		int nr_files = 0;
>  
> -		if (!base_btf &&
> -		    strncmp(*argv, sysfs_prefix, sizeof(sysfs_prefix) - 1) == 0 &&
> -		    strcmp(*argv, sysfs_vmlinux) != 0)
> -			base = get_vmlinux_btf_from_sysfs();
> -
> -		btf = btf__parse_split(*argv, base ?: base_btf);
> -		if (!btf) {
> -			err = -errno;
> -			p_err("failed to load BTF from %s: %s",
> -			      *argv, strerror(errno));
> -			goto done;
> +		/* First grab our argument, filtering out the sysfs_vmlinux. */
> +		if (strcmp(*argv, sysfs_vmlinux) != 0) {
> +			files[nr_files++] = *argv;
> +		} else {
> +			p_info("skipping %s (will be loaded as base)",
> +			       *argv);
>  		}
>  		NEXT_ARG();
> +
> +		while (argc && is_prefix(*argv, "file")) {
> +			NEXT_ARG();
> +			if (!REQ_ARGS(1)) {
> +				err = -EINVAL;
> +				goto done;
> +			}
> +			/* Filter out any sysfs vmlinux entries. */
> +			if (strcmp(*argv, sysfs_vmlinux) == 0) {
> +				p_info("skipping %s (will be loaded as base)",
> +				       *argv);
> +				NEXT_ARG();
> +				continue;
> +			}
> +			if (nr_files >= MAX_BTF_FILES) {
> +				p_err("too many BTF files (max %d)",
> +				      MAX_BTF_FILES);
> +				err = -E2BIG;
> +				goto done;
> +			}
> +			files[nr_files++] = *argv;
> +			NEXT_ARG();
> +		}
> +
> +		/* Auto-detect vmlinux base if any file is from sysfs */
> +		if (!vmlinux_base) {
> +			for (int j = 0; j < nr_files; j++) {
> +				if (strncmp(files[j], sysfs_prefix,
> +					    sizeof(sysfs_prefix) - 1) == 0) {
> +					base = get_vmlinux_btf_from_sysfs();
> +					vmlinux_base = base;
> +					break;
> +				}
> +			}
> +		}
> +
> +		/* All files were the sysfs_vmlinux, handle it like we used to */
> +		if (nr_files == 0) {
> +			nr_files = 1;
> +			files[0] = sysfs_vmlinux;
> +		}
> +
> +		if (nr_files == 1) {
> +			btf = btf__parse_split(files[0],
> +					       base ?: base_btf);
> +			if (!btf) {
> +				err = -errno;
> +				p_err("failed to load BTF from %s: %s",
> +				      files[0], strerror(errno));
> +				goto done;
> +			}
> +		} else {
> +			if (!vmlinux_base) {
> +				p_err("base BTF is required when merging multiple BTF files; use -B/--base-btf or use sysfs paths");
> +				err = -EINVAL;
> +				goto done;
> +			}
> +
> +			btf = merge_btf_files(files, nr_files,
> +					      vmlinux_base);
> +			if (!btf) {
> +				err = -errno;
> +				goto done;
> +			}
> +		}
>  	} else {
>  		err = -1;
>  		p_err("unrecognized BTF source specifier: '%s'", src);
> @@ -1445,7 +1552,8 @@ static int do_help(int argc, char **argv)
>  		"       %1$s %2$s dump BTF_SRC [format FORMAT] [root_id ROOT_ID]\n"
>  		"       %1$s %2$s help\n"
>  		"\n"
> -		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
> +		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] |\n"
> +		"                    file FILE [file FILE]... }\n"
>  		"       FORMAT  := { raw | c [unsorted] }\n"
>  		"       " HELP_SPEC_MAP "\n"
>  		"       " HELP_SPEC_PROGRAM "\n"

