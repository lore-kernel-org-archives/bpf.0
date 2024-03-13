Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6224224E0
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322627; cv=fail; b=bxps3/56mAAFRaI/F5Y9myD6hQkNuMqxRAXkrCegxg8qmdoK6XtHq7725g9K+RPWqfo6RxiAs7a9oagFRZDZiOe9T3gX7qq2lYY+uxhcqO8HXar+sEKMVhNObqoev3huzUPsFozXnlcbflY17fuDt+X/4rCdEk7HwXi5MhJJ5hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322627; c=relaxed/simple;
	bh=G1SSOBgCBwk1DMbpZaDeYAbX5ucwKbQfUxbsQ1lz1LE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=duIt4ci8uG1Xt9gsP+WtPe9z6VoilVdccvjqwFE1IdYrVR4IkDwcI7nSUC+43jUq2VsRJwBhs1e/PPhIw0EqXSU3uhhx2YXoBxFne38y1FggfhpA2xmRyx8pB5CrH82slyYJYGXLJHOL+QUIyqEL2PcwQ70NNQA5pDRjnoUD138=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FkVv1Pw3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UVgOMPmd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FkVv1Pw3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UVgOMPmd"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42D8iFSg011272;
	Wed, 13 Mar 2024 09:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zI/a6LH8v8sRyuvxcJDfOZtxv0GoEeUWnqIQAP/BAI0=;
 b=FkVv1Pw3ATYt+NDlDFfyL8TN3hGM+G+aNQpJDq02VNoMfpsWNkxPxdbM5NKb8QfScGNk
 zwPDL6hx8LsV5wPRf4HHqQ3e6JWP9txBIin0rLSU9UH1cb4i24VADDy08rH/UO8Doqt+
 nXmudlq1LLgHqBAUrsVnNZUjLJqvqhiUmaMM7N2J6X/Ba3CPWlrpSR6pYVQfuZ+E47CY
 1upWuYTpojjsLa3N6PhD9FPkxkDm5c8tqLEAKtFkJzJZeEgiR1a9PfuANVbtFcHH1LOq
 3SnAhriCBfdbOQpNPjLxAaLfrU48carSDICRTmHaV3bsgGlc9rJw0f/Jv5ntSnkpX2NG rw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrec2gd53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 09:36:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42D9FFHu028739;
	Wed, 13 Mar 2024 09:36:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre78hqrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 09:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij7j8OA3eDdk6Le5Jw9Rc80qSRQcAPq4zuXQr0KT3dYvQ2m9/hc5GUaW6I2wepkEdQgyEXeKKsC7L9mCX8XKdLxki3hSBX7H03eJpkpnarWswA15qjQ2hnQNaZwMjByQ2eBd79sMdQ+96MPVuzNlj/0euKywteEewdpZdF/euxLWcUSaSlA5HhfYR3dzGKWC2QFkba0NTB6JdPZRCbUzEWYS5cm1rE891PZGPw4j9cxtnEf3pkj11uVo0uWvmyYxzsiAnmO3OktzQHBsAd8kDwiTG6fSp0gtyHtKcOzMF+6y1XsuCLTlq2iRk/Cmeq5NwcoNKwT8ImwNwHybbJIhew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zI/a6LH8v8sRyuvxcJDfOZtxv0GoEeUWnqIQAP/BAI0=;
 b=XJTENucAEm2opllqKkpSO++ZtNd5O4zUca4HP2SioEvjsrVVWJCdZrE56r+Jc27qSUBWu+t/bnybwv10UN7ESrHQPST/gTBOgb3Jfk+4dIlWIzOF2lzjJ/ivurfM3H0+g34qiOiEtVImwq6sdttUvo2rL2FtrDSzQjOAGKscqqZJu6TjpRaJXBPtPR4zuA8gEFjGpAfteKSKIuvm/sYIcbjaMKFjxSvXdg6U1jmh77nZuvVK55Sdw05NDCvojFivhK0HNSxmPTJuJgIdOmgUpvyoNi9U4uqIxun08u1hbnXxFvHOa8bfUtGmqkYqmvERowYRaAWnFVJhKU5Daq3jxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI/a6LH8v8sRyuvxcJDfOZtxv0GoEeUWnqIQAP/BAI0=;
 b=UVgOMPmdK4NKI7rAUCqx64Jo4Y1P4KM9thqNTVSXdVsbP9vN5M+8QcoLf6wuS5ZZRUY4yQqfp7+kJpugenF9RgIlLFIJqD3qvtFLIwF6knKfsyZGFYSXjOJoiWLKqUfIGm/mkcaCAT/s83weF898iW8V7DSxtckTqbqXyYJAtg8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4412.namprd10.prod.outlook.com (2603:10b6:806:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.39; Wed, 13 Mar
 2024 09:36:44 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 09:36:44 +0000
Message-ID: <f9ab9ab3-c3cb-4a63-bc4e-102b9f6925a9@oracle.com>
Date: Wed, 13 Mar 2024 09:36:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 2/2] pahole: Inject kfunc decl tags into BTF
Content-Language: en-GB
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: acme@kernel.org, jolsa@kernel.org, quentin@isovalent.com,
        andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org
References: <cover.1707071969.git.dxu@dxuuu.xyz>
 <28e81ccf28d6dd33f6db50af6526dc1770502b8d.1707071969.git.dxu@dxuuu.xyz>
 <8e0580c6-bc72-4644-a010-c73d779f385c@oracle.com>
 <s3fcrvcbxjn47nw3nhcus4hmyx3zkxz26vz4ddm2fxoskacf4s@tfd2rx7n33vc>
 <tqkiee5rc3szutsobuuttgpv4ejjhnjbcfhkdozkrvxcjrp6zf@2mvkkhhbn7vj>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <tqkiee5rc3szutsobuuttgpv4ejjhnjbcfhkdozkrvxcjrp6zf@2mvkkhhbn7vj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0281.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: f39963fb-6852-499f-e32e-08dc4341182c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	L1TltqQpg9vL7+8p7Rz+UXHDQv9ulvzez1EQU991aUQYsu7CROw0+vVO8qtxQoQ/IQmpAubj8ff908DWW0Q0B2To2qi+OkKFw/NngRLh3nGHDWgsb+rHb/I0+D++uuADNdDJ8ttw0+Ua6xvsL8xjc33FOcFnJPi16OkTYIGOKdYC+wRIMZLHGBsuhTXj+ImIQOjGERn/3SYoNxatiakJfkgB2zHOp/rGoJEyQ31rm/949bLY25cDAIrcswModXwvlloKAn/a0ySMc2kAHqGSSOcUx2iFZvPO1VK+eMAjf6SifUQDh3xAbejTBxpX1qwup1v68elBpCe6ke8yNyJeSiw3lv4fvOKeItLr3pdpSE00tekxw46EwI+aKd+FQ7/qpuPW56aUM/4YR5GV3d87zSVTW31knOOF8syyaeadOKoQ/Cc1c/YpTusLVJ8CISpvimLmnvRJxx+Q/jP6grXoFmhUmbgQJFJXtXStEwm0NkmVtlcyb2N6hyd8M3wSavvmm7LzyUiCEoT0SXzQCcg9y9AE15QBGnJY0S7MR6wS5LH4jn8/gnuUcQbaHTFAOm9DFu4J3BmiWwasSLR9b6t/AhQ6/KvAe9Gz2IFJX/H9uqI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZDBrd09XajFUWFRCMUQrM0VYUzY0SzBTL3dIUm1CeE4yZFkzSVo5WVVGV0FY?=
 =?utf-8?B?UnhnTllMODFHc2IwamFrUjgvWkx3NVF5QXEzRUhPSmJmYWJqbE92RTc4NGFv?=
 =?utf-8?B?ampmMFNaMmxyd3l0MDExSHdiLzZzNFhRK1pwUk5DWld6ZVdJdjRFbENpUUV3?=
 =?utf-8?B?RjVnOHJhRDVKTnRuY0lBRUJJN3J5RFdqelZNTE9HeGluTVAwS01SMkE5bXVZ?=
 =?utf-8?B?emErTVpnalpaZm1sUmVYcDNOcHhjR0twQkhQTjFqcWh2UElMdUVGemNoOWtj?=
 =?utf-8?B?SU9ZaVh1YkY2L2lzMjliZHRLZFhxdGQzRGtDYU8wZ0VwczIzdStYQmNvUGp4?=
 =?utf-8?B?TkxubkdIK1hXcmx3SWptUUl4TGZSMWtLRVhwQ0ZhSUJMZWkzeWVySW9OOXFI?=
 =?utf-8?B?eVpqOHV3R2JEYjNKWXh1R0F5ZlVVRWxackVyY3NiOVhNY2FiWEY1RFdrN293?=
 =?utf-8?B?b1NEYk9VNzZMWlVMdG1iNTJIdGlIenFIYmVVRlZEaUZhMmRML3ZoUDdIdEFo?=
 =?utf-8?B?cUpDRldrNk5ISWsrQXo5anBJQkVWTFVsM2h2ZXBxc2pKV0xoV0taZG5sVmtK?=
 =?utf-8?B?Uk93VUpSUTlaazU5bnUxODNOam1PTlRjTEJnR1JGTm1GZXRzRytmWHVPeHNt?=
 =?utf-8?B?SEFtZmVsbVlKbzM2RnlMWUVuWnY2dStJcU1YSUVZVXAzNENsaDBiQlpacUtF?=
 =?utf-8?B?SWpwWklJdWtFcVdLKzNwbTJyd2V3RzU3OUdFeFczYWpPZW9DWUQvTXFaL2FD?=
 =?utf-8?B?Z2ZCNHBacTNOVjA3bjdEYXAreDJQSGlhVnFIazNiQUtjY0llOWRJL0pMWDVO?=
 =?utf-8?B?Qk8yNXlxdVlNVmJCUU9NODh3eGwxdnN3bHRlbnNVZ2VETDFwYk9OZHo5S2tK?=
 =?utf-8?B?T0IvWXVzREl0TW1lWTh5dmdxUlRVNklYbmw3WUJNUk9tTzVqV2xGem4zdnRt?=
 =?utf-8?B?ajdzKzZubit0MDhyRkpJcmFVdTRjV1RpQ0ZBNllOSlpXUDVTSUMwUyt3UUsw?=
 =?utf-8?B?QzlKSkVTTnFwOCticnVOY0kxNzQ1QWwwNDdlZ1FZaDJqRnB6Z2w2RU1XSlNI?=
 =?utf-8?B?b0hoUS83YXlkUG1ubXhESFRhOE9XZmhSclI4OTFiRWpRN3UzQURZMCtZdFVW?=
 =?utf-8?B?d2M3ZHRXSEZxMlpqZ1NWU2sxY0tOSXEvZlBVbnN0K1Uydkhsb0hJc1A0a01v?=
 =?utf-8?B?emhxaU9ObGVuY3NlY0Q1Tk9yNTF5MUlwUzRLa1MvcGlXQ0l1WElKOHdJcDBn?=
 =?utf-8?B?YUNwUUNZQ2F1VVJwVy9FL0UwVUNyOWhUYThSOWxHbnlxSERLWSthcmZ4OTFE?=
 =?utf-8?B?UWttSmt3b2Jna0xhZXlDSXVHbS9vZG4yRDVVczdRRW9Oc3BkdWwvVEx4M0ZB?=
 =?utf-8?B?SU9MWG03UThZdUM1cmNpN2Z5eXdhOHYyUy9tZ3dmbU5mL3MvNVE3Q1dCTW13?=
 =?utf-8?B?QjZSUTRHckRSM3U0Y3plN1RoSkJ6ZFRLbVdUMzhXUmtibUxEb21lNjlaM1Bu?=
 =?utf-8?B?TGQ2cXFnbEZCYnRBWVRsQk5SV1hLN1c0SzZMaFpxb2FZVllWSUlBTFdydTJY?=
 =?utf-8?B?T1ZINS85eGR0YjcvS0NhY2hsTWtxVlIrWjJmYmRtTUpNU2x6Y3BWMTd6REJX?=
 =?utf-8?B?QzlrVlFjYkNrdzhJbzNscldkSUZxWE5QT29YTkE1RzZXajVuc3EyOTZjSGRH?=
 =?utf-8?B?ZHdVYUdOVHIvOFpzR3M5S2VmMnY5V0lBRE1pZHpQVUVEV3NFU202TVhyWWh0?=
 =?utf-8?B?L05qZytQajNWd2Q3SnIzR091L1lsQnVUcGhwN3dNTzA1OW1uVHltTU12SGNH?=
 =?utf-8?B?ZndKdW0xZzFRbGFETUFyNlVGVUhvdURJQ1VTT0FPZzdxOHd1S3JPd0h0Q29N?=
 =?utf-8?B?RFBwcStKd0x1aTlLSUNydlR2aWZ5dWFXcTJUNEZscUt6ODBnMVoyRHFGN1F5?=
 =?utf-8?B?azJBYUkyajhUTnMwSTFlUm1uVmlyZUdKRjlJN01sUGswV1h3WkZDZ0R3aXZ4?=
 =?utf-8?B?NkhZWEVmdTlyUDlDYXNURzYyVGNFWVh5UjFYcVQxTXZ1anhKTzlFcXpTSC9r?=
 =?utf-8?B?dGloNzVvdS9wZGNrK01MRjJsMlZPTVNKdzhSQTFLWHBScDBOT0dRUEd6ZlhR?=
 =?utf-8?B?VWF6NEFYYVFIRzQ3ZXF3MVRVREZOQXA1WFpwdEQ3ME9wdWdTUGVZTHE3SW0x?=
 =?utf-8?Q?M//YZAzcsDalZF6RryRYmmE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yRSh8axrg0a/vtrvuC9M/D35iqv5iFRm9wYO7AgkPMqes87BWU9WxH6UHz+vFeafGPcrlhgtsaB4hbRURmSkc0eLNnWfOPCRfYcL29/P0m5Yc8Ig0t6CHAHz0OaMEhHWlL01R/IfeCSfyXpyV+4QBPUWa8WQnviJLJ5bsi+Chqa/3NfRTun4w4PawMzj50FvvUoA+qrKIOJfFe44ei3xw2LM3iVDkv3Osux/l4MHdY9zLAmBEltoLOlR3TpSGn0eHhi+fYhuVZsS85KGc8Y/Sg6M0NeaDd0JBkzk37W9DcuBoNeG0+R3ti1cl3ADscDV/xCMJWb86cTd4TlJlcXplu1vtWte1JC0Kva+AgwmmxpTDkTBhhMV4DA5jY6vlPyHZWGy0oU9Az+3EjQcCkuO41Uo39L+xxq+lCXfexNqP/Op715hDP3nBmopkPdpUoWOVvypz0lO4gP/1U1FA3di9ENNcav6c9leW7270J20D6OAG4I6fbGzmSETmw8UxM/bGt1l+QzbS7p9kGm37OGRVpwJ8VGMO015OfGAASobMz4WUU7yPsGL8D5+L8hTMnHopnHgp6Ka/EyBzMxJsVodfYast8JlpXRSfwtkAbG+YNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39963fb-6852-499f-e32e-08dc4341182c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:36:43.9954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w72s5+mZrpQdYmTucUTawKezWPuCnmg6BzlTgBTHCWtrPO7rUKk+aVWe7oaQ3+TLZu48BnDnD4r6BRH2OZlvMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130070
X-Proofpoint-ORIG-GUID: ptrvatiHBMRa2wmzxSP_kK26ZWVATDZO
X-Proofpoint-GUID: ptrvatiHBMRa2wmzxSP_kK26ZWVATDZO

On 13/03/2024 03:17, Daniel Xu wrote:
> Hi Alan,
> 
> On Wed, Feb 28, 2024 at 05:57:01PM -0700, Daniel Xu wrote:
>> Hi Alan,
>>
>> On Thu, Feb 08, 2024 at 10:00:15AM +0000, Alan Maguire wrote:
>>> On 04/02/2024 18:40, Daniel Xu wrote:
> 
> [...]
> 
>>>
>>> Then all you'd need to do is iterate over BTF functions, using
>>> btf_encoder__find_function() to get a function and associated ELF info
>>> by name.
>>
>> Didn't know about this, thanks. I'll take a look at if the patch can use
>> the existing function metadata. That should get rid of
>> btf_encoder__collect_btf_funcs() if it works.
> 
> I experimented with this a bit and I'm not sure if it's a good approach.
> 
> Here are the two commits:
> 
>         https://pastes.dxuuu.xyz/xo9jwk
>         https://pastes.dxuuu.xyz/xmzew5
> 
> Basically my approach was to fan-in all the function info collected by
> the different threads. I don't think it'll work cuz some of the data
> (the name in particular) in struct elf_function belongs to the thread's
> struct btf_encoder instance. Which is all freed by btf_encoder__delete()
> before btf_encoder__encode().
> 
> It could probably be fixed, but doesn't seem very clean to me. So I
> think it'll be better to keep the code as-is. Unless you were thinking
> something different.
> 

Thanks for trying! We may end up revisiting the freeing of ELF
function/variable info in the future if we add address information from
symbols into BTF, but since that's not there yet, it makes sense to do
your collection separately.

Alan
