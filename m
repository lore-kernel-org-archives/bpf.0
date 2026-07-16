Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F533C0A05;
	Thu, 16 Jul 2026 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201154; cv=fail; b=DqoXTCm+kYwEb8MHzh0fi8/QiF/iqeDFeVUeJZnmA/FPO4N/V555AXIvdGbQgGYFIGwlayoUXE/A43VxFDFU1RMG2ihqh0AV2etYJ1cUZpYN9oiilI1oqRCD98l0r3ZIU0Z6DkzcP1JEHuiT0E9nuCwJzXl3XmbzrrbqTuI4hmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201154; c=relaxed/simple;
	bh=o0NBm7CrpKs3GEg8qv2bjkdPmDayj7zs6oB6FhcjoVw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j3FlRohEVlbrXPKfdA2qnV4vIdmaWTZT/DKXivTxcKAaxXE2rntPHFNk4f/SLZlO1Pa3kibpepEKTAJCpcyxpV06ZB98DmgnMzFNTVIFOIkgwNB680PVSrlmxSr8KUGxQ0u5309bCo8ezwmBLUORQPFnPpWL5MI+KhTAAsUdC3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3BhNBRH; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3BhNBRH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784201152; x=1815737152;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=o0NBm7CrpKs3GEg8qv2bjkdPmDayj7zs6oB6FhcjoVw=;
  b=i3BhNBRHKD5XS2HuKoJD312kfMo3yc/dGg7brygS+PNf0KdK7eFnowFC
   n7OFfgso6ZyBRuU7B5v/H4JJrEyaI7DLKCX7KDzM9+QFbY0vP/C/UmlBd
   qhaBIOftX1hTXQEpjrrrm0AqeR6t5YY/HBy669YKILjj8xiCnDp2DJrli
   M8TZTBszJGUmJdvnwHlfxicRKQdthlD49MNyUwem0VLKrfvmjlIuGEV0f
   sMfKpH+evaqZknRoLdkeu22Wzueu9ILrcXzdwv6t4p3N0e1ZSLV7BRNr3
   oZ4JVHaFM1PQTyY3g+xtxU1ZUqAUApIYmHYRqDfMpNQWhwcCAxwLJ0mWT
   A==;
X-CSE-ConnectionGUID: WPoHsAfSSTmkfmptMgPx3A==
X-CSE-MsgGUID: 50nqP/XSSoqJ6lc0Lru/PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96372841"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="96372841"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 04:25:52 -0700
X-CSE-ConnectionGUID: BnT/FzH4Qp+dCK+/LjvCUA==
X-CSE-MsgGUID: OS9CgE8dTty6pWzwR/TxZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="260772964"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 04:25:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 04:25:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 04:25:51 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 04:25:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZs+a8B/uTCMQh4uxT0eG0CwwbsJ5opyzzdRmzbxEk7rfcfOgb517IqVxXLKihVVNFeko6dUF8HT0+dvH1NEpZj4zXDVPuh9cdKD8B0i0dWetHLnvNm3hDV4F4I4IyZUKlfs0O1/bwV3GbMturLZo0SPrcSTTxqLZpuhvZyIL1XuzBmqUZGfVtqtcEcqXZm4LHzs8M6X+752QCJ0rF8OvkhkmPkzJonuEcDz9pCjpWkcREcK+oWh8tTgnNDKQZDL/GYqsdaG4nnVCWjb+P6Xs39Zdi2i9/w7JfMnrY+qkU4WZMkuwaSovrYOnN5KHJWIXgqtfROI8gZK6wB4YBD9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0CVDWasAGbqw4AZL+egZ4W52FYRaIrGr1Q01b0aFX8=;
 b=duxybzYp7ZC4XR5TRX7bTRfQS6a1bkxkeVihmMnRAyukB8nR3/hmakDg97//4BOyh6+LExGMoZNQkEV6QmYysxiMMHdb2V5O+XkjVyTRHvbJ00xU0Aqnk1mpBxPJd/3XA6HrLhuIxM4ailT4HOYaEZX59FBB633CyA6xZwHMM6BSd0eAoN1frJsPbwE9Jj0EgJcRQFF5VGYb06SSm3TRIduW9sfikT/1qSFPUBRcOUFg/Rc704NRrqQbX+O+ep1E9pvjKXDGh5UZF4QiKhMQk6MSxgLAgAlezjob6b4VauRkeqg3TCtmBb9eR/vXUiItvEuNGxZ7leDb7ImgnKYBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH3PPFB8E59DF50.namprd11.prod.outlook.com (2603:10b6:518:1::d44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 11:25:48 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 11:25:48 +0000
Date: Thu, 16 Jul 2026 13:25:36 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <bjorn@kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH v3 net 1/6] xsk: fix buffer leak in xsk_drop_skb() for
 AF_XDP multi-buffer Tx
Message-ID: <ali/sIjljiNm9RmI@boxer>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-2-maciej.fijalkowski@intel.com>
 <CAL+tcoAc7d8MSCqK23_pmL2G8tSS-MpfM53brijPntv5A+BA2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAc7d8MSCqK23_pmL2G8tSS-MpfM53brijPntv5A+BA2Q@mail.gmail.com>
X-ClientProxiedBy: VIUP296CA0035.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH3PPFB8E59DF50:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8ba77d-e751-41ca-880a-08dee32cfbfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OK6eUwKwTj7urj8hi4tle5ls1IB7wiPT+Q52O3oihyjBEoo3tyc8Naa7T11Qa+JGpZlzpdJBiBrPMQpY5EJ8n/a2+AuWZGbOyvjwNqxGCXbk4NNjG8hzgnKlKtx2kN223dvBPDz50Nlc7Nv4DcyDdaOU1WEqEeGKOAZnwdrusZ/BSKllsR4gizPbyQkgXe36JQQI1WzzO5iCBYCSccrPXoWFvmXPbROH5oJrC6L6q/cZwCruxQomvbiHJoy3rYofWSkGcMm2JiolHtUR3w4bPR2jaoOdFzE5qvflQC0CqsNOU1LpTo+fKzMHkytx35ZTQ4MXMWZsI6/hPE7TP9nEbsyPZw8CzpVlqdukJKyYyD/BPc/jE44+Nj2VVcN1tBC8qhkgnuUwoNNfP3GdXUINXTwYFpacircCj0TmREK8j+aWfT6yjZL/kAtiwzDvZOQOU2mwmVfjhH6kNVD2gUAnjC23X4cxoaXr3NM0op8hbNLqDPJbWTljov3dTB5fVnPMhonsYV4Y9VwfSKIf3Ltm67NbJAYD449JdGV4M57M7g6TxQtaodUebgYtyi4o22A/XmpxluY2hT4kfRiTopnWQ1SKSqD8fwtjcG4ZIYqoh8fZBm12g5QFo8Dxd6nOZ8+gWTRhW5/tOkV269Iw2Hcv2nyRdNtiqxlON06D2oo3oNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHdubE9ZazBtMFBKaU9iSHpXZU1CSytkelVRai9ub2xpWlZBMUI3TGdzVzRx?=
 =?utf-8?B?dk9JUVlKbFF2QUk1ZCtQbitGVHkyM2I3WXFDRE1FMktQRll0ZW5WOFFxczB0?=
 =?utf-8?B?WmllZmtCMTJOS1BxSERqV0dPbk5hR29qU1Jzejd3dXE2cWNKMEdxWTI1WEVk?=
 =?utf-8?B?VU1jWFR2VmRpRjBuU0ZZM3ZJRUNFWWZXM1lMazRSWmJ4eXRsM3FrV0pzbVdt?=
 =?utf-8?B?Q2dXdVZlYkw1SjJJRWlvamc5OUJGQWNnZzE2S1k5aENSR3FLaUdJUEF1RUU2?=
 =?utf-8?B?bWt3eGNkM2ZaWWo3SGxpNVRZNjVYdTlLanI4QkJOTnB1aG13cXF4dXFSZ0J1?=
 =?utf-8?B?TTBKeEdIQ0kyU1hUWUN0ZmU4UG9zci94TDRCbUE2RzdGMGRxWENnSFNCbDlx?=
 =?utf-8?B?MXJZaWN5dEd1b0tiR2xnNG5WMzNPOGt0Y1BFN2w4SUF0N0N6WEdiZDVGa09J?=
 =?utf-8?B?aXhEcENyTFNpZTFhYTNGN0lKUW5EWEgyM09ra0NOMkh2TG1xVFg0VWtXNU5t?=
 =?utf-8?B?MzNRRERQVG1oT1NYa0szUmpuSlEzZm9sNFRGWnQ3VjgyMUM4NWFpZGMwMkFu?=
 =?utf-8?B?SFNwTTBXVEhybnB5NlloR3QxZHhzSm05QlJ3QTRLWGw0aERMY21nTWNCQ0xH?=
 =?utf-8?B?Yis0aHFqUHNianpLUHV6dVpPLzlQTzlQRUhTb3d4NEo1MThuRFlPYnc4QS9M?=
 =?utf-8?B?ZStLT1pUSHhsUTNVMlB2SHlpajRwMjhUNnM5VmplWFBmK3l0cTlkcC9LU1Ni?=
 =?utf-8?B?a3c0L2FBeGFoRVZLSHdneTlleldWdjZoNmxzM0ZkK1ZaVnZSN3d1cGFXQjhK?=
 =?utf-8?B?ejlnVGlPdzJqeENQV3FrSnpaNm5NME84aHpFcVRiWHBkUlZxSlhHSXFlK2xL?=
 =?utf-8?B?V1lBMGVDb3dPN1M3NEZFakMwN0JiOWVOOS9KcnBNbmJoVDgvTVJqUmtSU2Rv?=
 =?utf-8?B?OHU4MC9DVlNleEF3TE5vZWhET2FwdHNxbW5wa1JnNVFSck4wbkt1allrZFpz?=
 =?utf-8?B?VWl6U3dQOUxIZUpUOEl0ZGkyU25QaDFjSTlkMDhCYzZNMllydG50Vk5DTnBr?=
 =?utf-8?B?bnRjbUQ5ME1ydW1GclQ2aTN6bnFxbjVobnhqcEJPQXlpU3ZTSlNEUTU3NU1C?=
 =?utf-8?B?WmVCajhHNy9JVzVzeFpQVFJTbUF5L1BuYzJSQlViemIyYlVFMTRtbm5LbFlZ?=
 =?utf-8?B?eTFWSmFPdXlkdmVIcFlaZmhqdDhTK1FpT2pIcCtDNE1VQjU0cDluUVlsZlFw?=
 =?utf-8?B?TWtoQ2w4QlplZHNOTXYzeWNsNmNIdFZEL1BlNGh2b0ZqSFV2VTQyVmJGaE1V?=
 =?utf-8?B?NkcvSE9YWDA3RXBjWk05T2pjc0RIVjNYeFlIWkpCTUViQ2xKWkROMS9lLzNn?=
 =?utf-8?B?UmlocHBGSjUxc3duSGYxclZrNUFpWWhSOE0zRnZCRlNuZmxKWkNkM2wxY08v?=
 =?utf-8?B?TEkxaEg0bmdjWE9qbjZFVURzTXhKZjd4SlZHbnpFa3BZZ2tZQXN4Zm1aRkRQ?=
 =?utf-8?B?VnVyYWdPS2dSb0dtRUplNm1YQThLQ2tvTGc4a24weU1iYW9pdnlOSkNSMmJD?=
 =?utf-8?B?Qkl1TEladW8xQnpwMFR2R1FBQkw3K3VnbENvNC8yWFZEbE9lbURzYitiU05n?=
 =?utf-8?B?OWs0bEtjYmxMQXZvakEwamFtaU51UlljQ0Rpb1A4TjJTaEVHbm0zRUNocTRo?=
 =?utf-8?B?TnNsZ3F6QUp2ekwxUHBHVjdHZ0JHZ1NuMUlzaWxiYmZ0cGdKZzNSRmxnU1lP?=
 =?utf-8?B?VnM4NTNlUG1PbXoyM3B1VjE2bERQVllxbW15VVNmRDVLOWhyYlBpZVZ1OGZl?=
 =?utf-8?B?dWFMbXowR0RzSkRKNHBZcUdRSlBNaExpYnhmR0JIell1NXNIWXdHN0xhQkFx?=
 =?utf-8?B?OWRaaDJKbGFWZHRSNENQWlVwanh3YktVejhoMDEyRlZGc1dzeGVoMktLdW1X?=
 =?utf-8?B?T1A2S1h5UmZqSjE3dXFrQlY5UTBOb3pXL09xWlpaTmI5eFM0dFlrN21MV1dV?=
 =?utf-8?B?UlROTjN6cWViT21BNVBmeWpXWHE0VVlQUUZjZExqQTR4UHV3dldKSFdqRnJC?=
 =?utf-8?B?UTdQQmFWRyt5NzZYUUJQNkxLRyt2YXJNT0xmOHQ3NlpDc0djOGJtVlJSL2ow?=
 =?utf-8?B?eGRld09DS1p6bDlOcWNFSW52c0FwanhKdjM0QU1wYWJHbnBldmVNMTFNNCtL?=
 =?utf-8?B?S2JXYTExTEQ5YVk4UkJVSHJUb09uVFR2SFl2UHVRalB5QXJQT0thU3JiYmh5?=
 =?utf-8?B?WHJidWNvQ2dQSUloR2RXbjA1bHVJT2x3UExONW9UaU1JWFFBOWp2anEwTmND?=
 =?utf-8?B?ajJTZUIySTZIU2JzRFNadzAxYjVCTmV5MmV6Z1pJWi9hemY3NUZycm16eHpX?=
 =?utf-8?Q?rT1Kg1qfwjst5Xa8=3D?=
X-Exchange-RoutingPolicyChecked: HLqg8pCBm2nkN5cJrG3w8NrU4aAsrRHAFx4T87AcSHpgEpxZURYiPk5C0qREVlzS65MyybsWOY3XjBC560xi8n0vie26S5L6rCDWFfvQIfHVTmC6JbZjsBGPiLTOgTeb/HfIJD4lU0kSkrtmYLUqL77KqlMJJZvDZrpvsf17OOU81O8SgXDD7ZQEiREaiosOAK4Id6+p0A1Xz7pDVC1Bn/pOTHvIUfkmxMyuK3tFzkTuZNrLC9KerrmftBG8jtGgyXLtMr3bjoLtoMMzrz7e3qtfz2jePW1alZXM/2EsPajL61waZbZE1JtGa4TWiXV21ORA/Gh6OFwCWGQTAHzbag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8ba77d-e751-41ca-880a-08dee32cfbfb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 11:25:47.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1Gny8XBbtaOWPj+6TVTws9hl8gVkHwMvvL74VD0wetE95K8HJBq/75+1G92ZoCMsuTM2NyBX4uV9jIcS637fH7W6GHzKzIChwCVnZL2uO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFB8E59DF50
X-OriginatorOrg: intel.com

On Thu, Jul 16, 2026 at 01:22:24PM +0200, Jason Xing wrote:
> On Tue, Jul 14, 2026 at 4:08 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This patch is inspired by the check[1] from sashiko. It says when
> > overflow happens, the address of cq to be published is invalid.
> > Actually the severer thing is the whole process of publishing the
> > address of cq in this particular case is not right: it should truely
> > publish the address and advance the cached_prod in cq as long as it
> > reads descriptors from txq.
> >
> > The following is the full analysis.
> > xsk_drop_skb() is called in three places, which all discard a partially
> > built multi-buffer skb:
> > 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
> > 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
> >    the TX ring prevents the partial packet from completing
> > 3) xsk_release(): socket close while xs->skb holds an incomplete packet
> >
> > In all three cases, the TX descriptors for the already-processed frags
> > have been consumed from the TX ring (xskq_cons_release), and CQ slots
> > have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> > which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> > the buffer addresses never appear in the completion queue, userspace
> > permanently loses track of these buffers.
> >
> > Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
> > destructor, which already submits buffer addresses to the CQ via
> > xsk_cq_submit_addr_locked().
> >
> > Note that cancelling the descriptors back to the TX ring (via
> > xskq_cons_cancel_n) is not a appropriate option because an oversized
> > packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
> > which is an obviously deadlock bug in the TX path.
> >
> > Also move the desc->addr assignment in xsk_build_skb() above the
> > overflow check so that the current descriptor's address is recorded
> > before a potential -EOVERFLOW jump to free_err, consistent with the
> > zerocopy path in xsk_build_skb_zerocopy().
> >
> > [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> >
> > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
> Maciej, maybe your tag is missing here?

IIRC this has been taken as-is from your patchset. The next one has been
touched in few ways and I included my co-developed tag there.

> 
> Thanks,
> Jason
