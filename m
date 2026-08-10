Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46742C517
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404166; cv=none; b=kXDsimobG6vFhO0lJgSLH5w563xtsO93GeDPSJxJUk4N/CViuteEOlfpz+gxtC80P/EVe8I5OCHqEFI5JiXMQRclmenrXM6J8ojqQL+K1KmNycbRMyuwsbFF7a5msPaszHPFso3zCfrUk5eCLPILYQVvV7dRE3rCPyJWjCeAv/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404166; c=relaxed/simple;
	bh=M0MjLcWTskDALbCS54CZ4/9+M5FLfIcdbvqgABIt+TA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q0YrGslOUEwoUuB8kdUeN5tzxHs1J9xIcXK2yHwFgVWtrIK5QN48gza1J413SxTqZ6rTHuPeXksvN2wvRtJcnpy1EyhWmf+YG2ZY3UMlr5qDQC93RGI55N3yS5b10Y4DWDfZeJvbmWINTUThtRJ2Hb32OVORQyQ6ZqQ7kSvt/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnvX48gj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnvX48gj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc97653887so26682865ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 16:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786404163; x=1787008963; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3sR0roWS7ay8jw9jkIlC9XLTYMTiMVpzbqbRgtEhFxM=;
        b=HnvX48gj+gTC5lccl2ewu0YBISb1i2fwxlC3R54THhBzaD4SakFXTiUU938tYQ2zZl
         cpsCnZanlARXkk2fSmGz3ydyJT5Mfg3jLIaOc6NOefN0+hnsDgTAJyQcXu60rZA4ZqNO
         4XzFYsB8n4VCw8IdroVlUTsAd09l+0hDUVuyOQrHUE+qJ7ba+jSyFGc4+RpLiNRWCBWP
         PRJLE1awyrXkCSGJ1THSePufgAoL8mt+7EoaWokTL22M8SJZNgUv/mOPQWidkC2w1KWK
         zRtmUvNXarhg1qT5RKBL2qLe9J2eizRzAirb2/u3/ck4B7LOVCJhljBJUOr1R8hvN0oA
         YpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786404163; x=1787008963;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3sR0roWS7ay8jw9jkIlC9XLTYMTiMVpzbqbRgtEhFxM=;
        b=KdGfczSL3oFL7UtClhopt4J3+U4RAUT6urkMXZoIlC1T3++RqwrHRiNJUXl2h/93JF
         dG847CK/e5BNG7JwMYEtCrMCD1D21+NglnlpY6YX01VgAWLnQRigcReZErmKKbMkwxD3
         cnrMOruJDj/PwtCQGttsCAN8eiDKzrz+TDRxk8vA3eoG98Zwh2ev9Qnjv2Egn1ufyC3f
         3lrIdvto1TTNpPkGFRkSGt/kvcChkuiqwgLeHQC5u3keZGq10OTqwbaQNolvj75Rur7A
         u5H3oRs+cjYF0ogN4nIzExUlg7/rZc524sr4giaVPTt4oRMADgKGz/lHQbD1pEvHKuMz
         hcdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrt0gu3ZNVdyei7P7xFZ5HLjQK2d9SgVE5gWuXoCJ/Y3UPBmdj76Ql8SqkH1Xj6zCogSIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCt8RilMZtYYNBkhoLc43runyaPknTJHmH+mD5DJhs0ICSHdxu
	dcEWbuvkcRZ09vjX7weDiBLr/r4jA4rl/cbZp9+i3oO22AGuPtBxApFH
X-Gm-Gg: AR+sD11Mf7roBBpZN1IovHzvPhjgQpyrQHPWDYZFGhGPo70KopRcq+YjIXZcsLAI0Qe
	sKTimuBGzq0dIalAJLM8VKb+C9V8EVVqdlp1MR6yPf6if48AmZNWZBZZ6oa5pIR0t8v56Gsanr2
	Sg/1Q8T7sX8QxN2LoggGb6FLxVeuY8y39gZ1Q1w8ilcWpPAVHwiiJJMeX/Tbb2omlpPQFQMNATR
	unOrcontl0SvthZFLYH5N1+PVE0XLEpM6JvqLiDMavLAkUj0OrJIi6GqKnekmaBNXbYzF/CAA7+
	l6+yjb+dSGmBblvYVzt/j46Ts+lHY1kbCd3T0dste8P6h9unG0Pp2RfopG7qiHvB/pNS5eWpmFM
	gByvF4vE5TE3iVKHRQpDYCUUenQay6kH0SCyzTaRZ+QzzkOGTfAQjFn604blZPLAF/vvNG3IQSt
	DrbHAlOrsin9gQ8q9Zk1JdLjm0HWePZlECdvQCV5P413bzmXFgFlBcqDyZY2IJoOQvBWqDzLag9
	H/8dpDnDdIoY4o0
X-Received: by 2002:a17:90b:3b52:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-392cc8d043emr4789411a91.3.1786404163218;
        Mon, 10 Aug 2026 16:22:43 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5238e07sm1164685a91.15.2026.08.10.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 16:22:42 -0700 (PDT)
Message-ID: <8ea2c2ef5a50333c84865d09c860a9617edbda9b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v11 03/10] bpf: Introduce global percpu data
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend	 <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan	 <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
Date: Mon, 10 Aug 2026 16:22:39 -0700
In-Reply-To: <20260806163125.11172-4-leon.hwang@linux.dev>
References: <20260806163125.11172-1-leon.hwang@linux.dev>
	 <20260806163125.11172-4-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-07 at 00:31 +0800, Leon Hwang wrote:

...

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 440e73e1b11b..f2398749103b 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1817,6 +1817,43 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
v)
> =C2=A0			goto next_insn;
> =C2=A0		}
> =C2=A0
> +		if (bpf_jit_supports_percpu_insn() &&
> +		=C2=A0=C2=A0=C2=A0 insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
> +		=C2=A0=C2=A0=C2=A0 (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE ||
> +		=C2=A0=C2=A0=C2=A0=C2=A0 insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE=
)) {
> +			struct bpf_map *map;
> +
> +			aux =3D &env->insn_aux_data[i + delta];
> +			map =3D env->used_maps[aux->map_index];
> +			if (map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +				goto next_insn;
> +
> +			prog->jit_required =3D true;
> +
> +			/*
> +			 * We are *skipping* first half of ld_imm64 insn
> +			 * with 'i++;', patching over second half of it
> +			 * with that same half + mov64_percpu_reg insn.
> +			 * All because bpf_patch_insn_data() can only
> +			 * replace one 8-byte insn, which does not work
> +			 * well for ld_imm64 insn.
> +			 */
> +
> +			insn_buf[0] =3D insn[1];
> +			insn_buf[1] =3D BPF_MOV64_PERCPU_REG(insn->dst_reg, insn->dst_reg);
> +			cnt =3D 2;

Hi Leon,

Sorry for joining the discussion so late, but Andrii asked me to take
a look at the verifier part of the changes. Could you please elaborate
on what exactly does not work with 16-byte instructions and
bpf_patch_insn_data()? Note that e.g. 'if (insn->imm =3D=3D BPF_FUNC_timer_=
set_callback) {'
case in the same bpf_do_misc_fixups() applies a patch containing BPF_LD_IMM=
64().

The rest of the patch lgtm.

> +
> +			i++;
> +			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta=C2=A0=C2=A0=C2=A0 +=3D cnt - 1;
> +			env->prog =3D prog =3D new_prog;
> +			insn=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D new_prog->insnsi + i + delta;
> +			goto next_insn;
> +		}
> +
> =C2=A0		if (insn->code !=3D (BPF_JMP | BPF_CALL))
> =C2=A0			goto next_insn;
> =C2=A0		if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)

...
