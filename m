Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505842;
	b=Hi/vdejFGQ7T3anifk7vocUeVraD/GCVGvL8BAqkaB+Eu0XJMoFLQJotVuP4xIdOQMXy
	 mgIS0qBzhdrTCgNYR5IEA6ppqaq0bMd+KbXh1kCt/I0z+xmN10R0aXbqK8FRECMetx9hP
	 OigSDLJSg1j42Pt9332/zvcVdq9QoM15i+ozUWSOhsjzFkK8fVrsGU72UYYcUHrMeD/y8
	 h5UdMHMXeQwKlR3o3OeW+IsKh2p2GCKMcpea3C7ymbbSBE2r98ublt1RYB2egaPrrtvIJ
	 WMmquHJuIO1XmFmWAF8g1r4yZwt2FltkTmDBTegNNmnkM+81NWwpc2vqGw/LR7QdNew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505842;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=eyzv8VAqNq1bMqb4fOvcEwCqivNKTmGpUN7t4CEDvZk=;
	b=pZiDxKHdcKSkdIFA55WswZ2CZCTpZF/7qWEic1CwTsDh5zJrttJcKRmqminN9IJOy34+
	 P8zjoB/g0fnWl9eDf/c7cKtK8H+05HMMvdk+qI8YHV7UiZcGs8FdDjdT2PoHLsa0xZVpU
	 MqhE8F69eMy6bhSNNbToJFF0BoY672wHU9b/bH+F62aO2C0PT4UfUHCiPAnBtjBdhRUvh
	 0o7rUHN4X4PXa7GaQ2LUJtg4ByeftQqEea5FKsm2+YkXMAPuQ9gvJ0SoZgIob087mibUq
	 m2Rk6VjJIyIaQETfTFR34+KrNzqLTXCflw28wIOzsBRt31kl4/RtMd4zw6tn1keDIng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3Sjarel;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D260A262D;
	Tue, 20 Oct 2026 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3Sjarel
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E47E1F000C4;
	Tue, 20 Oct 2026 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505841;
	bh=eyzv8VAqNq1bMqb4fOvcEwCqivNKTmGpUN7t4CEDvZk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F3Sjarel3UirHSqDWgbAcigJAb2VgLKzWpkD9POqx2/dhwFqxZxW690eGRvqR2WqX
	 NoaRFxxAOwFVunX77I3u+aXHxRSqL5a7hTaKsRNNZnPhtBOimBG6EFPNmbYafSFlLM
	 BuWK/lLVwsYGOcLOWSPxTMPQ7h53hW3SgG1IP8DKL6lPcSNu/9TLcIHY9ntu7WCEEW
	 J9KOLHoRQSMol7QO/ooKfsdSOgB5dWIoKHytAb9OCuBBHbsE8Xw1sERnDZ5cO/BNPq
	 I04ZQmMB/Zvvx5hlSjX1xHk/TEs5ghna01Gm5UCFRLJ6SFz5zpERndztmTJOIplgMP
	 DVPxpZiLC2s3Q==
Content-Type: multipart/mixed; boundary="===============4125915590678054643=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <0f8e9bbc8c00828efc651f83163cd7bec80c11298e94880c0319981ded391ef3@mail.kernel.org>
In-Reply-To: <10e58b0ec9fab53a862d5efe45c8de932e0f5a6b.1792503001.git.xukuohai@huawei.com>
References: <10e58b0ec9fab53a862d5efe45c8de932e0f5a6b.1792503001.git.xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 07/16] libbpf: Add arena percpu feature probe
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:17:21 +0000 (UTC)

--===============4125915590678054643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Add arena percpu feature probe

TL;DR: The new arena percpu probe check in bpf_object__relocate() lacks an
arena_map->autocreate condition, so on kernels without the feature, objects
with .arena.percpu data may fail to load with -EOPNOTSUPP even when the arena
is disabled.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8634778e8ba5..be2ddaf96631 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -8288,6 +8288,12 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
>  			return -EOPNOTSUPP;
>  		}
>
> +		if (obj->arena_percpu.present && !kernel_supports(obj, FEAT_ARENA_PERCPU_DATA)) {
> +			pr_warn("map '%s': kernel doesn't support %s variables\n",
> +				arena_map->name, ARENA_PERCPU_SEC);
> +			return -EOPNOTSUPP;
> +		}
> +

Should this check also require arena_map->autocreate?

As written, any object with a .arena.percpu section fails to load on a
kernel without this feature, even when the arena map is not going to be
created.

The rest of the series supports an arena map with autocreate == false:

  bpf_object__relocate_data(), RELO_ARENA_PERCPU:
      if (map->autocreate) {
          insn[0].src_reg = BPF_PSEUDO_ARENA_PERCPU; ...
      } else {
          poison_map_ldimm64(...);
      }

  bpf_object__relocate_data_ptrs():
      if (!arena->autocreate)
          return 0;

  bpf_object__bind_arena():
      if (!map->autocreate || map->fd < 0 || ...)
          return 0;

The later commit 6714f66de847 ("libbpf: Introduce arena percpu helpers for
user space") also documents bpf_map__arena_percpu_base() as returning NULL
for a map with autocreate == false.

The related FEAT_PERCPU_DATA and FEAT_GLOBAL_DATA handling in
bpf_object__create_maps() skips creating the map and only fails the
programs that are loaded and reference it:

  If those global variable-using programs are not loaded at runtime due to
  bpf_program__set_autoload(prog, false), bpf_object loading will succeed
  just fine even on old kernels. Same skipping applies to percpu data.

Consider a kernel that supports arenas but not arena percpu, or an arch
whose JIT lacks bpf_jit_supports_arena_percpu_insn().  The application
calls bpf_map__set_autocreate(arena, false) and
bpf_program__set_autoload(prog_using_percpu, false), then
bpf_object__load():

bpf_object__load()
  bpf_object_load()
    bpf_object_prepare()
      bpf_object__relocate()
        return -EOPNOTSUPP;

At the parent commit 422f64147751 this same object loaded: the arena was
skipped in bpf_object__create_maps(), percpu ldimm64 instructions in
programs that are not autoloaded were never relocated, and poisoned ones
are only rejected if the program is loaded.

libbpf has no public probe for this feature, and retrying with the arena
disabled hits the same check.  Is there any configuration on such kernels
that can load an object carrying arena percpu data, including its programs
that do not use the arena?

Adding arena_map->autocreate && to the condition would keep the early, clear
error for the normal case while keeping the autocreate == false path
working.

The commit message says "fail objects carrying arena percpu data with
-EOPNOTSUPP when it is missing", but it does not say why this should apply
when the arena map is not going to be created.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39434884362
--===============4125915590678054643==--
