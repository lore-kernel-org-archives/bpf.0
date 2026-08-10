Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523693BE635;
	Mon, 10 Aug 2026 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359599; cv=none; b=UztvbLg/GXH49VvMVBaIaRyiTHihy136snVx3QaBclr3fSkineNLrFHtyrDbTr5/CSJXyLpSXbg7AVctZXHIEVG6moSc2VwcMrPEc3gNJDkf5YUShTr451JAWOj0vLUbQ9sb+h9Xv9ieMAumZoDwuzuHENhi+xnlYY6R3lnnELo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359599; c=relaxed/simple;
	bh=+Iw+4bBO89J717mHlLJrUBhcauF8tf+xg543RsB5zCM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RUR2qKPIQwhrOWtYpSglc4uvfN0kJg7ueAq3Jijbp6aNQMuI+81oI/FX30mXXRNkf52dJPTlh1gdjgxWJpMJhpS8CPcIecNfHX/ltHgI0wQ4unfHRPmjhMmJT+emEjnqLR5p8n68Vk6jC4cdUqKNOvXnyIpTCR4GqqbBikjWpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6F1QME/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6F1QME/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539CB1F000E9;
	Mon, 10 Aug 2026 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359598;
	bh=xbM4gbSuwjsjG8vSc+BkwQbh/PMhRDiuJXMRdJz0ihQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=C6F1QME/Y6zr/NrgKC9Bk2ScxXsksvvem5W6rAcxZ2dsJkVuYY2seNs2fiVwn8NyC
	 pS6Ar4bgew9/KcdoG1kFweoC2yqgRKJGzaO33OLf0/TSX3ZsTBPq0H1i7mJuiEZ3hU
	 PQxB6NTsD5ji7K2/7oZoU8mrSv5lTynfHo+8blfajfZX/VBMUYK63uKnakJ5CxV8IU
	 1LoYvHLdhprKlVNNKYRpYUqlUN4GynIV4PyFJmgumG2yE4kp5/J32YsaHQrmrneg4/
	 dj09HKrlSZcve8P5K4MYbt2IjcsmCG9E8l5NaZwKeeQlp9qFi8wUgi6K5/3kauZNOE
	 fluXPq0ThgdCg==
Content-Type: multipart/mixed; boundary="===============1316979623471997190=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8b97ada9d7f542fd0c548520e60a114194879159e5ac8ef0cca2b8c367b2f323@mail.kernel.org>
In-Reply-To: <20260810094634.2723213-4-chenyuan_fl@163.com>
References: <20260810094634.2723213-4-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf, arena: check range_tree_set return in arena_free_pages and arena_free_worker
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 10:59:57 +0000 (UTC)

--===============1316979623471997190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit bfa5738a7c316a45ba16a067c92606ef3610c0b9
> Author: Yuan Chen <chenyuan@kylinos.cn>
> Date:   Mon Aug 10 17:46:34 2026 +0800
>
>     bpf, arena: check range_tree_set return in arena_free_pages and arena_free_worker
>
>     arena_free_pages() and arena_free_worker() now handle range_tree_set()
>     errors. arena_free_pages() aborts the free on error, and
>     arena_free_worker() moves range_tree_set() before PTE clearing so that a
>     failed tree update leaves the PTEs intact instead of freeing pages that
>     the arena free tree does not track.
>
>     Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

This commit fixes missing error handling for range_tree_set() that can
lead to memory tracking inconsistencies. Should this include a Fixes: tag
pointing to the original commit that introduced bpf_arena?

  Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31377360587
--===============1316979623471997190==--
