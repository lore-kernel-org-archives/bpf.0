Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D528499F32
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994191; cv=pass; b=SFPdeic3hcF5K4MIKq+UpUpGTivLmTvuZ8E0nQN7Jb+HL+rOI+y+J61DrcgUQW3SZd4PpmtDkzVrNpLtY4DVc1i+DNAuDg4mSbSQaHVCiC40gOQW/W1ZzK4Q/iaCsFXg1k7YdCPUP7/hTkIpAHloGJddNGPmJmiHrZoQGAvuzq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994191; c=relaxed/simple;
	bh=+7GvrFCTig6+XKh9XtZo0qryEmaVhb59G6kU9uLljlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8+32Z7cU89MNXliWt2ekqTa+N0AB8Zc8/IcBVD6e3vU+sQvEXOoGRNbi8LWPxkKrxrRZUMqHWIcPqGKUrSVH8PhMAcx6ynbqcrDBkV1cIL3BhsLp/uh37OnTkyM6ao/4StMMjD2kwSn4En73WYZUsYXriuZgJJxbR5W8AWvO98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kf36jn+5; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf36jn+5"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe7so428016066b.3
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 05:36:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789994180; cv=none;
        d=google.com; s=arc-20260327;
        b=WTvaZqXiCXaWWPXzcATEStJgq8r3wWA6ldiNzmfScWKrbazDXb1BImZy9IVoxJarNB
         Ut7nfBBDjtrBcUpRRaVKnzIR3lXCkXL556EC9Wti3pCY/LjFp0z/ZZKbfYpzISSjIXiG
         dSaXTyRwxEPw3BT3Aa5AnxMZvPPm16XDGvL5X4S4opb10r4jcUCMgJ4jG3/mKAPa+kN5
         fuyOZ7zbQuKwyIkknCVR/GwxpvEuPNkpDh1pd99RYRJEx0/B6Vf3XW6r6LhUy5mhypSb
         5NCu7AvqlDvIq0Dxmhwa9Vq04me5GSTc5uMqa6um++8opawEKEYMgJVzptvXM7Zayl8M
         pWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iz2b5wFy4VksNOEisfWzBUqWz1D5b0NsuKllyDNnKu4=;
        fh=JrhgCnAikvvfB7IDLxact1PMuBp3bg7HblfGMuGQIAI=;
        b=rNzy0r4R1l44bjJGWHIisdXjqQZ8adJzK4XoDUU9SyO6iaJ9/lkn59QH+OQtFqoB9b
         miQE0SDJ+wFaem3mMJgzP7egaB1v0jU+dr+mWdLfD+3ipUdwMmEF7inWmal8s5gqW6O+
         ya4ccGREKlxq5HKnophmPxGAVHKEeZWMXNFD1QgD8u0biChrZJ4G4Z6RbQpNz+NgRWhM
         j2e7YQUlEmnpAPYv/yuGMbzX5ytRrTBo8LXtx3JYoqG0WY0gw2qd/qKcNgU9vfRTCjf+
         ox25f/gPKgmEEvF7HU35VQVTuTLvc9vImvHypC49J+cz7FT7WTgRvht4v1Ee5LCsTJ1u
         ieeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789994180; x=1790598980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iz2b5wFy4VksNOEisfWzBUqWz1D5b0NsuKllyDNnKu4=;
        b=Kf36jn+5gK8PZdrszqofyjdUcZGzYuUwsLBf4vWu4QdaMEfYjPJUQJeypytW0hQW9Y
         +ic8G8XAJRsyZSyLX/fj0jEHfGX837WAia9xv9SIwXy8WNSsIu3D9Xnl1pua4aWIBVxS
         zmjgLDgMOgWXi60balkBOFI+KPjr+PO4Qlyqy3/Fbecrjx6ueGlhWAfNCWFTyLGrU3Ii
         DBpNpfdl/wfBbYdXYU9+W+488VoBhgUedEilS9/hxDxzg2NWAa7dJsbsePRlcB1fXlBV
         hCnOVazYz8EBK62h+FyALA0vUXUyD2C3gm+H0/yUs58O0tqjdEh6OtOnyXstY6V+85Z2
         o/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789994180; x=1790598980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iz2b5wFy4VksNOEisfWzBUqWz1D5b0NsuKllyDNnKu4=;
        b=jmpIqoRz991dRAkjHjW6OoCfJGtWz9nCCtKsCx+angvIsOuxM0EdKnTRDJX7QniQ6Y
         8kzR94y788vxMtgHIBdSEvwdQ6RfCJEzUgm5uH4MEQrnbVIy9WXxRN6yKlaFWAcZYW4x
         lYKN50Bv9e7w6iK33xFlxGj48Bvg5eTUrg4Uju4ceXZde/VMDiOXQdH+1oYH8C7Lvn8w
         ADC31lk2N2jxB+rLqVYPIbTdpR3ppgTfYZ2DhAW/9L9oyZyuAPoJMrI+d1uXpbI2Ckub
         +LsIYwtlM4+jY5MSgo+UoKo7NSJfh+o9BF/WXBc7cBLuZyUlV6Oev4WPigkhdgYNNx96
         +kkQ==
X-Gm-Message-State: AFuF++n7r4lkNg7IFR3v3hWG/U0UEE4mHKMofXLZeoJjw1sg1RNQG2rt
	1gpfeEtSte8m7q5U7r4B806rmUtfSIupkMdudxeLGTV1bLxfUVYkXn+u4xXKZ1fIdcf/xHmTxQB
	y29azc9EWXbK0ZDBlLlGxOnpcazxb5gs=
X-Gm-Gg: AYBFou1ACyhKxQAsRDgEMK39LlBOhd+6XbmATozmz3HbxNfs3OUH5LT9NIFOMke7C2F
	fAWHIOlTgT/A624DxoN+zdK+pfQXm42MeOu7k4IkgQHrrN0R98jT6aJfT7G17//HaUUPH/6XMPc
	EUl7qbM9MYWpsY3wTsKqsIJFJLSzJSJ3WGhYvF3aDsyTcjILSTn1YOei02jCPDww0arMkpipIb0
	hDSFz2IwJYVv1iDGyX6mAdxVSTrfJ//04ASHU4FBwjYdOW1KQR54ZuPM7+zMIOov+pw6kgwRCvS
	gZEWd+u3T66CaOQB0BrDSaIFrFzgFxxQb7n5oib+vIdvf7VxBSY7
X-Received: by 2002:a17:906:c10f:b0:c29:659e:2fd2 with SMTP id
 a640c23a62f3a-c2a157c1e2amr909879066b.27.1789994180391; Mon, 21 Sep 2026
 05:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921075855.2065871-6-nickolay.lysenko@gmail.com> <d158925eea4aefe908c98df2ef3afc65bb8f5ff522bbdeadeacd3728be864d75@mail.kernel.org>
In-Reply-To: <d158925eea4aefe908c98df2ef3afc65bb8f5ff522bbdeadeacd3728be864d75@mail.kernel.org>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Mon, 21 Sep 2026 14:36:09 +0200
X-Gm-Features: AcwNN1XfnC6y_2CfoCOgdpEbe0pvIHK6LRrJeEVM2RXRj-qWyUJqKxWx368D9nE
Message-ID: <CAMtxOX16wo4HifDbtsx_gnjM9rrxiptpWu3oO3GUdpzdsUpgRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 5/9] selftests/bpf: generate verifier/tests.h
 in a regular recipe
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 11:06=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 5bcb762dc3fcf..0e23cb5067776 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -910,12 +910,12 @@ $(eval $(call DEFINE_TEST_RUNNER,test_maps))
> >  # them (e.g., test.h is using completely pattern), that it's worth jus=
t
> >  # explicitly defining all the rules explicitly.
> >  verifier/tests.h: verifier/*.c
> > -     $(shell ( cd verifier/; \
> > +     $(Q)( cd verifier/; \
> >                 echo '/* Generated header, do not edit */'; \
> >                 echo '#ifdef FILL_ARRAY'; \
> >                 ls *.c 2> /dev/null | sed -e 's@\(.*\)@#include \"\1\"@=
'; \
> >                 echo '#endif' \
> > -             ) > verifier/tests.h)
> > +             ) > verifier/tests.h
>
> The changelog states that "its exit status is discarded" was a defect
> of the old $(shell ...) form that this patch fixes. Does the new form
> actually make the exit status meaningful?

Yes, it does. Previously, $(shell ...) discarded the command's exit
status. With this change, make detects failures such as being unable
to open verifier/tests.h for writing.

The commands inside the subshell can still mask failures from ls or
sed. That behavior predates this patch, and I would leave improving
it to a separate follow-up.

>
> The recipe body is a subshell whose commands are chained with ';', not
> '&&', and whose last command is 'echo '#endif''. A subshell exits with
> the status of its last command, so the recipe's status is echo's status,
> which is always 0. Concretely:
>
>   - 'cd verifier/' failing is not fatal (';' chaining), and the
>     following echos still run.
>
>   - 'ls *.c 2> /dev/null' deliberately discards its own error output,
>     and a pipeline reports only sed's status.
>
>   - sed failing (missing/broken sed, ENOMEM, SIGPIPE) yields a header
>     containing only the '/* Generated header */' line, '#ifdef FILL_ARRAY=
'
>     and '#endif' - a valid but empty test list - and the recipe still
>     reports success.
>
> In that case make treats verifier/tests.h as successfully built,
> .DELETE_ON_ERROR: does not trigger because there was no error, the file
> gets an mtime newer than every verifier/*.c so it is never regenerated,
> and $(OUTPUT)/test_verifier links and runs with zero verifier tests
> instead of ~1000 - a silent pass rather than a build failure. The only
> failure the recipe can now report is the '> verifier/tests.h' redirect
> itself failing.
>
> This is not a behavioural regression relative to the pre-patch code (the
> old $(shell) form masked the same failures), but it means the exit-status
> rationale in the changelog is not satisfied by the patch. Could the
> commands be chained with '&&' or the recipe be prefixed with 'set -e;'?
> Note the sibling recipe just above at Makefile:795-798 has the identical
> ';'-chained shape, so matching it might be the intent - but that recipe
> ends in a command whose failure is equally invisible.
>
> >  $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | =
$(OUTPUT)
> >       $(call msg,BINARY,,$@)
> >       $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/355776=
80350
