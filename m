Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A92556BA6;
	Tue, 29 Sep 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710678; cv=fail; b=NRorHh2PfArf3UQn8YJECxhY0vEvAFXNBqFW6XVhzTBkSQsdlYy1clB5vghoXPw1GmKn1+acCBkw/ntSreO8psvU44nh97up1fneRwHsyz/yRc38zc1a8VQE9nYuXvfnvYmpis2Zh/1SuYWpRYymxa9gktJWtGNm1tMpe+f1ZiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710678; c=relaxed/simple;
	bh=JQFnISIatuEijrZRvVqz2RSsxefznoOqnGLtu0UlDzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B+XMUCAQaUxNHez93AgnVCeIRrOw3cnfK/Nf02QMIv9kef2gDW9TVKpbusoCvd1WaVrcQyyun0eb2dp5/rHGBZT9O7yOZOgqfmFVSQr5pWK5Vl8C0q2eMsKNfvbW9c9SFQ7lL3YoDR992YX8XN+YyrDxgVjUs5UbWcg3PQw7wOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VN/fRZax; arc=fail smtp.client-ip=40.93.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VN/fRZax"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5W8gNZgwZ/H5JwXL+FnE/s7/SL0sTTDyGCEUnQo7yBtY8Kp7uUd6GFpm1cy2lgqSbEJYJcfZ5UCS7lZ1mYOZzNRjRtBWnmKz2wNX1GPdBYrLs272X0Dyc+VqvC89C0BoTjnAdrZg2Q6TgxlGm00FkXq/UraDYkolpkmgMnYqbqWa0BF4mKrTDS1LQkyjnuJuERh7JVJNMOM65YNBK3yipqSaggFd2t3a41QN52qnWB4B5uu57Dd2G/a/dYgoGVPxpQ3PmiN/axmgJ+7LTV8HTj7qg5pn4YIuSOhTrlufqUBGpMr2PDqyY5fD7e1As0xlhkqh50JrP8tXd3sLvJbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP8eiBCJu7v39VpjNXGNbXjRzSeuVEfqtVV+yKpsZOA=;
 b=valny/I7FZbIg19RrAtB16Lxnxd4+ukqnDCFEqb3O5c5rwhC8PZdEqbVwmUn91aUXOdnD0IGLPN04bQcmjeFsLENh5CvfDXHyY+bpQGr7i572QiFYQZf9dONxxBN/6y+UzeggAnnZKSlIeU1HMrhMc2mEYvH6/Cc30PAtn4J7zej+oVmmIfPwwBxzfXVO7S9PLArbA0LHFaOSf6+wNN8crBomWWRXyMnHt2ErVv74kIPia1wMDJL0TXARO0bL6Fa2fLj4Qbm/3N34N34CveNrMHbazLRXyVancJ0mUzu6FYHjZeFhw0SPEJe4Qn/nxpZn3HAJrC1pZxaMrO/YdeAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP8eiBCJu7v39VpjNXGNbXjRzSeuVEfqtVV+yKpsZOA=;
 b=VN/fRZaxmMY8kZIw6VroAlSm9w4ZKP7Al51H1Roj59urQMP07sO4cFC9DM76WuvR6AWeRS/OCDR7XuBuG/emvRum9wufJGaQry71OTd2ALQ6OwHUrUv8Twb6KagJGJKE7evCJ1pjOKYo7DikDZkgzP4qm9RArXStlvDldC7T3LOFjR3f+artKB+Mvd491UvArRXggSkVfiZtOEAtJTW/ON1R1JIUm6ZvkIZ9m0TqoTgvBDUkq/PCIb7Wk1GwmCa5a+K6fvYcUGPiTFACcwYshVCQV359j5EFQS+E/ZIe3ME3Rb7ElJLORfHdFaSUB8vx+YhD7uVUtUyhC93TaUQE9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 19:37:53 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 19:37:53 +0000
Date: Tue, 29 Sep 2026 21:37:45 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Work around pahole 1.32
 dropping scx_bpf_task_set_lazy_resched() from BTF
Message-ID: <arwTiTqswOa_Zr9q@gpd4>
References: <7c139810be5ffc9764ed4236efc28794@kernel.org>
 <arwPVufx2ZUOc_sp@gpd4>
 <arwQjsHCGl5lF7LR@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arwQjsHCGl5lF7LR@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 48738ca3-2a2c-4db7-7d6e-08df1e61278b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ByKFCK4vhpw0m4nwy0eo4TknL5KP/ZXxtBH7N9XZzv1uM5qPTK1GK21xx4zH2KEeorygT2hZez1IXKJ89QZWvis9CmdQQ+vtqALoc4lMYiOrRArw//vnH2QFkb1VCGSaeGNDepVUqLcguDKTVn0ZSkhlZBPjwo8JIlVNlnzi+HQjWhxtg0aSGBTf6cJcaUgMNMAk+OuPl1DSlU1sD0C5KQ9vERvjS3DP8d9+40VPG55Fchyr3Lq9vTHVBl02MAa55/qjNQncgpX38R8r/nONoD4Wd3EvEQuOq+0a3A41Ghx0ABLKh5SofPQz31f3Ddeeg2MA3fCuXMQ8fYbMq/o26AcuXuXly+xhV8pwsB220IiLSJahcNQdW1U6Yb4h7pbzgZzqKoOTs554oN7abXXxm7tvh6ES6P7NGDxzn/5JYwh/5dBDLEjG/UwQHXMqq7VfwcWnAx2Ipkl80Zwq++KjZNCR6vbJg78i73P2zU5VgPtF2bP3jqbSM2TPHT6yMSFKl0FBaio2J9XZi7yQTX+aj/nMZ7nDKpHhkFcvA/wk3Koj/mXRbmxxc2r3PdERliiNXEoyZObUAZBiT/NmI/PJLvTJJClBoQO/qTwdjr+I375IMhVLRhIMSQpWKjwBS00N+RTxauxHUGyAn0AU9eDwypiXAYxE18isazDEaaMNxJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mAeiSUK2xT2d/wLXJ69MTPk41vOSN6JalqlZsMPDfZxIyvKeXFwHVkV2ty71?=
 =?us-ascii?Q?F82T10lg7LCuiThDUTSPi6wG4o36CWCrQXaAqmsFFlC8wBsOD8l+v4cxtOAv?=
 =?us-ascii?Q?i4HaDyge/IVleywHH+htFL5/waqoekdm9v98qRBpb2YDtAVs8u+GNILZp8en?=
 =?us-ascii?Q?QZ+tCJg6E5P7dZTpePHFUCdjbGsu8AVtML1d6i5b0WkePoAiWyTaAY+lcykb?=
 =?us-ascii?Q?AwhGssRPMuKEw+mxDeJhSjh3XhsSCOaQJ+hbU3Im9uLBTp+1vC5lZQ3P262u?=
 =?us-ascii?Q?/gcfE7Y1WCR4rXTAUFnIDDLg250zfdvHgPXy/EEUylR+xVBirplQodWBufVs?=
 =?us-ascii?Q?mrbenCvdebg3j7vC4iwTSEQEW4lOwQPVWhOCkZ70wpz9BOaha2PXkObm9mSf?=
 =?us-ascii?Q?PW7J4ET6L5yaeIsDGrI3MUDWy/n+Tm7BHen1NVSczi/SLogRVhzP1mSy5o7P?=
 =?us-ascii?Q?EPC6Z1ezGvHZ4TBfauerNoiik4EFRc7k5R6redZJBkszaPUclmj8HbQfPHMV?=
 =?us-ascii?Q?KWauEC0bddix3susG6v+8TGgQWb/QRONN/a1lW7o1jEcKspJb2qGZUJoUWOF?=
 =?us-ascii?Q?Ff9HrbeoTiTxsI935N7rfuRUIg4QGsG4XszJpUDYr7DTeKrtSJ2NFieNWP7w?=
 =?us-ascii?Q?W5dU8TnDOgwrMBU4c0JtS7BR+T9qAXq2HCy+uLwGK+39ZkIawGpa8seYvrgz?=
 =?us-ascii?Q?2lb4a8wldntNOL9aw4GouO0OsfyNhAKNbQrUb2xCQf/EX/6o+Pcf8EzskqsE?=
 =?us-ascii?Q?FeHNuHJf74VtdrLwHloFxLJZDjzuH/lB8mMPioP6me4ZMP4TsJQEZLPRZyCO?=
 =?us-ascii?Q?o2bhugaHbbtov88eg8dEn6M60rMJ1KOmndfQrAHxpL9UGRcBWOuCubSbKjWO?=
 =?us-ascii?Q?z4dwRGNvUdUGC+u18lWlGmBbCHYA8LlfOurRG4m33Qk8Gj5j/nLg4gSCJ7tp?=
 =?us-ascii?Q?qos8KRbjkIDwAa9hgAoxBkF10ah6s/tdhPoGIa4KIA7rtGczqxpAhmU6Fce7?=
 =?us-ascii?Q?u9B8paksA5Ox63TTveLHpoH2Fb1s/f/EXNC0B9FCKAHa73ivIDracN+Kylyt?=
 =?us-ascii?Q?yhk9z7gIrlXKxtK5XR9xDFkuiCgmXeTmFJ38LHriYkNMNkFw+8SOXTxxoRtK?=
 =?us-ascii?Q?PylmDR7pVUN5wgqoC/gH70jdeqELprwbEklKWQDZU4qTQ12EZXjl3PqG8xO8?=
 =?us-ascii?Q?kNZPN42fr8W6lWo3/De35+/1CnTqa1RwHgTeGOsokSkbhkii3yLXYG+5Z9zY?=
 =?us-ascii?Q?Jp50/+tHFpgubEIPv+TP2LkCzTNUPyMYFTB6pcy0WO+Slaq4mMVkh4jtM9c6?=
 =?us-ascii?Q?hhleRgcpeQj7ghPg3LjSbY7d7w4F2Q7OJcJlFM+cWxLhFQaIF2nceqwXFjNo?=
 =?us-ascii?Q?PqU21ucBMTiicGIO0hxwg7vs6x5JeoV0KzwZd1Z68ZJTk3EWZHy8S2WY/J9k?=
 =?us-ascii?Q?RgcONTGOS3B19s691nyi5VCWxyk27cyvHfsUHv0mwjQH+WRdla5I7+oY5qbq?=
 =?us-ascii?Q?yuZQIPw7dp44eq4NEuq61i3uqpGm2fDySVxJIS2mBvw0CN69/PZ4M0l8hCWd?=
 =?us-ascii?Q?WGuEL2S/3/cQmrG8sSUVHT7nmJX4cAsmaANMk/IsRZbQbsysl73AnbiC4NgJ?=
 =?us-ascii?Q?uTHn+oorQ8thYs/wadzEsq+yfr1zT+AwUQCo+K4/lJAfUha8DU7wnEpwVdiV?=
 =?us-ascii?Q?Ae4RNcjaQqqgTYSnhQKkw8uW4yEHqHZKILSL+2vHLsNYe0bvwtyH+D0fM+7C?=
 =?us-ascii?Q?GvU9ifSweg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48738ca3-2a2c-4db7-7d6e-08df1e61278b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 19:37:53.5705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eE0NHagMJWt2g90tOT1koWJb5ca37bmTf0DuP2+kPmNhYS1f5qN6JQpr+VX6aI/YVJxibFLOGV7BjJiMYLSC4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

On Tue, Sep 29, 2026 at 09:25:02AM -1000, Tejun Heo wrote:
> On Tue, Sep 29, 2026 at 09:19:50PM +0200, Andrea Righi wrote:
> > First of all thanks for figuring this out, it was really annoying, I've been
> > holding pahole to 1.31 because of this.
> > 
> > I also looked a bit and it seems to be triggered specifically by the bool type.
> > This is with clang 22.1.8 on x86_64 without barrier_data and only changing the
> > type:
> > 
> >   bool  movl %esi, %ebp    -> dropped by pahole
> >   u32   movl %esi, %ebp    -> ok
> >   u64   movq %rsi, %r15    -> ok
> > 
> > With u32 the generated code is identical to the bool case, but clang keeps the
> > RSI entry range, so pahole is happy.
> > 
> > Should we just change lazy to u32 (or use a u64 flags) instead of using
> > barrier_data()?
> 
> I mean, bool is the right and I'm hoping clang can be fixed and the
> workaround seems to work, so keep it as-is unless there are other reasons to
> change it (e.g. this becomes a wider interface taking u64 flags or sth like
> that)?

Yeah, at the moment I don't see any valid reason to change lazy to a u64 flags.
And it's probably better to introduce a workaround in the code rather than a
workaround in the ABI, so let's keep barrier_data().

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
