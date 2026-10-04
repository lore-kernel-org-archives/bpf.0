Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022125.outbound.protection.outlook.com [52.101.101.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2DB38AC75;
	Sun,  4 Oct 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118182; cv=fail; b=L7xXxq4qGz7wahXKaA9wubTGNYZzpo8ed3/raelmsZrp/VliBUYqRa3lQA1OpL/l0kSr/KEkwo69WMA/8GZhaNm2rsNKdDuagpYXPonrNjrC0S/hncFkHpZddJE+k6WdpCo5zRGEOK5zn6w2g5SwP2eober1Oup3lhQ1cQMZpIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118182; c=relaxed/simple;
	bh=/MxzpFaeOs3PSt2rr4DjmpQydVbR9sriXGneVvctdnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IPjXJz44P+u6QBBeAYMDmKELQiO6UBAE1L8n/TNtX/QxCjvZiL39Lo8iIpif9sWG1BF2JUrVMULdymNlwPHleDqqB//YfazTOND25IHIGHR5sgIUHmVgFnz49i6KPylWfFXwiV096e4a4XzMpiJPztTPZ2J0LI8R7RmnlyCj/xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qX93kueeH/3pvQoeWKseqetjw7evzyURfK6glC1u0sV0rAcW9uI+JNZI8sGmcWfaLJvkbXbUYDInUNdOHGNaBVLbhERtsgG4rzbTX0Y6CuNrftyMJz0u5uKb4XFu/txwa7Tr/UJNaDno0QPvKZ17Gm3OQLiCvId66FbBuN2G1YWb8SezKDeKC1y1dd0G9Ox27JPXzmpSgRYhogg+xdPdi1QmNdVT2SmRk2Gcobw8fEODKbBZut403Y3EavKl81HMai1FEKQC/tODo35RaO9/1fJ/H4m2OG1Z4SDqWarlxTrBvmwKCVgJFFfflD1AzkNkICgSJDWvMWBoIsKoTeAvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=kTgEC1BFhVNK6joMSZBXKnut/IsvXhYXxlOCBiJQ0/g=;
 b=Ns6Xl7H5/rwOTLzR//02vbTjeV8Dm+A93pMMXyq5UzOnTubEvoWzsQKPTRhzlUPKFn0z20zC0XYCZ8YArmX+MURHkq87b+xNgd+JY7aoMyBgTG548koUEzAKaJubyDIHJ+8nwuAAMwfc+M9MlYH738T40e1wLJjj1pQ2sQET+WN7GfmM767miEY2/zzRgpPQZ4FxMSg3AXUfJDQDcdlCSWqJXQj05cSYzKp0iPSkijzuK/FqricbPIfVOwhLMBcDTfcn5kP0e49S6N1YO5qb0eG/j/CKVEZLOIaqeYfXzo3l7yXNNtMVAL6QxvEQBGDc38YjouR0nxF9ae/Cv7MPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB4009.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:183::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:49:37 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:49:36 +0000
Date: Sun, 4 Oct 2026 08:49:34 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Add stubs.c for CONFIG_MODULES=n
 module_put_and_kthread_exit()
Message-ID: <6kffereanrivmycrw6nnrks2sect26i5mnrdq2un7lvpurk5ap@kybf7dhhr6by>
References: <20261002-module-stubs-v2-1-a0d8c6ad1738@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002-module-stubs-v2-1-a0d8c6ad1738@suse.com>
X-ClientProxiedBy: VIUP296CA0063.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB4009:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8108ed-bb35-4de1-1644-08df2215f25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|5023799004|6133799003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	zusiqtbucAja4GtrvSg0yww4e1nARDNnY7cVFNV3VR+cntIszxgcaH/v3p9NSWJxh57z8Ds7b0UpqDWVlBKcjH3SCyM5deRwZdq5PuliExYBBn5UPojLZJXLjBrngAKJiZzwf6EohviAQbzFG7bDZj0UXdp0YcMd0Y3yLI+bFf9FPGlqQkQDgWJgQAkuym3SyhWfdxP22ZPit6Lbs45QkN7lqFpwsp/r7EbYf9G5gc/Ft2lL7U1CNetMOPu6Y1YxJEZhCUAlJMhlTynbeZynXVwkAxU93d9vqL8sNbnJc3jB/5RIGPmwOQjBQCT7PnTg/XNWtzu6gacr3c7LgI6tpXvQExUK8KhJz2ED1AjcdjhxA5RkOi99fbabErNJL6imWMnzvEyLSv96I6RcAU1orlHpVD1/zY054ml5Pnzkh08u2FifLqkyvjkayYX6V6VUh/MMhj3OgVZNQl1/VsgtOxlQWDPVANzFj5WSLOVgLic/2BGguf4r6t4OFnpm64m6BPpMz9DKKDjQ7aO72IvusxbdkqFvAbVBuvhDfsDSoysiD0jEr7Azocv+V9OowwoVV6qReuWq7n7zGOu920jss9JSYsmhDSFjKwog4a2/Eac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(5023799004)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjdIc1IvUURHQTBuVWE4MmxtOFJFQm5Pb25BeFhFQklWNmg3QzM2ZldEMDJo?=
 =?utf-8?B?akJ2Tlo5NzJTUHlCdWcrTzRPeGxOSkV5bmlmQnNBQTN6WWUrUW13UUtkcGlk?=
 =?utf-8?B?K0EveTRRdDdvK0MreEFudXVTWXV1Yityc0FpdkVUTHRsN3dRbkdPTW5VaVhL?=
 =?utf-8?B?WHRFeEdiZWNTWDd2bEJ6RXZ4NU1hT1lOTkMrL0s4SVJISXRxaFNvblp5K0RU?=
 =?utf-8?B?b2xKOWxaTlYxOSs3STdBNGlrUWJCd1pBZ05nRnJ6bmc4UnVCc1NlbFdWS05w?=
 =?utf-8?B?SWJ3VWl6OHlMWTJLT2dXYzgycGtkV3pncitNdmV3VE9GbWhvMkEvREFuZXc0?=
 =?utf-8?B?YlhjbzFITm51TlQ2N01XVXlqdGZMUFdrV014Rm9RaEdYR3JuaThjcXhzZEdp?=
 =?utf-8?B?Q0lHS1I2RERMRmhXUHVVVFJHcmJGK3AxZUxNbTlDSE5qQWN3VGRNOHZTVDA1?=
 =?utf-8?B?b1FGdGdaVWhWWDJEZWdzMHRXTE0wWTM0eDNLYWIyV1gzbXpTMzRVYUliaXIr?=
 =?utf-8?B?eEh6Zm9oT1VvVVQrQUtTQThrbDJSUkFCdHpxOExHZk0rWEtueTE4OG4rSVM3?=
 =?utf-8?B?QmczOVVGcmRhMGt5OWdna2NRSlhUU25pVkYrYVM1dm8rREh4czFKejFiZnRo?=
 =?utf-8?B?QlMyMjZFTFhjUEZ5ZVNGVDgyUGNZb3NCbFBpR1VobzJOdzlldGpZRDE5RlN0?=
 =?utf-8?B?bzdEYXNORVZsY0NLV0JTS1VpUWpsS1NxbEZHMGJtZEw3KzFhZFBWNS83QXJG?=
 =?utf-8?B?L0pOV0l6dTNkS2JPdlZGZ0tUTzdDc1JXMnBldnNja3A4ZXVOQ01mbmJYT0lR?=
 =?utf-8?B?Y3F6dXdCQzg1VUl3OE5yV05vdXhoY1ROdjVSeElTZUduMGIvVW1xWE8rZHpm?=
 =?utf-8?B?djFHWEQ2dFUzejg1cksvSWp2aCs0SEF3RVprZklRZWRHeERhRVh0a1hXbkZM?=
 =?utf-8?B?RXErdkRudHZJUHVyZUlVdkxhWjBQYWRETzlwOFl3TTZTcnVLWlpiY2tiRFd6?=
 =?utf-8?B?TG5MWW9YSkN5WitHQzRSQTI4NmwvT0dlaEJjQnhCQW5qYmRtYzBjYzFPaGpw?=
 =?utf-8?B?cGtKNGN1VnJlNXpudy9sTitkZE5Oc1k3YXkrenV4Z1ZKbEJtY3hNSDlpZWFW?=
 =?utf-8?B?TUhJbFVCTTFidFhqbExwcFNXTlMwbUJrMW5sempCd2hnbFJjQU5CZEt3S0xs?=
 =?utf-8?B?Qnpaa1B0a0JkNVExKzdKVkZXQjBJN0dHbnFSK0hiNW1YY2pvcStFc2lrMnQ0?=
 =?utf-8?B?MytXcGRIaE55NkJ2RVJmZW5iNE9tSFdZR1lnWXYyN0JmUXlHY1diaTVIUTdW?=
 =?utf-8?B?ckRoSm51aG5wU1prNmtKQnp2WEhsTWxXYlhBQmNPODhJUWsvWTViZVpDdEJT?=
 =?utf-8?B?L01oODZNcWUzQUtHM25GaVFzajUyU2RiUnB3K0UybCswcjhMc1dobzFFblRD?=
 =?utf-8?B?SmFmWi8yNEVOdjlxQmNlbkR3dnVaT2N4dWFBY05EcGQ3cWQ1Ry9zZk5HY1Nz?=
 =?utf-8?B?YUgrTmRoSGF6a0cvVlB1RGpDVU1JaDAweStHQWZRYTRRYVZjbFZPYjRkUWRl?=
 =?utf-8?B?ODBoMTEzRUFoWkc2MXgvdmY5NGhTRi8vZGFRWWJSdDNGa0ZKTzZ6cEJVZi9X?=
 =?utf-8?B?QkUySmp1QWxwOU9CL3p0S3dNalNld2o1cnZ6aEtNU2tINTBqbURiYmR5bzdk?=
 =?utf-8?B?dTJWRGJHdUJNcnVLYWxrQXN5MUZpSzVQcUgzL2xMcGdmRmc5d09BWVRub0Z5?=
 =?utf-8?B?Z2lHSG9rdENGVjJtN29iOUhwdzNxenZQVElmTlhWRWpWQ0JvUmlpMld6ankz?=
 =?utf-8?B?UE1yNGordkdCUXRvbUtib1UzUUorUjNLSGlHZkgxbW8rSERCa1ZWSjJFdHpx?=
 =?utf-8?B?Y2ZLTGgrUkZtSlI0K2xqN1kveTdWelZWbkFwTVl5blpGdDNIN0IvSFNYWU9N?=
 =?utf-8?B?djIxNVVaQXNtUXBjZXB6NTIzU3IxekRkNW1GRURjT0dIOHducm56WUlxVnd0?=
 =?utf-8?B?Ky9NNUhjaXZOb3AzL2xEb0xoMndPVGo3ZkhKSG1mNWlVWFg5ZFUwaEtRSEpD?=
 =?utf-8?B?Z0NIRnUxY05JSUYvMUVFUUlWanN0Z1BFay94Z1hTckFDbWNqZDZFNVBaeGFq?=
 =?utf-8?B?Y0x1dWxzVzJXbXpDb3pJQmIxaWJTOVdUV1BtRUFqRFJ3N1JvQ3M3cE9pdTNp?=
 =?utf-8?B?WGtxODM0V1cxOWN4NmRRV3NFbjZqYlJ5NWc4aVgxUzZ4Ykk5d0lwZDJjdVpp?=
 =?utf-8?B?aVpkeHJONy9sSUcvcTdBT0VXTW5DWUZHL0M2R3FpNTZSak1xbEVTMmh1d3k1?=
 =?utf-8?B?VFJhU0VFNU9tc0I2ZWtkemE5REpjTDk4aTNwcytzTFFDS3BOVW9Gdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8108ed-bb35-4de1-1644-08df2215f25b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:49:36.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTp2IJPEGa5CZPZvF1/PR+jYV6iKMHwwU9V2hAiXr46eSqJuW7bobfaqNn38yeQd1FOsNCDj3oOHK+g9Zlvkxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4009

On Fri, Oct 02, 2026 at 10:40:38AM +0200, Petr Pavlu wrote:
> Module-related stubs for CONFIG_MODULES=n can normally live in
> linux/module.h. This works well when the stub does nothing or simply
> returns a constant. However, some non-module implementations may be more
> expensive, either because they have a real implementation or because they
> require additional dependencies to be pulled into linux/module.h. This
> header appears in roughly 15k #include directives across the kernel, so it
> should avoid bringing in unnecessary definitions.
> 
> Specifically, linux/module.h defines module_put_and_kthread_exit() as an
> alias for kthread_exit() when CONFIG_MODULES=n. That in turn requires
> linux/kthread.h, even though linux/module.h otherwise has no need for it.
> Note that linux/module.h currently doesn't include linux/kthread.h and
> requires its users to pick it up through other paths, which is itself not
> quite right.
> 
> Introduce kernel/module/stubs.c to hold such stubs, built only for
> CONFIG_MODULES=n. This mirrors kernel/time/posix-stubs.c, which is used for
> CONFIG_POSIX_TIMERS=n.
> 
> Define module_put_and_kthread_exit() in both CONFIG_MODULES configurations
> to call __module_put_and_kthread_exit() and add a CONFIG_MODULES=n
> implementation of that function to kernel/module/stubs.c. Since
> __module_put_and_kthread_exit() is now implemented even when
> CONFIG_MODULES=n, remove the corresponding '#ifdef CONFIG_MODULES' from the
> noreturn_deny BPF list.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
> kernel/module/stubs.c should also be used for add_taint_module() [1] in the
> future.
> 
> [1] https://lore.kernel.org/linux-modules/a79a6a06-cc48-4036-882d-95e9b4cc01cf@suse.com/
> ---
> Changes in v2:
> - Remove the unnecessary include of internal.h in stubs.c.
> - Remove the unnecessary EXPORT_SYMBOL(__module_put_and_kthread_exit) in
>   stubs.c.
> - Link to v1: https://patch.msgid.link/20260922-module-stubs-v1-1-abe465a24879@suse.com
> ---
>  include/linux/module.h | 9 +++------
>  kernel/Makefile        | 2 +-
>  kernel/bpf/verifier.c  | 2 --
>  kernel/module/Makefile | 4 ++++
>  kernel/module/main.c   | 1 +
>  kernel/module/stubs.c  | 9 +++++++++
>  6 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea..4c7bd7f9f889 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -658,10 +658,6 @@ static inline bool within_module(unsigned long addr, const struct module *mod)
>  /* Search for module by name: must be in a RCU critical section. */
>  struct module *find_module(const char *name);
>  
> -extern void __noreturn __module_put_and_kthread_exit(struct module *mod,
> -			long code);
> -#define module_put_and_kthread_exit(code) __module_put_and_kthread_exit(THIS_MODULE, code)
> -
>  #ifdef CONFIG_MODULE_UNLOAD
>  int module_refcount(struct module *mod);
>  void __symbol_put(const char *symbol);
> @@ -850,8 +846,6 @@ static inline int unregister_module_notifier(struct notifier_block *nb)
>  	return 0;
>  }
>  
> -#define module_put_and_kthread_exit(code) kthread_exit(code)
> -
>  static inline void print_modules(void)
>  {
>  }
> @@ -879,6 +873,9 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
>  }
>  #endif /* CONFIG_MODULES */
>  
> +void __noreturn __module_put_and_kthread_exit(struct module *mod, long code);
> +#define module_put_and_kthread_exit(code) __module_put_and_kthread_exit(THIS_MODULE, code)
> +
>  #ifdef CONFIG_SYSFS
>  extern struct kset *module_kset;
>  extern const struct kobj_type module_ktype;
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 1e1a31673577..08a94594975d 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -58,7 +58,7 @@ obj-y += liveupdate/
>  obj-y += dma/
>  obj-y += entry/
>  obj-y += unwind/
> -obj-$(CONFIG_MODULES) += module/
> +obj-y += module/
>  
>  obj-$(CONFIG_KCMP) += kcmp.o
>  obj-$(CONFIG_FREEZER) += freezer.o
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 72a3f5998dd2..be70f10e4968 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20417,9 +20417,7 @@ BTF_ID(func, __ia32_sys_exit_group)
>  BTF_ID(func, __kunit_abort)
>  BTF_ID(func, kunit_try_catch_throw)
>  #endif
> -#ifdef CONFIG_MODULES
>  BTF_ID(func, __module_put_and_kthread_exit)
> -#endif
>  #ifdef CONFIG_X86_64
>  BTF_ID(func, __x64_sys_exit)
>  BTF_ID(func, __x64_sys_exit_group)
> diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> index 50ffcc413b54..72fd2972eacf 100644
> --- a/kernel/module/Makefile
> +++ b/kernel/module/Makefile
> @@ -7,6 +7,7 @@
>  # and produce insane amounts of uninteresting coverage.
>  KCOV_INSTRUMENT_main.o := n
>  
> +ifeq ($(CONFIG_MODULES),y)
>  obj-y += main.o
>  obj-y += strict_rwx.o
>  obj-y += kmod.o
> @@ -23,3 +24,6 @@ obj-$(CONFIG_KGDB_KDB) += kdb.o
>  obj-$(CONFIG_MODVERSIONS) += version.o
>  obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
>  obj-$(CONFIG_MODULE_STATS) += stats.o
> +else
> +obj-y += stubs.o
> +endif
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad0..a8bf803afa81 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -60,6 +60,7 @@
>  #include <linux/codetag.h>
>  #include <linux/debugfs.h>
>  #include <linux/execmem.h>
> +#include <linux/kthread.h>
>  #include <uapi/linux/module.h>
>  #include "internal.h"
>  
> diff --git a/kernel/module/stubs.c b/kernel/module/stubs.c
> new file mode 100644
> index 000000000000..1385c87e8169
> --- /dev/null
> +++ b/kernel/module/stubs.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/kthread.h>
> +#include <linux/module.h>
> +
> +void __noreturn __module_put_and_kthread_exit(struct module *mod, long code)
> +{
> +	kthread_exit(code);
> +}
> 
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> change-id: 20260918-module-stubs-dccefe41dace

Hi Petr,

I noticed your response to Sashiko [1].

I agree. Marking the stub function with "__used __retain" in
kernel/module/stubs.c (e.g. as per "#define __bpf_kfunc __used __retain
__noclone noinline") should be sufficient. Thank you.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

[1]: https://lore.kernel.org/sashiko-reviews/c166a29c-14f4-44ee-81ac-d79c82175fc8@suse.com/

Kind regards,
-- 
Aaron Tomlin
