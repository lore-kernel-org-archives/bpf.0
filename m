Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADCC40BF2
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710891094; cv=none; b=A3/V2gob1L0cRVRXyPn5CMykJhJpJGL0CqwavVc6M75NATjS1VonK5QiEQ9JcD1J8atRRSgthLx2E2NAl+qpn06CHDviNV9NW+cmOcYJQSM8tDo/dy1PwutioxrS/202cVoKJdMGAvNtH8lsvJRqQsDjVvI5aMwbaMe4iypWsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710891094; c=relaxed/simple;
	bh=0hykgGvTgJHnZ8Qdts+dBCgjLZvdXnjImLFWs1pdUmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZApEyY/UG6FkYo7q3ESubLB6JFE5vvfKOUKjVz5Tn961lWFSRH7/5EeP7Gb798fNXTWAKoYH2Ar2+ZmIqKhVoTi3m9AHmPiI+AUxaThXt/gUK+kb36JvRJ5/BySrbfpKU8uSswxz/b5xCmYbC/QVZQ1X8pPw1HoO+ki8k7Oy9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PabAM1vI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PabAM1vI"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6f69e850bso5089155b3a.0
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 16:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710891090; x=1711495890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hykgGvTgJHnZ8Qdts+dBCgjLZvdXnjImLFWs1pdUmc=;
        b=PabAM1vIfSeojV1Q4eAcxIYVFsxIPB8LeToben4c4uMQpULz3aBrrMxfezK+wgvMez
         VbUj6Q+38JXwoMzBT7xmLHqPuYRxS1oCV3U8hXtxVoX7pFkrTq1H4Iur1O2eZSZcmQ1V
         rL3rNCE1eVBQgzlHtQzRjOlH9HIFO51x7Hy2Xl03dR938khHdEYZqoJfZaX0g01TTv4e
         0pxwvEnr62oym5a83/1DeioYAu3yUDppaKGzNTylFGvVJexxj9kX5aX/w3mX29w2OZ5r
         qVLcSRJc+b199IFqxz1DhEUm7JLuR2t+NbGg8lcPFmT+de7ubcqSQq8KzyDic2/dsQ3N
         Ighw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710891090; x=1711495890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hykgGvTgJHnZ8Qdts+dBCgjLZvdXnjImLFWs1pdUmc=;
        b=RNNm1h8s9U1xx41Q5R9HdiqX+/BYQ0NLX1iELnmW4UJz0ZpAU/2L6J0zMd1dYE+eKp
         XvFCMAA0j1dGmb7dgFs1FJZ8u8b1C07LIl2cvbJvR/7JFSvAXcIkVE5SqIn4jdXP8N47
         hZE6BvAbBytMGXTRNPA8wvcxdqD17EA8ofh6yRIulPtobUUhxk18mZPpVwfnCuR0TdZr
         Kw3b0f7DYawyUFEdZYux+VHYWjbq/lU7L3sFv0DeY1N1EpSscVDfgSzuHzetkb+rRqN5
         Re+oNYoidChjIBO5FWGsd8ZVPzt+7EWA+v+JaHzt0Jy9VmFny7wY1CqMcV+hZJkVHhmI
         2OWw==
X-Gm-Message-State: AOJu0Yz5cw5OzCGHIGrJ/nT1SZi+Y9KQoH+H1urquHXBaK2gW6rlXWna
	GtaRptaL+7NzrOEeIfwR+zbPJcGRwR7Jl/gON51vUsw41QLAtwsqu4Ny6cQ5QGKG6Estr8f+VF2
	dQfBHhfOMlEPLVTAKJ0Qlq6zPRTg=
X-Google-Smtp-Source: AGHT+IGtQBpbrwcz6Nk93nSwNy41a6/Ho7jXi6AwQxTRZFx52LfWOBbRDImZ3fL5Z4kEEizt4lT+5Oza8yFY/fRUuOA=
X-Received: by 2002:a05:6a00:4f84:b0:6e7:4605:12d4 with SMTP id
 ld4-20020a056a004f8400b006e7460512d4mr3276189pfb.3.1710891090016; Tue, 19 Mar
 2024 16:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ2PR14MB650171C32E2AD95B67FD51CD8E2C2@SJ2PR14MB6501.namprd14.prod.outlook.com>
In-Reply-To: <SJ2PR14MB650171C32E2AD95B67FD51CD8E2C2@SJ2PR14MB6501.namprd14.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Mar 2024 16:31:17 -0700
Message-ID: <CAEf4BzYN_q35RtE=7ZpwDf2KtOwpB7mejr=TQUQNUFK6FP_ptQ@mail.gmail.com>
Subject: Re: [bpf-next] bpf: Verifying eBPF range analysis on v6.8
To: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paul Chaignon <paul@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Srinivas Narayana Ganapathy <sn624@cs.rutgers.edu>, 
	Santosh Nagarakatte <sn349@cs.rutgers.edu>, Matan Shachnai <m.shachnai@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:16=E2=80=AFPM Harishankar Vishwanathan
<harishankar.vishwanathan@rutgers.edu> wrote:
>
> Hi,
>
> We wanted to give you an update on our recent results with verifying the
> soundness of the latest patches (Re: "BPF register bounds logic and testi=
ng
> improvements=E2=80=9D) to the eBPF verifier=E2=80=99s range analysis usin=
g our tool Agni [1].
> Specifically, we checked the range analysis in the functions
> adjust_scalar_min_max_vals and descendants (for arithmetic and logic
> instructions) and reg_set_min_max and descendants (for branching instruct=
ions).
> We were able to confirm that the range analyses in kernel 6.8 is sound, w=
ith the

Nice, great to have this verified, thanks!

> following assumptions: we only consider parts of the verifier concerned w=
ith
> range analysis (that is, the part that updates u/smin, u/smax, and tnums =
in
> bpf_reg_state), we only consider scalar types (SCALAR_VALUE) in bpf regis=
ters,
> we assume Agni's translation of the verifier's C code to logic (SMT) is c=
orrect.
>
> Starting from kernel v6.4 onwards, Agni used to take several days to veri=
fy
> these kernels. Further investigation revealed that this was due to the ch=
anges
> to reg_bounds_sync and descendants, which introduced a lot more control f=
low
> (branches) in the verifier code, causing a symbolic path explosion that d=
egraded
> the performance of the verification. To address this, we adopted a modula=
r
> approach to verification.
>
> Consider adjust_scalar_min_max_vals, it can be split as a prefix <X>
> (adjust_scalar_min_max_vals minus reg_bounds_sync) and a suffix <Y>
> (reg_bounds_sync), such such that the entire function is represented as <=
X>.<Y>
> We were able to verify <X>: assuming that when <X> starts in any well-for=
med
> abstract state, <X> will only produce well-formed output states. Similarl=
y we
> were also able to verify <Y>: assuming that when <Y> starts in any well-f=
ormed
> abstract state, <Y> will only produce well-formed output states. Hence, t=
he
> entire function <X>.<Y> is sound. In earlier kernel versions, we have fou=
nd that
> this modular soundness property is untrue. However, in kernels 6.4 throug=
h 6.8,
> modular soundness holds, making it easier to scale verification by breaki=
ng up
> the monolithic verification task: since <Y> consumes the output of <X>, t=
he full
> chain of operations <X> followed by <Y> must also be sound.
>
> To run Agni on the latest kernels requires a preprocessing step because
> regs_refine_cond_op has a goto-label that introduces a backwards edge in =
the
> control-flow graph of the verifier, something that Agni does not support =
yet. We
> provide a patch that essentially removes this backwards edge and makes th=
e
> verifier code a DAG, while keeping it functionally equivalent. The patch =
and the
> instructions to recreate our results are available at [2].
>
> Best,
> Harishankar Vishwanathan
>
> [1] Agni: https://github.com/bpfverif/agni/
> [2] Instructions: https://github.com/bpfverif/agni/wiki/Running-Agni-on-6=
.8
