Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAFC468C07;
	Mon,  5 Oct 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195847; cv=fail; b=YhoQC0AXw2a9yU6IA6kGZnaFbSXWnIHpKSf2hRikcYn75nyGIGVr4tTYTexZoidxdeKgRf0cv9IhvYvTi6YOuoF+SolOiPif27RF+jnmXLBGlv1qv4x9f/jSQ4R7bVX1Qje3xUbjHQKXY6orpBZNrmfNgv7r13Ck1XMUqTKGjLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195847; c=relaxed/simple;
	bh=+XnLtXKHy0a1tKl1vvLLy4QcrX/3Jat22UXfFDhsOWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BjAFF0ZRBNL7tcatLJ5EaHGUYGSKAAG0zMqH7stVoWF2GtUYTn+M1mtLQQAto6PbJmIbiDMzaCVyCNgCLh1YoTHgOiA+jMrxOEROXhGEXMaz5vfhGlIdxCk+qjXEjQXIiDoo+WqZwUb52bsJn6C9f6GGUo/LVSG07+BzCwM5ZUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDFYcvmB; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDFYcvmB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791195846; x=1822731846;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+XnLtXKHy0a1tKl1vvLLy4QcrX/3Jat22UXfFDhsOWM=;
  b=cDFYcvmBsT+kxo7eazvXOuRxeunDdyJYMGLpj9Kcz2/ow9WIGn4v9mLx
   0JKdyvHHVGexFf/ssW9cmX8GOY+IXEEEUL9lGYZHg7mdkL3jI+KDrfN/o
   rpVHnQveoj4ixQ8IOWwrssgDCq2zhhARgl1t3aG30nRCoVT+HTqTt2/W7
   t2HbfAgEUhoxMwpfNZlbm7kkUVe5L7deGm17B9BeRn7JYdF0aVLOYxxAC
   L1gVqOgh8l7Q9xkNnod13WVAfeVrWEKod6YDh17CsruyA6q4lvZg3A4EE
   rpSyZwcR6LsiYm42HooO18cI/3L7hisGr0CnJK6BJYEfnQrOVQ+Fbtwd9
   A==;
X-CSE-ConnectionGUID: r4Ivpe28R3WQXdmgo9hsSQ==
X-CSE-MsgGUID: /AMitkNqRFGAo4C1BUbbVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="91887676"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="91887676"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:24:05 -0700
X-CSE-ConnectionGUID: +hpH4t+wRfunGyMRouCzAA==
X-CSE-MsgGUID: Q5u/9Qi5QmyxsUUBk7XCAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="276877740"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:24:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:24:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:24:04 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:24:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+Dt5kEjnyXkhnlICnQyi9Or8t4i5GyPcuArRVsOhAtwvA1dMURNntO2FTKYT2J6SfHG2kqlAqEqqptxjxPWI1kYIz3RB2bLfJhbIrYiu+tXn4jOFpeUdSyYXcA0tht4wsCQfBFzgM/m77HsXtN8qQtsP+S92bwmGKXNOoOuqhJ3lANesz5N93Ibbvgy6QjxOCQYsbQTaaggP9CjWtKVvDG//mwqmmkdNLGMzI765i6h8XdQlFUyRbM/Nl8bSIXAfb0O+T8e+WSbW3/cKxmtL6NzNeabaHZDhzbBPpvZPDQVmLHwlvAZzJPdCipR8lecqQhscEPsf71w2WaUT7iuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn0/5C1CzW3urL2Gcasgyg0d4piD5GVdwUrrvIjhAXQ=;
 b=Cr1jxiHJ0JnFPsN7nJqRrkwoFmGlm8RqRMddkkZntLzj/fwvzqTKTTWF6lUeYTzOB2jBinModsEgz0OLtmElWwymnjZUYU25Gcb2PLxlxxPG06rbmDBS3s2vvXu54usDI9u4+P8ex6qp2pcM2sI1zMpJziDAptn4ETnArOsGoi4qrZUvU/b7Tv0acUbPVzh+Cg6xGhyaKvepBVz6OPPvLZc/TQzqYNDR05jY01Veu8m3gEkC4mphPzcys7ii4amJwAHF6MlhvRxrfbVXw+MZdwYpjsfi74jq2vbVVJwXl0zYmtV3E2LqGjD5YzSiU+oJoGZ/LOX5ItKIyc6NCNGCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:24:01 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:24:01 +0000
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
Subject: RE: [PATCH iwl-net 01/10] ice: replay UDP tunnel ports after a core
 or global reset
Thread-Topic: [PATCH iwl-net 01/10] ice: replay UDP tunnel ports after a core
 or global reset
Thread-Index: AQHdUnCRlrRqvb+MEUGYh4NY7NdSrbbuwlkw
Date: Mon, 5 Oct 2026 10:24:01 +0000
Message-ID: <IA3PR11MB8986C71ECE278C137299773CE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-2-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-2-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: 01d61a21-6ce6-45ad-b19e-08df22cac63f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|38070700021|56012099006|11063799006|10067099003|21046099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: m6+SyqoDZ+vMmuu1Gfhp9Tvo2dRN53iRrUtNgQ0AcwWOobSwilGLwXqJZvUjX+DOHxWZqyxBfI8h22/IVs+4OEozoM6nSOsJPWhbeF4n0rpjDFv4ao4732F33CAbjvc9Xg+RJ3v0UIMrUf7FGg8NbG3BYoHNvEVy14vXskz8VoB3vZAy67n6RbL3scz4tzVjNxeMeIKxFOrI4A8xxJbOyMQBut6My5RePyfGqQ0a15IOrlwTUEE9lZQ2ahKTHOydNOuAsZSQGLK3NjJQVPZzJ41Ns/5/qGPo8xKwdnbyl0IiGUqn5hRkUJivXNuG6sU89gzRJxTWvJ02O7gcuA8n56d9QBYfHxFEMab+fU1YOE+4J/MLbPjQGisDBEBrS6paqHdM/tYv3PlQBfApGhSUUXfqHbrC6eHYktBU16NX17TMMPIVOwORF4S/W64UixWjP6BHS9eeqj8lAQ1RlRAYg9c7XiAWoon42MLr4uZXYy//N6bRREwYlI2AOu/9GVsX7y864vuqaBziHUZB8JORLgxk8GBx4szp3vuXIZ4uCKCEA8VBzJbiyJUI/C2d9QTGfcmALxwyg6pm+ecnitN/Mdnjr1XrArvZCq41Wjm7b6VZOV6dAqIzGEI8KItUexWV0jQ0gej2yS/Fl1b7hHwDIYfNEouEBDQaJi+v7vFL5Goo1wlsnnjsKl0FkLL3sWFgGxJKs35+D9frxZLV0AviUfhMLwqIXQS6kDXs9vdj7Kw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(21046099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LWd4u0N6xK4IK+lsisRDnI43++ek5JuWOLE3hIH9nT97dmrGCzZlE7c7kycq?=
 =?us-ascii?Q?Mt2T3C3nkCctJvFUxPCyKzK4RucFzHfDnE7+5JupvjLTRDYFL5ezeFAFWIfe?=
 =?us-ascii?Q?wAO4IaRfvbsc619IWRukchFnNVVZeSRi6vBYMLxLKCdzK7y2hZ/CPaDZZJLL?=
 =?us-ascii?Q?DQDDIVlUh/VRZ7wi2ZM+AZNXV2A3n+VE3kvx6AE70GiDjOu6UHkwnuXbxtZr?=
 =?us-ascii?Q?PgA8iQCK1L3FtUqf1UpKHGsJVNjyrWqXjj4829LpEXT8VkGB6+UeLEMkU2Nr?=
 =?us-ascii?Q?ia61RR/NwIY4nsbSV9yB1AT5sWneHaTOZAVlQr9biAIEcMsQBbGiU+l0La5U?=
 =?us-ascii?Q?i73kqj2iCiKdMcqRJhTg36HTDiL/RPHKoxS8JGv6uHAc44xie82clL4KO4j2?=
 =?us-ascii?Q?CRaZYxpy4iAFCavWrK5jyP0kwS3zEhDiZwyJa9USlks330qlJXZUfPylTKBW?=
 =?us-ascii?Q?zdblArV2GhdSkariHSVQ0ZAy3YzGmJ/Xygtm9PjuQrIUBWDhzoQQIuqPxhm0?=
 =?us-ascii?Q?5sQtuTVRyDDJcwnG0IUFRvmPvGVsqNb0zQLxzYa53lvMXfVitbq5BpntZWD3?=
 =?us-ascii?Q?pHzlqAwHGBzOejlZEttlvNw0zU4Edgkyoz8D5KN+2rdGlGXMmNzhn8d07IQZ?=
 =?us-ascii?Q?PCOJyGLDBKE0eVUpbPGsRyIXINe/yiIjnYewssS7BYPDFMnrYrmlq2elhDTI?=
 =?us-ascii?Q?scvDmcKRtce2201/v5lb0RcQKmWKbzcf6Ko8WyQkTx4Bereta9mhMj38pYpV?=
 =?us-ascii?Q?7X+ZCDbnYQd9KjYizW7YT07skE4BuERrLW7uKt/ETlQ6W0IvQuKDD4nt2QwS?=
 =?us-ascii?Q?TmoidLrfJEcElu2HQyQ4KHi6V6cNUbDl18Oq2atEw8rtRzywqKG5GrK0k1P7?=
 =?us-ascii?Q?Pn4ZdRlPWKHVnkqEo0iVfTYdoPg+ZCgyoj2wSU66oO1lZmLL+LYN5lZeECC6?=
 =?us-ascii?Q?9gEPRcGKA9/jDx47X01pMw7WPoT8N7MndFky51Lj7BgtcI0VHyftkoTCSx45?=
 =?us-ascii?Q?DOf75+PSv3YLE0ycnq00lDvaEHr9cfjO1A1P73uP0WxafAXB0NkN47awxFUt?=
 =?us-ascii?Q?nEQ2IEsCigKDWx6IKbI7I5uAEg9WZ2dH7qjVMpgQX6BTfZDGkGNcUKna+ErG?=
 =?us-ascii?Q?CnvARPE3IuivOQix7bccyb2qWVHVna2Oyw3WmuwVMzqJEWasCqOGjvxkLlZz?=
 =?us-ascii?Q?QrtabhP6Cl6qrVf1j6jF/NjWtknBVuu8s6fmBuZb9vv4hRre+wtpQG8TIqgy?=
 =?us-ascii?Q?XdW+0sWRH0SmY0Qi22hPNs6xhtmLTCm7JLoNR8fOSiJeTX6JD51J3xs39lxK?=
 =?us-ascii?Q?/hOsokDhZk3Lel3xrsTufE5N45dZFR/B4LJqo4HtYnqo83iR/W5Q635ADaw7?=
 =?us-ascii?Q?KxT06kEeLzXJkbvIrGa0LOKQCIjjuUVkozlwx4lOKLV5YNJgNtWYWKofw/TW?=
 =?us-ascii?Q?pFpDzMDWvIjcefVuDo780Jv/Xv5OF8iG+w4FXtQoYuonhGD6p2aP0SsIKNs9?=
 =?us-ascii?Q?IwkjD/EpnsNj4vSa5sQ5K4TapVhkLJG+i2Huougby5BKd6qsc6BkfOGajym+?=
 =?us-ascii?Q?VBinsJVRDLnSkSorf6Satg4jTSR9xSWm2w8rz6YPoqkHuBYyGtR45KyfSq0g?=
 =?us-ascii?Q?FO3BlM4+aOMUCC90w+3Bt6vrEJ+YxMOq9qACQWnCo65A2z4BAXKx7u27a/wL?=
 =?us-ascii?Q?hbxZVW8qs+t2mvCJZet0ym5tFoD4QYtBJBIh9chNi/JbG0EV7+SoSnw+Kt7o?=
 =?us-ascii?Q?+pd3++mMWkPUxJ2JBd2tVttCyxnSeqo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a17mXO5/fozQckgzFXleLs5zM0VKckGapB3PE4vkg1iZN19a+L3Axj1VVwz8Au0CelzIl/NcNoTkLBrxD+y/QVSBpk6BcSSLgmUPw4fk+jXPncfH6+Lf/SxPp60wad1bFcNgtzq1Ck3opp9EWRZp+26Z7/01dutRq6wxcd6CdWoHzZr5+jwLDSLuzx9iXIErFzn7LyTeeLE0KrbgoM7s1wFM+UWGWcA/a4XDiQZKnh8EI2OixyWYa/oMUXJAKjM2zMu0NBxlzk6t9iKZsCgCznNBP0iw1NQLjG1YDoiMBhCQNlNKKlnz17H+Y3BBroleadNJpvqXaEn7FHdBrzArAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d61a21-6ce6-45ad-b19e-08df22cac63f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:24:01.4208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVdJK0gFWu7cI6n+BjVZxWJpkdkxVUdebJFEXrH2zXjWw26PGB/Bn5H+trkDBQYmPicvQW1a9LXP/hRrZ2De+4z9YxGZxsi8sG52n9yGkvo=
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
> Subject: [PATCH iwl-net 01/10] ice: replay UDP tunnel ports after a
> core or global reset
>=20
> A CORER, GLOBR or EMPR reloads the DDP package in ice_rebuild() and
> ice_init_pkg_hints() clears hw->tnl, so every offloaded VXLAN and
> GENEVE port is gone from both the boost TCAM and the driver table. The
> udp_tunnel_nic core is never told about it and still considers the
> ports programmed, so the Rx tunnel offloads silently stop working
> after the reset. With VXLAN port 4789 offloaded, 64 flows that differ
> only in the inner headers are spread over all six Rx queues of the
> test port by RSS, after a CORER they all land in a single queue, the
> same as without the port. Removing the port later trips the WARN_ON()
> in
> ice_destroy_tunnel() because its table entry is no longer valid:
>=20
>   WARNING: ice_flex_pipe.c:524 at ice_udp_tunnel_unset_port+0x56/0x280
> [ice]
>   ice 0000:04:00.3 enp4s0f3np3: Error removing UDP tunnel - -5
>   ice 0000:04:00.3 enp4s0f3np3: UDP tunnel port sync failed port 4789
> type vxlan: -5
>=20
> Call udp_tunnel_nic_reset_ntf() once the main VSI is rebuilt so the
> core programs the ports again. A PF reset keeps the package and the
> table, so it is left alone. No rtnl_lock is needed since commit
> 1ead7501094c
> ("udp_tunnel: remove rtnl_lock dependency").
>=20
> i40e fixed the same problem in commit 1f190d936948 ("i40e: Reprogram
> port offloads after reset").
>=20
> Fixes: a4e82a81f573 ("ice: Add support for tunnel offloads")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 8c4b0fbc790644..f2121e79fca993 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -7859,8 +7859,11 @@ static void ice_rebuild(struct ice_pf *pf, enum
> ice_reset_req reset_type)
>  		ice_rebuild_arfs(pf);
>  	}
>=20
> -	if (vsi && vsi->netdev)
> +	if (vsi && vsi->netdev) {
>  		netif_device_attach(vsi->netdev);
> +		if (reset_type !=3D ICE_RESET_PFR)
> +			udp_tunnel_nic_reset_ntf(vsi->netdev);
> +	}
>=20
>  	ice_update_pf_netdev_link(pf);
>=20
> --
> 2.55.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
