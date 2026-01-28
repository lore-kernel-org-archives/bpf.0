Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376B2D73BD;
	Wed, 28 Jan 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614607; cv=fail; b=okZQBeBtZVm2N2Sa7JARHbZLI02uca05JZ89xOB94H3GcD6hDOP5hqdXzmYQqM9vwc/SHSBtTynPX67+UnaMbgw2fbCiR/c95d8VgeCFQS6tvx1SQZAPLhspc0qPTCGkCbo+rKuymxBrUW04dLBTfAr1o6RS5+Hn82ginkTCBwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614607; c=relaxed/simple;
	bh=jUhP4hduzptLzOuHpTWiqCNKF/0SxDjGXCkwkX8GYvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u9jJAqzJvmcvuJKYxs5sq34Z4+SRdHxKUry//ghq9/A1/xdkBJFBUBM/ftR5XhHX7kE2IaVDiRmq7mi8L9vKfW0hbI1L9hPL8V90ah3XfGI6Q0ChEOpBeUficw3xzty090JVETys4PKZN89uSxm3NJTKSHzxrZ99cliE+ZRJ5uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cQk7Yfgq; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cQk7Yfgq"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60SDcmd42737591;
	Wed, 28 Jan 2026 07:35:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=CUVSlWfWaA/meKY+rL/7qES81dcDQrKQ7aKAalNbNcY=; b=cQk7Yfgq06d5
	wjzgN7H4JRim+VQ2b3rjwIicPU42NZIxHdB2eeqaBCbNdojpbfxMduJX//2wm9nw
	m2ep8MNfs9vMFDoEJG4w0Iez0snTbibDlpSOitV2JQ7yNIJUMArJkXx3DaDBZLRK
	rDnu4oBQfRViV3lZg001qIg6sup7912GCICr4HfTo0g06L0kHDdi/P+orX+ZRBCN
	HDGQBh2+A6iAqzdu97SQrTLQi3Pa8n7WvPvgbJqa/JeJ35nXxxPFj2jsxAVbB4Eh
	UuDMo4fOshDxyZnyRWvEr5VFjBl0QlFyKMVgh64NK+IyIpflrgLil5o5G9WYlAfm
	kOgUbTvHpg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	by m0001303.ppops.net (PPS) with ESMTPS id 4bykh4153r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 07:35:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVMMdwyOsL5WFiC1F/sLgKuZhHfAwfD9i9RPhGiwDYMf/hQvXBESrHH5rtMyQKVx/OWxzcAxHGE2ZyMMn2cQXs4klUhTd5PpAuH10Sknet4ar91WyHrgOWZKirfGSkQDYWyb0WSTC/hB+W1BChsf89XKxraOykpXxwbFZN7ocrXAY/4oml50LrXDwno6ZDN/piDcFuI5Ycn7gFtEdzqUgFiIAScCmsZjbq5dEA5+DbtiqegwGfwSB94ibnyUHo0OETneR51oaUQFGn+ouEUCExhJKiLY2pcac/UTO8y/iSktXu6V2tS0+lHHrblKA7Z28tORhypvpnutDpvr+Hz70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUVSlWfWaA/meKY+rL/7qES81dcDQrKQ7aKAalNbNcY=;
 b=d9/hkxANg8UZPGXAXz3OLwRXFVSN2F+pv4663rWX01kG1yU5PksZ5kSPNkQ5heq2Q9oVcuZbJ/VXEMx7D8CagDXEbNd/wJhG4ZtPpqsnlB7R+IzzxK3C2rykNDVFNNaCzUypERaxvpD5n9QrqUQIFj6xERj4qV/uAJ8D4ajB7DQSgs1l9R1fLizmUvLapjpgGegMKulvz0JG0l66fS+HsZONePHU5Vc6iubjEHPRNymaOImtpwbkpfnL6Gfu1aXe+2T6NBvtHh9W5WOJNH8MBpVYjhgqiMoYLHUpvKTMC8FbtxGxNwCYYoHrKYFHjDakyBJyGERjLaWgFUlzH1W7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by LV3PR15MB6657.namprd15.prod.outlook.com (2603:10b6:408:271::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 15:35:21 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 15:35:21 +0000
Message-ID: <65231eeb-1f00-4af2-9234-a290ea3f6585@meta.com>
Date: Wed, 28 Jan 2026 10:35:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add bpf_arch_supports_fsession()
To: bot+bpf-ci@kernel.org, leon.hwang@linux.dev, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        puranjay@kernel.org, xukuohai@huaweicloud.com, catalin.marinas@arm.com,
        will@kernel.org, shuah@kernel.org, menglong8.dong@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
        martin.lau@kernel.org, ihor.solodrai@linux.dev
References: <20260128150112.8873-2-leon.hwang@linux.dev>
 <e64c4137e7f262e6fdab272e8ee44c8a129a36eb6d0186914375d6ba20d88474@mail.kernel.org>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <e64c4137e7f262e6fdab272e8ee44c8a129a36eb6d0186914375d6ba20d88474@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::13) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|LV3PR15MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed3cc9c-ba34-49f6-1c31-08de5e82d8f6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGZKcFY5dkw2SHlqSWdZWll4ODA0MDRlTnVkV05SWE9Ga3NtNE5ocWxKSUlR?=
 =?utf-8?B?UHBNZjNWZVBnUGJsU1kvSTJLT1FIS2JSUGhXRGJLQU5MMCsyNFJVN0U5Lzlz?=
 =?utf-8?B?RVdRRUI0SHRKNGtjbnhxekh2K3p3L2MrMnQ0eEZqM1FNNzl2VWlNZEFLSVdW?=
 =?utf-8?B?Z2ZZd3l1RVhXU052aXFueUdzMzlybThRczZNTFBuUHlRRXRaeTVMZHdHSk9q?=
 =?utf-8?B?K255Z0owY215UzMwL3JDR1liMHErWjNQZ0lKbVFJejRtbGpvazhiWUc0M2RJ?=
 =?utf-8?B?T3lQOEticUJVVVk2YVBKU1htK2txWFd3U0NFTDZiMitLcFR1YWl3S28xZWVj?=
 =?utf-8?B?ZjZ3OURhQ1h2Wmk4N0pYTGwzL08yQUZsSHE1cUZuc3RaaFE5OEFtSnBNRFVj?=
 =?utf-8?B?OWc4UHBYaFVJVDRDaXFLVFBobkJzOUV2S2RueUdReDNyRU5qcU0wUkdXSk05?=
 =?utf-8?B?bkNGaW04NXk2Z2hvWEF1dFl0WTB5d0dPb245c0k3TS8wdEhMVytwOHord3NC?=
 =?utf-8?B?VnErM2RZeWtiM210MW9vUXFFL3ZlVE9kWFJZQ1ZEOFlYeDgyOXI4b1A3QXZj?=
 =?utf-8?B?QWdXZHRsVHFaeUlMTXF1amE5dS8yb3RpeDEveXhZcERJcVRHeUJvWHN6dHVI?=
 =?utf-8?B?dkZkZE52QUp1YzhndzNzanpkUUJHOFBRZlpRazdGanIxRkZNSVc5d0E2WlJO?=
 =?utf-8?B?YnExMjJUQU5vSkFwcGpoY25JSE91UlJSazEzWW93b3ByTTFnU0JwdnZ4S3Vu?=
 =?utf-8?B?ZTBCdElYMGFwbWJMcFcvRTBLVDZXandqb2JMWTR6ZDJLcFMzcHZndlFCSk5S?=
 =?utf-8?B?NjM2SEdnUmlkMC9LV3FOQkxYY0d1aVFTQU5pV3BYVE1WSVJiQjVhbnorVmFG?=
 =?utf-8?B?VGI4bGNkOXZ0bE12cXBVRndkZTA5MkRDa3plZEFSeWNUZjJ5bW5HNHNWVFIr?=
 =?utf-8?B?L3R3c3pMZDQ3NVdiQzVXbzJhSWFwazVNVnYwUWtGa0FNNTB0dEt1MDNyUWtZ?=
 =?utf-8?B?Y3RTUzFNak1zTWNCV0ZGdEw0T09HeTlzemQrT2tPZ2Vpa1h6dTd2aXliZ21h?=
 =?utf-8?B?NlB6b1IvTGhJRmZrcitLNWlFeXIxbDNJeEtKaWpCYzl0Mm5KSXVybGNRTVlO?=
 =?utf-8?B?WS9ldW1Wdm1uZGZVbXQvRncvUy9ibGhsVTBNWlcvbkR6ZUlWSE9tYkQ1d2Qy?=
 =?utf-8?B?Tm5XL29VL3VKaThoKzhPNWhPYno1dFk3MUIyNEFreHRXYzBBUWh5YVVZZTVp?=
 =?utf-8?B?U0Q1aWF4cjVyVXpDVUpLQytOQllwd1ZGWUpmTjBlNGRzbGhKajErMEMxZ01o?=
 =?utf-8?B?NlEwQW1qZUp0KzJZcDMxdG5ucmRxZVZiVG5XamhlT3R2WEUybGp4SFNjM2lI?=
 =?utf-8?B?eTJUMWlseU9FV3dVUEtLYml5Nkxrd0drT0JHWHZva2lhbXNvM3hvcVpqQ2NJ?=
 =?utf-8?B?N1ViczkrTFo1V3V2TnY1bXQyK1BSQnZ2TE96ZjA0SVZVNnpGVC9zZnhod2ls?=
 =?utf-8?B?QjRQc1NmTTN0Y3ppcEpTckcwNmNlNzdpeWxSYTVRZmZYYkF6NzJXc1pVSEpS?=
 =?utf-8?B?MjBLL0wzcTFTb0xsbEVpVFpHM2NXN0Z1Ny9nMVBnK2tyQ2JLaWJtVUo1dHlL?=
 =?utf-8?B?SWErK1BkWURKU2lkZzQxcWpvLzQ1QWhidFJuaDNMNHRsaHl3WERjQTZ3YjFi?=
 =?utf-8?B?TTg0ZmVZalVIQ1lkdjFEcklCWU9xbWFndUZud1dmM0wwYUs3Yjh1MXcxVVlR?=
 =?utf-8?B?dFV1SGV2YVVlZ2pqTExnMlBIa0QxVmZtR2tGcFJ4TmhZVnMxdUFYZU1iU2Vm?=
 =?utf-8?B?NHZ6RHdoZzV4RXY5YUJZMUc1bE56NzlJRVhZd29DY20ycStDTlhTK2t4QWtK?=
 =?utf-8?B?OHBIZ3d0RXorWk1ZNFB5YVlQWEQ0YXJYVzkyVVMyRzdjMDVUZ0czU2tCUWhB?=
 =?utf-8?B?QXVNUnFCVlFkTVVsOEIyYVA3NkUwT2lwaXN3VFNBVnJyWGNlRGdHYVJNZ0pt?=
 =?utf-8?B?Qi81bVN5a0x1RkZVMjc3NG8vVXF3eUk0MUttaEVBYjBkZVNrNFgrV2pNakNI?=
 =?utf-8?B?M2h4ZEl4TkZrOUJINk4zTVZUc1lGaFZYbHNFR0EyWDBBOWV5ZGp4ajhnV3ZJ?=
 =?utf-8?Q?M/f0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjhtczcvY1o5TitwbEpsZlBHZnZRYnIzcWhHejZLN0pubGE3OGUzRGZHM0gy?=
 =?utf-8?B?T3J5cG1ORnVuT0htaDc5UTJGUVhEOGhtZ1RtMGI2RVJ5bUJOdmFPUzNsNkRq?=
 =?utf-8?B?NzFWM2pFSnJ6Q0NQUzBSamlCUURKVkEweW5QNGNGNDFZL2ZNSWMwQzhZSVda?=
 =?utf-8?B?UnVXQWJFd3pOQ3JtQ29vL2M4TDd0TDUzYi9VWXg2MzRTTElwU1VpdXFWMzdj?=
 =?utf-8?B?VDh1ZGlHekFhZElOdHE2RW81bUJVczhUK3ErVW9mc0htNEFGdEdqeEdnV2Rv?=
 =?utf-8?B?bDFmMzFaZDFLNmgvZGlWU0NadEx3bytSc2g0Z1YzZGVnL1lwN2JMNGFuZC9y?=
 =?utf-8?B?UmIvYTlQTU1TNURiR0VkQXp2TXlScEpZWS9RK2xseEZ5YjFsOFBlL0lTR3Bi?=
 =?utf-8?B?b1NIemhwQjdvMTFIQWtubGg3M0VVaXFkZ2thUHVmSDdGaElkWjhWYlNyY3N3?=
 =?utf-8?B?cTBab0pXNktuVnUveUN3M1VDSEplTEdpZGJiMEtQekl5bUlnWmwxS3dhWUdn?=
 =?utf-8?B?cGMreFEzdDR1RWYvcVZ0Mjlaa2QzWUZRUVZhZGdoUjd0NldoRkVSaU1zTnFo?=
 =?utf-8?B?THJTa3dqYWdiM2g1bmpxbjYyS1IydFBUTDJvYU14T21WemcxUGg2NmpBSldS?=
 =?utf-8?B?S1QyWmdtWjFTSW5PQ2hYOHZ5bzl3NlNvQWZibS80ak5WejhpeTVZTlJSSEZk?=
 =?utf-8?B?c09taFdXT1QySVgydGtoa2kreXF5cm1zQVZKT0pPMEN3MWkycEx1cTEySms1?=
 =?utf-8?B?U3JxaDZ2N1ZsUFdWSFMydDNVWVUvRWZsb1lPeThENElMQzlNWmdCc0htY0pM?=
 =?utf-8?B?VlQzS3VtdHlEL3hsWW0vRExEcnJBRkpWZzZDaC9DUTBaaHRjamxHY1I1S3Zv?=
 =?utf-8?B?RWRTQzVJdDZaL0ZiMndtTThJK2xMZkZ1eXRrZHBidHkrNUhLc0I1UHFGUVUr?=
 =?utf-8?B?ZFNrNHpEbkhrMm9yMVRjKzU3U1pvZ1hIMXcwc01UUHNLYjFsRW44RnJGOEFP?=
 =?utf-8?B?UVpLS3pFOFhhMlVrWmVzYzdpYitMcEFKRHlwKzhEeDVlODFaejcweXUvVUVM?=
 =?utf-8?B?QzJHTE0zS0daSHM1NFVNZ3lOVlZqR29NOWlES3FQSE1MRHhuZUJaVWJUNTEy?=
 =?utf-8?B?czJzc1BXS00zcDlMWXVmMzV2YUVOeU12a2c3RkFBQ0M5ckFVeS9sZUp2WUhq?=
 =?utf-8?B?OEZjTzFZSjE0MUI0dmUrdXZuSGhGeFYyYnJ6aFR6dEt2R05JVWlBc1dtVnA5?=
 =?utf-8?B?SlliT2FWSUxEeWhMOHlCM2IzcTI1VExvaytKZlFWMmVXUzQ3SFBEeW9uamFj?=
 =?utf-8?B?NkhOZU9EWWM4ZnI1U0NseEFxblNqZit3SlV4NDU3Q010KzhENEhiNHBmZ0Rh?=
 =?utf-8?B?VkttT2hySUNFK3JrOXE4c0RuZ0E5czV6aUtQL01vS0VkVXQ1Z2ROZ1VIZXJC?=
 =?utf-8?B?UTRKazRRQk9TM1FtRkY2cm13L05uT2grclFRKzAwYnNmQS9xeEh4UElGc0Ri?=
 =?utf-8?B?RHdBVGY2aWRrWDlGc0d5bDdLR24xSGx6dkFGUXVMYVNtaVZxVXM2SjdlSDN3?=
 =?utf-8?B?bVVwL0RCZE80WlhkeFlUWFRBZytVMStUOUwveVkvWGNLNGVlamt2ejV2anBr?=
 =?utf-8?B?cU14aER5VUVONzVHSDNnTzVEWkRkOUd5WnlsKy84blpKcVpoMHd4SlptQ0FJ?=
 =?utf-8?B?ZTBweWlQOXhkbHpISUFDMUo1TXVSbTV0NHozSEJDOWxqSUFZUDJLUU10Rjd5?=
 =?utf-8?B?czcxMkRaOHpqV3R3NUN3d00rcGFQd0pXZlpBSnFLZlJienBuMGhmNUlHZFBK?=
 =?utf-8?B?aE9vWVZ1UFJ5UmJBT0hVc1k2WXRYdnBBdzJPTnloY1ZvaUVWc2tldVQycm1r?=
 =?utf-8?B?bWtaN1RKWHZtQ0pGcG5uT09QMW1jcEEyZExSOC9KL2tpTnpDUmcwVmw3Q2Yx?=
 =?utf-8?B?ekYrSGRxVWR5Y1pxbW9jS0M2SWx5ZE8xWkNXK3RDZGV0bjVCOHJDbm9UMEdW?=
 =?utf-8?B?NnRCWlhZS3BxVzB0T0ltaCsvbEczcVBpdEpQenBqb1ZUdTZ2Um12L0ZYVTMw?=
 =?utf-8?B?ZGVHaVRGdnJUZ0ZtZ2NOQ0l6em4wQUVDYjZrM2I0dlIzT0JMOHZ4aTdGU3F0?=
 =?utf-8?B?d3RQMWZBcmNZT2tGN3NsTVB5THdISkVKb0lSQWhuS2Y4aWV2REYrV3B3U3Yz?=
 =?utf-8?B?Q3graTAweG81b0lIblozTGU0QVgxVHRReTZkbXo0OXhSbkRTUDB0V2ViYzh5?=
 =?utf-8?B?WjM2cTN0YWtYSkZZOTg5MGhvWlZhRVRLc0g4R2hWRE1WbGtMbXIxYmFjWktv?=
 =?utf-8?Q?o5m3aZeSdKMmYE09sS?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed3cc9c-ba34-49f6-1c31-08de5e82d8f6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 15:35:21.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB1ZvUwe2NK6vTsmvsJTizRpu13efQEejmuO9KKxMayr59kFEoNc+R9c1DPdE/AK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6657
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEyOCBTYWx0ZWRfXxbOyIUJ9+tLB
 JSbz1UVtaj7ULI8sFRa9AnhQEoebbuvh8ko0SfsbcoXvHcOqegg51EUK0FST0j9fKNghZYSvo0x
 n1LJzo7ht4qYAUXkksT4FQqcDgnmkwHTgITy8aQJ5YfelrGuvSjDbq1Kyj2kJdpmVnnILzAfAnL
 0CKedKiy/24Yrm6l5rnr7kPacCL10klrh+PM/A4Xci8OblwwMYnHo4o6FMt4eM0trabZJ/CsVtD
 O9mPVvRDJlJcI/ZO++Bn6D3yYoN/RDECIdafp/1f4bcj4TmfvDcIwNePFlnQ5hAfUQaEb+x07aP
 agtmG/tYxPStpJWOuL6u8DAstOjQAej0yUmZWMqcoSmUtYKgpTslhdA/Jf5Hhm2BplQDv6wy1aB
 QLItPDlKNKJzk8kuq9Wt1F96mq1sVZdmbH6sFsDJ7LYxNuNMli21HCP9STeIxsMfXzNdHStd0xU
 bRuMJxQR+A3c6zs+ilA==
X-Proofpoint-ORIG-GUID: 21uDgYKqajjYAhhx82bwtWvZxebWaynR
X-Authority-Analysis: v=2.4 cv=KbzfcAYD c=1 sm=1 tr=0 ts=697a2cbc cx=c_pps
 a=RaQOCb/jdUlFsaPmnWcrog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=cr_4cZAeu6lmMoaqPs8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 21uDgYKqajjYAhhx82bwtWvZxebWaynR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01



On 1/28/26 10:26 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 5a075e06cf..070ba80e39 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -4112,3 +4112,8 @@ bool bpf_jit_supports_timed_may_goto(void)
>>  {
>>  	return true;
>>  }
>> +
>> +bool bpf_jit_supports_fsession(void)
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is the actual function name in the code.

Ihor, I think the script parsing review-inline.txt chopped off the
part of the review where AI was complaining about the commit message?

commit f636685cc0b05bb758bb58729cc65dde79ac7108
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add bpf_arch_supports_fsession()

This commit adds architecture-specific gating for fsession programs,
returning -EOPNOTSUPP when the architecture does not implement fsession
support, instead of failing at runtime with -EFAULT.

>     bpf: Add bpf_arch_supports_fsession()

The commit subject references bpf_arch_supports_fsession(), but the
actual function implemented is named bpf_jit_supports_fsession().

>     Introduce bpf_arch_supports_fsession() to explicitly gate fsession usage
>     based on architecture support.

Similarly, the commit body describes bpf_arch_supports_fsession(), while
the code uses bpf_jit_supports_fsession().

Should the commit message be updated to match the actual function name?
The function follows the existing bpf_jit_supports_*() naming convention
used by similar functions in the codebase.

-chris

