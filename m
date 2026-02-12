Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB318405C
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770856563; cv=pass; b=SPX2LlQTfEx0DHicKAjxlhX9fVXc9LQUMwc8noQgr01pQjwDCuqm+oZSLCAZV2PnaovSAWVXuRQMhlQCtZVuyESBXp+FQTrvYRHBw2xb/gjcTx+18+c72EcxtFUrsk88Nmqh2kPC24HnjVhtr1D20lRGJUkgqC+s3iMxAm/4VOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770856563; c=relaxed/simple;
	bh=XdAcy1RFVCA0eq2T/NMlU1dD9CXy+pSvKgYe0WCodyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBQyZla4HOUUt0tCeLKKwTR0LUrg/BmOHJPMLnWZ6hRP12NCzcFw0lf5h5VJmnKLygqWyR5czKsJLopIa68TUFvJqFVSrZH6263jUeR8DTUjTAA6h3OroP+QgwrhC0ADkmH0p5fRj9FvZLnP4AtPhlzASqjsQ9KK7f224RwsogY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WrusRRl0; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WrusRRl0"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8842e5a2a1so1136843866b.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 16:36:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770856561; cv=none;
        d=google.com; s=arc-20240605;
        b=S8KNJkup/xjOi2nP5cfqMntkjLtR++ykOve7H00vVRL24bYvMHYHSZjj/iujBS09V+
         jMsf4/BK2aa1naFhbw3k5PnJXSevNnk9negpKUYM71lzgDW90DhWaEkSLEU2kDSah5wE
         C1oU3y7LKjt3pru9ScpXWT49HkJVQ1Ayw219rvSgJapmR4E5ES89WqwLQt7rNbnztVEQ
         CK9VlrxtiBCV6AlS+sK1pfa5pl/cN/UR0hi7NX+2ai8CZHhv6ofPr3qrGVy5n6In4MkU
         +yGLNwgv5TqRlsSlT1dmhoPoKqjaJJW21bRgjkPm3v224uUR7a/qABfl7A79jxbCXYcJ
         KkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/qABditqdorMY8GlszRCaOVFO4i9AqMmA5efRo8ZvMo=;
        fh=tCmg0+ypVIBb5vnmHK5ko0PyBhSn51PFTP7uLhM0U+I=;
        b=US3gBgIQ3wT8DwHldiPLRLvJRkf2rHiwVCCnBlBes+sIBrWaA2Uihxj/oawQGgg7F+
         bI+83e/teN2uB/wdlGKNCq5helWFpXbfcg8O3a8cauh3wRdIXNJxzFB4MzY3sxX9yEVC
         6R+DWl/K4nZ/8OHtV9C7CIaZyJPk4f29rvUZHiAC+hbcYwjf8yLLxKHAJCxwacEuXEbz
         SMyDWxjaCuE7eLrR1VtT9GwOdpuui+gS3nzFxnx9uwun2UL7wdDTl/wu7f17YIPbTxsV
         uHDYdKK2mdKByib9oG8A5SabR9zm39/QWA/vixw75UKvTR8NyG5m5jqlyKgWZoo7Ne/0
         Ok4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770856561; x=1771461361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qABditqdorMY8GlszRCaOVFO4i9AqMmA5efRo8ZvMo=;
        b=WrusRRl08CltGucQ/i9uYwAQudsowEZGgNjcsyziBDI9hMZbwPyG1LshZ7ajSEnvvt
         Jg/BIuIKT4Hkx4J8plV+HPDfR8JATt+qHEqw+DXIKJrYrV6vB3SHnE5vCQOhaAD2MCNy
         HKK1kP+1s2Yl1+yjv7D15z2Ru6SK+V7XDE0OOOo8EQURH32AH9gKfKXQAJ8KGS/DNoFI
         Ig0mtNszbABjKY+oS5bsKKuncK0RUnqfk4P9o78hnNswyeilfud5nOEbPiZ7Wx6jXNea
         5e7GPGKgO7FmZuTw1+DHZoxFzJfwxid5nnzuOmwSb7Ki5EhP7S8Cxo9FrZC36IT8q4Mz
         5CLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770856561; x=1771461361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/qABditqdorMY8GlszRCaOVFO4i9AqMmA5efRo8ZvMo=;
        b=M6G+uc832dJ2w3yp3rBhEAtOhnu1fnYCzdMbwYH69K0tKLPgPPI3yp0zNSNnJGRTUS
         pAdfEfIvk78g7fBq9yd4ZeyVUsbFSFVmVnl7JFME4k4S0sGH4giYy4d/3FOBHoeYY7s/
         bRztE2DdvPORwDZXiP/RN6IOngt7+DqWnLC+PEcGuyUgiDMuhc6atl9mFo2UCTNkxEC2
         qEq8gf3zMACv3z4rZ6OPv0eARCF7a4+s2phtvhchtFQGoR6i8h7LfULTqD0U9H3/438w
         xtlGxYGr6YSGfiIuGLLMy7U4V/x42RrmcQv+uc/D1DITVE/BOukpoeTzxDihMKTnO806
         Pvvg==
X-Forwarded-Encrypted: i=1; AJvYcCW0UIeF20A2aKbqto6Yu0pCz5ZpeCtA7W32lhbZNsbtlWDCCqOqnp2br2IEP8Stx5ZcPTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzItfeBNTjymHZujFs8J6u1xz2kFzb6R49wLjhp+PXlbmcZUWTm
	D2arCE/yAVDeEGbF3cNki8LidtSKYPk85dmOH1/jd4Usnyi9hvgRREemjAS17yqSys/MkQwpp7A
	qsNeqfSyj08BQmOcvJTJ1SBwfRW99tF7tz1us0Dxe
X-Gm-Gg: AZuq6aKm0PEZU3W2rWyUFEINyG0K9jNs8WTc7onupFtr4pmokymjZC6RZHV1qyAy3eo
	I7j+WETrH9ZwCol2UObK4n4iYTOuH61pQ7QffjIdsX3qMo9ZQk6F0Fxm/0g/xH2VckUfHPsSB6f
	YyoBFNclc3Gn8zzjvnCXX8QCnCYafC/vAR7ajlpP3XDNofh2eWJpG/aGZ0LLR/ufat7bUoJbgFT
	jkG6NavqfpIkTuT9+84qOZAo4K1HFTRj8VKL7o+ncrSbap6RRJgOnlts3eodMiOzJRqA6vltKPO
	e2d32Y4fN2pN9eZWoyqQDCG5chO7mzQZwoM7Z3TLPw==
X-Received: by 2002:a17:906:4fca:b0:b8e:15cf:78e3 with SMTP id
 a640c23a62f3a-b8f8f8531a7mr45691766b.62.1770856560501; Wed, 11 Feb 2026
 16:36:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211235055.239024-2-wusamuel@google.com> <957536c0c710b7277d3fbc374ff4299bb38542e54de680aaa16d46e72c503e10@mail.kernel.org>
In-Reply-To: <957536c0c710b7277d3fbc374ff4299bb38542e54de680aaa16d46e72c503e10@mail.kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 11 Feb 2026 16:35:48 -0800
X-Gm-Features: AZwV_QhoQjc3qfgFkcvMcmU0GlRusAKXgy3l4Am8cmehf0eiZaDBQu0iu37yTrw
Message-ID: <CAG2KctqkkNF0aB3f0BmY-7us2DgHvGOpHvKUL9g8af0usz+Nuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Add wakeup_source iterator
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 4:19=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source=
_iter.c
> > new file mode 100644
> > index 000000000000..ab83d212a1f9
> > --- /dev/null
> > +++ b/kernel/bpf/wakeup_source_iter.c
>
> [ ... ]
>
> > +static void wakeup_source_iter_seq_stop(struct seq_file *seq, void *v)
> > +{
> > +     int *srcuidx =3D seq->private;
> > +
> > +     if (*srcuidx >=3D 0)
> > +             wakeup_sources_read_unlock(*srcuidx);
> > +     *srcuidx =3D -1;
> > +}
>
> Should seq_stop invoke the BPF program with a NULL wakeup_source when
> iteration completes? Other BPF iterators follow this pattern:
>
> kernel/bpf/map_iter.c:bpf_map_seq_stop():
>     if (!v)
>         (void)__bpf_map_seq_show(seq, v, true);
>
> kernel/bpf/prog_iter.c:bpf_prog_seq_stop():
>     if (!v)
>         (void)__bpf_prog_seq_show(seq, v, true);
>
> kernel/bpf/link_iter.c:bpf_link_seq_stop():
>     if (!v)
>         (void)__bpf_link_seq_show(seq, v, true);
>
> The __wakeup_source_seq_show() function already accepts the in_stop
> parameter but is never called with in_stop=3Dtrue from seq_stop. This wou=
ld
> allow BPF programs to know when iteration is complete and perform any
> finalization (e.g., outputting summary statistics).

As noted in the v3 email thread, I don't see a current need for
additional handling at the end of the wakeup_sources iterator.

> > +static int __wakeup_source_seq_show(struct seq_file *seq, void *v, boo=
l in_stop)
> > +{
> > +     struct bpf_iter_meta meta =3D {
> > +             .seq =3D seq,
> > +     };
> > +     struct bpf_iter__wakeup_source ctx =3D {
> > +             .meta =3D &meta,
> > +             .wakeup_source =3D v,
> > +     };
> > +     struct bpf_prog *prog =3D bpf_iter_get_info(&meta, in_stop);
> > +
> > +     if (prog)
> > +             return bpf_iter_run_prog(prog, &ctx);
> > +
> > +     return 0;
> > +}
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/219279=
83378
>
> AI-authorship-score: low
> AI-authorship-explanation: The code follows standard kernel BPF iterator =
patterns with no unusual characteristics suggesting AI generation.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Missing end-of-iteration callback is an API c=
onsistency issue, not a crash or security problem.
