Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8B399D08;
	Sat,  3 Oct 2026 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059239; cv=none; b=KjGFU7u6SwD8dTC1RcnMQYQoTvIqG9of04XEDXiJ3Zg327fGopvd1tB6F6Rr47M3FLZTrvi3FC78jayDB2YzMEvUoSqtU0kjDJA+DCNL0uRmN+aH6VDVC2l+kiHQ0tR3P35YnBJPLCb0ny37CA8drkUMQ4/ckvemZ+lwPL0DVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059239; c=relaxed/simple;
	bh=mT31yOMhXDWFMElESEO3qfpPEJMC3J7twqaTISca9KI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EUsBNMG0ClyYp8GArlaw/eEnQmlqBjEPsghQ/avyPybZuAoJfgOY8UnqWduQn/APwsxUgeIC1KhKihUwifqpgUKTuKBbCg7/CR6lHIzMUY3BuNieVhtPa6a3PrJSXfW3prXPWw4TNV5SpfF7EejDidpYD4rrPv7SuI6VXWorG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfczIm8U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfczIm8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA171F0089B;
	Sat,  3 Oct 2026 20:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791059237;
	bh=LJhiMP2xHD5W0OGx6I0lraK3sXPnT6dyp2E5Z6+dTU0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EfczIm8UTpbmH7pNe2Jh9bIcu8zEKAoqMRUP0tOzgvXRc0O/okIqM6Dbr6EpODKIZ
	 38DI/aCV6OuqJ3bOloQC+GdmJGI22aot6TPIfUcTVj+vtnqSB2ivR7UfAUZ09iQKC6
	 SXLlgPZw4fXBX3B32furWtBJc7Kwo6LH9BkJ65/iXq6B2QxWn1sBMbeiB7UlltHz86
	 xA249DmhByH3jl6pbeJM9/UXDOZ1d6FXRj4BdKOQ4IgUQ0HTkf45ppeDQKYUCEiiye
	 h14uX5lzy+bKa5eUOY1E5rtzrSYHluMRdGOhU84a9MAJErnbtSJdDzb6SIwDawP/Wy
	 vm4qLoxD61Cag==
Content-Type: multipart/mixed; boundary="===============2848157404646130315=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c31e200b18e1cec867f9be4d5a3f20fe8403ee300b51c81e4584c144a7592e5e@mail.kernel.org>
In-Reply-To: <20261003194323.817885-3-alan.maguire@oracle.com>
References: <20261003194323.817885-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 2/7] resolve_btfids: Populate BTF link section
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com
Cc: jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,nathan@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,arnaldo.melo@gmail.com,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  3 Oct 2026 20:27:15 +0000 (UTC)

--===============2848157404646130315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Populate BTF link section

TL;DR: patch_btf_link() and main() in resolve_btfids mostly fail silently; a
kbuild vmlinux link step could stop with only "Error 234". Should pr_err()
messages be added, as patch_btfids() does?

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index dcd289d16faf..84cd9691f177 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -1036,6 +1095,110 @@ static int dump_raw_btf(struct btf *btf, const char *out_path)
>  	return 0;
>  }
>  
> +static int patch_btf_link(struct object *obj, const struct btf_link *link)
> +{
> [ ... ]
> +	if (stat(link->btf_path, &st) || !S_ISREG(st.st_mode) ||
> +	    st.st_size <= 0 || st.st_size > UINT_MAX)
> +		return -EINVAL;
> +	raw_btf_size = st.st_size;
> +	raw_btf_data = malloc(raw_btf_size);
> +	if (!raw_btf_data)
> +		return -ENOMEM;
> +	btf_file = fopen(link->btf_path, "rb");
> +	if (!btf_file)
> +		goto out_data;

Should patch_btf_link() print a message when it fails?

Nearly every error path here returns without any diagnostic: the stat() and
S_ISREG() check, malloc(), fopen(), fread(), an unknown ELF class, a module
name that is too long, a section name that does not fit in section[], open(),
elf_begin(), elf_getshdrstrndx(), gelf_getshdr(), an unknown EI_DATA and
elf_update().  Only "section %s not found" and "section %s is not a writable
BTF link" call pr_err().

The sibling patch_btfids() calls pr_err() with strerror(errno) or
elf_errmsg() on the corresponding failures (open, elf_begin,
elf_getshdrstrndx, gelf_getshdr, stat, fopen, fread, elf_update), and
pr_err() prints regardless of verbosity.

> [ ... ]

> +	if (!scn) {
> +		pr_err("FAILED: section %s not found in %s\n", section, obj->path);
> +		goto out_elf;
> +	}
> [ ... ]
> +	if (elf_update(elf, ELF_C_WRITE) >= 0)
> +		err = 0;
> +out_elf:
> [ ... ]

[ ... ]

> @@ -1931,12 +2097,30 @@ int main(int argc, const char **argv)
> [ ... ]
> -	if (btfids_path)
> -		return patch_btfids(btfids_path, obj.path);
> +	if (btfids_path) {
> +		err = patch_btfids(btfids_path, obj.path);
> +		if (err || !btf_links.cnt)
> +			goto out;
> +		if (elf_collect(&obj)) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +		for (u32 i = 0; i < btf_links.cnt; i++) {
> +			struct btf_link *link = &btf_links.links[i];
>  
> +			err = patch_btf_link(&obj, link);
> +			if (err)
> +				break;
> +		}
> +		goto out;
> +	}

main() does not print anything either when patch_btf_link() fails:

    err = patch_btf_link(&obj, link);
    if (err)
        break;
    ...
    goto out;

so resolve_btfids exits with status 234 (-EINVAL) or 255 (-1) and no
message.

This looks reachable from kbuild.  f61c6417ac15 ("kbuild, btf: Expose
vmlinux inline BTF through sysfs") makes scripts/link-vmlinux.sh always pass:

    --btf_link .BTF.inline:btf_vmlinux_inline:vmlinux.BTF.inline

when BTF_INLINE=m, while scripts/gen-btf.sh explicitly handles a missing
${ELF_FILE}.BTF.inline by running:

    rm -f "${objtree}/vmlinux.BTF.inline"

In that case, or if writing the output fails, or if a module name is 56
characters or more on a 64-bit target, the vmlinux link step stops after
"BTFIDS vmlinux" with only make's "Error 234" and nothing that says which
check failed.

Could pr_err() messages be added, as patch_btfids() does, naming
link->btf_path, link->module, the section and obj->path?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37149955093
--===============2848157404646130315==--
