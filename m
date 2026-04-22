Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C5219CD1B
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776895352; cv=none; b=Hhxcu6MKpgaHe36HzsTqAVj1NutBtISUAnYJj/xdt7vOVvIRrZYLOkuE8k2RZg2UyxGwh7B58aSCgC0OC1NO9IxZnftrAf7BP3TaTKzyu6IEPP286InmrFyKs0ZdwTKILrH9/bomPxRZrwmuUivwk9H74EwVZkbp/W3QbzrdNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776895352; c=relaxed/simple;
	bh=qw82GKGKxyWVe9N7bTJC99BwbcUgKdlfk6HqKBauFXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fbW3IULHoqbDGUkiSVSHTOYQ9T6wVY+pcxXkOD2B1YXvBJOS0CyQA16Dl1sASvV61oFSyaym8442jGqvnlL/SE6S4PvNIc6PoSMfce6F/AHrbcxhwI94c8k1yZE+uDugurT3aPce2wqGNZVqq9OKPIXlglxPnZMDi0A1DOiODWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC33B6aB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC33B6aB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8141C19425;
	Wed, 22 Apr 2026 22:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776895351;
	bh=qw82GKGKxyWVe9N7bTJC99BwbcUgKdlfk6HqKBauFXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pC33B6aBY5pYnRdfxKmuBT+52rgf7vO6aREzY9IiZe8fxK/VBFseFdEBjCHhGeSZ+
	 f/NZWvlw0Ja6zztnIjwbVCD68dtuIH/mLODYUiJGpy9WxI7SoombUon+4DUGvjHML1
	 6wqQJJqBV+Q5T7BPCRtUkyLE0A1AwdGvh5j38e6TXt5+hft92C0oCeUrfgl/vbI4ZJ
	 ACKcdoxxmRP1F7MRjlADUBANVtSQ4n99uizrVEsnkqSoH+g61ZF3GfbnO8EJVxjRyI
	 rwa6rLj6ykLqcML3Q3C2FR5m9lM17EZC4MsFO5UzE/Ff2/5Yehn7dv4QnB1lqIPmlj
	 bPemEfIHUn4cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v12 2/6] bpf: Add
 bpf_prog_run_array_sleepable()
Reply-To: sashiko@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260422-sleepable_tracepoints-v12-2-744bf0e3b311@meta.com>
References: <20260422-sleepable_tracepoints-v12-2-744bf0e3b311@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 22:02:31 +0000
Message-Id: <20260422220231.A8141C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Inverted RCU lock logic in bpf_prog_run_array_sleepable() caus=
es use-after-free and 'sleeping in atomic' panics
--

commit bed1594e26a509b74cbf793566b3e03eca1cc31d
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Add bpf_prog_run_array_sleepable()

This commit adds a new function to run BPF program arrays on faultable
tracepoints. It includes per-program recursion checking for private stack
safety and identifies dummy placeholder programs by checking if the length
is zero.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4b703c90ca94..c909fee369c2d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> @@ -3079,6 +3079,56 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *p=
tr);
>  void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
>  void bpf_prog_report_arena_violation(bool write, unsigned long addr, uns=
igned long fault_ip);
> =20
> +static __always_inline u32
> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
> +			     const void *ctx, bpf_prog_run_fn run_prog)
> +{

[ ... ]

> +		run_ctx.bpf_cookie =3D item->bpf_cookie;
> +
> +		if (prog->sleepable) {
> +			guard(rcu)();
> +			ret &=3D run_prog(prog, ctx);
> +		} else {
> +			ret &=3D run_prog(prog, ctx);
> +		}

Should the guard(rcu)() logic be inverted here?=20

Sleepable BPF programs are permitted to block and sleep to handle page
faults, but holding the RCU read lock while sleeping is generally not
permitted and can lead to scheduling while atomic panics.

Conversely, executing non-sleepable BPF programs without the RCU read lock
could lead to use-after-free regressions, as they rely on the execution
environment holding the RCU lock to safely access RCU-protected memory and
dynamically sized maps.

Could this be changed to if (!prog->sleepable) to match the pattern used in
bpf_prog_run_array_uprobe()?

> +
> +		bpf_prog_put_recursion_context(prog);
> +		item++;
> +	}
> +	bpf_reset_run_ctx(old_run_ctx);
> +	migrate_enable();
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422-sleepable_=
tracepoints-v12-0-744bf0e3b311@meta.com?part=3D2
