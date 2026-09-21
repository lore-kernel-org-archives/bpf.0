Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B437187B
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992534; cv=pass; b=cpSDnyunZ3Ww/70ygxjjH310dQaZcx73+b0D8ZvO+amZzOF+lNkWXrGoJTuUMZCxIZeoc/U+6eFBUtPYgDeKJB5URmZ71zXg5RHwBSTJG4pce+blAvZH40f3wD/TFDSpar7yCZRAmWgZqyGbo8nQTNKJNKK0nAenAMFu0SK2v4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992534; c=relaxed/simple;
	bh=nTL55pcMaNLKLuZdwx7U/b/190WnttgtvN/xvHoGnlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTmusI582O1ma/P5ySn2DV2bwCM8MFbjXZLKs7edLuqSD8JFkOSveDarYz++bSq0Bg+uJO1ACkv2N0Qv/79YFHeB7kAKF8boqUbUWUSL2m9gYiKFfLgdv5K9+8GkSyH671T7MFGZ04OPpZ5U9vFDdKx9I7+vJWT7dkNscR3bNGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcI9FPJ6; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcI9FPJ6"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efebso425641666b.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 05:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789992530; cv=none;
        d=google.com; s=arc-20260327;
        b=TUj6xIjWhCCaMYfYa4fv+/mjBukpKr5H73OFAe86VXoWZDPpUdFj1T76HUGc/y+RWi
         YhwNFdiIVwgP5g8PFJ2qEsOiteiCOFLIIzn1T9UhawQqYjpUfAdBiSQ1ApAzzha//CnW
         /YM2OS3xAnz1BPWH7fRkFyWFarUnKCH00m+FGrk2P6q34Q5bG4R0SdjGJNuVsRogVaDZ
         vvz+e9mgGO8nZMq2OIuJxMx0uGUWK01Xg8UUC8SE6u8gockZBel3oN0xiRzg5l97Kmag
         prq86cGaqgwzOM0lDpM8Nv/JU3YJNeS9mWj7zt8HlK2ZAirrT8jsyq9arUdKrFWOBqcl
         50vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I7e6mjeZBiYO82jtnP6Vp/Sh1fwCrRa9XA8DT/8mPok=;
        fh=JrhgCnAikvvfB7IDLxact1PMuBp3bg7HblfGMuGQIAI=;
        b=qYZCIEISxft28t8cZRIvgWeOUrMUoMB4oAh8pbe/zO3myEmSI9m1gqQyPu1ITQOLZa
         bP62sn6ue5NuPcKYRHAZC+Bk2XAK+HYl+MDjMODHUOi+kAnCaANquCyLzKDkqP0FEZtn
         C9hXbMmUNEPgC6/brxAt1MFX0xPosfE72gvOP+RcMMDOu2l8NSchK8lHjbfmELqSp6vg
         nKBuHcHhSioAl8CmtEzP9uNyGyjOGXuZD88Pcx7D8pR1LReK0GdNK55I+ITsEVzt23NJ
         HhPbwCMBS7xoEYfzRdCvikiw5YBphIp9D09UJQsyIe8YZTsFYX9/Cd6AOnjWecDtlAAG
         1U5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789992530; x=1790597330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I7e6mjeZBiYO82jtnP6Vp/Sh1fwCrRa9XA8DT/8mPok=;
        b=RcI9FPJ6IELB/Xf1asx8ZnwYQpWgbVaWTqGRPyd58Oy99ryWffFxaWa884PniEz6n9
         TfcEGFAt3rr8Gh/PRK3+wUj8k8DpUdA+h321bKWqoH54pMyMJLH4+TAdcubvt9/VxyV5
         yu+J0yXOhG1JgkYo79AchxGKhrPbpIcwdJOxlqpA4b5XKxrsiWUm2PoX4iL6NhzcHyvS
         8wXvsjJylzpAXdBFuzYNhsDn6Jxur4eU2GfMpsYKTwGDf4Lkm7ETtPdHsndaGsbC7bNf
         ow3Od6OXmauThy1sehcDwV6o3FnSHq+tGiuq11BmKA6uIZKl9gquJvN8XaaUnRj6N2hv
         wPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992530; x=1790597330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I7e6mjeZBiYO82jtnP6Vp/Sh1fwCrRa9XA8DT/8mPok=;
        b=MnPAkT1LqI8vnlXayY0kifaVKzJeer5nQuXvM2UxBsoQKg1Prgg74RTYG8NQX1PROd
         arn/fk+7lBeALkgoBlrvDv1CEmGeDzEO0DjuPtVJokbTWS9VpyZQTaK/acN9ujTgVV2C
         C4wY51oxPcI9cjv8b4NxQysvsnqZPEhX9Sd+pU7nd+jm5yrzXfEOA19ABnXFCFfAuHHq
         YIa+NFr5a8kbjNCQWXukCtwVHTGDVAmjskSk36kyKXWXFujVG9aryyDw0LY3cJHU/98b
         w8pXIrb0tWUfA1PQ9arklt1xNbwUpOegUm2db7/Sk8BcbQc6pYwVhRZ+gV1sV7py/XUC
         qXFA==
X-Gm-Message-State: AFuF++kwb0JYQEA3NvqlDfXy/XFbjX8M7LQ9sluUwpRoIiB+Enr9V0Xt
	2rtnFAlAnV117xKqMBQ1nKIQh19PUVjEH390fjqj/tqvlU9Fqswn3HZerM79RHO2LGGpdEtGOYV
	BZJvSKHUZ9FyhsV5my8T1128LgfX5e8k=
X-Gm-Gg: AYBFou36ZPh80Lp6d72C4zEmHHMz1n3gIUnR6Vk0V+bfSJN8dqe68GeF+wb8DdPSFMk
	8dReTeVmStvBcvof7rPJCGLgfFSKOKBSpm4EyYzkqfLjqXIEKZA7JRG9HkBdZilca5+yaPV0xIU
	RNhWojgkBg3OaY+cAFbGl1gjPYq/sembQMBQCyunz2JXYu1+unNF5Q2DSLNm1UQY4H6x4Oe/IEe
	3mEsCzSRSQbOu/qXusET19BhnbTjEQZSqVQWogmmubrfsApzbZXhNFRkBTPiS52bwD1zmRAR3+e
	a2tRJA5w892BH2PIa2jnXmvc03TOhsFYsgQMMPDuX2vat3/BLnzc
X-Received: by 2002:a17:907:d07:b0:c26:1691:b374 with SMTP id
 a640c23a62f3a-c2a15827d9fmr877116366b.45.1789992530256; Mon, 21 Sep 2026
 05:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921075855.2065871-10-nickolay.lysenko@gmail.com> <a242ffd77138377c8726e5a7e52609fbe0352e8cc4a3b9efe48eecf566057cc4@mail.kernel.org>
In-Reply-To: <a242ffd77138377c8726e5a7e52609fbe0352e8cc4a3b9efe48eecf566057cc4@mail.kernel.org>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Mon, 21 Sep 2026 14:08:39 +0200
X-Gm-Features: AcwNN1Wr_djsZlN1GvrelH71pfyuPeBwRUCUbYcqgP5rkd7hl8AAcS6H5IhoTB4
Message-ID: <CAMtxOX2J_GWH4QhQmpvbGdEjRV7fkhgM9NUKL0BbPqKsFpfs-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 9/9] selftests/bpf: build each test runner
 instance in its own sub-make
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 11:22=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testin=
g/selftests/bpf/Makefile.runner
> > new file mode 100644
> > index 0000000000000..d266c42468882
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/Makefile.runner
> > @@ -0,0 +1,125 @@
>
> [ ... ]
>
> > +# Permissive build behaviour (skip-on-failure compile, partial-link) o=
nly
> > +# applies to test_progs and its flavors; runners that use strong cross=
-object
> > +# references (e.g. test_maps) keep strict semantics even when permissi=
ve.
> > +PERMISSIVE_TESTS :=3D $(if $(filter test_progs,$(RUNNER)),$(PERMISSIVE=
))
>
> [ ... ]
>
> > +# compile individual test files
> > +# Note: we cd into output directory to ensure embedded BPF object is f=
ound
> > +# The %.test.d dependency files are a side effect of the -MMD below; t=
he
> > +# separate no-recipe rule for them orders the first compilation after
> > +# skeleton generation and re-orders test object compilation when heade=
rs
> > +# change.
> > +$(TEST_OBJS): $(RDIR)/%.test.o: $(TESTS_DIR)/%.c | $(RDIR)/%.test.d
> > +     $(call msg,TEST-OBJ,$(BINARY),$@)
> > +     $(Q)(cd $(@D) && $(CC) -I. $(CFLAGS) -MMD -MT $@ -c $(CURDIR)/$< =
$(LDLIBS) -o $(@F)) $(if \
> > +             $(PERMISSIVE_TESTS),$(call skip_on_fail,TEST))
>
> Does the backslash placement here cause the $(if) condition to be
> unconditionally true?
>
> The backslash-newline sits inside the $(if ...) call between the
> function name and its first argument. GNU make preserves
> backslash-newline in recipe lines (so the shell can join continued
> commands), and does not strip whitespace from the condition string
> before testing it. The raw condition text becomes '\' + newline +
> tabs + '$(PERMISSIVE_TESTS)', and since a backslash is not
> whitespace, the condition string is never empty.
>
> This means $(call skip_on_fail,TEST) is always appended, regardless
> of PERMISSIVE_TESTS. The guard collapses to permissive for every
> runner, including test_maps, contradicting the comment at line 50
> that says permissive build behavior only applies to test_progs.
>
> With BPF_STRICT_BUILD=3D0, a map_tests/*.c file that fails to compile
> would now report success, have its .o deleted by skip_on_fail, and
> then fail later in the test_maps link with 'No such file or
> directory' for the removed object, instead of failing at compile
> with the real diagnostic.
>
> Moving the continuation to complete the condition on the first line
> would fix this:
>
>         $(Q)(cd $(@D) && $(CC) -I. $(CFLAGS) -MMD -MT $@ -c $(CURDIR)/$< =
$(LDLIBS) -o $(@F)) \
>                 $(if $(PERMISSIVE_TESTS),$(call skip_on_fail,TEST))
>

I could not reproduce this. It seems make collapses backslash-newline seque=
nces
inside variable and function references before expanding a recipe. The
continuation here therefore does not become part of the $(if) condition.

I tested this as follows in case anyone is curious to test as well (sorry
if i mangled whitespaces below anyhow):

$ cat Makefile
# Standalone reproduction of the condition reported against v8 patch 9.
RUNNER ?=3D test_maps
BPF_STRICT_BUILD ?=3D 1

PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
PERMISSIVE_TESTS :=3D $(if $(filter test_progs,$(RUNNER)),$(PERMISSIVE))

# Same nested guard as the real helper; no files need removing here.
skip_on_fail =3D $(if $(PERMISSIVE),|| { printf '%s\n' 'SKIP-$(1)'; })

.PHONY: all
all:
    @printf 'runner=3D%s strict=3D%s\n' '$(RUNNER)' '$(BPF_STRICT_BUILD)'
    @false $(if \
                     $(PERMISSIVE_TESTS),$(call skip_on_fail,TEST))
    @printf '%s\n' 'Continued after failed command'

$ for runner in test_maps test_progs; do
      for strict in 0 1; do
          if make --no-print-directory \
              RUNNER=3D"$runner" BPF_STRICT_BUILD=3D"$strict"; then
              echo "make exit: 0"
          else
              echo "make exit: $?"
          fi
      done
  done
runner=3Dtest_maps strict=3D0
make: *** [Makefile:14: all] Error 1
make exit: 2
runner=3Dtest_maps strict=3D1
make: *** [Makefile:14: all] Error 1
make exit: 2
runner=3Dtest_progs strict=3D0
SKIP-TEST
Continued after failed command
make exit: 0
runner=3Dtest_progs strict=3D1
make: *** [Makefile:14: all] Error 1
make exit: 2


>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/355776=
80350
