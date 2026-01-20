Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8E3ACEE8;
	Tue, 20 Jan 2026 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946726; cv=fail; b=mYO6CfBqAhCjyp9cQ0W7eCO2BDklhT+oP8nPV4pQRmf0UR02gkv/XuWMlEbL+MDPgV4idbmOopVD/WGHY6MJSiiQ+P0qdyxMbwZ0jZftOt5Ew4OyRpL+zByM6SrAhOra+/b5JKYkvK60CK37ysShw2VcMpYQkCBOhbvpQ9fHVig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946726; c=relaxed/simple;
	bh=pxtIph5ywH5bmCOcHDGLs1LRJ6U7WyMykoX9z7nJWnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=duWZB++YSwGIWujIRMz9bTUp4hEaU0wNKprN0d896ldYeh6RQ4fpjt9c6EK2MfvT8AUQlUWpzLyRmiB1vEZA4EXIbFKn3uyDHcAW45asBsefSMOiHVO6JrKa6Vln7LrZJCU+qZg6+1Ks1Pvwq4pKkNLxMNKas80GPezuzll9nOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EoJtxebW; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EoJtxebW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuIeL4nSxg+rkgNEJYJOikz4wIw0OAP3Kd0wC4+OEs1E8TU2SjozUINTzjvayiqD1YeRwhIEoTbQswvgtBTRFiDgVCmaUwxGXOKAItX2JQzjIJE9lKjiTy0aEAVr9Cycl2obQzX6bkvn24yZjjLFLKLXR4R68oZTCAkX1f9q8UJVkPFVcA1E4DJ0jQdIGR+P62t5FBriPTJrL4y+TWuZJm1CAKUElc9/UAc7STKzb0ZvJbaLTE0/HWCvtqraptYbj0VG02mLSBHm87dwxqyK8pv0wzfqAi/Tc19jnedvUp1bQ8yYcc+q541PgLBnwfhISwL8IhqK90bjm5pLS8G/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LxFezwLGhXEzaV1EksqyJT18XWufpOXpI7WL6qS2wo=;
 b=JDHyuD4cIeUTm06QBdaLmp6VsVn2d/w0BA3JSLK4hoWD4+9CjZIf/MstsJMuLHmN8cZ28o3ARzaDeGGiUfbWTuJeOExUJYGKuTvTaKooQIrXFwWIZNBMBloXx8HJcAmaxD3gA7igRMl+e3XNfMVHDZEg+/+D+YbuFvZF+bCYRdc3oPVCECM14qxaJjjCPTXEiCMZWUkB+jwOQoA8dYl912Oi6aZjFoViLyjIIMgq9I066U0X182BuX23K9/9yp+q66Aoo0sthCKK72oyMlh5aD3NgE4sZJdJr2Xl0t/ulQ4KU0G+KzHra1CjrUPK7K6Gs1x8seY8rka0LLie6DiGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LxFezwLGhXEzaV1EksqyJT18XWufpOXpI7WL6qS2wo=;
 b=EoJtxebWy0EeYdenHSfMBaQhRM4rIdWC9s/3X18vJGAgyKIlRBwwOJvZw1hYjR6QFDL8Vwop0grXnZAa1kI1NHUdzGHRcEhyYqF9Af+QwutOoubIqQNOQ4AuOCLyx1ZjvllOsBJsHY2B+avCTBm1+EhhSntns7iUjUEy/9Xl2xN2oK9DMb3IbnKq+cz98E0WDJqwWQ8GR3WGW1igAIzLBQaJzq4KkphO8+MjcP9TprqOdJgHBuai65U1+kGTSLmk5tPLco+24RlhYSLJNCiJfIhwxQVw66pAItNhY1HaUwD3oy487e8FwCEhmBDu0kI3KhTz857wuyYb8Este13k3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 22:05:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 22:05:11 +0000
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
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 7/7] selftests/sched_ext: Add test for DL server total_bw consistency
Date: Tue, 20 Jan 2026 23:05:02 +0100
Message-ID: <20260120220502.190159-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120220502.190159-1-arighi@nvidia.com>
References: <20260120215808.188032-1-arighi@nvidia.com>
 <20260120220502.190159-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ab02ec-4988-4850-c3bf-08de586ffb3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kk8oa3y/4A9RW/AX4CC9B3sReefmq/lPAsm4OPKbCSPiSsAM7wFca/CNyZjt?=
 =?us-ascii?Q?eOW/C5HaJP/hT0e3Guc+Aq1ugkyaQQTfdDI1tJ/42ivc4HoaQGr3/B85tlr8?=
 =?us-ascii?Q?5YdbYxVOYzOXm4mqWtwWZZB/CI6E3nav2Ky2ThnA27NCOkKc9dp0AGgvx7Bl?=
 =?us-ascii?Q?Sw0Fh1FVdrPY+WIYu2fUiDnPUr3OYDFn4YeOwoubuUsMqIZJTTnwqQ36Yc6b?=
 =?us-ascii?Q?ODgxaST2fSg1orlaLAgS0D4NgHfshr6FEwGXMHEy7UtxhOgrBzKqecU0gIQL?=
 =?us-ascii?Q?/pBpVa4osJA6ERlJs5yAj4rxq46gHAK1Qz2oJMFPLjgF0B6TcXgtiiBnoUQF?=
 =?us-ascii?Q?g79yZeZEDs6gtuPvU5LavTnvAna0Wh5OCNNB+aVkog9CBy8t/vlWaKPIeIbV?=
 =?us-ascii?Q?mLLnSpANtKOBrt9oBhANQbpEJm3s3oeLbokIvKqvPzDI0UKxiSObOhNGOwas?=
 =?us-ascii?Q?jBdnaTB/WzlTa2cnAVhMJRpGW/j6cZJlOwLc29Ze6fbWb5VB3O5ScoHOnlrN?=
 =?us-ascii?Q?dvJ49aWCOjkKYceXsIMmIMjeI22383cx1O5rWHzbRqWN+hRI4EF2/4QDl3x2?=
 =?us-ascii?Q?yEm0Pc5HvQFR419fgp2b48vtYdhWjt37Jli1DnukPXWE+PpJ6WUbkLoDp5Fe?=
 =?us-ascii?Q?7AIXisV5zDxkWZ+o/u91JyRcohp4/SeSighX9cRfNHGwF5X7YjCePzFYg8n3?=
 =?us-ascii?Q?uPkFBpByLdf3OkShb4TF9fZgW/gX1bnDvNRg8oswBqQ0zUcYjjSg6mlaacK2?=
 =?us-ascii?Q?KnUo8Locth2smwnhrIuDi+WFzHM98jcevAO4+ysNB2SSo9NPDnA2ag8UUgJj?=
 =?us-ascii?Q?Yf3CGEibuZluJrB4672JgJ4icngI1Uz/DFYRkUwZfjVHONsspBZWfbixfIp3?=
 =?us-ascii?Q?Fm22dHKAXY0t6n5Ygb+y8QP6PdKp/jrzuBX1xhXMrztfCUh9ZCAPmuRWAw6g?=
 =?us-ascii?Q?HXFDB/EA7+qgYh5iQt4wemMXn4yiYRt4MTGmIvGo6q1hMWM5MYpgt/d//Bgo?=
 =?us-ascii?Q?jSrfbgKqPq4PJNPo0oyl5Clj+1sV2xtjYFRyuaUlbYg0MEugS+g/XiSCjQYE?=
 =?us-ascii?Q?ANycw7L5osjCIbLWc6ZyzfmqVQwiGOlBQU22pdse/pj8zBXeSYpFdiNUjjw6?=
 =?us-ascii?Q?y5fxbkzIyEgrlyLju1GVgCBifwd81ehanihGT8CggpLUBkaH/ccGkjC7sN75?=
 =?us-ascii?Q?10k0YpsI4nLdcuWdAkmYrfZw0RQcCxp5Q0rWA+uptO0iPxdMuQgpAEcHXnKx?=
 =?us-ascii?Q?c7lnvkeg56sWPmUnH3CyrGfqCC0IbKO3oLt1tWAtxtsR+S2GiP74KuGudKr+?=
 =?us-ascii?Q?04AkZMOGqw7YQ0cgOnngTdNSgMj5SpY3md3bKVjr5z053VQiMr3qkM7qdnFA?=
 =?us-ascii?Q?9MxQ6M+Fu1jrXfglDJPnIGrsxfBuPYxKE+vtMFAxkEnlJp9iMnMGd1XtJft8?=
 =?us-ascii?Q?peuCidfw2owAjPpmvNSMf/hRebqF3p+kOYSbTssrL2F95AoDsH42APkL0Jre?=
 =?us-ascii?Q?AmBcyknFatUL+LRfVPc41Y7RggEiAXZxzE6Gp9kxQN4hgyLh37pY4T7rgZHJ?=
 =?us-ascii?Q?h6sx5/q3gOY+vZg9iJcsyVPL9aGTBNqGnYP0HOM/5ac6yGXSAkPCjeOGV0Sx?=
 =?us-ascii?Q?TQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oqh5L4wFBuSExVNNuvhIpzDJSI+v/yNeqpbPYNt7j+VswcAtKgOMWSFT8Sue?=
 =?us-ascii?Q?jV5umhgzIo7CkDjQ73RoSjf7eNyVYK1nEkFavC+58Ez4j5wTubEbcr5amqz2?=
 =?us-ascii?Q?Mny2ZbD+VAJKhPxZY/9p5hGcjP//Ongc+6cXsKy8Xn5POJdZDwg5UA+AnbEJ?=
 =?us-ascii?Q?qmQPc9xIuC9kmMzc80CR0iajVXgpUyTe68MGejDaXvBdm677lcxnL5iVbTAA?=
 =?us-ascii?Q?ZmCHPTLHfA+ZZEh54j/5cRzfXMfl7Vz5R7xz+1SGVHpgO+3JsBQiGxau/iFw?=
 =?us-ascii?Q?CV01u61dYv0fyEhgY/WttGxb7ituXIi6oOXD2HJX2NR0Xnu/8Bb+4O/oa0eJ?=
 =?us-ascii?Q?neQBVTk2Jib9Nmp62RSRdvXfl40IMONFCVyVveG3XonSmiqF5Pb2W5qlOAKM?=
 =?us-ascii?Q?hhFX/2URC2Dqpvq2GtAzVAxlgOqCUe15ZgPXVLXd6t3YZ9bl2SFvv1tQCCq8?=
 =?us-ascii?Q?FXYyohG3OKFcpS6zTPhJMnjPZsVbIQoLvR0YzUYAPNCTJ07Jm8baBzrjodcU?=
 =?us-ascii?Q?suau2poZCpH74NEEfYEzb4+s4i7EYRvVR0cKOEJ0Hf105LE2dY1Ch4TJ9Ti9?=
 =?us-ascii?Q?A7y7u7uMlc2g47Ia9uqyGJaxUyt4HNAc/rm3oFUayU8NG0N+KKPi6huE/UPf?=
 =?us-ascii?Q?tlkbr7KKaicnHM+IGOEaLLV+2ClehugOraylDSbBjfcNW6I6VTKO3pV0x3UF?=
 =?us-ascii?Q?v+vTrK06Ha7evCVII5Wpgdem+/1zGQAxCyGyxouCvxvIRwbTzrlzWpdvYrVd?=
 =?us-ascii?Q?72e63In8u5YfTX4vXaUuc1ZrlQPT2mNOUw65HlrL/oHtrb0IpVYPzClSH6Ri?=
 =?us-ascii?Q?e6T/3iME2CDVgvK98x+vXSPz6T90Q6e6J5oLlI7zXvMIBmtHo0YlphFaIYK4?=
 =?us-ascii?Q?IPnWYqJFiE/Odd3WDf0LoYVn7WE6Ys32kUKJC0qdOknEX9k2pPb1sLLhJWOJ?=
 =?us-ascii?Q?UEdtxd62MJ+28kg2qhQCcs00rcX/+7S+Zc6L6ssuaoKIOLqnYaNdEpChZIr1?=
 =?us-ascii?Q?BsQE7nkbiThMAIslg5uHFB2BI1YfPVxSI9/EUGVN1VKy88tTh28r+isSkmhI?=
 =?us-ascii?Q?kGvUEq0l6/yQSu8RhmQv895K2FbHXiYcEPUlLiVoFE3a3MP0dvIwUfVLIrgh?=
 =?us-ascii?Q?0/2Jiybx4tY43GeqZv10FmDHoEfp1fZxofRmfm1VHyomfORlivfv5aoZU0ot?=
 =?us-ascii?Q?5FnJ1VkQEuIwWcfRdhjvsezVX6ddPSM6gWllG4QUu4nbkYkpW1pR4wmAjZHK?=
 =?us-ascii?Q?7TMspno/2nGVwwvn5jlyeNLEKYMG3Q4r+xkODopYyWZ43Amd0lG6//iDSP6v?=
 =?us-ascii?Q?fkGKjHNSZNYc5MFfh5704ZsQcdfHbvKhovtN7tlKB2tDy+v4Tjhe1S0g0G+H?=
 =?us-ascii?Q?Y/UdaLlqVO1qFMqtfbrFKzJdWpt8ZW+CZ68Zf3cLC6Xd+/t1VrrAPA4eqluX?=
 =?us-ascii?Q?O93YAFuEYqaY1oh5N4HhEqQi0rYBNjoMUmpKj0n8Epyd+oFSxkeN346PtJUl?=
 =?us-ascii?Q?nvTaiB0MV/6Cp0ejitWJUVd0YI6gBiadbeFg2mNK/4hxD45A09EGEywViZYD?=
 =?us-ascii?Q?FQRpYglZ/bCWV5GdoL45EhIRth0f/8ULMiBdsaIEzJOPCfj/9gEmP+H3NncU?=
 =?us-ascii?Q?iCBLygxqxNnKQR1E1olOTvawkWfA6L3fYTNAU6kaopK/WEUog9jUeU+edqC6?=
 =?us-ascii?Q?R1xzbcjg8VRJ6MdeJ6kq/5Y95wPxiH/LNme95ED1Cq1q0jRZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ab02ec-4988-4850-c3bf-08de586ffb3f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:05:11.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVWKhqXNpUwmVkYzfnwlI1IHezPXEycPAs1fiHG8yidCIs4wmcTVfCqT9pI927sdimaSNguHXvkeAjgv8Bsw4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426

From: Joel Fernandes <joelagnelf@nvidia.com>

Add a new kselftest to verify that the total_bw value in
/sys/kernel/debug/sched/debug remains consistent across all CPUs
under different sched_ext BPF program states:

1. Before a BPF scheduler is loaded
2. While a BPF scheduler is loaded and active
3. After a BPF scheduler is unloaded

The test runs CPU stress threads to ensure DL server bandwidth
values stabilize before checking consistency. This helps catch
potential issues with DL server bandwidth accounting during
sched_ext transitions.

v2: - small coding style fixes (Andrea Righi)

Tested-by: Christian Loehle <christian.loehle@arm.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile   |   1 +
 tools/testing/selftests/sched_ext/total_bw.c | 281 +++++++++++++++++++
 2 files changed, 282 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index c9255d1499b6e..2c601a7eaff5f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -185,6 +185,7 @@ auto-test-targets :=			\
 	select_cpu_vtime		\
 	rt_stall			\
 	test_example			\
+	total_bw			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
diff --git a/tools/testing/selftests/sched_ext/total_bw.c b/tools/testing/selftests/sched_ext/total_bw.c
new file mode 100644
index 0000000000000..5b0a619bab86e
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/total_bw.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test to verify that total_bw value remains consistent across all CPUs
+ * in different BPF program states.
+ *
+ * Copyright (C) 2025 NVIDIA Corporation.
+ */
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <pthread.h>
+#include <scx/common.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "minimal.bpf.skel.h"
+#include "scx_test.h"
+
+#define MAX_CPUS 512
+#define STRESS_DURATION_SEC 5
+
+struct total_bw_ctx {
+	struct minimal *skel;
+	long baseline_bw[MAX_CPUS];
+	int nr_cpus;
+};
+
+static void *cpu_stress_thread(void *arg)
+{
+	volatile int i;
+	time_t end_time = time(NULL) + STRESS_DURATION_SEC;
+
+	while (time(NULL) < end_time)
+		for (i = 0; i < 1000000; i++)
+			;
+
+	return NULL;
+}
+
+/*
+ * The first enqueue on a CPU causes the DL server to start, for that
+ * reason run stressor threads in the hopes it schedules on all CPUs.
+ */
+static int run_cpu_stress(int nr_cpus)
+{
+	pthread_t *threads;
+	int i, ret = 0;
+
+	threads = calloc(nr_cpus, sizeof(pthread_t));
+	if (!threads)
+		return -ENOMEM;
+
+	/* Create threads to run on each CPU */
+	for (i = 0; i < nr_cpus; i++) {
+		if (pthread_create(&threads[i], NULL, cpu_stress_thread, NULL)) {
+			ret = -errno;
+			fprintf(stderr, "Failed to create thread %d: %s\n", i, strerror(-ret));
+			break;
+		}
+	}
+
+	/* Wait for all threads to complete */
+	for (i = 0; i < nr_cpus; i++) {
+		if (threads[i])
+			pthread_join(threads[i], NULL);
+	}
+
+	free(threads);
+	return ret;
+}
+
+static int read_total_bw_values(long *bw_values, int max_cpus)
+{
+	FILE *fp;
+	char line[256];
+	int cpu_count = 0;
+
+	fp = fopen("/sys/kernel/debug/sched/debug", "r");
+	if (!fp) {
+		SCX_ERR("Failed to open debug file");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		char *bw_str = strstr(line, "total_bw");
+
+		if (bw_str) {
+			bw_str = strchr(bw_str, ':');
+			if (bw_str) {
+				/* Only store up to max_cpus values */
+				if (cpu_count < max_cpus)
+					bw_values[cpu_count] = atol(bw_str + 1);
+				cpu_count++;
+			}
+		}
+	}
+
+	fclose(fp);
+	return cpu_count;
+}
+
+static bool verify_total_bw_consistency(long *bw_values, int count)
+{
+	int i;
+	long first_value;
+
+	if (count <= 0)
+		return false;
+
+	first_value = bw_values[0];
+
+	for (i = 1; i < count; i++) {
+		if (bw_values[i] != first_value) {
+			SCX_ERR("Inconsistent total_bw: CPU0=%ld, CPU%d=%ld",
+				first_value, i, bw_values[i]);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static int fetch_verify_total_bw(long *bw_values, int nr_cpus)
+{
+	int attempts = 0;
+	int max_attempts = 10;
+	int count;
+
+	/*
+	 * The first enqueue on a CPU causes the DL server to start, for that
+	 * reason run stressor threads in the hopes it schedules on all CPUs.
+	 */
+	if (run_cpu_stress(nr_cpus) < 0) {
+		SCX_ERR("Failed to run CPU stress");
+		return -1;
+	}
+
+	/* Try multiple times to get stable values */
+	while (attempts < max_attempts) {
+		count = read_total_bw_values(bw_values, nr_cpus);
+		fprintf(stderr, "Read %d total_bw values (testing %d CPUs)\n", count, nr_cpus);
+		/* If system has more CPUs than we're testing, that's OK */
+		if (count < nr_cpus) {
+			SCX_ERR("Expected at least %d CPUs, got %d", nr_cpus, count);
+			attempts++;
+			sleep(1);
+			continue;
+		}
+
+		/* Only verify the CPUs we're testing */
+		if (verify_total_bw_consistency(bw_values, nr_cpus)) {
+			fprintf(stderr, "Values are consistent: %ld\n", bw_values[0]);
+			return 0;
+		}
+
+		attempts++;
+		sleep(1);
+	}
+
+	return -1;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct total_bw_ctx *test_ctx;
+
+	if (access("/sys/kernel/debug/sched/debug", R_OK) != 0) {
+		fprintf(stderr, "Skipping test: debugfs sched/debug not accessible\n");
+		return SCX_TEST_SKIP;
+	}
+
+	test_ctx = calloc(1, sizeof(*test_ctx));
+	if (!test_ctx)
+		return SCX_TEST_FAIL;
+
+	test_ctx->nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (test_ctx->nr_cpus <= 0) {
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* If system has more CPUs than MAX_CPUS, just test the first MAX_CPUS */
+	if (test_ctx->nr_cpus > MAX_CPUS)
+		test_ctx->nr_cpus = MAX_CPUS;
+
+	/* Test scenario 1: BPF program not loaded */
+	/* Read and verify baseline total_bw before loading BPF program */
+	fprintf(stderr, "BPF prog initially not loaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(test_ctx->baseline_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable baseline values");
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load the BPF skeleton */
+	test_ctx->skel = minimal__open();
+	if (!test_ctx->skel) {
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	SCX_ENUM_INIT(test_ctx->skel);
+	if (minimal__load(test_ctx->skel)) {
+		minimal__destroy(test_ctx->skel);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	*ctx = test_ctx;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct total_bw_ctx *test_ctx = ctx;
+	struct bpf_link *link;
+	long loaded_bw[MAX_CPUS];
+	long unloaded_bw[MAX_CPUS];
+	int i;
+
+	/* Test scenario 2: BPF program loaded */
+	link = bpf_map__attach_struct_ops(test_ctx->skel->maps.minimal_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	fprintf(stderr, "BPF program loaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(loaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values with BPF loaded");
+		bpf_link__destroy(link);
+		return SCX_TEST_FAIL;
+	}
+	bpf_link__destroy(link);
+
+	/* Test scenario 3: BPF program unloaded */
+	fprintf(stderr, "BPF program unloaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(unloaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values after BPF unload");
+		return SCX_TEST_FAIL;
+	}
+
+	/* Verify all three scenarios have the same total_bw values */
+	for (i = 0; i < test_ctx->nr_cpus; i++) {
+		if (test_ctx->baseline_bw[i] != loaded_bw[i]) {
+			SCX_ERR("CPU%d: baseline_bw=%ld != loaded_bw=%ld",
+				i, test_ctx->baseline_bw[i], loaded_bw[i]);
+			return SCX_TEST_FAIL;
+		}
+
+		if (test_ctx->baseline_bw[i] != unloaded_bw[i]) {
+			SCX_ERR("CPU%d: baseline_bw=%ld != unloaded_bw=%ld",
+				i, test_ctx->baseline_bw[i], unloaded_bw[i]);
+			return SCX_TEST_FAIL;
+		}
+	}
+
+	fprintf(stderr, "All total_bw values are consistent across all scenarios\n");
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct total_bw_ctx *test_ctx = ctx;
+
+	if (test_ctx) {
+		if (test_ctx->skel)
+			minimal__destroy(test_ctx->skel);
+		free(test_ctx);
+	}
+}
+
+struct scx_test total_bw = {
+	.name = "total_bw",
+	.description = "Verify total_bw consistency across BPF program states",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&total_bw)
-- 
2.52.0

