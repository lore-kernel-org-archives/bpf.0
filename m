Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FEA1B4257
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 02:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611169; cv=none; b=CHO92KJBKODJiJBV9Mz8yYjJkhPTb5bV2YSrHI1SrWD4Jstdy4yKmAkjHryOVyUYFBmw40JDVVDc1cT4dEw5YWd2KVkwon89ThVFRLYNKKhkKgwLwb0vjqem0Pwwj9MrsUXQ05WmnUXr6bhij/hIO5WINmv8lv6ohAPIMFJmQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611169; c=relaxed/simple;
	bh=9uQjKc/CDrkkvVrbFda2bCwyl3LeRxPoIqAgvhHdyB8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=pWJp7VvO0uNtIuArBspbFxxbZBc+rGz2wSyuOsdEwpqkgj4iusoG9U1pGwO0HLJbriWBoQp8PuCLQCgOFA+ogJtaZwQNad1TdlxS5FUFhV0zmiJhydG/bq1lJVC8UPKVwEC8/ArjGfGdNxgnIHU/a5z88xXK8R3qORUFNAm9iDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO3gxvRz; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO3gxvRz"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so273062a91.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789611167; x=1790215967; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=06zoYhBtUhN9BYmhhkdktVcpUI8fN0gSQ+J4O95dueg=;
        b=EO3gxvRzdUOkFDy+DfSFO7/szNCCH72HDaXPTRGN/oPUvu13C/a//cvDUK8FXQSCg8
         No1xxrPqwdvAwdHk/zQed9XRuZXiTSKlqWoj6/MqhatV3WXlHqQJemLpOy7uw740u2wt
         7pP/YvT4bydaPgKaF9mLmzJKShNllf4OshMz2WZBPVXhIw4D9aaPaO7wwrwrKCrdKo0X
         oAIkPHjCXdK5ico179Re8/1dz8QlqDlwsfWIchJ/m3IaA5fU8RLUxUR7fYGogQSCeS2d
         iAqeEKM+VcW5E4XQ6R8X5ETAf3p/7RoBPc/ZR0Tfdp9lpB+2qPT3GXi2Sl9ezYWZd5uK
         FucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789611167; x=1790215967;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=06zoYhBtUhN9BYmhhkdktVcpUI8fN0gSQ+J4O95dueg=;
        b=Y9LhJBcu5oEE6EWrZjnSUb/7tmgXyw1RFUTZNBCotjfjLayHkvDMtV3XS2M6tc91iz
         diGTrJEQ2++MjmnMyCiobzUvxs2wucxMeLbk4LtXYm9Jele1SuBckUJtGtzVT2Bacpv2
         rPTcBltBSGY4deRCv2qlJwlkd1qqRuOmTe/L+ospL9svUKcF1DUo5E42pnK0kYMLQG5B
         RVdNMmLnWUlkK7KVFCcfPI9tJck2QtcOO+2SjQWdIPxbUjQ/cZb8o7pqt3Le5ezwwJ9f
         +yKWav1xCC/X8py9jWgd9toNV42d8CicbIIyCgNeJJtdhpzMrMO6jNKiv3Kha3svi4aF
         vpTQ==
X-Gm-Message-State: AFuF++mNXPKE/1fc2h6QVwH+bOqAqiyznCXYLiEfgK1N6GyRCf6keYsH
	9K7cbYnWl9GqzUrKxq/d3ocpZjjgA3fbcHED2bXRAgpr16F+sZRRWXkh
X-Gm-Gg: AYBFou3fWHKRo+dJ/MWoJ7FYVhO9Ij85cnWa8RRAkWpt+K8cca0KHqo+ifXa/KgUh9V
	Qxv1Vg/gpvfAjg/VcZhOcjdtJ6RHvzjdIPzmO/jqvRtdeHNoeU000tgZRdcORZt4lbZMPwWJM4b
	q3KZ63no9IAjnAyS8lfESI3ufvD6vxNTW7duXFeE+8VoTl3SfcSg4BqsQC6AgUerQLpcvWw90F6
	LJAd+m6uiVftCjZiJmAkEMq96TdbYc9QpDtC4+PYegt+8Z5GZaUssnXWt24aUUn9jaWaurj39Xs
	SaQ0O6HI8NM3mRkZRjtO9+KPJhknwtCRmTpv4TcZKylpQZCygJexZOEtxnXioAlKATe2jDxDOPp
	O4q4Eom+dium2VQE+2pfgcx+vxX9JcQl3u4GTqHtptkc7LgWO+mP9L+QFpvIdRxCbmlXJr9vnjX
	sLrZLATr/49Ho2ckWLW9B+OxMWM6rh1oe4qBoiBFa73gBitiI39OudU0Stebi7+xA1JWZIV/e0k
	PZpqr9Ij8C3G/NsFOv5EiFrPoOv6n2MZwMwtvG6e5VkhQ/iW++t25BJ/hjSVeSh7/whe95m60hZ
	3IWC
X-Received: by 2002:a17:90b:2885:b0:398:d132:ba76 with SMTP id 98e67ed59e1d1-39e1e502f25mr11653021a91.21.1789611166697;
        Wed, 16 Sep 2026 19:12:46 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1c4ac8cbsm2099570a91.2.2026.09.16.19.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 19:12:46 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 02:12:45 +0000
Message-Id: <DLH87NTSTNKF.1GYVTW5UIE63R@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 2/4] libbpf: Render decl_tags in btf_dump
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20260917012037.1396254-3-ihor.solodrai@linux.dev>
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev> <20260917012037.1396254-3-ihor.solodrai@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 16, 2026 at 06:20 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> BTF_KIND_DECL_TAG is an attribute on a declaration: with kind_flag=0
> the tag name is the argument of a btf_decl_tag(), and with kind_flag=1
> it encodes a complete __attribute__.
>
> When doing btf_dump, render both forms at every declaration btf_dump
> emits - a record, a record member and a typedef:

[...]

> Every decl tag in vmlinux BTF is a bpf_kfunc or bpf_fastcall tag on a
> FUNC, which has no declaration in the C output, so generated vmlinux.h
> does not change.

iirc the goal of this series is "bpftool btf dump file prog.bpf.o
format c" and skeletons growing
__attribute__((btf_decl_tag("contains:..."))) on members.
Pls say so in the commit log.
Otherwise it's 200 lines of code for "generated vmlinux.h doesn't
change".

> +static int btf_dump_cmp_decl_tags(const void *a, const void *b)
> +{
> +	const struct decl_tag_desc *x = a, *y = b;
> +
> +	if (x->target_id != y->tar
get_id)
> +		return x->target_id < y->target_id ? -1 : 1;
> +	return x->tag_id < y->tag_id ? -1 : 1;
> +}

nit: return 0 when equal. cmp(x, x) != 0 is asking for trouble.

> @@ -220,8 +258,18 @@ static int btf_dump_resize(struct btf_dump *d)
>  		err = btf_dump_mark_referenced(d, t);
>  		if (err)
>  			return err;
> +
> +		if (btf_is_decl_tag(t)) {
> +			err = btf_dump_push_decl_tag(d, i, t);
> +			if (err)
> +				return err;
> +		}
>  	}

\edited robot voice

On either error d->last_id is not advanced but d->decl_tags_cnt keeps
whatever was pushed so far, so the next btf_dump__dump_type() walks
the same ids again and pushes the same tags twice -> duplicated
__attribute__ in the output ?

pw-bot: cr
