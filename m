Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642583C4B8D;
	Fri,  2 Oct 2026 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964469; cv=fail; b=aF2jtw5CC2NH8XvHDmkWmExnn6k5jR1X/evZQWOhHr+pUTgLbhIO3ehc0AmfKW8iJcGpL/l+DfrOk/rcEfkvbR2MnAs2efKw7Rx46ERwcJfY9eSLbL2ROAS2ZDz4FNoyYjbw02YAF3ZHDhRaUnr6fjOaRd4PugcQt6UuIyUdATw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964469; c=relaxed/simple;
	bh=gfBNaqvwWvPizNa8p/tfYZn4gJeHMgteddPa9XgtFt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uc/XVKmGPeMT7fK2Q9Dy/aUm897eEingxA27XEB0/IsTxn2pummgNriktGqqdmOKIJPB3aSuN9JghMyTB/hG15QBy14ycBJ+OvUsGL/IQRWVdBvTDCq+9AS4yj32j0jZ8wzVhxrmkuwP7R4as6C1cXM0jZM52qdiNwCQGo4NSRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D26k+oP9; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D26k+oP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790964462; x=1822500462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gfBNaqvwWvPizNa8p/tfYZn4gJeHMgteddPa9XgtFt0=;
  b=D26k+oP9MYofcABqpnUf+pRsA0kBdc8nMqABfC535pdWS6keWfPo+4Fp
   MK29nQDx52ckJLcVuoWPDRdTiUeFVNT/FgkqxDJ0QnB9exfKMwWj6AEPz
   OyfR7Ruj1yQO6AyN1WqE4QVDm07uRErysIM0OL3s5hdvz8k4UY324amn0
   0MGMWX8pRUC62bjtMJUuRR4qqDoSEVPPg6ksC/MrR+yLMLsglMhJNfK84
   S95Qi8lHawMUlSuuT6fh8oem2YmBeeT47xwl2ZDkahts2WpaFcp5W0bG9
   XllKuFxOn0/a16DVxT+IEqyqBYn0RaQWezpKjvZWLr7Of6gb0hzpfbHF9
   w==;
X-CSE-ConnectionGUID: I4jgvemoQxei6ZNh6OoXDQ==
X-CSE-MsgGUID: VRpW7Ty5Ty+x5nzMY5jePg==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="101898295"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="101898295"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 11:07:38 -0700
X-CSE-ConnectionGUID: RdgItYUsRiWsisnbOjGlUw==
X-CSE-MsgGUID: yzrk4YApTKKAxYtYkzz5iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="314296138"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 11:07:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 11:07:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 11:07:37 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 11:07:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf62Wul2MYzBlp7CwyY0bKh6paqHeAJIsV1ADfqa4NVjVd1+TR7CI3/aL3TdY9Ez1jzCCBs6uMIkoaYWFd8KYUPZfCGlXfmIS+nv52+7exWTq8WmRM5UVx433SjS3RtvQ+thj9tLWRfc7yxwBTAaKrf21/Od+zck3XztxztfASwWnAwv5g+Gl2gzwpAs4mWYZS+bCPQp8bG8CQjmEVaO/B8Qqul+a8BIFObBJCPfmuqryL0Fq7/5D5CFRvmXBEQW+kWUKH4lSsh0+QeXzKasR6M89FDax0ol6sBdqPIrjFUv7oYeTGmr/zd7mUbaty0WBCLnaa5kAtQpKSKZ1npJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDkwIWug8nXA3qKwhEbmYBxeWKOAFPrJJXic7H631CI=;
 b=xUJOnUDPGcFbxvkfA62YM1nUUpOlV6jq0Kho7O0LCliLJZkGR2B0erajZXlPvzOvZlijoAk4rDFNL3fhdArzeZkdn4Esnz43IhUujnSBkUyvTYWcq+1P1rPxkGVbzvnR+EMwdUxb52ZWlefljN6cLeoGh+wG+crzpzuL+xOM0Vf4wh3vd1AWlNqoFGMHLMVgV8qHTWSt75POg51hUqkfoD3IrSCO0MeBcVT5VuQHjyRs4ZU59nFg2JE+W/RKA4gVjvcPhAXO3kW0VvBzIitTSHrRrAj0NqYWdT+Bhf9DdlChPX1rsXvW9KzM4g+Yv9cjTQg/kJHrP+ZK10cqQ+mX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8028.namprd11.prod.outlook.com (2603:10b6:806:2df::7)
 by CH3PR11MB514151.namprd11.prod.outlook.com (2603:10b6:610:360::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 18:07:32 +0000
Received: from SN7PR11MB8028.namprd11.prod.outlook.com
 ([fe80::1731:75b0:1bb8:9b19]) by SN7PR11MB8028.namprd11.prod.outlook.com
 ([fe80::1731:75b0:1bb8:9b19%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 18:07:32 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "stfomichev@gmail.com" <stfomichev@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kerneljasonxing@gmail.com" <kerneljasonxing@gmail.com>, "bjorn@kernel.org"
	<bjorn@kernel.org>
Subject: RE: [PATCH net-next 09/13] selftests: xsk: run the RX and TX
 endpoints in separate processes
Thread-Topic: [PATCH net-next 09/13] selftests: xsk: run the RX and TX
 endpoints in separate processes
Thread-Index: AQHdUeKnNfswzXEXI065OzwFuFgYxrbqjGrA
Date: Fri, 2 Oct 2026 18:07:31 +0000
Message-ID: <SN7PR11MB8028097375CFC0B1B6E4B8198F892@SN7PR11MB8028.namprd11.prod.outlook.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
 <20261001202124.692591-10-maciej.fijalkowski@intel.com>
In-Reply-To: <20261001202124.692591-10-maciej.fijalkowski@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8028:EE_|CH3PR11MB514151:EE_
x-ms-office365-filtering-correlation-id: 21150c34-42cb-4d87-5984-08df20b0076a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|5023799004|56012099006|11063799006|4143699003|10067099003|3023799007|6133799003|38070700021|18002099003|22082099003|17002099007;
x-microsoft-antispam-message-info: dilP+TRnNsxg/jP7G0Ls7m6Nh7o/6pONKdds+tpd4MvWD38NY9bOed/U3EppstIxNvd6NmkZCWciVS1eVc7315FPLGLrmIyRWec5VCkYC2FP/dKsr837oDd7exKh/53m+qMg1Dbe17BAFt+B+Lu1+2MWPlEXF7VjgJYFebB5qOWLgdVvQYcCN3BAMSIyUKLprvtziq3tfAA9Va3/FT8dVijAbEO97vNH1vY9OrkF1mOkdOZmTKrBCY+dE4sMlNF9CMXaxQ8aJuf7SllfbuwlSnATqIZtPEKCACjq39lR/IO/H3LreSQS2FqiB9syERGTG3sklQ1bRhkP4v9IZkMmixSGSaIqtD41OMFh8miEmLFlLn3bipuj+iCOev3GqI6tw9r3kqp/z0HdHJEmAo7KC5GB8a6qFtTsgcRIXNfN3uHJcIdAce011+Ie6gq7fTy8OC8W+4HFZNjbjSwWv+7tE8Aj6GiukB6YX3VxE4AykPFWHY0Tw12ZiljbPnn5BhZ+hlSaRqCPJj1i1NLI+76Oynt5rdsnkiAl7dq7UdKV4GrDK/VL8nBxehv6/uo93GCSQJEjk37SJmm3nGeunhsG38BKAciwTaTH8587/EUzVQeyz3VG8Bqo4pXlabgRStg3IHr7GhDX4/cek9jQRorjdKrUjKywtupYAfbxH2NfbcWOlag0r4C3yo0mhp/0T5VniBzGgP1bVihHyXcO/1Auvrwlh/o5jxFewJdm8s08Ip0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8028.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(5023799004)(56012099006)(11063799006)(4143699003)(10067099003)(3023799007)(6133799003)(38070700021)(18002099003)(22082099003)(17002099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HYfindALUdk7IVk5FaY3hQ5UljmcKh6iJqslHM0xtJKtEEMkysCTgyWyFAee?=
 =?us-ascii?Q?7W6lEJnx3cwCzm3VnNlVpXUbCRcOWXri7XCvrtjhAv+M6nQbeSPfgZ8mYyHY?=
 =?us-ascii?Q?xaMoYpqmriIDm7AnhYRI4qKEF+BKlIhVpoBP8TeADeJdE+krOCfZc63kDq0m?=
 =?us-ascii?Q?Cq/kA1T2etro6ViUqQNn7J5zt38Saxj9EaLmUrUNmqVcC3uWRXlYailgywS+?=
 =?us-ascii?Q?pfUphhXmArFq5fMEiuMA9L5xqXpNm+0lCFkV68S2ONk81EHHElXIDFrM1X1U?=
 =?us-ascii?Q?mEK/qW8CsspybMBaV2Ex1lqFQEQ6icqQFI5hv+DKfwS2YdEydMZ0M8YqGJGZ?=
 =?us-ascii?Q?0uqDeIeSOXjzjoNhTjnG1ReD3MXGhxPjaPdAPxzJnJ64L+H9BqC/ssrSBulr?=
 =?us-ascii?Q?5jliijhhban3jOObckEv0RGdFh2N0FmO7oIGKhyXOVMOPl+eMqfUA/3GToa2?=
 =?us-ascii?Q?BRqJXuLlwycRLgnSx3mz7afaW7m3MxmmUcm0rkau4+vUEhw3y7nx1IIYvXwv?=
 =?us-ascii?Q?a4Q3aFOlnjDOXAvmk+lxtzRa2BJy0374WItOg4e4DdeA1+IUjGsuA0tNUSVT?=
 =?us-ascii?Q?2o9N88vD/UkkGRnvNwped8qyaA6mpUofs9bu/SjV8qBmipPa7+99MsR4jP4S?=
 =?us-ascii?Q?49pAXIxOYukhx8DkFkceWIk7TjRPcyEz8/QN21YoUAl5cHKd6r7PadgDkGUx?=
 =?us-ascii?Q?/3pRidQypfOcBko/kUB5x9UqfUXu3KBmMzQYuDVwNGzBHs8OOZZCvixY4kTc?=
 =?us-ascii?Q?3zIUtWs34garkfdiiXBdixZAxQ5CQr78AfhNuEn9AWODNvP9bGctcxQUPl2o?=
 =?us-ascii?Q?IglEn/XHmpdMs5XLNZrT1AvOgtEhHl0kb09LFKBogdsbJPXOI5SDm9TOcEZI?=
 =?us-ascii?Q?1BzTn+Z7hFsfKsH1qRKT/rlvLHKi/VCMFOzBSXe2jELJm8s/LjsKwi3zNUnL?=
 =?us-ascii?Q?dG0BuCTINda/wa3lwpRqGpLGcno2uV1nw1SuYAaDePB8Uw5VirgNxZZUDhmk?=
 =?us-ascii?Q?diSX5yiKmD3ksjbvDIhZUoKrOABSraIm05DbxDRdwlDaBuIuKTLSO67OxeGy?=
 =?us-ascii?Q?UrqQyIxMBFr/JtQTHW/e80elMFRTF1igjJ2Aj/Yr35gyKDmBHX4lcuaLjbwG?=
 =?us-ascii?Q?DTAe20SfdNHp+JsxY8LjsK9q2W+aj8oMg0w5sTOXXxfyXF81Hoawo39NahXP?=
 =?us-ascii?Q?ro9CxIbQ/OmF/1aZRW8q7ZR20LJxTp4g4Ly92y01KGIRg2PNMP8G7b/6C/10?=
 =?us-ascii?Q?s/NhqpT+gzkjSRUjRzQVEV2m/0jHe4IZ8+eAx3qQ1xw3yaLOnz7UuphW+gf6?=
 =?us-ascii?Q?usi1soHqS1poRpCQstklIOb96mVZD4X+E3/I8WKJN6BCbtc2q3biUyur2zqT?=
 =?us-ascii?Q?nFSiXDt18yxhQ/chmFodCvS/tPcwhK7J3Ra2EYGRudVfyejK/acS76kriH5T?=
 =?us-ascii?Q?uQ15HNOjvVuBfqplkvdhjkhlqmWrq0NZdHcj1aktM0AdjSScOX+SGLZA8E5R?=
 =?us-ascii?Q?4cqPTDGS1sOg8PMR+7HbWUGE1K9SiDamcruF1aoYF2/tXZyVb+IV0iQVe3P4?=
 =?us-ascii?Q?xXZeJuoVgDtTzw9VKR2W1QyL9cqgDNrXbRHafrE0nCq8kCsg1THbyo32pQE7?=
 =?us-ascii?Q?bN7TbESX2rLLWzvIYuv0C3ddGXDrRLcfZfPTFpaI7/7eD4BPLzgCE4UOtr22?=
 =?us-ascii?Q?vS6DtreJ8mdMOFjCvZIlo4T8J4hm1Q6XR+mVoD6mmSjxcsGE4qpyERhUQ5Co?=
 =?us-ascii?Q?zxMiXl0l/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: reihu5O0rPDUFkmOxpiIJRyaUmUt9rNBG1TaNzpuj0pyPukq1xaGyGbg5gT+FRFqYY7HOW/D8yxKAdGcsU99usJbs1L2/plu1uE3a4HXbe+pOJIaYJg8ZY2EGOIuwHUFnc6AnP4kkhVqK3FZruE7e4yI2BHAvaHM5iLAG5wtcpfdjGSfZrEAWH3jTsBi4oKyL+0DBwQVaH3a4g7KanFKbpQwIzeYKTe87UFLJUgR+Yjiox9iNJWs7ICrDQXWV2Mt0BOF9XChn18+1LMC2O1HD2EZCxxRXVDXA6fWB6I29lt/Y53UPl7zUGwmg5BrQhSzfoMyPqgcUJHNslolrCcCPQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8028.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21150c34-42cb-4d87-5984-08df20b0076a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 18:07:32.0606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bp3mN5MhRpLfWh+fKDd6sVx0tfqAAF2zmQuLhMe5ytq+03diSq8IkcinDALFAKf4pLZMBjxkjZznwrDDr1So3XBe4msFBwRTecWaz4fRPk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB514151
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Sent: Friday, October 2, 2026 1:51 AM
> To: netdev@vger.kernel.org
> Cc: bpf@vger.kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>;
> stfomichev@gmail.com; kuba@kernel.org; pabeni@redhat.com; Vyavahare,
> Tushar <tushar.vyavahare@intel.com>; kerneljasonxing@gmail.com;
> bjorn@kernel.org; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Subject: [PATCH net-next 09/13] selftests: xsk: run the RX and TX endpoin=
ts in
> separate processes
>=20
> Run the two endpoints of a test case in separate xskxceiver processes, so=
 that
> they no longer have to share a process or a host. A process binds only th=
e
> interface given with -i, takes its role from -e rx|tx and meets the other
> endpoint over a small TCP control channel (-p HOST -P PORT). The other si=
de is
> represented by a shadow ifobject that mirrors the local capabilities and =
holds
> an unattached copy of the XDP skeleton, so the shared test code keeps
> addressing both sides while only the local one is programmed.
>=20
> The pthreads, the barrier and test->fail go away. Each process calls the =
worker
> of its local ifobject directly, and the endpoints exchange three fixed-si=
ze
> messages instead:
>=20
> - READY is exchanged before each step and works as a barrier; TCP
>   ordering puts all progress of the previous step before it
> - PROGRESS carries the number of packets RX consumed, which TX
>   subtracts from its in-flight count so that it does not overrun the
>   RX UMEM
> - ABORT tells the other endpoint to stop waiting after a failure
>=20
> The TX endpoint listens and RX connects. Test selection, interface capabi=
lities
> and verdicts stay with the launcher and are not exchanged between the
> endpoints.
>=20
> For each case, test_xsk.sh starts the TX endpoint in the background, list=
ening
> on a control port on 127.0.0.1 (random unless -p is given), runs the RX
> endpoint once TX listens and prints the TX log when TX fails or with -v.
>=20
> Assisted-by: LLM
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  tools/testing/selftests/net/lib/Makefile      |   2 +-
>  .../testing/selftests/net/lib/xsk/test_xsk.c  | 199 +++++++------
> .../testing/selftests/net/lib/xsk/test_xsk.h  |  23 +-
> .../testing/selftests/net/lib/xsk/xsk_peer.c  | 267 ++++++++++++++++++
> .../testing/selftests/net/lib/xsk/xsk_peer.h  |  18 ++
>  .../selftests/net/lib/xsk/xskxceiver.c        | 121 ++++++--
>  tools/testing/selftests/net/test_xsk.sh       |  49 ++--
>  tools/testing/selftests/net/xsk_prereqs.sh    |  53 +++-
>  8 files changed, 594 insertions(+), 138 deletions(-)  create mode 100644
> tools/testing/selftests/net/lib/xsk/xsk_peer.c
>  create mode 100644 tools/testing/selftests/net/lib/xsk/xsk_peer.h
>=20
> diff --git a/tools/testing/selftests/net/lib/Makefile
> b/tools/testing/selftests/net/lib/Makefile
> index 4f220748fad6..cdc7469068da 100644
> --- a/tools/testing/selftests/net/lib/Makefile
> +++ b/tools/testing/selftests/net/lib/Makefile
> @@ -36,7 +36,7 @@ include ../bpf.mk
>  XSK_DIR :=3D xsk
>  XSK_BPF_OBJ :=3D $(OUTPUT)/xsk_xdp_progs.bpf.o  XSK_SKEL :=3D
> $(OUTPUT)/xsk_xdp_progs.skel.h -XSK_SOURCES :=3D $(addprefix
> $(XSK_DIR)/,xskxceiver.c xsk.c test_xsk.c) \
> +XSK_SOURCES :=3D $(addprefix $(XSK_DIR)/,xskxceiver.c xsk.c test_xsk.c
> +xsk_peer.c) \
>  	$(top_srcdir)/tools/lib/find_bit.c
>  XSK_HEADERS :=3D $(wildcard $(XSK_DIR)/*.h)
>=20
> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> index eb91d74a9f94..b6cfdefb7a18 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> @@ -7,7 +7,6 @@
>  #include <linux/mman.h>
>  #include <linux/netdev.h>
>  #include <poll.h>
> -#include <pthread.h>
>  #include <string.h>
>  #include <sys/mman.h>
>  #include <sys/socket.h>
> @@ -15,6 +14,7 @@
>  #include <unistd.h>
>=20
>  #include "test_xsk.h"
> +#include "xsk_peer.h"
>  #include "xsk_xdp_common.h"
>  #include "xsk_xdp_progs.skel.h"
>=20
> @@ -38,10 +38,37 @@
>  static const u8 g_mac[ETH_ALEN] =3D {0x55, 0x44, 0x33, 0x22, 0x11, 0x00}=
;
>=20
>  bool opt_verbose;
> -pthread_barrier_t barr;
> -pthread_mutex_t pacing_mutex =3D PTHREAD_MUTEX_INITIALIZER;
>=20
>  int pkts_in_flight;
> +static struct xsk_peer *ctrl_peer;
> +
> +void xsk_set_endpoint(struct xsk_peer *peer) {
> +	ctrl_peer =3D peer;
> +}
> +
> +static int pacing_rx_progress(u32 pkts) {
> +	int err =3D xsk_peer_rx_progress(ctrl_peer, pkts);
> +
> +	if (err)
> +		ksft_print_msg("RX control channel failed: %d (%s)\n", err,
> +			       strerror(-err));
> +	return err;
> +}
> +
> +static int pacing_tx_sync(void)
> +{
> +	int acked =3D xsk_peer_tx_sync(ctrl_peer);
> +
> +	if (acked < 0) {
> +		ksft_print_msg("TX control channel failed: %d (%s)\n", acked,
> +			       strerror(-acked));
> +		return acked;
> +	}
> +	pkts_in_flight -=3D acked;
> +	return 0;
> +}
>=20
>  /* The payload is a word consisting of a packet sequence number in the u=
pper
>   * 16-bits and a intra packet data sequence number in the lower 16 bits.=
 So
> the 3rd packet's @@ -244,7 +271,8 @@ static void __test_spec_init(struct
> test_spec *test, struct ifobject *ifobj_tx,
>  		ifobj->xsk->umem->frame_size =3D
> XSK_UMEM__DEFAULT_FRAME_SIZE;
>  	}
>=20
> -	if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING))
> +	if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING) &&
> +	    ifobj_is_local(ifobj_tx))
>  		hw_ring_size_reset(ifobj_tx);
>=20
>  	test->ifobj_tx =3D ifobj_tx;
> @@ -252,7 +280,6 @@ static void __test_spec_init(struct test_spec *test,
> struct ifobject *ifobj_tx,
>  	test->current_step =3D 0;
>  	test->total_steps =3D 1;
>  	test->nb_sockets =3D 1;
> -	test->fail =3D false;
>  	test->set_ring =3D false;
>  	test->adjust_tail =3D false;
>  	test->adjust_tail_support =3D false;
> @@ -320,26 +347,31 @@ static void test_spec_set_xdp_prog(struct
> test_spec *test, struct bpf_program *x
>  	test->xskmap_tx =3D xskmap_tx;
>  }
>=20
> -static int test_spec_set_mtu(struct test_spec *test, int mtu)
> +static int test_spec_set_mtu_ifobj(struct ifobject *ifobj, int mtu)
>  {
>  	int err;
>=20
> -	if (test->ifobj_rx->mtu !=3D mtu) {
> -		err =3D xsk_set_mtu(test->ifobj_rx->ifindex, mtu);
> +	if (ifobj_is_local(ifobj) && ifobj->mtu !=3D mtu) {
> +		err =3D xsk_set_mtu(ifobj->ifindex, mtu);
>  		if (err)
>  			return err;
> -		test->ifobj_rx->mtu =3D mtu;
> -	}
> -	if (test->ifobj_tx->mtu !=3D mtu) {
> -		err =3D xsk_set_mtu(test->ifobj_tx->ifindex, mtu);
> -		if (err)
> -			return err;
> -		test->ifobj_tx->mtu =3D mtu;
>  	}
>=20
> +	ifobj->mtu =3D mtu;
>  	return 0;
>  }
>=20
> +static int test_spec_set_mtu(struct test_spec *test, int mtu) {
> +	int err;
> +
> +	err =3D test_spec_set_mtu_ifobj(test->ifobj_rx, mtu);
> +	if (err)
> +		return err;
> +
> +	return test_spec_set_mtu_ifobj(test->ifobj_tx, mtu); }
> +
>  void pkt_stream_reset(struct pkt_stream *pkt_stream)  {
>  	if (pkt_stream) {
> @@ -989,6 +1021,9 @@ static int __receive_pkts(struct test_spec *test,
> struct xsk_socket_info *xsk)
>  	fds.fd =3D xsk_socket__fd(xsk->xsk);
>  	fds.events =3D POLLIN;
>=20
> +	if (pacing_rx_progress(0))
> +		return TEST_FAILURE;
> +
>  	ret =3D kick_rx(xsk);
>  	if (ret)
>  		return TEST_FAILURE;
> @@ -1088,9 +1123,8 @@ static int __receive_pkts(struct test_spec *test,
> struct xsk_socket_info *xsk)
>  	if (ifobj->release_rx)
>  		xsk_ring_cons__release(&xsk->rx, frags_processed);
>=20
> -	pthread_mutex_lock(&pacing_mutex);
> -	pkts_in_flight -=3D pkts_sent;
> -	pthread_mutex_unlock(&pacing_mutex);
> +	if (pacing_rx_progress(pkts_sent))
> +		return TEST_FAILURE;
>  	pkts_sent =3D 0;
>=20
>  	return TEST_CONTINUE;
> @@ -1166,6 +1200,9 @@ static int __send_pkts(struct ifobject *ifobject,
> struct xsk_socket_info *xsk,
>  	int ret;
>=20
>  	buffer_len =3D pkt_get_buffer_len(umem, pkt_stream->max_pkt_len);
> +	if (pacing_tx_sync())
> +		return TEST_FAILURE;
> +
>  	/* pkts_in_flight might be negative if many invalid packets are sent */
>  	if (pkts_in_flight >=3D (int)((umem_size(umem) - xsk->batch_size *
> buffer_len) /
>  	    buffer_len) && !test_timeout) {
> @@ -1250,9 +1287,7 @@ static int __send_pkts(struct ifobject *ifobject,
> struct xsk_socket_info *xsk,
>  		valid_frags +=3D nb_frags;
>  	}
>=20
> -	pthread_mutex_lock(&pacing_mutex);
>  	pkts_in_flight +=3D valid_pkts;
> -	pthread_mutex_unlock(&pacing_mutex);
>=20
>  	xsk_ring_prod__submit(&xsk->tx, i);
>  	xsk->outstanding_tx +=3D valid_frags;
> @@ -1329,9 +1364,6 @@ static int send_pkts(struct test_spec *test, struct
> ifobject *ifobject)
>  			if (ret !=3D TEST_CONTINUE)
>  				return ret;
>=20
> -			if (test->fail)
> -				return TEST_FAILURE;
> -
>  			if (!test->poll_tmout) {
>  				ret =3D wait_for_tx_completion(&ifobject-
> >xsk_arr[i]);
>  				if (ret)
> @@ -1653,36 +1685,57 @@ static int testapp_validate_rx_endpoint(struct
> test_spec *test,
>  	return err;
>  }
>=20
> -void *worker_testapp_validate_tx(void *arg)
> +static int sync_endpoints(struct test_spec *test) {
> +	int err =3D xsk_peer_ready(ctrl_peer);
> +
> +	if (err)
> +		ksft_print_msg("Endpoint synchronization failed at step %u:
> %d (%s)\n",
> +			       test->current_step, err, strerror(-err));
> +	return err;
> +}
> +
> +int worker_testapp_validate_tx(struct test_spec *test)
>  {
> -	struct test_spec *test =3D (struct test_spec *)arg;
>  	int err;
>=20
> -	err =3D testapp_validate_tx_endpoint(test, test->ifobj_tx);
> +	err =3D sync_endpoints(test);
>  	if (err)
> -		test->fail =3D true;
> +		return err;
>=20
> -	pthread_exit(NULL);
> +	err =3D testapp_validate_tx_endpoint(test, test->ifobj_tx);
> +	if (err) {
> +		ksft_print_msg("TX endpoint traffic failed at step %u: %d\n",
> +			       test->current_step, err);
> +		xsk_peer_abort(ctrl_peer);
> +	}
> +	return err;
>  }
>=20
> -void *worker_testapp_validate_rx(void *arg)
> +int worker_testapp_validate_rx(struct test_spec *test)
>  {
> -	struct test_spec *test =3D (struct test_spec *)arg;
>  	struct ifobject *ifobject =3D test->ifobj_rx;
>  	int err;
>=20
>  	err =3D testapp_prepare_rx_endpoint(test, ifobject);
> +	if (err) {
> +		ksft_print_msg("RX endpoint setup failed at step %u: %d\n",
> +			       test->current_step, err);
> +		xsk_peer_abort(ctrl_peer);
> +		return err;
> +	}
>=20
> -	if (test->use_barrier)
> -		pthread_barrier_wait(&barr);
> -
> -	/* We leave only now in case of error to avoid getting stuck in the
> barrier */
> -	if (!err)
> -		err =3D testapp_validate_rx_endpoint(test, ifobject);
> +	err =3D sync_endpoints(test);
>  	if (err)
> -		test->fail =3D true;
> +		return err;
>=20
> -	pthread_exit(NULL);
> +	err =3D testapp_validate_rx_endpoint(test, ifobject);
> +	if (err) {
> +		ksft_print_msg("RX endpoint traffic failed at step %u: %d\n",
> +			       test->current_step, err);
> +		xsk_peer_abort(ctrl_peer);
> +	}
> +	return err;
>  }
>=20
>  static void testapp_clean_xsk_umem(struct ifobject *ifobj) @@ -1737,13
> +1790,13 @@ static int xsk_attach_xdp_progs(struct test_spec *test, struc=
t
> ifobject *ifobj_r  {
>  	int err =3D 0;
>=20
> -	if (xdp_prog_changed_rx(test)) {
> +	if (ifobj_is_local(ifobj_rx) && xdp_prog_changed_rx(test)) {
>  		err =3D xsk_reattach_xdp(ifobj_rx, test->xdp_prog_rx, test-
> >xskmap_rx, test->mode);
>  		if (err)
>  			return err;
>  	}
>=20
> -	if (!ifobj_tx)
> +	if (!ifobj_tx || !ifobj_is_local(ifobj_tx))
>  		return 0;
>=20
>  	if (xdp_prog_changed_tx(test))
> @@ -1756,7 +1809,7 @@ static void clean_sockets(struct test_spec *test,
> struct ifobject *ifobj)  {
>  	u32 i;
>=20
> -	if (!ifobj || !test)
> +	if (!ifobj || !test || !ifobj_is_local(ifobj))
>  		return;
>=20
>  	for (i =3D 0; i < test->nb_sockets; i++) @@ -1768,15 +1821,15 @@ static
> void clean_umem(struct test_spec *test, struct ifobject *ifobj1, struct i
>  	if (!ifobj1)
>  		return;
>=20
> -	testapp_clean_xsk_umem(ifobj1);
> -	if (ifobj2)
> +	if (ifobj_is_local(ifobj1))
> +		testapp_clean_xsk_umem(ifobj1);
> +	if (ifobj2 && ifobj_is_local(ifobj2))
>  		testapp_clean_xsk_umem(ifobj2);
>  }
>=20
>  static int __testapp_validate_traffic(struct test_spec *test, struct ifo=
bject
> *ifobj1,
>  				      struct ifobject *ifobj2)
>  {
> -	pthread_t t0, t1;
>  	u32 mbuf_cap;
>  	int err;
>=20
> @@ -1806,51 +1859,27 @@ static int __testapp_validate_traffic(struct
> test_spec *test, struct ifobject *i
>  			       err, strerror(-err));
>  		return TEST_FAILURE;
>  	}
> -	test->use_barrier =3D !!ifobj2;
> -
> -	if (test->use_barrier) {
> -		if (pthread_barrier_init(&barr, NULL, 2))
> -			return TEST_FAILURE;
>=20
> +	if (ifobj2)
>  		pkt_stream_reset(ifobj2->xsk->pkt_stream);
> -	}
> -
>  	test->current_step++;
>  	pkt_stream_reset(ifobj1->xsk->pkt_stream);
>  	pkts_in_flight =3D 0;
>=20
> -	/*Spawn RX thread */
> -	pthread_create(&t0, NULL, ifobj1->func_ptr, test);
> -
> -	if (test->use_barrier) {
> -		pthread_barrier_wait(&barr);
> -		if (pthread_barrier_destroy(&barr)) {
> -			test->use_barrier =3D false;
> -			pthread_join(t0, NULL);
> -			clean_sockets(test, ifobj1);
> -			clean_umem(test, ifobj1, NULL);
> -			return TEST_FAILURE;
> -		}
> -	}
> -
> -	if (ifobj2) {
> -		/*Spawn TX thread */
> -		pthread_create(&t1, NULL, ifobj2->func_ptr, test);
> -		pthread_join(t1, NULL);
> -	}
> -
> -	pthread_join(t0, NULL);
> -
> -	if (test->total_steps =3D=3D test->current_step || test->fail) {
> +	/* In a one-sided step, the idle endpoint only keeps in step. */
> +	if (ifobj_is_local(ifobj1))
> +		err =3D ifobj1->func_ptr(test);
> +	else if (ifobj2 && ifobj_is_local(ifobj2))
> +		err =3D ifobj2->func_ptr(test);
> +	else
> +		err =3D sync_endpoints(test);
> +	if (test->total_steps =3D=3D test->current_step || err) {
>  		clean_sockets(test, ifobj1);
>  		clean_sockets(test, ifobj2);
>  		clean_umem(test, ifobj1, ifobj2);
>  	}
>=20
> -	if (test->fail)
> -		return TEST_FAILURE;
> -
> -	return TEST_PASS;
> +	return err ? TEST_FAILURE : TEST_PASS;
>  }
>=20
>  static int testapp_validate_traffic(struct test_spec *test) @@ -1866,7
> +1895,8 @@ static int testapp_validate_traffic(struct test_spec *test)
>=20
>  	if (test->set_ring) {
>  		if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING)) {
> -			if (set_ring_size(ifobj_tx)) {
> +			if (ifobj_is_local(ifobj_tx) &&
> +			    set_ring_size(ifobj_tx)) {
>  				ksft_print_msg("Failed to change HW ring
> size.\n");
>  				return TEST_FAILURE;
>  			}
> @@ -1899,7 +1929,7 @@ int testapp_teardown(struct test_spec *test)
>=20
>  static void swap_directions(struct ifobject **ifobj1, struct ifobject **=
ifobj2)  {
> -	thread_func_t tmp_func_ptr =3D (*ifobj1)->func_ptr;
> +	test_func_t tmp_func_ptr =3D (*ifobj1)->func_ptr;
>  	struct ifobject *tmp_ifobj =3D (*ifobj1);
>=20
>  	(*ifobj1)->func_ptr =3D (*ifobj2)->func_ptr; @@ -1938,6 +1968,9 @@
> static int swap_xsk_resources(struct test_spec *test)
>  	test->ifobj_tx->xsk =3D &test->ifobj_tx->xsk_arr[1];
>  	test->ifobj_rx->xsk =3D &test->ifobj_rx->xsk_arr[1];
>=20
> +	if (!ifobj_is_local(test->ifobj_rx))
> +		return TEST_PASS;
> +
>  	ret =3D xsk_update_xskmap(test->ifobj_rx->xskmap, test->ifobj_rx->xsk-
> >xsk, 0);
>  	if (ret)
>  		return TEST_FAILURE;
> @@ -2286,7 +2319,7 @@ int testapp_too_many_frags(struct test_spec
> *test)
>  	return ret;
>  }
>=20
> -static int xsk_load_xdp_programs(struct ifobject *ifobj)
> +int xsk_load_xdp_programs(struct ifobject *ifobj)
>  {
>  	ifobj->xdp_progs =3D xsk_xdp_progs__open_and_load();
>  	if (libbpf_get_error(ifobj->xdp_progs))
> @@ -2344,12 +2377,10 @@ static int detect_ifobj_caps(struct ifobject *ifo=
bj)
>  	return 0;
>  }
>=20
> -int init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
> +int init_iface(struct ifobject *ifobj)
>  {
>  	int err;
>=20
> -	ifobj->func_ptr =3D func_ptr;
> -
>  	err =3D xsk_load_xdp_programs(ifobj);
>  	if (err) {
>  		ksft_print_msg("Error loading XDP program\n"); diff --git
> a/tools/testing/selftests/net/lib/xsk/test_xsk.h
> b/tools/testing/selftests/net/lib/xsk/test_xsk.h
> index 861a2ee3b8e1..53e5032510a0 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
> @@ -77,9 +77,13 @@ enum test_mode {
>  struct ifobject;
>  struct test_spec;
>  typedef int (*validation_func_t)(struct ifobject *ifobj); -typedef void
> *(*thread_func_t)(void *arg);  typedef int (*test_func_t)(struct test_spe=
c
> *test);
>=20
> +struct xsk_peer;
> +
> +/* The control channel to the other endpoint. */ void
> +xsk_set_endpoint(struct xsk_peer *peer);
> +
>  struct xsk_socket_info {
>  	struct xsk_ring_cons rx;
>  	struct xsk_ring_prod tx;
> @@ -139,7 +143,7 @@ struct ifobject {
>  	struct xsk_caps caps;
>  	struct xsk_socket_info *xsk;
>  	struct xsk_socket_info *xsk_arr;
> -	thread_func_t func_ptr;
> +	test_func_t func_ptr;
>  	validation_func_t validation_func;
>  	struct xsk_xdp_progs *xdp_progs;
>  	struct bpf_map *xskmap;
> @@ -169,11 +173,18 @@ static inline void ifobj_set_cap(struct ifobject
> *ifobj, u32 cap)
>  	ifobj->caps.flags |=3D cap;
>  }
>=20
> +/* The shadow of the peer's ifobject is never bound to an interface. */
> +static inline bool ifobj_is_local(const struct ifobject *ifobj) {
> +	return ifobj->ifindex;
> +}
> +
>  #define xsk_get_cap(test, cap) ((test)->ifobj_tx->caps.cap)
>=20
>  struct ifobject *ifobject_create(void);  void ifobject_delete(struct ifo=
bject
> *ifobj); -int init_iface(struct ifobject *ifobj, thread_func_t func_ptr);
> +int init_iface(struct ifobject *ifobj); int
> +xsk_load_xdp_programs(struct ifobject *ifobj);
>=20
>  int xsk_configure_umem(struct ifobject *ifobj, struct xsk_umem_info *ume=
m,
> void *buffer, u64 size);  int xsk_configure_socket(struct xsk_socket_info=
 *xsk,
> struct xsk_umem_info *umem, @@ -222,12 +233,10 @@ struct test_spec {
>  	u16 total_steps;
>  	u16 current_step;
>  	u16 nb_sockets;
> -	bool fail;
>  	bool set_ring;
>  	bool adjust_tail;
>  	bool adjust_tail_support;
>  	bool poll_tmout;
> -	bool use_barrier;
>  	enum test_mode mode;
>  	char name[MAX_TEST_NAME_SIZE];
>  };
> @@ -288,8 +297,8 @@ int testapp_xdp_metadata_mb(struct test_spec
> *test);  int testapp_xdp_prog_cleanup(struct test_spec *test);  int
> testapp_xdp_shared_umem(struct test_spec *test);
>=20
> -void *worker_testapp_validate_rx(void *arg); -void
> *worker_testapp_validate_tx(void *arg);
> +int worker_testapp_validate_rx(struct test_spec *test); int
> +worker_testapp_validate_tx(struct test_spec *test);
>=20
>  static const struct test_spec tests[] =3D {
>  	{.name =3D "SEND_RECEIVE", .test_func =3D testapp_send_receive}, diff -=
-
> git a/tools/testing/selftests/net/lib/xsk/xsk_peer.c
> b/tools/testing/selftests/net/lib/xsk/xsk_peer.c
> new file mode 100644
> index 000000000000..4cc5f3542e55
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/xsk/xsk_peer.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <arpa/inet.h>
> +#include <errno.h>
> +#include <netdb.h>
> +#include <netinet/tcp.h>
> +#include <poll.h>
> +#include <stdlib.h>
> +#include <sys/socket.h>
> +#include <unistd.h>
> +
> +#include "xsk_peer.h"
> +
> +#define XSK_PEER_MAGIC			0x58534b50
> +#define XSK_PEER_ACCEPT_TMOUT_MS	30000
> +
> +/* One case per connection; the launcher owns the verdict. */ enum
> +xsk_peer_msg_type {
> +	XSK_PEER_READY =3D 1,
> +	XSK_PEER_PROGRESS,
> +	XSK_PEER_ABORT,
> +};
> +
> +struct xsk_peer_msg {
> +	u32 magic;
> +	u32 type;
> +	u32 pkts;
> +};
> +
> +struct xsk_peer {
> +	int fd;
> +	u32 acked;
> +	bool ready_seen;
> +	bool closed;
> +};
> +
> +static int io_full(int fd, void *buf, size_t len, bool write_op) {
> +	size_t done =3D 0;
> +	ssize_t ret;
> +
> +	while (done < len) {
> +		if (write_op)
> +			ret =3D send(fd, (char *)buf + done, len - done,
> MSG_NOSIGNAL);
> +		else
> +			ret =3D read(fd, (char *)buf + done, len - done);
> +		if (ret < 0 && errno =3D=3D EINTR)
> +			continue;
> +		if (ret < 0)
> +			return -errno;
> +		if (!ret)
> +			return -EPIPE;
> +		done +=3D ret;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Past its last barrier the peer may exit at any time, and it resets
> +the
> + * connection if our progress reports are still unread.
> + */
> +static bool peer_gone(int err)
> +{
> +	return err =3D=3D -EPIPE || err =3D=3D -ECONNRESET; }
> +
> +static int peer_send(struct xsk_peer *peer, u32 type, u32 pkts) {
> +	struct xsk_peer_msg msg =3D {
> +		.magic =3D htonl(XSK_PEER_MAGIC),
> +		.type =3D htonl(type),
> +		.pkts =3D htonl(pkts),
> +	};
> +
> +	return io_full(peer->fd, &msg, sizeof(msg), true); }
> +
> +static int peer_recv_one(struct xsk_peer *peer) {
> +	struct xsk_peer_msg msg;
> +	int err;
> +
> +	err =3D io_full(peer->fd, &msg, sizeof(msg), false);
> +	if (peer_gone(err))
> +		peer->closed =3D true;
> +	if (err)
> +		return err;
> +	if (ntohl(msg.magic) !=3D XSK_PEER_MAGIC)
> +		return -EPROTO;
> +
> +	switch (ntohl(msg.type)) {
> +	case XSK_PEER_READY:
> +		/* The peer waits for our READY, so it is at most one step
> ahead. */
> +		if (peer->ready_seen)
> +			return -EPROTO;
> +		peer->ready_seen =3D true;
> +		return 0;
> +	case XSK_PEER_PROGRESS:
> +		peer->acked +=3D ntohl(msg.pkts);
> +		return 0;
> +	case XSK_PEER_ABORT:
> +		return -ECANCELED;
> +	default:
> +		return -EPROTO;
> +	}
> +}
> +
> +/* Consume what the peer has sent so far without blocking. */ static
> +int peer_drain(struct xsk_peer *peer) {
> +	struct pollfd pfd =3D { .fd =3D peer->fd, .events =3D POLLIN };
> +	int ret;
> +
> +	while (!peer->closed) {
> +		ret =3D poll(&pfd, 1, 0);
> +		if (ret < 0 && errno =3D=3D EINTR)
> +			continue;
> +		if (ret < 0)
> +			return -errno;
> +		if (!ret)
> +			break;
> +		ret =3D peer_recv_one(peer);
> +		if (ret && !peer->closed)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +/* Return once both endpoints are set up for the next step. */ int
> +xsk_peer_ready(struct xsk_peer *peer) {
> +	int err;
> +
> +	err =3D peer_send(peer, XSK_PEER_READY, 0);
> +	while (!err && !peer->ready_seen)
> +		err =3D peer_recv_one(peer);
> +	if (err)
> +		return err;
> +
> +	/* TCP ordering puts all progress of the previous step before READY. */
> +	peer->ready_seen =3D false;
> +	peer->acked =3D 0;
> +	return 0;
> +}
> +
> +void xsk_peer_abort(struct xsk_peer *peer) {
> +	if (peer && !peer->closed)
> +		peer_send(peer, XSK_PEER_ABORT, 0);
> +}
> +
> +int xsk_peer_rx_progress(struct xsk_peer *peer, u32 pkts) {
> +	int err;
> +
> +	if (pkts && !peer->closed) {
> +		err =3D peer_send(peer, XSK_PEER_PROGRESS, pkts);
> +		if (peer_gone(err))
> +			peer->closed =3D true;
> +		else if (err)
> +			return err;
> +	}
> +	return peer_drain(peer);
> +}
> +
> +/* Return the packets RX reported consumed since the last call, or
> +-errno. */ int xsk_peer_tx_sync(struct xsk_peer *peer) {
> +	int err =3D peer_drain(peer);
> +	u32 acked =3D peer->acked;
> +
> +	if (err)
> +		return err;
> +	peer->acked =3D 0;
> +	return acked;
> +}
> +
> +static int accept_tmout(int lfd)
> +{
> +	struct pollfd pfd =3D { .fd =3D lfd, .events =3D POLLIN };
> +	int ret;
> +
> +	do {
> +		ret =3D poll(&pfd, 1, XSK_PEER_ACCEPT_TMOUT_MS);
> +	} while (ret < 0 && errno =3D=3D EINTR);
> +	if (!ret)
> +		errno =3D ETIMEDOUT;
> +	return ret > 0 ? accept(lfd, NULL, NULL) : -1; }
> +
> +/*
> + * The launcher starts the listener and waits for its port before
> +starting
> + * the connector, so connect() needs no retry. accept() is bounded in
> +case
> + * the connector exits before it gets that far.
> + */
> +static int peer_open_tcp(const char *host, const char *port, bool
> +listen_side) {
> +	struct addrinfo hints =3D { .ai_family =3D AF_UNSPEC, .ai_socktype =3D
> SOCK_STREAM };
> +	int fd =3D -1, lfd, saved =3D ECONNREFUSED, one =3D 1, err;
> +	struct addrinfo *res, *ai;
> +
> +	err =3D getaddrinfo(host, port, &hints, &res);
> +	if (err)
> +		return -EINVAL;
> +
> +	if (!listen_side)
> +		goto conn;
> +
> +	for (ai =3D res; ai; ai =3D ai->ai_next) {
> +		lfd =3D socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> +		if (lfd < 0)
> +			continue;
> +		setsockopt(lfd, SOL_SOCKET, SO_REUSEADDR, &one,
> sizeof(one));
> +		if (!bind(lfd, ai->ai_addr, ai->ai_addrlen) && !listen(lfd, 1)) {
> +			fd =3D accept_tmout(lfd);
> +			saved =3D errno;
> +			close(lfd);
> +			break;
> +		}
> +		saved =3D errno;
> +		close(lfd);
> +	}
> +	freeaddrinfo(res);
> +	return fd >=3D 0 ? fd : -saved;
> +
> +conn:
> +	for (ai =3D res; ai; ai =3D ai->ai_next) {
> +		fd =3D socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> +		if (fd < 0)
> +			continue;
> +		if (!connect(fd, ai->ai_addr, ai->ai_addrlen))
> +			break;
> +		saved =3D errno;
> +		close(fd);
> +		fd =3D -1;
> +	}
> +	freeaddrinfo(res);
> +	return fd >=3D 0 ? fd : -saved;
> +}
> +
> +struct xsk_peer *xsk_peer_open(const char *host, const char *port,
> +			       bool listen_side)
> +{
> +	int fd =3D peer_open_tcp(host, port, listen_side);
> +	struct xsk_peer *peer;
> +	int one =3D 1;
> +
> +	if (fd < 0) {
> +		errno =3D -fd;
> +		return NULL;
> +	}
> +	peer =3D calloc(1, sizeof(*peer));
> +	if (!peer) {
> +		close(fd);
> +		return NULL;
> +	}
> +	peer->fd =3D fd;
> +	setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof(one));
> +	return peer;
> +}
> +
> +void xsk_peer_close(struct xsk_peer *peer) {
> +	if (peer) {
> +		close(peer->fd);
> +		free(peer);
> +	}
> +}
> diff --git a/tools/testing/selftests/net/lib/xsk/xsk_peer.h
> b/tools/testing/selftests/net/lib/xsk/xsk_peer.h
> new file mode 100644
> index 000000000000..1e61078baea2
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/xsk/xsk_peer.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef XSK_PEER_H_
> +#define XSK_PEER_H_
> +
> +#include <linux/types.h>
> +
> +struct xsk_peer;
> +
> +struct xsk_peer *xsk_peer_open(const char *host, const char *port,
> +			       bool listen_side);
> +void xsk_peer_close(struct xsk_peer *peer);
> +
> +int xsk_peer_ready(struct xsk_peer *peer); void xsk_peer_abort(struct
> +xsk_peer *peer); int xsk_peer_rx_progress(struct xsk_peer *peer, u32
> +pkts); int xsk_peer_tx_sync(struct xsk_peer *peer);
> +
> +#endif /* XSK_PEER_H_ */
> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> index b8a52846eaf8..e66625810a9d 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> @@ -9,9 +9,9 @@
>   * See test_xsk.sh for detailed information on test topology
>   * and prerequisite network setup.
>   *
> - * This test program contains two threads, each thread is single socket =
with
> - * a unique UMEM. It validates in-order packet delivery and packet conte=
nt
> - * by sending packets to each other.
> + * Each instance of this test program runs one endpoint, Tx or Rx, with
> + a
> + * single socket and a unique UMEM. Two instances validate in-order
> + packet
> + * delivery and packet content by sending packets to each other.
>   *
>   * Tests Information:
>   * ------------------
> @@ -57,12 +57,14 @@
>   *
>   * Flow:
>   * -----
> - * - Single process spawns two threads: Tx and Rx
> - * - Each of these two threads attach to a veth interface
> - * - Each thread creates one AF_XDP socket connected to a unique umem fo=
r
> each
> + * - test_xsk.sh starts two processes: Tx and Rx
> + * - Each of these two processes attach to a veth interface
> + * - Each process creates one AF_XDP socket connected to a unique umem
> + for each
>   *   veth interface
> - * - Tx thread Transmits a number of packets from veth<xxxx> to veth<yyy=
y>
> - * - Rx thread verifies if all packets were received and delivered in-or=
der,
> + * - Tx process listens on a TCP control port, Rx process connects to it=
 and
> + *   the two synchronize each test step over that connection
> + * - Tx process Transmits a number of packets from veth<xxxx> to
> + veth<yyyy>
> + * - Rx process verifies if all packets were received and delivered
> + in-order,
>   *   and have the right content
>   *
>   * Enable/disable packet dump mode:
> @@ -92,6 +94,7 @@
>  #include <sys/types.h>
>=20
>  #include "test_xsk.h"
> +#include "xsk_peer.h"
>  #include "xsk_xdp_progs.skel.h"
>  #include "xsk.h"
>  #include "xskxceiver.h"
> @@ -100,8 +103,18 @@
>  #include "kselftest.h"
>  #include "xsk_xdp_common.h"
>=20
> +enum xsk_endpoint_role {
> +	XSK_ENDPOINT_NONE,
> +	XSK_ENDPOINT_RX,
> +	XSK_ENDPOINT_TX,
> +};
> +
>  static enum test_mode opt_mode =3D TEST_MODE_ALL;  static u32
> opt_run_test =3D RUN_ALL_TESTS;
> +static enum xsk_endpoint_role opt_endpoint_role =3D XSK_ENDPOINT_NONE;
> +static const char *opt_peer_host; static const char *opt_peer_port;
> +static const char *opt_ifname;
>=20
>  static void __exit_with_error(int error, const char *file, const char *f=
unc, int
> line)  { @@ -162,6 +175,9 @@ static struct option long_options[] =3D {
>  	{"mode", required_argument, 0, 'm'},
>  	{"list", no_argument, 0, 'l'},
>  	{"test", required_argument, 0, 't'},
> +	{"endpoint", required_argument, 0, 'e'},
> +	{"peer", required_argument, 0, 'p'},
> +	{"peer-port", required_argument, 0, 'P'},
>  	{"help", no_argument, 0, 'h'},
>  	{0, 0, 0, 0}
>  };
> @@ -169,7 +185,7 @@ static struct option long_options[] =3D {  static voi=
d
> print_usage(char **argv)  {
>  	const char *str =3D
> -		"  Usage: xskxceiver -i TX_IFACE -i RX_IFACE -m MODE -t TEST
> [OPTIONS]\n"
> +		"  Usage: xskxceiver -i IFACE -e rx|tx -m MODE -t TEST -p HOST
> -P PORT [OPTIONS]\n"
>  		"  Options:\n"
>  		"  -i, --interface      Use interface\n"
>  		"  -v, --verbose        Verbose output\n"
> @@ -177,16 +193,18 @@ static void print_usage(char **argv)
>  		"  -m, --mode           Run only mode skb, drv, or zc\n"
>  		"  -l, --list           List all available tests\n"
>  		"  -t, --test           Run a specific test. Enter number from -l
> option.\n"
> +		"  -e, --endpoint       Role of this endpoint: rx or tx\n"
> +		"  -p, --peer           Control host: IPv4/IPv6 address or
> hostname\n"
> +		"  -P, --peer-port      Control TCP port (1-65535)\n"
>  		"  -h, --help           Display this help and exit\n";
>=20
>  	ksft_print_msg(str, basename(argv[0]));
>  	ksft_exit_xfail();
>  }
>=20
> -static void bind_iface(struct ifobject *ifobj, const char *ifname, threa=
d_func_t
> func,
> -		       char **argv)
> +static void bind_iface(struct ifobject *ifobj, const char *ifname, char
> +**argv)
>  {
> -	size_t len =3D ifname ? strlen(ifname) : 0;
> +	size_t len =3D strlen(ifname);
>=20
>  	if (!len || len >=3D sizeof(ifobj->ifname))
>  		print_usage(argv);
> @@ -198,7 +216,7 @@ static void bind_iface(struct ifobject *ifobj, const =
char
> *ifname, thread_func_t
>  		ksft_exit_fail();
>  	}
>=20
> -	if (init_iface(ifobj, func)) {
> +	if (init_iface(ifobj)) {
>  		ksft_print_msg("Error: cannot initialize interface %s\n", ifobj-
> >ifname);
>  		ksft_exit_fail();
>  	}
> @@ -216,23 +234,18 @@ static void print_tests(void)  static void
> parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx, =
int
> argc,
>  			       char **argv)
>  {
> -	const char *ifname[2] =3D {};
> -	u32 interface_nb =3D 0;
>  	int option_index, c;
>=20
>  	opterr =3D 0;
>=20
>  	for (;;) {
> -		c =3D getopt_long(argc, argv, "i:vbm:lt:", long_options,
> &option_index);
> +		c =3D getopt_long(argc, argv, "i:vbm:lt:e:p:P:", long_options,
> +&option_index);
>  		if (c =3D=3D -1)
>  			break;
>=20
>  		switch (c) {
>  		case 'i':
> -			if (interface_nb >=3D ARRAY_SIZE(ifname))
> -				break;
> -
> -			ifname[interface_nb++] =3D optarg;
> +			opt_ifname =3D optarg;
>  			break;
>  		case 'v':
>  			opt_verbose =3D true;
> @@ -261,17 +274,30 @@ static void parse_command_line(struct ifobject
> *ifobj_tx, struct ifobject *ifobj
>  			if (errno)
>  				print_usage(argv);
>  			break;
> +		case 'e':
> +			if (!strcmp(optarg, "rx"))
> +				opt_endpoint_role =3D XSK_ENDPOINT_RX;
> +			else if (!strcmp(optarg, "tx"))
> +				opt_endpoint_role =3D XSK_ENDPOINT_TX;
> +			else
> +				print_usage(argv);
> +			break;
> +		case 'p':
> +			opt_peer_host =3D optarg;
> +			break;
> +		case 'P':
> +			opt_peer_port =3D optarg;
> +			break;
>  		case 'h':
>  		default:
>  			print_usage(argv);
>  		}
>  	}
>=20
> -	if (opt_run_test =3D=3D RUN_ALL_TESTS || opt_mode =3D=3D
> TEST_MODE_ALL)
> +	if (!opt_ifname || opt_endpoint_role =3D=3D XSK_ENDPOINT_NONE ||
> !opt_peer_host ||
> +	    !*opt_peer_host || !opt_peer_port || opt_run_test =3D=3D
> RUN_ALL_TESTS ||
> +	    opt_mode =3D=3D TEST_MODE_ALL)
>  		print_usage(argv);
> -
> -	bind_iface(ifobj_tx, ifname[0], worker_testapp_validate_tx, argv);
> -	bind_iface(ifobj_rx, ifname[1], worker_testapp_validate_rx, argv);
>  }
>=20
>  static void xsk_unload_xdp_programs(struct ifobject *ifobj) @@ -357,20
> +383,49 @@ static bool mode_supported(enum test_mode mode, u32 caps)
>=20
>  static void cleanup_iface(struct ifobject *ifobj)  {
> +	/* A peer shadow has a skeleton but no bound interface. */
> +	if (!ifobj_is_local(ifobj))
> +		goto unload;
> +
>  	if (ifobj_has_cap(ifobj, XSK_CAP_HW_RING))
>  		hw_ring_size_reset(ifobj);
>  	if (ifobj->xdp_prog)
>  		xsk_detach_xdp_program(ifobj->ifindex,
>  				       ifobj->mode =3D=3D TEST_MODE_SKB ?
>  				       XDP_FLAGS_SKB_MODE :
> XDP_FLAGS_DRV_MODE);
> +unload:
>  	xsk_unload_xdp_programs(ifobj);
>  }
>=20
> +/* Connect the two endpoints without negotiating the remote NIC's
> +capabilities. */ static int setup_peer(struct ifobject *local, struct if=
object
> *shadow,
> +		      struct xsk_peer **peer)
> +{
> +	/* Unattached skeleton copy; the engine only attaches the local side.
> */
> +	if (xsk_load_xdp_programs(shadow))
> +		return TEST_FAILURE;
> +
> +	/* TX listens and RX connects. */
> +	*peer =3D xsk_peer_open(opt_peer_host, opt_peer_port,
> +			      opt_endpoint_role =3D=3D XSK_ENDPOINT_TX);
> +	if (!*peer) {
> +		ksft_print_msg("Failed to connect XSK peer: %s\n",
> strerror(errno));
> +		return TEST_FAILURE;
> +	}
> +
> +	shadow->caps =3D local->caps;

For the current veth setup this looks fine, but in hardware mode the DUT
and peer can have different capabilities (e.g. ZC vs SKB).
Is the expectation that capability-dependent test selection remains
entirely launcher-owned, without any capability exchange between the
endpoints?

> +	xsk_set_endpoint(*peer);
> +	return TEST_PASS;
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	u32 cache_line_size, max_frags, umem_tailroom;
>  	const size_t total_tests =3D ARRAY_SIZE(tests);
>  	struct ifobject *ifobj_tx, *ifobj_rx;
> +	struct ifobject *shadow_ifobj;
> +	struct ifobject *local_ifobj;
> +	struct xsk_peer *peer =3D NULL;
>  	struct test_spec test =3D {};
>  	int ret =3D TEST_FAILURE;
>  	u32 caps;
> @@ -415,12 +470,26 @@ int main(int argc, char **argv)
>  		ksft_exit_xfail();
>  	}
>=20
> +	/* swap_directions() swaps the workers, so the shadow needs one
> too. */
> +	ifobj_tx->func_ptr =3D worker_testapp_validate_tx;
> +	ifobj_rx->func_ptr =3D worker_testapp_validate_rx;
> +	if (opt_endpoint_role =3D=3D XSK_ENDPOINT_TX) {
> +		local_ifobj =3D ifobj_tx;
> +		shadow_ifobj =3D ifobj_rx;
> +	} else {
> +		local_ifobj =3D ifobj_rx;
> +		shadow_ifobj =3D ifobj_tx;
> +	}
> +	bind_iface(local_ifobj, opt_ifname, argv);
> +	caps =3D detect_mode_caps(local_ifobj);
> +
>  	test.tx_pkt_stream_default =3D
> pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
>  	test.rx_pkt_stream_default =3D
> pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
>  	if (!test.tx_pkt_stream_default || !test.rx_pkt_stream_default)
>  		goto out;
>=20
> -	caps =3D detect_mode_caps(ifobj_tx);
> +	if (setup_peer(local_ifobj, shadow_ifobj, &peer))
> +		goto out;
>=20
>  	if (!mode_supported(opt_mode, caps)) {
>  		if (opt_mode =3D=3D TEST_MODE_DRV)
> @@ -438,8 +507,10 @@ int main(int argc, char **argv)
>  	ret =3D run_pkt_test(&test);
>=20
>  out:
> +	xsk_set_endpoint(NULL);
>  	cleanup_iface(ifobj_tx);
>  	cleanup_iface(ifobj_rx);
> +	xsk_peer_close(peer);
>  	pkt_stream_delete(test.tx_pkt_stream_default);
>  	pkt_stream_delete(test.rx_pkt_stream_default);
>  	ifobject_delete(ifobj_tx);
> diff --git a/tools/testing/selftests/net/test_xsk.sh
> b/tools/testing/selftests/net/test_xsk.sh
> index e476556eb05b..2ef9ce7e1b27 100755
> --- a/tools/testing/selftests/net/test_xsk.sh
> +++ b/tools/testing/selftests/net/test_xsk.sh
> @@ -8,22 +8,20 @@
>  #
>  # Topology:
>  # ---------
> -#                 -----------
> -#               _ | Process | _
> -#              /  -----------  \
> -#             /        |        \
> -#            /         |         \
> -#      -----------     |     -----------
> -#      | Thread1 |     |     | Thread2 |
> -#      -----------     |     -----------
> -#           |          |          |
> -#      -----------     |     -----------
> -#      |  xskX   |     |     |  xskY   |
> -#      -----------     |     -----------
> -#           |          |          |
> -#      -----------     |     ----------
> -#      |  vethX  | --------- |  vethY |
> -#      -----------   peer    ----------
> +#      -----------   control    -----------
> +#      | TX proc | ------------ | RX proc |
> +#      -----------  (TCP, lo)   -----------
> +#           |                        |
> +#      -----------              -----------
> +#      |  xskX   |              |  xskY   |
> +#      -----------              -----------
> +#           |                        |
> +#      -----------              ----------
> +#      |  vethX  | ------------ |  vethY |
> +#      -----------     peer     ----------
> +#
> +# The two xskxceiver processes each drive one veth and synchronize over
> +a # TCP control connection on 127.0.0.1.
>  #
>  # AF_XDP is an address family optimized for high performance packet
> processing,  # it is XDP's user-space interface.
> @@ -71,6 +69,9 @@
>  # Set up veth interfaces and leave them up so xskxceiver can be launched=
 in a
> debugger:
>  #   sudo ./test_xsk.sh -d
>  #
> +# Use a specific TCP port for the control connection (random by default)
> +#   sudo ./test_xsk.sh -p PORT
> +#
>  # Run test suite in a specific mode only [skb,drv]
>  #   sudo ./test_xsk.sh -m MODE
>  #
> @@ -90,11 +91,15 @@ if [ ! -x "./${XSKOBJ}" ]; then
>  	exit $ksft_skip
>  fi
>=20
> -while getopts "vdm:lt:h" flag
> +PEER_HOST=3D127.0.0.1
> +PEER_PORT=3D
> +
> +while getopts "vdm:lt:p:h" flag
>  do
>  	case "${flag}" in
>  		v) verbose=3D1;;
>  		d) debug=3D1;;
> +		p) PEER_PORT=3D${OPTARG};;
>  		m) MODE=3D${OPTARG};;
>  		l) list=3D1;;
>  		t) TEST=3D${OPTARG};;
> @@ -181,6 +186,13 @@ if [ ${#CASES[@]} -eq 0 ]; then
>  	exit 1
>  fi
>=20
> +if [ -z "$PEER_PORT" ]; then
> +	PEER_PORT=3D$(random_port) || {
> +		echo "Could not find an unused TCP port" >&2
> +		exit 1
> +	}
> +fi
> +
>  validate_root_exec
>  validate_veth_support ${VETH0}
>  validate_ip_utility
> @@ -225,7 +237,8 @@ RUN_VARIANT=3DSOFTIRQ
>=20
>  if [[ $debug -eq 1 ]]; then
>      ARGS=3D"${BASE_ARGS} -m ${MODES[0]} -t ${CASES[0]}"
> -    echo "./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${ARGS}"
> +    echo "./${XSKOBJ} -i ${VETH0} -e tx -p ${PEER_HOST} -P ${PEER_PORT}
> ${ARGS}"
> +    echo "./${XSKOBJ} -i ${VETH1} -e rx -p ${PEER_HOST} -P ${PEER_PORT}
> ${ARGS}"
>      exit
>  fi
>=20
> diff --git a/tools/testing/selftests/net/xsk_prereqs.sh
> b/tools/testing/selftests/net/xsk_prereqs.sh
> index 30173db12c56..82cd7839d77d 100755
> --- a/tools/testing/selftests/net/xsk_prereqs.sh
> +++ b/tools/testing/selftests/net/xsk_prereqs.sh
> @@ -69,16 +69,63 @@ validate_ip_utility()
>  	[ ! $(type -P ip) ] && { echo "'ip' not found. Skipping tests."; test_e=
xit
> $ksft_skip; }  }
>=20
> +wait_port_listen()
> +{
> +	local i
> +
> +	for i in $(seq 50); do
> +		if [ -n "$(ss -Hltn "sport =3D :$1" 2>/dev/null)" ]; then
> +			return 0
> +		fi
> +		kill -0 $2 2>/dev/null || return 1
> +		sleep 0.1
> +	done
> +	return 1
> +}
> +
> +random_port()
> +{
> +	local i port
> +
> +	for i in $(seq 50); do
> +		port=3D$((32768 + RANDOM))
> +		if [ -z "$(ss -Hltn "sport =3D :$port" 2>/dev/null)" ]; then
> +			echo "$port"
> +			return 0
> +		fi
> +	done
> +	return 1
> +}
> +
> +# The TX endpoint listens on the control port and runs in the
> +background, # the RX endpoint connects to it and reports; both print the
> same verdicts.
>  exec_xskxceiver()
>  {
> -	local run_args=3D"${ARGS}"
> +	local tx_log tx_pid tx_ret run_args=3D"${ARGS}"
>=20
>          if [[ $busy_poll -eq 1 ]]; then
>  		run_args+=3D" -b"
>  	fi
>=20
> -	./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${run_args}
> -	retval=3D$?
> +	tx_log=3D$(mktemp)
> +	./${XSKOBJ} -i ${VETH0} -e tx -p ${PEER_HOST} -P ${PEER_PORT}
> ${run_args} > ${tx_log} 2>&1 &
> +	tx_pid=3D$!
> +
> +	if wait_port_listen ${PEER_PORT} ${tx_pid}; then
> +		./${XSKOBJ} -i ${VETH1} -e rx -p ${PEER_HOST} -P
> ${PEER_PORT} ${run_args}
> +		retval=3D$?
> +	else
> +		echo "TX endpoint did not listen on
> ${PEER_HOST}:${PEER_PORT}"
> +		retval=3D1
> +	fi
> +
> +	wait ${tx_pid}
> +	tx_ret=3D$?
> +	if [[ $tx_ret -ne 0 || $verbose -eq 1 ]]; then
> +		sed 's/^/tx| /' ${tx_log}
> +	fi
> +	rm -f ${tx_log}
> +	[[ $retval -eq 0 ]] && retval=3D$tx_ret
>=20
>  	if [[ $list -ne 1 ]]; then
>  	    test_status $retval "${TEST_NAME}"
> --
> 2.43.0

