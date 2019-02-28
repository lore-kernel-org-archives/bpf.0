Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1660C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA88218D0
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UfgiPbvN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Z0E60Awm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfB1T60 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:58:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51288 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbfB1T6Z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 14:58:25 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SJoWpV006665;
        Thu, 28 Feb 2019 11:58:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vrf3SaxRB436ahNvYDYn7wACNq6UyvO6YwG+wqAJqtw=;
 b=UfgiPbvNNf4ZeMl8lwuBPPW+MZihJhd9NZUoH/ZBQISwgMSZnLjBQqoKJu4KS5VZsYWW
 XWJMsV6T7j6Lu65rH/nP9IGh6vAL83fM6wG02PLUyzMjfPML8rvyg/WGMpLBLVSO2/7J
 d3xf5mmGvSDX7VWriYxiaTMFBI2EYEUJDAs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxjv7gt2g-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 11:58:01 -0800
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 28 Feb 2019 11:56:43 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 28 Feb 2019 11:56:43 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 28 Feb 2019 11:56:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrf3SaxRB436ahNvYDYn7wACNq6UyvO6YwG+wqAJqtw=;
 b=Z0E60AwmuJXoP3HoM+tzlI62x5/195sRiTlWD4ydFeqMvVcC6Jrnw8huCKJskNQlGV1FStFDsxO084awxyhFqq8SkSx9z3+eQ3LH89boP5cGJJIi9IBqrhA+9PrSjm/QI9x+eV9pkKmLylgP5KSx6du4A6F7x8mlPODA2RVXLSk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1278.namprd15.prod.outlook.com (10.175.3.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Thu, 28 Feb 2019 19:56:41 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 19:56:41 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Song Liu <liu.song.a23@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 3/5] btf: allow to customize dedup hash table
 size
Thread-Topic: [PATCH bpf-next 3/5] btf: allow to customize dedup hash table
 size
Thread-Index: AQHUzu50Jc3vqLN1s0afd0avolWUq6X1iLSAgAAGqYCAAAMIAIAACoeAgAAEpwA=
Date:   Thu, 28 Feb 2019 19:56:41 +0000
Message-ID: <6AF6C3B6-C723-4B49-BA76-D30CA0141C1E@fb.com>
References: <20190227224642.1069138-1-andriin@fb.com>
 <20190227224642.1069138-4-andriin@fb.com>
 <CAPhsuW73_ttrf_MrBzLZrzjqMmg6yE2A5JirtzBa+PYCfdajqg@mail.gmail.com>
 <CAEf4Bzb_HS8F66GWkRCd3ZTKvo=DFTyGS-SxeswdM02OUMnvrg@mail.gmail.com>
 <743BC79E-0C97-4E71-8ED8-76D5B434B0B0@fb.com>
 <CAEf4BzYRy5bpyh49=GDg-1NCJEO7dBTQoFq3eR-gqriVhwt4Mw@mail.gmail.com>
In-Reply-To: <CAEf4BzYRy5bpyh49=GDg-1NCJEO7dBTQoFq3eR-gqriVhwt4Mw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::45c4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cb76897-9a37-4f5b-81b2-08d69db6dbb6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1278;
x-ms-traffictypediagnostic: MWHPR15MB1278:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1278;20:VqGJsU3mF1ZGIaMi1ONkS3blYKiKKZ7yOId0CqpbZJKwMXwONFZX7PPA9kihX+w03D/9IY5QewvHEHze5OuLbBXsUdji8WpBArFDavZlnWWhFfJ8gDELwG/IgKofdqjF7YGnApPdMzAJaCsaStjubkdwwBZ3XDJ7V4tumc/ZtnU=
x-microsoft-antispam-prvs: <MWHPR15MB1278E8689071C7313EA148C2B3750@MWHPR15MB1278.namprd15.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(346002)(136003)(199004)(189003)(8936002)(76176011)(2906002)(50226002)(6116002)(6506007)(99286004)(53546011)(36756003)(68736007)(6246003)(229853002)(82746002)(71200400001)(71190400001)(6436002)(6512007)(53936002)(102836004)(106356001)(105586002)(83716004)(6486002)(14444005)(256004)(57306001)(8676002)(93886005)(186003)(446003)(14454004)(11346002)(2616005)(25786009)(5660300002)(305945005)(478600001)(4326008)(486006)(46003)(7736002)(54906003)(81166006)(316002)(81156014)(476003)(97736004)(6916009)(86362001)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1278;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GA0iEqKG5nQZ3f4pxZw/aznR/vOKPBgm2AmO46LdL+6y1Al83sI1fziuyR3HvJa9rOW0kF2lYVrrTMwv4aBb9eVQZ2AgdGhFOL6xJfRHoh4y22sh1xCwz9i8Aka6DPhfw4hMw9IKvA+d6d9o4ZMCTadxwwufZE91wkmaD2NY3lIJ+S3RAR9cP+UjDSneHeRTMzTZ1FS20G5m5+RSnikYwOp0Pc6KYdyq7/ax5CwuLcU4TpV8zquVH35r09vEY6/1JxeIkkJGw5KeKtqC794UsKlfTB8rnpxHijKz2ogW2v8c9/PIeyhDe/Mn5QcC5d6u1QK3yrS6WmtiofW6ObBejH/wdOU6eNE7fGaFe34u+cF9Ap3WuqNGmey5WeIuGYLVfb+3Frte4ug8gjQjUYyz5Q3Db7duPYQgLPv+/Ke6QIk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1FFFCE94A6C264BA87D637B2882E9AC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb76897-9a37-4f5b-81b2-08d69db6dbb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 19:56:41.3091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1278
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 28, 2019, at 11:40 AM, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
>=20
> On Thu, Feb 28, 2019 at 11:02 AM Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Feb 28, 2019, at 10:51 AM, Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
>>>=20
>>> On Thu, Feb 28, 2019 at 10:27 AM Song Liu <liu.song.a23@gmail.com> wrot=
e:
>>>>=20
>>>> On Wed, Feb 27, 2019 at 2:47 PM Andrii Nakryiko <andriin@fb.com> wrote=
:
>>>>>=20
>>>>> Default size of dedup table (16k) is good enough for most binaries, e=
ven
>>>>> typical vmlinux images. But there are cases of binaries with huge amo=
unt
>>>>> of BTF types (e.g., allyesconfig variants of kernel), which benefit f=
rom
>>>>> having bigger dedup table size to lower amount of unnecessary hash
>>>>> collisions. Tools like pahole, thus, can tune this parameter to reach
>>>>> optimal performance.
>>>>>=20
>>>>> This change also serves double purpose of allowing tests to force has=
h
>>>>> collisions to test some corner cases, used in follow up patch.
>>>>>=20
>>>>> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>>>>> ---
>>>>> tools/lib/bpf/btf.c | 43 ++++++++++++++++++++++++++-----------------
>>>>> tools/lib/bpf/btf.h |  1 +
>>>>> 2 files changed, 27 insertions(+), 17 deletions(-)
>>>>>=20
>>>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>>>> index 68b50e9bbde1..6bbb710216e6 100644
>>>>> --- a/tools/lib/bpf/btf.c
>>>>> +++ b/tools/lib/bpf/btf.c
>>>>> @@ -1070,8 +1070,7 @@ int btf__dedup(struct btf *btf, struct btf_ext =
*btf_ext,
>>>>>       return err;
>>>>> }
>>>>>=20
>>>>> -#define BTF_DEDUP_TABLE_SIZE_LOG 14
>>>>> -#define BTF_DEDUP_TABLE_MOD ((1 << BTF_DEDUP_TABLE_SIZE_LOG) - 1)
>>>>> +#define BTF_DEDUP_TABLE_DEFAULT_SIZE (1 << 14)
>>>>> #define BTF_UNPROCESSED_ID ((__u32)-1)
>>>>> #define BTF_IN_PROGRESS_ID ((__u32)-2)
>>>>>=20
>>>>> @@ -1128,18 +1127,21 @@ static inline __u32 hash_combine(__u32 h, __u=
32 value)
>>>>> #undef GOLDEN_RATIO_PRIME
>>>>> }
>>>>>=20
>>>>> -#define for_each_hash_node(table, hash, node) \
>>>>> -       for (node =3D table[hash & BTF_DEDUP_TABLE_MOD]; node; node =
=3D node->next)
>>>>> +#define for_each_dedup_cand(d, hash, node) \
>>>>> +       for (node =3D d->dedup_table[hash & (d->opts.dedup_table_size=
 - 1)]; \
>>>>> +            node;                                                   =
      \
>>>>> +            node =3D node->next)
>>>>>=20
>>>>> static int btf_dedup_table_add(struct btf_dedup *d, __u32 hash, __u32=
 type_id)
>>>>> {
>>>>>       struct btf_dedup_node *node =3D malloc(sizeof(struct btf_dedup_=
node));
>>>>> +       int bucket =3D hash & (d->opts.dedup_table_size - 1);
>>>>>=20
>>>>>       if (!node)
>>>>>               return -ENOMEM;
>>>>>       node->type_id =3D type_id;
>>>>> -       node->next =3D d->dedup_table[hash & BTF_DEDUP_TABLE_MOD];
>>>>> -       d->dedup_table[hash & BTF_DEDUP_TABLE_MOD] =3D node;
>>>>> +       node->next =3D d->dedup_table[bucket];
>>>>> +       d->dedup_table[bucket] =3D node;
>>>>>       return 0;
>>>>> }
>>>>>=20
>>>>> @@ -1177,7 +1179,7 @@ static void btf_dedup_table_free(struct btf_ded=
up *d)
>>>>>       if (!d->dedup_table)
>>>>>               return;
>>>>>=20
>>>>> -       for (i =3D 0; i < (1 << BTF_DEDUP_TABLE_SIZE_LOG); i++) {
>>>>> +       for (i =3D 0; i < d->opts.dedup_table_size; i++) {
>>>>>               while (d->dedup_table[i]) {
>>>>>                       tmp =3D d->dedup_table[i];
>>>>>                       d->dedup_table[i] =3D tmp->next;
>>>>> @@ -1221,10 +1223,19 @@ static struct btf_dedup *btf_dedup_new(struct=
 btf *btf, struct btf_ext *btf_ext,
>>>>>       if (!d)
>>>>>               return ERR_PTR(-ENOMEM);
>>>>>=20
>>>>> +       d->opts.dont_resolve_fwds =3D opts && opts->dont_resolve_fwds=
;
>>>>> +       /* ensure table size is power of two and limit to 2G */
>>>>> +       d->opts.dedup_table_size =3D opts && opts->dedup_table_size
>>>>> +               ? opts->dedup_table_size
>>>>> +               : BTF_DEDUP_TABLE_DEFAULT_SIZE;
>>>>> +       for (i =3D 0; i < 31 && (1 << i) < d->opts.dedup_table_size; =
 i++)
>>>>> +               ;
>>>>> +       d->opts.dedup_table_size =3D 1 << i;
>>>>> +
>>>> So this is the roundup log2 logic? How about we define some marcos
>>>> to make it cleaner? Like
>>>>=20
>>>> #define BTF_DEDUP_TABLE_MAX_SIZE xxxx
>>>=20
>>> You mean hide this loop behind macro? Or specify max size as a macro?
>>> If former, I'd rather do static function, something like
>>> roundup_pow_of_2_with_max?
>>=20
>> I meant specify max size as a macro. Doing static function is also a
>> good idea.
>=20
> Ok, will do.
>=20
>>=20
>>>=20
>>>>=20
>>>> Also, how big hash table do we need for allyesconfig? 2G seems really
>>>> big to me.
>>>=20
>>> It works even with 16k and takes about 45 seconds. I didn't want to
>>> artificially limit this to something small and left it up to user.
>>> This algorithm can be used for arbitrary binaries after pahole's
>>> dwarf2btf conversion, which could be much bigger than kernel, so I
>>> didn't want to artificially limit this. Realistically, unlikely that
>>> you'll need more than 64k-128k.
>>=20
>> How about we show some warning like "You are using really big size" for
>> too big numbers, like 16M+?
>=20
> Tbh, adding extra arbitrary constant and emitting warning seems
> excessive. If it's huge number, allocation will fail and we'll return
> error. If it's just big, RSS will be high, and if user cares he should
> be able to deduce that he specified unreasonable size. In general, I
> doubt this value will be overriden often, most uses will probably just
> use default setting.

Fair enough. Let's go with 2G as-is then.=20

>=20
>>=20
>> Thanks,
>> Song
>>=20
>>>=20
>>>>=20
>>>>>       d->btf =3D btf;
>>>>>       d->btf_ext =3D btf_ext;
>>>>>=20
>>>>> -       d->dedup_table =3D calloc(1 << BTF_DEDUP_TABLE_SIZE_LOG,
>>>>> +       d->dedup_table =3D calloc(d->opts.dedup_table_size,
>>>>>                               sizeof(struct btf_dedup_node *));
>>>>>       if (!d->dedup_table) {
>>>>>               err =3D -ENOMEM;
>>>>> @@ -1249,8 +1260,6 @@ static struct btf_dedup *btf_dedup_new(struct b=
tf *btf, struct btf_ext *btf_ext,
>>>>>       for (i =3D 0; i <=3D btf->nr_types; i++)
>>>>>               d->hypot_map[i] =3D BTF_UNPROCESSED_ID;
>>>>>=20
>>>>> -       d->opts.dont_resolve_fwds =3D opts && opts->dont_resolve_fwds=
;
>>>>> -
>>>>> done:
>>>>>       if (err) {
>>>>>               btf_dedup_free(d);
>>>>> @@ -1824,7 +1833,7 @@ static int btf_dedup_prim_type(struct btf_dedup=
 *d, __u32 type_id)
>>>>>=20
>>>>>       case BTF_KIND_INT:
>>>>>               h =3D btf_hash_int(t);
>>>>> -               for_each_hash_node(d->dedup_table, h, cand_node) {
>>>>> +               for_each_dedup_cand(d, h, cand_node) {
>>>>>                       cand =3D d->btf->types[cand_node->type_id];
>>>>>                       if (btf_equal_int(t, cand)) {
>>>>>                               new_id =3D cand_node->type_id;
>>>>> @@ -1835,7 +1844,7 @@ static int btf_dedup_prim_type(struct btf_dedup=
 *d, __u32 type_id)
>>>>>=20
>>>>>       case BTF_KIND_ENUM:
>>>>>               h =3D btf_hash_enum(t);
>>>>> -               for_each_hash_node(d->dedup_table, h, cand_node) {
>>>>> +               for_each_dedup_cand(d, h, cand_node) {
>>>>>                       cand =3D d->btf->types[cand_node->type_id];
>>>>>                       if (btf_equal_enum(t, cand)) {
>>>>>                               new_id =3D cand_node->type_id;
>>>>> @@ -1846,7 +1855,7 @@ static int btf_dedup_prim_type(struct btf_dedup=
 *d, __u32 type_id)
>>>>>=20
>>>>>       case BTF_KIND_FWD:
>>>>>               h =3D btf_hash_common(t);
>>>>> -               for_each_hash_node(d->dedup_table, h, cand_node) {
>>>>> +               for_each_dedup_cand(d, h, cand_node) {
>>>>>                       cand =3D d->btf->types[cand_node->type_id];
>>>>>                       if (btf_equal_common(t, cand)) {
>>>>>                               new_id =3D cand_node->type_id;
>>>>> @@ -2263,7 +2272,7 @@ static int btf_dedup_struct_type(struct btf_ded=
up *d, __u32 type_id)
>>>>>               return 0;
>>>>>=20
>>>>>       h =3D btf_hash_struct(t);
>>>>> -       for_each_hash_node(d->dedup_table, h, cand_node) {
>>>>> +       for_each_dedup_cand(d, h, cand_node) {
>>>>>               int eq;
>>>>>=20
>>>>>               btf_dedup_clear_hypot_map(d);
>>>>> @@ -2349,7 +2358,7 @@ static int btf_dedup_ref_type(struct btf_dedup =
*d, __u32 type_id)
>>>>>               t->type =3D ref_type_id;
>>>>>=20
>>>>>               h =3D btf_hash_common(t);
>>>>> -               for_each_hash_node(d->dedup_table, h, cand_node) {
>>>>> +               for_each_dedup_cand(d, h, cand_node) {
>>>>>                       cand =3D d->btf->types[cand_node->type_id];
>>>>>                       if (btf_equal_common(t, cand)) {
>>>>>                               new_id =3D cand_node->type_id;
>>>>> @@ -2372,7 +2381,7 @@ static int btf_dedup_ref_type(struct btf_dedup =
*d, __u32 type_id)
>>>>>               info->index_type =3D ref_type_id;
>>>>>=20
>>>>>               h =3D btf_hash_array(t);
>>>>> -               for_each_hash_node(d->dedup_table, h, cand_node) {
>>>>> +               for_each_dedup_cand(d, h, cand_node) {
>>>>>                       cand =3D d->btf->types[cand_node->type_id];
>>>>>                       if (btf_equal_array(t, cand)) {
>>>>>                               new_id =3D cand_node->type_id;
>>>>> @@ -2403,7 +2412,7 @@ static int btf_dedup_ref_type(struct btf_dedup =
*d, __u32 type_id)
>>>>>               }
>>>>>=20
>>>>>               h =3D btf_hash_fnproto(t);
>>>>> -               for_each_hash_node(d->dedup_table, h, cand_node) {
>>>>> +               for_each_dedup_cand(d, h, cand_node) {
>>>>>                       cand =3D d->btf->types[cand_node->type_id];
>>>>>                       if (btf_equal_fnproto(t, cand)) {
>>>>>                               new_id =3D cand_node->type_id;
>>>>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>>>>> index b60bb7cf5fff..28a1e1e59861 100644
>>>>> --- a/tools/lib/bpf/btf.h
>>>>> +++ b/tools/lib/bpf/btf.h
>>>>> @@ -90,6 +90,7 @@ LIBBPF_API __u32 btf_ext__func_info_rec_size(const =
struct btf_ext *btf_ext);
>>>>> LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *bt=
f_ext);
>>>>>=20
>>>>> struct btf_dedup_opts {
>>>>> +       unsigned int dedup_table_size;
>>>>>       bool dont_resolve_fwds;
>>>>> };
>>>>>=20
>>>>> --
>>>>> 2.17.1

