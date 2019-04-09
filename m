Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACC9C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 18:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B202077C
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 18:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="V9/R3gKL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GGj4cq8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDISZb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:25:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33560 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbfDISZa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Apr 2019 14:25:30 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39IGn5k019965;
        Tue, 9 Apr 2019 11:25:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LGZuwLOpsYq/BaJjn3FVR3xDlb2m3cfGk6RnFt6ITCk=;
 b=V9/R3gKLhYaRIpZmm8WHYlT5l/R5tftV317eysvECQIHr7kv8PAN1srZfN36gYaTgBNA
 Z0krWf+T0cr/lWZ5H7f4qR4TKVOQnC6m1EMJITlXHoeRna93nbTpytCuRTDihh7yEzXj
 vSbOAU8mnrMZlryGzWVGDQYBu8mPAlYUkuY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rrwca0ymn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 11:25:05 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 11:25:04 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 11:25:04 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Apr 2019 11:25:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGZuwLOpsYq/BaJjn3FVR3xDlb2m3cfGk6RnFt6ITCk=;
 b=GGj4cq8rojVBJy5ECKSDP9Y3H7aJlphrPyQFUTSEFTF4E4DF+g7Ew7iWiL2CeopLQQMtmO+GDn9ZYi7FWaS9xXF8+ChUuq4zrBpuoSxbBtDka9ajxe5iGVSJyTvhFTGPFw5l5X4zXFm0qnEyxk4TbLjlhG9hIcj3zH/ZiTIE0+g=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1440.namprd15.prod.outlook.com (10.173.234.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 18:25:02 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 18:25:02 +0000
From:   Martin Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Thread-Topic: [PATCH bpf-next v3 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Thread-Index: AQHU7vmXZoWOQe8RskaIzAVsSLH2WqY0JSIA
Date:   Tue, 9 Apr 2019 18:25:02 +0000
Message-ID: <20190409182500.ezvhvgfrcbdvhd6o@kafai-mbp>
References: <20190409172739.242389-1-sdf@google.com>
In-Reply-To: <20190409172739.242389-1-sdf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0093.namprd22.prod.outlook.com
 (2603:10b6:301:5e::46) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::8c82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 352c0b93-2732-4381-490c-08d6bd18ae65
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1440;
x-ms-traffictypediagnostic: MWHPR15MB1440:
x-microsoft-antispam-prvs: <MWHPR15MB144091EFF43066EDDF8A11F7D52D0@MWHPR15MB1440.namprd15.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(54906003)(5660300002)(102836004)(106356001)(4326008)(97736004)(52116002)(305945005)(8676002)(186003)(25786009)(86362001)(8936002)(6506007)(105586002)(256004)(316002)(6436002)(9686003)(6512007)(53936002)(386003)(7736002)(81156014)(229853002)(71190400001)(99286004)(71200400001)(81166006)(6916009)(68736007)(33716001)(1076003)(11346002)(478600001)(46003)(2906002)(76176011)(486006)(476003)(6116002)(446003)(6486002)(14454004)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1440;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EBDeJPnhmruf2iheHUwdsaz7go2O/YOf+RcwHXuZ3Hrt+914LtBUWgLMtmcxBZFlBHmB8mdkWnrlF3+lhkNJzIrOiB8CJnuoUlSyZHw5DZlMhH3KAi3LQBMBZJi3Y9Njh4+KCJrI7DFwd3rdE25FGBqNwEN4Vo6SKJtN3rBZ/ASbhH0xEir5BTYs7QIva8kF9Z84pstUs9BIZaPAkRwNHjKYEoxOliLexPJ0lF/Go4/p6VHAoJDenWH5V2akkRPnWsGYKBvszSJXXSPLNoFMRA+lX8q8KV7KuL5O47VUo7BRNWhuvCVy3McA7xx9wklsBCUdoN/8G7rhYTch8iuOKCXg0Qmg3IY1gs2G4nqDeAB9gZ6dbEQMW514raqITDNIQ7ZiqxUdA1p1tEk7mjFFsRze4uXylJ6e9aAizbZuLTU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A96706F4DAD30C4A95CBBA53FA76EA0D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 352c0b93-2732-4381-490c-08d6bd18ae65
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 18:25:02.5684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1440
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 09, 2019 at 10:27:37AM -0700, Stanislav Fomichev wrote:
> Add new set of arguments to bpf_attr for BPF_PROG_TEST_RUN:
> * ctx_in/ctx_size_in - input context
> * ctx_out/ctx_size_out - output context
>=20
> The intended use case is to pass some meta data to the test runs that
> operate on skb (this has being brought up on recent LPC).
>=20
> For programs that use bpf_prog_test_run_skb, support __sk_buff input and
> output. Initially, from input __sk_buff, copy _only_ cb and priority into
> skb, all other non-zero fields are prohibited (with EINVAL).
> If the user has set ctx_out/ctx_size_out, copy the potentially modified
> __sk_buff back to the userspace.
>=20
> We require all fields of input __sk_buff except the ones we explicitly
> support to be set to zero. The expectation is that in the future we might
> add support for more fields and we want to fail explicitly if the user
> runs the program on the kernel where we don't yet support them.
>=20
> The API is intentionally vague (i.e. we don't explicitly add __sk_buff
> to bpf_attr, but ctx_in) to potentially let other test_run types use
> this interface in the future (this can be xdp_md for xdp types for
> example).
>=20
> v3:
>   * handle case where ctx_in is NULL, but ctx_out is not [Martin]
>   * convert size=3D=3D0 checks to ptr=3D=3DNULL checks and add some extra=
 ptr
>     checks [Martin]
>=20
> v2:
>   * Addressed comments from Martin Lau
>=20
> Cc: Martin Lau <kafai@fb.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/uapi/linux/bpf.h |   7 ++
>  kernel/bpf/syscall.c     |  10 ++-
>  net/bpf/test_run.c       | 142 ++++++++++++++++++++++++++++++++++++---
>  3 files changed, 150 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 837024512baf..8e96f99cebf8 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -396,6 +396,13 @@ union bpf_attr {
>  		__aligned_u64	data_out;
>  		__u32		repeat;
>  		__u32		duration;
> +		__u32		ctx_size_in;	/* input: len of ctx_in */
> +		__u32		ctx_size_out;	/* input/output: len of ctx_out
> +						 *   returns ENOSPC if ctx_out
> +						 *   is too small.
> +						 */
> +		__aligned_u64	ctx_in;
> +		__aligned_u64	ctx_out;
>  	} test;
> =20
>  	struct { /* anonymous struct used by BPF_*_GET_*_ID */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 1d65e56594db..5bb963e8f9b0 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1949,7 +1949,7 @@ static int bpf_prog_query(const union bpf_attr *att=
r,
>  	return cgroup_bpf_prog_query(attr, uattr);
>  }
> =20
> -#define BPF_PROG_TEST_RUN_LAST_FIELD test.duration
> +#define BPF_PROG_TEST_RUN_LAST_FIELD test.ctx_out
> =20
>  static int bpf_prog_test_run(const union bpf_attr *attr,
>  			     union bpf_attr __user *uattr)
> @@ -1962,6 +1962,14 @@ static int bpf_prog_test_run(const union bpf_attr =
*attr,
>  	if (CHECK_ATTR(BPF_PROG_TEST_RUN))
>  		return -EINVAL;
> =20
> +	if ((attr->test.ctx_size_in && !attr->test.ctx_in) ||
> +	    (!attr->test.ctx_size_in && attr->test.ctx_in))
> +		return -EINVAL;
> +
> +	if ((attr->test.ctx_size_out && !attr->test.ctx_out) ||
> +	    (!attr->test.ctx_size_out && attr->test.ctx_out))
> +		return -EINVAL;
> +
>  	prog =3D bpf_prog_get(attr->test.prog_fd);
>  	if (IS_ERR(prog))
>  		return PTR_ERR(prog);
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index fab142b796ef..2023d8841c6d 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -123,12 +123,125 @@ static void *bpf_test_init(const union bpf_attr *k=
attr, u32 size,
>  	return data;
>  }
> =20
> +static void *bpf_ctx_init(const union bpf_attr *kattr, u32 max_size)
> +{
> +	void __user *data_in =3D u64_to_user_ptr(kattr->test.ctx_in);
> +	void __user *data_out =3D u64_to_user_ptr(kattr->test.ctx_out);
> +	u32 size =3D kattr->test.ctx_size_in;
> +	void *data;
> +	int err;
> +
> +	if (!data_in && !data_out)
> +		return NULL;
> +
> +	data =3D kzalloc(max_size, GFP_USER);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (data_in) {
> +		err =3D bpf_check_uarg_tail_zero(data_in, max_size, size);
> +		if (err) {
> +			kfree(data);
> +			return ERR_PTR(err);
> +		}
> +
> +		if (copy_from_user(data, data_in, size)) {
A min_t is needed:
		size =3D min_t(u32, max_size, size);
		if (copy_from_user(data, data_in, size)) {

Others lgtm,

Acked-by: Martin KaFai Lau <kafai@fb.com>

> +			kfree(data);
> +			return ERR_PTR(-EFAULT);
> +		}
> +	}
> +	return data;
> +}
