Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B123E8C48;
	Wed, 21 Jan 2026 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999898; cv=fail; b=VWtS7q7mQ2FmOaEMsqRuMAwKSzbU/BADWq+lxGP4Wse1Rtb+QOfK/w2SjXWZ1n/nAJUxnJV8JpKQXSoxXEsWRLdUmgONBdWrrtNv7bPAgK1AFY3Thh1ZWRnqQaMxLYxM5jCsYOl04gycE/FDxCrEHSpbkE2OUwbH5oX0rE+ViD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999898; c=relaxed/simple;
	bh=LnoJRcLH3CKdJP67ia4gPB31Z3BfCSFFbk2Z/6UG5nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D/8Eq7EQCptOHVAznQ8b0SHvj2hdvaeP9fVOGU4g/aYPfj6dp2dD/1btRwyYcnYB3iPzwu1WovAdcZ7y3ybRYmeQ69g4XKtsdn5racOJPXHfdBpRkUB3VArH2wV9OczJlDC2UP0lzTvfeCsvi8LagBB5PnNG0GucCfSQpiwsCDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BZI+lMtV; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BZI+lMtV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5Xg6H9Mj5+PxUpjw2fUX4zNIFLSLSnWgugkmvvtNJxU6B+isaBxnGsON0xmx4UsJsY9gj7H4kQGrKWVT/CvH5zHOzylahKbAiP/erRRULSD2ckhXJTKs3PYw+148stkqUq2z7izniQHraIEnz7Kzyiuyka4tvH5yl3F57geOfrTmpVKcTWiK512QSdxKX6Sdob8N790w1ydI9e0ZeFKNKfvESz5wmsyefYXg9gj82gByznXITgzJ1ZSkW1kX8xBfHYzl96pd6EVb1njyQnTH4VH9uZfcJ4PX75khlWXO7aExayL0rQI/Rh2c7V7BQTuIVS7eQp1oS6bK8uKvSFn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGA9Z8GvRJ33W2UDAJwNlQ9zFxkqIzoa1ZbPj1sx+/g=;
 b=pQti5Zbvp0ybElPuWXFVITmETOpuW9Ag1vEneDA18pHWL4Ztmqrk26bHdNtw/AUuQKvpuhq0G05UZH+eb1/Z8opRnMrX/3CjvzEz/OlPFjDoEGPTXsYUMATtI3/Ju0ZavCFX5zmoCd4o6VBI3d8rYAUeadNW2wWGuYMLUJVUOLNn66O6YYQyj38KApuE97SXfg6N6QN1sA9sha6HTTEJsRDeDWNPNBz+VEMiRreSqfFPLQJx2gFvu75RI8I1+0PRHwoyBueAARPn4JRgq+/OdM2i8mjUMLRnBMxLy/T23pbnO3iZd6v4WRjNwzZFIrutcUaSrk/SFwzjQjKta9W3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGA9Z8GvRJ33W2UDAJwNlQ9zFxkqIzoa1ZbPj1sx+/g=;
 b=BZI+lMtV2I3ghr7wMljKvDiNi2Imdy+iQhvP8bmBtQtEMl+VrR5nsgHDYz037kgUg31182Kr0K2wz/AZWu6L6Oq4zXOiLEL40Y5xPEtMUF9UC2vZu+mzDiSlDlFR53XljHpYegST7ak+JgKp5cuAHhFZ+sej/0/0DMrUpRdEsJNPoPMR7h4Nj+qsAxz6kl0Yb4RZmp7Bv2EiTadHY3K8vkWJwtaAQXkOu8zU/8KRLX2NlJ2Yh48omBvUfRdP759yItGZPEcPmq2K5XHn2XPjQvD8OaL3qrEUWKOGvC5EAjZUcSUsX2AiVy6/Bm3NvXGdAvv+mKKqqkMU1uO+kqMsfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:51:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:51:29 +0000
Date: Wed, 21 Jan 2026 13:51:26 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aXDLzlvzV-dfer7R@gpd4>
References: <20260120215808.188032-1-arighi@nvidia.com>
 <20260120215808.188032-5-arighi@nvidia.com>
 <20260121123158.GB166857@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121123158.GB166857@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: ZR0P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: f39096e0-1900-4701-b51b-08de58ebcc0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWVZMllMNCtHcHdHdmw4cHB2blcwc2c2SVhtd21mRlBjQUNWV0NzeG40Zk83?=
 =?utf-8?B?TG5ZTEJEZmV1SVBESVRlMkYxcVpqRUNWZHVKcHljdGhSTVovclkzeXpiOWwz?=
 =?utf-8?B?cEdpbGRva0VsUndLVnYwZ2Q2RUI0UWttU21oRmxJY2hZcU1DVlpxRFZTOEhi?=
 =?utf-8?B?VEd3Z1NicnR5NEo2c1l4L3R4ZjEyUVpESUpjb0RNb3hRb3FVSkljSUY0K0Nz?=
 =?utf-8?B?TzZ1ZEN4K29VeHRRdkZReUdhNHp5VDZOajd0RmpENzhnNEd2a0VScGppVWtZ?=
 =?utf-8?B?RG8rUlcrRXF3S0ZsZ09OYXcrZVp6ZEpqL1NxWVZhbGFSTGlSV1RMMjA5V3o2?=
 =?utf-8?B?YStyQ3NlZ1ZVZjN4RVhiR3VudFhlMWdma1poUkdvNmtabmhkVEx0Vk8xWjhi?=
 =?utf-8?B?UExkTnA1YzQwQm1KaUNRbnhucW5mY1JJNnhzVjRyODU5RmZkN3NYcVVIdlZU?=
 =?utf-8?B?MGxwNitiNXZOejZEWFIwTXpzbllWeG13M3hzZjZWUnJtYlZERW1VR1VnS0pu?=
 =?utf-8?B?aUxTQ1pqVElYeWJPbDI0bkhoUTQ1MnVtaGdVZVVoUGQyckxlYzJtQmp0T003?=
 =?utf-8?B?RnhUVmJPbXBuVlBwN1BORk1yMkV1MkJPN3ZmV1MraCtHRitZYjNQOU10YzlE?=
 =?utf-8?B?dmM5RWoxampIREFTU3F5MUs0RGZRQXB5S20xK3ZERFhKZmlBODRadnFKbTFE?=
 =?utf-8?B?R1h5US9Gc1ZuZHprRmxGSnRSQ3hrNjdqS3pyLzVra2JMWCs4enBLc1F4TE4x?=
 =?utf-8?B?U1U4ZCs0U1ZHcVp3UHBXZ2VMK2JyVEFWc3FyMzNMYmRoUGpqSVdNeFJPUW11?=
 =?utf-8?B?Y05wVis0a2pPWU5mQ3NzQVE0UzloWVhYaWxqc0pYRWNCaE5iV2lxTDJwVFo1?=
 =?utf-8?B?RFBrbnpwZDdxcnBxbUMwcit0VUpaOU5pc0ZnNU84aTV0Y2s4WlU5d0lBYVgw?=
 =?utf-8?B?ZzlrdVF3czlmYkFmNUlZSEhOc3IxdlpQOXdBK0dpNmxlU3pjcldsTG5WZHFM?=
 =?utf-8?B?Skdoc2VTS1BhVUpxSVA2QzJhN05FaTlSZWY3akdwa0l3bUFUcVVnNi9Gc0lj?=
 =?utf-8?B?VUpjTW5IVHBOaTdBM3FseDZYL28xWmpsUUtDLzZrL21SUWllSUJPRWF6c0FW?=
 =?utf-8?B?QjdCeG84VVhlL01IZHNyVlNEcnQ1VGVtSXl2Umd4cXpXY05BRlZCMGZEVTdF?=
 =?utf-8?B?VVByTlh5T1VPWnFobFJmWm9yQVJaRkN2UmVLYVdBdmxOVk1oRXByTkZCTWhZ?=
 =?utf-8?B?ek9taWQzU3I5QWlVQVVSb2pxendBZzh3RGFOZm8wQ2tRekRySEZOcUdBUmE3?=
 =?utf-8?B?aHFZeEdqcVVuZXU1WmUvTSt0OUlsUm14SFp3WmZJeUdmREd1ZEhtbnEzcHE2?=
 =?utf-8?B?OUdFTkFreGVhSFRxRUdaS2R4Y0dFc3NFc2l2alV3a2tBUnpKdWo5amRkSExL?=
 =?utf-8?B?NThGNmExU0VRUnNDVER2a0ExeWg2WFNwU014dWdBNnZkclFnSTZ4RkV0QnZw?=
 =?utf-8?B?QmRHNkw5VFVJU3NnczJnSFo0S2ZVSDh3T3dZNmpTUnZCcTRWSHFpSVdYKzB6?=
 =?utf-8?B?WXNvMkUybk1GdU9VV3ZKY2RnS3kwYWEwYXZ3eVQ3NjI0ZmFUazhhVGdSZXNN?=
 =?utf-8?B?MUZEeFBnYU9tdmZnQ0lHc044bWxVWFcrV2V4aGpPYmtFbUlycHRKKzJyelQ0?=
 =?utf-8?B?b0E4V2docEtpekhwYnMzRFZPSlMzN2pZVDBnMEpjcnNQbEltZEREbGRTc3pN?=
 =?utf-8?B?b2NpWmFqcmdsWWYxeFREZDRvYTVjVzdiY3d2TkdFampCdjNxM21rYzVCWTJi?=
 =?utf-8?B?dWZNV1dyZXhNdDF5RnRqeW5FdmE5QzQ5ZG00R3hHaWRlV0VLL0ErWWZYM0tr?=
 =?utf-8?B?OVRnMGViNlIzaTBlNENOaU5Scm5mVksrY3Z4bG9DRENPT0ZBcTZQOVg3Q0dj?=
 =?utf-8?B?MFdaTzRQWXZxWWFuUnNGLzU1bW8yV1VxbHArWkpkRGtCYis5WGcvbUlLT1lT?=
 =?utf-8?B?bmdDNkhMbzh3ZHM1UzM1Y0VsQ05lSDgydXErV3NEdDZQMnFYYjJuampkZkpS?=
 =?utf-8?B?ZEZLRittOG9ESU82TlBoeGhXeGliV1JHdFd0a05DWVpiNXlTcGc0K2Y3Umkr?=
 =?utf-8?Q?5pPs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3ZDcHlpRXBFVzQ3RExoR0JSSmV3ZWxXeVFFbEdvc1U1WjlnR3lSWmkyM0RF?=
 =?utf-8?B?SE9MUkpDNGV5ckdMd1hFdVd2OTNVSmRkUTlBMjM2Z0FPQ0ptbnljZXZMQUcx?=
 =?utf-8?B?MzZjN2JKaWVVQit1QVRscE1pMCt6ZVZjWk91aVA0MENTQXZtNE8xT2pIWm9O?=
 =?utf-8?B?QVE5cDBxQUNML3JpbWQ1Y3hSVzlsRHRPdUlxVHEzNzFPb2N4Y1EybyszSjZV?=
 =?utf-8?B?NmNldmk2MTdiWDVjaE1NZWE3SHFVWFdjMGdrM0xPV24rMTlsOVZBdHFSaE1L?=
 =?utf-8?B?bHdNbGUyTmlNYTVHL1R3VytiOWNvOFJxVU5neld5WXFxTmU4WjJ1ajlTUE5H?=
 =?utf-8?B?eEgyMkM1c1pLcGJkZXpieWNwT1F5cnJLdjQydVBPMXBndWJxRXJIY1I2UkRq?=
 =?utf-8?B?M0F4T0tEMUtxcmI2b0tSTTFWb2R1SDBhQkVsa2ZZZU5SQy9QdE1kb2hRczIz?=
 =?utf-8?B?VW5UelVZYVFyTGZuckRNUllOYXEwbktwTTVaMGl5bkJCcktMNUY5WjNrd1U4?=
 =?utf-8?B?NUxoclRIcVJNMHJRTEdDcCsxVWEvRTN4Nmx1NEU4QllBVmJacGpScFlJajFJ?=
 =?utf-8?B?dEZDSjliOXNKMm1GWEhvTWpYM21zdlE2L1dXQSswQU1jdUNuM2NGVEhsWith?=
 =?utf-8?B?d0dCYUtNYkFLVWNGam9FWncwNzFwcTRvaVpzUnNnYk1KQUtHVnczQkF1bjZ3?=
 =?utf-8?B?aUp1TTZqKzg3OFlKd3piRUsydmtPK2IxK0RXNnNNRDI3bjIyU2dBK0s5TFJH?=
 =?utf-8?B?UldKL0VWUlBBTmhpZXRsK1A3MXpYUHMwLzcxNmVJQ01pRml5R1RRWGxBY0dz?=
 =?utf-8?B?NloxM0pTc0VJcUZOS3hZN0JST05yVFB5L2ZxaDBjZmFDWGxvY2RQL2hiV2Nr?=
 =?utf-8?B?K2EyOEJmejJaTGwyOWJaZEhtams0SkJQbDRNMnFUSFZpNzFaRjdxRXl4QzVt?=
 =?utf-8?B?Q0RIYjAvdjI4UDNvWHV4TjRISE5nTzRKY1QwNFR3NFg4Vjd6aU5qZ2plVSs0?=
 =?utf-8?B?ZkJXQ2xQSTZtRWdJdHdobUV4cDVESXVWaDdYZFd3UnBiMGx3NW9YREVSL1Zm?=
 =?utf-8?B?QnhRRFk1RHFIejRRbFZaNUI5TTBHQkRwdjdZYkdZVXo2aFZ2YnJLS3MwOGNP?=
 =?utf-8?B?ZXRhRXVrMnlDcjNTbHZZdnpRWC8rU2lLL3dPSzYzMHpzSC9iVld1MmhxVy81?=
 =?utf-8?B?Y2hIUERMVzNjOFdQd2ZDU2kzTEREUmV2dTcyWFlYczVuT3lSY0MyYzF0L28r?=
 =?utf-8?B?aisxMG9FZENjRDJ5WkpRanBLQ2p3VVBzN2N6bUdqRzhXa2JvSnpUd2NocEFa?=
 =?utf-8?B?TThQMFMzTDQvNEIxb3h1WmhCN1V4QjdHS1RSWlNhcDUvMnNhRzRvZkdKSUE5?=
 =?utf-8?B?QTIrT2ZVdXVGMi9ISEFyWTdRb1RqYkZKZmUwS25hN0JGaklQeFdxWkN5eDh6?=
 =?utf-8?B?cnV0WXNjT1RxNGlmdy81WE1YSndIS3c0ME12dFN1L1B2aWkxb1Frb05LdDJG?=
 =?utf-8?B?bFBrcjVDMnJDT0FKczZEUUl1MUVvTjJaT2k5SU5LNmJZeEY3aUJzRy9tckFl?=
 =?utf-8?B?d2VjVys2T1dRMHJoZkhLeVNCbDZEZGJuZnVnMDBncTBZcUE2RXE0ZjJhRnQ3?=
 =?utf-8?B?QUhCdERWcGJEMFlnOFRCT0szQVZUU2llbWYzUmdDVEZib0p1cHRuY2xrdzFS?=
 =?utf-8?B?OUF1ZmpOTWVrcFV5bEdkMFdtUXE2eUI0bmgwbVVOc1BacXdVa3Z3WjExZUhR?=
 =?utf-8?B?RlVsL2EyM0F2Y3BiWlRpQzkzV2UxNEVFQll6WFluMFlkaXBDUVBBcmpTWnB3?=
 =?utf-8?B?cExGeW16ejRONmRiYUNjTWVqQXJKamZZcnhoMWhoOFF6ZFY0Zk9Ta1k4Tk9H?=
 =?utf-8?B?SFVCR29CVmlrdnBZbnE5U2FiVnNOYTE2c3FKK0hQSXRIbnRYWC9RREEyRDdv?=
 =?utf-8?B?dFkzc0dtZWFSV0lmVXU2czJxMVlIKzhSTXBBaDJJWWNoWHpzQ2hhV1BEdjdv?=
 =?utf-8?B?ME5BbGg1cDJwOUMyb0dPRUFyNkJOZVB0a29ReHR6aXNyNlRpZmR1RjBGdndE?=
 =?utf-8?B?bDFuNFdlUCtqck5Jcnk3TXdjR1hqbWxuVWs1U2xUTVI2OWdPWmRmT2JBeWV0?=
 =?utf-8?B?WW9oUUdmTlFlQVRvb3FTemhvS2RTYWF3MVdSZHhJMEEwMnVjL1BLdVB2ektk?=
 =?utf-8?B?UFdKOHNxWkNTTk01WVZyVmNmYTE5VXB5KzV1U0J4Q3RsTHlDQlo0azZOMGxO?=
 =?utf-8?B?eDgxN1pXeTM0YUdhN0N1bmM5eG1BSzkybXFEc3pUTWErZFVCaUIwOHRpRnd1?=
 =?utf-8?B?S05janUyR0VRLzZETkFjbjZobGJjYnZ6ZDRlNFB2aFJtNVpvdy8vUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39096e0-1900-4701-b51b-08de58ebcc0a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:51:29.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TosBSvhsQH5YTEOt/DN9w6Hm8UMAUJqC7NpmbpVINxLYZEyK6k+Y/GwGmzlEoMcKyP1ZqzrEPoQd+pR3obIQCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

On Wed, Jan 21, 2026 at 01:31:58PM +0100, Peter Zijlstra wrote:
...
> > v5: - do not restart the EXT server on switch_class() (Juri Lelli)
> > v4: - initialize EXT server bandwidth reservation at init time and
> >       always keep it active (Andrea Righi)
> >     - check for rq->nr_running == 1 to determine when to account idle
> >       time (Juri Lelli)
> > v3: - clarify that fair is not the only dl_server (Juri Lelli)
> >     - remove explicit stop to reduce timer reprogramming overhead
> >       (Juri Lelli)
> >     - do not restart pick_task() when it's invoked by the dl_server
> >       (Tejun Heo)
> >     - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
> > v2: - drop ->balance() now that pick_task() has an rf argument
> >       (Andrea Righi)
> 
> FWIW (for all these patches), those v# comments, they go...
> 
> > Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> > Tested-by: Christian Loehle <christian.loehle@arm.com>
> > Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> 
> ... here, after the ---.

Oh... I used to do it this way, then noticed others were including the
version in the patch and I started doing the same, I’ll revert to my
original way. :)

Thanks,
-Andrea
