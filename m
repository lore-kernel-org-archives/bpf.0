Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09884C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 03:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1E020842
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 03:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AH1HyuaO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YhQyZBTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfBZDn1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:43:27 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50632 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbfBZDn1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Feb 2019 22:43:27 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q3elg4013583;
        Mon, 25 Feb 2019 19:43:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=CyQ7i72TWhmp5GswH4aWG4yZ4awRdF6JBU0MqiYvFHc=;
 b=AH1HyuaOQkJ80nSHka2j4RGSTDqU7f75C+FgNqSVnbIi8zer1O1mX6VwmdVMoTllR/zV
 jYmH+DzxcdQ5P4gSY+V26DR8zjirwAbMsrRWzQ/WCkOf6ISi2OubgcaJG4E9/DCefooB
 9ajRsc3xf3v7x1aWeDMdJKzYl21ePhJtCKU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvtg2rjsd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Feb 2019 19:43:02 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 25 Feb 2019 19:42:58 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 25 Feb 2019 19:42:57 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 25 Feb 2019 19:42:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyQ7i72TWhmp5GswH4aWG4yZ4awRdF6JBU0MqiYvFHc=;
 b=YhQyZBThie4/snlzeke4O/S0uSXlrvRZVXkiC5JcMG6ys1bCuzQlgi7JrqBY8DDUkesIWNAZrYdULuJYxkWCJeNZTvSdqPoRBnqPgHOvoK7LuBJ4ozr5OGHXXuKZHzhGWJBHp+GSzBA1HKsmayu9StRT6PhfywdREHWpwWNzuTU=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 03:42:55 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 03:42:55 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
CC:     Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/4] bpf: enable program stats
Thread-Topic: [PATCH v3 bpf-next 1/4] bpf: enable program stats
Thread-Index: AQHUzVl+TgA+w9+HAkOXAbBOtH+zIqXxIvCAgAAMwoCAADdagIAACPWA
Date:   Tue, 26 Feb 2019 03:42:55 +0000
Message-ID: <88de89a2-606f-471c-1556-cebddba231a1@fb.com>
References: <20190225222842.2031962-1-ast@kernel.org>
 <20190225222842.2031962-2-ast@kernel.org> <20190225230703.GB32115@mini-arch>
 <2eeb7f8d-d184-07d1-2b7b-76c93b4b1bfe@fb.com>
 <20190226031049.GD32115@mini-arch>
In-Reply-To: <20190226031049.GD32115@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:a03:114::20) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:65f5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcbf9424-903a-4b94-3b7e-08d69b9c7e14
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3384;
x-ms-traffictypediagnostic: BYAPR15MB3384:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3384;20:5NM1mWZ1igK8SjPhLv1xgJeZC72PqGjvCPcOptuqBRCHCch9feMBxDWmOyPQi2dGZ603/WI8I7x+2sOYLCn4bveDrK5zxZGpb7K2W1PRGNosNTMGMzBYFQafp/oW6hLohqRUIZr2C6ExWP78pmUy8wJHXc7nLs9SrF4vesT+Bw8=
x-microsoft-antispam-prvs: <BYAPR15MB33845B300930EDD74627BFA3D77B0@BYAPR15MB3384.namprd15.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(2906002)(5660300002)(46003)(478600001)(71200400001)(4326008)(31686004)(8676002)(2616005)(6486002)(8936002)(105586002)(71190400001)(81156014)(81166006)(68736007)(446003)(6436002)(11346002)(25786009)(229853002)(476003)(106356001)(6512007)(36756003)(6116002)(53936002)(256004)(14444005)(6916009)(305945005)(102836004)(93886005)(186003)(6246003)(86362001)(316002)(76176011)(52116002)(54906003)(14454004)(97736004)(31696002)(99286004)(53546011)(6506007)(7736002)(386003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3384;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DWSxEbG+jUBviwxN1ZE27wHhdR71j3C/MCysCyuS+SHgGqdiRQ3PokyIEeAocOQh95HYPYzIZWHcsUWQytd3IyOuTUhaNZXgIbs1gekZ3QfQ7DIcd7eMrI8t44JecMhg0kieBHvth9LsXCrRG+nMQOcOuzSol+tc7a3Bp2yPF1i/TarEBszooHfp7StC/kVzsG/fDRG92iJ8ilvATdomDIySukNWU2nCPHgEf0+W8zTkEc9F333D/s68QzS9JdlIKTAww0lq/pYDm8WnX5KsfUYy+RPMKrVpQ2jju5912hesfq14BcdXYU8tT/0oq9e4lGqhkvjiV8Vfkv37ymuNPmPS72SqaoOVqCVPEWa/6uPIUyT5g8mkv0lAGZkgSwLL+F7vmwk30fc2lUOdcTZ3JWTuJGTPfQtDhpdGMGvp7yk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72E31352D882E845933340B32D2FEFFC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbf9424-903a-4b94-3b7e-08d69b9c7e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 03:42:54.7569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3384
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMi8yNS8xOSA3OjEwIFBNLCBTdGFuaXNsYXYgRm9taWNoZXYgd3JvdGU6DQo+IE9uIDAyLzI1
LCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3JvdGU6DQo+PiBPbiAyLzI1LzE5IDM6MDcgUE0sIFN0YW5p
c2xhdiBGb21pY2hldiB3cm90ZToNCj4+Pj4gKyNkZWZpbmUgQlBGX1BST0dfUlVOKHByb2csIGN0
eCkJKHsJCQkJXA0KPj4+PiArCXUzMiByZXQ7CQkJCQkJXA0KPj4+PiArCWNhbnRfc2xlZXAoKTsJ
CQkJCQlcDQo+Pj4+ICsJaWYgKHN0YXRpY19icmFuY2hfdW5saWtlbHkoJmJwZl9zdGF0c19lbmFi
bGVkX2tleSkpIHsJXA0KPj4+PiArCQlzdHJ1Y3QgYnBmX3Byb2dfc3RhdHMgKnN0YXRzOwkJCVwN
Cj4+Pj4gKwkJdTY0IHN0YXJ0ID0gc2NoZWRfY2xvY2soKTsJCQlcDQo+Pj4gUVE6IHdoeSBzY2hl
ZF9jbG9jaygpIGFuZCBub3QsIGZvciBleGFtcGxlLCBrdGltZV9nZXRfbnMoKSB3aGljaCB3ZSBk
bw0KPj4+IGluIHRoZSBicGZfdGVzdF9ydW4oKT8gT3IgZXZlbiB3aHkgbm90IGxvY2FsX2Nsb2Nr
Pw0KPj4+IEknbSBqdXN0IHdvbmRlcmluZyB3aGF0IGtpbmcgb2YgdHJhZGUgb2ZmIHdlIGFyZSBk
b2luZyBoZXJlDQo+Pj4gcmVnYXJkaW5nIHByZWNpc2lvbiB2cyBydW4gdGltZSBjb3N0Lg0KPj4N
Cj4+DQo+PiBJJ20gbWFraW5nIHRoaXMgZGVjaXNpb24gYmFzZWQgb24gZG9jdW1lbnRhdGlvbjoN
Cj4+IERvY3VtZW50YXRpb24vdGltZXJzL3RpbWVrZWVwaW5nLnR4dA0KPj4gIkNvbXBhcmVkIHRv
IGNsb2NrIHNvdXJjZXMsIHNjaGVkX2Nsb2NrKCkgaGFzIHRvIGJlIHZlcnkgZmFzdDogaXQgaXMN
Cj4+IGNhbGxlZCBtdWNoIG1vcmUgb2Z0ZW4sIGVzcGVjaWFsbHkgYnkgdGhlIHNjaGVkdWxlci4g
SWYgeW91IGhhdmUgdG8gZG8NCj4+IHRyYWRlLW9mZnMgYmV0d2VlbiBhY2N1cmFjeSBjb21wYXJl
ZCB0byB0aGUgY2xvY2sgc291cmNlLCB5b3UgbWF5DQo+PiBzYWNyaWZpY2UgYWNjdXJhY3kgZm9y
IHNwZWVkIGluIHNjaGVkX2Nsb2NrKCkuIg0KPiBTbyBzY2hlZF9jbG9jayBpcyBmYXN0LCBidXQg
aW1wcmVjaXNlOyBhbmQga3RpbWVfZ2V0X25zIChhbmQNCj4gbG9ja19jbG9jaz8pIGFyZSBzbG93
KGVyKSwgYnV0IG1vcmUgcHJlY2lzZT8NCj4gDQo+IElmIHRoYXQncyB0aGUgY2FzZSwgd291bGQg
aXQgbWFrZSBzZW5zZSB0byB1c2UgYSBtb3JlIHByZWNpc2UNCj4gbWVhc3VyZW1lbnQ/IEkgc3Vw
cG9zZSB0aGUgQlBGIHByb2dyYW0gZXhlY3V0aW9uIHRpbWUgaXMgb24gdGhlIG9yZGVyIG9mDQo+
IG5hbm9zZWNvbmRzIGFuZCBpZiBzY2hlZF9jbG9zZSBoYXMgbXNlYyBvciB1c2VjIHJlc29sdXRp
b24sIGFsbCB3ZSBnZXQgaXMNCj4gZXNzZW50aWFsbHkgbm9pc2U/DQo+IA0KPiBJIHVuZGVyc3Rh
bmQgdGhhdCB5b3Ugd2FudCB0aGlzIGZlYXR1cmUgdG8gaGF2ZSBhbG1vc3Qgbm8gb3ZlcmhlYWQs
IGJ1dA0KPiBzaW5jZSBpdCdzIGdhdGVkIGJ5IHRoZSBzdGF0aWMga2V5LCBzaG91bGQgd2UgYWlt
IGZvciBhIGhpZ2hlciBwcmVjaXNpb24/DQo+IA0KDQpDb25zaWRlcmluZyBldmVyeXRoaW5nIEkg
YmVsaWV2ZSBzY2hlZF9jbG9jaygpIHN0cmlrZXMgdGhlIGJlc3QgdHJhZGUgb2ZmLg0K
