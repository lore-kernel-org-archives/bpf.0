Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BFEC10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 16:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8CA2073F
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 16:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Jx+GAYOP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UZH1T0AP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDLQIy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:08:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49716 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726702AbfDLQIy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Apr 2019 12:08:54 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3CFuqda020708;
        Fri, 12 Apr 2019 09:08:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=8QsSR/N4yZi3OfthgqGRQqLDavdwZ0/Et1ktLpJESt8=;
 b=Jx+GAYOPqB2VGrolOgaWgo9Q+xZKmwS0vyJfQJmcyrCiNnno+WRo8cLdkVM3Yh1OWbM+
 /3U8Pf683wPNvxZcYI9B9YOA0Zr8g4liXzAgpaCimXJqArSM+cZLSlqtuZ+DIXGfuLt7
 CQX/dmc3h9+4wsxvHvVgU9WBm578zaorKRQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2rtfspa6y4-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 12 Apr 2019 09:08:30 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 12 Apr 2019 09:08:26 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 12 Apr 2019 09:08:25 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 12 Apr 2019 09:08:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QsSR/N4yZi3OfthgqGRQqLDavdwZ0/Et1ktLpJESt8=;
 b=UZH1T0APaaSsRihDB/EVtUhEiQGjKkcD2nWvWkXBnzfqPraNW4EGjUqdR8IYnkwwcM/rNiPEPpTtT2TVipFtEjSK9gVOgsQ7f7NUuS04KkXD0C9cP0dKEXYIJ3xvjbZR5JARwPCMLhgOqG/Hqffdj250dzjkxwz+hvBcNjd0QtU=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1385.namprd15.prod.outlook.com (10.173.224.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Fri, 12 Apr 2019 16:08:24 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::290e:d830:9d6c:e8a2]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::290e:d830:9d6c:e8a2%11]) with mapi id 15.20.1792.009; Fri, 12 Apr
 2019 16:08:24 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alan Maguire <alan.maguire@oracle.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        Andrey Ignatov <rdna@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: fix whitespace for ENCAP_L2 defines in
 bpf.h
Thread-Topic: [PATCH bpf-next] bpf: fix whitespace for ENCAP_L2 defines in
 bpf.h
Thread-Index: AQHU8SLPnWStndNUmkqBQWNe6wW4nKY4saKA
Date:   Fri, 12 Apr 2019 16:08:23 +0000
Message-ID: <C7F0DF3C-260F-4FA1-BE9A-A34325EF3D03@fb.com>
References: <1555068454-27894-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1555068454-27894-1-git-send-email-alan.maguire@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::1:b0cf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f752ffbb-0f0e-47ce-353d-08d6bf611737
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR15MB1385;
x-ms-traffictypediagnostic: DM5PR15MB1385:
x-microsoft-antispam-prvs: <DM5PR15MB13852A5A51C2B6F497171533B3280@DM5PR15MB1385.namprd15.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39860400002)(199004)(189003)(97736004)(7736002)(11346002)(6506007)(476003)(53936002)(305945005)(76176011)(6116002)(316002)(486006)(2616005)(54906003)(446003)(6512007)(46003)(86362001)(6916009)(36756003)(5660300002)(102836004)(99286004)(68736007)(81166006)(83716004)(256004)(6246003)(4326008)(81156014)(57306001)(478600001)(53546011)(105586002)(33656002)(2906002)(6486002)(25786009)(82746002)(6436002)(106356001)(8676002)(186003)(8936002)(71200400001)(71190400001)(14454004)(50226002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1385;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B8wN65ycyWEqy4rBQmq6scdDtvUdSxVHPN+VeVmMM5p+cJoUQXVDlyXI7G6mT2eWyPUoJlG9FYkxEHc34h+fR/P+j1C94Iab4OG9/3SvavhC65tTDmok54Bizk2omAi5BNITlBzFD38+pnyMiRUnfuyO61aBe3ccRB2/tUFE9FKhOMzGNcYiRWjMk4hI9FrE38Mb0JhD7nbjpY4WtqPJR6hjG8kGstAS1Qkczojm+Gg0AIXYli7iT+8f5RPhA+/cc+ZuU0PPEuaV+24RkVJJ/nHlpHubmE1g0Rwwb3izAR/MyuTiMFnPTOkefrtO/TS7KAUGuev2tgJR1LVoaqvglJ+iqoHBySnIiMzeFcjtfvernWJaE25u9XzWySqQderivwzEauTqVcvk2wDXxIWBuRtuuRO6giA50j+3shkjx4Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A26F61C81DD98A409D109760586F3142@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f752ffbb-0f0e-47ce-353d-08d6bf611737
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 16:08:23.9608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1385
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 12, 2019, at 4:27 AM, Alan Maguire <alan.maguire@oracle.com> wrote=
:
>=20
> replace tab after #define with space in line with rest of definitions
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Song Liu <songliubraving@fb.com>


> ---
> include/uapi/linux/bpf.h       | 6 +++---
> tools/include/uapi/linux/bpf.h | 6 +++---
> 2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2e96d0b..dacf3fc 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2668,14 +2668,14 @@ enum bpf_func_id {
> /* BPF_FUNC_skb_adjust_room flags. */
> #define BPF_F_ADJ_ROOM_FIXED_GSO	(1ULL << 0)
>=20
> -#define	BPF_ADJ_ROOM_ENCAP_L2_MASK	0xff
> -#define	BPF_ADJ_ROOM_ENCAP_L2_SHIFT	56
> +#define BPF_ADJ_ROOM_ENCAP_L2_MASK	0xff
> +#define BPF_ADJ_ROOM_ENCAP_L2_SHIFT	56
>=20
> #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	(1ULL << 1)
> #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	(1ULL << 2)
> #define BPF_F_ADJ_ROOM_ENCAP_L4_GRE	(1ULL << 3)
> #define BPF_F_ADJ_ROOM_ENCAP_L4_UDP	(1ULL << 4)
> -#define	BPF_F_ADJ_ROOM_ENCAP_L2(len)	(((__u64)len & \
> +#define BPF_F_ADJ_ROOM_ENCAP_L2(len)	(((__u64)len & \
> 					  BPF_ADJ_ROOM_ENCAP_L2_MASK) \
> 					 << BPF_ADJ_ROOM_ENCAP_L2_SHIFT)
>=20
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 2e96d0b..dacf3fc 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -2668,14 +2668,14 @@ enum bpf_func_id {
> /* BPF_FUNC_skb_adjust_room flags. */
> #define BPF_F_ADJ_ROOM_FIXED_GSO	(1ULL << 0)
>=20
> -#define	BPF_ADJ_ROOM_ENCAP_L2_MASK	0xff
> -#define	BPF_ADJ_ROOM_ENCAP_L2_SHIFT	56
> +#define BPF_ADJ_ROOM_ENCAP_L2_MASK	0xff
> +#define BPF_ADJ_ROOM_ENCAP_L2_SHIFT	56
>=20
> #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	(1ULL << 1)
> #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	(1ULL << 2)
> #define BPF_F_ADJ_ROOM_ENCAP_L4_GRE	(1ULL << 3)
> #define BPF_F_ADJ_ROOM_ENCAP_L4_UDP	(1ULL << 4)
> -#define	BPF_F_ADJ_ROOM_ENCAP_L2(len)	(((__u64)len & \
> +#define BPF_F_ADJ_ROOM_ENCAP_L2(len)	(((__u64)len & \
> 					  BPF_ADJ_ROOM_ENCAP_L2_MASK) \
> 					 << BPF_ADJ_ROOM_ENCAP_L2_SHIFT)
>=20
> --=20
> 1.8.3.1
>=20

