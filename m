Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194817;
	b=eWYrY7YpFFiivTJDlbiuYE9pS6/b4HVtJakdDVl6LZg2OSGeYEdaeeWDTdCwUcKVZIj2
	 LEaUdUvHiV9guvvR6x4oPWWlhbK7ZBAsU4+b34kfdYaA++8YxrdWBiegIsH03LEz3I2XA
	 zfSjNCIxr/c2MLw+Od2NA4giWjjRPuvB3E/5fJMs3EJz3spPk0r3tpkeJD7W+3yy5KCA2
	 +nAY4uIzlTnYvXjJO9cr9JB7UvgiW6y5O2SRUpR3TzvmIptfCbqzC8Nal+fjgL5+hV94S
	 IdcIFVxpw3FySBZLGUR3RMd6Rej/A2rGt1trcd0UdOMMBd99DWcPWnwWRtlLmKugFTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rTR6fgNF+2TTk5l8yXrK2u6P71Yis/UBObU7lA/CVSY=;
	b=A8oD8iVeBBbBNqjv2VQCZ1hwOw6qiNPMCPh2IGSxkrf2KgH2Sjs0s0MY0rF+YRIBmEyR
	 9h8dlhC5eOEsf2wW/MoNrUNOXptcx0qt5cR7H5KzsMoSebGGeyfCp5fV7DH7zmn2paO9y
	 Qi4yhHYhpRpD5t6pCv6UTJ03vhgvPpkraUIHFtqauANxdwlYFAzdpZr5pG0kYJPcNR6Au
	 P1EkI4EqQoKXi88XVveF6ZlHQcig+xyse3KkQ1qPfaFrtgMqoGzeAuqf7NKzIhLsml55t
	 ZZCbcxMJ9qXu7hQe/EGV2uqevqF4m6+7//F3f/dWrog6kZz0YploDo6MAj/xuU1oBYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T4eBS8Wg;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EEE606A31F
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 13:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2EEE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T4eBS8Wg
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so7865395e9.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793194815; x=1793799615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rTR6fgNF+2TTk5l8yXrK2u6P71Yis/UBObU7lA/CVSY=;
        b=T4eBS8Wg2tS8DF2FxDoEzLk87FWGAltZONOWqqijvhnliG+/czE7LgvFt+6WpuWixQ
         JoL0giCy/cjWdD0Ne1bc1EGAQPvdUpic6VSEjbeOkc4Qxc/nA8+64kkEwHTGNWVj/hcw
         Ohpjh2dSQWALbSot6oK24tbEpUlpMI/8rxyrSro5tibi/fo2DFSYzf+s+1vyqxKYfvLo
         XrgA9dUQd65+mVhNnGRNVZaeFKJxG86XUO6IYgm6Rou9lg4QAMd9jEwsjX6tOev+Eag4
         ktPy6iANe6CUFb13V9Km1VpmaoEpJmi//nnx+suJrOUXG2jBKAYszIucY7rtpIFQi9UR
         glig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194815; x=1793799615;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTR6fgNF+2TTk5l8yXrK2u6P71Yis/UBObU7lA/CVSY=;
        b=xL514fOpjqT7BmUdVG6L3h0JUE5nDiIC1A0k404ME3XWvhF4G8s4aaBIkj6aGgdaAF
         RLZS79Uh+lHbWVN6MAmeQm3+0S4JS/5LjCZvezjjohVxjzakxOv2Z4WyMg4vBDhKb2Gg
         l7BBTWwwRi3m9GxnuJCj4Uf044sStroZl/tb6xN19kZrLTSWaFy+r2f63/Hd99ks458N
         Gh7wNdHcpau70/4Gp9rNPGE8UDln0rV8bgIsI7ulbY6f5309xHVgVPFXeQYrJdgR3una
         GWm5mJsoKr7TMJKz+yTrQ56Wa4EWYJE+GvIWVf1EC2uoeyJ9/sADj6CyT548WMgu62/i
         1/ew==
X-Forwarded-Encrypted: i=1; AKwUvBwOF+wV61Opo8iT5mJlTq4xa53M5RSjLfiyvhxReQFiTzZYACMgfE2Nx6x1JbX3IKDYT5I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2Wve2lqb1a8KQmrmHO6QAi8+ecjXDP/+dmVrkkHJs8pxhxIy3
	zmPmJn2O/lQNH+NqnpdQNiXymbS59jkjMmaHsel8U7gW/V7PauLrFaEfY/Z30i+W
X-Gm-Gg: AYBFou3gWOvfibZYZdFdshali2HtdVQmys9ApVBYzwzwJuP/7N8rCe/CoKgzQ9METhw
	ufmv1sgqSPBH9dNurLFE0r2uZAdLVB3o/X51dgYih17F2r0xT6X1+PmV00T8wlnLhOrJllVpf0R
	6PR7mmsLs2Dc2bvplamqHCKWmUjaQGLcGi0paZDV3Di1/SRvGJ47OPjkNoNbwdD8awziRYr+u3m
	LExZtLGozFSBX9k6X8TmlgQTdB8b2sSwjQnCdhKyUun3ln/ijpA9aY+UtdAtYZmZJxEOXY0hGfO
	iDwVmJv5DDRQe/stNpPZPxbZ9YaaamEhBAVGkE/mFHMtP2RbWgCWl5/1B3WhdM4U8DCNiNANNHZ
	y1K8SaZ733RFjEfTfv7LBzcm1+ph36xVTH2v+axL2ugOD/fXn3br3jd8DOcYMH2L4TwmEgeOylv
	Hb3Wr4z+BMxsnoqZTt3lAvKMsnXZD8m7qdwNRsPHAqNvR3+iOghe3DqHW4VXp8Qy8lsDGVcT4rd
	kkMn6j+kJ1+v4EijfE+hiDWMBwSvQABnSrZy79CZwovlAwNewsXN/YTsq7D8KHIdKDA7vy5CkcF
	DoDGMNz10uFIw/iME4uEqIdtHegFK3sQx5kvJCQD44HrbjesShzxs9v1p7C0tiNIK+8=
X-Received: by 2002:a05:600c:6085:b0:4a1:e01e:1927 with SMTP id 5b1f17b1804b1-4a996a9e304mr40226765e9.5.1793194814621;
        Wed, 28 Oct 2026 06:40:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3c32sm29592978f8f.47.2026.10.28.06.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:40:14 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:40:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to
 /proc/kallsyms
Message-ID: <20261028134012.01d52e94@pumpkin>
In-Reply-To: <20261023001603.560210-9-wusamuel@google.com>
References: <20261023001603.560210-8-wusamuel@google.com>
	<20261023001603.560210-9-wusamuel@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 17:16:02 -0700
Samuel Wu <wusamuel@google.com> wrote:

> Add an extensible KALLSYMS_QUERY ioctl() interface to /proc/kallsyms
> to support fast point queries without scanning the entire text file.
> Exactly one query mode must be set in query_flags.
> 
> When KALLSYMS_QUERY_BY_SYMBOL is set in query_flags, KALLSYMS_QUERY
> resolves a NUL-terminated symbol name in vmlinux or loaded modules and
> then populates sym_addr:
> - Searches vmlinux first via kallsyms_lookup_names() (binary search),
>   which takes precedence over loaded modules, and falls back to
>   module_kallsyms_on_each_symbol() under module_mutex for module
>   symbols
> - Matches names exactly, like kallsyms_lookup_name(), disregarding the
>   .llvm.<hash> matching, following precedent set by commit fb6a421fb615
>   ("kallsyms: Match symbols exactly with CONFIG_LTO_CLANG")

Hmmmm....
What happens when you have functions foo and foo.constprop0
In some sense they are duplicates.

> - Resolves 0x0 symbol addresses in both vmlinux and modules
> - Rejects ambiguous symbols (multiple entries with the same name at
>   different addresses within vmlinux, or across loaded modules) with
>   -EADDRNOTAVAIL, while allowing same-address aliases
> 
> Userspace symbolizers resolve kernel addresses to symbol names with
> /proc/kallsyms. This is typically done by reading the entire
> /proc/kallsyms text file, and keeping a compressed sorted copy of it in
> order to resolve addresses at runtime.

You could mmap the tables into userspace and have a ioctl that reported
the offsets of the tables (etc).
Then user lookup would faster then kernel lookup!
Especially since you could throw a bit more memory at it to remove the
linear scans.

> 
> When KALLSYMS_QUERY_BY_ADDR is set in query_flags, KALLSYMS_QUERY
> resolves one address to the symbol that contains it:
> - sym_addr holds the address to resolve on input.
> - sym_name_addr must point to a user buffer of sym_name_size bytes
>   that receives the NUL-terminated symbol name. On output,
>   sym_name_size holds the number of bytes written (including the
>   terminating NUL). -ENAMETOOLONG is returned if the buffer is too
>   small; a buffer of KSYM_NAME_LEN (512 at the time of writing) bytes
>   is always large enough.
> - Symbols are resolved via kallsyms_lookup(), the same lookup as %pS,
>   covering vmlinux, loaded modules, BPF JIT images, and freed module
>   init functions still tracked by ftrace.
> 
> On an 8 CPU Cuttlefish (x86-64 VM), using this patchseries to load a BPF
> program with 11 typeless ksyms has ~220x speedup (157ms -> 0.7ms).

Have you tried measuring it with my patches that speed up the kernel
'search by name' code?
That speeds the lookup by a factor of ~18 (testing the code in userspace).

You also should allow for 'find first' and 'find next'.
As well as letting the code iterate though functions with the same name
it is absolutely trivial to enhance the 'lookup by name' code to match
a prefix.
(Basically it needs to 'return -index' instead of 'return -1' when the
binary scan fails.)


> 
> On an 8 CPU x86-64 VM with a 175k line kallsyms, there are broad
> performance and memory savings for the symbolization and callstack
> sampling tool, Perfetto:
> - Init time: ~350x speedup (155.7ms -> 0.44ms)
> - 50k symbolizations: ~12x speedup (25.2ms -> 2.2ms)
> - VmRSS: -68% (15.1MB -> 4.8MB)
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  include/uapi/linux/fs.h |  41 +++++++++++++
>  kernel/kallsyms.c       | 132 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 173 insertions(+)
> 
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 34c6f219462a..b43f227dad0e 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -674,6 +674,47 @@ struct procmap_query {
>  	__u64 build_id_addr;		/* in */
>  };
>  
> +/* /proc/kallsyms ioctl */
> +#define KALLSYMS_QUERY	_IOWR(PROCFS_IOCTL_MAGIC, 18, struct kallsyms_query)
> +
> +/* Exactly one query mode must be set in query_flags. */
> +enum kallsyms_query_flags {
> +	/*
> +	 * Look up a symbol in vmlinux or loaded modules (vmlinux first; BPF
> +	 * and ftrace symbols are not searched) by exact NUL-terminated name
> +	 * at sym_name_addr and return sym_addr. sym_addr and sym_name_size
> +	 * must be 0 on input.
> +	 */
> +	KALLSYMS_QUERY_BY_SYMBOL = 0x01,
> +	/*
> +	 * Look up the symbol covering sym_addr and write its NUL-terminated
> +	 * name to the sym_name_addr buffer of sym_name_size bytes. The same
> +	 * symbols as %pS are searched: vmlinux, loaded modules, BPF JIT
> +	 * images, and freed module init functions still tracked by ftrace.
> +	 * A buffer of KSYM_NAME_LEN (512 at the time of writing) bytes is
> +	 * always enough. On success, sym_name_size is set to the number of
> +	 * bytes written (including the terminating NUL).
> +	 */
> +	KALLSYMS_QUERY_BY_ADDR = 0x02,
> +};
> +
> +/*
> + * Returns -ENOENT if no symbol matches, -EADDRNOTAVAIL if the name maps to
> + * more than one address, -ENAMETOOLONG if the name does not fit in
> + * KSYM_NAME_LEN (512 at the time of writing) or sym_name_size bytes, and
> + * -EPERM if kallsyms addresses are hidden from the opener of /proc/kallsyms
> + * (e.g. kptr_restrict).
> + */
> +struct kallsyms_query {
> +	__u64 size;		/* in - struct size for compatibility */

I'm not sure you need a size here as well as the one in the ioctl command.
It only complicates things when they differ.

If you need a new version they you add an extra case to the switch statement.
Simple and easy,

> +	__u64 query_flags;	/* in - query mode (enum kallsyms_query_flags) */
> +	__u64 sym_name_addr;	/* in - address of symbol name buffer */
> +	__u64 sym_addr;		/* out (BY_SYMBOL) / in (BY_ADDR) */
> +	__u64 sym_name_size;	/* in/out - name buffer size / bytes written */

Maybe separate the buffer size from the length of the symbol written?
The in/out parameter will get annoying in code doing multiple lookups.
Or just have the buffer size and require it to be '\0' terminated.
(There is a strncpy_from_user() can that be used.)

The '\0' terminated string handling is likely to be noise against
all the rest of the lookup code.

David

> +};
> +
> +#define KALLSYMS_QUERY_SIZE_VER0	40 /* sizeof first published struct */
> +
>  /*
>   * Shutdown the filesystem.
>   */
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index aec2f06858af..7caaf3e421c7 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -31,6 +31,7 @@
>  #include <linux/kernel.h>
>  #include <linux/bsearch.h>
>  #include <linux/btf_ids.h>
> +#include <linux/uaccess.h>
>  
>  #include "kallsyms_internal.h"
>  
> @@ -922,11 +923,142 @@ const char *kdb_walk_kallsyms(loff_t *pos)
>  }
>  #endif	/* CONFIG_KGDB_KDB */
>  
> +struct kallsyms_mod_find_ctx {
> +	const char *name;
> +	unsigned long addr;
> +	bool found;
> +};
> +
> +static int kallsyms_mod_find_cb(void *data, const char *name, unsigned long addr)
> +{
> +	struct kallsyms_mod_find_ctx *ctx = data;
> +
> +	if (strcmp(name, ctx->name) != 0)
> +		return 0;
> +	if (ctx->found && ctx->addr != addr)
> +		return -EADDRNOTAVAIL;
> +	ctx->found = true;
> +	ctx->addr = addr;
> +	return 0;
> +}
> +
> +static int do_kallsyms_query(struct kallsym_iter *iter, void __user *uarg)
> +{
> +	char namebuf[KSYM_NAME_LEN];
> +	struct kallsyms_query karg;
> +	unsigned long addr;
> +	unsigned int start;
> +	unsigned int end;
> +	unsigned int i;
> +	__u64 usize;
> +	long len;
> +	int err;
> +
> +	BUILD_BUG_ON(sizeof(struct kallsyms_query) != KALLSYMS_QUERY_SIZE_VER0);
> +
> +	/*
> +	 * The text interface shows zero addresses to openers without permission.
> +	 * A zeroed point query result is useless (and an address-to-symbol query
> +	 * would leak KASLR), so fail instead.
> +	 */
> +	if (!iter->show_value)
> +		return -EPERM;
> +	if (copy_from_user(&usize, uarg, sizeof(usize)))
> +		return -EFAULT;
> +	if (usize > PAGE_SIZE)
> +		return -E2BIG;
> +	if (usize < KALLSYMS_QUERY_SIZE_VER0)
> +		return -EINVAL;
> +
> +	err = copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
> +	if (err)
> +		return err;
> +
> +	switch (karg.query_flags) {
> +	case KALLSYMS_QUERY_BY_SYMBOL:
> +		if (karg.sym_addr || karg.sym_name_size)
> +			return -EINVAL;
> +
> +		len = strncpy_from_user(namebuf, u64_to_user_ptr(karg.sym_name_addr),
> +					sizeof(namebuf));
> +		if (len < 0)
> +			return len;
> +		if (len == 0)
> +			return -EINVAL;
> +		if (len == sizeof(namebuf))
> +			return -ENAMETOOLONG;
> +
> +		if (kallsyms_lookup_names(namebuf, &start, &end)) {
> +			struct kallsyms_mod_find_ctx ctx = { .name = namebuf };
> +
> +			err = module_kallsyms_on_each_symbol(NULL, kallsyms_mod_find_cb, &ctx);
> +			/* Check first: maps -EOPNOTSUPP (CONFIG_MODULES=n) to -ENOENT. */
> +			if (!ctx.found)
> +				return -ENOENT;
> +			if (err)
> +				return err;
> +			addr = ctx.addr;
> +		} else {
> +			addr = kallsyms_sym_address(get_symbol_seq(start));
> +			for (i = start + 1; i <= end; i++) {
> +				if (kallsyms_sym_address(get_symbol_seq(i)) != addr)
> +					return -EADDRNOTAVAIL;
> +			}
> +		}
> +
> +		karg.sym_addr = addr;
> +		break;
> +	case KALLSYMS_QUERY_BY_ADDR:
> +		if (!karg.sym_name_size)
> +			return -EINVAL;
> +		addr = karg.sym_addr;
> +		/* Reject addresses that do not fit in unsigned long (32-bit). */
> +		if (addr != karg.sym_addr)
> +			return -ENOENT;
> +		if (!kallsyms_lookup(addr, NULL, NULL, NULL, namebuf))
> +			return -ENOENT;
> +
> +		len = strlen(namebuf) + 1;
> +		if (karg.sym_name_size < len)
> +			return -ENAMETOOLONG;
> +		if (copy_to_user(u64_to_user_ptr(karg.sym_name_addr), namebuf, len))
> +			return -EFAULT;
> +
> +		karg.sym_name_size = len;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (copy_to_user(uarg, &karg, min_t(size_t, sizeof(karg), usize)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static long kallsyms_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct seq_file *m = file->private_data;
> +
> +	switch (_IOC_NR(cmd)) {
> +	case _IOC_NR(KALLSYMS_QUERY):
> +		if (!extensible_ioctl_valid(cmd, KALLSYMS_QUERY, KALLSYMS_QUERY_SIZE_VER0))
> +			return -ENOIOCTLCMD;
> +		return do_kallsyms_query(m->private, (void __user *)arg);
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> +
>  static const struct proc_ops kallsyms_proc_ops = {
>  	.proc_open	= kallsyms_open,
>  	.proc_read	= seq_read,
>  	.proc_lseek	= seq_lseek,
>  	.proc_release	= seq_release_private,
> +	.proc_ioctl	= kallsyms_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.proc_compat_ioctl = compat_ptr_ioctl,
> +#endif
>  };
>  
>  static int __init kallsyms_init(void)

