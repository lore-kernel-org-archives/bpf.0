Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EAA221FB4;
	Sat,  3 Oct 2026 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059230; cv=none; b=Yk3EOUlK9qZquzBthUU+kYuplnlNobu6x249oCBYmbxvYs46isGAMZI1ygjSoqCGePcUIBHeq3aLwbEkc1Fsi5tQyAGJSx1ejKsfiToem/ga8DBf7co48PP8DkNQtHnLxLtjPgJTh5WJZtC++LxhrVqgfdf6i81Eo/YmmJg6W80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059230; c=relaxed/simple;
	bh=NqcJvK8AVQJw5bBPeuLa9tHvXWvlcSOhRLw+nFiqoTM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NZbUbT1QK3pSvQy5m9bTP1Oout0offHvQ+Wp3Ye44ddmrtYY+t3Q/wNf4FUZyxSG+OVW77Ukf59S7ui4kj0jfwtcxhAWwR2eN3fIaPZNnjnDWiBapgs22mdLLamWtZGhWOV3HFj9zZii2TF6CZLX+A9mUO08vAq7dfnh1NQDfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb114UBN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb114UBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCE41F0089B;
	Sat,  3 Oct 2026 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791059228;
	bh=7jAlsb3u1qgbmfPQKgvguosNRVvIsjj5uewMkFgkegU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bb114UBNCJTyD1/WKtd/IjgaWvwyiYexRT1Esb5RHbxFhAHeTj0h8SXbDB/A8LFiY
	 SSOkoxREGyFCzW/0aWvxcihNq1gm+OzTg5z7BcvidFEuxmwfXTaDwD2O2LgcVhKiUI
	 Nblx9XkXXVbH3Q5QQG9tzT9hB37Z2jcn6sOxn4oZaGGMaoSrmxMyuZEMTETzg5M5iQ
	 h7PygUMqVl098dgdVYb7YVQ9wmfNdCL1wKlqZVZ7+mBfrU1z+qeeX/wqf+q53eCORy
	 68xu37eVYI8ErjRn2iuRvCEioFCzav7KQyP7nFOAwygskDGIs3wcvK/nNWefG/27rQ
	 BzvPr+xrmoFjA==
Content-Type: multipart/mixed; boundary="===============7817698977931516323=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f1bab7e572efd3d52885d98ce4db1d0b97750a42a7eddacda9536b7943c8ffad@mail.kernel.org>
In-Reply-To: <20261003194323.817885-6-alan.maguire@oracle.com>
References: <20261003194323.817885-6-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 5/7] btf: Relocate and expose module inline BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com
Cc: jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,nathan@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,arnaldo.melo@gmail.com,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  3 Oct 2026 20:27:05 +0000 (UTC)

--===============7817698977931516323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> btf: Relocate and expose module inline BTF

TL;DR: Nits only, no bugs: in module inline BTF relocation, the
old_module_type_cnt parameter looks redundant, and the final
btf_set_base_btf()/btf_check_sorted() calls appear unneeded.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -6922,15 +6922,137 @@ __u32 btf_relocate_id(const struct btf *btf, __u32 id)
> +static int btf_rebase_inline(struct btf *inline_btf,
> +			     const struct btf *module_btf,
> +			     const u32 *module_id_map,
> +			     const u32 *module_str_map,
> +			     u32 old_module_type_cnt)
> +{
> +	u32 old_start_id = inline_btf->start_id;
> +	u32 old_start_str_off = inline_btf->start_str_off;

[ ... ]

> +		while ((id = btf_field_iter_next(&it))) {
> +			if (!*id)
> +				continue;
> +			if (*id < old_module_type_cnt) {
> +				if (module_id_map)
> +					*id = module_id_map[*id];
> +			} else if (*id >= old_start_id) {
> +				*id += id_delta;
> +			} else {
> +				return -EINVAL;
> +			}
> +		}

This isn't a bug, but is the old_module_type_cnt parameter needed?

The only caller passes old_module_type_cnt = btf_nr_types(btf), sampled
before btf_relocate().  inline_btf was parsed by btf_parse_split() against
that same btf, and btf_set_base_btf() sets its start_id to
btf_nr_types(base_btf).

That makes old_module_type_cnt equal to old_start_id, so the final
"else return -EINVAL" branch above does not look reachable.  Could
old_start_id be used for both checks and the parameter dropped?

[ ... ]

> +	btf_set_base_btf(inline_btf, module_btf);
> +	btf_check_sorted(inline_btf);
> +	return 0;
> +}

[ ... ]

> @@ -6954,67 +7076,66 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,

[ ... ]

> +	if (inline_btf) {
> +		err = btf_rebase_inline(inline_btf, btf, btf->base_id_map,
> +					module_str_map, old_module_type_cnt);
> +		if (err) {
> +			pr_warn("failed to relocate module [%s] inline BTF: %d\n",
> +				module_name, err);
> +			btf_free(inline_btf);
> +		} else {
> +			*relocated_inline_data = inline_btf->data;
> +			inline_btf->data = NULL;
> +			btf_free(inline_btf);
> +		}
> +	}

This isn't a bug, but are the btf_set_base_btf() and btf_check_sorted()
calls at the end of btf_rebase_inline() needed?

On success, btf_parse_module() only takes inline_btf->data and then calls
btf_free(inline_btf) right away, so the updated start_id, start_str_off and
named_start_id are never read.  btf_check_sorted() also runs strcmp() across
the inline types and the result is discarded.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37149955093
--===============7817698977931516323==--
