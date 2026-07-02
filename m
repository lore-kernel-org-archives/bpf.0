Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5629D26B;
	Thu,  2 Jul 2026 01:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956804; cv=none; b=ik6zztkqeyGqLNHJ4r9ORbyRpxl0vsN4orGQ004iLIgtOfNgl2utodJpVPV9vi1vf3k49yX6nAagQzKvBUc6RzCNcpcr748eKapm+tDwfQ0aB8Fw5J78/o2s4yQfKQUhKTqNxVvHCBrWzyLB7YP4oCpnGpTLMlKTWYhOoC12uyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956804; c=relaxed/simple;
	bh=Fsp932BM5Tj56XIfrPkq86T3mcRIqEuR/pSVDOn8jb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WqMfqZaH1cKK+RFoGG7FT/oMVohKzpl1UYhTt0k5yW+wiwbPapZO7pswI/NJu0TbUWcVwNYqQz8JN3zxzr5F7pf1nXX3+9zdyqkgdmEwxkTYGhsSvlVGoSF2W3Eq7NImm7jo5K7esHlXXRC+vzsWDizouuR81eIKJb7UfbXEkNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: da7f36e075b711f1aa26b74ffac11d73-20260702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fb2eada6-4025-4c78-b063-eccd2930ed67,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:215430f9b86859e04e436735222961ac,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|123|850|865|898,TC:nil,C
	ontent:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: da7f36e075b711f1aa26b74ffac11d73-20260702
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1475334740; Thu, 02 Jul 2026 09:46:33 +0800
From: luoliang@kylinos.cn
To: Andrii Nakryiko <andrii@kernel.org>
Cc: KaFai Wan <kafai.wan@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: Re: [PATCH] bpftool: use btf_vlen()/btf_kind()/btf_kflag() helpers consistently
Date: Thu,  2 Jul 2026 09:46:30 +0800
Message-Id: <20260702014630.2300585-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEf4BzbeSK+-5L5LudgV0+fpRHK6fSVfwBnE3C3OE+c2vFGP3Q@mail.gmail.com>
References: <CAEf4BzbeSK+-5L5LudgV0+fpRHK6fSVfwBnE3C3OE+c2vFGP3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 1 Jul 2026 13:03:51 -0700, Andrii Nakryiko <andrii@nakryiko@gmail.com> wrote:
> this is the only line that would benefit from a tiny amount of human
> touch and judgement call, and yet...
>
> pw-bot: cr

Thanks Andrii (and KaFai for spotting this). Folded into v2, sent as a
reply to the original patch.
