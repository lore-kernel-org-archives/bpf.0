Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B9484252;
	Sat, 17 Oct 2026 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248669; cv=fail; b=G1fI7IGtU7DdrClhP49WIrAJ4cCB9GH6D4/UkbBwck/lnFXOJApAmp2xoZmf4zBVkJm2FptSF2gpcJQycxrdzscm6aypzLXh0yWZQJAcKLTtbOg3bxGUv937hGzDsWVNVUMCKdum5gHGJTOsfOO7tl1V4/DLrBn8ho89FZ9Zem0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248669; c=relaxed/simple;
	bh=x33HgS9w5w9XaUC0/QREnmEaMR/z2BtkTtoXUi1HLbk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mUEDwIosrcuDgSD6IN+vEup9TfKfM3dBCCEAhUeDkfyeHMI2m5JRQHmb6HH+5K0TWl2w1kAywIzVuBmN8s0hhUYMP4QZMAm8wgH338BSHpehpKIsN1cblizc8lGmiTvmpDlvLkN0SRIOpoV3lDlGSehPnnRxaKtzMctUXdybvCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZiu0VQ5; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZiu0VQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792248666; x=1823784666;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=x33HgS9w5w9XaUC0/QREnmEaMR/z2BtkTtoXUi1HLbk=;
  b=TZiu0VQ5Uwl3Lx6XoRlDGGCwU8Rl2NfhTYdbu+ObqSXdAaE2zRJgTVjD
   8q+PXiOynPdHfNooshaV9IOA/O/F7FwKGjSp8BRXGTgK1IGkXgSRDSmwl
   XGMHgS7frr46gOGVNHu2CZWfO7st7R8Cs825++HxdjAFVl84lJOFpNyzK
   MDkD/pyIy+SZGnsyq57/JNx1e51SJG1pGfLML3AY/B+Un0dqsrFusBLr8
   17GdCT2OkWBnMEf28pQ+8oY1IsFla+nSvpzZS7dS9JLEdYhqFSlkcHi/B
   PdptgczhXfF3zJofwZYhaY6xMQLzE+SI7//1weVdwpXKpUHUrp5B1hvlO
   g==;
X-CSE-ConnectionGUID: XzJOB8HGRlK98vhlOHObRg==
X-CSE-MsgGUID: oOuEW6GRSD+P7aHFPytRew==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="895185"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="895185"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 07:51:05 -0700
X-CSE-ConnectionGUID: rlI1MkOJSw+4wBSOAK231g==
X-CSE-MsgGUID: eSOFjc+RSly3RhxvGyptZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2053585"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 07:51:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 07:51:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 17 Oct 2026 07:51:03 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 07:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bek10+mni3wDnJbOxk+QsNzSh7YP5gbA3dQKVh4+23YpV1TJcuRek/vPq0E4VRpDHxNBxbU9bE7IYm1AfkA7LzuCMCCetJbGsSwNnbhA+lXrtqaA6F0dzWLvJmTURax2FjA2Ozbdu+2fLPhGp0ZF6A+LrxBrJfTbYdOeC7Hx4/dYrq3buum3Npqkeo/BZU6xZPOGUfg4oiYl9CTSBVgjlPaHcai6Y5MSJMGou9ds9v0elJgr0UDaHWfYCpc+7wiQI+gnr132GNx9S7EPbZ6+BWrEqAeXNtAeZrZKmCfJxfCTXMTdmA7bvjwR/kmTuTt9qNk02hkuJLQSvSIe6QvdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dkZos3/Q7Kb6w0CogrNFe6s16YZkkG7u6hpRfyCEXM=;
 b=SCw7pQnr4kWyX0QAgmU2ObQ8gg6YJhnhrfTPdvFgrmGz0f9zt2Ut6ycs7nTe9ZM6MX/hDV/r9TREZpxI6pWxV/xAbz3ComjTT7/BJlGSJ3BepTC8Iqvz5f/syTw4XbHuPw6Jp3543t644mUfSiMdrctzW7/c92x/n/6g/ch3NhadYyLANeQucPc2zJHxEwpnnaQAWX9tXpF1Kn/4+lzVAUhpwCZwphaC9l1Ak+chInz4nvCnjiZDMRiGq9SWQQlcFr/wkfJGZcA1URvg3BKxcVzBkI6bM364cfHxpZriNJsZvm6G9Q7cHihaTjL+Jqk+VHhfXSsO1pPlMSJJ4HcFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6358.namprd11.prod.outlook.com (2603:10b6:8:b7::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Sat, 17 Oct 2026 14:51:01 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0522.012; Sat, 17 Oct 2026
 14:51:00 +0000
Date: Sat, 17 Oct 2026 16:50:49 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v3 net-next 03/15] selftests: xsk: drop the
 single-interface loopback mode
Message-ID: <atOLSbHkCUhVnBZ4@boxer>
References: <20261014184539.774708-4-maciej.fijalkowski@intel.com>
 <179220636510.434549.7705519903366245411@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179220636510.434549.7705519903366245411@kernel.org>
X-ClientProxiedBy: VIUP296CA0155.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35d::9) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 33792ce3-b8b9-4646-2ac9-08df2c5e0f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|10067099003|56012099006|261009223027099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: lV35XWIEnJWp/lOuBiMfxLGrqFTLWQLUEcx7p5o7BcJ0LYYbXfkqVLIH1CTA1nawihAaiOJNKrqirU/iAKBllh8+YyMVfyceFcjfSVl9qbFsmufd7Qb2VtpVLor1HVv4oFHTrMiKt6hjSB6d9qdllj6VPozdJBqs1+xwMEiSQL+bfTxeYrB2ACqhGYVgQWEsbCZ/6RPenzdEEcXDDPU5H4DFXUl8JiOIzin0C1VvVzYsGAAo0t6Z8sXcaTj7WV/N6QMUONO1XJpJFrMc134g/Rggutojood13yYYxcsZvkXj9FdaM19TCeEzXnvD8vTmFQzJec2pWJHCNwy9UmWCuLgGifho0KvgMseLJAwekhug7ELRDXwQkGAC0V1h907Me7Jmy+2rMzAjTSh6TABmHWcvzF77TwWDHNHH48ZAwBHirkZWwYcupgUnopaY/bxQPBsRWOsCBF7D43CEwO80JJIWGtYXDmTAlkFJPYI+uxQqaYduD8jFRCnAOd76Ye51yefcI+F3QWxCETSugwIUbTPWfLL0/xLMSj4On4veWWCY2NXuWLqUjZsympg1RAbRMxDF273NcDmeGQbmkvUu8mpsKJwzwAeSQCYlPFsZffJclCK2IZKjmraKWmu03ACS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(261009223027099003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AhByhxy7kPQDy8ys3Ts6nsKux01ysqijPbZkbo9scJzpyRys4Zq23O95j9?=
 =?iso-8859-1?Q?6KDCxs2XKxgNI3BLYOA50BvGibg5bVO1hKsd1IGyE/5NRRmKrEHRtHWaKm?=
 =?iso-8859-1?Q?IrsGb7iiiHIq2QARAiX/atXC44DCcPDIoLMAXhCc3dQipFAlzjdx4hp49D?=
 =?iso-8859-1?Q?ht8A6mpmw1o+A7U8xXQiccT7jDUkvs87QgSodQlrvPcm5tdmXOz2V/qQy3?=
 =?iso-8859-1?Q?mSfVf2ZQUxwuw5xNu3qZW/KcxMpuG7V1Av7ooW/21k8ysHGHTIRz3LMNBa?=
 =?iso-8859-1?Q?+sV3+xVeGDFtbVOgS6ftCJHtuN2md8vII/6pUg91b1cxQv7SfR9X6g4zkq?=
 =?iso-8859-1?Q?VKUi2SMsryVwls4cjCvaGI2QPXYJURrHugbqtCCyhdfB4XbKUwwcQl5+8r?=
 =?iso-8859-1?Q?LYuaYJSu4vNenUNdU5AcGKeMn9H9SbiEfbD5OvxDU58yop2C4d1radiyBN?=
 =?iso-8859-1?Q?mEh8lrWI/729MS/K/6MU/Bf6O3CQ5HboylTzS1XxfIxEcrKzWs7Bq6cLHF?=
 =?iso-8859-1?Q?vzXL1CoADH1G9QdnuJ85EKt30VXpJWTwP4ddGJZDSfdE2ZKh4ZpX9UsZEm?=
 =?iso-8859-1?Q?ypyHIhS/HcreJ+RpU9p9a+VGjyW9/0HJU3ImrsPl+/h+TidQvJz85Cimx/?=
 =?iso-8859-1?Q?5jPL8fAg04si9Xli/g+obfR4dFjDU6cdSaM5u0c5lJhgIn9TbnR3azgp6b?=
 =?iso-8859-1?Q?vF2d4uwLfqHjDyuxdF7pRiW5zKz55Nkq/0VND9+N0QE73fcW12eoZHPdTJ?=
 =?iso-8859-1?Q?m9rY2bLftzRjCsboMznS5Dt2x0jgy091HahM+JLjuHJF0r2/JUumpO35DO?=
 =?iso-8859-1?Q?j4Sl0XZblWAz+A3ZiGYly0Y9t8i0Etn59YBzhS39LAeySPichsVWk2NTs/?=
 =?iso-8859-1?Q?Q5TIVhroAuy3KBTYrynaAr/oWCrumjdfGI2TlOtPKb0OP3TM572WCkRFFi?=
 =?iso-8859-1?Q?XcBiS2S7WCr0bOrTPc+WehRo4gs2sVLx21bPSeGLVz2QmP7fck90T0Q/8E?=
 =?iso-8859-1?Q?343irz0V4yoF4GIVp45xypX2tkEUyr2UKuzlAse1zLWynTKcV6rOplv4rn?=
 =?iso-8859-1?Q?RD8A7yu4sMv3rbu+Sze7sZi/rDLHNl+xAFzxxRNdL0/Tn3cr/RvJ9E4c+5?=
 =?iso-8859-1?Q?pQRRg/iInFXWujhFgn7MI1PzhCofSIQb6/9rosC0cLpmm1j4QvyYUpj5gI?=
 =?iso-8859-1?Q?vRRkyGYk5DSIWmH9mOATk7yGI+ogkgOMCedO8rbJ4xT4Rf/EOharh/7t/s?=
 =?iso-8859-1?Q?t2p3n049v77SlgRFrdaF6YRNTRuq71uytWNycLhOAsNDXpMZVuzdVJhZiy?=
 =?iso-8859-1?Q?ou8rwJIVyuVb5A+hCHuoOXY6v9dcy551xpiS6SWo2ICRp6xnQ+D1pi5lus?=
 =?iso-8859-1?Q?aluztW2b3bHXtpHX5N+ghNot3DO5Trps82oW1bi/pxe/JALilAbyDpOqwd?=
 =?iso-8859-1?Q?ehTCTOU3a7wTmBX/9nxwspLf61tJuPtbiBJNRhJ/yERXGgMc/rbKwdzGfz?=
 =?iso-8859-1?Q?lc9lfQAbR/XBD42MrLaSYny3aJgjFx3Rh8m3E7diEvvrFRSdc5pxnZKZZE?=
 =?iso-8859-1?Q?SdtP/5WZv70x1otKUuUgB2bh1O0L88pkAEFCcZxTRILXIY1bLtEsAU2rnW?=
 =?iso-8859-1?Q?3KGccLnfRXNpTqCajwO/8CYkFALIJfoJ5xnLzZ1wqy1ArW7v87KdExakLE?=
 =?iso-8859-1?Q?2Zs6FWDkj3wsfUSs5zHeZbtR1VBAeE2UwOBb7RoDpKvKnzqfFD/8mlt9gC?=
 =?iso-8859-1?Q?+2erwUWZ92XyHnuK2FPcxpoV7hSji5Qp4mrIszaVS26aCR53ngrQMpyaQk?=
 =?iso-8859-1?Q?u6E3NhBqlE7FEnRoxKEEyj7uL12k4hs=3D?=
X-Exchange-RoutingPolicyChecked: fZ5OctHrJjgCYijGxgnbW15/twklEph4VlSv5RlY0zglnwhqgoIv5cX9vcI3gmPft5qAASalJX1U9xnR1A/b8j6EER0AWaZZ0O22sG4lGFco7pfySsgfnazXtj/ENXBNJCuIYA/OkrMz2BAMTw9hyuti/wGe5gWqD5nEF1CNfClJ9F59si6zYpOa/3I9IyCs2FNLsI5yQzQMUbKIrlY6h4bqSNz6Xy9/xpzatQT6/S+pBjvOweEpph6rAVMaNzAWhZvuZlO9wUTx7b5LvP1VybQzU+OJhFTWZ7pOCv2p9h35Y1H1d25XccPezNQqdMx/oc4dbLY9/kxo2rBXHZysRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 33792ce3-b8b9-4646-2ac9-08df2c5e0f30
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 14:51:00.4701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDnfcdxWY7tdrTUdLmbxItmveKl83Pevk2mJpK3PMHHGE9BU9pv3D9o03izKX8nZP9kz+KEQnK9oIukKmIxXbsv/i9Hb3MF272QwubrzkL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6358
X-OriginatorOrg: intel.com

On Sat, Oct 17, 2026 at 03:06:05AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 � High: 0 � Medium: 1 � Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Old single-interface invocations are now misread instead of
>   being rejected.
> 
> --
> 
> selftests: xsk: drop the single-interface loopback mode
> 
> This commit removes the xskxceiver mode where the TX and RX sockets were
> bound to queue 0 of one interface with a shared UMEM. It also removes the
> split UMEM addressing and the POLL_TXQ_FULL workaround that mode needed.
> The -i IFACE option of test_xsk.sh is dropped as well.
> 
> > diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> > index 62db060298a4a..69fac65f073c5 100755
> > --- a/tools/testing/selftests/bpf/test_xsk.sh
> > +++ b/tools/testing/selftests/bpf/test_xsk.sh
> 
> [ ... ]
> 
> > @@ -88,14 +85,11 @@
> >  
> >  . xsk_prereqs.sh
> >  
> > -ETH=""
> > -
> > -while getopts "vi:dm:lt:h" flag
> > +while getopts "vdm:lt:h" flag
> >  do
> >  	case "${flag}" in
> >  		v) verbose=1;;
> >  		d) debug=1;;
> > -		i) ETH=${OPTARG};;
> >  		m) MODE=${OPTARG};;
> >  		l) list=1;;
> >  		t) TEST=${OPTARG};;
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> > index 7dad8556a722e..24109dd7264e2 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> 
> [ ... ]
> 
> > @@ -388,10 +387,6 @@ int main(int argc, char **argv)
> >  		ksft_exit_xfail();
> >  	}
> >  
> > -	shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
> > -	ifobj_tx->shared_umem = shared_netdev;
> > -	ifobj_rx->shared_umem = shared_netdev;
> > -
> >  	if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx))
> >  		print_usage(argv);
> 
> [Severity: Medium]
> Now that shared_netdev is gone, what rejects the old
> "xskxceiver -i ethX -i ethX" invocation?
> 
> parse_command_line() still sets ifobj_tx and ifobj_rx from the first two
> -i options. validate_interface() only rejects an empty name. As a result,
> TX and RX can use the same ifindex and nothing reports it.
> 
> When that happens, each endpoint binds its own UMEM to queue 0 of the same
> netdev, because xsk_configure() now does:
> 
> 	bool shared = !!i;
> 
> The TX bind cannot succeed without XDP_SHARED_UMEM. xsk_configure()
> retries SOCK_RECONF_CTR times, and then every test fails. Nothing tells
> the user that the mode was removed.
> 
> xsk_attach_xdp_progs() has also lost its early return for a shared-netdev
> TX side, so the TX attach replaces the RX program on the same ifindex.
> 
> Should main() exit with a usage error when
> ifobj_tx->ifindex == ifobj_rx->ifindex?
> 
> test_xsk.sh has a related problem. 'i' is no longer in the getopts string,
> and the case statement has no '?' arm. Running "test_xsk.sh -i ethX"
> prints an illegal option warning and then runs the veth suite, which could
> be mistaken for a hardware result.
> 
> Later patches in this series look like they resolve this:
> 
> - "selftests: xsk: run one test case per xskxceiver invocation" removes
>   test_xsk.sh and xsk_prereqs.sh in favour of test_xsk.py.
> 
> - "selftests: xsk: run the RX and TX endpoints in separate processes"
>   makes parse_command_line() take a single interface. It calls
>   print_usage() when the role, peer host, peer port, test or mode is
>   missing.
> 
> So the problem seems limited to this commit, for example while bisecting.

These are correct statements, however I wouldn't expect us to be hunting
down the bugs while bisecting onto this particular commit as it is putting
the tool into transitional state and as it is said above, future commits
take care of this.

Let me see if I will be so clever with providing justifications onto
further reports on this series ;)

> 
> -- 
> Sashiko AI review � https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
