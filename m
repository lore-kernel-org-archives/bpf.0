Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922714519B6;
	Wed, 26 Aug 2026 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766244; cv=fail; b=Mba0w2y79md7JF3s0ChdsUvpg+q+t+bjDgdaj9HLqRwKBGDNJyn1qt70Grix7VoNmuBpJ+WpVS4/x6Vey1wWXcuVlRCuox7gXE1DFi0KtI0HaU7tFHAfSrAnT/RTsIvr7KcWeGmqWjNG3NhmeW2bhuwFCRPozwGMiiFUBOHXpag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766244; c=relaxed/simple;
	bh=MVpYgGa0S0PrEXMZQ8NBqd6IaXz0mlp1HFAMhQAPUe8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DKZtcui7I359DmSUfGi2y/h12Kp06Gkill24YwyDqTMneic6fzcWj1L7M5NsP9yPM3ghIfKzC50bZ0t3n1R4rATIY6mIEadDdCPeL66dQEetjMRXfwntlk4zSsyf+yN4fU04TYUvsA0Vx8GA+h4yduQ+IK9bpkSCLWLQOQvx1t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0STLVAb; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0STLVAb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787766232; x=1819302232;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MVpYgGa0S0PrEXMZQ8NBqd6IaXz0mlp1HFAMhQAPUe8=;
  b=O0STLVAbsdhbZ+PIJA4OyV1OH8Fpx2m7hkwdUStShvR33wd90UmGnyet
   orSjjFxvXTA1mSfnM/x1/2y69ifWItKfeG7XqcmfSdbcBLvusOGPJGw5j
   EB9rMe+0NcX0NXBygJh2jVM+PzlSf5ERUmDGXxB6T9gO+je4JjoSWJo6B
   y/At97S+U3mn4WOvSVeJJq0AI9qYgMG5PwbGx+rilo+TZdRRJ2m09W08G
   IklAexAnQwDDp/kkxT6ZoMdn/kg4vTK/8yCXKuPqk2nJsIBF6VyhPD6C1
   vqylk1v1pVZ6QNp0o+ObJcXGfS6WdE+kGTEY9povNOlNCC/+qbg1IzPLf
   Q==;
X-CSE-ConnectionGUID: IJ7T5ZMrTuKi9wdU+ZqURQ==
X-CSE-MsgGUID: WfaODFOYTkajD605Wl7AYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="87198483"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="87198483"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 10:43:43 -0700
X-CSE-ConnectionGUID: WuVpFMvhQoeqgdi4q5c/HA==
X-CSE-MsgGUID: bRrgdLfzQ3iAiW2hzPqJgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="267654671"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 10:43:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 10:43:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 10:43:42 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 10:43:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlDw4YM91jV5qithep3JUe802c+rSScVrvlGrh3dp22bRkyiW/BJqKM/W8OSPmuWRNodFzUmqDVY7tmuxNqSVbZ/oWpNK9XKACnZwTWa8mJH3PaqvZYIbFJwwtIglYz+GVfi4YiCFSaQZS8nGn3MRdFhwC4yKT7RR31qVs+1ZMPLoqyBvd/XyIUg2FBmKvR3e/CevjKeEXfxU2EPFijK+HJtBIkGM42ElsiCpCKtWPuByQzvU4TEsjoa7r7ioTDtt51qGU1V1mXp44nkladK5oi7pN8+IBp0oeXkvZM/b8ZYkA/OkzcLC72UYF+cyq7yeKWRMnTfqlWqUw9LFoXmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROPaKSCXAiPMjjQp/UDnQA68UPtsmODhjZTXfwc8eF4=;
 b=Y0W4Lr1UvDKqEbGI4cwO+9Mt5IgAkRnIrSrOipDb87EBsUdz4kLkLPTEegZLRBMwz7e3B0DH5nkx7U/xioOm9KMe917uCTMiZN97G8yh6VhZRVYQdU3C2OGVvYIniZuFr2csOpxS4YGe2HHpynAAVcU4E4z04UC74BmOyvf3bDg+eCn9qFlO0rNr6kvalnSg404MjjnN+3rbEfytVulFQdrVjeg01/PRLPfBKSeZ7FoRLQDXgkfX/t6bJXB7yBwDZiII7pPgpE+Ey6ukVIQLr9crOfbAKPXjR/NAXBoFkpDxp+ooNsg851PJRMWMHBE0IG3TY5gjERyHvf8ayhTYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.7; Wed, 26 Aug 2026 17:43:38 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 17:43:37 +0000
Date: Wed, 26 Aug 2026 19:43:30 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Khawar Ahemad <ahemadkhawar123@gmail.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <horms@kernel.org>,
	<syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com>
Subject: Re: [PATCH bpf-next v3] xsk: Fix circular locking dependency between
 &net->xdp.lock, &xs->mutex, and netdev_lock_ops
Message-ID: <ao8lwrbcS1sYzVN0@boxer>
References: <20260826173019.2917-1-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260826173019.2917-1-ahemadkhawar123@gmail.com>
X-ClientProxiedBy: VI1PR07CA0140.eurprd07.prod.outlook.com
 (2603:10a6:802:16::27) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BN9PR11MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f81065b-6367-42b9-92dc-08df03998f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5kEGpY/YhvWGcSe+DEqaWLbZe1WSs0nUk7JUOABs6x0w5dWHmusZILDjtmFN0+PykK9Tv6k+ojhee/9oXemjjUI7KS9ih4cuccLI12rTq2p4IwkRHmMDvM8fFcFZkDPLAtFE+d8qFGl3ycufSUtcQqZViQupfJGk3VC2R3fTZuV7D5Ty4g8acitkdpMCTp3nsEij4R04DuktDZV3bEtqjFJRcwTPXU4LH1n/uacx4wzRt6Ktf9FXndXEKf8JPg2w5WOOCoSMum+liWhee2+UD7T4eTh4I6E3JPLFIFoJ9mN1TeaAWt3YUtQ6Z1WN/jUY8xMNZ2YS+g2Mz6GCwXFQit37mdtcL6wiV5ikr+7B1+v6FARBo/fAFxhpOSo+y3wjcV8cnyemUKbI8IwDbtYpGhI+hcZCv9xa8jjV4c1CiXel/jlDiN/4VYzpqi/szKbXpfIBtroy+Lz5y8nBtUGOJtuCXkyFUM595SZW7O9Mejs40VsqouscaVMvgsWXZz1dSDJbvlL5y8dj1Gzd2HtCP++yb88EBnqqxd6xqtyHUjldk+4w13bsSyHCsaPVEQJSZCQNLkqJzf3ednaU9reMIXacyznm8DY9rJ5r9QcCAxJdVVUjMNnx+wzQC683zREO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wYQJchTr4/Td4EV+/mML6RLeOX0pgXq5Kgjl84kE3y36Da7SpJTItn20Xk29?=
 =?us-ascii?Q?H3pEVBKYDzU3xXT8wbOZAk+4oTl+VOLxyhODXssQ0QPVS4OLsmwYXA35A5uc?=
 =?us-ascii?Q?vzdLZUHxAm3MqVLlzggx2b98lmbU+EhQVy976xYYHfmKjIft/lmcZScBo+JE?=
 =?us-ascii?Q?3y95VVJtyQqyNQgibicBcIdh+ueUE6ys0PWoq1HeyuJe3apugCJoFezIl7Vz?=
 =?us-ascii?Q?No2kdsIbozY5+2vi15SJVVuzDDFu2Lw0hMJTfwqfL6Sc93fcHrgwIEnBPVhw?=
 =?us-ascii?Q?WiPRlSc8jG51dfBIADsFNUCKuPwRmi+HlO8WIrCqw6X1IP3ojgQJWd+3+wwu?=
 =?us-ascii?Q?96m8c6+yGTVkA1VIItijPmP4ntRYPKYAmDa2byGwJ8aiS3Fn9kyYlqf/eZ0s?=
 =?us-ascii?Q?6zUJGKTGRXmwoA7FMp9h66xlSCeDFSY31V9y5iuS7NuluUviBFwDdyvdwWmu?=
 =?us-ascii?Q?TrI7wiaxR+26WNjlEuWnwjd4CptYOGQ9RfqqOgRKmzxcFpBjfLW1fmTxApZL?=
 =?us-ascii?Q?cIKxlPsb8QD5VTNTre5p30WZnHXhjkYccIHmVY7nx6yZQh96eP6QK7d03MWE?=
 =?us-ascii?Q?Wj5+3CORl3UFJ3KQ9x7GXnM8GPwFGCFsZWT685l8ewDCsLpyhU27BPFmW0zj?=
 =?us-ascii?Q?k5sZwPbm7y6uVvWuLy+Mk3PdnFzCrF5gf6cxp6ODn3Z9Jkvb3M2wWEe2rQLa?=
 =?us-ascii?Q?x7HovUQaRfo1mizxkUXexzOFYI+j6b7n5tK9II1kIffvO3RRHCYX75F643Pc?=
 =?us-ascii?Q?SuotqgwwmxvEGPLZdoAIPsf+UmHhBs+zfny36w+ItNoxSGu0AVmPZ+PazvKe?=
 =?us-ascii?Q?FC3Mfxtg8XTrtX2FRYpgWVqpKD3zOUmmbhORPYieZr1FVvedk5JHMFJhRMiL?=
 =?us-ascii?Q?mRAWZen1khlc6nJEOfur5FMPU6YPKT3eKYBlp5B4NyiBE1jNU5aTQyg8QB1x?=
 =?us-ascii?Q?BRc9VkQ2yKGBdMztyZfsBwr2DFo4tZO52jSzBwf0vesS55Aet2hcc5wam3Z5?=
 =?us-ascii?Q?efRWvopkSp7ovQslLrpr8mvz3AGDG8oQpNn/sonE3JjpeeEb7vZTEh0h9fCa?=
 =?us-ascii?Q?I32f0Yzq86YOmWBu1BkgDYzQZCb35q1NSDo/oOTieX7Fw/8Ku+2BLkPwVwWw?=
 =?us-ascii?Q?oLDSB2EUgpj4GL2lQVWmN/dsxp+nBX15c2Ob8OMKKjMqi/9kHOYs/x/VjUab?=
 =?us-ascii?Q?+rwNj+2ZxxtBJr328+uFsXxk/kRms31vr7WoGK9tEjCnI3VEEVWqF2dL8b/1?=
 =?us-ascii?Q?ADFpBt5HmvClmuM28ANXEjJCkvsYYuZl9Ic7MeLh4rBChdH1wdHHX/9fnbNQ?=
 =?us-ascii?Q?GUCODTkvUnwfMKHuINQQchuM8C0wUaPTencURXBmJJnKzL/hN/qK0kaxFIu2?=
 =?us-ascii?Q?cj7laBncTQK0nvZMGEzI43q6eZkpCX3HgwV9qoRAQk5sE7vdddRaeeLH8S1L?=
 =?us-ascii?Q?9BYBTDV44X6XjkjP/KsMJhTy94j7lUnAJkzBIeRCj16zC2gVu8SBPhB5HrTm?=
 =?us-ascii?Q?IB+Or+CDMWERnb1CKwWCkeRZWrs8MQdZFBkHTHcEvvqMqZazVLuMNtfshesu?=
 =?us-ascii?Q?5i75a6BrW33ANeAXACkUccTNOUj8PCLmcJFuvwPdMUTwnSnauYyjDiCOGbMW?=
 =?us-ascii?Q?sUdDrCW7tz+Iq59783t0nhc6CkmPxxGGcD8S4u3XZFDMOUvdmmq4wx/kRc9y?=
 =?us-ascii?Q?j4RuXQa6r5GMN+CK5diKFVvV4E7zCsH04Tv42fhfltsO9YtU3WBcPF5N8oAE?=
 =?us-ascii?Q?kKF5TjrcPExCeL8XO332FIc+G98ve+8=3D?=
X-Exchange-RoutingPolicyChecked: Im8f/8TYZTEj+wHFqceBpfo0Nq5RP/hgLHipv4rbBPOPCv70FkD/GARJ8p97hstTaKjdlxR6D1RNiOFTOOSqJwfM1dNcI5QZzqe14RsMo/Ck69H+RWaE9IZIdctpxTl1cc7rRV5ZkjlXOHaSKI+64itmedu5PcPoMLW70VMAc7LHyeu9QuhPH9Vy4BZMWWk+LacVXlHIlZmypBAnrRL1Tdxcoz63ZbhZBHM55JdlnlvV2juo2SdwhMeENxu4zcJVHj60Mk/ajGtb7khziI5wWqRr0e0KyQkKVznrSlWsT8Ixtel/TkN4Un/Ng8EKjhvzIanT3uQhXJy8mCoNi3e69w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f81065b-6367-42b9-92dc-08df03998f33
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 17:43:37.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3XNO88o+s4/OVRKPIHjuG0dOD18CPnJWFBl3U7zaMHrnT+VLZiTkjQRULaKaeL0KAWXM39XwElk7kBjuFCor+hnl68b9YrTKIQoRUvhAXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
X-OriginatorOrg: intel.com

On Wed, Aug 26, 2026 at 11:00:19PM +0530, Khawar Ahemad wrote:
> syzbot reported a circular locking dependency involving &net->xdp.lock,
> &xs->mutex, and netdev_lock_ops():
> 
> -> #2 (&net->xdp.lock):
>        xsk_diag_dump
>        netlink_dump
> 
> -> #1 (&xs->mutex):
>        xsk_bind
> 
> -> #0 (netdev_lock_ops):
>        xsk_notifier
> 
> The lockdep dependency cycle arose from the following relationships:
> - xsk_diag_dump() established &net->xdp.lock -> &xs->mutex by calling
>   xsk_diag_fill() under &net->xdp.lock.
> - xsk_bind() established &xs->mutex -> netdev_lock_ops().
> - Device unregistration and xsk_notifier() established
>   netdev_lock_ops() -> &net->xdp.lock while also invoking xp_clear_dev()
>   under &net->xdp.lock and &xs->mutex.
> 
> Eliminate the cycle by decoupling the locks across both paths:
> 
> 1. In xsk_notifier(), split the unregistration into two phases:
>    - First, unbind all matching sockets under &net->xdp.lock and
>      &xs->mutex.
>    - Then, release &net->xdp.lock and perform device queue teardown by
>      sweeping the device queues via xsk_get_pool_from_qid() and calling
>      xp_clear_dev(pool) outside all AF_XDP locks.
> 2. In xsk_diag_dump(), avoid holding &net->xdp.lock while calling
>    xsk_diag_fill(). Instead, locate the target socket under &net->xdp.lock,
>    take a temporary socket reference via sock_hold(), release
>    &net->xdp.lock, and call xsk_diag_fill() (which acquires &xs->mutex)
>    with sock_put().
>    Distinguish -ENOENT (when an unbound socket is skipped) from -EMSGSIZE
>    (when the skb is full and the cursor must be retained for dump
>    continuation).
> 
> Fixes: 975b11ae9077 ("xsk: add socket allocate, create and bind")
> Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682
> Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
> ---
> v2 -> v3:
> - Fix direct AB-BA lock inversion in xsk_notifier() by performing device
>   queue sweeps via xsk_get_pool_from_qid() outside &net->xdp.lock.
> - Eliminate &net->xdp.lock -> &xs->mutex in xsk_diag_dump() by taking a
>   temporary socket reference under &net->xdp.lock and releasing the lock
>   prior to xsk_diag_fill().
> - Distinguish -ENOENT (skipped unbound socket) from -EMSGSIZE (buffer
>   exhaustion) to preserve dump continuation without infinite loops.
> - Link to v2: https://lore.kernel.org/bpf/20260826162110.99879-1-ahemadkhawar123@gmail.com/
> 
> v1 -> v2:
> - Avoid reordering locks in xsk_bind() to preserve errno precedence.
> - Link to v1: https://lore.kernel.org/bpf/20260825152152.86092-1-ahemadkhawar123@gmail.com/
> 
>  net/xdp/xsk.c      | 17 +++++++-----
>  net/xdp/xsk_diag.c | 65 +++++++++++++++++++++++++++++++---------------
>  2 files changed, 55 insertions(+), 27 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index c2f47182dc..e72344fccb 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -2099,14 +2099,15 @@ static int xsk_notifier(struct notifier_block *this,
>  {
>  	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>  	struct net *net = dev_net(dev);
> +	unsigned int max_queues;
>  	struct sock *sk;
> +	u16 qid;
>  
>  	switch (msg) {
>  	case NETDEV_UNREGISTER:
>  		mutex_lock(&net->xdp.lock);
>  		sk_for_each(sk, &net->xdp.list) {
>  			struct xdp_sock *xs = xdp_sk(sk);
> -			struct xsk_buff_pool *pool = NULL;

I'm sorry but I have to ask you to stop this spam. This is clearly a v3
based on your v2 which is not a correct way to post a fix.

Besides there is a mandatory 24 hour period between posting next
revisions.

>  
>  			mutex_lock(&xs->mutex);
>  			if (xs->dev == dev) {
> @@ -2114,18 +2115,22 @@ static int xsk_notifier(struct notifier_block *this,
>  				if (!sock_flag(sk, SOCK_DEAD))
>  					sk_error_report(sk);
>  
> -				pool = xs->pool;
>  				xsk_unbind_dev(xs);
>  			}
>  			mutex_unlock(&xs->mutex);
> +		}
> +		mutex_unlock(&net->xdp.lock);
> +
> +		/* Clear device references outside AF_XDP locks to avoid
> +		 * lock inversion with netdev_lock_ops().
> +		 */
> +		max_queues = max(dev->real_num_rx_queues, dev->real_num_tx_queues);
> +		for (qid = 0; qid < max_queues; qid++) {
> +			struct xsk_buff_pool *pool = xsk_get_pool_from_qid(dev, qid);
>  
> -			/* Clear device references outside xs->mutex to avoid
> -			 * lock inversion with netdev_lock_ops().
> -			 */
>  			if (pool)
>  				xp_clear_dev(pool);
>  		}
> -		mutex_unlock(&net->xdp.lock);
>  		break;
>  	}
>  	return NOTIFY_DONE;
> diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> index 0170363eb5..bad0b13064 100644
> --- a/net/xdp/xsk_diag.c
> +++ b/net/xdp/xsk_diag.c
> @@ -97,6 +97,7 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
>  	struct xdp_sock *xs = xdp_sk(sk);
>  	struct xdp_diag_msg *msg;
>  	struct nlmsghdr *nlh;
> +	int err = -EMSGSIZE;
>  
>  	nlh = nlmsg_put(nlskb, portid, seq, SOCK_DIAG_BY_FAMILY, sizeof(*msg),
>  			flags);
> @@ -111,8 +112,10 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
>  	sock_diag_save_cookie(sk, msg->xdiag_cookie);
>  
>  	mutex_lock(&xs->mutex);
> -	if (READ_ONCE(xs->state) == XSK_UNBOUND)
> +	if (READ_ONCE(xs->state) == XSK_UNBOUND) {
> +		err = -ENOENT;
>  		goto out_nlmsg_trim;
> +	}
>  
>  	if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
>  		goto out_nlmsg_trim;
> @@ -145,7 +148,7 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
>  out_nlmsg_trim:
>  	mutex_unlock(&xs->mutex);
>  	nlmsg_cancel(nlskb, nlh);
> -	return -EMSGSIZE;
> +	return err;
>  }
>  
>  static int xsk_diag_dump(struct sk_buff *nlskb, struct netlink_callback *cb)
> @@ -153,28 +156,48 @@ static int xsk_diag_dump(struct sk_buff *nlskb, struct netlink_callback *cb)
>  	struct xdp_diag_req *req = nlmsg_data(cb->nlh);
>  	struct net *net = sock_net(nlskb->sk);
>  	int num = 0, s_num = cb->args[0];
> -	struct sock *sk;
> -
> -	mutex_lock(&net->xdp.lock);
> -
> -	sk_for_each(sk, &net->xdp.list) {
> -		if (!net_eq(sock_net(sk), net))
> -			continue;
> -		if (num++ < s_num)
> -			continue;
> -
> -		if (xsk_diag_fill(sk, nlskb, req,
> -				  sk_user_ns(NETLINK_CB(cb->skb).sk),
> -				  NETLINK_CB(cb->skb).portid,
> -				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
> -				  sock_i_ino(sk)) < 0) {
> -			num--;
> -			break;
> +	struct sock *sk, *target_sk;
> +	int err;
> +
> +	for (;;) {
> +		target_sk = NULL;
> +		num = 0;
> +
> +		mutex_lock(&net->xdp.lock);
> +		sk_for_each(sk, &net->xdp.list) {
> +			if (!net_eq(sock_net(sk), net))
> +				continue;
> +			if (num++ == s_num) {
> +				sock_hold(sk);
> +				target_sk = sk;
> +				break;
> +			}
>  		}
> +		mutex_unlock(&net->xdp.lock);
> +
> +		if (!target_sk)
> +			break;
> +
> +		err = xsk_diag_fill(target_sk, nlskb, req,
> +				    sk_user_ns(NETLINK_CB(cb->skb).sk),
> +				    NETLINK_CB(cb->skb).portid,
> +				    cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +				    sock_i_ino(target_sk));
> +		sock_put(target_sk);
> +
> +		/*
> +		 * xsk_diag_fill() returns:
> +		 *   0:         entry added successfully.
> +		 *   -ENOENT:   socket is unbound, skip it.
> +		 *   -EMSGSIZE: skb is full, retry this socket on the next dump callback.
> +		 */
> +		if (err == -EMSGSIZE)
> +			break;
> +
> +		s_num++;
>  	}
>  
> -	mutex_unlock(&net->xdp.lock);
> -	cb->args[0] = num;
> +	cb->args[0] = s_num;
>  	return nlskb->len;
>  }
>  
> -- 
> 2.54.0 (Apple Git-157)
> 
