Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ABF3F1AAA;
	Tue, 19 May 2026 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187947; cv=fail; b=VK1ojUzTrYvI9McJy3KM09LsL/xqwhxzL9bXd8MRjR1507W8sJDBBdkQdVMabPM/54Cq0KTLs90gnrabp7QvhVwpTwQcHTn9D3x4uqKonJBB3dXU832lIs1mtRQi9gQ1fqMouI5iCBjng+d5bFL7ASmfH3uhAxNiDN4W9Lr6tZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187947; c=relaxed/simple;
	bh=5/jvY/OuhgGq/WyhetmzD5i56GMSA92FxF9ZH7J63HM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nzdvEMVjLE/qIdgb6jM7KDZQZocl3nS1EMux06hTPV9iIojNiU+05CAEgBZ1UlphxqTsfMq5WTc9/VS3WG5YCx7cPyNo82FNMILnVB7dsFfGJnE4q3bZKExwEvJm0ByM6GI065rmCBw5QuYVUSahm1CBDl61GOdR9RFydM7GBqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=S/nL1/K3; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="S/nL1/K3"
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 64J1Sihv3107524;
	Tue, 19 May 2026 11:52:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=apr2026.eng; bh=GK8qHZyly+BOgJ0GrDSI/d
	//r5SJxTLFDtXjCsnpWOo=; b=S/nL1/K3KjySRL6lNM0Tjfg5lymafA8QxoXjkH
	Ty44ja4rcexIp21JJQ6TpJo4M218OF06Cc3Vag4dQ5CoWtUtvukP/JTxOGqahlb+
	+Yk2BhL4bXBNTWr/Z67aZKOedCEBhQgr4JjlnZD2r3cCut9ox/NIYQJYe23WUpNK
	Gs5e44oh2vmi/85q1O7QwYm9OM6Ujtz+FIpPwe0ks+NWxf6h8YKA9cAXno3J+nYb
	t/xUI2kkB3cLPiAu9J3wTrtsks91VDq8ri73SofFYMIomG6YzIVkImKS/DKBJ4H5
	326RGdM5LdLenxoRZ9AwvjfHSDfEEwLgKmQA+65eVD9EfrUA==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4e6h5fch67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:52:16 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 64JAqD8m028472;
	Tue, 19 May 2026 06:52:15 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4e6kwwghwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 06:52:15 -0400 (EDT)
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:52:15 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:52:14 -0700
Received: from DM5PR08CU004.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 05:52:15 -0500
Received: from SA1PR17MB4708.namprd17.prod.outlook.com (2603:10b6:806:19b::16)
 by DS7PR17MB6611.namprd17.prod.outlook.com (2603:10b6:8:e6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Tue, 19 May 2026 10:52:13 +0000
Received: from SA1PR17MB4708.namprd17.prod.outlook.com
 ([fe80::9fa:d156:893e:6287]) by SA1PR17MB4708.namprd17.prod.outlook.com
 ([fe80::9fa:d156:893e:6287%5]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 10:52:12 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v6 6/6] selftests/bpf: tc_tunnel - validate decap GSO and
 encapsulation state
Thread-Topic: [PATCH v6 6/6] selftests/bpf: tc_tunnel - validate decap GSO and
 encapsulation state
Thread-Index: AQHc269lbRYrOf/Qe0i/Q+6SVPslT7X+0/mAgBZvtAA=
Date: Tue, 19 May 2026 10:52:12 +0000
Message-ID: <56083B7A-B13B-4133-8857-FAD8201F6D7C@akamai.com>
References: <20260504101759.3319427-7-nhudson@akamai.com>
 <20260505041431.CD280C2BCB4@smtp.kernel.org>
In-Reply-To: <20260505041431.CD280C2BCB4@smtp.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR17MB4708:EE_|DS7PR17MB6611:EE_
x-ms-office365-filtering-correlation-id: 029d9135-a2fe-4538-6f85-08deb594aefe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|6049299003|4143699003|4133799003|22082099003|18002099003|56012099003|38070700021|4053099003;
x-microsoft-antispam-message-info: tgIn96/YzCCIqKfZiEAFx/hd4HkmGHNgje85Ghr3vAo6Z/9Z/WMlZYMvK4ZM/ho7NvzwoDOcg+tgdfg0DuHjgAjvb18APTRdZmFIMuWzIlZqYQA45Vyir11vI3o9Z8TjyKLZ2GQ3EHv78CffUVsVU4gb7VV6Ty2Nf0salvub2QVaPl04fhRY5oRticAQdlpOKEt3JlNV0zswXXr7RWJdlyczE9LIlly3NQmzWMkedN+tG5LKvE7euv3PXvAMWrARa13f8oZu1Vi1gT+yVJvJBs7HQHYBciUZTGW3V5W1CmcVgIcRhYs37i0Czml8nKDil0I4Jp/1wS9auPUpHNuzAnCHkY4SiFdETZAFjEuw2RCIZ7KD8Oyz4KQWHO/pKbSuIDanoVNjEqmo242Ki6kWGXlklvM/go9Y+HJQC0dlQthqT3XIOWYVg1i779ZKEOL57+TOhDfIkLvpEsmECc5OBM8FMpvACEE8OjByzrk3Q9zw9fIjsDjGtPEzdVUrDULUuR24xxEIXGQNvt6DzN3q2W4I66Lmyb2gFGZonPPVYZ7hlTfO5PbgnXfd2FwnpdoooKzmMnclsZbpQyyUgkuNwUNk8a8ht6tdMH8IBXzyZN7rDCi3gI9Lp7DJ95fYVbS/G+UcI1EmiJDsKFzvyDYTZsC67hwFUs0lHGMNL0KC858Ywx/M3Ti9bC1s/fGZqlSslgBiH6Y49pl2RxfOLmnP3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR17MB4708.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(6049299003)(4143699003)(4133799003)(22082099003)(18002099003)(56012099003)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDdBdTZBdGJrT2JMM1htdENCemtSdGNmeXczazhWcmdzV0RRWU9hZnZtWWZh?=
 =?utf-8?B?TVg3ZFFobTl3UW13ZlNUYzdrcWVQSnlvcHhxblZ3Qk9uMkhab2Rhb2dWY09l?=
 =?utf-8?B?QWw3bDRWTE5sUlViSW5KNzRMYVZ3MG1qZVFVWEwyZ3FKVkVIeU8xS3BtaUpQ?=
 =?utf-8?B?VFNzS0crVDdhT3pvc1gzOE1BcjRzOTJKZjFMbDd2RmRVRjdNR2p5YTFQcDBo?=
 =?utf-8?B?RTYwVituSjVuNWgxVm1GUVQ5clRzMkNCcGJIOVVBcXBxc3U5TndKbmcrMmxu?=
 =?utf-8?B?K1VMTHRQaWcyT0NKMndBc3BlTVloc0ZKWU9CSXc0VHhaeWRMT1JaLzdpVllm?=
 =?utf-8?B?LzBrNFM3bjBuL2NlSXZGRExON3Z2Zmp2bnFOTXMwbGo4a2txNEE3ZkJhVUIv?=
 =?utf-8?B?VGpHMmxVVUpJRDhheSswSHg5bEUvbGdOVmxMVnMxdHdJS2NOR0lSMlZWWERv?=
 =?utf-8?B?MFUvQUhDNXBhcUl6YWhJT3AyejRETXQ5Yy9LUzNBN2NMMWlhR20rZklsbDhn?=
 =?utf-8?B?WTFiWmcrbG04UzMyVWFLMWxOMVd3d1NQLy9FNVFZcTY5dFZaK203bVlGOVRE?=
 =?utf-8?B?eTE0MXVQaDFOVVphRW9ETi9LWllCTXVqVmZpWlVXSTJTaDhWWHZuV2NkSEov?=
 =?utf-8?B?eGk2YzJHVmVUR3ZRb2FVQTh0T0U0c1RFbSt2T0I1U2VDcUZpMHpwRnlyblRV?=
 =?utf-8?B?RUltcGNSN3ZkZ1RQblVTTGFkSFpIdlc5MldrVmZIWmgyeTE2MHJWMkJKR2Jz?=
 =?utf-8?B?U0dvcDZLTmk1eDc0WEhTUS8vTXQ5WHRlWkJpblVXTVEyd3JYQVVDcVB2RzVq?=
 =?utf-8?B?aVpOZ3BYc3hmaml5L3pmcm5UTVNFQkpxRDdVRllaTXNqY2o5a3hHL1greXd5?=
 =?utf-8?B?M3Q3dzFKdFZ2ZDQ5MEFkb2N0bnlEc25QNWtCVXhocUF3anpkOFNMTjdST1FN?=
 =?utf-8?B?TnpzN0xPNTNxKzE3STVpaURzY3MyMG02WmZzUXpzMDJZNk96ZTZ4Q05zUDdy?=
 =?utf-8?B?NFRyTlZkWW5IZUtnaXpsUWIyV2VhMytsRHFQTlRNSXN3ekhUZmk5b2k0Tkc3?=
 =?utf-8?B?dzl0Wi9YWFQvK2JjMGZBNTJUVmJGVzRDTU41a0QyVCtjbVZFaXVuTHNzMWJL?=
 =?utf-8?B?V1RZdllCZWREYVg1SlFJM0tQUS9LYW13c3BtTkhydWpUV2tiTTFERGJFQkJH?=
 =?utf-8?B?b2tpcHhCSU1XR1VwL09scCtJRXROclp3TFFtQVdTbnIwYitMRDRSd3RTN3dy?=
 =?utf-8?B?NlVNZ1V2K3Iwa3dRWU1sOUgyWXpTd0FSQU5zVmlJRTFxakhhRSt6bi8wdUtx?=
 =?utf-8?B?UlNiaUl4NjErQ0s4RVo5RTFjSnE2eVN3QUgxSEZ0UDF3M1NJY25mUlZnWTBQ?=
 =?utf-8?B?NGozSjZqWEN2eHU1WXRldlNRN2tMcEQ3QnNEdlEveWRsc3FBOXFZQytYa2pi?=
 =?utf-8?B?bEM5cHpmb1hiOCtEdCtDWk1wYXVRYjRkWmpyM01WSld3U3FqblZVVlNZNGd2?=
 =?utf-8?B?aC9Yd2hmMVdZRnhqTVRLNVdMcGdLeGp5Z0Vtelk1STI1UytFbDdhYVVIaE4y?=
 =?utf-8?B?T1JhbEVXMkVZcmJ5L01PZEdHYzF2a3hGUXVoaU5KN0dzOUVieGdhVUI0djVz?=
 =?utf-8?B?SE1NLzJBRXAvWUU5ZEpldXkvdVNDeUtMUTZjS0lsS05lYnR5bVk4SnRWYmcz?=
 =?utf-8?B?dVlmdXFnWEVqdFpudXQ2WkhTdFRYMnYvakZOaVdpV3BmeFdMQ0VzOUxsQm04?=
 =?utf-8?B?a1hsdHcxaHVsaWpwR2EwUE40Y3lUSW0wNjA1UTdqNytyRUcva2RUTFJpcFBh?=
 =?utf-8?B?M3ZJb0hEMkVwUUllZEt0WjQ3cFdCNjVJVUhJN0xzczVVcnFlcFF3QVJGeVpi?=
 =?utf-8?B?OTh3S2VjbVorM0djWDRCUFQ4Z3NaejgxTmFVV2pJUUhEeG10UUdrYXdnZ2VV?=
 =?utf-8?B?WUpKRkhWeFptUlZkQ2Z0WGJNaFpnc0w3TVJTSm5RdnNjakw2OUt5Z1VXU3Zh?=
 =?utf-8?B?dXJKSG1WeHdmV0tUdVNKa21MQXk1VVVHQUVrYWR3MWdiU3Y1Z3Y5bnM3TXQ2?=
 =?utf-8?B?a3FmVnVKSndLc2hFcWZnYVU0K20vdERyT0tuSWFhMDdmQjI5VFI0U0paZWxu?=
 =?utf-8?B?WWkrQ1JOQ2hiNEtUQzZwcnJMVXJlWnRnaSs3cHp6TFh1elE3eG0rQkJJbzZS?=
 =?utf-8?B?K3U3TzA1emJWTDk3UVFqTVp4Nmg0Ui85YzFkUVJrdzR5VWl5Yk40RDZ1MUha?=
 =?utf-8?B?T25SQWV6Mm9QNm9hUHFOSS80bE5PMEhCMm9EcmFVaGQ1ZHkySm0zYmtsNlZq?=
 =?utf-8?B?Ym5PeEFXOFZjV2w3dGYrVzVmN3BJVjMvNm1wK21NZEw1WmJMbVJjWTdXOGlH?=
 =?utf-8?Q?92HKKzHKUbdxKVEOOwzCtcIF8d2B9aGnFop2pRXAYq1vS?=
x-ms-exchange-antispam-messagedata-1: 7SLpKi75qmaNSA==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KW/hA2ETOz13eUFTJ3rCGSM2slvUQPVL9tX2cQLQevgE2d3QjZdlUyDEgLO04bctYkyOXKxiTVQicdzxud1VDaU7ZKP1sdAVoXC8raD9ugCe28EdT51tCt08biKmwCstWYTI1huERsI+Ihj+QRCuT6L6Za3MagPA74vh+XDi40LpDAQ26RCygoo8iKkKsVOgK+BnSzVbOLv2BdVw6M5pl0uWtVzItjndrHD+WZKfYAvVKlaUbGDXv020r7DmLdqca8aVbhY5v2aHfW/ZlqRbaDozD1aVs/hADDW66vztIej1o22x8Uh11ToDqP4q1skKaxoM7CcR2/rW9Pm9J8IFaA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9e5FKiJyLg6WETkKFCOD3mlLmLt3+lVmDUhV8poHwt4=;
 b=TeiUFoH81lYlwllyB3mr1qVkNKTi6YJ7kEPWzG3j3bRG3ln+J+VmVrPnGSbMBd03bNwM//IIUT+3ANONTClxYJSUzbIzej48lUPkRC4hfx6i865PRI5Q01DYfxlVBHRg9Q+AnsV7IvPLOrE8lFOE+UFcp+32JWl0K+TnOjuSls7liocqC9JrC1Ju+H2/V+nMfMnLoAzcXK9QKwzCZ60lZ6n477MhPVLxwbWW4uh185QYtRqEkNUVsndY9IGiveivW2X4uQgTHuPuF3wLkAPJe4cRgB/j9/GjlO/wawrnmxD0zj8Dd1Zhr+LO35fw90a1PtQcKnW3yLXEz+odpXS2BA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: Db3Mb9+YYuKIe4vZ867a1zOvHx6PGbplzHNnGnxWudb4QatPwZUMIq98dQaSokhpj0holAsmaAz/fMwmQAdT3BCn3VDLH52SNvVTisI8sIiZu+jKff7Ecf1m1bIiLGRFKyF/kSliRGyek2BUKZMhJFb71eKxZvDzIDU7EYDJlbqoFVUAjyET676fEDaxnLJj4DY1apI2NANEBqZFYJvvezogscnh0CKvsECdARxYsjLFK+EyVDaOykjWDdvsGs4dllt+KkN9NB93CFwjbgAgXsM5HFPe1r0XZLEUTq2vCcrLJbPE/DO5jYPnFhENEMCCt7vEV3wujzGXAkzwrfn4Og==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA1PR17MB4708.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 029d9135-a2fe-4538-6f85-08deb594aefe
x-ms-exchange-crosstenant-originalarrivaltime: 19 May 2026 10:52:12.8484 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 4iSzu7uKWwEOQAFFFcEjQrEKbBfydO1Xo+F51xlXijc9n5Nn+HMRLh7Nb/vMgUYWAtJ6Uca5ZeOLgcftEw51SQ==
x-ms-exchange-transport-crosstenantheadersstamped: DS7PR17MB6611
Content-Type: multipart/signed;
	boundary="Apple-Mail=_CB17F43A-6A3E-4102-B526-CE9D5AD217C4";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605190107
X-Authority-Analysis: v=2.4 cv=FdoHAp+6 c=1 sm=1 tr=0 ts=6a0c40e1 cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=d4nn1RXdvEacMIURMw2s:22
 a=c92rfblmAAAA:8 a=X7Ea-ya5AAAA:8 a=VwQbUJbxAAAA:8 a=tk0bPIkgPnXlFGnnlE4A:9
 a=QEXdDO2ut3YA:10 a=HaINecIjJBRJfztY45cA:9 a=ZVk8-NSrHBgA:10
 a=30ssDGKg3p0A:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: QfVjxL9zZdxrpcJynnOWiRuw-3BvV4lr
X-Proofpoint-GUID: QfVjxL9zZdxrpcJynnOWiRuw-3BvV4lr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwNiBTYWx0ZWRfX9pEUG+5mdeFI
 cd4if2Zw30r7eILfy/sVUDuO4PMPkzK2cz8xBz3BsFgtfRvasCLrqeCBHOQeDQ/tNEsIPOSJcmA
 fvGGxH4UsfXO/ut7Y86JWG1VPc5al9UCcZLfOE8+xBei5rUfEfZnDsFNoQCliyRCDgjzOl0ocLf
 47MBHejqAAGhdD12npVmql9q5xpvvCjRtW/UP/KxpAE08ROm0OJH7tiuWsjwU4SdJx2SdTU4XyV
 gALy/G1fhyVpKCo2O6jmtrsu8vPEJLCSMtdRzAbSZ2upeA9omG2hf/+ABUWfn7CiNAHLt7CdLAi
 nyFDLde/3QWgSK8G572RdCBgKgx+rxQ7HwE1AYsvRz7zTZjIUvklo3QhJCJRgaTPM3PvS6Ocu2x
 xbJ2mzsPlYuSdfFdG2ys2SwruZ7r1/LDnv0pLm9urb3uux+kQ5h7KVIpo5N3x3nKSEitosiLZWw
 IocxXBUhFZnH4WNViVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190106

--Apple-Mail=_CB17F43A-6A3E-4102-B526-CE9D5AD217C4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On May 5, 2026, at 5:14=E2=80=AFAM, sashiko-bot@kernel.org wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [High] Pointer arithmetic `kskb->head + kskb->end` causes build =
failures and runtime logic errors on 32-bit kernels.
> - [Medium] Missing kernel feature causes test to fail instead of skip, =
breaking CI on older kernels.
> --
>=20
> commit f73fb4725baa7b601a1b82c32e5095c6b4294f5c
> Author: Nick Hudson <nhudson@akamai.com>
>=20
> selftests/bpf: tc_tunnel - validate decap GSO and encapsulation state
>=20
> This commit enhances the tc_tunnel selftest to validate post-decap =
tunnel
> state for both GSO and non-GSO packets, and checks IPXIP decap for =
IPIP/SIT
> paths.
>=20
>> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c =
b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
>> index 7376df405a6b..853bca962910 100644
>> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
>> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> [ ... ]
>> @@ -621,6 +645,11 @@ static int decap_internal(struct __sk_buff *skb, =
int off, int len, char proto)
>> break;
>> case IPPROTO_GRE:
>> olen +=3D sizeof(struct gre_hdr);
>> + if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
>> + BPF_F_ADJ_ROOM_DECAP_L4_GRE))
>> + return TC_ACT_SHOT;
>=20
> If the kernel is missing support for these new decapsulation flags, =
will
> returning TC_ACT_SHOT cause the test harness to time out and fail the =
test?
>=20
> Since selftests often run on older kernels, should missing features =
gracefully
> skip the test instead of failing it to prevent false positives and CI
> breakages on stable or LTS branches?

The current TC_ACT_SHOT fallback prevents silent passes, but it does =
cause affected subtests to fail on kernels without the new decap flags. =
We should move feature gating to prog_tests and skip unsupported =
subtests there, so older kernels report SKIP instead of FAIL while =
preserving strict checks when the feature exists.

>=20
> [ ... ]
>> @@ -655,6 +688,40 @@ static int decap_internal(struct __sk_buff *skb, =
int off, int len, char proto)
>> if (bpf_skb_adjust_room(skb, -olen, BPF_ADJ_ROOM_MAC, flags))
>> return TC_ACT_SHOT;
>>=20
>> + kskb =3D bpf_cast_to_kern_ctx(skb);
>> + shinfo =3D bpf_core_cast(kskb->head + kskb->end, struct =
skb_shared_info);
>=20
> Will this arithmetic work correctly on 32-bit kernels?
>=20
> On 64-bit architectures, sk_buff_data_t is an integer offset, so
> kskb->head + kskb->end works. However, on 32-bit platforms, =
sk_buff_data_t is
> a pointer (unsigned char *), making the addition of two pointers =
invalid C and
> causing build failures.
>=20
> Furthermore, even if cross-compiled with a 64-bit vmlinux.h, adding
> kskb->head to an absolute kskb->end pointer would yield an invalid =
address at
> runtime.

Martin previous replied

"Other tests have been using it to get shinfo already. I would leave it =
as is.
If it really would be needed to run and compile on 32-bit in the future,
it could use bpf_core_field_size(kskb->end) and then do things =
differently.=E2=80=9D

To this.



>=20
> --=20
> Sashiko AI review =C2=B7 =
https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260504101759.=
3319427-1-nhudson@akamai.com?part=3D6__;Iw!!GjvTz_vk!VFiErP1-AQql4LyaLTqxj=
mLQFQ7MMBQ5-R9rsHjqekoHUFNBl0WsEAX6ynWPASieLSi7E1DjAA-Rf64aLeCR$


--Apple-Mail=_CB17F43A-6A3E-4102-B526-CE9D5AD217C4
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCc8w
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJjCCBMyg
AwIBAgITFwALeewU5YRKbvcMWwABAAt57DAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI2MDMyMDEzNDgw
MloXDTI4MDMxOTEzNDgwMlowUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1FIVDEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAx+gvYqVaQAmc/yNlMv3t5CK6FN7++3ZChJpOElnFyZWj3h+VwSqN
5WD4VQn5DL515KovgCiv63DeQ1NuXNu3XKKeakHyssixhIL2hqjlPFnsrwXJ2R9B9hAGIiOBy2rK
Var+w87AFUZ70jsZlI70IBnJOYsPYnZRmXBytTxVWk9V7Nnh10RuUfkZE2Ry+P18Z7glHYoQeksi
hz/9uqRUEqt23qDYBR1J7bB+SSW5A3LmoTEugWYzayxb9iM0vVleEHqeuN5nihGn8Y7nIrs5sIo8
6AG2Bjl0O2VgWWVfqhl9IMQlx1ZxHAicuMvDN49LD1yMkqx+LeBLboiFQQ0MVQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUD8PIZa7GFc+oX4RLtUq8oUrOL/IwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
oBkMF25odWRzb25AY29ycC5ha2FtYWkuY29tgRJuaHVkc29uQGFrYW1haS5jb20wHwYDVR0jBBgw
FoAUtjfong1VAIz5spH9WobJYxF5rVwwgYAGA1UdHwR5MHcwdaBzoHGGMWh0dHA6Ly9ha2FtYWlj
cmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRDQSgxKS5jcmyGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3
MDEuY29ycC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybDCByAYIKwYBBQUHAQEEgbsw
gbgwPQYIKwYBBQUHMAKGMWh0dHA6Ly9ha2FtYWljcmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRD
QSgxKS5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3MDEuY29ycC5ha2FtYWku
Y29tL0FrYW1haUNsaWVudENBKDEpLmNydDAtBggrBgEFBQcwAYYhaHR0cDovL2FrYW1haW9jc3Au
YWthbWFpLmNvbS9vY3NwMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCILO5TqHuNQtgYWLB6Lj
IYbSD4FJhaXDEJrVfwIBZAIBUzA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZI
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0gAMEUCIBZ79THtRc/r
DXpg8rSeL4tPy9/eLjXnJvYW5Ek2SUJ8AiEA5j0Wa0K9P2Vumn7N4F5MpbHW2t/kxsdwUu2Vzp6S
5BUxggHpMIIB5QIBATBTMDwxITAfBgNVBAoTGEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEXMBUG
A1UEAxMOQWthbWFpQ2xpZW50Q0ECExcAC3nsFOWESm73DFsAAQALeewwDQYJYIZIAWUDBAIBBQCg
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA1MTkxMDUyMDJa
MC8GCSqGSIb3DQEJBDEiBCBZ1gtm8txaqpZ0Jrhy8ng01iHn8/FUJ1ozlg5YhqyfPDANBgkqhkiG
9w0BAQsFAASCAQBLSUIZjCOdqkRl9WPcxOy390Rgr0wdHxYdUsAN/R1wZCjp2wTcD9EI4qJMgPfO
tkXSC9dw/w0Cte4v4CgdgYC37wRQcA+l0BZqUBD7LcZtz2al7KlaGleb+vScPoE4sk+3JwGgsRVI
7/K34A7KKkh9DJBdJgHLclFWA0/yNfAUcp1sIoMyjbFlFZejBfl2q1c9qV0KL03+k5XfMwnubA5a
U/f2exJUwOjgRvAZlI+Ol0N9cvLL5kTAjD1XgSmNd9Ca39na832AbEkRQd4ngVwiVp6GoM1RA1S3
z740uwKTQ6fVC7L0B3FiVV3gQgwJBTfGwkMOdcSohppuVuz4UkaTAAAAAAAA

--Apple-Mail=_CB17F43A-6A3E-4102-B526-CE9D5AD217C4--
