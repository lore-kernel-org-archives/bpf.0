Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D53E8C56;
	Wed, 23 Sep 2026 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.13.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142389; cv=fail; b=JfC9O195+H169RfBLRenm0zuD61eDGuGmmAM4YGrJFySkGjlp77uYOiRSgEDZW0jxRwaiLJpUG/fM+yS4AYE8euGwLxivVpaz/VqxksgOZOh/n88H/IV9ZLKpcOT4t65Zyqwe7YGqW5Lis+xLaRZMbig5K8L8gzxogkrUUZy11I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142389; c=relaxed/simple;
	bh=zX7CPh475azDVpUZMRnXRECSwxDtPXolJS+s6IyqRlU=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FRSURie1GlI8f8rWbaPi0Zyf9S1es76pR6XXI7dChyOTQIxzCs6O/XrauBPqLvTeoRyvEM++NE1+T7+Ct+EeIEg8XRr8TF0DuhWuTctMYkCLanbjnLrr5Cg4+FoYwZwAsLhi1ifkodCR41Reb684Ynbqjq6QWhprMY3rOyrC64g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DWAnmo7x; arc=fail smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DWAnmo7x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790142388; x=1821678388;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=zX7CPh475azDVpUZMRnXRECSwxDtPXolJS+s6IyqRlU=;
  b=DWAnmo7xwrSu5nwspN9tIssXt25GjqQdzKrc5hxrWMku7L/NOLGVfW9h
   AGcv4fZq+xDp1J7sVZvET76cOqIboA84ZxO3YPr5jgORJKYQ6DyX/W6Fq
   +lewjrXpKCFVfL0RnDfZN6+0lJKlV7DuPFg6ynsWKp9NsFm082erkVv5Z
   hwftXL1CYbjaZXSvjsbNgUppwEc93H4ozlfM4V5cOfNucdZz5Bq0GlRVF
   R/RsPeXIGa8ZeVjn5HmJNWK1q7Ev/YqnUBwK8/Z7p22Vm+ZW90owxa5da
   x5cE9IaRUo2jBykYvl18P98dQq4g+JhIFDu9Ai47bR0WEFKD7vtFfAgj8
   A==;
X-CSE-ConnectionGUID: CVfKPyG2QBOUY711WZ/kJw==
X-CSE-MsgGUID: uOwHaidZRsC4Kz1jdKKN2A==
X-IronPort-AV: E=Sophos;i="6.27,117,1787011200"; 
   d="scan'208";a="29383402"
Subject: Re: [PATCH bpf-next 1/1] bpf: btf: add btf=off boot parameter to disable and
 free vmlinux BTF
Thread-Topic: [PATCH bpf-next 1/1] bpf: btf: add btf=off boot parameter to disable and
 free vmlinux BTF
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 05:46:27 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:9056]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.208:2525] with esmtp (Farcaster)
 id 6ebcf10b-acc6-4fc2-9560-490c333ef766; Wed, 23 Sep 2026 05:46:27 +0000 (UTC)
X-Farcaster-Flow-ID: 6ebcf10b-acc6-4fc2-9560-490c333ef766
Received: from EX19EXOUWA001.ant.amazon.com (10.250.64.209) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:46:12 +0000
Received: from BYAPR08CU003.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWA001.ant.amazon.com (10.250.64.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49
 via Frontend Transport; Wed, 23 Sep 2026 05:46:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFrFl03JG4BX7ntqO6XqDF778rAQuM+nxC9ELRsZRr5qqcJRfrpDVnid6H/clqWZg4/JieiHatSc0Majrz14i2PYbUkIMx3rlnrW1J+qipBsXr4A4YuQdrHvfbZs19uikHbWHyA1x9tp1KXsNLo3nfQHTTz4FRw4a9EhJoZgDN1d+1JAb0XPoBitPMpKrcme1/h6JK4yhSWX/q9Cf3gIL/bUi69lGKNZ3ELUQd5FUKByzdHgQZDPhQ6nKtVfMT1BlqUOCnFCGXqKqDN+G8WxzJFBAfHVMc1TBIGEb38q6atKcjYX67ejMFmxAdCjTzjIbtVjyb8TUX5hK2ldWG4euA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX7CPh475azDVpUZMRnXRECSwxDtPXolJS+s6IyqRlU=;
 b=J1refF6nGkr1R7Q3RAtmRvm1RSjF8ANldIbhsSxwYzs/dAFL1QgMAxEJ1gniswu87WVRgq38DqD+SaAhOCfHz1VCNt6/wk6YHy+wukw/EgC7xUiOEXz39Jh2r8XAea+XDECs2G3O/Mh/r3hF38aw5Tq6ucG1F4lxv1J/XsZYv/rJqBOT8WjDYBjMP+QZnXutkpXDszPnFpubZUZo3GyIe+my6gmBxllPvailnRKBkS4Zl2RFoC9VDGmR3/2ikIohxXrQF04KYejT/yCX+f1mKTOr9KRvSkxFwd2uRBYO0e1XM9hTUmReESTI/3IRAMpGd1ivE0AMQRHCyGgLbVSO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MN2PR18MB2669.namprd18.prod.outlook.com (2603:10b6:208:10a::32)
 by IA0PPF30E686C57.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 05:46:03 +0000
Received: from MN2PR18MB2669.namprd18.prod.outlook.com
 ([fe80::7a22:7d4b:a619:1a8]) by MN2PR18MB2669.namprd18.prod.outlook.com
 ([fe80::7a22:7d4b:a619:1a8%5]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 05:46:03 +0000
From: "Wang, Jay" <wanjay@amazon.com>
To: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>
CC: "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Mohamed Abuelfotoh, Hazem"
	<abuehaze@amazon.com>, "Doebel, Bjoern" <doebel@amazon.de>,
	"jay.wang.upstream@gmail.com" <jay.wang.upstream@gmail.com>
Thread-Index: AQHdRkfPPs5hrVoBI0OIjl6KqnCeG7bRsjiAgACogACACOEBAA==
Date: Wed, 23 Sep 2026 05:46:03 +0000
Message-ID: <8AAEFE7A-9167-4DC9-AD57-DB92742F57F7@amazon.com>
References: <20260917000201.25581-1-wanjay@amazon.com>
 <20260917000201.25581-2-wanjay@amazon.com>
 <DLH7UY9PDSQP.2AXEGNH838JS0@gmail.com>
 <C1DF89F9-B9F4-4FBC-9B94-E250AAAFEDA2@amazon.com>
 <33592fca-88a8-44aa-8d94-40e1e604554e@oracle.com>
In-Reply-To: <33592fca-88a8-44aa-8d94-40e1e604554e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Microsoft-MacOutlook/16.111.26071325
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR18MB2669:EE_|IA0PPF30E686C57:EE_
x-ms-office365-filtering-correlation-id: 80711833-053c-4fa6-9962-08df1935f462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|3023799007|11063799006|10067099003|38070700021|56012099006|4143699003;
x-microsoft-antispam-message-info: /aNdkG7mjorAw6gWaoRG1hJE/QwydvIVkxexeHwiaaUI4AEub2TkePe3QJ9lZj6ya0SIcgekt4MFBF0U/31CMHog7tLVY4TmWHJkQAW7ac0E0BIjlkFCos1aJWZKmcXggBGAtv61OUWID/idP0o0gL2Jzuq7Xok/EFSRrQ7VFJQ/yRA4O0JgvXz5+aYjws3j6mmXcbCqbbzB/iMrh2ik21hbgphguKWX6XrnqSBzeEWsj0Bkk2uPGP6RwrzUpBHGhFZWl402IabOOehg/6S4yeMTqoVpSxD/n60mmUADYMEbZXmv6Is4DLzsI9fEfYFYkAjcbxWXlo3184bChT/ZuT1Q1DlBHmDg3utsbWZ0mXJirLDAHPkNCBBium2iz7FPUcGN0YiHlPUkQZNbdmcfxIedrh6LgVA0a6GgKJTsLSxu6KoPCpQro+TCXIAj/sIX6zaKyvgrKhDjAdnslSIt7z74kIcupqIaYBjvhs2ZRZhqSGvjTKmBooTYIGAQCISe1S4ihI4R4LPAoqqo6o8rw/5g6/P/x9M1epIkAya1z3WBJWZi5K9ojzUyQi9ysnT/b7doOS+HTj2+uWsCKoBZShorhhD32+7xvKXqx6a2DsObbpY3jsJ1xlEqFfcnItPpcFSGWS226ZxmljsjRp/kts/A4kT82w0InCax6co+ds7gHYr8qwptIYZDcegXF63db/HtZi654ZDj+eQeAzZ2XaRXSFGVSquOAIyESydMZpo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB2669.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(38070700021)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmRyczlBeFJuVFhKVXdnZWVkd1E3QitvcHdlWGVFRE16MVlMalVUYXVhSDNL?=
 =?utf-8?B?VUl0azU0b1B2eTNpa0VMT3VvbkVaZGROSzR6WTd5RFpwMytKMDRXZm1UaVlj?=
 =?utf-8?B?d0N0eitDUFNMeElseHdDOVVVQ05SclJJSkh6cWlxcldHemZlK1JVUUR1WjFi?=
 =?utf-8?B?Z2pPeVl2OHBzVTYyL2RsRW1XTU1kYXR0S3dGbGRPMWlLcVBzcGpKbjZUSXdp?=
 =?utf-8?B?cW9KQm8rN2hBVWN1QW1ndVA2YVdIaTJwbFlqbEVuNHkvYXdzeU1JMWJmSGdN?=
 =?utf-8?B?TnJBd081RXpRZzgzZEtKMGhMYlFFYmFDVy94aWl6WS9jbFh5MWljam9DWWFa?=
 =?utf-8?B?S0tzWDhkc3EyRktiSWxpbjY4clVXSjdmY3pEcFNFTXVYbGh0eXFSeWhBc2x5?=
 =?utf-8?B?TW1TZ3N4NHhZelM4d2lvZlZNVnkwLy94T28wUlM3RllzdjFxWktzbDlla3JQ?=
 =?utf-8?B?dXY0WE92K1N1NytVU1puakE4MDh3K1hHb1psdW5mTWN3K1ZlM1pTbEptNlFY?=
 =?utf-8?B?QTJjdzFDUzRobjRlR3hBZnA5S0RDSWRpcU5ITncxd0p5SnA4QzQrU1JBbHdP?=
 =?utf-8?B?eW9yTk1LMWdITEdWdldQU0RTUzMvblJLZHJiMTFWTVViNngzKzJhTWIvRVZG?=
 =?utf-8?B?R2ZPcDB5WXlwZG85NEc3L2FCTW9aMUpGMGFwMDlPZ0F6Ui9YRVc2Y3Jybm1y?=
 =?utf-8?B?ZzlLclRvRzFKWHpyVkdmMkNiZ1c5SCs3V1ZDR01ERVRkd3IwUTRLclNrU1g3?=
 =?utf-8?B?SEN2OFZzUmxNdlhYSG9mLzlVYStmYVVjRHB5RlA3R3kxdTJ2ZE1KQXh5WmF5?=
 =?utf-8?B?THlVaUxncGxUQ0ZrejI5OFltZVhjZTVMR0wrMGxDKzVhclVSQjlXeS9Udmxw?=
 =?utf-8?B?YjZyL2lOYTVVbjZxUUZ4akNHV0Y3MUUrZWVwRjdXa1ZHank5eWNHbUEvaE5s?=
 =?utf-8?B?MGFpN0lRRXFsMWpFOTNuNVhrd2pUTFd2TlFLQ0tTRjRWbjltNkVVMDgrSHRW?=
 =?utf-8?B?ZEVPamVWV3phbHNyeFQ2M1BRbWpzREhCanVySy83ZVB4dktpZm5VZ2FiQktt?=
 =?utf-8?B?ZCtEZ0NWZXhSeFhWbDY5ZkxpMHdvSU02N0FobUh5RTlSZkloRVNFbGI1R3hH?=
 =?utf-8?B?TGhnNjdwUDdLdjR0VjNBQXByeWRKeThZTFowRGcwMjJ3WWpweUxaYm1GT0Rl?=
 =?utf-8?B?WWl1Y2pzMzlKUXdBTWFvdjlUZk9KN0xDdW15a3VZR2ZsTUZKUmFYeW5idzdp?=
 =?utf-8?B?cVcvMmRNanZtdTQ4OVZiWFB3SkczUlZUcmxtZ1ZsYjVWVGswckJsTlJpdGVU?=
 =?utf-8?B?LzVjQmtDeDV1eFZRNExjeHdnaWFwdEpuT0NKaDE4c3dEaUExWjBCS0J3QXF5?=
 =?utf-8?B?TERPT3U2R09MUFpTQjlQajlLK0tXa1A0Z1FDS2lqS2RxUVNab09UMklNanhv?=
 =?utf-8?B?b081bVJaeTBhRWVOR29oTnF2QW1XbVVNLzBQOWoySmk0M213SmJBSU51bXFG?=
 =?utf-8?B?VzAzU2xzdnY2SDFKano3bmpLZlo0aTA5NEpWek5YRGppNGZxL0plMW4ybk4y?=
 =?utf-8?B?WDRGSVlnOXNoR3FhQXdhR1dha0Ryb1RyLzRLMGJtTGVMYSsrc21iTmRBYjlk?=
 =?utf-8?B?WlZabDM1ckNlczZwYUdNWFZmVjlTUEdRNjd1Y0JvMVY0MDdveDVqQzFxa25l?=
 =?utf-8?B?c0tIZFNlaU1lVDVJNVExM1BWWkNaN0tSdnFpM1dSRlZDakxiejE5eGV2ZExZ?=
 =?utf-8?B?WmdCOGNvdk4xeWlyWlh2andpK09DZVBXTVpMOHhLRmhRcllMcEJjNWp3Z2VP?=
 =?utf-8?B?Vm9JN3ZmYjRiTmtxVEdEWS9lc0xpNFl5NVF4VlBNWWo2VUlTUUhuRW0rVS9R?=
 =?utf-8?B?allXc3RMeFd2azk0cG1ZM3FmeW9lOG5MOVFkZlc1MFIrODRJMDU4SytGMWtl?=
 =?utf-8?B?VGljUlFWYmVTaXZjdlU0dS9zYjFVdVp4dkhpL3Nna0VyM1FyU0ltblIrYi9V?=
 =?utf-8?B?d0hkNmxOeWVhZWFzWUxsMVVnblJyeWxXSi93a0syZjBveGlsWWRTaXc3dEhq?=
 =?utf-8?B?b3ZkdGIxd0pXWjFkNGQySW91c1g5ZjZYb2NvK1RlSU93VFNyeGNCT0xYeksx?=
 =?utf-8?B?ZHdLTU5UMXMvdnc1UDBQQ2FEK3hicnpyd05tNTZzb1RtV0tuM09WeG9UQkdL?=
 =?utf-8?B?S0xEb2VsbnFZYm1ENDNLK0pleXpEdUVlVDU4TkNXQ2ZhdnlSRi9NYUNPNDls?=
 =?utf-8?B?S3gxNUo2ZFhLdDMyRXFXTHhFNWFFVURha25xVmkxWGUzR3ZxcWlubmpOMFVh?=
 =?utf-8?B?N1pxdmdid2NlOHk3MmFJMVJJbUNMSzFwR0hMREh1dm5ibmVsUzVjZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D65C764C79F1B749B80FA01AB21A8AE3@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AA+Mj+O+hdzx3Iz3qEtw67o5AyR6EuOkSyKSZhdc5frOXWo6aWpsODuvEp1NZfeTYAZ8EAyeCP4XJqSgc6gpkYE5rwv3E0ck//IR5HCpisGrOJrRICxyjHd4WgSoLUcokB1gAPQv1C9aBjnghxXabcXhjUYOXkR8Eqt/HxCoJZLcEyO0QgRMsO00+f+bYqVz0nYNdKEc1tmc5hFenKa70xxr1lME4qgBWLMduAywaqPyFdL5hxcugdpn3F2xso+jW8XRCM9/lltZoAb60D34b/vxgGOxpudHJUNjdyChxquQ7z62UGXMc1rrElGH82NYF2pEL+rF8BhI2jgIErrKGw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB2669.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80711833-053c-4fa6-9962-08df1935f462
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 05:46:03.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OC3W4ZgR0Uv6eAl9dkZhGFg9DLlxdo6NqUA669rZ2bN+exrAIvhODxBLHbKHsujutXV/zTIj2sVCxCRffHtSrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF30E686C57
X-OriginatorOrg: amazon.com

PiBUaGUgY2hhbGxlbmdpbmcgcGFydCBJIHN1c3BlY3Qgd2lsbCBiZSBob3cgdG8gcHJlc2VydmUg
eW91ciBnb2FsIC0gDQphdm9pZGluZyBtZW1vcnkgYWxsb2NhdGlvbiAtIHdoaWxlIHN1cHBvcnRp
bmcgbW9kdWxlIEJURi4gU3BlY2lmaWNhbGx5DQpmb3IgY2FzZXMgd2hlcmUgdm1saW51eCBCVEYg
aGFzIG5vdCBiZWVuIHVzZWQgeWV0IGFuZCBtb2R1bGVzIGxvYWQuDQpTaW5jZSB5b3UnZCBuZWVk
IHRvIHByZXNlcnZlIHRoZSBtb2R1bGUgQlRGIGZvciBsYXRlciB1c2Ugb24gbG9hZCAoZHVlIHRv
DQp0aGUgbmF0dXJlIG9mIHRoZSBFTEYgc2VjdGlvbiBpdCBpcyBpbiksIEknbSBub3Qgc3VyZSB0
aGF0IHBhcnQgd291bGQgYmUgZmVhc2libGUsDQp1bmxlc3MgeW91IHdhbnRlZCB0byBqdXN0IHN1
cHBvcnQgQlRGIGZvciBtb2R1bGVzIGxvYWRlZCBhZnRlciB2bWxpbnV4IEJURg0KDQpUaGFua3Mg
Zm9yIHBvaW50aW5nIHRoaXMgb3V0LCBBbGFuLiAgSSBoYXZlIGZpbmlzaGVkIENPTkZJR19ERUJV
R19JTkZPX0JURj1tLCBpbmNsdWRpbmcgbW9kdWxlIEJURiBmb3IgbW9kdWxlcyBsb2FkZWQgYmVm
b3JlIHRoZSB2bWxpbnV4IEJURjogIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi8yMDI2MDky
MzA1Mzk0OC4zMDYxNy0xLXdhbmpheUBhbWF6b24uY29tLyAgY2M6QWxleGVpDQogIA0KDQrvu79P
biA5LzE3LzI2LCAxMjoxMiBBTSwgIkFsYW4gTWFndWlyZSIgPGFsYW4ubWFndWlyZUBvcmFjbGUu
Y29tIDxtYWlsdG86YWxhbi5tYWd1aXJlQG9yYWNsZS5jb20+PiB3cm90ZToNCg0KDQpDQVVUSU9O
OiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24u
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgY2FuIGNv
bmZpcm0gdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCg0KDQoN
Cg0KT24gMTcvMDkvMjAyNiAwNTowNywgV2FuZywgSmF5IHdyb3RlOg0KPj4gQ29uc2lkZXIgdXNp
bmcgQWxhbidzIGFwcHJvYWNoIGFuZCBzdXBwb3J0IENPTkZJR19ERUJVR19JTkZPX0JURj1tDQo+
DQo+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uIFdl4oCZbGwgZXhwbG9yZSBob3cgd2UgY2Fu
IG1ha2UgQ09ORklHX0RFQlVHX0lORk9fQlRGPW0gc3VwcG9ydGFibGUgYW5kIG1heSBwb3N0IGEg
djIgcGF0Y2ggbGF0ZXIuDQo+DQo+IEJlc3QsDQo+IEpheQ0KPg0KDQoNClNlZSBzb21lIG9mIHRo
ZSBtYWNoaW5lcnkgaW4gWzFdIGZvciBoaW50cyBvbiBob3cgdG8gZG8gdGhpcy4gSWRlYWxseQ0K
d2Ugd291bGQgd2FudCB0aGUgZmlyc3QgdXNlciBvZiB2bWxpbnV4IHRvIGZvcmNlIHRoZSBtb2R1
bGUgdG8gbG9hZCwNCi9zeXMva2VybmVsL2J0Zi92bWxpbnV4IHRvIGJlaGF2ZSBzaW1pbGFybHkg
YXMgYmVmb3JlIGV0Yy4gVGhlIGFwcHJvYWNoDQp0aGVyZSBkb2VzIHRoaXMgZm9yIHZtbGludXgu
aW5saW5lIHNvIGFkYXB0aW5nIHNvbWV0aGluZyBsaWtlIHRoYXQgaXMNCmxpa2VseSB0aGUgd2F5
IHRvIGdvLg0KDQoNClRoZSBjaGFsbGVuZ2luZyBwYXJ0IEkgc3VzcGVjdCB3aWxsIGJlIGhvdyB0
byBwcmVzZXJ2ZSB5b3VyIGdvYWwgLQ0KYXZvaWRpbmcgbWVtb3J5IGFsbG9jYXRpb24gLSB3aGls
ZSBzdXBwb3J0aW5nIG1vZHVsZSBCVEYuIFNwZWNpZmljYWxseQ0KZm9yIGNhc2VzIHdoZXJlIHZt
bGludXggQlRGIGhhcyBub3QgYmVlbiB1c2VkIHlldCBhbmQgbW9kdWxlcyBsb2FkLg0KU2luY2Ug
eW91J2QgbmVlZCB0byBwcmVzZXJ2ZSB0aGUgbW9kdWxlIEJURiBmb3IgbGF0ZXIgdXNlIG9uIGxv
YWQgKGR1ZSB0bw0KdGhlIG5hdHVyZSBvZiB0aGUgRUxGIHNlY3Rpb24gaXQgaXMgaW4pLCBJJ20g
bm90IHN1cmUgdGhhdCBwYXJ0IHdvdWxkIGJlIGZlYXNpYmxlLA0KdW5sZXNzIHlvdSB3YW50ZWQg
dG8ganVzdCBzdXBwb3J0IEJURiBmb3IgbW9kdWxlcyBsb2FkZWQgYWZ0ZXIgdm1saW51eCBCVEYN
Cndhcy4NCg0KDQpPbi1kZW1hbmQgdm1saW51eCBCVEYgYXZhaWxhYmlsaXR5IHdvdWxkIHN0aWxs
IGJlIGEgd2luLg0KDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9icGYvMjAyNjA5MDEx
NjU3NTcuODAxNDQ5LTE2LWFsYW4ubWFndWlyZUBvcmFjbGUuY29tIDxtYWlsdG86MjAyNjA5MDEx
NjU3NTcuODAxNDQ5LTE2LWFsYW4ubWFndWlyZUBvcmFjbGUuY29tPi8NCg0KDQo+IE9uIDkvMTYv
MjYsIDY6NTYgUE0sICJBbGV4ZWkgU3Rhcm92b2l0b3YiIDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21h
aWwuY29tIDxtYWlsdG86YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gPG1haWx0bzphbGV4
ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tIDxtYWlsdG86YWxleGVpLnN0YXJvdm9pdG92QGdtYWls
LmNvbT4+PiB3cm90ZToNCj4NCj4NCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZy
b20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4NCj4NCj4NCj4NCj4gT24gVGh1LCBTZXAgMTcs
IDIwMjYgYXQgMTI6MDIgQU0gSmF5IFdhbmcgPHdhbmpheUBhbWF6b24uY29tIDxtYWlsdG86d2Fu
amF5QGFtYXpvbi5jb20+IDxtYWlsdG86d2FuamF5QGFtYXpvbi5jb20gPG1haWx0bzp3YW5qYXlA
YW1hem9uLmNvbT4+PiB3cm90ZToNCj4+DQo+PiBBZGQgYSAiYnRmPW9mZiIgZWFybHkgYm9vdCBw
YXJhbWV0ZXIsIHNpbWlsYXIgdG8gdGhlIGV4aXN0aW5nICJzZWxpbnV4PTAiDQo+PiBwYXJhbWV0
ZXIsIHNvIHVzZXJzIHdobyBkbyBub3Qgd2FudCBCVEYgY2FuIHR1cm4gaXQgb2ZmIGF0IGJvb3Q7
IHRoZQ0KPj4gc2VjdGlvbiBpcyB0aGVuIGZyZWVkIHRvIHNhdmUgbWVtb3J5Lg0KPg0KPg0KPiB0
YmggSSdtIG5vdCBleGNpdGVkIGFib3V0IGJ0Zj1vZmYuIEJURiBpcyBub3QgZGVidWcgaW5mbyBh
bnltb3JlLg0KPiBzY2hlZF9leHQsIGJwZi1sc20gKHN5c3RlbWQgdXNlcyBpdCksIGhpZC1icGYs
IG1vc3Qgb2YgYmNjL2JwZnRyYWNlDQo+IHF1aWV0bHkgc3RvcCB3b3JraW5nLCBhbmQgd2UnbGwg
YmUgdGhlIG9uZXMgdHJpYWdpbmcgImxpYmJwZjogZmFpbGVkDQo+IHRvIGZpbmQgdmFsaWQga2Vy
bmVsIEJURiIgcmVwb3J0cyBmcm9tIHBlb3BsZSB3aG8gY29weS1wYXN0ZWQgYQ0KPiAic2F2ZSA1
TUIiIHR1bmluZyBndWlkZS4NCj4gVGhpcyBuZWVkcyBtb3JlIHRob3VnaHQuDQo+DQo+DQo+PiAu
Li4vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0IHwgMTQgKysrDQo+PiBhcmNoL2Fy
bTY0L21tL21tdS5jIHwgMTA4ICsrKysrKysrKysrKysrKysrLQ0KPj4gYXJjaC94ODYvbW0vaW5p
dF82NC5jIHwgMzAgKysrKysNCj4+IGFyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMgfCAyOCAr
KysrLQ0KPj4gaW5jbHVkZS9saW51eC9idGYuaCB8IDkgKysNCj4+IGtlcm5lbC9icGYvYnRmLmMg
fCA1MSArKysrKysrKy0NCj4+IGtlcm5lbC9icGYvc3lzZnNfYnRmLmMNCj4gfCA3ICsrDQo+PiBr
ZXJuZWwvYnBmL3ZlcmlmaWVyLmMgfCAyICstDQo+DQo+DQo+IFRoaXMgZG9lc24ndCBhcHBseSB0
byBicGYtbmV4dC4NCj4gQ29uc2lkZXIgdXNpbmcgQWxhbidzIGFwcHJvYWNoIGFuZCBzdXBwb3J0
IENPTkZJR19ERUJVR19JTkZPX0JURj1tDQo+DQo+DQo+IHB3LWJvdDogY3INCj4NCj4NCj4NCg0K
DQoNCg0KDQo=
