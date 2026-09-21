Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E5147DF94
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032908; cv=none; b=YnYvHIaMFWc5KGtcn+oThSxeXhK4Lql3vndH/hKkoeD5YuRvAmHUR2/zArC7CB7DnXXKMLiW4FTEHPNYlJRRDqAwimVXgQa/HeDHMwJldI6uGtlLTHB+oJJQmD6UhbaXruI+GjWgpq5uW6Umz1LpaoBsX736WB0qMg69qtqI3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032908; c=relaxed/simple;
	bh=n9Pl3IJBE3w3Y6GWPJ3KBqpjXoKQqgw3/iOMNDrvm/8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FNEsYPLfjj+6Rt6W+1pD7mrb4sLo3I+1hgxUanzQ0ioGth+HYZPhafSzYSNFNNKaSP7AoSgfSIsGcnmQ9JXahTfbYbKuXw+630ZzZK3PEB8o3OJeGboBb9gmomCoEYaSPY99HVR0Ie02IbdRY6eOKJsdNh5mf7aUzvLKBB2TDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnT37Du6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnT37Du6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8705B1F000FF;
	Mon, 21 Sep 2026 23:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790032905;
	bh=Y/TTlcQXHN7Z5ikX3A+1RbVJG5rC4sv06cRCf26fNSU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QnT37Du61o5LFJ00417Ua2/mhVmfVEQCvGJg5SOegvMEIjbMGwQ1RCcToAwypoQFh
	 9iOShWdSx3e8R30L/VGNjjZEcSD5MkuM7fPeXowxGWbr2kCBeKyF/a4PIHbOIVWI8K
	 Ljfx2fTFqhDdNSDqn/4dN2I6S8qgzWJ2csNUd8rWx5K+8FP/oT0FMXjI06h46hMeeZ
	 cm7TNqUMzisi3/XwvM9GhhxxJidoTZrtuJXNpAEvD3UuxtK14+9p/ZsCGDwAs8WR7X
	 Gx6UhBssrzWh5QrGINUNpkP6EmnX8wysemwF+/noe59ZlRNsH65en9R6Vck63hCbxe
	 3hlwwT96NUivA==
Content-Type: multipart/mixed; boundary="===============5503195944072848839=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f880f340f62274595f84810e4afcc3eaaab5035ce2631dd60f49dbe2d9464e0e@mail.kernel.org>
In-Reply-To: <20260921223937.3203093-2-andrey.grodzovsky@crowdstrike.com>
References: <20260921223937.3203093-2-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v4 1/7] libbpf: BPF program load strategy enum
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: ast@kernel.org,martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 23:21:44 +0000 (UTC)

--===============5503195944072848839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cd1ea1bb53cb..a3085847cb97 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -15374,3 +15372,17 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
>  	free(s->progs);
>  	free(s);
>  }
> +
> +int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_strategy strategy)
> +{
> +	if (prog->obj->state >= OBJ_LOADED)
> +		return libbpf_err(-EINVAL);
> +
> +	prog->load_strategy = strategy;
> +	return 0;
> +}

Does this function need to validate that strategy is within the defined enum
range?

The setter stores any int value without checking whether it is one of the
two defined enumerators (0 or 1). When code elsewhere in libbpf tests the
stored value, it splits into two non-complementary forms:

  form A, 'is it disabled?':
    libbpf.c obj_needs_vmlinux_btf():        if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED) continue;
    libbpf.c bpf_object__relocate_core():    if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED) continue;
    libbpf.c bpf_object__relocate():         if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED) continue;
    libbpf.c bpf_object__relocate():         if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED) continue;

  form B, 'is it auto?':
    libbpf.c bpf_object__load_progs():       if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_AUTO) { ... continue; }
    libbpf.c bpf_object__attach_skeleton():  if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_AUTO || !prog->autoattach) continue;

With any value other than 0 or 1, a program is neither DISABLED nor AUTO,
so it falls on the 'will be loaded' side of every form-A test and on the
'skip' side of every form-B test. The program is fully CO-RE-relocated,
call-relocated and data-relocated, may force a vmlinux BTF load, and is
then silently never loaded and never auto-attached.

bpf_program__set_load_strategy() returns 0 (success) and
bpf_program__autoload() reports false. There is no diagnostic:
bpf_object__load() succeeds and bpf_program__fd() stays -1.

This is reachable beyond simple caller error, because of how the symbol
is versioned. bpf_program__set_load_strategy is exported under
LIBBPF_1.8.0. The stated purpose of the commit is to allow 'new BPF
program loading strategies to be introduced by extending the enum value
range', and the next patch in this series (7f73306ceddb) does exactly
that, adding BPF_PROG_LOAD_STRATEGY_MANUAL = 2 without re-versioning the
symbol.

An application compiled against the newer header and run against a
libbpf.so that predates MANUAL therefore resolves to this
implementation, which accepts value 2 and silently produces a program
that is never loaded, instead of returning -EINVAL/-EOPNOTSUPP as the
newer implementation does.

That follow-up commit rewrites this function with switch (strategy) {
case DISABLED: case AUTO: ... case MANUAL: ... default: return
libbpf_err(-EINVAL); } -- i.e. it adds precisely the range rejection
that is missing here. Adding the default: return libbpf_err(-EINVAL);
rejection in this commit, where the API is introduced, is what makes
the forward-compatibility contract work; libbpf already validates
public-API inputs this way elsewhere (OPTS_VALID(), if (!prog) return
libbpf_err(-EINVAL) in bpf_program__clone()).

Would it make sense to add a validation check here:

  switch (strategy) {
  case BPF_PROG_LOAD_STRATEGY_DISABLED:
  case BPF_PROG_LOAD_STRATEGY_AUTO:
      break;
  default:
      return libbpf_err(-EINVAL);
  }

so that out-of-range values are rejected at the API boundary?

> +
> +enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program *prog)
> +{
> +	return prog->load_strategy;
> +}

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 7a84dd00ce95..03c3d2bd15bf 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -463,6 +463,8 @@ LIBBPF_1.8.0 {
>  		bpf_program__attach_tracing_multi;
>  		bpf_program__clear_flags;
>  		bpf_program__clone;
> +		bpf_program__load_strategy;
> +		bpf_program__set_load_strategy;
>  		btf__find_by_name_kind_own;
>  		btf__new_empty_opts;
>  } LIBBPF_1.7.0;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35664584544
--===============5503195944072848839==--
