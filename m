Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DDA12F585;
	Tue, 28 Jul 2026 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785232794; cv=fail; b=TJWJ6guD/fogYZq5v3FgbX5+BoNCZijJF1JaKgU8b5D71mf0kIjY1Syy0yZqlMfIlWq5Ivu2Vjtvbaqs9PowLw+pU0gu5DDKRcxVvB3+6btjzCkFvf3xIV5+ioI28fYAtdPSkLcshZbSGkw0YlskgK2gdPY2s3TrJg8+irkaGhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785232794; c=relaxed/simple;
	bh=WYfxHDNjZ1k6HbwN4sHuoXATJTiidE9RzH6hurdx1qA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fX2TIcCzbIMP5d0D9wuSRgZPspNog7U9Ca9qBTvyYTiFqpYqHXuPLvsEH+qgb7TZ7thc+/XlE+1DLDFGdJV0ojP/Jie4FHCqoCjEBkbQQJpPTs4NuE2Iwee+O0kZHsTZeIJWPQntXFyRBkYiDnbPedxqxzFd+iZwjmrBueWdLE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rw7Q5QNw; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rw7Q5QNw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785232792; x=1816768792;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WYfxHDNjZ1k6HbwN4sHuoXATJTiidE9RzH6hurdx1qA=;
  b=Rw7Q5QNwG6dsxTav2A2KyyXcSxUehAHzWzXjfUz2VGNrC/8PMimxFupk
   oAzYgbOz+FNbYs2F2139rt9apd5jhNHSAFNB0scFBTu6Ywch8ec1Jgvzt
   F9D8uNB465d1Dj1PJ3YQr10vjJnRBLEEuF3ys6IW7gMbuFOldlZzzxMgp
   zDmzqv7vyICkoErdH/s3awZm+vyHKo7LPaxrxM5gKeH1c7nfKtX9T/nAT
   y7wMhkH73VdNHd9tWkmzWQGIGcsC5KuSj20+ZD+Uzm9VatZrC0vM5CODy
   zgp2Y++dadXQGTDXBYY87hvg5jWQnYmDriQROrsfZCnYVIMIhr22a/svw
   w==;
X-CSE-ConnectionGUID: HtTmnaf4RUWhyv3UxSIiIA==
X-CSE-MsgGUID: wpAh5d1nTZii4f2Xmd+JMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="103352556"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="103352556"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 02:59:52 -0700
X-CSE-ConnectionGUID: RgKuTLAKTyeCuDAzkwqbCQ==
X-CSE-MsgGUID: pSIT2cxuSQy0rMo3Atj5Dg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 02:59:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 02:59:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 02:59:50 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 02:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2+WqGhRHXWNpRi9jSYF6PFq5lpTH4OJ0RmWK3ePrzfDLtIridbu2CFU/HH5+CW4IMOb2HJsUnxPZphuvMNl7gPwqU1Jwwu7woR6YkGjtDaqHmsugIPzmQ/W7FD1mDGf/+0tiVblQezFUQBzYDhmPgM6Di0o1zPibYCQ9EjfcAQ2MOuUoAYlcWiMXxldCIKSgJ5BC0F66xUEIcbN9fOYWu5rE9y1zsMbDysCh2cKeuk55gyLL+maBAAjR4j95NSeyYNz4x2mxQRg3xijbWViukO/5/ZqhFlRVYPukV4HAoY33/5CIZjRoQ/d2NOQPTuaJckDsyNF8vKDeU0nLOLXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YxZY3+U3xv/1vdg070FC3oJLkjmHHNEkdcz/038Po4=;
 b=pKPB7NY2R4bf6R827jJHu037J8UkN2Jg2IAn7htI5GWBOZKW8Bj/E7aB+WY3GzHyHuXW2k4rHJYxIWBbnvDCC0Yw2ecClZIuEjEdxjK00i+UGLWniG8NBZOIHndTq81fYbncp9ZpCHfROSgRsKSENOwmry/nD3DcKm+QFqzWm9AIaEjOL8Z5zrvZFYMp8EJLNRyIpH9AIPF6Lf2ViGxxBWS9GmwjI3kU3VmX5naHpgRnismaPIQYXweAIZZPv2aKxKVgBtKgu4z7jCmnW9D9LFA/Zhs5OynQZ2Ky75DRx6Lf/j9S/5PxV478QNBpNFlS6XLUReENFjDB3Uk9L4Q8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 09:59:43 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 09:59:43 +0000
Date: Tue, 28 Jul 2026 11:59:37 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kernelxing@tencent.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>,
	<andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2] selftests/xsk: decouple xskxceiver and xdp
 apps from test_progs objects
Message-ID: <amh9ibVsNipHg8VH@boxer>
References: <20260728060758.1970618-1-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260728060758.1970618-1-tushar.vyavahare@intel.com>
X-ClientProxiedBy: DUZPR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::11) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW5PR11MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 23037192-b163-4338-4006-08deec8ef258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|11063799006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gN/gJTonTPGB/MLCNucbiCvjhtwrdY4zKIrPLlwAO524b+XzAXTdc6OvXz+JIvbFlc9BnLyhE4tmElmAlHVk4Jfu7mhBCkUJLViwg+mRkKC5JyFOGmo0XzWgfGsSj88vXQrhSDpmKrWMogXukZGnGsXH0On2AWwxeDUOsP0CRWZ1+SOveKArqtUJf68yP7CMzHWlWm8MZSs49om4/606YMhgoRzmCFreIknM2FLGg8GcWTXylDr/MfNUr/5zteFiOPPObwaxPg8Wv8ZR5NaDOJ2IWNMZlS0tbPWkctu6C7k1ZB3hP+9RcMJCARoSo35TgLBVmlz3GA0UqK7IhqtK+7i7hwe30bEplosbKphHeDQdtsk8ccwASSCwErwpiXQkiMNwpJD55PVNGEEB4r1CByqxInBaNOAgDnPbTgJAqmEEQXp0rfnm6POApv61kQgPSmSZW2/J5jLyzCPTpW816VUCCl0zPMR6+QIWfhqXoUEfGiW6IewKzSS6Jc2+pkqh7ijbO8ReSMLld+1NNNJu71Ojz1Z3L2PFVmdgv8hXd5DAHeR1uPcgQfmXq4Q/egJ4AjVYUzzX3eeTOEJlgEIZcp3Vbzby6KJYCLhdKyO1+fcB3NaJvaLiCRRw0aiTiOmgf4LlE+SYi0q33mQp/fhG+Uuzbswkwqzt9XkRj6t7lC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+uHnYnHe22q3el7bVgjC7q7spWzHb4sCmiVKxwxlBA4nGG/JvLjrvHmumzcI?=
 =?us-ascii?Q?V6V6O8GGfziD8wOvNUCa5A5/zNUZ+eOoYysiqZOMh/82G5C5GWayU3RktqMm?=
 =?us-ascii?Q?hODsfqVbsH8E0K/ZYE68gKtu73ihUET4WTe5aIRgLVHSCsj9lLa8KT/mE8/L?=
 =?us-ascii?Q?U2dvinBjccWOOAFqD4Dhev2YBxwl7NVp0zp+AdVyJK0JUlH+U9rfV4Dlbszx?=
 =?us-ascii?Q?TLWfHjWa9seRU2bPkmvWfW+/vS6gN+sYp2+88UWZEuhBcFvZ7CyYjEcMH8+A?=
 =?us-ascii?Q?qKG5HXj24S/XcYQysPGO7OcRd9kNICfOMMz3OUlp0DKPmrxhyuZ5p1p95+Bm?=
 =?us-ascii?Q?Qo6Ojr9DK0sJgHumTIzYnbTuUWUKYmkDGCJLZZBW1s8kzUYfFwryLVDguuAW?=
 =?us-ascii?Q?G0UtEzIFXUtaKXNXTn9y2FZ74cSm2jfn6zsfbuiB/hZybKTyOCBYiPkp6BZF?=
 =?us-ascii?Q?UPxwMrcftz2i8jOTFzNBkNgtI0V9VRPBQm7fdecmuHpzFRXxdvxl8t5tLimH?=
 =?us-ascii?Q?1442m7b5GMR5B3agybqJ4GT69B7fIt2HgrfH/VHKqKEWtwD6pr8GWVk30E8P?=
 =?us-ascii?Q?KM+bjRU9pui2pkifN4xiBt0s6QS5A02C7geNDYTTsw1PK5qquS3i6CDjcTCN?=
 =?us-ascii?Q?DgVzBQDCbfBnkILuAy3tyLqcvw9MKhuxFLMAw36EuLPnvJEQJPMkAfl1yHSU?=
 =?us-ascii?Q?VYU9tDedYvIJ5Q+38MqHiq5kK5S7SLdq1ZJxjwHAQ43VmC3B/+9Mxc5ryoro?=
 =?us-ascii?Q?npTA35qiUx1xoiqsnX9giMj/POIttdknF2g9XbU6c9WPlnKYyFhrbeJRm0OD?=
 =?us-ascii?Q?WWM5v0oUBM1EpQmqx3VzyHmi/bpahi1bGM51WGN0JCrXbK9zBa9pewN7WbB8?=
 =?us-ascii?Q?9Dtr1lf/EXMAXMMtvBR4fJMj8fQAcpxDDl5n7Kr6vB0quGn7wuM/bEw+NdBG?=
 =?us-ascii?Q?RTZ5FpU2S05TkJEz+gpNI1rE2VHWgS4vKpNaoKixDcwQ5AJ6bRwCg1pqfAdF?=
 =?us-ascii?Q?exXOBNiWmC7sZjTbICvPE+xwIFnY41DZZ5684P9WP3wBqwMVulLjjPpjLHf8?=
 =?us-ascii?Q?rzYflMVOCAo3X/Gf8Rxdh9Js7Cw8bbWfRp2fc0QVZzA3D1KlGoozQQf3Dd0w?=
 =?us-ascii?Q?WMKPjAGB3YXLwMmokRR09hrFNf1AmHE/UCxryUBuUzvayn6XGPeLE83NeizU?=
 =?us-ascii?Q?ilX0gCf2teF3QSSqRnLnJpRSPgjYXyECNjnoXupqU0oaeTgks29ECpHOVzeS?=
 =?us-ascii?Q?uw0U9MRQYSi0D1vPJRH1TvVV4uV1MWaHJN52Iy8G3zitqSQeB+Bdb4YlbQ5F?=
 =?us-ascii?Q?CzPduhkyqK8k2WtCFcE/Y/VVWAafVFlgj05Kyhy5d/OmHh4Adb2ddyYPsG/N?=
 =?us-ascii?Q?4JFZxRDI6oj1st80gv3yNA8CrUcON2SWRdXrGjF0ElavI0wdj4Q/xUbcjcj8?=
 =?us-ascii?Q?2vrCwM+b36xXg5VBLkLkTJDnzsJp88lgbULBymlbpG0TZ4MnzY0lXBjZNCiF?=
 =?us-ascii?Q?tBpAJ1lo4R1xKubdWRPDI/bGR/IAYD95KYEH6LQb5IJCdKMSW/n9/69PcjFm?=
 =?us-ascii?Q?O7ChgmdMTvdz3EXGRtz9/2wmHxKXGdqsASueaT2w9ViKThy6WoIZWVytsz5R?=
 =?us-ascii?Q?LwqsoaGpMSBMd7FruGb/1NsF5H5E4OxgEjY2U6M25iOHsORyJpQ3qkQ1r4ka?=
 =?us-ascii?Q?KFP4rXEpvJAVmLTLJfVK471zEww6PtQk+/WmZ8EhlM5ZNPW3HXbquiWEb+Ub?=
 =?us-ascii?Q?CNdT08rpsOqE8EBsc439hsj7zIYj1uA=3D?=
X-Exchange-RoutingPolicyChecked: TlnfqIndy80zuZIH4s4fJ3yDhfyPrl4xsqz2KiAC3sCcTDa8Yj6sZZQM6wbCTzA7cYJ/tgbludUlctbFpu3RZw8S+N0VxqxZHUWCAA8M7F7GlgaxgN7yc8aEwx7BTiqADdOBFb43PAbvZmG2CvifIJZdSys/qfIjylT6kP7Qp5ODCdrrJz1z9r0+PedjEbM2GT8dJPTZwk0CsyNOHFKpDdp4iioyf1NEsgHjg9ctFlab+Re9OVjq4T2q85OWHAUlYPL9tzpNPVSpnjqY5Cf8FvOiJBjnIewzjoxN1LUCIgzFnD44nzTIz0He27jnm+/8p4NfqD8MVABTeWs+g6zjdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 23037192-b163-4338-4006-08deec8ef258
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 09:59:43.7412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlcTv7LaSvd+byAyT66MYR18CdyNz4fbTUdGHkcZDg2RalM5vWUxzaakPaopr+LoK66To5Hnr714K2+Ws+b62gbUBepb3Gms6nfEg8VrsCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
X-OriginatorOrg: intel.com

On Tue, Jul 28, 2026 at 06:07:58AM +0000, Tushar Vyavahare wrote:
> Build xskxceiver, xdp_hw_metadata, and xdp_features from explicit source
> lists instead of reusing helper objects produced by test_progs rules.
> 
> Reusing shared objects such as network_helpers.o and xsk.o can pull in
> test_progs-only dependency chains and trigger unrelated libarena builds
> when invoking a single target.
> 
> Keep these standalone binaries self-contained so each target builds only
> its own required sources and BPF skeleton dependencies.
> 
> ---
> v2:
> - Inline dependency lists in tools/testing/selftests/bpf/Makefile.
> - Drop *_SRC helper variables per review feedback.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Your SoB should go above ---

Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  tools/testing/selftests/bpf/Makefile | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index b642ee489ea6..f4e78bf8ec80 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -934,17 +934,26 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>  
> -# Include find_bit.c to compile xskxceiver.
> -EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c prog_tests/test_xsk.h
> -$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
> +# Keep xskxceiver independent from test_progs object dependencies.
> +$(OUTPUT)/xskxceiver: xskxceiver.c xsk.c network_helpers.c \
> +			   $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c \
> +			   xskxceiver.h xsk.h network_helpers.h \
> +			   prog_tests/test_xsk.h test_progs.h bpf_util.h \
> +			   $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>  
> -$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xdp_hw_metadata.skel.h | $(OUTPUT)
> +$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c xsk.c network_helpers.c \
> +			   $(TOOLSDIR)/lib/find_bit.c xdp_metadata.h \
> +			   xsk.h network_helpers.h test_progs.h bpf_util.h \
> +			   $(OUTPUT)/xdp_hw_metadata.skel.h $(BPFOBJ) | $(OUTPUT)
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>  
> -$(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp_features.skel.h | $(OUTPUT)
> +$(OUTPUT)/xdp_features: xdp_features.c network_helpers.c xdp_features.h \
> +			   network_helpers.h \
> +			   test_progs.h bpf_util.h $(OUTPUT)/xdp_features.skel.h \
> +			   $(BPFOBJ) | $(OUTPUT)
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>  
> -- 
> 2.43.0
> 
