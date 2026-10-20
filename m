Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505826;
	b=mnJXxMhkhdx5OcQB7P/CfzjNahTomirB8rwmDkugqBPIm4pUScFpEFz6fMothkfjuTRl
	 6TNgGt3q9TvQi1tv+qR1BVfVkVx5A+7Sz7gizxEiws6QdDJnSOXutD1RPKJDEuV00wSOe
	 hfQb/UFX97++qnF47m5XTX8LbBbKSxg04aJy+rVrL7hVriuBZMLg+BpnRXo61vMpIPGsD
	 DoEft49DoSn47IPnFTd+j8XfHhxF7CdaeQfibo27KQxhWZW7gpj4nlBnEq4H9F0AZ+GK0
	 armJmIEJWA+Bt32hrzspjgMd6WTK9V+4GHS8fbY3XiZLPpViGYT4GFKn0FrLB5/dXWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505826;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Z6AN2h+UoVg9iDJypz0pTaruJDGBnqJ+VugjyNl2o3U=;
	b=lfExI72N+O2csTBGG6CPXPrpGl25vOHRzEjIpnUPqzuM60vHRRS74f+whwndKoRM4+CI
	 iYMBQSwdkp6K98PlfQgDuD/kDnQ3lpdis0UKCIqgy30FxKpFFM+B2ZUkAxiXAumle0SjY
	 lO346//VV+ywOnT9ovIL1oEmb9yFNnrU1zjgIporih76jv3lh9u7aJo9AmdShIRI7VlHa
	 ZVPZ8ulTbsda19PkJfzgNSJTrdBrat+8G7EIu7j4Yf1rBrF/A1CTSwvv1HmcOES/x93lM
	 NW1ig6NadXtM5neaWbmQTSCnCW96umdZNUvFth+zMOgsfIvK0239fvyqT38tuJTaJTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REg2J+6a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A92606AA19;
	Tue, 20 Oct 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REg2J+6a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8EE1F000C6;
	Tue, 20 Oct 2026 14:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505826;
	bh=Z6AN2h+UoVg9iDJypz0pTaruJDGBnqJ+VugjyNl2o3U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=REg2J+6aE+m/Mx9DxhQBSj2WYcWVpAVGKk7FC3b/7If6ddd4DDawP1uqRMDEq92aT
	 CDp8UWUTO0LxCz3jgFQx/w7oWTfGnRech4otenTnGXm4HsSla51iFHOdnkm1YEduju
	 qoZMQnx4WmMojdm5nSZnrEr7521b7XLvjIewGHj2kBUJGDHavJ0nxzK+xrOJICgJBs
	 kWLmoxNMx6c/5GlRO+N0ab+KH708QHM8J7Br4hP+n5cdrhCgdMsm8gjhryrkq7m2Gp
	 Xtb0eRyx55Eviq35eZ3RZ/dULGeX7XAfLeG6lnJOYGf8wKNGvj0aPABN/jlbz5euE5
	 mTNBNXNF75ENQ==
Content-Type: multipart/mixed; boundary="===============1030206949800535023=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <dfe1cca60761dd13e22962fea7221920539b98cdd2b0cbb949803e77e25c3632@mail.kernel.org>
In-Reply-To: <7b248b2be4834322ddaad8ee08d22d083877a932.1792503001.git.xukuohai@huawei.com>
References: <7b248b2be4834322ddaad8ee08d22d083877a932.1792503001.git.xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 01/16] libbpf: Collect arena percpu data section
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:17:06 +0000 (UTC)

--===============1030206949800535023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Collect arena percpu data section

TL;DR: Objects with .arena.percpu but no .maps section may get a misleading
libbpf error naming .addr_space.1 and "global __arena variables"; it's a
message-wording question, not a functional problem.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8fcb8cf39cc0..d79fc382319e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -3201,7 +3212,7 @@ static int bpf_object__init_arena_data(struct bpf_object *obj)
>
>  	if (obj->arena_map_idx < 0) {
>  		/* bpf_object__init_user_btf_maps() didn't look: there is no .maps section */
> -		if (obj->efile.arena_data) {
> +		if (obj->efile.arena_data || obj->efile.arena_percpu_data) {
>  			pr_warn("elf: sec '%s': to use global __arena variables the ARENA map should be explicitly declared in SEC(\".maps\")\n",
>  				ARENA_SEC);
>  			return -ENOENT;

The condition now also fires on obj->efile.arena_percpu_data, but the warning
still names ARENA_SEC and talks about "global __arena variables".  Is that the
intended message for the percpu case?

Consider an object with no SEC(".maps"), the ".arena.data" marker (the
data_in_arena case), some .data/.bss, a ".arena.percpu" section and no
".addr_space.1" section.  bpf_object__init_user_btf_maps() returns 0 early
because btf_maps_shndx < 0, so its new ARENA_PERCPU_SEC message never runs.

bpf_object__init_arena_data() then reaches this block with arena_data == NULL
and arena_percpu_data != NULL, and prints:

  elf: sec '.addr_space.1': to use global __arena variables the ARENA map
  should be explicitly declared in SEC(".maps")

That points at a section the object does not have and at a kind of variable
the user did not declare.  The real problem is the .arena.percpu variables.

The same patch adds a separate message for this case in
bpf_object__init_user_btf_maps():

  pr_warn("elf: sec '%s': to use arena percpu variables the ARENA map should be explicitly declared in SEC(\".maps\")\n",
          ARENA_PERCPU_SEC);

So the two paths report the same condition differently.  Should the no-.maps
path in bpf_object__init_arena_data() choose its section name and wording
based on which of arena_data / arena_percpu_data is set?

The message is unchanged at the end of the series (08224ba2de19
"selftests/bpf: Add test for arena percpu bounds"), so no later commit
addresses this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39434884362
--===============1030206949800535023==--
