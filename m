Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E741280327;
	Thu, 29 Jan 2026 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769673751; cv=fail; b=CKHw1tWTdpqSydZheAsYT1PC+WSmeogj4GiIkZiFGOKUJLomGxkJXYkXmI88v3+V0vGllx0B9YUpLV8EZ5aSfJ+sE5OfE9O9MxEH/4hxWil17WJp9VYNc7Lc9rgCwReF8duenZ7MQniRmRWuRpkaOjmg2Jv0Tda4SBLFvqzNikw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769673751; c=relaxed/simple;
	bh=mwfNfa9x11oKeg2D+LbLubSakY/gQHANLkBgIeP9/4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n1XS+SngqNaatGKpeg0bZ2ZrFEH4gLE9Xv6+Gg8MnbB1kzMv/DrzPjaXaBrUIXj9SgliSPiFCOII0dlclgC76MaMjX2HqAlgOCIRBslhH0GNtZVINPX5m6fsprdJQ42i/4/ejrt/swioWFJGxuQJS1g5kKcPpAMYeXQ8oMIY0xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W4QysOv9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d/E3U8lY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W4QysOv9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d/E3U8lY"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T6nimc1054988;
	Thu, 29 Jan 2026 08:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8hEBAHr2aLNsYIkEDk
	DmlLGQh71a6seBEyP1K5EtNGA=; b=W4QysOv939XjTP67wzrEuciQf0J8dPGTAQ
	1/y2KYnxO1Y6boWPC59BSTc0VO3I+h/GC3rshBOXvZiR8nD3Q7FgYpP6Zg63FyOf
	0Rl2qqw5UrheGM+USoYW+LJwdX2uVnqwdCESM6wQskaPTqE1IgVnUa/a5a+MwlrO
	S2gfHY3bdniIjXZ2SRqMxpZDRN8A0Nd9wyIJQ51F8K0/cI9bZQCVIDgGC9dx5yz1
	VYPpdrqjgcx3RddBGkjd8Uu3cuSLQN8z5kKh/S6i5sSim5xiPiWDszXGUSX9Q75K
	rxZht3dUI+h38rCDYmXeToAW4Mnb9SC8y+tSxvIEj2QqwCq2tJWQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5b6aguv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 08:01:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60T5vtKV019835;
	Thu, 29 Jan 2026 08:01:33 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhhax47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 08:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwrR5HIBzmFoxfCRGJBP3M07zxB3S5RfTpMcBzLw2FjI6m2vSUY/aRMpTxDZ8ninT/Ia0r2XbtjGLhzDFI5h/52GLbiUE95OuIqouF8qfGy/k7I4cBcWHAv4xkpb79UcR9tEd1XZKKoMmaOB7ytUYDwYkS88x2Re5DFvfF4/VRPOsaqSmmxbkcASeMqJ9zq+KZM4xbu1yFSqFhxBbKvpZnK2kHkpIPwcM7FDVVTFrFjSV4MiccBjHJXP9GnEawp2ySNJwOh4uDquDjOrraikqm4e1jOgYc7EsljkpAzWl3mu8WfBsSxc8kJiekAJYS7g4CC6TD70L5sLqCvuI42auQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hEBAHr2aLNsYIkEDkDmlLGQh71a6seBEyP1K5EtNGA=;
 b=elP4qZmhwgwh86Kw/F0bTIoOLKZ75P+m9RGPfPo6NA2Cgn1pIVRhCmZhBQ1PrK72xun+BJDfj16fkS4wJEKpWKp1Z87jqHX00brokbX23ZNI9PPU4rt7St3+r2+dRPVui/bN53zpKkqnKoTuSg2heaDfstmrLBVqqudO9LdM+BAEkAM+ek/g8H269MIyIi/SnWt1s9TImTDb9dR/LcGScJupJNvPA1MS3SKKVkFSbDEWO2lrOI5mw9TPDrANBBZDgjG28VYK2IsAQjL046ipK/vpYnUCMubiiiBqIHZ3r6J61yy4Dv0OK7uvbIIjLO2jd2RJqaWYwf3ifHhSLSWkxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hEBAHr2aLNsYIkEDkDmlLGQh71a6seBEyP1K5EtNGA=;
 b=d/E3U8lYfojLGEHmUOJxCWQw4fZ/Ca1ve+FgUSXGYOYrEJcm5JpUcxjjJ6yDSOrtm+bMLYAqoGMBBHoLa5sguVSKstMc4fSMjFRyi7MYqXqA+gv8G4nlpny9gZQ5k0NShqLWsTZRRFBW5PVFzj0/RTHp692PDVRQyuuRKxpRqD0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH3PPFFC83155F5.namprd10.prod.outlook.com (2603:10b6:518:1::7db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:01:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 08:01:29 +0000
Date: Thu, 29 Jan 2026 17:01:20 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 10/22] slab: add optimized sheaf refill from partial
 list
Message-ID: <aXsT0FSP5IGCXxOt@hyeyoo>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-10-041323d506f7@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-sheaves-for-all-v4-10-041323d506f7@suse.cz>
X-ClientProxiedBy: SE2P216CA0025.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH3PPFFC83155F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 639274e0-de04-4064-5728-08de5f0c9bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9rLWY7AHMkGfspDIC8aivEQknDmwqiJXpT2IznT+9U1QzXZpG3WtzVml6JV6?=
 =?us-ascii?Q?v3yz8vuz773OLit9wytBE8nLxGR7V8z51tkri5wXkS6ukTnXcs6Nq/9FEks4?=
 =?us-ascii?Q?caTmFYr7Wd3qLHC9SB7H3GByzUsK/7/CG8u/8OVf0PWIHMQShF8vuo0IeQDO?=
 =?us-ascii?Q?5sBJdrS5u7XylrTgREQQOnsc/K6sRHVjCapvVRQo1OFZGeQFX0YXL8e579dE?=
 =?us-ascii?Q?ouz6Z88z+QI9PEcz3BdcFelyIBrmIRXblEFCQb7XUa82WLr4RA4S10beHAWt?=
 =?us-ascii?Q?X4lpYNc0NGtSch4gfy1/7FKFSq5IBLzVpIzgyYLh3Jq+lLefNfT0lfU/W4Q1?=
 =?us-ascii?Q?+0WUbxn1mZ+sgU4stkc0FUjwx/qWK27NxYamh37rh+1ddDmJXAGJfEFWiNQ9?=
 =?us-ascii?Q?fiaVnM4dvpxr9aLePffnyRJpCvWkfVughxGvaVqsld/gmsndrhdEhcF+EIMz?=
 =?us-ascii?Q?AOLieXeh9KG6bI2d/VIX5XkHhgDonIEnMcNjpycqPtrQLKDSu1gFY6v3E/EA?=
 =?us-ascii?Q?6LwrL3Y+0iQQ8brrwTjn1R0xopYvetO5pFTf/VUo+CPlDfPTDbLeXX7908Q9?=
 =?us-ascii?Q?fGUXkeeHn8EJfAH/RjKnBeRn3LzkB1dnYCeSov8/33HYy17/XYXb318S2Zk9?=
 =?us-ascii?Q?z/Wc3QxAyIiG8lzdKJ9uFSl8CxxG7Ihk3PzK4kaLXpKldJBjDfjkgG0VsWMe?=
 =?us-ascii?Q?TDFvV0RpRIwl23oBQfo9nHx2V1cwn8jXbBmhxe0/7bdcKB1aw9L5phOxnM2X?=
 =?us-ascii?Q?gFzt2/PPojOYARtvVVmehq/ufSkjNwkBaA/fB+3WS5zT7eAr//Z6gkK/gvh/?=
 =?us-ascii?Q?Nu0i6hVTQ+DFrIHDh3esOig4WUAk2pCR2tCV+ajogCivHu+KtEf69exOmK7s?=
 =?us-ascii?Q?i73i89akLbM50PeuhaUne7y1NPWlfs3tk1/i8v8lDWw6aoLuGKt8k7+5jT+o?=
 =?us-ascii?Q?8DnF+rqcx4hdrb4qn/by9JbI2pYKOg9z0dT0yAFffdCbcTR2VAk720kEIsTX?=
 =?us-ascii?Q?7WCF8DUfnS/gz7foikBTz/R4L541DsI8n2NvJSw9vzHsMGp3u+o1knJq3z/r?=
 =?us-ascii?Q?7A+fYp4YqiQeXPrpYZmT6ock+nKfLpbJAJxgl6MS8Ywc1G0VF+ZvSoXxqtv4?=
 =?us-ascii?Q?P3xWJ/DXvMjBa4PSiI1XAYvQR4sJebpvWadCisO4sovwoCXtSBBGsXWEmVgQ?=
 =?us-ascii?Q?ZVwzweTi6w9n5NaK7MEfTmOiH9jN5xb0tDcu0xYr7QvORW+cbkVyy4ohMewk?=
 =?us-ascii?Q?SiNZ+u6xk89isej1qswzbwo/vSsfuS2Vr59AmCWpLxlYTaHK3OUcQowinKeL?=
 =?us-ascii?Q?wgImXT80ACTt0SnjUnZ6oJW9FEbzn5KQ7XQbSCZXWVlu6+MXGIMEdNMK1+A/?=
 =?us-ascii?Q?D7iHKxtUQddrp5k98K/HgCoZr/fdd88I8zLapsSBoOI10eCXUIThivmfnDx1?=
 =?us-ascii?Q?U45EgLnW4RGVVTEpv7WHLZylqPv/WV8+83pnooDULFik5Z301BFvsunAYr3b?=
 =?us-ascii?Q?EW0iSMEDzxqWfNGIgOM2//ohkujm3BPV6QH3o3L+0SksNEgAzSiBtDi6ipSr?=
 =?us-ascii?Q?kAZKhaX75mQ4IWqwiVU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vLw4ZdPbjyYUkrniaDs5V8BhJ8ypiqXNsmNK+cTcfCC4+MhUziqDaQ1aSCep?=
 =?us-ascii?Q?r3+mIBYLnBtvZrKWhGl+LxBH/INCBuqSyXPK0dqB/d6haFZOZSkkHI1YnHoX?=
 =?us-ascii?Q?snBVCw+38InNObyATAiM61gqkR+Nv9w4Tw2/tJZjRpqptAIw4HSMKkPKvtww?=
 =?us-ascii?Q?7RC5jsgv1tOY5VRPgzNje6epuNc7/fpM+u/4Dff07hvhnPEPLzdEUg6EOmU4?=
 =?us-ascii?Q?SY/o7q8NnaVDsGwzj+AuhoSkFSXLzJAgAhgiQny1nAZ8Z5tSblxYL4grrCgn?=
 =?us-ascii?Q?v6v5DxAktQFegk7cMAPhR0ruVmhIs9tdWZihPS9rwIIH+82LzdfPLWpLo45H?=
 =?us-ascii?Q?2uzAxwh7wBHnISVoSfWIMOEGCGqAthpmEjvC/HCdNhbdrBFiqH6ODe9s7o2y?=
 =?us-ascii?Q?pxp5oH+e1ZszDd2z5eoyH1dfxbPyTAWS2G92iWk7x1EGLwPs2soGkPD6idPo?=
 =?us-ascii?Q?0BwOUfIAc/4RGTYDuu8/lXUbJ0qMabsRzpJj7IJb1Ss7ZiUVBoM1wwNqLj+a?=
 =?us-ascii?Q?4rbQZ8y/J35jxkRYqVNdfA60HaX/7r/tzqM8iHgKG2jRXE81aKVi4z3qEDer?=
 =?us-ascii?Q?CF7RZT5q+LavhJHUQC1pu3/fqRhKXk5UT/f3YpZgGg+hpSZhd79ObDA/scSR?=
 =?us-ascii?Q?4+mhn5FuPYWSkdLpa944VmaZoSNfQ9rpeWC/X8+ZB0vNzVhOEVuRSdu59nFf?=
 =?us-ascii?Q?nz1k1NZrOJM4rrgofv4gcw70D0mohHxDnKC/8Wwdlwed3WatifD0rzhOJYOw?=
 =?us-ascii?Q?V6SK8kmvH5giwODyACYjiguLAlfLD0tAi7N0Zu67KeVLWan4+iMFTa0Ec48F?=
 =?us-ascii?Q?Z2nQpr9kMSmT6AIDjMUd5qxxZLQI0pIlIkpewMx6JG9riqlywlIcdMrjTTFx?=
 =?us-ascii?Q?v6lU7t3WK97ptbnCt2aMGvKfWi2A6DoemBQufVHmtLZ/Y5AjH/bgL7swyvIU?=
 =?us-ascii?Q?ct8UT0RebXtfLTDKryq9jIDB89xEMwsXgihnAqY1RjHm04oGzstCCrA3CY12?=
 =?us-ascii?Q?Dwayi0ECFQS3GK5nCxLxJD7iqaa/7YR+f/7LOgpLdLkHXz4vooa71hYGoeae?=
 =?us-ascii?Q?AWXMG+n10fITOn3tlvneAr6hfcHCYnBcQLcGtBqUP8okk8eppokN0SR0PVpm?=
 =?us-ascii?Q?zEK93oidRw/G+NXcwWxrq0lTxw3pMRkx0paW1OUfzx5xxBpV689zl3uVEOx/?=
 =?us-ascii?Q?fKRPaW55fhm9sqWDShY60DGSmPohra4oIisPeAgcf5PYrfV9F2I0IduxXe/y?=
 =?us-ascii?Q?hiFPiy1o8HFQhkZKbHLu8lvORc5aBjbpsphZpGPWOWPSkW/+YxSIvBwy+QEm?=
 =?us-ascii?Q?scxyv3a2TZYqhedMEBjvYxiWuCKlPxQJhjO8LDsRcjizXr85fnxDo3mpK2tX?=
 =?us-ascii?Q?Mi95kdMxSGFei8oUXC8qhSBiIINSz39kLof0RRbgBdK0pXLLyj8a0wCoDCAe?=
 =?us-ascii?Q?Yo8YpvrjL7wQMu+V8Urm/v4h3MpgepW+WUrReL1PlWhO/tE4VWNK98sFqBk9?=
 =?us-ascii?Q?p8L78RXITlBSb6WnlzOp/isoPNR+cjeLmjr1dPcjd+1OQUn4T1evp2m9gSTc?=
 =?us-ascii?Q?dtW+IzNbPQv9yaGaQUiG/YLzkVf+JBTt6v9G20Cyt7rhMHLrNdPoINOuBoi8?=
 =?us-ascii?Q?SmJD438aS8wfD1+3MibxlBKRZdrPDnjqeLAcRvhU5kPdF5JvwsYvUAfslC7F?=
 =?us-ascii?Q?pZINUvPP0Gos0sRaIuAVO50vrvZH15AKpTu16C78mcHRJ6wK6wZlFkDezzOY?=
 =?us-ascii?Q?BxGg0YJjig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3kMl8vO1p+OkCMwYUWJ3hIp2X/Lz055LcdRYWcMZn3GeyjDFzdJxzH+POkUr3ribOYuymg2Qi7hdmPujMSQHY59mI7Rek8UFzBq2Smvvkw6LyxHC4BwMpoFGBsdZ7Rl2F4dvAuXjRwl6UW32UA78wKEJs3aIE2312NB26icXoFeE3S7PFebXC+bsdVYVhgYqeqmURTz7dGKvhHXh7FMtU7J94+RxBIQ/wNyK+4dpUHqsQjcrZtpcDwknIjq/PqZJnIpnYMcgfNCWy2KNIZsZp9fyH/J3D3VWhrSla6sM8oFVb9cAE4wEYXmJLDa3F3ubWB1TN79EsRctdUkQpRNKbGwXkJoXaQJvOBhUximfAhy8IY0GEAcoTj2LRS394j62tJlMJmg1hsAGKzsVo4OWgPdFE/pUicSHTOB9D2gKBGuOEhmuSbdbItRplPIsQZDTOIcT3L23u3/eKtNHIRIjRSsqNdiCTe3n1gfD2WBI/6zaQIcRiRZUf5X6YjhHd7atr1Akk//fiBm3m2YTsOx4s8pgBUPLJ8cNSIQOV/bHyiqO/PdmdkvafWpuPSr8saS6XeiYfScHD+DQs71g5BHMz9P0eDT0+2UpFEJqlYiGLoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639274e0-de04-4064-5728-08de5f0c9bcf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 08:01:29.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKwoENHYhUoLKM2gk/HAIR22ZyHkBbZatx0z7RFTH2Vt9FUWTC0Yt3BjRYjpN3YbgAS9ySPrVX7J0s3iN2P1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFFC83155F5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_01,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601290047
X-Proofpoint-GUID: KK2DieHiqsguCy25DD_QWaAXuCqOb9gl
X-Authority-Analysis: v=2.4 cv=OLQqHCaB c=1 sm=1 tr=0 ts=697b13de b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=u1qovP0KQFmDFdSvR1oA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12103
X-Proofpoint-ORIG-GUID: KK2DieHiqsguCy25DD_QWaAXuCqOb9gl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA0NyBTYWx0ZWRfXzrasCwSNH7kp
 ftUwSsIKZQfNsXUfuhioyZN/km2afZayJwWecq89ZaLDoYKdtfAhv70IwNy5JV0D3uWtPtdPVME
 gmApqLERrP7gIjQ5+ln8DUaqfEgAIJLqPnlOXdspZfG+nEUPrQzE1CvgxQW/cO9zynFnh22EEdk
 NUnOF6X2ARVqJl0jPZpSUJl7lO08Tvh+R4c68Q6/tHudlVuKtokRWePalAmroULie2ZatDm5XXI
 Li1PB3D+Vc146uNm8kf1Gvhw2bu0EKE2doEubz9tdxGM72akokq997xX4da7jzE0o+uTgHFQlWD
 aPLDndcV6/LrWKI1S1ML5i1/svAP8cOkqsm/RkPKxA05Yi2kaJREOVZWvx6+mti6kMf7jIV2HIM
 VDp/fklJ6NwIUpCPftfTX/rCuYhpatkdQmOwmDAEwK8Besa6/M1ZoNvLG3mFT0dl6At8zr0dvrm
 8eivGbKEInlVZ/TUQJpyHhDrZj2KSpk/WPnS2RMQ=

On Fri, Jan 23, 2026 at 07:52:48AM +0100, Vlastimil Babka wrote:
> At this point we have sheaves enabled for all caches, but their refill
> is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
> slabs - now a redundant caching layer that we are about to remove.
> 
> The refill will thus be done from slabs on the node partial list.
> Introduce new functions that can do that in an optimized way as it's
> easier than modifying the __kmem_cache_alloc_bulk() call chain.
> 
> Introduce struct partial_bulk_context, a variant of struct
> partial_context that can return a list of slabs from the partial list
> with the sum of free objects in them within the requested min and max.
> 
> Introduce get_partial_node_bulk() that removes the slabs from freelist
> and returns them in the list. There is a racy read of slab->counters
> so make sure the non-atomic write in __update_freelist_slow() is not
> tearing.
> 
> Introduce get_freelist_nofreeze() which grabs the freelist without
> freezing the slab.
> 
> Introduce alloc_from_new_slab() which can allocate multiple objects from
> a newly allocated slab where we don't need to synchronize with freeing.
> In some aspects it's similar to alloc_single_from_new_slab() but assumes
> the cache is a non-debug one so it can avoid some actions. It supports
> the allow_spin parameter, which we always set true here, but the
> followup change will reuse the function in a context where it may be
> false.
> 
> Introduce __refill_objects() that uses the functions above to fill an
> array of objects. It has to handle the possibility that the slabs will
> contain more objects that were requested, due to concurrent freeing of
> objects to those slabs. When no more slabs on partial lists are
> available, it will allocate new slabs. It is intended to be only used
> in context where spinning is allowed, so add a WARN_ON_ONCE check there.
> 
> Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
> only refilled from contexts that allow spinning, or even blocking.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 293 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 272 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 22acc249f9c0..142a1099bbc1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -778,7 +786,8 @@ __update_freelist_slow(struct slab *slab, struct freelist_counters *old,
>  	slab_lock(slab);
>  	if (slab->freelist == old->freelist &&
>  	    slab->counters == old->counters) {
> -		slab->freelist = new->freelist;
> +		/* prevent tearing for the read in get_partial_node_bulk() */
> +		WRITE_ONCE(slab->freelist, new->freelist);
>  		slab->counters = new->counters;
>  		ret = true;
>  	}

Other than the above being WRITE_ONCE(slab->counters, new->counters),
Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon
