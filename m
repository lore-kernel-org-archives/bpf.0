Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020127.outbound.protection.outlook.com [52.101.84.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6313BBFBC;
	Fri, 14 Aug 2026 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716606; cv=fail; b=aMhIlbgiSxhemHI1+YTPNqhIF5bL1fY03hYMVO4ScDcqWJoBtYwnKCaFINL3QMnDtZFjSKlilGkXl7wfDlumY5QAqEarPIt+qPb7/laCG4yM1wRPqg3lq+LrdNIiE7dmyKekaliQbH7n9ym3V0egIrhvq7lF7HSavF4/mTSNMZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716606; c=relaxed/simple;
	bh=lOiMaErBBuubkyLxmmCrvzbF/WWMEGnLTJSCE/1N+bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HokH5mWnqpN6tfuWEGKYNdt/XuVj6NKFeEouJY5fOh/186F9yibzZaDQPIvOO2T9egCTDoiFaC4dDh7AliDvnLPFeeQ3uG74XE6oGRkm0DxRH5GUrbNLzsWO3u87FGOIsyquzMDqZ442l0mff0vbt5w+8uXYn3uB1btYcnwmMYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com; spf=pass smtp.mailfrom=btesa.com; dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b=tGKDcQe/; arc=fail smtp.client-ip=52.101.84.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=btesa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b="tGKDcQe/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRwD/ry1eRF5ZApw6wLnTTpNhavWJzZJUIjBFq8nk6KyYtByjS1jCKJLKfaFBMHezSmYmcBwrVEPLzMGXAeZ+yarw4uQgGYVffyZvmhPnx/2eeVli5kLyJXQvak4i81qwSuKiTNG9G97VXXCyvA4TNyQuhm9VmkjawTjQ/tN0IQvNc8AQR3zk3b4Imh0nSuDKTxdjc8Y5xZH+95Zvjcko+NXyASd8qK/g+r9KTgvF6L8VYJBwCfYyJnbV0z0PYksY14O9THYcHCFSSwvMiuHV3yZXVrZ6ESz9Z2RwqH36Iv2R1uq9r4G90FCQzS3MzIJa2iuNJz6tbnvsPmUCb4OSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOiMaErBBuubkyLxmmCrvzbF/WWMEGnLTJSCE/1N+bE=;
 b=tmX2X/f/84VVsLlH8kxMmog8YGzNMkk1q43mcpHMVWCsLQFzXL5hxRiIGumi34b+drSbq057oRgKEQ5cBDaez+Dc9/uUHrmi8K5lXa2KvEEwI+uUaak1d8bF6XPwVaDthRMYD9UJq8ibi5U9spQdpO3E+BTGb4DHFYKUBv+M7X3noBDjmRrMBJbILZWXcaqGFXr2jJ3A8I2tmVD06Z9qg9zLSeL9/QpAPPE03eBLJd5oNvVz4REEKgsI7HEXiYKSDX7OfNrpc82juI0qOqP7iZS3r3ERZrOmvcc9hLYodWxMvSjoXkMoqX8hZVqbAGM9KM3aR/wGcHh9Sfe9FKvaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=btesa.com; dmarc=pass action=none header.from=btesa.com;
 dkim=pass header.d=btesa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btesa.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOiMaErBBuubkyLxmmCrvzbF/WWMEGnLTJSCE/1N+bE=;
 b=tGKDcQe/xsunlKsZk+xlQCZp3D5ldBJ45H8sv/aqCSZUW6UFU0tpXTT7dCYmok6rvc3p7J6MHXr/KsCWMCvJgQs3eIl0cHmuQLH8qDWOVi6aP4JbMMy0If0rb+67PenzgUzrdzAPqDPWV/+AbxBM8G4D75nKEW6kmle0h6/rw7so44YK99+fNPNW1Txn8Q0l/AKBJ+tuK9OhkZ7TAx0e8nZzZNYZ2Dd1nHyG5W9FUQhgh6yInWHL0Sn5/FJs16oihOP9XsyRoxJOBLf9gOLMQn6ia6A/eq9lbcXJd5Pt1nTydc9yD4HbJfCx7XhZ6/E7fiLAPQBVAX2tCqk8j3DC7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=btesa.com;
Received: from AM6PR07MB5384.eurprd07.prod.outlook.com (2603:10a6:20b:80::25)
 by VI1PR07MB9994.eurprd07.prod.outlook.com (2603:10a6:800:1dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.3; Fri, 14 Aug
 2026 14:09:55 +0000
Received: from AM6PR07MB5384.eurprd07.prod.outlook.com
 ([fe80::b45:9ec:1126:f27e]) by AM6PR07MB5384.eurprd07.prod.outlook.com
 ([fe80::b45:9ec:1126:f27e%5]) with mapi id 15.21.0339.002; Fri, 14 Aug 2026
 14:09:55 +0000
From: =?UTF-8?q?Israel=20T=C3=A9llez?= <i.tellez@btesa.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 bpf 3/4] bpf: Read producer_pos before overwrite_pos in ringbuf_avail_data_sz()
Date: Fri, 14 Aug 2026 16:09:36 +0200
Message-ID: <20260814140936.24188-1-i.tellez@btesa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814124843.22041-4-i.tellez@btesa.com>
References: <20260814124843.22041-4-i.tellez@btesa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0182.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::18) To AM6PR07MB5384.eurprd07.prod.outlook.com
 (2603:10a6:20b:80::25)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR07MB5384:EE_|VI1PR07MB9994:EE_
X-MS-Office365-Filtering-Correlation-Id: b573d238-8a54-4e72-234c-08defa0db79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SDSNAQQkprI0GVytG4Zxxx66YAmoUu9ncfQ1KSarcYsndBiurhkOG6j8oCa8ILY5sBZ2jJa9Lu0y3Vh2YErVPNxn2bRujw01vrzSqxFre+11BbNn7oWLN5pYOf2qLPbi62bRNYDBbF9WFrAst7FupvRj7h2SrWPK2rDTYW76G+X4Gun1v9eC30PevG54ivz8vhQ1j5lQA+Etl/bTe+RcQCbufkkxPQCVazI8MzjovyhgBgpwT8fYNidyGh+Ggmhoy8XLQgwnnsMNR1C79EkjrolFTbvKU+d/RUFmKVscdIANTVLaRBh+T5Gh0U9S4rsxczsobXYE0Yh2wI4DYM1ynuo33b/UcafSjWBtbJGaFXWrhCU6sq3txrWRB1ujHs9jBOmGlCk5UzVesgD+QbYtb/ZI9QSMUQ+YGzylrMTjunolzpNBI4QNypXB5JtebGGOhJz34x1tMhtcVpnejS2FpGS44xj/kOdiFyJ7eNLnhrbfyEwWfv2E7MYFGhf1hkAr0wlWvU6YIfcctXiO+/gnNneHPmGZTx4ciLHacF+K077jVFkwsr7PSBpF9Xx7abTy+Ese+nJIkLpSu7OjrB6HuZs7x2TqCIIfnjdoyMp1+L3KeXJEndLhA7RarqB/JPJYEXXkB2CGV51kXfdrzo9giyrLYFH7XbOJWPV7iL1d/WaX6/4QUCi51S+MzIPuq95eEYs07tnInWjfHhwGN90AoPbEXBavwkaVfPlfzbZem2Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB5384.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lKBjag6issysdEXTA98CpiDBes/tX0RsB4+DwhIVkgd942pVpNj4ppcCpshP?=
 =?us-ascii?Q?ufP4J+4EclPjIe82+bmporWblj4vaCCcZzydSrl8Oti1EZ7JzLsh22oLOLJt?=
 =?us-ascii?Q?Vpiie9Ly517Q8WueUq8ccKESBan7ikdceAWdfNdl7IzZywK1+03R+u2YYUhx?=
 =?us-ascii?Q?WrvlUf82tIaNl3+qcIKYGhZssJKh07uBJ9D27JIRurmI26Ro2BXj0yMc9Gx6?=
 =?us-ascii?Q?CQ9aq1MkCCFG/9PfS2R0etPCToBfza4+D8KfP7n4xHq5svHc3iG8oAjAJcQK?=
 =?us-ascii?Q?ivgiFUlUIiXhR5bbb1JXigG4SaRZixfqeofEf1DCR9c6XiCtv0wW/uItqFbH?=
 =?us-ascii?Q?ivHagFpBur9F6uLmmgxzb8udeZ4Mj8dbTnbQjT7FO4jENcZ8/z5EtTOtrhA9?=
 =?us-ascii?Q?nVtL4eFdeswWb8tOaoyHTR6B16UJOzkWOi1bYRs8YnomsSEZI4PsePTjVXEe?=
 =?us-ascii?Q?XUhi4ZO7UT0MXvE5fl5NgymiVDMewXi2u5mKZ0J9H/rPEZ/7JGX/DxvmqILx?=
 =?us-ascii?Q?qd/FQIe3dNYH1XxnxORIjvlvGVJv4NmSJAQWxm62MP/S1132iu4D8qLBdX49?=
 =?us-ascii?Q?L+I8oCOEORD2MUUoE1+9WKYF1+6jhL6ZF4hjGJWbQGuN4P0+jPd5w8Jk4YZy?=
 =?us-ascii?Q?KUngM7n+nSlcl4phBD7/SfXVDumYAjLjXvSsy20E/CFNKmsK4Bnlpt9g3Nx/?=
 =?us-ascii?Q?pzVrtrWLKOiqYEoVtxOsdqfv8+HU8tf1KxWEqti09XCUKb0b5pNwUrpyd/xW?=
 =?us-ascii?Q?BOGyop2rXpJW3eyPh32uGejmdz1qEMhu9LHCGAnEl5zVP0YdfCORpPRlvFJq?=
 =?us-ascii?Q?05i6A5Hj7i7/1g9D3+AW0PChUsLfX9EAEfbldTVPufoHnhTccyGzpComu+9S?=
 =?us-ascii?Q?0FVFh2I3RU1Z/kzFbGwlHtwuX+nHiYIQyrDsIiFqeqF0D0j0cWmFgPnrzGwd?=
 =?us-ascii?Q?is0Ca82vH0AlCqt10AokwGF2VGhZB7UjOKF9thquCtRNykcx3JvDj9448c/K?=
 =?us-ascii?Q?9cImRdyz48mgFDo4MUxjx+UonTqHmgyb0NJFcvN5AIURusVuiBn9eYw/iU/C?=
 =?us-ascii?Q?mLWaOI1PIrBOfgfW7pjs+yfvkfNrppM/qHYFYO65ZNT/HV/rWJ9DpULSJyfT?=
 =?us-ascii?Q?3Rl7TP81BucDXF60e4crbPp7aM74jkcG1b3EL6gN3iagThtIlxVUcgQUtsds?=
 =?us-ascii?Q?+rC9ZiSd9yARY7XVDPdGiZ618oqzdnIkkimm6scxIzA6SQIljYvCS2OmHpQZ?=
 =?us-ascii?Q?UbjFWH06NxeeDn5ikKQsdZtuPvwm7LZW58DC0hQ8kuQEAd4XebzhYtRVmGXB?=
 =?us-ascii?Q?Aten8Q6Y8X0BLWxSpULlBNLLQOSd4NF04nDbEx4Zoh/D44oX7TyBc7Rr546E?=
 =?us-ascii?Q?gqeDT4KdnKj427zQVJajezId7O/HoBnHpV29I7pc0b3CvEwprlAqt9A9lNOT?=
 =?us-ascii?Q?CaemIvU7fX8dhAKPiNzZbO0ShQ5ujhp2kXDP4xkehFtp4sKjoGLJU7kLN9Mw?=
 =?us-ascii?Q?KfK4BQYufAbF6DDaGx0ID5NZtLkJFcBvqDDyPXDjmtSAcHKcUsNYy+SBVDtZ?=
 =?us-ascii?Q?4GCpJ2jkMlSm+SGPqaIgbnnIhHLjEgJPiBBJ4fCSVkMdgZQbvUVUrHqWTNQj?=
 =?us-ascii?Q?kMxK6Abt7ovVf7GjEMuUgV0cJsP4Y9aQdN9OtoMW9BrejOZn9Mq03rPpD9CC?=
 =?us-ascii?Q?KyE42scsXultpA4UAeOGh/ZyAs2Rfm5BLN3lfzA31EQUlAXRHH1Ul86Mzm8i?=
 =?us-ascii?Q?b0Cy7OiAJg=3D=3D?=
X-OriginatorOrg: btesa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b573d238-8a54-4e72-234c-08defa0db79e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB5384.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:09:55.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f51efa09-da77-4b78-95dd-fde75cdb9c62
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUxmoy9fP9caerXIXfgg2T0uL0XKkwHXGiPMqBOPXvNZVpZFhaia4BQ9i2X4FbVqelN1xwhIeRetWdOCjvJT4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9994

Please drop this patch from the series; patches 1, 2 and 4 stand on their own.

Reading producer_pos first does follow the contract documented in
__bpf_ringbuf_reserve(), but it also allows overwrite_pos to be observed
ahead of the producer_pos snapshot, and then prod_pos - over_pos underflows
and min() falls back to prod_pos - cons_pos, which in overwrite mode is not
bounded by the ring size. That trades a bounded staleness for an unbounded
overestimate, which is worse than what it fixes.

Making the documented order safe needs an additional guard for over_pos
running ahead of the snapshot, so it belongs in its own patch rather than
here.
