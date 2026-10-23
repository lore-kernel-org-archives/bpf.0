Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792716675;
	b=ilqPX/OLqNsjaucBhmgvrWaj3VgWEWqlMHvCn8QP9zvlBd5/7vTaLwbn32sVV/rGvbuk
	 SgC0oB46XuX0tFV/1Iuq7vGt7Vvki0ZXfTjl2hBK/JKYds8E7XXby4fcs7H/a3vboGtwd
	 rL+VtEGSSkt8l4PTcdeTU7LLEoOsgd41pngsV/FkQKuRHZflg1uoxkHcbybM4KVKTGjn2
	 97uHs500eO6edIAUkSfijiC4HjvBOlEcWqJ2c0CU5wAg6KFeYoM/XaZfGlb3ye7F6uFq+
	 5uKY3cZtl9cnFo1WWOl2J6yF870SgRW3Q5NtebTWhY0EGmQddMgqv3poqgJgLQvYBdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716675;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=X5GYCdh8xmF1VOcwMI9Rmm9Dlopew8Em98MYwDhZlz0=;
	b=ENBJa2j/Vz0kXtjh+cviIoXgNfVccn14qTrgWtXFXMFyLqdoTVMv0m7ke99pVirHmJim
	 Ld0atMM9AXndlA5vfInaCPp2XdyVzwfAtt69kxfIDBZrc2r9wK1HeXgz10VeZ6g9WtEjd
	 CkjN/BD8RBbPcQ9cz+IrgdDLnXAMVJkfkG+ypeZ9tpZ2vfwsdQhE5DaX6L0d5kyt1eSYn
	 Yq5xNmUw73I+rtpcnUZgjCWKxIrxIDHYYmUL6Rp4xCtbOdwTrua2vS94+Z3bldicUKo6H
	 nUz6Xv2+5C8pTug6a2DFAK32aL69J/w9KUjX3szrPaXEkZmk5BtCWl/aesiFrUzjCwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjdbaiF2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F92606A320;
	Fri, 23 Oct 2026 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjdbaiF2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9401F01825;
	Fri, 23 Oct 2026 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792716675;
	bh=X5GYCdh8xmF1VOcwMI9Rmm9Dlopew8Em98MYwDhZlz0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PjdbaiF2zllHQoqqlIrAUp9LjOt6GiwrLwHJUctXypc7wQuyWRR8+0Y34F6xNbbQi
	 YMZJjhQb/GC54H5a+z/c6yMCNA2isQLWBgg3zeVk+dcAbBjPWhWFFFGOsf7oG0ydeX
	 NO7pFbDj9Xf1psUs3tsGeyy0lM31+ziZUNurXLMoQDRV4hB6z5qMFMWC4NLWNI9+zE
	 Ib3vVwSS8E5wWh4ETKbbsQUJOTP8c+Exxmtql3go55k/HllI7H0lkifDAt3nKSQtu2
	 mbvqSKbndlGzOYDKdHzdqSrGt2Elee41qCu+sbkQ9+Bs8ZsfqQSfJDvHy36M38LyUI
	 yEWeOozZ1qgxQ==
Content-Type: multipart/mixed; boundary="===============0694406438474598081=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <90371d2279a5eb08966a82325922e1f15eb93560d4019f5c9020956cadb4120a@mail.kernel.org>
In-Reply-To: <20261023001603.560210-12-wusamuel@google.com>
References: <20261023001603.560210-12-wusamuel@google.com>
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Resolve typeless ksyms via KALLSYMS_QUERY ioctl
From: bot+bpf-ci@kernel.org
To: wusamuel@google.com,corbet@lwn.net,skhan@linuxfoundation.org,rdunlap@infradead.org,viro@zeniv.linux.org.uk,brauner@kernel.org,jack@suse.cz,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com
Cc: wusamuel@google.com,kernel-team@android.com,linux-kernel@vger.kernel.org,linux-fsdevel@vger.kernel.org,linux-doc@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,llvm@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 23 Oct 2026 00:51:13 +0000 (UTC)

--===============0694406438474598081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Resolve typeless ksyms via KALLSYMS_QUERY ioctl

TL;DR:
- Possible regression: ioctl lookup ignores .llvm. suffixed symbols, so
  typeless ksyms may fail to load or resolve to 0 on LTO kernels
- Fallback to kallsyms parsing may miss -EACCES (SELinux/seccomp), failing
  loads that worked before

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8fcb8cf39cc0..0e94d2335bd7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -9644,8 +9662,64 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
>  	return 0;
>  }
>
> -static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
> +static int bpf_object__query_ksyms(struct bpf_object *obj)
> +{
> +	struct kallsyms_query q;
> +	struct extern_desc *ext;
> +	int err = 0;
> +	int fd;
> +	int i;
> +
> +	fd = open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		return -errno;
> +
> +	for (i = 0; i < obj->nr_extern; i++) {
> +		ext = &obj->externs[i];
> +		if (ext->type != EXT_KSYM || ext->ksym.type_id)
> +			continue;
> +
> +		q = (struct kallsyms_query){
> +			.size = sizeof(q),
> +			.query_flags = KALLSYMS_QUERY_BY_SYMBOL,
> +			.sym_name_addr = ptr_to_u64(ext->name),
> +		};
> +
> +		if (ioctl(fd, KALLSYMS_QUERY, &q) < 0) {
> +			err = -errno;
> +			if (err == -ENOENT) {
> +				err = 0;
> +				continue;
> +			}
> +			if (err == -EADDRNOTAVAIL)
> +				pr_warn("extern (ksym) '%s': resolution is ambiguous\n",
> +					ext->name);
> +			break;
> +		}

Can this regress typeless ksyms on CONFIG_LTO_CLANG kernels?  The old
kallsyms_cb() deliberately matched data symbols that carry a suffix:

    res = strstr(sym_name, ".llvm.");
    if (sym_type == 'd' && res)
        ext = find_extern_by_name_with_len(obj, sym_name, res - sym_name);

That was added by commit c56e59776f46 ("libbpf: Handle <orig_name>.llvm.<hash>
symbol properly") after test_ksyms failed on a CONFIG_LTO_CLANG_THIN kernel,
where bpf_link_fops had been renamed to bpf_link_fops.llvm.<hash>.  That
commit also lists tk_core, fake_dst_ops and __fs_reclaim_map as real
renamed symbols.

On the kernel side, KALLSYMS_QUERY only matches names exactly:
kallsyms_lookup_names() does a strcmp() on the expanded name, and
kallsyms_mod_find_cb() also uses strcmp().  So a lookup for "bpf_link_fops"
returns -ENOENT when only "bpf_link_fops.llvm.<hash>" exists.

Here -ENOENT is treated as "not found", err is cleared and the loop
continues.  bpf_object__resolve_typeless_ksyms() then falls back only on
-ENOTTY or -EPERM, so libbpf_kallsyms_parse() is never reached.  On a
kernel that has this ioctl:

 - a strong "extern const void foo __ksym;" now makes bpf_object__load()
   fail with "extern 'foo' (strong): not resolved" (-ESRCH), where it
   loaded before
 - a weak one silently gets address 0 instead of the real address

The selftests helper kallsyms_find() in trace_helpers.c still strips
".llvm." from 'd' symbols, so it and libbpf now disagree about what
test_ksyms (bpf_link_fops) should resolve to.

The commit message notes this difference, but gives no reason for dropping
behavior that libbpf added on purpose.  libbpf kept the .llvm. handling
elsewhere to avoid regressions, and commit f8a05692de06 says "we'd like to
not regress".

Would it work to fall back to libbpf_kallsyms_parse() for typeless externs
that are still unresolved after the ioctl pass?  That only costs extra time
when a symbol is actually missing.  Alternatively, the kernel query could
match the .llvm. suffix for data symbols.  I did not find a fix for this in
the rest of the series.

> +		ext->is_set = true;
> +		ext->ksym.addr = q.sym_addr;
> +		pr_debug("extern (ksym) '%s': resolved in kernel to 0x%llx\n",
> +			 ext->name, ext->ksym.addr);
> +	}
> +	close(fd);
> +	return err;
> +}
> +
> +static int bpf_object__resolve_typeless_ksyms(struct bpf_object *obj)
>  {
> +	int err;
> +
> +	err = bpf_object__query_ksyms(obj);
> +	/*
> +	 * Fall back to parsing /proc/kallsyms only if the ioctl is not
> +	 * accessible: not present (-ENOTTY on older kernels) or kallsyms
> +	 * addresses hidden from this opener (-EPERM, e.g. kptr_restrict).
> +	 */
> +	if (err != -ENOTTY && err != -EPERM)
> +		return err;

Does this fallback miss other ways the ioctl can be blocked while reading
/proc/kallsyms is still allowed?

The old code never issued an ioctl on this file.  Now every KALLSYMS_QUERY
goes through security_file_ioctl().  For this command selinux_file_ioctl()
takes the default case and calls ioctl_has_perm(cred, file, FILE__IOCTL,
(u16)cmd), which returns -EACCES when the policy grants read on the
kallsyms label but not ioctl, or limits ioctl commands with allowxperm.  A
seccomp filter that makes ioctl() return an errno other than EPERM has the
same effect.

In those setups bpf_object__query_ksyms() returns -EACCES (or similar),
bpf_object__resolve_typeless_ksyms() returns it as-is, and
bpf_object__resolve_externs() turns it into -EINVAL:

    err = bpf_object__resolve_typeless_ksyms(obj);
    if (err)
        return -EINVAL;

So an object with any typeless ksym now fails to load, even though parsing
the text file would have worked as it did before this patch.

The failure is also hard to diagnose.  Apart from -EADDRNOTAVAIL, nothing
from the ioctl or from open() is reported.  The open() failure path is a
bare:

    fd = open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
    if (fd < 0)
        return -errno;

without the "failed to open /proc/kallsyms" pr_warn() that
libbpf_kallsyms_parse() prints, so the user only sees "failed to load
object".

Should the fallback cover any error other than -EADDRNOTAVAIL (and other
real lookup errors), or at least -EACCES as well, with a pr_warn() for the
errors that are not handled?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39878338337
--===============0694406438474598081==--
