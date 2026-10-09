Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016643E9CB;
	Fri,  9 Oct 2026 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549845; cv=fail; b=k+csXcUwAqzBZPAZeBA8JkSMY0rQ+bXOaFx/4VdMbkJN93UuIRkHj05/K7mlcXJgZGwcUw3llOoGN64dGZFM8I1cGFDgBzFOviPjBy7OaRsRdgreadYjQ2x0o8aIjc1h8H4Ceg0NmsjI2XFkogPfadLC4AqHE16VGTusAq14vDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549845; c=relaxed/simple;
	bh=GYq6df3ch2Eg/uqb055wv3gLLGxZYUnkKjrsneDj4rA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hcIk+LofLKSmit3YZlHDyFEZiRDj9vmphBSweapjg+ExvdoZNiEYWmwPlFZSbSgHJ3EnIyKt4OhgaWztOmJpillGYCNw7C4BtMXXWcADkkCU2ZHCsDawnYHgPRb8AHd+utSa6IJV+b5c1JfpM2A1StSLPi6j+SN3QCXo/s/aW8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWLHY6SR; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWLHY6SR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791549839; x=1823085839;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GYq6df3ch2Eg/uqb055wv3gLLGxZYUnkKjrsneDj4rA=;
  b=OWLHY6SRtoCWfv2mOjmTvaOFags4A31nwl1+CXPjiPeDE36/RQnrfDua
   WsH7bWooKbRzsPJHQe28oX195J5YTs3SaQbkv2QG8RyYGgYWpOfDFB7od
   iLt/fu9tqkqivofYAazR4REIQOtMsXw2BUe5GD+10eTD9DlQ7nDqJ9bQn
   MIZouJlnLvusRl/eBuGmoHUpB0qn2XLZeSp9GiZLZr5ORm1NGpunraKOi
   6LvIOOMpVrO+At/+uPck4WRwT2jQhqWl7S3A/Zbll7n65TOSkxcqWmX8d
   SZei44QmrmbXutoiqIwQp7Ts/lMclTGMp5H3Lh0OFqGiUOA93YCMtYBIU
   w==;
X-CSE-ConnectionGUID: XLovoB83QBKEpuaCuLJ+Fw==
X-CSE-MsgGUID: 7FPmbnejS4W6LtlOK7IqtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="234181"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="234181"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:43:59 -0700
X-CSE-ConnectionGUID: e2A/phnfTw6jDlSTRzxxbw==
X-CSE-MsgGUID: sulQss/WSp+GslcwAcEudA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="660879"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:43:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 05:43:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 05:43:58 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 05:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6sk+AI1faFLfA9PMu6qNDu9gP4b7lWP8caRAYp++81dJoOKT5QJ7dFzKzMUmFZxswNYcfSi3iQ4Okpp2mDOc4hLiTpUIjmeDdCzUTrx4XycYjXFvUq4LdrYMcnO8wIsfjBmNkNTQ+qRxwMvrGlCeKD1+EC6s8xSWQrKzJGDmWMSsTb8m2Uo4GahZt/vIW0j5VXebW3R7Sy79u5VKvCJjnNvcv4jX3rNBU3ZtyXDSfzx4SzTqrJCKxWBRRKT+uNo6Z3bb+eP1sHluE72riOILZnlaG3vu9BWboJn4Rxkl7j5rlZtKbWUtGkujeHO3QLQCJ7kboeg7EXEYN30jiBKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujRgMyOUEwgZblk9deO/H1UM3mk8oYiCOu1PFLWNtHQ=;
 b=ilRfVDJUivpEzY6kFE1I7TUcJtqDMkJ39eHxpYKFMg/K1VX3TeccKXhampwrXH/9QHGPQNmVarLut9wLxC1O9uNs8tTIYeFKg2L5PcQLY3VmyNFA6nXuX/zvibSixXN44u/eH41eYIPyi9rMsa5H945ygn8gc1LgJlW/uT6okGp+VJgXPF4FbSt3p7C0tx8u3aYKlac9Hub9aINjFzFJTsulsacYBVAVRpHNzwodkNBlpansh3hA3IXAncBZ+lxgMDPkQsG9LuLP+7j4bfUsazPKhTJgUMi54CxjHggM/guypbPIidKsbAARNRvyPedUmUa6WOLr2G5cCsL2q6Aztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.17; Fri, 9 Oct 2026 12:43:50 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 12:43:50 +0000
Date: Fri, 9 Oct 2026 14:43:44 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>
Subject: Re: [PATCH v2 net-next 02/14] selftests: xsk: drop the
 single-interface loopback mode
Message-ID: <asjhgIQLaM/IUXkg@boxer>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
 <20261008114909.734364-3-maciej.fijalkowski@intel.com>
 <87wlrrqk9n.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wlrrqk9n.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: WA2P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa6c70a-0d45-4d1d-bcc1-08df2602f819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|5023799004|4143699003|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: w+13fjczVA2djaAAj+hXRCuCKTfhZm97jYRTCjR8vjd1c8oyTfRSn+edahMm89jH8TqGR77qEebNgaf5bOe9QTb4NCKa0BlvIAZhBazj3EXNn0Q8z8LIYLS7xLrBVA8yexGvAE058BYNhtB8m0nud/iGb32obDrUcl6nrO45IR8Mr7kEa1+RSMGjLbwh4C25IDsjcYnaieg57Zdmf67nr58Yfm9LPuu8peUu6NPMNEABHO4mvSF6DMJzZtQFSoxFapUaWyeJ7QT+OwJ6pcrZJ0e+irI6bpt7uUJ/IykOgxW+y8Y7fpzTbrwTk5GrIXAK9KMEKCmm2yIcdo4VmTAnRx/TbnvFAHTKM92Z65oLMfn6dLB3RKcyxRL0Cm85vj3xpWCFy6kqivK5FfppO8DzB+Rh1ip522zoV0bbe6scGdMwHDZwY1MyiQuxqKzReHuMwkhp8TMDsU5Wxzjt6S36k4vEKoYDiqwLOJMH2gyMl91eOCak6bGKOs65OH7y7Y9Yv6AzVvskXzo8/s4MtF6ns+T7McwQXJVYGp1nmPUwfmnf3vvqzU5kFDX7zU2D4Qirvq73nVsniGwz0VqPPRlQuBJqC2mC+ms+cAXCxu5iKAhBZj7ZXp2GKef4uy8iNgvRhwVWZh6kyjv8Mkx3S/N2C9nnVkzGB2iCdJUInXESojc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tsuHGi/sN6tx+ZnbtVyDbbbo9M/DP18e6qkzwI6DxVNtOrsptSeVmxIPSF?=
 =?iso-8859-1?Q?DmIoV7Noo2MyDhspbQ4QUmp33M7ZtWNFtZZsQK+9fiDHsDYi5YwZuhKSh5?=
 =?iso-8859-1?Q?2W34r0poMSFm0OmZuph/J57tvD4VAFy4VGwXjppeOzkG2nvlVAo2o5ZqLA?=
 =?iso-8859-1?Q?AVXGCkcv2ggQ6QUM8dM6e+fKRZl1GfGpqwZTGLnNYld2jOUnQjnGEk4VWO?=
 =?iso-8859-1?Q?PN0pCfp1CgFNBEyvnhFrnJiBdaQFEqlox+iZWVZGdga55+oMOjqJSovoZy?=
 =?iso-8859-1?Q?EUB38780yzROq9Vt0QxLQYv9P2EBZRMVKXnAgd3CV1+CM7qBNIEvwQl5XJ?=
 =?iso-8859-1?Q?nMFqY6F6VTrs2zCDzWRyN6tGfeinyaZgEIcqfgwkY3TwMaoib/zg+l5JW0?=
 =?iso-8859-1?Q?wasOmmR0729r4ZpXNZT5xGb4zrQEi4U79vqmI9ph6DqvAmkJ5gjVlJOn+4?=
 =?iso-8859-1?Q?naAhpkN96Kq07FyFSGGIdG1yketcFO8v1tenAH5DPO3SccIlo18lHWHEtG?=
 =?iso-8859-1?Q?RWwOTb1pDqh0BV0heKa82cIw3zp3yTs7CuBp8osxILTWJ1jCIn3bElf1HC?=
 =?iso-8859-1?Q?+/7t5PkPRpuFnqv18LqJ4CxEnwtFFG/1GA/85SqOEK4UN8RzDMx+LqoOn3?=
 =?iso-8859-1?Q?QaYT0dZbpIOVQViRfbYN3wdABkEyZsEK+3sV+Mq9Q/WadpNoz3JkeJLv84?=
 =?iso-8859-1?Q?pqlxNOTh5NZyfy2mKbtl8wiQsi4VnkMde/ehhocf5orZVNFXJqWT5zwi1h?=
 =?iso-8859-1?Q?hE2p9reJ/XzoT6WXlmu2wyfLmsOurhJVbfswdbkKXez1vunDXUn03frg3z?=
 =?iso-8859-1?Q?StVwvq+oX3JE29BvSwBjJuYvg4sfD/kTDoTmOb+yyMA6orTVm2CmL68gYH?=
 =?iso-8859-1?Q?eDZzcwWwc1SfkGd/bqrBXt6pAXsN9RZQTB/HMChXhgCjC0aA+mfVhofpFX?=
 =?iso-8859-1?Q?2z7DHTKwz9bbxLXpg4NWRT/aaXLZR5HLbEUt1pVt8/OJOL3NDQ5EYsfoKM?=
 =?iso-8859-1?Q?q/e6g5JoL7tZBEIJxyoIUsFU3kTl/Gx5YxjRrKlyhrbacxCkBj/qiVR92s?=
 =?iso-8859-1?Q?NrRDbodi715clY9FYPzuSdy3tWTFw0ry5hZ2iXg0QW/vEWaGDmlNTu0UFe?=
 =?iso-8859-1?Q?2Z8RNdk0GtSXC47sTbPIQK2ejOUoNNykqV8MDDOisywufUYE+ZfX61OH5A?=
 =?iso-8859-1?Q?QqzZODpaoa3gsUVg0ksQ9qLsKwC4Q+AA9nGGtuNxqLPyrxlPKCNfkyIH9o?=
 =?iso-8859-1?Q?s7XQidgjxVipKlmKb+BH24scldbPTstS2/5MTdPeMONVX08TrwVPGwyH0M?=
 =?iso-8859-1?Q?z/hJpm6wRcRRNMjzZf65d0617J1JWU9bq/nuqcIZbEoQ4Ga0Klnipn0i18?=
 =?iso-8859-1?Q?+TawK1CneihkFe6kG3ComKIsZ0t3vJ3cBD3s/b4GN44WXCDefjBfsghBfz?=
 =?iso-8859-1?Q?cGPkjwe+vR7tz8JJSNsfFvaJar7mmiwUcE14iJs+113zwuI6js0ERmkqB5?=
 =?iso-8859-1?Q?aUKdX4Vlau2LhzSiSUhx7aIuSR/QA50W+WroiaeH6vOc0JB+S9UbRe9Um/?=
 =?iso-8859-1?Q?qMo7Z/EgyH87T+29UsEv/izbFr7+B5Rhrejhy4thWmhjTevC+Ly+pdjrTA?=
 =?iso-8859-1?Q?EJAxHGq6HN7jez+GU0qnChe2b6gKVn9JjfGDLyubolLHOQpP984lBod0gl?=
 =?iso-8859-1?Q?84gIQJ6F6FnAMR+SfrgzLNbYiq82OU1O9UOwdiOBiWhXL/cG1PeGzuJbGS?=
 =?iso-8859-1?Q?5cp93R3UIXIOel+R9ThM9N98sO0I00VwfSkhhnaxy2c6RIAZ5jYOfoN4O0?=
 =?iso-8859-1?Q?84pN19n2AxZlgfHbDkw+3EWDWuh3A34=3D?=
X-Exchange-RoutingPolicyChecked: wg83bZaW1Nru1iMDFAtBzzUOELyAwmT/4jhinpXfEKc64pRZpJvqJxXeMOlL9itPehG3PGX38tUVJKAx0NiNpTmn1PJnHZISL4jN90PhLiXUPgGdFMnYMycdkCPDay9qzrq30v5/GB7JYk0s4T2DYPjxM/b7FXy9IHgS50P9e0bgb8c8qfhNc0BrvJBPnBHR3zEjy49OMQDIMySGB8+fQ6xwYm7sYMb8S5KnaKZ1aigj63trmicAh9hX+R8wpFt0mpngFPEcvAX89bWKlpTsZSqEc7B2LBNRyGnKSkbvQko9mjnbyBVym1FRJN0rrg4Y5HNj0yzeyKJcaas4Nk26jw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa6c70a-0d45-4d1d-bcc1-08df2602f819
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 12:43:50.6531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SB7Ntn+sdv9iwr/+ezRg4JViu/yJGjUcETGHZYvbTfkjIgIwpryli1pRyNzdTWQfxipCvavBlhYx6k2EwU3W8Up88v1jA3yABLlY1OrVd6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8013
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 11:46:12AM +0200, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > xskxceiver -i ethX -i ethX was dedicated for HW tests and both sockets
> > were bound on queue 0 of one interface, which the kernel only allows
> > with a shared UMEM setting. That mode is going away: the endpoints are
> > about to become separate processes and would have to share the UMEM
> > mapping and the socket fd across them.
> 
> I'm *not* asking you to add anything, but curious if the HW
> loopback-plug mode is supported running two processes?

You could now spawn two xskxceiver's (rx/tx) on the same interface and
would achieve the same what we've been doing via

ethtool -K $IFACE loopback <on|off> with single xskxceiver process.

> 
> 
> Björn
