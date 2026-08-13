Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759EC2737FC
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646792; cv=none; b=XjihMrcuVo2M68716/LIN5HA+po/ce0dlrBo2jEKKy7FkxGn2Uku6609LDPuH9FPjYw+zJ+5bMsCKw/gIktUlDcSYDGnWOqK6rF8Bl7Tq4QIUqddB55Fo8UDXkfvjswJ5ccaXGIwQkglB1R/rzNVqSo59/q9Ut3Z6MVVqM9Gv+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646792; c=relaxed/simple;
	bh=TizQEdWUnBhu6f2c0Xq+niSzGCegAHA5mRn1iMikqtw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SYw3Oq9wRPS/EvzwdzLbUXrKqU7G2YRBuEgc6FsDqhyf128UOXBuYmARXwm+KhI+EAJvUgCU/Of6Tbj0xvNGp5RRNRpDKlcDBZkhAjr5qhb/8xgYdaO6YWsJLWzgjz4RJ65mOHykYnZipbtTGR4lZ4up56cm6Ay51Xo7LQhujjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quFNdvWm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quFNdvWm"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9aea40d799so89711a12.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786646791; x=1787251591; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Id7arB04V/7RPtU+f7zEwxheasZnCTG3qpfLV+QRi00=;
        b=quFNdvWmz5y+hDedk+a4cf3x/4uOUmx7xxv8xSo/i9jX9p4rJ3xX84B4PKAEvWSMij
         2aalCDWoUUX5iMcfKbpTYkNILG6g9uE6mgJHIz7ZfCvdySNRG7Ffm4UzFQNa1JgUbDMi
         NGz+XuPhPdslrKYnAybEtEQsTI0ioRHHoatpea9S0kUkhsAgPcQWgH9H2g0NhC4trk3A
         ODCILWqGbWKi+qwHbJHpEn4DEp/u4Sibs4B/TjTvVZReGnIWRQSttJtHMVuywGWSs9QL
         tXs5cJsZwCKkx9Nqug/4hoJHF/AvEFUJMEsDJCthvVLD/toy4TWNLPew8mGOPhkO5Xpy
         XfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646791; x=1787251591;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Id7arB04V/7RPtU+f7zEwxheasZnCTG3qpfLV+QRi00=;
        b=irHYKnsIqRFds8ywqnIMJOsXjnUOLMSbJluIizEa8rEQs9H5HDCu6a7oujdxFsGy1i
         gm9aLZuIREuDmrPbPvi40m3K0k9BmAj6nhAe/Jw3k45DhPocPEGQrnDx7S6E7EMgX62s
         4jUpCcvKfkxdewb34GxLECSI1SGHgLVkZGWxRzvgIHuJuk65lyqxMlO70f9etRGS0AGn
         3hvPVO4/tHa4NkCodRM7L0tq/PHBtxWogvupKJdi59SKizzv5vDNL8ab/hO2DeMWGtqo
         8PXTLAdKe5K/9TuAl6TPqjKQiDAY0uHuCRh1VB990u+fPOOvNZKdSUI8yXtQdilmiDDk
         9L8w==
X-Forwarded-Encrypted: i=1; AHgh+Ro65391+5zGX/6SPP2QdH9zBT//fuMCUhcBZENp/3tK1UHikKs+IzEtLyk8aqoqxOKQVE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGxUlShFIHp97WWjRDpJdrrP1YdAo5LkCrNrEQ1Z8+zca88ehA
	L5VwY9jc3Q+7SNfqA0yulNm3HjkNfjjkM/ccQ2VBCImMAJex9kN1q92j
X-Gm-Gg: AR+sD110TbTLPyUo3ou6ccRuf9/NKZrTQCGRo/chBUdO8M942NU+GswudpF70D5FOYP
	ZbX7iygab1R0JQaBfoKjp5zXclFCqP1QaAGvJGhGW6Nkrdvl5zVlwN1Y8neBcd7sm50x+pINzcP
	+DhgJC6w84uuPuUi0fErBsl/YGib2jySbtGRBh3BBsprhjTmrUgVv7lQRoPXvzthK+H2uKcXVmQ
	QfY6377F8UYHldYKRURFsx9l6Irvg3qbXsWFAHsXdYaNImdK1JSCAynAnwrE0g5joWEBt4AVEic
	MaToYeBCJCQphAu4DGcGMLyfqcQCOaaAMNXd63qHwp5VhtIrNvT6WTV82WWVg864rO88JC7/yCK
	eWULDyLWnZAfu22Y7WyOMKfa4BG6VqCkUxaGxu3mgsjBF373AhMpJ/T7WdrIYV1s5hbe7JYlD9J
	7k5YoeKIqiPlhiAt+uZFg8G3xaIn4yokerpBg2kNadlvLvfOmRzMG3X/XW3w7hLzCZonCKvq/mt
	H/MjsEi3ng/ej3Mx65+s/AQMHJUpGNKJU6RXARFFSFZOQ==
X-Received: by 2002:a05:6a20:4310:b0:3bf:6237:4d46 with SMTP id adf61e73a8af0-3cc553baf77mr9974523637.28.1786646790614;
        Thu, 13 Aug 2026 11:46:30 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31f15063cd8sm6854577eec.9.2026.08.13.11.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:46:29 -0700 (PDT)
Message-ID: <842785560c9f449a30eb6f07ee165eeded595fa7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 02/16] bpf: Add source and instruction
 diagnostic context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 13 Aug 2026 11:46:28 -0700
In-Reply-To: <20260812233326.3575958-3-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
				 <20260812233326.3575958-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 01:33 +0200, Kumar Kartikeya Dwivedi wrote:

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4a10c9878cf..7aad3bbed412 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -4147,8 +4147,17 @@ static inline bool bpf_is_subprog(const struct bpf=
_prog *prog)
> =C2=A0}
> =C2=A0
> =C2=A0const struct bpf_line_info *bpf_find_linfo(const struct bpf_prog *p=
rog, u32 insn_off);
> -void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info=
 *linfo,
> -			=C2=A0=C2=A0=C2=A0=C2=A0 const char **filep, const char **linep, int =
*nump);
> +#define BPF_LINFO_LINE_TRIM 1

Nit: a single callsite requires trim, might as well trim there and avoid th=
e flag.

> +struct bpf_linfo_source {
> +	const char *file;
> +	const char *line;
> +	u32 file_name_off;
> +	int line_num;
> +	int line_col;
> +};
> +
> +void bpf_get_linfo_source(struct btf *btf, const struct bpf_line_info *l=
info,
> +			=C2=A0 struct bpf_linfo_source *src, u32 flags);

...

> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -214,6 +214,7 @@ int btf_type_seq_show_flags(const struct btf *btf, u3=
2 type_id, void *obj,
> =C2=A0 */
> =C2=A0int btf_type_snprintf_show(const struct btf *btf, u32 type_id, void=
 *obj,
> =C2=A0			=C2=A0=C2=A0 char *buf, int len, u64 flags);
> +int btf_type_snprintf_show_name(const struct btf *btf, u32 type_id, char=
 *buf, int len);

Nit: the name of the function suggests that it does a printf.

...

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index ba57aabd399f..77dcffb9adee 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

...

> @@ -16,6 +24,50 @@
> =C2=A0#define POLICY "Policy"
> =C2=A0#define VERIFIER_LIMIT "Verifier Limit"
> =C2=A0
> +#define BPF_DIAG_MSG_LEN 512
...
> +#define BPF_DIAG_REG_DESC_LEN 512
...
> +#define BPF_DIAG_REG_TMP_LEN 192

dead constants

...

> +static struct bpf_diag *diag_env(struct bpf_verifier_env *env)
> +{
> +	return env->diag;
> +}

this wrapper is unnecessary

> +static char *diag_fmt_alloc(struct bpf_verifier_env *env, size_t size)
> +{
> +	struct bpf_diag *diag =3D diag_env(env);
> +	struct diag_fmt_chunk *chunk;
> +	size_t capacity, available;
> +	char *buf;
> +
> +	if (!diag || !size || size > INT_MAX)
> +		return NULL;
> +
> +	if (!list_empty(&diag->fmt_chunks)) {
> +		chunk =3D list_last_entry(&diag->fmt_chunks, struct diag_fmt_chunk, no=
de);
> +		available =3D seq_buf_get_buf(&chunk->seq, &buf);
> +		if (available >=3D size)
> +			goto commit;
> +	}
> +
> +	capacity =3D max_t(size_t, BPF_DIAG_FMT_CHUNK_SIZE, size);
> +	chunk =3D kmalloc(struct_size(chunk, data, capacity), GFP_KERNEL_ACCOUN=
T);

Q: would it be cheaper to allocate one page per chunk?

> +	if (!chunk)
> +		return NULL;
> +
> +	seq_buf_init(&chunk->seq, chunk->data, capacity);
> +	list_add_tail(&chunk->node, &diag->fmt_chunks);
> +	available =3D seq_buf_get_buf(&chunk->seq, &buf);
> +	if (WARN_ON_ONCE(available < size))
> +		return NULL;
> +
> +commit:
> +	seq_buf_commit(&chunk->seq, size);
> +	return buf;
> +}

...

> +static void diag_fmt_restore(struct bpf_verifier_env *env, struct diag_f=
mt_mark mark)
> +{
> +	struct bpf_diag *diag =3D diag_env(env);
> +	struct diag_fmt_chunk *chunk;
> +
> +	if (!diag)
> +		return;
> +
> +	while (!list_empty(&diag->fmt_chunks)) {
> +		chunk =3D list_last_entry(&diag->fmt_chunks, struct diag_fmt_chunk, no=
de);
> +		if (chunk =3D=3D mark.chunk)
> +			break;
> +		list_del(&chunk->node);
> +		kfree(chunk);
> +	}
> +
> +	if (mark.chunk) {
> +		mark.chunk->seq.len =3D mark.len;
> +		seq_buf_str(&mark.chunk->seq);
> +	}
> +}
> +
> +static void diag_fmt_free(struct bpf_verifier_env *env)

Nit: single user, might as well inline. Also, can it be:

     diag_fmt_restore(env, (struct diag_fmt_mark mark){})

     ?

> +{
> +	struct bpf_diag *diag =3D diag_env(env);
> +	struct diag_fmt_chunk *chunk, *tmp;
> +
> +	if (!diag)
> +		return;
> +
> +	list_for_each_entry_safe(chunk, tmp, &diag->fmt_chunks, node) {
> +		list_del(&chunk->node);
> +		kfree(chunk);
> +	}
> +}
> +
> +void bpf_diag_free(struct bpf_verifier_env *env)
> +{
> +	struct bpf_diag *diag =3D env->diag;
> +
> +	if (!diag)
> +		return;
> +
> +	diag_fmt_free(env);
> +	kfree(diag);
> +	env->diag =3D NULL;
> +}
> +

...

> +static void diag_format_source_lane(char *buf, size_t size, const char *=
source_prefix,
> +				    int source_line_width, int line_num, const char *line)
> +{
> +	int len, text_width;
> +
> +	if (line_num <=3D 0) {
> +		buf[0] =3D '\0';
> +		return;
> +	}
> +
> +	len =3D scnprintf(buf, size, "%s%*d | ", source_prefix, source_line_wid=
th, line_num);
> +	if (len >=3D (int)size)

Can this condition ever be true? scnprintf returns a value in range [0..siz=
e].

> +		return;
> +
> +	text_width =3D BPF_DIAG_SOURCE_LANE_WIDTH - len;
> +	diag_format_source_text(buf + len, size - len, line, text_width);
> +}

...

> +void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const c=
har *label,
> +			=C2=A0=C2=A0=C2=A0 const char *fmt, ...)
> +{

...

> +	linfo =3D bpf_find_linfo(env->prog, insn_idx);
> +	if (!btf || !linfo) {
> +		diag_write(env, "=C2=A0 insn %u\n", insn_idx);
> +		diag_print_source_annotation(env, 0, 0, label, msg);
> +		goto out_restore;
> +	}
> +	bpf_get_linfo_source(btf, linfo, &src, 0);
> +	if (!src.file || !*src.file || !src.line || !*src.line) {
> +		diag_write(env, "=C2=A0 insn %u\n", insn_idx);
> +		diag_print_source_annotation(env, 0, 0, label, msg);

Should this case still print instruction context?
(and the one above it).

> +		goto out_restore;
> +	}
> +

...

> diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
> index e8e4c06233e2..7b391cf49ae5 100644

...

> +void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const c=
har *label,
> +			=C2=A0=C2=A0=C2=A0 const char *fmt, ...) __printf(4, 5);

Nit: no external users.

...



