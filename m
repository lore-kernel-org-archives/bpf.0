Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5853CF660
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516394; cv=fail; b=Nv2MG62j5oRTS6IhsBQ6bwzza4J5quHuoT8vpd1QfOcjY3JA5yf2qzHhJfI7YCqqqlkt6vHIHySn8Ydv7mUBhIFcZ/Q33mLw38bFIqWoqKJQwjOmU4NzkjWPIg2uQnqJ50/b1Ep5MggaJheD1GNwp6ygOkdgrI85v7nJSKQppD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516394; c=relaxed/simple;
	bh=aK6Pz90FoSOcyuX3m1ROuSCKcXBHJnR5TNDkcht43O4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TWO//UJS4SuaGhINMKjw20fV18dfYaz5DFwhfz9o+Co7GnKL0Li9uM/NYeTQScJOrn1aeShNS9exVpiVxGU7IdCbEOgzepfZdtnDVry83/I6wvUSWswzQIv4Ry6HXWYn1GZaglv9GuA1Wj8D5bp4uNhS5MM7fG1kn93uAZ2Kw68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=gVya6i/h; arc=fail smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="gVya6i/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2662; q=dns/txt;
  s=iport01; t=1778516393; x=1779725993;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=aK6Pz90FoSOcyuX3m1ROuSCKcXBHJnR5TNDkcht43O4=;
  b=gVya6i/h857GD49WBRmCBSETUlfq3SItTWieSkqqLu5MVt6PLgzOR4DN
   bacPVvXyH2pi3ujpa/0EZU3itlLUGPDA2usSAt8wCboEtAFcYfwKb22Bt
   5EJo5Zzk6Exk0zDSi5vyJyxbvIlw+b4wudLUoKNqohCXiBnvaDEOa1Sdc
   amXa03OtwZsbsxWv7MGevn5a+coTzGrOC3I8Aej44M7e6Z7PuYkBGvnKf
   Gw2YQB4SoRBbega5pRSWMkhD68NE377bQIaX5ziwR/Sfrg0l+9vQl/VWB
   5aCKsAAlZfs6GXJKOGNKAlYkxxwon30LJqnpDHjVLBkQCXxxVavb/xwdt
   g==;
X-CSE-ConnectionGUID: XEOVAYL+RnqI1ec87uVvKg==
X-CSE-MsgGUID: EXyjTySQRuGzKra3vkB3SA==
X-IPAS-Result: =?us-ascii?q?A0B0AwAlAAJq/4sQJK1agS6BK4FuU4EGAoEPEkkIiBsDh?=
 =?us-ascii?q?SyGWIIhA5g8hV6Bfw8BAQENAkQNBAEBhQYCjTICJjQJDgECBAMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQEBCwEBBQEBAQIBBwWBDhOGTw2GWgEBAQECARIVYgIBCBguMSUCBAEaE?=
 =?us-ascii?q?weCYYJMJwMBAg4GqSgBgT0Ciip4gQEzgQHgKwaBTYhZAYpxJxuCDYFXgjA4P?=
 =?us-ascii?q?oJhAgKBXgKEE4IvBIMwjl5SeBwDWSwBVRMXCwcFgSMQMwMqLy0jDzwFLR1wD?=
 =?us-ascii?q?CcSDx0XFR5YGwcFEiEqbko8LFwaAwMNISQRWUE4C0YFgXACgh4ZXyMvA06BB?=
 =?us-ascii?q?gMLbT03Bg4bAwSBNQWKIh0PgikdXzUQIIE+pVahegqEHIwelXAXqmsuh2WQc?=
 =?us-ascii?q?yKNZ5U0P4UaAgQCBAUCEAEBBoFoPIFZcBWDI1IZD5IjxTZ5PQIHAgcNAwuTZ?=
 =?us-ascii?q?QEB?=
IronPort-PHdr: A9a23:0vAcmRU+rl6mSJCjPK16H3XDPRjV8K3PAWYlg6HPw5pUeailupP6M
 1Oav7NmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QcPs=
IronPort-Data: A9a23:7h+ww6A2l6PwBRVW/2riw5YqxClBgxIJ4kV8jS/XYbTApDN33zcPn
 TAcXG+DbqqMMGH2fIgjOdmw9EsB6JWAzdYyOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jWGthh
 fuo+5eBYAL8gmYtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE89hJMmgHGc4i/P9WWGxFp
 aMFFi4uYUXW7w626OrTpuhEj8AnKozveYgYoHwllWufBvc9SpeFSKLPjTNa9G5v3YYVQ7CHO
 YxAMmsHgBfoO3WjPn8cDZUkguqAjXjkeDoeo1WQzUYyyzSDlFYgjuC1YLI5fPSnddRXolejn
 1jb0HbaGBhBKt+1kgGspyfEaujn2HmTtJgpPLeg+NZ0j1CJgG8eEhsbUR28u/bRt6Klc9tbL
 0pR/m8lqrI/sRTxCNL8RBa/5nWDu3bwRuZtLgHz0ynUooL86AeCDW9CRTlEAOHKfudsLdD2/
 jdlR+/UOAE=
IronPort-HdrOrdr: A9a23:B73ijaBd1Uh8ao3lHeijsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskdvZJhBo7y90dq7MA3hHPlOkMYs1NaZLUXbUQSTXfpfBOfZslnd8mjFh5JgPM
 RbAuZD4b/LfCJHZK/BiWHSfadDsby6GeKT9JrjJhxWPGdXgtRbnn9E43GgYzRLrWd9dP0EPa
 vZzPBq4xCnfnMaZNm6AH4qY8jvzuegqLvWJTQ9K1oC8gehsROEgYSWLzGomjsOWTJGxrkvtV
 PCjxH44aubtfS6wA/31mPY7Zha8eGRi+erAvbituElbhHXziq4boVoXLOP+Bovpvu01VosmN
 7Q5z89IsVa8RrqDyKIiCqo/zOl/Ccl6nfkx1Pdq2Dku9bFSDUzDNcErZ5FcyHe91ErsLhHoe
 B2NiOixt9q5CH77WPADuvzJldXf42P0CMfeNso/jhiuE0lGedsRMIkjRho+dw7bVPHAcgcYZ
 lT5YfnlbZrWGLfSWzFtW9yx9HpdHEyEhCaBnUmgKWuomJrdLQT9TpF+CTZ9U1wqa7UR/R/lp
 f5G7Utm7dUQsAMa6VhQO8HXMusE2TIBQnBKWSIPD3cZeo60l/22tfKCY8OlamXUY1NyIF3lI
 XKUVteu2J3c0XyCdeW1JkO9hzWWm2yUTnk18kbvvFCy/DBbauuNTfGREElksOmrflaCsrHW+
 yrMJYTB/P4N2PhFYtAwgW7UZhPLnsVVtETp78AKhizi9OOLpevuv3Qcf7VKraoGTE4WnnnCn
 9GRzT3LNUo1DHcZpY5ummnZ5rAQD2KwXsrKtmpwwE68vl5CrFx
X-Talos-CUID: 9a23:bBP3fWzD5YwrdBvsgn1eBgUkN+cbW0z5j03WOm7hBG05F6CrV3yfrfY=
X-Talos-MUID: 9a23:C207PgVExhlTRfDq/BLclTNeJfxR2bmBGmMXmM4YuOPfDgUlbg==
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-02.cisco.com ([173.36.16.139])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 May 2026 16:18:45 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-02.cisco.com (Postfix) with ESMTPS id 782A918000149
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:18:45 +0000 (GMT)
X-CSE-ConnectionGUID: 5a/W80sSQsm7whiHpufNbg==
X-CSE-MsgGUID: o4cVWwTrQTCedXkHyeZvww==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.23,229,1770595200"; 
   d="scan'208";a="61009118"
Received: from mail-co1pr07cu00103.outbound.protection.outlook.com (HELO CO1PR07CU001.outbound.protection.outlook.com) ([40.93.10.91])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 May 2026 16:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lehJgag7CNlxVXxfedmGYDAXDC+d/7ipYP6WJueZZ3vskgOj1diEst9fAcxSAzHcOP2LgwZvd3f9ZlWkNL4tIusSpbeCjZX0Lyii0Msw+UfjDAtMvLPQtSo7WVlrSSDQG48Datayypzv02KWtD2jyk2n7I+0FEEfF5WS4klbr3cLgc2ggcJXR9o9/BfbeIrm+qEAGimITAnI9qsQtKvLkC1MAruMdX1hVY27QvWsgNk8oMhix5GYBcUIFCDaLNB61A1B6k3llce7LT1yxawQrCjk+ZHU4u8NHgvVxLCGJlvxoRDL/JzNzE2Q4AJTqXOsDHpaPz+HoA9UwraGWn2lDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK6Pz90FoSOcyuX3m1ROuSCKcXBHJnR5TNDkcht43O4=;
 b=a30fOl07aRRntXHM3/VreCfRu6y3QoB7a2HlS3CfVTznXGZUNEv/f2toOM+pemPu49JB0WoFYsTO0vUxCM8B9VOLw3n3rRQSpCJS5+EBYkf2VrnLgH/Lx92JmROtNOG+p6AoPsl4Rn+yVvhjA/D40VD1ALJWuAwY7bD6DG4Qve1OvQHVtE77FkFdJEMRSQkGdDUeo/2l7hxKAURGFFkSYqSJQ4a1xeAyfS4az0JMiZoxYN9hKNBs8/BKpmRWQ8TquYxUVpF9yEozoTIFlv7YzuiJfystbbwdjC+01fqZhyi10I3zolZ7mcnx+OaGvr66LSp7LotD/P++hPbSLnSWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14)
 by PH8PR11MB9880.namprd11.prod.outlook.com (2603:10b6:510:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 16:18:42 +0000
Received: from SA1PR11MB6848.namprd11.prod.outlook.com
 ([fe80::1e26:8f73:29d4:cf05]) by SA1PR11MB6848.namprd11.prod.outlook.com
 ([fe80::1e26:8f73:29d4:cf05%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 16:18:42 +0000
From: "Cristian Morales Vega (cmorve)" <cmorve@cisco.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: Re: [QUESTION] BPF_SK_SKB_STREAM_PARSER cannot observe strparser
 orig_offset?
Thread-Topic: [QUESTION] BPF_SK_SKB_STREAM_PARSER cannot observe strparser
 orig_offset?
Thread-Index: AQHc4UzcdZrP+t27EUuP1HlEy6a7N7YI+foAgAACGj8=
Date: Mon, 11 May 2026 16:18:42 +0000
Message-ID:
 <SA1PR11MB6848CE0D74476DA27BCA6091C0382@SA1PR11MB6848.namprd11.prod.outlook.com>
References:
 <SA1PR11MB68483E0B4C78DA91FF8DCE7AC0382@SA1PR11MB6848.namprd11.prod.outlook.com>
 <ec18cff8-a760-4bcb-b5bc-604924ff81ec@linux.dev>
In-Reply-To: <ec18cff8-a760-4bcb-b5bc-604924ff81ec@linux.dev>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6848:EE_|PH8PR11MB9880:EE_
x-ms-office365-filtering-correlation-id: e55bff56-4a5f-4bef-094a-08deaf78f805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003|11063799003;
x-microsoft-antispam-message-info:
 3PTOEbvRhQEJNf1JfXAIc+JubqGNyiTIwTZ0mMORjaBcVXmVdkKXZ/wlkHqufQWQL167tECp/gK0rDE21DX73u5m6a/4uk9OiT3nTxQWBySXdxLsdcV7Z7Dpd9BsGc7LznozTWP5kOD2H4ntOJuGE0IWJLH9PI9aFL3H9G73GrlgV0YtrXNlqOk+iSIqf0BCQDPut10MC8fo8kftjQzcdMZTWSLCoUoK6uj2mLMr73retayKsw0Rwx6M3XnpCeBD+hS9KfantvxqrcCpL6JEkifn65kE+MDyzxAfkDEvMcgdKMYZpb/BziV+7C2PODwmbo/dXBnK4BISX0AgObWwxt75zJKdplX32kXDRULw3Yk8ycnfMTiGp2N2Q3gjdc8v3Gv/A2B1CmdLA3+o97AInFNTCMtSVyhxxtog0bEyJgIhTMrrhA/5IoPSAEbCLPIozU528TO1PmTsLxd1RU0pRFRkNxCYrniOVWchkegPRPZqpt3tlCprkEZJsAepZCB7DJshz14kb782SlBKIebpLu82ifTWsFH63sncPui0vFxaRKmX34vHuBBCw0LX1pYb2mjUokVU6aLyAUF65SN9I9K3QuO0eFbhGE4jkL2qNYEE5RuNAN9X6ungs+J6kyjRO/Umkzai7424xo8jc5B4lJyBYgiLohCO74Z1m/8Q/F7JKKdctkjzIPincuSESX7NzYg30J09L6ygj9qVErlFEg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6848.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?h2PeEXQvAn8BQp8nIoTJFYOSgXL52CQFB+qV5mc1LLOaB3BQ+XtxpdgAw/?=
 =?iso-8859-1?Q?den0fMXpENIcSshrXSJ9OktLkHmzT8mtk1F39SXhOr6wVeA2V3dpBohuTO?=
 =?iso-8859-1?Q?NK0ow4FnppbVDX6oHUWXOH5M48pk13N0pt+5eIVw4buGHO2x8tB9nk71KG?=
 =?iso-8859-1?Q?KtMrV6/8Wg50Y5oCqKq5IRkTQHWSnLZMziKTHy5B7EpTkuIsNMNz1FhkDD?=
 =?iso-8859-1?Q?HRfWjapk6JnhrV7qW0uY0DJNeNxMym2uyJDVVjBRbU7HH6MIQ+s/1apqAL?=
 =?iso-8859-1?Q?alfNkL1ndhMC0qD2pU+yw1UFiLtOsnxaYHyQNPbDsCgFPNsmoucmG4ak1/?=
 =?iso-8859-1?Q?DmUO+tXrS3DzNasOJg1lvGarHFPCBVPQWuuGcuTdzuMqoIHmEcY0eiisNY?=
 =?iso-8859-1?Q?d51l3SISoOyhm7Y8TAJ1aFPRZR08zeA6DR91162qvomNJc/RTon1FqrcyW?=
 =?iso-8859-1?Q?WgaSPCBsEWkTPi4FFNadRZ80/ckZJsVQ6eIl3zq6U5BWmPjISU6zUswwmj?=
 =?iso-8859-1?Q?1F4D1+cuMvxj448TITkZjvCyc57icfkUYiuSaGQ/cljQw2PE0J34qO74HJ?=
 =?iso-8859-1?Q?8yeRGSwSKMk3DBtO5i//O8atubHK0rd/RAFR7cY6Z2oMjX9fo/zl+htz1+?=
 =?iso-8859-1?Q?S3lBLDNH0MU4Hn9yK1bn1X1MGB6f/gEHYsF1ALaXpCuTIRVn7/dkHA3rfU?=
 =?iso-8859-1?Q?54I02WHr6CUQVh3vJOAliVTnVbch7/BaqKiUMf+MkciDwXWmNPvg6TXx6p?=
 =?iso-8859-1?Q?L8g5ELJ5Pc1luFDMWWDWOq1PuppzdX85FXr0OJRG9aVzIZO4Gqd0TrSCE3?=
 =?iso-8859-1?Q?jPxk1cOXz83NuC6eaSfNCMVMw/i+TS9/kZpbaI1FaTBPnsZ76hVctjFSrZ?=
 =?iso-8859-1?Q?L1IL8JfoVoIduwFk2g7EpelLm1bQUZCW4d4DPXxHbAkNIoxROp406NVb0n?=
 =?iso-8859-1?Q?GpQ+j2nGlWTTcdtS7oVCUXg+8DhHU1HOOoT8+xxBriSspt8u3e9fvnsKyZ?=
 =?iso-8859-1?Q?iXlQBU8sPjnfe13fAPfs6QETddERBNO1UgD+ROTiCmor7MaYyD8wbP4zAx?=
 =?iso-8859-1?Q?tMrRLZ94I3VbTm6Gs3V1snaqJIO8CpasIoqWALj09O0yg/gANsvx3pdNKr?=
 =?iso-8859-1?Q?2H1pHbf5jR9+bKpa8p4SBOukbt1rrF7YDpTRwhBZWMSUbyXdcmTtG8DAQL?=
 =?iso-8859-1?Q?OlCQTqovK86ZNtJ9ss+K/m/r35zB/9l0JNY94CdK9+lpWq1FPoqU63CPQv?=
 =?iso-8859-1?Q?gNSgh3508tnCPDN3zP6IlhMMZs1zvaWsL9BhoKMFJjePifhVdNEq/+rR2C?=
 =?iso-8859-1?Q?XxENqaD8nNQM3xEHT0SS1ojua+2bJ+kmBFApjLwaBr8ldYF3GivcGzDWBZ?=
 =?iso-8859-1?Q?fT6TmtYMartzHpM3Xq1ZBgWlm089GWEjtZYHd5WGWr1G6zTUmkXls9XrQe?=
 =?iso-8859-1?Q?ebFfg7n4f/BKU9EJ6kqDY1ubJIZBnN4FKvOh0QhQOmDSPtn9ZeivptfXdk?=
 =?iso-8859-1?Q?mbeDY7JU0LGT5uKck82g+13PaDcjt0QjU0kACAAsNTsaaxlPUnA+aMUGgJ?=
 =?iso-8859-1?Q?QrESF9Jq9+Qp+bA+trOxeA0ggxetrelmZk+aWJXVclzOExpiaSoEE2Qxx6?=
 =?iso-8859-1?Q?UlSWq5EbwARZ752nKvvJOO1jc7IlxtHr31WJRhBl/kTE+bOy+gT3JefFwD?=
 =?iso-8859-1?Q?FN8rXb88LIvpFH7kc9HIF8UAn1rbaEVOPr8jDpAnZ/ov7wuiHafhGP0xlH?=
 =?iso-8859-1?Q?Lj2iX/nQuQNOuExm0uRLy03cyIIVdC52QU/84e1oO/KjqP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mmIADEXJTltQDDQpldbR+8pzObTKQfOgdqZSgjkgNbnK385acoNyz3mIn/iz8xOMS1JzbxbBW8maTw/nSBiwV9arWDXdPeksqmCc0cRLIR0Cf/A5CGhhgJAdTd3S2Mmi0VG4TH1zG/4RiBHFbg5r8g4WwTYR+9pu6e56+TWqtPRVE3tjpcgpCvjE9r7MxKeUhU4RVTgRrcnfpkkMF2vIi+PCr+npCP3Z24JoQrX8DZtHpYbPlX9qVoQx72Ju1FRDBUwhwrkcJc9J3w859/hG4DiSFbIsvvb0//wsajGuJAQfpf8vyZ1KajKUtrCPqJ+1OXb6jlc5OuDcL14wVvRj0g==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6848.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55bff56-4a5f-4bef-094a-08deaf78f805
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 16:18:42.4846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Z40L4x5p2DE0SMqSWDX1kuDR1zQzkSOJYykBGxCEDXvgVZ4lhrFNqxOQunnyao4slWjh2S9PTtreE55EsELkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9880
X-Outbound-Client-TLS: ANONYMOUS;rcdn-opgw-2.cisco.com [72.163.7.163];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: alln-l-core-02.cisco.com

> > On 5/11/26 10:49 PM, Cristian Morales Vega (cmorve) wrote:=0A=
> > I am trying to use=A0BPF_SK_SKB_STREAM_VERDICT in an old kernel (I don'=
t have control over the version), so I need to also use BPF_SK_SKB_STREAM_P=
ARSER. I though to just do "return skb->len;" in it, as a no-op, since I do=
n't really have an use for the parser.=0A=
> =0A=
> Since v5.18 BPF_SK_SKB_STREAM_VERDICT=A0can be used without=0A=
> BPF_SK_SKB_STREAM_PARSER.=0A=
> =0A=
> Which kernel version you use now?=0A=
=0A=
I think it's since 5.10? But I have to make it run on a big range of kernel=
 versions, right now I'm looking at a 5.4.213 system.=0A=
=0A=
=0A=
> >=0A=
> > So far so good. But I can see that, from time to time, __strp_recv() re=
ceives a non-zero orig_offset as "first skb" (i.e. strp->skb_head is null).=
 In such a case, I should not be returning skb->len but "skb->len - orig_of=
fset" (i.e. orig_len), right? Otherwise I would enter=0A=
> >=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 extra =3D (ssize_t)(stm->a=
ccum_len + cand_len) -=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st=
m->strp.full_len;=0A=
> >=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (extra < 0) {=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=
 Message not complete yet. */=0A=
> >=0A=
> > But AFAICT BPF_SK_SKB_STREAM_PARSER doesn't have access to that offset.=
 It seems it had it until e0dc3b93bd7bcff8c3813d1df43e0908499c7cf0 (which w=
as backported), but not any more?=0A=
> >=0A=
> Is my understanding correct? If not, what am I missing? And, if yes, ther=
e is any solution?=0A=
> =0A=
> =0A=
> If you just return skb->len=A0only in your parser , the 'issue' should no=
t=0A=
> happen.=0A=
=0A=
But if the parser returns skb->len, even in a modern system (in theory, I'm=
 struggling to reproduce getting orig_offset !=3D 0 in any system I can pro=
perly debug). Let's say orig_skb->len is 1500, orig_offset 1000 and orig_le=
n 500.=0A=
- cand_len will be set to 500 here ->https://github.com/torvalds/linux/blob=
/master/net/strparser/strparser.c#L186=0A=
- len will be set to 1500 here -> https://github.com/torvalds/linux/blob/ma=
ster/net/strparser/strparser.c#L221=0A=
- stm->strp.full_len will be set to 1500 here -> https://github.com/torvald=
s/linux/blob/master/net/strparser/strparser.c#L258=0A=
- extra will be set to 0 + 500 - 1500 =3D -1000 here -> https://github.com/=
torvalds/linux/blob/master/net/strparser/strparser.c#L261=0A=
=0A=
So it will enter "/* Message not complete yet. */" inside "if (extra < 0)",=
 no?=0A=
