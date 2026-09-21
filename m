Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F524FC331
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015841; cv=fail; b=GhK8Ew5k4ucijidm4QuewKeG3/eNk+XgWEbU3+AoxRBDSQJddyK7+M15FlhHLBEHiQZkTtAUT8CbpZiA7HAIhp2ggJGWxc1FDPBEghBYa1Zu03joD2KybSDW/l7nQji6ZImbiaHonNhT81aDDIxb5BdXKeSdbaVkC3aYyrpcnQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015841; c=relaxed/simple;
	bh=DnZj4/gRIYZTyC2ROY4QIDhcl6Rky+MvfT3nlOZzIXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LBX7k7Y1deT3dSw19barL3Ymo42PZAz8KSRyalXGv635D2iiFz1fVP4g6BYc8EyGUzxKVvj4Gvn7P0K2FoikpYGbeGq+z0vvCiXlMpFNFWhsuY/OCH3hGvQfNT4UkhWIxGcxEUQe2fT6zjyQMw5J/jLGPTQ4EvM4RhXhJWjj/EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CepEs5cU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hib9CfOL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CepEs5cU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hib9CfOL"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LDts8e3254258;
	Mon, 21 Sep 2026 18:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rEJivcvZ6ftjqE8B0ymwezs2wmGuwi3zrdR5ETzrOVs=; b=
	CepEs5cUQRbmt8i4W2d/d6RXSZ82V9aV08YbzGGaxde5g55fiSmoVorKo+7ZMlS3
	9iZb+AX9GwDe8NdUMMl/Td9BPhb7UPCDSE6TCfEWkcmbq0BwYidpN/gvyuJqu0i+
	d808e1oFk3AqEfhojyPUF8G73a/wxIgrm29vZ2XzCPgHXSiG0rIUgYy3eNpFeVQO
	UJeh4P5yLMRWkR13S2CnaTEU/pO/F7g/eh/XH7s+a9a/AU3P7Dv/fI/hIiMujVKV
	aPtWTN3YOTGEabnuouLmmZZ/Realxi0+Bw7hB4v9qFw58rEzR5bfZ0H31S1QWdSq
	hpYmG0JREGYV5wbNG4bOKQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0h2xfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 18:36:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68LIZBE7032290;
	Mon, 21 Sep 2026 18:36:51 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gtegjkb06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Sep 2026 18:36:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSHSdAG46lyqXWXezbh7xH1HSVM4d8xBUKn61KX9yht9kUmlFmSNOrveBLJr7VgRmg5l98B4a87WruTZ8hUsSFvsXkYHy8HbU1Zgx5xMhE+aUWLDqIzu2b3G9OLZ2aq0w6Z23mi4t7knET+u7q3JK9jAPfPpyrnNNoWWmbI2Zgh1ZcINkS9+Sp5VbwXf2XOryVlVltGlVjoy/3WmpY/KIY8qLFjuh3UDdl8BstyejU9Z/y8gOtPnPRUmvXAQNApEyGjxCsLtRSPFpQjq2qJJ3WgFkhbinuov3ct7L7I5JtZyHhDgft1Qv2u2RzdtTjVyO7lHihM5EftKyV72jLP1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEJivcvZ6ftjqE8B0ymwezs2wmGuwi3zrdR5ETzrOVs=;
 b=ACYsritN/FhPCC+SeDOveZlIY93f8ibtiM4omQFT/+Qwdc3SnKFxN+VEkusUYvQ+1Dlx0KGymCZGL205mbRmYNvqrKU7r7f2xoTF0bkTHmcXmzTsITIk3cHrLLSLnu4r8VV1kTAM5QwxIJFyr5YCyJDY5oP30GfVgsAHR1YpcCCT6sY2pNCQ6xRpu2sGa6PTn3aoKIl4d5BNs/HreDk60cOLkzebq2Q7ekUGAFRFx93eDO04Kl+6Aqfq3qIqXPYz1pSHGqvZn2On7CJ8JThuBY2dtin46mhLqt6WBe5yB+NqrpTXeYjFlqRX4hdszsyvkUGMAOwhIYSr0rEfjkmMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEJivcvZ6ftjqE8B0ymwezs2wmGuwi3zrdR5ETzrOVs=;
 b=hib9CfOL+5MkkkNWbqXd0OcYSv6Ril8Ougau2vbuywmwO5VBwATU0G+da6RDtpZ7wLvGW78Kf8qMfXbk19ekVlK3cjpHWbXuKFwJTx5wUBlf1CcD+8GprWuJFfbtqMmbBOeKAOVVJMDnbO4BG6sFPZM6Tb4dFiyVgYJoNqK55VY=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DS2PR10MB657072.namprd10.prod.outlook.com (2603:10b6:8:70d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Mon, 21 Sep
 2026 18:36:49 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0451.012; Mon, 21 Sep 2026
 18:36:48 +0000
Message-ID: <0befe070-2aa3-4a00-b190-1a020f0b9e70@oracle.com>
Date: Mon, 21 Sep 2026 19:36:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 06/11] selftests/bpf: BTF distill tests to
 ensure LOC[_PARAM|_PROTO] add to split BTF
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, andrii@kernel.org,
        jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-7-alan.maguire@oracle.com>
 <fc7dd9b68e50a07af40f6ac571fb7adb6ba512d3.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <fc7dd9b68e50a07af40f6ac571fb7adb6ba512d3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::7) To DS7PR10MB4909.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DS2PR10MB657072:EE_
X-MS-Office365-Filtering-Correlation-Id: 1167ddd1-36b8-4875-9773-08df180f4b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7bamkvxInI2oFS60OqTRRrStKsznbEYWu4TH0TYSD2ht6rNf5OUuKLuOUVS1ZO2pzXtsj9Z9YWZ1EeakPqeJsjEwdY5xdT3Urnr28wF6jOyZu8BdEm0MT6Jnv7WwYyQ0+/uIObSV9zQtLHRUa0m4aLWnpnjoLAcFj1kuIkksduT1VMznHs2mpDdHmRYx+dmKRyBuuh9gmHp9RKWrI+q+ty75C/iLSlmgr3UVFR45Us3OIbMw5z9fA6dQ4RPyQv05RCWiYpOczgHO0YCzXbn3LBDQLZ0INsfjWUodnJoVBO5M7xvri7oaz8/CKx8+4co7wDY6mFrYDGCF6rb9aEThxejRD0L63qKiQjpwDKUmLUrHG/hPlXfq28Z/zEKesfECxbbyinkQLSGRiosZM3IdCjO6Inh3mgy5HGDOIbr82R16lNUoEYd8G/5dovr1L7qgzKMVCiCm2iN7B35vWacd7EbbZ7pgeKgxaJf60YFxp1N9KDqz0cOg8P0ryvWfkjceLXUAlBJqRLexO9WRmFjJp11X0NJiWhSUypcao6bIMynLQZAe5EVN6/VAeMBhuAsBD30ELaZfvVOYvleXFM3/9Qzpvk5faRRqOhjDsM38mQTK6IcaSalb3DgAYybRMYqLpXOhOOIo3uSaUKQ9+JdB6kA0Iv79rKUquntdUcuz4Vk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTlwRlM4N0JOK3h1d1NJUWtYY09veUJYQWlEVHlzdWdBTHo1b0daazhBOWJ6?=
 =?utf-8?B?bWVvemlPRkxNeVR5WHZnUWZrRUt0ZnQ4QnJkbWhNTjZIRWNpaHNRamQvYnJC?=
 =?utf-8?B?cHA4UTlNODVWNzVIcEx0YnUxMjRqWlJ3MDQ4N3dYMWRVYjczUmpvRWtnODlM?=
 =?utf-8?B?VHcySWRUZlRjeGN1dEtBS0c3cWZEdlI0RXVLaERDdWFsakVhV2RKSUppM2dv?=
 =?utf-8?B?akprSy9mREo2c2hvTXFtRm9ybEcyTUwxK3dGd2V0M3NiL3p4Y3RpWlI4R0R1?=
 =?utf-8?B?cXV1WmE4a0RwbUVhT2xsT1FIS3YxU0ZtU3FReE9wQzdodmhwR0VWcVpnM3hO?=
 =?utf-8?B?UjJHUG9IYW9QdEtPZ0ZwdEtMa0o5U2drdXJibUVmWVpVRnVsQUtvKy9keG1k?=
 =?utf-8?B?T3VtL3dkQ3hQYWxPY3pXeE5oNitVL0tyL2NmTytaeWRMek9kdUs1ZGZZV2Zi?=
 =?utf-8?B?dmtBUk9SSGdNa0E5ZFZubk9Ja296TkprNjhpL3NzTFp3NzJNYlpnczdyNk1U?=
 =?utf-8?B?RWJaNjRYMXI1NUFPaGhrUHduYlJlaUNYT2h1MmZrakxFUUFFc0pUTDRva2Rw?=
 =?utf-8?B?RlIwN3kwcVI1VVEwNktVa1g3aXV0T2piTlNoSDk4Ly9WRXd2bFpNbzhIVDFV?=
 =?utf-8?B?S05BckVtRWZ3emt6M2xiNjArc1J0Z0t1d21TZ3RFekFTVWoyRDlTMWR6ckpF?=
 =?utf-8?B?VWdKNWMwYVNYUnpiZngwbkR5TDFhbWtnUCtSaGcvMk42RTJkRmlHTkRoSDMw?=
 =?utf-8?B?QTdNQXhhZmRGTXFWeUVrYlViTVFnekZacTVJbklBWExXQm83bTAyWlgvSlFZ?=
 =?utf-8?B?K09RSFVneFlUSjhST2ZCOWRjaEZ5d2xydzN6aDNOYktaSmRBUURkMGZhWDEr?=
 =?utf-8?B?K3BmT1hpbm5zMHhnSVZOcDdkRDRNaXcwVE51Z1FZQUVnZDlRM3pUcVZLS1R6?=
 =?utf-8?B?OGJrU253ZW9pZm8vdzgwOTFZNzFEb0x2Mk80R1ZGTXhCdWY1cks3YklleFZI?=
 =?utf-8?B?clpFdk4ramlvbjVscitGMldWRXFpZE92aUpqVzFxYlM2Wng5dmkvdGlNLzNY?=
 =?utf-8?B?VzBsWG9RRW5ycVIrMzFwdHZvdkM5SWRLMFhlK0lQZDhJV2d0dGpjT3U2K0hi?=
 =?utf-8?B?T2xONHJYSnJPcGxveU9Sblh0eksvZGJsbzZnb2cwQ25RZHUxMlA5UldEeXNX?=
 =?utf-8?B?U245TEdnbzc0Znd1VDFvN1RyRGVwbFgzUzJESS9kQ2l5enNCSVdwM09LK2Jj?=
 =?utf-8?B?ZExIT2NXaDJDWHcyVUZXQmJxQkcvdEpZd2V5RUdhZ3gxTVdweXhVMk9SanZi?=
 =?utf-8?B?Y01WUGFINDU0eHZMWi9rcjhBb0lTa1JkZU0xYi90MGsxU1I2ZTlvTkRFNlZ2?=
 =?utf-8?B?T0gwcUY5Y0RtaWVWUTFtWWpnTzJzbkg3bmlMZ2MvN3RVeG9Oa1lFNWNNTjJz?=
 =?utf-8?B?ek1JTUpkZHBpMFAvRjhOTHA4QUsvZ2N5QWZqVWEvRENYQ1ZsaHpTenh4d1pm?=
 =?utf-8?B?a2k4WUJxcDJMbkNvMi94MDFEbTdzTjVDd3RjWmZ1RVp6M0Y4OWRtK3VacFJi?=
 =?utf-8?B?Znp3dWY0WW85N1dENmF6RUJMczI0OERaVmRNTmtVblZKRVFkT0pjd1dFRmdQ?=
 =?utf-8?B?NnExc0JkY2lzUitlVTIyb2FxYmM4NEN5Sk14dWZLT0FVV3QwUmQ1cnZVQjQr?=
 =?utf-8?B?RTFydlZpTTE1ajJMYUFlaTduajUzdEVPMnl6M00zQ09FV1FBMExINnlSNVVl?=
 =?utf-8?B?WDRwRVBQVFl4NGdWZWlvTnhyV25Yb0pCOVM2cW4yRWkyb20xL3JVVEN0cWFU?=
 =?utf-8?B?Y0VtSnJTY3NxaTVSTDFEQm9tUlpDOFBTY2hVRy9TMXVVSGJnWUtydWk2NS9Z?=
 =?utf-8?B?czhoakI2NFo0NTBGVzNUNGRFam11L1RoeUFUc0ZPVjQ0Y0JxYmFPQTMxOGpw?=
 =?utf-8?B?V1NPZFRvSzl5Q05TV3JHU0t0Qk1lSnI5cE1VMUpkeVZxZ2FuRjdRK1lLMVk0?=
 =?utf-8?B?amNXaGNDdVluWEozQ3ZVWENYT0VDc2pGdkhPSHVWOWsvNDZxaEM1WlpLeW5h?=
 =?utf-8?B?czBESmYzbjNucjdERklpQXZaRGlFanV1MUJyQVJxKy95dHpTOStXdWNLMzNL?=
 =?utf-8?B?aVpOdW5uK2pZTnRDSHRHamtlTzJFUGxrR1krTkM3enVlbStpWE90MFpUcnVL?=
 =?utf-8?B?Wk9neUlGVUszdnBTd24yTkFoSzZLNUptNGk5YVVHMWlXWnpTa0xjK0V5UEJU?=
 =?utf-8?B?TFdydThnSUNmYWZEb0NWVlVJU2M3cGJiNmZ5cWx3REJubzd3dXV6RUNrUkpE?=
 =?utf-8?B?UTF1MzhFbWkwVTVnNFlUME85bWwxUWgyNGQ4MExJLzRqbHdzSTY2QT09?=
X-Exchange-RoutingPolicyChecked:
	etU9C71lLS38q/kzMbedSUrtXfggcRLdoprS7RF8pcZ/iIXEYTWkAlKq9p5BZzG4s6rG4drPA3lQMLbnmCdzbDd6o6A2lkKa+T4vrsTOGIhKGwYbCyrXYodkFMsUK8tY14TJaI5drr5WopA0G9BOKJnHqDQKeb7dQFz+JYxeTSMMmLBHsew2ACLCcUzPWKOJu2VFxWMALUJ/fawrrvPa9x0KA16CtzKdGsKwGv5PtOEiojUwP6K/oyu4zvsDGTilSubHEHZhhdJI4eUJz4T3uhGMR3cQEumNVGn71j6DrrKXAhT1wrL7X7CxAcy7dGbFuThqWdsQXzzqfhIrUlCCpw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cv1cmANvEXiJB+tCc4D5tIgAs6iDG70umcP5s5rQwPYJAggdPM0ay0vNiFWCsGHFkvbmaj1wDhII03U2Igegi/uy9yUwMYsqlwjFA0Zvo+O01D6QsrlFBJHmTplKADnnBNNZJCnAFmp+tW3FDJRk9ZbntDtu4h3QdW47z1+y+pV+lcJH64mrwoOtt1jJshdDmOWP7bYlP3V353ULLKyUX6viv5zbmun4aeQkzJwfDaGT1t4lmFGkNI7rJxaKSl5vHAtVZIU7f37IeA2rthw2k8El7PyyKdC2VaLusF2jnK/Uu2mw2has882GojvtuM2u7vMCYZmq0QnVUpkqMR/8cuwcYuse82a7BndZoESJV1tJi+l0w/yhG3IB+aujUuZigUhmnz00nkKmA4crZBGB2LQY247p5VhE7sngnfe4xoyjhlAZeuNYMffWcX9YoAzJMPKAoAt5Vukl5o9DqI9gAFiobcZb8hSNPvkrmQC4QCktPkDctGFOjfB4Q71QlBjnRRVl2iraIPM9gY+Ox5JkG2c0vXoqxi7usKs//ZeWEeZyFjUju347xLWWgOzR6HKGdMFrWtxQuleeuenjPhw86G7/JwIE8n01yRxGRoXEO+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1167ddd1-36b8-4875-9773-08df180f4b48
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4909.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:36:48.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BXEkmE1sGQE4YqdF0+lbsDRGhcLgDvyaNI+Eth9m7vFY69q8cgL6YplH/9y/nK6wekklVSjH09ZMrpL7jfU+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB657072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609210271
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX75ThidpgySh9
 I+3HAzxOMeFs6U37IxFCmb5DqjO8473LRbwCROyqo5xsFmfAgnQHzRbVhZNbVIaQQgO4olEED8x
 3ntXjgXE4XbcGborX07xYT3pxhYMIottvBBfP/XorSNmO4A10OIF
X-Proofpoint-GUID: lXdhZVo5_bV7ilCBlUOcwyD4Jdf9J8hb
X-Authority-Analysis: v=2.4 cv=CNa/zhrD c=1 sm=1 tr=0 ts=6ab17944 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8
 a=0Cgan-oSxU9vI9vzlIMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfXx8fb8rLkfVWY
 RMwVH5cv88XtpA8d1SCy9F5LUb4W3zPgEEyn/G1BwZXJDYzbcjMB9hO9ZxGyuqVcp1h0+L7VkNd
 945VK9dnuULrnn8qcRx00cDpb74/Y+0Qh5CKR4Aw2uee8Zs/xjnhJQtQ0OZDOBmVEPr+H3arKx5
 wMVDNHTejJZLJjjTZhOPuxUwc0OxY6r9G6vDqset9ODg+SthPFJO23JuLHodXNv27cB9sgOB7ep
 EGWV0YTaFbebW37NrDUYUs9hpUaONwP1DizjZeBO1588gxexYJqS0/tVCmoea+zi9GyhwAvX1fn
 2yBSJAtB4lvTIxzfBX6YXfpTPS0xDlNFj54BvlW4KhK2raFHaPwA6hrXdLny12LNi1VQseq0+zA
 Q+lN9T1VRjWX0eBjb7CtE3gHlDMkohP3rdva/iiU+BkORPM7lc08iskN4T2g6KEhHE5ublItlym
 qS8qZB1xW6OgCjNPr4w==
X-Proofpoint-ORIG-GUID: lXdhZVo5_bV7ilCBlUOcwyD4Jdf9J8hb

On 18/09/2026 20:59, Eduard Zingerman wrote:
> On Wed, 2026-09-16 at 08:41 +0100, Alan Maguire wrote:
>> When creating distilled BTF, BTF_KIND_FUNC, _LOC_PARAM and _LOC_PROTO
>> should be added to split BTF.  This means potentially some duplication
>> of location information, but only for out-of-tree modules that use
>> distilled base/split BTF.
>> 
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  .../selftests/bpf/prog_tests/btf_distill.c    | 101 ++++++++++++++++++
>>  1 file changed, 101 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
>> index fb67ae195a73..141a4cb1f405 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
>> @@ -671,6 +671,105 @@ static void test_distilled_base_embedded_err(void)
>>  	btf__free(btf1);
>>  }
>>  
>> +/* LOC_PARAM, LOC_PROTO should be added to split BTF. */
>> +static void test_distilled_loc(void)
>> +{
>> +	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL;
>> +	struct btf *btf4 = NULL, *btf5 = NULL;
>> +
>> +	btf1 = btf__new_empty();
>> +	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
>> +		return;
>> +
>> +	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);	/* [1] int */
>> +	btf__add_func_proto(btf1, 1);                   /* [2] int (*)(int); */
>> +	btf__add_func_param(btf1, "p1", 1);
>> +	btf__add_func(btf1, "foo", BTF_FUNC_STATIC, 2);	/* [3] int foo(int); */
>> +	btf__add_loc_param(btf1, 4, BTF_LOC_PARAM_SIGNED | BTF_LOC_PARAM_CONST);
>> +	btf__add_loc_param_value(btf1, -1);		/* [4] loc value */
>> +	btf__add_loc_proto(btf1);			/* [5] loc proto */
>> +	btf__add_loc_proto_param(btf1, 4);		/*  param value */
>> +
>> +	VALIDATE_RAW_BTF(
>> +		btf1,
>> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
>> +		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
>> +		"\t'p1' type_id=1",
>> +		"[3] FUNC 'foo' type_id=2 linkage=static",
>> +		"[4] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
>> +		"\tvalue=-1",
>> +		"[5] LOC_PROTO '(anon)' vlen=1\n"
>> +		"\ttype_id=4");
> 
> Maybe also add an unrelated type to the base, such that effects of the
> distill are visible?
>

yep, good idea, will do.

 
>> +	btf2 = btf__new_empty_split(btf1);
>> +	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
>> +		goto cleanup;
>> +
>> +	btf__add_locsec(btf2, "inline.text");		/* [6] locsec */
>> +	btf__add_locsec_loc(btf2, 3, 5, 256);		/* "foo" offset 256 */
>> +	VALIDATE_RAW_BTF(
>> +		btf2,
>> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
>> +		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
>> +		"\t'p1' type_id=1",
>> +		"[3] FUNC 'foo' type_id=2 linkage=static",
>> +		"[4] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
>> +		"\tvalue=-1",
>> +		"[5] LOC_PROTO '(anon)' vlen=1\n"
>> +		"\ttype_id=4",
>> +		"[6] LOCSEC 'inline.text' vlen=1\n"
>> +		"\tfunc_type_id=3 loc_proto_type_id=5 offset=256");
>> +
>> +	if (!ASSERT_EQ(0, btf__distill_base(btf2, &btf3, &btf4),
>> +		       "distilled_base") ||
>> +	    !ASSERT_OK_PTR(btf3, "distilled_base") ||
>> +	    !ASSERT_OK_PTR(btf4, "distilled_split") ||
>> +	    !ASSERT_EQ(2, btf__type_cnt(btf3), "distilled_base_type_cnt"))
>> +		goto cleanup;
>> +
>> +	VALIDATE_RAW_BTF(
>> +		btf4,
>> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
>> +		/* remainder is split BTF */
>> +		"[2] LOCSEC 'inline.text' vlen=1\n"
>> +		"\tfunc_type_id=4 loc_proto_type_id=6 offset=256",
>> +		"[3] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
>> +		"\t'p1' type_id=1",
>> +		"[4] FUNC 'foo' type_id=3 linkage=static",
>> +		"[5] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
>> +		"\tvalue=-1",
>> +		"[6] LOC_PROTO '(anon)' vlen=1\n"
>> +		"\ttype_id=5");
>> +
>> +	btf5 = btf__new_empty();
>> +	if (!ASSERT_OK_PTR(btf5, "empty_reloc_btf"))
>> +		goto cleanup;
> 
> I'd add another btf__add_<something> here to shift the ides and make
> sure that relocate actually did something.
> 

makes sense. Will add for v4. Thanks!


