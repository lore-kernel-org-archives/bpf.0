Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.39.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795097419;
	b=hYYPINaa1+Npb/xHV2HbM/0aURIj7Nnl+Wy0V4tLvMMk3OKsrJLfSzlZAGJXTypQ1TBo
	 S9PryDwUTytF5BY6+vEZ2IkspnpvreUb13Q1hXhFixH50NSt0CMODbjaQyuwYuk70sUDM
	 7CIFzSbG+pGLnpUwYPQs7F4A/mt9BL6jnvF/tsrEgqMJ+hMfh9h30KLvMEaUhbyQ8wH7y
	 pSEJYEbyrTuLmN396uBs4dJ2ASdUjU60W9uckwNIwXZjKy+q0+uauzLT5mEoSeGAcjX46
	 dkBH6AtGmCmGmhzfkyScFk2lLqAdLK+aKT0xIbY5NoGdikhz2qIXPmsMUJABzPPGSSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097419;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-exchange-messagesentrepresentingtype:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=78qMs8DZoCCDmNgDd9yWZcg5aFhEw1zfoCwIu8VPa4c=;
	b=piiIsxzZzFlCwE24Cxnsga56oymiRbtaeAii2Pdkv1eW7nN5n6WobdF24lZ3m1HKSd0q
	 u8gGNTl6e7J7gXk/K4DeNOQiwjERV043tMmv8Glnn70tx+EVpZnRy6WRHqc5DLKF0cYSo
	 AJHoHBBL1qBOfxRFpT5y75GqKBId23hfbucwJjN5QocFW0RUM73y+SfjMhD5ccOE6jbWs
	 WKtXPuGw3Dnpj64Jj3AseK6+sVRelVMIwKg0ylSrHq4wcTawfR/GzX59c3H60YdOhIeds
	 aH+p+oVHdVjLi+JSxbPLM9+/sXqCoUgUiNrSSfJFZaa7NrOmT3GYGKyTGaQ6WN7P2Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=grofrd+3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.39.32
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011032.outbound.protection.outlook.com [52.103.39.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814BE606A320;
	Thu, 19 Nov 2026 14:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814BE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=grofrd+3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqWZ0alOy8EitfYXlfO7h6vCvqNMDuRAmIyFyA1jq70PViqNBcHEMCWTL65fPS9lyCjfibd4lCLMWPU1YfTv6LkVGApmxEn4UhYiKNcGT7KEJQIvnuF8B8ePaQbADesjnYgeiOykIfclk4e46TTdybUNA1vTezMdoLiCm/xScJ8TF2bVpassN4n7BPvug29DjqqHmd7BGs/bsevImUaFzw2byxBB20pedBMyK69YHlkrWMSDFkJOgqzCIVMDtTqSptzJ/sZ3rG/yeaIp6bAPe9qH5NRiok1Z6A3LBxPdtciv7I+HktIrryjwThwNumpFLmlDXcefv/J9rHxB22cmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78qMs8DZoCCDmNgDd9yWZcg5aFhEw1zfoCwIu8VPa4c=;
 b=Wydbb4HuOy4Jlqcu+bJY/0Lh3YZ90Ig/AeE5E4yV/eKiL2kvgusm2nuCiZEfHsBp0hirHDyrljrbHom5DVDhpAFwWx/yxnlMusUQTd+c96Aa1vsjpPsNbY3la5iBE9MK7h23Bq9C0BwTEP5sdR7wr2ZIzQQS8WnW+EhhRsPGond2l44SBu4SWgslYfg8Soql+yfWi/kcBFvENmPpmuyQKLDlxDPk/yuDK2bBuKAvQluJMQ6vqXvkFk2tbA0LxFsen+QhRtDGpcwPDAuOPlp6qt0oyXWxNHSb35pOBKIh4eXZipCuR9vGdh/173bUl1UKyP07VjWyUUPUi32vO5Ox7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78qMs8DZoCCDmNgDd9yWZcg5aFhEw1zfoCwIu8VPa4c=;
 b=grofrd+3BRz4+YuOER4HajW1bt3E0eqnAg4vzmK1AV1pJ9OnodcBrIl3E7q6s4+4BiM8r6wWkuYMdKmAOv5UQFcp6HFKVfNJLJ+9/QDq8FZNE+gnEEBLH/DcAuxXZ2+myeLcsgfXXMHW5GxlCexuuHYg7GNm13jPORGQtstCqCgr88CyCTw7PuVj3NUpwoSMahvjKncMZg0NxRSNb7rtb5JJsisxB+hS0ib1B0nS41doqLaAZnUUiavdlsDhFSYHcjxa0jDI7vJgELRtVKrNKmeGgDdwtKgUQVh1gVF8BIoY+wgyD/mejw6vmo0/ySbJsQXVOhMxadW/C6WRrUC29g==
Received: from DU4P194MB2971.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:641::19)
 by VI0P194MB2246.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:249::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 14:10:15 +0000
Received: from DU4P194MB2971.EURP194.PROD.OUTLOOK.COM
 ([fe80::e38e:ed60:52c6:4554]) by DU4P194MB2971.EURP194.PROD.OUTLOOK.COM
 ([fe80::e38e:ed60:52c6:4554%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 14:10:15 +0000
From: James Sawyer <jamessawyer@outlook.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Bjorn Topel <bjorn@kernel.org>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v2] xsk: set network header on skb at generic transmit
Thread-Topic: [PATCH net v2] xsk: set network header on skb at generic
 transmit
Thread-Index: AQHdeC4ypPphz0MtZ0u7s+7q7Zy9Z7c1bwkV
Date: Thu, 19 Nov 2026 14:10:15 +0000
Message-ID:
 <DU4P194MB29716D57A08053EAF2AF4F8FA7792@DU4P194MB2971.EURP194.PROD.OUTLOOK.COM>
References: <20260901083325.3445-1-kerneljasonxing@gmail.com>
 <178847847848.4131868.16090144540850507396@kernel.org>
 <CAL+tcoDpyG-Hy9mtDnLSGu0nvU_VDqTjs-k51r2+OPwVyHtABA@mail.gmail.com>
 <CAL+tcoC=w6j+1p8ovjbLxgb1QdL3ipic0nMOvX_9OJrspSQS2Q@mail.gmail.com>
 <arKm5gCaERk6MaGA@boxer>
 <CAL+tcoB8f7H1ptcEk1iVH065AcUNPEL2V1gKoJacwr3zndfPWA@mail.gmail.com>
In-Reply-To:
 <CAL+tcoB8f7H1ptcEk1iVH065AcUNPEL2V1gKoJacwr3zndfPWA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P194MB2971:EE_|VI0P194MB2246:EE_
x-ms-office365-filtering-correlation-id: 7ba70778-ed02-4bb2-4157-08df4646d586
x-ms-exchange-slblob-mailprops:
 feAVlmA1hHWA2BEffU3cZHEVyr7UW34wLpNMP1PuH2CaHteYM1sGkz8P07PqWHBdtNN1JMXO9NURPK3JdVWlvbsWKneghSmTR8Q3ER5bHVOsr1HPwRtkftuOw5PBwTOL1WdrKd+BXrf2ZBxInELDEV3KUnGDIrwXbNiWOUatMz8yFplYSMbWDM4Ox7PjSvcdgexBSx1NelazA4BMHCexdPnTuss8p5G6cJfuW/tYi7Tue6eRJc1zQnuJHLi4wJ5NQCEPw4+9jMcEitE9sR+vLIwB1RI3tL0y49XHmnDwUzOLcDD6CUEIz/jTR+I/vhFw3nXWaxMEGa1VaMat+kXONAFyb5UojoFHJEvDvcchqAAxz1AhtyL45H8Ktm8gxc6iPFUymdkYrqGlV8R6R/NH9wgVyw0PduBGaSBs/DGwf1EBdGmaMPoruMTOMwl2T8EEiftYOm1Cm5q//ASHHNefG24kwsIbG7NYr/2zvFidwbD6t1djoNZzFnwXPMRh10oQgZNCK+7xRp6Bf5tdS3OEktN3v3fSxp7VPe3mT1IlwPGtxCFIK2T4pbQp/U9EXycD4MSmCj1ZlLyBK22bPbDI6xozWJHSARHxGr+Xs6ncGNgJ36dUSwbsLAgUcGkTOk1qCFNzgULtGDdbd066mBqIBWne/5CEfb5DwbNw3ICpMcLbA4WUIpcnYumaNBFVnjuyshbnXdrwJwTq5pz/m9RtBw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|4140399003|25010399006|37011999003|8060799015|55001999006|22091999003|24121999003|19110799012|8062599012|38102599003|15080799012|24021099003|25031999004|40105399003|53005399003|260806224601699006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xEB9mvx60WWAZ2E+4GV2zNZ0M6uRIglwqFOTW02JZSGRYDtV+t7geza1CgcE?=
 =?us-ascii?Q?xdJnEZnoxE+7lDBNV1ZvQrurNw1uoWT8UuQtPMbtYrBSnSRLmYf7+DZy39hF?=
 =?us-ascii?Q?00W0vjOct+0JQddBCpZvkX15DK6Lk9iEI+8ntQkln67ry9D1dPAD2i30yWu/?=
 =?us-ascii?Q?dbfkcu0YcP+PfT6sab7v/X8PYSQtYK/BtZKpDxsIh9gfsP42norZegsNOQFA?=
 =?us-ascii?Q?EHvqd1F0jnnM7o8b863OA4bsAjMxQDWqSTKq+HnAhygqQGTdi41o2V6DjWjc?=
 =?us-ascii?Q?/VXZPZUnaA2yJKkalHosjbe2ppzPT9oKE3hIvJocEXuKEP+zPPPvKzbWc3WF?=
 =?us-ascii?Q?wR0IQ7b9F00kR5FTG4cNYYiSsMgU/B4KkCveGMhiGIhYz6mPEqZ/THFqvNXI?=
 =?us-ascii?Q?TAq4PbmvDz4ZMPXKV2NVsD0XSNem+frzNMMuf9MesV6vcrT454Ol4z54zSNS?=
 =?us-ascii?Q?q9xnm7CvLLUc0eXw26PiZ4c+hP4+iYU8bTst8SqCnczrpJqcvEWHc7ANAoqA?=
 =?us-ascii?Q?E96HKqZKywl0fUAQcUCe5D1rSEEcKkCrKGVLwzurrPR4qBWJqkaTFkDzIsoc?=
 =?us-ascii?Q?XEc3flCBQ5UODwZF4HiFf6MONHyiVhZWI/uB2jivzP8JUsGe3jWxvkkbOvKu?=
 =?us-ascii?Q?M4IGAnhLP35yfp3Wt7eAW952p4A7GdeJzJyT3zVETpSPYb/UlK9GO64o7WFr?=
 =?us-ascii?Q?FDv+GvR+IrChdP/y2HYfieAGUWMSBRomng/xmEJZDjQM/qZI0tnhXB5MbFhO?=
 =?us-ascii?Q?O84MPfnEm7Txviqjvuh0Gzs6qCz6lqNvixIB+jcJrtBiITUaPMsGCBQQOFqH?=
 =?us-ascii?Q?kgk+aMIINtA2uXOdfhpeRos7MSg8YTfGh7ybnQduh3EPIf58mWPpRS7ok8y4?=
 =?us-ascii?Q?oXb2o2AF/xOMWn/Vubd6276VG28MGK7MDdFtpk2d0/mK2rIsy1aHc9WoaKph?=
 =?us-ascii?Q?V+ec8zBMvbfQuRByf2xQaQhtfLcmNLKpT81B5eS6iD+AVoy75+rHONQuea4F?=
 =?us-ascii?Q?ZH+Uvla0lBgluY57YusNuU5XREE0SDEZ0n+JjchRIzcAAQXYbcDFGrXnJx6R?=
 =?us-ascii?Q?AjxLQnMnfezelyoCwdr5XRNcxR4da2ActcBeVUJ91gH/ueaE7Jbbjm6wvIrS?=
 =?us-ascii?Q?P+d9H15LlbtYwfi/80ZB2gUF6mLgTYf7A3rv21Fn7pckrGCAz0xpr1E=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d2Dh25fTOT13deD0RH1rWGiPdkY2k6uYkmSiRgCJluO2ReDingO9oWSk3c8w?=
 =?us-ascii?Q?ZXVQMgvQtQuhWVaVocWxTZybcWQH9PlpcF5qcEOVbIdIbtgmfaBnpn4yuf/m?=
 =?us-ascii?Q?qzK5jDpKITGNuZ3Jl9iW76UFraINBif7l6kxuZhXCwG9E1z7pQdamRd6cYxP?=
 =?us-ascii?Q?KcTPytDvfTcnJIvCIzVMldba++doM76/bcTaHvlBsxNcek5Rn9PNKGmM3tMM?=
 =?us-ascii?Q?5iGPCAQKI64VTc8prJYZsEqkvOQ6RKusAOlzSqOAorOnMujNxMuonpOXqhPH?=
 =?us-ascii?Q?8MPcLUkIFaabI6akZaIu3rQ3FlhtufVyx3wSSSIOnAerg48B9fehpLViVfgY?=
 =?us-ascii?Q?Fsnr7a2NkcdgrbVgWqUqnWfpHH1uv1N9gNieudyalCb0hRKe7f63J7ktVP6C?=
 =?us-ascii?Q?wtr+qdsJXoL89hC2/9o1CSkoNyYXNBPRtVtXSbshCwJPBTIY1W1GwQGmZuH0?=
 =?us-ascii?Q?XNcCVKBeo+Dqty3syIdrLNmUqUeEDgIdhD822Hc5JjMV967twv+pdtWs4aCt?=
 =?us-ascii?Q?F5P1uJrLrxUW5PmqGY3RpeusCAzxeJyVkvn8oy2DR/xr8Kz6mQIdFO+9xjc7?=
 =?us-ascii?Q?07scReUWVUK81DYBslHImP87Gvtjm7iVgzJEntXpmok7HjIVdi4brYJZMzym?=
 =?us-ascii?Q?kheJiUvwsdpZMQNlFH1EN+4mAYbltBwlRylaE/VuUTtvMO0fm66gSlK5NxjW?=
 =?us-ascii?Q?mS815BC2Yl40Ucjlpb2n9ziuoYpWvxgjK9heCF9/JbfMc4WQh6vNBJoaE1wJ?=
 =?us-ascii?Q?BazbQp4F9cewDA9vl/qIYAQ3n4YNMJnt5EgYlbPm3zf3mGoRgLVuO01QcjqW?=
 =?us-ascii?Q?/UToYVqHAemRRaggdyYZaDraAF2xZK1xZG5S5dxPu2Au7BW12iaEG9+eZzUy?=
 =?us-ascii?Q?3M4yfuF4SJ2eicfLt0MhL4thJCpf4tqeZLR64lSjCuLeDTzH+8llf42plLiS?=
 =?us-ascii?Q?ghiQ6GY+JSmEzGFWoq4jwpu0uqGktJGKKuIlpttC2AesvgwDZEA9aNIjycEG?=
 =?us-ascii?Q?+ZiiDpJTVML/UlG/kRW9MncnDxq+hhXFM17Dt1tcsLFUsq9zM4rW03rplzi8?=
 =?us-ascii?Q?YNkLDy9VnA5TNfIWJEzb64IMteoyqOFLYqwqg1mX0PUjep5ai3ITpxr7lINF?=
 =?us-ascii?Q?zRzSAWaaKTrJaKmUKmbEtH7GM8Bwmn5+KYG9z3JO8X8RhPMFJ2unn3L8Rpmv?=
 =?us-ascii?Q?YjtVW+2pPKZdiV9EN94DgFG+Kfpdg4MnucehzsUQhNTy5GXtXY4XtRCJ189y?=
 =?us-ascii?Q?shlO0NVv77NH9+vNAtR8C62v5GyZz6OZLI/P6x6/y9kNTPYy5pqfv8j53pez?=
 =?us-ascii?Q?X6REtWxVgk+cswXlE+2Ls3o1GTa0uQ0cC7jUIiVbtTMTriNoFuFURVmBFay0?=
 =?us-ascii?Q?9kW15++OdtL4omOs3UaMjzH/g0Iz?=
Content-Type: text/plain; charset="us-ascii"
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P194MB2971.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba70778-ed02-4bb2-4157-08df4646d586
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 14:10:15.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P194MB2246

On Thu, Nov 19, 2026, Jason Xing wrote:=0A=
> James, I would add your tested-by/reported-by tag if you don't mind.=0A=
=0A=
Hi Jason,=0A=
=0A=
Thank you, I'd be glad to. Please use:=0A=
=0A=
Reported-by: James Sawyer <jamessawyer@outlook.com>=0A=
=0A=
I tested the v3 hunk (skb_reset_network_header() at the top of=0A=
xsk_skb_init_misc()) and it closed the issue. I will run v4 through the=0A=
same test when you post it and reply with Tested-by, so the tag matches=0A=
the patch that was actually tested.=0A=
=0A=
Thanks for taking this forward.=0A=
=0A=
James=0A=
