Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062123;
	b=XdzMa5DU08dvfs0QAXcWAEbrycH9S8yruyKmaUL07E9moTsNHK6IN2i2pA/Q9UIOWgAF
	 aYXrYOjsiUkQz98g1jwr8MnRrMrAynBrdGKNSFxMSf/EyPRaZr/xo5oRwjIu+35eKDGpt
	 d1fxSXpbY1PokBWr8bv9a1wgwPI3j2gudsTpJ9zv5dJusvOhQ5mEgn6OZJZL9ZySuayPC
	 36RSwdssjX6DMFx9w7sW4+H8r9KFSjH6extt6IOTYz3Kp7OHDkPozBUKlVsz+HjjQvFMC
	 H7gIsthP61qVkijvTC5ksiLi/XOIRRLPBhuWaoRr7/np+cQRf+UeLMLnAKVDojjt0Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062123;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=QoCsn1FDysxufh8tE5woBLo628qTdCf3YKfBRRH9TkQ=;
	b=SnNAtmt3jf6S3Rf+V3sDdxJIrxBrb4Phl4yvn2yH4slU6wmMRf5S24nKTd1LHuR3GVLp
	 7a4meYcmtqsvP8zyuotI19uLjxHXt+oAWLNKcrqJ965qhGfXAiCDr932dnbBP4IRh5deB
	 15/HrU2h2+o1TriJtQOj9wWAbW88aUWtNf32kANRG2FEktLg2O7gfdtCu3nbFwPQpn9+l
	 Lm+5ZELxEOEnt7O7Lw9aDSvfqTXR4/mOmpijyaRZurumewe8d0zXS/7YDpDaDrUjpuJZi
	 L58/GCzhhzheP/ZMXGKvY4Njo42t8wd4WC0XRxgSbGQTO70/CTRPfK0166I72f1kiSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuHghXUb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60360A6F54
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuHghXUb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88A61F008A7;
	Sat,  7 Nov 2026 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794062123;
	bh=QoCsn1FDysxufh8tE5woBLo628qTdCf3YKfBRRH9TkQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EuHghXUb066l3rFQ674AGd4Fl5poxUvDUTQ5BCxGnDZ2uYEiQNxVZNBOQYbvvC9zX
	 YufwmWk5ywzrU8pnU1WTzQW/97JgIq3dtGMd6w2rB6+S7uYsCOhDlFXwl5Zyg44byW
	 KkAU7n5EXYvIcU5fbd8zJ3lo2iSvx80izMaefHFJEM1NODo6xSH4FMjDnAWiCNRy1C
	 59QNvnhLYoNxzbCtq7uRdJQr8NKeAlU2Z79/nKZigUwMavzMFpSqOJb33QV8hg5Wka
	 wziHREjKfDY5GkqUewyqXlWbOjb/jQJDM+i+DPmv8Ojrmp3A7nwsIQTHCYIMhL93KP
	 FmwpwhizIvZUA==
Content-Type: multipart/mixed; boundary="===============1477288193622799869=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ee7aa1aa0fdd825777a5bf6e22447ceb87fc753e7b7c30a06e7f6db14bebf93d@mail.kernel.org>
In-Reply-To: <20261107135419.81491-1-shlomojune6@gmail.com>
References: <20261107135419.81491-1-shlomojune6@gmail.com>
Subject: Re: [PATCH] bpf: fix special field check with variable offset access
From: bot+bpf-ci@kernel.org
To: shlomojune6@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shlomojune6@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  7 Nov 2026 14:35:22 +0000 (UTC)

--===============1477288193622799869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: fix special field check with variable offset access

TL;DR: The wider special-field check in btf_struct_access() may reject safe
variable-offset array accesses (e.g. arr[i].val next to kptrs) that loaded
before; no reproducer or selftest for the claimed bug.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -8094,7 +8094,8 @@ int btf_struct_access(struct bpf_verifier_log *log,
>  		for (i = 0; i < rec->cnt; i++) {
>  			struct btf_field *field = &rec->fields[i];
>  			u32 offset = field->offset;
> -			if (off < offset + field->size && offset < off + size) {
> +			if (min_off < (s64)offset + field->size &&
> +			    (s64)offset < max_off + size) {

Does this reject variable offset accesses that were safe before, such as
p->arr[i].field where the array element type also holds a special field?

The step check in check_variable_offset() only accepts the access if
reg->step is a multiple of the array element size and the access stays inside
the array:

    if (esize == 0 || reg->step % esize != 0)
        continue;
    ...
    if (check_add_overflow(array_start, (s64)asize, &array_end) ||
        check_add_overflow(max_off, (s64)size, &access_end) ||
        access_end > array_end)
        continue;
    return ret;

reg_bounds_sync() keeps the register on the base + step * k line, so the
offsets reachable at runtime are min_off + k * step, not every value in
[min_off, max_off].  Each of them sits at the same position inside its array
element as min_off does inside element 0.  Special fields of an array of
structs are repeated with the element stride by btf_find_nested_struct() ->
btf_repeat_fields(..., nelems - 1, t->size), so the old test at min_off
already decided whether a special field is touched in every element.

For example, a program that was previously accepted:

    struct elem { long val; struct node_data __kptr *p; };   /* 16 bytes */
    struct holder { struct bpf_rb_node rb; struct elem arr[4]; };

    o = bpf_obj_new(struct holder);
    /* r1 = o + i * 16, i in [0, 3]  -> step 16 */
    v = *(u64 *)(r1 + offsetof(struct holder, arr[0].val));

Here min_off = 32 and max_off = 80, so the reads are at 32, 48, 64 and 80,
which are all arr[k].val.  The old test sees no overlap: [32, 40) against the
kptrs at 40, 56, 72 and 88.  check_variable_offset() accepts it because
16 % 16 == 0 and access_end 88 <= array_end 96.  The new test checks [32, 88),
finds the kptrs at 40, 56 and 72, and fails with "direct access to kptr is
disallowed".  Elements holding BPF_LIST_HEAD or BPF_RB_ROOT, the other kinds
btf_repeat_fields() repeats, are rejected the same way.

The SCEV loop widening from the same series (6ccf49f79327, which allows
PTR_TO_BTF_ID in is_widenable_reg_type()) may turn a plain bounded loop over
o->arr[i].val into exactly this kind of varying offset access.  If so,
programs that verified before the series by unrolling with constant offsets
may now fail to load.

The commit message says "the whole [min_off, max_off] range can be reached at
runtime".  That does not match the base/step model from 89e72f81a455.  I could
not construct a case where the old min_off test is bypassed for a MEM_ALLOC
object: unions are not scanned for special fields, flexible arrays are not
walked for allocated types, and every success path goes through the step
check.

Is there a reproducer for the leak or crash in bpf_obj_free_fields()?  If the
real problem is unsound step tracking somewhere, the array bounds part of
check_variable_offset() would be affected too.

If the full range test is wanted anyway, could it be limited to cases where
the step check cannot guarantee the same intra-element offset, or could the
commit message explain why rejecting these accesses is acceptable?  A selftest
for the scenario being fixed would also help.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42380405667
--===============1477288193622799869==--
