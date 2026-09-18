Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CCF4E4305;
	Fri, 18 Sep 2026 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730821; cv=none; b=gK01sRng5xdc8j7opkUZuBh0ah+resVG6q/ExBZ8235h55RR8UbD4u4V1YA/0sEieoCQQD3koGkltf96uvC8p9aBz9dKVifqy3IUyvKm0y43HRFgGe857y9g8RA31fvsetc8jAw+xj1UpVMZESWzzJoEPc4MN65Hp9jOufrxxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730821; c=relaxed/simple;
	bh=TdQGxkuEdE7R1M0nj31f1yB0sOxZGBoP6ChU17jobdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e42gnh6vo0ShSHQ43Stv+sGAupeb4WlAuw/7kyco23w8D6OxXztZ8mCzAGN80iHdftlhk0eMXe5FL9a3ZdsFRUe/I6jw8wX4jKtxhTkZLtZU0HJMcHgRz5nKN+C/3YSkGd0PIcnWGnjN3QZmmnpjDVarB/IE60jQVkhXKQ1uEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lchtrgx2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lchtrgx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C271F000FF;
	Fri, 18 Sep 2026 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789730809;
	bh=rx9ZWGMxfrcUwXFlr3gvg3Bgz+hJZVKZ/ma27fs/PfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Lchtrgx2zGQu2lYHfr6gssXLzk+UGIkGA2xRX5CF92vxPcOZiLPxZEEO1aYDkjvmQ
	 kZx4Z0P8jhYpPXM12qu6XongV6EeyIKzT+TLoCnlRy324Hrh5qdPLZh3J0rc7cwwTJ
	 0I63OEZIcsmoiy7ROdmITd4rZ60LG59cYaSQCi7TZYew21OqvxsnyKdJVdFmWtm6RQ
	 bDUgxeJ/TWVzhYlPHTPhxtfSZ5kxH3NksxJdBc3tem+xGrDuEqnJgb0+3f3yZo1PWn
	 XJSo0rFirDqOyA283iWjl+q80O78FcN0pQyhAZFLxAm8oiSYsj6+/fNidHU5Sl+YzI
	 IjxsAB5FcFRqQ==
Message-ID: <0693be81-8d89-4a18-9964-5f2c0ad62327@kernel.org>
Date: Fri, 18 Sep 2026 12:26:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 0/2] bpftool: Fix sparse CPU IDs
To: Hui Su <sh_def@163.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org
References: <20260918102052.1247819-1-sh_def@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260918102052.1247819-1-sh_def@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-18 19:20 UTC+0900 ~ Hui Su <sh_def@163.com>
> bpftool currently assumes that possible CPU IDs are dense.  This is not true
> when the possible CPU mask itself is sparse, such as 0,2-3.  In that case,
> per-CPU map output labels and prog profile event-array keys can refer to the
> wrong logical CPUs.
> 
> The first patch keeps dense per-CPU buffer slots separate from logical CPU
> IDs when printing map values, and propagates errors from the shared output
> path to its callers.
> 
> The second patch applies the same distinction to prog profile: userspace
> keeps a compact CPU count for result buffers, while BPF event-array keys use
> the logical CPU ID and the logical ID span.

Looks good to me, thank you!

Acked-by: Quentin Monnet <qmo@kernel.org>
