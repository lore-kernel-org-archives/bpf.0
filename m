Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208E4DAF86;
	Fri,  9 Oct 2026 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554481; cv=fail; b=HRsNDRR6BPoVOGCS+1qxyYaSKm84EDkca/iZSPtJmkFlhEKwIeTJb0+MDhwOzSPM8oTVG2WK25+j4MCTFRoj2H8WVOQ8ODL2kSSD0w/HITMJ2qPvj7bI+Ltsh1Qi9Ivb1xiR/KUUySvbhxPlAh0ixfVP+gHF83tNFqu9wSURE3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554481; c=relaxed/simple;
	bh=vVmaIjXfIEHXo9JcGhA4LNCJF9XkfbugcxNEiKkRag8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QfLfbkNhp05Fj4VBzni7H7Go1VLv2sfiLvVY/kEiiF66h2TA6H9V+IoQjsYFhunQ6g8L7Z+stmHXQd/qYPJYrTMlWieJQYmShgE2yzninq6/r5eWO51ON62WbhJ5BWef9vNoW584yufkC33URklJnVnbuyRAzGxxQJzCq+fUrl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LR5WxDzn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FjtMP1zr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LR5WxDzn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FjtMP1zr"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699Du2Gw3159836;
	Fri, 9 Oct 2026 14:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O5393Nv5F96OIeGRoIbJIOEyBmw9sIkWqCr+FhSxzj8=; b=
	LR5WxDzn0Wq7AxvTM5/flEkzoFNn5TrQAOB8AuDAc9ymlKOgvCd2fT1scw9owbTJ
	9PbtaFrTcU72BAAw2RItq1356Xn8nxYonPRvrvNwDobv8UpSa9VFO28UGuYxSW2g
	Y4t35SHvjh2VxHO6YicBTaPRqc3sUloAnfj1yayXt3dKPyRMKqIyFSj9OPLAp8DI
	fyYp2lBSbGN8XKvlbmlYuEUWAIMqC5RK+z8YoStnfzsE9SGtRceDUB/zO4duG7++
	x51VlHx8Ask3Wn1i9noQv0oFM94OdrG5uAqBJsPIVZ9meZe5wp6hTooGy4LOFkh2
	IHR6R4QOyjzQc2QTH7+EOw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h5xeyb9ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 14:01:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 699DpApD037103;
	Fri, 9 Oct 2026 14:01:14 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h5xexesx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 09 Oct 2026 14:01:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gjg5maBckjjOUrOlS8GR2HbTQ5/ie4dQen0f3AG9hGWxN0JryOVrwSt2INGCBTmMVXAl/eN67hiBjFu7UUsEyXimiUMlFDW6FSsvovUvti6V+CLXN7/H801l8X44jvTIkXa8UTdMieENHnO0nbDcVr676oC++jqbihqVqu3pvsGkYWlHglmIpTIDHDjcSv735TKyHyrfAb1qtsYQlse97va7izrLt/7ET/LhDJeQ3sYxHGzd2UsMenmz8umQYlSTLqqlQd+mTZ5KP6XjMGVBy31XnnTe821wfCjaXh2ZQd8StRnEpyTD/62JVGJiGZ1ZwWTrBXFyaP0tGoFD1ekT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5393Nv5F96OIeGRoIbJIOEyBmw9sIkWqCr+FhSxzj8=;
 b=mb4mB0sBfya3mb1XIrYjPz3tdRiT3t2JKdlE2dN/aOXcSyaDZnf43i6SudPNt4CMDh8HAagb6SviQ3reK6zEZzTi6jQ7EWwXbYSwyhycuHrM5MR5DK9v4wgov9W5EEmXNhcU8+7nkS3kjzv3OazwtFzXG1aXRoC0/lGCOkSWYls/XC+4RdMjNzUweFA8W9Y8C3sHcVlS3maHP+d9+rVyTI2lHi0PI0dzzhA93rO+kJb7sTerIsEfonKuwI/iQjgBGwr9SETm4kM4O92aYLZWeCUMkRoeUWUYiKsbns8bXV4hnjEEeuWydBpJhAi1GkCZ6yJjAXTc2s3F+c6LbMDMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5393Nv5F96OIeGRoIbJIOEyBmw9sIkWqCr+FhSxzj8=;
 b=FjtMP1zrSkHgIGgu1z+bfUkh3MIn8OHimfr0JmxWwZQrqlXzfZnccc75qY+ey32X4xKKeonYaQfipu7IZ+lBZyenjb8fCf68iyo6/AJVNEaZPX4jiKDOPudp0QBHGjjgjy8TR1z7AtFMkg+WN/PsDLupzcpK/5gjmZj7TBSFfPE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by MW5PR10MB5873.namprd10.prod.outlook.com (2603:10b6:303:19b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 14:00:52 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0522.002; Fri, 9 Oct 2026
 14:00:49 +0000
Message-ID: <18c33c30-a9ee-4617-8828-c6896bf1c121@oracle.com>
Date: Fri, 9 Oct 2026 15:00:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 4/7] btf: Preserve string relocation maps for
 split BTF
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com>
 <20261009112324.1442319-5-alan.maguire@oracle.com>
 <sashiko-outbox-165464@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <sashiko-outbox-165464@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0347.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::15) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|MW5PR10MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 073d0465-b828-48e7-2751-08df260db8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|4143699003|6133799003|10063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5BaADQ7SYogacOptCRK4j5FJ7DVIswah/ssVpbTaKZ8VHzj8kraj2zXMVMVPVH/tiTjvYDGRoyWYjzqqpy/q3/pCMohBjrIvdUIHfwwhfrcyU+UvHZoBlv0ndnffVQkrS82bmH1Hb2O5yAg4e7WSuOJB+X3Z2p21vfh+9Qg3VDgzqr+0OAwbjqBaZXEwCIDU0kz8Zkp5jHlgoaW92tBcz65eZPqgmZVPdNAtBHdPmhU01pQ8Qh9mbLGZPB1yKPdyplzVXY/fws605qxa13ZLGqPNsZ1s5dgrstNAV+WubqUHlq6yvvkXTtnhlR6QTQ+Fr3pDfPA62OFZcjyzTB1t61sGYr5Kcb1ZBNLDTCXY4y3cMJB5+hcK/Lg9ba9luU9d/A5d3WvbA9hlf41VvLXQlVen34eUYmvDbhsmSu6dLiQwRLfiC9oM/hyykc7ZXk+9TQg27NvzcjS44o4k3hIw7S4RNS8sCofW63rJYEQQ8zfXoHSwYhXvhRYrvaK1ZgkU6u2/mbigG2AGpuM3ZJ7UNjFYzIEWJ8ya5lff/sasQbbTcjYRYUTQPfKEbpds7U+Ca2pFt8QbhAAFa1D4VCQTHUF/oU48SgNz5n+bKiBJ0Wetx3oOQBQ4LsHzbqYUHl4sSSwCzG9LFTUFb2wrfm1/JCLZBd9vLEB4/KX4HZFIqXY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(10063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlZmWGxIU202MHNwUXF2eEcwSjR2bm5kK0cxdjNwbXFEN3VCTm05Z0hyeWl5?=
 =?utf-8?B?ck0xVmNXNm1xSWdNNWgrNFhiWUhnYmd6VUxWdEFsU2srenBDY1JwTFJoeStB?=
 =?utf-8?B?MzZmb3dITEtCK21LWU5tK2k1Q0JHTkRSb1h4TnNxK1FqOVVXSmR4VHc3aFE2?=
 =?utf-8?B?cVRUMk1TeVNlUUcyZHVJMytBdnk1YkN2bjd6SUMxYVlzZWUzOGNta3VOQzRo?=
 =?utf-8?B?MVlabFVjdG80bDlML012aFUycTdOTXlQL2VMMDB5cWRsbUd4TGVhdHVxeEpM?=
 =?utf-8?B?MEE3MjhCYjAzTWFHZVRmTzZ0WEhBSVJSVEZHZjh4TzdzamZmQVphMzh2T3Rq?=
 =?utf-8?B?a3Y3VzBDRWRHbkEzQ3grSkdDK1JJTHA2SU5PeXAyaVV6ZHl2UUsvTnhGa05Z?=
 =?utf-8?B?SHJ0Y2l6OGpXU01hMHhSd1JxWkxGK0QxWHZjM1Fwbzkvd1ZBKzJoNG0yMkJY?=
 =?utf-8?B?aWM5N0ovbit6V0RXeTE2OTVNVVNwT3NUZ2NnYzVHOElYWHFnYXo0Z1BQNjdM?=
 =?utf-8?B?OWI2RlZQOThlcXRPSnlESjgwUkYyYlJrcmJjUnNuQVZQd1grMU9VNythQUdR?=
 =?utf-8?B?eGQ5OFNNS1RTdVErR3F5L2hnWnRRcXpBeDA2WjVjc29sbmt0QmtSdk8ycGJD?=
 =?utf-8?B?V1dNK0ZSRXRqVlc3VlA5MFRjNnZPb0VmcTVsZFkySmU1a1ByMTlhaVhZbFRP?=
 =?utf-8?B?Sk1yN3NtMUxrM0xPVU9iZnRkSEw0VG1QazhGTks4MzJYcTJUUksremxpODJJ?=
 =?utf-8?B?dkpSTSsyNnNmSmE2Wnh2YlhCMjA4Nk4wTDN0VHdEVUJkV3VubWtia0thbWZC?=
 =?utf-8?B?UkpidGRXUFZNRWpPc0tlNTRyd3p2ZUwvdVpoZ3BrbnVhYkkwL3JQQVd6NW9Y?=
 =?utf-8?B?SmhjdUNaNklxMlFvSUlJd3R0eWVWTlVEYUswZmF0TFRuZHYvM25SNDdrNnVU?=
 =?utf-8?B?bXJsWStlUzlCWTF3dXRtQUlIWkwwRDI1dnZ1UGhoVEppL0pKWlYwUFBBQlZj?=
 =?utf-8?B?N0VjNi9IT3BpSHVyWnptU1RTdFpydGc4MWpvc1VLMnllYVAwVUM5bTh6RVFV?=
 =?utf-8?B?QnpvaUxQWWxHck9zbk1yK0xnMkZiQVBtVkthS3FLZ0p5QXVUblUvL3JEMlNT?=
 =?utf-8?B?OWtmM0hSODc5Ylhzc3A5MHRiTUFkbUlpUThxY042V1Z4blFvREl3U2Fidm1i?=
 =?utf-8?B?SXhUYTR2dWxYWGJXRFl5aFBvNkJzN3JhZDVReWdOSWx1YXVNVk56MklzU0ZV?=
 =?utf-8?B?TzlxdkRodnM2TTM0anJyWnFvcHhvL0JORUwxbWdnYjBCV1IzTkorelVQZTFn?=
 =?utf-8?B?K0FhMUpDRzI4Uys1TEZ3cnRpZCtRSWpEOStMM25XSkpnSnE2SU9WTkxFLzBY?=
 =?utf-8?B?QUN1d3dBc3RUNG9FVnExNzlyVnpPT1R5NXRyVHFGNURTWkVBMDVUWE1ESjFI?=
 =?utf-8?B?WnZSRDBUaU0rWjBIWUlUMTh4dmZ0bnBXYmkydWVmOTRrUW9lOFRSaDJZdmRF?=
 =?utf-8?B?YWJKRGVFNi9idldRZVkxL3B1ODQyZlNEaWJ4M3c4blk3VEN5QXcvUERvN3VX?=
 =?utf-8?B?Tkc1SzNzcG4zK0RvNVQrTlVYY2VsaG52cmJTRmxmWnlvMEx4N0tNVm5ZTXE3?=
 =?utf-8?B?RkVyWXhBOEZjM0w5M1lxeUdKZmRKOWh0TWRucEhiQy9CU0h3SitWS0dOY20v?=
 =?utf-8?B?TGR6N1NzL2d6bzU5STZyNkZ2ZlNHYzJ5NnhGQ3YzZk8vUzVaRUhJbzZmaDQ5?=
 =?utf-8?B?c2Z5aGxTbzBJRldCMk5WOUJUc2tleDc2NWl4S0dSU0t3NHhmUTdxYWxhU2M5?=
 =?utf-8?B?UjVEYXJRZzNDaE5BYXVmbHJnU2k1S1VuYXFVcloxc1NWdXR1bkNvK2FLTzMy?=
 =?utf-8?B?ZHNodVdSV3NYaXRUNVBGZ1pnb281bWE5aHdObVhKMEVpWVdtTU9ZeTNzYkM0?=
 =?utf-8?B?a2EzbXFMWFNyS010bFJxZ29wc3VKSG5HQytzYzJkU2JOOWUyVmNQVzRKR3ZQ?=
 =?utf-8?B?R0xLZk5vNkp1QS9BUFJZY3h1S2o0R1RyUGVET0xiOUV4R1JRVG1oYkgyM1FZ?=
 =?utf-8?B?dnIvd2E3RVF1VUg4NUQxNFNpSUZaSXFCZkJmMlp0dGV3eVVQR2cyWVE1Qjcx?=
 =?utf-8?B?WVZwSVp2NmhJdWN1bVNVV01FaVhqMFVOYlhFc0JYVndnQ0J3amd6M1JzVi9J?=
 =?utf-8?B?UEt2cFk1YTRHSWZTL2NadjB4RFNoN1lFb2RmTFhtZEFwQkJmdHowWW1md2ls?=
 =?utf-8?B?SFZpYUJTYmFIU20va09UMSsveHJEZGMwWTNkdC9SRUFTOFZwbzJ5Uk52UjhW?=
 =?utf-8?B?V0tqaVMzRzlNRzJFa1NYWUhuWFdzWE1tSUlid0FDNTZNZHpJUk53dz09?=
X-Exchange-RoutingPolicyChecked:
	qN/JR26EFG5ogOPLsbuqoaXylW33OWJgJyuTrmnVDCXwFYxGGDQEQvyAaV6ogbrN3Ay4/3rAmE5yi9YHQLiWImzN0Vf9NqlaRUo/h0MRQkstOWBVxv+gx96PiWQREBkuJPRuwJPMK3+PvswY0C3QkctIyVdNcwfe6x8wdfqQfT3nKE/b4CavjssmaaOyWoXN6X7TAUri2wFfCHfPTj9bJihFj0EeZ3AU7Vw6YddKzDKnGeqnUYX6yCYdb4xsRKDrT8qJ2wKdGnl2Z9WFiUMEPpK4X4uh8hXI0BiFBNcB9GORZaMt9XdRh6zxtOtZgyv+tP4AsOPOk+BEidHREUeGuw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A27V1EmfKmfpbHGdaRwS4zxNqO9B5cGGE4mlSn1gUf+9W7Bwk93+rHpm4AKddW8V6acOg/CFjr7A2lCuAZSbEquD7WEz2iypIrVTV+0KVedl6RwLhIjuhMWrnagA0hZGOMCmOlykkR2veI9uhrBXVr/QbUno87btfXwUyt0AOyZeGxTER7pW+Yt/TWlItFGkjlFUByp1nh41s+0C4bWFyy5dwN/BPJQDysGOAvKv9hM+f4EpqshYjis6YuKl3RYEahYbmVtz/4N1Ui3uhVGkeDeZjKQMO96iqM5305JjlKMU+Z3FFSgd5iSA9kMdX25M4m4WzFCjLW5UbocIQGPXr95o6Wvahfns+tYSe0Jm8+EloUby/RPcYaI/kINYfi4QBWKu2JwEReZjRES1QvSwKK+lxGK9sO/Y0/F9Z7JkIyoP4QVp32QLZ8xwKeeEMLZK/zD1boPq+HeLu8CLceG85Wje6oAtVk9nPEP+hxk7cWBTzyASQBwK7rqogn1qD/FKVtGN+Hncz6aaYcrUYPLN19go5iz507ZNROI1/2u6OJl6s++CWNtGz6mj8MfyQ0e4Rj8L4OmhDmDFk9/mwxo9Ms9vCdj+UK/LmOXBo6DIS94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073d0465-b828-48e7-2751-08df260db8c2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:00:49.1152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RVWAF3ATORaPv6Tjv/oxvs6OCcglwKNPiQBEnmFE3SUZueV7mlpWYK7GeJDb9BfZudd/3hiTL/X3Hi24uFkyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610090055
X-Proofpoint-ORIG-GUID: zo7k63eR8JJNQgQY9hpit81_4Ec39SiT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NSBTYWx0ZWRfX2a7IGgh+FVWn
 soc9/qtt/8uKzakk86g3AqKYChIrstqQyKcTifTa9jpgP5ccUxWWMavtbIbsvVBuIKiJ+9jpdZk
 tN2v2V/u/ldaZaMEG3enqw4fJwEI9pSe6hw5hrlVsUsPkpqYfT6y
X-Proofpoint-GUID: zo7k63eR8JJNQgQY9hpit81_4Ec39SiT
X-Authority-Analysis: v=2.4 cv=e6mT2qp/ c=1 sm=1 tr=0 ts=6ac8f3ab b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=1qgnjoeLtzMld6vI9fkA:9 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NSBTYWx0ZWRfX1tzpR1S2ecmV
 T9kF2zuhq5kKA48DWlGuxGADJ9d0JSzTII9lBiWugRb4RfiX/humUPGis2+KNhlQJ36nnogJI/G
 Ha8pngxeflKD5QGsUldMgTg10oy7gVl5K0sBmXRogDYF1xlV0POVSIFPsEIFkp02/mFFQ2/e2tw
 CbzRQ7/t20eo0y4uDZpzxYKvvPJZPlZZpq2uo5HnAVNsnltMJGFcz9Z+WeRCfA+zkYlWDGRjG7k
 eHpLGRQof1X2JYnslsPDI/TaxZS8jUUqg4ASBjxGFXxLLWDqORfR9rytwoI8n+MfwnBXrTfiY30
 qmfIdN9rk5xCl7YlLWkR8kC9/DcFDw0TKoAMP5b9Pu0Pdlwbt4anm5LI5sMnQyigke+xu4frqgN
 9VlELR43Roo3wJ910XWOxLwDJHK08w0lkJ6GUXrd2wWayOQLxTTbVwIOyZywWl3omTiT/yU4ip+
 44lpl6EIdvKSlbOBQcw==

On 09/10/2026 13:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] btf: memory corruption and invalid string offsets with split base BTF
> - [High] bpf: heap buffer overflow in btf_relocate_map_distilled_base() on split BTF
> - [Medium] libbpf: NULL pointer dereference in btf_relocate() when btf has no base
> - [Low] bpf: btf_relocate_rewrite_strs prints empty string in warning
> --
> 
> commit 5e8ac630aea03f4aa4b3a237792c60ad3c7a0956
> Author: Alan Maguire <alan.maguire@oracle.com>
> 
> btf: Preserve string relocation maps for split BTF
> 
> Make btf_relocate() optionally return the string-offset map it builds
> while relocating a BTF relative to a distilled base. A subsequent split
> BTF object can use that map to rebase references to base strings.
> 
> Also account for the accumulated base string offset when assigning a
> new BTF base. This is required when the base is itself split.
> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 592b71a838410..22dd123450c3e 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -1936,7 +1936,7 @@ void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
>>  {
>>  	btf->base_btf = (struct btf *)base_btf;
>>  	btf->start_id = btf_nr_types(base_btf);
>> -	btf->start_str_off = base_btf->hdr.str_len;
>> +	btf->start_str_off = base_btf->start_str_off + base_btf->hdr.str_len;
>>  }
> 
> [Severity: High]
> Since this allows using a split BTF as the base, will it cause out-of-bounds
> heap writes in tools/lib/bpf/btf_relocate.c:btf_relocate_map_distilled_base()?
> 

It is technically true that if we used split BTF as the basis for a distilled
.BTF.base, the string offset would be a problem. However we never do.
The reason .BTF.base exists is because we want a way to create stable base
BTF references for split BTF after potential base vmlinux changes.


