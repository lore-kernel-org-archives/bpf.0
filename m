Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013046.outbound.protection.outlook.com [40.93.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCA3ECBFE;
	Tue, 20 Jan 2026 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946313; cv=fail; b=MTx8n4KQ1+nRjBe9dfag3ozbh4Q/DHxDSJjGhn2E725l5P4MR/IgEDG4QbRVvj0vFxdO8KD4DPmkinrOue85rxW1phO4F3vNa3irHg8s0KZ4ET8N+K/SBe74nCYxsvpmo5oz2WcVFis5GpoHvnqUgFSSbrnHTl3n250MBiSP6hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946313; c=relaxed/simple;
	bh=n86omlfVDr5NGOdqIU3p9hgCCgSUlN2AdCvKQDnA1EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YKaUVuCh8ij5D9J8V+ddNK/jwvvBo4EDcqRi76D7+7uh/yaSMSqFjW6vtcimDYmvqOAurWHlg9qHyE8sTHjV6tO0lxLUB64Vq35V61ExGvQ9AVU+drdc1+XAFGI14dWg/r8cMudowZkTy8f2ik73fo1rolbgyABlVcLx2LYNjfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UGgzelf7; arc=fail smtp.client-ip=40.93.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UGgzelf7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljO+sRtvdOWkz6V2zfaTC2NN+qhPv8RePPPfEi2//E31LysmtDCt/xCpJztvD2OX8abIbkLGZ7wibViGgWt/hugd0+tBwpHq2EFfRMST9SI6UkbVxZ/SehlQ3Vi+HQoU1/S1GUTmKL+mYUbIdAbR7AdhlbyEjSX9WYSBCw+TgsfspjVgC3X0ITgZ6cp5noVfuO9eAvFg4+wB+Oiylwq0zaKQTBJ528cLA00jH1ebJDQ1HJ4+2lYMO+rM5CEVDT25KWsBXJ7L8k/lL9uUD3uQSmwweYh4+1xrhocRxZJZFbJhcVPIYrk6f5nyCn9YoOtoUCmDvEOn8/psEzzUoECXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvHn0OqsDct1kPu3YlxzC2IxvwnaS8m9PLjrfPLC2+0=;
 b=m/nJp0lwXG+xZbvAbVTZFqcFdMsxa3jLqJdXr2snss7iBLU4TZ3I0aSn+cOz5LbCxJYLd8KIUJqx365BCGNOE2u195ya8jOE3pWzr+yvtJY2NvwRsD4YvqScgYuxwQCRwqf3ptk8a3xBW5+PYG0LzkO3vgUlTtukW+Hc5eibs27c68ViWb+O7ZQWY52Uv0uRuVGdJarfGov5CprxQYzoiMVrW6wDc7jPwqmhLbipzdOBBVajOKWf6gegIo61C1fw5+7wPesp+wQzkZlFqpv1RC9HOKYElkOjk5icBtJuGuss0Y/sG8fM1sQlBUdW2pRyIs8nlX2C8q3ySusg8E+20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvHn0OqsDct1kPu3YlxzC2IxvwnaS8m9PLjrfPLC2+0=;
 b=UGgzelf7mgR+2tmrZMx+bSnEa8Q/ZFqrvCzkztAD2icYpM6pwvq3jTN8/59HiwD1ImQPcHUVzWh6+o8BQyHcn8671Th5WlAQNGDlIY6PjmAw+w+SZeln/g/Z5zNqd7WEG+hF+a2l7OP1gVRTA58hrctPl08nIUOjxjcizAjx8uCtshqNJ+F7cQ2Efp1xfpSK39X/YRFjBNWDTBZyhdZVIm+6eEQKbcuZRV6l9H8t45u9njB//BAnwjJPDTV0W/qz5Rps8B6Xz1jfQil6FmLDvDgc9zwFu93PF+A9+iGxsRzjlBhslhOcMBABAYlhDCwtafnOwjUObvX6AteApdAzlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 21:58:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 21:58:24 +0000
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
Subject: [PATCH 3/7] sched/debug: Stop and start server based on if it was active
Date: Tue, 20 Jan 2026 22:50:34 +0100
Message-ID: <20260120215808.188032-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120215808.188032-1-arighi@nvidia.com>
References: <20260120215808.188032-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0028.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 34faf821-8d3a-435f-fd43-08de586f08e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ciu7UATIuAupy3prLe9/qJujYqsjtXwgEFqDVIZa/UPddXYXoePzqeRI5kGB?=
 =?us-ascii?Q?pu0+LaQe7YUSYS7W7cEV3YzAyoPzQt0wqBmG2a7H4EFVjgIL9hdkoHmlDgcy?=
 =?us-ascii?Q?Z7grOGQNbTzHIVBvvdHx6vUKAVh5AqDVYl9Qp4aqbvC8zqbhHi4RcuGVmiFC?=
 =?us-ascii?Q?J0SxgLdnpowPYXa0BHz9Ub/VB3+WP5DaO7nB9u2pts1x2K0xUJoP80D/Y5uZ?=
 =?us-ascii?Q?28i7oGff7OoG8/nugokbb+QOQc65c2YLxAHolJsPc6M40ZbEKkXrr3dqXaqZ?=
 =?us-ascii?Q?ZQm6b1SP4cgsfAIlfL+wH10Piqx7SRp8Je8EtWYDKezOIwX/Hy+BvgLtRm1x?=
 =?us-ascii?Q?2cD5MX5B0M2Ua7qzy8JY6SrYM5oUWulehmopDiFmemq01YcIOXYS85uXBX/W?=
 =?us-ascii?Q?qGX/iW7kviow/Ejy0fYgzkd8wqv2EYMfL5hgvjPx7GlYkK8hY8wX9HL/EdTY?=
 =?us-ascii?Q?vQouvwCgxH3+WfE4iQ2MWDw3cnKVmW9NGtaM7FPI8FzE6Vcx7cTWXF1L8XvS?=
 =?us-ascii?Q?TFrIKdt/318Gca7WFa1jpsV6TRcwXRKAoM8ay1a4P3aux3/HM3MdZt4Rvj/3?=
 =?us-ascii?Q?6tY4ToeRmsD+JIUrGwjINgVVpFJA/egmF/kZaYcoxTImFYHGNwVJez9Cb7jI?=
 =?us-ascii?Q?JcpoIHJY76Q8mtr4mTtV0BXR4dslcUIHqwLFZYt+oORiLokhxe23OlTt2xbf?=
 =?us-ascii?Q?gmylE/9gtQJXjlfItGYZD5dCATvLsjbtOBOAdJ6wUpH1gO0brSWr1WVviloK?=
 =?us-ascii?Q?1m8Se7m81P/GNNOHiUPrICODdTRvIX+8BdMfzHBKxe8Qjq8zYRfHgSgbElJR?=
 =?us-ascii?Q?JKSnDJzP21nDaRR+zAo1UT8hEWt0VVV5vyfB9FHBxlrTASiUw7Z5n4ha6KnY?=
 =?us-ascii?Q?8HPVJ6YkbBDmFik6uDvj2seM3tTRIyvi08jY79ZijPYyTsP48QTggJuFOYYz?=
 =?us-ascii?Q?01eQlDeYO/D7DnXOatsIIyawk15Ec90pPW9gyuTbT8VIuyk9QwyuHQUJoAG4?=
 =?us-ascii?Q?zW32qZ2Yk8uXanrnYpPP0Pnrcpx6l0+wEjoCt+nWMv+KwBg8ORy6L/oqyjYw?=
 =?us-ascii?Q?Fr891dDfH6DUfSNrG7OzjSYNU/w17mDeGnhc+H1UfTng+3zJR9WACrBbbfnc?=
 =?us-ascii?Q?aEuggSscrDIt+fpomHHrkS4iMnIn5ih8QcscMCWlk98YOKKeGmtDOnjaEFpC?=
 =?us-ascii?Q?VaUPG+XEiG5xjbiZCXjpGn/jxOecLIRl/PZHNxQIAJCzyWeP4M3lBu1+fGPw?=
 =?us-ascii?Q?mVepP/bus1KOWmFhA2wr7S8rcjUzjEBsf0HuTkqEml/+dvwizSo6dZtAzR+C?=
 =?us-ascii?Q?oYPF4HHZsXnLU9E5pE+zbBUQd0Y0HGdev42yJqAvdJsnnsNByMOJs9m67v9v?=
 =?us-ascii?Q?plaUaO/d7WvACze7Vy9gf71oAumdlYkMeX4SQPA3S2s2NR+Ze981655rBhbV?=
 =?us-ascii?Q?OUqbOivYjQIK0uZnw0cDgdiqwOfYaIHlAqcpkMxQn+PIJuLi7uHpKwP5T8Yb?=
 =?us-ascii?Q?yrExes4i2wWZ7YpkwlVy/GsMg3kUR/P9WQen06FDIDCqXWofFidgsoL6cxbu?=
 =?us-ascii?Q?SIFHK15n7Ru+nqQGUROThlxX+wSEizBZaxZXwqXcCZsllqNv9V5btReaNBt6?=
 =?us-ascii?Q?Cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VNO2++uc/h+wr6eKpFn0HVH5YRs4+RCECekL1LF8xDgXF+wQA1PFn7v/EFK+?=
 =?us-ascii?Q?HL4ivSKKekff6njVdUQeRHWHQxe4cNt4ojgeZGE5C/fhN9vBqYh9rtzbMHsX?=
 =?us-ascii?Q?2egOD/C3sJOvT+E5JAmulZVvfGwLvNgqvimhouRFvjjwRX1Z/gN8N3dVBox4?=
 =?us-ascii?Q?dwBZjhB83NrxFO0po3oV02Lspw/vUgXvs5OTEH/4UwdkBhQvKUB5QU8NDpTB?=
 =?us-ascii?Q?hmAJgOmpmYl00D7EvxUG2oBlgulGwYojxRxuStyfKqHS4aMBuLfpNNZ2rB+i?=
 =?us-ascii?Q?6cPRxzzxQo/LopwS+Y2y1wi/B9QBHE1cN5aTQo3B0f50uAybIRJ21Pd46Cj9?=
 =?us-ascii?Q?wjSbWwdGjphWv/ibH+ejZgUliawTV1Uj++Tw9d9CYkdo2ud6g253spInq4ka?=
 =?us-ascii?Q?pUHF10bYfY3tqu0lUXA/f337KgSQ7C/H9RBLpFyWxx/5G3j8koI1vxQW02b2?=
 =?us-ascii?Q?IN6z8WILChx64FdVLw3Z9vHys4yWQB+u2QcN5SQAM/1hYxXSq9EgLNVDJVjv?=
 =?us-ascii?Q?Vh/gDh4ofO77VQnZrjIzVp2V7glIOdSYwcrQCmRq8onXTv2cjZ5emxyyUG14?=
 =?us-ascii?Q?L8YSgZL+ied8rrA5vPNwzw9HDMamCbbDLQNepjqVVYOY1NKmg+pOg6xx9xZV?=
 =?us-ascii?Q?2UNRXHrT6LtyLlVJ+0T9ekZdHIg1OLy+pXRSOG3KxxMMI39Sy0rMKNJqtFli?=
 =?us-ascii?Q?53o0Tm49mfkABCwpkGUmuysq/j0VIzKR6l0tilzfZvPrJq4gyuwIHNhvJYtw?=
 =?us-ascii?Q?fvnLJIbNJjVGh6N6IhrlAV9Pyn+rwTsKhIgcdET1vFT6A3OzazAQLxeCRThx?=
 =?us-ascii?Q?mpA1pLoQQHFAqftHNrTYGQafekkRNuTrZyN9NqP+HmsOuOpR3x5Tjb4s+1mg?=
 =?us-ascii?Q?+pdCXziWLVjsdgd8l/eHz+oTsyLMvrT5bJuxTlCcKsqJV29HH8aIuuv4QKTj?=
 =?us-ascii?Q?VQ27crhfEBkmh2B9C62X+p7R02SzF6biaUEV72uIGQeAor9h7EqadD25V9JM?=
 =?us-ascii?Q?pvEOpaPFNLGCFKxJd1Ia7LKFYGJDjhauTtWWetOo6I3GowSN+Dcu1dBcIXru?=
 =?us-ascii?Q?79f/H8wTgkSxVDWPs979R+Snwuh6SM1nOaqHlPmk9OXrGTHmw34GwyK6dYOq?=
 =?us-ascii?Q?pSWtBtHfxQZikri21atWtR5XEaaHd5LCk8aIcs0yDJi1FVZQlMSU8/oHDJIz?=
 =?us-ascii?Q?SZtcGzn9bZQhdTEa1tMmtMmq/cE73Wy9AZnrViY4z+7CrpI5BuJiKUXQjVRM?=
 =?us-ascii?Q?gYSyPw79xXsi9xSkCuEqxoijAKFoKfwooFjDa4vhTmL697332IkkkC8yrRPV?=
 =?us-ascii?Q?sQ4yLXJQ41uyZfA8vXH/4+UMZl6Y9vuJIDPbrWHiCuxXropOWYo0qf58nkeg?=
 =?us-ascii?Q?ETD7MUqYyIzM+qwGYogInsDjnlr+/g/j14vtH7BX+dAKUYIPgND9d8aJEGwF?=
 =?us-ascii?Q?1e+l83h40UIV4jFD/Gy7qMBbPRVy0lTYH9wZgZam6RhAurMAPBR/5nz2Eanz?=
 =?us-ascii?Q?/Bdfo4Hj3ueseB8WyTjpj8YerCKIsHSXy+03nRY5S8JyGIOfb3Ggn39RNM3X?=
 =?us-ascii?Q?Xho29nr5L4NiI1eQo9GoVQhs98q8h8/cPbkZ0rlVsYhVL6kcmAp3Zb13h356?=
 =?us-ascii?Q?5w2qnA1zIvxqevZlvscTtDhIkabe2s/IN8Pl2TB6b1yKrfIMAqrBNom5oMvI?=
 =?us-ascii?Q?6rb4pM32HAxD72AxCy+SJCLJuh4oaAhSrl3sz++C7QdbsHgK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34faf821-8d3a-435f-fd43-08de586f08e8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 21:58:24.8896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UooREvH9FvoE8LdrXTd9EtYfzqcENlU11ZvW6gJLgHCjJtaTLzlw+p8KNr7ZU5b3kT4L/sJ42UVbh/kp8xh9PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101

From: Joel Fernandes <joelagnelf@nvidia.com>

Currently the DL server interface for applying parameters checks
CFS-internals to identify if the server is active. This is error-prone
and makes it difficult when adding new servers in the future.

Fix it, by using dl_server_active() which is also used by the DL server
code to determine if the DL server was started.

v2: do not start the server if runtime is zero (Juri Lelli)

Tested-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 93f009e1076d8..dd793f8f3858a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		return err;
 
 	scoped_guard (rq_lock_irqsave, rq) {
+		bool is_active;
+
 		runtime  = rq->fair_server.dl_runtime;
 		period = rq->fair_server.dl_period;
 
@@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		update_rq_clock(rq);
-		dl_server_stop(&rq->fair_server);
+		is_active = dl_server_active(&rq->fair_server);
+		if (is_active) {
+			update_rq_clock(rq);
+			dl_server_stop(&rq->fair_server);
+		}
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
 
@@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (rq->cfs.h_nr_queued)
+		if (is_active && runtime)
 			dl_server_start(&rq->fair_server);
 
 		if (retval < 0)
-- 
2.52.0

