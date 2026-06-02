Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4636AB44;
	Tue,  2 Jun 2026 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388268; cv=none; b=rJ0/1GxorDB0u08zkVDbqhw8vcPSoG564t09jxWJEy+GRlET62gA66N8wELNx6cCklwro+FQjZrVBUGFis3WIzebzbH6xTm7TkSQ0TCN9VvGKsF2wKdshqqCxYdndONHfJx0fJGvWm+jpP5amA/Z/S/+2jasGMDtM2DOhOfq5os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388268; c=relaxed/simple;
	bh=HUjE2EJJ9xrtlXuM3d+zAuScL0DoL/ceWHsHV8ziM48=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qkblbGqXiP1QqprpqgpmniWY96i6vgYR+rzyE4yRIsZYdLPJMeNFIRSKKlnLWNh7tu+08iCTx14EZK69DEa6GDfRi+SLS1B/pD4nMhbrd4jkUI3awx+Z4+CHMeFkZ6mjqAX7MsR85bBbNL5k5d8aU7mOFukZxKjLCgzce8Jgmxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cuYP3FuE; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cuYP3FuE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HUjE2EJJ9xrtlXuM3d+zAuScL0DoL/ceWHsHV8ziM48=;
	b=cuYP3FuEDvRuYRBBubkTsOQMKENYa80wEdmw8G9agsUHWXG0vqdPbzy1H2klAm5KZ6TYsy8Kz
	g2VMe51v0EccM+jpqWGV89uNj9nP958e1oY+WbP/xzoMvy/H1wNC0ajCwSj0+ikQ1PgJE8ohOt4
	J5fzHwnDIaloyzq2ZYgfk84=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gV3Qb1R4Dz1prL9;
	Tue,  2 Jun 2026 16:09:43 +0800 (CST)
Received: from kwepemr100009.china.huawei.com (unknown [7.202.195.37])
	by mail.maildlp.com (Postfix) with ESMTPS id 041FB40569;
	Tue,  2 Jun 2026 16:17:35 +0800 (CST)
Received: from kwepemr200017.china.huawei.com (7.202.195.7) by
 kwepemr100009.china.huawei.com (7.202.195.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 2 Jun 2026 16:17:34 +0800
Received: from kwepemr200017.china.huawei.com ([7.202.195.7]) by
 kwepemr200017.china.huawei.com ([7.202.195.7]) with mapi id 15.02.1544.011;
 Tue, 2 Jun 2026 16:17:34 +0800
From: "malin (R)" <malin89@huawei.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, cenxianlong
	<cenxianlong@huawei.com>, Chenzhe <chenzhe@huawei.com>, "ameryhung@gmail.com"
	<ameryhung@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>, Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, YiFei Zhu <zhuyifei@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: Tighten cgroup storage cookie checks for prog arrays
Thread-Topic: [PATCH] bpf: Tighten cgroup storage cookie checks for prog
 arrays
Thread-Index: AdzyaEITWUMNckZmikKGny/JzBZJ0Q==
Date: Tue, 2 Jun 2026 08:17:34 +0000
Message-ID: <76435d42382342899b247b87a7c1e500@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8gWW9uZ2hvbmcsDQoNCj4gQ2hhbmdlICdoaW0nIHRvICdoZXInLg0KDQpNeSBiYWQuIEFw
b2xvZ2l6ZS4NCg0KPiBJIHRoaW5rwqB5b3UgY2FuIG1lbnRpb24gdGhpcyBpbiBjb21taXQgbWVz
c2FnZS4NCg0KWWVzLCBJIGRpZCBpdCB3aXRoIHRoZSBuZXdseSBzZW50IHBhdGNoZXMsIGFsb25n
IHdpdGggc2VsZnRlc3QgY29kZQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnBmLzIwMjYwNjAy
MDczNTM5LjE1Njc4NDYtMS1tYWxpbjg5QGh1YXdlaS5jb20vVC8jdA0KDQpUaGFua3MNCkxpbg0K
DQo=
