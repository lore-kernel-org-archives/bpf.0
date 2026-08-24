Received: from MRZP264CU002.outbound.protection.outlook.com (mail-francesouthazon11020077.outbound.protection.outlook.com [52.101.165.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C143B3CE
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.165.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585977; cv=fail; b=PWd1GWYmyeM3La3V2JE3KFXxsxg1Z0urarTMylib0xUvjlNWJGl/4f5vQunfUXZ16rYedANIFqzVkBZ/LNZQqiD6QPgpRz9Rz8MWh+4d36FvtvLaPKuBcrwuqQ58Ll1rPEKpXuRC8T8OjeyxGjazg5wIcvrn8FnqzBltgiKKQh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585977; c=relaxed/simple;
	bh=YbSNbrPzMEHl6QBJ1SuAkGlfSgART4wrqJglkcW19v0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VJgDdp1OY6SD01mzn+kNS6/Q2tio8yrh5XsQE0ntil4878edWsC2TUMzvTcKTa1+e4R6TWUir5anbWp0uw46aCUJlfWL0Nzd2x8q+wp6yNfbH7LpJacRMtNrqJwGM/ICm2KOKoAzM7fxiu9RGEsX6hjBTOVwUd4cXAppDmDYQw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=harfanglab.fr; spf=pass smtp.mailfrom=harfanglab.fr; dkim=pass (1024-bit key) header.d=harfanglab.fr header.i=@harfanglab.fr header.b=G0bTW+79; arc=fail smtp.client-ip=52.101.165.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=harfanglab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harfanglab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harfanglab.fr header.i=@harfanglab.fr header.b="G0bTW+79"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFWiBSDgTuYBjprQSoNuiFU9y910Mw3bJIGWKR/8ualqdq3UcNvA33m4GUqjVnlrRjgWZO59z0OZws4srr4ggHXbHlFqS0jK11F9iCiq0yk4rsKV+dNnBsqF2zP2ECYX+mYv0T+DorXpx71PxUQe6S1fUiNHsMgLUpp92/a/0FBP8e/r54xh+bop7sGMggAqRpf3LkEfkKb1+d4rLHMrHkm30OOeGnplI8Kc6SoEGz4h2ok+Z8AY20Cm1aYHQRbYVWw+YN7qD6GqXXjpqodhHLftN0bXslgHXC4ay1oZ2W5nvh0PF2oBl5V9SJsUSt7U6latYsqb5huudi+SFWYxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbSNbrPzMEHl6QBJ1SuAkGlfSgART4wrqJglkcW19v0=;
 b=Z7D9ZMWv/f/K8MWeqRQg7Dv3w3lZkyr/yAvdgCWxrofYt8M3tbH+ypOK5GX8eD7CM/fZAsExNOFHbsPmwa9EfsC3qC1ftiEbk/pSrk2ddnusfBS44KOFtLNyFHHN7WC2+kLUDH9+fqaRf3WC8hEd/3R8iMvZtjXH+5XHhT7p4W2F4vgPLjkFNtbcBc5sxo72HCmejVoYMU6Im9aTbrVUUWou+hDe0F8uA3/BGYiR+oKk5OUq4+PeTdCm/z5BnjBFaGPWnynRTpQvpXIgJJAz2rNe5HlTfhl9c4plnTNEfXFKHcMgkXYSgeWxSqcpKpzR5C9+GFANdMAr9N4ehsT5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=harfanglab.fr; dmarc=pass action=none
 header.from=harfanglab.fr; dkim=pass header.d=harfanglab.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harfanglab.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbSNbrPzMEHl6QBJ1SuAkGlfSgART4wrqJglkcW19v0=;
 b=G0bTW+79EH9lOBZb1MTpnFPepvIVtVSku2M8w3vTXT5TRB2XSbjLCvrYjcga3LRKrtrs7UWSAHrLdU+6k6SBdq9YnUVlDXWwMS3UDtLWZMp0LbigZCBHu37E4YJQC7n0kVM97POxqVQd7ikUIfB0BrjFlxbXWg/F9jkxg8VG6kQ=
Received: from MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:28::14)
 by MR1P264MB3172.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:39:31 +0000
Received: from MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7d89:c984:624d:9689]) by MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7d89:c984:624d:9689%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 15:39:31 +0000
From: Vincent Thiberville <vincent@harfanglab.fr>
To: Leon Hwang <leon.hwang@linux.dev>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
Thread-Topic: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
Thread-Index:
 AQHdB8yzqGrNWEhQ9U+ot25Rw6XY5rZWVYcAgACsKdaAAPcQgIAYISD5gAD6DoCAE05CFYApSp7Y
Date: Mon, 24 Aug 2026 15:39:30 +0000
Message-ID:
 <MR1P264MB331442551E797EDA92D3D89CB7A02@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
References:
 <MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
 <d255172d-d9e9-4116-9243-975cf4bdf3d0@linux.dev>
 <MR1P264MB33143D31DA8982ADB2E0D808B7F72@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
 <90c32de0-feac-4e63-9757-2a1d115be08c@linux.dev>
 <MR1P264MB331493FEEA2ACE6C2AEA5EB9B7C72@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
 <b76ade17-44cb-4e60-97fc-41ba55258691@linux.dev>
 <MR1P264MB33149467BB801CBD0A3425FFB7CA2@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To:
 <MR1P264MB33149467BB801CBD0A3425FFB7CA2@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=harfanglab.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB3314:EE_|MR1P264MB3172:EE_
x-ms-office365-filtering-correlation-id: 2e8ae6d8-540e-4b21-6634-08df01f5e3c2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10070799003|10067099003|11063799006|4143699003|56012099006|55112099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 8R025gtAGomgk+4RaofOYSkB/NBxSkLssyDPE20+h+8A6aG+C1tCDsUNwJYntzkXcY+d+6V8Zp99Vjha9Zu1ASsutfnAjQinj8bWU+c0qLGqFVZErWV78T/2yx0jSsRHhdNyx9Q0VieDGKBrDLLaEFD1P7x57qhv/lvKoGv0qDk8Go2V5rvE+oVq0GPhWp1pnx5HcuIslOwnXQ3vb9JL55Art2pp45aez4Bsy7puluvITYJYLVEYeXXKTAWIENEQS5oCx3sye6hJk1vMrfqlDRDcONOLusKjCEZWWwtKVf48a0KI5LtacIYtUzEGpKBnsrW5xA0FFIn0GPYFMpE/7JPJ5lSWUav5IPRuu7XOaH7JqZgJUbcaymvTbj6xWby8/iCZ5YTUdg4O7K3Zei15TpRJT7yO2PKzEkuqjehdXkzJ+MWry6NpNSzk09GrP0TehQZEFpqcy2LGtAr+IiJtnfMt43yAbh5QERTCdRo3WjF2DIndgWD30voE3iVUWQOMvhydtrAVj6tcMibrAJqCATcvoW/sD1feaUoi21KMFRulPP9S9153yCKbVlm3c1E/7igcyz+H/rb4eropyveNrqlVwmZSjndePWTzZODPB5XI31Gw/H3EQY1fgHWOiGE/MBuhTeSBJBvcILyYUnZD4LGy0rmkyiNR/V3mV1kAwq5ilfzolpzBO6cv6eHhrLFtFj5+jCZR9tQdOy78tFJjr6PHNJ/gNEk37o1ifzg+Azg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10070799003)(10067099003)(11063799006)(4143699003)(56012099006)(55112099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aZ15Au8SIS6njJVMdPN9ekjIoUFqb1VNixVQJaAsMCLsSqObIedAc5FSuM?=
 =?iso-8859-1?Q?MpMHYTcdcKF2n0PJGgP/bxy8l4uOjg1Fg2ho8FPmE+arhrdI20qxilpx5P?=
 =?iso-8859-1?Q?TfEH/p7wJYRjr9OYBZZ5UiyaeKEVqWT/m1o96qaCmmXVd8WB6sf81XJOzn?=
 =?iso-8859-1?Q?BbQuSX0Jl45bH3FEob/NP0gpSn++hz1Jae2zkX81VSr39AbcLmhzr437Nu?=
 =?iso-8859-1?Q?9fGJCYn70itGUme1SpO9VP0Wdhl6kKH2RrFFDQ57rwlSfJTuTd5Ew6zTNf?=
 =?iso-8859-1?Q?5ktIvpg6BN4NR6vwCYLpuEWVVSLxnO+iwASABgWIhxZwG1Xd20sZxMyyCS?=
 =?iso-8859-1?Q?7RScqXwAWgBfKuN0OBtRcjwZqwx0PIKWLiFJ36gqT0a5z+gWmd9UyTk3uD?=
 =?iso-8859-1?Q?sXLvgdhUcc1il7rAwvncO9peMEQrduQUUfi1wwpxCeMcloBHcHvkuipqE2?=
 =?iso-8859-1?Q?bZPS2++dsZrdN6Xw/jJyt6XPgTwqF6UOb4JZeqcvHCiitkRemRPpN7jUz8?=
 =?iso-8859-1?Q?MEb9FG0B3bDvfNngirYRVzyFECR6Sf5QwTQHv7fghW3eBGmEacRkMKOWJJ?=
 =?iso-8859-1?Q?5Gy0BmPBJPOLvzTKH3sOtchNNBBe6fDaBbCbcTpZV4ihYuENyf28/IIUas?=
 =?iso-8859-1?Q?1Qe9KyokzstZkULc0avZmt5b2i1yP9di8ff5KNE7ruwC6hK9+rHreMAziR?=
 =?iso-8859-1?Q?oBRaWkcXfss3Do5pg+e9BL3toYWAa4kg0oCdwYTCL+VR3cN+7S6qZ4Mgjv?=
 =?iso-8859-1?Q?yUSE4DIMZFho3zmSjCyuoCjxHwkoi0Ar2UZmxA8+IdXI83aAPW8rM0h9xH?=
 =?iso-8859-1?Q?/VtDjQ9zuU1NozS3LY7Joe/zmGol02eXAvZ7E0lYpQpHCjEfgxQ1itrMOS?=
 =?iso-8859-1?Q?LGjQoe93QzZFO9ne10SsqC6YgNPvv8jiiOVppbTvIhLlmIF+RWsLpZraHw?=
 =?iso-8859-1?Q?hn+3qizO0m7GZYXGLY3PIzRMWOYrMgpYIGhiWbuOybGUv6tfPaictQ0MTh?=
 =?iso-8859-1?Q?Sp4sVd9O4vMYG5GV/ZznNWtvheFqE8XfflGRHJMZFaqydSRFhf9PDpuyuw?=
 =?iso-8859-1?Q?Y5mLCHeX0RuGvQu6ahG3rJ2nIAvp1+EUau6k6fWBcYaum+A+t2nfHqHwXw?=
 =?iso-8859-1?Q?XDWJnzYTlr60Y3c+LzcfMa6O+8AaX9b7R/KuRSm9DIiCYkbNaxdQtDwFo1?=
 =?iso-8859-1?Q?fhoz61hC8zq/T+5OT5CzCowkMp+TRRiE1aCAUTpFziMCU2YzDtZIcyZhEh?=
 =?iso-8859-1?Q?lL4FZqeWS7yA+rlCInLGUloZH3wbljv/0mBNQorh2aBUvYxSuetwbDNXen?=
 =?iso-8859-1?Q?Pi722/IzQpwtMhmqWoA2JV/Rb49A2uilCpKd+9ytePZJbbrY5hV96NBqAU?=
 =?iso-8859-1?Q?SfCUbUVxPnFsjnwX/x5ytigfrloMQ40YvtNETWVzleHcYfChUG3wXWrYB+?=
 =?iso-8859-1?Q?XiLht0Ij+6qo6G4j1gfSiST8O2UNTs53gElJSptXaHkbR04+WG1LTLtkyP?=
 =?iso-8859-1?Q?PlKaQyrXuwqzmXG6/oFZenUoiUVnsvPGvd0InlepO7koXXCvqro9eXM9Ig?=
 =?iso-8859-1?Q?JokwMx5Svx/Mxot3cpNzKn4zjN3hQws5Llu3jUjTrF3SmKbNL1aIDfj69w?=
 =?iso-8859-1?Q?A2D1Kf7kMjnvs2s3oagIt8YbnicxAjDezOo9QLo8ehYQGrFS2rx4qpjbhU?=
 =?iso-8859-1?Q?JmmAeEFwfA7JFIp8LY285Fn91lyg9J/en6aK6smtIAUsWK0GwBb6yYIMf8?=
 =?iso-8859-1?Q?cModSirRGrx8t1sR8dWyO0Pyv9OQ4Hse+MaqaLQfXGDhCLQ1UsIJW1a4ih?=
 =?iso-8859-1?Q?Yo9mmPCbfyKML5aGF7YByLwsTybZ6X07KI+M9wPoARBYmtlN/3FL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: harfanglab.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8ae6d8-540e-4b21-6634-08df01f5e3c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 15:39:30.9182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e072cd9e-210a-496b-aa68-c0965404b8f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v9ReKqmRoNJY2osGZlnoheXnOJZAx9HlSqoLLkh04icYC8Jbi4Kgfw5eY526AIgfQiz2Dm1sFHpO6PssyGhDgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3172

Hello=0A=
=0A=
Sorry to raise the issue again but as far as I can tell, this hasn't been f=
ixed on stable branches.=0A=
This is currently causing kernel panics on for example debian stable. Is it=
 possible to fix the=0A=
issue on 6.12? Also, is there a need to fix it on other versions since 6.12=
, such as 6.18 or 7.1?=0A=
=0A=
Thanks=0A=
Vincent=0A=
