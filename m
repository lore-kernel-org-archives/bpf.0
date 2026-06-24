Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E933DE434;
	Wed, 24 Jun 2026 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782332523; cv=none; b=JSOOuu7fZZNAc+9lnqrxyrpZQEwTMfqV+OHggsp+Q4iQg7NmNvabh3A/tVG1o1NKlUgO73YWbDArMRH9vmkL8hyNSQ2FSeBjJBs2LXKWUt2vj79X+/EBkyTSpfsVrkDxaJDASE/hfIkE6QNiYTUyH0p9T2VezR6pxxz9cwJlbPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782332523; c=relaxed/simple;
	bh=QBDgkKeBJuNW5ts/Qw40xDq2NvZ6ubirvD/nA/A4+Zc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m99g3a3pQAEB8nj+yJ+MSqGG7ukoBS80czgUVJrhiaX8C3eVb/V4sWUTR0OpsJD1yePM7IsLGmIGHESXDb06UPAr1IDOQW6DFSJ9IsgLnzRE/zRZi5CL5YIQfKyrfjLhC7Hb4SNXkOoEG0p+Oj0i9XAcqc6PdvLh39s37jEKywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7TH82xT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7TH82xT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AF41F000E9;
	Wed, 24 Jun 2026 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782332522;
	bh=rQmIUcUHUkXI9O6rbx+1F58a4h79FX041y2042hLC60=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n7TH82xT6/P+bKxRxLgIszJN7vhKOATwAUPhNxPyuIf/epninp0lrPArkG7pQwXtM
	 K3FEXNQNZA2b1uzBRp/8u5IL0krtfiAenWNVk3OZjoAYrzX57uxMZXntNy9dDZmIE2
	 Lyt/U6nRJvt8kkx0leLK2y/QNTqkqj4okFV+3KgOQq6/ApHHvNaI8GMKHhErLzOSi+
	 X+uZNL87hXONy/V2P3Gyp+XyY85BrdjI2bDw64FoU88FKJwsmHzEzXrfRDAlCeatA+
	 8Qe/eElJ12EtTC/iRrUYcVtmlIhmYaLWe566oJZj6mjEzmwwKKzA6TgjXta4ED7eBz
	 N67PeykikJUlQ==
Content-Type: multipart/mixed; boundary="===============4962084409953598579=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3f805099239376999ea04b3eb47c45ce15fa5e058949208813104649e99004d9@mail.kernel.org>
In-Reply-To: <20260625-bpf-htab-task-work-uaf-v1-1-31e711ccb159@cherr.cc>
References: <20260625-bpf-htab-task-work-uaf-v1-1-31e711ccb159@cherr.cc>
Subject: Re: [PATCH] bpf: Fix use-after-free in htab elem with bpf_task_work
From: bot+bpf-ci@kernel.org
To: me@cherr.cc,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,yatsenko@meta.com
Cc: me@ziyao.cc,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,me@cherr.cc,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 24 Jun 2026 20:22:01 +0000 (UTC)

--===============4962084409953598579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9f394e1aa2e8..19fa61909e4f 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -950,12 +951,69 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  	return -ENOENT;
>  }
>
> +/* Deferred htab_elem free for bpf_task_work maps.  cancel_and_free()
> + * returns while the task_work callback may still be accessing map_val;

this isn't a bug, but this new multi-line comment opens with text on the
same line as '/*'.  Would you prefer the kernel/bpf/ multi-line style with
'/*' on its own line, or keep it consistent with the rest of hashtab.c?  The
same question applies to the new comments in htab_map_free(),
bpf_task_work_callback(), and below in alloc_htab_elem().

[ ... ]

> @@ -1118,6 +1180,11 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
>  	}
>
>  	memcpy(l_new->key, key, key_size);
> +	/* Re-initialize special fields for recycled elements.  copy_map_value()
> + * skips btf_record fields, so a stale ERR_PTR(-EBUSY) left by
> + * bpf_task_work_cancel_and_free would persist and block new scheduling.
> + */
> +	check_and_init_map_value(&htab->map, htab_elem_value(l_new, key_size));

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28124335811
--===============4962084409953598579==--
