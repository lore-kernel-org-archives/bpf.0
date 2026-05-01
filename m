Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABB440B6DF
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654750; cv=none; b=L26WcqumGqozUyMmP/NhVkBNvxENkTe5Os6Pw87wBfickpKgE71sKUKSZOKvnm6f5dXZmfqZqzohNtGPA7xGZWp4azIVrY32lRowTC3KFLvCQnZ1zFlTP6aZxD3LHYcAkJ2Ekv5fAqX/ZTifYzbgsyN0/w+7pHTxoES+kC1vq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654750; c=relaxed/simple;
	bh=QQ0Fmk+9mh9JEgWY8eIjORnk6vI3LUE6Zd6VI7fa/nc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YbPAESyaetv2M9srJBcNRSelueL5lBgKARn7ia7cu9qT+Kmc61nR1NVgtAkzytQ+Y21PGTQf8ec7iAQEEhG8oEsbVsE4SZZ2rtjyttQEpYXadzUWat0fkwS6TagXTNjg1Og7FtIwIyZ7y+/DQavZOHl9M6ThEQqBrULWYqg3Bjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF1ZWN0t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF1ZWN0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABE1C2BCC6;
	Fri,  1 May 2026 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777654750;
	bh=QQ0Fmk+9mh9JEgWY8eIjORnk6vI3LUE6Zd6VI7fa/nc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LF1ZWN0tCScpB+yPUV2Ss4PwjjfQ457KV263QPQZEDeJXxO9ks9EVh6AAGjfbBrXs
	 Sska+1fNSuzjVEhU7jHOtXgKP7duZcVWoD6KWeh40ZkWYJ5fmPygDwGe/i7zGrEe/6
	 DKF51foGSfUf2/Mf12X3XklgL8pH0lyydN+xU9MLoaq0dFpNQnNvDQBX/Z+rXls90J
	 z6kNd71+GBL0i3yZRHi7iz2O6xJFlkyZqAh6O8UdzR6+w86HSRQlPLEwsNKoQ8Hr3k
	 wazYuf4o1OjJtKQwehyOU43jnr9n8V1sfNTa66rpj13/9yv4YTSd69FOuKTHnPFOKh
	 hN3jl9ufxNbpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2 v3] bpf: Add LINK_DETACH support for perf
 link
Reply-To: sashiko@lists.linux.dev
To: "Florian Lehner" <dev@der-flo.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501160901.224134-2-dev@der-flo.net>
References: <20260501160901.224134-2-dev@der-flo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 16:59:09 +0000
Message-Id: <20260501165909.EABE1C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent execution of BPF_LINK_DETACH and BPF_OBJ_GET_INFO_BY_FD=
 (or /proc/pid/fdinfo reads) causes a NULL pointer dereference on event->pr=
og.
--

commit 738bb49794369ff2bcc7c3d461300bd57e714cf5
Author: Florian Lehner <dev@der-flo.net>

bpf: Add LINK_DETACH support for perf link

This commit implements the .detach operation for bpf_perf_link, allowing
BPF_LINK_DETACH to release the perf event without destroying the link objec=
t.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -4095,22 +4117,42 @@ static int bpf_perf_link_fill_link_info(const str=
uct bpf_link *link,
>  {
>  	struct bpf_perf_link *perf_link;
>  	const struct perf_event *event;
> +	struct file *perf_file;
> +	int ret;
> =20
>  	perf_link =3D container_of(link, struct bpf_perf_link, link);
> -	event =3D perf_get_event(perf_link->perf_file);
> -	if (IS_ERR(event))
> +
> +	mutex_lock(&bpf_perf_link_mutex);
> +	perf_file =3D perf_link->perf_file;
> +	if (perf_file)
> +		get_file(perf_file);
> +	mutex_unlock(&bpf_perf_link_mutex);
> +
> +	if (!perf_file)
> +		return 0;
> +
> +	event =3D perf_get_event(perf_file);
> +	if (IS_ERR(event)) {
> +		fput(perf_file);
>  		return PTR_ERR(event);
> +	}
> =20
>  	switch (event->prog->type) {

Can this result in a NULL pointer dereference on event->prog?

If a concurrent BPF_LINK_DETACH triggers bpf_perf_link_release(), it sets
perf_link->perf_file =3D NULL under the mutex, drops the mutex, and then ca=
lls
perf_event_free_bpf_prog(event).

If perf_event_free_bpf_prog() clears event->prog right after we drop the
mutex here but before we evaluate the switch statement, evaluating
event->prog->type could panic.

Would it be safer to use link->prog->type instead? The program reference in
link->prog is pinned for the lifetime of the link object.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501160901.2241=
34-1-dev@der-flo.net?part=3D1
