Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752439CD18;
	Wed,  2 Sep 2026 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337172; cv=fail; b=aX7aQ+pg3Z1124p5NW+9cEl1l1MbFK1G/Spn8M4jPSDwvaiBt6GCd2+i8VQ/shRZAh+qKhD66VDlnuQr4KO9gc0IGk+5rJRmxo10jVFXZ72sWaS6c/LPTipXVkUSpADHX+D9u0FIWIKaui7xeX+U6thXFEqferGTcPl7Pt4q/58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337172; c=relaxed/simple;
	bh=3iYP/mlIwYLqULOy4kot0qE8V0vJ5tALTFIlmUOSlGM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GhLCVeP/Eodr0cz1MQfSDTu5NW1Xg1ms2+Wem7cAH6yF5Ov3YfIt0LfO73AqVZLbjqIheNlJmQcWOWV2ETk5JJNe2dlDdQih2PzAG+gTFsN1Txmg+AVT9ZmDoaarA5xXzyqP0Ox0TaJsgxv35jCByQ/9PCOtyKk58FFwI8uMcMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSFw0KFG; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSFw0KFG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788337167; x=1819873167;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=3iYP/mlIwYLqULOy4kot0qE8V0vJ5tALTFIlmUOSlGM=;
  b=VSFw0KFGSjs9VeMeobz7veWOnfiyJJt270ROdKRrOF56JbEgt+taLBfr
   JgF+Tuv81ptJJihFsRnd0UgZlMZxUOIu7rZkZlPJ95V+mT9yfSQVqHpbE
   R4tRu8FOvGVqHrG8Tn8IbrwLcOt3VqA5iXJWLS0th1Qq2L1+iBEzVoemq
   ajbzbaXuoJKi4vZbgFkO3EsJOcU+F19auaB9RIqSOuJM6ZPTUkArGpS8R
   fO6WPjwvupPm7oN+w5HQAqP4abFxjOiaD54ynbowuF3e4o9uMG8H31+V+
   J3CPmH31T7vqW5ZDlU81fS4ogz+1bHHPu2VLU6g+BcBII7YM8h0OOYT1h
   Q==;
X-CSE-ConnectionGUID: krJduEzxQfWXfbXP3/OTWQ==
X-CSE-MsgGUID: TsxKk/SqSHWp9OXJy9aE8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="91298955"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="91298955"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 01:19:26 -0700
X-CSE-ConnectionGUID: Y4JVBTBsTxmk4dmAg11uDw==
X-CSE-MsgGUID: GT6EuiJXQMuqLHs9mnOoAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="267567850"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 01:19:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:19:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:19:25 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MY2S+qW92XgXo/RtdTab/q0M3M2t2azivYAm86K1kMW2aBMOew+1L1wWP6Cbsp7ha6B7b/6gjsgf2im26LgGtMRIuT42HswcyMOPPxaO3aVc+IMyeS3wPnsYKYDyFKaoCPmDcv1INszvVr9JOUa5GRE9ksmVhFRdFNVb2H6VwrnKwU4COL83fu+yrfdJPeQ5D/GPA7K0MF2312gsj52F+dai7NDHZj87oR8ldwUlvzq/32TJHlMDWV8UOxmOKktZ7ZM7HreNqT/BgJZoJyc+FysfZMe50aXKWqXyybmPfLAd6xWYmHSZ4j4wEkQ76fIw4P2JgL5qjBdD/dhH+tII+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0j9Ac3KogicyALFgTtSoBhLCO8t/9VHAo30hbyqgxDY=;
 b=lG0MEaapln56eDQGaKdwKKyBfDzUeyATpLrOclDnawUaYoh6ha2DuTJqMGUwg4p/1lAefvqJ/pfRK+hqK5OBlKuPKoIu+9kK5yDtVsfO6ieVBey0dFWxeF1ab5+Y/kRftxQIn+02tXoJ6ngWplhjWb6HJZKk+ULjbxN6+Tf91TN4WWcM6Dqnrky0mD0OUtKqlSlpGHu05mawG5JlurxvtAF7P5dm7jWl1K9ZZ5u0WrnoL368+ekGkzRnLbTBW3TXr0OQJCTm17yTfUy9XqlioxhinRhjrmuF6wYPYKLmSIEmUE8m+j5hPv4PQENIrnYtCQ1xZJkJc47G5qXBsJuA4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Wed, 2 Sep
 2026 08:19:20 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:19:20 +0000
From: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
To: Khawar Ahemad <ahemadkhawar123@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com"
	<syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com>
Subject: RE: [PATCH bpf-next v5] xsk: Fix circular locking dependency between
 &net->xdp.lock, &xs->mutex, and netdev_lock_ops
Thread-Topic: [PATCH bpf-next v5] xsk: Fix circular locking dependency between
 &net->xdp.lock, &xs->mutex, and netdev_lock_ops
Thread-Index: AQHdOpFvCDXqVCHh2Uux5+dmiUlnG7a68dFQ
Date: Wed, 2 Sep 2026 08:19:20 +0000
Message-ID: <DM4PR11MB6117332DE5BD8408848E453D82B72@DM4PR11MB6117.namprd11.prod.outlook.com>
References: <20260902041257.58374-1-ahemadkhawar123@gmail.com>
In-Reply-To: <20260902041257.58374-1-ahemadkhawar123@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6117:EE_|CH3PR11MB7764:EE_
x-ms-office365-filtering-correlation-id: 87c4b966-4dc7-460a-e52c-08df08cae3a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7416014|23010399003|38070700021|921020|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: mVlRMtDIVhWKWmTb6Zw4ht9BDC4R/sdxfKea7H9DwvIeJmU6MP2jOE9Ie7e0sYv7d4ynES/Nimux2x842qy3QWq2PECAT63gJBltTnoQFwyuSelzrjDhxMqLG8QaFUcq83heMx54R9vdzvzLyh86yJof2uIxaMbTzczGPQoZ+BulQ7e3P90TEurv/caS9qUP2KJvi/ATsvAc5wsbyba51wq0K/DgldOgkfTYmbtlPHtY8UeYVopVZ/3uDR6wKCdJB/ka4/ziDu5+v5i7OCoCMRlH6BtniOeZizrUNh9AtOI93LWFJWTYghUaAyZlbkk6NeCDb7BUDUNnzlQMDZA95jJadLjrRGbH6EhetUorG5OudnsfMAW+jp5ky0UgeDefSy8h0jMvtWldhMRUjlex2KJoLFiu0hxPrYTx4J2kNupmaxPMtoMiEooNVj67U1Yk4BpUpmL8bnR9iK50vYGAxUCMfpmc3t9nH9NwwAl1wl2vgBr5dfNykgTRadrqfYmHiW60V3sJ/yDi6UC/83gRtjkxzdiiK6ITMmvil1tCxiFhQs1kWgXnFzssnfwoVXUNUzIVXBuUuQYV8aCSHKToDYkgcElSa/EPtd7K6MQ9JfWzSyDovMzRKBZUkwrgTLYIqOP83lxgo8CaXJfuDrk593T9ZOnN1bX8Qal3lwpEGuIjujIQaY1lVPr+JZTOdAqq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014)(23010399003)(38070700021)(921020)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UJtHQc6njoxWzKYFRJe6UjdZQrLi4C8fhq4g8ICqn5OUdaww0wknTesK5PCE?=
 =?us-ascii?Q?/6kLT+igBvmLPfQzdNChEDSrvOzJj6aTFGRVRDMnPWoygVPVWZcJni1SVJjs?=
 =?us-ascii?Q?QF8TrUnBik9gpRi93AyAR0xHEwTtgbsBouBSnBLOLgxWr8IrZ0aElhynPvml?=
 =?us-ascii?Q?rAvrmLF9/czac2NO9PDYkC9MW6U51w6SrFxCG21FLGA0jEsdxv1RFLOvWllc?=
 =?us-ascii?Q?4CsDLIk6Q2c90h20qUXEKZThpUGR+VHssXCIBZzC38iR4x8CJVZb3sd44LFU?=
 =?us-ascii?Q?nDNL789dtu6J7wJzOqP3dySl4YBM2bgY5tbYNOD1Cy5WE5L6B/uzi200jGhW?=
 =?us-ascii?Q?ER9Oj0JYGHsLfC9eT2wjZ2MnP6ruiX0nVJ7GiTIiLnN5pgBhDBRg3HUyDdCa?=
 =?us-ascii?Q?eDzh0Pe7MGYkbrz1aRBG0jTm9gNZ+rEFpYohfVk1wVgSqnacT7FRXrB+oZmy?=
 =?us-ascii?Q?8vl3cOzjmnG2iPUbUBV5LAmA4oj3AEj1pir+x36+lYG1cBP0Dy0Zyt2KKi3U?=
 =?us-ascii?Q?TShPk/EanU4+b4zRVJd9CLGgF740q1137qBpgsV9HDlTGDdvwhriLXSUSKUS?=
 =?us-ascii?Q?tudQ4aDzZBgmMWMc4rQJYznX30n0ZBRhIECpJl08tzBkLsUxqCNjJceKPQi1?=
 =?us-ascii?Q?2WWxxQ2Y3EIsIb6TDMbuBciyPmNhlWURg3iyZB9/cXCed0KEdch7o9g9bssW?=
 =?us-ascii?Q?G6XnQ5PEuRCjxQKhGqpvrzfM2Rf/KlyPiQaS6JqWwasUbT3KPcEVtH557Tyo?=
 =?us-ascii?Q?8+J+stTyhnPjM5dLqfSWElzyObksEDaGmw99+zrXgr+cvLd69iU5v9cGuybG?=
 =?us-ascii?Q?8K3xQ54JzIkSr+U4ct2zjJuvvjBaohpwqpmDdpJbL6MfICBpYxJxYddMOMPg?=
 =?us-ascii?Q?3DwiaDPX/ujWRCSR7dM1Nsb1rDidpvwpf7G4hQNIqn52XxUfAg8V3HnTwMyT?=
 =?us-ascii?Q?dKUVX8oobixNOwPAG/oYVXqYRNc9un5d6N3ctMGuAzHGp/HguDwZLCDpbA22?=
 =?us-ascii?Q?J4vLklfCUD5JdNSUZYwZjm3c/JwDBuhID6AtPSqLYyEF20yhrH3iFUOWuNXs?=
 =?us-ascii?Q?s7ctpclxt7a8meuPvsIuQmo9WstGDdqYDMGkXz/ZME1spDBFrGjmXC61jDXN?=
 =?us-ascii?Q?8d4ebAfXP66TEfqbj9Ui3sAuX5SBgSvo5FZ7HlS1DUubLc9zRQPqGq5XgmuX?=
 =?us-ascii?Q?J7muDK2bBlQl8wIjwveUL/1JMWZXvnElRTswfPKliRiQdIyM3KshvEnJO0/W?=
 =?us-ascii?Q?AQVCv2hZd0Cy3kn4IAnO4XMpuOWxUe5MkUedsng8lx2e6txvuHXdc27B81l8?=
 =?us-ascii?Q?RTzcKgRHCYJ3TXUuyflQbAGnn7DctDQ+UVLmZbc/Q+sbCrU2/AQ8b8cQHmD6?=
 =?us-ascii?Q?wfUpADXP2h5sVG737JODKa1i0pIFggKX7vMLorwhr806sT8iULDeiWGZMWhh?=
 =?us-ascii?Q?6NMbTS9y+CZOHJmXoQU3Q9fzkwsEeg5sixBiITBZSb7If1c5ZROJFaUQ22fA?=
 =?us-ascii?Q?wxoUapnWSQL4Yht0HvHEaylzATRQq2Tdera9Hr9JPZaAWNCVjJNRK13txKzq?=
 =?us-ascii?Q?v/FX/WOyNeJ67CcuEwbgNS2UJwFT2HjbbgAzmvuWtK0nJl17HShbEMV/GMGC?=
 =?us-ascii?Q?7Dg5NxdfXa1kG7ksrTN2os4R1KQYCKcMUzd2pPb0fVBi49uNamXHwJsl2agv?=
 =?us-ascii?Q?VNJCTYpDy7NsShjwUCVdF8jYXVL5niGfjHfTV4D7QaMflcw285HWWCh4TFmA?=
 =?us-ascii?Q?c1GUFi3tvqiLVt7KCQeBs0m2M5CB7C1q7VO7JekQ1im/IY4olFyu6//HW8Q/?=
x-ms-exchange-antispam-messagedata-1: bPERkMt3TsV7Kzb5QLjdvy9T7FiFuVUfeWw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lWhoh2TVg+rz/Slo0N4oGAl8ZylcZMr3kd9NaJjwo1PA2lC9Gr5D+89Bjm2dRjYl6baRGBRl+yrqs3r46gfeow+WGaq9lmTxSuW7SvjOEIb1GkHorB87ARKq3NjuyHAv9V86USO9YMT7UkK16HNlji2sf42hYwyOof8ueQnCyx0PvtD97GVOZB5JRaUNz17NibhoVDaWKL7zndb2GR82ITCioxWfKa8DcSIUwUyVOerHyoRuFGLbB3uN22TT2C0NnWae5vDYQV1LBgtdJ7VF+IxQsFhZx0R7e0JNRvqb0pGc/3cSP9sM3TrhxoC8AveXJQfIStS63523LNuGDGNH1w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c4b966-4dc7-460a-e52c-08df08cae3a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 08:19:20.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqcBQwdCTEvFbtO5rPFBH8o+5bYeOywh/TKrM2Ehq8sMM46nNJo+dxUmgAQ+WykScTTMgNGC/iFdqwHTD2K6FFF0haltP6/0zxkrXg2yWPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
X-OriginatorOrg: intel.com

> syzbot reported a circular locking dependency involving &net->xdp.lock,
> &port->pnodes_lock, netdev_lock_ops(), and &xs->mutex:
>=20
> -> #3 (&net->xdp.lock):
>        xsk_notifier+0x3d/0x2c0 net/xdp/xsk.c:2106
>        ipvlan_device_event+0x310/0x4e0 drivers/net/ipvlan/ipvlan_main.c:8=
34
>        unregister_netdevice_many_notify+0x808/0x18b0 net/core/dev.c:12518
>=20
> -> #2 (&port->pnodes_lock):
>        ipvlan_device_event+0x85/0x4e0 drivers/net/ipvlan/ipvlan_main.c:79=
5
>        notifier_call_chain+0xb5/0x410 kernel/notifier.c:85
>=20
> -> #1 (&dev_instance_lock_key / netdev_lock_ops):
>        netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>        xsk_bind+0x331/0x11d0 net/xdp/xsk.c:1627
>=20
> -> #0 (&xs->mutex):
>        xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
>        xsk_diag_dump+0x2e0/0x4e0 net/xdp/xsk_diag.c:166
>=20
> The cycle exists through the following dependency chain:
> 1. xsk_diag_dump() acquired &xs->mutex while holding &net->xdp.lock (#0).
> 2. xsk_bind() acquired netdev_lock_ops() while holding &xs->mutex (#1).
> 3. Device unregistration in ipvlan_device_event() acquired
>    &port->pnodes_lock (#2) and called xsk_notifier(), which acquired
>    &net->xdp.lock (#3).
>=20
> Break the circular dependency by decoupling the locking in xsk_diag_dump(=
)
> and xsk_notifier():
>=20
> 1. In xsk_diag_dump(), avoid holding &net->xdp.lock while calling
>    xsk_diag_fill(). Instead, locate the target socket under &net->xdp.loc=
k,
>    take a temporary socket reference via sock_hold(), release
>    &net->xdp.lock, and call xsk_diag_fill() (which acquires &xs->mutex)
>    with sock_put().
>    To preserve dump continuation across buffer exhaustion, distinguish
>    -ENOENT (when an unbound socket is skipped) from -EMSGSIZE (when the
>    skb is full and the cursor must be retained for the next dump callback=
).
> 2. In xsk_notifier(), split device unregistration into two phases:
>    - First, unbind all matching sockets under &net->xdp.lock and
>      &xs->mutex.
>    - Then, release &net->xdp.lock and perform device queue teardown by
>      sweeping the device queues via xsk_get_pool_from_qid() and calling
>      xp_clear_dev(pool) outside all AF_XDP locks.

Hi Khawar,

We went with fixing ipvlan side instead:
https://lore.kernel.org/netdev/20260828164918.451364-1-maciej.fijalkowski@i=
ntel.com/

Forgot to CC you, sorry about that.

>=20
> Fixes: 975b11ae9077 ("xsk: add socket allocate, create and bind")
> Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Daa48b5fe7bfda62d1682
> Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
> ---
> v4 -> v5:
> - Rebase cleanly on latest bpf-next master.
> - Link to v4: https://lore.kernel.org/bpf/20260826174744.3394-1-
> ahemadkhawar123@gmail.com/
>=20
> v3 -> v4:
> - Rebase cleanly on latest bpf-next master to resolve merge conflict.
> - Update commit message to accurately describe the full 4-lock dependency
>   chain (&net->xdp.lock, &port->pnodes_lock, netdev_lock_ops, &xs->mutex)
>   from the syzbot report.
> - Link to v3: https://lore.kernel.org/bpf/20260826173019.2917-1-
> ahemadkhawar123@gmail.com/
>=20
> v2 -> v3:
> - Fix direct AB-BA lock inversion in xsk_notifier() by performing device
>   queue sweeps via xsk_get_pool_from_qid() outside &net->xdp.lock.
> - Eliminate &net->xdp.lock -> &xs->mutex in xsk_diag_dump() by taking a
>   temporary socket reference under &net->xdp.lock and releasing the lock
>   prior to xsk_diag_fill().
> - Distinguish -ENOENT (skipped unbound socket) from -EMSGSIZE (buffer
>   exhaustion) to preserve dump continuation without infinite loops.
> - Link to v2: https://lore.kernel.org/bpf/20260826162110.99879-1-
> ahemadkhawar123@gmail.com/
>=20
> v1 -> v2:
> - Avoid reordering locks in xsk_bind() to preserve errno precedence.
> - Link to v1: https://lore.kernel.org/bpf/20260825152152.86092-1-
> ahemadkhawar123@gmail.com/
>=20
>  net/xdp/xsk.c      | 16 +++++++++---
>  net/xdp/xsk_diag.c | 65 +++++++++++++++++++++++++++++++--------------
> -
>  2 files changed, 57 insertions(+), 24 deletions(-)
>=20
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4..e72344fccb 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -2099,7 +2099,9 @@ static int xsk_notifier(struct notifier_block *this=
,
>  {
>  	struct net_device *dev =3D netdev_notifier_info_to_dev(ptr);
>  	struct net *net =3D dev_net(dev);
> +	unsigned int max_queues;
>  	struct sock *sk;
> +	u16 qid;
>=20
>  	switch (msg) {
>  	case NETDEV_UNREGISTER:
> @@ -2114,13 +2116,21 @@ static int xsk_notifier(struct notifier_block *th=
is,
>  					sk_error_report(sk);
>=20
>  				xsk_unbind_dev(xs);
> -
> -				/* Clear device references. */
> -				xp_clear_dev(xs->pool);
>  			}
>  			mutex_unlock(&xs->mutex);
>  		}
>  		mutex_unlock(&net->xdp.lock);
> +
> +		/* Clear device references outside AF_XDP locks to avoid
> +		 * lock inversion with netdev_lock_ops().
> +		 */
> +		max_queues =3D max(dev->real_num_rx_queues, dev-
> >real_num_tx_queues);
> +		for (qid =3D 0; qid < max_queues; qid++) {
> +			struct xsk_buff_pool *pool =3D
> xsk_get_pool_from_qid(dev, qid);
> +
> +			if (pool)
> +				xp_clear_dev(pool);
> +		}
>  		break;
>  	}
>  	return NOTIFY_DONE;
> diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> index 0170363eb5..bad0b13064 100644
> --- a/net/xdp/xsk_diag.c
> +++ b/net/xdp/xsk_diag.c
> @@ -97,6 +97,7 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buf=
f
> *nlskb,
>  	struct xdp_sock *xs =3D xdp_sk(sk);
>  	struct xdp_diag_msg *msg;
>  	struct nlmsghdr *nlh;
> +	int err =3D -EMSGSIZE;
>=20
>  	nlh =3D nlmsg_put(nlskb, portid, seq, SOCK_DIAG_BY_FAMILY,
> sizeof(*msg),
>  			flags);
> @@ -111,8 +112,10 @@ static int xsk_diag_fill(struct sock *sk, struct sk_=
buff
> *nlskb,
>  	sock_diag_save_cookie(sk, msg->xdiag_cookie);
>=20
>  	mutex_lock(&xs->mutex);
> -	if (READ_ONCE(xs->state) =3D=3D XSK_UNBOUND)
> +	if (READ_ONCE(xs->state) =3D=3D XSK_UNBOUND) {
> +		err =3D -ENOENT;
>  		goto out_nlmsg_trim;
> +	}
>=20
>  	if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs,
> nlskb))
>  		goto out_nlmsg_trim;
> @@ -145,7 +148,7 @@ static int xsk_diag_fill(struct sock *sk, struct sk_b=
uff
> *nlskb,
>  out_nlmsg_trim:
>  	mutex_unlock(&xs->mutex);
>  	nlmsg_cancel(nlskb, nlh);
> -	return -EMSGSIZE;
> +	return err;
>  }
>=20
>  static int xsk_diag_dump(struct sk_buff *nlskb, struct netlink_callback =
*cb)
> @@ -153,28 +156,48 @@ static int xsk_diag_dump(struct sk_buff *nlskb,
> struct netlink_callback *cb)
>  	struct xdp_diag_req *req =3D nlmsg_data(cb->nlh);
>  	struct net *net =3D sock_net(nlskb->sk);
>  	int num =3D 0, s_num =3D cb->args[0];
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
> +		target_sk =3D NULL;
> +		num =3D 0;
> +
> +		mutex_lock(&net->xdp.lock);
> +		sk_for_each(sk, &net->xdp.list) {
> +			if (!net_eq(sock_net(sk), net))
> +				continue;
> +			if (num++ =3D=3D s_num) {
> +				sock_hold(sk);
> +				target_sk =3D sk;
> +				break;
> +			}
>  		}
> +		mutex_unlock(&net->xdp.lock);
> +
> +		if (!target_sk)
> +			break;
> +
> +		err =3D xsk_diag_fill(target_sk, nlskb, req,
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
> +		 *   -EMSGSIZE: skb is full, retry this socket on the next dump
> callback.
> +		 */
> +		if (err =3D=3D -EMSGSIZE)
> +			break;
> +
> +		s_num++;
>  	}
>=20
> -	mutex_unlock(&net->xdp.lock);
> -	cb->args[0] =3D num;
> +	cb->args[0] =3D s_num;
>  	return nlskb->len;
>  }
>=20
> --
> 2.54.0 (Apple Git-157)

