Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC16C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 04:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8868A20842
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 04:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UCzqUbKN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YpKxO8pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfBZE2J (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 23:28:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53716 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbfBZE2J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Feb 2019 23:28:09 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q4QqcI006480;
        Mon, 25 Feb 2019 20:27:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kYSnHRa/JmwC4Pp8hzkZkww+RCX11LYzRCYBUae/1zU=;
 b=UCzqUbKNyDZfFobEyQhtZlLI0SrQeJHbvPWq0AvTMFr9dpho63fWAgsIySXvgF7Zn2aU
 esAnH3dx6JmYFaxMFANNBQJSOdqsxWPfei9eH6nZ2cePFak7JM9NL2UvBZEjQ6jcLRZB
 s8TA6B/KK/z0JuW2Tkpc/omttUUr5c9ako0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2qvqf0hah3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Feb 2019 20:27:44 -0800
Received: from frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 25 Feb 2019 20:27:43 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 25 Feb 2019 20:27:43 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 25 Feb 2019 20:27:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYSnHRa/JmwC4Pp8hzkZkww+RCX11LYzRCYBUae/1zU=;
 b=YpKxO8pW5JVqfDnVClUS7hUb0HRs5a8n2KpPj7qUTmJ0fCU0Lpu4s/qhjeU/UoVcQw5L4lS1mFbav3AYDGKyzkiVi6X/LHKcbBVFKZOszGGc9KoTHSZOgMvs+B5gGdnbgnpifDqfyHilrska0vW2Ypid8wq/hsV1ZEuaB+OLsdQ=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2789.namprd15.prod.outlook.com (20.179.158.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 04:27:22 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 04:27:22 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Roman Gushchin <guro@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: enable program stats
Thread-Topic: [PATCH bpf-next 1/4] bpf: enable program stats
Thread-Index: AQHUyweRwmBXsztXUkyKLmesTtiSOaXsiQ4AgAAJBgCAABl/gIADqiuAgAErUYA=
Date:   Tue, 26 Feb 2019 04:27:22 +0000
Message-ID: <24d2c526-3f9c-3101-ef60-d92777ebdcb7@fb.com>
References: <20190222233644.1487087-1-ast@kernel.org>
 <20190222233644.1487087-2-ast@kernel.org>
 <20190223003434.GA17559@tower.DHCP.thefacebook.com>
 <8de20612-c32a-9370-254d-9ebf1df78efa@iogearbox.net>
 <20190223023810.5s7zyj4zqe6poigg@ast-mbp.dhcp.thefacebook.com>
 <439aa0d4-3f31-1385-076a-bb8dab515bef@iogearbox.net>
In-Reply-To: <439aa0d4-3f31-1385-076a-bb8dab515bef@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:a03:60::16) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:65f5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f462dde-1801-4816-7418-08d69ba2b384
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2789;
x-ms-traffictypediagnostic: BYAPR15MB2789:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2789;20:4qZxFV4rO+v0o3VI/egkClQ4CYUiPHvRqEOv0zsOKf0Hv2F4H3GJGc/ZpO8RdCLwmqwLYKDFxG/uesPFckRUX111iZ64Iw1HB+PF7oLtpmFquOAhL8kT6VklcdvGE0/ImKx+csD/k30BKoWhRQwID0oBGhMO+Jc0PTLt5cCfoHc=
x-microsoft-antispam-prvs: <BYAPR15MB278915EA6C009F09E67780FCD77B0@BYAPR15MB2789.namprd15.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(229853002)(68736007)(8676002)(76176011)(52116002)(81156014)(4326008)(97736004)(2616005)(8936002)(36756003)(105586002)(476003)(106356001)(53936002)(186003)(486006)(6246003)(81166006)(46003)(316002)(446003)(11346002)(102836004)(53546011)(6506007)(386003)(6116002)(31686004)(110136005)(14444005)(7736002)(14454004)(71200400001)(71190400001)(54906003)(2906002)(6436002)(93886005)(6512007)(305945005)(86362001)(6486002)(478600001)(25786009)(99286004)(31696002)(5660300002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2789;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KG9HACIA/atQrUIuMubofiPc14zH9lqKZDhNfXqcZWyKVllLgKsiBRk/8n60vmXdVxEK+4L94cwl6xXBLU5YnlpWPbDQrNtnnXLaX1igiWcv20eMefh0KMu25GGcAj3ReLNBrhqIevhSwKrKTb3uvOgsoeSrDCATFfxut63xikRqJbhx5otb2VfEC3Hpw5m5cwW8GEJuuc/bOhpENTvwYq82Z9a0vImqvsz/99cg2c4tFvT0NWjBJTzfwCnnEc//DbUPzyab+i9zV9jrfLlB/Tdg80loYDMG6z0K7IexYeeHsBTupZ8VFTRoSiawOmGc2SFspQ/8Piw9AvtHtNy1vqzwNHWn7rtFt/dUvpkVU4QnSMGjzA7au614oi8ERX9WzwApCK0Wc0/OsXw5vCn5ApRpuboI1qAo165rl6ik51Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A55CA9D282FDB3408649617E7949BC6D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f462dde-1801-4816-7418-08d69ba2b384
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 04:27:21.3659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2789
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMi8yNS8xOSAyOjM2IEFNLCBEYW5pZWwgQm9ya21hbm4gd3JvdGU6DQo+IA0KPiBOb3QgdGhy
b3VnaCB0aGUgc3RhY2ssIGJ1dCB3YXMgbW9yZSB0aGlua2luZyBzb21ldGhpbmcgbGlrZSBsb3ct
b3ZlcmhlYWQNCj4ga3Byb2Jlcy1zdHlsZSBleHRlbnNpb24gZm9yIGEgQlBGIHByb2cgd2hlcmUg
c3VjaCBzZXF1ZW5jZSB3b3VsZCBiZSBhZGRlZA0KPiAnaW5saW5lJyBhdCBiZWdpbm5pbmcgLyBl
eGl0IG9mIEJQRiBwcm9nIGludm9jYXRpb24gd2l0aCBub3JtYWwgY3R4IGFjY2Vzcw0KPiBhbmQg
aGVscGVycyBhcyB0aGUgbmF0aXZlIHByb2dyYW0gKGUuZy4gdGltZS1zdGFtcGluZyBwbHVzIHJl
YWQvd3JpdGUgaW50bw0KPiBtYXJrIGFzIG9uZSBleGFtcGxlIHdoaWNoIGtwcm9iZXMgY291bGRu
J3QgZG8pLiBCdXQgbWlnaHQgZ28gbXVjaCBiZXlvbmQNCj4gY29udGV4dCBvZiB0aGlzIHN0YXRz
IGNvbGxlY3Rpb24uDQoNCnNlZSBiZWxvdy4NCg0KPiBUaGF0J3MgYWN0dWFsbHkgYW4gaW50ZXJl
c3RpbmcgdGhvdWdodCwgZ2l2ZW4gdGhlIG9yaWdpbmFsIHByb2ctPmJwZl9mdW5jDQo+IGlzIGEg
a25vd24gYWRkcmVzcyBhdCB0aGF0IHRpbWUsIHRoaXMgY291bGQgYmUgdGVtcGxhdGVkIHdoZXJl
IGFuIGlubmVyDQo+IGR1bW15IGJwZl9mdW5jIGNhbGwgdG8gdGhlIG5vcm1hbCBCUEYgcHJvZyBn
ZXRzIGxhdGVyIHJlcGxhY2VkIHdpdGggdGhlDQo+IGFjdHVhbCBwcm9nLT5icGZfZnVuYyBhZGRy
ZXNzIHRvIGhhdmUgbm8gaW5kaXJlY3QgY2FsbC4gVGhpcyB3b3VsZCBhbHNvDQo+IGFsbG93IHRv
IGtlZXAgdGhlIGFjdHVhbCBwcm9nLT5icGZfZnVuYyBlbnRyeSBjYWxsLXNpdGVzIHNtYWxsIGFu
ZCBzaW1wbGUuDQoNCk15IGZpcnN0IHRob3VnaHQgd2FzIHRoYXQgd2UgaW5kZWVkIGNhbiBoYXZl
IGEgdGVtcGxhdGUgb2Ygc3RhdHMNCmNvbGxlY3Rpbmcgd3JhcHBlciBpbiAudGV4dCwNCnRoZW4g
YXQgJ3N3aXRjaCBzdGF0cyBvbicgZXZlbnQgdm1hbGxvYyBleGVjIHJlZ2lvbiwgY29weSB3cmFw
cGVyIGNvZGUNCmludG8gaXQgYW5kIG1hbnVhbGx5IHBhdGNoICdjYWxsIGZvbycgeDg2IGluc24g
d2l0aCBkaXJlY3QganVtcC4NClRoYXQgaXMgc3RpbGwgcXVpdGUgaW52b2x2ZWQgZnJvbSBjb2Rp
bmcgc2lkZS4NCkl0J3Mgc2ltaWxhciB0byB3aGF0IGtwcm9iZS9mdHJhY2UgaXMgZG9pbmcsIGJ1
dCBwcm9iYWJseQ0KYW4gb3ZlcmtpbGwgZm9yIHN0YXRzIGR1ZSB0byBwb3RlbnRpYWwgc2VjdXJp
dHkNCmNvbmNlcm5zIHdpdGggbmV3IGV4ZWN1dGFibGUgY29kZS4NCkJ1dCBpdCB3b24ndCB3b3Jr
IGR1ZSB0byB0YWlsX2NhbGxzLg0KSSd2ZSBsb29rZWQgaW50byBzaW5nbGUgd3JhcHBlciBhcHBy
b2FjaCB3aXRoIGluZGlyZWN0IGNhbGwNCihiZWNhdXNlIGl0J3MgbXVjaCBlYXNlciB0aGFuIHBh
dGNoaW5nIHg4NikgYW5kIHJlYWxpemVkIGl0DQp3b24ndCB3b3JrIGZvciB0aGUgc2FtZSByZWFz
b24uDQpJbmxpbmUga3Byb2JlK2tyZXRwcm9iZSBpbnNlcnRpb24gd29uJ3Qgd29yayBlaXRoZXIu
DQpBbGwgYmVjYXVzZSB3ZSBoYXZlIHRhaWxfY2FsbHMuDQp3ZSBjYW5ub3QgaGF2ZSBleGVjdXRh
YmxlIGVwaWxvZ3VlIGluIHByb2dzLg0KdGFpbF9jYWxsIHdpbGwgam1wIGludG8gbmV4dCBwcm9n
IGFuZCBzZWNvbmQgcGFydCBvZiBzdGF0cyBjb2xsZWN0aW9uDQp3b24ndCBydW4uIEVzc2VudGlh
bGx5IG5vIGVwaWxvZ3VlIGFsbG93ZWQgdW5sZXNzIHdlIGRpc2FibGUgdGFpbF9jYWxsLg0KT3Ig
d2Ugc29tZWhvdyByZWltcGxlbWVudCB0YWlsX2NhbGxzIHNvIHRoYXQgcHJvZyByZXR1cm5zLA0K
YW4gZXBpbG9ndWUgaXMgZXhlY3V0ZWQgYW5kIHRoZW4ganVtcHMgaW50byB0aGUgbmV4dCBwcm9n
Lg0KdGFpbF9jYWxsIHR1cm5lZCBvdXQgYmUgdGhlIHdvcnN0IGNvcm5lciBjYXNlIGZlYXR1cmUg
dG8gZGVhbCB3aXRoLg0KDQpXaXRoIHN0YXRpY19rZXkgYXBwcm9hY2ggdGhlIG1haW4gcHJvZyBh
Y2NvdW50cyB0aGUgdGltZQ0Kb2YgYWxsIHByb2dzIGNhbGxlZCB2aWEgdGFpbF9jYWxsLg0KV2Ug
Y2FuIGFyZ3VlIHdoZXRoZXIgaXQncyBpZGVhbCBzZW1hbnRpY3MsIGJ1dCBsb29rcyBsaWtlDQpp
dCdzIHRoZSBvbmx5IHRoaW5nIHdlIGNhbiBkby4NCkkgZG9uJ3Qgc2VlIGEgd2F5IGhvdyB0YWls
X2NhbGxlZCBwcm9ncyBjYW4gY291bnQgdGhlaXIgb3duIHRpbWUuDQpTdGF0cyB3b3VsZCBzb21l
aG93IG5lZWQgdG8gYmUgY29tcHV0ZWQgcmlnaHQgYmVmb3JlIGp1bXBpbmcNCmludG8gbmV4dCBw
cm9nLiBXaGljaCBtZWFucyBoZWF2eSBjaGFuZ2VzIGluIGFsbCBKSVRzDQpwbHVzIGV4dHJhIHBl
cmZvcm1hbmNlIGNvc3QgYXQgcnVudGltZSwgc2luY2Ugc3VjaCBpZiAoc3RhdHNfb24pDQpjaGVj
ayBpbiB0YWlsX2NhbGwgaGFuZGxpbmcgd291bGQgaGF2ZSB0byBiZSBkb25lIGF0IHJ1bnRpbWUs
DQpzaW5jZSBKSVRlZCBjb2RlIGlzIHJlYWQtb25seSBhbmQgcmVnZW5lcmF0aW5nIHByb2dzIGR1
ZSB0byBzdGF0cw0KaXMgbm9uLXN0YXJ0ZXIuDQpPciB0YWlsLWNhbGxlZCBuZXh0IHByb2cgd291
bGQgbmVlZCB0byB1cGRhdGUgc3RhdHMgZm9yIHByZXZpb3VzDQpwcm9nLCBidXQgdGhlcmUgaXMg
bm8gcG9pbnRlciB0byAnYXV4LT5zdGF0cycgdGhlcmUuDQpTbyBpbW8gdGhhdCBpcyBkZWFkIGVu
ZC4NCnN0YXRpY19rZXkgYXBwcm9hY2ggaXMgdGhlIHNpbXBsZXN0IGJ5IGZhci4NCg==
