Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69372B9A4
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770859526; cv=none; b=uBsCe6x7+S65qY+cMpj10D+EpAlelrDNGv5ACw+2gDSHcSDKXX/MN+KWPv2MlfchgkNdoETzcaDVK3TyEHFEi3bRcNqNavoay53VqVCNItW4XEOPLDGxRP8yX3KYx4lEaSec+ck2uOesTb9GbHiqPFxomQLpveS6YYEWBJCoxwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770859526; c=relaxed/simple;
	bh=o9cDOFLgsePdW5PzlEEu1Dy0gmn410INX6J86GACRgk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=V/9Io+qqpx/PQOcroDnuEj3ZWjL8VuTcLt/Saep+9Q2ehg7lvb5zBefyZ7uITnIaunFVaKslpp7621AFlCoKIjPiwdALqCsc0fPTi78rFczVACe2MiALdREo26RF9RIVBEsLXvvJq74ZCTej1eSGA2o0K8omzvEItwW7GnclSVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyC5U+3C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyC5U+3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFA4C16AAE;
	Thu, 12 Feb 2026 01:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770859525;
	bh=o9cDOFLgsePdW5PzlEEu1Dy0gmn410INX6J86GACRgk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fyC5U+3Clt7U4kldX8Z5YBqw/9h+XSfvOtpdkCBA6ORNa8VdcnKh9Gwfyo1ehO0bX
	 8GJjilkDQUQ+/ZWBeHhx94ffU+UzqinJy6qmQyf4M3R5RZ4bs3ySMDodV7YiYOZTTp
	 jIWWDywUouo5yCEz4N7KqWd3Z93nLzcFT2SAWI/pC3GWjxOJkkF0+E8LP4IUg4S7SD
	 cWTN7Ze6UYycsgAuv+u2HLVehVt0QFNT6nWeaceYflHbvjCe+F25XwzyGazKyXigzC
	 1B1FeZVSzb1xed/uMz5EHB3Hi7YNujwrJGZrr20qrQT/81WdAGanBygtNkH630RoWO
	 hH7BmhfzIp2ZQ==
Content-Type: multipart/mixed; boundary="===============4466265122321247060=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1d603d75031844115e0b15a3a8162bcf393ffd81b7a85deb2b59bd6f26199ce2@mail.kernel.org>
In-Reply-To: <20260212-veristat_prepare-v1-1-c351023fb0db@meta.com>
References: <20260212-veristat_prepare-v1-1-c351023fb0db@meta.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Introduce bpf_prog_clone()
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,ameryhung@gmail.com,puranjay@kernel.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 12 Feb 2026 01:25:25 +0000 (UTC)

--===============4466265122321247060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..b2d8277a3ef0 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +static int clone_prog_maps(struct bpf_object *obj, struct bpf_insn *insns,
> +			   size_t insns_cnt, int *temp_fds)
> +{
> +	int i, j, old_fd, new_fd, num_fds = 0;
> +
> +	for (i = 0; i < obj->nr_maps; i++) {
> +		struct bpf_map *map = &obj->maps[i];
> +
> +		if (!map_type_contains_progs(map->def.type))
> +			continue;
> +
> +		old_fd = map->fd;
> +		if (old_fd < 0)
> +			continue;
> +
> +		new_fd = bpf_map_create(map->def.type, map->name,
> +					map->def.key_size, map->def.value_size,
> +					map->def.max_entries, NULL);
> +		if (new_fd < 0)
> +			return -errno;

If bpf_map_create() fails here after successfully creating one or more maps
in previous iterations, the file descriptors stored in temp_fds[] are never
closed. Would it make sense to close temp_fds[0..num_fds-1] before returning
-errno?

> +
> +		for (j = 0; j < insns_cnt; j++) {

[ ... ]

> +		}
> +
> +		temp_fds[num_fds++] = new_fd;
> +	}
> +
> +	return num_fds;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21929204831

AI-authorship-score: low
AI-authorship-explanation: The code follows established libbpf patterns, uses domain-appropriate terminology, and lacks typical AI generation artifacts; appears to be human-authored.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: File descriptor leak in clone_prog_maps() on partial failure is a resource leak with low severity since it only occurs under unusual error conditions.

--===============4466265122321247060==--
