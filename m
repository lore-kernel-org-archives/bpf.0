Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB613D1CB5
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695434; cv=none; b=L8vCAj/v9OhV75eljQMdHYG1g7XSz63SrPpYisNBoVZKmyX+9VyS3b+GSCHzvo37d6sAfnNPLJ7HysxDMhh9Ks69OvgmCKD9vNZeU7aWUdGT6jDN8GsG2BqyDK23GrGmUICR0B/6MTq0AiYTHRIaQuAh49FAyn7rtzcm9s8lfnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695434; c=relaxed/simple;
	bh=O6NE0dQWkmUmTIO6UnYAozfUFrvDOgUvXEav4Qej7+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=USqglvthvC7e8EPYgl7fu8s6UYafohHB54ZPPmiaoyH0kSp4SIac59jsb5A0FkR50R7q5DGg5TgPBdleLj/9hHvcortRyPER2AYv6NtTQz3LSVkBOEIT13nwje+x03waqsG9Ok2vqsGidA/HkCLPzzQ1U7Nitmfmu5cTN2rfSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1xXm7/W; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1xXm7/W"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-137dd5161feso5086916c88.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 14:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780695432; x=1781300232; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KEGBj4FpvWWj1rv/WQcKtR0ehnNj5xj17BAtDHOpU44=;
        b=C1xXm7/WBeD3x3g0cMQmvYXy564wrmftmt4iM9J89ODd00upO1DvNKyt0LW7hazhIo
         8+RRG5NDXOc/5vpt330JFGlK/ctCRgGMWKJOJMJWqSYkbfHzA1bc9T5gKtOdEum5fiON
         nBeE3S1Q4fW0UgHNFsEkXdWgs3QkJRTdIvCaGCgXS28D1OT7PVoaup+aa4PLoNJsNkSb
         eldxKcdvpNX/extvvTRK/QquZEJ7mcxA90Mbtvv+qjxcQN18PzNnVCB4W9iH7U594iOw
         ONs1BGxXJaXeMO0EW2ei76SsZhu9hFLdcrN7Yr43CCmGPjvAe4sxaq7kq0BEdRR8q5xS
         BCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780695432; x=1781300232;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEGBj4FpvWWj1rv/WQcKtR0ehnNj5xj17BAtDHOpU44=;
        b=lr/yeIODl+XOqbDDx2qT8OuhMm9ti22SJgaah+f7GzOUBhIZ9tkw01ysAknosRWh3j
         nhrQkSCVYI+G9Id+EP0n+rxijmtuv+6Rj7it5v/wDiB7OFUQOG+x0Bs02poj1STuHuc0
         H0RpBGzjhoHqgnoq72U8Wse8KjsIxu6PgvzW8N6FDZKH97pdypscu52vHvwjXotmMMiv
         i8KW5f/3GadaSvuu1ZeQcO1FhgjINecjg1dda0HK3kRvUIDtlUwhaWXRixe5B2rBjh3F
         YcD040iQL2k22FThiKB9WMQvAWH70GFfzZaMZ9fAqi/pvSWcRWVu3LCtmf5MioWqD7AI
         cE+A==
X-Forwarded-Encrypted: i=1; AFNElJ9jDrKXMxEg4rYgJr+9WGZzvy5/1+QS804JmnQf+fKqZQDx1WAD9iD4fu1IJ3xkcSRqNX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrVXMrosGH4TM6RjA56IHoFlE2H/Opc3AN+hjunwZH+8rGOtYB
	FPpdDQr8X5eyZUeVwZCZaxq5j8lCltSuKvXvkl28UJ0/QmEMALDR8JhF
X-Gm-Gg: Acq92OFbtaKTuljggEsyDJ3uiB5NfLQr7jlNQwvmqPGgeXNgKkHAUfmNWeMPdfVzpKt
	WBE5h01qLIUsKVLG3q4Rr16KlJh6UgTFeBy1GrLKW4dh0jZBIqKahEFBwUZAFaUjGjKKT/83yh6
	rcjBUo6pqbzYx+d59UNidJFZ0RBGmljkCe868ty3vGND20WYdbrhioqC+MMfhtfrJoATGdxGZ6l
	c22dk32wFMItpYi7Ux+7Yr6PEgOSEWxCsFZ1oTkremttjdfosjI3Rs+sisvgZ4ksicDMuQncT0r
	43fO7Yvi4nOlkv1GDWrXNC3PNChL2QI1J5atlr0yMxPLIfnG2wM7wvqJuYxKI7bZFQ8sxctszK5
	O/jGJwueVCIQlJ+nNT3iX32muzW5mxyTaGMvYdx8WwMpnu/8H08KLCiRLIVVUNzTaI1G2ggquQj
	xcFB/SQC5sXKcyEtllGPfhBVxxPL7qwIUbM0gyUA6luyaKaPxdMT0IUVQkIu3oj3S2S1VMtjQ0Q
	1Y59MLLckb/H7Ps
X-Received: by 2002:a05:7300:cc0c:b0:304:5a9c:6452 with SMTP id 5a478bee46e88-3077b1d710bmr3124030eec.17.1780695431906;
        Fri, 05 Jun 2026 14:37:11 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5171:6892:c6a6:f1b4? ([2620:10d:c090:500::8271])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e8csm8868497eec.16.2026.06.05.14.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:37:11 -0700 (PDT)
Message-ID: <f349704ed7986ac8ff35475988fcb9e98237df5d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 04/17] bpf: Track verifier branch diagnostic
 history
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Fri, 05 Jun 2026 14:37:09 -0700
In-Reply-To: <20260605063412.974640-5-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
	 <20260605063412.974640-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 08:33 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> +void bpf_diag_clear_history(struct bpf_verifier_state *state)
> +{
> +	kfree(state->diag_history);
> +	state->diag_history =3D NULL;
> +	state->diag_history_cnt =3D 0;
> +	state->diag_history_omitted =3D 0;

Is diag_history_omitted all that useful?
It is used to print this:

        if (state->diag_history_omitted && start_idx =3D=3D 0)
                verbose(env, "  ... %u earlier diagnostic events omitted by=
 display limit ...\n",
                        state->diag_history_omitted);

But this does not seem to provide an actionable feedback to the user.

> +}

[...]

> +static void
> +bpf_diag_drop_oldest_and_append_history(struct bpf_verifier_state *state=
,
> +					const struct bpf_diag_history_event *event)
> +{
> +	if (!state->diag_history_cnt) {
> +		state->diag_history_omitted++;
> +		return;
> +	}
> +
> +	memmove(state->diag_history, state->diag_history + 1,
> +		(state->diag_history_cnt - 1) * sizeof(*state->diag_history));
> +	state->diag_history[state->diag_history_cnt - 1] =3D *event;
> +	state->diag_history_omitted++;
> +}
> +
> +static void bpf_diag_append_history(struct bpf_verifier_state *state,
> +				    const struct bpf_diag_history_event *event)
> +{

Maybe make this a circular buffer?

> +	struct bpf_diag_history_event *history;
> +
> +	if (!state)
> +		return;
> +
> +	if (state->diag_history_cnt < BPF_DIAG_HISTORY_MAX) {
> +		history =3D krealloc_array(state->diag_history,
> +					 state->diag_history_cnt + 1,
> +					 sizeof(*history), GFP_KERNEL_ACCOUNT);
> +		if (!history) {
> +			bpf_diag_drop_oldest_and_append_history(state, event);
> +			return;
> +		}
> +
> +		state->diag_history =3D history;
> +		state->diag_history[state->diag_history_cnt++] =3D *event;
> +		return;
> +	}
> +
> +	bpf_diag_drop_oldest_and_append_history(state, event);
> +}
> +
> +void bpf_diag_record_branch(struct bpf_verifier_state *state, u32 insn_i=
dx,
> +			    bool cond_true)
> +{
> +	struct bpf_diag_history_event event =3D {
> +		.insn_idx =3D insn_idx,
> +		.kind =3D BPF_DIAG_HISTORY_BRANCH,
> +		.branch.cond_true =3D cond_true,
> +	};

This can be recovered from the regular jump history, but let me read
till the end of the series.

> +
> +	bpf_diag_append_history(state, &event);
> +}

[...]
