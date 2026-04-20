Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B14274FD0
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713117; cv=fail; b=EXsGgY4kMJdbxfp81EqObMD6Mb/ERCwoGNiecGhc3Faj+LtX0B1RWDMBrW1VaysQxa+b13IwT3gJ/GXsH6WYDYPbb9haXYQcqJ81zoNUL9iErFXP4c8+a81jb8WK9vzgaOhSDkbGady5b0Af12eHL+/euk4dA3PcPtnIHwkNlLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713117; c=relaxed/simple;
	bh=IKB0y8i1/Lqxnja+HdFGvJj1cFP+RPRNMouTiWogxYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YUaKKviNU3QNVgeVr3eSLcN+4KQEQuGcecZx/9yw8XM4pdr6+hP5XQekDHeARs2Tmh3pKl8nNIK1XbAG6aHUJkYjen6QP8koKrqDL0ebAQZ6mtMBOq5iC3MWpGe7tdBhzoThs6yyXKk+Rwa2OQxju+5Nr2filQ8l0/Qe2Ld1Hws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iVGgYgo9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V4tgCNWa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iVGgYgo9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V4tgCNWa"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KIMUZ11201435;
	Mon, 20 Apr 2026 19:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K09q8Nz6Z+G1c2C9kpyYUdAaRdftJCEK2IRY4ywn6og=; b=
	iVGgYgo9sQbYbInBSwG8BRDZkvMq13XoCmbuhuqbbDy9F6LSMdOpZD3uBGZ/AVg5
	HVYnP5uhdkvsJ7b/hdwthgu948IqhNK9j4z2YQoNbwaBE/ljiHKGxPyFx2lol8gJ
	FgSghIyj2FanebiK8dCdZvwHxrlfSVNcDRtOY+Fh/Ll9FhDAEtFIGi1xzOBvWmno
	PWkQUxk+yMatZ/Se4ox3p3Hpd87u3oo/20r5PtqhqbQ+nfsleKKl9IjdifYkc+p3
	DyzxZVlU1gN/fJYYFQwB8Izkr1AFol1Rr1nQPUNw45TIj+IKrQAe71WQuJ6wIYwT
	l1LbeWJbYoGMu9JA7qgEog==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dm28xkwn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 19:24:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63KJLI6t008226;
	Mon, 20 Apr 2026 19:24:56 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dn1af3ckb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 19:24:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWxq+awLgi9EJemXzj5Xy5ny7sJq1LDMvu0NR702wF0LAIr2C7SYS8LCQwnrevddUGaFWwc4uhfywVI/jXS72fZ9KV4seB6zWsc0Tsd7f25IDhpcly48GSRWEK+6Iky/mngsPwrz0BFaO5sqgXZrGhSEgh7oOyBRzpAR3HGGMeRcws08NihBSWSU2iTmQOysHOFsm4awzm/84PhJd4NU1RWtdiXJSBLcJDRTwMKEH937WLm+WsL/1eCENZenlk6QkQLIryjHcDqRBOyxr4AZ4SyAKMJ+PxQEFOZgf8H8P9mGiSQh+R4OFNpwmpBlkMmPL80CVveuycbazbhUS7IMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K09q8Nz6Z+G1c2C9kpyYUdAaRdftJCEK2IRY4ywn6og=;
 b=QZNNn4r1XzxDjRmPSm9r7LGFpVz6BjEY/Ivxr48Z1Ktg0iPYbkM2D+9L2QeLepUVuD+hjDYM3HLUhNGX+k/9C2Yt4LqOVTfPd3fZMRKGbOUifOYJ83OSEbeskH9xSfSaZ5K8DmmSWkS0lJOrcVMWsfXLfw0V5ax9znOQ9y4isRzIW9nT98Q98MpFi0QSq0bizx3xo2EoLm1a1MaRFFV5whFYG0cqY6QgqKAq7YoBBAmY1+gU8SdvW+OwV9iWqGel87B6KQTGWMSeK59JwiVJPVgEiQ5dgG8EYOAgR760syyMYxebaIXVTaQ/e5TA1ZPhEjNxHbNrdby6I3FrixVHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K09q8Nz6Z+G1c2C9kpyYUdAaRdftJCEK2IRY4ywn6og=;
 b=V4tgCNWay3e3yBwnNVflEOPDHw84lfG3WEXctVmSUBXUkxtX41kS0oRHSfHmLaPGd1Msk9LqqfWcV+vU3FsIQaUR8LcCgkGZt1gsDd+MOtxqmbjhwwbb6CRyhtqMBFRLB6iKrFLI0tRlmTFnnVU0Y6DBFEq69/iqQivQZ6lMhDU=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH8PR10MB6576.namprd10.prod.outlook.com (2603:10b6:510:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 19:24:53 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 19:24:53 +0000
Message-ID: <0bee8966-f5d7-4ab6-a76b-85ca47ec3ef5@oracle.com>
Date: Mon, 20 Apr 2026 20:24:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 0/6] bpf: Extend BTF UAPI vlen, kinds to use
 unused bits
To: David Faust <david.faust@oracle.com>, ast@kernel.org,
        yonghong.song@linux.dev
Cc: martin.lau@linux.dev, eddyz87@gmail.com, daniel@iogearbox.net,
        memxor@gmail.com, andrii@kernel.org, song@kernel.org, jolsa@kernel.org,
        qmo@kernel.org, mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org
References: <20260417143023.1551481-1-alan.maguire@oracle.com>
 <1b1dd492-316b-4ece-a3f4-dd26d85666fa@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <1b1dd492-316b-4ece-a3f4-dd26d85666fa@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0437.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::10) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH8PR10MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: eb66daad-0895-4c94-fd80-08de9f127f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u5/zLNQ8PS1usB2gOhhz5qtstbgX7UwW3i9ajmt7k3mlSl11LiRICjl0OrrcsyiSn4Zwr0XUpi8dxPLKp/7RlcMTCK4mx7iQDaj2qjJ5FYZNVWWJ8cW7e8z/kh60SYPnq2DHoL3SG0ghvGqXD3ZdPY6YgdwXHaK0TB0ND0TvawfEDAOCaNZX+9IVj1vyyqK7+Vh2P6OEp0QNyPNpxh86rNxx4Vr32XmaJRNzGdaKvt7hGHyYfVDIu97mhPMvKfxqBnQs5n72CYZmh2ZbnBGYz/3ix7ww6zi+ND9sel8n030uT4mfncNbwcZKbfgA3gwhJItuCzSHuktGNN+enCRyxFkq8p1aEsQCApgLEc4pCh7Vq8aQ8e5t7iyIqxX5Z6r83IUSiYco1DSuxy8ez0Hc2eFs5e1uRVxDfwa6XR4TkZ/aGUHbYUnXxx9MH3TfFY00hqmM2++UoSEBNoNEDDgoA6fmkzOBGn8RSx1pe81Cqu6HRtMQb5l76VJwSr3j6/Pkr/S1bLco3qaIMr3rd3gtExah/GNBQbdDFOlh9i/0WjLZMuPPRwsnORNiMmJ9RQdCUbxeqSDFzLqZEZg0y4UbQ7p9UGNxQ41630a6+7sAWsu7d5a5ka1xFdXsedTfLRSNX0sOniGim7UlWx1Skb7CJBdMcLlaLyeXC7wyKjP/q1eeCpLOaSoHrnWmvTiyiN64SkZuCCiiu2v5PkgsLuDl4oriyzLbL/BqRZ7OpoUc5Uk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N215UGNYdkMvMThiNmg2VGlraHBNenNPOVdkT3Bka3NSaSszYUZodk9wSEhV?=
 =?utf-8?B?WU1wTFFGQ2xYZFVybkp5ZWJXZ1QrV1JMNi9EVVhFTUQ2QW9JUnRQdHdmN3pO?=
 =?utf-8?B?dWFobHB1YjU3ZlZyM212TzR3aGtUV1JvLzVsaldSVmlkNGZQeDRISHFqd1di?=
 =?utf-8?B?bE1rdVhZa1JCbHd3NTlkcUJZWlFQNUY0YWhrMGV6dW5WalM3VmZ4TVhZeGJX?=
 =?utf-8?B?M3Y4Q2VPa1FLY0FqdGU4eEd4ZDYvUU1qaVkzK1hTM28rVW9JSUE4anFFZ0lw?=
 =?utf-8?B?ZElmcUhBenhldmthZC9PckVCY1RTMUpiZExzeENONFlFVjdLdTRrRFRUdjF3?=
 =?utf-8?B?bkNLYXFZMWdmOHhyanFBbkxqQ2s5V01Na0tUTTh3RkRUbVlDNGhJRDdVckl3?=
 =?utf-8?B?KzRHRUJWZy9kNWNOR1JOZitvcnMvRGJaaDcrUEpKakpubUExNk9HdkEvVmEr?=
 =?utf-8?B?RzlsV0tGOUd2ZitML29SS1pLMnptQjZmSHpFWXo2SkdkVkEwd2dRNk1Oc052?=
 =?utf-8?B?Y01lWTZ6eDh0c3o5cFBxVHlQSlVrdXkxb0dHVXpHc2xrZ3F4NlRFeVd6dnlV?=
 =?utf-8?B?dkVqNmFTNkdSRCtMVmZwdTdZUStKMkFTWmtmc2pQaFo5YXp0M3FNSEJ0NERw?=
 =?utf-8?B?N3ZnWmJQWEdRSDFNazMxYXNMM2Eza3B3WFVrbE9vOEt3RmVRUStmVXFhV3Ry?=
 =?utf-8?B?djR2TTJYdmVpUnpxMHVnMlVjSXB4c0RQZ2tkSEZzeTB3aFRSR254V2x2NmU2?=
 =?utf-8?B?UC8rNHJSRUMxa3BjVDU4Vk8xMGUzZHNzTnNWMHZqeG13Y2MySWdBdnJWYllp?=
 =?utf-8?B?Y3NKbFEvU1hjT2NxMGZDU1U5UlhwdHlSQU92U3F6VkdITllsRXpIaVVXYzR3?=
 =?utf-8?B?Vnp6eUk3WWdtVmRhaUpTaDBtMDRFejh5UXhCdlIzcHhXaDBHdm5PenlGUmU4?=
 =?utf-8?B?S0dsdkhWaFl2VUVBOGNWU1RLVjd2ZnV6aXk0MmRWdU5KOXExb2NoOVpMaWEy?=
 =?utf-8?B?R3M2OFlyYkwvTTRKWCt3ZyttY0hZZW9zKzVvOWNTdTRYeUQwMURuM0ZpeUc0?=
 =?utf-8?B?TVViMUxBUVpYMTdidmxtTk1VcUNQV3p5NXhKc3hxTnM0QWdhM2RDRGZzNjVa?=
 =?utf-8?B?bGdQMlp6UmllU0hpSjA5dU5LcVFEMU01OHJPMWZTOHZQZkpDcjR1RG9tRE9h?=
 =?utf-8?B?VkpwQy9FVWo5eGdWVTlTM09EZ0YvNFRJZlQ4bkNVcGVNN1M0bENxSUJRcmx5?=
 =?utf-8?B?TElBTjRFbmdWNUF5QmJFMHFzZ2Q4VnprQXZKTStYc3ZKd01aSXkrVHBwVnlC?=
 =?utf-8?B?VGt0azh1OFgxSkdEUkxnTG93SjI0UmxrbE5aVmdwMjhCYWJLK3ZGQUZjQ3RL?=
 =?utf-8?B?T0krWFlmRENaYm5EeDJrU2ZoVkhwQTZWN1cyb2hnTGRSSWVoajJWMzhnbG90?=
 =?utf-8?B?T1JMbXJrR1dSRGtMczJNcHNraUFFUk9YSXRmbFZwUEowQlFSOW1VR0JsMysr?=
 =?utf-8?B?SUZFMjZFV3hwQzNmWng0OGxtVzlUelhPajIraHl6cDhldXd6dlhwcTlNZzRV?=
 =?utf-8?B?QjNKT3pZUzZTK1NBYVlIWFZtOW1MZ1BKOGtaZ1pnanBFTCs1dkJqY2VmK05X?=
 =?utf-8?B?Sm5RV1ZiVVhXVnlvaWRYWm15ZjJWV0hXVlF5UVo1dTkxbXY1NFlPVUQ0WGdx?=
 =?utf-8?B?UHBUS1JpODk1YmdVUS9pYnBGa2FtR1ljWVFWcVhod09SWThETUZaRzc4ZzFW?=
 =?utf-8?B?WHFzcUNLOXZ3bkNBNTZSbWhsa0Z0RDBzdjlwcXEvb1I3R0krUDgxN3hDZHEr?=
 =?utf-8?B?WElVNnR1dGJkSUM0RkdTRGZuQWxJclVpVEIrSXRMVzNrV3IxSXU4ZUxtbU5w?=
 =?utf-8?B?WjBNNGplRTF0VEFWL2pJcm4xUGNJRms4MVJwN3pnZ0hOK1NzcEplSHVoc0ZC?=
 =?utf-8?B?a3kydzByRjJnb3d5azFjY2c0V1hLQ0svcW94eXBoazBwSHdaWnVTMFByZ05s?=
 =?utf-8?B?ZzFQMVRzZU9FSFRHWm9oOEw0RDFVZnFGWGZ3MFRIaFJXYXRVZlV3QXZaMU1Q?=
 =?utf-8?B?M1ZTK1E3QlBwbUZsb3cxU3pWTXk3dXZuamN2RlNBT1dGUkorTGt1ZWtzSEc3?=
 =?utf-8?B?YTVick83VzNlS3lxc3RGd1I4TEhHWU92TFo0Q2QxOSttK0N1Vjk0WGc3TmFR?=
 =?utf-8?B?c2NyaGRyTmZxM2svZHc1eDR2M0llT3h0dWRvUEJYUUxCekkxS3laSTVJZkNs?=
 =?utf-8?B?TkRwbUtYSzNzUWZoL25VSnRXN21TU0R5aVZ1UDJ4YVc4eDNiZGRlVVo3Y0dl?=
 =?utf-8?B?d09Rd0dsKy94VEZsNnBjMEM2S2F5K0Q2UTNtWGNQZUJvclozRllLdz09?=
X-Exchange-RoutingPolicyChecked:
	ecb+KTwrEaetC7+Cg/Zw8YkN7A0F/Z0cDzI1MZjrozw4PQDpm9uRE7vbF5vgbioNGKxFlBA8gs00FKLOPdNFwy24pLWlWoIrwUm9boWphJVJxRbj8niy6HjMXBrrdd6blhdRbAUmq2QpX4bOCfE6xshYNtgki7U5aJ46QOnMWidXgxB2r5W18o2Wdzd+KFje1VYvw3stbbp69D699J0DpxhqdE8q921bY9/cJz1x/HJ5pfNoNt1rH+5ivb3JQYoQztrajlpjMgHZH1xxFwgcdqHdzXbkgN9Hrvr+wa/fKYJ7Y9qssC/RgdvXWzYw70wyg3vQHDsixFnEaQ6gC9HhzQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/bL+Aq2j4UzCpsXsm5Bc+jvQ+UKJ/l0kS/rV/ftCy9j4BSCHbFjtmrvNov7OnUv6jrrHC+fQcrr5Q3GW/5pV8gf3yWnpUXWlWx0kEWGtBsJ2n53J22nNfWJZp68HoKt9GKoWspmZ9F9Gz6AL+Lp6nC9TRdfbL32dyOrQi18Kca1xpMzaWWewpiQJUMATncQKR3/ZHke69pF5dt8y8H3eUkerBlKmpnLxctqSAjD9Ntro7raQ+oOSR7pc/IFRWQWkO5VKu15ROE41Cpnr+jgAPLYkUTOpdu7U8b93ahAquP6qulxgaEmec4OzO0iiRc26FhvTTRzEFpdoVeaGfp956Ni2yuWKo39oTo5nlxrT7WiabgWLeIRD1NY/+P6H5zEHdms6Aqal4Qna44HOrvgHFAczAOy3oak+3t6YPgFAfANl4DHwhbrFmi6RzDeTzn4ppEU04oQU9c9ogYAB812GtLA3ni4xqG56AjdG2MlQHDM3jaPz8aeMyg6S8ted1BBz5OpZ3RUH+Yjqbg6LYx6fur0umh4wtbn4Fg2LoiPWwAArgJqYDODl5XNGWgy1MS08/HAiD4YoZ43BJ9YvrzjSFwRPcyJRyFYeCIA2/DO1gfw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb66daad-0895-4c94-fd80-08de9f127f78
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:24:53.2671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSg5Uz/N3B2FoESljTAJ/jyFk4diDibh3+VXCMUNgT4rz4Yym5UxiSq4yvY+IKqc2I8VPxqGzaKRM1PTumz6wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604200188
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE4OCBTYWx0ZWRfXxL/rnhCx1cOA
 z7+wxIVguYya7B2gKLzyqfEn/+Sj6fTjKg+Fq8GEKRUdDbzZSUoUp+WGkEpPsq2Likz6LiFGuHG
 TxybTTw4G7aJhag9ax9SWCBOJC0pEa/JVRuadsXeC6DwinfzG9IsFxo2AIijVs86UiVFbibIzfu
 eIRXGYoLC6udAB9Yu2jiQmHIR+MhK8LFEeQ0EGUqb4m2gEkMzOEE1njeyg5wV6MWRN9YrW10uvi
 yycbeOM2p14jiMiJXHUY0cG4mqULlidUt2Ki49vwMLiuY4wJbpqeV64x9uuwGcMccQwxX2SXuVf
 rV3ciraSeQJT4yrSh4sJbgunF82R1y1b7uiJQ+MpCLrqgkjP4Au9PjqVV0ZOsXGa/2AosRlUw/4
 YQzDAe5vi1OdUNN6w97XJANGHr5jxuYV2Oftqcag+DmQwk+W454EmPyvhtmuKlQtqBluvvOZ+4L
 2koVVGHS4O3x396xPrQ==
X-Authority-Analysis: v=2.4 cv=er3vCIpX c=1 sm=1 tr=0 ts=69e67d89 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=Z_jVGcaz6a7zmuTL3jIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1sHj-ngWlCaGcM8uejLzzoP4q53AQ6tQ
X-Proofpoint-GUID: 1sHj-ngWlCaGcM8uejLzzoP4q53AQ6tQ

On 20/04/2026 19:30, David Faust wrote:
> 
> 
> On 4/17/26 07:30, Alan Maguire wrote:
>> Currently BTF types can have a maximum of 65535 vlen-specified
>> objects.  While this limit has not yet been surpassed for existing
>> cases (struct/union fields, enum values, function arguments and
>> datasec), upcoming BTF location information - specifically inline
>> sites - will hit that limit.  Utilize unused BTF info bits in
>> struct btf_type to increase limit to 24-bits (over 16 million).
>> This is more than an order of magnitude greater than inline
>> site counts for the kernel (~400,000) so should be enough for
>> the near future at least.
>>
>> Similarly, struct btf_type uses 5 bits for BTF kind values;
>> currently we use 20 kinds, but BTF location information will
>> take another 3, and conceivably providing better support for Rust
>> types in BTF (now that modules can be built using Rust) could
>> push us close to the max of 31.  Use 2 unused bits to provide
>> a max possible kind of 127.
> 
> Should we bump btf_version in the header for this?
> (e.g. when emitting from compiler)
> 
> It may be useful to know that the BTF for a given file was
> constructed with the new limitations like vlen in mind or not.
>

hi David

From a compatibility perspective the kernel has always enforced a requirement
that the unused bits are zero and it will reject BTF which uses those unused bits.
So with this change the kernel will permit extended vlens/kinds but older kernels
will reject such BTF. If the kernel had been more permissive in the past it might
be worth a version bump as it could be argued that it was ambiguous whether the
unused bits had random data in them as opposed to extended vlens.

So in this context I'd say it's not worth a version bump as there's no ambiguity
here; either the formerly unused fields are zeroed to be acceptable to older kernels
or they are used for extended kinds/vlens. Thanks!

Alan
