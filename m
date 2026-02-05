Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE8431B10D
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269018; cv=none; b=NTRnw/KH9TjoRh4x5ARKa91OrGROXI6kwHA+yi/xYidSkz69kzWywVEeIgFQ3p1bIpc+Gp+m7pyu3bSh5a44MZJ1tlwPktr11BZK3E/wdPScfkiae17kYx57iHSeC/PIBl7E/NFWl6nfiMOelZf+hwTJdDCijTL4Z/FLF5OieZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269018; c=relaxed/simple;
	bh=d1aOwghCS+SVrYb9dbtTndq1HEIan9kcryVnARMAIKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jwkmg16gJeTKI8JIco7nm8dQktcgtwB09WIQihYN9JltolhW+qnE+6aPjo+wLzSr06NV9RsQGmypt56NASP1+H14rQqFrpF+B1YL2kfrdW/I4NW6YTBcED4aYUQF25TLB5Jj1uxAoO95OQRMzig0Evoy/GyidTCT64fxxXeqhns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=fail smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.32.2.84])
	by mtasvr (Coremail) with SMTP id _____wCXJVBDKYRpiWKCAA--.13889S3;
	Thu, 05 Feb 2026 13:23:16 +0800 (CST)
Received: from localhost.localdomain (unknown [112.32.2.84])
	by mail-app3 (Coremail) with SMTP id zS_KCgA3OWxCKYRpgxwRBg--.3405S2;
	Thu, 05 Feb 2026 13:23:15 +0800 (CST)
From: Tianci Cao <ziye@zju.edu.cn>
To: eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	shenghaoyuan0928@163.com,
	song@kernel.org,
	tangyazhou518@outlook.com,
	yonghong.song@linux.dev,
	ziye@zju.edu.cn
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for BPF_END bitwise tracking
Date: Thu,  5 Feb 2026 13:23:13 +0800
Message-Id: <20260205052313.225076-1-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e316e3675ffae5f65f70cfc25d8c5e2522c97e09.camel@gmail.com>
References: <e316e3675ffae5f65f70cfc25d8c5e2522c97e09.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgA3OWxCKYRpgxwRBg--.3405S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?/rZqywXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083r2keJFfieWsS/AIcxKcp+cJqesHuFo4GQAAK1VhX371AMRQfHId7+6o/06X+QqMmkue
	b4FmBMr79jbuJ3p8zirN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj9xXoW7Wr4xuFykXrWkuF4xJF4fZwc_yoWkZFc_ua
	48Xr1kCa1DXay7GrnxZF1rJrnrGw4jgryfGw1qgws3JryxJFn5GrWDC34kKr1fKF4UGFnF
	yFnxJ3yY9wnFvosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbTAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7xwIDUUUU

Hi Eduard,

On 2/5/26 3:58 AM, Eduard Zingerman wrote:
> Nit: Technically I did not ack this patch, just suggested the changes.
>      For such cases you should keep SOB as in the previous version,
>      or add suggested-by. Acks should only be added if someone sent
>      and email with ack itself.
>
>      Anyway, patch-set looks good to me, thank you for working on this!
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks for the review and the Ack!

I see the patch set has been merged (thanks Alexei for applying!). Apologies
for the misunderstanding regarding the tags earlier. I have noted your advice
and will follow the proper conventions in future submissions.

On a side note, we are also working on range tracking (interval analysis)
support for bswap operations. While bswap is non-monotonic and hard to
track with ranges, we found that by leveraging existing range information,
range tracking can complement bitwise tracking (tnum) to yield a more
precise combined reg state.

Given that the implementation would be more complex than the tnum approach,
we wanted to ask if the community would be interested in seeing an RFC for this?

Thanks,

Tianci

