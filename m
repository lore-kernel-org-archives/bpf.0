Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975653D4139;
	Tue, 20 Jan 2026 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946304; cv=fail; b=PmU36rJaJvdOlhsIOkumA4UVS3f+Y0j2/s9reK2qgm7uZS9Z8sCDbF6n27SqxvGGO7qI3+umWOJgdjr/AIyuDMrIJcSLnOA2VHMHsc2ZLezHZeYizeyGZoJDIpruhHxx3C5KA0CWUw6jwO56YNZ0G5gLzzecRznApAuf/9LCiCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946304; c=relaxed/simple;
	bh=H8+/VwKmtK7knNmnX0w7quynoWOR/dT+B3A5LaiwzPo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L3oLN3zt9xLtodtulvqVXn/0cXlrI+rOuZSqEngaRmtMSUV05OTrgBJQQAj+HxJjJ6ldDzHW6PIHS8Xsujq5LwacqtC0COdUarRStkiGAsYn26Hp/bSK/JhDKdBtWpg0l6pBAC+eCQq1eTm9Piy1dkYGOnA+MowBnRRYIjDaxkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hXWVBARY; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hXWVBARY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNvlU5g8493EuICqvtbBK6QXQPZEEPHqoOez6ICRQ5h8K+UKPRhzDla2t0O5wsQSqhGD+smAJFHBei9yc0PH2ns1JvDLJU3qgOU3Ld8yo8UbjESKKY4yhI6+kyPR7BecBPG4s6gDGi+aiBcNi/txjtnP6f8IsCZyFfTzOEj6a6Bl40ehEmd0b1yKn/LoGSumMEyAb3mgvuVE064JWH8T2RNmH2hPqhzHtnYK3tDJzV2tR8vP7u3COAu53lDBlUnCLi7OOriEts7zskR9IEFw+8YbR2OGFa+OIXfLjH6MWc8vYalb54HJvItY19dYEXWR5KInGl33Q6GGyjrMrB4GiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmZ9Vsuj/BrQWe/KI0y/bT9kAU91QpZp5Z4C22Wtcvg=;
 b=LCBdwffIz7zd7gEFQq3Hakx3koPMlDqw3UcQs94E2eOA3aGZ+xrjN8aYViPvTL/rAEPY9Mn9bruXS6QGGEj9ICfoay+S70HfBw2uFnyQYsoxTgTqNrXWWiglGovrOhqQo71bAr7MBP/I8Rew7gj83IcloiJMHJMe5weodWjb9GLAvugnxu5cOcchHs4XImYafq3QrdgihN43RoL0z3c5ITRNYDiA+OURyXyo81P2q4etj9gO8nV78/Lehfvs+3okxJWGxxcsVtsDuvgr64Q7Id8/Ts+ksE15G1D9ZwQihIbzjSaBRUU7H/wq9StHvVGuKRR0x8NG0bcpurGNvGnqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmZ9Vsuj/BrQWe/KI0y/bT9kAU91QpZp5Z4C22Wtcvg=;
 b=hXWVBARYQj/J1pXsvMioS1cqVXPvLPCjxHVV5ZnLu4/S46dCeZ4bCdJw+nSBkue12dvE1c06nWQ44dfFTgJk6rDIGQo4Pb7uyXGmF2+3D2GxU+1L7LDvsTM3nriznsyoXMekEFTfaBRu4Wx0FLh/KmYZ4Gu/JxWAkPPd7rDHdRW3VacqC3cnt4EJglAlNvI32ya6iaeCmwBoQ+r7icrbvCWCvlBLkIb8g+RivlMT6UwUlS32gd0yqx45MmsoYB79XTU4kn+v35iwDF4QZkzWS/SNi0+KLHvZThEtcsU23M0VEK2GR99A8BhFXiBMif2D2PFGU4DxweJxcHQoWCaYPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 21:58:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 21:58:15 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET RESEND v11 sched_ext/for-6.20] Add a deadline server for sched_ext tasks
Date: Tue, 20 Jan 2026 22:50:31 +0100
Message-ID: <20260120215808.188032-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 7844f6ec-a927-4154-fe2d-08de586f0322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3nQyKcpFY95EtFXLzAkZg745eprJnInMYdsKMgZmS550ST+1OZUxgbZb6dcP?=
 =?us-ascii?Q?vrSUBSvX5AR5gnCLdRHdy9oDEAHLjDMch/9/k90pC/EBHVtUAcL4sYHzCafk?=
 =?us-ascii?Q?+7wQ54dgj1ci4iojrz4jH/fN+gVTRNFOyiujbfjdaRVNpJVFbKFraibfoSkx?=
 =?us-ascii?Q?09jOyI1vWW7LXn1ShzLLiyJ0ZVU0X/nK4mzcZeJQcYKzeH94tdbGkaIIrG9v?=
 =?us-ascii?Q?VZQVKiqKSiA3EOvEN7n4kgMebJxp6DxQtsl8Sj+/2WeTQrP/6bGpukMgVdGX?=
 =?us-ascii?Q?xu+FCL6VykMZlmsPXXr+9/OEcEJIlRQqQMMARmQ5YBOnQEkhIPXNF9VZr8wp?=
 =?us-ascii?Q?nJH8z61JsEAJFaR2xypgL2zKJ9oT5Sz7L2WYp+aemWoiHkJ/vgDtIK+YWN7x?=
 =?us-ascii?Q?eBqivHuAMku1PGVIaf7nKTjnTVzYWl03N8h5D3BdwLXzCLoy7ZCMuJnZYXRB?=
 =?us-ascii?Q?jCuj6ouf6wrayhzCDlj4vEAKb9eofLCADpOqj/6VOnvg3lhRgEcxnAok2wsA?=
 =?us-ascii?Q?RLnmx1SV6LE+WMOMOt4CrxMNI3ec8FQ4ZgnpeeWYxuMC9vM1QjNrXKx4YbmI?=
 =?us-ascii?Q?tH67DCUCrHmGQGtFKZD8Doh3rxdUku6HQm6vch2mWVCFG+VzLhBBfy1Ot6+7?=
 =?us-ascii?Q?ewMhHBxlSntbA6ZSXlCvI/nmGEosXXobmW0L+anLV0uIPB8rIYybV8S+SARm?=
 =?us-ascii?Q?naIh0DSEmzS7o5Jr73WaWA0VjCL6AEjGsyY3O7w2u/cdYlQln+evG/slR+zZ?=
 =?us-ascii?Q?sEITuVc+pZUunGcwkU8A2EfbBTk7LCmogbh/lcfNNBm2tZx3ztxhjjEdX5oL?=
 =?us-ascii?Q?D8DP9mBlPjBDpPsvl+czUN/4RDk5KWt8k6aF+ORTiOg4D8khEHmFpnT0csDa?=
 =?us-ascii?Q?KIYpOk90v81m2zboj6EcSkCbB7hqoKZ9WTLP/D0kq9QSnzClgOSpVOWHwkRR?=
 =?us-ascii?Q?IikJKnpG+wGxe8ygZAnIDHCX6WrtBJUPb4zALpHsd9ZgspRXckgMHB33wiKa?=
 =?us-ascii?Q?Ll7Rj71+S5oNKwBWrVfmoDynRZHf5KzGyyNn5K9eSb+689OhMpYt2XA2Shha?=
 =?us-ascii?Q?FzA8SlfLnjbcOqBVoNRCeXhtbJETPI7xnbyvPzUDMg+ZVQoavd1e3eYgzf10?=
 =?us-ascii?Q?eoxApCQ+V+Kjbrkpmt2HCelTiPq7Kc0l+7OxPapkRvp4rtFMeP21HeT+gRyh?=
 =?us-ascii?Q?7+4EgNYJMWl/ACr7QvJ4sOPJ4J1SeFde/4I3TgJZe324a8kX2xvKjHcZVDxu?=
 =?us-ascii?Q?lBriWLmoG3FcdWk6WMaSDy9/oYuDKVGerjud0IJTeEreT0tGKoV2gF+yzRwY?=
 =?us-ascii?Q?7BEQXTTG/UOK1P6mdQG0Q0SeVp0X3uogjrwPtcQ/OWdAkgG1HOo9swm3dVcH?=
 =?us-ascii?Q?Kdu6sKN9+e0tND8gGG9qh4MLeBl2H4ASaFhii2TRbR1Lcy+MGBTxMNPm1K+n?=
 =?us-ascii?Q?gJNZ39Hgx0JELyuvimGL9TTBavwV2hxizx/8Spv0hF87kRv4gI8ny0glcTtt?=
 =?us-ascii?Q?x7+tWOeka4PiJPxxE43buRG34pZnFD+ZBlStdqsjFNlnPO4wR1jJd2mF0mHo?=
 =?us-ascii?Q?0M0QJpS9biv4UpgyvD099Eky24Do4Q3c0FaiSRo1nDxprM+AXYLKoKXtaCoa?=
 =?us-ascii?Q?3KR61A98SAF69TcYtxntF8s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nTW+xHgcH8a8H2q2KLvIWtOAhq0L/ZJALOYyEcYIVfCCHrRVYIgdheMIpTe2?=
 =?us-ascii?Q?ylRSlgNSRSHJfKxffBu6bOoTRZnefflDzLeDiE3EpLg9zlY8vOJ9Gh7atGMU?=
 =?us-ascii?Q?p12A7aP/fAhX6ZArkPliGFT+Ok2S5v5DxetSwA24igngZqtzs+1aXZ2ZzIDP?=
 =?us-ascii?Q?nMAxWoVh+LGXZJ8Tr5e5IaO1JzVJ+GEbYjEZU5PMWxCiaaH2DgS2mKEsqyz4?=
 =?us-ascii?Q?JLrGcygI/pByDQPnehRlBk1B7Q1Pt/k5XYGYy71VO2E3e0Fw/LmWtA1hbC1i?=
 =?us-ascii?Q?rGoFv9aGXDw+gDbGxuI55z3EjAYLQpHUFgzU2B8VvwBsMaNh+XOhPa/LJ8a4?=
 =?us-ascii?Q?55v/bDjG3LYWhwYrpEvVYcCcFhvPVaJRoZ2u/VOaLp7nnsgfiQ86sEU6kHy/?=
 =?us-ascii?Q?zoMUvhCftQQ41d55J5if7fusEeW7zdwC5U5FVgz9X/SNHRfnoRv51W0rDFP1?=
 =?us-ascii?Q?VK6aSXtJr6q5EsbpDlTZs9cojzpBzL/Aa1Ucfk3D54YxLe+8ktkClxjKw1Iv?=
 =?us-ascii?Q?EW2UYxY8+xaqfBCo74bAJLDV+M3jv4dZPEqOKO7LPQ1ASuWCnRMkg8pi+DTD?=
 =?us-ascii?Q?w83JN02m++fDKQeRI0rfcn+4INRBp/YACFftXpzLJgPWS5D9CE7R31BZuZ/T?=
 =?us-ascii?Q?RwQ6cnuioGPxg48gWBpd4RYULZAVviDOTPT70a3ALgb5RjE0hhIl6jNZ4DaM?=
 =?us-ascii?Q?2fbMoBb5nZcnApx9EzkfTFFUyxAnQRGkXYQZoRCUcCX08JruLaZfotekPeUk?=
 =?us-ascii?Q?O4eV3gcFowIDqTZlrRrji0No4zqa7PCnSMJb4DWHzt9GyDH6WwjW5N0fjC6S?=
 =?us-ascii?Q?ZosVcgiIuUxVxTa5Kr/UnF5Ww4GCdvFj73f4woHfFAhM8eei6ITh+NcrXeIM?=
 =?us-ascii?Q?xh22bVWUYhIqsJjau2YmHN7VB6ek2f2QDVCLSj0tvAVIci8lsHIQFGk56V+y?=
 =?us-ascii?Q?JHNpEPFOnViayvLZv6gwjhZbbXW/kzKS9zY+gjyCKbDdzQlOK9awcc1Je2MX?=
 =?us-ascii?Q?mLgUFUtcyW/xG2QTTjDh8r6DSMQm0N1w18CmoY7OjIUjMSJ9GMo86S87p2yC?=
 =?us-ascii?Q?gEshHrMSj5X+EbnpDBmnCBRJuu53Kbq3Tkqxs45ecUBOK66wYLyVyyFNLzxG?=
 =?us-ascii?Q?mJv+WiZaOcjAK5IRWDIEMcATHTJ7STAEkkUQBU5mbPlHbzBzzdjCc5YWPV5B?=
 =?us-ascii?Q?lkccI6wf04puiXprHb+dn/G8lluieWvviuEltTOAM7drU8iamC37RZNUfff6?=
 =?us-ascii?Q?zomtbpIJjNymtxD7X0tDSQ8iBx6oq+AL7LwrCyby2EZ+7Yynr0xb2J/mYGpO?=
 =?us-ascii?Q?qC8h61VeyoOOT/qWT400Acuq2u7534O6n9wbjMc5IQwMjIG5k543gDpgc3Fj?=
 =?us-ascii?Q?hYeheA9gzYYBrUbQlgkVF9oUQRyO2LI2U1EyWCfQ3IxfhS3YuF7aJlNEY6X5?=
 =?us-ascii?Q?7UH/NJ3828p+L8Fpbcd4MtVagMcs94n8Ck8m3Jgz33LlobeLt6Cd3UBL1YSx?=
 =?us-ascii?Q?F7LHzv8r8eBSij6J9zV001ZSUzB4L0woJZC8/0ENPgmhM/miipJi2bhdu6r8?=
 =?us-ascii?Q?6bTy790VE+Y/fPZ/AfND23Ve5y8HKtgoZuJDQ+bRYD1Ds8TsxRUHrt9q9q/F?=
 =?us-ascii?Q?3F/FstOPkrYipCDoQUhrS1McY5ULr8zrzRVNnacREguEYNaOiiPtQW8kdvXw?=
 =?us-ascii?Q?6k/0jt2X9ybNw98pykWODJzGm4elS9bSXlL/Y+EHTCPbuWcA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7844f6ec-a927-4154-fe2d-08de586f0322
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 21:58:15.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xE7+SlBhF+RpICdIwTshxu1BCTPHNTXP64saXBQrG0hKm+X3Zas3vfoW0YN+mwQBxBpXHA0a1WpgRvEiPuwfSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101

This is a resend of the patch set originally posted here:
https://lore.kernel.org/all/20251217093923.1556187-1-arighi@nvidia.com/

Re-sending to check whether there are any remaining objections. As
discussed during the LPC sched_ext microconference in Tokyo, a potential
"open issue" could be to define a better interface for configuring the
assigned bandwidth for the DL servers (currently via debugfs). However,
this shouldn't be a blocker and we can likely discuss this further at the
upcoming OSPM.

Tejun, if there are no further comments, I think this series can be applied
to sched_ext/for-6.20.

--

sched_ext tasks can be starved by long-running RT tasks, especially since
RT throttling was replaced by deadline servers to boost only SCHED_NORMAL
tasks.

Several users in the community have reported issues with RT stalling
sched_ext tasks. This is fairly common on distributions or environments
where applications like video compositors, audio services, etc. run as RT
tasks by default.

Example trace (showing a per-CPU kthread stalled due to the sway Wayland
compositor running as an RT task):

 runnable task stall (kworker/0:0[106377] failed to run for 5.043s)
 ...
 CPU 0   : nr_run=3 flags=0xd cpu_rel=0 ops_qseq=20646200 pnt_seq=45388738
           curr=sway[994] class=rt_sched_class
   R kworker/0:0[106377] -5043ms
       scx_state/flags=3/0x1 dsq_flags=0x0 ops_state/qseq=0/0
       sticky/holding_cpu=-1/-1 dsq_id=0x8000000000000002 dsq_vtime=0 slice=20000000
       cpus=01

This is often perceived as a bug in the BPF schedulers, but in reality they
can't do much: RT tasks run outside their control and can potentially
consume 100% of the CPU bandwidth.

Fix this by adding a sched_ext deadline server, so that sched_ext tasks are
also boosted and do not suffer starvation.

Two kselftests are also provided to verify the starvation fixes and
bandwidth allocation is correct.

== Design ==

 - The EXT server is initialized at boot time and remains configured
   throughout the system's lifetime
 - It starts automatically when the first sched_ext task is enqueued
   (rq->scx.nr_running == 1)
 - The server's pick function (ext_server_pick_task) always selects
   sched_ext tasks when active
 - Runtime accounting happens in update_curr_scx() during task execution
   and update_curr_idle() when idle
 - Bandwidth accounting includes both fair and ext servers in root domain
   calculations
 - A debugfs interface (/sys/kernel/debug/sched/ext_server/) allows runtime
   tuning of server parameters

== Highlights in this version ==

As discussed at the sched_ext microconference at LPC Tokyo, the plan is to
start with a simpler approach, avoiding automatically creating or tearing
down the EXT server bandwidth reservation when a BPF scheduler is loaded or
unloaded. Instead, the reservation is kept permanently active. This
significantly simplifies the logic while still addressing the starvation
issue.

Any fine-tuning of the bandwidth reservation is delegated to the system
administrator, who can adjust it via the debugfs interface. In the future,
a more suitable interface can be introduced and automatic removal of the
reservation when the BPF scheduler is unloaded can be revisited.

This patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-dl-server

Changes in v11:
 - do not create/remove the bandwidth reservation for the ext server when a
   BPF scheduler is loaded/unloaded, but keep the reservation bandwdith
   always active
 - change rt_stall kselftest to validate both FAIR and EXT DL servers
 - Link to v10: https://lore.kernel.org/all/20250903095008.162049-1-arighi@nvidia.com/

Changes in v10:
 - reordered patches to better isolate sched_ext changes vs sched/deadline
   changes (Andrea Righi)
 - define ext_server only with CONFIG_SCHED_CLASS_EXT=y (Andrea Righi)
 - add WARN_ON_ONCE(!cpus) check in dl_server_apply_params() (Andrea Righi)
 - wait for inactive_task_timer to fire before removing the bandwidth
   reservation (Juri Lelli)
 - remove explicit dl_server_stop() in dequeue_task_scx() to reduce timer
   reprogramming overhead (Juri Lelli)
 - do not restart pick_task() when invoked by the dl_server (Tejun Heo)
 - rename rq_dl_server to dl_server (Peter Zijlstra)
 - fixed a missing dl_server start in dl_server_on() (Christian Loehle)
 - add a comment to the rt_stall selftest to better explain the 4%
   threshold (Emil Tsalapatis)
 - Link to v9: https://lore.kernel.org/all/20251017093214.70029-1-arighi@nvidia.com/

Changes in v9:
 - Drop the ->balance() logic as its functionality is now integrated into
   ->pick_task(), allowing dl_server to call pick_task_scx() directly
 - Link to v8: https://lore.kernel.org/all/20250903095008.162049-1-arighi@nvidia.com/

Changes in v8:
 - Add tj's patch to de-couple balance and pick_task and avoid changing
   sched/core callbacks to propagate @rf
 - Simplify dl_se->dl_server check (suggested by PeterZ)
 - Small coding style fixes in the kselftests
 - Link to v7: https://lore.kernel.org/all/20250809184800.129831-1-joelagnelf@nvidia.com/

Changes in v7:
 - Rebased to Linus master
 - Link to v6: https://lore.kernel.org/all/20250702232944.3221001-1-joelagnelf@nvidia.com/

Changes in v6:
 - Added Acks to few patches
 - Fixes to few nits suggested by Tejun
 - Link to v5: https://lore.kernel.org/all/20250620203234.3349930-1-joelagnelf@nvidia.com/

Changes in v5:
 - Added a kselftest (total_bw) to sched_ext to verify bandwidth values
   from debugfs
 - Address comment from Andrea about redundant rq clock invalidation
 - Link to v4: https://lore.kernel.org/all/20250617200523.1261231-1-joelagnelf@nvidia.com/

Changes in v4:
 - Fixed issues with hotplugged CPUs having their DL server bandwidth
   altered due to loading SCX
 - Fixed other issues
 - Rebased on Linus master
 - All sched_ext kselftests reliably pass now, also verified that the
   total_bw in debugfs (CONFIG_SCHED_DEBUG) is conserved with these patches
 - Link to v3: https://lore.kernel.org/all/20250613051734.4023260-1-joelagnelf@nvidia.com/

Changes in v3:
 - Removed code duplication in debugfs. Made ext interface separate
 - Fixed issue where rq_lock_irqsave was not used in the relinquish patch
 - Fixed running bw accounting issue in dl_server_remove_params
 - Link to v2: https://lore.kernel.org/all/20250602180110.816225-1-joelagnelf@nvidia.com/

Changes in v2:
 - Fixed a hang related to using rq_lock instead of rq_lock_irqsave
 - Added support to remove BW of DL servers when they are switched to/from EXT
 - Link to v1: https://lore.kernel.org/all/20250315022158.2354454-1-joelagnelf@nvidia.com/

Andrea Righi (2):
  sched_ext: Add a DL server for sched_ext tasks
  selftests/sched_ext: Add test for sched_ext dl_server

Joel Fernandes (5):
  sched/deadline: Clear the defer params
  sched/debug: Fix updating of ppos on server write ops
  sched/debug: Stop and start server based on if it was active
  sched/debug: Add support to change sched_ext server params
  selftests/sched_ext: Add test for DL server total_bw consistency

 kernel/sched/core.c                              |   6 +
 kernel/sched/deadline.c                          |  87 +++++--
 kernel/sched/debug.c                             | 171 +++++++++++---
 kernel/sched/ext.c                               |  33 +++
 kernel/sched/idle.c                              |   3 +
 kernel/sched/sched.h                             |   2 +
 kernel/sched/topology.c                          |   5 +
 tools/testing/selftests/sched_ext/Makefile       |   2 +
 tools/testing/selftests/sched_ext/rt_stall.bpf.c |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c     | 240 +++++++++++++++++++
 tools/testing/selftests/sched_ext/total_bw.c     | 281 +++++++++++++++++++++++
 11 files changed, 802 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c
