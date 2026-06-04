Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25C3242D97;
	Thu,  4 Jun 2026 01:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537938; cv=none; b=BZcWE7MPFEyDmMTgCSxL+A1BLo2Mhj4sq6cbpRrClp1V0IOoqTnTVkhfd6f7QLAUHpoiTGlSzhxBAd00dfKf+FEqliFOLdtoGsf8knOX9BX9GbKvMjSY0NlnVrfODEYKViZNiVhXO8VtE2aY0HafddInAgfobibgUUzK1I19OHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537938; c=relaxed/simple;
	bh=cohlC8uDN/ukpxoTnPhz2LxMcKFRncSMuHHvGxOEWVw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Wf9A4bir1BWEtCcYSbGdFbkjADW1So/yMEpLEhVb3i/ileAj6qXXe6lh9tvA6QlHHYn2hdZwisY4Bb5P1k9gSFJFJo2j9bGGbLf1MXaEit1L5IOhhKi06ZrLYoETCfhAkUS0TEmC2q1iKMPrnyJxmusoMZoT7Cm9/05Aja568Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jfOEUDtK; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jfOEUDtK"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cohlC8uDN/ukpxoTnPhz2LxMcKFRncSMuHHvGxOEWVw=;
	b=jfOEUDtK1woBx78F5fZYHP7x5GUkD9z879Pb5f9XG3bfGWIpcIZnrO5vInUYDMD+k1dk/mVWA
	hCQcq3pceiDB9bqW97Y1hdpLOoWEahHjx+xEIIajQ0v55LxspAoihE2ji8yY+Ymk3uiLrY8jC7l
	Guexl4r/Pf1ROUDFDIC9qMI=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gW6my2LsBzLls7;
	Thu,  4 Jun 2026 09:44:18 +0800 (CST)
Received: from kwepemr100005.china.huawei.com (unknown [7.202.195.187])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CAE740565;
	Thu,  4 Jun 2026 09:52:08 +0800 (CST)
Received: from kwepemr200017.china.huawei.com (7.202.195.7) by
 kwepemr100005.china.huawei.com (7.202.195.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 09:52:07 +0800
Received: from kwepemr200017.china.huawei.com ([7.202.195.7]) by
 kwepemr200017.china.huawei.com ([7.202.195.7]) with mapi id 15.02.1544.011;
 Thu, 4 Jun 2026 09:52:07 +0800
From: "malin (R)" <malin89@huawei.com>
To: Leon Hwang <leon.hwang@linux.dev>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
	<eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, YiFei Zhu <zhuyifei@google.com>, Shuah Khan
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Amery Hung <ameryhung@gmail.com>, cuirongzhen
	<cuirongzhen@huawei.com>, tanjingguo <tanjingguo@huawei.com>, cenxianlong
	<cenxianlong@huawei.com>, Chenzhe <chenzhe@huawei.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: Cover tail-call cgroup storage
 prog-array checks
Thread-Topic: [PATCH v2 2/2] selftests/bpf: Cover tail-call cgroup storage
 prog-array checks
Thread-Index: AdzzxJm9lqf8ZAVD80W1jyHgDviu2w==
Date: Thu, 4 Jun 2026 01:52:07 +0000
Message-ID: <d34847c0db934031ad40e7fcb695e5b8@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Leon,

> These new ones should stay at the tail of test_tailcalls().

My bad, just found this reply.

Will fix that in the next version.

Thanks
Lin
