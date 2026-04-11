Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C17E792
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892842; cv=none; b=c7ioLqoDzf3y94645hspK19d5zO2D1yQFnZ9aQxg+TAwotoeXGAHcgDKzqBZrfGYce2xLojLZyWFc5PmR1qr2TYqDH1V+6mDaSKSaBMUtLLqW6OTGKGZfCqsK280EERxvotr4z9iMphL1kfzVrm9vYSxXqwTzWgyaEP/GMA4e0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892842; c=relaxed/simple;
	bh=wGbBkQp2ILnkHmOqDv2/s21hTmjqpH8CYp7xOU/q7kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fqc8G+l1xtwq6PqY3NSlLthvQVVFXcEBKqUOMpKSsHQIqGVgbZMv171W6UQHhAtu5y8Cq/rYWl5KozQehXeBTeTzyMhTUsEAKkqweFP/MTnhO7k/5BgyjT0RLcuocZevJ2iBnfpKLcXNVIKlYJdbhJE1Jwi+0ohkDonGgabrDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBQaT/aA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBQaT/aA"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f138a6d5aso544517b3a.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775892841; x=1776497641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ryCUWN5JZmxF4CLOrLm5FaSrOwnjFTUuC3tbNsIM7Lw=;
        b=RBQaT/aAg9gPbwWZPBTVQrCIXwngMnxbKyb3O9Gp6SqWgNeGPJm7YGDpb1joEAaCxR
         HgtBSFmUepNRq4FqLFt0HXH/+5EXJky7ujF2m+3J4S9TfpBMlhJucuHkW6wprL05fB+5
         /sy/JolutrFe0IVzMSmDYLHUyuCtqc1RPdlaNyBPMVu6GUa7uRYBo0bg7CBMCQEy1/Gn
         /dqbbvT5IbkergB0fm8/Rqw1697SO3Up+gk5ACUuZA4+tTcFz+hGd7w71eKugHai9CuH
         nu8YYx/4Mpfm4piw7+XM0W1JGHYVexK/CJjeAD313OfgKJ42VKkI4jqyVGGtrAPuA9rh
         3I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775892841; x=1776497641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryCUWN5JZmxF4CLOrLm5FaSrOwnjFTUuC3tbNsIM7Lw=;
        b=fXasWYE+AOOqWmjXwXY2XsjoqbQHdjGfLWJ7PBXULhb0wOnepMSNJOHwStYOgNkjtn
         5/eKFxLKJy5VYBqDNFfzAyn9B+fWClGA/CYcdYCxQHe8BeMD0BdYQa1taugTXuzG8ZIj
         nEyhzPmd8zzjSuC5ao0eb/bfisfGTxUSvydAJOJbA7jgB+sx7e+/IrQpSG5FPqz7+ADJ
         rYGz2SC4KJrodfCl3j4MY1n5729GungxJQHAjCoddGwS0IXiTZhdrwYKEgrxdRmEQXLl
         2AtngFlQipXvkivfSgCo/vhTe1Qc9dQEEw9mXRgwQuR3jHhP/Oz50XxhBTbI/3DKPqIz
         JJDw==
X-Gm-Message-State: AOJu0YyUyYtuFGTKjTuuW4DglHJfXt8AIRKINDpjW078KN/+w280cM8J
	gTZA6GYcI74rqkN2R8IinHBUB9o5CkzHLIt/GFxozrYJZoNvy+mprB7j8LK1sA==
X-Gm-Gg: AeBDiesQPEgwiz78nk9xMYJayjU3iprUsbQXv9YVSmK3s4pRF2kPiecMONfcl8YpmXA
	30iw5p9z7TerBZHDeEVA4zb+kAspwNRThh8KlsrNR+p+8zw7nkrVPUU9WBI4k6xIdVJy53S83va
	uWWKpMdMxZIRXMemNc90eMPzPwNubG5zd6n4QdtKZ4fbVCxK449p2TxbX88GvVlsdFjsOWnhB7q
	SMoeo8gZ8GxOj4uKUObVCN7OgdEhOLuGs/d2cA2bnMJZK8/ToUrqaXEYDQ1A0/oVR0M82Ri/qgw
	s2qk53jlNlVw9RIJ9+LOWvYjP5kc0890ikcS8k7jMRsitU6o1OgZqV4IrfrBRKnU0rw1R70/lxD
	hpV+SCkjlbInXuiJBXMFT9QsnCSfpQC6BHRZBpV5oeNUahi6yEMfAoL9wfDd1WhFhyc9Wr6quAL
	4a6VorlfRYwTIvrjAPZEW3oTqRJGsuo5VGL1bReqEByGfgeWEnZWd58xlb8GGHG8A23XA=
X-Received: by 2002:a05:6a00:3e27:b0:82c:2205:507d with SMTP id d2e1a72fcca58-82f0c385de5mr6117271b3a.36.1775892840822;
        Sat, 11 Apr 2026 00:34:00 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30f5c3sm4965388b3a.3.2026.04.11.00.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 00:34:00 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	cupertino.miranda@oracle.com
Subject: [PATCH bpf-next v2 0/4] selftests/bpf: impose global ordering for test decl_tags
Date: Sat, 11 Apr 2026 00:33:43 -0700
Message-ID: <20260410-selftests-global-tags-ordering-v2-0-c566ec9781bf@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260326-selftests-global-tags-ordering-8f324323d9c8
Content-Transfer-Encoding: 8bit

Impose global ordering for all decl tags used by test_loader.c based
tests: __success, __failure, __msg, etc. The tags are now sorted by
testing framework to be processed in the same order they appear in the
C source code of the test.

The ordering is necessary for gcc-bpf. Neither GCC nor the C standard
defines the order in which function attributes are consumed.
While Clang tends to preserve tags definition order in the output BTF,
GCC does not. This inconsistency causes BPF tests with multiple __msg
entries to fail when compiled with GCC.

This is based on a patch [1] from Cupertino Miranda (see patch #3) and
includes some additional cleanups for test_loader.c decl tags
declaration and processing (see patches #1, #2, #4).

[1] https://lore.kernel.org/bpf/20260305130035.192080-1-cupertino.miranda@oracle.com/

Changelog:
v2: https://lore.kernel.org/bpf/20260330-selftests-global-tags-ordering-v2-0-c0ac61e81098@gmail.com/
v2 -> v3:
- fixed free(tmp) call in collect_decl_tags() (Puranjay, bot)
- naming nit in compile_regex() (Mykyta)

v1 -> v2:
- refactoring str_has_pfx() usages missing from v1 (Puranjay)
- removed realloc_or_free() (Andrii)
- fixed qsort(NULL, ...) usage (Puranjay)
- skip_decl_tag_pfx() returns NULL if tag does not start from
  "comment:" (Puranjay)

v1: https://lore.kernel.org/bpf/20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com/
---
Eduard Zingerman (4):
      selftests/bpf: fix __jited_unpriv tag name
      selftests/bpf: make str_has_pfx return pointer past the prefix
      selftests/bpf: impose global ordering for test decl_tags
      selftests/bpf: inline TEST_TAG constants in test_loader.c

 tools/testing/selftests/bpf/progs/bpf_misc.h |  60 ++++----
 tools/testing/selftests/bpf/test_loader.c    | 202 +++++++++++++--------------
 2 files changed, 125 insertions(+), 137 deletions(-)
---
base-commit: 749b925802c2351ae7204e6960ca086e4c4e4fa7
change-id: 20260326-selftests-global-tags-ordering-8f324323d9c8
