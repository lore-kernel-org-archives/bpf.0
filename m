Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4812439F60;
	Wed, 12 Aug 2026 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536838; cv=fail; b=AkUFWjWOBP18oKChbQYR5OuBZ62OA1WaAl0kSgzkfjSFDwBH+xSr6AD8lO9WvHgLzY+CUS1WBHYzRSBNh3GpWEC6UwycAl+Sq4UnIOPWR/roXZeBLwWw6442ya0wXNJmCbhMSkrk+lUY2ncaBFmmEG8RTerkFzejniZ0m6xKxTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536838; c=relaxed/simple;
	bh=ONTL1CHHwEM5PXM/+Yeiz37jgI9J5by3rJKVe6Jxd0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hLPGYwg3t4xzAGAlIi6mwN0vroNksgwlN/7MbIoDzHuCRRL7/+tbka1x/uq/tiWpNJtQfIhk+0YCEZMsHNoVvDUUkddq+joprHYYDlFdxyCCPtUm61pAZuHwASeaxlsnL4nBqox4orCf/Lc2XiW954r7/W5Kf8b/7WoC0pEqhBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=h/NhRrQ8; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="h/NhRrQ8"
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 67CB4H9D676467;
	Wed, 12 Aug 2026 13:13:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=apr2026.eng; bh=poJRfDx/SDDGFHLfzth4R+
	BCkptZRoeN/0+lIMmHuz8=; b=h/NhRrQ8sYWsGOPlWLq/reaR3TUFwc97N4jYO/
	BJi6YA/4IZHyI5T1CtjsnXhOHFrATJ0SBCOdxLStvT8OP9APdeXiGj05l2VgmU4t
	bQsZIBMPgOOikp1IKCVdD60unuau5FaPfQ1ZAJKC1v1+DdxO2ApyC61ioTdQEJ1w
	koVHdYvJnJndbGkW9kxGHLS5/oEdFl70wjKAj6ng4Sf7v1XIxfhR+s12kd1UA3a6
	8S/SBmnVb1T5VJquTdzI6W0TidRLjz9Xex/+Ceb1tEgOD9fWpYuKkXyzxNe90r0l
	n8mvCFZ+gt82nB7W09VOpCpCyXbFOZfif3o3r/LRRhQJGu8Q==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4fxfc7nqy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:13:50 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67CC4YRS015469;
	Wed, 12 Aug 2026 08:13:50 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4fwysumtss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:13:48 -0400 (EDT)
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 12 Aug 2026 05:13:48 -0700
Received: from CY3PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 12 Aug 2026 05:13:48 -0700
Received: from SJ0PR17MB4711.namprd17.prod.outlook.com (2603:10b6:a03:378::6)
 by PH7PR17MB5929.namprd17.prod.outlook.com (2603:10b6:510:158::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 12:13:46 +0000
Received: from SJ0PR17MB4711.namprd17.prod.outlook.com
 ([fe80::bc8:ae55:d179:ebac]) by SJ0PR17MB4711.namprd17.prod.outlook.com
 ([fe80::bc8:ae55:d179:ebac%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 12:13:46 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 4/6] bpf: allow new DECAP flags and add guard
 rails
Thread-Topic: [PATCH bpf-next v7 4/6] bpf: allow new DECAP flags and add guard
 rails
Thread-Index: AQHdKjUQBXO5p3MatkCjvRVLjog1I7aaNK6AgAAe54A=
Date: Wed, 12 Aug 2026 12:13:46 +0000
Message-ID: <C1FBF256-7BA8-4F29-A63B-93703339B188@akamai.com>
References: <20260812083115.73100-1-nhudson@akamai.com>
 <20260812083115.73100-5-nhudson@akamai.com>
 <20260812102300.0BF711F000E9@smtp.kernel.org>
In-Reply-To: <20260812102300.0BF711F000E9@smtp.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR17MB4711:EE_|PH7PR17MB5929:EE_
x-ms-office365-filtering-correlation-id: 11e8486b-db40-419e-d134-08def86b28c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|6049299003|376014|1800799024|366016|23010399003|6133799003|4053099003|38070700021|10067099003|4143699003|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: /3XhC96+FdhG51arN2OpdmOUvOCTxjuYqRBG3F6nfl4I7REuCRsBQhyCJSJPQfkfeU3nR6x71ZkNOVcOyQTnvcsw8TO7ybme5hyGpEgNMkaiFWSlcFsEGe3QEcW0wemqnE4rH8ltgMYypYCi8daB1mD8K/xpLg8B+4afJioRd3kybGoWHr3q8gqGrMpUPeqskUmKGAYR9H1E89NwjPTOtOuo0VP5YWbNqdIwWS0gMawUzrGdHfLbQhs2X11Be6ZwcUn239X5XDMjUCd+TJNkzou6LC93mepfhF8dpOaH6pgy32NVQHBEnpOFvlvRH5euk254ZokmT9DbP/NrBbPkfCeglQDjerGG98hdiw+tPStQrJg5JH/Ifbjg2lAd5HDoApEq9OZBPCJV2I1cSbedfGRJuz4fnE9poy+WZm8W7H461aOaE2sVP+gwRMt6SYc9+029CN0LLnJFc3SnnOx1MHRKxZBz+rCF4ipiU9bAFN3yLtc0T5LDvobGnHxcg7+2exeq4ECgE9WkP2dDbeEJjrVNrh/SxtTG+i5uKA+K77/sFqAob0YsczPI8DXOoAMyoWZMCCh7GEC0cT1qXu5cdCmL9JlR3Pq4vtj3vAZnTRusmUsw1s7CeB5KX5bC4R+g1PUWh6h8bpfPvnOHcUjFr2Cu6qZZleQuErTUWKuLPScrgsT+NOr2JC9IFD3Pp4AWnlaud0B3vP0VfWtxlsqKJiYJN2ONDcITNKs+FGpSMPM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB4711.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(6049299003)(376014)(1800799024)(366016)(23010399003)(6133799003)(4053099003)(38070700021)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGtNdytLL2RiQ2VpT0l0SmlLZ2Q4U05JZU1YK3BYNlZQSnVoY2lmQXNRR1Ft?=
 =?utf-8?B?QXIxRWR1dHZsckZKU3dTTWJMcEdtQnM3eWV6cm9tOE1FS1ZWcjdTZjRqY2pS?=
 =?utf-8?B?Tm9UeURWSHYrQWNncjMvbWw4Tzc5MnZKUExPZnl6QmJyT3ROak85NW8wa2xC?=
 =?utf-8?B?M2JLSlV6QUsxOWhHWHZUL1FVZ0dXM20zWEliY2NDUFEzdlRsTlErNUlkbTho?=
 =?utf-8?B?bFdyb3VickFSTTd4dU5iYUtWazBXbUlJS0YxVVJnQkJOeVJzMi9DK2dZdi8y?=
 =?utf-8?B?WkZxUDZ6cVBlYllIMUxiNkc3SEk4bmVKUHFkS0U1OC83Y0d0aHBlQkE1VVcw?=
 =?utf-8?B?d2V6K3VEdEFoQlpsRDBiV3ZsaTNpWHloc2RQbWJNYUJOSEZySGhIWEtQTWV3?=
 =?utf-8?B?alZ5WEVQNWlmUjI5bE9DUFc5M3F6TjZCOU45WFc0bG8xU3I3c1ArcmNwR2g3?=
 =?utf-8?B?a01TOGw2akZ2a2R5eXRPd3ZJWVBBTzFCV0gweXl2Lyt5aDFRRXcwL0NVZFUv?=
 =?utf-8?B?ZDJNS2FLMkhTZTdJajRKMGpKV0JtZzhhZ3UxNWhKYmxYbWlocWFQRFB5NlNi?=
 =?utf-8?B?ZGdNQjJkZjdBaE5qRmtIMFdDTVZwSktyWlcxVlU1WFlDKzlXYUl0M2dKYzYr?=
 =?utf-8?B?cTlnY0NuaTI5M2Q1a2dVSWFNa3FST1BpdDg5V0FXVzEveEJ2N2xDKzZlbG1y?=
 =?utf-8?B?cDFjRHdZdWVKcW9zdnF5cEd3UUNRaUVzRllvTEFBYXc4VFVOYXZkbjJFWExj?=
 =?utf-8?B?bWRqSzBYOFNQdm1LdlcxSERJUmhkbUt6SGxhcEtVbElMbVVuMVFTTnd0M012?=
 =?utf-8?B?N04wVVdWdGNCUDBUelRlVE1JQzVXZmJaK3lwNDI0VU4yZ3gzSUkwOTRxS01Q?=
 =?utf-8?B?aFAyVVJwWndlM1I3VlpBV1p3NzArUHloZkU2Q25nY2trbHo4UGZ1dDdoZito?=
 =?utf-8?B?aWVXaS9HejhkSjV1L1hYYVM4WnkvVDE3V2V5aDRSVFhoa3M4T2NmYjlQVlFQ?=
 =?utf-8?B?VkVhQ1pET2dOdEZjbzNEZi9Gd1huUUw2VWNqWTN0NHliUzBUOW90SWZkMDR2?=
 =?utf-8?B?TTNmbTVuc2VqT3MveC80Q21qRTBxeXljNGRiZzJOYTRYQzVuMXIzb25tcjh2?=
 =?utf-8?B?dzM3b3pudXQ5SVMvQTg4Z0c5djMxS0tZRE02Nnp5WTJza1czVEMyQ3lTcU1U?=
 =?utf-8?B?UWYyajVMREhLR21Ma3RCN2RsZTlZWVhJcXZ3bFNWSWQyL2NlN3RJcGRudEtM?=
 =?utf-8?B?cXpESVEvSTV5b0JUYUE2a1NRSHc5Qy9KTXZaM3drMWNva01ONWRoNTJzOVRC?=
 =?utf-8?B?dDFkUmF3WkkyVzE4OVlLTHlIRFFvaldvRElIc2pEN2NpQ2RLb0JRMjhwRkx1?=
 =?utf-8?B?OVg5VEcyTHZnU3FqUCtUT3VCb0o2ZU1pbzNwbVFyNUU1bUtJaXRMRVdTZUVN?=
 =?utf-8?B?UkN5aGYyakR0RWg2djZpOEJFWjlDUUR2allwdjBLNjBMVWFGdjdZTVNyVUVa?=
 =?utf-8?B?amtKRU4yRFFiRDFVMmsyNzV5RXUyYVcxeDR6NGlUUHBES2o1ZUo0dVdPK0hY?=
 =?utf-8?B?djlMT0hHSVdDTktXeU5LWHdITTBldFF6T3kxYXQ2V3ZmMThTbnEvZ2Zlc1RL?=
 =?utf-8?B?UDRuSTA3aWZBRW1hRS9ZSnl1cmhsL01VUWJHNG5SZXN5UWQxbDMvL1MyRWZG?=
 =?utf-8?B?Y2RscU9GN0gxQndJN1BHeElzR0d5eEVqOURzZnVSZXVkWWNhS0lDTXRjSCsv?=
 =?utf-8?B?VStrbzAxTHBNRU9JbWUzTk5ZTzIzcTdLZWJqT2VzVkUzL2tLdFFUYmNZbU9U?=
 =?utf-8?B?K2NjbTVWTmwyR0tpbEhzVzZrR2Z5QTRjTlJqTDM2S0FUSHpqMEw0dDg5UWVr?=
 =?utf-8?B?UG50Q01uNmRCU3dIS1FtUWJUdzByY2VUaUZ4a1plKzR5bHYwY0dLQ002cGlM?=
 =?utf-8?B?aDBPSlQ0V0hFeS81RjhtdDNVdnh6bG5VQWdkZmZJVGhpRkZKZXpwR2ovSThT?=
 =?utf-8?B?TDNBZGs1b2ROclF2T0tSMktZSFA4T2EzaFBxcGxQbGVkV3VqdWVWaGhUbXFo?=
 =?utf-8?B?aldoNHNPSElIVkRTR3dscm13VG82V1o3QitIaUN0VkxHcmZRci9MdkNKL2dM?=
 =?utf-8?B?UFhOeXQxYzM3SURCMFVjQWZjeExMWktzL0ZLOXFwVjZHVk9ONG9vYU9KTXph?=
 =?utf-8?B?bEl2QnUzVmh0NFlhd283VFNsMVRYdzc0aGExb1VWZlpFNXNSTHVhWmZsbDlU?=
 =?utf-8?B?MFIxY1RFUFVFSkkzdjZibDRaRXJCV01mL3FWekFTR1RWN3UzU29xcFdLUlBa?=
 =?utf-8?B?NmRvclJZOWlMRWN0Vy93R1JFUkZGNkVHQzlpZU95bGJzeWZXSnB5a0tLOVQ0?=
 =?utf-8?Q?csl4Ysuv8qYkrGf1pauPRpI/2BDoEm+IJC0VgHz7PD3iR?=
x-ms-exchange-antispam-messagedata-1: PV9avBSADZfe5w==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBEtHeVgm037eIpR1BK3XBgxkQPH1GKJc4SExRqaSWh0r8MfNJlGn4MvjdZQyN8+2nLsddB1+Emyidkvybhb37Ee3atkA8gBnLOYfzSFgVv7tzsyxSavnBe0jiHPUquH4r2VlZdVfB/BgiGJdzGCx4rlI8Wok+UyfVKjUCsJ5bSI3B0b8+SL7GYS97x7XpKPuZM93ilWpWJbEq4UJATj5m5dOQqACexvogzEftn0ju1Z07pqKsJChqK58hDrZ2Qi8tYkjkybRDb9qxs/B5sG1rzWDziOBxROjEe4DdmkCq0wp3v2yvKoLuJ31gBzxhjnUoEmvQz5vBah3kaZSQsOQA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWf6FUlOG5sZgN9txQoTwmtF7OCPkSM2sJMNevXuDog=;
 b=b5bhc5a3NMM0sTgtWbSi4wTbms07P5OkQwF1/90PSZ4RtxSO9Knya9WTxkqSh7Ul5NBdS7zFGpl+NQ0wchES9/5YDIwmiWDW90Dv6q7Fa9bkvVpL9KncV5kvFIppjHYyNJDR6V+iVL5rFyExpishxw8kDwAA+FBI+Jz23w7aM8gxZ+K8Ix/2+YjECrfJLj9b5rGjv5Kb8GtVjatGMYYnzuAXggFHkBO6iQGmhCtIjsiq5v6ZfatfYZ/9FAIi49jR0qj8eKtYrJoVQPFgf4FV4bGIxRTdTJ50llVJCXRJ8UWnafujX20mVHGdlqNooOKTf6uXXftPBQklLlqxDeNgPg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: Kw6F73EQPracWgyH7Sn8FGEFYrJNTK+UQY1PzMo5AN4Tb+2AkTbNETqE8/+I9T8OFRe/8uzSkeqA24FWWjcmtv3OhBB2okqZIB71SJHNAp4FW00yjCV7e2g7ps7SJjyYIkrBXs6OTf1hbQEtPe96OonEOdltZpcD/X6UtHHjvb56iNA3y/aEt/U92o54cv2ChAvjKfXS3bD4fMkVA7ZxlhoCRXCarVh6nrv8rW1isoQMA8k23KeN0wixhHjBDpw2Au+hdBL5OBhYkEtwzFVfHNKEWedsRN1y39g4ytd5al2gWhfaIfcz/j+5K0uW5NbHT0YjHVXS0iK5Hq2SLiCqyQ==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SJ0PR17MB4711.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 11e8486b-db40-419e-d134-08def86b28c8
x-ms-exchange-crosstenant-originalarrivaltime: 12 Aug 2026 12:13:46.2148 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: UlHM3IV3F8iNntPEz9IpP4ngEeSa5EoygIbVN0dPkR89nJEACt5ZJHLcsfeRJkSc8eCqE06x55SpycV+g/IOMA==
x-ms-exchange-transport-crosstenantheadersstamped: PH7PR17MB5929
x-originatororg: akamai.com
Content-Type: multipart/signed;
	boundary="Apple-Mail=_50F30C6D-FC58-45B5-89D2-AA7BBB336A00";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608120098
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfX0bOsJci5AGhW
 4FD1YY9jgiaTRYpyNw6YnF7wPhTIvMB+7eGaOTmNAQHLtbQwCy4+naJVjwrIIuh8V2Rg4a2AgMh
 exW1Yo6zpwKUkrQ63tULnSy8jbCLKec=
X-Proofpoint-GUID: J5AL7yTChWbuSibfBagkZmIxl-RqQ7kv
X-Authority-Analysis: v=2.4 cv=Cf84Irrl c=1 sm=1 tr=0 ts=6a7c637f cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=KDzEjHMMTas96-nIEKpj:22
 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=Jns5T0zSJ4wvgkbfMZAA:9 a=QEXdDO2ut3YA:10
 a=HUI2YWsAF9AzphKFq_4A:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfXzdLDBNjAmJys
 0X1e46RXCwH6HKH3Kgjjqxdd6/UznHPsCfkx7BPEznX6S0C6UZ3dgSyhAHegtSfOOUlU9hMrmb9
 7U1AHXkx386o91ADeqA5/hrrtsxwwaYA9Wruose1eIgnjvu1d3sjSJzdpe/dM148uRi+247m+CA
 w5q4g675wOcuqVbDIK8nPY6yU04DvzZvvBMK3ZcCc035nYvV7/z+f6M5clKGX8xbnoRtfyXoVlR
 9Mmt8PtEEAzLVSE3iRTbsD/gwY641LZxsA4y8S+W57r/8LB+N22AVMglkfFWs/h2yYSr6SVefPS
 bfoKn4oFwNbLL49rVmfhkARkUecc+AxTZZWT2yduX8VvLuFgLczjTRwEWXJKa4aX0AzcGzEe+yZ
 /win2H4rpTLdzL+b6VxRZwLL9bGLIRGK8zIKOCOfbu48FzyPxVj9jLMr7BxPetb/g7bfd8bLKcd
 SRobJtzHclMDpjVYd8g==
X-Proofpoint-ORIG-GUID: J5AL7yTChWbuSibfBagkZmIxl-RqQ7kv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608120099

--Apple-Mail=_50F30C6D-FC58-45B5-89D2-AA7BBB336A00
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Aug 12, 2026, at 11:22=E2=80=AFAM, sashiko-bot@kernel.org wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [High] The patch exposes new decapsulation flags without =
implementing the required kernel side effects to clear tunnel-specific =
GSO flags and `skb->encapsulation` status, leading to stale tunnel =
metadata on decapsulated packets.
> - [High] The `decap` flag check in `bpf_skb_net_shrink()` was not =
updated to include the new L4 and IPXIP decapsulation masks, causing =
critical packet state updates (like dropping the outer `dst_entry`) to =
be skipped.
> --
>=20
> --- Patch [4]: [PATCH bpf-next v7 4/6] bpf: allow new DECAP flags and =
add guard rails ---
> commit cdd433d824d20f40752fca9cc2db82451d364a2c
> Author: Nick Hudson <nhudson@akamai.com>
>=20
> bpf: allow new DECAP flags and add guard rails
>=20
> Add checks to require shrink-only decap, reject conflicting decap flag
> combinations, and verify removed length is sufficient for claimed =
header
> decapsulation.
>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 89e516049c852..981b75941e7f7 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
> [ ... ]
>> @@ -3579,7 +3586,9 @@ static u32 bpf_skb_net_base_len(const struct =
sk_buff *skb)
>> BPF_F_ADJ_ROOM_ENCAP_L2( \
>>  BPF_ADJ_ROOM_ENCAP_L2_MASK))
>>=20
>> -#define BPF_F_ADJ_ROOM_DECAP_MASK (BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>> +#define BPF_F_ADJ_ROOM_DECAP_MASK (BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
>> + BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
>=20
> [Severity: High]
> Does this mask update also need to be reflected in the decap check in
> bpf_skb_net_shrink()?
>=20
> Currently, bpf_skb_net_shrink() evaluates decap based only on the L3 =
mask:
>=20
> net/core/filter.c:bpf_skb_net_shrink() {
> bool decap =3D flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
> ...
> if (decap) {
> ...
> if (skb_valid_dst(skb))
> skb_dst_drop(skb);
> }
> ...
> }
>=20
> If a BPF program uses BPF_F_ADJ_ROOM_DECAP_L4_UDP to decapsulate an L4 =
or
> IPXIP tunnel but does not provide BPF_F_ADJ_ROOM_DECAP_L3_MASK, decap
> evaluates to false.
>=20
> As a result, skb_dst_drop(skb) is skipped, causing the inner packet to
> incorrectly inherit the outer tunnel's routing cache. This can route =
the
> inner packet to the tunnel endpoint instead of its true destination.


This exact dst-drop gating question was already discussed on-list:

https://lore.kernel.org/all/20250604210604.257036-1-kuba@kernel.org/

Keeping L3-gated behavior in this series is intentional. Any broader =
change will be a separate follow-up.

>=20
> [Severity: High]
> Does this code miss clearing tunnel-specific GSO flags and =
skb->encapsulation
> status?
>=20
> The UAPI documentation promises that using BPF_F_ADJ_ROOM_DECAP_L4_UDP =
will
> clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and =
SKB_GSO_UDP_TUNNEL_CSUM)
> when decapsulating a UDP tunnel.
>=20
> However, bpf_skb_net_shrink() omits the logic to do this:
>=20
> net/core/filter.c:bpf_skb_net_shrink() {
> ...
> ret =3D bpf_skb_net_hdr_pop(skb, off, len_diff);
> if (unlikely(ret < 0))
> return ret;
>=20
> if (decap) {
> /* Match skb->protocol to new outer l3 protocol */
> ...
> }
>=20
> Leaving stale tunnel metadata on the packet can cause downstream =
drivers to
> parse incorrect header offsets, resulting in skb_over_panic or
> skb_under_panic.

This is done in patch 5 of the series.





--Apple-Mail=_50F30C6D-FC58-45B5-89D2-AA7BBB336A00
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
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA4MTIxMjEzMzVa
MC8GCSqGSIb3DQEJBDEiBCDx0aeAYriMSbEz9EyGIWlearil1JglMMc83EvjESygqTANBgkqhkiG
9w0BAQsFAASCAQAl0bAkIIEesFldCTEIZxKk5Z9jTkHpAUM9q3nSGfrZj71XT1PRHuRLex6dbPiT
cPY+huTLW3DmfyKnce6cVWtN8JF4eMfISbkRTfqdcFxQBtyJ0yp5thiIL3IPeBbiVDPyd0tn6snv
FWarnTwvE1hSfJV258Q3uqF0dQmeROzealhtDajH/3lJXayJaTA1vTJqaVXs5nLufXAFLZrgY1kf
BQeX0AtkZl9iwJEOkxtj3Aed9Qe6AAuqNKS6mSKVRznyqsOU3BjwY7iRWoNVnQJfOqa/tXhTZdl9
8rHggQDrCJtvoepaxS4X2PWQqNbfVuWL5Hvm293u8ZYrAzxn2oDeAAAAAAAA

--Apple-Mail=_50F30C6D-FC58-45B5-89D2-AA7BBB336A00--
