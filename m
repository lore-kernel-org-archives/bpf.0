Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2E5C43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 21:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49D62084F
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 21:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nHMDn8QI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="W5e17P3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfDZVgn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:36:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36440 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726169AbfDZVgn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 17:36:43 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QLXh20030358;
        Fri, 26 Apr 2019 14:36:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tcJLLpWK2iGpZfPZmqS/uY2sTPCq48V4cCJ1s+CzdQE=;
 b=nHMDn8QIUErKGnKWf2LbTSjJ1rrc3op8zPt6ZiV0+jMYGSHiMUgh6WtX5OHzgz6QE2ip
 0wQLHWxDdXtpAIXHF4/iokYSIla5rHjUConMNIn5dRloWhGzoKh6IcoCw8x59sxQWZ+L
 ipCV5NtioAJUBJbbfkAIXMzywwGL1ZbxE3c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s4a0500dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Apr 2019 14:36:23 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Apr 2019 14:36:22 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 26 Apr 2019 14:36:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcJLLpWK2iGpZfPZmqS/uY2sTPCq48V4cCJ1s+CzdQE=;
 b=W5e17P3kuy9W/Ve82XaMe1t7dEPFXo5ggW75mCOxOc509mH+YhcRDNxivP6p2P/M7UEk1IwiFDA2tZsE9MDJP7dNUUV5KS200lHDqtDNtdQvoPMWEGCnbuRB9rBmSRzTXtAcuMU48Yb7+yRrkf01M7nOcPof6uaPGeVuD/TifYw=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1854.namprd15.prod.outlook.com (10.174.255.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 21:36:20 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 21:36:20 +0000
From:   Martin Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 5/6] bpf: Add BPF_MAP_TYPE_SK_STORAGE test to
 test_maps
Thread-Topic: [PATCH v3 bpf-next 5/6] bpf: Add BPF_MAP_TYPE_SK_STORAGE test to
 test_maps
Thread-Index: AQHU/FMf46Ax1/7Jm0CpUFJ1GkXNbaZOxAaAgAAzfQA=
Date:   Fri, 26 Apr 2019 21:36:20 +0000
Message-ID: <20190426213618.utfybnbzk3essirh@kafai-mbp.dhcp.thefacebook.com>
References: <20190426171102.61757-1-kafai@fb.com>
 <20190426171112.62405-1-kafai@fb.com>
 <09d7ea96-641f-9692-686f-03c5f44774e8@fb.com>
In-Reply-To: <09d7ea96-641f-9692-686f-03c5f44774e8@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:102:1::48) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:7ae1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe264e15-f6af-4b54-c0fa-08d6ca8f38b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1854;
x-ms-traffictypediagnostic: MWHPR15MB1854:
x-microsoft-antispam-prvs: <MWHPR15MB1854A076C6642DBB868DDAB4D53E0@MWHPR15MB1854.namprd15.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(76176011)(46003)(305945005)(97736004)(7736002)(102836004)(186003)(53546011)(5660300002)(6506007)(386003)(316002)(73956011)(14454004)(229853002)(71190400001)(66556008)(64756008)(66446008)(52116002)(71200400001)(66946007)(6246003)(66476007)(6862004)(2906002)(6512007)(86362001)(9686003)(68736007)(53936002)(486006)(4326008)(53946003)(6116002)(11346002)(446003)(478600001)(1076003)(81156014)(30864003)(81166006)(14444005)(54906003)(25786009)(6486002)(6436002)(256004)(8676002)(99286004)(8936002)(6636002)(476003)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1854;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ymD9TD+yWrZ3EFaYtbHYkpDuEb4ps8vdnOuWV+lMATTkSimz4xn5/HofPR6USBZ3RjFooWsjNlcaRcyxLcvwCwG+gHHs3tb4P7+fASM9nCR/xjToF78il5OEDL0ptJ2CPGktDJ77oY9ZTpDQCtIf3yGPBDmUTvRUWF6LG2Q4fnn6zY4iBnVYoAT8czsfRd5zagWWDK8UEBRa0lTvAUb406LZmoOOE6qaI5077jRqSI+V/fzOV/GdOwnsv2gBkteInVKUBL0T/joP/+sEhBxM1sOq7OhE8WYvYODbWwu5Be5YgmidvQBfXdYrgmamY/OKKOHhnSpUdLyil+kqOP5PMGYCtfsbkdW0U6dF/Aoh/+EQ/gf2RuwnOerefHciifD6xVDjsFkmtr7cSjDkKfLcOTqq3MVYQXeAHfHFpg/vbWw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4607BE514ACB9A4092D2B7970D67F226@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe264e15-f6af-4b54-c0fa-08d6ca8f38b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 21:36:20.4932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1854
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260141
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 26, 2019 at 11:32:01AM -0700, Yonghong Song wrote:
>=20
>=20
> On 4/26/19 10:11 AM, Martin KaFai Lau wrote:
> > This patch adds BPF_MAP_TYPE_SK_STORAGE test to test_maps.
> > The src file is rather long, so it is put into another dir map_tests/
> > and compile like the current prog_tests/ does.  Other existing
> > tests in test_maps can also be re-factored into map_tests/ in the
> > future.
> >=20
> > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > ---
> >   tools/testing/selftests/bpf/Makefile          |  25 +-
> >   .../selftests/bpf/map_tests/sk_storage_map.c  | 638 +++++++++++++++++=
+
> >   tools/testing/selftests/bpf/test_maps.c       |  18 +-
> >   tools/testing/selftests/bpf/test_maps.h       |  17 +
> >   4 files changed, 688 insertions(+), 10 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/map_tests/sk_storage_m=
ap.c
> >   create mode 100644 tools/testing/selftests/bpf/test_maps.h
> >=20
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index f9d83ba7843e..66f2dca1dee1 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -74,6 +74,8 @@ all: $(TEST_CUSTOM_PROGS)
> >   $(OUTPUT)/urandom_read: $(OUTPUT)/%: %.c
> >   	$(CC) -o $@ $< -Wl,--build-id
> >  =20
> > +$(OUTPUT)/test_maps: map_tests/*.c
> > +
> >   BPFOBJ :=3D $(OUTPUT)/libbpf.a
> >  =20
> >   $(TEST_GEN_PROGS): $(BPFOBJ)
> > @@ -232,6 +234,27 @@ $(PROG_TESTS_H): $(PROG_TESTS_DIR) $(PROG_TESTS_FI=
LES)
> >   		  echo '#endif' \
> >   		 ) > $(PROG_TESTS_H))
> >  =20
> > +TEST_MAPS_CFLAGS :=3D -I. -I$(OUTPUT)
> > +MAP_TESTS_DIR =3D $(OUTPUT)/map_tests
> > +$(MAP_TESTS_DIR):
> > +	mkdir -p $@
> > +MAP_TESTS_H :=3D $(MAP_TESTS_DIR)/tests.h
> > +test_maps.c: $(MAP_TESTS_H)
> > +$(OUTPUT)/test_maps: CFLAGS +=3D $(TEST_MAPS_CFLAGS)
> > +MAP_TESTS_FILES :=3D $(wildcard map_tests/*.c)
> > +$(MAP_TESTS_H): $(MAP_TESTS_DIR) $(MAP_TESTS_FILES)
> > +	$(shell ( cd map_tests/; \
> > +		  echo '/* Generated header, do not edit */'; \
> > +		  echo '#ifdef DECLARE'; \
> > +		  ls *.c 2> /dev/null | \
> > +			sed -e 's@\([^\.]*\)\.c@extern void test_\1(void);@'; \
> > +		  echo '#endif'; \
> > +		  echo '#ifdef CALL'; \
> > +		  ls *.c 2> /dev/null | \
> > +			sed -e 's@\([^\.]*\)\.c@test_\1();@'; \
> > +		  echo '#endif' \
> > +		 ) > $(MAP_TESTS_H))
> > +
> >   VERIFIER_TESTS_H :=3D $(OUTPUT)/verifier/tests.h
> >   test_verifier.c: $(VERIFIER_TESTS_H)
> >   $(OUTPUT)/test_verifier: CFLAGS +=3D $(TEST_VERIFIER_CFLAGS)
> > @@ -251,4 +274,4 @@ $(OUTPUT)/verifier/tests.h: $(VERIFIER_TESTS_DIR) $=
(VERIFIER_TEST_FILES)
> >   		 ) > $(VERIFIER_TESTS_H))
> >  =20
> >   EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(ALU32_BUILD_DIR) \
> > -	$(VERIFIER_TESTS_H) $(PROG_TESTS_H)
> > +	$(VERIFIER_TESTS_H) $(PROG_TESTS_H) $(MAP_TESTS_H)
> > diff --git a/tools/testing/selftests/bpf/map_tests/sk_storage_map.c b/t=
ools/testing/selftests/bpf/map_tests/sk_storage_map.c
> > new file mode 100644
> > index 000000000000..f66e4a3ee6e4
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
> > @@ -0,0 +1,638 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2019 Facebook  */
> > +#include <linux/compiler.h>
> > +#include <linux/err.h>
> > +
> > +#include <sys/resource.h>
> > +#include <sys/socket.h>
> > +#include <sys/types.h>
> > +#include <linux/btf.h>
> > +#include <unistd.h>
> > +#include <signal.h>
> > +#include <errno.h>
> > +#include <string.h>
> > +#include <pthread.h>
> > +
> > +#include <bpf/bpf.h>
> > +#include <bpf/libbpf.h>
> > +
> > +#include <test_maps.h>
> > +
> > +static struct bpf_create_map_attr xattr =3D {
> > +	.name =3D "sk_storage_map",
> > +	.map_type =3D BPF_MAP_TYPE_SK_STORAGE,
> > +	.map_flags =3D BPF_F_NO_PREALLOC,
> > +	.max_entries =3D 0,
> > +	.key_size =3D 4,
> > +	.value_size =3D 8,
> > +	.btf_key_type_id =3D 1,
> > +	.btf_value_type_id =3D 3,
> > +	.btf_fd =3D -1,
> > +};
> > +
> > +static unsigned int nr_sk_threads_done;
> > +static unsigned int nr_sk_threads_err;
> > +static unsigned int nr_sk_per_thread =3D 4096;
> > +static unsigned int nr_sk_threads =3D 4;
> > +static int sk_storage_map =3D -1;
> > +static unsigned int stop;
> > +static int runtime_s =3D 5;
> > +
> > +static bool is_stopped(void)
> > +{
> > +	return READ_ONCE(stop);
> > +}
> > +
> > +static unsigned int threads_err(void)
> > +{
> > +	return READ_ONCE(nr_sk_threads_err);
> > +}
> > +
> > +static void notify_thread_err(void)
> > +{
> > +	__sync_add_and_fetch(&nr_sk_threads_err, 1);
> > +}
> > +
> > +static bool wait_for_threads_err(void)
> > +{
> > +	while (!is_stopped() && !threads_err())
> > +		usleep(500);
> > +
> > +	return !is_stopped();
> > +}
> > +
> > +static unsigned int threads_done(void)
> > +{
> > +	return READ_ONCE(nr_sk_threads_done);
> > +}
> > +
> > +static void notify_thread_done(void)
> > +{
> > +	__sync_add_and_fetch(&nr_sk_threads_done, 1);
> > +}
> > +
> > +static void notify_thread_redo(void)
> > +{
> > +	__sync_sub_and_fetch(&nr_sk_threads_done, 1);
> > +}
> > +
> > +static bool wait_for_threads_done(void)
> > +{
> > +	while (threads_done() !=3D nr_sk_threads && !is_stopped() &&
> > +	       !threads_err())
> > +		usleep(50);
> > +
> > +	return !is_stopped() && !threads_err();
> > +}
> > +
> > +static bool wait_for_threads_redo(void)
> > +{
> > +	while (threads_done() && !is_stopped() && !threads_err())
> > +		usleep(50);
> > +
> > +	return !is_stopped() && !threads_err();
> > +}
> > +
> > +static bool wait_for_map(void)
> > +{
> > +	while (READ_ONCE(sk_storage_map) =3D=3D -1 && !is_stopped())
> > +		usleep(50);
> > +
> > +	return !is_stopped();
> > +}
> > +
> > +static bool wait_for_map_close(void)
> > +{
> > +	while (READ_ONCE(sk_storage_map) !=3D -1 && !is_stopped())
> > +		;
> > +
> > +	return !is_stopped();
> > +}
> > +
> > +static int load_btf(void)
> > +{
> > +#define BTF_INFO_ENC(kind, kind_flag, vlen) \
> > +	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
> > +#define BTF_TYPE_ENC(name, info, size_or_type) \
> > +	(name), (info), (size_or_type)
> > +#define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
> > +	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
> > +#define BTF_TYPE_INT_ENC(name, encoding, bits_offset, bits, sz) \
> > +	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz),	\
> > +	BTF_INT_ENC(encoding, bits_offset, bits)
> > +#define BTF_MEMBER_ENC(name, type, bits_offset) \
> > +	(name), (type), (bits_offset)
> > +
> > +	const char btf_str_sec[] =3D "\0bpf_spin_lock\0val\0cnt\0l";
> > +	__u32 btf_raw_types[] =3D {
> > +		/* int */
> > +		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> > +		/* struct bpf_spin_lock */                      /* [2] */
> > +		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 4),
> > +		BTF_MEMBER_ENC(15, 1, 0), /* int val; */
> > +		/* struct val */                                /* [3] */
> > +		BTF_TYPE_ENC(15, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 2), 8),
> > +		BTF_MEMBER_ENC(19, 1, 0), /* int cnt; */
> > +		BTF_MEMBER_ENC(23, 2, 32),/* struct bpf_spin_lock l; */
> > +	};
> > +	struct btf_header btf_hdr =3D {
> > +		.magic =3D BTF_MAGIC,
> > +		.version =3D BTF_VERSION,
> > +		.hdr_len =3D sizeof(struct btf_header),
> > +		.type_len =3D sizeof(btf_raw_types),
> > +		.str_off =3D sizeof(btf_raw_types),
> > +		.str_len =3D sizeof(btf_str_sec),
> > +	};
> > +	__u8 raw_btf[sizeof(struct btf_header) + sizeof(btf_raw_types) +
> > +		     sizeof(btf_str_sec)];
> > +
> > +	memcpy(raw_btf, &btf_hdr, sizeof(btf_hdr));
> > +	memcpy(raw_btf + sizeof(btf_hdr), btf_raw_types, sizeof(btf_raw_types=
));
> > +	memcpy(raw_btf + sizeof(btf_hdr) + sizeof(btf_raw_types),
> > +	       btf_str_sec, sizeof(btf_str_sec));
> > +
> > +	return bpf_load_btf(raw_btf, sizeof(raw_btf), 0, 0, 0);
> > +}
> > +
> > +static int create_sk_storage_map(void)
> > +{
> > +	int btf_fd, map_fd;
> > +
> > +	btf_fd =3D load_btf();
> > +	CHECK(btf_fd =3D=3D -1, "bpf_load_btf", "btf_fd:%d errno:%d\n",
> > +	      btf_fd, errno);
> > +	xattr.btf_fd =3D btf_fd;
> > +
> > +	map_fd =3D bpf_create_map_xattr(&xattr);
> > +	xattr.btf_fd =3D -1;
> > +	close(btf_fd);
> > +	CHECK(map_fd =3D=3D -1,
> > +	      "bpf_create_map_xattr()", "errno:%d\n", errno);
> > +
> > +	return map_fd;
> > +}
> > +
> > +static void *insert_close_thread(void *arg)
> > +{
> > +	struct {
> > +		int cnt;
> > +		int lock;
> > +	} value =3D { .cnt =3D 0xeB9F, .lock =3D 0, };
> > +	int i, map_fd, err, *sk_fds;
> > +
> > +	sk_fds =3D malloc(sizeof(*sk_fds) * nr_sk_per_thread);
> > +	if (!sk_fds) {
> > +		notify_thread_err();
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	for (i =3D 0; i < nr_sk_per_thread; i++)
> > +		sk_fds[i] =3D -1;
> > +
> > +	while (!is_stopped()) {
> > +		if (!wait_for_map())
> > +			goto close_all;
> > +
> > +		map_fd =3D READ_ONCE(sk_storage_map);
> > +		for (i =3D 0; i < nr_sk_per_thread && !is_stopped(); i++) {
> > +			sk_fds[i] =3D socket(AF_INET6, SOCK_STREAM, 0);
> > +			if (sk_fds[i] =3D=3D -1) {
> > +				err =3D -errno;
> > +				fprintf(stderr, "socket(): errno:%d\n", errno);
> > +				goto errout;
> > +			}
> > +			err =3D bpf_map_update_elem(map_fd, &sk_fds[i], &value,
> > +						  BPF_NOEXIST);
> > +			if (err) {
> > +				err =3D -errno;
> > +				fprintf(stderr,
> > +					"bpf_map_update_elem(): errno:%d\n",
> > +					errno);
> > +				goto errout;
> > +			}
> > +		}
> > +
> > +		notify_thread_done();
> > +		wait_for_map_close();
> > +
> > +close_all:
> > +		for (i =3D 0; i < nr_sk_per_thread; i++) {
> > +			close(sk_fds[i]);
> > +			sk_fds[i] =3D -1;
> > +		}
> > +
> > +		notify_thread_redo();
> > +	}
> > +
> > +	free(sk_fds);
> > +	return NULL;
> > +
> > +errout:
> > +	for (i =3D 0; i < nr_sk_per_thread && sk_fds[i] !=3D -1; i++)
> > +		close(sk_fds[i]);
> > +	free(sk_fds);
> > +	notify_thread_err();
> > +	return ERR_PTR(err);
> > +}
> > +
> > +static int do_sk_storage_map_stress_free(void)
> > +{
> > +	int i, map_fd =3D -1, err =3D 0, nr_threads_created =3D 0;
> > +	pthread_t *sk_thread_ids;
> > +	void *thread_ret;
> > +
> > +	sk_thread_ids =3D malloc(sizeof(pthread_t) * nr_sk_threads);
> > +	if (!sk_thread_ids) {
> > +		fprintf(stderr, "malloc(sk_threads): NULL\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	for (i =3D 0; i < nr_sk_threads; i++) {
> > +		err =3D pthread_create(&sk_thread_ids[i], NULL,
> > +				     insert_close_thread, NULL);
> > +		if (err) {
> > +			err =3D -errno;
> > +			goto done;
> > +		}
> > +		nr_threads_created++;
> > +	}
> > +
> > +	while (!is_stopped()) {
> > +		map_fd =3D create_sk_storage_map();
> > +		WRITE_ONCE(sk_storage_map, map_fd);
> > +
> > +		if (!wait_for_threads_done())
> > +			break;
> > +
> > +		WRITE_ONCE(sk_storage_map, -1);
> > +		close(map_fd);
> > +		map_fd =3D -1;
> > +
> > +		if (!wait_for_threads_redo())
> > +			break;
> > +	}
> > +
> > +done:
> > +	WRITE_ONCE(stop, 1);
> > +	for (i =3D 0; i < nr_threads_created; i++) {
> > +		pthread_join(sk_thread_ids[i], &thread_ret);
> > +		if (IS_ERR(thread_ret) && !err) {
> > +			err =3D PTR_ERR(thread_ret);
> > +			fprintf(stderr, "threads#%u: err:%d\n", i, err);
> > +		}
> > +	}
> > +	free(sk_thread_ids);
> > +
> > +	if (map_fd !=3D -1)
> > +		close(map_fd);
> > +
> > +	return err;
> > +}
> > +
> > +static void *update_thread(void *arg)
> > +{
> > +	struct {
> > +		int cnt;
> > +		int lock;
> > +	} value =3D { .cnt =3D 0xeB9F, .lock =3D 0, };
> > +	int map_fd =3D READ_ONCE(sk_storage_map);
> > +	int sk_fd =3D *(int *)arg;
> > +	int err =3D 0; /* Suppress compiler false alarm */
> > +
> > +	while (!is_stopped()) {
> > +		err =3D bpf_map_update_elem(map_fd, &sk_fd, &value, 0);
> > +		if (err && errno !=3D EAGAIN) {
> > +			err =3D -errno;
> > +			fprintf(stderr, "bpf_map_update_elem: %d %d\n",
> > +				err, errno);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!is_stopped()) {
> > +		notify_thread_err();
> > +		return ERR_PTR(err);
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static void *delete_thread(void *arg)
> > +{
> > +	int map_fd =3D READ_ONCE(sk_storage_map);
> > +	int sk_fd =3D *(int *)arg;
> > +	int err =3D 0; /* Suppress compiler false alarm */
> > +
> > +	while (!is_stopped()) {
> > +		err =3D bpf_map_delete_elem(map_fd, &sk_fd);
> > +		if (err && errno !=3D ENOENT) {
> > +			err =3D -errno;
> > +			fprintf(stderr, "bpf_map_delete_elem: %d %d\n",
> > +				err, errno);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!is_stopped()) {
> > +		notify_thread_err();
> > +		return ERR_PTR(err);
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static int do_sk_storage_map_stress_change(void)
> > +{
> > +	int i, sk_fd, map_fd =3D -1, err =3D 0, nr_threads_created =3D 0;
> > +	pthread_t *sk_thread_ids;
> > +	void *thread_ret;
> > +
> > +	sk_thread_ids =3D malloc(sizeof(pthread_t) * nr_sk_threads);
> > +	if (!sk_thread_ids) {
> > +		fprintf(stderr, "malloc(sk_threads): NULL\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	sk_fd =3D socket(AF_INET6, SOCK_STREAM, 0);
> > +	if (sk_fd =3D=3D -1) {
> > +		err =3D -errno;
> > +		goto done;
> > +	}
> > +
> > +	map_fd =3D create_sk_storage_map();
> > +	WRITE_ONCE(sk_storage_map, map_fd);
> > +
> > +	for (i =3D 0; i < nr_sk_threads; i++) {
> > +		if (i & 0x1)
> > +			err =3D pthread_create(&sk_thread_ids[i], NULL,
> > +					     update_thread, &sk_fd);
> > +		else
> > +			err =3D pthread_create(&sk_thread_ids[i], NULL,
> > +					     delete_thread, &sk_fd);
> > +		if (err) {
> > +			err =3D -errno;
> > +			goto done;
> > +		}
> > +		nr_threads_created++;
> > +	}
> > +
> > +	wait_for_threads_err();
> > +
> > +done:
> > +	WRITE_ONCE(stop, 1);
> > +	for (i =3D 0; i < nr_threads_created; i++) {
> > +		pthread_join(sk_thread_ids[i], &thread_ret);
> > +		if (IS_ERR(thread_ret) && !err) {
> > +			err =3D PTR_ERR(thread_ret);
> > +			fprintf(stderr, "threads#%u: err:%d\n", i, err);
> > +		}
> > +	}
> > +	free(sk_thread_ids);
> > +
> > +	if (sk_fd !=3D -1)
> > +		close(sk_fd);
> > +	close(map_fd);
> > +
> > +	return err;
> > +}
> > +
> > +static void stop_handler(int signum)
> > +{
> > +	if (signum !=3D SIGALRM)
> > +		printf("stopping...\n");
> > +	WRITE_ONCE(stop, 1);
> > +}
> > +
> > +#define BPF_SK_STORAGE_MAP_TEST_NR_THREADS "BPF_SK_STORAGE_MAP_TEST_NR=
_THREADS"
> > +#define BPF_SK_STORAGE_MAP_TEST_SK_PER_THREAD "BPF_SK_STORAGE_MAP_TEST=
_SK_PER_THREAD"
> > +#define BPF_SK_STORAGE_MAP_TEST_RUNTIME_S "BPF_SK_STORAGE_MAP_TEST_RUN=
TIME_S"
> > +#define BPF_SK_STORAGE_MAP_TEST_NAME "BPF_SK_STORAGE_MAP_TEST_NAME"
> > +
> > +static void test_sk_storage_map_stress_free(void)
> > +{
> > +	struct rlimit rlim_old, rlim_new =3D {};
> > +	const char *env_opt;
> > +	int err;
> > +
> > +	getrlimit(RLIMIT_NOFILE, &rlim_old);
> > +
> > +	env_opt =3D getenv(BPF_SK_STORAGE_MAP_TEST_NR_THREADS);
> > +	if (env_opt)
> > +		nr_sk_threads =3D atoi(env_opt);
> > +
> > +	env_opt =3D getenv(BPF_SK_STORAGE_MAP_TEST_SK_PER_THREAD);
> > +	if (env_opt)
> > +		nr_sk_per_thread =3D atoi(env_opt);
> > +
> > +	env_opt =3D getenv(BPF_SK_STORAGE_MAP_TEST_RUNTIME_S);
> > +	if (env_opt)
> > +		runtime_s =3D atoi(env_opt);
>=20
> I see these env variables are getenv'd by multiple times.
> Maybe put all these into one routine before running the test.
Will do.

>=20
> > +
> > +	signal(SIGTERM, stop_handler);
> > +	signal(SIGINT, stop_handler);
> > +	if (runtime_s > 0) {
> > +		signal(SIGALRM, stop_handler);
> > +		alarm(runtime_s);
> > +	}
> > +
> > +	if (rlim_old.rlim_cur < nr_sk_threads * nr_sk_per_thread) {
> > +		rlim_new.rlim_cur =3D nr_sk_threads * nr_sk_per_thread + 128;
> > +		rlim_new.rlim_max =3D rlim_new.rlim_cur + 128;
> > +		err =3D setrlimit(RLIMIT_NOFILE, &rlim_new);
> > +		CHECK(err, "setrlimit(RLIMIT_NOFILE)", "rlim_new:%lu errno:%d",
> > +		      rlim_new.rlim_cur, errno);
> > +	}
> > +
> > +	err =3D do_sk_storage_map_stress_free();
> > +
> > +	signal(SIGTERM, SIG_DFL);
> > +	signal(SIGINT, SIG_DFL);
> > +	if (runtime_s > 0) {
> > +		signal(SIGALRM, SIG_DFL);
> > +		alarm(0);
> > +	}
> > +
> > +	if (rlim_new.rlim_cur)
> > +		setrlimit(RLIMIT_NOFILE, &rlim_old);
> > +
> > +	CHECK(err, "test_sk_storage_map_stress_free", "err:%d\n", err);
> > +}
> > +
> > +static void test_sk_storage_map_stress_change(void)
> > +{
> > +	const char *env_opt;
> > +	int err;
> > +
> > +	env_opt =3D getenv(BPF_SK_STORAGE_MAP_TEST_NR_THREADS);
> > +	if (env_opt)
> > +		nr_sk_threads =3D atoi(env_opt);
> > +
> > +	env_opt =3D getenv(BPF_SK_STORAGE_MAP_TEST_RUNTIME_S);
> > +	if (env_opt)
> > +		runtime_s =3D atoi(env_opt);
> > +
> > +	signal(SIGTERM, stop_handler);
> > +	signal(SIGINT, stop_handler);
> > +	if (runtime_s > 0) {
> > +		signal(SIGALRM, stop_handler);
> > +		alarm(runtime_s);
> > +	}
> > +
> > +	err =3D do_sk_storage_map_stress_change();
> > +
> > +	signal(SIGTERM, SIG_DFL);
> > +	signal(SIGINT, SIG_DFL);
> > +	if (runtime_s > 0) {
> > +		signal(SIGALRM, SIG_DFL);
> > +		alarm(0);
> > +	}
> > +
> > +	CHECK(err, "test_sk_storage_map_stress_change", "err:%d\n", err);
> > +}
> > +
> > +static void test_sk_storage_map_basic(void)
> > +{
> > +	struct {
> > +		int cnt;
> > +		int lock;
> > +	} value =3D { .cnt =3D 0xeB9f, .lock =3D 0, }, lookup_value;
> > +	struct bpf_create_map_attr bad_xattr;
> > +	int btf_fd, map_fd, sk_fd, err;
> > +
> > +	btf_fd =3D load_btf();
> > +	CHECK(btf_fd =3D=3D -1, "bpf_load_btf", "btf_fd:%d errno:%d\n",
> > +	      btf_fd, errno);
> > +	xattr.btf_fd =3D btf_fd;
> > +
> > +	sk_fd =3D socket(AF_INET6, SOCK_STREAM, 0);
> > +	CHECK(sk_fd =3D=3D -1, "socket()", "sk_fd:%d errno:%d\n",
> > +	      sk_fd, errno);
> > +
> > +	map_fd =3D bpf_create_map_xattr(&xattr);
> > +	CHECK(map_fd =3D=3D -1, "bpf_create_map_xattr(good_xattr)",
> > +	      "map_fd:%d errno:%d\n", map_fd, errno);
> > +
> > +	/* Add new elem */
> > +	memcpy(&lookup_value, &value, sizeof(value));
> > +	err =3D bpf_map_update_elem(map_fd, &sk_fd, &value,
> > +				  BPF_NOEXIST | BPF_F_LOCK);
> > +	CHECK(err, "bpf_map_update_elem(BPF_NOEXIST|BPF_F_LOCK)",
> > +	      "err:%d errno:%d\n", err, errno);
> > +	err =3D bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
> > +					BPF_F_LOCK);
> > +	CHECK(err || lookup_value.cnt !=3D value.cnt,
> > +	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
> > +	      "err:%d errno:%d cnt:%x(%x)\n",
> > +	      err, errno, lookup_value.cnt, value.cnt);
> > +
> > +	/* Bump the cnt and update with BPF_EXIST | BPF_F_LOCK */
> > +	value.cnt +=3D 1;
> > +	err =3D bpf_map_update_elem(map_fd, &sk_fd, &value,
> > +				  BPF_EXIST | BPF_F_LOCK);
> > +	CHECK(err, "bpf_map_update_elem(BPF_EXIST|BPF_F_LOCK)",
> > +	      "err:%d errno:%d\n", err, errno);
> > +	err =3D bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
> > +					BPF_F_LOCK);
> > +	CHECK(err || lookup_value.cnt !=3D value.cnt,
> > +	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
> > +	      "err:%d errno:%d cnt:%x(%x)\n",
> > +	      err, errno, lookup_value.cnt, value.cnt);
> > +
> > +	/* Bump the cnt and update with BPF_EXIST */
> > +	value.cnt +=3D 1;
> > +	err =3D bpf_map_update_elem(map_fd, &sk_fd, &value, BPF_EXIST);
> > +	CHECK(err, "bpf_map_update_elem(BPF_EXIST)",
> > +	      "err:%d errno:%d\n", err, errno);
> > +	err =3D bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
> > +					BPF_F_LOCK);
> > +	CHECK(err || lookup_value.cnt !=3D value.cnt,
> > +	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
> > +	      "err:%d errno:%d cnt:%x(%x)\n",
> > +	      err, errno, lookup_value.cnt, value.cnt);
> > +
> > +	/* Update with BPF_NOEXIST */
> > +	value.cnt +=3D 1;
> > +	err =3D bpf_map_update_elem(map_fd, &sk_fd, &value,
> > +				  BPF_NOEXIST | BPF_F_LOCK);
> > +	CHECK(!err || errno !=3D EEXIST,
> > +	      "bpf_map_update_elem(BPF_NOEXIST|BPF_F_LOCK)",
> > +	      "err:%d errno:%d\n", err, errno);
> > +	err =3D bpf_map_update_elem(map_fd, &sk_fd, &value, BPF_NOEXIST);
> > +	CHECK(!err || errno !=3D EEXIST, "bpf_map_update_elem(BPF_NOEXIST)",
> > +	      "err:%d errno:%d\n", err, errno);
> > +	value.cnt -=3D 1;
> > +	err =3D bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
> > +					BPF_F_LOCK);
> > +	CHECK(err || lookup_value.cnt !=3D value.cnt,
> > +	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
> > +	      "err:%d errno:%d cnt:%x(%x)\n",
> > +	      err, errno, lookup_value.cnt, value.cnt);
> > +
> > +	/* Bump the cnt again and update with map_flags =3D=3D 0 */
> > +	value.cnt +=3D 1;
> > +	err =3D bpf_map_update_elem(map_fd, &sk_fd, &value, 0);
> > +	CHECK(err, "bpf_map_update_elem()", "err:%d errno:%d\n",
> > +	      err, errno);
> > +	err =3D bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
> > +					BPF_F_LOCK);
> > +	CHECK(err || lookup_value.cnt !=3D value.cnt,
> > +	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
> > +	      "err:%d errno:%d cnt:%x(%x)\n",
> > +	      err, errno, lookup_value.cnt, value.cnt);
> > +
> > +	/* Test delete elem */
> > +	err =3D bpf_map_delete_elem(map_fd, &sk_fd);
> > +	CHECK(err, "bpf_map_delete_elem()", "err:%d errno:%d\n",
> > +	      err, errno);
> > +	err =3D bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
> > +					BPF_F_LOCK);
> > +	CHECK(!err || errno !=3D ENOENT,
> > +	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
> > +	      "err:%d errno:%d\n", err, errno);
> > +	err =3D bpf_map_delete_elem(map_fd, &sk_fd);
> > +	CHECK(!err || errno !=3D ENOENT, "bpf_map_delete_elem()",
> > +	      "err:%d errno:%d\n", err, errno);
> > +
> > +	memcpy(&bad_xattr, &xattr, sizeof(xattr));
> > +	bad_xattr.btf_key_type_id =3D 0;
> > +	err =3D bpf_create_map_xattr(&bad_xattr);
> > +	CHECK(!err || errno !=3D EINVAL, "bap_create_map_xattr(bad_xattr)",
> > +	      "err:%d errno:%d\n", err, errno);
> > +
> > +	memcpy(&bad_xattr, &xattr, sizeof(xattr));
> > +	bad_xattr.btf_key_type_id =3D 3;
> > +	err =3D bpf_create_map_xattr(&bad_xattr);
> > +	CHECK(!err || errno !=3D EINVAL, "bap_create_map_xattr(bad_xattr)",
> > +	      "err:%d errno:%d\n", err, errno);
> > +
> > +	memcpy(&bad_xattr, &xattr, sizeof(xattr));
> > +	bad_xattr.max_entries =3D 1;
> > +	err =3D bpf_create_map_xattr(&bad_xattr);
> > +	CHECK(!err || errno !=3D EINVAL, "bap_create_map_xattr(bad_xattr)",
> > +	      "err:%d errno:%d\n", err, errno);
> > +
> > +	memcpy(&bad_xattr, &xattr, sizeof(xattr));
> > +	bad_xattr.map_flags =3D 0;
> > +	err =3D bpf_create_map_xattr(&bad_xattr);
> > +	CHECK(!err || errno !=3D EINVAL, "bap_create_map_xattr(bad_xattr)",
> > +	      "err:%d errno:%d\n", err, errno);
> > +
> > +	xattr.btf_fd =3D -1;
> > +	close(btf_fd);
> > +	close(map_fd);
> > +	close(sk_fd);
> > +}
> > +
> > +void test_sk_storage_map(void)
> > +{
> > +	const char *test_name;
> > +
> > +	test_name =3D getenv(BPF_SK_STORAGE_MAP_TEST_NAME);
> > +
> > +	if (!test_name || !strcmp(test_name, "basic"))
> > +		test_sk_storage_map_basic();
> > +	if (!test_name || !strcmp(test_name, "stress_free"))
> > +		test_sk_storage_map_stress_free();
> > +	if (!test_name || !strcmp(test_name, "stress_change"))
> > +		test_sk_storage_map_stress_change();
>=20
> Maybe add a single line to print out whether the test_sk_storage_map=20
> successful or not?
Ok.

>=20
> > +}
> > diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/se=
lftests/bpf/test_maps.c
> > index 3c627771f965..246f745cb006 100644
> > --- a/tools/testing/selftests/bpf/test_maps.c
> > +++ b/tools/testing/selftests/bpf/test_maps.c
> > @@ -27,6 +27,7 @@
> >  =20
> >   #include "bpf_util.h"
> >   #include "bpf_rlimit.h"
> > +#include "test_maps.h"
> >  =20
> >   #ifndef ENOTSUPP
> >   #define ENOTSUPP 524
> > @@ -36,15 +37,6 @@ static int skips;
> >  =20
> >   static int map_flags;
> >  =20
> > -#define CHECK(condition, tag, format...) ({				\
> > -	int __ret =3D !!(condition);					\
> > -	if (__ret) {							\
> > -		printf("%s(%d):FAIL:%s ", __func__, __LINE__, tag);	\
> > -		printf(format);						\
> > -		exit(-1);						\
> > -	}								\
> > -})
> > -
> >   static void test_hashmap(unsigned int task, void *data)
> >   {
> >   	long long key, next_key, first_key, value;
> > @@ -1703,6 +1695,10 @@ static void run_all_tests(void)
> >   	test_map_in_map();
> >   }
> >  =20
> > +#define DECLARE
> > +#include <map_tests/tests.h>
> > +#undef DECLARE
> > +
> >   int main(void)
> >   {
> >   	srand(time(NULL));
> > @@ -1713,6 +1709,10 @@ int main(void)
> >   	map_flags =3D BPF_F_NO_PREALLOC;
> >   	run_all_tests();
> >  =20
> > +#define CALL
> > +#include <map_tests/tests.h>
> > +#undef CALL
> > +
> >   	printf("test_maps: OK, %d SKIPPED\n", skips);
> >   	return 0;
> >   }
> > diff --git a/tools/testing/selftests/bpf/test_maps.h b/tools/testing/se=
lftests/bpf/test_maps.h
> > new file mode 100644
> > index 000000000000..77d8587ac4ed
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/test_maps.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _TEST_MAPS_H
> > +#define _TEST_MAPS_H
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +#define CHECK(condition, tag, format...) ({				\
> > +	int __ret =3D !!(condition);					\
> > +	if (__ret) {							\
> > +		printf("%s(%d):FAIL:%s ", __func__, __LINE__, tag);	\
> > +		printf(format);						\
> > +		exit(-1);						\
> > +	}								\
> > +})
> > +
> > +#endif
> >=20
