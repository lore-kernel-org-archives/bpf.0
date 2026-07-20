Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1A1A9B58
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784511320; cv=none; b=rBK8T7Wu/MfBPbZwpZt+MYLv+Kiq1msUHoPmcoERTiZjeKB0McuKLYqUlCbmaGnapU3EJAkg4lgA1aA+0dhP/S2Q/6EAAqCFbViAusEv3/BG+bQEWstBmZ1A/gHxh2XeQHe7AYSVH7H6AztfeZRspZo+q3SJqYdacgO87q1B+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784511320; c=relaxed/simple;
	bh=DvmKQSAicfcl7VwyQpb1Ng04atmhpE7lUJaU54pjk3U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DTF8ZRYdlNRx7l0NkaZgYEI6d35iVik1V5D2R8Q563WmsnDS3qN4D9woguVR/fiTitqi0n9nuRb0tn8sNZM0rEySZOtEbBCdjEk1oHCb4TeTEw/583pDC0PDNKqqZvo7Dy42fo3lisjE2TajEuoc4BXNew7cbEaI71Wj8V4zZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9Qi+IWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9Qi+IWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE771F00A3A;
	Mon, 20 Jul 2026 01:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784511319;
	bh=AqvSmHU3u+RfU/HdSYzyqwZ99hwI4baCiwhxxd+GsUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E9Qi+IWPEbywmIt6riKESpbU0EjjUNrcJKXFr2v85ubn0EKLUms6tcPnBZtFqFZGX
	 QS9Uhtz0rkrakD4xQvTWeAGuJnTB34WdG49/3SmVyotA6roWwwLIfbrA+A6Wkem9Cq
	 XFgRb0ivr5a2WXc5tl212jftBNafjhoNr2jjMfzBmdc++Tg5QJniCZug3QEZaAhKWR
	 +aqw0W91I9tqmuNDiExxlAiZdo+HJNYf/SbW9JipIbSmzcBtK7JnzwsAepWzmpfRxR
	 EDt3qzPbMrKMpgPcokXGzzGwAffiPaCQ1nOGrHoN3HnON3Tz/c4vm8ky8C6hc/eYLW
	 HKAEYdi2oNaXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: roll back stream capacity when allocation
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianlin Shi" <shijianlin11@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
References: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 01:35:18 +0000
Message-Id: <20260720013519.3BE771F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch addresses a capacity leak in `bpf_stream_push_str()` whe=
n stream element allocation fails, but entirely misses the identical capaci=
ty leak in the staging logic (`bpf_stream_stage_printk()` and `bpf_stream_s=
tage_commit()`).
- [High] If copy_to_user() fails during bpf_stream_read() after some elemen=
ts have already been consumed, the function returns -EFAULT instead of the =
number of bytes successfully read, resulting in silent data loss.
--

--- Patch [1]: [PATCH bpf] bpf: roll back stream capacity when allocation f=
ails ---
commit 06c82cbb65aa09c192205a6718b0fa398300f1ac
Author: Jianlin Shi <shijianlin11@foxmail.com>

bpf: roll back stream capacity when allocation fails

The patch fixes a stream capacity leak in bpf_stream_push_str().
If allocating a stream element fails, the previously charged capacity
is now rolled back to avoid permanent exhaustion.

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index be9ce98e94692..4b8a74b9162e1 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -79,7 +79,14 @@ static int bpf_stream_push_str(struct bpf_stream *stre=
am, const char *str, int l
>  {
>  	int ret =3D bpf_stream_consume_capacity(stream, len);
> =20
> -	return ret ?: __bpf_stream_push_str(&stream->log, str, len);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __bpf_stream_push_str(&stream->log, str, len);
> +	if (ret)
> +		atomic_sub(len, &stream->capacity);
> +
> +	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but it seems there's an identical
capacity leak in the staging logic that this patch doesn't address.

In bpf_stream_stage_printk(), ss->len is unconditionally incremented even if
allocation fails:

kernel/bpf/stream.c:bpf_stream_stage_printk() {
    ...
    ss->len +=3D ret;
    /* Exclude NULL byte during push. */
    ret =3D __bpf_stream_push_str(&ss->log, buf->buf, ret);
    ...
}

Then in include/linux/bpf.h, the bpf_stream_stage() macro unconditionally
calls bpf_stream_stage_commit():

#define bpf_stream_stage(ss, prog, stream_id, expr)            \
    ({                                                     \
        bpf_stream_stage_init(&ss);                    \
        (expr);                                        \
        bpf_stream_stage_commit(&ss, prog, stream_id); \
        bpf_stream_stage_free(&ss);                    \
    })

Which then permanently charges the falsely inflated length against the capa=
city:

kernel/bpf/stream.c:bpf_stream_stage_commit() {
    ...
    ret =3D bpf_stream_consume_capacity(stream, ss->len);
    ...
}

Should the staging logic also be updated to prevent permanently leaking
stream capacity when memory allocation fails?

[Severity: High]
This is a pre-existing issue, but I noticed another problem related to how
stream errors are handled in bpf_stream_read() when copy_to_user() fails.

If some elements are successfully consumed and freed:

kernel/bpf/stream.c:bpf_stream_read() {
    ...
    bpf_stream_backlog_pop(stream);
    bpf_stream_release_capacity(stream, elem);
    bpf_stream_free_elem(elem);
    ...
}

But a subsequent copy_to_user() fails on an unmapped page, the function ret=
urns
-EFAULT unconditionally:

    ...
    mutex_unlock(&stream->lock);
    return ret ? ret : len - rem_len;
}

Does this mean the successfully copied elements from earlier loop iterations
are permanently lost without the reader knowing how many bytes were read?
Should it return the bytes successfully read (len - rem_len) when some
elements were already consumed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_E69EAE29327=
E25B3548A9AF3F4FA289A6806@qq.com?part=3D1
