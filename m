Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13186279DCA;
	Tue,  2 Jun 2026 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365109; cv=none; b=ZgNEQRQ1lLOa4S4CapJ1JW4laxo/Hltq6fL+fiemEXXbtpqZZ/ZJ8muKBJiHErkgJ7AceO9E/Mbyr4UJkq211ISvgwTbEAah5Vjz5MsnDWd4uqJ9j/MXVaR8aLxgt5eeUKsQ4D+l8gdxkobqYY2TVy5SKcKKMrM/GvyPzsf5VBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365109; c=relaxed/simple;
	bh=Fuwb7dS399pT2zohNJ73HQ9tcHNEWOUk56Y7PbGc9TM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h4jXjTwGLYw52Tto4GyR3+ProqUpzSutJAZwVM2fduVp0G/3SmUovUyED0kH4IphUpmLp2Ho8ouQjiOKUO2g5H8iERBRyUk0TRUcTOcZSEry4AR/s4au6ivrQEdXlbh7ISY7nbLz8tLygh9qdJJ+XjreUXAM4GkZCX9lW2TGKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=y2Atywkn; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="y2Atywkn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Fuwb7dS399pT2zohNJ73HQ9tcHNEWOUk56Y7PbGc9TM=;
	b=y2AtywknaptblnA2lx8aCWrlTUObJiqOEb7v73I8FSKigUYcGFQnwBQf/QLcmTTve2vivJ3RO
	gT+eCGS60Fn9vCQj6XxtijYVI5lQJjiWXzAc6ocKr9coYeF/FUFl3Ivr2R4ouXqsAwXtTlXbSg1
	vUzjhBkGLeSgCaMke8pV4v4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gTtsH62X8z12LJH;
	Tue,  2 Jun 2026 09:43:47 +0800 (CST)
Received: from kwepemr200009.china.huawei.com (unknown [7.202.195.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C1B84056D;
	Tue,  2 Jun 2026 09:51:44 +0800 (CST)
Received: from kwepemr200017.china.huawei.com (7.202.195.7) by
 kwepemr200009.china.huawei.com (7.202.195.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 09:51:43 +0800
Received: from kwepemr200017.china.huawei.com ([7.202.195.7]) by
 kwepemr200017.china.huawei.com ([7.202.195.7]) with mapi id 15.02.1544.011;
 Tue, 2 Jun 2026 09:51:41 +0800
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
Thread-Index: AdzyMdwuWUMNckZmikKGny/JzBZJ0Q==
Date: Tue, 2 Jun 2026 01:51:40 +0000
Message-ID: <b160365f172b48f395e7edb7e1f879b9@huawei.com>
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

SGVsbG8gWW9uZ2hvbmcsDQoNCj4gVGhlIHBhdGNoIGxvb2tzIG9rYXkgdG8gbWUuIEJ1dCBjYW4g
eW91IGFkZCBhIHNlbGZ0ZXN0IGZvciB0aGlzPw0KDQpPSywgd2Ugd2lsbCBzZW5kIHYyIHBhdGNo
IHdpdGggYWRkZWQgc2VsZnRlc3QuDQoNCkJ5IHRoZSB3YXksIGFzIHRoZSBBSSByZXZpZXcgYm90
IGZvdW5kLCB0aGlzIHBhdGNoIGlkZWEgaXMgYWxyZWFkeSBwcm9wb3NlZCBieSBBbWVyeS4NCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi8yMDI1MTIwMzE5NTA1MC4zMjE1NzI4LTEtYW1lcnlo
dW5nQGdtYWlsLmNvbS8NCg0KU2hvdWxkIEkgYWRkIHNvbWV0aGluZyBsaWtlIFN1Z2dlc3RlZC1i
eSBmb3IgaGltIG9yIHNvbWV0aGluZyBlbHNlPw0KDQpUaGFua3MNCkxpbg0K
