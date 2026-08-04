Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6C834FF45
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836924; cv=none; b=gHAzHb9MaDgvWvauguo/zxvBWJYGB1ovXNYbhzN80PhVklxAmWh2BRRPkuKt5LdCOb+LBXGoIWGj1UtpDRJgAZrGvvG4XS/KUKXifKqy03/yN0FjMYEXY9T6HhCfVvEy5m+at5u3+nJvbKRNl3h3KbdjgYGdg427V64k3fEc33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836924; c=relaxed/simple;
	bh=Wc+LX+TQjIsVOTNQUAHQyDJzLG7FHsnNC4LvyY7AiaU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=VAKPKYjTXLcGjEX9uzpoo3v1q9bRWTMO+aMIwCFTVl/UG7tjrh6FpJ/SSCXFaIzdrO57LAmvEFeHGhq+v0ufUfYpo68h4TX5aq5PhxwaDAryxWg/iC56orS3rplbf2BN3AA63Vc06sGhJtoneh5jgsA6cuBVrXB32BPe7kthUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8PqVma/; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8PqVma/"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-4700bd8aed1so386240f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785836921; x=1786441721; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JJJxbsNs3I3V0kqI1GRztsq81h+oULmvh4UwpCqYfvQ=;
        b=k8PqVma/Pfzyny0feuWKV/QvgFXKlY9CoyKB26S7nCcyTmFgAxpz9qAG8GL2pSuJ7a
         ULwJbM77/XKFoYt/E9oRvMGciWe+q1am22SSl0LkUhvWu6ateSSj9sTgXBEPA91VQFLd
         q70QYsWaDJ/1zcsz1f8osB11F5PIQKlvlWHdraj7hW/zKxOns4CJbQo6FYKOiqdmLshp
         qwdwfIxrHJfsbOtlPhmo43w9rh9zSbDbxMce1+D092rmurL2qZ91gBiv8tKu4rDO0gWa
         DTMo8zljG2gUTajaUsFW3FvX15XjbkdBk7fgCGOCHOb5+r1GjETFIOTa4bdNgm3Z+z68
         bSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836921; x=1786441721;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JJJxbsNs3I3V0kqI1GRztsq81h+oULmvh4UwpCqYfvQ=;
        b=eF9W/yZBPkR5aE7HGYEoyqSegXUj5wiw8ctCbde4dr2DqOPpuvN404EGptmIN8fTOl
         rFixn/AJfaW4VQJzefSh5CLj+esNtgOrf8To/+OzQS/sPjZxa6tdNq4H6W9gtlkHT4oB
         D1lFFAPJ+8/xYw38fZe5Jtd5eRLIKJaErNXZM+W2cE0M0PU8QkSuEbqrx1ZSx4ULwFIp
         DtCYDlOdl/ao/jcFZSUdcWIFuJFHZl1C/6oV1s4tgSjl5nMbwszwqxLVYRgdDjk0BsGr
         +qdK5MUR29A74Rvw7r1/KS57EX4MqVuNY1woGPNsR6Hlt9BfZK5obh0WrF84ZyEc5Edj
         rfTA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8PEF2odHVuNMvxiCu+5rTFmGraQAXCVSfZzqBrYZcI5vqeqD/0RXP8RNSBxaw+OZjbPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqR+ro900xTFH5ShyZ7vf/Fy37nkbrlgv5m0Gt8VbN2gu/uNPD
	pek3ujz/L13ymi+g2U2XRww8pjnoVSi3a6Hu937HQFYZxcnHooWSx5pZ
X-Gm-Gg: AR+sD10HoxNJAp0ns6EtCa3WeLaObRLzHBJzdpV+QRI/3sTfsJjbhXA3S3AB5LOW+gP
	tVJJ98TYbJIe//2Rv7bAOLvWPJAxqosDQmGQjft6UiSM3anumACbNNeMxUoz1OwoChqhQyW4Rz2
	6vib6EpARtDB9Xdw/9v7IfA0Hjk/YS4JYCTGq2GLBvuD9zAGuByTfvy1khAfy+h5O6aSHY29qb4
	IU5Wp+pV5i3nT6eZD6gWodvwDH4JKJwEbdzwOHBi6zFetTGLFk1sZQ56CADt4Mb5Zi4C8hfZkQR
	yL7NgkKiEUAGwiEaEigKbCsfg49AydepDzFF3V/cq6wdzqis8eYuSq2uNnfCZjsVifsj//do/jS
	VnSD5SNm0gvsyxjy7LElWpo5qqWauvUHXdonZ6DMCCsWEW3VDtekwkcizLN28pxQXaScOqAH38I
	fwPQ8McOA70GPvIlUEtdLKLGIznNgP1+WfF5Ae6DynnU4xu8SGyDRv+MHbx+eGs24a4eyZuHYV0
	a/D2fcc3PEatGwJK6BgCDH5F+GdtDwoxmufWLnLKYNNu7iDqB19iGnagD3XjNAOb4SDPwRaQhT6
	NJktLcyoplnZiymt3on2p9SRcaw=
X-Received: by 2002:a05:6000:1182:b0:47f:8603:a879 with SMTP id ffacd0b85a97d-47fe81b68camr6015451f8f.11.1785836920724;
        Tue, 04 Aug 2026 02:48:40 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1956sm42747480f8f.6.2026.08.04.02.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 02:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 11:48:39 +0200
Message-Id: <DKG2CR8JD0F6.1MUAY6BVAIHLZ@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Show more useful info in stack
 depth stats
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <kkd@meta.com>,
 <kernel-team@meta.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260804081114.3871564-2-memxor@gmail.com>
 <89233ff19ba231586f1785f43c58f90c0d0ff756a8ff2e0232c475cfaea0b599@mail.kernel.org>
In-Reply-To: <89233ff19ba231586f1785f43c58f90c0d0ff756a8ff2e0232c475cfaea0b599@mail.kernel.org>

On Tue Aug 4, 2026 at 11:31 AM CEST, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b274004fccfd9..80c249906fd39 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18777,15 +18777,21 @@ static void print_verification_stats(struct bp=
f_verifier_env *env)
>>  	if (env->log.level & BPF_LOG_STATS) {
>>  		verbose(env, "verification time %lld usec\n",
>>  			div_u64(env->verification_time, 1000));
>> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
>> -		for (i =3D 1; i < subprog_cnt; i++)
>> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
>> -		verbose(env, " max %d\n", env->max_stack_depth);
>> -		verbose(env, "insns processed %d", env->subprog_info[0].insn_processe=
d);
>> -		for (i =3D 1; i < subprog_cnt; i++)
>> -			if (bpf_subprog_is_global(env, i))
>> -				verbose(env, "+%d", env->subprog_info[i].insn_processed);
>> -		verbose(env, "\n");
>> +		verbose(env, "stack depth max %d\n", env->max_stack_depth);
>> +		for (i =3D 0; i < subprog_cnt; i++) {
>> +			const char *name =3D env->subprog_info[i].name;
>> +
>> +			if (!name || !name[0])
>> +				name =3D "<unknown>";
>> +			if (i =3D=3D 0)
>> +				verbose(env, "prog (%s) insns %d stack %d\n", name,
>> +					env->subprog_info[i].insn_processed,
>> +					env->subprog_info[i].stack_depth);
>> +			else
>> +				verbose(env, "subprog %d (%s) insns %d stack %d\n", i, name,
>> +					env->subprog_info[i].insn_processed,
>> +					env->subprog_info[i].stack_depth);
>> +		}
>>  	}
>
> The new loop prints insns %d for every subprogram, but
> subprog_info[i].insn_processed is only ever written for the main program
> and for global subprograms. The old code encoded exactly that with an
> explicit filter:
>
> kernel/bpf/verifier.c (old):
>     verbose(env, "insns processed %d", env->subprog_info[0].insn_processe=
d);
>     for (i =3D 1; i < subprog_cnt; i++)
>         if (bpf_subprog_is_global(env, i))          /* <-- filter removed=
 */
>             verbose(env, "+%d", env->subprog_info[i].insn_processed);
>
> The only two writers are do_check_main() and do_check_subprogs(). The
> latter is reached only after:
>
> kernel/bpf/verifier.c:18711
>     if (!bpf_subprog_is_global(env, i))
>         continue;
>
> and the whole function returns early at:
>
> kernel/bpf/check_btf.c:1070
>     if (!aux->func_info)
>         return 0;
>
> env is kvzalloc'd, so for every static subprogram, callback (bpf_loop,
> timer), and every subprogram of a program loaded without BTF func_info,
> insn_processed is structurally always 0. Those instructions were counted
> into the caller's record, because static subprogs are verified inline as
> part of the calling frame.
>
> Does this mean that for any program using static subprograms or callbacks
> the new per-subprog insns field shows 0 rather than where verifier work i=
s
> actually spent?
>
> The patch's own new expectations confirm this. Every "subprog N (...) ins=
ns"
> line added in this commit is for a non-global subprogram (dummy_loop_call=
back,
> cumulative_stack_depth_subprog, timer_cb1, subprog1, subprog2), and each
> uses the permissive {{[0-9]+}} regex that matches 0.
>
> This directly contradicts the stated purpose: "it is hard to see where
> verifier work is spent". Either the bpf_subprog_is_global() filter should
> be kept (omit the field, or the whole record, for subprograms that are no=
t
> independently verified), or the field should be marked as not-measured
> (e.g. insns -) so that 0 is not mistaken for a real measurement.
>

This is valid, and should be considered.

> Related coverage loss from the same root cause:
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.=
c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>> index 67dc352addfd7..1755f133f0205 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>> @@ -52,7 +52,7 @@ __msg("('global_calls_good_only') is global and assume=
d valid.")
>>  /* eventually global_good() is transitively validated as well */
>>  __msg("Validating global_good() func")
>>  __msg("('global_good') is safe for any args that match its prototype")
>> -__msg("insns processed {{[0-9]+\\+[0-9]+\\+[0-9]+$}}")
>> +__msg("prog (chained_global_func_calls_success) insns {{[0-9]+}} stack"=
)
>
> The old anchored pattern asserted that exactly three independent counts
> were emitted (main + global_calls_good_only + global_good). The
> replacement checks only the main-program record and asserts nothing about
> the two global subprogram records. Could the one test that actually
> validated per-global-subprog instruction accounting be preserved?
>
>
> The BPF_LOG_STATS payload grows roughly an order of magnitude per
> subprogram, which can turn a previously-succeeding program load into
> -ENOSPC for callers that pass their own fixed log buffer.
>
> Old stats output scaled at about 4 bytes per subprogram ("+%d" for the
> stack chain, plus "+%d" only for global subprogs). New output emits a ful=
l
> line per subprogram: "subprog %d (%s) insns %d stack %d\n", roughly 40-50
> bytes plus the BTF name, which btf_name_valid_identifier() bounds only by
> KSYM_NAME_LEN =3D=3D 512. With BPF_MAX_SUBPROGS =3D=3D 256 permitted subp=
rograms
> the stats section goes from under ~2 KB to well over ~12 KB, and far more
> with long function names.
>
> Does this matter? Looking at the load path:
>
> kernel/bpf/log.c:45-58 bpf_vlog_update_len_max()
>     tracks the required size in log->len_max.
>
> kernel/bpf/log.c:295 bpf_vlog_finalize()
>     returns -ENOSPC when log->ubuf && log->len_max > log->len_total.
>
> kernel/bpf/verifier.c:20397-20402 bpf_check()
>     err =3D bpf_log_attr_finalize(attr_log, &env->log);
>     if (err) ret =3D err;
>     if (ret) goto err_release_maps;
>
> so the successful verification is turned into a failed BPF_PROG_LOAD.
>
> A userspace loader that sets log_level =3D 4 (stats only) with a modest,
> fixed log_buf sized against the old output will start failing to load
> multi-subprogram programs after this change. libbpf only auto-retries wit=
h
> a larger buffer when it owns the buffer:
>
> tools/lib/bpf/libbpf.c:8064-8071
>     if (own_log_buf && errno =3D=3D ENOSPC ...)
>
> so callers supplying their own log_buf get the failure.
>
> Could the number of per-subprog records be bounded, or emitted only above
> some log level, to avoid the behaviour change for stats-only callers?
>

This is a stretch. In practice, we won't have such small buffers.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/308917=
20984

