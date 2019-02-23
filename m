Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A84C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 00:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901FF205C9
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 00:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rFvAuLok";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ATO88RG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbfBWAfG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:35:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59814 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbfBWAfG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Feb 2019 19:35:06 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1N0WCut017078;
        Fri, 22 Feb 2019 16:34:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=m1wLnk59FsDthNPoJnyx1Re0ZOdLOt0cI6WF9UgwTN4=;
 b=rFvAuLokGvI7s10xjY/0XDgW4ykXvYn4hPJMit1lqh+y/+EHkzIIKYXxPIvA46rqjo2k
 0M9gsmwnxDqdqLRm1KEMTZOx1JZ7DAnpRg4M6tFSGkBsQB9h9Mwo/XBuWP9/Q3BZhDGG
 zXf1I6ayeXywb1g71pB8CBoNyuLE9mTx3fI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qtsserbgj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Feb 2019 16:34:43 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 22 Feb 2019 16:34:40 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 22 Feb 2019 16:34:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1wLnk59FsDthNPoJnyx1Re0ZOdLOt0cI6WF9UgwTN4=;
 b=ATO88RG0Fwmzx3e0GsVkPieUcEsUsz/7Yz3xNAUIrGWFIbbdrGmfRQnXROTLAajQcbewkSTESpYH8MdkKo5RbQCfZsAmqNpZsOUxbpy52ocDnkELtYh9zulaHw5EfigS9LRkwlmPamDPcyREJkGy2I9eiMnuOjz9KiLYsaPl4ic=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3462.namprd15.prod.outlook.com (20.179.60.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Sat, 23 Feb 2019 00:34:38 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1643.016; Sat, 23 Feb 2019
 00:34:38 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: enable program stats
Thread-Topic: [PATCH bpf-next 1/4] bpf: enable program stats
Thread-Index: AQHUyweSfrqmAysg6E+adH2zaAquXaXsiQqA
Date:   Sat, 23 Feb 2019 00:34:38 +0000
Message-ID: <20190223003434.GA17559@tower.DHCP.thefacebook.com>
References: <20190222233644.1487087-1-ast@kernel.org>
 <20190222233644.1487087-2-ast@kernel.org>
In-Reply-To: <20190222233644.1487087-2-ast@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0105.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::46) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:8e3c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e5449a9-6a91-42d6-d8f5-08d69926b126
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3462;
x-ms-traffictypediagnostic: BYAPR15MB3462:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3462;20:/y+owLHeUhoF+qCwobh2HdK5XjaOXi7LgpajUVxb1TC5ry78NWB+kBGk795/+0B88COm5KhQVfPYtVNetiSRiabd3yWT5MedPNaUttkwyqFzG4Lig/wwHyeVTK9gnbwp2PxLtEsWGQDBLAThEMCdVPD9MSXPOZdaYZvGezsIsy8=
x-microsoft-antispam-prvs: <BYAPR15MB34626B161790320142DEB1C3BE780@BYAPR15MB3462.namprd15.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(366004)(396003)(136003)(199004)(189003)(76176011)(52116002)(71200400001)(8936002)(8676002)(6512007)(6486002)(9686003)(71190400001)(81166006)(105586002)(25786009)(14454004)(6436002)(81156014)(53936002)(486006)(186003)(86362001)(476003)(386003)(6506007)(99286004)(6116002)(446003)(46003)(11346002)(102836004)(305945005)(106356001)(7736002)(256004)(4326008)(6246003)(54906003)(33656002)(14444005)(1076003)(5660300002)(6916009)(316002)(68736007)(2906002)(97736004)(229853002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3462;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cLXddiBLHeA45xIiLOrXpehqd9UnV0JnTkUIoBA2DbBaloGHh82XtSZa0zvm/AyaTAze99gSD2gWF+vaxSBvT07ULHRrEGjW/K1ZwKyinka+HhWziWAh6rcA6DoOP0HpLynTcFBLtziIuiM+kA40TCdeGT9e2WDnqQ9JWIwIxz3xQUzCicbgccrL5ANLZNp0bbMeAZCzekTejTmhWAJzKwH1qPTYSYaRyng5kH0IDMRq+ZuG2IPa4Vno6R9dbklCpKkggBd9nJytRo+Kux47GQcG9b+42ZVQ8gzfiRSunBjvvZcsawtlQWA6P/X9wqKzja2Waru9LzFKMl7Xl1LkdyjpZS3mSQ2CTF6otNWFMfvgbhg6F7/3IWtwEXMOb+0BrU6ygrUklSqvV5vnyOgeGQRXGgv/RmSE0akzef2gvUY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <022695E67E24304D829FC4796DF51C8D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5449a9-6a91-42d6-d8f5-08d69926b126
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 00:34:37.5931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3462
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-23_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 22, 2019 at 03:36:41PM -0800, Alexei Starovoitov wrote:
> JITed BPF programs are indistinguishable from kernel functions, but unlik=
e
> kernel code BPF code can be changed often.
> Typical approach of "perf record" + "perf report" profiling and tunning o=
f
> kernel code works just as well for BPF programs, but kernel code doesn't
> need to be monitored whereas BPF programs do.
> Users load and run large amount of BPF programs.
> These BPF stats allow tools monitor the usage of BPF on the server.
> The monitoring tools will turn sysctl kernel.bpf_stats_enabled
> on and off for few seconds to sample average cost of the programs.
> Aggregated data over hours and days will provide an insight into cost of =
BPF
> and alarms can trigger in case given program suddenly gets more expensive=
.
>=20
> The cost of two sched_clock() per program invocation adds ~20 nsec.
> Fast BPF progs (like selftests/bpf/progs/test_pkt_access.c) will slow dow=
n
> from ~40 nsec to ~60 nsec.
> static_key minimizes the cost of the stats collection.
> There is no measurable difference before/after this patch
> with kernel.bpf_stats_enabled=3D0
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf.h    |  7 +++++++
>  include/linux/filter.h | 16 +++++++++++++++-
>  kernel/bpf/core.c      | 13 +++++++++++++
>  kernel/bpf/syscall.c   | 24 ++++++++++++++++++++++--
>  kernel/bpf/verifier.c  |  5 +++++
>  kernel/sysctl.c        | 34 ++++++++++++++++++++++++++++++++++
>  6 files changed, 96 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index de18227b3d95..14260674bc57 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -340,6 +340,11 @@ enum bpf_cgroup_storage_type {
> =20
>  #define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
> =20
> +struct bpf_prog_stats {
> +	u64 cnt;
> +	u64 nsecs;
> +};
> +
>  struct bpf_prog_aux {
>  	atomic_t refcnt;
>  	u32 used_map_cnt;
> @@ -389,6 +394,7 @@ struct bpf_prog_aux {
>  	 * main prog always has linfo_idx =3D=3D 0
>  	 */
>  	u32 linfo_idx;
> +	struct bpf_prog_stats __percpu *stats;
>  	union {
>  		struct work_struct work;
>  		struct rcu_head	rcu;
> @@ -559,6 +565,7 @@ void bpf_map_area_free(void *base);
>  void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
> =20
>  extern int sysctl_unprivileged_bpf_disabled;
> +extern int sysctl_bpf_stats_enabled;
> =20
>  int bpf_map_new_fd(struct bpf_map *map, int flags);
>  int bpf_prog_new_fd(struct bpf_prog *prog);
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f32b3eca5a04..7b14235b6f7d 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -533,7 +533,21 @@ struct sk_filter {
>  	struct bpf_prog	*prog;
>  };
> =20
> -#define BPF_PROG_RUN(filter, ctx)  ({ cant_sleep(); (*(filter)->bpf_func=
)(ctx, (filter)->insnsi); })
> +DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
> +
> +#define BPF_PROG_RUN(prog, ctx)	({				\
> +	u32 ret;						\
> +	cant_sleep();						\
> +	if (static_branch_unlikely(&bpf_stats_enabled_key)) {	\
> +		u64 start =3D sched_clock();			\
> +		ret =3D (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
> +		this_cpu_inc(prog->aux->stats->cnt);		\
> +		this_cpu_add(prog->aux->stats->nsecs,		\
> +			     sched_clock() - start);		\
> +	} else {						\
> +		ret =3D (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
> +	}							\
> +	ret; })

Can we bump "cnt" unconditionally and gate only the "nsecs" calculation?

Why it might be useful?
If the performance cost is too high to keep the statistics gathering
always enabled, it will be possible to measure the average cost
periodically and extrapolate.

Thanks!
