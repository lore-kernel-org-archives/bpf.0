Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E01E4F474C;
	Tue, 22 Sep 2026 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060698; cv=none; b=auBL75oo9UJ0hF07lSHlgpfKZt2DMrqkGNW4CZPsz13G76qj9XQCw9xmeKmf+GGhNRGhq3IRI75VAiV6tk7F581LD8bL6hNZFZtiy/OeJhJW1wOWy8UDnpX4iM7qFg2x6S/0y7GP3/AkicHk+9TasPqAUw3QFtNQXR7GCBy4Ktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060698; c=relaxed/simple;
	bh=xb+ML7B/wsHqkAm4sviLlOgKiMcF/sIlhEKQe7Ac5PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bH2D4EHZXbKNQ+piRkDkxwD1Y/TBEBxjnIiENEfZbjmxSGLqRvIfSUgMqo8yscCNDSBG/NOZ9hSAf5kpkBThHhXyTNZUR1caUSfEQLRJD7rHaJaqQkcBQyhFk0lYqAXoizyzoHsEifu62Tv2S21G02NEZjPVEhBecHTwpK8e0Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h2KzUv43; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h2KzUv43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=p2
	qx/98AGIgAs9QaTEUqM74hqQUBcMVIUw0SxZmpelA=; b=h2KzUv43XphVWd8C31
	RYvVIcweZZ+W8D1oeIRU0qrUFFwcHBfNGe4yLn8hKIH5M2u24rMSHov03enZIOs7
	gttPDvG53JPkNhACL+06waViHANFlseUZdpy5AJqtIpYgjB+eMgIP2/KV0XeQiUD
	kQNJbJvfgyszeZSridMaYvBxA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBHN29UKLJqJZ4HAw--.12533S2;
	Tue, 22 Sep 2026 15:03:50 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: memxor@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	matt@bobrowski.net,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Reject bpf_skb_output() from return-side tracing
Date: Tue, 22 Sep 2026 15:03:48 +0800
Message-Id: <20260922070348.485673-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DLLHE9PBLDU0.XQGEOQQIR4HV@gmail.com>
References: <DLLHE9PBLDU0.XQGEOQQIR4HV@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBHN29UKLJqJZ4HAw--.12533S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15KryDWrWfCw4kuFy8Krg_yoW8ury7pa
	yv93WYkr4DtrW7CwsrAw4Fvr98t395Aw45GrWvy345Zws8Zr97tr48Ka1F9as8A34UC3yq
	vr4qv34DJ395AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUoOJnUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzxZm3mqyKFYL5QAA3p

On Tue, 22 Sep 2026 04:15:13 +0200, Kumar Kartikeya Dwivedi wrote:

> On Tue Sep 22, 2026 at 3:54 AM CEST, Feng Yang wrote:
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > BPF fexit programs run after the traced function returns, while their
> > context still contains the original function argument values. A traced
> > function is free to consume an skb argument before returning, so the
> > pointer seen by fexit can already be stale.
> >
> > The verifier checks that the first argument to bpf_skb_output() has the
> > BTF type of struct sk_buff, but that does not establish its lifetime.
> > bpf_skb_event_output() then dereferences skb->len and can trigger a
> > use-after-free.
> >
> > Do not expose bpf_skb_output() to tracing programs which can run after
> > the target: fexit, fexit.multi, fsession and fsession.multi. Keep it
> > available to fentry and other tracing attach types where it is already
> > supported. fsession must be rejected because the same program runs on
> > both entry and return and the verifier cannot prove that a helper call
> > is entry-only.
> >
> > Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
> > Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Closes: https://lore.kernel.org/all/9d61b891-2d52-42b9-bc1a-ad963ccb675d@std.uestc.edu.cn/
> > Signed-off-by: Yun Lu <luyun@kylinos.cn>
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > ---
> 
> Sorry, this is not an acceptable fix. This negates usage of the function in all
> fexit and fession attach points. Unless there is a simpler way to enumerate in
> which attach points this helper should be disabled, it might not be worth doing
> and leaving this be as is.
> 

Thanks for your reply. That is indeed correct.

Moreover, the comment for `bpf_skb_output` in `include/uapi/linux/bpf.h`
reads: "This helper is similar to bpf_perf_event_output() but restricted to
raw_tracepoint bpf programs.", yet this comment is actually outdated.

> pw-bot: cr

