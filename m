Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C926FC43218
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 18:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A07820679
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 18:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RKRRf57F";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SbbZYwHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDZSE5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:04:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40520 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbfDZSE5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 14:04:57 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QI4Bop020182;
        Fri, 26 Apr 2019 11:04:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ACWLLdIAKAvghMMITQvrnc4Tj6aRblty/LgSUFMgLsU=;
 b=RKRRf57FHDnlnEyyAFmlARDtEj2b22ssjbN849f0NVcSlYZiZnYmUQDz2nFiKbHtS84H
 dw3CLMYQBxKBqoNTAdQYDMA48Xy/DPh5AKemLEtGiD25L8tejjEYmY41e2Pv6BJ4XKxA
 lZP35CePjOR8/zZiQYfVZhlE+VI6BIP3rfc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s416as673-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Apr 2019 11:04:33 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Apr 2019 11:04:31 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 26 Apr 2019 11:04:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACWLLdIAKAvghMMITQvrnc4Tj6aRblty/LgSUFMgLsU=;
 b=SbbZYwHksom8s9oQ8O6XFW90ILG+rIUSc2o/MIewfxZ7SbcXtOtHTJd3V7WDKesbaWOcIQZOQKVANaZRGnRyvY2bPR3LMtOECEBIcbEqv+SONRmmaADyhVFm+Qn0up3eCAl25pbKuoG4FDRXmXR/fL5p+8y4IcopAFBbBBVFVSQ=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1472.namprd15.prod.outlook.com (10.173.234.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 18:04:14 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 18:04:14 +0000
From:   Martin Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 1/6] bpf: Introduce bpf sk local storage
Thread-Topic: [PATCH v2 bpf-next 1/6] bpf: Introduce bpf sk local storage
Thread-Index: AQHU+8SP0khR36spq0yGA4fa43XmYqZOswwAgAAKUYA=
Date:   Fri, 26 Apr 2019 18:04:13 +0000
Message-ID: <20190426180411.vntu3jm2oyt5cghj@kafai-mbp.dhcp.thefacebook.com>
References: <20190426001042.851372-1-kafai@fb.com>
 <20190426001043.851430-1-kafai@fb.com>
 <9452fd5c-af81-3764-4c90-052235f1bb7d@fb.com>
In-Reply-To: <9452fd5c-af81-3764-4c90-052235f1bb7d@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:104:6::25) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:7ae1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b700889-7820-402b-8bc3-08d6ca719719
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1472;
x-ms-traffictypediagnostic: MWHPR15MB1472:
x-microsoft-antispam-prvs: <MWHPR15MB1472302F842E3F59D0D25C11D53E0@MWHPR15MB1472.namprd15.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(30864003)(73956011)(6246003)(66946007)(25786009)(53546011)(68736007)(6486002)(386003)(6862004)(6506007)(4326008)(66556008)(66476007)(64756008)(66446008)(8936002)(446003)(7736002)(305945005)(76176011)(186003)(86362001)(71200400001)(71190400001)(476003)(6436002)(11346002)(53936002)(229853002)(97736004)(53946003)(316002)(52116002)(6116002)(256004)(14444005)(9686003)(5660300002)(6512007)(2906002)(102836004)(486006)(99286004)(14454004)(81156014)(8676002)(81166006)(1076003)(478600001)(54906003)(46003)(6636002)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1472;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wltteUs6aCwbzplRd5tcjuaCgjdctZsJED0avEM1+Udgf1DEGaodM/asepXMVTv6BJIBCDo+CtMQytWXpYqvI+Nm4dUy6VnvJxogVzp+8vxvV0M0b5K35LnOsJcOzH8DKifGY+MRducpf4Q+/Q20Vzx6gP64kJRGIB7RaAuLJS6hv0jmZ5Fh9Uvdf5ND0GaeHUzIa/P8m8bat7+7DonRubpJxEZFWJyO113T0hooFpf7Ha9eG8AOJ8z6ES/ufMM133QU9AW3gQg/a+ib3zJt0cLSShZGQQWvHYI0rYM6uIs0bds/08IntS47SyrxKDbQ7I+kKkyVVV151yJryQfQPMhYqAdhgfReSw3py7LlqJmMmQwub4ThiwAw/zTYOVOhJViD97TR80PTGlc1jehe+nnK3S9vTXN93IMG9cYIbFM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E9A812BC5E9244C9C47E975C4243A5F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b700889-7820-402b-8bc3-08d6ca719719
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 18:04:13.9947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1472
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260123
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 26, 2019 at 10:27:16AM -0700, Yonghong Song wrote:
>=20
>=20
> On 4/25/19 5:10 PM, Martin KaFai Lau wrote:
> > After allowing a bpf prog to
> > - directly read the skb->sk ptr
> > - get the fullsock bpf_sock by "bpf_sk_fullsock()"
> > - get the bpf_tcp_sock by "bpf_tcp_sock()"
> > - get the listener sock by "bpf_get_listener_sock()"
> > - avoid duplicating the fields of "(bpf_)sock" and "(bpf_)tcp_sock"
> >    into different bpf running context.
> >=20
> > this patch is another effort to make bpf's network programming
> > more intuitive to do (together with memory and performance benefit).
> >=20
> > When bpf prog needs to store data for a sk, the current practice is to
> > define a map with the usual 4-tuples (src/dst ip/port) as the key.
> > If multiple bpf progs require to store different sk data, multiple maps
> > have to be defined.  Hence, wasting memory to store the duplicated
> > keys (i.e. 4 tuples here) in each of the bpf map.
> > [ The smallest key could be the sk pointer itself which requires
> >    some enhancement in the verifier and it is a separate topic. ]
> >=20
> > Also, the bpf prog needs to clean up the elem when sk is freed.
> > Otherwise, the bpf map will become full and un-usable quickly.
> > The sk-free tracking currently could be done during sk state
> > transition (e.g. BPF_SOCK_OPS_STATE_CB).
> >=20
> > The size of the map needs to be predefined which then usually ended-up
> > with an over-provisioned map in production.  Even the map was re-sizabl=
e,
> > while the sk naturally come and go away already, this potential re-size
> > operation is arguably redundant if the data can be directly connected
> > to the sk itself instead of proxy-ing through a bpf map.
> >=20
> > This patch introduces sk->sk_bpf_storage to provide local storage space
> > at sk for bpf prog to use.  The space will be allocated when the first =
bpf
> > prog has created data for this particular sk.
> >=20
> > The design optimizes the bpf prog's lookup (and then optionally followe=
d by
> > an inline update).  bpf_spin_lock should be used if the inline update n=
eeds
> > to be protected.
> >=20
> > BPF_MAP_TYPE_SK_STORAGE:
> > -----------------------
> > To define a bpf "sk-local-storage", a BPF_MAP_TYPE_SK_STORAGE map (new =
in
> > this patch) needs to be created.  Multiple BPF_MAP_TYPE_SK_STORAGE maps=
 can
> > be created to fit different bpf progs' needs.  The map enforces
> > BTF to allow printing the sk-local-storage during a system-wise
> > sk dump (e.g. "ss -ta") in the future.
> >=20
> > The purpose of a BPF_MAP_TYPE_SK_STORAGE map is not for lookup/update/d=
elete
> > a "sk-local-storage" data from a particular sk.
> > Think of the map as a meta-data (or "type") of a "sk-local-storage".  T=
his
> > particular "type" of "sk-local-storage" data can then be stored in any =
sk.
> >=20
> > The main purposes of this map are mostly:
> > 1. Define the size of a "sk-local-storage" type.
> > 2. Provide a similar syscall userspace API as the map (e.g. lookup/upda=
te,
> >     map-id, map-btf...etc.)
> > 3. Keep track of all sk's storages of this "type" and clean them up
> >     when the map is freed.
> >=20
> > sk->sk_bpf_storage:
> > ------------------
> > The main lookup/update/delete is done on sk->sk_bpf_storage (which
> > is a "struct bpf_sk_storage").  When doing a lookup,
> > the "map" pointer is now used as the "key" to search on the
> > sk_storage->list.  The "map" pointer is actually serving
> > as the "type" of the "sk-local-storage" that is being
> > requested.
> >=20
> > To allow very fast lookup, it should be as fast as looking up an
> > array at a stable-offset.  At the same time, it is not ideal to
> > set a hard limit on the number of sk-local-storage "type" that the
> > system can have.  Hence, this patch takes a cache approach.
> > The last search result from sk_storage->list is cached in
> > sk_storage->cache[] which is a stable sized array.  Each
> > "sk-local-storage" type has a stable offset to the cache[] array.
> > In the future, a map's flag could be introduced to do cache
> > opt-out/enforcement if it became necessary.
> >=20
> > All data will be removed from sk->sk_bpf_storage during
> > sk destruction.
> >=20
> > bpf_sk_storage_get() and bpf_sk_storage_delete():
> > ------------------------------------------------
> > Instead of using bpf_map_(lookup|update|delete)_elem(),
> > the bpf prog needs to use the new helper bpf_sk_storage_get() and
> > bpf_sk_storage_delete().  The verifier can then enforce the
> > ARG_PTR_TO_SOCKET argument.  The bpf_sk_storage_get() also allows to
> > "create" new elem if one does not exist in the sk.  It is done by
> > the new BPF_SK_STORAGE_GET_F_CREATE flag.  An optional value can also b=
e
> > provided as the initial value during BPF_SK_STORAGE_GET_F_CREATE.
> > The BPF_MAP_TYPE_SK_STORAGE also supports bpf_spin_lock.  Together,
> > it has eliminated the potential use cases for an equivalent
> > bpf_map_update_elem() API (for bpf_prog) in this patch.
> >=20
> > Misc notes:
> > ----------
> > 1. map_get_next_key is not supported.  From the userspace syscall
> >     perspective,  the map has the socket fd as the key while the map
> >     can be shared by pinned-file or map-id.
> >=20
> >     Since btf is enforced, the existing "ss" could be enhanced to prett=
y
> >     print the local-storage.
> >=20
> >     Supporting a kernel defined btf with 4 tuples as the return key cou=
ld
> >     be explored later also.
> >=20
> > 2. The sk->sk_lock cannot be acquired.  Atomic operations is used inste=
ad.
> >     e.g. cmpxchg is done on the sk->sk_bpf_storage ptr.
> >     Please refer to the source code comments for the details in
> >     synchronization cases and considerations.
> >=20
> > 3. The mem is charged to the sk->sk_omem_alloc as the sk filter does.
> >=20
> > Benchmark:
> > ---------
> > Here is the benchmark data collected by turning on
> > the "kernel.bpf_stats_enabled" sysctl.
> > Two bpf progs are tested:
> >=20
> > One bpf prog with the usual bpf hashmap (max_entries =3D 8192) with the
> > sk ptr as the key. (verifier is modified to support sk ptr as the key
> > That should have shortened the key lookup time.)
> >=20
> > Another bpf prog is with the new BPF_MAP_TYPE_SK_STORAGE.
> >=20
> > Both are storing a "u32 cnt", do a lookup on "egress_skb/cgroup" for
> > each egress skb and then bump the cnt.  netperf is used to drive
> > data with 4096 connected UDP sockets.
> >=20
> > BPF_MAP_TYPE_HASH with a modifier verifier (152ns per bpf run)
> > 27: cgroup_skb  name egress_sk_map  tag 74f56e832918070b run_time_ns 58=
280107540 run_cnt 381347633
> >      loaded_at 2019-04-15T13:46:39-0700  uid 0
> >      xlated 344B  jited 258B  memlock 4096B  map_ids 16
> >      btf_id 5
> >=20
> > BPF_MAP_TYPE_SK_STORAGE in this patch (66ns per bpf run)
> > 30: cgroup_skb  name egress_sk_stora  tag d4aa70984cc7bbf6 run_time_ns =
25617093319 run_cnt 390989739
> >      loaded_at 2019-04-15T13:47:54-0700  uid 0
> >      xlated 168B  jited 156B  memlock 4096B  map_ids 17
> >      btf_id 6
> >=20
> > Here is a high-level picture on how are the objects organized:
> >=20
> >         sk
> >      +------+
> >      |      |
> >      |      |
> >      |      |
> >      |*sk_bpf_storage-----> bpf_sk_storage
> >      +------+                 +-------+
> >                   +-----------+ list  |
> >                   |           |       |
> >                   |           |       |
> >                   |           |       |
> >                   |           +-------+
> >                   |
> >                   |     elem
> >                   |  +--------+
> >                   +->| snode  |
> >                   |  +--------+
> >                   |  |  data  |          bpf_map
> >                   |  +--------+        +---------+
> >                   |  |map_node|<-+-----+  list   |
> >                   |  +--------+  |     |         |
> >                   |              |     |         |
> >                   |     elem     |     |         |
> >                   |  +--------+  |     +---------+
> >                   +->| snode  |  |
> >                      +--------+  |
> >     bpf_map          |  data  |  |
> >   +---------+        +--------+  |
> >   |  list   +------->|map_node|  |
> >   |         |        +--------+  |
> >   |         |                    |
> >   |         |           elem     |
> >   +---------+        +--------+  |
> >                   +->| snode  |  |
> >                   |  +--------+  |
> >                   |  |  data  |  |
> >                   |  +--------+  |
> >                   |  |map_node|<-+
> >                   |  +--------+
> >                   |
> >                   |
> >                   |          +-------+
> >       sk          +----------| list  |
> >    +------+                  |       |
> >    |      |                  |       |
> >    |      |                  |       |
> >    |      |                  +-------+
> >    |*sk_bpf_storage------->bpf_sk_storage
> >    +------+
> >=20
> > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
>=20
> Thanks. Generally look good. I have a few comments below.
>=20
> > ---
> >   include/linux/bpf.h          |   2 +
> >   include/linux/bpf_types.h    |   1 +
> >   include/net/bpf_sk_storage.h |  13 +
> >   include/net/sock.h           |   5 +
> >   include/uapi/linux/bpf.h     |  44 +-
> >   kernel/bpf/syscall.c         |   3 +-
> >   kernel/bpf/verifier.c        |  27 +-
> >   net/bpf/test_run.c           |   2 +
> >   net/core/Makefile            |   1 +
> >   net/core/bpf_sk_storage.c    | 796 ++++++++++++++++++++++++++++++++++=
+
> >   net/core/filter.c            |  12 +
> >   net/core/sock.c              |   5 +
> >   12 files changed, 906 insertions(+), 5 deletions(-)
> >   create mode 100644 include/net/bpf_sk_storage.h
> >   create mode 100644 net/core/bpf_sk_storage.c
> >=20
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index f15432d90728..0d2788beacd2 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -184,6 +184,7 @@ enum bpf_arg_type {
> >   	ARG_PTR_TO_MAP_KEY,	/* pointer to stack used as map key */
> >   	ARG_PTR_TO_MAP_VALUE,	/* pointer to stack used as map value */
> >   	ARG_PTR_TO_UNINIT_MAP_VALUE,	/* pointer to valid memory used to stor=
e a map value */
> > +	ARG_PTR_TO_MAP_VALUE_OR_NULL,	/* pointer to stack used as map value o=
r NULL */
> >  =20
> >   	/* the following constraints used to prototype bpf_memcmp() and othe=
r
> >   	 * functions that access data on eBPF program stack
> > @@ -204,6 +205,7 @@ enum bpf_arg_type {
> >   	ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
> >   	ARG_PTR_TO_INT,		/* pointer to int */
> >   	ARG_PTR_TO_LONG,	/* pointer to long */
> > +	ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
> >   };
> >  =20
> >   /* type of values returned from helper functions */
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > index d26991a16894..eb1e4f867a5e 100644
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> > @@ -60,6 +60,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY_OF_MAPS, array_of_map=
s_map_ops)
> >   BPF_MAP_TYPE(BPF_MAP_TYPE_HASH_OF_MAPS, htab_of_maps_map_ops)
> >   #ifdef CONFIG_NET
> >   BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP, dev_map_ops)
> > +BPF_MAP_TYPE(BPF_MAP_TYPE_SK_STORAGE, sk_storage_map_ops)
> >   #if defined(CONFIG_BPF_STREAM_PARSER)
> >   BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKMAP, sock_map_ops)
> >   BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKHASH, sock_hash_ops)
> > diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.=
h
> > new file mode 100644
> > index 000000000000..b9dcb02e756b
> > --- /dev/null
> > +++ b/include/net/bpf_sk_storage.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2019 Facebook */
> > +#ifndef _BPF_SK_STORAGE_H
> > +#define _BPF_SK_STORAGE_H
> > +
> > +struct sock;
> > +
> > +void bpf_sk_storage_free(struct sock *sk);
> > +
> > +extern const struct bpf_func_proto bpf_sk_storage_get_proto;
> > +extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
> > +
> > +#endif /* _BPF_SK_STORAGE_H */
> [...]
> > +
> > +static struct bpf_sk_storage_data *
> > +__sk_storage_lookup(struct bpf_sk_storage *sk_storage,
> > +		    struct bpf_sk_storage_map *smap,
> > +		    bool cacheit_lockit)
> > +{
> > +	struct bpf_sk_storage_data *sdata;
> > +	struct bpf_sk_storage_elem *selem;
> > +
> > +	/* Fast path (cache hit) */
> > +	sdata =3D rcu_dereference(sk_storage->cache[smap->cache_idx]);
> > +	if (sdata && rcu_access_pointer(sdata->smap) =3D=3D smap)
> > +		return sdata;
> > +
> > +	/* Slow path (cache miss) */
> > +	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode)
> > +		if (rcu_access_pointer(SDATA(selem)->smap) =3D=3D smap)
> > +			break;
> > +
> > +	if (!selem)
> > +		return NULL;
> > +
> > +	sdata =3D SDATA(selem);
> > +	if (cacheit_lockit) {
> > +		/* spinlock is needed to avoid racing with the
> > +		 * parallel delete.  Otherwise, publishing an already
> > +		 * deleted sdata to the cache will become a use-after-free
> > +		 * problem in the next __sk_storage_lookup().
> > +		 */
> > +		raw_spin_lock_bh(&sk_storage->lock);
> > +		if (selem_linked_to_sk(selem))
> > +			rcu_assign_pointer(sk_storage->cache[smap->cache_idx],
> > +					   sdata);
> > +		raw_spin_unlock_bh(&sk_storage->lock);
> > +	}
> > +
> > +	return sdata;
> > +}
> > +
> > +static struct bpf_sk_storage_data *
> > +sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_l=
ockit)
> > +{
> > +	struct bpf_sk_storage *sk_storage;
> > +	struct bpf_sk_storage_map *smap;
> > +
> > +	sk_storage =3D rcu_dereference(sk->sk_bpf_storage);
> > +	if (!sk_storage)
> > +		return NULL;
> > +
> > +	smap =3D (struct bpf_sk_storage_map *)map;
> > +	return __sk_storage_lookup(sk_storage, smap, cacheit_lockit);
> > +}
> > +
> > +static int check_flags(const struct bpf_sk_storage_data *old_sdata,
> > +		       u64 map_flags)
> > +{
> > +	if (old_sdata && (map_flags & ~BPF_F_LOCK) =3D=3D BPF_NOEXIST)
> > +		/* elem already exists */
> > +		return -EEXIST;
> > +
> > +	if (!old_sdata && (map_flags & ~BPF_F_LOCK) =3D=3D BPF_EXIST)
> > +		/* elem doesn't exist, cannot update it */
> > +		return -ENOENT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int sk_storage_alloc(struct sock *sk,
> > +			    struct bpf_sk_storage_map *smap,
> > +			    struct bpf_sk_storage_elem *first_selem)
> > +{
> > +	struct bpf_sk_storage *prev_sk_storage, *sk_storage;
> > +	int err;
> > +
> > +	err =3D omem_charge(sk, sizeof(*sk_storage));
> > +	if (err)
> > +		return err;
> > +
> > +	sk_storage =3D kzalloc(sizeof(*sk_storage), GFP_ATOMIC | __GFP_NOWARN=
);
> > +	if (!sk_storage) {
> > +		err =3D -ENOMEM;
> > +		goto uncharge;
> > +	}
> > +	INIT_HLIST_HEAD(&sk_storage->list);
> > +	raw_spin_lock_init(&sk_storage->lock);
> > +	sk_storage->sk =3D sk;
> > +
> > +	__selem_link_sk(sk_storage, first_selem);
> > +	selem_link_map(smap, first_selem);
> > +	/* Publish sk_storage to sk.  sk->sk_lock cannot be acquired.
> > +	 * Hence, atomic ops is used to set sk->sk_bpf_storage
> > +	 * from NULL to the newly allocated sk_storage ptr.
> > +	 *
> > +	 * From now on, the sk->sk_bpf_storage pointer is protected
> > +	 * by the sk_storage->lock.  Hence,  when freeing
> > +	 * the sk->sk_bpf_storage, the sk_storage->lock must
> > +	 * be held before setting sk->sk_bpf_storage to NULL.
> > +	 */
> > +	prev_sk_storage =3D cmpxchg((struct bpf_sk_storage **)&sk->sk_bpf_sto=
rage,
> > +				  NULL, sk_storage);
> > +	if (unlikely(prev_sk_storage)) {
> > +		selem_unlink_map(first_selem);
> > +		err =3D -EAGAIN;
> > +		goto uncharge;
> > +
> > +		/* Note that even first_selem was linked to smap's
> > +		 * bucket->list, first_selem can be freed immediately
> > +		 * (instead of kfree_rcu) because
> > +		 * bpf_sk_storage_map_free() does a
> > +		 * synchronize_rcu() before walking the bucket->list.
> > +		 * Hence, no one is accessing selem from the
> > +		 * bucket->list under rcu_read_lock().
> > +		 */
> > +	}
> > +
> > +	return 0;
> > +
> > +uncharge:
> > +	kfree(sk_storage);
> > +	atomic_sub(sizeof(*sk_storage), &sk->sk_omem_alloc);
> > +	return err;
> > +}
> > +
> > +/* sk cannot be going away because it is linking new elem
> > + * to sk->sk_bpf_storage. (i.e. sk->sk_refcnt cannot be 0).
> > + * Otherwise, it will become a leak (and other memory issues
> > + * during map destruction).
> > + */
> > +static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
> > +						     struct bpf_map *map,
> > +						     void *value,
> > +						     u64 map_flags)
> > +{
> > +	struct bpf_sk_storage_data *old_sdata =3D NULL;
> > +	struct bpf_sk_storage_elem *selem;
> > +	struct bpf_sk_storage *sk_storage;
> > +	struct bpf_sk_storage_map *smap;
> > +	int err;
> > +
> > +	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
> > +	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
> > +	    /* BPF_F_LOCK can only be used in a value with spin_lock */
> > +	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map=
)))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	smap =3D (struct bpf_sk_storage_map *)map;
> > +	sk_storage =3D rcu_dereference(sk->sk_bpf_storage);
> > +	if (!sk_storage || hlist_empty(&sk_storage->list)) {
>=20
> Is it possible sk_storage is not NULL and hlist_empty(&sk_storage->list)=
=20
> is true?
Very unlikely but possible.  Note that the sk->sk_bpf_storage ptr is protec=
ted
by atomic cmpxchg().

> Is this case, should we avoid allocation of new sk_storage at all?
It should still try which has a good chance that the cmpxchg(..., NULL, ...=
)
in sk_storage_alloc() will succeed.

>=20
> > +		/* Very first elem for this sk */
> > +		err =3D check_flags(NULL, map_flags);
> > +		if (err)
> > +			return ERR_PTR(err);
> > +
> > +		selem =3D selem_alloc(smap, sk, value, true);
> > +		if (!selem)
> > +			return ERR_PTR(-ENOMEM);
> > +
> > +		err =3D sk_storage_alloc(sk, smap, selem);
> > +		if (err) {
> > +			kfree(selem);
> > +			atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
>=20
> discharding sk->sk_omem_alloc already happens in sk_storage_alloc?
They are discharging two different things.
sk_storage_alloc() discharges the sk_storage.
Here it dischages the selem.

>=20
> > +			return ERR_PTR(err);
> > +		}
> > +
> > +		return SDATA(selem);
> > +	}
> > +
> > +	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
> > +		/* Hoping to find an old_sdata to do inline update
> > +		 * such that it can avoid taking the sk_storage->lock
> > +		 * and changing the lists.
> > +		 */
> > +		old_sdata =3D __sk_storage_lookup(sk_storage, smap, false);
> > +		err =3D check_flags(old_sdata, map_flags);
> > +		if (err)
> > +			return ERR_PTR(err);
> > +		if (old_sdata && selem_linked_to_sk(SELEM(old_sdata))) {
> > +			copy_map_value_locked(map, old_sdata->data,
> > +					      value, false);
> > +			return old_sdata;
> > +		}
> > +	}
> > +
> > +	raw_spin_lock_bh(&sk_storage->lock);
> > +
> > +	/* Recheck sk_storage->list under sk_storage->lock */
> > +	if (unlikely(hlist_empty(&sk_storage->list))) {
> > +		/* A parallel del is happening and sk_storage is going
> > +		 * away.  It has just been checked before, so very
> > +		 * unlikely.  Return instead of retry to keep things
> > +		 * simple.
> > +		 */
> > +		err =3D -EAGAIN;
> > +		goto unlock_err;
> > +	}
> > +
> > +	old_sdata =3D __sk_storage_lookup(sk_storage, smap, false);
> > +	err =3D check_flags(old_sdata, map_flags);
> > +	if (err)
> > +		goto unlock_err;
> > +
> > +	if (old_sdata && (map_flags & BPF_F_LOCK)) {
> > +		copy_map_value_locked(map, old_sdata->data, value, false);
> > +		selem =3D SELEM(old_sdata);
> > +		goto unlock;
> > +	}
> > +
> > +	/* sk_storage->lock is held.  Hence, we are sure
> > +	 * we can unlink and uncharge the old_sdata successfully
> > +	 * later.  Hence, instead of charging the new selem now
> > +	 * and then uncharge the old selem later (which may cause
> > +	 * a potential but unnecessary charge failure),  avoid taking
> > +	 * a charge at all here (the "!old_sdata" check) and the
> > +	 * old_sdata will not be uncharged later during __selem_unlink_sk().
> > +	 */
> > +	selem =3D selem_alloc(smap, sk, value, !old_sdata);
> > +	if (!selem) {
> > +		err =3D -ENOMEM;
> > +		goto unlock_err;
> > +	}
> > +
> > +	/* First, link the new selem to the map */
> > +	selem_link_map(smap, selem);
> > +
> > +	/* Second, link (and publish) the new selem to sk_storage */
> > +	__selem_link_sk(sk_storage, selem);
> > +
> > +	/* Third, remove old selem, SELEM(old_sdata) */
> > +	if (old_sdata) {
> > +		selem_unlink_map(SELEM(old_sdata));
> > +		__selem_unlink_sk(sk_storage, SELEM(old_sdata), false);
> > +	}
> > +
> > +unlock:
> > +	raw_spin_unlock_bh(&sk_storage->lock);
> > +	return SDATA(selem);
> > +
> > +unlock_err:
> > +	raw_spin_unlock_bh(&sk_storage->lock);
> > +	return ERR_PTR(err);
> > +}
> > +
> > +static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
> > +{
> > +	struct bpf_sk_storage_data *sdata;
> > +
> > +	sdata =3D sk_storage_lookup(sk, map, false);
> > +	if (!sdata)
> > +		return -ENOENT;
> > +
> > +	selem_unlink(SELEM(sdata));
> > +
> > +	return 0;
> > +}
> > +
> [...]
> > +static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
> > +{
> > +	struct bpf_sk_storage_map *smap;
> > +	unsigned int i;
> > +	u32 nbuckets;
> > +	u64 cost;
> > +
> > +	if (attr->map_flags !=3D BPF_F_NO_PREALLOC || attr->max_entries ||
> > +	    attr->key_size !=3D sizeof(int) || !attr->value_size ||
> > +	    /* Enforce BTF for userspace sk dumping */
> > +	    !attr->btf_key_type_id || !attr->btf_value_type_id)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return ERR_PTR(-EPERM);
> > +
> > +	if (attr->value_size >=3D KMALLOC_MAX_SIZE -
> > +	    MAX_BPF_STACK - sizeof(struct bpf_sk_storage_elem) ||
> > +	    /* selem->elem_size is a u16 */
> > +	    attr->value_size > U16_MAX - sizeof(struct bpf_sk_storage_elem))
> > +		return ERR_PTR(-E2BIG);
> > +
> > +	smap =3D kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN);
> > +	if (!smap)
> > +		return ERR_PTR(-ENOMEM);
> > +	bpf_map_init_from_attr(&smap->map, attr);
> > +
> > +	smap->bucket_log =3D ilog2(roundup_pow_of_two(num_possible_cpus()));
> > +	nbuckets =3D 1U << smap->bucket_log;
> > +	smap->buckets =3D kvcalloc(sizeof(*smap->buckets), nbuckets,
> > +				 GFP_USER | __GFP_NOWARN);
> > +	if (!smap->buckets) {
> > +		kfree(smap);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +	cost =3D sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
> > +
> > +	for (i =3D 0; i < nbuckets; i++) {
> > +		INIT_HLIST_HEAD(&smap->buckets[i].list);
> > +		raw_spin_lock_init(&smap->buckets[i].lock);
> > +	}
> > +
> > +	smap->elem_size =3D sizeof(struct bpf_sk_storage_elem) + attr->value_=
size;
> > +	smap->cache_idx =3D (unsigned int)atomic_inc_return(&cache_idx) %
> > +		BPF_SK_STORAGE_CACHE_SIZE;
> > +	smap->map.pages =3D round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
>=20
> should we test bpf_map_precharge_memlock() here?
I did not do it here because the size of this map does not depend on
"map.max_entries".  Meaning,
this map merely needs the memory for the buckets which is less likely to
fail (and destroying in case of final charge failure is not that expensive
either) which then makes this precheck not as useful as other maps.

Thanks for reviewing!

>=20
> > +
> > +	return &smap->map;
> > +}
> > +
> > +static int notsupp_get_next_key(struct bpf_map *map, void *key,
> > +				void *next_key)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +
> > +static int bpf_sk_storage_map_check_btf(const struct bpf_map *map,
> > +					const struct btf *btf,
> > +					const struct btf_type *key_type,
> > +					const struct btf_type *value_type)
> > +{
> > +	u32 int_data;
> > +
> > +	if (BTF_INFO_KIND(key_type->info) !=3D BTF_KIND_INT)
> > +		return -EINVAL;
> > +
> > +	int_data =3D *(u32 *)(key_type + 1);
> > +	if (BTF_INT_BITS(int_data) !=3D 32 || BTF_INT_OFFSET(int_data))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> [...]> diff --git a/net/core/sock.c b/net/core/sock.c
> > index 443b98d05f1e..9773be724aa9 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -137,6 +137,7 @@
> >  =20
> >   #include <linux/filter.h>
> >   #include <net/sock_reuseport.h>
> > +#include <net/bpf_sk_storage.h>
> >  =20
> >   #include <trace/events/sock.h>
> >  =20
> > @@ -1709,6 +1710,10 @@ static void __sk_destruct(struct rcu_head *head)
> >  =20
> >   	sock_disable_timestamp(sk, SK_FLAGS_TIMESTAMP);
> >  =20
> > +#ifdef CONFIG_BPF_SYSCALL
> > +	bpf_sk_storage_free(sk);
> > +#endif
> > +
> >   	if (atomic_read(&sk->sk_omem_alloc))
> >   		pr_debug("%s: optmem leakage (%d bytes) detected\n",
> >   			 __func__, atomic_read(&sk->sk_omem_alloc));
> >=20
