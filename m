Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEA0C43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 21:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D72206A3
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 21:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eLx7Iryh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Mig7nmxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfDZVYH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:24:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55054 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726134AbfDZVYH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 17:24:07 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3QLNiet011114;
        Fri, 26 Apr 2019 14:23:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zFgSx/+VaxEg87VfI51IGf+qjOpeBYQuSmVYF+xfBNo=;
 b=eLx7Iryhs8FuXdB7swPbGTIWnZFRbB1Ax/BPVT4CAo+Ep4Iuc+RK4VxV08ALl1iqR/2H
 KwgY688hOKIPI4o8noC7UphOYY/Ix+uYi6kMNDA+2bqPVlcPM7IGZEsskBGW0afqP22A
 gfNGlIPuhL6Yit0YVx/Dd6LvvJVMQQ0/Qys= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2s44jgs3t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Apr 2019 14:23:44 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Apr 2019 14:23:40 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 26 Apr 2019 14:23:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFgSx/+VaxEg87VfI51IGf+qjOpeBYQuSmVYF+xfBNo=;
 b=Mig7nmxmrB3TjAKVKTa10yTmXNKlTKKzWeUxzv6fiKjtslJH/GzA9qX2t7Zct0QM53FECFFqHjrKwISRib69JlxNjU3CQE1zUcDDtUS5MfUqmOxgfDIR/BJx71b6MvbhC8GZKHjnLI8/46tMXYSr4xQo81Iz89H83OciaL+ybOQ=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1550.namprd15.prod.outlook.com (10.173.235.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 21:23:18 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 21:23:18 +0000
From:   Martin Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v3 bpf-next 6/6] bpf: Add ene-to-end test for
 bpf_sk_storage_* helpers
Thread-Topic: [PATCH v3 bpf-next 6/6] bpf: Add ene-to-end test for
 bpf_sk_storage_* helpers
Thread-Index: AQHU/FMdskIjY58YxESfsdbqk3+7FaZOubEAgAA6LgA=
Date:   Fri, 26 Apr 2019 21:23:18 +0000
Message-ID: <20190426212316.uhyxmrpql4qux5b7@kafai-mbp.dhcp.thefacebook.com>
References: <20190426171102.61757-1-kafai@fb.com>
 <20190426171114.62466-1-kafai@fb.com> <20190426175502.GG1247@mini-arch>
In-Reply-To: <20190426175502.GG1247@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:300:13d::29) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:7ae1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1e12903-5de9-40e9-a6a4-08d6ca8d66a4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1550;
x-ms-traffictypediagnostic: MWHPR15MB1550:
x-microsoft-antispam-prvs: <MWHPR15MB1550DD144923544CA891D669D53E0@MWHPR15MB1550.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(396003)(136003)(366004)(189003)(199004)(71190400001)(71200400001)(66446008)(7736002)(305945005)(6436002)(6116002)(53936002)(52116002)(4326008)(14444005)(68736007)(6512007)(256004)(25786009)(9686003)(1076003)(446003)(73956011)(486006)(66476007)(86362001)(6246003)(316002)(476003)(66946007)(11346002)(30864003)(54906003)(2906002)(8676002)(81166006)(102836004)(478600001)(66556008)(8936002)(6506007)(186003)(6486002)(64756008)(14454004)(46003)(5660300002)(6916009)(386003)(76176011)(99286004)(81156014)(229853002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1550;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3HRCPY+kNBYnguKH50oIrc1jKBxpEOOu6mewsVjynobzcqIlxCNiYE1WEu03pHTn+LmSsEBqO/C2YMRj9uJQYIA5O5xldM+3BhkaROzFtYB6+fDBJ5ULZZLCvnGv2wJ/lTp0dZpssoW+fmA1HvyKO+wCo4E5Jvfp6l6rIZQJOmWNG7n1C0C0SBUQs/si6R4dna3O7EwtJh5E4TcVP5depK5pPwvlWN2Qj/zIrhnZtAkau0vTdMdnrz0qal61r6oImrOWYVL/bgmz2pckD+GZbfWPV9pJtFpsgTPY43J2nJwN9PyFG+m6TPOu+56SVEfvr41gBH7gCtiBkZnxCDzB6IKAZm1P/noyyJER36efWh18RixsjuP8vSaWVREjTpMHHJnpL7P1a1c4QYke5EZ8wTkoWsq6jBcGsHNSVSi4uNM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65F7BBA485D5464CB52619EC80EA2821@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e12903-5de9-40e9-a6a4-08d6ca8d66a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 21:23:18.4893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1550
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260140
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 26, 2019 at 10:55:02AM -0700, Stanislav Fomichev wrote:
> On 04/26, Martin KaFai Lau wrote:
> > This patch rides on an existing BPF_PROG_TYPE_CGROUP_SKB test
> > (test_sock_fields.c) to do a TCP end-to-end test on the new
> > bpf_sk_storage_* helpers.
> >=20
> > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > ---
> >  tools/testing/selftests/bpf/bpf_helpers.h     |   5 +
> >  .../bpf/progs/test_sock_fields_kern.c         |  49 ++++++++
> >  .../testing/selftests/bpf/test_sock_fields.c  | 115 +++++++++++++++---
> >  3 files changed, 153 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/=
selftests/bpf/bpf_helpers.h
> > index 59e221586cf7..6e80b66d7fb1 100644
> > --- a/tools/testing/selftests/bpf/bpf_helpers.h
> > +++ b/tools/testing/selftests/bpf/bpf_helpers.h
> > @@ -211,6 +211,11 @@ static int (*bpf_strtol)(const char *buf, unsigned=
 long long buf_len,
> >  static int (*bpf_strtoul)(const char *buf, unsigned long long buf_len,
> >  			  unsigned long long flags, unsigned long *res) =3D
> >  	(void *) BPF_FUNC_strtoul;
> > +static void *(*bpf_sk_storage_get)(void *map, struct bpf_sock *sk,
> > +				   void *value, __u64 flags) =3D
> > +	(void *) BPF_FUNC_sk_storage_get;
> > +static int (*bpf_sk_storage_delete)(void *map, struct bpf_sock *sk) =
=3D
> > +	(void *)BPF_FUNC_sk_storage_delete;
> > =20
> >  /* llvm builtin functions that eBPF C program may use to
> >   * emit BPF_LD_ABS and BPF_LD_IND instructions
> > diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields_kern.c =
b/tools/testing/selftests/bpf/progs/test_sock_fields_kern.c
> > index 37328f148538..93ef3e039da3 100644
> > --- a/tools/testing/selftests/bpf/progs/test_sock_fields_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/test_sock_fields_kern.c
> > @@ -55,6 +55,31 @@ struct bpf_map_def SEC("maps") linum_map =3D {
> >  	.max_entries =3D __NR_BPF_LINUM_ARRAY_IDX,
> >  };
> > =20
> > +struct bpf_spinlock_cnt {
> > +	struct bpf_spin_lock lock;
> > +	__u32 cnt;
> > +};
> > +
> > +struct bpf_map_def SEC("maps") sk_pkt_out_cnt =3D {
> > +	.type =3D BPF_MAP_TYPE_SK_STORAGE,
> > +	.key_size =3D sizeof(int),
> > +	.value_size =3D sizeof(struct bpf_spinlock_cnt),
> > +	.max_entries =3D 0,
> > +	.map_flags =3D BPF_F_NO_PREALLOC,
> > +};
> > +
> > +BPF_ANNOTATE_KV_PAIR(sk_pkt_out_cnt, int, struct bpf_spinlock_cnt);
> > +
> > +struct bpf_map_def SEC("maps") sk_pkt_out_cnt10 =3D {
> > +	.type =3D BPF_MAP_TYPE_SK_STORAGE,
> > +	.key_size =3D sizeof(int),
> > +	.value_size =3D sizeof(struct bpf_spinlock_cnt),
> > +	.max_entries =3D 0,
> > +	.map_flags =3D BPF_F_NO_PREALLOC,
> > +};
> > +
> > +BPF_ANNOTATE_KV_PAIR(sk_pkt_out_cnt10, int, struct bpf_spinlock_cnt);
> > +
> >  static bool is_loopback6(__u32 *a6)
> >  {
> >  	return !a6[0] && !a6[1] && !a6[2] && a6[3] =3D=3D bpf_htonl(1);
> > @@ -120,7 +145,9 @@ static void tpcpy(struct bpf_tcp_sock *dst,
> >  SEC("cgroup_skb/egress")
> >  int egress_read_sock_fields(struct __sk_buff *skb)
> >  {
> > +	struct bpf_spinlock_cnt cli_cnt_init =3D { .lock =3D 0, .cnt =3D 0xeB=
9F };
> >  	__u32 srv_idx =3D ADDR_SRV_IDX, cli_idx =3D ADDR_CLI_IDX, result_idx;
> > +	struct bpf_spinlock_cnt *pkt_out_cnt, *pkt_out_cnt10;
> >  	struct sockaddr_in6 *srv_sa6, *cli_sa6;
> >  	struct bpf_tcp_sock *tp, *tp_ret;
> >  	struct bpf_sock *sk, *sk_ret;
> > @@ -161,6 +188,28 @@ int egress_read_sock_fields(struct __sk_buff *skb)
> >  	skcpy(sk_ret, sk);
> >  	tpcpy(tp_ret, tp);
> > =20
> > +	if (result_idx =3D=3D EGRESS_SRV_IDX) {
> > +		/* The userspace has created it for srv sk */
> > +		pkt_out_cnt =3D bpf_sk_storage_get(&sk_pkt_out_cnt, sk, 0, 0);
> > +		pkt_out_cnt10 =3D bpf_sk_storage_get(&sk_pkt_out_cnt10, sk,
> > +						   0, 0);
> > +	} else {
> > +		pkt_out_cnt =3D bpf_sk_storage_get(&sk_pkt_out_cnt, sk,
> > +						 &cli_cnt_init,
> > +						 BPF_SK_STORAGE_GET_F_CREATE);
> > +		pkt_out_cnt10 =3D bpf_sk_storage_get(&sk_pkt_out_cnt10,
> > +						   sk, &cli_cnt_init,
> > +						   BPF_SK_STORAGE_GET_F_CREATE);
> > +	}
> > +
> > +	if (!pkt_out_cnt || !pkt_out_cnt10)
> > +		RETURN;
> > +
> [..]
> > +	pkt_out_cnt->cnt +=3D 1;
> > +	bpf_spin_lock(&pkt_out_cnt10->lock);
> > +	pkt_out_cnt10->cnt +=3D 10;
> > +	bpf_spin_unlock(&pkt_out_cnt10->lock);
> Any reason only cnt10 is spin-locked? I see both of them use
> bpf_spinlock_cnt struct.
Intentionally one takes lock and one does not as a test.
I will add one comment here.

>=20
> > +
> >  	RETURN;
> >  }
> > =20
> > diff --git a/tools/testing/selftests/bpf/test_sock_fields.c b/tools/tes=
ting/selftests/bpf/test_sock_fields.c
> > index dcae7f664dce..550baf8aa1ca 100644
> > --- a/tools/testing/selftests/bpf/test_sock_fields.c
> > +++ b/tools/testing/selftests/bpf/test_sock_fields.c
> > @@ -35,6 +35,11 @@ enum bpf_linum_array_idx {
> >  	__NR_BPF_LINUM_ARRAY_IDX,
> >  };
> > =20
> > +struct bpf_spinlock_cnt {
> > +	struct bpf_spin_lock lock;
> > +	__u32 cnt;
> > +};
> > +
> >  #define CHECK(condition, tag, format...) ({				\
> >  	int __ret =3D !!(condition);					\
> >  	if (__ret) {							\
> > @@ -50,6 +55,8 @@ enum bpf_linum_array_idx {
> >  #define DATA_LEN sizeof(DATA)
> > =20
> >  static struct sockaddr_in6 srv_sa6, cli_sa6;
> > +static int sk_pkt_out_cnt10_fd;
> > +static int sk_pkt_out_cnt_fd;
> >  static int linum_map_fd;
> >  static int addr_map_fd;
> >  static int tp_map_fd;
> > @@ -220,28 +227,90 @@ static void check_result(void)
> >  	      "Unexpected listen_tp", "Check listen_tp output. ingress_linum:=
%u",
> >  	      ingress_linum);
> > =20
> > -	CHECK(srv_tp.data_segs_out !=3D 1 ||
> > +	CHECK(srv_tp.data_segs_out !=3D 2 ||
> >  	      srv_tp.data_segs_in ||
> >  	      srv_tp.snd_cwnd !=3D 10 ||
> >  	      srv_tp.total_retrans ||
> > -	      srv_tp.bytes_acked !=3D DATA_LEN,
> > +	      srv_tp.bytes_acked !=3D 2 * DATA_LEN,
> >  	      "Unexpected srv_tp", "Check srv_tp output. egress_linum:%u",
> >  	      egress_linum);
> > =20
> >  	CHECK(cli_tp.data_segs_out ||
> > -	      cli_tp.data_segs_in !=3D 1 ||
> > +	      cli_tp.data_segs_in !=3D 2 ||
> >  	      cli_tp.snd_cwnd !=3D 10 ||
> >  	      cli_tp.total_retrans ||
> > -	      cli_tp.bytes_received !=3D DATA_LEN,
> > +	      cli_tp.bytes_received !=3D 2 * DATA_LEN,
> >  	      "Unexpected cli_tp", "Check cli_tp output. egress_linum:%u",
> >  	      egress_linum);
> >  }
> > =20
> > +static void check_sk_pkt_out_cnt(int accept_fd, int cli_fd)
> > +{
> > +	struct bpf_spinlock_cnt pkt_out_cnt =3D {} , pkt_out_cnt10 =3D {};
> > +	int err;
> > +
> > +	pkt_out_cnt.cnt =3D ~0;
> > +	pkt_out_cnt10.cnt =3D ~0;
> > +	err =3D bpf_map_lookup_elem(sk_pkt_out_cnt_fd, &accept_fd, &pkt_out_c=
nt);
> > +	if (!err)
> > +		err =3D bpf_map_lookup_elem(sk_pkt_out_cnt10_fd, &accept_fd,
> > +					  &pkt_out_cnt10);
> > +
> > +	/* The bpf prog only counts for fullsock and
> > +	 * passive conneciton did not become fullsock until 3WHS
> > +	 * had been finished.
> > +	 * The bpf prog only counted two data packet out but we
> > +	 * specially init accept_fd's pkt_out_cnt by 2 in
> > +	 * init_sk_storage().  Hence, 4 here.
> > +	 */
> > +	CHECK(err || pkt_out_cnt.cnt !=3D 4 || pkt_out_cnt10.cnt !=3D 40,
> > +	      "bpf_map_lookup_elem(sk_pkt_out_cnt, &accept_fd)",
> > +	      "err:%d errno:%d pkt_out_cnt:%u pkt_out_cnt10:%u",
> > +	      err, errno, pkt_out_cnt.cnt, pkt_out_cnt10.cnt);
> > +
> > +	pkt_out_cnt.cnt =3D ~0;
> > +	pkt_out_cnt10.cnt =3D ~0;
> > +	err =3D bpf_map_lookup_elem(sk_pkt_out_cnt_fd, &cli_fd, &pkt_out_cnt)=
;
> > +	if (!err)
> > +		err =3D bpf_map_lookup_elem(sk_pkt_out_cnt10_fd, &cli_fd,
> > +					  &pkt_out_cnt10);
> > +	/* Active connection is fullsock from the beginning.
> > +	 * 1 SYN and 1 ACK during 3WHS
> > +	 * 2 Acks on data packet.
> > +	 *
> > +	 * The bpf_prog initialized it to 0xeB9F.
> > +	 */
> > +	CHECK(err || pkt_out_cnt.cnt !=3D 0xeB9F + 4 ||
> > +	      pkt_out_cnt10.cnt !=3D 0xeB9F + 40,
> > +	      "bpf_map_lookup_elem(sk_pkt_out_cnt, &cli_fd)",
> > +	      "err:%d errno:%d pkt_out_cnt:%u pkt_out_cnt10:%u",
> > +	      err, errno, pkt_out_cnt.cnt, pkt_out_cnt10.cnt);
> > +}
> > +
> > +static void init_sk_storage(int sk_fd, __u32 pkt_out_cnt)
> > +{
> > +	struct bpf_spinlock_cnt scnt =3D {};
> > +	int err;
> > +
> > +	scnt.cnt =3D pkt_out_cnt;
> > +	err =3D bpf_map_update_elem(sk_pkt_out_cnt_fd, &sk_fd, &scnt,
> > +				  BPF_NOEXIST);
> > +	CHECK(err, "bpf_map_update_elem(sk_pkt_out_cnt_fd)",
> > +	      "err:%d errno:%d", err, errno);
> > +
> > +	scnt.cnt *=3D 10;
> > +	err =3D bpf_map_update_elem(sk_pkt_out_cnt10_fd, &sk_fd, &scnt,
> > +				  BPF_NOEXIST);
> > +	CHECK(err, "bpf_map_update_elem(sk_pkt_out_cnt10_fd)",
> > +	      "err:%d errno:%d", err, errno);
> > +}
> > +
> >  static void test(void)
> >  {
> >  	int listen_fd, cli_fd, accept_fd, epfd, err;
> >  	struct epoll_event ev;
> >  	socklen_t addrlen;
> > +	int i;
> > =20
> >  	addrlen =3D sizeof(struct sockaddr_in6);
> >  	ev.events =3D EPOLLIN;
> > @@ -308,24 +377,30 @@ static void test(void)
> >  	      accept_fd, errno);
> >  	close(listen_fd);
> > =20
> > -	/* Send some data from accept_fd to cli_fd */
> > -	err =3D send(accept_fd, DATA, DATA_LEN, 0);
> > -	CHECK(err !=3D DATA_LEN, "send(accept_fd)", "err:%d errno:%d",
> > -	      err, errno);
> > -
> > -	/* Have some timeout in recv(cli_fd). Just in case. */
> >  	ev.data.fd =3D cli_fd;
> >  	err =3D epoll_ctl(epfd, EPOLL_CTL_ADD, cli_fd, &ev);
> >  	CHECK(err, "epoll_ctl(EPOLL_CTL_ADD, cli_fd)", "err:%d errno:%d",
> >  	      err, errno);
> > =20
> > -	err =3D epoll_wait(epfd, &ev, 1, 1000);
> > -	CHECK(err !=3D 1 || ev.data.fd !=3D cli_fd,
> > -	      "epoll_wait(cli_fd)", "err:%d errno:%d ev.data.fd:%d cli_fd:%d"=
,
> > -	      err, errno, ev.data.fd, cli_fd);
> > +	init_sk_storage(accept_fd, 2);
> > =20
> > -	err =3D recv(cli_fd, NULL, 0, MSG_TRUNC);
> > -	CHECK(err, "recv(cli_fd)", "err:%d errno:%d", err, errno);
> > +	for (i =3D 0; i < 2; i++) {
> > +		/* Send some data from accept_fd to cli_fd */
> > +		err =3D send(accept_fd, DATA, DATA_LEN, 0);
> > +		CHECK(err !=3D DATA_LEN, "send(accept_fd)", "err:%d errno:%d",
> > +		      err, errno);
> > +
> > +		/* Have some timeout in recv(cli_fd). Just in case. */
> > +		err =3D epoll_wait(epfd, &ev, 1, 1000);
> > +		CHECK(err !=3D 1 || ev.data.fd !=3D cli_fd,
> > +		      "epoll_wait(cli_fd)", "err:%d errno:%d ev.data.fd:%d cli_fd:%d=
",
> > +		      err, errno, ev.data.fd, cli_fd);
> > +
> > +		err =3D recv(cli_fd, NULL, 0, MSG_TRUNC);
> > +		CHECK(err, "recv(cli_fd)", "err:%d errno:%d", err, errno);
> > +	}
> > +
> > +	check_sk_pkt_out_cnt(accept_fd, cli_fd);
> > =20
> >  	close(epfd);
> >  	close(accept_fd);
> > @@ -395,6 +470,14 @@ int main(int argc, char **argv)
> >  	CHECK(!map, "cannot find linum_map", "(null)");
> >  	linum_map_fd =3D bpf_map__fd(map);
> > =20
> > +	map =3D bpf_object__find_map_by_name(obj, "sk_pkt_out_cnt");
> > +	CHECK(!map, "cannot find sk_pkt_out_cnt", "(null)");
> > +	sk_pkt_out_cnt_fd =3D bpf_map__fd(map);
> > +
> > +	map =3D bpf_object__find_map_by_name(obj, "sk_pkt_out_cnt10");
> > +	CHECK(!map, "cannot find sk_pkt_out_cnt10", "(null)");
> > +	sk_pkt_out_cnt10_fd =3D bpf_map__fd(map);
> > +
> >  	test();
> > =20
> >  	bpf_object__close(obj);
> > --=20
> > 2.17.1
> >=20
