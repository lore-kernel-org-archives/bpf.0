Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012059.outbound.protection.outlook.com [40.107.75.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F4A2F0C74
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787196483; cv=fail; b=btBduqJQguzMJL0W15qmIwvFrrMe5pYxJRKP+dPctGmNrSnUoxi6bV3ClZ1gKRpuDXr5fuNIPLA9FIzTlrBm74dkr5vQ/hpxNkVBw70EJJxZsbEGjqqd47WI4kOuQS6KU2kFul+y/LfmPrZpDYUscJigqLlVPNp6ZotBriAph10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787196483; c=relaxed/simple;
	bh=a9Vocrlm0hQfXUTlIyeZwyHq+NpxByVdce1pWvm/GwA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BurseycQXh/tBLz1QkMorQVN3h3qNpjq8uTUEczyy826SkAs3mbXvMuBUvY6cLw7vnwUM8jwe8wOshfLrexC12UjBQoskQwvzwsjYf2Evpnn4BIwWM+l5+DouXdPeJLYtaO1sAqXmSpSHlutxzpEJq5Igbka9zaHrPKWrY5ybsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qTUiSAJy; arc=fail smtp.client-ip=40.107.75.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qTUiSAJy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCyyyQk78HVZu6s/tzvMotlUqPF3A7n8ABVnaSOKIUUfnQ6lUKQGE63fUbTYp5yqmV8OOEWdXy2Tq/TOzIvOusk7kYdzIUgqsdOaMzglzkP1MHqdTwj/PRhbl0stagg+F4Gml2Nump65MXqg5kKBKvev/LhqTo7WBCOpfaBk76iMMf34tKAOb7yRV4ox8mSgDAK1Z1x9p/RE5/hNiUooXv8klYx+btJmtUc76cu71tqFITWxmtJzOjTWYaJnI1OX9hgIeC99GkqFw7WagYrwFb7XylqBtS32xANt+9V/gxHUXEmxo13EhcIlFbKd1cHtgMmB/h4Qkx+a0gT3u1WW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH9mDKi67RNOa3UqEIw0fZ/v+x0lIABFXT/7EPOBFzQ=;
 b=PE6Un8ijvXVyb0IbGRFshcpQIj2E8erINsnZPdc/SrQhkopteTJpWK0LLwGuKUuRJjQ13qGvbk0zwooNtUfK6gtETvsoYoq56vK44JbkaO0QvdA7A5i05u/VbOku83UjeTl/2azg0pNmDhHJlFDhJETicz1dWy3a4wE0T8BkMrwNdwsV2kjc8W27IlSaZOhLOFh8sXbQjWJzZfTl8Z0H4OodEZNsrJxz5IvKV4rzrEUZRFZcuYLCsQ4gCMIaRD4OzUWOY+fRqtnfadwT+cJt5ubVFfTFWkrwUUydC1OujMStS17tLfpWKeUTeW5+bbvX9m9e6hLPZHSu3Gx0hQhC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH9mDKi67RNOa3UqEIw0fZ/v+x0lIABFXT/7EPOBFzQ=;
 b=qTUiSAJyp8ipXy7ZPTdeHncoq33/RpL+BhqTbpYBBN220Pxda9y5zSKAFrPtzVuxCbQF0NzKR0WBxc2V3djkKPsinZAZh1ESZXF0hUCl/K++hy61fWs0AMFsgOC4mria/WNWNsibp1zWMMTNgVFwBnJOqw8TgK/8OuhFy9wmoM3pq1ErPfgnsP3Epu454ieplACwDHiSSjREEH5yO9XoMSem4G48uXITqiuEBZ9zhXzzmx1cwb+RiAEXzl6wo9mjv+PgY6MS2otH1QYpDUIsRaMYLHzn5YQMozE/Lg3XXlD2Ti9ZDAfPlqHRJRajpvDWbs6HQ9siYM2XLkvTHwCing==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SE2PPF4565C7005.apcprd06.prod.outlook.com (2603:1096:108:1::7cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 20 Aug
 2026 03:27:56 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 03:27:56 +0000
Message-ID: <31b304cd-11d8-47f5-a8ee-b26b4b88fcb0@vivo.com>
Date: Thu, 20 Aug 2026 11:27:53 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] libbpf: support selective kernel
 module BTF loading via bpf_object_open_opts
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org
References: <20260819090426.267-2-zhaofuyu@vivo.com>
 <150459b74dba9ea3f0bd133f97039f998e25830ada87b803fcbc6c77b17bcf93@mail.kernel.org>
In-Reply-To: <150459b74dba9ea3f0bd133f97039f998e25830ada87b803fcbc6c77b17bcf93@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SE2PPF4565C7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 0653240b-e97c-4fab-05ab-08defe6b06d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	+34HjOWxvOv89os9sY9tPiS/hAUzEpFc9PKi/t/XScTGkWydjJYxBxKazWSfgw9CuLTlnhBbiydM7E/Il+qSSQEo9XeZxg1CjIXc+wm/a8mt5gEvM9N6DE1GXS15B+l7830PxvTbXWux2vU5jasz5iqP1WWHlI+gUJ3SIaCX/ULKRrirMMnJcMoozyivM9vFDFWRdek9P7U6OjoXdDwdpNq/doacdau43fSW0/OIEWG5sG32TCaPLkzM781X7s4iqHVBSQlQY57OpHe8fqyI8P9EKf9sEiyE9WhyYEVZRBdfy1Lbl64MSXwDW/Sz5kH/0mFmI3/wt+JdQ882Uj7euQDYJd90oiAY6aaQv+3nC6vpG/R77if120buqTwqGaqYWT+JIZZLzpgU6/lHrtvpge4TcZf6CqXiVyuxpqw9C4+H83sbtaLrePdz4H+8+cyNZlok+HjM+JBjTTktts1Ff4q9oByk4swPqgwcYVppid+oD/4P8Jhbj+HOREsUNZzOcetHFxralDGfxdP+yDxAxPVUny6VIHBEx6r3aMAWTcO8EZUlcLbm1ouZEzdjzrDeh2rO9rGdUDhUCSkcqCAHRzivJbBWswX4TdbZggkgYATMnyiDPVYBgx1XyDGNTd21
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXFxTzNUcU9VaEM2WWxGOTlvNzEraGhYcVAzUnc4K1hCdXBRazdyb21heS9y?=
 =?utf-8?B?L2cwSzdMSzJQakd3eDZCS3owZURtVUVLSnhjYzEzNnlSNWhpenNvdy9ha3hB?=
 =?utf-8?B?czM0ZWxtalhnb3BTM1N1VHdlNnhtZXJzTEEwRndleDFyYm5RVW9wWSt3RTZQ?=
 =?utf-8?B?NWtXU2cxaWxmWlJEREZnMElYdDJYUFpKT2FqRXBNM0NqeUZ0ejF5OFZwR3d6?=
 =?utf-8?B?RVRJY1p5bjVTRDVTQnhvbGg4aW9kQ2g3QmtVSE1MbjdVVlRmQlVLYVd1TWpI?=
 =?utf-8?B?QXRNVExTMXMvSE5ZTkZoRE9STVMwTERaK3Z0ZTZHZEZId3FkQlpoak1NRXkr?=
 =?utf-8?B?eXRRWGt1bnp3Wmo1VHdsZUtYZWRnclJlbm1veUk3Vi9tQUxUSjVoTUVrWTFq?=
 =?utf-8?B?dG9IM1hKUG00ZlQwRk5CRVhwMWF3MHdpS05FekViTkFIWEFDcVZqbG5iVTRr?=
 =?utf-8?B?MFU0d0E0Qzh2NXlPby9WNnVLRUJqVXhraUtTUXlrTFFwK1JKK0pPc2VaUjJQ?=
 =?utf-8?B?U1E5Smx0YXJXVkRSSDUrWDUxeUxtWGZQQ0N5SGdxVmtlTlg3dmp5V2w1cUtB?=
 =?utf-8?B?emJkTmQ2WitrQXh5RmZnL2k4NjBiU1h2VVVLelZRVXc4Kzk4WEcyRllLek4z?=
 =?utf-8?B?cDlaMnA2SklYWUx5aG9wdjduV05JTlNqZVdaQUdYTm02V0xsc0gwK2dFaFNi?=
 =?utf-8?B?aitlTFRsZFZFTWlENGZROHlJQlhsU2dkak1kQk1ocDRxd0ZHekZZVkpwWUsv?=
 =?utf-8?B?c1pPQVFxWnZkcWRLSUlUbXA3LzMrZTBYcXhyc2Zaa1hqUmhxSVpuMlNTak90?=
 =?utf-8?B?SDJUSEVFR3FXaU9TUUJhSTg1Yml1aGxFcFZkUER4THIvSVEvRVJmZnBxb2dX?=
 =?utf-8?B?bFl2bVRTM0tOazBUdnVHaUxNWG94YjJWYlZpQVVvblNnNm5ONHdNTTdQMlM1?=
 =?utf-8?B?RmcvVGlYWnh2aEtaaHkyeUdJYmRBUlBXNGF1THdtZ2JmbVJOMURVUFZGaEw5?=
 =?utf-8?B?SUZVc1ZKNm9oM0RHRkd3RXVDajJLQUpVdGhuN21LdURKVXdPT1FkVDdIVk5H?=
 =?utf-8?B?Y1BtM09BY0pSWml3V095ZGk5ZzBwbXh1anhMWnp0QXNJQzlVOFJaSThSR1VZ?=
 =?utf-8?B?dWordmNNQ2pXNkZZNm1BclFYRUVBck1tUFdSZHBYU0hnK2tRTW5oNGxUeHFS?=
 =?utf-8?B?ODdZTlltdDFoOFNyWHIwV2J3RGpjMmtQNkc1NUZwN09UQXBKM0tkaTBONUtr?=
 =?utf-8?B?aE5RMUcxTkpSaWNqZGZiT1FSRW5ZK0tqSUY0MVJ6V29RMmVHK0ZZZFVqZlhZ?=
 =?utf-8?B?QVdUeHdxVUFEY2Z5MitKeGxzeDBmV0xSR3FPenVTY3JYbFArM2NMUjJwOFdH?=
 =?utf-8?B?VXZYQlBsWFVGeHhxVzNKeG93ZnFxTW9TdE1VUWVmdTRwdjZrM25RT0V6V1l3?=
 =?utf-8?B?ejFRS1pVZkl0ZFJlMkg2NTlweU5hZVFTdEZzTVo2dVk3cGlPQ0lrbEdkTGYx?=
 =?utf-8?B?cWMzSTA3VEpuQ04xcnJpcmRqMUoxemRrQm03UDhJZmZWTXgwbmpLdmRHbFlH?=
 =?utf-8?B?aDNkeDhUb3l1aVFTZ3pqdzNPT1VhMysvbDdDVE1WMnZ2RGk3dnl4N25JUU5m?=
 =?utf-8?B?bE1kSzZYWWtlQnRSTkdOOWxseDI1c3MzbEptK01NTE9ka1BPeWlTVGVVMlpz?=
 =?utf-8?B?NlpFT2wxSzBnS0dKQVdNd3I5NUhMU1hLcUhTdE5pVm16b05YdExFZkp4MUpP?=
 =?utf-8?B?OGxhUXZ5bENIYzRzODV0ZSt0NEt4cTkzQ003bmxUUnpNMWd2L2x3L1BJWnAy?=
 =?utf-8?B?YkhFaTU0WmZIeGNveTEvNEFDeERZZW5PWTFPUzlmVW1wT3dncUdidXNuMHhj?=
 =?utf-8?B?ZHppREZSRFZiMUFESXlUQjJrMjlTdEhZS0N2VVBDY1hSOHQwMWdHUmJCTlkx?=
 =?utf-8?B?aUxibDBMbERnRXIxdmVqR3lXLzhwNkNQakdxQTFJVkZncE1Ia2FBQ0VPempG?=
 =?utf-8?B?UVNENEFhT1pRMUZQZE0wVnpBSGl1SkdjbVZWRE1VdlhQN3kwaWZETVQxaElV?=
 =?utf-8?B?VGxlOTRQOHpEODY0RDhDTEJUZ3hWblRCdXo4TUdES2YvT1ByRWw0WDBDNExm?=
 =?utf-8?B?eXlMZjRMa25PTmwxYW04cENHbFZ1dHlyTkhFL0lhMFo3TmpJMGVST0hnWCtV?=
 =?utf-8?B?SGZsblBKRitiZTlSNjdnM1RlTTZIOHJzUGN4MFpsRGp6NWpXaklkVnE3Q3RH?=
 =?utf-8?B?Sy9RY0hXMy94R1ZsOVhtUVAzMmlVYklxSEVycElxckxON2tRSktWWXNRMHF6?=
 =?utf-8?B?Uk5iNkRPREJubVhXRGxoNXlmT1h6SVhQNit4eHJSdXV4ek9vRmpDQT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0653240b-e97c-4fab-05ab-08defe6b06d8
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 03:27:56.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mF9lxv+fB2BcFNwt3gg+IurXU5Z3vX68po+kNnJd+q6HfFH1SaCK78HjmpyhZFoQoX/reYHbhAGKzUElhCu0tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF4565C7005



On 8/19/2026 5:35 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index b749c01742ee..957415341caf 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -782,6 +782,13 @@ struct bpf_object {
>>  	char *token_path;
>>  	int token_fd;
>>
>> +	/* kernel module BTFs to load, as specified via bpf_object_open_opts */
>> +	struct {
>> +		char **names;
>> +		size_t nr_names;
>> +		struct hashmap *names_map;
>> +	} *kmod_btfs;
>> +
> 
> This isn't a bug, but since this holds module names rather than BTFs,
> would a name like kmod_btf_filter read more clearly next to the existing
> btf_modules field?
> 

I think kmod_btfs is sufficiently clear here. It represents the kernel
module names used to select which module BTFs should be loaded. Using
kmod_btf_filter could instead imply filtering BTFs, which would be
ambiguous with the fact that the filter is based on module names.

>>  	char path[];
>>  };
> 
> [ ... ]
> 
>> @@ -5851,6 +5858,121 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>>  	return 0;
>>  }
>>
>> +static size_t mod_name_hash_fn(long key, void *ctx)
>> +{
>> +	return str_hash((char *)key);
>> +}
>> +
>> +static bool mod_name_equal_fn(long key1, long key2, void *ctx)
>> +{
>> +	return strcmp((char *)key1, (char *)key2) == 0;
>> +}
> 
> This isn't a bug, but these look identical to str_hash_fn()/str_equal_fn()
> in btf_dump.c - would it be worth hoisting one copy into libbpf_internal.h
> instead of adding a second pair?
> 

I think it is better to keep these helpers separate. Although they are
currently identical, the two use cases are unrelated and may evolve
independently, so sharing them would unnecessarily couple the implementations.

> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32236360082

