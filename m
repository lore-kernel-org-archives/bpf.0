Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B592C10F11
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 00:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B51020685
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 00:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EzV779A1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aB2iauC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfDWAHT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 20:07:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48374 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729892AbfDWAHT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Apr 2019 20:07:19 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3N01a8S017182;
        Mon, 22 Apr 2019 17:06:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+bMRG/1ctxmmA4IOdY/wwa2tWQzN5KFohUL/KXgRMjY=;
 b=EzV779A1vTn2sBgYJd/GqRPRHB8JyWELcsRUH8yPbTH5aIIYBaSElooSieAVlcC4UYhq
 ubRKxP5Fd+hOJ8/56c28ObltX41oamspWp++oLrGY4BMVjBc8Q82YMqXP1QVKXndkytt
 ZVnXyJXzDWxJJ0kjK02uCKna9igmSuoON+c= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2s1p0f8ec4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 17:06:58 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 17:06:57 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 17:06:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bMRG/1ctxmmA4IOdY/wwa2tWQzN5KFohUL/KXgRMjY=;
 b=aB2iauC/1hMqJej0zxyK2dzDu/l4FroJplO7Bd4/N21TGxADQykwtuJ0AXMa0H4/ZwppCqS4wzBDJTTjI668LTB9OGI+im1UbH8EuphAAS0RT0ZSUEG97Lgxx7615u6/9Bma5qUYr7LTAXtVeqbiuuIO5OkiEHAnPdXc4O1k/3A=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Tue, 23 Apr 2019 00:06:55 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::919e:882a:d660:3f4c]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::919e:882a:d660:3f4c%6]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 00:06:55 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: parallel verification
Thread-Topic: [PATCH bpf-next 0/2] bpf: parallel verification
Thread-Index: AQHU9r6N2pdkPEcxgkmSzqczfPxZOaZI4PuAgAACboA=
Date:   Tue, 23 Apr 2019 00:06:55 +0000
Message-ID: <28461404-f098-ef19-70c1-9ed1ac4ce449@fb.com>
References: <20190419144455.853134-1-ast@kernel.org>
 <a58562b8-4501-d976-29b7-aec15475afe5@iogearbox.net>
In-Reply-To: <a58562b8-4501-d976-29b7-aec15475afe5@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0025.prod.exchangelabs.com (2603:10b6:300:101::11)
 To BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:442]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18533738-9cfc-439d-dff0-08d6c77f9821
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3029;
x-ms-traffictypediagnostic: BYAPR15MB3029:
x-microsoft-antispam-prvs: <BYAPR15MB3029D881CF2EC5CACC2298B9D7230@BYAPR15MB3029.namprd15.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(366004)(136003)(376002)(52314003)(199004)(189003)(66556008)(66476007)(478600001)(64756008)(66446008)(8676002)(73956011)(36756003)(5660300002)(66946007)(14454004)(81156014)(68736007)(4744005)(8936002)(81166006)(86362001)(15650500001)(71200400001)(71190400001)(31696002)(2501003)(6116002)(2906002)(476003)(6512007)(31686004)(14444005)(256004)(53936002)(446003)(4326008)(53546011)(386003)(11346002)(6506007)(2616005)(6246003)(316002)(110136005)(76176011)(54906003)(99286004)(486006)(6436002)(6486002)(229853002)(97736004)(186003)(46003)(52116002)(102836004)(25786009)(7736002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3029;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9wZ0XCC3egyKkvIIBv0RqFJBVU/LujnH/rZFqyrI1FXza3C9iyumj6Z2PiIX9ZjPBXyKraXmkh5HYnst2HNkU6glbjweYeXr3duBPGPuH0l5tFULtOgkAUxLMm1LUXCLOfxTn17h+jQx3wRmzDnwrqsWnyl2oZdszq9j0USUaDJqcFOHRd2UdAi+/+1nwJwrlaOF6rG3y50hwQFkFale96uxIurAximvwg9e8QmkE3JGQZvjgETE5WV4gQyfzESh0LfTJEPXNvWi4MV9Ual2AzqB8yUOI7345kMzCEWb8P04zUZc5eP1qfrskBZhwkzS8D7XLbPSItfOl1cso7M6/ep46cnJzeCwNuB4WfTgq34FJtwe0dDGu8Koh0e1uokseCncW2BSb/raMW1mcc3pTqSD36d344ZO4Qo5A+0md2k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F6ECDB39EEDFF429D8266B7EC34AFB3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 18533738-9cfc-439d-dff0-08d6c77f9821
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 00:06:55.5691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3029
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gNC8yMi8xOSA0OjU4IFBNLCBEYW5pZWwgQm9ya21hbm4gd3JvdGU6DQo+IE9uIDA0LzE5LzIw
MTkgMDQ6NDQgUE0sIEFsZXhlaSBTdGFyb3ZvaXRvdiB3cm90ZToNCj4+IEFsbG93IHRoZSBicGYg
dmVyaWZpZXIgdG8gcnVuIGluIHBhcmFsbGVsIGZvciByb290Lg0KPj4NCj4+IEFsZXhlaSBTdGFy
b3ZvaXRvdiAoMik6DQo+PiAgICBicGY6IHJlbW92ZSBnbG9iYWwgdmFyaWFibGVzDQo+PiAgICBi
cGY6IGRyb3AgYnBmX3ZlcmlmaWVyX2xvY2sNCj4+DQo+PiAgIGluY2x1ZGUvbGludXgvYnBmX3Zl
cmlmaWVyLmggfCAgNSArKysrKw0KPj4gICBrZXJuZWwvYnBmL3ZlcmlmaWVyLmMgICAgICAgIHwg
MzMgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+Pg0KPiANCj4gVG9vIGJhZCB3
ZSBzdGlsbCBuZWVkIHRvIGtlZXAgaXQgYXJvdW5kIGZvciB1bnByaXYuIEFueXdheSwgYXBwbGll
ZCwgdGhhbmtzIQ0KDQpJJ20gcGxhbmluZyB0byBhZGQgbWVtY2cgYWNjb3VudGluZyBhbmQgdGVh
Y2ggb29tX2JhZG5lc3MNCmFib3V0IHRoZSBtZW1vcnkgdXNlZCBkdXJpbmcgdmVyaWZpY2F0aW9u
LiBUaGVuIHdlIGNhbiBkcm9wDQp0aGUgbXV0ZXggZm9yIHVucHJpdiBhcyB3ZWxsLg0K
