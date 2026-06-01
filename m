Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C239C649;
	Mon,  1 Jun 2026 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311382; cv=none; b=ACG4znsBgsIuSFpxOlhrbXt98ucABzoZ+8rL6xX8S0il/OE5ffveBWHYmFpO5CUD0fbWEyobLC09jvqyuVo1sRfk7/Fnr/oUxycqUxqozjEW4NI3RIYRImlLiklFVvPojnHePNck0RCdqkZNuOhiTVjOZQDeW8WfdzcSBzGCinA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311382; c=relaxed/simple;
	bh=Um6XVo3l4P451BBsz05mvtQaqiP8oKUNuT5zxR0S0Lo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eq5AGQm76iPjZhruET44uDSijGV6D+DQgA/P4ynQRp+TMnCYYvmWx+IQp76sEXw7pr7FGb3wBLY0jHoJc66GEegBcw7NiaCo3bHZwOWATFMsBmDQu5D3a4UPRv027ieQiBFr5MLYG4HtwmpvSAXZWmXK7HzSFqGwGy2mCbV+UE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=01LzoH1X; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="01LzoH1X"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Um6XVo3l4P451BBsz05mvtQaqiP8oKUNuT5zxR0S0Lo=;
	b=01LzoH1Xi2iY9DOfkV8u47aj6HwZM7kOoxuyBE8ZOqBhnOjIB+ZsOFppI/NIHPB91z0TLwxI2
	Y/HclddmGfHLSoh+9MXSwIU/8u3Ue3GCO8ixKL1RY5ltIcucXn8WgtJCygNkBcD5KnpYxDhA3Fd
	2Oufl+DVMhxH9hba1ErCBwM=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gTW066Yqwz1K97S;
	Mon,  1 Jun 2026 18:48:22 +0800 (CST)
Received: from kwepemr500009.china.huawei.com (unknown [7.202.194.214])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A4674056E;
	Mon,  1 Jun 2026 18:56:10 +0800 (CST)
Received: from kwepemr200017.china.huawei.com (7.202.195.7) by
 kwepemr500009.china.huawei.com (7.202.194.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Jun 2026 18:56:09 +0800
Received: from kwepemr200017.china.huawei.com ([7.202.195.7]) by
 kwepemr200017.china.huawei.com ([7.202.195.7]) with mapi id 15.02.1544.011;
 Mon, 1 Jun 2026 18:56:09 +0800
From: "malin (R)" <malin89@huawei.com>
To: "bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, cenxianlong
	<cenxianlong@huawei.com>, Chenzhe <chenzhe@huawei.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "memxor@gmail.com" <memxor@gmail.com>, "song@kernel.org"
	<song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "zhuyifei@google.com"
	<zhuyifei@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "martin.lau@kernel.org" <martin.lau@kernel.org>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "clm@meta.com" <clm@meta.com>,
	"ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>
Subject: RE: [PATCH] bpf: Tighten cgroup storage cookie checks for prog arrays
Thread-Topic: [PATCH] bpf: Tighten cgroup storage cookie checks for prog
 arrays
Thread-Index: Adzxs+6zer3GTaqjQC6ZP3NozKoFag==
Date: Mon, 1 Jun 2026 10:56:09 +0000
Message-ID: <5122ce58caf34720aebf4654c142abfd@huawei.com>
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

Hello everyone,

> The commit message references commit abad3d0bad72 as the incomplete fix t=
hat this patch builds upon. Should the Fixes: tag point to abad3d0bad72 rat=
her than 7d9c3427894f? The current patch removes the '|| !cookie'
> logic that was introduced in abad3d0bad72, not the original shared storag=
e feature from 7d9c3427894f.

Well it's hard to tell, because in fact these two fixes (this one) and the =
abad3d0bad72 both target on 7d9c3427894f.
The abad3d0bad72 handles A->B tail case and this patch handles A->B->C case=
s.
I cannot say this patch `fixes` the ` abad3d0bad72` but only as complement.


> This work appears to duplicate Amery Hung's patch from December 2025 (htt=
ps://lore.kernel.org/bpf/20251203195050.3215728-1-ameryhung@gmail.com/).
> That earlier patch proposed the exact same fix - removing the '!cookie'
> exception to prevent NULL pointer dereference in bpf_get_local_storage().
>=20
> Amery's patch was preceded by a review thread from July 2025 where Alexei=
 Starovoitov suggested design changes (removing the for_each_cgroup_storage=
_type_cond macro). While Daniel Borkmann addressed that feedback in v2, the=
 core logic remained and Amery's v3 submission received no maintainer respo=
nse. Pu Lehui from Huawei followed up in January 2026 asking about the stat=
us.

Sorry for missing that patch, I just searched all commits in stable and mai=
nline tree.
This patch only mentions "NULL pointer dereference" instead of the worse CV=
E-2025-38502.
We have reproduced the exploit and call for Amery's patch to be accepted AS=
AP.
(maybe add a Reported-by tag to credit us).

Regards
Lin
