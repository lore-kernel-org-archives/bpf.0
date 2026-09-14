Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC404908AF;
	Mon, 14 Sep 2026 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406821; cv=fail; b=rcyrRTs2oomdlJJs4XJJs6kvfk0rapuvk56l58eY+lcSzOwRWLCgwXDY8sQemIm6T62SI0CNQU28pGWR0g3uG+ANkUn+c0MfzOIIpeXpKlREK9QNqbcNS4EC6voKmX6t+loaDl0NVe82+wwDqzWeXASWy3CD0mUtELRf660hfd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406821; c=relaxed/simple;
	bh=/AZtYcxx/mCTn8SxdZKwgfEPktQhrNJNOWLMv2Kv/PQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hSaWMz83l4DaSzv0qH89om2+vqsa9YmXKKLRXlIukLNOwxgqIHkRe3ZzDeIp5HzR/Ntsy/QqFEv3w5g7tRTxn8yuAeEwZBp9x/9+YobHNTHAaECD8016NC8V8qRj61o+kPNQpBSHRGIiTwOQouRvzZq8p/lxvzzcnTSN1ILSGIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cQsckRHA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=io2lmQdy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cQsckRHA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="io2lmQdy"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EEQXPt3134148;
	Mon, 14 Sep 2026 17:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GWkJEikCkaJS2F0QOAVEmp8vd351R4g6iY/EPFpwbk0=; b=
	cQsckRHA8lTc4htdjECQubC12lrGy4doQFirwWQvqIDVIqQTb+qIedCKPJCtlIdM
	mAn6wld0WzwlMyWUKlGPCR2HaOfvv8HA0uL9NMmtoJFhL8jzr54GtmLbAAHTxA3C
	gdwdd2Pw8zT+SzIUBnl8+LATLSE8o3tcPY+tEAMTbBlr88EjQQDd2pMOjQBMjltn
	inxJ69vvn6NVHALtp2YqkoN3Y68yaRqUFeMJetDwEWivMIeBhz13Chup5uEXpL2s
	lQudbhfHp/zVE5x8xOCsM+NlaQ4tkeWF63XtXqu+ptMhLlaE9OPwE3UP9yiwAbts
	BJSCZBN46AVg3eWwmqHKtA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmxsbj8v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 17:26:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68EHP1q6000933;
	Mon, 14 Sep 2026 17:26:57 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6b1m8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Sep 2026 17:26:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTipX2O3zXhyxkPB6fMko0BIMf6Ef/vErbpd6L25jXDa+GagbbhgYQQONp2FWhrhnxaKiWV5fekB8UunUrGxM4UtQ6B6MbdiaMx0fAOfjf2VlaXetrgfr2Gv/wGjTUXGChFPs39mAfpJnnE7xAazPiHi4MeQulYMuJXrZ0uukfhWTybNbxoBwldDD4ofsv18VV9isYt2tFzRhly2WBXNVpdsl11vCGZoS0vzoJrDNEDKRob1ooQBtC3xxrQRPKA4Ojk/0IRqWZ7gGRX5+H3+43OvzMXjmnIAdCgy1ua1VJEsBAH0znsVzvfM2bleJbBQjeur3vBKyMWOk+lbK3K0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWkJEikCkaJS2F0QOAVEmp8vd351R4g6iY/EPFpwbk0=;
 b=LWRaoZ7qUR2d/vCg2+/ZFYGe2WcZvI7E5cNWVvXoF54yKiqG+zjQ5itmMCW6dYxizTfit81118sDiZY5diqOlyl+k7YfBxW2kTQlYsRwjvwomBaLd3oRBgS9hDdcosJHfvBqZm8DJmXt0eAR5UryUUV6nBTNuxjs9UBOeovOQ8hH1+mSCzHD+t7GisSIlmdBzsHYxnpno1dDiHqrFPwXkC2C3t0gwkyKXI2wE+hwdbaaIeQseS5qHTViKfjpbxv/hqnZL18734uib722hIcVqysmPxJJ1GloWc+3DaSJm8SUFw+zhSYadSMDe4vjvSt+GSwUS0zPbImQnHgwnPDlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWkJEikCkaJS2F0QOAVEmp8vd351R4g6iY/EPFpwbk0=;
 b=io2lmQdyAmWv3WySD0CEMjgmoO39M9pQaENJBF4p1zbe5KSj7/QsVWFvP8Rj/qVIJurIJ7RUDnnq2emxyjQn9ZgeY2zk1DVa4W1v2y/y7+3+QWU4QeK2dAzTgjyIjnjmWcHg4g+z7G7xlw3ojl3tVzJ+JDH4nDCOl3ybpWOWanY=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by BL3PR10MB6090.namprd10.prod.outlook.com (2603:10b6:208:3b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Mon, 14 Sep
 2026 17:26:48 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 17:26:48 +0000
Message-ID: <0df37f1e-f727-4b16-880c-5c79cad46515@oracle.com>
Date: Mon, 14 Sep 2026 18:26:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 01/18] btf: Extend UAPI to support BTF
 location (inline site) info
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-2-alan.maguire@oracle.com>
 <20260901171757.A506A1F000E9@smtp.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260901171757.A506A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|BL3PR10MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: b129e215-10df-44e8-4d43-08df12855b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|6133799003|22082099003|18002099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	dknWh+kM8SWGzrnTb8r/2GpxiGwd1pGHZ2j459E8yUH+gMeyrovXZY8jw8/nxxW7Xs5bqOl6biykclJEjPC7OOigqAyDalJBetkN2XAxJob8mMztO57FLQHNPo/iFkxbo9wBF+xSIKB4kAkxRbBSJhEHbT5IOtjjFXVK4kynoMPTnIvHrw6UqlJsBuEIXwLHm4KvHg+J5ZWz5eQvgiOJR107Lu5eLxd3jTC31Z4s7jzuUgbRgTjHLAS3JlB5jFK6AF5Z8HFVBzooxyNbuwYMi98gd3d0fD7EF2lcnsLnR/zKmJD/MZHtE0jH6zmC33dS1vvF7UZO4ItegjKJUunNhj49jlTFVxw0M1E6gNFwkrZH9jQn0NcSUSnYGJYoYlD4TKBTV+ucTll05lp25YpjACuOTXc7az/hkawUIA1H6wB4zVkVJKUKbQy4YcUPWbxMjdbjVXDtAOUSNXNpDcvpFN3NEoaJAV1F9TeeOrWlIXfiUSUNzfcUYLNie54fBHOHZyGdLRaeHAQUx7G+tQa27sXlTcJ+mPLey8TVBnGKFvxupC9D11xzNb9ZA6RDprml7js+lFriHu/u5KGeEdiu8um1fEUzPU5ZEpuPMYEIkOZEWXqQwr4PsRLZAeanQS0B75rpPKXAM34XdFNfk9op8JCR7DWcRKwzM93xXYpEAZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SitTWmcyUWU2ZFpkRHMwdC9QaFJ6TENlU2pTbno2RmpHajJXVnVudnQvL2Jp?=
 =?utf-8?B?NHpqK1NBZHZ3YmQvVDZncjZoTmNRQnVLSUY2SXZIeSt3SXd6UE9MZENFdUhV?=
 =?utf-8?B?bU1OWmMrR2xQUUtETUZZNmwzM2VzMHFubGpwaHgvc3lxVWpGdGhtR0NMMFZE?=
 =?utf-8?B?ak13S3hVRVRPNlVFcWRYVmZSMi9tdklxNzJMMCttclJDTFEyT2E5ZDVURERN?=
 =?utf-8?B?N2psNWNIZkJSejNRd0M1WVk2Y3M2b3VOVFVheDFodnhBaU9aTVlhOWY4b3Zh?=
 =?utf-8?B?YzFzaVRSeUZGN1ozNFJ5VTdpMEpCOFM0Szd4dFJ2ZGt0c09XMVVsZVRlKzNC?=
 =?utf-8?B?ZWtJU0QyM3BrSXVGMCtmQzJ6SmxiVCtOSVhKbW9XM1ZqZEdTdGs2bUV1cjFU?=
 =?utf-8?B?emJnNEFPMTNuN2V4YlBEb2Q5NU42WXRLVU0zZHZyZ1c1RFZ0bUo4dG5NSW16?=
 =?utf-8?B?dkw1V0E5QVI1WCtEU2VBdmR0L0hmUTVXcTFoVDVjbS9HU1FIeWhLVWp0OXZR?=
 =?utf-8?B?bXk3NlNBR002NG5TT2cxRUVmVy9wT3BXeGRWLzlDTW0wc0J0NmdDUWduQisy?=
 =?utf-8?B?QnhmN3RzNlNPSDlrWThGL2V3VkQwUHdib1I1cmtrSkZpdE41UmpvT3o1WG9V?=
 =?utf-8?B?TDBzQmJCSWhpbmowNFVvamc2Rk1DeHIvR2RJNjVYSUhmbHd0M0YrTmVYQU9j?=
 =?utf-8?B?aVM0cTlXTUNpajJIOTJwRmNmak5mMzluTDgxRTg4Yjk1TjVocW8raEkzUkgx?=
 =?utf-8?B?eXEwdnVEMHdQeHBjRGFBcXFzMUdZVEp6OEtEdHpDZnI5UzJoSk4yVG5vYVNI?=
 =?utf-8?B?YVYvc0lKS2pMQkJOUzJDdlRJdTNXOXBBWnl5bDlNR1VhYW1sQVZyQjV3Slls?=
 =?utf-8?B?VS9MeExYZnUreWpZK2g2a3gxeGdDYWdPUStZZnNNcUZaOGQ3dXg4RmtBZEdD?=
 =?utf-8?B?Rkk5L2ZKcTlrSHRaUllGSVI5aWE0b09sTlV5YzNxTmpXQU9GRHlXWWVPOFM3?=
 =?utf-8?B?RXd2RUJ4VzV0REVLUkR4UUFHc3U3S1BMSUZQRmRlL3Z1UW95STFNbk1UeGdF?=
 =?utf-8?B?ejFiVktZbnVkWldCN2NOZ25SK25aaVVlQ09JbmZ3bWJDUURFQU9KazJUYnJZ?=
 =?utf-8?B?bjhRdUttSzhHUmF0UHBkcWthQitvN1pXb0cyQ3JUenRDdFZJaHBUb0Z5YWNY?=
 =?utf-8?B?N1FIbkNzSWYwU3RObGJhK2ZiUEUrTTYrYUdVK0dmMEJPazlaNDhDU3lxM2hU?=
 =?utf-8?B?MG5MckRLYkEwRGsxdmIwcjZ0Yi9vWjRsNytFU0J3RE1INHp6MG51MHQyRm1R?=
 =?utf-8?B?SXZrQlN2YVNxekZYT1hEKzU2V2p3dkk4K05LNmNhZjV0ZkFwUGM0akFURnNi?=
 =?utf-8?B?Y1FoVHp4SmNHUjRFZTFCc1A4RlBLc1hPRHNJeTVsMmcxUzFySUdTQ1VYM2Jt?=
 =?utf-8?B?MXVDTU1yNEVlVDd5aUlkWGxCU2E3cDZDVG1WZlN0RjZvaVZZb3Y5a2oxekRB?=
 =?utf-8?B?NmM4RnlCdWk3aFU0aVR6TDNHZ1c0dVhvU1VVLys3bWliSGZrZ3JKWGUwcU9t?=
 =?utf-8?B?Ny92ZjZNMFAycFB3am1wMUNETFZBNFZnTWJlaWd0dm1Ud3ZIaThNNFhiYzA4?=
 =?utf-8?B?VG9BVlRGV1VFckFpVGZJaHk4NXUxaFdwSWx3MmtTSDhaZjcwS2F5SXMxczVo?=
 =?utf-8?B?RnJhdWlVY2lOdUluWkNHL093ZEhidGZSZVhxdUt1VWlCQzZqZmtyTHNSY0xI?=
 =?utf-8?B?RDI4VllDdHR1SmhGVVdsQWoxNjkwUVpWdzE5bllZL21hN1dXM3N5ZFhaME5R?=
 =?utf-8?B?VDgwOG5GOHBFdmRUcHFkVWozSjMrRklDaWp3QTRTeC9hd2FiMmYxTDZPS2pH?=
 =?utf-8?B?MEFDaFhUYlk0cjBLcDJaWHVDWEl3aUtFZ1lTVkVrUU9iYXJ4WnFGNk9LamtS?=
 =?utf-8?B?RVJOTmtlWmJEVFZwUVk3NFhEOURxV2NsOGxIWllQR0MxalJ6akZ1QmkxQWpT?=
 =?utf-8?B?bVZSZWo3dUJ0cVpkWDNBbDhsejRQWEVKdGc5QkZNb2dxY1ZQVXBMZUdqUUVX?=
 =?utf-8?B?aFVRWVl0YmtMOTUzMnY1L0t0ajlUNjgzUW1OSzRlTFBSMVNRcFVacG1hSUMr?=
 =?utf-8?B?T2xqWUYrVS9seHNJeTIvU2RZenJRU01aZEMrOEFsL3RscSsvcWFwd2VnMzFD?=
 =?utf-8?B?WERBcGozZnBKM0FVbTZHcE5LZjlEeG16K0pJNHNLYUxFQ2UwU0RCRlhzaUF0?=
 =?utf-8?B?VUg4VmVSZDEwckRQdG5qMGk5MDRjaFh6VzdkSHo4T1ZiYXNSWWxTZUsxOGRs?=
 =?utf-8?B?bFdDVk9tNGlTK3YxWjlqeTRrckFSVmw3ODYxUHNtRUxpcG5tT1orUT09?=
X-Exchange-RoutingPolicyChecked:
	SsjOLrlEsWBdWT5pJHklOXdE4dQxlWoAF1/6PK3UCD9jwuJAulNMI8KS4sedXdIA1HjTVEs5+8nxP/ckSaoJoTSlHMK0k02930uYM9z8jxomqg23HC4m9dzw92YI3lLJIDdNvZ+c1j8iHFpmWLGL4rjnaTNj+JEhDCBQ7CyzUTeaWASfgAeFNyDbOifpDKMqwzowGe9XzgrJ+EkXupMd92cdM0vTQqnuJqWUhFhctKneg90lqbENhQJlj6KCV6GkkPdCpXmHd4HziwBgINikL0LB8wbLuiNtc8ZWMll6ino91zgHo2uBTKkdaI+EvJDdsd+kEDLlloEJcH+Nubhl5g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W+Vqz7zJENo0pnCnHugvjYSGZRk2Xg+A3MBeVTQu0YHsKhRFHGujUQ9pWSOiH2g+ZRDoHx0SKBSqhR3dj6RLn1g26U7PBtCv7k02y/NfOUgH6HlL3lKY/5TYMCDR7W3UwJvmusmQfAtK+nKjjyukC5UNj2sz5E0mJhKbmPdKy4AOaMiYkw00P4izRMVBL2F6svr36BAXkfP+p6+IOxYSdrCN9lBRvzJCOvBZNdfcRwoCVaiOavTZ5hyVT6ZW+ZiVbpak6iOjlvv6zNBId+GguMB9QrouekK7NFGRbcIL4CVOlQr5ZNuzTq+DNP4mOj4Cvm049MYQA38A0Gn28+u6xffQ+/OewIf49HXXEkbB3xp3R6YqUKbiXREdrn4DIXZgIgqBv/wAJkX2zTxZdTuT6v3+9G5EQ2anhqv+owrdxn9UCmz++QhY2k2l9kkRiRR8IEfFc/A6IzOIENbNBbH+mz0yllR4LJ2PmHvZjRvZRw35udKgr0teXQMUsO/6v9aGwo8Oq6zjoYvlouOZNtH0yHUwBFpD/aEn0pxsuu6COX6M/N13QEkKXmHX4UrCRqtLxdIRASuYvLsjqzB3n4JFLEozWmBs79HxisOmWs708b0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b129e215-10df-44e8-4d43-08df12855b3d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 17:26:48.2281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HyXKGtngNNI5OS7UlcIRd0fufskyW5TXO4jx249nyMkFjy4nlVP0N2rVmv2cIDTftFy1OF71mCm5BVPonkxvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609140247
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI0NiBTYWx0ZWRfX94Ptx0LZHADP
 7f8sc/pB6VRBDyG7QkCssXp7Jhb8k21qe5KTgsGkxy1ypOcAaViR3bCgTmkh0VltOxikKsTFckx
 kfYgEjPg0O+pH1vBrsfLSAZswLf1F9rKVW+RMsmLFm2HtR1YH4Cu3X0fa0bK2moDZG5KIeODc5Q
 uPOcALcjjg2hnUmwSsrBN+Z0sHFAEiKgDoQss/q001cFiOPq+MqYpS9jtp9831gb0UINl15dvNC
 5uEIrGONGYTEvzCXFBCU+ZMgzb7sWvY0eLYu69KH1hjB6m2yk0SjAh6vijSmuP11zgd2ZxqCtYh
 sbSa8E0ZAoVW4iYI5GTyBLq+1UAQSdTvJkU6hG+G9fKafNosyk5GWAUQL2HCMMSqOvS+jxKzxo/
 M+BwNV3Ksue15j/FgO+Mj7xPhbcl0Wum2osnZJwIES6xjvANrlInUBRnVJXrCir8bEEwdCG17xs
 A5N8KL7Np1lX54l8ffA==
X-Proofpoint-GUID: P-uIsmlLa5Du005EEDLTUuvmbbd903PL
X-Authority-Analysis: v=2.4 cv=dY0VTnXe c=1 sm=1 tr=0 ts=6aa82e62 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=kWs9ooAbT9S7EJzgDXsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P-uIsmlLa5Du005EEDLTUuvmbbd903PL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI0NiBTYWx0ZWRfX5S4YIeMi/ulx
 1gY8DXj4CA4tEjqGpCufE9EyaceG3y6EdTsC0yaKnDkcBjxpQzt6eZniUqTPhf3dSpb9vVpBTl3
 Ffq7s+6sqpwmHqC67h7i3ciVF2I7LzCXOuN2bsvfdt8Pax3Q9/al

On 01/09/2026 18:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] btf_loc_proto_resolve fails to validate the return type location parameter (t->type).
> - [Medium] Missing strict validation of unused fields and flags in check_meta callbacks for new BTF kinds.
> --
> 
> commit 32008454060b92e68c858ee6b661e8885cb28034
> Author: Alan Maguire <alan.maguire@oracle.com>
> 
> btf: Extend UAPI to support BTF location (inline site) info
> 
> This commit adds BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO, and
> BTF_KIND_LOCSEC to help represent location information for functions.
> It enables representing fully or partially inlined functions at
> potentially multiple inline sites.
> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 9c2cab08bb794..d74c8668aa3f6 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> [ ... ]
>> +static s32 btf_loc_param_check_meta(struct btf_verifier_env *env,
>> +				    const struct btf_type *t,
>> +				    u32 meta_left)
>> +{
>> +	const struct btf_loc_param *p = btf_loc_param(t);
>> +	u32 meta_needed;
>> +	u32 size;
>> +
>> +	meta_needed = sizeof(*p) + sizeof(__u32) * btf_vlen(t);
> 
> [Severity: Medium]
> Should this function strictly validate that p->flags only contains valid
> enum bits, and check that btf_type_kflag(t) is 0? 
> 
> The BTF verifier typically rejects non-zero unused fields and unknown flags
> to ensure forward compatibility. If malformed BTF objects with arbitrary
> garbage in these fields are accepted, they might silently alter behavior
> or break if these bits are repurposed in the future.
>

kflag test makes sense, restricting the semantics of the loc param flags less
so given that we don't use them in the kernel.

 
>> +	if (meta_left < meta_needed) {
>> +		btf_verifier_log_basic(env, t,
>> +				       "meta_left:%u meta_needed:%u",
>> +				      meta_left, meta_needed);
>> +		return -EINVAL;
>> +	}
> [ ... ]
>> +static int btf_loc_proto_resolve(struct btf_verifier_env *env,
>> +				 const struct resolve_vertex *v)
>> +{
>> +	const __u32 *params = btf_loc_params(v->t);
>> +	u32 i, nr_params = btf_type_vlen(v->t);
>> +	struct btf *btf = env->btf;
>> +
>> +	for (i = 0; i < nr_params; i++) {
> 
> [Severity: High]
> Does this function need to validate the return type location parameter
> encoded in v->t->type? 
> 
> It appears to validate the vlen parameters (params[i]) but entirely skips
> verifying v->t->type. If a malformed BTF object specifies an out-of-bounds
> type ID or an incorrect BTF kind in the t->type field, could it result in
> type confusion or out-of-bounds memory accesses when subsequent code trusts
> this field?
>

loc params don't have a return type since we can only get at inbound parameters
at the location. We should check for 0 I suppose.



>> +		const struct btf_type *param_type;
>> +		u32 param_type_id = params[i];
>> +
>> +		if (!param_type_id)
>> +			continue;
> [ ... ]
>> +static s32 btf_locsec_check_meta(struct btf_verifier_env *env,
>> +				 const struct btf_type *t,
>> +				 u32 meta_left)
>> +{
>> +	u32 meta_needed;
>> +
>> +	meta_needed = sizeof(struct btf_loc) * btf_type_vlen(t);
> 
> [Severity: Medium]
> Similar to the location parameter check, should this callback enforce that
> the unused t->size/t->type union and the kflag are 0? Without these
> checks, the verifier might accept garbage data in these unused fields which
> violates the strict validation design pattern.
> 

Sure.

>> +
>> +	if (meta_left < meta_needed) {
>> +		btf_verifier_log_basic(env, t,
>> +				       "meta_left:%u meta_needed:%u",
>> +				       meta_left, meta_needed);
>> +		return -EINVAL;
>> +	}
>> +	return meta_needed;
>> +}
> 

