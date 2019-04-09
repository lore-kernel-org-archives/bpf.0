Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ABDC10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 05:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDA220833
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 05:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OH2AKFoF";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PwVDY/0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfDIF1s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:27:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34536 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbfDIF1s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Apr 2019 01:27:48 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x395RLnB012460;
        Mon, 8 Apr 2019 22:27:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=IpyJosn9lixr//jA0K5I8fLPLNo8MkD3tPTeVn5iTW0=;
 b=OH2AKFoF3Vamc/e1J1ergC6Xe2JuR2WjUp5MT0NKRlyWGoKR5OpZNgd+J/pEeyKkz3+4
 Q1UuirCKDZIWdub++lVeNZu18Tynujru0UxlYniwcB/w0EMFLbu+JdGqy7vRtIAyg6jM
 7w0sAzNgAzry6YeFr7LN+hTte317spU3VMc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rrdhe9ect-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Apr 2019 22:27:21 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 8 Apr 2019 22:27:20 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 8 Apr 2019 22:27:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpyJosn9lixr//jA0K5I8fLPLNo8MkD3tPTeVn5iTW0=;
 b=PwVDY/0FBL7iXdzpL56nCg2aDQLc8CCmhR7G/dA04qRVLRBjwrLfKdVKPddjz4m876eRvd+D8MKRVW3n0l0kD9GmIjSEz18wxGsWr43NwwyFCOogLjkdRjqdke4Jyz9nAdjevmF1LQMUHp/bdT8BxGvVu0P2AUaCuC5YgiuedHY=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1184.namprd15.prod.outlook.com (10.175.2.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 05:27:18 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 05:27:18 +0000
From:   Martin Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Thread-Topic: [PATCH bpf-next v2 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Thread-Index: AQHU7iTFVkTXAz8v906Z0KMDyxwwG6YzTX6A
Date:   Tue, 9 Apr 2019 05:27:17 +0000
Message-ID: <20190409052715.fwd3wmabo6yssjgv@kafai-mbp.dhcp.thefacebook.com>
References: <20190408160432.151478-1-sdf@google.com>
In-Reply-To: <20190408160432.151478-1-sdf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:300:ad::33) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::bb46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e462c5b-f1bc-455d-ffeb-08d6bcac07e3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1184;
x-ms-traffictypediagnostic: MWHPR15MB1184:
x-microsoft-antispam-prvs: <MWHPR15MB11848AD36324DFB009E62390D52D0@MWHPR15MB1184.namprd15.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39860400002)(366004)(346002)(199004)(189003)(6436002)(76176011)(6246003)(486006)(6116002)(6486002)(53936002)(6916009)(99286004)(229853002)(1076003)(9686003)(6512007)(5660300002)(97736004)(46003)(52116002)(7736002)(86362001)(14444005)(71200400001)(71190400001)(256004)(14454004)(305945005)(6506007)(102836004)(186003)(81156014)(446003)(68736007)(11346002)(4326008)(8676002)(476003)(8936002)(316002)(2906002)(81166006)(106356001)(105586002)(478600001)(25786009)(54906003)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1184;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wHK7NpZh2zCRaLob5/VencLUGtSC+yNT7TFmowLKT+EVKRzWMcKzQQvK/egvJ9jI38nt9leWlf+8eq5m7oOFhurYPfXsnoNjXZO94pVnf3svEDp8d1bee4M9pQrc1ngagEAHweTYIoTQ+i5EP6Z8JUnYhLUnEogEEP6bsmRc+OJKBLHXcxYOGq6R9H4cZOPNDEty52dqUJVlmSzguxL5s0ClqxdheFJIr7QWQTD8qy1Ve1i8xFW0sP2vwS6TWbMry8gESyre2o463Ncmn65kV52LUX47atKffQoSSvzxSLYH7gEJ1ypmVvmPUX2A2OLLvaAL+qNyp39exWAmpw0nhxVptVrsXJ/nm3Dyvvt+ieyAhfFINtVJOEDCTSdySQG+Qp524Rf5Sm+Lzo1/AoRo9zA3B078kZP3EqAW9bsHjog=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A784793E4BA7754CA20E930BA75E7A64@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e462c5b-f1bc-455d-ffeb-08d6bcac07e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 05:27:18.0560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1184
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 08, 2019 at 09:04:30AM -0700, Stanislav Fomichev wrote:
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
> v2:
>   * Addressed comments from Martin Lau
>=20
> Cc: Martin Lau <kafai@fb.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/uapi/linux/bpf.h |   7 ++
>  kernel/bpf/syscall.c     |  10 ++-
>  net/bpf/test_run.c       | 135 ++++++++++++++++++++++++++++++++++++---
>  3 files changed, 143 insertions(+), 9 deletions(-)
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
> index fab142b796ef..3c6e3855c886 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -123,12 +123,118 @@ static void *bpf_test_init(const union bpf_attr *k=
attr, u32 size,
>  	return data;
>  }
> =20
> +static void *bpf_ctx_init(const union bpf_attr *kattr, u32 max_size)
> +{
> +	void __user *data_in =3D u64_to_user_ptr(kattr->test.ctx_in);
> +	u32 size =3D kattr->test.ctx_size_in;
> +	void *data;
> +
> +	if (!size)
> +		return NULL;
A note for a later comment in bpf_prog_test_run_skb().
This function may return NULL.

> +
> +	if (size > max_size)
If should be fine if the kernel unsupported bytes are zeros
(i.e. tailing zeros in data_in).
Please refer to the existing bpf_check_uarg_tail_zero() usages
or also CHECK_ATTR() in syscall.c. Something like this if
bpf_check_uarg_tail_zero() is used,

	err =3D bpf_check_uarg_tail_zero(data_in, max_size, size));
	if (err)
		return ERR_PTR(err);

> +		return ERR_PTR(-E2BIG);
> +
> +	data =3D kzalloc(max_size, GFP_USER);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (copy_from_user(data, data_in, size)) {
> +		kfree(data);
> +		return ERR_PTR(-EFAULT);
> +	}
> +	return data;
> +}
> +
> +static int bpf_ctx_finish(const union bpf_attr *kattr,
> +			  union bpf_attr __user *uattr, const void *data,
> +			  u32 size)
> +{
> +	void __user *data_out =3D u64_to_user_ptr(kattr->test.ctx_out);
> +	int err =3D -EFAULT;
> +	u32 copy_size =3D size;
> +
data is not checked for NULL here.

> +	if (!kattr->test.ctx_size_out)
> +		return 0;
> +
> +	if (copy_size > kattr->test.ctx_size_out) {
> +		copy_size =3D kattr->test.ctx_size_out;
> +		err =3D -ENOSPC;
> +	}
> +
> +	if (copy_to_user(data_out, data, copy_size))
> +		goto out;
> +	if (copy_to_user(&uattr->test.ctx_size_out, &size, sizeof(size)))
> +		goto out;
> +	if (err !=3D -ENOSPC)
> +		err =3D 0;
> +out:
> +	return err;
> +}

[ ... ]

>  int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *k=
attr,
>  			  union bpf_attr __user *uattr)
>  {
>  	bool is_l2 =3D false, is_direct_pkt_access =3D false;
>  	u32 size =3D kattr->test.data_size_in;
>  	u32 repeat =3D kattr->test.repeat;
> +	struct __sk_buff *ctx =3D NULL;
>  	u32 retval, duration;
>  	int hh_len =3D ETH_HLEN;
>  	struct sk_buff *skb;
> @@ -141,6 +247,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, con=
st union bpf_attr *kattr,
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
> =20
> +	ctx =3D bpf_ctx_init(kattr, sizeof(struct __sk_buff));
> +	if (IS_ERR(ctx)) {
> +		kfree(data);
> +		return PTR_ERR(ctx);
> +	}
> +
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_SCHED_CLS:
>  	case BPF_PROG_TYPE_SCHED_ACT:
> @@ -158,6 +270,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, cons=
t union bpf_attr *kattr,
>  	sk =3D kzalloc(sizeof(struct sock), GFP_USER);
>  	if (!sk) {
>  		kfree(data);
> +		kfree(ctx);
>  		return -ENOMEM;
>  	}
>  	sock_net_set(sk, current->nsproxy->net_ns);
> @@ -166,6 +279,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, cons=
t union bpf_attr *kattr,
>  	skb =3D build_skb(data, 0);
>  	if (!skb) {
>  		kfree(data);
> +		kfree(ctx);
>  		kfree(sk);
>  		return -ENOMEM;
>  	}
> @@ -180,32 +294,37 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
>  		__skb_push(skb, hh_len);
>  	if (is_direct_pkt_access)
>  		bpf_compute_data_pointers(skb);
> +	ret =3D convert___skb_to_skb(skb, ctx);
> +	if (ret)
> +		goto out;
>  	ret =3D bpf_test_run(prog, skb, repeat, &retval, &duration);
> -	if (ret) {
> -		kfree_skb(skb);
> -		kfree(sk);
> -		return ret;
> -	}
> +	if (ret)
> +		goto out;
>  	if (!is_l2) {
>  		if (skb_headroom(skb) < hh_len) {
>  			int nhead =3D HH_DATA_ALIGN(hh_len - skb_headroom(skb));
> =20
>  			if (pskb_expand_head(skb, nhead, 0, GFP_USER)) {
> -				kfree_skb(skb);
> -				kfree(sk);
> -				return -ENOMEM;
> +				ret =3D -ENOMEM;
> +				goto out;
>  			}
>  		}
>  		memset(__skb_push(skb, hh_len), 0, hh_len);
>  	}
> +	convert_skb_to___skb(skb, ctx);
> =20
>  	size =3D skb->len;
>  	/* bpf program can never convert linear skb to non-linear */
>  	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
>  		size =3D skb_headlen(skb);
>  	ret =3D bpf_test_finish(kattr, uattr, skb->data, size, retval, duration=
);
> +	if (!ret)
> +		ret =3D bpf_ctx_finish(kattr, uattr, ctx,
ctx is not checked for NULL in here either.

> +				     sizeof(struct __sk_buff));
> +out:
>  	kfree_skb(skb);
>  	kfree(sk);
> +	kfree(ctx);
>  	return ret;
>  }
> =20
> --=20
> 2.21.0.392.gf8f6787159e-goog
>=20
