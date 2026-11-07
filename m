Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794040468;
	b=3O1Xpuxvsx1FVXcw5QGa7KBEgOOJ3n4e8WK2M92lQ8eiCSh8AcuJH26p65CqU6VBTNGB
	 a3fOEM+Nnrx2br5tgJTmUzoRMbu42Nru20yb39Poe3U5wjfIcLDo5N6xStKV03LtoK0Kb
	 kZuj8tcwGNE8/wAuQ4ybjsiDbrCsCYJRkqVBnrmz9GD2PfNvO7hPuxk+gzWO4gsFk2L5x
	 m9cX5WsbnSmNtFY+Mkv7SBTsAm4FIGV69KLqtq/iVa77VndvWTo4Q8F2Wqamoa2NjwEK8
	 KlzGPnRSeP/PprOhmVGaB2xHNNUA/uXa1L566kRv+/O62VcKBtVgo3lD19eaUC9jR1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040468;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:msip_labels:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nwHmVcIYvi/Cb8vCRu50CDu+oTfDcgMHt7S9hp06qJY=;
	b=xDuYmg+FinwniSpZaiLONptgi7xNRae58uDsgfxc+3xOVi6AyeG/Rv0gp8ETioCu/xK2
	 Ey6XOakBW7YRx6xv7vikxrsWxqPSWF6YyNrRXsEIMcVvwfmsrrm1weX8cEgBcy7EFqmSu
	 xnV/xcAfSyhTn2GwD3piL3HTGwn3mbLXPIgX0JkyLf4tyecvXfp/ZUeAgezx4N4Wvt89K
	 TY0xs5VJ8iGo2qDhB7uKxgNlm1o19pkwD8SCCa67cKoItibAKFPdzC+YCwQ3/xWxF/zWX
	 Sy7y2/zo9AxCnghOZXAlgFQJvtWBrbZraEtgH00Hskwp3Hzm8IvOXGGBPZMhml9u79w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wsu.edu;
	spf=pass smtp.mailfrom=wsu.edu;
	dkim=pass header.d=wsu.edu header.i=@wsu.edu header.a=rsa-sha256 header.s=pp1 header.b=JIvNzq2T;
	dkim=pass header.d=wsu.edu header.i=@wsu.edu header.a=rsa-sha256 header.s=selector2 header.b="ZmB4kF/B";
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.34
Received: from mx0b-0007b301.pphosted.com (mx0b-0007b301.pphosted.com [67.231.152.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3574606A326;
	Sat,  7 Nov 2026 08:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3574606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wsu.edu header.i=@wsu.edu header.a=rsa-sha256 header.s=pp1 header.b=JIvNzq2T;
	dkim=pass (2048-bit key, unprotected) header.d=wsu.edu header.i=@wsu.edu header.a=rsa-sha256 header.s=selector2 header.b=ZmB4kF/B
Received: from pps.filterd (m0000689.ppops.net [127.0.0.1])
	by mx0b-.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A75hpCc576830;
	Sat, 7 Nov 2026 00:33:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wsu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=nwHmVcIYvi/Cb8vCRu50CDu+oTfD
	cgMHt7S9hp06qJY=; b=JIvNzq2TYMiCXQRAs/0wXWvpcI6BOPE7IbB70yByFDtV
	HCIUvz+CljtvJ0aYUxIJ0K3UgGPma6z6WSm9ROB51JjR9q3uzc+ZIiZfmoaTFLxC
	vXXAf2hiZUu4BYAOOslNT788C+GWMw3mDsoMYOqTPEwgPCcUMfl5hl/x+E3TlNk9
	4D3ZRYPpUdtDE1/yG964ve5UUwI/pTaSyMkszjg5FKO7bOHH4rid4kwTXGo2H+Sz
	5Zdxcvz/kDwXeHAxf0BuVGjVLvWMK0Bvp+jrGW/YW4Te1jGeuEN3SdBrMsev8eXs
	XIkPghXVvHEP0fLtG0Fc6298K4aCZh3IXuY0QpLwRg==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023097.outbound.protection.outlook.com [40.107.201.97])
	by mx0b-.pphosted.com (PPS) with ESMTPS id 4hs3qrmm2h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 07 Nov 2026 00:33:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ub3dF0EiWGr4QvnuDYTn8FwA3IalqNc7YlzaC80E8Z6aNfyrgkXjnxzIXrzPrBkfLSQ3KkJKLi7CwbQrvGAp+SzcbgzlbmTNYXNwsg+kai+JxPl5IdB5P7ohq1t4OlmFyEAgrCtVEp9tBZQIZAnWNaT/3URF0kTwHHz5zCy5HroP+Nyien+VZYLkXqsG+yHpj5hw4xwD7TwGngf16Wh2AUh8VaNoXjolkBDDqgpN4lOqDc6xPgiRDXzIqa7uBxTuCMsXCbMx0zDE5pi2/yd28EsjMQBCATtN4AnpniQxaj6jxIJCjlfdCw+9+L7IuFAwc7zqVw/OXHe0DR0fTNyQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwHmVcIYvi/Cb8vCRu50CDu+oTfDcgMHt7S9hp06qJY=;
 b=y/UGkqofZYUIahMH76OVdI5O+Vj0FasQ2WWwaQmjXW8r0VfLEYpwj1jB3tySD0gqcHDqwJwm2efhshSlmLNyEZjteV22QufoHaQyLw8IhqDnu8//C60CZ1X9v9MPgoFF973r8yC2vBnst+1CymMNlWbMbrKkFerom5ZFCDDD754vnoa4LUllGd/oq7t/tShue6QZNUah1ipuP+e/eLLjQk0D539oCPiU9ZUNF0uQZ+pcQ1NoXFPcmc90pwoOkIYmeQdJtsXnuRv+m5B/ZGEEtQvqmM9YuaWaF5le1Rk9tGIygGLo+5rc0x6q5yNsKR/mAXnyac90pvc7RthZ/MujZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wsu.edu; dmarc=pass action=none header.from=wsu.edu; dkim=pass
 header.d=wsu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wsu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwHmVcIYvi/Cb8vCRu50CDu+oTfDcgMHt7S9hp06qJY=;
 b=ZmB4kF/B5RRWrXOoxKFddO9FiymimbI9D7P4opdIOmVlVS/lTssEuHvTPaLa8ikEa5AYGJtn1IcrcIJzv1dL+sqgIvwit8kcdW1c4376t2bpvSEh825YdZMLXs3+hhCkHxwdXazsHTY5E2vwiCwbK8oc2ssyefwvXAofu6m8vvMnSr4bGn7MT+wplnmGHf4ZijCXi/aymyFtm7eZoVJZOgfBnQIYGsiaxgNp0SGNhkKkGqUtCwVJjvc/IQcluFPguy3bETMlG8pdjmq5zWZFo8fc7JuedcFt6SmQQZeo6iME8ErnjSOfcf9nGuyv5sHCGrX0gexotKZpekcl+QGEfg==
Received: from DS4PR01MB994453.prod.exchangelabs.com (2603:10b6:8:35c::18) by
 DSM1PF3CBE71DAC.prod.exchangelabs.com (2603:10b6:f:fc00::949) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.6; Sat, 7 Nov 2026 08:33:47 +0000
Received: from DS4PR01MB994453.prod.exchangelabs.com
 ([fe80::e4b8:f0ff:396a:103]) by DS4PR01MB994453.prod.exchangelabs.com
 ([fe80::e4b8:f0ff:396a:103%3]) with mapi id 15.21.0615.005; Sat, 7 Nov 2026
 08:33:46 +0000
From: "Puranam, Ananta Srikar" <srikar.puranam@wsu.edu>
To: "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "memxor@gmail.com"
	<memxor@gmail.com>
CC: "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org"
	<song@kernel.org>,
        "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "emil@etsalapatis.com"
	<emil@etsalapatis.com>,
        "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Priya, Swarn" <swarn.priya@wsu.edu>,
        "Ammanaghatta Shivakumar, Basavesh" <basavesh.shivakumar@wsu.edu>
Subject: [BUG] bpf: module BTF accepts and publishes a non-VAR DATASEC member
Thread-Topic: [BUG] bpf: module BTF accepts and publishes a non-VAR DATASEC
 member
Thread-Index: AQHdbpEOOooAAtw/GUC0rWAHLgNBjA==
Date: Sat, 7 Nov 2026 08:33:45 +0000
Message-ID:
 <DS4PR01MB994453205513CC608C09303E23EA752@DS4PR01MB994453.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wsu.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR01MB994453:EE_|DSM1PF3CBE71DAC:EE_
x-ms-office365-filtering-correlation-id: 24f05ab3-a700-434b-d6bf-08df3ca9d6cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|786006|23010399003|376014|7416014|366016|1800799024|38070700021|5023799004|11063799006|56012099006|261022113327099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261009220027099003|261009221727099003|261009223027099003|261009223327099003|261009221227099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 bypkiGxNNsLUoauimCEiFqTdyq+Lx0NkdEt1Po0P46zDKfDBhngrXEkmrGq6GBTDqpVf7dky3PI/cwTUoXazbpl46BZGo0faVStPDNr5q0msHtDoLWrA2H15tzWOWlavEhupcj08H0BhjHCP/UuO1u5zT+DCsrtE+tPPAZSvAfuNyoSy+OoJw/JSMY9IRlJddzIS+xqefUH0QXgiQpt/ugVFxT3Wf0Tqyt1HUPQ4rAxpULJ0VIUttA7IKQMlEHBjtJfHWvaTuj60mYuFceIz6TKPNcZFofGcxq9TI7WJUa9xrva8aq0Bd+/p8GF524Xu3r8ZJgH6k/rmS64ucDltKTpkWf6LZN5bxWR26WEkBkAOwo2AOvwfQ4NwkkBQZ3EWXJIgzhEm69Cnjs0Q9PPanQikBZ29QFW5Zo+eTIimWvmnj/PD9LnpoCYHiz2zhsMVNplL9N1eO+IYVWIkzJYDqYpW42cD0sBTwfC5+pRaLPmYjft7fqJ6KqEkY9qGKZwVRBFhEnVOuP9mzVMJ3l2x7wXklAmnbhxmHfGPFjZQjJN/SvEF6sXDrJPw8oYHh7wh6ORY6wTTyPZrWcHPtiors4W267gBlHF3TdJJ+FK7NH1P55bntCnssf5McVOriPyt0b8ZDpYDI45+14cKnrRscOo7UPh3S0rUITXVwHX8EB0gANMOueMNQ5PpNOI30i3vaqUcRe4Y85GlKMe2qeVPdwjaEaFFdyku9xFaZz3nqLg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR01MB994453.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(5023799004)(11063799006)(56012099006)(261022113327099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009220027099003)(261009221727099003)(261009223027099003)(261009223327099003)(261009221227099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?O0lT6GWa6KKhGSkjMQj48dHfDULG1EqPSO6LMOePJkXKJxLNS3batrvU3z?=
 =?iso-8859-1?Q?BvpHdwCd2Fr4tmHjgzdJZqqGF6xS1uKBGEMoR7lD3k5T8kiK/yUjvXHDh/?=
 =?iso-8859-1?Q?BbCP0rgjluHw/0p3oyJSPNRhcV3z3QyEvCMRySmnVuoQiOZ7hfMgBw4nWY?=
 =?iso-8859-1?Q?r/X4v0P0JAv5h51KgqMW/RtqL0RK08v3NVthXbmmX4/ouTCyvYrnTycBRb?=
 =?iso-8859-1?Q?Sz0lkXbSdp8R4yXGNZCU7r+JgkAEHYzvuVLohtcnjPHcEPz5mgiptAIWtJ?=
 =?iso-8859-1?Q?a/JveD8zD2sJnwJ6v0CLSBjG02hPX1M65Ca9Zpd6I5nlcZ5XwxbqCRQmBM?=
 =?iso-8859-1?Q?wOYapAuSz1vvIFCIe+9rPwH6pmbeKw3aFywPfHNrRCQpN3f7uVBRYkxiud?=
 =?iso-8859-1?Q?bk+r12AOfUhJLJUguOf1wjjph/Z+5sQu59ewvHATrTzKEzjozQb7pTFCYk?=
 =?iso-8859-1?Q?n6pcreK4YkWQk7Rx8YEopU59QYXxAZsnFVrd3o5VU2ZH83gFMMCPk1s79w?=
 =?iso-8859-1?Q?owlqpSI+W4/SNROhUbaYHdBazQ0iWX1TfSlhKY8qbX21HhUwslRMIMIA9i?=
 =?iso-8859-1?Q?JgZU51GL8AU8rDZPK7wZRK6NhMOsZCm8fF9Xl6A8kA9CSvkv23NPn/irzb?=
 =?iso-8859-1?Q?togoyggc/2i75JaSPAAi+kUVSb+wlNXdaCzKMZo7sK9NWgIhitfHdXjxL9?=
 =?iso-8859-1?Q?lLEvDMQAIJX+t2/Yi4C7MiOZSZs+xxBpG2fKTgkyCt0J1awyraWakW5WpR?=
 =?iso-8859-1?Q?CmOJKq3m/AyGH6oxOjT8OXDz7ASp9Guve+T9+W6iSfUZRympIaC1n7v3p7?=
 =?iso-8859-1?Q?FhNRHZGfeSeUxE3sg8oIPaUkb5ND6OCBpT4/ifGyXes82JodnXn/pgvz44?=
 =?iso-8859-1?Q?EEwQZF95/B0x+V+FP1HcVi7mo6/9/Dy7naD6vjAxVBK2XCrfBKfkRv+/Fg?=
 =?iso-8859-1?Q?ssRbhdJgX/9Hw4ihWI08elXjZBAeYxgPlp09N6AWcS+I7MCrwHp9E0aDts?=
 =?iso-8859-1?Q?1Sqhapkzcmndk3UsJaDm07gSvQWLPXP/vaIXwy/wJ0+1s9E2P5CtqgxIfk?=
 =?iso-8859-1?Q?XBiZFobuThJcFjKjNyArtEaD0ZQLGrsqInad4d3u2lYHvkM4Fwaf8/D8UF?=
 =?iso-8859-1?Q?WCCF/6hYyd2cdeNBQcP5iCYsZ5IrvexEjdX7DskXfOPlTzFwYIOPXBrRbf?=
 =?iso-8859-1?Q?qY26iOXJi2qsyg5giHIND6jdqX19Pw9QzPnmwO3uogOscMJTxSPcNB4YEe?=
 =?iso-8859-1?Q?RzQQdCWO1N3gLjKem3JvZHOgfw+rLzGH/vhG3UpvHgbll4cyt+6CQ24cQQ?=
 =?iso-8859-1?Q?T19C1NMJEdzzwOkEWsswFPbX75loZ1p06ETv8+UNjGNQss0l4op6BDeJA1?=
 =?iso-8859-1?Q?qu0DX/vC6y/keV62x0bjTad8N9QjIqnVrvhp2y7GmaXXulI0cP6CAu/cVJ?=
 =?iso-8859-1?Q?AQm+1SDuQLz5NrfT2zi4tfRSDvEp3ZiZs1DdCh2wjZ7Ur3zRuXIeASK281?=
 =?iso-8859-1?Q?S/jtHjbOGqfSTvm0HhRybMKhnq0PO8Ie5ZfiELsNVVIL65yiChXkCNWqjv?=
 =?iso-8859-1?Q?s6j0zCDX7z+roM9HBttFUtfxtfZp8hgsU9cTRnSbKMv2+emgZekPU/gF7c?=
 =?iso-8859-1?Q?031DlepCzkMyJ4i8a0XjyMuF8Pw42fDIgBwc7DVD4r3VIZedKN7bKn5m5+?=
 =?iso-8859-1?Q?Qa4xo1/0MGiIP6tAZf1gDp97Dtvg88UULEfH2jgFXzeXJm2EK99V053IoX?=
 =?iso-8859-1?Q?UNPrYAeoRGBiqfz4r2+524+0LPBqS6l9ynbZn9XqbBasI3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gjeOWiIXrRybB/H49Hrd/b0G2DowG3XWFpOAwZTwcFjkPZFUya07qU4FojKal8Qi3fZfDiuzB/OvdtBUywkR47pTGBobmJ0tv6Cspx52Cn3domUh7qLegR25kNIpd19NKAOoQFg+LKxA+VyDE4Vy7LcVcrawtXQkhuAmU3qLPEHT6COUq9K2/wZbV0hx6NHogOsW0Xa4WA1aHF20Q0FZBaIjHDDd/wqgWGxHd5CaPFeIuh4n1pAVN8vzexmrXn/OW10jmyy3ut8A+QGJJoOZanUgahw+UjM7Tkk8UVE36exY+LYqTE/ftTJwQigRYNIGKL9YbIsKgRuMBO7iUqGsxg==
X-OriginatorOrg: wsu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR01MB994453.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f05ab3-a700-434b-d6bf-08df3ca9d6cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 08:33:45.7807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b52be471-f7f1-47b4-a879-0c799bb53db5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YoDpx+p8rm9EKDUw1Af7F0shEUL9E5qB227Vk9OeqgYoM+2FfkNMLfU99sZKra6YI7eW7aOzyFA3R8EMGFwbtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF3CBE71DAC
X-Authority-Analysis: v=2.4 cv=fs1J914f c=1 sm=1 tr=0 ts=6aeee26e cx=c_pps
 a=XVr+MSEQQxWnM56OsALW2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=WNJZbBgGTWIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QNy-vP4XruPnrUY3G42T:22 a=SQFY37l2tHPQY3hqUwSg:22
 a=qfGR-RWDYpoRiXhgssUA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAzMyBTYWx0ZWRfXwewdHYvWw8Q0
 dJTKpQj28Q1a6oqu+1MSwdP8YPm4c2HVY2c9SDngY1FpIsjE0JA6knt/ehB3eIWfxIAc+d4CRuS
 jFMnkZN01i8hYTh6usmvLYpCSAeSDPsWoTIyJDLPmSyT8DO5B8HAkAxtZr0l/XNaEEXG870uRHw
 8B+Lv4eRJQ+DkEQP0DStOtxdnkPxEUrl6jAn74u38OPae1qVCYZg8u9yy+36UatZC1utAcAq3YC
 ku99iaZSkVEHMIfWJmW/wtph3pqW6qSigtOyaZwDoWF0hAuaSbwV+zTgsgIZWx03OIt+uKNYhO6
 upgNQX39kKd42sTR9zhV9re5E9hoETlz4WuHj9vEC6QhXmx9QmIqKJwO+A5x6r1H+WCphH4ub42
 BXJa7bgmndCOQ8+AMmaMO2+EZ3iGL94i2+OQVqKkBEUUkxE6+tIYNss8O1bVR3c6LnSXN/Utvcv
 3lMXOrSmALFvEmhJ1AQ==
X-Proofpoint-GUID: tWc8Lx7XDemF_BfZ6zzYLclNjJ28Jsse
X-Proofpoint-ORIG-GUID: tWc8Lx7XDemF_BfZ6zzYLclNjJ28Jsse
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAzMyBTYWx0ZWRfX78N+V0xJgcJI
 h8rgXKB4fsyDgFxPIsHMXBCHT+9THtC5aQK2J6nMdopRl6pWhtjMlgOnqyyNqx0ua4PK2SiqnK8
 kL07CqtjtPsG7+Y4eqOmoxYUcRGXqeEdX9+KJFcAh4e5nB+RUqQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070033

Hi,=0A=
=0A=
I'm Ananta Srikar Puranam, a PhD student at Washington State University.=0A=
I'm reporting this bug on behalf of my team: Dr. Swarn Priya and=0A=
Dr. Basavesh Ammanaghatta Shivakumar (both Cc'd).=0A=
=0A=
btf_parse_module() accepts module BTF in which a DATASEC member=0A=
references an INT directly instead of a VAR, and the kernel then=0A=
publishes that BTF in /sys/kernel/btf/<module>.  The full type=0A=
resolver rejects the same relationship ("Not a VAR kind member"), but=0A=
btf_parse_module() never runs it.=0A=
=0A=
Trigger=0A=
=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
A matched pair built from one minimal external module with a single=0A=
per-cpu int, so that pahole emits, in the module's distilled split BTF:=0A=
=0A=
  control.ko  INT (distilled base) -> VAR -> DATASEC '.data..percpu'=0A=
  invalid.ko  identical, except the DATASEC member's type is the base=0A=
              INT instead of the VAR (one 4-byte field changed; the VAR=0A=
              itself is still present)=0A=
=0A=
Observed (current mainline, x86_64)=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Both modules load (insmod exit 0) and both publish=0A=
/sys/kernel/btf/btf_datasec_repro (199 bytes).  Decoding the published=0A=
BTF in the guest with bpftool from the same tree:=0A=
=0A=
  control:=0A=
    [152041] DATASEC '.data..percpu' size=3D4 vlen=3D1=0A=
            type_id=3D152044 offset=3D0 size=3D4 (VAR 'btf_datasec_target')=
=0A=
  invalid:=0A=
    [152041] DATASEC '.data..percpu' size=3D4 vlen=3D1=0A=
            type_id=3D107629 offset=3D0 size=3D4 (INT 'int')=0A=
=0A=
type_id 107629 is vmlinux's 'int', i.e. the distilled base reference=0A=
after relocation.  The invalid module's BTF also appears in=0A=
"bpftool btf list".  There is no oops, warning, or BTF error message.=0A=
=0A=
Tested=0A=
=3D=3D=3D=3D=3D=3D=0A=
=0A=
  - Mainline a91337fb5e8e ("Merge tag 'configfs-7.4-rc2' ..."),=0A=
    7.4.0-rc1-00590-ga91337fb5e8e, x86_64 under KVM:=0A=
      non-VAR twin accepted and its BTF published in 4/4 loads;=0A=
      control accepted and published in 4/4=0A=
  - Earlier validation on the same commit (separate build and guest):=0A=
    the same result for a matched distilled split-BTF pair.=0A=
=0A=
Cause=0A=
=3D=3D=3D=3D=3D=0A=
=0A=
btf_parse_module() parses the distilled base and the split module BTF,=0A=
relocates base references with btf_relocate(), and returns the BTF=0A=
after metadata validation.  It does not call btf_check_all_types(), so=0A=
btf_datasec_resolve() never runs on module BTF, and its check that each=0A=
DATASEC member resolves to a VAR:=0A=
=0A=
        if (!var_type || !btf_type_is_var(var_type)) {=0A=
                btf_verifier_log_vsi(env, v->t, vsi,=0A=
                                     "Not a VAR kind member");=0A=
                return -EINVAL;=0A=
        }=0A=
=0A=
is skipped.  The invalid relationship therefore remains in the=0A=
published module BTF.=0A=
=0A=
This has been the case since module BTF loading was added in:=0A=
=0A=
  36e68442d1af ("bpf: Load and verify kernel module BTFs")=0A=
=0A=
which is in v5.11-rc1 and later.=0A=
=0A=
Impact=0A=
=3D=3D=3D=3D=3D=3D=0A=
=0A=
Triggering requires CONFIG_DEBUG_INFO_BTF_MODULES=3Dy and permission to=0A=
load a module (CAP_SYS_MODULE).  I observed inconsistent validation and=0A=
publication of malformed type metadata, not a crash, memory corruption,=0A=
privilege escalation, or an unprivileged boundary crossing.  Per=0A=
Documentation/process/threat-model.rst I am treating this as a BTF=0A=
validation bug, not a vulnerability.  I have not checked what BPF=0A=
programs or tools do when they consume this BTF.=0A=
=0A=
Setup=0A=
=3D=3D=3D=3D=3D=0A=
=0A=
  Host:       Ubuntu 26.04.1 LTS, x86_64=0A=
  Toolchain:  Ubuntu GCC 15.2.0 / GNU ld 2.46, pahole v1.31=0A=
              (built with O=3D)=0A=
  Config:     x86_64_defconfig plus kernel/configs/kvm_guest.config=0A=
              plus=0A=
                CONFIG_BPF_SYSCALL=3Dy=0A=
                CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy=0A=
                CONFIG_DEBUG_INFO_BTF=3Dy=0A=
                CONFIG_DEBUG_INFO_BTF_MODULES=3Dy=0A=
              (resolved with olddefconfig; full .config available)=0A=
  Module:     out-of-tree, built with M=3D against the same build tree,=0A=
              so kbuild emits .BTF plus a distilled .BTF.base; the=0A=
              invalid twin is the built .ko with only the DATASEC=0A=
              member's btf_var_secinfo.type rewritten=0A=
  QEMU:       qemu-system-x86_64 10.2.1 with KVM, -smp 16 -m 8G=0A=
  Guest:      Ubuntu 26.04 amd64 rootfs (debootstrap); modules loaded=0A=
              with insmod over SSH; BTF decoded with tools/bpf/bpftool=0A=
              built from the same tree (v7.9.0, libbpf 1.9)=0A=
=0A=
The source reproducer (module and BTF-rewriting script) is available=0A=
privately on request.  Per Documentation/process/security-bugs.rst I=0A=
have not posted it to the list.=0A=
=0A=
Fix=0A=
=3D=3D=3D=0A=
=0A=
A proposed series runs the existing btf_check_all_types() in=0A=
btf_parse_module() after distilled base references have been=0A=
relocated to their final vmlinux BTF IDs, and adds matched valid and=0A=
invalid module fixtures to the BPF selftests.  On a91337fb5e8e with=0A=
the fix applied (x86_64 KVM), the control still loaded and the non-VAR=0A=
twin was rejected with:=0A=
=0A=
  BPF: Not a VAR kind member=0A=
  failed to validate module [btf_datasec_repro] BTF: -22=0A=
=0A=
The focused selftest fixtures built and passed in a direct KVM run.=0A=
The full test_progs build could not be completed on that machine=0A=
because its Clang 18 lacks address-space support needed by unrelated=0A=
current arena tests.  I will send the series separately.=0A=
=0A=
Tool transparency=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
The root-cause analysis, original reproducer and proposed series were=0A=
prepared with the help of an AI coding assistant (OpenAI Codex).  The=0A=
QEMU/KVM reproduction environment and the reproducer used for the=0A=
results above were set up with Anthropic's Claude Code.  I re-ran the=0A=
reproduction myself and have checked the statements in this report.=0A=
=0A=
Thanks,=0A=
Srikar=
