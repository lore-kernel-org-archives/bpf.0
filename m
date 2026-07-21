Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076639903B;
	Tue, 21 Jul 2026 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657083; cv=fail; b=pNnIdz8Vs0VuZiQt+eKIhwn9uw76v/gkCm9sLgEEFuizfTe4VdnwOBybFwncTphsQK1yCKgbY7wKyr0Th8yJFSUI/5qUoImVd75+jAtJHtM9+imO2T6AmiToXxV2G+L6bXMuZWyXd7nGlliQzbzC/vOfA0wY9zG/AJTYgSgdeuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657083; c=relaxed/simple;
	bh=kDRxvMIQ8ztzU12gt4a3oifyDCsKNPDmp4szvrSTMcQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c8zc5Ci7DbXA8lp16kg2dOshXdva3Y28TSrT6GpiAr4h6asD9BnnDXgSiaBMvUgkVCP06hQIcDPJ+R1/YRl+ji+aagsp45MqWpo1wW9KfPJWGFIKF18ZmveNiRAo7YfHcyE6gPK1366HWhwkZB6/gLVdqd251/l86+1EnkOj3RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMn3N9O9; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMn3N9O9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784657082; x=1816193082;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kDRxvMIQ8ztzU12gt4a3oifyDCsKNPDmp4szvrSTMcQ=;
  b=DMn3N9O9FqRujtD5go60TSpnjoItoij01KC+zYnHP2lAn4xZEBq/CTVh
   3YgeY+AKK+6SLg/frBMw9MSeS9v3SuNDGxCpvkk2x69+uY6v09LdwZhyS
   arPg1lPEWt0Asuq4hq6owR98o4FrJKG3hcN850HU8uOEThJjy/RVSe7W1
   tuioKcbX59I9IGRuca0aNhy28toeUTVwTk4oxbfZO16j+ubZPxwZO/U2a
   84ezjjjuc7rFc7LVpwdVv8hmLBwooFOXR7KAHR8Ggv1A5qiNpzpoBhkPO
   HSrchxRbS0zff9wEQ/lGF1QsE2+qj4lbeWYuMgmbAK/elbz/4FTIXmjOv
   g==;
X-CSE-ConnectionGUID: r1KgCpmIQhyRzQX+VbWEPg==
X-CSE-MsgGUID: ySbwh/kRQ+ijs51XsPccTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="110818449"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="110818449"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 11:04:41 -0700
X-CSE-ConnectionGUID: J3mbZnLISAKILg7vMfCP1Q==
X-CSE-MsgGUID: 7rdrJS38RZC2YV3WvRpr6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="296042967"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 11:04:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 11:04:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 11:04:40 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.17)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 11:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1r8UFFfw5Uj0/4Zq0eYBmesVnJfnk2UTfA2kx6MQBMz5cumG2vNHbgaslqg+TegMirOsYHjSa2D85G1YfwsQ2cWumj9QV0Mct4ZBCr1kvQ/f4E7A++L3B+JbadF5Oul5aYeuH5gYbzxHnvIcqueh0yi/4hAJgtgwcD+q/Z6uIcSuhNknZpxsjE9cF2QM18VhdBLyvsp3kWr9fVlX/ihfVatIzipT6duofOFzuQeMgkmeMffibmbzmGLAYCKRBUu3dJOHediglw/8EKwBqInzEIypvJa4FLzbOCZVBFbT4L8hTXj7AohlPSoHIOOE3WzCh91niDrWNZpfCYmJbcKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRGuf0kORK9lBQ1jYWRbmCmk1VxoABPWYz1Wgx3LzjY=;
 b=oA0gBzjJ8K7Q1Auia1VreNftVZ3CeKBtMjag5OWZoOrsKFEsj/nHmV+oaDS0sVGl+N/3tfIvPjxQpUq4LHRNE9C5sD5K8HQlFGwHUbn1EuIGjx5XyrV7hP0M4sxajNpfy5Cd5Jptez+sLh3Lcf0M/IYJkDnANuc2UbktGzonieEUfHjcRU6hWWyp06NioxmwfWaFBr5GxI01wnfhf96Drh61LKi7+Gm++1UNL7swRJhox2ZKwtudEfGEeTHCJP6BzY4SfEVyEVJf30L5ft65RKVQujlrcZHat60pkCGib7ftbdO/J4E/XvlRCKqmqoKXQFHTUPIqQCQGT8cKgOMFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB6774.namprd11.prod.outlook.com (2603:10b6:806:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 18:04:30 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 18:04:30 +0000
Date: Tue, 21 Jul 2026 20:04:24 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev@vger.kernel.org>
CC: <bpf@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <bjorn@kernel.org>, <kerneljasonxing@gmail.com>, "Jason
 Xing" <kernelxing@tencent.com>
Subject: Re: [PATCH v4 net 2/6] xsk: drain continuation descs after overflow
 in xsk_build_skb()
Message-ID: <al+0qKu1U7kutrih@boxer>
References: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
 <20260719135609.147823-3-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260719135609.147823-3-maciej.fijalkowski@intel.com>
X-ClientProxiedBy: AS4P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a8c994-de1e-457f-a615-08dee75282bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|6133799003|4143699003|56012099006|10067099003|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: A1uw6Pj75DqlZ2vU73/LBgDQwFTTCJjSZBEQGBNDPIZemNCom+jyWoT4IXJvx3ldAKaSk87eRAPi/PEA3DP1wWiYXOIcTXf1C3dzh4yQbBULoQZkMfJ7ddMp53r7PiuQXz96bVpNxkCRgNiKnl7UcqVX+SUFxKkGmXk88Tw5FSl8sit0TpvZUvU08iN+MNkLKL5D+jL3DT09nMM8ZEdb/1c81WeEfhcof8/B+evKi8Wxs8y58h15vHQPrqaCZxUc3IDuZ4rUvDlyFVg/pIjWkqE12lBkYyFZ0FywRusHYCcfNnoilOyRsufE/dd3NXVCvhiJae0XZqfI3REre27MYHLf7NCRS9yELTka24J1OKD4v+gvsRXz5FpQRKnlNIwnajFKbK7C5kKmK9B2rw3dW2af1m0Tec6pioaG3QYeba2+dYoRYopnHdnR0982ZUEELT33eoB/Rq++YwkMZxjyqdutDjfsWS5REvXZANCK3JJ8E3Gq2OesfYVsIKe/+IB3UFEqQb7QjmXcL0hzm08nSBajL5rodUkDQv6WaJnrlken+x3WblJrZcPLTBgrvqifiDZn13uLlwbFKcFwg6Bruli8eK0ha4rJ7toLSLSUJwgOJ5WPzM7sG1/dr570KxZfWSZPKQcrk4dOFuHfVUhJkQIb4vDBWdTFhvjNy7twPZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(4143699003)(56012099006)(10067099003)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aGNPRHssYPY+1cSw5Z+hDsb5ruv8OzcH0loSu5TNhoVa5AF50DkfGk4tdXq2?=
 =?us-ascii?Q?5csgFCmM9EqZsXf/rnahzBwgQ1m5QzbYBleeu+6x+2HvU8ZsdEbAXZVhBS/O?=
 =?us-ascii?Q?W/Cvq+mYKoVjsVmyGmVdl0kjozDrP5l3XUOxYAHpmbQ+GMcmOSksD8rgDQA3?=
 =?us-ascii?Q?ckzqfObdnxJxiyGNCseNIhQEgrpr3hqNoy9IQt+/gVek+IllK6JY/VqzA14t?=
 =?us-ascii?Q?6PBLiPMAiRoNf1AIETQjzDdXQsmmBEXuI8bqYq+2xrl8VoNmXcGASp7eBnsN?=
 =?us-ascii?Q?OlhBtjcj6BfzxoWSZmWa2qNgqYy2a5k/jZFcVgeK3IIEYEcKaoyOkSlgTjBh?=
 =?us-ascii?Q?UCGMR/qDu5GEqUOYNwpUGZ9MONGunDaBRLQkZgkR3QbKs7qyrqhzt+l5Hiv0?=
 =?us-ascii?Q?4Vb47emOxz0wP0ODguc+w5PXXkpPv+G95vYUN2/LPAa7j8oY9n7ny23PPOkM?=
 =?us-ascii?Q?Kp1Q0ynBI4iBi6b6bkFNORDPn81LNJp/94B4BC8U582UnSrKQexNYYhg5I+E?=
 =?us-ascii?Q?TLl6taQAapWvJicergtU+r+MFBFfFWThAw2jMwwHfSkJM4OTjGcLbbVK5oCW?=
 =?us-ascii?Q?o3hvNOXSviTyGi3ZtbuYLdVWgmigESayrRXn5NArwfrblBQJm/M+xuBV9kik?=
 =?us-ascii?Q?9yEAR3irCAhO+wFl/IWGAZEHt5d/N1qHjd5F2GIT+wMLwxxtm7uPeuSOE7We?=
 =?us-ascii?Q?pQLmp4i39MwI4/OYFYCCHioSIZuAkgBxSBwK837OFFRuUvaNUIriAdtDefeg?=
 =?us-ascii?Q?3jOyuZ/xClyjwlt7gmoxUagCxMBKYrhehXfmhcMO9Unkk+D5zre+4Qq/5YkU?=
 =?us-ascii?Q?kRpEsGX5Kq8kDdzpFcj58Jm+YKm3kZDcaW2ln2y1D8BJ7RjfC+RE2Y7mhJAZ?=
 =?us-ascii?Q?bsMZR9ROTVwC4pyL+AftjDvpgP/QwiHtv6pCtnrvGSNTp5VOGCwkBiI2pIub?=
 =?us-ascii?Q?IzO8ViqYcODjuLwod0PgLhbO1FqotSH6g4wsuTo2WOUFLHqFF30ahcx79gGq?=
 =?us-ascii?Q?W5C6WYQuybr/T1kDBavyTW7KzOymJOD0lthJ32m7TATH8VXBa0uGaONGNhMP?=
 =?us-ascii?Q?4XAxENT5MLO0+iMR9iB82x8NDBuXQNPpGEDO5nV9f5VdJBh+aJ0kFD5Df3ZM?=
 =?us-ascii?Q?7H+35W0gwrJ3a53XbOliatSOKwrFQ3NwzKYXgQaBibeI1GefyQx4ghlxj+5M?=
 =?us-ascii?Q?QlO6dEhbVrhqJNrUQk7VIn8/ISN8eNH7Ncep2zBiO84RJdJwEVsdVVHWCMS9?=
 =?us-ascii?Q?mGa424QesVC544Zi99hQM3PPbS1VsghDp0F/nSFywOaWL+R5KBudsPQtIXEj?=
 =?us-ascii?Q?LnQQstbnUL2etBkJbcVLAuOdMmOz5PM9pwx97TdJ1Gpsz0UXfbhSYiSCJmRv?=
 =?us-ascii?Q?4sBb43NTqblIJAflfXDEmfK51/YvPqBajDZaHelyfR5ntGlxmo3KLG0sly/B?=
 =?us-ascii?Q?DNX9XEtFEtAJgHpn0OcM0w3k3VDT0qzhoy3gdDfxWmxSXGiRtGln+t/0E530?=
 =?us-ascii?Q?XT1id+vxjvgVRQt6n0qpPoVdfV0W+ezSgThBtuNSMwFbZMtzSggVZYRvarLM?=
 =?us-ascii?Q?Ah3G9Zv0OzR25Zlv6WypBu4e3aIEfeejLJbZSlzepxdagwf2/CWmRJl56BVQ?=
 =?us-ascii?Q?/BruiQZoprHRKrS+hVYd2wn01rLLb6AIxohmYjdn32As5IKTWMBo4whBSO7I?=
 =?us-ascii?Q?X7RR/srqnya8O7nYexy3KMV4EakJCCFYuanVDnPkn4dNvLbJSFZysKAtvpA2?=
 =?us-ascii?Q?kkm8fvn0oOK9eNRz5rXZddP/agLEqCk=3D?=
X-Exchange-RoutingPolicyChecked: gMq3vKRoho+FigXKf+yXJgrgNGIBChSkDoIw+d5AlAg7wH34ErC+qHJQFM69PkITQxFaCkrEqPgO7ypjkDkIO8BXhaO/hasHsE4PLGJSZfxyp+yM5DxhP1EqKBWyLogFXgrGEaj93eeWXyei1i20uRqcM7dp0gnLOHjzZ2d9W3y1YvbpNuuo4c15bKvcOey1HMzE3rpfvv9FMwQ07IU9rAggZxKhMwyxrzybjLwTbfuP6qgyR1XEYgzsd2WMnmELFdPFDuO5yHotUgc+RUHdOxSlvumv8e9Wx8AaRQgYUfe5NrEzO2DVsGpB2/1AaX7SbIPILoQCTPoyL5+HO6KjZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a8c994-de1e-457f-a615-08dee75282bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:04:30.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g765DsOl2bI0bRL63KVhdO1N0B5calFWH+/uFu8NHVLNIKWVFs4GMTiBZ65nE9j/ekkbXzeQifjGL8IOsG95IUsDttIR4jpZ2WjddDT4juo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6774
X-OriginatorOrg: intel.com

On Sun, Jul 19, 2026 at 03:56:05PM +0200, Maciej Fijalkowski wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Fix generic xmit path multi-buffer logic when packets are either too big
> (count of descriptors exceed MAX_SKB_FRAGS) or an invalid descriptor is
> included in fragmented packet. Introduce xdp_sock::drain_cont and act
> upon this flag - when it is set, keep on consuming descriptors from
> AF_XDP Tx ring and put them directly onto Cq. Previously these
> descriptors were silently lost and could never be reached again.
> 
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> Reviewed-by: Jason Xing <kernelxing@tencent.com>
> Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # wrapped cq addr submission onto routine
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/xdp_sock.h |  1 +
>  net/xdp/xsk.c          | 45 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index ebac60a3d8a1..8b51876efbed 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -80,6 +80,7 @@ struct xdp_sock {
>  	 * call of __xsk_generic_xmit().
>  	 */
>  	struct sk_buff *skb;
> +	bool drain_cont;
>  
>  	struct list_head map_list;
>  	/* Protects map_list */
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index a7a83dc4546a..12a845d012f6 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -737,6 +737,19 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
>  }
>  
> +static void xsk_cq_submit_addr_single_locked(struct xsk_buff_pool *pool,
> +					     struct xdp_desc *desc)
> +{
> +	unsigned long flags;
> +	u32 idx;
> +
> +	spin_lock_irqsave(&pool->cq_prod_lock, flags);
> +	idx = xskq_get_prod(pool->cq);
> +	xskq_prod_write_addr(pool->cq, idx, desc->addr);
> +	xskq_prod_submit_n(pool->cq, 1);
> +	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
> +}
> +
>  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>  {
>  	spin_lock(&pool->cq->cq_cached_prod_lock);
> @@ -1028,13 +1041,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  static int __xsk_generic_xmit(struct sock *sk)
>  {
>  	struct xdp_sock *xs = xdp_sk(sk);
> -	bool sent_frame = false;
>  	struct xdp_desc desc;
>  	struct sk_buff *skb;
> +	u32 cached_cons;
>  	u32 max_batch;
>  	int err = 0;
>  
>  	mutex_lock(&xs->mutex);
> +	cached_cons = xs->tx->cached_cons;
>  
>  	/* Since we dropped the RCU read lock, the socket state might have changed. */
>  	if (unlikely(!xsk_is_bound(xs))) {
> @@ -1063,11 +1077,21 @@ static int __xsk_generic_xmit(struct sock *sk)
>  			goto out;
>  		}
>  
> +		if (unlikely(xs->drain_cont)) {
> +			xsk_cq_submit_addr_single_locked(xs->pool, &desc);
> +			xs->tx->invalid_descs++;
> +			xskq_cons_release(xs->tx);
> +			xs->drain_cont = xp_mb_desc(&desc);
> +			continue;
> +		}
> +
>  		skb = xsk_build_skb(xs, &desc);
>  		if (IS_ERR(skb)) {
>  			err = PTR_ERR(skb);
>  			if (err != -EOVERFLOW)
>  				goto out;
> +			if (xp_mb_desc(&desc))
> +				xs->drain_cont = true;
>  			err = 0;
>  			continue;
>  		}
> @@ -1096,18 +1120,33 @@ static int __xsk_generic_xmit(struct sock *sk)
>  			goto out;
>  		}
>  
> -		sent_frame = true;
>  		xs->skb = NULL;
>  	}
>  
>  	if (xskq_has_descs(xs->tx)) {
> +		bool drain = xs->skb || xs->drain_cont || xp_mb_desc(&desc);
> +
> +		err = xsk_cq_reserve_locked(xs->pool);
> +		if (err) {
> +			xs->tx->invalid_descs--;
> +			if (xs->skb)
> +				xsk_drop_skb(xs->skb);
> +			xs->drain_cont = drain;
> +			err = -EAGAIN;
> +			goto out;
> +		}
> +
>  		if (xs->skb)
>  			xsk_drop_skb(xs->skb);
> +
> +		xsk_cq_submit_addr_single_locked(xs->pool, &desc);
> +
>  		xskq_cons_release(xs->tx);
> +		xs->drain_cont = xp_mb_desc(&desc);
>  	}
>  
>  out:
> -	if (sent_frame)
> +	if (xs->tx->cached_cons != cached_cons)

Sashiko says:

[Severity: High]
This isn't a bug introduced by this patch, but does this change to the
release condition expose a pre-existing issue where rolling back a partial
multi-buffer packet corrupts the Tx ring?

During multi-buffer packet assembly, if the max_batch limit is reached,
__xsk_generic_xmit() exits and commits the partially consumed descriptors
to ring->consumer. User-space observes this and may overwrite those slots.

On the next call to __xsk_generic_xmit(), packet assembly resumes. If
__dev_direct_xmit() subsequently returns NETDEV_TX_BUSY, the code calls
xskq_cons_cancel_n() to rewind the local cached_cons by the full packet
length:

	if (err == NETDEV_TX_BUSY) {
		/* Tell MAC device to consume more and retry later. */
		xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb));
		...

Because cached_cons is rewound by the full length (including fragments
consumed in the previous call), it becomes smaller than the cached_cons
saved at the start of this current call.

Will this new condition (xs->tx->cached_cons != cached_cons) then evaluate
to true and commit the rewound index to the globally visible ring->consumer?

If ring->consumer jumps backwards, wouldn't the kernel fetch descriptors
that user-space may have already overwritten with new data upon retry?

Maciej says:

So generic xmit is still not bullet-proof, sigh. It's a problem that was
present even when `sent_frame` based consumer pointer update was used, so
sashiko correctly classified it as pre-existing issue.

I think this can be addressed after current set lands, as no new bugs are
introduced and seems it got acks from Stan and Jason.

>  		__xsk_tx_release(xs);
>  
>  	mutex_unlock(&xs->mutex);
> -- 
> 2.43.0
> 
