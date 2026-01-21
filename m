Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACB28D850;
	Wed, 21 Jan 2026 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016435; cv=fail; b=r4olYOrd/oruWMnGZ9LGRpdAHv0nH1yjvqhqb/I6HVVl80ex8hxk/leIT/AcdlDvSKD0ABEoiuhgbu3SB3QRu71lyMA3CwjBLrIMZfTosEtiAusn9AMA6cegpletKGt1NiecXAUYcPhS/OAgCOOh+/w+nAhdEAacZe5IMnc2x38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016435; c=relaxed/simple;
	bh=NwmL4QGlecx9VpP+Uq+D+TB70dUEJTnm1JvECUaelH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N63GVhOREmb++jmQQBudwpSni4qhNaOA4B8zd64lMy/7KX5orPzTtYCpMBHG801uhitR0J3Y3GYb4jGIUn2ZRMLeX/GupFf4S6PJE/W1Uu+uYn6rKKGXcm0HoxP+UFwlWE4YD6SMnih51VrzTisVYtKXjpJOvPc82kxrmKjKV0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GyNIO1X1; arc=fail smtp.client-ip=52.101.193.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GyNIO1X1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gF7o/oMdXQNLXPEoUmSKYqevYstTjIf9rr+nVJhfU8XVYwFOdcvb8g+Wc3WVOMGOEqmaIJfcKr20kSaXHKvVAHcw9WxTJPwT9Vh5GFFXtmuiG7C4c8I+zzeNk0VdTiLI1IHbrZ2w6jrZa1ZQlKjlzPyyy0pz8u1paWgee+IrT17SqBspfHtlC5I+vQ1XabHhYU9Dpj9PfUgbmhDPlJvUpOFKBzBgjv04Dlw7IMTcZ4mDjOqQYnPKp/eIiq9qJxovDlvW/y35UuWdj4akpme3DFvwHXBWrCAKtuObw6g2YorlJNCHmZlQrNAdclKszj4A3auQqgBPopyICGXRy/YqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuH2SeN+pCs6us0lz6rRBxR/q2NNfd9TlxqVR9LB5NI=;
 b=peki8ddh2XtZ9M7XgJVMwootDW+xKJ+QbzY//MJ1jQH2bdX9/2kd2ti+XoWuJmwolXVYe63ceUlKHlu20dNuW4N19zfV0fWXSnV0DGtIpa3IW3QG8JL7xQQSJ8aHFdGTEDChdz7/AZ25QVFateSi/22r/OTxWzVJdp9MbUTn2ZvBYyRfIBgODVxhP4H7PrGbiVdpTJXfMnwqHJ6aTGLEMIwQg8E9tsjuhLvj5EFfmMVGUmpz2I54RzFGaiIkW1MXqI5zZaNU270aH/5BDrrRmrT15UIs7h57zNUqbSohBD7CQ5VZiZlJHchGcQe0m+Wht/IxNvl2Yx1DW/LKzRD2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuH2SeN+pCs6us0lz6rRBxR/q2NNfd9TlxqVR9LB5NI=;
 b=GyNIO1X11y8dL/PA+mTDYdQQK9YbCH6Fu4yDlp+YYSjx8xX/qziNk4TJ1vZZpBGa3VYv/fB4Q1stEz+Y4XHFpRkeOXRSCw4XcPkvV+gfnF6NukqaNqFEJd+z9h1Zm6W1VPyV3D93UtaafZiBWdq6WGCDMitF1p8M3WmUWpvDF4/g5UnCWxROpwBy0HCYPpz1bel4doDavou26hc3we4sm0v1tfhN9fYzqcccWVPxWU45nHgLvj1MoqdoCs/othxJ9qT2e4cya+MEtx8r49ktiWuZp71Tm3TGvoN6Dr9zl6jeuj+R+l79cKSaGMql9CgBGRaiCLDuwZ9qLb4lyH5WCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:27:10 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 17:27:10 +0000
Date: Wed, 21 Jan 2026 18:27:06 +0100
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
Message-ID: <aXEMat4IoNnGYgxw@gpd4>
References: <20260120215808.188032-1-arighi@nvidia.com>
 <20260120215808.188032-5-arighi@nvidia.com>
 <20260121122901.GA166857@noisy.programming.kicks-ass.net>
 <aXDLYj0_VnbVZkJE@gpd4>
 <20260121155245.GG166857@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121155245.GG166857@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI1P293CA0028.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::20) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d986660-2b8c-427c-cf49-08de59124ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HKlCbJvFeDErJpWY6jY9vgesMgo9oFqXlh9IpiDA4GLdqaal+RGjhN+ATmPf?=
 =?us-ascii?Q?17Wfqa+HI5q4RnACrWlwllJNeRzsq/VmVZQUYPaqvDYcIr1q087NPb6oQlQn?=
 =?us-ascii?Q?zOR/Kf/uuE7OMTktNLrBqGPNTHUQ/JptSUKhtZAeBZciqd+nGhXevfydU3lR?=
 =?us-ascii?Q?deyJsWYi1rG4j2lLEmJDCwHJUkEf4ZKu9zGoyVP6vTQ1dwsUJ/uS7W3xKMZy?=
 =?us-ascii?Q?Eq1X4Yq530C6y+/R13h32L/niFWunaxfTBZQT5iSodJmeD5GH38MPH12fj7s?=
 =?us-ascii?Q?PXJ7iQqbEBoYbvz2LnC29ee0fG3L6NE5+ekVxfHbQIZfDT5DoljF7rbBpn27?=
 =?us-ascii?Q?3og3U2gtCVlXDl4gmOLXdqKexbbmlbvj9YwMENDBn2NhLvT6lWcdpJBu5xue?=
 =?us-ascii?Q?hX5CEAgLPqjilaVNFJPm4kYIW6+CGqgiVHhVQL+E+QjnlNUV+7BzA4nIc9XW?=
 =?us-ascii?Q?W0CiFF7Yakyl5R077lxu4GTLQNAvIw5zaOPURK0P9ezrR5tNOOVLKW3qSytX?=
 =?us-ascii?Q?gPo/IZaI4/hORK67kz8+wwuBPQD3cTUjtqLmhnhfFd6h9Kl5wY9kxaj+oU67?=
 =?us-ascii?Q?GQLQg/gLp2PY+NDuWNOcWiRCipTTs4WU26gEdokyMgSM4wFdT34fj+2/5eh+?=
 =?us-ascii?Q?qrj90czvH6WzKkf6q7mWaFl5Gxszpbu/Dz+YjQWwvCJu6vqVa52lUXKiPHTz?=
 =?us-ascii?Q?au/rsAOls9ozG2/1y4Wt6SSU374PRXUm65AcIad7MYu+47Psq6WB2joIgNvJ?=
 =?us-ascii?Q?sANFJsOMJQKtmUaY35KkOaLPfDo4ZWdfjuK6fMKf50gOmAZfEAOU4udWF51u?=
 =?us-ascii?Q?BtjAlINhUhxPDLGeArdVa/L18vt+lPqVxQu737heV9pohpa5IYD4022iqEKD?=
 =?us-ascii?Q?Iw7HRL1GE20cdn3V5E41CJsQnxQBPZbvyfQmm0gEsH0czyBNJfU/8og+NPNc?=
 =?us-ascii?Q?p2hNWs/pc+H13dyvUfXh+hyflt2dylcgmAR9jZ5JDD13ZRDXmUIVdVoBOqMK?=
 =?us-ascii?Q?1drCxuujjwssptFb2FDUFv9WqJIF2O3JQRKGf4SQQF/XT2ZIdYn84bzQHSvY?=
 =?us-ascii?Q?3vc2PSa2zRdRIO3lsm/Q777Or3xErmgkKCLCW0/hgMXa/Nh6HvZkyj2aOeAh?=
 =?us-ascii?Q?AKxgIYRe7Qv6Cx8pQvoVxU8zWovV4WuF2FBY7QJCi9faZSqMLYnxBC2NBFA8?=
 =?us-ascii?Q?OUdHGW/C3E27uK+EhAk0sQvEc5z2lPe89SAQnq7QSq9vROnJWgY57ncWzccS?=
 =?us-ascii?Q?68msLO9V8E1cZcjoT23GyYpdjHQb+JIA+n1Lf2g7fl3LAjFNjXTgbu4PW05t?=
 =?us-ascii?Q?ldnVYBs6wVWsG8WuKAV8/xEBPVRjJArAysAbc/7j2vD+HdqgawHJlZH0fYkZ?=
 =?us-ascii?Q?ajrxfGcKbW/qLuEaR044Fl3CEiZYD3Mr6P8eE905u54Y190Ivs1mSdBWs8wd?=
 =?us-ascii?Q?zjRoktX85+mzxO2Wfp/tLvUSWDPKSQUQ4hc+NQsEgNxJ621P+ORnjRUE6RsN?=
 =?us-ascii?Q?ATDA+YiHK4OXOox1VFfZsSkDKUdKKqVwwJVsTUTOpT26k7S0xYDsbIAnG+6d?=
 =?us-ascii?Q?rYyX7lRA77ATU49Fvt0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pLoOcZmFlGR+g7mbst8zYKO35cupzk/oq+y1ej0wPVG9+OaKLqp8zrK/Yq2w?=
 =?us-ascii?Q?N9o2TWZGJhmCnNw2nwUakoaQiHLK59cepZaJIFOwuanfHZ+eYXD833YgO+Kh?=
 =?us-ascii?Q?MIc130BhV625mvx5MJ87Lu8OihrAWORGkGuvNT2V0L05zqiJ+GdaJwxux1hH?=
 =?us-ascii?Q?5+m402ByNH2QKZPKePOoye2MPnnyDx5KG0Ysl5syau6AbO7UKZpdTLb+JHm7?=
 =?us-ascii?Q?eF0AE10NBfw4G/BTDczrcs4y/nint1T6bpDuF+iLMHZ+M7hELo7qC60Firou?=
 =?us-ascii?Q?TLMNK1w2mNdaZ+YaULBWmsfJG2wTpaouI28VacGykFn/H0lZQhxCpAkEDrh/?=
 =?us-ascii?Q?3Ex0eIlgP4yXZJAQiB1UhadfiMkS7AvJdZhLkFwksv/fCGGLLQOjEm4EbTNN?=
 =?us-ascii?Q?agnrKXHoiomgMnlRFAJEDAoGSQxGnjRHDOT8aNSgHMa8SjvlxrkAgCpGTNZu?=
 =?us-ascii?Q?P9Qb9BhVeNeGnGzimrMmUJn01WaKer/xOXKW5fP/MyCFcYNDbbg/cSG/wBqd?=
 =?us-ascii?Q?cs6jjpxX+mxO85GY5Enf21BMfsstEkFwit4ae0RE6vqWy/t8CqNYiD0uwM61?=
 =?us-ascii?Q?qbwJ1ph4VnyneryTYasGtxG3poDYvGo1lxsI7nhT/aX8W1AvfpQNRdPpln5D?=
 =?us-ascii?Q?VDgKLfL549gBRs0mXuiyvjsBOy9X2ere3Gc57BALYE4Cw0Zat6lWikVY6hhP?=
 =?us-ascii?Q?59JJ8rA4ZgTgT4CzjstOwxnzy/SG6hWFvP6VPY+3JZHlbhu+UsgAd1iD1wVP?=
 =?us-ascii?Q?wdsWs8oTZkEmbWtRcWXhZxLukkCofPsY2x6ZUF7Ex1tl7g4+MzHXQTgZy4OT?=
 =?us-ascii?Q?lirmwxg6Eckc7zjn16dQQ5rPXI3VHP/CXRD331XBodyK/BIcD+b/oDl3SL/O?=
 =?us-ascii?Q?gfTL/zT4oYvLsr6s6el7tBh5zsMb9hV6PDk/7b5KypvhpiaKai8y3D8dZK/c?=
 =?us-ascii?Q?6/Lc+S1Gs0O7APiGLW2VeKlbvn9M6qgWH/FdVydE9lHrVIw3b+7+duy92dxE?=
 =?us-ascii?Q?p+/OkF7fRaQlhbp9W+TetUlSalAy3JQ+OZeCXmqv4ak8SJLYWT4sC+FZw0Lt?=
 =?us-ascii?Q?2zv+3yNgY1DuPJeE4XSWuubPoWiDHRMMlCqQbjPliYgVUl+t+QUSrJzUCei0?=
 =?us-ascii?Q?P4X24euuYbff+VSndeTPAZYnSzY+1tV5sFtqD7FwcXH81Exi2ri9QDy1Q3BX?=
 =?us-ascii?Q?dhi5gxXvk/TJtNahJVI8zdCbn8amBpBcctWUsAnleUwvFoWCpqzKq7x+4yfl?=
 =?us-ascii?Q?Gp1lmvOMJu9e3cupHabDSFkcx7SBZSgpCU9lIo8X+7s+WzMr73Pbtq+HiLBk?=
 =?us-ascii?Q?5VdCy81fOVYyOAIxGN04Za/EDXp9R9dwDKlEcukE8nLgaSJSRLrp0xATYFMF?=
 =?us-ascii?Q?ZNc+7y/H+QL04zxAFGtWF+oKGa5aPg1p/4VG6zcRZvgkDhuV9hSSM3qqpu2i?=
 =?us-ascii?Q?YHBiotLGSoSPLAi/S0eiRUIwAwKspoUgCZ+9q/KkSEYm4ZfSxm8LttJvWqQG?=
 =?us-ascii?Q?MlbrEDcUI7ARMn4ctsk2zeMJy/XbZxGNv/8aw/OxbnVJaysxIdsawDYLuvTZ?=
 =?us-ascii?Q?HzBumrUetnvklcyMqWXAA/zxznV59+vjMWAhFmFeel3xXI1FiuU2EI9LfVgl?=
 =?us-ascii?Q?itF5N3ObMAJSk5piK9595QOlK3vUDUQR+rhPy5A5u/owsInNNZ/J6Y+fLM10?=
 =?us-ascii?Q?b6BddIEvtJiVt/XxG+KzW/E/dwP7qvPA0KW6D6ytfRY0ZFFFG41h1FeNpNU1?=
 =?us-ascii?Q?c+zAOBX//Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d986660-2b8c-427c-cf49-08de59124ef9
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:27:10.4072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgTyvVqa8ocR0ai9VOwHBoQGPRgH9MMmew3p0vjm5sz3LqXsC/KpLMXaoQQb5ftqJm82RaBlQsEXvSj9cduhyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026

On Wed, Jan 21, 2026 at 04:52:45PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 21, 2026 at 01:49:38PM +0100, Andrea Righi wrote:
> > On Wed, Jan 21, 2026 at 01:29:01PM +0100, Peter Zijlstra wrote:
> > > On Tue, Jan 20, 2026 at 10:50:35PM +0100, Andrea Righi wrote:
> > > 
> > > > @@ -1813,6 +1813,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
> > > >  	hrtimer_try_to_cancel(&dl_se->dl_timer);
> > > >  	dl_se->dl_defer_armed = 0;
> > > >  	dl_se->dl_throttled = 0;
> > > > +	dl_se->dl_defer_running = 0;
> > > >  	dl_se->dl_defer_idle = 0;
> > > >  	dl_se->dl_server_active = 0;
> > > >  }
> > > 
> > > This should definitely not be in this patch. Why was this added? Were
> > > you trying to do the same as:
> > > 
> > >   ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable tasks")
> > > 
> > 
> > The problem is that if remove this, RT can completely stall EXT tasks, also
> > with ca1e8eede4fc applied.
> 
> But that's not something ext specific, right? Can you pull this change
> out and write a sane Changelog for it, describing the problem and so?

Yeah, this should happen with fair as well. I'll try to reproduce the
problem without ext and try to get more info.

Thanks,
-Andrea
