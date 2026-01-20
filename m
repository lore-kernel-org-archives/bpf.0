Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07D134CF;
	Tue, 20 Jan 2026 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946719; cv=fail; b=eyp4OBR8gQvNFAlumL0kOWW6rNgBj8qw/mre2iOjNdWhJMXtv2IS+qlbUrf453vmpW4RL0PCdUtUdvI0HtJ0TLLc1vK63egcrPG/hEi634yyQWXaGBg1H2azJycZv5ic9f7VrwnIYkvjUs+Q5d2h4a7MLDcEKGGCB5GLipDZeWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946719; c=relaxed/simple;
	bh=PiE42TOYg+zOarxj39tTWCfmA2K8E0nAkpQ3REJhDFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1BjTjtTcz84BSzCHdRHl2hcLaRqMiD4bP1smFqRs8611lRXl63BgQz/7Dyn6vSYFuC7PSaVwnkvACDzTIb5GzqcC2Hj4taiiWQNLGvCnbRX8Z/LXWS5GrSL8yTEYalUDlnovSnSSV0djP2Bck3GJBfeuvD9dBBitD8k0qERuf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sl92nkwX; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sl92nkwX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X52/AFcrV9JOPyFiuSHf6grDgNY6fKUPRyiAciZ9FvKWwv/NkVxpQrabQII1MpjtDqxWTOxkAFkW4/IVTpZt7WJxLxqPeLTLINwI1USRBKGnXgUHskNOaC2RSWEfZsAb8pncgzTVHHYWnwNBsADaIJFLA0sqGkE8309wF4s8al3UO52U1GBxswAM72n0AkmTD3IVSsd6INv88ad9Qp3gARwjL0u+ZGQB1aF+mh/8O9BxJwg9uj7O2FM0q/8csjcQ0abjdHY9k3PhyBGAgl0qux0qnN8TdkggVoCUYptY4Nsto0F514H/4kB+p+7prtKS0lo2M7CeyeBJvscMbq5PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTQ15wdg5b9mffX1GSkaEm6FG85PtyPOechoyJI03t4=;
 b=JABoR395IGcC3DVHnlL2iX3J/yaHD3bLgtpLJ3o/u2iPFE4iJ8MsrZ5FNaF+4Rs8E1z8eMAI83D72A+64s6hk1a/rXkv4P0RZca6jloKoscfIODoZsz5dnE+go6SLHE/6acvON8V9jaKzDQtwRfTDhBb+M8OT53c4hKVWAROLyubTkyirPqdQy5U4gUf77z0NsWNVtZrjPQzoS8PZ+Lt1WSmxT4+PIjPIgzYBsjuu0FTyqv9ZWbiKoyK8C24iNpxnEn7neQPe33wyVJ0klsTgF/bxgNrYBfG+zi5On4HXjG/hoifNEC/ofnBiKDXG/VC6j48Pm4c3uUJ6h9bNvpNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTQ15wdg5b9mffX1GSkaEm6FG85PtyPOechoyJI03t4=;
 b=sl92nkwXI1UMzWLIRJMu2LLBMG+IMJ5Dy6GYhDdUlah65DXMU0xwat7lV6AaK8cOy3CYK/zdIa7Hj/GMIwJVsLO6nXt2LF0Nncw8cztlmAgcr522iTUXNcvKLvKzzUQR0anW11vVXzXCE9c/JGQc/dfHeezZOr6crOSW8105eEO9TKv+fuWyhg9Xl9T0irHYcFlSgIN10fW3h/r6BqbC9iv85SmY+JVuXSJZu0kwv1vZu6e3ntHXivue7kS8cEoJFuXCiI+oD8+MdsCjqHBjlfkT70Mq02T12RqEXJff2pUe/t6JC77mxQURe5gDQNNvLg7Olhvlb7oHr+isas54ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 22:05:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 22:05:08 +0000
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
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 6/7] selftests/sched_ext: Add test for sched_ext dl_server
Date: Tue, 20 Jan 2026 23:05:01 +0100
Message-ID: <20260120220502.190159-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120220502.190159-1-arighi@nvidia.com>
References: <20260120215808.188032-1-arighi@nvidia.com>
 <20260120220502.190159-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b701946-2628-4c5d-f707-08de586ff92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IdENwzOga+zlEbqK0IHMzfWKFPBsEnt8sH45fuuMUh9yJwNUGevUnGMvabPD?=
 =?us-ascii?Q?k2kxhlLU5WuT9W2RkPzHNqufgfU7WS2O5XKEMk+OVeTNHW/LOOvSyelwjP4B?=
 =?us-ascii?Q?ZvhULKwrWZ03OVrg/XACOZBlPsUGo8VMWCxXOshN1uY4jLpCgZ7bAL/krsfC?=
 =?us-ascii?Q?Ir00+fIU5H0sFQfjj5+2V3CKCTAAO/OwmVresJD/IStu0lveSz4y9nmr2mv+?=
 =?us-ascii?Q?r/diR/oCUavUHRFPAma1sWyk9kcirS5gpAV6CBZMKWe9U/BU5Rn/sRh0AnYi?=
 =?us-ascii?Q?uy2cKMnmy1Ul4IRF1fiQEJtxnX7QqUCF7GJwn/ubITDHzb/0Yx/zdgFgZY7r?=
 =?us-ascii?Q?+fFwMOjPhCzzSd85RmoJ1xh84HPaDXCP8F1mjmAe12Dmo2uxwszz706M2VDR?=
 =?us-ascii?Q?emy254nfZ7csTBDwisnmz25Q3vT89L8RVEvV+1Zl8ILbTbLf1M/h1nMYf85p?=
 =?us-ascii?Q?LF7DJViQIrcuzLqtfdCo09fR07hXgleUahMyFjfa0xBxIupyWh/DvzlWwHFQ?=
 =?us-ascii?Q?KxKv0PKDLSL7u+tGXCta6etN4ioQfUCn5dNhzjVRuyRDXD4vA9+A5XHbjKL8?=
 =?us-ascii?Q?AsIoFv6oM/c62qafXEseMOgqKmwu4R7KRtwyIGcixP1uixZCA5UEdSP1/tSX?=
 =?us-ascii?Q?DMpyxLb33SI9sUxvcz1gmgo4hoqdKah1LkAMSzp/6J25OuY0+a3RWoz7YTf5?=
 =?us-ascii?Q?n4NKl/umLQjuZ9wiagODkFjNqjhfqHoWokxMTlf5skFfsOCAFYf8xgp3oBfd?=
 =?us-ascii?Q?vAGp6sE61qRM2DXJXUuFZHK05sDUQ7VoArLWwC59shdmfCuTPDKqn5kh2//m?=
 =?us-ascii?Q?2opoPBoy6TQdpFAElQfengbX1kYP5J5sL+6XZR0K7/xYyYlqJBaJDWlWDEBC?=
 =?us-ascii?Q?ntGBb/IoAMW687Wh7aF557M72JrxkkXfJ6FGEBxt9DVE4KMK5rAF3wnYPd1i?=
 =?us-ascii?Q?IO0TknB5PSTGHT5i9ViPn/kl9HnkFs45FAHiwIwJB/CSFjzuSTNiEFyIlbYR?=
 =?us-ascii?Q?wTwWyxNCCDp95fefsbfBm1YlM/SxEA8wjE0KhDHh85vzydFV0MwUU2Pc4PD6?=
 =?us-ascii?Q?OaVFf+a3b3CuyMqPKX6A0TzayyzQt/BN9NF9r6dmW9dijW8PxlQA9sdI4TuM?=
 =?us-ascii?Q?ZZVn7YMqHvXR98I5h/Qhz4pU0jd6qtqX/k0SVjDySdKFmA8JAFZaBRm/izLx?=
 =?us-ascii?Q?sJKcq0gjEBto5ALCr2Ytq8HzltQWdoTGS0/g5vUkSgLbH+EgxkriKXCwLF5k?=
 =?us-ascii?Q?pKhzaIoBp3SmZS2kS+cTElY12qQdX9a3pQ/ym39s/uJDlIPvE8vMKBl1G2Vc?=
 =?us-ascii?Q?IKKEbuAzvYZkja3o1/6CulwdzI7KXk7wdXgraVdFXBeNCOLRNcbd2IcElavg?=
 =?us-ascii?Q?COxIs9o3D8OyjTt3wgP0GLAx49RFjPwuLcHlzkj4SMPyPruQuzUjOfvFr5nA?=
 =?us-ascii?Q?85p8X/z0rGoRRe7r/aW5hruNLrkW1RP52abB3OYmqf6zKeBwzDtqK86Dj0U2?=
 =?us-ascii?Q?DR7OhMvFaTIhD1dA9rQK5m9Bbq5TSRJUz++K8snFhSLjiHyAwBy80J+46cTU?=
 =?us-ascii?Q?K0s4XskfcpdeprCz3Q3frneVZQBr0PK5pxoUX7rSJlUYAkWNbCcPv/gLSU8o?=
 =?us-ascii?Q?dQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1rj97NwcThySONKdNwNz7FSn/csSLlMUFTSym0frffEjSAVF4kcKaOezzRM?=
 =?us-ascii?Q?tpV3Sb7IJ1XMAN1dm6KfTEcQtfnRFOUAtJa5fwPsMQs8nmLXSrkGLpDRR9G9?=
 =?us-ascii?Q?x2R5bhLKBRiwU0f1ipPMhEpoBmd6gNtz9KyQx2BBHmM4h5EjFJAaL8Yo8ixm?=
 =?us-ascii?Q?wXBU7aoe3u3BSf5fom3COrDmeHAc/eLfFpg2F5bxrHzJjgWoDUgnvFOoCKar?=
 =?us-ascii?Q?/ThaE0YkJ60q6hhrvRy5CaPLDUkSA8BQdd8TSNwN12dHqIlG68+wF6duJVjZ?=
 =?us-ascii?Q?OgLVCYPmeWLsgxoV4p3m6kEJvCJPY4G9sefU+KTHY5Y/ybxbxQXmJtKKuiX6?=
 =?us-ascii?Q?HjqluFuWWCAezpCZYgl1W9hMELTMZIrP9Gg5LPXJRc4ozdjnV2oy/kubzlGS?=
 =?us-ascii?Q?0L9WZQUKGMNVnhwsARQ7W8DELiGJQ7MOZMVUA+JNC1XSAkWfO/xxx8LbGTSr?=
 =?us-ascii?Q?3151BeXVsNGP2qtmHftiBKw3RXkpyaVTYRZd+yhTAaMsVc3G7fTPbkkrJAwj?=
 =?us-ascii?Q?DWOkAXcLPyN+664xt+PDo+G+BxT5bf/7h/yWlb1SQ7Lsf+0/+m5JUd2hJ93L?=
 =?us-ascii?Q?qwCD6Fu/Mp4ABAbOR/54ZxYBZBhBb5iCXfp+/UsvYQvQwtoofDo9C50FWuzb?=
 =?us-ascii?Q?kXGYAGh1sdfTE51GqMaTypoult7dYuExpJsMWbi5ZSoHM0TL7uh0pmAJQKKj?=
 =?us-ascii?Q?xo7+SUx8je5W2r4/OHjtMk8Pcgqrjn0DGinJX6WK/kBt8KS6jdYX+mbhy7kN?=
 =?us-ascii?Q?FFRPo1S4lm6OW6QJ3TYe5zCz6HFALe+ZUklRRT5tYuE0vtrMJepP0p8Ei+cD?=
 =?us-ascii?Q?9nWvbjxnTsYobMQ0eWh4V0ybwVp3AdezqmigHvOjOF4xAQpLDna5cIQDIG1C?=
 =?us-ascii?Q?lkpjQ5wL2T0kuy/aJIY8g0aWMIY0TFmw/EhxuHHOdiLojc2si3Lh3atGGgJH?=
 =?us-ascii?Q?7oxCf1so1V/plfp7CwOkfba+ynwNdomrPDjAORGJ1fjUf4/dd/RayYZDXKeJ?=
 =?us-ascii?Q?VoA1CtF07HD8xBrTZNI5cEI+lePoKTrB9+t2a593KETyb3XVfKVEBoPG+u2P?=
 =?us-ascii?Q?zBnM2/HMkmJGh2OfiIkRlpVusvRhH5c03QLCL+P+Sj0Qlh1wZIgfvZ/GTZaD?=
 =?us-ascii?Q?q/AZhNdPw4fhvfKy6hUY0uOgbxyPUJEFxALeEkPCM4sAjdNNuyZ+HWC4b/Vs?=
 =?us-ascii?Q?Z10c42N46l8Pk/POH1Qhm20Bu5seBEJ6oKzV4Brk1AJsN80m73Ld90vdanh6?=
 =?us-ascii?Q?vL2P3AGxczc2JqAdLOgFXQWSkLxSj5yulB7dlbgNSC+s/RhrTsuCFv8s/i9m?=
 =?us-ascii?Q?ZtxjdGjUY9i8drAOmlwlFk+rES33nWLApDj1KGkd/Vv3GL9YK/pZCXduk38D?=
 =?us-ascii?Q?tTEAsIk98hh40jjYmnTZDfZr7UCkHQGFmt/m3ewcmYi3vJa+evkU8SesiXgG?=
 =?us-ascii?Q?jQmtftYo4guGTxQBhm9yBUTv5LojTp5fHi9HTEhupX/0dXH+a/v0oRXIX4oX?=
 =?us-ascii?Q?YuZzFY6LbBm77ciftYn022yOEQVVLVKMHVvpEIFGFQghc4QS1r1BNVsU6ar7?=
 =?us-ascii?Q?UFQpywQide3ak7/OVLjn/SaIBue3nyeVg0+e1IXDmzphiezTXGXSyZwjRGp1?=
 =?us-ascii?Q?O4ThTSmFZBravUgwflrCjOchlkc7V61c8WybGDEjupxqVkjU9Osin4zutZ1S?=
 =?us-ascii?Q?yJKpN7Syg6cQV2vi/7Kqcyg1P7GHI4XlFhLKKFTiIamIM2Zi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b701946-2628-4c5d-f707-08de586ff92c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:05:07.9781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czkPF9AjcHV8MuJpPrxZYmEzHaX4lTmCgTF3nnpqin3XG8+dPoKPctbUedFIhCM8VbI3WoeXK4EKsOwkMf04zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426

Add a selftest to validate the correct behavior of the deadline server
for the ext_sched_class.

v4: - cover full cycle: fair stop, ext start, ext stop, fair start
      (Christian Loehle)
v3: - add a comment to explain the 4% threshold (Emil Tsalapatis)
v2: - replaced occurences of CFS in the test with EXT (Joel Fernandes)

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 240 ++++++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5fe45f9c5f8fd..c9255d1499b6e 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -183,6 +183,7 @@ auto-test-targets :=			\
 	select_cpu_dispatch_bad_dsq	\
 	select_cpu_dispatch_dbl_dsp	\
 	select_cpu_vtime		\
+	rt_stall			\
 	test_example			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
new file mode 100644
index 0000000000000..80086779dd1eb
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
+ *
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops rt_stall_ops = {
+	.exit			= (void *)rt_stall_exit,
+	.name			= "rt_stall",
+};
diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
new file mode 100644
index 0000000000000..015200f80f6e2
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <linux/sched.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <unistd.h>
+#include "rt_stall.bpf.skel.h"
+#include "scx_test.h"
+#include "../kselftest.h"
+
+#define CORE_ID		0	/* CPU to pin tasks to */
+#define RUN_TIME        5	/* How long to run the test in seconds */
+
+/* Simple busy-wait function for test tasks */
+static void process_func(void)
+{
+	while (1) {
+		/* Busy wait */
+		for (volatile unsigned long i = 0; i < 10000000UL; i++)
+			;
+	}
+}
+
+/* Set CPU affinity to a specific core */
+static void set_affinity(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	if (sched_setaffinity(0, sizeof(mask), &mask) != 0) {
+		perror("sched_setaffinity");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Set task scheduling policy and priority */
+static void set_sched(int policy, int priority)
+{
+	struct sched_param param;
+
+	param.sched_priority = priority;
+	if (sched_setscheduler(0, policy, &param) != 0) {
+		perror("sched_setscheduler");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Get process runtime from /proc/<pid>/stat */
+static float get_process_runtime(int pid)
+{
+	char path[256];
+	FILE *file;
+	long utime, stime;
+	int fields;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	file = fopen(path, "r");
+	if (file == NULL) {
+		perror("Failed to open stat file");
+		return -1;
+	}
+
+	/* Skip the first 13 fields and read the 14th and 15th */
+	fields = fscanf(file,
+			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
+			&utime, &stime);
+	fclose(file);
+
+	if (fields != 2) {
+		fprintf(stderr, "Failed to read stat file\n");
+		return -1;
+	}
+
+	/* Calculate the total time spent in the process */
+	long total_time = utime + stime;
+	long ticks_per_second = sysconf(_SC_CLK_TCK);
+	float runtime_seconds = total_time * 1.0 / ticks_per_second;
+
+	return runtime_seconds;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct rt_stall *skel;
+
+	skel = rt_stall__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static bool sched_stress_test(bool is_ext)
+{
+	/*
+	 * We're expecting the EXT task to get around 5% of CPU time when
+	 * competing with the RT task (small 1% fluctuations are expected).
+	 *
+	 * However, the EXT task should get at least 4% of the CPU to prove
+	 * that the EXT deadline server is working correctly. A percentage
+	 * less than 4% indicates a bug where RT tasks can potentially
+	 * stall SCHED_EXT tasks, causing the test to fail.
+	 */
+	const float expected_min_ratio = 0.04; /* 4% */
+	const char *class_str = is_ext ? "EXT" : "FAIR";
+
+	float ext_runtime, rt_runtime, actual_ratio;
+	int ext_pid, rt_pid;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	/* Create and set up a EXT task */
+	ext_pid = fork();
+	if (ext_pid == 0) {
+		set_affinity(CORE_ID);
+		process_func();
+		exit(0);
+	} else if (ext_pid < 0) {
+		perror("fork task");
+		ksft_exit_fail();
+	}
+
+	/* Create an RT task */
+	rt_pid = fork();
+	if (rt_pid == 0) {
+		set_affinity(CORE_ID);
+		set_sched(SCHED_FIFO, 50);
+		process_func();
+		exit(0);
+	} else if (rt_pid < 0) {
+		perror("fork for RT task");
+		ksft_exit_fail();
+	}
+
+	/* Let the processes run for the specified time */
+	sleep(RUN_TIME);
+
+	/* Get runtime for the EXT task */
+	ext_runtime = get_process_runtime(ext_pid);
+	if (ext_runtime == -1)
+		ksft_exit_fail_msg("Error getting runtime for %s task (PID %d)\n",
+				   class_str, ext_pid);
+	ksft_print_msg("Runtime of %s task (PID %d) is %f seconds\n",
+		       class_str, ext_pid, ext_runtime);
+
+	/* Get runtime for the RT task */
+	rt_runtime = get_process_runtime(rt_pid);
+	if (rt_runtime == -1)
+		ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
+	ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_runtime);
+
+	/* Kill the processes */
+	kill(ext_pid, SIGKILL);
+	kill(rt_pid, SIGKILL);
+	waitpid(ext_pid, NULL, 0);
+	waitpid(rt_pid, NULL, 0);
+
+	/* Verify that the scx task got enough runtime */
+	actual_ratio = ext_runtime / (ext_runtime + rt_runtime);
+	ksft_print_msg("%s task got %.2f%% of total runtime\n",
+		       class_str, actual_ratio * 100);
+
+	if (actual_ratio >= expected_min_ratio) {
+		ksft_test_result_pass("PASS: %s task got more than %.2f%% of runtime\n",
+				      class_str, expected_min_ratio * 100);
+		return true;
+	}
+	ksft_test_result_fail("FAIL: %s task got less than %.2f%% of runtime\n",
+			      class_str, expected_min_ratio * 100);
+	return false;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+	struct bpf_link *link = NULL;
+	bool res;
+	int i;
+
+	/*
+	 * Test if the dl_server is working both with and without the
+	 * sched_ext scheduler attached.
+	 *
+	 * This ensures all the scenarios are covered:
+	 *   - fair_server stop -> ext_server start
+	 *   - ext_server stop -> fair_server stop
+	 */
+	for (i = 0; i < 4; i++) {
+		bool is_ext = i % 2;
+
+		if (is_ext) {
+			memset(&skel->data->uei, 0, sizeof(skel->data->uei));
+			link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
+			SCX_FAIL_IF(!link, "Failed to attach scheduler");
+		}
+		res = sched_stress_test(is_ext);
+		if (is_ext) {
+			SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+			bpf_link__destroy(link);
+		}
+
+		if (!res)
+			ksft_exit_fail();
+	}
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+
+	rt_stall__destroy(skel);
+}
+
+struct scx_test rt_stall = {
+	.name = "rt_stall",
+	.description = "Verify that RT tasks cannot stall SCHED_EXT tasks",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&rt_stall)
-- 
2.52.0

