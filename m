Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013052.outbound.protection.outlook.com [40.107.44.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820C361DA6
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342831; cv=fail; b=IoN5Nlz4X6uDjF8okmOv8aSWUDJ3dHckQ1t8BJEC5ObDELLQ4nkGSix6cS5OC2AA6EyAh2JpqKZJUPfxnwIRDopx3mRHv1BTHYVgWb+oUa/81K69gggJIcjpdUrb1+gGjtTpjk8p0Vp/QCVtJQEwN1SXAlYHWTP2BdP5/2MlTvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342831; c=relaxed/simple;
	bh=JJ7LBI6YnDUoKQLQfcwmYXZTsrdXMJq91FUi5eHeE7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TUP6wjKyVcMTpE3m3irk9V5s9RZ/hwgoVQCBze7JLgGTcme9hCvCpI29Isa3CvcMvkgDt/pWsdF15XyMO3K2wm4W9ZiciAAB4kr49zNzqe6RFfctO/BV9Cd12EAB6/dt6D7bHITnq3kMB+sS7620as7zcJNx9KEKRYcZO+jzfLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cuBDjQvr; arc=fail smtp.client-ip=40.107.44.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cuBDjQvr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDLr54c1L62jblyzdGuBI+FjjL7it295I0il2blNJEPkyvt3n5OwV1drMw4Phpcp0QbZ1DI6I4OFXB3k/g2zL/ThWRL7+8tn7F7fZhGv/0AjoMGlr3s50aXc9UJMdWFFvfIN9kk1ek1dNKh7Lgt2ejlGsrtIlj2UChwLo4BgWz4uu2wtrxhXtp+RAAJ6sY+4/Mzl0ae2cjmhESzjAjymNO/BOTcK1E5g0VzGTT70iQTcsgRboN4jNyuzawtPZPH81L4fci5w/f5LJn0lsJookgrlS9uzdGRqgQqmJPzyWgNhaNrXMbP0/TZAB40KAFIf/Bm60od2ag6iNa+mMZ2QJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukDSvzddZBnKc1KteVj62+LpIQ6FSaK4r8t7fQmB/Gw=;
 b=duRgJ8mn2r8SR7fcNmNTU9VWkrUppAFfHf8Gzh3hIb3oknpMvLRa2qpKAxy/x8ZvkGi7lrOCFqhDHN8Zkiany1soVeJhi2CwmEvIaW9QFBggGMobR4IFSx6XY25gBEWoUzpg6KviA/PqTct0PVeI7Xsge3NF9G5/E2wCZ+gfisa8mUAmcNpv3d2mt7VA9jQ/TxcxL6qWrurZa3MacKyCqLu/fMiTS6NtoDJyYGCBvU9zgmklW1FK9tqvv5DFQzfgloaeGfb7XnepTBDQEFmWQWJfyPitw7vXChOCMoeGuIVkvIdo5hL2z+nc4eQ0EQIUpP6aRHY239X1b2tKMWRVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukDSvzddZBnKc1KteVj62+LpIQ6FSaK4r8t7fQmB/Gw=;
 b=cuBDjQvr/uB8CtJPzUDpE0yuOziXCeoRa/hB7yotkViQfbGJwXZzIq8TsB8hC7YbdJnk5DveLIxsb2ByCl8tg7ONpRpP1aCoCTYnBfkwp0PIbXwOYuWKvC6oll9onoh9l7oiAgOS4fPm2359wvepT1QToVf3nf6OzFfNuUwZs09Y1nKd42B1+3CoPjPvFA2qFIyixgEnrUglr6olcgQPSrJUR4K8vfIzQ4w4vuN4YsEI+xDBgNJ6T6eqXWlW1pnfTFDjbKjagVhjv4+EMZg+dhrvAB/HFafyzEiQOw9RABn2pqnu3u6ZKT6WPsYz9vnVaFZ6CsoV0F/wkSPaygZGNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB8952.apcprd06.prod.outlook.com (2603:1096:101:33b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:20:26 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 06:20:26 +0000
Message-ID: <40e6c11b-5868-4463-9067-374c96775553@vivo.com>
Date: Mon, 10 Aug 2026 14:20:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 0/2] libbpf: Improve BPF load performance by
 selectively loading kmod BTFs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
References: <20260806042042.3239428-1-zhaofuyu@vivo.com>
 <CAEf4BzZbsH2kyq9wb=eCNEOioWJnO2jSwsvbL3uWeyL51OnzVw@mail.gmail.com>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <CAEf4BzZbsH2kyq9wb=eCNEOioWJnO2jSwsvbL3uWeyL51OnzVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: e3af2235-30de-41a0-7fe0-08def6a7778c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|4143699003|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GBbPTeOb0aqkAx/T26KDATx0w0NUAJ1Sqew6I+XzbAMDTvnwhv5WAyWGIRzag5NQeOwRBVEpQ9Ze5m5OVpYYzeZ2W6ovuCViwOtw8OBT2+N1ms3C0VeTd0F2Fs9pQ8ImTzgSLN4kU+AKG6Y43kcgMvLfrgtLgTuxqh4uy6o4MKxa2IFwsjVY/Q7DcUu9qsbjGkL4aVWWAPt2A7Mskss0w6H7/DJRUGohpoCSOXJz+uL4kldstc8og9dT6QHT4swMGRc7elBdcikQMS34TczQPY3OOFXvVDRkwT3HRx4DKHWH/HETpG3KbOPMfJDoydsWgwL8cLEwWD4PcT6Ofn/5N/JhIoosGjSLGb4RaZhzGVMVgB8A77pIHkpIdtzz7ACeJWimYn/JZoRBleNFGVJ9aqT2w9ZARmrUebByKpeBldpdEEzG4DDaeocPj0qX4Br0chfxiBPMegTq+jKftnGRMY4fPjTlfm74erWmG5hX6SO43/sbwopjjxHZ5+gxg2wbofMmXLbiFwn5SJ8u4YLo8idH1uLQW2Xcd8ze6W5RY9y5xG/pf609dAAkCUox+JQnUvRgl5q+Ps6UP4u+frjXxa60YMxhF0rgSWOH5UOcrWAmKQL4ChEJpeKxvr4ly1NLETB483UrB3D4HfOwk3IiLtmJUeydN73kQpIDJBcKIpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHVwaUc1MkJGVnNwRmVsRWFYUjdkaCtVMFE2TnNpbUZQMWkzN1RORFprU0Rr?=
 =?utf-8?B?U2p4L0hsQmVrZTJxMHREajRlRWFCbUUxRnBRWStsdlFLQzhvQXI5ZFNrWjIr?=
 =?utf-8?B?M2NOUkkxSlV5MlIycGVkbEpsR0lYQmhZaG1tNjQ3alpTd2Vxd2ZFS0NsUDdo?=
 =?utf-8?B?S0d4OU1SUFhMdU9hQXZHc1NRVGRuazdzSy9oK3dMemFobE1iQVJKY0ZseE05?=
 =?utf-8?B?eUg4Z1BIa0x6Y294SVhYVWEyT0s1cVArU1dtQmd0TU1aUGlzZU5UMElOYWs2?=
 =?utf-8?B?cTNZN05yY1Q0RXlaTmwxZ2l4VEtvZkhTL3poYVFnNmpaeVNWNE1sVmM5UjVz?=
 =?utf-8?B?K1ArOHBsWVUxSFpUOW5aVDd1eVlSaUhqSnplSlRUTW9DY2RNV0VaR2ZTU1ds?=
 =?utf-8?B?N0lRaVRVcFFtZ1dZU1d6VExtdzkzTWFnaUloYTdyZzhXb1pacVBURTBTZFl5?=
 =?utf-8?B?TEVxRTh2cXBOV051emVsaEJvZXFFbVJDdWcxSHh4SFZERTF2TnRvdnZPNFNB?=
 =?utf-8?B?QjREZ1R6OUFpWkdPa2I3QklUd3hsMHdwYXBSaGlFc1NrMFRZZlpDR2l3L3k4?=
 =?utf-8?B?RHliVU9OWmJQZjBLZDVEbXBvdmVaK25EN0VWQnJiNXdQY2ozK1JnMkk5UU1a?=
 =?utf-8?B?a2ZLTjRHRVZDdHNrSWJ1L3BESFhlZFhaanQyK1dqWVhLaGIvakVVMkEySHc4?=
 =?utf-8?B?STc0N3lnbExsREo0dVhBZDI3cnkrMzFGTzRLdWo3bVZ4UHhFanpNOGhiTUVP?=
 =?utf-8?B?Y0d5NjhTbWR2b2g0WmU1QWdLTWt1ZlVvVHpyTFQzcDZhUDlSQjRVSkkzTHNM?=
 =?utf-8?B?NnNib2xoM3NWT2lYMDNHS1RXRUZPUWNJY0drQlE4TVRBYW5qUngrQzlkS0xS?=
 =?utf-8?B?cldLRVlQT2xUTjRTaVAwWHFTK3QrcHYwZ2dRL3BEWTh3QUc5T01Nb3EwK3FO?=
 =?utf-8?B?ckpuWStlVjN4UnBXV2l3R2ZNS25odzRyK29DSVBGQ2ttUGlHSmtSYjExK1F3?=
 =?utf-8?B?U2o4cG9nZ2V0ZVNtMWxGU09lM0NERmZZQnNWTnRuUGh6TkRZMGJ0UVdaamsr?=
 =?utf-8?B?cWZSV0FicW5CMThYZWt1RjBKQkhpN1hBMWs3Yk5FQ0wveDFlNmYwNHFmWFY4?=
 =?utf-8?B?M1JnbXhuRVRiUThWR2hmbTlHeVRDKzFSVXN5a0pCWVp3Vm4zV1IyQU55M0dp?=
 =?utf-8?B?MXZFRE5sSUlsaDBUUTZ6citCWXhLcDNROHV0N2Q2SEk1Z3hmdm44US9nc1Fs?=
 =?utf-8?B?SVkzWmxJS0N6V2pTRUVFYTdLb093RDVwQnhRbmRBQUowQVFETUpuWlk1bmRJ?=
 =?utf-8?B?ZTYxTUpTK0kvcHU1UUdETElyeXhSZnAyTXhaTnNYNUN3UUFwVHBPOVlRYW9o?=
 =?utf-8?B?aVVqMXVXZDJoZVo5eGw3endoUXhtTGdoU21NNmt6cFN5ZXArZGpONWh2U1FR?=
 =?utf-8?B?SnpDNUl0RU1BSDR4akh4Y2M5dk81OFFzSFBuQ3NDV0NWUFhPWHlpSmFCcEZR?=
 =?utf-8?B?T2grRVVsSXpVV1FDVGFxTFhxQXZOZDdjSjNkU2VKTXR4NlZDZnF4WEgrS083?=
 =?utf-8?B?RTJEUG9kRnR0UzdSNFVMOC81QzM1ZlIxeDFWVWpRYURpdGM0Tkl4dDdETm5Z?=
 =?utf-8?B?YW52YnVMcVpsYWl1aHdQWFpCRnE3TC8yNHdxZk1NMEdxcCtKZUpiYUQzNjBJ?=
 =?utf-8?B?L1BoTzJ3bTk4dng2MWIyVmdPTjNyRVhrd2tQVWpBaTkzcDR1MnBjYUlJNUZ1?=
 =?utf-8?B?NnlIQUw2VEt5WW50d0cyTXZaWmNlczl2NllTQklrVXdiUXRMNWQzS1Q3VjVp?=
 =?utf-8?B?SURObDJ1U0N6RnE0enpGQWYwVys4NEZLdCsreWRIOFI0T1VLZEhlVDBDeGZ0?=
 =?utf-8?B?VVR1Qk9QTG1ZVjVLaWhSL283MkxoWEpMN0IzdWF5SnpGWjRDaDA3Z1NaaUo0?=
 =?utf-8?B?NzlQZk16WHcva3NlSnU1dlhXdGVzcDd5cGx3NkU3MGRFOUFvSWJDd0s1OHI4?=
 =?utf-8?B?Q0FiSTJoYWZnVCtHOXhPSXlnTzdsMTF0R0djYTVlVEFqZ1BrbUh0ekZnSHFr?=
 =?utf-8?B?azlTUGZJMUU3eGQ3VkpzRXZLVkttNlR0d1R0a2NpMjF6Y1E2TXoraDFSWFFB?=
 =?utf-8?B?OFFaVjFTTVFiQmdvalFkWXJpQmlHU3F2U0pUZnVqNXhUMGE0a2c0Z0tUWUdH?=
 =?utf-8?B?bExXb2ZCb1VvNDVNeDVucmFlZllzYmVsT1VsL1RmdjJHeERiSmYvNXhQaGVY?=
 =?utf-8?B?bk1TTHdEZk9yVkdBUnpLREhwT0t6WE5NYkttSDV4WUoyUTIvUEJ4cmg2WmxD?=
 =?utf-8?B?R3c5S0FERDgyOEM1U1dhb1VQWXBNMFh2dUNRbXFqMDgzNXk3QTJXUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3af2235-30de-41a0-7fe0-08def6a7778c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 06:20:26.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NrwO7wgxTr0Iyvfz44zOTBtB4sxYhCpzoF1q9GZbzst7lHsCPkRdeTN+92Ujn0gH16i+dRHB90JuoxAx2+H1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8952



On 8/8/2026 6:18 AM, Andrii Nakryiko wrote:
> On Wed, Aug 5, 2026 at 9:21 PM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>
>> Currently, during BPF object loading, load_module_btfs() unconditionally
>> iterates over all loaded kernel modules and loads their BTFs. This
>> introduces unnecessary overhead when a BPF program only needs a specific,
>> small subset of modules. In environments with hundreds of modules,
>> loading all module measurably increases the loading time.
>>
>> This series introduces a ".kmod_btfs" ELF section, allowing BPF programs
>> to declare the modules that need BTF loading. libbpf parses this
>> section, collects the module names, and skips loading BTFs for any
>> module not in the list, thereby reducing overhead. It also stops the
>> iteration early once all declared modules are found.
>>
>> Usage example:
>>
>>   DEFINE_KMOD_BTFS(_needed_kmods) = { "bpf_testmod" };
>>
>> Performance impact (<skel>__open_and_load() time):
>>
>>   Modules loaded | Without .kmod_btfs | With .kmod_btfs | Speedup
>>   ---------------|--------------------|-----------------|--------
>>   1              | 35.0 ms            | 35.0 ms         | Baseline
>>   10             | 36.5 ms            | 35.1 ms         | +3.8%
>>   100            | 46.2 ms            | 35.9 ms         | +22.3%
>>   300            | 65.2 ms            | 38.0 ms         | +41.7%
> 
> First, is 30ms start up overhead really such a big deal when it comes
> to one-time thing that sets up a bunch of BPF programs? Can you
> elaborate on the use case you have that actually is harmed by this
> libbpf behavior?
> 

Hi Andrii,

Thanks for the feedback, and sorry for the delayed response.

To clarify the use case, we use `sched_ext` on Android mobile platforms
and dynamically switch schedulers for performance-sensitive scenarios,
such as gaming workloads. The BPF programs are loaded on demand when a
scheduler switch is required, rather than being initialized once during
system startup. Since the scheduler switch happens on the critical path
of user interaction, the setup latency directly affects the perceived
responsiveness of the system.

On Android devices, the impact of `load_module_btfs()` is even more
pronounced in our use case. In our testing, loading BTFs for all modules
takes more than 300 ms (with 93 module BTFs), which accounts for around
69% of the total BPF loading time. Such a delay during the scheduler
transition can cause visible frame drops in latency-sensitive workloads.

We also tried preloading the BPF programs. However, this does not fit
well with our use case. Mobile devices have tighter memory constraints,
and we avoid keeping unused BPF programs resident when they are not
needed. Since different workloads may require different schedulers,
preloading all possible BPF programs would introduce unnecessary memory
overhead.

By allowing a BPF program to explicitly declare the required kernel
modules through `.kmod_btfs`, libbpf can avoid loading unrelated module
BTFs and significantly reduce the loading latency without increasing the
memory footprint of inactive features.

Hope this clarifies the motivation behind this change. Thanks again for
the feedback.

Best regards,
Fuyu

>>
>> Fuyu Zhao (2):
>>   libbpf: support selective kernel module BTF loading via .kmod_btfs
>>     section
>>   selftests/bpf: add tests for selective kmod BTF loading
>>
>>  tools/lib/bpf/bpf_helpers.h                   |  14 +++
>>  tools/lib/bpf/libbpf.c                        | 112 ++++++++++++++++++
>>  .../selftests/bpf/prog_tests/kmod_btfs.c      |  47 ++++++++
>>  tools/testing/selftests/bpf/progs/kmod_btfs.c |  14 +++
>>  .../selftests/bpf/progs/kmod_btfs_mix.c       |  15 +++
>>  .../selftests/bpf/progs/kmod_btfs_nonexist.c  |  17 +++
>>  6 files changed, 219 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c
>>
>> --
>> 2.34.1
>>
>>

