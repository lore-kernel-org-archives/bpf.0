Received: from mta1.migadu.com (out-54.mta1.migadu.com [95.215.58.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB43AFD07
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328222; cv=none; b=oBlyKWbV9zWJgGIieFFImoJ5zqQ5KDec1LHpEIaSjQb/ISGOq7aw/DFXXxGWu/rePx1O+pIrnJ/LH6tLiN/lOgtsFg101JcrT6hZcxbonYIiF0MwOC5vu4fL768PUhOes5P60Td+uAIF0jeuitgCRRM5w7Ey64b3zpWU+gEnxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328222; c=relaxed/simple;
	bh=JHT13dmPp/AIubZlwWDeP8eBDCBjcOjq9l+NPlQtCZw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JQLzlEb7WI7K58Q0eaAv04+Kk/KacesK6X3mBSRvDlcKNqDXL+RC73KrgTSX8lpqXGqsa0iaDN3EvglKE7yg4aTfru5iN1eZtGboiPpJiHg/HWrPhOb/9gN7pYeFliLIHnqwJM35sUljcECUppz6+cl8bYpFDlkpUaq8+075FE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s3qQlToD; arc=none smtp.client-ip=95.215.58.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s3qQlToD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JHT13dmPp/AIubZlwWDeP8eBDCBjcOjq9l+NPlQtCZw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790328216; v=1; x=1790933016;
 b=s3qQlToD/ByH68rKOY5ITX5w5SkBxDp7Qi1zEC1ue8Ld3Sv8oXRjahmrCUE38waE4wHLVRb4
 B9AjKpfpvj1wquCQ5Ra5/N6Sy1mIgvVIfYI7fdK5TehgRxJ8Fc00QWfULhn4PBgEzQYrUKoRDfZ
 TTD06PKPSpBJYervGtCdgNTY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3bb441a73f66d55f;
	Fri, 25 Sep 2026 09:23:36 +0000
X-Mizu-Trace-ID: 3bb441a73f66d55f
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 09:23:31 +0000
Message-Id: <DLOADU4BBAUV.3HU4BSEG87ZOS@linux.dev>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "KP Singh" <kpsingh@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Leon Hwang" <leon.hwang@linux.dev>, "Junseo
 Lim" <zirajs7@gmail.com>, "Sechang Lim" <rhkrqnwk98@gmail.com>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>, "Ilya
 Leoshkevich" <iii@linux.ibm.com>, "Hari Bathini" <hbathini@linux.ibm.com>,
 "Christophe Leroy" <chleroy@kernel.org>, "Naveen N Rao"
 <naveen@kernel.org>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 "Pu Lehui" <pulehui@huawei.com>, "Tiezhu Yang" <yangtiezhu@loongson.cn>,
 "Hengqi Chen" <hengqi.chen@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v3 2/3] bpf: Skip the progs of trampoline images
 that are being freed
From: "Florent Revest" <florent.revest@linux.dev>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
X-Mailer: aerc 0.17.0
References: <20260924170543.1017048-1-florent.revest@linux.dev>
 <20260924170543.1017048-3-florent.revest@linux.dev>
 <DLNZ5JQGHKP6.3TN7S6R9IFH5C@gmail.com>
In-Reply-To: <DLNZ5JQGHKP6.3TN7S6R9IFH5C@gmail.com>

On Fri Sep 25, 2026 at 12:35 AM UTC, Alexei Starovoitov wrote:
> On Thu Sep 24, 2026 at 5:05 PM UTC, Florent Revest (Anthropic) wrote:
> > call sequences, which replaces ip_after_call. Tasks that are still in a=
n
> > image that was put skip all of its progs from then on, including the
> > ones that are still attached, like they already skipped its fexit
> > progs. The call to the original function is left alone, a task that is
> > before it in the image still has to run it.
>
> So I slept on it and you were right to argue that skipping fmod_ret
> is a bad idea. bpf-ci explains it well.
>
> So let's patch only the progs that are being detached instead of all.
> Pretty much what you had in v2, but also explain why list is needed
> and why just patching previous tramp is not enough.

Ack, I will respin in v4 with a better explanation than I had in v2.

> Also see CI re: lower limit for x86.

Yes, I could reproduce it. I'll lower the limit to 36 on x86.

> Adjusting BPF_MAX_TRAMP_LINKS for large page sizes is a bigger change.
> Ignore it for now.

Alright!
