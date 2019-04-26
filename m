Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C84C43218
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 18:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E40F2077B
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 18:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZdQ7eZEg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Pcsa0tF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfDZSWP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:22:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60758 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725875AbfDZSWP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 14:22:15 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3QILiTQ014328;
        Fri, 26 Apr 2019 11:21:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XUgGgSYJdz/IWMxNuAEVL/SmSzRmIC+QNTImq4HOmDg=;
 b=ZdQ7eZEg0RbZnQnrvGqNtO681zXJhlwl+aIW/eMxg+HGgZd1/1lYZJLyqHcT2LAkV+5Y
 lEZNLert/JaNTbldYvJ3Yt1SguEQXrGuqIym2C9xHPkbbiXl0znZrZdjehJKSQGAIaJc
 9OEAJbHJ8p9EVQzlGvfmmp6WV8BwBnV4XNk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2s3bspnd5n-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Apr 2019 11:21:54 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 26 Apr 2019 11:21:16 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 26 Apr 2019 11:21:16 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 26 Apr 2019 11:21:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUgGgSYJdz/IWMxNuAEVL/SmSzRmIC+QNTImq4HOmDg=;
 b=Pcsa0tF1CyElZ9s0ESm79MRtbyM41EqeYdvwT7FK6Ocsybv4tbrCdBMrH5c7kE04fsTqLQKElaQvhyhN1aR8LhENDFFAlbbrxx7XEJNC/8o+TGvUmEO040HfdG4Ude6mC77EycpqmZcFaev4+hulaLEDsnq3cCZo4cqNaUt/Gag=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1167.namprd15.prod.outlook.com (10.175.2.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.19; Fri, 26 Apr 2019 18:21:00 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 18:21:00 +0000
From:   Martin Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 3/6] bpf: Support BPF_MAP_TYPE_SK_STORAGE in
 bpf map probing
Thread-Topic: [PATCH v3 bpf-next 3/6] bpf: Support BPF_MAP_TYPE_SK_STORAGE in
 bpf map probing
Thread-Index: AQHU/FMPOedZHVAnAkCnig4Gpc8OhKZOuGyAgAAIg4A=
Date:   Fri, 26 Apr 2019 18:21:00 +0000
Message-ID: <20190426182057.7d54qljtiah5aump@kafai-mbp.dhcp.thefacebook.com>
References: <20190426171102.61757-1-kafai@fb.com>
 <20190426171107.62279-1-kafai@fb.com>
 <c81269b9-a422-0407-e6c4-830e86310852@fb.com>
In-Reply-To: <c81269b9-a422-0407-e6c4-830e86310852@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0064.namprd19.prod.outlook.com
 (2603:10b6:300:94::26) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:7ae1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b349a827-0667-4e86-7416-08d6ca73ef1a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1167;
x-ms-traffictypediagnostic: MWHPR15MB1167:
x-microsoft-antispam-prvs: <MWHPR15MB1167CE138C6DFAC793D848C5D53E0@MWHPR15MB1167.namprd15.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(6486002)(478600001)(6636002)(186003)(7736002)(53936002)(68736007)(6116002)(2906002)(316002)(305945005)(52116002)(54906003)(6436002)(5660300002)(256004)(14444005)(102836004)(229853002)(6246003)(99286004)(8676002)(53546011)(11346002)(9686003)(6862004)(25786009)(66946007)(1076003)(446003)(6506007)(486006)(71190400001)(81166006)(97736004)(66556008)(386003)(8936002)(476003)(66476007)(76176011)(46003)(64756008)(81156014)(73956011)(86362001)(71200400001)(14454004)(66446008)(4326008)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1167;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y4ncmvPdBiHh7MSGC/RqlGtP1GEHH6T7W3la8UcSZxcgiYW1/az0Vw5ZDGd0S31fwebrbvhcd6ZxUdx38/cO9YZlCyI+CaFWL7RQIECRYDLfx/0jg94Hk8ZqkZm+gXLOLMbGPIWVFIWQhTjeQvIZXHTRfqLCMOzyywF4l6Te+/10gpJWLzXXibnjriItMofzTBPGaQV6QcbwYB1my2NDbXK0e5j8fAbIgA6sV50ydR8idbx5uw1/4zNlKyRTV7G4UoPLQj/7EGHWg7GkCbebeDfqXLMk3n1OYGequF2TsSuIjTqudnAmfYGvHJk1rjCBKfnnFHZGw9LPAQRy+Qr4Y6dhWtvjudwmweUO9/ef5bwKWV88oc6XYhNZkQU2baeoY2wPTkTSc1J1hDwlz0xXjsNm0blhYfiCgOFmCF+r5/U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F912FA8E37379D44925C20582EC97251@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b349a827-0667-4e86-7416-08d6ca73ef1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 18:21:00.5665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 26, 2019 at 10:50:29AM -0700, Yonghong Song wrote:
>=20
>=20
> On 4/26/19 10:11 AM, Martin KaFai Lau wrote:
> > This patch supports probing for the new BPF_MAP_TYPE_SK_STORAGE.
> > BPF_MAP_TYPE_SK_STORAGE enforces BTF usage, so the new probe
> > requires to create and load a BTF also.
> >=20
> > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > ---
> >   tools/bpf/bpftool/map.c       |  1 +
> >   tools/lib/bpf/libbpf_probes.c | 74 ++++++++++++++++++++++++++++++++++=
-
> >   2 files changed, 74 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> > index 10b6c9d3e525..693ab3da37de 100644
> > --- a/tools/bpf/bpftool/map.c
> > +++ b/tools/bpf/bpftool/map.c
> > @@ -46,6 +46,7 @@ const char * const map_type_name[] =3D {
> >   	[BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE]	=3D "percpu_cgroup_storage",
> >   	[BPF_MAP_TYPE_QUEUE]			=3D "queue",
> >   	[BPF_MAP_TYPE_STACK]			=3D "stack",
> > +	[BPF_MAP_TYPE_SK_STORAGE]		=3D "sk_storage",
> >   };
> >  =20
> >   const size_t map_type_name_size =3D ARRAY_SIZE(map_type_name);
> > diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probe=
s.c
> > index 0f25541632e3..2e26ddb005e4 100644
> > --- a/tools/lib/bpf/libbpf_probes.c
> > +++ b/tools/lib/bpf/libbpf_probes.c
> > @@ -9,6 +9,7 @@
> >   #include <net/if.h>
> >   #include <sys/utsname.h>
> >  =20
> > +#include <linux/btf.h>
> >   #include <linux/filter.h>
> >   #include <linux/kernel.h>
> >  =20
> > @@ -130,11 +131,65 @@ bool bpf_probe_prog_type(enum bpf_prog_type prog_=
type, __u32 ifindex)
> >   	return errno !=3D EINVAL && errno !=3D EOPNOTSUPP;
> >   }
> >  =20
> > +static int load_btf(void)
> > +{
> > +#define BTF_INFO_ENC(kind, kind_flag, vlen) \
> > +	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
> > +#define BTF_TYPE_ENC(name, info, size_or_type) \
> > +	(name), (info), (size_or_type)
> > +#define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
> > +	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
> > +#define BTF_TYPE_INT_ENC(name, encoding, bits_offset, bits, sz) \
> > +	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz), \
> > +	BTF_INT_ENC(encoding, bits_offset, bits)
> > +#define BTF_MEMBER_ENC(name, type, bits_offset) \
> > +	(name), (type), (bits_offset)
> > +
> > +	const char btf_str_sec[] =3D "\0bpf_spin_lock\0val\0cnt\0l";
> > +	/* struct bpf_spin_lock {
> > +	 *   int val;
> > +	 * };
> > +	 * struct val {
> > +	 *   int cnt;
> > +	 *   struct bpf_spin_lock l;
> > +	 * };
> > +	 */
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
>=20
> In the future, different map types could want to test different type
> configurations. Maybe btf_raw_types and btf_str_sec could be provided
> as a parameter for load_btf()?
I think it will be cleaner to keep one btf_raw_types[].
Other types can be added to the same btf_raw_types[] later instead of
redefining int/long/unsigned...etc.  The bpf_probe_map_type() can
point the btf_key_type_id and btf_value_type_id to different type_id.

It can be revisited if it needs to probe some newly introduced BTF type
(in the type section) later which I think should be very rare.

>=20
> > +
> >   bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
> >   {
> >   	int key_size, value_size, max_entries, map_flags;
> > +	__u32 btf_key_type_id =3D 0, btf_value_type_id =3D 0;
> >   	struct bpf_create_map_attr attr =3D {};
> > -	int fd =3D -1, fd_inner;
> > +	int fd =3D -1, btf_fd =3D -1, fd_inner;
> >  =20
> >   	key_size	=3D sizeof(__u32);
> >   	value_size	=3D sizeof(__u32);
> > @@ -160,6 +215,16 @@ bool bpf_probe_map_type(enum bpf_map_type map_type=
, __u32 ifindex)
> >   	case BPF_MAP_TYPE_STACK:
> >   		key_size	=3D 0;
> >   		break;
> > +	case BPF_MAP_TYPE_SK_STORAGE:
> > +		btf_key_type_id =3D 1;
> > +		btf_value_type_id =3D 3;
> > +		value_size =3D 8;
> > +		max_entries =3D 0;
> > +		map_flags =3D BPF_F_NO_PREALLOC;
> > +		btf_fd =3D load_btf();
> > +		if (btf_fd < 0)
> > +			return false;
> > +		break;
> >   	case BPF_MAP_TYPE_UNSPEC:
> >   	case BPF_MAP_TYPE_HASH:
> >   	case BPF_MAP_TYPE_ARRAY:
> > @@ -205,11 +270,18 @@ bool bpf_probe_map_type(enum bpf_map_type map_typ=
e, __u32 ifindex)
> >   		attr.max_entries =3D max_entries;
> >   		attr.map_flags =3D map_flags;
> >   		attr.map_ifindex =3D ifindex;
> > +		if (btf_fd >=3D 0) {
> > +			attr.btf_fd =3D btf_fd;
> > +			attr.btf_key_type_id =3D btf_key_type_id;
> > +			attr.btf_value_type_id =3D btf_value_type_id;
> > +		}
> >  =20
> >   		fd =3D bpf_create_map_xattr(&attr);
> >   	}
> >   	if (fd >=3D 0)
> >   		close(fd);
> > +	if (btf_fd >=3D 0)
> > +		close(btf_fd);
> >  =20
> >   	return fd >=3D 0;
> >   }
> >=20
