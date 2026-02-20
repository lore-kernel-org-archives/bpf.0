Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6853176EB;
	Fri, 20 Feb 2026 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771614473; cv=fail; b=A1lF1MIOqyAqiXkVHfmg3ttJ4x1OU7p4jDepdZduRDCBfXrOFxoSiDNpPo5Dm88lzPduh3LtjscNV0UIyUN1D439R/5trDKBELIiH1isZV1785XX5GJY8w3V9jiVTis0PJw4Mtyn2Q2t7NvC2kynUBPHvr2hxj0312nBXzVqU2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771614473; c=relaxed/simple;
	bh=BptxkuvNdhT22DPkzkjqpQr2qeFqFT3Z80YJPI32rJg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SESbDf0nR+Hz2vE82ReW6+FLv/3bbpuTVqZJeiA+3Atig9TdQPVKdr8SJfKX6CtrDegwVwYgb4GvRoclzIbEK6UP0ve6iyC2KYKqBDVgU4+SERXClrDtWKlaPB3QwNNmPfut05lErlRfdld7xzZYQ68jNwjBi5UbstoFhgjfqME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TLvfgUu+; arc=fail smtp.client-ip=52.101.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TLvfgUu+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbm5mDijcIQMszm/jG9VxABUjtVaf8PBCsCb/nLz3B5Tky4Zoud4jGDZ+rnQr3YvIPms5EHt5VUbOS5x2rMOBuoGP6pvbhYwG1w0hdrpssX0/PvFK7tq/mIMmQeEPvj0nHP+zXhFWWZ8C9t+TwaSE0NryadGnIEfshGxWjVsBpM4FbsE392IVR+7lC8RSLIIZPxuZjC8UaEiEpzf4bHpA1Tcq/jRpC7RPzWOfH5fRNkQKUdNZUDHgR4uiWfL46lnx/soMLW81qCtzBcnqUD12A2l0YJ2hZv4K4BDAvoU/RD1PfA7i+vscV/6Z9J8WwJPDebeVjbZunnCwKshgzA5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ouYmeaGOgo62c19Hu/M5syRPO65oY+zEHzm5ZWedEc=;
 b=aAcWFTDitL4n7DqVKxkVH37K/AdfD70ms3CYT1Un65Y0fVxi5TflD2Ja0i4rFwW2br42rwoMt356lsTmfMdrrqorMTvq35y5YmPeeIAVTzmyw8f7YE+ehIWgpkmA5TbhS/+Y8ga4L/Xe/74mLlZfGdaB+yd5IapzhxEEidwm/8zLeNxcr83uSXk5EwLXeLjcvHOyeqkBWMYcdbZqPdrmtqAON1WPo1DCp1Jgmj8bgaesuVk6jMzBDuY1ELe61AfIKs2eiXAm9nT/cv+znBl5910+N/BmO2xkLoHca5Jgxppox0W+cuGvGq9HzLNoE6Vj5Vkon+4uDdwOwXqwW1BJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ouYmeaGOgo62c19Hu/M5syRPO65oY+zEHzm5ZWedEc=;
 b=TLvfgUu+D/UDSIfb2zhMv8bqcZ1JvIWSzSVjVEG6uBNq6h9tYsahm5l8sWmeaUMGzgaQ2+RWnMHLTvRn9G3n/jDstUH9LlfQ02KbEv2X/Q+J+C9d3SzvUwszQ6oIK4qR6iQ8YoMOXyWvT07GeN5Er/AUYjDgFOwN+W8145n1OgxcLLBCbMMNQXRWGK2sTr91sT9IErvPNsCWJI6yV8+SBsV12FyIBnFmK+q5hMCzbGfUhaIJOBuspmugB+yA+0Y9pIaO3y1xp53VcH6jbR9qeB5DKgbEeCK2Ipe4DEts1l7duJ/ey6D99zKeY1F1kYb5TkM+seRWqKZZ082P2bkEZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB999108.namprd12.prod.outlook.com (2603:10b6:806:4a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 19:07:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 19:07:48 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Prevent invalid u32 bounds in __reg32_deduce_bounds()
Date: Fri, 20 Feb 2026 20:07:36 +0100
Message-ID: <20260220190736.230329-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB999108:EE_
X-MS-Office365-Filtering-Correlation-Id: 6159943f-d1ea-4454-b969-08de70b3566c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EfD2m3ruC8CbKchfqHoAEJxhv98pztjW9b0DlY5CTaL54HNadZ1XcsSPxyt1?=
 =?us-ascii?Q?d4jqRIv56jyHSGNfXEIXcuYsD1AAdWprm8XeMhePs6LEjqn2aQBljxm4yvQp?=
 =?us-ascii?Q?fiioZRu9n7Q468SECDaMygC//0XHeqxya1izJS2Qx7Be13BPWZRO8MVk/IQX?=
 =?us-ascii?Q?to9LREDeSOp7U07llBbW2Zpa+4bTE+636A9LWb3IoPx/B1t5RUe6cX9CxYzE?=
 =?us-ascii?Q?UNClGOE3zXMca7w3a9jR8ceYbpTWqUic2xlysV5KcENAnKmNHkSbVyqjew3Z?=
 =?us-ascii?Q?9BPQVClPZLIq6rJoGtwjUNGpEs/CKe7IIKsJ+dBTJMpLrL6MBp1NYVb6htyy?=
 =?us-ascii?Q?UPtqnQw5Ik5CfHuztnyktf/lPvD/wjef5njKO86heMbc69+zqk7pLGE2Uyyd?=
 =?us-ascii?Q?5z72ekXqJJ5BI2d4vzWo7Nhbzw48dyxD/Vm/hKBQ+9xOMf6e26HCji3A+7q2?=
 =?us-ascii?Q?EKzLhk994jdU7yeX0qjIFS3cJ5xGxZAaDQGQGcfXm1bNLfDbhHcYhOtObfdG?=
 =?us-ascii?Q?M049hR5fI2e5qqIfbo/MKwume7qCKrTycHqGxW4v8IbX9R3iHVQu0jAv2i/2?=
 =?us-ascii?Q?GykTnnHcruKCIhXKj11pmrsE/+l6PI2HJoNaqkipsxO79IzpMAYF3MNzvrNB?=
 =?us-ascii?Q?8XraVCJJb+NlU4s1FSlu88tkm8F8jEsg2O50ZHRI+6abHYRqIWhUNm51ZgnY?=
 =?us-ascii?Q?nfRaySQyWu87C3WQ2IHwT2yJBY5U0JUmehMs9DBOzrEAdjEPlVt706jH1c9L?=
 =?us-ascii?Q?S6aedSSkg43QsovjUe58RzhR6x2BuajfJs8Bf/Mot4/Wt/5SadjMJZDyLOZD?=
 =?us-ascii?Q?hHT/AMqgzRX0HEfjD1qw/4zkQgjll/8SB/UPLz26wqv7qU+MvPx94zEdQeKK?=
 =?us-ascii?Q?iGlNDQXIWhc4r1+V8jAsDAdtCy04JVZKLRRKOEXm6oF5oUF53t/jk6kgRgNx?=
 =?us-ascii?Q?VstL+5eizlRHFy521u3uREC4Lq5SD23nY/WsQnbNugazHa1ugbneNEoAHhhN?=
 =?us-ascii?Q?3f9KN77tkccus9CuSs3GNCsyTXacm6HxAW7CR2T+z/7fdsY24bMjQ0hyBHt/?=
 =?us-ascii?Q?yhdz+zqKhlqHUqLezoiXiDgsV1W18m97JJ+A9TGVHeVtvNS+BohL5fIX6iA7?=
 =?us-ascii?Q?T8aWKpdtHfehql9OH2LK2pQRVN7lYwSSkrQD71dmQy95oz9/CTfTUcu9sqdG?=
 =?us-ascii?Q?Hqre2IIHCFz8yObc0U5Pb4+fznw/hav+4rKlKzDuwyE7/hnx3sVOT/lg9gDe?=
 =?us-ascii?Q?lsyKEQtdOTXS350pQN3ESSHTOz7/5Janx7RiFLlXPQRZdO32Kx+gPbXfAO0q?=
 =?us-ascii?Q?+JLepE0pbIlhq7JIpz9hejc7ejNMSFFHxqPelevhNvmjaMrdgzi3Y1hgWgDB?=
 =?us-ascii?Q?vnNT5rG2OWes+w+gMggogZZBOKmcj/TWRVG1DJaxEf/jOgkbv6+4vwZWhnYA?=
 =?us-ascii?Q?KtDEMOFApfHq1oUJ2fbpd5sk8SktnrXmkBsn9iWK+QyxpRADBXcZOoeYYa2B?=
 =?us-ascii?Q?nsVYoAN1lsWkEG7AWpIUNufB3MYpjW3sntjN7l/IYjhjzboG9fToF9+E1UT+?=
 =?us-ascii?Q?4fCrRl2XzS4HI4vmp1+Z8z9PSFRPf0TlF2FaKnem?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?68vGHB/kSv4Foxtf6ZljmpuHNbfVLXit8o257qiR0gzxgzcsYstd97gfk4S+?=
 =?us-ascii?Q?HVEkHVpns5OgNxVEvSkNel3hkVBBb3Zc1H8yF4IezTsqfW53Rc+29lAXB243?=
 =?us-ascii?Q?4ev00rBA/h/LZAwGvHuPNQjEb9aHuou+ugz+pPTg/i10LNNpJJ/l+C66TJ4g?=
 =?us-ascii?Q?pgmy0Cn9I9oFP5sOkUyXsCKhlr70o2dLVLPOWIKnO7yaUDL53BAoOFSQwyd1?=
 =?us-ascii?Q?qprgPg+0Ocv3fPNKpJZJurWq1kwyBxx1D1In/pkwTl5uZYeNIPD4DSPO8Qkz?=
 =?us-ascii?Q?kjnh7KtZFhhXijqDiENk2p8O9hZp7kWayazU2ioA18/Mqls3XkztNBhMWf/J?=
 =?us-ascii?Q?a3ngHqw9YBDcfWLAvxHIB3l2BQDd7uHY7OGBAa5gRubBiepBnhE4l/4Nfkxa?=
 =?us-ascii?Q?insKzYvbbb74Hi9b7NfVFtLyZbDxOJAsP9DDIFB9tdWr7blU9ulZdlr7VkFr?=
 =?us-ascii?Q?uTgZhf1MUbQ35wuL1iF3rfsuRKinUu8pRo5a58dLbgkBalK0osZ2hfFmL+79?=
 =?us-ascii?Q?s3OT2h9BoUxauPQkL/5SCWaUgU7vMSJsV4lZg23XAQLz4ubW6Gxz92tTvcUZ?=
 =?us-ascii?Q?KfNerGMJ0cWzC3BOYsBv4kzCqRNPHnjnSt+K7vKjPUiY2Yc7rfuBeommwqof?=
 =?us-ascii?Q?CDpIaHoLGaExy5/yowbGt9D8L65HHul10Vn5ZZSHdkd3f+1J1aqPBCA+e1dA?=
 =?us-ascii?Q?1CKBG3CDbDHbFG7gW0NDnzv7yBS7L6pC756AlryxDUDb9wiZDE0R+0Q8Wt32?=
 =?us-ascii?Q?l3ScDip/EUMQ6Hy7mke+X9DygNz/0Bi1O9FjZn5x5excgKRWng5PY+6GW30F?=
 =?us-ascii?Q?peaHMhrjcOASqjYXoP11RDdQOR5NmKhfeCUl8aXHKsEw8pAk2ehbwexOtWR3?=
 =?us-ascii?Q?REZDqPAUbB7qn8iDmh/MzUPAC0EyeyAnW89B6DagWACWKW+U2VWSUKeYBmgT?=
 =?us-ascii?Q?7qVQmOrLY9pdkZX2rVmEYcIkde74o4UEYt9+SR/VHKOTLCp5b8PeHXJNIP4/?=
 =?us-ascii?Q?4Wtm6tvRtchb3V360irBuDQq6ltn4awYlIgdOMCvs0xkmF5fsNlzEaYP9ljb?=
 =?us-ascii?Q?sRht12ZTqk+Ncrv6s8to8HXwnnRRrU4gFGkDv6pd3f/WXEupSJU6RvhztJKl?=
 =?us-ascii?Q?Zp7Z9QPg9SFevYDLzF14Y1dRzQPOJJugU8E+80s84NWv6NHk2xgfFtGXjc2S?=
 =?us-ascii?Q?lw+wv7lIVBRx/irOnak4U3qs7cKuX0Ore7YybG3g3mDsgggXxdcmB2t9uIbu?=
 =?us-ascii?Q?YmLFbbfnq4ckCt41jusAFKPEo8AyVQ0+5EU3hb05pod+FOzFT+mvrX51T9nz?=
 =?us-ascii?Q?PdYt2qOEl+EmVLO0rAwjyejSrg1cfEtDCsyEnlWgvWF2PZFJO5Ytw1RZYafw?=
 =?us-ascii?Q?IRLOdwHBcrsCDokhk3/f3fw7ST2MHf0oPiFObfEZTdnYxd5BEJbE6yxmPKwq?=
 =?us-ascii?Q?Ip8vdrWiybpKqnUxAeln5GiIouJGzJ4XfTnD6cgFsBul0q9kU8JpOhlaoGmV?=
 =?us-ascii?Q?9mAIlqqL5YVFoU9sC9wrZo3AZ8LM3den9xZTkEy3y/QyHn5Dhnm0XsCCs2nC?=
 =?us-ascii?Q?ELRHmIdyIOGERd8xpUB8RLbI0eoSR4gYsG4cgjLV5OSJdjaxR231gBfLQPmG?=
 =?us-ascii?Q?0TZJH8MQVwtyf8McXMscTVoxKiQS5lzq8RDdj2tmy7mS+sxPhqNXuaraTXMA?=
 =?us-ascii?Q?aGiQt9PwIJK3RTY2xIDuA5MqX1VwCQTqER27JTw1C9Zyxat+zXfryhAJV3U3?=
 =?us-ascii?Q?W8XzLN0pEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6159943f-d1ea-4454-b969-08de70b3566c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:07:48.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFlGcvxDCbeWJTYPOGc66logu1lGJGh4PP9K8PGZLcU38DP5Nz4VFas8xhjmGcv/bgM9QA1S3yi21EizOoakcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999108

When refining register bounds, __reg32_deduce_bounds can derive u32
min/max from 64-bit or s32 bounds and assign them with max_t/min_t.

If the existing u32 range and the derived range do not overlap (e.g.,
u64 says [0, 1] while u32 was [2, 2] from an earlier path), the
intersection is empty and the new u32_min_value can end up greater than
u32_max_value, triggering the following warning:

  verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation
    u64=[0x0, 0x1] s64=[0x0, 0x1] u32=[0x3, 0x1] s32=[0x0, 0x1] var_off=(0x0, 0x1)
  WARNING: kernel/bpf/verifier.c:2742 at reg_bounds_sanity_check
  Call Trace:
    reg_bounds_sanity_check+0xbc/0x1e0
    reg_set_min_max+0x1a2/0x1f0
    check_cond_jmp_op+0x5d2/0x1980
    do_check_common+0x2b0f/0x3410
    do_check_subprogs+0xcd/0x180
    bpf_check+0x33fe/0x3850
    bpf_prog_load+0x7d7/0xee0
    __sys_bpf+0xea2/0x2e30

This was triggered by the scx CI while loading the scx_layered sched_ext
scheduler [1].

Fix by only applying the derived u32 bounds when the resulting range is
valid (u32_min <= u32_max).

[1] https://github.com/sched-ext/scx/pull/3349

Fixes: c1efab6468fd5 ("bpf: derive subreg bounds from full bounds when upper 32 bits are constant")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/bpf/verifier.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f6..78964c7e9ac99 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2424,8 +2424,13 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
 		/* u64 to u32 casting preserves validity of low 32 bits as
 		 * a range, if upper 32 bits are the same
 		 */
-		reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->umin_value);
-		reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->umax_value);
+		u32 u32_min = max_t(u32, reg->u32_min_value, (u32)reg->umin_value);
+		u32 u32_max = min_t(u32, reg->u32_max_value, (u32)reg->umax_value);
+
+		if (u32_min <= u32_max) {
+			reg->u32_min_value = u32_min;
+			reg->u32_max_value = u32_max;
+		}
 
 		if ((s32)reg->umin_value <= (s32)reg->umax_value) {
 			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
@@ -2435,8 +2440,13 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
 	if ((reg->smin_value >> 32) == (reg->smax_value >> 32)) {
 		/* low 32 bits should form a proper u32 range */
 		if ((u32)reg->smin_value <= (u32)reg->smax_value) {
-			reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->smin_value);
-			reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->smax_value);
+			u32 u32_min = max_t(u32, reg->u32_min_value, (u32)reg->smin_value);
+			u32 u32_max = min_t(u32, reg->u32_max_value, (u32)reg->smax_value);
+
+			if (u32_min <= u32_max) {
+				reg->u32_min_value = u32_min;
+				reg->u32_max_value = u32_max;
+			}
 		}
 		/* low 32 bits should form a proper s32 range */
 		if ((s32)reg->smin_value <= (s32)reg->smax_value) {
@@ -2479,8 +2489,13 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
 	 * -3 s<= x s<= -1 implies 0xf...fd u<= x u<= 0xf...ff.
 	 */
 	if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
-		reg->u32_min_value = max_t(u32, reg->s32_min_value, reg->u32_min_value);
-		reg->u32_max_value = min_t(u32, reg->s32_max_value, reg->u32_max_value);
+		u32 u32_min = max_t(u32, reg->s32_min_value, reg->u32_min_value);
+		u32 u32_max = min_t(u32, reg->s32_max_value, reg->u32_max_value);
+
+		if (u32_min <= u32_max) {
+			reg->u32_min_value = u32_min;
+			reg->u32_max_value = u32_max;
+		}
 	}
 }
 
-- 
2.53.0

