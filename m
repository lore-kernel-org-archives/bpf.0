Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C151432E81;
	Tue, 21 Jul 2026 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620311; cv=none; b=HLESpKeCWYgzkPX9d74AAWIgGwjc8MbpBUeqaf4vTMoEom16ZAx+a7GNuI63+IGK3erMZI0Uo5jgk6EjGykj0SVV3wlI9F0wzRrGZijSiQcEnal6e0mydeJbsBIOx7v/9Lwntjnsjnih3vecbC4qS2ty2qXaa2Q3OyQUZ77Mkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620311; c=relaxed/simple;
	bh=Wb2fFTi8+Zj91Iz38Ywph0bejrolCdCFBaMmt+Ihn6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BLae/R6099Q5rgOJ6d9O/ZpLP6ns/sjh5FV3dXkWXs12v6GmaWQOYsW+Qan097uAh1Zi+Ww/xPaaS0m74z5wJDtSYM5t7U1qLeHo9kjkX95q8nAr6oaZpjNsKjJ7xfhrBZ1Z5EsBTi04MEGxPKX2tZvpqiZByQcN6gR1nME90Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Zn6TboQf; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Zn6TboQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Wb2fFTi8+Zj91Iz38Ywph0bejrolCdCFBa
	Mmt+Ihn6Q=; b=Zn6TboQfDzpGE0FRl1lN/z3n0BTMqyaaAl69sda7N3I+Sdryaa
	oeWjNN5ILBSv4N32oomlLUMEnrUlRjYvTqeTI3gf2V0HbljwA+S1LAWao4TbTDpW
	37GI/HY3HO5bZ+AUr6qIyq8ie540bd+1uJmSq5zBWYAkzzAv7nLcC4/UQ=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQD3xRT0JF9qlKwfAA--.46135S2;
	Tue, 21 Jul 2026 15:51:25 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyy23@mails.tsinghua.edu.cn,
	daniel@iogearbox.net,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 1/2] bpf: Preserve stack frame number for commuted arithmetic
Date: Tue, 21 Jul 2026 07:51:08 +0000
Message-Id: <20260721075108.2889436-1-chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a469d5344126d38b5151b9bd044ce83320875517.camel@gmail.com>
References: <a469d5344126d38b5151b9bd044ce83320875517.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQD3xRT0JF9qlKwfAA--.46135S2
X-Coremail-Antispam: 1UD129KBjvdXoWrXFyxGrWUGryxtw1ftrWDurg_yoWxXFX_Xa
	95K398G34kuF4qvF13AF47XrWkGrySgr1fA34jqr42k397Xr45WrnYvryUWw1xG34FqrWD
	Cr1fKF4rWr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbD8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvQ6LUUUUU
	=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Hi Eduard,

Totally agree.

I'll respin v2 to preserve the full pointer state instead of copying only selected fields, and use a temporary scalar offset register for the commuted `scalar += pointer` case as you suggested.

I also re-checked the history before adding the `Fixes:` tag. The tightest candidate I found is:

`Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")`

That commit introduced the unified `scalar += pointer` handling and the pointer-state inheritance path. `f4d7e40a5b15` added the multi-frame stack model later, so it is related but less precise as a `Fixes:` target.

Will send v2 soon.

Thanks!

