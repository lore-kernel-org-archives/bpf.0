Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635CE2F12DA;
	Sat,  4 Jul 2026 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783165629; cv=none; b=uv1qQuIQBLOi6lUpEF5kYOpM2Vh3IMg7a417EQDJS4S3IhK5lVEp1FH5EUkhiEMbW/4p5/bgzGb2yTuF1AYW97lxQ7quBBiz0WhKXlDEe1DJo/9MYin88wsrYoQE67EZfPioY0al4yuLrC6ymEmtqbqJPAmpduBCncMjMjE9H/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783165629; c=relaxed/simple;
	bh=ghJLMa6XvB13l1eE9UbaR1aXuVDT1Q/2PE/HtQPQcJ8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gVrGnQlQYmabfz2Y8vMOiY3FbSMqdIZT4o1Mo+V+8pdaevp5VcwFqyjbIzpGVDTiwqvk2JaaHTVoHU2vlilgQxlyLKXgBiLNFUkQLmQocL4NqB7wClQfTINSp3KpC49SIj+KdToUSGnGXDUpXuDU0RC8WdM5lKTlBYxOw/u1VZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOAgwAq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOAgwAq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D72E1F000E9;
	Sat,  4 Jul 2026 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783165627;
	bh=2KuwXNX+Ur+Qa+OP5HizAZkzOvmorxqa9f9GDxbbZ/4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lOAgwAq6bGyJ4f5FqlQdSaldL2Cmeo9BQPntVw5ieDB85Ik3vQJq6t6leiAjzQRcc
	 8u58eJlw3d1ythw+BFHY0nFFs9r0HucwrmutypBtFDHb06tfvI1cOrUHkIJuzycsAa
	 hDHesxuQaV7gU7FvC8jwK7k9rRjOWEXlVj+/6PWRpb82hHCjURmUiKzMbTttPCv9m0
	 s3v9HZOMCfkLtgVb7OIxBQ/iI8soR5xg0PFS+lPfjaXOK/j060Tij8MoKVwPjeF5RY
	 RBqOKWVJAAnMOWvx5Yct6ahFbHqW+v8m6mZra/Svgcv/4z4AH3ZQGFqJGfxFOnJWTF
	 rh9eNIVvl2T8w==
Content-Type: multipart/mixed; boundary="===============8896493578805394997=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7f3e0f9992a32264f6c7cf00f2ef3ce87a0a6fbd6703084aff3de68cda77dc9c@mail.kernel.org>
In-Reply-To: <20260704111016.95816-1-malayarout91@gmail.com>
References: <20260704111016.95816-1-malayarout91@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix memory leak in msg_alloc_iov error path
From: bot+bpf-ci@kernel.org
To: malayarout91@gmail.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org
Cc: mrout@redhat.com,skhan@linuxfoundation.org,me@brighamcampbell.com,malayarout91@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,john.fastabend@gmail.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  4 Jul 2026 11:47:07 +0000 (UTC)

--===============8896493578805394997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Fix memory leak in msg_alloc_iov error path
>
>     In msg_alloc_iov(), when calloc() fails for an individual iov_base
>     allocation, the error path frees all previously allocated iov_base
>     entries but fails to free the iov array itself that was allocated
>     with calloc() at the beginning of the function. This results in a
>     memory leak of the iov array.
>
>     Add free(iov) in the unwind_iov error path to ensure proper cleanup
>     of all allocated memory.
>
>     Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
>     Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>

Is the Fixes: tag pointing at the right commit?

In 16962b2404ac ("bpf: sockmap, add selftests") the iov allocation lived
inside msg_loop(), and its out_errno error path already freed the iov
array with free(iov).  There was no msg_alloc_iov() helper and no
unwind_iov label at that point.

The leaking unwind_iov path was introduced later, when the allocation was
refactored into the new msg_alloc_iov() helper whose unwind_iov label
frees each iov_base entry but omits free(iov).  Would this be a better
match?

  Fixes: 753fb2ee0934 ("bpf: sockmap, add msg_peek tests to test_sockmap")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28704662518
--===============8896493578805394997==--
