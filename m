Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BEF3845BD
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340406; cv=fail; b=ofpJCEamDvu+0vjtl8bYndWa1EE3C0ptaq3KSCDxdGWmbATfiH2AHzcA8HDaHU5kiyA8bE9nVANvJohCIcRxjyBEYsUdfOF0/WBhknMSESHDqkDkrIf34bcqwdWWgKVU0wxADYVF3eQaQMqri+/Iesz1YMI0fwL5tJ24SXgQ+kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340406; c=relaxed/simple;
	bh=b6CdaPGU4ToNeGu0Gl7wszDB+E+8mt/N8eFGfdp1JrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1xWSR8ZnvKw6J/AFSiFHv85Kmw7mEZu3G8DMp6VrEBf09tNB/KjuQ+pzu+5kfFulVdHr6ly5OXkQ9sjifJfPV2mkFFlrDbunp1GoAofx9NI2ILwyf6C3UrKcRfNT+quaw7RcR7dEnH5glM/jYNt4xjmWRvwRoW+4zBFmXtPd3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lANisa9t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CBL5RFNW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lANisa9t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CBL5RFNW"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6ZTn72136605;
	Thu, 16 Apr 2026 11:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7uOx3X7KCGBdKy39DqnEniiQLeznUVtFwkwBSyVgZQI=; b=
	lANisa9tH1QMHsXVn8j+tyQphUIqWlqAd0gzstt2AMqIuR9zGXvrOADOG/+ltUM0
	0mCpBjj+FTM1b+u0nPxa5DVjpByW5sSbcOG6RSHG0vqBLZuSPWm7RNXhDStb3d4b
	1AlVCIzrvc1qy8y1669PPsup4bBMTZY4gQNUkA1ZZJr1XgtMm8+n9Fl3d/SfkiEL
	DPZo3ikkDU5IEwCpgT8Z/M28aPq2bOz42+wNKGLV3rgBb/GmEknM4ekd9qUYBynJ
	hCPhINCbI2ovlWsZcCsgpKcmcMVJM0us2yFDbsKlH8uZneNEVB4irCvtSdX5Dzzi
	eaMNF/96lCRj8vLhXkGvbQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh8687d8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 11:53:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63GBnRq2023302;
	Thu, 16 Apr 2026 11:53:17 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh9jrvyk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 11:53:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpqxxFtN8axg1FhNQrpEemnYUDFV2rLz200UM8DYdtixIQGbx38AlVQrL8k8p9a6Xf2a7lyNB9SKy8WLhq4dU4BpiKr3a5j80FCksO5/qSDJmXs59962zQRtK1oE0/pFvObdQv2YGssq8wpwAoSRNPrV1kap7TX+xTu+CnnjVkJJk33kITHlgwuNiBn0w1ZqVQoXv2LMX6Pp+26tO3sgJ4d6nQ/XyxSGsohwMjLFmiXEaqpCjGnM9aNyImrg58CW5pW7Ha1GdIm+M6EOi6vO9wtVcbIjPLOpBHyvWXGOIATVuyv1b66Bdqttsj39cGiTQ7Wtp19SBg8immjakYdtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uOx3X7KCGBdKy39DqnEniiQLeznUVtFwkwBSyVgZQI=;
 b=TCKvESoRRSv4/zhXpdpxGJKrN/Yw+af37T7QJdKKN1GKJLxZWYAT7BB5ed3K+8eR9OpiefIrencShorDyVM0mOcq/3Q7bzYKd9prGIc8WfB72fcz19icUt9B4Ns3AVEkt3/BWsqi6htZPKczB225O5JPp4Qf/sKWYTMxRDjm4jtPzv8OgLEQ7DHe27EzXG30zmHGjWiBZTUfstIdVPwYuo2UzJTqJGSVfa0vNtLd0dfZNiCUliUKSyUVDjGsOwcpHQorMAMyN21QV0DQ8q7pGNXviI+am3Kx1oLcwJIlnqpEdrT6SM6gNvPOcHgQ+qsiX1UaIoP+272VzTapbb1fOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uOx3X7KCGBdKy39DqnEniiQLeznUVtFwkwBSyVgZQI=;
 b=CBL5RFNWsHts7Stlptp30DpD6J0FvSF6atDK7bHRZkmhrEvEQtQWhEuDToPl1pdAPeXa1v+5eHYEj6+lrriifAb8cvkAyvE07g6joZk78fHadERznpKSxEUGWt39TPUU3BLGv9wYisk8qY1MfZC0ntO8MvKBObnvbPHQdBCnRmQ=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DM4PR10MB6158.namprd10.prod.outlook.com (2603:10b6:8:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 11:53:13 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 11:53:13 +0000
Message-ID: <b65d0326-766d-482b-aeb4-1d6c3adf31dc@oracle.com>
Date: Thu, 16 Apr 2026 12:53:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: fix deduplication of typedef with base
 definitions
To: Antoine Tenart <atenart@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org,
        Paul Houssel <paulhoussel2@gmail.com>
References: <20260416073826.142056-1-atenart@kernel.org>
 <74ee8ec0-904b-40ae-8fd8-25e1aa24b465@oracle.com> <aeC3ta43I7ZJFWZ5@kwain>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aeC3ta43I7ZJFWZ5@kwain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0530.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::13) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DM4PR10MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a2ea36-5afd-498d-45f6-08de9baebce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	U54Plh20ws0CZmbrU1jQnzEVACSovXie3i3zPlSTOmJ0RC0QCW837bw4Nvm6amu1jHN2wZhfgfniM3ZAX/pSZgI/2CSNnA1AE+vwed03M0Xc31FvHVa6ia+ekAu9Eah9s0YgSiOuRs4wHGv4tCAO3wSNxw/DgSQuhDgH0fULUcq+rof8n1orIPKOjv87d+Pog2FMhbVyqs9LveDVATNW+SUgHZqe5s46Bsukvge1fyFRBu7iC+fPxmEsja2vxQT6nPsCdh884Gp8BIg7BwYX1MEmbHSoUKsQguUyPahn4vbGwnqBtMKSpOia+RmfYmB53TFhqxcMUoTsjxg7pC9JuiuYee00aos+S/IQtUwkBRGg5dtgIv9JoqDJ7bF1iMc/avvS12UoWchhin/CAl+uRDpu+rinhZ8TDmmjQ5XXPCXw0MEpl7pqy45xcF8P7IJ/AIKYxE9vmjzkVZqJfltlRP9M0fbNv3dOs/n3GucINhP8BPe7eji83mqsxyUoZ8Nlb25mBNwttW2AAsGIGCsk/9VeGS9rBbd1Ke0hhh38ezNwD348D6rvs4FfYfUaArqA0Rckvuk8OMLBu+3BWrPxoTbs4u95B1ksDSxWduJZ25nG9/AgPmszOfl8BmU9RKw7QK+Zc1l7bgP4w0VWTKtwq36cVvwNm1awp07UnzzHlLphMokhqOFnqm8tXe2RMzm+OVKu/DbOLEKC7VzekxUw2pyoefNbupP81vOu0ibyJOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3V6dmdlVTkzUXZ4Z3FpWlNCQnMvQzliSklYNjRNSjFWVkE3aHpnWWxwcmRV?=
 =?utf-8?B?V1RSSGlkNUcrbnVVQjUveHBBZWI0a0NHTkxjWVhvMEdjYnRUN0J4ZFR2dWpo?=
 =?utf-8?B?M0MvNGFTcUJFemo2UDViQ1lxT2FNNUZJT2gvR0k4Y1ZCeGNXMFc5anZ1NkVm?=
 =?utf-8?B?Y1QrZlRpVEttSnFpWU15QTZBRG1jazlaMlNVdk5pVjJkd1Job1ROdDBvSDdu?=
 =?utf-8?B?d0lPa3F4SUlNVnNaV2pQaHJtMVNlZ3RSWEVEYlFHblBCY3llQlVqUmxFMFJ0?=
 =?utf-8?B?OHVGVkZLSHVJRytJS3luZk1lSWlBb2wyUFpXdlV3VkxnekMwNUpoa0JPa1pK?=
 =?utf-8?B?MmE4ZXp3cHQ4ankxYTNYb3VGVDkwM1h5a0wzQzEwbFhCY1FRMnB4WWZlVlh5?=
 =?utf-8?B?aGhNVnhuOTlsSGRvbXFyQTBEd3FYbHNKcEpVNUFOMmNyS05QenhjT1cvdmpl?=
 =?utf-8?B?cnU3WGRYM0pnQnZFYkJUNEJqeUo3elBKaWxWVGJMZVdHRFNETzhIN05JaVdY?=
 =?utf-8?B?RDAyQzZ0VGIrbk5Zd1pZbjNPRVhEMjN6WS9rV2Z5cFQxeEhIejczS0N1Qlg4?=
 =?utf-8?B?Vld0b0tOSWJReTY4am1hcDM5ZE02amYyMmFpeXJVV1pSZ05uT0E0TTQ0MTdp?=
 =?utf-8?B?NU0zaDlmcFUzbnlUS3VEREg4blRNbFI2MlZzYlY1TTdZTThrMkxQN0xqeGxT?=
 =?utf-8?B?SmZHdzhLKzZoV3lBSktIUmp1cTNJTjdwcmNpMmNCclJvSDdzZGt4eHp1c3lU?=
 =?utf-8?B?SXZheWtWNFQxUGcvYmVjakV3cVF5bFVqQ1FCamFFMjdmQUVkcjlzd3dPc1pH?=
 =?utf-8?B?REVMb2RJSlFxdlc1VERGSkxOc1dtdU8xVVp3VFg0Sm05UFEyQWdLd3lXUHh5?=
 =?utf-8?B?RWZJYkZoYUpYY0pGeVJRejdjTHdVOUxlN0VCVEJXd3k5T1lIU0pDOCtKV00x?=
 =?utf-8?B?RURkcWU4b0pMTDdJd1pBYitLWERDRld1RDFhU0hsVmF6V0FIUmVVd3VBRnE3?=
 =?utf-8?B?d2dtbVBRdUJmQ0tXaVIzaThhMXNsWEcyajR2bGg5OFphWXNRVlZoZU5rOVBO?=
 =?utf-8?B?ck5DamwzbWlwRzNWMTZZMnM1VVMwZFNabG5ETzU3V2dkMnRXSHZ5UitaTTIz?=
 =?utf-8?B?YzJuazBzYWV3V2VuZkdhREFseGhjQlJtaGRGVzU5akhmRUNtcmFLNDdIWWFr?=
 =?utf-8?B?MmIzYjl0STdJUjArUW9ncEh6cFU4UjJOZDJQa3Mwc1k2ZTVxOGEzRmJzM1Nq?=
 =?utf-8?B?M0xnWDF2MmI0bjNmcUl1YzZZQ1I1UEZJMEpyNEpublEwWkdwZWpkeHZyMG1Z?=
 =?utf-8?B?MisxdzJlQXF3SEs2NXAyenpJSzgvckE4M2U3bWh2MTdxbFR3alFQK1RKU0wz?=
 =?utf-8?B?bVRJR09rNjVRSVFrS3lma3E4VEtLcWovbC92Y1daSlF0Ukxod08xMkJKZ3VL?=
 =?utf-8?B?eE0yemZSK0hXa21kYk9qbHBaeGduTkV5VGNmaFpHd0laM0RaRDg1QmhoYTBW?=
 =?utf-8?B?VEgwSDh0VmJvSmh4OUVGVUEzYy9OdmxkZkJZNzZCWHF3eFhXa2dzSlQ0NDda?=
 =?utf-8?B?ZW05dXM4SXg0b1dlNlZVVzdVU3dYM1IxK29haDVUUzZHaE9yZGJpbnVjWkEy?=
 =?utf-8?B?MkxuVnZ1RlVmUDc2cDdPZENKNWVXTVptOWJDeS9STHovdEd6WjBlWmtXQVV4?=
 =?utf-8?B?THNvSVpXMkJpcS9sSHplYzMyeEpURHRjbklxeWtSWE1vN1FwdkcrelUvMkFW?=
 =?utf-8?B?ZmFKcTJYTlptZ1ZxTzBRNENHaVRRa1dpSlhUTEpoQmNXblRGV0pYOXY4V0dp?=
 =?utf-8?B?ck1pM3F5K3RTNElvOUdyRWN4dDh2TitRMVZOdENtbmVlSlpWWlY1MmRwRU9t?=
 =?utf-8?B?TmdCR0QwS1JVdmJyanpDL3dZZkFuOFNGT0pDK1k1eVg1QUZheEZSd2JVaXNI?=
 =?utf-8?B?a0RIaVlIUHZUTngxK2tIU25sVkZKeUE4b051TVhJem5aekVCZTNCdTRrQUtL?=
 =?utf-8?B?ZDFOck9hc01TeEdYbnNkYW5NaFdMVnJGaUx3ckRTR3RZWnRaczB1ZzdaVnNx?=
 =?utf-8?B?Yk1mVHlnYnB3dHBtRlJvS0U4VEdTU2tIQUJBdGJDTWN4MzFUZ3JJYWNJQVl4?=
 =?utf-8?B?blBEV0U5YnVGWm96bGtzNmJEclZzTlBPa0w1c0JoR29HTWFRZS9Za05DTElo?=
 =?utf-8?B?QWxYcStyUldIcVVEcCtDb1lucFdMSnZJcjlON3lJcVh2VnI5Z2FtZGRmVlI2?=
 =?utf-8?B?cDAyalBHOHBzVzRodEVtc2lvWjZ4aitNUWplZ2hRaUZ2alo1L0pIcEpmYnhq?=
 =?utf-8?B?R1VkNVpoV3J1K3I0TXJjaXcySGpxdVVCY2RjMzJYQW1rTFgxV0xMUT09?=
X-Exchange-RoutingPolicyChecked:
	EnDAyyYBDlaXr9aFwP6Ta0vyJRf0Dtzos+mxUA0I/odBLZLiQX30jls9CsqcMPDFKFE2zGXNGXf3OiyBQDSHx5VZ6CYLN7aOJZL79Sg2hySQNffZUYMW3kXDdxQRplPCxjKo/gr6h7uZiHxt0+fjdBUkDpflWOXFp9JPU+SPs9RD/1VZFL03gMov7LTnXfIPyNTUBdQt0Bpf0yvkEMjNV+8bdLGhX0L2tueMf6WUZyLF00u/EU96oCOe47NGFlBPc0JMs3knXmWMFcUGCVykQbRJez9VhnmLd49f2R0iRCwD3FIgPDmjL0vDsHtB/otR75DU7OS+HObHjeMF/5TxTg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fT7fYzrqVT3a9OC6YL4G65zT0GneXvieB8mD7g1qoBGdYB1qMshjvjsc6iDPNmhVb7O0CTq+t9wAgvzj+s++ebDT1KmoE/3jDuScQP3XkUeEbL5or9IE67VfAOVHjbKdCX+kAu9Rl3PLDJsH4kZdoXJ7jnqynKLLUVME4nkZiFzP3LJY5WaCgU3g1m8VJLcFieQD6Ri7EM0SfSqgtxMki/wlCr2F6nguqVj9Ln5q1I6mylWF4bPRBOYz3lZh7xbbYX4rvdrFeN+Eh5TJ6shwMIlOU13eufwoloEQJRROzlQBle8GVrTafYjVkKkz/fz6iofRLvgkSsfeFCHyeIH6fjEvhv8cfN5EaazLwU07RIuNDd7AaDMCbYrbi5Am9ZIpFpUn/unlMsIBm+gGFQh9jHtgJOk2P7rChNfrnSB09FNw2pKcprpAI6DbucjIUtA4UU+btwY0g9A3fBEcCvYZnjhbJ86umvcPPI59BL1FAoBt8uXulkPqOjTz2Q+l4B0MtIP3Au8upeTdnroyBAcaWKgZgDtI9FFyx8KMG7M+RW/pzvnQT9jetV5pOQRI7KCBqtVXnJvlk0KhaHoi0lVIRszpuDf9vW9PElayh9FxeIw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a2ea36-5afd-498d-45f6-08de9baebce7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:53:13.1801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPX/MdbkhJ6b0l+BgPlmeyfjizsYVYH2FVk2rPtLrr0IDZg2dIBuVoo3n3Qm3H94b/5x7gtHTI1RfZQ/B4xSgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604160112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMiBTYWx0ZWRfX+1ltlpceAMzX
 vmHKofnYN/TOdsa7I0TOERs3WNB1IILYtWKYDcceZwTHxuXFunbUWn58V6xVIuD4zXfkC3VJHVL
 rWiyzbWaQfHs7mMF6WcXbVnatgr2rR6sMNk1i/4ABZIp9K7Fa6UN0tbkkd12tXsyZDaFE2ZXyPi
 ZT5Z3BiAU2OhsXgLv/KHgbT18Zwv8eCllT6hQTSfGA+xqcO9ZelV3ZUREG228/CI+jGCsHigcPh
 XwrBx4ZKNVOQpqLpbPW2tSt/j/vJNLIWop/G4BsygmEDrKTProjeoY4SuVa59tS3b4TUP0r9ADx
 VC473o5htvJk1yL7FtnZsfDsy4I9UiB7QTC1iVUtmWghvPfQ8PESq6cAg4iJjq6zq/53HOnhuFj
 Ysu8fBtGzqTeqNsrjFJPyMrfx5VK92nlDi2Ku4CH2zGEDplcFQwUH25jqv5PabVVVUUdt218fX7
 XDMVOXrXWxaMiNcBlyA==
X-Proofpoint-GUID: nc1HXoZ2tu6q1V5ZfPxRsC-EWvejH2N0
X-Proofpoint-ORIG-GUID: nc1HXoZ2tu6q1V5ZfPxRsC-EWvejH2N0
X-Authority-Analysis: v=2.4 cv=JY6Ma0KV c=1 sm=1 tr=0 ts=69e0cdae b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=FUCG-ZQX3y9wA8q_yFsA:9 a=QEXdDO2ut3YA:10

On 16/04/2026 11:20, Antoine Tenart wrote:
> On Thu, Apr 16, 2026 at 09:31:53AM +0100, Alan Maguire wrote:
>> On 16/04/2026 08:38, Antoine Tenart wrote:
>>> When deduplicating definitions for a module, typedef defined in the base
>>> are not removed. This is because the hash used for base types differs
>>> from the one used in the deduplication logic in btf_dedup_struct_type.
>>>
>>> This was introduced by the referenced commit when moving the typedef
>>> deduplication logic handling from btf_dedup_ref_type to
>>> btf_dedup_struct_type, as this also changed the hash logic
>>> (btf_hash_common to btf_hash_typedef).
>>>
>>> This also impacts other types referencing those typedef (e.g. const). In
>>> my test, the BTF section size of the openvswitch module went from 31KB
>>> to 45KB.
>>>
>>> Cc: Paul Houssel <paulhoussel2@gmail.com>
>>> Fixes: 3781413465df ("libbpf: Fix BTF dedup to support recursive typedef definitions").
>>> Signed-off-by: Antoine Tenart <atenart@kernel.org>
>>
>> Nice catch! It would be great to have test coverage for this in
>> prog_tests/btf_dedup_split.c ; adding a duplicated typedef to base and split
>> BTF in test_split_simple() and ensuring it's removed from split BTF
>> would do the trick I think.
> 
> Makes sense, I'll add a test for v2. Would you prefer a dedicated test
> or reusing an existing one?

Thanks! I'd suggest just adding identical typedefs to the base+split BTF 
in the existing  test_split_simple() in prog_tests/btf_dedup_split.c, ensuring 
the deduped BTF only has one instance of the typedef (but in a separate
patch from this one). That should be enough to verify this is fixed I think.

Feel free to add my

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

to the libbpf patch.
