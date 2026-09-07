Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716E83890EE
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760025; cv=pass; b=K5vHcGEDQE7cXiTcrNrX6aG4BMvLJXRn1FmT9kNeVD2+7GxxSBm5AnpkeNTUuJOjRAbgF9O79PSnQXBqnRnglV+ZpQfZ8wGHJw7J0uVUomht+9gFPuF7WftblIojO9Ul9wHu4eZ0At3zLxgCxhujgdoDXGrZ7Jsb5nRwXTP2Gdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760025; c=relaxed/simple;
	bh=RUgzcORyckA+8dmosj3W4O7LpXuF1V+EFIaKxpkao/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LS2crLGOWmMEd6HgyzSlMGqnOr47Y9GOdBnmYYkXQQsbEG+aTBJCWAq91E0Zc4qopUcRksSsGzZ7C5GtNEqrbYRduviQsMi7JOtEdE5Bd8kmYCru0R5f0ThvkeH8LD/BaTyJdhk7qkNPOR6A4yMIDhoWhT23lj65hFoK+rxgdb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IkamvXQD; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkamvXQD"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so209721cf.0
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 22:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788760022; cv=none;
        d=google.com; s=arc-20260327;
        b=Lw15OYbBPtkey+YR8e1w4Hw8ARxakFlIpmhL3gN+zw4TWiYZYU+iY1nVdqMKTlfozq
         CZ6VL/pu0BzqfM6hUF6p2ScwRURF1TGK6hfC01hP01deqraV/bND/Tp7zsbftn71kiZw
         jz8Wc/EmUeTyPHUO5FOf+DxlF+FL+pTWs82praNEwqQL438s5Wj/KHFfDsntYl67nHZJ
         y7V4eF3+lAqkDpl4coaOFOhRYhznMQ5n4Z+c50GiF26WQVXAGLWYCfYu4o7ScooNSCua
         cvTNneGp1ws7avyq7EiU70p2vCX2TrRaEPmBUX7ENNu/6imoCr+X3EQB64X6mtnnWRWt
         DE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RUgzcORyckA+8dmosj3W4O7LpXuF1V+EFIaKxpkao/0=;
        fh=1ujWX6JIx6aMDd8sW6jWOLJXNZfxfD/fZ+vNdvCZIbI=;
        b=H0arFeI+hYdXdbqD1mkpQjGlahwNBQMGxaQhJooh8IRlfHk7B7r+Vbef1PfSYEeMsM
         qowSPFzq0yc3KPQVbcyvvRCUE/HIMSPHht0eTD0EFas4DSAyNkm8Y/8gHtkePMH8UVfE
         3wGlyVCHSS8Jev/pxVw/DHLKEhQ5DVBENNHixjMJ818O/TZKP9Fmx73URp3DPZg58rt2
         3ye9rfrlt9XR0xfK6HEmf7wEWm7IBc1iI7YIC+4hJ1tLk6+MHgjhkocucqtHOaf4cAum
         cXswa1VVtAapJxolq8hEdy99hTj5EyKo1NBwK350QLQ6zpTwcNlQ+pv/Dl3YZfhn2AYp
         vwKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788760022; x=1789364822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RUgzcORyckA+8dmosj3W4O7LpXuF1V+EFIaKxpkao/0=;
        b=IkamvXQDnUCwsOAsZYjD+ZwShl62rlw7OIeABI1Pobtyljv0wOXYmEWk4mh4CLxoUH
         pr6dTP8SukVGHPvsoCXPmLeCWOHmxwy0Q3qiw5KyiDNeVp/897bI7LifuB3uNxgIcjZJ
         AQK72jd0PMRWeVPhIDJEQC968/ItcxQK9N4lS4jepeFpY1p3/TkyOGX73X+5+oWKefJg
         K7owoRSYh9UJ9BUCpRAF2rfXq2a2y/BUIdfoZqdLapfkjc9EsfBKaaz+Q3nl//vLJGI7
         vxmplUQqGcZO1B1LlkW+RjeT0xnyUAgfklLVfIkxGzpZh9loHKzlGHXKacWbIfilqWvo
         +nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788760022; x=1789364822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUgzcORyckA+8dmosj3W4O7LpXuF1V+EFIaKxpkao/0=;
        b=WKhPS4okRYUTbWkduT40g052nFRRcE3qeSnfn1CnwQ+ZDWYUdZrleI1bzdEyUXnSKA
         ETsPyDNiUq0YWusiZrlOgQs1fwnvlvtynOBufQMchLfZR3NxGhiPlKPmOMfePOR1MBPC
         g150y+7RZfV3npLdCEvY9iYtTdhoyEq9vbW43r9ZwGYrF0bhYLv/7NDkRbkhUXxcl2Bw
         REn9DcHoWq6cIxhCNmynXO+UWdUqLo1q7HsxcYH4C0TfkdUwoxvZRW3827M57BbnMDoc
         MsCkcA3lPhGqj/WkCJuGM2prB8a9bUhO8YgreMposrm9/PG0+xYd3InIERp8lkSCfX8i
         RRBw==
X-Forwarded-Encrypted: i=1; AKwUvBzPwg5u7H4Om0thSmn1WDoz7W7D6anBPpJJNw5YJnllXeda1QCJkFpqJoe+33tGSTYu7lI=@vger.kernel.org
X-Gm-Message-State: AFuF++nBy6/DuoLL8+Zlm1srgKkeVI9r9cR0HO/7RdW8Tpoy5gIjdXJ6
	yHq+OchVAM9KkxlhUckQcyicSPP9oPjg/VSAGdl9gxb7JHmjpoqVexThoGNBQ/zOaZss3Ys6dU3
	jBheXme6Hdom8IVpdhYKx73G9nxhLlGuksCk2YfvA
X-Gm-Gg: AYBFou3yaYuGAP4KmRwByyKpglo5p9/YjFqHm2vA0WyZNZDfaROHKTEZrobwPGOP1Pl
	3uXcHytfE8dPbujy3MWojRLdux/r0SI+osUk776/hP2Ej66CKSB5wv2/JJMPBApDwKYodXes8zG
	nT7dB7p+RNsccexuLegVcSvdeDJsatECCixf4AJjZAfukykUaKDUhEXLNvGLG/evS8Wz2o9KqtE
	1gPS7psC9l2k/aFcR1VoakR06n5O5fhfQ92VrKqxwoXJN84crBAUkTLIPxp4gHj9KcY/wBTdPqE
	Ps/z/oWasFqZpE07L/1rQYLFKZkKU0YHn2Gbkb4OXGB7hT5ogK4ChAn8Ugad9hHz0U8L6r8tNH+
	8N7KIYtf7uxaNxo3G0xb1xd/7mR8=
X-Received: by 2002:ac8:5a56:0:b0:530:5ed7:50f0 with SMTP id
 d75a77b69052e-53084da738dmr6405881cf.13.1788760021899; Sun, 06 Sep 2026
 22:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904031912.2133476-1-tweek@google.com> <b965bb62-fcc8-4517-9947-24613650f1f5@linux.dev>
In-Reply-To: <b965bb62-fcc8-4517-9947-24613650f1f5@linux.dev>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Mon, 7 Sep 2026 15:46:43 +1000
X-Gm-Features: AcwNN1VHWc43-sC_3CoGJGewDfaRQRVxmRUaVlq04jRRQFeRsaJdgNEB0GaZUNE
Message-ID: <CA+zpnLc-WAqE9rA0PsjvOFe_YCZOdVj9YAzuayGXx0nhpqtw7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Move verifier failure tests
 out of test_global_percpu_data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Sid Nayyar <sidnayyar@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 4:07=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> On 4/9/26 11:19, Thi=C3=A9baud Weksteen wrote:
> > Commit 4c9241bd731a ("selftests/bpf: Add tests to verify global percpu
> > data") added test_global_percpu_data.c to LSKELS_EXTRA. Later, in commi=
t
> > 1ed2294b31fc ("selftests/bpf: Test verifier log for global percpu data"=
)
> > two verifier failure tests were added (verifier_strncmp and
> > verifier_snprintf), both marked as non-autoload (SEC("?kprobe")).
> >
> > When bpftool generates light skeletons, non-autoloaded programs are
> > skipped during loading, causing the loader program to store subsequent
> > program FDs into incorrect skeleton struct fields (e.g. dump_percpu_dat=
a's
> > FD was stored into verifier_strncmp's descriptor).
>
> IIUC, patch 2 will fix the issue totally.
>
> Better to add a subtest to verify both the issue and the fix?

Thanks for the review. That's right, patch 2 will fix the issue:
bpftool will fail to build any program that is set up that way. That's
why patch 1 is necessary; otherwise, the existing test would fail.

Just checking your suggestion: what I can do is add a new test to make
sure that dump_percpu_data is set up as expected (fd > 0). I can write
a new test_global_percpu_data_iter_lskel, that is similar to
test_global_percpu_data_iter, but for lskel?

I can also write a test to ensure that bpftool fails when light
skeletons are set up with autoload=3Dfalse?

Thanks,
