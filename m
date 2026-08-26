Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFB223DFF
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787707221; cv=none; b=R/ydizGJvhC1aojiTVkbpvhjr/JA9ez6RErWTw05JmbLcv9GYE3JVL2g3Jf0IKc139sVmZyS1MqUs1CVSMYxgKUjV01/PP8RwNrNyyxdNxL5a3zQCFKFR8obfbTXokxTEJauoNdnUik3vsxQ5quWIhbFLJhG3AODR0UScZJ0+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787707221; c=relaxed/simple;
	bh=XnC0OAV8aac6dSnM/x5f16DLZfKmuzQPmXK1c/DyNuQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=cEKV/nrS+ktvttwcpZEV4+H6Q2NtyV1kVT+Mgi23yJjj9SBnx+5g4W3uR9TNoSOc7yjBamZCYJ1IZ8Dwz860wCAeBfoKhCtRpataAgW7eAyRfoRYwljboyIU8zzBx/4mp5c20aQdLQO5f+7LfU4MWZZS5TmyMs7WtZYyKCZFWh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvXDqPCw; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvXDqPCw"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-44caeb973b3so112772fac.1
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 18:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787707218; x=1788312018; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fUDFu0Aj3iEpRXjvLMN725jqc9wt6Juyi3TstW1quH4=;
        b=HvXDqPCwS3WmApsIZxRk/LmujckKD/zFiNYJLt9nYFf/jckjdQ5su2iEzw8Qiz3NRb
         BtNpHC+MlUY5Us+RkWmFUwkCwcZnI8iys1HHMHjXcF3P5sz3Np/IUHAZZJXEyo8+wxAW
         06rW67lAJF6VaN9kKj/+Q8D4VZsdbDYOjjZyUwRwOZBfBi8phQ1+u5FDvbvHJmG4h7JL
         RZRp5jvtEhKTOb1OlNkZrVMSb0jN0q+/8C3cm2AION+ldD45LGW/CgZjPs8AAQBaTx7E
         TnCr64jx2OlamCUnqDwTYvzl582HJpjLxfUpE5AZV58WPybVO+3fIB9YLWeBO/KL/wQ3
         NZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787707218; x=1788312018;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUDFu0Aj3iEpRXjvLMN725jqc9wt6Juyi3TstW1quH4=;
        b=Nhvgh2DiYoDyc9x781dRuAGviu4E8Lw/quRw+TiL21A1cTUSK/HT0utJrn9GOf+Rxd
         XdAbJkI7JGYWntgG+8irUb1l0xDLFZb9+Bv9nJie03m/Gn/Hzhejlmq4YTWKYxVBdxeh
         9iEX8hGDoMYh5A3SrV1g/J2h9HVJoR3TPCed1qwnqU+aj7kM+byZzE/Z05uU9fXahjoS
         Asdt2Zsuwq6wL8Kp6v2+ABoucmSO3KFJ/G6kYHpinXHqueuQfm0PFt/rvCcxjn+MC5rW
         eGBXtMFF3ZWS/qbTXE1VZ2bQKgN1dops0dU4WSrG3lHbr4e1gMeohBdzKYiG104rtsQ2
         r7hA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+cTY3bL0gVc98Zqz62clMAlWF9Zb8okzZHUU7N2oj3j9FwmJgWe5C4B9ZGEAXXXqB8W4=@vger.kernel.org
X-Gm-Message-State: AFuF++kQ3/cPT9eJSt4+PFwTUeG3IxosW9iJZ4HjFatCKiWR6CyXTgYV
	P8AUZmbmHEZ3cUqdeYo42nNleHLcxBJ325EPTCLGdZYg7Z32tdlxjIc3
X-Gm-Gg: AR+sD112kt0+/LrHZO0Sz49F/pVhAlkmXb3dySfV6IYhAREqcM79as/QUI8SiwsVu6b
	5PhtjuZBDH25zsPVfAGaYvODOjqMNkm2c+5vqB5ft51Db3iPbHEW05gVarFClJcj3iYVwpoyBVY
	hHLwaTEOt+w4GLm9LbSvAigiCRBonatu8pgUeBamtg23e/fiFhudeG0C0CWc86dK6FnOJhZJd0+
	DHfrmPAG/VV69DfNqxofbARWKpxALfRM1ytizCBH6dpe7vgcqKq7i3PBO25sItFsAKqowICjtvg
	rrKBn2DEiNxs5eUde97mS9J/uydPnzqpUEyhh7d+eXjz9FZCIhC8ll/Xg3F8EWUVvZo4LVIjVZ3
	RboVeIiqyszXH4AtrjdEixon1lS4aGgiLeaLKzrLipK4MkErK0q0v3n9PLcSvb1EERq9YjV6eDd
	ZRR4vYk5ygvALZNvKHkaidLGsKxUHdFuooJpFHRNZWjflWa/Kxwy8wDzHEp6SHmbDWxPQQ4RSNT
	kT4en+XhPVUPaCEfEBsRJ5OtbTmdmiVTjJPxZoalUVEz6moQ11Q9A==
X-Received: by 2002:a05:6870:7d1a:b0:463:18a0:959b with SMTP id 586e51a60fabf-4659ab270acmr4525251fac.21.1787707218263;
        Tue, 25 Aug 2026 18:20:18 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-465b014ca15sm841315fac.14.2026.08.25.18.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 18:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 18:20:16 -0700
Message-Id: <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable
 programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Christian Simon" <simon@swine.de>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@kernel.org>, <tj@kernel.org>, <yonghong.song@linux.dev>,
 <stable@vger.kernel.org>, <andrii.nakryiko@gmail.com>, <olsajiri@gmail.com>
X-Mailer: aerc
References: <20260822225444.2774461-1-simon@swine.de>
 <20260822225444.2774461-2-simon@swine.de>
In-Reply-To: <20260822225444.2774461-2-simon@swine.de>

On Sat Aug 22, 2026 at 3:54 PM PDT, Christian Simon wrote:
> A JITed BPF program can use one private stack per program and CPU.
> Sleepable programs can be preempted, allowing another task to run the
> same program on the same CPU. The second invocation then reuses and can
> overwrite the first invocation's private stack.

I'm confused by this. sleepable progs go through __bpf_prog_enter_sleepable=
_recur()
which has per-prog recurison counter. So preemption of the prog
doesn't break private stack.
If the same prog attemps to execute on the same cpu it will be skipped.

syscall prog types go via bpf_prog_run_array_sleepable()
that have per prog recursions counter.

Looks like we're not doing it for bpf_prog_run_array_uprobe().
I'm not sure what the right trade off here.
I feel universally checking for recursion is better
then selectively disabling private stack for uprobe.

> Disable private stack for sleepable programs so they use the regular kern=
el
> stack, which handles preemption correctly. This change is intentionally
> limited to programs marked sleepable; preemptible non-sleepable dispatch
> paths require separate protection.
>
> Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
> Fixes: 156d985123b6 ("powerpc64/bpf: Implement JIT support for private st=
ack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Simon <simon@swine.de>
> ---
>  kernel/bpf/verifier.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5e37ca75e5c4..038753ef07a9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5237,6 +5237,15 @@ static enum priv_stack_mode bpf_enable_priv_stack(=
struct bpf_prog *prog)
>  	if (!bpf_jit_supports_private_stack())
>  		return NO_PRIV_STACK;
> =20
> +	/*
> +	 * Sleepable programs can be preempted, allowing another task to run
> +	 * the same program on the same CPU. Since private stack is per-CPU
> +	 * and per-program, the second invocation would corrupt the first's
> +	 * stack. Disable private stack for sleepable programs.
> +	 */
> +	if (prog->sleepable)
> +		return NO_PRIV_STACK;

This is not true in genreal. sleepable progs can use priv stack.

pw-bot: cr
