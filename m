Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20855366DB5
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511037; cv=fail; b=Jqr8p6/cINvXmOxDVRHCALUeI2TxvEsmFwA1Pwtu0MbkPuMGDC0ZRPO2iCHgHnMMH1K8qQsiMe7kvmtjOXjuPzZaeKKa1v4k1BHqfXPbo0+z1V7N1AFq3MCR7D3t0FFwXkV4aOK6PrMlhQly7JmgU3ZQXnHY6LQTIGJJiTddGKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511037; c=relaxed/simple;
	bh=Lu74lX5SFPe3xJpZMGhkeHpF+YifexiQylHFuFUt3uA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W5YiTfBHAry6auG10LEh1b3ZN3dNcZO12U7zzvQWkIHv0Ot9rWlPyjOJKGOjpqCOJ8mMR+rWbZ02bHiWQPyNrJUibGcHl8v+86skStJfLcDdp1+kQBPIXUEOpMg1RcDcj7Zk/77ANmf3kvVp01BXXOS1fW3CRxdwMh3lQcxMIWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=fVtVwu0M; arc=fail smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="fVtVwu0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1026; q=dns/txt;
  s=iport01; t=1778511036; x=1779720636;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ke42QRvrReYdFQbG22e6NlgIUTBR8JnwxDWQt4ZcGcM=;
  b=fVtVwu0Mlu+PW+DpoQeHQkFZ+m93ITFcL7Hbdrwk63GCHLnJI/4xIeBm
   Cs5rlvQ4Rlhifz53W5GjNKRJ+Lal16HzxmAkRywo7tQ2S54Er5zB0WiJu
   jRTGasFuz2HK5GfzqFq5A89o5+p5kFiWVIkIhoW/wiKMUpQekcO4NZDdB
   u7bGh2WjAUudnlBhQJFdCHn866Sy/WBZA7TCBpsY3GWrcikncnhatJIoi
   zJDGuYt5hwbRnDAz/B2fp0QTiuxjI/4escx52MvBNU9VxfRuQX8NblLO+
   fEubdE1HecEmX5WM8HpSlUIP7S3UbxhJpylwwyQA3c/ExYrqwIl618f9S
   g==;
X-CSE-ConnectionGUID: a4PZGHx3Tv267MKlMHZ5AQ==
X-CSE-MsgGUID: E+YnrYFrSdKAZ0gNB44dIA==
X-IPAS-Result: =?us-ascii?q?A0CDAwAX7AFq/4wQJK1agS6BK4FuU4EGgRESiGwDhSyGW?=
 =?us-ascii?q?JpghV6Bfw8BAQENAlEEAQGFBgKNMgImNAkOAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZQDIZzFWQBfycEGxMHhVQDAQKpDwGBPQKKKniBATOBA?=
 =?us-ascii?q?eAxgU2IWQGGLoRDJxuCDYFXh2uEE4IvBIMwjmmBShwDWSwBVRMXCwcFgWYDK?=
 =?us-ascii?q?i8tMjwyHYEjPhczWBsHBYFLgg5yaoEEhF94Iy8DToEFAwttPTcUGwMEgTUFj?=
 =?us-ascii?q?HgdXzWBbqVWoXoKhByiDheqagEuh2WQcyKjGz+FGgIEAgQFAhABAQaBaDyBW?=
 =?us-ascii?q?XAVgyNSGQ/XQIE2AgcCBw0DC5NlAQE?=
IronPort-PHdr: A9a23:LDx3OBPeMKhzdr27/eQl6nc2WUAX0o4cdiYP4ZYhzrVWfbvmo9LpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgl0w=
IronPort-Data: A9a23:thiGAK+LuglSoZPoV7gIDrUDw3+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 mYXCzyHOvmCYWX0etgnYIu0pxxUu8SEztFlTVZo/HtEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4EzrauS9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mpyyHjEAX9gWAsbztNs/vrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2k/YbUq1cZnWl1Qr
 6JHDRMJSzCx2suPlefTpulE3qzPLeHiOIcZ/3UlxjbDALN+GtbIQr7B4plT2zJYasJmRKmFI
 ZFHL2MxKk2cO3WjOX9PYH46tOytgWPhfhVTqUmeouw85G27IAlZjOi1YICOJoTXLSlTtmvbl
 2TczkrjOR05He7Hxhyvri6gp8aayEsXX6pXTtVU7MVCikWd7nIcBQdQVlahp/S9zEmkVLpix
 1c88y4qq+02sUesVNS4B0b+q3+ftRlaUN1VewEn1DywJmPvy1/xLkAPTyVKb5ots8peeNDg/
 gThcw/BbdC3jICodA==
IronPort-HdrOrdr: A9a23:tZHjYKCKJha+2XnlHei/sseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskdtZJhBo7y90dq7MA/hHPlOkMQs1NaZLUPbUQSTXfpfBOfZslnd8k7Fh6JgPM
 VbAtJD4bTLZDAQ47eZkWyF+r0bsb+6GdWT9J/jJgBWPHhXgs9bnmBEIzfeOHdbACNBAp00Ho
 ed4M1omxqMEE58Uu2LQlM+c6zmvdPkqLLKCCRqOzcXrCWehzKh77D3VyOfwgofVD13x7Ij+3
 jukgDy5Kmv2svLhSM00VW9071m3P/ajvdTDs2FjcYYbh/2jByzWYhnU7qe+BgoveCG8j8R4Z
 jxiiZlG/42x2Laf2mzrxeo8RLnyiwS53jrzkLdqWf/oPb+WCkxB6N69MJkm1rimgkdVeNHoe
 d2NlGixt5q5NT77WPADu3zJlNXf4yP0DwfeKAo/iViuMAlGcBsRMQkjT1o+dE7bWzHwbFiNv
 VyB8fB4/sTW1abY3fF+lRL+rWXLywO9tPseDlZhiRTuAImx0yQwyYjtb0it2ZF+5QnR5Ze4e
 PYdqxuibFVV8cTKblwHeEbXKKMeyXwqD/3QRWvyG7cZdc6EmOIr4Sy7KQ+5emsdpBNxJwumI
 7ZWFcdsWIpYUrhBcCHwZUOq3n2MS6AdCWoztsb64lyu7X6SrauOSqfSEo2m8/lp/kEGMXUV/
 u6JZoTCf7+KmnlH5pPwmTFKtFvAGhbVNdQtscwWlqIrM6OIor2tvbDePKWP7bpGSZMYBKKPp
 LCZkmHGCxt1DHYZpajummgZ5rEQD2Nwa5N
X-Talos-CUID: =?us-ascii?q?9a23=3A5pPS1GhJdZNdPh3tOhMdmsFsbTJueyHl/ljwMxS?=
 =?us-ascii?q?EFzw3F5i2TXqwyv5Nqp87?=
X-Talos-MUID: 9a23:wbfDJgY50cCjW+BTmnzdgitTGt1T74eHOhgCt79a58WlHHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-03.cisco.com ([173.36.16.140])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 May 2026 14:49:28 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-03.cisco.com (Postfix) with ESMTPS id 03B5518000438
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 14:49:28 +0000 (GMT)
X-CSE-ConnectionGUID: CfnkGnBUSMGYY4kJqLi9HQ==
X-CSE-MsgGUID: sBqB0fSET/uggorpkJixqw==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.23,229,1770595200"; 
   d="scan'208";a="80834992"
Received: from mail-cy3pr08cu00100.outbound.protection.outlook.com (HELO CY3PR08CU001.outbound.protection.outlook.com) ([40.93.6.104])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 May 2026 14:49:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHA5APPTYGmKSE0/PwEAE+nk3loskAPoxZIH+meiPRNx9kIeKo5hWgq0grNdVr2+F58bIZ25TXzjzH/UC2cmMzbkaMs+4W2RZJmkE+h6cv4PWetxS2I22CFWl6ZbEOMDXxTKO1X1x5LfQQ4cxtYOpX6pVkS/J9GoYvG2Ud7Z0mDKXK87lO5IdUbaBjH3kfRsoviq7ck/2PkfyIf3lnQog8tOpGNKjq8/VVZZOp4MldcGqnp7uQ2Tc+nFPbP1GLe6BbL6fy5QkTZgyrxmLB9KFKIdAOQbd6Wi+O4Eslq6Mbh034gwaLRUCyJ+C+dI5PODT2Jraze/JoF/5jD4ZNCcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke42QRvrReYdFQbG22e6NlgIUTBR8JnwxDWQt4ZcGcM=;
 b=G7JPSVqpKh5smIRfHIsAkAVYDzbiMCx97938fJCSQ1PUkC3BV4CKvDVxWep+amXCeWUc/j/OG8FG9hzmclYN/oWTc89LgfqCkvcppb/AvJ5PnUuTR+tu4Wu/UvyvdL7q+qg/3Ka2TYc0d9sqGIBCgtno8OSBC6ZqaEsOSWdVIex0GAMSRF/dZgP8nibaJ3wv5GrJ8O8owdaNyV7xGrElTRrWsA5a9jqlsV5oaHZRI3yP3XC1jtk80eLsFigUK5OSvr6qPLmTgI3zdf9DchCzqocBfap2zuGCx+tsqwXwq1IrN081598a6FKfqrBeCJeECQli3bqrEifY8HG1ewFnnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14)
 by IA0PR11MB7912.namprd11.prod.outlook.com (2603:10b6:208:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 14:49:25 +0000
Received: from SA1PR11MB6848.namprd11.prod.outlook.com
 ([fe80::1e26:8f73:29d4:cf05]) by SA1PR11MB6848.namprd11.prod.outlook.com
 ([fe80::1e26:8f73:29d4:cf05%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 14:49:25 +0000
From: "Cristian Morales Vega (cmorve)" <cmorve@cisco.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [QUESTION] BPF_SK_SKB_STREAM_PARSER cannot observe strparser
 orig_offset?
Thread-Topic: [QUESTION] BPF_SK_SKB_STREAM_PARSER cannot observe strparser
 orig_offset?
Thread-Index: AQHc4UzcdZrP+t27EUuP1HlEy6a7Nw==
Date: Mon, 11 May 2026 14:49:25 +0000
Message-ID:
 <SA1PR11MB68483E0B4C78DA91FF8DCE7AC0382@SA1PR11MB6848.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6848:EE_|IA0PR11MB7912:EE_
x-ms-office365-filtering-correlation-id: 54458214-0853-480a-40d5-08deaf6c7ebb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|11063799003|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 AqqqPx1c/AM4emrBcDhwe6v8s88H1qPepRo1sGaM5rDKZ8TgleF728+xbIvX3/NabV4UcIit5dIw47//JcsZwvdTN8JB3+OAUjY2jeknIq3uJ7w/yL0cvbmUxEgZ2R9wozsLAjD5VcyaUru1g60EAIt1iBBdrHOl66TaYrrOWlIVHi0l/chXwJ7oZKzaRnLNT7r654WWs/Nt0oAGeszGsqzbG0mjPIfEpKl/2vvZIfHilY5KCZE6+MSE6WOYPrAg499JCVWEY+01c+KhIbkMLD1AA4qTLJi+GQ7CHC4s0HlbXssYXsxTtgnVlqTeOxp5TJHdOMzWlGgmiLwD8YHaTJaJRMOWUPY/cRFQrN3AGsjsW/fI3gaq9YO9KuTbJv4i/P+tY7nZ3SrE0X2qpQgvGyMro6GrMZyp4NKstzXVVZ098mu9xB/gf0fAlqlIlnE+kxM7PW6ONol3bfayM2dGGHIE8wEWLFBXIATMCwT1JzLrYMjlRsaciZUFGO7pxF/ZIyWx33iuFmc2MQvoxmd7auqfSYQGguFthMAYNGWxuLfakuhT4MX92BBKfqLyWkf3abwuNRZ7r+RQww7M4l0BBwR/Ou5VTE0+9k9VcuASdqJM5iVdcAJpSpssBDWUalYdoHELyO5ghdiJFdJUcw6N2jJofsmO7u4Na5SdM+XpmJOsUY0gfFbgcQDP6ryBL+mc3t72eDRVFqUAmcO2KrkT0cr5dO8w9ULzmxpG/TVEK80mEbza2crxO1kFOBnaZmdH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6848.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+6lYShsQcsxdiCNRTX/VppQpiQx/3OY6EUIVjDf4HZuZl7IrswHTblLHnT?=
 =?iso-8859-1?Q?UDrCbObAjHBH7sjYI2zSu0yNt3r9E/LZ+T1PvSXBjhXC8vj970+jBTnElo?=
 =?iso-8859-1?Q?YZpEeMEaQ1RKm6Wz7RFdz9YkPXHQPCAhxQUw+JMt1QK889tXXbkOkgm99C?=
 =?iso-8859-1?Q?k5BFVxzMAh0st/q1ytqAfP/9YwkiVIi7kw1KSvPoYceQkDfauLkvppcfYm?=
 =?iso-8859-1?Q?ojhDyzls54rNaBMhI/3rKmTLrbeKCx0QYbHOPPlPburTvbHZ7VMExidhqk?=
 =?iso-8859-1?Q?hhvJeV+QH025wJefD7h1gYSOnzQSvbGxssU97yydaMJYtv9bC9Z8QaXMqk?=
 =?iso-8859-1?Q?AMNNAtJGitMhGCoHfYDEp4gKKMOixmRMTEcU/nODDGtgeHdqKqV/mBjdhZ?=
 =?iso-8859-1?Q?uXAQ5rpnQcm/X0+NJ5UKbKyctAPqUBKBnjXRQ5L30nGWE/r899nyDOPHZT?=
 =?iso-8859-1?Q?LFJE2YjMRvgXz+cCvjzYE+cvDE2LZUbIoq7wTP3/d9APtJlYu+992JFe/q?=
 =?iso-8859-1?Q?GjZ4ppfSJZBRTo2fC0fgfdr2CHlTw/OLXMW9Z96E6XgceDAD/6NqJyiMP4?=
 =?iso-8859-1?Q?CNYjR8JuxOEaWAZ0bB3t27P97g7C8M2JZP7CcUTRCn2GOggdT1mav1B/Sn?=
 =?iso-8859-1?Q?DaamazXF9ZXF9QxKjyPuQlPpsi/pOwR8iGx1d3OzeTT8QYFubp5IWcjUBe?=
 =?iso-8859-1?Q?khqyMPm+cZV7fyhqhdeMW5aQTPb1NecDzYPrV6xLVlKMCLY0qE7wziCI0O?=
 =?iso-8859-1?Q?xD/DxNiyONXG2L0hdxqwbbYpqHsbkrpjv033bckKvTkxVQV16N2RGxeVPG?=
 =?iso-8859-1?Q?wTOeY7FVA7IefVH6WZ8/2hhvqb+LWHH7j35jhYOIFzOqihGsoeeq0sb8AB?=
 =?iso-8859-1?Q?/5y75tZwTCc0Q3a3DcLy2/gyWEH65SaKeO4yQwIUmEq6s4sppyRKCc0pjB?=
 =?iso-8859-1?Q?OELAzCS5yzdSQ+CBumEv8BqGT3Fze9ytu5JvwJ+b/vxjnIxr+lC0nOM3wr?=
 =?iso-8859-1?Q?5o03V+MSCyNLJCHrGamJ0olUA5ALueytz3mDWB/IpY7H8muoTQSsQSMAHh?=
 =?iso-8859-1?Q?uCHTx006Fv+uW/GA0Ca+DfSItXWfpffa0b+JIdwbM+S3vbcj8f4NsK4Hz+?=
 =?iso-8859-1?Q?PtnIqxP00UC6CuEPaAiqZ2g/dlYgr+t9qzvIKMEzdZPNvSItdizVlzuZR7?=
 =?iso-8859-1?Q?RfLFEWYDWrfSN7F3D6Dh9p8oWMvX5MHFHhoTibCmAu5R1YI7u5uE28jymw?=
 =?iso-8859-1?Q?FS6RIH6WYXRCxx4ijwzhT9MPR0L60kDZAZd3KeCVcyLcvO4tYw92iACLsx?=
 =?iso-8859-1?Q?hmS9+8qzIAaKZj/FlCXzXf2j7lQfNkTJFuS6DFhj6PKYTGdKXDBkscT+Xm?=
 =?iso-8859-1?Q?rBWo45k3knzxLphuXAAnCjU4crm+dAayS6Nj7MUryCyXrhVh/GiBSHdnQi?=
 =?iso-8859-1?Q?qkFjG8PIERBxe9CDqaXxrhJga6ZYm7k3ysS6h3T0WiS9ZxVA0YyN1T5m6A?=
 =?iso-8859-1?Q?WQWAdqvXo2Za4Sx9lshK85NKxtch43scJ7FbRcZ6X8azczz2hvChgUdfEU?=
 =?iso-8859-1?Q?MJHP8TUJkneXSte81HahLqT7E4ge6yGfwEi4zw10ebzZhAtandYbPvZsKv?=
 =?iso-8859-1?Q?lFxZaoTaGsnTOT7DuyQVQnwhj1ktG0u5sZ8WrR0TwW1Q49iH0+p+LXalxR?=
 =?iso-8859-1?Q?9WBxbbTMi0GFqfrtlg7Zsk4WEDsr928exStpVzT6P9knapuqlY+QbrtdVy?=
 =?iso-8859-1?Q?lzY3tA2ualJsDQOW4C0MVSytdgX9j44nPjS0+wlJ/0Vahi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	PPmnQoZ/awWnU3BzptbmsU95qQEhtECZNxI7Xx5INHqQQZhW7NlteWgOVQwOKhYHpj0mw+zEtjezO4rbDzbWhkgETQe5Iv4R95VgUWvSjVLO1WlBkqXKKO0jzZbQmtxpOpKJ7kaRvY+c2HZhQY3w1SPZgPQGbONaS8+q6wgvkG+p/HXXpMyiLnysA+Y3uen3mg4XTmFvnTo0nndUIMHoMHh/c8EHk0aBwsji2rwvDGVpwoBvwjmNAKl5+JuRT596q1zTGcHWYNEug1WD17s5IzwYUF4E31xJdvvrRoFe+GAzjLRDDLHjRJ2gmrhhlOxj0mBKbAJUI3q5JR7o05jC6A==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6848.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54458214-0853-480a-40d5-08deaf6c7ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 14:49:25.0353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4OGZC0Dn068RL3xyZj4NRWM1Qlq3w+QWsz94hUf3RtipHF1tqJVCl4vFCLbVjQZeeH2JFssYcD3aE73DOa2oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7912
X-Outbound-Client-TLS: ANONYMOUS;rcdn-opgw-4.cisco.com [72.163.7.165];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: alln-l-core-03.cisco.com

I am trying to use=A0BPF_SK_SKB_STREAM_VERDICT in an old kernel (I don't ha=
ve control over the version), so I need to also use BPF_SK_SKB_STREAM_PARSE=
R. I though to just do "return skb->len;" in it, as a no-op, since I don't =
really have an use for the parser.=0A=
=0A=
So far so good. But I can see that, from time to time, __strp_recv() receiv=
es a non-zero orig_offset as "first skb" (i.e. strp->skb_head is null). In =
such a case, I should not be returning skb->len but "skb->len - orig_offset=
" (i.e. orig_len), right? Otherwise I would enter=0A=
=0A=
		extra =3D (ssize_t)(stm->accum_len + cand_len) -=0A=
			stm->strp.full_len;=0A=
=0A=
		if (extra < 0) {=0A=
			/* Message not complete yet. */=0A=
=0A=
But AFAICT BPF_SK_SKB_STREAM_PARSER doesn't have access to that offset. It =
seems it had it until e0dc3b93bd7bcff8c3813d1df43e0908499c7cf0 (which was b=
ackported), but not any more?=0A=
=0A=
Is my understanding correct? If not, what am I missing? And, if yes, there =
is any solution?=0A=
