Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF33E49CC
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026248; cv=pass; b=QpQD6D2yjnAmTCT/cm4Zo3kIkElvBjLpqwm4F0utb61tUZbwRonryL1S21USzPKGHfXPkMigZi/QSN/1W4JviB7rCqCAT7hovV4OzvS34qKJY/AiYrUPk1DgpJimJr6fUQFH/ogM3Nzw8mT7nz9kFQmCFvKWFnDy+iac8aPenoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026248; c=relaxed/simple;
	bh=iaXTPIKH2D73T2js8KZyUAj+YswgCyg2dK6ubYpwlXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hG1zoWVaO6goZU2hH67eqiZKzOBSHoI2j33W6XnwX1SJSwWUqVd/IvLx0Z0AJS/sWbTEZUEub3lgZvYch+YXPMToIuls9r/7r7FTmzEsWsuUvCBph/fLW5mt78y5fYFeU86LkwVmM04yDTjJzH+8TR5Ea2e83nflXoBnWS126No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h43xxRko; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h43xxRko"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso3781798a91.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790026246; cv=none;
        d=google.com; s=arc-20260327;
        b=HEbmHkCea+2oVYDIs3jK4WIEnCSeoPkuP/UNTVkINpbwQSeNbOZnsyus7NoOAJD5Mt
         VhfP6h32EisOSAUDZO6UZ3Cuji0fpAWQeF8jtR24sFc8G59QGb1j9NyFCxixqR6+Sg9m
         LdChfjccuyemHgRV/lKXi+1PxtzDt265EdDIPsvprt+PSgvgr3MN9K3pMGra2unXyzcM
         Q9dtekvGIJDW3AS7r1JSf64E1HKx9CcUZPovdDO3my7/w3uHX8UxyLtZAh3ISAiFxtO9
         DcHJqktTn40ml5YHdDY1Q9+3UH/7IHgma1xccHYsa+VeHI43NGJXQ0OYs7f70pMYngrv
         3NPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5UCNksm1oqsm+FKq1Whp9B5kNMlJu9ggUGVJnCzUXOA=;
        fh=jW3xtVRl+mUX2kgNecddnKWR9siHlt2z+A+4FoKn7ds=;
        b=ecjQUbi+FsfZ6rh9tEhKNjKAUirAv7jMpVOUV1qxQDkrwTL4BegyjPv6nRaS7s6C/9
         X6xAgbQpp4E/bYRLNIW4li4suNHifQl1W8oTHJ55MC0zzf1shaCV7tMS87Wr7mAoMWMj
         dchcSUdHyEdn3aJ1XQtpVjwQ1CVg25DbJhprcLTkmAu/nXoE4AxWDtPQqMLTC3enVyi+
         mNsvZN4/XD8/HRWSCauBi4/rVqZBrT01MD6nDiIKg/ZNeTOji9zILJjEglpZbY7BI79q
         xp+wYWamAvXJwodCdQMisvAwMWl+UuT5/yFdDRyxSEso6+qLfMR1OF96v0yGM1jUwZkr
         /4SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790026246; x=1790631046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5UCNksm1oqsm+FKq1Whp9B5kNMlJu9ggUGVJnCzUXOA=;
        b=h43xxRkoWLubh3RXwVX8mcEXOYU2R7xBch6BiQsiMRaHVGS6J5kASrBJyTJ2O8vpQ+
         nT6Ai0akiRXwpez0og2+rzN5NsVysjgWLxQ11bPqnrD284FWpFj+UUgiiEVjtpgvlEIA
         44TBwmEXnENuLUUZ+6d09GKrHPBAyiDa9P/KS2On7EESxcJrglVhGejHJQsFpM+DcC9g
         8/SxKWNmul8XUufXhak6r++ulagL0+2Qez+ZT4qqG7rGau0Sae036hj5cvWpr+Mo1Ev2
         4Dl8GUQIw8IhMl3wAidhGCnzyC8eCcy3zn+8CQjbZV5julGyWAqQXp4jusFEEO9hJ3gs
         7/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026246; x=1790631046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5UCNksm1oqsm+FKq1Whp9B5kNMlJu9ggUGVJnCzUXOA=;
        b=FVAynE5jcDKFNv6eEBZXL/a46GjTXVCyFQQeilPHe7DzRiqcykclcejNjNkUFJ7UpJ
         F7n2kcrKz/OelIyuT+Msz+QCqqKQaM0LCunSyYtFAf6JgAO5/OKVdP9Bal9R3EA7muX6
         L92Hzp5Ur4vvQwf9kSslix6pP2t+u3t1I6JkP8/gpHnk9pofYajAWRRRXxKM+FX9RuOn
         KyJUuFSkNGQKPbKCNgjB7Sm7MJhWDG1+2+eY5b36ilS9h07+X0D/F2DYHBgGwwBUVPAV
         2e5+/vPOQdrL6+qK9eUmjdq0gdXdunjw7ueyJbdp5C0vqvzGDogXcHQ/Y9JcTRjFAcz0
         MFYw==
X-Forwarded-Encrypted: i=1; AKwUvBy7cSWj8/5Pd92WSv/zp4YEQTMUqx0C1jrp399rtPg2livXcEUM+inGd5onkJuFlsNRfog=@vger.kernel.org
X-Gm-Message-State: AFuF++nyV5Qtt2pGcBmR/18QP03aSIUdDDI5cclY2ZX2l2yf9y6N2VF6
	vYiL5Or6/KZc9OaIEDcw3CJyCeXMGs4iUg9RBRRDixUSlc5vWv9gtcfezLNDFYe0agPGvYtELZ4
	D/YVbdJPsH+lyo3kExwaX5KeeU0mIN30=
X-Gm-Gg: AYBFou2QMxhCsC4f8IT7781QTqnLkc/Di7hryaJjfb7xZM4FDLvJkVDW3XHydy4tze4
	3RcyMLvL4OFd5S4VDdW93x1MpQqAQCZ5gJxor0xVRhDMuDUn8NpEXl8hoVRA1cTHzcCTfK5t1O2
	+LLxgatHcfx7wHmHSS6gx0IAzcGnkZnCKM0slyLiVJ8KCoka8W38jlp4NCBtm9ip6KJeBserX1u
	k42zH419TOOkPNo7t9TRJOEd4aye0AeL787gCHOTavI1KK2JvS0TQQ+v7wP1A2vGutodMv48vTj
	hTyO5ffG9PyCkCxFLov8O8MUFt327lo9IoEuOwMLIfvU071VzH+Hbhn45S5BSx7g3QkVo6sIt7m
	UsDJ8+OdKiP+l/1Wuav+h5I5NlYzD4VsuiKbZ8OI5z0B1Y8j28aEN
X-Received: by 2002:a17:90b:2709:b0:39e:6c69:9b8e with SMTP id
 98e67ed59e1d1-39e6c69b257mr10967181a91.51.1790026246328; Mon, 21 Sep 2026
 14:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918040919.3402577-1-tweek@google.com>
In-Reply-To: <20260918040919.3402577-1-tweek@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Sep 2026 14:30:32 -0700
X-Gm-Features: AcwNN1UBLDNvhaONZR6woeBhYnn7wMW04jRG5L5QnSQolx_VpN1cA7taae-yCUA
Message-ID: <CAEf4BzaeKXEC-gBbxo36wdAGwwZxqkL6pV=oo0dke4S2BmuRmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Skip non-autoload programs when
 generating light skeletons
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 9:09=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> When generating a light skeleton (bpftool gen skeleton -L),
> bpf_object__load() skips loading programs marked as non-autoload (e.g.
> SEC("?...")), so the generated loader program only records and populates
> file descriptors for autoloaded programs.
>
> Previously, bpftool emitted struct bpf_prog_desc fields, link fields,
> and attach/detach/destroy functions for all programs in the BPF object,
> causing the loader program to store subsequent program FDs into
> incorrect skeleton struct fields when non-autoload programs were
> present.
>
> Furthermore, bpf_object__load() can update a program's autoload status
> during preparation (e.g. for struct_ops programs when resolving kernel
> BTF members or adjusting autoload based on map autocreate settings).
> Move bpf_object__gen_loader() and bpf_object__load() out of gen_trace()
> into do_skeleton() before counting programs and emitting struct fields so
> that struct field declarations and attach/detach/destroy functions all
> observe the final post-load autoload state.
>
> Skip programs with !bpf_program__autoload(prog) when counting programs
> and generating progs/links struct fields as well as attach, detach, and
> destroy functions for light skeletons.

This seems like error prone behavior to me. Wouldn't it be better to
hard fail if the BPF object has non-autoloaded BPF programs instead,
as clearly it's not meant to be used with a light skeleton that
doesn't support such programs? So why not emit a meaningful error and
exit?

Or I don't know, let's teach light skeleton how to support
non-loadable programs maybe, not sure what that would take, but worth
considering to bridge the gap?


pw-bot: cr

>
> Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" =
and "gen skeleton" command.")
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
> v2 -> v3:
>   - Move comment from gen_trace() to do_skeleton()
>   - Add comment to do_skeleton() why the loader is called early
> v1 -> v2:
>   - Move bpf_object__gen_loader() and bpf_object__load() out of gen_trace=
()
>
>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  4 +-
>  tools/bpf/bpftool/gen.c                       | 76 ++++++++++++-------
>  2 files changed, 52 insertions(+), 28 deletions(-)
>

[...]
