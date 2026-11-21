Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795297786;
	b=tRClzyNqfSc/j5/MDu5cuEfKTBAG4YxJIkyv4MOEPjWlujx+H5FCPSOuIWgp3gDk+her
	 JvqR/ESD8fiM1oIKEU4W0V3t6LZQ8TdrIUqQRpg9F16ZFwMKHn01hoOHPflg7SnnV7II9
	 lIabuIW5i8b1bB3dAvbY5T82M9aU91ozdWILjVUbzE4nAjafF/pu0USexbFkSVKbO2pMi
	 KVoPcLm4HLRgRaPdzxx6r+319HWkYqwJ6ghOB5ikz7NzsO5Fw01lsn9j50xn6EsTmAxFt
	 X0ksea0wTtIY80a9eGMQgmI43hYaLAtiVOx3sJzgHnfFoFUge2rfmN9cFYgIGGvM9ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795297786;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RnJ6arqDe8XdKvMDDqjWCmoHXy77IV/NTKiH8CubKvY=;
	b=JB0du7cEKMzxgMm+eks7qCIvDBM19oCMgTcQYMcy7NktBLfLjM9XhQ0UkRZ7Wdj72SV3
	 MgARQy8/mWomK1zW1aU6t1Sg5BtzP99qdetI3iVV55fStZaeuHBblvruEZoBTx3NylWTp
	 5EFXsimy5NbidI7I2wD69b5xhFdTwfaMttIhkaxkxzozigDtWclg+H/lwBc+2givUlgzt
	 vuwnAz5FI1MTXcB12gF4xzk4a25UCu14+LbQRKaArGy35PE2H1kWU6yX+ufORlGjXY+KH
	 1sGxt6EnkBzoE7E7uJEGDtdxjUZYH9TWHZiWaonFZA2xv57Wzp6H9EMWw023C2s1z4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QDlMj8N9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.3
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340F606A320;
	Sat, 21 Nov 2026 21:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1340F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QDlMj8N9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6/CJlHOpa39segw8Vqt9sy4SEO+EVUgpftqORo5ZUbGtk4VmOFhard3oJfaS28m0A6p53L7/UcM1Nx9SbBZHr2JW8cjwJMyjO7OPiMobrLNq89VutJXvn/f9sGfUCRuVbhavq6XhCIzdEsMd5ZdrlDxfy+okspvSFY7U0bLOjUBsWZpiKA9kj6jofczRLXBaadIgGehH9NF3QoFg+cuGymW+5oQMkCCp115uUn4vRXNxQl5dHb/nHWZcamF5LIcZMDBu2dF5Ps6bzK5ZX31geKkWlidYnwvHeabcXNvw34DOHfMd1H5EdY3HL7N/QbeJa+GZtePHnZoc4mkqBXAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnJ6arqDe8XdKvMDDqjWCmoHXy77IV/NTKiH8CubKvY=;
 b=Pvr5oUPDPOpjfty5WNI58fEBy8c+ON9Z1YzJ3imUvMrBFZmzA6kbjeYRmKYrv+8dXwqnE5h4Hlq19OD6el1GEhvEZUNF5l5fi4NfVoe2qcE3HtrEJQzSb39wAyzFwpXYIhq1WfhNwD7TxEoN4QEVLU42pw8yLadPxT9wMnhQ5rP9mg0X60JcVUOUfGXmVoE0k0U+RoD59TAjvafcGWW5C+9R7vBoLBKWkDPuLJr5/ymtwVj0zepxHOHuFbaerAekCaiECN3YPfb5PEJQ4nAVUKZsuMWmFfGrUj4WvBFellAzrzCduJ/cnh2rXvceQtI17+8BqbvOiJWt9AO8jHwbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnJ6arqDe8XdKvMDDqjWCmoHXy77IV/NTKiH8CubKvY=;
 b=QDlMj8N9cqSKzmd01gecBcc2KmuDnPeK8iiozMctLBF/L0iEA3TtCKpsKoKA9OurzcEBfDIZVIP6L1XP6PxAmMEJdqgpRXvGqicP6akkx01NnU8kuFFdBuKN53QCczWT4WB2R1yobA+s0Oq4w5kmcmgmFAYYCcr+GTd+qRMiKbvmsYFXq1Wzf5VbwfIRmujqQTbuwmm/6xusmjbwaX6TXh4LxLVXVuBBHpGU8NxLtY4s8DHpfeXuPbCFWdi7jeeqPNqrTG9nHe00ZuUoZ1FyB19L3FTREi1d8q5eJbwJfhw0/z4IlxzvcRw3mYEJlJKSe/Bw3XHHDS6ywMD5qo8w+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sat, 21 Nov
 2026 21:49:40 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.012; Sat, 21 Nov 2026
 21:49:40 +0000
Date: Sat, 21 Nov 2026 22:49:27 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Vineeth Pillai <vineethrp@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Josh Don <joshdon@google.com>,
	Peilin Ye <yepeilin@google.com>, Zhi Wang <zhiw@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Himadri Chhaya-Shailesh <himadrics@protonmail.com>,
	NchangRoy <royfru44@gmail.com>, bpf@vger.kernel.org,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 0/3] bpf: Import external pages into an arena
Message-ID: <awIR5y9x9sK8j7dB@gpd4>
References: <20261117103028.4105609-1-arighi@nvidia.com>
 <CA+HDTgQ0mx0PgXDps2h2kd8TbJsFWOmJGJmDRGEHZgBZ_qSVwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HDTgQ0mx0PgXDps2h2kd8TbJsFWOmJGJmDRGEHZgBZ_qSVwQ@mail.gmail.com>
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 8125c396-49a4-4b87-1989-08df48195773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|13003099007|11063799006|56012099006|4143699003|261102123227099003|261026140227099003|261021123027099003|261026121527099003|261028144727099003|261021135927099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261102130727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	KVXXzHIyMwhSM4r7Bex4am0K3hfEoM/t+2I1wy2CLr356FOTgX7zjE1YTuuZJL0ITuBQ1RJS2pvrz0Xcfj7tASphhH6lf6UFCsjZY38qWilaXCfLZLXOBHBCxGIeFuKJlwHyM2zs9g0fegzMYonOWyCOK/aDQN71f5Z/aIqaIuIG+zE+FYDHU1iLvNAYX+abOeTtMb7no/hswCAhPW1B6nz6IcI+LM1phjg17cYD59RAnM/3INFvxTeJgZrg7OA1PLBj1A4/pnGfT5Nrnn+DUvqAqIYNZSwLWiZWUA6P78Kn+43Obhv1F+CbjsPHwZL6hg/fGyCYqrJ64l3ePYMF22Jp/tN5gU6OJGsn0aC+EGoG/sLrWbP4OYJtYW0gK4bwlv8J5xn3sNJKFsUB3XyFVexetV0ftSMMNHle3JDZG3bDdFhRSIRObBPaYQzgiRAkkyBk/k0gFOfg7qMPhAfMN37l6xnVouqAy60BMO47NmrSVaLZ1SxtokYlXKdoa9wZk8oHPfaDT9jVuFFeBtkGNXE42h0X/lMxtkBJKHOEnojRCkktoo1SysMtOmj6DPbgdBsZjbPuJ1SH2qHsNaI0MdQRnMWR/Lx85SF15MwaB4QAIL+v6lvbqEoXxXxfI5D7edjXmDrk0DQf26/CQBQaJB/hHBG3OLHmA8oVYUZfyzo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(13003099007)(11063799006)(56012099006)(4143699003)(261102123227099003)(261026140227099003)(261021123027099003)(261026121527099003)(261028144727099003)(261021135927099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102130727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTNybHFpUy9nMGt5RWtibkxka01WNldhWVhDSEtpL1J3RThTUTB5NzIrWkpB?=
 =?utf-8?B?cmNGc1g0KzZNZGpJM0R3dWpWcXk2VnNFR0loV085My8rQ2JsbENzMjliNXhq?=
 =?utf-8?B?VUFPOVFaeElBMkdoZkY5bFRiRWJCWTJkSUEwSlNHSElseVczQVQyOGV5N3hW?=
 =?utf-8?B?OFZVL21abVRXNmZPNE5DVzFVUVhpemozTFh2bnlSMVJUa2VJaVRTMENEcE9C?=
 =?utf-8?B?TXlidCs0WUR3TW1IZExiWlJXdW02VHBGOUJPeGhtYmVPUUR3NDBUakt1RVhu?=
 =?utf-8?B?STNHWkpLVU9SMDNKZy9vTCtXdFphNGlieXc5bklWOVlBL3htRzdFb29TSXlx?=
 =?utf-8?B?a0VkbVRsR1RFTkFhcFVFUGV0SUg5Uy9Nc0lUejBjemZVNi93S1pTL3ZNL0hH?=
 =?utf-8?B?L0ovUHhEbXd3eGRwbWd1MG9iSExFVzEvYWFVMnBoUVVObS8rWHJ4bGFwekxV?=
 =?utf-8?B?endwWG1EVW5jNTlTdmY3eWpQOUt1RUljemc3YnRUVUFVVm9JNTFxZjN0RmZU?=
 =?utf-8?B?Ui91Z2hkYTdnSy9FZXB5dWNwK3RwS2wyZzBmcFhGcklHMzZmTmxPdGJEd3Ar?=
 =?utf-8?B?WVIwZi9DdDlLYXUyUjQrZExDcGxXNXZwU3p5QXlJTHhzSnBHTVpZUGpzOHds?=
 =?utf-8?B?K1lha3lRUkFzR1ppbkxzb1NnSlp2clZ4TDd5aUpSYjJNbjh3Ujc0RGVUc29v?=
 =?utf-8?B?eC85MmRyYURSeDVnc241S2hDOXhyWnlEOU9HbmI2Z0tSUitJTGo1OStUS2d4?=
 =?utf-8?B?R3FGRjdVZndLOVZSeC96NFRkUHFIMXVGODhWVGEyMldYYWg5cXRiVFdGZllO?=
 =?utf-8?B?aGFCeDM2UXArV3NYRy9aSjAzc1MrQWN0T28zUHZuUCtmenp4ZzJycVprc2lY?=
 =?utf-8?B?VldQMlQ2aWhBSWNHVmVrNndpWlZNS3VxaWQyU2xJTU9hUlJZUGtWL2FOM3pE?=
 =?utf-8?B?Z05RaElZQjV5SmJLZVAyak40UVlVcTRpanpWUm1QSUp1bllhZjNvV0Y0TERR?=
 =?utf-8?B?VmtDSEpGVmo0TVU1MFhKeEgzenAzSXhpRm4zR3lFOUVCVEdLWnY3VGoyTkVt?=
 =?utf-8?B?WXJKeXZhbmRZLzNFQklJNjlvWWlQaDhMb0dYbVJWREYrS0RURDl2K3dpNjFu?=
 =?utf-8?B?U3hFQ056aFR6UXBVMDVFSFkwVmZrdldldTArRW9mRjlabW4yZzlRUVhCdFNR?=
 =?utf-8?B?eUFGVGJtZGxXVmpoK2RjWS90Ull2akliL1ZKeHdHbXc4NEg0TmVORFQxVzJ3?=
 =?utf-8?B?TjFWRVpDREFjaDFlN2xPVzRBZ3lnV1VHQ2NsN29nYkFiWGdMZE9TdlN2R0cy?=
 =?utf-8?B?enNwQ3RRaWFhRUpnZGxJMldoS3U0SmJGcXF0ZFY5NVNlL2FLb2RBZHlGSXFD?=
 =?utf-8?B?bHZMNXVCb1V5ejBSSmUyM2lGTU5RRlViMTZwTkRuc2QvdDhNdEZ6YU5nOW1s?=
 =?utf-8?B?UFQ2QStxU0pMUnd5alB6d0pLNTFrZnNkaEUxSXN2OE92Yms4Y1pldkhKUlFp?=
 =?utf-8?B?S083eFpMMjlPQ09GeExUd2x6NnZraVRPY0EvdlVPNDR5dGFEcTdsWG9vSXN0?=
 =?utf-8?B?UHQ3b1VPdjVGSER2ODAwYTc0M25laytraFJFdW5qM0Z6NjJkQlJkN1d2USs4?=
 =?utf-8?B?bjZDUmxEMDdkRFNnaWM0OUhVYkdHWE9GbzRjWGl5cml4UGNSVC8vWHgzUXNs?=
 =?utf-8?B?VysyME5rVUszejlVVFZqSXJZUGtOWk96M21NRlVEZ1hEK0NheWFCNjdYR3lD?=
 =?utf-8?B?dkNDeDVYUDlnWGpyQWZPdmxIYmtObVZKa0FsTzQyTFhtTFRtT2dReTFmeE1Z?=
 =?utf-8?B?RjFOQTRCL0tNQ3V4SDRHN0hsdGtUQW9sd2ZYa0dpSDNySVVaM2I5VkFJRkJt?=
 =?utf-8?B?RHZHSlNTeVVmTVFOMWw0SFNQRms2TmRWYTdrZGxaQWdUWC9SMjdRdEJKWW5N?=
 =?utf-8?B?OExSOTFvQTg3ZUtTdmNzWEQ0S09zNUsvbmlzTW5PeS81aEdTeUJUM2JMcjh4?=
 =?utf-8?B?d0NlY2Z6SWNHdFZwUHRJdEUxWUQyODBSWk1tTHVRZVI4K1Z4VlBzdU4vK1hl?=
 =?utf-8?B?RndhNmVKK3Q2VWo3UWMvL1pZQjFtSkczRnZnTGxWYkZ4cHZpTGxCc1pZdmRE?=
 =?utf-8?B?Z1FmaWxYUFczSzcybzNWR2p2SkNmV0ZnaTVLTDdkMitCa1I5TXB2NkNJMUx4?=
 =?utf-8?B?cTVGZklCaVQyTTUzSTNHTVF0VmhKekU0OW9nZ0JockFPTUw4UWZtamJNMGxa?=
 =?utf-8?B?alM4S3hVR081Q2lIaHo5SzdMeHE0LzBXa1Q5WWhCM0F1ajJ4OHM2YVpUcEVq?=
 =?utf-8?B?Mjk1cjVPUFhGbGsyeC9FQmVtMWVVQjRHNUU5MElWR1FYWDRyNWhGQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8125c396-49a4-4b87-1989-08df48195773
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 21:49:39.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KsxeTkyiAZuij2uXS0mLDIVpvSoV9tPDS1KvpqB+TR3zp4lKHX785WkK9FRsyKzoj9ayZaHNjMAFJYmfSCVMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805

Hi Vineeth,

On Fri, Nov 20, 2026 at 08:45:19AM -0500, Vineeth Pillai wrote:
> Hi Andrea,
> 
> Thanks for the v2 and for sharing the scx_pvhost/scx_pvguest demo
> branch. Thought of discussing the possibility of using the pvsched
> transport with the bpf arena framework implemented in this series.

Thanks for looking at this and for the detailed write-up, this is very
helpful. Comments below.

> 
> On Tue, Nov 17, 2026 at 5:30 AM Andrea Righi <arighi@nvidia.com> wrote:
> >
> > As discussed in the BPF track and the sched_ext microconference at Linux
> > Plumbers 2026 [1][2], shared BPF arenas can provide a generic channel for
> > bidirectional zero-copy communication between BPF programs running on a host
> > and its guests, for example to exchange scheduling hints between host and
> > guest sched_ext schedulers.
> >
> > v1 [3] exposed a pinned arena as a sized bpffs file and gave the guest its
> > share of it as a NUMA node. Following the review, this version drops that
> > approach and teaches the arena to map pages that it didn't allocate, based on
> > Alexei's prototype [4].
> >
> > Background
> > ==========
> >
> > An arena can only map pages it allocated itself, so its memory can be shared
> > only with the BPF programs and the user space that map the arena.
> >
> > Sharing it with a guest through a NUMA node, as in v1, has two fundamental
> > problems: the node is ordinary guest RAM, so the guest arena's pages go back to
> > the guest's buddy allocator when the guest scheduler exits, while the host can
> > still write to them; and memory block granularity makes it wasteful (16M of
> > guest memory for one shared page) and limits it to a few hundred guests per
> > host scheduler.
> >
> > Design
> > ======
> >
> > The arena gains a single primitive, arena_map_ext_pages(), which maps pages
> > supplied from outside at a free arena address. Each call creates one import,
> > kept in an interval tree with its pages, which belong to their supplier, not to
> > the arena:
> >
> >  - bpf_arena_free_pages() over any of them releases the whole import: the
> >    pages are unmapped and unpinned, and the range goes back to the arena, so
> >    the arena doesn't grow as guests come and go,
> >  - they are released when the arena is destroyed,
> >  - they are not counted in the arena memory usage,
> >  - the arena mapping raises SIGBUS on them (SIGSEGV with
> >    BPF_F_SEGV_ON_FAULT): user space accesses them through their supplier.
> >
> > Two sleepable kfuncs for syscall programs supply the pages, one for each side
> > of a host/guest shared arena:
> >
> >   int bpf_arena_import_memfd(void *map, void __arena *addr,
> >                              u32 page_cnt, int fd, u64 off);
> >
> > Host side: pins the pages of a memfd, or of any file on tmpfs or hugetlbfs,
> > with memfd_pin_folios() like udmabuf does. The host hands the same file to the
> > VMM as a memory backend, with no change to the VMM.
> >
> >   int bpf_arena_import_dax(void *map, void __arena *addr,
> >                            u32 page_cnt, u64 src);
> >
> > Guest side: the VMM exposes the file as a virtio-pmem or NVDIMM device, which
> > the guest turns into a device-dax device (/dev/daxX.Y). The kfunc pins the
> > device-dax pages mapped at an address of the calling task, and holds a
> > reference on their dev_pagemap until it releases them.
> >
> > Both sides then see the same pages as arena memory, at an offset known to both
> > of them, so they can agree on a layout in-band, with plain BPF loads and
> > stores, and keep pointers to it in the rest of their arena state.
> >
> > Use case: paravirt scheduling
> > =============================
> >
> > The git tree below has an additional [DEMO] commit, not meant for upstream,
> > that provides a real, tested use case of this functionality: a pair of
> > sched_ext schedulers, scx_pvhost on the host and scx_pvguest in every guest,
> > which share a few pages per VM through their arenas. The host publishes which
> > vCPUs it has preempted, its idle CPUs and every VM's fair share of the host
> > CPUs; the guests publish their demand and the state of their vCPUs. With that,
> > the guests stop queueing work behind preempted vCPUs and fold onto their share
> > of the host CPUs only while that pays off.
> >
> 
> As Josh mentioned on v1, we have been developing pvsched [5] -- a
> lightweight guest/VMM/host paravirt transport (with QEMU and Cloud
> Hypervisor support) based on the "guest allocates ordinary RAM, passes
> GPAs via a small PCI BAR + synchronous doorbell, host pins via
> /dev/pvsched" model. We recently added external-policy support so the
> shared pages after a small negotiation header are completely opaque to
> the kernel framework.
> 
> Looking at Patch 1, arena_map_ext_pages() (along with import_memfd for
> host/userspace sharing) already takes an arbitrary struct page ** array
> and maps it contiguously into arena VA space. That means for VMs we can
> layer your shared-arena model directly on top of the pvsched transport
> (on both host and guest) and get the best of both approaches:

Agreed, that was the idea behind keeping arena_map_ext_pages() generic:
the arena doesn't care where the pages come from, memfd and device-dax
are just the two suppliers I could use without touching the VMM.

> 
> 1. No extra memory backend or devdax/nvdimm stack:
>    Instead of a separate 16 MiB pmem file per VM (plus guest ZONE_DEVICE
>    memmap overhead, libnvdimm/dax_pmem config, and sysfs rebinding) for
>    sharing a few pages at a hardcoded 2 MiB offset, the guest allocates
>    ordinary 4 KiB RAM pages (including from the right guest NUMA nodes)
>    and registers their GPAs in BAR1. Both sides still map that page
>    list as a flat, contiguous virtual slice in their BPF arenas via
>    arena_map_ext_pages(), and Patch 2 (import_dax, along with its
>    dev_pagemap unbind blocking and mem_hotplug_lock ordering) wouldn't
>    be needed for VMs.

Yes, the device-dax path is mostly a way to get the whole machinery
working today with stock QEMU and Firecracker. The memory cost is small:
the backing file is sparse on the host, so only the shared pages (and
the namespace info block) are allocated, and the guest pays ~256 KB for
the memmap of the 16 MiB device. But it does need the extra device, the
nvdimm/dax stack and the namespace setup in the guest, and with a proper
transport the guest side becomes much simpler.

I'd still like to keep the device-dax import as an optional supplier,
since it works with existing VMMs and lets people experiment with shared
arenas right now. It may be deprecated in the future in favor of a
paravirt transport like pvsched/pvshm once that is available. Does that
sound reasonable?

> 
> 2. Clean lifetime and synchronous revocation:
>    In the guest, pvsched_guest owns the allocated RAM pages across
>    guest scheduler reloads, so scx_pvguest exiting never returns shared
>    pages to the guest buddy allocator while attached; on driver unbind
>    or kexec, a synchronous DOORBELL=0 detaches on the host first. On
>    the host, /dev/pvsched detach callbacks know the exact instant a VM
>    detaches or exits and can synchronously unmap the imported arena
>    PTEs (relying on ex_handler_bpf zeroing loads/dropping stores),
>    avoiding stale writes or blocked device unbinds.

Yeah, this is the part I'm missing with device-dax: the dax core doesn't
tell its users that a device is going away, so there's no way to revoke
the pages and the unbind just blocks.

> 
> 3. Up-front negotiation, authoritative vCPU identity, and doorbell:
>    BAR0 + the page header give an explicit handshake for policy name,
>    version, and layout before anything goes live, and /dev/pvsched
>    binds pages directly to VMM runner TIDs and KVM vcpu_ids (avoiding
>    inotify + /proc/*/maps + thread comm scraping across QEMU, CHV,
>    Firecracker, crosvm, etc.). BAR0 also provides a kick doorbell and
>    optional KVM boundary hooks when a policy wants event-driven wakeups
>    in addition to polling.

Agreed, the vCPU discovery in the demo is just there to avoid touching
the VMM, it's the least robust part and an authoritative binding from
the transport would be much better.

> 
> 4. Consumer-agnostic on both ends:
>    Decoupling the transport from the consumer lets scx_pvhost <->
>    scx_pvguest use shared BPF arenas as in your demo, while also
>    allowing mixed setups -- e.g., keeping stock EEVDF in the guest
>    (publishing via thin in-kernel hooks without replacing guest task
>    scheduling, which you noted in scx-pvsched.md's TODO) consumed by a
>    host sched_ext scheduler or kernel module.

Makes sense, and that's the main reason I'd like the arena side to stay
a generic primitive and not grow anything pvsched/VM-specific.

> 
> 5. Live migration and Confidential VMs:
>    With memfd + arena->kern_vm, host BPF writes go through init_mm and
>    aren't tracked by user PTE / KVM dirty logging during pre-copy
>    migration, and x-ignore-shared conflicts with VMs whose main RAM
>    uses shared memfd (e.g. for vhost-user). With guest-RAM pages +
>    pvsched, pages migrate as normal guest RAM: source VMM detaches at
>    stop-and-copy (unmapping the arena import and marking pages dirty
>    before the final sync), and destination VMM replays BAR1 into
>    destination /dev/pvsched before vCPU resume (immediately disabling
>    via header status if the destination runs no host scheduler, with
>    zero blackout). Guest-allocated pages also map naturally to CoCo VMs
>    via set_memory_decrypted() before GPA registration.

Live migration actually works with the scx-pvsched demo already: the
shared pages only hold soft state that both sides can rebuild. Every
time the host picks up a VM it writes a new epoch in the shared header.
If the migration copies the shared pages, the destination host sees its
epoch overwritten by the source host's and writes its own back; if it
doesn't, the guest sees a new epoch and writes its entries again. Either
way the guest is back under the new host's fair share within a second or
two, and if the destination runs no host scheduler, the heartbeat stops
and the guest behaves like a normal VM.

That said, having the transport detach and re-attach the pages
explicitly is cleaner than relying on the epoch, and it would let the
destination host know about the VM before it resumes.

Confidential VMs are a known limitation of v2, and a transport that
registers the pages after set_memory_decrypted() solves that naturally.

> 
> On the pvsched side, supporting scx_pvhost/scx_pvguest cleanly would
> just mean:
>  - making the pvsched PCI transport + /dev/pvsched arch-independent so
>    arm64 works alongside x86_64,
>  - allowing an ordered multi-page VM slice in BAR1 (not just 1 page per
>    vCPU), and
>  - exposing a thin kernel helper around arena_map_ext_pages() /
>    arena_unmap_import() in kernel/bpf/arena.c so host and guest kfuncs
>    can import and synchronously revoke those pages.

I can add something like this in v3:

  int bpf_arena_map_ext_pages(struct bpf_map *map, u64 addr,
                              struct page **pages, u32 page_cnt,
                              void (*release)(struct page **pages,
                                              u32 page_cnt, void *priv),
                              void *priv);
  int bpf_arena_unmap_ext_pages(struct bpf_map *map, u64 addr,
                                void *priv);

The caller keeps ownership of the pages: the arena calls the release
callback exactly once, whether the import goes away through
bpf_arena_unmap_ext_pages(), bpf_arena_free_pages() or arena destruction
(the memfd and dax kfuncs use the same callback).

The unmap is synchronous: on return the PTEs are gone, the TLB is
flushed and the callback has run. The range then reads as zero from BPF
and goes back to the arena. It returns -ENOENT if addr isn't the start
of the caller's import (priv must match) or if it was already released.

Would that work for the /dev/pvsched detach path?

> 
> I am working on a PoC using the paravirt transport from pvsched for the
> bpf arena framework in this series. Will share it soon.

Great, looking forward to it!

> 
> We are also thinking of extracting the transport side of pvsched into a
> standalone pvshm framework, with pvsched as a consumer of pvshm. I am
> envisioning pvshm as the transport framework for guest/host BPF arena
> imports as well, while pvsched remains a standalone scheduling
> framework supporting kernel-module or BPF-based policies.

I like this split and I think a generic shared memory transport, with
BPF arenas as one consumer and pvsched as another, fits well with
keeping the arena side generic.

Thanks,
-Andrea

> 
> Please let me know your thoughts about this.
> 
> Thanks,
> Vineeth
> 
> [5] https://github.com/pvsched/linux
> 
> > On an NVIDIA Vera host (arm64), with 8-vCPU VMs on QEMU or Firecracker, at 2x
> > and 6x overcommit, compared to stock VMs, the paravirt pair is 2.2-3x as fast on
> > hackbench, 1.3-1.9x on a kernel build and serves 1.6-2x the requests of schbench
> > and nginx; tools/sched_ext/scx-pvsched.md in the [DEMO] commit describes the
> > design, the results and how to run it.
> >
> > Known limitations
> > =================
> >
> >  - Imports are released whole: freeing part of an import releases all of it.
> >  - Imported device-dax pages keep the device in use: unbinding it blocks until
> >    the arena releases them. Revoking them would need a notification from the
> >    dax core and a way to tell the BPF programs that the memory is gone.
> >  - BPF programs have no machine check recovery: on a real NVDIMM, the supplier
> >    has to keep bad pages out of the arena.
> >  - There is no doorbell: the sched_ext use case polls the shared pages at
> >    scheduling events.
> >  - Confidential VMs would need the guest to keep the shared pages shared with
> >    the host, which the device-dax import doesn't handle yet.
> >
> > References
> > ==========
> >
> > [1] https://lpc.events/event/20/contributions/2429/
> > [2] https://lpc.events/event/20/contributions/2482/
> > [3] https://lore.kernel.org/r/20261010224902.1232178-1-arighi@nvidia.com/
> > [4] https://lore.kernel.org/r/DM6HVNSP3USV.AJSWS289Z3I9@gmail.com/
> >
> > Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-pvsched
> >
> > Changes in v2:
> >  - Drop BPF_F_ARENA_NO_FREE, BPF_F_ARENA_EXPORT and the sized bpffs file, and
> >    map pages that the arena didn't allocate instead (Alexei Starovoitov)
> >  - Import the host's pages from a memfd with memfd_pin_folios(), the VMM uses
> >    the same file as a memory backend (Alexei Starovoitov)
> >  - Replace the guest NUMA node with a device-dax import, so the guest's pages
> >    never go back to its buddy allocator (Alexei Starovoitov, Josh Don)
> >  - Release an import with bpf_arena_free_pages(), instead of keeping the arena
> >    at its high watermark (Alexei Starovoitov, Josh Don)
> >  - Map the shared pages at an offset known to both sides, instead of
> >    discovering it out of band (Josh Don)
> >  - Track imports in an interval tree instead of a second range tree and a
> >    list, so that a release finds its import without allocating
> >  - Link to v1: https://lore.kernel.org/r/20261010224902.1232178-1-arighi@nvidia.com/
> >
> > Andrea Righi (3):
> >       bpf: Allow importing memfd pages into an arena
> >       bpf: Allow importing device-dax pages into an arena
> >       selftests/bpf: Test importing pages into an arena
> >
> >  kernel/bpf/arena.c                                 | 461 ++++++++++++++++++++-
> >  .../selftests/bpf/prog_tests/arena_import.c        | 451 ++++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/arena_import.c   |  93 +++++
> >  3 files changed, 994 insertions(+), 11 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_import.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/arena_import.c
> 
