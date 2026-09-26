Received: from out-zbxj-a75.jellyfish.systems (out-zbxj-a75.jellyfish.systems [198.54.127.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83037315D32
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790387094; cv=none; b=W123PZ9+iYsBDqKBu1311vdvkjVIHRi5C/lBj9HV30CRE37AOh1aV84V4c3FXRNbcg7r57HFRAhM6FzBwpJ1OBvOHco3OoBzpVsl9LsbVTF1RTOoQVM3thKEAdr/ivoCSo0z4qrghQcwKhAgZz3k9z4LI+b/N2FYrnhcu8IvOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790387094; c=relaxed/simple;
	bh=zQ7Db06q8qeYH7rafIP30VKwT78ouJ0Pa3J48XIAAM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CboQUGHavsglwsdMf1JET322JmHDemupkvxVuF39XzgYrnz9L/taJWy2lTPjRAdoyV+u3w+AYpdmCakXgmlo3uNsmyEp8oYQpDFMNOLR4MFyhRhom+6iUfgJsl/V0Qs5FXbS22jao5NQwQJuQuZDBuGIZArMB/y+2/8/nRRxCiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=ZrnrV/g+; arc=none smtp.client-ip=198.54.127.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="ZrnrV/g+"
Received: from 192.168.50.46 (unknown [114.92.81.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hs9NY71xbz2x9g;
	Sat, 26 Sep 2026 01:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790387074;
	bh=zQ7Db06q8qeYH7rafIP30VKwT78ouJ0Pa3J48XIAAM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrnrV/g+p7IQAlBoUfAtVM8N4Jn773cp0wynz8k9Uep+KKIxdW0J7Ywvsm6df/b3S
	 nnEh8YaSCeEJcT9dVU+Ag9VnB/2p/JV1oVrlN9wZMeI41JbUaUYCBWQnCOX5M5agI1
	 QWiHnifT0/b1JRjVFyZzE8x4sJf4w/QVDG09p/brnN2Z70LMgPfPPgknWHo/rXsm2g
	 FO5YfW/n7PNW4hs5jZbkTmBbyS7hGr+qLNgfzBAREZiDADFMqZxuscasdkYFENT0bR
	 HMS8HiTaozIz19qy/Lio8504I4p47vM13u5LvM+oLZFyIuf9m1cy5/5wwUapX443cl
	 oSoag17VS671w==
From: Tianyi Chen <hi@tychen.cc>
To: qmo@kernel.org, skokovmaksimevg@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, kuba@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Fail map dump for maps that
 can't be iterated
Date: Sat, 26 Sep 2026 10:44:28 +0900
Message-ID: <179038706871.25394.17522711126515661125@tychen.cc>
In-Reply-To: <661699fb-456c-4e68-85df-94cb829b2204@kernel.org>
References: <20260925162031.27259-1-skokovmaksimevg@gmail.com>
 <20260925162031.27259-2-skokovmaksimevg@gmail.com>
 <661699fb-456c-4e68-85df-94cb829b2204@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Envelope-From: hi@tychen.cc

Hi Quentin, Maxim,

> Tianyi, note that this conflicts with your series ("bpftool: Add
> recursive map dumping"), one of you will have to rebase.

I'll take care of rebasing the recursive dump series. I have posted v9
on current bpf-next plus Maxim's v2 patch 1/2, explicitly listed as a
prerequisite in the cover letter:
https://lore.kernel.org/r/20260926014208.24773-1-hi@tychen.cc

The conflict resolution keeps the early iteration check before recursive
plain/BTF output and retains Maxim's iteration-error reporting. All 15
recursive dump subtests pass on the combined tree. I also checked that
non-iterable ringbuf dumps fail with valid JSON, with and without recursion.

Maxim, please go ahead with your revisions; no need to rebase around my
series. I'll adjust mine if your implementation changes.

Thanks,
Tianyi
