Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD2426D0A;
	Thu, 15 Oct 2026 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068773; cv=fail; b=YtH0L9hrH0dUWBGqvfLFe2ZLl2y9RS/vWIf5mvKCG2o9SbYSFwu2JjoChZZkyRtiwsuz8VMEE34KS7ZVEArq28l5QSPGPqca1MeQZMQR+zDAHnDihZW9zHyxdz+egbCHTh/jYc7nG44UZcqQ0NB2UQArhPUSHAGjQmkGyGhy6Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068773; c=relaxed/simple;
	bh=5SwuXXpcVe2NbZyFyQ0f0Ito+JmgGYc+qRZjr7MyHtY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SvN0OvuGIbJlTSyhupRSGD5VwiShynfxFdNVuMGDY/QhLIcBcza3Qa/wUJRCvPBPxKHnpAFtXS1H6eaKeydigWUxbEsdwoBN2tt+G/XN0YgRFWNPPuvRfFB8fl6GuCLB465wV6jhFZTvRVmSrk1/iNg5/SwBjn9ravPi26I7lmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/j8dAqs; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/j8dAqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792068772; x=1823604772;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5SwuXXpcVe2NbZyFyQ0f0Ito+JmgGYc+qRZjr7MyHtY=;
  b=X/j8dAqsPKrFeRfzM2OWujCm+8nNGw7UUNIiGUkTKuAh3hmpS7BxX9rY
   0KLuDKxLkrSjW9GLMfZFFzaivAg4BzMcfQSmmHqbe0dYbAo9CMHFZ/a+Z
   R9KMBIRNKBjTmKm9Bscejyzt7SZy8tj7XwrS4yPAaaGz58j8+R0Va/b+q
   ab1xeSgeg/Tw9FJav3zrft/AZfs3ClWnPGlWNmawC9LSHQgvesfpAd9YQ
   98sCitj/PAvQQCJU079pSgHP42zebJNhz+6zyu7GIvhdARb8fXxPZ6BaI
   wSF1uNPdaa3+wYxn4CGve7wWeWO7/LWPZwjD7+78nf13htUO26ZLeCcqr
   w==;
X-CSE-ConnectionGUID: /a3vgqN0Qti+YX/fGSkYIQ==
X-CSE-MsgGUID: waOYBT/7QFq47kwR8bda8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="732144"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="732144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 05:52:51 -0700
X-CSE-ConnectionGUID: vF8vz/3pTUiNPAULlzRR5g==
X-CSE-MsgGUID: 0UXlwAouSXm70C0kAuXHTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1645346"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 05:52:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 05:52:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 05:52:49 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 05:52:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYi05U/0osr0Odc83fUjmOWRkpVAk2dwVbXOVplJdzVZ/cUkOlyLck2PibCWKi+VxaK7DvAu9I4JXw1K0i/jyjOR4QWSFtq7/hRv6uzzvPp8P2/rD+IkpqwjhixJPwrMtszFjIhQ5bORECHcjUfkNNDFeE0hdq5MdKIJy/HfACgHPb4Ojhh3q2HrJyTcEsrVZxrHLxd4WPD/eM9Cdc1AnASckHeo7AsgcQf9ZyRsEY2JCsXcEOx45GtjsWggvfOpo7saOdx2Gty67ejA/6QqaINBVT9EdvH/1lVG+M7LK6LrtphFAqgaNxMstOwQr8lPrujskWpziindTZkmFqNivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmWR7T3ANSEEzIG4rprYNMPAqQl60Xk7UZFr+OvkyRE=;
 b=kVIWxLRl62bQlQ6fJMpc5vk70ldHxShRgjRWQFY4Whg3gB6e7nIQuLXwsBDh6hWEn9EQNIRse87F3R73KRf4lG0PxbAQLSTvVdpSBR5BvtQyrPUNsUBDHPZUEvAhZ/e5KX68YTH+muya37OMWzQHUi0koGxw4+oaIjo1I+arP3p0Sxw/E+2hDH31izzaaq9q1yIwggUsbGa2sECJvyDnuheKwowj5o1ZHR73I5Fl8FHhA/XWZs4Z+bbVZXarBLGD8cw81xZV2fQh+ZcLIexjcF+bqaeK6nNm9zdiUtNQQMdn5yKVl39s4iH8w5+oSTBGQoibQbshsm3SaLbnNhpjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Thu, 15 Oct 2026 12:52:47 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 12:52:47 +0000
Date: Thu, 15 Oct 2026 14:52:35 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>
Subject: Re: [PATCH v3 net-next 14/15] selftests: drv-net: test AF_XDP
 zero-copy with an SKB peer
Message-ID: <atDMk+dDMd7YnV1+@boxer>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-15-maciej.fijalkowski@intel.com>
 <87jynj5kad.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jynj5kad.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: VI4PEPF00000144.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::88e) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d1a3f4-7dbb-43e1-c8cf-08df2abb3640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|4143699003|18002099003|10067099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: K5OrCZxZUxgiTKUfSTbwrJLSEV3XY3IrY3uLOORU3qUWmbQiX06nhOmdHl1Vqwm66XuHvfSp3FRuteZfQJM9pHVFmBt3Qeh/2RO3HlnFe1qsKjwrM3xaVuwazQc8ewX3sIjd27e5/oV2eSu8ww1qXYS78QIVNNnt45+mMbD7W5Hb1lkanQg8ay/7Cie9VolbiD3BCC6Owg8zxQfJo1ltIbqYE5JxHDRovq3ffEMbSq8P0RMl+gKS+6MUkPRm2yzu4kdyr+6hV3rshWGpCvbB+YFd47MsHrfGClb4mWyILqhxcVtlFkzBTI5y92lSoaTuQyXraqt7VkuPmH30uIt8Qt5Zzeitd8virHTKMx0wo/sCRpyplNYyf8wq3CMRyen3aJRZHs8LiHVR3roiEDGmQsrTdNQwgkIgLbJXNZ4aJIwt9pweAp+xKEFhtQcpoxK5PCaQw45F3cQ0vwccmoauH3D6PEBQM5oNP2KkXCKgIJ8Z5YQn4sVvSJ8n2bt4QM7GEe04RYYCYK1MnL2iZUIth4nUOtpU0TN/ykzUxen5d1cMddrTz9VM/+CTUoOHATM/vc82rA971LIgdt8DkCAACUBIdCx0f3oamZHeF30giU162J13M+UCKE9QuLhmPXl5JFTxr6gK6l3lwD4Vqt/ZXrzwfaiyQl4YWNopJMo6Z+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(4143699003)(18002099003)(10067099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1/ndOj0CG9PndSjoaGwSaf3CYBj4BUeifA1FkAYPhpaAAPiZV2ysUuGNiH?=
 =?iso-8859-1?Q?Hl6M+8qt29yvVvwhxpsV0+7rE34J15RHb6bwNKqQm6ine75WRruys8qfZP?=
 =?iso-8859-1?Q?Q7ol0B2tXNosuMuD8PCvXmWKPinTJ8jq8JNnpXd0rmbQiuaclts4pnyqgn?=
 =?iso-8859-1?Q?EuokRoXMEOPY0GdgNH5mXshnTlaSnd+SiUvasLW0VUXPqE8w08Oyi+kSD/?=
 =?iso-8859-1?Q?NvgsY30sg6GEYHja9XLRABv0wrJW/7al+iGM9hXxd7jcwhA5wKvLscT5s5?=
 =?iso-8859-1?Q?H+r1HTyuWuixbdx4sYi8EVt0eERWhH9V9q5+qhSuin2hqoOpNG78sbbNPB?=
 =?iso-8859-1?Q?bdHCEAyXth0O+t6dKha8/EcJoYb80RJX0Q1vLrtn0q3ILVGe4UvCrxO6As?=
 =?iso-8859-1?Q?tGTqoc0kcnGsScEglPZUGEuU72Dni+prxCSQ/reKMlci/8kOJQaSemWTvW?=
 =?iso-8859-1?Q?6G+XbRo0VkGm9IjCegwHqoFugr94dQm3K5GdAQhOM20BevBoNciNr2kWpX?=
 =?iso-8859-1?Q?0Cg5YWnNQO9oTayfciHyXj0cQR0gdewj/FoDufbjGv6cpKtjxxFtiHMQZf?=
 =?iso-8859-1?Q?8XsayMMl3h7QoR+DX6ypSiJrGEYTLQFX9But4mbtRL+PMROE5ddy5kabow?=
 =?iso-8859-1?Q?tGYycPSTZT4g13jDLQBNfq0d7X0lyWpiz3hledfjdWpaBZlUjGx5gg87dY?=
 =?iso-8859-1?Q?q3+wRffSu8/RBZ+KDYa/vbDIYVGXB5l6fifliBUoBXXuPznVCxlnNCUX4I?=
 =?iso-8859-1?Q?HQPDW9Yu1HuySHGC9tOF5ePF90cSvd5eawgaDq4vkIhq2HSl22MdRPLn0s?=
 =?iso-8859-1?Q?NHaIssAwRJoLU7KLjqneW2QupymMLYWPBQyyK5HmxFr4oZP6vOptioKDDJ?=
 =?iso-8859-1?Q?ZQpiKDNBBdOQBPnDosYq+VLRpVim7w69U/AaxImPtvWddweyVvkCXyyhFX?=
 =?iso-8859-1?Q?NFQdM3uZYw4hX0yDoG6IXgRT4XOx+wcdzu7JTmcxdR5OLafi4wBEW/Mfqs?=
 =?iso-8859-1?Q?SHTGrWI74Qz9zKOJZzXa/wNNdgu+52zG0Mux3T6BFRoWDeRBzkBfL/ZTnq?=
 =?iso-8859-1?Q?e9UpYlATUnOwvjQmdsuiZoQQFMxVnwqilAXrmuF9m+/i72wxm7kIHOfcw2?=
 =?iso-8859-1?Q?aRuUivNoeDYP5jx/ieaXbUHIdhNUzfD8vP1VkIF5WPhzk9tWlTYxyWV7i4?=
 =?iso-8859-1?Q?jJOu8X7IbVazpNR0VBd5XMTkZYxOPV9VtpNhg83BhcOLyAvVlyiuhHKgG5?=
 =?iso-8859-1?Q?e+noFrYEGtRVhNXaTkDZhFFPInZuQDgKpJq/V7hlFo1Ru7Ja9g5GPZlcmm?=
 =?iso-8859-1?Q?Mtq4tpLoE5ayKoIchFzHdLXpZjaAzvz5l9qehnwBxusIpmqe1QSytRdlOR?=
 =?iso-8859-1?Q?vb+A9xcUeWNoDUVGWyufW301qnWuyNO3+HcxBB1tvJGerM7XOME3y3tnfa?=
 =?iso-8859-1?Q?590GncoEkqxRBKD2wBcJseW1hd+ak3LInEc9XSjkHhGuZz6CDaTgC/AJXn?=
 =?iso-8859-1?Q?xaXnSz7qaYGtB/M/ZR5KPW/0JuopT1fqYaX8fMUcSGZc3XyAtO/dPgz6/h?=
 =?iso-8859-1?Q?D0E3RnzzWq/2C6hr8Mo8zbCYNp2tgYT6FDuP508AuCQrLbPe9wZ6McYIWD?=
 =?iso-8859-1?Q?dtYhRfWaJY9kcktZ4OiRvTipDLDhwFMdlhWOBP3gDlXv/B+1EN4YqWg9U/?=
 =?iso-8859-1?Q?hvFrnsGrQWLoSQLTx81h3rFZ2ibV4edVjqJnwijYxU4uYCLBPcxJXqO5be?=
 =?iso-8859-1?Q?2pI/HXysPBzMwWGS8l9Up2+yiB2wmb79NN5zqUqwmN8yz0c0Bosg6DukuU?=
 =?iso-8859-1?Q?eleDsMVP9u6QkyZWEBhTip1pPwtdy8E=3D?=
X-Exchange-RoutingPolicyChecked: 2nJoV8Is8v4mkXJybT7k02nFG9sU8dOkVTTeRTgkhEoywRFMXK0KQDGZ77NeRvy/C3YNSb/G6AP6YJEq0dL8lCcfN0NUTIp+ePYiB3yrlHrsr5EYAMck6vhcY5usUPKLZJO608I9NaOSO5DcVk6XAsWajAtVCoD+Vjtd9DvhOPY80DGyKqxbHJHtoqwLyN2vOx7CKJMOyyqsfvEhMX3wq8ynh3p3btsTq4MSDz7teHX84cRDK9EoKuvKUIt2Q3EmNSOmil6TBwciHiZeIdu/Otm8p7qBGPhoV7/JMDEhPC0oZGsTFqrex/cAatD9FXCOX1wlAo6prVkXDJdnEbPsQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d1a3f4-7dbb-43e1-c8cf-08df2abb3640
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:52:46.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytFW8eQkX2oTNtfen/YmOZ/dv6jNikSEkrLGF2YDAa9xLAiLZMP7XTFsb7IOAne6qvzMrZMH48gzAR8N5tX44ZKStFASejzvg1JmbQKZaDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-OriginatorOrg: intel.com

On Thu, Oct 15, 2026 at 12:29:30PM +0200, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > Run the AF_XDP cases that a physical link can carry as pairs of
> > xskxceiver processes: a zero-copy endpoint on the DUT and an SKB-mode
> > endpoint on the remote, which needs no zero-copy support. xsk.py runs
> > the cases that xskxceiver -L lists, in the DUT directions listed with
> > them, as KTAP variants named <rx|tx>_<CASE>. test_xsk runs them with
> > the DUT socket driven by interrupts and test_xsk_busy_poll with it busy
> > polling, after xsk_setup_busy_poll() sets napi_defer_hard_irqs and
> > gro_flush_timeout on the DUT so that SO_PREFER_BUSY_POLL keeps its IRQs
> > masked, as on veth.
> >
> > main() sets up what the cases share once and undoes it after them, as
> > defer() works only within a case, so xsk.py rejects -l and -h, on which
> > ksft_run() exits without returning:
> >
> > - the DUT endpoint binds the last queue with both an RX and a TX ring,
> >   which is taken out of RSS with ethtool -X equal and handed back with
> >   ethtool -X default; a TX endpoint fills no RX buffers, so in
> >   zero-copy mode its queue drops what it receives and TX cases need the
> >   queue out of RSS as much as RX cases do. A DUT with fewer than two
> >   such queues skips
> > - an ntuple rule on each host steers the test UDP flow to the receiving
> >   endpoint: the DUT queue in RX cases and queue 0 of the remote, where
> >   its endpoint binds, in TX cases. A host without ntuple support skips.
> >   Setting the rules once spares each TX case the ssh round trips of a
> >   remote rule and toggles ntuple-filters, which resets some NICs, once
> >   per run rather than per case
> > - huge pages are reserved on both hosts, and the UNALIGNED cases are
> >   left out without them
> > - both endpoints get the DUT's xdp-zc-max-segs for TOO_MANY_FRAGS,
> >   which is left out without multi-buffer zero-copy
> >
> > A DUT that does not advertise AF_XDP zero-copy skips the run.
> >
> > The remote endpoint listens on REMOTE_V4, and the DUT endpoint connects
> > once the remote says on stderr that it listens. The control connection
> > shares the tested link, where the XDP programs pass it to the stack.
> > Killing an ssh client does not stop the command it runs, so timeout(1)
> > bounds the remote endpoint, and the runner waits for it to exit before
> > the case ends. The endpoints are waited for with the test_xsk.py
> > helpers, so the output of one that does not pass is logged, timeouts
> > included.
> >
> > The endpoints detach their XDP programs and restore the MTU and ring
> > sizes when they exit; the runner detaches the programs and restores the
> > MTU only after one fails or is killed. Each endpoint sees only its own
> > device and mode, so one may skip a case that the other runs and then
> > fails once its peer is gone; such a case is reported as skipped.
> >
> > xsk.py runs the xskxceiver that net/lib builds, which drv-net already
> > installs, and copies it to the remote with cfg.remote.deploy(). Add
> > xsk.py to TEST_PROGS and to the AF_XDP entry in MAINTAINERS,
> > CONFIG_XDP_SOCKETS to the drivers/net/hw config, and the xskxceiver
> > helpers to the drivers/net/hw library exports.
> >
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> I just skimmed this, and it seems like it needs some scrutiny on the
> cleanup side. The LLM flagged a few cleanup issues. Could you check
> these paths?
> 
>   | main() only restores shared state on the normal path. Exceptions
>   | during setup can leave RSS, steering rules or hugepage reservations
>   | changed. Would a run-scoped ExitStack help here?

If there would be no objections to ExitStack usage, then I'm gonna do it

>   |
>   | _steer_udp() enables ntuple filtering before recording its original
>   | state. If rule insertion fails, that change isn't tracked.
>   |
>   | _unsteer_udp() stops on the first error, leaving subsequent cleanup
>   | undone.

dang you nit-picking AI; these are valid tho; maybe these come from a
desire to setup steering once, not per each test-case, so I couldn't have
a matching defer()...

For gro_stats.py it's not a big deal but here we run ~80 test cases, so
pulling out things that can be configured once per ksft_run() is important
from execution time POV.

>   |
>   | _run() waits for the remote in finally, but doesn't ensure the local
>   | endpoint is stopped/reaped if its wait is interrupted.
>   |
>   | The fallback cleanup restores XDP/MTU, but not ring sizes after an
>   | endpoint is killed.

this one is also valid as cleanup_iface() wouldn't be reached - i assume
it would be nicer to setup ring sizes from python side now; i could get
back at passing the test name and based on that issue ethtool calls rather
than plain ioctls from C. We might pass the info of ring size via flag
when calling xskxceiver.

I'll see if this simplify anything or make things worse.

>   |
>   | "-X default" resets RSS rather than restoring the original table.

It means someone else could have modified the table before reserving the
last queue - should we respect it? But that sounds to me like other tests
would be doing bad job at cleaning up after themselves. My assumption was
that we start with clean state.

>   |
>   | An unconditional SKIP when either endpoint skips can hide a genuine
>   | failure on the other endpoint, including a crash or cleanup failure.
> 
> The defer ordering itself looks sensible: detach XDP before restoring
> the MTU.
> 
> 
> Björn
