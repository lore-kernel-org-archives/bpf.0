Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793045256;
	b=oEB/U/JHYgp/wAVs9ckYVZ/F3EbQGfa8E0yWPsDz10QxvQoLFjlN8oPLHL3PevCcGijs
	 aGl18HQFdluVCWKWM7Sjq2rFg9qJTp97RaXJV/zgpza6AcnpL2fbLvceoRI85UVB4vR9E
	 S56LVPTX1c6WxGMjLt0NF+qMOZjzyBTXeBMJ9Rmqv+piVwWsA9kXyqIBPYB6/vdID2OZG
	 iFa3v59pxHOP2RVYSABTxYmEr/6uOJGVcKkuQOyWGpZmt43qLxNvevaYYYmMy8x6iUQ0v
	 sWm2l0OE1KugD3rnuSa8PCD0GcAp0IZ0O7MhSh/r1XCZv3Xak+ZP40Jjf0AVhyuS3vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045256;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=acFF/TQDNG09OAl6is2yNKs3kqE20j5vclu8Q7VgL4E=;
	b=oE5uIkSeLhrf1MZUY7yG6oQXD8ulUs8sjuGwmpp4WTeTmdxD861rw7hvEz3dELk39oba
	 JkKUs+R4KbNYO3Pn8/dXaqbUVqh40PipFfpcg4s1WNHg6xwuxCMQ1kYXHVxSJG11QdVva
	 j2/BXFojjFGLefFBOVqoVmzsRNir7zXqF3TBKt+7Vdltm6OoIycpDljnoM0tIsQAPTQyW
	 J+XOxcXN8+mpXPNSu5MQjc10j43WXHY3B2VELP2kfQnPvIkkgoRrJi/wNscqBQt5L0+e0
	 2R8220+VwYE6oiT01nkb+GMrxK2ii4vKQi9cTcXwReCryKrNDGtP8xcTH71huI2L+/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="K/hGtRrT";
	arc=fail smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D716606A31F;
	Mon, 26 Oct 2026 20:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D716606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K/hGtRrT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793045255; x=1824581255;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h6AMeoqQmQCpPsSz5/z58HQNgqWBPFuOqXQjt+DALa0=;
  b=K/hGtRrTLtgj29+Za7HBWIOva4MCpfzo9ENtToBfcDG1vPu82HQaf35L
   1Z+4Sw4Bgovcqg58oJMCW+wiLa+SB5fsCrEk4h+ZpucmsFH8cOxyvrhjx
   VimT+R5pxauB+/cOnn/21vCsmckHLvmbf4CxEe1ysqlPuxN74gfg57cSf
   S818DfQBARug0gBxqUIUnxei3XWkc2Zem5IGg+n3wZSb5t59xSxiR6zLc
   PNvVeaNMSOnoyS48BcMTZIBgbGsCHKAjaYQfTdceVTVcHVs8TPzNQ38V0
   TvW7G5neAbJYByhAn9Hpabwr3BoSbMJmRSjwAklTSzf7Ld05rmKbYZZNB
   g==;
X-CSE-ConnectionGUID: 4ugfOPjWQ7S8CZbhJZyiJw==
X-CSE-MsgGUID: i3Y8MElwQ+m5nKVb7f9EuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1744250"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1744250"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 13:07:34 -0700
X-CSE-ConnectionGUID: JbxF3TuxR4KXwvyVj6fekw==
X-CSE-MsgGUID: iSXn7WUTRYOMiZccRzjU/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4310026"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 13:07:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 13:07:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 13:07:33 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 13:07:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCd3f1MdJgMHntk0Gb1+SUo6Z2G/gxxbL2FNET+F1aD+S4IkjRICOne2Xf5emtqYuki8ht9Uzjo2AQ/qVryLBAs1w/jpbFFo3BUYcmS+DDAkVSR36r9BHmLnGtVGQBP3lK8C5HzLBcYgC5T79eN+31zSF7/W3Y+b/x4I2ue3rEGKry237vZw94MXR3TGeuvJyIhLietwLnJPLenfh8k8K/EvKs8GtqiQX5CuxbAUNf7Rv4CQeoNkNlKlCO2W6Hegf1IF+RNmlsey1o+L/jMxF6AybZtvKMU++GQaycZ65ceTGxFsINaxXvXNIDoi0eeASeJTiCbJYdvkERyISbLYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acFF/TQDNG09OAl6is2yNKs3kqE20j5vclu8Q7VgL4E=;
 b=akz5tYbkYxu8HAyde80bpg1eTvlezIgavM6FOKWcpRwuZGLW5LsSHUTdMs2t3T2H+8VARJYy9fK5PRp+oIq+N536W58oATgUjrH9qZ0+qR6GZ3agDosxb51BqTX0MZtOKip/9xX+VZIIG4cNZAefI47dgRw/m3MQwZV/XVU/LGP4X5qUo+rOrzhcz+Xfe/AGbzmPdFeKTxKFrTJnigivLeSkPRzFbSUr8ECChWvnvj8u0zNu4Fidu/j0PiKbYHAShrPYlFKMufixWyJ70CTwKq1ERYf5hJzaOh3vu+WFSbyG6s8cJ8DpWVz5nvliOfYiSB/p5Ramkv8GadbxFIcOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by DS4PR11MB573126.namprd11.prod.outlook.com
 (2603:10b6:8:509::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 20:05:53 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 20:05:53 +0000
Date: Mon, 26 Oct 2026 21:05:42 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Paul Moses <p@1g4.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] igc: return XSK frame copies on XDP_TX failure
Message-ID: <at+yluh1NVm78gn6@boxer>
References: <20261023141317.3904442-1-p@1g4.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261023141317.3904442-1-p@1g4.org>
X-ClientProxiedBy: DU7P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::7) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|DS4PR11MB573126:EE_
X-MS-Office365-Filtering-Correlation-Id: dc722ef0-8f57-4a4f-3192-08df339c89f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|22082099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: eLfSkLA+EmvHtU6/SGnlT8GUVhi89r7KuXR8HqD+RlO+wuskfoD+QPbWTME711Gi6RKZ3Bh1eNbiMgC14elzxUKdtIjBTJ68wG/i+fTx/JoVFL82fmL6bs51icktiZvR4Gzi7nlEwffLvmuYncN81ZUExdVmrw4+phxBBnBtUhQfHcwzN7vjGCC37DpcHzXx9WKYmAtlRi+xR5yIpbjPK2U55WHAbjpRaalvgJyPFwykmEeTzbwfSaASrDQ/nmNylWv2ksqdQjtfC4ivAXPreoCsTrKN8+QuCLO1/hZ1yp63lUyN9a4UMXNItiU388iZcLplUGfE9z3+L5U1WV/m5olnYaDLXRPgz5+RvTy77mIJNsDr2EuaoQQZyW0v9Ae4jZikuK7mu6OLXlTKl4L7B6MGM2Dm6VUEmvHXLJkGovOL/Yg8XDAivro54hbZqXV8mnqtO34r64726tP1wMDLQ00S88ciQ7Dc6yf4Qy444IRQtaPdD4IrNSPTIpVGIvZwvIAyMQMtyTCVGUo35vsmYDr5oeythLP2Zt8sadETowkRfIhxpbWh8r6zZotf479oFm6DhzEPn7bHmynkMzRooFe0DXIVprUFUISD5ZDFDXgfFx6RMAhbTTSOsP6s5sko8f/SjF+9wPDR+gpccgEWRPxxCrnUYFfkqkTdMxRBtyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CJWKJJwIgE8qR+u2mVCmIaFVfwJttneQ2WCiSNeMGG9UwG9gt8ZRI4DQxoaH?=
 =?us-ascii?Q?G/4bcL5TiWTFxrIWqKNUORIviKAkpUCCYArRwlKEBiEhsIH0Rh0WIL/ksmuz?=
 =?us-ascii?Q?1oMTXfjv0zhDCKg/C2dI8UKcJqjfjCtmGCnqxnY3DPYmTtelfUquZhhGR8Bt?=
 =?us-ascii?Q?RaUzLa5hWmeF1FvmXGq59wht+0L1EOuFhU8KADWuQ8w4XBmt32OWH/iKNooe?=
 =?us-ascii?Q?IDFG1bzZb6+64SIh3RArzxd6qrtZA6kVOmk3XjIkltU76jS8jAeQvgOcafbG?=
 =?us-ascii?Q?5aK92CHIkOiSkTONBs5lmj3uW5bFYN37iHZN/xzKZSuFPRmL70zhvaczotnT?=
 =?us-ascii?Q?Y/4Sq1RSs9TDIU2KBF6CjHmTfRYxg+s3wtlpDcB5F+JaWL1pxwLdsvL+KALW?=
 =?us-ascii?Q?ciMTV6NzQwxXR4ghNllASfWlfV9jx4O4GqQSMRlUdu5t5QUN25UV+qGTjkLF?=
 =?us-ascii?Q?AfM3E8GBPW6mR1TwPLl9fPjyIHUCC2vn1RaJhgz5FEmRceqb5oQqrpqPjjmZ?=
 =?us-ascii?Q?s+vPBb4q281+faVjhasO7aFVNEdXjQ5GPUjlmolA3OytxXAlr0ohEuA7f9ro?=
 =?us-ascii?Q?Sqs/6LHpIdnF/SMTqCmxvylYegi+rwRT/GBb22pfwT2WSIS2ifRm12exkFGQ?=
 =?us-ascii?Q?h9DScI9Kg4bmYlO77S1xEmEOljeu9vczRku7hn6bj0psj/dFfQQ3gjqtQd+4?=
 =?us-ascii?Q?bDBpu97oGfBjlafy4zGDtnRf9tdq5ArOM1gqMnjbL+nM3vue+aQL5aj7zmLI?=
 =?us-ascii?Q?gejP+nc9b5jA7cEAZzBPeDgxVxvC0WzD7OTOWxIjsnldntv0jTdFpu60wMuT?=
 =?us-ascii?Q?gUnCwmskrYG5OxIiFJMFCqFhJ3MZUcRo4ljcitK73z0QtDJi6oVetDKWOq/y?=
 =?us-ascii?Q?XYdEoxw1IAUBnXlTy5UaL7BG4AJNCX03S3dUsnEsnRCdquGCkL6gvcOa97AH?=
 =?us-ascii?Q?8JbHhA6wCpU0h2GLmQg4Zwc77IR2OhKXFCQQBFn4yDMPts+Kxy5h8Qgyj5jr?=
 =?us-ascii?Q?Uj4E87bamT26DFkNKaQYdMa5edawPS1vCxlTkjHoH36RSuLG28ZWouWxf3IE?=
 =?us-ascii?Q?piYK/KH0+3MIg55Zw2RBRc6jDgzi6+C5/yuT/VYV12jprSa3sdy30f9aRvTw?=
 =?us-ascii?Q?4L/5iDNnYzAZpJyq2YqHotZ1rbpzPXsFMTF4iFbPB2d+mymEdG3IVLPySArp?=
 =?us-ascii?Q?Lr8Z4qREgmC1f7UwPbGVIBPPVxQuUFnfhNYZkh8x5uGTDhnM6TRj8O9YV1EC?=
 =?us-ascii?Q?2+n0qQ2hV+xfOw4psBjMSZH4zXrjr6TuS20uJPQ9wSwhXaE2qh5rJrAq7sKY?=
 =?us-ascii?Q?H0wscMOn/S33zpBsM0XJ8yo2mstqDmWK8UvtXEAvE0q4tGsfJa8OaDihhrHE?=
 =?us-ascii?Q?lOykr6ktkzQXvKeCBhaUE2q4TTrFai3irjNoZBOK/9Tgf8JOn4eUymhgNMRr?=
 =?us-ascii?Q?ee8MPAZX0T9vX69bbiJFTXgiWScgS7Cw9zFrAl6QWduHDUNdwoYJZ8GUOLqo?=
 =?us-ascii?Q?dDXoqFa+++/2oFuQfMW1aXyQJkp0Yoo+FfuetVVyw3SO1LHYf9bmRzxcwcQU?=
 =?us-ascii?Q?+mR8HBDqkR2Fxitbvua/+7gxKvGkRV3HOzNCP5SY9MjseESbpUjvtU2jszQD?=
 =?us-ascii?Q?WkiCCGiHTNUvuier2rVmtjdSZc94x0n1T1YbojNeM+QwoRcoISmVK46h8kb2?=
 =?us-ascii?Q?LR9p9fnugIpzaDvLBWtJ8ocbCUBnbHnne5W3030M8SMkdYCw1IaO4tYEpER2?=
 =?us-ascii?Q?jkGpTgIvp0sJQj7KmBIiI+MOqjkczzM=3D?=
X-Exchange-RoutingPolicyChecked: E+4i4seK6yZl7ye8zYJdOKOa6wrNAUiurRLVD94jr7YyqCnXpYLfZI6Z+a0frXNyix16svukF3vU3FCBfSOx7kKyemuJPrilXuslFg2KVN7+91ubO3O1VVyoduo049un+znAVz5zHKa/v9Iyln4je7lAVB6uFTn+DSDiY9vU+9gXjeRzmpMVJ0y0A1gYxNyWZk65eUervAsRYfttKP4APuTZvwj5iOwSWo1oUkSc93Mf5qDXekJ0v8v7hYcF7akpWjWwovI0LWx6EMk2zPBPEP8D6GjUZK9Mb4vzCkdjz9BSlIZOXh320JROTc7VlHOu7zJev62WyBUEhiyeHaUwKw==
X-MS-Exchange-CrossTenant-Network-Message-Id: dc722ef0-8f57-4a4f-3192-08df339c89f3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 20:05:53.3230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CYv+jUQmImqOXsgdbY+8ibwbmSGxO14+Y32DxbdytmIoYW7WnUj+I7UgaaxBXwyrFA/i3ayJCiGQMsJs17aHQqg92quwdaAnXehm2Xcqqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB573126
X-OriginatorOrg: intel.com

On Fri, Oct 23, 2026 at 02:13:42PM +0000, Paul Moses wrote:
> Converting an XSK buffer to an XDP frame allocates a page and returns
> the original buffer to its pool. If the TX ring is full or DMA mapping
> fails, igc_xdp_xmit_back() returns an error without freeing the copy.
> The RX cleaner cannot release it, so the page leaks.
> 
> Return the copied frame on TX failure. Save the RX memory type before
> conversion so native frames remain RX-owned on failure.
> 
> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---
> Tested on Intel I225-V with baseline and patched kernels. Physical
> pause-frame backpressure caused 46 leaked copies on the baseline.
> With the fix, all 72 rejected copies were returned once and freed,
> and all 192 copies were accounted for. 
> 
>  drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c..39263fd04aa9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2487,6 +2487,7 @@ struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter, int cpu)
>  
>  static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
>  {
> +	enum xdp_mem_type mem_type = xdp->rxq->mem.type;

small nit is we require a concept called RCT (reverse christmas tree)
which makes you to order variable declarations from longest line to
shortest.

>  	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
>  	int cpu = smp_processor_id();
>  	struct netdev_queue *nq;
> @@ -2504,6 +2505,10 @@ static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
>  	txq_trans_cond_update(nq);
>  	res = igc_xdp_init_tx_descriptor(ring, xdpf);
>  	__netif_tx_unlock(nq);
> +
> +	if (res && mem_type == MEM_TYPE_XSK_BUFF_POOL)
> +		xdp_return_frame(xdpf);

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> +
>  	return res;
>  }
>  
> -- 
> 2.56.GIT
> 
> 
> 
