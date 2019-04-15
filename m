Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33EFC10F12
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 22:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02452087C
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 22:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mDxntc19";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="M6q81zQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfDOWqq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:46:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726041AbfDOWqq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Apr 2019 18:46:46 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3FMVZWL024127;
        Mon, 15 Apr 2019 15:46:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zjNShTJ4QORs4GRoijWthSFcVejJNGPbaRvluYo8iSA=;
 b=mDxntc19vxFYcyr1drsPALmFjna+pkmjHIkOcTwPdaz5CfJ6BfUMQ+4+GZCphOfAgLvw
 eW46byooHAuFBvwSDXZeAWnR4vkxWEsiZpiqzyZ2aEZh1NIU+p3Y7E3zpS4nVBo2Bd6g
 FX+qeQjlpSRsvOjKmoZJ4niJMc2DaL/g9BU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2rvvjdsk3a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Apr 2019 15:46:18 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 15 Apr 2019 15:46:17 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 15 Apr 2019 15:46:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjNShTJ4QORs4GRoijWthSFcVejJNGPbaRvluYo8iSA=;
 b=M6q81zQZ80MM+e05miWjp94j022PETPzZh7KapFf1QP/ZhIq3Da3ikr9O2BsUNmN3ZBqPqvMU3Gd73npIBABJWACR1y96mlG01fgBmp66QovsleN59oMwh/b3oTwUxC2glrStdByyCNMzkuclz1vP8aUeC8leSBcyZe5aMgwuX0=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1645.namprd15.prod.outlook.com (10.175.135.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 22:46:15 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 22:46:15 +0000
From:   Martin Lau <kafai@fb.com>
To:     Viet Hoang Tran <hoang.tran@uclouvain.be>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Lawrence Brakmo <brakmo@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "tranviethoang.vn@gmail.com" <tranviethoang.vn@gmail.com>
Subject: Re: [PATCH bpf] bpf: allow clearing all sock_ops callback flags
Thread-Topic: [PATCH bpf] bpf: allow clearing all sock_ops callback flags
Thread-Index: AQHU83FHYT2ycenC0U6Jc5FzR6ziA6Y90yoA
Date:   Mon, 15 Apr 2019 22:46:15 +0000
Message-ID: <20190415224612.qwxqmuxhojcerdgn@kafai-mbp.dhcp.thefacebook.com>
References: <20190415131042.1111-1-hoang.tran@uclouvain.be>
In-Reply-To: <20190415131042.1111-1-hoang.tran@uclouvain.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:104:7::17) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:1421]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ea006ca-ffa2-4b26-cedd-08d6c1f42aa3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1645;
x-ms-traffictypediagnostic: MWHPR15MB1645:
x-microsoft-antispam-prvs: <MWHPR15MB164519061EDBBBC249B64D28D52B0@MWHPR15MB1645.namprd15.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(136003)(396003)(199004)(189003)(316002)(6916009)(186003)(386003)(6506007)(102836004)(54906003)(6486002)(6436002)(52116002)(4744005)(476003)(53936002)(486006)(1076003)(106356001)(46003)(478600001)(11346002)(105586002)(446003)(14454004)(5660300002)(2906002)(9686003)(97736004)(86362001)(6116002)(99286004)(81166006)(8676002)(25786009)(6246003)(8936002)(76176011)(7736002)(229853002)(256004)(3716004)(81156014)(71190400001)(6512007)(68736007)(4326008)(305945005)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1645;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WwJwKOvDGqsUtkH/MQFXH+e+mxGE4jjN38No5DZULSv3iS7LrBTXjaiItKX3RhwFLhcSBoHnSrTgcFBCDu2CqJkgVLGCDmYT8BsONpsaMU41EhTU7ufJZVjzaK8QAp/Y94HeUcHNNJEt0xo4TYtl0BMlpxoFVscou4DCizfiv+C+XqEey/8ldhuabYkb3EtYjY/qFdQkVcIwBNmClNKzMuG8JEDqSI2k6QYEWTRbeu1CiphiTZzf1g0k3ZAoyyumu7oVRcyazdMXmv66XgiRmalf+83a8Ah+e0toybFEC7hnVXbpBdObwcIrMsgfz0mn8dQmWlsiMZ8NslvG8/AW0bB+t1gx3MX6D1nyPuRSMP+lwDJQgHPgohIASXYn5ZzgMraxYwF8gMer816PpPN3TC3XOOxBAC0jtB1dbVhPpKY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67173DAE6953B04AA38DB1DE3054589E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea006ca-ffa2-4b26-cedd-08d6c1f42aa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 22:46:15.5897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1645
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 15, 2019 at 09:54:55AM +0000, Viet Hoang Tran wrote:
> The helper function bpf_sock_ops_cb_flags_set() can be used to both
> set and clear the sock_ops callback flags. However, its current
> behavior is not consistent. BPF program may clear a flag if more than
> one were set, or replace a flag with another one, but cannot clear all
> flags.
>=20
> This patch also updates the documentation to clarify the ability to
> clear flags of this helper function.
>

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index fc92ebc4e200..0c4cdfbb2fc7 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4355,8 +4355,7 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_so=
ck_ops_kern *, bpf_sock,
>  	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
>  		return -EINVAL;
> =20
> -	if (val)
> -		tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> +	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
Acked-by: Martin KaFai Lau <kafai@fb.com>

> =20
>  	return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
>  }
> --=20
> 2.17.1
>=20
