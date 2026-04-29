Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A4227E1DC
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478594; cv=none; b=j0XcKF7KvCVrSBB9blQzw5Q3wyqYsZeefvNMxdMQWU1gd3eQ8RlFrCZAUwZ3k8sbzJbrqudotv2Qyf+B5qZoX7Ds1Sn8wPSJWguRN5F7GF/bj8A91ZeVTz1u2fPg5HMJB50RfipP4ELAxcuBI9asT9GpEZeK5DqMi+RUmdThTxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478594; c=relaxed/simple;
	bh=ASowbmPasczMP5dbxKPT/+SP8WynqK8x6CIcQuy1lJg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=D8JPsWUa7vtOddujdLbwFLQMSkgfjc6zxiExBiIKVdRfTGsH26qNcv8vv11qkaR3tDLoXwkJXiq0nTqQxWvbmik654GLGYbGPFbokBAAy2uQteeOxrpGN7NPMy9DxOr/Tj6BZ7SZebgT/g3eigg7eg+H5EqylTXg2uS05Cx+7uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XYe7WzH5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XYe7WzH5"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba60d78aff3so1642765066b.2
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777478590; x=1778083390; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhdj0vDqY4IK9FGeHJnEdg/Na6gGbjvcG8OkOW45Cug=;
        b=XYe7WzH5WjFuVLEr+IFvaUipKrkcQpydQeex2GHUlN6dsPLQk2e3kOOUJqZrKM/IUa
         lkwPOHdGE12Zqw9AZJ6CLRthWM+0Lxd3dPDH5rjyLY8GUjnARkVMib9mnWQEkarSlQny
         4K5S43LMiBuw5OJb/LgoDWAAJndRlLNje6F0J7VdIfFhOfvxniKQNunZ8dj9+VRPTiqa
         kA4lT7A79KSLyqmjnzWhXbQkCZoDSjT4nYPhLKkNV8V6q/wwrtgHzB51DuvQB9v160CG
         XFqKKHPCm8zmAsqNpND1Mz63M3hSoIFivL8Z1FpdU4zmk/SCdmr8Iv3YaVAZiKDOCerG
         FP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777478590; x=1778083390;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhdj0vDqY4IK9FGeHJnEdg/Na6gGbjvcG8OkOW45Cug=;
        b=A5G6SF3qoaVBfQRrcCTAKv0t9VbLsGR91/+TUdg6+BQtVTdKwxIYAXI28WTyPWmuTe
         PPYqTilRZ3KUimAY7i3f9jqUgowUW90kmhsJopUqSuJoFqsf+5sFuDdtjLnI2HaGtnh4
         Dms/bapwYWBexJlQGaY7bX+s8wYqmKhBDtrE+y04qvp+zyveTgkrE+UFbZlrApdXOpF8
         amyKmTBPv5WNm7sVhORkXGlfKne2ThaqdPLHPsDN9mmMh98Kc2XBCwJ058KoJggaeQmB
         GBhZfmwirOiGzrGWVQ8etKQtMNEQHLL1PxmHc/Kbf8/6xTYj8r6M08GJA+fZnvGK4eY5
         wrkA==
X-Gm-Message-State: AOJu0YwS3Lwh6lHORfHr/4zgIlR1/DxjeIChskk8JFS9amU25mrkFwoT
	tVyqdt6PIEqXqh694oxhn9y8kMNfV7BFHJDzgRPEPOy/CFXTqKQ/oSKWjZknu+TpIfc=
X-Gm-Gg: AeBDietDr6SogUXpmDqtstL7SHhAzhW99bVb031dlZxhpCmDinAieYB1JXS+i/uePee
	4coduE5UfLPRy+XM7JeDm6SG1pLNwStGhGvtd6eG+Rcni13KIe6PdWd0bXEzT+rs9Sw78rJl6y1
	LmJCwN5sG6jr0q6oVIheVSRUxYUh4PTp0BDaU3tYB2XDnAJqdSY9O7aTQfMXOLWX1PGnXKLmj7F
	fYfJdBVm94Ct7AbRNnXuAfTJU13Q5rvkd6xJqfM4tBAJhxCY2JWIXjilDipR0x2in+zpsikz8or
	Nq2OLtxIxK/n50Nw8owW1z5ie4Hz4WlalYJJYhC8D0gDczQMuQnUfrIgRgvTu9mPzB0p7NFDgfM
	xJZ5tMa5Gy+7ssrtBIG3eo4JD2NsRmhDwyWxP8JwhO2o5+dIaGZBYKF6HLbRfKWoskukAPQzoGO
	Up6AVOxAS7/uE+ZN+rbSYiTwU=
X-Received: by 2002:a17:907:199a:b0:bae:7a8d:2b89 with SMTP id a640c23a62f3a-bb8028bd7b2mr466986266b.17.1777478589871;
        Wed, 29 Apr 2026 09:03:09 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:2ecf:67ff:fe81:9da0])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62982136587sm1265170137.2.2026.04.29.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:03:05 -0300
Message-Id: <DI5RKLL97L0C.12X4X9HNJNDCY@suse.com>
Subject: Re: [PATCH bpf-next v9 03/11] selftests/bpf: Tolerate BPF and
 skeleton generation failures
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
 <alan.maguire@oracle.com>, <martin.lau@kernel.org>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
To: <bot+bpf-ci@kernel.org>, <rbm@suse.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <shuah@kernel.org>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260429-selftests-bpf_misconfig-v9-3-c311f06b4791@suse.com>
 <0625d99bd069ff39efd2a3077ff84b7b0e7be5c2c3129bfbb4f7fc955a6aaae4@mail.kernel.org>
In-Reply-To: <0625d99bd069ff39efd2a3077ff84b7b0e7be5c2c3129bfbb4f7fc955a6aaae4@mail.kernel.org>

On Wed Apr 29, 2026 at 12:13 PM -03, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index cc6ee7a2df93..b104c687dcf0 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>
> [ ... ]
>
>> @@ -607,47 +611,81 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:			=
	\
>>  					  $$($$<-$2-CFLAGS),$(TRUNNER_BINARY))
>>
>>  $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
>> -	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
>> -	$(Q)$$(BPFTOOL) gen object $$(<:.o=3D.linked1.o) $$<
>> -	$(Q)$$(BPFTOOL) gen object $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked1.o)
>> -	$(Q)$$(BPFTOOL) gen object $$(<:.o=3D.linked3.o) $$(<:.o=3D.linked2.o)
>> -	$(Q)diff $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked3.o)
>> -	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=3D.linked3.o) name $$(notdir $$(<=
:.bpf.o=3D)) > $$@
>> -	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=3D.linked3.o) name $$(notdir $=
$(<:.bpf.o=3D)) > $$(@:.skel.h=3D.subskel.h)
>> -	$(Q)rm -f $$(<:.o=3D.linked1.o) $$(<:.o=3D.linked2.o) $$(<:.o=3D.linke=
d3.o)
>> +	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
>> +		$$(RM) $$@ $$(@:.skel.h=3D.subskel.h);			\
>> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
>> +		exit 0;							\
>> +	fi;)								\
>> +	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' =
1>&2; \
>> +	$$(BPFTOOL) gen object $$(<:.o=3D.linked1.o) $$< &&		\
>> +	$$(BPFTOOL) gen object $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked1.o) && =
\
>> +	$$(BPFTOOL) gen object $$(<:.o=3D.linked3.o) $$(<:.o=3D.linked2.o) && =
\
>> +	diff $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked3.o) &&		\
>> +	$$(BPFTOOL) gen skeleton $$(<:.o=3D.linked3.o) name $$(notdir $$(<:.bp=
f.o=3D)) > $$@ && \
>> +	$$(BPFTOOL) gen subskeleton $$(<:.o=3D.linked3.o) name $$(notdir $$(<:=
.bpf.o=3D)) > $$(@:.skel.h=3D.subskel.h) $(if $(PERMISSIVE),|| { \
>> +		$$(RM) $$@ $$(@:.skel.h=3D.subskel.h); \
>> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
>> +	}) && \
>> +	rm -f $$(<:.o=3D.linked1.o) $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked3.o=
)
>
> Does the permissive mode error handler only apply to the final command?
>
> The TRUNNER_BPF_SKELS rule chains six commands together with &&:
>
>     $(BPFTOOL) gen object $(<:.o=3D.linked1.o) $< &&
>     $(BPFTOOL) gen object $(<:.o=3D.linked2.o) $(<:.o=3D.linked1.o) &&
>     $(BPFTOOL) gen object $(<:.o=3D.linked3.o) $(<:.o=3D.linked2.o) &&
>     diff $(<:.o=3D.linked2.o) $(<:.o=3D.linked3.o) &&
>     $(BPFTOOL) gen skeleton ... > $@ &&
>     $(BPFTOOL) gen subskeleton ... > $(@:.skel.h=3D.subskel.h) || { ... }
>
> If any of the first five commands fail, the && chain breaks and the
> recipe exits immediately with an error status, causing Make to abort the
> build. The error handler (|| { $(RM) ...; printf 'SKIP-SKEL' ...; })
> only catches failures from the final gen subskeleton command.

This is false. POSIX shell && and || have equal precedence and are
left-associative [1].

A failure of any command in the && chain causes the chain's exit status to
be non-zero, which the || handler then catches. Make recipes are invoked as
/bin/sh -c 'recipe' without -e, so the chain doesn't abort early.

Example:
  $ false && echo B && echo C || echo HANDLER
  HANDLER
  $ echo A && false && echo C || echo HANDLER
  A
  HANDLER
  $ echo A && echo B && false || echo HANDLER
  A
  B
  HANDLER

[1]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.h=
tml#tag_18_09_03

Thanks,

>
> This appears to contradict the commit message, which states the intent is
> to "continue with remaining tests" when generation fails. The same patter=
n
> affects TRUNNER_BPF_LSKELS, TRUNNER_BPF_LSKELS_SIGNED, and
> TRUNNER_BPF_SKELS_LINKED.
>
> To fully implement permissive mode, would it make sense to attach the
> error handler to the entire pipeline by wrapping the command sequence in
> a subshell?
>
>     ( cmd1 && cmd2 && ... ) || { error_handler }
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/251156=
89001

