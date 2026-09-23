Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331933D6D6
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153278; cv=fail; b=gOT2jvN2RbHzuBHp2f3lVuMVaIx6VClGcGyycTubI5u8NdEf6cQl8I/KkHqwIxLzwox+dNW+YVI9CgZBsx2LI0+5RUznpsu6JtjILmdDZRUZytmsQokmnQeTKk+8XJqLquivuYraswRIpjdvIV3B63ARIqD406G/SPMej5EJKkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153278; c=relaxed/simple;
	bh=dojZxYNjmmk8yU1fZhrs54TO9yqaAI93kCUnL7ARZdw=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=d4h9V/RT2k3Nq9X7coaxOcEkXZSVfZAW+7C564wxNjSTq6J+OL1y015db14ohdKbzUtu9Du5qnTBeVPqQ37/l6BMIsiKPvUByS2C7XDFSXdNi1MROSkfZenMDx/BvEywmbySgwWzaKGt4ITNJa8S8yzCSysy397oicM/etS7E5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GP8rMAzl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c4jqeZiS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GP8rMAzl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c4jqeZiS"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N2HY6u1206931;
	Wed, 23 Sep 2026 08:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=48Ciyy19jNtAmivhw+
	C+Psdlzh4hSVfrVw03H2J/pxw=; b=GP8rMAzl02TT8tJADuExhBPbHR+GnvV+Tz
	FpzpwHWDmVCaw9ssjUyNh7ZBqDM/ng0QD9hHPnZyFMEJqHfeoceETyqFVIVJMgjg
	waOykFEaYIVx5iqNiO9stPwOqLE5uz9ed8ISPtFKnUKBQZRkxA4QaBLO0dZVB6L+
	5/e/a93aE7xE1f776lB2JRhc36g2bw7aztvO4bngHzwD8un7J48exnydQku5vkMn
	86M/Iv84aYSxXiW9UbA1Lu5UAWGU89uACyx2R2ES3ssZzeEPDSVPCpy2/kgQUEXi
	6v3CiUCQ2QCMzKjb+MEzT/sKM8PaXZ4hiZWs3wE4VnR2cBcb8o8w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0xnekq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 08:47:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68N8Z4j4035808;
	Wed, 23 Sep 2026 08:47:27 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4guurhw39f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Sep 2026 08:47:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sl6VMviPA+j8ZOFR7T6bld5f7Bk+kd2eXsywlgOA4vEdVIU8e3M5YuMj4YniYBn0sMDVFr8JUZftsI9lovIV5my4rvCCSseYHlEICJmcHNPh+qHjg0vSjU1SynFwoANAwEyb9+HDG+LszhgI37tVnR774UXr5aVcgJMVMe5VeTXi939paCr7EVEHuRJizSbtCxS8XHIu0NvO4ty48L7+nKC94rpIvjHrz2RN6C3tfMOpHreBeUwkzHE1YVy9oq0rPJTaEv4Ig/6EAey8fNwlDxjTyTe5xLiTuDIHBKVJLaoWkFRIBywNYswzpxu2Evv3KPe92brG7hvas7F0UYI3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48Ciyy19jNtAmivhw+C+Psdlzh4hSVfrVw03H2J/pxw=;
 b=bILozB11Qv8PXeFc7Fjluh/+yGugUi8dgVjFJ5xFNZ63NOLFbN+HB8lwheqvF3hnGJPaUhdB7ET7hQgYJnMMpGtT6bpPNvPjEhONmgQKYlLwJtGDMOJgO+Jqeb1dAIkqLox+aRh01t+Ew53ea0qYj+TZc+hVP1MKIMEbvh7LrpaYZP+LEulWU8CSydqRUrMqxyTRzfaAY+W72FbJP4Xr+/7UoxfnppN2bRMh58514AjxKWWW8LlVhYYmI6XdRzqU9tVr4nOsbZ/InsVSVExtywvZqM+Dt+JY0zttTbcgWqbJkFiLVQxY2lVbhslb1PhbxoAeYoQiWHaEeH+xFyMG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48Ciyy19jNtAmivhw+C+Psdlzh4hSVfrVw03H2J/pxw=;
 b=c4jqeZiSvZ9H/dE2yYNcEN5e4V3/3JA1vNmxWCOkf2qpYkfQHgNmTwARJtWsh3zUpcVgDTH3FItS5BrppyylEpP+L5SJhm89eVbZgnjjPYob3ncx0KhZ19S0dESD1/QylYlVtalK0Dcr+MQv9eIceT8nwcPvR0Sua2VZs9eZM7w=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH8PR10MB6574.namprd10.prod.outlook.com (2603:10b6:510:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.5; Wed, 23 Sep
 2026 08:47:22 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 08:47:22 +0000
Content-Type: multipart/mixed; boundary="------------q0HEXb7pteemQVcjZBatXGfX"
Message-ID: <3c1247d4-3ef8-427a-8514-51d2cd9aa136@oracle.com>
Date: Wed, 23 Sep 2026 09:47:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump LOC_PARAM,
 LOC_PROTO and LOCSEC
To: Quentin Monnet <qmo@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
        ast@kernel.org, andrii@kernel.org, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
        puranjay@kernel.org, yatsenko@meta.com
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-10-alan.maguire@oracle.com>
 <a53eaf9758d1110ad7a2211b55533ffd470e083f.camel@gmail.com>
 <53e01dce-efdc-4e8f-8510-e23cba17c429@oracle.com>
 <f03d6246dca7a772e44bc31c98e7950d64ee55d3.camel@gmail.com>
 <5af8a42e-ce2f-443c-bdad-2e989dcc1a9b@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <5af8a42e-ce2f-443c-bdad-2e989dcc1a9b@kernel.org>
X-ClientProxiedBy: DO0P289CA0011.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:20::16) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH8PR10MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 64cca8c8-9aa0-4de0-d0b3-08df194f484f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|6049299003|1800799024|4053099003|6133799003|3023799007|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sZEa98keASDyZEm2nVjWJADYqdxGToLm3N88PT1dAA2VY7xZ++tVrGC9NOKa0zOs96IdrL1DLwUOmze9b6yMxy1fYcowj5FlOmwkorvWT+1EZUZ/Resq6rjRT+XecoviESa2jzSg/M9tSnBU67o9FAqaRsxKW5vnQYo15O6VFaPjCerSaigUD6zTU3bk0gzbkAz1qo/Fy0iBMnSzSsRrk8lWWPrvKGMs7r9lHUkv1MTTiAHO/WwY2bRlVLyqvlyZi0xolGXukyM02DEK4c61NVongLQu6wnb5MqOuuOI6yrI3Fpi8eoyoLpAbAsPV3reUKaYQR38Mj0URIPHr3c1tmdhxiXmJLzY75VEFcEm0Lf0iYvSsV1S/sU35e1LLDsucc6YeIP3NRITXE7rM5PKIFXAznWWz2jeSbSYMo+Dl0Etvzs0mLiGQiMg+3w97ARRENbvOPg/lLGNzFJ/GAUsjrqUFYMXRT/tgJ0lco5kaWSBHIiP79FYYfkVGeGFBUPDliBir1lwbp5XoSLGucAR5YRQF/S9yGCF37pQQsyvne+v+vOHGOEu2voGTB+CVZ5dKkBlbegHK/aP72jZQDNblLmQASL6PITcp1++WFr//BVx831eK9ju3FWUxZZaIV5X+kecnumpRz1kNqGvyMICK3XKyZxK65Tkh0IFcofzvQI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(6049299003)(1800799024)(4053099003)(6133799003)(3023799007)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW0wbXpURmxSK2lBUTZYK3o5WllYMzR6V05JQ3podW0yNS9xbFkxTC9pU290?=
 =?utf-8?B?U0dvbnpjS2tiR001RGRiSllVMnJoaXRCMmJXeWp1cEZ3NzZNTXJwVisrckN5?=
 =?utf-8?B?SUtNb3VGaHlTRzJhcVlROWxMKzI0bFpRUlpsbVNYKy9tMXM3cVpuU0tHb0lU?=
 =?utf-8?B?N2h1b0w3Wloxc2Vadlc3dnl2a0R0NTF6VXdvYU55bzl4d1RHY0VhVEdXcU4x?=
 =?utf-8?B?RGJCR0FqVVh6S0tMRk5HbHgvY3h4NDZrWk1hRU9Pb1dlTmZHTjJIK29PUEFw?=
 =?utf-8?B?MmZCNWtycDhTTTZyS3Z4K2xCWFYzZlQ5N3NCSnNTYVhraSs4aWUrVlBGSk04?=
 =?utf-8?B?a3l0R1RTSE0wc0xRdVhLazV5S0JrR1krMXhUYVcrUG81UG5DUGZ1Z2w0aERt?=
 =?utf-8?B?Vkh4RnJ3M3pLS0RBSEZEbDkxb0k1bVdWelI3WVFTRlpiSWhabG5xZHpxaHUx?=
 =?utf-8?B?c01rOHJGNjRHUmNLeHMvV0Q5ZEFtTkZmSVBVL0J6dnkwdjRJcUdZckpzcXJs?=
 =?utf-8?B?OVUyaFpMNGp4elIwYmhUc2tMczhZS3lFMkd6QUZ3Ymx4UE45d1NMNGZqTzI2?=
 =?utf-8?B?eld2ekdES3V6eU5SOG1XZUgvV01SOUJYWDVUMHR6Y2VyUFNZVXZ0K0hmVS9t?=
 =?utf-8?B?VWpUR3NUNnFxV1lmYlpZVVF4cTBHL3FXSnBJamRtaEZOc1Mwc0RHcUFwY3I5?=
 =?utf-8?B?VnRZMzdtZlhlTDAzSEtPdHlOcS9zWE5uWVJLMlNqNHVaZk5JT0xjTEVEMHZh?=
 =?utf-8?B?bWhRdFQySkQ3Q0h4eGFrcEExdFNOM25DT1R6eG1iUnZKQ3JhL1JxWWFnZ3JV?=
 =?utf-8?B?TFdaT1NCcklJVnc2YzlKYll0cGkzYWhIejlJLytIWXJOSnp2eEU0NzFhSTJp?=
 =?utf-8?B?RTk0Si8wcG94TElEaWNtTjNiWkM5dHJkQnJWVU5XM0kxSUlpbTZUOVplN3px?=
 =?utf-8?B?UDl2R1hWeHBZZzZlR0xoWDlKM2xFWXAyMkR1U2txcnNPUm1DSlFKK084SkNK?=
 =?utf-8?B?THRYbXJQbnBTWDM4L1RZWTkyY1ByM25UVUN1MlNUWEdvajJ1N1diMWFFTXVR?=
 =?utf-8?B?b1VUbitoQTMraFVMWkRFeWNuTVBkRURKNFVRVzRhUXJ4RFJORjltTkVQbzNp?=
 =?utf-8?B?d2VERGlVMEQxK2Z6d3VBMXhsaFljTHc3ZXNTSzdxNEtZZEdHNjRwYldOdDln?=
 =?utf-8?B?OVEyQUJCcFBwK0FjUnlCNjJjT3gvUHBXNk1QUVorL2U0dmVmdE1OV2hKdk14?=
 =?utf-8?B?aGkrY2NPS29lKzdwOXZhS25OVm9ralhaVlJqYXAzSURwanlyb3ptS0ExWXdy?=
 =?utf-8?B?V25ONUYvSXMxczlqaWgxbXBCSWNRWU81NCt3Ull6RS8rSWpSMUxMQmkrdDJW?=
 =?utf-8?B?d0ZCVDJydmF2TDVHM1QrK3BwaXZqVTdodGM0Kzh6MDA1Z2loN2tvMzltSzdP?=
 =?utf-8?B?bCtaUk9qUjZLcGVjN2VvdjZ6YkFuUVdReEdJOEFDdEhCVmYySjBNaWhPMllY?=
 =?utf-8?B?ems2WHd0a0xJUWo3NlVWNHRNU3dUTFJqc2NsMGF4WVlxRjVoLy9PRFJoZ1pZ?=
 =?utf-8?B?bkl1bmRHQkV0WG5ONm92SzJjTTMxcmNEcGxtMFZGQkNPYUVRMUVtQlNjbUFX?=
 =?utf-8?B?bUFWNzFLay9iQkNRYzBjdElja1BUaFVTTVprdWNiVzNQaUt2S21pNDhMeWRv?=
 =?utf-8?B?SWlybTBPOEpHdVpyZkpGUSsvNDU2aU5tTk1zNEpVODM0eTRlZ2hWMUVCaWt6?=
 =?utf-8?B?TVZvTXVxNHEyc2t5SEF5TXhnMlJGM3MxcVhtQXNGWlllR0NtL2RUSWp3Q2ZY?=
 =?utf-8?B?bGxhNEtndlNGNXk5SE9QT1ZtRmtvaFYyWWp0VHJKQUdSeTBmQUo3NkZ0cVdk?=
 =?utf-8?B?Z056Q0VCNFl1VjVPek50WnB5Z2FaM3ZhR3M5V1NseUhEeVljRWh6RzJydFJE?=
 =?utf-8?B?VjRqeUcwSWxyV0RwN2VjQWtJMnZoWnpId1Y1SVVERThBVVArd2hVeDBka3Rm?=
 =?utf-8?B?S1NPd0NKR0srVFVoaXpzOTFCT0Z4NExVMnVoNGlYaVh3TlVuQ0FMQTlJUDl4?=
 =?utf-8?B?S0ZpOGJkaHZ1WnhQd2o2SGRNK3h3VXNseTBFZXJONE5GYTBORGVielVtUXVL?=
 =?utf-8?B?bGpGN202S0lTUzZnRTA4OWU3bDN3R0RNYTd4UUxwbkdTZmZ5d3k2TzVGVW4z?=
 =?utf-8?B?ZW5RNFZDeXJYdy83RHRRUjkrZFlIclBsS2xvZlJuZDNDSVFpMTJEVHcwbmJz?=
 =?utf-8?B?OXp2UzV1SllsR2UxWEN6L1FDbzY3cDB4N3dab3h1d1pDVU1UVkVPVW40M0JM?=
 =?utf-8?B?a3A4V3Q5VlFHZGxnTmNsUnhpcHozWmFHWThCVjBnUVRySXNnWWVodz09?=
X-Exchange-RoutingPolicyChecked:
	kySyJCAAGT2XOkh6LjrsH/kXV0aeyXvFAUZQpCKtWYqwhbzag+11+UG7ESED7NuvitvJj0ekoXcHcQo0Ad41ZrsvDdkzkpJY7VFhaMOh91ggnAJEgb3Qs5sIqKUWohqvvKzbgpDBpZ8MyfX0zQPZFtN7QIn9nvIvt6hRsOUIW7nVUsbH3im5asuw9K0NdEw4yyqCjMvGB0uAwf/AGqxEpHpxyfzB3Ph1VhrkADH11nQcDftuGMehOfAE2jdFlnDrbtiXT2Nk0Pt8VgnGWM2ELw+fdgsHQ82bc4dvVHo55bsPHHoAojzxixZ+mH16XamJgpfyhnjeZNrRgYUOa1XUgA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x0W1bLv8EDDpPED0KfrPTMpicCnBtDOAcEC1AHu0v4uF9CKmy+erXOtug/rFFAE25sYYCAX8TeLI8yGRTBG6Bdx2Mv4BAENDJpoGXcRQr7gk3zBEvJtjxJBe6G91qVmZ+BGOTZF6VBDVWRQQYeQavezrHnyPk42K0Ls6kAMf9Pf7JckpvRm0Z7XHDC3gtsZ4h5F5RNHN6mhf8s1szxYF+TG9fAC8pcce4iyLVfxL9Cxna77i80593Au/It4lIjgsOMA/fMaee9HeZ/IOxVK3X0OY4Z4h0h4/zBOIV7ZIUFNrT7i3WlGQq00twh5NXKbso2Wmm6UZ0HtbKN1s0CIzQKFOTJF1HCbDwrK5dUYMYCSyD/R+5cUY8XL43D2eEyN/4fWs7gohcEiAh15gtWmd2MK49XytNUBbeOADR3zGE3l1xikKuhfQzDns4GgLYzISmdJk8ABYvaVkfh3SFPChgmHtKkKibsVlCyZH/YrCi/RAc8VcjjocYOpkBLrcaAgiGpglh1RjzBmWIsn4nthejOLfQhE2wfHMCUglQNxMVSb3Q9/8t3zEAeO+yU9Z1hPi+6MQKLQKuwEn6+EI04XDaOfizQbiNXM51cWRvRraCFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cca8c8-9aa0-4de0-d0b3-08df194f484f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:47:22.0509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJqYDX4rwIdQMFBnd+XBA0jnBaaCrI6HvR2s6W5oJBvvwaEXbKs1dNExRF6xS4206Wr9e2WUh6zKEyKpXtcPTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609230034
X-Authority-Analysis: v=2.4 cv=F/bC5ahN c=1 sm=1 tr=0 ts=6ab39220 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=HVfyyZH2AAAA:20 a=pGLkceISAAAA:8
 a=z1HqrjBihMI3sEiQnTQA:9 a=QEXdDO2ut3YA:10 a=3lBD5H6sjrQK0tRQXkQA:9
 a=B2y7HmGcmWMA:10 a=WmVTiCyuxqgg3mnwYu6p:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfX9pzuC2tEOmZF
 3xCenNzcuA08wrAjdEfxcZxnR/z6TEe3kPoeoKhXocibq2S/PEvFEX+m3M34vW/AS9kv40mou9f
 IjCeWkubXqo2vGuZ5FV2Wfa/eHPztqqBZsWLMPbIqDun+0k3x1a8
X-Proofpoint-ORIG-GUID: 49HMH4QPfWE0ETZKXLohjBPhyxJ4wXCo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfXyTkOSxRUmyMg
 rdzfbeb0xrmCfNBHC7s51aQxYS6tfHocZR5xbmYdMuC7VEhwh2lo/lWIUzZdC5GML7rlMzE7ym9
 1lu8do7HtD6UquMtBCvqfa+tI9kJkq4sDCg6s5GVAaBZ8S/YzvRHde221TnvuOBRyI9pCXqwgGY
 n2FmsWQZ7rKWWX7LJwBrpSLUCuSN9jTCQiugijraRVw//xQyFVbKfOvZSNgRDq01TXz+YSBHtgd
 sZ6dh/N2PQJpUoqTbzpGx5iUZU21mGb/kjnqBfSpC1YsyQMl64+wIx1Wc1krJ43ZqcEUuKaUFXj
 6/1XXKKf09HwymGDUDk79nfFrf28/8MJpCFtugCPrEOSelQVNnhhhb5/JMRgRY+axNmLGutLdZE
 jIqpv4Xc6v+XXm7hucnXlzlSoK/x5UbXAguqase0WQjtTXXXrp//eDfFh1sB6dnaNUSwEVrrnMe
 Me3vKLGYyN/hzc1edQw==
X-Proofpoint-GUID: 49HMH4QPfWE0ETZKXLohjBPhyxJ4wXCo

--------------q0HEXb7pteemQVcjZBatXGfX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/09/2026 12:59, Quentin Monnet wrote:
> 2026-09-21 14:46 UTC-0700 ~ Eduard Zingerman <eddyz87@gmail.com>
>> On Mon, 2026-09-21 at 19:47 +0100, Alan Maguire wrote:
>>> On 18/09/2026 21:51, Eduard Zingerman wrote:
>>>> On Wed, 2026-09-16 at 08:41 +0100, Alan Maguire wrote:
>>>>
>>>> ...
>>>>
>>>>> +static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
>>>>> +{
>>>>> +	const struct btf_loc_param *p;
>>>>> +	__u32 i = 0, vlen;
>>>>> +	__u64 value;
>>>>> +	bool negative = false;
>>>>> +	char regs[32] = {};
>>>>> +	char num[32] = {};
>>>>> +	const char *op = "";
>>>>> +
>>>>> +	if (!t || !btf_is_loc_param(t)) {
>>>>> +		snprintf(str, sz, "<invalid>");
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	p = btf_loc_param(t);
>>>>> +	vlen = btf_vlen(t);
>>>>> +
>>>>> +	if (p->flags & BTF_LOC_PARAM_REG) {
>>>>> +		__u32 nregs = (p->flags == BTF_LOC_PARAM_REG) ? vlen : 1;
>>>>> +
>>>>> +		if (nregs > vlen) {
>>>>> +			snprintf(str, sz, "?");
>>>>> +			return;
>>>>> +		}
>>>>> +
>>>>> +		switch (nregs) {
>>>>> +		case 2:
>>>>> +			snprintf(regs, sizeof(regs), "r%u, r%u",
>>>>> +				 p->values[0], p->values[1]);
>>>>
>>>> I agree with Jiri regarding the register names. It's not a huge table,
>>>> e.g. [1], 20 lines for x86 ~> 100-200 lines that would not really
>>>> change to handle all architectures that have BPF jits.
>>>> And it would be very convenient for those using the tool.
>>>>
>>>
>>> Yeah, it's doable, it's just that it is more portable when done in
>>> pfunct; we can use dwfl interface to get register names [1]. With
>>> pfunct changes in that tree we get output that is either arch-independent
>>> (standalone BTF) or when combined with ELF info from vmlinux
>>> gives us the arch-specific register names, containing function etc.
>>> To see the inline site for ip_send_skb for example:
>>>
>>> $ pfunct --inline_sites -f ip_send_skb --elf vmlinux /sys/kernel/btf/vmlinux.inline
>>> 0xffffffff8201f241 [ip_push_pending_frames+0x31, .text +0x101f241] ip_send_skb(struct net * net [%rbx], struct sk_buff * skb [%rax])
>>>
>>> (above does not need DWARF at all, just BTF + ELF info, so will work with a
>>> debuginfo-stripped vmlinux)
>>>
>>> So for me the tool to reach for in understanding the raw BTF is
>>> bpftool, whereas to apply the arch-specific transformations, locate the
>>> absolute addresses etc I'd use pfunct. But that's just me; I'm happy to
>>> go with the consensus here. Given the current library support, I think
>>> maintaining per-arch tables in bpftool (rather than introducing a new
>>> library dependency) would be the way to go if we do add it.
>>>
>>> Quentin, what do you think? Are per-arch tables for registers in bpftool
>>> ok from your side? Thanks!
>>>
>>> Alan
>>>
>>> [1] https://github.com/alan-maguire/dwarves/blob/0da899665b04f16c3f68c0b736834a15e045c3c9/pfunct.c#L95
>>
>> Adding dwfl as an (optional?) dependency for bpftool and reusing the
>> same code as [1] might be an option as well.
>>
>> ...
> 
> 
> If we decide to go with arch-specific transformation, I think I'd rather
> go with local tables rather than adding a dependency, unless it turns
> out to be necessary. But Alan's argument makes sense to me, bpftool
> prints the literal BTF encoding, and resolving to per-arch instructions
> is probably best left to pfunct.
> 

Thanks Quentin! To investigate I implemented the table for i386, x86_64,
aarch64 and s390 (attached). So while it is technically straightforward
what I realized however is that we have to make an architecture
choice that isn't available from /sys/kernel/btf data directly. So we
are stuck using the arch bpftool has been compiled to (unless we add
another parameter to pass to bpftool raw dump). So while "use the same
arch as bpftool" is likely often the right answer, we might sometimes 
want to examine raw BTF for another architecture. That feels to me like
an argument for more neutral raw output too.

I've updated pfunct a bit to handle a few situations

- raw BTF only; no reg interpretation, no absolute address resolution
- raw BTF + --elf file option ; adds per-arch reg interpretation, containing function and
absolute address resolution
- raw BTF + --running option ; uses reg interpretation, kallsyms/module data 
to do address and containing function resolution that is kASLR-friendly

So the logical split is bpftool tells me what the BTF is; pfunct tells
me what it means in the context of the associated ELF file or running kernel.

Anyway we can go either way, but FWIW my vote is to keep bpftool
arch-neutral. Thanks!

Alan
--------------q0HEXb7pteemQVcjZBatXGfX
Content-Type: text/x-patch; charset=UTF-8;
 name="0009-bpftool-Add-ability-to-dump-LOC_PARAM-LOC_PROTO-and-.patch"
Content-Disposition: attachment;
 filename*0="0009-bpftool-Add-ability-to-dump-LOC_PARAM-LOC_PROTO-and-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyOTI5YTg5NGVmZmY0ZTYwYmU1YzcxMjM0NWUzNmRjMTZiZGQyYjdlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGFuIE1hZ3VpcmUgPGFsYW4ubWFndWlyZUBvcmFjbGUuY29t
PgpEYXRlOiBUaHUsIDE4IFNlcCAyMDI1IDA5OjE5OjA0ICswMDAwClN1YmplY3Q6IFtQQVRDSCB2
NCBicGYtbmV4dCAwOS8xMV0gYnBmdG9vbDogQWRkIGFiaWxpdHkgdG8gZHVtcCBMT0NfUEFSQU0s
CiBMT0NfUFJPVE8gYW5kIExPQ1NFQwoKSW4gcmF3IG1vZGUgZW5zdXJlIHdlIGNhbiBkdW1wIG5l
dyBCVEYga2luZHMgaW4gbm9ybWFsL2pzb24gZm9ybWF0LgpCVEZfS0lORF9MT0NfUEFSQU1zIGFy
ZSByZW5kZXJlZCBhcyBzdHJpbmdzLCBmb3IgZXhhbXBsZSBhCmNvbnN0IHZhbHVlIG9mIDB4MmEg
YW5kIGEgZGVyZWZlcmVuY2Ugb2YgJXIxMCArIDB4MjA6CgogIFsxMl0gTE9DX1BBUkFNICcoYW5v
biknIHNpemU9NCBmbGFncz0weDIgdmxlbj0xIHZhbHVlcz0nMHgyYScKICBbMTNdIExPQ19QQVJB
TSAnKGFub24pJyBzaXplPTggZmxhZ3M9MHgzOCB2bGVuPTIgdmFsdWVzPScqKCVyMTAgKyAweDIw
KScKCkxPQ19QUk9UT3MgcmVuZGVyIHRoZSBhc3NvY2lhdGVkIHZhbHVlcyBvZiBlYWNoIG9mIHRo
ZWlyCkxPQ19QQVJBTXMgZm9yIGVhc2llciByZWFkYWJpbGl0eToKCiAgWzE0XSBMT0NfUFJPVE8g
Jyhhbm9uKScgdmxlbj0yCiAgCXR5cGVfaWQ9MTIgdmFsdWU9JzB4MmEnCiAgCXR5cGVfaWQ9MTMg
dmFsdWU9JyooJXIxMCArIDB4MjApJwoKYW5kIExPQ1NFQyBzaG93cyBmdW5jdGlvbiBuYW1lIGFz
c29jaWF0ZWQgd2l0aCBzaXRlOgoKICBbMTVdIExPQ1NFQyAnaW5saW5lLnRleHQnIHZsZW49MQog
IAluYW1lPSdmb28nIGZ1bmNfdHlwZV9pZD01IGxvY19wcm90b190eXBlX2lkPTE0IG9mZnNldD02
NAoKUmVnaXN0ZXJzIGFyZSBkaXNwbGF5ZWQgYXMgdGhlaXIgYXJjaC1zcGVjaWZpYyBEV19PUF9y
ZWcqCmVxdWl2YWxlbnRzIHdoZXJlIGF2YWlsYWJsZS4KClNpZ25lZC1vZmYtYnk6IEFsYW4gTWFn
dWlyZSA8YWxhbi5tYWd1aXJlQG9yYWNsZS5jb20+Ci0tLQogdG9vbHMvYnBmL2JwZnRvb2wvYnRm
LmMgfCAyNjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxl
IGNoYW5nZWQsIDI2NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdG9vbHMvYnBmL2JwZnRv
b2wvYnRmLmMgYi90b29scy9icGYvYnBmdG9vbC9idGYuYwppbmRleCA2NWU4YTI5Mjc3ZTYuLjM4
NGZlZjJkYWRmZiAxMDA2NDQKLS0tIGEvdG9vbHMvYnBmL2JwZnRvb2wvYnRmLmMKKysrIGIvdG9v
bHMvYnBmL2JwZnRvb2wvYnRmLmMKQEAgLTI5LDYgKzI5LDQwIEBACiAKICNkZWZpbmUgTUFYX1JP
T1RfSURTCQkxNgogI2RlZmluZSBNQVhfQlRGX0ZJTEVTCQk2NAorI2RlZmluZSBNQVhfTE9DX1BB
UkFNX1dPUkRTCTgKKworLyogRFdBUkYgcmVnaXN0ZXIgbnVtYmVycyB1c2VkIGJ5IEJURl9LSU5E
X0xPQ19QQVJBTS4gKi8KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCitzdGF0aWMgY29uc3QgY2hh
ciAqIGNvbnN0IGJ0Zl9kd2FyZl9yZWdfbmFtZXNbXSA9IHsKKwkicmF4IiwgInJkeCIsICJyY3gi
LCAicmJ4IiwgInJzaSIsICJyZGkiLCAicmJwIiwgInJzcCIsCisJInI4IiwgInI5IiwgInIxMCIs
ICJyMTEiLCAicjEyIiwgInIxMyIsICJyMTQiLCAicjE1IiwgInJpcCIsCit9OworI2VsaWYgZGVm
aW5lZChfX2kzODZfXykKK3N0YXRpYyBjb25zdCBjaGFyICogY29uc3QgYnRmX2R3YXJmX3JlZ19u
YW1lc1tdID0geworCSJlYXgiLCAiZWN4IiwgImVkeCIsICJlYngiLCAiZXNwIiwgImVicCIsICJl
c2kiLCAiZWRpIiwgImVpcCIsCit9OworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKK3N0YXRp
YyBjb25zdCBjaGFyICogY29uc3QgYnRmX2R3YXJmX3JlZ19uYW1lc1tdID0geworCSJ4MCIsICJ4
MSIsICJ4MiIsICJ4MyIsICJ4NCIsICJ4NSIsICJ4NiIsICJ4NyIsCisJIng4IiwgIng5IiwgIngx
MCIsICJ4MTEiLCAieDEyIiwgIngxMyIsICJ4MTQiLCAieDE1IiwKKwkieDE2IiwgIngxNyIsICJ4
MTgiLCAieDE5IiwgIngyMCIsICJ4MjEiLCAieDIyIiwgIngyMyIsCisJIngyNCIsICJ4MjUiLCAi
eDI2IiwgIngyNyIsICJ4MjgiLCAieDI5IiwgImxyIiwgInNwIiwKK307CisjZWxpZiBkZWZpbmVk
KF9fczM5MHhfXykgfHwgZGVmaW5lZChfX3MzOTBfXykKK3N0YXRpYyBjb25zdCBjaGFyICogY29u
c3QgYnRmX2R3YXJmX3JlZ19uYW1lc1tdID0geworCSJyMCIsICJyMSIsICJyMiIsICJyMyIsICJy
NCIsICJyNSIsICJyNiIsICJyNyIsCisJInI4IiwgInI5IiwgInIxMCIsICJyMTEiLCAicjEyIiwg
InIxMyIsICJyMTQiLCAicjE1IiwKKwkiZjAiLCAiZjIiLCAiZjQiLCAiZjYiLCAiZjEiLCAiZjMi
LCAiZjUiLCAiZjciLAorCSJmOCIsICJmMTAiLCAiZjEyIiwgImYxNCIsICJmOSIsICJmMTEiLCAi
ZjEzIiwgImYxNSIsCisJImMwIiwgImMxIiwgImMyIiwgImMzIiwgImM0IiwgImM1IiwgImM2Iiwg
ImM3IiwKKwkiYzgiLCAiYzkiLCAiYzEwIiwgImMxMSIsICJjMTIiLCAiYzEzIiwgImMxNCIsICJj
MTUiLAorCSJhMCIsICJhMSIsICJhMiIsICJhMyIsICJhNCIsICJhNSIsICJhNiIsICJhNyIsCisJ
ImE4IiwgImE5IiwgImExMCIsICJhMTEiLCAiYTEyIiwgImExMyIsICJhMTQiLCAiYTE1IiwKKwki
cHN3bSIsICJwc3dhIiwKK307CisjZWxzZQorc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBidGZf
ZHdhcmZfcmVnX25hbWVzW10gPSB7fTsKKyNlbmRpZgogCiBzdGF0aWMgY29uc3QgY2hhciAqIGNv
bnN0IGJ0Zl9raW5kX3N0cltOUl9CVEZfS0lORFNdID0gewogCVtCVEZfS0lORF9VTktOXQkJPSAi
VU5LTk9XTiIsCkBAIC01MSw2ICs4NSw5IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgYnRm
X2tpbmRfc3RyW05SX0JURl9LSU5EU10gPSB7CiAJW0JURl9LSU5EX0RFQ0xfVEFHXQk9ICJERUNM
X1RBRyIsCiAJW0JURl9LSU5EX1RZUEVfVEFHXQk9ICJUWVBFX1RBRyIsCiAJW0JURl9LSU5EX0VO
VU02NF0JPSAiRU5VTTY0IiwKKwlbQlRGX0tJTkRfTE9DX1BBUkFNXQk9ICJMT0NfUEFSQU0iLAor
CVtCVEZfS0lORF9MT0NfUFJPVE9dCT0gIkxPQ19QUk9UTyIsCisJW0JURl9LSU5EX0xPQ1NFQ10J
PSAiTE9DU0VDIiwKIH07CiAKIHN0cnVjdCBzb3J0X2RhdHVtIHsKQEAgLTExNyw2ICsxNTQsMTQ0
IEBAIHN0YXRpYyBpbnQgYnRmX2tpbmRfc2FmZShpbnQga2luZCkKIAlyZXR1cm4ga2luZCA8PSBC
VEZfS0lORF9NQVggPyBraW5kIDogQlRGX0tJTkRfVU5LTjsKIH0KIAorc3RhdGljIHZvaWQgYnRm
X2xvY19wYXJhbV9yZWdfc3RyKF9fdTMyIHJlZywgY2hhciAqc3RyLCBzaXplX3Qgc3opCit7CisJ
Y29uc3QgY2hhciAqbmFtZSA9IE5VTEw7CisKKwlpZiAocmVnIDwgQVJSQVlfU0laRShidGZfZHdh
cmZfcmVnX25hbWVzKSkKKwkJbmFtZSA9IGJ0Zl9kd2FyZl9yZWdfbmFtZXNbcmVnXTsKKwlpZiAo
bmFtZSkKKwkJc25wcmludGYoc3RyLCBzeiwgIiUlJXMiLCBuYW1lKTsKKwllbHNlCisJCXNucHJp
bnRmKHN0ciwgc3osICJyJXUiLCByZWcpOworfQorCitzdGF0aWMgdm9pZCBidGZfbG9jX3BhcmFt
X3Jhd19zdHIoY29uc3Qgc3RydWN0IGJ0Zl9sb2NfcGFyYW0gKnAsIF9fdTMyIHZsZW4sCisJCQkJ
ICBjaGFyICpzdHIsIHNpemVfdCBzeikKK3sKKwlfX3UzMiBpLCBucl93b3JkcyA9IG1pbih2bGVu
LCAoX191MzIpTUFYX0xPQ19QQVJBTV9XT1JEUyk7CisJc2l6ZV90IG9mZiA9IDA7CisKKwlpZiAo
IXN6KQorCQlyZXR1cm47CisKKwlvZmYgKz0gc25wcmludGYoc3RyICsgb2ZmLCBzeiAtIG9mZiwg
InJhdz1bIik7CisJZm9yIChpID0gMDsgaSA8IG5yX3dvcmRzICYmIG9mZiA8IHN6OyBpKyspCisJ
CW9mZiArPSBzbnByaW50ZihzdHIgKyBvZmYsIHN6IC0gb2ZmLCAiJXMweCUwOHgiLAorCQkJCWkg
PyAiLCAiIDogIiIsIHAtPnZhbHVlc1tpXSk7CisJaWYgKHZsZW4gPiBucl93b3JkcyAmJiBvZmYg
PCBzeikKKwkJb2ZmICs9IHNucHJpbnRmKHN0ciArIG9mZiwgc3ogLSBvZmYsICIsIC4uLiIpOwor
CWlmIChvZmYgPCBzeikKKwkJc25wcmludGYoc3RyICsgb2ZmLCBzeiAtIG9mZiwgIl0iKTsKK30K
Kworc3RhdGljIHZvaWQgYnRmX2xvY19wYXJhbV9zdHIoY29uc3Qgc3RydWN0IGJ0Zl90eXBlICp0
LCBjaGFyICpzdHIsIHNpemVfdCBzeikKK3sKKwljb25zdCBzdHJ1Y3QgYnRmX2xvY19wYXJhbSAq
cDsKKwlfX3UzMiBpID0gMCwgdmxlbjsKKwlfX3U2NCB2YWx1ZTsKKwlfX3UzMiB2YWx1ZV9zaXpl
OworCWJvb2wgbmVnYXRpdmUgPSBmYWxzZTsKKwljaGFyIHJlZ3NbMzJdID0ge307CisJY2hhciBu
dW1bMzJdID0ge307CisJY29uc3QgY2hhciAqb3AgPSAiIjsKKworCWlmICghdCB8fCAhYnRmX2lz
X2xvY19wYXJhbSh0KSkgeworCQlzbnByaW50ZihzdHIsIHN6LCAiPGludmFsaWQ+Iik7CisJCXJl
dHVybjsKKwl9CisKKwlwID0gYnRmX2xvY19wYXJhbSh0KTsKKwl2bGVuID0gYnRmX3ZsZW4odCk7
CisKKwlpZiAocC0+ZmxhZ3MgJiBCVEZfTE9DX1BBUkFNX1JFRykgeworCQlfX3UzMiBucmVncyA9
IChwLT5mbGFncyA9PSBCVEZfTE9DX1BBUkFNX1JFRykgPyB2bGVuIDogMTsKKworCQlpZiAobnJl
Z3MgPiB2bGVuKSB7CisJCQlidGZfbG9jX3BhcmFtX3Jhd19zdHIocCwgdmxlbiwgc3RyLCBzeik7
CisJCQlyZXR1cm47CisJCX0KKworCQlzd2l0Y2ggKG5yZWdzKSB7CisJCWNhc2UgMjoKKwkJCWJ0
Zl9sb2NfcGFyYW1fcmVnX3N0cihwLT52YWx1ZXNbMF0sIHJlZ3MsIHNpemVvZihyZWdzKSk7CisJ
CQlzbnByaW50ZihyZWdzICsgc3RybGVuKHJlZ3MpLCBzaXplb2YocmVncykgLSBzdHJsZW4ocmVn
cyksCisJCQkJICIsICIpOworCQkJYnRmX2xvY19wYXJhbV9yZWdfc3RyKHAtPnZhbHVlc1sxXSwK
KwkJCQkJICAgICAgcmVncyArIHN0cmxlbihyZWdzKSwKKwkJCQkJICAgICAgc2l6ZW9mKHJlZ3Mp
IC0gc3RybGVuKHJlZ3MpKTsKKwkJCWJyZWFrOworCQljYXNlIDE6CisJCQlpZiAocC0+dmFsdWVz
WzBdID09IEJURl9MT0NfUEFSQU1fRkJSRUcpCisJCQkJc25wcmludGYocmVncywgc2l6ZW9mKHJl
Z3MpLCAiZmJyZWciKTsKKwkJCWVsc2UKKwkJCQlidGZfbG9jX3BhcmFtX3JlZ19zdHIocC0+dmFs
dWVzWzBdLCByZWdzLCBzaXplb2YocmVncykpOworCQkJYnJlYWs7CisJCWRlZmF1bHQ6CisJCQli
dGZfbG9jX3BhcmFtX3Jhd19zdHIocCwgdmxlbiwgc3RyLCBzeik7CisJCQlyZXR1cm47CisJCX0K
KwkJaSArPSBucmVnczsKKwl9CisJaWYgKHAtPmZsYWdzICYgKEJURl9MT0NfUEFSQU1fQ09OU1R8
QlRGX0xPQ19QQVJBTV9PRkZTRVQpKSB7CisJCXN3aXRjaCAodmxlbiAtIGkpIHsKKwkJY2FzZSAx
OgorCQkJdmFsdWVfc2l6ZSA9IHNpemVvZihwLT52YWx1ZXNbMF0pOworCQkJdmFsdWUgPSBwLT52
YWx1ZXNbaV07CisJCQlicmVhazsKKwkJY2FzZSAyOgorCQkJdmFsdWVfc2l6ZSA9IDIgKiBzaXpl
b2YocC0+dmFsdWVzWzBdKTsKKwkJCXZhbHVlID0gKChfX3U2NClwLT52YWx1ZXNbaSArIDFdIDw8
IDMyKSB8IHAtPnZhbHVlc1tpXTsKKwkJCWJyZWFrOworCQlkZWZhdWx0OgorCQkJYnRmX2xvY19w
YXJhbV9yYXdfc3RyKHAsIHZsZW4sIHN0ciwgc3opOworCQkJcmV0dXJuOworCQl9CisJCWkgPSB2
bGVuOworCQlpZiAocC0+ZmxhZ3MgJiBCVEZfTE9DX1BBUkFNX1NJR05FRCkgeworCQkJLyoKKwkJ
CSAqIHNpemUgZGVzY3JpYmVzIHRoZSByZXByZXNlbnRlZCBwYXJhbWV0ZXIsIHNvIGl0CisJCQkg
KiBkZXNjcmliZXMgYSBjb25zdGFudCdzIHNpZ25lZCB3aWR0aC4gQW4gb2Zmc2V0CisJCQkgKiBp
cyBkZXRlcm1pbmVkIGJ5IGl0cyB2YWx1ZSB3b3JkcyBhZnRlciB0aGUgcmVnaXN0ZXIKKwkJCSAq
IG51bWJlci4KKwkJCSAqLworCQkJX191MzIgc2l6ZSA9IHAtPmZsYWdzICYgQlRGX0xPQ19QQVJB
TV9PRkZTRVQgPworCQkJCSAgICAgdmFsdWVfc2l6ZSA6IHQtPnNpemU7CisJCQlfX3UzMiBiaXRz
ID0gc2l6ZSAqIDg7CisKKwkJCS8qCisJCQkgKiBTaW5jZSB3ZSByZXByZXNlbnQgY29uc3RhbnQg
dmFsdWVzIGluIGhleCwgd2UKKwkJCSAqIG5lZWQgdG8gZGV0ZXJtaW5lIGlmIHRoZSB2YWx1ZSBp
cyBuZWdhdGl2ZSBzbworCQkJICogd2UgY2FuIHByZXBlbmQgYSAiLSIsIGFuZCBhbHNvIGZpeCB0
aGUgdmFsdWUKKwkJCSAqIHRvIGJlIHBvc2l0aXZlIHNvIHdlIGNhbiBoYXZlIC0gMHg8dmFsdWU+
LgorCQkJICovCisJCQlpZiAoc2l6ZSAmJiBzaXplIDw9IHNpemVvZih2YWx1ZSkpIHsKKwkJCQlp
ZiAoc2l6ZSA8IHNpemVvZih2YWx1ZSkpCisJCQkJCXZhbHVlICY9ICgxVUxMIDw8IGJpdHMpIC0g
MTsKKwkJCQluZWdhdGl2ZSA9IHZhbHVlICYgKDFVTEwgPDwgKGJpdHMgLSAxKSk7CisJCQkJaWYg
KG5lZ2F0aXZlKQorCQkJCQl2YWx1ZSA9IHNpemUgPT0gc2l6ZW9mKHZhbHVlKSA/IC12YWx1ZSA6
CisJCQkJCQkoMVVMTCA8PCBiaXRzKSAtIHZhbHVlOworCQkJfQorCQl9CisJCXNucHJpbnRmKG51
bSwgc2l6ZW9mKG51bSksICIweCVsbHglcyIsICh1bnNpZ25lZCBsb25nIGxvbmcpdmFsdWUsCisJ
CQkgcC0+ZmxhZ3MgJiBCVEZfTE9DX1BBUkFNX0FERFIgPyAiIChhZGRyKSIgOiAiIik7CisJfQor
CWlmIChpICE9IHZsZW4pIHsKKwkJYnRmX2xvY19wYXJhbV9yYXdfc3RyKHAsIHZsZW4sIHN0ciwg
c3opOworCQlyZXR1cm47CisJfQorCWlmIChudW1bMF0pCisJCW9wID0gcmVnc1swXSA/IChuZWdh
dGl2ZSA/ICIgLSAiIDogIiArICIpIDogbmVnYXRpdmUgPyAiLSIgOiAiIjsKKworCXNucHJpbnRm
KHN0ciwgc3osICIlcyVzJXMlcyVzIiwKKwkJIHAtPmZsYWdzICYgQlRGX0xPQ19QQVJBTV9ERVJF
RiA/ICIqKCIgOiAiIiwKKwkJIHJlZ3MsCisJCSBvcCwKKwkJIG51bSwKKwkJIHAtPmZsYWdzICYg
QlRGX0xPQ19QQVJBTV9ERVJFRiA/ICIpIiA6ICIiKTsKK30KKwogc3RhdGljIGludCBkdW1wX2J0
Zl90eXBlKGNvbnN0IHN0cnVjdCBidGYgKmJ0ZiwgX191MzIgaWQsCiAJCQkgY29uc3Qgc3RydWN0
IGJ0Zl90eXBlICp0KQogewpAQCAtNDE1LDYgKzU5MCw5NSBAQCBzdGF0aWMgaW50IGR1bXBfYnRm
X3R5cGUoY29uc3Qgc3RydWN0IGJ0ZiAqYnRmLCBfX3UzMiBpZCwKIAkJfQogCQlicmVhazsKIAl9
CisJY2FzZSBCVEZfS0lORF9MT0NfUEFSQU06IHsKKwkJY29uc3Qgc3RydWN0IGJ0Zl9sb2NfcGFy
YW0gKnAgPSBidGZfbG9jX3BhcmFtKHQpOworCQlfX3UzMiB2bGVuID0gYnRmX3ZsZW4odCk7CisJ
CWNoYXIgcGFyYW1fc3RyWzI1Nl0gPSB7fTsKKworCQlidGZfbG9jX3BhcmFtX3N0cih0LCBwYXJh
bV9zdHIsIHNpemVvZihwYXJhbV9zdHIpKTsKKworCQlpZiAoanNvbl9vdXRwdXQpIHsKKwkJCWpz
b253X3VpbnRfZmllbGQodywgInNpemUiLCB0LT5zaXplKTsKKwkJCWpzb253X3VpbnRfZmllbGQo
dywgImZsYWdzIiwgcC0+ZmxhZ3MpOworCQkJanNvbndfdWludF9maWVsZCh3LCAidmxlbiIsIHZs
ZW4pOworCQkJanNvbndfc3RyaW5nX2ZpZWxkKHcsICJ2YWx1ZXMiLCBwYXJhbV9zdHIpOworCQl9
IGVsc2UgeworCQkJcHJpbnRmKCIgc2l6ZT0ldSBmbGFncz0weCV4IHZsZW49JXUgdmFsdWVzPScl
cyciLAorCQkJICAgICAgIHQtPnNpemUsIHAtPmZsYWdzLCB2bGVuLCBwYXJhbV9zdHIpOworCQl9
CisJCWJyZWFrOworCX0KKwljYXNlIEJURl9LSU5EX0xPQ19QUk9UTzogeworCQlfX3UzMiAqcGFy
YW1zID0gYnRmX2xvY19wcm90b19wYXJhbXModCk7CisJCV9fdTMyIGksIHZsZW4gPSBidGZfdmxl
bih0KTsKKworCQlpZiAoanNvbl9vdXRwdXQpIHsKKwkJCWpzb253X3VpbnRfZmllbGQodywgInZs
ZW4iLCB2bGVuKTsKKwkJCWpzb253X25hbWUodywgInBhcmFtcyIpOworCQkJanNvbndfc3RhcnRf
YXJyYXkodyk7CisJCX0gZWxzZSB7CisJCQlwcmludGYoIiB2bGVuPSV1Iiwgdmxlbik7CisJCX0K
KworCQlmb3IgKGkgPSAwOyBpIDwgdmxlbjsgaSsrLCBwYXJhbXMrKykgeworCQkJY29uc3Qgc3Ry
dWN0IGJ0Zl90eXBlICpwOworCQkJY2hhciBwYXJhbV9zdHJbMjU2XSA9IHt9OworCisJCQlpZiAo
KnBhcmFtcykgeworCQkJCXAgPSBidGZfX3R5cGVfYnlfaWQoYnRmLCAqcGFyYW1zKTsKKwkJCQli
dGZfbG9jX3BhcmFtX3N0cihwLCBwYXJhbV9zdHIsIHNpemVvZihwYXJhbV9zdHIpKTsKKwkJCX0g
ZWxzZSB7CisJCQkJc25wcmludGYocGFyYW1fc3RyLCBzaXplb2YocGFyYW1fc3RyKSwgIjx1bmF2
YWlsYWJsZT4iKTsKKwkJCX0KKwkJCWlmIChqc29uX291dHB1dCkgeworCQkJCWpzb253X3N0YXJ0
X29iamVjdCh3KTsKKwkJCQlqc29ud191aW50X2ZpZWxkKHcsICJ0eXBlX2lkIiwgKnBhcmFtcyk7
CisJCQkJanNvbndfc3RyaW5nX2ZpZWxkKHcsICJ2YWx1ZSIsIHBhcmFtX3N0cik7CisJCQkJanNv
bndfZW5kX29iamVjdCh3KTsKKwkJCX0gZWxzZSB7CisJCQkJcHJpbnRmKCJcblx0dHlwZV9pZD0l
dSB2YWx1ZT0nJXMnIiwgKnBhcmFtcywgcGFyYW1fc3RyKTsKKwkJCX0KKwkJfQorCQlpZiAoanNv
bl9vdXRwdXQpCisJCQlqc29ud19lbmRfYXJyYXkodyk7CisJCWJyZWFrOworCX0KKworCWNhc2Ug
QlRGX0tJTkRfTE9DU0VDOiB7CisJCXN0cnVjdCBidGZfbG9jICpsb2NzID0gYnRmX2xvY3NlY19s
b2NzKHQpOworCQlfX3UzMiBpLCB2bGVuID0gYnRmX3ZsZW4odCk7CisKKwkJaWYgKGpzb25fb3V0
cHV0KSB7CisJCQlqc29ud191aW50X2ZpZWxkKHcsICJ2bGVuIiwgdmxlbik7CisJCQlqc29ud19u
YW1lKHcsICJsb2NzIik7CisJCQlqc29ud19zdGFydF9hcnJheSh3KTsKKwkJfSBlbHNlIHsKKwkJ
CXByaW50ZigiIHZsZW49JXUiLCB2bGVuKTsKKwkJfQorCisJCWZvciAoaSA9IDA7IGkgPCB2bGVu
OyBpKyssIGxvY3MrKykgeworCQkJY29uc3Qgc3RydWN0IGJ0Zl90eXBlICpmID0gYnRmX190eXBl
X2J5X2lkKGJ0ZiwgbG9jcy0+ZnVuYyk7CisJCQljb25zdCBjaGFyICpuYW1lID0gIjxpbnZhbGlk
PiI7CisKKwkJCWlmIChmICYmIGJ0Zl9pc19mdW5jKGYpKQorCQkJCW5hbWUgPSBidGZfc3RyKGJ0
ZiwgZi0+bmFtZV9vZmYpOworCisJCQlpZiAoanNvbl9vdXRwdXQpIHsKKwkJCQlqc29ud19zdGFy
dF9vYmplY3Qodyk7CisJCQkJanNvbndfdWludF9maWVsZCh3LCAiZnVuY190eXBlX2lkIiwgbG9j
cy0+ZnVuYyk7CisJCQkJanNvbndfc3RyaW5nX2ZpZWxkKHcsICJuYW1lIiwgbmFtZSk7CisJCQkJ
anNvbndfdWludF9maWVsZCh3LCAibG9jX3Byb3RvX3R5cGVfaWQiLCBsb2NzLT5sb2NfcHJvdG8p
OworCQkJCWpzb253X3VpbnRfZmllbGQodywgIm9mZnNldCIsIGxvY3MtPm9mZnNldCk7CisJCQkJ
anNvbndfZW5kX29iamVjdCh3KTsKKwkJCX0gZWxzZSB7CisJCQkJcHJpbnRmKCJcblx0bmFtZT0n
JXMnIGZ1bmNfdHlwZV9pZD0ldSBsb2NfcHJvdG9fdHlwZV9pZD0ldSBvZmZzZXQ9JXUiLAorCQkJ
CSAgICAgICBuYW1lLCBsb2NzLT5mdW5jLCBsb2NzLT5sb2NfcHJvdG8sIGxvY3MtPm9mZnNldCk7
CisJCQl9CisJCX0KKwkJaWYgKGpzb25fb3V0cHV0KQorCQkJanNvbndfZW5kX2FycmF5KHcpOwor
CQlicmVhazsKKwl9CiAJZGVmYXVsdDoKIAkJYnJlYWs7CiAJfQotLSAKMi40My41Cgo=

--------------q0HEXb7pteemQVcjZBatXGfX--
