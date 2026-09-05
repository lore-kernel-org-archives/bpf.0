Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7373D9DBB
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788596218; cv=none; b=kqb4U+BZZC3Jin33Z29wbSDg8bZzJ4WOxBAP2x4unxek2T1tt1yRel738vOu95NPGKzWPfztUnp8rhihlhvICX8XKG1URw5pimXHMwUVakeurAZoGTjJ7hXIp6nEdqOJZCE0fXKpsClOfpQXr1EPHXr0z/Y4z9g7qaTZn6d5BuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788596218; c=relaxed/simple;
	bh=gEiuK1aM7Rdvs7OlwSBY9C5WqAcmuBlIgT7SZMh9qBM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=O7th/odaqRGt4RaVVUVwePYqiakjT/vTHGPfOAtjPbtCsQ2rR8Xf5eFz1OkyEl1/bwFcfWYfJPNpXOaURNWdlu0nhVLE4SjJxrJBNEck+A8KZVBgct/tcxsVHsAakFsSXNrDr2V8cZRm0f1akvj4WMwAeqvU0HFIIl/q28tGFys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHZQPhQy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHZQPhQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFA61F00A3D;
	Sat,  5 Sep 2026 08:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788596214;
	bh=hUT+AtmU9xFEwedqw5M26XP4e2AF4sYuHzz6REHcJjI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KHZQPhQy7wmGjVYYd09855G0x0pyy0lb1gooyG/58FFSpKfaObUvnJXzXsS+H7jJT
	 NDRTADZZ/SUEbfH0ukuQeFzD/XMUNMoR8RTAMneu/PO0PwIkoY0rlqP5KJDsPqN9sI
	 q75A/Ik6Ow3+AdLniRM5GyykMC5TA6pHr1fY+PV/SSvNL0bKKzoLYGB7/mazsUrMPg
	 W8q8vNdMvR3ZrsgR8Ne9V4KcRkLGduWWQTPQL3iOwTGyh9bU5/1XVwIJFDJ5+n98iJ
	 TuYf/3bqTzDSdweXpaLEaie4fgefMKcXoqbDiPZh1CtR7+l+FtrWX6gW4DeNQZ1lcW
	 mm8BuaaB9Ek4Q==
Content-Type: multipart/mixed; boundary="===============2150620085120200702=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f80e08bd3986dfde488a84d79b437d352a7aa94ab9e069c654858dfa4de775c5@mail.kernel.org>
In-Reply-To: <20260905070003.3193366-7-memxor@gmail.com>
References: <20260905070003.3193366-7-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 6/8] selftests/bpf: Test poisoned subprogram terminator
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 08:16:53 +0000 (UTC)

--===============2150620085120200702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> index a18d3680fb16..c350fbb95845 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c

[ ... ]

> @@ -14,6 +14,117 @@
>
>  static char log[16 * 1024];
>
> +static int load_core_relo_subprog(int btf_fd, int main_id, int sub_id,
> +				  int enum_id, int access_str_off, bool relocate)
> +{

[ ... ]

> +}
> +
> +static void test_poisoned_subprog_terminator(void)
> +{

[ ... ]

> +cleanup:
> +	if (env.verbosity > VERBOSE_NORMAL && log[0]) {
> +		printf("-------- program load log start --------\n");
> +		printf("%s", log);
> +		printf("-------- program load log end ----------\n");
> +	}

This isn't a bug, but would a small shared helper be worth it now that
there are three copies of this log-dump printf block in the file? The
same three-line sequence appears in test_bad_local_id() and also appears
for BTF load failures earlier in that function.

> +	close(prog_fd);
> +	close(btf_fd);
> +	btf__free(btf);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33952325041
--===============2150620085120200702==--
