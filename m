Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FEE46AA80;
	Mon,  5 Oct 2026 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195908; cv=fail; b=ijlfl7mh5rfx82c7Rw/pk9nEaMUXPFjGLYrct/29OKw2MnwHk8iFEEcpylFQeQ0+5h58WNW7ZU5F9galZiGQvMugiUIlFbck3ZqIMt4Ifu7GUEByffDNKVW1ZhG1oJk0HLwqNUqCYs99WRC5AWfkCUwcTn+DVmD4W0j8jPgwjr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195908; c=relaxed/simple;
	bh=5cpgbJ8XWwounIIpMvaLA0YpdsJg88N377Na1aArUhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UsB4uxzmJRb7can3vM4m3f87nSnAhQlQw4T1zJetcE4h2Djv9tjDDHLEfHt2vwmX1uyGA+dmhJuOEqNdgg5nh/0EqS3obrNhqpcco9TNb8/D0UJ9RptK2OP0n/2FKoJVoTSpd/XhHkVXHojfCIrDZtOri5INqLF91KHTK4C/z7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jK5la4UM; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jK5la4UM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791195907; x=1822731907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5cpgbJ8XWwounIIpMvaLA0YpdsJg88N377Na1aArUhY=;
  b=jK5la4UM5NeklXCO8sPig1yvYp5BD6P9o/BXmJ5uhlrs3UWGvoyZVjY8
   G0og1HDbiF+pbFqq88j84o/eS3FQthMQy5pJmx4AMKgh/vq6TBE/VqBFo
   nV2lWdRV1t3TjLscCCuT7uNrYg5z7MRU3xGKBjil/4Oxpv8x26L9vc4Sb
   WvmC3Rasxrpj1npWMdaWxAGsid3p1rXdBjsgxAgetndHHzVT4GcLTt7cr
   i5HG2SaWLBdVzlxSGzyOC3yu9Nzr/qu45n/va5/QZVhxjPuG/rnV9R/hw
   UNje+lvKaJL5qhnQS70tFMDotpFpZylp0VZwT98tbmhP41+8CrAhsCZmJ
   Q==;
X-CSE-ConnectionGUID: 4Y4zkIpXSgmSkukqF9Qupw==
X-CSE-MsgGUID: tiiJKnU0SgKqwuOJzxz2qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="79422707"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="79422707"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:24:58 -0700
X-CSE-ConnectionGUID: j6jy+j9sSZeIgg/uik94Bw==
X-CSE-MsgGUID: P+6/2g8ITfuikj4hpeHr3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="284671262"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:24:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:24:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:24:57 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:24:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWccaixWpokm7Gq9Vfbfb6rkzRG7Xe5dOPYJOKyV0vDUSUJ67pD48Xi1QhOdNnnRWAO5jfdpPzgbkkbE8OheK5QYPAwGNKdMoLGMf8gkJMEPfJkScoQqLoI1LMds8RC3lm33q92T52Yk0AUP/pOn80K3M/lAkTwhAj+IcXYnJl5wOM0+loxE6yrKfkycAAnRSny0vir5l/YHnWdIC6HM2qqLLaexJEYHZGm1OFSiqvOW7z4w8UzgRYM/yotWk4FpgwRu95t1oxk7iUbnN/QSgc+FIkTvmNqDccWLTNpy35cxE0P50SCwhum0ingZq8eRK+6lk8MCtpAm4B45VA5MEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=433WpYpEe+8fFQRZikfL2l8NgqeYlDUAN3qAwbwysWY=;
 b=JrlPEo8R6CQNRsVidnmuIqJU51XO91R+tvTSa3PixGVQFE6534Men+wilaFmNXxPV8IkpTa1qb4F7mOYNZbliBmQwjzqBA8CkU33zn+iRsbtr1X8ZpcVZiCxl3zy6r0a4sonB72djkGZJXR4/WFk0M+3KDMktpHgPDBybVt3SuWEq1eXdtqB6KPpd4Pq5TWAkepn+EyH7BVCOe6zDQu3HdNiF45HXLBwzM+vGLDI5RCJzHdqnkdDQBEQ/2jVVJ634uSKY+7EmyWCv+Lt/tHObnT16hUIkrJ98aAK5bkJQLCsShf4ex9487HevrWPl/bbcABJCeg+hPT30mp7ROxfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:24:52 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:24:52 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Henry Tieman
	<henry.w.tieman@intel.com>, Anirudh Venkataramanan
	<anirudh.venkataramanan@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>,
	Preethi Banala <preethi.banala@intel.com>, Kiran Patil
	<kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>, Stephen Hemminger
	<stephen@networkplumber.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH iwl-net 02/10] ice: fix IRQ freeing in
 ice_vsi_req_irq_msix() error path
Thread-Topic: [PATCH iwl-net 02/10] ice: fix IRQ freeing in
 ice_vsi_req_irq_msix() error path
Thread-Index: AQHdUm8xDzz03GojrUGwLtZdjvTm57buwofA
Date: Mon, 5 Oct 2026 10:24:52 +0000
Message-ID: <IA3PR11MB898651BF54ABFFEE99BC9BFDE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-3-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-3-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: 491184e8-6173-4d66-1abc-08df22cae4e1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|38070700021|56012099006|11063799006|10067099003|21046099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: VKv4Ssqf6sXRWwmm+QAVFeMmLWMndZRMbYsHP7E/UbCelKZodb0I6KQ0MEFiiA0lklhrpMYRUCFSbA28EN9rOcy5w5l4fyBwo8tWjstOXhQQFZLGc4xOCKp5gU7CAcnZoFv5PfBlXT6sUdtaRuwqgaBmKZ1Mw8bNYsj/efLPNx7KhTmPR1L5gntQzVLXRmuBN6EDZmTSuADgCVfSSw4+XR9vkqeFdDZ+6VMhEu/g1gw10trJvBxoFl7xkcdpI4tbrHRsM2wi5PvnkNlvLB8NZa88c2Y2NwNX1sebRdHAN0z2WPuSb2pXnm5MqfeTqKWUC0+ukcVJUQ7Q+8fDnimbWeflZ2pdKSXPfHUaZTIGOyrSNjqAmDZwgvO87w0DMoYS8pKUDNKYbX+WRwAZxRCru4gN37kl+wgpUoWACBMEZ3SF9u6VZlN86egDnP1iO9YzagFx4cCIotCkV+O7Y2JzLHk7sj8/vIZ1OxgHl7+CVaobseSzHBCder4blv/PNG+HIro20+NfekU7IXl+SqCVRtFnnhKZzC/Po/jbR3hC3IhXAyENKqHG+M0cFq6UsDdNlMEwoXhgoAJ6rxPmWYs6LSqcHzJkn+PaqKkXXtiPFDYlP2YgvFfvJFyzutiYO0s44zPbOL08+Q1fwlNyBKX6fP9Yp2+KzJYaGi6oHWOXx08NbPLs50zusL2tSekFJpfZcyKiPA4ep4yHDhoj5hc4gG4cZjrhUctkdfVzQxuhNvM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(21046099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sG1HGaoGnyyXEeB0v+JiO0kDWotd7x4VB5oOitf6F0nQ8YtuXtxSZ3feAId5?=
 =?us-ascii?Q?rAN1vxzC34p6vhHh0U8z17PLPE4yytXARAdgyBAhVpCvZWLs+v4feXsOjGNv?=
 =?us-ascii?Q?gMszOTiF8dOx/JsZN1xANw27j2EAReGmJ10/A/VXv8aQOTH3le91lwRZNoco?=
 =?us-ascii?Q?GUyCMSQuRiKnRB3lCmOaRBwjn+v1hexkjxmcQAkarWWaMlsDArKAjksPRRsB?=
 =?us-ascii?Q?cWi8lLbWi7JZ1PX3cNVjY6oY8K/RPxKZ3VH2UdBa1eqZcz4PEkY/OyruaikF?=
 =?us-ascii?Q?axcXdOGBLSJ60nnXVinYsPk9Ret58AbVIQh8ZDl/cOqHI61b32vl1PfXzsJe?=
 =?us-ascii?Q?DlcUT6rrN4zZ+6CyMXEahMnXcu/ZXJ54UmHEwGWFfFumnoFNUKhBZEs1jFpV?=
 =?us-ascii?Q?NlRPGuHyNC1cV/Bp8pEKNFPoBCQC2qyUnLppEU8eM1+Rlenv3fHGkI5qCujK?=
 =?us-ascii?Q?jVpwPmbepKQ2tUR5m/YkXmqdUSiuZPh6usNwoVU089mK01RdfyrheoXorGKh?=
 =?us-ascii?Q?vGY6GERjZ7CkEcscLf4kOtEjUsjhEvyP16gYqOqX/BD9Jd2YSmzjRJLnDgR+?=
 =?us-ascii?Q?k98NDprIOWYqEv8EGq0ZssGVKAzO5hCvdtD4DqSd+/Et+deCJMMbYB15N47X?=
 =?us-ascii?Q?E0hApCowS0vz0u2nRg4oPp8yS0j72gbY7fEeK/cc+SupZ3v3ggvjT6Za+PXc?=
 =?us-ascii?Q?HXbzvg66qzx5CxMD4SIxsxaoySwfPTfuFV2uT8pci/Z78yR/MlcGvNdGExqR?=
 =?us-ascii?Q?0rHWmD8NbKBgzVMKapVRtmsvgHEM2jx7HSYHEyufWnmo3j9q8y+zSHpSdfmq?=
 =?us-ascii?Q?gWOmK9kcX4S29aLcmyOzOsrt13yR6qPD/PN8Wib733IJTIkUVoeRU6wEVL3B?=
 =?us-ascii?Q?W8chekOWNGbx6KfknPXDARBJhz0u0LB77fHHolBIHboaHk2RHHPpIhjVxiQb?=
 =?us-ascii?Q?whj/kEu9IXCKhHil1C3KoU8vsEMufWTAUjZzUp3ySN/pIZ7bxS6Bpcv9B9a/?=
 =?us-ascii?Q?GoGpt8U5zwbgVs3wPmq6kWWjFrPRp7/qIj0fXt4cr00ATHAWyuanz2MLSw9a?=
 =?us-ascii?Q?rvUZQPGvvgoB5KOCl8fZePKMA7U4LqGpOcBpR7CAeg4KKX1y1jZq2b05kByE?=
 =?us-ascii?Q?hKIahvaRH51sM6ICsYnXheeD8qBDlILMtiZuJeJx9/t3/qjJ4FH8cE7QodFP?=
 =?us-ascii?Q?14LgyoMuzAqvOhxIgNs9nX1o/gouZuZ1UgOgvGs/xD5gNFf0yVcI8hWuSGV9?=
 =?us-ascii?Q?AQyTWx/OBzdRUerOfzKLa6BSVUaCO7MNH6O1UDq+Tlw3k4i4plKywFuCeeNG?=
 =?us-ascii?Q?vi5uZxW0eEBDsoU8+Ic1bC+UP1P4vy53nm1ukjgiwK1ND0/zbnLrTWANaCpX?=
 =?us-ascii?Q?391etdHarY4DHQY/M54+e7lTTmREfmu+gL7Pj1yZU1nW5roMveEJQhNv3A3x?=
 =?us-ascii?Q?do2tDKnR+uSTUSn4osPpZnXxZ6OJCzgFqt/kBa11Y+MoOMpgw6FruEmkv3fr?=
 =?us-ascii?Q?TdeISjcTKIAxmQUQeNKOrvjs6WmwnFeMTI9EZmnYD5DW3cqACY5dDOACzyiW?=
 =?us-ascii?Q?BqpUmE4PjA4RR3ptxcNZKeOxV5OHNo/mIFadfefGLYpSBZDYle/qUlYWSoBO?=
 =?us-ascii?Q?LBYsaj+iIiq6ObhSjnbnGCPqJJoERB6N8Sre55TGXGZu7EtH2RrgmoR6Bx7y?=
 =?us-ascii?Q?X7dxOjRxciY8SG1JbZmHTnfvGESPRw5UNO44q/Zmyd7I/w/oajZsoG7a5lUW?=
 =?us-ascii?Q?lQMGJb9n7HW4rfH31vCwiBhEdyahhjg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OuTmFUfUYdmV3iHIHIwbkQ5lNdXHn3IAoFWlrXc5o1dd9M5gdf+8lLNu3dMNw9uzmJorpi0LOvtrYAqqgjdcAiLrIxe/Shgm5vqn/6wp/llCzps2Iqcs3dNKsqNFJpCHajFjgXDzHXf8iwlu7mWDV5xgxoGLVlTyYhfj6rCLUKuk0fmaZlxUCk+HkoS9IbMrkXewiAAYf/SHVl8nY/AEuNjRVr7OC1Hi81SsWSTPimOvQpQHr6kiK3c8COHNXaLNUmis80RknqOKLfQdKZC0xxZKFYGKjeRyBps2yqXjRDB955CB8hG/no2UCRJ1GXowfLehEutxxUyvNoEOPoXVnQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491184e8-6173-4d66-1abc-08df22cae4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:24:52.8179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1UsmWL7lt6PQwMIeZ83yKNkitG+93Yf9M7axJk/Vqc7Ax9UaZM2FqpsauUwbcqevPr+9VfKDC9d8s6854QKAY3IXn+Fosc87D4i7Mm5onk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Petr Oros <poros@redhat.com>
> Sent: Friday, October 2, 2026 3:08 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Alexei Starovoitov <ast@kernel.org>;
> Daniel Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>;
> Stanislav Fomichev <sdf@fomichev.me>; Henry Tieman
> <henry.w.tieman@intel.com>; Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Jesse Brandeburg
> <jbrandeb@kernel.org>; Preethi Banala <preethi.banala@intel.com>;
> Kiran Patil <kiran.patil@intel.com>; Dan Nowlin
> <dan.nowlin@intel.com>; Stephen Hemminger
> <stephen@networkplumber.org>; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org; bpf@vger.kernel.org
> Subject: [PATCH iwl-net 02/10] ice: fix IRQ freeing in
> ice_vsi_req_irq_msix() error path
>=20
> The vectors are requested with the q_vector as dev_id, but the error
> path frees them with &vsi->q_vectors[vector], which is the address of
> the array slot. devm_free_irq() finds no matching devres entry, warns
> and leaves the IRQ requested. The unwind also tries to free vectors
> that the request loop skipped because they have no rings.
>=20
> Forcing request_irq to fail on the fourth vector during ndo_open
> gives:
>=20
>   ice 0000:04:00.2 enp4s0f2np2: MSIX request_irq failed, error: -16
>   WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
>   WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
>   WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
>=20
> and the three IRQs stay registered in /proc/interrupts while the
> interface is down.
>=20
> Pass the q_vector as dev_id and skip the vectors without rings, which
> the request loop never requested.
>=20
> i40e fixed the same mistake in commit 915470e1b44e ("i40e: fix IRQ
> freeing in i40e_vsi_request_irq_msix error path").
>=20
> Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index f2121e79fca993..d246cde36ae726 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -2582,8 +2582,12 @@ static int ice_vsi_req_irq_msix(struct ice_vsi
> *vsi, char *basename)
>=20
>  free_q_irqs:
>  	while (vector--) {
> -		irq_num =3D vsi->q_vectors[vector]->irq.virq;
> -		devm_free_irq(dev, irq_num, &vsi->q_vectors[vector]);
> +		struct ice_q_vector *q_vector =3D vsi->q_vectors[vector];
> +
> +		if (!q_vector->tx.tx_ring && !q_vector->rx.rx_ring)
> +			continue;
> +
> +		devm_free_irq(dev, q_vector->irq.virq, q_vector);
>  	}
>  	return err;
>  }
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


