Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0923DFC6A
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889104; cv=none; b=IlE1YNu4OrbUaZrFog+nhNJw/o8QjCNVIgbMtVFceFD58b8sAq3frzRD/RSFHBskPch7xIzgjHeTAQ0c/lYI5BYjnECMWSORtFJVGHhpENlJSlt96XrVzPh3GshTO68SpQTzVhTkVvZXqJJPfCPJHdYhoIcQmGrVY+/eta007i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889104; c=relaxed/simple;
	bh=ObADTlzoiTA6U2yvY2GshZzVd6tdDp6Ev6J9pWdWFpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRrHjxVDuOn1wnrIcA013llqWs+adhgNbi2t9N1HylKlIn7B0pJSMMKpWMWVP4jDAaVZ2F9U2DGorKArgA7Uo8NIl7vy6+DYUDivQ8BQYHkTqeucq7XqEO4hYQDY3bEThKD1ZU558IDiDn/Ym7cgh9OT1wTlCJUBzbBWhRyvFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeJz9tJD; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeJz9tJD"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b355ffso1216073b3a.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 00:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889099; x=1790493899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gOTpVBg6yPuc/XTyIpDgsbvA7J2tB8bOdXuJs8CMv5I=;
        b=aeJz9tJDlgGqXDpwmg17rdebHsEgNeKwq56CrolZAU66C5Povl95IUNMoKEyA7kcaA
         DokxkG3N9QWO7QfzxbhDlAVPu4JMlTnXNXRpYtgA8x8EaMUjTXqus6Dgat+JL+Fevk3c
         rac9kaJ5SpDDLlfgXR0QzTcKGpc576/2chR+3skHz+/kDrMse/BaPVV5iVZnLPCFu1/c
         ReV1IxLvAEOkmov53j6O3QDKUtI69JFNMZFVD2qOdRQjp4UWDZbMo+h2vjQuAfRd++6v
         8OPXItDNSibKLfMMmre0nKQhJ5BkMbKYKNOFs3x+AR05r2jz410qscYXJI88YsbdhGuw
         mmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889099; x=1790493899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gOTpVBg6yPuc/XTyIpDgsbvA7J2tB8bOdXuJs8CMv5I=;
        b=SIcnRPNW/EBOZVAjuAv2AZz3pX088tnxAuwnAuCuoTPSoNSuyTClg/bTMjdOfgYzYj
         6CFD6fJI4BZNoLn90+IAr5vpDC7r3YnwfjRy9wSRY3vIzNsnV2cHXMeVjfvsg3tqq4Mg
         YFg8HfXbXrJClqtgBwrVVxzTiHitvtJmKiyz6xzLnAiNJt3BTxWWKO5LKusqVB8vmpuy
         +yndrkY/hl88s1bjg1ooW81TnMw7AU6EaU+j9cVxAMgMyTDH541LIxZxkk+oabkdbcX0
         NO64A165bQSDL+wQtMIlUKOJE4mgSZPtyfpGyddqOHXuq5IHdVF45QK3+bNMVmMAJn4t
         2ZQw==
X-Gm-Message-State: AFuF++nN4+LBzXjdnQYONfzZ/duiZHGnlwT3mMYE8MM2SSmPlBNRDmtW
	FIZ2Ro0NoXA6GMSEO+PH0xlUVOp4ePmcsrU0+5SGSyeJ45D5gsCHyX20NdFkp38NY7w=
X-Gm-Gg: AYBFou1oOySZNNyOTioOSe4LHkV8CZio7tMihAevnY+omCGmHBGoM0h+WCyTnRaQJ3H
	pkjDaElRNKfjipeHaV4+Sj+dc4B+hQOAe/cLLnPsfZwTekZzDdBEoQEMbxA4a5a9FTG/2uLd3dO
	4z/+LfRJ///PQNMIwXZ8h5KenfoL+SZ5uou3aebx4JCuERDY1rkxasP/VYvI7jFInmrjQT0C9cY
	0bf1OAJ+v2pgjCJrrbC1WZKilFN3SbjWbQIRCdZ67An8QYcOzugOb43SGWq1011ZI9Q2vkepyaM
	UT4rXRGeC0iC3CcT+n6tlA3nH2aYrYbp/CwBkdFD3orsLLuzINjyHKyVxeS+ttdTnElUmkYFtwY
	9sXr8MXe3taNcsuHtdHjvEm0/WjPDwhlwa2uLfjh/HVMnbPctB24HNUYQc5WYEBGUgR54SC3GLJ
	5OI/0sgNlrOFa9iuQdzHyaVEXYn+Olj2bQtY17ppWoJ3hk8c0TOno3rPDdvOp9ZH56oUTiRNQ1m
	2ChNIWafPnCdMZTIutWkEis8zTGY1C5yyFXTR82dlDMxVSd/kE=
X-Received: by 2002:aa7:88c3:0:b0:878:3783:8a4b with SMTP id d2e1a72fcca58-87837839351mr3593980b3a.51.1789889099106;
        Sun, 20 Sep 2026 00:24:59 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com ([58.247.171.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9b0d62csm1668019b3a.39.2026.09.20.00.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:24:58 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: Re: [PATCH bpf 1/1] bpf: crypto: check params size before reading reserved fields
Date: Sun, 20 Sep 2026 15:24:41 +0800
Message-ID: <20260920072441.60435-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <4f3ab4b03e79017e215521743996555439bf0bb3.1789802413.git.xuyuqiabc@gmail.com>
References: <4f3ab4b03e79017e215521743996555439bf0bb3.1789802413.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This note is about a Sashiko finding on the already-applied patch
(a11212910cf0); that review was not posted to the list.  The note
below is analysis only; I am not asking to change the merged patch.

> The `algo` string in `struct bpf_crypto_params` is not checked for
> null-termination before being passed to the crypto API. A BPF program
> can fill this array and subsequent fields with non-null bytes, causing
> `vsnprintf` in `request_module` to read out-of-bounds, potentially
> resulting in a kernel panic or leaking kernel memory to user-space.
> locations: kernel/bpf/crypto.c:165 `bpf_crypto_ctx_create`;
> kernel/bpf/crypto.c:185

This is a valid finding.  It is also pre-existing and independent of the
params__sz out-of-bounds read that this patch fixes.

The kfunc's __sz annotation only bounds-checks the buffer: the verifier
calls check_mem_size_reg() on the params / params__sz pair and checks
that params__sz bytes of the pointer are readable.  It neither zeroes
nor NUL-terminates the buffer.  After the size check in
bpf_crypto_ctx_create(), params__sz == sizeof(struct bpf_crypto_params)
== 408, so algo[] (offset 16, 128 bytes, kernel/bpf/crypto.c:33) lies
inside the validated region, but nothing guarantees a NUL anywhere in
it.  A program can pass reserved[0] = reserved[1] = 0 (which the
function requires) and fill algo[] and the trailing fields with non-NUL
bytes.

type->has_algo(params->algo) (kernel/bpf/crypto.c:165) then reaches an
unbounded read:

  bpf_crypto_lskcipher_has_algo()
    crypto_has_skcipher()          crypto/skcipher.c:666
      crypto_type_has_alg()        crypto/algapi.c:1039
        crypto_find_alg()          crypto/api.c:535
          crypto_alg_mod_lookup()  crypto/api.c:338
            crypto_larval_lookup()  crypto/api.c:290
              request_module("crypto-%s", name)   crypto/api.c:303
                vsnprintf(module_name, MODULE_NAME_LEN, fmt, args)
                                                  kernel/module/kmod.c:150

The "%s" conversion has no precision, so vsnprintf() does a plain
strlen() on name; it keeps reading through key[], key_len and authsize
and past the 408-byte region that the verifier validated, until it finds
a zero byte.  KASAN reports a slab-out-of-bounds read if the object ends
before the next zero.  That is the extent of the bug: the OOB is only
that strlen()/string_nocheck walk past the 408-byte region.  An
unterminated algo makes vsnprintf()'s "%s" read unbounded, but when the
return value is >= MODULE_NAME_LEN, kmod.c returns -ENAMETOOLONG and
does not reach call_modprobe() or the usermode helper.

The finding also cites kernel/bpf/crypto.c:185.  That line is a blank
line, not a second use of algo; if (!ctx) after kzalloc is at 181.
The nearby second use of params->algo is type->alloc_tfm() at 187;
185 is a near miss for that line.  A 128-byte all-non-NUL algo cannot
match any already-loaded cra_name, so has_algo() returns false,
bpf_crypto_ctx_create() sets -EOPNOTSUPP, and type->alloc_tfm() is
not reached.

This is only reachable from BPF_PROG_TYPE_SYSCALL (the
crypt_init_kfunc_set registration at kernel/bpf/crypto.c:393), which
requires CAP_BPF, so it is not an unprivileged attack.  Still, the
verifier-validated buffer is the trust boundary, and reading past it is
a bug regardless.

Relationship to this patch: the patch only moves the params__sz
comparison ahead of the reserved[] reads.  The algo[] termination
problem exists identically before and after it, so it is a separate root
cause and is neither fixed nor worsened here.

A follow-up would validate that the strings are terminated before
handing them to the crypto API, for example:

  if (strnlen(params->algo, sizeof(params->algo)) == sizeof(params->algo) ||
      strnlen(params->type, sizeof(params->type)) == sizeof(params->type)) {
          *err = -EINVAL;
          return NULL;
  }

(memchr(params->algo, '\0', sizeof(params->algo)) is equivalent.)
params is const, so writing
params->algo[sizeof(params->algo) - 1] = '\0' would modify the
caller's buffer; explicitly rejecting an unterminated name is cleaner
than silently truncating it.  params->type[] is only compared with
strcmp() against the short, NUL-terminated registered type names, so
it cannot drive the unbounded read, but validating both keeps them
consistent.

That would be a separate patch (Fixes: 3e1c6f35409f), not a change to
the already-merged commit.  Happy to send it if you want it.

Thanks,
Yuqi Xu
