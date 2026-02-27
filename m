Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFF1FBEA6
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 06:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172049; cv=none; b=gi4RkdXMErt2HdNgXqjNJj88ntnKvejyk12lKZGLUirNqF7T1ROiSHKg0KnMwgwumJVARDqKufzAO7B74Wal0xj3FrPoOz4sibi/0eIaQzQcpyzomayTmMw9u0OTaC75yaRagyZiCtBwCijtaKkjdnWwRQ4hl2+OenIpGcaa6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172049; c=relaxed/simple;
	bh=pltMd68pXtspY2Upgfx3xCR6ZavyRlPO4drKidvAneo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=a/t5OEN+gDDCDflf71kbjKiKdgHNFMEs4PdzWepAPSv/F5M77Z+NTzph3xCfLxvz78Vvv8xzH/9XPqJjSSD+nz4phlbky6dSxK+ARidmEHfdXyBa1I9+9UT+0XlrbdBY+IYkW6sSHiiaxK5sodIM8XV5+LYsGTXPV6hpX1x1WRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pS8wFZ6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS8wFZ6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618BAC116C6;
	Fri, 27 Feb 2026 06:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772172048;
	bh=pltMd68pXtspY2Upgfx3xCR6ZavyRlPO4drKidvAneo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pS8wFZ6zOTM7TeRW41tS0tdrfykxlFXuWoxJMgY5dyCLoRDU8/no0bH5xRfvHGH+g
	 9DU4fmHXi4jBItDlsxjakt8489UmBy7Uxkky92id6Ogb6xBpa0nXieqpr8ARoAsv6T
	 JHzyyCI9/b+AFa/3M3V53KKLmZLdzMCLv6Rtfk9j+V38pSxgKazPHK3GhWW4MmGleG
	 EEBylHSLq8ZP8lzU5Qpgo3mV17aiNCtSJr7T7LS5HOM1mf5HnYNxM33hXvGb5fF2vB
	 JkoP06lq8ySh67sypBGBi0kHp5M81SKEHq3TlD//SVUhZRK1VYB3/GofFW+RnXBu0c
	 N+bcJNtnpM4sQ==
Content-Type: multipart/mixed; boundary="===============6356370650837337377=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b723f5e88ced0c432994c551869d190173f9549849f347039aadd1d405150aa2@mail.kernel.org>
In-Reply-To: <20260227052031.3988575-4-memxor@gmail.com>
References: <20260227052031.3988575-4-memxor@gmail.com>
Subject: Re: [PATCH bpf v2 3/5] bpf: Delay freeing fields in local storage
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yatsenko@meta.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 27 Feb 2026 06:00:47 +0000 (UTC)

--===============6356370650837337377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -164,16 +164,25 @@ static void bpf_local_storage_free(struct bpf_local_storage *local_storage,

[ ... ]

> +/* rcu callback for use_kmalloc_nolock == false */
> +static void __bpf_selem_free_rcu(struct rcu_head *rcu)
> +{
> +	struct bpf_local_storage_elem *selem;
> +
> +	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> +	/* bpf_selem_unlink_nofail may have already cleared smap and freed fields. */
> +	if (SDATA(selem)->smap)
> +		bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem)->data);
> +	kfree(selem);
> +}

The smap field is declared as __rcu in struct bpf_local_storage_data:

    struct bpf_local_storage_map __rcu *smap;

Here it is read directly twice without rcu_dereference_check,
once for the NULL check and once for the ->map.record access.

The sibling function bpf_selem_free_rcu() in the same file
handles this with a local variable and the proper accessor:

    smap = rcu_dereference_check(SDATA(selem)->smap, 1);
    if (smap) {
            ...
            bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
            ...
    }

Should __bpf_selem_free_rcu() follow the same pattern for
consistency and to avoid sparse warnings?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22474216888

AI-authorship-score: low
AI-authorship-explanation: Deep domain-specific BPF local storage and RCU chaining knowledge, tightly integrated with existing subsystem patterns, characteristic of a domain expert.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Inconsistent access of __rcu-annotated pointer without rcu_dereference_check and double read instead of local variable, will trigger sparse warnings but is not a correctness bug.

--===============6356370650837337377==--
