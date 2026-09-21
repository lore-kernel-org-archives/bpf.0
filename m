Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF073C3F60
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981587; cv=none; b=pj4Jgpy/Xezm9fmQhtuTmhSX2m3F0FJJYGIek4QDaTJSgkYLCtAu/pAMSVlfTbndXD0Hukt6UGzgq6R4l7bwK/T1Alp0H8wdiiN8g6cGfSVxyJLMdkjKUGcEylhNYNNG1fdPPV2VMny2IOM6EZzNebzz6SOlnbh++exo7onu2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981587; c=relaxed/simple;
	bh=7qmmqVNJKHMRwPwX5G5XrnCJN78AESaJiJh6ZxodLv4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HYQ4b+M7NyMmIcaOho8DnBlvNFtL6+87Oxlq13/mJxd03yMtBBuaRbculk/F8ZJ0WIAeFjq0GmipckfJT2elgjNnGSJN0+vP7ivWLGcC6g4XbRxb9wh/vlxCxR1tvIHiZuliyYzfLRlAJWjxeqtGGUHpmg2K0xMX+ZxFc+5i4GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeXfMzsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeXfMzsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B991F00898;
	Mon, 21 Sep 2026 09:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789981586;
	bh=9Xn4oGe//ezNhuKknmae2sfbb/M4fzENJd1enbzshTQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IeXfMzsuOl9FxIdiHiQZEHCL9i6yhU6jeekgXF9vhSeNygm9ii+oj54onvZTvTX0e
	 qX0MZVlIy5IuF5i/Faf28IjIKOW6zHj+ABL5kiMcs3JZcg9biMicYtxo54U4ED3ZUc
	 n2pH4yCZZcV2uchM5m15E4scocWxsX+jpix1xtX5yy5Yz5WyQUKfoPK2ynMV/DNnBs
	 6f/9NLJaCnMMGyECwg/l9q5VoFfipeQ1/hIYR5slPWpR+zQwwm0zQZ35XINMYU+R3b
	 m+KChRzJcz0dxM3q+thGUnr1qeB29pSC+eZV21n/2/xM4uX2MvKSWEVUaUvb/JQCgM
	 T6NxwYPhDc/xQ==
Content-Type: multipart/mixed; boundary="===============7353610577065362674=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d158925eea4aefe908c98df2ef3afc65bb8f5ff522bbdeadeacd3728be864d75@mail.kernel.org>
In-Reply-To: <20260921075855.2065871-6-nickolay.lysenko@gmail.com>
References: <20260921075855.2065871-6-nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v8 5/9] selftests/bpf: generate verifier/tests.h in a regular recipe
From: bot+bpf-ci@kernel.org
To: nickolay.lysenko@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 09:06:24 +0000 (UTC)

--===============7353610577065362674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 5bcb762dc3fcf..0e23cb5067776 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -910,12 +910,12 @@ $(eval $(call DEFINE_TEST_RUNNER,test_maps))
>  # them (e.g., test.h is using completely pattern), that it's worth just
>  # explicitly defining all the rules explicitly.
>  verifier/tests.h: verifier/*.c
> -	$(shell ( cd verifier/; \
> +	$(Q)( cd verifier/; \
>  		  echo '/* Generated header, do not edit */'; \
>  		  echo '#ifdef FILL_ARRAY'; \
>  		  ls *.c 2> /dev/null | sed -e 's@\(.*\)@#include \"\1\"@'; \
>  		  echo '#endif' \
> -		) > verifier/tests.h)
> +		) > verifier/tests.h

The changelog states that "its exit status is discarded" was a defect
of the old $(shell ...) form that this patch fixes. Does the new form
actually make the exit status meaningful?

The recipe body is a subshell whose commands are chained with ';', not
'&&', and whose last command is 'echo '#endif''. A subshell exits with
the status of its last command, so the recipe's status is echo's status,
which is always 0. Concretely:

  - 'cd verifier/' failing is not fatal (';' chaining), and the
    following echos still run.

  - 'ls *.c 2> /dev/null' deliberately discards its own error output,
    and a pipeline reports only sed's status.

  - sed failing (missing/broken sed, ENOMEM, SIGPIPE) yields a header
    containing only the '/* Generated header */' line, '#ifdef FILL_ARRAY'
    and '#endif' - a valid but empty test list - and the recipe still
    reports success.

In that case make treats verifier/tests.h as successfully built,
.DELETE_ON_ERROR: does not trigger because there was no error, the file
gets an mtime newer than every verifier/*.c so it is never regenerated,
and $(OUTPUT)/test_verifier links and runs with zero verifier tests
instead of ~1000 - a silent pass rather than a build failure. The only
failure the recipe can now report is the '> verifier/tests.h' redirect
itself failing.

This is not a behavioural regression relative to the pre-patch code (the
old $(shell) form masked the same failures), but it means the exit-status
rationale in the changelog is not satisfied by the patch. Could the
commands be chained with '&&' or the recipe be prefixed with 'set -e;'?
Note the sibling recipe just above at Makefile:795-798 has the identical
';'-chained shape, so matching it might be the intent - but that recipe
ends in a command whose failure is equally invisible.

>  $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35577680350
--===============7353610577065362674==--
