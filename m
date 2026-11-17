Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911458;
	b=RsM16KFNaquf9dKAl4aHrtBVHCrc+tZoE9V8/JdQFvxwnN/3CTzxj2cE3HZyUivWwgHf
	 7tD19ZVZU71jtgCX+CuYA8WlQnKDhAdadUFol0pjy/60GytssZGlnb16iEikVXL2tPzKh
	 T9dAiictaZdnX8eZ1iwvqrcAB3IWChQzo0D0IBLmfNqft3XI/V+i3XGeNnldJAuSHRKpu
	 rMne8vyeV1jyEfEcL7SFLrpFB/QIDKpVj58TahGYMhsRxuui4Fwa3JigS/kb0WU9tUIdZ
	 xdRZPHL7eGc7ytOAZfSm3TTqmPIp4+ko36VhegwkUCZGWXlU8ugFVk1CPDRF0JPGq7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911458;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
	bh=N+S6HeGqjWEQqo20pp8YYIk0JXAHiLz/wOsnWap8Jx4=;
	b=0tprmHVPfxNd0VSLTBgpGICCjxREb6Y9eHPP+B9ecUx9Tb1NjOEByEVQDag0ZWmgycXV
	 ykd/mlt3u4V+e1AEBXB3k5UAjZYbRlmnxZ1/h99Gn8qAVRvNK8LeN+eByLXOP/1mHUGm9
	 c7e9lEdHZGiZ3cyXW7VCQ2BlXuUyVvEwkGIdF6yZ4w/1YgnKOhfOVeeWgu9H5WvJX/rd4
	 Eqxdd3vu3LARcM05y5tMTRyVwXkA9AMGxXCdgGtTKqnSapdDMwE3SItDETdUT0PpRU/L8
	 ZKWwsxinBSg4HJeQo/dB7qwl6p2l6OnBboq10cs93Ocnc6XbmiigD2maYGQ98D9PPcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EttP77Va;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.15
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442B606A32F;
	Tue, 17 Nov 2026 10:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D442B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EttP77Va
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYeniI7erSWuJf2F/Smf8A+AxIILpW3NV/3Rxl6sOtTSnBD+RZjFTqH1/5mqpIHurq4hPRLzR6ZyYcys6aWjl2ZJE7yY8weDvpFXKrBI1Uys7NWRRgslpZWMk2ncUNufl5uzw9lhADO+naf0swtOzCGoiA4Ulvjn2XjdU1intn6I2t7ezB2W0/8i8I2pGFrYhI6/3FUmB9Tu/d/dXIY+VbbjaGyUIktKTl5WpQc+we3Lz/QORF7VeK1M6NWUR5NmjE25Qj0cUR/9YKq2mTVNnZHr5y6lBQfXU3ic0SbPsx0pXP45U7tAP0GeC0fJD1s/lEcbEgnlwMTtbmNDjgByOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+S6HeGqjWEQqo20pp8YYIk0JXAHiLz/wOsnWap8Jx4=;
 b=vp22AlbvQX6zQay4vYRok9SXZcQlJD3LXSDaIp38cSJNZFN548BW7O69fmapO0xHlIvkYhCwkDAD8pt8uwwSjKSnhaRSOVsRWVs18KmByTCbum715qx6b36eT/gWxX+QH0uxilPrEpp1h+5UkKhxAOSz9ANP76q/lAc5mAyvDu+iStKNaHE2L6lS9JDe2yOTifuMwkrnIQukm3iTBU4pVIkOoASQ+Oi8EJp5h5Y39YFo4nu65rN1fsiU+CA8FhOdgLOVgjxbGL2V35Nw3LW5P0UOkqNvPVc8B9xy3RxZkbPbGIhlZl30Ew51yxjryKvQqi04TxtANBG2Y9DU2q8BEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+S6HeGqjWEQqo20pp8YYIk0JXAHiLz/wOsnWap8Jx4=;
 b=EttP77VaZbfvCfpCuMzxpigBuYRVT8AJSdNBTe0le7mLIZKMuTOrdSQx766jiBfqOoHHHgR2DRqcP+2jfWhVA37CixyHofhTyPhApw+4FxxKG7yWy5UchxcTSjgIdUC6vx2FAAo+UbdlgBgzUNSlP9gPRjZrTo03b4m7cbZyKtt8a0a/Fqkb+G29LdOGq8revil2Bd2zcQo8gy0WmQHB+ErwwAjCeomXBQJJtVLmnGdwnQZVTZr6g9E3mTc6B63RFYYA+03jW0w8McTay201n/nRT4AOFqzObJZsYZbkOxW1eBrRDZVygo/CeUbR9sQESIBIkz9X6veYB23IikFAbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH1PPF189669351.namprd12.prod.outlook.com (2603:10b6:61f:fc00::608) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:30:51 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 10:30:51 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Josh Don <joshdon@google.com>,
	Vineeth Pillai <vineethrp@google.com>,
	Peilin Ye <yepeilin@google.com>,
	Zhi Wang <zhiw@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Himadri Chhaya-Shailesh <himadrics@protonmail.com>,
	NchangRoy <royfru44@gmail.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] bpf: Allow importing memfd pages into an arena
Date: Tue, 17 Nov 2026 11:28:06 +0100
Message-ID: <20261117103028.4105609-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117103028.4105609-1-arighi@nvidia.com>
References: <20261117103028.4105609-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::7) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: 8644c5e8-2a75-4f3a-9f0d-08df4495da79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|5023799004|11063799006|56012099006|261022075727099003|261026140227099003|261021121427099003|261026121527099003|261021123027099003|261022113327099003|261022105027099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	d5Trf1JJvCp81UwiSh5I3oS4jr0IDcBJs6p6BWlpMHP0UFSUvN3UvJ28gz4vpw5oGJk7CIQXJpxYWoMLVW9c4DrI7cZMpqvLw8x81KyJv4gCGjSz5Dw8rA8h7CcrdJribgTLA93mW/F0byRDFYBuntgls+xjZJV8VRd/tJxeRQZyjkfZMNFcBR2HhOX/AUgSelmvNQn9b++QIuWSLPAeEok/waP/Xp6djWb+HBitm2V1p9uEYXLVgp9JOvklDysfVU9Y4JL+H1GqE8ZsrpkhapmBbdb40X+g9nTspfwvQWkeSyTngjlv+spxl9SWYreZx8CskJQ9YBdZEB/eOHbYqlkvbXfXjn1sponSaiXOh6xzM5AcXJwg72/bGfZUrh/Wp7tX+XfbLgm0ytSAgqQyQpuiM9HNfMmGfPXBOMFlxxQo6M8Xfm0wy38ragPmlMe+TI4DgrKGM9GyERCU0lVJDoLXxBZFgi2+RDjTgyu5v+H2OD9COani93+hxIaztDGQGdocFeS4g5i07LAHku6nvbCflXyLXs6utJAniELR5jsPOXPfQ7Vqov/Vaaqqax6DNR+JrORJ8IKXkJlHkuAJN5IVLaJ91JRnDjMNuvgkcbwpZhtM0rKX9XEV+5KlQnVW+zWwNUMFi2Up9fj2936mIgTxzpMNsV7tJAeTbMV1Mxg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(5023799004)(11063799006)(56012099006)(261022075727099003)(261026140227099003)(261021121427099003)(261026121527099003)(261021123027099003)(261022113327099003)(261022105027099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qGg4rXHT8d289MTfIdZ215Xz5X7MLbvqOEfVt5wt16HhVJlqPLn6R9nc0hR+?=
 =?us-ascii?Q?ANUgIcm3gNqNFql4PgbxhVbElrFUDWPedACuZQ/5oflGREKwe1soPHpCBk+u?=
 =?us-ascii?Q?UFC/KdZqYctnOw3s3hViFFYCRv2zkE1lAG/8Y1Doz+Qet9jO2T+SlTkAPdIO?=
 =?us-ascii?Q?qPHwx/A0AzjRf3f8+Bj/kRBs2uSmcXTuRgPpqkoC/r+bKvcpOtFQlQKXWLgn?=
 =?us-ascii?Q?wm4dgi+4KNg5OIGyZO0sU5lWXOXEYwZo+eYPCsWQH5rFacZRCtudJ2LDt5Au?=
 =?us-ascii?Q?+Z39NYFtdLCBmzVp5obHzj5Yeot+L6y006DGRzFc/Y8vy+6wqMCCK4EOh7ul?=
 =?us-ascii?Q?WLR8OrWbXi/SKuFHrNvMXmCJC48oWLcE9a8YSmdsczd7w1Spw6MjsU3R2Pdx?=
 =?us-ascii?Q?ZR4k9xSGPDWngDN9W948wnnGMdaACoNrbtS0yyT1+BdBh0isTls2nyxNntkC?=
 =?us-ascii?Q?12jjUHByg8YEXRBCKSv3YEe6ouF3LstcPCEgq9E5FTC8bYHlv0hHE6BO8XH5?=
 =?us-ascii?Q?/JNz6ej6O6BPvBh38MAGABHaK3438dqbAASm/lm0eZn1vj8y+a9ZxMaYV1pO?=
 =?us-ascii?Q?lh7VwPy3ZOKREKWzZYOaJkK4mKsizxbYSDr0YJ1XSJtElzKk+yVNikYvrtRC?=
 =?us-ascii?Q?tiytIB/yZdciy1fbssKJD4+MmCONG7pwI+/4XJcmevH7gFawfBsrEFkn6GxR?=
 =?us-ascii?Q?OgSObnZwtDcBIq7WUEk8YaD4CbuM0LvMSD9G1mKhwC1SuhNktlmxI0VPTdFN?=
 =?us-ascii?Q?RdNMbK4kcGZpThekFWhy2JQfO8U8EfNwuQa1SU5O3Y0s+wEqnls3oerROJo0?=
 =?us-ascii?Q?/Cgi80lZN6W2UkOM8ntFhMca9Eon/bvcDQ9r0WoM+ePYbL4UiV24RV9WzvN+?=
 =?us-ascii?Q?4e3hbDNGiess8JWOEVSNEw4VlHnWZ7bxq+lh9oSxb2vaJXanKINx78ZfThrl?=
 =?us-ascii?Q?i3xIzHTuqdG7S9KdSzpiVMt82w/64e9UDrYPU0ONVlM9NfNT3qAnYFIxMGbg?=
 =?us-ascii?Q?hR+7bvesf23/0AOVi7PpR1YxmlVxAayhK3sYJRst/bTdKTEG3B9ZN1xGsPWR?=
 =?us-ascii?Q?9Cy62hvLUm+uvRmDA7oXAWaRphCEXjY9SZMMKdZ07jNSgGI/d4ojqgUojIgO?=
 =?us-ascii?Q?lc26ZHSErSCS7KHTgjYrnMV3jZfDwMyZ7ldRkYHLkHV4ZeEEvnFGWJvwwRFX?=
 =?us-ascii?Q?4SeHzH5pO0wkztNsXq+pClmEnejosLQa0QGlDC/o7tcqSwj2qLG5IIsydFjz?=
 =?us-ascii?Q?LlRJLl9Hjq64Wf1UvWVNpgQhGN5lhLsg+HB4s5K6hOzIKFwgW+ODMbTd3uYs?=
 =?us-ascii?Q?zCS7P6ddaPJ8K/DJY2yZPx+dEbg93f4r6eBnMvy+3+eNpy4ewTf1baBN9LQd?=
 =?us-ascii?Q?64TAh6s1epu0qgQGlfXVvNA+j3SxLDDnY/FwO32fDflsq849zv/tTtzmtO7D?=
 =?us-ascii?Q?FkX+f1m0Dvw/OZkr+Se5wT404XBGwzLWVsTWhsqnNuapl7kTL94p2K5Vbw2j?=
 =?us-ascii?Q?poVEAm81fqP0Czfv67dvJ+5E+iC4g7ipP+jzq+wGenMdrnCPeMCmplvhYUch?=
 =?us-ascii?Q?HVC/t1FwnxOzhn3J4yhmlDzrFP8tZ4MCYimcxYcZwZAGN8i1rf6pgeVLpTKC?=
 =?us-ascii?Q?wn33NDc6NP+2ofzqWLDiSqL2hjqSB01ag7V/ZXzkuQuY+Gopt3EX+IP1YPXy?=
 =?us-ascii?Q?dXM6gIiXc5CDnKn3PsfHgPYAnPvQKadG9hgyhGK3aXeBdxij?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8644c5e8-2a75-4f3a-9f0d-08df4495da79
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:30:51.8461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xts0GSFGhkeo45nUFvyNr/jTk6BTPzuiF51hDCd9wmN4mbCeyVrclxgXMjpBmowgAJnMZzOUpm2dhiadditGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351

An arena can only map pages it allocated itself, so its memory can be
shared only with the BPF programs and the user space that map the arena.

Teach the arena to map pages that it didn't allocate and add a sleepable
kfunc for syscall programs that imports the pages of a memfd, or of any
file on tmpfs or hugetlbfs:

  int bpf_arena_import_memfd(void *map, void __arena *addr,
                             u32 page_cnt, int fd, u64 off);

The folios are pinned with memfd_pin_folios(), like udmabuf does, and
mapped at addr. Whatever maps the file then sees the same pages as the
BPF programs, for example a VMM that maps it into a guest.

Each import is kept in an interval tree with its pages, which belong to
the file, not to the arena:
 - bpf_arena_free_pages() over any of them releases the whole import:
   the pages are unmapped and unpinned, the data stays in the file,
 - they are released when the arena is destroyed,
 - they are not counted in the arena memory usage,
 - the arena mapping raises SIGBUS on them (SIGSEGV with
   BPF_F_SEGV_ON_FAULT): user space accesses them by mapping the file.

The file must be open for reading and writing and the LSMs must allow a
shared mapping of it. It must not be append-only or sealed against
writes.

F_SEAL_SHRINK is not required, unlike udmabuf: a file on tmpfs, such as
a VMM memory backend, can't be sealed. If the supplier shrinks the file
or punches a hole in the imported range, the arena keeps the pages it
pinned, which are no longer the file's.

While its pages are imported, the file can't be executed, as when it's
open for writing.

The pins aren't charged to locked_vm: like the rest of BPF memory, the
pages are accounted to a memory cgroup, the one of the supplier that
allocated them (hugetlbfs pages come from the hugetlb pool). Pinning
them adds no memory, but keeps it from being swapped out until the
arena releases it. Only a program with CAP_BPF, or a BPF token, can
import pages.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/bpf/arena.c | 340 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 329 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index aff231922e114..799a8cf1ee728 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -4,7 +4,10 @@
 #include <linux/btf.h>
 #include <linux/cacheflush.h>
 #include <linux/err.h>
+#include <linux/file.h>
+#include <linux/interval_tree_generic.h>
 #include <linux/irq_work.h>
+#include <linux/memfd.h>
 #include "linux/filter.h"
 #include <linux/llist.h>
 #include <linux/mman.h>
@@ -14,6 +17,7 @@
 #include <linux/printk.h>
 #include <linux/ratelimit.h>
 #include <linux/rbtree_latch.h>
+#include <linux/security.h>
 #include <asm/tlbflush.h>
 #include "range_tree.h"
 
@@ -64,7 +68,9 @@ struct bpf_arena {
 	struct vm_struct *kern_vm;
 	struct page *scratch_page;
 	struct range_tree rt;
-	/* protects rt and nr_pages */
+	/* pages the arena didn't allocate, see struct arena_import */
+	struct rb_root_cached imports;
+	/* protects rt, imports and nr_pages */
 	rqspinlock_t spinlock;
 	/* number of pages currently populated in the arena */
 	u64 nr_pages;
@@ -114,6 +120,28 @@ struct arena_free_span {
 	u32 page_cnt;
 };
 
+/*
+ * Pages mapped by one import, pinned once each. They are released together,
+ * when the arena frees any of them or is destroyed.
+ */
+struct arena_import {
+	struct rb_node rb;
+	long subtree_last;
+	/* on a list while being released */
+	struct list_head head;
+	struct page **pages;
+	/* the file, with write access on its inode */
+	struct file *file;
+	long pgoff;
+	long page_cnt;
+	u32 uaddr;	/* lower 32 bits of the user address */
+};
+
+#define IMPORT_START(imp)	((imp)->pgoff)
+#define IMPORT_LAST(imp)	((imp)->pgoff + (imp)->page_cnt - 1)
+INTERVAL_TREE_DEFINE(struct arena_import, rb, long, subtree_last, IMPORT_START, IMPORT_LAST,
+		     static inline __maybe_unused, arena_import_it)
+
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
 {
 	return arena ? (u64) (long) arena->kern_vm->addr + GUARD_SZ / 2 : 0;
@@ -210,6 +238,8 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
 struct apply_range_data {
 	struct bpf_arena *arena;
 	struct llist_head *pages;
+	/* imported pages, they can't be linked through pcp_llist */
+	struct page **ext_pages;
 	int i;
 };
 
@@ -221,17 +251,21 @@ struct clear_range_data {
 static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 {
 	struct apply_range_data *d = data;
-	struct llist_node *node;
+	struct llist_node *node = NULL;
 	struct page *page;
 	pte_t pteval;
 
 	if (!data)
 		return 0;
 
-	node = READ_ONCE(d->pages->first);
-	if (WARN_ON_ONCE(!node))
-		return -EINVAL;
-	page = llist_entry(node, struct page, pcp_llist);
+	if (d->ext_pages) {
+		page = d->ext_pages[d->i];
+	} else {
+		node = READ_ONCE(d->pages->first);
+		if (WARN_ON_ONCE(!node))
+			return -EINVAL;
+		page = llist_entry(node, struct page, pcp_llist);
+	}
 	/* paranoia, similar to vmap_pages_pte_range() */
 	if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
 		return -EINVAL;
@@ -264,8 +298,11 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 		return -EBUSY;
 	set_pte_at(&init_mm, addr, pte, pteval);
 #endif
-	WARN_ON_ONCE(llist_del_first(d->pages) != node);
 	d->i++;
+	/* Imported pages are accounted to their supplier */
+	if (!node)
+		return 0;
+	WARN_ON_ONCE(llist_del_first(d->pages) != node);
 	WRITE_ONCE(d->arena->nr_pages, d->arena->nr_pages + 1);
 	return 0;
 }
@@ -324,6 +361,47 @@ static int apply_range_set_scratch_cb(pte_t *pte, unsigned long addr, void *data
 	return 0;
 }
 
+static int apply_range_clear_ext_cb(pte_t *pte, unsigned long addr, void *data)
+{
+	ptep_get_and_clear(&init_mm, addr, pte);
+	return 0;
+}
+
+/* Under arena->spinlock, or when nothing else can use the arena anymore */
+static struct arena_import *arena_find_import(struct bpf_arena *arena, long pgoff)
+{
+	return arena_import_it_iter_first(&arena->imports, pgoff, pgoff);
+}
+
+static u64 arena_import_kaddr(struct bpf_arena *arena, struct arena_import *imp)
+{
+	return bpf_arena_get_kern_vm_start(arena) + imp->uaddr;
+}
+
+/* Like arena_find_import(), the caller flushes the TLB after */
+static void arena_unmap_import(struct bpf_arena *arena, struct arena_import *imp)
+{
+	apply_to_existing_page_range(&init_mm, arena_import_kaddr(arena, imp),
+				     imp->page_cnt << PAGE_SHIFT, apply_range_clear_ext_cb, NULL);
+}
+
+static void arena_flush_import(struct bpf_arena *arena, struct arena_import *imp)
+{
+	u64 kaddr = arena_import_kaddr(arena, imp);
+
+	flush_tlb_kernel_range(kaddr, kaddr + (imp->page_cnt << PAGE_SHIFT));
+}
+
+static void arena_release_import(struct arena_import *imp)
+{
+	/* BPF programs write through the kernel mapping, which doesn't track dirty */
+	unpin_user_pages_dirty_lock(imp->pages, imp->page_cnt, true);
+	put_write_access(file_inode(imp->file));
+	fput(imp->file);
+	kvfree(imp->pages);
+	kfree(imp);
+}
+
 static int populate_pgtable_except_pte(struct bpf_arena *arena)
 {
 	/* Populate intermediates for the recovery range (4 GiB + upper half-guard). */
@@ -375,6 +453,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		arena->user_vm_end = arena->user_vm_start + vm_range;
 
 	INIT_LIST_HEAD(&arena->vma_list);
+	arena->imports = RB_ROOT_CACHED;
 	init_llist_head(&arena->free_spans);
 	init_irq_work(&arena->free_irq, arena_free_irq);
 	INIT_WORK(&arena->free_work, arena_free_worker);
@@ -443,6 +522,15 @@ static void arena_map_destroy(struct work_struct *work)
 {
 	struct bpf_arena *arena = container_of(to_rcu_work(work), struct bpf_arena,
 					     destroy_work);
+	struct arena_import *imp;
+
+	/* Imported pages go back to their supplier */
+	while ((imp = arena_import_it_iter_first(&arena->imports, 0, LONG_MAX))) {
+		arena_import_it_remove(imp, &arena->imports);
+		arena_unmap_import(arena, imp);
+		arena_flush_import(arena, imp);
+		arena_release_import(imp);
+	}
 
 	/*
 	 * free_vm_area() calls remove_vm_area() that calls free_unmap_vmap_area().
@@ -569,7 +657,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct mem_cgroup *new_memcg, *old_memcg;
 	LLIST_HEAD(pages);
 	struct page *page, *new_page = NULL;
-	struct apply_range_data data;
+	struct apply_range_data data = {};
 	vm_fault_t fault_ret;
 	long kbase, kaddr;
 	unsigned long flags;
@@ -605,6 +693,15 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 
 	page = vmalloc_to_page((void *)kaddr);
 	if (page) {
+		/*
+		 * Not the arena's: user space maps the file or the device the
+		 * pages come from
+		 */
+		if (arena_find_import(arena, vmf->pgoff)) {
+			fault_ret = (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
+				    ? VM_FAULT_SIGSEGV : VM_FAULT_SIGBUS;
+			goto out_err_locked;
+		}
 		if (page == arena->scratch_page) {
 			/* BPF triggered scratch here; don't lazy-alloc over it */
 			fault_ret = (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
@@ -855,7 +952,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
 	struct mem_cgroup *new_memcg, *old_memcg;
-	struct apply_range_data data;
+	struct apply_range_data data = {};
 	LLIST_HEAD(pages);
 	long mapped = 0;
 	unsigned long flags;
@@ -1010,9 +1107,12 @@ static int arena_free_range(struct bpf_arena *arena, long uaddr, long page_cnt)
 	u64 full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
 	long kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
 	long pgoff = compute_pgoff(arena, uaddr);
+	long first = pgoff, last = pgoff + page_cnt - 1;
+	struct arena_import *imp, *tmp;
 	struct clear_range_data cdata;
 	struct llist_node *pos, *t;
 	LLIST_HEAD(free_pages);
+	LIST_HEAD(imports);
 	unsigned long flags;
 	struct page *page;
 	int ret;
@@ -1033,6 +1133,15 @@ static int arena_free_range(struct bpf_arena *arena, long uaddr, long page_cnt)
 		return 0;
 	}
 
+	/* Imports are released whole, also the ones that are only partly in the range */
+	while ((imp = arena_import_it_iter_first(&arena->imports, pgoff, pgoff + page_cnt - 1))) {
+		first = min(first, IMPORT_START(imp));
+		last = max(last, IMPORT_LAST(imp));
+		arena_import_it_remove(imp, &arena->imports);
+		arena_unmap_import(arena, imp);
+		list_add(&imp->head, &imports);
+	}
+
 	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
 	/* clear ptes and collect struct pages */
@@ -1050,6 +1159,8 @@ static int arena_free_range(struct bpf_arena *arena, long uaddr, long page_cnt)
 
 	/* ensure no stale TLB entries */
 	flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
+	list_for_each_entry(imp, &imports, head)
+		arena_flush_import(arena, imp);
 
 	if (page_cnt > 1)
 		/* bulk zap if multiple pages being freed */
@@ -1070,8 +1181,15 @@ static int arena_free_range(struct bpf_arena *arena, long uaddr, long page_cnt)
 	/* The callers hold no other rqspinlock, so this one can only time out */
 	while (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
 		cond_resched();
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	/*
+	 * The range and the imports it overlaps are contiguous: set them at once,
+	 * so that the imports need no more range tree nodes than the range alone
+	 */
+	range_tree_set(&arena->rt, first, last - first + 1);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
+	list_for_each_entry_safe(imp, tmp, &imports, head)
+		arena_release_import(imp);
 	return 0;
 }
 
@@ -1272,6 +1390,160 @@ static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt
 	return ret;
 }
 
+/*
+ * Map @page_cnt pages that the arena didn't allocate at @uaddr, which must be
+ * free. On success the arena keeps @pages, their pins and the write access on
+ * @file until it releases them, see struct arena_import.
+ */
+static int arena_map_ext_pages(struct bpf_arena *arena, long uaddr, struct page **pages,
+			       long page_cnt, struct file *file)
+{
+	/* The first mmap() may be setting the user range: a non-zero start is final */
+	u64 user_vm_start = READ_ONCE(arena->user_vm_start);
+	struct apply_range_data data = { .arena = arena, .ext_pages = pages };
+	struct mem_cgroup *new_memcg, *old_memcg;
+	long page_cnt_max, pgoff, kaddr;
+	struct arena_import *imp;
+	unsigned long flags;
+	int ret;
+
+	if (!user_vm_start)
+		return -EINVAL;
+	page_cnt_max = ((long)READ_ONCE(arena->user_vm_end) - (long)user_vm_start) >> PAGE_SHIFT;
+	if (!uaddr || (uaddr & ~PAGE_MASK) || page_cnt > page_cnt_max)
+		return -EINVAL;
+	pgoff = (u32)(uaddr - (u32)user_vm_start) >> PAGE_SHIFT;
+	if (pgoff > page_cnt_max - page_cnt)
+		return -EINVAL;
+	kaddr = bpf_arena_get_kern_vm_start(arena) + (u32)uaddr;
+
+	imp = kmalloc_obj(*imp, GFP_KERNEL_ACCOUNT);
+	if (!imp)
+		return -ENOMEM;
+	imp->pages = pages;
+	imp->file = file;
+	imp->pgoff = pgoff;
+	imp->page_cnt = page_cnt;
+	imp->uaddr = (u32)uaddr;
+
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
+		ret = -EBUSY;
+		goto out;
+	}
+	ret = is_range_tree_set(&arena->rt, pgoff, page_cnt) ? -EBUSY :
+	      range_tree_clear(&arena->rt, pgoff, page_cnt);
+	if (!ret) {
+		/* The page tables are there, and a free range has no pages */
+		WARN_ON_ONCE(apply_to_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
+						 apply_range_set_cb, &data));
+		flush_vmap_cache(kaddr, page_cnt << PAGE_SHIFT);
+		get_file(file);
+		arena_import_it_insert(imp, &arena->imports);
+	}
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+out:
+	bpf_map_memcg_exit(old_memcg, new_memcg);
+	if (ret)
+		kfree(imp);
+	return ret;
+}
+
+/*
+ * Import the pages of a memfd or of a file on tmpfs or hugetlbfs. Every file
+ * there has seals: one that isn't a memfd reports F_SEAL_SEAL alone. Other
+ * files have none and can't be imported.
+ */
+static int arena_import_file(struct bpf_arena *arena, long uaddr, u32 page_cnt,
+			     struct file *file, u64 off)
+{
+	long i, nr_folios, first, cnt = 0;
+	struct folio **folios;
+	struct page **pages;
+	pgoff_t folio_off;
+	int seals, ret;
+
+	/*
+	 * Like a writable open: exec of the file fails with -ETXTBSY until the
+	 * pages are released, and a file being executed can't be imported.
+	 * Keeping the file open isn't enough, a memfd holds no write access.
+	 */
+	ret = get_write_access(file_inode(file));
+	if (ret)
+		return ret;
+
+	folios = kvmalloc_array(page_cnt, sizeof(*folios), GFP_KERNEL_ACCOUNT);
+	pages = kvmalloc_array(page_cnt, sizeof(*pages), GFP_KERNEL_ACCOUNT);
+	if (!folios || !pages) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Adding F_SEAL_WRITE takes the inode lock and fails while pages are
+	 * pinned: hold it until they are, like udmabuf
+	 */
+	inode_lock_shared(file_inode(file));
+	seals = memfd_get_seals(file);
+	if (seals < 0)
+		nr_folios = -EINVAL;
+	else if ((seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) || IS_APPEND(file_inode(file)))
+		nr_folios = -EPERM;
+	else
+		nr_folios = memfd_pin_folios(file, off,
+					     off + ((u64)page_cnt << PAGE_SHIFT) - 1,
+					     folios, page_cnt, &folio_off);
+	inode_unlock_shared(file_inode(file));
+	if (nr_folios <= 0) {
+		ret = nr_folios ?: -EINVAL;
+		goto out;
+	}
+
+	/* One pin per page, like pin_user_pages() */
+	for (i = 0; i < nr_folios; i++, folio_off = 0) {
+		first = cnt;
+		for (; folio_off < folio_size(folios[i]) && cnt < page_cnt;
+		     folio_off += PAGE_SIZE)
+			pages[cnt++] = folio_page(folios[i], folio_off >> PAGE_SHIFT);
+		if (cnt - first > 1 && folio_add_pins(folios[i], cnt - first - 1)) {
+			unpin_folios(folios + i, nr_folios - i);
+			cnt = first;
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	ret = cnt == page_cnt ? arena_map_ext_pages(arena, uaddr, pages, page_cnt, file) : -EINVAL;
+out:
+	if (ret) {
+		unpin_user_pages(pages, cnt);
+		kvfree(pages);
+		put_write_access(file_inode(file));
+	}
+	kvfree(folios);
+	return ret;
+}
+
+static int arena_import_memfd(struct bpf_arena *arena, long uaddr, u32 page_cnt, int fd,
+			      u64 off)
+{
+	int ret;
+
+	if (off & ~PAGE_MASK)
+		return -EINVAL;
+
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
+	/* BPF programs read and write it like a shared mapping, which needs the same */
+	if ((fd_file(f)->f_mode & (FMODE_READ | FMODE_WRITE)) != (FMODE_READ | FMODE_WRITE))
+		return -EPERM;
+	ret = security_mmap_file(fd_file(f), PROT_READ | PROT_WRITE, MAP_SHARED);
+	if (ret)
+		return ret;
+	return arena_import_file(arena, uaddr, page_cnt, fd_file(f), off);
+}
+
 static void arena_free_worker(struct work_struct *work)
 {
 	struct bpf_arena *arena = container_of(work, struct bpf_arena, free_work);
@@ -1369,6 +1641,42 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_c
 
 	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
 }
+
+/**
+ * bpf_arena_import_memfd - map the pages of a memfd into an arena
+ * @p__map: the arena
+ * @addr__ign: page-aligned arena address where the pages are mapped
+ * @page_cnt: number of pages to import
+ * @fd: memfd, or file on tmpfs or hugetlbfs, open for reading and writing
+ * @off: page-aligned offset in the file
+ *
+ * Pin the pages of @fd at @off and map them at @addr__ign, which must be free.
+ * They stay until bpf_arena_free_pages() frees any of them, which releases the
+ * whole import, or until the arena is destroyed. Their content stays in the
+ * file. User space accesses them by mapping @fd: the arena mapping raises
+ * SIGBUS (SIGSEGV with BPF_F_SEGV_ON_FAULT) at their addresses. The first page
+ * of an arena that starts on a 4GB boundary can't be imported: its address
+ * reaches the kfunc as NULL.
+ *
+ * F_SEAL_SHRINK is not required, a file on tmpfs can't be sealed. The supplier
+ * must not shrink the file below the imported range or punch holes in it: the
+ * arena would keep the pages it pinned, which are no longer the file's.
+ *
+ * While its pages are imported, the file can't be executed, as when it's open
+ * for writing, and a file being executed can't be imported.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+__bpf_kfunc int bpf_arena_import_memfd(void *p__map, void *addr__ign, u32 page_cnt,
+				       int fd, u64 off)
+{
+	struct bpf_map *map = p__map;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || page_cnt > map->max_entries)
+		return -EINVAL;
+	return arena_import_memfd(arena, (long)addr__ign, page_cnt, fd, off);
+}
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
@@ -1382,9 +1690,19 @@ static const struct btf_kfunc_id_set common_kfunc_set = {
 	.set   = &arena_kfuncs,
 };
 
+BTF_KFUNCS_START(arena_syscall_kfuncs)
+BTF_ID_FLAGS(func, bpf_arena_import_memfd, KF_ARENA_ARG2 | KF_SLEEPABLE)
+BTF_KFUNCS_END(arena_syscall_kfuncs)
+
+static const struct btf_kfunc_id_set syscall_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &arena_syscall_kfuncs,
+};
+
 static int __init kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set);
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set) ?:
+	       register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &syscall_kfunc_set);
 }
 late_initcall(kfunc_init);
 
-- 
2.56.1

