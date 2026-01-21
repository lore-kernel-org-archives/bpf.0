Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F3830F556;
	Wed, 21 Jan 2026 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999790; cv=fail; b=rtKPSR+pVWwaQnYC1PMzaaGPdoLi6chV0bpLKYzVzRNiRoE9mLaI8ox8AjizPp8lWyEN2AnbkeOmGvLGbXHnMEx+GseJlfZQFr/cn2ceE7HF17qSCrosNYoTXU6o/x7jT1KpiIHYl6hNySDLY3PYcTA05K76uP46Yuj50wD9HCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999790; c=relaxed/simple;
	bh=S+alyl8MOyBJ7qzU08/rLdnOJON/m+x0yrdXQnKQMCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LpZiuN/PyLTmDwqF45Wo8YbiJMLTFUz7z7J82Nb3Fe/8+D8r/vdCg7iPwxJHpQ7qRiNvTvi/DV49okbqIWqnWJ6aFvVQ7L11WDx/niLk+8z4tcKvbqd1ErEJoie5m0b4RFzUO+dUsQl7zWD9CIXOHsxMUntK3QX7i1VDfgcw7NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jrcK+NWt; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jrcK+NWt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Znlsv6qhA3ozEoYiEvxou3HXn3I92GOBWMUndBDXREED9t8W+iioC28q4XFXlb66GN/1SgwDTTfje9nCUj6TOGSrcgl1oCSP+cJvjZHwseFZ9nrHeN+6eleAEyaQS14LR/gdu/4HC4KzT3cDWpnWFr6E7woJx+B6oRZIk10uyHaKFioNG+pIKWORstTSYIVekTc9j3oio4wKKRPtz42bDv8Sgc6mk+x2X66NjTV7fHxK1WO3Fg2BllTPEL8buUztU8TBDF9cW5939Dz8hWJvCv71/ad3ZMjoN+HdOzjNIcHCmwYxqf19JnYGhzQVHN/K+E2FcpsQIog6cudM0/IRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3EyLs/y9Az+hAm1hfyBvLse8BKGji1Z14TGHFfmVNU=;
 b=UjrCLDD2dy4fYDKFP6NSVXVmuyWrOtSNT+dUU4hVPM99vCI4BNei4jbVko5rs9Zih4cVeZydwob4FeHVGCXaLGdsEPbnOCoFtlghtXccYTEK5s4jKtMKRYvkPrTaBbypGfP+Z9VV1+cSh/krk6C1C3PSZosiK71l2ApA3UI3FXHScpHZolZ7lsXwV5v2QU69GkSmEB9nU0+gmhU5v8rtTepS9dXPcMwGzlxAmxFo5P1QSx1OW0knjgYr5K+QfHfJw2pasCumvZ0qw8DyyDrRKH8prDgGKAQRPok+5yqDF4kYSs5MV+2uFvMigUaIj3eSC3g0KPi3gRpooJCKeXRNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3EyLs/y9Az+hAm1hfyBvLse8BKGji1Z14TGHFfmVNU=;
 b=jrcK+NWt/IkfsbBU1gLPLnMagS+StOVIpZ6BtWZdMbMNl0WYSZL/a+Qga9HtqnXIXC7R0AxZMJLh7x39jLQdc0gXMWXzV7WaiGeDRJP3SFpytJataqSt/QDt5W+EvZb0hg7R/r+rAmdZ5eyOfTbj4JbSk6vZy/Ao0u6epW5e5hE81Ky+jySRDUEf03g7H7eBhOnE1TYJBk2c6ePQ5101jaq08DQXzzgRVuVRYnLZq6lsqcvbLfhMzNuHPLVyGFsho5Kt68VAFjrBn3/D6K3BNhViLKBE2R7GpU6bxfUNl5YZ1+YklZ2Su4qQH4qMZV3RukX4eWWh/SUEUE5TC4RoAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:49:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:49:41 +0000
Date: Wed, 21 Jan 2026 13:49:38 +0100
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
Message-ID: <aXDLYj0_VnbVZkJE@gpd4>
References: <20260120215808.188032-1-arighi@nvidia.com>
 <20260120215808.188032-5-arighi@nvidia.com>
 <20260121122901.GA166857@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121122901.GA166857@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: d1306197-f7cf-444c-ce16-08de58eb8b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wMtEPOv5tY9OlXw+qu4xAU2afnU0ZZ6cXZdMYDznU5XflBErsbW8k43+XOvk?=
 =?us-ascii?Q?tqwM2TuoeeUwZNtUEI7khK0qJZHcIvSLMuqi3g3sLqolatL+q3RtclimGR7S?=
 =?us-ascii?Q?DKdSzEMEzwSrqTCpj+YaeLgdMT6iT9qC2bWxEWLznTKO3RbPDgbQ3Be+sbx3?=
 =?us-ascii?Q?CL8x4fbRFfdraHoMd8vA12F1HYHpblPgBO6lYEsGacnF7g2MEMCBJiRZWVTv?=
 =?us-ascii?Q?Upa0Ido8zDJLgSxA8HiS+fycoO/GuF2pKwel6I9ZfQnPoY01jS/HcDZBPwYK?=
 =?us-ascii?Q?+UrU9sY7uiOyU0znXKXuMOq+TP+xNAQj/DlE/gbs+/ALdMHn13U5VE7Dm4hT?=
 =?us-ascii?Q?fUKb18oB99OERdBqAtGsMQoINgvfRGPMzxlBPc8dijkpHUc1kwfcavmGq2qg?=
 =?us-ascii?Q?KM0+GANf9CQytyEbmzjwi960SdZ1cYmMJibQzlS8JJvjXpynVYLc7rKKdNLY?=
 =?us-ascii?Q?Ia1K1ecgwmYGIqkzFDtTec1Jub+sAFpvQM3wsdMfiVkOVGSr+CzunXLvdrrz?=
 =?us-ascii?Q?qiO5K5IXC7xkGUd/BqaFQo5dWRl4cK2oHIIE1H7bneuK8x9dhKR+bBTz3mui?=
 =?us-ascii?Q?T7jIoRF3lRzVPZYQBQGwULluOpiA0o500IuTEPq1o3EWQ9jgUAL+S+pH+o5m?=
 =?us-ascii?Q?Jk0y3HbJRTvfW+Uv2A5iT9hht1wMDpL8tYQB+CqFUycH8NOPwS3yxgqy2DW8?=
 =?us-ascii?Q?dHgI10gMClz5HjGutL9neU6IIC+sM6hYni2PWa8CVqwuAHbMP4hu1nEoN4lH?=
 =?us-ascii?Q?oJa1sOf8LEQNg6vedcvA+Zz8txR2c85gJvJ+VNv2ZVI0AIjsF1gMmMf4hEeN?=
 =?us-ascii?Q?4icJU96ZQ/lkKsMx3GNaQl/7lYDkjLAae1Xb5vcQm40J5erE6haH7/dBXP+X?=
 =?us-ascii?Q?OD474zK2vpmhxYR761FzVRP3RUlq2+63s8oAuCdi+qaTzLdUndovJxYtIKng?=
 =?us-ascii?Q?z9d/0ygoauU/tNSnM6/AelcVVcTSemS7fdKOby27sYc8mzUtG6oR19EwSLz0?=
 =?us-ascii?Q?QN9+c2wkjGnyHlJZITQx8wlCimc3WmF92VV8dxMlO9C9uQ/Od/3VQpO7h0d+?=
 =?us-ascii?Q?zHVI3IBYl8eEIwhnGKR7yGA1RHcaZtqNK1m3GfujYrx0PQ6D89w86sNr0a6j?=
 =?us-ascii?Q?dYbL4gHHX8RFb6pUSc26PRfNp6l0xAOyODxM/s32xbNFiJkuC+Yskv1uCbAr?=
 =?us-ascii?Q?umTIkXTeF4Mbl8ivnb13kYYqXG+GXv08kVtiSyp9phWaNvC6zrHlH2AxnWIL?=
 =?us-ascii?Q?Wz/NPGiM5h07ykRfA1KqSQmeR7LoBp/uEbNAVcoYtljlMwpEeqgRxGIb3ySK?=
 =?us-ascii?Q?yL89HJt3F3s2DM2CeEyol3YCff4vXE8/yiVhRWJSJsV4ym4eHK3U3OAjbFON?=
 =?us-ascii?Q?ltmVKOftyMSGX34Kj2eZLANcH/MpFfbABQT5zx1GsUdbYRhEdwPFxrJvf/Zn?=
 =?us-ascii?Q?I/KKasyQA4grdGextZT4taa1uPm6ovdEP3pJ9Lr9d/r2kR8K33KHqBnUNoBV?=
 =?us-ascii?Q?xCyudZdhfnuGVN/GFPajeEcpWma7YbTRpWArFL4EAPdYlqF7ETyEUYx0x15e?=
 =?us-ascii?Q?CgObvjwJh+XFzyndQf8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5UQVXlXAcp4uSxbH5FMczJ4E+FYZ8NNPTESfZeiQeNdndQSRLRHL7vGg+E1z?=
 =?us-ascii?Q?mWK/RMSu9yvMTfwNDOxz7GrQvNmpOXokpYWvPyqYj2loaAn9x9aewUj8Kh5m?=
 =?us-ascii?Q?/LQCbz0WxhNLo5JqSMkv9TIJvvwQ0YaqjzoI8HEidslZRL5KY7FKPkRdu5qi?=
 =?us-ascii?Q?tnue3FXBVYKDtjgP0uxwQJ5bFxq0inppshwg6ajIZnZ4d7UO0y87cdTmoaC/?=
 =?us-ascii?Q?Z1Ifwy5iCz80+igOpisD7ydBmypfOx/J2iqo9T54xnPr73TuxwRbVv9t5h4v?=
 =?us-ascii?Q?Pph3QBjKEzR+sU1fqvR/18IKXiVoHJWrZU1hojo2bYXUHYaOqSn5Au6UrwZr?=
 =?us-ascii?Q?ySt1jMWYmhgDa/EGtX0138kZDxXpT9TYAbEKTNY4jvv3kohQ3xaieOe0iaQk?=
 =?us-ascii?Q?l5XaGkh99g3BXHvCf2jOd1OOh2OWPST9ktJ91eBzobKqQoSV7QSgUzcpy/PE?=
 =?us-ascii?Q?npmPcvJ+nc2L+UrYWZrY2PfQdU2eePnCh52PamuCZv0AZLf4fLF8jBa7kQyx?=
 =?us-ascii?Q?/N5zykEIlN7fddKBozsKKXXCSs1pr8AgzZ55ia4uw/4oxXy40rEWlI5mHC2k?=
 =?us-ascii?Q?Q8oUUyOoScbpMzwnDizOmn+A76W45+qKH2nOIQkne95wFTV8caRfLwRomvHp?=
 =?us-ascii?Q?It+R6DQXByphPMNaehwP3kktHYXIuSTN3XUK0dWCblPjDucAKkHwKjTfFz/Q?=
 =?us-ascii?Q?ERVv5JS2JEBuEFDsDsUZNkDgQN1qMtFQln2Q3mjLdyozIgQwVZG2oucjAWvW?=
 =?us-ascii?Q?mWP2YyPvidybAfPL1/i6aTBbJu9nrb+Vk8zVDcYwEkXtch/9Fb03u8hkp7fK?=
 =?us-ascii?Q?GKGIRgnIDcOljPYqOCOnEqZFitz0tgJjrsClMRZw/7mhmtXB1oK2QIKgiKAr?=
 =?us-ascii?Q?RrsVag+UDl2261tQFae5bjSYIEf0XzUJhhDeR26pkatoIWHSNyH3CpYqxNX9?=
 =?us-ascii?Q?isJOEXd6X0GXsfNrZNN0okLFdRDUHw+O1SvrbZ3rhRzZlEGf5foepmbx6lUY?=
 =?us-ascii?Q?RDylwVFObpIBRqvWWj/3/TVIPWf7bOCz6QgeTpyCkHSodlZ8kmSDmi/DZh/a?=
 =?us-ascii?Q?O3G0Ft6UnWFzvygtkY/oUTQmhKOqpUcKotRtc6tQoCN5q6QwB8npjmtKxTzc?=
 =?us-ascii?Q?m9QZApA+34fhtdVr9cO0lXGoZYy0ok8GKVZvYrFZDW080LzXrT0FxOtN0mWu?=
 =?us-ascii?Q?tO6N8KYXf8YjDI/wC69kq09d8BUcVr4k5TEigfj2eZ2KpD1mBUgYx7IwQA4h?=
 =?us-ascii?Q?n/rc/jcFghCANKIQbtDPZB7CEvk95FLtb2RadCBTPQ29DI0P+m437uCLYkOr?=
 =?us-ascii?Q?TaUDaajnhmmpGV4hZFmbrUH+WNiac+BFAE+qJ/UQLQPcCtDpk/qjv38QxxDy?=
 =?us-ascii?Q?iAAlGBsahXKG4vyrIUUSHNoyW5hyESj4ZKv1fkPLHCLD0sXIYZvCpw4OEGub?=
 =?us-ascii?Q?tJIM4tkTg4G1wr8dcE8ain3PJyzBpYXpEFIvrbndlrVp2OpB07h5Gjdvn7ap?=
 =?us-ascii?Q?d61u6Y5Usoq/uiZzXHkare6I2AuxnSTMwa0BORVnb6gUnA6EDbKmVp84N6kp?=
 =?us-ascii?Q?j1GHZ1QMEA+ZyzUftmF9GUF8/Tv7t4VvHyFcFCVAvjc5b5MUN1LYlrqLkgv0?=
 =?us-ascii?Q?jXsAthvhmxeZu5GXXxzDtj3TS6vqPOpoDJQOF6o6zjDf61CmoXpK0wg0nPZA?=
 =?us-ascii?Q?B/9ZBFOdYjYKfNewginyvN9CA27AJQLr9PEzObtoINEEHqxVg6ZtneljcdZ5?=
 =?us-ascii?Q?k4tVPFuk7g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1306197-f7cf-444c-ce16-08de58eb8b71
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:49:41.4644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOkSqRP1cJ7Qm3/OvFJY8UQNRB8fKRWLxyRdtmgLkKdi8ncWvLWYzWDmxXpZLx+SrZujLyo/D0hYM/lE1ID2UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

On Wed, Jan 21, 2026 at 01:29:01PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 20, 2026 at 10:50:35PM +0100, Andrea Righi wrote:
> 
> > @@ -1813,6 +1813,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
> >  	hrtimer_try_to_cancel(&dl_se->dl_timer);
> >  	dl_se->dl_defer_armed = 0;
> >  	dl_se->dl_throttled = 0;
> > +	dl_se->dl_defer_running = 0;
> >  	dl_se->dl_defer_idle = 0;
> >  	dl_se->dl_server_active = 0;
> >  }
> 
> This should definitely not be in this patch. Why was this added? Were
> you trying to do the same as:
> 
>   ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable tasks")
> 

The problem is that if remove this, RT can completely stall EXT tasks, also
with ca1e8eede4fc applied.

Example (with the rt_stall kselftest):

 # Runtime of EXT task (PID 2100) is 0.000000 seconds
 # Runtime of RT task (PID 2101) is 4.990000 seconds
 # EXT task got 0.00% of total runtime
 not ok 2 FAIL: EXT task got less than 4.00% of runtime

Thanks,
-Andrea
