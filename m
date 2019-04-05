Return-Path: <SRS0=rZCH=SH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09B7C282CE
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 20:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D66206BA
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 20:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="g3Gnc0So";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dI72Y/GT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfDEUIW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:08:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56370 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbfDEUIV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Apr 2019 16:08:21 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35JqHp2006824;
        Fri, 5 Apr 2019 13:07:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RrZs0BW2yzAlk1aXDcZyrhYSsPNyygNOjjRKiYFTYys=;
 b=g3Gnc0SoZcBGQVzUOT1pzdozOZm8f9/XIvcrhFohQbkXM4O11NoiJDq5kYsJaGKYHvqV
 dIKl6jr+k4MkR+hAtHzackcXfXDPSEKKh+Tb/I7faIUHRkr1JUQzOxS1mEfTjgXjb6jM
 RX6Tr59vo2QqsjeYXQ5A7GqQqjJ8xVu2Lq0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rpd5904jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Apr 2019 13:07:56 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 5 Apr 2019 13:07:54 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 5 Apr 2019 13:07:54 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 5 Apr 2019 13:07:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrZs0BW2yzAlk1aXDcZyrhYSsPNyygNOjjRKiYFTYys=;
 b=dI72Y/GT1UCiDflolRf8eIghIt1lIGgdlQaur2Hr17fO/bABG12KPv/frYCOJ8W+vm/BrZK6akXIQfLKBfNJOMC0M0jbMY8jWJ0xTEXHUQfyM2dTwj61pcwQ6dwtJe1UEk+IZpiqdfIN63ZsW4G1LKUz2YBntL0nv9CEXFxBKOo=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1871.namprd15.prod.outlook.com (10.174.255.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Fri, 5 Apr 2019 20:07:38 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1750.014; Fri, 5 Apr 2019
 20:07:38 +0000
From:   Martin Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Thread-Topic: [PATCH bpf-next 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Thread-Index: AQHU6xd2Fc2knoVy0Ue1wCzxlZ6/G6YuAD0A
Date:   Fri, 5 Apr 2019 20:07:38 +0000
Message-ID: <20190405200736.ba2mzz42y7pecpsm@kafai-mbp.dhcp.thefacebook.com>
References: <20190404185133.95071-1-sdf@google.com>
In-Reply-To: <20190404185133.95071-1-sdf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:300:93::15) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:a543]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45690400-71ba-4f55-7183-08d6ba02599c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1871;
x-ms-traffictypediagnostic: MWHPR15MB1871:
x-microsoft-antispam-prvs: <MWHPR15MB187131BEBDE8DF652AC91E4BD5510@MWHPR15MB1871.namprd15.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(4326008)(316002)(99286004)(229853002)(71190400001)(68736007)(7736002)(14444005)(256004)(71200400001)(54906003)(305945005)(97736004)(486006)(6486002)(1076003)(14454004)(476003)(6116002)(86362001)(6436002)(386003)(25786009)(76176011)(6506007)(105586002)(446003)(11346002)(2906002)(8936002)(6916009)(478600001)(46003)(8676002)(102836004)(53936002)(9686003)(5660300002)(6512007)(186003)(81166006)(81156014)(106356001)(52116002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1871;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DSGVoGWd4KVvPQxRRjUVsprVA/0IQQiD1pzi9HBEgUtmS82WU3xYZNlpiW8NUbvu8dlah9AgCsBhh+vzNfeWnmG8OCOLe6P5nEhcGBuuL7d+o8OE1UV4Gr/8UzvWUWTN3RsTXfiBZr5XaqRikSswf1USi4nsZI30bzFsql0LWMSoNlcv4oNXCKwz9n5XB96o2WfLuJgcstEy0AstAQmSTVOa82O47nEYIleLbq1Y8AEeA4NMpX46QOE7QUm1fYR79NTk+8t86rDiNc1JMywlq8KFRGNHBasVhXDCpgFGf7raGsDWbhbFXwD75rtaxJVUFlBuAKsd+fqPtzMgEJiKSNcrU+qOlf9td+UblqkTzmY91tSTykjVRGiqC4QdFYrncWh+mRWUgOoER0CGidhtmR0pFN/sT4IzrQTEstJVsvI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30618EE17F025E48A75C2316246573A2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 45690400-71ba-4f55-7183-08d6ba02599c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 20:07:38.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1871
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 04, 2019 at 11:51:31AM -0700, Stanislav Fomichev wrote:
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
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/uapi/linux/bpf.h |   7 +++
>  kernel/bpf/syscall.c     |   2 +-
>  net/bpf/test_run.c       | 133 +++++++++++++++++++++++++++++++++++++--
>  3 files changed, 136 insertions(+), 6 deletions(-)
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
> index 1d65e56594db..4ad754e2943a 100644
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
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index fab142b796ef..593912a66d64 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -123,12 +123,121 @@ static void *bpf_test_init(const union bpf_attr *k=
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
> +	if ((kattr->test.ctx_size_in && !kattr->test.ctx_in) ||
> +	    (!kattr->test.ctx_size_in && kattr->test.ctx_in))
> +		return ERR_PTR(-EINVAL);
> +
> +	if ((kattr->test.ctx_size_out && !kattr->test.ctx_out) ||
> +	    (!kattr->test.ctx_size_out && kattr->test.ctx_out))
> +		return ERR_PTR(-EINVAL);
These attr checks belong to bpf_prog_test_run() in syscall.c.

> +
> +	if (!size)
> +		return NULL;
> +
> +	if (size > max_size)
Not allowed even the tailing (size - max_size) bytes are zero?

> +		return ERR_PTR(-EINVAL);
The convention should be -E2BIG if the userspace passed in something bigger
with tailing non-zero that the kernel cannot understand.

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
> +	u32 copy_size =3D size;
Is the "u32 copy_size =3D size;" needed?
I don't see "size" is changed.

> +
> +	if (!kattr->test.ctx_size_out)
> +		return 0;
> +
> +	if (copy_size > kattr->test.ctx_size_out)
If I read both bpf_ctx_init() and btf_ctx_finish() correctly,
the kattr->test.ctx_size_in (input) can be smaller than
sizeof(struct __sk_buff) but the kattr->test.ctx_size_out (output)
cannot be smaller than sizeof(struct __sk_buff)?

> +		return -ENOSPC;
> +
> +	if (data_out && copy_to_user(data_out, data, copy_size))
"data_out" check is not needed.

> +		return -EFAULT;
> +	if (copy_to_user(&uattr->test.ctx_size_out, &size, sizeof(size)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +/**
> + * range_is_zero - test whether buffer is initialized
> + * @buf: buffer to check
> + * @from: check from this position
> + * @to: check up until (excluding) this position
> + *
> + * This function returns true if the there is a non-zero byte
> + * in the buf in the range [from,to).
> + */
> +static inline bool range_is_zero(void *buf, size_t from, size_t to)
> +{
> +	return !memchr_inv((u8 *)buf + from, 0, to - from);
> +}
> +
> +static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *_=
_skb)
> +{
> +	struct qdisc_skb_cb *cb =3D (struct qdisc_skb_cb *)skb->cb;
> +
> +	if (!__skb)
> +		return 0;
> +
> +	/* make sure the fields we don't use are zeroed */
> +	if (!range_is_zero(__skb, 0, offsetof(struct __sk_buff, priority)))
> +		return -EINVAL;
> +
> +	/* priority is allowed */
> +
> +	if (!range_is_zero(__skb, offsetof(struct __sk_buff, priority) +
> +			   FIELD_SIZEOF(struct __sk_buff, priority),
> +			   offsetof(struct __sk_buff, cb)))
> +		return -EINVAL;
> +
> +	/* cb is allowed */
> +
> +	if (!range_is_zero(__skb, offsetof(struct __sk_buff, cb) +
> +			   FIELD_SIZEOF(struct __sk_buff, cb),
> +			   sizeof(struct __sk_buff)))
> +		return -EINVAL;
> +
> +	skb->priority =3D __skb->priority;
> +	memcpy(&cb->data, __skb->cb, QDISC_CB_PRIV_LEN);
> +
> +	return 0;
> +}
> +
> +static void convert_skb_to___skb(struct sk_buff *skb, struct __sk_buff *=
__skb)
> +{
> +	struct qdisc_skb_cb *cb =3D (struct qdisc_skb_cb *)skb->cb;
> +
> +	if (!__skb)
> +		return;
> +
> +	__skb->priority =3D skb->priority;
> +	memcpy(__skb->cb, &cb->data, QDISC_CB_PRIV_LEN);
> +}
> +
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
> @@ -141,6 +250,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, con=
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
> @@ -158,6 +273,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, cons=
t union bpf_attr *kattr,
>  	sk =3D kzalloc(sizeof(struct sock), GFP_USER);
>  	if (!sk) {
>  		kfree(data);
> +		kfree(ctx);
>  		return -ENOMEM;
>  	}
>  	sock_net_set(sk, current->nsproxy->net_ns);
> @@ -166,6 +282,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, cons=
t union bpf_attr *kattr,
>  	skb =3D build_skb(data, 0);
>  	if (!skb) {
>  		kfree(data);
> +		kfree(ctx);
>  		kfree(sk);
>  		return -ENOMEM;
>  	}
> @@ -180,12 +297,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, co=
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
I think the following needs kfree(ctx) also (or goto out).
Copying the context here:

			if (pskb_expand_head(skb, nhead, 0, GFP_USER)) {
				kfree_skb(skb);
				kfree(sk);
				return -ENOMEM;
			}

> @@ -198,14 +315,20 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
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
