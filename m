Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C5C1B3925;
	Sat, 15 Aug 2026 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786784562; cv=none; b=btz0ksIxOYboqF1qUwAuBb/N1pcksbRfqO/JWouxQ2HytqeiHk/5E2X2l2iYlwqCizRzS/N1nWq2Rd3EmJl5moEGZWzCcPSnlaWmPuoEVVZzS1dUURX+OWptUhfjinJzrqnaph+H/NR5HhLs5v2axdA4GVbzUkOfJ4Y4o2zmwWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786784562; c=relaxed/simple;
	bh=DMItCJDlSKiCQ/lysLU5dtPxada8u+OZHCzmkOVUK9o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BIeaGX270VYH2ny0G428Q0BQap1EM27pjT1QkHxpw8hrkrfe83IEyt1dKxeho38JgxPJaiqY5QhyHx8WWFfTntJDAPPrCNJ5RClWXBpYyWNBRCRfeg69jXRaeCmkCxY2EsfNcYIUvxrgFRlJTzErzncp6qhwmNG+EpV3vVv85zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6MEUGfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6MEUGfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBB51F000E9;
	Sat, 15 Aug 2026 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786784561;
	bh=6twb7uRV9jEpRX9PUZ4hJx0AHJaPacoL37DWck5BfAU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X6MEUGfjldOwXsCo77IpHuDag+e3g/ga++yTfs61b7DZqfQREYq8fO3xYszQkdK8X
	 5eeMuymqQsXF8Ut75hV6WfUzQGFvGvJCCv2qvGMaRBNU/VTycZTASw0hovuVZKwW4A
	 iRWbfSNvAVOm9IANqH2JAJpglPTSbO92UNnhxNMLb0lkS6FNwtebZJSbujBfgituxo
	 PhgwArs8rtkQFSsTJBKueRWTN5Hl23VfJ91iyM6wKfIIzCN/okGLnXIJOXqgRmM/yP
	 FVisv0M2TucZQulQ7UxnNHep1ImOfxz+2XV0keF51XUhaaHnaPKqOEHb7cIC8uv3kz
	 IBa+50cmcDK5w==
Content-Type: multipart/mixed; boundary="===============7793310102712997944=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <30e41d6a6f8c19fee31fb09839d9b896b590df1f585ea6976d0c77f3d065383e@mail.kernel.org>
In-Reply-To: <tencent_B9A612466A5F8D64DA61B448344B570F5905@qq.com>
References: <tencent_B9A612466A5F8D64DA61B448344B570F5905@qq.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: fix stream capacity leak in staging path
From: bot+bpf-ci@kernel.org
To: shijianlin11@foxmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,emil@etsalapatis.com,memxor@gmail.com,pulehui@huawei.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 09:02:40 +0000 (UTC)

--===============7793310102712997944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 0b157ec4e38e..ef5a7b06ffcb 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -316,17 +316,19 @@ int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...)
>  {
>  	struct bpf_bprintf_buffers *buf;
>  	va_list args;
> -	int ret;
> +	int len, ret;
>
>  	if (bpf_try_get_buffers(&buf))
>  		return -EBUSY;
>
>  	va_start(args, fmt);
> -	ret = vsnprintf(buf->buf, ARRAY_SIZE(buf->buf), fmt, args);
> +	/* Cap to the written length, excluding the trailing NUL. */
> +	len = vscnprintf(buf->buf, ARRAY_SIZE(buf->buf), fmt, args);
>  	va_end(args);
> -	ss->len += ret;
>  	/* Exclude NULL byte during push. */
> -	ret = __bpf_stream_push_str(&ss->log, buf->buf, ret);
> +	ret = __bpf_stream_push_str(&ss->log, buf->buf, len);
> +	if (!ret)
> +		ss->len += len;

This isn't a bug, but with the existing '/* Exclude NULL byte during
push. */' a couple of lines down, does the new comment above vscnprintf()
add anything, or could one of the two be dropped?

>  	bpf_put_buffers();
>  	return ret;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31874860107
--===============7793310102712997944==--
