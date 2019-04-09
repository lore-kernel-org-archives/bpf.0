Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0852AC10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 16:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D4B20883
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 16:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jypZmZ08";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WKRZgV6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDIQY5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:24:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47474 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726372AbfDIQY5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Apr 2019 12:24:57 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39GHde8027385;
        Tue, 9 Apr 2019 09:24:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=gg6ifPdHL9xXghFrfAUHSgdfBJfLQajqLE2jjqrvr6E=;
 b=jypZmZ08jg69oX6Nt4H0czEcJ32hDkOR4XNN3HTLunx2p/9WmgeP9cE2psjqblFjwjTT
 wdI8XxCmq5zN1jlgwzhxt+8qtgdLZwhUTT96gZtPKLrZpJBxse7Z8kkUkMxiUNscR3tX
 C4QkiJdYPXOvT3avKWDkdUSKSvL035YILjw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rrv2brthr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 09:24:33 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 09:24:32 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 09:24:31 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Apr 2019 09:24:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gg6ifPdHL9xXghFrfAUHSgdfBJfLQajqLE2jjqrvr6E=;
 b=WKRZgV6au5G5iPRvm2bH4CwSR5XVSKq5TQAjxQu8Mwo+dxEySFY210dFSezaO0hjshk92hVst2r77OvMJAyBKFzriEzsEuynU9uMNM0xWtrE1ZMUzXyJjqJjCBnr1TM+QwARgtbi42afR6R60KUSxEMSw0MxZy83ghjhjVETWjI=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1646.namprd15.prod.outlook.com (10.175.138.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Tue, 9 Apr 2019 16:24:29 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 16:24:29 +0000
From:   Martin Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
CC:     Stanislav Fomichev <sdf@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Thread-Topic: [PATCH bpf-next v2 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Thread-Index: AQHU7iTFVkTXAz8v906Z0KMDyxwwG6YzTX6AgACzFACAAASAAA==
Date:   Tue, 9 Apr 2019 16:24:28 +0000
Message-ID: <20190409162418.2pbwltzv3qe4tovk@kafai-mbp>
References: <20190408160432.151478-1-sdf@google.com>
 <20190409052715.fwd3wmabo6yssjgv@kafai-mbp.dhcp.thefacebook.com>
 <20190409160812.GL7431@mini-arch.hsd1.ca.comcast.net>
In-Reply-To: <20190409160812.GL7431@mini-arch.hsd1.ca.comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0058.namprd15.prod.outlook.com
 (2603:10b6:101:1f::26) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::8c82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2be93c51-073a-406a-4bde-08d6bd07d6b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1646;
x-ms-traffictypediagnostic: MWHPR15MB1646:
x-microsoft-antispam-prvs: <MWHPR15MB1646C0506C1A8BCA1ECAB2BED52D0@MWHPR15MB1646.namprd15.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(346002)(366004)(396003)(376002)(39860400002)(189003)(199004)(106356001)(1076003)(6916009)(86362001)(229853002)(71200400001)(6486002)(478600001)(71190400001)(186003)(6116002)(9686003)(6436002)(11346002)(14454004)(14444005)(446003)(6512007)(256004)(4326008)(486006)(52116002)(476003)(99286004)(53936002)(33716001)(8676002)(76176011)(6246003)(97736004)(8936002)(6506007)(305945005)(81166006)(46003)(54906003)(68736007)(2906002)(25786009)(102836004)(105586002)(316002)(7736002)(81156014)(5660300002)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1646;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CSlROHygB8O4RCdlQwLs07xm2t0AR40lvNh9OMRuULJo7vIIi3D0eg0RZBH9inXWdaBhUsKMZZ62J+qH4YxsNVpbIDOj8I27EdliIlHOZYTKrAL0C7l58go9Vf1meynJCCPAv1N4YeAXDVwoZys0Nn5814PxtfnXexA7wG4M7h5IPvdSEwBO/F6gsDW2wwobcQuQ/zdNr5YFWMSGfLnHu8yPUNI+nCvl8jG3AfYxkFa4yfOhAaxnxSg5kdm3m+5PSzvP23Pfi41CwGTVT546RqPWd1vBtq0A7hFqoM2mhB//ZP6exhTppdYiWf4ASUspauouYwCwRd2pKvzskCcN2bCnaunBq1TDTKydvSjmzxOpza9yTYiP9aeUVj/ksj6aIZwJHI86UMgBLJ+LmM/HBYaFDWtln7Fody4YJX6BQrc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2B2A63EECCD9B40A2571799705B692C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be93c51-073a-406a-4bde-08d6bd07d6b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 16:24:28.8902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1646
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 09, 2019 at 09:08:12AM -0700, Stanislav Fomichev wrote:
> On 04/09, Martin Lau wrote:
> > On Mon, Apr 08, 2019 at 09:04:30AM -0700, Stanislav Fomichev wrote:
> > > Add new set of arguments to bpf_attr for BPF_PROG_TEST_RUN:
> > > * ctx_in/ctx_size_in - input context
> > > * ctx_out/ctx_size_out - output context
> > >=20
> > > The intended use case is to pass some meta data to the test runs that
> > > operate on skb (this has being brought up on recent LPC).
> > >=20
> > > For programs that use bpf_prog_test_run_skb, support __sk_buff input =
and
> > > output. Initially, from input __sk_buff, copy _only_ cb and priority =
into
> > > skb, all other non-zero fields are prohibited (with EINVAL).
> > > If the user has set ctx_out/ctx_size_out, copy the potentially modifi=
ed
> > > __sk_buff back to the userspace.
> > >=20
> > > We require all fields of input __sk_buff except the ones we explicitl=
y
> > > support to be set to zero. The expectation is that in the future we m=
ight
> > > add support for more fields and we want to fail explicitly if the use=
r
> > > runs the program on the kernel where we don't yet support them.
> > >=20
> > > The API is intentionally vague (i.e. we don't explicitly add __sk_buf=
f
> > > to bpf_attr, but ctx_in) to potentially let other test_run types use
> > > this interface in the future (this can be xdp_md for xdp types for
> > > example).
> > >=20
> > > v2:
> > >   * Addressed comments from Martin Lau
> > >=20
> > > Cc: Martin Lau <kafai@fb.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >  include/uapi/linux/bpf.h |   7 ++
> > >  kernel/bpf/syscall.c     |  10 ++-
> > >  net/bpf/test_run.c       | 135 ++++++++++++++++++++++++++++++++++++-=
--
> > >  3 files changed, 143 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 837024512baf..8e96f99cebf8 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -396,6 +396,13 @@ union bpf_attr {
> > >  		__aligned_u64	data_out;
> > >  		__u32		repeat;
> > >  		__u32		duration;
> > > +		__u32		ctx_size_in;	/* input: len of ctx_in */
> > > +		__u32		ctx_size_out;	/* input/output: len of ctx_out
> > > +						 *   returns ENOSPC if ctx_out
> > > +						 *   is too small.
> > > +						 */
> > > +		__aligned_u64	ctx_in;
> > > +		__aligned_u64	ctx_out;
> > >  	} test;
> > > =20
> > >  	struct { /* anonymous struct used by BPF_*_GET_*_ID */
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 1d65e56594db..5bb963e8f9b0 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -1949,7 +1949,7 @@ static int bpf_prog_query(const union bpf_attr =
*attr,
> > >  	return cgroup_bpf_prog_query(attr, uattr);
> > >  }
> > > =20
> > > -#define BPF_PROG_TEST_RUN_LAST_FIELD test.duration
> > > +#define BPF_PROG_TEST_RUN_LAST_FIELD test.ctx_out
> > > =20
> > >  static int bpf_prog_test_run(const union bpf_attr *attr,
> > >  			     union bpf_attr __user *uattr)
> > > @@ -1962,6 +1962,14 @@ static int bpf_prog_test_run(const union bpf_a=
ttr *attr,
> > >  	if (CHECK_ATTR(BPF_PROG_TEST_RUN))
> > >  		return -EINVAL;
> > > =20
> > > +	if ((attr->test.ctx_size_in && !attr->test.ctx_in) ||
> > > +	    (!attr->test.ctx_size_in && attr->test.ctx_in))
> > > +		return -EINVAL;
> > > +
> > > +	if ((attr->test.ctx_size_out && !attr->test.ctx_out) ||
> > > +	    (!attr->test.ctx_size_out && attr->test.ctx_out))
> > > +		return -EINVAL;
> > > +
> > >  	prog =3D bpf_prog_get(attr->test.prog_fd);
> > >  	if (IS_ERR(prog))
> > >  		return PTR_ERR(prog);
> > > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > > index fab142b796ef..3c6e3855c886 100644
> > > --- a/net/bpf/test_run.c
> > > +++ b/net/bpf/test_run.c
> > > @@ -123,12 +123,118 @@ static void *bpf_test_init(const union bpf_att=
r *kattr, u32 size,
> > >  	return data;
> > >  }
> > > =20
> > > +static void *bpf_ctx_init(const union bpf_attr *kattr, u32 max_size)
> > > +{
> > > +	void __user *data_in =3D u64_to_user_ptr(kattr->test.ctx_in);
> > > +	u32 size =3D kattr->test.ctx_size_in;
> > > +	void *data;
> > > +
> > > +	if (!size)
> > > +		return NULL;
> > A note for a later comment in bpf_prog_test_run_skb().
> > This function may return NULL.
> >=20
> > > +
> > > +	if (size > max_size)
> > If should be fine if the kernel unsupported bytes are zeros
> > (i.e. tailing zeros in data_in).
> > Please refer to the existing bpf_check_uarg_tail_zero() usages
> > or also CHECK_ATTR() in syscall.c. Something like this if
> > bpf_check_uarg_tail_zero() is used,
> >=20
> > 	err =3D bpf_check_uarg_tail_zero(data_in, max_size, size));
> > 	if (err)
> > 		return ERR_PTR(err);
> >=20
> Nice! Will use that instead.
>=20
> > > +		return ERR_PTR(-E2BIG);
> > > +
> > > +	data =3D kzalloc(max_size, GFP_USER);
> > > +	if (!data)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	if (copy_from_user(data, data_in, size)) {
> > > +		kfree(data);
> > > +		return ERR_PTR(-EFAULT);
> > > +	}
> > > +	return data;
> > > +}
> > > +
> > > +static int bpf_ctx_finish(const union bpf_attr *kattr,
> > > +			  union bpf_attr __user *uattr, const void *data,
> > > +			  u32 size)
> > > +{
> > > +	void __user *data_out =3D u64_to_user_ptr(kattr->test.ctx_out);
> > > +	int err =3D -EFAULT;
> > > +	u32 copy_size =3D size;
> > > +
> > data is not checked for NULL here.
> I do check kattr->test.ctx_size_out on the next line. And I've added
> checks to the syscall.c that make sure that ctx_size_out and ctx_out
> are consistent (i.e. if ctx_size_out is 0, ctx_out is NULL).
>=20
> Let me instead check kattr->test.ctx_out, that should be more clear.
Note that I meant "data" instead of "data_out".  The caller
"bpf_prog_test_run_skb()" passed in "ctx" (input) as "data" here.

I think !kattr->test.ctx_size_out and !data_out are equally good.
Your call ;)

Thanks!

[ ... ]

> > >  int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_att=
r *kattr,
> > >  			  union bpf_attr __user *uattr)
> > >  {
> > >  	bool is_l2 =3D false, is_direct_pkt_access =3D false;
> > >  	u32 size =3D kattr->test.data_size_in;
> > >  	u32 repeat =3D kattr->test.repeat;
> > > +	struct __sk_buff *ctx =3D NULL;
> > >  	u32 retval, duration;
> > >  	int hh_len =3D ETH_HLEN;
> > >  	struct sk_buff *skb;
> > > @@ -141,6 +247,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog,=
 const union bpf_attr *kattr,
> > >  	if (IS_ERR(data))
> > >  		return PTR_ERR(data);
> > > =20
> > > +	ctx =3D bpf_ctx_init(kattr, sizeof(struct __sk_buff));
> > > +	if (IS_ERR(ctx)) {
> > > +		kfree(data);
> > > +		return PTR_ERR(ctx);
> > > +	}
> > > +
> > >  	switch (prog->type) {
> > >  	case BPF_PROG_TYPE_SCHED_CLS:
> > >  	case BPF_PROG_TYPE_SCHED_ACT:
> > > @@ -158,6 +270,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, =
const union bpf_attr *kattr,
> > >  	sk =3D kzalloc(sizeof(struct sock), GFP_USER);
> > >  	if (!sk) {
> > >  		kfree(data);
> > > +		kfree(ctx);
> > >  		return -ENOMEM;
> > >  	}
> > >  	sock_net_set(sk, current->nsproxy->net_ns);
> > > @@ -166,6 +279,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, =
const union bpf_attr *kattr,
> > >  	skb =3D build_skb(data, 0);
> > >  	if (!skb) {
> > >  		kfree(data);
> > > +		kfree(ctx);
> > >  		kfree(sk);
> > >  		return -ENOMEM;
> > >  	}
> > > @@ -180,32 +294,37 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog=
, const union bpf_attr *kattr,
> > >  		__skb_push(skb, hh_len);
> > >  	if (is_direct_pkt_access)
> > >  		bpf_compute_data_pointers(skb);
> > > +	ret =3D convert___skb_to_skb(skb, ctx);
> > > +	if (ret)
> > > +		goto out;
> > >  	ret =3D bpf_test_run(prog, skb, repeat, &retval, &duration);
> > > -	if (ret) {
> > > -		kfree_skb(skb);
> > > -		kfree(sk);
> > > -		return ret;
> > > -	}
> > > +	if (ret)
> > > +		goto out;
> > >  	if (!is_l2) {
> > >  		if (skb_headroom(skb) < hh_len) {
> > >  			int nhead =3D HH_DATA_ALIGN(hh_len - skb_headroom(skb));
> > > =20
> > >  			if (pskb_expand_head(skb, nhead, 0, GFP_USER)) {
> > > -				kfree_skb(skb);
> > > -				kfree(sk);
> > > -				return -ENOMEM;
> > > +				ret =3D -ENOMEM;
> > > +				goto out;
> > >  			}
> > >  		}
> > >  		memset(__skb_push(skb, hh_len), 0, hh_len);
> > >  	}
> > > +	convert_skb_to___skb(skb, ctx);
> > > =20
> > >  	size =3D skb->len;
> > >  	/* bpf program can never convert linear skb to non-linear */
> > >  	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
> > >  		size =3D skb_headlen(skb);
> > >  	ret =3D bpf_test_finish(kattr, uattr, skb->data, size, retval, dura=
tion);
> > > +	if (!ret)
> > > +		ret =3D bpf_ctx_finish(kattr, uattr, ctx,
> > ctx is not checked for NULL in here either.
> Good catch, I didn't think about the case where ctx_in is not set,
> but ctx_out is set. Let me handle that in the v3.
>=20
> Thank you for a review!
> >=20
> > > +				     sizeof(struct __sk_buff));
> > > +out:
> > >  	kfree_skb(skb);
> > >  	kfree(sk);
> > > +	kfree(ctx);
> > >  	return ret;
> > >  }
> > > =20
> > > --=20
> > > 2.21.0.392.gf8f6787159e-goog
> > >=20
