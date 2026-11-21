Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795255283;
	b=jHd3gMTIRxkQxuvt6hP1ET7BZ/5PkNBRHDc86zzZrRTW05A7Swxtn09qJPJfnk3OYqxh
	 P4V8Hhtj8dKbs9BMIM50vjEBlZYuzJ24PY5iZbyskFNWVRM+9zJ+s8PSzYcQHtuRXmFVI
	 upD65I45Eaw77cEWthLD71TJ8s9tT5s6UWMvfwvE6/k1fSDTFM5F8C3NuLGX44BhcagWn
	 edfvjJgjHfVCci9h2VIt5GogizcWkLaU9StcAM61p9t1tluEa92iB5O33WyTRmhLRSKFq
	 9tjLZH481DaMnhk/9YVPMEgz05Z7cnNJct6WUwSow+b2N/5eai818aFn+AsLkO7JmAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795255283;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=G5nkqCVQtReqjS5t45sOCeMTqjAaM3Ilj5KAbycGLtY=;
	b=4Q6WYyCJrEl9CTOhKtUvAXHPS+5GV3rDLJCprPIYFYryVLBp0uzFwvzdv6+0pWUNDXaX
	 PXSa2WjFzs9DL78dX4Jui2Y9a5knW9eD858h98PUrrP42I2d5TJuAb6r3044TdWTjlhdP
	 QomNqZOKrQW+cMzTLewBIMaiYWo1psKIhIRNrOeH4PT/F9dwKbZZmEknDXDV9EWTgZlHC
	 RAYpNctEZWR7pSa5LD8Bi+U20e33y4VXq+LGq5kt1m0tZwfsDgu4rUSc7oY0n/LuRHn8s
	 m2i3SydXrGFRvziJ4SnegkBTUj6vD7Ijy4fz+uJVtogvitBhWVYioyCoeFtLzRSKrXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IlBleaor;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.67
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C18606A325;
	Sat, 21 Nov 2026 10:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C18606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IlBleaor
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzaHX9W9Qq6Hv6xVipcUvFzIMmp0AZcMq4tq7ubsSquPXl/HTpXKNtbpLuE/iFx5atrxOb1yUuaDNnrSnBWa/3yewMljtrVZ+VwKxzbJnRcsGiD79S/RIrRakFhzkOQ3i0R0Evs5b/ZOVnShYfTGIxce6Pgh+Uo0ag47+DGp0wcYF4WscEOaTlq/Nay+VS25l30aageFbTie+7ZI6bel40xHcE0tNZM7CrgL3+WWeS9QyoDrojxQ+BNixgdmjjNRf2EH+5rKiNeiBr77U9ZZ67VVL4yGhGbvEgaHagt1Zzd/PXtIaKhvHTAqzdalFEjY+EamfJ5Ci8EwbOoAE7kqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5nkqCVQtReqjS5t45sOCeMTqjAaM3Ilj5KAbycGLtY=;
 b=DFZznlISmgl6wVlYRedRlju11W2M646AfHm+ctkvVL78QI1l9RE6870DzQAdf8SdYa+LT+3psnR9yXtaHXvrwnG/Ip+cCb8XAiMIJxcp+2hoJWHlIueqoGvkuAchiMZZk3D+om0c1ASzKRtXYLVpA4zTJM5a/dMo34mRybewDyikkXY6dPNxvH51yxr9MiVvjtwy/FFmhy14qC0V4TtRpKTF8h3eGzpJOiakD37dU8h4nVVMQWAzG80Yoebha6FB/sHQpPYl1AeGv7L+pPlXSI+zUVkE7YiqUJbo8YXRYw4oYBrzTDuGHg6R/axjWvCEcuk6/PDUJh7SpKkDyNDTJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5nkqCVQtReqjS5t45sOCeMTqjAaM3Ilj5KAbycGLtY=;
 b=IlBleaorFWd8ULu8uOzC0VgxWX1ZEZ1ZPruCizaMEVtebS5fnqQoSYzFZ59GWLkLO8kmUiEuddGzmQAyKG9aw55OaBZ4kVOw6H1W0u1hgcc2n/ehZnO2POCdKxbkuXAKtY3rozK7MNMjunqlxDoRa0dTx3Y1kKRdeHOCrqMGWjienOg951PVttla4wXbHl6qJOEVRtaZyV7i9B7/ecuDlNeY56R1feZSe9IkXCDKJxV5BCTaGPwy8/77TNybfsQzQZOi+6r77j7Tsj1GG3iw3qzYogWMa7VXyVi4Cf7QM/2CrvAAO/AqD46zdLtc38cTMLlvJA6i9PdtN+FE8BX6Ag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA0PPFDDA81179A.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Sat, 21 Nov
 2026 10:01:17 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.012; Sat, 21 Nov 2026
 10:01:16 +0000
Date: Sat, 21 Nov 2026 11:01:01 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, Xu Kuohai <xukuohai@huawei.com>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	David Vernet <void@manifault.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Werner <awerner32@gmail.com>,
	Zvi Effron <zeffron@riotgames.com>,
	Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next v3 4/8] libbpf: ringbuf: Add a caller-owned
 iterator
Message-ID: <awFr3R3DPS_so3Pp@gpd4>
References: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org>
 <20261120-bpf-ringbuf-fixes-v3-4-ff7ca15d6c37@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-bpf-ringbuf-fixes-v3-4-ff7ca15d6c37@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA0.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44f) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|IA0PPFDDA81179A:EE_
X-MS-Office365-Filtering-Correlation-Id: 80db284e-07e7-484d-5dbe-08df47b66186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|4143699003|22082099003|11063799006|18002099003|10067099003|6133799003|261022113327099003|261026130827099003|261009223027099003|261022115727099003|261028144727099003|261022105027099003|261021123027099003|261102130727099003|261021130227099003|261021135927099003|261102123227099003|261026140227099003|261022075727099003|261021121427099003|3023799007|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	RySSSLkpZSw8TPAnex8DP2t1WV4I6tY8ha8Q4wtwZLfkSNONiwtXOVFVgerxrr8tKAG9GV7NrOj1+VWX5rtsE92jUPmLVyT2lpx4VG2TpIDL050KrTwvhQjEMXLx8spT5iJwhNJ984DJQIlzjf/pjLOys7CrLuxTAvQLv8xyTB1foA/yDYIWXyon46cOgrIaYtSgFhICwuOUw7PR+Sy3mYR73rEdQ3YXoCB2p0XNgZKCpXRkVWct4fBLZxPCB23NfG5DkPTMgqZJ7dbM3opKUPDyNS3heLEn/3DlxH014Ktf9x16lIxtQMAW7qmJkUKYZupZ7JvT5AJ0/MngOwHPdcYk59f1lqrbODJzqForc2fwuT57yNFK2JUYQhkS4w+9kUaGyF6voLlUI9w9N7L4GeDbz2/mvmn65f9t1yQKSKfijCeXk6ZyeRCfavxHjvebd15avWZbtl+sp8S5bhT7flnS3P2HOALyienJgrB/LgdRLSH2YyBIZXZTh7YzG8ld7R1ogcSxJ4YRIylgF4Hs/mSLdPl6cMPNoRWAOGwaWxYFKxYwOESjUeDEUfh/BjW/eBUdGKnKiLh+HrusQxMVzr8W0Nf3QhmGbDRbj+DUp72xEOerYBdrfhvbvT44ycGDzUO5kGiARBbUd66lQJiyLZjOZTpgtsBvT+R/NqIDGuA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(4143699003)(22082099003)(11063799006)(18002099003)(10067099003)(6133799003)(261022113327099003)(261026130827099003)(261009223027099003)(261022115727099003)(261028144727099003)(261022105027099003)(261021123027099003)(261102130727099003)(261021130227099003)(261021135927099003)(261102123227099003)(261026140227099003)(261022075727099003)(261021121427099003)(3023799007)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gLHzcCDgSLTASEfdzyzVho8YvJte5IwbA0NkZxdIRGmyWjRvP35lZPgVdsfa?=
 =?us-ascii?Q?ZpvvkZAI2gWdXvPCOp4P/xizvCXD0cCCFtSqASyaG+8kVPF9qu+uFnzSk6lH?=
 =?us-ascii?Q?zhUCizms00Ili7Ng2hapsy87Tu9q9716VHYqtRDeisSGQHEuvRrAHcBdhyua?=
 =?us-ascii?Q?Iy03X0GMbtPckKWqFxpgnO/HrIzRHGEMSyCbo4BisARrZzXWCdA3OirV7+NG?=
 =?us-ascii?Q?tLXrLNZtq/8Wj6C++b1Zdui/0Rri2c65Bbceao5DtS8+N+0+cdBSgl3aZF7r?=
 =?us-ascii?Q?fmDM3h1RKQmuiahQ4SwUdWZufcwy6f/Fm/vMNc9N40ej+ER0pbK16KOMNGSS?=
 =?us-ascii?Q?XhesBydnGH+Juy1AmFwy/6yB3Y00nvVrOIY3ugxSnq0/LOhGun46O1go2r7G?=
 =?us-ascii?Q?TZwdTGxiaYfL/fCmV112ySE8Tgz2bvMAsvVYgKxi2PuipQq/9r+0aHN/4yaL?=
 =?us-ascii?Q?UUKfXIZBcg20LvQsrnlsiVLr7pivDShaU/60UKQ1b6T7N7LJ836ZvId5DVGi?=
 =?us-ascii?Q?cDLNZ3pqgTIs9kNjm+QNwRFzRX105h3crsAUcQQep/Aa+iOkcOQYssdz9LvC?=
 =?us-ascii?Q?vUQfwGjBPNdViAVe1i5EtHD2iMKTPh6Vdhhwu3oParbNoYTJzWM4trrnqq01?=
 =?us-ascii?Q?Y1K3SNrYUFWPbT5Pzr/25pKjpGHsQ8A7be9B3GG3oe7oxJ+ORL1Czst6qiGX?=
 =?us-ascii?Q?q9RZib3mIJhNwPFOfBVK0emEqGORhDJ5hj0XsBVj6+kD7TkezVjfbMWCGS6v?=
 =?us-ascii?Q?VVOh5w3ipCxnl7ZYVe64rxla/nKbfxx6e2PgXKZ29VAS5BQ3JLFRFr3QwjHB?=
 =?us-ascii?Q?vpb5lqgNvGuM1yoXmE8VrzngjKxxk3VzwMftPl8rn8CBd7wkwtlM6RgXjTUh?=
 =?us-ascii?Q?uUolrzJwkA5qnAgzqApQfm3QHkiOu/JfaH4b+1gAiZV9u7jl279xPMyObvGI?=
 =?us-ascii?Q?RkEPHCQrzYMuLqBaneVWXy0KZwmJw8PiZhjL3LQN4VhvxsdyxP3mqE93BqgL?=
 =?us-ascii?Q?iaFmsRaHzsLRi6MSLtJe2wmU0YqXu8/rlCKNERlF7Rio8ZSTtqnYQK7A+CUS?=
 =?us-ascii?Q?mknQm1z/XVU2iATKCDHZOdsMZR/by8YjYxEb6xwLgq0PGhe+oMsqCXMK7/qD?=
 =?us-ascii?Q?xaBRte06J74sZ0mP+l/R4kxEOpkbpiBqu0TkaJP3Veeq0EQi7kIqjct7iiGG?=
 =?us-ascii?Q?XLlRhWFboLdaKGkU9+pzALJVlaBYF9kfmqm2TbHZENz673Ovy8p348O0XhLz?=
 =?us-ascii?Q?HGur/2vZcz6hpUt8OQlcROJzkpDMp4rhMNWRJs5aHgUcVq4SNsf6q6zW2oaT?=
 =?us-ascii?Q?jzASFsVfOUbxR5IghnFmrJg2Zk5qWWy9Q0ZAgZeOdWBsTeg41KIzl+4fO7n8?=
 =?us-ascii?Q?mL18poRXsZDpIbE+FGGmm1+OtZspdoVLGPo7P2Jl/AD46LEyMTFGHw3jm66X?=
 =?us-ascii?Q?8ZXdcfaCj4o5AeJnaYrax4FRbRtkzxvCyjbSCVIET0xmXqlIm1UY+JxYA5zG?=
 =?us-ascii?Q?qbVbVhmVMHz6drWx0Ncg0WWrQTtUXm1It0Xbi5iJpJ1SL6O4DgNMidK9jtoI?=
 =?us-ascii?Q?XJ0OnMpEb3e6h6D8SxxbiaXZtbr8j4x0tSQbzTHMxEe0pWlnnkqXMhZaUBUh?=
 =?us-ascii?Q?MH9QecFI1F53CP18na84iuCstLVnCyyqxAwI0J/4Cb9uQiSMB4o1S45YXTFj?=
 =?us-ascii?Q?27/xV95y/mIbv8VMfJMseOEFF1QRPu7w6WGRLeSKrAV0xyNwU2km3j798Qu2?=
 =?us-ascii?Q?YCvn+KK7bw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80db284e-07e7-484d-5dbe-08df47b66186
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 10:01:16.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bctg3joLOsDRu7IdrQ1IIuksbmiSh7a33d6PT0VjTACwHC7v+PBkzcFkt2njm2MxJ2Wv7hkkMLoFdfvSJrcOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDDA81179A

Hi Tamir,

On Fri, Nov 20, 2026 at 03:33:17PM -0500, Tamir Duberstein wrote:
> Ring buffer records are exposed only through callbacks. Callers that
> need to stop at an operation-specific condition have no non-error way to
> end consumption early.
> 
> Add a caller-owned iterator that returns borrowed records one at a time.
> Each next call ends the borrow and can publish consumed records before
> inspecting another one, allowing callers to batch consumer updates.
> Implement callback consumption on the same internal iterator core so
> both paths share the record traversal and publication protocol. Allow
> iterator-only rings to omit the setup callback.
> 
> Preserve callback validation, so callback-based consumption of an
> iterator-only ring still returns -EINVAL. Keep the consumer-publication
> barrier on early destruction, including bounded and callback-error
> returns.
> 
> Keep overwrite maps out of the public iterator; handling a stale
> consumer position requires a separate resynchronization protocol.
> Require iterator users to observe exhaustion before waiting for another
> readiness notification.
> 
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
>  tools/lib/bpf/libbpf.h   |  67 ++++++++++++++++++
>  tools/lib/bpf/libbpf.map |   3 +
>  tools/lib/bpf/ringbuf.c  | 172 +++++++++++++++++++++++++++++++++++++----------
>  3 files changed, 207 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 856650d58578..cc9e141ffd0a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1541,6 +1541,11 @@ struct ring_buffer;
>  struct ring;
>  struct user_ring_buffer;
>  
> +/* Opaque caller-owned iterator state. */
> +struct ring_buffer_iter {
> +	__u64 __opaque[8];
> +};
> +
>  /* Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps. */
>  /*
>   * A negative return stops consumption; non-negative values continue. Stopping
> @@ -1594,6 +1599,68 @@ LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
>  LIBBPF_API struct ring *ring_buffer__ring(struct ring_buffer *rb,
>  					  unsigned int idx);
>  
> +/**
> + * @brief **ring_buffer_iter_new()** initializes a caller-owned iterator for a
> + * ring buffer map.
> + *
> + * @param it Pointer to the iterator to initialize.
> + * @param r Ring buffer map to iterate. Its ring buffer manager must remain
> + * valid until the iterator is destroyed.
> + * @return 0 on success; a negative error code on failure.
> + *
> + * Every successful call must be paired with ring_buffer_iter_destroy() before
> + * the iterator storage is reused or the ring buffer manager is freed. An
> + * active iterator must not be copied. On failure, the iterator is unchanged.
> + *
> + * A ring consumed only through iterators may be registered with a NULL sample
> + * callback. A sample callback is required to consume records through
> + * callback-based APIs.
> + *
> + * Only one iterator or callback-based consumer may operate on a ring buffer
> + * map at a time. BPF_F_RB_OVERWRITE ring buffer maps are not supported.
> + */
> +LIBBPF_API int ring_buffer_iter_new(struct ring_buffer_iter *it,
> +				    struct ring *r);
> +
> +/**
> + * @brief **ring_buffer_iter_next()** returns the next available record.
> + *
> + * @param it Pointer to an initialized ring buffer iterator.
> + * @param size Optional pointer that receives the record size.
> + * @param sync Publish consumed records before advancing.
> + * @return A read-only pointer to the record data, or NULL if the iterator is
> + * exhausted.
> + *
> + * The returned record's data becomes invalid on the next call to
> + * ring_buffer_iter_next() or ring_buffer_iter_destroy(), regardless of sync.
> + * When sync is true, this call publishes records returned by earlier calls
> + * before inspecting another one. Otherwise publication may be deferred until
> + * the iterator refreshes the producer position, observes a busy record, or
> + * is destroyed. Once this function returns NULL, it continues returning NULL.
> + * Create a new iterator to check the ring again.
> + *
> + * Only a NULL return establishes a notification-safe observation: after
> + * publishing the consumer position, the iterator observed no committed record.
> + * Before waiting for ring buffer readiness, drive an iterator to NULL. If an
> + * iterator was destroyed early, create another iterator and drive it to NULL
> + * before waiting.
> + */
> +LIBBPF_API const void *ring_buffer_iter_next(struct ring_buffer_iter *it,
> +					     size_t *size, bool sync);
> +
> +/**
> + * @brief **ring_buffer_iter_destroy()** destroys a ring buffer iterator.
> + *
> + * @param it Pointer to a zero-initialized iterator or one initialized by
> + * ring_buffer_iter_new().
> + *
> + * Any record returned by the previous ring_buffer_iter_next() call is consumed.
> + * Destroying an iterator before ring_buffer_iter_next() returns NULL publishes
> + * the consumed position, but records can remain queued without a new readiness
> + * notification.
> + */
> +LIBBPF_API void ring_buffer_iter_destroy(struct ring_buffer_iter *it);
> +
>  /**
>   * @brief **ring__consumer_pos()** returns the current consumer position in the
>   * given ringbuffer.
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index a45666f546fa..5ab5a46fedb1 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -479,4 +479,7 @@ LIBBPF_1.9.0 {
>  		bpf_program__load;
>  		bpf_program__load_strategy;
>  		bpf_program__set_load_strategy;
> +		ring_buffer_iter_destroy;
> +		ring_buffer_iter_new;
> +		ring_buffer_iter_next;
>  } LIBBPF_1.8.0;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 7bf92311da68..2e281e2fa573 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -255,64 +255,166 @@ static int ringbuf_validate_callbacks(const struct ring_buffer *rb)
>  	return 0;
>  }
>  
> -static int64_t ringbuf_process_ring(struct ring *r, size_t n)
> +/*
> + * The private state aliases the public iterator's opaque __u64 storage.
> + * Allow that access without violating strict aliasing rules.
> + */
> +struct ring_buffer_iter_state {
> +	struct ring *ring;
> +	unsigned long cons_pos;
> +	unsigned long prod_pos;
> +	bool consumer_dirty;
> +	bool needs_wakeup;
> +} __attribute__((__may_alias__));
> +
> +_Static_assert(sizeof(struct ring_buffer_iter_state) <=
> +		       sizeof(struct ring_buffer_iter),
> +	       "ring buffer iterator state exceeds opaque storage");
> +_Static_assert(__alignof__(struct ring_buffer_iter_state) <=
> +		       __alignof__(struct ring_buffer_iter),
> +	       "ring buffer iterator is under-aligned");
> +
> +static void ringbuf_iter_publish(struct ring_buffer_iter_state *state)
>  {
> -	int *len_ptr, len, err;
> -	/* 64-bit to avoid overflow in case of extreme application behavior */
> -	int64_t cnt = 0;
> +	if (!state->consumer_dirty)
> +		return;
> +
> +	/* Release consumed records to the producer. */
> +	__atomic_store_n(state->ring->consumer_pos, state->cons_pos,
> +			 __ATOMIC_RELEASE);
> +	state->consumer_dirty = false;
> +	state->needs_wakeup = true;
> +}
> +
> +static void ringbuf_iter_init(struct ring_buffer_iter *it, struct ring *r)
> +{
> +	struct ring_buffer_iter_state *state = (void *)it;
> +
> +	memset(it, 0, sizeof(*it));
> +	state->ring = r;
> +	state->cons_pos = __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
> +	state->prod_pos = state->cons_pos;
> +}
> +
> +int ring_buffer_iter_new(struct ring_buffer_iter *it, struct ring *r)
> +{
> +	if (r->overwrite)
> +		return libbpf_err(-EOPNOTSUPP);
> +
> +	ringbuf_iter_init(it, r);
> +	return 0;
> +}
> +
> +static const void *ringbuf_iter_next(struct ring_buffer_iter *it, size_t *size,
> +				     bool sync)
> +{

Can we make this internal helper __always_inline? Otherwise we have an
out-of-line call per record in ringbuf_process_ring(), which could be a
bit expensive. Inlining would also allow specialization of the sync=true
path.

I tried with a local CPU-pinned benchmark using extracted consumer code
and measured ~1014 ns to drain 512 precommitted 64-byte records, versus
~1231 ns with the final series. Inlining this helper, together with the
private destructor (see below), reduced that to ~1029 ns.

These are synthetic traversal measurements, not end-to-end BPF
throughput. It'd be interesting to check rb-libbpf throughput before and
after the callback conversion.

> +	struct ring_buffer_iter_state *state = (void *)it;
> +	struct ring *r = state->ring;
> +	int *len_ptr, len;
>  	unsigned long cons_pos, prod_pos;
>  	bool got_new_data;
>  	void *sample;
>  
> -	err = ringbuf_validate(r);
> -	if (err)
> -		return err;
> -	if (n == 0)
> -		return 0;
> +	if (!r)
> +		return NULL;
> +	if (sync)
> +		ringbuf_iter_publish(state);
> +	cons_pos = state->cons_pos;
> +	prod_pos = state->prod_pos;
>  
> -	cons_pos = __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
> -	for (;;) {
> +	do {
>  		got_new_data = false;
> -		prod_pos = __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
> -		while (prod_pos - cons_pos > 0) {
> +		if (cons_pos == prod_pos) {
> +			ringbuf_iter_publish(state);
> +			if (state->needs_wakeup) {
> +				/*
> +				 * Ensure either this sees a new record or its producer sees
> +				 * the updated consumer position and sends a notification.
> +				 */
> +				__atomic_thread_fence(__ATOMIC_SEQ_CST);
> +				state->needs_wakeup = false;
> +			}
> +			prod_pos = __atomic_load_n(r->producer_pos,
> +						   __ATOMIC_ACQUIRE);
> +			state->prod_pos = prod_pos;
> +		}
> +
> +		while (cons_pos != prod_pos) {
>  			len_ptr = r->data + (cons_pos & r->mask);
>  			len = __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE);
>  
>  			/* Retry a busy record once after publishing prior records. */
> -			if (len & BPF_RINGBUF_BUSY_BIT)
> +			if (len & BPF_RINGBUF_BUSY_BIT) {
> +				ringbuf_iter_publish(state);
> +				got_new_data = state->needs_wakeup;
> +				if (got_new_data) {
> +					/* Order the consumer update before retrying the header. */
> +					__atomic_thread_fence(__ATOMIC_SEQ_CST);
> +					state->needs_wakeup = false;
> +				}
>  				break;
> +			}
>  
>  			got_new_data = true;
>  			cons_pos += roundup_len(len);
> +			state->cons_pos = cons_pos;
> +			state->consumer_dirty = true;
>  
>  			if ((len & BPF_RINGBUF_DISCARD_BIT) == 0) {
>  				sample = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
> -				err = r->sample_cb(r->ctx, sample, len);
> -				if (err < 0) {
> -					/* update consumer pos and bail out */
> -					__atomic_store_n(r->consumer_pos, cons_pos, __ATOMIC_RELEASE);
> -					__atomic_thread_fence(__ATOMIC_SEQ_CST);
> -					return err;
> -				}
> -				cnt++;
> +				if (size)
> +					*size = len;
> +				return sample;
>  			}
>  
> -			__atomic_store_n(r->consumer_pos, cons_pos, __ATOMIC_RELEASE);
> -
> -			if (cnt >= n)
> -				goto done;
> +			if (sync)
> +				ringbuf_iter_publish(state);
>  		}
> -		if (!got_new_data)
> -			return cnt;
> +	} while (got_new_data);
>  
> -		/*
> -		 * Order the published consumer position before the next
> -		 * producer-position load, whether below or in a later invocation.
> -		 */
> +	state->ring = NULL;
> +	return NULL;
> +}
> +
> +const void *ring_buffer_iter_next(struct ring_buffer_iter *it, size_t *size,
> +				  bool sync)
> +{
> +	return ringbuf_iter_next(it, size, sync);
> +}
> +
> +void ring_buffer_iter_destroy(struct ring_buffer_iter *it)
> +{
> +	struct ring_buffer_iter_state *state = (void *)it;
> +
> +	ringbuf_iter_publish(state);
> +	/* Order publication before a producer load in a later invocation. */
> +	if (state->needs_wakeup)
>  		__atomic_thread_fence(__ATOMIC_SEQ_CST);
> +	memset(it, 0, sizeof(*it));
> +}

Likewise, can we move this body into a new inline helper and keep the
exported destructor as a wrapper? Something like this:

static __always_inline void
ringbuf_iter_destroy(struct ring_buffer_iter *it)
{
	struct ring_buffer_iter_state *state = (void *)it;

	ringbuf_iter_publish(state);
	/* Order publication before a producer load in a later invocation. */
	if (state->needs_wakeup)
		__atomic_thread_fence(__ATOMIC_SEQ_CST);
	memset(it, 0, sizeof(*it));
}

void ring_buffer_iter_destroy(struct ring_buffer_iter *it)
{
	ringbuf_iter_destroy(it);
}

> +
> +static int64_t ringbuf_process_ring(struct ring *r, size_t n)
> +{
> +	struct ring_buffer_iter it
> +		__attribute__((cleanup(ring_buffer_iter_destroy))) = {};

Then use the new private helper here:

	struct ring_buffer_iter it
		__attribute__((cleanup(ringbuf_iter_destroy))) = {};

> +	const void *sample;
> +	size_t size;
> +	int err = ringbuf_validate(r);
> +	/* 64-bit to avoid overflow in case of extreme application behavior */
> +	int64_t cnt = 0;
> +
> +	if (err)
> +		return err;
> +	if (n == 0)
> +		return 0;
> +
> +	ringbuf_iter_init(&it, r);
> +	while (cnt < n && (sample = ringbuf_iter_next(&it, &size, true))) {
> +		err = r->sample_cb(r->ctx, (void *)sample, size);
> +		if (err < 0)
> +			return err;
> +		cnt++;
>  	}
> -done:
> -	__atomic_thread_fence(__ATOMIC_SEQ_CST);
>  	return cnt;
>  }
>  
> @@ -421,7 +523,7 @@ struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx)
>  
>  unsigned long ring__consumer_pos(const struct ring *r)
>  {
> -	/* Synchronizes with the release store in ringbuf_process_ring(). */
> +	/* Synchronizes with the iterator's release store. */
>  	return __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
>  }

Thanks,
-Andrea
