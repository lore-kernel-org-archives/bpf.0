Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8037DAAD
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364845; cv=fail; b=eL5Htu3fcznoofxTeuEax+JC3Hr5qfu+IMYrtjgLP6MluXez2tSXgPQqn98Fg+dkW7FBhElDUCrdAyNBDayoQyI5bRTWF+ahMWWv+40RRFO4yWLhlNVmMDn3WDpniOdTEyj27XPToQK6i/gbTLStG69AVZEA7sAQpYWbfl8RrLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364845; c=relaxed/simple;
	bh=rEfLH38GkdqaUimiU0WOoNl2E38QI5v+3+NLDI/Im08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TwwA1t0HRXHe/egRMYk9lS2/Bajq1IduS8kExtpQSiap2hE2EXUEB0nIOTkv2nCu2v1d6NJPJTv4tcrpH8wBxwc4QYCK8vdCefMEt4PrwoYJkUCARy8e4XjWUJqCC2OwVqd1Ze+6er39c/g/JxhFFnaPlyVPeb8xQj0kaMFsxbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pxB1YdC3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dK+aePZI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pxB1YdC3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dK+aePZI"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679NjQau2671228;
	Mon, 10 Aug 2026 12:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Kbb7FtTuy7BhJ4844XpD3gJv3VccS/ZFRYfjMRRllow=; b=
	pxB1YdC38lgawIcl1jA1xh6/nryXDlq7k9px/6XRL4kH6etyjGoH3yENEZN671mz
	XVKQ6zQeGzyEwbETqACDb32rEcyTgw9qhn3HczkR3C82Jr668+dYaW0upjsjqZR+
	B88dQyQKwKjDJLKph3oQM12PR9RjAdo+h7T11rymQ58n7qdbB1FiFzy/Ev+cLdJp
	QfrASeJOdo7ewSQv/OV09wNBCuqT8ZONJrITHsvXbC7+6fb69ya+ySrVqP0cRQA0
	9aZySJsE6SHigiCFYAgBp6wahlSRFB5S9mTAtBPYRGNIae26Ee1Vq7j5h5+SWUXp
	UlPhF1Wpzwv0NeQcT+krXg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fww0stcgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 12:27:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67ACPaCI021820;
	Mon, 10 Aug 2026 12:27:20 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwq5vn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Aug 2026 12:27:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFTU7d7jN6RYxvCCMPalKTAqjy+X9piFcdj5AvJ8oqmqGLtZsO0LjhWdxDzJk/tSc0BkbjQwSvcl6jZyXeWhd/6nLTibCmg4gIoibuaVDClwG78Vgg2XmYmZ9z/JxNremHlhw4+Da92CEbS/uaHIg3DmEBTsA/cwb8Vhj/0LQ1H/JXs5PFmmNx+5iACeRDYckl4KXdnWjHcH8KdqS+cPk/S5qaF2IjP5IBmn5IblUOUoxmjV1iedDAIwxjJ56Xnxflljq1dp7JedFBmpOFDxptWAycWyUdSqfhZl51u2YoB3o172ujAucLKgpmo3YoQLjLuHkbJY3YHLMzReYfi/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbb7FtTuy7BhJ4844XpD3gJv3VccS/ZFRYfjMRRllow=;
 b=fCAxdKjgm7eFygW9F08CTZRrUDPzvhESPTCVS33L6OA7Ifi3zbB3pSl4jhcKYZUNG1tGCO0MFukZYpVxKOtEj73P1Eyp1aCiSWEjIcFyXnuiI35Z/fYHb8dQSsBVMMTCa4ijiaimAlYarJhyb8LWHzmtNPd1TpXBfwKP6DPJie2VnGNRboIbHdl0dI64Wg7u/N6MXTLkB4xcKd1eZ+dOz0RTP7iVik0LyVoCWQ7JXpiVZwz8vYanwl8s5C+N1sDONQE8FfTKD1bwhXAsHYTLDHbu3vOcfE97rsJcxa3gm2EG49OfH0mMmnvSTiY+ugHSZ0PSoateXa5S63QQsMRUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbb7FtTuy7BhJ4844XpD3gJv3VccS/ZFRYfjMRRllow=;
 b=dK+aePZIx7UU13aRFmFHl/gcT1vu5O8jBatAgNesAN7LRiHcldd5DLXNMoq7q7ZoHJ/TE8XvQePW9L6XX1+uAeMEQFowJmHh5XSc8JOFfQhRKEWvI7CtlBWjmP34+KddKI7hkOmhhv9oAnNF7vomPbo/gkufSzBuJ5evJx0N3XA=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SJ1PR10MB5907.namprd10.prod.outlook.com (2603:10b6:a03:48a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:27:14 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 12:27:14 +0000
Message-ID: <6f1d8104-c79c-431a-b04a-5b93b9628c40@oracle.com>
Date: Mon, 10 Aug 2026 13:27:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 0/2] libbpf: Improve BPF load performance by
 selectively loading kmod BTFs
To: Fuyu Zhao <zhaofuyu@vivo.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
References: <20260806042042.3239428-1-zhaofuyu@vivo.com>
 <CAEf4BzZbsH2kyq9wb=eCNEOioWJnO2jSwsvbL3uWeyL51OnzVw@mail.gmail.com>
 <40e6c11b-5868-4463-9067-374c96775553@vivo.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <40e6c11b-5868-4463-9067-374c96775553@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DO3P289CA0027.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1e::9) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SJ1PR10MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b50dc2-a7e7-48fc-b29f-08def6dab4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+9ZRG7BQrTG27PYOLT4//BUmZQnL4Cc44SsQ/hTVUDllnQ6IJ0Dht8hMj3nfpJgysSn3XMhP+YSVTiPL3Q/KRJ1cHatocaSdgfFF7aCaMqdWASiuiCw6HWNeuwdKGgeEiBbx9Sn+f5B7wwV9MT4mluHY5pLvbFK96RHUL7WL7OfFfbhswBgEAPn842Wj4py1FiQ+yXRlDrke0eA0pVqbV6qNuUhsG0Kz2/ZO0TlrjSqhBBZSeZflqU2pLyr20s7mI3RzGpHzIpgpV4fLNW3hHdkV1Px5Mnzmzapw83w+oZ21esCLlktyCe/rZiGzZ5nmNIXlCnExGbO9HsssRMA6nb2sRJ+jOZ4wDhA0sMqSfvanTXuER7M22+knsnuE0lmjhovLsXO+7NNvqz8VggIt3AHug/pr1xnE3bEbaP148gqVrZCP+qykQ2mBIm3AHkcKf/FydnMoeNF8Snprk326DIEg+G2BvTtBduYW84JBMm/WJRYvW4vTYWJMQvtqfDxdlCleJmBR85HIvs2qVRYHDbhDadv1zD/2OuUFA/TwV+UZ4OI0dTxbysPBZK/xVi+7E/9xO0oEJMlx3imlwpikX6JKwAbz4c9x6+l30jiI9PWPXsX53oQXM2Lc6LPs5GRxgQGjhai657aOghOYWdIXd0JOqk3RA5RS/qkjiBCIZM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzBGeE9uaTNjSzZSQnZBNmp6SmVpWC9YR244Y0Q5ZHp6T0RyNGdENE4vSVkv?=
 =?utf-8?B?T1ZyRVpaSm9NUVFzVy9wZzczQTZJR1FnS1lwcS91d0FGdlNIUzdPSmRuOGZa?=
 =?utf-8?B?M0dZdFk0dFl0QU1CMU16NDg0VjBxd3hIQzlvR2tJM1BRTjg0UTc5R1dDakY5?=
 =?utf-8?B?T0tFdUcxYkM2T0hiQUFNK3pxMnNSKzVsUzNRRVpJd2RWbFoyaWJEdk5iczVQ?=
 =?utf-8?B?aU5zbmcrOWJuMXF1cW1VNXRFb0RzTW5tazVTdVh6K21jcEdxODhBdkZjWVRD?=
 =?utf-8?B?QmJQL0didjA2NzhraHVUNHFlbG1UM0gxRlhVVFl3RGxVdzdhY3hCNmpkVjls?=
 =?utf-8?B?NFZHWngxOHFYNUpNNytXQkc5THlSSnBTbGQycWxrWm1BaEZvMGp3V25nL2NS?=
 =?utf-8?B?TDdjbUlKMWRXUVNpNmtwOExhZk5FQ0dmbU91cXROYlptUEI0NjcrR2hGckdR?=
 =?utf-8?B?RElsd201bXRKamhtRm8va3p3WHlYRjdqZE9VZi93ZU4rMnRpS1Zuc1hyenBL?=
 =?utf-8?B?NFdpUGdrYnpxSmpPamQ2TFJ4K0ZwdlR0ZnA1eHhLSU1CMVZyRlhxNGE5NVFQ?=
 =?utf-8?B?YTM3UmdsSGtRWlJwcy91RklDQm5RVWorbWQwRmIzTlhnOWszWGhsRWo4TEZq?=
 =?utf-8?B?ejRkM0g0ajMzS2RJei85VlRWWllaVWNIYXNZdU13TDJQWEE0VXlXWnhVQ0RU?=
 =?utf-8?B?bElBcERqU3BNV0wvZ3BMaVJoc1lqSlFsSkQ2aG5BK1pIWHdEZC90U0RsL0Na?=
 =?utf-8?B?ZGhtbndwQk5NZm96Nmh2SVA4NXZVUEhDZWRZVnpWdnFJbm9vLytrUnNWSEQ3?=
 =?utf-8?B?WnpObWpoRStPaTM0dFNtUlBiOG5QNmYxeE5JTHJFSVk3ZnFRbHoyL29RbEI3?=
 =?utf-8?B?OXVMZ0hKUVBWbEZYZWNCUkJsMG1zU1cvRWEydllRSjMwb0lSQlJ5TWljVVNJ?=
 =?utf-8?B?eFpQT3h0N0hpb3VoUG5FSGZ4YjhLR1NDamE2YU9UT1pydXoxdlBJSFRPRGhW?=
 =?utf-8?B?VmF4THN1YnIxZFZiK3U3aTFSYmJPWFNSb2k5WXA4YnFQS3pjdVpNYlFiUHgw?=
 =?utf-8?B?SjJzdlNCbzQxcHFkKzl2cGk5ckNZNnNXeW5qY3BVdDFlTUVUakpnTFBnVWhn?=
 =?utf-8?B?U0lTOUhVdWVqZ3J5YWMrZlVHZ3FWNy9uclBRTUpUOE9MVFFuSk81QVIvRkN6?=
 =?utf-8?B?V2JRWFoxTm1iclpicUxJSU5BbDRPaFduRjRscDNOOUs0dHNpVWx5UUpjVFlI?=
 =?utf-8?B?V3NySUtSVGMwdmN1ZUdpTTNVL05YNHBVTUIxWXZJN2svT2J0UjRBQzMrQVdo?=
 =?utf-8?B?MkgyWEZzcjNqUlVhSm5xTTdnVjBPUk5IaHBSTDZTL2s0ckVaMVhWUitYbERV?=
 =?utf-8?B?dTAxRmZYNEx3Y3ZTOWRKZjc0citSeE1kZlZiTTRjVUcrZ05YT3JhSENuM2ti?=
 =?utf-8?B?TW9OTVBOSE5WVXNiSzZ1RHl4UFJwM0RHckd4eUlGRlRNTFk5aTJWSkpnSzNp?=
 =?utf-8?B?UDlyaHgvcGZoVmNPYWVwNWk5TXpGL08vUUNtRGdSc3VydUhGbmlWdzJJb3dB?=
 =?utf-8?B?V3lBd0l3Znl0bjVVMy9xNVJPVUVQSXlLVlE1WGNrVmpCUkM1cmViU0VrYkRh?=
 =?utf-8?B?cWNrYTBhV0dIbHZaTUNhbHJrS1BLWHNPNzRrNEdpQmtlcWwzWG9lZFBSRW9h?=
 =?utf-8?B?R0lpYVd6aXVMVWFRTkpxUkEvamwweU5lRFFrejMvbVhvOHRJTVdyekZWaDNQ?=
 =?utf-8?B?K3NkMERRekpLeWl2T2R3MlJ1NE1Mc3lhcVk1UjlXQVhpNnJkbU9TWkpHRDVB?=
 =?utf-8?B?WjhkVzREeUtwZTVsYUlEYzVLL21hVjIwL3IvZ0dzOU9OTW15Q2FIVStJc2Zy?=
 =?utf-8?B?MkVhdnp2MzFNZlJpM2o4ZDk5cDJxWGJXVlFnL21mcDRIVzFmQkVLY1d5TmNZ?=
 =?utf-8?B?eWkvMmptcWkzcFdrbWJEcWZCRFJCYThydDVibHViamx0MWMzNFNJM3FEYnM0?=
 =?utf-8?B?bkhYWmpONUQraHRtanRkRUJUTTlTR0VwRFlQcjkyczFEZXB2SGRLK1F5L2Iz?=
 =?utf-8?B?OURBcEdxbU00WVc3MWlTN0ljd1Y3bmxBaFhGN1pPMEV1eW5aN0pFQ1NRcHRp?=
 =?utf-8?B?WXNuNktBVmVtd2I2cUZFYVlueEhWTk1QQkxLSjZ1WWRWZzNUM2lhSE50WDBH?=
 =?utf-8?B?UVJOSll0VFgxRE9tR09FbUpBMjZ5K2N3UW1MTU1UTENUMnpaaVFvZEM1MmF6?=
 =?utf-8?B?QTJoRWJRTkxlM2F0V252NGJYc0krUWJPUUxzNlUvYnVUeCs3c0ZZeXdOempJ?=
 =?utf-8?B?amlHMTNselJNZ1AzSk90YjBHc2dlWjg5M3NDSDZGWEViQW8rR1Z6dz09?=
X-Exchange-RoutingPolicyChecked:
	H374U7ZXbrE+l/0/O/Xh324LV6VzCEmwIPBG8RGvfwFEFPcmRduoHgwOjngb0uQsFzDWeMQaXYSV/M/3nER5UZ3/evDpfyrTl0PXDpOkFd+hKG3wFOnazGMDOQP52genI2jWemuUsDFCCibJDAQHvZohyy8rCVgLh+Fnb2k6/qZu1+m47xVWjTzrP9YQCf296TiloQC/rSu7jMQL/Gb8JSQFjv5bl9O6DmkDh4df6XXhZT5gEa9nBA1F/4dJu7+UxFHC6CDl57bhjg2TG0pBrrrpLvD/9hYQ3XLE0IGw4THS19p89CQRLZLdxkn9t1PCnM4YalB16KW/6thTLKUU+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5VE0Np7f1MzeFqRo7yJIx/VOKORwWOfUVHGfMbrHJfgrX/mRAEk0bvWt/8T66tjYDcIQpf1RVE/0oj7HrAXX49eRlTdJxHRjeD7xkkTuGhOvLvZPoQtAHDgv25CQ5O5/WkEKNS6fZDjexYKmFIeRL5Cg94uqoOyV3bkegS/zoIHK41RkC1J08vPOSfQ+sLlS6Jk10Rj8uRU7n0co4DS/fONVWpggHPYmHYBvl/K8Zzw5tWAJzrcM1pvoW3kAurJrUrU4y7CIHzfDtEUDej1luIXHL9dYiGrOvoCQEvfR1UMHYWwlKx4DYA4RvBmlGEJ3aVWa1nq9SVmYeI4WQpwDWcRvM7x1N1OeBhDF7sQlOflBHcwspT2RTAB6GIVfXC+aHrfa0foOSgwGnf3vq/0Uh/X5hZC7KtOElJg6FS0aMQySV0fYXfIlB+cj1mRkP82/Lzcqm/DtPmi13wm+4FreGQkOJKAtw8CfNWYM+Ru7flOzNl2/n3a19QQ4Hhdh0uRcJWvN1rWlOs8ALjWl8VAzLIY8CwtpJyMFKXpcVeOfnasUhB+2tR9tyF2mpIS2S2X5AO9wF0HiT9AQ00IUGj+qRjMgIZ4w9szxuAcZf7LUT0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b50dc2-a7e7-48fc-b29f-08def6dab4f4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:27:14.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sobEO8w3iftnQNW1cSqv22tsF3hk6gHIKHuCqKJZvccHWIAGBDoDyVtqInKuz1r5iGkFRWAwo5HdNLOOEI8fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608100106
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwNyBTYWx0ZWRfX7HAD9s45ZUze
 KYPeEi9377Hw4H97sHlSlJOH/yyHnJFbiUXPs+Si8jVaqEon1nBHq3jY3trjUHAd/4i/qJO+kme
 fzNUqYThGVWokJStLyV/C7BkBlrrlNozdQP2GO3aBZsw+wZ+8nHG
X-Proofpoint-ORIG-GUID: HBcVuenznyDN_-kn_CojlIOh_Wn5BaWk
X-Proofpoint-GUID: HBcVuenznyDN_-kn_CojlIOh_Wn5BaWk
X-Authority-Analysis: v=2.4 cv=FcAHAp+6 c=1 sm=1 tr=0 ts=6a79c3a9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=1WtWmnkvAAAA:8
 a=NTGMwuTq61LgyPNUM1kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13510
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwNyBTYWx0ZWRfX1wQvPRPVEzVF
 GAJPTtMVitRczPN31/Tj85yet6ZxjplO2fDbbrgqkCnoSKCnBJ2PSvmoZGPoiQTsD0AKC+4JIIF
 +/564hsZNmkfwHnNImwOZBLTobwdKMW6Hrm5OWL8EbGWPi+qRztKkdHF3S8E7vPGTnZyEuPdqUD
 NnYYamVGOGNzgK0dMu90YuQ+sA9ISEq8EGlBiwe7CZ2Owz5UaC0+uJ6X7fPIZveAMbIongM4JbF
 hlS9La83mD4V32xST9oYtHq+Th2HQWzRF5uylSTS3znRG6Hv2lFQ6Cj9Pgwm67vVzfpm+OKnJHB
 KoWl10PT56CrnBc5953ZB1GH1DCDI2oXiW3mEru70E1CV0K5JIsRsSMJA0U/2Ol7oSlr4AARHcU
 Rmk1sNsBkths2gP7GLvq8XvyiSCUAWNCb3/w3q4ZJU/8ZkVeNUoGYP1WpJ/kV57al5+1OxoYHdb
 Q8N8ZUW38iGaVp8sosPMGg7SIBL/0C6s3oa8WvaM=

On 10/08/2026 07:20, Fuyu Zhao wrote:
> 
> 
> On 8/8/2026 6:18 AM, Andrii Nakryiko wrote:
>> On Wed, Aug 5, 2026 at 9:21 PM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>>
>>> Currently, during BPF object loading, load_module_btfs() unconditionally
>>> iterates over all loaded kernel modules and loads their BTFs. This
>>> introduces unnecessary overhead when a BPF program only needs a specific,
>>> small subset of modules. In environments with hundreds of modules,
>>> loading all module measurably increases the loading time.
>>>
>>> This series introduces a ".kmod_btfs" ELF section, allowing BPF programs
>>> to declare the modules that need BTF loading. libbpf parses this
>>> section, collects the module names, and skips loading BTFs for any
>>> module not in the list, thereby reducing overhead. It also stops the
>>> iteration early once all declared modules are found.
>>>
>>> Usage example:
>>>
>>>   DEFINE_KMOD_BTFS(_needed_kmods) = { "bpf_testmod" };
>>>
>>> Performance impact (<skel>__open_and_load() time):
>>>
>>>   Modules loaded | Without .kmod_btfs | With .kmod_btfs | Speedup
>>>   ---------------|--------------------|-----------------|--------
>>>   1              | 35.0 ms            | 35.0 ms         | Baseline
>>>   10             | 36.5 ms            | 35.1 ms         | +3.8%
>>>   100            | 46.2 ms            | 35.9 ms         | +22.3%
>>>   300            | 65.2 ms            | 38.0 ms         | +41.7%
>>
>> First, is 30ms start up overhead really such a big deal when it comes
>> to one-time thing that sets up a bunch of BPF programs? Can you
>> elaborate on the use case you have that actually is harmed by this
>> libbpf behavior?
>>
> 
> Hi Andrii,
> 
> Thanks for the feedback, and sorry for the delayed response.
> 
> To clarify the use case, we use `sched_ext` on Android mobile platforms
> and dynamically switch schedulers for performance-sensitive scenarios,
> such as gaming workloads. The BPF programs are loaded on demand when a
> scheduler switch is required, rather than being initialized once during
> system startup. Since the scheduler switch happens on the critical path
> of user interaction, the setup latency directly affects the perceived
> responsiveness of the system.
> 
> On Android devices, the impact of `load_module_btfs()` is even more
> pronounced in our use case. In our testing, loading BTFs for all modules
> takes more than 300 ms (with 93 module BTFs), which accounts for around
> 69% of the total BPF loading time. Such a delay during the scheduler
> transition can cause visible frame drops in latency-sensitive workloads.
> 
> We also tried preloading the BPF programs. However, this does not fit
> well with our use case. Mobile devices have tighter memory constraints,
> and we avoid keeping unused BPF programs resident when they are not
> needed. Since different workloads may require different schedulers,
> preloading all possible BPF programs would introduce unnecessary memory
> overhead.
> 
> By allowing a BPF program to explicitly declare the required kernel
> modules through `.kmod_btfs`, libbpf can avoid loading unrelated module
> BTFs and significantly reduce the loading latency without increasing the
> memory footprint of inactive features.
>

the approach of having an extra section .kmod_btfs feels a bit unwieldy;
we already support kernel/module qualification in autoload section names
via

SEC("fentry/mymod:foo")
SEC("fexit/vmlinux:bar")

Couldn't you use that instead to inform selective lookup in find_kernel_btf_id()?

 
> Hope this clarifies the motivation behind this change. Thanks again for
> the feedback.
> 
> Best regards,
> Fuyu
> 
>>>
>>> Fuyu Zhao (2):
>>>   libbpf: support selective kernel module BTF loading via .kmod_btfs
>>>     section
>>>   selftests/bpf: add tests for selective kmod BTF loading
>>>
>>>  tools/lib/bpf/bpf_helpers.h                   |  14 +++
>>>  tools/lib/bpf/libbpf.c                        | 112 ++++++++++++++++++
>>>  .../selftests/bpf/prog_tests/kmod_btfs.c      |  47 ++++++++
>>>  tools/testing/selftests/bpf/progs/kmod_btfs.c |  14 +++
>>>  .../selftests/bpf/progs/kmod_btfs_mix.c       |  15 +++
>>>  .../selftests/bpf/progs/kmod_btfs_nonexist.c  |  17 +++
>>>  6 files changed, 219 insertions(+)
>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>>>  create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs.c
>>>  create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
>>>  create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c
>>>
>>> --
>>> 2.34.1
>>>
>>>
> 
> 

