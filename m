Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3983290BD
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113219; cv=none; b=peOjuoajLyNxlWgObrnJUviQ+m//NKpncRDfCISnhU5b3b3WZj2K0yFXdLkW4PQRd5BZnRFji11fafX3NeVxBPLwGm96y377S22IyOPGOki0I6o679yWrknCYH+2ExAWJewjuUlyOeX1zGZ92c4iELPmlqcJsL7xK9d2RDE7GZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113219; c=relaxed/simple;
	bh=gQSiYggHqMUqGohAfLOyOool24qZAxosvnwlJbtZ34I=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=UjwigSaMr3nD0Ct/QqjMfdY4Kvt4O3+05Sk8X90Bk+P77SvjqJbxgFfyQReXXCbgx5X1AGydlLiD8IixWtauHqBxBHX4snu4241Pv17hR1xv9sCJtlc8RsTcwFifI97EMSRjd0gTXjUBPXkvEDQy5YSrHq4h0798nCfEyAIozTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1ccmYhX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1ccmYhX"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3a813079a55so385260a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792113217; x=1792718017; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=plr37+AdqLwY15XVGk53zlbtl1djLuK/QOjHd4r9Mjw=;
        b=J1ccmYhXX7YIHhLhfvPfw/uUbQ4W7JMXL9d3HlcKEvByCkoNWSYIHFDc7WeDXv0sNf
         JeJGlXpJUYqMx4j5gfB1T+a6c+SxxRlIdBzBnlzCtJG2Q/CEkUWlSSLi5zq2kz6eDxeY
         EK5kB98kYmkrMiOyuR0gT+akJ8XHrJTrE+AQ96enUStl+v1EvPMJLWk4GZoRU+rl6oSK
         PkzIEo2+MvVBavUMRm5LsAo+Kp3aRaPdpucu7HsyfN7y+VcF/cpuBtCf+wW373QaK+Ml
         hGfbe3Z7HRxW6F7hrE+7plNW+ud5PoRbEZ2KGowOUxZ/t/2Bo+5rF3Eksv3fblVj1+AQ
         /APQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792113217; x=1792718017;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plr37+AdqLwY15XVGk53zlbtl1djLuK/QOjHd4r9Mjw=;
        b=zpK0RhIyTG2UoDPxF4S4nxjT9seiJNuuq51E2lfUWUmY/bXCPmk3m0ykBej8c9a1dJ
         Sw7MetcVnhONy/EkDXBNo3301ZYi2+X0QOIpjuOz7aVPI7qK+32LiZda0AAJsMEVfRhU
         +OoqWu3QpjG07FK04Y4T786k9YSF3yaWHI0t8VzkIIMiAP5nrPJ+a7hMHfA6DfZsD5CZ
         IPpRvP2Y3HjSw0Jq1qNQDecsOqFkrfaZM0HtlwgFfaGpS87zp48Z+d0SkNsE5MeTwFyC
         fw+sF1pOFZJSjQaHdVF+nYFB8+PGDPPBstM1j45tI3C24nXvGesocFIK4+IMvwojtTiU
         5ELQ==
X-Forwarded-Encrypted: i=1; AKwUvBypClyte6L0KiGhRAarkKmIhswj+EHL2lA8o0xG3ctVO7ercADSQtdXXEX9qJmp/vbMND0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoF0t10uqQJgjVqx/g6tsbTERPU6DO3OmyzOvCWwEpg9Q4dFjF
	VQDkuLBrS2sWjkHwXZioF9tm23hYPXHSWwvaLEbGuNC5cuKz1Y3CWbs+
X-Gm-Gg: AYBFou3TPF0j0MzLc+Po3lcwMO+PD+/TFL53kab7J7GmK3GGyxT27djxZhEGDdy9cj2
	I3+45S3RxZCGMxLZZYHoynVn3/klJZBqDMypXpO+qS8Lom7FFRuZ3f5YbO9LSHCtsJ5qUCk/bub
	pOhQFFsvLBILv3wvVNQVnjDb7jnMl8v0tSneuUG8uf9RJa3JwPm5+X9sQkDeWUlcL47p65fV98F
	MMIS0iyqAev9moZp26HA1xOZD+uG6bJzkEuffU/Vv+NSJ+XkUkd6whkH4Y63DkQVHfXtGIhHKGS
	S9zchQByPi5g69cM6SP2S+qg/iewkntL7pOfzVFfHKHdYTnkS25PIubfr4izysuaFhP+vqv3B3W
	Jc0Mo8b7nQkP8jiAfVPOQ2T0aqGPUZhtvCWxgpJ4RQgMhHpCz0fXuMQl+FM3OZdlSP0kJAN8WWE
	7NoL2UvmgxWXOG/AG2cYxFDMKVrZkhKolNZI58vEcBnlLohHkh4Yqj5LEqiXvgtSOnk8xH+YcTh
	I9SRcsBZVhWb07QmkP+b0OkuIF/8o5jjplYgcghsUUsERBRlw4ihbtHF1N5jiKw3u2n+MAT5Fts
	5X4=
X-Received: by 2002:a17:90b:4d8e:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3acbb8bf8cfmr1168741a91.37.1792113217090;
        Thu, 15 Oct 2026 18:13:37 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3c8e2c9sm130697a91.2.2026.10.15.18.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 18:13:36 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 01:13:36 +0000
Message-Id: <DM5V45Y5ZYRA.17X2LC1YRCS1N@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Tejun Heo" <tj@kernel.org>, <kkd@meta.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 12/15] bpf: Set up the arena base only in
 functions that use it
In-Reply-To: <20261015234125.3152346-13-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com> <20261015234125.3152346-13-memxor@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 01:41 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> @@ -9919,6 +9933,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
>  		}
>  		break;
>  	case ARG_PTR_TO_ARENA:
> +		/* the JIT rebases the __arena argument of a kfunc on the arena base */
> +		if (is_kfunc(meta))
> +			mark_uses_arena_insn(env);
>  		break;

This mark is not reached when the prog passes 0.
is_kfunc_arg_nullable() is true for both __arena and __arena__nullable,
so arg_type is ARG_PTR_TO_ARENA | PTR_MAYBE_NULL and
check_func_arg() returns at

	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {

before the switch.

  SEC("syscall")
  int prog(void *ctx)
  {
	return bpf_kfunc_arena_cap_test(NULL) != 0;
  }

is not marked, but the func model has BTF_FMODEL_ARENA_ARG, so
emit_kfunc_arena_args() hits
WARN_ON_ONCE(!bpf_prog_uses_arena_insns(bpf_prog))
and the prog is rejected.

v1 was marking the wrong subprog in the same spot.
This spot has a WARN. When a mark is missed for ldx or stx
JIT emits [r12 + reg] with r12 of the caller.

Can bpf_prog_uses_arena_insns() look at the final insns instead?
Like detect_reg_usage() does for callee saved regs.
jit_subprogs() already looks for PROBE_MEM32 and PROBE_ATOMIC
in every func to count exentries.
Then no marks in the verifier.

pw-bot: cr
