Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90512E63C;
	Sat, 23 May 2026 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779564035; cv=none; b=NrEpEZe06ttRJ30tY5IEag4VPtP7O7kG4pJZ0dtI0wou68c9rdd9X9LO1TMoiEmg0n1U0vw32k/CnVPwn7XLUFBzhTh3Bnss5JWVEbGEwEi6G3EBStNIfTL8VjznFAEA9UX8xfWRILvajHP1mP2UVZoYVk220YzT5fdL4rS6RXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779564035; c=relaxed/simple;
	bh=L5wijmXiW6AEupe1xQBJEFZgUgfFFRvGFSxfq55Sid0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dgKNwG8TKFqhJ/Ugu+0uauASwS/RMjq8v8rHKhOTKBcmmLtDZPb35CX1HoqGhYTAkeo+bvwm4HmT6BGsNyj+GZEgSG/hFIr3cjuWoMOhsBhuntxADpWQJuMGqJv07hgAHQGHUb08eyUZdWiblT6qcuakH+JEAyXaiMdz6BD3NB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hn3DjKCa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn3DjKCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399501F000E9;
	Sat, 23 May 2026 19:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779564034;
	bh=RFgoPUnzYG3oVGx9TixcDLafMi4cDJnuWYqgJMh9cDM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hn3DjKCa/8Z2SIPcZ5S7W3oj1a9kbijqgdm9h8T5sCedGogdLHT2a4lyuYQIKrPwJ
	 iXMa4zOarmEvV67oZqye/0xLF8AfP8KkdtV9UlMo2YE9uZz+M12pML61CIOB5cb7Su
	 AwE9BJypYVfN9FkorfUUP+4ZW6ALLz1elJIckV57mWc/kpqNc6DBmTWQUA3Cprh9Gs
	 Mp6FmGF7QNpO2GrlM6NDelmmcGrO0h5bDk3LDjtxR/srOqyuSKvpBmHtjHsSBVt4zS
	 s+U9k9dIz3UodDgTbVKvhRIpjYjmPX/PrKsK9IO6HFmN+krwfuXMBq2C/WCASFH85U
	 OLQo/6y3giHGg==
Content-Type: multipart/mixed; boundary="===============3388178999859968608=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6d68aa2d0611358e17f9c5a01f8b27a1ad0a420a8205c4a4ffded3a15eb92a03@mail.kernel.org>
In-Reply-To: <20260523183422.124105-1-suchitkarunakaran@gmail.com>
References: <20260523183422.124105-1-suchitkarunakaran@gmail.com>
Subject: Re: [PATCH] bpf: replace pop/push emptiness check with bpf_list_empty()
From: bot+bpf-ci@kernel.org
To: suchitkarunakaran@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,shuah@kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,suchitkarunakaran@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 23 May 2026 19:20:34 +0000 (UTC)

--===============3388178999859968608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> index 1a3233a275c7..3b05ac1d7c77 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> @@ -197,17 +197,13 @@ static bool
>  fq_flows_is_empty(struct bpf_list_head *head, struct bpf_spin_lock *lock)
>  {
>  	struct bpf_list_node *node;
                              ^^^^

The variable 'node' is no longer used after removing the pop/push logic.
Will this trigger an unused-variable compiler warning and break the selftests
build?

>  +	bool empty;
>
>  	bpf_spin_lock(lock);
> -	node = bpf_list_pop_front(head);
> -	if (node) {
> -		bpf_list_push_front(head, node);
> -		bpf_spin_unlock(lock);
> -		return false;
> -	}
> +	empty = bpf_list_empty(head);
>  	bpf_spin_unlock(lock);
>
> -	return true;
> +	return empty;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26340856238
--===============3388178999859968608==--
