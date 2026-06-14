Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A8DDA9
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 03:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781406717; cv=fail; b=DugZvjumYZQ4uCAwVoiPdVCU6kFa9n6siEadCnfFqyanQ1ElGsvWEr5+s/JmoakuS3iYuPvB9CTpbgjz0yORCThnHh0yproip6TsT7ohkx1/8xtwf0Ln1j3+AdHjy5ENIL2q6PzIc9Qqi93EOKZGU3HI9YpvYUVak1efAxz2f7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781406717; c=relaxed/simple;
	bh=rwmpQBaiG0ubc7WgEEGl0DxwHAIhvBFxgNkfY10ZBrE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z1/rMhrihlbt1Fp5TfMsC4x4GavyznnKJxeJ9l0paNtULPiPg+n/XCzx0M1MytNixviy5q0jp3eptPpvSyK6jhvQ8cjFQVtXx44Hi1xr7tQTZLDfFF2VlIm7V9sGVvibXHKh5VrgDxoGZTpq7aHPQcrqvPrbFtkt6q5Mz1FN1Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=dx+ZBy8/; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="dx+ZBy8/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=ces1;
  t=1781406716; x=1812942716;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rwmpQBaiG0ubc7WgEEGl0DxwHAIhvBFxgNkfY10ZBrE=;
  b=dx+ZBy8/Cu7pEfPjHszDqOXeeDrUtW9quupcMxhj6QVRKEVgoJu4QqGV
   s0jkGo+PZz1tfVFFYvxif6dTbtvFvn1q3n4uba62sR4gcvHpMOaTRyY7W
   Smh1GAKxkEhVf+5ZCHlvL1EEFKDjiLvuHOQd2XW7UnYYzD8mKdTHOWhdq
   s=;
X-CSE-ConnectionGUID: fZ8vR+leSOG1QYOxcQJLQw==
X-CSE-MsgGUID: JCCZ+47BRV+rNrGS6gWuUw==
X-Talos-CUID: =?us-ascii?q?9a23=3AH0jImGmbw2ctJV23w2NuKk9nZ7LXOXPvnGnqYEu?=
 =?us-ascii?q?1MkFGEYSkbk+bwYFAqtU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ABvwTcQwEgVLJe+3uZbiaf5TRB0yaqIaFI3JOzco?=
 =?us-ascii?q?sgffHLwpqFAzDgwuqf5Byfw=3D=3D?=
Received: from mail-canadacentralazon11020139.outbound.protection.outlook.com (HELO YT3PR01CU008.outbound.protection.outlook.com) ([52.101.189.139])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 23:11:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EehzEWC4yODoxbVS9YOqsNZf8bNDsSwTksNY19qnAZ/qZ1ZDfMkrR8nfZ4MEkyP0BAILcV+bzFd25/x85F0w917L5SHc5jEqD+CoZOwv4q9gQdw2qSO0FE3YpdrAcmX5VU8RSak6zIStxYleGY3EQQaeiH9lBw3zP+ju3W/6I3edVOPQGpppC3sJoyFFLIIjZ6HwhEeqmPtr19k5+AEOxu4751jOhmLeTYoY7xnGW2UMMtZoKbxmo8j5kuRLMaPCsM+Dk0HLXILgtsTyjYqT3QbsWmYic8LaMjO5qU0YTn6mkE/SQOoDGCjl8xRCY7lrCFEumLbz5A2P2U+korpv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfyR7ARiPbfdI+B5gK5SU24hmB3zLmEkUV4ArI+eCMc=;
 b=G/NsGoG3bTUfNDMJBVr7nOWmpAEj7TlgGk56gzp8mh8gtGFM5R8l+YIXg5BorsLsMzFKfMWSXB9+7OIJbKJ+krRkl2wCNWkPA53vKVeOTMLKw3w8ki4g3vHcqZKa/4bC7TO6Jp7pSE0mJdSTpGsU6QMPH2bG/3oDsOKTaGA23PL2M61zP1JmQuG4e7E9apYPoYqt8t/ACAwePp/rZWsEtivl0SW+poOTQdpHmEmCwr8EtKWD0FV0SqXRy9OyK39ZH13J6JllK699fPWqYFdkfzXnZN2BeqxpoFEXnkQLomohqS1ykcuQ6vRMI+FeAOmwnjUZ7aCYY0xVUp4BhEl/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR01MB10511.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:82::15)
 by YT4PR01MB10406.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.10; Sun, 14 Jun
 2026 03:11:45 +0000
Received: from YQBPR01MB10511.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e47e:5558:f558:43b]) by YQBPR01MB10511.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e47e:5558:f558:43b%4]) with mapi id 15.21.0139.009; Sun, 14 Jun 2026
 03:11:42 +0000
Message-ID: <f99c47a0-6c99-4538-a80d-d992273416d8@uwaterloo.ca>
Date: Sat, 13 Jun 2026 20:11:40 -0700
User-Agent: Mozilla Thunderbird
From: Hugh Coleman <htcolema@uwaterloo.ca>
Subject: Re: Proposing a change to cnumXX_normalize
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: yanze.li@ubc.ca, bpf@vger.kernel.org
References: <8c297913-c48b-4d50-a253-039037c21e53@uwaterloo.ca>
 <7a5c9c3e8ef2cb86b7ae38fb4593e7337e9962c0.camel@gmail.com>
Content-Language: en-CA
In-Reply-To: <7a5c9c3e8ef2cb86b7ae38fb4593e7337e9962c0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:303:6a::15) To YQBPR01MB10511.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:82::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR01MB10511:EE_|YT4PR01MB10406:EE_
X-MS-Office365-Filtering-Correlation-Id: c513ee75-b214-4dc6-7871-08dec9c2a88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|786006|376014|4143699003|18002099003|56012099006|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	f0Pf1RIzUzvAWE4V2cX9/EU9O29VtxdWDC3faAMwpqEW9Kzi9hLslxn32qBKioIclf3jeL4HADnB7uzMvmjq2L65bO8sfcge3eh/n+OLBLKTBjeSevhEphRybDvzhO2QbOmZjDYbd4zVzdD//8yk1uqBLeZxpaMpWs31N44cH4/bOjSQs5gYM1ioqDm0BqmBaIdjTUVXBe2U0eIU6/cT4IugfYW3wHF2Aw1wD3Kb/5Jzy8EJF1Pt6e+olQ1Qxlpcdkmcsak9Exl4mE58YcErCm6uwA+OEiEQdBPhPlUdFh4Z3WxDqOH94YZNdUJ8BGJ4mx+2UBTUmZj9kvCv4Mqjw7IqzAB7f4k7XcxBQzV9tbPRBs3+8g0vl8WmmzD0VFautOID5Ww9rfE/2yLCUAH6pc7jogTq6uTFtllQmWT4sxd6A9d/IYuh6+am6iyRb+JtaNfud8kSxIVvuzqOq3qVVhJMt+/ECpQB5bR49UM8Qfa71NpbslBoAb4UxhRvaPbULHkOzcWjbjVpt9h4RbSec8kxJk68ETW6B5tdVK6Oe/a3LxtxXq0dNeBAxgJlXOiVaSR99mavF8393AT+OnM7c6WSYy3QxyGARq0yws58PXr4PKnZZ768ZUuPtwAKXz0Dp3VmwBQt8ni0xOcZomnCjuiywdYuV0ASDAMz8JAfOHIE4qwY+QyOMoqmH2eJDw0b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR01MB10511.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(786006)(376014)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzVCNGg4RVRsbHpzclhxVEFqNlZYSW9ZK2hoT1o3NTRzYlJBRkUvaVVFQWpJ?=
 =?utf-8?B?RUlEa1VHT3FsNjhxbFNtbmpmYk5BMlkrek13Q3ZnLzIvcDdnbllhWVpPaTEz?=
 =?utf-8?B?WXkrVjZJNnp2SzBmVHZqVHpOT3g5TUpPZGE0UWlPYlBtV3hsTGhaWFJBbzRw?=
 =?utf-8?B?RUhRT3lad2hDOFVCbC9PVklpQUFYT1NTRmV6bDYrSVN0RWlvOWN0WGFEcUZM?=
 =?utf-8?B?OWNRWm15RGs0akNwSFJpaUl4TnNEaGdqY3F5bU1seWdhKzBTQ0tPM2VYRkc4?=
 =?utf-8?B?bU9TSnUvbCtXdE0waU15cHJiMVBiQ2VBbHZtRHlsUjRlcmdlR1BVeVY5OGFl?=
 =?utf-8?B?dUtNb0FuTHVDOW5nQjZwVStxamNuTUYyM0dyNThkUHdVcitnK1RjRCt4TjY1?=
 =?utf-8?B?eUFvNlFHeERoRVdLc3BLSFlqQ002clhGUDUxa253b05xTFRCTEo5dXRtSkRm?=
 =?utf-8?B?dFkrRk12Qm40R3BMSCtHcVpQcElZKzlKcHdjTFJKbU13VUN5THZQY0w5emR5?=
 =?utf-8?B?SWlxekJkNzdqTEdscDFTVTcvejdTbHJXN2dDTXN2S1p0d0g2MTVrNmN1MXJX?=
 =?utf-8?B?cXlZWHJaR0J1UjBDY0pnZWV0VWJEVkNYVWRqWHJnUUNCTTk0d0txT28zMWxz?=
 =?utf-8?B?dXpKVmE2SHdadG9lOGpuWDI4NC8yZENMdldaTkJZZWVMcFVNMHJQRGo5Ri9O?=
 =?utf-8?B?QUN5cGVSVVNheHNKU0ZSL1lvQkMyQ0w2THo0aTJWVEN6ZjcyTXFFa3VlVnlR?=
 =?utf-8?B?b0NnZ0VDc2oxYlFrcmNEREtlSWZZdUFBVzNHd3hRd0FDZUFpRjJYb0hVQ3Ux?=
 =?utf-8?B?Tjduc0hYT3NqR1FLangwSW5FMWc0TExsczJJQStkTUc4cG1sWEk4OWN5M3M0?=
 =?utf-8?B?dENXcUdUNytqU3pSdGlKM1V6TXB1WkNZM2NpVkxHT3RianNpYlgrdG9zZlBu?=
 =?utf-8?B?M3dUKytQdjYxVUxad281bXloSWpxNkJlRU9YSGNsSVFvNStnT2UvUEpXU3ln?=
 =?utf-8?B?MEl3cUxWSUg2dFRIUmlBeXhnVFcyTm81YWdqVFo4ajcwK21GM1l5YnFzMnVi?=
 =?utf-8?B?NTk4Uk14ZjBtQ2w0MTBiTnBwK3lYOVcvYzRhYUF2WHJPaDd2cGNaQ2JVNGwz?=
 =?utf-8?B?R3BEWjdKWUVNWVdXeTViQmxiRnpUMWVQV1pyZnhOMFRQenBWWEREampTWnUy?=
 =?utf-8?B?WHJXZHdVbU5XdUVzRDNFTzR5S2lXQm42WnlzeVpGVHpacUhROWN6R1dEWURD?=
 =?utf-8?B?bzVvdmpYbTlodlozMzdUTEF6Ni9admNGZnBTaDhoNCsyc3BuNHZmMmpEcmRH?=
 =?utf-8?B?SGd3WGEyeTBZeCt2amYrNEVYN2JxVEhxYlVrTjd0UmV5MFFLeUVUN1FRVmtl?=
 =?utf-8?B?dE1iK09ORVJjWWY3OXAwZ01PU1JMckpldlV6Z0U4YW5PSmRTZjFTQkd4ZVNm?=
 =?utf-8?B?clY3blpSVm14ZlBWSTEzSktWenJnQ1BoZUI5NnA5QmVFYWVIYSt1eTNqRytH?=
 =?utf-8?B?clc5ZFM0TzBwallMQVZoWTJud3FFVXNZamhqbEVrRGJycG9WTkR4R2tqSy9a?=
 =?utf-8?B?MUhWZCtFcVVlYWpUVUZJTWtqdlltTGRibk50aVhHT29nRWVWS0l1WDc3OWNG?=
 =?utf-8?B?c202SXZJRFpONkdTODFIbzArVUpSTVdHNkEyaU0xVTR2YWU0WTluazBPZ095?=
 =?utf-8?B?VnRIY3FaQjgrYVB6Mm8zSDN3dW1LT05TYWtSaUFZcXBqN3FDaXhKZFNMWHpy?=
 =?utf-8?B?TXRPczBiMVBVOGI4L1NCd3hUem5Oc1JadjBSSGE1SE9VdFAyNXJaRVNubVFm?=
 =?utf-8?B?b3VPRmExTm95YW9mMysyRkgvWE1yczBkcktMWkxOQ0M0eThjdFVPUHZCTlU2?=
 =?utf-8?B?Q2Z2VXFEZjRtM2paQTRWRGtCdnJCQzRBaGQyaTRFV2kzR05BcHl0WjVoVUZ4?=
 =?utf-8?B?YWx1UHg3bEFVUi9EbXYvcVhHanNJQjhvMkhFcUFRSjJXWHd3dkZXUi9JTml6?=
 =?utf-8?B?MDdQYlFRbTlEYUtsVVJQem9TRXZnZEoveU5EdFJ0VmlJN1ZOb3FobDN0OXVy?=
 =?utf-8?B?OUpqNFRqRVFJQmxYbkVCKzV5ZHVpMGVjNCtuMnBIdDRDbWVaNTMvTWR5d2sw?=
 =?utf-8?B?QjlrK05ubmUreC9yU3NqNlU5UklXbkdZWDJnNnRKd01oczFFYkV5dCtNbE1Z?=
 =?utf-8?B?UXRYMnd5RXpPZ29NV05tRmcwckxNRmJzRTAwUTJWYnAya3FIdDlNWjRSMjFC?=
 =?utf-8?B?RGIzT0d4WlNibU4vRXErOGZxS1VESlBkaUxzVVRRa2t4VnExWDV2cWk5NGJa?=
 =?utf-8?B?VHh1YjBvb1dmZU5KbXZRMFV3eWw1ZVNQNnB4L1FTeFlOQ09KWDh4UT09?=
X-Exchange-RoutingPolicyChecked:
	nR5kyx/y2cIeg+SYiQymxRoExjMqX7ivuSLSwc9YRdgDqCaiWl2j31y/9CRmZk5g5n/L6hWLrbe/gCXGKRgyNPNsMGnFyW+dEdejzL27MIbIdF2K60NVTbOME48j1DdF1YRntOrqPFOkVBznUn5Kc0FZncnFNZH+3sUO2PpVxlUk9Gxr86BqcBzNtkBOowvb0p1d3824Oixo5UptHFNhf47izHqBJaA6Z5VmsBccTeHlcBFF+I3ZZIea28Z+E+dLZkh814Ol4Xzg9u/ekaO9uDQqL8sTO6rTI+3GaPRHtCGa+D+MfL5d0OKsrlTtSFLXtyZKMHKSmYqO8o4qS0Maag==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S6JSZH2pQ3xIMZqYoSTNQ1MswkPbpmUucf1yKyKjTiOvVx54yLjS5/ziSiWmyk2+sKBDa3Ge49sb+aLkTuIe5LtYuJ60GS5JqL9LO8MyOwupydKOW7ZgpAkWzwNKLnOwnDMedFN5f6C95LP+6iJnBvX4noW3Vyp8kY0NMYVLKv1DZPqYiIpr65iRMMhHrPdi/I26WpZr0zPjRzwUH0ZWnGGHJQRcghLRnky0jz4ARKCmLaEZsFKv1Ai6/T2WeDfoKlQSYWSiPCvnQfOAFVEj0HvrOYUVeLrSZaPysWugKEkcQog9bv49PwpJadfJRQ/xaE41aX7Aqye7EXNQCTERjHDms+HZj4dsXl7+AMzuKqpb93dNgcwEkFt02RivPq2ciZqV/siKgeBgBhqwMTuuuEiGRUFnJSKSXW4VlLgm4ISMROHjq7a2mCBZwfJrkC5Cuut2asmzrob+8I8HgiFdwgIWYbhAw/GJGxhSaMVYp3zeMolsbRgyK5ke5ADspI2evuL7vZy9ndN+za5I/NXQAgP7lar6mtQVfPcH0PxgNLI2ECNKCn7sjC+0smdZiog9luy1P1ir6yB3whvX5m3zN7ei4cTyJnOF2W2svzSdM/7MqxZGKvCMfvMsw8aFM/dI
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: c513ee75-b214-4dc6-7871-08dec9c2a88e
X-MS-Exchange-CrossTenant-AuthSource: YQBPR01MB10511.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 03:11:42.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PI/931wglJbH98qYrepwrD3cbx/NX+Ln+8rH8Wn2saFmuccLhkuRT/iC2Qx9I4pAHxXgVOLh97B+SkevOlISCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10406

Hello Eduard,

Thank you for the response.

> In theory, the normalization function is unnecessary, if something
> hits a full circle, then the primitive functions shouldn't be
> sensitive to exact starting position.
> However, I wanted a representation for an for empty cnum w/o adding
> more fields to the cnum structure, and I picked the { UT_MAX, UT_MAX }
> pair for this purpose. Which added a requirement for normalization.
> The idea is to guard for is_empty() at relevant operations and to
> apply normalize() to the results of the operations that can produce a
> { UT_MAX, UT_MAX } as a legit full-circle value.

Yes, we see the benefit of having a representation for an empty cnum 
(for example, to return from intersection operations) that does not 
increase the size of the cnum struct. So the idea is that if size = 
UT_MAX, the base is irrelevant, so we can introduce a normalization 
function which "resets" base = 0, and "free up" { .base = x, .size = 
UT_MAX } for all x != 0 to have other interpretations.

> Hence, normalize(EMPTY) is not supposed to be called ever.

As implemented, `add` and `negate` can and do call normalize(EMPTY). For 
example, suppose:

	struct cnum a = { .base = 1, .size = UT_MAX - 1 };
	struct cnum b = { .base = UT_MAX - 1, .size = 1 };

Then, consider what happens if we call add(a, b). Neither is empty, and 
thus this condition does not hold:

	if (FN(is_empty)(a) || FN(is_empty)(b))
		return EMPTY;

Then, since `a.size = UT_MAX - 1` and `b.size = 1`, this condition also 
does not hold:

	if (a.size > UT_MAX - b.size)
		return (struct cnum_t){ 0, (ut)UT_MAX };

As such, we go to:

	else
		return FN(normalize)((struct cnum_t){ a.base + b.base, a.size + b.size });

Here, a.base + b.base = 1 + UT_MAX - 1 = UT_MAX and a.size + b.size = 
UT_MAX - 1 + 1 = UT_MAX, and so this is calling normalize with argument 
EMPTY. Then `normalize` sends EMPTY to UNBOUNDED, and add(a, b) returns 
UNBOUNDED.

To us, this is strange: `normalize` should not be changing the meaning 
of its argument like this. That is, if we let "gamma(c)" mean "the set 
of possible unsigned integers contained in the cnum c", we wish that:

	forall (c:cnum), gamma(c) == gamma(normalize(c))

and not that:

	forall (c:cnum),
		(c == EMPTY    ==> normalize(c) == UNBOUNDED)
		&& (c != EMPTY ==> gamma(c) == gamma(normalize(c)))

which is what the current implementation does.

> As for the patch itself, it seems it just inlines the normalize()
> calls in-place, so I don't see why it's needed, tbh.
> normalize() is not an externally visible function.
> Shouldn't it be possible for the proof assistant to do such inlining
> on it's own?

In some sense, yes, that is what we have done -- and you are correct 
that the proof assistant does not need us to manually do the inlining 
for it. That said, and even though the function is not externally 
visible, we think that it could benefit from having more straightforward 
semantics.

Ultimately, it's possible that our concern is just with how the function 
is named. To us, if `normalize(x) = y`, then x and y should be 
essentially interchangeable, ie. y is just a different way of 
representing the "meaning" of x. As such, normalize should not send 
EMPTY to UNBOUNDED, and `add` and `negate` certainly should not rely on 
this behaviour. `normalize` should only set .base = 0 whenever it is 
passed a "truly" unbounded cnum (ie. a cnum w/ .size = UT_MAX, .base != 
0, .base != UT_MAX).

Cheers,
Hugh Coleman

On 2026-06-12 12:08, Eduard Zingerman wrote:
> On Wed, 2026-06-10 at 19:21 -0700, Hugh Coleman wrote:
> 
> Hi Hugh,
> 
> Sorry for the delayed response.
> CC'ing mailing list in case people have some additional opinions.
> 
>> I'm a research assistant working with a PhD student at the University of
>> British Columbia (cc'ed). Broadly, we're working on formalizing the
>> soundness of the eBPF verifier in the F* programming language.
> 
> Nice to meet someone from Vancouver here.
> 
>> So far, we have been able to prove the soundness of the "circular
>> number" operations you implemented earlier this year in `cnum.c` and
>> `cnum_defs.h`. However, we were a little surprised by the implementation
>> of `cnumXX_normalize` (specific emphasis added):
>>
>> static inline struct cnum_t FN(normalize)(struct cnum_t cnum)
>> {
>>     if (cnum.size == UT_MAX && cnum.base != 0 && cnum.base != (ut)ST_MAX)
>>     //                                                        ^^^^^^^^^^
>>       cnum.base = 0;
>>     return cnum;
>> }
>>
>> To us, the natural requirement that this function should satisfy is
>> that: `x` is a concretization of (the cnum) `C` if and only if `x` is a
>> concretization of `normalize(C)`. That is, `normalize` should faithfully
>> preserve the domain of possible values. However, as written, this
>> normalization function doesn't quite do this, as the condition checks
>> for `(ut)ST_MAX` (0x7fff...) rather than `UT_MAX`. In particular, this
>> means that it sends the empty cnum to the unbounded cnum. We're
>> wondering if there's a reason it was chosen to be implemented this way.
> 
> In theory, the normalization function is unnecessary, if something
> hits a full circle, then the primitive functions shouldn't be
> sensitive to exact starting position.
> However, I wanted a representation for an for empty cnum w/o adding
> more fields to the cnum structure, and I picked the { UT_MAX, UT_MAX }
> pair for this purpose. Which added a requirement for normalization.
> The idea is to guard for is_empty() at relevant operations and to
> apply normalize() to the results of the operations that can produce a
> { UT_MAX, UT_MAX } as a legit full-circle value.
> 
> Hence, normalize(EMPTY) is not supposed to be called ever.
> 
>> We would propose changing `(ut)ST_MAX` to `UT_MAX`, so that this
>> function has the "if and only if" property described above.
> 
> I vaguely remember one of the test cases ending up sensitive to
> preserving { ST_MAX, UT_MAX }. It was an intermediate result which was
> further narrowed by some operation and that narrowing was not precise
> enough if the intermediate result was normalized to { 0, UT_MAX }.
> 
> However, if I simplify the normalize() function to:
> 
>      struct cnum_t FN(normalize)(struct cnum_t cnum)
>      {
>           if (cnum.size == UT_MAX && cnum.base != 0)
>                   cnum.base = 0;
>           return cnum;
>      }
> 
> I don't see any selftests failing at the moment.
> So, maybe it was a deficiency of some of the non-final versions of
> other primitive operations, and the ST_MAX condition can be removed.
> 
>> Accordingly,
>> since `cnumXX_add` and `cnumXX_negate` depend on this behaviour, we also
>> propose corresponding patches to these functions. (In fact, we can
>> entirely eliminate the need for `normalize`.) We see this as an
>> advantage as it simplifies the implementation of `add` and also
>> eliminates a potentially surprising property of `normalize`.
>>
>> We are not ourselves active kernel contributors, but if you agree with
>> our assessment, hopefully the attached .patch file can be of use to you.
>> We would also be happy to share the F* soundness proofs for these
>> amended operations.
> 
> As for the patch itself, it seems it just inlines the normalize()
> calls in-place, so I don't see why it's needed, tbh.
> normalize() is not an externally visible function.
> Shouldn't it be possible for the proof assistant to do such inlining
> on it's own?
> 
> Best regards,
> Eduard Zingerman

